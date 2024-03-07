<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1031.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1031" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _C3SAUP = "";
        var _C3BCODE = "";
        var _C3MCODE = "";
        var _C3SCODE = "";
        var DataGubn = "";
        var _id = "";

        // 페이지 로드
        function OnLoad() {

            var Num = "<%= Request.QueryString["CODE"] %>";

            var data = Num.split('^');

            if (data.length > 1) {

                _C3SAUP = data[0];
                _C3BCODE = data[1];
                _C3MCODE = data[2];
                _C3SCODE = data[3];

                UP_DataBind_Run();
            }
            else {

                DataGubn = "ADD";
                _C3SAUP = "";
                _C3BCODE = "";
                _C3MCODE = "";
                _C3SCODE = "";

                btnDel.Hide();
            }

            cboC3SAUP_Change();
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["C3SAUP"] = _C3SAUP;
            ht["C3BCODE"] = _C3BCODE;
            ht["C3MCODE"] = _C3MCODE;
            ht["C3SCODE"] = _C3SCODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1030", "UP_ACFIXCLASS3_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    cboC3SAUP.SetValue(DataSet.Tables[0].Rows[0]["C3SAUP"]);    // 사업부
                    let selectEl = document.querySelector("#cboC3BCODE");
                    var objOption = document.createElement("option");
                    objOption.text = DataSet.Tables[0].Rows[0]["C3BCODE"] + "-" + DataSet.Tables[0].Rows[0]["C3BCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["C3BCODE"];
                    selectEl.options.add(objOption);    // 대분류 코드
                    selectEl = document.querySelector("#cboC3MCODE");
                    objOption = document.createElement("option");
                    objOption.text = DataSet.Tables[0].Rows[0]["C3MCODE"] + "-" + DataSet.Tables[0].Rows[0]["C3MCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["C3MCODE"];
                    selectEl.options.add(objOption);    // 중분류 코드
                    txtC3SCODE.SetValue(DataSet.Tables[0].Rows[0]["C3SCODE"]);  // 설비코드
                    txtC3NAME.SetValue(DataSet.Tables[0].Rows[0]["C3NAME"]);    // 설비명
                    txtC3LINKCODE1.SetValue(DataSet.Tables[0].Rows[0]["C3LINKCODE1"]); //연결설비코드1
                    txtC3LINKCODE1NM.SetValue(DataSet.Tables[0].Rows[0]["C3LINKCODE1NM"]); //연결설비명1
                    txtC3LINKCODE2.SetValue(DataSet.Tables[0].Rows[0]["C3LINKCODE2"]); //연결설비코드2
                    txtC3LINKCODE2NM.SetValue(DataSet.Tables[0].Rows[0]["C3LINKCODE2NM"]); //연결설비명2
                    txtC3BIGO.SetValue(DataSet.Tables[0].Rows[0]["C3BIGO"]);    // 비고
                    cboC3SAUP.SetDisabled(true);
                    cboC3BCODE.SetDisabled(true);
                    cboC3MCODE.SetDisabled(true);
                    txtC3SCODE.SetDisabled(true);

                    if (DataSet.Tables[0].Rows[0]["SOGUBUN"] == "Y" || DataSet.Tables[0].Rows[0]["WOGUBUN"] == "Y") {
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
            cboC3SAUP.SetValue("");
            cboC3BCODE.SetValue("");
            cboC3MCODE.SetValue("");
            txtC3SCODE.SetValue("");
            txtC3NAME.SetValue("");
            txtC3LINKCODE1.SetValue("");
            txtC3LINKCODE1NM.SetValue("");
            txtC3LINKCODE2.SetValue("");
            txtC3LINKCODE2NM.SetValue("");
            txtC3BIGO.SetValue("");
            cboC3SAUP.SetDisabled(false);
            cboC3BCODE.SetDisabled(false);
            cboC3MCODE.SetDisabled(false);
            txtC3SCODE.SetDisabled(false);

            DataGubn = "ADD";
            _C3SAUP = "";
            _C3BCODE = "";
            _C3MCODE = "";
            _C3SCODE = "";

            btnDel.Hide();
        }

        // 저장 버튼 이벤트
        function btnSave_Click() {         

            if (cboC3SAUP.GetValue() == "" || cboC3SAUP.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="사업부를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboC3BCODE.GetValue() == "" || cboC3BCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="대분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboC3MCODE.GetValue() == "" || cboC3MCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="중분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtC3NAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="설비명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["C3SAUP"] = cboC3SAUP.GetValue();
            ht["C3BCODE"] = cboC3BCODE.GetValue();
            ht["C3MCODE"] = cboC3MCODE.GetValue();
            if (DataGubn == 'ADD') {
                ht["C3SCODE"] = "0";
                ht["WKGUBUN"] = "A";
            }
            else {
                ht["C3SCODE"] = txtC3SCODE.GetValue();
                ht["WKGUBUN"] = "C";
            }
            ht["C3NAME"] = txtC3NAME.GetValue();
            ht["C3LINKCODE1"] = txtC3LINKCODE1.GetValue();
            ht["C3LINKCODE2"] = txtC3LINKCODE2.GetValue();
            ht["C3BIGO"] = txtC3BIGO.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1030", "UP_ACFIXCLASS3_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            
                            DataGubn = "";
                            _C3SAUP = cboC3SAUP.GetValue();
                            _C3BCODE = cboC3BCODE.GetValue();
                            _C3MCODE = cboC3MCODE.GetValue();
                            _C3SCODE = DataSet.Tables[0].Rows[0]["MSG"];

                            UP_DataBind_Run();

                            btnDel.Show();

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

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

            ht["C3SAUP"] = cboC3SAUP.GetValue();
            ht["C3BCODE"] = cboC3BCODE.GetValue();
            ht["C3MCODE"] = cboC3MCODE.GetValue();
            ht["C3SCODE"] = txtC3SCODE.GetValue();
            ht["WKGUBUN"] = "D";

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1030", "UP_ACFIXCLASS3_DEL", function (e) {

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
        function cboC3SAUP_Change() {

            var ht = new Object();
            ht["SAUP"] = cboC3SAUP.GetValue();
            ht["GUBUN"] = "";

            if (DataGubn == "ADD") {
                cboC3BCODE.TypeName = "PSM.PSM1030";
                cboC3BCODE.MethodName = "UP_GET_BCODE_LIST";
                cboC3BCODE.DataTextField = "C1CODENAME";
                cboC3BCODE.DataValueField = "C1CODE";
                cboC3BCODE.Params(ht);
                cboC3BCODE.BindList();
                cboC3BCODE.SetValue("");
                

                cboC3BCODE_Change();
            }
            return false;
        }

        // 대분류 선택 이벤트
        function cboC3BCODE_Change() {
            var ht = new Object();
            ht["SAUP"] = cboC3SAUP.GetValue();
            ht["BCODE"] = cboC3BCODE.GetValue();
            ht["GUBUN"] = "";

            if (DataGubn == "ADD") {
                cboC3MCODE.TypeName = "PSM.PSM1030";
                cboC3MCODE.MethodName = "UP_GET_MCODE_LIST";
                cboC3MCODE.DataTextField = "C2CODENAME";
                cboC3MCODE.DataValueField = "C2MCODE";
                cboC3MCODE.Params(ht);
                cboC3MCODE.BindList();
                cboC3MCODE.SetValue("");
            }

            return false;
        }

        // 연관설비 코드헬프
        function btnPopUp_Click(id)
        {   
            _id = id;

            if (id == "C3LINKCODE1"){

                fn_OpenPop("../POP/PSP1030.aspx", 1000, 600);
            }
            else if (id == "C3LINKCODE2") {

                fn_OpenPop("../POP/PSP1030.aspx", 1000, 600);
            }
        }

        // 연관설비 코드헬프 콜백
        function btnPopup_Callback(ht)
        {
            if (_id == "C3LINKCODE1") {

                txtC3LINKCODE1.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                txtC3LINKCODE1NM.SetValue(ht["C3NAME"]);

            }
            else if (_id == "C3LINKCODE2") {
                txtC3LINKCODE2.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                txtC3LINKCODE2NM.SetValue(ht["C3NAME"]);
            }
        }

        function fn_OpenPopCustom(url, w, h, name) {
            if (url == "" || url == null || url == undefined) return;

            w = (w == undefined || w == null) ? 600 : w;
            h = (h == undefined || h == null) ? 400 : h;

            var strLeft = (window.screen.width - w) / 2;
            var strTop = (window.screen.height - h) / 2;

            var feat = "toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=" + w + ",height=" + h + ",top=" + strTop + ",left=" + strLeft;

            if (!winPop || (winPop && winPop.closed)) {
                winPop = window.open(url, name, feat);
            } else {
                winPop.location.href = url;
            }
            winPop.focus();
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="설비코드 등록" Literal="true"></Ctl:Text>
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
                        <Ctl:Text ID="lblC3SAUP" runat="server" LangCode="lblC3SAUP" Description="사업부" Required = "true"></Ctl:Text>

                    </th>
                    <td colspan="3">                                          
                       <Ctl:Combo ID="cboC3SAUP" Width="60px" runat="server" OnChange="cboC3SAUP_Change();">
                           <asp:ListItem Selected="True" Text="UTT" Value="T"></asp:ListItem>
                           <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                       </Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblC3BCODE" runat="server" LangCode="lblC3BCODE" Description="대분류" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:Combo ID="cboC3BCODE" Width="150px" runat="server" OnChange="cboC3BCODE_Change()"></Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblC3MCODE" runat="server" LangCode="lblC3MCODE" Description="중분류" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:Combo ID="cboC3MCODE" Width="230px" runat="server"></Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblC3SCODE" runat="server" LangCode="lblC3SCODE" Description="설비" ></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtC3SCODE" Width="120px" runat="server" LangCode="txtC3SCODE" Description="설비" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblC3NAME" runat="server" LangCode="lblC3NAME" Description="설비명" Required = "true"></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtC3NAME" Width="230px" runat="server" LangCode="txtC3NAME" Description="설비명"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblC3LINKCODE1" runat="server" LangCode="lblC3LINKCODE1" Description="연관설비1"></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtC3LINKCODE1" Width="90" runat="server"></Ctl:TextBox>      
                        <img src="/Resources/Images/btn_search.gif" ID="btnC3LINKCODE1" alt="연관설비1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('C3LINKCODE1');"  />
                        <Ctl:TextBox ID="txtC3LINKCODE1NM" readonly="true" Width="200" runat="server"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblC3LINKCODE2" runat="server" LangCode="lblC3LINKCODE2" Description="연관설비2"></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtC3LINKCODE2" Width="90" runat="server"></Ctl:TextBox>      
                        <img src="/Resources/Images/btn_search.gif" ID="btnC3LINKCODE2" alt="연관설비2조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('C3LINKCODE2');"  />
                        <Ctl:TextBox ID="txtC3LINKCODE2NM" readonly="true" Width="200" runat="server"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblC3BIGO" runat="server" LangCode="lblC3BIGO" Description="비고" ></Ctl:Text>
                    </th>
                    <td colspan="3">
                     <Ctl:TextBox ID="txtC3BIGO" runat="server"  Height="80"
                          ReadMode="false" ReadOnly="false" SetType="text"
                          Text="" TextMode="MultiLine" Validation="false" Width="500px">
                     </Ctl:TextBox>
                </td>
                </tr>
            </table>
		</Ctl:Layer>

        
	</div>

</asp:content>