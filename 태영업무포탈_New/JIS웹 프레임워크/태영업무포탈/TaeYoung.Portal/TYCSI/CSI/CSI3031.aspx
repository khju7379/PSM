<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI3031.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI3031" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

            var NUM = "<%= Request.QueryString["NUM"] %>";
            var data = NUM.split('^');

            if (data[0] != "") {
                txtCHCHULIL.SetValue(data[0]);
            }
            else {
            
                var today = new Date();
                txtCHCHULIL.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            }
            txtGSPINO.SetValue(data[1]);
        }

        // 조회 버튼
        function btnSearch_Click() {

            if (txtCHCHULIL.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="출고일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtGSPINO.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG02" Description="GS-PI NO를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CHCHULIL"] = txtCHCHULIL.GetValue();
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

        function btnExcel_Click() {

            if (txtCHCHULIL.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="출고일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtGSPINO.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG02" Description="GS-PI NO를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            gridIndex.ExcelDownload("EXCEL.xls");
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">

    <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="FLEXI BAG/ISO TANK 작업 출고내역 조회" Literal="true"></Ctl:Text>
        </h4>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

   <div id="content">
        <Ctl:Layer ID="layer1" runat="server">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="210px" />
                    <col width="110px" />
                    <col width="250px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="lblCHCHULIL" runat="server" LangCode="txtCHCHULIL" Description="출고일자" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtCHCHULIL" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="lblGSPINO" runat="server" LangCode="lblGSPINO" Description="GS-PI NO" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                         <Ctl:TextBox ID="txtGSPINO" Width="240px" runat="server" MaxLength="3"></Ctl:TextBox>                        
                    </td>
                    <td style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                        <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                        <Ctl:Button ID="btnEXCEL" runat="server" LangCode="btnEXCEL" Description="EXCEL" OnClientClick="btnExcel_Click();"></Ctl:Button>
                    </td>
                </tr>
            </table>        
        </div>
        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" HFixation="false" Height="610" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI3031_LIST" UseColumnSort="false" HeaderHeight="20" CellHeight="30" >
                            
                <Ctl:SheetField DataField="HMDESC1"     TextField="HMDESC1"      Description="화물명"       Width="140" HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="CHCHULIL"    TextField="CHCHULIL"     Description="출고일자"     Width="80"  HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="CHCHTANK"    TextField="CHCHTANK"     Description="탱크번호"     Width="60" HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="CHBIJUNG"    TextField="CHBIJUNG"     Description="비중"         Width="80" HAlign="center"  Align="right"  runat="server"/>
                <Ctl:SheetField DataField="CHMTQTY"     TextField="CHMTQTY"      Description="출고량(MT)"   Width="80" HAlign="center"  Align="right"  runat="server"/>
                <Ctl:SheetField DataField="CHCONTNUM"   TextField="CHCONTNUM"    Description="컨테이너번호" Width="110" HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="CHSILNUM"    TextField="CHSILNUM"     Description="SEAL번호"     Width="100"   HAlign="center"  Align="left" runat="server"/>
                <Ctl:SheetField DataField="GSDESC1"     TextField="GSDESC1"      Description="목적국"       Width="160" HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="CHCARNO"     TextField="CHCARNO"      Description="차량번호"     Width="70" HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="JIGSPINO"    TextField="JIGSPINO"     Description="GS-PI NO"     Width="160"   HAlign="center"  Align="left"  runat="server" />
                <Ctl:SheetField DataField="JICARNO1"    TextField="JICARNO1"     Description="지시사항"     Width="300" HAlign="center"  Align="left"  runat="server"/>
                <Ctl:SheetField DataField="CHCHSTR"     TextField="CHCHSTR"      Description="입고시간"     Width="70" HAlign="center"  Align="right" runat="server"/>
                <Ctl:SheetField DataField="CHCHEND"     TextField="CHCHEND"      Description="출고시간"     Width="70" HAlign="center"  Align="right" runat="server"/>
                <Ctl:SheetField DataField="CHEMPTY"     TextField="CHEMPTY"      Description="공차"         Width="70" HAlign="center"  Align="right" runat="server"/>
                <Ctl:SheetField DataField="CHTOTAL"     TextField="CHTOTAL"      Description="실차"         Width="70" HAlign="center"  Align="right" runat="server"/>
                <Ctl:SheetField DataField="LTQTY"       TextField="LTQTY"        Description="출고량(L)"    Width="70" HAlign="center"  Align="right" runat="server"/>
                <Ctl:SheetField DataField="DCDESC1"     TextField="DCDESC1"      Description="출고화주명"   Width="140" HAlign="center"  Align="left" runat="server"/>
                <Ctl:SheetField DataField="CHWKTYPE"    TextField="CHWKTYPE"     Description="출고유형"     Width="80" HAlign="center"  Align="left" runat="server"/>
                <Ctl:SheetField DataField="VNSANGHO"    TextField="VNSANGHO"     Description="통관화주"     Width="140" HAlign="center"  Align="left" runat="server"/>
            </Ctl:WebSheet>     
        </Ctl:Layer> 
    </div>
</asp:content>