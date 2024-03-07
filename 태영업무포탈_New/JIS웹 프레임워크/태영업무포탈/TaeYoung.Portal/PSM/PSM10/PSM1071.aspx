<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1071.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1071" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _CMSBCODE = "";
        var _CMGRCODE = "";
        var _CMGRSEQ = "";
        var DataGubn = "";
        var _id = "";

        // 페이지 로드
        function OnLoad() {

            var Code = "<%= Request.QueryString["CODE"] %>";

            var data = Code.split('^');

            if (data.length > 2) {

                
                DataGubn = "";
                _CMSBCODE = data[0];
                _CMGRCODE = data[1];
                _CMGRSEQ = data[2];
                
                UP_DataBind_Run();
            }
            else {

                DataGubn = "ADD";
                _CMSBCODE = "";
                _CMGRCODE = "";
                _CMGRSEQ = "";

                UP_FiledInit();

                btnDel.Hide();
            }
        }

        function UP_FiledInit() {

            var today = new Date();
            txtCMWRDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));  //작성일자

            svCMWRSABUN.SetValue("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>");    //작성자s
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["CMSBCODE"] = _CMSBCODE;
            ht["CMGRCODE"] = _CMGRCODE;
            ht["CMGRSEQ"] = _CMGRSEQ;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1070", "UP_CHECKLIST_MCODE_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    cboCMSBCODE.SetValue(DataSet.Tables[0].Rows[0]["CMSBCODE"]);    //사업부
                    svCMGRCODE.SetValue(DataSet.Tables[0].Rows[0]["CMGRCODE"]);      //그룹코드
                    $("#svCMGRCODE_CDDESC1").val(DataSet.Tables[0].Rows[0]["CDDESC1"]);
                    txtCMGRSEQ.SetValue(DataSet.Tables[0].Rows[0]["CMGRSEQ"]);    //그룹순번
                    txtCMMCNUM.SetValue(DataSet.Tables[0].Rows[0]["CMMCNUM"]);    //장치번호
                    txtCMDESC.SetValue(DataSet.Tables[0].Rows[0]["CMDESC"]);    //내용
                    svCMWRSABUN.SetValue(DataSet.Tables[0].Rows[0]["CMWRSABUN"]);    //작성자
                    txtCMWRDATE.SetValue(DataSet.Tables[0].Rows[0]["CMWRDATE"]);    //작성일자

                    cboCMSBCODE.SetDisabled(true);
                    svCMGRCODE.SetDisabled(true);
                    $("#svCMGRCODE_CDCODE_img").attr("style", "display:none");
                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        // 저장 버튼 이벤트
        function btnSave_Click() {         

            if (cboCMSBCODE.GetValue() == "" || cboCMSBCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="사업부를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (svCMGRCODE.GetValue() == "" || svCMGRCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="그룹코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            else if (svCMGRCODE.GetValue() == "07") {

                if (txtCMMCNUM.GetValue() == "" || txtCMMCNUM.GetValue() == null) {
                    alert('<Ctl:Text runat="server"  Description="장치번호를 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
                if (txtCMDESC.GetValue() == "" || txtCMDESC.GetValue() == null) {
                    alert('<Ctl:Text runat="server" Description="내용을 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }
            
            if (svCMWRSABUN.GetValue() == "" || svCMWRSABUN.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="작성자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtCMWRDATE.GetValue() == "" || txtCMWRDATE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="작성일자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CMSBCODE"] = cboCMSBCODE.GetValue();
            ht["CMGRCODE"] = svCMGRCODE.GetValue();

            if (DataGubn == 'ADD') {
                ht["CMGRSEQ"] = "0";
            }
            else {
                ht["CMGRSEQ"] = txtCMGRSEQ.GetValue();
            }
            ht["CMMCNUM"] = txtCMMCNUM.GetValue();
            ht["CMDESC"] = txtCMDESC.GetValue();
            ht["CMWRSABUN"] = svCMWRSABUN.GetValue();
            ht["CMWRDATE"] = txtCMWRDATE.GetValue();

            if (DataGubn == "ADD") {
                ht["WKGUBUN"] = "A";
            }
            else {
                ht["WKGUBUN"] = "C";
            }
            
            if (confirm('<Ctl:Text runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1070", "UP_CHECKLIST_MCODE_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {
                            
                        DataGubn = "";
                        _CMSBCODE = DataSet.Tables[0].Rows[0]["CMSBCODE"];
                        _CMGRCODE = DataSet.Tables[0].Rows[0]["CMGRCODE"];
                        _CMGRSEQ = DataSet.Tables[0].Rows[0]["CMGRSEQ"];
                            
                        UP_DataBind_Run();

                        btnDel.Show();

                        alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                        if (opener != null && typeof (opener.btnSearch_Click) == "function") {
                            opener.btnSearch_Click();
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

        // 삭제 버튼 이벤트
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["CMSBCODE"] = cboCMSBCODE.GetValue();
            ht["CMGRCODE"] = svCMGRCODE.GetValue();
            ht["CMGRSEQ"] = txtCMGRSEQ.GetValue();
            ht["WKGUBUN"] = "D";

            if (confirm('<Ctl:Text ID="MSG03" runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1070", "UP_CHECKLIST_MCODE_DEL", function (e) {

                    alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                    if (opener != null && typeof (opener.btnSearch_Click) == "function") {
                        opener.btnSearch_Click();
                    }
                    this.close();

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            this.close();            
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="항목코드 등록" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
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
                    <col width="100px" />
                    <col width="100px" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="lblCMSBCODE" runat="server" LangCode="lblCMSBCODE" Description="사업부" Required = "true"></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:Combo ID="cboCMSBCODE" Width="60px" runat="server" >
                            <asp:ListItem Selected="True" Text="UTT" Value="T"></asp:ListItem>
                            <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblCMGRCODE" runat="server" LangCode="lblCMGRCODE" Description="그룹" Required = "true"></Ctl:Text>
                    </th>
                    <td >
                        <Ctl:SearchView ID="svCMGRCODE" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'CK'}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                            <Ctl:SearchViewField runat="server" DataField="CDCODE"  TextField="CDCODE" Description="코드" Hidden="false" TextBox="true" Width="100" Default="true"  />
                            <Ctl:SearchViewField runat="server" DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" TextBox="true" Width="100" />                                            
                        </Ctl:SearchView>
                    </td>
                    <th>
                        <Ctl:Text ID="lblCMGRSEQ" runat="server" LangCode="lblCMGRSEQ" Description="그룹순번" ></Ctl:Text>
                    </th>
                    <td>
                       <Ctl:TextBox ID="txtCMGRSEQ" Width="80" runat="server" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>  
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblCMMCNUM" runat="server" LangCode="lblCMMCNUM" Description="장치번호" ></Ctl:Text>
                    </th>
                    <td colspan="3">
                       <Ctl:TextBox ID="txtCMMCNUM" Width="80" runat="server" ></Ctl:TextBox>  
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblCMDESC" runat="server" LangCode="lblCMDESC" Description="내용"></Ctl:Text>
                    </th>
                    <td colspan="3">
                       <Ctl:TextBox ID="txtCMDESC" Width="250" runat="server"></Ctl:TextBox>  
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblCMWRSABUN" runat="server" LangCode="lblCMWRSABUN" Description="작성자" Required = "true"></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:SearchView ID="svCMWRSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                            <Ctl:SearchViewField runat="server" DataField="KBSABUN"   TextField="KBSABUN"   Description="사 번" Hidden="false" TextBox="true" Width="100" Default="true"  />
                            <Ctl:SearchViewField runat="server" DataField="KBHANGL" TextField="KBHANGL" Description="이 름"     Hidden="false" TextBox="true" Width="100" />                                            
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblCMWRDATE" runat="server" LangCode="lblCMWRDATE" Description="작성일자" Required = "true"></Ctl:Text>
                    </th>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtCMWRDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                    </td>
                </tr>
            </table>
		</Ctl:Layer>
	</div>

</asp:content>