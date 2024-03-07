<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1051.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1051" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _PREYEAR = "";
        var _PRESEQ = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var Num = "<%= Request.QueryString["CODE"] %>";

            var data = Num.split('^');

            if (data.length > 1) {

                _PREYEAR = data[0];
                _PRESEQ = data[1];
                DataGubn = "COPY";
            }
            else {

                _PREYEAR = "";
                _PRESEQ = "";
                DataGubn = "ADD";

            }
            UP_FiledInit();
        }

        function UP_FiledInit() {

            if (DataGubn == "ADD") {
                $('#copyFiled').css('display', 'none');
                $('#copyImage').css('display', 'none');

                btnCopy.Hide();
            }
            else {
                txtPREYEAR.SetValue(_PREYEAR);
                txtPRESEQ.SetValue(_PRESEQ);

                btnSave.Hide();
            }
        }

        // 저장 버튼 이벤트
        function btnSave_Click() {         

            if (txtRSYEAR.GetValue() == "" || txtRSYEAR.GetValue().length != 4) {
                alert('<Ctl:Text runat="server" Description="년도를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboRSUSDPMK.GetValue() == "" || cboRSUSDPMK.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="사용부서를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRSUSSDATE.GetValue() == "" || txtRSUSSDATE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="적용기간 시작일자를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRSUSEDATE.GetValue() == "" || txtRSUSEDATE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="적용기간을 종료일자를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["RSYEAR"] = txtRSYEAR.GetValue();
            ht["RSUSDPMK"] = cboRSUSDPMK.GetValue();
            ht["RSUSSDATE"] = txtRSUSSDATE.GetValue();
            ht["RSUSEDATE"] = txtRSUSEDATE.GetValue();

            if (confirm('<Ctl:Text runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_VER_ADD", function (e) {
                    alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
                    if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                        opener.btnSearch_Click();
                    }
                    this.close();
                    
                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 복사 버튼 이벤트
        function btnCopy_Click() {

            if (txtRSYEAR.GetValue() == "" || txtRSYEAR.GetValue().length != 4) {
                alert('<Ctl:Text runat="server" Description="년도를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboRSUSDPMK.GetValue() == "" || cboRSUSDPMK.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="사용부서를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRSUSSDATE.GetValue() == "" || txtRSUSSDATE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="적용기간 시작일자를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRSUSEDATE.GetValue() == "" || txtRSUSEDATE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="적용기간을 종료일자를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["PREYEAR"] = txtPREYEAR.GetValue();
            ht["PRESEQ"] = txtPRESEQ.GetValue();
            ht["RSYEAR"] = txtRSYEAR.GetValue();
            ht["RSUSDPMK"] = cboRSUSDPMK.GetValue();
            ht["RSUSSDATE"] = txtRSUSSDATE.GetValue();
            ht["RSUSEDATE"] = txtRSUSEDATE.GetValue();

            if (confirm('<Ctl:Text runat="server" Description="복사 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_COPY", function (e) {
                    alert('<Ctl:Text runat="server" Description="복사가 완료 되었습니다." Literal="true"></Ctl:Text>');
                    if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                        opener.btnSearch_Click();
                    }
                    this.close();

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="복사 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            this.close();            
        }

    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <div class="btn_bx" style="height:30px">
		    <Ctl:Button ID="btnSave" runat="server" Style="Orange" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnCopy" runat="server" Style="Orange" LangCode="btnCopy" Description="복사" OnClientClick="btnCopy_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>                        
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server">
		    <table class="table_01" style="width:100%;" border="0">
                <colgroup>
                    <col width="100px" />
                    <col width="150px" />
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr id="copyFiled">
                    <th>
                        <Ctl:Text ID="lblPREYEAR" runat="server" LangCode="lblPREYEAR" Description="기준년도" Required = "true"></Ctl:Text>
                    </th>
                    <td>                                          
                       <Ctl:TextBox ID="txtPREYEAR" Width="100px" runat="server" LangCode="txtPREYEAR" Description="기준년도" ReadOnly="true"></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="lblPRESEQ" runat="server" LangCode="lblPRESEQ" Description="순번" Required = "true"></Ctl:Text>
                    </th>
                    <td>                                          
                       <Ctl:TextBox ID="txtPRESEQ" Width="80px" runat="server" LangCode="txtPRESEQ" Description="순번" ReadOnly="true"></Ctl:TextBox>
                    </td>
                </tr>
                <tr id="copyImage">
                    <td colspan="4" style="text-align:center;">
                        <img src="/Resources/Images/down_arrow.png" alt="" title="" >
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblRSYEAR" runat="server" LangCode="lblRSYEAR" Description="복사년도" Required = "true"></Ctl:Text>
                    </th>
                    <td>                                          
                       <Ctl:TextBox ID="txtRSYEAR" Width="100px" runat="server" LangCode="txtRSYEAR" Description="복사년도" MaxLength="4"></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="lblRSSEQ" runat="server" LangCode="lblRSSEQ" Description="순번" ></Ctl:Text>
                    </th>
                    <td>                                          
                       <Ctl:TextBox ID="txtRSSEQ" Width="80px" runat="server" LangCode="txtRSSEQ" Description="순번" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblRSUSDPMK" runat="server" LangCode="lblRSUSDPMK" Description="사용부서" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboRSUSDPMK" Width="60px" runat="server">
                           <asp:ListItem Selected="True" Text="UTT" Value="T"></asp:ListItem>
                           <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                       </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblRSUSDATE" runat="server" LangCode="lblRSUSDATE" Description="적용기간" Required = "true"></Ctl:Text>
                    </th>
                    <td >
                        <Ctl:TextBox ID="txtRSUSSDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ></Ctl:TextBox> - 
                        <Ctl:TextBox ID="txtRSUSEDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ></Ctl:TextBox>
                    </td>
                </tr>
            </table>
		</Ctl:Layer>

        
	</div>

</asp:content>