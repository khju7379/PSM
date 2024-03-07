<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebTree.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.WebTree" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            //샘플 DataSet Grid Bind
            var ht = new Object();
            grid99.Params(ht);
            grid99.BindList(1);

        }

        /************************************************************************
        함수명		: wtNAME1_click
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-04-27
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME1_click(o, s) {

        }

        /************************************************************************
        함수명		: wtNAME1_Loaded
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-04-27
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME1_Loaded() {

        }

        /************************************************************************
        함수명		: wtNAME2_Loaded
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-04-30
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME2_Loaded() {

        }

        /************************************************************************
        함수명		: wtNAME2_click
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-04-30
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME2_click(o, s) {

        }

        /************************************************************************
        함수명		: wtNAME13_click
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-04-30
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME13_click(o, s) {
            //o 마우스 이벤트
            // 선택 Node 정보

            alert(s.Item.Text);
        }

        /************************************************************************
        함수명		: wtNAME14_Loaded
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-04-30
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME14_Loaded() {
            wtNAME14.AllChildClose();
            return false;
        }

        /************************************************************************
        함수명		: wtNAME16_Loaded
        작성목적	: AllChildOpen() 테스트용 기본 세팅
        작 성 자	: 이정홍
        최초작성일	: 2018-05-02
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME16_Loaded() {
            wtNAME16.AllChildClose();
        }

        /************************************************************************
        함수명		: wtNAME17_Loaded
        작성목적	: AllSelectCancelItem() 테스트용 기본 세팅
        작 성 자	: 이정홍
        최초작성일	: 2018-05-02
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME17_Loaded() {
            setTimeout(function () {
                var node = wtNAME17.FindItem("2");  // 선택할 Node의 IDX값
                node.SelNode.checked = true;
                node.TreeView.SelectItem(node);
            }, 1000);
        }

        /************************************************************************
        함수명		: wtNAME19_click
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-05-02
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME19_click(o, s) {
            s.Item.ChildClose();
        }

        /************************************************************************
        함수명		: wtNAME20_click
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-05-02
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME20_click(o, s) {
            s.Item.ChildOpen();
        }

        /************************************************************************
        함수명		: wtNAME20_Loaded
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-05-02
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME20_Loaded() {
            wtNAME20.AllChildClose();
        }

        /************************************************************************
        함수명		: wtNAME23_click
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-05-02
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME23_click(o, s) {
            wtNAME23.SelectCancelItem(s.Item);
            alert(s.Item);
        }

        /************************************************************************
        함수명		: btn1_Click
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-04-30
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function btn1_Click() {
            wtNAME14.BindTree("wtNAME14");
        }

        /************************************************************************
        함수명		: btn5_Click
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-05-02
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function btn5_Click() {
            var ht = new Object();
            ht["IDX"] = 1;

            wtNAME18.Params(ht);
            wtNAME18.BindTree('wtNAME18');
        }

        /************************************************************************
        함수명		: btn7_Click
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-05-02
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function btn7_Click() {
            var idx = "7";
            var node = wtNAME22.FindItem(idx); // 선택할 Node의 IDX값
            // 해당 컨트롤의 Node 체크
            node.SelNode.checked= true; //선택한 Node 체크
            node.TreeView.SelectItem(node); //선택한 Node 선택
        }
                
        /************************************************************************
        함수명		: wtNAME99_Loaded
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-04-30
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME99_Loaded() {

        }

        /************************************************************************
        함수명		: wtNAME99_click
        작성목적	: 
        작 성 자	: 이정홍
        최초작성일	: 2018-04-30
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function wtNAME99_click(o, s) {
            //o 마우스 이벤트
        // 선택 아이템 정보
            alert(s.Item.Text);
            // s.Item.Text
            // s.Item.Name
            // s.Item.Values.length
            // s.Item.Values[0]
        }


        /************************************************************************
        함수명		: fn_Redirect
        작성목적	: 해당 페이지로 이동한다.
        작 성 자	: 이정홍
        최초작성일	: 2018-04-27
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function fn_Redirect(url) {
            /* 작업중인 페이지는 접근 차단 */
            if (url == "ChartFxScript" || url == "FlipSwitch" || url == "WebSheet" || url == "WebTree") {
                alert('<Ctl:Text ID="MSG09" runat="server" LangCode="MSG09" Description="해당 페이지는 업데이트 예정입니다." Literal="true"></Ctl:Text>');
                return false;
            }
            self.location.href = "/WebTemplate/ControlSample/" + url + ".aspx";
            return false;
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / WebTree
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="WebTree Control Sample" Literal="true"></Ctl:Text></h4>

        <div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
        </div>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <!-- 메인버튼 -->
        <div style="text-align: right;margin-bottom:15px;">
            <Ctl:Button ID="btn99" runat="server" Description="메인으로" Hidden="false" LangCode="TXT99" OnClientClick="fn_Redirect('Index');"></Ctl:Button>
        </div>

        <!--기본샘플-->
        <Ctl:Layer ID="layer1" runat="server" Title="WebTree Control 기본샘플" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="15%" />
                    <col width="50%" />
                    <col width="35%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT10" runat="server" LangCode="TXT10" Description="구분"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="결과물"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT11" runat="server" LangCode="TXT11" Description="
                        aspx 페이지 작성
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="
                        &#60Ctl:WebTree ID=&#34;wtNAME1&#34; runat=&#34;server&#34; CheckBox=&#34;false&#34;<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp; Description=&#34;WebTree 제목 설명&#34; HideTitle=&#34;false&#34; IndexBindFiledName=&#34;IDX&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp; MethodName=&#34;GetTreeTemplate&#34; ParentBindFieldName=&#34;PRTIDX&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp; TextBindFieldName=&#34;TEXT&#34; TypeName=&#34;Template.TemplateBiz&#34; Width=&#34;300&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp; OnClick=&#34;wtNAME1_click&#34; OnLoaded=&#34;wtNAME1_Loaded&#34;/&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME1" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" OnClick="wtNAME1_click" OnLoaded="wtNAME1_Loaded"/>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT12" runat="server" LangCode="TXT12" Description="
                        cs 페이지 작성
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT09" runat="server" LangCode="TXT09" Description="
                        &#60Ctl:WebTree ID=&#34;wtNAME2&#34; runat=&#34;server&#34; /&#62
                        <br/><br/>
                        <p style='display:inline;color:Green;'> /* WebTree.aspx.cs 에 작성 */ </p><br />
                        protected override void OnLangInit(EventArgs e)<br />
                        {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.CheckBox = false;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.Description = &#34;WebTree 제목 설명&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.HideTitle = false;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.IndexBindFiledName = &#34;IDX&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.MethodName = &#34;GetTreeTemplate&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;Hashtable ht = new Hashtable();<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;ht[&#34;IDX&#34;] = 0;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.param = ht;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.ParentBindFieldName = &#34;PRTIDX&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.TextBindFieldName = &#34;TEXT&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.TypeName =&#34;Template.TemplateBiz&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.Width=300;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.OnClick = &#34;wtNAME2_click&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME2.OnLoaded = &#34;wtNAME2_Loaded&#34;;<br />
                        }
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME2" runat="server" />
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="WebTree Control 샘플 DataSet" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="17%" />
                    <col width="13%" />
                    <col width="70%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT04" runat="server" LangCode="TXT04" Description="TypeName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT05" runat="server" LangCode="TXT05" Description="MethodName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="DataSet"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="Template.TemplateBiz"></Ctl:Text>
                    </td>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT08" runat="server" LangCode="TXT08" Description="GetTreeTemplate"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid99" runat="server" Paging="false" CheckBox="false" Width="100%" TypeName="Template.TemplateBiz" MethodName="GetTreeTemplate">
                            <Ctl:SheetField DataField="IDX" TextField="IDX" Description="IDX" Width="90"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="TEXT" TextField="TEXT" Description="TEXT" Width="80"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="VALUE" TextField="VALUE" Description="VALUE" Width="160"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="PRTIDX" TextField="PRTIDX" Description="PRTIDX" Width="140"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="URL" TextField="URL" Description="URL" Width="60"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="GLEVEL" TextField="GLEVEL" Description="GLEVEL" Width="70"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="SORT" TextField="SORT" Description="SORT" Width="60"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties List-->
        <Ctl:Layer ID="layer3" runat="server" Title="WebTree Control Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT50" runat="server" LangCode="TXT50" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT51" runat="server" LangCode="TXT51" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT207"><Ctl:Text ID="TXT52" runat="server" LangCode="TXT52" Description="CheckBox" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT53" runat="server" LangCode="TXT53" Description="- 해당 컨트롤의 트리 체크박스 표시여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT211"><Ctl:Text ID="TXT56" runat="server" LangCode="TXT56" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT57" runat="server" LangCode="TXT57" Description="- 해당 컨트롤의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT215"><Ctl:Text ID="TXT60" runat="server" LangCode="TXT60" Description="HideTitle" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT61" runat="server" LangCode="TXT61" Description="- 해당 컨트롤의 트리 제목 숨김여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT63"><Ctl:Text ID="TXT62" runat="server" LangCode="TXT62" Description="IndexBindFiledName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT63" runat="server" LangCode="TXT63" Description="- 해당 컨트롤의 Index Field용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT223"><Ctl:Text ID="TXT64" runat="server" LangCode="TXT64" Description="MethodName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT65" runat="server" LangCode="TXT65" Description="- 해당 컨트롤의 Biz의 메소드명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT227"><Ctl:Text ID="TXT76" runat="server" LangCode="TXT76" Description="param" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT77" runat="server" LangCode="TXT77" Description="- 해당의 컨트롤의 Biz에 넘겨줄 파라미터"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT231"><Ctl:Text ID="TXT66" runat="server" LangCode="TXT66" Description="ParentBindFieldName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT67" runat="server" LangCode="TXT67" Description="- 해당 컨트롤의 Parent Index Field용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT235"><Ctl:Text ID="TXT68" runat="server" LangCode="TXT68" Description="TextBindFieldName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT69" runat="server" LangCode="TXT69" Description="- 해당 컨트롤의 TextField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT239"><Ctl:Text ID="TXT72" runat="server" LangCode="TXT72" Description="TypeName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT73" runat="server" LangCode="TXT73" Description="- 해당 컨트롤의 Biz명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT243"><Ctl:Text ID="TXT74" runat="server" LangCode="TXT74" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT75" runat="server" LangCode="TXT75" Description="- 해당 컨트롤의 너비"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events List-->
        <Ctl:Layer ID="layer4" runat="server" Title="WebTree Control Events" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT100" runat="server" LangCode="TXT100" Description="Events"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT101" runat="server" LangCode="TXT101" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT257"><Ctl:Text ID="TXT102" runat="server" LangCode="TXT102" Description="OnClick" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT103" runat="server" LangCode="TXT103" Description="- 해당 컨트롤 Node 클릭 시 발생할 스크립트 이벤트"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT261"><Ctl:Text ID="TXT104" runat="server" LangCode="TXT104" Description="OnLoaded<br/><p style='display:inline;color:red;'>(페이지 로드시 2번실행.수정예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT105" runat="server" LangCode="TXT105" Description="- 해당 컨트롤 로드 후 발생할 스크립트 이벤트"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="WebTree Control Functions" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT106" runat="server" LangCode="TXT106" Description="Functions"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT107" runat="server" LangCode="TXT107" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT307"><Ctl:Text ID="TXT108" runat="server" LangCode="TXT108" Description="AllChildClose()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT109" runat="server" LangCode="TXT109" Description="- 해당 컨트롤의 모든 Node 하위 닫기"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT311"><Ctl:Text ID="TXT110" runat="server" LangCode="TXT110" Description="AllChildOpen()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT111" runat="server" LangCode="TXT111" Description="- 해당 컨트롤의 모든 Node 하위 열기"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT315"><Ctl:Text ID="TXT112" runat="server" LangCode="TXT112" Description="AllSelectCancelItem()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT113" runat="server" LangCode="TXT113" Description="- 해당 컨트롤의 전체 체크 해제"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT319"><Ctl:Text ID="TXT114" runat="server" LangCode="TXT114" Description="BindTree()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT115" runat="server" LangCode="TXT115" Description="- 해당 컨트롤 트리 데이터 바인딩"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT323"><Ctl:Text ID="TXT116" runat="server" LangCode="TXT116" Description="ChildClose()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT117" runat="server" LangCode="TXT117" Description="- 해당 컨트롤의 선택 Node 하위 닫기"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT327"><Ctl:Text ID="TXT118" runat="server" LangCode="TXT118" Description="ChildOpen()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT119" runat="server" LangCode="TXT119" Description="- 해당 컨트롤의 선택 Node 하위 열기"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT331"><Ctl:Text ID="TXT120" runat="server" LangCode="TXT120" Description="Clear()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT121" runat="server" LangCode="TXT121" Description="- 해당 컨트롤의 트리 초기화"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT335"><Ctl:Text ID="TXT124" runat="server" LangCode="TXT124" Description="FindItem()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT125" runat="server" LangCode="TXT125" Description="- 해당 컨트롤의 특정 Node 찾기(체크, 선택)"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer6" runat="server" Title="WebTree Control Properties Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT201" runat="server" LangCode="TXT201" Description="Properties"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT202" runat="server" LangCode="TXT202" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT203" runat="server" LangCode="TXT203" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT204" runat="server" LangCode="TXT204" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT205" runat="server" LangCode="TXT205" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT53"><Ctl:Text ID="TXT206" runat="server" LangCode="TXT206" Description="CheckBox" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT207" runat="server" LangCode="TXT207" Description="- 해당 컨트롤의 트리 체크박스 표시여부" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT208" runat="server" LangCode="TXT208" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CheckBox 에는 trur | false 값을 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT209" runat="server" LangCode="TXT209" Description="
                        <p style='display:inline;color:blue;'>CheckBox=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME3" runat="server" CheckBox="true" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT57"><Ctl:Text ID="TXT210" runat="server" LangCode="TXT210" Description="Description" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT211" runat="server" LangCode="TXT211" Description="- 해당 컨트롤의 설명" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT212" runat="server" LangCode="TXT212" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 타이틀에 Text를 표시한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Description에는 string 값을 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT213" runat="server" LangCode="TXT213" Description="
                        <p style='display:inline;color:blue;'>Description=&#34;WebTree 제목 설명&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME4" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT61"><Ctl:Text ID="TXT214" runat="server" LangCode="TXT214" Description="HideTitle" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT215" runat="server" LangCode="TXT215" Description="- 해당 컨트롤의 트리 제목 숨김여부" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT216" runat="server" LangCode="TXT216" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; HideTitle에는 true | false 값을 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT217" runat="server" LangCode="TXT217" Description="
                        <p style='display:inline;color:blue;'>HideTitle=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME5" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="true" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT61"><Ctl:Text ID="TXT218" runat="server" LangCode="TXT218" Description="IndexBindFiledName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT219" runat="server" LangCode="TXT219" Description="- 해당 컨트롤의 Index Field용 칼럼" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT220" runat="server" LangCode="TXT220" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; IndexBindFiledName 의 기본값은 &#34;IDX&#34; 이다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Node는 Parent Index Field 의 Value와 같은 Index Field 를 Value를 가진 Node 아래에 위치한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT221" runat="server" LangCode="TXT221" Description="
                        <p style='display:inline;color:blue;'>IndexBindFiledName=&#34;PRTIDX&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME6" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="PRTIDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT65"><Ctl:Text ID="TXT222" runat="server" LangCode="TXT222" Description="MethodName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT223" runat="server" LangCode="TXT223" Description="- 해당 컨트롤의 Biz의 메소드명" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT224" runat="server" LangCode="TXT224" Description="
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT225" runat="server" LangCode="TXT225" Description="
                        <p style='display:inline;color:blue;'>MethodName=&#34;GetTreeTemplate&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME7" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT77"><Ctl:Text ID="TXT226" runat="server" LangCode="TXT226" Description="param" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT227" runat="server" LangCode="TXT227" Description="- 해당의 컨트롤의 Biz에 넘겨줄 파라미터" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT228" runat="server" LangCode="TXT228" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; param 속성은 cs 페이지에서 사용하거나 스크립트에서 Params() 로 대체하여 사용한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; param 는 Hashtable 값을 사용한다.
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT229" runat="server" LangCode="TXT229" Description="
                        <p style='display:inline;color:Green;'> /* WebTree.aspx.cs 에 작성 */ </p><br/>
                        Hashtable ht2 = new Hashtable();<br />
                        ht2[&#34;IDX&#34;] = 1;<br />
                        <p style='display:inline;color:Blue;'>wtNAME8.param = ht2;</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME8" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT67"><Ctl:Text ID="TXT230" runat="server" LangCode="TXT230" Description="ParentBindFieldName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT231" runat="server" LangCode="TXT231" Description="- 해당 컨트롤의 Parent Index Field용 칼럼" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT232" runat="server" LangCode="TXT232" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ParentBindFieldName의 기본값은 &#34;PRTIDX&#34; 이다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Node는 Parent Index Field 의 Value와 같은 Index Field 를 Value를 가진 Node 아래에 위치한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT233" runat="server" LangCode="TXT233" Description="
                        <p style='display:inline;color:blue;'>ParentBindFieldName=&#34;IDX&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME9" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="IDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT69"><Ctl:Text ID="TXT234" runat="server" LangCode="TXT234" Description="TextBindFieldName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT235" runat="server" LangCode="TXT235" Description="- 해당 컨트롤의 TextField용 칼럼" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT236" runat="server" LangCode="TXT236" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; TextBindFieldName 기본값은 &#34;TEXT&#34; 이다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT237" runat="server" LangCode="TXT237" Description="
                        <p style='display:inline;color:blue;'>TextBindFieldName=&#34;IDX&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME10" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="IDX" TypeName="Template.TemplateBiz" Width="300" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT73"><Ctl:Text ID="TXT238" runat="server" LangCode="TXT238" Description="TypeName" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT239" runat="server" LangCode="TXT239" Description="- 해당 컨트롤의 Biz명" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT240" runat="server" LangCode="TXT240" Description="
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT241" runat="server" LangCode="TXT241" Description="
                        <p style='display:inline;color:blue;'>TypeName=&#34;Template.TemplateBiz&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME11" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT75"><Ctl:Text ID="TXT242" runat="server" LangCode="TXT242" Description="Width" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT243" runat="server" LangCode="TXT243" Description="- 해당 컨트롤의 너비" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT244" runat="server" LangCode="TXT244" Description="
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT245" runat="server" LangCode="TXT245" Description="
                        <p style='display:inline;color:blue;'>width=&#34;100&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME12" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="100" />
                    </td>
                </tr>
            </table>
        </Ctl:Layer>


        <!--Events Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="WebTree Control Events Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT251" runat="server" LangCode="TXT251" Description="Events"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT252" runat="server" LangCode="TXT252" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT253" runat="server" LangCode="TXT253" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT254" runat="server" LangCode="TXT254" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT255" runat="server" LangCode="TXT255" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT103"><Ctl:Text ID="TXT256" runat="server" LangCode="TXT256" Description="OnClick" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT257" runat="server" LangCode="TXT257" Description="- 해당 컨트롤 Node 클릭 시 발생할 스크립트 이벤트" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT258" runat="server" LangCode="TXT258" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤 Node 클릭 시 OnClick에 있는 스크립트를 호출한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 스크립트 정의 시 wtNAME13_click(o, s) 형태로 정의한다.(o : 마우스 이벤트 , s : 선택 Node 정보)
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT259" runat="server" LangCode="TXT259" Description="
                        <p style='display:inline;color:blue;'>OnClick=&#34;wtNAME13_click&#34;</p>
                        <br /><br />
                        function wtNAME13_click(o, s) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* o : 마우스 이벤트, s : 선택 Node 정보 */ </p><br />
                            <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;alert(s.Item.Text);<br />
                        }
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME13" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" OnClick="wtNAME13_click" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT105"><Ctl:Text ID="TXT260" runat="server" LangCode="TXT260" Description="OnLoaded<br/><p style='display:inline;color:red;'>(페이지 로드시 2번실행.수정예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT261" runat="server" LangCode="TXT261" Description="- 해당 컨트롤 로드 후 발생할 스크립트 이벤트" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT262" runat="server" LangCode="TXT262" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤 로드 후 OnLoaded에 있는 스크립트를 호출한다.
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT263" runat="server" LangCode="TXT263" Description="
                        <p style='display:inline;color:blue;'>OnLoaded=&#34;wtNAME14_Loaded&#34;</p>
                        <br /><br />
                        function wtNAME14_Loaded() {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME14.AllChildClose(); <p style='display:inline;color:Green;'>/* 해당 컨트롤의 모든 Node 하위 닫기 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;return false;<br />
                        }
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME14" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" OnLoaded="wtNAME14_Loaded" />
                        <div style="margin-top:10px;margin-bottom:10px;">
                            <Ctl:Button ID="btn1" runat="server" LangCode="btn1" Description="BindTree()" OnClientClick="btn1_Click();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="WebTree Control Functions Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT301" runat="server" LangCode="TXT301" Description="Functions"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT302" runat="server" LangCode="TXT302" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT303" runat="server" LangCode="TXT303" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT304" runat="server" LangCode="TXT304" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT305" runat="server" LangCode="TXT305" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT109"><Ctl:Text ID="TXT306" runat="server" LangCode="TXT306" Description="AllChildClose()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT307" runat="server" LangCode="TXT307" Description="- 해당 컨트롤의 모든 Node 하위 닫기" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT308" runat="server" LangCode="TXT308" Description="
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT309" runat="server" LangCode="TXT309" Description="
                        <p style='display:inline;color:blue;'>wtNAME15.AllChildClose();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME15" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                        <div style="margin-top:10px;margin-bottom:10px;">
                            <Ctl:Button ID="btn2" runat="server" LangCode="btn2" Description="AllChildClose()" OnClientClick="wtNAME15.AllChildClose();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT111"><Ctl:Text ID="TXT310" runat="server" LangCode="TXT310" Description="AllChildOpen()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT311" runat="server" LangCode="TXT311" Description="- 해당 컨트롤의 모든 Node 하위 열기" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT312" runat="server" LangCode="TXT312" Description="
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT313" runat="server" LangCode="TXT313" Description="
                        <p style='display:inline;color:blue;'>wtNAME16.AllChildOpen();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME16" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" OnLoaded="wtNAME16_Loaded" />
                        <div style="margin-top:10px;margin-bottom:10px;">
                            <Ctl:Button ID="btn3" runat="server" LangCode="btn3" Description="AllChildOpen()" OnClientClick="wtNAME16.AllChildOpen();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT113"><Ctl:Text ID="TXT314" runat="server" LangCode="TXT314" Description="AllSelectCancelItem()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT315" runat="server" LangCode="TXT315" Description="- 해당 컨트롤의 전체 체크 해제" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT316" runat="server" LangCode="TXT316" Description="
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT317" runat="server" LangCode="TXT317" Description="
                        <p style='display:inline;color:blue;'>wtNAME17.AllSelectCancelItem();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME17" runat="server" CheckBox="true" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" OnLoaded="wtNAME17_Loaded" />
                        <div style="margin-top:10px;margin-bottom:10px;">
                            <Ctl:Button ID="btn4" runat="server" LangCode="btn4" Description="AllSelectCancelItem()" OnClientClick="wtNAME17.AllSelectCancelItem();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT115"><Ctl:Text ID="TXT318" runat="server" LangCode="TXT318" Description="BindTree()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT319" runat="server" LangCode="TXT319" Description="- 해당 컨트롤 트리 데이터 바인딩" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT320" runat="server" LangCode="TXT320" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).BindTree(&#34;(컨트롤ID)&#34;); 형식으로 사용한다.
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT321" runat="server" LangCode="TXT321" Description="
                        function btn5_Click() {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;var ht = new Object();<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;ht[&#34;IDX&#34;] = 1;<br />
                            <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;wtNAME18.Params(ht); <p style='display:inline;color:Green;'>/* 스크립트에서 파라미터 추가시 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:blue;'>wtNAME18.BindTree(&#34;wtNAME18&#34;);</p><br />
                        }
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME18" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                        <div style="margin-top:10px;margin-bottom:10px;">
                            <Ctl:Button ID="btn5" runat="server" LangCode="btn5" Description="btn5" OnClientClick="btn5_Click();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT117"><Ctl:Text ID="TXT322" runat="server" LangCode="TXT322" Description="ChildClose()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT323" runat="server" LangCode="TXT323" Description="- 해당 컨트롤의 선택 Node 하위 닫기" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT324" runat="server" LangCode="TXT324" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 OnClick 에서 사용한다.
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT325" runat="server" LangCode="TXT325" Description="
                        function wtNAME19_click(o, s) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:blue;'>s.Item.ChildClose();</p><br />
                        }
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME19" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" OnClick="wtNAME19_click" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT119"><Ctl:Text ID="TXT326" runat="server" LangCode="TXT326" Description="ChildOpen()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT327" runat="server" LangCode="TXT327" Description="- 해당 컨트롤의 선택 Node 하위 열기" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT328" runat="server" LangCode="TXT328" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 컨트롤의 OnClick 에서 사용한다.
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT329" runat="server" LangCode="TXT329" Description="
                        function wtNAME20_click(o, s) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:blue;'>s.Item.ChildOpen();</p><br />
                        }
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME20" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" OnClick="wtNAME20_click" OnLoaded="wtNAME20_Loaded" />
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT121"><Ctl:Text ID="TXT330" runat="server" LangCode="TXT330" Description="Clear()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT331" runat="server" LangCode="TXT331" Description="- 해당 컨트롤의 트리 초기화" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT332" runat="server" LangCode="TXT332" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).Clear(&#34;(컨트롤ID)&#34;); 형식으로 사용한다.
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT333" runat="server" LangCode="TXT333" Description="
                        <p style='display:inline;color:blue;'>wtNAME21.Clear(&#34;wtNAME21&#34;);</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME21" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                        <div style="margin-top:10px;margin-bottom:10px;">
                            <Ctl:Button ID="btn6" runat="server" LangCode="btn6" Description="Clear()" OnClientClick="wtNAME21.Clear('wtNAME21');"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT125"><Ctl:Text ID="TXT334" runat="server" LangCode="TXT334" Description="FindItem()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT335" runat="server" LangCode="TXT335" Description="- 해당 컨트롤의 특정 Node 찾기(체크, 선택)" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT336" runat="server" LangCode="TXT336" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; var node = (컨트롤ID).FindItem(IDX값); 로 특정 Node를 정의한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; node.SelNode.checked = true; 로 체크한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; node.TreeView.SelectItem(node); 로 선택한다.
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT337" runat="server" LangCode="TXT337" Description="
                        function btn7_Click() {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;var idx = &#34;7&#34;; <p style='display:inline;color:Green;'>/* 선택할 Node의 IDX값 */</p><br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;var node = <p style='display:inline;color:blue;'>wtNAME22.FindItem(idx)</p>; <p style='display:inline;color:Green;'>/* 선택할 Node */</p><br />
                            <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:blue;'>node.SelNode.checked</p> = true; <p style='display:inline;color:Green;'>/* 선택한 Node 체크 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:blue;'>node.TreeView.SelectItem(node);</p> <p style='display:inline;color:Green;'>/* 선택한 Node 선택 */</p><br />
                        }
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME22" runat="server" CheckBox="true" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                        <div style="margin-top:10px;margin-bottom:10px;">
                            <Ctl:Button ID="btn7" runat="server" LangCode="btn7" Description="btn7" OnClientClick="btn7_Click();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>