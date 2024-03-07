<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSP1091.aspx.cs" Inherits="TaeYoung.Portal.PSM.POP.PSP1091" %>


<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _CDINDEX = "";

        // 페이지 로드
        function OnLoad() {

            var CODE = "<%= Request.QueryString["CODE"] %>";

            var data = CODE.split('^');

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            _CDINDEX = data[0];

            ht["CDINDEX"] = data[0];
            ht["CDCODE"] = data[1];

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridIndex.CallBack = function () {

                var dt = gridIndex.GetAllRow();
                var grd_chk = document.getElementsByName("gridIndex_chk");

                for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                    var dr = dt.Rows[i];

                    if (dr["CHK"] == "Y") {
                        grd_chk[i].checked = true;
                    }
                }
            };
        }

        // 선택 버튼
        function btnChoice_Click() {

            var checkRows = gridIndex.GetCheckRow();
            var cdcode = "";
            var cdname = "";

            if (checkRows.length > 0) {

                for (i = 0; i < checkRows.length; i++) {
                    if (i == 0) {
                        cdcode = checkRows[i]['CODE'];
                        cdname = checkRows[i]['NAME'];
                    }
                    else {
                        cdcode = cdcode + "," + checkRows[i]['CODE'];
                        cdname = cdname + ", " + checkRows[i]['NAME'];
                    }
                }
            }
            
            if (_CDINDEX == "SA") {
                if (opener) {
                    opener.Popup_SACODE_Callback(cdcode, cdname);
                    self.close();
                }
                else {
                    alert("대상이 없습니다.");
                }
            }
            else if (_CDINDEX == "TO") {
                if (opener) {
                    opener.Popup_TOCODE_Callback(cdcode, cdname);
                    self.close();
                }
                else {
                    alert("대상이 없습니다.");
                }
            }s
        }

        // 닫기 버튼
        function btnClose_Click() {

            this.close();            
        }

    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="코드조회" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
            <Ctl:Button ID="btnChoice" runat="server" Style="Orange" LangCode="btnChoice" Description="선택" OnClientClick="btnChoice_Click();"></Ctl:Button>
            <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>                        
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server">
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="true" Width="100%" HFixation="true" Height="420" TypeName="PSM.PSM1090" MethodName="UP_GET_SACODE_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20" >
                <Ctl:SheetField DataField="CODE" TextField="코드" Description="코드" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="" />
                <Ctl:SheetField DataField="NAME" TextField="코드명" Description="코드명" Width="*"  HAlign="center" Align="left"  runat="server" OnClick="" />
                <Ctl:SheetField DataField="CHK" TextField="체크여부" Description="체크여부" Width="0"  HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true"/>
            </Ctl:WebSheet>  
		</Ctl:Layer>
	</div>
</asp:content>
