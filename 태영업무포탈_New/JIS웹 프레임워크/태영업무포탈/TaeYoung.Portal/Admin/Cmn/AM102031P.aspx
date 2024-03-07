<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AM102031P.aspx.cs" Inherits="TaeYoung.Portal.Admin.Cmn.AM102031P" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="conHead">
	<script src="/Resources/Script/OrgChart.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript">
        var dept = '<Ctl:Text runat="server" LangCode="DEPT" Description="부서" Literal="true"></Ctl:Text>';
        var user = '<Ctl:Text runat="server" LangCode="DEPT" Description="유저" Literal="true"></Ctl:Text>';
        /******************************************************************************************
        * 함수명 : OnLoad 
        * 설  명 : 페이지 로드
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function OnLoad() {
            grid1.CallBack = function () {
                var all = grid1.GetAllRow();
                for (var i = 0; i < ObjectCount(all.Rows); i++) {
                    var dr = all.Rows[i];
                    if (dr["USRTYPE"] == "1") {
                        grid1.SetValue(i, "USRTYPENM", user);
                    }
                    else if (dr["USRTYPE"] == "2") {
                        grid1.SetValue(i, "USRTYPENM", dept);
                    }
                }
            };
            var ht = new Object();
            ht["GRPID"] = txtGroupCode.GetValue();

            if (ht["GRPID"] != "") {
                PageMethods.InvokeServiceTable(ht, "Common.AclBiz", "GetGroupInfo", BindPage, function (e) { alert(e.get_message()); });
            }
        }

        /******************************************************************************************
        * 함수명 : OnLoad 
        * 설  명 : 페이지 바인딩
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function BindPage(e) {
            var DataSet = eval(e);
            if (DataSet && DataSet.Tables[0].Rows.length != 0) {
                var result = DataSet.Tables[0].Rows[0];

                txtGroupCode.SetValue(result["GRPID"]);
                cboGRPTYPE.SetValue(result["GRPTYPE"]);
                txtGrpExt.SetValue(result["GRPEXT"]);
                rdoUseYn.SetValue(result["USEYN"]);
                txtKorGroupName.SetValue(result["GRPNAME_KO"]);
                txtEnGroupName.SetValue(result["GRPNAME_EN"]);
                txtCnGroupName.SetValue(result["GRPNAME_CN"]);
                txtEsGroupName.SetValue(result["GRPNAME_ES"]);
                txtEt1GroupName.SetValue(result["GRPNAME_ET1"]);

                var ht = new Object();
                ht["GRPID"] = txtGroupCode.GetValue();

                if (ht["GRPID"] != "") {
                    grid1.Params(ht);
                    grid1.BindList(1)
                };
            }
        }

        /******************************************************************************************
        * 함수명 : fn_ManagerAdd 
        * 설  명 : 담당자 추가
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function fn_ManagerAdd() {
            om_OpenOrgChart({ callback: fn_CallBack, appType: 'deptuser', oneSelect: false });
            return false;
        }

        /******************************************************************************************
        * 함수명 : fn_CallBack 
        * 설  명 : 담당자 추가 Callback
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function fn_CallBack(data) {
            // 필드 바인딩
            var orgchartObj;
            if (typeof (data) == "string" && data.length > 0) {
                OrgData = data;
                if (data.toLowerCase().indexOf("<?xml") > -1) {
                    orgchartObj = parseXML(data);
                }
                else {
                    orgchartObj = eval(data);
                }
            }
            var data = "";
            var idx = (grid1.GetAllRow() == null) ? 0 : ObjectCount(grid1.GetAllRow().Rows);

            if (orgchartObj) {
                for (var i = 0; i < orgchartObj.length; i++) {
                    // 그룹 리턴은 추가되어야함
                    grid1.InsertRow();
                    if (orgchartObj[i].EmpID == "") { // 그룹
                        grid1.SetValue(idx, "USRID", orgchartObj[i].DeptCode);                      // 부서코드
                        grid1.SetValue(idx, "USRNM", orgchartObj[i].DisplayName);                   // 부서명
                        grid1.SetValue(idx, "USRTYPENM", dept);                                     // 부서
                        grid1.SetValue(idx, "USRTYPE", "2");
                        grid1.SetValue(idx, "COMPANYCODE", orgchartObj[i].CompanyCode);             // 법인코드
                        grid1.SetValue(idx, "COMPANYNAME", orgchartObj[i].CompanyName);             // 법인명
                        grid1.SetValue(idx, "ORI_COMPANYCODE", orgchartObj[i].CompanyCode);         // 사용자 법인코드
                        grid1.SetValue(idx, "ORI_COMPANYNAME", orgchartObj[i].CompanyName);         // 사용자 법인명
                    }
                    else {
                        grid1.SetValue(idx, "USRID", orgchartObj[i].EmpID);                         // 사번
                        grid1.SetValue(idx, "USRNM", orgchartObj[i].DisplayName);                   // 이름
                        grid1.SetValue(idx, "USRTYPENM", user);                                     // 유저
                        grid1.SetValue(idx, "USRTYPE", "1");
                        grid1.SetValue(idx, "COMPANYCODE", orgchartObj[i].SiteCompanyCode);         // 법인코드
                        grid1.SetValue(idx, "COMPANYNAME", orgchartObj[i].SiteCompanyName);         // 법인명
                        grid1.SetValue(idx, "ORI_COMPANYCODE", orgchartObj[i].CompanyCode);         // 사용자 법인코드
                        grid1.SetValue(idx, "ORI_COMPANYNAME", orgchartObj[i].CompanyName);         // 사용자 법인명
                    }
                    idx++;
                }
            }
        }

        /******************************************************************************************
        * 함수명 : fn_btnClose 
        * 설  명 : 닫기
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function fn_btnClose() {
            window.close();
            return false;
        }

        /******************************************************************************************
        * 함수명 : fn_btnClose 
        * 설  명 : 그리도 row 클릭 이벤트
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function Grid1RowClick() {
            return false;
        }

        /******************************************************************************************
        * 함수명 : RowRemove 
        * 설  명 : 선택된 담당자 삭제
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function RowRemove() {
            var o = grid1.GetCheckRow(); // 체크된 전체데이터
            if (o == null) return;
            var check_idx = new Array();

            for (i = 0; i < ObjectCount(o); i++) {
                for (j = 0; j < ObjectCount(grid1.CurrData.Rows); j++) {
                    if (grid1.CurrData.Rows[j] == o[i]) {
                        check_idx.push(j);
                    }
                }
            }

            // 삭제
            grid1.RemoveRows(check_idx);

            return false;
        }

        /******************************************************************************************
        * 함수명 : btnSave_Click 
        * 설  명 : 저장
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function btnSave_Click() {
            if (!confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG02" Description="등록 하시겠습니까?" Literal="true"></Ctl:Text>')) {
                return false;
            }
            var param = new Object();
            var htGrp = new Object();
            htGrp["GRPID"] = txtGroupCode.GetValue();
            htGrp["USEYN"] = rdoUseYn.GetValue();
            htGrp["GRPTYPE"] = cboGRPTYPE.GetValue();
            htGrp["GRPEXT"] = txtGrpExt.GetValue();

            var htGrpLang = new Object();
            var ht = new Object();
            ht["GRPID"] = txtGroupCode.GetValue();
            ht["LANGCODE"] = "ko";
            ht["GRPNAME"] = txtKorGroupName.GetValue();
            htGrpLang["ht0"] = ht;

            var idx = 1;
            if (txtEnGroupName.GetValue() != "") {
                ht = new Object();

                ht["GRPID"] = txtGroupCode.GetValue();
                ht["LANGCODE"] = "en";
                ht["GRPNAME"] = txtEnGroupName.GetValue();

                htGrpLang["ht" + idx.toString()] = ht;
                idx++;
            }
            if (txtCnGroupName.GetValue() != "") {
                ht = new Object();

                ht["GRPID"] = txtGroupCode.GetValue();
                ht["LANGCODE"] = "cn";
                ht["GRPNAME"] = txtCnGroupName.GetValue();

                htGrpLang["ht" + idx.toString()] = ht;
                idx++;
            }
            if (txtEsGroupName.GetValue() != "") {
                ht = new Object();

                ht["GRPID"] = txtGroupCode.GetValue();
                ht["LANGCODE"] = "es";
                ht["GRPNAME"] = txtEsGroupName.GetValue();

                htGrpLang["ht" + idx.toString()] = ht;
                idx++;
            }
            if (txtEt1GroupName.GetValue() != "") {
                ht = new Object();

                ht["GRPID"] = txtGroupCode.GetValue();
                ht["LANGCODE"] = "et1";
                ht["GRPNAME"] = txtEt1GroupName.GetValue();

                htGrpLang["ht" + idx.toString()] = ht;
                idx++;
            }

            var htMember = new Object();
            ht = new Object();

            if (grid1.CurrData != null) {
                for (var i = 0; i < ObjectCount(grid1.CurrData.Rows); i++) {
                    ht = new Object();
                    var data = grid1.CurrData.Rows[i];
                    ht["GRPID"] = txtGroupCode.GetValue();                  // 그룹아이디
                    ht["USRID"] = data["USRID"];                            // 부서코드 또는 사번
                    ht["COMPANYCODE"] = "TY";// data["COMPANYCODE"];                // 법인코드
                    ht["USRTYPE"] = data["USRTYPE"];                        // 부서,유저 구분
                    ht["USR_COMPANYCODE"] = data["ORI_COMPANYCODE"];        // 사용자 법인코드

                    htMember["ht" + i] = ht;
                }
            }

            param["htGrp"] = htGrp;
            param["htGrpLang"] = htGrpLang;
            param["htMember"] = htMember;

            PageMethods.InvokeServiceTable(param, "Common.AclBiz", "AddGroup", btnSave_After);

            return false;
        }

        /******************************************************************************************
        * 함수명 : btnSave_After 
        * 설  명 : 저장 후 Callback
        * 작성일 : 2014-10-08
        * 작성자 : 장세현
        * 수  정 :
        ******************************************************************************************/
        function btnSave_After(e) {
            alert('<Ctl:Text ID="MSG07" runat="server" LangCode="MSG001" Description="저장 완료 되었습니다." Literal="true" />');
            if (opener != null && typeof (opener.gridBind) == "function") {
                opener.gridBind();
            }
            self.close();
        }
	</script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="conBody">

	<!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="그룹사용자 등록" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
		    <Ctl:Button ID="btnGroup" runat="server" Style="Orange" LangCode="TXT02" Description="등록" OnClientClick="return btnSave_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnManagerAdd" runat="server" Style="Orange" LangCode="TXT03" Description="담당자추가" OnClientClick="return fn_ManagerAdd();" ></Ctl:Button>
            <Ctl:Button ID="btnDelete" runat="server" Style="Orange" LangCode="TXT04" Description="담당자삭제" OnClientClick="return RowRemove();" ></Ctl:Button>
            <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="TXT05" Description="닫기" OnClientClick="return fn_btnClose();" ></Ctl:Button>                        
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
                    <col style="width:10%;" />
                    <col style="width:15%;" />
                    <col style="width:10%;" />
                    <col style="width:15%;" />
                </colgroup>
            <tr>
                <th><Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="그룹코드" Required="true"></Ctl:Text></th>
                <td colspan="3"><Ctl:TextBox ID="txtGroupCode" runat="server"></Ctl:TextBox></td>
            </tr>
            <tr>
                <th><Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="그룹타입"></Ctl:Text></th>
                <td>
                    <Ctl:Combo ID="cboGRPTYPE" runat="server" Width="130px">
                    </Ctl:Combo>
                </td>
                <th><Ctl:Text ID="TXT08" runat="server" LangCode="TXT08" Description="그룹명(국문)"></Ctl:Text></th>
                <td><Ctl:TextBox ID="txtKorGroupName" runat="server"></Ctl:TextBox></td>
            </tr>
            <tr>
                <th><Ctl:Text ID="TXT09" runat="server" LangCode="TXT09" Description="그룹명(중문)"></Ctl:Text></th>
                <td><Ctl:TextBox ID="txtCnGroupName" runat="server"></Ctl:TextBox></td>
                <th><Ctl:Text ID="TXT10" runat="server" LangCode="TXT10" Description="그룹명(영문)"></Ctl:Text></th>
                <td><Ctl:TextBox ID="txtEnGroupName" runat="server"></Ctl:TextBox></td>
            </tr>
            <tr>
                <th>
                    <Ctl:Text ID="TXT16" runat="server" LangCode="TXT16" Description="그룹명(스페인)"></Ctl:Text>
                </th>
                <td>
                    <Ctl:TextBox ID="txtEsGroupName" runat="server"></Ctl:TextBox>
                </td>
                <th>
                    <Ctl:Text ID="TXT17" runat="server" LangCode="TXT17" Description="그룹명(추가언어)"></Ctl:Text>
                </th>
                <td>
                    <Ctl:TextBox ID="txtEt1GroupName" runat="server"></Ctl:TextBox>
                </td>
            </tr>
            <tr>
                <th>
                    <Ctl:Text ID="TXT11" runat="server" LangCode="TXT11" Description="그룹옵션"></Ctl:Text>
                </th>
                <td>
                    <Ctl:TextBox ID="txtGrpExt" runat="server" Width="100%"></Ctl:TextBox>
                </td>
                <th><Ctl:Text ID="TXT12" runat="server" LangCode="TXT12" Description="사용여부"></Ctl:Text></th>
                <td><Ctl:Radio ID="rdoUseYn" runat="server" RepeatColumns="2">
                            <asp:ListItem LangCode="TXT13" Description="사용" Value="1" Selected="True"></asp:ListItem>
                            <asp:ListItem LangCode="TXT14" Description="사용안함" Value="0"></asp:ListItem>
                     </Ctl:Radio>
                </td>
            </tr>
            </table>
		</Ctl:Layer>

        <Ctl:Layer ID="layer2" runat="server" Title="Group Member" DefaultHide="False">
            <Ctl:WebSheet ID="grid1" runat="server" Paging="False" CheckBox="True" Width="100%" Merge="True" HFixation="False" UseColumnSort="true" TypeName="Common.AclBiz" MethodName="GetGroupMember">
                <Ctl:SheetField DataField="USRTYPENM" TextField="GTXT04" Description="그룹유형" Width="15%"  HAlign="center" Align="center" OnClick="Grid1RowClick" runat="server" />
                <Ctl:SheetField DataField="USRID" TextField="GTXT01" Description="그룹멤버ID" Width="15%"  HAlign="center" Align="center" OnClick="Grid1RowClick" runat="server" />
                <Ctl:SheetField DataField="USRNM" TextField="GTXT02" Description="그룹멤버명" Width="20%"  HAlign="center" Align="center" OnClick="Grid1RowClick" runat="server" />
                <Ctl:SheetField DataField="COMPANYCODE" TextField="GTXT05" Description="법인코드" Width="15%"  HAlign="center" Align="center" OnClick="Grid1RowClick" runat="server" />
                <Ctl:SheetField DataField="COMPANYNAME" TextField="GTXT03" Description="법인명" Width="*"  HAlign="center" Align="center" OnClick="Grid1RowClick" runat="server" />

                <Ctl:SheetField DataField="USRTYPE" TextField="" Description="그룹유형코드" Width="1px"  HAlign="center" Align="left" OnClick="Grid1RowClick" Hidden="true" runat="server" />
                <Ctl:SheetField DataField="ORI_COMPANYCODE" TextField="" Description="사용자 법인코드" Width="1px"  HAlign="center" Align="left" OnClick="Grid1RowClick" Hidden="true" runat="server" />
                <Ctl:SheetField DataField="ORI_COMPANYNAME" TextField="" Description="사용자 법인명" Width="1px"  HAlign="center" Align="left" OnClick="Grid1RowClick" Hidden="true" runat="server" />
            </Ctl:WebSheet>
		    <table class="table_01" style="width:100%; display:none;" border="0" >
                <colgroup>
                    <col style="width:10%;" />
                    <col style="width:15%;" />
                    <col style="width:10%;" />
                    <col style="width:15%;" />
                </colgroup>
            <tr>
                <th colspan="4"><Ctl:Text ID="TXT15" runat="server" LangCode="TXT15" Description="사용자" Required="true"></Ctl:Text></th>
            </tr>
            </table>
		</Ctl:Layer>
	</div>

</asp:Content>