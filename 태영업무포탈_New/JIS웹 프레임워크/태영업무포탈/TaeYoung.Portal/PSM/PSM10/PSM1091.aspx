<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1091.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1091" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        // 페이지 로드
        function OnLoad() {

            var CODE = "<%= Request.QueryString["CODE"] %>";

            var data = CODE.split('^');

            if (data.length == 4) {

                txtJSMBLASS.SetValue(data[0]);
                txtJSMMLASS.SetValue(data[1]);
                txtJSMSLASS.SetValue(data[2]);
                txtJSMSEQ.SetValue(data[3]);

                UP_DataBind_Run();

                var ht = new Object();
                ht["GUBUN"] = "";

                cboBCODE.TypeName = "PSM.PSM1080";
                cboBCODE.MethodName = "UP_GET_JSA_BCODE_LIST";
                cboBCODE.DataTextField = "J1CODENAME";
                cboBCODE.DataValueField = "J1CODE";
                cboBCODE.Params(ht);
                cboBCODE.BindList();

                cboBCODE_Change();
            }
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object();
                        
            ht["P_MENU_NAME"] = txtJSMBLASS.GetValue() + "_" + txtJSMMLASS.GetValue() + "_" + txtJSMSLASS.GetValue() + "_" + txtJSMSEQ.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_MASTER_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtJSMBLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JBCODE"]);
                    txtJSMMLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JMCODE"]);
                    txtJSMSLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JSCODE"]);
                    txtJSMWKNAME.SetValue(DataSet.Tables[0].Rows[0]["JSMWKNAME"]);
                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        // 대분류 선택 이벤트
        function cboBCODE_Change() {

            var ht = new Object();
            ht["BCODE"] = cboBCODE.GetValue();
            ht["GUBUN"] = "";

            cboMCODE.TypeName = "PSM.PSM1080";
            cboMCODE.MethodName = "UP_GET_JSA_MCODE_LIST";
            cboMCODE.DataTextField = "J2CODENAME";
            cboMCODE.DataValueField = "J2MCODE";
            cboMCODE.Params(ht);
            cboMCODE.BindList();

            cboMCODE_Change();

            cboMCODE.SetValue("");
        }

        // 중분류 선택 이벤트
        function cboMCODE_Change() {

            var ht = new Object();
            ht["BCODE"] = cboBCODE.GetValue();
            ht["MCODE"] = cboMCODE.GetValue();
            ht["GUBUN"] = "";

            cboSCODE.TypeName = "PSM.PSM1080";
            cboSCODE.MethodName = "UP_GET_JSA_SCODE_LIST";
            cboSCODE.DataTextField = "J3CODENAME";
            cboSCODE.DataValueField = "J3SCODE";
            cboSCODE.Params(ht);
            cboSCODE.BindList();

            cboSCODE.SetValue("");
        }

        // 복사 버튼 이벤트
        function btnCopy_Click() {

            if (cboBCODE.GetValue() == "" || cboBCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="대분류를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboMCODE.GetValue() == "" || cboMCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="중분류를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboSCODE.GetValue() == "" || cboSCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="소분류를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJSMWKNAMECOPY.GetValue() == "" || txtJSMWKNAMECOPY.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="작업명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["JSMBLASS"] = txtJSMBLASS.GetValue();
            ht["JSMMLASS"] = txtJSMMLASS.GetValue();
            ht["JSMSLASS"] = txtJSMSLASS.GetValue();
            ht["JSMSEQ"] = txtJSMSEQ.GetValue();
            ht["BCODE"] = cboBCODE.GetValue();
            ht["MCODE"] = cboMCODE.GetValue();
            ht["SCODE"] = cboSCODE.GetValue();
            ht["JSMWKNAME"] = txtJSMWKNAMECOPY.GetValue();

            //alert(ht["JSMBLASS"] + "-" + ht["JSMMLASS"] + "-" + ht["JSMSLASS"] + "-" + ht["JSMSEQ"] + "-" + ht["BCODE"] + "-" + ht["MCODE"] + "-" + ht["SCODE"] + "-" + ht["JSMWKNAME"]);

            if (confirm('<Ctl:Text runat="server" Description="복사 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_COPY", function (e) {
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
                    <col width="80px" />
                    <col width="75px" />
                    <col width="80px" />
                    <col width="115px" />
                    <col width="80px" />
                    <col width="*" />
                </colgroup>
                <tr >
                    <th>
                        <Ctl:Text ID="lblJSMBLASS" runat="server" LangCode="lblJSMBLASS" Description="대분류" ></Ctl:Text>
                    </th>
                    <td style="text-align:left">
                        <Ctl:Text ID="txtJSMBLASS" runat="server" LangCode="txtJSMBLASS" Description="" Hidden="true"></Ctl:Text>
                        <Ctl:Text ID="txtJSMBLASSNM" runat="server" LangCode="txtJSMBLASSNM" Description="대분류명" ForeColor="Blue"></Ctl:Text>
                    </td>
                    <th>
                        <Ctl:Text ID="lblJSMMLASS" runat="server" LangCode="lblJSMMLASS" Description="중분류" ></Ctl:Text>
                    </th>
                    <td style="text-align:left">
                        <Ctl:Text ID="txtJSMMLASS" runat="server" LangCode="txtJSMMLASS" Description="" Hidden="true"></Ctl:Text>
                        <Ctl:Text ID="txtJSMMLASSNM" runat="server" LangCode="txtJSMMLASSNM" Description="중분류명" ForeColor="Blue"></Ctl:Text>
                    </td>
                    <th>
                        <Ctl:Text ID="lblJSMSLASS" runat="server" LangCode="lblJSMSLASS" Description="소분류" ></Ctl:Text>
                    </th>
                    <td style="text-align:left">
                        <Ctl:Text ID="txtJSMSLASS" runat="server" LangCode="txtJSMSLASS" Description="" Hidden="true"></Ctl:Text>
                        <Ctl:Text ID="txtJSMSLASSNM" runat="server" LangCode="txtJSMSLASSNM" Description="소분류명" ForeColor="Blue"></Ctl:Text>
                    </td>
                    
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJSMWKNAME" runat="server" LangCode="lblJSMSEQ" Description="작업명" ></Ctl:Text>
                    </th>
                    <td colspan="5" style="text-align:left">
                        <Ctl:Text ID="txtJSMSEQ" runat="server" LangCode="txtJSMSEQ" Description="" Hidden="true"></Ctl:Text>
                        <Ctl:Text ID="txtJSMWKNAME" runat="server" LangCode="txtJSMWKNAME" Description="작업명" ForeColor="Blue"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <Ctl:Text ID="Text1" runat="server" LangCode="Text1" Description="JSA 코드 생성할 DATA 입력" ></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblBCODE" runat="server" LangCode="lblBCODE" Description="대분류" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboBCODE" Width="100px" runat="server" OnChange= "cboBCODE_Change()">
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblMCODE" runat="server" LangCode="lblMCODE" Description="중분류" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboMCODE" Width="200px" runat="server"  OnChange= "cboMCODE_Change()">
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblSCODE" runat="server" LangCode="lblSCODE" Description="소분류" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cboSCODE" Width="230px" runat="server" RepeatColumns="2" >
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJSMWKNAMECOPY" runat="server" LangCode="lblJSMWKNAMECOPY" Description="작업명" Required = "true"></Ctl:Text>
                    </th>
                    <td colspan="5">
                        <Ctl:TextBox ID="txtJSMWKNAMECOPY" Width="100%" runat="server" LangCode="txtJSMWKNAMECOPY" Description="작업명"></Ctl:TextBox>
                    </td>
                </tr>
            </table>
		</Ctl:Layer>
	</div>
</asp:content>