using System;
using System.Data;
using JINI.Base;
using JINI.Data;
using JINI.Data.Transactions;

namespace TaeYoung.Biz.Common
{
    /// <summary>
    /// 오류 예외처리에 대한 비지니스 로직
    /// 해당 클래스는 오류 예외처리만 사용됩니다.
    /// </summary>
    public class ExceptionLogBiz : BizBase
    {
        #region InsertLog - Log를 Insert 한다.
        /// <summary>
        /// 로그를 입력합니다.
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
        /// <returns></returns>
        [Transaction(TransactionOption.Required)]
        public void InsertLog(string logType, string bizType, DateTime occurTime, string formId, string message,
            string messageDetail, string userIP, string userID, DateTime exeTime)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                //logDac.ExceptionLog_Insert(logType, bizType, occurTime, formId, message, messageDetail, userIP, userID, exeTime, Environment.MachineName);
                dac.AddParameters("P_LOG_TYPE", DbType.String, logType);
                dac.AddParameters("P_Biz_Type", DbType.String, bizType);
                dac.AddParameters("P_OCCUR_TIME", DbType.DateTime, occurTime);
                dac.AddParameters("P_FORM_ID", DbType.String, formId);
                dac.AddParameters("P_MESSAGE", DbType.String, message);
                dac.AddParameters("P_MESSAGE_DETAIL", DbType.String, messageDetail);
                dac.AddParameters("P_USER_IP", DbType.String, userIP);
                dac.AddParameters("P_USER_ID", DbType.String, userID);
                dac.AddParameters("P_EXECUTION_TIME", DbType.DateTime, exeTime);
                dac.AddParameters("P_MACHINE_NAME", DbType.String, Environment.MachineName);

                dac.ExcuteNonQuery("CMN_LOG_ADD");

            }
        }
        #endregion
    }
}
