using System.Web;
using TaeYoung.Biz.Type;
using JINI.User;

namespace TaeYoung.Biz
{
    public static class Document
    {
        #region UserInfo - 사용자 정보를 가져오거나 설정한다.
        /// <summary>
        /// 사용자 정보를 가져오거나 설정한다.
        /// </summary>
        public static UserInfo UserInfo
        {
            get
            {
                if (HttpContext.Current.Session["UserInfo"] != null)
                {
                    return (UserInfo)HttpContext.Current.Session["UserInfo"];
                }
                else
                {
                    return null;
                }
            }
            set
            {
                //HttpContext.Current.Session.Remove("UserInfo"); // 삭제후 재설정
                HttpContext.Current.Session["UserInfo"] = value;
            }
        } 
        #endregion

        #region ClientCultureName - 클라이언트가 선택한 다국어코드를 가져오거나 선택한다.
        /// <summary>
        /// 클라이언트가 선택한 다국어코드를 가져오거나 선택한다.
        /// </summary>
        public static string ClientCultureName
        {
            get
            {
                string cultureName = string.Empty;

                // 쿠키가 있는지 확인
                if (HttpContext.Current.Request.Cookies["Language"] != null)
                {
                    cultureName = HttpContext.Current.Request.Cookies["Language"].Value;
                    HttpContext.Current.Session["Language"] = cultureName;
                }
                else if (HttpContext.Current.Session["Language"] != null)
                {
                    cultureName = HttpContext.Current.Session["Language"].ToString();
                }
                else
                {
                    cultureName = "ko";
                }

                return cultureName;

                //return HttpContext.Current.Session["Language"] == null ? "KO" : HttpContext.Current.Session["Language"].ToString();
            }
            set
            {
                HttpContext.Current.Session["Language"] = value;

                // 쿠키처리
                HttpCookie cookie = new HttpCookie("Language");
                //cookie.Domain = "sjku.co.kr";
                //cookie.Domain = "localhost";
                cookie.Value = value;
                HttpContext.Current.Response.Cookies.Add(cookie);

                Document.UserInfo.ClientCultureName = value; // UserInfo에도 적용(Biz 용)
            }

        }
        #endregion

        #region UserLoacle - 사용자 로케일 설정 (숫자, 날짜 표기 등)
        /// <summary>
        /// 사용자 로케일 설정 (숫자, 날짜 표기 등)
        /// </summary>
        public static string UserLocale
        {
            get
            {
                string locale = string.Empty;

                // 쿠키가 있는지 확인
                if (HttpContext.Current.Request.Cookies["UserLocale"] != null)
                {
                    locale = HttpContext.Current.Request.Cookies["UserLocale"]["UserLocale"];
                }
                else if (HttpContext.Current.Session["UserLocale"] != null)
                {
                    locale = HttpContext.Current.Session["UserLocale"].ToString();
                }

                // 설정된 로케일이 없을 경우, 언어 설정 값을 사용한다.
                return string.IsNullOrEmpty(locale) ? ClientCultureName : locale;

            }
            set
            {
                HttpContext.Current.Session["UserLocale"] = value;

                // 쿠키처리
                HttpCookie cookie = new HttpCookie("UserLocale");
                cookie["UserLocale"] = value;
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
        }
        #endregion

        #region SiteCompany - 회사변경에 의한 회사코드
        /// <summary>
        /// 회사변경에 의한 회사코드
        /// </summary>
        public static string SiteCompanyCode
        {
            get
            {
                string siteCompany = string.Empty;

                //foreach (HttpCookie cookie in HttpContext.Current.Request.Cookies)
                //{
                //    if (cookie.Domain == "iTaeYoung.com" && cookie.Name == "company")
                //    {
                //        siteCompany = cookie.Value;
                //    }
                //}

                //if (string.IsNullOrEmpty(siteCompany))
                //{
                //    siteCompany = HttpContext.Current.Session["company"].ToString();
                //}

                // 업체일시 SiteCompany에 CompanyCode값을 리턴
                if (Document.UserInfo != null && Document.UserInfo.IsVend)
                {
                    // 세션값도 변경
                    //Document.UserInfo.SiteCompanyCode = Document.UserInfo.CompanyCode;

                    if (HttpContext.Current.Request.Cookies["SiteCompany_EP"] == null)
                        SiteCompanyCode = Document.UserInfo.CompanyCode;

                    return HttpContext.Current.Request.Cookies["SiteCompany_EP"].Value;
                }

                // 쿠키가 있는지 확인
                if (HttpContext.Current.Request.Cookies["SiteCompany_EP"] != null)
                {
                    siteCompany = HttpContext.Current.Request.Cookies["SiteCompany_EP"].Value;
                }

                //HttpContext.Current.Session["company"] = siteCompany;
                else if (HttpContext.Current.Session["SiteCompany_EP"] != null)
                {
                    siteCompany = HttpContext.Current.Session["SiteCompany_EP"].ToString();
                }

                if (HttpContext.Current.Request.Url.AbsolutePath.ToUpper().IndexOf("/EIS/") < 0)
                {
                    // 쿠키가 있는지 확인
                    if (HttpContext.Current.Request.Cookies["company"] != null)
                    {
                        siteCompany = HttpContext.Current.Request.Cookies["company"].Value;
                    }
                }

                //HttpContext.Current.Session["company"] = siteCompany;
                else if (HttpContext.Current.Session["company"] != null)
                {
                    siteCompany = HttpContext.Current.Session["company"].ToString();
                }

                //SiteCompany 값 오류 확인
                //string[] arrayVal = siteCompany.Split('=');
                //if (arrayVal.Length > 1)
                //{
                //    siteCompany = arrayVal[arrayVal.Length-1];
                //}

                // 설정된 로케일이 없을 경우, 언어 설정 값을 사용한다.
                return siteCompany;

            }
            set
            {
                // 쿠키에 값을 넣지 않음 - 도미노가 아닐시 처리필요
                //HttpContext.Current.Session["company"] = value;

                // 쿠키처리
                HttpCookie cookie = new HttpCookie("SiteCompany_EP");
                //cookie.Domain = "iTaeYoung.com";
                cookie.Value = value;// cookie["company"] = value;
                HttpContext.Current.Response.Cookies.Add(cookie);
                if (HttpContext.Current.Session["UserInfo"] != null)
                {
                    (HttpContext.Current.Session["UserInfo"] as UserInfo).SiteCompanyCode = value;
                }
                
            }
        }
        #endregion

        #region UserID - 사용자ID를 가져온다
        /// <summary>
        /// 사용자ID를 가져온다
        /// </summary>
        public static string UserID
        {
            get
            {
                return UserInfo.LoginID;
            }
        } 
        #endregion

        #region EmpID - 사번을 가져온다
        /// <summary>
        /// 사번을 가져온다
        /// </summary>
        public static string EmpID
        {
            get
            {
                return UserInfo.EmpID;
            }
        } 
        #endregion

        #region DomAuthSessId - 도미노 세션ID
        public static string DomAuthSessId 
        {
            get
            {
                return HttpContext.Current.Session["DomAuthSessId"] == null ? string.Empty : HttpContext.Current.Session["DomAuthSessId"].ToString();
            }
            set
            {
                HttpContext.Current.Session["DomAuthSessId"] = value;
            }
        }
        #endregion

        public static string VendLoginID
        {
            get
            {
                if (HttpContext.Current.Request.Cookies["VEND_LOGINID"] != null)
                {
                    return HttpContext.Current.Request.Cookies["VEND_LOGINID"].Value;
                }
                else
                {
                    return string.Empty;
                }
            }
            set
            {
                // 쿠키처리
                HttpCookie cookie = new HttpCookie("VEND_LOGINID");
                //cookie.Domain = "iTaeYoung.com";
                cookie.Value = value;// cookie["company"] = value;
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
        }

        #region UserLogin - Session Login
        /// <summary>
        /// Session Login (Create UserInfo)
        /// </summary>
        /// <param name="emp_id"></param>
        /// <param name="login_id"></param>
        /// <param name="user_name"></param>
        /// <param name="dept_code"></param>
        /// <param name="dept_name"></param>
        /// <param name="rank_code"></param>
        /// <param name="rank_name"></param>
        /// <param name="duty_code"></param>
        /// <param name="duty_name"></param>
        /// <param name="email"></param>
        /// <param name="cell_phone"></param>
        /// <param name="internal_phone"></param>
        /// <param name="culture"></param>
        /// <param name="teamchiefyn"></param>
        /// <param name="companycode"></param>
        /// <param name="companyname"></param>
        /// <param name="signid"></param>
        /// <param name="jobcode"></param>
        /// <param name="jobname"></param>
        /// <param name="locationcode"></param>
        /// <param name="isVender"></param>
        /// <param name="kostl"></param>        
        public static void UserLogin(string emp_id, string login_id, string user_name, string dept_code, string dept_name, string rank_code, string rank_name, string duty_code, string duty_name, string email, string cell_phone, string internal_phone, string culture, string teamchiefyn, string companycode, string companyname, string signid, string jobcode, string jobname, string locationcode, bool isVender, string kostl, string _SiteCompanyCode)
        {
            UserInfo userInfo = new UserInfo();

            userInfo.EmpID = emp_id;
            if (isVender && !string.IsNullOrEmpty(VendLoginID))
            {
                userInfo.LoginID = VendLoginID;
            }
            else
            {
                userInfo.LoginID = login_id;
            }
            userInfo.UserName = user_name;
            userInfo.DeptCode = dept_code;
            userInfo.DeptName = dept_name;
            userInfo.RankCode = rank_code;
            userInfo.RankName = rank_name;
            userInfo.DutyCode = duty_code;
            userInfo.DutyName = duty_name;
            userInfo.Email = email;
            userInfo.CellPhone = cell_phone;
            userInfo.InternalPhone = internal_phone;
            userInfo.Culture = culture;
            userInfo.TeamChiefYN = teamchiefyn;
            userInfo.CompanyCode = companycode;
            userInfo.CompanyName = companyname;
            userInfo.SignID = signid;
            userInfo.JobCode = jobcode;
            //부서명이 있으면 직원 로그인으로 본다
            if(dept_code != "")
            {
                userInfo.JobName = dept_name;    //부서명
            }
            else
            {
                userInfo.JobName = jobname;    //담당자명
            }            
            userInfo.LocationCode = locationcode;

            userInfo.ClientCultureName = ClientCultureName;// System.Threading.Thread.CurrentThread.CurrentCulture.ToString().Split('-')[0].ToLower();
            userInfo.KOSTL = kostl;

            //switch (userInfo.ClientCultureName.ToUpper())
            //{
            //	case "KO":
            //		userInfo.LangCodeSAP = "3";
            //		break;
            //	case "EN":
            //		userInfo.LangCodeSAP = "E";
            //		break;
            //	default:
            //		userInfo.LangCodeSAP = "1";
            //		break;
            //}

            // client number
            //userInfo.Mandt = FxConfigManager.GetString("Mandt");

            // vend
            userInfo.IsVend = isVender;

            userInfo.SiteCompanyCode = string.IsNullOrEmpty(SiteCompanyCode)?_SiteCompanyCode:SiteCompanyCode;//SiteCompanyCode;

            
            Document.UserInfo = userInfo;
        } 
        #endregion


    }
}
