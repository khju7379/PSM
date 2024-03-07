<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePwdPopup.aspx.cs" Inherits="TaeYoung.Portal.ChangePwdPopup" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <link rel="stylesheet" type="text/css" href="OpenIssue.css" />
    <script type="text/javascript" src="OpenIssue.js"></script>
    <script type="text/javascript">
        var corpcd = "<%= TaeYoung.Biz.Document.UserInfo.SiteCompanyCode %>";
        var regco = "<%= TaeYoung.Biz.Document.UserInfo.CompanyCode %>";
        var langcd = "<%= TaeYoung.Biz.Document.UserInfo.ClientCultureName %>";
        var regid = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
        var loginid = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";
        var userName = "<%= TaeYoung.Biz.Document.UserInfo.UserName %>";
        var isVend = "<%= TaeYoung.Biz.Document.UserInfo.IsVend %>";

        function OnLoad() {
           
        }
        var btnSave_Click = function () {
            
            if (txtCURPASSWORD.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="BTN_SAVE_MSG01" Description="현재 비밀번호를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtNEWPASSWORD.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="BTN_SAVE_MSG02" Description="신규 비밀번호를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtCURPASSWORD.GetValue() == txtNEWPASSWORD.GetValue()) {
                alert('<Ctl:Text runat="server" LangCode="BTN_SAVE_MSG03" Description="현재 비밀번호와 다른 비밀 번호를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtCHKPASSWORD.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="BTN_SAVE_MSG04" Description="확인 비밀번호를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtNEWPASSWORD.GetValue() != txtCHKPASSWORD.GetValue()) {
                alert('<Ctl:Text runat="server" LangCode="BTN_SAVE_MSG05" Description="신규 비밀번호를 확인 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (!confirm('<Ctl:Text runat="server" LangCode="BTN_SAVE_MSG06" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>')) {
                return false;
            }

           

            //gamro4554
            var param = {
                'COMPANYCODE': regco
              , 'LOGINID': regid
              , 'PASSWORD': txtCURPASSWORD.GetValue()
              , 'NEWPASS': txtNEWPASSWORD.GetValue()
            };

            PageMethods.InvokeServiceTable(param, "Common.OrgChartBiz", "SetPassChange", btnSave_CallBack, function (e) {
                alert(e.get_message());
            });

            return false;
        }
        var btnSave_CallBack = function (e) {
            var ds = eval(e);

            if (ds) {
                var row = ds.Tables[0].Rows[0];
                //성공
                if (row.CHK_FLG == "Y") {
                    alert('<Ctl:Text runat="server" LangCode="BTN_SAVE_RTN_MSG01" Description="비밀번호를 변경 하였습니다." Literal="true"></Ctl:Text>');
                    btnClose_Click();
                    //현재 비밀번호 오류
                } else if (row.CHK_FLG == "C") {
                    alert('<Ctl:Text runat="server" LangCode="BTN_SAVE_RTN_MSG02" Description="비밀번호를 확인 하세요." Literal="true"></Ctl:Text>');
                }
            }
        };

        var btnClose_Click = function () {
            this.close();
            return false;
        }
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4><Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="비밀 번호 변경" Literal="true"></Ctl:Text></h4>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <!-- 사정조치 요구서(NCR) -->
        <Ctl:Layer ID="layer1" runat="server" Title="" DefaultHide="False" Collapsible = "False">
            <table class = "table_01" style="width: 100%;">
                <colgroup>
                    <col style = "width : 15%;" />
                    <col style = "width : auto;" />
                </colgroup>
                <tr>
                    <th><Ctl:Text ID="TXT_txtCURPASSWORD" runat='server' LangCode='TXT_txtCURPASSWORD' Description='현재 비밀 번호' Literal='True'/></th>
                    <td><Ctl:TextBox ID="txtCURPASSWORD" runat="server" SetType="Text" TextMode="Password" Width = "200"></Ctl:TextBox></td>
                </tr>
                <tr>
                    <th><Ctl:Text ID="TXT_txtNEWPASSWORD" runat='server' LangCode='TXT_txtNEWPASSWORD' Description='신규 비밀 번호' Literal='True'/></th>
                    <td><Ctl:TextBox ID="txtNEWPASSWORD" runat="server" SetType="Text" TextMode="Password" Width = "200"></Ctl:TextBox></td>
                </tr>
                <tr>
                    <th><Ctl:Text ID="TXT_txtCHKPASSWORD" runat='server' LangCode='TXT_txtCHKPASSWORD' Description='확인 비밀 번호' Literal='True'/></th>
                    <td><Ctl:TextBox ID="txtCHKPASSWORD" runat="server" SetType="Text" TextMode="Password" Width = "200"></Ctl:TextBox></td>
                </tr>
            </table>
        </Ctl:Layer>

        <div style = "width : 100%; text-align : center;">
            <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();"></Ctl:Button>
            <Ctl:Button ID="btnClose" runat="server" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();"></Ctl:Button>
        </div>
        

    </div>
</asp:content>

