<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebSheet.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.WebSheet" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <style>
    #grid9_main, #grid9_main table#grid9, #grid9_main table#grid9 col
    {
        width:70px !important;
    }
    #grid9_body 
    {
        position:absolute;
        right:0;
    }
    
    #grid35_main, #grid35_main table#grid35, #grid35_main table#grid35 col
    {
        width:70px !important;
    }
    #grid35_body 
    {
        position:absolute;
        right:0;
    }
    </style>
    <script type="text/javascript">
        
        function OnLoad() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            /* 기본 샘플 그리드1 */
            grid1.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid1.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            /* 기본 샘플 그리드2 */
            grid2.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid2.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            /* 기본 샘플 그리드3 */
            grid3.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid3.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            /* 기본 샘플 그리드4 */
            grid4.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid4.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            //샘플 DataSet Grid Bind
            var ht2 = new Object();
            ht2["PageSize"] = "5";
            grid99.Params(ht2);
            grid99.BindList(1);

            // AutoColumns 속성 예제
            grid5.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid5.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            // CellHeight 속성 예제
            grid6.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid6.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            // CheckAutoMergeTarget 속성 예제
            grid7.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid7.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            // CheckBox 속성 예제
            grid8.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid8.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            // Fixation 속성 예제
            grid9.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid9.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            // HeaderHeight 속성 예제
            grid10.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid10.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            // Height 속성 예제
            grid11.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid11.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            // HFixation 속성 예제
            grid12.Params(ht);
            grid12.BindList(1);

            // PageSize 속성 예제
            var ht13 = new Object();
            grid13.Params(ht13);
            grid13.BindList(1);

            // Paging=false 속성 예제
            grid14.Params(ht);
            grid14.BindList(1);

            // PagingSize 속성 예제
            grid16.Params(ht);
            grid16.BindList(1);

            // UseColumnSort 속성 예제
            grid17.Params(ht);
            grid17.BindList(1);

            // Width 속성 예제
            grid18.Params(ht);
            grid18.BindList(1);

            // AutoSaveTarget() 예제
            grid19.Params(ht);
            grid19.BindList(1);
            grid19.AutoSaveTarget = function (r, c) {
                alert();
            }

            // BindList() 예제
            grid20.TypeName = "Template.TemplateBiz";
            grid20.MethodName = "ListTemplatePaging";
            var ht20 = new Object();
            ht20["SearchCondition"] = "title256";
            grid20.Params(ht20);
            grid20.BindList(2);

            // CallBack() 예제
            grid21.CallBack = function () {
                alert();
            }

            // DataBind() 예제
            var ht22 = new Object();
            PageMethods.InvokeServiceTable(ht22, "Template.TemplateBiz", "ListTemplate", function (e) {
                var ds = eval(e)

                grid22.DataBind(ds.Tables[0]);
            });

            grid23.Params(ht);
            grid23.BindList(1);

            grid24.Params(ht);
            grid24.BindList(1);

            grid25.Params(ht);
            grid25.BindList(1);

            grid26.Params(ht);
            grid26.BindList(1);

            grid27.Params(ht);
            grid27.BindList(1);

            grid28.Params(ht);
            grid28.BindList(1);

            grid29.Params(ht);
            grid29.BindList(1);

            grid30.Params(ht);
            grid30.BindList(1);

            grid31.Params(ht);
            grid31.BindList(1);

            grid32.Params(ht);
            grid32.BindList(1);

            grid33.Params(ht);
            grid33.BindList(1);

            grid34.Params(ht);
            grid34.BindList(1);

            grid35.Params(ht);
            grid35.BindList(1);

            grid36.Params(ht);
            grid36.BindList(1);

            grid37.Params(ht);
            grid37.BindList(1);

            grid38.Params(ht);
            grid38.BindList(1);

            grid39.Params(ht);
            grid39.BindList(1);

            grid40.Params(ht);
            grid40.BindList(1);

            grid41.Params(ht);
            grid41.BindList(1);

            grid42.Params(ht);
            grid42.BindList(1);

            grid43.Params(ht);
            grid43.BindList(1);

            grid44.Params(ht);
            grid44.BindList(1);

            grid45.Params(ht);
            grid45.BindList(1);

            grid46.Params(ht);
            grid46.BindList(1);

            grid47.Params(ht);
            grid47.BindList(1);

            grid48.Params(ht);
            grid48.BindList(1);

            grid49.Params(ht);
            grid49.BindList(1);

            grid50.Params(ht);
            grid50.BindList(1);

            grid51.Params(ht);
            grid51.BindList(1);

            grid52.Params(ht);
            grid52.BindList(1);



            // 테스트용
            grid100.Params(ht2);
            grid100.BindList(1);
        }

        function grid1_Click(row, cell) {

        }

        /********************************************************************************************
        * 함수명      : btnSearch21_Click
        * 작성목적    : grid21 조회
        * Parameter   :
        * Return
        * 작성자      : 
        * 최초작성일  : 2018-05-28
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btnSearch21_Click() {
            var ht = new Object();
            grid21.Params(ht);

            grid21.BindList(1);
            return false;
        }

        function grid44_Click(row, cell) {
            alert();
        }

        /********************************************************************************************
        * 함수명      : btnExcel_Click
        * 작성목적    : 엑셀다운로드 이벤트
        * Parameter   :
        * Return
        * 작성자      : 
        * 최초작성일  : 2018-04-13
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btnExcel_Click() {
            grid1.ExcelDownload("test.xls");
        }

        /********************************************************************************************
        * 함수명      : grid1_Click
        * 작성목적    : 그리드 데이터 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 
        * 최초작성일  : 2018-04-13
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function grid7_Click(r,c) {
            var ht = grid1.GetRow(r);
            alert('<Ctl:Text ID="MSG01" runat="server" LangCode="MSG01" Description="ROWNO : " Literal="true"></Ctl:Text>' + ht["ROWNO"]);
        }

        /********************************************************************************************
        * 함수명      : grid8_RowAdd
        * 작성목적    : 그리드 Row 추가
        * Parameter   :
        * Return
        * 작성자      : 
        * 최초작성일  : 2018-04-13
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function grid8_RowAdd() {
            grid8.InsertRow();
        }

        /********************************************************************************************
        * 함수명      : grid8_RowRemove
        * 작성목적    : 그리드 Row 삭제
        * Parameter   :
        * Return
        * 작성자      : 
        * 최초작성일  : 2018-04-13
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function grid8_RowRemove() {
            var o = grid8.GetCheckRow(); // 체크된 전체데이터
            if (o == null || o == "") {
                alert('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG02" Description="체크된 Row가 존재하지 않습니다." Literal="true"></Ctl:Text>');
                return false;
            }
            var check_idx = new Array();

            for (i = 0; i < ObjectCount(o); i++) {
                for (j = 0; j < ObjectCount(grid8.CurrData.Rows); j++) {
                    if (grid8.CurrData.Rows[j] == o[i]) {
                        check_idx.push(j);
                    }
                }
            }
            grid8.RemoveRows(check_idx);
            return false;
        }


        /************************************************************************
        함수명		: fn_Redirect
        작성목적	: 해당 페이지로 이동한다.
        작 성 자	: 
        최초작성일	: 2018-05-03
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
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / WebSheet
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="WebSheet Control Sample" Literal="true"></Ctl:Text></h4>

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
        <Ctl:Layer ID="layer1" runat="server" Title="WebSheet Control 기본샘플" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="15%" />
                    <col width="50%" />
                    <col width="35%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT04" runat="server" LangCode="TXT04" Description="구분"></Ctl:Text>
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
                        <Ctl:Text ID="TXT05" runat="server" LangCode="TXT05" Description="기본 그리드"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="
                        &#60Ctl:WebSheet ID=&#34;grid1&#34; runat=&#34;server&#34; AutoColumns=&#34;false&#34; CellHeight=&#34;28&#34;<br/>
                        &nbsp;&nbsp;CheckAutoMergeTarget=&#34;0&#34; CheckBox=&#34;true&#34; Fixation=&#34;false&#34; HeaderHeight=&#34;28&#34;<br />
                        &nbsp;&nbsp;Height=&#34;120&#34; HFixation=&#34;true&#34; MethodName=&#34;ListTemplate&#34; PageSize=&#34;3&#34; Paging=&#34;true&#34;<br />
                        &nbsp;&nbsp;PagingSize=&#34;6&#34; TypeName=&#34;Template.TemplateBiz&#34; UseColumnSort=&#34;false&#34;  Width=&#34;100%&#34; &#62<br />
                        <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:SheetField runat=&#34;server&#34; Align=&#34;left&#34; AutoMerge=&#34;true&#34; DataField=&#34;CREATEDT&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;DataType=&#34;Date&#34; Description=&#34;CREATEDT&#34; Edit=&#34;false&#34; Fix=&#34;false&#34; HAlign=&#34;center&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;Hidden=&#34;false&#34; HiddenHeader=&#34;false&#34; TextField=&#34;CREATEDT&#34;  Width=&#34;90&#34; <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;OnClick=&#34;grid1_Click&#34; /&#62<br />
                        <br />
                        &#60/Ctl:WebSheet&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid1" runat="server" AutoColumns="false" CellHeight="28" CheckAutoMergeTarget="0" CheckBox="true" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="true" PagingSize="6" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%" >
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="true" DataField="CREATEDT" DataType="Date" Description="CREATEDT" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="CREATEDT"  Width="90" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="멀티헤더"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="
                        &#60Ctl:WebSheet ......&#62<br/>
                            <br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:SheetHeader runat=&#34;server&#34; Align=&#34;center&#34; ColIndex=&#34;0&#34; Colspan=&#34;2&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Description=&#34;멀티헤더&#34; Height=&#34;20&#34; RowIndex=&#34;0&#34; Rowspan=&#34;1&#34; TextField=&#34;ROWNO&#34; /&#62<br/>
                            <br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:SheetField ...... /&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:SheetField ...... /&#62<br/>
                        &#60/Ctl:WebSheet&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid2" runat="server" AutoColumns="false" CellHeight="28" CheckAutoMergeTarget="0" CheckBox="true" FixableWidth="500" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="true" PagingSize="6" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%" >
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="2" Description="멀티헤더" Height="20" RowIndex="0" Rowspan="1" TextField="ROWNO" />

                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="true" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="70" OnClick="grid1_Click" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="true" DataField="CREATEDT" DataType="Date" Description="CREATEDT" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="CREATEDT"  Width="90" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT08" runat="server" LangCode="TXT08" Description="&#60ListItem&#62 사용"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT09" runat="server" LangCode="TXT09" Description="
                        &#60Ctl:WebSheet ...... &#62<br/>
                        <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:SheetField runat=&#34;server&#34; Align=&#34;left&#34; AutoMerge=&#34;false&#34; DataField=&#34;ROWNO&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Description=&#34;순번&#34; Edit=&#34;true&#34; EditType=&#34;Combo&#34; Fix=&#34;false&#34; HAlign=&#34;center&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Hidden=&#34;false&#34; HiddenHeader=&#34;false&#34; StripeColorF=&#34;Red&#34; StripeColorL=&#34;Blue&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TextField=&#34;ROWNO&#34; Width=&#34;70&#34; OnClick=&#34;grid1_Click&#34;&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#60asp:ListItem Text=&#34;1&#34; Value=&#34;1&#34;&#62&#60/asp:ListItem&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#60asp:ListItem Text=&#34;2&#34; Value=&#34;2&#34;&#62&#60/asp:ListItem&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#60asp:ListItem Text=&#34;3&#34; Value=&#34;3&#34;&#62&#60/asp:ListItem&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60/Ctl:SheetField&#62<br/><br />
                        &#60/Ctl:WebSheet&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid3" runat="server" AutoColumns="false" CellHeight="28" CheckAutoMergeTarget="0" CheckBox="true" FixableWidth="500" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="true" PagingSize="6" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%" >
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="ROWNO" Description="순번" Edit="true" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" StripeColorF="Red" StripeColorL="Blue" TextField="ROWNO" Width="70" OnClick="grid1_Click">
                                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                            </Ctl:SheetField>
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT10" runat="server" LangCode="TXT10" Description="데이터 바인딩"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT11" runat="server" LangCode="TXT11" Description="
                        &#60Ctl:WebSheet ......&#62<br/>
                        <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60Ctl:SheetField runat=&#34;server&#34; Align=&#34;left&#34; AutoMerge=&#34;false&#34; DataField=&#34;IDX&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DataTextField=&#34;IDX&#34; DataValueField=&#34;IDX&#34; Description=&#34;문서번호&#34; Edit=&#34;true&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EditType=&#34;Combo&#34; Fix=&#34;false&#34; HAlign=&#34;center&#34; Hidden=&#34;false&#34; HiddenHeader=&#34;false&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MethodName=&#34;ListTemplatePaging&#34; <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Params=&#34;{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}&#34;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TextField=&#34;IDX&#34; TypeName=&#34;Template.TemplateBiz&#34; Width=&#34;70&#34; OnClick=&#34;grid1_Click&#34; /&#62<br />
                        <br />
                        &#60/Ctl:WebSheet&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid4" runat="server" AutoColumns="false" CellHeight="28" CheckAutoMergeTarget="0" CheckBox="true" FixableWidth="500" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="true" PagingSize="6" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%" >
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="true" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="70" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="WebSheet Control 샘플 DataSet" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="17%" />
                    <col width="13%" />
                    <col width="70%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT51" runat="server" LangCode="TXT51" Description="TypeName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT52" runat="server" LangCode="TXT52" Description="MethodName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT53" runat="server" LangCode="TXT53" Description="DataSet"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT57" runat="server" LangCode="TXT57" Description="Template.TemplateBiz"></Ctl:Text>
                    </td>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT58" runat="server" LangCode="TXT58" Description="ListTemplate"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid99" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="Template.TemplateBiz" MethodName="ListTemplate">
                            <Ctl:SheetField DataField="NO" TextField="NO" Description="NO" Width="50"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="ROWNO" TextField="ROWNO" Description="ROWNO" Width="60"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="IDX" TextField="IDX" Description="IDX" Width="40"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="TITLE" TextField="TITLE" Description="TITLE" Width="60"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="CREATEDT" TextField="CREATEDT" Description="CREATEDT" Width="150"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="CREATENM" TextField="CREATENM" Description="CREATENM" Width="80"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="NUM" TextField="NUM" Description="NUM" Width="120"  HAlign="center" Align="right" runat="server" />
                            <Ctl:SheetField DataField="CREATEDT2" TextField="CREATEDT2" Description="CREATEDT2" Width="80"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties List-->
        <Ctl:Layer ID="layer3" runat="server" Title="WebSheet Control Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT101" runat="server" LangCode="TXT101" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT102" runat="server" LangCode="TXT102" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT307">&#60SheetField&#62</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT104" runat="server" LangCode="TXT104" Description="- 해당 컨트롤에 바인딩할 칼럼 Field"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT311">&#60SheetHeader&#62</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT106" runat="server" LangCode="TXT106" Description="- 해당 컨트롤의 멀티헤더 칼럼 Field"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT315">AutoColumns</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT108" runat="server" LangCode="TXT108" Description="- 해당 컨트롤의 칼럼 자동생성 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT319">CellHeight</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT110" runat="server" LangCode="TXT110" Description="- 해당 컨트롤의 Cell 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT323">CheckAutoMergeTarget</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT112" runat="server" LangCode="TXT112" Description="- 해당 컨트롤의 체크박스 자동결합 수"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT327">CheckBox</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT114" runat="server" LangCode="TXT114" Description="- 해당 컨트롤의 체크박스 표시 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT331">Fixation</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT116" runat="server" LangCode="TXT116" Description="- 해당 컨트롤의 가로 틀고정 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT335">HeaderHeight</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT118" runat="server" LangCode="TXT118" Description="- 해당 컨트롤의 헤더 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT339">Height</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT120" runat="server" LangCode="TXT120" Description="- 해당 컨트롤의 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT343">HFixation</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT122" runat="server" LangCode="TXT122" Description="- 해당 컨트롤의 높이 틀고정 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT371">MethodName</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT136" runat="server" LangCode="TXT136" Description="- 해당 컨트롤의 Biz의 메소드명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT347">PageSize</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT124" runat="server" LangCode="TXT124" Description="- 해당 컨트롤의 페이지 사이즈"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT351">Paging</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT126" runat="server" LangCode="TXT126" Description="- 해당 컨트롤의 페이징 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT355">PagingSize</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT128" runat="server" LangCode="TXT128" Description="- 해당 컨트롤의 표시할 페이징번호의 사이즈"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT359">TypeName</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT130" runat="server" LangCode="TXT130" Description="- 해당 컨트롤의 Biz명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT363">UseColumnSort</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT132" runat="server" LangCode="TXT132" Description="- 해당 컨트롤의 컬럼헤더 정렬기능 사용여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT367">Width</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT134" runat="server" LangCode="TXT134" Description="- 해당 컨트롤의 너비"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events List-->
        <Ctl:Layer ID="layer4" runat="server" Title="WebSheet Control Events" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT151" runat="server" LangCode="TXT151" Description="Events"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT152" runat="server" LangCode="TXT152" Description="설명"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>
        
        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="WebSheet Control Functions" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT201" runat="server" LangCode="TXT201" Description="Functions"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT202" runat="server" LangCode="TXT202" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT457">AutoSaveTarget()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT234" runat="server" LangCode="TXT234" Description="- 해당 컨트롤의 값 수정 후 콜백함수 호출"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT461">BindList()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT204" runat="server" LangCode="TXT204" Description="- 해당 컨트롤을 데이터 바인딩"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT465">CallBack()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT206" runat="server" LangCode="TXT206" Description="- 해당 컨트롤을 데이터 바인딩 후 콜백함수 호출"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT473">DataBind()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT210" runat="server" LangCode="TXT210" Description="- 해당 컨트롤에 데이터테이블을 바인딩"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT477">ExcelDownload()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT212" runat="server" LangCode="TXT212" Description="- 해당 컨트롤 내용을 엑셀파일로 출력한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT481">GetAllRow()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT214" runat="server" LangCode="TXT214" Description="- 해당 컨트롤의 모든 Row"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT485">GetCheckRow()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT216" runat="server" LangCode="TXT216" Description="- 해당 컨트롤의 체크된 Row"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT489">GetRow()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT218" runat="server" LangCode="TXT218" Description="- 해당 컨트롤의 Row"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT497">InsertRow()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT222" runat="server" LangCode="TXT222" Description="- 해당 컨트롤의 빈 Row를 추가한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT521">RemoveAllRow()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT236" runat="server" LangCode="TXT236" Description="- 해당 컨트롤의 모든 Row를 삭제한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT505">RemoveRows()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT226" runat="server" LangCode="TXT226" Description="- 해당 컨트롤의 Row를 삭제한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT509">SetValue()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT228" runat="server" LangCode="TXT228" Description="- 해당 컨트롤의 Value를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT517">$().css()</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT232" runat="server" LangCode="TXT232" Description="- 해당 컨트롤의 Row 와 Cell의 배경색을 변경한다."></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer6" runat="server" Title="WebSheet Control Properties Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT301" runat="server" LangCode="TXT301" Description="Properties"></Ctl:Text>
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
                        <a href="#TXT104">&#60SheetField&#62</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT307" runat="server" LangCode="TXT307" Description="- 해당 컨트롤에 바인딩할 칼럼 Field"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT308" runat="server" LangCode="TXT308" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; <p style='display:inline;color:red;'>SheetField 에 대해서는 SheetField Properties 와 Examples 참조한다.</p>
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT309" runat="server" LangCode="TXT309" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT106">&#60SheetHeader&#62</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT311" runat="server" LangCode="TXT311" Description="- 해당 컨트롤의 멀티헤더 칼럼 Field"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT312" runat="server" LangCode="TXT312" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; <p style='display:inline;color:red;'>SheetHeader 에 대해서는 SheetHeader Properties 와 Examples 참조한다.</p>
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT313" runat="server" LangCode="TXT313" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT108">AutoColumns</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT315" runat="server" LangCode="TXT315" Description="- 해당 컨트롤의 칼럼 자동생성 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT316" runat="server" LangCode="TXT316" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 모든 칼럼을 자동으로 생성한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; SheetField 의 칼럼헤드를 공유하며, SheetField 뒤에 생성된다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; AutoColumns 에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT317" runat="server" LangCode="TXT317" Description="
                        <p style='display:inline;color:blue;'>AutoColumns=&#34;true&#34;</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid5" runat="server" AutoColumns="true" CellHeight="28" CheckAutoMergeTarget="0" CheckBox="false" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%" >
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="true" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="70" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT110">CellHeight</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT319" runat="server" LangCode="TXT319" Description="- 해당 컨트롤의 Cell 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT320" runat="server" LangCode="TXT320" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT321" runat="server" LangCode="TXT321" Description="
                        <p style='display:inline;color:blue;'>CellHeight=&#34;50&#34;</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid6" runat="server" AutoColumns="false" CellHeight="50" CheckAutoMergeTarget="0" CheckBox="false" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%" >
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="true" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="70" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT112">CheckAutoMergeTarget</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT323" runat="server" LangCode="TXT323" Description="- 해당 컨트롤의 체크박스 자동결합 수"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT324" runat="server" LangCode="TXT324" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CheckBox = &#34;true&#34; 일때만 사용할 수 있다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CheckAutoMergeTarget 에는 int 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT325" runat="server" LangCode="TXT325" Description="
                        <p style='display:inline;color:blue;'>CheckAutoMergeTarget=&#34;2&#34;</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid7" runat="server" AutoColumns="false" CellHeight="28" CheckAutoMergeTarget="2" CheckBox="true" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%" >
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="true" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="70" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT114">CheckBox</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT327" runat="server" LangCode="TXT327" Description="- 해당 컨트롤의 체크박스 표시 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT328" runat="server" LangCode="TXT328" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CheckBox 에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT329" runat="server" LangCode="TXT329" Description="
                        <p style='display:inline;color:blue;'>CheckBox=&#34;true&#34;</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid8" runat="server" AutoColumns="false" CellHeight="28" CheckAutoMergeTarget="0" CheckBox="true" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%" >
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="true" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="70" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT116">Fixation</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT331" runat="server" LangCode="TXT331" Description="- 해당 컨트롤의 가로 틀고정 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT332" runat="server" LangCode="TXT332" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Fixation 에는 true | false 값을 사용한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; SheetField 의 Fix 속성이 true 인 칼럼은 왼쪽에 틀고정된다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT333" runat="server" LangCode="TXT333" Description="
                        <p style='display:inline;color:blue;'>Fixation=&#34;true&#34;</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <div style="position:relative;width:100%;">
                            <Ctl:WebSheet ID="grid9" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Fixation="true" Height="120" HFixation="false" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%">
                                <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="true" EditType="Combo" Fix="true" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="90" OnClick="null" />
                                <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="TITLE" DataTextField="TITLE" DataValueField="IDX" Description="TITLE" Edit="true" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="TITLE" TypeName="Template.TemplateBiz" Width="200" OnClick="null" />
                                <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="TITLE" DataTextField="TITLE" DataValueField="IDX" Description="TITLE" Edit="true" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="TITLE" TypeName="Template.TemplateBiz" Width="200" OnClick="null" />
                            </Ctl:WebSheet>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT118">HeaderHeight</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT335" runat="server" LangCode="TXT335" Description="- 해당 컨트롤의 헤더 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT336" runat="server" LangCode="TXT336" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT337" runat="server" LangCode="TXT337" Description="
                        <p style='display:inline;color:blue;'>HeaderHeight=&#34;50&#34;</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <div style="position:relative;width:100%;">
                            <Ctl:WebSheet ID="grid10" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Fixation="false" HeaderHeight="50" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%">
                                <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="true" EditType="Combo" Fix="true" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="90" OnClick="null" />
                            </Ctl:WebSheet>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT120">Height</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT339" runat="server" LangCode="TXT339" Description="- 해당 컨트롤의 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT340" runat="server" LangCode="TXT340" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; HFixation 가 true일 경우에만 적용된다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT341" runat="server" LangCode="TXT341" Description="
                        <p style='display:inline;color:blue;'>Height=&#34;200&#34;</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <div style="position:relative;width:100%;">
                            <Ctl:WebSheet ID="grid11" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Fixation="false" HeaderHeight="28" Height="200" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%">
                                <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="true" EditType="Combo" Fix="true" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="90" OnClick="null" />
                            </Ctl:WebSheet>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT122">HFixation</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT343" runat="server" LangCode="TXT343" Description="- 해당 컨트롤의 높이 틀고정 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT344" runat="server" LangCode="TXT344" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; HFixation에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT345" runat="server" LangCode="TXT345" Description="
                        <p style='display:inline;color:blue;'>HFixation=&#34;true&#34;</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <div style="position:relative;width:100%;">
                            <Ctl:WebSheet ID="grid12" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%">
                                <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="true" EditType="Combo" Fix="true" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="90" OnClick="null" />
                            </Ctl:WebSheet>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT136">MethodName</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT371" runat="server" LangCode="TXT371" Description="- 해당 컨트롤의 Biz의 메소드명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT372" runat="server" LangCode="TXT372" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT373" runat="server" LangCode="TXT373" Description="
                        <p style='display:inline;color:blue;'>MethodName=&#34;ListTemplate&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT124">PageSize</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT347" runat="server" LangCode="TXT347" Description="- 해당 컨트롤의 페이지 사이즈"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT348" runat="server" LangCode="TXT348" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; PageSize에는  int 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT349" runat="server" LangCode="TXT349" Description="
                        <p style='display:inline;color:blue;'>PageSize=&#34;1&#34;</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <div style="position:relative;width:100%;">
                            <Ctl:WebSheet ID="grid13" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Fixation="false" HeaderHeight="28" Height="120" HFixation="false" MethodName="ListTemplate" PageSize="1" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%">
                                <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="grid1_Click" />
                            </Ctl:WebSheet>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT126">Paging</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT351" runat="server" LangCode="TXT351" Description="- 해당 컨트롤의 페이징 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT352" runat="server" LangCode="TXT352" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Paging에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT353" runat="server" LangCode="TXT353" Description="
                        <p style='display:inline;color:blue;'>Paging=&#34;true&#34;</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid14" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="1" Paging="true" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT128">PagingSize</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT355" runat="server" LangCode="TXT355" Description="- 해당 컨트롤의 표시할 페이징번호의 사이즈"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT356" runat="server" LangCode="TXT356" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Paging=&#34;true&#34; 일때만 사용할 수 있다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; PagingSize 에는 int 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT357" runat="server" LangCode="TXT357" Description="
                        <p style='display:inline;color:blue;'>PagingSize=&#34;4&#34;</p>
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid16" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="1" Paging="true" PagingSize="4" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT130">TypeName</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT359" runat="server" LangCode="TXT359" Description="- 해당 컨트롤의 Biz명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT360" runat="server" LangCode="TXT360" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT361" runat="server" LangCode="TXT361" Description="
                        <p style='display:inline;color:blue;'>TypeName=&#34;Template.TemplateBiz&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT132">UseColumnSort</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT363" runat="server" LangCode="TXT363" Description="- 해당 컨트롤의 컬럼헤더 정렬기능 사용여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT364" runat="server" LangCode="TXT364" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 칼럼헤드 클릭시 해당 칼럼순으로 정렬된다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; UseColumnSort 에는 true | false 값을 사용한다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT365" runat="server" LangCode="TXT365" Description="
                        <p style='display:inline;color:blue;'>UseColumnSort=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid17" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="1" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="true"  Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT134">Width</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT367" runat="server" LangCode="TXT367" Description="- 해당 컨트롤의 너비"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT368" runat="server" LangCode="TXT368" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다.
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT369" runat="server" LangCode="TXT369" Description="
                        <p style='display:inline;color:blue;'>Width=&#34;200&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid18" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="false" MethodName="ListTemplate" PageSize="1" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="200">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="WebSheet Control Events Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT401" runat="server" LangCode="TXT401" Description="Events"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT402" runat="server" LangCode="TXT402" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT403" runat="server" LangCode="TXT403" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT404" runat="server" LangCode="TXT404" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT405" runat="server" LangCode="TXT405" Description="결과"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>
        
        <!--Functions Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="WebSheet Control Functions Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT451" runat="server" LangCode="TXT451" Description="Functions"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT452" runat="server" LangCode="TXT452" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT453" runat="server" LangCode="TXT453" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT454" runat="server" LangCode="TXT454" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT455" runat="server" LangCode="TXT455" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT234">AutoSaveTarget()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT457" runat="server" LangCode="TXT457" Description="- 해당 컨트롤의 값 수정 후 콜백함수 호출"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT458" runat="server" LangCode="TXT458" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Edit=&#34;true&#34; 인 칼럼만 편집모드가 가능하다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 편집모드에서 값이 수정된 후 Cell에서 벗어날때 호출된다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 호출함수의 r은 수정된 cell의 row의 index, c는 칼럼의 위치 index 이다. (0부터 1씩 증가한다.)
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT459" runat="server" LangCode="TXT459" Description="
                        <p style='display:inline;color:Green;'>/* OnLoad 에서 AutoSaveTarget 함수 */</p><br />
                        <p style='display:inline;color:Blue;'>grid19.AutoSaveTarget = function (r, c) {</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;alert();<br />
                        <p style='display:inline;color:Blue;'>}</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid19" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="false" MethodName="ListTemplate" PageSize="1" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField DataField="TITLE" Edit="true" TextField="TITLE" Description="TITLE" Width="60"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT204">BindList()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT461" runat="server" LangCode="TXT461" Description="- 해당 컨트롤을 데이터 바인딩"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT462" runat="server" LangCode="TXT462" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 데이터 바인딩에 필요한 속성을 스크립트에서 지정한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; BindList 에는 조회 시 보여줄 페이지번호를 넣어준다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT463" runat="server" LangCode="TXT463" Description="
                        <p style='display:inline;color:Green;'> /* OnLoad 시 실행 스크립트 */ </p><br />
                        <p style='display:inline;color:Green;'> /* 데이터 바인딩 시 필요 속성 값을 스크립트에서 지정한다. */ </p><br />
                        grid20.TypeName = &#34;Template.TemplateBiz&#34;;<br />
                        grid20.MethodName = &#34;ListTemplatePaging&#34;;<br /><br />
                        <p style='display:inline;color:Green;'> /* 데이터 바인딩 시 넘길 파라미터 */ </p><br />
                        var ht20 = new Object();<br />
                        ht20[&#34;SearchCondition&#34;] = &#34;title256&#34;;<br />
                        grid20.Params(ht20);<br /><br />
                        <p style='display:inline;color:Green;'> /* 데이터 바인딩 */ </p><br />
                        <p style='display:inline;color:Blue;'>grid20.BindList(2);</p> <p style='display:inline;color:Green;'> // 2번 페이지 조회 </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid20" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="false" PageSize="3" Paging="true" PagingSize="3" UseColumnSort="false"  Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField DataField="TITLE" Edit="false" TextField="TITLE" Description="TITLE" Width="60"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT206">CallBack()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT465" runat="server" LangCode="TXT465" Description="- 해당 컨트롤을 데이터 바인딩 후 콜백함수 호출"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT466" runat="server" LangCode="TXT466" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT467" runat="server" LangCode="TXT467" Description="
                        <p style='display:inline;color:Green;'> /* OnLoad 시 실행 스크립트 */ </p><br />
                        <p style='display:inline;color:blue;'>grid21.CallBack = function () {</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;alert();<br />
                        <p style='display:inline;color:blue;'>}</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid21" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="grid1_Click" />
                        </Ctl:WebSheet>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnSearch21" runat="server" LangCode="btnSearch21" Description="조회" OnClientClick="return btnSearch21_Click();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT210">DataBind()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT473" runat="server" LangCode="TXT473" Description="- 해당 컨트롤에 데이터테이블을 바인딩"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT474" runat="server" LangCode="TXT474" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT475" runat="server" LangCode="TXT475" Description="
                        var ht22 = new Object();<br />
                        PageMethods.InvokeServiceTable(ht22, &#34;Template.TemplateBiz&#34;, &#34;ListTemplate&#34;, function (e) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;var ds = eval(e)<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:blue;'>grid22.DataBind(ds.Tables[0]);</p><br />
                        });
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid22" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" PageSize="3" Paging="false" PagingSize="3" UseColumnSort="false"  Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField DataField="TITLE" Edit="false" TextField="TITLE" Description="TITLE" Width="120"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT212">ExcelDownload()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT477" runat="server" LangCode="TXT477" Description="- 해당 컨트롤 내용을 엑셀파일로 출력한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT478" runat="server" LangCode="TXT478" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 바인딩된 데이터를 입력한 파일명으로 엑셀파일을 출력한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT479" runat="server" LangCode="TXT479" Description="
                        <p style='display:inline;color:green;'> /* websheet.xls 엑셀파일을 출력한다. */</p><br />
                        <p style='display:inline;color:blue;'>grid23.ExcelDownload('websheet.xls');</p> 
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid23" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField DataField="TITLE" Edit="false" TextField="TITLE" Description="TITLE" Width="120" Hidden="false"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnExcel23" runat="server" LangCode="btnExcel23" Description="ExcelDownload()" OnClientClick="grid23.ExcelDownload('websheet.xls');"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT214">GetAllRow()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT481" runat="server" LangCode="TXT481" Description="- 해당 컨트롤의 모든 Row"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT482" runat="server" LangCode="TXT482" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ObjectCount 를 사용하여 row 수를 가져오거나, Rows 를 사용하여 특정 칼럼의 값을 가져올 수 있다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Rows 의 index 는 0부터 1씩 증가한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT483" runat="server" LangCode="TXT483" Description="
                        <p style='display:inline;color:blue;'>grid23.GetAllRow();</p><br />
                        <p style='display:inline;color:blue;'> ObjectCount(grid23.GetAllRow());</p> <p style='display:inline;color:green;'> /* 해당 컨트롤의 row 수 */ </p><br />
                        <p style='display:inline;color:blue;'> grid23.GetAllRow().Rows[0][&#34;NO&#34;];</p> <p style='display:inline;color:green;'> /* 해당 컨트롤의 0 번째 row의 &#34;NO&#34; 값 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT216">GetCheckRow()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT485" runat="server" LangCode="TXT485" Description="- 해당 컨트롤의 체크된 Row"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT486" runat="server" LangCode="TXT486" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 체크박스에 체크된 row를 가져온다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; rows 의 index는 0부터 1씩 증가한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT487" runat="server" LangCode="TXT487" Description="
                        <p style='display:inline;color:blue;'>grid24.GetCheckRow();<br />
                        ObjectCount(grid24.GetCheckRow());</p> <p style='display:inline;color:green;'> /* 체크된 row 수 */ </p><br />
                        <p style='display:inline;color:blue;'>grid24.GetCheckRow()[0][&#34;IDX&#34;];</p> <p style='display:inline;color:green;'> /* 체크된 0번째 row의 &#34;IDX&#34; 값 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid24" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="true" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField DataField="TITLE" Edit="false" TextField="TITLE" Description="TITLE" Width="120" Hidden="false"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT218">GetRow()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT489" runat="server" LangCode="TXT489" Description="- 해당 컨트롤의 Row"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT490" runat="server" LangCode="TXT490" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 선택할 index 값은 0부터 1씩 증가한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CurrData.Rows[i] 를 사용하기도 한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT491" runat="server" LangCode="TXT491" Description="
                        <p style='display:inline;color:blue;'>grid24.GetRow(0)[&#34;TITLE&#34;];</p> <p style='display:inline;color:green;'> /* 해당 컨트롤의 0번째 row의 &#34;TITLE&#34; 값 */ </p><br />
                        <p style='display:inline;color:blue;'>grid24.CurrData.Rows[0][&#34;TITLE&#34;];</p> <p style='display:inline;color:green;'> /* 해당 컨트롤의 0번째 row의 &#34;TITLE&#34; 값 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT222">InsertRow()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT497" runat="server" LangCode="TXT497" Description="- 해당 컨트롤의 빈 Row를 추가한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT498" runat="server" LangCode="TXT498" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT499" runat="server" LangCode="TXT499" Description="
                        <p style='display:inline;color:blue;'>grid25.InsertRow();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid25" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="false" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField DataField="TITLE" Edit="true" TextField="TITLE" Description="TITLE" Width="120" Hidden="false"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnInsert25" runat="server" LangCode="btnInsert25" Description="InsertRow()" OnClientClick="grid25.InsertRow();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT236">RemoveAllRow()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT521" runat="server" LangCode="TXT521" Description="- 해당 컨트롤의 모든 Row를 삭제한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT522" runat="server" LangCode="TXT522" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT523" runat="server" LangCode="TXT523" Description="
                        <p style='display:inline;color:blue;'>grid26.RemoveAllRow();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid26" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField DataField="TITLE" Edit="true" TextField="TITLE" Description="TITLE" Width="120" Hidden="false"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnRemoveAll26" runat="server" LangCode="btnRemoveAll26" Description="RemoveAllRow()" OnClientClick="grid26.RemoveAllRow();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT226">RemoveRows()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT505" runat="server" LangCode="TXT505" Description="- 해당 컨트롤의 Row를 삭제한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT506" runat="server" LangCode="TXT506" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 여러 Row를 삭제할 수 있다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 삭제할 Row의 index 값들을 배열형식으로 넣는다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 선택할 index 값은 0부터 1씩 증가한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT507" runat="server" LangCode="TXT507" Description="
                        <p style='display:inline;color:green;'>/* 삭제할 Row의 index를 [0,1] 와 같은 배열형식으로 넣는다. */</p><br />
                        <p style='display:inline;color:blue;'>grid27.RemoveRows([0,1])</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid27" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField DataField="TITLE" Edit="true" TextField="TITLE" Description="TITLE" Width="120" Hidden="false"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnRemove27" runat="server" LangCode="btnRemove27" Description="RemoveRows()" OnClientClick="grid27.RemoveRows([0,1]);"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT228">SetValue()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT509" runat="server" LangCode="TXT509" Description="- 해당 컨트롤의 Value를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT510" runat="server" LangCode="TXT510" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 변경할 Row 의 index, 칼럼명, 변경할 값을 넣어준다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 변경할 Row 의 index 값은 0부터 1씩 증가한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT511" runat="server" LangCode="TXT511" Description="
                        <p style='display:inline;color:green;'> /* 0번째 row의 &#34;IDX&#34; 칼럼 값을 &#34;9999&#34;로 변경한다. */ </p><br />
                        <p style='display:inline;color:blue;'>grid1.SetValue(&#34;0&#34;, &#34;IDX&#34;, &#34;9999&#34;);</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid28" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField DataField="TITLE" Edit="true" TextField="TITLE" Description="TITLE" Width="120" Hidden="false"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnSetValue28" runat="server" LangCode="btnSetValue28" Description="SetValue()" OnClientClick="grid28.SetValue(0,'IDX','9999');"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT232">$().css()</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT517" runat="server" LangCode="TXT517" Description="- 해당 컨트롤의 Row 와 Cell의 배경색을 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT518" runat="server" LangCode="TXT518" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; jquery를 이용하여 row 또는 Cell 의 배경색을 변경한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; cell css 변경 >  StripeColorF 또는 StripeColorL 속성 > row css 변경 순으로 우선적용된다. <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; row css 변경 시 $('#[grid id]_MainRow_' + [row index]).css('background', '#FFBDBD'); 형식으로 사용한다. <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; cell css 변경 시 $('#[grid id]_' + [row index] + '_[column index]').css('background', 'Red');형식으로 사용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; index 값은 0부터 1씩 증가한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT519" runat="server" LangCode="TXT519" Description="
                        <p style='display:inline;color:green;'>/* row css 변경 시. grid29 의 0번째 row의 배경색을 #FFBDBD 로 변경한다. */</p><br />
                        <p style='display:inline;color:blue;'>$('#grid29_MainRow_' + 0).css('background', '#FFBDBD');</p><br />
                        <p style='display:inline;color:green;'>/* cell css 변경 시. grid29 의 1번째 row의 0번째 column의 배경색을 #BDBDFF 로 변경한다. */</p><br />
                        <p style='display:inline;color:blue;'>$('#grid29_' + 1 + '_0').css('background', '#BDBDFF');</p><br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid29" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" StripeColorF="#888888" StripeColorL="#aaaaaa" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField DataField="TITLE" Edit="true" TextField="TITLE" Description="TITLE" Width="120" Hidden="false"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnCssChange29_1" runat="server" LangCode="btnCssChange29_1" Description="rowChange()" OnClientClick="$('#grid29_MainRow_' + 0).css('background', '#FFBDBD');"></Ctl:Button>
                            <Ctl:Button ID="btnCssChange29_2" runat="server" LangCode="btnCssChange29_2" Description="cellChange()" OnClientClick="$('#grid29_' + 1 + '_0').css('background', '#BDBDFF');"></Ctl:Button>
                        </div>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--SheetField Properties List-->
        <Ctl:Layer ID="layer9" runat="server" Title="&#60SheetField&#62 Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT551" runat="server" LangCode="TXT551" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT552" runat="server" LangCode="TXT552" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT657">Align</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT554" runat="server" LangCode="TXT554" Description="- 해당 Field의 데이터 정렬"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT661">AutoMerge</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT556" runat="server" LangCode="TXT556" Description="- 해당 Field의 동일 데이터 결합 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT733">DataTextField</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT592" runat="server" LangCode="TXT558" Description="- 해당 Feild 의 데이터바인딩 TextField"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT665">DataField</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT558" runat="server" LangCode="TXT558" Description="- 해당 Field의 DataField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT737">DataValueField</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT594" runat="server" LangCode="TXT558" Description="- 해당 Feild 의 데이터바인딩 ValueField"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT669">DataType</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT560" runat="server" LangCode="TXT560" Description="- 해당 Field의 표시 데이터타입"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT673">Description</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT562" runat="server" LangCode="TXT562" Description="- 해당 Field 의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT677">Edit</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT564" runat="server" LangCode="TXT564" Description="- 해당 Field 의 편집모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT681">EditType</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT566" runat="server" LangCode="TXT566" Description="- 해당 Field 의 편집모드 칼럼형태"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT685">Fix</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT568" runat="server" LangCode="TXT568" Description="- 해당 Field 의 틀고정 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT689">HAlign</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT570" runat="server" LangCode="TXT570" Description="- 해당 Field 의 칼럼헤드 정렬"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT693">Hidden</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT572" runat="server" LangCode="TXT572" Description="- 해당 Field 의 숨김여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT697">HiddenHeader</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT574" runat="server" LangCode="TXT574" Description="- 해당 Field 의 칼럼헤드 숨김여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT701">MethodName</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT576" runat="server" LangCode="TXT576" Description="- 해당 Field 의 Biz의 메소드명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT705">Params</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT578" runat="server" LangCode="TXT578" Description="- 해당 Field 의 Biz에 넘겨줄 파라미터"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT709">StripeColorF</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT580" runat="server" LangCode="TXT580" Description="- 해당 Filed의 짝수줄 배경색"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT713">StripeColorL</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT582" runat="server" LangCode="TXT582" Description="- 해당 Filed의 홀수줄 배경색"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT721">TextField</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT586" runat="server" LangCode="TXT586" Description="- 해당 Field의 칼럼헤드 다국어 언어코드"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT725">TypeName</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT588" runat="server" LangCode="TXT588" Description="- 해당 Field의 Biz명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT729">Width</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT590" runat="server" LangCode="TXT590" Description="- 해당 Field의 너비"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
        
        <!--SheetField Events List-->
        <Ctl:Layer ID="layer10" runat="server" Title="&#60SheetField&#62 Events" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT601" runat="server" LangCode="TXT601" Description="Events"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT602" runat="server" LangCode="TXT602" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT757">OnClick</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT604" runat="server" LangCode="TXT604" Description="- 해당 field 클릭 시 발생할 스크립트 이벤트"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--SheetField Properties Examples-->
        <Ctl:Layer ID="layer11" runat="server" Title="&#60SheetField&#62 Properties Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT651" runat="server" LangCode="TXT651" Description="Properties"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT652" runat="server" LangCode="TXT652" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT653" runat="server" LangCode="TXT653" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT654" runat="server" LangCode="TXT654" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT655" runat="server" LangCode="TXT655" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT554">Align</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT657" runat="server" LangCode="TXT657" Description="- 해당 Field의 데이터의 정렬"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT658" runat="server" LangCode="TXT658" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Align 에는 Left | Center | Right 값을 사용한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT659" runat="server" LangCode="TXT659" Description="
                        <p style='display:inline;color:blue;'>Align=&#34;right&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid30" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="right" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT556">AutoMerge</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT661" runat="server" LangCode="TXT661" Description="- 해당 Field의 동일 데이터 결합 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT662" runat="server" LangCode="TXT662" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; field가 AutoMerge=&#34;true&#34; 인 경우 상하로 데이터가 같으면 결합한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT663" runat="server" LangCode="TXT663" Description="
                        <p style='display:inline;color:blue;'>AutoMerge=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid31" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="33%" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="true" DataField="CREATENM" DataType="Text" Description="CREATENM" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="CREATENM"  Width="66%" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT558">DataField</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT665" runat="server" LangCode="TXT665" Description="- 해당 Field의 DataField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT666" runat="server" LangCode="TXT666" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT667" runat="server" LangCode="TXT667" Description="
                        <p style='display:inline;color:blue;'>DataField=&#34;NO&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid32" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="33%" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT592">DataTextField</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT733" runat="server" LangCode="TXT733" Description="- 해당 Feild 의 데이터바인딩 TextField"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT734" runat="server" LangCode="TXT734" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Combo, Radio 와 같이 feild에 데이터 바인딩 시 사용
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT735" runat="server" LangCode="TXT735" Description="
                        <p style='display:inline;color:blue;'>DataTextField=&#34;TITLE&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT560">DataType</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT669" runat="server" LangCode="TXT669" Description="- 해당 Field의 표시 데이터타입"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT670" runat="server" LangCode="TXT670" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; DataType 에는 Text | Date | Number | Button | TextArea 을 사용한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT671" runat="server" LangCode="TXT671" Description="
                        <p style='display:inline;color:blue;'>DataType=&#34;Text&#34;</p><br />
                        <p style='display:inline;color:blue;'>DataType=&#34;Date&#34;</p> <br />
                        <p style='display:inline;color:blue;'>DataType=&#34;Number&#34;</p> <br />
                        <p style='display:inline;color:blue;'>DataType=&#34;Button&#34;</p> <br />
                        <p style='display:inline;color:blue;'>DataType=&#34;TextArea&#34;</p> <br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid33" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="Text" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="50" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="CREATEDT" DataType="Date" Description="Date" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="IDX"  Width="80" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Number" Description="Number" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="50" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Button" Description="Button" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="50" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="TextArea" Description="TextArear" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="50" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT594">DataValueField</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT737" runat="server" LangCode="TXT737" Description="- 해당 Feild 의 데이터바인딩 ValueField"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT738" runat="server" LangCode="TXT738" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Combo, Radio 와 같이 feild에 데이터 바인딩 시 사용
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT739" runat="server" LangCode="TXT739" Description="
                        <p style='display:inline;color:blue;'>DataValueField=&#34;TITLE&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT562">Description</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT673" runat="server" LangCode="TXT673" Description="- 해당 Field 의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT674" runat="server" LangCode="TXT674" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 Field의 다국어코드가 등록되지 않았을 경우 Description을 칼럼헤드에 표시한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Description에는 string 값을 사용한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT675" runat="server" LangCode="TXT675" Description="
                        <p style='display:inline;color:blue;'>Description=&#34;순서&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid34" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="순서" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT564">Edit</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT677" runat="server" LangCode="TXT677" Description="- 해당 Field 의 편집모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT678" runat="server" LangCode="TXT678" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Edit 에는 true | false 값을 사용한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Edit 가 true인 feild는 오른쪽 상단에 녹색삼각형 표시가 보인다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; feild 클릭 시 수정할 수 있다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT679" runat="server" LangCode="TXT679" Description="
                        <p style='display:inline;color:blue;'>Edit=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid36" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT566">EditType</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT681" runat="server" LangCode="TXT681" Description="- 해당 Field 의 편집모드 칼럼형태"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT682" runat="server" LangCode="TXT682" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; EditType 에는 Text | Combo | Calendar | Radio | CheckBox | SearchView 값을 사용한다. <br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Combo, Radio, CheckBox, SearchView 값 사용 시 해당 컨트롤과 같은 방식으로 사용 한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT683" runat="server" LangCode="TXT683" Description="
                        <p style='display:inline;color:blue;'>EditType=&#34;Text&#34;</p><br/>
                        <p style='display:inline;color:blue;'>EditType=&#34;Combo&#34;</p><br/>
                        <p style='display:inline;color:blue;'>EditType=&#34;Calendar&#34;</p><br/>
                        <p style='display:inline;color:blue;'>EditType=&#34;Radio&#34;</p><br/>
                        <p style='display:inline;color:blue;'>EditType=&#34;CheckBox&#34;</p><br/>
                        <p style='display:inline;color:blue;'>EditType=&#34;SearchView&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid37" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="TITLE" DataType="Text" Description="Text" Edit="true" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="50" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="TITLE" DataTextField="TITLE" DataValueField="TITLE" Description="Combo" Edit="true" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="TITLE" TypeName="Template.TemplateBiz" Width="50" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="CREATEDT" DataType="Text" Description="Calendar" Edit="true" EditType="Calendar" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="50" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="TITLE" DataTextField="TITLE" DataValueField="TITLE" Description="Radio" Edit="true" EditType="Radio" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="TITLE" TypeName="Template.TemplateBiz" Width="50" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="TITLE" DataTextField="TITLE" DataValueField="TITLE" Description="CheckBox" Edit="true" EditType="CheckBox" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="TITLE" TypeName="Template.TemplateBiz" Width="50" OnClick="null" />
                            <Ctl:SheetField DataField="IDX" TextField="IDX" Description="SearchView" Width="70" HAlign="center" Align="left" Edit="true" runat="server" EditType="SearchView" TypeName="Template.TemplateBiz" MethodName="ListTemplate">
                                <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                                <Ctl:SearchViewField DataField="ROWNO" TextField="ROWNO" Description="순번" Hidden="false" Width="100" TextBox="true" runat="server" />
                                <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                            </Ctl:SheetField>
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT568">Fix</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT685" runat="server" LangCode="TXT685" Description="- 해당 Field 의 틀고정 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT686" runat="server" LangCode="TXT686" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; WebSheet의 Fixation=&#34;true&#34;인 경우에만 사용할 수 있다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Fix에는 true | false 값을 사용한다. <br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Fix가 true인 field는 왼쪽에 틀고정 된다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT687" runat="server" LangCode="TXT687" Description="
                        <p style='display:inline;color:blue;'>Fix=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <div style="position:relative;width:100%;">
                            <Ctl:WebSheet ID="grid35" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Fixation="true" Height="120" HFixation="false" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                                <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="false" EditType="Combo" Fix="true" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="90" OnClick="null" />
                                <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="TITLE" DataTextField="TITLE" DataValueField="IDX" Description="TITLE" Edit="false" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="TITLE" TypeName="Template.TemplateBiz" Width="200" OnClick="null" />
                                <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="TITLE" DataTextField="TITLE" DataValueField="IDX" Description="TITLE" Edit="false" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="TITLE" TypeName="Template.TemplateBiz" Width="200" OnClick="null" />
                            </Ctl:WebSheet>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT570">HAlign</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT689" runat="server" LangCode="TXT689" Description="- 해당 Field 의 칼럼헤드 정렬"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT690" runat="server" LangCode="TXT690" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183;HAlign 에는 Left | Center | Right 값을 사용한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT691" runat="server" LangCode="TXT691" Description="
                        <p style='display:inline;color:blue;'>HAlign=&#34;right&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid38" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="right" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT572">Hidden</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT693" runat="server" LangCode="TXT693" Description="- 해당 Field 의 숨김여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT694" runat="server" LangCode="TXT694" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Hidden 에는 true | false 값을 사용한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT695" runat="server" LangCode="TXT695" Description="
                        <p style='display:inline;color:blue;'>Hidden=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT574">HiddenHeader</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT697" runat="server" LangCode="TXT697" Description="- 해당 Field 의 칼럼헤드 숨김여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT698" runat="server" LangCode="TXT698" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; HiddenHeader에는 true | false 값을 사용한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; SheetHeader 와 같이 사용한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT699" runat="server" LangCode="TXT699" Description="
                        <p style='display:inline;color:blue;'>HiddenHeader=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid39" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="1" Description="NO Head" Height="20" RowIndex="0" Rowspan="1" TextField="NO" />

                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="true" TextField="NO"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT576">MethodName</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT701" runat="server" LangCode="TXT701" Description="- 해당 Field 의 Biz의 메소드명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT702" runat="server" LangCode="TXT702" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 Field 에 데이터 바인딩 시 사용
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT703" runat="server" LangCode="TXT703" Description="
                        <p style='display:inline;color:blue;'>MethodName=&#34;ListTemplatePaging&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT578">Params</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT705" runat="server" LangCode="TXT705" Description="- 해당 Field 의 Biz에 넘겨줄 파라미터"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT706" runat="server" LangCode="TXT706" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 Field 에 데이터 바인딩 시 사용
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT707" runat="server" LangCode="TXT707" Description="
                        <p style='display:inline;color:blue;'>{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT580">StripeColorF</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT709" runat="server" LangCode="TXT709" Description="- 해당 칼럼의 짝수줄 Filed의 배경색"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT710" runat="server" LangCode="TXT710" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; html 색상코드 값을 사용한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; StripeColorL 와 같이 사용한다.(미설정 시 rgb(0,0,0) 값으로 변경된다.)
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT711" runat="server" LangCode="TXT711" Description="
                        <p style='display:inline;color:blue;'>StripeColorF=&#34;yellow&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid40" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" StripeColorF="yellow" StripeColorL="orange" TextField="NO" Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>

                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT582">StripeColorL</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT713" runat="server" LangCode="TXT713" Description="- 해당 칼럼의 홀수줄 Filed의 배경색"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT714" runat="server" LangCode="TXT714" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; html 색상코드 값을 사용한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; StripeColorF 와 같이 사용한다.(미설정 시 rgb(0,0,0) 값으로 변경된다.)
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT715" runat="server" LangCode="TXT715" Description="
                        <p style='display:inline;color:blue;'>StripeColorL=&#34;orange&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid41" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" StripeColorF="yellow" StripeColorL="orange" TextField="NO" Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT586">TextField</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT721" runat="server" LangCode="TXT721" Description="- 해당 Field의 칼럼헤드 다국어 언어코드"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT722" runat="server" LangCode="TXT722" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 Field의 다국어코드가 등록되지 않았을 경우 Description을 칼럼헤드에 표시한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT723" runat="server" LangCode="TXT723" Description="
                        <p style='display:inline;color:blue;'>TextField=&#34;NO&#34;</p> Description=&#34;넘버&#34;
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid42" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="넘버" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NOCODE" Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT588">TypeName</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT725" runat="server" LangCode="TXT725" Description="- 해당 Field의 Biz명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT726" runat="server" LangCode="TXT726" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 Field 에 데이터 바인딩 시 사용  
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT727" runat="server" LangCode="TXT727" Description="
                        <p style='display:inline;color:blue;'>TypeName=&#34;Template.TemplateBiz&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT590">Width</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT729" runat="server" LangCode="TXT729" Description="- 해당 Field의 너비"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT730" runat="server" LangCode="TXT730" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT731" runat="server" LangCode="TXT731" Description="
                        <p style='display:inline;color:blue;'>Width=&#34;50&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid43" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="너비50" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NOCODE" Width="50" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="여분" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NOCODE" Width="*" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--SheetField Events Examples-->
        <Ctl:Layer ID="layer12" runat="server" Title="&#60SheetField&#62 Events Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT751" runat="server" LangCode="TXT751" Description="Events"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT752" runat="server" LangCode="TXT752" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT753" runat="server" LangCode="TXT753" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT754" runat="server" LangCode="TXT754" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT755" runat="server" LangCode="TXT755" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT604">OnClick</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT757" runat="server" LangCode="TXT757" Description="- 해당 컨트롤 field 시 발생할 스크립트 이벤트"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT758" runat="server" LangCode="TXT758" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 스크립트(row, cell) 형식으로 정의한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; row는 클릭한 row 의 index 이며, cell은 cell의 index이다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; index는 0부터 1씩 증가한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT759" runat="server" LangCode="TXT759" Description="
                        <p style='display:inline;color:blue;'>OnClick=&#34;grid44_Click&#34;</p><br/><br />
                        function grid44_Click(row, cell) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;alert();<br />
                        }
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid44" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO" Width="50" OnClick="grid44_Click" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="IDX"  Width="90" OnClick="grid44_Click" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--SheetHeader Properties List-->
        <Ctl:Layer ID="layer13" runat="server" Title="&#60SheetHeader&#62 Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT801" runat="server" LangCode="TXT801" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT802" runat="server" LangCode="TXT802" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT857">Align</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT804" runat="server" LangCode="TXT804" Description="- 해당 칼럼헤드의 텍스트 정렬"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT861">ColIndex</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT806" runat="server" LangCode="TXT806" Description="- 해당 칼럼헤드의 좌우 Index"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT865">Colspan</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT808" runat="server" LangCode="TXT808" Description="- 해당 칼럼헤드의 좌우병합 수"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT869">Description</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT810" runat="server" LangCode="TXT810" Description="- 해당 칼럼헤드의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT873">Height</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT812" runat="server" LangCode="TXT812" Description="- 해당 칼럼헤드의 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT877">RowIndex</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT814" runat="server" LangCode="TXT814" Description="- 해당 칼럼헤드의 상하 Index"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT881">Rowspan</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT816" runat="server" LangCode="TXT816" Description="- 해당 칼럼헤드의 상하병합 수"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT885">TextField</a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT818" runat="server" LangCode="TXT818" Description="- 해당 칼럼헤드의 다국어 언어코드"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
        
        <!--SheetHeader Properties Examples-->
        <Ctl:Layer ID="layer14" runat="server" Title="&#60SheetHeader&#62 Properties Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT851" runat="server" LangCode="TXT851" Description="Properties"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT852" runat="server" LangCode="TXT852" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT853" runat="server" LangCode="TXT853" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT854" runat="server" LangCode="TXT854" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT855" runat="server" LangCode="TXT855" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT804">Align</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT857" runat="server" LangCode="TXT857" Description="- 해당 칼럼헤드의 텍스트 정렬"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT858" runat="server" LangCode="TXT858" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Align 에는 Left | Center | Right 값을 사용한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT859" runat="server" LangCode="TXT859" Description="
                        <p style='display:inline;color:blue;'>Align=&#34;right&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid45" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetHeader runat="server" Align="right" ColIndex="0" Colspan="1" Description="NO Head" Height="20" RowIndex="0" Rowspan="1" TextField="NO" />

                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT806">ColIndex</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT861" runat="server" LangCode="TXT861" Description="- 해당 칼럼헤드의 좌우 Index"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT862" runat="server" LangCode="TXT862" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; index는 0부터 1씩 증가한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT863" runat="server" LangCode="TXT863" Description="
                        <p style='display:inline;color:blue;'>ColIndex=&#34;0&#34;</p> <p style='display:inline;color:green;'> /* No Head */ </p><br />
                        <p style='display:inline;color:blue;'>ColIndex=&#34;1&#34;</p> <p style='display:inline;color:green;'> /* IDX Head */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid46" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="1" Description="NO Head" Height="20" RowIndex="0" Rowspan="1" TextField="NO" />
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="1" Colspan="1" Description="IDX Head" Height="20" RowIndex="0" Rowspan="1" TextField="IDX" />

                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="IDX"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT808">Colspan</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT865" runat="server" LangCode="TXT865" Description="- 해당 칼럼헤드의 좌우병합 수"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT866" runat="server" LangCode="TXT866" Description="
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT867" runat="server" LangCode="TXT867" Description="
                        <p style='display:inline;color:blue;'>Colspan=&#34;2&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid47" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="2" Description="Colspan 2" Height="20" RowIndex="0" Rowspan="1" TextField="NO" />

                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="IDX"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT810">Description</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT869" runat="server" LangCode="TXT869" Description="- 해당 칼럼헤드의 설명"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT870" runat="server" LangCode="TXT870" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 칼럼헤드의 다국어코드가 등록되지 않았을 경우 Description을 칼럼헤드에 표시한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Description에는 string 값을 사용한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT871" runat="server" LangCode="TXT871" Description="
                        <p style='display:inline;color:blue;'>Description=&#34;NO Head&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid48" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="1" Description="NO Head" Height="20" RowIndex="0" Rowspan="1" TextField="NO" />

                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT812">Height</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT873" runat="server" LangCode="TXT873" Description="- 해당 칼럼헤드의 높이"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT874" runat="server" LangCode="TXT874" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 숫자만 입력시 px 단위로 변경된다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT875" runat="server" LangCode="TXT875" Description="
                        <p style='display:inline;color:blue;'>Height=&#34;70&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid49" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="1" Description="NO Head" Height="70" RowIndex="0" Rowspan="1" TextField="NO" />

                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT814">RowIndex</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT877" runat="server" LangCode="TXT877" Description="- 해당 칼럼헤드의 상하 Index"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT878" runat="server" LangCode="TXT878" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; index는 0부터 1씩 증가한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT879" runat="server" LangCode="TXT879" Description="
                        <p style='display:inline;color:blue;'>RowIndex=&#34;0&#34;</p> <p style='display:inline;color:green;'> /* NO Head 1 */ </p><br />
                        <p style='display:inline;color:blue;'>RowIndex=&#34;1&#34;</p> <p style='display:inline;color:green;'> /* NO Head 2 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid50" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="1" Description="NO Head 1" Height="20" RowIndex="0" Rowspan="1" TextField="NO" />
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="1" Description="NO Head 2" Height="20" RowIndex="1" Rowspan="1" TextField="NO" />

                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT816">Rowspan</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT881" runat="server" LangCode="TXT881" Description="- 해당 칼럼헤드의 상하병합 수"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT882" runat="server" LangCode="TXT882" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; SheetField 의 칼럼헤드도 병합의 대상이 된다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT883" runat="server" LangCode="TXT883" Description="
                        <p style='display:inline;color:blue;'>Rowspan=&#34;2&#34;</p> <p style='display:inline;color:green;'> /* NO Head */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid51" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="1" Description="NO Head" Height="20" RowIndex="0" Rowspan="2" TextField="NO" />
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="1" Colspan="1" Description="IDX Head" Height="20" RowIndex="0" Rowspan="1" TextField="IDX" />

                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataType="Text" Description="IDX" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="IDX"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT818">TextField</a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT885" runat="server" LangCode="TXT885" Description="- 해당 칼럼헤드의 다국어 언어코드"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT886" runat="server" LangCode="TXT886" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 해당 칼럼헤드의 다국어코드가 등록되지 않았을 경우 Description을 칼럼헤드에 표시한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr> 
                <tr>
                    <td>
                        <Ctl:Text ID="TXT887" runat="server" LangCode="TXT887" Description="
                        <p style='display:inline;color:blue;'>TextField=&#34;NO&#34;</p>  Description=&#34;NO Head&#34;
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid52" runat="server" AutoColumns="false" CheckAutoMergeTarget="0" CheckBox="false" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="false" PagingSize="3" TypeName="Template.TemplateBiz" UseColumnSort="false" Width="100%">
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="1" Description="NO Head" Height="20" RowIndex="0" Rowspan="1" TextField="NO" />

                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="NO" DataType="Text" Description="NO" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="NO"  Width="90" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>