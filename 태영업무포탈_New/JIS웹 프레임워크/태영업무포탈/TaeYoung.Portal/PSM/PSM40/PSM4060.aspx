<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4060.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4060" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    
    
    <script type="text/javascript">        

        // 페이지 로드
        function OnLoad() {

            var today = new Date();
            txtFRDate.SetValue(CalLpad(today.getFullYear() - 1) + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            txtTODate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

            btnSearch_Click();
        }

        // 조회 버튼 이벤트
        function btnSearch_Click() {

            var ht = new Object(); 

            ht["P_SDATE"]  = txtFRDate.GetValue();
            ht["P_EDATE"] = txtTODate.GetValue();          

            grdOutWorkList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grdOutWorkList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩            
        }

        //신규 버튼
        function btnNew_Click() {

            var param = "";

            //fn_OpenPop("PSM4061.aspx?param=" + param, 1050, 650);

            fn_OpenPopCustom("PSM4061.aspx?param=" + param, 1050, 650);
        }

        //작업요청서 그리드 선택 이벤트
        function grdOutWorClick(r, c)
        {            
            var rw = grdOutWorkList.GetRow(r);            

            //fn_OpenPop("PSM4061.aspx?param=" + rw["OS_NUM"], 1050, 650);

            fn_OpenPopCustom("PSM4061.aspx?param=" + rw["OS_NUM"], 1050, 650);
        }

        function btnSearch_Callback(){
             btnSearch_Click();
        }

      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="외주공사 조회" DefaultHide="False">
            <!-- 상단의 버튼을 정의 -->
            <div class="btn_bx" style="padding-bottom:0px;">
                <table class="table_01" style="width: 100%;">    
                    <colgroup>
                        <col width="70px" />
                        <col width="220px" />
                        <col width="*" />
                    </colgroup>
                    <tr style="text-align:left;">                       
                        <th>
                            <Ctl:Text ID="lblData" runat="server" Required="true" LangCode="lblData" Description="작업일자" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtFRDate"  runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                            <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                        </td>                       
                        <td style="text-align:right;">
                            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                            <Ctl:Button ID="btnNew" runat="server" LangCode="btnNew" Description="신규" OnClientClick="btnNew_Click();"></Ctl:Button>
                        </td>
                    </tr>
                </table>
            </div>        

            <table style="width: 100%;">
                <colgroup>
                    <col width="25%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td valign="top">
                        <Ctl:WebSheet ID="grdOutWorkList" runat="server" Paging="true" CheckBox="false"   Width="100%" TypeName="PSM.PSM4060" MethodName="UP_Get_OutWork_LIST" UseColumnSort="true" HeaderHeight="10" CellHeight="20">

                            <Ctl:SheetField DataField="OS_NUM" TextField="등록번호" Description="등록번호" Width="100"  HAlign="center" Align="left"  runat="server" OnClick="grdOutWorClick" />
                            <Ctl:SheetField DataField="OSMETHODCODE" TextField="작업내용" Description="작업내용" Width="250"  HAlign="center" Align="left"  runat="server" OnClick="grdOutWorClick" />
                            
                            <Ctl:SheetField DataField="OSWKDATE" TextField="작업기간" Description="작업기간" Width="100" HAlign="center" Align="left"  runat="server" OnClick="grdOutWorClick" />
                            <Ctl:SheetField DataField="OSCOMPANY" TextField="작업회사" Description="작업회사" Width="60" HAlign="center" Align="left"  runat="server" OnClick="grdOutWorClick" />
                            <Ctl:SheetField DataField="OSLOCATIONCODENM" TextField="설비명" Description="설비명" Width="100" HAlign="center" Align="left"  runat="server" OnClick="grdOutWorClick" />
                            <Ctl:SheetField DataField="OSAREACODENM" TextField="작업구역" Description="작업구역" Width="150" HAlign="center" Align="left"  runat="server" OnClick="grdOutWorClick" />
                            <Ctl:SheetField DataField="OSWKCLDATE" TextField="완료일자" Description="완료일자" Width="80" HAlign="center" Align="center"  runat="server" OnClick="grdOutWorClick" />
                            <Ctl:SheetField DataField="OSWKCLOSE" TextField="완료" Description="완료" Width="50" HAlign="center" Align="center"  runat="server" OnClick="grdOutWorClick" />
                            
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 

        
    </div>
</asp:content>
