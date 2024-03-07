<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1082.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1082" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _J2BCODE = "";
        var _J2MCODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            ht["GUBUN"] = "S";

            cboBCODE.TypeName = "PSM.PSM1080";
            cboBCODE.MethodName = "UP_GET_JSA_BCODE_LIST";
            cboBCODE.DataTextField = "J1CODENAME";
            cboBCODE.DataValueField = "J1CODE";
            cboBCODE.Params(ht);
            cboBCODE.BindList();

            ht = new Object();

            ht["GUBUN"] = "";

            cboJ2BCODE.TypeName = "PSM.PSM1080";
            cboJ2BCODE.MethodName = "UP_GET_JSA_BCODE_LIST";
            cboJ2BCODE.DataTextField = "J1CODENAME";
            cboJ2BCODE.DataValueField = "J1CODE";
            cboJ2BCODE.Params(ht);
            cboJ2BCODE.BindList();

            ht = new Object(); 

            ht["J2BCODE"] = "";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            DataGubn = "ADD";
            btnDel.Hide();
            
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["J2BCODE"] = _J2BCODE;
            ht["J2MCODE"] = _J2MCODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1080", "UP_JSA_CLASS2_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    
                    cboJ2BCODE.SetValue(DataSet.Tables[0].Rows[0]["J2BCODE"]);
                    txtJ2MCODE.SetValue(DataSet.Tables[0].Rows[0]["J2MCODE"]);
                    txtJ2NAME.SetValue(DataSet.Tables[0].Rows[0]["J2NAME"]);
                    txtJ2BIGO.SetValue(DataSet.Tables[0].Rows[0]["J2BIGO"]);
                    
                    cboJ2BCODE.SetDisabled(true);
                    txtJ2MCODE.SetDisabled(true);

                    if (DataSet.Tables[0].Rows[0]["J3GUBUN"] == "Y") {
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

            ht["J2BCODE"] = cboBCODE.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 신규 버튼
        function btnNew_Click()
        {
            var ht = new Object();

            ht["GUBUN"] = "";

            cboJ2BCODE.TypeName = "PSM.PSM1080";
            cboJ2BCODE.MethodName = "UP_GET_JSA_BCODE_LIST";
            cboJ2BCODE.DataTextField = "J1CODENAME";
            cboJ2BCODE.DataValueField = "J1CODE";
            cboJ2BCODE.Params(ht);
            cboJ2BCODE.BindList();

            cboJ2BCODE.SetValue("");
            txtJ2MCODE.SetValue("");
            txtJ2NAME.SetValue("");
            txtJ2BIGO.SetValue("");
            
            cboJ2BCODE.SetDisabled(false);
            txtJ2MCODE.SetDisabled(false);

            DataGubn = "ADD";

            btnDel.Hide();
        }

        // 저장 버튼
        function btnSave_Click() {         

            if (cboJ2BCODE.GetValue() == "" || cboJ2BCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="대분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJ2NAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="중분류명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["J2BCODE"] = cboJ2BCODE.GetValue();
            
            if (DataGubn == 'ADD') {
                ht["J2MCODE"] = "0";
            }
            else {
                ht["J2MCODE"] = txtJ2MCODE.GetValue();
            }
            ht["J2NAME"] = txtJ2NAME.GetValue();
            ht["J2BIGO"] = txtJ2BIGO.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1080", "UP_JSA_CLASS2_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        DataGubn = "";
                        
                        _J2BCODE = DataSet.Tables[0].Rows[0]["J2BCODE"];
                        _J2MCODE = DataSet.Tables[0].Rows[0]["J2MCODE"];

                        UP_DataBind_Run();
                        btnSearch_Click();

                        alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
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

        // 삭제 버튼
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["J2BCODE"] = cboJ2BCODE.GetValue();
            ht["J2MCODE"] = txtJ2MCODE.GetValue();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1080", "UP_JSA_CLASS2_DEL", function (e) {

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
            
            _J2BCODE = rw["J2BCODE"];
            _J2MCODE = rw["J2MCODE"];

            UP_DataBind_Run();
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="JSA코드(중분류)" Literal="true"></Ctl:Text>
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
		    <table class="table_01" style="width:100%;" border="0">
                <colgroup>
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="lblBCODE" runat="server" LangCode="lblBCODE" Description="대분류"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:Combo ID="cboBCODE" Width="150px" runat="server" ></Ctl:Combo>
                    </td>
                </tr>
            </table>
            <table style="width: 100%;height:270px;">
                <colgroup>
                    <col width="25%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td valign="top" >
                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="200" TypeName="PSM.PSM1080" MethodName="UP_GET_JSA_CLASS2_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="J2BCODE" TextField="대분류코드" Description="대분류코드" Width="100"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="J2BCODENM" TextField="대분류명" Description="대분류명" Width="150" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="J2MCODE" TextField="중분류코드" Description="중분류코드" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="J2NAME" TextField="중분류명" Description="중분류명" Width="240" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                            <Ctl:SheetField DataField="J2BIGO" TextField="비고" Description="비고" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />                            
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>      
            <table class="table_01" style="width:100%;" border="0">
                <colgroup>
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJ2BCODE" runat="server" LangCode="lblJ2BCODE" Description="대분류" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:Combo ID="cboJ2BCODE" Width="150px" runat="server" ></Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJ2MCODE" runat="server" LangCode="lblJ2MCODE" Description="중분류" ></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtJ2MCODE" Width="120px" runat="server" LangCode="txtJ2MCODE" Description="중분류" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJ2NAME" runat="server" LangCode="lblJ2NAME" Description="중분류명" Required = "true"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtJ2NAME" Width="230px" runat="server" LangCode="txtJ2NAME" Description="중분류명"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJ2BIGO" runat="server" LangCode="lblJ2BIGO" Description="비고" ></Ctl:Text>
                    </th>
                    <td>
                     <Ctl:TextBox ID="txtJ2BIGO" runat="server"  Height="80"
                          ReadMode="false" ReadOnly="false" SetType="text"
                          Text="" TextMode="MultiLine" Validation="false" Width="500px">
                     </Ctl:TextBox>
                </td>
                </tr>
            </table>
		</Ctl:Layer>

        
	</div>

</asp:content>