<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AM102030.aspx.cs" Inherits="TaeYoung.Portal.Admin.Cmn.AM102030" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="conHead">
	
    <script type="text/javascript">
        var plant = "<%= TaeYoung.Biz.Document.UserInfo.LocationCode %>";
        var corpcd = "<%= TaeYoung.Biz.Document.UserInfo.SiteCompanyCode %>";
        var langcd = "<%= TaeYoung.Biz.Document.ClientCultureName %>";
        var regid = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
        var mandt = "<%= TaeYoung.Biz.Document.UserInfo.Mandt %>";
        /******************************************************************************************
        * 함수명 : OnLoad 
        * 설  명 : Page Load 시 Grid Binding 처리 함수
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function OnLoad() {
            gridBind();
        }
        /******************************************************************************************
        * 함수명 : Grid1RowClick 
        * 설  명 : 그리드 로우 선택 이벤트
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function Grid1RowClick(row, cell) {
            var row = grid1.GetRow(row);
            var win = window.open("AM102031P.aspx?GrpID=" + row["GRPID"], row, "top=100, left=500, width=700, height=700, toolbar=no, directories=no, location=no, status=no, menubar=no, scrollbars=yes, resizable=no");
            win.focus();
            return false;
        }
        function Grid1RowClick2(r, c) {
            var row = grid1.GetRow(r);
            var ht = new Object();
            ht["ACL_GRP"] = row["GRPID"];
            grid2.Params(ht);
            grid2.BindList(1);
        }
        /******************************************************************************************
        * 함수명 : fn_btnUserReg 
        * 설  명 : 담당자 등록 클릭
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function fn_btnUserReg() {
            var win = window.open("AM102031P.aspx", "AM102031P", "top=100, left=500, width=700, height=700, toolbar=no, directories=no, location=no, status=no, menubar=no, scrollbars=yes, resizable=no");
            win.focus();
            return false;
        }

        /******************************************************************************************
        * 함수명 : fn_btnSearch 
        * 설  명 : 페이지 조회
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function fn_btnSearch() {
            gridBind();
            return false;
        }

        function gridBind() {
            var ht = new Object();
            ht["LANGCODE"] = langcd
            ht["GrpType"] = cboGRPTYPE.GetValue();
            ht["GRPNAME"] = txtGRPNAME.GetValue();
            ht["GRPID"] = txtGRPID.GetValue();

            grid1.Params(ht);
            grid1.BindList(1);
        }
        // 삭제버튼
        function btnDelete_Click() {
            if (grid1.SelectedRow != null) { // 선택된 값이 있을시
                if (window.confirm('<Ctl:Text ID="MSG01" runat="server" LangCode="MSG01" Description="사용중인 프로그램이 없을경우 삭제 가능합니다\n 선택한 그룹을 삭제하시겠습니까?" Literal="true"></Ctl:Text>')) {

                    var rows = grid1.GetRow(grid1.SelectedRow);

                    if (rows["CNT"] * 1 != 0) {
                        alert('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG02" Description="사용중인 프로그램이 존재합니다." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    var ht = new Object();
                    ht["GRPID"] = rows["GRPID"];
                    PageMethods.InvokeServiceTableSync(ht, "Common.AclBiz", "RemoveGroup", function (e) {
                        gridBind();
                    }, function (e) {
                        alert(e);
                        gridBind();
                    });
                }
            }
            return false;
        }
	</script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="conBody">

	<!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="그룹 관리" Literal="true"></Ctl:Text>
        </h4>    
        <div class="btn_bx">
			<Ctl:Button ID="btnUserReg" runat="server" Style="Orange" LangCode="TXT02" Description="등록" OnClientClick="return fn_btnUserReg();" ></Ctl:Button>
            <Ctl:Button ID="btnDelete" runat="server" Style="Orange" LangCode="TXT03" Description="삭제" OnClientClick="return btnDelete_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnSearch" runat="server" Style="Orange" LangCode="TXT04" Description="조회" OnClientClick="return fn_btnSearch();" ></Ctl:Button>            
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server">
            <div style="width:79.5%;float:left;">
      		   	<ul class="search" style="border-bottom:0px;">
      		   		<li style="padding-left:5px;">
                        <img src="/Resources/Images/icon_search.gif" alt="" title="" />
                    </li>
                    <li style="padding-left:5px;">
                        <Ctl:Text ID="TXT05" runat="server" LangCode="TXT05" Description="그룹유형"></Ctl:Text>
                    </li>
   					<li style="padding-left:5px;">
                        <Ctl:Combo ID="cboGRPTYPE" runat="server" Width="130px">
                        </Ctl:Combo>
                    </li>
                    <li style="padding-left:5px;">
                        <Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="그룹명"></Ctl:Text>
                    </li>
   					<li style="padding-left:5px;">
                        <Ctl:TextBox ID="txtGRPNAME" runat="server" SetType="Text" Width="150"></Ctl:TextBox>
                    </li>
                    <li style="padding-left:5px;">
                        <Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="그룹ID"></Ctl:Text>
                    </li>
   					<li style="padding-left:5px;">
                        <Ctl:TextBox ID="txtGRPID" runat="server" SetType="Text" Width="150"></Ctl:TextBox>
                    </li>
                </ul>
			    <Ctl:WebSheet ID="grid1" runat="server" Paging="true" CheckBox="false" Width="100%" HFixation="false" CellHeight="18" HeaderHeight="18" TypeName="Common.AclBiz" MethodName="GetGroupList">
                    <Ctl:SheetField DataField="GRPTYPENM" TextField="GTXT01" Description="그룹유형" Width="160"  HAlign="center" Align="left" runat="server" />
                    <Ctl:SheetField DataField="GRPID" TextField="GTXT02" Description="그룹ID" Width="120"  HAlign="center" Align="left" runat="server" />
                    <Ctl:SheetField DataField="GRPNAME" TextField="GTXT03" Description="그룹명" Width="*"  HAlign="center" Align="left" OnClick="Grid1RowClick" runat="server" />
                    <Ctl:SheetField DataField="CNT" TextField="GTXT04" Description="권한사용 숫자" Width="120"  HAlign="center" Align="left" OnClick="Grid1RowClick2" runat="server" />
                </Ctl:WebSheet>
            </div>

            <div style="width:19.5%;float:right;">
                <ul class="search" style="border-bottom:0px;">
                    <li style="height:25px;">
                    </li>
                </ul>
                <Ctl:WebSheet ID="grid2" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" height="610" CellHeight="18" HeaderHeight="18" TypeName="Common.AclBiz" MethodName="GetMenuListByAcl">
                    <Ctl:SheetField DataField="KO" TextField="GTXT05" Description="메뉴명" Width="100%"  HAlign="center" Align="left" runat="server" />
                </Ctl:WebSheet>
            </div>
		</Ctl:Layer>
	</div>
</asp:Content>