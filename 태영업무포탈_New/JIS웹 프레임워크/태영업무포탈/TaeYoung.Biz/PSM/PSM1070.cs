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
    public class PSM1070 : BizBase
    {
        #region Description : CHECKLIST 메뉴 조회
        public DataSet UP_GET_CHECKLIST_MENU_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1070_CHECKLIST_MENU_LIST");
            }
        }
        #endregion

        #region Description : CHECKLIST 조회
        public DataSet UP_GET_CHECKLIST_LIST(Hashtable ht)
        {
            string[] sDatas = ht["P_MENU_NAME"].ToString().Split('_');

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_CISBCODE", DbType.String, sDatas[0]);
                dbCon.AddParameters("P_CIGRCODE", DbType.String, sDatas[1]);
                dbCon.AddParameters("P_CIGRSEQ", DbType.String, sDatas[2]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1070_CHECKLIST_LIST");
            }
        }
        #endregion

        #region Description : CHECKLIST 출력
        public DataSet UP_GET_CHECKLIST_PRT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_CISBCODE", DbType.String, ht["CISBCODE"]);
                dbCon.AddParameters("P_CIGRCODE", DbType.String, ht["CIGRCODE"]);
                dbCon.AddParameters("P_CIGRSEQ", DbType.String, ht["CIGRSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1070_CHECKLIST_LIST");
            }
        }
        #endregion

        #region Description : CHECKLIST 조회
        public DataSet UP_CHECKLIST_MENU_RUN(Hashtable ht)
        {
            string[] sDatas = ht["P_MENU_NAME"].ToString().Split('_');

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_CMSBCODE", DbType.String, sDatas[0]);
                dbCon.AddParameters("P_CMGRCODE", DbType.String, sDatas[1]);
                dbCon.AddParameters("P_CMGRSEQ", DbType.String, sDatas[2]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1070_CHECKLIST_MENU_RUN");
            }
        }
        #endregion

        #region Description : CHECKLIST 메뉴 확인
        public DataSet UP_CHECKLIST_MCODE_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CMSBCODE", DbType.String, ht["CMSBCODE"]);
                dbCon.AddParameters("P_CMGRCODE", DbType.String, ht["CMGRCODE"]);
                dbCon.AddParameters("P_CMGRSEQ", DbType.String, ht["CMGRSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1071_CHECKLIST_MCODE_RUN");
            }
        }
        #endregion

        #region Description : CHECKLIST 메뉴 등록
        public DataSet UP_CHECKLIST_MCODE_ADD(Hashtable ht)
        {
            string sCMGRSEQ = string.Empty;
            
            DataSet ds = new DataSet();

            if (ht["CMGRSEQ"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_CMSBCODE", DbType.String, ht["CMSBCODE"]);
                    dbCon.AddParameters("P_CMGRCODE", DbType.String, ht["CMGRCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1071_CHECKLIST_MCODE_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sCMGRSEQ = ds.Tables[0].Rows[0]["CMGRSEQ"].ToString();
                    }
                }
            }
            else
            {
                sCMGRSEQ = ht["CMGRSEQ"].ToString();
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CMSBCODE", DbType.String, ht["CMSBCODE"]);
                dbCon.AddParameters("P_CMGRCODE", DbType.String, ht["CMGRCODE"]);
                dbCon.AddParameters("P_CMGRSEQ", DbType.String, sCMGRSEQ);
                dbCon.AddParameters("P_CMMCNUM", DbType.String, ht["CMMCNUM"]);
                dbCon.AddParameters("P_CMDESC", DbType.String, ht["CMDESC"]);
                dbCon.AddParameters("P_CMWRSABUN", DbType.String, ht["CMWRSABUN"]);
                dbCon.AddParameters("P_CMWRDATE", DbType.String, ht["CMWRDATE"]);
                dbCon.AddParameters("P_CMHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["WKGUBUN"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1071_CHECKLIST_MCODE_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CMSBCODE", DbType.String, ht["CMSBCODE"]);
                dbCon.AddParameters("P_CMGRCODE", DbType.String, ht["CMGRCODE"]);
                dbCon.AddParameters("P_CMGRSEQ", DbType.String, sCMGRSEQ);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1071_CHECKLIST_MCODE_RUN");
            }

        }
        #endregion

        #region Description : CHECKLIST 메뉴 삭제
        public void UP_CHECKLIST_MCODE_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_CMSBCODE", DbType.String, ht["CMSBCODE"]);
                dbCon.AddParameters("P_CMGRCODE", DbType.String, ht["CMGRCODE"]);
                dbCon.AddParameters("P_CMGRSEQ", DbType.String, ht["CMGRSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1071_CHECKLIST_MCODE_DEL");
            }
        }
        #endregion

        #region Description : CHECKLIST DCODE 조회
        public DataSet UP_GET_CHECKLIST_DCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_CISBCODE", DbType.String, ht["CISBCODE"]);
                dbCon.AddParameters("P_CIGRCODE", DbType.String, ht["CIGRCODE"]);
                dbCon.AddParameters("P_CIGRSEQ", DbType.String, ht["CIGRSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1072_CHECKLIST_DCODE_LIST");
            }
        }
        #endregion

        #region Description : CHECKLIST DCODE 확인
        public DataSet UP_GET_CHECKLIST_DCODE_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_CISBCODE", DbType.String, ht["CISBCODE"]);
                dbCon.AddParameters("P_CIGRCODE", DbType.String, ht["CIGRCODE"]);
                dbCon.AddParameters("P_CIGRSEQ", DbType.String, ht["CIGRSEQ"]);
                dbCon.AddParameters("P_CIITEMNUM", DbType.String, ht["CIITEMNUM"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1072_CHECKLIST_DCODE_RUN");
            }
        }
        #endregion

        #region Description : CHECKLIST DCODE 등록
        public DataSet UP_CHECKLIST_DCODE_ADD(Hashtable ht)
        {
            string sCIITEMNUM = string.Empty;
            string sWKGUBUN = string.Empty;

            DataSet ds = new DataSet();

            if (ht["CIITEMNUM"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_CISBCODE", DbType.String, ht["CISBCODE"]);
                    dbCon.AddParameters("P_CIGRCODE", DbType.String, ht["CIGRCODE"]);
                    dbCon.AddParameters("P_CIGRSEQ", DbType.String, ht["CIGRSEQ"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1072_CHECKLIST_DCODE_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sCIITEMNUM = ds.Tables[0].Rows[0]["CIITEMNUM"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sCIITEMNUM = ht["CIITEMNUM"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CISBCODE", DbType.String, ht["CISBCODE"]);
                dbCon.AddParameters("P_CIGRCODE", DbType.String, ht["CIGRCODE"]);
                dbCon.AddParameters("P_CIGRSEQ", DbType.String, ht["CIGRSEQ"]);
                dbCon.AddParameters("P_CIITEMNUM", DbType.String, sCIITEMNUM);
                dbCon.AddParameters("P_CIEVAITEM", DbType.String, ht["CIEVAITEM"]);
                dbCon.AddParameters("P_CIEVASTD", DbType.String, ht["CIEVASTD"]);
                dbCon.AddParameters("P_CIWRSABUN", DbType.String, ht["CIWRSABUN"]);
                dbCon.AddParameters("P_CIWRDATE", DbType.String, ht["CIWRDATE"]);
                dbCon.AddParameters("P_CIHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1072_CHECKLIST_DCODE_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CISBCODE", DbType.String, ht["CISBCODE"]);
                dbCon.AddParameters("P_CIGRCODE", DbType.String, ht["CIGRCODE"]);
                dbCon.AddParameters("P_CIGRSEQ", DbType.String, ht["CIGRSEQ"]);
                dbCon.AddParameters("P_CIITEMNUM", DbType.String, sCIITEMNUM);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1072_CHECKLIST_DCODE_RUN");
            }
        }
        #endregion

        #region Description : CHECKLIST DCODE 삭제
        public DataSet UP_CHECKLIST_DCODE_DEL(Hashtable ht)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            string sMSG = UP_CHECKLIST_DCODE_Check(ht);

            dt.Columns.Add("STATE", typeof(System.String));
            dt.Columns.Add("MSG", typeof(System.String));

            if (sMSG == "")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_CISBCODE", DbType.String, ht["CISBCODE"]);
                    dbCon.AddParameters("P_CIGRCODE", DbType.String, ht["CIGRCODE"]);
                    dbCon.AddParameters("P_CIGRSEQ", DbType.String, ht["CIGRSEQ"]);
                    dbCon.AddParameters("P_CIITEMNUM", DbType.String, ht["CIITEMNUM"]);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1072_CHECKLIST_DCODE_DEL");

                    row = dt.NewRow();
                    row["STATE"] = "OK";
                    row["MSG"] = "";
                    dt.Rows.Add(row);
                    ds.Tables.Add(dt);
                }
            }
            else
            {
                row = dt.NewRow();
                row["STATE"] = "ERR";
                row["MSG"] = sMSG;
                dt.Rows.Add(row);
                ds.Tables.Add(dt);
            }

            return ds;
        }
        #endregion

        #region Description : CHECKLIST DCODE 삭제 체크
        public string UP_CHECKLIST_DCODE_Check(Hashtable ht)
        {
            string sMSG = string.Empty;

            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, 15);
                dbCon.AddParameters("P_CSTSBCODE", DbType.String, ht["CISBCODE"]);
                dbCon.AddParameters("P_CSTGRCODE", DbType.String, ht["CIGRCODE"]);
                dbCon.AddParameters("P_CSTGRSEQ", DbType.String, ht["CIGRSEQ"]);
                dbCon.AddParameters("P_CSTITEMNUM", DbType.String, ht["CIITEMNUM"]);

                ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1072_CHECKLIST_STRESULT_LIST");

                if (ds.Tables[0].Rows.Count > 0)
                {
                    sMSG = "안전조치 내용이 존재하여 삭제할 수 없습니다.";

                    return sMSG;
                }
            }

            return sMSG;
        }
        #endregion

        #region Description : CHECKLIST STRESULT 조회
        public DataSet UP_GET_CHECKLIST_STRESULT_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_CSTSBCODE", DbType.String, ht["CSTSBCODE"]);
                dbCon.AddParameters("P_CSTGRCODE", DbType.String, ht["CSTGRCODE"]);
                dbCon.AddParameters("P_CSTGRSEQ", DbType.String, ht["CSTGRSEQ"]);
                dbCon.AddParameters("P_CSTITEMNUM", DbType.String, ht["CSTITEMNUM"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1072_CHECKLIST_STRESULT_LIST");
            }
        }
        #endregion

        #region Description : CHECKLIST STRESULT 확인
        public DataSet UP_GET_CHECKLIST_STRESULT_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_CSTSBCODE", DbType.String, ht["CSTSBCODE"]);
                dbCon.AddParameters("P_CSTGRCODE", DbType.String, ht["CSTGRCODE"]);
                dbCon.AddParameters("P_CSTGRSEQ", DbType.String, ht["CSTGRSEQ"]);
                dbCon.AddParameters("P_CSTITEMNUM", DbType.String, ht["CSTITEMNUM"]);
                dbCon.AddParameters("P_CSTSEQ", DbType.String, ht["CSTSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1072_CHECKLIST_STRESULT_RUN");
            }
        }
        #endregion

        #region Description : CHECKLIST DCODE 등록
        public DataSet UP_CHECKLIST_STRESULT_ADD(Hashtable ht)
        {
            string sCSTSEQ = string.Empty;
            string sWKGUBUN = string.Empty;

            DataSet ds = new DataSet();

            if (ht["CSTSEQ"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_CSTSBCODE", DbType.String, ht["CSTSBCODE"]);
                    dbCon.AddParameters("P_CSTGRCODE", DbType.String, ht["CSTGRCODE"]);
                    dbCon.AddParameters("P_CSTGRSEQ", DbType.String, ht["CSTGRSEQ"]);
                    dbCon.AddParameters("P_CSTITEMNUM", DbType.String, ht["CSTITEMNUM"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1072_CHECKLIST_STRESULT_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sCSTSEQ = ds.Tables[0].Rows[0]["CSTSEQ"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                sCSTSEQ = ht["CSTSEQ"].ToString();
                sWKGUBUN = "C";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CSTSBCODE", DbType.String, ht["CSTSBCODE"]);
                dbCon.AddParameters("P_CSTGRCODE", DbType.String, ht["CSTGRCODE"]);
                dbCon.AddParameters("P_CSTGRSEQ", DbType.String, ht["CSTGRSEQ"]);
                dbCon.AddParameters("P_CSTITEMNUM", DbType.String, ht["CSTITEMNUM"]);
                dbCon.AddParameters("P_CSTSEQ", DbType.String, sCSTSEQ);
                dbCon.AddParameters("P_CSTACTDESC", DbType.String, ht["CSTACTDESC"]);
                dbCon.AddParameters("P_CSTADVDESC", DbType.String, ht["CSTADVDESC"]);
                dbCon.AddParameters("P_CSTWRSABUN", DbType.String, ht["CSTWRSABUN"]);
                dbCon.AddParameters("P_CSTWRDATE", DbType.String, ht["CSTWRDATE"]);
                dbCon.AddParameters("P_CSTHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1072_CHECKLIST_STRESULT_ADD");
            }
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CSTSBCODE", DbType.String, ht["CSTSBCODE"]);
                dbCon.AddParameters("P_CSTGRCODE", DbType.String, ht["CSTGRCODE"]);
                dbCon.AddParameters("P_CSTGRSEQ", DbType.String, ht["CSTGRSEQ"]);
                dbCon.AddParameters("P_CSTITEMNUM", DbType.String, ht["CSTITEMNUM"]);
                dbCon.AddParameters("P_CSTSEQ", DbType.String, sCSTSEQ);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM1072_CHECKLIST_STRESULT_RUN");
            }
        }
        #endregion

        #region Description : TANK 저장물질 요소 삭제
        public void UP_CHECKLIST_STRESULT_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CSTSBCODE", DbType.String, ht["CSTSBCODE"]);
                dbCon.AddParameters("P_CSTGRCODE", DbType.String, ht["CSTGRCODE"]);
                dbCon.AddParameters("P_CSTGRSEQ", DbType.String, ht["CSTGRSEQ"]);
                dbCon.AddParameters("P_CSTITEMNUM", DbType.String, ht["CSTITEMNUM"]);
                dbCon.AddParameters("P_CSTSEQ", DbType.String, ht["CSTSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM1072_CHECKLIST_STRESULT_DEL");
            }
        }
        #endregion
    }
}