<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSB0006.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSB0006" %>

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

            if (txtTRNUMNO1.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="차량번호 앞자리를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            else {
                if (txtTRNUMNO1.length < 3) {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG02" Description="차량번호 앞자리는 세자리 이상입니다." Literal="true"></Ctl:Text>');
                    return false;
                }
            }
            if (txtTRNUMNO2.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="차량번호 뒷자리를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            else {
                if (txtTRNUMNO2.GetValue().length != 4) {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG04" Description="차량번호 뒷자리는 네자리 입니다." Literal="true"></Ctl:Text>');
                    return false;
                }
            }
            if ($("#svTRUNSONG_CDCODE").val() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG05" Description="차량소속 코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if ($("#svTRHYUNGT_CDCODE").val() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG06" Description="탱크로리 코드를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtTRJUNGRY.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG07" Description="적재 중량 MT량을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            UP_GetCarNo();

            ht["TRNUMNO1"] = txtTRNUMNO1.GetValue();
            ht["TRNUMNO2"] = txtTRNUMNO2.GetValue();
            ht["TRUNSONG"] = $("#svTRUNSONG_CDCODE").val();
            ht["TRUNSONGNM"] = svTRUNSONG.GetValue();
            ht["TRHYUNGT"] = $("#svTRHYUNGT_CDCODE").val();
            ht["TRHYUNGTNM"] = svTRHYUNGT.GetValue();
            ht["TRUNNAME"] = txtTRUNNAME.GetValue();
            ht["TRGITEL"] = txtTRGITEL.GetValue();
            ht["TRJUNGRY"] = txtTRJUNGRY.GetValue();
            ht["VNCODE"] = txtVNCODE.GetValue();
            ht["HWAJUNM"] = txtHWAJUNM.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG08" Description="등록 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_CSB0006_SAVE", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            
                            $("#btnSave").attr("style", "display:none");
                        }
                        var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG09" Description="' + msg + '" Literal="true"></Ctl:Text>');

                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG10" Description="등록 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG10" Description="등록 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        function btnClose_Click() {
            this.close();
        }

        function UP_GetCarNo() {
            var sSTNUM;
            var sEDNUM;
            var sNUM;

            var sGUBUN;

            var sCarNo;

            sCarNo = txtTRNUMNO1.GetValue().trim().substr(0, 1);

            if (sCarNo == "1" || sCarNo == "2" || sCarNo == "3" || sCarNo == "4" || sCarNo == "5" ||
                sCarNo == "6" || sCarNo == "7" || sCarNo == "8" || sCarNo == "9" || sCarNo == "0")
            {
                switch (txtTRNUMNO1.GetValue().substr(0, 1))
                {
                    case "1":
                        sSTNUM = "＇１＇";
                        sGUBUN = "1";
                        break;
                    case "2":
                        sSTNUM = "＇２＇";
                        sGUBUN = "1";
                        break;
                    case "3":
                        sSTNUM = "＇３＇";
                        sGUBUN = "1";
                        break;
                    case "4":
                        sSTNUM = "＇４＇";
                        sGUBUN = "1";
                        break;
                    case "5":
                        sSTNUM = "＇５＇";
                        sGUBUN = "1";
                        break;
                    case "6":
                        sSTNUM = "＇６＇";
                        sGUBUN = "1";
                        break;
                    case "7":
                        sSTNUM = "＇７＇";
                        sGUBUN = "1";
                        break;
                    case "8":
                        sSTNUM = "＇８＇";
                        sGUBUN = "1";
                        break;
                    case "9":
                        sSTNUM = "＇９＇";
                        sGUBUN = "1";
                        break;
                    case "0":
                        sSTNUM = "＇０＇";
                        sGUBUN = "1";
                        break;
                }

                switch (txtTRNUMNO1.GetValue().substr(1, 1))
                {
                    case "1":
                        sEDNUM = "＇１＇";
                        break;
                    case "2":
                        sEDNUM = "＇２＇";
                        break;
                    case "3":
                        sEDNUM = "＇３＇";
                        break;
                    case "4":
                        sEDNUM = "＇４＇";
                        break;
                    case "5":
                        sEDNUM = "＇５＇";
                        break;
                    case "6":
                        sEDNUM = "＇６＇";
                        break;
                    case "7":
                        sEDNUM = "＇７＇";
                        break;
                    case "8":
                        sEDNUM = "＇８＇";
                        break;
                    case "9":
                        sEDNUM = "＇９＇";
                        break;
                    case "0":
                        sEDNUM = "＇０＇";
                        break;
                }
            }
            else
            {
                switch (txtTRNUMNO1.GetValue().substr(2, 1))
                {
                    case "1":
                        sSTNUM = "＇１＇";
                        sGUBUN = "1";
                        break;
                    case "2":
                        sSTNUM = "＇２＇";
                        sGUBUN = "1";
                        break;
                    case "3":
                        sSTNUM = "＇３＇";
                        sGUBUN = "1";
                        break;
                    case "4":
                        sSTNUM = "＇４＇";
                        sGUBUN = "1";
                        break;
                    case "5":
                        sSTNUM = "＇５＇";
                        sGUBUN = "1";
                        break;
                    case "6":
                        sSTNUM = "＇６＇";
                        sGUBUN = "1";
                        break;
                    case "7":
                        sSTNUM = "＇７＇";
                        sGUBUN = "1";
                        break;
                    case "8":
                        sSTNUM = "＇８＇";
                        sGUBUN = "1";
                        break;
                    case "9":
                        sSTNUM = "＇９＇";
                        sGUBUN = "1";
                        break;
                    case "0":
                        sSTNUM = "＇０＇";
                        sGUBUN = "1";
                        break;
                }

                switch (txtTRNUMNO1.GetValue().substr(3, 1))
                {
                    case "1":
                        sEDNUM = "＇１＇";
                        break;
                    case "2":
                        sEDNUM = "＇２＇";
                        break;
                    case "3":
                        sEDNUM = "＇３＇";
                        break;
                    case "4":
                        sEDNUM = "＇４＇";
                        break;
                    case "5":
                        sEDNUM = "＇５＇";
                        break;
                    case "6":
                        sEDNUM = "＇６＇";
                        break;
                    case "7":
                        sEDNUM = "＇７＇";
                        break;
                    case "8":
                        sEDNUM = "＇８＇";
                        break;
                    case "9":
                        sEDNUM = "＇９＇";
                        break;
                    case "0":
                        sEDNUM = "＇０＇";
                        break;
                }

                if (sGUBUN == "")
                {
                    sSTNUM = txtTRNUMNO1.GetValue().substr(2, 1);
                    sEDNUM = txtTRNUMNO1.GetValue().substr(3, 1);
                }
                else
                {
                    sSTNUM = sSTNUM.substr(1, 1);
                    sEDNUM = sEDNUM.substr(1, 1);
                }

                sNUM = txtTRNUMNO1.GetValue().substr(0, 2) + sSTNUM + sEDNUM + txtTRNUMNO1.GetValue().substr(4, 1);
                txtTRNUMNO1.SetValue(sNUM);
            }
        }

       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="신규차량 등록" Literal="true"></Ctl:Text>
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
                    <col style="width:130px;" />
                    <col style="width:*;" />
                </colgroup>
            <tr>
                <th><Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="차량번호" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtTRNUMNO1" runat="server" Width="80px" maxlength="12"></Ctl:TextBox>  
                    <Ctl:TextBox ID="txtTRNUMNO2" runat="server" Width="60px" maxlength="4"></Ctl:TextBox>  
                    <Ctl:Text ID="TXT09" runat="server" LangCode="TXT09" style="color:red" Description="(예시) 경남81아 / 2555"></Ctl:Text>
                </td>
            </tr>
            <tr>
                <th><Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="차량소속" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:SearchView ID="svTRUNSONG" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'SK'}" >                       
                        <Ctl:SearchViewField DataField="CDCODE" TextField="CDCODE" Description="코드" Hidden="false" Width="50" TextBox="true" runat="server" />
                        <Ctl:SearchViewField DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" Width="200" TextBox="false" Default="true" runat="server" />
                    </Ctl:SearchView>
                </td>
            </tr>
            <tr>
                <th><Ctl:Text ID="TXT04" runat="server" LangCode="TXT04" Description="탱크로리" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:SearchView ID="svTRHYUNGT" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'HT'}" >                       
                        <Ctl:SearchViewField DataField="CDCODE" TextField="CDCODE" Description="코드" Hidden="false" Width="50" TextBox="true" runat="server" />
                        <Ctl:SearchViewField DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" Width="200" TextBox="false" Default="true" runat="server" />
                    </Ctl:SearchView>
                </td>
            </tr>
            <tr>
                <th><Ctl:Text ID="TXT05" runat="server" LangCode="TXT05" Description="기사성명"></Ctl:Text></th>
                <td>                    
                    <Ctl:TextBox ID="txtTRUNNAME" runat="server" Width="100px"></Ctl:TextBox>  
                </td>
            </tr>
            <tr>
                <th><Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="기사전화"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtTRGITEL" runat="server" Width="250px"></Ctl:TextBox>  
                </td>
            </tr>
            <tr>
                <th><Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="적재중량(MT)" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtTRJUNGRY" style="text-align:right" runat="server" SetType="Number" Width="100px"></Ctl:TextBox>  
                    <Ctl:Text ID="TXT08" runat="server" LangCode="TXT08" style="color:red" Description="(예시) 20.000"></Ctl:Text>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="color:red;text-align:center">
                    <Ctl:Text ID="TXT10" runat="server" LangCode="TXT10" style="color:red" Description="차량 등록완료 후 차량 등록증을 태영 담당자메일 또는 팩스(052-228-3535/6)으로 필히 보내주시기 바랍니다."></Ctl:Text>
                </td>
            </tr>
            <Ctl:TextBox ID="txtVNCODE" Hidden="true" runat="server"></Ctl:TextBox> 
            <Ctl:TextBox ID="txtHWAJUNM" Hidden="true" runat="server"></Ctl:TextBox> 
            </table>
		</Ctl:Layer>
	</div>
</asp:content>