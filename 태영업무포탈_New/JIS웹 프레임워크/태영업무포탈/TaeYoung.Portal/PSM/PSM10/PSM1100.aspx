<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1100.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1100" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">
      

        function OnLoad() {            
           

            UP_Get_DataBinding();

        }

        function UP_Get_DataBinding() {

             // PageLoad시 이벤트 정의부분
            // PageLoad시 이벤트 정의부분
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            // CurrentPageIndex 및 PageSize값은 자동으로 입력되며 필요시 선언하여 넣을수 있다. (Biz에서 해당 항목은 반드시 정의해줘야함)
            // 페이지 갯수 변경 예제 ( 기본 10개 )
            ht["PageSize"] = 15;
            ht["SearchCondition"] = "";
            ht["KBHANGL"] = txtHANGL.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩         

        }

        function Grid1RowClick(r, c) {

            // 프로그래스바 호출
            PageProgressShow();

            var dr = gridIndex.GetRow(r);

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_KBSABUN"] = dr["KBSABUN"];

            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_KBSABUN_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    svKBSABUN.SetValue(DataSet.Tables[0].Rows[0]["KBSABUN"]);
                    txtKBJKCD.SetValue(DataSet.Tables[0].Rows[0]["KBJKCDCODE"]);
                    txtKBJKCDNM.SetValue(DataSet.Tables[0].Rows[0]["KBJKCDNM"]);
                    txtKBBUSEO.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEOCODE"]);
                    txtKBBUSEONM.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEONM"]);
                }

                UP_SetPriViewImgSign(DataSet);

                AttachFileLod();

            }, function (e) {
                // Biz 연결오류
                alert("Error");

                // 프로그래스바 삭제
                PageProgressHide();
            });

        }

        function UP_SetPriViewImgSign(DataSet) {

                // 첨부파일 바인딩
                // 조회시에 파일명/SIZE/등을 가져온다.
                var data = "";
                var filename = DataSet.Tables[0].Rows[0]["FILE_NAME"];
                var _filesize = parseInt(DataSet.Tables[0].Rows[0]["FILESIZE"]);
                var filesize = getSize(_filesize);
                // 다운로드 경로는 예외처리 되어야함
                var filepath;            

                if (filename != '') {
                    filepath = "/Portal/PSM/PSM10/PSM1100_Down.aspx?sabun=" + DataSet.Tables[0].Rows[0]["KBSABUN"] + "&name=" + DataSet.Tables[0].Rows[0]["FILE_NAME"];
                }
                else {
                    filepath = "/Resources/Images/blank.gif";
                }                

                data += filename + "|" + filesize + "|" + filepath;
                document.getElementById("fuName1_viewdata").value = data;                

                $("#imgSign").attr("src", filepath);
        }


        function btnSearch_Click() {         

            UP_Get_DataBinding();

            $("#imgSign").attr("src", "/Resources/Images/blank.gif");
        }


        function btnSave_Click() {

            // 사진 저장 체크
            if (FILEUPLOAD[0].uploader.files.length > 1) {
                alert("첨부파일은 한 건만 등록가능합니다.");
                return;
            }
            //else if (FILEUPLOAD[0].uploader.files.length == 1 && document.getElementById("fuName1_viewdata").value != ""){
            //    alert("첨부파일은 한 건만 등록가능합니다.");
            //    return;
            //}

            for (var i = 0; i < FILEUPLOAD[0].uploader.files.length; i++) {
                  
                //10메가 제한
                if ( FILEUPLOAD[0].uploader.files[i].size > 10000000) {
                    alert("첨부파일은 10메가를 초과할수 없습니다!");
                    return;
                }
            }          

            UploadStart(UploadComplete);
           
        }

        function UploadComplete() {


            $("#imgSign").attr("src", "/Resources/Images/blank.gif");
                     
            fuName1.FileSave("SG", svKBSABUN.GetValue(), function () { });

            AttachFileLod();

            alert("저장이 완료되었습니다.");
        }

        function GetAttachFile_Callback(e) {            

            fuName1.FileSave("SG", svKBSABUN.GetValue(), function () { });

            AttachFileLod();

            alert("저장이 완료되었습니다.");
        }


       

        function UP_SABUN_Selected(r, dr) {

            

            txtKBJKCD.SetValue(dr["KBJKCDCODE"]);
            txtKBJKCDNM.SetValue(dr["KBJKCDNM"]);
            txtKBBUSEO.SetValue(dr["KBBUSEOCODE"]);
            txtKBBUSEONM.SetValue(dr["KBBUSEONM"]);
        }       

        function AttachFileLod() {
            
                document.getElementById("fuName1_filedata").value = "";

                fuName1.FileLoad("SG", svKBSABUN.GetValue(), function () {
                // 로드완료

                   // 프로그래스바 닫기
                   PageProgressHide();
                });

        }     
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="SIGN관리" DefaultHide="False">
        <div class="btn_bx">
           <ul class="search" style="border-bottom:0px;">
            <li><Ctl:Text ID="lblHANGL" runat="server" LangCode="lblHANGL" Description="성 명"></Ctl:Text></li>
            <li><Ctl:TextBox ID="txtHANGL" runat="server" LangCode="txtHANGL" Text="" Description="성 명"></Ctl:TextBox></li>
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
            <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();"></Ctl:Button>
            
            </ul>
        </div>
        <table  style="width: 100%;">
                <colgroup>
                    <col width="50%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td valign="top">
                        
                         <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSM1100" MethodName="UP_SIGNCODE_LIST" UseColumnSort="true">
                            <Ctl:SheetField DataField="KBSABUN" TextField="KBSABUN" Description="사 번" Width="60"  HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                            <Ctl:SheetField DataField="KBHANGL" TextField="KBHANGL" Description="이 름" Width="60"  HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                            <Ctl:SheetField DataField="KBJKCD" TextField="KBJKCD" Description="직 급" Width="60"  HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                            <Ctl:SheetField DataField="JKDESC" TextField="JKDESC" Description="직급명" Width="60"  HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                            <Ctl:SheetField DataField="KBBUSEO" TextField="KBBUSEO" Description="부 서" Width="60"  HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                            <Ctl:SheetField DataField="KBBUSEONM" TextField="KBBUSEONM" Description="부서명" Width="*" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />                            
                        </Ctl:WebSheet>
                        
                    </td>
                    <td valign="top">
                          
                          <table class="table_01" style="width: 100%;border-bottom:1px">
                                <colgroup>
                                    <col width="30%" />
                                    <col width="60%" />
                                </colgroup>
                                <tr>
                                    <th><Ctl:Text ID="TXT_KBSABUN" runat="server" LangCode="TXT_KBSABUN" Description="사 번" /></th>
                                    <td>
                                        <Ctl:SearchView ID="svKBSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                                            <Ctl:SearchViewField runat="server" DataField="KBSABUN"   TextField="KBSABUN"   Description="사 번" Hidden="false" TextBox="true" Width="100" Default="true"  />
                                            <Ctl:SearchViewField runat="server" DataField="KBHANGL" TextField="KBHANGL" Description="이 름"     Hidden="false" TextBox="true" Width="100" />                                            
                                        </Ctl:SearchView>
                                    </td>
                                </tr>                               
                                <tr>
                                    <th><Ctl:Text ID="TXT_KBJKCD" runat="server" LangCode="TXT_KBJKCD" Description="직 급" /></th>
                                    <td>
                                        <Ctl:TextBox ID="txtKBJKCD" style="background: rgb(224, 224, 224);" Width="50px" ReadOnly="true" runat="server" />
                                        <Ctl:TextBox ID="txtKBJKCDNM" style="background: rgb(224, 224, 224);" ReadOnly="true" runat="server" />
                                    </td>
                                </tr>                               
                                <tr>
                                    <th><Ctl:Text ID="TXT_KBBUSEO" runat="server" LangCode="TXT_KBBUSEO" Description="부 서" /></th>
                                    <td>
                                        <Ctl:TextBox ID="txtKBBUSEO"  style="background: rgb(224, 224, 224);" Width="50px" ReadOnly="true" runat="server" />
                                        <Ctl:TextBox ID="txtKBBUSEONM" style="background: rgb(224, 224, 224);" ReadOnly="true" runat="server" />
                                    </td>
                                </tr>                               
                                <tr>
                                    <th><Ctl:Text ID="TXT_SIGN" runat="server" LangCode="TXT_SIGN" Description="결재싸인" /></th>
                                    <td>
                                        <Ctl:FileUpload ID="fuName1" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                                    </td>
                                </tr>                               
                                <tr>
                                    <th><Ctl:Text ID="TXT_SIGN2" runat="server" LangCode="TXT_SIGN2" Description="미리보기" /></th>
                                    <td>
                                        <img id="imgSign" src="/Resources/Framework/blank.gif" />
                                    </td>
                                </tr>   
                                
                               
                            </table>                     
                    
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 


    </div>
</asp:content>
