<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4040.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4040" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <style>

        html,body {width:100%;  }
            body,div,ul,li{margin:0; padding:0;}
            ul,li {list-style:none;}

            /*tab css*/
            .tab{float:left; width:100%; height:280px;}
            .tabnav{font-size:0; width:280px; border:0px solid #ddd;}
            
            .tabnav li{display: inline-block;  height:30px; text-align:center; border-right:1px solid #ddd;}

            .tabnav li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:2px; }

            .tabnav li a.active:before{background:#A32958;}

            .tabnav li a.active{border-bottom:1px solid #fff;}
            .tabnav li a{ position:relative; display:block; background: #f8f8f8; color: #646464; padding:0 30px; line-height:30px; text-decoration:none; font-size:13px;}
            .tabnav li a:hover,
            .tabnav li a.active{background:#fff; color:#A32958; }            
            .tabcontent{padding: 5px; height:680px; border:1px solid #ddd; border-top:none;}

       #sub_body #container #content_bx .table {
				position: relative;
				margin-bottom: 0px;
			}
    </style>
    <script type="text/javascript">

        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";

        var _id = "";

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

            tabControl();
        }

        function tabControl() {

            $('.tabcontent > div').hide();

            $('.tabnav a').click(function () {
                $('.tabcontent > div').hide().filter(this.hash).fadeIn();
                $('.tabnav a').removeClass('active');
                $(this).addClass('active');
                return false;
            }).filter(':eq(0)').click();
        }

        // 조회 버튼 이벤트
        function btnSearch_Click() {

            var team;
            var dept;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            grdWorkList.RemoveAllRow();
            grdSafeList.RemoveAllRow();
            grdJsaList.RemoveAllRow();

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
            ht["P_TITLE"]   = txtWOWORKTITLE.GetValue();
            ht["P_STATUS"]  = cboWorkStatus.GetValue();

            grdWorkList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grdWorkList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            document.getElementById("tab01").style.display = "";
            document.getElementById("tab02").style.display = "none";
            $('#tabli01').addClass('active');
            $('#tabli02').removeClass('active');
        }       

        //작업요청서 그리드 선택 이벤트
        function grdWorkClick(r, c)
        {
            var rw = grdWorkList.GetRow(r);

            var ht = new Object();

            ht["P_JSLWKGUBN"]     = "D";
            ht["P_SMWKTEAM"]      = rw["APP_NUM"].substr(0, 6);
            ht["P_SMWKDATE"]      = rw["APP_NUM"].substr(7, 8);
            ht["P_SMWKSEQ"]       = rw["APP_NUM"].substr(16, 3);
            ht["P_SMWKORAPPDATE"] = "";


            // 안전작업허가서 조회
            grdSafeList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grdSafeList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩  

            ht["P_JSLWKGUBN"] = "D";
            ht["P_SMWKTEAM"]  = rw["APP_NUM"].substr(0, 6);
            ht["P_SMWKDATE"]  = rw["APP_NUM"].substr(7, 8);
            ht["P_SMWKSEQ"]   = rw["APP_NUM"].substr(16, 3);
            // JSA 조회
            grdJsaList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grdJsaList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
            

            document.getElementById("tab01").style.display = "";
            document.getElementById("tab02").style.display = "none";
            $('#tabli01').addClass('active');
            $('#tabli02').removeClass('active');
        }

        function grdWorkJSAClick(r, c) {

            var rw = grdWorkList.GetRow(r);

            debugger;

        //    if (rw["JSA_ADD"] == '') {

        //        alert('JSA-POPUP');
        //    }
        }

        function grdWorkSAFEClick(r, c) {

            var rw = grdWorkList.GetRow(r);

        //    if (rw["SAFE_ADD"] == '') {

        //        alert('SAFE-POPUP');
        //    }
        }

        //안전작업허가서 그리드 선택 이벤트
        function grdSafeClick(r, c) {

            var param = '';

            var rw = grdSafeList.GetRow(r);

            param = rw["APP_NUM"] + "-" + rw["OR_NUM"];

            if (c >= 3) {
                fn_OpenPopCustom("PSM4041.aspx?param=UPT&param1=" + param, 1200, 1000, param);
            }

            //alert(param);

        }

        function grdJsaClick(r, c) {

            var rw = grdJsaList.GetRow(r);

            var CODE = rw["JSLWKGUBN"] + "^" + rw["JSLWKTEAM"] + "^" + rw["JSLWKDATE"] + "^" + rw["JSLWKSEQ"] + "^" + rw["JSLDATE"] + "^";
            CODE = CODE + rw["JSLSEQ"] + "^" + rw["JSMBLASS"] + "^" + rw["JSMMLASS"] + "^" + rw["JSMSLASS"] + "^" + rw["JSMSEQ"];
            
            fn_OpenPopCustom("PSM4045.aspx?CODE=" + CODE, 1450, 870, CODE);
        }

        function GridSafeCopy(APP_NUM) {

            debugger;

            _id = "SAFE";

            fn_OpenPopCustom("PSM4042.aspx?param=SAFE&param1=" + APP_NUM, 550, 350);
        }

        function GridJsaCopy(APP_NUM) {

            debugger;

            _id = "JSA";

            fn_OpenPopCustom("PSM4042.aspx?param=JSA&param1=" + APP_NUM, 550, 350);
        }

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

            var userAgent = navigator.userAgent.toLowerCase();
            var userPlatform = navigator.platform.toLowerCase();
            var pc = "win16|win32|win64|mac|macintel";

            //// 터치 기기 구분
            //var isTouchDevice = (navigator.maxTouchPoints || 'ontouchstart' in document.documentElement);

            //alert(isTouchDevice);
            

            //var CODE = DOCNAME + "^" + ArrayCode[0] + "^" + ArrayCode[1] + "^" + ArrayCode[2] + "^" + ArrayCode[3] + "^" + ArrayCode[4];
            //fn_OpenPopCustom("PSM4043.aspx?CODE=" + CODE, 300, 500, CODE);

            //alert(navigator.platform);

            if (pc.indexOf(userPlatform) < 0) {

                var CODE = DOCNAME + "^" + ArrayCode[0] + "^" + ArrayCode[1] + "^" + ArrayCode[2] + "^" + ArrayCode[3] + "^" + ArrayCode[4];
                fn_OpenPopCustom("PSM4043.aspx?CODE=" + CODE, 300, 500, CODE);
            }
            else {

                fn_OpenPop("../../Common/ReportView.aspx?RPT=" + DOCNAME + "&CMWKTEAM=" + ArrayCode[0] + "&CMWKDATE=" + ArrayCode[1]
                    + "&CMWKSEQ=" + ArrayCode[2] + "&SMWKORAPPDATE=" + ArrayCode[3] + "&SMWKORSEQ=" + ArrayCode[4], 1000, 600);
            }

            //if (userAgent.match('Tablet') || userAgent.match('iphone') || userAgent.match('ipod') || userAgent.match('ipad') || userAgent.match('iemobile') || userAgent.match('opera mini') || userAgent.match('android') || userAgent.match('webos') || userAgent.match('Blackberry')) {

            //    var CODE = DOCNAME + "^" + ArrayCode[0] + "^" + ArrayCode[1] + "^" + ArrayCode[2] + "^" + ArrayCode[3] + "^" + ArrayCode[4];
            //    fn_OpenPopCustom("PSM4043.aspx?CODE=" + CODE, 300, 500, CODE);
            //}
            //else {
                
            //    fn_OpenPop("../../Common/ReportView.aspx?RPT=" + DOCNAME + "&CMWKTEAM=" + ArrayCode[0] + "&CMWKDATE=" + ArrayCode[1]
            //        + "&CMWKSEQ=" + ArrayCode[2] + "&SMWKORAPPDATE=" + ArrayCode[3] + "&SMWKORSEQ=" + ArrayCode[4], 1000, 600);
            //}
                        
        }

        function GridJSADocClick(APP_NUM) {

            var ArrayCode = APP_NUM.split('-');

            fn_OpenPop("../../Common/ReportView.aspx?RPT=PSM4040_RPT&CMWKTEAM=" + ArrayCode[0] + "&CMWKDATE=" + ArrayCode[1]
                + "&CMWKSEQ=" + ArrayCode[2] + "&SMWKORAPPDATE=" + ArrayCode[3] + "&SMWKORSEQ=" + ArrayCode[4], 1000, 600);
        }

        function WKGridRowClick(gubun) {
            alert(gubun);
        }

        function GridJsaPrt(JSA_NUM) {
            
            var ArrayCode = JSA_NUM.split('-');
            var sessionid = "<%= Session.SessionID %>";

            fn_OpenPop("../../Common/ReportView.aspx?RPT=PSM1090_RPT&SESSIONID=" + sessionid + "&JSMWKGUBN=" + ArrayCode[0] + "&JSMPOTEAM=" + ArrayCode[1]
                + "&JSMPODATE=" + ArrayCode[2] + "&JSMPOSEQ=" + ArrayCode[3] + "&P_JSMDATE=" + ArrayCode[4] + "&P_JSMMSEQ=" + ArrayCode[5]
                + "&P_JSMBLASS=" + ArrayCode[6] + "&P_JSMMLASS=" + ArrayCode[7] + "&P_JSMSLASS=" + ArrayCode[8] + "&P_JSMSEQ=" + ArrayCode[9], 1000, 600);
        }

        function gridClick(r, c) {

            var param = '';

            var rw = grdWorkList.GetRow(r);

            param = rw["APP_NUM"];

            debugger;

            if (c == 0) {

                param = "D-" + param + "-" + r;

                fn_OpenPopCustom("PSM4048.aspx?param=" + param , 1200, 700, param);
            }
            else if (c == 1) {
                fn_OpenPopCustom("PSM4041.aspx?param=NEW&param1=" + param, 1200, 1000, param);
            }

            //$('.tabcontent > div').hide();

            //$('.tabnav a').click(function () {
            //    $('.tabcontent > div').hide().filter(this.hash).fadeIn();
            //    $('.tabnav a').removeClass('active');
            //    $(this).addClass('active');
            //    return false;
            //}).filter(':eq(0)').click();
        }

        // 일일JSA 생성 콜백 함수
        function jsa_popup_callback(RowIndex) {

            var rw = grdWorkList.GetRow(RowIndex);

            var ht = new Object();

            ht["P_JSLWKGUBN"] = "D";
            ht["P_SMWKTEAM"] = rw["APP_NUM"].substr(0, 6);
            ht["P_SMWKDATE"] = rw["APP_NUM"].substr(7, 8);
            ht["P_SMWKSEQ"] = rw["APP_NUM"].substr(16, 3);
            // JSA 조회
            grdJsaList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grdJsaList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            document.getElementById("tab01").style.display = "none";
            document.getElementById("tab02").style.display = "";
            $('#tabli01').removeClass('active');
            $('#tabli02').addClass('active');
        }
        // JSA(변경관리) 콜백 함수
        function jsachange_popup_callback(JSLWKGUBN, SMWKTEAM, SMWKDATE, SMWKSEQ) {

            var ht = new Object();

            ht["P_JSLWKGUBN"] = JSLWKGUBN;
            ht["P_SMWKTEAM"] = SMWKTEAM;
            ht["P_SMWKDATE"] = SMWKDATE;
            ht["P_SMWKSEQ"] = SMWKSEQ;
            // JSA 조회
            grdJsaList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grdJsaList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            document.getElementById("tab01").style.display = "none";
            document.getElementById("tab02").style.display = "";
            $('#tabli01').removeClass('active');
            $('#tabli02').addClass('active');
        }

        // 콜백 함수
        function btnCOPY_Callback(param) {

            debugger;

            // 안전작업 허가서 조회
            if (_id == "SAFE") {

                var data = param.split('-');

                var ht = new Object();

                ht["P_JSLWKGUBN"]     = "D";
                ht["P_SMWKTEAM"]      = data[0];
                ht["P_SMWKDATE"]      = data[1];
                ht["P_SMWKSEQ"]       = data[2];
                ht["P_SMWKORAPPDATE"] = "";

                // 안전작업허가서 조회
                grdSafeList.Params(ht); // 선언한 파라미터를 그리드에 전달함
                grdSafeList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩  

                ht["P_JSLWKGUBN"] = "D";
                ht["P_SMWKTEAM"]  = data[0];
                ht["P_SMWKDATE"]  = data[1];
                ht["P_SMWKSEQ"]   = data[2];
                // JSA 조회
                grdJsaList.Params(ht); // 선언한 파라미터를 그리드에 전달함
                grdJsaList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                document.getElementById("tab01").style.display = "";
                document.getElementById("tab02").style.display = "none";
                $('#tabli01').addClass('active');
                $('#tabli02').removeClass('active');
            }
            else {

                var data = param.split('-');

                var ht = new Object();

                ht["P_JSLWKGUBN"] = "D";
                ht["P_SMWKTEAM"]  = data[1];
                ht["P_SMWKDATE"]  = data[2];
                ht["P_SMWKSEQ"]   = data[3];
                // JSA 조회
                grdJsaList.Params(ht); // 선언한 파라미터를 그리드에 전달함
                grdJsaList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                document.getElementById("tab01").style.display = "none";
                document.getElementById("tab02").style.display = "";
                $('#tabli01').removeClass('active');
                $('#tabli02').addClass('active');
            }
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
                                <asp:ListItem Text="전체"     Value="1,5"></asp:ListItem>
                                <asp:ListItem Text="작업진행" Value="1" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="작업완료" Value="5"></asp:ListItem>
                            </Ctl:Combo>
                        </td>
                        <th>
                            <Ctl:Text ID="txtSMCOSABUN" runat="server" LangCode="lblSabun" Description="감독자"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:SearchView ID="svSMCOSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="">
                                <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" />
                                <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="110" TextBox="true" Default="true" runat="server" />
                            </Ctl:SearchView>
                        </td>
                        <td style="border-left:hidden"></td>
                    </tr>
                    <tr style="text-align:left;">
                        <th>
                            <Ctl:Text ID="lblData" runat="server" LangCode="lblData" Description="요청일자" ></Ctl:Text>
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
                            <Ctl:SearchView ID="svSabun" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="">
                                <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" />
                                <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="110" TextBox="true" Default="true" runat="server" />
                            </Ctl:SearchView>
                        </td>
                        <td style="border-left:hidden"></td>
                    </tr>
                    <tr style="text-align:left;">
                        <th>
                            <Ctl:Text ID="lblWOWORKTITLE" runat="server" LangCode="lblSMWORKTITLE" Description="작업명"></Ctl:Text>
                        </th>
                        <td colspan ="5" style="border-right:hidden">
                            <Ctl:TextBox ID="txtWOWORKTITLE" Width ="370px" runat="server"></Ctl:TextBox>
                        </td>

                        <td style="text-align:right;">
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
                        <Ctl:WebSheet ID="grdWorkList" runat="server" Paging="false" CheckBox="false" HFixation="true"   Height="230" Width="100%" TypeName="PSM.PSM4040" MethodName="UP_GET_WORKORDER_LIST" UseColumnSort="true" HeaderHeight="10" CellHeight="20">

                            <Ctl:SheetHeader TextField="tColumns1" Description="JSA"      Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="0" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns2" Description="허가서"   Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="1" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns3" Description="요청번호" Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="2" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns4" Description="작업내용" Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="3" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns5" Description="작업설비" Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="4" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns6" Description="요청부서" Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="5" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns7" Description="수신부서" Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="7" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns8" Description="작업기간" Align="center" Colspan="2" RowSpan="1" RowIndex="1" ColIndex="9" runat="server" />
                            <Ctl:SheetHeader TextField="tColumns9" Description="상태"     Align="center" Colspan="1" RowSpan="2" RowIndex="1" ColIndex="11" runat="server" />

                            <Ctl:SheetField DataField="JSA_ADD"           TextField="JSA"      Description="JSA"      Width="50"  HAlign="center" Align="center" runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="SAFE_ADD"          TextField="허가서"   Description="허가서"   Width="50"  HAlign="center" Align="center" runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="APP_NUM"           TextField="요청번호" Description="요청번호" Width="140" HAlign="center" Align="left"   runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOWORKTITLE"       TextField="작업내용" Description="작업내용" Width="380" HAlign="center" Align="left"   runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOLOCATIONCODE1NM" TextField="작업설비" Description="작업설비" Width="200" HAlign="center" Align="left"   runat="server" OnClick="grdWorkClick" />

                            <Ctl:SheetField DataField="WOSOTEAMNM"        TextField="부서" Description="부서" Width="100" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOAPPORSABUNNM"    TextField="성명" Description="성명" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WORETEAMNM"        TextField="부서" Description="부서" Width="100" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOAPPREVSABUNNM"   TextField="성명" Description="성명" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WODSDATE1"         TextField="From" Description="From" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WODSDATE2"         TextField="To"   Description="To"   Width="80"  HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />
                            <Ctl:SheetField DataField="WOSTATUS"          TextField="상태" Description="상태" Width="120" HAlign="center" Align="left"  runat="server" OnClick="grdWorkClick" />

                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>

            <div class="tab">

                <ul class="tabnav">
                    <li><a id="tabli01" href="#tab01">안전작업허가서</a></li>
                    <li><a id="tabli02" href="#tab02">일일JSA관리</a></li>
                </ul>
                <div class="tabcontent">
                    <div id="tab01">
                        <table  style="width: 100%;">
                            <tr>
                                <td valign="top">      
                                    <Ctl:WebSheet ID="grdSafeList" runat="server" Paging="false" HFixation="true"   Width="100%"  Height="230" CheckBox="false" TypeName="PSM.PSM4040" MethodName="UP_GET_SAFEORDER_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20" >
                                        
                                        <Ctl:SheetField DataField="SAFECOPY"      TextField="복사"     Description="복사"     Width="60"   HAlign="center" Align="center"  runat="server"  />
                                        <Ctl:SheetField DataField="SAFEDOCPRT"    TextField="허가서"   Description="허가서"   Width="60"   HAlign="center" Align="center"  runat="server"  />
                                        <Ctl:SheetField DataField="JSADOCPRT"     TextField="화기"     Description="화기"     Width="50"   HAlign="center" Align="center"  runat="server"  />
                                        <Ctl:SheetField DataField="SFSTATUS"      TextField="상태"     Description="상태"     Width="80"   HAlign="center" Align="left"    runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="APP_NUM"       TextField="요청번호" Description="요청번호" Width="160"  HAlign="center" Align="left"    runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="OR_NUM"        TextField="허가번호" Description="허가번호" Width="110"  HAlign="center" Align="left"    runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="SWWKNAME"      TextField="작업구분" Description="작업구분" Width="130"  HAlign="center" Align="left"    runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="SMWKMETHOD"    TextField="작업방법" Description="작업방법" Width="100"  HAlign="center" Align="center"  runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="C3NAME1"       TextField="작업설비" Description="작업설비" Width="130"  HAlign="center" Align="left"    runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="SMWORKTITLE"   TextField="작업내용" Description="작업내용" Width="150"  HAlign="center" Align="left"    runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="SMREVTEAMNM"   TextField="작업부서" Description="작업부서" Width="100"  HAlign="center" Align="left"    runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="SMTADATE"      TextField="작업기간" Description="작업기간" Width="150"  HAlign="center" Align="left"    runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="SMORSABUNNM"   TextField="요청자"   Description="요청자"   Width="70"   HAlign="center" Align="center"  runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="SMGRSABUNNM"   TextField="승인자"   Description="승인자"   Width="70"   HAlign="center" Align="center"  runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="SMCOSABUNNM"   TextField="감독자"   Description="감독자"   Width="70"   HAlign="center" Align="center"  runat="server"  OnClick="grdSafeClick" />
                                        <Ctl:SheetField DataField="SMSMSABUNNM"   TextField="안전환경" Description="안전환경" Width="70"   HAlign="center" Align="center"  runat="server"  OnClick="grdSafeClick" />

                                    </Ctl:WebSheet>  
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div id="tab02">
                        <table  style="width: 100%;">
                            <tr>
                                <td valign="top">
                                    <Ctl:WebSheet ID="grdJsaList" runat="server" Paging="false"  HFixation="true"  Width="100%" Height="240" CheckBox="false"  TypeName="PSM.PSM4040" MethodName="UP_GET_JSA_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                                        
                                        <Ctl:SheetField runat="server" DataField="JSACOPY"       Description="복사"     Width= "60"  HAlign="center" Align="center" />
                                        <Ctl:SheetField runat="server" DataField="JSAPRT"        Description="출력"     Width= "60"  HAlign="center" Align="center" />
                                        <Ctl:SheetField runat="server" DataField="JSLDATE"       Description="작성일자" Width= "80"  HAlign="center" Align="left" OnClick="grdJsaClick"/>
                                        <Ctl:SheetField runat="server" DataField="JSLSEQ"        Description="순번"     Width= "50"  HAlign="center" Align="left" OnClick="grdJsaClick"/>
                                        <Ctl:SheetField runat="server" DataField="JBCODE"        Description="대분류명" Width= "100" HAlign="center" Align="left" OnClick="grdJsaClick"/>
                                        <Ctl:SheetField runat="server" DataField="JMCODE"        Description="중분류명" Width= "100" HAlign="center" Align="left" OnClick="grdJsaClick"/>
                                        <Ctl:SheetField runat="server" DataField="JSCODE"        Description="소분류명" Width= "100" HAlign="center" Align="left" OnClick="grdJsaClick"/>
                                        <Ctl:SheetField runat="server" DataField="JSMSEQ"        Description="순번"     Width= "30"  HAlign="center" Align="left" OnClick="grdJsaClick"/>
                                        <Ctl:SheetField runat="server" DataField="JSMWKNAME"     Description="작업명"   Width= "300" HAlign="center" Align="left" OnClick="grdJsaClick"/>
                                        <Ctl:SheetField runat="server" DataField="H1CODE"        Description="도면번호" Width= "100" HAlign="center" Align="left" OnClick="grdJsaClick"/>
                                        <Ctl:SheetField runat="server" DataField="JSMMSDS"       Description="MSDS"     Width= "100" HAlign="center" Align="left" OnClick="grdJsaClick"/>
                                        <Ctl:SheetField runat="server" DataField="JSLWRSABUNNM"  Description="작성자"   Width= "100" HAlign="center" Align="left" OnClick="grdJsaClick"/>

                                    </Ctl:WebSheet>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </Ctl:Layer>
    </div>
</asp:content>
