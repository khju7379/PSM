<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4042.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4042" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";

        var fsParam = "";
        var fsParam1 = "";

        var fsWKTEAM;
        var fsWKDATE;
        var fsWKSEQ;
        var fsWKORSEQ;

        // 페이지 로드
        function OnLoad() {

            var today = new Date();

            /*txtDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));*/
            txtCOPYDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate() + 1));

            fsParam = "<%= Request.QueryString["param"] %>";

            fsParam1 = "<%= Request.QueryString["param1"] %>";

            var data = fsParam1.split('-');

            debugger;

            if (fsParam == 'JSA') {
                fsWKTEAM = data[1];
                fsWKDATE = data[2];
                fsWKSEQ = data[3];
                txtDATE.SetValue(data[4]);
                fsWKORSEQ = data[5];
            }
            else {
                fsWKTEAM  = data[0];
                fsWKDATE  = data[1];
                fsWKSEQ   = data[2];
                txtDATE.SetValue(data[3]);
                fsWKORSEQ = data[4];
            }

        }

        // 결재 버튼
        function btnCopy_Click() {

            debugger;

            var gubun;

            if (fsParam == "SAFE") {
                if (confirm('<Ctl:Text ID="MSG01" runat="server" LangCode="MSG18" Description="일일 JSA와 같이 복사하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    gubun = 'YES';
                }
                else {

                    gubun = 'NO';
                }

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["P_DATE"]     = txtDATE.GetValue();
                ht["P_COPYDATE"] = txtCOPYDATE.GetValue();
                ht["P_WKORSEQ"]  = fsWKORSEQ;
                ht["P_WKGUBN"]   = 'D';
                ht["P_WKTEAM"]   = fsWKTEAM;
                ht["P_WKDATE"]   = fsWKDATE;
                ht["P_WKSEQ"]    = fsWKSEQ;

                ht["P_EMPNO"] = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
                ht["P_GUBUN"] = gubun;

                debugger;

                PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_COPY", function (e) {

                    var DataSet1 = eval(e);

                    debugger;

                    if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                        if (DataSet1.Tables[0].Rows[0]["STATE"] == "OK") {

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="복사가 완료 되었습니다." Literal="true"></Ctl:Text>');

                            opener.btnCOPY_Callback(fsParam1);
                            self.close();
                        }
                        else {
                            alert(DataSet1.Tables[0].Rows[0]["MSG"]);
                        }
                    }
                }, function (e) {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
            else {
                debugger;
                if (txtDATE.GetValue() == txtCOPYDATE.GetValue()) {
                    alert("기준일자와 복사일자는 같을 수 없습니다!");
                    return
                }

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["P_DATE"]     = txtDATE.GetValue();
                ht["P_COPYDATE"] = txtCOPYDATE.GetValue();
                ht["P_WKORSEQ"]  = fsWKORSEQ;
                ht["P_WKGUBN"]   = 'D';
                ht["P_WKTEAM"]   = fsWKTEAM;
                ht["P_WKDATE"]   = fsWKDATE;
                ht["P_WKSEQ"]    = fsWKSEQ;

                ht["P_EMPNO"] = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
                ht["P_GUBUN"] = gubun;

                debugger;

                PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_JSA_COPY", function (e) {

                    var DataSet1 = eval(e);

                    debugger;

                    if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                        if (DataSet1.Tables[0].Rows[0]["STATE"] == "OK") {

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="복사가 완료 되었습니다." Literal="true"></Ctl:Text>');

                            debugger;

                            opener.btnCOPY_Callback(fsParam1);
                            self.close();
                        }
                        else {
                            alert(DataSet1.Tables[0].Rows[0]["MSG"]);
                        }
                    }
                }, function (e) {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });

            }
        }
        

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            this.close();
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

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="[복사]" DefaultHide="False">
            <!-- 상단의 버튼을 정의 -->
            <div class="btn_bx">
                <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="80px" />
                        <col width="120px" />
                        <col width="50px" />
                        <col width="80px" />
                        <col width="120px" />
                        <col width="300px" />
                    </colgroup>


                    <tr style="text-align:left;">
                        <th>
                            <Ctl:Text ID="lblData" runat="server" Required="true" LangCode="lblData" Description="기준일자" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtDATE"  runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox>
                        </td>

                        <td style="border:0px">
                            <img src="/Resources/Images/right_arrow.png" class="arrow" alt="" />
                        </td>

                        <th>
                            <Ctl:Text ID="Text1" runat="server" Required="true" LangCode="lblData" Description="복사일자" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtCOPYDATE"  runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox>
                        </td>
                        <td style ="text-align:right; border:0px">
                            <Ctl:Button ID="btnCopy"  runat="server" Style="orange" LangCode="btnCopy" Description="저장" OnClientClick="btnCopy_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>
                        </td>
                    </tr>
                </table>
            </div>
        </Ctl:Layer> 
    </div>
</asp:content>
