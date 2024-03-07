<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AM102021P.aspx.cs" Inherits="TaeYoung.Portal.Admin.Cmn.AM102021P" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="conHead">
	
    <script type="text/javascript">
        var langcd = "<%= TaeYoung.Biz.Document.ClientCultureName %>";
        var dept = '<Ctl:Text runat="server" LangCode="DEPT" Description="부서" Literal="true"></Ctl:Text>';
        var user = '<Ctl:Text runat="server" LangCode="DEPT" Description="유저" Literal="true"></Ctl:Text>';
        var _programID = "";
        /********************************************************************************************
        * 함수명      : OnLoad()
        * 작성목적    : OnLoad 
        * Parameter   :
        * Return
        * 작성자     : 장윤호
        * 최초작성일   : 2014-10-20
        * 최종작성일   :
        * 수정내역    :
        ********************************************************************************************/
        function OnLoad() {
            _programID = QueryString("p");

            if (_programID == "") {
                if (alert('<Ctl:Text runat="server" LangCode="MSG02" Description="잘못된 접근 경로 입니다." Literal="true"></Ctl:Text>') == null) {
                    self.close();
                }
                return false;
            }

            grid2.CallBack = function () {
                var all = grid2.GetAllRow();
                for (var i = 0; i < ObjectCount(all.Rows); i++) {
                    var dr = all.Rows[i];

                    if (dr["USRTYPE"] == "1") {
                        grid2.SetValue(i, "USRTYPENM", user);
                    }
                    else if (dr["USRTYPE"] == "2") {
                        grid2.SetValue(i, "USRTYPENM", dept);
                    }
                }
            };

            grid3.CallBack = function () {
                var dt = grid3.GetAllRow(); // 전체데이터

                if (dt) {
                    for (var i = 0; i < ObjectCount(dt.Rows); i++) {
                        if (dt.Rows[i]["RETIREYN"] == "Y") {
                            grid3.GetCellColumnName(i, "EMPID").children[0].style.color = "#FF0000";
                            grid3.GetCellColumnName(i, "EMPID").children[0].style.textDecoration = "line-through";
                        }
                    }
                }
            };

            BindPage();
        }

        function BindPage() {
            var ht = new Object();
            ht["PROGRAMID"] = _programID;
            ht["LANGCD"] = langcd;

            PageMethods.InvokeServiceTable(ht, "Common.AclBiz", "GetAclGroup", BindPage_Callback);

        }

        function BindPage_Callback(e) {
            var ds = eval(e);

            if (ds.Tables[0].Rows.length == 0) {
                if (alert('<Ctl:Text runat="server" LangCode="MSG02" Description="잘못된 접근 경로 입니다." Literal="true"></Ctl:Text>') == null) {
                    self.close();
                }
                return false;
            }

            var cnt = 0;
            for (var i = 0; i < ds.Tables[1].Rows.length; i++) {
                cnt += Number(ds.Tables[1].Rows[i]["USR_CNT"]);
            }

            // 헤더 바인딩
            var dr = ds.Tables[0].Rows[0];
            txtPROGRAMID.SetValue(dr["PROGRAMID"]);
            txtPROGRAMNM.SetValue(dr["PROGRAMNM"]);
            txtGRPCNT.SetValue(dr["GRP_CNT"]);
            var str = "";
            str += '<span style="color:#0000FF;">' + GetNumberLocale(dr["EMP_CNT"].toString(), Use_Language) + '</span> / ';
            str += '<span style="color:#B93333; font-weight:bold;">' + GetNumberLocale(cnt.toString(), Use_Language) + '</span>';
            txtUSRCNT.SetValue(str);

            //그룹 목록 바인딩
            grid1.DataBind(ds.Tables[1]);

            // 그룹멤버 콤보 바인딩
            BindCombo(ds.Tables[1]);

            // 그룹멤버 바인딩
            BindGrid2();

            // 그룹멤버 사용자 바인딩     BindGrid2() 안에 있음으로 주석
            //txtUSRID.SetValue("");
            //txtUSRTYPE.SetValue("");
            //BindGrid3();
        }

        /********************************************************************************************
        * 함수명      : btnSelect_Click()
        * 작성목적    : 그룹 선택 버튼 
        * Parameter   :
        * Return
        * 작성자     : 장윤호
        * 최초작성일   : 2014-10-20
        * 최종작성일   :
        * 수정내역    :
        ********************************************************************************************/
        function btnSelect_Click() {
            var o = grid1.GetCheckRow(); // 체크된 전체데이터
            if (ObjectCount(o) <= 0) {
                alert('<Ctl:Text ID="MSG01" runat="server" LangCode="MSG01" Description="그룹을 선택하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (window != null && window.opener != null) {
                window.opener.groupSelect(o);
                self.close();
            }

            return false;
        }

        function grid1_RowClick(r, c) {
            var row = grid1.GetRow(r);

            if (c == 0) {
//                var win = window.open("/GW/AM010/Popup/AM0102020.aspx?GrpID=" + row["GRPID"], "AM0102020", "top=100, left=500, width=700, height=700, toolbar=no, directories=no, location=no, status=no, menubar=no, scrollbars=yes, resizable=no");
//                win.focus();
                return false;
            }
            else {
                cboGRP.SetValue(row["GRPID"]);
                BindGrid2();
            }
        }

        function grid2_RowClick(r, c) {
            var row = grid2.GetRow(r);
            txtUSRID.SetValue(row["USRID"]);
            txtUSRTYPE.SetValue(row["USRTYPE"]);
            BindGrid3();
        }

        function BindCombo(dt) {
            var c = cboGRP.Control;
            $(c).find("option").remove();
            $(c).append("<option value=''>ALL</option>");
            for (i = 0; i < ObjectCount(dt.Rows); i++) {
                var dr = dt.Rows[i];
                $(c).append("<option value='" + dr["GRPID"] + "'>" + dr["GRPNAME"] + "</option>");
            }
        }

        function BindGrid2() {
            var ht = new Object();
            ht["PROGRAMID"] = _programID;
            ht["LANGCD"] = langcd;
            ht["GRPID"] = cboGRP.GetValue();

            grid2.Params(ht);
            grid2.BindList(1);

            txtUSRID.SetValue("");
            txtUSRTYPE.SetValue("");

            BindGrid3();

            return false;
        }

        function BindGrid3() {
            var ht = new Object();
            ht["LANGCD"] = langcd;
            ht["PROGRAMID"] = _programID;
            ht["GRPID"] = cboGRP.GetValue();
            ht["USRTYPE"] = txtUSRTYPE.GetValue();
            ht["USRID"] = txtUSRID.GetValue();
            ht["EMPNM"] = txtEMPNM.GetValue();
            ht["RETIREYN"] = ObjectCount(chkRETIREYN.GetValue()) == 1 ? "Y" : "";

            grid3.Params(ht);
            grid3.BindList(1);

            return false;
        }

        /********************************************************************************************
        * 함수명      : btnGroup_Add_Click()
        * 작성목적    : 권한그룹추가 버튼 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2016-07-12
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btnGroup_Add_Click() {
            ShowPopup("AM102033P.aspx?MENUID=" + txtPROGRAMID.GetValue(), "그룹선택", 500, 500);
            return false;
        }

        /********************************************************************************************
        * 함수명      : SelectGrpID()
        * 작성목적    : 그룹 권한 저장 이벤트
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2016-07-12
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function SelectGrpID(rows) {
            PageProgressShow();

            var ACLID = txtPROGRAMID.GetValue();

            var tmp = new Object();
            var hts = new Array();

            for (i = 0; i < ObjectCount(rows); i++) {
                var ht = new Object();
                ht["ACL_GRP"] = rows[i]["GRPID"];
                ht["ACL_ID"] = ACLID;
                hts.push(ht);
            }

            PageMethods.InvokeServiceTableArray(ht, hts, "Common.AclBiz", "AddMenuGrpAcl", function (e) {
                alert('<Ctl:Text runat="server" LangCode="MSG03" Description="저장되었습니다." Literal="true"></Ctl:Text>');

                BindPage();

                PageProgressHide();
            }, function (e) {
                alert(e.get_message());
                PageProgressHide();
            });
        }

        function GetNumberLocale(c, r) {
            return c;
        }
	</script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="conBody">

	<!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="프로그램별 권한관리" Literal="true" ></Ctl:Text>
        </h4>

        <div class="btn_bx">
			<Ctl:Button ID="btnSelect" runat="server" Style="Orange" LangCode="BTN01" Description="닫기" OnClientClick="window.close(); return false;"></Ctl:Button>
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">
		<Ctl:Layer ID="layer1" runat="server">
            <table class="table_01" style="width:100%;">
                <colgroup>
                    <col width="10%" />
                    <col width="15%" />
                    <col width="10%" />
                    <col width="15%" />
                    <col width="10%" />
                    <col width="15%" />
                    <col width="10%" />
                    <col width="15%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT001" runat="server" LangCode="TXT001" Description="Program ID" Literal="true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Text ID="txtPROGRAMID" runat="server"></Ctl:Text>
                    </td>
                    <th>
                        <Ctl:Text ID="TXT002" runat="server" LangCode="TXT002" Description="Program 명" Literal="true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Text ID="txtPROGRAMNM" runat="server"></Ctl:Text>
                    </td>
                    <th>
                        <Ctl:Text ID="TXT003" runat="server" LangCode="TXT003" Description="권한 그룹 수" Literal="true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Text ID="txtGRPCNT" runat="server"></Ctl:Text>
                    </td>
                    <th>
                        <Ctl:Text ID="TXT004" runat="server" LangCode="TXT004" Description="그룹 사용자 수" Literal="true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Text ID="txtUSRCNT" runat="server"></Ctl:Text>
                    </td>
                </tr>
            </table>
			<!-- 내용 영역 -->
            <div style="width:100%; position:relative; margin-top:10px;">
                <div style="width:30%; float:left; border-top:1px solid #C8C8C8;">
                    <Ctl:WebSheet ID="grid1" runat="server" Paging="false" CheckBox="false" Width="100%" CellHeight="18" HFixation="true" height="500">
                        <ul class="search" style="height:30px;">
                            <li style="width:60px; font-weight:bold; line-height:30px;">
                                <Ctl:Text ID="TXT010" runat="server" LangCode="TXT010" Description="그룹목록" Literal="True" />
                            </li>
                            <li style="float:right;">
                                <Ctl:Button ID="btnGroup_Add" runat="server" Style="Orange" LangCode="BTN03" Description="권한그룹추가" OnClientClick="return btnGroup_Add_Click();"></Ctl:Button>
                            </li>
                        </ul>

                        <Ctl:SheetField DataField="GRPID" TextField="Grid01" Description="그룹ID" Width="30%"  HAlign="center" Align="left" OnClick="grid1_RowClick" runat="server" />
			            <Ctl:SheetField DataField="GRPNAME" TextField="Grid02" Description="그룹명" Width="*"  HAlign="center" Align="left" OnClick="grid1_RowClick" runat="server" />
                        <Ctl:SheetField DataField="USR_CNT" TextField="Grid03" Description="권한자" Width="20%"  HAlign="center" Align="right" OnClick="grid1_RowClick" runat="server" />

                    </Ctl:WebSheet>
                </div>
                <div style="width:39%; float:left; margin-left:0.5%; margin-right:0.5%; border-top:1px solid #C8C8C8;">
                    <Ctl:WebSheet ID="grid2" runat="server" Paging="false" CheckBox="false" Width="100%" CellHeight="18" HFixation="true" height="500" TypeName="Common.AclBiz" MethodName="GetAclGroupMember">
                        <ul class="search" style="height:30px;">
                            <li style="width:60px; font-weight:bold; line-height:30px;">
                                <Ctl:Text ID="TXT011" runat="server" LangCode="TXT011" Description="그룹멤버" Literal="True" />
                            </li>
                            <li style="width:60px; line-height:30px;">
                                <Ctl:Combo ID="cboGRP" runat="server" OnChange="return BindGrid2();" />
                            </li>
                        </ul>

                        <Ctl:SheetField DataField="GRPNAME" TextField="Grid02" Description="그룹명" Width="25%"  HAlign="center" Align="left" OnClick="grid2_RowClick" runat="server" />
                        <Ctl:SheetField DataField="USRTYPENM" TextField="Grid10" Description="유형" Width="15%"  HAlign="center" Align="center" OnClick="grid2_RowClick" runat="server" />
                        <Ctl:SheetField DataField="USRID" TextField="Grid11" Description="멤버ID" Width="20%"  HAlign="center" Align="left" OnClick="grid2_RowClick" runat="server" />
                        <Ctl:SheetField DataField="USRNM" TextField="Grid12" Description="멤버명" Width="30%"  HAlign="center" Align="left" OnClick="grid2_RowClick" runat="server" />
                        <Ctl:SheetField DataField="USR_CNT" TextField="Grid13" Description="수" Width="10%"  HAlign="center" Align="right" OnClick="grid2_RowClick" runat="server" />

			        </Ctl:WebSheet>
                </div>
                <div style="width:30%; float:left;">
                    <Ctl:WebSheet ID="grid3" runat="server" Paging="true" CheckBox="false" Width="100%" CellHeight="18" HFixation="true" height="400" TypeName="Common.AclBiz" MethodName="GetAclGroupUser">
                        <ul class="search" style="height:30px; border-top:1px solid #C8C8C8;">
                            <li style="width:60px; font-weight:bold; line-height:30px;">
                                <Ctl:Text ID="TXT012" runat="server" LangCode="TXT012" Description="사용자조회" Literal="true" />
                                <div style="display:none;">
                                    <Ctl:Text ID="txtUSRID" runat="server" />
                                    <Ctl:Text ID="txtUSRTYPE" runat="server" />
                                </div>
                            </li>
                            <li style="line-height:30px;">
                                <Ctl:TextBox ID="txtEMPNM" runat="server" Width="100px"/>
                            </li>
                            <li style="line-height:30px;">
                                <Ctl:CheckBox ID="chkRETIREYN" runat="server" RepeatColumns="1">
                                    <asp:ListItem Value="1" LangCode="TXT13" Description="퇴직자조회"></asp:ListItem>
                                </Ctl:CheckBox>
                            </li>
                            <li style="float:right;">
                                <Ctl:Button ID="btnSEARCH" runat="server" Style="Orange" LangCode="BTN02" Description="조회" OnClientClick="return BindGrid3();"></Ctl:Button>
                            </li>
                        </ul>

                        <Ctl:SheetField DataField="COMPANY" TextField="Grid31" Description="법인명" Width="20%"  HAlign="center" Align="left" runat="server" />
                        <Ctl:SheetField DataField="DEPTNM" TextField="Grid32" Description="부서명" Width="20%"  HAlign="center" Align="left" runat="server" />
                        <Ctl:SheetField DataField="USRNM" TextField="Grid12" Description="멤버명" Width="20%"  HAlign="center" Align="left" runat="server" />
                        <Ctl:SheetField DataField="EMPID" TextField="Grid21" Description="사번" Width="20%"  HAlign="center" Align="left" runat="server" />
                        <Ctl:SheetField DataField="EMPNM" TextField="Grid22" Description="이름" Width="20%"  HAlign="center" Align="left" runat="server" />

			        </Ctl:WebSheet>
                </div>
            </div>
		</Ctl:Layer>
	</div>
</asp:Content>