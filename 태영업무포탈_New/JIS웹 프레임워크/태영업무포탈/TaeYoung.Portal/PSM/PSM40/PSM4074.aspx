<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4074.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4074" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";

        var fsParam ="";

        // 페이지 로드
        function OnLoad() {

            fsParam = "<%= Request.QueryString["param"] %>";

            if (fsParam == 'APPROVAL') {
                btnRETRACT.Hide();
            }
            else if (fsParam == 'RETRACT' || fsParam == 'CANCEL') {
                btnApproval.Hide();
            }

        }

        // 결재 버튼
        function btnApproval_Click() {

            if (opener) {

                opener.btnApp_Callback(txtCOMMENT1.GetValue());
                self.close();
            }
            else {
                alert("대상이 없습니다.");
            }
        }

        // 철회 및 취소 버튼
        function btnRETRACT_Click() {

            if (opener) {

                if (txtCOMMENT1.GetValue() == "") {

                    alert("내용을 입력하세요.");
                    return;
                }

                opener.btnApp_Callback(txtCOMMENT1.GetValue());
                self.close();
            }
            else {
                alert("대상이 없습니다.");
            }
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            this.close();
        }

    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="[의견 및 결재]" Literal="true"></Ctl:Text>
        </h4>
        <div class="btn_bx" >
            <Ctl:Button ID="btnApproval" runat="server" Style="Orange" LangCode="btnApproval" Description="저장" OnClientClick="btnApproval_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnRETRACT"  runat="server" Style="Orange" LangCode="btnRETRACT" Description="확인" OnClientClick="btnRETRACT_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnClose"    runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>                        
        </div>
        <div class="clear"></div>
    </div>

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" DefaultHide="False">
            <!-- 상단의 버튼을 정의 -->
            <div class="btn_bx">
                <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="370px" />
                    </colgroup>
                    <tr style="text-align:left;">
                        <td style="text-align:left; border-left:hidden; border-top:hidden; border-right:hidden; border-bottom:hidden;">
                            <Ctl:TextBox ID="txtCOMMENT1" runat="server" Height="85" ReadMode="false" ReadOnly="false" SetType="text"
                                  Text="" TextMode="MultiLine" Validation="false" Width="350px">
                             </Ctl:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </Ctl:Layer> 
    </div>
</asp:content>
