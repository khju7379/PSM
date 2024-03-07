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
using JINI.Util.Json;

namespace TaeYoung.Portal
{
    public partial class Login : System.Web.UI.Page
    {
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


            if (!string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                DirectLogin(Request.QueryString["id"]);

                //DirectLogin("khim");
            }
        }

        //http://localhost:8110/Portal/Login.aspx?id=khim&ReturnUrl=/Template/EDU/TankMonitor3.aspx
        /// <summary>
        /// 강제로 로그인
        /// </summary>
        /// <param name="id"></param>
        private void DirectLogin(string id)
        {
            // 세션이 없거나 ID가 변경되었음
            using (OrgChartBiz biz = new OrgChartBiz())
            {
                DataSet ds = biz.GetUserinfoLogin(id, Document.ClientCultureName.ToLower());

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
                            , ""//userById["SignID"].ToString()
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
                        Response.Redirect("Main.aspx");

                        //Response.Redirect("/Template/EDU/TankMonitor3.aspx");
                    }
                    else
                    {
                        Response.Redirect(return_url);
                    }
                }


            }
        }


        // TaeYoung.Portal.Svcdominoadmin Svc = new TaeYoung.Portal.Svcdominoadmin("webmaster", EncryptionManager.EncryptString(System.Configuration.ConfigurationManager.AppSettings["PublicKey"].ToString(), "tyc3362"));
        // this.txtPWD.Text = Svc.GetDefaultDBPath(id);
        
        protected void btn_login_Click(object sender, EventArgs e)
        {
            // 세션이 없거나 ID가 변경되었음
            using (OrgChartBiz biz = new OrgChartBiz())
            {
                string id = txt_login_id.Value;
                string pw = txt_login_pw.Value;
                string company = hdnCompany2.Text;

                //TaeYoung.Portal.Svcdominoadmin Svc = new TaeYoung.Portal.Svcdominoadmin("webmaster", EncryptionManager.EncryptString(System.Configuration.ConfigurationManager.AppSettings["PublicKey"].ToString(), "tyc3362"));

                //string sGwPw = Svc.GetDefaultDBPath(id);

                //bool isLogin = false;
                //bool isCustomer = false;

                //if (sGwPw == pw) isLogin = true;
                //else
                //{
                //    DataSet ds = biz.GetLoginCustomer(id, pw);
                //    if (ds != null && ds.Tables.Count > 0 // 리턴되는 테이블이 있는지
                //        && ds.Tables[0].Rows.Count > 0 // 리턴되는 데이터가 있는지
                //        && Convert.ToInt32(ds.Tables[0].Rows[0][0]) > 0) // 아이디와 비밀번호로 조회하여 데이터 갯수를 가져온다.
                //    {
                //        isLogin = true;
                //        isCustomer = true;
                //    }
                //}

                bool isLogin = false;
                bool isCustomer = false;

                DataSet dsLogin = biz.GetLoginCustomer(id, pw);
                if (dsLogin != null && dsLogin.Tables.Count > 0 // 리턴되는 테이블이 있는지
                    && dsLogin.Tables[0].Rows.Count > 0 // 리턴되는 데이터가 있는지
                    && Convert.ToInt32(dsLogin.Tables[0].Rows[0][0]) > 0) // 아이디와 비밀번호로 조회하여 데이터 갯수를 가져온다.
                {
                    isLogin = true;
                    isCustomer = true;
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
                            , ""//userById["SignID"].ToString()
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

                        if (isCustomer)
                        {
                            

                            switch (userById["CompanyCode"].ToString())
                            {
                                case "UT": // UTT고객정보
                                    Response.Redirect("/Portal/TYCSI/CSIHome.aspx");
                                    break;
                                case "US": // SILO고객정보
                                    Response.Redirect("/Portal/TYCSS/CSSHome.aspx");
                                    break;
                                case "TG": // 그레인고객정보
                                    Response.Redirect("/Portal/TGCSI/CSIHome.aspx");
                                    break;                             
                            }

                            
                            
                        }
                        else
                        {
                            Response.Redirect("/Portal/PSM/PSMHome.aspx");
                        }
                        

                        //Response.Redirect("/Template/EDU/TankMonitor3.aspx");
                    }
                    else
                    {
                        Response.Redirect(return_url);
                    }
                }
                else // 로그인 실패시
                {
                    ClientScript.RegisterClientScriptBlock(GetType(), "error", "alert('아이디나 비밀번호가111 틀렸습니다.');", true);
                }


            }
        } 

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
