<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1052.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1052" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _RMYEAR = "";
        var _RMSEQ = "";
        var _RMCODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var Code = "<%= Request.QueryString["CODE"] %>";

            var data = Code.split('^');

            if (data.length > 2) {

                DataGubn = "";
                _RMYEAR = data[0];
                _RMSEQ = data[1];
                _RMCODE = data[2];

                UP_DataBind_Run();
            }
            else {

                DataGubn = "A";
                _RMYEAR = data[0];
                _RMSEQ = data[1];
                _RMCODE = "";

                UP_FiledInit();

                btnDel.Hide();
            }
        }

        function UP_FiledInit() {

            txtRMYEAR.SetValue(_RMYEAR);    //년도
            txtRMSEQ.SetValue(_RMSEQ);      //순번
            txtRMCODE.SetDisabled(false);
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["RMYEAR"] = _RMYEAR;
            ht["RMSEQ"] = _RMSEQ;
            ht["RMCODE"] = _RMCODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_MASTER_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtRMYEAR.SetValue(DataSet.Tables[0].Rows[0]["RMYEAR"]);    //년도
                    txtRMSEQ.SetValue(DataSet.Tables[0].Rows[0]["RMSEQ"]);      //순번
                    txtRMCODE.SetValue(DataSet.Tables[0].Rows[0]["RMCODE"]);    //대분류코드
                    txtRMNAME.SetValue(DataSet.Tables[0].Rows[0]["RMNAME"]);    //대분류명

                    txtRMCODE.SetDisabled(true);

                    if (DataSet.Tables[0].Rows[0]["RMGUBUN"] == "Y") {

                        btnSave.Hide();
                        btnDel.Hide();
                    }
                    else {
                        btnSave.Show();
                        btnDel.Show();
                    }
                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });

        }


        function UP_FieldCheck() {

            if (txtRMYEAR.GetValue() == "" || txtRMYEAR.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="년도를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRMSEQ.GetValue() == "" || txtRMSEQ.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="순번을 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRMCODE.GetValue() == "" || txtRMCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server"  Description="대분류코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRMNAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="대분류명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (DataGubn == "A") {

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["RMYEAR"] = txtRMYEAR.GetValue();
                ht["RMSEQ"] = txtRMSEQ.GetValue();
                ht["RMCODE"] = txtRMCODE.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_MASTER_SAVECHECK", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                        alert('<Ctl:Text runat="server" Description="동일한 번호가 등록되어 있습니다." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else {
                        UP_Save();
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert("Error");
                    return false;
                });
            }
            else {
                UP_Save();
            }
        }

        // 저장 이벤트
        function UP_Save() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["RMYEAR"] = txtRMYEAR.GetValue();
            ht["RMSEQ"] = txtRMSEQ.GetValue();
            ht["RMCODE"] = txtRMCODE.GetValue();
            ht["RMNAME"] = txtRMNAME.GetValue();
            if (DataGubn == "A") {
                ht["WKGUBUN"] = "A";
            }
            else {
                ht["WKGUBUN"] = "C";
            }


            if (confirm('<Ctl:Text ID="MSG02" runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_MASTER_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            DataGubn = "";
                            _RMYEAR = txtRMYEAR.GetValue();
                            _RMSEQ = txtRMSEQ.GetValue();
                            _RMCODE = txtRMCODE.GetValue();

                            UP_DataBind_Run();

                            btnDel.Show();

                            alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                            if (opener != null && typeof (opener.riskcode_popup_callback) == "function") {
                                opener.riskcode_popup_callback(_RMYEAR, _RMSEQ, _RMCODE, txtRMNAME.GetValue());
                            }
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 저장 버튼 이벤트
        function btnSave_Click() {         

            UP_FieldCheck();
        }

        // 삭제 버튼 이벤트
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["RMYEAR"] = txtRMYEAR.GetValue();
            ht["RMSEQ"] = txtRMSEQ.GetValue();
            ht["RMCODE"] = txtRMCODE.GetValue();
            ht["WKGUBUN"] = "D";

            if (confirm('<Ctl:Text ID="MSG03" runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_MASTER_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                            if (opener != null && typeof (opener.riskcode_popup_callback) == "function") {
                                opener.riskcode_popup_callback(_RMYEAR, _RMSEQ, _RMCODE, "");
                            }
                            this.close();
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
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
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="대분류코드 등록" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
		    <Ctl:Button ID="btnSave" runat="server" Style="Orange" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnDel" runat="server" Style="Orange" LangCode="btnDel" Description="삭제" OnClientClick="btnDel_Click();" ></Ctl:Button>
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
                <tr>
                    <th>
                        <Ctl:Text ID="lblRMYEAR" runat="server" LangCode="lblRMYEAR" Description="년도" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:TextBox ID="txtRMYEAR" Width="90" runat="server" ReadOnly="true"></Ctl:TextBox>   
                    </td>
                    <th>
                        <Ctl:Text ID="lblRMSEQ" runat="server" LangCode="lblRMSEQ" Description="순번" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:TextBox ID="txtRMSEQ" Width="90" runat="server" ReadOnly="true"></Ctl:TextBox>  
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblRMCODE" runat="server" LangCode="lblRMCODE" Description="대분류코드" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:TextBox ID="txtRMCODE" Width="90" runat="server" MaxLength="1"></Ctl:TextBox>  
                    </td>
                    <th>
                        <Ctl:Text ID="lblRMNAME" runat="server" LangCode="lblRMNAME" Description="대분류명" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:TextBox ID="txtRMNAME" Width="300" runat="server"></Ctl:TextBox>  
                    </td>
                </tr>
            </table>
		</Ctl:Layer>

        
	</div>

</asp:content>