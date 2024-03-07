<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AM102032P.aspx.cs" Inherits="TaeYoung.Portal.Admin.Cmn.AM102032P" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="conHead">
	
    <script type="text/javascript">
        var langcd = "<%= TaeYoung.Biz.Document.ClientCultureName %>";

        /********************************************************************************************
        * 함수명      : OnLoad()
        * 작성목적    : OnLoad 
        * Parameter   :
        * Return
        * 작성자     : 장윤호
        * 최초작성일   : 2014-10-20
        * 최종작성일   :
        * 수정내역    :
        ********************************************************************************************/
        function OnLoad() {
            var ht = new Object();
            ht["SEARCHCONDITION"] = "";
            ht["LANGCODE"] = langcd;

            grid1.Params(ht);
            grid1.BindList(1);
        }

        /********************************************************************************************
        * 함수명      : btnSelect_Click()
        * 작성목적    : 그룹 선택 버튼 
        * Parameter   :
        * Return
        * 작성자     : 장윤호
        * 최초작성일   : 2014-10-20
        * 최종작성일   :
        * 수정내역    :
        ********************************************************************************************/
        function btnSelect_Click() {
            var o = grid1.GetCheckRow(); // 체크된 전체데이터
            if (ObjectCount(o) <= 0) {
                alert('<Ctl:Text ID="MSG01" runat="server" LangCode="MSG01" Description="그룹을 선택하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (window != null && window.opener != null) {
                window.opener.groupSelect(o);
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
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="그룹선택" Literal="true" ></Ctl:Text>
        </h4>

        <div class="btn_bx">
			<Ctl:Button ID="btnSelect" runat="server" Style="Orange" LangCode="BTN01" Description="선택" OnClientClick="return btnSelect_Click();"></Ctl:Button>
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">
		<Ctl:Layer ID="layer1" runat="server">
			<!-- 내용 영역 -->
			<Ctl:WebSheet ID="grid1" runat="server" Paging="false" CheckBox="true" Width="100%" HFixation="true" height="500" TypeName="Common.AclBiz" MethodName="GetGroupAclExists">
						
                <Ctl:SheetField DataField="GRPID" TextField="Grid01" Description="그룹ID" Width="20%"  HAlign="center" Align="left" runat="server" />
                <Ctl:SheetField DataField="GRPNAME" TextField="Grid02" Description="그룹명" Width="80%"  HAlign="center" Align="left" runat="server" />

			</Ctl:WebSheet>
		</Ctl:Layer>
	</div>
</asp:Content>