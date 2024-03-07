<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMS1022.aspx.cs" Inherits="TaeYoung.Portal.SMS.SMS10.SMS1022" %>

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
                        

            UP_OrgTreeDataBing();

            UP_GridDataBing();            
        }

        //SMS1020 수신자리스트 그리드 값 가져오기
        function UP_Get_ParentGridValue(hts) {
                        

            if (hts.length > 0) {               
                
                var rows = gridDetail.GetAllRow().Rows;
                var index = ObjectCount(rows);                

                for (var i = 0; i < hts.length; i++) {
                    gridDetail.InsertRow();
                    gridDetail.SetValue(index, "KBBSTEAM", hts[i]["KBBSTEAM"]);
                    gridDetail.SetValue(index, "KBBSTEAMNM", hts[i]["KBBSTEAMNM"]);
                    gridDetail.SetValue(index, "ADDSABUN", hts[i]["ADDSABUN"]);
                    gridDetail.SetValue(index, "ADDNAME", hts[i]["ADDNAME"]);

                    var grd_chk = document.getElementsByName("gridDetail_chk");
                    grd_chk[index].checked = true;

                    index = index + 1;
                }
            }
        }

        function UP_GridDataBing() {            

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["ADDGROUP"] = '99';
            
            gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridDetail.CallBack = function () {
                opener.UP_ChildFomArray();
            }            
        }

        function UP_OrgTreeDataBing() {

            wtOrg.Clear("wtOrg");

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["SAUPBCODE1"] = "ALL";
            ht["SAUPBCODE2"] = "ALL";
            ht["DEPTCODE1"] = "ALL";
            ht["DEPTCODE2"] = "ALL";

            ht["SAUPBCODE3"] = "ALL";
            ht["SAUPBCODE4"] = "ALL";
            ht["DEPTCODE3"] = "ALL";
            ht["DEPTCODE4"] = "ALL";

            if (cboGubn.GetValue() == "G") {
                wtOrg.MethodName = "UP_SMS_OrgTree_GROUP";
            }
            else {
                wtOrg.MethodName = "UP_SMS_OrgTree_LIST";
            }           

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


            //var treeNode = $("#wtOrg").find("#A10000_Items");

            //var childNode = $(treeNode).children();

            //for (var i = 0; i < childNode.length; i++) {

            //    var Node = childNode[i];

            //    $(Node).find("input[type=checkbox]").prop("checked", true);
            //}            

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
                if (cboGubn.GetValue() == "G") {
                    gridDetail.SetValue(index, "ADDSABUN", wtOrg.SelectedItems[0].Values[1]);
                    gridDetail.SetValue(index, "KBBSTEAM", wtOrg.SelectedItems[0].Values[4]);
                    gridDetail.SetValue(index, "KBBSTEAMNM", wtOrg.SelectedItems[0].Values[7]);
                    gridDetail.SetValue(index, "ADDNAME", wtOrg.SelectedItems[0].Values[6]);
                }
                else {
                    gridDetail.SetValue(index, "ADDSABUN", wtOrg.SelectedItems[0].Values[1]);
                    gridDetail.SetValue(index, "KBBSTEAM", wtOrg.SelectedItems[0].Values[4]);
                    gridDetail.SetValue(index, "KBBSTEAMNM", wtOrg.SelectedItems[0].Values[12]);
                    gridDetail.SetValue(index, "ADDNAME", wtOrg.SelectedItems[0].Values[7]);
                }

                
                var grd_chk = document.getElementsByName("gridDetail_chk");
                grd_chk[index].checked = true;
            }
            

        }

        function btnRun_Click() {
            
            var hts = new Array();

            var checkRows = gridDetail.GetCheckRow();

            if (checkRows.length > 0) {                

                    for (i = 0; i < checkRows.length; i++) {
                        var ht = new Object();

                        ht["KBBSTEAM"] = checkRows[i]['KBBSTEAM'];
                        ht["KBBSTEAMNM"] = checkRows[i]['KBBSTEAMNM'];
                        ht["ADDSABUN"] = checkRows[i]['ADDSABUN'];
                        ht["ADDNAME"] = checkRows[i]['ADDNAME'];

                        hts.push(ht);
                    }
                
                opener.UP_Get_Address(hts);

                self.close();
            }
            else {
                alert("저장할 자료가 없습니다!");
            }
        }

        function cboGubn_Change() {
            
            UP_OrgTreeDataBing();            
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
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="수신자 목록 등록" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
		    <Ctl:Button ID="btnSave" runat="server" Style="Orange" LangCode="btnSave" Description="확인" OnClientClick="btnRun_Click();" ></Ctl:Button>
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
                                <li style="float:left;">
                                    <Ctl:Combo ID="cboGubn" runat="server" RepeatColumns="2" OnChange="cboGubn_Change();">
                                          <asp:ListItem Selected="True" Text="부서별" Value="P" ></asp:ListItem>
                                          <asp:ListItem Text="그룹별" Value="G"></asp:ListItem>
                                    </Ctl:Combo>
                                </li>
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
                             
                            <Ctl:WebSheet ID="gridDetail" runat="server"  Paging="false"  HFixation="true"  Width="100%" Height="350" CheckBox="true"  TypeName="SMS.SMSBiz" MethodName="UP_SMS_SMSManager_ADDETAIL_LIST"  UseColumnSort="true" HeaderHeight="20" CellHeight="30" >                            
                                
                                <Ctl:SheetField DataField="KBBSTEAM"    AutoMerge="true" TextField="KBBSTEAM"   Hidden="true"  Description="부서코드" Width="85" HAlign="center" Align="left"   runat="server" />
                                <Ctl:SheetField DataField="KBBSTEAMNM"  AutoMerge="true" TextField="KBBSTEAMNM"  Hidden="true"   Description="부서명" Width="85" HAlign="center" Align="left"   runat="server" />
                                <Ctl:SheetField DataField="ADDSABUN"    TextField="ADDSABUN"    Description="사번" Width="85" HAlign="center" Align="left"   runat="server" />
                                <Ctl:SheetField DataField="ADDNAME"     TextField="ADDNAME"     Description="이름" Width="100"  HAlign="center" Align="left"  runat="server" />                            

                            </Ctl:WebSheet>  
                        </Ctl:Layer>
                    </td>                  
                
                </tr>

        </table>

        
	</div>

</asp:content>

