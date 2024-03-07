<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1032.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1032" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _C2SAUP = "";
        var _C2BCODE = "";
        var _C2MCODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 10000;
            ht["C2SAUP"] = "T";
            ht["C2BCODE"] = "";
            ht["C2NAME"] = "";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            DataGubn = "ADD";
            btnDel.Hide();
            cboSAUP_Change();
            cboC2SAUP_Change();
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["C2SAUP"] = _C2SAUP;
            ht["C2BCODE"] = _C2BCODE;
            ht["C2MCODE"] = _C2MCODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1030", "UP_ACFIXCLASS2_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    
                    cboC2SAUP.SetValue(DataSet.Tables[0].Rows[0]["C2SAUP"]);
                    let selectEl = document.querySelector("#cboC2BCODE");
                    var objOption = document.createElement("option");
                    for (i = selectEl.length; i >= 0; i--) {
                        selectEl.options[i] = null;
                    }
                    objOption.text = DataSet.Tables[0].Rows[0]["C2BCODE"] + "-" + DataSet.Tables[0].Rows[0]["C2BCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["C2BCODE"];
                    selectEl.options.add(objOption);
                    txtC2MCODE.SetValue(DataSet.Tables[0].Rows[0]["C2MCODE"]);
                    txtC2NAME.SetValue(DataSet.Tables[0].Rows[0]["C2NAME"]);
                    txtC2BIGO.SetValue(DataSet.Tables[0].Rows[0]["C2BIGO"]);
                    cboC2SAUP.SetDisabled(true);
                    cboC2BCODE.SetDisabled(true);
                    txtC2MCODE.SetDisabled(true);

                    if (DataSet.Tables[0].Rows[0]["C3GUBUN"] == "Y") {
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

        // 조회 버튼
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 10000;
            ht["C2SAUP"] = cboSAUP.GetValue();
            ht["C2BCODE"] = cboBCODE.GetValue();
            ht["C2NAME"] = txtMCODENM.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼
        function btnNew_Click()
        {
            cboC2SAUP.SetValue("T");
            cboC2BCODE.SetValue("");
            txtC2MCODE.SetValue("");
            txtC2NAME.SetValue("");
            txtC2BIGO.SetValue("");
            cboC2SAUP.SetDisabled(false);
            cboC2BCODE.SetDisabled(false);
            txtC2MCODE.SetDisabled(false);

            DataGubn = "ADD";

            cboC2SAUP_Change();

            btnDel.Hide();
        }

        // 저장 버튼
        function btnSave_Click() {         

            if (cboC2SAUP.GetValue() == "" || cboC2SAUP.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="사업부를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboC2BCODE.GetValue() == "" || cboC2BCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="대분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtC2NAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="중분류명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["C2SAUP"] = cboC2SAUP.GetValue();
            ht["C2BCODE"] = cboC2BCODE.GetValue();
            
            if (DataGubn == 'ADD') {
                ht["C2MCODE"] = "0";
            }
            else {
                ht["C2MCODE"] = txtC2MCODE.GetValue();
            }
            ht["C2NAME"] = txtC2NAME.GetValue();
            ht["C2BIGO"] = txtC2BIGO.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1030", "UP_ACFIXCLASS2_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        DataGubn = "";
                        _C2SAUP = DataSet.Tables[0].Rows[0]["C2SAUP"];
                        _C2BCODE = DataSet.Tables[0].Rows[0]["C2BCODE"];
                        _C2MCODE = DataSet.Tables[0].Rows[0]["C2MCODE"];

                        UP_DataBind_Run();
                        btnSearch_Click();

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
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

        // 삭제 버튼
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["C2SAUP"] = cboC2SAUP.GetValue();
            ht["C2BCODE"] = cboC2BCODE.GetValue();
            ht["C2MCODE"] = txtC2MCODE.GetValue();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1030", "UP_ACFIXCLASS2_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            btnNew_Click();
                            btnSearch_Click();

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');
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

        // 닫기 버튼
        function btnClose_Click() {

            this.close();            
        }

        // 그리드 선택 이벤트
        function gridClick(r, c) {
            var rw = gridIndex.GetRow(r);

            DataGubn = "";
            _C2SAUP = rw["C2SAUP"];
            _C2BCODE = rw["C2BCODE"];
            _C2MCODE = rw["C2MCODE"];

            UP_DataBind_Run();
        }

        // 사업부 선택 이벤트
        function cboSAUP_Change() {

            var ht = new Object();
            ht["SAUP"] = cboSAUP.GetValue();
            ht["GUBUN"] = "S";
            
            cboBCODE.TypeName = "PSM.PSM1030";
            cboBCODE.MethodName = "UP_GET_BCODE_LIST";
            cboBCODE.DataTextField = "C1CODENAME";
            cboBCODE.DataValueField = "C1CODE";
            cboBCODE.Params(ht);
            cboBCODE.BindList();
            cboBCODE.SetValue("");

            return false;
        }

        function cboC2SAUP_Change()
        {
            var ht = new Object();
            ht["SAUP"] = cboC2SAUP.GetValue();
            ht["GUBUN"] = "";

            if (DataGubn == "ADD") {
                cboC2BCODE.TypeName = "PSM.PSM1030";
                cboC2BCODE.MethodName = "UP_GET_BCODE_LIST";
                cboC2BCODE.DataTextField = "C1CODENAME";
                cboC2BCODE.DataValueField = "C1CODE";
                cboC2BCODE.Params(ht);
                cboC2BCODE.BindList();
                cboC2BCODE.SetValue("");
            }

            return false;
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="설비코드(중분류)" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
            <Ctl:Button ID="btnSearch" runat="server" Style="Orange" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
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
            <table style="width: 100%;">
                <colgroup>
                    <col width="60%" />
                    <col width="*" />
                </colgroup>
                    <tr>
                        <td>
		                    <table class="table_01" style="width:100%;" border="0">
                                <colgroup>
                                    <col width="80px" />
                                    <col width="75px" />
                                    <col width="80px" />
                                    <col width="120" />
                                    <col width="80px" />
                                    <col width="*" />
                                </colgroup>
                                <tr>
                                    <th>
                                        <Ctl:Text ID="lblSAUP" runat="server" LangCode="lblSAUP" Description="사업부"></Ctl:Text>

                                    </th>
                                    <td>                                          
                                       <Ctl:Combo ID="cboSAUP" Width="60px" runat="server" OnChange="cboSAUP_Change();">
                                           <asp:ListItem Selected="True" Text="UTT" Value="T"></asp:ListItem>
                                           <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                                       </Ctl:Combo>
                                    </td>
                                    <th>
                                        <Ctl:Text ID="lblBCODE" runat="server" LangCode="lblBCODE" Description="대분류"></Ctl:Text>
                                    </th>
                                    <td>
                                       <Ctl:Combo ID="cboBCODE" Width="110px" runat="server" ></Ctl:Combo>
                                    </td>
                                    <th>
                                        <Ctl:Text ID="lblMCODE" runat="server" LangCode="lblBCODE" Description="중분류명"></Ctl:Text>
                                    </th>
                                    <td>
                                       <Ctl:TextBox ID="txtMCODENM" Width="200px" runat="server" LangCode="txtMCODENM" Description="중분류명"></Ctl:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td rowspan="2" valign="top">
                            <table class="table_01" style="width:100%;" border="0">
                                <colgroup>
                                    <col width="100px" />
                                    <col width="*" />
                                </colgroup>
                                <tr>
                                    <th>
                                        <Ctl:Text ID="lblC2SAUP" runat="server" LangCode="lblC2SAUP" Description="사업부" Required = "true"></Ctl:Text>

                                    </th>
                                    <td>                                          
                                       <Ctl:Combo ID="cboC2SAUP" Width="60px" runat="server" OnChange="cboC2SAUP_Change();">
                                           <asp:ListItem Selected="True" Text="UTT" Value="T"></asp:ListItem>
                                           <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                                       </Ctl:Combo>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <Ctl:Text ID="lblC2BCODE" runat="server" LangCode="lblC2BCODE" Description="대분류" Required = "true"></Ctl:Text>
                                    </th>
                                    <td>
                                       <Ctl:Combo ID="cboC2BCODE" Width="150px" runat="server" ></Ctl:Combo>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <Ctl:Text ID="lblC2MCODE" runat="server" LangCode="lblC2MCODE" Description="중분류" ></Ctl:Text>
                                    </th>
                                    <td>
                                        <Ctl:TextBox ID="txtC2MCODE" Width="120px" runat="server" LangCode="txtC2MCODE" Description="중분류" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <Ctl:Text ID="lblC2NAME" runat="server" LangCode="lblC2NAME" Description="중분류명" Required = "true"></Ctl:Text>
                                    </th>
                                    <td>
                                        <Ctl:TextBox ID="txtC2NAME" Width="230px" runat="server" LangCode="txtC2NAME" Description="중분류명"></Ctl:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <Ctl:Text ID="lblC2BIGO" runat="server" LangCode="lblC2BIGO" Description="비고" ></Ctl:Text>
                                    </th>
                                    <td>
                                     <Ctl:TextBox ID="txtC2BIGO" runat="server"  Height="80"
                                          ReadMode="false" ReadOnly="false" SetType="text"
                                          Text="" TextMode="MultiLine" Validation="false" Width="280px">
                                     </Ctl:TextBox>
                                </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table style="width: 100%;height:270px;">
                                <colgroup>
                                    <col width="25%" />
                                    <col width="*" />
                                </colgroup>
                                <tr>
                                    <td valign="top">
                                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="420" TypeName="PSM.PSM1030" MethodName="UP_GET_ACFIXCLASS2_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                                            <Ctl:SheetField DataField="C2SAUP" TextField="사업부" Description="사업부" Width="50"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                                            <Ctl:SheetField DataField="C2BCODE" TextField="대분류코드" Description="대분류코드" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                                            <Ctl:SheetField DataField="C2BCODENM" TextField="대분류명" Description="대분류명" Width="120" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                                            <Ctl:SheetField DataField="C2MCODE" TextField="중분류코드" Description="중분류코드" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                                            <Ctl:SheetField DataField="C2NAME" TextField="중분류명" Description="중분류명" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                                        </Ctl:WebSheet>
                                    </td>
                                </tr>
                            </table>     
                        </td>
                    </tr>
                </table>
            
		</Ctl:Layer>

        
	</div>

</asp:content>