<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Template01.aspx.cs" Inherits="TaeYoung.WebTemplate.Template01" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">
        var siteCompanyCode = "";
        var a = "<%= TaeYoung.Biz.Document.UserInfo.UserName %>";
        var regid = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";

        function OnLoad() {
            test();
            //document.getElementById("")

            //$("#txtDate").val();

            var a = txtDate.GetValue();

            a = "10101010";

            txtDate.SetValue(a);


            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            // CurrentPageIndex 및 PageSize값은 자동으로 입력되며 필요시 선언하여 넣을수 있다. (Biz에서 해당 항목은 반드시 정의해줘야함)
            // 페이지 갯수 변경 예제 ( 기본 10개 )
            ht["PageSize"] = "10";
            ht["a"] = "1";
            ht["b"] = "2";

            grid1.Params(ht); // 선언한 파라미터를 그리드에 전달함
            //grid1.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            // 바인딩 이후 처리사항
            grid1.CallBack = function () {
                // 바인딩된 값을 가져오는 예제
                var ht = grid1.GetRow(0); // 첫번째 row의 값 return
                // 전체데이터
                var ht2 = grid1.GetAllRow();
                // alert(ht2.Rows[0]["IDX"]);
                //그리드 컬럼 값 수정방법
                grid1.SetValue("0", "IDX", "값수정"); // 두번쨰 row중 IDX항목의 값을 '값수정'으로 변경
                //grid1.SetColor("0", "IDX", "#FF00FF");
            };

            // 그리드가 편집모드일시 값수정후 이벤트
            grid1.AutoSaveTarget = function (r, c) {// row,cell
                var ht = grid1.GetRow(r); // 수정한 row의 값을 가져온다.
                alert("값변경:" + r + "," + c);
            };

            // 스크립트에서 다국어 코드 호출방법
            //GetLangCode("TEST0003", "ko", function (e) {
            //    alert(e);
            //});

            // 차트 데이터 바인딩
            PageMethods.InvokeServiceTable(ht, "Template.TemplateBiz", "GetChart", function (e) {
                var ds = eval(e);
                // 컬럼정보를 가져온다
                var keys = Object.keys(ds.Tables[0].Rows[0]);
                // 바인딩할 데이터를 가져온다
                var datas = Object.values(ds.Tables[0].Rows[0]);

                var datas2 = ChartDataConvert(ds.Tables[0].Rows);

                var tmp = ['1번', '2번', '3번', '4번', '5번' ];

                // 차트 컨트롤 선언
                var bar = new RGraph.Bar({
                    id: 'cvs',
                    data: datas2,
                    options: {
                        labels: keys,
                        colors: ['#ddf', '#dd0'],
                        ylabels: false,
                        backgroundGridVlines: false,
                        backgroundGridBorder: false,
                        textSize: 14,
                        strokestyle: 'rgba(0,0,0,0)'
                    }
                }).grow();

                var line = new RGraph.Line({
                    id: 'cvs',
                    data: datas,
                    options: {
                        spline: true,
                        shadow: true,
                        tickmarks: 'endsquare',
                        backgroundGridVlines: false,
                        backgroundGridBorder: false,
                        textSize: 14,
                        tooltips: keys
                    }
                });


                line.set('hmargin', (line.canvas.width - line.get('gutterLeft') - line.get('gutterRight')) / (bar.data.length * 2)).trace2({ frames: 30 });

                var pie = new RGraph.Pie({
                    id: 'cvs2',
                    data: datas,
                    options: {
                        tooltips: keys,
                        labels: keys,
                        labelsSticksList: true,
                        shadow: false,
                        strokestyle: 'rgba(0,0,0,0)',
                        exploded: 0
                    }
                }).roundRobin();

                // 차트 컨트롤 선언
                var bar = new RGraph.Bar({
                    id: 'cvs3',
                    data: datas,
                    options: {
                        labels: keys,
                        colors: ['#ddf'],
                        ylabels: false,
                        backgroundGridVlines: false,
                        backgroundGridBorder: false,
                        textSize: 14,
                        strokestyle: 'rgba(0,0,0,0)'
                    }
                }).grow();

            }, function (e) {
                // Biz 연결오류
            });
        }

        function btn1_Click() {
            //alert("1번클릭");

            //alert(txtDate.GetValue());

            //txtDate.SetValue("20202020");

            //grid1.ExcelDownload("파일명");

            alert($("#txtDate").val());
            txtDate.GetValue();
        }

        function btn2_Click() {
            //alert("2번클릭");
            var ht = new Object();
            ht["TEST"] = "1";
            PageMethods.InvokeServiceTable(ht, "Template.TemplateBiz", "GetTest", function (e) {
                var ds = eval(e)

                var a = ds.Tables[0].Rows[0]["TEST"];

                alert(a);
            }, function (e) {
                // Biz 연결오류
            });
        }

        function Grid1RowClick(r, c) {
            var a = grid1.GetRow(r)["ROWNO"]

            alert(a);

            //var dt = grid1.GetRow(r);

            //ShowPopup("Templete01V.aspx?Mode=r&IDX=" + dt["IDX"], "템플릿조회", 1024, 750);

            return false;
        }

        function btnAddTemplete_Click() {
            ShowPopup("Templete01V.aspx", "템플릿입력", 1024, 750);
            return false;
        }

        // SearchView Jquery 확장
        //$.fn.extend({
        //    SearchView: function () {
        //        $(this).text("123");
        //    }
        //});

        //        $.widget("ui.SearchView", {
        //            options: { key: "svTest" },

        //            _create:function(){
        //                // 커스텀 위젯 코드 안에서는 위젯의 element를
        //                // this.element로 위젯의 옵션을 this.options로
        //                // 접근할 수 있다.
        //                //if( this.options.hidden ){
        //                //    this.element.hide();
        //                //}
        //                $(this.element).html("123")
        //            },
        //        });

        //        $(document).ready(function () {
        //            $("#svTest").SearchView();
        //        });


        function grid3_RowAdd() {

            grid3.InsertRow();

            return false;

           
        }

        function grid3_RemoveAdd() {
            //grid3.RemoveRows({0});
            return false;
        }

        function btn3_Click() {
            ValidationCheck();// 페이지의 유효성검사(컨트롤이 Validation = true 인 값들의 공백체크)
        }

        // 탭 변경이 발생 이벤트 (필요시 추가해준다)
        function TabChanged(e) {
            // e : 탭 순서
            alert("탭변경");
        }

        function test() {
            //AndroidFunction.showToast($("body").height());
        }

        function fnCalendar_Changed() {
            alert("aaa");
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4><Ctl:Text ID="Text14" runat="server" LangCode="TXT01" Description="<h4>컨트롤 확인페이지</h4>"></Ctl:Text></h4>

        <div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btn1" runat="server" LangCode="TXT02" Description="첫번째" OnClientClick="btn1_Click();"></Ctl:Button>
            <Ctl:Button ID="btn2" runat="server" LangCode="btn2" Description="두번쨰" OnClientClick="btn2_Click();"></Ctl:Button>
            <Ctl:Button ID="btn3" runat="server" LangCode="btn3" Description="유효성검사" OnClientClick="btn3_Click();"></Ctl:Button>
        </div>
        <div class="clear"></div>
    </div>

    <!--//타이틀끝-->
      		
    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="10%" />
                    <col width="40%" />
                    <col width="10%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        달력 (Fr~To)
                        <%--<Ctl:Text ID="tCalenderFT" runat="server" LangCode="tCalenderFT" Description="달력 (Fr~To)" Required="true"></Ctl:Text>--%>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtFRDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox> ~
                        <Ctl:TextBox ID="txtTODate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar_FrTo" CalendarGroup="GRP01"></Ctl:TextBox>
                    </td>
                    <th>
                        <%--<Ctl:Text ID="tRating" runat="server" LangCode="tRating" Description="별점" Required="true"></Ctl:Text>--%>
                        사용자조회
                    </th>
                    <td>
                        <%--<Ctl:Rating ID="ratSTAR" runat="server" ItemCount="10" Gap="Half" />--%>
                        <a onclick="OrgPopup('<%= TaeYoung.Biz.Document.UserInfo.EmpID %>','<%= TaeYoung.Biz.Document.UserInfo.CompanyCode %>',true);"><%= TaeYoung.Biz.Document.UserInfo.UserName %></a>
                    </td>
                </tr>
                <tr>
                    <th>
                        <%--Required 가 true일시 문자 옆에 오렌지색 * 가 나타남--%>
                        <Ctl:Text ID="tCalender" runat="server" LangCode="tCalender" Description="달력" Required="true"></Ctl:Text>
                    </th>
                    <td>
                        <%--SetCalendarFormat 에 따른 날자형태 변경--%>
                        <Ctl:TextBox ID="txtDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" OnCalendarChanged="fnCalendar_Changed" Validation="true"></Ctl:TextBox> 
                        <Ctl:TextBox ID="txtDate2" runat="server" SetCalendarFormat="YYYYMM" SetType="Calendar"></Ctl:TextBox>
                        <Ctl:TextBox ID="txtDate3" runat="server" SetCalendarFormat="YYYY" SetType="Calendar"></Ctl:TextBox>
                        
                        <%--<Ctl:TimePicker ID="timeTest" runat="server"></Ctl:TimePicker>--%>
                    </td>
                    <th>
                        <Ctl:Text ID="tNumber" runat="server" LangCode="tNumber" Description="숫자"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtNumber" runat="server" SetType="Number" Validation="true"></Ctl:TextBox><br />
                    </td>
                </tr>
                <tr>
                    <th>
                        숫자에 콤마
                    </th>
                    <td>
                        <Ctl:TextBox ID="TextBox1" runat="server" SetType="NumberComma" Validation="true"></Ctl:TextBox><br />
                    </td>
                    <th>
                        백분율
                    </th>
                    <td>
                        <Ctl:TextBox ID="TextBox2" runat="server" SetType="Percent" Width="40"></Ctl:TextBox><br />
                    </td>
                </tr>
                <tr>
                    <th>
                        일반적인 텍스트박스
                    </th>
                    <td>
                        <Ctl:TextBox ID="TextBox5" runat="server" SetType="Text"></Ctl:TextBox><br />
                    </td>
                    <th>
                        TextArea
                    </th>
                    <td>
                        <Ctl:TextBox ID="TextBox3" runat="server" SetType="Text" TextMode="MultiLine" Height="100"></Ctl:TextBox><br />
                    </td>
                </tr>
                <tr>
                    <th>
                        비밀번호
                    </th>
                    <td>
                        <Ctl:TextBox ID="TextBox4" runat="server" SetType="Text" TextMode="Password"></Ctl:TextBox><br />
                        
                    </td>
                    <th>
                        자동검색뷰
                    </th>
                    <td>
                        <Ctl:SearchView ID="svTest" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplate" Params="{'a':'1','b':'2'}">
                            <Ctl:SearchViewField DataField="ROWNO" TextField="ROWNO" Description="순번" Hidden="false" Width="200" TextBox="true" Default="true"  runat="server" />
                            <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" runat="server" />
                            <Ctl:SearchViewField DataField="COLUMNS1" TextField="COLUMNS1" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <th>
                        버튼
                    </th>
                    <td>
                        <Ctl:Button ID="btn01" runat="server" OnClientClick="">버튼1</Ctl:Button>
                        <Ctl:Button ID="Button1" runat="server" OnClientClick="">버튼2</Ctl:Button>
                    </td>
                    <th>
                        텍스트박스 Readonly
                    </th>
                    <td>
                        <Ctl:TextBox ID="txtReadOnly" runat="server" ReadOnly="true"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        체크박스
                    </th>
                    <td>
                        <Ctl:CheckBox ID="chk1" runat="server">
                            <asp:ListItem Selected="True" Text="값1" Value="0" LangCode="chk1_1" Description="값1"></asp:ListItem>
                            <asp:ListItem Text="값2" Value="2"></asp:ListItem>
                        </Ctl:CheckBox>
                    </td>
                    <th>
                        라디오버튼
                    </th>
                    <td>
                        <Ctl:Radio ID="rdo1" runat="server" RepeatColumns="2">
                            <asp:ListItem Selected="True" Text="값1" Value="0" LangCode="chk1_1" Description="값1"></asp:ListItem>
                            <asp:ListItem Text="값2" Value="2"></asp:ListItem>
                        </Ctl:Radio>
                    </td>
                </tr>
                <tr>
                    <th>
                        콤보박스
                    </th>
                    <td>
                        <Ctl:Combo ID="cmb1" runat="server" RepeatColumns="2">
                            <asp:ListItem Selected="True" Text="값1" Value="0" LangCode="chk1_1" Description="값1"></asp:ListItem>
                            <asp:ListItem Text="값2" Value="2"></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                    <th>
                        텍스트
                    </th>
                    <td>
                        <Ctl:Text ID="txt1" runat="server" Text="테스트텍스트"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <%--<th>Flip Switch</th>
                    <td>
                        <Ctl:FlipSwitch ID="flp1" runat="server" Width="100">
                            <asp:ListItem Selected="True" Text="값1" Value="0"></asp:ListItem>
                            <asp:ListItem Text="값2" Value="2"></asp:ListItem>
                        </Ctl:FlipSwitch>
                    </td>--%>
                    <th>차트</th>
                    <td>
                        <!-- 차트를 바인딩할 div -->
                        <canvas id="cvs" width="600" height="250">
                            [No canvas support]
                        </canvas>
                        <canvas id="cvs2" width="350" height="250">
                            [No canvas support]
                        </canvas>
                        <canvas id="cvs3" width="600" height="250">
                            [No canvas support]
                        </canvas>
                    </td>
                    <th>트리</th>
                    <td>
                        <Ctl:WebTree ID="tree1" runat="server" Width="199" TypeName="Common.MenuBiz" MethodName="GetMenuSubData"></Ctl:WebTree>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
        <%--탭이 필요할시 레이어 컨트롤 하단에 LayerTap과 LayerTapBody 컨트롤을 사용하여 탭를 표현--%>
        <Ctl:Layer ID="layer2" runat="server" Title="컨트롤 예제">
            <Ctl:WebSheet ID="grid1" runat="server" Paging="false" CheckBox="false" Width="100%" UseColumnSort="true" HFixation="false" Fixation="false" Height="300" Title="WebSheet" TypeName="QM.QMBiz" MethodName="ListTemplatePaging">
                <ul class="search" style="border-bottom:0px;">
      		   	    <li><img src="/Resources/Images/icon_search.gif" alt="" title="" /></li>
                    <li>
                        <Ctl:Text ID="TXT30" runat="server" LangCode="TXT30" Description="법인"></Ctl:Text>
                    </li>
                    <li>
                        <Ctl:Combo ID="cboCompany" runat="server" onchange="cboCompany_Change(this);"></Ctl:Combo>
                    </li>
                    <li>&nbsp;&nbsp;</li>
                    <li>
      		   	   	    <Ctl:Text ID="TXT100" runat="server" LangCode="TXT100" Description="카테고리"></Ctl:Text>
                    </li>
                    <li>
                        <Ctl:Combo ID="cboCategoryCond" runat="server" Width="100px"></Ctl:Combo>
                    </li>
                    <li>&nbsp;&nbsp;</li>

      		   	    <li style="display:none;">
      		   	   	    <Ctl:Text ID="Text1" runat="server" LangCode="TXT04" Description="차종"></Ctl:Text>
	   			    </li>
   				    <li style="display:none;">
                        <%--<Ctl:JisSearchView ID="svCarCode_Search" runat="server" />--%>
                    </li>
                    <%--<li>&nbsp;&nbsp;</li>--%>
      		   	    <li style="display:none;">
      		   	   	    <Ctl:Text ID="Text2" runat="server" LangCode="TXT05" Description="제품군"></Ctl:Text>
	   			    </li>
   				    <li style="display:none;">
                        <%--<Ctl:JisSearchView ID="svProdCode_Search" runat="server" />--%>
                    </li>
                    <%--<li>&nbsp;&nbsp;</li>--%>

                    <li>
      		   	   	    <Ctl:Text ID="TXT99" runat="server" LangCode="TXT99" Description="진행상태"></Ctl:Text>
	   			    </li>
   				    <li>
                        <Ctl:Combo ID="cboProState" runat="server" RepeatColumns="2" Width="75px">
                            <asp:ListItem Value="" Text=""></asp:ListItem>
                            <asp:ListItem Selected="True" Value="P" Text="" LangCode="TXT98" Description="진행중"></asp:ListItem>
                            <asp:ListItem Value="C" Text="" LangCode="TXT97" Description="완료"></asp:ListItem>
                        </Ctl:Combo>
                    </li>
                    <li>
                        <Ctl:Button ID="btnAddTemplete" runat="server" Style="Orange" LangCode="TXT03" Description="신규" OnClientClick="return btnAddTemplete_Click(); return false;" InGrid="true"></Ctl:Button>
                    </li>
                </ul>

                <Ctl:SheetHeader TextField="tColumns1" Description="테스트" Align="center" Colspan="13" runat="server" />
                <Ctl:SheetHeader TextField="2Columns1" Description="테스트2" Align="center" Colspan="7" runat="server" RowIndex="2" />
                <Ctl:SheetHeader TextField="3Columns1" Description="테스트3" Align="center" Colspan="6" runat="server" RowIndex="2" ColIndex="2" />

                <Ctl:SheetField DataField="ROWNO" TextField="ROWNO" Description="순번" Width="60" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" OnClick="Grid1RowClick" HiddenHeader="false" Hidden="false" Fix="true" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="IDX" TextField="IDX" Description="문서번호" Width="60" Height="24" HAlign="center" Align="left" runat="server" />
                <Ctl:SheetField DataField="COLUMNS1" TextField="COLUMNS1" Description="컬럼1" Width="*" Height="24" Edit="true" DataType="text" EditType="text" HAlign="center" Align="left" OnClick="" HiddenHeader="false" Hidden="false" Fix="true" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="COLUMNS2" TextField="COLUMNS2" Description="컬럼2" Width="100" Height="24" Edit="true" DataType="text" EditType="text" HAlign="center" Align="left" OnClick="" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="COLUMNS3" TextField="COLUMNS3" Description="컬럼3" Width="100" Height="24" Edit="true" DataType="text" EditType="calendar" DateFormat="yyyy-mm"  HAlign="center" Align="left" OnClick="" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="true" runat="server" />
                <Ctl:SheetField DataField="COLUMNS4" TextField="COLUMNS4" Description="컬럼4" Width="100" Height="24" Edit="true" DataType="text" EditType="searchview" HAlign="center" Align="left" OnClick="" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplate">
                    <Ctl:SearchViewField DataField="ROWNO" TextField="ROWNO" Description="순번" Hidden="false" Width="200" TextBox="true" Default="true"  runat="server" />
                    <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" runat="server" />
                    <Ctl:SearchViewField DataField="COLUMNS1" TextField="COLUMNS1" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                </Ctl:SheetField>
                <Ctl:SheetField DataField="COLUMNS5" TextField="COLUMNS5" Description="컬럼5" Width="100" Height="24" Edit="true" DataType="text" EditType="combo" HAlign="center" Align="left" OnClick="" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server">
                    <asp:ListItem Value="" Text=""></asp:ListItem>
                    <asp:ListItem Selected="True" Value="P" Text="" LangCode="TXT98" Description="진행중"></asp:ListItem>
                    <asp:ListItem Value="C" Text="" LangCode="TXT97" Description="완료"></asp:ListItem>
                </Ctl:SheetField>
                <Ctl:SheetField DataField="COLUMNS6" TextField="COLUMNS6" Description="컬럼6" Width="100" Height="24" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" OnClick="" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="COLUMNS7" TextField="COLUMNS7" Description="컬럼7" Width="100" Height="24" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" OnClick="" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="COLUMNS8" TextField="COLUMNS8" Description="컬럼8" Width="100" Height="24" Edit="false" DataType="Number" NumberFormat="###,###,###,###,###.##" EditType="text" HAlign="center" Align="left" OnClick="" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="COLUMNS9" TextField="COLUMNS9" Description="컬럼9" Width="100" Height="24" Edit="false" DataType="Date" EditType="text" HAlign="center" Align="left" OnClick="" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="UPDID" TextField="UPDID" Description="등록자" Width="80" Height="24" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" OnClick="" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />
                <Ctl:SheetField DataField="UPDDT" TextField="UPDDT" Description="등록일" Width="80" Height="24" Edit="false" DataType="text" EditType="text" HAlign="center" Align="left" OnClick="" HiddenHeader="false" Hidden="false" Fix="false" AutoMerge="false" runat="server" />

            </Ctl:WebSheet>
        </Ctl:Layer>
        <Ctl:Layer ID="layerTab" runat="server" Title="레이어예제 예제">
            <Ctl:LayerTap ID="tap11" runat="server" Width="200px" Title="첫번째" Description="첫번째"></Ctl:LayerTap>
            <Ctl:LayerTap ID="tap12" runat="server" Width="200px" Title="두번째" Description="두번째"></Ctl:LayerTap>
            <Ctl:LayerTap ID="tap13" runat="server" Width="200px" Title="세번째" Description="세번째"></Ctl:LayerTap>
		    <Ctl:LayerTapBody ID="tap11_body" runat="server"> 첫번째 </Ctl:LayerTapBody>
            <Ctl:LayerTapBody ID="tap22_body" runat="server"> 두번째 </Ctl:LayerTapBody>
		    <Ctl:LayerTapBody ID="tap33_body" runat="server"> 세번째 
            wefwefwefewfwef
            wefwe
            fwe
            fwef
            wefwe

            </Ctl:LayerTapBody>
        </Ctl:Layer>
        <Ctl:Layer ID="layPrjInfo" runat="server" LangCode="TXT26" Description="프로젝트 등록 정보" DefaultHide="False">
           
            <div style="float:right;">
				<Ctl:Button ID="btnGrid3RowAdd" runat="server" OnClientClick="grid3_RowAdd();" LangCode="TXT23" Description="행추가"></Ctl:Button>
				<Ctl:Button ID="btnGrid3RowRemove" runat="server" OnClientClick="grid3_RemoveAdd();" LangCode="TXT24" Description="행삭제"></Ctl:Button>
			</div>
			
            <%--<Ctl:WebSheet ID="grid3" runat="server" Paging="false" CheckBox="true" Width="100%" Height="300">
                <Ctl:SheetItems ID="gird_item2" runat="server">
                    
                </Ctl:SheetItems>
            </Ctl:WebSheet>--%>
            <br />
            <div style="font-size:13px; padding-left:5px; float:left;">
                <Ctl:Text ID="Text13" runat="server" LangCode="TXT25" Description="COMMENT" Literal="true"></Ctl:Text>
            </div>
            <div style="padding:5px;">
                <Ctl:TextBox ID="txtComment" runat="server" SetType="Text" TextMode="MultiLine" Height="50"></Ctl:TextBox>
            </div>
        </Ctl:Layer>
    </div>
</asp:content>
