<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CommonCode.aspx.cs" Inherits="TaeYoung.Portal.Admin.Cmn.CommonCode" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">
        //선택된 트리 값
        var selectMenuId = "";

        /**********************************************************************
        * OnLoad
        **********************************************************************/
        function OnLoad() {
            SrdoUSEYN.SetValue("Y");
            initInputData();

            tree_Inquery();
        }

        /**********************************************************************
        * 조회 버튼 클릭 
        **********************************************************************/
        function btnSearch_Click() {
            //선택 된 트리 값 초기화
            selectMenuId = "";
            //입력 폼 초기화
            initInputData();
            //트리 조회
            tree_Inquery();

            return false;
        }

        /**********************************************************************
        * 저장 버튼 클릭 이벤트
        **********************************************************************/
        function btnSave_Click() {

            var ht = new Object();
            ht["COMPANYCODE"] = IcboCompanyCode.GetValue();
            ht["DCODE"] = IcboDCODE.GetValue()? IcboDCODE.GetValue() : "";
            ht["PCODE"] = ItxtPCODE.GetValue();
            ht["CODE"] = ItxtCODE.GetValue();
            ht["ERPCODE"] = ItxtERPCODE.GetValue();
            ht["SODR"] = ItxtSODR.GetValue();
            ht["CODTXT_KR"] = ItxtCODTXT_KR.GetValue();
            ht["CODTXT_EN"] = ItxtCODTXT_EN.GetValue();
            ht["CODTXT_ZH"] = ItxtCODTXT_ZH.GetValue();
            ht["CODTXT_RU"] = ItxtCODTXT_RU.GetValue();
            ht["CODEXT1"] = ItxtCODEXT1.GetValue();
            ht["CODEXT2"] = ItxtCODEXT2.GetValue();
            ht["CODEXT3"] = ItxtCODEXT3.GetValue();
            ht["CODEXTN1"] = ItxtCODEXTN1.GetValue();
            ht["CODEXTN2"] = ItxtCODEXTN2.GetValue();
            ht["CODEXTN3"] = ItxtCODEXTN3.GetValue();
            ht["USEYN"] = IrdoUSEYN.GetValue().toUpperCase() == "Y" ? "Y" : "N";
            ht["REGID"] = "admin";

            selectMenuId = ItxtCODE.GetValue();

            PageMethods.InvokeServiceTable(ht, "Common.CommonBiz", "SetCMN_CODE_ADD", Save_CallBack, function (e) {
                alert(e.get_message());
            });

            return false;
        }

        /**********************************************************************
        * 저장 버튼 클릭 콜백 함수
        **********************************************************************/
        function Save_CallBack(e) {
            alert('<Ctl:Text ID="SAVE_MSG01" runat="server" LangCode="SAVE_MSG01" Description="입력하신 정보가 저장되었습니다." Literal="true" />');
            tree_Inquery();
            return false;
        }

        /**********************************************************************
        * 삭제 버튼 클릭 이벤트
        **********************************************************************/
        function btnRemove_Click() {
            selectMenuId = "";
            
            var ht = new Object();
            ht["COMPANYCODE"] = IcboCompanyCode.GetValue();
            ht["CODE"] = ItxtCODE.GetValue();
            ht["REGID"] = "admin";

            PageMethods.InvokeServiceTable(ht, "Common.CommonBiz", "SetCMN_CODE_DEL", Remove_CallBack, function (e) {
                alert(e.get_message());
            });

            return false;
        }

        /**********************************************************************
        * 삭제 버튼 클릭 콜백 함수
        **********************************************************************/
        function Remove_CallBack(e) {
            alert('<Ctl:Text ID="REMOVE_MSG01" runat="server" LangCode="REMOVE_MSG01" Description="입력하신 정보가 삭제되었습니다." Literal="true" />');

            initInputData();
            tree_Inquery();

            return false;
        }

        /**********************************************************************
        * 트리 조회
        **********************************************************************/
        function tree_Inquery() {

            var ht = new Object();
            ht["COMPANYCODE"] = ScboCompanyCode.GetValue();
            ht["DCODE"] = ScboDCODE.GetValue() ? ScboDCODE.GetValue() : "";
            ht["PCODE"] = "";
            ht["USEYN"] = SrdoUSEYN.GetValue().toUpperCase() == "Y" ? "Y" : "N";
            ht["LANGCODE"] = "KO";

            wtWMSMENU.Params(ht); // 선언한 파라미터를 그리드에 전달함
            wtWMSMENU.BindTree("wtWMSMENU");

            //setTreeValue(wtWMSMENU);
            return false;
        }

        /**********************************************************************
        * 트리 초기값
        **********************************************************************/
        function wtWMSMENU_Loaded() {
            wtWMSMENU.AllChildClose();
            var itemList = wtWMSMENU.Search(selectMenuId);
            if (itemList.length > 0) {
                itemList[0].Select();
            }

            //사용여부 아니요 취소선 적용
            setTreeValue(wtWMSMENU);
            
            return false;
        }

        //미사용 취소선 스타일 
        function setTreeValue(obj) {
            if (obj.Items.length > 0) {
                for (var i = 0; i < obj.Items.length; i++) {
                    if (obj.Items[i].Values[15] == "N") {
                        $(obj.Items[i].TextNode).css("text-decoration", "line-through")
                    }

                    setTreeValue(obj.Items[i]);
                }
            }
        }

        /**********************************************************************
        * 트리 클릭 이벤트
        **********************************************************************/
        function tree1_click(e, s) {
            IcboCompanyCode.SetValue(wtWMSMENU.SelectedItems[0].Values[0]);
            IcboDCODE.SetValue(wtWMSMENU.SelectedItems[0].Values[1]);
            ItxtPCODE.SetValue(wtWMSMENU.SelectedItems[0].Values[2]);
            ItxtCODE.SetValue(wtWMSMENU.SelectedItems[0].Values[3]);
            ItxtSODR.SetValue(wtWMSMENU.SelectedItems[0].Values[4]);
            ItxtCODTXT_KR.SetValue(wtWMSMENU.SelectedItems[0].Values[5]);
            ItxtCODTXT_EN.SetValue(wtWMSMENU.SelectedItems[0].Values[6]);
            ItxtCODTXT_ZH.SetValue(wtWMSMENU.SelectedItems[0].Values[7]);
            ItxtCODTXT_RU.SetValue(wtWMSMENU.SelectedItems[0].Values[8]);
            ItxtERPCODE.SetValue(wtWMSMENU.SelectedItems[0].Values[9]);
            ItxtCODEXT1.SetValue(wtWMSMENU.SelectedItems[0].Values[10]);
            ItxtCODEXT2.SetValue(wtWMSMENU.SelectedItems[0].Values[11]);
            ItxtCODEXT3.SetValue(wtWMSMENU.SelectedItems[0].Values[12]);
            ItxtCODEXTN1.SetValue(wtWMSMENU.SelectedItems[0].Values[13]);
            ItxtCODEXTN2.SetValue(wtWMSMENU.SelectedItems[0].Values[14]);
            ItxtCODEXTN3.SetValue(wtWMSMENU.SelectedItems[0].Values[15]);
            IrdoUSEYN.SetValue(wtWMSMENU.SelectedItems[0].Values[16]);

            return false;
        }

        /**********************************************************************
        * 입력값 초기화 함수
        **********************************************************************/
        function initInputData() {
            IcboCompanyCode.SetValue("");
            IcboDCODE.SetValue("");
            ItxtCODE.SetValue("");
            ItxtPCODE.SetValue("");
            ItxtERPCODE.SetValue("");
            ItxtSODR.SetValue("");
            ItxtCODTXT_KR.SetValue("");
            ItxtCODTXT_EN.SetValue("");
            ItxtCODTXT_ZH.SetValue("");
            ItxtCODTXT_RU.SetValue("");
            ItxtCODEXT1.SetValue("");
            ItxtCODEXT2.SetValue("");
            ItxtCODEXT3.SetValue("");
            ItxtCODEXTN1.SetValue("0");
            ItxtCODEXTN2.SetValue("0");
            ItxtCODEXTN3.SetValue("0");
            IrdoUSEYN.SetValue("Y");

            return false;
        }

    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    
    <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="Text14" runat="server" LangCode="TXT01" Description="<h4>공통코드관리</h4>"></Ctl:Text>
        </h4>

        <div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnRemove" runat="server" LangCode="btnRemove" Description="삭제" OnClientClick="btnRemove_Click(); return false;"></Ctl:Button>
            <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click(); return false;"></Ctl:Button>
            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click(); return false;"></Ctl:Button>
        </div>
        <div class="clear"></div>
    </div>

    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer3" runat="server" Title="조회" DefaultHide="False">
             <ul class="search" style="border-bottom:0px;">
                <li><img src="/Resources/Images/icon_search.gif" alt="" title="" /></li>
                <li><Ctl:Text ID="TScboCompanyCode" runat="server" LangCode="TScboCompanyCode" Description="법인"></Ctl:Text></li>
                <li><Ctl:Combo ID="ScboCompanyCode" runat="server" RepeatColumns="2" OnChange= "tree_Inquery()"></Ctl:Combo></li>
                <li><Ctl:Text ID="TScboDCODE" runat="server" LangCode="TScboDCODE" Description="업무구분"></Ctl:Text></li>
                <li><Ctl:Combo ID="ScboDCODE" runat="server" RepeatColumns="2" OnChange= "tree_Inquery()"></Ctl:Combo></li>
                <li><Ctl:Text ID="TSrdoUSEYN" runat="server" LangCode="TSrdoUSEYN" Description="사용여부"></Ctl:Text></li>
                <li><Ctl:Radio ID="SrdoUSEYN" runat="server" RepeatColumns="2">
                        <asp:ListItem Value="Y" Text="사용"></asp:ListItem>
                        <asp:ListItem Value="N" Text="미사용"></asp:ListItem>
                    </Ctl:Radio>
                </li>
            </ul>
            <table class="table_01" style="width: 100%;border-bottom:1px">
                <colgroup>
                    <col width="180" />
                    <col width="100%" />
                </colgroup>
                <tr style="vertical-align:top;" >
                    <td style="padding-right:5px;">
                        <Ctl:WebTree ID="wtWMSMENU" runat="server" Width="180" Height="800" OnClick="tree1_click" EnableSearchBox="false" />
                    </td>
                    <td>
                        <ul class="search" style="border-bottom:0px;">
                            <li style="min-width : 100px;"><Ctl:Text ID="TIcboCompanyCode" runat="server" LangCode="TIcboCompanyCode" Description="법인" ></Ctl:Text></li>
                            <li><Ctl:Combo ID="IcboCompanyCode" runat="server" RepeatColumns="2" ></Ctl:Combo></li>
                            <li style="min-width : 100px;"><Ctl:Text ID="TIcboDCODE" runat="server" LangCode="TIcboDCODE" Description="업무구분 코드"></Ctl:Text></li>
                            <li><Ctl:Combo ID="IcboDCODE" runat="server" RepeatColumns="2" OnChange= "tree_Inquery()"></Ctl:Combo></li>
                        </ul>
                        <ul class="search">
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtPCODE" runat="server" LangCode="TItxtPCODE" Description="상위코드"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtPCODE" runat="server"></Ctl:TextBox></li>
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtCODE" runat="server" LangCode="TItxtCODE" Description="코드"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtCODE" runat="server"></Ctl:TextBox></li>
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtERPCODE" runat="server" LangCode="TItxtCODE" Description="ERP 코드"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtERPCODE" runat="server"></Ctl:TextBox></li>
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtSODR" runat="server" LangCode="TItxtSODR" Description="정렬"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtSODR" runat="server" SetType="Number"></Ctl:TextBox></li>
                        </ul>
                        <ul class="search">
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtCODTXT_KR" runat="server" LangCode="TItxtCODTXT_KR" Description="한국어"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtCODTXT_KR" runat="server"></Ctl:TextBox></li>
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtCODTXT_EN" runat="server" LangCode="TItxtCODTXT_EN" Description="영어"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtCODTXT_EN" runat="server"></Ctl:TextBox></li>
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtCODTXT_ZH" runat="server" LangCode="TItxtCODTXT_ZH" Description="중문"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtCODTXT_ZH" runat="server"></Ctl:TextBox></li>
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtCODTXT_RU" runat="server" LangCode="TItxtCODTXT_RU" Description="러시아"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtCODTXT_RU" runat="server"></Ctl:TextBox></li>
                        </ul>
                        <ul class="search">
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtCODEXT1" runat="server" LangCode="TItxtCODEXT1" Description="참조1"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtCODEXT1" runat="server"></Ctl:TextBox></li>
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtCODEXT2" runat="server" LangCode="TItxtCODEXT2" Description="참조2"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtCODEXT2" runat="server"></Ctl:TextBox></li>
                            <li style="min-width : 100px; margin-right"><Ctl:Text ID="TItxtCODEXT3" runat="server" LangCode="TItxtCODEXT3" Description="참조3"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtCODEXT3" runat="server"></Ctl:TextBox></li>
                        </ul>
                        <ul class="search">
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtCODEXTN1" runat="server" LangCode="TItxtCODEXTN1" Description="참조1(숫자)"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtCODEXTN1" runat="server" SetType="Number">0</Ctl:TextBox></li>
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtCODEXTN2" runat="server" LangCode="TItxtCODEXTN2" Description="참조2(숫자)"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtCODEXTN2" runat="server" SetType="Number">0</Ctl:TextBox></li>
                            <li style="min-width : 100px;"><Ctl:Text ID="TItxtCODEXTN3" runat="server" LangCode="TItxtCODEXTN3" Description="참조3(숫자)"></Ctl:Text></li>
                            <li><Ctl:TextBox ID="ItxtCODEXTN3" runat="server" SetType="Number">0</Ctl:TextBox></li>
                        </ul>
                        <ul class="search">
                            <li style="min-width : 100px;"><Ctl:Text ID="TIrdoUSEYN" runat="server" LangCode="TIrdoUSEYN" Description="사용여부"></Ctl:Text></li>
                            <li>
                                <Ctl:Radio ID="IrdoUSEYN" runat="server" RepeatColumns="2">
                                    <asp:ListItem Value="Y" Text="사용"></asp:ListItem>
                                    <asp:ListItem Value="N" Text="미사용"></asp:ListItem>
                                </Ctl:Radio>
                            </li>
                        </ul>
                    </td>
                </tr>
            </table>
            
        </Ctl:Layer>
    </div>
</asp:content>
