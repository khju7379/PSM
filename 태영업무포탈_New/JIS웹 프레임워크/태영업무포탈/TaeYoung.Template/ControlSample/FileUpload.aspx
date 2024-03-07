<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileUpload.aspx.cs" Inherits="Temp.WebTemplate.ControlSample.FileUpload" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {
            //샘플 DataSet Grid Bind
            var ht = new Object();
            ht["ATTACH_TYPE"] = "FileUpload";
            ht["ATTACH_NO"] = "0";
            grid99.Params(ht);
            grid99.BindList(1);

            // 프로그래스바 호출
            PageProgressShow();

            // 첨부파일을 문서타입, 문서번호로 기존데이터 호출
            fuName1.FileLoad("FileUpload", "0", function () {
                // 로드완료

                // 프로그래스바 닫기
                PageProgressHide();
            });

            // 첨부파일을 문서타입, 문서번호로 기존데이터 호출
            fuName2.FileLoad("FileUpload", "0", function () {
            });

            // 이미지 미리보기 자료
            fuName3.FileLoad("FileUpload", "01", function () {
            });

            // 심플모드
            fuName4.FileLoad("FileUpload", "0", function () {
            });

            // ReadMode 시 첨부파일 제거 버튼 빠져있음. 제이쿼리로 처리.
            $("#fuName2 .ui-icon-circle-minus").hide();
        }

        /********************************************************************************************
        * 함수명      : btnFuName5_Check()
        * 작성목적    : 첨부파일 저장
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-26
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btnFuName5_Check() {
            // 프로그래스바 호출
            PageProgressShow();

            fuName5.FileUpload(function () {

                // 업로드 완료후 데이터 저장
                //fuName5.FileSave("FileUpload", "02", function () { // 문서타입, 문서번호 입력
                //    // 전송 완료
                //    alert("전송이 완료되었습니다.");

                //    // 프로그래스바 닫기
                //    PageProgressHide();
                //});
            });
        }

        /********************************************************************************************
        * 함수명      : btnFuName6_Check()
        * 작성목적    : 첨부파일 저장
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-26
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btnFuName6_Check() {
            // 프로그래스바 호출
            PageProgressShow();

            fuName6.FileUpload(function () {

                // 업로드 완료후 데이터 저장
                fuName6.FileSave("FileUpload", "02", function () { // 문서타입, 문서번호 입력
                    // 전송 완료
                    alert("전송이 완료되었습니다.");

                    // 프로그래스바 닫기
                    PageProgressHide();
                });
            });
        }

        /********************************************************************************************
        * 함수명      : btnFuName7_Check()
        * 작성목적    : 첨부파일 조회
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-26
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function btnFuName7_Check() {
            // 프로그래스바 호출
            PageProgressShow();

            // 첨부파일을 문서타입, 문서번호로 기존데이터 호출
            fuName7.FileLoad("FileUpload", "02", function () {
                // 로드완료

                // 프로그래스바 닫기
                PageProgressHide();
            });
        }
        

        /********************************************************************************************
        * 함수명      : UploadStart()
        * 작성목적    : 모든 컨트롤 파일 업로드
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-26
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/ 
        function btnFuName8_Check() {
            UploadStart(UploadComplete);
        }

        /********************************************************************************************
        * 함수명      : UploadComplete()
        * 작성목적    : 모든 컨트롤의 업로드된 첨부파일 정보 저장
        * Parameter   :
        * Return
        * 작성자      : 이정홍
        * 최초작성일  : 2018-04-26
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function UploadComplete() {
            /* 정보를 저장할 Table의 형식에 따라 내용을 작성 */

            var hts = new Array();
            if (document.getElementById("fuName8_filedata").value != "" || document.getElementById("fuName9_filedata").value != "") {
                /* fuName8 컨트롤 추가부분 */
                var item = document.getElementById("fuName8_filedata").value;
                item = item.split("^");
                for (var i = 0; i < item.length - 1; i++) {
                    var data = item[i].split("|");
                    var sht = new Object();

                    sht["ATTACH_TYPE"] = "FileUpload";  //문서타입
                    sht["ATTACH_NO"] = "08";           // 문서번호

                    // 0: 실제파일명, 1: 파일사이즈, 2:파일 타입, 3:파일경로, 4:파일 확장자, 5: 저장파일명
                    sht["FILE_NAME"] = data[0];                             // 실제 파일명
                    sht["FILE_SIZE"] = data[1];                             // 파일 사이즈
                    sht["FILE_MIME"] = data[2];                             // 파일 타입
                    sht["FILE_PATH"] = data[3];                             // 파일 경로
                    sht["FILE_EXT"] = data[4];                              // 파일 확장자
                    sht["ATTACH_UNID"] = data[5];                           // 저장 파일명

                    hts.push(sht);
                }

                /* fuName9 컨트롤 추가부분 */
                item = document.getElementById("fuName9_filedata").value;
                item = item.split("^");
                for (var i = 0; i < item.length - 1; i++) {
                    var data = item[i].split("|");
                    var sht = new Object();

                    sht["ATTACH_TYPE"] = "FileUpload";  //문서타입
                    sht["ATTACH_NO"] = "09";           // 문서번호

                    // 0: 실제파일명, 1: 파일사이즈, 2:파일 타입, 3:파일경로, 4:파일 확장자, 5: 저장파일명
                    sht["FILE_NAME"] = data[0];                             // 실제 파일명
                    sht["FILE_SIZE"] = data[1];                             // 파일 사이즈
                    sht["FILE_MIME"] = data[2];                             // 파일 타입
                    sht["FILE_PATH"] = data[3];                             // 파일 경로
                    sht["FILE_EXT"] = data[4];                              // 파일 확장자
                    sht["ATTACH_UNID"] = data[5];                           // 저장 파일명

                    hts.push(sht);
                }

                PageMethods.InvokeServiceTableArraySync(new Object(), hts, "Common.CommonBiz", "AddAttachFile", function () {
                    alert("전송이 완료되었습니다.");
                });
            }
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
        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/ ControlSample / FileUpload
        <Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="FileUpload Control Sample" Literal="true"></Ctl:Text></h4>

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
        <Ctl:Layer ID="layer1" runat="server" Title="FileUpload Control 기본샘플" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="65%" />
                    <col width="35%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="코드"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT02" runat="server" LangCode="TXT02" Description="결과물"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT03" runat="server" LangCode="TXT03" Description="
                        <p style='display:inline;color:green'>/* 컨트롤에 첨부된 파일의 &#34;-&#34; 버튼 클릭 시 DB에서 삭제된다. */</p>
                        <br /><br />
                        &#60Ctl:FileUpload ID=&#34;fuName1&#34; runat=&#34;server&#34; ReadMode=&#34;false&#34;<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SetUploadType=&#34;list&#34; SimpleMode=&#34;false&#34; &#62<br />
                        &#60/Ctl:FileUpload&#62
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FileUpload ID="fuName1" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--샘플 DataSet-->
        <Ctl:Layer ID="layer2" runat="server" Title="FileUpload Control 샘플 DataSet" DefaultHide="False">
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
                        <Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="Common.CommonBiz"></Ctl:Text>
                    </td>
                    <td style="text-align:center;">
                        <Ctl:Text ID="TXT08" runat="server" LangCode="TXT08" Description="GetAttachFileList"></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:WebSheet ID="grid99" runat="server" Paging="false" CheckBox="false" Width="100%" TypeName="Common.CommonBiz" MethodName="GetAttachFileList">
                            <Ctl:SheetField DataField="ATTACH_TYPE" TextField="ATTACH_TYPE" Description="ATTACH_TYPE" Width="10%"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="ATTACH_NO" TextField="ATTACH_NO" Description="ATTACH_NO" Width="8.9%"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="ATTACH_UNID" TextField="ATTACH_UNID" Description="ATTACH_UNID" Width="17.8%"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="FILE_NAME" TextField="FILE_NAME" Description="FILE_NAME" Width="15.6%"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="FILE_SIZE" TextField="FILE_SIZE" Description="FILE_SIZE" Width="6.7%"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="FILE_MIME" TextField="FILE_MIME" Description="FILE_MIME" Width="70"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="FILE_EXT" TextField="FILE_EXT" Description="FILE_EXT" Width="7.8%"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="FILE_PATH" TextField="FILE_PATH" Description="FILE_PATH" Width="15.6%"  HAlign="center" Align="center" runat="server" />
                            <Ctl:SheetField DataField="UPLOAD_PATH" TextField="UPLOAD_PATH" Description="UPLOAD_PATH" Width="*"  HAlign="center" Align="center" runat="server" />
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties List-->
        <Ctl:Layer ID="layer3" runat="server" Title="FileUpload Control Properties" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT51" runat="server" LangCode="TXT51" Description="Properties"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT52" runat="server" LangCode="TXT52" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT207"><Ctl:Text ID="TXT55" runat="server" LangCode="TXT55" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT56" runat="server" LangCode="TXT56" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT211"><Ctl:Text ID="TXT57" runat="server" LangCode="TXT57" Description="SetUploadType" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT58" runat="server" LangCode="TXT58" Description="- 해당 컨트롤의 업로드 형태"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT215"><Ctl:Text ID="TXT59" runat="server" LangCode="TXT59" Description="SimpleMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT60" runat="server" LangCode="TXT60" Description="- 해당 컨트롤의 간단모드 여부"></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events List-->
        <Ctl:Layer ID="layer4" runat="server" Title="FileUpload Control Events" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT101" runat="server" LangCode="TXT101" Description="Events"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT102" runat="server" LangCode="TXT102" Description="설명"></Ctl:Text>
                    </th>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Functions List-->
        <Ctl:Layer ID="layer5" runat="server" Title="FileUpload Control Functions" DefaultHide="False">
            <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="TXT151" runat="server" LangCode="TXT151" Description="Functions"></Ctl:Text>
                    </th>
                    <th>
                        <Ctl:Text ID="TXT152" runat="server" LangCode="TXT152" Description="설명"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT307"><Ctl:Text ID="TXT153" runat="server" LangCode="TXT153" Description="FileSave()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT154" runat="server" LangCode="TXT154" Description="- 해당 컨트롤의 업로드된 첨부파일의 정보를 DB에 저장한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT311"><Ctl:Text ID="TXT155" runat="server" LangCode="TXT155" Description="FileUpload()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT156" runat="server" LangCode="TXT156" Description="- 해당 컨트롤의 첨부파일을 업로드한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT314"><Ctl:Text ID="TXT157" runat="server" LangCode="TXT157" Description="FileLoad()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT158" runat="server" LangCode="TXT158" Description="- 해당 컨트롤에 업로드된 첨부파일을 호출한다."></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">
                        <a href="#TXT319"><Ctl:Text ID="TXT159" runat="server" LangCode="TXT159" Description="UploadStart()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td>
                        <Ctl:Text ID="TXT160" runat="server" LangCode="TXT160" Description="- 모든 파일업로드 컨트롤의 첨부파일을 업로드한다."></Ctl:Text>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Properties Examples-->
        <Ctl:Layer ID="layer6" runat="server" Title="FileUpload Control Properties Examples" DefaultHide="False">
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
                        <a href="#TXT56"><Ctl:Text ID="TXT206" runat="server" LangCode="TXT206" Description="ReadMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT207" runat="server" LangCode="TXT207" Description="- 해당 컨트롤의 읽기모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT208" runat="server" LangCode="TXT208" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; ReadMode 에는 true | false 값을 사용한다. <br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; <p style='display:inline;color:Red;'>첨부파일 삭제버튼 hide()가 안됨. 스크립트로 적용한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(&#34;#(컨트롤ID) .ui-icon-circle-minus&#34;).hide();</p>
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT209" runat="server" LangCode="TXT209" Description="
                        <p style='display:inline;color:blue;'>ReadMode=&#34;true&#34;</p>
                        <br /><br />
                        <p style='display:inline;color:Green;'>/* Onload시 작성 */</p><br />
                        $(&#34;#fuName2 .ui-icon-circle-minus&#34;).hide(); <p style='display:inline;color:Green;'>/* ReadMode=&#34;true&#34; 일 경우 사용한다. */</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FileUpload ID="fuName2" runat="server" ReadMode="true" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT58"><Ctl:Text ID="TXT210" runat="server" LangCode="TXT210" Description="SetUploadType" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT211" runat="server" LangCode="TXT211" Description="- 해당 컨트롤의 업로드 형태"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT212" runat="server" LangCode="TXT212" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; SetUploadType 에는 list | thumbs 값을 사용한다. <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; <p style='display:inline;color:Red;'>썸네일 이미지는 jpg로 표시된다.</p>
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT213" runat="server" LangCode="TXT213" Description="
                        <p style='display:inline;color:blue;'>SetUploadType=&#34;thumbs&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FileUpload ID="fuName3" runat="server" ReadMode="false" SetUploadType="thumbs" SimpleMode="false" ></Ctl:FileUpload>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT60"><Ctl:Text ID="TXT214" runat="server" LangCode="TXT214" Description="SimpleMode" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT215" runat="server" LangCode="TXT215" Description="- 해당 컨트롤의 간단모드 여부"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT216" runat="server" LangCode="TXT216" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; SimpleMode 에는 true | false 값을 사용한다.<br/>
                        "></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT217" runat="server" LangCode="TXT217" Description="
                        <p style='display:inline;color:blue;'>SimpleMode=&#34;true&#34;</p>
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FileUpload ID="fuName4" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="true" ></Ctl:FileUpload>
                    </td>
                </tr>
            </table>
        </Ctl:Layer>

        <!--Events Examples-->
        <Ctl:Layer ID="layer7" runat="server" Title="FileUpload Control Events Examples" DefaultHide="False">
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
            </table>
        </Ctl:Layer>

        <!--Functions Examples-->
        <Ctl:Layer ID="layer8" runat="server" Title="FileUpload Control Functions Examples" DefaultHide="False">
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
                        <a href="#TXT154"><Ctl:Text ID="TXT306" runat="server" LangCode="TXT306" Description="FileSave()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT307" runat="server" LangCode="TXT307" Description="- 해당 컨트롤의 업로드된 첨부파일의 정보를 DB에 저장한다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT308" runat="server" LangCode="TXT308" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 첨부파일을 서버로 업로드 후 업로드된 첨부파일의 정보를 DB에 저장한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; FileUpload()의 콜백함수에서 사용한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).FileSave(문서타입, 문서번호, 콜백함수) 형식으로 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT309" runat="server" LangCode="TXT309" Description="
                        PageProgressShow(); <p style='display:inline;color:Green;'>/* 프로그래스바 호출 */</p>
                        <br /><br />
                        fuName5.FileUpload(function () {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* 업로드 완료후 데이터 저장 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:blue;'>fuName5.FileSave</p>(&#34;FileUpload&#34;, &#34;02&#34;, function () { <p style='display:inline;color:Green;'>/* 문서타입, 문서번호 입력 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;alert(&#34;전송이 완료되었습니다.&#34;); <p style='display:inline;color:Green;'>/* 업로드 완료 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PageProgressHide(); <p style='display:inline;color:Green;'>/* 프로그래스바 닫기 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;});<br />
                        });
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FileUpload ID="fuName5" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnFuName5" runat="server" LangCode="TXTBtnFuName5" Description="FileUpload()" OnClientClick="btnFuName5_Check();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT156"><Ctl:Text ID="TXT310" runat="server" LangCode="TXT310" Description="FileUpload()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT311" runat="server" LangCode="TXT311" Description="- 해당 컨트롤의 첨부파일을 업로드한다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT312" runat="server" LangCode="TXT312" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 업로드 파일 정보를 저장하기 위해 콜백함수에서 FileSave()를 사용한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).FileUpload(콜백함수) 형식으로 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT313" runat="server" LangCode="TXT313" Description="
                        PageProgressShow(); <p style='display:inline;color:Green;'>/* 프로그래스바 호출 */</p>
                        <br /><br />
                        <p style='display:inline;color:blue;'>fuName6.FileUpload</p>(function () {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* 업로드 완료후 데이터 저장 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;fuName6.FileSave(&#34;FileUpload&#34;, &#34;02&#34;, function () { <p style='display:inline;color:Green;'>/* 문서타입, 문서번호 입력 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;alert(&#34;전송이 완료되었습니다.&#34;); <p style='display:inline;color:Green;'>/* 업로드 완료 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PageProgressHide(); <p style='display:inline;color:Green;'>/* 프로그래스바 닫기 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;});<br />
                        });
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FileUpload ID="fuName6" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnFuName6" runat="server" LangCode="TXTBtnFuName6" Description="FileUpload()" OnClientClick="btnFuName6_Check();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT158"><Ctl:Text ID="TXT317" runat="server" LangCode="TXT317" Description="FileLoad()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT314" runat="server" LangCode="TXT314" Description="- 해당 컨트롤에 업로드된 첨부파일을 호출한다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT315" runat="server" LangCode="TXT315" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 첨부파일을 문서타입, 문서번호로 기존데이터를 호출한다.<br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; (컨트롤ID).FileLoad(문서타입,문서번호,콜백함수) 형식으로 사용한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT316" runat="server" LangCode="TXT316" Description="
                        PageProgressShow(); <p style='display:inline;color:Green;'>/* 프로그래스바 호출 */</p>
                        <br /><br />
                        <p style='display:inline;color:blue;'>fuName7.FileLoad</p>(&#34;FileUpload&#34;, &#34;02&#34;, function () {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* 로드완료 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;PageProgressHide(); <p style='display:inline;color:Green;'>/* 프로그래스바 닫기 */</p><br />
                        });
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FileUpload ID="fuName7" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnFuName7" runat="server" LangCode="TXTBtnFuName7" Description="FileUpload()" OnClientClick="btnFuName7_Check();"></Ctl:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3" style="text-align:center;">
                        <a href="#TXT160"><Ctl:Text ID="TXT318" runat="server" LangCode="TXT318" Description="UploadStart()" Literal="true"></Ctl:Text></a>
                    </td>
                    <td colspan="2">
                        <Ctl:Text ID="TXT319" runat="server" LangCode="TXT319" Description="- 모든 파일업로드 컨트롤의 첨부파일을 업로드한다." />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <Ctl:Text ID="TXT320" runat="server" LangCode="TXT320" Description="
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; UploadStart(UploadComplete); 형식으로 사용한다. <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; UploadComplete 은 업로드된 첨부파일의 정보를 저장한다.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&#183; 사용하는 Table에 따라 UploadComplete 의 내용을 작성한다.
                        " />
                    </td>
                </tr>
                <tr>
                    <td>
                        <Ctl:Text ID="TXT321" runat="server" LangCode="TXT321" Description="
                        <p style='display:inline;color:blue;'>UploadStart(UploadComplete);</p>
                        <br /><br />
                        function UploadComplete() {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* 정보를 저장할 Table의 형식에 따라 내용을 작성 */</p><br />
                            <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;var hts = new Array();<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;if (document.getElementById(&#34;fuName8_filedata&#34;).value != &#34;&#34; ||<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;document.getElementById(&#34;fuName9_filedata&#34;).value != &#34;&#34;) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* fuName8 컨트롤 추가부분 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var item = document.getElementById(&#34;fuName8_filedata&#34;).value;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;item = item.split(&#34;^&#34;);<br /><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for (var i = 0; i < item.length - 1; i++) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var data = item[i].split(&#34;|&#34;);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var sht = new Object();<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;ATTACH_TYPE&#34;] = &#34;FileUpload&#34;;  <p style='display:inline;color:Green;'>//문서타입</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;ATTACH_NO&#34;] = &#34;08&#34;;           <p style='display:inline;color:Green;'>// 문서번호</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>// 0: 실제파일명, 1: 파일사이즈, 2:파일 타입, 3:파일경로, 4:파일 확장자, 5: 저장파일명</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;FILE_NAME&#34;] = data[0];                             <p style='display:inline;color:Green;'>// 실제 파일명</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;FILE_SIZE&#34;] = data[1];                             <p style='display:inline;color:Green;'>// 파일 사이즈</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;FILE_MIME&#34;] = data[2];                             <p style='display:inline;color:Green;'>// 파일 타입</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;FILE_PATH&#34;] = data[3];                             <p style='display:inline;color:Green;'>// 파일 경로</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;FILE_EXT&#34;] = data[4];                              <p style='display:inline;color:Green;'>// 파일 확장자</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;ATTACH_UNID&#34;] = data[5];                           <p style='display:inline;color:Green;'>// 저장 파일명</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hts.push(sht);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
                                <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>/* fuName9 컨트롤 추가부분 */</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;item = document.getElementById(&#34;fuName9_filedata&#34;).value;<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;item = item.split(&#34;^&#34;);<br /><br/>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for (var i = 0; i < item.length - 1; i++) {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var data = item[i].split(&#34;|&#34;);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var sht = new Object();<br />
                                    <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;ATTACH_TYPE&#34;] = &#34;FileUpload&#34;;  <p style='display:inline;color:Green;'>//문서타입</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;ATTACH_NO&#34;] = &#34;09&#34;;           <p style='display:inline;color:Green;'>// 문서번호</p><br />
                                    <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<p style='display:inline;color:Green;'>// 0: 실제파일명, 1: 파일사이즈, 2:파일 타입, 3:파일경로, 4:파일 확장자, 5: 저장파일명</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;FILE_NAME&#34;] = data[0];                             <p style='display:inline;color:Green;'>// 실제 파일명</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;FILE_SIZE&#34;] = data[1];                             <p style='display:inline;color:Green;'>// 파일 사이즈</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;FILE_MIME&#34;] = data[2];                             <p style='display:inline;color:Green;'>// 파일 타입</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;FILE_PATH&#34;] = data[3];                             <p style='display:inline;color:Green;'>// 파일 경로</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;FILE_EXT&#34;] = data[4];                              <p style='display:inline;color:Green;'>// 파일 확장자</p><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sht[&#34;ATTACH_UNID&#34;] = data[5];                           <p style='display:inline;color:Green;'>// 저장 파일명</p><br />
                                    <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hts.push(sht);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
                                <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PageMethods.InvokeServiceTableArraySync(new Object(), hts, &#34;Common.CommonBiz&#34;,<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#34;AddAttachFile&#34;, function () {<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;alert(&#34;전송이 완료되었습니다.&#34;);<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;});<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;}<br />
                        }
                        <br />
                        "></Ctl:Text>
                    </td>
                    <td>
                        <Ctl:FileUpload ID="fuName8" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                        <Ctl:FileUpload ID="fuName9" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                        <div style="margin-top:10px;">
                            <Ctl:Button ID="btnFuName8" runat="server" LangCode="btnFuName8" Description="UploadStart()" OnClientClick="btnFuName8_Check();"></Ctl:Button>
                        </div>
                    </td>
                </tr>

            </table>
        </Ctl:Layer>
    </div>
</asp:content>