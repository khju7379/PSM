<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Template02.aspx.cs" Inherits="TaeYoung.WebTemplate.Template02" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <style type ="text/css">
        #sub_body #container #content_bx .table table.table_02 td
        {
            text-align : left;
        }
    </style>

    <script type="text/javascript">
        function OnLoad() {

            var dt = new Date();
            txtDate.SetValue(dt.getFullYear() + '-' + (dt.getMonth() + 1) + '-' + dt.getDate());
            txtDate2.SetValue(dt.getFullYear() + '-' + (dt.getMonth() + 1));
            txtDate3.SetValue(dt.getFullYear());
        }

        function cmbTest1_Changed() {
            alert('콤보 Changed 함수');
            return false;
        }
        function fnCalendar_Changed() {
            alert('달력 Changed 함수');
        }
        function RadioTest_Changed() {
            alert('라디오 Changed 함수');
        }
        function chkTest_Changed() {
            alert('체크박스 Changed 함수');
        }
    </script>
</asp:content>


<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">

<%-- 본문시작 --%>

    <div id="Div1">
        <Ctl:Layer ID="layer1" runat="server" Title="컨트롤정리" DefaultHide="False">
            <table class="table_02" style="width: 100%;">
                <colgroup>
                    <col width="400" />
                    <col width="*"  />
                </colgroup>
                <tr>
                    <th>
                         <Ctl:Button ID="Btnn01" runat="server" LangCode="Button01"  Style="Blue" >버튼1</Ctl:Button>
                         <Ctl:Button ID="Btnn02" runat="server" LangCode="Button02"  Style="Orange" >버튼2</Ctl:Button>
                         <Ctl:Button ID="Btnn03" runat="server" LangCode="Button03"  Style="White" >버튼3</Ctl:Button>
                         <Ctl:Button ID="Btnn04" runat="server" LangCode="Button04"   >버튼4</Ctl:Button>
                         <Ctl:Button ID="Btnn05" runat="server" LangCode="Button05" InGrid="true">버튼5</Ctl:Button>
                    </th>
                    <td>
                      <span style="color:#FF0000;"><span style="color:#0100FF;">&lt;</span><span style="color:#800000;">Ctl:Button ID</span>
                      <span style="color:#0000FF;">="Btnn02"</span> runat<span style="color:#0000FF;">="server"</span> LangCode<span style="color:#0000FF;">="Button01"</span> Style<span style="color:#0000FF;">="Orange" ></span> 
                      <span style="color:#800000;">버튼1<span style="color:#0100FF;">&lt;</span> /Ctl:Button<span style="color:#0000FF;">&gt;</span></span></span> </br>
                      <span style="color:#FF0000;"><span style="color:#0100FF;">&lt;</span><span style="color:#800000;">Ctl:Button ID</span>
                      <span style="color:#0000FF;">="Btnn05"</span> runat<span style="color:#0000FF;">="server"</span> LangCode<span style="color:#0000FF;">="Button05"</span> InGrid<span style="color:#0000FF;">="true"></span>
                      <span style="color:#800000;">버튼5<span style="color:#0100FF;">&lt;</span>/Ctl:Button<span style="color:#0000FF;">&gt;</span></span></span> </br></br>

                      &nbsp;&nbsp;- <span style="color:#FF0000;">InGrid</span> : 그리드 컨트롤 내 버튼 스타일 설정 </br>                  
                      &nbsp;&nbsp;- <span style="color:#FF0000;">LangCode</span> : 언어코드를 설정하거나 가져온다.</br>                  
                      &nbsp;&nbsp;- <span style="color:#FF0000;">Style</span> : 버튼 템플릿 지정</br>
                      &nbsp;&nbsp;&nbsp;&nbsp;- <span style="color:#0100FF;">Blue </span>/ 파란색</br>
                      &nbsp;&nbsp;&nbsp;&nbsp;- White / 하얀색</br>
                      &nbsp;&nbsp;&nbsp;&nbsp;- <span style="color:#FF5E00;">Orange </span> / 오렌지색</br>
                      &nbsp;&nbsp;&nbsp;&nbsp;- <span style="color:#5D5D5D;">Gray </span> / 회색 </br>
                      &nbsp;&nbsp;- <span style="color:#FF0000;">OnClientClick</span> : 컨트롤의 Click 이벤트가 발생할 경우 클라이언트측 스크립트 함수 호출</br>
                      &nbsp;&nbsp;- <span style="color:#FF0000;">OnClick</span> : 컨트롤의 Click 이벤트가 발생할 경우 서버측 함수 호출</br>

                                   
                    </td>
                </tr>

                <tr>
                    <th>
                        패스워드</br>
                        <Ctl:TextBox ID="TextBox4" runat="server" SetType="Text" TextMode="Password"></Ctl:TextBox><br />
                        텍스트박스</br> 
                        <Ctl:TextBox ID="TextBox1" runat="server" SetType="Text" Validation="false"></Ctl:TextBox><br />
                        숫자</br>
                        <Ctl:TextBox ID="TextBox_Number" runat="server" SetType="Number"></Ctl:TextBox><br />
                        숫자에콤마</br>
                        <Ctl:TextBox ID="TextBox7" runat="server" SetType="NumberComma"></Ctl:TextBox><br />
                        퍼센트</br>
                        <Ctl:TextBox ID="TextBox_Percent" runat="server" SetType="Percent"></Ctl:TextBox><br />
                        달력</br>
                        <Ctl:TextBox ID="txtDate" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" OnCalendarChanged="fnCalendar_Changed"  ></Ctl:TextBox> 
                        <Ctl:TextBox ID="txtDate2" runat="server" SetCalendarFormat="YYYYMM" SetType="Calendar"></Ctl:TextBox>
                        <Ctl:TextBox ID="txtDate3" runat="server" SetCalendarFormat="YYYY" SetType="Calendar" ></Ctl:TextBox>
                    </th>
                    <td>
                        <span style="color:#FF0000;"><span style="color:#0100FF;">&lt;</span>
                        <span style="color:#800000;">Ctl:TextBox </span> ID<span style="color:#0000FF;">="TextBox1"</span>SetType<span style="color:#0000FF;">="Calendar"</span>SetCalendarFormat
                        <span style="color:#0000FF;"> ="YYYYMMDD"</span>runat <span style="color:#0000FF;">="server"></span>  
                         
                        <span style="color:#0100FF;">&lt;</span> <span style="color:#800000;"> /Ctl:TextBox</span> <span style="color:#0000FF;">&gt;</span></span><br /></br>

                        &nbsp;&nbsp;- <span style="color:#FF0000;">TextMode="Password"</span> :  패스워드 타입</br>
                        &nbsp;&nbsp;- <span style="color:#FF0000;">SetType</span> : 텍스트박스의 타입을 가져오거나 설정한다.</br>
                        &nbsp;&nbsp;&nbsp;&nbsp;- <span style="color:#0000FF;">Text</span> : 택스트박스</br>
                        &nbsp;&nbsp;&nbsp;&nbsp;- <span style="color:#0000FF;">Number</span> : 숫자</br>
                        &nbsp;&nbsp;&nbsp;&nbsp;- <span style="color:#0000FF;">NumberComma</span> : 숫자3자리마다 ','(콤마)처리</br>
                        &nbsp;&nbsp;&nbsp;&nbsp;- <span style="color:#0000FF;">Percent</span> : % (최대값은 100)</br>
                        &nbsp;&nbsp;&nbsp;&nbsp;- <span style="color:#0000FF;">Calendar</span> : 달력 </br>
                        &nbsp;&nbsp;- <span style="color:#FF0000;">SetCalendarFormat</span> : 날자형태 변경 YYYYMMDD,YYYYMM,YYYY</br>
                        &nbsp;&nbsp;- <span style="color:#FF0000;">ReadOnly</span> 텍스트박스의 입력가능 여부 조정</br>
                        
                    </td>         
                </tr>
                <tr>
                    <th>
                        체크박스</br>
                        <Ctl:CheckBox ID="chkTest1" runat="server"  RepeatColumns="5" OnChanged="chkTest_Changed();">
                            <asp:ListItem Value="0" Text="첫번째" LangCode="" Description=""></asp:ListItem>
                            <asp:ListItem Value="2" Text="두번째" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="4" Text="세번째"></asp:ListItem>
                            <asp:ListItem Value="6" Text="네번째"></asp:ListItem>
                            <asp:ListItem Value="8" Text="다섯번째"></asp:ListItem>
                        </Ctl:CheckBox>
                    </th>
                    <td>
                        <span style="color:#FF0000;"><span style="color:#0100FF;">&lt;</span><span style="color:#800000;"> Ctl:CheckBox ID</span>
                        <span style="color:#0000FF;"> ="chkTest1"</span> runat<span style="color:#0000FF;">="server"</span> Selected <span style="color:#0000FF;">="True"></span> <span style="color:#0100FF;">&lt;</span> </span>
                        <span style="color:#800000;">/Ctl:CheckBox</span></span><span style="color:#0000FF;">&gt;</span></br></br>

                        &nbsp;&nbsp;- <span style="color:#FF0000;">Selected</span> : ListItem에 등록하여  바인딩되는 값 {get; set;}</br>  
                        &nbsp;&nbsp;- <span style="color:#FF0000;">DataTextField</span> : <span style="color:#0000FF;">string</span> / 해당 컨트롤의 Option 명을 나타내는 필드 명<br />
                        &nbsp;&nbsp;- <span style="color:#FF0000;">DataValueField</span> : <span style="color:#0000FF;">string</span> / 해당 컨트롤의 Option 값을 나타내는 필드 명<br />
                        &nbsp;&nbsp;- <span style="color:#FF0000;">OnChanged</span> : 컨트롤이 변경시 발생할 이벤트 { get; set; }</br>
                             
                    </td>
                </tr>
                <tr>
                    <th>
                        라디오 박스 예제</br>
                        <Ctl:Radio ID="rdoTest1" runat="server" OnChanged="RadioTest_Changed();">
                            <asp:ListItem Value="0" Text="첫번째"  Selected="True"></asp:ListItem>
                            <asp:ListItem Value="2" Text="두번째"></asp:ListItem>
                            <asp:ListItem Value="4" Text="세번째"></asp:ListItem>
                            <asp:ListItem Value="6" Text="네번째"></asp:ListItem>
                            <asp:ListItem Value="8" Text="다섯번째"></asp:ListItem>
                         </Ctl:Radio>
                    </th>
                    <td>
                         <span style="color:#FF0000;"><span style="color:#0100FF;">&lt;</span><span style="color:#800000;">Ctl:Radio </span> ID <span style="color:#0000FF;">="rdoTest1"</span> 
                         OnChanged <span style="color:#0000FF;"> ="RadioTest_Changed(); </span>"  
                         runat <span style="color:#0000FF;">="server"</span>  <span style="color:#0000FF;">&gt;</span> <span style="color:#0100FF;">&lt;</span>
                         <span style="color:#800000;">/Ctl:Radio></span></span></br></br>

                          &nbsp;&nbsp;- <span style="color:#FF0000;">Selected</span> : ListItem에 등록하여  바인딩되는 값 {get; set;}</br>  
                          &nbsp;&nbsp;- <span style="color:#FF0000;">DataTextField</span> : <span style="color:#0000FF;">string</span> / 해당 컨트롤의 Option 명을 나타내는 필드 명<br />
                          &nbsp;&nbsp;- <span style="color:#FF0000;">DataValueField</span> : <span style="color:#0000FF;">string</span> / 해당 컨트롤의 Option 값을 나타내는 필드 명<br />
                          &nbsp;&nbsp;- <span style="color:#FF0000;">OnChanged</span> : 컨트롤이 변경시 발생할 이벤트 { get; set; }</br>
                    </td>       
                </tr>
                <tr>
                    <th>
                        콤보박스</br></br>
                        <Ctl:Combo ID="cmbTest1" runat="server" OnChange="cmbTest1_Changed();">
                            <asp:ListItem Value="0" Text="첫번째"></asp:ListItem>
                            <asp:ListItem Value="2" Text="두번째"></asp:ListItem>
                            <asp:ListItem Value="4" Text="세번째"></asp:ListItem>
                            <asp:ListItem Value="6" Text="네번째"></asp:ListItem>
                            <asp:ListItem Value="8" Text="다섯번째"></asp:ListItem>
                        </Ctl:Combo>
                    </th>
                    <td>
                        <span style="color:#FF0000;"><span style="color:#0100FF;"> < </span><span style="color:#800000;">Ctl:Combo ID</span> 
                        <span style="color:#0000FF;">="cmbTest1"</span> runat<span style="color:#0000FF;">="server"</span> OnChange<span style="color:#0000FF;">="cmbTest1_Changed();"</span>  
                        <span style="color:#0100FF;"> < </span><span style="color:#800000;">/Ctl:Combo</span><span style="color:#0100FF;"> > </span></span></br></br>
                        &nbsp;&nbsp;- <span style="color:#FF0000;">TextField</span> : 컨트롤에 바인딩할 텍스트</br>
                        &nbsp;&nbsp;- <span style="color:#FF0000;">ValueField</span> : 컨트롤에 바인딩할 값</br>
                        &nbsp;&nbsp;- <span style="color:#FF0000;">OnChange</span> : 컨트롤이 변경시 발생할 이벤트</br>
                    </td>
                </tr>
                <tr>
                    <th>
                        플립스위치 예제</br>
                        <Ctl:FlipSwitch ID="flp1" runat="server" Width="100">
                            <asp:ListItem Selected="True" Text="값1" Value="0"></asp:ListItem>
                            <asp:ListItem Text="값2" Value="2"></asp:ListItem>
                        </Ctl:FlipSwitch>
                    </th>
                    <td>
                      <span style="color:#FF0000;"><span style="color:#0100FF;"> < </span><span style="color:#800000;"> Ctl:FlipSwitch </span> ID 
                      <span style="color:#0000FF;">="flp1"</span> runat <span style="color:#0000FF;">="server"</span> Width <span style="color:#0000FF;">="100"> </span>
                      <span style="color:#0100FF;"> < </span><span style="color:#800000;">/Ctl:FlipSwitch </span><span style="color:#0000FF;"> ></span></span> </br></br>
                        &nbsp;&nbsp;- <span style="color:#FF0000;"> GetControlValue </span> : 컨트롤의 값을 가져온다.</br>
                        &nbsp;&nbsp;- <span style="color:#FF0000;">SelectedValueData </span> : 해당 컨트롤의 선택여부를 결정하는 값을 설정하거나 가져온다.
                    </td>
                </tr>
                <tr>
                    <th>
                        레이어 예제</br>
                           <Ctl:Layer ID="layerTab" runat="server" Title="레이어" DefaultHide="True">
                                <Ctl:LayerTap ID="tap11" runat="server" Width="150px" Title="첫번째" Description="첫번째"></Ctl:LayerTap>
                                <Ctl:LayerTap ID="tap12" runat="server" Width="150px" Title="두번째" Description="두번째"></Ctl:LayerTap>

                            레이어</br>
                            
                           <Ctl:LayerTapBody ID="tap11_body" runat="server"> 
                                <Ctl:Layer ID="layerTab7" runat="server" Title="Layer 테스트"></Ctl:Layer>
                                    첫번째 
                                </Ctl:LayerTapBody>
                            <Ctl:LayerTapBody ID="tap22_body" runat="server"> 두번째 </Ctl:LayerTapBody>
                           </Ctl:Layer>
                    </th>
                    <td>
                        <span style="color:#FF0000;"><span style="color:#0100FF;"> < </span><span style="color:#800000;">Ctl:Layer ID </span> <span style="color:#0000FF;">="layer1"</span> runat 
                        <span style="color:#0000FF;">="server"</span> Title <span style="color:#0000FF;">="레이어예제"</span> DefaultHide <span style="color:#0000FF;">="True"></span><span style="color:#0100FF;"> < </span>
                        <span style="color:#800000;">/Ctl:Layer</span><span style="color:#0100FF;"> ></span></span></br></br>
                            &nbsp;&nbsp;- <span style="color:#FF0000;">layer</span> : 기본디자인의 영역에 레이어를 추가한다.</br>
                             &nbsp;&nbsp;- <span style="color:#FF0000;">Title</span> : 레이어의 상단 타이틀을 가져오거나 설정한다.</br>
                             &nbsp;&nbsp;- <span style="color:#FF0000;">DefaultHide</span> : 레이어의 숨김여부 설정</br>
                        <span style="color:#FF0000;"><span style="color:#0100FF;"> < </span><span style="color:#800000;">Ctl:LayerTab ID </span> <span style="color:#0000FF;">="layerTab1"</span> runat 
                        <span style="color:#0000FF;">="server"</span> Title <span style="color:#0000FF;">="첫번째"</span> Width <span style="color:#0000FF;">="200px"></span><span style="color:#0100FF;"> < </span>
                        <span style="color:#800000;">/Ctl:LayerTab</span><span style="color:#0100FF;"> ></span></span></br></br>
                            &nbsp;&nbsp;- <span style="color:#FF0000;">layerTap</span> : 기본디자인의 영역에 탭을 추가한다.</br>
                             &nbsp;&nbsp;- <span style="color:#FF0000;">Title</span> : 레이어의 상단 타이틀을 가져오거나 설정한다.</br>
                             &nbsp;&nbsp;- <span style="color:#FF0000;">Width</span> : 컨트롤의 넓이를 지정한다.</br>
                        <span style="color:#FF0000;"><span style="color:#0100FF;"> < </span> <span style="color:#800000;">Ctl:LayerTapBody</span> ID <span style="color:#0000FF;">="tap11_body"</span> runat
                        <span style="color:#0000FF;">="server"></span></span> <span style="color:#0100FF;"> < </span>  <span style="color:#800000;"> /Ctl:LayerTapBody</span>
                        <span style="color:#0100FF;"> ></span></span></br></br>
                            &nbsp;&nbsp;- <span style="color:#FF0000;">layerTapBody</span> : 기본 디자인의 영역에 탭의 내용을 추가한다.</br>


                    </td>
                </tr>
                <tr>
                    <th>
                        그리드 예제
                        <Ctl:Layer ID="layer4" runat="server" Title="">
                            <Ctl:WebSheet ID="grid1" runat="server" Paging="false" CheckBox="true" Width="100%" HFixation="true" Fixation="false" Height="300" Title="그리드">
                            </Ctl:WebSheet>
                        </Ctl:Layer>
                    </th>
                    <td>
                        <span style="color:#FF0000;"><span style="color:#0100FF;">&lt;</span><span style="color:#800000;">Ctl:WebSheet</span> ID <span style="color:#0000FF;">="grid1"</span> runat
                        <span style="color:#0000FF;">="server"</span> Paging <span style="color:#0000FF;">="false"</span> CheckBox <span style="color:#0000FF;">="true"</span>
                         Width <span style="color:#0000FF;">="100%"</span> HFixation <span style="color:#0000FF;">="true"</span> Fixation <span style="color:#0000FF;">="false"</span>
                         Height <span style="color:#0000FF;">="300"</span> Title <span style="color:#0000FF;">="그리드"></span></span><span style="color:#0100FF;">&lt;</span><span style="color:#800000;">/Ctl:WebSheet</span>
                        <span style="color:#0100FF;">&gt;</span></span></br></br>
                    </td>
                </tr>
                <tr>
                    <th>
                        시간선택 컨트롤</br>
                        <Ctl:TimePicker ID="timeTest" runat="server"></Ctl:TimePicker></br>
                        <Ctl:TimePicker ID="timeTest2" runat="server" ReadMode="false" Value="10 00 PM" ></Ctl:TimePicker>                 
                    </th>
                    <td>
                         <span style="color:#FF0000;"><span style="color:#0100FF;"> < </span><span style="color:#800000;">Ctl:TimePicker </span>ID<span style="color:#0000FF;">="timeTest"</span> runat<span style="color:#0000FF;">="server"></span>
                         <span style="color:#0100FF;"> < </span> <span style="color:#800000;">/Ctl:TimePicker></span></span></br></br>
                         &nbsp;&nbsp;- <span style="color:#FF0000;">ReadMode</span> - 읽기모드를 가져오거나 설정한다.(ture,false)</br>
                         &nbsp;&nbsp;- <span style="color:#FF0000;">Value</span> - 컨트롤에 데이터를 가져오거나 설정한다. 초기값넣거나 할때사용 (11 00 AM 띄어쓰기로 가능) 
                    </td>
                </tr>
                <tr>
                    <th>
                          웹에디터</br>
                          <Ctl:WebEditor ID="webeditor1" runat="server" Width="400" Height="400" > </Ctl:WebEditor>        
                    </th>
                    <td>
                            <span style="color:#FF0000;"><span style="color:#0100FF;"> < </span><span style="color:#800000;">Ctl:WebEditor</span> ID<span style="color:#0000FF;">="webeditor1"</span> runat<span style="color:#0000FF;">="server"</span> Width 
                            <span style="color:#0000FF;">="400"</span> Height<span style="color:#0000FF;">="400" ></span><span style="color:#0100FF;"> < </span><span style="color:#800000;">/Ctl:WebEditor></span></span></br>
                            </br>
                            width 값이 800 정도되야 모든항목이 다보인다     
                    </td>
               </tr>
        </Ctl:Layer>
    </div>
</asp:content>
