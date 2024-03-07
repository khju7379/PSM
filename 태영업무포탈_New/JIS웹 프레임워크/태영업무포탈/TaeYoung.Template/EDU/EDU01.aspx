<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EDU01.aspx.cs" Inherits="TaeYoung.Template.EDU.EDU01" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        function OnLoad() {

            // PageLoad시 이벤트 정의부분
            idx = "<%= Request.QueryString["IDX"] %>";

            if(idx == "") idx = "0";

            BindView();

            if(idx!="0"){
                BindView();
            }
        }

        function BindView(){
            var ht = new Object();

//            ht["IDX"] = idx;

//            PageMethods.InvokeServiceTable(ht, "Template.TemplateBiz", "GetTemplate", function (e) {
//                var dt = eval(e).Tables[0]; // 가져온 데이터 JSON변환

//                txtTitle.SetValue(dt.Rows[0]["COLUMNS1"]);
//                txtDate.SetValue(dt.Rows[0]["COLUMNS2"]);
//                svTest.SetValue(dt.Rows[0]["COLUMNS3"]);
//                cmbTest.SetValue(dt.Rows[0]["COLUMNS4"]);

            PageMethods.InvokeServiceTableSync(ht, "TYSCMLIB.TankBiz", "GetTankPageList", function (e) {            

                var dt = eval(e).Tables[0]; // 가져온 데이터 JSON변환

                alert(dt.rows[0][0].toString());


            }, function (e) {
                // Biz 연결오류
                alert(e.responseJSON.Message);
            });

        }

        function btnSave_Click() {
            if(!ValidationCheck()){ // 유효성검사
                return;
            }

            var title = txtTitle.GetValue();
            var columns2 = txtDate.GetValue();
            var columns3 = svTest.GetValue();
            var columns4 = cmbTest.GetValue();

            var ht = new Object();

            ht["IDX"] = idx;
            ht["COLUMNS1"] = title;
            ht["COLUMNS2"] = columns2;
            ht["COLUMNS3"] = columns3;
            ht["COLUMNS4"] = columns4;
            ht["COLUMNS5"] = "";
            ht["COLUMNS6"] = "";
            ht["COLUMNS7"] = "";
            ht["COLUMNS8"] = "";
            ht["COLUMNS9"] = "";

            PageMethods.InvokeServiceTable(ht, "Template.TemplateBiz", "AddTemplate", function (e) {
                alert("저장이 완료되었습니다.");
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        function btnDelete_Click() {
            self.close();
        }
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4>
            게시판
        </h4>

        <div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();"></Ctl:Button>
            <Ctl:Button ID="Button1" runat="server" LangCode="btnSave" Description="삭제" OnClientClick="btnSave_Click();"></Ctl:Button>
            <Ctl:Button ID="btnDelete" runat="server" LangCode="btnSave" Description="닫기" OnClientClick="btnDelete_Click();"></Ctl:Button>
        </div>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="레이어 제목을 입력하세요" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="140" />
                    <col width="400" />
                    <col width="140" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        제목
                    </th>
                    <td colspan="3">
                        <ctl:TextBox ID="txtTitle" runat="server" width="90%" Required="true" Validation="true"></ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        COLUMN1
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" OnCalendarChanged="fnCalendar_Changed" ></Ctl:TextBox> 
                    </td>
                    <th>
                        COLUMN2
                    </th>
                    <td>
                        <Ctl:SearchView ID="svTest" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplate" Params="{'a':'1','b':'2'}">
                            <Ctl:SearchViewField DataField="ROWNO" TextField="ROWNO" Description="순번" Hidden="false" Width="200" TextBox="true" Default="true"  runat="server" />
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" runat="server" />
                            <Ctl:SearchViewField DataField="COLUMNS1" TextField="COLUMNS1" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <th>
                        COLUMN1
                    </th>
                    <td>
                        <Ctl:Combo ID="cmbTest" runat="server" RepeatColumns="2">
                            <asp:ListItem Selected="True" Text="값1" Value="0" LangCode="chk1_1" Description="값1"></asp:ListItem>
                            <asp:ListItem Text="값2" Value="2"></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        COLUMN1
                    </th>
                    <td>
                        첫번째 내용
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>