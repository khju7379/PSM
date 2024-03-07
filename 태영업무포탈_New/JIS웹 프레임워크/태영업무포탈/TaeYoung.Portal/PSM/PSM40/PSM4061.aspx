<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4061.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4061" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    
    
    <script type="text/javascript">        

        var _obj;

        // 페이지 로드
        function OnLoad() {

            var data = "<%= Request.QueryString["param"] %>";            

            var today = new Date();
            txtOSDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
                     

            if (data) {
                UP_Set_DataBind(data);
            }
            else {
                txtOSSEQ.SetValue("자동생성");
            }
        
        }

        function UP_Set_DataBind(data) {


            var ArrayCode = data.split('-');

            var ht = new Object();
            ht["P_OSDATE"] = ArrayCode[0];
            ht["P_OSSEQ"] = ArrayCode[1];  

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4061", "UP_PSM_OUTSIDECONSTRUCT_RUN", DataBind_After);

        }

        function DataBind_After(e) {

            try {
                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {                                        

                    txtOSDATE.SetValue(DataSet.Tables[0].Rows[0]["OSDATE"]);
                    txtOSSEQ.SetValue(DataSet.Tables[0].Rows[0]["OSSEQ"]);
                    txtOSLOCATIONCODE1.SetValue(DataSet.Tables[0].Rows[0]["OSLOCATIONCODE1"]);
                    txtOSLOCATIONCODE1NM.SetValue(DataSet.Tables[0].Rows[0]["OSLOCATIONCODE1NM"]);
                    txtOSAREACODE1.SetValue(DataSet.Tables[0].Rows[0]["OSAREACODE1"]);
                    txtOSAREACODE1NM.SetValue(DataSet.Tables[0].Rows[0]["OSAREACODE1NM"]);
                    txtOSLOCATIONCODE2.SetValue(DataSet.Tables[0].Rows[0]["OSLOCATIONCODE2"]);
                    txtOSLOCATIONCODE2NM.SetValue(DataSet.Tables[0].Rows[0]["OSLOCATIONCODE2NM"]);
                    txtOSAREACODE2.SetValue(DataSet.Tables[0].Rows[0]["OSAREACODE2"]);
                    txtOSAREACODE2NM.SetValue(DataSet.Tables[0].Rows[0]["OSAREACODE2NM"]);
                    txtOSLOCATIONCODE3.SetValue(DataSet.Tables[0].Rows[0]["OSLOCATIONCODE3"]);
                    txtOSLOCATIONCODE3NM.SetValue(DataSet.Tables[0].Rows[0]["OSLOCATIONCODE3NM"]);
                    txtOSAREACODE3.SetValue(DataSet.Tables[0].Rows[0]["OSAREACODE3"]);
                    txtOSAREACODE3NM.SetValue(DataSet.Tables[0].Rows[0]["OSAREACODE3NM"]);
                    txtOSLOCATIONCODE4.SetValue(DataSet.Tables[0].Rows[0]["OSLOCATIONCODE4"]);
                    txtOSLOCATIONCODE4NM.SetValue(DataSet.Tables[0].Rows[0]["OSLOCATIONCODE4NM"]);
                    txtOSAREACODE4.SetValue(DataSet.Tables[0].Rows[0]["OSAREACODE4"]);
                    txtOSAREACODE4NM.SetValue(DataSet.Tables[0].Rows[0]["OSAREACODE4NM"]);
                    txtOSLOCATIONCODE5.SetValue(DataSet.Tables[0].Rows[0]["OSLOCATIONCODE5"]);
                    txtOSLOCATIONCODE5NM.SetValue(DataSet.Tables[0].Rows[0]["OSLOCATIONCODE5NM"]);
                    txtOSAREACODE5.SetValue(DataSet.Tables[0].Rows[0]["OSAREACODE5"]);
                    txtOSAREACODE5NM.SetValue(DataSet.Tables[0].Rows[0]["OSAREACODE5NM"]);
                    txtOSMETHODCODE.SetValue(DataSet.Tables[0].Rows[0]["OSMETHODCODE"]);
                    txtOSCOMPANY.SetValue(DataSet.Tables[0].Rows[0]["OSCOMPANY"]);
                    $("#svOSBUSEO_BUSEO").val(DataSet.Tables[0].Rows[0]["OSBUSEO"]);
                    $("#svOSBUSEO_BUSEONM").val(DataSet.Tables[0].Rows[0]["OSBUSEONM"]);
                    $("#svOSSABUN_KBSABUN").val(DataSet.Tables[0].Rows[0]["OSSABUN"]);
                    $("#svOSSABUN_KBHANGL").val(DataSet.Tables[0].Rows[0]["OSSABUNNM"]);

                    txtOSWKSDATE.SetValue(DataSet.Tables[0].Rows[0]["OSWKSDATE"]);
                    txtOSWKEDATE.SetValue(DataSet.Tables[0].Rows[0]["OSWKEDATE"]);

                    txtOSWKCLDATE.SetValue(DataSet.Tables[0].Rows[0]["OSWKCLDATE"]);

                    $("#txtOSDATE").attr("onclick", "");
                    $("#txtOSDATE").attr("style","width:80px; background-color:LightGray");

                    if (DataSet.Tables[0].Rows[0]["OSWKCLOSE"] == "Y") {
                        $('input:checkbox[name="chkOSWKCLOSE"]').attr("checked", true);
                    }
                           var ht = new Object();

                           ht["P_OSWKDATE"] = DataSet.Tables[0].Rows[0]["OSDATE"];
                           ht["P_OSWKSEQ"] = DataSet.Tables[0].Rows[0]["OSSEQ"];

                           //외주공사 작업내용 Checkbox 표시
                           PageMethods.InvokeServiceTable(ht, "PSM.PSM4061", "UP_PSM_OUTSIDECONSTRUCT_WKCODE_RUN", function (e) {

                            var ds = eval(e);

                               if (ObjectCount(ds.Tables[0].Rows) > 0) {

                                   for (var i = 0; i < ObjectCount(ds.Tables[0].Rows); i++) {

                                               var code = ds.Tables[0].Rows[i]["OSWKCODE"];

                                               switch (code) {
                                                   case "01":                                       
                                                       $('input:checkbox[name="chkOSWKCODE1"]').attr("checked", true);
                                                       break;
                                                   case "02":
                                                       $('input:checkbox[name="chkOSWKCODE2"]').attr("checked", true);
                                                       break;
                                                   case "03":
                                                       $('input:checkbox[name="chkOSWKCODE3"]').attr("checked", true);
                                                       break;
                                                   case "04":
                                                       $('input:checkbox[name="chkOSWKCODE4"]').attr("checked", true);
                                                       break;
                                                   case "05":
                                                       $('input:checkbox[name="chkOSWKCODE5"]').attr("checked", true);
                                                       break;
                                                   case "06":
                                                       $('input:checkbox[name="chkOSWKCODE6"]').attr("checked", true);
                                                       break;
                                                   case "07":
                                                       $('input:checkbox[name="chkOSWKCODE7"]').attr("checked", true);
                                                       break;
                                                   case "08":
                                                       $('input:checkbox[name="chkOSWKCODE8"]').attr("checked", true);
                                                       break;
                                                   case "09":
                                                       $('input:checkbox[name="chkOSWKCODE9"]').attr("checked", true);
                                                       break;
                                                   case "10":
                                                       $('input:checkbox[name="chkOSWKCODE10"]').attr("checked", true);
                                                       break;                                      
                                               }
                                   }                              
                              
                           }
                        }, function (e) {
                            // Biz 연결오류
                            alert("Error");
                        });
                   
                }
            }
            catch (err) {
                alert(err.message);
            }
        }


        //설비코드 팝업
        function btnPopUp_Click(obj, gubn) {

            var param = "";
            var SaupCode = "";

            _obj = obj;

            if (gubn != '2') {
                //설비코드
                fn_OpenPop("../POP/PSP1030.aspx" , 1000, 600);
            }
            else {
                //주변지역
                var Sdata = '';
                var Tdata = '';

                for (var i = 1; i < 6; i++) {
                    if ($("#txtOSAREACODE" + i).val().length >= 9) {                        

                        if ($("#txtOSAREACODE" + i).val().substr(0, 1) == "T") {
                            Tdata = Tdata + $("#txtOSAREACODE" + i).val() + "^" + $("#txtOSAREACODE" + i + "NM").val() + "^";                      
                        }
                        else {
                            Sdata = Sdata + $("#txtOSAREACODE" + i).val() + "^" + $("#txtOSAREACODE" + i + "NM").val() + "^";                      
                        }                        
                    }

                   if ($("#txtOSLOCATIONCODE" + i).val().length > 8 ) {

                       SaupCode = $("#txtOSLOCATIONCODE" + i).val().substr(0, 1);                            
                   }
                }

                if (SaupCode == '') {
                   alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="설비코드를 먼저 선택하세요!" Literal="true"></Ctl:Text>');
                   return;
                }

                if (SaupCode != 'S') {
                    fn_OpenPop("../POP/PSP1031.aspx?param="+Tdata , 1650, 800);
                }
                else {
                    fn_OpenPop("../POP/PSP1032.aspx?param="+Sdata , 1650, 700);
                }                
            }
            
        }

        function btnPopup_Callback(ht)
        {
            $("#" + _obj + "").val(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
            $("#"+_obj+"NM").val(ht["C3NAME"]);           
        }

        function btnAreaPopup_Callback(ht)
        {
          
            var index;

            for (var i = 1; i < 6; i++) {
                
                $("#txtOSAREACODE" + i).val("");
                $("#txtOSAREACODE"+i+"NM").val("");
            }        
            
            for (var i = 0; i < ObjectCount(ht.Rows); i++) {
                index = i + 1;
                $("#txtOSAREACODE" + index).val(ht.Rows[i]["AREACODE"]);
                $("#txtOSAREACODE"+index+"NM").val(ht.Rows[i]["AREACODENM"]);                                           
            }        
        }

        //저장 버튼 이벤트
        function btnSave_Click() {
            
            //작업구분 필수 선택
            var iCheck = 0;
            for (i = 1; i < 11; i++) {                              
                if ($("input:checkbox[name=chkOSWKCODE" + i + "]").prop('checked') == true) {
                    iCheck = iCheck + 1;
                }
            }
            if (iCheck <= 0) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업구분 선택하세요." Literal="true"></Ctl:Text>');
                return;
            }

            //설비코드 한개 이상 선택
            iCheck = 0;
            for (var i = 1; i < 6; i++) {                
                if ($("#txtOSLOCATIONCODE" + i).val() != '') {
                    iCheck = iCheck + 1;
                }                
            }        
            if (iCheck <= 0) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드를 선택하세요." Literal="true"></Ctl:Text>');
                return;
            }                       

            var ht = new Object(); 

            ht["P_OSDATE"] = txtOSDATE.GetValue().replace(/-/gi, '');
            if (txtOSSEQ.GetValue() == "자동생성") {
                ht["P_OSSEQ"] = "0";
            }
            else {
                ht["P_OSSEQ"] = txtOSSEQ.GetValue();
            }
            ht["P_OSLOCATIONCODE1"] = txtOSLOCATIONCODE1.GetValue();
            ht["P_OSAREACODE1"] = txtOSAREACODE1.GetValue();
            ht["P_OSLOCATIONCODE2"] = txtOSLOCATIONCODE2.GetValue();
            ht["P_OSAREACODE2"] = txtOSAREACODE2.GetValue();
            ht["P_OSLOCATIONCODE3"] = txtOSLOCATIONCODE3.GetValue();
            ht["P_OSAREACODE3"] = txtOSAREACODE3.GetValue();
            ht["P_OSLOCATIONCODE4"] = txtOSLOCATIONCODE4.GetValue();
            ht["P_OSAREACODE4"] = txtOSAREACODE4.GetValue();
            ht["P_OSLOCATIONCODE5"] = txtOSLOCATIONCODE5.GetValue();
            ht["P_OSAREACODE5"] = txtOSAREACODE5.GetValue();
            ht["P_OSMETHODCODE"] = txtOSMETHODCODE.GetValue();
            ht["P_OSCOMPANY"] = txtOSCOMPANY.GetValue();
            ht["P_OSBUSEO"] = $("#svOSBUSEO_BUSEO").val();
            ht["P_OSSABUN"] = $("#svOSSABUN_KBSABUN").val();
            ht["P_OSWKSDATE"] = txtOSWKSDATE.GetValue().replace(/-/gi, '');
            ht["P_OSWKEDATE"] = txtOSWKEDATE.GetValue().replace(/-/gi, '');          
            if ($("input:checkbox[name=chkOSWKCLOSE]").prop('checked') == true) {
                ht["P_OSWKCLOSE"] = "Y";
            }
            else {
                ht["P_OSWKCLOSE"] = "";
            }
            ht["P_OSWKCLDATE"] = txtOSWKCLDATE.GetValue().replace(/-/gi, '');

            var hts = new Array();           

            for (i = 1; i < 11; i++) {               

                var htcode = new Object();                

                if ($("input:checkbox[name=chkOSWKCODE"+i+"]").prop('checked') == true) {
                    htcode["P_OSWKCODE"] = $("input:checkbox[name=chkOSWKCODE" + i + "]").val();
                    htcode["P_OSWKNAME"] = $("input:checkbox[name=chkOSWKCODE" + i + "]").next().text();

                    hts.push(htcode);
                }                                
            }

            PageMethods.InvokeServiceTableArray(ht, hts, "PSM.PSM4061", "UP_PSM_OUTSIDECONSTRUCT_ADD", function (e) {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                if (opener) {
                    opener.btnSearch_Callback();
                    self.close();
                }
                  
            }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
            
        }

        //삭제 버튼 이벤트
        function btnDel_Click() {

            if (!confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG02" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>')) {
                return false;
            }

            var ht = new Object();

            ht["P_OSDATE"] = txtOSDATE.GetValue().replace(/-/gi, '');
            ht["P_OSSEQ"] = txtOSSEQ.GetValue();            

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4061", "UP_PSM_OUTSIDECONSTRUCT_DEL", function (e) {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제가 완료 되었습니다." Literal="true"></Ctl:Text>');

                if (opener) {
                    opener.btnSearch_Callback();
                    self.close();
                }
                
             }, function (e) {
                    // Biz 연결오류
                 alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
             });
            
        }

        //작업구분 체크박스 선택 이벤트
        function UP_WKCODE_Click(index) {
                        
            if (index == 1) {

                if ($("input:checkbox[name=chkOSWKCODE1]").prop('checked') == true) {

                    for (i = 2; i < 11; i++) {
                        $('input:checkbox[name=chkOSWKCODE' + i + "]").prop("checked", false);
                    }
                }
            }
            else {
                $("input:checkbox[name=chkOSWKCODE1]").prop('checked', false);
            }

        } 

        //작업완료
        function UP_WKCLOSE_Click() {

            if ($("input:checkbox[name=chkOSWKCLOSE]").prop('checked') == true) {
                var today = new Date();
                txtOSWKCLDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            }
            else {
                txtOSWKCLDATE.SetValue("");
            }

        }

        //닫기 버튼 이벤트
        function btnClose_Click() {

            this.close();            
        }
       
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

      <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="외주공사관리" Literal="true"></Ctl:Text>
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
                    <col style="width:10%;" />
                    <col style="width:35%;" />
                    <col style="width:10%;" />
                    <col style="width:*" />
                </colgroup>
            <tr>
                <th><Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="등록일자" Required = "true"></Ctl:Text></th>
                <td colspan="3">
                     
                     <Ctl:TextBox ID="txtOSDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ></Ctl:TextBox>
                     <Ctl:TextBox ID="txtOSSEQ"  ReadOnly="true" style="background-color:LightGray; Text-Align:center" Width="50px" runat="server"></Ctl:TextBox>
                </td>
            </tr>
            <tr>
                <th><Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="작업구분" Required = "true"></Ctl:Text></th>
                <td colspan="3">
                     <Ctl:CheckBox ID="chkOSWKCODE1" runat="server" ReadMode="false" DataMember="chkBox1_1" onclick="UP_WKCODE_Click(1)" >
                         <asp:ListItem Text="일반위험작업" Value="01" ></asp:ListItem>
                     </Ctl:CheckBox>
                     <Ctl:CheckBox ID="chkOSWKCODE2" runat="server" ReadMode="false" DataMember="chkBox1_1" onclick="UP_WKCODE_Click(2)" >
                         <asp:ListItem Text="밀폐공간출입작업" Value="02" ></asp:ListItem>
                     </Ctl:CheckBox>
                     <Ctl:CheckBox ID="chkOSWKCODE3" runat="server" ReadMode="false" DataMember="chkBox1_1" onclick="UP_WKCODE_Click(3)" >
                         <asp:ListItem Text="전기작업" Value="03" ></asp:ListItem>
                     </Ctl:CheckBox>
                     <Ctl:CheckBox ID="chkOSWKCODE4" runat="server" ReadMode="false" DataMember="chkBox1_1" onclick="UP_WKCODE_Click(4)" >
                         <asp:ListItem Text="열간작업" Value="04" ></asp:ListItem>
                     </Ctl:CheckBox>
                     <Ctl:CheckBox ID="chkOSWKCODE5" runat="server" ReadMode="false" DataMember="chkBox1_1" onclick="UP_WKCODE_Click(5)" >
                         <asp:ListItem Text="Tank Cleaning" Value="05" ></asp:ListItem>
                     </Ctl:CheckBox>
                     <Ctl:CheckBox ID="chkOSWKCODE6" runat="server" ReadMode="false" DataMember="chkBox1_1" onclick="UP_WKCODE_Click(6)" >
                         <asp:ListItem Text="Bin Cleaning" Value="06" ></asp:ListItem>
                     </Ctl:CheckBox>
                     <Ctl:CheckBox ID="chkOSWKCODE7" runat="server" ReadMode="false" DataMember="chkBox1_1" onclick="UP_WKCODE_Click(7)" >
                         <asp:ListItem Text="굴착작업" Value="07" ></asp:ListItem>
                     </Ctl:CheckBox>
                     <Ctl:CheckBox ID="chkOSWKCODE8" runat="server" ReadMode="false" DataMember="chkBox1_1" onclick="UP_WKCODE_Click(8)" >
                         <asp:ListItem Text="고소작업" Value="08" ></asp:ListItem>
                     </Ctl:CheckBox>
                     <Ctl:CheckBox ID="chkOSWKCODE9" runat="server" ReadMode="false" DataMember="chkBox1_1" onclick="UP_WKCODE_Click(9)" >
                         <asp:ListItem Text="인양작업" Value="09" ></asp:ListItem>
                     </Ctl:CheckBox>
                     <Ctl:CheckBox ID="chkOSWKCODE10" runat="server" ReadMode="false" DataMember="chkBox1_1" onclick="UP_WKCODE_Click(10)" >
                         <asp:ListItem Text="방사선작업" Value="10" ></asp:ListItem>
                     </Ctl:CheckBox>
                </td>
            </tr>
             <tr>
                <th><Ctl:Text ID="TXT10" runat="server" LangCode="TXT10" Description="설비코드1" ></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtOSLOCATIONCODE1" readonly="false" Width="80" runat="server"></Ctl:TextBox>      
                    <img src="/Resources/Images/btn_search.gif" ID="btnCODE1" alt="설비코드" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('txtOSLOCATIONCODE1','1');"  />               
                    <Ctl:TextBox ID="txtOSLOCATIONCODE1NM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
                <th><Ctl:Text ID="Text1" runat="server" LangCode="TXT10" Description="작업구역1" ></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtOSAREACODE1" readonly="false" Width="80" runat="server"></Ctl:TextBox>      
                    <img src="/Resources/Images/btn_search.gif" ID="btnAREACODE1" alt="작업구역" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('txtOSLOCATIONCODE2','2');"  />               
                    <Ctl:TextBox ID="txtOSAREACODE1NM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
            </tr>   
            <tr>
                <th><Ctl:Text ID="Text2" runat="server" LangCode="TXT10" Description="설비코드2" ></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtOSLOCATIONCODE2" readonly="false" Width="80" runat="server"></Ctl:TextBox>      
                    <img src="/Resources/Images/btn_search.gif" ID="btnCODE2" alt="설비코드" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('txtOSLOCATIONCODE2','1');"  />               
                    <Ctl:TextBox ID="txtOSLOCATIONCODE2NM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
                <th><Ctl:Text ID="Text3" runat="server" LangCode="TXT10" Description="작업구역2" ></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtOSAREACODE2" readonly="false" Width="80" runat="server"></Ctl:TextBox>      
                    <img src="/Resources/Images/btn_search.gif" ID="btnAREACODE2" alt="작업구역" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('txtOSLOCATIONCODE4','2');"  />               
                    <Ctl:TextBox ID="txtOSAREACODE2NM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
            </tr>      
             <tr>
                <th><Ctl:Text ID="Text4" runat="server" LangCode="TXT10" Description="설비코드3" ></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtOSLOCATIONCODE3" readonly="false" Width="80" runat="server"></Ctl:TextBox>      
                    <img src="/Resources/Images/btn_search.gif" ID="btnCODE3" alt="설비코드" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('txtOSLOCATIONCODE3','1');"  />               
                    <Ctl:TextBox ID="txtOSLOCATIONCODE3NM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
                <th><Ctl:Text ID="Text5" runat="server" LangCode="TXT10" Description="작업구역3" ></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtOSAREACODE3" readonly="false" Width="80" runat="server"></Ctl:TextBox>      
                    <img src="/Resources/Images/btn_search.gif" ID="btnAREACODE3" alt="작업구역" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('JITANKNO','2');"  />               
                    <Ctl:TextBox ID="txtOSAREACODE3NM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
            </tr>      
             <tr>
                <th><Ctl:Text ID="Text6" runat="server" LangCode="TXT10" Description="설비코드4" ></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtOSLOCATIONCODE4" readonly="false" Width="80" runat="server"></Ctl:TextBox>      
                    <img src="/Resources/Images/btn_search.gif" ID="btnCODE4" alt="설비코드" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('txtOSLOCATIONCODE4','1');"  />               
                    <Ctl:TextBox ID="txtOSLOCATIONCODE4NM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
                <th><Ctl:Text ID="Text7" runat="server" LangCode="TXT10" Description="작업구역4" ></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtOSAREACODE4" readonly="false" Width="80" runat="server"></Ctl:TextBox>      
                    <img src="/Resources/Images/btn_search.gif" ID="btnAREACODE4" alt="작업구역" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('JITANKNO','2');"  />               
                    <Ctl:TextBox ID="txtOSAREACODE4NM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
            </tr>    
             <tr>
                <th><Ctl:Text ID="Text8" runat="server" LangCode="TXT10" Description="설비코드5" ></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtOSLOCATIONCODE5" readonly="false" Width="80" runat="server"></Ctl:TextBox>      
                    <img src="/Resources/Images/btn_search.gif" ID="btnCODE5" alt="설비코드" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('txtOSLOCATIONCODE5','1');"  />               
                    <Ctl:TextBox ID="txtOSLOCATIONCODE5NM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
                <th><Ctl:Text ID="Text9" runat="server" LangCode="TXT10" Description="작업구역5" ></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtOSAREACODE5" readonly="false" Width="80" runat="server"></Ctl:TextBox>      
                    <img src="/Resources/Images/btn_search.gif" ID="btnAREACODE5" alt="작업구역" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('JITANKNO','2');"  />               
                    <Ctl:TextBox ID="txtOSAREACODE5NM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
            </tr>  
            <tr>
                <th><Ctl:Text ID="Text10" runat="server" LangCode="TXT07" Description="작업내용" Required = "true" ></Ctl:Text></th>
                <td colspan="3">
                    <Ctl:TextBox ID="txtOSMETHODCODE" readonly="false"   Width="400px" runat="server"></Ctl:TextBox>
                </td>
            </tr>
            <tr>
                <th><Ctl:Text ID="Text11" runat="server" LangCode="TXT07" Description="작업회사" Required = "true" ></Ctl:Text></th>
                <td colspan="3">
                    <Ctl:TextBox ID="txtOSCOMPANY" readonly="false"   Width="200px" runat="server"></Ctl:TextBox>
                </td>
            </tr>
             <tr>
                <th><Ctl:Text ID="Text12" runat="server" LangCode="TXT10" Description="담당부서" ></Ctl:Text></th>
                <td>
                     <Ctl:SearchView ID="svOSBUSEO" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_GETDATA" Params="{'P_DATE':txtOSDATE.GetValue() }" >
                                <Ctl:SearchViewField DataField="BUSEO"   TextField="BUSEO"   Description="부서" Hidden="false" Width="70" TextBox="true"  runat="server" />
                                <Ctl:SearchViewField DataField="BUSEONM" TextField="BUSEONM" Description="부서명" Hidden="false" Width="110" TextBox="true" Default="true" runat="server" />
                     </Ctl:SearchView>
                </td>
                <th><Ctl:Text ID="Text13" runat="server" LangCode="TXT10" Description="담당자" ></Ctl:Text></th>
                <td>
                     <Ctl:SearchView ID="svOSSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" >
                                <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" />
                                <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="110" TextBox="true" Default="true" runat="server" />
                      </Ctl:SearchView>
                </td>
            </tr>  
             <tr>
                <th><Ctl:Text ID="Text14" runat="server" LangCode="TXT10" Description="작업일자" ></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtOSWKSDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ></Ctl:TextBox>
                    ~
                    <Ctl:TextBox ID="txtOSWKEDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ></Ctl:TextBox>
                </td>
                <th><Ctl:Text ID="Text15" runat="server" LangCode="TXT10" Description="완료일자"></Ctl:Text></th>
                <td>
                    <Ctl:CheckBox ID="chkOSWKCLOSE" runat="server" onclick="UP_WKCLOSE_Click()" >
                              <asp:ListItem Text="" Value="chkOSWKCLOSE" LangCode="chk1_1" Description=""></asp:ListItem>                                             
                    </Ctl:CheckBox>                                         
                    <Ctl:TextBox ID="txtOSWKCLDATE" readonly="true" style="background-color:LightGray;" runat ="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ></Ctl:TextBox>
                </td>
            </tr>  

            </table>
		</Ctl:Layer>

        
	</div>
    
</asp:content>
