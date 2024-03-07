<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AM102033P.aspx.cs" Inherits="TaeYoung.Portal.Admin.Cmn.AM102033P" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="conHead">
	
    <script type="text/javascript">
        var langcd = "<%= TaeYoung.Biz.Document.ClientCultureName %>";
        var menuid = "<%= MENUID %>";

        function OnLoad() {
            var ht = new Object();
            //ht["PageSize"] = "9999";
            ht["SEARCHCONDITION"] = menuid;
            ht["LANGCODE"] = langcd;

            grid1.CallBack = function () {
                // 체크박스 처리
                var rows = grid1.GetAllRow().Rows;
                var grd_chk = document.getElementsByName("grid1_chk");
                for (var i = 0; i < ObjectCount(rows); i++) {
                    if (rows[i]["CHK"] == "1") {
                        grd_chk[i].checked = true;
                    }
                }
            };

            grid1.Params(ht);
            grid1.BindList(1);
        }

        function btnSave_Click() {
            if (opener != null && typeof (opener.SelectGrpID) == "function") {
                opener.SelectGrpID(grid1.GetCheckRow());
                self.close();
            }
            return false;
        }
	</script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="conBody">

	<!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="ltlTitle" runat="server" LangCode="Title" Description="권한관리" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
			<!-- 버튼 영역 -->
            <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="return btnSave_Click();"></Ctl:Button>
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server" Title="그룹선택" LangCode="layer1" Description="그룹선택">
			<!-- 내용 영역 -->
			<Ctl:WebSheet ID="grid1" runat="server" Paging="false" CheckBox="true" Width="100%" HFixation="true" height="220" TypeName="Common.AclBiz" MethodName="GetGroupAclExists">
                <Ctl:SheetField DataField="GRPID" TextField="Grid01" Description="그룹ID" Width="*"  HAlign="center" Align="left" OnClick="" runat="server" />
                <Ctl:SheetField DataField="GRPNAME" TextField="Grid02" Description="그룹명" Width="*"  HAlign="center" Align="left" OnClick="" runat="server" />
			</Ctl:WebSheet>
		</Ctl:Layer>
	</div>
</asp:Content>