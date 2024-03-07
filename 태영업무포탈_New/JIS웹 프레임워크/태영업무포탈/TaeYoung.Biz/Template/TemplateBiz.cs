using System;
using System.Collections;
using System.Data;
using JINI.Base;
using JINI.Data;
using System.Threading;

using System.Collections.Generic;

namespace TaeYoung.Biz.Template
{
    /// <summary>
    /// 공통코드 비지니스 로직
    /// </summary>
    public class TemplateBiz : BizBase
    {
        #region ListTempete - 템플릿 리스트를 가져온다.
        /// <summary>
        /// 템플릿 리스트를 가져온다.
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet ListTemplate(Hashtable ht)
        {

            //Document.UserInfo.EmpID
            //ht["a"] = "1";
            if (ht["CurrentPageIndex"] == null)
            {
                ht["CurrentPageIndex"] = 1;
            }
            if (ht["PageSize"] == null)
            {
                ht["PageSize"] = 20;
            }
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = "";
            }
            else
            {
                ht["SearchCondition"] = " AND COLUMNS1 LIKE '%" + ht["SearchCondition"] + "%'";
            }

            ht["PageSize"] = "15";

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                return dbCon.ExcuteDataSet("TEMPLATE01_LIST");
            }
        }
        #endregion

        public DataSet ListTemplatePaging(Hashtable ht)
        {
            //ht[""] = "";
            if (ht["CurrentPageIndex"] == null)
            {
                ht["CurrentPageIndex"] = 1;
            }
            if (ht["PageSize"] == null)
            {
                ht["PageSize"] = 20;
            }
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = "";
            }
            else
            {
                ht["SearchCondition"] = " AND COLUMNS1 LIKE '%" + ht["SearchCondition"] + "%'";
            }

            ht["PageSize"] = "15";

            DataSet ds = new DataSet();

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                ds = dbCon.ExcuteDataSet("TEMPLATE01_LIST");
            }

            ds.Tables[1].Rows[0][0] = 140;

            //DataSet ds = new DataSet();
            //// db데이터
            //DataRow dr = ds.Tables[0].NewRow();
            //foreach(DataColumn dc in ds.Tables[0].Columns)
            //{
            //    dr[dc.ColumnName] = "";
            //}
            //ds.Tables[0].Rows.InsertAt(dr, 3);


            //ds.Tables[1].Rows.InsertAt()

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                dr["COLUMNS9"] = "20170101";
            }

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                dr["COLUMNS8"] = 1234567.1234567;
            }

            return ds;

            //DataSet ds2 = new DataSet();

            //DataTable dt = ds.Tables[0].Copy();
            //for (int aa = 0; aa < 100; aa++)
            //{
            //    foreach (DataRow dr in ds.Tables[0].Rows)
            //    {
            //        DataRow dr_new = dt.NewRow();

            //        for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
            //        {
            //            dr_new[ds.Tables[0].Columns[i].ToString()] = dr[ds.Tables[0].Columns[i].ToString()];
            //        }
            //        dt.Rows.Add(dr_new);
            //    }
            //}

            //ds2.Tables.Add(dt);

            //return ds2;
        }


        public DataSet GetTest(Hashtable ht)
        {
           
            DataSet ds = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("TEST");

            DataRow dr = dt.NewRow();

            dr["TEST"] = ht["TEST"];

            dt.Rows.Add(dr);

            ds.Tables.Add(dt);

            return ds;
        }


        public DataSet GetTest2(Hashtable ht, Hashtable[] hts)
        {
            //foreach
            DataSet ds = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("TEST");

            DataRow dr = dt.NewRow();

            dr["TEST"] = ht["TEST"];

            dt.Rows.Add(dr);

            ds.Tables.Add(dt);

            return ds;
        }

        #region GetTemplate - 템플릿 정보를 가져온다.
        /// <summary>
        /// 템플릿 정보를 가져온다.
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetTemplate(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_IDX", DbType.Int32, ht["IDX"]);

                return dbCon.ExcuteDataSet("TEMPLATE01_GET");
            }
        }
        #endregion


        #region AddTemplate - 템플릿 정보를 입력한다.
        /// <summary>
        /// 템플릿 정보를 입력한다.
        /// </summary>
        /// <param name="ht"></param>
        //[Transaction(TransactionOption.Required)]
        public void AddTemplate(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_IDX", DbType.Int32, ht["IDX"]);
                dbCon.AddParameters("P_COLUMNS1", DbType.String, ht["COLUMNS1"]);
                dbCon.AddParameters("P_COLUMNS2", DbType.String, ht["COLUMNS2"]);
                dbCon.AddParameters("P_COLUMNS3", DbType.String, ht["COLUMNS3"]);
                dbCon.AddParameters("P_COLUMNS4", DbType.String, ht["COLUMNS4"]);
                dbCon.AddParameters("P_COLUMNS5", DbType.String, ht["COLUMNS5"]);
                dbCon.AddParameters("P_COLUMNS6", DbType.String, ht["COLUMNS6"]);
                dbCon.AddParameters("P_COLUMNS7", DbType.String, ht["COLUMNS7"]);
                dbCon.AddParameters("P_COLUMNS8", DbType.String, ht["COLUMNS8"]);
                dbCon.AddParameters("P_COLUMNS9", DbType.String, ht["COLUMNS9"]);

                dbCon.ExcuteNonQuery("TEMPLATE01_ADD");
            }
        }
        #endregion    
 
        #region RemoveTemplate - 템플릿 정보를 삭제한다.
        /// <summary>
        /// 템플릿 정보를 삭제한다.
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet RemoveTemplate(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_IDX", DbType.Int32, ht["IDX"]);

                return dbCon.ExcuteDataSet("NVHTLIB.TEMPLETE10D1");
            }
        }
        #endregion

        #region GetChart - 차트에 가상 데이터를 가져온다.
        /// <summary>
        /// 차트에 가상 데이터를 가져온다.
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetChart(Hashtable ht)
        {
            Random r = new Random();

            DataSet ds = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("V1", typeof(int));
            dt.Columns.Add("V2", typeof(int));
            dt.Columns.Add("V3", typeof(int));
            dt.Columns.Add("V4", typeof(int));
            dt.Columns.Add("V5", typeof(int));

            DataRow dr = dt.NewRow();

            dr["V1"] = r.Next(10, 20);
            dr["V2"] = r.Next(10, 20);
            dr["V3"] = r.Next(10, 20);
            dr["V4"] = r.Next(10, 20);
            dr["V5"] = r.Next(10, 20);

            dt.Rows.Add(dr);

            DataRow dr2 = dt.NewRow();

            dr2["V1"] = r.Next(10, 20);
            dr2["V2"] = r.Next(10, 20);
            dr2["V3"] = r.Next(10, 20);
            dr2["V4"] = r.Next(10, 20);
            dr2["V5"] = r.Next(10, 20);

            dt.Rows.Add(dr2);

            ds.Tables.Add(dt);

            //Thread.Sleep(3000);

            return ds;
        } 
        #endregion



        public DataSet MultiDataInsert(Hashtable ht, Hashtable[] hts)
        {


            return null;

            //// 전체 권한 삭제
            //using (DB2Connecter dac = new DB2Connecter("DB2"))
            //{
            //    dac.AddParameters("P_ACL_GRP", DbType.String, hts[0]["ACL_GRP"]);
            //    dac.ExcuteDataSet("NVHTLIB.PTCMMBAS10D1");
            //}
        }

        public DataSet MultiDataDelete(Hashtable ht, Hashtable[] hts)
        {
            return null;

            //// 전체 권한 삭제
            //using (DB2Connecter dac = new DB2Connecter("DB2"))
            //{
            //    dac.AddParameters("P_ACL_GRP", DbType.String, hts[0]["ACL_GRP"]);
            //    dac.ExcuteDataSet("NVHTLIB.PTCMMBAS10D1");
            //}
        }

        public void PTCMMBAS70_UPDATE_EXCEL_TEMP(Hashtable ht)
        {
            //int CurrentPageIndex, int PageSize
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_CODE", DbType.String, ht["CODE"]);
                dbCon.AddParameters("P_PCODE", DbType.String, ht["PCODE"]);
                dbCon.AddParameters("P_CODTXT_EN", DbType.String, ht["CODTXT_EN"]);
                dbCon.AddParameters("P_CODTXT_ZH", DbType.String, ht["CODTXT_ZH"]);
                dbCon.AddParameters("P_CODTXT_RU", DbType.String, ht["CODTXT_RU"]);

                dbCon.ExcuteNonQuery("NVHTLIB.PTCMMBAS70_UPDATE_EXCEL_TEMP");
            }
        }


        
    }
}
