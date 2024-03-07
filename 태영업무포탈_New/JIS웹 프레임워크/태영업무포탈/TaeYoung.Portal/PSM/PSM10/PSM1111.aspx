<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1111.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1111" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _PBC1NTCODE = "";
        var _PBC1LCODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {           

            UP_Init();

            UP_Get_DataBinding();

            btnNew_Click();
        }

        function UP_Init() {

            //btnSave.Hide();
            btnDel.Hide();

            // 게시판 분류 코드 조회
            var ht = new Object();

            ht["P_GUBUN"] = 'S';

            cboNTCODE.TypeName = "PSM.PSM1111";
            cboNTCODE.MethodName = "UP_GET_NTCODE_LIST";
            cboNTCODE.DataTextField = "CODENAME";
            cboNTCODE.DataValueField = "CODE";
            cboNTCODE.Params(ht);
            cboNTCODE.BindList();

            ht = new Object();

            ht["P_GUBUN"] = '';

            cboPBC1NTCODE.TypeName = "PSM.PSM1111";
            cboPBC1NTCODE.MethodName = "UP_GET_NTCODE_LIST";
            cboPBC1NTCODE.DataTextField = "CODENAME";
            cboPBC1NTCODE.DataValueField = "CODE";
            cboPBC1NTCODE.Params(ht);
            cboPBC1NTCODE.BindList();
        }

        function UP_Get_DataBinding() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_PBC1NTCODE"] = cboNTCODE.GetValue();
            ht["P_PBC1LCODE"] = '';

            GridLCODE.Params(ht); // 선언한 파라미터를 그리드에 전달함
            GridLCODE.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.               

            ht["P_PBC1NTCODE"] = _PBC1NTCODE;
            ht["P_PBC1LCODE"] = _PBC1LCODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1111", "UP_GET_LCODE_LIST", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {                    
                    
                    txtPBC1LCODE.SetValue(DataSet.Tables[0].Rows[0]["PBC1LCODE"]);
                    //svPBC1NTCODE.SetValue(DataSet.Tables[0].Rows[0]["PBC1NTCODE"]);
                    //$("#svPBC1NTCODE_CDDESC1").val(DataSet.Tables[0].Rows[0]["PBC1NTNAME"]);
                    cboPBC1NTCODE.SetValue(DataSet.Tables[0].Rows[0]["PBC1NTCODE"]);
                    txtPBC1NAME.SetValue(DataSet.Tables[0].Rows[0]["PBC1LCODENM"]);
                    txtPBC1BIGO.SetValue(DataSet.Tables[0].Rows[0]["PBC1BIGO"]);
                    cboPBC1NTCODE.SetDisabled(true);
                    txtPBC1LCODE.SetDisabled(true);

                    $("#txtPBC1LCODE").attr("style", "width:50px; background-color: gainsboro;");

                    DataGubn = "";

                    if (DataSet.Tables[0].Rows[0]["C2GUBUN"] == "Y") {
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

            UP_Get_DataBinding();
        }

        // 신규 버튼
        function btnNew_Click()
        {
            
            txtPBC1LCODE.SetValue("");
            txtPBC1NAME.SetValue("");
            txtPBC1BIGO.SetValue("");

            cboPBC1NTCODE.SetDisabled(false);
            txtPBC1LCODE.SetDisabled(false);
            $("#txtPBC1LCODE").attr("style", "width:50px;");

            DataGubn = "A";

            btnSave.Show();
            btnDel.Hide();
        }

        // 저장 체크
        function UP_FieldCheck() {

            if (cboPBC1NTCODE.GetValue() == "") {
                alert('<Ctl:Text runat="server"  Description="게시판 구분을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBC1LCODE.GetValue() == "") {
                alert('<Ctl:Text runat="server"  Description="대분류코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBC1LCODE.GetValue().length != 3) {
                alert('<Ctl:Text runat="server"  Description="대분류코드는 세자리 입니다." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBC1NAME.GetValue() == "") {
                alert('<Ctl:Text runat="server"  Description="대분류명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (DataGubn == "A") {

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["P_PBC1NTCODE"] = cboPBC1NTCODE.GetValue();
                ht["P_PBC1LCODE"] = txtPBC1LCODE.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1111", "UP_BOARD_CLASS1_SAVECHECK", function (e) {

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

            ht["P_PBC1NTCODE"] = cboPBC1NTCODE.GetValue();
            ht["P_PBC1LCODE"] = txtPBC1LCODE.GetValue();
            ht["P_PBC1NAME"] = txtPBC1NAME.GetValue();
            ht["P_PBC1BIGO"] = txtPBC1BIGO.GetValue();
            ht["WKGUBUN"] = DataGubn;

            if (confirm('<Ctl:Text ID="MSG02" runat="server"  Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1111", "UP_BOARD_CLASS1_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            _PBC1NTCODE = cboPBC1NTCODE.GetValue();
                            _PBC1LCODE = txtPBC1LCODE.GetValue();
                            UP_DataBind_Run();
                            UP_Get_DataBinding();

                            alert('<Ctl:Text runat="server"  Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
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
                    alert('<Ctl:Text runat="server"  Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
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

            ht["P_PBC1NTCODE"] = cboPBC1NTCODE.GetValue();
            ht["P_PBC1LCODE"] = txtPBC1LCODE.GetValue();
            ht["WKGUBUN"] = "D";

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1111", "UP_BOARD_CLASS1_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            btnNew_Click();

                            UP_Get_DataBinding();

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');
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
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }    

        // 그리드 선택 이벤트
        function gridClick(r, c) {

            var rw = GridLCODE.GetRow(r);

            _PBC1NTCODE = rw["PBC1NTCODE"];
            _PBC1LCODE = rw["PBC1LCODE"];

            UP_DataBind_Run();
        }

           // 닫기 버튼
        function btnClose_Click() {

            this.close();            
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="공정안전자료분류코드(대분류)" Literal="true"></Ctl:Text>
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
                    <col width="55%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td>
                        <table class="table_01" style="width:100%;" border="0">
                            <colgroup>
                                <col width="100px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <th>
                                    <Ctl:Text ID="Text1" runat="server" LangCode="lblPBC1NTCODE" Description="게시판 구분" ></Ctl:Text>
                                </th>
                                <td>    
                                    <Ctl:Combo ID="cboNTCODE" Width="230px" runat="server">
                                    </Ctl:Combo>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td rowspan="2" valign="top">
                        <table class="table_01" style="width:100%;" border="0">
                            <colgroup>
                                <col width="100px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblPBC1NTCODE" runat="server" LangCode="lblPBC1NTCODE" Description="게시판 구분" Required="true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:Combo ID="cboPBC1NTCODE" Width="230px" runat="server">
                                    </Ctl:Combo>
                                    <%--<Ctl:SearchView ID="svPBC1NTCODE" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'NT'}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                                        <Ctl:SearchViewField runat="server" DataField="CDCODE"  TextField="CDCODE" Description="코드" Hidden="false" TextBox="true" Width="60" Default="true"  />
                                        <Ctl:SearchViewField runat="server" DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" TextBox="true" Width="150" />                                            
                                    </Ctl:SearchView>--%>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblPBC1LCODE" runat="server" LangCode="lblPBC1LCODE" Description="대분류코드" Required="true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtPBC1LCODE" Width="50px" runat="server" LangCode="txtPBC1LCODE" Description="대분류코드" SetType="Number" MaxLength="3"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblPBC1NAME" runat="server" LangCode="lblPBC1NAME" Description="대분류명" Required="true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtPBC1NAME" Width="230px" runat="server" LangCode="txtPBC1NAME" Description="대분류명"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblPBC1BIGO" runat="server" LangCode="lblPBC1BIGO" Description="비고" ></Ctl:Text>
                                </th>
                                <td>
                                 <Ctl:TextBox ID="txtPBC1BIGO" runat="server"  Height="80"
                                      ReadMode="false" ReadOnly="false" SetType="text"
                                      Text="" TextMode="MultiLine" Validation="false" Width="250px">
                                 </Ctl:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <Ctl:WebSheet ID="GridLCODE" runat="server" Paging="false" HFixation="true" Fixation = "false" CheckBox="false" Width="100%" Height="290" TypeName="PSM.PSM1111" MethodName="UP_GET_LCODE_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">                            
                            <Ctl:SheetField DataField="PBC1NTCODE" TextField="게시판코드" Description="게시판코드" Width="0"  HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true"/>
                            <Ctl:SheetField DataField="PBC1NTNAME" TextField="게시판 구분" Description="게시판 구분" Width="150"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="PBC1LCODE" TextField="대분류코드" Description="대분류코드" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                            <Ctl:SheetField DataField="PBC1LCODENM" TextField="대분류명" Description="대분류명" Width="230" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />   
                            <Ctl:SheetField DataField="PBC1BIGO" TextField="비고" Description="비고" Width="0" HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true"/>
                        </Ctl:WebSheet>
                    </td>
                    
                </tr>
            </table>      
            
		</Ctl:Layer>

        
	</div>

</asp:content>