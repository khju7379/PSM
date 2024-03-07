<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI3020.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI3020" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {
            var today = new Date();
            txtFRDate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            today.setDate(today.getDate() + 6);
            txtTODate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
        }

        function btnSearch_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="조회일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"]         = 15;
            ht["SearchCondition"]  = "";

            ht["IPHWAJU"]          = HwajuCode;
            ht["SDATE"]            = txtFRDate.GetValue();
            ht["EDATE"]            = txtTODate.GetValue();
            ht["HWAMUL"]           = $("#svHWAMUL_CDCODE").val();
            ht["TANKNO"]           = txtTANKNO.GetValue();
            ht["CARNO"]            = txtCARNO.GetValue();
            

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

//        function btnAdd_Click() {

//            fn_OpenPop("CSI3021.aspx?NUM=^", 1400, 650);
//        }

        function gridClick(r, c) {
            var dr = gridIndex.GetRow(r)
            var NUM = dr["IOIPDATE"] + "^" + dr["IOTKNO"];

            fn_OpenPopCustom("CSI3021.aspx?NUM=" + NUM, 1600, 900, NUM);
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
        <Ctl:Layer ID="layer1" runat="server" LangCode="layer1" Title="입고지시 조회" DefaultHide="False">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="200px" />
                    <col width="80px" />
                    <col width="200px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="조회일자 (Fr~To)"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtFRDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                        <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="txtHWAMUL" runat="server" LangCode="txtHWAMUL" Description="화 물"></Ctl:Text>
                    </th>
                    <td>
                         <Ctl:SearchView ID="svHWAMUL" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_HWAMUL_LIST" Params="{'INDEX':'HM', 'IPHWAJU':HwajuCode }" >   
                              <Ctl:SearchViewField DataField="CDCODE" TextField="CDCODE" Description="코드" Hidden="false" Width="50" TextBox="true"  runat="server" />
                              <Ctl:SearchViewField DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" Width="130" TextBox="true" Default="true" runat="server" />
                         </Ctl:SearchView>
                    </td>
                    <td style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>                     
                    </td>
                </tr>
                 <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="txtSearchTANKNO" runat="server" LangCode="txtSearchTANKNO" Description="탱크번호"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtTANKNO" runat="server"></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="txtSearchCARNO" runat="server" LangCode="txtSearchCARNO" Description="차량번호"></Ctl:Text>
                    </th>
                    <td colspan = "2" >
                        <Ctl:TextBox ID="txtCARNO" runat="server"></Ctl:TextBox>                        
                    </td>
                </tr>
            </table>        
        </div>
        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation = "true" Height="610" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI3020_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                <Ctl:SheetField DataField="IOIPDATE"  TextField="IOIPDATE"  Description="입고일자"       Width="100" HAlign="left"  Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="IOTKNO"    TextField="IOTKNO"    Description="순번"           Width="50"  HAlign="left"  Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="HMDESC1"   TextField="HMDESC1"   Description="입고화물"       Width="210" HAlign="left"  Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="IOTANKNO"  TextField="IOTANKNO"  Description="입고탱크"       Width="90"  HAlign="left"  Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="IOIPQTY"   TextField="IOIPQTY"   Description="입고수량(MT)"   Width="150" HAlign="right" Align="right" runat="server" DataType="Number" OnClick="gridClick"/>
                <Ctl:SheetField DataField="CJIPQTY"   TextField="CJIPQTY"   Description="실입고수량(MT)" Width="150" HAlign="right" Align="right" runat="server" DataType="Number" OnClick="gridClick"/>
                <Ctl:SheetField DataField="IOCARNO"   TextField="IOCARNO"   Description="차량번호"       Width="120" HAlign="left"  Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="IOCONTAIN" TextField="IOCONTAIN" Description="CON NO"         Width="150" HAlign="left"  Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="IOTMGUBNM" TextField="IOTMGUBNM" Description="특허구분"       Width="120" HAlign="left"  Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="IOWKTYPE"  TextField="IOTMGUBNM" Description="입고유형"       Width="120" HAlign="left"  Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="JISTATUS"  TextField="JISTATUS"  Description="상태"           Width="110" HAlign="left"  Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="IODESC"    TextField="IODESC"    Description="지시사항"       Width="300" HAlign="left"  Align="left"  runat="server" OnClick="gridClick"/>

            </Ctl:WebSheet>     
        </Ctl:Layer> 
    </div>
</asp:content>