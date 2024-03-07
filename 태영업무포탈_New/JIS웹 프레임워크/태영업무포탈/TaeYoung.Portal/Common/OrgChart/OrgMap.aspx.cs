using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Data;
using JINI.Base;
using TaeYoung.Common;
using TaeYoung.Biz;

namespace TaeYoung.Portal.Common.OrgChart
{
    public partial class OrgMap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                string strSection = Request.Params["section"];
                //default:APP 
                if (string.IsNullOrEmpty(strSection)) strSection = "APP";
                strSection = strSection.ToUpper();

                switch (strSection)
                {
                    case "OCS":
                        orgmapOcs();
                        break;

                    case "MAIL":
                        orgmapMail();
                        break;

                    case "APP":
                    default:
                        orgmapApp();
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
        }


        #region GetLangCode - 현재 페이지에 적용되고 있는 다국어 코드를 가져온다.
        /// <summary>
        /// 현재 페이지에 적용되고 있는 다국어 코드를 가져온다.
        /// </summary>
        /// <returns></returns>
        public string GetLangCode()
        {
            return Document.ClientCultureName.ToLower();
            //string langCode = "ko";
            //switch (Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName)
            //{
            //    case "en":
            //    case "en-US":
            //        langCode = "en";
            //        break;
            //    case "zh":
            //    case "zh-CN":
            //        langCode = "zh";
            //        break;
            //}
            //return langCode;
        }
        #endregion

        /// <summary>
        /// Application에서 불려지는 조직도
        /// </summary>
        protected void orgmapApp()
        {
            // Include js
            string strJsfile = "orgmap.app";
            if (!this.Page.ClientScript.IsClientScriptIncludeRegistered(strJsfile))
            {
                this.Page.ClientScript.RegisterClientScriptInclude(strJsfile, ResolveUrl("common/orgmap.app.js"));
            }
            this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "orgmap", "Ext.onReady( function() { new GW.OrgMap.Common.App.Form(); } );", true);
        }

        /// <summary>
        /// OCS 메신저에서 불려지는 조직도
        /// </summary>
        protected void orgmapOcs()
        {
            // Include js
            string strJsfile = "orgmap.ocs";
            if (!this.Page.ClientScript.IsClientScriptIncludeRegistered(strJsfile))
            {
                this.Page.ClientScript.RegisterClientScriptInclude(strJsfile, ResolveUrl("common/orgmap.ocs.js"));
            }
            this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "orgmap", "Ext.onReady( function() { new GW.OrgMap.Common.Ocs(); } );", true);
        }

        /// <summary>
        /// 아웃룩(addin)이나 OWA 에서 불려지는 조직도
        /// </summary>
        protected void orgmapMail()
        {
            // Include js
            string strJsfile = "orgmap.mail";
            if (!this.Page.ClientScript.IsClientScriptIncludeRegistered(strJsfile))
            {
                this.Page.ClientScript.RegisterClientScriptInclude(strJsfile, ResolveUrl("common/orgmap.mail.js"));
            }

            string strScript = string.Empty;
            string strApp = Request.Params["app"];
            string strFrom = Request.Params["from"];
            string strOverlap = Request.Params["overlap"];

            if (string.IsNullOrEmpty(strApp))
            {
                if (string.IsNullOrEmpty(strFrom))
                {
                    // OWA
                    if (string.IsNullOrEmpty(strOverlap))
                        strScript = "Ext.onReady( function() { new GW.OrgMap.Common.Mail(); } );";
                    else
                        strScript = "Ext.onReady( function() { new GW.OrgMap.Common.Mail('owa', '" + strOverlap + "', 'Mail'); } );";
                }
                else if (strFrom.Equals("outlook"))
                {
                    // outlook addin
                    // outlookItemType 
                    string outlookItemType = string.IsNullOrEmpty(Request.Params["outlookItemType"]) ? "Mail" : Request.Params["outlookItemType"];
                    //strScript = "Ext.onReady( function() { new GW.OrgMap.Common.Mail('outlook'); } );";

                    if (string.IsNullOrEmpty(strOverlap))
                        strScript = "Ext.onReady( function() { new GW.OrgMap.Common.Mail('outlook', '" + outlookItemType + "'); } );";
                    else
                        strScript = "Ext.onReady( function() { new GW.OrgMap.Common.Mail('outlook', '" + strOverlap + "', '" + outlookItemType + "'); } );";
                }
            }
            else if (strApp.Equals("CustomMailGroup"))
            {
                if (string.IsNullOrEmpty(strFrom))
                {
                    strScript = "Ext.onReady( function() { new GW.OrgMap.Common.CustomMailGroup(); } );";
                }
                else if (strFrom.Equals("outlook"))
                {
                    strScript = "Ext.onReady( function() { new GW.OrgMap.Common.CustomMailGroup('outlook'); } );";
                }
            }
            else
            {
                // reserved, do nothing~
                strScript = "Ext.onReady( function() { alert('메일 조직도 Parameter Error.'); } );";
            }

            this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "orgmap", strScript, true);
        }
    }
}