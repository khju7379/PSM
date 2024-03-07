<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4010.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4010" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript" src="/Resources/Script/Common.js"></script>

    <script type="text/javascript">

        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";

        // 페이지 로드
        function OnLoad() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            ht["PageSize"] = 15;

            debugger;
            var today = new Date();

            txtDate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

            if (deptcd.substring(0, 1) == 'A') {

                dept = deptcd.substring(0, 1);

                rdoSaup.SetValue(dept);
            }

            if (deptcd == "A10300" || deptcd.substring(0, 2) == "D1") {
                rdoSaup.SetValue("ALL");
            }
            else if (deptcd == "C10000" || deptcd.substring(0, 1) == "A") {
                rdoSaup.SetValue("A");
            }
            else if (deptcd == "E10100" || deptcd.substring(0, 1) == "T") {
                rdoSaup.SetValue("T");
            }
            else if (deptcd == "E10200" || deptcd.substring(0, 1) == "S") {
                rdoSaup.SetValue("S");
            }

            btnSearch_Click();
        }

        // 조회 버튼 이벤트
        function btnSearch_Click() {

            var team;
            var dept;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            gridIndex.RemoveAllRow();

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"]         = 15;
            ht["P_WOORDATE"]       = txtDate.GetValue();
            ht["P_WOAPPRESABUN1"]  = $("#svSUSIN_KBSABUN").val();
            ht["P_WOWORKTITLE"]    = txtWOWORKTITLE.GetValue();
            ht["P_WKGUBN"]         = rdoGubun.GetValue();
            ht["P_WKSTATUS"]       = cboWorkStatus.GetValue();

            //if (cboWorkStatus.GetValue() == "A") {
            //    ht["P_WKSTATUS"] = "1,5";
            //}
            //else {
            //    ht["P_WKSTATUS"] = cboWorkStatus.GetValue();
            //}


            team = '';
            dept = '';
            if (rdoSaup.GetValue() == "ALL") {
                team = '';
            }
            else if (rdoSaup.GetValue() == "T") {
                team = rdoSaup.GetValue();
                dept = 'E10100';
            }
            else if (rdoSaup.GetValue() == "S") {
                team = rdoSaup.GetValue();
                dept = 'E10200';
            }
            else if (rdoSaup.GetValue() == "A") {
                team = rdoSaup.GetValue();
            }
            ht["P_WKTEAM"]    = team;
            ht["P_DEPT"]      = dept;
            ht["P_WOORTEAM"]  = $("#svBuseo_BUSEO").val();
            ht["P_WOORSABUN"] = $("#svSabun_KBSABUN").val();

            //alert(ht["CurrentPageIndex"] + "^" + ht["PageSize"] + "^" + ht["P_WKGUBN"] + "^" + ht["P_WKSTATUS"] + "^" + ht["P_WKTEAM"] + "^" + ht["P_DEPT"] + "^" + ht["P_WOORTEAM"] + "^" + ht["P_WOORSABUN"]);

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼 이벤트
        function btnNew_Click() {

            var param = '';

            fn_OpenPopCustom("PSM4011.aspx?param=NEW&param1=" + param, 1200, 1000, param);
        }

        

        // 그리드 선택 이벤트
        function gridClick(r, c)
        {
            var rw = gridIndex.GetRow(r);

            var param = rw["APP_NUM"];

            fn_OpenPopCustom("PSM4011.aspx?param=UPT&param1=" + param, 1200, 1000, param);
        }
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="작업요청관리" DefaultHide="False">
            <!-- 상단의 버튼을 정의 -->
            <div class="btn_bx" style="padding-bottom:0px;">
                <table class="table_01" style="width: 100%;">    
                    <colgroup>
                        <col width="60px" />
                        <col width="320px" />
                        <col width="60px" />
                        <col width="320px" />
                        <col width="60px" />
                        <col width="320px" />
                        <col width="*" />
                    </colgroup>
                    <tr style="text-align:left;">
                        <th>
                            <Ctl:Text ID="lblSAUP" runat="server" LangCode="lblSAUP" Description="사업장"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:Radio ID="rdoSaup" runat="server" DataMember="IDX" ReadMode="false" OnChanged="return true;">
                                    <asp:ListItem Text="전체" Value="ALL" Selected="true"></asp:ListItem>
                                    <asp:ListItem Text="UTT"  Value="T" ></asp:ListItem>
                                    <asp:ListItem Text="SILO" Value="S" ></asp:ListItem>
                                    <asp:ListItem Text="관리" Value="A" ></asp:ListItem>
                            </Ctl:Radio>
                        </td>
                        <th>
                            <Ctl:Text ID="txtGubun" runat="server" LangCode="lblSAUP" Description="작업구분"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:Radio ID="rdoGubun" runat="server" DataMember="IDX" ReadMode="false" OnChanged="return true;">
                                    <asp:ListItem Text="전체" Value="A" Selected="true"></asp:ListItem>
                                    <asp:ListItem Text="단순" Value="1" ></asp:ListItem>
                                    <asp:ListItem Text="변경" Value="2" ></asp:ListItem>
                            </Ctl:Radio>
                        </td>
                        <th>
                            <Ctl:Text ID="txtWorkStatus" runat="server" LangCode="lblSAUP" Description="상태진행"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:Combo ID="cboWorkStatus" Width="80px" runat="server">
                                <asp:ListItem Text="전체"     Value="1,5"></asp:ListItem>
                                <asp:ListItem Text="작업진행" Value="1" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="작업완료" Value="5"></asp:ListItem>
                            </Ctl:Combo>
                        </td>
                        <td style="border-left:hidden"></td>
                    </tr>

                    <tr style="text-align:left;">
                        <th>
                            <Ctl:Text ID="lblData" runat="server" LangCode="lblData" Description="요청일자" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                        </td>
                        <th>
                            <Ctl:Text ID="lblBuseo" runat="server" LangCode="lblBuseo" Description="요청부서"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:SearchView ID="svBuseo" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_GETDATA" Params="{'P_DATE':txtDate.GetValue() }" >
                                <Ctl:SearchViewField DataField="BUSEO"   TextField="BUSEO"   Description="부서" Hidden="false" Width="70" TextBox="true"  runat="server" />
                                <Ctl:SearchViewField DataField="BUSEONM" TextField="BUSEONM" Description="부서명" Hidden="false" Width="110" TextBox="true" Default="true" runat="server" />
                            </Ctl:SearchView>
                        </td>
                        <th>
                            <Ctl:Text ID="txtSabun" runat="server" LangCode="lblSabun" Description="요청자"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:SearchView ID="svSabun" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="">
                                <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" />
                                <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="110" TextBox="true" Default="true" runat="server" />
                            </Ctl:SearchView>
                        </td>
                        <td style="border-left:hidden"></td>
                    </tr>
                    <tr style="text-align:left;">                        
                        <th>
                            <Ctl:Text ID="lblWOWORKTITLE" runat="server" LangCode="lblBuseo" Description="작업명"></Ctl:Text>
                        </th>
                        <td colspan ="3">
                            <Ctl:TextBox ID="txtWOWORKTITLE" Width ="500px" runat="server"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="txtSUSIN" runat="server" LangCode="lblBuseo" Description="수신자"></Ctl:Text>
                        </th>
                        <td style="border-right:hidden">
                            <Ctl:SearchView ID="svSUSIN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="">
                                <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" />
                                <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="110" TextBox="true" Default="true" runat="server" />
                            </Ctl:SearchView>
                        </td>
                        <td style="text-align:right;">
                            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                            <Ctl:Button ID="btnNew"   runat ="server" LangCode="btnNew"    Description="신규" OnClientClick="btnNew_Click();"></Ctl:Button>
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
                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSM4010" MethodName="UP_GET_WORKORDER_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="23">

                            <Ctl:SheetHeader TextField="tColumns1" Description="요청번호" Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="0" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns2" Description="작업내용" Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="1" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns3" Description="작업설비" Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="2" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns4" Description="요청부서" Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="3" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns5" Description="수신부서" Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="5" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns6" Description="작업기간" Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="7" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns7" Description="상태"     Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="9" runat="server" />

                            <Ctl:SheetField DataField="APP_NUM" TextField="요청번호" Description="요청번호" Width="130"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="WOWORKTITLE" TextField="작업내용" Description="작업내용" Width="380"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="WOLOCATIONCODE1NM" TextField="작업설비" Description="작업설비" Width="200" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="WOSOTEAMNM" TextField="부서" Description="부서" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="WOAPPORSABUNNM" TextField="성명" Description="성명" Width="60" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="WORETEAMNM" TextField="부서" Description="부서" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="WOAPPREVSABUNNM" TextField="성명" Description="성명" Width="60" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />

                            <Ctl:SheetField DataField="WODSDATE1" TextField="From" Description="From" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="WODSDATE2" TextField="To" Description="To" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="WOSTATUS" TextField="상태" Description="상태" Width="120" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />

                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
