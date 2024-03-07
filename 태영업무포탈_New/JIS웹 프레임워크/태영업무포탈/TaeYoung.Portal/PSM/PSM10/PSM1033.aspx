<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1033.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1033" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _C1SAUP = "";
        var _C1CODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            //ht["PageSize"] = 100;
            ht["L2SAUP"] = "T";
            ht["L2BCODE"] = "";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            DataGubn = "ADD";
            btnDel.Hide();
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["C1SAUP"] = _C1SAUP;
            ht["C1CODE"] = _C1CODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1030", "UP_ACFIXCLASS1_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    
                    cboC1SAUP.SetValue(DataSet.Tables[0].Rows[0]["C1SAUP"]);
                    txtC1CODE.SetValue(DataSet.Tables[0].Rows[0]["C1CODE"]);
                    txtC1NAME.SetValue(DataSet.Tables[0].Rows[0]["C1NAME"]);
                    txtC1BIGO.SetValue(DataSet.Tables[0].Rows[0]["C1BIGO"]);
                    cboC1SAUP.SetDisabled(true);
                    txtC1CODE.SetDisabled(true);

                    if (DataSet.Tables[0].Rows[0]["C2GUBUN"] == 'Y') {
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

            ht["CurrentPageIndex"] = 1;
            //ht["PageSize"] = 100;

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼
        function btnNew_Click()
        {
            cboC1SAUP.SetValue("T");
            txtC1CODE.SetValue("");
            txtC1NAME.SetValue("");
            txtC1BIGO.SetValue("");
            cboC1SAUP.SetDisabled(false);
            txtC1CODE.SetDisabled(false);

            DataGubn = "ADD";

            btnDel.Hide();
        }

        // 저장 버튼
        function btnSave_Click() {

            if (cboC1SAUP.GetValue() == "" || cboC1SAUP.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="사업부를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtC1CODE.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="대분류코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtC1NAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="대분류명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            var WKGUBUN;
            if (DataGubn == "ADD")
            {
                WKGUBUN = "A";
            }
            else
            {
                WKGUBUN = "C";
            }

            ht["WKGUBUN"] = WKGUBUN;
            ht["C1SAUP"] = cboC1SAUP.GetValue();
            ht["C1CODE"] = txtC1CODE.GetValue();
            ht["C1NAME"] = txtC1NAME.GetValue();
            ht["C1BIGO"] = txtC1BIGO.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1030", "UP_ACFIXCLASS1_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            DataGubn = "";
                            _C1SAUP = cboC1SAUP.GetValue();
                            _C1CODE = txtC1CODE.GetValue();

                            UP_DataBind_Run();
                            btnSearch_Click();

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 삭제 버튼
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["WKGUBUN"] = "D";
            ht["C1SAUP"] = cboC1SAUP.GetValue();
            ht["C1CODE"] = txtC1CODE.GetValue();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1030", "UP_ACFIXCLASS1_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            btnNew_Click();
                            btnSearch_Click();

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
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
            _C1SAUP = rw["C1SAUP"];
            _C1CODE = rw["C1CODE"];

            UP_DataBind_Run();
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="설비코드(대분류)" Literal="true"></Ctl:Text>
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
                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="320" TypeName="PSM.PSM1030" MethodName="UP_GET_ACFIXCLASS1_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="C1SAUP" TextField="사업부" Description="사업부" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="C1CODE" TextField="대분류코드" Description="대분류코드" Width="100"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="C1NAME" TextField="대분류명" Description="대분류명" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />   
                            <Ctl:SheetField DataField="C1BIGO" TextField="비고" Description="비고" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
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
                                    <Ctl:Text ID="lblC1SAUP" runat="server" LangCode="lblC1SAUP" Description="사업부" Required = "true"></Ctl:Text>

                                </th>
                                <td>                                          
                                   <Ctl:Combo ID="cboC1SAUP" Width="60px" runat="server" >
                                       <asp:ListItem Selected="True" Text="UTT" Value="T"></asp:ListItem>
                                       <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                                   </Ctl:Combo>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblC1CODE" runat="server" LangCode="lblC1CODE" Description="대분류코드" Required="true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtC1CODE" Width="120px" runat="server" LangCode="txtC1CODE" Description="대분류코드" MaxLength="2"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblC1NAME" runat="server" LangCode="lblC1NAME" Description="대분류명" Required="true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtC1NAME" Width="230px" runat="server" LangCode="txtC1NAME" Description="대분류명"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblC1BIGO" runat="server" LangCode="lblC1BIGO" Description="비고" ></Ctl:Text>
                                </th>
                                <td>
                                 <Ctl:TextBox ID="txtC1BIGO" runat="server"  Height="80"
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