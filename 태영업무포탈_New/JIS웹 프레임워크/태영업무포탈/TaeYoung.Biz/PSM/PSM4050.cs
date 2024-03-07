using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JINI.Base;
using System.Data;
using JINI.Data;
using System.Collections;

namespace TaeYoung.Biz.PSM
{
    public class PSM4050 : BizBase
    {
        #region Description : 작업요청관리 조회
        public DataSet UP_GET_SAFEWORKORDER_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE", DbType.String, ht["P_SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["P_EDATE"]);
                dbCon.AddParameters("P_WKSAUP", DbType.String, ht["P_WKSAUP"]);
                dbCon.AddParameters("P_WKTEAM", DbType.String, ht["P_WKTEAM"]);
                dbCon.AddParameters("P_STATUS", DbType.String, ht["P_STATUS"]);
                dbCon.AddParameters("P_DEPT", DbType.String, ht["P_DEPT"]);
                dbCon.AddParameters("P_ORSABUN", DbType.String, ht["P_ORSABUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4050_SAFEWORKOR_LIST");
            }
        }
        #endregion

        #region Description : 안전작업허가서 조회
        public DataSet UP_GET_SAFEORDER_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {

                dbCon.AddParameters("P_SMWKTEAM", DbType.String, ht["P_SMWKTEAM"]);
                dbCon.AddParameters("P_SMWKDATE", DbType.String, ht["P_SMWKDATE"]);
                dbCon.AddParameters("P_SMWKSEQ", DbType.String, ht["P_SMWKSEQ"]);
                dbCon.AddParameters("P_SMWKORAPPDATE", DbType.String, ht["P_SMWKORAPPDATE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4050_SAFEORDER_LIST");
            }
        }
        #endregion


    }
}