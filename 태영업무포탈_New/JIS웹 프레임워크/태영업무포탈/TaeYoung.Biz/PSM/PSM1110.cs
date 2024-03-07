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
    public class PSM1110 : BizBase
    {

        public DataSet UP_BOARD_CLASS1_ADD(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {


                dbCon.AddParameters("P_PBC1LCODE", DbType.String, ht["P_PBC1LCODE"]);
                dbCon.AddParameters("P_PBC1NAME", DbType.String, ht["P_PBC1NAME"]);
                dbCon.AddParameters("P_PBC1BIGO", DbType.String, ht["P_PBC1BIGO"]);
                dbCon.AddParameters("P_PBC1HISAB", DbType.String, ht["P_PBC1HISAB"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1110_BOARD_CLASS1_ADD");
            }
        }

        public void UP_BOARD_CLASS1_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {

                dbCon.AddParameters("P_PBC1LCODE", DbType.String, ht["P_PBC1LCODE"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1110_BOARD_CLASS1_DEL");
            }
        }

        public DataSet UP_BOARD_CLASS2_ADD(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBC2LCODE", DbType.String, ht["P_PBC2LCODE"]);
                dbCon.AddParameters("P_PBC2MCODE", DbType.String, ht["P_PBC2MCODE"]);
                dbCon.AddParameters("P_PBC2NAME", DbType.String, ht["P_PBC2NAME"]);
                dbCon.AddParameters("P_PBC2BIGO", DbType.String, ht["P_PBC2BIGO"]);
                dbCon.AddParameters("P_PBC2HISAB", DbType.String, ht["P_PBC2HISAB"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1110_BOARD_CLASS2_ADD");
            }
        }

        public void UP_BOARD_CLASS2_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {

                dbCon.AddParameters("P_PBC2LCODE", DbType.String, ht["P_PBC2LCODE"]);
                dbCon.AddParameters("P_PBC2MCODE", DbType.String, ht["P_PBC2MCODE"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1110_BOARD_CLASS2_DEL");
            }
        }

        public DataSet UP_BOARD_CLASS3_ADD(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBC3LCODE", DbType.String, ht["P_PBC3LCODE"]);
                dbCon.AddParameters("P_PBC3MCODE", DbType.String, ht["P_PBC3MCODE"]);
                dbCon.AddParameters("P_PBC3SCODE", DbType.String, ht["P_PBC3SCODE"]);
                dbCon.AddParameters("P_PBC3NAME", DbType.String, ht["P_PBC3NAME"]);
                dbCon.AddParameters("P_PBC3BIGO", DbType.String, ht["P_PBC3BIGO"]);
                dbCon.AddParameters("P_PBC3HISAB", DbType.String, ht["P_PBC3HISAB"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1110_BOARD_CLASS3_ADD");
            }
        }

        public void UP_BOARD_CLASS3_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {

                dbCon.AddParameters("P_PBC3LCODE", DbType.String, ht["P_PBC3LCODE"]);
                dbCon.AddParameters("P_PBC3MCODE", DbType.String, ht["P_PBC3MCODE"]);
                dbCon.AddParameters("P_PBC3SCODE", DbType.String, ht["P_PBC3SCODE"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1110_BOARD_CLASS3_DEL");
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

        #region Description : 중분류코드 조회(콤보박스)
        public DataSet UP_GET_MCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBC2LCODE", DbType.String, ht["P_PBC2LCODE"]);                

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1110_MCODE_LIST");
            }
        }
        #endregion

        #region Description : 소분류코드 조회(콤보박스)
        public DataSet UP_GET_SCODE_LIST(Hashtable ht)
        {
            
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_PBC3NTCODE", DbType.String, ht["P_PBC3NTCODE"]);
                dbCon.AddParameters("P_PBC3LCODE", DbType.String, ht["P_PBC3LCODE"]);
                dbCon.AddParameters("P_PBC3MCODE", DbType.String, ht["P_PBC3MCODE"]);
                dbCon.AddParameters("P_PBC3NAME", DbType.String, ht["P_PBC3NAME"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1110_SCODE_LIST");
            }
        }
        #endregion


    }
}
