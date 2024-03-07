<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSB0001.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSB0001" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

            // PageLoad시 이벤트 정의부분

            var NUM = "<%= Request.QueryString["NUM"] %>";
            var data = NUM.split('^');

            if (data.length == 2)
            {
                txtHWAJU.SetValue(data[0]);
                txtHWAJUNM.SetValue(data[1]);
            }

            if(txtHWAJU.GetValue() != "")
            {
                BindPage();
            }
        }

        function BindPage() {
            var ht = new Object();

            ht["IPHWAJU"] = txtHWAJU.GetValue();

            PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_GET_CSB0001_HWAMUL_LIST", BindPage_Callback);

        }

        function BindPage_Callback(e) {
            var ds = eval(e);

            // 콤보 바인딩
            BindCombo(ds.Tables[0]);
            btnSearch_Click();
        }

        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 100000;
            ht["HWAJU"] = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>"
            ht["HWAMUL"] = cmbHWAMUL.GetValue();

            gridMaster.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridMaster.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩



        }

        function btnClose_Click()
        {
            this.close();
        }

        // 마스터 그리드 선택
        function MasterGridClick(r, c)
        {
            var rows = gridMaster.GetRow(gridMaster.SelectedRow);

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 100000;
            ht["IPHANG"] = rows["CJIPHANG"];
            ht["BONSUN"] = rows["CJBONSUN"];
            ht["HWAJU"] = rows["CJHWAJU"];
            ht["HWAMUL"] = rows["CJHWAMUL"];
            
            gridDetail.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            
            
        }

        //그리드 선택한 row 값 부모창에 넘겨주기
        function DetailGridClick(r, c) {

            if (opener) {
               opener.btnPopup_Callback(gridMaster.GetRow(gridMaster.SelectedRow), gridDetail.GetRow(gridDetail.SelectedRow));
               self.close();
            }
            else {
                alert("대상이 없습니다.");
            }
        }

        function BindCombo(dt) {
            var c = cmbHWAMUL.Control;
            $(c).find("option").remove();
            $(c).append("<option value=''>전체</option>");
            for (i = 0; i < ObjectCount(dt.Rows); i++) {
                var dr = dt.Rows[i];
                $(c).append("<option value='" + dr["CDCODE"] + "'>" + dr["CDDESC1"] + "</option>");
            }
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="content">
        <Ctl:Layer ID="layer1" runat="server" LangCode="layer1" Title="통관일자별 재고 조회" DefaultHide="False">
        <div class="btn_bx">        
            <table class="table_01" style="width: 100%;">    
                <colgroup>
                    <col width="110px" />
                    <col width="270px" />
                    <col width="110px" />
                    <col width="140px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="txtSearchHWAJU" runat="server" LangCode="txtSearchHWAJU" Description="통관화주"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtHWAJU" readonly="true" style="background-color:LightGray" Width="50px" runat="server"></Ctl:TextBox>                    
                        <Ctl:TextBox ID="txtHWAJUNM" readonly="true" style="background-color:LightGray"  Width="200px" runat="server"></Ctl:TextBox>
                    </td>
                    <th>
                        <Ctl:Text ID="txtSearchHWAMUL" runat="server" LangCode="txtSearchHWAMUL" Description="화물"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:Combo ID="cmbHWAMUL" runat="server" RepeatColumns="2">

                        </Ctl:Combo>
                    </td>
                    <td>
                      <!-- 상단의 버튼을 정의 -->
                     <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
                     <Ctl:Button ID="btnClose" runat="server" LangCode="btnAdd" Description="닫기" OnClientClick="btnClose_Click();"></Ctl:Button>
                    </td>
                </tr>
            </table>        
        </div>

                        
                         <Ctl:WebSheet ID="gridMaster" runat="server" Paging="false" HFixation="true" Fixation = "true" Height="250" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_GET_CSB0001_JEGO_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                            <Ctl:SheetField DataField="HMDESC1" TextField="HMDESC1" Description="화물명" Width="170"  HAlign="center" Align="left" runat="server" OnClick="MasterGridClick" />
                            <Ctl:SheetField DataField="CJIPHANG" TextField="CJIPHANG" Description="접안일자" Width="100" HAlign="center" Align="left" runat="server" OnClick="MasterGridClick" />
                            <Ctl:SheetField DataField="VSDESC1" TextField="VSDESC1" Description="본  선" Width="170" HAlign="center" Align="left" runat="server" OnClick="MasterGridClick" />
                            <Ctl:SheetField DataField="CJCUSTIL" TextField="CJCUSTIL" Description="통관일자" Width="100" HAlign="center" Align="left" runat="server" OnClick="MasterGridClick" />
                            <Ctl:SheetField DataField="CJBLNO" TextField="CHBLNO" Description="B/L NO" Width="150" HAlign="center" Align="left" runat="server" OnClick="MasterGridClick" />
                            <Ctl:SheetField DataField="CJMSNSEQ" TextField="CJMSNSEQ" Description="MSN" Width="100" HAlign="center" Align="left" runat="server" OnClick="MasterGridClick" />
                            <Ctl:SheetField DataField="CJJEQTY" TextField="CJJEQTY" Description="재고량" DataType="Number" Width="120" HAlign="right" Align="right" runat="server" OnClick="MasterGridClick" />
                            <Ctl:SheetField DataField="CJCUQTY" TextField="CJCUQTY" Description="통관량" DataType="Number"  Width="120" HAlign="right" Align="right" runat="server" OnClick="MasterGridClick" />
                            <Ctl:SheetField DataField="CJCHQTY" TextField="CJCHQTY" Description="출고량" DataType="Number"  Width="120" HAlign="right" Align="right" runat="server" OnClick="MasterGridClick" />
                            <Ctl:SheetField DataField="JIQTY" TextField="JIQTY" Description="지시량" DataType="Number"  Width="120" HAlign="right" Align="right" runat="server" OnClick="MasterGridClick" />
                            <Ctl:SheetField DataField="CJYSDATE" TextField="CJYSDATE" Description="양수일자" Width="104" HAlign="center" Align="left" runat="server" OnClick="MasterGridClick" />

                            <Ctl:SheetField DataField="CJACTHJ" TextField="CJACTHJ" Description="통관화주" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="CJJGHWAJU" TextField="CJJGHWAJU" Description="재고화주" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="CJBONSUN" TextField="CJBONSUN" Description="본선코드" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="CJHWAJU" TextField="CJHWAJU" Description="화주" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="CJHWAMUL" TextField="CJHWAMUL" Description="화물" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="CJHSNSEQ" TextField="CJHSNSEQ" Description="HSN" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="CJCHASU" TextField="CJCHASU" Description="차수" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="CJYSHWAJU" TextField="CJYSHWAJU" Description="양수화주" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="CJYDHWAJU" TextField="CJYDHWAJU" Description="양도화주" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="CJYDSEQ" TextField="CJYDSEQ" Description="양도차수" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="CJYSSEQ" TextField="CJYSSEQ" Description="양수순번" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="JGVEND" TextField="JGVEND" Description="재고화주명" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="IPVEND" TextField="IPVEND" Description="입고화주명" Hidden="true" runat="server" />
                            <Ctl:SheetField DataField="IPMTQTY" TextField="IPMTQTY" Description="B/L분할수량" Hidden="true" runat="server" />
                            

                        </Ctl:WebSheet>
                        
               
                        
                         <Ctl:WebSheet ID="gridDetail" runat="server" Paging="false" HFixation="true" Fixation = "true" Height="170" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_GET_CSB0002_CHTANK_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                            <Ctl:SheetField DataField="SVTANKNO" TextField="SVTANKNO" Description="TANK번호" Width="150"  HAlign="center" Align="left" runat="server" OnClick="DetailGridClick" />
                            <Ctl:SheetField DataField="SVMTQTY" TextField="SVMTQTY" Description="입고M/T량" DataType="Number" Width="160" HAlign="center" Align="right" runat="server" OnClick="DetailGridClick" />
                            <Ctl:SheetField DataField="SVKLQTY" TextField="SVKTQTY" Description="입고K/L량" DataType="Number" Width="160" HAlign="center" Align="right" runat="server" OnClick="DetailGridClick" />
                            <Ctl:SheetField DataField="SVCHULQTY" TextField="SVCHULQTY" Description="출고량" DataType="Number" Width="160" HAlign="right" Align="right" runat="server" OnClick="DetailGridClick" />
                            <Ctl:SheetField DataField="SVJGQTY" TextField="SVJGQTY" Description="재고량" DataType="Number" Width="160" HAlign="right" Align="right" runat="server" OnClick="DetailGridClick" />
                            <Ctl:SheetField DataField="SVGUMJUNG" TextField="SVGUMJUNG" Description="검정사" Width="260" HAlign="center" Align="left" runat="server" OnClick="DetailGridClick" />
                            <Ctl:SheetField DataField="SVMOGB" TextField="SVMOGB" Description="이고구분" Width="160" HAlign="center" Align="left" runat="server" OnClick="DetailGridClick" />
                            <Ctl:SheetField DataField="SVMOTA" TextField="SVMOTA" Description="이고TANK" Width="164" HAlign="center" Align="left" runat="server" OnClick="DetailGridClick" />
                        </Ctl:WebSheet>


        </Ctl:Layer> 
    </div>
</asp:content>