//using System;
//using System.Data;
//using System.IO;
//using System.Net;
//using System.Text;
//using System.Xml;
//using JINI.Base.Configuration;
//using TaeYoung.Biz.Common;

//namespace TaeYoung.Common.Domino
//{
//    /// <summary>
//    /// 도미노 웹서비스 호출
//    /// </summary>
//    public class DominoSvc : IDisposable
//    {
//        public DominoSvc()
//        {
//            UserName = FxConfigManager.GetString("DominoUserName");
//            Password = FxConfigManager.GetString("DominoPassword");
//        }

//        /// <summary>
//        /// ID
//        /// </summary>
//        public string UserName { get; set; }
//        /// <summary>
//        /// 비밀번호
//        /// </summary>
//        public string Password { get; set; }

//        #region GetCurrentUser - 현재사용자정보 로드
//        /// <summary>
//        /// 현재사용자정보 로드
//        /// </summary>
//        /// <returns></returns>
//        public DataTable GetCurrentUser(string sessionID, string url)
//        {
//            try
//            {
//                using (LoggingBiz loggerbiz = new LoggingBiz())
//                {
//                    loggerbiz.AddLogging("DOM", "TEST", DateTime.Now, sessionID + "-" + url, "", "", Environment.MachineName);
//                }
//            }
//            catch
//            {
//            }

//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의

//                    //|<NewDataSet>|
//                    //ReturnXML & |<UserInfo>|
//                    //ReturnXML & |<USERID><![CDATA[|& eDoc.MShortName(0) &|]]></USERID>|
//                    //ReturnXML & |<NOTESID><![CDATA[|& UName.Canonical &|]]></NOTESID>|
//                    //ReturnXML & |<NAME><![CDATA[|&LDoc.LUserName(0)&|]]></NAME>|
//                    //ReturnXML & |<EMPNO><![CDATA[|&LDoc.LEmpNo(0)&|]]></EMPNO>|
//                    //ReturnXML & |<COMPANY><![CDATA[|&LDoc.LCompany(0)&|]]></COMPANY>|
//                    //ReturnXML & |<COMPANYCODE><![CDATA[|&LDoc.LCompanyCode(0)&|]]></COMPANYCODE>|
//                    //ReturnXML & |<COMPANYERPCODE><![CDATA[|&eDoc.MCompanyErpCode(0)&|]]></COMPANYERPCODE>|
//                    //ReturnXML & |<TOPDEPT><![CDATA[|&LDoc.LTopDept(0)&|]]></TOPDEPT>|
//                    //ReturnXML & |<TOPDEPTCODE><![CDATA[|&LDoc.LTopDeptCode(0)&|]]></TOPDEPTCODE>|
//                    //ReturnXML & |<DEPT><![CDATA[|&LDoc.LDept(0)&|]]></DEPT>|
//                    //ReturnXML & |<DEPTCODE><![CDATA[|&LDoc.LDeptCode(0)&|]]></DEPTCODE>|
//                    //ReturnXML & |<GRADE><![CDATA[|&LDoc.LGrade(0)&|]]></GRADE>|
//                    //ReturnXML & |<GRADECODE><![CDATA[|&LDoc.LGradeCode(0)&|]]></GRADECODE>|
//                    //ReturnXML & |<LEADER><![CDATA[|&LDoc.LLeader(0)&|]]></LEADER>|
//                    //ReturnXML & |<LEADERCODE><![CDATA[|&LDoc.LLeaderCode(0)&|]]></LEADERCODE>|
//                    //ReturnXML & |<USECOMPANY><![CDATA[|& Join(eDoc.UseCompany, "; ")&|]]></USECOMPANY>|
//                    //ReturnXML & |</UserInfo>|
//                    //ReturnXML & |</NewDataSet>|

//                    string[] columns = { "USERID", "NOTESID", "NAME", "EMPNO", "COMPANY", "COMPANYCODE", "COMPANYERPCODE", "TOPDEPT", "TOPDEPTCODE", "DEPT", "DEPTCODE", "GRADE", "GRADECODE", "LEADER", "LEADERCODE", "USECOMPANY" };
//                    // Perform Webservice call       

//                    //dt = ConvertToXML(svc.GETCURRENTUSERINFO(sessionID), columns);
//                    dt = ConvertToXML(svc.GETCURRENTUSERINFONEW(sessionID, url), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GetCompany - 회사코드
//        /// <summary>
//        /// 회사코드
//        /// </summary>
//        /// <returns></returns>
//        public DataTable GetCompany()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "COMPANYCODE", "DISPLAYORDER", "DOMAINNAME" };
//                    // Perform Webservice call       
//                    dt = ConvertToXML(svc.UPDATECOMCODE(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GetCompanyLang - 회사명
//        /// <summary>
//        /// 회사명
//        /// </summary>
//        /// <returns></returns>
//        public DataTable GetCompanyLang()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "COMPANYCODE", "LANGUAGECODE", "COMPANY", "ABBCOMPANY" };
//                    // Perform Webservice call       
//                    dt = ConvertToXML(svc.UPDATECOMCODENAME(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GetDept - 부서코드
//        /// <summary>
//        /// 부서코드
//        /// </summary>
//        /// <returns></returns>
//        public DataTable GetDept()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "COMPANYCODE", "DEPTCODE", "DEPTORDER", "DEPTLEVEL"
//                                       , "PARENTDEPTCODE", "CREATEDDT", "DEPTEMAIL", "DISPLAYNAME"
//                                       , "DISPLAYYN", "LOCATION", "DPARTNER", "IFYN"
//                                       , "REGID", "REGDT", "UPDID", "UPDDT" };
//                    // Perform Webservice call       
//                    dt = ConvertToXML(svc.UPDATEDEPTCODE(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GetDeptLang - 부서코드명
//        /// <summary>
//        /// 부서코드명
//        /// </summary>
//        /// <returns></returns>
//        public DataTable GetDeptLang()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "COMPANYCODE", "DEPTCODE", "LANGCODE", "DEPTNAME" };
//                    // Perform Webservice call       
//                    dt = ConvertToXML(svc.UPDATEDEPTCODENAME(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GetDuty - 직책코드
//        /// <summary>
//        /// 직책코드
//        /// </summary>
//        /// <returns></returns>
//        public DataTable GetDuty()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "COMPANYCODE", "DUTYCODE", "LANGCODE", "DUTYNAME", "TEAMCHIEFYN", "SORTNO" };
//                    // Perform Webservice call       
//                    dt = ConvertToXML(svc.UPDATELEADERCODE(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        //#region GetGroup - 그룹코드
//        ///// <summary>
//        ///// 그룹코드
//        ///// </summary>
//        ///// <returns></returns>
//        //public DataTable GetGroup()
//        //{
//        //    // 웹서비스
//        //    DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//        //    // 리턴 데이터 테이블
//        //    DataTable dt = new DataTable();

//        //    Exception ex = new Exception("");

//        //    CookieContainer cookies = new CookieContainer();
//        //    // Prepare HTTP request
//        //    HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//        //    request.Method = "POST";
//        //    request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//        //    request.CookieContainer = cookies;
//        //    // Prepare POST body
//        //    string post = "Username=" + UserName + "&Password=" + Password;
//        //    byte[] bytes = Encoding.ASCII.GetBytes(post);
//        //    // Write data to request
//        //    request.ContentLength = bytes.Length;
//        //    Stream streamOut = request.GetRequestStream();
//        //    streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//        //    // Get response
//        //    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//        //    try
//        //    {
//        //        // Check if we are authenticated properly
//        //        if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//        //        {
//        //            // Set up authentication cookie    
//        //            svc.CookieContainer = cookies;
//        //            // 생성할 테이블의 컬럼 정의
//        //            string[] columns = { "GRPID", "SHRRNG", "USEYN", "GRPTYPE", "GRPEMAIL", "GRPEXT", "REGID", "REGDT", "UPDID", "UPDDT" };
//        //            // Perform Webservice call       
//        //            dt = ConvertToXML(svc.UPDATEGROUPINFO(), columns);
//        //        }
//        //    }
//        //    catch (Exception _ex)
//        //    {
//        //        ex = _ex;
//        //    }
//        //    finally
//        //    {
//        //        response.Close();
//        //        request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//        //        request.KeepAlive = false;
//        //        request.Method = "POST";
//        //        request.AllowAutoRedirect = false;
//        //        request.ContentType = "application/x-www-form-urlencoded";
//        //        request.CookieContainer = cookies;
//        //        response = (HttpWebResponse)request.GetResponse();
//        //        response.Close();

//        //        svc.Dispose();

//        //        if (ex.Message != "")
//        //        {
//        //            throw ex;
//        //        }
//        //    }

//        //    return dt;
//        //}
//        //#endregion

//        //#region GetGroupLang - 그룹명
//        ///// <summary>
//        ///// 그룹명
//        ///// </summary>
//        ///// <returns></returns>
//        //public DataTable GetGroupLang()
//        //{
//        //    // 웹서비스
//        //    DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//        //    // 리턴 데이터 테이블
//        //    DataTable dt = new DataTable();

//        //    Exception ex = new Exception("");

//        //    CookieContainer cookies = new CookieContainer();
//        //    // Prepare HTTP request
//        //    HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//        //    request.Method = "POST";
//        //    request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//        //    request.CookieContainer = cookies;
//        //    // Prepare POST body
//        //    string post = "Username=" + UserName + "&Password=" + Password;
//        //    byte[] bytes = Encoding.ASCII.GetBytes(post);
//        //    // Write data to request
//        //    request.ContentLength = bytes.Length;
//        //    Stream streamOut = request.GetRequestStream();
//        //    streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//        //    // Get response
//        //    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//        //    try
//        //    {
//        //        // Check if we are authenticated properly
//        //        if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//        //        {
//        //            // Set up authentication cookie    
//        //            svc.CookieContainer = cookies;
//        //            // 생성할 테이블의 컬럼 정의
//        //            string[] columns = { "GRPID", "LANGCODE", "GRPNAME" };
//        //            // Perform Webservice call       
//        //            dt = ConvertToXML(svc.UPDATEGROUPNAME(), columns);
//        //        }
//        //    }
//        //    catch (Exception _ex)
//        //    {
//        //        ex = _ex;
//        //    }
//        //    finally
//        //    {
//        //        response.Close();
//        //        request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//        //        request.KeepAlive = false;
//        //        request.Method = "POST";
//        //        request.AllowAutoRedirect = false;
//        //        request.ContentType = "application/x-www-form-urlencoded";
//        //        request.CookieContainer = cookies;
//        //        response = (HttpWebResponse)request.GetResponse();
//        //        response.Close();

//        //        svc.Dispose();

//        //        if (ex.Message != "")
//        //        {
//        //            throw ex;
//        //        }
//        //    }

//        //    return dt;
//        //}
//        //#endregion

//        //#region GetGroupMember - 그룹맴버
//        ///// <summary>
//        ///// 그룹맴버
//        ///// </summary>
//        ///// <returns></returns>
//        //public DataTable GetGroupMember()
//        //{
//        //    // 웹서비스
//        //    DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//        //    // 리턴 데이터 테이블
//        //    DataTable dt = new DataTable();

//        //    Exception ex = new Exception("");

//        //    CookieContainer cookies = new CookieContainer();
//        //    // Prepare HTTP request
//        //    HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//        //    request.Method = "POST";
//        //    request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//        //    request.CookieContainer = cookies;
//        //    // Prepare POST body
//        //    string post = "Username=" + UserName + "&Password=" + Password;
//        //    byte[] bytes = Encoding.ASCII.GetBytes(post);
//        //    // Write data to request
//        //    request.ContentLength = bytes.Length;
//        //    Stream streamOut = request.GetRequestStream();
//        //    streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//        //    // Get response
//        //    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//        //    try
//        //    {
//        //        // Check if we are authenticated properly
//        //        if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//        //        {
//        //            // Set up authentication cookie    
//        //            svc.CookieContainer = cookies;
//        //            // 생성할 테이블의 컬럼 정의
//        //            string[] columns = { "GRPID", "USRID", "COMPANYCODE", "USRTYPE" };
//        //            // Perform Webservice call       
//        //            dt = ConvertToXML(svc.UPDATEGROUPMEMBER(), columns);
//        //        }
//        //    }
//        //    catch (Exception _ex)
//        //    {
//        //        ex = _ex;
//        //    }
//        //    finally
//        //    {
//        //        response.Close();
//        //        request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//        //        request.KeepAlive = false;
//        //        request.Method = "POST";
//        //        request.AllowAutoRedirect = false;
//        //        request.ContentType = "application/x-www-form-urlencoded";
//        //        request.CookieContainer = cookies;
//        //        response = (HttpWebResponse)request.GetResponse();
//        //        response.Close();

//        //        svc.Dispose();

//        //        if (ex.Message != "")
//        //        {
//        //            throw ex;
//        //        }
//        //    }

//        //    return dt;
//        //}
//        //#endregion

//        #region GetRank - 직위코드
//        /// <summary>
//        /// 직위코드
//        /// </summary>
//        /// <returns></returns>
//        public DataTable GetRank()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = System.Text.Encoding.UTF8.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "COMPANYCODE", "RANKCODE", "LANGCODE", "RANKNAME", "TEAMCHIEFYN", "SORTNO" };
//                    // Perform Webservice call       
//                    dt = ConvertToXML(svc.UPDATEGRADECODE(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GetUser - 사용자정보
//        /// <summary>
//        /// 사용자정보
//        /// </summary>
//        /// <returns></returns>
//        public DataTable GetUser()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "COMPANYCODE", "EMPID", "LOGINID", "ALIAS", "EMAIL", "MAINDEPTCODE"
//                                       , "CREATEDDT", "DISPLAYNAME", "DISPLAYYN", "DUTYCODE"
//                                       , "JOBCODE", "RANKCODE", "CELLPHONE", "FAXNUMBER"
//                                       , "EXTENSIONNUMBER", "LOCATIONCODE", "TEAMCHIEFYN", "DATEOFBIRTH"
//                                       , "IFYN", "MESSANGERIFYN", "PHONE1", "PHONE2"
//                                       , "CULTURE", "REGID", "REGDT", "UPDID", "UPDDT", "JOBDESC" };
//                    // Perform Webservice call       
//                    dt = ConvertToXML(svc.UPDATEUSERINFO(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GetUserLang - 사용자명
//        /// <summary>
//        /// 사용자명
//        /// </summary>
//        /// <returns></returns>
//        public DataTable GetUserLang()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "COMPANYCODE", "EMPID", "LANGCODE", "USERLNAME", "USERFNAME" };
//                    // Perform Webservice call       
//                    dt = ConvertToXML(svc.UPDATEUSERNAME(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GetAdditionalJob - 겸직정보
//        /// <summary>
//        /// 겸직정보
//        /// </summary>
//        /// <returns></returns>
//        public DataTable GetAdditionalJob()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "COMPANYCODE", "EMPID", "SEQNO", "LOGINID", "DEPTCODE", "JOBCODE", "DUTYCODE", "RANKCODE", "TEAMCHIEFYN", "JOBDESC" };
//                    // Perform Webservice call       
//                    dt = ConvertToXML(svc.UPDATEADDITIONALJOB(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("MessengerDominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region 계측기

//        #region GetGAUGE_FMMAKER - 계측기(부품) Marker
//        public DataTable GetGAUGE_FMMAKER()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "Code", "Maker" };
//                    // Perform Webservice call
//                    dt = ConvertToXML(svc.GAUGE_FMMAKER(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GAUGE_FMBULTEAM - 계측기(부품) 불출 팀
//        public DataTable GAUGE_FMBULTEAM()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "Team" };
//                    // Perform Webservice call
//                    dt = ConvertToXML(svc.GAUGE_FMBULTEAM(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GAUGE_FMBULLINE - 계측기(부품) 불출 라인
//        public DataTable GAUGE_FMBULLINE()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "LineCode", "LineName" };
//                    // Perform Webservice call
//                    dt = ConvertToXML(svc.GAUGE_FMBULLINE(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GAUGE_FMBULGONG - 계측기(부품) 불출 공정
//        public DataTable GAUGE_FMBULGONG()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "GongName" };
//                    // Perform Webservice call
//                    dt = ConvertToXML(svc.GAUGE_FMBULGONG(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GAUGE_FMGURE - 계측기(부품) 거래처
//        public DataTable GAUGE_FMGURE()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "Code1", "Code2", "DealCompanyName" };
//                    // Perform Webservice call
//                    dt = ConvertToXML(svc.GAUGE_FMGURE(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GetGauge_Fmgongmu - 계측기(부품) 공정 정보
//        public DataTable GetGauge_Fmgongmu()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "GongName" };
//                    // Perform Webservice call
//                    dt = ConvertToXML(svc.GAUGE_FMGONGMU(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region GAUGE_FMITEM - 계측기(부품) 아이템 정보
//        public DataTable GAUGE_FMITEM()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "ItemNo", "Category", "PumName", "GyuGyeok", "Juki", "Sogeup", "Eulji" };
//                    // Perform Webservice call
//                    dt = ConvertToXML(svc.GAUGE_FMITEM(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region FGMEASUR_FMMAKER - 계측기(FG) Marker
//        public DataTable FGMEASUR_FMMAKER()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "Code", "SangHO" };
//                    // Perform Webservice call
//                    dt = ConvertToXML(svc.FGMEASUR_FMMAKER(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region FGMEASUR_FMBULTEAM - 계측기(FG) 불출 팀
//        public DataTable FGMEASUR_FMBULTEAM()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "TeamName" };
//                    // Perform Webservice call
//                    dt = ConvertToXML(svc.FGMEASUR_FMBULTEAM(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region FGMEASUR_FMBULLINE - 계측기(FG) 불출 라인
//        public DataTable FGMEASUR_FMBULLINE()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "LineCode", "LineName" };
//                    // Perform Webservice call
//                    dt = ConvertToXML(svc.FGMEASUR_FMBULLINE(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

//        #region FGMEASUR_FMGONGMU - 계측기(FG) 장비공정
//        public DataTable FGMEASUR_FMGONGMU()
//        {
//            // 웹서비스
//            DominoWS.wsDominoAdminElement svc = new DominoWS.wsDominoAdminElement();
//            // 리턴 데이터 테이블
//            DataTable dt = new DataTable();

//            Exception ex = new Exception("");

//            CookieContainer cookies = new CookieContainer();
//            // Prepare HTTP request
//            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?login");
//            request.Method = "POST";
//            request.AllowAutoRedirect = false; request.ContentType = "application/x-www-form-urlencoded";
//            request.CookieContainer = cookies;
//            // Prepare POST body
//            string post = "Username=" + UserName + "&Password=" + Password;
//            byte[] bytes = Encoding.ASCII.GetBytes(post);
//            // Write data to request
//            request.ContentLength = bytes.Length;
//            Stream streamOut = request.GetRequestStream();
//            streamOut.Write(bytes, 0, bytes.Length); streamOut.Close();
//            // Get response
//            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
//            try
//            {
//                // Check if we are authenticated properly
//                if ((response.StatusCode == HttpStatusCode.Found) || (response.StatusCode == HttpStatusCode.Redirect) || (response.StatusCode == HttpStatusCode.Moved) || (response.StatusCode == HttpStatusCode.MovedPermanently))
//                {
//                    // Set up authentication cookie    
//                    svc.CookieContainer = cookies;
//                    // 생성할 테이블의 컬럼 정의
//                    string[] columns = { "LineCode", "LineName", "GongjungCode", "GongjungName" };
//                    // Perform Webservice call
//                    dt = ConvertToXML(svc.FGMEASUR_FMGONGMU(), columns);
//                }
//            }
//            catch (Exception _ex)
//            {
//                ex = _ex;
//            }
//            finally
//            {
//                response.Close();
//                request = (HttpWebRequest)HttpWebRequest.Create(FxConfigManager.GetString("DominoNamesURL") + "?logout");
//                request.KeepAlive = false;
//                request.Method = "POST";
//                request.AllowAutoRedirect = false;
//                request.ContentType = "application/x-www-form-urlencoded";
//                request.CookieContainer = cookies;
//                response = (HttpWebResponse)request.GetResponse();
//                response.Close();

//                svc.Dispose();

//                if (ex.Message != "")
//                {
//                    throw ex;
//                }
//            }

//            return dt;
//        }
//        #endregion

        

//        #endregion

//        #region DatabaseInjectionString - DB 인젝션 처리
//        /// <summary>
//        /// DB 인젝션 처리
//        /// </summary>
//        /// <param name="str"></param>
//        /// <returns></returns>
//        public string DatabaseInjectionString(string str)
//        {
//            StringBuilder sb = new StringBuilder(str);

//            sb = sb.Replace("'", "''");
//            sb = sb.Replace("\\", "");
//            sb = sb.Replace("--", "");
//            sb = sb.Replace(";", "");

//            return sb.ToString();
//        }
//        #endregion

//        #region ConvertToXML - XML 데이터를 DataTable로 변환한다.
//        /// <summary>
//        /// XML 데이터를 DataTable로 변환한다.
//        /// </summary>
//        /// <param name="xml"></param>
//        /// <param name="columns"></param>
//        /// <returns></returns>
//        private DataTable ConvertToXML(string xml, string[] columns)
//        {
//            DataTable dt = new DataTable();

//            xml = xml.Replace("&", "#1#");
//            xml = xml.Replace("'", "#2#");

//            MemoryStream ms = new MemoryStream(System.Text.Encoding.UTF8.GetBytes(xml));
//            // XML을 parse하기 위해 XmlDocument를 사용
//            XmlDocument xmlDoc = new XmlDocument();

//            // MemoryStream을 이용하여 XML문을 읽는다.
//            xmlDoc.Load(ms);

//            XmlElement root = xmlDoc.DocumentElement;

//            foreach (string column in columns)
//            {
//                dt.Columns.Add(column, typeof(string));
//            }

//            foreach (XmlNode node in root.ChildNodes)
//            {
//                DataRow dr = dt.NewRow();

//                for (int i = 0; i < columns.Length; i++)
//                {
//                    dr[columns[i]] = node.ChildNodes[i].InnerText.Replace("#1#","&").Replace("#2#","'");
//                }

//                //foreach (string column in columns)
//                //{
//                //    dr[column] = node[column].InnerText;
//                //}

//                dt.Rows.Add(dr);
//            }

//            ms.Close();
//            ms.Dispose();

//            return dt;
//        }
//        #endregion

//        #region Dispose - 자원해제
//        /// <summary>
//        /// 자원해제
//        /// </summary>
//        public void Dispose()
//        {
//            GC.SuppressFinalize(this);
//        }
//        #endregion
//    }
//}
