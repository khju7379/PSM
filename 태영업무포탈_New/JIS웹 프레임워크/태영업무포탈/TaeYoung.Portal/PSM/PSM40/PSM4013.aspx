<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4013.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4013" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";

        var fsParam ="";

        // 페이지 로드
        function OnLoad() {

            var sWOORTEAM;
            var sWOORDATE;
            var sWOSEQ;

            sWOORTEAM = "<%= Request.QueryString["param"] %>";
            sWOORDATE = "<%= Request.QueryString["param1"] %>";
            sWOSEQ    = "<%= Request.QueryString["param2"] %>";

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_WOORTEAM"] = "<%= Request.QueryString["param"] %>";
            ht["P_WOORDATE"] = "<%= Request.QueryString["param1"] %>";
            ht["P_WOSEQ"]    = "<%= Request.QueryString["param2"] %>";

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_GET_WORKORDER_FINISH_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    cboWOIMMEDGUBN.SetValue(DataSet.Tables[0].Rows[0]["WOIMMEDGUBN"]);
                    txtWOIMMEDTEXT_POP.SetValue(DataSet.Tables[0].Rows[0]["WOIMMEDTEXT"])

                    txtMsg.SetValue("전결시 조치완료이면 이 요청건은 공사완료 됩니다.");
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재선 지정 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });

        }

        // 결재 버튼
        function btnApproval_Click() {

            if (cboWOIMMEDGUBN.GetValue() == "Y") {
                if (txtWOIMMEDTEXT_POP.GetValue() == "") {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 내용을 입력하세요." Literal="true"></Ctl:Text>');

                    return;
                }
            }

            if (opener) {

                opener.btnPopup_Last_Callback(txtCOMMENT1.GetValue(), cboWOIMMEDGUBN.GetValue(), txtWOIMMEDTEXT_POP.GetValue());
                self.close();
            }
            else {
                alert("대상이 없습니다.");
            }
        }

        function Combo_Changed() {

            if (cboWOIMMEDGUBN.GetValue() == "Y") {
                txtMsg.SetValue("전결시 조치완료이면 이 요청건은 공사완료 됩니다.");
            }
            else {
                txtMsg.SetValue("");
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
                        <col width="60px" />
                        <col width="100px" />
                        <col width="300px" />
                    </colgroup>
                    <tr style="text-align:left; border:hidden;">
                        <td style="text-align:left;">
                            <Ctl:Text ID="Text15" runat="server" LangCode="lblWOCHANGEWKJOB" Description="의견"></Ctl:Text>
                        </td>
                        <td colspan ="2" style="text-align:left; border-left:hidden; border-top:hidden; border-right:hidden; border-bottom:hidden;">
                            <Ctl:TextBox ID="txtCOMMENT1" runat="server" Height="85" ReadMode="false" ReadOnly="false" SetType="text"
                                  Text="" TextMode="MultiLine" Validation="false" Width="400px">
                             </Ctl:TextBox>
                        </td>
                    </tr>

                    <tr style="border:hidden;">
                        <td style="text-align:left;">
                            <Ctl:Text ID="Text1" runat="server" LangCode="lblWOIMMEDGUBN" Description="조치구분"></Ctl:Text>
                        </td>
                        <td style="text-align:left;border:hidden;">
                            <Ctl:Combo ID="cboWOIMMEDGUBN" Width="100px" runat="server" onchange="Combo_Changed();">
                                <asp:ListItem Text="작업진행" Value="N" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="조치완료" Value="Y" ></asp:ListItem>
                            </Ctl:Combo>
                        </td>
                        <td style="text-align:left; ">
                            <Ctl:Text ID="txtMsg" ForeColor ="red" runat="server" Width ="300px"></Ctl:Text>
                        </td>
                    </tr>

                    <tr style="text-align:left; border:hidden;">
                        <td style="text-align:left;border:hidden;">
                            <Ctl:Text ID="Text2" runat="server" LangCode="lblWOIMMEDGUBN" Description="조치내용"></Ctl:Text>
                        </td>

                        <td colspan ="2" style="text-align:left; border:hidden;">
                            <Ctl:TextBox ID="txtWOIMMEDTEXT_POP" runat="server" Height="85" ReadMode="false" ReadOnly="false" SetType="text"
                                  Text="" TextMode="MultiLine" Validation="false" Width="400px">
                             </Ctl:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </Ctl:Layer> 
    </div>
</asp:content>
