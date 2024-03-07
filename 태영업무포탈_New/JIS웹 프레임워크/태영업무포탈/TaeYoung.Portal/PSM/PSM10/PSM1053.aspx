<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1053.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1053" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _RLYEAR = "";
        var _RLSEQ = "";
        var _RLCODE = "";
        var _RLNAME = "";
        var _RLITEMCODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var Code = "<%= Request.QueryString["CODE"] %>";

            var data = Code.split('^');

            if (data.length > 4) {

                DataGubn = "";
                _RLYEAR = data[0];
                _RLSEQ = data[1];
                _RLCODE = data[2];
                _RLNAME = data[3];
                _RLITEMCODE = data[4];

                UP_DataBind_Run();
            }
            else {

                DataGubn = "A";
                _RLYEAR = data[0];
                _RLSEQ = data[1];
                _RLCODE = data[2];
                _RLNAME = data[3];
                _RLITEMCODE = "";

                UP_FiledInit();

                btnDel.Hide();
            }
        }

        function UP_FiledInit() {

            txtRLYEAR.SetValue(_RLYEAR);    //년도
            txtRLSEQ.SetValue(_RLSEQ);      //순번
            txtRLCODE.SetValue(_RLCODE);    //대분류코드
            txtRLNAME.SetValue(_RLNAME);      //대분류명
            txtRLITEMCODE.SetDisabled(false);
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["RLYEAR"] = _RLYEAR;
            ht["RLSEQ"] = _RLSEQ;
            ht["RLCODE"] = _RLCODE;
            ht["RLITEMCODE"] = _RLITEMCODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_LIST_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtRLYEAR.SetValue(DataSet.Tables[0].Rows[0]["RLYEAR"]);    //년도
                    txtRLSEQ.SetValue(DataSet.Tables[0].Rows[0]["RLSEQ"]);      //순번
                    txtRLCODE.SetValue(DataSet.Tables[0].Rows[0]["RLCODE"]);    //대분류코드
                    txtRLNAME.SetValue(DataSet.Tables[0].Rows[0]["RLNAME"]);    //대분류명
                    txtRLITEMCODE.SetValue(DataSet.Tables[0].Rows[0]["RLITEMCODE"]);    //항목코드
                    txtRLITEMNAME.SetValue(DataSet.Tables[0].Rows[0]["RLITEMNAME"]);    //항목명
                    txtRLRSINDEX0.SetValue(DataSet.Tables[0].Rows[0]["RLRSINDEX0"]);    //지수0
                    txtRLRSINDEX1.SetValue(DataSet.Tables[0].Rows[0]["RLRSINDEX1"]);    //지수1
                    txtRLRSINDEX2.SetValue(DataSet.Tables[0].Rows[0]["RLRSINDEX2"]);    //지수2
                    txtRLRSINDEX3.SetValue(DataSet.Tables[0].Rows[0]["RLRSINDEX3"]);    //지수3

                    txtRLITEMCODE.SetDisabled(true);

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

        // 저장 체크
        function UP_FieldCheck() {

            if (txtRLYEAR.GetValue() == "" || txtRLYEAR.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="년도를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRLSEQ.GetValue() == "" || txtRLSEQ.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="순번을 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRLCODE.GetValue() == "" || txtRLCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server"  Description="대분류코드를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRLNAME.GetValue() == "" || txtRLNAME.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="대분류명을 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRLITEMCODE.GetValue() == "" || txtRLITEMCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server"  Description="항목코드를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtRLITEMNAME.GetValue() == "" || txtRLITEMNAME.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="항목명을 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (DataGubn == "A") {

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["RLYEAR"] = txtRLYEAR.GetValue();
                ht["RLSEQ"] = txtRLSEQ.GetValue();
                ht["RLCODE"] = txtRLCODE.GetValue();
                ht["RLITEMCODE"] = txtRLITEMCODE.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_LIST_SAVECHECK", function (e) {

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

            ht["RLYEAR"] = txtRLYEAR.GetValue();
            ht["RLSEQ"] = txtRLSEQ.GetValue();
            ht["RLCODE"] = txtRLCODE.GetValue();
            ht["RLITEMCODE"] = txtRLITEMCODE.GetValue();
            ht["RLNAME"] = txtRLNAME.GetValue();
            ht["RLITEMNAME"] = txtRLITEMNAME.GetValue();
            ht["RLRSINDEX0"] = txtRLRSINDEX0.GetValue();
            ht["RLRSINDEX1"] = txtRLRSINDEX1.GetValue();
            ht["RLRSINDEX2"] = txtRLRSINDEX2.GetValue();
            ht["RLRSINDEX3"] = txtRLRSINDEX3.GetValue();

            if (DataGubn == "A") {
                ht["WKGUBUN"] = "A";
            }
            else {
                ht["WKGUBUN"] = "C";
            }

            if (confirm('<Ctl:Text runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_LIST_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            DataGubn = "";
                            _RLYEAR = txtRLYEAR.GetValue();
                            _RLSEQ = txtRLSEQ.GetValue();
                            _RLCODE = txtRLCODE.GetValue();
                            _RLNAME = txtRLNAME.GetValue();
                            _RLITEMCODE = txtRLITEMCODE.GetValue();

                            UP_DataBind_Run();

                            btnDel.Show();

                            alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                            if (opener != null && typeof (opener.riskcode_popup_callback) == "function") {
                                opener.riskcode_popup_callback(_RLYEAR, _RLSEQ, _RLCODE, _RLNAME);
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

            ht["RLYEAR"] = txtRLYEAR.GetValue();
            ht["RLSEQ"] = txtRLSEQ.GetValue();
            ht["RLCODE"] = txtRLCODE.GetValue();
            ht["RLITEMCODE"] = txtRLITEMCODE.GetValue();
            ht["WKGUBUN"] = "D";

            if (confirm('<Ctl:Text ID="MSG03" runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1050", "UP_RISKCODE_LIST_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                            if (opener != null && typeof (opener.riskcode_popup_callback) == "function") {
                                opener.riskcode_popup_callback(_RLYEAR, _RLSEQ, _RLCODE, _RLNAME);
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
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="항목코드 등록" Literal="true"></Ctl:Text>
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
                    <col width="*" />
                    <col width="100px" />
                    <col width="*" />
                    <col width="100px" />
                    <col width="*" />
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="lblRLCODE" runat="server" LangCode="lblRLCODE" Description="대분류코드" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:TextBox ID="txtRLCODE" Width="90" runat="server" ReadOnly="true"></Ctl:TextBox>  
                    </td>
                    <th>
                        <Ctl:Text ID="lblRLNAME" runat="server" LangCode="lblRLNAME" Description="대분류명" Required = "true"></Ctl:Text>
                    </th>
                    <td colspan="5">
                       <Ctl:TextBox ID="txtRLNAME" Width="300" runat="server" ReadOnly="true"></Ctl:TextBox>  
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblRLITEMCODE" runat="server" LangCode="lblRLITEMCODE" Description="항목코드" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:TextBox ID="txtRLITEMCODE" Width="90" runat="server" MaxLength="1"></Ctl:TextBox>  
                    </td>
                    <th>
                        <Ctl:Text ID="lblRLITEMNAME" runat="server" LangCode="lblRLITEMNAME" Description="항목명" Required = "true"></Ctl:Text>
                    </th>
                    <td colspan="5">
                       <Ctl:TextBox ID="txtRLITEMNAME" Width="300" runat="server"></Ctl:TextBox>  
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblRLRSINDEX0" runat="server" LangCode="lblRLRSINDEX0" Description="지수0"></Ctl:Text>
                    </th>
                    <td colspan="3">
                       <Ctl:TextBox ID="txtRLRSINDEX0" Width="150" runat="server"></Ctl:TextBox>  
                    </td>
                    <th>
                        <Ctl:Text ID="lblRLRSINDEX1" runat="server" LangCode="lblRLRSINDEX1" Description="지수1"></Ctl:Text>
                    </th>
                    <td colspan="3">
                       <Ctl:TextBox ID="txtRLRSINDEX1" Width="150" runat="server"></Ctl:TextBox>  
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblRLRSINDEX2" runat="server" LangCode="lblRLRSINDEX2" Description="지수2"></Ctl:Text>
                    </th>
                    <td colspan="3">
                       <Ctl:TextBox ID="txtRLRSINDEX2" Width="150" runat="server"></Ctl:TextBox>  
                    </td>
                    <th>
                        <Ctl:Text ID="lblRLRSINDEX3" runat="server" LangCode="lblRLRSINDEX3" Description="지수3"></Ctl:Text>
                    </th>
                    <td colspan="3">
                       <Ctl:TextBox ID="txtRLRSINDEX3" Width="150" runat="server"></Ctl:TextBox>  
                    </td>
                </tr>
                <Ctl:TextBox ID="txtRLYEAR" Hidden="true" runat="server"></Ctl:TextBox>  
                <Ctl:TextBox ID="txtRLSEQ" Hidden="true" runat="server"></Ctl:TextBox>  
            </table>
		</Ctl:Layer>

        
	</div>

</asp:content>