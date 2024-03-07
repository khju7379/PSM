<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4080.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4080" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript" src="/Resources/Script/Common.js"></script>

    <script type="text/javascript">

        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";

        // 페이지 로드
        function OnLoad() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            ht["PageSize"] = 15;

            var today = new Date();
            txtFRDate.SetValue(CalLpad(today.getFullYear() - 1) + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            txtTODate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            //txtPECDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

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

            if (deptcd.substr(0, 1) == 'E') {
                if (deptcd == 'E10000' || dept == 'E10100') {
                    team = 'T';
                    dept = 'E10100';
                }
                else {
                    team = 'S';
                    dept = 'E10200';
                }

            }

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            //ht["P_PECDATE"] = txtPECDATE.GetValue();
            ht["P_STDATE"] = txtFRDate.GetValue();
            ht["P_EDDATE"] = txtTODate.GetValue();
            ht["P_PECTEAM"] = $("#svPECTEAM_BUSEO").val();
            ht["P_PECTITLE"] = txtPECTITLE.GetValue();
            ht["P_PECSGUBUN"] = rdoPECSGUBUN.GetValue();
            ht["P_WKSAUP"] = team;
            ht["P_DEPT"] = dept;
            ht["P_STATUS"] = cboWorkStatus.GetValue().replace('A', '');;

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼 이벤트 (테스트용)
        function btnNew_Click() {

            var param = 'A20000^20230914^1^^';

            fn_OpenPopCustom("PSM4081.aspx?param=" + param + "&param1=list", 1000, 800, param);
        }

        // 등록 팝업 콜백
        function board_popup_callback() {

            btnSearch_Click();
        }

        // 그리드 선택 이벤트
        function gridClick(r, c)
        {
            var rw = gridIndex.GetRow(r);

            var param = rw["PECTEAM"] + "^" + rw["PECDATE"] + "^" + rw["PECSEQ"] + "^" + rw["PECRDATE"] + "^" + rw["PECRSEQ"] + "^" + rw["PECTEAMNM"];

            fn_OpenPopCustom("PSM4081.aspx?param=" + param + "&param1=list", 1000, 800, param);
        }
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="가동전 안전점검 보고서" DefaultHide="False">
            <!-- 상단의 버튼을 정의 -->
            <div class="btn_bx" style="padding-bottom:0px;">
                <table class="table_01" style="width: 100%;">    
                    <colgroup>
                        <col width="80px" />
                        <col width="320px" />
                        <col width="80px" />
                        <col width="320px" />
                        <col width="80px" />
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
                            <Ctl:Text ID="lblPECDATE" runat="server" Required="true" LangCode="lblPECDATE" Description="점검일자" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtFRDate"  runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                            <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                            <%--<Ctl:TextBox ID="txtPECDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> --%>
                        </td>
                        <th>
                            <Ctl:Text ID="lblPECTEAM" runat="server" LangCode="lblPECTEAM" Description="점검팀"></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:SearchView ID="svPECTEAM" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_GETDATA" Params="{'P_DATE':txtFRDate.GetValue() }" >
                                <Ctl:SearchViewField DataField="BUSEO"   TextField="BUSEO"   Description="부서" Hidden="false" Width="70" TextBox="true"  runat="server" />
                                <Ctl:SearchViewField DataField="BUSEONM" TextField="BUSEONM" Description="부서명" Hidden="false" Width="110" TextBox="true" Default="true" runat="server" />
                            </Ctl:SearchView>
                        </td>
                        <td style="border-left:hidden"></td>
                    </tr>
                    <tr style="text-align:left;">
                        <th>
                            <Ctl:Text ID="txtGubun" runat="server" LangCode="lblSAUP" Description="작업구분"></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:Radio ID="rdoPECSGUBUN" runat="server" DataMember="IDX" ReadMode="false" OnChanged="return true;">
                                    <asp:ListItem Text="전체" Value="" Selected="true"></asp:ListItem>
                                    <asp:ListItem Text="일반" Value="1" ></asp:ListItem>
                                    <asp:ListItem Text="화물" Value="2" ></asp:ListItem>
                            </Ctl:Radio>
                        </td>
                        <th>
                            <Ctl:Text ID="txtWorkStatus" runat="server" LangCode="lblSAUP" Description="상태진행"></Ctl:Text>
                        </th>
                        <td colspan="3">
                            <Ctl:Combo ID="cboWorkStatus" Width="80px" runat="server">
                                <asp:ListItem Text="전체"     Value="A" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="작업진행" Value="1"></asp:ListItem>
                                <asp:ListItem Text="작업완료" Value="2"></asp:ListItem>
                            </Ctl:Combo>
                        </td>
                        <td style="border-left:hidden"></td>
                    </tr>
                    <tr style="text-align:left;">
                        <th>
                            <Ctl:Text ID="lblPECTITLE" runat="server" LangCode="lblPECTITLE" Description="제목"></Ctl:Text>
                        </th>
                        <td colspan="3" style="border-right:hidden">
                            <Ctl:TextBox ID="txtPECTITLE" Width ="370px" runat="server"></Ctl:TextBox>
                        </td>
                        <td colspan="3" style="text-align:right;">
                            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                            <%--<Ctl:Button ID="btnNew"   runat ="server" LangCode="btnNew"    Description="신규" OnClientClick="btnNew_Click();"></Ctl:Button>--%>
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
                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSM4080" MethodName="UP_GET_XEAM_CHECK_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="25">
                            <Ctl:SheetField DataField="PEC_NUM" TextField="점검번호" Description="점검번호" Width="160"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="APP_NUM" TextField="요청번호" Description="요청번호" Width="160"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="PECTEAM" TextField="점검팀" Description="점검팀" Width="120"  HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true"/>
                            <Ctl:SheetField DataField="PECTEAMNM" TextField="점검팀" Description="점검팀" Width="120"  HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECDATE" TextField="점검일자" Description="점검일자" Width="100"  HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECSEQ" TextField="순번" Description="순번" Width="60" HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECTITLE" TextField="제목/변경저장 물질" Description="제목/변경저장 물질" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="PECSGUBUNNM" TextField="작업구분" Description="작업구분" Width="80" HAlign="center" Align="center"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="PECINSDATE" TextField="점검일자" Description="점검일자" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="PECWOTEAM" TextField="작업요청팀" Description="작업요청팀" Width="120" HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true"/>
                            <Ctl:SheetField DataField="PECWOTEAMNM" TextField="작업요청팀" Description="작업요청팀" Width="120" HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECWODATE" TextField="작업요청일자" Description="작업요청일자" Width="100" HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECWOSEQ" TextField="작업요청순번" Description="작업요청순번" Width="80" HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECRDATE" TextField="보고서일자" Description="보고서일자" Width="100" HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECRSEQ" TextField="보고서순번" Description="보고서순번" Width="80" HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="REP_NUM" TextField="보고서번호" Description="보고서번호" Width="120"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="WKSTATENM" TextField="상태진행" Description="상태진행" Width="120"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
