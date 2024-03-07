using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;

using JINI.Base;
using JINI.Base.Configuration;
using JINI.Base.Security;
using JINI.Data;
using System;

namespace TaeYoung.Biz.Portal
{
    public class MenuBiz : BizBase
    {
        private static string _connectionString = "DB2";

        #region GetMenuId - 메뉴아이디 중복 검사
        /// <summary>
        /// 메뉴아이디 중복 검사
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuId(string MenuId)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_MENUID", DbType.String, MenuId);

                return dac.ExcuteDataSet("NVHTLIB.PTCMMBAS40S1");
            }
        }
        #endregion

        #region GetMenuDataTree - 메뉴 트리 조회
        /// <summary>
        /// 메뉴 트리 조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuDataTree(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                return dac.ExcuteDataSet("CMN_MENU_TREE_GET");
            }
        }
        #endregion

        #region AddMenuTree - 메뉴 항목 등록
        ///// <summary>
        /////  메뉴 항목 등록
        ///// </summary>
        ////[Transaction(TransactionOption.Required)]
        public void AddMenuTree(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);
                dac.AddParameters("P_HIGHRANKID", DbType.String, ht["HIGHRANKID"]);
                dac.AddParameters("P_DISPLAYYN", DbType.String, ht["DISPLAYYN"]);
                dac.AddParameters("P_IPYN", DbType.String, ht["IPYN"]);
                dac.AddParameters("P_KO", DbType.String, ht["KO"]);
                dac.AddParameters("P_EN", DbType.String, ht["EN"]);
                dac.AddParameters("P_CN", DbType.String, ht["CN"]);
                dac.AddParameters("P_RU", DbType.String, ht["RU"]);
                dac.AddParameters("P_SORTNO", DbType.Int32, ht["SORTNO"].ToString() == "" ? 0 : JINI.Util.ConvertType.ToInt32(ht["SORTNO"]));
                dac.AddParameters("P_MENUTYPE", DbType.String, ht["MENUTYPE"]);

                dac.ExcuteNonQuery("CMN_MENU_ADD");
            }
        }
        #endregion

        #region AddMenuAcl - 메뉴 권한 입력
        /// <summary>
        /// 메뉴 권한 입력
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public static DataSet AddMenuAcl(Hashtable tmp, Hashtable[] hts)
        {
            if (hts.Length > 0)
            {
                //// 전체 권한 삭제
                using (DB2Connecter dac = new DB2Connecter(_connectionString))
                {
                    dac.AddParameters("P_ACL_GRP", DbType.String, hts[0]["ACL_GRP"]);
                    dac.ExcuteDataSet("NVHTLIB.PTCMMBAS10D1");
                }
                using (DB2Connecter dac = new DB2Connecter(_connectionString))
                {
                    dac.AddParameters("P_ACL_GRP", DbType.String, hts[0]["ACL_GRP"]);
                    dac.ExcuteDataSet("NVHTLIB.PTCMMBAS10D1");
                }
                //// 선택 권한 입력
                foreach (Hashtable ht in hts)
                {
                    using (DB2Connecter dac = new DB2Connecter(_connectionString))
                    {
                        dac.AddParameters("P_ACL_ID", DbType.String, ht["ACL_ID"]);
                        dac.AddParameters("P_ACL_GRP", DbType.String, ht["ACL_GRP"]);
                        dac.ExcuteNonQuery("NVHTLIB.PTCMMBAS10I1");
                    }
                    using (DB2Connecter dac = new DB2Connecter(_connectionString))
                    {
                        dac.AddParameters("P_ACL_ID", DbType.String, ht["ACL_ID"]);
                        dac.AddParameters("P_ACL_GRP", DbType.String, ht["ACL_GRP"]);
                        dac.ExcuteNonQuery("NVHTLIB.PTCMMBAS10I1");
                    }
                }
            }

            return null;
        }
        #endregion

        #region AddMenuGrpAcl - 메뉴 권한 입력 (메뉴별)
        /// <summary>
        /// 메뉴 권한 입력 (메뉴별)
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public static DataSet AddMenuGrpAcl(Hashtable tmp, Hashtable[] hts)
        {
            if (hts.Length > 0)
            {
                //// 그룹 권한 삭제
                using (DB2Connecter dac = new DB2Connecter(_connectionString))
                {
                    dac.AddParameters("P_ACL_ID", DbType.String, hts[0]["ACL_ID"]);
                    dac.ExcuteDataSet("NVHTLIB.PTCMMBAS10D2");
                }
                using (DB2Connecter dac = new DB2Connecter(_connectionString))
                {
                    dac.AddParameters("P_ACL_ID", DbType.String, hts[0]["ACL_ID"]);
                    dac.ExcuteDataSet("NVHTLIB.PTCMMBAS10D2");
                }
                //// 선택 권한 입력
                foreach (Hashtable ht in hts)
                {
                    using (DB2Connecter dac = new DB2Connecter(_connectionString))
                    {
                        dac.AddParameters("P_ACL_ID", DbType.String, ht["ACL_ID"]);
                        dac.AddParameters("P_ACL_GRP", DbType.String, ht["ACL_GRP"]);
                        dac.ExcuteNonQuery("NVHTLIB.PTCMMBAS10I1");
                    }
                    using (DB2Connecter dac = new DB2Connecter(_connectionString))
                    {
                        dac.AddParameters("P_ACL_ID", DbType.String, ht["ACL_ID"]);
                        dac.AddParameters("P_ACL_GRP", DbType.String, ht["ACL_GRP"]);
                        dac.ExcuteNonQuery("NVHTLIB.PTCMMBAS10I1");
                    }
                }
            }

            return null;
        }
        #endregion

        #region DeleteMenu - 메뉴를 삭제한다
        /// <summary>
        /// 메뉴를 삭제한다
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public void DeleteMenu(Hashtable ht)
        {
            //int CurrentPageIndex, int PageSize
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);

                dac.ExcuteNonQuery("CMN_MENU_DEL");
            }
        }
        #endregion

        #region GetMenuCombo - 메뉴 목록 콤보
        /// <summary>
        /// 메뉴 목록 콤보
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuCombo(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {

                return dac.ExcuteDataSet("CMN_MENU_COMBO_GET");
            }
        }
        #endregion

        #region GetMenuSearchTree - 메뉴 검색 목록
        /// <summary>
        /// 메뉴 검색 목록
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuSearchTree(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);

                return dac.ExcuteDataSet("CMN_MENU_SEARCH_GET");
            }
        }
        #endregion

        #region GetMenuAcl - 메뉴 트리 조회(권한지정용)
        /// <summary>
        /// 메뉴 트리 조회(권한지정용)
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public static DataSet GetMenuAcl(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                return dac.ExcuteDataSet("NVHTLIB.PTCMMBAS40L3");
            }
        }
        #endregion

        #region GetMenuSubData - 좌측메뉴 트리조회
        /// <summary>
        /// 좌측메뉴 트리조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuSubData(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                //dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);
                //dac.AddParameters("P_EMPID", DbType.String, ((UserInfo)ht["UserInfo"]).EmpID);
                //dac.AddParameters("P_COMPANYCODE", DbType.String, ((UserInfo)ht["UserInfo"]).CompanyCode);
                //dac.AddParameters("P_LANGCODE", DbType.String, ((UserInfo)ht["UserInfo"]).ClientCultureName);

                return dac.ExcuteDataSet("NVHTLIB.PTCMMBAS40L4");
            }
        }
        #endregion

        #region GetVisitMenuSubData - 출입관리 좌측메뉴 트리조회
        /// <summary>
        /// 출입관리 좌측메뉴 트리조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetVisitMenuSubData(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);

                return dac.ExcuteDataSet("NVHTLIB.PTCMMBAS40L5");
            }
        }
        #endregion

        #region GetMenuAclByGrp - 메뉴 트리 조회(권한체크용)
        /// <summary>
        /// 메뉴 트리 조회(권한체크용)
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public static DataSet GetMenuAclByGrp(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                return dac.ExcuteDataSet("NVHTLIB.PTCMMBAS40S3");
            }
        }
        #endregion


        #region DupMenuProgamID - 메뉴 / 프로그램 ID 중복 체크
        public DataSet DupMenuProgamID(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);
                dac.AddParameters("P_CHK_DIV", DbType.String, ht["CHK_DIV"]);

                return dac.ExcuteDataSet("CMN_MENU_IDCHK_GET");
            }
        } 
        #endregion







        #region GetProgramDataTree - 프로그램 트리 조회
        /// <summary>
        /// 프로그램 트리 조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetProgramDataTree(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);

                return dac.ExcuteDataSet("CMN_PROGRAM_LIST");
            }
        }
        #endregion

        #region AddProgramTree - 프로그램 항목 등록
        /// <summary>
        ///  프로그램 항목 등록
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public void AddProgramTree(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);
                dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);
                dac.AddParameters("P_PROGRAMPATH", DbType.String, ht["PROGRAMPATH"]);
                dac.AddParameters("P_DESCRIPTION", DbType.String, ht["DESCRIPTION"]);
                dac.AddParameters("P_POPUP", DbType.String, ht["POPUP"]);
                dac.AddParameters("P_POPUP_SIZE", DbType.String, ht["POPUP_SIZE"]);
                dac.AddParameters("P_MENUTYPE", DbType.String, ht["MENUTYPE"]);

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
        public void DeleteProgram(Hashtable ht)
        {
            //int CurrentPageIndex, int PageSize
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);
                dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);

                dac.ExcuteNonQuery("CMN_PROGRAM_DEL");
            }
        }
        #endregion











        #region GetLangDataTree - 언어 트리 조회
        /// <summary>
        /// 언어 트리 조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetLangDataTree(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);

                return dac.ExcuteDataSet("CMN_LANG_TREE_GET");
            }
        }
        #endregion

        #region AddLang - 다국어 등록
        /// <summary>
        ///  다국어 등록
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public void AddLang(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);
                dac.AddParameters("P_CODE", DbType.String, ht["CODE"]);
                dac.AddParameters("P_KO", DbType.Object, ht["KO"]);
                dac.AddParameters("P_EN", DbType.Object, ht["EN"]);
                dac.AddParameters("P_ZH", DbType.Object, ht["ZH"]);
                dac.AddParameters("P_RU", DbType.Object, ht["RU"]);

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
        public void DeleteLang(Hashtable ht)
        {
            //int CurrentPageIndex, int PageSize
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_CODE", DbType.String, ht["CODE"]);                // 코드
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);      // 프로그램아이디

                dac.ExcuteNonQuery("CMN_LANG2_DEL");
            }
        }
        #endregion

        #region RemoveLang - 다국어 삭제
        /// <summary>
        ///  다국어 삭제
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public void RemoveLang(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter(_connectionString))
            {
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);

                dac.ExcuteNonQuery("CMN_LANG_DEL");
            }
        }
        #endregion
    }
}
