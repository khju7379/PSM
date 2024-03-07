using System.Collections;
using System.Data;
using TaeYoung.Biz.Type;
using JINI.Base;
using JINI.Data;
using JINI.User;

namespace TaeYoung.Biz.Common
{
    public class MenuBiz : BizBase
    {
        #region GetMenuId - 메뉴아이디 중복 검사
        /// <summary>
        /// 메뉴아이디 중복 검사
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuId(string MenuId)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_MENUID", DbType.String, MenuId);

                return dac.ExcuteDataSet("CMN_MENU_IDCHK_GET");
            }
        }
        #endregion

        #region GetMenuDataTree - 메뉴 트리 조회
        /// <summary>
        /// 메뉴 트리 조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuDataTree()
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                return dac.ExcuteDataSet("CMN_MENU_TREE_GET");
            }
        }
        #endregion

        #region GetCMN_MENU_TREE_PPT_GET - 메뉴 트리 조회 : 메뉴얼 등록 PPT 조회용
        //[Transaction(TransactionOption.Required)]
        public DataSet GetCMN_MENU_TREE_PPT_GET(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_PROGRAMID", DbType.String, ht["PROGRAMID"]);
                return dac.ExcuteDataSet("CMN_MENU_TREE_PPT_GET");
            }
        }
        #endregion

        //#region AddMenuTree - 메뉴 항목 등록
        ///// <summary>
        /////  메뉴 항목 등록
        ///// </summary>
        ////[Transaction(TransactionOption.Required)]
        //public void AddMenuTree(MenuInfo mInfo)
        //{
        //    using (DB2Connecter dac = new DB2Connecter("DB2"))
        //    {
        //        dac.AddParameters("P_MenuId", DbType.String, mInfo.MenuId);
        //        dac.AddParameters("P_ProgramId", DbType.String, mInfo.ProgramId);
        //        dac.AddParameters("P_HighRankId", DbType.String, mInfo.HighRankId);
        //        dac.AddParameters("P_DisplayYN", DbType.Int32, mInfo.DisplayYN);
        //        dac.AddParameters("P_IPYN", DbType.String, mInfo.IPYN);
        //        dac.AddParameters("P_KO", DbType.String, mInfo.Ko);
        //        dac.AddParameters("P_EN", DbType.String, mInfo.En);
        //        dac.AddParameters("P_CN", DbType.String, mInfo.Cn);
        //        dac.AddParameters("P_RU", DbType.String, mInfo.Ru);
        //        dac.AddParameters("P_SORTNO", DbType.String, mInfo.Sortno);
        //        dac.AddParameters("P_MENUTYPE", DbType.String, mInfo.Menutype);

        //        dac.ExcuteNonQuery("CMN_MENU_ADD");
        //    }
        //}
        //#endregion

        #region AddMenuTree - 메뉴 항목 등록
        ///// <summary>
        /////  메뉴 항목 등록
        ///// </summary>
        ////[Transaction(TransactionOption.Required)]
        public void AddMenuTree(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
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
                using (DB2Connecter dac = new DB2Connecter("DB2"))
                {
                    dac.AddParameters("P_ACL_GRP", DbType.String, hts[0]["ACL_GRP"]);
                    dac.ExcuteDataSet("CMN_ACL_DEL");
                }
                using (DB2Connecter dac = new DB2Connecter("DB2"))
                {
                    dac.AddParameters("P_ACL_GRP", DbType.String, hts[0]["ACL_GRP"]);
                    dac.ExcuteDataSet("CMN_ACL_DEL");
                }
                //// 선택 권한 입력
                foreach (Hashtable ht in hts)
                {
                    using (DB2Connecter dac = new DB2Connecter("DB2"))
                    {
                        dac.AddParameters("P_ACL_ID", DbType.String, ht["ACL_ID"]);
                        dac.AddParameters("P_ACL_GRP", DbType.String, ht["ACL_GRP"]);
                        dac.ExcuteNonQuery("CMN_ACL_ADD");
                    }
                    using (DB2Connecter dac = new DB2Connecter("DB2"))
                    {
                        dac.AddParameters("P_ACL_ID", DbType.String, ht["ACL_ID"]);
                        dac.AddParameters("P_ACL_GRP", DbType.String, ht["ACL_GRP"]);
                        dac.ExcuteNonQuery("CMN_ACL_ADD");
                    }
                }
            }

            return null;
        }
        #endregion

        #region AddERPGrantAcl - 메뉴 권한 등록
        /// <summary>
        /// 메뉴 권한 등록
        /// </summary>
        /// <param name="ht"></param>
        public void AddERPGrantAcl(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_ACL_ID", DbType.String, ht["ACL_ID"]);
                dac.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);
                dac.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dac.ExcuteNonQuery("CMN_ACL_ERP_GRANT_ADD");
            }
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
                using (DB2Connecter dac = new DB2Connecter("DB2"))
                {
                    dac.AddParameters("P_ACL_ID", DbType.String, hts[0]["ACL_ID"]);
                    dac.ExcuteDataSet("CMN_ACL_GRP_DEL ");
                }
                using (DB2Connecter dac = new DB2Connecter("DB2"))
                {
                    dac.AddParameters("P_ACL_ID", DbType.String, hts[0]["ACL_ID"]);
                    dac.ExcuteDataSet("CMN_ACL_GRP_DEL ");
                }
                //// 선택 권한 입력
                foreach (Hashtable ht in hts)
                {
                    using (DB2Connecter dac = new DB2Connecter("DB2"))
                    {
                        dac.AddParameters("P_ACL_ID", DbType.String, ht["ACL_ID"]);
                        dac.AddParameters("P_ACL_GRP", DbType.String, ht["ACL_GRP"]);
                        dac.ExcuteNonQuery("CMN_ACL_ADD");
                    }
                    using (DB2Connecter dac = new DB2Connecter("DB2"))
                    {
                        dac.AddParameters("P_ACL_ID", DbType.String, ht["ACL_ID"]);
                        dac.AddParameters("P_ACL_GRP", DbType.String, ht["ACL_GRP"]);
                        dac.ExcuteNonQuery("CMN_ACL_ADD");
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
        public void DeleteMenu(string MenuId)
        {
            //int CurrentPageIndex, int PageSize
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_MENUID", DbType.String, MenuId);

                dac.ExcuteNonQuery("CMN_MENU_DEL");
            }
        }
        #endregion

        #region GetMenuCombo - 메뉴 목록 콤보
        /// <summary>
        /// 메뉴 목록 콤보
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuCombo()
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {

                return dac.ExcuteDataSet("CMN_MENU_COMBO_GET");
            }
        }
        /// <summary>
        /// 메뉴 목록 콤보
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuCombo(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
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
        //public DataSet GetMenuSearchTree(string MenuId)
        //{
        //    using (DB2Connecter dac = new DB2Connecter("DB2"))
        //    {
        //        dac.AddParameters("P_MENUID", DbType.String, MenuId);

        //        return dac.ExcuteDataSet("CMN_MENUSEARCH_GET");
        //    }
        //}
        #endregion

        #region GetMenuSearchTree - 메뉴 검색 목록
        /// <summary>
        /// 메뉴 검색 목록
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuSearchTree(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
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
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                return dac.ExcuteDataSet("CMN_MENU_TREE_GET_ACLAPP");
            }
        }
        #endregion

        #region GetMenuData - 상단메뉴조회
        /// <summary>
        /// 상단메뉴조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuData(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_EMPID", DbType.String, ((UserInfo)ht["UserInfo"]).EmpID);
                dac.AddParameters("P_COMPANYCODE", DbType.String, ((UserInfo)ht["UserInfo"]).CompanyCode);
                dac.AddParameters("P_LANGCODE", DbType.String, ((UserInfo)ht["UserInfo"]).ClientCultureName);
                dac.AddParameters("P_MENUTYPE", DbType.String, "GP");

                return dac.ExcuteDataSet("CMN_MENU_GET");
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
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);
                dac.AddParameters("P_EMPID", DbType.String, ((UserInfo)ht["UserInfo"]).EmpID);
                dac.AddParameters("P_COMPANYCODE", DbType.String, ((UserInfo)ht["UserInfo"]).CompanyCode);
                dac.AddParameters("P_LANGCODE", DbType.String, ((UserInfo)ht["UserInfo"]).ClientCultureName);

                return dac.ExcuteDataSet("CMN_MENU_LEFT_TREE_GET");
            }
        }
        #endregion


        #region GetMenuSubData_Wf - 좌측메뉴 트리조회_winform
        /// <summary>
        /// 좌측메뉴 트리조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuSubData_Wf(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);
                dac.AddParameters("P_EMPID", DbType.String, ht["EmpID"]);
                dac.AddParameters("P_COMPANYCODE", DbType.String, ht["SiteCompanyCode"]);
                dac.AddParameters("P_LANGCODE", DbType.String, ht["ClientCultureName"]);

                return dac.ExcuteDataSet("CMN_MENU_LEFT_TREE_GET");
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
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_MENUID", DbType.String, ht["MENUID"]);

                return dac.ExcuteDataSet("CMN_MENU_SEARCH_GET");
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
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                return dac.ExcuteDataSet("CMN_MENUTREE_GET_ACLCHK ");
            }
        }
        #endregion


    }
}
