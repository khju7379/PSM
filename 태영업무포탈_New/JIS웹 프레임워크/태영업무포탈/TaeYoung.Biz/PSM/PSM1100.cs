using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JINI.Base;
using System.Data;
using JINI.Data;
using System.Collections;
using System.IO;

namespace TaeYoung.Biz.PSM
{
    public class PSM1100 : BizBase
    {

        public DataSet UP_SIGNCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_KBHANGL", DbType.String, ht["KBHANGL"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_SIGNCODE_LIST");
            }
        }

        #region Description : 대분류코드 조회(콤보박스)
        public DataSet UP_GET_LCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1110_LCODE_LIST");

            }
        }
        #endregion

    }
}
