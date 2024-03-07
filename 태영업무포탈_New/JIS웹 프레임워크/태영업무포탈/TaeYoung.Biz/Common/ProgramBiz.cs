using System.Data;
using TaeYoung.Biz.Type;
using JINI.Base;
using JINI.Data;
using JINI.Data.Transactions;

namespace TaeYoung.Biz.Common
{
    public class ProgramBiz : BizBase
    {
        #region GetProgramID - 현재 페이지의 프로그램ID를 조회
        //[Transaction(TransactionOption.Disabled)]
        public DataSet GetProgramID(string ProgramPath, bool Vend)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PROGRAMPATH", DbType.String, ProgramPath);
                dbCon.AddParameters("P_LANGCODE", DbType.String, Document.ClientCultureName);
                dbCon.AddParameters("P_MENUTYPE", DbType.String, "GP");

                return dbCon.ExcuteDataSet("CMN_PROGRAM_GET");
            }
        }
        #endregion

        #region GetProgramID_EIS - 현재 페이지의 프로그램ID를 조회
        //[Transaction(TransactionOption.Disabled)]
        public DataSet GetProgramID_EIS(string ProgramPath)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_PROGRAMPATH", DbType.String, ProgramPath);
                dbCon.AddParameters("P_LANGCODE", DbType.String, Document.ClientCultureName);
                dbCon.AddParameters("P_MENUTYPE", DbType.String, "EIS");


                return dbCon.ExcuteDataSet("CMN_PROGRAM_GET2");
            }
        }
        #endregion

        #region GetProgramDataTree - 프로그램 트리 조회
        /// <summary>
        /// 프로그램 트리 조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetProgramDataTree(string MenuId)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_MENUID", DbType.String, MenuId);

                return dac.ExcuteDataSet("CMN_PROGRAM_LIST");
            }
        }
        #endregion

        #region AddProgramTree - 프로그램 항목 등록
        /// <summary>
        ///  프로그램 항목 등록
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public void AddProgramTree(ProgramInfo pInfo)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_ProgramId", DbType.String, pInfo.ProgramId);
                dac.AddParameters("P_MenuId", DbType.String, pInfo.MenuId);
                dac.AddParameters("P_ProgramPath", DbType.String, pInfo.ProgramPath);
                dac.AddParameters("P_DESCRIPTION", DbType.String, pInfo.Explanation);

                dac.ExcuteNonQuery("CMN_PROGRAM_ADD");
            }
        }
        #endregion

        #region DeleteProgram - 프로그램을 삭제한다
        /// <summary>
        /// 프로그램을 삭제한다
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public void DeleteProgram(string ProgramId, string MenuId)
        {
            //int CurrentPageIndex, int PageSize
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_PROGRAMID", DbType.String, ProgramId);
                dac.AddParameters("P_MENUID", DbType.String, MenuId);

                dac.ExcuteNonQuery("CMN_PROGRAM_DEL");
            }
        }
        #endregion
    }
}
