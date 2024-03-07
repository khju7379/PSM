using System;
using TaeYoung.Common;
using Temp.Biz.Template;
using System.Collections;
using System.Data;

namespace Temp.WebTemplate.ControlSample
{
    public partial class Index : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        #region OnLangInit - 다국어 처리 데이터 정의
        /// <summary>
        /// 다국어 처리 데이터 정의
        /// </summary>
        /// <param name="e">arguments</param>
        protected override void OnLangInit(EventArgs e)
        {
            setInit();
        }
        #endregion

        #region setInit - 바인딩 세팅
        /// <summary>
        /// 바인딩 세팅
        /// </summary>
        public void setInit()
        {
            InitflpIDX1();
        }
        #endregion

        #region InitflpIDX1 - flpIDX1 세팅
        /// <summary>
        /// flpIDX1 세팅
        /// </summary>
        private void InitflpIDX1()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                //Hashtable ht = new Hashtable();
                //ht["PageSize"] = 3;
                //DataSet ds = biz.ListTemplate(ht);

                //flpIDX1.DataTextField = "TITLE";
                //flpIDX1.DataValueField = "IDX";
                //flpIDX1.SelectedValueField = "NO";
                //flpIDX1.SelectedValueData = "2560";
                //flpIDX1.DataSource = ds.Tables[0];
                //flpIDX1.DataBind();
            }
        }
        #endregion


    }
}