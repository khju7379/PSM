<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4070.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4070" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";

        // 페이지 로드
        function OnLoad() {

            var today = new Date();
            txtFRDate.SetValue(CalLpad(today.getFullYear() - 1) + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            txtTODate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

            if (deptcd.substring(0, 1) == 'A') {

                dept = deptcd.substring(0, 1);

                rdoSaup.SetValue(dept);
            }

            if (deptcd == "A20000" || deptcd.substring(0, 2) == "D1") {
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

            ht["P_STDATE"]  = txtFRDate.GetValue();
            ht["P_EDDATE"]  = txtTODate.GetValue();          
            ht["P_ORSABUN"] = $("#svSabun_KBSABUN").val();
            ht["P_WKSAUP"]  = team;
            ht["P_WKTEAM"]  = $("#svBuseo_BUSEO").val();
            ht["P_DEPT"]    = dept;
            ht["P_TITLE"] = txtWOWORKTITLE.GetValue();
            ht["P_STATUS"] = cboWorkStatus.GetValue();

            //if (cboWorkStatus.GetValue() == "A") {
            //    ht["P_STATUS"] = "9,10,11,12,13,14,15";
            //}
            //else if (cboWorkStatus.GetValue() == "1") {
            //    ht["P_STATUS"] = "9,10,11,12,13,14";
            //}
            //else {
            //    ht["P_STATUS"] = "15";
            //}                      

            grdWorkList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grdWorkList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            grdEXAMList.RemoveAllRow();
        }

        // 점검표 점검내용관리 버튼 이벤트
        function btnExcon_Click() {

            fn_OpenPopCustom("PSM4071.aspx?param=NEW&param2=1", 1400, 800, "Excon");
        }

        function grdWorkEXAMClick(r, c) {

            
        }

        // 그리드 선택 이벤트
        function gridClick(r, c)
        {
            var rw = grdWorkList.GetRow(r);

            var param = rw["APP_NUM"];

            fn_OpenPopCustom("PSM4073.aspx?param=NEW&param1=" + param, 1200, 1000, param);
            //fn_OpenPopCustom("PSM4073.aspx?param=UPT&param1=" + param + "^A20000-20231013-001", 1200, 1000, param);
        }

        //작업요청서 그리드 선택 이벤트
        function grdWorkClick(r, c)
        {
            var rw = grdWorkList.GetRow(r);

            var ht = new Object();
            
            ht["P_PECWOTEAM"]   = rw["APP_NUM"].substr(0, 6);
            ht["P_PECWODATE"]   = rw["APP_NUM"].substr(7, 8);
            ht["P_PECWOSEQ"]    = rw["APP_NUM"].substr(16, 3);
            ht["P_PECSGUBUN"]   = "1";

            // 가동전 점검 조회
            grdEXAMList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grdEXAMList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 등록 팝업 콜백
        function board_popup_callback(TEAM, DATE, SEQ) {

            btnSearch_Click();

            //var ht = new Object();

            //ht["P_PECWOTEAM"] = TEAM;
            //ht["P_PECWODATE"] = DATE;
            //ht["P_PECWOSEQ"] = SEQ;
            //ht["P_PECSGUBUN"] = "1";

            //// 가동전 점검 조회
            //grdEXAMList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            //grdEXAMList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }
        
        function grdEXAMClick(r, c) {

            var rw = grdEXAMList.GetRow(r);

            var param = rw["APP_NUM"] + "^" + rw["PEC_NUM"];

            fn_OpenPopCustom("PSM4073.aspx?param=UPT&param1=" + param, 1200, 1000, param);
        }

        //function rdoSaupChanged() {

        //    var rdoList = $("input[name=rdoSaup]");

        //    // 체크가 되어있는 항목의 value 값을 txtCheckValue 필드에 저장
        //    for (var i = 0; rdoList[i]; i++) {

        //        if (rdoList[i].checked == true) {
        //            txtCheckValue.SetValue($(rdoList[i]).val());
        //        }
        //    }

        //    // 체크가 전부 해제된 경우 txtCheckValue 필드에 저장되어 있는 값으로 다시 체크선택 함
        //    if (!rdoList.is(":checked")) {

        //        $("input[value=" + txtCheckValue.GetValue() +"]").prop("checked", true);
        //    }
        //}
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="가동전점검" DefaultHide="False">
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
                            <%--<Ctl:Text ID="txtCheckValue"  runat="server" Hidden="true"></Ctl:Text>--%>
                            <Ctl:Radio ID="rdoSaup" runat="server" >
                                    <asp:ListItem Text="전체" Value="ALL" Selected="true"></asp:ListItem>
                                    <asp:ListItem Text="UTT"  Value="T" ></asp:ListItem>
                                    <asp:ListItem Text="SILO" Value="S" ></asp:ListItem>
                                    <asp:ListItem Text="관리" Value="A" ></asp:ListItem>
                            </Ctl:Radio>
                        </td>
                        <th>
                            <Ctl:Text ID="txtWorkStatus" runat="server" LangCode="lblSAUP" Description="상태진행"></Ctl:Text>
                        </th>
                        <td colspan ="3" >
                            <Ctl:Combo ID="cboWorkStatus" Width="80px" runat="server">
                                <asp:ListItem Text="전체"     Value="1,5" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="작업진행" Value="1"></asp:ListItem>
                                <asp:ListItem Text="작업완료" Value="5"></asp:ListItem>
                            </Ctl:Combo>
                        </td>
                        <td style="border-left:hidden"></td>
                    </tr>

                    <tr style="text-align:left;">
                        <th>
                            <Ctl:Text ID="lblData" runat="server" Required="true" LangCode="lblData" Description="요청일자" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtFRDate"  runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                            <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblBuseo" runat="server" LangCode="lblBuseo" Description="요청부서"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:SearchView ID="svBuseo" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_GETDATA" Params="{'P_DATE':txtFRDate.GetValue() }" >
                                <Ctl:SearchViewField DataField="BUSEO"   TextField="BUSEO"   Description="부서" Hidden="false" Width="70" TextBox="true"  runat="server" />
                                <Ctl:SearchViewField DataField="BUSEONM" TextField="BUSEONM" Description="부서명" Hidden="false" Width="110" TextBox="true" Default="true" runat="server" />
                            </Ctl:SearchView>
                        </td>
                        <th>
                            <Ctl:Text ID="txtSabun" runat="server" LangCode="lblSabun" Description="요청자"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:SearchView ID="svSabun" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" >
                                <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" />
                                <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="110" TextBox="true" Default="true" runat="server" />
                            </Ctl:SearchView>
                        </td>
                        <td  style="border-left:hidden"></td>
                    </tr>
                    <tr style="text-align:left;">
                        <th>
                            <Ctl:Text ID="lblWOWORKTITLE" runat="server" LangCode="lblSMWORKTITLE" Description="작업명"></Ctl:Text>
                        </th>
                        <td colspan ="3">
                            <Ctl:TextBox ID="txtWOWORKTITLE" Width ="370px" runat="server"></Ctl:TextBox>
                        </td>
                        <td colspan="3" style="text-align:right;border-left:hidden;">
                            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                            <Ctl:Button ID="btnExcon"   runat ="server" LangCode="btnExcon"    Description="점검표 관리" OnClientClick="btnExcon_Click();"></Ctl:Button>
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
                        <Ctl:WebSheet ID="grdWorkList" runat="server" Paging="false" CheckBox="false" HFixation="true"   Height="240" Width="100%" TypeName="PSM.PSM4070" MethodName="UP_GET_WORKORDER_LIST" UseColumnSort="true" HeaderHeight="10" CellHeight="20">

                            <Ctl:SheetHeader TextField="tColumns1" Description="가동전 점검" Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="0" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns3" Description="요청번호"    Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="1" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns4" Description="작업내용"    Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="2" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns5" Description="작업설비"    Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="3" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns6" Description="변경등급"    Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="4" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns7" Description="변경종류"    Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="5" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns8" Description="요청부서"    Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="6" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns9" Description="수신부서"    Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="8" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns10" Description="작업기간"    Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="10" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns11" Description="상태"        Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="12" runat="server" />

                            <Ctl:SheetField DataField="EXAM_ADD"          TextField="가동전 점검" Description="JSA"      Width="70"  HAlign="center" Align="center" runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="APP_NUM"           TextField="요청번호"    Description="요청번호" Width="140" HAlign="center" Align="left"   runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOWORKTITLE"       TextField="작업내용"    Description="작업내용" Width="350" HAlign="center" Align="left"   runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOLOCATIONCODE1NM" TextField="작업설비"    Description="작업설비" Width="180" HAlign="center" Align="left"   runat="server" OnClick="grdWorkClick" />

                            <Ctl:SheetField DataField="CAASKCLASS"        TextField="변경등급"    Description="변경등급" Width="60" HAlign="center" Align="center"   runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="CAASKSTEPGN"       TextField="변경종류"    Description="변경종류" Width="95" HAlign="center" Align="left"   runat="server" OnClick="grdWorkClick" />

                            <Ctl:SheetField DataField="WOSOTEAMNM"        TextField="부서" Description="부서" Width="100" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOAPPORSABUNNM"    TextField="성명" Description="성명" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WORETEAMNM"        TextField="부서" Description="부서" Width="100" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOAPPREVSABUNNM"   TextField="성명" Description="성명" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WODSDATE1"         TextField="From" Description="From" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WODSDATE2"         TextField="To"   Description="To"   Width="80"  HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOSTATUS"          TextField="상태" Description="상태" Width="110" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />

                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>   
            
            <table  style="width: 100%;">
                <tr>
                    <td valign="top">      
                        <Ctl:WebSheet ID="grdEXAMList" runat="server" Paging="false" HFixation="true"   Width="100%"  Height="270" CheckBox="false" TypeName="PSM.PSM4070" MethodName="UP_GET_EXAM_CHECK_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20" >
                                        
                            <Ctl:SheetField DataField="APP_NUM"     TextField="요청번호"    Description="요청번호"    Width="180"  HAlign="center" Align="left"    runat="server"  OnClick="grdEXAMClick" />
                            <Ctl:SheetField DataField="PEC_NUM"     TextField="점검번호"    Description="점검번호"    Width="180"  HAlign="center" Align="left"    runat="server"  OnClick="grdEXAMClick" />
                            <Ctl:SheetField DataField="PECTITLE"    TextField="제목"        Description="제목"        Width="*"    HAlign="center" Align="left"    runat="server"  OnClick="grdEXAMClick" />
                            <Ctl:SheetField DataField="PECINSDATE"  TextField="점검일자"    Description="점검일자"    Width="120"  HAlign="center" Align="center"  runat="server"  OnClick="grdEXAMClick" />
                            <Ctl:SheetField DataField="PECSGUBUN"   TextField="구분"        Description="구분"        Width="120"  HAlign="center" Align="center"  runat="server"  OnClick="grdEXAMClick" />
                            <Ctl:SheetField DataField="PECRNUM"     TextField="보고서 번호" Description="보고서 번호" Width="130"  HAlign="center" Align="left"    runat="server"  OnClick="grdEXAMClick" />
                        </Ctl:WebSheet>  
                    </td>
                </tr>
            </table>
        </Ctl:Layer> 
    </div>
</asp:content>
