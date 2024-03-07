using System;
using TaeYoung.Biz.Common;

namespace TaeYoung.Logging.HttpModule.Logger
{
    /// <summary>
    /// 메서드별 실행시간을 기록하는 클래스 입니다. 
    /// </summary>
    public class TimeStamp : IDisposable
    {
        /// <summary>
        /// Request Url
        /// </summary>
        public string RequestUrl = string.Empty;
        /// <summary>
        /// 로그정보를 기록합니다. 
        /// </summary>
        /// <param name="occurTime">발생시간</param>
        /// <param name="bizType">업무구분</param>
        /// <param name="formId">ns + class + method</param>
        /// <param name="userIp">IP</param>
        /// <param name="userId">Uid</param>
        /// <param name="exeTime">실행시간(초)</param>
        public void LogTime(DateTime occurTime, string bizType, string formId, string message, string userIp, string userId, DateTime exeTime)
        {
            string strLogType = LogType.Time;

            TimeSpan ts = exeTime - occurTime;
            double t = ts.TotalSeconds * 1000;
            t = Math.Ceiling(t);

            // Log
            using (ExceptionLogBiz biz = new ExceptionLogBiz())
            {
                biz.InsertLog(strLogType, bizType, occurTime, formId.Replace("/InvokeServiceTable", ""), message, "<<RequestUrl>>" + this.RequestUrl + " <<Time>>" + t.ToString(), userIp, userId, exeTime);
            }
        }

        /// <summary>
        /// 객체를 해제합니다.
        /// </summary>
        public void Dispose()
        {
            ;
        }
    }
}

