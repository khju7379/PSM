using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using TaeYoung.Biz.Type;
using JINI.Base;
using JINI.Data;
using JINI.Data.Transactions;
using JINI.User;
using JINI.Base.Configuration;

namespace TaeYoung.Biz.Common
{
    /// <summary>
    /// 공통코드 비지니스 로직
    /// </summary>
    public class OrgChartBiz : BizBase
    {
        /*********************************************************************/
        //서한그룹 포탈 사용 중인 Biz는 아래 region 안으로 옮겨 주세요.
        /*********************************************************************/
        #region 서한그룹 포탈 사용

        #region GetCompanyCombo - 회사 콤보박스 목록
        /// <summary>
        /// 회사 콤보박스 목록
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetCompanyCombo(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LANGUAGECODE", DbType.String, Document.UserInfo.ClientCultureName.ToLower()); // 언어코드

                return dbCon.ExcuteDataSet("ORG_COMPANY_LIST");
            }
        }
        #endregion

        #region GetCompanyComboOrg - 전사조직도 회사 콤보박스 목록
        /// <summary>
        /// 전사조직도 회사 콤보박스 목록
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetCompanyComboOrg(Hashtable ht)
        { 
            
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LANGUAGECODE", DbType.String, Document.UserInfo.ClientCultureName.ToLower()); // 언어코드

                DataSet ds = dbCon.ExcuteDataSet("ORG_COMPANY_LIST");

                for (int i = ds.Tables[0].Rows.Count-1; i > -1; i--)
                {
                    if (ds.Tables[0].Rows[i]["COMPANYCODE"].ToString().Trim() == "BSNTN" ||
                        ds.Tables[0].Rows[i]["COMPANYCODE"].ToString().Trim() == "CGNTN" ||
                            ds.Tables[0].Rows[i]["COMPANYCODE"].ToString().Trim() == "SAMEXICO" ||
                            ds.Tables[0].Rows[i]["COMPANYCODE"].ToString().Trim() == "SAUSA" ||
                            ds.Tables[0].Rows[i]["COMPANYCODE"].ToString().Trim() == "ZGKAMTEC" ||
                            ds.Tables[0].Rows[i]["COMPANYCODE"].ToString().Trim() == "")
                    {
                        ds.Tables[0].Rows[i].Delete();
                    }
                }

                return ds;
            }
        }
        #endregion

        #region GetEISCompanyCombo - 경영정보 회사 콤보박스 목록
        /// <summary>
        /// 경영정보 회사 콤보박스 목록
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetEISCompanyCombo(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, "");
                dbCon.AddParameters("P_LANGCODE", DbType.String, "ko");
                dbCon.AddParameters("P_PCODE", DbType.String, "CMN0100101");
                dbCon.AddParameters("P_DCODE", DbType.String, "EIS0001");

                return dbCon.ExcuteDataSet("CMN_CODE_GET");
            }

            
        }
        #endregion

        #region GetCompanyCombo2 - 회사 콤보박스 목록(로그인)
        /// <summary>
        /// 회사 콤보박스 목록(로그인)
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetCompanyCombo2(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LANGUAGECODE", DbType.String, ht["LANGCODE"] == null ? "ko" : ht["LANGCODE"]); // 언어코드

                return dbCon.ExcuteDataSet("ORG_COMPANY_LIST");
            }
        }
        #endregion

        #region GetCompanyComboCommon - 회사 콤보박스 목록 (COMMON = N)
        /// <summary>
        /// 회사 콤보박스 목록 (COMMON = N)
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetCompanyComboCommon(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LANGUAGECODE", DbType.String, Document.UserInfo.ClientCultureName.ToLower()); // 언어코드

                return dbCon.ExcuteDataSet("ORG_COMPANY_LIST_COMMON");
            }
        }
        #endregion

        #region GetUserList - 사용자 리스트
        /// <summary>
        /// 사용자 리스트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetUserList(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 5000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, Convert.ToString(ht["COMPANYCODE"]));
                dbCon.AddParameters("P_DEPTCD", DbType.String, Convert.ToString(ht["DEPTCD"]));
                dbCon.AddParameters("P_DPARTNER", DbType.String, Convert.ToString(ht["DPARTNER"]));
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, Convert.ToString(ht["SearchCondition"]));
                dbCon.AddParameters("P_LANGCD", DbType.String, ht.ContainsKey("LANGCD") && !string.IsNullOrEmpty(Convert.ToString(ht["LANGCD"]).Trim()) ? Convert.ToString(ht["LANGCD"]) : ((UserInfo)ht["UserInfo"]).ClientCultureName.ToLower()); // 언어코드
                return dbCon.ExcuteDataSet("ORG_USER_LST");
            }
        }
        #endregion

        #region GetUserList1 - 사용자 리스트
        /// <summary>
        /// 사용자 리스트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetUserList1(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 5000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, Convert.ToString(ht["COMPANYCODE"]));
                dbCon.AddParameters("P_DEPTCD", DbType.String, Convert.ToString(ht["DEPTCD"]));
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, Convert.ToString(ht["SearchCondition"]));
                dbCon.AddParameters("P_LANGCD", DbType.String, ht.ContainsKey("LANGCD") && !string.IsNullOrEmpty(Convert.ToString(ht["LANGCD"]).Trim()) ? Convert.ToString(ht["LANGCD"]) : ((UserInfo)ht["UserInfo"]).ClientCultureName.ToLower()); // 언어코드
                return dbCon.ExcuteDataSet("ORG_USER_LST1");
            }
        }
        #endregion

        #region GetUserAllList - 사용자 리스트(내부,소사장,업체사용자 업체를 제외한 전체)
        /// <summary>
        /// 사용자 리스트(내부,소사장,업체사용자 업체를 제외한 전체)
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetUserAllList(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 5000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, Convert.ToString(ht["COMPANYCODE"]));
                dbCon.AddParameters("P_DEPTCD", DbType.String, Convert.ToString(ht["DEPTCD"]));
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, Convert.ToString(ht["SearchCondition"]));
                dbCon.AddParameters("P_LANGCD", DbType.String, ht.ContainsKey("LANGCD") && !string.IsNullOrEmpty(Convert.ToString(ht["LANGCD"]).Trim()) ? Convert.ToString(ht["LANGCD"]) : ((UserInfo)ht["UserInfo"]).ClientCultureName.ToLower()); // 언어코드
                return dbCon.ExcuteDataSet("ORG_USER_LIST_ALL");
            }
        }
        #endregion

        #region GetUserListForVendCode - 사용자 리스트 (업체 코드 조회 용)
        /// <summary>
        /// 사용자 리스트 (업체 코드 조회 용)
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetUserListForVendCode(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 5000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, Convert.ToString(ht["COMPANYCODE"]));
                dbCon.AddParameters("P_DPARTNER", DbType.String, Convert.ToString(ht["DPARTNER"]));
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, Convert.ToString(ht["SearchCondition"]));
                dbCon.AddParameters("P_LANGCD", DbType.String, ht.ContainsKey("LANGCD") && !string.IsNullOrEmpty(Convert.ToString(ht["LANGCD"]).Trim()) ? Convert.ToString(ht["LANGCD"]) : ((UserInfo)ht["UserInfo"]).ClientCultureName.ToLower()); // 언어코드
                return dbCon.ExcuteDataSet("ORG_USER_VEND_LST");
            }
        }
        #endregion

        #region GetUserVendList - 사용자 리스트 (업체 코드 조회 용) - 소팅순서 업체,사용자 순
        /// <summary>
        /// 사용자 리스트 (업체 코드 조회 용) - 소팅순서 업체,사용자 순
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetUserVendList(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 5000);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, Convert.ToString(ht["SearchCondition"]));
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, Convert.ToString(ht["COMPANYCODE"]));
                dbCon.AddParameters("P_DPARTNER", DbType.String, Convert.ToString(ht["DPARTNER"]));
                dbCon.AddParameters("P_LANGCD", DbType.String, ht.ContainsKey("LANGCD") && !string.IsNullOrEmpty(Convert.ToString(ht["LANGCD"]).Trim()) ? Convert.ToString(ht["LANGCD"]) : ((UserInfo)ht["UserInfo"]).ClientCultureName.ToLower()); // 언어코드
                return dbCon.ExcuteDataSet("ORG_USER_VEND_LST_PAM");
            }
        }
        #endregion

        #region GetVendList - 협력업체 리스트
        /// <summary>
        /// 협력업체 리스트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetVendList(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht.ContainsKey("COMPANYCODE") ? Convert.ToString(ht["COMPANYCODE"]) : string.Empty);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, Convert.ToString(ht["SearchCondition"]));
                dbCon.AddParameters("P_LANGCD", DbType.String, ht.ContainsKey("LANGCD") && !string.IsNullOrEmpty(Convert.ToString(ht["LANGCD"]).Trim()) ? Convert.ToString(ht["LANGCD"]) : ((UserInfo)ht["UserInfo"]).ClientCultureName.ToLower()); // 언어코드
                return dbCon.ExcuteDataSet("ORG_VEND_LST");
            }
        }
        #endregion

        #region GetFirstVendList - 협력업체 리스트
        /// <summary>
        /// 협력업체 리스트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetFirstVendList(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht.ContainsKey("COMPANYCODE") ? Convert.ToString(ht["COMPANYCODE"]) : string.Empty);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, Convert.ToString(ht["SearchCondition"]));
                dbCon.AddParameters("P_LANGCD", DbType.String, ht.ContainsKey("LANGCD") && !string.IsNullOrEmpty(Convert.ToString(ht["LANGCD"]).Trim()) ? Convert.ToString(ht["LANGCD"]) : ((UserInfo)ht["UserInfo"]).ClientCultureName.ToLower()); // 언어코드
                return dbCon.ExcuteDataSet("ORG_VEND_LIST_FIRST");
            }
        }
        #endregion

        #region GetUserinfoAll - 사용자 ID로 사용자정보를 가져온다.
        /// <summary>
        /// 사용자 ID로 사용자정보를 가져온다.
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetUserinfoAll(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LOGINID", DbType.String, ht["EMPID"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);

                return dbCon.ExcuteDataSet("ORG_USER_GET_LOGINID");
            }
        }
        #endregion

        #region GetUserListTree - 전사조직도 사용자 트리 리스트
        /// <summary>
        /// 전사조직도 사용자 트리 리스트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetUserListTree(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LANGCD", DbType.String, ht["LANGCD"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                return dbCon.ExcuteDataSet("ORG_USER_LIST_TREE");
            }
        }
        #endregion

        #region GetUserListTreeSub - 전사조직도 사용자 트리 서브 리스트
        /// <summary>
        /// 전사조직도 사용자 트리 서브 리스트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetUserListTreeSub(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LANGCD", DbType.String, ht["LANGCD"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_DEPTCODE", DbType.String, ht["DEPTCODE"]);
                return dbCon.ExcuteDataSet("ORG_USER_LIST_TREE_SUB");
            }
        }
        #endregion

        #region GetOrg_User_Teamchiefyn - 팀장 사번 조회 리스트
        /// <summary>
        /// 작성자 : 장윤호
        /// 팀장 사번 조회 리스트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetOrg_User_Teamchiefyn(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);               // 법인
                dac.AddParameters("P_DEPTCODE", DbType.String, ht["DEPTCODE"]);                     // 부서
                return dac.ExcuteDataSet("ORG_USER_LIST_TEAMCHIEFYN");
            }
        }
        #endregion

        #region GetOrg_User_Groupusr - 그룹유저 사번 리스트
        /// <summary>
        /// 작성자 : 장윤호
        /// 그룹유저 사번 리스트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetOrg_User_Groupusr(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);               // 법인
                dac.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);                           // 그룹코드
                return dac.ExcuteDataSet("ORG_USER_LIST_GROUPUSR");
            }
        }
        #endregion

        #region GetEmp_Mst - 인사기록카드 조회 리스트
        /// <summary>
        /// 작성자 : 장윤호
        /// 인사기록카드 조회 리스트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetEmp_Mst(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);               // 법인
                dac.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);                           // 그룹코드
                return dac.ExcuteDataSet("EMP_MST_GET");
            }
        }
        #endregion


        #region GetEmpInfo - 사용자 정보를 가져온다.
        /// <summary>
        /// 사용자 정보를 가져온다.
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetEmpInfo(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                return dbCon.ExcuteDataSet("PCMLIB.ORG_USER_SEL");
            }
        }
        #endregion
        #endregion

        #region GetAddinLogin - 사용자 ID로 사용자정보를 가져온다.(에드인)
        /// <summary>
        /// 사용자 ID로 사용자정보를 가져온다.
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetAddinLogin(string companycode, string loginid, string pass , string langcode)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LOGINID", DbType.String, loginid);
                dbCon.AddParameters("P_LANGCODE", DbType.String, langcode);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);

                return dbCon.ExcuteDataSet("ORG_USER_GET_ADDIN_LOGIN");
            }
        }
        #endregion

        #region GetLoginCustomer - 고객사 로그인
        /// <summary>
        /// 고객사 로그인
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetLoginCustomer(string loginid, string password)
        {

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LOGINID", DbType.String, loginid);
                dbCon.AddParameters("P_PASSWORD", DbType.String, password);

                return dbCon.ExcuteDataSet("ORG_CUSTOMER_LOGIN");
            }
        }
        #endregion

        #region GetUserinfoLogin - 사용자 ID로 사용자정보를 가져온다.
        /// <summary>
        /// 사용자 ID로 사용자정보를 가져온다.
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetUserinfoLogin(string loginid, string langcode)
        {
             
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LOGINID", DbType.String, loginid);
                dbCon.AddParameters("P_LANGCODE", DbType.String, langcode);

                return dbCon.ExcuteDataSet("ORG_USER_GET_LOGINID");
            }
        }
        #endregion

        #region GetVendinfoLogin - 사용자 ID로 사용자정보를 가져온다. (+2)
        /// 사용자 ID로 사용자정보를 가져온다.
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetVendinfoLogin(string loginid, string langcode, string companycode)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LOGINID", DbType.String, loginid);
                dbCon.AddParameters("P_LANGCODE", DbType.String, langcode);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);

                return dbCon.ExcuteDataSet("ORG_USER_GET_VENDID");
            }
        }

        //[Transaction(TransactionOption.Supported)]
        public DataSet GetVendinfoLogin(string loginid, string langcode)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LOGINID", DbType.String, loginid);
                dbCon.AddParameters("P_LANGCODE", DbType.String, langcode);

                return dbCon.ExcuteDataSet("ORG_USER_GET_VENDID_NOCOM");
            }
        }
        #endregion

        #region GetVendLogin - 로그인아이디, 비밀번호로 사용자를 로그인한다.(업체)
        /// <summary>
        /// 로그인아이디, 비밀번호로 사용자를 로그인한다.(업체)
        /// </summary>
        /// <param name="companycode">회사코드</param>
        /// <param name="loginid">로그인아아디</param>
        /// <param name="password">비밀번호</param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetVendLogin(string companycode, string loginid, string password)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);
                dbCon.AddParameters("P_LOGINID", DbType.String, loginid);
                dbCon.AddParameters("P_PASSWORD", DbType.String, password);

                return dbCon.ExcuteDataSet("ORG_USER_GET_VEND_LOGIN");
            }
        } 
        #endregion

        public DataSet GetPassword(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_LOGINID", DbType.String, ht["LOGINID"]);
                DataSet ds = dbCon.ExcuteDataSet("ORG_USER_PASS_GET");
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    dr["PASSWORD"] = JINI.Base.Security.EncryptionManager.DecryptString(FxConfigManager.GetString("Encryption"), dr["PASSWORD"].ToString());
                }

                return ds;
            }
        }

        public void ResetPassword(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_LOGINID", DbType.String, ht["LOGINID"]);
                dbCon.AddParameters("P_PASSWORD", DbType.String, JINI.Base.Security.EncryptionManager.EncryptString(FxConfigManager.GetString("Encryption"), "1"));
                dbCon.ExcuteNonQuery("ORG_USER_PASS_RESET");
            }
        }

        #region SetPassChange - 비밀 번호 변경
        
        public DataSet SetPassChange(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                string pw = string.Empty;
                string r_pw = string.Empty;

                if ( ht["COMPANYCODE"].ToString() != "TY" )
                {
                    pw =  ht["PASSWORD"].ToString();
                    r_pw =  ht["NEWPASS"].ToString();
                }
                else
                {
                    pw = JINI.Base.Security.EncryptionManager.EncryptString(FxConfigManager.GetString("Encryption"), ht["PASSWORD"].ToString());
                    r_pw = JINI.Base.Security.EncryptionManager.EncryptString(FxConfigManager.GetString("Encryption"), ht["NEWPASS"].ToString());
                }

                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_LOGINID", DbType.String, ht["LOGINID"]);
                dbCon.AddParameters("P_PASSWORD", DbType.String, pw);
                dbCon.AddParameters("P_NEWPASS", DbType.String, r_pw);

                return dbCon.ExcuteDataSet("ORG_USER_PASS_MOD");
            }
        }
        #endregion


        #region GetSiteUserLogin - 현장 사용자의 사번으로 사용자정보를 가져온다
        /// <summary>
        /// 현장 사용자의 사번으로 사용자정보를 가져온다
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetSiteUserLogin(string loginid)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //dbCon.AddParameters("P_LANGCODE", DbType.String, langcode);
                dbCon.AddParameters("P_EMPID", DbType.String, loginid);

                return dbCon.ExcuteDataSet("ORG_SITEUSER_GET");
            }
        }
        #endregion

        #region ModifySiteUserLogin - 현장 사용자의 비밀번호를 변경한다.
        /// <summary>
        /// 현장 사용자의 비밀번호를 변경한다.
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public void ModifySiteUserLogin(string loginid, string password)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //dbCon.AddParameters("P_LANGCODE", DbType.String, langcode);
                dbCon.AddParameters("P_EMPID", DbType.String, loginid);
                dbCon.AddParameters("P_PASSWORD", DbType.String, password);
                dbCon.AddParameters("P_MODIFYDT", DbType.String, DateTime.Now.ToString("yyyy-MM-dd"));

                dbCon.ExcuteNonQuery("ORG_SITEUSER_PW_MOD");
            }
        }
        #endregion

        #region ModifySiteUserLogin - 현장 사용자의 비밀번호를 변경한다.
        /// <summary>
        /// 현장 사용자의 비밀번호를 변경한다.
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public void ModifySiteUserLoginAjax(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //dbCon.AddParameters("P_LANGCODE", DbType.String, langcode);
                dbCon.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);
                dbCon.AddParameters("P_PASSWORD", DbType.String, ht["PASSWORD"]);
                dbCon.AddParameters("P_MODIFYDT", DbType.String, DateTime.Now.ToString("yyyy-MM-dd"));

                dbCon.ExcuteNonQuery("ORG_SITEUSER_PW_MOD");
            }
        }
        #endregion
        
        #region GetUserinfoConnection - 테스트를 위하여 10분마다 쿼리 연결을 실행한다.
        /// <summary>
        /// 테스트를 위하여 10분마다 쿼리 연결을 실행한다.
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetUserinfoConnection()
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LOGINID", DbType.String, "gw-han");
                dbCon.AddParameters("P_LANGCODE", DbType.String, "ko");

                return dbCon.ExcuteDataSet("ORG_USER_GET_LOGINID");
            }
        }
        #endregion

        #region GetACL - 사용자의 그룹과 menuid로 사용권한여부를 가져온다
        /// <summary>
        /// 사용자의 그룹과 menuid로 사용권한여부를 가져온다
        /// </summary>
        /// <param name="companyCode">접속회사코드</param>
        /// <param name="id">접속ID</param>
        /// <param name="lang">접속언어</param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetACL(string empid, string companycode, string menuid)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_EMPID", DbType.String, empid);
                dac.AddParameters("P_COMPANYCODE", DbType.String, companycode);
                dac.AddParameters("P_MENUID", DbType.String, menuid);
                return dac.ExcuteDataSet("ORG_USER_GET_ACL");
            }
            //using (DacConnecter dac = new DacConnecter("Portal"))
            //{
            //    dac.AddParameters("EMPID", DbType.String, empid);
            //    dac.AddParameters("COMPANYCODE", DbType.String, companycode);
            //    dac.AddParameters("MENUID", DbType.String, menuid);
            //    return dac.ExcuteDataSet("SP_USER_SELECT_ACL");
            //}
        }
        #endregion

        #region GetGroupAclExists - 그룹 List 조회(권한선택)
        /// <summary>
        /// 그룹 List 조회(권한선택)
        /// </summary>
        //[Transaction(TransactionOption.Supported)]
        public static DataSet GetGroupAclExists(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dac.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SEARCHCONDITION"]);
                return dac.ExcuteDataSet("ORG_GROUP_LIST_ACLSELECT");
            }
        }
        #endregion

        #region GetGroupAcl - 그룹 List 조회(권한)
        /// <summary>
        /// 그룹 List 조회(권한)
        /// </summary>
        //[Transaction(TransactionOption.Supported)]
        public static DataSet GetGroupAcl(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dac.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dac.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SEARCHCONDITION"]);
                dac.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                return dac.ExcuteDataSet("ORG_GROUP_LIST_ACL");
            }
        }
        #endregion

        #region GetGroup - 그룹 List 조회
        /// <summary>
        /// 그룹 List 조회
        /// </summary>
        //[Transaction(TransactionOption.Supported)]
        public static DataSet GetGroup(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CURRENTPAGEINDEX"]);
                dac.AddParameters("P_PAGESIZE", DbType.Int32, ht["PAGESIZE"]);
                dac.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dac.AddParameters("P_GRPTYPE", DbType.String, ht["GRPTYPE"]);
                dac.AddParameters("P_GRPNAME", DbType.String, ht["GRPNAME"]);
                return dac.ExcuteDataSet("ORG_GROUP_LIST");
            }
        }
        #endregion

        #region GetGroupMember - 그룹 멤버 조회
        /// <summary>
        /// 그룹 멤버 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public static DataSet GetGroupMember(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                return dac.ExcuteDataSet("ORG_GROUPUSR_GET");
            }
        }
        #endregion

        #region GetGroupByUser - 사용자의 그룹 조회
        /// <summary>
        /// 사용자의 그룹 조회
        /// </summary>
        /// <param name="companyCode">접속회사코드</param>
        /// <param name="id">접속ID</param>
        /// <param name="lang">접속언어</param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetGroupByUser(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);
                dac.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                return dac.ExcuteDataSet("ORG_GROUP_GET_BYEMPID");
            }
        }
        #endregion

        #region GetGroupMemberAll - 그룹 멤버 전체 조회
        /// <summary>
        /// 그룹 멤버 전체 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public static DataSet GetGroupMemberAll(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_NAME", DbType.String, ht["NAME"]);
                return dac.ExcuteDataSet("ORG_GROUPUSR_GET_ALL");
            }
        }
        #endregion

        #region GetUserVendor - 업체정보 리턴
        /// <summary>
        ///업체정보 리턴
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetUserVendor(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dac.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dac.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dac.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dac.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);

                return dac.ExcuteDataSet("ORG_USER_ENT_GET");
            }
        }
        #endregion

        #region GetUserVendorCombo - 업체정보 리턴(콤보)
        /// <summary>
        ///업체정보 리턴
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetUserVendorCombo(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dac.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dac.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                return dac.ExcuteDataSet("ORG_USER_ENT_GET_COMBO");
            }
        }
        #endregion

        #region GetUserSV - 전체 사용자를 조회한다.(SV) P_LANGCODE 코드 UserInfo
        /// <summary>
        /// 전체 사용자를 조회한다.(SV)
        /// </summary>
        /// <param name="companyCode">접속회사코드</param>
        /// <param name="id">접속ID</param>
        /// <param name="lang">접속언어</param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetUserSV(Hashtable ht)
        {
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = "";
            }
            else
            {
                //ht["SearchCondition"] = " AND C.USERLNAME LIKE '%%'";
                ht["SearchCondition"] = " AND (EMPID LIKE '%" + ht["SearchCondition"].ToString() + "%' OR USERNAME LIKE '%" + ht["SearchCondition"].ToString() + "%')";
                //ht["SearchCondition"] = " AND (C.EMPID LIKE '%" + ht["SearchCondition"].ToString() + "%' OR C.USERNAME LIKE '%" + ht["SearchCondition"].ToString() + "%')";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ((UserInfo)ht["UserInfo"]).ClientCultureName.ToLower()); // 언어코드

                return dbCon.ExcuteDataSet("ORG_USER_LIST_SV");
            }
        }
        #endregion

        #region GetUserSV2 - 전체 사용자를 조회한다.(SV) - P_LANGCODE paramater
        /// <summary>
        /// 전체 사용자를 조회한다.(SV)
        /// </summary>
        /// <param name="companyCode">접속회사코드</param>
        /// <param name="id">접속ID</param>
        /// <param name="lang">접속언어</param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetUserSV2(Hashtable ht)
        {
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = "";
            }
            else
            {
                //ht["SearchCondition"] = " AND C.USERLNAME LIKE '%%'";
                //ht["SearchCondition"] = " AND (C.EMPID LIKE '%" + ht["SearchCondition"].ToString() + "%' OR C.USERLNAME || C.USERFNAME LIKE '%" + ht["SearchCondition"].ToString() + "%')";
                ht["SearchCondition"] = " AND (EMPID LIKE '%" + ht["SearchCondition"].ToString() + "%' OR USERNAME LIKE '%" + ht["SearchCondition"].ToString() + "%')";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]); // 언어코드

                return dbCon.ExcuteDataSet("ORG_USER_LIST_SV");
            }
        }
        #endregion

        #region GetUserSV3 - 전체 사용자를 조회한다.(SV) P_LANGCODE 코드 UserInfo
        /// <summary>
        /// 전체 사용자를 조회한다.(SV)
        /// </summary>
        /// <param name="companyCode">접속회사코드</param>
        /// <param name="id">접속ID</param>
        /// <param name="lang">접속언어</param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetUserSV3(Hashtable ht)
        {
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = "";
            }
            else
            {
                ht["SearchCondition"] = " AND (EMPID LIKE '%" + ht["SearchCondition"].ToString() + "%' OR USERNAME LIKE '%" + ht["SearchCondition"].ToString() + "%' OR MAINDEPTCODE LIKE '%" + ht["SearchCondition"].ToString() + "%' OR DEPTNAME LIKE '%" + ht["SearchCondition"].ToString() + "%')";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ((UserInfo)ht["UserInfo"]).ClientCultureName.ToLower()); // 언어코드

                return dbCon.ExcuteDataSet("ORG_USER_LIST_SV");
            }
        }
        #endregion

        #region GetUserOnlySV - 내부 사용자를 조회한다.(SV) P_LANGCODE 코드 UserInfo
        /// <summary>
        /// 내부 사용자를 조회한다.(SV) P_LANGCODE 코드 UserInfo
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetUserOnlySV(Hashtable ht)
        {
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = " AND DPARTNER = '0' ";
            }
            else
            {
                ht["SearchCondition"] = " AND DPARTNER = '0' AND (EMPID LIKE '%" + ht["SearchCondition"].ToString() + "%' OR USERNAME LIKE '%" + ht["SearchCondition"].ToString() + "%' OR MAINDEPTCODE LIKE '%" + ht["SearchCondition"].ToString() + "%' OR DEPTNAME LIKE '%" + ht["SearchCondition"].ToString() + "%')";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ((UserInfo)ht["UserInfo"]).ClientCultureName.ToLower()); // 언어코드

                return dbCon.ExcuteDataSet("ORG_USER_LIST_SV");
            }
        }
        #endregion

        #region GetVendSV - 업체 사용자를 조회한다.(SV) P_LANGCODE 코드 UserInfo
        /// <summary>
        /// 업체 사용자를 조회한다.(SV) P_LANGCODE 코드 UserInfo
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetVendSV(Hashtable ht)
        {
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = " AND DPARTNER = '1' ";
            }
            else
            {
                ht["SearchCondition"] = " AND DPARTNER = '1' AND (EMPID LIKE '%" + ht["SearchCondition"].ToString() + "%' OR USERNAME LIKE '%" + ht["SearchCondition"].ToString() + "%' OR MAINDEPTCODE LIKE '%" + ht["SearchCondition"].ToString() + "%' OR DEPTNAME LIKE '%" + ht["SearchCondition"].ToString() + "%')";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ((UserInfo)ht["UserInfo"]).ClientCultureName.ToLower()); // 언어코드

                return dbCon.ExcuteDataSet("ORG_USER_LIST_SV");
            }
        }
        #endregion

        #region GetVendSV2 - 업체 사용자를 조회한다.(SV) P_LANGCODE 코드 paramater
        /// <summary>
        /// 업체 사용자를 조회한다.(SV) P_LANGCODE 코드 UserInfo
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetVendSV2(Hashtable ht)
        {
            if (ht["SearchCondition"] == null)
            {
                ht["SearchCondition"] = " AND DPARTNER = '1' ";
            }
            else
            {
                ht["SearchCondition"] = " AND DPARTNER = '1' AND (EMPID LIKE '%" + ht["SearchCondition"].ToString() + "%' OR USERNAME LIKE '%" + ht["SearchCondition"].ToString() + "%' OR MAINDEPTCODE LIKE '%" + ht["SearchCondition"].ToString() + "%' OR DEPTNAME LIKE '%" + ht["SearchCondition"].ToString() + "%')";
            }

            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]); // 언어코드

                return dbCon.ExcuteDataSet("ORG_USER_LIST_SV");
            }
        }
        #endregion

        #region GetUserBYDeptCd - 부서별 사용자 조회
        /// <summary>
        /// 부서별 사용자 조회
        /// </summary>
        /// <param name="companyCode">접속회사코드</param>
        /// <param name="id">접속ID</param>
        /// <param name="lang">접속언어</param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetUserBYDeptCd(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dbCon.AddParameters("P_DEPTCD", DbType.String, ht["DEPTCD"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                return dbCon.ExcuteDataSet("ORG_USER_GET_DEPT");
            }
        }
        #endregion

        #region GetGroupUserSV - 그룹사용자 서치뷰
        /// <summary>
        /// 그룹사용자 서치뷰
        /// </summary>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetGroupUserSV(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);

                return dbCon.ExcuteDataSet("ORG_GROUPUSER_SV_LST");
            }
        }
        #endregion

        #region GetPPTUser - 전체 사용자를 조회한다.(COMBO) - PPT 사용
        /// <summary>
        /// 전체 사용자를 조회한다.(SV)
        /// </summary>
        /// <param name="companyCode">접속회사코드</param>
        /// <param name="id">접속ID</param>
        /// <param name="lang">접속언어</param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetPPTUser(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LangCode"]); // 언어코드

                return dbCon.ExcuteDataSet("ORG_USER_LIST_COMBO");
            }
        }
        #endregion

        #region GetDeptCbo - 부서 콤보박스 조회
        /// <summary>
        /// 부서 콤보박스 조회
        /// </summary>
        /// <param name="companycode"></param>
        /// <param name="langcode"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetDeptCbo(string companycode, string langcode)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);
                dbCon.AddParameters("P_LANGCODE", DbType.String, langcode);

                return dbCon.ExcuteDataSet("ORG_DEPTCOMBO_LIST");
            }
        }
        #endregion

        #region GetOrgSearch - 조직도 검색
        /// <summary>
        /// 조직도 검색
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public static DataSet GetOrgSearch(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //dbCon.AddParameters("P_COMPANYCODE", DbType.String, "1000");
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dbCon.AddParameters("P_SEARCHSTRING", DbType.String, ht["SEARCHSTRING"]);
                return dbCon.ExcuteDataSet("ORG_DEPT_ORGCHART_TREE_GET");
            }
        }
        #endregion

        #region GetPTORGUSR70L6 - 업체 및 부서 조회 (부적합 사용)
        /// <summary>
        /// 업체 및 부서 조회 (부적합 사용)
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public static DataSet GetPTORGUSR70L6(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht["CurrentPageIndex"]);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht["PageSize"]);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, ht["SearchCondition"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);

                return dbCon.ExcuteDataSet("ORG_DEPTCONTRACTOR_GET");
            }
        }
        #endregion

        #region 그룹 리스트
        /// <summary>
        /// 그룹 리스트
        /// </summary>
        public DataSet SelectGroup(string companyCode, string langCode)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, companyCode);
                dbCon.AddParameters("P_LANGCODE", DbType.String, langCode);
                return dbCon.ExcuteDataSet("ORG_GROUP_LIST");
            }
        }
        #endregion

        #region GetOrgSearchMember - 조직도의 조건내 검색
        /// <summary>
        /// 조직도의 조건내 검색
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetOrgSearchMember(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_DEPTCODE", DbType.String, ht["DEPTCODE"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dbCon.AddParameters("P_SEARCHSTRING", DbType.String, ht["SEARCHSTRING"]);

                return dbCon.ExcuteDataSet("ORG_DEPT_ORGCHART_DEPTOFFICER_GET");
                //return dbCon.ExcuteDataSet("ORG_DEPT_ORGCHART_DEPTOFFICER_GET_TMP");
            }
        }
        #endregion

        #region 조직도의 그룹 멤버 조회
        /// <summary>
        /// 그룹 멤버 조회
        /// </summary>
        /// <param name="groupCode"></param>
        /// <param name="langCode"></param>
        /// <returns></returns>
        public DataSet GetOrgGroupMember(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_GROUPCODE", DbType.String, ht["GROUPCODE"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                return dbCon.ExcuteDataSet("ORG_DEPT_ORGCHART_GROUP_OFFICER_GET");
            }
        }
        #endregion

        #region GetUserInfo - ID로 사용자 정보를 가져온다.
        /// <summary>
        /// ID로 사용자 정보를 가져온다.
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetUserInfo(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                return dbCon.ExcuteDataSet("ORG_DEPT_ORGCHART_OFFICER_GET");
            }
        }
        #endregion

        #region GetUserInfoCard - ID로 사용자 정보를 가져온다.
        /// <summary>
        /// ID로 사용자 정보를 가져온다.
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet GetUserInfoCard(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                dbCon.AddParameters("P_REGID", DbType.String, ht["REGID"]);
                return dbCon.ExcuteDataSet("ORG_DEPT_ORGCHART_OFFICER_GET_CARD");
            }
        }
        #endregion

        #region GetVendList - 협력업체 리스트(로그인시)
        /// <summary>
        /// 협력업체 리스트(로그인시)
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetVendList2(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_CURRENTPAGEINDEX", DbType.Int32, ht.ContainsKey("CurrentPageIndex") && !string.IsNullOrEmpty(Convert.ToString(ht["CurrentPageIndex"]).Trim()) ? Convert.ToInt32(ht["CurrentPageIndex"]) : 1);
                dbCon.AddParameters("P_PAGESIZE", DbType.Int32, ht.ContainsKey("PageSize") && !string.IsNullOrEmpty(Convert.ToString(ht["PageSize"]).Trim()) ? Convert.ToInt32(ht["PageSize"]) : 1000);
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht.ContainsKey("COMPANYCODE") ? Convert.ToString(ht["COMPANYCODE"]) : string.Empty);
                dbCon.AddParameters("P_SEARCHCONDITION", DbType.String, Convert.ToString(ht["SearchCondition"]));
                dbCon.AddParameters("P_LANGCD", DbType.String, "ko"); // 언어코드
                return dbCon.ExcuteDataSet("ORG_VEND_LST");
            }
        }
        #endregion

        #region GetVendUser - 협력업체 사용자(콤보)
        /// <summary>
        /// 협력업체 사용자(콤보)
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetVendUser(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht.ContainsKey("COMPANYCODE") ? Convert.ToString(ht["COMPANYCODE"]) : string.Empty);
                dbCon.AddParameters("P_LOGINID", DbType.String, Convert.ToString(ht["LOGINID"]));
                return dbCon.ExcuteDataSet("ORG_VENDUSR_GET");
            }
        }
        #endregion

        #region GetUserCompanyList - 접속가능한 회사정보 리스트
        /// <summary>
        /// 접속가능한 회사정보 리스트
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public DataSet GetUserCompanyList(Hashtable ht)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_LOGINID", DbType.String, ht["LOGINID"]);
                return dbCon.ExcuteDataSet("ORG_USER_GET_COMPANYLIST");
            }
        }
        #endregion

        // 인터페이스
        #region AddCompany - 회사코드 입력
        /// <summary>
        /// 회사코드 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddCompany(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_COMPANY_DEL");
            }
            
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                foreach (DataRow dr in dt.Rows)
                {
                    string companycode = "";
                    companycode = dr["COMPANYCODE"].ToString();
                    if (companycode.Length > 10)
                    {
                        companycode = companycode.Substring(0, 10);
                    }

                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);
                    dbCon.AddParameters("P_DISPLAYORDER", DbType.String, dr["DISPLAYORDER"]);
                    dbCon.AddParameters("P_DOMAINNAME", DbType.String, dr["DOMAINNAME"]);
                    dbCon.AddParameters("P_COMMON", DbType.String, dr["COMMON"]);

                    dbCon.ExcuteNonQuery("ORG_COMPANY_ADD");
                }
            }
        }
        #endregion

        #region AddCompanyLang - 회사명 입력
        /// <summary>
        /// 회사명 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddCompanyLang(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_COMPANYLANG_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    string companycode = "";
                    companycode = dr["COMPANYCODE"].ToString();
                    if (companycode.Length > 10)
                    {
                        companycode = companycode.Substring(0, 10);
                    }

                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);
                    dbCon.AddParameters("P_LANGUAGECODE", DbType.String, dr["LANGUAGECODE"]);
                    dbCon.AddParameters("P_COMPANY", DbType.String, dr["COMPANY"]);
                    dbCon.AddParameters("P_ABBCOMPANY", DbType.String, dr["ABBCOMPANY"]);

                    dbCon.ExcuteNonQuery("ORG_COMPANYLANG_ADD");
                }
            }
        }
        #endregion

        #region AddDept - 부서코드 입력
        /// <summary>
        /// 부서코드 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddDept(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_DEPT_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    if (dr["DEPTCODE"] == DBNull.Value || dr["DEPTCODE"] == null || dr["DEPTCODE"].ToString() == string.Empty)
                    {
                        continue;
                    }

                    if (dr["COMPANYCODE"] == DBNull.Value || dr["COMPANYCODE"] == null || dr["COMPANYCODE"].ToString() == string.Empty || dr["COMPANYCODE"].ToString() == "== 선택 ==")
                        continue;

                    string companycode = "";
                    companycode = dr["COMPANYCODE"].ToString();
                    if (companycode.Length > 10)
                    {
                        companycode = companycode.Substring(0, 10);
                    }

                    string parentdeptcode = "";
                    parentdeptcode = dr["PARENTDEPTCODE"].ToString();
                    if (parentdeptcode.Length > 10)
                    {
                        parentdeptcode = parentdeptcode.Substring(0, 10);
                    }

                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);
                    dbCon.AddParameters("P_DEPTCODE", DbType.String, dr["DEPTCODE"]);
                    dbCon.AddParameters("P_DEPTORDER", DbType.String, dr["DEPTORDER"]);
                    dbCon.AddParameters("P_DEPTLEVEL", DbType.String, dr["DEPTLEVEL"]);
                    dbCon.AddParameters("P_PARENTDEPTCODE", DbType.String, parentdeptcode);
                    dbCon.AddParameters("P_CREATEDDT", DbType.String, dr["CREATEDDT"]);
                    dbCon.AddParameters("P_DEPTEMAIL", DbType.String, dr["DEPTEMAIL"]);
                    dbCon.AddParameters("P_DISPLAYNAME", DbType.String, dr["DISPLAYNAME"]);
                    dbCon.AddParameters("P_DISPLAYYN", DbType.String, dr["DISPLAYYN"]);
                    dbCon.AddParameters("P_LOCATION", DbType.String, dr["LOCATION"]);
                    dbCon.AddParameters("P_DPARTNER", DbType.String, dr["DPARTNER"]);
                    dbCon.AddParameters("P_IFYN", DbType.String, dr["IFYN"].ToString().Substring(0, 1));
                    dbCon.AddParameters("P_REGID", DbType.String, dr["REGID"]);
                    //dbCon.AddParameters("P_REGDT", DbType.String, dr["REGDT"]);
                    dbCon.AddParameters("P_UPDID", DbType.String, dr["UPDID"]);
                    //dbCon.AddParameters("P_UPDDT", DbType.String, dr["UPDDT"]);

                    dbCon.ExcuteNonQuery("ORG_DEPT_ADD");
                }
            }
        }
        #endregion

        #region AddDeptLang - 부서명 입력
        /// <summary>
        /// 부서명 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddDeptLang(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_DEPTLANG_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    string companycode = "";
                    companycode = dr["COMPANYCODE"].ToString();
                    if (companycode.Length > 10)
                    {
                        companycode = companycode.Substring(0, 10);
                    }
                    if (dr["COMPANYCODE"] == DBNull.Value || dr["COMPANYCODE"] == null || dr["COMPANYCODE"].ToString() == string.Empty || dr["COMPANYCODE"].ToString() == "== 선택 ==")
                        continue;
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);
                    dbCon.AddParameters("P_DEPTCODE", DbType.String, dr["DEPTCODE"]);
                    dbCon.AddParameters("P_LANGCODE", DbType.String, dr["LANGCODE"]);

                    //20160317 인터페이스 오류로인한 임시작업
                    string deptName = "";
                    if (dr["DEPTNAME"].ToString().Length > 30)
                        deptName = dr["DEPTNAME"].ToString().Substring(0, 29);
                    else
                        deptName = dr["DEPTNAME"].ToString();

                    dbCon.AddParameters("P_DEPTNAME", DbType.String, deptName);

                    dbCon.ExcuteNonQuery("ORG_DEPTLANG_ADD");
                }
            }
        }
        #endregion

        #region AddDeptSingle - 부서정보 입력
        /// <summary>
        /// 부서정보 입력
        /// </summary>
        /// <param name="hts"></param>
        //[Transaction(TransactionOption.Supported)]
        public int AddDeptSingle(List<Hashtable> hts, List<Hashtable> lhts)
        {
            int cnt = 0;
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, hts[0]["COMPANYCODE"]);
                dbCon.AddParameters("P_DEPTCODE", DbType.String, hts[0]["DEPTCODE"]);
                dbCon.AddParameters("P_DEPTORDER", DbType.String, hts[0]["DEPTORDER"]);
                dbCon.AddParameters("P_DEPTLEVEL", DbType.String, hts[0]["DEPTLEVEL"]);
                dbCon.AddParameters("P_PARENTDEPTCODE", DbType.String, hts[0]["PARENTDEPTCODE"]);
                dbCon.AddParameters("P_CREATEDDT", DbType.String, hts[0]["CREATEDDT"]);
                dbCon.AddParameters("P_DEPTEMAIL", DbType.String, hts[0]["DEPTEMAIL"]);
                dbCon.AddParameters("P_DISPLAYNAME", DbType.String, hts[0]["DISPLAYNAME"]);
                dbCon.AddParameters("P_DISPLAYYN", DbType.String, hts[0]["DISPLAYYN"]);
                dbCon.AddParameters("P_LOCATION", DbType.String, hts[0]["LOCATION"]);
                dbCon.AddParameters("P_DPARTNER", DbType.String, hts[0]["DPARTNER"]);
                dbCon.AddParameters("P_IFYN", DbType.String, hts[0]["IFYN"].ToString().Substring(0, 1));
                dbCon.AddParameters("P_REGID", DbType.String, hts[0]["REGID"]);
                dbCon.AddParameters("P_UPDID", DbType.String, hts[0]["UPDID"]);
                cnt += dbCon.ExcuteNonQuery("ORG_DEPT_ADD");
            }
            foreach (Hashtable ht in lhts)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                    dbCon.AddParameters("P_DEPTCODE", DbType.String, ht["DEPTCODE"]);
                    dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                    //20160317 인터페이스 오류로인한 임시작업
                    string deptName = "";
                    if (ht["DEPTNAME"].ToString().Length > 30) deptName = ht["DEPTNAME"].ToString().Substring(0, 29);
                    else deptName = ht["DEPTNAME"].ToString();
                    dbCon.AddParameters("P_DEPTNAME", DbType.String, deptName);
                    cnt += dbCon.ExcuteNonQuery("ORG_DEPTLANG_ADD");
                }
            }
            return cnt;
        }
        #endregion

        #region DelDept - 부서정보 삭제
        /// <summary>
        /// 부서정보 삭제
        /// </summary>
        /// <param name="hts"></param>
        //[Transaction(TransactionOption.Supported)]
        public int DelDept(List<Hashtable> hts)
        {
            int cnt = 0;
            foreach (Hashtable ht in hts)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                    dbCon.AddParameters("P_DEPTCODE", DbType.String, ht["DEPTCODE"]);
                    cnt += dbCon.ExcuteNonQuery("ORG_DEPT_DEL2");
                }
            }
            return cnt;
        }
        #endregion

        #region AddDuty - 직책코드 입력
        /// <summary>
        /// 직책코드 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddDuty(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_DUTY_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                if (string.IsNullOrEmpty(Convert.ToString(dr["DUTYCODE"])))
                {
                    continue;
                }
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, dr["COMPANYCODE"]);
                    dbCon.AddParameters("P_DUTYCODE", DbType.String, dr["DUTYCODE"]);
                    dbCon.AddParameters("P_LANGCODE", DbType.String, dr["LANGCODE"]);
                    dbCon.AddParameters("P_DUTYNAME", DbType.String, dr["DUTYNAME"]);
                    dbCon.AddParameters("P_TEAMCHIEFYN", DbType.String, dr["TEAMCHIEFYN"]);
                    dbCon.AddParameters("P_SORTNO", DbType.Int32, dr["SORTNO"]);

                    dbCon.ExcuteNonQuery("ORG_DUTY_ADD");
                }
            }
        }
        #endregion

        #region AddGroup - 그룹코드 입력
        /// <summary>
        /// 그룹코드 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddGroup(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터입력
                dbCon.ExcuteNonQuery("ORG_GROUP_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {

                    if (dr["GRPID"].ToString().Length > 10) // 예외처리
                    {
                        continue;
                    }

                    dbCon.AddParameters("P_GRPID", DbType.String, dr["GRPID"]);
                    dbCon.AddParameters("P_SHRRNG", DbType.String, dr["SHRRNG"].ToString().Substring(0, 1));
                    dbCon.AddParameters("P_USEYN", DbType.String, dr["USEYN"].ToString().Substring(0, 1));
                    dbCon.AddParameters("P_GRPTYPE", DbType.String, dr["GRPTYPE"]);
                    dbCon.AddParameters("P_GRPEMAIL", DbType.String, dr["GRPEMAIL"]);
                    dbCon.AddParameters("P_GRPEXT", DbType.String, dr["GRPEXT"]);
                    dbCon.AddParameters("P_REGID", DbType.String, dr["REGID"]);
                    //dbCon.AddParameters("P_REGDT", DbType.String, dr["REGDT"]);
                    dbCon.AddParameters("P_UPDID", DbType.String, dr["UPDID"]);
                    //dbCon.AddParameters("P_UPDDT", DbType.String, dr["UPDDT"]);

                    dbCon.ExcuteNonQuery("ORG_GROUP_ADD");
                }
            }
        }
        #endregion

        #region AddGroupLang - 그룹명 입력
        /// <summary>
        /// 그룹명 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddGroupLang(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_GROUPLANG_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    if (dr["GRPID"].ToString().Length > 10) // 예외처리
                    {
                        continue;
                    }
                    string grpName = dr["GRPNAME"].ToString();
                    if (grpName.Length > 40)
                    {
                        grpName = grpName.Substring(0, 40);
                    }

                    dbCon.AddParameters("P_GRPID", DbType.String, dr["GRPID"]);
                    dbCon.AddParameters("P_LANGCODE", DbType.String, dr["LANGCODE"]);
                    dbCon.AddParameters("P_GRPNAME", DbType.String, grpName);

                    dbCon.ExcuteNonQuery("ORG_GROUPLANG_ADD");
                }
            }
        }
        #endregion

        #region AddGroupMember - 그룹맴버 입력
        /// <summary>
        /// 그룹맴버 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddGroupMember(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_GROUPUSR_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    if (dr["GRPID"].ToString().Length > 10) // 예외처리
                    {
                        continue;
                    }

                    dbCon.AddParameters("P_GRPID", DbType.String, dr["GRPID"]);
                    dbCon.AddParameters("P_USRID", DbType.String, dr["USRID"]);
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, dr["COMPANYCODE"]);
                    dbCon.AddParameters("P_USRTYPE", DbType.String, dr["USRTYPE"]);

                    dbCon.ExcuteNonQuery("ORG_GROUPUSR_ADD");
                }
            }
        }
        #endregion

        public int SetGroupInfoRealTime(List<Hashtable> GrpInfo, List<Hashtable> MemInfo)
        {
            int cnt = 0;
            foreach (Hashtable ht in GrpInfo)
            {
                if (Convert.ToString(ht["GRPID"]).Length > 10) continue;
                //해당되는 그룹ID정보를 삭제
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                    dbCon.ExcuteNonQuery("ORG_GROUP_DEL");
                }
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                    dbCon.AddParameters("P_SHRRNG", DbType.String, ht["SHRRNG"]);
                    dbCon.AddParameters("P_USEYN", DbType.String, ht["USEYN"]);
                    dbCon.AddParameters("P_GRPTYPE", DbType.String, ht["GRPTYPE"]);
                    dbCon.AddParameters("P_GRPEMAIL", DbType.String, ht["GRPEMAIL"]);
                    dbCon.AddParameters("P_GRPEXT", DbType.String, ht["GRPEXT"]);
                    dbCon.AddParameters("P_REGID", DbType.String, ht["REGID"]);
                    dbCon.AddParameters("P_UPDID", DbType.String, ht["UPDID"]);
                    dbCon.ExcuteNonQuery("ORG_GROUP_ADD");
                }
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    string grpName = Convert.ToString(ht["GRPNAME"]);
                    if (grpName.Length > 40) grpName = grpName.Substring(0, 40);
                    dbCon.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                    dbCon.AddParameters("P_LANGCODE", DbType.String, "ko");
                    dbCon.AddParameters("P_GRPNAME", DbType.String, grpName);
                    dbCon.ExcuteNonQuery("ORG_GROUPLANG_ADD");
                }
                foreach (Hashtable mht in MemInfo)
                {
                    if (Convert.ToString(mht["GRPID"]) != Convert.ToString(ht["GRPID"])) continue;
                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {
                        dbCon.AddParameters("P_GRPID", DbType.String, mht["GRPID"]);
                        dbCon.AddParameters("P_USRID", DbType.String, mht["USRID"]);
                        dbCon.AddParameters("P_COMPANYCODE", DbType.String, mht["COMPANYCODE"]);
                        dbCon.AddParameters("P_USRTYPE", DbType.String, mht["USRTYPE"]);
                        dbCon.ExcuteNonQuery("ORG_GROUPUSR_ADD");
                    }
                }
                cnt++;
            }
            return cnt;
        }

        public int DelGroupInfoRealTime(List<Hashtable> hts)
        {
            int cnt = 0;
            foreach (Hashtable ht in hts)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_GRPID", DbType.String, ht["GRPID"]);
                    dbCon.ExcuteNonQuery("ORG_GROUP_DEL");
                }
                cnt++;
            }
            return cnt;
        }

        #region AddLocation - 지역코드 입력
        /// <summary>
        /// 지역코드 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddLocation(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_LOCATION_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_LOCATIONCODE", DbType.String, dr["LOCATIONCODE"]);
                    dbCon.AddParameters("P_DISPLAYORDER", DbType.String, dr["DISPLAYORDER"]);
                    dbCon.AddParameters("P_DISPLAYYN", DbType.String, dr["DISPLAYYN"]);
                    dbCon.AddParameters("P_LOCATIONGROUP", DbType.String, dr["LOCATIONGROUP"]);

                    dbCon.ExcuteNonQuery("ORG_LOCATION_ADD");
                }
            }
        }
        #endregion

        #region AddLocationGroup - 지역그룹 입력
        /// <summary>
        /// 지역그룹 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddLocationGroup(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_LOCATIONGROUP_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_LOCATIONCODE", DbType.String, dr["LOCATIONCODE"]);
                    dbCon.AddParameters("P_LANGCODE", DbType.String, dr["LANGCODE"]);
                    dbCon.AddParameters("P_LOCATIONGROUPNAME", DbType.String, dr["LOCATIONGROUPNAME"]);

                    dbCon.ExcuteNonQuery("ORG_LOCATIONGROUP_ADD");
                }
            }
        }
        #endregion

        #region AddLocationLang - 지역명 입력
        /// <summary>
        /// 지역명 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddLocationLang(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_LOCATIONLANG_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_LOCATIONCODE", DbType.String, dr["LOCATIONCODE"]);
                    dbCon.AddParameters("P_LANGCODE", DbType.String, dr["LANGCODE"]);
                    dbCon.AddParameters("P_LOCATIONNAME", DbType.String, dr["LOCATIONNAME"]);

                    dbCon.ExcuteNonQuery("ORG_LOCATIONLANG_ADD");
                }
            }
        }
        #endregion

        #region AddRank - 직위코드 입력
        /// <summary>
        /// 직위코드 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddRank(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_RANK_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                if (string.IsNullOrEmpty(Convert.ToString(dr["RANKCODE"])))
                {
                    continue;
                }
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, dr["COMPANYCODE"]);
                    dbCon.AddParameters("P_RANKCODE", DbType.String, dr["RANKCODE"]);
                    dbCon.AddParameters("P_LANGCODE", DbType.String, dr["LANGCODE"]);
                    dbCon.AddParameters("P_RANKNAME", DbType.String, dr["RANKNAME"]);
                    dbCon.AddParameters("P_TEAMCHIEFYN", DbType.String, dr["TEAMCHIEFYN"]);
                    int sortno = 0;
                    if (int.TryParse(dr["SORTNO"].ToString(), out sortno))
                    {
                        sortno = Convert.ToInt32(dr["SORTNO"]);
                    }
                    dbCon.AddParameters("P_SORTNO", DbType.Int32, sortno);

                    dbCon.ExcuteNonQuery("ORG_RANK_ADD");
                }
            }
        }
        #endregion

        #region AddUser - 사용자정보 입력
        /// <summary>
        /// 사용자정보 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddUser(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_USER_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    if (dr["EMPID"] == DBNull.Value && string.IsNullOrEmpty(Convert.ToString(dr["EMPID"])))
                    {
                        continue;
                    }

                    string empid = dr["EMPID"].ToString();
                    //if (empid.Length > 10)
                    //{
                    //    empid = empid.Substring(1);
                    //}



                    string companycode = "";
                    companycode = dr["COMPANYCODE"].ToString();
                    if (companycode.Length > 10)
                    {
                        companycode = companycode.Substring(0, 10);
                    }
                    string sitecompany = "";
                    sitecompany = Convert.ToString(dr["SITECOMPANY"]);
                    if (!string.IsNullOrEmpty(sitecompany) && sitecompany.Length > 10)
                    {
                        sitecompany = sitecompany.Substring(0, 10);
                    }
                    if (dr["COMPANYCODE"] == DBNull.Value || dr["COMPANYCODE"] == null || dr["COMPANYCODE"].ToString() == string.Empty || dr["COMPANYCODE"].ToString() == "== 선택 ==")
                        continue;
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);
                    dbCon.AddParameters("P_EMPID", DbType.String, empid);
                    dbCon.AddParameters("P_LOGINID", DbType.String, dr["LOGINID"]);
                    dbCon.AddParameters("P_ALIAS", DbType.String, dr["ALIAS"]);
                    dbCon.AddParameters("P_EMAIL", DbType.String, dr["EMAIL"]);
                    dbCon.AddParameters("P_MAINDEPTCODE", DbType.String, dr["MAINDEPTCODE"].ToString().Length > 10 ? dr["MAINDEPTCODE"].ToString().Substring(0, 10) : dr["MAINDEPTCODE"].ToString());
                    dbCon.AddParameters("P_CREATEDDT", DbType.String, dr["CREATEDDT"]);
                    dbCon.AddParameters("P_DISPLAYNAME", DbType.String, dr["DISPLAYNAME"]);
                    dbCon.AddParameters("P_DISPLAYYN", DbType.String, dr["DISPLAYYN"].ToString().Substring(0, 1));
                    dbCon.AddParameters("P_DUTYCODE", DbType.String, dr["DUTYCODE"]);
                    dbCon.AddParameters("P_JOBCODE", DbType.String, dr["JOBCODE"]);
                    dbCon.AddParameters("P_RANKCODE", DbType.String, dr["RANKCODE"]);
                    dbCon.AddParameters("P_CELLPHONE", DbType.String, dr["CELLPHONE"]);

                    string faxnum = string.Empty;
                    if (dr["FAXNUMBER"].ToString().Length > 18) faxnum = dr["FAXNUMBER"].ToString().Substring(0, 17);
                    else faxnum = dr["FAXNUMBER"].ToString();
                    dbCon.AddParameters("P_FAXNUMBER", DbType.String, faxnum.Length);

                    dbCon.AddParameters("P_EXTENSIONNUMBER", DbType.String, dr["EXTENSIONNUMBER"]);
                    dbCon.AddParameters("P_LOCATIONCODE", DbType.String, dr["LOCATIONCODE"]);
                    dbCon.AddParameters("P_TEAMCHIEFYN", DbType.String, dr["TEAMCHIEFYN"].ToString().Length > 0 ? dr["TEAMCHIEFYN"].ToString().Substring(0, 1) : "N");
                    dbCon.AddParameters("P_DATEOFBIRTH", DbType.String, "");//dr["DATEOFBIRTH"]);
                    dbCon.AddParameters("P_IFYN", DbType.String, dr["IFYN"].ToString().Substring(0, 1));
                    dbCon.AddParameters("P_MESSANGERIFYN", DbType.String, dr["MESSANGERIFYN"].ToString().Substring(0, 1));
                    dbCon.AddParameters("P_PHONE1", DbType.String, dr["PHONE1"]);
                    dbCon.AddParameters("P_PHONE2", DbType.String, dr["PHONE2"]);
                    dbCon.AddParameters("P_CULTURE", DbType.String, dr["CULTURE"]);
                    dbCon.AddParameters("P_REGID", DbType.String, "admin");//dr["REGID"]);
                    //dbCon.AddParameters("P_REGDT", DbType.String, dr["REGDT"]);
                    dbCon.AddParameters("P_UPDID", DbType.String, "admin");//dr["UPDID"]);
                    //dbCon.AddParameters("P_UPDDT", DbType.String, dr["UPDDT"]);
                    dbCon.AddParameters("P_JOBDESC", DbType.String, dr["JOBDESC"]);
                    dbCon.AddParameters("P_SITECOMPANY", DbType.String, sitecompany);

                    dbCon.ExcuteNonQuery("ORG_USER_ADD");
                }
            }
        }
        #endregion

        #region AddUserLang - 사용자명 입력
        /// <summary>
        /// 사용자명 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddUserLang(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 전체 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_USERLANG_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    //string companycode = dr["COMPANYCODE"].ToString();
                    //if (companycode.Length > 4)
                    //{
                    //    continue;
                    //}

                    string empid = dr["EMPID"].ToString();
                    //if (empid.Length > 10)
                    //{
                    //    empid = empid.Substring(1);
                    //}

                    string companycode = "";
                    companycode = dr["COMPANYCODE"].ToString();
                    if (companycode.Length > 10)
                    {
                        companycode = companycode.Substring(0, 10);
                    }
                    if (dr["COMPANYCODE"] == DBNull.Value || dr["COMPANYCODE"] == null || dr["COMPANYCODE"].ToString() == string.Empty || dr["COMPANYCODE"].ToString() == "== 선택 ==")
                        continue;
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);
                    dbCon.AddParameters("P_EMPID", DbType.String, empid);
                    dbCon.AddParameters("P_LANGCODE", DbType.String, dr["LANGCODE"]);
                    dbCon.AddParameters("P_USERLNAME", DbType.String, dr["USERLNAME"]);
                    dbCon.AddParameters("P_USERFNAME", DbType.String, dr["USERFNAME"]);

                    dbCon.ExcuteNonQuery("ORG_USERLANG_ADD");
                }
            }
        }
        #endregion

        #region AddAdditionalJob - 겸직정보 입력
        /// <summary>
        /// 겸직정보 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void AddAdditionalJob(DataTable dt)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                // 데이터 삭제
                dbCon.ExcuteNonQuery("ORG_ADDITIONALJOB_DEL");
            }
            foreach (DataRow dr in dt.Rows)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    if (dr["EMPID"] == DBNull.Value && string.IsNullOrEmpty(Convert.ToString(dr["EMPID"])))
                    {
                        continue;
                    }

                    string empid = dr["EMPID"].ToString();
                    if (empid.Length > 10)
                    {
                        empid = empid.Substring(1);
                    }
                    string companycode = "";
                    companycode = dr["COMPANYCODE"].ToString();
                    if (companycode.Length > 10)
                    {
                        companycode = companycode.Substring(0, 10);
                    }
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, companycode);
                    dbCon.AddParameters("P_EMPID", DbType.String, empid);
                    dbCon.AddParameters("P_SEQNO", DbType.String, dr["SEQNO"]);
                    dbCon.AddParameters("P_LOGINID", DbType.String, dr["LOGINID"]);
                    dbCon.AddParameters("P_DEPTCODE", DbType.String, dr["DEPTCODE"]);
                    dbCon.AddParameters("P_JOBCODE", DbType.String, dr["JOBCODE"]);
                    dbCon.AddParameters("P_DUTYCODE", DbType.String, dr["DUTYCODE"]);
                    dbCon.AddParameters("P_RANKCODE", DbType.String, dr["RANKCODE"]);
                    dbCon.AddParameters("P_TEAMCHIEFYN", DbType.String, dr["TEAMCHIEFYN"]);
                    dbCon.AddParameters("P_JOBDESC", DbType.String, dr["JOBDESC"]);

                    dbCon.ExcuteNonQuery("ORG_ADDITIONALJOB_ADD");
                }
            }
        }
        #endregion

        #region GetUserDept - 사용자의 소속 부서를 조회한다.
        /// <summary>
        /// 사용자의 소속 부서를 조회한다.
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Supported)]
        public static DataSet GetUserDept(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);
                dac.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dac.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                return dac.ExcuteDataSet("ORG_USER_LIST_DEPT");
            }
        }
        #endregion

        // 도미노에서 조직도 실시간 동기화
        #region ModifyUserOut - 사용자정보 입력
        /// <summary>
        /// 사용자정보 입력
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void ModifyUserOut(List<Hashtable> hts)
        {
            foreach (Hashtable ht in hts)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                    dbCon.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);

                    dbCon.ExcuteNonQuery("ORG_USER_DEL_BYEMPID");
                }
            }
        }
        #endregion

        #region ModifyUser - 사용자수정
        /// <summary>
        /// 사용자수정
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void ModifyUser(List<Hashtable> hts)
        {
            foreach (Hashtable ht in hts)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                    dbCon.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);
                    dbCon.AddParameters("P_LOGINID", DbType.String, ht["LOGINID"]);
                    dbCon.AddParameters("P_ALIAS", DbType.String, ht["ALIAS"]);
                    dbCon.AddParameters("P_EMAIL", DbType.String, ht["EMAIL"]);
                    dbCon.AddParameters("P_MAINDEPTCODE", DbType.String, ht["MAINDEPTCODE"]);
                    dbCon.AddParameters("P_CREATEDDT", DbType.String, ht["CREATEDDT"]);
                    dbCon.AddParameters("P_DISPLAYNAME", DbType.String, ht["DISPLAYNAME"]);
                    dbCon.AddParameters("P_DISPLAYYN", DbType.String, ht["DISPLAYYN"].ToString().Substring(0, 1));
                    dbCon.AddParameters("P_DUTYCODE", DbType.String, ht["DUTYCODE"]);
                    dbCon.AddParameters("P_JOBCODE", DbType.String, ht["JOBCODE"]);
                    dbCon.AddParameters("P_RANKCODE", DbType.String, ht["RANKCODE"]);
                    dbCon.AddParameters("P_CELLPHONE", DbType.String, ht["CELLPHONE"]);
                    dbCon.AddParameters("P_FAXNUMBER", DbType.String, ht["FAXNUMBER"]);
                    dbCon.AddParameters("P_EXTENSIONNUMBER", DbType.String, ht["EXTENSIONNUMBER"]);
                    dbCon.AddParameters("P_LOCATIONCODE", DbType.String, ht["LOCATIONCODE"]);
                    dbCon.AddParameters("P_TEAMCHIEFYN", DbType.String, ht["TEAMCHIEFYN"].ToString().Length > 0 ? ht["TEAMCHIEFYN"].ToString().Substring(0, 1) : "N");
                    dbCon.AddParameters("P_DATEOFBIRTH", DbType.String, "");//ht["DATEOFBIRTH"]);
                    dbCon.AddParameters("P_IFYN", DbType.String, ht["IFYN"].ToString().Substring(0, 1));
                    dbCon.AddParameters("P_MESSANGERIFYN", DbType.String, ht["MESSANGERIFYN"].ToString().Substring(0, 1));
                    dbCon.AddParameters("P_PHONE1", DbType.String, ht["PHONE1"]);
                    dbCon.AddParameters("P_PHONE2", DbType.String, ht["PHONE2"]);
                    dbCon.AddParameters("P_CULTURE", DbType.String, ht["CULTURE"]);
                    dbCon.AddParameters("P_REGID", DbType.String, "admin");//ht["REGID"]);
                    //dbCon.AddParameters("P_REGDT", DbType.String, ht["REGDT"]);
                    dbCon.AddParameters("P_UPDID", DbType.String, "admin");//ht["UPDID"]);
                    //dbCon.AddParameters("P_UPDDT", DbType.String, ht["UPDDT"]);
                    dbCon.AddParameters("P_JOBDESC", DbType.String, ht["JOBDESC"]);
                    dbCon.AddParameters("P_SITECOMPANY", DbType.String, ht["MCOMCODE"]);

                    dbCon.ExcuteNonQuery("ORG_USER_ADD");
                }
            }
        }
        #endregion

        #region ModifyUserName - 사용자명수정
        /// <summary>
        /// 사용자명수정
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void ModifyUserName(List<Hashtable> hts)
        {
            //using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            //{
            //    dbCon.AddParameters("P_COMPANYCODE", DbType.String, hts[0]["COMPANYCODE"]);
            //    dbCon.AddParameters("P_EMPID", DbType.String, hts[0]["EMPID"]);

            //    dbCon.ExcuteNonQuery("ORG_USER_DEL_BYEMPID");
            //}

            foreach (Hashtable ht in hts)
            {
                using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                {
                    dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                    dbCon.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);
                    dbCon.AddParameters("P_LANGCODE", DbType.String, ht["LANGCODE"]);
                    dbCon.AddParameters("P_USERLNAME", DbType.String, ht["USERLNAME"]);
                    dbCon.AddParameters("P_USERFNAME", DbType.String, ht["USERFNAME"]);

                    dbCon.ExcuteNonQuery("ORG_USERLANG_ADD");
                }
            }
        }
        #endregion

        #region ModifyAdditionalJob - 겸직수정
        /// <summary>
        /// 겸직수정
        /// </summary>
        /// <param name="dt">웹서비스 데이터</param>
        //[Transaction(TransactionOption.Supported)]
        public void ModifyAdditionalJob(List<Hashtable> hts)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                //dbCon.AddParameters("P_COMPANYCODE", DbType.String, hts[0]["COMPANYCODE"]);
                dbCon.AddParameters("P_LOGINID", DbType.String, hts[0]["LOGINID"]);

                dbCon.ExcuteNonQuery("ORG_ADDITIONALJOB_DEL_PERSONAL");
            }

            if (hts[0]["DEPTCODE"].ToString() != string.Empty) // 부서코드가 공백일시 겸직이 없는것으로 간주하고, 겸직이 없을시 실행하지 않음
            {
                foreach (Hashtable ht in hts)
                {
                    using (DB2Connecter dbCon = new DB2Connecter("DB2"))
                    {
                        dbCon.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                        dbCon.AddParameters("P_EMPID", DbType.String, ht["EMPID"]);
                        dbCon.AddParameters("P_SEQNO", DbType.String, ht["SEQNO"]);
                        dbCon.AddParameters("P_LOGINID", DbType.String, ht["LOGINID"]);
                        dbCon.AddParameters("P_DEPTCODE", DbType.String, ht["DEPTCODE"]);
                        dbCon.AddParameters("P_JOBCODE", DbType.String, ht["JOBCODE"]);
                        dbCon.AddParameters("P_DUTYCODE", DbType.String, ht["DUTYCODE"]);
                        dbCon.AddParameters("P_RANKCODE", DbType.String, ht["RANKCODE"]);
                        dbCon.AddParameters("P_TEAMCHIEFYN", DbType.String, ht["TEAMCHIEFYN"]);
                        dbCon.AddParameters("P_JOBDESC", DbType.String, ht["JOBDESC"]);

                        dbCon.ExcuteNonQuery("ORG_ADDITIONALJOB_ADD");
                    }
                }
            }
        }
        #endregion

        // HR
        #region GetUserTree - 전사조직도 트리를 조회한다.
        /// <summary>
        /// 전사조직도 트리를 조회한다.
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public static DataSet GetUserTree(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dac.AddParameters("P_LANGCD", DbType.String, ht["LANGCD"]);

                return dac.ExcuteDataSet("ORG_USER_GET_HRDATA");
            }
        }
        #endregion

        #region GetUserTreeSub - 전사조직도 하위 트리를 조회한다.
        /// <summary>
        /// 전사조직도 하위 트리를 조회한다.
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public static DataSet GetUserTreeSub(Hashtable ht)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, ht["COMPANYCODE"]);
                dac.AddParameters("P_DEPTCODE", DbType.String, ht["DEPTCODE"]);
                dac.AddParameters("P_LANGCD", DbType.String, ht["LANGCD"]);

                return dac.ExcuteDataSet("ORG_USER_GET_HRSUBDATA");
            }
        }
        #endregion

        // 언어변경
        #region ChnageCulture - 언어를 변경한다
        /// <summary>
        /// 언어를 변경한다
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        //[Transaction(TransactionOption.Supported)]
        public static DataSet ChnageCulture(Hashtable ht)
        {
            Document.ClientCultureName = ht["CULTURE"].ToString();

            return null;
        }
        #endregion

        #region 신 그룹웨어 로그인 사번 권한 체크
        /// <summary>
        /// 문자발송이력 상세 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_TB_PASSWORD_RUN(string sCOMPANYCODE, string sEMPID, string sPASSWORD)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, sCOMPANYCODE);
                dbCon.AddParameters("P_EMPID", DbType.String, sEMPID);
                dbCon.AddParameters("P_PASSWORD", DbType.String, sPASSWORD);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_TB_PASSWORD_RUN");
            }
        }
        #endregion

        #region 신 그룹웨어 로그인 영문이니셜로 권한 체크
        /// <summary>
        /// 문자발송이력 상세 조회
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public DataSet UP_SMS_TB_USER_RUN(string sCOMPANYCODE, string sLOGINID, string sPASSWORD)
        {
            using (DB2Connecter dbCon = new DB2Connecter("DB2"))
            {
                dbCon.AddParameters("P_COMPANYCODE", DbType.String, sCOMPANYCODE);
                dbCon.AddParameters("P_LOGINID", DbType.String, sLOGINID);
                dbCon.AddParameters("P_PASSWORD", DbType.String, sPASSWORD);

                return dbCon.ExcuteDataSet("TYJINFWLIB.SMS_TB_USER_RUN");
            }
        }
        #endregion
    }
}
