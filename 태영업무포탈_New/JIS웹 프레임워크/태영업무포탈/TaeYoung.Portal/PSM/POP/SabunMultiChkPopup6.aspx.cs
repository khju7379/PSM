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
    public partial class SabunMultiChkPopup6 : BasePage
    {
        private string sSABUN;
        private string sDEPT;
        private string sSAUPBU;
        private string[] sChildDept = new string[2];

        // 결재자
        private string[] sKBSABUN = new string[5];
        private string[] sKBHANGL = new string[5];
        private string[] sCDDESC1 = new string[5];
        private string[] sJKCODE = new string[5];
        private string[] sKBBUSEO = new string[5];

        #region Description : 페이지 로드
        public SabunMultiChkPopup6()
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

                // 참조
                this.BindTree(this.pnlReference, true, "");

                this.HdnSEQ.Text = "";
                this.HdnAPPRO1.Text = "";
                this.HdnAPPRO2.Text = "";
                this.HdnAPPRO3.Text = "";
                this.HdnAPPRO4.Text = "";
                this.HdnSafe.Text = "";
                this.HdnGubn.Text = "";

                // 결재자 가져오기
                UP_GET_Approval();

                X.Js.Call("chk_ClientChange", "1");
            }
        }
        #endregion

        #region Description : 결재자 가져오기
        private void UP_GET_Approval()
        {
            string sParam = string.Empty;
            string sEqual = string.Empty;

            int i = 0;
            int iCount = 0;
            int iData_Cnt = 0;

            this.HdnGubn.Text = this.Request.QueryString["param5"].ToString();

            // 총 결재라인수
            this.HdnCnt.Text = this.Request.QueryString["Data_Cnt"].ToString();

            // 결재할 순서
            this.HdnApprovalSite.Text = this.Request.QueryString["param6"].ToString();

            // 안전환경팀 사업부
            this.HdnSafeBuseo.Text = this.Request.QueryString["param7"].ToString().Substring(0, 1);

            iData_Cnt = int.Parse(this.Request.QueryString["Data_Cnt"].ToString());

            iCount = 0;

            #region Description : 결재라인

            for (i = 0; i < iData_Cnt; i++)
            {
                sParam = "param" + Convert.ToString(i + 1);

                iCount = i + 1;
                if (this.Request.QueryString[sParam].ToString() != "")
                {
                    sKBSABUN[i] = this.Request.QueryString[sParam].ToString();
                }
                else
                {
                    sKBSABUN[i] = "";
                }
            }

            this.HdnAPPRO1.Text = "";
            this.HdnAPPRO2.Text = "";
            this.HdnAPPRO3.Text = "";
            this.HdnAPPRO4.Text = "";


            string sGUBUN = string.Empty;

            DataTable dt = new DataTable();

            dt.Columns.Add("SEQ");
            dt.Columns.Add("GUBUN");
            dt.Columns.Add("KBSABUN");
            dt.Columns.Add("KBHANGL");
            dt.Columns.Add("CDDESC1");
            dt.Columns.Add("JKCODE");

            for (i = 0; i < iCount; i++)
            {
                if (sKBSABUN[i].ToString() != "")
                {
                    if (i == int.Parse(Get_Numeric(this.HdnApprovalSite.Text.Trim())))
                    {
                        if (sKBSABUN[int.Parse(Get_Numeric(this.HdnApprovalSite.Text.Trim()))].ToString() != Document.UserInfo.EmpID)
                        {
                            sKBSABUN[i] = Document.UserInfo.EmpID;  // 용도 확인

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
                                    sJKCODE[i]  = ds.Tables[0].Rows[0]["JCCD"].ToString();
                                }

                                sEqual = "Not";

                                if (this.Request.QueryString["param5"].ToString() == "safe")
                                {
                                    if (i == 0)
                                    {
                                        sGUBUN = "작업요청자";

                                        this.HdnAPPRO1.SetValue("작업요청자");
                                    }
                                    else if (i == 1)
                                    {
                                        sGUBUN = "허가자";

                                        this.HdnAPPRO2.SetValue("허가자");
                                    }
                                    else if (i == 2)
                                    {
                                        sGUBUN = "안전환경팀";

                                        this.HdnAPPRO3.SetValue("안전환경팀");

                                        this.HdnSafe.Text = sKBSABUN[i].ToString();
                                    }
                                    else if (i == 3)
                                    {
                                        sGUBUN = "현장안전감독자";

                                        this.HdnAPPRO4.SetValue("현장안전감독자");
                                    }
                                }
                                else
                                {
                                    if (i == 0)
                                    {
                                        sGUBUN = "작업요청자";

                                        this.HdnAPPRO1.SetValue("작업요청자");
                                    }
                                    else if (i == 1)
                                    {
                                        sGUBUN = "허가자";

                                        this.HdnAPPRO2.SetValue("허가자");
                                    }
                                    else if (i == 2)
                                    {
                                        sGUBUN = "현장안전감독자";

                                        this.HdnAPPRO3.SetValue("현장안전감독자");
                                    }
                                }

                                dt.Rows.Add((i), sGUBUN.ToString(), sKBSABUN[i].ToString(), sKBHANGL[i].ToString(), sCDDESC1[i].ToString(), sJKCODE[i].ToString());

                            }
                        }
                        else
                        {
                            if (sEqual == "")
                            {
                                UP_SET_Buseo(i);

                                if (this.Request.QueryString["param5"].ToString() == "safe")
                                {
                                    if (i == 0)
                                    {
                                        sGUBUN = "작업요청자";

                                        this.HdnAPPRO1.SetValue("작업요청자");
                                    }
                                    else if (i == 1)
                                    {
                                        sGUBUN = "허가자";

                                        this.HdnAPPRO2.SetValue("허가자");
                                    }
                                    else if (i == 2)
                                    {
                                        sGUBUN = "안전환경팀";

                                        this.HdnAPPRO3.SetValue("안전환경팀");

                                        this.HdnSafe.Text = sKBSABUN[i].ToString();
                                    }
                                    else if (i == 3)
                                    {
                                        sGUBUN = "현장안전감독자";

                                        this.HdnAPPRO4.SetValue("현장안전감독자");
                                    }
                                }
                                else
                                {
                                    if (i == 0)
                                    {
                                        sGUBUN = "작업요청자";

                                        this.HdnAPPRO1.SetValue("작업요청자");
                                    }
                                    else if (i == 1)
                                    {
                                        sGUBUN = "허가자";

                                        this.HdnAPPRO2.SetValue("허가자");
                                    }
                                    else if (i == 2)
                                    {
                                        sGUBUN = "현장안전감독자";

                                        this.HdnAPPRO3.SetValue("현장안전감독자");
                                    }
                                }
                            }
                        }

                        if (sEqual == "")
                        {
                            dt.Rows.Add((i), sGUBUN.ToString(), sKBSABUN[i].ToString(), sKBHANGL[i].ToString(), sCDDESC1[i].ToString(), sJKCODE[i].ToString());
                        }
                    }
                    else
                    {
                        if (sEqual == "")
                        {
                            UP_SET_Buseo(i);

                            if (this.Request.QueryString["param5"].ToString() == "safe")
                            {
                                if (i == 0)
                                {
                                    sGUBUN = "작업요청자";

                                    this.HdnAPPRO1.SetValue("작업요청자");
                                }
                                else if (i == 1)
                                {
                                    sGUBUN = "허가자";

                                    this.HdnAPPRO2.SetValue("허가자");
                                }
                                else if (i == 2)
                                {
                                    sGUBUN = "안전환경팀";

                                    this.HdnAPPRO3.SetValue("안전환경팀");

                                    this.HdnSafe.Text = sKBSABUN[i].ToString();
                                }
                                else if (i == 3)
                                {
                                    sGUBUN = "현장안전감독자";

                                    this.HdnAPPRO4.SetValue("현장안전감독자");
                                }
                            }
                            else
                            {
                                if (i == 0)
                                {
                                    sGUBUN = "작업요청자";

                                    this.HdnAPPRO1.SetValue("작업요청자");
                                }
                                else if (i == 1)
                                {
                                    sGUBUN = "허가자";

                                    this.HdnAPPRO2.SetValue("허가자");
                                }
                                else if (i == 2)
                                {
                                    sGUBUN = "현장안전감독자";

                                    this.HdnAPPRO3.SetValue("현장안전감독자");
                                }
                            }
                        }

                        if (sEqual == "")
                        {
                            dt.Rows.Add((i), sGUBUN.ToString(), sKBSABUN[i].ToString(), sKBHANGL[i].ToString(), sCDDESC1[i].ToString(), sJKCODE[i].ToString());
                        }
                    }
                }
            }

            this.Store2.DataSource = dt;
            this.Store2.DataBind();

            #endregion

            #region Description : 참조자

            int k = 0;

            DataTable dt3 = new DataTable();

            dt3.Columns.Add("KBSABUN");
            dt3.Columns.Add("KBHANGL");

            string[] sSABUN = this.Request.QueryString["SABUN"].ToString().Split(',');
            string[] sNAME = this.Request.QueryString["NAME"].ToString().Split(',');

            iData_Cnt = sSABUN.Length;

            for (k = 0; k < iData_Cnt; k++)
            {
                if (sSABUN[k].ToString() != "")
                {
                    dt3.Rows.Add(sSABUN[k].ToString().Trim(), sNAME[k].ToString().Trim());
                }
            }

            this.Store5.DataSource = dt3;
            this.Store5.DataBind();

            #endregion

        }
        #endregion

        #region Description : 결재선지정 버튼
        protected void btnSelect_Click(object sender, DirectEventArgs e)
        {
            if (this.HdnSafe.Text.Trim() != "")
            {
                using (TaeYoung.Biz.PSM.PSMBiz biz = new TaeYoung.Biz.PSM.PSMBiz())
                {
                    DataSet ds = new DataSet();

                    Hashtable ht = new Hashtable();

                    ht["P_DATE"] = System.DateTime.Now.ToShortDateString().Substring(0, 4) + "-" + System.DateTime.Now.ToShortDateString().Substring(5, 2) + "-" + System.DateTime.Now.ToShortDateString().Substring(8, 2);
                    ht["P_KBSABUN"] = HdnSafe;

                    ds = biz.UP_SABUN_GET_BUSEO(ht);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (ds.Tables[0].Rows[0]["KBBUSEO"].ToString().Substring(0, 2) != "D1")
                        {
                            X.MessageBox.Alert("확인", "마지막 결재라인은 안전환경팀 직원만 선택 가능합니다.").Show();
                        }
                        else
                        {
                            X.Js.Call("btnSelect_ClientClick");
                        }
                    }
                }
            }
            else
            {
                X.Js.Call("btnSelect_ClientClick");
            }
        }
        #endregion

        #region Description : 부서명 가져오기
        private void UP_SET_Buseo(int iArray)
        {
            using (TaeYoung.Biz.PSM.PSMBiz biz = new TaeYoung.Biz.PSM.PSMBiz())
            {
                if (sKBSABUN[iArray].ToString() != "")
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
                    ht["P_SABUN"]  = sKBSABUN[iArray].ToString();

                    ds = biz.UP_ORG_GETDATA(ht);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sKBHANGL[iArray] = ds.Tables[0].Rows[0]["NAME"].ToString();
                        sCDDESC1[iArray] = ds.Tables[0].Rows[0]["JKDESC"].ToString();
                        sJKCODE[iArray]  = ds.Tables[0].Rows[0]["JCCD"].ToString();
                        sKBBUSEO[iArray] = ds.Tables[0].Rows[0]["PNODE"].ToString();
                    }
                    else
                    {
                        sKBHANGL[iArray] = "";
                        sCDDESC1[iArray] = "";
                        sJKCODE[iArray]  = "";
                        sKBBUSEO[iArray] = "";
                    }
                }
                else
                {

                }
            }
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

        #region Description : 참조자 메뉴 데이터 바인딩
        private void BindTree(TreePanel treePanel, bool pageLoad, string sSABUN)
        {
            DataSet ds = null;

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
                ht["P_SABUN"] = "";

                ds = biz.UP_ORG_GETDATA(ht);

                if (ds != null && ds.Tables.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Select("[LEVEL] = 1"))
                    {
                        if (pageLoad)
                            treePanel.Root[0].Children.Add(this.GetNode(ds.Tables[0], dr, sSABUN));
                        else
                        {
                            treePanel.GetRootNode().AppendChild(this.GetNode(ds.Tables[0], dr, sSABUN));
                        }
                    }
                }

                this.pnlMenu.Render();
            }
        }
        #endregion

        #region Description : 참조자 하위노드 가져오기
        private Node GetNode(DataTable dtMenuDatas, DataRow drMenuData, string sSABUN)
        {
            string[] sabunList = sSABUN.Split(new string[] { "," }, StringSplitOptions.None);

            Node rtnValue = null;
            DataRow[] childNodeDatas;
            string menu_no = string.Empty;
            string menu_nm = string.Empty;

            Int32 iLVL = 0;

            if (drMenuData != null)
            {
                iLVL = Convert.ToInt32(drMenuData["LEVEL"]);

                menu_no = Convert.ToString(drMenuData["CNODE"]);
                menu_nm = Convert.ToString(drMenuData["TEXT"]);

                rtnValue = new Node();
                rtnValue.NodeID = menu_no;
                rtnValue.Text = menu_nm;
                rtnValue.Qtip = Convert.ToString(drMenuData["T_LEVEL"]);
                rtnValue.DataPath = Convert.ToString(drMenuData["T_LEVEL"]);

                //rtnValue.Expanded = false;



                // 같은 사업부 폴더 펼치기
                if (sSAUPBU == menu_no)
                {
                    rtnValue.Expanded = true; // 폴더 펼치기
                }
                else
                {
                    rtnValue.Expanded = false; // 폴더 접기
                }

                // 같은 팀 또는 파트 폴더 펼치기
                if (sChildDept[0] == menu_no)
                {
                    rtnValue.Expanded = true; // 폴더 펼치기
                }




                childNodeDatas = dtMenuDatas.Select(string.Format("[PNODE] = '{0}'", menu_no));

                if (childNodeDatas.Length > 0)
                {
                    rtnValue.Leaf = false;

                    foreach (DataRow dr in childNodeDatas)
                    {
                        rtnValue.Children.Add(this.GetNode(dtMenuDatas, dr, sSABUN));
                    }
                }

                if (iLVL >= 2)
                {
                    if (Convert.ToString(drMenuData["SABUN"]) != "")
                    {
                        rtnValue.Leaf = true; // 맨 하위 메뉴임
                    }

                    rtnValue.Checked = false;
                }

                if (iLVL == 1)
                {
                    //rtnValue.Expanded = false; // 폴더 접기

                    rtnValue.Checked = false;  // 체크 박스를 두면서 체크를 없게 함
                }
            }

            return rtnValue;
        }
        #endregion

        #region Description : 현재 날짜
        protected string Get_NowDate()
        {
            string NowDate = System.DateTime.Now.ToShortDateString().Substring(0, 4) + "-" + System.DateTime.Now.ToShortDateString().Substring(5, 2) + "-" + System.DateTime.Now.ToShortDateString().Substring(8, 2);
            return NowDate;
        }
        #endregion
    }
}