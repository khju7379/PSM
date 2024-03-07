using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JINI.Base;
using TaeYoung.Biz;

namespace TaeYoung.Portal.Common.OrgChart
{
    public partial class SetLineMain : PageBase
    {
        protected string LangCode
        {
            get
            {
                return Document.ClientCultureName;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string strForm = string.Empty;

            strForm = base.ConvertString(Request.QueryString["_form"]);

            if (string.IsNullOrEmpty(strForm))
            {
                this.Page.ClientScript.RegisterClientScriptInclude("Org", ResolveUrl("Common/SetLine.Org.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("Presence", ResolveUrl("Common/SetLine.Org.Presence.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("ApproverAgree", ResolveUrl("Common/SetLine.ApproverAgree.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("Charge", ResolveUrl("Common/SetLine.Charge.js"));
                //this.Page.ClientScript.RegisterClientScriptInclude("ChargeAgree", ResolveUrl("Common/SetLine.ChargeAgree.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("Acl", ResolveUrl("Common/SetLine.Acl.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("Receive", ResolveUrl("Common/SetLine.Receive.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("AppArchive", ResolveUrl("Common/SetLine.AppArchive.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("AclArchive", ResolveUrl("Common/SetLine.AclArchive.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("Main", ResolveUrl("Common/SetLine.Main.js"));

                //this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "SetLine.Org", "GW.Org = new GW.SetLine.Org();", true);
                //this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "SetLine.Org.Presence", "GW.NameControl = new GW.PresenceMgr();", true);
                //this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "SetLine.ApproverAgree", "GW.ApproverAgree = new GW.SetLine.ApproverAgree();", true);
                //this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "SetLine.Charge", "GW.Charge = new GW.SetLine.Charge();", true);
                //this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "SetLine.Acl", "GW.Acl = new GW.SetLine.Acl();", true);
                //this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "SetLine.Receive", "GW.Receive = new GW.SetLine.Receive();", true);
                //this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "SetLine", "Ext.onReady( function() { new GW.SetLine.Main(); } );\nvar i=1;", true);
                //this.Page.ClientScript.RegisterClientScriptBlock(GetType(), "functionLoad", "functionLoad();", true);
            }
            else
            {
                this.Page.ClientScript.RegisterClientScriptInclude("Org", ResolveUrl("Common/SetLine.Org.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("Presence", ResolveUrl("Common/SetLine.Org.Presence.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("AppArchive", ResolveUrl("Common/SetLine.AppArchiveWord.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("AclArchive", ResolveUrl("Common/SetLine.AclArchiveWord.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("ApproverAgree", ResolveUrl("Common/SetLine.ApproverAgree.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("Acl", ResolveUrl("Common/SetLine.Acl.js"));
                this.Page.ClientScript.RegisterClientScriptInclude("Main", ResolveUrl("Common/SetLine.Main.js"));
            }

        }
    }
}