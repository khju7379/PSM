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
    public class PSM1060 : BizBase
    {
        #region Description : HAZOP 메뉴 조회
        public DataSet UP_GET_HAZOP_MENU_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1060_HAZOP_MENU_LIST");
            }
        }
        #endregion

        #region Description : HAZOP 조회
        public DataSet UP_GET_HAZOP_PRINT_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SESSION", DbType.String, Document.UserInfo.EmpID + "qwerasdfzxcv");
                dbCon.AddParameters("P_HSPLCODE", DbType.String, ht["HSPLCODE"]);
                dbCon.AddParameters("P_HSWKCODE", DbType.String, ht["HSWKCODE"]);
                dbCon.AddParameters("P_SABUN", DbType.String, Document.UserInfo.EmpID);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1060_HAZOAP_PRINT_CREATE");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SESSION", DbType.String, Document.UserInfo.EmpID + "qwerasdfzxcv");

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1060_HAZOAP_PRINT_LIST");
            }
        }
        #endregion
    }
}