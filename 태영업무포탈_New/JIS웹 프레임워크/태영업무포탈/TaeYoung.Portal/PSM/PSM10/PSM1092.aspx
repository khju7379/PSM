<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1092.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1092" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var Code = "<%= Request.QueryString["CODE"] %>";

            var data = Code.split('^');

            txtJSDBLASS.SetValue(data[0]);
            txtJSDMLASS.SetValue(data[1]);
            txtJSDSLASS.SetValue(data[2]);
            txtJSDSEQ.SetValue(data[3]);

            UP_DataMastaBind_Run();

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["JSDBLASS"] = txtJSDBLASS.GetValue();
            ht["JSDMLASS"] = txtJSDMLASS.GetValue();
            ht["JSDSLASS"] = txtJSDSLASS.GetValue();
            ht["JSDSEQ"] = txtJSDSEQ.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            if (data.length == 5) {

                DataGubn = "";
                txtJSDITEMSEQ.SetValue(data[4]);
                UP_DataBind_Run();
            }
            else {
                btnNew_Click();
            }

            btnDel.Hide();
        }

        // 데이터 바인딩
        function UP_DataMastaBind_Run() {

            var ht = new Object();

            ht["P_MENU_NAME"] = txtJSDBLASS.GetValue() + "_" + txtJSDMLASS.GetValue() + "_" + txtJSDSLASS.GetValue() + "_" + txtJSDSEQ.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_MASTER_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtJSDBLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JBCODE"]);
                    txtJSDMLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JMCODE"]);
                    txtJSDSLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JSCODE"]);
                    txtJSDWKNAME.SetValue(DataSet.Tables[0].Rows[0]["JSMWKNAME"]);
                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.  

            if (txtJSDITEMSEQ.GetValue() != "") {

                ht["JSDBLASS"] = txtJSDBLASS.GetValue();
                ht["JSDMLASS"] = txtJSDMLASS.GetValue();
                ht["JSDSLASS"] = txtJSDSLASS.GetValue();
                ht["JSDSEQ"] = txtJSDSEQ.GetValue();
                ht["JSDITEMSEQ"] = txtJSDITEMSEQ.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_DETAIL_RUN", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        txtJSDITEMSEQ.SetValue(DataSet.Tables[0].Rows[0]["JSDITEMSEQ"]);
                        txtJSDITEMTEXT.SetValue(DataSet.Tables[0].Rows[0]["JSDITEMTEXT"]);
                        txtJSDTOOLTEXT.SetValue(DataSet.Tables[0].Rows[0]["JSDTOOLTEXT"]);

                        btnDel.Show();
                    }

                    UP_SetPreViewImg(DataSet);

                    AttachFileLod();

                    if (DataSet.Tables[0].Rows[0]["JRGUBUN"] == "Y" || DataSet.Tables[0].Rows[0]["JSGUBUN"] == "Y") {

                        btnDel.Hide();
                    }
                    else {
                        btnDel.Show();
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert("Error");
                });
            }
            else {
                btnNew_Click();
            }
        }

        function UP_SetPreViewImg(DataSet) {

            // 첨부파일 바인딩
            // 조회시에 파일명/SIZE/등을 가져온다.
            var data = "";
            var filename = DataSet.Tables[0].Rows[0]["FILE_NAME_JSA"];
            var _filesize = parseInt(DataSet.Tables[0].Rows[0]["FILE_SIZE_JSA"]);
            var filesize = getSize(_filesize);
            // 다운로드 경로는 예외처리 되어야함
            var filepath;

            if (filename != '') {
                filepath = "/Portal/PSM/PSM10/PSM1092_Down.aspx?fileid=" + DataSet.Tables[0].Rows[0]["FILE_ID_JSA"] + "&name=" + DataSet.Tables[0].Rows[0]["FILE_NAME_JSA"];
            }
            else {
                filepath = "/Resources/Images/blank.gif";
            }

            data += filename + "|" + filesize + "|" + filepath;

            document.getElementById("fuName1_viewdata").value = data;

            $("#imgJSA").attr("src", filepath);

            data = "";
            filename = DataSet.Tables[0].Rows[0]["FILE_NAME_TOOL"];
            _filesize = parseInt(DataSet.Tables[0].Rows[0]["FILE_SIZE_TOOL"]);
            filesize = getSize(_filesize);
            // 다운로드 경로는 예외처리 되어야함
            var filepath;

            if (filename != '') {
                filepath = "/Portal/PSM/PSM10/PSM1092_Down.aspx?fileid=" + DataSet.Tables[0].Rows[0]["FILE_ID_TOOL"] + "&name=" + DataSet.Tables[0].Rows[0]["FILE_NAME_TOOL"];
            }
            else {
                filepath = "/Resources/Images/blank.gif";
            }

            data += filename + "|" + filesize + "|" + filepath;
            document.getElementById("fuName2_viewdata").value = data;

            $("#imgTOOL").attr("src", filepath);
        }


        // 조회 버튼
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["JSDBLASS"] = txtJSDBLASS.GetValue();
            ht["JSDMLASS"] = txtJSDMLASS.GetValue();
            ht["JSDSLASS"] = txtJSDSLASS.GetValue();
            ht["JSDSEQ"] = txtJSDSEQ.GetValue();
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            $("#imgJSA").attr("src", "/Resources/Images/blank.gif");
        }

        // 신규 버튼
        function btnNew_Click()
        {
            txtJSDITEMSEQ.SetValue("");
            txtJSDITEMTEXT.SetValue("");
            txtJSDTOOLTEXT.SetValue("");

            fuName1.FileLoad("JJ", "", "");
            $("#imgJSA").attr("src", "/Resources/Images/blank.gif");

            DataGubn = "ADD";
            btnDel.Hide();
        }

        // 저장 버튼
        function btnSave_Click() {         

            if (txtJSDBLASS.GetValue() != "" && txtJSDMLASS.GetValue() != "" && txtJSDSLASS.GetValue() != "" && lblJSDSEQ.GetValue() != "") {

                if (txtJSDITEMTEXT.GetValue() == "" || txtJSDITEMTEXT.GetValue() == null) {
                    alert('<Ctl:Text runat="server" Description="작업단계를 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }

                // 사진 저장 체크
                if (FILEUPLOAD[0].uploader.files.length > 1) {
                    alert("첨부파일은 한 건만 등록가능합니다.");
                    return;
                }
                //else if (FILEUPLOAD[0].uploader.files.length == 1 && document.getElementById("fuName1_viewdata").value != "") {
                //    alert("첨부파일은 한 건만 등록가능합니다.");
                //    return;
                //}
                if (FILEUPLOAD[1].uploader.files.length > 1) {
                    alert("첨부파일은 한 건만 등록가능합니다.");
                    return;
                }
                //else if (FILEUPLOAD[1].uploader.files.length == 1 && document.getElementById("fuName2_viewdata").value != "") {
                //    alert("첨부파일은 한 건만 등록가능합니다.");
                //    return;
                //}

                for (var i = 0; i < FILEUPLOAD[0].uploader.files.length; i++) {

                    //10메가 제한
                    if (FILEUPLOAD[0].uploader.files[i].size > 10000000) {
                        alert("첨부파일은 10메가를 초과할수 없습니다!");
                        return;
                    }
                }
                for (var i = 0; i < FILEUPLOAD[1].uploader.files.length; i++) {

                    //10메가 제한
                    if (FILEUPLOAD[1].uploader.files[i].size > 10000000) {
                        alert("첨부파일은 10메가를 초과할수 없습니다!");
                        return;
                    }
                }

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["JSDBLASS"] = txtJSDBLASS.GetValue();
                ht["JSDMLASS"] = txtJSDMLASS.GetValue();
                ht["JSDSLASS"] = txtJSDSLASS.GetValue();
                ht["JSDSEQ"] = txtJSDSEQ.GetValue();

                if (DataGubn == 'ADD') {
                    ht["JSDITEMSEQ"] = "0";
                }
                else {
                    ht["JSDITEMSEQ"] = txtJSDITEMSEQ.GetValue();
                }

                ht["JSDITEMTEXT"] = txtJSDITEMTEXT.GetValue();
                ht["JSDTOOLTEXT"] = txtJSDTOOLTEXT.GetValue();

                if (confirm('<Ctl:Text runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_DETAIL_ADD", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                            DataGubn = "";
                            txtJSDITEMSEQ.SetValue(DataSet.Tables[0].Rows[0]["JSDITEMSEQ"]);

                            UploadStart(UploadComplete);
                        }
                        else {
                            alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        }

                    }, function (e) {
                        // Biz 연결오류
                        alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    });
                }
            }
            else {
                alert('<Ctl:Text runat="server" Description="JSA 마스타 등록 후 작업하세요." Literal="true"></Ctl:Text>');
            }
        }

        function UploadComplete() {

            var fileid = "";

            fileid = txtJSDBLASS.GetValue() + txtJSDMLASS.GetValue() + txtJSDSLASS.GetValue() + Set_Fill3(txtJSDSEQ.GetValue()) + Set_Fill3(txtJSDITEMSEQ.GetValue());

            $("#imgJSA").attr("src", "/Resources/Images/blank.gif");
            $("#imgTOOL").attr("src", "/Resources/Images/blank.gif");

            fuName1.FileSave("JJ", fileid , function () { });
            fuName2.FileSave("JT", fileid , function () { });

            AttachFileLod();

            UP_DataBind_Run();
            btnSearch_Click();

            alert("저장이 완료되었습니다.");

            if (opener != null && typeof (opener.jsa_popup_callback) == "function") {
                opener.jsa_popup_callback();
            }

        }

        //function GetAttachFile_Callback(e) {

        //    var fileid = "";

        //    fileid = txtJSDBLASS.GetValue() + txtJSDMLASS.GetValue() + txtJSDSLASS.GetValue() + Set_Fill3(txtJSDSEQ.GetValue()) + Set_Fill3(txtJSDITEMSEQ.GetValue());

        //    fuName1.FileSave("JSA", fileid, function () { });

        //    AttachFileLod();

        //    alert("저장이 완료되었습니다2.");
        //}

        function AttachFileLod() {

            var fileid = "";

            fileid = txtJSDBLASS.GetValue() + txtJSDMLASS.GetValue() + txtJSDSLASS.GetValue() + Set_Fill3(txtJSDSEQ.GetValue()) + Set_Fill3(txtJSDITEMSEQ.GetValue());

            document.getElementById("fuName1_filedata").value = "";

            fuName1.FileLoad("JJ", fileid , function () {
                // 로드완료

                // 프로그래스바 닫기
                PageProgressHide();
            });
            document.getElementById("fuName2_filedata").value = "";

            fuName2.FileLoad("JT", fileid , function () {
                // 로드완료

                // 프로그래스바 닫기
                PageProgressHide();
            });
        }

        // 삭제 버튼
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["JSDBLASS"] = txtJSDBLASS.GetValue();
            ht["JSDMLASS"] = txtJSDMLASS.GetValue();
            ht["JSDSLASS"] = txtJSDSLASS.GetValue();
            ht["JSDSEQ"] = txtJSDSEQ.GetValue();
            ht["JSDITEMSEQ"] = txtJSDITEMSEQ.GetValue();

            if (confirm('<Ctl:Text runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_DETAIL_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            btnNew_Click();
                            btnSearch_Click();

                            alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }
                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 닫기 버튼
        function btnClose_Click() {

            this.close();            
        }

        // 그리드 선택 이벤트
        function gridClick(r, c) {
            var rw = gridIndex.GetRow(r);

            DataGubn = "";
            txtJSDITEMSEQ.SetValue(rw["JSDITEMSEQ"]);

            UP_DataBind_Run();
        }

        function Set_Fill3(sFirst) {
            
            if (sFirst.toString().length == 1) {

                sFirst = "00" + sFirst.toString();
            }
            else if (sFirst.toString().length == 2) {

                sFirst = "0" + sFirst.toString();
            }
            else if (sFirst.toString().length == 3) {
                sFirst = sFirst.toString();
            }
            else {
                sFirst = '000';
            }

            return sFirst;
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="항목등록" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
            <Ctl:Button ID="btnSearch" runat="server" Style="Orange" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
            <Ctl:Button ID="btnNew" runat="server" Style="Orange" LangCode="btnNew" Description="신규" OnClientClick="btnNew_Click();" ></Ctl:Button>
		    <Ctl:Button ID="btnSave" runat="server" Style="Orange" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnDel" runat="server" Style="Orange" LangCode="btnDel" Description="삭제" OnClientClick="btnDel_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnClose" runat="server" Style="Orange" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();" ></Ctl:Button>
        </div>
        <div class="clear"></div>     
    </div>
	<!--//타이틀끝-->

	<!--컨텐츠시작-->
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server">
            <table class="table_01" style="width:100%;" border="0">
                <colgroup>
                    <col width="60px" />
                    <col width="120px" />
                    <col width="60px" />
                    <col width="170px" />
                    <col width="60px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td style="text-align:left">
                        <Ctl:Text ID="lblJSDBLASS" runat="server" LangCode="lblJSDBLASS" Description="대분류" ></Ctl:Text>
                    </td>
                    <td style="text-align:left">
                        <Ctl:Text ID="txtJSDBLASS" runat="server" LangCode="txtJSDBLASS" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                        <Ctl:Text ID="txtJSDBLASSNM" runat="server" LangCode="txtJSDBLASSNM" Description="" ForeColor="Blue"></Ctl:Text>
                    </td>
                    <td style="text-align:left">
                        <Ctl:Text ID="lblJSDMLASS" runat="server" LangCode="lblJSDMLASS" Description="중분류" ></Ctl:Text>
                    </td>
                    <td style="text-align:left">
                        <Ctl:Text ID="txtJSDMLASS" runat="server" LangCode="txtJSDMLASS" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                        <Ctl:Text ID="txtJSDMLASSNM" runat="server" LangCode="txtJSDMLASSNM" Description="" ForeColor="Blue"></Ctl:Text>
                    </td>
                    <td style="text-align:left">
                        <Ctl:Text ID="lblJSDSLASS" runat="server" LangCode="lblJSDSLASS" Description="소분류" ></Ctl:Text>
                    </td>
                    <td style="text-align:left">
                        <Ctl:Text ID="txtJSDSLASS" runat="server" LangCode="txtJSDSLASS" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                        <Ctl:Text ID="txtJSDSLASSNM" runat="server" LangCode="txtJSDSLASSNM" Description="" ForeColor="Blue"></Ctl:Text>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:left">
                        <Ctl:Text ID="lblJSDSEQ" runat="server" LangCode="lblJSDSEQ" Description="작업명" ></Ctl:Text>
                    </td>
                    <td colspan="5" style="text-align:left">
                        <Ctl:Text ID="txtJSDSEQ" runat="server" LangCode="txtJSDSEQ" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                        <Ctl:Text ID="txtJSDWKNAME" runat="server" LangCode="txtJSDWKNAME" Description="" ForeColor="Blue"></Ctl:Text>
                    </td>
                </tr>
            </table>
            <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="200" TypeName="PSM.PSM1090" MethodName="UP_JSA_DETAIL_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                <Ctl:SheetField DataField="JBCODE" TextField="대분류코드" Description="대분류코드" Width="60"  HAlign="center" Align="left"  runat="server" hidden="true" />
                <Ctl:SheetField DataField="JMCODE" TextField="중분류코드" Description="중분류코드" Width="100"  HAlign="center" Align="left"  runat="server" hidden="true" />
                <Ctl:SheetField DataField="JSCODE" TextField="소분류코드" Description="소분류코드" Width="150" HAlign="center" Align="left"  runat="server" hidden="true" />
                <Ctl:SheetField DataField="JSMWKNAME" TextField="작업명" Description="작업명" Width="60" HAlign="center" Align="left"  runat="server" hidden="true" />
                <Ctl:SheetField DataField="JSDITEMSEQ" TextField="순번" Description="순번" Width="60" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                <Ctl:SheetField DataField="JSDITEMTEXT" TextField="작업단계" Description="작업단계" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
                <Ctl:SheetField DataField="JSDTOOLTEXT" TextField="도구" Description="도구" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridClick" />
            </Ctl:WebSheet>
            <table class="table_01" style="width:100%;" border="0">
                <colgroup>
                    <col width="100px" />
                    <col width="100px" />
                    <col width="100px" />
                    <col width="100px" />
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJSDITEMSEQ" runat="server" LangCode="lblJSDITEMSEQ" Description="순번" ></Ctl:Text>

                    </th>
                    <td colspan="5">                                          
                        <Ctl:TextBox ID="txtJSDITEMSEQ" Width="80px" runat="server" LangCode="txtJSDITEMSEQ" Description="순번" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJSDITEMTEXT" runat="server" LangCode="lblJSDITEMTEXT" Description="작업단계" Required = "true"></Ctl:Text>
                    </th>
                    <td colspan="5">
                        <Ctl:TextBox ID="txtJSDITEMTEXT" Width="550px" runat="server" LangCode="txtJSDITEMTEXT" Description="작업단계"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblJSDTOOLTEXT" runat="server" LangCode="lblJSDTOOLTEXT" Description="도구"></Ctl:Text>
                    </th>
                    <td colspan="5">
                        <Ctl:TextBox ID="txtJSDTOOLTEXT" Width="550px" runat="server" LangCode="txtJSDTOOLTEXT" Description="도구"></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>
                        <Ctl:Text ID="lblPICTURE1" runat="server" LangCode="lblPICTURE1" Description="작업단계 사진"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:FileUpload ID="fuName1" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                    </td>
                    <th><Ctl:Text ID="lblPREVIEW1" runat="server" LangCode="lblPREVIEW1" Description="미리보기" /></th>
                    <td colspan="3">
                        <img id="imgJSA" src="/Resources/Framework/blank.gif" />
                    </td>
                </tr>   
                <tr>
                    <th>
                        <Ctl:Text ID="lblPICTURE2" runat="server" LangCode="lblPICTURE2" Description="도구 사진"></Ctl:Text>
                    </th>
                    <td>
                        <Ctl:FileUpload ID="fuName2" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                    </td>
                    <th><Ctl:Text ID="lblPREVIEW2" runat="server" LangCode="lblPREVIEW2" Description="미리보기" /></th>
                    <td colspan="3">
                        <img id="imgTOOL" src="/Resources/Framework/blank.gif" />
                    </td>
                </tr>   
            </table>
		</Ctl:Layer>
	</div>
</asp:content>