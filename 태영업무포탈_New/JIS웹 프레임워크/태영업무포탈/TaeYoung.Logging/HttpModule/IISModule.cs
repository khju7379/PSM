using System;
using System.Diagnostics;
using System.Reflection;
using System.Text;
using System.Web;
using TaeYoung.Biz.Type;
using TaeYoung.Logging.HttpModule.Logger;
using JINI.User;
using System.Data;
using System.Xml;

namespace TaeYoung.Logging.HttpModule
{
    /// <summary>
    /// IIS 호출시 이벤트 발생 처리
    /// 1. 로그처리
    /// 2. ProgressBar 처리
    /// </summary>
    public class IISModule : IHttpModule
    {
        #region _logger - CommonLogger 전역변수입니다.
        /// <summary>
        /// CommonLogger 전역변수입니다.
        /// </summary>
        protected CommonLogger _logger = null;
        #endregion

        #region UserIP - 사용자 IP를 리턴한다.
        /// <summary>
        /// 사용자 IP를 리턴한다.
        /// </summary>
        public string UserIP
        {
            get
            {
                return HttpContext.Current.Request.UserHostAddress;
            }
        }
        #endregion

        #region UserID - 사용자 ID를 리턴한다.
        /// <summary>
        /// 사용자 ID를 리턴한다. 
        /// </summary>
        public string UserID
        {
            get
            {
                return (HttpContext.Current.Session == null || HttpContext.Current.Session["UserInfo"] == null) ? "" : ((UserInfo)HttpContext.Current.Session["UserInfo"]).LoginID;
            }
        }
        #endregion

        #region Init - 모듈을 초기화한다.
        /// <summary>
        /// 모듈을 초기화한다.
        /// </summary>
        /// <param name="app"></param>
        public void Init(HttpApplication app)
        {
            // 파이프라인 이벤트에 등록합니다.
            app.BeginRequest += new EventHandler(this.Application_BeginRequest);
            //app.AcquireRequestState += new EventHandler(app_AcquireRequestState);
            app.EndRequest += new EventHandler(this.Application_EndRequest);
            app.Error += new EventHandler(this.Application_ErrorRequest);
        }
        #endregion

        #region Application_BeginRequest - 시작처리
        /// <summary>
        /// 시작처리
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        private void Application_BeginRequest(Object source, EventArgs e)
        {
            if (isProg)
            {
                // 로그 시작
                LogStart();
            }
        } 
        #endregion

        void app_AcquireRequestState(object sender, EventArgs e)
        {
            // 로그 시작
            //LogStart();
        } 

        #region Application_ErrorRequest - 오류발생시
        /// <summary>
        /// 오류발생시
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        private void Application_ErrorRequest(Object source, EventArgs e)
        {
            if (isProg)
            {
                try // 로그생성시 오류 발생은 무시한다(순환오류 예외처리)
                {
                    Exception ex = HttpContext.Current.Server.GetLastError().GetBaseException();

                    // 두 오류는 무시
                    if (ex.Message.StartsWith("HTTP 헤더를 보낸 후에는") || ex.Message.StartsWith("원격 호스트에서 연결을 닫았습니다."))
                    {
                    }
                    else
                    {
                        // 로그정보를 DB에 저장
                        LogException(ex);
                        // 오류페이지 구현시 아래서 정의
                    }
                }
                finally
                {
                }
            }
        } 
        #endregion

        #region Application_EndRequest - 완료처리
        /// <summary>
        /// 완료처리
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        private void Application_EndRequest(Object source, EventArgs e)
        {
            if (isProg)
            {
                // 로그 완료
                LogEnd();
            }
        } 
        #endregion

        #region Dispose - 자원해재
        /// <summary>
        /// 자원해재
        /// </summary>
        public void Dispose()
        {

        } 
        #endregion

        ///////////////////////////////////////////////////////////////////////
        // 6. Loging Method
        ///////////////////////////////////////////////////////////////////////
        #region LogStart - Exception Log를 시작합니다.
        /// <summary>
        /// Exception Log를 시작합니다. 
        /// </summary>
        protected void LogStart()
        {
            this._logger = new CommonLogger(this.UserIP, this.UserID);
        }
        #endregion

        #region LogEnd - Log 객체를 해제합니다.
        /// <summary>
        /// Log 객체를 해제합니다.
        /// </summary>
        protected void LogEnd()
        {
            if (this._logger != null)
            {
                this._logger.RequestURL = GetReqeustUrl();
                this._logger.LogEnd();
                this._logger = null;
            }
        }
        #endregion

        #region LogException - Exception Log를 저장합니다.
        /// <summary>
        /// Exception Log를 저장합니다. 
        /// </summary>
        /// <param name="ex">Exception</param>
        protected void LogException(Exception ex)
        {
            if (this._logger != null)
            {
                this._logger.RequestURL = GetReqeustUrl();
                this._logger.LogException(ex);
            }
        }
        #endregion

        #region GetReqeustUrl - Request Url을 반환합니다.
        /// <summary>
        /// Request Url을 반환합니다.
        /// </summary>
        /// <returns></returns>
        private string GetReqeustUrl()
        {
            string strUrl = string.Empty;
            try
            {
                strUrl = HttpContext.Current.Request.Url.AbsoluteUri;
            }
            catch //(Exception ex)
            {
                ;
            }
            return strUrl;
        }
        #endregion

        #region GetMethodName - 메서드 명을 가지고 옵니다.
        /// <summary>
        /// 메서드 명을 가지고 옵니다. 
        /// </summary>
        /// <returns></returns>
        public string GetMethodName()
        {
            StackFrame stackFrame = new StackFrame(9, false);
            string msg = string.Empty;
            MethodBase methodBase = stackFrame.GetMethod();
            msg += methodBase.DeclaringType.FullName + "->";
            msg += methodBase.Name + "()";
            return msg;
        }
        #endregion

        #region ExceptionMessage - Exception 메시지의 Display
        /// <summary>
        /// Exception 메시지의 Display
        /// </summary>
        /// <param name="mainCode"></param>
        /// <param name="msgID"></param>
        /// <param name="ex"></param>
        /// <param name="messages"></param>
        public void ExceptionMessage(string mainCode, string msgID, Exception ex, string[] messages)
        {
            bool bCustom = false;

            // Biz에서 의도적인 Exception 전달 시 
            if (ex.Message != null && ex.Message.Length == 4)
            {
                msgID += "|" + ex.Message;
            }
            // ex.Mesage가 "0004|컬럼은|삭제" 형태인 경우 처리
            else if (ex.Message != null && ex.Message.Length > 4 && ex.Message[4].ToString() == "|")
            {
                msgID += "|" + ex.Message.Substring(0, 4);
                bCustom = true;
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("var msgArray = new Array();");
            if (bCustom == false)
            {
                if (messages != null && messages.Length != 0)
                {
                    for (int i = 0; i < messages.Length; i++)
                    {
                        sb.Append("msgArray[" + i.ToString() + "] = '" + messages[i] + "';");
                    }
                }
            }
            else
            {
                string[] tempMsg = ex.Message.Split('|');
                // 0번째 항목은 메시지 아이디다.!!
                for (int i = 1; i < tempMsg.Length; i++)
                {
                    sb.Append("msgArray[" + Convert.ToString(i - 1) + "] = '" + tempMsg[i] + "';");
                }
            }

            sb.Append(@"fn_ShowErrorMessage('{0}','{1}','{2}','{3}',msgArray);");
            string strStackTrace = ex.Message + " " + ex.StackTrace;
            strStackTrace = strStackTrace.Replace("'", "").Replace("\"", "").Replace("\r\n", "|").Replace("\\", "/");
            string strScript = string.Format(sb.ToString(), mainCode, msgID, "03", strStackTrace);

            //this.Page.ClientScript.RegisterClientScriptBlock(this.Page.GetType(), Guid.NewGuid().ToString(), strScript, true);
        }
        #endregion

        #region LTPAToken - 현재 LTPAToken입니다.
        /// <summary>
        /// 현재 LTPAToken입니다.
        /// </summary>
        private string LTPAToken
        {
            get
            {
                System.Text.Encoding en = System.Text.Encoding.GetEncoding("EUC-KR");
                string rtnValue = string.Empty;

                if (HttpContext.Current.Request.UserHostAddress == "::1" || HttpContext.Current.Request.UserHostAddress == "127.0.0.1") // 로컬일시 테스트
                {
                    //rtnValue = "Admin";
                    rtnValue = "devLocal";
                }
                else if (HttpContext.Current.Request.Cookies["LOGIN_ID"] != null)
                {
                    rtnValue = HttpContext.Current.Request.Cookies["LOGIN_ID"].Value;
                }
                // 테스트를 위하여 강제지정
                else
                {
                    //rtnValue = "";
                    //throw new Exception("사용자가 로그인하지 못했습니다.");
                    rtnValue = "nologin";
                }

                // 임시 계정 설정
                //rtnValue = "dev1";

                return rtnValue;
            }
        }
        #endregion

        #region GetMiddleString - 문자열 사이의 내용을 추출한다
        /// <summary>
        /// 문자열 사이의 내용을 추출한다
        /// </summary>
        /// <param name="str">원본 문자열</param>
        /// <param name="begin">시작값</param>
        /// <param name="end">마지막값</param>
        /// <returns></returns>
        private string GetMiddleString(string str, string begin, string end)
        {
            if (string.IsNullOrEmpty(str))
            {
                return null;
            }

            string result = null;
            if (str.IndexOf(begin) > -1)
            {
                str = str.Substring(str.IndexOf(begin) + begin.Length);
                if (str.IndexOf(end) > -1) result = str.Substring(0, str.IndexOf(end));
                else result = str;
            }
            return result;
        }
        #endregion

        private bool isProg
        {
            get
            {
                if (HttpContext.Current.Request.RawUrl.ToLower().IndexOf("aspx") > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }
    }
}
