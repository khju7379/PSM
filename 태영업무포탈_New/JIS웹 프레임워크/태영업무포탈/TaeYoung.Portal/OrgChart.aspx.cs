using System;
using System.Data;
using JINI.Base;
using TaeYoung.Common;
using TaeYoung.Biz.Common;
using TaeYoung.Biz;
using System.Collections.Generic;
using System.Web.UI;

namespace TaeYoung.Portal
{
    /// <summary>
    /// 클래스 설명을 기술한다.
    /// </summary>
    public partial class OrgChart : BasePage
    {
        #region ORG_ACL - 인사기록카드 권한 여부
        public string ORG_ACL
        {
            get;
            set;
        }
        #endregion

        #region OnLangInit - 다국어 처리 데이터 정의
        /// <summary>
        /// 다국어 처리 데이터 정의
        /// </summary>
        /// <param name="e">arguments</param>
        protected override void OnLangInit(EventArgs e)
        {
        }
        #endregion

        #region Page_Load - 페이지 로드
        /// <summary>
        /// 페이지 로드
        /// </summary>
        /// <param name="sender">this</param>
        /// <param name="e">arguments</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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



                    }
                }

                this.ORG_ACL = this.UserGroup.Exists(s => s == "ORG_CARD") ? "Y" : "N";
            }
        }
        #endregion
    }
}