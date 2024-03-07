using System.Collections;
using System.Data;
using TaeYoung.Biz.Type;
using JINI.Base;
using JINI.Data;
using JINI.Data.Transactions;

namespace TaeYoung.Biz.Common
{
    /// <summary>
    /// 다국어 처리관련 비지니스 로직
    /// </summary>
    public class LangBiz : BizBase
    {
        #region GetLangDataTree - 언어 트리 조회
        /// <summary>
        /// 언어 트리 조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetLangDataTree(string ProgramId)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_PROGRAMID", DbType.String, ProgramId);

                return dac.ExcuteDataSet("CMN_LANG_TREE_GET");
            }
        }
        #endregion

        #region AddLangTree - 언어 항목 등록
        /// <summary>
        ///  언어 항목 등록
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public void AddLangTree(LangInfo pInfo)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_PROGRAMID", DbType.String, pInfo.ProgramId);
                dac.AddParameters("P_CODE", DbType.String, pInfo.Code);
                dac.AddParameters("P_KO", DbType.String, pInfo.Ko);
                dac.AddParameters("P_EN", DbType.String, pInfo.En);
                dac.AddParameters("P_ZH", DbType.String, pInfo.Zh);
                dac.AddParameters("P_RU", DbType.String, pInfo.Ru);

                dac.ExcuteNonQuery("CMN_LANG_ADD");
            }
        }
        #endregion

        #region DeleteLang - 다국어를 삭제한다
        /// <summary>
        /// 다국어를 삭제한다
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public void DeleteLang(string Code, string ProgramId)
        {
            //int CurrentPageIndex, int PageSize
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_CODE", DbType.String, Code);                // 코드
                dac.AddParameters("P_PROGRAMID", DbType.String, ProgramId);      // 프로그램아이디

                dac.ExcuteNonQuery("CMN_LANG2_DEL");
            }
        }
        #endregion

        #region GetLangCode - 다국어 코드로 해당 문자 조회
        /// <summary>
        /// 다국어 코드로 해당 문자 조회
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Disabled)]
        public DataSet GetLangCode(string programid, string langCode, string country)
        {
            //int CurrentPageIndex, int PageSize
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                // 세션값 확인 예제
                //System.Web.SessionState.HttpSessionState session = ht["session"] as System.Web.SessionState.HttpSessionState;

                dac.AddParameters("P_PROGRAMID", DbType.String, programid);
                //dac.AddParameters("P_CODE", DbType.String, langCode);
                dac.AddParameters("P_LANGCODE", DbType.String, country.ToUpper());

                return dac.ExcuteDataSet("CMN_LANG_GET");
            }
        }
        #endregion

        #region GetLangCodeScript - 다국어 코드로 해당 문자 조회(스크립트호출)
        /// <summary>
        /// 다국어 코드로 해당 문자 조회(스크립트호출)
        /// </summary>
        /// <returns></returns>
        [Transaction(TransactionOption.Disabled)]
        public static DataSet GetLangCodeScript(Hashtable ht)
        {
            //int CurrentPageIndex, int PageSize
            using (DacConnecter dbCon = new DacConnecter("Portal"))
            {
                dbCon.AddParameters("@CODE", DbType.String, "'" + ht["langCode"] + "'"); // CS와 같은 프로시져를 사용하기 위하여 값을 '' 로 감쌈
                dbCon.AddParameters("@LANGCODE", DbType.String, ht["country"]);

                return dbCon.ExcuteDataSet("SP_LANG_CODE_SELECT");
            }
        }
        #endregion

        #region AddLang - 다국어 등록
        /// <summary>
        ///  다국어 등록
        /// </summary>
        [Transaction(TransactionOption.Required)]
        public void AddLang(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                string en = ht["en"] == null ? "" : ht["en"].ToString();
                string cn = ht["cn"] == null ? "" : ht["cn"].ToString();
                string cz = ht["cz"] == null ? "" : ht["cz"].ToString();

                dac.AddParameters("P_PROGRAMID", DbType.String, ht["programid"]);
                dac.AddParameters("P_CODE", DbType.String, ht["code"]);
                dac.AddParameters("P_KO", DbType.String, ht["ko"]);
                dac.AddParameters("P_EN", DbType.String, en);
                dac.AddParameters("P_ZH", DbType.String, cn);
                dac.AddParameters("P_RU", DbType.String, cz);

                dac.ExcuteNonQuery("CMN_LANG_ADD");
            }
        }
        #endregion

        #region RemoveLang - 다국어 삭제
        /// <summary>
        ///  다국어 삭제
        /// </summary>
        [Transaction(TransactionOption.Required)]
        public void RemoveLang(string programid)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_PROGRAMID", DbType.String, programid);

                dac.ExcuteNonQuery("CMN_LANG_DEL");
            }
        }
        #endregion
    }
}