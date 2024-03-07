using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using JINI.Base;
using JINI.Base.Configuration;
using JINI.Base.Security;
using JINI.Data;
using System;
using System.Web;

namespace TaeYoung.Biz.Portal
{
    public class TimeLogBiz : BizBase
    {
        private static string _connectionString = "DB2";

        ///////////////////////////////////////////////////////////////////////
        // Public Method
        ///////////////////////////////////////////////////////////////////////

        #region GetChart
        /// <summary>
        /// GetChart
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetChart(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter(_connectionString))
            {
                dbCon.AddParameters("P_YEAR", DbType.String, ht["YEAR"]);
                dbCon.AddParameters("P_MONTH", DbType.String, ht["MONTH"]);
                dbCon.AddParameters("P_DAY", DbType.String, ht["DAY"]);
                dbCon.AddParameters("P_DIV_TOP", DbType.Int32, JINI.Util.ConvertType.ToInt32(ht["DIV_TOP"]));

                return dbCon.ExcuteDataSet("CMN_SYSTEMLOG_TIME_LIST");
            }
        }
        #endregion

        #region GetTopLogGridForMonth
        /// <summary>
        /// GetChart
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetTopLogGridForMonth(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter(_connectionString))
            {
                dbCon.AddParameters("P_YEAR", DbType.String, ht["YEAR"]);
                dbCon.AddParameters("P_DIV_TOP", DbType.Int32, ht["DIV_TOP"]);

                return dbCon.ExcuteDataSet("CMN_SYSTEMLOG_TIME_GRID_MONTH_LIST");
            }
        }
        #endregion

        #region GetTopLogGridForDay
        /// <summary>
        /// GetChart
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetTopLogGridForDay(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter(_connectionString))
            {
                dbCon.AddParameters("P_YEAR", DbType.String, ht["YEAR"]);
                dbCon.AddParameters("P_MONTH", DbType.String, ht["MONTH"]);
                dbCon.AddParameters("P_DAY", DbType.String, ht["DAY"]);
                dbCon.AddParameters("P_DIV_TOP", DbType.Int32, ht["DIV_TOP"]);

                return dbCon.ExcuteDataSet("CMN_SYSTEMLOG_TIME_GRID_DAY_LIST");
            }
        }
        #endregion

        #region ProgramLog.aspx

        #region GetCmn_Program_Systemlog_List - 프로그램별 시스템로그 카운트
        /// <summary>
        /// 프로그램별 시스템로그 카운트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetCmn_Program_Systemlog_List(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter(_connectionString))
            {
                dbCon.AddParameters("P_STDT", DbType.String, ht["STDT"]);
                dbCon.AddParameters("P_EDDT", DbType.String, ht["EDDT"]);

                return dbCon.ExcuteDataSet("CMN_PROGRAM_LIST_SYSTEMLOG");
            }
        }
        #endregion

        #endregion

        #region GetCmn_Systemlog_List - 시스템 로그 리스트
        /// <summary>
        /// 시스템 로그 리스트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetCmn_Systemlog_List(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter(_connectionString))
            {
                dbCon.AddParameters("P_YEAR", DbType.String, ht["YEAR"]);
                dbCon.AddParameters("P_MONTH", DbType.String, ht["MONTH"]);
                dbCon.AddParameters("P_DAY", DbType.String, ht["DAY"]);
                dbCon.AddParameters("P_DIV_TOP", DbType.Int32, JINI.Util.ConvertType.ToInt32(ht["DIV_TOP"]));
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("CMN_SYSTEMLOG_LIST_TIME");
            }
        }
        #endregion
    }
}
