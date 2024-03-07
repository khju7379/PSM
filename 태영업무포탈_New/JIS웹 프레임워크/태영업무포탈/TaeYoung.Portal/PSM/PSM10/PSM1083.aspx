<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1083.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1083" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _J1CODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["L2BCODE"] = "";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            DataGubn = "A";
            btnDel.Hide();
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   
            
            ht["J1CODE"] = _J1CODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1080", "UP_JSA_CLASS1_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    
                    txtJ1CODE.SetValue(DataSet.Tables[0].Rows[0]["J1CODE"]);
                    txtJ1NAME.SetValue(DataSet.Tables[0].Rows[0]["J1NAME"]);
                    txtJ1BIGO.SetValue(DataSet.Tables[0].Rows[0]["J1BIGO"]);
                    
                    txtJ1CODE.SetDisabled(true);

                    if (DataSet.Tables[0].Rows[0]["J2GUBUN"] == "Y") {
                        btnDel.Hide();
                    }
                    else {
                        btnDel.Show();
                    }
                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });

        }

        // 조회 버튼
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼
        function btnNew_Click()
        {   
            txtJ1CODE.SetValue("");
            txtJ1NAME.SetValue("");
            txtJ1BIGO.SetValue("");
            txtJ1CODE.SetDisabled(false);

            DataGubn = "A";

            btnDel.Hide();
        }

        // 저장 체크
        function UP_FieldCheck() {

            if (txtJ1CODE.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="대분류코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJ1NAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="대분류명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (DataGubn == "A") {

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["J1CODE"] = txtJ1CODE.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1080", "UP_JSA_CLASS1_SAVECHECK", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                        alert('<Ctl:Text runat="server" Description="동일한 코드가 등록되어 있습니다." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else {
                        UP_Save();
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert("Error");
                    return false;
                });
            }
            else {
                UP_Save();
            }
        }

        // 저장 이벤트
        function UP_Save() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            var WKGUBUN;
            if (DataGubn == "A") {
                WKGUBUN = "A";
            }
            else {
                WKGUBUN = "C";
            }

            ht["WKGUBUN"] = WKGUBUN;

            ht["J1CODE"] = txtJ1CODE.GetValue();
            ht["J1NAME"] = txtJ1NAME.GetValue();
            ht["J1BIGO"] = txtJ1BIGO.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1080", "UP_JSA_CLASS1_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            DataGubn = "";

                            _J1CODE = txtJ1CODE.GetValue();

                            UP_DataBind_Run();
                            btnSearch_Click();

                            alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 저장 버튼
        function btnSave_Click() {
            
            UP_FieldCheck();
        }

        // 삭제 버튼
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["WKGUBUN"] = "D";
            
            ht["J1CODE"] = txtJ1CODE.GetValue();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1080", "UP_JSA_CLASS1_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            btnNew_Click();
                            btnSearch_Click();

                            alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 닫기 버튼
        function btnClose_Click() {

            this.close();            
        }

        // 그리드 선택 이벤트
        function gridClick(r, c) {
            var rw = gridIndex.GetRow(r);

            DataGubn = "";
            
            _J1CODE = rw["J1CODE"];

            UP_DataBind_Run();
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="JSA코드(대분류)" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
            <Ctl:Button ID="btnSearch" runat="server" Style="Orange" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
            <Ctl:Button ID="btnNew" runat="server" Style="Orange" LangCode="btnNew" Description="신규" OnClientClick="btnNew_Click();" ></Ctl:Button>
		    <Ctl:Button ID="btnSave" runat="server" Style="Orange" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnDel" runat="server" Style="Orange" LangCode="btnDel" Description="삭제" OnClientClick="btnDel_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>                        
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server">
            <table style="width: 100%;">
                <colgroup>
                    <col width="50%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td valign="top">
                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="320" TypeName="PSM.PSM1080" MethodName="UP_GET_JSA_CLASS1_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="J1CODE" TextField="대분류코드" Description="대분류코드" Width="100"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="J1NAME" TextField="대분류명" Description="대분류명" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />   
                            <Ctl:SheetField DataField="J1BIGO" TextField="비고" Description="비고" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                        </Ctl:WebSheet>
                    </td>
                    <td valign="top">
                        <table class="table_01" style="width:100%;" border="0">
                            <colgroup>
                                <col width="100px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblJ1CODE" runat="server" LangCode="lblJ1CODE" Description="대분류코드" Required="true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtJ1CODE" Width="120px" runat="server" LangCode="txtJ1CODE" Description="대분류코드" MaxLength="2"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblJ1NAME" runat="server" LangCode="lblJ1NAME" Description="대분류명" Required="true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtJ1NAME" Width="230px" runat="server" LangCode="txtJ1NAME" Description="대분류명"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblJ1BIGO" runat="server" LangCode="lblJ1BIGO" Description="비고" ></Ctl:Text>
                                </th>
                                <td>
                                 <Ctl:TextBox ID="txtJ1BIGO" runat="server"  Height="80"
                                      ReadMode="false" ReadOnly="false" SetType="text"
                                      Text="" TextMode="MultiLine" Validation="false" Width="250px">
                                 </Ctl:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>      
            
		</Ctl:Layer>

        
	</div>

</asp:content>