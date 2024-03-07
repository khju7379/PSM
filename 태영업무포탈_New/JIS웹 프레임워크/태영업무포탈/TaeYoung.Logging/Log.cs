using System;
using System.Diagnostics;
using System.Reflection;
using System.Text;
using TaeYoung.Logging.HttpModule.Logger;

namespace TaeYoung.Logging
{
    public static class Log
    {
        #region _logger - CommonLogger 전역변수입니다.
        /// <summary>
        /// CommonLogger 전역변수입니다.
        /// </summary>
        private static CommonLogger _logger = null;
        #endregion

        #region UserIP - 사용자 IP를 리턴한다.
        /// <summary>
        /// 사용자 IP를 리턴한다.
        /// </summary>
        private static string UserIP
        {
            get
            {
                return "";// System.Net.Dns.GetHostAddresses(System.Net.Dns.GetHostName()).GetValue(0).ToString();
            }
        }
        #endregion

        #region UserID - 사용자 ID를 리턴한다.
        /// <summary>
        /// 사용자 ID를 리턴한다. 
        /// </summary>
        private static string UserID
        {
            get
            {
                return "WBT"; // 를 넣어주셔
            }
        }
        #endregion

        ///////////////////////////////////////////////////////////////////////
        // 6. Loging Method
        ///////////////////////////////////////////////////////////////////////
        #region LogStart - Exception Log를 시작합니다.
        /// <summary>
        /// Exception Log를 시작합니다. 
        /// </summary>
        public static void LogStart()
        {
            _logger = new CommonLogger(UserIP, UserID);
        }
        /// <summary>
        /// Exception Log를 시작합니다. 
        /// </summary>
        /// <param name="userID">프로그램ID</param>
        public static void LogStart(string userID)
        {
            _logger = new CommonLogger(UserIP, userID);
        }
        #endregion

        #region LogEnd - Log 객체를 해제합니다.
        /// <summary>
        /// Log 객체를 해제합니다.
        /// </summary>
        public static void LogEnd()
        {
            if (_logger != null)
            {
                _logger.RequestURL = GetReqeustUrl();
                _logger.LogEnd();
                _logger = null;
            }
        }
        #endregion

        #region LogException - Exception Log를 저장합니다.
        /// <summary>
        /// Exception Log를 저장합니다. 
        /// </summary>
        /// <param name="ex">Exception</param>
        public static void LogException(Exception ex)
        {
            if (_logger != null)
            {
                _logger.RequestURL = GetReqeustUrl();
                _logger.LogException(ex);
            }
        }
        #endregion

        #region GetReqeustUrl - Request Url을 반환합니다.
        /// <summary>
        /// Request Url을 반환합니다.
        /// </summary>
        /// <returns></returns>
        private static string GetReqeustUrl()
        {
            string strUrl = string.Empty;
            try
            {
                strUrl = "WBT";
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
        private static string GetMethodName()
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
        private static void ExceptionMessage(string mainCode, string msgID, Exception ex, string[] messages)
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
    }
}
