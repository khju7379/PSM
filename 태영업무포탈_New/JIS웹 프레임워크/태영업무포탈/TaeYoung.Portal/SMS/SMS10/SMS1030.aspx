<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMS1030.aspx.cs" Inherits="TaeYoung.Portal.SMS.SMS10.SMS1030" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        
        function OnLoad() {
            btnSearch_Click();

            btnTelAdd.Hide();
            btnNew.Hide();
        }

        function btnSearch_Click() {            

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            gridGWList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridGWList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩딩
        }

        function gridBind() {
            var ht = new Object();
            ht["LANGCODE"] = langcd
            ht["GrpType"] = cboGRPTYPE.GetValue();
            ht["GRPNAME"] = txtGRPNAME.GetValue();
            ht["GRPID"] = txtGRPID.GetValue();

            grid1.Params(ht);
            grid1.BindList(1);
        }

        function btnDetailSearch_Click() {

            var rw = gridDetail.GetRow(0);

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 50;
            ht["ADDGROUP"] = rw["ADDGROUP"];
            ht["ADDSABUN"] = "";
            ht["ADDNAME"] = txtKBHANGL.GetValue();

            gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        function btnSave_Click() {
            
            var ht = new Object();
            var hts = new Array();

            var checkRows = gridGWList.GetCheckRow();

            if (checkRows.length > 0) {
                for (i = 0; i < checkRows.length; i++) {

                    ht["ADMGROUP"] = checkRows[i]['MENU_NO'];
                    ht["ADMGRNAME"] = checkRows[i]['MENU_NAME'];
                    ht["ADMHISAB"] = "0287-M";

                    hts.push(ht);
                }                
                if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    PageMethods.InvokeServiceTableArray(ht, hts, "SMS.SMSBiz", "UP_SMS_SMSManager_ADMASTA_ADD", function (e) {
                        alert("저장이 완료되었습니다.");
                    }, function (e) {
                        // Biz 연결오류
                        alert("저장중 오류가 발생되었습니다.");
                    });

                    btnSearch_Click();
                }
            }
            else {
                alert("저장할 자료가 없습니다!");
            }
            
        }

        function btnDel_Click() {

            var ht = new Object();
            var hts = new Array();

            var checkRows = gridGWList.GetCheckRow();

            if (checkRows.length > 0) {
                for (i = 0; i < checkRows.length; i++) {

                    ht["ADMGROUP"] = checkRows[i]['MENU_NO'];

                    hts.push(ht);
                }
                
                if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG21" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true)
                {

                    PageMethods.InvokeServiceTableArray(ht, hts, "SMS.SMSBiz", "UP_SMS_SMSManager_ADMASTA_DEL", function (e) {
                        alert("삭제가 완료되었습니다.");
                    }, function (e) {
                        // Biz 연결오류
                        alert("삭제중 오류가 발생되었습니다.");
                    });

                    btnSearch_Click();
                }
                
            }
            else {
                alert("삭제할 자료가 없습니다!");
            }
        }

        function btnRowAdd_Click() {

            gridGWList.InsertRow();

            // 컬럼에 값추가
            // 신규컬럼 : Row의 갯수-1 -> ObjectCount(gridCodeList.GetAllRow().Rows) - 1
            // 바인딩할 컬럼명 : CDINDEX
            // 입력할 값 : gridIndex그리드에서 선택한 값(SelectedRow) -> gridIndex.GetRow(gridIndex.SelectedRow)["CDCODE"]
            gridGWList.SetValue(ObjectCount(gridGWList.GetAllRow().Rows) - 1, "MENU_NO", "자동부여");            
        }

        function gridClick(r, c) {

            var dr = gridGWList.GetRow(r);

            gridDetail_Binding(dr["MENU_NO"]);
        }

        function gridDetail_Binding(dr) {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 50;
            ht["ADDGROUP"] = dr;
            ht["ADDSABUN"] = "";
            ht["ADDNAME"] = "";

            gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            if (dr == "1") {
                btnTelAdd.Hide();
                btnNew.Show();
            }
            else {
                btnTelAdd.Show();
                btnNew.Hide();
            }
        }

        function gridDetailClick(r, c) {

            var dr = gridDetail.GetRow(r);
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["ADDGROUP"] = dr["ADDGROUP"];
            ht["ADDSABUN"] = dr["ADDSABUN"];

            var NUM = dr["ADDGROUP"] + "^" + dr["ADDSABUN"];

            fn_OpenPopCustom("SMS1031.aspx?GWCODE=" + NUM, 800, 200, NUM);
            
        }

        function btnNew_Click() {

            var rw = gridDetail.GetRow(0);

            var NUM = rw["ADDGROUP"];

            fn_OpenPopCustom("SMS1031.aspx?GWCODE=" + NUM, 800, 200, NUM);
        }

        function btnTelAdd_Click() {

            var rw = gridDetail.GetRow(0);

            var NUM = rw["ADDGROUP"];

            fn_OpenPopCustom("SMS1032.aspx?GWCODE=" + NUM, 800, 530, NUM);
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
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" LangCode="layer1" Title="그룹주소록관리" DefaultHide="False">
                             
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="30%" />
                    <col width="70%" />
                </colgroup>
                <tr style="vertical-align:top;" >
                    <td style="padding-right : 0px;">                    
                           
                        <table class="table_01" style="width: 100%;">    
                                      
                                    <tr style="text-align:left; height:36px;">
                                        
                                        <td style="text-align:right;">                        
                                            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click(); return false;" InGrid= "True" ></Ctl:Button>
			                                <Ctl:Button ID="btnRowAdd" runat="server" LangCode="btnRowAdd" Description="행추가" OnClientClick="btnRowAdd_Click();" InGrid= "True" ></Ctl:Button>                                    
                                            <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                            <Ctl:Button ID="btnDel" runat="server" LangCode="btnDel" Description="삭제" OnClientClick="btnDel_Click();"></Ctl:Button>
                                        </td>
                                    </tr>                 
                          </table>          
                         

                          <Ctl:WebSheet ID="gridGWList" runat="server" Paging="false" CheckBox="true"  Width="100%" TypeName="SMS.SMSBiz" MethodName="UP_SMS_ADMASTA_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                                    <Ctl:SheetField DataField="MENU_NO"  TextField="MENU_NO" Description="그룹코드" Width="60"  HAlign="center" Align="center"  runat="server" OnClick="gridClick" />
                                     <Ctl:SheetField DataField="MENU_NAME" TextField="MENU_NAME" Description="그룹명" Width="150" HAlign="center" Align="left" Edit="true" runat="server" OnClick="gridClick" />                            
                          </Ctl:WebSheet>    
                          
                             
                    
                    </td>
                    <td style="padding-right : 0px;">                                                 
                            
                                <table class="table_01" style="width: 100%;">    
                                    <colgroup>
                                        <col width="100px" />
                                        <col width="100px" />
                                        <col width="*" />
                    
                                    </colgroup>
                                    <tr style="text-align:left;">
                                        <th>
                                            <Ctl:Text ID="txtSearchKBHANGL" runat="server" LangCode="txtSearchKBHANGL" Description="이 름"></Ctl:Text>
                                        </th>
                                        <td>
                                            <Ctl:TextBox ID="txtKBHANGL" runat="server" ></Ctl:TextBox>                                            
                                        </td>                   
                    
                                        <td style="text-align:right;">                        
                                            <Ctl:Button ID="btnDetailSearch" runat="server" LangCode="btnDetailSearch" Description="조회" OnClientClick="btnDetailSearch_Click(); return false;" InGrid= "True" ></Ctl:Button>
			                                <Ctl:Button ID="btnTelAdd" runat="server" LangCode="btnTelAdd" Description="연락처추가" OnClientClick="btnTelAdd_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                            <Ctl:Button ID="btnNew" runat="server" LangCode="btnNew" Description="신규" OnClientClick="btnNew_Click(); return false;" InGrid= "True" ></Ctl:Button>
                                        </td>
                                    </tr>                 
                                </table>          
                         

                           <Ctl:WebSheet ID="gridDetail" runat="server" Paging="true"  HFixation="true"  Width="100%" Height="600" CheckBox="false"  TypeName="SMS.SMSBiz" MethodName="UP_SMS_SMSManager_ADMASTA_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                                                <Ctl:SheetField DataField="ADDGROUP"    TextField="ADDGROUP"  Hidden="true"   Description="그룹" Width="85" HAlign="center" Align="left"    runat="server" />
                                                <Ctl:SheetField DataField="ADDSABUN"    TextField="ADDSABUN"    Description="사번" Width="85" HAlign="center" Align="left"  OnClick="gridDetailClick" runat="server" />
                                                <Ctl:SheetField DataField="ADDNAME"     TextField="ADDNAME"     Description="이름" Width="100"  HAlign="center" Align="left" OnClick="gridDetailClick" runat="server" />                            
                                                <Ctl:SheetField DataField="ADDTEL"   TextField="ADDTEL"   Description="전화번호" Width="110" HAlign="center" Align="left"  OnClick="gridDetailClick" runat="server" />
                                                <Ctl:SheetField DataField="ADDBIGO"   TextField="ADDBIGO"   Description="비고" Width="250" HAlign="center" Align="left"  OnClick="gridDetailClick" runat="server" />                             

                                         </Ctl:WebSheet> 
                    </td>
                </tr>
            </table>    

      

        </Ctl:Layer> 
    </div>
</asp:content>