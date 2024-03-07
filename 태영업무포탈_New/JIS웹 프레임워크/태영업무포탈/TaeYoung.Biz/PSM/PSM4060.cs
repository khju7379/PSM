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
    public class PSM4060 : BizBase
    {
        #region Description : 외주공사 조회
        public DataSet UP_Get_OutWork_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SDATE", DbType.String, ht["P_SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["P_EDATE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM4060_OutSideConstruct_LIST");
            }
        }
        #endregion

        


    }
}