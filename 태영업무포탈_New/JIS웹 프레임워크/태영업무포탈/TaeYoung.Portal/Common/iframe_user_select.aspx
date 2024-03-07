<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="iframe_user_select.aspx.cs" Inherits="TaeYoung.Portal.Common.iframe_user_select" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="conHead">
	<style type="text/css">        
        .LayerPop
        {
            display: block;
            width:700px;
        }
        
        .LayerPop div.LayerPop_title_02
        {
            width:680px;
        }
        
        .LayerPop .cont
        {
            width:680px;
        }
        
        #sub_body
        {
            position:absolute;
        }
        
        #content_bx
        {
            min-height:100%;
        }
        
        html, body
        {
            background: transparent;
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
            grid1.CallBack = function () {
                var all = grid1.GetAllRow();
                for (var i = 0; i < ObjectCount(all.Rows); i++) {
                    var dr = all.Rows[i];
                    if (dr["DEPTCODE"] == "ZZZZZZZZZ1") {       // 협력업체일때
                        grid1.SetValue(i, "COMPANYNAME", '<Ctl:Text runat="server" LangCode="OnLoad01" Description="협력업체" Literal="true"></Ctl:Text>');
                    }
                }
            };
    	}

    	/********************************************************************************************
    	* 함수명      : closeLayerPop()
    	* 작성목적    : 레이어팝업 닫기
    	* Parameter   :
    	* Return
    	* 작성자      : 장윤호
    	* 최초작성일  : 2017-05-15
    	* 최종작성일  :
    	* 수정내역    :
    	********************************************************************************************/
    	function closeLayerPop() {
    	    $(parent.document).find("#iframe_msg_box").hide();
    	    $(parent.document).find("#iframe_user_select").hide();

    	    $("#grid1_chkall").prop("checked", false);

    	    return false;
    	}

    	/********************************************************************************************
    	* 함수명      : grid1_Click()
    	* 작성목적    : 그리드 클릭 이벤트
    	* Parameter   :
    	* Return
    	* 작성자      : 장윤호
    	* 최초작성일  : 2017-05-15
    	* 최종작성일  :
    	* 수정내역    :
    	********************************************************************************************/
    	function grid1_Click(r, c) {
    	    var chk = $("#grid1_MainRow_" + r + " td.JINSheet_ChkCell input[value=" + r + "]");
    	    if (chk.prop("checked")) {
    	        chk.prop("checked", false);
    	    }
    	    else {
    	        chk.prop("checked", true);
    	    }
        }

    	/********************************************************************************************
    	* 함수명      : btnOk_Click()
    	* 작성목적    : 확인 버튼 클릭 이벤트
    	* Parameter   :
    	* Return
    	* 작성자      : 장윤호
    	* 최초작성일  : 2017-05-15
    	* 최종작성일  :
    	* 수정내역    :
    	********************************************************************************************/
        function btnOk_Click() {
            var carr = grid1.GetCheckRow();
            if (carr.length < 1) {
                alert('<Ctl:Text runat="server" LangCode="btnOk_Click01" Description="선택된 사용자가 없습니다." Literal="true"></Ctl:Text>');

                return false;
            }
            var ds =
            {
                 "DataSetName": "NewDataSet",
                 "Tables": [
                                {
                                    "Rows": []
                                }
                            ]
            };

            // 사용자 데이터 가공
            for (var i = 0; i < carr.length; i++) {
                ds.Tables[0].Rows.push(carr[i]);
            }

            parent.user_set(ds);

            closeLayerPop();

            return false;
        }
	</script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="conBody">
	<!--타이틀시작-->
    <%--<div id="title">
        <h4>
        </h4>

        <div class="btn_bx">
			<!-- 버튼 영역 -->
            
        </div>
        <div class="clear"></div>     
    </div>--%>
	<!--//타이틀끝-->
	<!--컨텐츠시작-->
    <div id="content">
        <div id="LayerPop_cont" class="LayerPop">
            <ul class="LayerPop_title">
                <li class="LayerPop_title_01">
                    <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="사용자 선택" Literal="true"></Ctl:Text>
                </li>
                <li class="LayerPop_close">
                    <a onclick="closeLayerPop();">
                        <img src="/Resources/Images/helpdesk_close.png" />
                    </a>
                </li>
            </ul>
            <div class="LayerPop_title_02">
                <div style="float:right; line-height:35px;">
                    <Ctl:Button ID="btnOk" runat="server" LangCode="btnOk" Description="확인" OnClientClick="return btnOk_Click();" Hidden="false"></Ctl:Button>
                </div>
            </div>
            <div class="cont">
                <Ctl:Layer ID="layer1" runat="server">
                    <Ctl:WebSheet ID="grid1" runat="server" CheckBox="true" Paging="false" CellHeight="20" HeaderHeight="20" Fixation="false" HFixation="true" Height="400" Width="100%">
                        <Ctl:SheetField DataField="COMPANYNAME" TextField="GTXT01" Description="법인" Width="40%" Edit="false" DataType="text" EditType="text" HAlign="center" Align="center" OnClick="grid1_Click" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                        <Ctl:SheetField DataField="DEPTNAME" TextField="GTXT02" Description="부서" Width="30%" Edit="false" DataType="text" EditType="text" HAlign="center" Align="center" OnClick="grid1_Click" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                        <Ctl:SheetField DataField="DISPLAYNAME" TextField="GTXT03" Description="이름" Width="30%" Edit="false" DataType="text" EditType="text" HAlign="center" Align="center" OnClick="grid1_Click" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                    </Ctl:WebSheet>
                </Ctl:Layer>
            </div>
        </div>
	</div>
</asp:Content>