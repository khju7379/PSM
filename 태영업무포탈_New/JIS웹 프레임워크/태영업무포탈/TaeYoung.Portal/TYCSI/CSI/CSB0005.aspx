<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSB0005.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSB0005" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

            // PageLoad시 이벤트 정의부분
            getHeajuCode();
        }
        function getHeajuCode() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["USERID"] = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";

            PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_GET_HWAJUCODE", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtVNCODE.SetValue(DataSet.Tables[0].Rows[0]["EMHWAJU"]);
                    txtHWAJUNM.SetValue("<%= TaeYoung.Biz.Document.UserInfo.UserName %>");

                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        function btnSave_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            if(txtCDDESC1.GetValue() == "")
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="도착지명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            ht["CDDESC1"] = txtCDDESC1.GetValue();
            ht["VNCODE"] = txtVNCODE.GetValue();
            ht["HWAJUNM"] = txtHWAJUNM.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG02" Description="등록 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_CSB0005_SAVE", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["CDCODE"] != "")
                        {
                            txtCDCODE.SetValue(DataSet.Tables[0].Rows[0]["CDCODE"]);
                            $("#btnSave").attr("style", "display:none");
                        }
                        var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="등록 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="등록 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        function btnClose_Click()
        {
            this.close();
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="신규도착지 등록" Literal="true"></Ctl:Text>
        </h4>
        <div class="btn_bx">        
		    <Ctl:Button ID="btnSave" runat="server"  LangCode="btnSave" Description="등록" OnClientClick="btnSave_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>                
        </div>
        <div class="clear"></div>    
    </div>
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server">
		    <table class="table_01" style="width:100%;" border="0">
                <colgroup>
                    <col style="width:80px;" />
                    <col style="width:*;" />
                </colgroup>
            <tr>
                <th><Ctl:Text ID="TXT20" runat="server" LangCode="TXT20" Description="도착지"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtCDCODE" runat="server" readonly="true" style="background-color:LightGray" Width="50px"></Ctl:TextBox>  
                </td>
            </tr>
            <tr>
                <th><Ctl:Text ID="TXT21" runat="server" LangCode="TXT21" Description="도착지명" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtCDDESC1" runat="server" Width="250px"></Ctl:TextBox>  
                </td>
            </tr>
            <tr>
                <td colspan="2" style="color:red;text-align:center">
                    <Ctl:Text ID="TXT22" runat="server" LangCode="TXT22" style="color:red" Description="도착지명을 필히 입력하시기 바랍니다."></Ctl:Text>
                </td>
            </tr>
            <Ctl:TextBox ID="txtVNCODE" Hidden="true" runat="server"></Ctl:TextBox> 
            <Ctl:TextBox ID="txtHWAJUNM" Hidden="true" runat="server"></Ctl:TextBox> 
            </table>
		</Ctl:Layer>
	</div>
</asp:content>