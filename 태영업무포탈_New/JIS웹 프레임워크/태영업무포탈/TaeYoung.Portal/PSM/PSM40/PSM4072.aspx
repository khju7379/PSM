<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4072.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4072" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        // 페이지 로드
        function OnLoad() {

            var Num = "<%= Request.QueryString["CODE"] %>";
            var data = Num.split('^');
            var today = new Date();

            txtCOPYPECCDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

            cboPECCGUBUN.SetValue(data[0]);
            txtPECCDATE.SetValue(data[1]);
            txtPECCSEQ.SetValue(data[2]);

            cboCOPYPECCGUBUN.SetValue(data[0]);

            cboPECCGUBUN.SetDisabled(true);
            cboCOPYPECCGUBUN.SetDisabled(true);
            txtPECCDATE.SetDisabled(true);
        }

        // 복사 버튼 이벤트
        function btnCopy_Click() {

            if (cboCOPYPECCGUBUN.GetValue() == "" || cboCOPYPECCGUBUN.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="작업구분을 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtCOPYPECCDATE.GetValue() == "" || txtCOPYPECCDATE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="복사일자를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_PECCGUBUN"] = cboPECCGUBUN.GetValue();
            ht["P_PECCDATE"] = txtPECCDATE.GetValue().split("-").join("");
            ht["P_PECCSEQ"] = txtPECCSEQ.GetValue();
            ht["P_COPYPECCGUBUN"] = cboCOPYPECCGUBUN.GetValue();
            ht["P_COPYPECCDATE"] = txtCOPYPECCDATE.GetValue();

            if (confirm('<Ctl:Text runat="server" Description="복사 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_EXAM_CHECK_CONTENTS_COPY", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            txtCOPYPECCSEQ.SetValue(DataSet.Tables[0].Rows[0]["MSG"]);

                            alert('<Ctl:Text runat="server" Description="복사가 완료 되었습니다." Literal="true"></Ctl:Text>');
                            if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                                opener.btnSearch_Click();
                            }
                            this.close();
                        }
                        else {
                            alert('<Ctl:Text runat="server" Description="복사 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" Description="복사 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="복사 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
                
            }
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            this.close();            
        }

    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <div class="btn_bx" style="height:30px">
            <Ctl:Button ID="btnCopy" runat="server" Style="Orange" LangCode="btnCopy" Description="복사" OnClientClick="btnCopy_Click();" ></Ctl:Button>
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
                    <col width="100px" />
                    <col width="120px" />
                    <col width="100px" />
                    <col width="120px" />
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="lblPECCGUBUN" runat="server" LangCode="lblPECCGUBUN" Description="작업구분"></Ctl:Text>
                    </th>
                    <td>                                          
                       <Ctl:Combo ID="cboPECCGUBUN" Width="80px" runat="server" ReadOnly="true">
                            <asp:ListItem Text="일반" Value="1"></asp:ListItem>
                            <asp:ListItem Text="화물" Value="2"></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblPECCDATE" runat="server" LangCode="lblPECCDATE" Description="기준일자"></Ctl:Text>
                    </th>
                    <td>                                          
                       <Ctl:TextBox ID="txtPECCDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ReadOnly="true"></Ctl:TextBox> 
                    </td>
                    <th>
                        <Ctl:Text ID="lblPECCSEQ" runat="server" LangCode="lblPECCSEQ" Description="순번"></Ctl:Text>
                    </th>
                    <td>                                          
                       <Ctl:TextBox ID="txtPECCSEQ" Width="50px" runat="server" style ="text-align:right;" LangCode="txtPECCSEQ" Description="순번" ReadOnly="true"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="text-align:center;">
                        <img src="/Resources/Images/down_arrow.png" alt="" title="" >
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblCOPYPECCGUBUN" runat="server" LangCode="lblCOPYPECCGUBUN" Description="작업구분" Required = "true"></Ctl:Text>
                    </th>
                    <td>                                          
                       <Ctl:Combo ID="cboCOPYPECCGUBUN" Width="80px" runat="server">
                            <asp:ListItem Text="일반" Value="1"></asp:ListItem>
                            <asp:ListItem Text="화물" Value="2"></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        <Ctl:Text ID="lblCOPYPECCDATE" runat="server" LangCode="lblCOPYPECCDATE" Description="복사일자" Required = "true"></Ctl:Text>
                    </th>
                    <td >                                          
                       <Ctl:TextBox ID="txtCOPYPECCDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                    </td>
                    <th>
                        <Ctl:Text ID="lblCOPYPECCSEQ" runat="server" LangCode="lblCOPYPECCSEQ" Description="순번" Required = "true"></Ctl:Text>
                    </th>
                    <td >
                        <Ctl:TextBox ID="txtCOPYPECCSEQ" Width="50px" runat="server" style ="text-align:right;" LangCode="txtCOPYPECCSEQ" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                    </td>
                </tr>
            </table>
		</Ctl:Layer>
	</div>
</asp:content>