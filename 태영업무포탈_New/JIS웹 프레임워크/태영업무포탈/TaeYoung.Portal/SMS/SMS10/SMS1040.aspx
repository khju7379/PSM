<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMS1040.aspx.cs" Inherits="TaeYoung.Portal.SMS.SMS10.SMS1040" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

        <style>           
             html,body {width:100%;  }
            body,div,ul,li{margin:0; padding:0;}
            ul,li {list-style:none;}

            /*tab css*/
            .tab{float:left; width:100%; height:600px;}
            .tabnav{font-size:0; width:600px; border:0px solid #ddd;}
            
            .tabnav li{display: inline-block;  height:30px; text-align:center; border-right:1px solid #ddd;}

            .tabnav li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:2px; }

            .tabnav li a.active:before{background:#A32958;}

            .tabnav li a.active{border-bottom:1px solid #fff;}
            .tabnav li a{ position:relative; display:block; background: #f8f8f8; color: #646464; padding:0 30px; line-height:30px; text-decoration:none; font-size:13px;}
            .tabnav li a:hover,
            .tabnav li a.active{background:#fff; color:#A32958; }            
            .tabcontent{padding: 5px; height:680px; border:1px solid #ddd; border-top:none;}
           
        </style>

    <script type="text/javascript">

        var idx = "";

       
        function OnLoad() {
            var today = new Date();
            txtFRDate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            today.setDate(today.getDate() + 6);
            txtTODate.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

            $("#txtSMSSTCNT").css({ "text-align": "right" });
            $("#txtSMSEMCNT").css({ "text-align": "right" });
            $("#txtSMSTOTALCNT").css({ "text-align": "right", "color": "blue"});

            $("#txtCHKCNT").css({ "text-align": "right" });
            $("#txtUNCHKCNT").css({ "text-align": "right" });
            $("#txtCHKTOTALCNT").css({ "text-align": "right", "color": "blue" });

            $("#txtDSPSMSTOTALCNT").css({ "color": "blue" });
            $("#txtDSPCHKTOTALCNT").css({ "color": "blue" });

            tabControl();

        }

        function tabControl() {

            $('.tabcontent > div').hide();

            $('.tabnav a').click(function () {
                $('.tabcontent > div').hide().filter(this.hash).fadeIn();
                $('.tabnav a').removeClass('active');
                $(this).addClass('active');
                return false;
            }).filter(':eq(0)').click();
        }


        function btnSearch_Click() {

            if (txtFRDate.GetValue() == "" || txtTODate.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="조회일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"]         = 15;            
            
            ht["P_SDATE"] = txtFRDate.GetValue();
            ht["P_EDATE"] = txtTODate.GetValue();
            if ($("#cmbTEAM").val() == "ALL") {
                ht["P_TEAM"] = "";                
            }
            else {
                ht["P_TEAM"] = $("#cmbTEAM").val();                
            }            

            if ($("#cmbCHARGUBN").val() == "ALL") {
                ht["P_SMSGUBN"] = "";                
            }
            else {
                ht["P_SMSGUBN"] = $("#cmbCHARGUBN").val();
            }           

            ht["P_SABUN"] = $("#svSABUN_KBSABUN").val();            

            gridMaster.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridMaster.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridMaster.CallBack = function () {
                // 편집 이벤트 제거
                // id+row번호+cell번호 : gridCodeList_0_1
                var dt = gridMaster.GetAllRow();                

                if (ObjectCount(dt.Rows) > 0) {
                    txtSMSSTCNT.SetValue(dt.Rows[0]["STCNT"]);
                    txtSMSEMCNT.SetValue(dt.Rows[0]["EMCNT"]);
                    txtSMSTOTALCNT.SetValue(dt.Rows[0]["TOTALCNT"]);
                }

                document.getElementById("tab01").style.display = "";
                document.getElementById("tab02").style.display = "none";
                $('#tabli01').addClass('active');
                $('#tabli02').removeClass('active');
            }

            UP_gridDetail_DataBinging('00000000', '0');
        }

        function gridClick(r, c) {

            var dr = gridMaster.GetRow(r);                      

            UP_gridDetail_DataBinging(dr["LOMDATE"], dr["LOMSEQ"]);

            document.getElementById("tab01").style.display = "none";
            document.getElementById("tab02").style.display = "";
            $('#tabli01').removeClass('active');
            $('#tabli02').addClass('active');
        }

        function UP_gridDetail_DataBinging(LOMDATE, LOMSEQ) {

            
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["LODDATE"] = LOMDATE;
            ht["LODSEQ"] = LOMSEQ;

            gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridDetail.CallBack = function () {
                // 편집 이벤트 제거
                // id+row번호+cell번호 : gridCodeList_0_1
                var dt = gridDetail.GetAllRow();

                if (ObjectCount(dt.Rows) > 0) {

                    txtCHKCNT.SetValue(dt.Rows[0]["CHKCNT"]);
                    txtUNCHKCNT.SetValue(dt.Rows[0]["UNCHKCNT"]);
                    txtCHKTOTALCNT.SetValue(dt.Rows[0]["TOTALCNT"]);
                }              

            }
        }

       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" LangCode="layer1" Title="발송이력 조회" DefaultHide="False">

         <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="200px" />
                    <col width="80px" />
                    <col width="200px" />
                    <col width="*" />
                    
                </colgroup>
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="txtSearchDate" runat="server" LangCode="txtSearchDate" Description="전송일자"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtFRDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                        <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="txtCHARGUBN" runat="server" LangCode="txtCHARGUBN" Description="문자유형"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cmbCHARGUBN" runat="server" RepeatColumns="2">
                            <asp:ListItem Selected="True" Text="전체" Value="ALL"></asp:ListItem>
                            <asp:ListItem Text="일반" Value="1"></asp:ListItem>
                            <asp:ListItem Text="비상" Value="2"></asp:ListItem>
                        </Ctl:Combo> 
                    </td>
                    <td style="text-align:right;">
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>                     
                    </td>

                                    
                </tr>    
                <tr style="text-align:left;">
                    <th>
                        <Ctl:Text ID="txtDPMK" runat="server" LangCode="txtDPMK" Description="사업장"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cmbTEAM" runat="server" RepeatColumns="2">
                            <asp:ListItem Selected="True" Text="전체" Value="ALL"></asp:ListItem>
                            <asp:ListItem Text="UTT" Value="T"></asp:ListItem>
                            <asp:ListItem Text="SILO" Value="S"></asp:ListItem>
                            <asp:ListItem Text="관리팀" Value="A"></asp:ListItem>
                        </Ctl:Combo> 
                    </td>
                    <th>
                        <Ctl:Text ID="txtSENDSABUN" runat="server" LangCode="txtSENDSABUN" Description="발신자"></Ctl:Text>
                    </th>
                    <td colspan="2">
                         <Ctl:SearchView ID="svSABUN" runat="server" TypeName="SMS.SMSBiz" MethodName="UP_SMS_KBSABUN_LIST" >   
                              <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" />
                              <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="130" TextBox="true" Default="true" runat="server" />
                         </Ctl:SearchView>
                    </td>  
                </tr>
            </table>          
        </div>

         <div class="tab">
            <ul class="tabnav">
              <li><a id="tabli01" href="#tab01">전송이력</a></li>
              <li><a id="tabli02" href="#tab02">상세내역</a></li>
            </ul>
            <div class="tabcontent">
              <div id="tab01">
                   <table  style="width: 100%;">
                       <tr>
                           <td valign="top">      
                             <Ctl:WebSheet ID="gridMaster" runat="server" Paging="false" HFixation="true"   Width="100%"  Height="550" CheckBox="false" TypeName="SMS.SMSBiz" MethodName="UP_SMS_SMSManagerLog_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                                <Ctl:SheetField DataField="LOMSMSGUBNNM"    TextField="LOMSMSGUBNNM"    Description="문자유형" Width="85" HAlign="center" Align="left"   runat="server" OnClick="gridClick"/>
                                <Ctl:SheetField DataField="LOMDATE"     TextField="LOMDATE"     Description="발신일자" Width="100"  HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                                <Ctl:SheetField DataField="LOMSEQ"     TextField="LOMSEQ"     Description="SEQ"      Width="30"  HAlign="center" Align="left" Hidden="true"  runat="server" OnClick="gridClick"/>
                                <Ctl:SheetField DataField="LOMTIME"   TextField="LOMTIME"   Description="발신시간" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                                <Ctl:SheetField DataField="LOMLOCATNM"   TextField="LOMLOCATNM"   Description="발신위치" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                                <Ctl:SheetField DataField="LOMTEAMNM"  TextField="LOMTEAMNM"  Description="발신부서" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                                <Ctl:SheetField DataField="KBHANGL"   TextField="KBHANGL"   Description="발신자"   Width="85"  HAlign="center"  Align="left" runat="server" OnClick="gridClick"/>
                                <Ctl:SheetField DataField="LOMSENDTEL"  TextField="LOMSENDTEL"  Description="발신번호" Width="120" HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>
                                <Ctl:SheetField DataField="LOMCONTENT"  TextField="LOMCONTENT"  Description="내 용"    Width="350" HAlign="center" Align="left"  runat="server" OnClick="gridClick"/>

                             </Ctl:WebSheet>  
                           </td>
                       </tr>
                   </table>

                  <table class="table_01" style="width: 100%;"> 
                                   <col width="10%" />
                                   <col width="10%" />
                                   <col width="10%" />
                                   <col width="10%" />
                                   <col width="10%" />
                                   <col width="*" />                                   
                                   <tr>
                                        <th><Ctl:Text ID="TXT01" runat="server" LangCode="TXT_txtMN_MENUID" Description="일반문자" /></th>
                                        <td>
                                            <Ctl:TextBox ID="txtSMSSTCNT" Width="50" ReadOnly="true" runat="server"  /> 건
                                        </td>
                                       <th><Ctl:Text ID="TXT02" runat="server" LangCode="TXT_txtMN_MENUID" Description="비상문자" /></th>
                                        <td>
                                            <Ctl:TextBox ID="txtSMSEMCNT" Width="50" ReadOnly="true" runat="server" /> 건
                                        </td>
                                       <th><Ctl:Text ID="txtDSPSMSTOTALCNT" runat="server" LangCode="TXT_txtMN_MENUID" Description="합   계" /></th>
                                        <td>
                                            <Ctl:TextBox ID="txtSMSTOTALCNT" Width="50" ReadOnly="true" runat="server" /> 건
                                        </td>
                                   </tr>
                         </table>                   
                   

              </div>
              <div id="tab02">
                   <Ctl:WebSheet ID="gridDetail" runat="server" Paging="false"  HFixation="true"  Width="100%" Height="550" CheckBox="false"  TypeName="SMS.SMSBiz" MethodName="UP_SMS_SMSManagerLogDetail_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                                <Ctl:SheetField DataField="ROWNO"    TextField="ROWNO"    Description="순번" Width="30" HAlign="center" Align="center"   runat="server" />
                                <Ctl:SheetField DataField="LODDATE"    TextField="LODDATE"    Description="발신일자" Width="85" HAlign="center" Align="left"   runat="server" />
                                <Ctl:SheetField DataField="LODTIME"     TextField="LODTIME"     Description="발신시간" Width="100"  HAlign="center" Align="left"  runat="server" />
                                <Ctl:SheetField DataField="KBHANGL"   TextField="KBHANGL"   Description="수신자" Width="80" HAlign="center" Align="left"  runat="server" />
                                    <Ctl:SheetField DataField="LODRECTEL"   TextField="LODRECTEL"   Description="수신번호" Width="110" HAlign="center" Align="left"  runat="server" />
                                    <Ctl:SheetField DataField="LODRECDAT"   TextField="LODRECDAT"   Description="수신일자" Width="85" HAlign="center" Align="left"  runat="server" />
                                    <Ctl:SheetField DataField="LODRECTIM"   TextField="LODRECTIM"   Description="수신시간" Width="80" HAlign="center" Align="left"  runat="server" />

                          </Ctl:WebSheet>  
                   <table class="table_01" style="width: 100%;">  
                                   <col width="10%" />
                                   <col width="10%" />
                                   <col width="10%" />
                                   <col width="10%" />
                                   <col width="10%" />
                                   <col width="*" />                                    
                                   <tr>
                                        <th><Ctl:Text ID="Text1" runat="server" LangCode="TXT_txtMN_MENUID" Description="수신확인" /></th>
                                        <td>
                                            <Ctl:TextBox ID="txtCHKCNT" Width="50"  ReadOnly="true" runat="server" /> 건
                                        </td>
                                       <th><Ctl:Text ID="Text2" runat="server" LangCode="TXT_txtMN_MENUID" Description="미확인" /></th>
                                        <td>
                                            <Ctl:TextBox ID="txtUNCHKCNT" Width="50"  ReadOnly="true" runat="server" /> 건
                                        </td>
                                        <th><Ctl:Text ID="txtDSPCHKTOTALCNT" runat="server" LangCode="TXT_txtMN_MENUID" Description="합  계" /></th>
                                        <td>
                                            <Ctl:TextBox ID="txtCHKTOTALCNT" Width="50"  ReadOnly="true" runat="server" /> 건
                                        </td>
                                   </tr>
                                 </table>
              </div>
            </div>
         </div><!--tab-->

        </Ctl:Layer> 
    </div>
</asp:content>
