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
    public class PSM2010 : BizBase
    {

        public DataSet UP_PID_LIST(Hashtable ht)
        {          
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("TYJINFWLIB.PSM_PID_LIST");
            }
        }

        public DataSet UP_ATTFILE_DOWN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_AFFILENAME", DbType.String, ht["P_AFFILENAME"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.PSM_ATTACHFILE_DOWN");
            }
        }

        #region Description : 공정안전자료 메뉴 조회
        public DataSet UP_GET_BOARD_MENU_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBC1NTCODE", DbType.String, ht["P_PBC1NTCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM2010_BOARD_MENU_LIST");
            }
        }
        #endregion

        #region Description : 소분류 코드 등록여부 체크
        public DataSet UP_BOARD_CLASS3_CHECK(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBC3LCODE", DbType.String, ht["P_PBC3LCODE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM2010_BOARD_CLASS3_CHECK");
            }
        }
        #endregion

        #region Description : 게시판 리스트 조회
        public DataSet UP_GET_BOARD_MAST_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_PBMCNTCODE", DbType.String, ht["PBMCNTCODE"]);
                dbCon.AddParameters("P_PBMLCODE", DbType.String, ht["PBMLCODE"]);
                dbCon.AddParameters("P_PBMMCODE", DbType.String, ht["PBMMCODE"]);
                dbCon.AddParameters("P_PBMSCODE", DbType.String, ht["PBMSCODE"]);
                dbCon.AddParameters("P_PBMTITLE", DbType.String, ht["PBMTITLE"]);
                dbCon.AddParameters("P_PBMPUSABUN", DbType.String, ht["PBMPUSABUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM2010_BOARD_MAST_LIST");
            }
        }
        #endregion

        #region Description : 중분류코드 조회(콤보박스)
        public DataSet UP_GET_PBMMCODE_LIST(Hashtable ht)
        {
            //System.Diagnostics.Debugger.Break();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBMCNTCODE", DbType.String, ht["PBMCNTCODE"]);
                dbCon.AddParameters("P_PBMLCODE", DbType.String, ht["PBMLCODE"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM2010_PBMMCODE_LIST");
            }
        }
        #endregion

        #region Description : 소분류코드 조회(콤보박스)
        public DataSet UP_GET_PBMSCODE_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBMCNTCODE", DbType.String, ht["PBMCNTCODE"]);
                dbCon.AddParameters("P_PBMLCODE", DbType.String, ht["PBMLCODE"]);
                dbCon.AddParameters("P_PBMMCODE", DbType.String, ht["PBMMCODE"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM2010_PBMSCODE_LIST");
            }
        }
        #endregion

        #region Description : 게시판 마스타 확인
        public DataSet UP_BOARD_MAST_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBMCNTCODE", DbType.String, ht["PBMCNTCODE"]);
                dbCon.AddParameters("P_PBMLCODE", DbType.String, ht["PBMLCODE"]);
                dbCon.AddParameters("P_PBMMCODE", DbType.String, ht["PBMMCODE"]);
                dbCon.AddParameters("P_PBMSCODE", DbType.String, ht["PBMSCODE"]);
                dbCon.AddParameters("P_PBMNUM", DbType.String, ht["PBMNUM"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM2011_BOARD_MAST_RUN");
            }
        }
        #endregion

        #region Description : 게시판 저장 체크 (날짜 체크)
        public DataSet UP_BOARD_DETAIL_CHECK(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBDCNTCODE", DbType.String, ht["PBMCNTCODE"]);
                dbCon.AddParameters("P_PBDLCODE", DbType.String, ht["PBMLCODE"]);
                dbCon.AddParameters("P_PBDMCODE", DbType.String, ht["PBMMCODE"]);
                dbCon.AddParameters("P_PBDSCODE", DbType.String, ht["PBMSCODE"]);
                dbCon.AddParameters("P_PBDNUM", DbType.String, ht["PBMNUM"]);
                dbCon.AddParameters("P_PBDMODATE", DbType.String, ht["PBDMODATE"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM2011_BOARD_DETAIL_CHECK");
            }
        }

        #endregion

        #region Description : 게시판 마스타 등록
        public DataSet UP_BOARD_MAST_ADD(Hashtable ht)
        {   
            string sWKGUBUN = string.Empty;
            DataSet ds = new DataSet();

            // 순번 가져오기
            if (ht["PBMNUM"].ToString() == "0")
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_PBMCNTCODE", DbType.String, ht["PBMCNTCODE"]);
                    dbCon.AddParameters("P_PBMLCODE", DbType.String, ht["PBMLCODE"]);
                    dbCon.AddParameters("P_PBMMCODE", DbType.String, ht["PBMMCODE"]);
                    dbCon.AddParameters("P_PBMSCODE", DbType.String, ht["PBMSCODE"]);

                    ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM2011_BOARD_MAST_SEQ");

                    if (ds.Tables[0].Rows.Count > 0)
                    {   
                        ht["PBMNUM"] = ds.Tables[0].Rows[0]["PBMNUM"].ToString();
                        sWKGUBUN = "A";
                    }
                }
            }
            else
            {
                //sJSMSEQ = ht["JSMSEQ"].ToString();
                sWKGUBUN = "C";
            }

            // 마스타 등록
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBMCNTCODE", DbType.String, ht["PBMCNTCODE"]);
                dbCon.AddParameters("P_PBMLCODE", DbType.String, ht["PBMLCODE"]);
                dbCon.AddParameters("P_PBMMCODE", DbType.String, ht["PBMMCODE"]);
                dbCon.AddParameters("P_PBMSCODE", DbType.String, ht["PBMSCODE"]);
                dbCon.AddParameters("P_PBMNUM", DbType.String, ht["PBMNUM"]);
                dbCon.AddParameters("P_PBMPUDATE", DbType.String, ht["PBMPUDATE"]);
                dbCon.AddParameters("P_PBMPUSABUN", DbType.String, ht["PBMPUSABUN"]);
                dbCon.AddParameters("P_PBMTITLE", DbType.String, ht["PBMTITLE"]);
                dbCon.AddParameters("P_PBMHISAB", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("P_PBDMODESC", DbType.String, ht["PBDMODESC"]);
                dbCon.AddParameters("P_PBDMOSABUN", DbType.String, ht["PBDMOSABUN"]);
                dbCon.AddParameters("P_PBDMODATE", DbType.String, ht["PBDMODATE"]);
                dbCon.AddParameters("P_GUBUN", DbType.String, sWKGUBUN);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM2011_BOARD_MAST_ADD");
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_PBMCNTCODE", DbType.String, ht["PBMCNTCODE"]);
                dbCon.AddParameters("P_PBMLCODE", DbType.String, ht["PBMLCODE"]);
                dbCon.AddParameters("P_PBMMCODE", DbType.String, ht["PBMMCODE"]);
                dbCon.AddParameters("P_PBMSCODE", DbType.String, ht["PBMSCODE"]);
                dbCon.AddParameters("P_PBMNUM", DbType.String, ht["PBMNUM"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM2011_BOARD_MAST_RUN");
            }

        }
        #endregion

        #region Description : 게시판 마스터 삭제
        public void UP_BOARD_MAST_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_PBMCNTCODE", DbType.String, ht["PBMCNTCODE"]);
                dbCon.AddParameters("P_PBMLCODE", DbType.String, ht["PBMLCODE"]);
                dbCon.AddParameters("P_PBMMCODE", DbType.String, ht["PBMMCODE"]);
                dbCon.AddParameters("P_PBMSCODE", DbType.String, ht["PBMSCODE"]);
                dbCon.AddParameters("P_PBMNUM", DbType.String, ht["PBMNUM"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM2011_BOARD_MAST_DEL");
            }
        }
        #endregion

        #region Description : 게시판 수정이력 조회
        public DataSet UP_GET_BOARD_DETAIL_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {   
                dbCon.AddParameters("P_PBDCNTCODE", DbType.String, ht["PBDCNTCODE"]);
                dbCon.AddParameters("P_PBDLCODE", DbType.String, ht["PBDLCODE"]);
                dbCon.AddParameters("P_PBDMCODE", DbType.String, ht["PBDMCODE"]);
                dbCon.AddParameters("P_PBDSCODE", DbType.String, ht["PBDSCODE"]);
                dbCon.AddParameters("P_PBDNUM", DbType.String, ht["PBDNUM"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM2011_BOARD_DETAIL_LIST");
            }
        }
        #endregion

        #region Description : 게시판 수정이력 확인
        public DataSet UP_BOARD_DETAIL_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBDCNTCODE", DbType.String, ht["PBDCNTCODE"]);
                dbCon.AddParameters("P_PBDLCODE", DbType.String, ht["PBDLCODE"]);
                dbCon.AddParameters("P_PBDMCODE", DbType.String, ht["PBDMCODE"]);
                dbCon.AddParameters("P_PBDSCODE", DbType.String, ht["PBDSCODE"]);
                dbCon.AddParameters("P_PBDNUM", DbType.String, ht["PBDNUM"]);
                dbCon.AddParameters("P_PBDMOSEQ", DbType.String, ht["PBDMOSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_PSM2011_BOARD_DETAIL_RUN");
            }
        }
        #endregion

        #region Description : 게시판 수정이력 등록
        public void UP_BOARD_DETAIL_ADD(Hashtable ht)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PBDCNTCODE", DbType.String, ht["PBDCNTCODE"]);
                dbCon.AddParameters("P_PBDLCODE", DbType.String, ht["PBDLCODE"]);
                dbCon.AddParameters("P_PBDMCODE", DbType.String, ht["PBDMCODE"]);
                dbCon.AddParameters("P_PBDSCODE", DbType.String, ht["PBDSCODE"]);
                dbCon.AddParameters("P_PBDNUM", DbType.String, ht["PBDNUM"]);
                dbCon.AddParameters("P_PBDMOSEQ", DbType.String, ht["PBDMOSEQ"]);
                dbCon.AddParameters("P_PBDMOSABUN", DbType.String, ht["PBDMOSABUN"]);
                dbCon.AddParameters("P_PBDMODESC", DbType.String, ht["PBDMODESC"]);
                dbCon.AddParameters("P_PBDMODATE", DbType.String, ht["PBDMODATE"]);
                dbCon.AddParameters("P_PBDHISAB", DbType.String, Document.UserInfo.EmpID);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM2011_BOARD_DETAIL_ADD");
            }

        }
        #endregion

        #region Description : 게시판 수정이력 수정
        public void UP_BOARD_DETAIL_UPDATE(Hashtable ht, Hashtable[] hts)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                for (int i = 0; i < hts.Length; i++)
                {
                    dbCon.AddParameters("P_PBDCNTCODE", DbType.String, hts[i]["PBDCNTCODE"]);
                    dbCon.AddParameters("P_PBDLCODE", DbType.String, hts[i]["PBDLCODE"]);
                    dbCon.AddParameters("P_PBDMCODE", DbType.String, hts[i]["PBDMCODE"]);
                    dbCon.AddParameters("P_PBDSCODE", DbType.String, hts[i]["PBDSCODE"]);
                    dbCon.AddParameters("P_PBDNUM", DbType.String, hts[i]["PBDNUM"]);
                    dbCon.AddParameters("P_PBDMOSEQ", DbType.String, hts[i]["PBDMOSEQ"]);
                    dbCon.AddParameters("P_PBDMOSABUN", DbType.String, hts[i]["PBDMOSABUN"]);
                    dbCon.AddParameters("P_PBDMODESC", DbType.String, hts[i]["PBDMODESC"]);
                    dbCon.AddParameters("P_PBDMODATE", DbType.String, hts[i]["PBDMODATE"]);
                    dbCon.AddParameters("P_PBDHISAB", DbType.String, Document.UserInfo.EmpID);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_PSM2011_BOARD_DETAIL_ADD");
                }
            }
        }
        #endregion
    }
}
