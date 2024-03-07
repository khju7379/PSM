<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1081.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1081" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _J3BCODE = "";
        var _J3MCODE = "";
        var _J3SCODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var Num = "<%= Request.QueryString["CODE"] %>";

            var data = Num.split('^');

            if (data.length > 1) {

                _J3BCODE = data[0];
                _J3MCODE = data[1];
                _J3SCODE = data[2];

                UP_DataBind_Run();
            }
            else {

                DataGubn = "ADD";
                
                _J3BCODE = "";
                _J3MCODE = "";
                _J3SCODE = "";

                btnDel.Hide();

                var ht = new Object();
                ht["GUBUN"] = "";

                cboJ3BCODE.TypeName = "PSM.PSM1080";
                cboJ3BCODE.MethodName = "UP_GET_JSA_BCODE_LIST";
                cboJ3BCODE.DataTextField = "J1CODENAME";
                cboJ3BCODE.DataValueField = "J1CODE";
                cboJ3BCODE.Params(ht);
                cboJ3BCODE.BindList();
            }

            cboJ3BCODE_Change();
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["J3BCODE"] = _J3BCODE;
            ht["J3MCODE"] = _J3MCODE;
            ht["J3SCODE"] = _J3SCODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1080", "UP_JSA_CLASS3_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    
                    let selectEl = document.querySelector("#cboJ3BCODE");
                    var objOption = document.createElement("option");
                    objOption.text = DataSet.Tables[0].Rows[0]["J3BCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["J3BCODE"];
                    selectEl.options.add(objOption);
                    selectEl = document.querySelector("#cboJ3MCODE");
                    objOption = document.createElement("option");
                    objOption.text = DataSet.Tables[0].Rows[0]["J3MCODE"] + "-" + DataSet.Tables[0].Rows[0]["J3MCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["J3MCODE"];
                    selectEl.options.add(objOption);
                    txtJ3SCODE.SetValue(DataSet.Tables[0].Rows[0]["J3SCODE"]);
                    txtJ3NAME.SetValue(DataSet.Tables[0].Rows[0]["J3NAME"]);
                    txtJ3BIGO.SetValue(DataSet.Tables[0].Rows[0]["J3BIGO"]);
                    
                    cboJ3BCODE.SetDisabled(true);
                    cboJ3MCODE.SetDisabled(true);
                    txtJ3SCODE.SetDisabled(true);

                    if (DataSet.Tables[0].Rows[0]["JSMGUBUN"] == "Y" || DataSet.Tables[0].Rows[0]["JSCGUBUN"] == "Y") {

                        btnDel.Hide();
                    }
                    else {
                        btnDel.Show();
                    }
                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });

        }

        // 신규 버튼 이벤트
        function btnNew_Click()
        {
            var ht = new Object();
            ht["GUBUN"] = "";

            cboJ3BCODE.TypeName = "PSM.PSM1080";
            cboJ3BCODE.MethodName = "UP_GET_JSA_BCODE_LIST";
            cboJ3BCODE.DataTextField = "J1CODENAME";
            cboJ3BCODE.DataValueField = "J1CODE";
            cboJ3BCODE.Params(ht);
            cboJ3BCODE.BindList();

            cboJ3BCODE.SetValue("");
            cboJ3MCODE.SetValue("");
            txtJ3SCODE.SetValue("");
            txtJ3NAME.SetValue("");
            txtJ3BIGO.SetValue("");
            
            cboJ3BCODE.SetDisabled(false);
            cboJ3MCODE.SetDisabled(false);
            txtJ3SCODE.SetDisabled(false);

            DataGubn = "ADD";
            _J3BCODE = "";
            _J3MCODE = "";
            _J3SCODE = "";

            btnDel.Hide();
        }

        // 저장 버튼 이벤트
        function btnSave_Click() {         

            if (cboJ3BCODE.GetValue() == "" || cboJ3BCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="대분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboJ3MCODE.GetValue() == "" || cboJ3MCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="중분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJ3NAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="소분류명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["J3BCODE"] = cboJ3BCODE.GetValue();
            ht["J3MCODE"] = cboJ3MCODE.GetValue();
            if (DataGubn == 'ADD') {
                ht["J3SCODE"] = "0";
            }
            else {
                ht["J3SCODE"] = txtJ3SCODE.GetValue();
            }
            ht["J3NAME"] = txtJ3NAME.GetValue();
            ht["J3BIGO"] = txtJ3BIGO.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1080", "UP_JSA_CLASS3_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        DataGubn = "";
                        _J3BCODE = DataSet.Tables[0].Rows[0]["J3BCODE"];
                        _J3MCODE = DataSet.Tables[0].Rows[0]["J3MCODE"];
                        _J3SCODE = DataSet.Tables[0].Rows[0]["J3SCODE"];

                        UP_DataBind_Run();

                        btnDel.Show();

                        alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                        if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                            opener.btnSearch_Click();
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

        // 삭제 버튼 이벤트
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["J3BCODE"] = cboJ3BCODE.GetValue();
            ht["J3MCODE"] = cboJ3MCODE.GetValue();
            ht["J3SCODE"] = txtJ3SCODE.GetValue();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1080", "UP_JSA_CLASS3_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            btnNew_Click();

                            alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                            if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                                opener.btnSearch_Click();
                            }
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

        // 대분류 선택 이벤트
        function cboJ3BCODE_Change() {
            var ht = new Object();
            
            ht["BCODE"] = cboJ3BCODE.GetValue();
            ht["GUBUN"] = "";

            if (DataGubn == "ADD") {
                cboJ3MCODE.TypeName = "PSM.PSM1080";
                cboJ3MCODE.MethodName = "UP_GET_JSA_MCODE_LIST";
                cboJ3MCODE.DataTextField = "J2CODENAME";
                cboJ3MCODE.DataValueField = "J2MCODE";
                cboJ3MCODE.Params(ht);
                cboJ3MCODE.BindList();
                cboJ3MCODE.SetValue("");
            }

            return false;
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="JSA코드(소분류)" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
            <Ctl:Button ID="btnNew" runat="server" Style="Orange" LangCode="btnNew" Description="신규" OnClientClick="btnNew_Click();" ></Ctl:Button>
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
                        <Ctl:Text ID="lblJ3BCODE" runat="server" LangCode="lblJ3BCODE" Description="대분류" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:Combo ID="cboJ3BCODE" Width="150px" runat="server" OnChange="cboJ3BCODE_Change()"></Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblJ3MCODE" runat="server" LangCode="lblJ3MCODE" Description="중분류" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:Combo ID="cboJ3MCODE" Width="200px" runat="server"></Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJ3SCODE" runat="server" LangCode="lblJ3SCODE" Description="소분류" ></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtJ3SCODE" Width="120px" runat="server" LangCode="txtJ3SCODE" Description="소분류" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJ3NAME" runat="server" LangCode="lblJ3NAME" Description="소분류명" Required = "true"></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtJ3NAME" Width="230px" runat="server" LangCode="txtJ3NAME" Description="소분류명"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJ3BIGO" runat="server" LangCode="lblJ3BIGO" Description="비고" ></Ctl:Text>
                    </th>
                    <td colspan="3">
                     <Ctl:TextBox ID="txtJ3BIGO" runat="server"  Height="80"
                          ReadMode="false" ReadOnly="false" SetType="text"
                          Text="" TextMode="MultiLine" Validation="false" Width="500px">
                     </Ctl:TextBox>
                </td>
                </tr>
            </table>
		</Ctl:Layer>
	</div>
</asp:content>