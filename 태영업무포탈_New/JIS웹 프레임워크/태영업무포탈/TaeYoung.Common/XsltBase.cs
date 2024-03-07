using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using TaeYoung.Biz.Common;

namespace TaeYoung.Common
{
    /// <summary>
    /// Xslt BasePage Class
    /// </summary>
    public class XsltBase : System.Web.UI.Page
    {
        #region ProgramID - 현재 프로그램의 프로그램 ID를 가져오거나 설정한다.
        /// <summary>
        /// 현재 프로그램의 프로그램 ID를 가져오거나 설정한다.
        /// </summary>
        public string ProgramID { get; set; }
        #endregion

        #region MenuID - MenuID - 현재 프로그램의 메뉴 ID를 가져오거나 설정한다.
        /// <summary>
        /// MenuID - 현재 프로그램의 메뉴 ID를 가져오거나 설정한다.
        /// </summary>
        public string MenuID { get; set; }
        #endregion

        #region XsltBase - Ctor
        /// <summary>
        /// Ctor
        /// </summary>
        public XsltBase()
        {
            // 다국어 처리를 위한 언어코드 리스트를 초기화한다.
            LangCodeList = new List<string>();
        }
        #endregion

        #region LangCodeList - 언어코드 리스트
        /// <summary>
        /// 언어코드 리스트
        /// </summary>
        public List<string> LangCodeList { get; set; }
        #endregion

        #region LangCodeData - 언어 코드 데이터
        /// <summary>
        /// 언어 코드 데이터
        /// </summary>
        public DataTable LangCodeData { get; set; }
        #endregion

        #region OnLoad - 페이지를 로드한다.
        /// <summary>
        /// 페이지를 로드한다.
        /// </summary>
        /// <param name="e"></param>
        protected override void OnLoad(EventArgs e)
        {
            string _culture = string.IsNullOrEmpty(Request.QueryString["_culture"]) ? TaeYoung.Biz.Document.ClientCultureName : HttpUtility.UrlDecode(Request.QueryString["_culture"]);

            // Xslt 는 강제로 관리함
            this.ProgramID = "Xslt";

            // 다국어 변환을 위한 언어코드 로드
            this.OnLangInit(e);

            // 컨트롤 데이터 조회하여 다국어 변환 부분을 로드
            foreach (System.Web.UI.Control c in GetAllControls(this.Page))
            {
                if (c.GetType().ToString() == "JINI.Control.WebControl.Text")
                {
                    LangCodeList.Add(((JINI.Control.WebControl.Text)c).LangCode);
                }
                //else if (c.GetType().ToString() == "JINI.Approval.Base.FormControls.Button")
                //{
                //    LangCodeList.Add(((JINI.Approval.Base.FormControls.Button)c).LangCode);
                //}
            }


            string langList = string.Empty;

            // 컨트롤 다국어 처리 
            foreach (string lang in LangCodeList)
            {
                langList += "'" + lang + "',";
            }

            langList = langList.TrimEnd(',');

            if (!string.IsNullOrEmpty(langList))
            {

                // 다국어 문자열로 데이터 조회
                using (LangBiz biz = new LangBiz())
                {
                    DataSet ds = biz.GetLangCode(this.ProgramID, langList, _culture);

                    LangCodeData = ds.Tables[0];
                }

                // 컨트롤에 처리된 다국어를 바인딩
                // 컨트롤 데이터 조회하여 다국어 변환 부분을 로드
                // 데이터가 없을시 Description 을 텍스트로 변환함
                foreach (System.Web.UI.Control c in GetAllControls(this.Page))
                {
                    if (c.GetType().ToString() == "JINI.Control.WebControl.Text")
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
                    //else if (c.GetType().ToString() == "JINI.Approval.Base.FormControls.Button")
                    //{
                    //    string str = GetLangCode(((JINI.Approval.Base.FormControls.Button)c).LangCode);
                    //    if (str != string.Empty)
                    //    {
                    //        ((JINI.Approval.Base.FormControls.Button)c).Text = str;
                    //    }
                    //    else if (!string.IsNullOrWhiteSpace(((JINI.Approval.Base.FormControls.Button)c).Description))
                    //    {
                    //        ((JINI.Approval.Base.FormControls.Button)c).Text = ((JINI.Approval.Base.FormControls.Button)c).Description;
                    //    }
                    //}
                }
            }

            base.OnLoad(e);
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

        #region GetAllControls - 해당 컨트롤의 하위 컨트롤을 반환
        /// <summary>
        /// 해당 컨트롤의 하위 컨트롤을 반환
        /// </summary>
        /// <param name="control">해당 컨트롤</param>
        /// <returns>하위 컨트롤</returns>
        public static Control[] GetAllControls(Control control)
        {
            return GetAllControls(control, new List<Control>());
        }

        /// <summary>
        /// 해당 컨트롤의 하위 컨트롤을 반환
        /// </summary>
        /// <param name="control">해당 컨트롤</param>
        /// <param name="excludeControls">제외할 컨트롤</param>
        /// <returns>하위 컨트롤</returns>
        public static Control[] GetAllControls(Control control, params Control[] excludeControls)
        {
            List<Control> listExcludeControls = new List<Control>(excludeControls);
            return GetAllControls(control, listExcludeControls);
        }

        /// <summary>
        /// 해당 컨트롤의 하위 컨트롤을 반환
        /// </summary>
        /// <param name="control">해당 컨트롤</param>
        /// <param name="excludeControls">제외할 컨트롤</param>
        /// <returns>하위 컨트롤</returns>
        private static Control[] GetAllControls(Control control, List<Control> excludeControls)
        {
            List<Control> rtnValue = new List<Control>();

            foreach (Control tmpChild in control.Controls)
            {
                if (excludeControls.Contains(tmpChild))
                {
                    continue;
                }

                rtnValue.Add(tmpChild);
                rtnValue.AddRange(GetAllControls(tmpChild, excludeControls));
            }

            return rtnValue.ToArray();
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
    }
}
