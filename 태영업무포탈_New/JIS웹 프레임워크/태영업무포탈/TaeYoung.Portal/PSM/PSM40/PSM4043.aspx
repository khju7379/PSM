<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4043.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4043" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var _DOCNAME = "";
        var _CMWKTEAM = "";
        var _CMWKDATE = "";
        var _CMWKSEQ = "";
        var _SMWKORAPPDATE = "";
        var _SMWKORSEQ = "";

        // 페이지 로드
        function OnLoad() {

            var Num = "<%= Request.QueryString["CODE"] %>";

            var data = Num.split('^');

            _DOCNAME = data[0];
            _CMWKTEAM = data[1];
            _CMWKDATE = data[2];
            _CMWKSEQ = data[3];
            _SMWKORAPPDATE = data[4];
            _SMWKORSEQ = data[5];
        }

        function btnPrt_Click() {

            var sPRSITE = "";
            var sJSA = "";

            if (rdoPRSITE1.GetValue() != null) {
                sPRSITE = "1";
            }
            if (rdoPRSITE2.GetValue() != null) {
                sPRSITE = "2";
            }
            if (rdoPRSITE3.GetValue() != null) {
                sPRSITE = "3";
            }
            if (rdoPRSITE4.GetValue() != null) {
                sPRSITE = "4";
            }
            if (rdoPRSITE5.GetValue() != null) {
                sPRSITE = "5";
            }
            if (rdoPRSITE6.GetValue() != null) {
                sPRSITE = "6";
            }
            if (rdoPRSITE7.GetValue() != null) {
                sPRSITE = "7";
            }

            if (chkJSA.GetValue() == "JSA") {
                sJSA = "true";
            }
            
            if (sPRSITE != "") {

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.  

                var sessionid = "<%= Session.SessionID %>";

                ht["P_DOCNAME"] = _DOCNAME;
                ht["P_CMWKTEAM"] = _CMWKTEAM;
                ht["P_CMWKDATE"] = _CMWKDATE;
                ht["P_CMWKSEQ"] = _CMWKSEQ;
                ht["P_SMWKORAPPDATE"] = _SMWKORAPPDATE;
                ht["P_SMWKORSEQ"] = _SMWKORSEQ;
                ht["P_JSA"] = sJSA;
                ht["P_COPIES"] = cboPRINTCN.GetValue();
                ht["P_SESSIONID"] = sessionid;
                ht["P_PRSITE"] = sPRSITE;

                PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_PSM_PRINT_RUN", function (e) {

                    var DataSet = eval(e);
                    
                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            this.close();
                        }
                    }
                }, function (e) {
                    // Biz 연결오류
                    alert("Error");
                });
            }
        }

        function AjaxOnFailed(request, status, error) {
            document.write(request.responseText);
        }

        function btnClose_Click() {
            this.close();
        }

        function rdoLocationS_Changed(id) {

            var sWin = document.getElementById("trPRSITE");
            var theadObj = sWin.querySelectorAll("span");

            UP_Set_RadioCheckValue(theadObj, id);
        }

        function UP_Set_RadioCheckValue(theadObj, id) {

            var idname = id.GetValue();

            if (theadObj.length > 0) {

                for (var i = 0; i < theadObj.length; i++) {

                    if (theadObj[i].id == idname) {
                        
                        $("input:radio[name=" + idname + "]:radio[value=" + idname + "]").prop('checked', true);
                    }
                    else {
                        
                        $("input:radio[name=" + theadObj[i].id + "]:radio[value=" + theadObj[i].id + "]").prop('checked', false);

                    }
                }
            }
        }

    </script>
</asp:content>


<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="[안전작업허가서 출력]" DefaultHide="False">
            <!-- 상단의 버튼을 정의 -->
            <div class="btn_bx">
                <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="80px" />
                        <col width="200px" />
                    </colgroup>
                    <tr style="text-align:left;">
                        <td colspan="2" style ="text-align:right; border:0px">
                            <Ctl:Button ID="btnPrt"  runat="server" Style="orange" LangCode="btnPrt" Description="출력" OnClientClick="btnPrt_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>
                        </td>
                    </tr>
                    <tr id="trPRSITE">
                        <th style="text-align:left;">
                            <Ctl:Text ID="lblPRSITE" runat="server" LangCode="lblPRSITE" Description="출력장소"></Ctl:Text>
                        </th>
                        <td style="text-align:left;">
                            <Ctl:Radio ID="rdoPRSITE1" runat="server" RepeatColumns="1" OnChanged="rdoLocationS_Changed(rdoPRSITE1);">
                                <asp:ListItem Text="하단지 경비실" Value="rdoPRSITE1" ></asp:ListItem>
                            </Ctl:Radio>
                            <br/>
                            <Ctl:Radio ID="rdoPRSITE2" runat="server" RepeatColumns="1" OnChanged="rdoLocationS_Changed(rdoPRSITE2);">
                                <asp:ListItem Text="상단지 사무실" Value="rdoPRSITE2" ></asp:ListItem>
                            </Ctl:Radio>
                            <br/>
                            <Ctl:Radio ID="rdoPRSITE3" runat="server" RepeatColumns="1" OnChanged="rdoLocationS_Changed(rdoPRSITE3);">
                                <asp:ListItem Text="상단지 경비실" Value="rdoPRSITE3" ></asp:ListItem>
                                
                            </Ctl:Radio>
                            <br/>
                            <Ctl:Radio ID="rdoPRSITE4" runat="server" RepeatColumns="1" OnChanged="rdoLocationS_Changed(rdoPRSITE4);">
                                <asp:ListItem Text="해안단지 사무실" Value="rdoPRSITE4" ></asp:ListItem>
                            </Ctl:Radio>
                            <br/>
                            <Ctl:Radio ID="rdoPRSITE7" runat="server" RepeatColumns="1" OnChanged="rdoLocationS_Changed(rdoPRSITE7);">
                                <asp:ListItem Text="송유단지" Value="rdoPRSITE7" ></asp:ListItem>
                            </Ctl:Radio>
                            <br/>
                            <Ctl:Radio ID="rdoPRSITE5" runat="server" RepeatColumns="1" OnChanged="rdoLocationS_Changed(rdoPRSITE5);">
                                <asp:ListItem Text="SILO 경비실" Value="rdoPRSITE5" ></asp:ListItem>
                            </Ctl:Radio>
                            <br/>
                            <Ctl:Radio ID="rdoPRSITE6" runat="server" RepeatColumns="1" OnChanged="rdoLocationS_Changed(rdoPRSITE6);">
                                <asp:ListItem Text="SILO CCP" Value="rdoPRSITE6" ></asp:ListItem>
                            </Ctl:Radio>
                        </td>
                    </tr>
                    <tr>
                        <th style="text-align:left;">
                            <Ctl:Text ID="lblJSA" runat="server" LangCode="lblJSA" Description="JSA 포함"></Ctl:Text>
                        </th>
                        <td style="text-align:left;">
					        <Ctl:CheckBox ID="chkJSA" runat="server" ReadMode="false" >
                                <asp:ListItem Text="" Value="JSA" ></asp:ListItem>
                            </Ctl:CheckBox>
				        </td>
                    </tr>
                    <tr>
                        <th style="text-align:left;">
                            <Ctl:Text ID="lblPRINTCNT" runat="server" LangCode="lblPRINTCNT" Description="매수"></Ctl:Text>
                        </th>
                        <td style="text-align:left;">
                            <Ctl:Combo ID="cboPRINTCN" Width="60px" runat="server">
                                <asp:ListItem Text="1" Value="1" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="2" Value="2" ></asp:ListItem>
                                <asp:ListItem Text="3" Value="3" ></asp:ListItem>
                                <asp:ListItem Text="4" Value="4" ></asp:ListItem>
                                <asp:ListItem Text="5" Value="5" ></asp:ListItem>
                                <asp:ListItem Text="6" Value="6" ></asp:ListItem>
                                <asp:ListItem Text="7" Value="7" ></asp:ListItem>
                                <asp:ListItem Text="8" Value="8" ></asp:ListItem>
                                <asp:ListItem Text="9" Value="9" ></asp:ListItem>
                                <asp:ListItem Text="10" Value="10" ></asp:ListItem>
                            </Ctl:Combo>
                        </td>
                    </tr>
                </table>
            </div>
        </Ctl:Layer> 
    </div>
</asp:content>
