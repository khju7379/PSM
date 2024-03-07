<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMS1032.aspx.cs" Inherits="TaeYoung.Portal.SMS.SMS10.SMS1032" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    
        <style>                   

        #wtOrg
        {           
          overflow-y:auto;
        }
               
        </style>
   

    <script type="text/javascript">

        var GWCODE = "";
       
        function OnLoad() {

            GWCODE = "<%= Request.QueryString["GWCODE"] %>";           

            UP_OrgTreeDataBing();

            UP_GridDataBing();
        }      

        function UP_GridDataBing() {            

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["ADDGROUP"] = GWCODE;
            
            gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        function UP_OrgTreeDataBing() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["SAUPBCODE1"] = "ALL";
            ht["SAUPBCODE2"] = "ALL";
            ht["DEPTCODE1"] = "ALL";
            ht["DEPTCODE2"] = "ALL";
            ht["SAUPBCODE3"] = "ALL";
            ht["SAUPBCODE4"] = "ALL";
            ht["DEPTCODE3"] = "ALL";
            ht["DEPTCODE4"] = "ALL";

            wtOrg.Params(ht); // 선언한 파라미터를 그리드에 전달함
            wtOrg.BindTree('wtOrg'); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩            
        }

        function wtOrg_Loaded() {

            wtOrg.Sort = function () { }
            wtOrg.AllChildClose(); /* 해당 컨트롤의 모든 Node 하위 닫기 */
            return false;
        }

        function btnTreeAllClose_Click() {
            wtOrg.AllChildClose(); /* 해당 컨트롤의 모든 Node 하위 닫기 */
            return false;
        }

        function wtOrg_click(o, s) {

            if (wtOrg.SelectedItems[0].Values[6] != '') {
                
                /* o : 마우스 이벤트, s : 선택 Node 정보 */
                var rows = gridDetail.GetAllRow().Rows;
                var index = ObjectCount(rows);                

                for (var i = 0; i < ObjectCount(rows); i++) {
                    if (rows[i]["ADDSABUN"] == wtOrg.SelectedItems[0].Values[1]) {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="동일한 사번이 존재합니다." Literal="true"></Ctl:Text>');
                        return false;
                    }
                }
            
                gridDetail.InsertRow();
            
                gridDetail.SetValue(index, "ADDGROUP", GWCODE);
                gridDetail.SetValue(index, "ADDSABUN", wtOrg.SelectedItems[0].Values[1]);
                gridDetail.SetValue(index, "KBBSTEAM", wtOrg.SelectedItems[0].Values[4]);
                gridDetail.SetValue(index, "KBBSTEAMNM", wtOrg.SelectedItems[0].Values[12]);
                gridDetail.SetValue(index, "ADDNAME", wtOrg.SelectedItems[0].Values[7]);

                
                var grd_chk = document.getElementsByName("gridDetail_chk");
                grd_chk[index].checked = true;
            }
            

        }

        function btnSave_Click() {
            
            var hts = new Array();

            var checkRows = gridDetail.GetCheckRow();

            if (checkRows.length > 0) {

                if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    for (i = 0; i < checkRows.length; i++) {
                        var ht = new Object();

                        ht["ADDGROUP"] = checkRows[i]['ADDGROUP'];
                        ht["ADDSABUN"] = checkRows[i]['ADDSABUN'];
                        ht["ADMHISAB"] = "0287-M";                        

                        hts.push(ht);
                    }

                    PageMethods.InvokeServiceTableArray(ht, hts, "SMS.SMSBiz", "UP_SMS_SMSManager_ADDETAIL_ArrayADD", btnSave_After);                                      
                }
            }
            else {
                alert("저장할 자료가 없습니다!");
            }
        }

        function btnSave_After(e) {
            alert('<Ctl:Text ID="MSG07" runat="server" LangCode="MSG001" Description="저장 완료 되었습니다." Literal="true" />');
            if (opener != null && typeof (opener.gridDetail_Binding(GWCODE)) == "function") {
                opener.gridDetail_Binding(GWCODE);
            }
            self.close();
        }

        function btnDel_Click() {

            var hts = new Array();

            var checkRows = gridDetail.GetCheckRow();

            if (checkRows.length > 0) {

                if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG19" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    for (i = 0; i < checkRows.length; i++) {
                        var ht = new Object();

                        ht["ADDGROUP"] = checkRows[i]['ADDGROUP'];
                        ht["ADDSABUN"] = checkRows[i]['ADDSABUN'];                        

                        hts.push(ht);
                    }

                    PageMethods.InvokeServiceTableArray(ht, hts, "SMS.SMSBiz", "UP_SMS_SMSManager_ADDETAIL_ArrayDEL", btnDel_After);
                }
            }
            else {
                alert("삭제할 자료가 없습니다!");
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
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="주소록 추가 등록" Literal="true"></Ctl:Text>
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
		
         <table class="table_01" style="width: 100%;border-bottom:1px">
                <colgroup>
                    <col width="30%" />
                    <col width="70%" />                    
                </colgroup>
                <tr style="vertical-align:top;" >

                    <!-- 조직도-->
                    <td style="padding-right : 5px;">
                        <Ctl:Layer ID="layer_Menu" runat="server" Title="" DefaultHide="False" Collapsible = "False">
                            <ul class="search" style="border-bottom:0px;">
                                <li style="float:right;">
                                    <Ctl:Button ID="btnTreeAllClose" runat="server" LangCode="btnTreeAllClose" Description="접기" OnClientClick="btnTreeAllClose_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                </li>
                            </ul>
                            <table class="table_01" style="width: 100%; border-bottom:1px">
                                 <tr>
                                    <th><Ctl:Text ID="Text6" runat="server" LangCode="Text6" Description= "조직도" /></th>
                                </tr>
                                <tr style="vertical-align:top;" >
                                    <td style = "height:370px;">                                        

                                        <Ctl:WebTree ID="wtOrg" runat="server" CheckBox="false" Description="조직도" HideTitle="true" IndexBindFiledName="CNODE" EnableSearchBox="false"
                                                     MethodName="UP_SMS_OrgTree_LIST" ParentBindFieldName="PNODE"  TextBindFieldName="TEXT" TypeName="SMS.SMSBiz" Width = "100%" Height="200" 
                                                     OnClick="wtOrg_click" OnLoaded="wtOrg_Loaded" />
                                    </td>
                                </tr>                                                                
                            </table>
                        </Ctl:Layer>
                    </td>

                    <!-- 주소록 등록 관리 -->
                    <td style="padding-right : 5px;">
                        <Ctl:Layer ID="layer1" runat="server" Title="주소록" DefaultHide="False" Collapsible = "False">
                             
                            <Ctl:WebSheet ID="gridDetail" runat="server"  Paging="false"  HFixation="true"   Width="100%" Height="350" CheckBox="true"  TypeName="SMS.SMSBiz" MethodName="UP_SMS_SMSManager_ADDETAIL_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                                <Ctl:SheetField DataField="ADDGROUP"    TextField="ADDGROUP"  Hidden="true"   Description="그룹" Width="85" HAlign="center" Align="left"    runat="server" />
                                <Ctl:SheetField DataField="KBBSTEAM"    AutoMerge="true" TextField="KBBSTEAM"    Description="부서코드" Width="85" HAlign="center" Align="left"   runat="server" />
                                <Ctl:SheetField DataField="KBBSTEAMNM"  AutoMerge="true" TextField="KBBSTEAMNM"    Description="부서명" Width="85" HAlign="center" Align="left"   runat="server" />
                                <Ctl:SheetField DataField="ADDSABUN"    TextField="ADDSABUN"    Description="사번" Width="85" HAlign="center" Align="left"   runat="server" />
                                <Ctl:SheetField DataField="ADDNAME"     TextField="ADDNAME"     Description="이름" Width="100"  HAlign="center" Align="left"  runat="server" />                            

                            </Ctl:WebSheet>  
                        </Ctl:Layer>
                    </td>                  
                
                </tr>

        </table>

        
	</div>

</asp:content>