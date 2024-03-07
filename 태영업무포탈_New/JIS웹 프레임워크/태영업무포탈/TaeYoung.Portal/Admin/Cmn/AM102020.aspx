<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AM102020.aspx.cs" Inherits="TaeYoung.Portal.Admin.Cmn.AM102020" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="conHead">
	
    <script type="text/javascript">
        var langcd = "<%= TaeYoung.Biz.Document.ClientCultureName %>";
        // 페이지 로드시
        function OnLoad() {
            document.getElementById("tree1").style.width = "100%";
            document.getElementById("tree2").style.width = "100%";

            $("#<%= btnAdd.ClientID %>").hide();
            var ht = new Object();
            ht["PageSize"] = "9999";
            ht["LANGCODE"] = langcd;
            ht["GrpType"] = "";
            ht["GRPNAME"] = "";
            ht["GRPID"] = "";

            grid1.Params(ht);
            grid1.BindList(1);
            grid1.CallBack = function () {
                tree1.ProgressHide();
            };

            ht = new Object();

            //    		grid3.Params(ht);
            //    		grid3.BindList(1);
            grid4.Params(ht);
            grid4.BindList(1);

            ht["GRPID"] = "";

            //grid6.Params(ht);
            //grid6.BindList(1);

            // 트리 디자인 수정
            $("#tree1").css("border", "solid 1px #CCCCCC");
            $("#tree2").css("border", "solid 1px #CCCCCC");
            $("#tree3").css("border", "solid 1px #CCCCCC");

            
        }

        // 그룹목록 검색버튼 이벤트
        function btnSearch_Click() {
            var ht = new Object();
            ht["PageSize"] = "9999";
            ht["LANGCODE"] = langcd;
            ht["GrpType"] = "";
            ht["GRPNAME"] = txtTitle.GetValue();
            ht["GRPID"] = "";

            grid1.Params(ht);
            grid1.BindList(1);

            return false;
        }

        // 그룹목록 선택시 이벤트
        function Grid1RowClick(row, cell) {
            //PageProgressShow();
            var ht = grid1.GetRow(row)
            //var id = ht["GRPID"];

            var sht = new Object();
            sht["GRPID"] = ht["GRPID"];
            grid3.Params(sht);
            grid3.BindList(1);
            // 트리 베이터 바인딩
            tree1.ProgressShow();
            PageMethods.InvokeServiceTable(ht, "Common.MenuBiz", "GetMenuAclByGrp", function (e) {
                var DataSet = eval(e);
                // 선택 초기화
                tree1.AllSelectCancelItem();
                // 검색하여 권한이 있는 노드 체크
                for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                    // 갯수만큼 검색하여 선택처리한다.
                    var node = tree1.FindItem(DataSet.Tables[0].Rows[i]["IDX"]);
                    if (node) {
                        //node.Select();
                        //tree1.Item.TreeView.Select();.SelectItem(node);
                        node.SelNode.checked = true;

                        node.TreeView.SelectItem(node);

                        //node.AllChildSelect();
                        //node.TreeView.SelectItem(node);
                        //node.TreeView.onclickItem(e, node);
                    }
                }

                tree1.ProgressHide();

            }, function (e) {
                alert(e.get_message());
                tree1.ProgressHide();
            });
        }

        function Grid2RowClick(r, c) {
            var ht = grid2.GetRow(r)

            var sht = new Object();
            sht["GRPID"] = ht["GRPID"];
            grid4.Params(sht);
            grid4.BindList(1);
        }

        function Grid5RowClick(r, c) {
            var ht = grid5.GetRow(r)
            // 트리 베이터 바인딩
            tree3.ProgressShow();
            PageMethods.InvokeServiceTableCommon(ht, "MenuBiz", "GetMenuAclByGrp", function (e) {
                var DataSet = eval(e);
                // 선택 초기화
                tree3.AllSelectCancelItem();
                // 검색하여 권한이 있는 노드 체크
                for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                    // 갯수만큼 검색하여 선택처리한다.
                    var node = tree3.FindItem(DataSet.Tables[0].Rows[i]["IDX"]);
                    //node.Select();
                    //tree1.Item.TreeView.Select();.SelectItem(node);
                    node.SelNode.checked = true;

                    node.TreeView.SelectItem(node);

                    //node.AllChildSelect();
                    //node.TreeView.SelectItem(node);
                    //node.TreeView.onclickItem(e, node);
                }

                tree3.ProgressHide();

            }, function (e) {
                alert(e.get_message());
                tree3.ProgressHide();
            });
        }

        function Grid6RowClick(r, c) {
            tree3.AllSelectCancelItem();
            var dr = grid6.GetRow(r)

            var ht = new Object();
            ht["EMPID"] = dr["EMPID"];
            ht["COMPANYCODE"] = dr["CompanyCode"];
            grid5.Params(ht);
            grid5.BindList(1);
        }

        // 그룹목록 검색버튼 이벤트
        function btnSearch2_Click() {
            var ht = new Object();
            ht["NAME"] = txtName.GetValue(); // 임의의 값을 조회를 막음
            grid6.Params(ht);
            grid6.BindList(1);

            return false;
        }

        function tree1_click(o, s) {
        }
        function tree1_Loaded() {
        }

        // 그룹등록 팝업
        function btnGroupAdd_Click() {
            var win = window.open("AM102031P.aspx", "AM102031P", "top=100, left=500, width=700, height=700, toolbar=no, directories=no, location=no, status=no, menubar=no, scrollbars=yes, resizable=no");
            win.focus();
            return false;
        }

        // 저장버튼
        function btnSave_Click() {
            PageProgressShow();

            var GRPID = grid1.GetRow(grid1.SelectedRow)["GRPID"];

            var items = tree1.SelectedItems;
            var tmp = new Object();
            var hts = new Array();

            for (i = 0; i < items.length; i++) {
                var ht = new Object();
                ht["ACL_GRP"] = GRPID;
                ht["ACL_ID"] = items[i].Name;
                hts.push(ht);
            }

            PageMethods.InvokeServiceTableArrayCommon(ht, hts, "Common.AclBiz", "AddMenuAcl", function (e) {
                alert("저장이 완료되었습니다.");
                PageProgressHide();
            }, function (e) {
                alert(e.get_message());
                PageProgressHide();
            });

            return false;
        }
        function tree2_click(o, s) {
            var item = s.Item.Name;
            var ht = new Object();
            ht["PageSize"] = "9999";
            ht["SEARCHCONDITION"] = item;
            ht["LANGCODE"] = langcd;

            grid2.Params(ht);
            grid2.BindList(1);

            var sht = new Object();
            sht["GRPID"] = ""; // 임의의 값을 조회를 막음
            grid4.Params(sht);
            grid4.BindList(1);
        }

        function tree2_Loaded() {
        }
        function TabChanged(i) {
            if (i == 1) { // 두번쨰탭
                $("#<%= btnAdd.ClientID %>").show();
                $("#<%= btnSave.ClientID %>").hide();
            }
            else if (i == 0) {
                $("#<%= btnAdd.ClientID %>").hide();
                $("#<%= btnSave.ClientID %>").show();
            }
            if (i == 1) {
                tree2.BindTree("tree2");
                tree2.AllChildClose();
            }
            else if (i == 2) {
                tree3.BindTree("tree3");
                tree3.AllChildClose();
                var ht = new Object();
                ht["NAME"] = ""; // 임의의 값을 조회를 막음
                grid6.Params(ht);
                grid6.BindList(1);
            }
        }
        function btnAdd_Click() {

            ShowPopup("AM102033P.aspx?MENUID=" + tree2.SelectedItems[0].Name, "그룹선택", 400, 400);
            return false;
        }

        function SelectGrpID(rows) {
            PageProgressShow();

            var ACLID = tree2.SelectedItems[0].Name;

            var tmp = new Object();
            var hts = new Array();

            for (i = 0; i < ObjectCount(rows); i++) {
                var ht = new Object();
                ht["ACL_GRP"] = rows[i]["GRPID"];
                ht["ACL_ID"] = ACLID;
                hts.push(ht);
            }

            grid2.RemoveAllRow();
            // 없는 내용 추가
            for (var i = 0; i < ObjectCount(rows); i++) {
                // Row 추가
                grid2.InsertRow();
                // 추가한 ROW에 값 설정
                grid2.SetValue(i, "GRPID", rows[i]["GRPID"]);
                grid2.SetValue(i, "GRPNAME", rows[i]["GRPNAME"]);
            }

            PageMethods.InvokeServiceTableArrayCommon(ht, hts, "Common.AclBiz", "AddMenuGrpAcl", function (e) {
                alert("저장이 완료되었습니다.");
                // 전체 Row 삭제

                PageProgressHide();
            }, function (e) {
                alert(e.get_message());
                PageProgressHide();
            });
        }

	</script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="conBody">

	<!--타이틀시작-->
    <div id="title">
        <h4><Ctl:Text ID="ltlTitle" runat="server" LangCode="Title" Description="권한관리" Literal="true"></Ctl:Text></h4>  

        <div class="btn_bx">
			<!-- 버튼 영역 -->
			<Ctl:Button ID="btnGroupAdd" runat="server" Style="Orange" LangCode="btnGroupAdd" Description="그룹등록" OnClientClick="return btnGroupAdd_Click();"></Ctl:Button>
			<Ctl:Button ID="btnAdd" runat="server" Style="Orange" LangCode="btnAdd" Description="그룹추가" OnClientClick="return btnAdd_Click();"></Ctl:Button>
            <Ctl:Button ID="btnSave" runat="server" Style="Orange" LangCode="btnSave" Description="저장" OnClientClick="return btnSave_Click();"></Ctl:Button>
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server" Title="WebControl">
			<Ctl:LayerTap ID="tap11" runat="server" Width="200px" Title="그룹별 권한관리" Description="그룹별 권한관리"></Ctl:LayerTap>
            <Ctl:LayerTap ID="tap12" runat="server" Width="200px" Title="메뉴별 권한관리" Description="메뉴별 권한관리"></Ctl:LayerTap>
            <Ctl:LayerTap ID="tap13" runat="server" Width="200px" Title="사용자별 권한관리" Description="사용자별 권한관리"></Ctl:LayerTap>
			<!-- 내용 영역 -->
			<Ctl:LayerTapBody ID="tap11_body" runat="server">
				<div style="width:35%;float:left;">
                    <Ctl:Layer ID="layer2" runat="server" Title="그룹목록">
					    <Ctl:WebSheet ID="grid1" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="520" CellHeight="18" HeaderHeight="18">
                            <!--검색시작-->
                            <ul class="search">
                                <li><img src="/Resources/Images/icon_search.gif" alt="" title="" /></li>
                                <li style="padding-left:5px;"><Ctl:TextBox ID="txtTitle" runat="server" Width="250"></Ctl:TextBox></li>
                                <li style="padding-left:5px;"><Ctl:Button ID="btnSearch" runat="server" Style="Orange" LangCode="btnSearch"  Description="검색" InGrid="true" OnClientClick="return btnSearch_Click();"></Ctl:Button></li>
                            </ul>
					    </Ctl:WebSheet>
                    </Ctl:Layer>
				</div>
                <div style="width:35%; float:left;">
                    <Ctl:Layer ID="layer3" runat="server" Title="그룹인원">
					    <Ctl:WebSheet ID="grid3" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="520" CellHeight="18" HeaderHeight="18" UseColumnSort="true">
					    </Ctl:WebSheet>
                        <span style="color:Red;margin-left:10px;">* 상세인원 별로 권한설정은 불가합니다. 참고용으로만 활용하시길 바랍니다.</span>
                    </Ctl:Layer>
                </div>
				<div style="width:30%; float:right; vertical-align:top;">
                    <Ctl:Layer ID="layer4" runat="server" Title="리스트">
					    <Ctl:WebTree ID="tree1" runat="server" height="570"/>
                    </Ctl:Layer>
				</div>
            </Ctl:LayerTapBody>
            <Ctl:LayerTapBody ID="tap12_body" runat="server">
                <div style="width:30%;float:left;">
                    <Ctl:Layer ID="layer5" runat="server" Title="리스트">
					    <Ctl:WebTree ID="tree2" runat="server" height="570" style="border:solid 1px #000;" ScriptBindTree="true"/>
                    </Ctl:Layer>
				</div>
                <div style="width:35%; float:right;">
                    <Ctl:Layer ID="layer7" runat="server" Title="그룹인원">
					    <Ctl:WebSheet ID="grid4" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="520" CellHeight="18" HeaderHeight="18">
					    </Ctl:WebSheet>
                        <span style="color:Red;margin-left:10px;">* 상세인원 별로 권한설정은 불가합니다. 참고용으로만 활용하시길 바랍니다.</span>
                    </Ctl:Layer>
                </div>
				<div style="width:35%;float:right;">
                    <Ctl:Layer ID="layer6" runat="server" Title="그룹목록">
					    <Ctl:WebSheet ID="grid2" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="540" CellHeight="18" HeaderHeight="18">
					    </Ctl:WebSheet>
                    </Ctl:Layer>
				</div>
            </Ctl:LayerTapBody>
            <Ctl:LayerTapBody ID="tap13_body" runat="server">
                <div style="width:35%; float:left;">
                    <Ctl:Layer ID="layer9" runat="server" Title="그룹인원">
					    <Ctl:WebSheet ID="grid6" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="520" CellHeight="18" HeaderHeight="18">
                            <!--검색시작-->
                            <ul class="search">
                                <li><img src="/Resources/Images/icon_search.gif" alt="" title="" /></li>
                                <li style="padding-left:5px;"><Ctl:TextBox ID="txtName" runat="server" Width="250"></Ctl:TextBox></li>
                                <li style="padding-left:5px;"><Ctl:Button ID="btnSearch2" runat="server" Style="Orange" LangCode="btnSearch"  Description="검색" InGrid="true" OnClientClick="return btnSearch2_Click();"></Ctl:Button></li>
                            </ul>
					    </Ctl:WebSheet>
                        <%--<span style="color:Red;margin-left:10px;">* 상세인원 별로 권한설정은 불가합니다. 참고용으로만 활용하시길 바랍니다.</span>--%>
                    </Ctl:Layer>
                </div>
                <div style="width:30%;float:right;">
                    <Ctl:Layer ID="layer8" runat="server" Title="리스트">
					    <Ctl:WebTree ID="tree3" runat="server" height="570" style="border:solid 1px #000;" ScriptBindTree="true"/>
                    </Ctl:Layer>
				</div>
				<div style="width:35%;float:right;">
                    <Ctl:Layer ID="layer10" runat="server" Title="그룹목록">
					    <Ctl:WebSheet ID="grid5" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="540" CellHeight="18" HeaderHeight="18">
					    </Ctl:WebSheet>
                    </Ctl:Layer>
				</div>
            </Ctl:LayerTapBody>
		</Ctl:Layer>
	</div>
</asp:Content>