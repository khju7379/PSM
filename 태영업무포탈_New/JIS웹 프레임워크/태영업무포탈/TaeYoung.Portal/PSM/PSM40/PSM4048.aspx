<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4048.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4048" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _JSLWKGUBN = "";
        var _JSLWKTEAM = "";
        var _JSLWKDATE = "";
        var _JSLWKSEQ = "";
        var _RowIndex = "";

        // 페이지 로드
        function OnLoad() {

            var Code = "<%= Request.QueryString["param"] %>";

            var data = Code.split('-');
            var today = new Date();

            _JSLWKGUBN = data[0];
            _JSLWKTEAM = data[1];
            _JSLWKDATE = data[2];
            _JSLWKSEQ = data[3];
            _RowIndex = data[4];

            var ht = new Object();
            ht["GUBUN"] = "S";

            cboJSMBLASS.TypeName = "PSM.PSM1080";
            cboJSMBLASS.MethodName = "UP_GET_JSA_BCODE_LIST";
            cboJSMBLASS.DataTextField = "J1CODENAME";
            cboJSMBLASS.DataValueField = "J1CODE";
            cboJSMBLASS.Params(ht);
            cboJSMBLASS.BindList();

            txtJSLDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));  //작성일자

            cboJSMBLASS_Change();

            $("#gridIndex_chkall").attr("style", "display:none;");
        }

        // 대분류 선택 이벤트
        function cboJSMBLASS_Change() {

            var ht = new Object();
            ht["BCODE"] = cboJSMBLASS.GetValue();
            ht["GUBUN"] = "S";

            cboJSMMLASS.TypeName = "PSM.PSM1080";
            cboJSMMLASS.MethodName = "UP_GET_JSA_MCODE_LIST";
            cboJSMMLASS.DataTextField = "J2CODENAME";
            cboJSMMLASS.DataValueField = "J2MCODE";
            cboJSMMLASS.Params(ht);
            cboJSMMLASS.BindList();

            cboJSMMLASS_Change();
            //return false;
        }

        // 중분류 선택 이벤트
        function cboJSMMLASS_Change() {

            var ht = new Object();
            ht["BCODE"] = cboJSMBLASS.GetValue();
            ht["MCODE"] = cboJSMMLASS.GetValue();
            ht["GUBUN"] = "S";

            cboJSMSLASS.TypeName = "PSM.PSM1080";
            cboJSMSLASS.MethodName = "UP_GET_JSA_SCODE_LIST";
            cboJSMSLASS.DataTextField = "J3CODENAME";
            cboJSMSLASS.DataValueField = "J3SCODE";
            cboJSMSLASS.Params(ht);
            cboJSMSLASS.BindList();

            //return false;
        }

        // 조회 버튼
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            gridDetail.RemoveAllRow();

            ht["P_JSMBLASS"] = cboJSMBLASS.GetValue();
            ht["P_JSMMLASS"] = cboJSMMLASS.GetValue();
            ht["P_JSMSLASS"] = cboJSMSLASS.GetValue();
            ht["P_JSMWKNAME"] = txtJSMWKNAME.GetValue();
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridIndex.CallBack = function () {

                var dt = gridIndex.GetAllRow();
                var grd_chk = document.getElementsByName("gridIndex_chk");

                for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                    var dr = dt.Rows[i];

                    grd_chk[i].setAttribute('onclick', 'gridindexCheck(' + i + ')');
                }
            };
        }

        

        // j일일JSA 생성 버튼
        function btnCreate_Click() {

            var checkRows = gridIndex.GetCheckRow();

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다. 
            var hts = new Array();

            ht["P_WOORTEAM"] = _JSLWKTEAM;
            ht["P_WOORDATE"] = _JSLWKDATE;
            ht["P_WOSEQ"] = _JSLWKSEQ;
            ht["P_COPYDATE"] = txtJSLDATE.GetValue();

            if (checkRows.length > 0) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM4045", "UP_WORKORDER_FINISH_CHECK", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                        alert('<Ctl:Text runat="server"  Description="공사완료된 작업요청건입니다." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else {

                        PageMethods.InvokeServiceTable(ht, "PSM.PSM4045", "UP_SAFEORDER_CHECK", function (e) {

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) > 0 && _JSLWKGUBN == "D") {
                                alert('<Ctl:Text runat="server"  Description="안전작업허가서 자료가 존재합니다." Literal="true"></Ctl:Text>');
                                return false;
                            }
                            else {

                                for (i = 0; i < checkRows.length; i++) {

                                    // 일일JSA 생성
                                    ht = new Object();

                                    ht["P_JSLWKGUBN"] = _JSLWKGUBN;
                                    ht["P_JSLWKTEAM"] = _JSLWKTEAM;
                                    ht["P_JSLWKDATE"] = _JSLWKDATE;
                                    ht["P_JSLWKSEQ"] = _JSLWKSEQ;
                                    ht["P_JSLDATE"] = txtJSLDATE.GetValue();
                                    ht["P_JSMBLASS"] = checkRows[i]['JSMBLASS'];
                                    ht["P_JSMMLASS"] = checkRows[i]['JSMMLASS'];
                                    ht["P_JSMSLASS"] = checkRows[i]['JSMSLASS'];
                                    ht["P_JSMSEQ"] = checkRows[i]['JSMSEQ'];

                                    hts.push(ht);
                                }

                                ht = new Object();
                                ht["P_WOSTATUS"] = "2";  // 일일JSA 생성
                                ht["P_WOORTEAM"] = _JSLWKTEAM;
                                ht["P_WOORDATE"] = _JSLWKDATE;
                                ht["P_WOSEQ"] = _JSLWKSEQ;

                                if (confirm('<Ctl:Text runat="server" Description="생성 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {
                                    PageMethods.InvokeServiceTableArray(ht, hts, "PSM.PSM4045", "UP_JSACHANGE_CREATE", function (e) {
                                        alert('<Ctl:Text runat="server" Description="생성이 완료 되었습니다." Literal="true"></Ctl:Text>');

                                        if (opener != null && typeof (opener.jsa_popup_callback) == "function") {
                                            opener.jsa_popup_callback(_RowIndex);
                                        }
                                        this.close();

                                    }, function (e) {
                                        // Biz 연결오류
                                        alert('<Ctl:Text runat="server" Description="생성 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                    });
                                }
                            }
                        }, function (e) {
                            // Biz 연결오류
                            alert("Error");
                        });
                    }
                }, function (e) {
                    // Biz 연결오류  
                    alert("Error");
                });
            }
            else {
                alert("JSA 자료를 선택하세요!");
            }
        }

        // 닫기 버튼
        function btnClose_Click() {

            this.close();            
        }

        // 그리드 체크박스 선택 이벤트
        function gridindexCheck(r) {

            var dt = gridIndex.GetAllRow();
            var grd_chk = document.getElementsByName("gridIndex_chk");

            for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                var dr = dt.Rows[i];
                var rowId = "gridIndex_MainRow_" + i.toString();

                if (r != i) {
                    grd_chk[i].checked = false;

                    if (i % 2 == 0) {
                        $("#" + rowId).attr("style", "background:rgb(255, 255, 255);");
                    }
                    else {
                        $("#" + rowId).attr("style", "background:rgb(249, 249, 249);");
                    }
                }
                else {
                    $("#" + rowId).attr("style", "background:rgb(234, 234, 234);");
                }
            }

            var rw = gridIndex.GetRow(r);

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            var sessionid = "<%= Session.SessionID %>";

            ht["SESSIONID"] = sessionid;
            ht["P_MENU_NAME"] = rw["JSMBLASS"] + "_" + rw["JSMMLASS"] + "_" + rw["JSMSLASS"] + "_" + rw["JSMSEQ"];
            ht["GUBUN"] = "P";

            gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 그리드 선택 이벤트
        function gridClick(r, c) {

            var dt = gridIndex.GetAllRow();
            var grd_chk = document.getElementsByName("gridIndex_chk");

            for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                var dr = dt.Rows[i];

                if (r == i) {
                    grd_chk[i].checked = true;
                }
            }

            gridindexCheck(r);
        }

        function Set_Fill3(sFirst) {
            
            if (sFirst.toString().length == 1) {

                sFirst = "00" + sFirst.toString();
            }
            else if (sFirst.toString().length == 2) {

                sFirst = "0" + sFirst.toString();
            }
            else if (sFirst.toString().length == 3) {
                sFirst = sFirst.toString();
            }
            else {
                sFirst = '000';
            }

            return sFirst;
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="JSA 조회" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
            <Ctl:Button ID="btnSearch" runat="server" Style="Orange" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
            <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server">
            <table class="table_01" style="width:100%;" border="0">
                <colgroup>
                    <col width="60px" />
                    <col width="120px" />
                    <col width="60px" />
                    <col width="170px" />
                    <col width="60px" />
                    <col width="170px" />
                    <col width="60px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th style="text-align:left">
                        <Ctl:Text ID="lblJSMBLASS" runat="server" LangCode="lblJSMBLASS" Description="대분류" ></Ctl:Text>
                    </th>
                    <td style="text-align:left">
                        <Ctl:Combo ID="cboJSMBLASS" Width="100px" runat="server" OnChange= "cboJSMBLASS_Change()">
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th style="text-align:left">
                        <Ctl:Text ID="lblJSMMLASS" runat="server" LangCode="lblJSMMLASS" Description="중분류" ></Ctl:Text>
                    </th>
                    <td style="text-align:left">
                        <Ctl:Combo ID="cboJSMMLASS" Width="200px" runat="server"  OnChange= "cboJSMMLASS_Change()">
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th style="text-align:left">
                        <Ctl:Text ID="lblJSMSLASS" runat="server" LangCode="lblJSMSLASS" Description="소분류" ></Ctl:Text>
                    </th>
                    <td style="text-align:left">
                        <Ctl:Combo ID="cboJSMSLASS" Width="230px" runat="server" RepeatColumns="2" >
                            <asp:ListItem Selected="True" Text="전체" Value=""></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th style="text-align:left">
                        <Ctl:Text ID="lblJSMSEQ" runat="server" LangCode="lblJSMSEQ" Description="작업명" ></Ctl:Text>
                    </th>
                    <td colspan="5" style="text-align:left">
                        <Ctl:TextBox ID="txtJSMWKNAME" Width="300px" runat="server" LangCode="txtJSMWKNAME" Description="작업명"></Ctl:TextBox>
                    </td>
                </tr>
            </table>
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="true" Width="100%" HFixation="true" Height="190" TypeName="PSM.PSM4045" MethodName="UP_JSA_MASTER_LIST" UseColumnSort="true" HeaderHeight="10" CellHeight="10">
                <Ctl:SheetField DataField="JSMBLASS" TextField="대분류코드" Description="대분류코드" Width="60"  HAlign="center" Align="left"  runat="server" hidden="true" />
                <Ctl:SheetField DataField="JSMMLASS" TextField="중분류코드" Description="중분류코드" Width="60"  HAlign="center" Align="left"  runat="server" hidden="true" />
                <Ctl:SheetField DataField="JSMSLASS" TextField="소분류코드" Description="소분류코드" Width="60"  HAlign="center" Align="left"  runat="server" hidden="true" />
                <Ctl:SheetField DataField="JBCODE" TextField="대분류" Description="대분류" Width="150"  HAlign="center" Align="left"  runat="server"  OnClick="gridClick"/>
                <Ctl:SheetField DataField="JMCODE" TextField="중분류" Description="중분류" Width="150"  HAlign="center" Align="left"  runat="server"  OnClick="gridClick"/>
                <Ctl:SheetField DataField="JSCODE" TextField="소분류" Description="소분류" Width="150" HAlign="center" Align="left"  runat="server"  OnClick="gridClick"/>
                <Ctl:SheetField DataField="JSMSEQ" TextField="순번" Description="순번" Width="40" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                <Ctl:SheetField DataField="JSMWKNAME" TextField="작업명" Description="작업명" Width="250" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                <Ctl:SheetField DataField="JSMSECTIONNUM" TextField="도면번호" Description="도면번호" Width="150" HAlign="center" Align="left"  runat="server" hidden="true"/>
                <Ctl:SheetField DataField="H1CODE" TextField="도면번호" Description="도면번호" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                <Ctl:SheetField DataField="JSMMSDS" TextField="MSDS" Description="MSDS" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
            </Ctl:WebSheet>
            <table class="table_01" style="width:100%;" border="0">
                <colgroup>
                    <col width="60px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th style="text-align:left">
                        <Ctl:Text ID="lblJSLDATE" runat="server" LangCode="lblJSMBLASS" Description="작성일자" ></Ctl:Text>
                    </th>
                    <td style="text-align:left">
                        <Ctl:TextBox ID="txtJSLDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                    
                        <Ctl:Button ID="btnCreate" runat="server" Style="Orange" LangCode="btnCreate" Description="일일JSA 생성" OnClientClick="btnCreate_Click();" ></Ctl:Button>
                    </td>
                </tr>
            </table>
            <Ctl:WebSheet ID="gridDetail" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="260" TypeName="PSM.PSM1090" MethodName="UP_JSA_PRT_LIST" UseColumnSort="true" HeaderHeight="10" CellHeight="10">
                <Ctl:SheetField DataField="PRITEMTEXT" TextField="작업단계" Description="작업단계" Width="100"  HAlign="center" Align="left"  runat="server"  />
                <Ctl:SheetField DataField="PRRISKTEXT" TextField="위험성" Description="위험성" Width="100"  HAlign="center" Align="left"  runat="server"  />
                <Ctl:SheetField DataField="PREREFORMTEXT" TextField="개선대책" Description="개선대책" Width="200" HAlign="center" Align="left"  runat="server"  />
                <Ctl:SheetField DataField="PRTOOLTEXT" TextField="장비 및 도구" Description="장비 및 도구" Width="200" HAlign="center" Align="left"  runat="server"  />
            </Ctl:WebSheet>
		</Ctl:Layer>
	</div>
</asp:content>