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
    public class PSM4061 : BizBase
    {

        #region Description : 외주공사 확인
        public DataSet UP_PSM_OUTSIDECONSTRUCT_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_OSDATE", DbType.String, ht["P_OSDATE"]);
                dbCon.AddParameters("P_OSSEQ", DbType.Int32, ht["P_OSSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_OUTSIDECONSTRUCT_RUN");
            }
        }
        #endregion

        #region Description : 외주공사 등록
        public void UP_PSM_OUTSIDECONSTRUCT_ADD(Hashtable ht, Hashtable[] hts )
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //최초 등록일 경우
                if( Convert.ToInt32(ht["P_OSSEQ"]) <= 0 )
                {
                    dbCon.AddParameters("P_OSDATE", DbType.String, ht["P_OSDATE"]);
                    DataSet ds = dbCon.ExcuteDataSet("PSSCMLIB.PSM_OUTSIDECONSTRUCT_SEQ");
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ht["P_OSSEQ"] = ds.Tables[0].Rows[0]["OSSEQ"].ToString();
                    }
                }                

                dbCon.AddParameters("P_OSDATE", DbType.String, ht["P_OSDATE"]);
                dbCon.AddParameters("P_OSSEQ", DbType.Int32, ht["P_OSSEQ"]);
                dbCon.AddParameters("P_OSLOCATIONCODE1", DbType.String, ht["P_OSLOCATIONCODE1"]);
                dbCon.AddParameters("P_OSAREACODE1", DbType.String, ht["P_OSAREACODE1"]);
                dbCon.AddParameters("P_OSLOCATIONCODE2", DbType.String, ht["P_OSLOCATIONCODE2"]);
                dbCon.AddParameters("P_OSAREACODE2", DbType.String, ht["P_OSAREACODE2"]);
                dbCon.AddParameters("P_OSLOCATIONCODE3", DbType.String, ht["P_OSLOCATIONCODE3"]);
                dbCon.AddParameters("P_OSAREACODE3", DbType.String, ht["P_OSAREACODE3"]);
                dbCon.AddParameters("P_OSLOCATIONCODE4", DbType.String, ht["P_OSLOCATIONCODE4"]);
                dbCon.AddParameters("P_OSAREACODE4", DbType.String, ht["P_OSAREACODE4"]);
                dbCon.AddParameters("P_OSLOCATIONCODE5", DbType.String, ht["P_OSLOCATIONCODE5"]);
                dbCon.AddParameters("P_OSAREACODE5", DbType.String, ht["P_OSAREACODE5"]);
                dbCon.AddParameters("P_OSMETHODCODE", DbType.String, ht["P_OSMETHODCODE"]);
                dbCon.AddParameters("P_OSCOMPANY", DbType.String, ht["P_OSCOMPANY"]);
                dbCon.AddParameters("P_OSBUSEO", DbType.String, ht["P_OSBUSEO"]);
                dbCon.AddParameters("P_OSSABUN", DbType.String, ht["P_OSSABUN"]);
                dbCon.AddParameters("P_OSWKSDATE", DbType.String, ht["P_OSWKSDATE"]);
                dbCon.AddParameters("P_OSWKEDATE", DbType.String, ht["P_OSWKEDATE"]);
                dbCon.AddParameters("P_OSWKCLOSE", DbType.String, ht["P_OSWKCLOSE"]);
                dbCon.AddParameters("P_OSWKCLDATE", DbType.String, ht["P_OSWKCLDATE"]);
                dbCon.AddParameters("P_OSHISAB", DbType.String, Document.UserInfo.EmpID);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_OUTSIDECONSTRUCT_ADD");
            }

            UP_PSM_OUTSIDECONSTRUCT_WKCODE_DEL(ht);

            UP_PSM_OUTSIDECONSTRUCT_WKCODE_ADD(ht, hts);

        }
        #endregion

        #region Description : 외주공사 삭제
        public void UP_PSM_OUTSIDECONSTRUCT_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_OSDATE", DbType.String, ht["P_OSDATE"]);
                dbCon.AddParameters("P_OSSEQ", DbType.Int32, ht["P_OSSEQ"]);

                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_OUTSIDECONSTRUCT_DEL");
            }

            UP_PSM_OUTSIDECONSTRUCT_WKCODE_DEL(ht);
        }
        #endregion

        #region Description : 외주공사 작업내용 등록
        public void UP_PSM_OUTSIDECONSTRUCT_WKCODE_ADD(Hashtable ht, Hashtable[] hts)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                for (int i = 0; i < hts.Length; i++)
                {
                    dbCon.AddParameters("P_OSWKDATE", DbType.String, ht["P_OSDATE"]);
                    dbCon.AddParameters("P_OSWKSEQ", DbType.Int32, ht["P_OSSEQ"]);
                    dbCon.AddParameters("P_OSWKCODE", DbType.String, hts[i]["P_OSWKCODE"]);
                    dbCon.AddParameters("P_OSWKNAME", DbType.String, hts[i]["P_OSWKNAME"]);
                    dbCon.AddParameters("P_OSRISKRATE", DbType.String, "");
                    dbCon.AddParameters("P_OSCHECKGN", DbType.String, "Y");
                    dbCon.AddParameters("P_OSWKHISAB", DbType.String, Document.UserInfo.EmpID);

                    dbCon.ExcuteNonQuery("PSSCMLIB.PSM_OutSideConstruct_WKCODE_ADD");
                }
            }
        }
        #endregion

        #region Description : 외주공사 작업내용 삭제
        public void UP_PSM_OUTSIDECONSTRUCT_WKCODE_DEL(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_OSWKDATE", DbType.String, ht["P_OSDATE"]);
                dbCon.AddParameters("P_OSWKSEQ", DbType.Int32, ht["P_OSSEQ"]);
                
                dbCon.ExcuteNonQuery("PSSCMLIB.PSM_OutSideConstruct_WKCODE_DEL");
            }
        }
        #endregion
        

        #region Description : 외주공사 확인
        public DataSet UP_PSM_OUTSIDECONSTRUCT_WKCODE_RUN(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_OSWKDATE", DbType.String, ht["P_OSWKDATE"]);
                dbCon.AddParameters("P_OSWKSEQ", DbType.Int32, ht["P_OSWKSEQ"]);

                return dbCon.ExcuteDataSet("PSSCMLIB.PSM_OutSideConstruct_WKCODE_RUN");
            }
        }
        #endregion


    }
}