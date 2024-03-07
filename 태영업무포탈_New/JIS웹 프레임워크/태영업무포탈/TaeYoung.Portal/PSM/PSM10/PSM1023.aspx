<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1023.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1023" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _L1SAUP = "";
        var _L1CODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            //ht["PageSize"] = 50;
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

            ht["L1SAUP"] = _L1SAUP;
            ht["L1CODE"] = _L1CODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1020", "UP_LOCATION_CLASS1_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    
                    cboL1SAUP.SetValue(DataSet.Tables[0].Rows[0]["L1SAUP"]);
                    txtL1CODE.SetValue(DataSet.Tables[0].Rows[0]["L1CODE"]);
                    txtL1NAME.SetValue(DataSet.Tables[0].Rows[0]["L1NAME"]);
                    txtL1BIGO.SetValue(DataSet.Tables[0].Rows[0]["L1BIGO"]);
                    cboL1SAUP.SetDisabled(true);
                    txtL1CODE.SetDisabled(true);

                    if (DataSet.Tables[0].Rows[0]["L2GUBUN"] == 'Y') {
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
            //ht["PageSize"] = 50;

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼
        function btnNew_Click()
        {
            cboL1SAUP.SetValue("T");
            txtL1CODE.SetValue("");
            txtL1NAME.SetValue("");
            txtL1BIGO.SetValue("");
            cboL1SAUP.SetDisabled(false);
            txtL1CODE.SetDisabled(false);

            DataGubn = "ADD";

            btnDel.Hide();
        }

        // 저장 버튼
        function btnSave_Click() {

            if (cboL1SAUP.GetValue() == "" || cboL1SAUP.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="사업부를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtL1CODE.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="대분류코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtL1NAME.GetValue() == "") {
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
            ht["L1SAUP"] = cboL1SAUP.GetValue();
            ht["L1CODE"] = txtL1CODE.GetValue();
            ht["L1NAME"] = txtL1NAME.GetValue();
            ht["L1BIGO"] = txtL1BIGO.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1020", "UP_LOCATION_CLASS1_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            DataGubn = "";
                            _L1SAUP = cboL1SAUP.GetValue();
                            _L1CODE = txtL1CODE.GetValue();

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
            ht["L1SAUP"] = cboL1SAUP.GetValue();
            ht["L1CODE"] = txtL1CODE.GetValue();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1020", "UP_LOCATION_CLASS1_DEL", function (e) {

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
            _L1SAUP = rw["L1SAUP"];
            _L1CODE = rw["L1CODE"];

            UP_DataBind_Run();
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="위치코드(대분류)" Literal="true"></Ctl:Text>
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
                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="320" TypeName="PSM.PSM1020" MethodName="UP_GET_LOCATION_CLASS1_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="L1SAUP" TextField="사업부" Description="사업부" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="L1CODE" TextField="대분류코드" Description="대분류코드" Width="100"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="L1NAME" TextField="대분류명" Description="대분류명" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />   
                            <Ctl:SheetField DataField="L1BIGO" TextField="비고" Description="비고" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
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
                                    <Ctl:Text ID="lblL1SAUP" runat="server" LangCode="lblL1SAUP" Description="사업부" Required = "true"></Ctl:Text>

                                </th>
                                <td>                                          
                                   <Ctl:Combo ID="cboL1SAUP" Width="60px" runat="server" >
                                       <asp:ListItem Selected="True" Text="UTT" Value="T"></asp:ListItem>
                                       <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                                   </Ctl:Combo>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblL1CODE" runat="server" LangCode="lblL1CODE" Description="대분류코드" Required="true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtL1CODE" Width="120px" runat="server" LangCode="txtL1CODE" Description="대분류코드" MaxLength="1"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblL1NAME" runat="server" LangCode="lblL1NAME" Description="대분류명" Required="true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtL1NAME" Width="230px" runat="server" LangCode="txtL1NAME" Description="대분류명"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblL1BIGO" runat="server" LangCode="lblL1BIGO" Description="비고" ></Ctl:Text>
                                </th>
                                <td>
                                 <Ctl:TextBox ID="txtL1BIGO" runat="server"  Height="80"
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