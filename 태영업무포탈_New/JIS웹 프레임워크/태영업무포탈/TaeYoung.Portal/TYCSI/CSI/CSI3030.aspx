<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI3030.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI3030" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {
            var today = new Date();
            txtJISIDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
        }

        // 조회 버튼
        function btnSearch_Click() {

            if (txtJISIDATE.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="작업일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtGSPINO.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG02" Description="GS-PI NO를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["JIYYMM"] = txtJISIDATE.GetValue();
            ht["JIGSPINO"] = txtGSPINO.GetValue();
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridIndex.CallBack = function () {
                // 편집 이벤트 제거
                // id+row번호+cell번호 : gridCodeList_0_1
                var dt = gridIndex.GetAllRow();
                for (var i = 0; i < ObjectCount(dt.Rows); i++) {
                    if (dt.Rows[i]["CHJISINUM"] != "") {
                        gridIndex.EditModeDisable(i, 4);
                    }
                }
            }

        }

        // 저장버튼
        function btnSave_Click() {

            var hts = new Array();

            var checkRows = gridIndex.GetCheckRow();

            if (txtGSPINO.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG02" Description="GS-PI NO를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtMANAGER.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSave_MSG03" Description="필수 입력 사항입니다. 등록담당자를 입력해주세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (confirm('<Ctl:Text runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                if (checkRows.length > 0) {

                    for (i = 0; i < checkRows.length; i++) {

                        if (checkRows[i]['JICONTNUM'].length != 11) {
                            alert('<Ctl:Text runat="server" Description="컨테이너번호는 11자리입니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                        else {

                            for (j = 0; j < 11; j++) {
                                if (j == 0 || j == 1 || j == 2 || j == 3) {
                                    if (checkRows[i]['JICONTNUM'].substr(j, 1) != "A" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "B" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "C" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "D" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "E" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "F" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "G" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "H" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "I" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "J" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "K" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "L" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "M" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "N" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "O" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "P" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "Q" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "R" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "S" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "T" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "U" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "V" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "W" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "X" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "Y" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "Z") {

                                        alert('<Ctl:Text runat="server" Description="컨테이너번호 1~4자리는 영문 대문자입니다." Literal="true"></Ctl:Text>');
                                        return false;

                                    }
                                }
                                else {
                                    if (checkRows[i]['JICONTNUM'].substr(j, 1) != "0" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "1" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "2" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "3" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "4" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "5" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "6" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "7" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "8" &&
                                        checkRows[i]['JICONTNUM'].substr(j, 1) != "9") {

                                        alert('<Ctl:Text runat="server" Description="컨테이너번호 5~11자리는 숫자입니다." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            var ht = new Object();

                            ht["MANAGER"] = txtMANAGER.GetValue();
                            ht["JIYYMM"] = checkRows[i]['JIYYMM'];
                            ht["JISEQ"] = checkRows[i]['JISEQ'];
                            ht["HJDESC"] = checkRows[i]['HJDESC'];
                            ht["HMDESC1"] = checkRows[i]['HMDESC1'];
                            ht["JICONTNUM"] = checkRows[i]['JICONTNUM'];
                            ht["GSDESC1"] = checkRows[i]['GSDESC1'];
                            ht["JICARNO1"] = checkRows[i]['JICARNO1'];
                            ht["GSPINO"] = checkRows[i]['JIGSPINO'];

                            hts.push(ht);
                        }
                    }

                    PageMethods.InvokeServiceTableArray(ht, hts, "CSI.CSIBiz", "UP_CSI3030_SAVE", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                            if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                                
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                                btnSearch_Click();
                            }
                            else {
                                var msg = DataSet.Tables[0].Rows[0]["MSG"];
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                            }
                        }
                        else {
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG30" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        }
                    }, function (e) {
                        // Biz 연결오류
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG30" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    });
                }
                else {
                    alert("저장할 자료가 없습니다!");
                }
            }
        }

        function btnExcel_Click() {

            if (txtJISIDATE.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="작업일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtGSPINO.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG02" Description="GS-PI NO를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            gridIndex.ExcelDownload("EXCEL.xls");
        }

        function btnChulgo_Click() {
            var NUM = txtJISIDATE.GetValue() + "^" + txtGSPINO.GetValue();

            fn_OpenPopCustom("CSI3031.aspx?NUM=" + NUM, 1600, 900, NUM);
        }

        var winPop;

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
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" LangCode="layer1" Title="컨테이너번호 등록관리" DefaultHide="False">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="210px" />
                    <col width="110px" />
                    <col width="250px" />
                    <col width="110px" />
                    <col width="210px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="lblJISIDATE" runat="server" LangCode="lblJISIDATE" Description="작업일자" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtJISIDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="lblGSPINO" runat="server" LangCode="lblGSPINO" Description="GS-PI NO" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                         <Ctl:TextBox ID="txtGSPINO" Width="240px" runat="server"></Ctl:TextBox>                        
                    </td>
                    <th>
                        <Ctl:Text ID="lblMANAGER" runat="server" LangCode="lblMANAGER" Description="등록담당자"></Ctl:Text>
                    </th>
                    <td>
                         <Ctl:TextBox ID="txtMANAGER" Width="240px" runat="server"></Ctl:TextBox>                        
                    </td>
                    <td style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                        <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                        <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();"></Ctl:Button>
                        <%--<Ctl:Button ID="btnEXCEL" runat="server" LangCode="btnEXCEL" Description="EXCEL" OnClientClick="btnExcel_Click();"></Ctl:Button>--%>
                        <Ctl:Button ID="btnChulgo" runat="server" LangCode="btnEbtnChulgoXCEL" Description="작업내역" OnClientClick="btnChulgo_Click();"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" style="text-align:left;">
                        <Ctl:Text ID="Text1" runat="server" LangCode="Text1" Description=">> 등록 전, 작업화물/목적국/작업수량 필히 확인하시고, 상이 할 경우 담당자에게 즉시 확인 바랍니다." ForeColor="Blue"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" style="text-align:left;">
                        <Ctl:Text ID="Text2" runat="server" LangCode="Text2" Description=">> 컨테이너번호 등록 및 수정만 가능합니다. 저장 후 필히 재확인하세요!!" ForeColor="Blue"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" style="text-align:left;">
                        <Ctl:Text ID="Text3" runat="server" LangCode="Text2" Description=">> 저장 완료된 내역은 담당자에게 자동으로 메일 전송되오니, 차후 문제의 소지가 없도록 정확한 데이터 입력 요청드립니다." ForeColor="Blue"></Ctl:Text>
                    </td>
                </tr>
            </table>        
        </div>
        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" HFixation="false" Height="610" CheckBox="true" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI3030_LIST" UseColumnSort="false" HeaderHeight="20" CellHeight="30" >
                            
                <Ctl:SheetField DataField="JIYYMM"     TextField="JIYYMM"      Description="작업일자"       Width="100" HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="JISEQ"      TextField="JISEQ"       Description="순번"           Width="50"  HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="HJDESC"     TextField="HJDESC"      Description="재고화주"       Width="240" HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="HMDESC1"    TextField="HMDESC1"     Description="화물"           Width="240" HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="JICONTNUM"  TextField="JICONTNUM"   Description="컨테이너번호"   Width="180" HAlign="center"  Align="left"  runat="server" Edit="true" OnClick=""/>
                <Ctl:SheetField DataField="GSDESC1"    TextField="GSDESC1"     Description="목적국"         Width="200" HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="JISTQTY"    TextField="JISTQTY"     Description="지시수량1"      Width="0"   HAlign="center"  Align="right" runat="server" DataType="Number" Hidden="true"/>
                <Ctl:SheetField DataField="JIEDQTY"    TextField="JIEDQTY"     Description="지시수량2"      Width="0"   HAlign="center"  Align="right" runat="server" DataType="Number" Hidden="true"/>
                <Ctl:SheetField DataField="JICARNO1"   TextField="JICARNO1"    Description="지시사항"       Width="370" HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="JIGSPINO"   TextField="JIGSPINO"    Description="GS-PI NO"       Width="180" HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="CHJISINUM"  TextField="CHJISINUM"   Description="지시번호"       Width="0"   HAlign="center"  Align="left"  runat="server" Hidden="true" />
                <Ctl:SheetField DataField="BLANK"      TextField="　"            Description="　"               Width="300" HAlign="center"  Align="left"  runat="server" Hidden="true" />
                <Ctl:SheetField DataField="JITANKNO"   TextField="JITANKNO"    Description="출고TANK"       Width="100" HAlign="center"  Align="left"  runat="server" Hidden="true" />
                <Ctl:SheetField DataField="CHMTQTY"    TextField="CHMTQTY"     Description="출고량"         Width="100" HAlign="center"  Align="right" runat="server" Hidden="true" />
            </Ctl:WebSheet>     
        </Ctl:Layer> 
    </div>
</asp:content>