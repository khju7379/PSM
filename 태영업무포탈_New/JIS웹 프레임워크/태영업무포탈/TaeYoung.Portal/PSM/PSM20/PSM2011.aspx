<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM2011.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM20.PSM2011" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <script type="text/javascript">

        var _PBMCNTCODE = "";
        var _PBMLCODE = "";
        var _PBMLCODENM = "";
        var _PBMMCODE = "";
        var _PBMSCODE = "";
        var _PBMNUM = "";
        var DataGubn = "";
        var fshdnLoginSabun = "";

        // 페이지 로드
        function OnLoad() {

            var Num = "<%= Request.QueryString["CODE"] %>";

            var data = Num.split('^');
            
            fshdnLoginSabun = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
            svPBMPUSABUN.SetDisabled(true);
            $("#svPBMPUSABUN_KBHANGL_img").attr("style", "display:none");
            svPBDMOSABUN.SetDisabled(true);
            $("#svPBDMOSABUN_KBHANGL_img").attr("style", "display:none");

            if (data.length > 2) {

                DataGubn = "";
                _PBMCNTCODE = data[0];
                _PBMLCODE = data[1];
                _PBMMCODE = data[2];
                _PBMSCODE = data[3];
                _PBMNUM = data[4];

                UP_DataBind_Run();
            }
            else {

                DataGubn = "A";
                _PBMCNTCODE = data[0];
                _PBMLCODE = data[1];
                _PBMMCODE = "";
                _PBMSCODE = "";
                _PBMNUM = "";

                UP_init();
            }

            btnDetailSave.Hide();
        }

        function UP_init() {

            var today = new Date();

            txtPBMPUDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

            txtPBMLCODE.SetValue(_PBMLCODE);

            var ht = new Object();
            ht["P_PBC1NTCODE"] = _PBMCNTCODE;
            ht["P_PBC1LCODE"] = _PBMLCODE;

            // 대분류명 조회
            PageMethods.InvokeServiceTable(ht, "PSM.PSM1111", "UP_GET_LCODE_LIST", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtPBMLCODENM.SetValue(DataSet.Tables[0].Rows[0]["PBC1LCODENM"]);
                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
            
            $("#txtPBMLCODENM").attr("style", "font-size:20px;color:black;");

            svPBMPUSABUN.SetValue(fshdnLoginSabun);

            // 중분류 조회
            ht = new Object();
            ht["PBMCNTCODE"] = _PBMCNTCODE;
            ht["PBMLCODE"] = txtPBMLCODE.GetValue();
            ht["GUBUN"] = "";

            cboPBMMCODE.TypeName = "PSM.PSM2010";
            cboPBMMCODE.MethodName = "UP_GET_PBMMCODE_LIST";
            cboPBMMCODE.DataTextField = "PBC2NAME";
            cboPBMMCODE.DataValueField = "PBC2MCODE";
            cboPBMMCODE.Params(ht);
            cboPBMMCODE.BindList();

            cboPBMMCODE_Change();

            btnDel.Hide();
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

            ht["PBMCNTCODE"] = _PBMCNTCODE;
            ht["PBMLCODE"] = _PBMLCODE;
            ht["PBMMCODE"] = _PBMMCODE;
            ht["PBMSCODE"] = _PBMSCODE;
            ht["PBMNUM"] = _PBMNUM;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM2010", "UP_BOARD_MAST_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtPBMLCODE.SetValue(DataSet.Tables[0].Rows[0]["PBMLCODE"]);
                    txtPBMLCODENM.SetValue(DataSet.Tables[0].Rows[0]["PBMLCODENM"]);
                    $("#txtPBMLCODENM").attr("style", "font-size:20px;color:black;");
                    let selectEl = document.querySelector("#cboPBMMCODE");
                    var objOption = document.createElement("option");
                    objOption.text = DataSet.Tables[0].Rows[0]["PBMMCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["PBMMCODE"];
                    selectEl.options.add(objOption);
                    selectEl = document.querySelector("#cboPBMSCODE");
                    objOption = document.createElement("option");
                    objOption.text = DataSet.Tables[0].Rows[0]["PBMSCODENM"];
                    objOption.value = DataSet.Tables[0].Rows[0]["PBMSCODE"];
                    selectEl.options.add(objOption);
                    txtPBMNUM.SetValue(DataSet.Tables[0].Rows[0]["PBMNUM"]);
                    txtPBMPUDATE.SetValue(DataSet.Tables[0].Rows[0]["PBMPUDATE"]);
                    svPBMPUSABUN.SetValue(DataSet.Tables[0].Rows[0]["PBMPUSABUN"]);
                    txtPBMTITLE.SetValue(DataSet.Tables[0].Rows[0]["PBMTITLE"]);

                    txtPBDMODESC.SetValue("");
                    svPBDMOSABUN.SetValue("");
                    $("#svPBDMOSABUN_KBHANGL").val("");
                    $("#svPBDMOSABUN_KBSABUN").val("");

                    cboPBMMCODE.SetDisabled(true);
                    cboPBMSCODE.SetDisabled(true);
                    txtPBMNUM.SetDisabled(true);

                    AttachFileLod();
                    UP_DataBind_Detail();
                    btnDetailNew_Click();

                    if (fshdnLoginSabun == svPBMPUSABUN.GetValue()) {
                        // 게시명, 게시자, 게시일자 잠금 해제
                        txtPBMTITLE.SetDisabled(false);
                        svPBMPUSABUN.SetDisabled(false);
                        txtPBMPUDATE.SetDisabled(false);
                    }
                    else {
                        // 게시명, 게시자, 게시일자 잠금
                        txtPBMTITLE.SetDisabled(true);
                        svPBMPUSABUN.SetDisabled(true);
                        txtPBMPUDATE.SetDisabled(true);
                    }
                    
                    if (fshdnLoginSabun == DataSet.Tables[0].Rows[0]["PBMPUSABUN"]) {
                        btnDel.Show();
                    }
                    else {
                        btnDel.Hide();
                    }

                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        // 수정 이력 조회
        function UP_DataBind_Detail() {
            
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["PBDCNTCODE"] = _PBMCNTCODE;
            ht["PBDLCODE"] = txtPBMLCODE.GetValue();
            ht["PBDMCODE"] = cboPBMMCODE.GetValue();
            ht["PBDSCODE"] = cboPBMSCODE.GetValue();
            ht["PBDNUM"] = txtPBMNUM.GetValue();

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridIndex.CallBack = function () {
                var DetailRows = gridIndex.GetAllRow();

                for (i = 0; i < ObjectCount(DetailRows.Rows); i++) {

                    dr = DetailRows.Rows[i];

                    if (dr['PBDMOSABUN'] != fshdnLoginSabun) {
                        gridIndex.EditModeDisable(i, 1);   // 수정내용(1)
                    }
                }
            }
        }

        function UP_FieldCheck() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            if (_PBMCNTCODE == "") {
                alert('<Ctl:Text runat="server" Description="게시판 구분을 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBMLCODE.GetValue() == "" || txtPBMLCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="대분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboPBMMCODE.GetValue() == "" || cboPBMMCODE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="중분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cboPBMSCODE.GetValue() == "" || cboPBMSCODE.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="소분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBMTITLE.GetValue() == "" || txtPBMTITLE.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="게시명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (svPBMPUSABUN.GetValue() == "" || svPBMPUSABUN.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="게시자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtPBMPUDATE.GetValue() == "" || txtPBMPUDATE.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="게시일자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            // 사진 저장 체크
            if (FILEUPLOAD[0].uploader.files.length > 1) {
                alert("첨부파일은 한 건만 등록가능합니다.");
                return;
            }

            for (var i = 0; i < FILEUPLOAD[0].uploader.files.length; i++) {

                //10메가 제한
                if (FILEUPLOAD[0].uploader.files[i].size > 10000000) {
                    alert("첨부파일은 10메가를 초과할수 없습니다!");
                    return;
                }
            }

            if (DataGubn != "A") {
                if (txtPBDMODESC.GetValue() == "" || txtPBDMODESC.GetValue() == "") {
                    alert('<Ctl:Text runat="server" Description="수정내용을 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
                if (svPBDMOSABUN.GetValue() == "" || svPBDMOSABUN.GetValue() == "") {
                    alert('<Ctl:Text runat="server" Description="수정자를 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
                if (txtPBDMODATE.GetValue() == "" || txtPBDMODATE.GetValue() == "") {
                    alert('<Ctl:Text runat="server" Description="수정일자를 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }

                ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["PBMCNTCODE"] = _PBMCNTCODE;
                ht["PBMLCODE"] = txtPBMLCODE.GetValue();
                ht["PBMMCODE"] = cboPBMMCODE.GetValue();
                ht["PBMSCODE"] = cboPBMSCODE.GetValue();
                ht["PBMNUM"] = txtPBMNUM.GetValue();
                ht["PBDMODATE"] = txtPBDMODATE.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSM2010", "UP_BOARD_DETAIL_CHECK", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        alert('<Ctl:Text runat="server" Description="현재 입력된 수정일자 이후의 자료가 존재합니다." Literal="true"></Ctl:Text>');
                        return false;

                    }
                    else {
                        UP_Save();
                    }
                }, function (e) {
                    // Biz 연결오류
                    alert("Error");
                    return false;
                });
            }
            else {
                UP_Save();
            }
        }

        function UP_Save() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["PBMCNTCODE"] = _PBMCNTCODE;
            ht["PBMLCODE"] = txtPBMLCODE.GetValue();
            ht["PBMMCODE"] = cboPBMMCODE.GetValue();
            ht["PBMSCODE"] = cboPBMSCODE.GetValue();
            if (DataGubn == 'A') {
                ht["PBMNUM"] = "0";
            }
            else {
                ht["PBMNUM"] = txtPBMNUM.GetValue();
            }
            ht["PBMTITLE"] = txtPBMTITLE.GetValue();
            ht["PBMPUSABUN"] = $("#svPBMPUSABUN_KBSABUN").val();
            ht["PBMPUDATE"] = txtPBMPUDATE.GetValue();

            ht["PBDMODESC"] = txtPBDMODESC.GetValue();
            ht["PBDMOSABUN"] = $("#svPBDMOSABUN_KBSABUN").val();
            ht["PBDMODATE"] = txtPBDMODATE.GetValue();

            if (confirm('<Ctl:Text runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM2010", "UP_BOARD_MAST_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        _PBMMCODE = DataSet.Tables[0].Rows[0]["PBMMCODE"];
                        _PBMSCODE = DataSet.Tables[0].Rows[0]["PBMSCODE"];
                        _PBMNUM = DataSet.Tables[0].Rows[0]["PBMNUM"];

                        UploadStart(UploadComplete);

                        btnDel.Show();

                        if (opener != null && typeof (opener.board_popup_callback()) == "function") {
                            opener.board_popup_callback();
                        }
                        if (DataGubn != 'A') {
                            UP_DetailSave();
                        }
                        else {
                            DataGubn = "";
                            alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                            if (opener != null && typeof (opener.board_popup_callback()) == "function") {
                                opener.board_popup_callback();
                            }
                        }
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

        // 저장 버튼 이벤트
        function btnSave_Click() {
            
            UP_FieldCheck();
        }

        // 삭제 버튼 이벤트
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["PBMCNTCODE"] = _PBMCNTCODE;
            ht["PBMLCODE"] = txtPBMLCODE.GetValue();
            ht["PBMMCODE"] = cboPBMMCODE.GetValue();
            ht["PBMSCODE"] = cboPBMSCODE.GetValue();
            ht["PBMNUM"] = txtPBMNUM.GetValue();

            if (confirm('<Ctl:Text runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM2010", "UP_BOARD_MAST_DEL", function (e) {
        
                    alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                    if (opener != null && typeof (opener.board_popup_callback()) == "function") {
                        opener.board_popup_callback();
                    }

                    btnClose_Click();

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        function UploadComplete() {

            var fileid = "";

            fileid = _PBMCNTCODE + _PBMLCODE + _PBMMCODE + _PBMSCODE + Set_Fill3(_PBMNUM);
            
            fuName1.FileSave(_PBMCNTCODE, fileid, function () { });
            UP_DataBind_Run();

            //alert("저장이 완료되었습니다.");
        }

        function AttachFileLod() {

            var fileid = "";

            fileid = _PBMCNTCODE + _PBMLCODE + _PBMMCODE + _PBMSCODE + Set_Fill3(_PBMNUM);

            document.getElementById("fuName1_filedata").value = "";

            fuName1.FileLoad(_PBMCNTCODE, fileid, function () {
                // 로드완료

                // 프로그래스바 닫기
                PageProgressHide();
            });
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            this.close();            
        }

        // 그리드 선택 이벤트
        function gridClick(r, c) {

            var rw = gridIndex.GetRow(r);

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   
            
            ht["PBDCNTCODE"] = _PBMCNTCODE;
            ht["PBDLCODE"] = rw["PBDLCODE"];
            ht["PBDMCODE"] = rw["PBDMCODE"];
            ht["PBDSCODE"] = rw["PBDSCODE"];
            ht["PBDNUM"] = rw["PBDNUM"];
            ht["PBDMOSEQ"] = rw["PBDMOSEQ"];

            PageMethods.InvokeServiceTable(ht, "PSM.PSM2010", "UP_BOARD_DETAIL_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtPBDMODESC.SetValue(DataSet.Tables[0].Rows[0]["PBDMODESC"]);
                    svPBDMOSABUN.SetValue(DataSet.Tables[0].Rows[0]["PBDMOSABUN"]);
                    txtPBDMODATE.SetValue(DataSet.Tables[0].Rows[0]["PBDMODATE"]);
                    txtPBDMOSEQ.SetValue(DataSet.Tables[0].Rows[0]["PBDMOSEQ"]);

                    if (fshdnLoginSabun == rw["PBDMOSABUN"]) {
                        btnDetailSave.Show();
                    }
                    else {
                        btnDetailSave.Hide();
                    }
                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        // 수정이력 신규 버튼 이벤트 
        function btnDetailNew_Click() {

            txtPBDMOSEQ.SetValue("");
            txtPBDMODESC.SetValue("");
            //txtPBDMODATE.SetValue("");

            var today = new Date();

            txtPBDMODATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

            svPBDMOSABUN.SetValue(fshdnLoginSabun);

            btnDetailSave.Show();
        }

        // 수정이력 저장 이벤트
        function UP_DetailSave() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["PBDCNTCODE"] = _PBMCNTCODE;
            ht["PBDLCODE"] = txtPBMLCODE.GetValue();
            ht["PBDMCODE"] = cboPBMMCODE.GetValue();
            ht["PBDSCODE"] = cboPBMSCODE.GetValue();
            ht["PBDNUM"] = txtPBMNUM.GetValue();
            if (txtPBDMOSEQ.GetValue() == "") {
                ht["PBDMOSEQ"] = "0";
            }
            else {
                ht["PBDMOSEQ"] = txtPBDMOSEQ.GetValue();
            }

            ht["PBDMODESC"] = txtPBDMODESC.GetValue();
            ht["PBDMOSABUN"] = $("#svPBDMOSABUN_KBSABUN").val();
            ht["PBDMODATE"] = txtPBDMODATE.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM2010", "UP_BOARD_DETAIL_ADD", function (e) {

                alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                btnDetailNew_Click();
                UP_DataBind_Detail();

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

        // 수정이력 저장 버튼 이벤트 (수정)
        function btnDetailSave_Click() {

            var DetailRows = gridIndex.GetCheckRow();
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            var hts = new Array();

            if (DetailRows == null || DetailRows == "") {
                alert('<Ctl:Text runat="server" Description="저장할 내용이 없습니다." Literal="true"></Ctl:Text>');
                return false;
            }
            else {

                for (i = 0; i < DetailRows.length; i++) {

                    ht = new Object();
                    dr = DetailRows[i];

                    ht["PBDCNTCODE"] = _PBMCNTCODE;
                    ht["PBDLCODE"] = dr['PBDLCODE'];
                    ht["PBDMCODE"] = dr['PBDMCODE'];
                    ht["PBDSCODE"] = dr['PBDSCODE'];
                    ht["PBDNUM"] = dr['PBDNUM'];
                    ht["PBDMOSEQ"] = dr['PBDMOSEQ'];
                    ht["PBDMOSABUN"] = dr['PBDMOSABUN'];
                    ht["PBDMODESC"] = dr['PBDMODESC'];
                    ht["PBDMODATE"] = dr['PBDMODATE'].split("-").join("");;

                    hts.push(ht);
                }
                if (confirm('<Ctl:Text runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    PageMethods.InvokeServiceTableArray(ht, hts, "PSM.PSM2010", "UP_BOARD_DETAIL_UPDATE", function (e) {

                        var DataSet = eval(e);

                        alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                        UP_DataBind_Detail();

                    }, function (e) {
                        // Biz 연결오류
                        alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    });
                }
            }
        }
        
        // 중분류 선택 이벤트
        function cboPBMMCODE_Change() {

            var ht = new Object();
            ht["PBMCNTCODE"] = _PBMCNTCODE;
            ht["PBMLCODE"] = txtPBMLCODE.GetValue();
            ht["PBMMCODE"] = cboPBMMCODE.GetValue();
            ht["GUBUN"] = "";

            cboPBMSCODE.TypeName = "PSM.PSM2010";
            cboPBMSCODE.MethodName = "UP_GET_PBMSCODE_LIST";
            cboPBMSCODE.DataTextField = "PBC3NAME";
            cboPBMSCODE.DataValueField = "PBC3SCODE";
            cboPBMSCODE.Params(ht);
            cboPBMSCODE.BindList();

            //return false;
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
            <Ctl:TextBox ID="txtPBMLCODE" Width="0px" runat="server" LangCode="txtPBMLCODE" Description="대분류" Hidden="true"></Ctl:TextBox>
            <Ctl:TextBox ID="txtPBMNUM" Width="0px" runat="server" LangCode="txtPBMNUM" Description="순번" Hidden="true"></Ctl:TextBox>
            <Ctl:Text ID="txtPBMLCODENM" runat="server" LangCode="txtPBMLCODENM" Description="대분류명"></Ctl:Text>
        </h4>

        <div class="btn_bx">
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
                    <col width="100px" />
                    <col width="300px" />
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th colspan="4" style="text-align:left">
                        <Ctl:Text ID="Text3" runat="server" LangCode="lblPBDMODESC" Description="내용"></Ctl:Text>
                    </th>
                </tr>
                <tr>
                    <td style="text-align:center">
                        <Ctl:Text ID="lblPBMMCODE" runat="server" LangCode="lblPBMMCODE" Description="중분류" Required = "true"></Ctl:Text>
                    </td>
                    <td colspan="3">
                       <Ctl:Combo ID="cboPBMMCODE" Width="250px" runat="server" OnChange="cboPBMMCODE_Change()"></Ctl:Combo>
                    </td>
                    
                </tr>
                <tr>
                    <td style="text-align:center">
                        <Ctl:Text ID="lblPBMSCODE" runat="server" LangCode="lblPBMSCODE" Description="소분류" Required = "true"></Ctl:Text>
                    </td>
                    <td td colspan="3">
                       <Ctl:Combo ID="cboPBMSCODE" Width="250px" runat="server"></Ctl:Combo>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center">
                        <Ctl:Text ID="lblPBMTITLE" runat="server" LangCode="lblPBMTITLE" Description="게시명" Required = "true"></Ctl:Text>
                    </td>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtPBMTITLE" Width="600px" runat="server" LangCode="txtPBMTITLE" Description="게시명" ></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center">
                        <Ctl:Text ID="lblPBMPUSABUN" runat="server" LangCode="lblPBMPUSABUN" Description="게시자" ></Ctl:Text>
                    </td>
                    <td >
                        <Ctl:SearchView ID="svPBMPUSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                            <Ctl:SearchViewField runat="server" DataField="KBSABUN"   TextField="KBSABUN"   Description="사 번" Hidden="false" TextBox="true" Width="100"   />
                            <Ctl:SearchViewField runat="server" DataField="KBHANGL" TextField="KBHANGL" Description="이 름"     Hidden="false" TextBox="true" Width="100" Default="true"/>                                            
                        </Ctl:SearchView>
                    </td>
                    <td style="text-align:center">
                        <Ctl:Text ID="lblPBMPUDATE" runat="server" LangCode="lblPBMPUDATE" Description="게시일자"></Ctl:Text>
                    </td>
                    <td >
                        <Ctl:TextBox ID="txtPBMPUDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center">
                        <Ctl:Text ID="lblATTACH" runat="server" LangCode="lblATTACH" Description="첨부파일" ></Ctl:Text>
                    </td>
                    <td colspan="3">
                        <Ctl:FileUpload ID="fuName1" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                    </td>
                </tr>
                <tr>
                    <th colspan="4" style="text-align:left;">
                        <Ctl:Text ID="Text2" runat="server" LangCode="lblPBDMODESC" Description="수정이력 관리"></Ctl:Text>
                    </th>
                    <%--<th style="text-align:right">
                        <Ctl:Button ID="btnDetailNew" runat="server" Style="Orange" LangCode="btnDetailNew" Description="신규" OnClientClick="btnDetailNew_Click();" ></Ctl:Button>                        
                        <Ctl:Button ID="btnDetailSave" runat="server" Style="Orange" LangCode="btnDetailSave" Description="저장" OnClientClick="btnDetailSave_Click();" ></Ctl:Button>
                    </th>--%>
                </tr>
                <tr>
                    <td style="text-align:center">
                        <Ctl:TextBox ID="txtPBDMOSEQ" Width="0px" runat="server" LangCode="txtPBDMOSEQ" Description="수정이력순번" Hidden="true"></Ctl:TextBox>
                        <Ctl:Text ID="lblPBDMODESC" runat="server" LangCode="lblPBDMODESC" Description="수정내용"></Ctl:Text>
                    </td>
                    <td colspan="3">
                        <Ctl:TextBox ID="txtPBDMODESC" Width="600px" runat="server" LangCode="txtPBDMODESC" Description="수정내용" ></Ctl:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center">
                        <Ctl:Text ID="lblPBDMOSABUN" runat="server" LangCode="lblPBDMOSABUN" Description="수정자" ></Ctl:Text>
                    </td>
                    <td >
                        <Ctl:SearchView ID="svPBDMOSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                            <Ctl:SearchViewField runat="server" DataField="KBSABUN"   TextField="KBSABUN"   Description="사 번" Hidden="false" TextBox="true" Width="100"   />
                            <Ctl:SearchViewField runat="server" DataField="KBHANGL" TextField="KBHANGL" Description="이 름"     Hidden="false" TextBox="true" Width="100" Default="true"/>                                            
                        </Ctl:SearchView>
                    </td>
                    <th>
                        <Ctl:Text ID="lblPBDMODATE" runat="server" LangCode="lblPBDMODATE" Description="수정일자"></Ctl:Text>
                    </th>
                    <td >
                        <Ctl:TextBox ID="txtPBDMODATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="border-right:hidden">
                        <Ctl:Text ID="Text1" runat="server" LangCode="Text1" Description="[수정이력]" ></Ctl:Text>
                    </td>
                    <td style="text-align:right;border-right:hidden">
                        <Ctl:Button ID="btnDetailSave" runat="server" Style="Orange" LangCode="btnDetailSave" Description="이력수정" OnClientClick="btnDetailSave_Click();" ></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="true" Width="100%" HFixation="true" Height="130" TypeName="PSM.PSM2010" MethodName="UP_GET_BOARD_DETAIL_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                        <Ctl:SheetField DataField="PBDLCODE" TextField="PBDLCODE" Description="대분류" Width="0"  HAlign="center" Align="left" runat="server" OnClick="" Hidden="true" />
                        <Ctl:SheetField DataField="PBDMCODE" TextField="PBDMCODE" Description="중분류" Width="100" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>                            
                        <Ctl:SheetField DataField="PBDSCODE" TextField="PBDSCODE" Description="소분류" Width="100" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                        <Ctl:SheetField DataField="PBDNUM" TextField="PBDNUM" Description="순번" Width="80" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>
                        <Ctl:SheetField DataField="PBDMOSEQ" TextField="PBDMOSEQ" Description="수정순번" Width="80" HAlign="center" Align="center" runat="server" OnClick="" Hidden="false"/>
                        <Ctl:SheetField DataField="PBDMODESC" TextField="PBDMODESC" Description="수정내용" Width="*" HAlign="center" Align="left" runat="server" Edit="true" DataType="text" EditType="Text" OnClick="" Hidden="false" />
                        <Ctl:SheetField DataField="PBDMOSABUN" TextField="PBDMOSABUN" Description="사번" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true" />
                        <Ctl:SheetField DataField="KBHANGL" TextField="KBHANGL" Description="수정자" Width="100" HAlign="center" Align="center" runat="server" OnClick="" Hidden="false" />
                        <Ctl:SheetField DataField="PBDMODATE" TextField="PBDMODATE" Description="수정일자" Width="120" HAlign="center" Align="center" runat="server" OnClick="" Hidden="false" />
                    </Ctl:WebSheet>
                </tr>
            </table>
		</Ctl:Layer>

        
	</div>

</asp:content>