<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMS1031.aspx.cs" Inherits="TaeYoung.Portal.SMS.SMS10.SMS1031" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    
   

    <script type="text/javascript">

        var GWCODE = "";
        var SABUN = "";
        var DataGubn = "";
       
        function OnLoad() {

            var Num = "<%= Request.QueryString["GWCODE"] %>";
            
            var data = Num.split('^');

            if (data.length > 1) {

                DataGubn = "SAV";

                GWCODE = data[0];
                SABUN = data[1];

                UP_DataBing_Run();
            }
            else {

                DataGubn = "ADD";

                GWCODE = data[0];
            }
        }

        function UP_DataBing_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["ADDGROUP"] = GWCODE;
            ht["ADDSABUN"] = SABUN;
           
            PageMethods.InvokeServiceTable(ht, "SMS.SMSBiz", "UP_SMS_SMSManager_ADDETAIL_RUN", function (e) {

                var DataSet = eval(e);                

                if (ObjectCount(DataSet.Tables[0].Rows) > 0)
                {                    
                    $("#svSABUN_KBSABUN").val(DataSet.Tables[0].Rows[0]["ADDSABUN"]);
                    $("#svSABUN_KBHANGL").val(DataSet.Tables[0].Rows[0]["ADDNAME"]);
                    txtHTEL.SetValue(DataSet.Tables[0].Rows[0]["ADDTEL"]);   
                }               


            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });           

        }

        function btnSave_Click() {

            if (svSABUN.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="사번을 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            
            if (txtHTEL.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="전화번호를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtHTEL.GetValue().length < 13 || txtHTEL.GetValue().length > 13 ) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="전화번호 자리수를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
           
            ht["ADDGROUP"] = GWCODE;
            ht["ADDSABUN"] = $("#svSABUN_KBSABUN").val();

            PageMethods.InvokeServiceTableSync(ht, "SMS.SMSBiz", "UP_SMS_SMSManager_ADDETAIL_RUN", UP_Save_Callback);
        }

        function UP_Save_Callback(e) {

            var ds = eval(e);            

            if (DataGubn != "SAV") {

                if (ds != null && ds != undefined && ds.Tables.length > 0 && ds.Tables[0].Rows.length > 0) {

                    if (alert('<Ctl:Text runat="server" LangCode="MSG02" Description="이미 등록된 사번입니다." Literal="true"></Ctl:Text>') == null) {
                        self.close();
                    }
                    return false;
                }
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["ADDGROUP"] = GWCODE;
            ht["ADDSABUN"] = $("#svSABUN_KBSABUN").val();
            ht["ADDTEL"] = txtHTEL.GetValue();
            ht["ADMHISAB"] = "0287-M";

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "SMS.SMSBiz", "UP_SMS_SMSManager_ADDETAIL_ADD", btnSave_After);
            }           
        }

        function btnSave_After(e) {
            alert('<Ctl:Text ID="MSG07" runat="server" LangCode="MSG001" Description="저장이 완료 되었습니다." Literal="true" />');
            if (opener != null && typeof (opener.gridDetail_Binding(GWCODE)) == "function") {
                opener.gridDetail_Binding(GWCODE);
            }
            self.close();
        }

        function btnDel_Click() {

            if (svSABUN.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="사번을 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtHTEL.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="전화번호를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["ADDGROUP"] = GWCODE;
            ht["ADDSABUN"] = $("#svSABUN_KBSABUN").val();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "SMS.SMSBiz", "UP_SMS_SMSManager_ADDETAIL_DEL", btnDel_After);                
            }
        }

        function btnDel_After(e) {
            alert('<Ctl:Text ID="MSG08" runat="server" LangCode="MSG001" Description="삭제가 완료 되었습니다." Literal="true" />');
            if (opener != null && typeof (opener.gridDetail_Binding(GWCODE)) == "function") {
                opener.gridDetail_Binding(GWCODE);
            }
            self.close();
        }

        function btnClose_Click() {

            this.close();            
        }

       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="사번 등록" Literal="true"></Ctl:Text>
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
                    <col style="width:100px;" />
                    <col style="width:160px;" />
                    <col style="width:100px;" />
                    <col style="width:150px" />
                </colgroup>
            <tr>
                <th><Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="사 번" Required = "true"></Ctl:Text></th>
                <td colspan="2">                                          
                     <Ctl:SearchView ID="svSABUN" runat="server" TypeName="SMS.SMSBiz" MethodName="UP_SMS_KBSABUN_LIST" >   
                              <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" />
                              <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="130" TextBox="true" Default="true" runat="server" />
                     </Ctl:SearchView>
                </td>
                <th><Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="전화번호" Required = "true"></Ctl:Text></th>
                <td colspan="2">
                    <Ctl:TextBox ID="txtHTEL" Required="true" Width="150px" runat="server"></Ctl:TextBox> ( '-' 포함 )
                </td>
            </tr>
                
            </table>
		</Ctl:Layer>

        
	</div>

</asp:content>