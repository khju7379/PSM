<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4045.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4045" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        var DataGubn = "";

        var _JSLWKGUBN = "";
        var _JSLWKTEAM = "";
        var _JSLWKDATE = "";
        var _JSLWKSEQ = "";
        var _JSLDATE = "";
        var _JSLSEQ = "";
        var _JSMBLASS = "";
        var _JSMMLASS = "";
        var _JSMSLASS = "";
        var _JSMSEQ = "";

        function OnLoad() {

            var CODE = "<%= Request.QueryString["CODE"] %>";

            var data = CODE.split('^');

            if (data.length > 1) {

                DataGubn == "";
                _JSLWKGUBN = data[0];
                _JSLWKTEAM = data[1];
                _JSLWKDATE = data[2];
                _JSLWKSEQ = data[3];
                _JSLDATE = data[4];
                _JSLSEQ = data[5];
                _JSMBLASS = data[6];
                _JSMMLASS = data[7];
                _JSMSLASS = data[8];
                _JSMSEQ = data[9];

                UP_DataBind_Run();
            }
            else {

                DataGubn = "ADD";
                _JSLWKGUBN = "";
                _JSLWKTEAM = "";
                _JSLWKDATE = "";
                _JSLWKSEQ = "";
                _JSLDATE = "";
                _JSLSEQ = "";
                _JSMBLASS = "";
                _JSMMLASS = "";
                _JSMSLASS = "";
                _JSMSEQ = "";

                btnDel.Hide();
            }
        }

        // 데이터 바인딩
        function UP_DataBind_Run() {

            var ht = new Object();
            var SACODE = "";
            var SANAME = "";
            var TOCODE = "";
            var TONAME = "";
            var sessionid = "<%= Session.SessionID %>";

            DataGubn = "";
            btnDel.Show();

            ht["P_SESSIONID"] = sessionid;
            ht["P_JSMWKGUBN"] = _JSLWKGUBN;
            ht["P_JSMPOTEAM"] = _JSLWKTEAM; //
            ht["P_JSMPODATE"] = _JSLWKDATE;
            ht["P_JSMPOSEQ"] = _JSLWKSEQ;  //
            ht["P_JSMDATE"] = _JSLDATE;
            ht["P_JSMMSEQ"] = _JSLSEQ;
            ht["P_JSMBLASS"] = _JSMBLASS;
            ht["P_JSMMLASS"] = _JSMMLASS;
            ht["P_JSMSLASS"] = _JSMSLASS;
            ht["P_JSMSEQ"] = _JSMSEQ;
            ht["P_GUBUN"] = "S";

            //alert(sessionid + "-" + _JSLWKGUBN + "-" + _JSLWKTEAM + "-" + _JSLWKDATE + "-" + _JSLWKSEQ + "-" + _JSLDATE + "-" + _JSLSEQ + "-" + _JSMBLASS + "-" + _JSMMLASS + "-" + _JSMSLASS + "-" + _JSMSEQ);

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4045", "UP_JSACHANGE_MASTER_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtJSMWKGUBN.SetValue(DataSet.Tables[0].Rows[0]["JSMWKGUBN"]);
                    txtJSMPOTEAM.SetValue(DataSet.Tables[0].Rows[0]["JSMPOTEAM"]);
                    txtJSMPODATE.SetValue(DataSet.Tables[0].Rows[0]["JSMPODATE"]);
                    txtJSMPOSEQ.SetValue(DataSet.Tables[0].Rows[0]["JSMPOSEQ"]);
                    txtJSMDATE.SetValue(DataSet.Tables[0].Rows[0]["JSMDATE"]);
                    txtJSMMSEQ.SetValue(DataSet.Tables[0].Rows[0]["JSMMSEQ"]);
                    txtJSMBLASS.SetValue(DataSet.Tables[0].Rows[0]["JSMBLASS"]);
                    txtJSMBLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JBCODE"]);
                    txtJSMMLASS.SetValue(DataSet.Tables[0].Rows[0]["JSMMLASS"]);
                    txtJSMMLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JMCODE"]);
                    txtJSMSLASS.SetValue(DataSet.Tables[0].Rows[0]["JSMSLASS"]);
                    txtJSMSLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JSCODE"]);
                    txtJSMSEQ.SetValue(DataSet.Tables[0].Rows[0]["JSMSEQ"]);
                    txtJSMWKNAME.SetValue(DataSet.Tables[0].Rows[0]["JSMWKNAME"]);
                    txtJSMSYSTEM.SetValue(DataSet.Tables[0].Rows[0]["JSMSYSTEM"]);
                    txtJSMWKDATE.SetValue(DataSet.Tables[0].Rows[0]["JSMWKDATE"]);
                    txtJSMADDATE.SetValue(DataSet.Tables[0].Rows[0]["JSMADDATE"]);
                    txtJSMADCHASU.SetValue(DataSet.Tables[0].Rows[0]["JSMADCHASU"]);
                    svJSMSECTIONNUM.SetValue(DataSet.Tables[0].Rows[0]["JSMSECTIONNUM"]);
                    $("#svJSMSECTIONNUM_CDDESC1").val(DataSet.Tables[0].Rows[0]["H1CODE"]);
                    txtJSMMSDSCODE.SetValue(DataSet.Tables[0].Rows[0]["JSMMSDSCODE"]);
                    txtJSMMSDSSEQ.SetValue(DataSet.Tables[0].Rows[0]["JSMMSDSSEQ"]);
                    svJSMWKSABUN.SetValue(DataSet.Tables[0].Rows[0]["JSMWKSABUN"]);
                    $("#svJSMWKSABUN_KBHANGL").val(DataSet.Tables[0].Rows[0]["JSMWKSABUNNM"]);
                    txtJSMWKSUMMARY.SetValue(DataSet.Tables[0].Rows[0]["JSMWKSUMMARY"]);
                    txtJSMSANAME.SetValue(DataSet.Tables[0].Rows[0]["JSMSANAME"]);
                    txtJSMNEEDDATA.SetValue(DataSet.Tables[0].Rows[0]["JSMNEEDDATA"]);
                    txtJSMRISKCASE.SetValue(DataSet.Tables[0].Rows[0]["JSMRISKCASE"]);
                    txtJSMSELFNAME1.SetValue(DataSet.Tables[0].Rows[0]["JSMSELFNAME1"]);
                    txtJSMSELFTEXT1.SetValue(DataSet.Tables[0].Rows[0]["JSMSELFTEXT1"]);
                    txtJSMSELFNAME2.SetValue(DataSet.Tables[0].Rows[0]["JSMSELFNAME2"]);
                    txtJSMSELFTEXT2.SetValue(DataSet.Tables[0].Rows[0]["JSMSELFTEXT2"]);
                    txtJSMSELFNAME3.SetValue(DataSet.Tables[0].Rows[0]["JSMSELFNAME3"]);
                    txtJSMSELFTEXT3.SetValue(DataSet.Tables[0].Rows[0]["JSMSELFTEXT3"]);
                    txtJSMSELFNAME4.SetValue(DataSet.Tables[0].Rows[0]["JSMSELFNAME4"]);
                    txtJSMSELFTEXT4.SetValue(DataSet.Tables[0].Rows[0]["JSMSELFTEXT4"]);
                    txtJSMSELFNAME5.SetValue(DataSet.Tables[0].Rows[0]["JSMSELFNAME5"]);
                    txtJSMSELFTEXT5.SetValue(DataSet.Tables[0].Rows[0]["JSMSELFTEXT5"]);
                    txtJSMSCOMNAME1.SetValue(DataSet.Tables[0].Rows[0]["JSMSCOMNAME1"]);
                    txtJSMSCOMTEXT1.SetValue(DataSet.Tables[0].Rows[0]["JSMSCOMTEXT1"]);
                    txtJSMSCOMNAME2.SetValue(DataSet.Tables[0].Rows[0]["JSMSCOMNAME2"]);
                    txtJSMSCOMTEXT2.SetValue(DataSet.Tables[0].Rows[0]["JSMSCOMTEXT2"]);
                }

                // 개인안전보호구
                if (ObjectCount(DataSet.Tables[1].Rows) > 0) {


                    for (i = 0; i < ObjectCount(DataSet.Tables[1].Rows); i++) {
                        if (i == 0) {
                            SACODE = DataSet.Tables[1].Rows[i]['CODE'];
                            SANAME = DataSet.Tables[1].Rows[i]['NAME'];
                        }
                        else {
                            SACODE = SACODE + "," + DataSet.Tables[1].Rows[i]['CODE'];
                            SANAME = SANAME + ", " + DataSet.Tables[1].Rows[i]['NAME'];
                        }
                    }
                    txtSACODE.SetValue(SACODE);
                    txtSANAME.SetValue(SANAME);

                }
                else {
                    txtSACODE.SetValue("");
                    txtSANAME.SetValue("");
                }

                // 개인안전보호구
                if (ObjectCount(DataSet.Tables[2].Rows) > 0) {

                    for (i = 0; i < ObjectCount(DataSet.Tables[2].Rows); i++) {
                        if (i == 0) {
                            TOCODE = DataSet.Tables[2].Rows[i]['CODE'];
                            TONAME = DataSet.Tables[2].Rows[i]['NAME'];
                        }
                        else {
                            TOCODE = TOCODE + "," + DataSet.Tables[2].Rows[i]['CODE'];
                            TONAME = TONAME + ", " + DataSet.Tables[2].Rows[i]['NAME'];
                        }
                    }
                    txtTOCODE.SetValue(TOCODE);
                    txtTONAME.SetValue(TONAME);
                }
                else {
                    txtTOCODE.SetValue("");
                    txtTONAME.SetValue("");
                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            // JAS DETAIL 자료가 없는 경우 신규 등록 가능한 빈 로우 생성
            gridIndex.CallBack = function () {

                var dt = gridIndex.GetAllRow();

                if (ObjectCount(dt.Rows) == 0) {

                    gridIndex.InsertRow();

                    gridIndex.SetValue(ObjectCount(gridIndex.GetAllRow().Rows) - 1, "PRITEMTEXT", "<img src='/Resources/Images/Icon/it_res.png' style='cursor:pointer' onclick='gridClick();' />");
                }
            };
        }

        // 저장버튼
        function btnSave_Click() {

            if (txtJSMBLASS.GetValue() == "" || txtJSMBLASS.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="대분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJSMMLASS.GetValue() == "" || txtJSMMLASS.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="중분류를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJSMSLASS.GetValue() == "" || txtJSMSLASS.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="소분류를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJSMWKNAME.GetValue() == "" || txtJSMWKNAME.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="작업명을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJSMWKDATE.GetValue() == "" || txtJSMWKDATE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="작성일자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJSMADDATE.GetValue() == "" || txtJSMADDATE.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="개정일자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJSMWKSUMMARY.GetValue() == "" || txtJSMWKSUMMARY.GetValue() == null) {
                alert('<Ctl:Text runat="server" Description="작업개요를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_JSMWKGUBN"] = txtJSMWKGUBN.GetValue();
            ht["P_JSMPOTEAM"] = txtJSMPOTEAM.GetValue();
            ht["P_JSMPODATE"] = txtJSMPODATE.GetValue();
            ht["P_JSMPOSEQ"] = txtJSMPOSEQ.GetValue();
            ht["P_JSMDATE"] = txtJSMDATE.GetValue();
            ht["P_JSMMSEQ"] = txtJSMMSEQ.GetValue();
            ht["P_JSMBLASS"] = txtJSMBLASS.GetValue();
            ht["P_JSMMLASS"] = txtJSMMLASS.GetValue();
            ht["P_JSMSLASS"] = txtJSMSLASS.GetValue();
            if (DataGubn == "ADD") {
                ht["P_JSMSEQ"] = "0";
                ht["P_WKGUBUN"] = "A";
            }
            else{
                ht["P_JSMSEQ"] = txtJSMSEQ.GetValue();
                ht["P_WKGUBUN"] = "C";
            }
            ht["P_JSMWKNAME"] = txtJSMWKNAME.GetValue();
            ht["P_JSMSYSTEM"] = txtJSMSYSTEM.GetValue();
            ht["P_JSMWKDATE"] = txtJSMWKDATE.GetValue();
            ht["P_JSMADDATE"] = txtJSMADDATE.GetValue();
            ht["P_JSMADCHASU"] = txtJSMADCHASU.GetValue();
            ht["P_JSMWKSABUN"] = svJSMWKSABUN.GetValue();
            ht["P_JSMSANAME"] = txtJSMSANAME.GetValue();
            ht["P_JSMSECTIONNUM"] = svJSMSECTIONNUM.GetValue();
            ht["P_JSMMSDSCODE"] = txtJSMMSDSCODE.GetValue();
            if (txtJSMMSDSSEQ.GetValue() == "") {
                ht["P_JSMMSDSSEQ"] = "0";
            }
            else {
                ht["P_JSMMSDSSEQ"] = txtJSMMSDSSEQ.GetValue();
            }
            ht["P_JSMWKSUMMARY"] = txtJSMWKSUMMARY.GetValue();
            ht["P_JSMNEEDDATA"] = txtJSMNEEDDATA.GetValue();
            ht["P_JSMRISKCASE"] = txtJSMRISKCASE.GetValue();
            ht["P_JSMSELFNAME1"] = txtJSMSELFNAME1.GetValue();
            ht["P_JSMSELFTEXT1"] = txtJSMSELFTEXT1.GetValue();
            ht["P_JSMSELFNAME2"] = txtJSMSELFNAME2.GetValue();
            ht["P_JSMSELFTEXT2"] = txtJSMSELFTEXT2.GetValue();
            ht["P_JSMSELFNAME3"] = txtJSMSELFNAME3.GetValue();
            ht["P_JSMSELFTEXT3"] = txtJSMSELFTEXT3.GetValue();
            ht["P_JSMSELFNAME4"] = txtJSMSELFNAME4.GetValue();
            ht["P_JSMSELFTEXT4"] = txtJSMSELFTEXT4.GetValue();
            ht["P_JSMSELFNAME5"] = txtJSMSELFNAME5.GetValue();
            ht["P_JSMSELFTEXT5"] = txtJSMSELFTEXT5.GetValue();
            ht["P_JSMSCOMNAME1"] = txtJSMSCOMNAME1.GetValue();
            ht["P_JSMSCOMTEXT1"] = txtJSMSCOMTEXT1.GetValue();
            ht["P_JSMSCOMNAME2"] = txtJSMSCOMNAME2.GetValue();
            ht["P_JSMSCOMTEXT2"] = txtJSMSCOMTEXT2.GetValue();
            ht["P_SACODE"] = txtSACODE.GetValue();
            ht["P_SANAME"] = txtSANAME.GetValue();
            ht["P_TOCODE"] = txtTOCODE.GetValue();
            ht["P_TONAME"] = txtTONAME.GetValue();

            if (confirm('<Ctl:Text runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM4045", "UP_JSACHANGE_MASTER_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            DataGubn = "";
                            _JSLWKGUBN = DataSet.Tables[0].Rows[0]["JSMWKGUBN"];
                            _JSLWKTEAM = DataSet.Tables[0].Rows[0]["JSMPOTEAM"];
                            _JSLWKDATE = DataSet.Tables[0].Rows[0]["JSMPODATE"];
                            _JSLWKSEQ = DataSet.Tables[0].Rows[0]["JSMPOSEQ"];
                            _JSLDATE = DataSet.Tables[0].Rows[0]["JSMDATE"];
                            _JSLSEQ = DataSet.Tables[0].Rows[0]["JSMMSEQ"];
                            _JSMBLASS = DataSet.Tables[0].Rows[0]["JSMBLASS"];
                            _JSMMLASS = DataSet.Tables[0].Rows[0]["JSMMLASS"];
                            _JSMSLASS = DataSet.Tables[0].Rows[0]["JSMSLASS"];
                            _JSMSEQ = DataSet.Tables[0].Rows[0]["JSMSEQ"];

                            UP_DataBind_Run();

                            alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" Description="' + msg + '" Literal="true"></Ctl:Text>');
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

        // 삭제버튼
        function btnDel_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_JSMWKGUBN"] = txtJSMWKGUBN.GetValue();
            ht["P_JSMPOTEAM"] = txtJSMPOTEAM.GetValue();
            ht["P_JSMPODATE"] = txtJSMPODATE.GetValue();
            ht["P_JSMPOSEQ"] = txtJSMPOSEQ.GetValue();
            ht["P_JSMDATE"] = txtJSMDATE.GetValue();
            ht["P_JSMMSEQ"] = txtJSMMSEQ.GetValue();
            ht["P_JSMBLASS"] = txtJSMBLASS.GetValue();
            ht["P_JSMMLASS"] = txtJSMMLASS.GetValue();
            ht["P_JSMSLASS"] = txtJSMSLASS.GetValue();
            ht["P_JSMSEQ"] = txtJSMSEQ.GetValue();
            ht["P_WKGUBUN"] = "D";

            if (confirm('<Ctl:Text runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM4045", "UP_JSACHANGE_MASTER_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                            if (opener != null && typeof (opener.jsachange_popup_callback) == "function") {
                                opener.jsachange_popup_callback(txtJSMWKGUBN.GetValue(), txtJSMPOTEAM.GetValue(), txtJSMPODATE.GetValue(), txtJSMPOSEQ.GetValue());
                            }
                            this.close();
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

        // 닫기버튼
        function btnClose_Click() {

            this.close();
        }

        // 개인안전보호구 코드헬프
        function btnSACODE_Click() {
            
            var CODE = "SA^" + txtSACODE.GetValue();

            fn_OpenPopCustom("../POP/PSP1091.aspx?CODE=" + CODE, 400, 550, CODE);
        }

        // 안전장비 코드헬프
        function btnTOCODE_Click() {

            var CODE = "TO^" + txtTOCODE.GetValue();

            fn_OpenPopCustom("../POP/PSP1091.aspx?CODE=" + CODE, 400, 550, CODE);
        }

        function Popup_SACODE_Callback(CODE, NAME) {

            txtSACODE.SetValue(CODE);
            txtSANAME.SetValue(NAME);
        }

        function Popup_TOCODE_Callback(CODE, NAME) {

            txtTOCODE.SetValue(CODE);
            txtTONAME.SetValue(NAME);
        }

        

        // 그리드 버튼 선택 이벤트
        function gridClick(data) {

            if (data == undefined) {
                data = "";
            }

            var CODE = txtJSMBLASS.GetValue() + "^" + txtJSMMLASS.GetValue() + "^" + txtJSMSLASS.GetValue() + "^";
            CODE = CODE + txtJSMSEQ.GetValue() + "^" + txtJSMWKGUBN.GetValue() + "^" + txtJSMPOTEAM.GetValue() + "^";
            CODE = CODE + txtJSMPODATE.GetValue() + "^" + txtJSMPOSEQ.GetValue() + "^" + txtJSMDATE.GetValue() + "^" + txtJSMMSEQ.GetValue() + "^" + data;

            fn_OpenPopCustom("PSM4046.aspx?CODE=" + CODE, 1000, 720, CODE);
        }

        function gridRiskClick(data) {

            var  CODE = txtJSMWKGUBN.GetValue() + "^" + txtJSMPOTEAM.GetValue() + "^" + txtJSMPODATE.GetValue() + "^" + txtJSMPOSEQ.GetValue() + "^";
            CODE = CODE + txtJSMDATE.GetValue() + "^" + txtJSMMSEQ.GetValue() + "^" + txtJSMBLASS.GetValue() + "^" + txtJSMMLASS.GetValue() + "^" ;
            CODE = CODE + txtJSMSLASS.GetValue() + "^" + txtJSMSEQ.GetValue() + "^" + data + "^RISK";


            fn_OpenPopCustom("PSM4047.aspx?CODE=" + CODE, 1000, 680, CODE);
        }

        function gridReformClick(data) {

            var CODE = txtJSMWKGUBN.GetValue() + "^" + txtJSMPOTEAM.GetValue() + "^" + txtJSMPODATE.GetValue() + "^" + txtJSMPOSEQ.GetValue() + "^";
            CODE = CODE + txtJSMDATE.GetValue() + "^" + txtJSMMSEQ.GetValue() + "^" + txtJSMBLASS.GetValue() + "^" + txtJSMMLASS.GetValue() + "^";
            CODE = CODE + txtJSMSLASS.GetValue() + "^" + txtJSMSEQ.GetValue() + "^" + data + "^REFORM";

            fn_OpenPopCustom("PSM4047.aspx?CODE=" + CODE, 1000, 680, CODE);
        }

        // 등록 팝업 콜백
        function jsa_popup_callback() {

            var ht = new Object();
            var sessionid = "<%= Session.SessionID %>";

            ht["P_SESSIONID"] = sessionid;
            ht["P_JSMWKGUBN"] = _JSLWKGUBN;
            ht["P_JSMPOTEAM"] = _JSLWKTEAM; 
            ht["P_JSMPODATE"] = _JSLWKDATE;
            ht["P_JSMPOSEQ"] = _JSLWKSEQ;  
            ht["P_JSMDATE"] = _JSLDATE;
            ht["P_JSMMSEQ"] = _JSLSEQ;
            ht["P_JSMBLASS"] = _JSMBLASS;
            ht["P_JSMMLASS"] = _JSMMLASS;
            ht["P_JSMSLASS"] = _JSMSLASS;
            ht["P_JSMSEQ"] = _JSMSEQ;
            ht["P_GUBUN"] = "S";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
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

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="일일JSA관리" DefaultHide="False">
            <div class="content" >
                <table class="table_01" style="width: 100%;">    
                    <colgroup>
                        <col width="120" />
                        <col width="140" />
                        <col width="120" />
                        <col width="190" />
                        <col width="120" />
                        <col width="270" />
                        <col width="120" />
                        <col width="70" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                        <th>
                            <Ctl:TextBox ID="txtJSMWKGUBN" Width="0px" runat="server" Description="작성구분" Hidden="true"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtJSMPOTEAM" Width="0px" runat="server" Description="요청팀" Hidden="true"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtJSMPODATE" Width="0px" runat="server" Description="요청일자" Hidden="true"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtJSMPOSEQ" Width="0px" runat="server" Description="요청순번" Hidden="true"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtJSMDATE" Width="0px" runat="server" Description="작성일자" Hidden="true"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtJSMMSEQ" Width="0px" runat="server" Description="순번" Hidden="true"></Ctl:TextBox>

                            <Ctl:Text ID="lblJSMBLASS" runat="server" LangCode="lblJSMBLASS" Description="대분류" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtJSMBLASS" Width="40px" runat="server" LangCode="txtJSMBLASS" Description="대분류" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtJSMBLASSNM" Width="80px" runat="server" LangCode="txtJSMBLASSNM" Description="대분류명" ReadOnly="true"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMMLASS" runat="server" LangCode="lblJSMMLASS" Description="중분류" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtJSMMLASS" Width="40px" runat="server" LangCode="txtJSMMLASS" Description="중분류" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtJSMMLASSNM" Width="130px" runat="server" LangCode="txtJSMMLASSNM" Description="중분류명" ReadOnly="true"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSLASS" runat="server" LangCode="lblJSMSLASS" Description="소분류" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtJSMSLASS" Width="40px" runat="server" LangCode="txtJSMSLASS" Description="소분류" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtJSMSLASSNM" Width="180px" runat="server" LangCode="txtJSMSLASSNM" Description="소분류명" ReadOnly="true"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSEQ" runat="server" LangCode="lblJSMSEQ" Description="작업순번" ></Ctl:Text>
                        </th>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtJSMSEQ" Width="60px" runat="server" LangCode="txtJSMSEQ" Description="작업순번" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                        </td>
                        <td style="text-align:right">
                                        
                            <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();"></Ctl:Button>
                            <Ctl:Button ID="btnDel" runat="server" LangCode="btnDel" Description="삭제" OnClientClick="btnDel_Click();"></Ctl:Button>
                            <Ctl:Button ID="btnClose" runat="server" LangCode="btnClose" Description="닫기" OnClientClick="btnClose_Click();"></Ctl:Button>
                        </td>
                    </tr>
                </table>
                <table class="table_01" style="width: 100%;">    
                    <colgroup>
                        <col width="120" />
                        <col width="*" />
                        <col width="120" />
                        <col width="*" />
                        <col width="120" />
                        <col width="500" />
                    </colgroup>
                    <tr>
                        <th>
                            <Ctl:Text ID="lblJSMWKNAME" runat="server" LangCode="lblJSMWKNAME" Description="작업명" Required = "true"></Ctl:Text>
                        </th>
                        <td colspan="3">
                            <Ctl:TextBox ID="txtJSMWKNAME" Width="100%" runat="server" LangCode="txtJSMWKNAME" Description="작업명"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSYSTEM" runat="server" LangCode="lblJSMSYSTEM" Description="설비기능" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSYSTEM" Width="100%" runat="server" LangCode="txtJSMSYSTEM" Description="설비기능"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <Ctl:Text ID="lblJSMWKDATE" runat="server" LangCode="lblJSMWKDATE" Description="작성일자" Required = "true"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtJSMWKDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMADDATE" runat="server" LangCode="lblJSMADDATE" Description="개정일자" Required = "true"></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtJSMADDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMADCHASU" runat="server" LangCode="lblJSMADCHASU" Description="개정차수" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtJSMADCHASU" Width="60px" runat="server" LangCode="txtJSMADCHASU" Description="개정차수" MaxLength="3"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <Ctl:Text ID="lblJSMSECTIONNUM" runat="server" LangCode="lblJSMSECTIONNUM" Description="도면번호" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:SearchView ID="svJSMSECTIONNUM" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'H1'}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                                <Ctl:SearchViewField runat="server" DataField="CDCODE"   TextField="CDCODE"   Description="코드" Hidden="false" TextBox="true" Width="80" Default="true"  />
                                <Ctl:SearchViewField runat="server" DataField="CDDESC1" TextField="CDDESC1" Description="코드명"     Hidden="false" TextBox="true" Width="150" />                                            
                            </Ctl:SearchView>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMMSDSCODE" runat="server" LangCode="lblJSMMSDSCODE" Description="MSDS" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtJSMMSDSCODE" Width="60px" runat="server" LangCode="txtJSMMSDSCODE" Description="MSDS 코드" MaxLength="3"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtJSMMSDSSEQ" Width="60px" runat="server" LangCode="txtJSMMSDSSEQ" Description="MSDS 순번" MaxLength="3"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMWKSABUN" runat="server" LangCode="lblJSMWKSABUN" Description="작성자" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:SearchView ID="svJSMWKSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                                <Ctl:SearchViewField runat="server" DataField="KBSABUN"   TextField="KBSABUN"   Description="사 번" Hidden="false" TextBox="true" Width="100" Default="true"  />
                                <Ctl:SearchViewField runat="server" DataField="KBHANGL" TextField="KBHANGL" Description="이 름"     Hidden="false" TextBox="true" Width="100" />                                            
                            </Ctl:SearchView>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <Ctl:Text ID="lblJSMWKSUMMARY" runat="server" LangCode="lblJSMWKSUMMARY" Description="작업개요" Required = "true"></Ctl:Text>
                        </th>
                        <td colspan="3">
                            <Ctl:TextBox ID="txtJSMWKSUMMARY" Width="100%" runat="server" LangCode="txtJSMWKSUMMARY" Description="작업개요"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSANAME" runat="server" LangCode="lblJSMSANAME" Description="위험성평가 참여자" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSANAME" Width="100%" runat="server" LangCode="txtJSMSANAME" Description="위험성평가 참여자"></Ctl:TextBox>
                        </td>
                    </tr>
                </table>
                <table class="table_01" style="width: 100%;">    
                    <colgroup>
                        <col width="120" />
                        <col width="140" />
                        <col width="120" />
                        <col width="*" />
                        <col width="120" />
                        <col width="140" />
                        <col width="120" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                        <td colspan="8">
                            <Ctl:Text ID="Text12" runat="server" LangCode="Text12" Description="작업인력 및 역할(자체인원)" ></Ctl:Text>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <Ctl:Text ID="lblJSMNEEDDATA" runat="server" LangCode="lblJSMNEEDDATA" Description="작업에 필요한 자료" ></Ctl:Text>
                        </th>
                        <td colspan="3">
                            <Ctl:TextBox ID="txtJSMNEEDDATA" Width="100%" runat="server" LangCode="txtJSMNEEDDATA" Description="작업에 필요한 자료"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMRISKCASE" runat="server" LangCode="lblJSMRISKCASE" Description="사고사례" ></Ctl:Text>
                        </th>
                        <td colspan="3">
                            <Ctl:TextBox ID="txtJSMRISKCASE" Width="100%" runat="server" LangCode="txtJSMRISKCASE" Description="사고사례"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <Ctl:Text ID="lblJSMSELFNAME1" runat="server" LangCode="lblJSMSELFNAME1" Description="자체인원명1" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSELFNAME1" Width="100%" runat="server" LangCode="txtJSMSELFNAME1" Description="자체인원명1"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSELFTEXT1" runat="server" LangCode="lblJSMSELFTEXT1" Description="내용1" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSELFTEXT1" Width="100%" runat="server" LangCode="txtJSMSELFTEXT1" Description="내용1"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSELFNAME2" runat="server" LangCode="lblJSMSELFNAME2" Description="자체인원명2" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSELFNAME2" Width="100%" runat="server" LangCode="txtJSMSELFNAME2" Description="자체인원명2"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSELFTEXT2" runat="server" LangCode="lblJSMSELFTEXT2" Description="내용2" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSELFTEXT2" Width="100%" runat="server" LangCode="txtJSMSELFTEXT2" Description="내용2"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <Ctl:Text ID="lblJSMSELFNAME3" runat="server" LangCode="lblJSMSELFNAME3" Description="자체인원명3" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSELFNAME3" Width="100%" runat="server" LangCode="txtJSMSELFNAME3" Description="자체인원명3"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSELFTEXT3" runat="server" LangCode="lblJSMSELFTEXT3" Description="내용3" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSELFTEXT3" Width="100%" runat="server" LangCode="txtJSMSELFTEXT3" Description="내용3"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSELFNAME4" runat="server" LangCode="lblJSMSELFNAME4" Description="자체인원명4" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSELFNAME4" Width="100%" runat="server" LangCode="txtJSMSELFNAME4" Description="자체인원명4"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSELFTEXT4" runat="server" LangCode="lblJSMSELFTEXT4" Description="내용4" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSELFTEXT4" Width="100%" runat="server" LangCode="txtJSMSELFTEXT4" Description="내용4"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <Ctl:Text ID="lblJSMSELFNAME5" runat="server" LangCode="lblJSMSELFNAME5" Description="자체인원명5" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSELFNAME5" Width="100%" runat="server" LangCode="txtJSMSELFNAME5" Description="자체인원명5"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSELFTEXT5" runat="server" LangCode="lblJSMSELFTEXT5" Description="내용5" ></Ctl:Text>
                        </th>
                        <td>
                            <Ctl:TextBox ID="txtJSMSELFTEXT5" Width="100%" runat="server" LangCode="txtJSMSELFTEXT5" Description="내용5"></Ctl:TextBox>
                        </td>
                        <td colspan="4">
                        </td>
                    </tr>
                </table>
                <table class="table_01" style="width: 100%;">    
                    <colgroup>
                        <col width="120" />
                        <col width="140" />
                        <col width="120" />
                        <col width="*" />
                        <col width="120" />
                        <col width="140" />
                        <col width="120" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                        <td colspan="8">
                            <Ctl:Text ID="Text23" runat="server" LangCode="Text23" Description="작업인력 및 역할(용역업체)" ></Ctl:Text>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <Ctl:Text ID="lblJSMSCOMNAME1" runat="server" LangCode="lblJSMSCOMNAME1" Description="용역업체명1" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSCOMNAME1" Width="100%" runat="server" LangCode="txtJSMSCOMNAME1" Description="용역업체명1"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSCOMTEXT1" runat="server" LangCode="lblJSMSCOMTEXT1" Description="내용1" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSCOMTEXT1" Width="100%" runat="server" LangCode="txtJSMSCOMTEXT1" Description="내용1"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSCOMNAME2" runat="server" LangCode="lblJSMSCOMNAME2" Description="용역업체명2" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSCOMNAME2" Width="100%" runat="server" LangCode="txtJSMSCOMNAME2" Description="용역업체명2"></Ctl:TextBox>
                        </td>
                        <th>
                            <Ctl:Text ID="lblJSMSCOMTEXT2" runat="server" LangCode="lblJSMSCOMTEXT2" Description="내용2" ></Ctl:Text>
                        </th>
                        <td >
                            <Ctl:TextBox ID="txtJSMSCOMTEXT2" Width="100%" runat="server" LangCode="txtJSMSCOMTEXT2" Description="내용2"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <Ctl:Text ID="lblSANAME" runat="server" LangCode="lblSANAME" Description="개인안전보호구" ></Ctl:Text>
                        </th>
                        <td colspan="3">
                            <Ctl:TextBox ID="txtSACODE" Width="0" runat="server" LangCode="txtSACODE" Hidden="true"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtSANAME" runat="server"  Height="60"
                                    ReadMode="false" ReadOnly="false" SetType="text"
                                    Text="" TextMode="MultiLine" Validation="false" Width="550px">
                                </Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnSACODE" alt="분류추가" style="cursor:pointer;height: 25px;width: 25px;;vertical-align:top;" onclick="btnSACODE_Click();"  />
                        </td>
                        <th>
                            <Ctl:Text ID="lblTONAME" runat="server" LangCode="lblTONAME" Description="안전장비" ></Ctl:Text>
                        </th>
                        <td colspan="3">
                            <Ctl:TextBox ID="txtTOCODE" Width="0" runat="server" LangCode="txtTOCODE" Hidden="true"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtTONAME" runat="server"  Height="60"
                                    ReadMode="false" ReadOnly="false" SetType="text"
                                    Text="" TextMode="MultiLine" Validation="false" Width="550px">
                                </Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnTOCODE" alt="분류추가" style="cursor:pointer;height: 25px;width: 25px;vertical-align:top;" onclick="btnTOCODE_Click();"  />
                        </td>
                    </tr>
                </table>
                <Ctl:WebSheet ID="gridIndex" runat="server" Paging="false" CheckBox="false" Width="100%" Height="250" HFixation="true" TypeName="PSM.PSM4045" MethodName="UP_JSACHANGE_PRT_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                    <Ctl:SheetField DataField="PRBLASS" TextField="PRBLASS" Description="" Width="0"  HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>
                    <Ctl:SheetField DataField="PRMLASS" TextField="PRMLASS" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>
                    <Ctl:SheetField DataField="PRSLASS" TextField="PRSLASS" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>
                    <Ctl:SheetField DataField="PRSEQ" TextField="PRSEQ" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>
                    <Ctl:SheetField DataField="PRITEMSEQ" TextField="PRITEMSEQ" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>
                    <Ctl:SheetField DataField="PRRSUBSEQ" TextField="PRRSUBSEQ" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/> 
                    <Ctl:SheetField DataField="PRESUBSEQ" TextField="PRESUBSEQ" Description="" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>
                    <Ctl:SheetField DataField="PRITEMTEXT" TextField="PRITEMTEXT" Description="작업단계" Width="180" HAlign="center" Align="left" runat="server" OnClick="" />
                    <Ctl:SheetField DataField="PRRISKTEXT" TextField="PRRISKTEXT" Description="위험성" Width="*" HAlign="center" Align="left" runat="server" OnClick="" />
                    <Ctl:SheetField DataField="PRRISKCNT" TextField="PRRISKCNT" Description="빈도" Width="50" HAlign="center" Align="left" runat="server" OnClick="" />
                    <Ctl:SheetField DataField="PRRISKSOLID" TextField="PRRISKSOLID" Description="강도" Width="50" HAlign="center" Align="left" runat="server" OnClick="" />
                    <Ctl:SheetField DataField="PRRISKDEGREE" TextField="PRRISKDEGREE" Description="위험도" Width="50" HAlign="center" Align="left" runat="server" OnClick="" />
                    <Ctl:SheetField DataField="PREREFORMTEXT" TextField="PREREFORMTEXT" Description="개선대책" Width="*" HAlign="center" Align="left" runat="server" OnClick="" />
                    <Ctl:SheetField DataField="PREREFORMCNT" TextField="PREREFORMCNT" Description="빈도" Width="50" HAlign="center" Align="left" runat="server" OnClick="" />
                    <Ctl:SheetField DataField="PREREFORMSOLID" TextField="PREREFORMSOLID" Description="강도" Width="50" HAlign="center" Align="left" runat="server" OnClick="" />
                    <Ctl:SheetField DataField="PREREFORMDEGREE" TextField="PREREFORMDEGREE" Description="위험도" Width="50" HAlign="center" Align="left" runat="server" OnClick="" />
                    <Ctl:SheetField DataField="PRTOOLTEXT" TextField="PRTOOLTEXT" Description="장비 및 도구" Width="*" HAlign="center" Align="left" runat="server" OnClick="" />
                </Ctl:WebSheet>
            </div>
        </Ctl:Layer> 
    </div>
</asp:content>
