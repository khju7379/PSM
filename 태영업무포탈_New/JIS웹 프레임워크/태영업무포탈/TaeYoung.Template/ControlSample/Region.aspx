<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Region.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.Region" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            // PageLoad시 이벤트 정의부분

            // RegionMode 테스트
            svNAME1.SetValue("2563");
            fuName1.FileLoad("FileUpload", "01", function () {
                // 로드완료

                // 프로그래스바 닫기
                PageProgressHide();
            });
        }

        /********************************************************************************************
        * 함수명      : rgn05_Click
        * 작성목적    : 텍스트 클릭 이벤트
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-19
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function rgn05_Click() {
            alert('<Ctl:Text ID="MSG01" runat="server" LangCode="MSG01" Description="스크립트 호출" Literal="true"></Ctl:Text>');
            return false;
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
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / Region
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="Region Control Sample" Literal="true"></Ctl:Text></h4>

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
        <Ctl:Layer ID="layer1" runat="server" Title="Region Control 기본샘플" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="65%" />
                    <col width="35%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT50" runat="server" LangCode="TXT50" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT51" runat="server" LangCode="TXT51" Description="결과물"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT52" runat="server" LangCode="TXT52" Description="
                        &#60Ctl:Region ID=&#34;rgn01&#34; runat=&#34;server&#34; RegionMode=&#34;Read&#34; Style=&#34;border:1px solid red;&#34; &#62<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>&#60!-- 작성할 영역 --&#62</p><br />
                        &#60/Ctl:Region&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:Region ID="rgn01" runat="server" RegionMode="Read" Style="border:1px solid red;">
                            <Ctl:Text ID="TXT53" runat="server" LangCode="TXT52" Description="영역에 작성된 Text컨트롤"></Ctl:Text>
                        </Ctl:Region>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="Region Control 샘플 DataSet" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="17%" />
                    <col width="13%" />
                    <col width="70%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT54" runat="server" LangCode="TXT54" Description="TypeName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT55" runat="server" LangCode="TXT55" Description="MethodName"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT56" runat="server" LangCode="TXT56" Description="DataSet"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties List-->
        <Ctl:Layer ID="layer3" runat="server" Title="Region Control Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT73"><Ctl:Text ID="TXT59" runat="server" LangCode="TXT59" Description="RegionMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT60" runat="server" LangCode="TXT60" Description="- 해당 컨트롤 영역 모드" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT78"><Ctl:Text ID="TXT61" runat="server" LangCode="TXT61" Description="Style" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT62" runat="server" LangCode="TXT62" Description="- 해당 컨트롤의 스타일" />
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events List-->
        <Ctl:Layer ID="layer4" runat="server" Title="Region Control Events" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT04" runat="server" LangCode="TXT04" Description="Events"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT05" runat="server" LangCode="TXT05" Description="설명"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="Region Control Functions" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT210" runat="server" LangCode="TXT210" Description="Functions"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT211" runat="server" LangCode="TXT211" Description="설명"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer6" runat="server" Title="Region Control Properties Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT212" runat="server" LangCode="TXT212" Description="Properties"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT213" runat="server" LangCode="TXT213" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT214" runat="server" LangCode="TXT214" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT215" runat="server" LangCode="TXT215" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT216" runat="server" LangCode="TXT216" Description="결과"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT60"><Ctl:Text ID="TXT72" runat="server" LangCode="TXT72" Description="RegionMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT73" runat="server" LangCode="TXT73" Description="- 해당 컨트롤 영역 모드" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT74" runat="server" LangCode="TXT74" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; RegionMode = &#34;Edit&#34; 이면 편집모드로 지정되어 내부영역을 표시하지 않는다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; RegionMode = &#34;Read&#34; 이면 읽기모드로 지정되어 내부영역을 표시한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 읽기모드 변경 시 Region 컨트롤의 mode의 Value를 변경한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode의 Value 변경 시 RegionMode.Edit | RegionMode.Read 값을 사용한다.<br />
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT75" runat="server" LangCode="TXT75" 
                        Description="
                        <p style='display:inline;color:Blue;'>RegionMode=&#34;Read&#34;</p>
                        <br /><br />
                        <p style='display:inline;color:green'> /* Region.aspx.cs 에 작성 */ </p><br/>
                        public partial class Region : BasePage<br/>
                        {<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;public Region()<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;{<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;this.PostbackYN = true;<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;}<br/>
                            <br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;protected void btn1_Click(object sender, EventArgs e)<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;{<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Blue;'>this.rgn02.mode = RegionMode.Edit;</p><br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;}<br/>
                            <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;protected void btn2_Click(object sender, EventArgs e)<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;{<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Blue;'>this.rgn02.mode = RegionMode.Read;</p><br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;}<br/>
                        }
                        " />
                    </td>
                    <td>
                        <Ctl:Region ID="rgn02" runat="server" RegionMode="Read">
                            <Ctl:Text ID="TXT76" runat="server" LangCode="TXT76" Description="영역에 작성된 Text컨트롤"></Ctl:Text><br /><br />
                            <Ctl:Button ID="btn9" runat="server" LangCode="btn9" Description="영역에 작성된 Button컨트롤" OnClick="btn1_Click"></Ctl:Button><br /><br />
                            <Ctl:SearchView ID="svNAME1" runat="server" TypeName="Template.TemplateBiz" MethodName="ListTemplatePaging" Params="{'PageSize':5}" PagingSize="5" ReadMode="false" PlaceHolder="">
                                <Ctl:SearchViewField DataField="IDX" TextField="IDX" Description="문서번호" Hidden="false" Width="100" TextBox="true" Default="true" runat="server" />
                                <Ctl:SearchViewField DataField="TITLE" TextField="TITLE" Description="제목" Hidden="false" Width="100" TextBox="true" runat="server" />
                            </Ctl:SearchView><br /><br />
                            <Ctl:FileUpload ID="fuName1" runat="server" ReadMode="true" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload><br />
                            <Ctl:Radio ID="rdoIDX1" runat="server" DataMember="IDX" ReadMode="false" OnChanged="return false;">
                                <asp:ListItem Text="첫번째" Value="1" Selected="true"></asp:ListItem>
                                <asp:ListItem Text="두번째" Value="2" ></asp:ListItem>
                                <asp:ListItem Text="세번째" Value="3" ></asp:ListItem>
                            </Ctl:Radio><br /><br />
                            <Ctl:TextBox ID="txtIDX" runat="server" CalendarGroup="GRP0" DataMember="IDX" Height="50" PlaceHolder="빈칸" ReadMode="false" ReadOnly="false" SetCalendarFormat="YYYYMMDD" SetType="text" Text="영역에 작성된 TextBox 컨트롤" TextMode="MultiLine" Validation="false" Width="150" OnCalendarChanged="return false;">
                            </Ctl:TextBox>
                        </Ctl:Region>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btn1" runat="server" LangCode="btn1" Description="편집모드" OnClick="btn1_Click"></Ctl:Button>
                            <Ctl:Button ID="btn2" runat="server" LangCode="btn2" Description="읽기모드" OnClick="btn2_Click"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT62"><Ctl:Text ID="TXT77" runat="server" LangCode="TXT77" Description="Style" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT78" runat="server" LangCode="TXT78" Description="- 해당 컨트롤의 스타일" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT79" runat="server" LangCode="TXT79" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; Style은 기본태그의 Style 처럼 사용할 수 있지만 width와 height 값은 사용할 수 없다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT80" runat="server" LangCode="TXT81" Description="
                        <p style='display:inline;color:blue;'>Style=&#34;border:1px solid red&#34;</p>
                        " />
                    </td>
                    <td>
                        <Ctl:Region ID="rgn04" runat="server" RegionMode="Read" Style="border:1px solid red;">
                            <Ctl:Text ID="TXT81" runat="server" LangCode="TXT81" Description="영역에 작성된 Text컨트롤"></Ctl:Text>
                        </Ctl:Region>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>
        
        <!--Events Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="Region Control Events Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT217" runat="server" LangCode="TXT217" Description="Events"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT218" runat="server" LangCode="TXT218" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT219" runat="server" LangCode="TXT219" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT220" runat="server" LangCode="TXT220" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT221" runat="server" LangCode="TXT221" Description="결과"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="Region Control Functions Examples" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="50%" />
                    <col width="30%" />
                </colgroup>
                <tr>
                    <th rowspan="3">
                        <Ctl:Text ID="TXT205" runat="server" LangCode="TXT205" Description="Functions"></Ctl:Text>
                    </th>
                    <th colspan="2">
                        <Ctl:Text ID="TXT206" runat="server" LangCode="TXT206" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        <Ctl:Text ID="TXT207" runat="server" LangCode="TXT207" Description="상세설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT208" runat="server" LangCode="TXT208" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT209" runat="server" LangCode="TXT209" Description="결과"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>
    </div>
</asp:content>