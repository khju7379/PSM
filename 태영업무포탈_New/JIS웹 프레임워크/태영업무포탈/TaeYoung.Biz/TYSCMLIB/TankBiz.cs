using System;
using System.Collections;
using System.Data;
using JINI.Base;
using JINI.Data;
using System.Threading;

using System.Collections.Generic;

namespace TaeYoung.Biz.TYSCMLIB
{
    public class TankBiz : BizBase
    {
        #region GetTankCombo : 탱크정보를 가져온다(콤보박스)
        /// <summary>
        /// 탱크정보를 가져온다(콤보박스)
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetTankCombo(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_COMBO");
            }
        }
        #endregion

        #region GetHwamulCombo : 화주정보를 가져온다(콤보박스)
        /// <summary>
        /// 탱크정보를 가져온다(콤보박스)
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetHwajuCombo(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("TYJINFWLIB.UTITANKF_GET_HWAJU");
            }
        }
        #endregion

        #region GetHwamulCombo : 화물정보를 가져온다(콤보박스)
        /// <summary>
        /// 탱크정보를 가져온다(콤보박스)
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetHwamulCombo(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                return dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_HWAMUL");
            }
        }
        #endregion

        #region GetTank : 탱크정보를 가져온다
        /// <summary>
        /// 탱크정보를 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetTank(Hashtable ht)
        {
            DataSet ds = new DataSet();
            try
            {
                
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    if (ht["JEGOTK"] != "")
                    {
                        dbCon.AddParameters("P_JEGOTK", DbType.String, ht["JEGOTK"]);
                        ds = dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_TANK");
                    }
                    else
                    {
                        DataTable dt = new DataTable();
                        ds.Tables.Add(dt);
                    }
                    return ds;
                }
            }
            catch
            {
                DataTable dt = new DataTable();
                ds.Tables.Add(dt);

                return ds;
            }
        }
        #endregion

        #region UP_Tank_Change : 탱크정보 데이터변환
        private DataSet UP_Tank_Change(DataSet ds)
        {
            DataSet Retds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            int iRowCnt = ds.Tables[0].Rows.Count;
            int iPageCnt = 0;
            int iLastCnt = 0;
            int iCnt = 0;

            iPageCnt = Convert.ToInt32(Math.Ceiling(Convert.ToDouble(iRowCnt) / 10));
            iLastCnt = iRowCnt % 10;
            if (iLastCnt > 0)
            {
                iLastCnt = 10 - iLastCnt;
            }
            iRowCnt += iLastCnt;

            string[] sTKNO = new string[iRowCnt];

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                sTKNO[i] = ds.Tables[0].Rows[i]["TNTANKNO"].ToString();
            }

            dt.Columns.Add("TKNO1");
            dt.Columns.Add("TKNO2");
            dt.Columns.Add("TKNO3");
            dt.Columns.Add("TKNO4");
            dt.Columns.Add("TKNO5");
            dt.Columns.Add("TKNO6");
            dt.Columns.Add("TKNO7");
            dt.Columns.Add("TKNO8");
            dt.Columns.Add("TKNO9");
            dt.Columns.Add("TKNO10");

            for (int i = 0; i < iPageCnt; i++)
            {
                row = dt.NewRow();

                row["TKNO1"] = sTKNO[iCnt];
                row["TKNO2"] = sTKNO[iCnt + 1];
                row["TKNO3"] = sTKNO[iCnt + 2];
                row["TKNO4"] = sTKNO[iCnt + 3];
                row["TKNO5"] = sTKNO[iCnt + 4];
                row["TKNO6"] = sTKNO[iCnt + 5];
                row["TKNO7"] = sTKNO[iCnt + 6];
                row["TKNO8"] = sTKNO[iCnt + 7];
                row["TKNO9"] = sTKNO[iCnt + 8];
                row["TKNO10"] = sTKNO[iCnt + 9];

                dt.Rows.Add(row);

                iCnt += 10;
            }
            Retds.Tables.Add(dt);

            return Retds;
        }
        #endregion

        #region GetTrend : 트렌드정보를 가져온다
        /// <summary>
        /// 탱크정보를 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetTrend(Hashtable ht)
        {
            DataSet ds = new DataSet();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                string sTUGOTM = string.Empty;
                string sTUSTTIME = "000000";
                string sTUEDTIME = "240000";
                string sGUBN = ht["TUGOTM"].ToString();
                string sTIME = ht["TIME"].ToString();

                if (ht["TUGOTM"].ToString() == "60")
                {
                    sTUGOTM = "00";
                }
                else if (ht["TUGOTM"].ToString() == "30")
                {
                    sTUGOTM = "00,30";
                }
                else if (ht["TUGOTM"].ToString() == "10")
                {
                    sTUGOTM = "00,10,20,30,40,50";
                }
                else if (ht["TUGOTM"].ToString() == "1")
                {
                    sTUGOTM = "00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59";
                    sTUSTTIME = ht["TUSTTIME"] + "0000";
                    sTUEDTIME = ht["TUEDTIME"] + "0059";

                    
                }

                if (ht["TUGOTK"].ToString() != "" && ht["TUGOIL"].ToString() != "")
                {
                    dbCon.AddParameters("IN_TUGOTK", DbType.Int32, ht["TUGOTK"]);
                    dbCon.AddParameters("IN_TUGOIL", DbType.String, ht["TUGOIL"]);
                    dbCon.AddParameters("IN_TUSTTIME", DbType.String, sTUSTTIME);
                    dbCon.AddParameters("IN_TUEDTIME", DbType.String, sTUEDTIME);
                    dbCon.AddParameters("IN_TUGOTM", DbType.String, sTUGOTM);
                    ds = UP_Trend_Change(dbCon.ExcuteDataSet("TYJINFWLIB.UTATKHSF_GET_TREND"), sGUBN, sTIME);
                }
                else
                {
                    dbCon.AddParameters("IN_TUGOTK", DbType.Int32, 0);
                    dbCon.AddParameters("IN_TUGOIL", DbType.String, "9999-01-01");
                    dbCon.AddParameters("IN_TUGOTM", DbType.String, "30");
                    dbCon.AddParameters("IN_TUSTTIME", DbType.String, "000000");
                    dbCon.AddParameters("IN_TUEDTIME", DbType.String, "240000");
                    ds = UP_Trend_Change(dbCon.ExcuteDataSet("TYJINFWLIB.UTATKHSF_GET_TREND"), "30", "0");
                }
                
                return ds;
            }
        }
        #endregion

        #region UP_Trend_Change : 트렌드 데이터변환
        private DataSet UP_Trend_Change(DataSet ds, string GUBN, string TIME)
        {

            DataSet Retds = ds;
            int iBLANK = 0;

            if (GUBN == "60")
            {
                iBLANK = 24 - ds.Tables[0].Rows.Count;
            }
            else if (GUBN == "30")
            {
                iBLANK = 48 - ds.Tables[0].Rows.Count;
            }
            else if (GUBN == "10")
            {
                iBLANK = 144 - ds.Tables[0].Rows.Count;
            }
            else
            {
                if (TIME == "1")
                {
                    iBLANK = 60 - ds.Tables[0].Rows.Count;
                }
                else if (TIME == "2")
                {
                    iBLANK = 120 - ds.Tables[0].Rows.Count;
                }
                else if (TIME == "3")
                {
                    iBLANK = 180 - ds.Tables[0].Rows.Count;
                }
            }
            int i = 0;

            int count = ds.Tables[0].Rows.Count;

            DataRow row;
            if (iBLANK != 0)
            {
                for (i = 0; i < iBLANK + 1; i++)
                {
                    row = Retds.Tables[0].NewRow();

                    row["TUGOTK"] = DBNull.Value;
                    row["TUGOIL"] = DBNull.Value;
                    row["TUGOTM"] = "--:--";
                    row["TUGOMASS"] = "100000";
                    row["TUGOTEMP"] = "100000";
                    row["TUHIGH"] = 10000;
                    row["TUGKLQTY"] = 10000;
                    row["TUNKLQTY"] = DBNull.Value;
                    row["TUHWAMUL"] = DBNull.Value;
                    row["TUHMNAME"] = DBNull.Value;
                    row["JECAPA"] = 1000;
                    row["JENKLQTY"] = DBNull.Value;
                    row["JEPRESS"] = 10000;

                    Retds.Tables[0].Rows.Add(row);
                    count++;
                }
            }
            return Retds;
        }
        #endregion

        #region GetTankPageList : 페이지 리스트 조회
        /// <summary>
        /// 저장된 페이지의 전체 목록을 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetTankPageList(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("IN_TKSABUN", DbType.String, Document.UserInfo.EmpID);
                //dbCon.AddParameters("IN_TKSABUN", DbType.String, "0403-M");
                DataSet ds = dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_TANKPAGELIST");

                return ds;
            }
        }
        #endregion

        #region GetTankPage : 페이지 정보 조회
        /// <summary>
        /// 페이지 저장 정보를 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetTankPage(Hashtable ht)
        {
            DataSet ds = new DataSet();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_TKSABUN", DbType.String, Document.UserInfo.EmpID);
                //dbCon.AddParameters("P_TKSABUN", DbType.String, "0403-M");
                dbCon.AddParameters("P_TKINDEX", DbType.String, ht["TKINDEX"]);
                ds = dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_TANKPAGE");

                if (ds.Tables[0].Rows.Count <= 0)
                {
                    DataTable dt = ds.Tables[0];
                    DataRow row = dt.NewRow();

                    //dt.Columns.Add("TKSABUN");
                    //dt.Columns.Add("TKINDEX");
                    //dt.Columns.Add("TKNO1");
                    //dt.Columns.Add("TKNO2");
                    //dt.Columns.Add("TKNO3");
                    //dt.Columns.Add("TKNO4");
                    //dt.Columns.Add("TKNO5");
                    //dt.Columns.Add("TKNO6");
                    //dt.Columns.Add("TKNO7");
                    //dt.Columns.Add("TKNO8");
                    //dt.Columns.Add("TKNO9");
                    //dt.Columns.Add("TKNO10");

                    row = dt.NewRow();

                    row["TKSABUN"] = Document.UserInfo.EmpID;
                    //row["TKSABUN"] = "0403-M";
                    row["TKINDEX"] = ht["TKINDEX"];
                    row["TKNO1"] = "";
                    row["TKNO2"] = "";
                    row["TKNO3"] = "";
                    row["TKNO4"] = "";
                    row["TKNO5"] = "";
                    row["TKNO6"] = "";
                    row["TKNO7"] = "";
                    row["TKNO8"] = "";
                    row["TKNO9"] = "";
                    row["TKNO10"] = "";

                    dt.Rows.Add(row);
                    //ds.Tables.Add(dt);
                }

                return ds;
            }
        }
        #endregion

        #region SetTankPage : 페이지 저장
        /// <summary>
        /// 페이지 정보를 저장한다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public void SetTankPage(Hashtable ht)
        {   
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("IN_TKSABUN", DbType.String, Document.UserInfo.EmpID);
                //dbCon.AddParameters("IN_TKSABUN", DbType.String, "0403-M");
                dbCon.AddParameters("IN_TKINDEX", DbType.String, ht["TKINDEX"]);
                dbCon.AddParameters("IN_TKNO1", DbType.String, ht["TKNO1"]);
                dbCon.AddParameters("IN_TKNO2", DbType.String, ht["TKNO2"]);
                dbCon.AddParameters("IN_TKNO3", DbType.String, ht["TKNO3"]);
                dbCon.AddParameters("IN_TKNO4", DbType.String, ht["TKNO4"]);
                dbCon.AddParameters("IN_TKNO5", DbType.String, ht["TKNO5"]);
                dbCon.AddParameters("IN_TKNO6", DbType.String, ht["TKNO6"]);
                dbCon.AddParameters("IN_TKNO7", DbType.String, ht["TKNO7"]);
                dbCon.AddParameters("IN_TKNO8", DbType.String, ht["TKNO8"]);
                dbCon.AddParameters("IN_TKNO9", DbType.String, ht["TKNO9"]);
                dbCon.AddParameters("IN_TKN10", DbType.String, ht["TKN10"]);
                dbCon.AddParameters("IN_TKGUBN", DbType.String, ht["TKGUBN"]);
                dbCon.AddParameters("RET_MSG", DbType.String, "");
                dbCon.ExcuteNonQuery("TYJINFWLIB.UTATKJGF_SET_TANKPAGE");
            }
        }
        #endregion

        #region SetTankTemp : 탱크 관리온도 저장
        /// <summary>
        /// 탱크 관리온도를 저장한다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public void SetTankTemp(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("IN_TANKNO", DbType.String, ht["TANKNO"]);
                dbCon.AddParameters("IN_TANKTEMPH", DbType.String, ht["TANKTEMPH"]);
                dbCon.AddParameters("IN_TANKTEMPL", DbType.String, ht["TANKTEMPL"]);
                dbCon.AddParameters("IN_TANKHISAB", DbType.String, Document.UserInfo.EmpID);
                //dbCon.AddParameters("IN_TANKHISAB", DbType.String, "0403-M");
                dbCon.AddParameters("RET_MSG", DbType.String, "");
                dbCon.ExcuteNonQuery("TYJINFWLIB.UTATKJGF_SET_TANKTEMP");
            }
        }
        #endregion

        #region GetHwamulTank : 화주별 탱크 리스트 조회
        /// <summary>
        /// 화주별 탱크의 목록을 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetHwajuTank(Hashtable ht)
        {
            DataSet ds = new DataSet();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                if (ht["JEHWAJU"] != "")
                {
                    string[] sJEHWAJU = ht["JEHWAJU"].ToString().Split(':');

                    dbCon.AddParameters("IN_JEHWAJU", DbType.String, sJEHWAJU[0]);
                    dbCon.AddParameters("IN_JEHJNAME", DbType.String, sJEHWAJU[1]);
                    ds = UP_Data_Change(dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_TANKHWAJU"));
                }
                else
                {
                    DataTable dt = new DataTable();
                    ds.Tables.Add(dt);
                }
            }
            return ds;
        }
        #endregion

        #region GetHwamulTank : 화물별 탱크 리스트 조회
        /// <summary>
        /// 화물별 탱크의 목록을 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetHwamulTank(Hashtable ht)
        {
            DataSet ds = new DataSet();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                if (ht["JEHWAMUL"] != "")
                {
                    string[] sJEHWAMUL = ht["JEHWAMUL"].ToString().Split(':');

                    dbCon.AddParameters("IN_JEHWAMUL", DbType.String, sJEHWAMUL[0]);
                    dbCon.AddParameters("IN_JEHMNAME", DbType.String, sJEHWAMUL[1]);
                    ds = UP_Data_Change(dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_TANKHWAMUL"));
                }
                else
                {
                    DataTable dt = new DataTable();
                    ds.Tables.Add(dt);
                }
            }
            return ds;
        }
        #endregion

        #region GetLocateTank : 위치별 탱크 리스트 조회
        /// <summary>
        /// 위치별 탱크의 목록을 가져와서 저장한다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public void GetLocateTank(Hashtable ht)
        {
            DataSet ds = new DataSet();
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("IN_TNLOCATE", DbType.String, ht["TNLOCATE"]);
                ds = UP_Data_Change(dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_TANKLOCATE"));

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    dbCon.AddParameters("IN_TKSABUN", DbType.String, Document.UserInfo.EmpID);
                    //dbCon.AddParameters("IN_TKSABUN", DbType.String, "0403-M");
                    dbCon.AddParameters("IN_TKINDEX", DbType.String, i+3);
                    dbCon.AddParameters("IN_TKNO1", DbType.String, ds.Tables[0].Rows[i]["TKNO1"]);
                    dbCon.AddParameters("IN_TKNO2", DbType.String, ds.Tables[0].Rows[i]["TKNO2"]);
                    dbCon.AddParameters("IN_TKNO3", DbType.String, ds.Tables[0].Rows[i]["TKNO3"]);
                    dbCon.AddParameters("IN_TKNO4", DbType.String, ds.Tables[0].Rows[i]["TKNO4"]);
                    dbCon.AddParameters("IN_TKNO5", DbType.String, ds.Tables[0].Rows[i]["TKNO5"]);
                    dbCon.AddParameters("IN_TKNO6", DbType.String, ds.Tables[0].Rows[i]["TKNO6"]);
                    dbCon.AddParameters("IN_TKNO7", DbType.String, ds.Tables[0].Rows[i]["TKNO7"]);
                    dbCon.AddParameters("IN_TKNO8", DbType.String, ds.Tables[0].Rows[i]["TKNO8"]);
                    dbCon.AddParameters("IN_TKNO9", DbType.String, ds.Tables[0].Rows[i]["TKNO9"]);
                    dbCon.AddParameters("IN_TKN10", DbType.String, ds.Tables[0].Rows[i]["TKNO10"]);
                    dbCon.AddParameters("IN_TKGUBN", DbType.String, "A");
                    dbCon.AddParameters("RET_MSG", DbType.String, "");
                    dbCon.ExcuteNonQuery("TYJINFWLIB.UTATKJGF_SET_TANKPAGE");
                }
            }
        }
        #endregion

        #region UP_Data_Change : 화물/위치별 탱크 데이터변환
        private DataSet UP_Data_Change(DataSet ds)
        {
            DataSet Retds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            int iRowCnt = ds.Tables[0].Rows.Count;
            int iPageCnt = 0;
            int iLastCnt = 0;
            int iCnt = 0;

            iPageCnt = Convert.ToInt32(Math.Ceiling(Convert.ToDouble(iRowCnt) / 10));
            iLastCnt = iRowCnt % 10;
            if (iLastCnt > 0)
            {
                iLastCnt = 10 - iLastCnt;
            }
            iRowCnt += iLastCnt;

            string[] sTKNO = new string[iRowCnt];

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                sTKNO[i] = ds.Tables[0].Rows[i]["TNTANKNO"].ToString();
            }

            dt.Columns.Add("TKNO1");
            dt.Columns.Add("TKNO2");
            dt.Columns.Add("TKNO3");
            dt.Columns.Add("TKNO4");
            dt.Columns.Add("TKNO5");
            dt.Columns.Add("TKNO6");
            dt.Columns.Add("TKNO7");
            dt.Columns.Add("TKNO8");
            dt.Columns.Add("TKNO9");
            dt.Columns.Add("TKNO10");

            for (int i = 0; i < iPageCnt; i++)
            {
                row = dt.NewRow();

                row["TKNO1"] = sTKNO[iCnt];
                row["TKNO2"] = sTKNO[iCnt + 1];
                row["TKNO3"] = sTKNO[iCnt + 2];
                row["TKNO4"] = sTKNO[iCnt + 3];
                row["TKNO5"] = sTKNO[iCnt + 4];
                row["TKNO6"] = sTKNO[iCnt + 5];
                row["TKNO7"] = sTKNO[iCnt + 6];
                row["TKNO8"] = sTKNO[iCnt + 7];
                row["TKNO9"] = sTKNO[iCnt + 8];
                row["TKNO10"] = sTKNO[iCnt + 9];

                dt.Rows.Add(row);

                iCnt += 10;
            }
            Retds.Tables.Add(dt);

            return Retds;
        }
        #endregion

        #region GetPageWarnTank : 페이지 알람탱크 리스트 조회
        /// <summary>
        /// 페이지에 저장된 알람이 울리는 탱크의 전체 목록을 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetPageWarnTank(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_TKSABUN", DbType.String, Document.UserInfo.EmpID);
                //dbCon.AddParameters("P_TKSABUN", DbType.String, "0403-M");
                //return UP_PageAlram_Change(dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_TANKPAGEWARN"), "P");
                return dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_TANKPAGEWARN");
            }
        }
        #endregion

        #region UP_PageAlram_Change : 페이지 알람탱크 데이터변환
        private DataSet UP_PageAlram_Change(DataSet ds, string sGubn)
        {

            DataSet Retds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("TNTANKNO");
            dt.Columns.Add("ALRAM");
            dt.Columns.Add("GUBN");

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string sAlram = string.Empty;

                row = dt.NewRow();

                row["TNTANKNO"] = ds.Tables[0].Rows[i]["TNTANKNO"];

                if (ds.Tables[0].Rows[i]["HLGUBN"].ToString() != "")
                {
                    sAlram += ds.Tables[0].Rows[i]["HLGUBN"];
                }
                if (ds.Tables[0].Rows[i]["HTGUBN"].ToString() != "")
                {
                    if (sAlram != "")
                    {
                        sAlram += ",";
                    }
                    sAlram += ds.Tables[0].Rows[i]["HTGUBN"];
                }
                if (ds.Tables[0].Rows[i]["LTGUBN"].ToString() != "")
                {
                    if (sAlram != "")
                    {
                        sAlram += ",";
                    }
                    sAlram += ds.Tables[0].Rows[i]["LTGUBN"];
                }

                row["ALRAM"] = sAlram;
                if (sGubn == "A")
                {
                    row["GUBN"] = ds.Tables[0].Rows[i]["PAGEGUBN"];
                }
                else
                {
                    row["GUBN"] = "";
                }


                dt.Rows.Add(row);
            }
            Retds.Tables.Add(dt);

            return Retds;
        }
        #endregion

        #region GetWarnTank : 전체 알람탱크 리스트 조회
        /// <summary>
        /// 알람이 울리는 탱크의 전체 목록을 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetWarnTank(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("IN_TKSABUN", DbType.String, Document.UserInfo.EmpID);
                dbCon.AddParameters("IN_JALGOIL", DbType.String, ht["JALGOIL"].ToString().Replace("-",""));
                //dbCon.AddParameters("IN_TKSABUN", DbType.String, "0403-M");
                //return UP_Alram_Change(dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_WARNTANK"), "A");
                return UP_Alram_Change(dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_WARNTANK_NEW"));
            }
        }
        #endregion

        #region UP_Alram_Change : 페이지 알람탱크 데이터변환
        private DataSet UP_Alram_Change(DataSet ds)
        {

            DataSet Retds = new DataSet();
            DataTable dt = new DataTable();
            DataRow row;

            dt.Columns.Add("JALTKNO");
            dt.Columns.Add("JALGOIL");
            dt.Columns.Add("JALGOTM");
            dt.Columns.Add("JALGOILTM");
            dt.Columns.Add("JALALRGN");
            dt.Columns.Add("JALALRGNNM");
            dt.Columns.Add("JALSTVALUE");
            dt.Columns.Add("JALNWVALUE");
            dt.Columns.Add("JALCLGOIL");
            dt.Columns.Add("JALCLGOTM");
            dt.Columns.Add("JALCLGOILTM");
            dt.Columns.Add("JALCLVALUE");
            dt.Columns.Add("JALGUBN");
            dt.Columns.Add("JALPGUBN");

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                row = dt.NewRow();

                row["JALTKNO"] = ds.Tables[0].Rows[i]["JALTKNO"];
                row["JALGOIL"] = ds.Tables[0].Rows[i]["JALGOIL"];
                row["JALGOTM"] = ds.Tables[0].Rows[i]["JALGOTM"];
                row["JALGOILTM"] = ds.Tables[0].Rows[i]["JALGOILTM"];
                row["JALALRGN"] = ds.Tables[0].Rows[i]["JALALRGN"];
                row["JALALRGNNM"] = ds.Tables[0].Rows[i]["JALALRGNNM"];
                row["JALSTVALUE"] = ds.Tables[0].Rows[i]["JALSTVALUE"];
                row["JALNWVALUE"] = ds.Tables[0].Rows[i]["JALNWVALUE"];
                row["JALCLGOIL"] = ds.Tables[0].Rows[i]["JALCLGOIL"];
                row["JALCLGOTM"] = ds.Tables[0].Rows[i]["JALCLGOTM"];
                row["JALCLGOILTM"] = ds.Tables[0].Rows[i]["JALCLGOILTM"];
                if (ds.Tables[0].Rows[i]["JALCLGOIL"].ToString() == "")
                {
                    row["JALCLVALUE"] = "";
                }
                else
                {
                    row["JALCLVALUE"] = ds.Tables[0].Rows[i]["JALCLVALUE"];
                }
                row["JALGUBN"] = ds.Tables[0].Rows[i]["JALGUBN"];
                row["JALPGUBN"] = ds.Tables[0].Rows[i]["JALPGUBN"];

                dt.Rows.Add(row);
            }
            Retds.Tables.Add(dt);

            return Retds;
        }
        #endregion

        #region GetPress : 탱크 압력정보를 가져온다
        /// <summary>
        /// 탱크압력정보를 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetPress(Hashtable ht)
        {
            DataSet ds = new DataSet();
            try
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {   
                    ds = dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_PRESS");
                    //ds = dbCon.ExcuteDataSet("TYJINFWLIB.UTATKJGF_GET_PRESS_TEST");
                    
                    return ds;
                }
            }
            catch
            {
                DataTable dt = new DataTable();
                ds.Tables.Add(dt);

                return ds;
            }
        }
        #endregion

        #region SILO BIN 설비정보 가져온다
        /// <summary>
        /// SILO BIN 설비정보 가져온다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetBINSYSTEMCLASS(Hashtable ht)
        {
            DataSet ds = new DataSet();
            try
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    
                    dbCon.AddParameters("IN_LOADGUBN", DbType.String, ht["IN_LOADGUBN"]);
                    dbCon.AddParameters("IN_SDATE", DbType.String, ht["IN_SDATE"]);
                    dbCon.AddParameters("IN_C2SAUP", DbType.String, ht["IN_C2SAUP"]);

                    ds = dbCon.ExcuteDataSet("TYJINFWLIB.BIN_SYSTEM_CLASS");                    

                    return ds;
                }
            }
            catch
            {
                DataTable dt = new DataTable();
                ds.Tables.Add(dt);

                return ds;
            }
        }
        #endregion

        //#region GetLangDataTree - 오라클
        ///// <summary>
        ///// 언어 트리 조회
        ///// </summary>
        /////Transaction(TransactionOption.Required)
        //public DataSet GetLangDataTree(string ProgramId)
        //{
        //    using (DacConnecter dac = new DacConnecter("ORA"))
        //    {
        //        dac.AddParameters("TAKNO", DbType.String, ProgramId);

        //        return dac.ExcuteDataSet("CMN_LANG_TREE_GET");
        //    }
        //}
        //#endregion
    }
}
 