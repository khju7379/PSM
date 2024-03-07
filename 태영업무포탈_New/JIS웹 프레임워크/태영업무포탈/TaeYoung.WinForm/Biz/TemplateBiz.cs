using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using JINI.Base;
using JINI.Data.Transactions;
using JINI.Data;

namespace TaeYoung.WinForm.Biz
{
    public class TemplateBiz : BizBase
    {
        //[Transaction(TransactionOption.Disabled)]
        public DataSet GetTest(Hashtable ht)
        {

            DataSet ds = new DataSet();

            DataTable dt = new DataTable();

            dt.Columns.Add("TEST");

            DataRow dr = dt.NewRow();

            dr["TEST"] = ht["TEST"];

            dt.Rows.Add(dr);

            ds.Tables.Add(dt);

            return ds;
        }

        #region GetMenuDataTree - 메뉴 트리 조회
        /// <summary>
        /// 메뉴 트리 조회
        /// </summary>
        //[Transaction(TransactionOption.Required)]
        public DataSet GetMenuDataTree()
        {
            using (DB2Connecter dac = new DB2Connecter("DB2"))
            {
                return dac.ExcuteDataSet("CMN_MENU_TREE_GET");
            }
        }
        #endregion

    }
}
