<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI3010.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI3010" %>

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
            ht["CHHJ"]             = $("#svCHHJ_CDCODE").val();
            ht["CARNO"]            = txtCARNO.GetValue();
            ht["TANKNO"]           = txtTANKNO.GetValue();
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        function btnAdd_Click() {

            fn_OpenPop("CSI3011.aspx?NUM=^", 1400, 650);     
        }


        function btnAdd_Callback(ht) {
            alert(ht["txtCHULDATE"] + "," + ht["txtCHSEQ"]);
        }

        function gridClick(r, c) {
            var dr = gridIndex.GetRow(r)
            var NUM = dr["JIYYMM"] + "^" + dr["JISEQ"];

            fn_OpenPopCustom("CSI3011.aspx?NUM=" + NUM, 1600, 900, NUM);
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
        <Ctl:Layer ID="layer1" runat="server" LangCode="layer1" Title="출고지시 조회" DefaultHide="False">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="200px" />
                    <col width="80px" />
                    <col width="200px" />
                    <col width="80px" />
                    <col width="210px" />
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
                    <th>
                        <Ctl:Text ID="txtYN" runat="server" LangCode="txtYN" Description="도착지"></Ctl:Text>
                    </th>
                    <td>
                          <Ctl:SearchView ID="svCHHJ" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'DC'}" >                       
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
                    <td colspan = "4" >
                        <Ctl:TextBox ID="txtCARNO" runat="server"></Ctl:TextBox>                        
                    </td>
                </tr>
            </table>
        </div>
        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true" Fixation = "true" Height="610" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI3010_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                <Ctl:SheetField DataField="JIYYMM"    TextField="JIYYMM"    Description="출고일자" Width="85" HAlign="center" Align="left"   runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="JISEQ"     TextField="JISEQ"     Description="순번"     Width="50"  HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="HMDESC1"   TextField="HMDESC1"   Description="출고화물" Width="190" HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="DCDESC1"   TextField="DCDESC1"   Description="도착지"   Width="200" HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="JITANKNO"  TextField="JITANKNO"  Description="출고탱크" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="JICHQTY"   TextField="JICHQTY"   Description="출고수량" Width="85"  HAlign="right"  Align="right" runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="JICARNO2"  TextField="JICARNO2"  Description="차량번호" Width="120" HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="JICONTNUM" TextField="JICONTNUM" Description="CONNO"    Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="JITMGUBN"  TextField="JITMGUBN"  Description="특허구분" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="JIWKTYPE"  TextField="JIWKTYPE"  Description="출고유형" Width="90"  HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="JIQTY"     TextField="JIQTY"     Description="지시수량" Width="200" HAlign="right"  Align="right" runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="JISTATUS"  TextField="JISTATUS"  Description="출고상태" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                <Ctl:SheetField DataField="JICARNO1"  TextField="JICARNO1"  Description="지시사항" Width="260" HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>

            </Ctl:WebSheet>      
        </Ctl:Layer> 
    </div>
</asp:content>