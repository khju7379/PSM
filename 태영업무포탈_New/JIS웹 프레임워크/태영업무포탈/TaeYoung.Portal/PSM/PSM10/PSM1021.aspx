<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1021.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1021" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _L3SAUP = "";
        var _L3BCODE = "";
        var _L3MCODE = "";
        var _L3SCODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var Num = "<%= Request.QueryString["CODE"] %>";

            var data = Num.split('^');

            if (data.length > 1) {

                _L3SAUP = data[0];
                _L3BCODE = data[1];
                _L3MCODE = data[2];
                _L3SCODE = data[3];

                UP_DataBind_Run();
            }
            else {

                DataGubn = "ADD";
                _L3SAUP = "";
                _L3BCODE = "";
                _L3MCODE = "";
                _L3SCODE = "";

                btnDel.Hide();
            }

            cboL3SAUP_Change();
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["L3SAUP"] = _L3SAUP;
            ht["L3BCODE"] = _L3BCODE;
            ht["L3MCODE"] = _L3MCODE;
            ht["L3SCODE"] = _L3SCODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1020", "UP_LOCATIONCODE_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    cboL3SAUP.SetValue(DataSet.Tables[0].Rows[0]["L3SAUP"]);
                    let selectEl = document.querySelector("#cboL3BCODE");
                    var objOption = document.createElement("option");
                    objOption.text = DataSet.Tables[0].Rows[0]["L3BCODE"] + "-" + DataSet.Tables[0].Rows[0]["L3BCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["L3BCODE"];
                    selectEl.options.add(objOption);
                    selectEl = document.querySelector("#cboL3MCODE");
                    objOption = document.createElement("option");
                    objOption.text = DataSet.Tables[0].Rows[0]["L3MCODE"] + "-" + DataSet.Tables[0].Rows[0]["L3MCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["L3MCODE"];
                    selectEl.options.add(objOption);
                    txtL3SCODE.SetValue(DataSet.Tables[0].Rows[0]["L3SCODE"]);
                    txtL3NAME.SetValue(DataSet.Tables[0].Rows[0]["L3NAME"]);
                    txtL3BIGO.SetValue(DataSet.Tables[0].Rows[0]["L3BIGO"]);
                    cboL3SAUP.SetDisabled(true);
                    cboL3BCODE.SetDisabled(true);
                    cboL3MCODE.SetDisabled(true);
                    txtL3SCODE.SetDisabled(true);

                    if (DataSet.Tables[0].Rows[0]["SOGUBUN"] == "Y" || DataSet.Tables[0].Rows[0]["WOGUBUN"] == "Y") {
                        btnDel.Hide();
                    }
                    else {
                        btnDel.Show();
                    }
                }
                else {
                    btnNew_Click();
                }
                
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });

        }

        // 신규 버튼 이벤트
        function btnNew_Click()
        {
            cboL3SAUP.SetValue("");
            cboL3BCODE.SetValue("");
            cboL3MCODE.SetValue("");
            txtL3SCODE.SetValue("");
            txtL3NAME.SetValue("");
            txtL3BIGO.SetValue("");
            cboL3SAUP.SetDisabled(false);
            cboL3BCODE.SetDisabled(false);
            cboL3MCODE.SetDisabled(false);
            txtL3SCODE.SetDisabled(false);

            DataGubn = "ADD";
            _L3SAUP = "";
            _L3BCODE = "";
            _L3MCODE = "";
            _L3SCODE = "";

            btnDel.Hide();
        }

        // 저장 버튼 이벤트
        function btnSave_Click() {         

            if (cboL3SAUP.GetValue() == "" || cboL3SAUP.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="사업부를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboL3BCODE.GetValue() == "" || cboL3BCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="대분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboL3MCODE.GetValue() == "" || cboL3MCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="중분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtL3NAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="위치명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["L3SAUP"] = cboL3SAUP.GetValue();
            ht["L3BCODE"] = cboL3BCODE.GetValue();
            ht["L3MCODE"] = cboL3MCODE.GetValue();
            if (DataGubn == 'ADD') {
                ht["L3SCODE"] = "0";
            }
            else {
                ht["L3SCODE"] = txtL3SCODE.GetValue();
            }
            ht["L3NAME"] = txtL3NAME.GetValue();
            ht["L3BIGO"] = txtL3BIGO.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1020", "UP_LOCATIONCODE_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        DataGubn = "";
                        _L3SAUP = DataSet.Tables[0].Rows[0]["L3SAUP"];
                        _L3BCODE = DataSet.Tables[0].Rows[0]["L3BCODE"];
                        _L3MCODE = DataSet.Tables[0].Rows[0]["L3MCODE"];
                        _L3SCODE = DataSet.Tables[0].Rows[0]["L3SCODE"];

                        UP_DataBind_Run();

                        btnDel.Show();

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                        if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                            opener.btnSearch_Click();
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 삭제 버튼 이벤트
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["L3SAUP"] = cboL3SAUP.GetValue();
            ht["L3BCODE"] = cboL3BCODE.GetValue();
            ht["L3MCODE"] = cboL3MCODE.GetValue();
            ht["L3SCODE"] = txtL3SCODE.GetValue();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1020", "UP_LOCATIONCODE_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            btnNew_Click();

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                            if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                                opener.btnSearch_Click();
                            }
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            this.close();            
        }
        // 사업부 선택 이벤트
        function cboL3SAUP_Change() {

            var ht = new Object();
            ht["SAUP"] = cboL3SAUP.GetValue();
            ht["GUBUN"] = "";

            if (DataGubn == "ADD") {
                cboL3BCODE.TypeName = "PSM.PSM1020";
                cboL3BCODE.MethodName = "UP_GET_LCODE_LIST";
                cboL3BCODE.DataTextField = "L1CODENAME";
                cboL3BCODE.DataValueField = "L1CODE";
                cboL3BCODE.Params(ht);
                cboL3BCODE.BindList();
                cboL3BCODE.SetValue("");
                

                cboL3BCODE_Change();
            }
            return false;
        }

        // 대분류 선택 이벤트
        function cboL3BCODE_Change() {
            var ht = new Object();
            ht["SAUP"] = cboL3SAUP.GetValue();
            ht["LCODE"] = cboL3BCODE.GetValue();
            ht["GUBUN"] = "";

            if (DataGubn == "ADD") {
                cboL3MCODE.TypeName = "PSM.PSM1020";
                cboL3MCODE.MethodName = "UP_GET_MCODE_LIST";
                cboL3MCODE.DataTextField = "L2CODENAME";
                cboL3MCODE.DataValueField = "L2MCODE";
                cboL3MCODE.Params(ht);
                cboL3MCODE.BindList();
                cboL3MCODE.SetValue("");
            }

            return false;
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="위치코드 등록" Literal="true"></Ctl:Text>
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
                        <Ctl:Text ID="lblL3SAUP" runat="server" LangCode="lblL3SAUP" Description="사업부" Required = "true"></Ctl:Text>

                    </th>
                    <td colspan="3">                                          
                       <Ctl:Combo ID="cboL3SAUP" Width="60px" runat="server" OnChange="cboL3SAUP_Change();">
                           <asp:ListItem Selected="True" Text="UTT" Value="T"></asp:ListItem>
                           <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                       </Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblL3BCODE" runat="server" LangCode="lblL3BCODE" Description="대분류" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:Combo ID="cboL3BCODE" Width="150px" runat="server" OnChange="cboL3BCODE_Change()"></Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblL3MCODE" runat="server" LangCode="lblL3MCODE" Description="중분류" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:Combo ID="cboL3MCODE" Width="200px" runat="server"></Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblL3SCODE" runat="server" LangCode="lblL3SCODE" Description="위치" ></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtL3SCODE" Width="120px" runat="server" LangCode="txtL3SCODE" Description="위치" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblL3NAME" runat="server" LangCode="lblL3NAME" Description="위치명" Required = "true"></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtL3NAME" Width="230px" runat="server" LangCode="txtL3NAME" Description="위치명"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblL3BIGO" runat="server" LangCode="lblL3BIGO" Description="비고" ></Ctl:Text>
                    </th>
                    <td colspan="3">
                     <Ctl:TextBox ID="txtL3BIGO" runat="server"  Height="80"
                          ReadMode="false" ReadOnly="false" SetType="text"
                          Text="" TextMode="MultiLine" Validation="false" Width="500px">
                     </Ctl:TextBox>
                </td>
                </tr>
            </table>
		</Ctl:Layer>

        
	</div>

</asp:content>