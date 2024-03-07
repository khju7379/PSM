
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TaeYoung.Portal
{
    public partial class SitePostUrl : System.Web.UI.Page
    {
        public static string unescape(string code)
        {
            var str = Regex.Replace(code, @"\+", "\x20");
            str = Regex.Replace(str, @"%([a-fA-F0-9][a-fA-F0-9])", new MatchEvaluator((mach) => {
                var _tmp = mach.Groups[0].Value;
                var _hexC = mach.Groups[1].Value;
                var _hexV = int.Parse(_hexC, System.Globalization.NumberStyles.HexNumber);
                return ((char)_hexV).ToString();
            }));

            return str;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //"post 전달 action=""http://eis.taeyoung.co.kr/""
            //ACTION = ""GROUPWARE""
            //SABUN = ""0311 - M""
            //ID = ""sgkim"""   http://eis.taeyoung.co.kr   http://eis.taeyoung.co.kr/

            //http://hmi.taeyoung.co.kr/default.htm
            //공정안전관리   "post 전달 action=""http://psm.taeyoung.co.kr/login.aspx""
            //ACTION = ""GROUPWARE""
            //SABUN = ""0311 - M""
            //ID = ""sgkim"""   

            //string url = "http://"+Request.QueryString["url"]; // 대상 URL
            string url = Request.QueryString["url"]; // 대상 URL

            if (!string.IsNullOrEmpty(url))
            {
                frm.Action = url; // 전송 대상 경로

                //http://tgw.taeyoung.co.kr/Resources/Framework/SiteOpen.aspx?url=eis.taeyoung.co.kr&ACTION=GROUPWARE&SABUN=0311-M&ID=sgkim

                // propertie가 동일하여 강제로 지정 
                // ACTION
                TextBox ACTION = new TextBox();
                ACTION.ID = "ACTION";
                ACTION.Text = Request.QueryString["ACTION"];
                frm_Control.Controls.Add(ACTION);
                // SABUN
                TextBox SABUN = new TextBox();
                SABUN.ID = "SABUN";
                SABUN.Text = Request.QueryString["SABUN"];
                //SABUN.Text = Document.UserInfo.EmpID;
                frm_Control.Controls.Add(SABUN);
                // ID
                //TextBox ID = new TextBox();
                //ID.ID = "ID";
                //ID.Text = Request.QueryString["ID"];
                ////ID.Text = Document.UserInfo.LoginID;
                //frm_Control.Controls.Add(ID);

                // ID
                TextBox ID = new TextBox();
                ID.ID = "ID";
                ID.Text = Request.QueryString["ID"];
                //ID.Text = Document.UserInfo.LoginID;
                frm_Control.Controls.Add(ID);

                //LINKURL
                TextBox LINKURL = new TextBox();
                LINKURL.ID = "LINKURL";
                LINKURL.Text = Request.QueryString["LINKURL"];
                //ID.Text = Document.UserInfo.LoginID;
                frm_Control.Controls.Add(LINKURL);

                TextBox param1 = new TextBox();
                param1.ID = "param1";
                param1.Text = Request.QueryString["param1"];
                //ID.Text = Document.UserInfo.LoginID;
                frm_Control.Controls.Add(param1);
            }
        }
    }
}