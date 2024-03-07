using System;
using System.Collections;
using System.Data;
using JINI.Base;
using JINI.Data;
using JINI.Data.Transactions;

namespace TaeYoung.Biz.Common
{
    /// <summary>
    /// 로깅처리 비지니스로직 (로그인로그, 페이지이동 로그)
    /// </summary>
    public class LoggingBiz : BizBase
    {
        #region AddLogging - 접속로그 입력
        /// <summary>
        /// 접속로그 입력
        /// </summary>
        [Transaction(TransactionOption.Required)]
        public void AddLogging(string LOG_TYPE, string BIZ_TYPE, DateTime OCCUR_TIME, string FORM_ID, string USER_IP, string USER_ID, string MACHINE_NAME)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_LOG_TYPE", DbType.String, LOG_TYPE);
                dac.AddParameters("P_BIZ_TYPE", DbType.String, BIZ_TYPE);
                //dac.AddParameters("P_OCCUR_TIME", DbType.DateTime, OCCUR_TIME);
                dac.AddParameters("P_OCCUR_TIME", DbType.DateTime, OCCUR_TIME.ToString("yyyy-MM-dd HH:mm:ss"));
                dac.AddParameters("P_FORM_ID", DbType.String, FORM_ID);
                dac.AddParameters("P_USER_IP", DbType.String, USER_IP);
                dac.AddParameters("P_USER_ID", DbType.String, USER_ID);
                dac.AddParameters("P_MACHINE_NAME", DbType.String, MACHINE_NAME);
                dac.ExcuteNonQuery("CMN_CONNLOG_ADD");
            }
        }
        #endregion

        #region GetLoggingTable - 로깅 저장 테이블명 조회
        /// <summary>
        /// 로깅 저장 테이블명 조회
        /// </summary>
        [Transaction(TransactionOption.Required)]
        public DataSet GetLoggingTable()
        {
            using (DacConnecter dac = new DacConnecter("Logging"))
            {
                return dac.ExcuteDataSet("SP_LOGGING_TABLE_SELECT");
            }
        }
        #endregion

        #region GetLogging - 접속로그 조회
        /// <summary>
        /// 접속로그 조회
        /// </summary>
        /// <returns></returns>
        [Transaction(TransactionOption.Disabled)]
        public static DataSet GetLogging(Hashtable ht)
        {
            using (DacConnecter dbCon = new DacConnecter("Logging"))
            {
                // 보안상 SearchCondition은 Biz에서 조합한다.
                string searchCondition = string.Empty;
                if (ht["LogType"].ToString() != "0")
                {
                    searchCondition += "AND A.BIZ_TYPE='" + ht["LogType"].ToString() + "'";
                }
                if (!string.IsNullOrEmpty(ht["LogDate"].ToString()))
                {
                    searchCondition += " AND CONVERT(NVARCHAR,A.OCCUR_TIME,112) = '" + ht["LogDate"].ToString() + "'";
                }
                if (!string.IsNullOrEmpty(ht["LogSearch"].ToString()))
                {
                    searchCondition += " AND (A.USER_IP LIKE '" + ht["LogSearch"].ToString() + "%' OR A.USER_ID LIKE '" + ht["LogSearch"].ToString() + "%' OR B.DISPLAYNAME LIKE '" + ht["LogSearch"].ToString() + "%')";
                }
                if (!string.IsNullOrEmpty(ht["Company"].ToString()))
                {
                    searchCondition += " AND B.COMPANYCODE = '" + ht["Company"].ToString() + "'";
                }

                dbCon.AddParameters("@CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("@PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("@SEARCHCONDITION", DbType.String, searchCondition);
                dbCon.AddParameters("@DATE", DbType.String, ht["Date"]);

                return dbCon.ExcuteDataSet("SP_CONNECTION_LOG_LIST");
            }
        }
        #endregion

        #region GetLoggingUser - 접속로그 조회(사용자별)
        /// <summary>
        /// 접속로그 조회(사용자별)
        /// </summary>
        /// <returns></returns>
        [Transaction(TransactionOption.Disabled)]
        public static DataSet GetLoggingUser(Hashtable ht)
        {
            using (DacConnecter dbCon = new DacConnecter("Logging"))
            {
                // 보안상 SearchCondition은 Biz에서 조합한다.
                string searchCondition = string.Empty;

                if (!string.IsNullOrEmpty(ht["LogDate"].ToString()))
                {
                    searchCondition += " AND CONVERT(NVARCHAR,A.OCCUR_TIME,112) = '" + ht["LogDate"].ToString() + "'";
                }
                if (!string.IsNullOrEmpty(ht["Company"].ToString()))
                {
                    searchCondition += " AND B.COMPANYCODE = '" + ht["Company"].ToString() + "'";
                }

                dbCon.AddParameters("@CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("@PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("@SEARCHCONDITION", DbType.String, searchCondition);
                dbCon.AddParameters("@DATE", DbType.String, ht["Date"]);

                return dbCon.ExcuteDataSet("SP_CONNECTION_LOG_LIST_USER");
            }
        }
        #endregion

        #region GetLoggingProgram - 접속로그 조회(프로그램별)
        /// <summary>
        /// 접속로그 조회(프로그램별)
        /// </summary>
        /// <returns></returns>
        [Transaction(TransactionOption.Disabled)]
        public static DataSet GetLoggingProgram(Hashtable ht)
        {
            using (DacConnecter dbCon = new DacConnecter("Logging"))
            {
                // 보안상 SearchCondition은 Biz에서 조합한다.
                string searchCondition = string.Empty;
                if (ht["Dept"] != null && !string.IsNullOrEmpty(ht["Dept"].ToString()))
                {
                    searchCondition += "AND D.DEPTCODE='" + ht["Dept"].ToString() + "'";
                }
                else if (ht["User"] != null && !string.IsNullOrEmpty(ht["User"].ToString()))
                {
                    searchCondition += "AND C.EMPID='" + ht["User"].ToString() + "'";
                }
                if (!string.IsNullOrEmpty(ht["LogDate"].ToString()))
                {
                    searchCondition += " AND CONVERT(NVARCHAR,A.OCCUR_TIME,112) = '" + ht["LogDate"].ToString() + "'";
                }
                if (!string.IsNullOrEmpty(ht["Company"].ToString()))
                {
                    searchCondition += " AND B.COMPANYCODE = '" + ht["Company"].ToString() + "'";
                }

                dbCon.AddParameters("@CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("@PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("@SEARCHCONDITION", DbType.String, searchCondition);
                dbCon.AddParameters("@DATE", DbType.String, ht["Date"]);

                return dbCon.ExcuteDataSet("SP_CONNECTION_LOG_LIST_PROGRAM");
            }
        }
        #endregion

        #region GetLoggingDept - 접속로그 조회(부서별)
        /// <summary>
        /// 접속로그 조회(부서별)
        /// </summary>
        /// <returns></returns>
        [Transaction(TransactionOption.Disabled)]
        public static DataSet GetLoggingDept(Hashtable ht)
        {
            using (DacConnecter dbCon = new DacConnecter("Logging"))
            {
                // 보안상 SearchCondition은 Biz에서 조합한다.
                string searchCondition = string.Empty;

                if (!string.IsNullOrEmpty(ht["LogDate"].ToString()))
                {
                    searchCondition += " AND CONVERT(NVARCHAR,A.OCCUR_TIME,112) = '" + ht["LogDate"].ToString() + "'";
                }
                if (!string.IsNullOrEmpty(ht["Company"].ToString()))
                {
                    searchCondition += " AND B.COMPANYCODE = '" + ht["Company"].ToString() + "'";
                }

                dbCon.AddParameters("@CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("@PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("@SEARCHCONDITION", DbType.String, searchCondition);
                dbCon.AddParameters("@DATE", DbType.String, ht["Date"]);

                return dbCon.ExcuteDataSet("SP_CONNECTION_LOG_LIST_DEPT");
            }
        }
        #endregion

        #region GetLoggingComp - 접속로그 조회(업체별)
        /// <summary>
        /// 접속로그 조회(업체별)
        /// </summary>
        /// <returns></returns>
        [Transaction(TransactionOption.Disabled)]
        public static DataSet GetLoggingComp(Hashtable ht)
        {
            using (DacConnecter dbCon = new DacConnecter("Logging"))
            {
                // 보안상 SearchCondition은 Biz에서 조합한다.
                string searchCondition = string.Empty;

                if (!string.IsNullOrEmpty(ht["LogDate"].ToString()))
                {
                    searchCondition += " AND CONVERT(NVARCHAR,A.OCCUR_TIME,112) = '" + ht["LogDate"].ToString() + "'";
                }
                if (!string.IsNullOrEmpty(ht["Company"].ToString()))
                {
                    searchCondition += " AND B.COMPANYCODE = '" + ht["Company"].ToString() + "'";
                }

                dbCon.AddParameters("@CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("@PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("@SEARCHCONDITION", DbType.String, searchCondition);
                dbCon.AddParameters("@DATE", DbType.String, ht["Date"]);

                return dbCon.ExcuteDataSet("SP_CONNECTION_LOG_LIST_COMP");
            }
        }
        #endregion
    }
}
