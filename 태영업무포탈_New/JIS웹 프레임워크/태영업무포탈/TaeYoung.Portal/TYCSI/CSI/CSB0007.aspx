<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSB0007.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSB0007" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {
            
        }

        function btnClose_Click() {
            this.close();
        }
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="할증시간안내" Literal="true"></Ctl:Text>
        </h4>
        <div class="btn_bx">        
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
                        <col style="width:220px;" />
                        <col style="width:220px;" />
                        <col style="width:*;" />
                    </colgroup>
                    <tr>
                        <td colspan="3" style="text-align:center">
                        입/출고 할증시간
                        </td>
                    </tr>
                    <tr>
                        <td>
                    
                        </td>
                        <td style="color:blue;text-align:center">
                            <font style="color:red;">하절기</font> (04/01 ~ 10/31)
                        </td>
                        <td style="color:blue;text-align:center">
                            <font style="color:red;">동절기</font> (11/01 ~ 03/31)
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center">
                        일 반
                        </td>
                        <td style="text-align:center">
                        09:00 ~ 18:00
                        </td>
                        <td style="text-align:center">
                        09:00 ~ 17:00
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center">
                        특 허
                        </td>
                        <td style="text-align:center">
                        18:00 ~ 00:00
                        </td>
                        <td style="text-align:center">
                        17:00 ~ 00:00
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center">
                        조 출
                        </td>
                        <td style="text-align:center">
                        00:00 ~ 09:00
                        </td>
                        <td style="text-align:center">
                        00:00 ~ 09:00
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="text-align:center">
                        ※ 토요일, 공휴일/임시공휴일의 경우 전일 조출/특허
                        </td>
                    </tr>
                </table>
		</Ctl:Layer>
	</div>
</asp:content>