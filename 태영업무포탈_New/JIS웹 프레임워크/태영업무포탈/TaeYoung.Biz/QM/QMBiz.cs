using System;
using System.Collections;
using System.Data;
using JINI.Base;
using JINI.Data;

namespace TaeYoung.Biz.QM
{
    public class QMBiz : BizBase
    {
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

        public DataSet UP_HRCODE(Hashtable ht)
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
                ht["SearchCondition"] = " AND CDINDEX  = '" + ht["SearchCondition"] + "'";
            }

            ht["PageSize"] = "15";

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.UP_HRCODELIST");
            }
        }


        public void HR_INCODEMF_ADD(Hashtable ht, Hashtable[] hts)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                for (int i = 0; i < hts.Length; i++)
                {
                    dbCon.AddParameters("P_CDINDEX", DbType.String, hts[i]["CDINDEX"]);
                    dbCon.AddParameters("P_CDCODE", DbType.String, hts[i]["CDCODE"]);
                    dbCon.AddParameters("P_CDDESC1", DbType.String, hts[i]["CDDESC1"]);

                    dbCon.ExcuteNonQuery("TYJINFWLIB.HR_INCODEMF_ADD");
                }
            }
        }

        public void HR_INCODEMF_DEL(Hashtable ht, Hashtable[] hts)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                for (int i = 0; i < hts.Length; i++)
                {
                    dbCon.AddParameters("P_CDINDEX", DbType.String, hts[i]["CDINDEX"]);
                    dbCon.AddParameters("P_CDCODE", DbType.String, hts[i]["CDCODE"]);

                    dbCon.ExcuteNonQuery("TYJINFWLIB.HR_INCODEMF_DEL");
                }
            }
        }



    }
}
