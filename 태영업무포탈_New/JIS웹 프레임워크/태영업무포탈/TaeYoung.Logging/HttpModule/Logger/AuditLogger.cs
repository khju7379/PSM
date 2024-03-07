using System;
using TaeYoung.Biz.Common;

namespace TaeYoung.Logging.HttpModule.Logger
{
    /// <summary>
    /// Audit 정보를 기록하는 클래스 입니다. 
    /// </summary>
    public class AuditLogger : IDisposable
    {
        /// <summary>
        /// RequestUrl
        /// </summary>
        public string RequestUrl = string.Empty;

        /// <summary>
        /// Audit 정보를 기록한다. 
        /// </summary>
        /// <param name="occurTime">발생시간</param>
        /// <param name="bizType">업무구분</param>
        /// <param name="formId">namespace + class + method 명</param>
        /// <param name="userIp">사용자 IP</param>
        /// <param name="userId">사용자 ID</param>
        public void LogAudit(DateTime occurTime, string bizType, string formId, string userIp, string userId)
        {
            string strLogType = LogType.Audit;
            string message = userId + ": " + formId + "를 호출했습니다.";
            using (ExceptionLogBiz biz = new ExceptionLogBiz())
            {
                biz.InsertLog(strLogType, bizType, occurTime, formId, message, this.RequestUrl, userIp, userId, DateTime.Now);
            }
        }

        // IDisposable 

        /// <summary>
        /// 해제자
        /// </summary>
        public void Dispose()
        {
            ;
        }
    }
}

