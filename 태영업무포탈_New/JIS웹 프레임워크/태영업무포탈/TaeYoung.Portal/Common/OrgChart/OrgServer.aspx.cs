using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using JINI.Base;
using TaeYoung.Biz;
using TaeYoung.Biz.Common;


namespace TaeYoung.Portal.Common.OrgChart
{
    public partial class OrgServer : PageBase
    {
        /// <summary>
        /// locale code of client
        /// </summary>
        protected string LocaleCode = "ko";

        protected void Page_Load(object sender, EventArgs e)
        {
            base.ProgramID = "ORGCHART";

            string strResponse = string.Empty;

            if (!IsPostBack)
            {
                LocaleCode = "ko";
            }

            if (Request.Params["langCode"] != null)
            {
                string selectedLanguage = Request.Params["langCode"];
                if (!LocaleCode.Equals(selectedLanguage))
                {
                    LocaleCode = selectedLanguage;
                    //CookieHelper.SetCookie("HPW_MENU_LANGUAGE_ID", LocaleCode);
                    //if (selectedLanguage.Equals("zh"))
                    //{
                    //    selectedLanguage = "zh-chs";
                    //}
                    //this.UICulture = selectedLanguage;
                    //System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(selectedLanguage);
                    //base.InitializeCulture();
                }
            }

            string strAction = Request.Params["action"];
            switch (strAction)
            {
                // Init, 사용자 정보, 회사리스트, 그룹
                case "GetInitialize":
                    strResponse = GetInitialize();
                    break;

                // 조직도 회사부서 트리
                case "GetCompanyDeptTree":
                    strResponse = GetCompanyDeptTree();
                    break;

                // 조직도의 선택그리드 데이터
                case "GetMemberListForApp":
                    strResponse = GetMemberListForApp();
                    break;

                // 회사별 그룹정보
                case "GetCompanyGroup":
                    strResponse = GetCompanyGroup();
                    break;

                default:
                    strResponse = "{}";
                    break;
            }

            Response.ContentType = "text/plain";
            Response.Write(strResponse);
            //Response.End();

        }

        #region GetCompanyGroup
        private string GetCompanyGroup()
        {
            DataSet dsGroup = null;
            DataSet dsAddGroup = null;

            string strCompanyCode = Request.Params["companyCode"];

            Dictionary<string, object> jsonObject = new Dictionary<string, object>();

            using (OrgMapBiz orgmapBiz = new OrgMapBiz())
            {
                //dsGroup = orgmapBiz.SelectMailGroupType(LocaleCode);
                dsAddGroup = orgmapBiz.SelectGroup(strCompanyCode, LocaleCode);
            }

            // 그룹
            if (dsGroup != null)// && dsGroup.Tables[0].Rows.Count > 0)
            {
                ArrayList jsonGroupArray = new ArrayList();
                foreach (DataRow drGroup in dsGroup.Tables[0].Rows)
                {
                    Dictionary<string, object> jsonGroupObject = new Dictionary<string, object>();
                    jsonGroupObject.Add("groupTypeCode", drGroup["MailGroupTypeCode"].ToString().Trim().ToUpper());
                    jsonGroupObject.Add("groupTypeName", drGroup["MailGroupTypeName"].ToString().Trim());
                    jsonGroupObject.Add("text", drGroup["MailGroupTypeName"].ToString().Trim());
                    jsonGroupArray.Add(jsonGroupObject);
                }
                jsonObject.Add("Group", jsonGroupArray);
            }

            // 회사그룹리스트
            if (dsAddGroup != null)
            {
                ArrayList jsonAddGroupArray = new ArrayList();

                foreach (DataRow drAddGroup in dsAddGroup.Tables[0].Rows)
                {
                    Dictionary<string, object> jsonAddGroupObject = new Dictionary<string, object>();
                    jsonAddGroupObject.Add("groupCode", drAddGroup["GroupCode"].ToString().Trim().ToUpper());
                    jsonAddGroupObject.Add("groupName", drAddGroup["GroupName"].ToString().Trim());
                    jsonAddGroupObject.Add("text", drAddGroup["GroupName"].ToString().Trim());
                    jsonAddGroupArray.Add(jsonAddGroupObject);
                }
                jsonObject.Add("AddGroup", jsonAddGroupArray);
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(jsonObject);
        }
        #endregion

        #region GetInitialize
        /// <summary>
        /// 조직도가 처음 로딩될 때 로그인한 유저의 정보, 확장 가능한 초기 정보를 조직도가 받게함
        /// </summary>
        /// <returns></returns>
        private string GetInitialize()
        {
            Dictionary<string, object> jsonObject = new Dictionary<string, object>();

            DataSet dsCompany = null;
            DataSet dsGroup = null;
            DataSet dsAddGroup = null;

            using (OrgMapBiz orgmapBiz = new OrgMapBiz())
            {
                dsCompany = orgmapBiz.SelectCompanyList(LocaleCode);
                //dsGroup = orgmapBiz.SelectMailGroupType(LocaleCode);
                dsAddGroup = orgmapBiz.SelectGroup(UserCompanyCode, LocaleCode);
            }

            // 사용자 정보
            jsonObject.Add("MyCompanyCode", UserCompanyCode);
            jsonObject.Add("UserEmail", UserEmail);
            jsonObject.Add("MyDeptSelectPath", UserDeptSelectPath);

            // 회사
            if (dsCompany != null && dsCompany.Tables.Count == 2)
            {
                ArrayList jsonInnerComArray = new ArrayList();
                //ArrayList jsonRelativeComArray = new ArrayList();

                // 자회사
                foreach (DataRow drMyCompany in dsCompany.Tables[0].Rows)
                {
                    Dictionary<string, object> jsonInnerComObject = new Dictionary<string, object>();
                    // Note: "iconCls" 로 아이콘 지정가능
                    jsonInnerComObject.Add("companyCode", drMyCompany["companyCode"].ToString().Trim().ToUpper());
                    jsonInnerComObject.Add("companyName", drMyCompany["companyName"].ToString().Trim());
                    jsonInnerComObject.Add("text", drMyCompany["companyName"].ToString().Trim());
                    jsonInnerComObject.Add("isRelative", "N");
                    if (drMyCompany["companyCode"].ToString().Trim().ToUpper().Equals(UserCompanyCode))
                    {
                        jsonInnerComObject.Add("checked", true);
                    }
                    jsonInnerComArray.Add(jsonInnerComObject);
                }

                jsonObject.Add("InnerCompany", jsonInnerComArray);
            }

            // 그룹
            if (dsGroup != null && dsGroup.Tables[0].Rows.Count > 0)
            {
                ArrayList jsonGroupArray = new ArrayList();
                foreach (DataRow drGroup in dsGroup.Tables[0].Rows)
                {
                    Dictionary<string, object> jsonGroupObject = new Dictionary<string, object>();
                    jsonGroupObject.Add("groupTypeCode", drGroup["MailGroupTypeCode"].ToString().Trim().ToUpper());
                    jsonGroupObject.Add("groupTypeName", drGroup["MailGroupTypeName"].ToString().Trim());
                    jsonGroupObject.Add("text", drGroup["MailGroupTypeName"].ToString().Trim());
                    jsonGroupArray.Add(jsonGroupObject);
                }
                jsonObject.Add("Group", jsonGroupArray);
            }

            // 회사그룹리스트
            if (dsAddGroup != null)
            {
                ArrayList jsonAddGroupArray = new ArrayList();

                foreach (DataRow drAddGroup in dsAddGroup.Tables[0].Rows)
                {
                    Dictionary<string, object> jsonAddGroupObject = new Dictionary<string, object>();
                    jsonAddGroupObject.Add("groupCode", drAddGroup["GroupCode"].ToString().Trim().ToUpper());
                    jsonAddGroupObject.Add("groupName", drAddGroup["GroupName"].ToString().Trim());
                    jsonAddGroupObject.Add("text", drAddGroup["GroupName"].ToString().Trim());
                    jsonAddGroupArray.Add(jsonAddGroupObject);
                }
                jsonObject.Add("AddGroup", jsonAddGroupArray);
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(jsonObject);
        }
        #endregion

        #region GetCompanyDeptTree
        /// <summary>
        /// 조직도의 회사부서 트리의 데이터를 JSON으로 보내줌
        /// </summary>
        protected string GetCompanyDeptTree()
        {
            string strParentID = Request.Params["node"];
            string strCompanyCode = Request.Params["companyCode"];
            string strIsRelative = Request.Params["isRelative"];

            string parentDeptCode = null;
            if (!strParentID.Equals("company-root"))
            {

                parentDeptCode = strParentID;
            }

            DataSet dsDeptTree = null;
            using (OrgMapBiz orgmapBiz = new OrgMapBiz())
            {
                dsDeptTree = orgmapBiz.SelectDeptTree(strCompanyCode, parentDeptCode, strIsRelative, LocaleCode);

                if (dsDeptTree != null)
                {
                    if (dsDeptTree.Tables[0].Rows.Count > 0)
                    {
                        ArrayList jsonArray = new ArrayList();
                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        foreach (DataRow row in dsDeptTree.Tables[0].Rows)
                        {
                            JsonDeptTreeNode node = new JsonDeptTreeNode();

                            // 내,외부 협력업체 추가에 따른 예외처리 2017-07-01 장윤호
                            string deptname = string.Empty;
                            switch (row["DeptCode"].ToString())
                            {
                                case "ZZZZZZZZZ0":
                                    deptname = "내부협력업체";
                                    break;
                                case "ZZZZZZZZZ1":
                                    deptname = "외부협력업체";
                                    break;
                                default:
                                    deptname = row["DeptName"].ToString();
                                    break;
                            }

                            node.id = Convert.ToString(row["DeptCode"]).Trim();
                            node.text = deptname.Trim();        //node.text = Convert.ToString(row["DeptName"]).Trim();
                            node.leaf = !Convert.ToBoolean(row["HasSubDept"]);
                            node.deptEmail = Convert.ToString(row["DeptEmail"]).Trim();
                            node.CompanyCode = Convert.ToString(row["CompanyCode"]).Trim();
                            node.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                            jsonArray.Add(node);
                        }
                        return serializer.Serialize(jsonArray);
                    }
                }
            }

            return "[]";
        }
        #endregion

        #region GetMemberListForApp
        private string GetMemberListForApp()
        {
            string strCompanyCode = Request.Params["companyCode"];
            string strIsRelative = Request.Params["isRelative"];

            // dept, group, member
            string strMode = Request.Params["mode"];
            // deptcode, groupcode, searchstring
            string strQuery = Request.Params["query"];
            // group, member
            string strType = Request.Params["type"];

            Dictionary<string, object> jsonObject = new Dictionary<string, object>();
            ArrayList jsonArray = new ArrayList();
            DataSet ds = null;
            string rtn = string.Empty;
            switch (strMode)
            {
                case "member":
                    using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                    {
                        ds = orgmapBiz.SelectSearchUser(strCompanyCode, strQuery, strIsRelative, LocaleCode);
                        if (ds != null)
                        {
                            jsonObject.Add("NumOfPerson", ds.Tables[0].Rows.Count);
                            foreach (DataRow row in ds.Tables[0].Rows)
                            {
                                JsonApproverDataFields data = new JsonApproverDataFields();
                                data.EmpID = Convert.ToString(row["REmpID"]).Trim();
                                data.LoginID = Convert.ToString(row["EmpID"]).Trim();
                                data.ADDisplayName = Convert.ToString(row["DisplayName"]).Trim();
                                data.UserName = Convert.ToString(row["UserName"]).Trim();
                                data.Email = Convert.ToString(row["Email"]).Trim();
                                data.Type = "USER";
                                //data.DeptDisplayName = "";
                                data.DeptCode = Convert.ToString(row["DeptCode"]).Trim();
                                data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                                //data.DeptEmail = "";
                                data.CompanyCode = Convert.ToString(row["CompanyCode"]).Trim();
                                data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                                data.DutyName = Convert.ToString(row["DutyName"]).Trim();
                                data.DutyCode = Convert.ToString(row["DutyCode"]).Trim();
                                data.JobCode = Convert.ToString(row["JobCode"]).Trim();
                                data.JobName = Convert.ToString(row["JobName"]).Trim();
                                data.RankCode = Convert.ToString(row["RankCode"]).Trim();
                                data.RankName = Convert.ToString(row["RankName"]).Trim();
                                data.CellPhone = Convert.ToString(row["CellPhone"]).Trim();
                                data.TeamChiefYN = Convert.ToString(row["TeamChiefYN"]).Trim();
                                data.ExtensionNumber = Convert.ToString(row["ExtensionNumber"]).Trim();
                                data.FaxNumber = Convert.ToString(row["FaxNumber"]).Trim();
                                data.SignID = Convert.ToString(row["SignID"]).Trim();
                                data.Icon = Convert.ToString(row["Icon"]).Trim();

                                jsonArray.Add(data);
                            }
                        }
                        jsonObject.Add("dataRoot", jsonArray);

                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        rtn = serializer.Serialize(jsonObject);
                    }
                    break;
                case "group":
                    using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                    {
                        ds = orgmapBiz.SelectGroupMember(strCompanyCode, strQuery, LocaleCode);
                        if (ds != null)
                        {
                            if (strType == "group")
                            {
                                foreach (DataRow row in ds.Tables[0].Rows)
                                {
                                    JsonApproverDataFields data = new JsonApproverDataFields();
                                    data.EmpID = Convert.ToString(row["GroupMail"]).Trim();
                                    data.LoginID = Convert.ToString(row["GroupMail"]).Trim();
                                    data.ADDisplayName = Convert.ToString(row["GroupName"]).Trim();
                                    data.Email = Convert.ToString(row["GroupMail"]).Trim();
                                    data.Type = "GROUP";
                                    data.UserName = Convert.ToString(row["GroupName"]).Trim();

                                    jsonArray.Add(data);
                                }
                            }

                            if (strType == "member")
                            {
                                jsonObject.Add("NumOfPerson", ds.Tables[1].Rows.Count);
                                foreach (DataRow row in ds.Tables[1].Rows)
                                {
                                    JsonApproverDataFields data = new JsonApproverDataFields();
                                    data.EmpID = Convert.ToString(row["REmpID"]).Trim();
                                    data.LoginID = Convert.ToString(row["EmpID"]).Trim();
                                    data.ADDisplayName = Convert.ToString(row["DisplayName"]).Trim();
                                    data.UserName = Convert.ToString(row["UserName"]).Trim();
                                    data.Email = Convert.ToString(row["Email"]).Trim();
                                    data.Type = "USER";
                                    //data.DeptDisplayName = "";
                                    data.DeptCode = Convert.ToString(row["DeptCode"]).Trim();
                                    data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                                    //data.DeptEmail = "";
                                    data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                                    data.CompanyCode = Convert.ToString(row["CompanyCode"]).Trim();
                                    data.DutyName = Convert.ToString(row["DutyName"]).Trim();
                                    data.DutyCode = Convert.ToString(row["DutyCode"]).Trim();
                                    data.JobCode = Convert.ToString(row["JobCode"]).Trim();
                                    data.JobName = Convert.ToString(row["JobName"]).Trim();
                                    data.RankCode = Convert.ToString(row["RankCode"]).Trim();
                                    data.RankName = Convert.ToString(row["RankName"]).Trim();
                                    data.CellPhone = Convert.ToString(row["CellPhone"]).Trim();
                                    data.TeamChiefYN = Convert.ToString(row["TeamChiefYN"]).Trim();
                                    data.ExtensionNumber = Convert.ToString(row["ExtensionNumber"]).Trim();
                                    data.FaxNumber = Convert.ToString(row["FaxNumber"]).Trim();
                                    data.SignID = Convert.ToString(row["SignID"]).Trim();
                                    data.Icon = Convert.ToString(row["Icon"]).Trim();

                                    jsonArray.Add(data);
                                }
                            }
                        }
                        jsonObject.Add("dataRoot", jsonArray);

                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        rtn = serializer.Serialize(jsonObject);
                    }
                    break;
                case "mailgroup":
                    using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                    {
                        //ds = orgmapBiz.SelectMailGroup(strQuery, strCompanyCode, LocaleCode);
                        //if (ds != null && ds.Tables[0] != null)
                        //{
                        //    foreach (DataRow row in ds.Tables[0].Rows)
                        //    {
                        //        JsonApproverDataFields data = new JsonApproverDataFields();
                        //        data.EmpID = Convert.ToString(row["GroupMail"]).Trim();
                        //        data.LoginID = Convert.ToString(row["GroupMail"]).Trim();
                        //        data.ADDisplayName = Convert.ToString(row["GroupName"]).Trim();
                        //        data.Email = Convert.ToString(row["GroupMail"]).Trim();
                        //        data.Type = "GROUP";
                        //        data.UserName = Convert.ToString(row["GroupName"]).Trim();

                        //        jsonArray.Add(data);
                        //    }
                        //}
                        jsonObject.Add("dataRoot", jsonArray);

                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        rtn = serializer.Serialize(jsonObject);
                    }
                    break;
                case "dept":
                    using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                    {
                        ds = orgmapBiz.SelectDeptMember(strQuery, strCompanyCode, strIsRelative, LocaleCode);
                        if (ds != null)
                        {
                            //부서는 나타내지 않는다.
                            //foreach (DataRow row in ds.Tables[0].Rows)
                            //{
                            //    JsonApproverDataFields data = new JsonApproverDataFields();
                            //    data.ADDisplayName = Convert.ToString(row["DeptName"]).Trim());
                            //    data.Email = Convert.ToString(row["DeptEmail"]).Trim();
                            //    data.Type = "DEPT";
                            //    data.UserName = Convert.ToString(row["DeptName"]).Trim());

                            //    jsonArray.Add(data);
                            //}

                            jsonObject.Add("NumOfPerson", ds.Tables[1].Rows.Count);
                            foreach (DataRow row in ds.Tables[1].Rows)
                            {
                                JsonApproverDataFields data = new JsonApproverDataFields();

                                data.EmpID = Convert.ToString(row["REmpID"]).Trim();
                                data.LoginID = Convert.ToString(row["EmpID"]).Trim();
                                data.ADDisplayName = Convert.ToString(row["DisplayName"]).Trim();
                                data.UserName = Convert.ToString(row["UserName"]).Trim();
                                data.Email = Convert.ToString(row["Email"]).Trim();
                                data.Type = "USER";
                                //data.DeptDisplayName = "";
                                data.DeptCode = Convert.ToString(row["DeptCode"]).Trim();
                                data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                                //data.DeptEmail = "";
                                data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                                data.CompanyCode = Convert.ToString(row["CompanyCode"]).Trim();
                                data.DutyName = Convert.ToString(row["DutyName"]).Trim();
                                data.DutyCode = Convert.ToString(row["DutyCode"]).Trim();
                                data.JobCode = Convert.ToString(row["JobCode"]).Trim();
                                data.JobName = Convert.ToString(row["JobName"]).Trim();
                                data.RankCode = Convert.ToString(row["RankCode"]).Trim();
                                data.RankName = Convert.ToString(row["RankName"]).Trim();
                                data.CellPhone = Convert.ToString(row["CellPhone"]).Trim();
                                data.TeamChiefYN = Convert.ToString(row["TeamChiefYN"]).Trim();
                                data.ExtensionNumber = Convert.ToString(row["ExtensionNumber"]).Trim();
                                data.FaxNumber = Convert.ToString(row["FaxNumber"]).Trim();
                                data.SignID = Convert.ToString(row["SignID"]).Trim();
                                data.Icon = Convert.ToString(row["Icon"]).Trim();

                                jsonArray.Add(data);
                            }
                        }
                        jsonObject.Add("dataRoot", jsonArray);

                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        rtn = serializer.Serialize(jsonObject);
                    }
                    break;
            }
            return string.IsNullOrEmpty(rtn) ? "{\"dataRoot\":[]}" : rtn;
        }
        #endregion

        #region Session
        protected string UserEmail
        {
            get
            {
                if (Session["UserEmail"] == null)
                {
                    SetSessionData();
                }

                return Session["UserEmail"].ToString();
            }
        }

        protected string UserCompanyCode
        {
            get
            {
                if (Session["UserCompanyCode"] == null)
                {
                    SetSessionData();
                }

                return Session["UserCompanyCode"].ToString();
            }
        }

        protected string UserDeptSelectPath
        {
            get
            {
                if (Session["UserDeptSelectPath"] == null)
                {
                    SetSessionData();
                }

                return Session["UserDeptSelectPath"].ToString();
            }
        }

        private void SetSessionData()
        {
            if (!string.IsNullOrEmpty(Document.UserInfo.LoginID))
            {
                DataSet dsUser = null;
                string compancycode = System.Web.Configuration.WebConfigurationManager.AppSettings["CompanyCode"];
                using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                {
                    dsUser = orgmapBiz.SelectUser(string.IsNullOrEmpty(compancycode) ? Document.UserInfo.CompanyCode : compancycode, Document.UserInfo.LoginID, LocaleCode);
                }

                // 사용자 정보
                if (dsUser != null && dsUser.Tables.Count == 2)
                {
                    DataRow drUser = dsUser.Tables[0].Rows[0];
                    StringBuilder sbUserDeptSelectPath = new StringBuilder();

                    // 사용자 회사코드
                    Session["UserCompanyCode"] = drUser["CompanyCode"].ToString().ToUpper().Trim();
                    // 사용자 Email
                    Session["UserEmail"] = drUser["Email"].ToString().Trim();

                    // 사용자 부서 상위 부서리스트
                    foreach (DataRow drDept in dsUser.Tables[1].Rows)
                    {
                        sbUserDeptSelectPath.Append("/");
                        sbUserDeptSelectPath.Append(drDept["DeptCode"].ToString().Trim());
                    }
                    Session["UserDeptSelectPath"] = sbUserDeptSelectPath.ToString();
                }
            }
            else
            {
                throw new Exception(GetResources("WebOrg", "NotKnowUserID"));
            }
        }

        #endregion

        #region MakeJSONErrorMessage
        private string MakeJSONErrorMessage(Exception ex)
        {
            Dictionary<string, object> jsonObject = new Dictionary<string, object>();
            jsonObject.Add("result", false);
            jsonObject.Add("ErrorMessage", ex.Message + "<br/>" + ex.StackTrace.Replace(Environment.NewLine, "<br/>"));

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(jsonObject);
        }

        private string MakeJSONErrorMessage(string strErrorMessage)
        {
            Dictionary<string, object> jsonObject = new Dictionary<string, object>();
            jsonObject.Add("result", false);
            jsonObject.Add("ErrorMessage", strErrorMessage);

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(jsonObject);
        }
        #endregion

        public string GetResources(string programid, string code)
        {
            return string.Empty;
        }
    }

    #region 회사부서 트리 JSON 데이터
    /// <summary>
    /// 회사부서 트리
    ///     id   : 부서코드
    ///     text : 부서명
    ///     leaf : leaf node 여부 : boolean
    ///     deptEmail : 부서 이메일
    /// </summary>
    public class JsonDeptTreeNode
    {
        public string id;
        public string text;
        public bool leaf;
        public string deptEmail;
        public string CompanyCode;
        public string CompanyName;

        public JsonDeptTreeNode()
        {
            id = string.Empty;
            text = string.Empty;
            leaf = false;

            CompanyCode = string.Empty;
            CompanyName = string.Empty;
        }
    }
    #endregion

    #region 결재 조직도 JSON 데이터
    /// <summary>
    /// 결재 조직도
    /// </summary>
    public class JsonApproverDataFields
    {
        public string EmpID;
        public string LoginID;
        public string ADDisplayName;
        public string UserName;
        public string Email;
        public string Type;
        public string DeptCode;
        public string DeptName;
        public string CompanyName;
        public string CompanyCode;
        public string DutyName;
        public string DutyCode;
        public string RankName;         // 직위
        public string RankCode;         // 직위
        public string JobName;          // 직책
        public string JobCode;          // 직책
        public string CellPhone;
        public string TeamChiefYN;
        public string ExtensionNumber;
        public string FaxNumber;
        public string SignID;
        public string Icon;

        public JsonApproverDataFields()
        {
            EmpID = string.Empty;
            LoginID = string.Empty;
            ADDisplayName = string.Empty;
            UserName = string.Empty;
            Email = string.Empty;
            Type = string.Empty;
            DeptCode = string.Empty;
            DeptName = string.Empty;
            CompanyName = string.Empty;
            CompanyCode = string.Empty;
            DutyName = string.Empty;
            DutyCode = string.Empty;
            RankName = string.Empty;
            RankCode = string.Empty;
            JobName = string.Empty;
            JobCode = string.Empty;
            CellPhone = string.Empty;
            TeamChiefYN = string.Empty;
            ExtensionNumber = string.Empty;
            FaxNumber = string.Empty;
            SignID = string.Empty;
            Icon = string.Empty;
        }
    }
    #endregion

    #region 메일 조직도 JSON 데이터
    /// <summary>
    /// 메일 조직도
    ///     {name:'EmpID'},		        // mandatory
    ///     {name:'ADDisplayName'},		// mandatory
    ///     {name:'Email'},				// mandatory
    ///     {name:'Type'},				// mandatory : '', 'USER', 'DEPT', 'GROUP'
    ///     {name:'RankName'},			// option : 직위
    ///     {name:'DutyName'},			// option : 직무
    ///     {name:'DeptName'},			// option : 부서
    ///     {name:'UserName'},			// option
    ///     {name:'CellPhone'},			// option : 휴대폰
    ///     {name:'ExtensionNumber'},	// option : 전화번호
    ///     {name:'FaxNumber'}			// option : Fax
    ///     {name:'CompanyName'}		// option : 회사
    /// </summary>
    public class JsonMailDataFields
    {
        public string EmpID;
        public string ADDisplayName;
        public string Email;
        public string Type;
        public string RankName;
        public string DutyName;
        public string DeptName;
        public string UserName;
        public string CellPhone;
        public string ExtensionNumber;
        public string FaxNumber;
        public string CompanyName;
        public string JobName;

        public JsonMailDataFields()
        {
            EmpID = string.Empty;
            ADDisplayName = string.Empty;
            Email = string.Empty;
            Type = string.Empty;
            RankName = string.Empty;
            DutyName = string.Empty;
            DeptName = string.Empty;
            UserName = string.Empty;
            CellPhone = string.Empty;
            ExtensionNumber = string.Empty;
            FaxNumber = string.Empty;
            CompanyName = string.Empty;
            JobName = string.Empty;
        }
    }
    #endregion

    #region App 조직도 JSON 데이터
    /// <summary>
    /// APP 조직도 JSON 데이터
    /// </summary>
    public class JsonAppDataFields
    {
        public string DisplayName;              // Name
        public string ADDisplayName;            // AD의 DisplayName
        public int entryType;                   // 0: 부서, 1: 그룹, 2:사용자
        public string addr;                     // Email Address
        public string AccountId;                // 사용자 로그인 ID
        public string DeptName;                 // 부서이름
        public string DeptCode;                 // 부서코드
        public string RankName;                 // 직위
        public string RankCode;                 // 직위
        public string JobName;                  // 직책
        public string JobCode;                  // 직책
        public string DutyCode;                 // 직무코드
        public string DutyName;                 // 직무
        public string CompanyCode;              // 회사코드
        public string CompanyName;              // 회사이름
        public string EmpID;                    // 사번
        public string CellPhone;                // 휴대폰번호
        public string ExtensionNumber;          // 사내전화번호
        public string FaxNumber;                // FAX번호
        public string TeamChiefYN;              // 팀장여부
        public string SignID;                   // 사인ID
        public string Kostl;                    // 코스트센터
        public string Icon;
        public string SiteCompanyCode;          // Site 회사코드
        public string SiteCompanyName;          // Site 회사이름
        public string Culture;

        public JsonAppDataFields()
        {
            DisplayName = string.Empty;
            ADDisplayName = string.Empty;
            entryType = 2;              //디폴트 유저
            addr = string.Empty;
            AccountId = string.Empty;
            DeptName = string.Empty;
            DeptCode = string.Empty;
            RankName = string.Empty;
            RankCode = string.Empty;
            JobName = string.Empty;
            JobCode = string.Empty;
            DutyCode = string.Empty;
            DutyName = string.Empty;
            CompanyCode = string.Empty;
            CompanyName = string.Empty;
            EmpID = string.Empty;
            CellPhone = string.Empty;
            ExtensionNumber = string.Empty;
            FaxNumber = string.Empty;
            TeamChiefYN = string.Empty;
            SignID = string.Empty;
            Kostl = string.Empty;
            Icon = string.Empty;
            SiteCompanyCode = string.Empty;
            SiteCompanyName = string.Empty;
            Culture = string.Empty;
        }
    }
    #endregion
}