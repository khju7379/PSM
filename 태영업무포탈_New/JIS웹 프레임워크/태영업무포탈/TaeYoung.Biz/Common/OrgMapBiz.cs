using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using TaeYoung.Biz.Type;
using JINI.Base;
using JINI.Data;
using JINI.Data.Transactions;

namespace TaeYoung.Biz.Common
{
    public class OrgMapBiz : BizBase
    {
        #region SelectCompanyList - 회사 리스트 조회 (관계사, 자회사 포함)
        /// <summary>
        /// 회사 리스트 조회 (관계사, 자회사 포함)
        /// up_OrgChart_Select_Company
        /// </summary>
        /// <param name="langCode"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectCompanyList(string langCode)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_LANGCODE", DbType.String, langCode);

                return dac.ExcuteDataSet("ORM_COMPANY_LIST");
            }
        }
        #endregion

        #region SelectMailGroupType - 메일 그룹 형식
        /// <summary>
        /// 메일 그룹 형식
        /// up_OrgChart_Select_MailGroupType
        /// </summary>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectMailGroupType(string langCode)
        {
            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                dac.AddParameters("@langCode", DbType.String, langCode);

                return dac.ExcuteDataSet("up_OrgChart_Select_MailGroupType");
            }
        }
        #endregion

        #region SelectGroup - 그룹 리스트
        /// <summary>
        /// 그룹 리스트
        /// up_OrgChart_Select_Group
        /// </summary>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectGroup(string companyCode, string langCode)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, companyCode);
                dac.AddParameters("P_LANGCODE", DbType.String, langCode);

                return dac.ExcuteDataSet("ORM_GROUP_LIST");
            }
        }
        #endregion

        #region SelectDeptMember - 부서의 멤버 조회
        /// <summary>
        /// 부서의 멤버 조회
        /// up_OrgChart_Select_DeptMember
        /// </summary>
        /// <param name="deptCode"></param>
        /// <param name="companyCode"></param>
        /// <param name="langCode"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectDeptMember(string deptCode, string companyCode, string isRelative, string langCode)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_DEPTCODE", DbType.String, deptCode);
                dac.AddParameters("P_COMPANYCODE", DbType.String, companyCode);
                dac.AddParameters("P_ISRELATIVE", DbType.String, isRelative);
                dac.AddParameters("P_LANGCODE", DbType.String, langCode);
                dac.AddParameters("P_ISDEACTIVE", DbType.String, "");

                return dac.ExcuteDataSet("ORM_DEPTMEMBER_LIST");
            }
        }

        /// <summary>
        /// 부서의 멤버 조회
        /// up_OrgChart_Select_DeptMember
        /// </summary>
        /// <param name="deptCode"></param>
        /// <param name="companyCode"></param>
        /// <param name="langCode"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectDeptMember(string deptCode, string companyCode, string isRelative, string langCode, string isDeactive)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_DEPTCODE", DbType.String, deptCode);
                dac.AddParameters("P_COMPANYCODE", DbType.String, companyCode);
                dac.AddParameters("P_ISRELATIVE", DbType.String, isRelative);
                dac.AddParameters("P_LANGCODE", DbType.String, langCode);
                dac.AddParameters("P_ISDEACTIVE", DbType.String, isDeactive);

                return dac.ExcuteDataSet("ORM_DEPTMEMBER_LIST");
            }
        }
        #endregion

        #region SelectUser - 사용자 정보 조회
        /// <summary>
        /// 사용자 정보 조회
        /// up_OrgChart_Select_User
        /// </summary>
        /// <param name="companyCode"></param>
        /// <param name="loginID"></param>
        /// <param name="langCode"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectUser(string companyCode, string loginID, string langCode)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, companyCode);
                dac.AddParameters("P_LOGINID", DbType.String, loginID);
                dac.AddParameters("P_LANGCODE", DbType.String, langCode);

                return dac.ExcuteDataSet("ORM_USER_LIST");
            }
        }
        /// <summary>
        /// 사용자 정보 조회(EMPID)
        /// up_OrgChart_Select_User_ByEmpID
        /// </summary>
        /// <param name="loginID"></param>
        /// <param name="langCode"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectUserByEmpID(string empID, string companyID, string langCode)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_EMPID", DbType.String, empID);
                dac.AddParameters("P_COMPANYID", DbType.String, companyID);
                dac.AddParameters("P_LANGCODE", DbType.String, langCode);

                return dac.ExcuteDataSet("ORM_USER_LIST_BYEMPID");
            }
        }
        #endregion

        #region SelectDeptTree - 부서트리 조회
        /// <summary>
        /// 부서트리 조회
        /// up_OrgChart_Select_DeptTree
        /// </summary>
        /// <param name="parentDeptCode"></param>
        /// <param name="loginID"></param>
        /// <param name="langCode"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectDeptTree(string companyCode, string parentDeptCode, string isRelative, string langCode)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, companyCode);
                dac.AddParameters("P_PARENTDEPTCODE", DbType.String, string.IsNullOrEmpty(parentDeptCode) == true ? "" : parentDeptCode);
                dac.AddParameters("P_ISRELATIVE", DbType.String, isRelative);
                dac.AddParameters("P_LANGCODE", DbType.String, langCode);

                return dac.ExcuteDataSet("ORM_DEPT_LIST_TREE");
            }
        }
        #endregion

        #region SelectGroupMember- 그룹 멤버 조회
        /// <summary>
        /// 그룹 멤버 조회
        /// up_OrgChart_Select_GroupMember
        /// </summary>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectGroupMember(string companyCode, string groupCode, string langCode)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, companyCode);
                dac.AddParameters("P_GROUPCODE", DbType.String, groupCode);
                dac.AddParameters("P_LANGCODE", DbType.String, langCode);

                return dac.ExcuteDataSet("ORM_GROUPMEMBER_LIST");
            }
        }
        #endregion

        #region SelectMailGroup- 메일 그룹 리스트 - 사용 X
        /// <summary>
        /// 메일 그룹 리스트
        /// up_OrgChart_Select_MailGroup
        /// </summary>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectMailGroup(string groupTypeCode, string companyCode, string langCode)
        {
            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                dac.AddParameters("@groupTypeCode", DbType.String, groupTypeCode);
                dac.AddParameters("@companyCode", DbType.String, companyCode);
                dac.AddParameters("@langCode", DbType.String, langCode);

                return dac.ExcuteDataSet("up_OrgChart_Select_MailGroup");
            }
        }
        #endregion

        #region SelectSearchUser - 사용자 검색
        /// <summary>
        /// 사용자 검색
        /// up_OrgChart_Select_SearchUser
        /// </summary>
        /// <param name="companyCode"></param>
        /// <param name="keyword"></param>
        /// <param name="langCode"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectSearchUser(string companyCode, string keyword, string isRelative, string langCode)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, companyCode);
                dac.AddParameters("P_KEYWORD", DbType.String, keyword);
                dac.AddParameters("P_ISRELATIVE", DbType.String, isRelative);
                dac.AddParameters("P_LANGCODE", DbType.String, langCode);
                dac.AddParameters("P_ISDEACTIVE", DbType.String, "");

                return dac.ExcuteDataSet("ORM_USER_LIST_SEARCH");
            }
        }

        [Transaction(TransactionOption.Supported)]
        public DataSet SelectSearchUser(string companyCode, string keyword, string isRelative, string langCode, string isDeactive)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, companyCode);
                dac.AddParameters("P_KEYWORD", DbType.String, keyword);
                dac.AddParameters("P_ISRELATIVE", DbType.String, isRelative);
                dac.AddParameters("P_LANGCODE", DbType.String, langCode);
                dac.AddParameters("P_ISDEACTIVE", DbType.String, isDeactive);

                return dac.ExcuteDataSet("ORM_USER_LIST_SEARCH");
            }
        }
        #endregion

        #region SelectSearchDept - 부서 이름 검색
        /// <summary>
        /// 부서 이름 검색
        /// up_OrgChart_Select_SearchDept
        /// </summary>
        [Transaction(TransactionOption.Supported)]
        public DataSet SelectSearchDept(string companyCode, string keyword, string langCode)
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                dac.AddParameters("P_COMPANYCODE", DbType.String, companyCode);
                dac.AddParameters("P_KEYWORD", DbType.String, keyword);
                dac.AddParameters("P_LANGCODE", DbType.String, langCode);

                return dac.ExcuteDataSet("ORM_DEPT_LIST_SEARCH");
            }
        }
        #endregion

        /* CustomGroupBiz 내용 */
        #region ListAddressBookMemberAll - 사용자 그룹 멤버 리스트 - 사용 x
        /// <summary>
        /// 사용자 그룹 멤버 리스트
        /// </summary>
        /// <param name="groupADCommonName"></param>
        /// <returns></returns>
        public List<CustomGroupUserData> ListAddressBookMemberAll(string companyCode, string empId)
        {
            List<CustomGroupUserData> memberList = new List<CustomGroupUserData>();
            CustomGroupUserData userData = null;
            DataSet ds = null;

            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                dac.AddParameters("@CompanyCode", DbType.String, companyCode);
                dac.AddParameters("@EmpID", DbType.String, empId);

                ds = dac.ExcuteDataSet("up_OrgChart_List_AddressBookMemberAll");
            }

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    userData = new CustomGroupUserData();

                    userData.sAMAccountName = dr["sAMAccountName"].ToString();
                    userData.title = dr["Title"].ToString();
                    userData.displayName = dr["DisplayName"].ToString();
                    userData.employeeNumber = dr["EmployeeNumber"].ToString();
                    userData.company = dr["Company"].ToString();
                    userData.department = dr["Department"].ToString();
                    userData.dutyName = dr["DutyName"].ToString();
                    userData.mail = dr["Mail"].ToString();
                    userData.telephoneNumber = dr["TelephoneNumber"].ToString();

                    memberList.Add(userData);
                }
            }

            return memberList;
        }
        #endregion

        #region ListAddressBookMember - 사용자 그룹 멤버 리스트 - 사용 x
        /// <summary>
        /// 사용자 그룹 멤버 리스트
        /// </summary>
        ///<param name="companyCode"></param>
        ///<param name="empId"></param>
        ///<param name="groupNo"></param>
        /// <returns></returns>
        public List<CustomGroupUserData> ListAddressBookMember(string companyCode, string empId, int groupNo)
        {
            List<CustomGroupUserData> memberList = new List<CustomGroupUserData>();
            CustomGroupUserData userData = null;
            DataSet ds = null;

            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                dac.AddParameters("@CompanyCode", DbType.String, companyCode);
                dac.AddParameters("@EmpID", DbType.String, empId);
                dac.AddParameters("@GroupNo", DbType.Int32, groupNo);

                ds = dac.ExcuteDataSet("up_OrgChart_List_AddressBookMemberAll");
            }

            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    userData = new CustomGroupUserData();

                    userData.sAMAccountName = dr["sAMAccountName"].ToString();
                    userData.title = dr["Title"].ToString();
                    userData.displayName = dr["DisplayName"].ToString();
                    userData.employeeNumber = dr["EmployeeNumber"].ToString();
                    userData.company = dr["Company"].ToString();
                    userData.department = dr["Department"].ToString();
                    userData.dutyName = dr["DutyName"].ToString();
                    userData.mail = dr["Mail"].ToString();
                    userData.telephoneNumber = dr["TelephoneNumber"].ToString();

                    memberList.Add(userData);
                }
            }

            return memberList;
        }
        #endregion

        #region ListAddressBookGroup - 사용자별 개인주소록 그룹을 가져온다. - 사용 x
        /// <summary>
        /// 사용자별 개인주소록 그룹을 가져온다.
        /// </summary>
        /// <param name="companyCode"></param>
        /// <param name="empId"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Supported)]
        public DataSet ListAddressBookGroup(string companyCode, string empId)
        {
            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                dac.AddParameters("@CompanyCode", DbType.String, companyCode);
                dac.AddParameters("@EmpID", DbType.String, empId);

                return dac.ExcuteDataSet("up_OrgChart_List_AddressBookGroup");
            }
        }
        #endregion

        #region AddAddressBookGroup - 사용자별 개인주소록 그룹을 생성한다. - 사용 x
        /// <summary>
        /// 사용자별 개인주소록 그룹을 생성한다.
        /// </summary>
        /// <param name="companyCode"></param>
        /// <param name="empId"></param>
        /// <param name="loginId"></param>
        /// <param name="groupName"></param>
        /// <param name="orderNumber"></param>
        /// <param name="memo"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Required)]
        public int AddAddressBookGroup(string companyCode, string empId, string loginId, string groupName, int orderNumber, string memo)
        {
            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                dac.AddParameters("@CompanyCode", DbType.String, companyCode);
                dac.AddParameters("@EmpID", DbType.String, empId);
                dac.AddParameters("@LoginID", DbType.String, loginId);
                dac.AddParameters("@GroupName", DbType.String, groupName);
                dac.AddParameters("@OrderNumber", DbType.Int32, orderNumber);
                dac.AddParameters("@Memo", DbType.String, memo);

                return JINI.Util.ConvertType.ToInt32(dac.ExcuteScalar("up_OrgChart_Insert_AddressBookGroup"));
            }
        }
        #endregion

        #region ModifyAddressBookGroup - 사용자별 개인주소록 그룹을 수정한다. -  사용 x
        /// <summary>
        /// 사용자별 개인주소록 그룹을 수정한다.
        /// </summary>
        /// <param name="companyCode"></param>
        /// <param name="empId"></param>
        /// <param name="loginId"></param>
        /// <param name="groupNo"></param>
        /// <param name="groupName"></param>
        /// <param name="orderNumber"></param>
        /// <param name="useYN"></param>
        /// <param name="memo"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Required)]
        public int ModifyAddressBookGroup(string companyCode, string empId, string loginId, int groupNo, string groupName, int orderNumber, bool useYN, string memo)
        {
            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                dac.AddParameters("@CompanyCode", DbType.String, companyCode);
                dac.AddParameters("@EmpID", DbType.String, empId);
                dac.AddParameters("@LoginID", DbType.String, loginId);
                dac.AddParameters("@GroupNo", DbType.Int32, groupNo);
                dac.AddParameters("@GroupName", DbType.String, groupName);
                dac.AddParameters("@OrderNumber", DbType.Int32, orderNumber);
                dac.AddParameters("@UseYN", DbType.String, useYN);
                dac.AddParameters("@Memo", DbType.String, memo);

                return JINI.Util.ConvertType.ToInt32(dac.ExcuteScalar("up_OrgChart_Insert_AddressBookGroup"));
            }
        }
        #endregion

        #region RemoveAddressBookGroup - 사용자별 개인주소록 그룹 및 멤버 전체를 삭제한다. - 사용 x
        /// <summary>
        /// DeleteAddressBookGroup - 사용자별 개인주소록 그룹 및 멤버를 삭제한다.
        /// </summary>
        /// <param name="companyCode"></param>
        /// <param name="empId"></param>
        /// <param name="loginId"></param>
        /// <param name="groupNo"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Required)]
        public int RemoveAddressBookGroup(string companyCode, string empId, string loginId, int groupNo)
        {
            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                dac.AddParameters("@CompanyCode", DbType.String, companyCode);
                dac.AddParameters("@EmpID", DbType.String, empId);
                dac.AddParameters("@LoginID", DbType.String, loginId);
                dac.AddParameters("@GroupNo", DbType.Int32, groupNo);

                return JINI.Util.ConvertType.ToInt32(dac.ExcuteScalar("up_OrgChart_Delete_AddressBookGroup"));
            }
        }
        #endregion

        #region RemoveAddressBookMember - 사용자별 개인주소록 그룹의 멤버를 삭제한다. - 사용 x
        /// <summary>
        /// 사용자별 개인주소록 그룹의 멤버를 삭제한다.
        /// </summary>
        /// <param name="companyCode"></param>
        /// <param name="empId"></param>
        /// <param name="loginId"></param>
        /// <param name="groupNo"></param>
        /// <param name="email"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Required)]
        public int RemoveAddressBookMember(string companyCode, string empid, string loginId, int groupNo, List<string> emails)
        {
            int rtnValue = 0;

            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                foreach (string email in emails)
                {
                    dac.AddParameters("@CompanyCode", DbType.String, companyCode);
                    dac.AddParameters("@EmpID", DbType.String, empid);
                    dac.AddParameters("@LoginID", DbType.String, loginId);
                    dac.AddParameters("@GroupNo", DbType.Int32, groupNo);
                    dac.AddParameters("@Email", DbType.Int32, email);

                    dac.ExcuteScalar("up_OrgChart_Delete_AddressBookGroup");
                    rtnValue++;
                }
            }

            return rtnValue;
        }
        #endregion

        #region AddAddressBookMember - 사용자별 개인주소록 그룹에 멤버를 추가한다. - 사용 x
        /// <summary>
        /// 사용자별 개인주소록 그룹에 멤버를 추가한다.
        /// </summary>
        /// <param name="companyCode"></param>
        /// <param name="empid"></param>
        /// <param name="loginId"></param>
        /// <param name="groupNo"></param>
        /// <param name="emails"></param>
        /// <returns></returns>
        [Transaction(TransactionOption.Required)]
        public List<string> AddAddressBookMember(string companyCode, string empid, string loginId, int groupNo, List<string> emails)
        {
            List<string> noneUser = new List<string>();

            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                foreach (string email in emails)
                {
                    dac.AddParameters("@CompanyCode", DbType.String, companyCode);
                    dac.AddParameters("@EmpID", DbType.String, empid);
                    dac.AddParameters("@LoginID", DbType.String, loginId);
                    dac.AddParameters("@GroupNo", DbType.Int32, groupNo);
                    dac.AddParameters("@Email", DbType.Int32, email);

                    if (!(JINI.Util.ConvertType.ToInt32(dac.ExcuteScalar("up_OrgChart_Insert_AddressBookMember")) > 0))
                    {
                        noneUser.Add(email);
                    }
                }
            }

            return noneUser;
        }
        #endregion

        #region GetCustomGroupRule- 사용자 그룹 설정 - 사용 x
        /// <summary>
        /// 사용자 그룹 설정
        /// </summary>
        [Transaction(TransactionOption.Supported)]
        public Dictionary<string, CustomGroupRule> GetCustomGroupRule()
        {
            Dictionary<string, CustomGroupRule> CMGRule = new Dictionary<string, CustomGroupRule>();
            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                DataSet ds = dac.ExcuteDataSet("up_OrgChart_Select_CustomGroupRule");
                if (ds != null)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        CustomGroupRule rule = new CustomGroupRule();
                        string companyCode = Convert.ToString(dr["CompanyCode"]).Trim();
                        rule.MailDomainURI = Convert.ToString(dr["MailDomainURI"]).Trim();
                        rule.NameRulePrefix = Convert.ToString(dr["NameRulePrefix"]).Trim();
                        rule.NameRuleSuffix = Convert.ToString(dr["NameRuleSuffix"]).Trim();
                        if (!CMGRule.ContainsKey(companyCode))
                        {
                            CMGRule.Add(companyCode, rule);
                        }
                        else
                        {
                            CMGRule[companyCode] = rule;
                        }
                    }
                }
            }
            return CMGRule;
        }
        #endregion

        #region ListCustomGroup - 사용자 그룹 리스트 - 사용 x
        /// <summary>
        /// 사용자 그룹 리스트
        /// </summary>
        /// <param name="companyCode"></param>
        [Transaction(TransactionOption.Supported)]
        public DataSet ListCustomGroup(string companyCode)
        {
            using (DacConnecter dac = new DacConnecter("OrgChart"))
            {
                dac.AddParameters("@CompanyCode", DbType.String, "1");
                dac.AddParameters("@EmpID", DbType.String, "emp77771");

                return dac.ExcuteDataSet("up_OrgChart_List_AddressBookGroup");
            }
        }
        #endregion
    }

    #region CustomGroupRule Class
    /// <summary>
    /// CustomGroupRule Class
    /// </summary>
    public class CustomGroupRule
    {
        public string MailDomainURI = string.Empty;
        public string NameRulePrefix = string.Empty;
        public string NameRuleSuffix = string.Empty;

        public CustomGroupRule() { }
    }
    #endregion

    #region CustomGroupUserData Class
    /// <summary>
    /// CustomGroupUserData Class
    /// </summary>
    public class CustomGroupUserData
    {
        // TODO: --> 사번으로 할 때 Exception (case?)
        public static int CustomGroupUserDataSort(CustomGroupUserData user1, CustomGroupUserData user2)
        {
            return user1.employeeNumber.CompareTo(user2.employeeNumber);
        }

        /// <summary>
        /// primary key(로그인ID)
        /// </summary>
        public string sAMAccountName;

        /// <summary>
        /// 직책
        /// </summary>
        public string title;

        /// <summary>
        /// AD Display Name
        /// </summary>
        public string displayName;

        /// <summary>
        /// 사번
        /// </summary>
        public string employeeNumber;

        /// <summary>
        /// 회사
        /// </summary>
        public string company;

        /// <summary>
        /// 부서
        /// </summary>
        public string department;

        /// <summary>
        /// 직무 -> extensionAttribute3
        /// </summary>
        public string dutyName;

        /// <summary>
        /// 메일주소
        /// </summary>
        public string mail;

        /// <summary>
        /// 사내전화
        /// </summary>
        public string telephoneNumber;

        public CustomGroupUserData() { }
    }
    #endregion
}
