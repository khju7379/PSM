using System;
using System.Diagnostics;
using System.Reflection;
using TaeYoung.Biz.Common;
using JINI.Base.Configuration;

namespace TaeYoung.Logging.HttpModule.Logger
{
    /// <summary>
    /// Method별 로그를 남기는 클래스입니다.
    /// </summary>
    public class CommonLogger
    {
        // 사용자 IP
        private string clientIP = string.Empty;
        // 사용자 ID
        private string clientID = string.Empty;
        // 시작시간
        private DateTime dtStart = DateTime.Now;
        // 종료시간
        private DateTime dtEnd = DateTime.Now;
        // Form ID (namespace + class + method)
        //private string formId = string.Empty;
        // Request Url
        private string requestUrl = string.Empty;

        /// <summary>
        /// Request URL 세팅
        /// </summary>
        public string RequestURL
        {
            set
            {
                this.requestUrl = value;
            }
        }

        #region CommonLogger - .Ctor()
        /// <summary>
        /// 생성자 
        /// </summary>
        /// <param name="cip">clientIP</param>
        /// <param name="cid">clientID</param>
        /*
            asp.net Page의 경우 strClientIP = Request.UserHostAddress;
            web service의  경우 Context.Request.ServerVariables ["REMOTE_ADDR"]
        */
        public CommonLogger(string cip, string cid)
        {
            this.clientIP = cip;
            this.clientID = cid;
            this.dtStart = DateTime.Now;
        } 
        #endregion

        #region LogCustom - Custom Log를 기록합니다.
        /// <summary>
        /// Custom Log를 기록합니다.
        /// </summary>
        /// <param name="message">메시지</param>
        /// <param name="messageDetail">메시지상세</param>
        /// <param name="throwEx">Exception발생 시 다시 Throw할것인지 여부</param>
        public static void LogCustom(string message, string messageDetail, bool throwEx)
        {
            try
            {
                // Log
                using (ExceptionLogBiz biz = new ExceptionLogBiz())
                {
                    biz.InsertLog(LogType.Custom, LogType.Custom.ToString(), DateTime.Now,
                        GetMethodName(),
                        message, messageDetail, "", "", DateTime.Now);
                }
            }
            catch (Exception ex)
            {
                if (throwEx)
                {
                    throw ex;
                }
            }
        } 
        /// <summary>
        /// Custom Log를 기록합니다.
        /// </summary>
        /// <param name="message"></param>
        /// <param name="messageDetail"></param>
        /// <param name="formId"></param>
        /// <param name="throwEx"></param>
        public void LogCustom(string message, string messageDetail, string formId, bool throwEx)
        {
            try
            {
                using (ExceptionLogBiz biz = new ExceptionLogBiz())
                {
                    biz.InsertLog(LogType.Custom, LogType.Custom.ToString(), DateTime.Now,
                        formId,
                        message, messageDetail, this.clientIP, this.clientID, DateTime.Now);
                }
            }
            catch (Exception ex)
            {
                if (throwEx)
                {
                    throw ex;
                }
            }
        }
        #endregion

        #region GetMethodName - 메서드 명을 가지고 온다.
        /// <summary>
        /// 메서드 명을 가지고 온다. 
        /// </summary>
        /// <returns></returns>
        public static string GetMethodName()
        {
            StackFrame stackFrame = new StackFrame(2, false);
            string msg = string.Empty;
            MethodBase methodBase = stackFrame.GetMethod();
            msg += methodBase.DeclaringType.FullName + "->";
            msg += methodBase.Name + "()";
            return msg;
        } 
        #endregion

        #region LogException - Exception 정보를 기록합니다. (+ 4)
        /// <summary>
        /// Exception 정보를 기록합니다. 
        /// </summary>
        /// <param name="ex">Exception </param>
        public void LogException(Exception ex)
        {
            DateTime startTime = this.dtStart;
            // Exception Log를 남길지 여부를 결정합니다. 
            using (ErrorLogger logger = new ErrorLogger())
            {
                // Request URL 남기기
                if (!string.IsNullOrEmpty(this.requestUrl))
                {
                    logger.RequestUrl = this.requestUrl;
                }

                logger.LogException(startTime, LogType.Exception.ToString(), this.requestUrl, this.clientIP, this.clientID, ex);
            }
        }

        /// <summary>
        /// Exception 정보를 기록합니다. 
        /// </summary>
        /// <param name="ex">Exception </param>
        /// <param name="isWebSerivce">WebService 여부</param>
        public void LogException(Exception ex, bool isWebSerivce)
        {
            DateTime startTime = this.dtStart;
            // Exception Log를 남길지 여부를 결정합니다. 

            using (ErrorLogger logger = new ErrorLogger())
            {
                // Request URL 남기기
                if (!string.IsNullOrEmpty(this.requestUrl))
                {
                    logger.RequestUrl = this.requestUrl;
                }

                logger.LogException(startTime, LogType.Exception.ToString(), this.requestUrl, this.clientIP, this.clientID, ex);
            }

            // 웹-서비스인 경우 Exception을 다시 던진다. 
            if (isWebSerivce)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Exception 정보를 기록합니다. 
        /// </summary>
        /// <param name="ex"></param>
        /// <param name="isWebSerivce"></param>
        /// <param name="customMessage"></param>
        public void LogException(Exception ex, bool isWebSerivce, string customMessage)
        {
            DateTime startTime = this.dtStart;
            // Exception Log를 남길지 여부를 결정합니다. 
            using (ErrorLogger logger = new ErrorLogger())
            {
                // Request URL 남기기
                if (!string.IsNullOrEmpty(this.requestUrl))
                {
                    logger.RequestUrl = this.requestUrl;
                }
                logger.LogException(startTime, LogType.Exception.ToString(), this.requestUrl, this.clientIP, this.clientID, ex, customMessage);
            }

            // 웹-서비스인 경우 Exception을 다시 던진다. 
            if (isWebSerivce)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Exception 객체를 두개 받아서 첫 번째 ex가 "0004"형식인 경우 첫 번째 Exception을 
        /// throw 하고 아닌 경우 ex2를 throw 한다. 
        /// </summary>
        /// <param name="ex"></param>
        /// <param name="ex2"></param>
        public void LogException(Exception ex, Exception ex2)
        {
            DateTime startTime = this.dtStart;
            using (ErrorLogger logger = new ErrorLogger())
            {
                // Request URL 남기기
                if (!string.IsNullOrEmpty(this.requestUrl))
                {
                    logger.RequestUrl = this.requestUrl;
                }

                logger.LogException(startTime, LogType.Exception.ToString(), this.requestUrl, this.clientIP, this.clientID, ex);
            }

            bool blogFirst = false;
            // 네자리인 경우, "|"를 포함하고, 첫 번째 자리가 4자리인 경우
            if (ex.Message.Split('|')[0].Length == 4)
            {
                blogFirst = true;
            }

            if (blogFirst)
            {
                throw ex;
            }
            else
            {
                throw ex2;
            }
        }
        #endregion

        #region LogEnd - TimeStamp와 Audit정보를 기록합니다.
        /// <summary>
        /// TimeStamp와 Audit정보를 기록합니다. 
        /// </summary>
        public void LogEnd()
        {
            dtEnd = DateTime.Now;
            DateTime startTime = this.dtStart;
            TimeSpan ts = dtEnd - dtStart;
            double exeTime = ts.TotalSeconds * 1000;
            exeTime = Math.Ceiling(exeTime);
            // Audit Log를 남길지 여부를 결정합니다. 
            string strAuditLog = string.Empty;
            try
            {
                strAuditLog = FxConfigManager.GetString("AuditLog"); // AduitLog 여부
            }
            catch (Exception ex)
            {
                throw ex;
            }

            if (strAuditLog == "true")
            {
                using (AuditLogger logger = new AuditLogger())
                {
                    // Request URL 남기기
                    if (!string.IsNullOrEmpty(this.requestUrl))
                    {
                        logger.RequestUrl = this.requestUrl;
                    }
                    logger.LogAudit(startTime, LogType.Audit.ToString(), this.requestUrl, this.clientIP, this.clientID);
                }
            }

            // TimeStamp를 남길지 여부를 결정합니다.(남길지 여부와 최소실행시간명시) 
            string strTimeLog = string.Empty;
            double MinLogTime = 0;
            try
            {
                MinLogTime = FxConfigManager.GetDouble("TimeStamp");// 실행시간 1/1000 초 이상시 발생 
            }
            catch (Exception ex)
            {
                throw ex;
            }

            // 로그 여부가 true이고 실행시간이 web.config에 설정된 최소값 보다 클 때 저장한다. 
            if (exeTime >= MinLogTime)
            {
                using (TimeStamp timestamp = new TimeStamp())
                {
                    // Request URL 남기기
                    if (!string.IsNullOrEmpty(this.requestUrl))
                    {
                        timestamp.RequestUrl = this.requestUrl;
                    }
                    timestamp.LogTime(startTime, LogType.Time.ToString(), this.requestUrl, exeTime.ToString(), this.clientIP, this.clientID, this.dtEnd);
                }
            }
        } 
        #endregion
    }
}
