<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProgramLog.aspx.cs" Inherits="TaeYoung.Portal.Admin.Log.ProgramLog" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="conHead">
	
    <script type="text/javascript">
        var plant = "<%= TaeYoung.Biz.Document.UserInfo.LocationCode %>";
        var corpcd = "<%= TaeYoung.Biz.Document.UserInfo.SiteCompanyCode %>";
        var ori_corpcd = "<%= TaeYoung.Biz.Document.UserInfo.CompanyCode %>";
        var langcd = "<%= TaeYoung.Biz.Document.ClientCultureName %>";
        var regid = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
        var loginid = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";
        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";
        var userName = "<%= TaeYoung.Biz.Document.UserInfo.UserName %>";
        var isVend = "<%= TaeYoung.Biz.Document.UserInfo.IsVend %>";
        /********************************************************************************************
        * 함수명      : OnLoad()
        * 작성목적    : OnLoad
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-07-10
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function OnLoad() {
            btnSearch_Click();
    	}

    	/********************************************************************************************
    	* 함수명      : btnSearch_Click()
    	* 작성목적    : 조회 버튼 클릭 이벤트
    	* Parameter   :
    	* Return
    	* 작성자      : 장윤호
    	* 최초작성일  : 2017-07-10
    	* 최종작성일  :
    	* 수정내역    :
    	********************************************************************************************/
    	function btnSearch_Click() {
    	    var ht = new Object();
    	    ht["STDT"] = txtSTDT.GetValue();
    	    ht["EDDT"] = txtEDDT.GetValue();

    	    grid1.Params(ht);
    	    grid1.BindList(1);

    	    return false;
    	}
	</script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="conBody">

	<!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="프로그램 통계" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
			<!-- 버튼 영역 -->
            
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server">
            <ul class="search">
      		   	<li style="padding-left:10px;">
                    <Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="기간"></Ctl:Text>
                </li>
      		   	<li style="padding-left:5px;">
                    <Ctl:TextBox ID="txtSTDT" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                    <Ctl:TextBox ID="txtEDDT" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                </li>
                <li style="padding-left:5px;">
                    <Ctl:Button ID="btnSearch" runat="server" Style="Orange" LangCode="btnSearch" Description="조회" OnClientClick="return btnSearch_Click();"></Ctl:Button>
                </li>
            </ul>
            <Ctl:WebSheet ID="grid1" runat="server" Paging="false" CheckBox="false" CellHeight="20" HeaderHeight="20" HFixation="true" Height="600" Width="100%" UseColumnSort="true" TypeName="Portal.TimeLogBiz" MethodName="GetCmn_Program_Systemlog_List" >
                <Ctl:SheetField DataField="DESCRIPTION" TextField="GTXT02" Description="프로그램명" Width="40%" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" OnClick="" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="PROGRAMPATH" TextField="GTXT01" Description="경로" Width="*" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" OnClick="" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="PROGRAM_CNT" TextField="GTXT03" Description="접속량" Width="10%" Edit="false" DataType="Number" EditType="text" HAlign="center" Align="right" OnClick="" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
            </Ctl:WebSheet>
		</Ctl:Layer>
	</div>
</asp:Content>