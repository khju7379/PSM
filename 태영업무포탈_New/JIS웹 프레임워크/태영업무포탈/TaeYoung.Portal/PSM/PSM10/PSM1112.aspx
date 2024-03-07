<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1112.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1112" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _PBC2NTCODE = "";
        var _PBC2LCODE = "";
        var _PBC2MCODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {           

            UP_Init();
            UP_Get_DataBinding();

            //UP_Get_LCODECombo();

            btnNew_Click();
        }

        function UP_Init() {


            // 게시판 구분 데이터 바인딩
            var ht = new Object();

            ht["P_GUBUN"] = 'S';

            cboNTCODE.TypeName = "PSM.PSM1111";
            cboNTCODE.MethodName = "UP_GET_NTCODE_LIST";
            cboNTCODE.DataTextField = "CODENAME";
            cboNTCODE.DataValueField = "CODE";
            cboNTCODE.Params(ht);
            cboNTCODE.BindList();

            ht = new Object();

            ht["P_GUBUN"] = '';

            cboPBC2NTCODE.TypeName = "PSM.PSM1111";
            cboPBC2NTCODE.MethodName = "UP_GET_NTCODE_LIST";
            cboPBC2NTCODE.DataTextField = "CODENAME";
            cboPBC2NTCODE.DataValueField = "CODE";
            cboPBC2NTCODE.Params(ht);
            cboPBC2NTCODE.BindList();
        }

        // 게시판 구분 선택 이벤트
        function cboNTCODE_Change() {

            var ht = new Object();

            ht["P_PBC1NTCODE"] = cboNTCODE.GetValue();
            ht["P_GUBUN"] = 'S';

            cboLCODE.TypeName = "PSM.PSM1112";
            cboLCODE.MethodName = "UP_GET_LCODE_LIST";
            cboLCODE.DataTextField = "PBC1LCODENAME";
            cboLCODE.DataValueField = "PBC1LCODE";
            cboLCODE.Params(ht);
            cboLCODE.BindList();
        }
        function cboPBC2NTCODE_Change() {

            var ht = new Object();

            ht["P_PBC1NTCODE"] = cboPBC2NTCODE.GetValue();
            ht["P_GUBUN"] = '';

            cboPBC2LCODE.TypeName = "PSM.PSM1112";
            cboPBC2LCODE.MethodName = "UP_GET_LCODE_LIST";
            cboPBC2LCODE.DataTextField = "PBC1LCODENAME";
            cboPBC2LCODE.DataValueField = "PBC1LCODE";
            cboPBC2LCODE.Params(ht);
            cboPBC2LCODE.BindList();
        }

        function UP_Get_DataBinding() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_PBC2NTCODE"] = cboNTCODE.GetValue();
            ht["P_PBC2LCODE"] = cboLCODE.GetValue();
            ht["P_PBC2MCODE"] = '';

            GridMCODE.Params(ht); // 선언한 파라미터를 그리드에 전달함
            GridMCODE.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩         
        }

        //function UP_Get_LCODECombo()
        //{
        //    var ht = new Object();

        //    cboPBC2LCODE.TypeName = "PSM.PSM1112";
        //    cboPBC2LCODE.MethodName = "UP_GET_LCODE_LIST";
        //    cboPBC2LCODE.DataTextField = "PBC1LCODENAME";
        //    cboPBC2LCODE.DataValueField = "PBC1LCODE";
        //    cboPBC2LCODE.Params(ht);
        //    cboPBC2LCODE.BindList();
            

        //    return false;
        //}

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.               

            ht["P_PBC2NTCODE"] = _PBC2NTCODE;
            ht["P_PBC2LCODE"] = _PBC2LCODE;
            ht["P_PBC2MCODE"] = _PBC2MCODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1112", "UP_GET_MCODE_LIST", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {                    

                    cboPBC2NTCODE.SetValue(DataSet.Tables[0].Rows[0]["PBC2NTCODE"]);
                    let selectEl = document.querySelector("#cboPBC2LCODE");
                    var objOption = document.createElement("option");
                    for (i = selectEl.length; i >= 0; i--) {
                        selectEl.options[i] = null;
                    }
                    objOption.text = DataSet.Tables[0].Rows[0]["PBC2LCODE"] + "-" + DataSet.Tables[0].Rows[0]["PBC2LCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["PBC2LCODE"];
                    selectEl.options.add(objOption);
                    /*cboPBC2LCODE.SetValue(DataSet.Tables[0].Rows[0]["PBC2LCODE"]);*/
                    txtPBC2MCODE.SetValue(DataSet.Tables[0].Rows[0]["PBC2MCODE"]);
                    txtPBC2NAME.SetValue(DataSet.Tables[0].Rows[0]["PBC2MCODENM"]);
                    txtPBC2BIGO.SetValue(DataSet.Tables[0].Rows[0]["PBC2BIGO"]);
                    cboPBC2NTCODE.SetDisabled(true);
                    cboPBC2LCODE.SetDisabled(true);
                    txtPBC2MCODE.SetDisabled(true);
                    $("#txtPBC2MCODE").attr("style", "width:50px; background-color: gainsboro;");

                    DataGubn = "";

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

            UP_Get_DataBinding();
        }

        // 신규 버튼
        function btnNew_Click()
        {
            
            txtPBC2MCODE.SetValue("");
            txtPBC2NAME.SetValue("");
            txtPBC2BIGO.SetValue("");

            cboPBC2NTCODE.SetDisabled(false);
            cboPBC2LCODE.SetDisabled(false);
            txtPBC2MCODE.SetDisabled(false);
            $("#txtPBC2MCODE").attr("style", "width:50px;");

            //cboPBC2NTCODE_Change();

            DataGubn = "A";

            btnDel.Hide();
        }

        // 저장 체크 
        function UP_FieldCheck() {

            if (cboPBC2NTCODE.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="게시판 구분을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboPBC2LCODE.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="대분류코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBC2MCODE.GetValue() == "") {
                alert('<Ctl:Text runat="server"  Description="중분류코드를 입려하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBC2MCODE.GetValue().length != 3) {
                alert('<Ctl:Text runat="server" Description="중분류코드는 세자리 입니다." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBC2NAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="중분류명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (DataGubn == "A") {

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["P_PBC2NTCODE"] = cboPBC2NTCODE.GetValue();
                ht["P_PBC2LCODE"] = cboPBC2LCODE.GetValue();
                ht["P_PBC2MCODE"] = txtPBC2MCODE.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1112", "UP_BOARD_CLASS2_SAVECHECK", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                        alert('<Ctl:Text runat="server" Description="동일한 코드가 등록되어 있습니다." Literal="true"></Ctl:Text>');
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

            ht["P_PBC2NTCODE"] = cboPBC2NTCODE.GetValue();
            ht["P_PBC2LCODE"] = cboPBC2LCODE.GetValue();
            ht["P_PBC2MCODE"] = txtPBC2MCODE.GetValue();
            ht["P_PBC2NAME"] = txtPBC2NAME.GetValue();
            ht["P_PBC2BIGO"] = txtPBC2BIGO.GetValue();
            ht["WKGUBUN"] = DataGubn;

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1112", "UP_BOARD_CLASS2_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            _PBC2NTCODE = cboPBC2NTCODE.GetValue();
                            _PBC2LCODE = cboPBC2LCODE.GetValue();
                            _PBC2MCODE = txtPBC2MCODE.GetValue();

                            UP_Get_DataBinding();
                            UP_DataBind_Run();

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
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
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }


        // 저장 버튼
        function btnSave_Click() {

            UP_FieldCheck();
        }

        // 삭제 버튼
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["P_PBC2NTCODE"] = cboPBC2NTCODE.GetValue();
            ht["P_PBC2LCODE"] = cboPBC2LCODE.GetValue();
            ht["P_PBC2MCODE"] = txtPBC2MCODE.GetValue();
            ht["WKGUBUN"] = "D";

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1112", "UP_BOARD_CLASS2_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            btnNew_Click();
                            UP_Get_DataBinding();

                            alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');
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
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }    

        // 그리드 선택 이벤트
        function gridClick(r, c) {

            var rw = GridMCODE.GetRow(r);

            _PBC2NTCODE = rw["PBC2NTCODE"];
            _PBC2LCODE = rw["PBC2LCODE"];
            _PBC2MCODE = rw["PBC2MCODE"];

            UP_DataBind_Run();
        }

           // 닫기 버튼
        function btnClose_Click() {

            this.close();            
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="공정안전자료분류코드(중분류)" Literal="true"></Ctl:Text>
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
                    <col width="230px" />
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="lblNTCODE" runat="server" LangCode="lblNTCODE" Description="게시판 구분"></Ctl:Text>
                    </th>
                    <td>                                          
                       <Ctl:Combo ID="cboNTCODE" Width="230px" runat="server" OnChange="cboNTCODE_Change();"></Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblLCODE" runat="server" LangCode="lblLCODE" Description="대분류"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:Combo ID="cboLCODE" Width="230px" runat="server" >
                           <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                       </Ctl:Combo>
                    </td>
                </tr>
            </table>
            <table style="width: 100%;height:270px;">
                <colgroup>
                    <col width="25%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td valign="top">
                        <Ctl:WebSheet ID="GridMCODE" runat="server" Paging="false" HFixation="true" Fixation = "false" CheckBox="false" Width="100%" Height="200" TypeName="PSM.PSM1112" MethodName="UP_GET_MCODE_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="PBC2NTCODE" TextField="게시판코드" Description="게시판코드" Width="0"  HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true"/>
                            <Ctl:SheetField DataField="PBC2NTCODENM" TextField="게시판 구분" Description="게시판 구분" Width="150"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="PBC2LCODE" TextField="대분류코드" Description="대분류코드" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="PBC2LCODENM" TextField="대분류명" Description="대분류명" Width="230" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />   
                            <Ctl:SheetField DataField="PBC2MCODE" TextField="중분류코드" Description="중분류코드" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="PBC2MCODENM" TextField="중분류명" Description="중분류명" Width="230" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />   
                            <Ctl:SheetField DataField="PBC2BIGO" TextField="비고" Description="비고" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                                                        
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
                        <Ctl:Text ID="lblPBC2NTCODE" runat="server" LangCode="lblPBC2NTCODE" Description="게시판 구분" Required="true"></Ctl:Text>
                    </th>
                    <td>                                    
                        <Ctl:Combo ID="cboPBC2NTCODE" Width="230px" runat="server" OnChange="cboPBC2NTCODE_Change();"></Ctl:Combo>
                    </td>
                </tr>                            
                <tr>
                    <th>
                        <Ctl:Text ID="lblPBC2LCODE" runat="server" LangCode="lblPBC2LCODE" Description="대분류코드" Required="true"></Ctl:Text>
                    </th>
                    <td>                                    
                        <Ctl:Combo ID="cboPBC2LCODE" Width="230px" runat="server" ></Ctl:Combo>
                    </td>
                </tr>                            
                <tr>
                    <th>
                        <Ctl:Text ID="lblPBC2MCODE" runat="server" LangCode="lblPBC2MCODE" Description="중분류코드" Required="true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtPBC2MCODE" Width="50px" runat="server" LangCode="txtPBC2MCODE" Description="중분류코드" SetType="Number" MaxLength="3"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblPBC2NAME" runat="server" LangCode="lblPBC2NAME" Description="중분류명" Required="true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtPBC2NAME" Width="230px" runat="server" LangCode="txtPBC2NAME" Description="중분류명"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblPBC2BIGO" runat="server" LangCode="lblPBC2BIGO" Description="비고" ></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtPBC2BIGO" runat="server"  Height="80"
                            ReadMode="false" ReadOnly="false" SetType="text"
                            Text="" TextMode="MultiLine" Validation="false" Width="250px">
                        </Ctl:TextBox>
                    </td>
                </tr>
            </table>      
		</Ctl:Layer>
	</div>

</asp:content>

