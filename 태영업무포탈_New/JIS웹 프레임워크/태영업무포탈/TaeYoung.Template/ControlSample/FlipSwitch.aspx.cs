using System;
using TaeYoung.Common;
using System.Data;
using System.Collections;
using Temp.Biz.Template;

namespace Temp.WebTemplate.ControlSample
{
    public partial class FlipSwitch : BasePage
    {
        public FlipSwitch()
        {
            this.PostbackYN = true;
        }

        #region Page_Load
        /// <summary>
        /// Page_Load
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        #endregion

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
            InitflpIDX2();
            InitflpIDX4();
            InitflpIDX5();
            InitflpIDX6();
            InitflpIDX7();
            InitflpIDX8();
            InitflpIDX9();
            InitflpIDX10();
            InitflpIDX11();
            InitflpIDX12();
            InitflpIDX13();
            InitflpIDX14();
        }
        #endregion

        #region InitflpIDX2 - flpIDX2 세팅
        /// <summary>
        /// flpIDX2 세팅
        /// </summary>
        private void InitflpIDX2()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX2.DataTextField = "TITLE";
                flpIDX2.DataValueField = "IDX";
                flpIDX2.SelectedValueField = "NO";
                flpIDX2.SelectedValueData = "2560";
                flpIDX2.DataSource = ds.Tables[0];
                flpIDX2.DataBind();
            }
        }
        #endregion

        #region InitflpIDX4 - flpIDX4 세팅
        /// <summary>
        /// flpIDX4 세팅
        /// </summary>
        private void InitflpIDX4()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX4.DataTextField = "TITLE";
                flpIDX4.DataValueField = "IDX";
                flpIDX4.SelectedValueField = "NO";
                flpIDX4.SelectedValueData = "2560";
                flpIDX4.DataSource = ds.Tables[0];
                flpIDX4.DataBind();
            }
        }
        #endregion

        #region InitflpIDX5 - flpIDX5 세팅
        /// <summary>
        /// flpIDX5 세팅
        /// </summary>
        private void InitflpIDX5()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX5.DataTextField = "TITLE";
                flpIDX5.DataValueField = "IDX";
                flpIDX5.SelectedValueField = "NO";
                flpIDX5.SelectedValueData = "2560";
                flpIDX5.DataSource = ds.Tables[0];
                flpIDX5.DataBind();
            }
        }
        #endregion

        #region InitflpIDX6 - flpIDX6 세팅
        /// <summary>
        /// flpIDX6 세팅
        /// </summary>
        private void InitflpIDX6()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX6.DataTextField = "TITLE";
                flpIDX6.DataValueField = "IDX";
                flpIDX6.SelectedValueField = "NO";
                flpIDX6.SelectedValueData = "2560";
                flpIDX6.DataSource = ds.Tables[0];
                flpIDX6.DataBind();
            }
        }
        #endregion

        #region InitflpIDX7 - flpIDX7 세팅
        /// <summary>
        /// flpIDX7 세팅
        /// </summary>
        private void InitflpIDX7()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX7.DataTextField = "TITLE";
                flpIDX7.DataValueField = "IDX";
                flpIDX7.SelectedValueField = "CREATENM";
                flpIDX7.SelectedValueData = "문광복";
                flpIDX7.DataSource = ds.Tables[0];
                flpIDX7.DataBind();
            }
        }
        #endregion

        #region InitflpIDX8 - flpIDX8 세팅
        /// <summary>
        /// flpIDX8 세팅
        /// </summary>
        private void InitflpIDX8()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX8.DataTextField = "IDX";
                flpIDX8.DataValueField = "IDX";
                flpIDX8.SelectedValueField = "IDX";
                flpIDX8.SelectedValueData = "2560";
                flpIDX8.DataSource = ds.Tables[0];
                flpIDX8.DataBind();
            }
        }
        #endregion

        #region InitflpIDX9 - flpIDX9 세팅
        /// <summary>
        /// flpIDX9 세팅
        /// </summary>
        private void InitflpIDX9()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX9.DataTextField = "IDX";
                flpIDX9.DataValueField = "IDX";
                flpIDX9.SelectedValueField = "IDX";
                flpIDX9.SelectedValueData = "2560";
                flpIDX9.DataSource = ds.Tables[0];
                flpIDX9.DataBind();
            }
        }
        #endregion

        #region InitflpIDX10 - flpIDX10 세팅
        /// <summary>
        /// flpIDX10 세팅
        /// </summary>
        private void InitflpIDX10()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX10.DataTextField = "TITLE";
                flpIDX10.DataValueField = "IDX";
                flpIDX10.SelectedValueField = "NO";
                flpIDX10.SelectedValueData = "2560";
                flpIDX10.DataSource = ds.Tables[0];
                flpIDX10.DataBind();
            }
        }
        #endregion

        #region InitflpIDX11 - flpIDX11 세팅
        /// <summary>
        /// flpIDX11 세팅
        /// </summary>
        private void InitflpIDX11()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX11.DataTextField = "TITLE";
                flpIDX11.DataValueField = "IDX";
                flpIDX11.SelectedValueField = "NO";
                flpIDX11.SelectedValueData = "2560";
                flpIDX11.DataSource = ds.Tables[0];
                flpIDX11.DataBind();
            }
        }
        #endregion

        #region InitflpIDX12 - flpIDX12 세팅
        /// <summary>
        /// flpIDX12 세팅
        /// </summary>
        private void InitflpIDX12()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX12.DataTextField = "TITLE";
                flpIDX12.DataValueField = "IDX";
                flpIDX12.SelectedValueField = "NO";
                flpIDX12.SelectedValueData = "2560";
                flpIDX12.DataSource = ds.Tables[0];
                flpIDX12.DataBind();
            }
        }
        #endregion

        #region InitflpIDX13 - flpIDX13 세팅
        /// <summary>
        /// flpIDX13 세팅
        /// </summary>
        private void InitflpIDX13()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX13.DataTextField = "IDX";
                flpIDX13.DataValueField = "IDX";
                flpIDX13.SelectedValueField = "IDX";
                flpIDX13.SelectedValueData = "2560";
                flpIDX13.DataSource = ds.Tables[0];
                flpIDX13.DataBind();
            }
        }
        #endregion

        #region InitflpIDX14 - flpIDX14 세팅
        /// <summary>
        /// flpIDX14 세팅
        /// </summary>
        private void InitflpIDX14()
        {
            using (TemplateBiz biz = new TemplateBiz())
            {
                Hashtable ht = new Hashtable();
                ht["PageSize"] = 6;
                DataSet ds = biz.ListTemplate(ht);

                flpIDX14.DataTextField = "IDX";
                flpIDX14.DataValueField = "IDX";
                flpIDX14.SelectedValueField = "IDX";
                flpIDX14.SelectedValueData = "2560";
                flpIDX14.DataSource = ds.Tables[0];
                flpIDX14.DataBind();
            }
        }
        #endregion

    }
}