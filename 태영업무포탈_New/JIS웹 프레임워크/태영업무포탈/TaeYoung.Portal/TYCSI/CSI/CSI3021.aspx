<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI3021.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI3021" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    
    <script type="text/javascript">

        var idx = "";
        var state = "init";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

            var NUM = "<%= Request.QueryString["NUM"] %>";
            var data = NUM.split('^');

            if (data.length == 2)
            {
                txtIOIPDATE.SetValue(data[0]);
                txtIOTKNO.SetValue(data[1]);
            }

            if(txtIOTKNO.GetValue() == "")
            {
                btnNew_Click("init");
            }
            else{
                SelectIndex();
                btnSearch_Click();
            }
        }

        function getHeajuCode() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["USERID"] = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";

            PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_GET_HWAJUCODE", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtIOHWAJU.SetValue(DataSet.Tables[0].Rows[0]["EMHWAJU"]);
                    txtVNCODE.SetValue(DataSet.Tables[0].Rows[0]["EMHWAJU"]);
                    txtIOHWAJUNM.SetValue("<%= TaeYoung.Biz.Document.UserInfo.UserName %>");
                    IOHISAB.SetValue(DataSet.Tables[0].Rows[0]["EMSABUN"]);
                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        function SelectIndex() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["IOIPDATE"] = txtIOIPDATE.GetValue();
            ht["IOTKNO"] = txtIOTKNO.GetValue();
            ht["IOHWAJU"] = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";
            
            PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_GET_CSI3021_UTIIPORF_SELECT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtIOHWAJU.SetValue(DataSet.Tables[0].Rows[0]["IOHWAJU"]);        // 입고화주
                    txtIOHWAJUNM.SetValue(DataSet.Tables[0].Rows[0]["VNSANGHO"]);      // 입고화주명
                    txtIOHWAMUL.SetValue(DataSet.Tables[0].Rows[0]["IOHWAMUL"]);       // 입고화물
                    txtHMDESC1.SetValue(DataSet.Tables[0].Rows[0]["HMDESC1"]);        // 입고화물명
                    
                    txtIOTANKNO.SetValue(DataSet.Tables[0].Rows[0]["IOTANKNO"]);       // 입고탱크
                    txtIOIPQTY.SetValue(DataSet.Tables[0].Rows[0]["IOIPQTY"]);        // 입고수량
                    txtIPGOSTATUS.SetValue(DataSet.Tables[0].Rows[0]["JISTATUS"]);     // 입고상태
                    cmbIOWKTYPE.SetValue(DataSet.Tables[0].Rows[0]["IOWKTYPE"]);       // 입고유형
                    $("#svIOCARNO_TRNUMN").val(DataSet.Tables[0].Rows[0]["IOCARNO"]); //차량번호  OK
                    txtIOCONTAIN.SetValue(DataSet.Tables[0].Rows[0]["IOCONTAIN"]);      // 컨테이너 번호
                    txtIOSEALNUM.SetValue(DataSet.Tables[0].Rows[0]["IOSEALNUM"]);      // 씰 번호
                    cmbIOTMGUBN.SetValue(DataSet.Tables[0].Rows[0]["IOTMGUBN"]);       // 특허구분
                    txtIOIPTIME1.SetValue(DataSet.Tables[0].Rows[0]["IPTIME"].substr(0, 2));      // 시간
                    txtIOIPTIME2.SetValue(DataSet.Tables[0].Rows[0]["IPTIME"].substr(2, 2));      // 시간
                    IOHISAB.SetValue(DataSet.Tables[0].Rows[0]["IOHISAB"]);        // 태영담당
                    txtIODESC.SetValue(DataSet.Tables[0].Rows[0]["IODESC"]);         // 지시사항
                    txtVNCODE.SetValue(DataSet.Tables[0].Rows[0]["IOHWAJU"]);   
                    txtJOB.SetValue("C");

                    if(DataSet.Tables[0].Rows[0]["JISTATUS"] != "대 기")
                    {   
                        txtMESSAGE.SetValue("입고지시가 접수되어 수정이 불가합니다.");
                        $("#btnSave").attr("style", "display:none");
                        $("#btnUpt").attr("style", "display:none");
                        $("#btnDel").attr("style", "display:none");
                    }
                    else {
                        txtMESSAGE.SetValue("");
                        $("#btnSave").attr("style", "display:none");
                        $("#btnUpt").attr("style", "display:");
                        $("#btnDel").attr("style", "display:");
                    }
                }
                else{
                    btnNew_Click("");
                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        //코드헬프 팝업 호출
        function btnPopUp_Click() {
            
            var NUM = txtIOHWAJU.GetValue() + "^" + txtIOHWAJUNM.GetValue();

            fn_OpenPop("CSB0004.aspx?NUM=" + NUM, 1400, 650);
        }

        //코드헬프 팝업 선택한 row 받아서 표시
        function btnPopup_IOTANKNO_Callback(ht) {
            
            txtIOHWAJU.SetValue(ht["CUHWAJU"]);   // 화주
            txtIOHWAJUNM.SetValue(ht["VNSANGHO"]);   // 화주명
            txtIOHWAMUL.SetValue(ht["CUHWAMUL"]);   // 화물
            txtHMDESC1.SetValue(ht["HMDESC1"]);   // 화물명
            txtIOTANKNO.SetValue(ht["CUTANKNO"]);   // 입고탱크
        }

        function btnSearch_Click() {

            if (txtIOIPDATE.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="지시일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 10;
            ht["SearchCondition"] = "";

            ht["IPHWAJU"] = HwajuCode;
            ht["SDATE"] = txtIOIPDATE.GetValue();
            ht["EDATE"] = txtIOIPDATE.GetValue();
            ht["HWAMUL"] = "";
            ht["TANKNO"] = "";
            ht["CARNO"] = "";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        function btnNew_Click(gubn)
        {
            if (gubn == "init") {
                var today = new Date();
                txtIOIPDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
                txtIOHWAJU.SetValue("");        // 입고화주
                txtIOHWAJUNM.SetValue("");      // 입고화주명
                txtIOHWAMUL.SetValue("");       // 입고화물
                txtHMDESC1.SetValue("");        // 입고화물명
                txtIOTANKNO.SetValue("");       // 입고탱크
                cmbIOWKTYPE.SetValue("01");       // 입고유형
                IOHISAB.SetValue("");        // 태영담당
                txtVNCODE.SetValue("");

                getHeajuCode();
                btnSearch_Click();
            }
            txtIOTKNO.SetValue("");
            txtIPGOSTATUS.SetValue("");     // 입고상태
            txtIOIPQTY.SetValue("");        // 입고수량
            $("#svIOCARNO_TRNUMN").val(""); //차량번호  OK
            txtIOCONTAIN.SetValue("");      // 컨테이너 번호
            txtIOIPTIME1.SetValue("");      // 시간
            txtIOIPTIME2.SetValue("");      // 시간
            txtIOSEALNUM.SetValue("");      // 씰 번호
            cmbIOCARCNT.SetValue("1");        // 지시대수
            txtIODESC.SetValue("");         // 지시사항
            cmbIOTMGUBN.SetValue("1");       // 특허구분
            txtJOB.SetValue("A");
            txtMESSAGE.SetValue("");

            $("#btnSave").attr("style", "display:");
            $("#btnUpt").attr("style", "display:none");
            $("#btnDel").attr("style", "display:none");
        }

        function btnSave_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            
            var IOTMGUBNNM = "";
            var sCONTNUM = "";

            if(txtIOIPDATE.GetValue() == "")
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="지시 일자를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtIOTANKNO.GetValue() == "")
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG04" Description="입고 탱크번호를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtIOIPQTY.GetValue() == 0 || txtIOIPQTY.GetValue() == "")
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG05" Description="입고수량을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (cmbIOWKTYPE.GetValue() == "" || cmbIOWKTYPE.GetValue() == null)
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG06" Description="입고 유형을 선택하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (cmbIOWKTYPE.GetValue() == "01")
            {
                if ($("#svIOCARNO_TRNUMN").val() == "")
                {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG07" Description="차량번호를 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }
            else{

                if (txtIOCONTAIN.GetValue() == "")
                {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG08" Description="컨테이너 번호를 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
                else{
                    if (txtIOCONTAIN.GetValue().length != 11)
                    {   
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG09" Description="컨테이너 번호 자릿수는 11자리입니다." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else{
                        sCONTNUM = txtIOCONTAIN.GetValue().toUpperCase();

                        for (var i = 0; i < 11; i++)
                        {
                            if (i == 0 || i == 1 || i == 2 || i == 3)
                            {
                                if (sCONTNUM.substr(i, 1) != "A" &&
                                    sCONTNUM.substr(i, 1) != "B" &&
                                    sCONTNUM.substr(i, 1) != "C" &&
                                    sCONTNUM.substr(i, 1) != "D" &&
                                    sCONTNUM.substr(i, 1) != "E" &&
                                    sCONTNUM.substr(i, 1) != "F" &&
                                    sCONTNUM.substr(i, 1) != "G" &&
                                    sCONTNUM.substr(i, 1) != "H" &&
                                    sCONTNUM.substr(i, 1) != "I" &&
                                    sCONTNUM.substr(i, 1) != "J" &&
                                    sCONTNUM.substr(i, 1) != "K" &&
                                    sCONTNUM.substr(i, 1) != "L" &&
                                    sCONTNUM.substr(i, 1) != "M" &&
                                    sCONTNUM.substr(i, 1) != "N" &&
                                    sCONTNUM.substr(i, 1) != "O" &&
                                    sCONTNUM.substr(i, 1) != "P" &&
                                    sCONTNUM.substr(i, 1) != "Q" &&
                                    sCONTNUM.substr(i, 1) != "R" &&
                                    sCONTNUM.substr(i, 1) != "S" &&
                                    sCONTNUM.substr(i, 1) != "T" &&
                                    sCONTNUM.substr(i, 1) != "U" &&
                                    sCONTNUM.substr(i, 1) != "V" &&
                                    sCONTNUM.substr(i, 1) != "W" &&
                                    sCONTNUM.substr(i, 1) != "X" &&
                                    sCONTNUM.substr(i, 1) != "Y" &&
                                    sCONTNUM.substr(i, 1) != "Z")
                                {   
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG10" Description="컨테이너 번호 1~4자리까지는 알파벳입니다. 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                            else
                            {

                                if (sCONTNUM.substr(i, 1) != "0" &&
                                    sCONTNUM.substr(i, 1) != "1" &&
                                    sCONTNUM.substr(i, 1) != "2" &&
                                    sCONTNUM.substr(i, 1) != "3" &&
                                    sCONTNUM.substr(i, 1) != "4" &&
                                    sCONTNUM.substr(i, 1) != "5" &&
                                    sCONTNUM.substr(i, 1) != "6" &&
                                    sCONTNUM.substr(i, 1) != "7" &&
                                    sCONTNUM.substr(i, 1) != "8" &&
                                    sCONTNUM.substr(i, 1) != "9")
                                {
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG11" Description="컨테이너 번호 5~11자리까지는 숫자입니다. 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }
                    }
                }
            }

            if (cmbIOTMGUBN.GetValue() == "" || cmbIOTMGUBN.GetValue() == null)
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG12" Description="특허 구분을 선택하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            
            if (cmbIOTMGUBN.GetValue() == "1") {
                IOTMGUBNNM = "일반";
            }
            else if (cmbIOTMGUBN.GetValue() == "2") {
                IOTMGUBNNM = "조출";
            }
            else if (cmbIOTMGUBN.GetValue() == "3") {
                IOTMGUBNNM = "특허";
            }

            ht["Job"] = txtJOB.GetValue();
            ht["IOIPDATE"] = txtIOIPDATE.GetValue();
            ht["IOTKNO"] = txtIOTKNO.GetValue();
            ht["IOHWAJU"] = txtIOHWAJU.GetValue();
            ht["IOHWAJUNM"] = txtIOHWAJUNM.GetValue();
            ht["IOHWAMUL"] = txtIOHWAMUL.GetValue();
            ht["IOHWAMULNM"] = txtHMDESC1.GetValue();
            ht["IOTANKNO"] = txtIOTANKNO.GetValue();
            ht["IOIPQTY"] = txtIOIPQTY.GetValue();
            ht["IOWKTYPE"] = cmbIOWKTYPE.GetValue();
            ht["IOCARNO"] = $("#svIOCARNO_TRNUMN").val();
            ht["IOCONTAIN"] = sCONTNUM;
            ht["IOSEALNUM"] = txtIOSEALNUM.GetValue();
            ht["IOTMGUBN"] = cmbIOTMGUBN.GetValue();
            ht["IOTMGUBNNM"] = IOTMGUBNNM;
            ht["IOIPTIME1"] = txtIOIPTIME1.GetValue();
            ht["IOIPTIME2"] = txtIOIPTIME2.GetValue();
            ht["IODESC"] = txtIODESC.GetValue();
            ht["IOHISAB"] = IOHISAB.GetValue();
            ht["VNCODE"] = txtVNCODE.GetValue();
            ht["IOCARCNT"] = cmbIOCARCNT.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG02" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_CSI3021_SAVE", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {
                          
                        if(DataSet.Tables[0].Rows[0]["STATE"] == "OK")
                        {
                            txtIOTKNO.SetValue(DataSet.Tables[0].Rows[0]["IOTKNO"]);
                            SelectIndex();
                            btnSearch_Click();
                        }
                        var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG14" Description="' + msg + '" Literal="true"></Ctl:Text>');
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG15" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG15" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        function btnDel_Click()
        {
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["Job"] = "D";
            ht["IOIPDATE"] = txtIOIPDATE.GetValue();
            ht["IOTKNO"] = txtIOTKNO.GetValue();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG03" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {
                PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_CSI3021_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {
                    
                        if(DataSet.Tables[0].Rows[0]["STATE"] == "OK")
                        {
                            btnNew_Click("");
                            btnSearch_Click();
                        }
                        var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG17" Description="' + msg + '" Literal="true"></Ctl:Text>');
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG16" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG16" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        function btnClose_Click() {

            this.close();
            //return false;
        }

        function GridClick(r, c) {

            var rows = gridIndex.GetRow(gridIndex.SelectedRow);

            txtIOIPDATE.SetValue(rows["IOIPDATE"]);
            txtIOTKNO.SetValue(rows["IOTKNO"]);

            SelectIndex();
        }

        function btnPatent_Click() {
            fn_OpenPop("CSB0007.aspx", 520, 260);
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="입고지시관리 등록" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
            <Ctl:Button ID="btnSearch" runat="server" Style="Orange" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
            <Ctl:Button ID="btnNew" runat="server" Style="Orange" LangCode="btnNew" Description="신규" OnClientClick="btnNew_Click('');" ></Ctl:Button>
		    <Ctl:Button ID="btnSave" runat="server" Style="Orange" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnUpt" runat="server" Style="Orange" LangCode="btnUpt" Description="수정" OnClientClick="btnSave_Click();" ></Ctl:Button>
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
                    <col style="width:10%;" />
                    <col style="width:15%;" />
                    <col style="width:10%;" />
                    <col style="width:15%;" />
                    <col style="width:10%;" />
                    <col style="width:15%;" />
                </colgroup>
            <tr>
                <th><Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="입고일자" Required = "true"></Ctl:Text></th>
                <td colspan="5">
                     
                     <Ctl:TextBox ID="txtIOIPDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ></Ctl:TextBox>
                     <Ctl:TextBox ID="txtIOTKNO" readonly="true" style="background-color:LightGray" Width="50px" runat="server"></Ctl:TextBox>
                </td>
            </tr>
            <tr>
                <th><Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="입고화주" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtIOHWAJU" Width="50px" runat="server"></Ctl:TextBox>                    
                    <img src="/Resources/Images/btn_search.gif" ID="btnIPGO" alt="입고화주조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click();"  />
                    <Ctl:TextBox ID="txtIOHWAJUNM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
                <th><Ctl:Text ID="TXT08" runat="server" LangCode="TXT08" Description="입고화물"></Ctl:Text></th>
                <td><Ctl:TextBox ID="txtHMDESC1" readonly="true" style="background-color:LightGray" Width="220px" runat="server"></Ctl:TextBox></td>
                <th><Ctl:Text ID="TXT14" runat="server" LangCode="TXT14" Description="입고상태"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtIPGOSTATUS" readonly="true" style="background-color:LightGray" runat="server"></Ctl:TextBox>
                </td>
            </tr>
             <tr>
                <th><Ctl:Text ID="TXT11" runat="server" LangCode="TXT11" Description="입고탱크" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtIOTANKNO" readonly="true" Width="80" runat="server"></Ctl:TextBox>
                </td>
                <th><Ctl:Text ID="TXT18" runat="server" LangCode="TXT18" Description="입고수량" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtIOIPQTY" Width="80" style="text-align:right" runat="server" SetType="Number"></Ctl:TextBox>  
                </td>
            </tr>  
            
             <tr>
                <th><Ctl:Text ID="TXT17" runat="server" LangCode="TXT17" Description="입고유형" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:Combo ID="cmbIOWKTYPE" runat="server" RepeatColumns="2">
                            <asp:ListItem Selected="True" Text="TANK LORRY" Value="01"></asp:ListItem>
                            <asp:ListItem Text="ISO TANK" Value="02"></asp:ListItem>
                            <asp:ListItem Text="FLEXI BAG" Value="03"></asp:ListItem>
                    </Ctl:Combo>
                </td>
                <th><Ctl:Text ID="TXT16" runat="server" LangCode="TXT16" Description="차량번호"></Ctl:Text></th>
                <td>
                    <Ctl:SearchView ID="svIOCARNO" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_CARNO_LIST" >                       
                       <Ctl:SearchViewField DataField="TRNUMN" TextField="TRNUMN" Description="차량번호" Hidden="false" Width="120" TextBox="true" Default="true" runat="server" />
                       <Ctl:SearchViewField DataField="SOSOK" TextField="SOSOK" Description="차량소속" Hidden="false" Width="130" TextBox="false" runat="server" />
                    </Ctl:SearchView>
                    <Ctl:Text ID="TXTIOCARNO" runat="server" LangCode="TXTIOCARNO" style="color:red" Description="(예시) 2555 / 차량뒷번호4자리"></Ctl:Text>
                </td>
                <th><Ctl:Text ID="TXT20" runat="server" LangCode="TXT20" Description="컨테이너 NO"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtIOCONTAIN" runat="server" maxlength="11"></Ctl:TextBox>  
                </td>
            </tr>    
            <tr>
                <th><Ctl:Text ID="TXT21" runat="server" LangCode="TXT21" Description="특허구분" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:Combo ID="cmbIOTMGUBN" runat="server" RepeatColumns="2">
                            <asp:ListItem Selected="True" Text="일반" Value="1"></asp:ListItem>
                            <asp:ListItem Text="조출" Value="2"></asp:ListItem>
                            <asp:ListItem Text="특허" Value="3"></asp:ListItem>
                    </Ctl:Combo>
                    <Ctl:Button ID="btnPatent" runat="server" Style="Orange" LangCode="btnPatent" Description="할증시간안내" OnClientClick="btnPatent_Click();" ></Ctl:Button>
                </td>
                <th><Ctl:Text ID="TXT22" runat="server" LangCode="TXT22" Description="시간"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtIOIPTIME1" Width="40" runat="server" maxlength="2" SetType="Number"></Ctl:TextBox>  
                    <Ctl:Text runat="server" Description=":"></Ctl:Text> 
                    <Ctl:TextBox ID="txtIOIPTIME2" Width="40" runat="server" maxlength="2" SetType="Number"></Ctl:TextBox>  
                </td>
                <th><Ctl:Text ID="TXT26" runat="server" LangCode="TXT26" Description="씰 번호"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtIOSEALNUM" runat="server" Width="220px"></Ctl:TextBox>  
                </td>
            </tr>  
                <th><Ctl:Text ID="TXT29" runat="server" LangCode="TXT29" Description="지시대수" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:Combo ID="cmbIOCARCNT" Width="60" runat="server" RepeatColumns="2">
                            <asp:ListItem Selected="True" Text="1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                            <asp:ListItem Text="6" Value="6"></asp:ListItem>
                            <asp:ListItem Text="7" Value="7"></asp:ListItem>
                            <asp:ListItem Text="8" Value="8"></asp:ListItem>
                            <asp:ListItem Text="9" Value="9"></asp:ListItem>
                            <asp:ListItem Text="10" Value="10"></asp:ListItem>
                    </Ctl:Combo>
                </td>
                <th><Ctl:Text ID="TXT25" runat="server" LangCode="TXT25" Description="지시사항"></Ctl:Text></th>
                <td colspan="3">
                    <Ctl:TextBox ID="txtIODESC" Width="450" runat="server"></Ctl:TextBox>  
                </td>

            <tr>
                <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation = "true" Height="450" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI3020_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                    <Ctl:SheetField DataField="IOIPDATE"  TextField="IOIPDATE"  Description="입고일자"       Width="100" HAlign="left"  Align="left"  runat="server" OnClick="GridClick"/>
                    <Ctl:SheetField DataField="IOTKNO"    TextField="IOTKNO"    Description="순번"           Width="50"  HAlign="left"  Align="left"  runat="server" OnClick="GridClick"/>
                    <Ctl:SheetField DataField="HMDESC1"   TextField="HMDESC1"   Description="입고화물"       Width="210" HAlign="left"  Align="left"  runat="server" OnClick="GridClick"/>
                    <Ctl:SheetField DataField="IOTANKNO"  TextField="IOTANKNO"  Description="입고탱크"       Width="90"  HAlign="left"  Align="left"  runat="server" OnClick="GridClick"/>
                    <Ctl:SheetField DataField="IOIPQTY"   TextField="IOIPQTY"   Description="입고수량(MT)"   Width="150" HAlign="right" Align="right" runat="server" DataType="Number" OnClick="GridClick"/>
                    <Ctl:SheetField DataField="CJIPQTY"   TextField="CJIPQTY"   Description="실입고수량(MT)" Width="150" HAlign="right" Align="right" runat="server" DataType="Number" OnClick="GridClick"/>
                    <Ctl:SheetField DataField="IOCARNO"   TextField="IOCARNO"   Description="차량번호"       Width="120" HAlign="left"  Align="left"  runat="server" OnClick="GridClick"/>
                    <Ctl:SheetField DataField="IOCONTAIN" TextField="IOCONTAIN" Description="CON NO"         Width="150" HAlign="left"  Align="left"  runat="server" OnClick="GridClick"/>
                    <Ctl:SheetField DataField="IOTMGUBNM" TextField="IOTMGUBNM" Description="특허구분"       Width="120" HAlign="left"  Align="left"  runat="server" OnClick="GridClick"/>
                    <Ctl:SheetField DataField="IOWKTYPE"  TextField="IOTMGUBNM" Description="입고유형"       Width="120" HAlign="left"  Align="left"  runat="server" OnClick="GridClick"/>
                    <Ctl:SheetField DataField="JISTATUS"  TextField="JISTATUS"  Description="상태"           Width="110" HAlign="left"  Align="left"  runat="server" OnClick="GridClick"/>
                    <Ctl:SheetField DataField="IODESC"    TextField="IODESC"    Description="지시사항"       Width="300" HAlign="left"  Align="left"  runat="server" OnClick="GridClick"/>

                </Ctl:WebSheet>     
            </tr>
            <tr>
                
                <td colspan="6">
                    <Ctl:TextBox ID="txtMESSAGE" style="width:100%;color:red;text-align:center" readonly="true" runat="server"></Ctl:TextBox>
                </td>
            </tr>
            <Ctl:TextBox ID="txtIOHWAMUL" Hidden="true" runat="server"></Ctl:TextBox>
            <Ctl:TextBox ID="txtVNCODE" Hidden="true" runat="server"></Ctl:TextBox>
            <Ctl:TextBox ID="txtJOB" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="IOHISAB" Hidden="true" runat="server"></Ctl:TextBox>  
            </table>
		</Ctl:Layer>
        
	</div>

</asp:content>