<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMS1021.aspx.cs" Inherits="TaeYoung.Portal.SMS.SMS10.SMS1021" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    
   

    <script type="text/javascript">

        var _SMSGUBN = "";
        var _SMSSEQ = "";
        var DataGubn = "";
       
        function OnLoad() {

            var Num = "<%= Request.QueryString["CODE"] %>";

            var data = Num.split('^');

            if (data.length > 1) {
            
                _SMSGUBN = data[0];
                _SMSSEQ = data[1];

                UP_DataBing_Run();
            }
            else {

                DataGubn = "ADD";
                _SMSGUBN = '';

                btnDel.Hide();
            }
        }

        function UP_DataBing_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["SMSGUBN"] = _SMSGUBN;
            ht["SMSSEQ"] = _SMSSEQ;

            PageMethods.InvokeServiceTable(ht, "SMS.SMSBiz", "UP_SMS_SMSManager_FORM_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    cboCODE.SetValue(DataSet.Tables[0].Rows[0]["SMSGUBN"]);
                    txtSMSCONTENT.SetValue(DataSet.Tables[0].Rows[0]["SMSCONTENT"]);
                    cboCODE.SetDisabled(true);
                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });

        }

        function btnSave_Click() {         

            if (txtSMSCONTENT.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="문자내용을 입력하세요!" Literal="true"></Ctl:Text>');
                return false;
            }          

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["SMSGUBN"] = cboCODE.GetValue();
            if (DataGubn == 'ADD') {
                ht["SMSSEQ"] = '0';
            }
            else {
                ht["SMSSEQ"] = _SMSSEQ;
            }
            ht["SMSCONTENT"] = txtSMSCONTENT.GetValue();
            ht["SMSETC"] = '';
            ht["SMSHISAB"] = '0287-M';

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "SMS.SMSBiz", "UP_SMS_SMSManager_FORM_ADD", btnSave_After);
            }
        }

        function btnSave_After(e) {
            alert('<Ctl:Text ID="MSG07" runat="server" LangCode="MSG001" Description="저장이 완료 되었습니다." Literal="true" />');
            if (opener != null && typeof (opener.gridFORM_Binding()) == "function") {
                opener.gridFORM_Binding();
            }
            self.close();
        }

        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["SMSGUBN"] = cboCODE.GetValue();
            if (DataGubn == 'ADD') {
                ht["SMSSEQ"] = '0';
            }
            else {
                ht["SMSSEQ"] = _SMSSEQ;
            }

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG18" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "SMS.SMSBiz", "UP_SMS_SMSManager_FORM_DEL", btnDel_After);
            }
        }

        function btnDel_After(e) {
            alert('<Ctl:Text ID="MSG08" runat="server" LangCode="MSG001" Description="삭제가 완료 되었습니다." Literal="true" />');
            if (opener != null && typeof (opener.gridFORM_Binding()) == "function") {
                opener.gridFORM_Binding();
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
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="문자양식 등록" Literal="true"></Ctl:Text>
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
                </colgroup>
            <tr>
                <th><Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="구 분" Required = "true"></Ctl:Text></th>
                <td colspan="2">                                          
                   <Ctl:Combo ID="cboCODE" runat="server" TypeName="SMS.SMSBiz" MethodName="UP_SMS_SMSMANAGER_FORMCODE_LIST"
                              Params="{'PageSize':3}" DataTextField="GUBNNAME" DataValueField="GUBNCODE"
                              ReadMode="false" SelectedIndex="0" SelectedValue="2562" Width="200px"
                             OnChanged="return false;">
                   </Ctl:Combo>

                </td>
             
            </tr>
                 <tr>
               
                <th><Ctl:Text ID="Text2" runat="server" LangCode="TXT03" Description="내 용" Required = "true"></Ctl:Text></th>
                <td colspan="2">
                     <Ctl:TextBox ID="txtSMSCONTENT" runat="server"  Height="150"
                          PlaceHolder ="내 용" ReadMode="false" ReadOnly="false" SetType="text"
                          Style ="font-size:18px;" Text="" TextMode="MultiLine" Validation="false" Width="100%">
                     </Ctl:TextBox>
                </td>
            </tr>
                
            </table>
		</Ctl:Layer>

        
	</div>

</asp:content>