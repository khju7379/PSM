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
    public partial class OrgMapServer : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strResponse = string.Empty;
            try
            {

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
                    case "getInitialize":
                        strResponse = getInitialize();
                        break;

                    // 조직도 회사부서 트리
                    case "getCompanyDeptTree":
                        strResponse = getCompanyDeptTree();
                        break;

                    // MAIL 조직도
                    case "getMemberListForMail":
                        strResponse = getMemberListForMail();
                        break;

                    // APP 조직도
                    case "getMemberListForApp":
                        strResponse = getMemberListForApp();
                        break;
                    case "getCompanyGroup":
                        strResponse = getCompanyGroup();
                        break;

                    #region 사용자 메일 그룹
                    case "CMGInitialize":
                        strResponse = getCMGInitialize();
                        break;
                    case "createCustomGroup":
                        strResponse = createCustomGroup();
                        break;
                    case "editCustomGroup":
                        strResponse = editCustomGroup();
                        break;
                    case "deleteCustomGroup":
                        strResponse = deleteCustomGroup();
                        break;
                    case "deleteCustomGroupMember":
                        strResponse = deleteCustomGroupMember();
                        break;
                    case "addCustomGroupMember":
                        strResponse = addCustomGroupMember();
                        break;
                    case "getCustomGroup":
                        strResponse = getCustomGroup();
                        break;
                    case "getCustomGroupMember":
                        strResponse = getCustomGroupMember();
                        break;
                    #endregion

                    default:
                        strResponse = "{}";
                        break;
                }
            }
            catch (Exception ex)
            {
                throw ex;

            }
            finally
            {
            }

            Response.ContentType = "text/plain";
            Response.Write(strResponse);
            //Response.End();
        }

        #region getCompanyGroup
        private string getCompanyGroup()
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

        #region getMemberListForApp
        /// <summary>
        /// APP 조직도
        /// </summary>
        /// <returns></returns>
        private string getMemberListForApp()
        {
            string strCompanyCode = Request.Params["companyCode"];
            string strIsRelative = Request.Params["isRelative"];
            string strIsOnlyUser = Request.Params["isOnlyUser"];
            string strIsDeactive = Request.Params["isDeactive"];

            bool isOnlyUser = true;
            if (!string.IsNullOrEmpty(strIsOnlyUser) && strIsOnlyUser.Equals("N"))
            {
                isOnlyUser = false;
            }

            // dept, member
            string strMode = Request.Params["mode"];
            // deptcode, searchstring
            string strQuery = Request.Params["query"];
            // group, member
            string strType = Request.Params["type"];

            Dictionary<string, object> jsonObject = new Dictionary<string, object>();
            ArrayList jsonArray = new ArrayList();
            DataSet ds = null;
            switch (strMode)
            {
                case "group":
                    if (!string.IsNullOrEmpty(strQuery))
                    {
                        if (strType == "member")
                        {
                            using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                            {
                                ds = orgmapBiz.SelectGroupMember(strCompanyCode, strQuery, LocaleCode);
                            }

                            jsonObject.Add("NumOfPerson", ds.Tables[1].Rows.Count);
                            foreach (DataRow row in ds.Tables[1].Rows)
                            {
                                JsonAppDataFields data = new JsonAppDataFields();
                                data.AccountId = Convert.ToString(row["EmpID"]).Trim();
                                data.ADDisplayName = Convert.ToString(row["DisplayName"]).Trim();
                                data.addr = Convert.ToString(row["Email"]).Trim();
                                data.CellPhone = Convert.ToString(row["CellPhone"]).Trim();
                                data.CompanyCode = Convert.ToString(row["CompanyCode"]).Trim();
                                data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                                data.DeptCode = Convert.ToString(row["DeptCode"]).Trim();
                                data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                                data.DisplayName = Convert.ToString(row["UserName"]).Trim();
                                data.DutyCode = Convert.ToString(row["DutyCode"]).Trim();
                                data.DutyName = Convert.ToString(row["DutyName"]).Trim();
                                //data.EmpID = Convert.ToString(row["REmpID"]).Trim();
                                data.EmpID = Convert.ToString(row["REmpID"]).Trim();
                                //data.entryType = 2
                                data.ExtensionNumber = Convert.ToString(row["ExtensionNumber"]).Trim();
                                data.FaxNumber = Convert.ToString(row["FaxNumber"]).Trim();
                                data.JobCode = Convert.ToString(row["JobCode"]).Trim();
                                data.JobName = Convert.ToString(row["JobName"]).Trim();
                                data.RankCode = Convert.ToString(row["RankCode"]).Trim();
                                data.RankName = Convert.ToString(row["RankName"]).Trim();
                                data.TeamChiefYN = Convert.ToString(row["TeamChiefYN"]).Trim();
                                data.Kostl = row["KOSTL"].ToString().Trim();
                                data.Icon = row["ICON"].ToString().Trim();
                                data.SignID = Convert.ToString(row["SignID"]).Trim();

                                jsonArray.Add(data);
                            }
                        }
                        else if (strQuery.Equals("TYPECMG"))
                        {
                            //using (OrgMapBiz cmgBiz = new OrgMapBiz())
                            //{
                            //    ds = cmgBiz.ListCustomGroup(strCompanyCode);
                            //    if (ds != null && ds.Tables[0] != null)
                            //    {
                            //        foreach (DataRow row in ds.Tables[0].Rows)
                            //        {
                            //            JsonMailDataFields data = new JsonMailDataFields();
                            //            data.ADDisplayName = Convert.ToString(row["GroupName"]).Trim();
                            //            data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                            //            data.Email = Convert.ToString(row["GroupMail"]).Trim();
                            //            data.Type = "GROUP";
                            //            data.UserName = Convert.ToString(row["GroupName"]).Trim();

                            //            jsonArray.Add(data);
                            //        }
                            //    }
                            //}
                        }
                        else
                        {
                            // 메일 조직도 그룹
                            //using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                            //{
                            //    ds = orgmapBiz.SelectMailGroup(strQuery, strCompanyCode, LocaleCode);
                            //    if (ds != null && ds.Tables[0] != null)
                            //    {
                            //        foreach (DataRow row in ds.Tables[0].Rows)
                            //        {
                            //            JsonAppDataFields data = new JsonAppDataFields();
                            //            data.DisplayName = Convert.ToString(row["GroupName"]).Trim();
                            //            data.addr = Convert.ToString(row["GroupMail"]).Trim();
                            //            data.entryType = 1;

                            //            jsonArray.Add(data);
                            //        }
                            //    }
                            //}
                        }
                    }
                    break;
                case "member":
                    using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                    {
                        ds = orgmapBiz.SelectSearchUser(strCompanyCode, strQuery, strIsRelative, LocaleCode, strIsDeactive);
                        if (ds != null)
                        {
                            jsonObject.Add("NumOfPerson", ds.Tables[0].Rows.Count);
                            foreach (DataRow row in ds.Tables[0].Rows)
                            {
                                JsonAppDataFields data = new JsonAppDataFields();
                                data.AccountId = Convert.ToString(row["EmpID"]).Trim();
                                data.ADDisplayName = Convert.ToString(row["DisplayName"]).Trim();
                                data.addr = Convert.ToString(row["Email"]).Trim();
                                data.CellPhone = Convert.ToString(row["CellPhone"]).Trim();
                                data.CompanyCode = Convert.ToString(row["CompanyCode"]).Trim();
                                data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                                data.DeptCode = Convert.ToString(row["DeptCode"]).Trim();
                                data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                                data.DisplayName = Convert.ToString(row["UserName"]).Trim();
                                data.DutyCode = Convert.ToString(row["DutyCode"]).Trim();
                                data.DutyName = Convert.ToString(row["DutyName"]).Trim();
                                //data.EmpID = Convert.ToString(row["REmpID"]).Trim();
                                data.EmpID = Convert.ToString(row["REmpID"]).Trim();
                                //data.entryType = 2
                                data.ExtensionNumber = Convert.ToString(row["ExtensionNumber"]).Trim();
                                data.FaxNumber = Convert.ToString(row["FaxNumber"]).Trim();
                                data.JobCode = Convert.ToString(row["JobCode"]).Trim();
                                data.JobName = Convert.ToString(row["JobName"]).Trim();
                                data.RankCode = Convert.ToString(row["RankCode"]).Trim();
                                data.RankName = Convert.ToString(row["RankName"]).Trim();
                                data.TeamChiefYN = Convert.ToString(row["TeamChiefYN"]).Trim();
                                data.SignID = Convert.ToString(row["SignID"]).Trim();
                                data.Kostl = row["KOSTL"].ToString().Trim();
                                data.Icon = row["ICON"].ToString().Trim();

                                // SiteCompany 추가 2017-07-14 장윤호
                                data.SiteCompanyCode = Convert.ToString(row["SiteCompanyCode"]).Trim();
                                data.SiteCompanyName = Convert.ToString(row["SiteCompanyName"]).Trim();
                                data.Culture = Convert.ToString(row["CULTURE"]).Trim();

                                jsonArray.Add(data);
                            }
                        }
                    }
                    break;
                case "dept":
                    using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                    {
                        ds = orgmapBiz.SelectDeptMember(strQuery, strCompanyCode, strIsRelative, LocaleCode, strIsDeactive);
                        if (ds != null)
                        {
                            if (isOnlyUser == false)
                            {
                                foreach (DataRow row in ds.Tables[0].Rows)
                                {
                                    JsonAppDataFields data = new JsonAppDataFields();
                                    data.addr = Convert.ToString(row["DeptEmail"]).Trim();
                                    data.CompanyCode = Convert.ToString(row["CompanyCode"]).Trim();
                                    data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                                    data.DeptCode = Convert.ToString(row["DeptCode"]).Trim();
                                    data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                                    data.DisplayName = Convert.ToString(row["DeptName"]).Trim();
                                    data.entryType = 0;

                                    jsonArray.Add(data);
                                }
                            }
                            jsonObject.Add("NumOfPerson", ds.Tables[1].Rows.Count);
                            foreach (DataRow row in ds.Tables[1].Rows)
                            {
                                JsonAppDataFields data = new JsonAppDataFields();
                                data.AccountId = Convert.ToString(row["EmpID"]).Trim();
                                data.ADDisplayName = Convert.ToString(row["DisplayName"]).Trim();
                                data.addr = Convert.ToString(row["Email"]).Trim();
                                data.CellPhone = Convert.ToString(row["CellPhone"]).Trim();
                                data.CompanyCode = Convert.ToString(row["CompanyCode"]).Trim();
                                data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                                data.DeptCode = Convert.ToString(row["DeptCode"]).Trim();
                                data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                                data.DisplayName = Convert.ToString(row["UserName"]).Trim();
                                data.DutyCode = Convert.ToString(row["DutyCode"]).Trim();
                                data.DutyName = Convert.ToString(row["DutyName"]).Trim();
                                //data.EmpID = Convert.ToString(row["REmpID"]).Trim();
                                data.EmpID = Convert.ToString(row["REmpID"]).Trim();
                                //data.entryType = 2
                                data.ExtensionNumber = Convert.ToString(row["ExtensionNumber"]).Trim();
                                data.FaxNumber = Convert.ToString(row["FaxNumber"]).Trim();
                                data.JobCode = Convert.ToString(row["JobCode"]).Trim();
                                data.JobName = Convert.ToString(row["JobName"]).Trim();
                                data.RankCode = Convert.ToString(row["RankCode"]).Trim();
                                data.RankName = Convert.ToString(row["RankName"]).Trim();
                                data.TeamChiefYN = Convert.ToString(row["TeamChiefYN"]).Trim();
                                data.SignID = Convert.ToString(row["SignID"]).Trim();
                                data.Kostl = row["KOSTL"].ToString().Trim();
                                data.Icon = row["ICON"].ToString().Trim();

                                // SiteCompany 추가 2017-05-08 장윤호
                                data.SiteCompanyCode = Convert.ToString(row["SiteCompanyCode"]).Trim();
                                data.SiteCompanyName = Convert.ToString(row["SiteCompanyName"]).Trim();
                                data.Culture = Convert.ToString(row["CULTURE"]).Trim();

                                jsonArray.Add(data);
                            }
                        }
                    }
                    break;
                case "onlyDept":
                    using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                    {
                        ds = orgmapBiz.SelectDeptMember(strQuery, strCompanyCode, strIsRelative, LocaleCode);
                        if (ds != null)
                        {
                            if (isOnlyUser == false)
                            {
                                foreach (DataRow row in ds.Tables[0].Rows)
                                {
                                    JsonAppDataFields data = new JsonAppDataFields();
                                    data.addr = Convert.ToString(row["DeptEmail"]).Trim();
                                    data.CompanyCode = Convert.ToString(row["CompanyCode"]).Trim();
                                    data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                                    data.DeptCode = Convert.ToString(row["DeptCode"]).Trim();
                                    data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                                    data.DisplayName = Convert.ToString(row["DeptName"]).Trim();
                                    data.entryType = 0;

                                    jsonArray.Add(data);
                                }
                            }
                        }
                    }
                    break;
                case "searchDept":
                    using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                    {
                        ds = orgmapBiz.SelectSearchDept(strCompanyCode, strQuery, LocaleCode);
                        if (ds != null)
                        {
                            foreach (DataRow row in ds.Tables[0].Rows)
                            {
                                JsonAppDataFields data = new JsonAppDataFields();
                                data.ADDisplayName = Convert.ToString(row["DisplayName"]).Trim();
                                data.addr = Convert.ToString(row["Email"]).Trim();
                                data.CompanyCode = Convert.ToString(row["CompanyCode"]).Trim();
                                data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                                data.DeptCode = Convert.ToString(row["DeptCode"]).Trim();
                                data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                                data.DisplayName = Convert.ToString(row["DeptName"]).Trim();
                                data.entryType = 0;

                                jsonArray.Add(data);
                            }
                        }
                    }
                    break;
                case "_contacts":
                    if (!string.IsNullOrEmpty(UserEmail))
                    {
                        List<CustomGroupUserData> memberList = new List<CustomGroupUserData>();

                        //using (OrgMapBiz conBiz = new OrgMapBiz())
                        //{
                        //    memberList = conBiz.ListAddressBookMemberAll(UserCompanyCode, Document.UserInfo.EmpID);
                        //}
                        if (memberList.Count > 0)
                        {
                            jsonObject.Add("NumOfPerson", memberList.Count);
                            foreach (CustomGroupUserData person in memberList)
                            {
                                JsonAppDataFields data = new JsonAppDataFields();
                                data.AccountId = person.employeeNumber;// Convert.ToString(row["EmpID"]).Trim();
                                data.ADDisplayName = person.displayName;// Convert.ToString(row["DisplayName"]).Trim();
                                data.addr = person.mail;//// Convert.ToString(row["Email"]).Trim();
                                data.CellPhone = person.telephoneNumber;// Convert.ToString(row["CellPhone"]).Trim();
                                data.CompanyCode = string.Empty;// Convert.ToString(row["CompanyCode"]).Trim();
                                data.CompanyName = person.company;// Convert.ToString(row["CompanyName"]).Trim();
                                data.DeptCode = string.Empty;// Convert.ToString(row["DeptCode"]).Trim();
                                data.DeptName = person.department;  // Convert.ToString(row["DeptName"]).Trim();
                                data.DisplayName = person.displayName;// Convert.ToString(row["UserName"]).Trim();
                                data.DutyCode = string.Empty;// Convert.ToString(row["DutyCode"]).Trim();
                                data.DutyName = string.Empty;// Convert.ToString(row["DutyName"]).Trim();
                                //data.EmpID = Convert.ToString(row["REmpID"]).Trim();
                                data.EmpID = person.employeeNumber;// Convert.ToString(row["REmpID"]).Trim();
                                //data.entryType = 2
                                data.ExtensionNumber = person.telephoneNumber;// string.Empty;    // Convert.ToString(row["ExtensionNumber"]).Trim();
                                data.FaxNumber = string.Empty;// Convert.ToString(row["FaxNumber"]).Trim();
                                data.JobCode = string.Empty;// Convert.ToString(row["JobCode"]).Trim();
                                data.JobName = person.dutyName;// Convert.ToString(row["JobName"]).Trim();
                                data.RankCode = string.Empty;// Convert.ToString(row["RankCode"]).Trim();
                                data.RankName = person.title;// Convert.ToString(row["RankName"]).Trim();
                                data.TeamChiefYN = string.Empty;// Convert.ToString(row["TeamChiefYN"]).Trim();
                                data.Icon = string.Empty;

                                jsonArray.Add(data);
                            }
                        }
                    }
                    break;
            }
            jsonObject.Add("dataRoot", jsonArray);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(jsonObject);
        }
        #endregion

        #region getMemberListForMail
        /// <summary>
        /// MAIL 조직도
        /// </summary>
        /// <returns></returns>
        private string getMemberListForMail()
        {
            string strCompanyCode = Request.Params["companyCode"];
            string strIsRelative = Request.Params["isRelative"];

            // dept, group, member, contacts, team
            string strMode = Request.Params["mode"];
            // deptcode, groupcode, searchstring
            string strQuery = Request.Params["query"];

            Dictionary<string, object> jsonObject = new Dictionary<string, object>();
            ArrayList jsonArray = new ArrayList();
            DataSet ds = null;
            switch (strMode)
            {
                #region 팀연락처
                case "addgrp":
                    if (!string.IsNullOrEmpty(UserEmail))
                    {
                        List<CustomGroupUserData> memberList = new List<CustomGroupUserData>();

                        using (OrgMapBiz conBiz = new OrgMapBiz())
                        {
                            memberList = conBiz.ListAddressBookMember(UserCompanyCode, Document.UserInfo.EmpID, ConvertToInt32(strQuery));
                        }

                        jsonObject.Add("NumOfPerson", memberList.Count);
                        foreach (CustomGroupUserData person in memberList)
                        {
                            JsonMailDataFields data = new JsonMailDataFields();
                            data.ADDisplayName = person.displayName;
                            data.UserName = person.displayName;
                            data.CompanyName = person.company;
                            data.CellPhone = person.telephoneNumber;
                            data.ExtensionNumber = person.telephoneNumber;
                            data.RankName = person.title;
                            data.Email = person.mail;
                            //data.EmpID = person.Id;

                            data.Type = "CONTACTS_USER";
                            jsonArray.Add(data);
                        }
                    }
                    break;
                case "team":
                    //CopWS.EApprovalWS copWs = new CopWS.EApprovalWS();
                    //try
                    //{
                    //    copWs.Timeout = Skcc.Configuration.SkccFxConfigManager.GetInt32("CopWSTimeout");
                    //    string copWsAccount = Skcc.Configuration.SkccFxConfigManager.GetString("CopWSAccountID");
                    //    string copWsPassword = Skcc.Configuration.SkccFxConfigManager.GetString("CopWSPassword");
                    //    if (!string.IsNullOrEmpty(copWsAccount) && !string.IsNullOrEmpty(copWsPassword))
                    //    {
                    //        copWs.UseDefaultCredentials = false;
                    //        copWs.Credentials = new System.Net.NetworkCredential(copWsAccount, copWsPassword);
                    //    }
                    //}
                    //catch { }//ingnore
                    //ds = copWs.GetCoPTeamRoomAcquaintance(strQuery);
                    //if (ds != null && ds.Tables.Count != 0)
                    //{
                    //    jsonObject.Add("NumOfPerson", ds.Tables[0].Rows.Count);
                    //    foreach (DataRow row in ds.Tables[0].Rows)
                    //    {
                    //        JsonMailDataFields data = new JsonMailDataFields();
                    //        //data.ADDisplayName = Convert.ToString(row["DisplayName"]).Trim();
                    //        data.CellPhone = Convert.ToString(row["CellPhone"]).Trim();
                    //        //data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                    //        data.Email = Convert.ToString(row["Email"]).Trim();
                    //        //data.EmpID = Convert.ToString(row["EmpID"]).Trim();
                    //        data.ExtensionNumber = Convert.ToString(row["WorkPhone"]).Trim();
                    //        data.FaxNumber = Convert.ToString(row["WorkFax"]).Trim();
                    //        data.RankName = Convert.ToString(row["JobTitle"]).Trim();
                    //        data.Type = "USER";
                    //        data.UserName = Convert.ToString(row["FullName"]).Trim();
                    //        data.CompanyName = Convert.ToString(row["Company"]).Trim();
                    //        //data.DutyName = Convert.ToString(row["DutyName"]).Trim();

                    //        jsonArray.Add(data);
                    //    }
                    //}
                    break;
                #endregion
                #region 개인연락처
                case "contacts":
                    if (!string.IsNullOrEmpty(UserEmail))
                    {
                        List<CustomGroupUserData> memberList = new List<CustomGroupUserData>();
                        DataSet dsG = null;

                        using (OrgMapBiz conBiz = new OrgMapBiz())
                        {
                            //dsG = conBiz.ListAddressBookGroup(UserCompanyCode, Document.UserInfo.EmpID);
                            //memberList = conBiz.ListAddressBookMemberAll(UserCompanyCode, Document.UserInfo.EmpID);
                        }

                        if (dsG != null && dsG.Tables[0].Rows.Count > 0)
                        {
                            foreach (DataRow dr in dsG.Tables[0].Rows)
                            {
                                JsonMailDataFields data = new JsonMailDataFields();
                                data.ADDisplayName = dr["GroupName"].ToString();
                                data.UserName = dr["GroupName"].ToString();
                                data.Email = dr["GroupMail"].ToString();
                                data.Type = "CONTACTS_GROUP";
                                jsonArray.Add(data);
                            }
                        }
                        if (memberList.Count > 0)
                        {
                            jsonObject.Add("NumOfPerson", memberList.Count);
                            foreach (CustomGroupUserData person in memberList)
                            {
                                JsonMailDataFields data = new JsonMailDataFields();
                                data.ADDisplayName = person.displayName;
                                data.UserName = person.displayName;
                                data.CompanyName = person.company;
                                data.CellPhone = person.telephoneNumber;
                                data.ExtensionNumber = person.telephoneNumber;
                                data.RankName = person.title;
                                data.Email = person.mail;
                                //data.EmpID = person.Id;

                                data.Type = "CONTACTS_USER";
                                jsonArray.Add(data);
                            }
                        }
                        //ContactsDac contactDac = new ContactsDac();
                        //ExchangeContacts contacts = contactDac.GetContacts(UserEmail);

                        //if (contacts != null)
                        //{
                        //    if (contacts.MailGroupContacts != null)
                        //    {
                        //        foreach (MailGroupContacts mailGroup in contacts.MailGroupContacts)
                        //        {
                        //            JsonMailDataFields data = new JsonMailDataFields();
                        //            data.ADDisplayName = mailGroup.DisplayName;
                        //            data.UserName = mailGroup.DisplayName;
                        //            data.Email = mailGroup.DisplayName;
                        //            data.Type = "CONTACTS_GROUP";
                        //            jsonArray.Add(data);
                        //        }
                        //    }
                        //    if (contacts.PersonContacts != null)
                        //    {
                        //        jsonObject.Add("NumOfPerson", contacts.PersonContacts.Count);
                        //        foreach (PersonContacts person in contacts.PersonContacts)
                        //        {
                        //            //if(string.IsNullOrEmpty(person.EmailAddress)) continue;

                        //            JsonMailDataFields data = new JsonMailDataFields();
                        //            data.ADDisplayName = person.DisplayName;
                        //            data.UserName = person.DisplayName;
                        //            data.CompanyName = person.CompanyName;
                        //            data.CellPhone = person.MobilePhone;
                        //            data.ExtensionNumber = person.PhoneNumber;
                        //            data.RankName = person.JobTitle;
                        //            data.Email = person.EmailAddress;
                        //            //data.EmpID = person.Id;

                        //            data.Type = "CONTACTS_USER";
                        //            jsonArray.Add(data);
                        //        }
                        //    }
                        //}
                    }
                    break;
                #endregion
                #region 검색 결과
                case "member":
                    using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                    {
                        ds = orgmapBiz.SelectSearchUser(strCompanyCode, strQuery, strIsRelative, LocaleCode);
                        if (ds != null)
                        {
                            jsonObject.Add("NumOfPerson", ds.Tables[0].Rows.Count);
                            foreach (DataRow row in ds.Tables[0].Rows)
                            {
                                JsonMailDataFields data = new JsonMailDataFields();
                                data.ADDisplayName = Convert.ToString(row["DisplayName"]).Trim();
                                data.CellPhone = Convert.ToString(row["CellPhone"]).Trim();
                                data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                                data.Email = Convert.ToString(row["Email"]).Trim();
                                data.EmpID = Convert.ToString(row["EmpID"]).Trim();
                                data.ExtensionNumber = Convert.ToString(row["ExtensionNumber"]).Trim();
                                data.FaxNumber = Convert.ToString(row["FaxNumber"]).Trim();
                                data.RankName = Convert.ToString(row["RankName"]).Trim();
                                data.Type = "USER";
                                data.UserName = Convert.ToString(row["UserName"]).Trim();
                                data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                                data.DutyName = Convert.ToString(row["DutyName"]).Trim();
                                data.JobName = Convert.ToString(row["JobName"]).Trim();

                                jsonArray.Add(data);
                            }
                        }
                    }
                    break;
                #endregion
                #region 부서
                case "dept":
                    using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                    {
                        ds = orgmapBiz.SelectDeptMember(strQuery, strCompanyCode, strIsRelative, LocaleCode);
                        if (ds != null)
                        {
                            foreach (DataRow row in ds.Tables[0].Rows)
                            {
                                JsonMailDataFields data = new JsonMailDataFields();
                                data.ADDisplayName = Convert.ToString(row["DeptName"]).Trim();
                                data.Email = Convert.ToString(row["DeptEmail"]).Trim();
                                data.Type = "DEPT";
                                data.UserName = Convert.ToString(row["DeptName"]).Trim();

                                // 부서정보의 Email이 없으면 데이터를 보내주지 않는다. 관계사의 경우는 안보이게 된다.
                                if (!string.IsNullOrEmpty(data.Email))
                                {
                                    jsonArray.Add(data);
                                }
                            }

                            jsonObject.Add("NumOfPerson", ds.Tables[1].Rows.Count);
                            foreach (DataRow row in ds.Tables[1].Rows)
                            {
                                JsonMailDataFields data = new JsonMailDataFields();
                                data.ADDisplayName = Convert.ToString(row["DisplayName"]).Trim();
                                data.CellPhone = Convert.ToString(row["CellPhone"]).Trim();
                                data.DeptName = Convert.ToString(row["DeptName"]).Trim();
                                data.Email = Convert.ToString(row["Email"]).Trim();
                                data.EmpID = Convert.ToString(row["EmpID"]).Trim();
                                data.ExtensionNumber = Convert.ToString(row["ExtensionNumber"]).Trim();
                                data.FaxNumber = Convert.ToString(row["FaxNumber"]).Trim();
                                data.RankName = Convert.ToString(row["RankName"]).Trim();
                                data.Type = "USER";
                                data.UserName = Convert.ToString(row["UserName"]).Trim();
                                data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                                data.DutyName = Convert.ToString(row["DutyName"]).Trim();
                                data.JobName = Convert.ToString(row["JobName"]).Trim();

                                jsonArray.Add(data);
                            }
                        }
                    }
                    break;
                #endregion
                #region 그룹
                case "group":
                    if (!string.IsNullOrEmpty(strQuery))
                    {
                        if (strQuery.Equals("TYPECMG"))
                        {
                            //using (OrgMapBiz cmgBiz = new OrgMapBiz())
                            //{
                            //    ds = cmgBiz.ListCustomGroup(strCompanyCode);
                            //    if (ds != null && ds.Tables[0] != null)
                            //    {
                            //        foreach (DataRow row in ds.Tables[0].Rows)
                            //        {
                            //            JsonMailDataFields data = new JsonMailDataFields();
                            //            data.ADDisplayName = Convert.ToString(row["GroupName"]).Trim();
                            //            data.CompanyName = Convert.ToString(row["CompanyName"]).Trim();
                            //            data.Email = Convert.ToString(row["GroupMail"]).Trim();
                            //            data.Type = "GROUP";
                            //            data.UserName = Convert.ToString(row["GroupName"]).Trim();

                            //            jsonArray.Add(data);
                            //        }
                            //    }
                            //}
                        }
                        else
                        {
                            // 메일 조직도 그룹
                            //using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                            //{
                            //    ds = orgmapBiz.SelectMailGroup(strQuery, strCompanyCode, LocaleCode);
                            //    if (ds != null && ds.Tables[0] != null)
                            //    {
                            //        foreach (DataRow row in ds.Tables[0].Rows)
                            //        {
                            //            JsonMailDataFields data = new JsonMailDataFields();
                            //            data.ADDisplayName = Convert.ToString(row["GroupName"]).Trim();
                            //            data.Email = Convert.ToString(row["GroupMail"]).Trim();
                            //            data.Type = "GROUP";
                            //            data.UserName = Convert.ToString(row["GroupName"]).Trim();

                            //            jsonArray.Add(data);
                            //        }
                            //    }
                            //}
                        }
                    }
                    break;
                #endregion
            }
            jsonObject.Add("dataRoot", jsonArray);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(jsonObject);
        }
        #endregion

        #region 사용자 메일 그룹

        #region getCMGInitialize
        private string getCMGInitialize()
        {
            if (CMGAdmin == false) throw new Exception(GetResources("WebOrg", "NotPermissions"));

            Dictionary<string, object> jsonObject = new Dictionary<string, object>();

            DataSet dsCompany = null;
            Dictionary<string, CustomGroupRule> CMGRule = null;
            using (OrgMapBiz orgmapBiz = new OrgMapBiz())
            {
                dsCompany = orgmapBiz.SelectCompanyList(this.LocaleCode);
            }
            //using (OrgMapBiz orgmapCMGBiz = new OrgMapBiz())
            //{
            //    CMGRule = orgmapCMGBiz.GetCustomGroupRule();
            //}

            jsonObject.Add("MyCompanyCode", UserCompanyCode);
            jsonObject.Add("MyLoginID", Document.UserInfo.LoginID);
            jsonObject.Add("UserEmail", UserEmail);
            jsonObject.Add("MyDeptSelectPath", UserDeptSelectPath);
            jsonObject.Add("CMGSuperAdmin", CMGSuperAdmin);

            if (CMGRule == null || CMGRule.Count == 0) throw new Exception(GetResources("WebOrg", "UserGroupRule"));
            CustomGroupRule defaultRule = CMGRule[UserCompanyCode];

            // 회사
            if (dsCompany != null && dsCompany.Tables.Count == 2)
            {
                ArrayList jsonInnerComArray = new ArrayList();
                Dictionary<string, object> jsonALLComObject = new Dictionary<string, object>();
                // 전사
                jsonALLComObject.Add("companyCode", GetResources("WebOrg", "JeonSa"));
                jsonALLComObject.Add("companyName", GetResources("WebOrg", "JeonSa"));
                jsonALLComObject.Add("text", "text");
                jsonALLComObject.Add("isRelative", "N");

                jsonALLComObject.Add("MailDomainURI", defaultRule.MailDomainURI);
                jsonALLComObject.Add("NameRulePrefix", defaultRule.NameRulePrefix);
                jsonALLComObject.Add("NameRuleSuffix", defaultRule.NameRuleSuffix);

                jsonInnerComArray.Add(jsonALLComObject);

                // 자회사
                foreach (DataRow drMyCompany in dsCompany.Tables[0].Rows)
                {
                    Dictionary<string, object> jsonInnerComObject = new Dictionary<string, object>();

                    string companyCode = drMyCompany["companyCode"].ToString().Trim().ToUpper();
                    CustomGroupRule rule = CMGRule[companyCode];
                    if (rule == null) rule = defaultRule;

                    // Note: "iconCls" 로 아이콘 지정가능
                    jsonInnerComObject.Add("companyCode", companyCode);
                    jsonInnerComObject.Add("companyName", drMyCompany["companyName"].ToString().Trim());
                    jsonInnerComObject.Add("text", drMyCompany["companyName"].ToString().Trim());
                    jsonInnerComObject.Add("isRelative", "N");

                    jsonInnerComObject.Add("MailDomainURI", rule.MailDomainURI);
                    jsonInnerComObject.Add("NameRulePrefix", rule.NameRulePrefix);
                    jsonInnerComObject.Add("NameRuleSuffix", rule.NameRuleSuffix);
                    if (drMyCompany["companyCode"].ToString().Trim().ToUpper().Equals(UserCompanyCode))
                    {
                        jsonInnerComObject.Add("checked", true);
                    }
                    jsonInnerComArray.Add(jsonInnerComObject);
                }
                jsonObject.Add("InnerCompany", jsonInnerComArray);
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(jsonObject);
        }
        #endregion

        #region createCustomGroup
        private string createCustomGroup()
        {
            string strResponse = "{\"result\": true }";
            string groupOrder = Request.Params["groupOrder"].Trim();
            string groupName = Request.Params["groupName"].Trim();
            string description = Request.Params["description"].Trim();

            //using (OrgMapBiz cmgBiz = new OrgMapBiz())
            //{
            //    cmgBiz.AddAddressBookGroup(UserCompanyCode, Document.UserInfo.EmpID, Document.UserInfo.LoginID, groupName, ConvertToInt32(groupOrder), description);
            //}
            return strResponse;
        }
        #endregion

        #region editCustomGroup
        private string editCustomGroup()
        {
            string strResponse = "{\"result\": true }";
            string groupCode = Request.Params["groupCode"];
            string groupOrder = Request.Params["groupOrder"];
            string groupName = Request.Params["groupName"];
            string description = Request.Params["description"];
            string displayYN = Request.Params["displayYN"];

            //using (OrgMapBiz cmgBiz = new OrgMapBiz())
            //{
            //    cmgBiz.ModifyAddressBookGroup(UserCompanyCode, Document.UserInfo.EmpID, Document.UserInfo.LoginID, ConvertToInt32(groupCode), groupName, ConvertToInt32(groupOrder), displayYN == "N" ? false : true, description);
            //}
            return strResponse;
        }
        #endregion

        #region deleteCustomGroup
        private string deleteCustomGroup()
        {
            string strResponse = "{\"result\": true }";
            string groupCode = Request.Params["groupCode"];

            //using (OrgMapBiz cmgBiz = new OrgMapBiz())
            //{
            //    cmgBiz.RemoveAddressBookGroup(UserCompanyCode, Document.UserInfo.EmpID, Document.UserInfo.LoginID, ConvertToInt32(groupCode));
            //}
            return strResponse;
        }
        #endregion

        #region deleteCustomGroupMember
        private string deleteCustomGroupMember()
        {
            string strResponse = "{\"result\": true }";
            string groupADCN = Request.Params["groupADCN"];
            string groupMembers = Request.Params["groupMembers"];

            //using (OrgMapBiz cmgBiz = new OrgMapBiz())
            //{
            //    cmgBiz.RemoveAddressBookMember(UserCompanyCode, Document.UserInfo.EmpID, Document.UserInfo.LoginID, ConvertToInt32(groupADCN), new List<string>(groupMembers.Split('$')));
            //}
            return strResponse;
        }
        #endregion

        #region addCustomGroupMember
        private string addCustomGroupMember()
        {
            string strResponse = string.Empty;
            List<string> unKnownUserList = null;
            string groupADCN = Request.Params["groupADCN"];
            string groupMembers = Request.Params["groupMembers"];

            //using (OrgMapBiz cmgBiz = new OrgMapBiz())
            //{
            //    unKnownUserList = cmgBiz.AddAddressBookMember(UserCompanyCode, Document.UserInfo.EmpID, Document.UserInfo.LoginID, ConvertToInt32(groupADCN), new List<string>(groupMembers.Split('$')));
            //    //.AddMemberToGroup(groupADCN, new List<string>(groupMembers.Split('$')));
            //}

            if (unKnownUserList != null)
            {
                Dictionary<string, object> jsonObject = new Dictionary<string, object>();
                jsonObject.Add("result", true);

                string externalUser = string.Empty;
                if (unKnownUserList.Count >= 1)
                {
                    externalUser = string.Join(", ", unKnownUserList.ToArray());
                }

                jsonObject.Add("unKnownUser", externalUser);
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                strResponse = serializer.Serialize(jsonObject);
            }
            return strResponse;
        }
        #endregion

        #region getCustomGroup
        private string getCustomGroup()
        {
            string strResponse = "[]";
            string companyCode = Request.Params["companyCode"];
            if (companyCode.Equals(GetResources("WebOrg", "JeonSa")))
            {
                companyCode = string.Empty;
            }

            DataSet ds = null;
            //using (OrgMapBiz cmgBiz = new OrgMapBiz())
            //{
            //    ds = cmgBiz.ListAddressBookGroup(UserCompanyCode, Document.UserInfo.EmpID);
            //}
            if (ds != null)
            {
                ArrayList jsonArray = new ArrayList();
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    Dictionary<string, object> jsonObject = new Dictionary<string, object>();
                    foreach (DataColumn dc in ds.Tables[0].Columns)
                    {
                        if (dc.ColumnName.Equals("CreateDT"))
                        {
                            DateTime date = Convert.ToDateTime(dr[dc]);
                            jsonObject.Add(dc.ColumnName, date.ToLocalTime().ToString("yyyy-MM-dd HH:mm:ss"));
                        }
                        else
                        {
                            jsonObject.Add(dc.ColumnName, dr[dc]);
                        }
                    }
                    jsonArray.Add(jsonObject);
                }
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                strResponse = serializer.Serialize(jsonArray);
            }
            return strResponse;
        }
        #endregion

        #region getCustomGroupMember
        private string getCustomGroupMember()
        {
            string groupADCN = Request.Params["groupADCN"];

            List<CustomGroupUserData> data = null;
            using (OrgMapBiz cmgBiz = new OrgMapBiz())
            {
                data = cmgBiz.ListAddressBookMember(UserCompanyCode, Document.UserInfo.EmpID, ConvertToInt32(groupADCN));    //.ListCustomGroupMember(groupADCN);
            }
            Dictionary<string, object> jsonObject = new Dictionary<string, object>();
            jsonObject.Add("NumOfPerson", data.Count);
            jsonObject.Add("dataRoot", data);
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(jsonObject);
        }
        #endregion

        private void validateGroupName(string companyCode, string groupName, string groupMailDomain)
        {
            Dictionary<string, CustomGroupRule> CMGRule = null;
            using (OrgMapBiz orgmapCMGBiz = new OrgMapBiz())
            {
                CMGRule = orgmapCMGBiz.GetCustomGroupRule();
            }
            if (CMGRule == null || CMGRule.Count == 0) throw new Exception(GetResources("WebOrg", "ServerGroupRule"));
            if (string.IsNullOrEmpty(companyCode))
            {
                companyCode = GetResources("WebOrg", "JeonSa");
            }
            CustomGroupRule rule = CMGRule[companyCode];
            if (rule != null)
            {
                if (!string.IsNullOrEmpty(rule.NameRulePrefix))
                {
                    if (groupName.IndexOf(rule.NameRulePrefix) != 0)
                    {
                        throw new Exception(GetResources("WebOrg", "GroupNamePrefixRule"));
                    }
                }
                if (!string.IsNullOrEmpty(rule.NameRuleSuffix))
                {
                    int idx = groupName.LastIndexOf(rule.NameRuleSuffix);
                    if (idx != groupName.Length - rule.NameRuleSuffix.Length)
                    {
                        throw new Exception(GetResources("WebOrg", "GroupNameSuffixRule"));
                    }
                }

                if (!string.IsNullOrEmpty(groupMailDomain) && !string.IsNullOrEmpty(rule.MailDomainURI))
                {
                    if (!rule.MailDomainURI.Equals(groupMailDomain))
                    {
                        throw new Exception(GetResources("WebOrg", "GroupMailAddressDomainRule"));
                    }
                }
            }
        }

        #endregion

        #region getCompanyDeptTree
        /// <summary>
        /// 조직도의 회사부서 트리의 데이터를 JSON으로 보내줌
        /// </summary>
        protected string getCompanyDeptTree()
        {
            string strParentID = Request.Params["node"];
            string strCompanyCode = Request.Params["companyCode"];
            string strIsRelative = Request.Params["isRelative"];

            string parentDeptCode = null;
            if (!strParentID.Equals("company-root"))
            {
                //if (strParentID.Equals(strCompanyCode + "-rootNode"))
                //{
                //    parentDeptCode = string.Empty;
                //}
                //else
                {
                    parentDeptCode = strParentID;
                }
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
                            //if (string.IsNullOrEmpty(node.id))
                            //{
                            //    node.id = strCompanyCode + "-rootNode";
                            //}
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

        #region getInitialize
        /// <summary>
        /// 조직도가 처음 로딩될 때 로그인한 유저의 정보, 확장 가능한 초기 정보를 조직도가 받게함
        /// </summary>
        /// <returns></returns>
        private string getInitialize()
        {
            string sOrgChartType = Request.Params["OrgChartType"];
            Dictionary<string, object> jsonObject = new Dictionary<string, object>();

            DataSet dsCompany = null;
            DataSet dsGroup = null;
            DataSet dsAddGroup = null;

            using (OrgMapBiz orgmapBiz = new OrgMapBiz())
            {
                dsCompany = orgmapBiz.SelectCompanyList(LocaleCode);
            }

            jsonObject.Add("MyCompanyCode", UserCompanyCode);
            jsonObject.Add("UserEmail", UserEmail);
            jsonObject.Add("MyDeptSelectPath", UserDeptSelectPath);
            jsonObject.Add("CMGAdmin", CMGAdmin);

            // 회사
            if (dsCompany != null && dsCompany.Tables.Count == 2)
            {
                ArrayList jsonInnerComArray = new ArrayList();
                ArrayList jsonRelativeComArray = new ArrayList();

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

                #region // 관계사
                //foreach (DataRow drRelCompany in dsCompany.Tables[1].Rows)
                //{
                //    Dictionary<string, object> jsonRelativeComObject = new Dictionary<string, object>();
                //    jsonRelativeComObject.Add("companyCode", drRelCompany["companyCode"].ToString().Trim().ToUpper());
                //    jsonRelativeComObject.Add("companyName", drRelCompany["companyName"].ToString().Trim());
                //    jsonRelativeComObject.Add("text", drRelCompany["companyName"].ToString().Trim());
                //    jsonRelativeComObject.Add("isRelative", "Y");
                //    jsonRelativeComArray.Add(jsonRelativeComObject);
                //} 
                #endregion

                jsonObject.Add("InnerCompany", jsonInnerComArray);
                jsonObject.Add("RelativeCompany", jsonRelativeComArray);
            }

            if (!string.IsNullOrEmpty(sOrgChartType) && (sOrgChartType.Equals("MAIL") || sOrgChartType.Equals("APP")))
            {
                using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                {
                    //dsGroup = orgmapBiz.SelectMailGroupType(LocaleCode);
                    dsAddGroup = orgmapBiz.SelectGroup(UserCompanyCode, LocaleCode);
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
                    jsonObject.Add("GroupType", jsonGroupArray);
                }

                if (sOrgChartType.Equals("MAIL"))
                {
                    ArrayList jsonMyTeamRoom = new ArrayList();
                    ArrayList jsonMyAddrBookGrpoom = new ArrayList();

                    DataSet ds = null;
                    //using (OrgMapBiz biz = new OrgMapBiz())
                    //{
                    //    ds = biz.ListAddressBookGroup(UserCompanyCode, Document.UserInfo.EmpID);
                    //}

                    if (ds != null && ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[0].Rows)
                        {
                            Dictionary<string, object> jsonTeamRoomObj = new Dictionary<string, object>();

                            jsonTeamRoomObj.Add("menuID", "TC");
                            jsonTeamRoomObj.Add("CoPName", Convert.ToString(dr["GroupName"]));
                            jsonTeamRoomObj.Add("CoPID", Convert.ToString(dr["GroupCode"]));
                            jsonTeamRoomObj.Add("text", Convert.ToString(dr["GroupName"]));
                            jsonTeamRoomObj.Add("checked", false);

                            jsonMyTeamRoom.Add(jsonTeamRoomObj);

                            jsonTeamRoomObj["menuID"] = "GC";
                            jsonMyAddrBookGrpoom.Add(jsonTeamRoomObj);
                        }

                        jsonObject.Add("MyTeamRoom", jsonMyTeamRoom);
                        jsonObject.Add("MyAddressBookGroup", jsonMyTeamRoom);
                    }
                }
                else if (sOrgChartType.Equals("APP"))
                {
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
                }
            }
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(jsonObject);
        }
        #endregion

        #region MakeJSONErrorMessage
        private string MakeJSONErrorMessage(Exception ex)
        {
            Dictionary<string, object> jsonObject = new Dictionary<string, object>();
            jsonObject.Add("result", false);
            jsonObject.Add("ErrorMessage", ex.Message + ex.StackTrace);

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

        #region Session

        protected bool CMGAdmin
        {
            get
            {
                if (Session["CMGAdmin"] == null)
                {
                    SetSessionData();
                }

                return true;    // Convert.ToBoolean(Session["CMGAdmin"]);
            }
        }

        protected bool CMGSuperAdmin
        {
            get
            {
                if (Session["CMGSuperAdmin"] == null)
                {
                    SetSessionData();
                }

                return Convert.ToBoolean(Session["CMGSuperAdmin"]);
            }
        }

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

        protected string LocaleCode
        {
            get
            {
                if (Session["MyLanguageCode"] == null)
                {
                    return Document.ClientCultureName;
                }

                return Session["MyLanguageCode"].ToString();
            }
            set
            {
                Session["MyLanguageCode"] = value;
            }
        }

        private void SetSessionData()
        {
            if (!string.IsNullOrEmpty(Document.UserInfo.LoginID))
            {
                DataSet dsUser = null;
                using (OrgMapBiz orgmapBiz = new OrgMapBiz())
                {
                    dsUser = orgmapBiz.SelectUser(Document.UserInfo.CompanyCode, Document.UserInfo.LoginID, LocaleCode);
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
                    // 사용자 메일그룹 ADMIN
                    Session["CMGAdmin"] = true;
                    // 사용자 메일그룹 SUPER ADMIN
                    Session["CMGSuperAdmin"] = true;

                    // 사용자 부서 상위 부서리스트
                    foreach (DataRow drDept in dsUser.Tables[1].Rows)
                    {
                        sbUserDeptSelectPath.Append("/");
                        sbUserDeptSelectPath.Append(drDept["DeptCode"].ToString().Trim());
                    }
                    Session["UserDeptSelectPath"] = sbUserDeptSelectPath.ToString();
                }
                else if (Document.UserInfo.LoginID.EndsWith("admin", StringComparison.CurrentCultureIgnoreCase))
                {
                    // truefree 2009-09-25
                    // DB에 없는 사용자들 (관리자 ID)
                    // CoPAdmin등 관리자 아이디로 조직도 출력시...
                    // SKEnergy, HW-경영관리팀으로 설정
                    Session["UserCompanyCode"] = "1";
                    Session["UserEMail"] = Document.UserInfo.LoginID + "@enftech.com";
                    Session["CMGAdmin"] = false;
                    Session["CMGSuperAdmin"] = false;
                    Session["UserDeptSelectPath"] = "/00000/02000/21000/23020";
                }
            }
            else
            {
                throw new Exception(GetResources("WebOrg", "NotKnowUserID"));
            }
        }

        #endregion

        public string GetResources(string programid, string code)
        {
            return string.Empty;
        }
    }
}