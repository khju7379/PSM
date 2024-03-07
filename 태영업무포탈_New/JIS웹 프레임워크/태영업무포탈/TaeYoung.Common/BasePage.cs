using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using TaeYoung.Biz.Common;
using TaeYoung.Common.VirtualPath;
using JINI.Base;
using JINI.Base.Configuration;
using TaeYoung.Biz;
using System.Web;
using System.Web.Security;
using System.Text.RegularExpressions;
using System.Xml;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.IO;

namespace TaeYoung.Common
{
    /// <summary>
    /// PageBase를 상속하여 재정의
    /// </summary>
    public class BasePage : PageBase
    {
        #region BasePage - Ctor
        /// <summary>
        /// Ctor.
        /// </summary>
        public BasePage()
        {
            // 다국어 처리를 위한 언어코드 리스트를 초기화한다.
            LangCodeList = new List<string[]>();
        }
        #endregion

        #region TopMenuID - 최상위 메뉴값
        /// <summary>
        /// 최상위 메뉴값
        /// </summary>
        public string TopMenuID { get; set; } 
        #endregion

		#region Popup - 현재페이지의 팝업여부를 지정
		/// <summary>
		/// 현재페이지의 팝업여부를 지정
		/// </summary>
		public bool Popup { get; set; } 
		#endregion

		#region Main - 현재페이지의 메인여부를 지정
		/// <summary>
		/// 현재페이지의 메인여부를 지정
		/// </summary>
		public bool Main { get; set; } 
		#endregion

        #region TopMenu - 현재페이지의 상단메뉴여부를 지정
        /// <summary>
        /// 현재페이지의 상단메뉴여부를 지정
        /// </summary>
        public bool TopMenu { get; set; } 
        #endregion

        #region LeftMenu - 현재페이지의 좌측메뉴여부를 지정
        /// <summary>
        /// 현재페이지의 좌측메뉴여부를 지정
        /// </summary>
        public bool LeftMenu { get; set; } 
        #endregion

		#region None - 현재페이지에 마스터페이지(None) 적용
		/// <summary>
		/// 현재페이지에 마스터페이지(None) 적용
		/// </summary>
		public bool None { get; set; } 
		#endregion

		#region ReadMode - 컨트롤 읽기모드 여부 처리
		/// <summary>
		/// 컨트롤 읽기모드 여부 처리
		/// </summary>
		public bool ReadMode { get; set; } 
		#endregion

        #region IgnoreReadMode - 컨트롤 읽기모드 예외처리
        /// <summary>
        /// 컨트롤 읽기모드 예외처리
        /// </summary>
        public List<string> IgnoreReadMode { get; set; }
        #endregion

        #region IsMobile - 모바일여부
        /// <summary>
        /// 모바일여부
        /// </summary>
        public bool IsMobile { get; set; } 
        #endregion

        #region IsEDMS - 문서함 여부
        /// <summary>
        /// 문서함 여부
        /// </summary>
        public bool IsEDMS { get; set; } 
        #endregion

        #region LangCodeList - 언어코드 리스트
        /// <summary>
        /// 언어코드 리스트
        /// </summary>
        public List<string[]> LangCodeList { get; set; }
        #endregion

        #region LangCodeData - 언어 코드 데이터
        /// <summary>
        /// 언어 코드 데이터
        /// </summary>
        public DataTable LangCodeData { get; set; } 
        #endregion

        #region OnPreInit - 페이지가 초기화되기 전
        /// <summary>
        /// 페이지가 초기화되기 전
        /// </summary>
        /// <param name="e"></param>
        protected override void OnPreInit(EventArgs e)
        {
            IgnoreReadMode = new List<string>();

            // 테스트를 위하여 메뉴 무조건 활성화
            this.LeftMenu = true;
            this.TopMenu = true;

            // QueryString값이 Chk
            if (!string.IsNullOrEmpty(Request.QueryString["Chk"]))
            {
                this.TopMenu = false;
            }
            else if (!string.IsNullOrEmpty(Request.QueryString["AllChk"]))
            {
                this.TopMenu = false;
                this.LeftMenu = false;
            }

            // 팝업여부 강제지정
            if (!string.IsNullOrEmpty(Request.QueryString["POPUP"]))
            {
                this.Popup = true;
            }

            // 마스터 페이지 로드
			if(this.MasterPageFile == null)
			{
				if (this.IsMobile)
				{
                    this.MasterPageFile = VirtualFilePathProvider.MasterPageFileLocationMobile;
				}
				else if (this.IsEDMS)
				{
					this.MasterPageFile = "~/VirtualPageDir/EDMS.Master";
				}
				else if (this.Popup)
				{
                    this.MasterPageFile = VirtualFilePathProvider.MasterPageFileLocationPopup;
				}
				else if (this.Main)
				{
					this.MasterPageFile = "~/VirtualPageDir/Main.Master";
				}
                else if (this.None)
                {

                }
                else
                {
                    //this.MasterPageFile = VirtualFilePathProvider.MasterPageFileLocation;
                    this.MasterPageFile = VirtualFilePathProvider.MasterPageFileLocationSub;
                }
			}

            // ViewState모드 사용안함 (명시적으로 선언하지 않을시)
            if (ViewStateMode == System.Web.UI.ViewStateMode.Inherit)
            {
                ViewStateMode = System.Web.UI.ViewStateMode.Disabled;
            }

            base.OnPreInit(e);
        } 
        #endregion

        #region OnInit - 페이지를 초기화한다.(로그인 실행부)
        /// <summary>
        /// 페이지를 초기화한다.(로그인 실행부)
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["ReadMode"]))
            {
                this.ReadMode = true;
            }

            if (!Login())
            {
                if (string.IsNullOrEmpty(Request.QueryString["Chk"]))
                {
                    //FormsAuthentication.RedirectToLoginPage(); // 닷넷일시
                    // LoginUrl 뒤에 원래 페이지로 가기위한  + "?ReturnUrl=" + Server.UrlEncode(Request.Url.PathAndQuery) 추가 2017-06-08 장윤호
                    HttpContext.Current.Response.Redirect(FormsAuthentication.LoginUrl + "?ReturnUrl=" + Server.UrlEncode(Request.Url.PathAndQuery));

                    return; // 응용프로그램을 초기화히지 않음
                }
                else
                {
                    //GotoLogin(); // 도미노일시
                    HttpContext.Current.Response.Redirect(FormsAuthentication.LoginUrl + "?ReturnUrl=" + Server.UrlEncode(Request.Url.PathAndQuery));

                    return; // 응용프로그램을 초기화히지 않음
                }
            }
            
            base.OnInit(e);
        } 
        #endregion

        public bool Login()
        {
            string loginid = string.Empty;
            // 세션체크에 실패시 도미노 로그인페이지로 이동
            try
            {
                loginid = LTPAToken; //"dev1";
            }
            catch
            {
                //string retUrl = "http://{0}/LoginUserInfo.nsf/SetSessionVal?OpenAgent&rurl={1}&rparam={2}";
                //
                //retUrl = string.Format(retUrl, Request.Url.Host, Request.Url.AbsoluteUri, Request.Url.Query.Replace("?", "").Replace("&", Server.UrlEncode("&")));
                //
                //Response.Redirect(retUrl);

                //GotoLogin();

                return false;
            }

            if (loginid == "nologin")
            {
                return false;
                //throw new Exception("사용자가 로그인하지 못했습니다.");
            }

            // 세션을 체크하여 로그인 ID가 같고, 언어코드가 같을시 기존 세션을 재사용함(속도문제)
            if (Session != null && Session["UserInfo"] != null && (Document.EmpID == loginid || Document.UserID == loginid || Document.UserID + "^" + Document.EmpID == loginid))
            {
                // 세션이 있음으로 로그인하지않음
            }
            else
            {
                // 세션이 없거나 ID가 변경되었음
                using (OrgChartBiz biz = new OrgChartBiz())
                {

                    DataSet ds = biz.GetUserinfoLogin(loginid, Document.ClientCultureName.ToLower());

                    DataRow userById = ds.Tables[0].Rows[0];

                    if (!string.IsNullOrEmpty(Document.SiteCompanyCode))
                    {
                        //로그인 보정 처리
                        foreach (DataRow chkDr in ds.Tables[0].Rows)
                        {
                            if (chkDr["SITECOMPANY"].Equals(Document.SiteCompanyCode))
                            {
                                userById = chkDr;
                            }
                        }
                    }

                    Document.UserLogin(
                            userById["empid"].ToString()
                            , userById["loginid"].ToString()
                            , userById["username"].ToString()
                            , userById["deptcode"].ToString()
                            , userById["deptname"].ToString()
                            , userById["rankcode"].ToString()
                            , userById["rankname"].ToString()
                            , userById["dutycode"].ToString()
                            , userById["dutyname"].ToString()
                            , userById["email"].ToString()
                            , userById["cellphone"].ToString()
                            , userById["extensionnumber"].ToString()
                            , userById["userlang"].ToString()
                            , userById["ischief"].ToString()
                            , userById["CompanyCode"].ToString()
                            , userById["CompanyName"].ToString()
                            , ""//userById["SignID"].ToString()
                            , userById["JobCode"].ToString()
                            , ""//userById["JobName"].ToString()
                            , userById["LocationCode"].ToString()
                            , userById["DPARTNER"].ToString() == "0" ? false : true
                            , userById["kostl"].ToString()
                            , userById["SITECOMPANY"].ToString());
                }

            }

            // 회사변경 처리를 위하여 무조건 세션에 쿠키값을 입력한다.
            if (!string.IsNullOrEmpty(Document.SiteCompanyCode))
            {
                Document.UserInfo.SiteCompanyCode = Document.SiteCompanyCode;
            }
            else
            {
                Document.SiteCompanyCode = Document.UserInfo.SiteCompanyCode;
            }

            return true;
        }

        #region OnLoad - 페이지를 로드한다.(프로그램/경로/컨트롤 처리 및 다국어)
        /// <summary>
        /// 페이지를 로드한다.(프로그램/경로/컨트롤 처리 및 다국어)
        /// </summary>
        /// <param name="e"></param>
        protected override void OnLoad(EventArgs e)
        {
            // 프로그램 경로로 현 페이지의 프로그램ID, 메뉴ID를 가져와서 페이지에 설정한다.
            using (ProgramBiz biz = new ProgramBiz())
            {
                //string url = Request.Url.PathAndQuery;
                var nvc = HttpUtility.ParseQueryString(Request.Url.Query);
                nvc.Remove("company");
                nvc.Remove("DomAuthSessId");
                nvc.Remove("NUM");
                
                // 각 페이지별 쿼리스트링 문제로 프로그램 아이디를 가져오지 못하므로 여기서 예외처리한다.
                //nvc.Remove("COMPANYCODE");

                string url = string.Empty;

                if (nvc.Count > 0)
                    url = Request.Url.AbsolutePath + "?" + nvc.ToString();
                else
                    url = Request.Url.AbsolutePath;

                if (!string.IsNullOrEmpty(Request.QueryString["foid"]))
                {
                    url += "?foid=" + Request.QueryString["foid"];
                }
                else if (!string.IsNullOrEmpty(Request.QueryString["SID"]))
                {
                    if (url.IndexOf('?') > -1)
                    {
                        url += "&";
                    }
                    else
                    {
                        url += "?";
                    }
                    url += "SID=" + Request.QueryString["SID"];
                }

                // DB 저장시 & 자동변경
                url = url.Replace("?Chk=1", "").Replace("&Chk=1", "").Replace("?AllChk=1", "").Replace("&AllChk=1", "").Replace("?makeLang=1", "").Replace("&makeLang=1", "").Replace("&", "&amp;");

                DataSet ds = biz.GetProgramID(url, Document.UserInfo.IsVend);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    this.ProgramID = ds.Tables[0].Rows[0]["PROGRAMID"].ToString().Trim();
                    this.MenuID = ds.Tables[0].Rows[0]["MENUID"].ToString().Trim();
                    this.Title = ds.Tables[0].Rows[0]["DESCRIPTION"].ToString();
                }
                else
                {
                    this.ProgramID = string.Empty;
                    this.MenuID = string.Empty;
                }

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    this.TopMenuID = ds.Tables[1].Rows[0]["MENUID"].ToString().Trim();
                }
            }

            //// 사용자 그룹 및 현재 페이지의 권한 설정
            using (OrgChartBiz biz = new OrgChartBiz())
            {
                DataSet ds = biz.GetACL(Document.UserInfo.EmpID, Document.UserInfo.SiteCompanyCode, this.MenuID);

                UserGroup = new List<string>();

                if (ds != null && ds.Tables.Count > 0)
                {
                    // 첫번째 테이블은 그룹 리스트
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        UserGroup.Add(dr[0].ToString());
                    }

                    // 두번째 테이블은 현 페이지의 사용권한
                    if (Convert.ToInt32(ds.Tables[1].Rows[0][0]) > 0)
                    {
                        ACL = true;
                    }
                    else
                    {
                        ACL = false;
                    }

                    //관리자 ON/OFF
                    try
                    {
                        CVYN = ds.Tables[2].Rows[0]["CVYN"].ToString();
                    }
                    catch (Exception ex)
                    {
                        CVYN = "";
                    }
                }
            }

            if (!this.PostbackYN)
            {
                // 이벤트를 제거하여 오류발생시 포스트백을 진행하지 않도록 함수를 재정의함
                ClientScript.RegisterClientScriptBlock(this.GetType(), "postback_remove", "__doPostBack = function(e){alert('오류로 인하여 기능이 동작하지 않습니다.');};", true);
            }

            base.OnLoad(e);

            // 다국어 변환을 위한 언어코드 로드
            this.OnLangInit(e);

            // 컨트롤 데이터 조회하여 다국어 변환 부분을 로드
            foreach (System.Web.UI.Control c in GetAllControls(this.Page))
            {
                if (c.GetType() == typeof(JINI.Control.WebControl.Text))
                {
                    LangCodeList.Add(new string[] { ((JINI.Control.WebControl.Text)c).LangCode, ((JINI.Control.WebControl.Text)c).Description });
                }
                else if (c.GetType() == typeof(JINI.Control.WebControl.Button))
                {
                    LangCodeList.Add(new string[] { ((JINI.Control.WebControl.Button)c).LangCode, ((JINI.Control.WebControl.Button)c).Description });
                }
                else if (c.GetType() == typeof(JINI.Control.WebControl.WebSheet))
                {
                    foreach (System.Web.UI.Control cc in c.Controls)
                    {
                        if (cc.GetType() == typeof(JINI.Control.WebControl.SheetHeader))
                        {
                            LangCodeList.Add(new string[] { ((JINI.Control.WebControl.SheetHeader)cc).TextField, ((JINI.Control.WebControl.SheetHeader)cc).Description });
                        }
                        else if (cc.GetType() == typeof(JINI.Control.WebControl.SheetField))
                        {
                            LangCodeList.Add(new string[] { ((JINI.Control.WebControl.SheetField)cc).TextField, ((JINI.Control.WebControl.SheetField)cc).Description });
                        }
                    }
                }
                else if (c.GetType() == typeof(JINI.Control.WebControl.SearchView))
                {
                    foreach (System.Web.UI.Control cc in c.Controls)
                    {
                        if (cc.GetType() == typeof(JINI.Control.WebControl.SearchViewField))
                        {
                            LangCodeList.Add(new string[] { ((JINI.Control.WebControl.SearchViewField)cc).TextField, ((JINI.Control.WebControl.SearchViewField)cc).Description });
                        }
                    }

                    if (!string.IsNullOrEmpty(((JINI.Control.WebControl.SearchView)c).PlaceHolder))
                        LangCodeList.Add(new string[] { ((JINI.Control.WebControl.SearchView)c).ID + "_EMPTY", ((JINI.Control.WebControl.SearchView)c).PlaceHolder });
                }
                else if (c.GetType() == typeof(JINI.Control.WebControl.WebTree))
                {
                    LangCodeList.Add(new string[] { ((JINI.Control.WebControl.WebTree)c).Title, ((JINI.Control.WebControl.WebTree)c).Description });
                }
                else if (c.GetType() == typeof(JINI.Control.WebControl.Combo))
                {
                    // ListItem 읽어서 다국어 처리
                    string xmlStr = ((JINI.Control.WebControl.Combo)c).InnerText;

                    // 대소문자 관계없이 replace
                    xmlStr = Regex.Replace(xmlStr, "asp:", "", RegexOptions.IgnoreCase);
                    xmlStr = xmlStr.Replace("\r", "").Replace("\n", "").Trim(); // Xml 파싱전 strip
                    xmlStr = Regex.Replace(xmlStr, "<listitem", "<listitem", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "</listitem>", "</listitem>§", RegexOptions.IgnoreCase);
                    // xml처리
                    xmlStr = Regex.Replace(xmlStr, "value", "value", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "text", "text", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "description", "description", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "selected", "selected", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "langcode", "langcode", RegexOptions.IgnoreCase);

                    string[] split_str = xmlStr.Split('§');

                    for (int j = 0; j < split_str.Length; j++)
                    {
                        if (string.IsNullOrEmpty(split_str[j].Trim())) continue; // 유효성검사

                        XmlDocument xml = new XmlDocument();
                        xml.LoadXml(split_str[j]);

                        if (xml.DocumentElement.Attributes["langcode"] != null)
                        {
                            LangCodeList.Add(new string[] { xml.DocumentElement.Attributes["langcode"].Value, xml.DocumentElement.Attributes["description"].Value });
                        }

                        // ListItem 추가
                        ListItem li = new ListItem();
                        if (xml.DocumentElement.Attributes["value"] != null)
                            li.Value = xml.DocumentElement.Attributes["value"].Value;
                        if (xml.DocumentElement.Attributes["text"] != null)
                            li.Text = xml.DocumentElement.Attributes["text"].Value;
                        if (xml.DocumentElement.Attributes["description"] != null)
                            li.Text = xml.DocumentElement.Attributes["description"].Value;
                        if (xml.DocumentElement.Attributes["selected"] != null)
                            li.Selected = Convert.ToBoolean(xml.DocumentElement.Attributes["selected"].Value);
                        if (xml.DocumentElement.Attributes["langcode"] != null)
                            li.Attributes.Add("LangCode", xml.DocumentElement.Attributes["langcode"].Value);
                        if (xml.DocumentElement.Attributes["description"] != null)
                            li.Attributes.Add("Description", xml.DocumentElement.Attributes["description"].Value);

                        ((JINI.Control.WebControl.Combo)c).Items.Add(li);
                    }

                    foreach (System.Web.UI.WebControls.ListItem li in ((JINI.Control.WebControl.Combo)c).Items)
                    {
                        if (li.Attributes["LangCode"] != null)
                        {
                            LangCodeList.Add(new string[] { li.Attributes["LangCode"].ToString(), li.Attributes["Description"].ToString() });
                        }
                    }
                }
                else if (c.GetType() == typeof(JINI.Control.WebControl.CheckBox))
                {
                    // ListItem 읽어서 다국어 처리
                    string xmlStr = ((JINI.Control.WebControl.CheckBox)c).InnerText;

                    // 대소문자 관계없이 replace
                    xmlStr = Regex.Replace(xmlStr, "asp:", "", RegexOptions.IgnoreCase);
                    xmlStr = xmlStr.Replace("\r", "").Replace("\n", "").Trim(); // Xml 파싱전 strip
                    xmlStr = Regex.Replace(xmlStr, "<listitem", "<listitem", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "</listitem>", "</listitem>§", RegexOptions.IgnoreCase);
                    // xml처리
                    xmlStr = Regex.Replace(xmlStr, "value", "value", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "text", "text", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "description", "description", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "selected", "selected", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "langcode", "langcode", RegexOptions.IgnoreCase);

                    string[] split_str = xmlStr.Split('§');

                    for (int j = 0; j < split_str.Length; j++)
                    {
                        if (string.IsNullOrEmpty(split_str[j].Trim())) continue; // 유효성검사

                        XmlDocument xml = new XmlDocument();
                        xml.LoadXml(split_str[j]);

                        if (xml.DocumentElement.Attributes["langcode"] != null)
                        {
                            LangCodeList.Add(new string[] { xml.DocumentElement.Attributes["langcode"].Value, xml.DocumentElement.Attributes["description"].Value });
                        }

                        // ListItem 추가
                        ListItem li = new ListItem();
                        if (xml.DocumentElement.Attributes["value"] != null)
                            li.Value = xml.DocumentElement.Attributes["value"].Value;
                        if (xml.DocumentElement.Attributes["text"] != null)
                            li.Text = xml.DocumentElement.Attributes["text"].Value;
                        if (xml.DocumentElement.Attributes["description"] != null)
                            li.Text = xml.DocumentElement.Attributes["description"].Value;
                        if (xml.DocumentElement.Attributes["selected"] != null)
                            li.Selected = Convert.ToBoolean(xml.DocumentElement.Attributes["selected"].Value);
                        if (xml.DocumentElement.Attributes["langcode"] != null)
                            li.Attributes.Add("LangCode", xml.DocumentElement.Attributes["langcode"].Value);
                        if (xml.DocumentElement.Attributes["description"] != null)
                            li.Attributes.Add("Description", xml.DocumentElement.Attributes["description"].Value);

                        ((JINI.Control.WebControl.CheckBox)c).Items.Add(li);
                    }

                    foreach (System.Web.UI.WebControls.ListItem li in ((JINI.Control.WebControl.CheckBox)c).Items)
                    {
                        if (li.Attributes["LangCode"] != null)
                        {
                            LangCodeList.Add(new string[] { li.Attributes["LangCode"].ToString(), li.Attributes["Description"].ToString() });
                        }
                    }
                }
                else if (c.GetType() == typeof(JINI.Control.WebControl.Radio))
                {
                    // ListItem 읽어서 다국어 처리
                    string xmlStr = ((JINI.Control.WebControl.Radio)c).InnerText;

                    // 대소문자 관계없이 replace
                    xmlStr = Regex.Replace(xmlStr, "asp:", "", RegexOptions.IgnoreCase);
                    xmlStr = xmlStr.Replace("\r", "").Replace("\n", "").Trim(); // Xml 파싱전 strip
                    xmlStr = Regex.Replace(xmlStr, "<listitem", "<listitem", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "</listitem>", "</listitem>§", RegexOptions.IgnoreCase);
                    // xml처리
                    xmlStr = Regex.Replace(xmlStr, "value", "value", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "text", "text", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "description", "description", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "selected", "selected", RegexOptions.IgnoreCase);
                    xmlStr = Regex.Replace(xmlStr, "langcode", "langcode", RegexOptions.IgnoreCase);

                    string[] split_str = xmlStr.Split('§');

                    for (int j = 0; j < split_str.Length; j++)
                    {
                        if (string.IsNullOrEmpty(split_str[j].Trim())) continue; // 유효성검사

                        XmlDocument xml = new XmlDocument();
                        xml.LoadXml(split_str[j]);

                        if (xml.DocumentElement.Attributes["langcode"] != null)
                        {
                            LangCodeList.Add(new string[] { xml.DocumentElement.Attributes["langcode"].Value, xml.DocumentElement.Attributes["description"].Value });
                        }

                        // ListItem 추가
                        ListItem li = new ListItem();
                        if (xml.DocumentElement.Attributes["value"] != null)
                            li.Value = xml.DocumentElement.Attributes["value"].Value;
                        if (xml.DocumentElement.Attributes["text"] != null)
                            li.Text = xml.DocumentElement.Attributes["text"].Value;
                        if (xml.DocumentElement.Attributes["description"] != null)
                            li.Text = xml.DocumentElement.Attributes["description"].Value;
                        if (xml.DocumentElement.Attributes["selected"] != null)
                            li.Selected = Convert.ToBoolean(xml.DocumentElement.Attributes["selected"].Value);
                        if (xml.DocumentElement.Attributes["langcode"] != null)
                            li.Attributes.Add("LangCode", xml.DocumentElement.Attributes["langcode"].Value);
                        if (xml.DocumentElement.Attributes["description"] != null)
                            li.Attributes.Add("Description", xml.DocumentElement.Attributes["description"].Value);

                        ((JINI.Control.WebControl.Radio)c).Items.Add(li);
                    }

                    foreach (System.Web.UI.WebControls.ListItem li in ((JINI.Control.WebControl.Radio)c).Items)
                    {
                        if (li.Attributes["LangCode"] != null)
                        {
                            LangCodeList.Add(new string[] { li.Attributes["LangCode"].ToString(), li.Attributes["Description"].ToString() });
                        }
                    }
                }
                else if (c.GetType() == typeof(JINI.Control.WebControl.LayerTap))
                {
                    LangCodeList.Add(new string[] { ((JINI.Control.WebControl.LayerTap)c).LangCode, ((JINI.Control.WebControl.LayerTap)c).Description });
                }
                else if (c.GetType() == typeof(JINI.Control.WebControl.Layer))
                {
                    LangCodeList.Add(new string[] { ((JINI.Control.WebControl.Layer)c).LangCode, ((JINI.Control.WebControl.Layer)c).Description });
                }

                // 컨트롤 ReadMode 여부 처리
                if (ReadMode && !IgnoreReadMode.Exists(x => x == c.ID))
                {
                    if (c.GetType() == typeof(JINI.Control.WebControl.SearchView))
                    {
                        ((JINI.Control.WebControl.SearchView)c).ReadMode = ReadMode;
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.TimePicker))
                    {
                        ((JINI.Control.WebControl.TimePicker)c).ReadMode = ReadMode;
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.TextBox))
                    {
                        ((JINI.Control.WebControl.TextBox)c).ReadMode = ReadMode;
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.Combo))
                    {
                        ((JINI.Control.WebControl.Combo)c).ReadMode = ReadMode;
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.CheckBox))
                    {
                        ((JINI.Control.WebControl.CheckBox)c).ReadMode = ReadMode;
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.Radio))
                    {
                        ((JINI.Control.WebControl.Radio)c).ReadMode = ReadMode;
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.FileUpload))
                    {
                        ((JINI.Control.WebControl.FileUpload)c).ReadMode = ReadMode;
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.Dext5Editor))
                    {
                        ((JINI.Control.WebControl.Dext5Editor)c).ReadMode = ReadMode;
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.Text))
                    {
                        ((JINI.Control.WebControl.Text)c).ReadMode = ReadMode;
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.FlipSwitch))
                    {
                        ((JINI.Control.WebControl.FlipSwitch)c).ReadMode = ReadMode;
                    }
                }
            }

            string langList = string.Empty;

            if (Request.QueryString["makeLang"] != null)
            {
                if (string.IsNullOrEmpty(this.ProgramID))
                    this.Page.Response.Write("<script>alert('프로그램이 등록되지 않았거나 ProgramID가 정확하지 않습니다.');</script>");
                else
                {
                    //using (LangBiz biz = new LangBiz())
                    //{
                    //    biz.RemoveLang(this.ProgramID);
                    //}
                }
            }

            // 컨트롤 다국어 처리 
            foreach (string[] lang in LangCodeList)
            {
                if (Request.QueryString["makeLang"] != null)
                {
                    if (!string.IsNullOrEmpty(this.ProgramID))
                    {
                        if (!string.IsNullOrEmpty(lang[0]))
                        {
                            Hashtable ht = new Hashtable();
                            ht.Add("programid", this.ProgramID);
                            ht.Add("code", lang[0]);
                            ht.Add("ko", lang[1]);

                            using (LangBiz biz = new LangBiz())
                            {
                                biz.AddLang(ht);
                            }
                        }
                    }
                }

                langList += "'" + lang[0] + "',";
            }

            langList = langList.TrimEnd(',');

            if (!string.IsNullOrEmpty(langList))
            {

                // 다국어 문자열로 데이터 조회
                using (LangBiz biz = new LangBiz())
                {
                    DataSet ds = biz.GetLangCode(this.ProgramID, langList, Document.ClientCultureName);

                    if (ds.Tables.Count > 0)
                    {
                        LangCodeData = ds.Tables[0];
                    }
                }

                // 컨트롤에 처리된 다국어를 바인딩
                // 컨트롤 데이터 조회하여 다국어 변환 부분을 로드
                foreach (System.Web.UI.Control c in GetAllControls(this.Page))
                {
                    if (c.GetType() == typeof(JINI.Control.WebControl.Text))
                    {
                        string str = GetLangCode(((JINI.Control.WebControl.Text)c).LangCode);
                        if (str != string.Empty)
                        {
                            ((JINI.Control.WebControl.Text)c).Text = str;
                        }
                        else if (!string.IsNullOrWhiteSpace(((JINI.Control.WebControl.Text)c).Description))
                        {
                            ((JINI.Control.WebControl.Text)c).Text = ((JINI.Control.WebControl.Text)c).Description;
                        }
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.Button))
                    {
                        string str = GetLangCode(((JINI.Control.WebControl.Button)c).LangCode);
                        if (str != string.Empty)
                        {
                            ((JINI.Control.WebControl.Button)c).Text = str;
                        }
                        else if (!string.IsNullOrWhiteSpace(((JINI.Control.WebControl.Button)c).Description))
                        {
                            ((JINI.Control.WebControl.Button)c).Text = ((JINI.Control.WebControl.Button)c).Description;
                        }
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.WebSheet)) // Sheet는 Description이 없기 때문에 다국어 데이터가 없을시 현 텍스트를 표시함
                    {

                        foreach (System.Web.UI.Control cc in ((JINI.Control.WebControl.WebSheet)c).Controls)
                        {
                            if (cc.GetType() == typeof(JINI.Control.WebControl.SheetHeader))
                            {
                                string str = GetLangCode(((JINI.Control.WebControl.SheetHeader)cc).TextField);
                                if (str != string.Empty)
                                {
                                    ((JINI.Control.WebControl.SheetHeader)cc).TextField = str;
                                    //((JINI.Control.WebControl.WebSheet)c).ModifyField((JINI.Control.WebControl.SheetHeader)cc);
                                }
                                else
                                {
                                    if (((JINI.Control.WebControl.SheetHeader)cc).Description != string.Empty)
                                    {
                                        ((JINI.Control.WebControl.SheetHeader)cc).TextField = ((JINI.Control.WebControl.SheetHeader)cc).Description;
                                        //((JINI.Control.WebControl.WebSheet)c).ModifyField((JINI.Control.WebControl.SheetHeader)cc);
                                    }
                                }
                            }
                            else if (cc.GetType() == typeof(JINI.Control.WebControl.SheetField))
                            {
                                string str = GetLangCode(((JINI.Control.WebControl.SheetField)cc).TextField);
                                if (str != string.Empty)
                                {
                                    ((JINI.Control.WebControl.SheetField)cc).TextField = str;
                                    //((JINI.Control.WebControl.WebSheet)c).ModifyField((JINI.Control.WebControl.SheetField)cc);
                                }
                                else
                                {
                                    if (((JINI.Control.WebControl.SheetField)cc).Description != string.Empty)
                                    {
                                        ((JINI.Control.WebControl.SheetField)cc).TextField = ((JINI.Control.WebControl.SheetField)cc).Description;
                                        //((JINI.Control.WebControl.WebSheet)c).ModifyField((JINI.Control.WebControl.SheetField)cc);
                                    }
                                }
                            }
                        }
                        // cs에서 바인딩시 다국어 처리
                        foreach (JINI.Control.WebControl.SheetHeader field in ((JINI.Control.WebControl.WebSheet)c).HeaderParams)
                        {
                            string str = GetLangCode(field.TextField);
                            if (str != string.Empty)
                            {
                                field.TextField = str;
                            }
                            else
                            {
                                if (field.Description != string.Empty)
                                {
                                    field.TextField = field.Description;
                                }
                            }
                        }
                        foreach (JINI.Control.WebControl.SheetField field in ((JINI.Control.WebControl.WebSheet)c).FieldParams)
                        {
                            string str = GetLangCode(field.TextField);
                            if (str != string.Empty)
                            {
                                field.TextField = str;
                            }
                            else
                            {
                                if (field.Description != string.Empty)
                                {
                                    field.TextField = field.Description;
                                }
                            }
                        }
                        //List<JINI.Control.WebControl.SheetHeader> header = ((JINI.Control.WebControl.WebSheet)c).GetHeaderField();
                        //foreach (JINI.Control.WebControl.SheetHeader f in header)
                        //{
                        //    string str = GetLangCode(f.TextField);
                        //    if (str != string.Empty)
                        //    {
                        //        f.TextField = str;
                        //        ((JINI.Control.WebControl.WebSheet)c).ModifyField(f);
                        //    }
                        //    else
                        //    {
                        //        if (f.Description != string.Empty)
                        //        {
                        //            f.TextField = f.Description;
                        //            ((JINI.Control.WebControl.WebSheet)c).ModifyField(f);
                        //        }
                        //    }
                        //}

                        //List<JINI.Control.WebControl.SheetField> field = ((JINI.Control.WebControl.WebSheet)c).GetField();
                        //foreach (JINI.Control.WebControl.SheetField f in field)
                        //{
                        //    string str = GetLangCode(f.TextField);
                        //    if (str != string.Empty)
                        //    {
                        //        f.TextField = str;
                        //        ((JINI.Control.WebControl.WebSheet)c).ModifyField(f);
                        //    }
                        //    else
                        //    {
                        //        if (f.Description != string.Empty)
                        //        {
                        //            f.TextField = f.Description;
                        //            ((JINI.Control.WebControl.WebSheet)c).ModifyField(f);
                        //        }
                        //    }
                        //}
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.SearchView)) // SearchView 는 Description이 없기 때문에 다국어 데이터가 없을시 현 텍스트를 표시함
                    {
                        foreach (System.Web.UI.Control cc in ((JINI.Control.WebControl.SearchView)c).Controls)
                        {
                            if (cc.GetType() == typeof(JINI.Control.WebControl.SearchViewField))
                            {
                                string str = GetLangCode(((JINI.Control.WebControl.SearchViewField)cc).TextField);
                                if (str != string.Empty)
                                {
                                    ((JINI.Control.WebControl.SearchViewField)cc).TextField = str;
                                    //((JINI.Control.WebControl.WebSheet)c).ModifyField((JINI.Control.WebControl.SheetField)cc);
                                }
                                else
                                {
                                    if (((JINI.Control.WebControl.SearchViewField)cc).Description != string.Empty)
                                    {
                                        ((JINI.Control.WebControl.SearchViewField)cc).TextField = ((JINI.Control.WebControl.SearchViewField)cc).Description;
                                        //((JINI.Control.WebControl.WebSheet)c).ModifyField((JINI.Control.WebControl.SheetField)cc);
                                    }
                                }
                            }
                        }
                        // cs에서 바인딩시 다국어 처리

                        List<JINI.Control.WebControl.SearchViewField> field = ((JINI.Control.WebControl.SearchView)c).GetField();
                        foreach (JINI.Control.WebControl.SearchViewField f in field)
                        {
                            string str = GetLangCode(f.TextField);
                            if (str != string.Empty)
                            {
                                f.TextField = str;
                                ((JINI.Control.WebControl.SearchView)c).ModifyField(f);
                            }
                            else
                            {
                                if (f.Description != string.Empty)
                                {
                                    f.TextField = f.Description;
                                    ((JINI.Control.WebControl.SearchView)c).ModifyField(f);
                                }
                            }
                        }

                        // EmptyText :: PlaceHolder 처리
                        string _str = GetLangCode(((JINI.Control.WebControl.SearchView)c).ID + "_EMPTY");
                        if (!string.IsNullOrEmpty(_str))
                        {
                            ((JINI.Control.WebControl.SearchView)c).PlaceHolder = _str;
                        }
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.WebTree))
                    {
                        string str = GetLangCode(((JINI.Control.WebControl.WebTree)c).Title);
                        if (str != string.Empty)
                        {
                            ((JINI.Control.WebControl.WebTree)c).Title = str;
                        }
                        else
                        {
                            ((JINI.Control.WebControl.WebTree)c).Title = ((JINI.Control.WebControl.WebTree)c).Description;
                        }
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.Combo))
                    {
                        foreach (System.Web.UI.WebControls.ListItem li in ((JINI.Control.WebControl.Combo)c).Items)
                        {
                            if (li.Attributes["LangCode"] != null)
                            {
                                string str = GetLangCode(li.Attributes["LangCode"].ToString());
                                if (str != string.Empty)
                                {
                                    li.Text = str;
                                }
                                //else
                                //{
                                //    if (li.Attributes["Description"] != null)
                                //    {
                                //        li.Text = li.Attributes["Description"].ToString();
                                //    }
                                //}
                            }
                        }
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.CheckBox))
                    {
                        foreach (System.Web.UI.WebControls.ListItem li in ((JINI.Control.WebControl.CheckBox)c).Items)
                        {
                            if (li.Attributes["LangCode"] != null)
                            {
                                string str = GetLangCode(li.Attributes["LangCode"].ToString());
                                if (str != string.Empty)
                                {
                                    li.Text = str;
                                }
                                //else
                                //{
                                //    if (li.Attributes["Description"] != null)
                                //    {
                                //        li.Text = li.Attributes["Description"].ToString();
                                //    }
                                //}
                            }
                        }
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.Radio))
                    {
                        foreach (System.Web.UI.WebControls.ListItem li in ((JINI.Control.WebControl.Radio)c).Items)
                        {
                            if (li.Attributes["LangCode"] != null)
                            {
                                string str = GetLangCode(li.Attributes["LangCode"].ToString());
                                if (str != string.Empty)
                                {
                                    li.Text = str;
                                }
                                //else
                                //{
                                //    if (li.Attributes["Description"] != null)
                                //    {
                                //        li.Text = li.Attributes["Description"].ToString();
                                //    }
                                //}
                            }
                        }
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.LayerTap))
                    {
                        string str = GetLangCode(((JINI.Control.WebControl.LayerTap)c).LangCode);
                        if (str != string.Empty)
                        {
                            ((JINI.Control.WebControl.LayerTap)c).Title = str;
                        }
                        else
                        {
                            if (!string.IsNullOrWhiteSpace(((JINI.Control.WebControl.LayerTap)c).Description))
                            {
                                ((JINI.Control.WebControl.LayerTap)c).Title = ((JINI.Control.WebControl.LayerTap)c).Description;
                            }
                        }
                    }
                    else if (c.GetType() == typeof(JINI.Control.WebControl.Layer))
                    {
                        string str = GetLangCode(((JINI.Control.WebControl.Layer)c).LangCode);
                        if (str != string.Empty)
                        {
                            ((JINI.Control.WebControl.Layer)c).Title = str;
                        }
                        else
                        {
                            if (!string.IsNullOrWhiteSpace(((JINI.Control.WebControl.Layer)c).Description))
                            {
                                ((JINI.Control.WebControl.Layer)c).Title = ((JINI.Control.WebControl.Layer)c).Description;
                            }
                        }
                    }
                }
            }

            // 상단메뉴 표시여부
            if (this.Master != null && this.Popup == false)
            {
                this.Master.FindControl("header").Visible = TopMenu;

                if (TopMenu)
                {
                    using (MenuBiz biz = new MenuBiz())
                    {
                        Hashtable ht = new Hashtable();
                        ht["UserInfo"] = Document.UserInfo;
                        DataSet menu = biz.GetMenuData(ht);

                        if (menu != null && menu.Tables.Count > 0 && menu.Tables[0].Rows.Count > 0)
                        {
                            string menutag = string.Empty;

                            foreach (DataRow dr in menu.Tables[0].Rows)
                            {
                                string style = string.Empty;
                                if (dr["IDX"].ToString() == this.TopMenuID) style = " class='toggle' ";

                                //menutag += "<li style='width: " + (100 / menu.Tables[0].Rows.Count).ToString() + "%;'>";
                                //menutag += "<li style='width: 250px;'>";
                                menutag += "<li style='width: 180px;'>";
                                menutag += "<h2><a onclick='PageProgressShow();' href='" + dr["PROGRAMPATH"].ToString() + "' " + style + ">" + dr["TEXT"].ToString() + "</a></h2>";
                                menutag += "</li>";
                            }

                            ((System.Web.UI.HtmlControls.HtmlGenericControl)this.Master.FindControl("topmenu")).InnerHtml = menutag;
                        }
                    }
                }
                else
                {
                    // 디자인 처리
                    ((System.Web.UI.WebControls.Literal)this.Master.FindControl("ltlCustomStyle")).Text +=
                        "#sub_body #container {top:0px}\n";
                }
            }

            // 좌측메뉴 표시여부
            if (this.Master != null && this.Popup == false && this.Main == false)
            {
                this.Master.FindControl("leftmenu_bx").Visible = LeftMenu;
                if (!LeftMenu)
                {
                    // 디자인 처리
                    ((System.Web.UI.WebControls.Literal)this.Master.FindControl("ltlCustomStyle")).Text +=
                        "#sub_body #container #content_bx {margin-left:0px}\n";
                    
                }
            }

            // 상단 & 좌측 디자인 처리
            
        } 
        #endregion

		#region OnLoadComplete - 페이지 로드완료시
		/// <summary>
		/// 페이지 로드완료시
		/// </summary>
		/// <param name="e"></param>
		protected override void OnLoadComplete(EventArgs e)
		{
			base.OnLoadComplete(e);

			string MenuID = this.MenuID;
			string ProgramID = this.ProgramID;

			// 메인일시 예외처리
			if (Request.Url.ToString().IndexOf("Main.aspx") > -1)
			{
				MenuID = "Main";
				ProgramID = "Main";
			}

            if (!string.IsNullOrEmpty(MenuID))
            {
                using (LoggingBiz loggerbiz = new LoggingBiz())
                {
                    loggerbiz.AddLogging("CONN", MenuID, DateTime.Now, ProgramID, UserIP, Document.EmpID, Environment.MachineName);
                }
            }
		} 
		#endregion

        #region GetLangCode - 다국어 코드로 텍스트를 반환한다.
        /// <summary>
        /// 다국어 코드로 텍스트를 반환한다.
        /// </summary>
        /// <param name="langCode"></param>
        /// <returns></returns>
        public string GetLangCode(string langCode)
        {
            string retData = string.Empty;

			// 데이터 값이 없을시 공백리턴
			if (LangCodeData == null) return retData;

            foreach (DataRow dr in LangCodeData.Rows)
            {
                if (dr["CODE"].ToString() == langCode)
                {
                    retData = dr["LANG_TEXT"].ToString();
                    break;
                }
            }

            return retData;
        } 
        #endregion

        #region OnLangInit - 다국어 처리를 위한 페이지 초기화 이벤트
        /// <summary>
        /// 다국어 처리를 위한 페이지 초기화 이벤트
        /// </summary>
        /// <param name="e"></param>
        protected virtual void OnLangInit(EventArgs e)
        {
            
        }
        #endregion

		#region GetCommonCode - 기본 공통코드를 가져온다.
		/// <summary>
		/// 기본 공통코드를 가져온다.
		/// </summary>
		/// <param name="pcode"></param>
		/// <returns></returns>
		public DataSet GetCommonCode(string pcode)
		{
            using (CommonBiz biz = new CommonBiz())
			{
				return biz.GetComCode(Document.UserInfo.CompanyCode, pcode, Document.ClientCultureName);
			}
		} 
		#endregion

        #region GetCommonCode - 기본 공통코드를 가져온다.(회사전체)
        /// <summary>
        /// 기본 공통코드를 가져온다.(회사전체)
        /// </summary>
        /// <param name="pcode"></param>
        /// <returns></returns>
        public DataSet GetCommonCodeAll(string pcode)
        {
            using (CommonBiz biz = new CommonBiz())
            {
                return biz.GetComCode("", pcode, Document.ClientCultureName);
            }
        }
        #endregion

        #region GetQueryString - URL 쿼리 문자열 변수를 가져온다.
        /// <summary>
        /// URL 쿼리 문자열 변수를 가져온다.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        protected string GetQueryString(string id)
        {
            string rtnValue = string.Empty;
            try
            {
                rtnValue = string.IsNullOrEmpty(Request.QueryString[id]) ? string.Empty : System.Web.HttpUtility.UrlDecode(Request.QueryString[id]);
            }
            catch (Exception e)
            {
            }

            return rtnValue;
        } 
        #endregion

        #region LTPAToken - 현재 LTPAToken입니다.
        /// <summary>
        /// 현재 LTPAToken입니다.
        /// </summary>
        private string LTPAToken
        {
            get
            {
                string rtnValue = string.Empty;

                if (!string.IsNullOrEmpty(this.UserID))
                {
                    rtnValue = this.UserID;
                }

                if (string.IsNullOrEmpty(rtnValue))
                {
                    // 테스트를 위하여 강제지정
                    if (HttpContext.Current.Request.UserHostAddress == "::1" || HttpContext.Current.Request.UserHostAddress == "127.0.0.1") // 로컬일시 테스트
                    {
                        rtnValue = "0287-M";
                        //rtnValue = "0311-M";
                        // 인증쿠키

                        FormsAuthentication.SetAuthCookie(rtnValue, false);
                        System.Web.HttpCookie LoginCookie = System.Web.Security.FormsAuthentication.GetAuthCookie(rtnValue, false);
                        //Document.SiteCompanyCode = "KOFCO";
                    }
                    else
                    {
                        rtnValue = "nologin";
                    }
                }

                //rtnValue = "0287-M";

                return rtnValue;
            }
        }
        #endregion

        #region GetMiddleString - 문자열 사이의 내용을 추출한다
        /// <summary>
        /// 문자열 사이의 내용을 추출한다
        /// </summary>
        /// <param name="str">원본 문자열</param>
        /// <param name="begin">시작값</param>
        /// <param name="end">마지막값</param>
        /// <returns></returns>
        private string GetMiddleString(string str, string begin, string end)
        {
            if (string.IsNullOrEmpty(str))
            {
                return null;
            }

            string result = null;
            if (str.IndexOf(begin) > -1)
            {
                str = str.Substring(str.IndexOf(begin) + begin.Length);
                if (str.IndexOf(end) > -1) result = str.Substring(0, str.IndexOf(end));
                else result = str;
            }
            return result;
        }
        #endregion

        #region GotoLogin - 로그인페이지로 이동
        /// <summary>
        /// 로그인페이지로 이동
        /// </summary>
        private void GotoLogin()
        {
            string retUrl = "http://{0}/LoginUserInfo.nsf/SetSessionVal?OpenAgent&rurl={1}&rparam={2}";

            retUrl = string.Format(retUrl, FxConfigManager.GetString("DominoURL"), HttpContext.Current.Request.Url.AbsoluteUri, HttpContext.Current.Request.Url.Query.Replace("?", "").Replace("&", HttpContext.Current.Server.UrlEncode("&")));

            HttpContext.Current.Response.Redirect(retUrl);
        } 
        #endregion

        /// <summary>
        /// Gets a Inverted DataTable
        /// </summary>
        /// <param name="table">DataTable do invert</param>
        /// <param name="columnX">X Axis Column</param>
        /// <param name="nullValue">null Value to Complete the Pivot Table</param>
        /// <param name="columnsToIgnore">Columns that should be ignored in the pivot 
        /// process (X Axis column is ignored by default)</param>
        /// <returns>C# Pivot Table Method  - Felipe Sabino</returns>
        public DataTable PivotDataTable(DataTable table, string columnX,
                                                     params string[] columnsToIgnore)
        {
            //Create a DataTable to Return
            DataTable returnTable = new DataTable();

            if (columnX == "")
                columnX = table.Columns[0].ColumnName;

            //Add a Column at the beginning of the table

            returnTable.Columns.Add(columnX);

            //Read all DISTINCT values from columnX Column in the provided DataTale
            List<string> columnXValues = new List<string>();

            //Creates list of columns to ignore
            List<string> listColumnsToIgnore = new List<string>();
            if (columnsToIgnore.Length > 0)
                listColumnsToIgnore.AddRange(columnsToIgnore);

            if (!listColumnsToIgnore.Contains(columnX))
                listColumnsToIgnore.Add(columnX);

            foreach (DataRow dr in table.Rows)
            {
                string columnXTemp = dr[columnX].ToString();
                //Verify if the value was already listed
                if (!columnXValues.Contains(columnXTemp))
                {
                    //if the value id different from others provided, add to the list of 
                    //values and creates a new Column with its value.
                    columnXValues.Add(columnXTemp);
                    returnTable.Columns.Add(columnXTemp);
                }
                else
                {
                    //Throw exception for a repeated value
                    throw new Exception("The inversion used must have " +
                                        "unique values for column " + columnX);
                }
            }

            //Add a line for each column of the DataTable

            foreach (DataColumn dc in table.Columns)
            {
                if (!columnXValues.Contains(dc.ColumnName) &&
                    !listColumnsToIgnore.Contains(dc.ColumnName))
                {
                    DataRow dr = returnTable.NewRow();
                    dr[0] = dc.ColumnName;
                    returnTable.Rows.Add(dr);
                }
            }

            //Complete the datatable with the values
            for (int i = 0; i < returnTable.Rows.Count; i++)
            {
                for (int j = 1; j < returnTable.Columns.Count; j++)
                {
                    returnTable.Rows[i][j] =
                      table.Rows[j - 1][returnTable.Rows[i][0].ToString()].ToString();
                }
            }

            return returnTable;
        }

        #region Description : string 값을 입력받아서 4자리로 변형해서 Return 해준다
        protected string Set_Fill4(string sFirst)
        {
            if (sFirst.Length == 1)
            {
                sFirst = "000" + sFirst;
            }
            else if (sFirst.Length == 2)
            {
                sFirst = "00" + sFirst;
            }
            else if (sFirst.Length == 3)
            {
                sFirst = "0" + sFirst;
            }
            else if (sFirst.Length == 4)
            {
                sFirst = sFirst;
            }
            else sFirst = "0000";

            return sFirst;
        }
        #endregion

        #region Description : string 값을 입력받아서 3자리로 변형해서 Return 해준다
        protected string Set_Fill3(string sFirst)
        {
            if (sFirst.Length == 1)
            {
                sFirst = "00" + sFirst;
            }
            else if (sFirst.Length == 2)
            {
                sFirst = "0" + sFirst;
            }
            else if (sFirst.Length == 3)
            {
                sFirst = sFirst;
            }
            else sFirst = "000";

            return sFirst;
        }
        #endregion

        #region Description : string 값을 입력받아서 2자리로 변형해서 Return 해준다
        protected string Set_Fill2(string sFirst)
        {
            if (sFirst.Length == 1)
            {
                sFirst = "0" + sFirst;
            }
            else if (sFirst.Length == 2)
            {
                sFirst = sFirst;
            }
            else sFirst = "00";

            return sFirst;
        }
        #endregion

        //==================================================================================================
        // YYYY-MM-DD형식을 YYYYMMDD형태의 string 으로 바꿔주는 메서드,,
        //==================================================================================================
        protected string Get_Date(string sStr)
        {
            if (sStr == "") return "";
            else return sStr.Replace("-", "");
        }

        protected string Set_Date(string sStr)
        {
            if (sStr.Length == 8)
            {
                sStr = sStr.Substring(0, 4) + "-" + sStr.Substring(4, 2) + "-" + sStr.Substring(6, 2);
            }
            else
            {
                sStr = "";
            }
            return sStr;
        }

        protected string Set_Time(string sStr)
        {
            if (sStr.Length == 4)
            {
                sStr = sStr.Substring(0, 2) + ":" + sStr.Substring(2, 2);
            }
            else if (sStr.Length == 6)
            {
                sStr = sStr.Substring(0, 2) + ":" + sStr.Substring(2, 2) + ":" + sStr.Substring(4, 2);
            }
            else
            {
                sStr = "";
            }
            return sStr;
        }

        #region 숫자 입력 텍스트박스는  000,000,000 형식을 000000000형태의 decimal 로 바꿔주는 메서드
        protected string Get_Numeric(string sStr)
        {
            if (sStr == "") return "0";
            else return sStr.Replace(",", "");
        }
        #endregion

        #region 암호화 복호화 함수
        public string DesEncrypt(string str)
        {
            byte[] iv = { 16, 29, 51, 112, 210, 78, 98, 186 };
            byte[] key = { 57, 129, 125, 118, 233, 60, 13, 94, 153, 156, 188, 9, 109, 20, 138, 7, 31, 221, 215, 91, 241, 82, 254, 189 };

            string encryptStr = string.Empty;

            byte[] bytIn = null;
            byte[] bytOut = null;
            MemoryStream ms = null;
            TripleDESCryptoServiceProvider tcs = null;
            ICryptoTransform ct = null;
            CryptoStream cs = null;

            try
            {

                bytIn = System.Text.Encoding.UTF8.GetBytes(str);

                ms = new MemoryStream();

                tcs = new TripleDESCryptoServiceProvider();

                ct = tcs.CreateEncryptor(key, iv);

                cs = new CryptoStream(ms, ct, CryptoStreamMode.Write);

                cs.Write(bytIn, 0, bytIn.Length);

                cs.FlushFinalBlock();

                bytOut = ms.ToArray();

                encryptStr = System.Convert.ToBase64String(bytOut, 0, bytOut.Length);
            }
            catch (Exception ex)
            {
            }
            finally
            {
                if (cs != null) { cs.Clear(); cs = null; }
                if (ct != null) { ct.Dispose(); ct = null; }
                if (tcs != null) { tcs.Clear(); tcs = null; }
                if (ms != null) { ms = null; }
            }

            return encryptStr;

        }

        //복호화
        public string DesDecrypt(string str)
        {
            byte[] iv = { 16, 29, 51, 112, 210, 78, 98, 186 };
            byte[] key = { 57, 129, 125, 118, 233, 60, 13, 94, 153, 156, 188, 9, 109, 20, 138, 7, 31, 221, 215, 91, 241, 82, 254, 189 };

            string decryptStr = string.Empty;

            byte[] bytIn = null;
            MemoryStream ms = null;
            TripleDESCryptoServiceProvider tcs = null;
            CryptoStream cs = null;
            ICryptoTransform ct = null;
            StreamReader sr = null;

            try
            {

                bytIn = System.Convert.FromBase64String(str);
                ms = new MemoryStream(bytIn, 0, bytIn.Length);
                tcs = new TripleDESCryptoServiceProvider();
                ct = tcs.CreateDecryptor(key, iv);
                cs = new CryptoStream(ms, ct, CryptoStreamMode.Read);
                sr = new StreamReader(cs);

                decryptStr = sr.ReadToEnd();

            }
            catch (Exception ex)
            {
            }
            finally
            {
                if (sr != null) { sr.Close(); sr = null; }
                if (cs != null) { cs.Clear(); cs = null; }
                if (ct != null) { ct.Dispose(); ct = null; }
                if (tcs != null) { tcs.Clear(); tcs = null; }
                if (ms != null) { ms.Close(); ms = null; }
            }

            return decryptStr;
        }
        #endregion
    }
}