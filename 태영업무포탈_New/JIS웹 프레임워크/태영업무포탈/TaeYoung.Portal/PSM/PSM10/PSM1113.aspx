<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1113.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1113" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _PBC3NTCODE = "";
        var _PBC3LCODE = "";
        var _PBC3MCODE = "";
        var _PBC3SCODE = "";
        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {           

            UP_Get_NTODECombo();

            var Num = "<%= Request.QueryString["CODE"] %>";

            var data = Num.split('^');

            if (data.length > 1) {

                _PBC3NTCODE = data[0];
                _PBC3LCODE = data[1];
                _PBC3MCODE = data[2];
                _PBC3SCODE = data[3];

                UP_DataBind_Run();
            }
            else {

                _PBC3NTCODE = '';
                _PBC3LCODE = '';
                _PBC3MCODE = '';
                _PBC3SCODE = '';

                //btnDel.Hide();

                btnNew_Click();
            }
            cboPBC3NTCODE_Change();
        }
     
        // 게시판 구분 콤보 리스트 바인딩
        function UP_Get_NTODECombo()
        {
            var ht = new Object();

            ht["P_GUBUN"] = '';

            cboPBC3NTCODE.TypeName = "PSM.PSM1111";
            cboPBC3NTCODE.MethodName = "UP_GET_NTCODE_LIST";
            cboPBC3NTCODE.DataTextField = "CODENAME";
            cboPBC3NTCODE.DataValueField = "CODE";
            cboPBC3NTCODE.Params(ht);
            cboPBC3NTCODE.BindList();

            cboPBC3NTCODE_Change();

            return false;
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.               

            ht["P_PBC3NTCODE"] = _PBC3NTCODE;
            ht["P_PBC3LCODE"] = _PBC3LCODE;
            ht["P_PBC3MCODE"] = _PBC3MCODE;
            ht["P_PBC3SCODE"] = _PBC3SCODE;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1113", "UP_GET_SCODE_LIST", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {                    

                    cboPBC3NTCODE.SetValue(DataSet.Tables[0].Rows[0]["PBC3NTCODE"]);
                    let selectEl = document.querySelector("#cboPBC3LCODE");
                    var objOption = document.createElement("option");
                    objOption.text = DataSet.Tables[0].Rows[0]["PBC3LCODE"] + "-" + DataSet.Tables[0].Rows[0]["PBC3LCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["PBC3LCODE"];
                    selectEl.options.add(objOption);
                    /*cboPBC3LCODE.SetValue(DataSet.Tables[0].Rows[0]["PBC3LCODE"]);*/
                    selectEl = document.querySelector("#cboPBC3MCODE");
                    objOption = document.createElement("option");
                    objOption.text = DataSet.Tables[0].Rows[0]["PBC3MCODE"] + "-" + DataSet.Tables[0].Rows[0]["PBC3MCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["PBC3MCODE"];
                    selectEl.options.add(objOption);
                    /*cboPBC3MCODE.SetValue(DataSet.Tables[0].Rows[0]["PBC3MCODE"]);*/
                    txtPBC3SCODE.SetValue(DataSet.Tables[0].Rows[0]["PBC3SCODE"]);
                    txtPBC3NAME.SetValue(DataSet.Tables[0].Rows[0]["PBC3NAME"]);
                    txtPBC3BIGO.SetValue(DataSet.Tables[0].Rows[0]["PBC3BIGO"]);

                    cboPBC3NTCODE.SetDisabled(true);
                    cboPBC3LCODE.SetDisabled(true);
                    cboPBC3MCODE.SetDisabled(true);
                    txtPBC3SCODE.SetDisabled(true);
                    $("#txtPBC3SCODE").attr("style", "width:50px; background-color: gainsboro;");

                    DataGubn = "";

                    if (DataSet.Tables[0].Rows[0]["PBGUBUN"] == "Y") {
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

        // 신규 버튼
        function btnNew_Click()
        {
            
            txtPBC3SCODE.SetValue("");
            txtPBC3NAME.SetValue("");
            txtPBC3BIGO.SetValue("");

            cboPBC3NTCODE.SetDisabled(false);
            cboPBC3LCODE.SetDisabled(false);
            cboPBC3MCODE.SetDisabled(false);
            txtPBC3SCODE.SetDisabled(false);
            $("#txtPBC3SCODE").attr("style", "width:50px;");

            DataGubn = "A";

            btnDel.Hide();
        }

        // 저장 체크
        function UP_FieldCheck() {

            if (cboPBC3NTCODE.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="게시판 구분을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboPBC3LCODE.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="대분류코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboPBC3MCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="중분류코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBC3SCODE.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="소분류코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBC3SCODE.GetValue().length != 3) {
                alert('<Ctl:Text runat="server" Description="소분류코드는 세자리입니다." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBC3NAME.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="소분류명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (DataGubn == "A") {

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["P_PBC3NTCODE"] = cboPBC3NTCODE.GetValue();
                ht["P_PBC3LCODE"] = cboPBC3LCODE.GetValue();
                ht["P_PBC3MCODE"] = cboPBC3MCODE.GetValue();
                ht["P_PBC3SCODE"] = txtPBC3SCODE.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1113", "UP_BOARD_CLASS3_SAVECHECK", function (e) {

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

            ht["P_PBC3NTCODE"] = cboPBC3NTCODE.GetValue();
            ht["P_PBC3LCODE"] = cboPBC3LCODE.GetValue();
            ht["P_PBC3MCODE"] = cboPBC3MCODE.GetValue();
            ht["P_PBC3SCODE"] = txtPBC3SCODE.GetValue();
            ht["P_PBC3NAME"] = txtPBC3NAME.GetValue();
            ht["P_PBC3BIGO"] = txtPBC3BIGO.GetValue();
            ht["WKGUBUN"] = DataGubn;

            if (confirm('<Ctl:Text ID="MSG02" runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1113", "UP_BOARD_CLASS3_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            _PBC3NTCODE = cboPBC3NTCODE.GetValue();
                            _PBC3LCODE = cboPBC3LCODE.GetValue();
                            _PBC3MCODE = cboPBC3MCODE.GetValue();
                            _PBC3SCODE = txtPBC3SCODE.GetValue();

                            alert('<Ctl:Text runat="server"  Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                            UP_DataBind_Run();

                            if (opener) {
                                opener.btnSearch_Callback();
                                //self.close();
                            }
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

            ht["P_PBC3NTCODE"] = cboPBC3NTCODE.GetValue();
            ht["P_PBC3LCODE"] = cboPBC3LCODE.GetValue();
            ht["P_PBC3MCODE"] = cboPBC3MCODE.GetValue();
            ht["P_PBC3SCODE"] = txtPBC3SCODE.GetValue();
            ht["WKGUBUN"] = "D";

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1113", "UP_BOARD_CLASS3_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {
                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            
                            if (opener) {
                                opener.btnSearch_Callback();
                                //self.close();
                                btnNew_Click();
                            }

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

        // 게시판 구분 선택 이벤트
        function cboPBC3NTCODE_Change() {

            var ht = new Object();

            ht["P_PBC1NTCODE"] = cboPBC3NTCODE.GetValue();
            ht["P_GUBUN"] = '';

            if (DataGubn == "A") {
                cboPBC3LCODE.TypeName = "PSM.PSM1112";
                cboPBC3LCODE.MethodName = "UP_GET_LCODE_LIST";
                cboPBC3LCODE.DataTextField = "PBC1LCODENAME";
                cboPBC3LCODE.DataValueField = "PBC1LCODE";
                cboPBC3LCODE.Params(ht);
                cboPBC3LCODE.BindList();
                cboPBC3LCODE.SetValue();

                cboPBC3LCODE_Change();
            }
        }

        // 대분류 선택 이벤트
        function cboPBC3LCODE_Change() {

            var ht = new Object();

            ht["P_PBC2NTCODE"] = cboPBC3NTCODE.GetValue();
            ht["P_PBC2LCODE"] = cboPBC3LCODE.GetValue();
            ht["P_GUBUN"] = '';

            if (DataGubn == "A") {
                cboPBC3MCODE.TypeName = "PSM.PSM1113";
                cboPBC3MCODE.MethodName = "UP_GET_MCODE_LIST";
                cboPBC3MCODE.DataTextField = "PBC2MCODENAME";
                cboPBC3MCODE.DataValueField = "PBC2MCODE";
                cboPBC3MCODE.Params(ht);
                cboPBC3MCODE.BindList();

                cboPBC3MCODE.SetValue("");
            }

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
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="공정안전자료분류코드(소분류)" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
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
                        <table class="table_01" style="width:100%;" border="0">
                            <colgroup>
                                <col width="100px" />
                                <col width="*" />
                            </colgroup>                           
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblPBC3NTCODE" runat="server" LangCode="lblPBC3NTCODE" Description="게시판 구분" Required="true"></Ctl:Text>
                                </th>
                                <td>                                    
                                    <Ctl:Combo ID="cboPBC3NTCODE" Width="230px" runat="server" OnChange= "cboPBC3NTCODE_Change()"></Ctl:Combo>
                                </td>
                            </tr>  
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblPBC3LCODE" runat="server" LangCode="lblPBC3LCODE" Description="대분류" Required="true"></Ctl:Text>
                                </th>
                                <td>                                    
                                    <Ctl:Combo ID="cboPBC3LCODE" Width="230px" runat="server" OnChange= "cboPBC3LCODE_Change()"></Ctl:Combo>
                                </td>
                            </tr>  
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblPBC3MCODE" runat="server" LangCode="lblPBC3MCODE" Description="중분류" Required="true"></Ctl:Text>
                                </th>
                                <td>                                    
                                    <Ctl:Combo ID="cboPBC3MCODE" Width="230px" runat="server" ></Ctl:Combo>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblPBC3SCODE" runat="server" LangCode="lblPBC3SCODE" Description="소분류코드" Required="true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtPBC3SCODE" Width="50px" runat="server" LangCode="txtPBC3SCODE" Description="소분류코드" SetType="Number" MaxLength="3"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblPBC3NAME" runat="server" LangCode="lblPBC3NAME" Description="소분류명" Required="true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtPBC3NAME" Width="230px" runat="server" LangCode="txtPBC3NAME" Description="소분류명"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblPBC3BIGO" runat="server" LangCode="lblPBC3BIGO" Description="비 고" ></Ctl:Text>
                                </th>
                                <td>
                                 <Ctl:TextBox ID="txtPBC3BIGO" runat="server"  Height="80"
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

