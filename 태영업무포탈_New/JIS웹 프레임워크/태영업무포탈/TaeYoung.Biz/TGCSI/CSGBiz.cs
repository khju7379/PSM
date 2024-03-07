using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JINI.Base;
using System.Data;
using JINI.Data;
using System.Collections;

namespace TaeYoung.Biz.CSG
{
    public class CSGBiz : BizBase
    {
        public DataSet UP_CSG1010_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_SDATE",            DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",            DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TGCSI_CSG1010_LIST");
            }
        }

        public DataSet UP_CSG1010_GETTEXT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_COMPANY",          DbType.String, ht["COMPANY"]);
                dbCon.AddParameters("P_HANGCHA",          DbType.String, ht["HANGCHA"]);
                dbCon.AddParameters("P_GOKJONG",          DbType.String, ht["GOKJONG"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TGCSI_CSG1010_GETTEXT");
            }
        }

        public DataSet UP_CSG1010_DETAIL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_COMPANY",          DbType.String, ht["COMPANY"]);
                dbCon.AddParameters("P_HANGCHA",          DbType.String, ht["HANGCHA"]);
                dbCon.AddParameters("P_GOKJONG",          DbType.String, ht["GOKJONG"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TGCSI_CSG1010_DETAIL");
            }
        }

        public DataSet UP_CSG1010_PRINT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SDATE",   DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",   DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",   DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TGCSI_CSG1010_PRINT");
            }
        }

        public DataSet UP_CSG1020_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_SDATE",            DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",            DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TGCSI_CSG1020_LIST");
            }
        }

        public DataSet UP_CSG1020_DETAIL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_COMPANY",          DbType.String, ht["COMPANY"]);
                dbCon.AddParameters("P_HANGCHA",          DbType.String, ht["HANGCHA"]);
                dbCon.AddParameters("P_GOKJONG",          DbType.String, ht["GOKJONG"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TGCSI_CSG1020_DETAIL");
            }
        }

        public DataSet UP_CSG1020_PRINT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SDATE", DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TGCSI_CSG1020_PRINT");
            }
        }

        public DataSet UP_CSG1030_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                //return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TGCSI_CSG1030_LIST_TEST");
                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TGCSI_CSG1030_LIST");
            }
        }

        public DataSet UP_CSG1040_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_SDATE",            DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",            DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TGCSI_CSG1040_LIST");
            }
        }

        public DataSet UP_CSG1050_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_SDATE",            DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",            DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_YSGUBUN",          DbType.String, ht["YSGUBUN"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TGCSI_CSG1050_LIST");
            }
        }
    }
}
