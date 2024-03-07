using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using System.Data;
using TaeYoung.Common;
using JINI.Data;
using System.Collections;

namespace TaeYoung.Portal.PSM
{
    public partial class PlantsSafetyMonitoring : BasePage
    {
        //public PlantsSafetyMonitoring()
        //{
        //    // 화면 로그인 권한 체크
        //    //this.CheckLogin = false;
        //    this.CheckAuth = false;
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!X.IsAjaxRequest)
            {
                this.dtpETADate.Text = string.Format("{0:yyyy-MM}", DateTime.Today);

                string sDate = string.Format("{0:yyyyMM}", Convert.ToDateTime(this.dtpETADate.Text + "-01"));

                stoPlantUnits.Data = GetUnitData();
                stoPlantUnits.DataBind();

                stoWorkingList.Data = GetWorkingData();
                stoWorkingList.DataBind();

                stoShipList.DataSource = GetShipListData(sDate);
                stoShipList.DataBind();

                stoAmountQty.DataSource = GetAmountData(sDate);
                stoAmountQty.DataBind();
            }
        }

        protected void UpdateMonitoringData(object sender, DirectEventArgs e)
        {
            
            stoWorkingList.RemoveAll();
            stoWorkingList.LoadData(GetWorkingData(), true);
        }

        #region Description : 모니터링 설비 기초데이터 가져오기
        protected object GetUnitData()
        {
            //DataSet ds = null;
            //this.DbConnector.CommandClear();
            ////자산관리 적용전 사용
            ////this.DbConnector.Attach("PS45RG2559", "T");

            ////자산관리 적용후 사용
            //this.DbConnector.Attach("PS648BX771", "S");

            //ds = this.DbConnector.ExecuteDataSet();
            //return ds.Tables[0];
            Hashtable ht = new Hashtable();

            ht["P_SAUP"] = "S";

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_SAUP", DbType.String, ht["P_SAUP"]);
                DataSet ds = db2.ExcuteDataSet("TYJINFWLIB.PSM_Plants_GetUnitData");

                return ds.Tables[0];
            }
        }
        #endregion

        #region Description : 모니터링 작업현황데이터 가져오기
        protected object GetWorkingData()
        {           

            Hashtable ht = new Hashtable();

            ht["P_SAUP"] = "S";

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_SAUP", DbType.String, ht["P_SAUP"]);
                DataSet ds = db2.ExcuteDataSet("TYJINFWLIB.PSM_Plants_GetWorkingData");

                return ds.Tables[0];
            }
        }
        #endregion

        #region Description : 선박입항 현황 데이터 가져오기
        protected DataTable  GetShipListData(string sDate)
        {
            //DataSet ds = null;
            //this.DbConnector.CommandClear();
            ////this.DbConnector.Attach("PS4A2BG123", sDate, sDate, sDate.Substring(0, 4), sDate);
            //this.DbConnector.Attach("PS4A2BG123", sDate, sDate.Substring(0, 4), sDate);
            //ds = this.DbConnector.ExecuteDataSet();

            //return ds.Tables[0];

            Hashtable ht = new Hashtable();

            ht["P_SDATE"] = sDate;
            ht["P_YEAR"] = sDate.Substring(0, 4);
            ht["P_EISDATE"] = sDate;

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_SDATE", DbType.String, ht["P_SDATE"]);
                db2.AddParameters("P_YEAR", DbType.String, ht["P_YEAR"]);
                db2.AddParameters("P_EISDATE", DbType.String, ht["P_EISDATE"]);
                DataSet ds = db2.ExcuteDataSet("TYJINFWLIB.PSM_Plants_GetShipListData");

                return ds.Tables[0];
            }
        }
        #endregion

        #region Description : 작업 실적 데이터 가져오기
        protected DataTable GetAmountData(string sDate)
        {
            //string wkdate = Get_Date(sDate);

            //sDate = string.Format("{0:yyyyMM}", Convert.ToDateTime(wkdate.Substring(0, 4) + "-" + wkdate.Substring(4, 2)).AddMonths(-1));

            //grdTotalTable.Title = "작업물량 집계표(" + sDate.Substring(0, 4) + "년" + sDate.Substring(4,2)+"월)";
            
            //DataSet ds = null;
            //this.DbConnector.CommandClear();
            //this.DbConnector.Attach("PS4A8D4165", sDate);

            //ds = this.DbConnector.ExecuteDataSet();

            //return ds.Tables[0];

            Hashtable ht = new Hashtable();

            ht["P_YYMM"] = sDate;

            using (DB2Connecter db2 = new DB2Connecter("DB2"))
            {
                db2.AddParameters("P_YYMM", DbType.String, ht["P_YYMM"]);
                DataSet ds = db2.ExcuteDataSet("TYJINFWLIB.PSM_PlantsUTT_GetAmountData");

                return ds.Tables[0];
            }
        }
        #endregion


        #region Description : 선박입항 현황 데이터 가져오기
        [DirectMethod]
        public void UP_DateMove(string sDate, string sGubn)
        {
            string wkdate = string.Empty;

            if (sGubn == "2")
            {
                wkdate = string.Format("{0:yyyy-MM}", Convert.ToDateTime(sDate).AddMonths(1));
            }
            else
            {
                wkdate = string.Format("{0:yyyy-MM}", Convert.ToDateTime(sDate).AddMonths(-1));
            }

            sDate = string.Format("{0:yyyy-MM-dd}", Convert.ToDateTime(wkdate + "-01"));

            //선박스케줄 조회           

            DataTable dt = GetShipListData((sDate.Replace("-","")).Substring(0, 6));

            if (dt.Rows.Count > 0)
            {
                this.dtpETADate.Text = string.Format("{0:yyyy-MM}", Convert.ToDateTime(sDate));

                stoShipList.RemoveAll();
                stoShipList.DataSource = dt;
                stoShipList.DataBind();

                stoAmountQty.RemoveAll();
                stoAmountQty.DataSource = GetAmountData(sDate);
                stoAmountQty.DataBind();

            }
            else
            {
                X.MessageBox.Alert("확인", "해당월에 자료가 존재하지 않습니다.").Show();
            }
        }
        #endregion
    }
}