using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JINI.Base;
using System.Data;
using JINI.Data;
using System.Collections;

namespace TaeYoung.Biz.CSS
{
    public class CSSBiz : BizBase
    {
        public DataSet UP_CSS1010_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_SDATE",            DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",            DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1010_LIST");
            }
        }

        public DataSet UP_CSS1010_GETTEXT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_HANGCHA",          DbType.String, ht["HANGCHA"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1010_GETTEXT");
            }
        }

        public DataSet UP_CSS1010_DETAIL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_HANGCHA",          DbType.String, ht["HANGCHA"]);
                dbCon.AddParameters("P_GOKJONG",          DbType.String, ht["GOKJONG"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1010_DETAIL");
            }
        }

        public DataSet UP_CSS1010_PRINT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SDATE",   DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",   DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",   DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1010_PRINT");
            }
        }

        public DataSet UP_CSS1020_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1020_LIST");
            }
        }

        public DataSet UP_CSS1030_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_SDATE",            DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",            DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1030_LIST");
            }
        }

        public DataSet UP_CSS1030_DETAIL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_HANGCHA",          DbType.String, ht["HANGCHA"]);
                dbCon.AddParameters("P_GOKJONG",          DbType.String, ht["GOKJONG"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1030_DETAIL");
            }
        }

        public DataSet UP_CSS1030_PRINT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SDATE", DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE", DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1030_PRINT");
            }
        }

        public DataSet UP_CSS1040_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_SDATE",            DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",            DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1040_LIST");
            }
        }

        public DataSet UP_CSS1050_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1050_LIST");
            }
        }

        public DataSet UP_CSS1060_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1060_LIST");
            }
        }

        public DataSet UP_CSS1070_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1070_LIST");
            }
        }

        public DataSet UP_CSS1080_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_SDATE",            DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",            DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1080_LIST");
            }
        }

        public DataSet UP_CSS1090_LIST(Hashtable ht)
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

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1090_LIST");
            }
        }

        public DataSet UP_CSS1100_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_SDATE",            DbType.String, ht["SDATE"]);
                dbCon.AddParameters("P_EDATE",            DbType.String, ht["EDATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS1100_LIST");
            }
        }






        public DataSet UP_CSS2010_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS2010_LIST");
            }
        }

        public DataSet UP_CSS2010_DETAIL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32, ht["PageSize"]);

                dbCon.AddParameters("P_YYMMDD",           DbType.String, ht["YYMMDD"]);
                dbCon.AddParameters("P_HANGCHA",          DbType.String, ht["HANGCHA"]);
                dbCon.AddParameters("P_GOKJONG",          DbType.String, ht["GOKJONG"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_YSDATE",           DbType.String, ht["YSDATE"]);
                dbCon.AddParameters("P_YDHWAJU",          DbType.String, ht["YDHWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS2010_DETAIL");
            }
        }

        public DataSet UP_CSS2010_PRINT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_DATE",  DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS2010_PRINT");
            }
        }

        public DataSet UP_CSS2020_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS2020_LIST");
            }
        }

        public DataSet UP_CSS2020_DETAIL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);

                dbCon.AddParameters("P_HYMCYYMM",         DbType.String, ht["HYMCYYMM"]);
                dbCon.AddParameters("P_HYYYMMDD",         DbType.String, ht["HYYYMMDD"]);
                dbCon.AddParameters("P_HYHANGCHA",        DbType.String, ht["HYHANGCHA"]);
                dbCon.AddParameters("P_HYGOKJONG",        DbType.String, ht["HYGOKJONG"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS2020_DETAIL");
            }
        }

        public DataSet UP_CSS2020_PRINT(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_DATE",  DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU", DbType.String, ht["HWAJU"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS2020_PRINT");
            }
        }

        public DataSet UP_CSS2030_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS2030_LIST");
            }
        }

        public DataSet UP_CSS2040_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS2040_LIST");
            }
        }

        public DataSet UP_CSS2050_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS2050_LIST");
            }
        }

        public DataSet UP_CSS2060_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_HWAJU",            DbType.String, ht["HWAJU"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS2060_LIST");
            }
        }

        public DataSet UP_CSS9000_LIST(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32,  ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE",         DbType.Int32,  ht["PageSize"]);
                dbCon.AddParameters("P_DATE",             DbType.String, ht["DATE"]);
                dbCon.AddParameters("P_GUBUN",            DbType.String, ht["GUBUN"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS9000_LIST");
            }
        }

        public DataSet UP_CSS9000_EIS_SEARCH(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_JUNYYMM", DbType.String, ht["P_JUNYYMM"]);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SP_TYCSS_CSS9000_EIS_SEARCH");
            }
        }
    }
}
