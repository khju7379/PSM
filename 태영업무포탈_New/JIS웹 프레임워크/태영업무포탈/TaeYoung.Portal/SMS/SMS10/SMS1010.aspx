<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMS1010.aspx.cs" Inherits="TaeYoung.Portal.SMS.SMS10.SMS1010" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
        <style>           
        
        .control_rabel
        {
            padding: 10px;
            font-size: 20px;
        }      

        span input[type=radio],span input[type=checkbox] {width: 20px; border: none; background: none;}
        
        #wtOrg
        {           
          overflow-y:auto;
        }         
        </style>

    <script type="text/javascript">

        var idx = "";

        var initMsg = '[긴급문자알림]';

        var SaupMsg;
        var LocationMsg;
        var AccidentMsg;

        var _GroupCode;        


        function OnLoad() {

            //var url = window.location.host;           

            _GroupCode = '';

            UP_Set_LocationChanged('S');

            UP_OrgTreeDataBing('Load');

            SaupMsg = 'SILO';
            LocationMsg = '';
            AccidentMsg = '';

            UP_Get_SMSCount();

            UP_Set_Message();

            $("#btnSMSSEND").css({ "background": "#F15F5F", "font-size": "20px", "color": "white" });

            CheckBox_CheckHandle();
        }

        function CheckBox_CheckHandle() {

            // 체크박스 이벤트 적용
            $("#chkbox_silo").find("input").each(function () {
                // 클릭
                $(this).on("click", function () {
                    if ($(this).prop("checked")) {
                        $(this).prop("checked", false);
                    }
                    else {
                        $(this).prop("checked", true);
                    }
                });
            });

            // div에 클릭 이벤트 적용
            $("#chkbox_silo").find("div").each(function () {
                $(this).on("click", function () {

                    // 클릭한 체크박스
                    var chk = $(this).find("input");

                    // 
                    if ($(chk).prop("checked")) {
                        $(chk).prop("checked", false);
                    }
                    else {
                        $(chk).prop("checked", true);
                    }

                    // 체크박스 변경시 발생 이벤트
                    CheckBox_Changed(chk);
                });
            });

            // 체크박스 이벤트 적용
            $("#chkbox_utt").find("input").each(function () {
                // 클릭
                $(this).on("click", function () {
                    if ($(this).prop("checked")) {
                        $(this).prop("checked", false);
                    }
                    else {
                        $(this).prop("checked", true);
                    }
                });
            });

            // div에 클릭 이벤트 적용
            $("#chkbox_utt").find("div").each(function () {
                $(this).on("click", function () {

                    // 클릭한 체크박스
                    var chk = $(this).find("input");

                    // 
                    if ($(chk).prop("checked")) {
                        $(chk).prop("checked", false);
                    }
                    else {
                        $(chk).prop("checked", true);
                    }

                    // 체크박스 변경시 발생 이벤트
                    CheckBox_Changed(chk);
                });
            });
        }

        function CheckBox_Changed(o) {
            //alert($(o).prop("checked"));

            _GroupCode = '';

            var id = $(o).attr('id');

            if (id.substr(0, 4) == 'chks') {

                //silo수신자 
                switch (id) {
                    case 'chks_all':
                        $("#chks_team").prop("checked", false);
                        $("#chks_silo").prop("checked", false);
                        $("#chks_manage").prop("checked", false);                       
                        break;
                    case 'chks_team':
                        $("#chks_all").prop("checked", false);
                        break;
                    case 'chks_silo':
                        $("#chks_all").prop("checked", false);                       
                        break;
                    case 'chks_manage':
                        $("#chks_all").prop("checked", false);
                        break;
                    default:
                        break;
                }                

                if ($("#chks_all").prop("checked") == true) {
                    _GroupCode = '1,';       //전체              
                }
                else {
                    if ($("#chks_team").prop("checked") == true) {
                        _GroupCode = '2' + ',';    //팀장,안전환경팀                    
                    }
                    if ($("#chks_silo").prop("checked") == true) {
                        _GroupCode = _GroupCode + '3' + ',';  //silo
                    }
                    if ($("#chks_manage").prop("checked") == true) {
                        _GroupCode = _GroupCode + '6' + ',';  //관리팀
                    }
                }
            }
            else {
                //utt수신자 
                switch (id) {
                    case 'chkt_all':
                        $("#chkt_team").prop("checked", false);
                        $("#chkt_utt").prop("checked", false);                        
                        break;
                    case 'chkt_team':
                        $("#chkt_all").prop("checked", false);                       
                        break;
                    case 'chkt_utt':
                        $("#chkt_all").prop("checked", false);
                        break;
                    default:
                        break;
                }

                if ($("#chkt_all").prop("checked") == true) {
                    _GroupCode = '1,';  //전체
                }
                else {
                    if ($("#chkt_team").prop("checked") == true) {
                        _GroupCode = '4' + ',';  //팀장,안전환경팀       
                    }
                    if ($("#chkt_utt").prop("checked") == true) {
                        _GroupCode = _GroupCode + '5' + ',';  //UTT
                    }                   
                }
            }

            _GroupCode = _GroupCode.substr(0, _GroupCode.length - 1);
           
            UP_OrgTreeDataBing('');
        }

        function UP_Set_Message() {

            var text = ' [긴급문자알림]' + '\n ' + SaupMsg + '  ' + LocationMsg + ' ' + AccidentMsg;

            txtMSG.SetValue(text);

            displayBytes();
        }

        /**********************************************************************
         * 구분 선택 이벤트 --- 시작
        **********************************************************************/
        function rdoS_Changed() {                        

            Rdo_T.SetValue("");
            UP_Set_LocationChanged('S');

            UP_Set_RadioClear('trLocation_T'); //사고위치
            UP_Set_RadioClear('trAccident');  //사고종류

            SaupMsg = 'SILO';
            LocationMsg = '';
            AccidentMsg = '';

            UP_OrgTreeDataBing('Load');

            UP_Set_Message();
        }
        function rdoT_Changed() {

            Rdo_S.SetValue("");
            UP_Set_LocationChanged('T');

            UP_Set_RadioClear('trLocation_S'); //사고위치
            UP_Set_RadioClear('trAccident');   //사고종류

            SaupMsg = 'UTT';
            LocationMsg = '';
            AccidentMsg = '';

            UP_OrgTreeDataBing('Load');

            UP_Set_Message();
        }
        /**********************************************************************
         * 구분 선택 이벤트 --- 종료
        **********************************************************************/        
       
        /**********************************************************************
          * 사고위치 선택 이벤트 --- 시작
        **********************************************************************/

        function UP_Set_LocationChanged(G) {

            if (G == "S") {
                document.getElementById("trLocation_T").style.display = "none";
                document.getElementById("trLocation_S").style.display = "";
                document.getElementById("trRecive_T").style.display = "none";
                document.getElementById("trRecive_S").style.display = "";

            }
            else {
                document.getElementById("trLocation_S").style.display = "none";
                document.getElementById("trLocation_T").style.display = "";
                document.getElementById("trRecive_T").style.display = "";
                document.getElementById("trRecive_S").style.display = "none";

            }
        }

        function rdoLocationS_Changed(id) {          

            var sWin = document.getElementById("trLocation_S");
            var theadObj = sWin.querySelectorAll("span");

            UP_Set_RadioCheckValue(theadObj, id);

            UP_Set_Message();
        }

        function rdoLocationT_Changed(id) {

            var sWin = document.getElementById("trLocation_T");
            var theadObj = sWin.querySelectorAll("span");

            UP_Set_RadioCheckValue(theadObj, id);

            UP_Set_Message();
        }

        function UP_Set_RadioCheckValue(theadObj, id) {

            var idname = id.GetValue();

            if (theadObj.length > 0) {

                for (var i = 0; i < theadObj.length; i++) {

                    if (theadObj[i].id == idname) {

                        $("input:radio[name=" + idname + "]:radio[value=" + idname + "]").prop('checked', true);

                        if (theadObj[i].id.substr(0, 4) == 'RdoG') {
                            AccidentMsg = theadObj[i].innerText + ' 발생!!';  //사고유형
                        }
                        else {
                            LocationMsg = theadObj[i].innerText;  //사고위치
                        }                        
                    }
                    else {

                        $("input:radio[name=" + theadObj[i].id + "]:radio[value=" + theadObj[i].id + "]").prop('checked', false);

                    }
                }
            }
        }

        function UP_Set_RadioClear(trname) {

            var sWin = document.getElementById(trname);
                         
            var theadObj = sWin.querySelectorAll("span");

            if (theadObj.length > 0) {

                for (var i = 0; i < theadObj.length; i++) {
                   
                    $("input:radio[name=" + theadObj[i].id + "]:radio[value=" + theadObj[i].id + "]").prop('checked', false);                   
                }
            }

            $("#chks_team").prop("checked", false);
            $("#chks_silo").prop("checked", false);
            $("#chks_manage").prop("checked", false);
            $("#chks_all").prop("checked", false);

            $("#chkt_all").prop("checked", false);
            $("#chkt_team").prop("checked", false);
            $("#chkt_utt").prop("checked", false);



        }
        /**********************************************************************
         * 사고위치 선택 이벤트 --- 종료
        **********************************************************************/

        /**********************************************************************
         * 사고종류 선택 이벤트 --- 시작
        **********************************************************************/

        function rdoAccident_Changed(id) {

            var sWin = document.getElementById("trAccident");
            var theadObj = sWin.querySelectorAll("span");

            UP_Set_RadioCheckValue(theadObj, id);

            UP_Set_Message();
        }

        /**********************************************************************
         * 사고종류 선택 이벤트 --- 종료
        **********************************************************************/       


       /**********************************************************************
        * 조직도 가져오기 --- 시작
       **********************************************************************/
        function UP_OrgTreeDataBing(gubn) {
                      

            wtOrg.Clear("wtOrg");

            wtOrg.AllSelectCancelItem();

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["SAUPBCODE1"] = "ALL";
            ht["SAUPBCODE2"] = "ALL";
            ht["DEPTCODE1"] = "ALL";
            ht["DEPTCODE2"] = "ALL";

            ht["SAUPBCODE3"] = "ALL";
            ht["SAUPBCODE4"] = "ALL";
            ht["DEPTCODE3"] = "ALL";
            ht["DEPTCODE4"] = "ALL";
            if (gubn == "Load") {
                ht["ADDGROUP"] = "";
            }
            else {
                ht["ADDGROUP"] = _GroupCode;
            }            

            wtOrg.Params(ht); // 선언한 파라미터를 그리드에 전달함
            wtOrg.BindTree('wtOrg'); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
            
        }

        function wtOrg_Loaded() {
            
            //wtOrg.AllChildClose(); /* 해당 컨트롤의 모든 Node 하위 닫기 */

            //wtOrg.CheckBox = true;

            //return false;

            wtOrg.Sort = function () { }

            // 최종 노드의 체크박스를 제외한 체크박스를 모두 숨기기 예제
            $("#wtOrg input[type=checkbox]").hide();

            // 구조 문제로 인하여 
            var treeNode = $("#wtOrg").find("#undefined_Items");

            // 하위 노드 검색
            $(treeNode).children("div").each(function () {

                FindLastNode(this);
            });
        }

        // 노드에서 마지막 노드일시 체크박스 활성화
        function FindLastNode(node) {
            // 트리 구조는 이름 및 하위구조이므로 하위구조에 값이 없을시에만 체크박스 보여줌
            //alert($(node).find(">div").eq(1).attr("id"));          

            if ($(node).children("div").eq(1).children("div").length > 0) {

                $(node).children("div").eq(1).children("div").each(function () {
                    FindLastNode(this); // 재귀
                });

            }
            else {

                var id = $(node).children("div").eq(0).attr("id").substr(0, 1);

                //사번이 있는경우만 체크박스 처리한다.
                if (id == '0') {

                    $(node).children("div").eq(0).find("input[type=checkbox]").show();
                    //$(node).children("div").eq(0).find("input[type=checkbox]").prop("checked", true);

                    var val = $(node).children("div").eq(0).attr("id");
                    var result_node = wtOrg.FindItem(val); // 선택할 Node의 IDX값
                    // 해당 컨트롤의 Node 체크
                    result_node.SelNode.checked = true; //선택한 Node 체크
                    node.TreeView.SelectItem(result_node); //선택한 Node 선택

                   
                }              

                
            }
        }

        function FintChildNode(node) {

        }


        /**********************************************************************
         * 조직도 가져오기 --- 종료
        **********************************************************************/


        /**********************************************************************
         * 문자 byte  --- 시작
        **********************************************************************/
        function displayBytes() {

            var obj = txtMSG.GetValue();

            if (bytes(obj) > 60) {
                alert("60byte를 초과하였습니다.");
                txtMSG.SetValue(txtMSG.GetValue().toString().substring(0, bytelength(obj)));
            }                     

            txtSmsbyte.SetValue(bytes(obj) + " / 60 bytes");
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

        /**********************************************************************
        * 문자 발송 버튼 이벤트 --- 시작
        **********************************************************************/ 
        function btnSMSSend_Click() {

            var id;
            var iChk;

            iChk = 0;            

            //사고위치
            if (Rdo_S.GetValue() == "S") {
                

                for (var i = 1; i < 9; i++) {

                    id = 'RdoS' + i;                   

                    if ($("input:radio[name=" + id + "]:radio[value=" + id + "]").prop('checked') == true) {
                        iChk = iChk + 1;
                    }
                }
            }
            else {

                for (var i = 1; i < 7; i++) {

                    id = 'RdoT' + i;

                    if ($("input:radio[name=" + id + "]:radio[value=" + id + "]").prop('checked') == true) {
                        iChk = iChk + 1;
                    }
                }

            }          

            if (iChk <= 0) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="사고위치를 선택하세요!" Literal="true"></Ctl:Text>');
                return;
            }          


            //사고종류
            iChk = 0;

            for (var i = 1; i < 5; i++) {

                id = 'RdoG' + i;

                if ($("input:radio[name=" + id + "]:radio[value=" + id + "]").prop('checked') == true) {
                    iChk = iChk + 1;
                }
            }

            if (iChk <= 0) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="사고종류를 선택하세요!" Literal="true"></Ctl:Text>');
                return;
            }


            var TreeItems = wtOrg.SelectedItems;  //조직도에서 선택된 사번 가져오기

            if (TreeItems.length <= 0) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="선택된 수신자가 없습니다!" Literal="true"></Ctl:Text>');
                return;
            }

            var obj = txtMSG.GetValue();

            txtSmsbyte.SetValue(bytes(obj) + " / 60 bytes");

            if (bytes(obj) > 60) {
                alert("60byte를 초과하였습니다.");
                return;
            }

            var hts = new Array();           

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG19" Description="전송 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {
                               

                for (var i = 0; i < TreeItems.length; i++) {
                    var ht = new Object();                    

                    ht["LODRECSAB"] = TreeItems[i].Name;
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

        function btnSMSSend_After(e) {

            var DataSet = eval(e);            

            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                var code = DataSet.Tables[0].Rows[0]["CODE"];
                var message = DataSet.Tables[0].Rows[0]["MSG"];                

                alert(message);
            }

            UP_Get_SMSCount();
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

       
        /**********************************************************************
        * 문자 발송 버튼 이벤트 --- 종료
        **********************************************************************/


    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">

     <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT_TITLE_01" runat="server" LangCode="TXT_TITLE_01" Description="<h4>비상통보 시스템</h4>"></Ctl:Text>
        </h4>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->
   <div id="content">      
       <table class="table_01" style="width: 100%; border-bottom:1px; ">
                <colgroup>
                    <col width="15%" />
                    <col width="20%" />
                    <col width="15%" />
                    <col width="25%" />
                    <col width="*" />
                </colgroup>
                <tr style="vertical-align:top;" >
                    <!-- 구 분 -->
                    <td style="padding-right : 5px;">
                        <Ctl:Layer ID="layer_Menu" runat="server" Title="구 분" DefaultHide="False" Collapsible = "False">
                             
                            <table  class="table_01" style="width:100%; border-bottom:1px">
                                <colgroup>
                                    <col width="30%" />
                                    <col width="60%" />
                                </colgroup>
                                <tr >
                                    <td colspan="2" >
                                        <br/>                                        
                                        <Ctl:Radio ID="Rdo_S"  runat="server" RepeatColumns="1" OnChanged="rdoS_Changed();" >
                                            <asp:ListItem  Value="S" Text="SILO" Selected="true"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>   
                                        <br/>                                        
                                        <br/>                                        
                                        <Ctl:Radio ID="Rdo_T"  runat="server" RepeatColumns="1" OnChanged="rdoT_Changed();" >
                                            <asp:ListItem  Value="T" Text="UTT" Selected="false"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>   
                                    </td>                                    
                                </tr>
                            </table>
                        </Ctl:Layer>
                    </td>

                    <!-- 사고위치 -->
                    <td style="padding-right : 5px;">
                        <Ctl:Layer ID="layer_Program" runat="server" Title="사고위치" DefaultHide="False" Collapsible = "False">
                             
                            <table class="table_01" style="width: 100%;border-bottom:1px">
                                <colgroup>
                                    <col width="30%" />
                                    <col width="60%" />
                                </colgroup>                               
                                <tr id="trLocation_S">
                                    <td colspan="2" >
                                        <br/>
                                        <Ctl:Radio ID="RdoS1" runat="server" RepeatColumns="2"   OnChanged="rdoLocationS_Changed(RdoS1);" >
                                            <asp:ListItem  Value="RdoS1" Text="본 관">                                                
                                            </asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                        <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoS2" runat="server" RepeatColumns="2"  OnChanged="rdoLocationS_Changed(RdoS2);" >
                                            <asp:ListItem Value="RdoS2" Text="부원료창고"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                        <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoS3" runat="server" RepeatColumns="2" OnChanged="rdoLocationS_Changed(RdoS3);" >
                                            <asp:ListItem Value="RdoS3" Text="ABC그룹"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                        <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoS4" runat="server" RepeatColumns="2" OnChanged="rdoLocationS_Changed(RdoS4);" >
                                            <asp:ListItem Value="RdoS4" Text="D그룹"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                        <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoS5" runat="server" RepeatColumns="2" OnChanged="rdoLocationS_Changed(RdoS5);" >
                                            <asp:ListItem Value="RdoS5" Text="잔교(하역기)"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                        <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoS6" runat="server" RepeatColumns="2" OnChanged="rdoLocationS_Changed(RdoS6);" >
                                            <asp:ListItem Value="RdoS6" Text="정비실"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                        <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoS7" runat="server" RepeatColumns="2" OnChanged="rdoLocationS_Changed(RdoS7);" >
                                            <asp:ListItem Value="RdoS7" Text="계근실"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                        <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoS8" runat="server" RepeatColumns="2" OnChanged="rdoLocationS_Changed(RdoS8);" >
                                            <asp:ListItem Value="RdoS8" Text="상 옥"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                        <br/>
                                        <br/>
                                       
                                    </td>
                                </tr> 
                                <tr id="trLocation_T" >
                                     <td colspan="2" >                                       
                                       <br/>
                                       <Ctl:Radio ID="RdoT1" runat="server" RepeatColumns="2" OnChanged="rdoLocationT_Changed(RdoT1);" >
                                            <asp:ListItem Value="RdoT1" Text="본 관"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                        <br/>
                                        <br/>                                       
                                        <Ctl:Radio ID="RdoT2" runat="server" RepeatColumns="2" OnChanged="rdoLocationT_Changed(RdoT2);" >
                                            <asp:ListItem Value="RdoT2" Text="하단지"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                         <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoT3" runat="server" RepeatColumns="2" OnChanged="rdoLocationT_Changed(RdoT3);" >
                                            <asp:ListItem Value="RdoT3" Text="부두"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                         <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoT4" runat="server" RepeatColumns="2" OnChanged="rdoLocationT_Changed(RdoT4);" >
                                            <asp:ListItem Value="RdoT4" Text="해안단지"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                         <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoT5" runat="server" RepeatColumns="2" OnChanged="rdoLocationT_Changed(RdoT5);" >
                                            <asp:ListItem Value="RdoT5" Text="상단지"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                         <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoT6" runat="server" RepeatColumns="2" OnChanged="rdoLocationT_Changed(RdoT6);" >
                                            <asp:ListItem Value="RdoT6" Text="송유단지"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                      </td>  
                                </tr>
                            </table>
                        </Ctl:Layer>
                    </td>

                    <!-- 사고종류 -->
                    <td style="padding-right : 5px;">
                        <Ctl:Layer ID="layer1" runat="server" Title="사고종류" DefaultHide="False" Collapsible = "False">
                             
                            <table class="table_01" style="width: 100%;border-bottom:1px">
                                <colgroup>
                                    <col width="30%" />
                                    <col width="60%" />
                                </colgroup>
                                <tr id="trAccident" style="vertical-align:top;" >
                                    <td colspan = "2" >
                                        <br/>
                                        <Ctl:Radio ID="RdoG1" runat="server" RepeatColumns="2" OnChanged="rdoAccident_Changed(RdoG1);">
                                            <asp:ListItem Value="RdoG1" Text="화재"></asp:ListItem>                                              
                                        </Ctl:Radio>
                                         <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoG2" runat="server" RepeatColumns="2" OnChanged="rdoAccident_Changed(RdoG2);">
                                            <asp:ListItem Value="RdoG2" Text="폭발"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                         <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoG3" runat="server" RepeatColumns="2" OnChanged="rdoAccident_Changed(RdoG3);">
                                            <asp:ListItem Value="RdoG3" Text="누출"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                         <br/>
                                        <br/>
                                        <Ctl:Radio ID="RdoG4" runat="server" RepeatColumns="2" OnChanged="rdoAccident_Changed(RdoG4);">
                                            <asp:ListItem Value="RdoG4" Text="안전사고"></asp:ListItem>                                                                                        
                                        </Ctl:Radio>
                                    </td>
                                </tr>
                               
                            </table>
                        </Ctl:Layer>
                    </td>

                    <!-- 수신자 -->
                    <td style="padding-right : 5px;">
                        <Ctl:Layer ID="layer2" runat="server" Title="수신자" DefaultHide="False" Collapsible = "False">
                             
                            <table class="table_01" style="width: 100%;border-bottom:1px">
                                <colgroup>                                    
                                    <col width="30%" />
                                    <col width="60%" />
                                </colgroup>
                               
                                <tr id="trRecive_S" >
                                    <td colspan = "2" >
                                        <div id="chkbox_silo"   >                                               
                                                <div style="font-size:20px;">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="checkbox" id="chks_all" style="width:18px; height:60px; " />
                                                        전 체                                                    
                                                </div>                                                
                                                <div style="font-size:20px;">
                                                    1차:&nbsp;&nbsp;
                                                    <input type="checkbox" id="chks_team" style="width:18px; height:60px; " /> 팀장, 안전환경팀
                                                </div>
                                                  
                                                <div style="font-size:20px;">
                                                    2차:&nbsp;&nbsp;
                                                    <input type="checkbox" id="chks_silo" style="width:18px; height:60px; " /> SILO
                                                </div>
                                                <div style="font-size:20px;">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <input type="checkbox" id="chks_manage" style="width:18px;height:60px; " /> 관리팀
                                                </div>                                                   
                                        </div>
                                    </td>
                                </tr>
                                <tr id="trRecive_T" >
                                    <td colspan = "2" >
                                        <div id="chkbox_utt" >
                                               
                                                        <div style="font-size:20px;">
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <input type="checkbox" id="chkt_all" style="width:18px; height:60px; " /> 전 체
                                                        </div>

                                                 
                                                        <div style="font-size:20px;">
                                                             1차:&nbsp;&nbsp;
                                                            <input type="checkbox" id="chkt_team" style="width:18px; height:60px; " /> 팀장, 안전환경팀
                                                        </div>
                                                
                                                        <div style="font-size:20px;">
                                                            2차:&nbsp;&nbsp;
                                                            <input type="checkbox" id="chkt_utt" style="width:18px; height:60px; " /> UTT
                                                        </div>
                                                  
                                        </div>
                                        
                                    </td>
                                </tr>
                                             
                            </table>
                        </Ctl:Layer>
                    </td>

                    <!-- 문자전송 -->
                    <td style="padding-right : 5px;">
                        <Ctl:Layer ID="layer3" runat="server" Title="문자전송" DefaultHide="False" Collapsible = "False">
                             
                            <table class="table_01" style="width: 100%;border-bottom:1px">
                                <colgroup>
                                    <col width="30%" />
                                    <col width="60%" />
                                </colgroup>
                                <tr style="vertical-align:top;" >
                                    <td colspan = "2" style = "height:150px;">
                                        <Ctl:TextBox ID="txtMSG" runat="server"  Height="150"
                                            PlaceHolder ="빈칸" ReadMode="false" ReadOnly="false" SetType="text"
                                            Style ="font-size:18px;" Text="" TextMode="MultiLine" Validation="false" Width="100%">
                                         </Ctl:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="Text19" runat="server" LangCode="TXT_txtPRM_PROGRAMID" Description="SMS" /></th>
                                    <td>
                                        <Ctl:Text ID="txtSmsbyte" runat="server" LangCode="TXT_Smsbyte" Description="20 / 60 Bytes" Required="true"></Ctl:Text>
                                    </td>
                                </tr>
                                <tr>
                                    <th><Ctl:Text ID="Text1" runat="server" LangCode="TXT_txtPRM_PROGRAMID" Description="발송가능건수" /></th>
                                    <td>
                                        <Ctl:Text ID="txtSMSCNT" runat="server" LangCode="TXT_txtSMSCNT" Description="1002 건" Required="true"></Ctl:Text>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan = "2"> 
                                         <Ctl:Button ID="btnSMSSEND" runat="server"   Description="문자전송" Height="30px" Width="93%" Hidden="false" LangCode="TXT01" OnClientClick="btnSMSSend_Click(); return false;">
                                         </Ctl:Button>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan = "2"><Ctl:Text ID="Text6" runat="server" LangCode="Text6" Description="수신자 리스트" /></th>
                                </tr>
                                <tr>                                    
                                    <td colspan = "2" style = "height:450px;" > 
                                     <Ctl:WebTree ID="wtOrg" runat="server" CheckBox="true" Description="조직도" HideTitle="true" IndexBindFiledName="CNODE" EnableSearchBox="false"
                                                     MethodName="UP_SMS_OrgTreeEmergency_LIST" ParentBindFieldName="PNODE"  TextBindFieldName="TEXT" TypeName="SMS.SMSBiz" Width = "100%" Height="200"  OnLoaded="wtOrg_Loaded" />
                                    </td> 
                                </tr>
                            </table>
                        </Ctl:Layer>
                    </td>
                
                </tr>
        </table>

    </div>
</asp:content>