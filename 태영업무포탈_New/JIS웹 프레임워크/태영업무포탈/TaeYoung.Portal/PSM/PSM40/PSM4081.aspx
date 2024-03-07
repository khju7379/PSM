<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4081.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4081" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var fsPECDATE1 = "";
        var fsPopupGubn = "";

        // 페이지 로드
        function OnLoad() {

            var Num = "<%= Request.QueryString["param"] %>";
            fsPopupGubn = "<%= Request.QueryString["param1"] %>";

            var data = Num.split('^');

            txtPERTCTEAM.SetValue(data[0]);
            txtPERTCDATE.SetValue(data[1]);
            txtPERTCSEQ.SetValue(Set_Fill3(data[2]));
            txtPERDATE.SetValue(data[3]);
            if (data[3] == "") {
                txtPERSEQ.SetValue("");
            }
            else {
                txtPERSEQ.SetValue(data[4]);
            }

            svPERSABUN.SetValue("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>")
            
            UP_DataBind_Run();
        }

        function UP_init() {

            //txtPBMLCODE.SetValue(_PBMLCODE);
            //txtPBMLCODENM.SetValue(_PBMLCODENM);
            //$("#txtPBMLCODENM").attr("style", "font-size:20px;color:black;");

            //// 중분류 조회
            //var ht = new Object();
            //ht["PBMLCODE"] = txtPBMLCODE.GetValue();
            //ht["GUBUN"] = "";

            //cboPBMMCODE.TypeName = "PSM.PSM2010";
            //cboPBMMCODE.MethodName = "UP_GET_PBMMCODE_LIST";
            //cboPBMMCODE.DataTextField = "PBC2NAME";
            //cboPBMMCODE.DataValueField = "PBC2MCODE";
            //cboPBMMCODE.Params(ht);
            //cboPBMMCODE.BindList();

            //cboPBMMCODE_Change();

            //btnDel.Hide();
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["P_PERTCTEAM"] = txtPERTCTEAM.GetValue();
            ht["P_PERTCDATE"] = txtPERTCDATE.GetValue().split("-").join("");
            ht["P_PERTCSEQ"] = txtPERTCSEQ.GetValue();
            ht["P_PERDATE"] = txtPERDATE.GetValue().split("-").join("");
            ht["P_PERSEQ"] = txtPERSEQ.GetValue();

            if (txtPERDATE.GetValue() != "") {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM4080", "UP_EXAM_REPORT_RUN", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        txtPERTCTEAM.SetValue(DataSet.Tables[0].Rows[0]["PERTCTEAM"]);
                        txtPERTCDATE.SetValue(DataSet.Tables[0].Rows[0]["PERTCDATE"]);
                        txtPERTCSEQ.SetValue(Set_Fill3(DataSet.Tables[0].Rows[0]["PERTCSEQ"]));
                        txtPERDATE.SetValue(DataSet.Tables[0].Rows[0]["PERDATE"]);
                        txtPERSEQ.SetValue(DataSet.Tables[0].Rows[0]["PERSEQ"]);

                        fn_Field_SetDisabled(true);

                        btnDel.Hide();
                        btnPrt.Show();
                        fsPECDATE1 = DataSet.Tables[0].Rows[0]["PECDATE1"];

                        if (fsPECDATE1 != "") {
                            btnNew.Hide();
                            btnSave.Hide();
                        }
                        else {
                            btnNew.Show();
                            btnSave.Show();
                        }

                        gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
                        gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                        gridIndex.CallBack = function () {
                            btnNew_Click();
                        }
                        
                    }
                    else {

                        gridIndex.RemoveAllRow();
                        btnDel.Hide();
                        btnPrt.Hide();

                        btnNew_Click();
                    }
                
                }, function (e) {
                    // Biz 연결오류
                    alert("Error");
                });
            }
            else {

                var today = new Date();

                txtPERDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

                gridIndex.RemoveAllRow();
                btnDel.Hide();
                btnPrt.Hide();
            }
        }

        function fn_Field_SetDisabled(bReadOnly) {

            //txtPERTCTEAM.SetDisabled(bReadOnly);
            //txtPERTCDATE.SetDisabled(bReadOnly);
            //txtPERTCSEQ.SetDisabled(bReadOnly);
            txtPERDATE.SetDisabled(bReadOnly);
            txtPERSEQ.SetDisabled(bReadOnly);
        }

        // 신규 버튼 이벤트
        function btnNew_Click() {

            //$("#svPERSABUN_KBSABUN").val("");
            //svPERSABUN.SetValue("");
            txtPERSUBJECTS.SetValue("");
            txtPERRESULTS.SetValue("");
            txtPERCONTENTS.SetValue("");
            txtPERBIGO.SetValue("");
            txtPERNUM.SetValue("");

            btnDel.Hide();

            var gridRows = gridIndex.GetAllRow();

            if (gridRows != null) {
                if (ObjectCount(gridRows.Rows) > 0) {

                    fn_Field_SetDisabled(true);
                }
                else {
                    //txtPERDATE.SetValue("");
                    txtPERSEQ.SetValue("");
                    fn_Field_SetDisabled(false);
                }
            }
            else {
                //txtPERDATE.SetValue("");
                txtPERSEQ.SetValue("");
                fn_Field_SetDisabled(false);
            }
        }

        // 저장 버튼 이벤트
        function btnSave_Click() {
            
            var ht = new Object();

            if (txtPERTCTEAM.GetValue() == "" || txtPERTCDATE.GetValue() == "" || txtPERTCSEQ.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="가동전 점검번호를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPERDATE.GetValue() == "" || txtPERDATE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="보고서 일자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (svPERSABUN.GetValue() == "" || svPERSABUN.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="점검자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPERSUBJECTS.GetValue() == "" || txtPERSUBJECTS.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="점검대상을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPERRESULTS.GetValue() == "" || txtPERRESULTS.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="점검결과를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (confirm('<Ctl:Text ID="MSG02" runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                ht["P_PERTCTEAM"] = txtPERTCTEAM.GetValue();
                ht["P_PERTCDATE"] = txtPERTCDATE.GetValue().split("-").join("");
                ht["P_PERTCSEQ"] = txtPERTCSEQ.GetValue();
                ht["P_PERDATE"] = txtPERDATE.GetValue().split("-").join("");
                ht["P_PERSEQ"] = txtPERSEQ.GetValue();

                if (txtPERNUM.GetValue() == "") {
                    ht["P_PERNUM"] = "0";
                    ht["P_GUBUN"] = "A";
                }
                else {
                    ht["P_PERNUM"] = txtPERNUM.GetValue();
                    ht["P_GUBUN"] = "C";
                }

                ht["P_PERSUBJECTS"] = txtPERSUBJECTS.GetValue();
                ht["P_PERRESULTS"] = txtPERRESULTS.GetValue();
                ht["P_PERSABUN"] = $("#svPERSABUN_KBSABUN").val();
                ht["P_PERCONTENTS"] = txtPERCONTENTS.GetValue();
                ht["P_PERBIGO"] = txtPERBIGO.GetValue();
    
                PageMethods.InvokeServiceTable(ht, "PSM.PSM4080", "UP_EXAM_REPORT_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                                
                            txtPERSEQ.SetValue(DataSet.Tables[0].Rows[0]["MSG"]);
                            UP_DataBind_Run();
                            if (fsPopupGubn == "list") {
                                if (opener != null && typeof (opener.board_popup_callback()) == "function") {
                                    opener.board_popup_callback();
                                }
                            }
                            else {
                                if (opener != null && typeof (opener.btnReport_Callback()) == "function") {
                                    opener.btnReport_Callback();
                                }
                            }
                            alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
                        }
                        else {
                            alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
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

            var ht = new Object();

            if (txtPERTCTEAM.GetValue() == "" || txtPERTCDATE.GetValue() == "" || txtPERTCSEQ.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="가동전 점검번호를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPERDATE.GetValue() == "" || txtPERSEQ.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="보고서 번호를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtPERNUM.GetValue() != "") {

                ht["P_PERTCTEAM"] = txtPERTCTEAM.GetValue();
                ht["P_PERTCDATE"] = txtPERTCDATE.GetValue().split("-").join("");
                ht["P_PERTCSEQ"] = txtPERTCSEQ.GetValue();
                ht["P_PERDATE"] = txtPERDATE.GetValue().split("-").join("");
                ht["P_PERSEQ"] = txtPERSEQ.GetValue();
                ht["P_PERNUM"] = txtPERNUM.GetValue();
            }

            if (confirm('<Ctl:Text runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {
                    
                PageMethods.InvokeServiceTable(ht, "PSM.PSM4080", "UP_EXAM_REPORT_DEL", function (e) {
                    
                    UP_DataBind_Run();
                    if (fsPopupGubn == "list") {
                        if (opener != null && typeof (opener.board_popup_callback()) == "function") {
                            opener.board_popup_callback();
                        }
                    }
                    else {
                        if (opener != null && typeof (opener.btnReport_Callback()) == "function") {
                            opener.btnReport_Callback();
                        }
                    }
                    alert('<Ctl:Text runat="server" Description="삭제가 완료 되었습니다." Literal="true"></Ctl:Text>');
                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 출력 버튼 이벤트
        function btnPrt_Click() {

            fn_OpenPop("../../Common/ReportView.aspx?RPT=PSM4081_RPT&PERTCTEAM=" + txtPERTCTEAM.GetValue() + "&PERTCDATE=" + txtPERTCDATE.GetValue().split("-").join("") +
                "&PERTCSEQ=" + txtPERTCSEQ.GetValue() + "&PERDATE=" + txtPERDATE.GetValue().split("-").join("") + "&PERSEQ =" + txtPERSEQ.GetValue(), 1000, 600);
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {
            
            this.close();            
        }

        // 그리드 선택 이벤트
        function gridClick(r, c) {

            var rw = gridIndex.GetRow(r);

            svPERSABUN.SetValue(rw["PERSABUN"]);
            txtPERSUBJECTS.SetValue(rw["PERSUBJECTS"]);
            txtPERRESULTS.SetValue(rw["PERRESULTS"]);
            txtPERCONTENTS.SetValue(rw["PERCONTENTS"]);
            txtPERBIGO.SetValue(rw["PERBIGO"]);
            txtPERNUM.SetValue(rw["PERNUM"]);

            if (fsPECDATE1 != "") {
                btnDel.Hide();
                btnSave.Hide();
            }
            else {
                btnDel.Show();
                btnSave.Show();
            }
        }

        function Set_Fill3(sFirst) {

            if (sFirst.toString().length == 1) {

                sFirst = "00" + sFirst.toString();
            }
            else if (sFirst.toString().length == 2) {

                sFirst = "0" + sFirst.toString();
            }
            else if (sFirst.toString().length == 3) {
                sFirst = sFirst.toString();
            }
            else {
                sFirst = '000';
            }

            return sFirst;
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="가동전 안전점검 보고서" Literal="true"></Ctl:Text>
        </h4>
        <div class="btn_bx">
            <Ctl:Button ID="btnNew" runat="server" Style="Orange" LangCode="btnNew" Description="신규" OnClientClick="btnNew_Click();" ></Ctl:Button>
		    <Ctl:Button ID="btnSave" runat="server" Style="Orange" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnDel" runat="server" Style="Orange" LangCode="btnDel" Description="삭제" OnClientClick="btnDel_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnPrt" runat="server" Style="Orange" LangCode="btnPrt" Description="출력" OnClientClick="btnPrt_Click();" ></Ctl:Button>
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
                    <col width="130px" />
                    <col width="510px" />
                    <col width="130px" />
                    <col width="510px" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="lblPERTCTEAM" runat="server" LangCode="lblPERTCTEAM" Description="점검번호" ></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtPERTCTEAM" Width ="60px" runat="server" ReadOnly="true"></Ctl:TextBox>
                        <Ctl:Text ID="txtPERTCTEAMNM"  runat="server" Hidden="true"></Ctl:Text>
                        <Ctl:Text ID="Text1" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                        <Ctl:TextBox ID="txtPERTCDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ReadOnly="true"></Ctl:TextBox> 
                        <Ctl:Text ID="Text2" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                        <Ctl:TextBox ID="txtPERTCSEQ" Width ="30px" style ="text-align:right;" runat="server" ReadOnly="true"></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="lblPERDATE" runat="server" LangCode="lblPERDATE" Description="보고서 번호" ></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtPERDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                        <Ctl:Text ID="Text3" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                        <Ctl:TextBox ID="txtPERSEQ" Width="50px" style ="text-align:right;" runat="server" LangCode="txtPERSEQ" ReadOnly="true" PlaceHolder ="자동부여" ></Ctl:TextBox>
                        <Ctl:Text ID="txtPERNUM"  runat="server" Hidden="true"></Ctl:Text>
                    </td>
                </tr>
                <tr style="padding: 2px 0;border-right :hidden;">
                    <td colspan="4" >
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblPERSABUN" runat="server" LangCode="lblPERSABUN" Description="점검자" ></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:SearchView ID="svPERSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                            <Ctl:SearchViewField runat="server" DataField="KBSABUN"   TextField="KBSABUN"   Description="사 번" Hidden="false" TextBox="true" Width="80"   />
                            <Ctl:SearchViewField runat="server" DataField="KBHANGL" TextField="KBHANGL" Description="이 름"     Hidden="false" TextBox="true" Width="80" Default="true"/>                                            
                        </Ctl:SearchView>
                    </td>
                    <th>
                        <Ctl:Text ID="lblPERSUBJECTS" runat="server" LangCode="lblPERSUBJECTS" Description="점검대상" ></Ctl:Text>
                    </th>
                    <td >
                        <Ctl:TextBox ID="txtPERSUBJECTS" Width="100%" runat="server" LangCode="txtPERSUBJECTS" ></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblPERRESULTS" runat="server" LangCode="lblPERRESULTS" Description="점결결과" ></Ctl:Text>
                    </th>
                    <td >
                        <Ctl:TextBox ID="txtPERRESULTS" Width="100%" runat="server" LangCode="txtPERRESULTSs" ></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="lblPERCONTENTS" runat="server" LangCode="lblPERCONTENTS" Description="개선사항" ></Ctl:Text>
                    </th>
                    <td >
                        <Ctl:TextBox ID="txtPERCONTENTS" Width="100%" runat="server" LangCode="txtPERCONTENTS" ></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblPERBIGO" runat="server" LangCode="lblPERBIGO" Description="비고" ></Ctl:Text>
                    </th>
                    <td style="border-right :hidden;">
                        <Ctl:TextBox ID="txtPERBIGO" Width="100%" runat="server" LangCode="txtPERBIGO" ></Ctl:TextBox>
                    </td>
                    <td colspan="2">

                    </td>
                </tr>
                <tr style="padding: 2px 0;border-right :hidden;">
                    <td colspan="4" >
                    </td>
                </tr>
                <tr>
                    <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="480" TypeName="PSM.PSM4080" MethodName="UP_EXAM_REPORT_RUN" UseColumnSort="false" HeaderHeight="10" CellHeight="20">

                        <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="1" Description="번호" Height="20" RowIndex="0" Rowspan="2" TextField="PERNUM" />
                        <Ctl:SheetHeader runat="server" Align="center" ColIndex="1" Colspan="1" Description="점검대상" Height="20" RowIndex="0" Rowspan="2" TextField="PERSUBJECTS" />
                        <Ctl:SheetHeader runat="server" Align="center" ColIndex="2" Colspan="1" Description="점검결과" Height="20" RowIndex="0" Rowspan="2" TextField="PERRESULTS" />
                        <Ctl:SheetHeader runat="server" Align="center" ColIndex="3" Colspan="2" Description="점검자" Height="20" RowIndex="0" Rowspan="1" TextField="PERSABUN" />
                        <Ctl:SheetHeader runat="server" Align="center" ColIndex="5" Colspan="1" Description="개선사항" Height="20" RowIndex="0" Rowspan="2" TextField="PERCONTENTS" />
                        <Ctl:SheetHeader runat="server" Align="center" ColIndex="6" Colspan="1" Description="비고" Height="20" RowIndex="0" Rowspan="2" TextField="PERBIGO" />
                        

                        <Ctl:SheetField DataField="PERNUM" TextField="PERNUM" Description="번호" Width="50" Edit="false" DataType="text" EditType="text" HAlign="center" Align="center" runat="server" OnClick="gridClick" Hidden="false" />
                        <Ctl:SheetField DataField="PERSUBJECTS" TextField="PERSUBJECTS" Description="점검대상" Width="120" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" runat="server" OnClick="gridClick" Hidden="false"/>                            
                        <Ctl:SheetField DataField="PERRESULTS" TextField="PERRESULTS" Description="점검결과" Width="230" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" runat="server" OnClick="gridClick" Hidden="false"/>   
                        <Ctl:SheetField DataField="PERSABUN" TextField="PERSABUN" Description="사번" Width="80" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" runat="server" OnClick="gridClick" Hidden="false"  />
                        <Ctl:SheetField DataField="KBHANGL" TextField="KBHANGL" Description="성명" Width="100" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" runat="server" OnClick="gridClick" Hidden="false"/>
                        <Ctl:SheetField DataField="PERCONTENTS" TextField="PERCONTENTS" Description="개선사항" Width="230" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" runat="server" OnClick="gridClick" Hidden="false"/>
                        <Ctl:SheetField DataField="PERBIGO" TextField="PERBIGO" Description="비고" Width="*" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" runat="server" OnClick="gridClick" Hidden="false" />
                    </Ctl:WebSheet>
                </tr>

            </table>
		</Ctl:Layer>
	</div>
</asp:content>