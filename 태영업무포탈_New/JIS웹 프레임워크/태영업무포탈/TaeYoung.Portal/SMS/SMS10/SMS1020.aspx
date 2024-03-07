<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMS1020.aspx.cs" Inherits="TaeYoung.Portal.SMS.SMS10.SMS1020" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">


        var Parenthts = new Array();  //부모창 선택 그리드값 저장 배열 변수

        function OnLoad() {

            txtSendTel.SetValue('0522283300');

            btnSearch_Click();

            UP_Get_SMSCount();

            $("#txtMSG").change(function () {
                CheckBox_CheckHandle();
            });

            gridAddress_Binding();

            // 수신확인 체크 이벤트 적용
            $("#layer3").find("input").each(function () {
                // 클릭
                $(this).on("click", function () {

                    CheckBox_CheckHandle();

                });
            });
        }

        //수신확인 체크 이벤트
        function CheckBox_CheckHandle() {                        

            if ($("input:checkbox[name=Chk_Smscheck]:checkbox[value=Chk_Smscheck]").prop('checked') == true) {
                ShortByteCheck();  //60byte 제한
            }
            else {
                displayBytes();   //90byte 제한
            }
        }

        function btnSearch_Click() {

            gridFORM_Binding();         
        }

        function gridFORM_Binding() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 50;
            ht["SMSGUBN"] = "";
            ht["SMSSEQ"] = "";

            gridFORM.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridFORM.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

        function gridAddress_Binding() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["ADDGROUP"] = '99';

            gridAddress.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridAddress.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        function gridBtnClick(r, c) {

            var dr = gridFORM.GetRow(r);

            txtMSG.SetValue(dr["SMSCONTENT"]);

            displayBytes();
        }

        function gridClick(r, c) {
            
            var rw = gridFORM.GetRow(r);

            var NUM = rw["SMSGUBN"] + '^' + rw["SMSSEQ"];

            fn_OpenPopCustom("SMS1021.aspx?CODE=" + NUM, 800, 300, NUM);
          
        }

        function gridSendClick(r, c) {            

            gridAddress.RemoveRows([r*1]);         

            var index = ObjectCount(gridAddress.GetAllRow().Rows);
            txtReciveCnt.SetValue(index + ' 명');
            
        }       

        //문자 발송 가능건수 가져오기
        function UP_Get_SMSCount() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.                   

            PageMethods.InvokeServiceTable(ht, "SMS.SMSBiz", "UP_Get_SMSCount", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtSMSCNT.SetValue(DataSet.Tables[0].Rows[0]["MSG"].toString() + ' 건');
                }

            }, function (e) {
                // Biz 연결오류
                alert('error');
            });

        }

       /******************************************************************************************
       * 함수명 : btnSMSSend_Click
       * 설  명 : 문자전송 버튼 이벤트
       ******************************************************************************************/

        function btnSMSSend_Click() {
                       

            var obj = txtMSG.GetValue();

            if (bytes(obj) <= 0) {
                alert("전송할 문자를 입력하세요!");
                return;                
            }

            if ($("input:checkbox[name=Chk_Smscheck]:checkbox[value=Chk_Smscheck]").prop('checked') == true) {

                if (bytes(obj) > 60) {
                    alert("60byte를 초과하였습니다.");
                    return;
                }
            }
            else {
                if (bytes(obj) > 90) {
                    alert("90byte를 초과하였습니다.");
                    return;
                }
            }

            var dt = gridAddress.GetAllRow();

            if (ObjectCount(dt.Rows) > 0 ) {

                if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG19" Description="전송 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    var hts = new Array();

                    for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                        var ht = new Object();

                        ht["LODRECSAB"] = dt.Rows[i]['ADDSABUN'];
                        ht["LOMCONTENT"] = txtMSG.GetValue();

                        hts.push(ht);
                    }

                    PageMethods.InvokeServiceTable(ht, "SMS.SMSBiz", "UP_Get_SMSCount", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                            var iSmsCnt = DataSet.Tables[0].Rows[0]["MSG"].toString();

                            if (hts.length > iSmsCnt) {
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="문자전송가능 건수가 부족합니다." Literal="true"></Ctl:Text>');
                                return;
                            }

                        }

                    }, function (e) {
                        // Biz 연결오류
                        alert('error');
                    });


                    PageMethods.InvokeServiceTableArray(ht, hts, "SMS.SMSBiz", "UP_SMS_SendMessage", btnSMSSend_After);
                }

            }
            else {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="수신자가 없습니다!" Literal="true"></Ctl:Text>');
                return;
            }
            

        }

        function btnSMSSend_After(e) {

            var DataSet = eval(e);

            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                var code = DataSet.Tables[0].Rows[0]["CODE"];
                var message = DataSet.Tables[0].Rows[0]["MSG"];

                alert(message);
            }

            txtMSG.SetValue('');

            UP_GridSetClear();

            UP_Get_SMSCount();
        }

        /******************************************************************************************
         * 함수명 : btnSMSCancel_Click
         * 설  명 : 문자 취소 버튼 이벤트
        ******************************************************************************************/

        function btnSMSCancel_Click() {

            txtMSG.SetValue('');

            CheckBox_CheckHandle();

            UP_GridSetClear();

        }

        function UP_GridSetClear() {

            gridAddress.RemoveAllRow();
            var index = ObjectCount(gridAddress.GetAllRow().Rows);
            txtReciveCnt.SetValue(index + ' 명');
        }
        /**********************************************************************
        * SMS1022 에서 SMS1020 으로 수신자리스트 배열로 가져오기
        **********************************************************************/
        function UP_Get_Address(hts) {            

            gridAddress.RemoveAllRow();

            var rows = gridAddress.GetAllRow().Rows;
            var index = ObjectCount(rows);

            for ( var i = 0; i < hts.length; i++) {

                gridAddress.InsertRow();
                gridAddress.SetValue(index, "KBBSTEAM", hts[i]["KBBSTEAM"]);
                gridAddress.SetValue(index, "KBBSTEAMNM", hts[i]["KBBSTEAMNM"]);
                gridAddress.SetValue(index, "ADDSABUN", hts[i]["ADDSABUN"]);
                gridAddress.SetValue(index, "ADDNAME", hts[i]["ADDNAME"]);
                //gridAddress.SetValue(index, "ADDDEL", '<input type="button" value="삭제" id="gridAddress_0_1_btn" style="width: 98%; height: auto; padding: 2px; cursor: pointer; background-color: rgb(255, 255, 255); color: rgb(100, 100, 100);">');
                var id = '#gridAddress_' + index + '_2_btn';

                gridAddress.SetValue(index, "ADDDEL", "<img  id='" + id +"' style='cursor:pointer' src= '/Resources/Images/ext_delete.png' onclick= UP_GridRowClick(this) >");

                //$(id).val('삭제');

                index = index + 1;
            }


            txtReciveCnt.SetValue(index + ' 명');
        }

        function UP_GridRowClick(id) {

            var index = id.parentNode.id.indexOf('_',0);

            var r = id.parentNode.id.substr(index+1, 1);

            gridSendClick(r, 2);
        }      
       
        /**********************************************************************
        * 문자 byte  --- 시작
       **********************************************************************/

        function ShortByteCheck() {

            var obj = txtMSG.GetValue();

            if (bytes(obj) > 60) {
                alert("60byte를 초과하였습니다.");
                txtMSG.SetValue(txtMSG.GetValue().toString().substring(0, bytelength(obj)));
            }

            txtSmsbyte.SetValue(bytes(obj) + " / 60 bytes");           
        }

        function displayBytes() {

            var obj = txtMSG.GetValue();

            if (bytes(obj) > 90) {
                alert("90byte를 초과하였습니다.");
                txtMSG.SetValue(txtMSG.GetValue().toString().substring(0, bytelength(obj)));
            }

            txtSmsbyte.SetValue(bytes(obj) + " / 90 bytes");
        }

        function bytes(obj) {

            var str = obj;

            var l = 0;
            for (var i = 0; i < str.length; i++)l += (str.charCodeAt(i) > 128) ? 2 : 1;
            return l;
        }

        function bytelength(obj) {

            var str = obj;
            var l = 0;
            var i = 0;
            for (i = 0; i < str.length; i++) {
                l += (str.charCodeAt(i) > 128) ? 2 : 1;
                if (l > 60) {
                    return i;
                }
            }
            return i;
        }
        /**********************************************************************
         * 문자 byte --- 종료
        **********************************************************************/

        function btnNew_Click() {            

            var NUM = '';

            fn_OpenPopCustom("SMS1021.aspx?CODE=" + NUM, 800, 300, NUM);
        }

        function btnAddress_Click() {

            Parenthts.splice(0, Parenthts.length);

            var dt = gridAddress.GetAllRow();

            if (dt) {
                for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                    var ht = new Object();

                    ht["KBBSTEAM"] = dt.Rows[i]['KBBSTEAM'];
                    ht["KBBSTEAMNM"] = dt.Rows[i]['KBBSTEAMNM'];
                    ht["ADDSABUN"] = dt.Rows[i]['ADDSABUN'];
                    ht["ADDNAME"] = dt.Rows[i]['ADDNAME'];

                    Parenthts.push(ht);
                }
            }                       

            fn_OpenPopCustom("SMS1022.aspx", 800, 530);
        }

        function UP_ChildFomArray() {
            winPop.UP_Get_ParentGridValue(Parenthts);
        }

        var winPop;

        function fn_OpenPopCustom(url, w, h, name) {
            if (url == "" || url == null || url == undefined) return;

            w = (w == undefined || w == null) ? 600 : w;
            h = (h == undefined || h == null) ? 400 : h;

            var strLeft = (window.screen.width - w) / 2;
            var strTop = (window.screen.height - h) / 2;

            var feat = "toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=" + w + ",height=" + h + ",top=" + strTop + ",left=" + strLeft;

            if (!winPop || (winPop && winPop.closed)) {
                winPop = window.open(url, name, feat);
            } else {
                winPop.location.href = url;
            }
            winPop.focus();
        }

       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
  <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="일반문자통보" Literal="true"></Ctl:Text>
        </h4>    
        <div class="btn_bx">
            <Ctl:Button ID="btnSearch" runat="server" Style="Orange" LangCode="TXT04" Description="조회" OnClientClick="btnSearch_Click();" ></Ctl:Button>            
            <Ctl:Button ID="btnNew" runat="server" Style="Orange" LangCode="TXT04" Description="신규" OnClientClick="btnNew_Click();" ></Ctl:Button>            
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">

         <Ctl:Layer ID="layer1" runat="server">
		    <table class="table_01" style="width:100%;" border="0">
                <colgroup>
                    <col style="width:30%;" />
                    <col style="width:65%;" />
                </colgroup>
           
            <tr>
                <td style="padding-right : 2px;">
                        <Ctl:Layer ID="layer3" runat="server" Title="" DefaultHide="False" Collapsible = "False">
                            <div class="btn_bx">
                               <Ctl:Button ID="btnSMSSend" runat="server" Style="Orange" LangCode="TXT04" Description="전송" OnClientClick="btnSMSSend_Click();" ></Ctl:Button>            
                               <Ctl:Button ID="btnSMSCancel" runat="server" Style="Orange" LangCode="TXT04" Description="취소" OnClientClick="btnSMSCancel_Click();" ></Ctl:Button>  
                            </div> 
                            <table class="table_01" style="width: 100%;border-bottom:1px">
                                <colgroup>
                                    <col width="25%" />
                                    <col width="65%" />
                                </colgroup>
                                <tr style="vertical-align:top;" >
                                    <td colspan = "2" style = "height:130px;">
                                        <Ctl:TextBox ID="txtMSG" runat="server"  Height="150"
                                            PlaceHolder ="내 용" ReadMode="false" ReadOnly="false" SetType="text"
                                            Style ="font-size:18px;" Text="" TextMode="MultiLine" Validation="false" Width="100%" >
                                         </Ctl:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="Text19" runat="server" LangCode="TXT_txtPRM_PROGRAMID" Description="SMS" /></th>
                                    <td>
                                        <Ctl:Text ID="txtSmsbyte" runat="server" LangCode="TXT_Smsbyte" Description=" 0 / 90 Bytes" Required="true"></Ctl:Text>
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="Text2" runat="server" LangCode="TXT_txtPRM_PROGRAMID" Description="발송가능건수" /></th>
                                    <td>
                                        <Ctl:Text ID="txtSMSCNT" runat="server" LangCode="TXT_txtSMSCNT" Description="1002 건" Required="true"></Ctl:Text>
                                    </td>
                                </tr>
                                 <tr>
                                    <th><Ctl:Text ID="Text1" runat="server" LangCode="TXT_txtPRM_PROGRAMID" Description="발신자" /></th>
                                    <td>
                                        <Ctl:TextBox ID="txtSendTel" runat="server" ReadOnly="true" ></Ctl:TextBox> 
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan = "2">
                                        <Ctl:Text ID="Text4" runat="server" LangCode="TXT_txtSMSCNT" Description="수신확인(문자내용 60 byte로 제한)" ></Ctl:Text>
                                         <Ctl:CheckBox ID="Chk_Smscheck" runat="server">
                                             <asp:ListItem Text="" Value="Chk_Smscheck" LangCode="chk1_1" Description=""></asp:ListItem>                                             
                                        </Ctl:CheckBox> 
                                    </td>
                                </tr>                                               
                                <tr>
                                   
                                       <th><Ctl:Text ID="Text3" runat="server" LangCode="TXT_txtPRM_PROGRAMID" Description="수신자리스트" /></th>
                                       <td style="text-align:center" >
                                          <Ctl:Text ID="txtReciveCnt" runat="server" LangCode="TXT_txtSMSCNT" Description="0 명" ></Ctl:Text>  
                                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          <Ctl:Button ID="btnAddress" runat="server" LangCode="btnAddress" Description="주소록" OnClientClick="btnAddress_Click(); return false;" InGrid= "True" ></Ctl:Button>                                           
                                       </td>
                                   
                                </tr>
                                 <tr>
                                     <td colspan = "2">
                                           <Ctl:WebSheet ID="gridAddress" runat="server"  Paging="false"  HFixation="true"  Width="100%" Height="300" CheckBox="false"  TypeName="SMS.SMSBiz" MethodName="UP_SMS_SMSManager_ADDETAIL_LIST"  UseColumnSort="true" HeaderHeight="20" CellHeight="30" >                            
                                
                                                <Ctl:SheetField DataField="KBBSTEAM"    AutoMerge="true" TextField="KBBSTEAM"   Hidden="true"  Description="부서코드" Width="85" HAlign="center" Align="left"   runat="server" />
                                                <Ctl:SheetField DataField="KBBSTEAMNM"  AutoMerge="true" TextField="KBBSTEAMNM"  Hidden="true"   Description="부서명" Width="85" HAlign="center" Align="left"   runat="server" />
                                                <Ctl:SheetField DataField="ADDSABUN"    TextField="ADDSABUN"    Description="사번" Width="85" HAlign="center" Align="left"     runat="server" />
                                                <Ctl:SheetField DataField="ADDNAME"     TextField="ADDNAME"     Description="이름" Width="100"  HAlign="center" Align="left"   runat="server" />                            
                                                <Ctl:SheetField DataField="ADDDEL"      TextField=""     Description="" Width="30"  HAlign="center" Align="center"   runat="server" />                            
                                                <%--<Ctl:SheetField DataField="ADDDEL"    DataType = "Button" TextField=""    Description="" Width="30" HAlign="center" Align="center"  OnClick="gridSendClick"  runat="server" />--%>

                                            </Ctl:WebSheet>  
                                         </td>
                                  </tr>                                           
                            </table>

                        </Ctl:Layer>
                    </td>

                    <td valign="top">
                        <Ctl:WebSheet ID="gridFORM" runat="server" Paging="true"  Width="100%"  HFixation="true" Height="650" CheckBox="false"  TypeName="SMS.SMSBiz" MethodName="UP_SMS_SMSManager_FORM_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                                <Ctl:SheetField DataField="CHK"    DataType = "Button" TextField=""    Description="" Width="40" HAlign="center" Align="center"  OnClick="gridBtnClick"  runat="server" />
                                <Ctl:SheetField DataField="ROWNO"     TextField="ROWNO"    Description="번 호" Width="30" HAlign="center" Align="center"  OnClick="gridClick"  runat="server" />
                                <Ctl:SheetField DataField="SMSGUBN"     TextField="SMSGUBN"     Description="CODE" Width="100"  HAlign="center" Align="left"  Hidden="true" runat="server" />
                                <Ctl:SheetField DataField="SMSSEQ"     TextField="SMSSEQ"     Description="SEQ" Width="100"  HAlign="center" Align="left"    Hidden="true" runat="server" />
                                <Ctl:SheetField DataField="SMSGUBNNM"     TextField="SMSGUBNNM"     Description="구 분" Width="100"  HAlign="center" Align="left" OnClick="gridClick"  runat="server" />
                                <Ctl:SheetField DataField="SMSCONTENT"     TextField="SMSCONTENT"     Description="내 용" Width="400"  HAlign="center" Align="left"  OnClick="gridClick" runat="server" />

                         </Ctl:WebSheet>  
                   </td>
             </tr>            
            </table>             
		</Ctl:Layer>
       

		
	</div>
</asp:content>