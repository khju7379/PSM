<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1022.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1022" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _L2SAUP = "";
        var _L2BCODE = "";
        var _L2MCODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            //ht["PageSize"] = 100000;
            ht["L2SAUP"] = "T";
            ht["L2BCODE"] = "";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            DataGubn = "ADD";
            btnDel.Hide();
            cboSAUP_Change();
            cboL2SAUP_Change();
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["L2SAUP"] = _L2SAUP;
            ht["L2BCODE"] = _L2BCODE;
            ht["L2MCODE"] = _L2MCODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1020", "UP_LOCATION_CLASS2_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    
                    cboL2SAUP.SetValue(DataSet.Tables[0].Rows[0]["L2SAUP"]);
                    let selectEl = document.querySelector("#cboL2BCODE");
                    var objOption = document.createElement("option");
                    for (i = selectEl.length; i >= 0; i--) {
                        selectEl.options[i] = null;
                    }
                    objOption.text = DataSet.Tables[0].Rows[0]["L2BCODE"] + "-" + DataSet.Tables[0].Rows[0]["L2BCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["L2BCODE"];
                    selectEl.options.add(objOption);
                    txtL2MCODE.SetValue(DataSet.Tables[0].Rows[0]["L2MCODE"]);
                    txtL2NAME.SetValue(DataSet.Tables[0].Rows[0]["L2NAME"]);
                    txtL2BIGO.SetValue(DataSet.Tables[0].Rows[0]["L2BIGO"]);
                    cboL2SAUP.SetDisabled(true);
                    cboL2BCODE.SetDisabled(true);
                    txtL2MCODE.SetDisabled(true);

                    if (DataSet.Tables[0].Rows[0]["L3GUBUN"] == "Y") {
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
            //ht["PageSize"] = 1;
            ht["L2SAUP"] = cboSAUP.GetValue();
            ht["L2BCODE"] = cboBCODE.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼
        function btnNew_Click()
        {
            cboL2SAUP.SetValue("T");
            cboL2BCODE.SetValue("");
            txtL2MCODE.SetValue("");
            txtL2NAME.SetValue("");
            txtL2BIGO.SetValue("");
            cboL2SAUP.SetDisabled(false);
            cboL2BCODE.SetDisabled(false);
            txtL2MCODE.SetDisabled(false);

            DataGubn = "ADD";

            cboL2SAUP_Change();

            btnDel.Hide();
        }

        // 저장 버튼
        function btnSave_Click() {         

            if (cboL2SAUP.GetValue() == "" || cboL2SAUP.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="사업부를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboL2BCODE.GetValue() == "" || cboL2BCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="대분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtL2NAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="중분류명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["L2SAUP"] = cboL2SAUP.GetValue();
            ht["L2BCODE"] = cboL2BCODE.GetValue();
            
            if (DataGubn == 'ADD') {
                ht["L2MCODE"] = "0";
            }
            else {
                ht["L2MCODE"] = txtL2MCODE.GetValue();
            }
            ht["L2NAME"] = txtL2NAME.GetValue();
            ht["L2BIGO"] = txtL2BIGO.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1020", "UP_LOCATION_CLASS2_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        DataGubn = "";
                        _L2SAUP = DataSet.Tables[0].Rows[0]["L2SAUP"];
                        _L2BCODE = DataSet.Tables[0].Rows[0]["L2BCODE"];
                        _L2MCODE = DataSet.Tables[0].Rows[0]["L2MCODE"];

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

            ht["L2SAUP"] = cboL2SAUP.GetValue();
            ht["L2BCODE"] = cboL2BCODE.GetValue();
            ht["L2MCODE"] = txtL2MCODE.GetValue();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1020", "UP_LOCATION_CLASS2_DEL", function (e) {

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
            _L2SAUP = rw["L2SAUP"];
            _L2BCODE = rw["L2BCODE"];
            _L2MCODE = rw["L2MCODE"];

            UP_DataBind_Run();
        }

        // 사업부 선택 이벤트
        function cboSAUP_Change() {

            var ht = new Object();
            ht["SAUP"] = cboSAUP.GetValue();
            ht["GUBUN"] = "S";
            
            cboBCODE.TypeName = "PSM.PSM1020";
            cboBCODE.MethodName = "UP_GET_LCODE_LIST";
            cboBCODE.DataTextField = "L1CODENAME";
            cboBCODE.DataValueField = "L1CODE";
            cboBCODE.Params(ht);
            cboBCODE.BindList();
            cboBCODE.SetValue("");

            return false;
        }

        function cboL2SAUP_Change()
        {
            var ht = new Object();
            ht["SAUP"] = cboL2SAUP.GetValue();
            ht["GUBUN"] = "";

            if (DataGubn == "ADD") {
                cboL2BCODE.TypeName = "PSM.PSM1020";
                cboL2BCODE.MethodName = "UP_GET_LCODE_LIST";
                cboL2BCODE.DataTextField = "L1CODENAME";
                cboL2BCODE.DataValueField = "L1CODE";
                cboL2BCODE.Params(ht);
                cboL2BCODE.BindList();
                cboL2BCODE.SetValue("");
            }

            return false;
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="위치코드(중분류)" Literal="true"></Ctl:Text>
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
		    <table class="table_01" style="width:100%;" border="0">
                <colgroup>
                    <col width="100px" />
                    <col width="75px" />
                    <col width="100px" />
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
                       <Ctl:Combo ID="cboBCODE" Width="150px" runat="server" ></Ctl:Combo>
                    </td>
                </tr>
            </table>
            <table style="width: 100%;height:270px;">
                <colgroup>
                    <col width="25%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td valign="top" >
                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="200" TypeName="PSM.PSM1020" MethodName="UP_GET_LOCATION_CLASS2_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="L2SAUP" TextField="사업부" Description="사업부" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="L2BCODE" TextField="대분류코드" Description="대분류코드" Width="100"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="L2BCODENM" TextField="대분류명" Description="대분류명" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="L2MCODE" TextField="중분류코드" Description="중분류코드" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="L2NAME" TextField="중분류명" Description="중분류명" Width="200" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="L2BIGO" TextField="비고" Description="비고" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>      
            <table class="table_01" style="width:100%;" border="0">
                <colgroup>
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="lblL2SAUP" runat="server" LangCode="lblL2SAUP" Description="사업부" Required = "true"></Ctl:Text>

                    </th>
                    <td>                                          
                       <Ctl:Combo ID="cboL2SAUP" Width="60px" runat="server" OnChange="cboL2SAUP_Change();">
                           <asp:ListItem Selected="True" Text="UTT" Value="T"></asp:ListItem>
                           <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                       </Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblL2BCODE" runat="server" LangCode="lblL2BCODE" Description="대분류" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:Combo ID="cboL2BCODE" Width="150px" runat="server" ></Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblL2MCODE" runat="server" LangCode="lblL2MCODE" Description="중분류" ></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtL2MCODE" Width="120px" runat="server" LangCode="txtL2MCODE" Description="중분류" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblL2NAME" runat="server" LangCode="lblL2NAME" Description="중분류명" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtL2NAME" Width="230px" runat="server" LangCode="txtL2NAME" Description="중분류명"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblL2BIGO" runat="server" LangCode="lblL2BIGO" Description="비고" ></Ctl:Text>
                    </th>
                    <td>
                     <Ctl:TextBox ID="txtL2BIGO" runat="server"  Height="80"
                          ReadMode="false" ReadOnly="false" SetType="text"
                          Text="" TextMode="MultiLine" Validation="false" Width="500px">
                     </Ctl:TextBox>
                </td>
                </tr>
            </table>
		</Ctl:Layer>

        
	</div>

</asp:content>