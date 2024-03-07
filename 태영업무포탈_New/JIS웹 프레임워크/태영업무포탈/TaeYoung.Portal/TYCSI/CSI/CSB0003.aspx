<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSB0003.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSB0003" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

            // PageLoad시 이벤트 정의부분

            var NUM = "<%= Request.QueryString["NUM"] %>";
            var data = NUM.split('^');

            if (data.length == 8)
            {
                txtIPHANG.SetValue(data[0]);
                txtBONSUN.SetValue(data[1]);
                txtBONSUNNM.SetValue(data[2]);
                txtHWAJU.SetValue(data[3]);
                txtHWAJUNM.SetValue(data[4]);
                txtHWAMUL.SetValue(data[5]);
                txtHWAMULNM.SetValue(data[6]);
                JITANKNO.SetValue(data[7]);

                btnSearch_Click();
            }
            
        }

        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 100000;
            ht["IPHANG"] = txtIPHANG.GetValue().split("-").join("");
            ht["BONSUN"] = txtBONSUN.GetValue();
            ht["HWAJU"] = txtHWAJU.GetValue();
            ht["HWAMUL"] = txtHWAMUL.GetValue();
            ht["JITANKNO"] = JITANKNO.GetValue();
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        function btnClose_Click()
        {
            this.close();
        }

        //그리드 선택한 row 값 부모창에 넘겨주기
        function GridClick(r, c) {

            if (opener) {
               opener.btnPopup_IPTANK_Callback(gridIndex.GetRow(gridIndex.SelectedRow));
               self.close();
            }
            else {
                alert("대상이 없습니다.");
            }
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" LangCode="layer1" Title="매출입고할증 조회" DefaultHide="False">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="270px" />
                    <col width="110px" />
                    <col width="270px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="txtSearchIPHANG" runat="server" LangCode="txtSearchIPHANG" Description="입항일자"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtIPHANG" readonly="true" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="txtSearchBONSUN" runat="server" LangCode="txtSearchBONSUN" Description="본선"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtBONSUN" readonly="true" style="background-color:LightGray" Width="50px" runat="server"></Ctl:TextBox>                    
                        <Ctl:TextBox ID="txtBONSUNNM" readonly="true" style="background-color:LightGray"  Width="200px" runat="server"></Ctl:TextBox>
                    </td>
                    <td rowspan="2" style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                     <Ctl:Button ID="btnClose" runat="server" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();"></Ctl:Button>
                    </td>
                </tr>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="txtSearchHWAJU" runat="server" LangCode="txtSearchHWAJU" Description="화주"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtHWAJU" readonly="true" style="background-color:LightGray" Width="50px" runat="server"></Ctl:TextBox>                    
                        <Ctl:TextBox ID="txtHWAJUNM" readonly="true" style="background-color:LightGray"  Width="200px" runat="server"></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="txtSearchHWAMUL" runat="server" LangCode="txtSearchHWAMUL" Description="화물"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtHWAMUL" readonly="true" style="background-color:LightGray" Width="50px" runat="server"></Ctl:TextBox>                    
                        <Ctl:TextBox ID="txtHWAMULNM" readonly="true" style="background-color:LightGray"  Width="200px" runat="server"></Ctl:TextBox>
                    </td>                    
                </tr>
            </table>        
        </div>
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" HFixation="true" Fixation = "true" Height="420" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_GET_CSB0003_IPTANK_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                <Ctl:SheetField DataField="COTANKNO" TextField="COTANKNO" Description="TANK번호" Width="180"  HAlign="center" Align="left" runat="server" OnClick="GridClick" />
                <Ctl:SheetField DataField="COCONTNO" TextField="COCONTNO" Description="계약번호" Width="250" HAlign="center" Align="left" runat="server" OnClick="GridClick" />
                <Ctl:SheetField DataField="COMTQTY" TextField="COMTQTY" Description="M/T량" DataType="Number" Width="235" HAlign="center" Align="right" runat="server" OnClick="GridClick" />
                <Ctl:SheetField DataField="COKLQTY" TextField="COKLQTY" Description="K/L량" DataType="Number" Width="235" HAlign="center" Align="right" runat="server" OnClick="GridClick" />
                <Ctl:SheetField DataField="COCHQTY" TextField="COCHQTY" Description="출고량" DataType="Number" Width="235" HAlign="right" Align="right" runat="server" OnClick="GridClick" />
                <Ctl:SheetField DataField="JGQTY" TextField="JGQTY" Description="재고량" DataType="Number" Width="239" HAlign="right" Align="right" runat="server" OnClick="GridClick" />
            </Ctl:WebSheet>
            <Ctl:TextBox ID="JITANKNO" Hidden="true" runat="server"></Ctl:TextBox> 
        </Ctl:Layer> 
    </div>
</asp:content>