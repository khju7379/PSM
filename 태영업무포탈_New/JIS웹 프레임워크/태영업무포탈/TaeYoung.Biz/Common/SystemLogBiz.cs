using System.Collections;
using System.Data;
using JINI.Base;
using JINI.Data;

namespace TaeYoung.Biz.Common
{
    /// <summary>
    /// 시스템 로그 처리
    /// </summary>
    class SystemLogBiz : BizBase
    {
        #region GetSystemLog - 시스템 로그 조회
        /// <summary>
        /// 시스템 로그 조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetSystemLogList(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dac.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dac.AddParameters("P_OCCUR_DATE", DbType.String, ht["OCCUR_DATE"]);
                dac.AddParameters("P_LOG_TYPE", DbType.String, ht["LOG_TYPE"]);
                dac.AddParameters("P_BIZ_TYPE", DbType.String, ht["BIZ_TYPE"]);
                dac.AddParameters("P_USER_ID", DbType.String, ht["USER_ID"]);

                return dac.ExcuteDataSet("CMN_LOG_LIST");
            }
        }
        #endregion

        #region GetSystemLog - 시스템 로그 상세정보 조회
        /// <summary>
        /// 시스템 로그 상세정보 조회
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public static DataSet GetSystemLog(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_IDX", DbType.String, ht["IDX"]);
                return dac.ExcuteDataSet("CMN_LOG_GET");
            }
        }
        #endregion
    }
}
