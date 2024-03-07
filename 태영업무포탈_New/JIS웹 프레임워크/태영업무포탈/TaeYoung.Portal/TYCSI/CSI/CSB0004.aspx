<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSB0004.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSB0004" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

            // PageLoad시 이벤트 정의부분
            var NUM = "<%= Request.QueryString["NUM"] %>";
            var data = NUM.split('^');

            if (data.length == 2)
            {
                txtHWAJU.SetValue(data[0]);
                txtHWAJUNM.SetValue(data[1]);

                btnSearch_Click();
            }
        }

        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 100000;
            ht["HWAJU"] = txtHWAJU.GetValue();
            
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
               opener.btnPopup_IOTANKNO_Callback(gridIndex.GetRow(gridIndex.SelectedRow));
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
        <Ctl:Layer ID="layer1" runat="server" LangCode="layer1" Title="입고탱크 조회" DefaultHide="False">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="270px" />
                    <col width="*" />
                </colgroup>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="txtSearchHWAJU" runat="server" LangCode="txtSearchHWAJU" Description="화주"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtHWAJU" readonly="true" style="background-color:LightGray" Width="50px" runat="server"></Ctl:TextBox>                    
                        <Ctl:TextBox ID="txtHWAJUNM" readonly="true" style="background-color:LightGray"  Width="200px" runat="server"></Ctl:TextBox>
                    </td>
                    <td style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                     <Ctl:Button ID="btnClose" runat="server" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();"></Ctl:Button>
                    </td>
                </tr>
            </table>        
        </div>
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" HFixation="true" Height="470" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_GET_CSB0004_CUTANKNO_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                <Ctl:SheetField DataField="CUHWAMUL" TextField="CUHWAMUL" Description="화물" Width="100"  HAlign="center" Align="left" runat="server" OnClick="GridClick" />
                <Ctl:SheetField DataField="HMDESC1" TextField="HMDESC1" Description="화물명" Width="200" HAlign="center" Align="left" runat="server" OnClick="GridClick" />
                <Ctl:SheetField DataField="CUTANKNO" TextField="CUTANKNO" Description="탱크번호" Width="100" HAlign="center" Align="left" runat="server" OnClick="GridClick" />
                <Ctl:SheetField DataField="CUDESC" TextField="CUDESC" Description="지시사항" Width="250" HAlign="center" Align="left" runat="server" OnClick="GridClick" />
                <Ctl:SheetField DataField="CUHWAJU" TextField="CUHWAJU" Description="화주" Width="250" HAlign="center" Align="right" runat="server" Hidden="true"/>
                <Ctl:SheetField DataField="VNSANGHO" TextField="VNSANGHO" Description="화주명" Width="250" HAlign="center" Align="right" runat="server" Hidden="true"/>
            </Ctl:WebSheet>
        </Ctl:Layer> 
    </div>
</asp:content>