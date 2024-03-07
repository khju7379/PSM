<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Switch.aspx.cs" Inherits="TaeYoung.Portal.Admin.Cmn.Switch" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">
        var plant = "<%= TaeYoung.Biz.Document.UserInfo.LocationCode %>";
        var corpcd = "<%= TaeYoung.Biz.Document.UserInfo.SiteCompanyCode %>";
        var langcd = "<%= TaeYoung.Biz.Document.ClientCultureName %>";
        var regid = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
        var loginid = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";
        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";
        var userName = "<%= TaeYoung.Biz.Document.UserInfo.UserName %>";
        var isvend = "<%=  TaeYoung.Biz.Document.UserInfo.IsVend %>";

        <%
            String userAcl = "";
            if(!String.IsNullOrEmpty(TaeYoung.Biz.Document.UserInfo.SiteCompanyCode)){
                String company = TaeYoung.Biz.Document.UserInfo.SiteCompanyCode;
                if(company.Equals("SEOHAN")){
                    userAcl = UserGroup.Exists(s => s == "SWITCH_SH") ? company : "N";
                }else if(company.Equals("KAMTEC")){
                    userAcl = UserGroup.Exists(s => s == "SWITCH_KT") ? company : "N";
                }else if(company.Equals("KOFCO")){
                    userAcl = UserGroup.Exists(s => s == "SWITCH_KF") ? company : "N";
                }

                userAcl = UserGroup.Exists(s => s == "SWITCH_IT") ? "" : userAcl;
            }
        %>

        /**********************************************************************
        * OnLoad
        **********************************************************************/
        function OnLoad() {
        }

        /**********************************************************************
        * 조회 버튼 클릭 
        **********************************************************************/
        function btnSearch_Click() {
            grid1.Params({ 'COMPANYCODE': '<%= userAcl %>', 'LANGCODE' : langcd});

            grid1.BindList(1);
            grid1.CallBack = function () {
                var all = grid1.GetAllRow();
                for (var i = 0; i < ObjectCount(all.Rows); i++) {
                    var row = all.Rows[i];

                    var radioTag = "<input type = 'radio' name = 'gridCVYN_" + i + "' id = 'gridCVYN_" + i + "' value = 'N' style = 'width : 20px;' " + (all.Rows[i]["CVYN"] == "N" ? "checked" : "") + " />ON&nbsp;";
                        radioTag += "<input type = 'radio' name = 'gridCVYN_" + i + "' id = 'gridCVYN_" + i + "' value = '' style = 'width : 20px;' " + (all.Rows[i]["CVYN"] == "" ? "checked" : "") + " />OFF";

                    grid1.SetValue(i, "CVYN", radioTag);

                }
            }

            return false;
        }

        /**********************************************************************
        * 저장 버튼 클릭 이벤트
        **********************************************************************/
        function btnSave_Click() {
            var ht = new Object();
            var all = grid1.GetAllRow();
            if (ObjectCount(all.Rows) < 1) {
                alert('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG03" Description="저장할 항목이 없습니다." Literal="true"></Ctl:Text>');
                return false;
            }

            if (!confirm('<Ctl:Text ID="MSG04" runat="server" LangCode="MSG04" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>')) {
                return false;
            }

            var ht = new Object();

            for (var i = 0; i < ObjectCount(all.Rows); i++) {
                var dr = all.Rows[i];
                var sht = new Object();
                sht["COMPANYCODE"] = dr["COMPANYCODE"];
                sht["CVYN"] = $("input[name=gridCVYN_" + i + "]:checked").val();
                sht["REGCO"] = corpcd;
                sht["REGID"] = regid;

                ht["ht" + i] = sht;
            }

            var hts = new Object();
            hts["GRID_DATA"] = ht;

            PageMethods.InvokeServiceTable(hts, "Portal.CVYNBiz", "SetCMN_SWITCH_ADD", Save_CallBack, function (e) {
                alert(e.get_message());
            });

            return false;
        }

        /**********************************************************************
        * 저장 버튼 클릭 콜백 함수
        **********************************************************************/
        function Save_CallBack(e) {
            alert('<Ctl:Text ID="SAVE_MSG01" runat="server" LangCode="SAVE_MSG01" Description="입력하신 정보가 저장되었습니다." Literal="true" />');
            btnSearch_Click();
            return false;
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    
    <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="Text14" runat="server" LangCode="TXT01" Description="<h4>스위치</h4>"></Ctl:Text>
        </h4>

        <div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click(); return false;"></Ctl:Button>
            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click(); return false;"></Ctl:Button>
        </div>
        <div class="clear"></div>
    </div>

    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer3" runat="server">
            <Ctl:WebSheet ID="grid1" runat="server" Paging="false" CheckBox="false" Width="100%" Fixation="true" HFixation="false" Height="300" TypeName="Portal.CVYNBiz" MethodName="GetCMN_SWITCH_LIST" >
                <Ctl:SheetField DataField="COMPANYNAME" TextField="COMPANYNAME" Description="법인" Width="150" Height="24" Edit="false" DataType="text" EditType="text" HAlign="center" Align="center" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="CVYN" TextField="CVYN" Description="ON/OFF" Width="200" Height="24" Edit="false" DataType="text" EditType="text" HAlign="center" Align="center" OnClick="null" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
            </Ctl:WebSheet>
        </Ctl:Layer>
    </div>
</asp:content>
