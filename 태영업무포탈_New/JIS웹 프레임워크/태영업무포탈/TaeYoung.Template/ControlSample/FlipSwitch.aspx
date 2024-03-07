<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlipSwitch.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.FlipSwitch" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            //샘플 DataSet Grid Bind
            var ht = new Object();
            ht["PageSize"] = "5";
            grid99.Params(ht);
            grid99.BindList(1);

            flpIDX14.Hide();
        }

        /************************************************************************
        함수명		: fn_Redirect
        작성목적	: 해당 페이지로 이동한다.
        작 성 자	: 이정홍
        최초작성일	: 2018-05-31
        최종작성일	:
        수정내역	:
        *************************************************************************/
        function fn_Redirect(url) {
            self.location.href = "/WebTemplate/ControlSample/" + url + ".aspx";
            return false;
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / FlipSwitch
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="FlipSwitch Control Sample" Literal="true"></Ctl:Text></h4>

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
        <Ctl:Layer ID="layer1" runat="server" Title="FlipSwitch Control Sample" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="15%" />
                    <col width="55%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="구분"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="결과물"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT04" runat="server" LangCode="TXT04" Description="&#60ListItem&#62 사용"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT05" runat="server" LangCode="TXT05" Description="
                        &#60Ctl:FlipSwitch ID=&#34;flpIDX1&#34; runat=&#34;server&#34; DataMember=&#34;IDX1&#34; ReadMode=&#34;false&#34;&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60asp:ListItem Selected=&#34;True&#34; Text=&#34;값1&#34; Value=&#34;0&#34;&#62&#60/asp:ListItem&#62<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#60asp:ListItem Text=&#34;값2&#34; Value=&#34;2&#34;&#62&#60/asp:ListItem&#62<br/>
                        &#60/Ctl:FlipSwitch&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX1" runat="server" DataMember="IDX1" ReadMode="false">
                            <asp:ListItem Selected="True" Text="값1" Value="0"></asp:ListItem>
                            <asp:ListItem Text="값2" Value="2"></asp:ListItem>
                        </Ctl:FlipSwitch>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="데이터 바인딩"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="
                        &#60Ctl:FlipSwitch ID=&#34;flpIDX2&#34; runat=&#34;server&#34; DataMember=&#34;IDX2&#34; ReadMode=&#34;false&#34;&#62<br/>
                        &#60/Ctl:FlipSwitch&#62<br />
                        <br />
                        <p style='display:inherit;color:Green;'> /* FlipSwitch.aspx.cs 에 작성 */ </p><br />
                        protected override void OnLangInit(EventArgs e) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;using (TemplateBiz biz = new TemplateBiz())<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;{<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Hashtable ht = new Hashtable();<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ht[&#34;PageSize&#34;] = 6;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DataSet ds = biz.ListTemplate(ht);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flpIDX2.DataTextField = &#34;TITLE&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flpIDX2.DataValueField = &#34;IDX&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flpIDX2.SelectedValueField = &#34;NO&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flpIDX2.SelectedValueData = &#34;2560&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flpIDX2.DataSource = ds.Tables[0];<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flpIDX2.DataBind();<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;}<br />
                        <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;......<br />
                        }
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX2" runat="server" DataMember="IDX2" ReadMode="false">
                        </Ctl:FlipSwitch>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="FlipSwitch Control 샘플 DataSet" DefaultHide="False">
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
                        <Ctl:Text ID="TXT54" runat="server" LangCode="TXT54" Description="Template.TemplateBiz"></Ctl:Text>
                    </td>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT55" runat="server" LangCode="TXT55" Description="ListTemplate"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid99" runat="server" Paging="false" CheckBox="false" Width="100%" TypeName="Template.TemplateBiz" MethodName="ListTemplate">
                            <Ctl:SheetField DataField="NO" TextField="NO" Description="NO" Width="50"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="ROWNO" TextField="ROWNO" Description="ROWNO" Width="60"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="IDX" TextField="IDX" Description="IDX" Width="40"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="TITLE" TextField="TITLE" Description="TITLE" Width="60"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="CREATEDT" TextField="CREATEDT" Description="CREATEDT" Width="150"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="CREATENM" TextField="CREATENM" Description="CREATENM" Width="80"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="NUM" TextField="NUM" Description="NUM" Width="120"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="CREATEDT2" TextField="CREATEDT2" Description="CREATEDT2" Width="80"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties List-->
        <Ctl:Layer ID="layer3" runat="server" Title="FlipSwitch Control Properties" DefaultHide="False">
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
                        <a href="#TXT257"><Ctl:Text ID="TXT103" runat="server" LangCode="TXT103" Description="&#60ListItem&#62" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT104" runat="server" LangCode="TXT104" Description="- 해당 컨트롤의 플립스위치를 직접 추가한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT261"><Ctl:Text ID="TXT105" runat="server" LangCode="TXT105" Description="DataMember<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT106" runat="server" LangCode="TXT106" Description="- 해당 컨트롤의 DataMember 값 지정"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT265"><Ctl:Text ID="TXT107" runat="server" LangCode="TXT107" Description="DataSource" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT108" runat="server" LangCode="TXT108" Description="- 해당 컨트롤의 DataSource"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT269"><Ctl:Text ID="TXT109" runat="server" LangCode="TXT109" Description="DataTextField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT110" runat="server" LangCode="TXT110" Description="- 해당 컨트롤의 TextField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT273"><Ctl:Text ID="TXT111" runat="server" LangCode="TXT111" Description="DataValueField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT112" runat="server" LangCode="TXT112" Description="- 해당 컨트롤의 ValueField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT277"><Ctl:Text ID="TXT113" runat="server" LangCode="TXT113" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT114" runat="server" LangCode="TXT114" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT281"><Ctl:Text ID="TXT115" runat="server" LangCode="TXT115" Description="SelectedValueData" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT116" runat="server" LangCode="TXT116" Description="- 해당 컨트롤의 선택여부 결정값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT285"><Ctl:Text ID="TXT117" runat="server" LangCode="TXT117" Description="SelectedValueField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT118" runat="server" LangCode="TXT118" Description="- 해당 컨트롤의 선택여부 대상칼럼"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events List-->
        <Ctl:Layer ID="layer4" runat="server" Title="FlipSwitch Control Events" DefaultHide="False">
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
        <Ctl:Layer ID="layer5" runat="server" Title="FlipSwitch Control Functions" DefaultHide="False">
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
                        <a href="#TXT357"><Ctl:Text ID="TXT203" runat="server" LangCode="TXT203" Description="Controls.GetDataMemberValue()<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT204" runat="server" LangCode="TXT204" Description="- DataMember로 지정한 컨트롤들의 Value를 가져온다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT361"><Ctl:Text ID="TXT205" runat="server" LangCode="TXT205" Description="Controls.SetDataMemberValue()<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT206" runat="server" LangCode="TXT206" Description="- DataMember로 지정한 컨트롤들의 Value를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT365"><Ctl:Text ID="TXT207" runat="server" LangCode="TXT207" Description="DataBind()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT208" runat="server" LangCode="TXT208" Description="- 해당 컨트롤을 데이터 바인딩"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT369"><Ctl:Text ID="TXT209" runat="server" LangCode="TXT209" Description="GetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT210" runat="server" LangCode="TXT210" Description="- 해당 컨트롤의 Value를 가져온다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT373"><Ctl:Text ID="TXT211" runat="server" LangCode="TXT211" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT212" runat="server" LangCode="TXT212" Description="- 해당 컨트롤을 숨긴다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT377"><Ctl:Text ID="TXT213" runat="server" LangCode="TXT213" Description="SetDisabled()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT214" runat="server" LangCode="TXT214" Description="- 해당 컨트롤의 비활성화 여부를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT381"><Ctl:Text ID="TXT215" runat="server" LangCode="TXT215" Description="SetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT216" runat="server" LangCode="TXT216" Description="- 해당 컨트롤의 Value를 변경한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT385"><Ctl:Text ID="TXT217" runat="server" LangCode="TXT217" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT218" runat="server" LangCode="TXT218" Description="- 숨겨진 컨트롤을 보여준다."></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer6" runat="server" Title="FlipSwitch Control Properties Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT251" runat="server" LangCode="TXT251" Description="Properties"></Ctl:Text>
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
                        <a href="#TXT104"><Ctl:Text ID="TXT256" runat="server" LangCode="TXT256" Description="&#60ListItem&#62" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT257" runat="server" LangCode="TXT257" Description="- 해당 컨트롤의 플립스위치를 직접 추가한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT258" runat="server" LangCode="TXT258" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 데이터 바인딩 시 직접 추가한 내용보다 바인딩된 내용이 우선된다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Text : 플립스위치의 Text, Value : 플립스위치의 Value, Selected : 플립스위치의 Default 선택
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT259" runat="server" LangCode="TXT259" Description="
                        <p style='display:inline;color:blue;'>
                        &#60asp:ListItem Selected=&#34;True&#34; Text=&#34;값1&#34; Value=&#34;0&#34;&#62&#60/asp:ListItem&#62<br />
                        &#60asp:ListItem Text=&#34;값2&#34; Value=&#34;2&#34;&#62&#60/asp:ListItem&#62
                        </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX3" runat="server" DataMember="IDX3" ReadMode="false">
                            <asp:ListItem Selected="True" Text="값1" Value="0"></asp:ListItem>
                            <asp:ListItem Text="값2" Value="2"></asp:ListItem>
                        </Ctl:FlipSwitch>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT106"><Ctl:Text ID="TXT260" runat="server" LangCode="TXT260" Description="DataMember<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT261" runat="server" LangCode="TXT261" Description="- 해당 컨트롤의 DataMember 값 지정"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT262" runat="server" LangCode="TXT262" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; DataMember 에는 조회하는 데이터의 칼럼 명을 사용한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; DataMember 로 지정한 컨트롤들의 Value를 Controls.GetDataMemberValue() 로 가져오거나<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Controls.SetDataMemberValue() 로 Value에 바인딩한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT263" runat="server" LangCode="TXT263" Description="
                        <p style='display:inline;color:blue;'>
                        DataMember=&#34;IDX&#34;
                        </p>&nbsp;
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT108"><Ctl:Text ID="TXT264" runat="server" LangCode="TXT264" Description="DataSource" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT265" runat="server" LangCode="TXT265" Description="- 해당 컨트롤의 DataSource"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT266" runat="server" LangCode="TXT266" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CS페이지에서 데이터바인딩 전에 DataSource 값을 준다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 플립스위치로 사용할 데이터테이블 값을 사용한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT267" runat="server" LangCode="TXT267" Description="
                        <p style='display:inline;color:Green;'> /* FlipSwitch.aspx.cs 에 작성 */</p><br />
                        Hashtable ht = new Hashtable();<br />
                        ht[&#34;PageSize&#34;] = 6;<br />
                        DataSet ds = biz.ListTemplate(ht);<br />
                        <br />
                        <p style='display:inline;color:blue;'>flpIDX4.DataSource = ds.Tables[0];</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX4" runat="server" DataMember="IDX4" ReadMode="false">
                        </Ctl:FlipSwitch>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT110"><Ctl:Text ID="TXT268" runat="server" LangCode="TXT268" Description="DataTextField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT269" runat="server" LangCode="TXT269" Description="- 해당 컨트롤의 TextField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT270" runat="server" LangCode="TXT270" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CS페이지에서 데이터바인딩 전에 DataTextField 값을 준다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT271" runat="server" LangCode="TXT271" Description="
                        <p style='display:inline;color:Green;'> /* FlipSwitch.aspx.cs 에 작성 */</p>
                        <br />
                        <p style='display:inline;color:blue;'>flpIDX5.DataTextField = &#34;TITLE&#34;;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX5" runat="server" DataMember="IDX5" ReadMode="false">
                        </Ctl:FlipSwitch>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT112"><Ctl:Text ID="TXT272" runat="server" LangCode="TXT272" Description="DataValueField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT273" runat="server" LangCode="TXT273" Description="- 해당 컨트롤의 ValueField용 칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT274" runat="server" LangCode="TXT274" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CS페이지에서 데이터바인딩 전에 DataValueField 값을 준다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT275" runat="server" LangCode="TXT275" Description="
                        <p style='display:inline;color:Green;'> /* FlipSwitch.aspx.cs 에 작성 */</p>
                        <br />
                        <p style='display:inline;color:blue;'>flpIDX6.DataValueField = &#34;IDX&#34;;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX6" runat="server" DataMember="IDX6" ReadMode="false">
                        </Ctl:FlipSwitch>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT114"><Ctl:Text ID="TXT276" runat="server" LangCode="TXT276" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT277" runat="server" LangCode="TXT277" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT278" runat="server" LangCode="TXT278" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 선택된 플립스위치의 Text를 표시한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ReadMode 에는 true | false 값을 사용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 여러 플립스위치가 선택되었을 경우 Text1, Text2, ... 형식으로 표시한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT279" runat="server" LangCode="TXT279" Description="
                        <p style='display:inline;color:blue;'>ReadMode=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX7" runat="server" DataMember="IDX7" ReadMode="true">
                        </Ctl:FlipSwitch>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT116"><Ctl:Text ID="TXT280" runat="server" LangCode="TXT280" Description="SelectedValueData" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT281_1" runat="server" LangCode="TXT281_1" Description=""></Ctl:Text>
                        <Ctl:Text ID="TXT281" runat="server" LangCode="TXT281" Description="- 해당 컨트롤의 선택여부 결정값"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT282" runat="server" LangCode="TXT282" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CS페이지에서 데이터바인딩 전에 SelectedValueData 값을 준다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 선택여부 대상칼럼 값이 선택여부 결정값과 동일한 플립 스위치들을 선택한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT283" runat="server" LangCode="TXT283" Description="
                        <p style='display:inline;color:Green;'> /* FlipSwitch.aspx.cs 에 작성 */</p>
                        <br />
                        flpIDX8.SelectedValueField = &#34;IDX&#34;; <p style='display:inline;color:green;'> /* 선택여부 대상칼럼 */ </p><br />
                        <p style='display:inline;color:blue;'>flpIDX8.SelectedValueData = &#34;2560&#34;;</p> <p style='display:inline;color:green;'> /* 선택여부 결정값 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX8" runat="server" DataMember="IDX8" ReadMode="false">
                        </Ctl:FlipSwitch>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT118"><Ctl:Text ID="TXT284" runat="server" LangCode="TXT284" Description="SelectedValueField" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT285" runat="server" LangCode="TXT285" Description="- 해당 컨트롤의 선택여부 대상칼럼"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT286" runat="server" LangCode="TXT286" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CS페이지에서 데이터바인딩 전에 SelectedValueField 값을 준다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 선택여부 대상칼럼 값이 선택여부 결정값과 동일한 플립 스위치들을 선택한다.
                        "></Ctl:Text>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT287" runat="server" LangCode="TXT287" Description="
                        <p style='display:inline;color:Green;'> /* FlipSwitch.aspx.cs 에 작성 */</p>
                        <br />
                        <p style='display:inline;color:blue;'>flpIDX9.SelectedValueField = &#34;IDX&#34;;</p> <p style='display:inline;color:green;'> /* 선택여부 대상칼럼 */ </p><br />
                        flpIDX9.SelectedValueData = &#34;2560&#34;; <p style='display:inline;color:green;'> /* 선택여부 결정값 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX9" runat="server" DataMember="IDX9" ReadMode="false">
                        </Ctl:FlipSwitch>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="FlipSwitch Control Events Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT301" runat="server" LangCode="TXT301" Description="Events"></Ctl:Text>
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
            </table>
        </Ctl:Layer>

        <!--Functions Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="FlipSwitch Control Functions Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT351" runat="server" LangCode="TXT351" Description="Functions"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT352" runat="server" LangCode="TXT352" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT353" runat="server" LangCode="TXT353" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT354" runat="server" LangCode="TXT354" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT355" runat="server" LangCode="TXT355" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT204"><Ctl:Text ID="TXT356" runat="server" LangCode="TXT356" Description="Controls.GetDataMemberValue()<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT357" runat="server" LangCode="TXT357" Description="- DataMember로 지정한 컨트롤들의 Value를 가져온다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT358" runat="server" LangCode="TXT358" Description="
                        
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT359" runat="server" LangCode="TXT359" Description="
                        <p style='display:inline;color:Blue;'>Controls.GetDataMemberValue()</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT206"><Ctl:Text ID="TXT360" runat="server" LangCode="TXT360" Description="Controls.SetDataMemberValue()<br/><p style='display:inline;color:red;'>(지원예정)</p>" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT361" runat="server" LangCode="TXT361" Description="- DataMember로 지정한 컨트롤들의 Value를 변경한다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT362" runat="server" LangCode="TXT362" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; RowData 값의 칼럼과 일치하는 DataMember 의 컨트롤들에 Value를 바인딩한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT363" runat="server" LangCode="TXT363" Description="
                        <p style='display:inline;color:Blue;'>Controls.SetDataMemberValue(<p style='display:inline;color:Green;'>/* RowData 값 사용 */</p>)</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT208"><Ctl:Text ID="TXT364" runat="server" LangCode="TXT364" Description="DataBind()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT365" runat="server" LangCode="TXT365" Description="- 해당 컨트롤을 데이터 바인딩" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT366" runat="server" LangCode="TXT366" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; CS페이지에서 데이터바인딩한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT367" runat="server" LangCode="TXT367" Description="
                        <p style='display:inline;color:Green;'> /* FlipSwitch.aspx.cs 에 작성 */</p><br />
                        using (TemplateBiz biz = new TemplateBiz())<br />
                        {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;Hashtable ht = new Hashtable();<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;ht[&#34;PageSize&#34;] = 6;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;DataSet ds = biz.ListTemplate(ht);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;flpIDX10.DataTextField = &#34;TITLE&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;flpIDX10.DataValueField = &#34;IDX&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;flpIDX10.SelectedValueField = &#34;NO&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;flpIDX10.SelectedValueData = &#34;2560&#34;;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;flpIDX10.DataSource = ds.Tables[0];<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Blue;'>flpIDX10.DataBind();</p> <p style='display:inline;color:Green;'> /* flpIDX10 컨트롤을 데이터바인딩 */</p><br />
                        }
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX10" runat="server" DataMember="IDX10" ReadMode="false">
                        </Ctl:FlipSwitch>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT210"><Ctl:Text ID="TXT368" runat="server" LangCode="TXT368" Description="GetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT369" runat="server" LangCode="TXT369" Description="- 해당 컨트롤의 Value를 가져온다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT370" runat="server" LangCode="TXT370" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).GetValue() 는 배열 값을 반환한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT371" runat="server" LangCode="TXT371" Description="
                        <p style='display:inline;color:blue;'> flpIDX10.GetValue(); </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT212"><Ctl:Text ID="TXT372" runat="server" LangCode="TXT372" Description="Hide()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT373" runat="server" LangCode="TXT373" Description="- 해당 컨트롤을 숨긴다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT374" runat="server" LangCode="TXT374" Description="
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT375" runat="server" LangCode="TXT375" Description="
                        <p style='display:inline;color:blue;'>flpIDX11.Hide();</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX11" runat="server" DataMember="IDX10" ReadMode="false">
                        </Ctl:FlipSwitch>
                        <div style="display:block;width:100%;margin-top:10px;float:left;">
                            <Ctl:Button ID="btnIDX11" runat="server" LangCode="btnIDX11" Description="Hide()" OnClientClick="flpIDX11.Hide();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT214"><Ctl:Text ID="TXT376" runat="server" LangCode="TXT376" Description="SetDisabled()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT377" runat="server" LangCode="TXT377" Description="- 해당 컨트롤의 비활성화 여부를 변경한다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT378" runat="server" LangCode="TXT378" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).SetDisabled(true | false);
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT379" runat="server" LangCode="TXT379" Description="
                        <p style='display:inline;color:blue;'>flpIDX12.SetDisabled(true);</p> <p style='display:inline;color:green;'> /* 비활성화 */ </p><br />
                        <p style='display:inline;color:blue;'>flpIDX12.SetDisabled(false);</p> <p style='display:inline;color:green;'> /* 활성화 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX12" runat="server" DataMember="flpIDX12" ReadMode="false">
                        </Ctl:FlipSwitch>
                        <div style="display:block;width:100%;margin-top:10px;float:left;">
                            <Ctl:Button ID="btnIDX12_1" runat="server" LangCode="btnIDX12_1" Description="비활성화" OnClientClick="flpIDX12.SetDisabled(true);"></Ctl:Button>
                            <Ctl:Button ID="btnIDX12_2" runat="server" LangCode="btnIDX12_2" Description="활성화" OnClientClick="flpIDX12.SetDisabled(false);"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT216"><Ctl:Text ID="TXT380" runat="server" LangCode="TXT380" Description="SetValue()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT381" runat="server" LangCode="TXT381" Description="- 해당 컨트롤의 Value를 변경한다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT382" runat="server" LangCode="TXT382" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).SetValue(str); <p style='display:inline;color:green'> /* str변수에는 변경할 값을 준다 */ </p><br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; str = Value, 선택해제 시 : str = &#34;&#34;
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT383" runat="server" LangCode="TXT383" Description="
                        <p style='display:inline;color:blue;'>flpIDX13.SetValue(2563);</p> <p style='display:inline;color:green;'> /* Value=2563 인 플립스위치 선택 */ </p><br />
                        <p style='display:inline;color:blue;'>flpIDX13.SetValue(&#34;&#34;);</p> <p style='display:inline;color:green;'> /* 선택해제 */ </p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX13" runat="server" DataMember="flpIDX13" ReadMode="false">
                        </Ctl:FlipSwitch>
                        <div style="display:block;width:100%;margin-top:10px;float:left;">
                            <Ctl:Button ID="btnIDX13_1" runat="server" LangCode="btnIDX13_1" Description="2563 선택" OnClientClick="flpIDX13.SetValue(2563);"></Ctl:Button>
                            <Ctl:Button ID="btnIDX13_2" runat="server" LangCode="btnIDX13_2" Description="선택해제" OnClientClick="flpIDX13.SetValue('');"></Ctl:Button>
                        </div>
                    </td>
                </tr>



                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT218"><Ctl:Text ID="TXT384" runat="server" LangCode="TXT384" Description="Show()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT385" runat="server" LangCode="TXT385" Description="- 숨겨진 컨트롤을 보여준다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT386" runat="server" LangCode="TXT386" Description="
                        " />&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT387" runat="server" LangCode="TXT387" Description="
                        <p style='display:inline;color:blue'>flpIDX14.Show();</p> 
                        "></Ctl:Text>&nbsp;
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX14" runat="server" DataMember="flpIDX14" ReadMode="false">
                        </Ctl:FlipSwitch>
                        <div style="display:block;width:100%;margin-top:10px;float:left;">
                            <Ctl:Button ID="btnIDX14" runat="server" LangCode="btnIDX14" Description="Show()" OnClientClick="flpIDX14.Show();"></Ctl:Button>
                        </div>
                    </td>
                </tr>



            </table>
        </Ctl:Layer>
    </div>
</asp:content>