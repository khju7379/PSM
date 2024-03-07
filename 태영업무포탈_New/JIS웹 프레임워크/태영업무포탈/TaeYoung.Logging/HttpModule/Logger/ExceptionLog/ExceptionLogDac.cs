using System;
using System.Data;
using JINI.Base;
using JINI.Data;

namespace TaeYoung.Logging.HttpModule.Logger.ExceptionLog
{
    /// <summary>
    /// 오류 예외처리에 대한 데이터 엑세스 로직
    /// 해당 클래스는 오류 예외처리만 사용됩니다.
    /// </summary>
    class ExceptionLogDac : DacBase
    {
        public ExceptionLogDac()
        {
            string LogDataBase = JINI.Base.Configuration.FxConfigManager.GetString("LogDataBase");
            this.ConnectionStrings = LogDataBase;
        }

        #region ExceptionLog_Insert - 오류내역을 DB로 전송
        /// <summary>
        /// 오류내역을 DB로 전송
        /// </summary>
        /// <param name="logType">로그구분</param>
        /// <param name="bizType">업무구분</param>
        /// <param name="occurTime">발생시간</param>
        /// <param name="formId">폼아이디</param>
        /// <param name="message">메시지</param>
        /// <param name="messageDetail">메시지 상세</param>
        /// <param name="userIP">IP</param>
        /// <param name="userID">ID</param>
        /// <param name="exeTime">실행시간</param>
        /// <param name="machineName">컴퓨터명</param>
        /// <returns></returns>
        public void ExceptionLog_Insert(string logType, string bizType, DateTime occurTime, string formId, string message,
            string messageDetail, string userIP, string userID, DateTime exeTime, string machineName)
        {
            using (DacConnecter dbCon = new DacConnecter(this.ConnectionStrings))
            {
                dbCon.AddParameters("P_LOG_TYPE", DbType.String, logType);
                dbCon.AddParameters("P_Biz_Type", DbType.String, bizType);
                dbCon.AddParameters("P_OCCUR_TIME", DbType.String, occurTime.ToString("yyyy-MM-dd hh:mm:ss"));
                dbCon.AddParameters("P_FORM_ID", DbType.String, formId);
                dbCon.AddParameters("P_MESSAGE", DbType.String, message);
                dbCon.AddParameters("P_MESSAGE_DETAIL", DbType.String, messageDetail);
                dbCon.AddParameters("P_USER_IP", DbType.String, userIP);
                dbCon.AddParameters("P_USER_ID", DbType.String, userID);
                dbCon.AddParameters("P_EXECUTION_TIME", DbType.String, exeTime.ToString("yyyy-MM-dd hh:mm:ss"));
                dbCon.AddParameters("P_MACHINE_NAME", DbType.String, machineName);

                dbCon.ExcuteNonQuery("NVHTLIB.PTCMMBAS60I1");
            }
        }
        #endregion

    }
}
