using System;
using System.Data;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using Ext.Net.Utilities;
using TaeYoung.Common;
using JINI.Base;
using JINI.Data;
using TaeYoung.Biz.Common;
using TaeYoung.Biz;
using System.Collections;


namespace TaeYoung.Portal.PSM.POP
{
    public partial class SabunMultiChkPopup7 : BasePage
    {
        private string sSABUN;
        private string sDEPT;
        private string sSAUPBU;
        private string[] sChildDept = new string[2];

        public int _icount = 1;
        public int _inum = 1;

        // 결재자
        private string[] sKBSABUN = new string[6];
        private string[] sKBHANGL = new string[6];
        private string[] sCDDESC1 = new string[6];
        private string[] sJKCODE  = new string[6];

        #region Description : 페이지 로드
        public SabunMultiChkPopup7()
        {
            this.Popup = true;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!X.IsAjaxRequest)
            {
                this.hdnCallBack.Value = this.Request.QueryString["CallBack"];

                sSABUN = Document.UserInfo.EmpID;
                sDEPT = Document.UserInfo.DeptCode;

                if (sDEPT.ToString().Substring(0, 2) == "A1" || sDEPT.ToString().Substring(0, 2) == "T1" || sDEPT.ToString().Substring(0, 2) == "E1" || sDEPT.ToString() == "T40100" ||
                    sDEPT.ToString().Substring(0, 2) == "S1" || sDEPT.ToString().Substring(0, 2) == "A2")
                {
                    sSAUPBU = sDEPT.ToString().Substring(0, 2) + "0000";
                }

                if (sDEPT.ToString() == "T40000" || sDEPT.ToString() == "S40000" || sDEPT.ToString().Substring(0, 2) == "D1")
                {
                    sSAUPBU = sDEPT.ToString();
                }

                sChildDept[0] = sDEPT.ToString();
                sChildDept[1] = sDEPT.ToString();

                // 요청, 수신
                this.BindMenu();

                this.HdnSOAPPROVAL.Text = "";

                // 결재자 가져오기
                UP_GET_Approval();

                X.Js.Call("chk_ClientChange", "1");
            }
        }
        #endregion

        #region Description : 결재자 가져오기
        private void UP_GET_Approval()
        {
            string sRECEPSABUN = string.Empty;
            string sParam = string.Empty;
            string sEqual = string.Empty;
            int i = 0;
            int j = 0;
            int k = 0;
            int iCount = 0;
            int iData_Cnt = 0;


            this.HdnCnt1.Text = this.Request.QueryString["Data_Cnt1"].ToString();
            
            // 현재 요청 결재라인위치
            this.HdnSOCnt.Text = this.Request.QueryString["param7"].ToString();

            // 요청 완료 구분
            this.HdnSOSign.Text = this.Request.QueryString["SOSign"].ToString();

            this.HdnGubun.Text = "";

            #region Description : 요청 결재라인

            iData_Cnt = int.Parse(this.Request.QueryString["Data_Cnt1"].ToString());

            for (i = 0; i < iData_Cnt; i++)
            {
                // 사번
                sParam = "param" + Convert.ToString(i + 1);

                if (this.Request.QueryString[sParam].ToString() != "")
                {
                    iCount = i + 1;

                    sKBSABUN[i] = this.Request.QueryString[sParam].ToString();
                }
            }

            DataTable dt1 = new DataTable();

            dt1.Columns.Add("SEQ");
            dt1.Columns.Add("KBSABUN");
            dt1.Columns.Add("KBHANGL");
            dt1.Columns.Add("CDDESC1");
            dt1.Columns.Add("JKCODE");

            for (i = 0; i < iCount; i++)
            {
                if (this.Request.QueryString["SOSign"].ToString() != "Complete") // 요청결재가 완료가 안 되었을 경우
                {
                    if (i == int.Parse(Get_Numeric(this.HdnSOCnt.Text.Trim())))
                    {
                        if (sKBSABUN[int.Parse(Get_Numeric(this.HdnSOCnt.Text.Trim()))].ToString() != Document.UserInfo.EmpID)
                        {
                            using (TaeYoung.Biz.PSM.PSMBiz biz = new TaeYoung.Biz.PSM.PSMBiz())
                            {
                                DataSet ds = new DataSet();

                                Hashtable ht = new Hashtable();

                                ht["P_BUSEO1"] = "ALL";
                                ht["P_BUSEO2"] = "ALL";
                                ht["P_BUSEO3"] = "ALL";
                                ht["P_BUSEO4"] = "ALL";
                                ht["P_BUSEO5"] = "ALL";
                                ht["P_BUSEO6"] = "ALL";
                                ht["P_BUSEO7"] = "ALL";
                                ht["P_BUSEO8"] = "ALL";
                                ht["P_SABUN"] = Document.UserInfo.EmpID;

                                ds = biz.UP_ORG_GETDATA(ht);

                                if (ds.Tables[0].Rows.Count > 0)
                                {
                                    sKBHANGL[i] = ds.Tables[0].Rows[0]["NAME"].ToString();
                                    sCDDESC1[i] = ds.Tables[0].Rows[0]["JKDESC"].ToString();
                                    sJKCODE[i] = ds.Tables[0].Rows[0]["JCCD"].ToString();
                                }

                                // 현재 로그인 한 사람 사번
                                this.HdnSOAPPROVAL.Text = Document.UserInfo.EmpID;

                                dt1.Rows.Add((i + 1), Document.UserInfo.EmpID, sKBHANGL[i].ToString(), sCDDESC1[i].ToString(), sJKCODE[i].ToString());

                                sEqual = "Not";
                            }
                        }
                        else
                        {
                            UP_SET_Req_Information(i);
                        }
                    }
                    else
                    {
                        if (sEqual == "")
                        {
                            UP_SET_Req_Information(i);
                        }
                    }
                }
                else
                {
                    UP_SET_Req_Information(i);
                }

                if (sEqual == "")
                {
                    // 현재 로그인 한 사람 사번
                    this.HdnSOAPPROVAL.Text = Document.UserInfo.EmpID;

                    dt1.Rows.Add((i + 1), sKBSABUN[i].ToString(), sKBHANGL[i].ToString(), sCDDESC1[i].ToString(), sJKCODE[i].ToString());
                }
            }

            this.Store2.DataSource = dt1;
            this.Store2.DataBind();

            #endregion
        }
        #endregion

        #region Description : 요청 결재라인 직원 정보 가져오기
        private void UP_SET_Req_Information(int iArray)
        {
            string sParam = string.Empty;

            int iCount = 0;

            // 사번
            sParam = "param" + Convert.ToString(iArray + 1);

            if (this.Request.QueryString[sParam].ToString() != "")
            {
                iCount = iArray + 1;

                sKBSABUN[iArray] = this.Request.QueryString[sParam].ToString();
            }

            // 이름
            sParam = "param1" + Convert.ToString(iArray + 1);

            if (this.Request.QueryString[sParam].ToString() != "")
            {
                iCount = iArray + 1;

                sKBHANGL[iArray] = this.Request.QueryString[sParam].ToString();
            }

            // 직급
            sParam = "param2" + Convert.ToString(iArray + 1);

            if (this.Request.QueryString[sParam].ToString() != "")
            {
                iCount = iArray + 1;

                sJKCODE[iArray] = this.Request.QueryString[sParam].ToString();
            }

            // 직급명
            sParam = "param3" + Convert.ToString(iArray + 1);

            if (this.Request.QueryString[sParam].ToString() != "")
            {
                iCount = iArray + 1;

                sCDDESC1[iArray] = this.Request.QueryString[sParam].ToString();
            }
        }
        #endregion


        #region Description : 부서명 가져오기
        private void UP_SET_Buseo(int iArray)
        {
            //this.DbConnector.CommandClear();
            //this.DbConnector.Attach("PS47EHN024", "ALL", "ALL", "ALL", "ALL", "ALL", "ALL", "ALL", "ALL", sKBSABUN[iArray].ToString());
            //DataSet ds = this.DbConnector.ExecuteDataSet();

            //if (ds.Tables[0].Rows.Count > 0)
            //{
            //    sKBHANGL[iArray] = ds.Tables[0].Rows[0]["NAME"].ToString();
            //    sCDDESC1[iArray] = ds.Tables[0].Rows[0]["JKDESC"].ToString();
            //    sJKCODE[iArray]  = ds.Tables[0].Rows[0]["JCCD"].ToString();
            //}
        }
        #endregion

        /// <summary>
        /// 최초 메뉴 바인딩
        /// </summary>
        private void BindMenu()
        {
            NodeCollection menus = null;
            Node tmpFavorRoot = this.GetFavorMenu();
            TreePanel tmpTree;
            string nodeID = "";
            string ChildnodeID = "";
            string Final_ChildnodeID = "";
            string openMenuID = "";

            if (tmpFavorRoot != null && (tmpFavorRoot.Children.Count > 1 || (tmpFavorRoot.Children.Count == 1 && tmpFavorRoot.Children[0].Leaf == false)))
            {
                menus = new NodeCollection();
                menus.Add(tmpFavorRoot);
            }
            else
            {
                openMenuID = "PS4171Y980";

                menus = this.GetMenu(true);
            }

            foreach (Node menu in menus)
            {
                nodeID = menu.NodeID.Split(new string[] { "^/^" }, StringSplitOptions.None)[0];

                tmpTree = new TreePanel();
                tmpTree.ID = "treMenu" + nodeID;
                tmpTree.CustomConfig.Add(new ConfigItem("menu_no", "'" + nodeID + "'"));
                tmpTree.Border = false;
                tmpTree.AutoScroll = true;
                tmpTree.AnimCollapse = false;
                tmpTree.Collapsed = nodeID != openMenuID;
                tmpTree.Title = menu.Text;
                tmpTree.Animate = false;
                tmpTree.RootVisible = false;
                tmpTree.Root.Add(menu);
                tmpTree.Listeners.ItemClick.Handler = "if (record.data.href) { e.stopEvent(); LoadPage(record.getId(), record.data.text, record.data.dataPath); }";

                this.pnlMenu.Items.Add(tmpTree);


                #region Description : 트리 소속팀 펼치기

                NodeCollection nc = this.GetMenu(true);

                for (int i = 0; i < nc.Count; i++)
                {
                    nodeID = nc[i].NodeID.ToString();

                    if (nodeID == sSAUPBU.ToString())
                    {
                        tmpTree.GetNodeById(sSAUPBU).Expand(true);
                    }

                    for (int j = 0; j < nc[i].Children.Count; j++)
                    {
                        ChildnodeID = nc[i].Children[j].NodeID.ToString();

                        if (ChildnodeID == sChildDept[0].ToString())
                        {
                            tmpTree.GetNodeById(sChildDept[0]).Expand(true);
                        }
                        else
                        {
                            tmpTree.GetNodeById(ChildnodeID).Collapse(true);
                        }

                        for (int k = 0; k < nc[i].Children[j].Children.Count; k++)
                        {
                            Final_ChildnodeID = nc[i].Children[j].Children[k].NodeID.ToString();

                            // 이부분을 잘 이용하자.
                            //ChildnodeID = nc[i].Children[j].Children[k].ParentNode.

                            if (Final_ChildnodeID == sChildDept[1].ToString())
                            {
                                tmpTree.GetNodeById(sChildDept[1]).Expand(true);
                            }
                            else
                            {
                                tmpTree.GetNodeById(Final_ChildnodeID).Collapse(true);
                            }
                        }
                    }
                }

                #endregion
            }
        }

        /// <summary>
        /// 즐겨찾기 메뉴
        /// </summary>
        private Node GetFavorMenu()
        {
            Node rootNode = new Node();
            rootNode.NodeID = "MenuFavor";
            rootNode.Text = "결재선 조회";
            rootNode.Qtip = "결재선 조회";

            NodeCollection nc = this.GetMenu(true);

            if (nc.Count > 0)
            {
                rootNode.Children.AddRange(nc);
            }

            return rootNode;
        }

        /// <summary>
        /// 메뉴 NodeCollection
        /// </summary>
        /// <param name="getAllMenu">전체 메뉴 목록인지 여부</param>
        private NodeCollection GetMenu(bool getAllMenu)
        {
            NodeCollection rtnValue = new NodeCollection();

            DataTable dt = UP_SABUN_GetMenuData("");

            if (dt != null)
            {
                Node treeNode = null;
                List<Node> childNodes = null;
                string menu_no, menu_nm, menu_url, menu_nm_path;
                bool childMenuEnable;

                foreach (DataRow dr in dt.Select("[LEVEL] = 1"))
                {
                    menu_no = Convert.ToString(dr["CNODE"]);
                    menu_nm = Convert.ToString(dr["JKDESC"]) + " " + Convert.ToString(dr["TEXT"]);
                    menu_url = Convert.ToString(dr["SABUN"]);
                    menu_nm_path = Convert.ToString(dr["TEXT"]);
                    if (!string.IsNullOrEmpty(menu_url))
                    {
                        menu_url = this.Request.ApplicationPath + menu_url;
                    }

                    childNodes = this.GetChildMenuNodes(dt, menu_no, 2, getAllMenu, out childMenuEnable);

                    if (childMenuEnable == false && getAllMenu == false)
                    {
                        continue;
                    }

                    if (childNodes.Count == 0 && string.IsNullOrEmpty(menu_url) && getAllMenu == false)
                    {
                        continue;
                    }

                    treeNode = new Node();
                    treeNode.NodeID = menu_no;
                    treeNode.Text = menu_nm;
                    treeNode.Qtip = menu_nm;
                    treeNode.DataPath = menu_nm_path + " " + Convert.ToString(dr["JCCD"]);
                    if (!string.IsNullOrEmpty(menu_url))
                    {
                        treeNode.Href = menu_url;
                    }

                    if (childNodes.Count > 0)
                    {
                        treeNode.Leaf = false;
                        treeNode.Children.AddRange(childNodes);
                    }
                    else
                    {
                        treeNode.Leaf = true;
                    }

                    rtnValue.Add(treeNode);
                }
            }

            return rtnValue;
        }

        /// <summary>
        /// 테이블에서 해당 상위 메뉴 번호와 레벨을 갖는 메뉴를 노드 List로 반환 (Recursive 사용)
        /// </summary>
        /// <param name="dt">메뉴 데이터 테이블</param>
        /// <param name="par_menu_no">상위 메뉴 번호</param>
        /// <param name="level">레벨</param>
        /// <param name="getAllMenu">전체 메뉴 목록인지 여부</param>
        /// <param name="childMenuEnable">하위 메뉴 중 사용할 수 있는 것이 있는지 여부</param>
        /// <returns></returns>
        private List<Node> GetChildMenuNodes(DataTable dt, string par_menu_no, int level, bool getAllMenu, out bool childMenuEnable)
        {
            List<Node> rtnValue = new List<Node>();
            Node treeNode = null;
            List<Node> childNodes = null;
            string menu_no, menu_nm, menu_url, menu_nm_path;
            bool curChildMenuEnable = false;
            childMenuEnable = false;

            foreach (DataRow dr in dt.Select(string.Format("[PNODE] = '{0}' AND [LEVEL] = {1}", par_menu_no, level)))
            {
                menu_no = Convert.ToString(dr["CNODE"]);
                menu_nm = Convert.ToString(dr["JKDESC"]) + " " + Convert.ToString(dr["TEXT"]);
                menu_url = Convert.ToString(dr["SABUN"]);
                menu_nm_path = Convert.ToString(dr["TEXT"]);
                if (!string.IsNullOrEmpty(menu_url))
                {
                    menu_url = this.Request.ApplicationPath + menu_url;
                }

                childNodes = this.GetChildMenuNodes(dt, menu_no, level + 1, getAllMenu, out curChildMenuEnable);

                if (curChildMenuEnable == false && getAllMenu == false)
                {
                    continue;
                }

                if (childNodes.Count == 0 && string.IsNullOrEmpty(menu_url) && getAllMenu == false)
                {
                    continue;
                }


                treeNode = new Node();
                treeNode.NodeID = menu_no;
                treeNode.Text = menu_nm;
                treeNode.Qtip = menu_nm;
                treeNode.DataPath = menu_nm_path + " " + Convert.ToString(dr["JCCD"]);
                if (!string.IsNullOrEmpty(menu_url))
                {
                    treeNode.Href = menu_url;
                }

                if (Convert.ToString(dr["CNODE"].ToString()) == sDEPT.ToString())
                {
                    if (Convert.ToString(dr["LEVEL"]) == "3")
                    {
                        sChildDept[0] = Convert.ToString(dr["PNODE"].ToString());
                        sChildDept[1] = Convert.ToString(dr["CNODE"].ToString());
                    }
                    else
                    {
                        sChildDept[0] = Convert.ToString(dr["CNODE"].ToString());
                        sChildDept[1] = "";
                    }
                }

                if (childNodes.Count > 0)
                {
                    treeNode.Leaf = false;
                    treeNode.Children.AddRange(childNodes);
                }
                else
                {
                    treeNode.Leaf = true;
                }

                if (curChildMenuEnable == true)
                {
                    childMenuEnable = true;
                }

                rtnValue.Add(treeNode);
            }

            return rtnValue;
        }

        [DirectMethod]
        public string GetMenuJson(bool getAllMenu)
        {
            return this.GetMenu(getAllMenu).ToJson();
        }

        private DataTable UP_SABUN_GetMenuData(string emp_no)
        {
            DataTable rtnValue = null;

            using (TaeYoung.Biz.PSM.PSMBiz biz = new TaeYoung.Biz.PSM.PSMBiz())
            {
                Hashtable ht = new Hashtable();

                ht["P_BUSEO1"] = "ALL";
                ht["P_BUSEO2"] = "ALL";
                ht["P_BUSEO3"] = "ALL";
                ht["P_BUSEO4"] = "ALL";
                ht["P_BUSEO5"] = "ALL";
                ht["P_BUSEO6"] = "ALL";
                ht["P_BUSEO7"] = "ALL";
                ht["P_BUSEO8"] = "ALL";
                ht["P_SABUN"] = emp_no.ToString();

                DataSet ds = biz.UP_ORG_GETDATA(ht);

                rtnValue = ds.Tables[0];
            }

            return rtnValue;
        }

        #region Description : 현재 날짜
        protected string Get_NowDate()
        {
            string NowDate = System.DateTime.Now.ToShortDateString().Substring(0, 4) + "-" + System.DateTime.Now.ToShortDateString().Substring(5, 2) + "-" + System.DateTime.Now.ToShortDateString().Substring(8, 2);
            return NowDate;
        }
        #endregion
    }
}