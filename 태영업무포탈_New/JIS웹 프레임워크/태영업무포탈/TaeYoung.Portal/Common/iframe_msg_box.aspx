<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="iframe_msg_box.aspx.cs" Inherits="TaeYoung.Portal.Common.iframe_msg_box" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="conHead">
	<style type="text/css">
        #Msg_box_bg
        {
            display: block;
        }
        
        #sub_body
        {
            position:absolute;
        }
                
        #content_bx
        {
            min-height:100%;
        }
	</style>
    <script type="text/javascript">
        var plant = "<%= TaeYoung.Biz.Document.UserInfo.LocationCode %>";
        var corpcd = "<%= TaeYoung.Biz.Document.UserInfo.SiteCompanyCode %>";
        var ori_corpcd = "<%= TaeYoung.Biz.Document.UserInfo.CompanyCode %>";
        var langcd = "<%= TaeYoung.Biz.Document.ClientCultureName %>";
        var regid = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
        var loginid = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";
        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";
        var userName = "<%= TaeYoung.Biz.Document.UserInfo.UserName %>";
        /********************************************************************************************
        * 함수명      : OnLoad()
        * 작성목적    : OnLoad
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-05-15
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
    	function OnLoad() {
    	}
	</script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="conBody">

	<!--타이틀시작-->
    <div id="title">
        <h4>
        </h4>

        <div class="btn_bx">
			<!-- 버튼 영역 -->
            
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->
	<div id="Msg_box_bg"></div>
	<!--컨텐츠시작-->
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server">
			<!-- 내용 영역 -->
		</Ctl:Layer>
	</div>
</asp:Content>