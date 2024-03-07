<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.Index" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            grid1.Params(ht); // 선언한 파라미터를 그리드에 전달함
            grid1.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
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
            if (false) {
                alert('<Ctl:Text ID="MSG01" runat="server" LangCode="MSG01" Description="해당 페이지는 업데이트 예정입니다." Literal="true"></Ctl:Text>');
                return false;
            }
            self.location.href = "/Template/ControlSample/" + url + ".aspx";
            return false;
        }
    </script>
</asp:content>
<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="WebControl Index" Literal="true"></Ctl:Text></h4>
        <div class="btn_bx">
        </div>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <!--기본샘플-->
        <Ctl:Layer ID="layer1" runat="server" Title="WebControl Index" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="50%" />
                    <col width="50%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT20" runat="server" LangCode="TXT20" Description="Control Link"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT21" runat="server" LangCode="TXT21" Description="Sample"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('Button');">
                            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="Button" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:Button ID="btnBtn" runat="server" Description="Button" Hidden="false" LangCode="btnBtn" OnClientClick="return false;"></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('CheckBox');">
                            <Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="CheckBox" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:CheckBox ID="chkIDX1" runat="server" ReadMode="false" DataMember="chkBox1_1">
                            <asp:ListItem Text="첫번째" Value="1" Selected="true"></asp:ListItem>
                            <asp:ListItem Text="두번째" Value="2" ></asp:ListItem>
                            <asp:ListItem Text="세번째" Value="3" ></asp:ListItem>
                        </Ctl:CheckBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('Combo');">
                            <Ctl:Text ID="TXT04" runat="server" LangCode="TXT04" Description="Combo" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:Combo ID="cboIDX1" runat="server" DataMember="IDX" ReadMode="false" SelectedIndex="0" SelectedValue="1" Width="200px" OnChanged="return false;">
                            <asp:ListItem Value="1" Text="첫번째" Selected="true"></asp:ListItem>
                            <asp:ListItem Value="2" Text="두번째"></asp:ListItem>
                            <asp:ListItem Value="3" Text="세번째"></asp:ListItem>
                        </Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('FileUpload');">
                            <Ctl:Text ID="TXT05" runat="server" LangCode="TXT05" Description="FileUpload" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:FileUpload ID="fuName1" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('FlipSwitch');">
                            <Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="FlipSwitch" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:FlipSwitch ID="flpIDX1" runat="server" DataMember="IDX1" ReadMode="false">
                        </Ctl:FlipSwitch>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('Layer');">
                            <Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="Layer" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:Layer ID="layer99" runat="server" DefaultHide="false" Description="단일 레이어" LangCode="layer99" ReadMode="false" Title="레이어 제목"></Ctl:Layer>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('Radio');">
                            <Ctl:Text ID="TXT08" runat="server" LangCode="TXT08" Description="Radio" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:Radio ID="rdoIDX1" runat="server" DataMember="IDX" ReadMode="false" OnChanged="return false;">
                            <asp:ListItem Text="첫번째" Value="1" Selected="true"></asp:ListItem>
                            <asp:ListItem Text="두번째" Value="2" ></asp:ListItem>
                            <asp:ListItem Text="세번째" Value="3" ></asp:ListItem>
                        </Ctl:Radio>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('Rating');">
                            <Ctl:Text ID="TXT09" runat="server" LangCode="TXT09" Description="Rating" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:Rating ID="ratSTAR" runat="server" DataMember="IDX" Gap="Half" ItemCount="10" ReadMode="false" Value="1"  />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('Region');">
                            <Ctl:Text ID="TXT10" runat="server" LangCode="TXT10" Description="Region" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:Region ID="rgn01" runat="server" RegionMode="Read">
                        </Ctl:Region>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('SearchView');">
                            <Ctl:Text ID="TXT11" runat="server" LangCode="TXT11" Description="SearchView" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:SearchView ID="svIDX" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false">
                            <Ctl:SearchViewField runat="server" DataField="IDX"   TextField="IDX"   Description="문서번호" Hidden="false" TextBox="true" Width="100" Default="true"  />
                            <Ctl:SearchViewField runat="server" DataField="TITLE" TextField="TITLE" Description="제목"     Hidden="false" TextBox="true" Width="100" />
                        </Ctl:SearchView>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('Text');">
                            <Ctl:Text ID="TXT12" runat="server" LangCode="TXT12" Description="Text" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT22" runat="server" LangCode="TXT22" Description="Text" ></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('TextBox');">
                            <Ctl:Text ID="TXT13" runat="server" LangCode="TXT13" Description="TextBox" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:TextBox ID="txtIDX" runat="server" CalendarGroup="GRP0" DataMember="IDX" ReadMode="false" ReadOnly="false" SetCalendarFormat="YYYYMMDD" SetType="text" Text="텍스트박스" Validation="false" Width="150" >
                        </Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('WebSheet');">
                            <Ctl:Text ID="TXT14" runat="server" LangCode="TXT14" Description="WebSheet" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid1" runat="server" AutoColumns="false" CellHeight="28" CheckAutoMergeTarget="0" CheckBox="true" FixableWidth="500" Fixation="false" HeaderHeight="28" Height="120" HFixation="true" MethodName="ListTemplate" PageSize="3" Paging="true" PagingSize="6" TypeName="Template.TemplateBiz" UseColumnSort="false"  Width="100%" >
                            <Ctl:SheetHeader runat="server" Align="center" ColIndex="0" Colspan="2" Description="멀티헤더" Height="20" RowIndex="0" Rowspan="1" TextField="ROWNO" />

                            <Ctl:SheetField runat="server" Align="left" AutoMerge="false" DataField="IDX" DataTextField="IDX" DataValueField="IDX" Description="문서번호" Edit="true" EditType="Combo" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" MethodName="ListTemplatePaging" Params="{'CurrentPageIndex':1,'PageSize':8,'SearchCondition':''}" TextField="IDX" TypeName="Template.TemplateBiz" Width="50%" OnClick="null" />
                            <Ctl:SheetField runat="server" Align="left" AutoMerge="true" DataField="CREATEDT" DataType="Date" Description="CREATEDT" Edit="false" Fix="false" HAlign="center" Hidden="false" HiddenHeader="false" TextField="CREATEDT"  Width="50%" OnClick="null" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="javascript:fn_Redirect('WebTree');">
                            <Ctl:Text ID="TXT15" runat="server" LangCode="TXT15" Description="WebTree" Literal="true"></Ctl:Text>
                        </a>
                    </td>
                    <td>
                        <Ctl:WebTree ID="wtNAME1" runat="server" CheckBox="false" Description="WebTree 제목 설명" HideTitle="false" IndexBindFiledName="IDX" MethodName="GetTreeTemplate" ParentBindFieldName="PRTIDX" TextBindFieldName="TEXT" TypeName="Template.TemplateBiz" Width="300" />
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>