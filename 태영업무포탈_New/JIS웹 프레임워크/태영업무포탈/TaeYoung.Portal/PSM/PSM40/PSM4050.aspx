<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4050.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4050" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <style>

       #sub_body #container #content_bx .table {
				position: relative;
				margin-bottom: 0px;
			}
    </style>
    <script type="text/javascript">

        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";

        // 페이지 로드
        function OnLoad() {

            var today = new Date();
            txtFRDate.SetValue(CalLpad(today.getFullYear() - 1) + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            txtTODate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));           
        }

        // 조회 버튼 이벤트
        function btnSearch_Click() {

            var team;
            var dept;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;

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

            ht["P_SDATE"]  = txtFRDate.GetValue();
            ht["P_EDATE"] = txtTODate.GetValue();          
            ht["P_ORSABUN"]  = $("#svSabun_KBSABUN").val();
            ht["P_WKSAUP"] = team;
            ht["P_WKTEAM"] = $("#svBuseo_BUSEO").val();
            ht["P_DEPT"] = dept;

            if (cboWorkStatus.GetValue() == "A") {
                ht["P_STATUS"] = "9,10,11,12,13,14,15";
            }
            else if (cboWorkStatus.GetValue() == "1") {
                ht["P_STATUS"] = "9,10,11,12,13,14";
            }
            else {
                ht["P_STATUS"] = "15";
            }                      

            grdWorkList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grdWorkList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩            
        }       

        //작업요청서 그리드 선택 이벤트
        function grdWorkClick(r, c)
        {
            var rw = grdWorkList.GetRow(r);

             var ht = new Object(); 

            ht["P_SMWKTEAM"] = rw["APP_NUM"].substr(0, 6);
            ht["P_SMWKDATE"] = rw["APP_NUM"].substr(7, 8);
            ht["P_SMWKSEQ"] = rw["APP_NUM"].substr(16, 3);
            ht["P_SMWKORAPPDATE"] = "";             

            grdSafeList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grdSafeList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩  
        }

        //안전작업허가서 그리드 선택 이벤트
        function grdSafeClick(r, c) {

            var param = '';

            var rw = grdSafeList.GetRow(r);

            param = rw["APP_NUM"] + "-" + rw["OR_NUM"];

            if (c >= 3) {
                fn_OpenPopCustom("PSM4041.aspx?param=UPT&param1=" + param, 1200, 1000, param);
            }

        }

        // 안전작업허가서 출력
        function GridSafeDocClick(APP_NUM) {

            var ArrayCode = APP_NUM.split('-');
            var DOCNAME = "";

            if (ArrayCode[3] > 20231114) {
                DOCNAME = "PSM4041_RPT_6";
            }
            else if (ArrayCode[3] > 20180130) {
                DOCNAME = "PSM4041_RPT_5";
            }
            else if (ArrayCode[3] > 20170705) {
                DOCNAME = "PSM4041_RPT_4";
            }
            else if (ArrayCode[3] > 2017011) {
                DOCNAME = "PSM4041_RPT_3";
            }
            else if (ArrayCode[3] > 20160608) {
                DOCNAME = "PSM4041_RPT_2";
            }
            else {
                DOCNAME = "PSM4041_RPT_1";
            }

            fn_OpenPop("../../Common/ReportView.aspx?RPT=" + DOCNAME + "&CMWKTEAM=" + ArrayCode[0] + "&CMWKDATE=" + ArrayCode[1]
                + "&CMWKSEQ=" + ArrayCode[2] + "&SMWKORAPPDATE=" + ArrayCode[3] + "&SMWKORSEQ=" + ArrayCode[4], 1000, 600);

        }

        // 일일JSA 출력
        function GridJSADocClick(APP_NUM) {

            var ArrayCode = APP_NUM.split('-');
            var sessionid = "<%= Session.SessionID %>";

            var ht = new Object();

            ht["P_JSMWKGUBN"] = "D";
            ht["P_JSMPOTEAM"] = ArrayCode[0];
            ht["P_JSMPODATE"] = ArrayCode[1];
            ht["P_JSMPOSEQ"] = ArrayCode[2];
            ht["P_JSMDATE"] = ArrayCode[3];

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_JSACHANGE_MASTER_LIST", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    fn_OpenPop("../../Common/ReportView.aspx?RPT=PSM4050_RPT&WKGUBN=D&CMWKTEAM=" + ArrayCode[0] + "&CMWKDATE=" + ArrayCode[1]
                        + "&CMWKSEQ=" + ArrayCode[2] + "&SMWKORAPPDATE=" + ArrayCode[3] + "&SESSIONID=" + sessionid, 1000, 600);
                }
                else {
                    alert('<Ctl:Text runat="server" Description="JSA 자료가 존재하지 않습니다." Literal="true"></Ctl:Text>');
                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });

        }

      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="작업요청서" DefaultHide="False">
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
                            <Ctl:Text ID="txtWorkStatus" runat="server" LangCode="lblSAUP" Description="상태진행"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:Combo ID="cboWorkStatus" Width="80px" runat="server">
                                <asp:ListItem Text="전체"     Value="A" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="작업진행" Value="1"></asp:ListItem>
                                <asp:ListItem Text="작업완료" Value="2"></asp:ListItem>
                            </Ctl:Combo>
                        </td>           
                        <td colspan="3" style="border-left:hidden"></td>
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
                        <td style="text-align:right;border-left:hidden;">
                            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
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
                        <Ctl:WebSheet ID="grdWorkList" runat="server" Paging="true" CheckBox="false" HFixation="true"   Height="240" Width="100%" TypeName="PSM.PSM4050" MethodName="UP_GET_SAFEWORKORDER_LIST" UseColumnSort="true" HeaderHeight="10" CellHeight="20">

                            <Ctl:SheetHeader TextField="tColumns1" Description="요청번호" Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="0" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns2" Description="작업내용" Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="1" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns3" Description="작업설비" Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="2" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns4" Description="요청부서" Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="3" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns5" Description="수신부서" Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="5" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns6" Description="작업기간" Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="7" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns7" Description="상태"     Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="9" runat="server" />

                            <Ctl:SheetField DataField="APP_NUM" TextField="요청번호" Description="요청번호" Width="130"  HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOWORKTITLE" TextField="작업내용" Description="작업내용" Width="380"  HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOLOCATIONCODE1NM" TextField="작업설비" Description="작업설비" Width="200" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />

                            <Ctl:SheetField DataField="WOSOTEAMNM" TextField="부서" Description="부서" Width="100" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOAPPORSABUNNM" TextField="성명" Description="성명" Width="60" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WORETEAMNM" TextField="부서" Description="부서" Width="100" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOAPPREVSABUNNM" TextField="성명" Description="성명" Width="60" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WODSDATE1" TextField="From" Description="From" Width="80" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WODSDATE2" TextField="To" Description="To" Width="80" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOSTATUS" TextField="상태" Description="상태" Width="120" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />

                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 

        <Ctl:Layer ID="layer2" runat="server" Title="안전작업허가서" DefaultHide="False">
            <table style="width: 100%;">
                <colgroup>
                    <col width="25%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td valign="top">
                        <Ctl:WebSheet ID="grdSafeList" runat="server" Paging="false" CheckBox="false" HFixation="true"   Height="240" Width="100%" TypeName="PSM.PSM4050" MethodName="UP_GET_SAFEORDER_LIST" UseColumnSort="true" HeaderHeight="10" CellHeight="20">

                            <Ctl:SheetField DataField="SAFEDOCPRT" TextField="허가서" Description="허가서" Width="60"  HAlign="center" Align="center"  runat="server"  />
                            <Ctl:SheetField DataField="JSADOCPRT" TextField="JSA" Description="JSA" Width="50"  HAlign="center" Align="center"  runat="server"  />
                            <Ctl:SheetField DataField="APP_NUM" TextField="요청번호" Description="요청번호" Width="150"  HAlign="center" Align="left"  runat="server" OnClick="grdSafeClick"  />
                            <Ctl:SheetField DataField="OR_NUM" TextField="허가번호" Description="허가번호" Width="130"  HAlign="center" Align="left"  runat="server" OnClick="grdSafeClick" />
                            <Ctl:SheetField DataField="SWWKNAME" TextField="작업구분" Description="작업구분" Width="130"  HAlign="center" Align="left"  runat="server" OnClick="grdSafeClick" />
                            <Ctl:SheetField DataField="SMWKMETHOD" TextField="작업방법" Description="작업방법" Width="100"  HAlign="center" Align="center"  runat="server" OnClick="grdSafeClick" />
                            <Ctl:SheetField DataField="C3NAME1" TextField="작업설비" Description="작업설비" Width="130"  HAlign="center" Align="left"  runat="server" OnClick="grdSafeClick" />
                            <Ctl:SheetField DataField="SMAREACODE1NM" TextField="작업구역" Description="작업구역" Width="130"  HAlign="center" Align="left"  runat="server" OnClick="grdSafeClick" />
                            <Ctl:SheetField DataField="SMREVTEAMNM" TextField="작업부서" Description="작업부서" Width="130"  HAlign="center" Align="left"  runat="server" OnClick="grdSafeClick" />
                            <Ctl:SheetField DataField="SMTADATE" TextField="작업기간" Description="작업기간" Width="180"  HAlign="center" Align="left"  runat="server" OnClick="grdSafeClick"  />
                            <Ctl:SheetField DataField="SMORSABUNNM" TextField="요청자" Description="요청자" Width="100"  HAlign="center" Align="center"  runat="server" OnClick="grdSafeClick"  />
                            <Ctl:SheetField DataField="SMGRSABUNNM" TextField="승인자" Description="승인자" Width="100"  HAlign="center" Align="center"  runat="server"  OnClick="grdSafeClick" />
                            <Ctl:SheetField DataField="SMCOSABUNNM" TextField="감독자" Description="감독자" Width="100"  HAlign="center" Align="center"  runat="server"  OnClick="grdSafeClick" />
                            <Ctl:SheetField DataField="SMSMSABUNNM" TextField="안전환경" Description="안전환경" Width="100"  HAlign="center" Align="center"  runat="server" OnClick="grdSafeClick" />

                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
