using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using TaeYoung.Biz.Common;
using TaeYoung.Biz;
using System.Web.Security;
using System.Collections;
using System.Reflection;
using System.IO;
using JINI.Base.Configuration;
using System.Web.Services;
using System.Web.Script.Services;
using System.ServiceModel.Web;
using System.Text.RegularExpressions;
using JINI.Util.Json;
using TaeYoung.Common;


namespace TaeYoung.Portal
{
    public partial class PortalLogin : System.Web.UI.Page
    {

        private string sNew_ACTION = "";
        private string sNew_SABUN = "";
        private string sNew_pwd = "";

        private string sPSM_ACTION  = "";
        private string sPSM_SABUN   = "";
        private string sPSM_pwd     = "";
        private string sPSM_LinkUrl = "";
        private string sPSM_Param   = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            form1.DefaultButton = "btn_login";
            form1.DefaultFocus = "txt_login_id";

            //if (IsPostBack)
            //{
            //    if (!string.IsNullOrEmpty(this.User.Identity.Name))
            //    {
            //        Response.Redirect("/WebTemplate/Template01.aspx");
            //    }
            //}
            //
            // 

            //Guid guidKey = Guid.NewGuid();

            //string str = Regex.Replace("G+DQZYytxJgRYgUWK1WuZw==", @"\+", "\x20");

            //Page.ClientScript.RegisterStartupScript(typeof(Page), guidKey.ToString(), "alert('" + str + "');", true);

            if (Request.QueryString.Count > 0 )
            {
                sPSM_ACTION = Request.QueryString[0];
                sPSM_SABUN  = Request.QueryString[1];
                sPSM_pwd    = Request.QueryString[2];

                sPSM_LinkUrl = Request.QueryString[3];


                if (!string.IsNullOrEmpty(sPSM_ACTION))
                {
                    if (sPSM_ACTION.ToString() == "APPPAGE")
                    {
                        sPSM_Param = "&param1=" + Request.Form["param1"];
                        sPSM_LinkUrl = sPSM_LinkUrl + sPSM_Param;
                    }

                    DirectLogin(sPSM_ACTION, sPSM_SABUN, sPSM_pwd);
                }
            }

            sNew_ACTION  = Request.Form["ACTION"];
            sNew_SABUN   = Request.Form["SABUN"];
            sNew_pwd     = Request.Form["PWD"];

            sPSM_LinkUrl = Request.Form["LINKURL"];

            if (!string.IsNullOrEmpty(sNew_ACTION))
            {
                if (sNew_ACTION.ToString() == "APPPAGE")
                {
                    sPSM_Param = "&param1=" + Request.Form["param1"];
                    sPSM_LinkUrl = sPSM_LinkUrl + sPSM_Param;
                }

                DirectLogin(sNew_ACTION, sNew_SABUN, sNew_pwd);
            }



        }

        //http://localhost:8110/Portal/Login.aspx?id=khim&ReturnUrl=/Template/EDU/TankMonitor3.aspx
        /// <summary>
        /// 강제로 로그인
        /// </summary>
        /// <param name="id"></param>
        private void DirectLogin(string sACTION, string id, string pwd)
        {
            
            // 세션이 없거나 ID가 변경되었음
            using (OrgChartBiz biz = new OrgChartBiz())
            {
                //Page.ClientScript.RegisterStartupScript(typeof(Page), guidKey.ToString(), "alert('" + sMsg1 + "');", true);

                if (sACTION.ToString() == "APPPAGE")
                {
                    DataSet gwpw_ds = biz.UP_SMS_TB_PASSWORD_RUN("TYI", id, "");

                    if (gwpw_ds.Tables[0].Rows.Count > 0)
                    {
                        pwd = gwpw_ds.Tables[0].Rows[0]["PASSWORD"].ToString();
                    }

                    //sMsg2 = "비번2:" + pwd;

                    //Page.ClientScript.RegisterStartupScript(typeof(Page), guidKey.ToString(), "alert('" + sMsg2 + "');", true);
                }
                else
                {
                    if (pwd.ToString() != "")
                    {
                        pwd = pwd.ToString().Replace(" ", "+");
                    }
                }
            }

            using (OrgChartBiz biz = new OrgChartBiz())
            {
                //sMsg3 = "비번3:" + pwd;

                //Page.ClientScript.RegisterStartupScript(typeof(Page), guidKey.ToString(), "alert('" + sMsg3 + "');", true);

                DataSet gwds = biz.UP_SMS_TB_PASSWORD_RUN("TYI", id, pwd);

                if (gwds.Tables[0].Rows.Count > 0)
                {
                    string sMailid = gwds.Tables[0].Rows[0]["KBMAILID"].ToString();

                    DataSet ds = biz.GetUserinfoLogin(sMailid, "ko");

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow userById = ds.Tables[0].Rows[0];

                        // 세션생성

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
                                , "Portal"//userById["SignID"].ToString()
                                , userById["JobCode"].ToString()
                                , userById["JobName"].ToString()
                                , userById["LocationCode"].ToString()
                                , userById["DPARTNER"].ToString() == "0" ? false : true
                                , userById["kostl"].ToString()
                                , userById["SITECOMPANY"].ToString());

                        // 회사코드 
                        Document.SiteCompanyCode = Document.UserInfo.SiteCompanyCode;


                        // 인증쿠키

                        FormsAuthentication.SetAuthCookie(id, false);

                        System.Web.HttpCookie LoginCookie = System.Web.Security.FormsAuthentication.GetAuthCookie(id, false);
                        //System.Web.Security.FormsAuthentication.RedirectFromLoginPage(loginid, false, System.Web.Security.FormsAuthentication.FormsCookiePath);
                        Response.AppendCookie(LoginCookie);

                        //Response.Redirect("/Portal/Main.aspx");
                        // 원래는 바로 Response.Redirect("Main.aspx"); 를 호출했으나 ReturnUrl이 있을시 로그인후 원래 호출하려던 페이지로 이동 추가 2017-06-08 장윤호
                        string return_url = Request.QueryString["ReturnUrl"] == null ? "" : Server.UrlDecode(Request.QueryString["ReturnUrl"].ToString());
                        if (string.IsNullOrEmpty(return_url))
                        {
                            //로그인사번의 권한 조회후 첫번째 메뉴 자동 선택
                            using (MenuBiz mbiz = new MenuBiz())
                            {
                                if (sACTION.ToString() == "APPPAGE")
                                {
                                    //Response.Redirect(sPSM_LinkUrl);
                                    //this.Page.Response.Write("<script type='text/javascript'>window.open('" + sPSM_LinkUrl + "','_blank', 'width=1200,height=800');window.open('about:blank','_self').close();function fn_OpenClose(){this.close();}fn_OpenClose();</script>");
                                    //this.Page.Response.Write("<script type='text/javascript'>window.open('" + sPSM_LinkUrl + "','_blank', 'width=1200,height=800');this.close();window.open('about:blank','_self').close();window.opener = self; self.close();</script>");
                                    this.Page.Response.Write("<script type='text/javascript'>window.open('" + sPSM_LinkUrl + "','_blank', 'width=1200,height=1000');window.opener = self; self.close();window.open('about:blank','_self').close();</script>");
                                }
                                else
                                {
                                    Hashtable ht = new Hashtable();
                                    ht["UserInfo"] = Document.UserInfo;
                                    DataSet menu = mbiz.GetMenuData(ht);

                                    if (menu != null && menu.Tables.Count > 0 && menu.Tables[0].Rows.Count > 0)
                                    {
                                        string sLocation = menu.Tables[0].Rows[0]["PROGRAMPATH"].ToString();

                                        int indexValue = sLocation.IndexOf("SMS");

                                        if (indexValue > 0)  //비상통보 권한만 있으면 최초화면으로 강제 이동
                                        {
                                            Response.Redirect("/Portal/SMS/SMS10/SMS1010.aspx");
                                        }
                                        else
                                        {
                                            Response.Redirect(menu.Tables[0].Rows[0]["PROGRAMPATH"].ToString());
                                        }
                                    }
                                    else
                                    {
                                        Response.Redirect("Main.aspx");
                                    }
                                }
                            }
                        }
                        else
                        {
                            Response.Redirect(return_url);
                        }
                    }
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(GetType(), "error", "alert('아이디나 비밀번호가 틀렸습니다.');", true);
                }

            }
        }


        // TaeYoung.Portal.Svcdominoadmin Svc = new TaeYoung.Portal.Svcdominoadmin("webmaster", EncryptionManager.EncryptString(System.Configuration.ConfigurationManager.AppSettings["PublicKey"].ToString(), "tyc3362"));
        // this.txtPWD.Text = Svc.GetDefaultDBPath(id);
        
        protected void btn_login_Click(object sender, EventArgs e)
        {
            //UP_Notes_Login();

            UP_Jini_Login();
        }

        #region 노츠 로그인 체크 함수
        private void UP_Notes_Login()
        {
            // 세션이 없거나 ID가 변경되었음
            using (OrgChartBiz biz = new OrgChartBiz())
            {
                string id = txt_login_id.Value;
                string pw = txt_login_pw.Value;
                string company = hdnCompany2.Text;

                TaeYoung.Portal.Svcdominoadmin Svc = new TaeYoung.Portal.Svcdominoadmin("webmaster", EncryptionManager.EncryptString(System.Configuration.ConfigurationManager.AppSettings["PublicKey"].ToString(), "tyc3362"));

                string sGwPw = Svc.GetDefaultDBPath(id);

                bool isLogin = false;
                bool isCustomer = false;

                if (sGwPw == pw) isLogin = true;
                else
                {
                    DataSet ds = biz.GetLoginCustomer(id, pw);
                    if (ds != null && ds.Tables.Count > 0 // 리턴되는 테이블이 있는지
                        && ds.Tables[0].Rows.Count > 0 // 리턴되는 데이터가 있는지
                        && Convert.ToInt32(ds.Tables[0].Rows[0][0]) > 0) // 아이디와 비밀번호로 조회하여 데이터 갯수를 가져온다.
                    {
                        isLogin = true;
                        isCustomer = true;
                    }
                }

                if (isLogin)
                {
                    //DataSet ds = biz.GetUserinfoLogin(id, Document.ClientCultureName.ToLower());

                    DataSet ds = biz.GetUserinfoLogin(id, "ko");

                    DataRow userById = ds.Tables[0].Rows[0];

                    // 세션생성

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
                            , "Portal"//userById["SignID"].ToString()
                            , userById["JobCode"].ToString()
                            , userById["JobName"].ToString()
                            , userById["LocationCode"].ToString()
                            , userById["DPARTNER"].ToString() == "0" ? false : true
                            , userById["kostl"].ToString()
                            , userById["SITECOMPANY"].ToString());



                    // 회사코드 
                    Document.SiteCompanyCode = Document.UserInfo.SiteCompanyCode;

                    // 인증쿠키
                    FormsAuthentication.SetAuthCookie(userById["empid"].ToString(), false);

                    System.Web.HttpCookie LoginCookie = System.Web.Security.FormsAuthentication.GetAuthCookie(userById["empid"].ToString(), false);
                    //System.Web.Security.FormsAuthentication.RedirectFromLoginPage(loginid, false, System.Web.Security.FormsAuthentication.FormsCookiePath);
                    Response.AppendCookie(LoginCookie);

                    //Response.Redirect("/Portal/Main.aspx");
                    // 원래는 바로 Response.Redirect("Main.aspx"); 를 호출했으나 ReturnUrl이 있을시 로그인후 원래 호출하려던 페이지로 이동 추가 2017-06-08 장윤호
                    string return_url = Request.QueryString["ReturnUrl"] == null ? "" : Server.UrlDecode(Request.QueryString["ReturnUrl"].ToString());
                    if (string.IsNullOrEmpty(return_url))
                    {
                        //영문설정                       
                        if (enremember.Checked)
                        {
                            Document.ClientCultureName = "en";
                        }

                        //로그인사번의 권한 조회후 첫번째 메뉴 자동 선택
                        using (MenuBiz mbiz = new MenuBiz())
                        {
                            Hashtable ht = new Hashtable();
                            ht["UserInfo"] = Document.UserInfo;
                            DataSet menu = mbiz.GetMenuData(ht);

                            if (menu != null && menu.Tables.Count > 0 && menu.Tables[0].Rows.Count > 0)
                            {
                                //Response.Redirect(menu.Tables[0].Rows[0]["PROGRAMPATH"].ToString());

                                string sLocation = menu.Tables[0].Rows[0]["PROGRAMPATH"].ToString();

                                int indexValue = sLocation.IndexOf("SMS");

                                if (indexValue > 0)  //비상통보 권한만 있으면 최초화면으로 강제 이동
                                {
                                    Response.Redirect("/Portal/SMS/SMS10/SMS1010.aspx");
                                }
                                else
                                {
                                    Response.Redirect(menu.Tables[0].Rows[0]["PROGRAMPATH"].ToString());
                                }
                            }
                            else
                            {
                                Response.Redirect("Main.aspx");
                            }
                        }
                    }
                    else
                    {
                        Response.Redirect(return_url);
                    }
                }
                else // 로그인 실패시
                {
                    ClientScript.RegisterClientScriptBlock(GetType(), "error", "alert('아이디나 비밀번호가 틀렸습니다.');", true);
                }


            }
        }
        #endregion

        #region 신 그룹웨어 로그인
        private void UP_Jini_Login()
        {
            // 세션이 없거나 ID가 변경되었음
            using (OrgChartBiz biz = new OrgChartBiz())
            {
                string id = txt_login_id.Value;
                string pw = txt_login_pw.Value;
                string company = "TYI";               
                                
                DataSet gwds = biz.UP_SMS_TB_USER_RUN(company, id, TaeYoung.Common.EncryptionManager.EncryptBase64(System.Configuration.ConfigurationManager.AppSettings["PassKey"].ToString(), pw));

                if (gwds.Tables[0].Rows.Count > 0)
                {
                    
                    DataSet ds = biz.GetUserinfoLogin(id, "ko");

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {

                        DataRow userById = ds.Tables[0].Rows[0];

                        // 세션생성

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
                                , "Portal"//userById["SignID"].ToString()
                                , userById["JobCode"].ToString()
                                , userById["JobName"].ToString()
                                , userById["LocationCode"].ToString()
                                , userById["DPARTNER"].ToString() == "0" ? false : true
                                , userById["kostl"].ToString()
                                , userById["SITECOMPANY"].ToString());

                        // 회사코드 
                        Document.SiteCompanyCode = Document.UserInfo.SiteCompanyCode;


                        // 인증쿠키

                        FormsAuthentication.SetAuthCookie(id, false);

                        System.Web.HttpCookie LoginCookie = System.Web.Security.FormsAuthentication.GetAuthCookie(id, false);
                        //System.Web.Security.FormsAuthentication.RedirectFromLoginPage(loginid, false, System.Web.Security.FormsAuthentication.FormsCookiePath);
                        Response.AppendCookie(LoginCookie);

                        //Response.Redirect("/Portal/Main.aspx");
                        // 원래는 바로 Response.Redirect("Main.aspx"); 를 호출했으나 ReturnUrl이 있을시 로그인후 원래 호출하려던 페이지로 이동 추가 2017-06-08 장윤호
                        string return_url = Request.QueryString["ReturnUrl"] == null ? "" : Server.UrlDecode(Request.QueryString["ReturnUrl"].ToString());
                        if (string.IsNullOrEmpty(return_url))
                        {
                            //로그인사번의 권한 조회후 첫번째 메뉴 자동 선택
                            using (MenuBiz mbiz = new MenuBiz())
                            {
                                Hashtable ht = new Hashtable();
                                ht["UserInfo"] = Document.UserInfo;
                                DataSet menu = mbiz.GetMenuData(ht);

                                if (menu != null && menu.Tables.Count > 0 && menu.Tables[0].Rows.Count > 0)
                                {
                                    string sLocation = menu.Tables[0].Rows[0]["PROGRAMPATH"].ToString();

                                    int indexValue = sLocation.IndexOf("SMS");

                                    if (indexValue > 0)  //비상통보 권한만 있으면 최초화면으로 강제 이동
                                    {
                                        Response.Redirect("/Portal/SMS/SMS10/SMS1010.aspx");
                                    }
                                    else
                                    {
                                        Response.Redirect(menu.Tables[0].Rows[0]["PROGRAMPATH"].ToString());
                                    }
                                }
                                else
                                {
                                    Response.Redirect("Main.aspx");
                                }
                            }
                        }
                        else
                        {
                            Response.Redirect(return_url);
                        }
                    }
                }
                else
                {
                    ClientScript.RegisterClientScriptBlock(GetType(), "error", "alert('아이디나 비밀번호가 틀렸습니다.');", true);
                }

            }
        }
        #endregion


        /*
         protected void btn_login_Click(object sender, EventArgs e)
         {
             // 세션이 없거나 ID가 변경되었음
             using (OrgChartBiz biz = new OrgChartBiz())
             {
                 string id = txt_login_id.Value;
                 string pw = txt_login_pw.Value;
                 string company = hdnCompany2.Text;

                 DataSet ds = biz.GetUserinfoLogin(id, Document.ClientCultureName.ToLower());

                 if(ds!=null && ds.Tables.Count>0 && ds.Tables[0].Rows.Count>0)
                 {
                     DataRow userById = ds.Tables[0].Rows[0];

                     // 비밀번호 체크
                     string pw_e = JINI.Base.Security.EncryptionManager.EncryptString(FxConfigManager.GetString("Encryption"), pw);

                     if (pw_e != userById["PASSWORD"].ToString().Trim())
                     {
                         ClientScript.RegisterClientScriptBlock(GetType(), "error", "alert('아이디나 비밀번호가 틀렸습니다.');", true);
                         return;
                     }

                     // 세션생성

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

                     // 회사코드 
                     Document.SiteCompanyCode = Document.UserInfo.SiteCompanyCode;


                     // 인증쿠키

                     FormsAuthentication.SetAuthCookie(id, false);

                     System.Web.HttpCookie LoginCookie = System.Web.Security.FormsAuthentication.GetAuthCookie(id, false);
                     //System.Web.Security.FormsAuthentication.RedirectFromLoginPage(loginid, false, System.Web.Security.FormsAuthentication.FormsCookiePath);
                     Response.AppendCookie(LoginCookie);

                     //Response.Redirect("/Portal/Main.aspx");
                     // 원래는 바로 Response.Redirect("Main.aspx"); 를 호출했으나 ReturnUrl이 있을시 로그인후 원래 호출하려던 페이지로 이동 추가 2017-06-08 장윤호
                     string return_url = Request.QueryString["ReturnUrl"] == null ? "" : Server.UrlDecode(Request.QueryString["ReturnUrl"].ToString());
                     if (string.IsNullOrEmpty(return_url))
                     {
                         Response.Redirect("/Portal/PSM/PSMHome.aspx");

                         //Response.Redirect("/Template/EDU/TankMonitor3.aspx");
                     }
                     else
                     {
                         Response.Redirect(return_url);
                     }
                 }
                 else // 로그인 실패시
                 {
                     ClientScript.RegisterClientScriptBlock(GetType(), "error", "alert('아이디나 비밀번호가 틀렸습니다.');", true);
                 }


             }
         } */

        #region InvokeServiceTable - html에서 Biz메소드를 AJAX로 호출한다.
        /// <summary>
        /// html에서 Biz메소드를 AJAX로 호출한다.
        /// </summary>
        /// <param name="data">실행 파라미터</param>
        /// <param name="typeString">실행될 Biz의 클래스명</param>
        /// <param name="methodName">실행될 Biz의 메소드명</param>
        /// <returns>결과값 JSON데이터</returns>
        /// <history>DLL 잠금 문제로 인하여 AppDomain으로 메소드 호출로 변경함</history>
        [WebMethod(true)]
        [WebInvoke(RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json)]
        [ScriptMethod(XmlSerializeString = true)]
        public static object InvokeServiceTable(string data, string typeString, string methodName)
        {
            // 방법을 변경하여 appdomain을 사용하지 않고 호출

            // 기존 hashtable형태의 데이터를 string으로 변경함으로 string -> hashtable로 변환해야함
            Hashtable hashData = ConvertHashtable(data);

            // 추가 - hashtable에 session 값을 추가한다.
            hashData.Add("UserInfo", HttpContext.Current.Session["UserInfo"]);

            string strRet = string.Empty;

            string dllPath = HttpContext.Current.Server.MapPath(FxConfigManager.GetString("AssemblyPath"));
            string dllName = FxConfigManager.GetString("AssemblyName");

            //Assembly assembly = Assembly.LoadFile(dllPath);

            // 파일을 검색하여 dll의 버전을 가져온다.
            System.Diagnostics.FileVersionInfo ver = System.Diagnostics.FileVersionInfo.GetVersionInfo(dllPath);

            string AssemblyTempPath = string.Empty;

            if (string.IsNullOrEmpty(FxConfigManager.GetString("AssemblyTempPath")))
            {
                AssemblyTempPath = "C:\\AssemblyTempPath";
            }
            else
            {
                AssemblyTempPath = FxConfigManager.GetString("AssemblyTempPath");
            }

            // 뒤에 \\ 가있을시 제거
            AssemblyTempPath = AssemblyTempPath.TrimEnd('\\');

            // 경로 생성
            string tempDllString = AssemblyTempPath + "\\" + dllName + "\\" + ver.FileVersion + ".dll";

            FileInfo dll_file = new FileInfo(tempDllString);

            if (!dll_file.Exists)
            {
                Directory.CreateDirectory(dll_file.Directory.FullName);
                File.Copy(dllPath, tempDllString); // 파일이 없을시 복사
            }

            Assembly assembly = Assembly.LoadFile(tempDllString);

            Type type = assembly.GetType(dllName + "." + typeString);
            if (type != null)
            {
                MethodInfo methodInfo = type.GetMethod(methodName);

                if (methodInfo != null)
                {
                    object result = null;
                    ParameterInfo[] parameters = methodInfo.GetParameters();

                    if (methodInfo.IsStatic) // static 메소드 여부 확인하여 처리
                    {
                        object[] parametersArray = new object[] { hashData };

                        result = methodInfo.Invoke(methodInfo, parametersArray);
                    }
                    else
                    {
                        object classInstance = Activator.CreateInstance(type, null);

                        object[] parametersArray = new object[] { hashData };

                        result = methodInfo.Invoke(classInstance, parametersArray);
                    }

                    //object classInstance = Activator.CreateInstance(type, null);
                    //if (parameters.Length == 0)
                    //{
                    //	result = methodInfo.Invoke(classInstance, null);
                    //}
                    //else
                    //{
                    //	object[] parametersArray = new object[] { hashData };
                    //
                    //	result = methodInfo.Invoke(methodInfo, parametersArray);
                    //}

                    // 

                    DataSet ds = (DataSet)result;

                    if (ds != null && ds.Tables.Count > 0)
                    {
                        strRet = string.Format("({0})", JsonConvert.Convert(ds, true));
                    }
                    else
                    {
                        strRet = "({\"DataSetName\" : \"NewDataSet\",\"Tables\" : [{\"TableName\" : \"Table\"}]})";
                    }
                }
            }

            return strRet;
        }
        #endregion

        #region ConvertHashtable - JObject(JSON)값을 hashtable로 변환한다.
        /// <summary>
        /// JObject(JSON)값을 hashtable로 변환한다.
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        private static Hashtable ConvertHashtable(string data)
        {
            Hashtable hashData = Newtonsoft.Json.JsonConvert.DeserializeObject<Hashtable>(data);
            Hashtable ht = new Hashtable();

            // Hashtable 내용을 검색하여 타입이 JObject일시 내용을 Hashtable로 변환한다.
            foreach (string key in hashData.Keys)
            {
                if (hashData[key] != null && hashData[key].GetType().Name == "JObject")
                {
                    Hashtable convertHt = ConvertHashtable(hashData[key].ToString().Replace("\r\n", ""));
                    Dictionary<string, object> dictionary = new Dictionary<string, object>();

                    foreach (string inKey in convertHt.Keys)
                    {
                        dictionary.Add(inKey, convertHt[inKey]);
                    }

                    ht[key] = dictionary;
                }
                else
                {
                    ht[key] = hashData[key];
                }
            }

            return ht;
        }
        #endregion

        

    }
}
