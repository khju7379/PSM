<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4071.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4071" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _Gubn;
        

        // 페이지 로드
        function OnLoad() {

            _Gubn = "<%= Request.QueryString["param"] %>"
            var WKGUBUN = "<%= Request.QueryString["param2"] %>"

            //if (_Gubn == "CHK") {
            cboWKGUBUN.SetValue(WKGUBUN);
            cboWKGUBUN.SetDisabled(true);
            cboPECCGUBUN.SetValue(WKGUBUN);
            cboPECCGUBUN.SetDisabled(true);
            //}

            btnSearch_Click();
            btnNew_Click();
            txtPECCSEQ.SetDisabled(true);
            txtROWCNT.Hide();
            btnRowAdd.Hide();
            btnSave.Hide();

            $("#gridMaster_chkall").attr("style", "display:none;");
        }

        // 조회 버튼
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_PECCGUBUN"] = cboWKGUBUN.GetValue();
            ht["P_PECCDATE"] = txtDATE.GetValue();

            gridMaster.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridMaster.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridMaster.CallBack = function () {

                if (_Gubn == "NEW") {
                    var dt = gridMaster.GetAllRow();
                    var grd_chk = document.getElementsByName("gridMaster_chk");
                    for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                        var dr = dt.Rows[i];

                        gridMaster.SetValue(i, "BTN_SEL", "");

                        grd_chk[i].setAttribute('onclick', 'gridMasterCheck(' + i + ')');
                    }
                }
            }
        }

        // 복사 버튼
        function btnCopy_Click() {

            var checkRows = gridMaster.GetCheckRow();
            var CODE = "";

            if (checkRows.length == 1) {

                CODE = checkRows[0]['PECCGUBUN'] + '^' + checkRows[0]['PECCDATE'] + '^' + checkRows[0]['PECCSEQ'];

                fn_OpenPopCustom("PSM4072.aspx?CODE=" + CODE, 650, 300, CODE);
            }
            else if (checkRows.length > 1) {
                alert('<Ctl:Text runat="server" Description="복사할 자료는 한 건만 선택할 수 있습니다." Literal="true"></Ctl:Text>');
            }
            else {
                alert('<Ctl:Text runat="server" Description="복사할 자료를 선택하세요." Literal="true"></Ctl:Text>');
            }
        }

        // 신규 버튼
        function btnNew_Click() {

            var today = new Date();

            txtPECCDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            txtPECCSEQ.SetValue("");
            
            cboPECCGUBUN.SetDisabled(true);
            txtPECCDATE.SetDisabled(false);

            gridDetail.RemoveAllRow();
            
            btnSave.Show();
            btnDel.Hide();
            btnRowAdd.Show();
            //txtROWCNT.SetDisabled(false);
            txtROWCNT.Show();
        }

        // 저장 버튼
        function btnSave_Click() {
                        
            var hts = new Array();

            var gridRows = gridDetail.GetAllRow();

            if (cboPECCGUBUN.GetValue() == "" || cboPECCGUBUN.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="작업구분을 선택하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPECCDATE.GetValue() == "" || txtPECCDATE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="적용일자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (gridRows == null) {
                alert('<Ctl:Text runat="server" Description="점검항목을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            for (i = 0; i < ObjectCount(gridRows.Rows); i++) {
                var ht = new Object();
                var PECCCHECK = "";
                var dr = gridRows.Rows[i];

                if (dr['PECLEVEL'].length == 0) {
                    alert('<Ctl:Text runat="server" Description="레벨을 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
                else if (dr['PECLEVEL'].length > 1) {
                    alert('<Ctl:Text runat="server" Description="레벨은 한자리만 입력가능합니다." Literal="true"></Ctl:Text>');
                    return false;
                }
                else {
                    if (dr['PECLEVEL'] != "1" &&
                        dr['PECLEVEL'] != "2" &&
                        dr['PECLEVEL'] != "3" &&
                        dr['PECLEVEL'] != "4" &&
                        dr['PECLEVEL'] != "5" &&
                        dr['PECLEVEL'] != "6" &&
                        dr['PECLEVEL'] != "7" &&
                        dr['PECLEVEL'] != "8" &&
                        dr['PECLEVEL'] != "9") {

                        alert('<Ctl:Text runat="server" Description="레벨은 1~9까지 숫자만 입력가능합니다." Literal="true"></Ctl:Text>');
                        return false;
                    }
                }
            }

            if (confirm('<Ctl:Text ID="MSG02" runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                if (ObjectCount(gridRows.Rows) > 0) {
                    
                    for (i = 0; i < ObjectCount(gridRows.Rows); i++) {
                        var ht = new Object();
                        var PECCCHECK = "";
                        var dr = gridRows.Rows[i];

                        ht["P_PECCGUBUN"] = cboPECCGUBUN.GetValue();
                        ht["P_PECCDATE"] = txtPECCDATE.GetValue();
                        ht["P_PECCSEQ"] = txtPECCSEQ.GetValue();

                        ht["P_PECCNUM"] = i + 1;
                        ht["P_PECCDESC"] = dr['PECCDESC'];
                        ht["P_PECLEVEL"] = dr['PECLEVEL'];

                        if (dr['PECCCHECK'] == "▣") {
                            PECCCHECK = "Y";
                        }

                        ht["P_PECCCHECK"] = PECCCHECK;

                        hts.push(ht);
                    }

                    PageMethods.InvokeServiceTableArray(ht, hts, "PSM.PSM4070", "UP_EXAM_CHECK_CONTENTS_ADD", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                            if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                                ht = new Object();
                                
                                ht["P_PECCGUBUN"] = cboPECCGUBUN.GetValue();
                                ht["P_PECCDATE"] = txtPECCDATE.GetValue();
                                ht["P_PECCSEQ"] = DataSet.Tables[0].Rows[0]["MSG"];

                                gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
                                gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                                gridDetail.CallBack = function () {

                                    gridDetailDataChange();
                                }

                                btnDel.Show();
                                btnSearch_Click();

                                alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
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
                else {
                    alert('<Ctl:Text runat="server" Description="저장할 자료가 없습니다!" Literal="true"></Ctl:Text>');
                }
            }
        }

        // 삭제 버튼
        function btnDel_Click() {

            var hts = new Array();
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["P_PECCGUBUN"] = cboPECCGUBUN.GetValue();
            ht["P_PECCDATE"] = txtPECCDATE.GetValue();
            ht["P_PECCSEQ"] = txtPECCSEQ.GetValue();

            hts.push(ht);

            if (confirm('<Ctl:Text ID="MSG03" runat="server" Description="전체내용을 삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTableArray(ht, hts, "PSM.PSM4070", "UP_EXAM_CHECK_CONTENTS_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            btnSearch_Click();
                            btnNew_Click();

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
                    alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 닫기 버튼
        function btnClose_Click() {

            this.close();            
        }

        // 좌측 그리드 체크박스 선택 이벤트
        function gridMasterCheck(r) {

            var dt = gridMaster.GetAllRow();
            var grd_chk = document.getElementsByName("gridMaster_chk");

            for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                var dr = dt.Rows[i];
                var rowId = "gridMaster_MainRow_" + i.toString();

                if (r != i) {
                    grd_chk[i].checked = false;

                    if (i % 2 == 0) {
                        $("#" + rowId).attr("style", "background:rgb(255, 255, 255);");
                    }
                    else {
                        $("#" + rowId).attr("style", "background:rgb(249, 249, 249);");
                    }
                }
                else {
                    $("#" + rowId).attr("style", "background:rgb(234, 234, 234);");
                }
            }

            var rw = gridMaster.GetRow(r);

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["P_PECCGUBUN"] = rw["PECCGUBUN"];
            ht["P_PECCDATE"] = rw["PECCDATE"]
            ht["P_PECCSEQ"] = rw["PECCSEQ"]

            gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridDetail.CallBack = function () {

                gridDetailDataChange();
            }
        }

        // 좌측 그리드 선택 이벤트
        function gridMasterClick(r, c) {

            //var rw = gridMaster.GetRow(r);

            //var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ////alert(rw["PECCSEQ"]);

            //ht["P_PECCGUBUN"] = rw["PECCGUBUN"];
            //ht["P_PECCDATE"] = rw["PECCDATE"]
            //ht["P_PECCSEQ"] = rw["PECCSEQ"]

            //gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            //gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            //gridDetail.CallBack = function () {

            //    gridDetailDataChange();
            //}

            var dt = gridMaster.GetAllRow();
            var grd_chk = document.getElementsByName("gridMaster_chk");

            for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                var dr = dt.Rows[i];

                if (r == i) {
                    grd_chk[i].checked = true;
                }
            }

            gridMasterCheck(r);
        }

        // 좌측 그리드 선택 버튼 이벤트
        function gridSelectClick(r, c) {

            if (opener) {
                opener.btnPopup_Callback(gridMaster.GetRow(r));
                self.close();
            }
            else {
                alert("대상이 없습니다.");
            }
        }

        function gridDetailDataChange() {

            var dt = gridDetail.GetAllRow();
            for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                var dr = dt.Rows[i];

                if (i == 0) {
                    cboPECCGUBUN.SetValue(dr['PECCGUBUN']);
                    txtPECCDATE.SetValue(dr['PECCDATE']);
                    txtPECCSEQ.SetValue(dr['PECCSEQ']);

                    cboPECCGUBUN.SetDisabled(true);
                    txtPECCDATE.SetDisabled(true);

                    if (dr['BTNGUBUN'] == "Y") {
                        btnSave.Hide();
                        btnDel.Hide();
                        btnRowAdd.Hide();
                        //txtROWCNT.SetDisabled(true);
                        txtROWCNT.Hide();
                    }
                    else {
                        btnSave.Show();
                        btnDel.Show();
                        btnRowAdd.Show();
                        //txtROWCNT.SetDisabled(false);
                        txtROWCNT.Show();
                    }
                }

                if (dr['PECCCHECK'] == "Y") {
                    gridDetail.SetValue(i, "PECCCHECK", "▣");
                }
                else {
                    gridDetail.SetValue(i, "PECCCHECK", "□");
                }
            }
        }

        // 우측 그리드 선택 이벤트
        function gridDetailClick(r, c) {


            var rw = gridDetail.GetRow(r);

            // 체크여부 컬럼
            if (c == 3) {

                if (rw["PECCCHECK"] == "▣") {

                    gridDetail.SetValue(r, "PECCCHECK", "□");
                }
                else {

                    gridDetail.SetValue(r, "PECCCHECK", "▣");
                }
            }
            else if (c == 4) {

                var index = parseInt(r) + 1;

                if (index == ObjectCount(gridDetail.GetAllRow().Rows)) {

                    gridDetail.InsertRow();  // 마지막줄에 추가
                    gridDetail.SetValue(ObjectCount(gridDetail.GetAllRow().Rows) - 1, "PECCCHECK", "□");

                    var index = ObjectCount(gridDetail.GetAllRow().Rows) - 1;

                    $("#gridDetail_" + index + "_4_btn").val("추가");
                    $("#gridDetail_" + index + "_5_btn").val("삭제");
                }
                else {
                    gridDetail.InsertAtRow(index);  // 해당 index 뒤에 추가 (첫번째줄 : 1)
                    gridDetail.SetValue(index, "PECCCHECK", "□");

                    $("#gridDetail_" + index + "_4_btn").val("추가");
                    $("#gridDetail_" + index + "_5_btn").val("삭제");
                }
            }
            else if (c == 5) {

                gridDetail.RemoveRows([r]);
            }
        }

        function btnRowAdd_Click() {

            var rowcnt = 0;

            if (txtROWCNT.GetValue() == "") {
                rowcnt = 1;
            }
            else {
                rowcnt = parseInt(txtROWCNT.GetValue());
            }

            for (i = 0; i < rowcnt; i++) {
            
                gridDetail.InsertRow();  // 마지막줄에 추가
                
                gridDetail.SetValue(ObjectCount(gridDetail.GetAllRow().Rows) - 1, "PECCCHECK", "□");

                var index = ObjectCount(gridDetail.GetAllRow().Rows) - 1;

                $("#gridDetail_" + index + "_4_btn").val("추가");
                $("#gridDetail_" + index + "_5_btn").val("삭제");
            }
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="점검표 관리" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
            
                               
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
                    <col width="35%" />
                    <col width="65%" />
                </colgroup>
                <tr>
                    <td valign="top">
                        <table class="table_01" style="width: 100%;">    
                            <colgroup>
                                <col width="80px" />
                                <col width="100px" />
                                <col width="80px" />
                                <col width="100px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblGUBUN" runat="server" LangCode="lblGUBUN" Description="작업구분"></Ctl:Text>
                                </th>
                                <td >
                                    <Ctl:Combo ID="cboWKGUBUN" Width="80px" runat="server">
                                        <asp:ListItem Text="전체"     Value="" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="일반" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="화물" Value="2"></asp:ListItem>
                                    </Ctl:Combo>
                                </td>
                                <th>
                                    <Ctl:Text ID="lblDATE" runat="server" LangCode="lblDATE" Description="적용일자"></Ctl:Text>
                                </th>
                                <td >
                                    <Ctl:TextBox ID="txtDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                                </td>
                                <td style="text-align:right">
                                    <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                                    <Ctl:Button ID="btnCopy" runat="server" LangCode="btnCopy" Description="복사" OnClientClick="btnCopy_Click();"></Ctl:Button>
                                </td>
                            </tr>
                        </table>
                        <Ctl:WebSheet ID="gridMaster" runat="server" Paging="false" CheckBox="true" Width="100%" HFixation="true" Height="630" TypeName="PSM.PSM4070" MethodName="UP_GET_EXAM_CHECK_MENU_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20" >
                            <Ctl:SheetField DataField="PECCGUBUN" TextField="PECCGUBUN" Description="작업구분" Width="100"  HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>
                            <Ctl:SheetField DataField="PECCGUBUNNM" TextField="PECCGUBUNNM" Description="작업구분" Width="80"  HAlign="center" Align="center" runat="server" OnClick="gridMasterClick" />
                            <Ctl:SheetField DataField="PECCDATE" TextField="PECCDATE" Description="적용일자" Width="120" HAlign="center" Align="left" runat="server" OnClick="gridMasterClick" />                            
                            <Ctl:SheetField DataField="PECCSEQ" TextField="PECCSEQ" Description="적용순번" Width="80" HAlign="center" Align="center" runat="server" OnClick="gridMasterClick" />   
                            <Ctl:SheetField DataField="BTN_SEL" TextField="BTN_SEL" Description="선택" Width="80" DataType="Button" HAlign="center" Align="left" runat="server" OnClick="gridSelectClick" />   
                        </Ctl:WebSheet>
                    </td>
                    <td valign="top">
                        <table class="table_01" style="width: 100%;">    
                            <colgroup>
                                <col width="80px" />
                                <col width="100px" />
                                <col width="80px" />
                                <col width="100px" />
                                <col width="80px" />
                                <col width="100px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <td colspan="7" style="text-align:right;height:25px;">
                                    <Ctl:Button ID="btnNew" runat="server" LangCode="btnNew" Description="신규" OnClientClick="btnNew_Click();" ></Ctl:Button>
		                            <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();" ></Ctl:Button>
                                    <Ctl:Button ID="btnDel" runat="server" LangCode="btnDel" Description="삭제" OnClientClick="btnDel_Click();" ></Ctl:Button>
                                    <Ctl:Button ID="btnClose" runat="server" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>     
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblPECCGUBUN" runat="server" LangCode="lblPECCGUBUN" Description="작업구분" Required = "true"></Ctl:Text>
                                </th>
                                <td >
                                    <Ctl:Combo ID="cboPECCGUBUN" Width="80px" runat="server">
                                        <asp:ListItem Text="일반" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="화물" Value="2"></asp:ListItem>
                                    </Ctl:Combo>
                                </td>
                                <th>
                                    <Ctl:Text ID="lblPECCDATE" runat="server" LangCode="lblPECCDATE" Description="적용일자" Required = "true"></Ctl:Text>
                                </th>
                                <td >
                                    <Ctl:TextBox ID="txtPECCDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                                </td>
                            
                                <th>
                                    <Ctl:Text ID="lblPECCSEQ" runat="server" LangCode="lblPECCSEQ" Description="순번" Required = "true"></Ctl:Text>
                                </th>
                                <td >
                                    <Ctl:TextBox ID="txtPECCSEQ" Width="50px" runat="server" style ="text-align:right;" LangCode="txtPECCSEQ" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                                </td>
                                <td style="text-align:right;">
                                    <Ctl:TextBox ID="txtROWCNT" Width="40px" runat="server" LangCode="txtROWCNT" SetType="Number" MaxLength="2"></Ctl:TextBox>
                                    <Ctl:Button ID="btnRowAdd" runat="server" LangCode="btnRowAdd" Description="행추가" OnClientClick="btnRowAdd_Click();" ></Ctl:Button>
                                </td>
                            </tr>
                        </table>
                        <Ctl:WebSheet ID="gridDetail" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="595" TypeName="PSM.PSM4070" MethodName="UP_GET_EXAM_CHECK_CONTENTS_LIST" UseColumnSort="false" HeaderHeight="20" CellHeight="20" >
                            <Ctl:SheetField DataField="PECCNUM" TextField="PECCNUM" Description="번호" Width="60" HAlign="center" Align="left" runat="server" />
                            <Ctl:SheetField DataField="PECCDESC" TextField="PECCDESC" Description="점검내용" Width="*" Edit="true" DataType="text" EditType="text" HAlign="center" Align="left" runat="server" />
                            <Ctl:SheetField DataField="PECLEVEL" TextField="PECLEVEL" Description="레벨" Width="60" Edit="true" DataType="text" EditType="text" HAlign="center" Align="left" runat="server" />
                            <Ctl:SheetField DataField="PECCCHECK" TextField="PECCCHECK" Description="체크여부" Width="80" HAlign="center" Align="center" runat="server" OnClick="gridDetailClick"/>
                            <Ctl:SheetField DataField="ROWADD" TextField="ROWADD" Description="행추가" Width="60" DataType="Button" HAlign="center" Align="left" runat="server" OnClick="gridDetailClick"/>
                            <Ctl:SheetField DataField="ROWDEL" TextField="ROWDEL" Description="행삭제" Width="60" DataType="Button" HAlign="center" Align="left" runat="server" OnClick="gridDetailClick"/>
                            <Ctl:SheetField DataField="BTNGUBUN" TextField="BTNGUBUN" Description="버튼잠금구분" Width="0" Hidden="true" HAlign="center" Align="left" runat="server" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>    
		</Ctl:Layer>
	</div>
</asp:content>