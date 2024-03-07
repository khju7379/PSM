 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4011.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4011" %>
 
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <style>           
            html,body {width:100%;  }
            body,div,ul,li{margin:0; padding:0;}
            ul,li {list-style:none;}

            /*tab css*/
            .tab_op{float:left; width:100%; height:220px; }
            .tabnav_op{font-size:0; width:500px; border:0px solid #ddd;}
            
            .tabnav_op li{display: inline-block;  height:30px; text-align:center; border-right:1px solid #ddd;}

            .tabnav_op li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:2px; }

            .tabnav_op li a.active:before{background:#A32958;}

            .tabnav_op li a.active{border-bottom:1px solid #fff;}
            .tabnav_op li a{ position:relative; display:block; background: #f8f8f8; color: #646464; padding:0 30px; line-height:30px; text-decoration:none; font-size:13px;}
            .tabnav_op li a:hover,
            .tabnav_op li a.active{background:#fff; color:#A32958; }            
            .tabcontent_op{padding: 5px; height:680px; border:1px solid #ddd; border-top:none;}

            /*tab css*/
            .tab_wk{float:left; width:100%; height:200px; }
            .tabnav_wk{font-size:0; width:500px; border:0px solid #ddd;}
            
            .tabnav_wk li{display: inline-block;  height:30px; text-align:center; border-right:1px solid #ddd;}

            .tabnav_wk li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:2px; }

            .tabnav_wk li a.active:before{background:#A32958;}

            .tabnav_wk li a.active{border-bottom:1px solid #fff;}
            .tabnav_wk li a{ position:relative; display:block; background: #f8f8f8; color: #646464; padding:0 30px; line-height:30px; text-decoration:none; font-size:13px;}
            .tabnav_wk li a:hover,
            .tabnav_wk li a.active{background:#fff; color:#A32958; }            
            .tabcontent_wk{padding: 5px; height:680px; border:1px solid #ddd; border-top:none;}
            
    </style>

    <script type="text/javascript" id="GT">

        function doDisplay() {

            var obj = document.getElementById("div_btn");


            debugger;
            if (obj.style.display == 'none') {
                obj.style.display = '';
            } else {
                obj.style.display = 'none';
            }
        }

        function hid() {

            debugger;
            var obj = document.getElementById("div_btn");
            obj.display

            obj.style.width = document.body.scrollWidth + 'px';
            obj.style.height = document.body.scrollHeight + 'px';
            obj.style.filter = "alpha(opacity=80)";
            obj.style.opacity = "3.8";

            obj.style.visibility = "visible";
        }

        
        var fsWOORTEAM = "";
        var fsWOORDATE = "";
        var fsWOSEQ = "0";

        var fshdnSOApproval = "0";
        var fshdnREApproval = "0";

        // 작업구분
        var fshdnExists = "";

        // 요청 결재순서
        var fshdnSOApproval = "";
        // 수신 결재순서
        var fshdnREApproval = "";

        var fshdnSOSign = "";
        var fshdnRESign = "";
        
        // 사번
        var fshdnLoginSabun = "";

        // 위험성평가체크
        var fsRMWKTEAM = "";

        var DataGubn = "";
        var _id = "";

        var fsRETRACTCOMMENT = "";

        var fsWOIMMEDGUBN = "";

        var fsRESABUN = "";

        // 페이지 로드
        function OnLoad() {

            $("#btnRETRACT").css("background-image", "url(/Resources/Images/Approval/reject.png)");
            $("#btnRETRACT").css("background-repeat", "no-repeat");
            $("#btnRETRACT").css("background-position", "3px 4px");
            $("#btnRETRACT").css("background-size", "17px, 17px");
            $("#btnRETRACT").css("padding-left", "30px");

            $("#btnSOApproval").css("background-image", "url(/Resources/Images/Approval/setline.png)");
            $("#btnSOApproval").css("background-repeat", "no-repeat");
            $("#btnSOApproval").css("background-position", "3px 4px");
            $("#btnSOApproval").css("background-size", "17px, 17px");
            $("#btnSOApproval").css("padding-left", "30px");

            $("#btnSave").css("background-image", "url(/Resources/Images/Approval/save.png)");
            $("#btnSave").css("background-repeat", "no-repeat");
            $("#btnSave").css("background-position", "3px 4px");
            $("#btnSave").css("background-size", "17px, 17px");
            $("#btnSave").css("padding-left", "30px");

            $("#btnDel").css("background-image", "url(/Resources/Images/Approval/delete.png)");
            $("#btnDel").css("background-repeat", "no-repeat");
            $("#btnDel").css("background-position", "3px 4px");
            $("#btnDel").css("background-size", "17px, 17px");
            $("#btnDel").css("padding-left", "30px");

            $("#btnApproval").css("background-image", "url(/Resources/Images/Approval/Approval.png)");
            $("#btnApproval").css("background-repeat", "no-repeat");
            $("#btnApproval").css("background-position", "3px 4px");
            $("#btnApproval").css("background-size", "17px, 17px");
            $("#btnApproval").css("padding-left", "30px");

            $("#btnCancel").css("background-image", "url(/Resources/Images/Approval/reject.png)");
            $("#btnCancel").css("background-repeat", "no-repeat");
            $("#btnCancel").css("background-position", "3px 4px");
            $("#btnCancel").css("background-size", "17px, 17px");
            $("#btnCancel").css("padding-left", "30px");

            $("#btnPrt").css("background-image", "url(/Resources/Images/Approval/print.png)");
            $("#btnPrt").css("background-repeat", "no-repeat");
            $("#btnPrt").css("background-position", "3px 4px");
            $("#btnPrt").css("background-size", "17px, 17px");
            $("#btnPrt").css("padding-left", "30px");

            $("#btnClose").css("background-image", "url(/Resources/Images/Approval/close.png)");
            $("#btnClose").css("background-repeat", "no-repeat");
            $("#btnClose").css("background-position", "3px 4px");
            $("#btnClose").css("background-size", "17px, 17px");
            $("#btnClose").css("padding-left", "30px");

            tabControl_opion("agree");
            tabControl_work("ok");

            fshdnLoginSabun = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";

            fshdnExists = "<%= Request.QueryString["param"] %>";

            var Num = "<%= Request.QueryString["param1"] %>";

            var data = Num.split('-');

            svWOFINISHSABUN.SetDisabled(true);
            $("#svWOFINISHSABUN_KBSABUN_img").attr("style", "display:none");
            txtWOFINISHTEXT.SetDisabled(true);

            svWOIMMEDSABUN.SetDisabled(true);
            $("#svWOIMMEDSABUN_KBSABUN_img").attr("style", "display:none");
            txtWOIMMEDTEXT.SetDisabled(true);

            if (fshdnExists == 'NEW') {

                var today = new Date();

                txtWOORDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
                txtWODSDATE1.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
                txtWODSDATE2.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

                txtWOORTEAM.SetValue("");
                txtWOORDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
                txtWOSEQ.SetValue("");

                // 요청부서 가져오기
                fn_SET_Buseo();

                btnDel.Hide();

                //fn_GET_Site();

                // 요청 결재자
                fn_Btn_Visible('0');

                fn_ReadOnly();
            }
            else {
                if (data.length > 1) {

                    txtWOORTEAM.SetValue(data[0]);
                    txtWOORDATE.SetValue(data[1]);
                    txtWOSEQ.SetValue(data[2]);

                    fn_GET_Display();
                }
            }
        }

        function tabControl_opion(gubun) {

            if (gubun == "agree") {
                $('.tabcontent_op > div').hide();

                $('.tabnav_op a').click(function () {
                    $('.tabcontent_op > div').hide().filter(this.hash).fadeIn();
                    $('.tabnav_op a').removeClass('active');
                    $(this).addClass('active');
                    return false;
                }).filter(':eq(0)').click();
            }
            else {
                $('.tabcontent_op > div').hide();

                $('.tabnav_op a').click(function () {
                    $('.tabcontent_op > div').hide().filter(this.hash).fadeIn();
                    $('.tabnav_op a').removeClass('active');
                    $(this).addClass('active');
                    return false;
                }).filter(':eq(1)').click();
            }
        }

        function tabControl_work(gubun) {

            if (gubun == "ok") {
                $('.tabcontent_wk > div').hide();

                $('.tabnav_wk a').click(function () {
                    $('.tabcontent_wk > div').hide().filter(this.hash).fadeIn();
                    $('.tabnav_wk a').removeClass('active');
                    $(this).addClass('active');
                    return false;
                }).filter(':eq(0)').click();
            }
            else {
                $('.tabcontent_wk > div').hide();

                $('.tabnav_wk a').click(function () {
                    $('.tabcontent_wk > div').hide().filter(this.hash).fadeIn();
                    $('.tabnav_wk a').removeClass('active');
                    $(this).addClass('active');
                    return false;
                }).filter(':eq(1)').click();
            }
        }

        function fn_ReadOnly() {

            var bReadOnly;
            var bReadOnly1;


            if (txtWOAPPSODATE1.GetValue() != "") {
                bReadOnly = true;
            }
            else {
                bReadOnly = false;
            }

            // 위험성평가 자료 체크
            if (fsRMWKTEAM != "") {
                bReadOnly1 = true;
            }
            else {
                bReadOnly1 = false;
            }

            if (fshdnExists == "NEW") {
               fn_Field_ReadOnly(bReadOnly, bReadOnly1, false);
            }
            else {
                fn_Field_ReadOnly(bReadOnly, bReadOnly1, true);
            }
        }

        function fn_Field_ReadOnly(bReadOnly, bReadOnly1, bReadOnly2) {
            txtWOORDATE.SetDisabled(bReadOnly2);

            txtWOPONUM1.SetDisabled(bReadOnly);
            txtWOPONUM2.SetDisabled(bReadOnly);
            txtWOPONUM3.SetDisabled(bReadOnly);
            txtWOPONUM4.SetDisabled(bReadOnly);
            txtWOPONUM5.SetDisabled(bReadOnly);
            txtWOWORKTITLE.SetDisabled(bReadOnly);
            txtWOLOCATIONCODE1.SetDisabled(bReadOnly);
            txtWOLOCATIONCODE2.SetDisabled(bReadOnly);
            txtWOLOCATIONCODE3.SetDisabled(bReadOnly);
            txtWOLOCATIONCODE4.SetDisabled(bReadOnly);
            txtWOLOCATIONCODE5.SetDisabled(bReadOnly);
            txtWOAREACODE1.SetDisabled(bReadOnly);
            txtWOAREACODE2.SetDisabled(bReadOnly);
            txtWOAREACODE3.SetDisabled(bReadOnly);
            txtWOAREACODE4.SetDisabled(bReadOnly);
            txtWOAREACODE5.SetDisabled(bReadOnly);
            txtWODSDATE1.SetDisabled(bReadOnly);
            txtWODSDATE2.SetDisabled(bReadOnly);

            cboWOCHANGEWKJOB.SetDisabled(bReadOnly);
            cboWOCHANGEWKDIV.SetDisabled(bReadOnly1);
        }

        function fn_GET_Site() {

            var iSO_COUNT = 0;
            var iRE_COUNT = 0;

            // 요청 결재자
            fn_Btn_Visible('0');

            if (txtWOAPPSOSABUN5.GetValue() != "") {
                iSO_COUNT = 5;
            }
            else if (txtWOAPPSOSABUN4.GetValue() != "") {
                iSO_COUNT = 4;
            }
            else if (txtWOAPPSOSABUN3.GetValue() != "") {
                iSO_COUNT = 3;
            }
            else if (txtWOAPPSOSABUN2.GetValue() != "") {
                iSO_COUNT = 2;
            }
            else if (txtWOAPPSOSABUN1.GetValue() != "") {
                iSO_COUNT = 1;
            }

            fshdnSOApproval = "0";

            if (txtWOAPPSODATE1.GetValue() != "") {

                fn_Get_Image('S1');

                fshdnSOApproval = "1";
            }

            if (txtWOAPPSODATE2.GetValue() != "") {
                fn_Get_Image('S2');

                fshdnSOApproval = "2";
            }

            if (txtWOAPPSODATE3.GetValue() != "") {
                fn_Get_Image('S3');

                fshdnSOApproval = "3";
            }

            if (txtWOAPPSODATE4.GetValue() != "") {
                fn_Get_Image('S4');

                fshdnSOApproval = "4";
            }

            if (txtWOAPPSODATE5.GetValue() != "") {
                fn_Get_Image('S5');

                fshdnSOApproval = "5";
            }

            // 수신 결재자
            if (txtWOAPPRESABUN5.GetValue() != "") {
                iRE_COUNT = 5;
            }
            else if (txtWOAPPRESABUN4.GetValue() != "") {
                iRE_COUNT = 4;
            }
            else if (txtWOAPPRESABUN3.GetValue() != "") {
                iRE_COUNT = 3;
            }
            else if (txtWOAPPRESABUN2.GetValue() != "") {
                iRE_COUNT = 2;
            }
            else if (txtWOAPPRESABUN1.GetValue() != "") {
                iRE_COUNT = 1;
            }

            fshdnREApproval = "0";

            if (txtWOAPPREDATE1.GetValue() != "") {
                fn_Get_Image('R1');

                fshdnREApproval = "1";
            }

            if (txtWOAPPREDATE2.GetValue() != "") {
                fn_Get_Image('R2');

                fshdnREApproval = "2";
            }

            if (txtWOAPPREDATE3.GetValue() != "") {
                fn_Get_Image('R3');

                fshdnREApproval = "3";
            }

            if (txtWOAPPREDATE4.GetValue() != "") {
                fn_Get_Image('R4');

                fshdnREApproval = "4";
            }

            if (txtWOAPPREDATE5.GetValue() != "") {
                fn_Get_Image('R5');

                fshdnREApproval = "5";
            }

            fshdnSOSign = "";
            
            fn_Get_Approval_Line(iSO_COUNT,                   fshdnSOApproval,
                                 txtWOAPPSOSABUN1.GetValue(), txtWOAPPSODATE1.GetValue(),
                                 txtWOAPPSOSABUN2.GetValue(), txtWOAPPSODATE2.GetValue(),
                                 txtWOAPPSOSABUN3.GetValue(), txtWOAPPSODATE3.GetValue(),
                                 txtWOAPPSOSABUN4.GetValue(), txtWOAPPSODATE4.GetValue(),
                                 txtWOAPPSOSABUN5.GetValue(), txtWOAPPSODATE5.GetValue(),
                                 iRE_COUNT,                   fshdnREApproval,
                                 txtWOAPPRESABUN1.GetValue(), txtWOAPPREDATE1.GetValue(),
                                 txtWOAPPRESABUN2.GetValue(), txtWOAPPREDATE2.GetValue(),
                                 txtWOAPPRESABUN3.GetValue(), txtWOAPPREDATE3.GetValue(),
                                 txtWOAPPRESABUN4.GetValue(), txtWOAPPREDATE4.GetValue(),
                                 txtWOAPPRESABUN5.GetValue(), txtWOAPPREDATE5.GetValue());
        }

        function fn_Get_Approval_Line(iSO_Cnt,   sSO_Cnt,
                                      sSOSABUN1, sSODATE1,
                                      sSOSABUN2, sSODATE2,
                                      sSOSABUN3, sSODATE3,
                                      sSOSABUN4, sSODATE4,
                                      sSOSABUN5, sSODATE5,
                                      iRE_Cnt,   sRE_Cnt,
                                      sRESABUN1, sREDATE1,
                                      sRESABUN2, sREDATE2,
                                      sRESABUN3, sREDATE3,
                                      sRESABUN4, sREDATE4,
                                      sRESABUN5, sREDATE5) {
            var sExists         = "";
            var sSO_BUSEO       = ""; // 첫 요청자 부서코드
            var sRE_BUSEO       = ""; // 첫 수신자 부서코드
            var sLOGIN_BUSEO    = ""; // 로그인 부서코드

            var sNOWAPP_SOSABUN = ""; // 현재 요청 결재할 사람
            var sNOWAPP_RESABUN = ""; // 현재 요청 결재할 사람

            var today = new Date();
            var date = "";

            var ht  = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            // 현재 요청 결재할 사람
            if (sSOSABUN1.toString() != "" && sSODATE1.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN1.toString();
            }
            else if (sSOSABUN2.toString() != "" && sSODATE2.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN2.toString();
            }
            else if (sSOSABUN3.toString() != "" && sSODATE3.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN3.toString();
            }
            else if (sSOSABUN4.toString() != "" && sSODATE4.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN4.toString();
            }
            else if (sSOSABUN5.toString() != "" && sSODATE5.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN5.toString();
            }

            // 현재 요청 결재할 사람
            if (sRESABUN1.toString() != "" && sREDATE1.toString() == "") {
                sNOWAPP_RESABUN = sRESABUN1.toString();
            }
            else if (sRESABUN2.toString() != "" && sREDATE2.toString() == "") {
                sNOWAPP_RESABUN = sRESABUN2.toString();
            }
            else if (sRESABUN3.toString() != "" && sREDATE3.toString() == "") {
                sNOWAPP_RESABUN = sRESABUN3.toString();
            }
            else if (sRESABUN4.toString() != "" && sREDATE4.toString() == "") {
                sNOWAPP_RESABUN = sRESABUN4.toString();
            }
            else if (sRESABUN5.toString() != "" && sREDATE5.toString() == "") {
                sNOWAPP_RESABUN = sRESABUN5.toString();
            }

            ht1["P_DATE"] = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());

            ht1["P_KBSABUN"] = fshdnLoginSabun;

            // 로그인 부서코드
            sLOGIN_BUSEO = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode%>";

            //// 로그인 부서코드
            //PageMethods.InvokeServiceTable(ht1, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

            //    var DataSet1 = eval(e);

            //    if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

            //        // 로그인 부서코드
            //        sLOGIN_BUSEO = DataSet1.Tables[0].Rows[0]["KBBUSEO"];
            //    }
            //}, function (e) {
            //    // Biz 연결오류
            //    alert('<Ctl:Text runat="server" Description="로딩중 로그인 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            //});

            if (Get_Numeric(sSO_Cnt) == "0") {
                if (sSOSABUN1 == fshdnLoginSabun) {

                    fn_Btn_Visible('0');
                }
                else {
                    if (sSO_BUSEO == sLOGIN_BUSEO) {

                        fn_Btn_Visible('0');
                    }
                    else {

                        fn_Btn_Visible('3');
                    }
                }
            }
            else {
                date = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());

                ht["P_DATE"] = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());

                // 현재 요청 결재할 사람의 부서코드
                if (sSOSABUN1.toString() != "") {

                    ht["P_KBSABUN"] = sNOWAPP_SOSABUN.toString();

                    PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                            // 첫 요청자 부서코드
                            sSO_BUSEO = DataSet.Tables[0].Rows[0]["KBBUSEO"];


                            // 요청 결재자
                            for (var i = parseInt(Get_Numeric(sSO_Cnt)); i <= iSO_Cnt; i++) {
                                if (i == iSO_Cnt) {
                                    if (parseInt(Get_Numeric(sRE_Cnt)) + 1 != iRE_Cnt) {
                                        if (sRESABUN1 == fshdnLoginSabun) {
                                            if (sREDATE1 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }

                                            sExists = "EXISTS";
                                            break;
                                        }
                                        else {
                                            if (i == 1) {
                                                if (sSOSABUN1 == fshdnLoginSabun) {
                                                    if (sSODATE1 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                                else {
                                                    if (sSODATE1 == "") {
                                                        if (sSO_BUSEO == sLOGIN_BUSEO) {

                                                            fn_Btn_Visible('6');
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                            }
                                            else if (i == 2) {
                                                if (sSOSABUN2 == fshdnLoginSabun) {
                                                    if (sSODATE2 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                                else {
                                                    if (sSODATE2 == "") {
                                                        if (sSO_BUSEO == sLOGIN_BUSEO) {
                                                            if (sSOSABUN1 == fshdnLoginSabun) {
                                                                fn_Btn_Visible('70');
                                                            }
                                                            else {
                                                                fn_Btn_Visible('6');
                                                            }
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                            }
                                            else if (i == 3) {
                                                if (sSOSABUN3 == fshdnLoginSabun) {
                                                    if (sSODATE3 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                                else {
                                                    if (sSODATE3 == "") {
                                                        if (sSO_BUSEO == sLOGIN_BUSEO) {
                                                            if (sSOSABUN1 == fshdnLoginSabun) {
                                                                fn_Btn_Visible('70');
                                                            }
                                                            else {
                                                                fn_Btn_Visible('6');
                                                            }
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                            }
                                            else if (i == 4) {
                                                if (sSOSABUN4 == fshdnLoginSabun) {
                                                    if (sSODATE4 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                                else {
                                                    if (sSODATE4 == "") {
                                                        if (sSO_BUSEO == sLOGIN_BUSEO) {
                                                            if (sSOSABUN1 == fshdnLoginSabun) {
                                                                fn_Btn_Visible('70');
                                                            }
                                                            else {
                                                                fn_Btn_Visible('6');
                                                            }
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                            }
                                            else if (i == 5) {
                                                if (sSOSABUN5 == fshdnLoginSabun) {
                                                    if (sSODATE5 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                                else {
                                                    if (sSODATE5 == "") {
                                                        if (sSO_BUSEO == sLOGIN_BUSEO) {
                                                            if (sSOSABUN1 == fshdnLoginSabun) {
                                                                fn_Btn_Visible('70');
                                                            }
                                                            else {
                                                                fn_Btn_Visible('6');
                                                            }
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                    if ((i + 1) == 1) {
                                        if (sSOSABUN1 == fshdnLoginSabun) {
                                            if (sSODATE1 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }
                                        else {
                                            if (sSODATE1 == "") {
                                                if (sSO_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSOSABUN1 == fshdnLoginSabun) {
                                                        fn_Btn_Visible('70');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('6');
                                                    }
                                                }
                                                else {
                                                    fn_Btn_Visible('3');
                                                }
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }

                                        sExists = "EXISTS";
                                        break;
                                    }
                                    else if ((i + 1) == 2) {
                                        if (sSOSABUN2 == fshdnLoginSabun) {
                                            if (sSODATE2 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }
                                        else {
                                            if (sSODATE2 == "") {
                                                if (sSO_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSOSABUN1 == fshdnLoginSabun) {
                                                        fn_Btn_Visible('70');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('6');
                                                    }
                                                }
                                                else {
                                                    fn_Btn_Visible('3');
                                                }
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }

                                        sExists = "EXISTS";
                                        break;
                                    }
                                    else if ((i + 1) == 3) {
                                        if (sSOSABUN3 == fshdnLoginSabun) {
                                            if (sSODATE3 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }
                                        else {
                                            if (sSODATE3 == "") {
                                                if (sSO_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSOSABUN1 == fshdnLoginSabun) {
                                                        fn_Btn_Visible('70');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('6');
                                                    }
                                                }
                                                else {
                                                    fn_Btn_Visible('3');
                                                }
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }

                                        sExists = "EXISTS";
                                        break;
                                    }
                                    else if ((i + 1) == 4) {
                                        if (sSOSABUN4 == fshdnLoginSabun) {
                                            if (sSODATE4 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }
                                        else {
                                            if (sSODATE4 == "") {
                                                if (sSO_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSOSABUN1 == fshdnLoginSabun) {
                                                        fn_Btn_Visible('70');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('6');
                                                    }
                                                }
                                                else {
                                                    fn_Btn_Visible('3');
                                                }
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }

                                        sExists = "EXISTS";
                                        break;
                                    }
                                    else {
                                        fn_Btn_Visible('1');

                                        sExists = "EXISTS";
                                        break;
                                    }
                                }
                            }
                        }

                    }, function (e) {
                        // Biz 연결오류
                        alert('<Ctl:Text runat="server" Description="로딩중 첫요청자 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    });
                }


                // 수신 결재자
                if (iSO_Cnt == parseInt(Get_Numeric(sSO_Cnt))) {
                    fshdnSOSign = "Complete";

                    if ((parseInt(Get_Numeric(sRE_Cnt)) == 0) && (sRESABUN1 == fshdnLoginSabun)) {
                        fn_Btn_Visible('5');

                        sExists = "EXISTS";
                    }
                    else {

                        // 현재 수신 결재할 사람의 부서코드
                        if (sRESABUN1.toString() != "") {

                            ht["P_KBSABUN"] = sNOWAPP_RESABUN.toString();

                            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                                var DataSet = eval(e);

                                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                                    // 첫 수신자 부서코드
                                    sRE_BUSEO = DataSet.Tables[0].Rows[0]["KBBUSEO"];


                                    for (var i = parseInt(Get_Numeric(sRE_Cnt)); i <= iRE_Cnt; i++) {
                                        if (parseInt(Get_Numeric(sRE_Cnt)) + 1 == iRE_Cnt) {
                                            if (i == 0) {
                                                if (sRESABUN1 == fshdnLoginSabun) {
                                                    if (sREDATE1 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                                else {
                                                    if (sREDATE1 == "") {
                                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                                                            fn_Btn_Visible('6');
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                            }
                                            else if (i == 1) {
                                                if (sRESABUN2 == fshdnLoginSabun) {
                                                    if (sREDATE2 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                                else {
                                                    if (sREDATE2 == "") {
                                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                                                            fn_Btn_Visible('6');
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                            }
                                            else if (i == 2) {
                                                if (sRESABUN3 == fshdnLoginSabun) {
                                                    if (sREDATE3 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                                else {
                                                    if (sREDATE3 == "") {
                                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                                                            fn_Btn_Visible('6');
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                            }
                                            else if (i == 3) {
                                                if (sRESABUN4 == fshdnLoginSabun) {
                                                    if (sREDATE4 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                                else {
                                                    if (sREDATE4 == "") {
                                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                                                            fn_Btn_Visible('6');
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                            }
                                            else if (i == 4) {
                                                if (sRESABUN5 == fshdnLoginSabun) {
                                                    if (sREDATE5 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                                else {
                                                    if (sREDATE5 == "") {
                                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                                                            fn_Btn_Visible('6');
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }

                                                    sExists = "EXISTS";
                                                    break;
                                                }
                                            }
                                        }
                                        else {
                                            if (i == 4) {
                                                if (sRESABUN5 == fshdnLoginSabun) {
                                                    if (sREDATE5 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }
                                                }
                                                else {
                                                    if (sREDATE5 == "") {
                                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                                                            fn_Btn_Visible('6');
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }
                                                }

                                                sExists = "EXISTS";
                                                break;
                                            }
                                            else if (i == 3) {
                                                if (sRESABUN4 == fshdnLoginSabun) {
                                                    if (sREDATE4 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }
                                                }
                                                else {
                                                    if (sREDATE4 == "") {
                                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                                                            fn_Btn_Visible('6');
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }
                                                }

                                                sExists = "EXISTS";
                                                break;
                                            }
                                            else if (i == 2) {
                                                if (sRESABUN3 == fshdnLoginSabun) {
                                                    if (sREDATE3 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }
                                                }
                                                else {
                                                    if (sREDATE3 == "") {
                                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                                                            fn_Btn_Visible('6');
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }
                                                }

                                                sExists = "EXISTS";
                                                break;
                                            }
                                            else if (i == 1) {
                                                if (sRESABUN2 == fshdnLoginSabun) {
                                                    if (sREDATE2 == "") {
                                                        fn_Btn_Visible('1');
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }
                                                }
                                                else {
                                                    if (sREDATE2 == "") {
                                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                                                            fn_Btn_Visible('6');
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }
                                                }

                                                sExists = "EXISTS";
                                                break;
                                            }
                                            else {
                                                if (sRESABUN1 == fshdnLoginSabun) {
                                                    if (sREDATE1 == "") {
                                                        UP_Btn_Show(2);
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }
                                                }
                                                else {
                                                    if (sREDATE1 == "") {
                                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                                                            fn_Btn_Visible('6');
                                                        }
                                                        else {
                                                            fn_Btn_Visible('3');
                                                        }
                                                    }
                                                    else {
                                                        fn_Btn_Visible('3');
                                                    }
                                                }

                                                sExists = "EXISTS";
                                                break;
                                            }
                                        }
                                    }

                                }
                            }, function (e) {
                                // Biz 연결오류
                                alert('<Ctl:Text runat="server" Description="로딩중 첫 수신자 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                            });
                        }
                    }
                }

                // 수신결재자 Complete
                if (iRE_Cnt == parseInt(Get_Numeric(sRE_Cnt))) {
                    fshdnRESign = "Complete";
                }

                if (sExists == "") {
                    fn_Btn_Visible('3');
                }

                // 요청 결재 진행중
                if (iSO_Cnt != parseInt(Get_Numeric(sSO_Cnt))) {
                    if (Get_Numeric(sSO_Cnt) != "0") {
                        if (sSOSABUN1.toString() == fshdnLoginSabun) {
                            fn_Btn_Visible('50');
                        }
                    }
                }
            }
        }

        function fn_Btn_Visible(gubun) {

            $("#btnRETRACT").hide();

            if (gubun == '0') {
                $("#btnSOApproval").show();
                $("#btnApproval").show();
                $("#btnSave").show();
                $("#btnDel").show();

                $("#btnPrt").hide();
                $("#btnCancel").hide();

                $("#btnWOGRURL1").show();
                $("#btnWOGRURL2").show();
            }
            else {
                $("#btnDel").hide();
                $("#btnSave").hide();
                $("#tsPrt").show();

                $("#btnWOGRURL1").hide();
                $("#btnWOGRURL2").hide();
            }

            if (gubun == '1') {
                $("#btnCancel").show();
                $("#btnApproval").show();
                $("#btnSOApproval").show();
            }

            if (gubun == '3') {
                $("#btnSOApproval").hide();
                $("#btnApproval").hide();
                $("#btnSave").hide();
                $("#btnDel").hide();
                $("#btnPrt").show();
                $("#btnCancel").hide();

                $("#btnWOGRURL1").hide();
                $("#btnWOGRURL2").hide();
            }

            if (gubun == '5') {
                $("#btnCancel").show();
                $("#btnSOApproval").show();
            }

            if (gubun == '6') {
                $("#btnCancel").hide();
                $("#btnApproval").hide();
                $("#btnSOApproval").show();
            }

            if (gubun == '30') {
                $("#btnSOApproval").hide();
            }

            if (gubun == '50') {
                $("#btnRETRACT").show();
            }

            if (gubun == '70') {
                $("#btnSOApproval").show();
                $("#btnApproval").show();
                $("#btnRETRACT").show();
            }
        }

        function fn_Get_Image(gubun) {

            var Num = "";
            var data = "";
            var control = "";

            if (gubun.substr(0, 1) == 'S') {

                Num = document.getElementById("conBody_ImgWOAPPSOPHOTO" + gubun.substr(1, 1)).src;

                data = Num.split('&');

                control = $("#txtWOAPPSOSABUN" + gubun.substr(1, 1)).val();

                Img_Read(gubun, control, data[1]);

                fshdnSOApproval = gubun.substr(1, 1);
            }
            else {
                Num = document.getElementById("conBody_ImgWOAPPREPHOTO" + gubun.substr(1, 1)).src;

                data = Num.split('&');

                control = $("#txtWOAPPRESABUN" + gubun.substr(1, 1)).val();

                Img_Read(gubun, control, data[1]);

                fshdnREApproval = gubun.substr(1, 1);
            }
        }




        function fn_SET_Buseo() {

            var DataSet;
            var DataSet1;

            var ht  = new Object();
            var ht1 = new Object();

            var today = new Date();

            ht["P_DATE"] = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());
            ht["P_KBSABUN"] = fshdnLoginSabun

            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    // 요청자
                    txtWOORSABUN.SetValue("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>");
                    pnlWOORSABUN.SetValue(DataSet.Tables[0].Rows[0]["KBHANGL"]);
                    // 요청팀
                    txtWOSOTEAM.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEO"]);
                    pnlWOSOTEAM.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEONM"]);

                    // 요청자1
                    txtWOAPPSOSABUN1.SetValue("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>");
                    txtWOAPPSONAME1.SetValue(DataSet.Tables[0].Rows[0]["KBHANGL"]);
                    txtWOAPPSOJKCD1.SetValue(DataSet.Tables[0].Rows[0]["KBJKCD"]);
                    txtWOAPPSOJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["CDDESC1"]);

                    // 요청부서
                    txtWOORTEAM.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEO"]);
                }

                

                ht1["P_BUSEO1"] = "ALL";
                ht1["P_BUSEO2"] = "ALL";
                ht1["P_BUSEO3"] = "ALL";
                ht1["P_BUSEO4"] = "ALL";
                ht1["P_BUSEO5"] = "ALL";
                ht1["P_BUSEO6"] = "ALL";
                ht1["P_BUSEO7"] = "ALL";
                ht1["P_BUSEO8"] = "ALL";
                ht1["P_SABUN"]  = fshdnLoginSabun

                PageMethods.InvokeServiceTable(ht1, "PSM.PSMBiz", "UP_ORG_GETDATA", function (e) {

                    DataSet1 = eval(e);

                    if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {
                        txtWOAPPSOJKCD1.SetValue(DataSet1.Tables[0].Rows[0]["JCCD"]);
                        txtWOAPPSOJKCDNM1.SetValue(DataSet1.Tables[0].Rows[0]["JKDESC"]);
                    }
                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="로딩중 직급 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="로딩중 사번 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

        // 데이터 바인딩
        function fn_GET_Display() {

            var sDate = "";
            var sTime = "";

            fshdnSOApproval = "0";
            fshdnREApproval = "0";

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_WOORTEAM"] = txtWOORTEAM.GetValue();
            ht["P_WOORDATE"] = Get_Date(txtWOORDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"] = Set_Fill3(txtWOSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_WORKORDER_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    // 첨부파일 로드
                    AttachFileLod();

                    /* 요청승인자 */
                    txtWOAPPSOSABUN1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOSABUN1"]);
                    txtWOAPPSOJKCD1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCD1"]);

                    txtWOAPPSOJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCDNM1"]);
                    txtWOAPPSONAME1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSONAME1"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPSODATE1"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPSODATE1"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPSOTIME1"];

                        txtWOAPPSODATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPSOTIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S1', DataSet.Tables[0].Rows[0]["WOAPPSOSABUN1"], DataSet.Tables[0].Rows[0]["SOIMGNAME1"])

                        fshdnSOApproval = "1";
                    }
                    else {
                        txtWOAPPSODATE1.SetValue("");
                        txtWOAPPSOTIME1.SetValue("");
                    }

                    txtWOAPPSOSABUN2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOSABUN2"]);
                    txtWOAPPSOJKCD2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCD2"]);

                    txtWOAPPSOJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCDNM2"]);
                    txtWOAPPSONAME2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSONAME2"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPSODATE2"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPSODATE2"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPSOTIME2"];

                        txtWOAPPSODATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPSOTIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S2', DataSet.Tables[0].Rows[0]["WOAPPSOSABUN2"], DataSet.Tables[0].Rows[0]["SOIMGNAME2"])

                        fshdnSOApproval = "2";
                    }
                    else {
                        txtWOAPPSODATE2.SetValue("");
                        txtWOAPPSOTIME2.SetValue("");
                    }

                    txtWOAPPSOSABUN3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOSABUN3"]);
                    txtWOAPPSOJKCD3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCD3"]);

                    txtWOAPPSOJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCDNM3"]);
                    txtWOAPPSONAME3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSONAME3"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPSODATE3"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPSODATE3"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPSOTIME3"];

                        txtWOAPPSODATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPSOTIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S3', DataSet.Tables[0].Rows[0]["WOAPPSOSABUN3"], DataSet.Tables[0].Rows[0]["SOIMGNAME3"])

                        fshdnSOApproval = "3";
                    }
                    else {
                        txtWOAPPSODATE3.SetValue("");
                        txtWOAPPSOTIME3.SetValue("");
                    }

                    txtWOAPPSOSABUN4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOSABUN4"]);
                    txtWOAPPSOJKCD4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCD4"]);

                    txtWOAPPSOJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCDNM4"]);
                    txtWOAPPSONAME4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSONAME4"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPSODATE4"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPSODATE4"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPSOTIME4"];

                        txtWOAPPSODATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPSOTIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S4', DataSet.Tables[0].Rows[0]["WOAPPSOSABUN4"], DataSet.Tables[0].Rows[0]["SOIMGNAME4"])

                        fshdnSOApproval = "4";
                    }
                    else {
                        txtWOAPPSODATE4.SetValue("");
                        txtWOAPPSOTIME4.SetValue("");
                    }

                    txtWOAPPSOSABUN5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOSABUN5"]);
                    txtWOAPPSOJKCD5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCD5"]);

                    txtWOAPPSOJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCDNM5"]);
                    txtWOAPPSONAME5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSONAME5"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPSODATE5"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPSODATE5"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPSOTIME5"];

                        txtWOAPPSODATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPSOTIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S5', DataSet.Tables[0].Rows[0]["WOAPPSOSABUN5"], DataSet.Tables[0].Rows[0]["SOIMGNAME5"])

                        fshdnSOApproval = "5";
                    }
                    else {
                        txtWOAPPSODATE5.SetValue("");
                        txtWOAPPSOTIME5.SetValue("");
                    }

                    /* 수신승인자 */
                    txtWOAPPRESABUN1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRESABUN1"]);
                    txtWOAPPREJKCD1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCD1"]);

                    txtWOAPPREJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCDNM1"]);
                    txtWOAPPRENAME1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRENAME1"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPREDATE1"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPREDATE1"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPRETIME1"];

                        txtWOAPPREDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPRETIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R1', DataSet.Tables[0].Rows[0]["WOAPPRESABUN1"], DataSet.Tables[0].Rows[0]["REIMGNAME1"])

                        // 현재 수신결재순번
                        fshdnREApproval = "1";
                    }
                    else {
                        txtWOAPPREDATE1.SetValue("");
                        txtWOAPPRETIME1.SetValue("");
                    }

                    txtWOAPPRESABUN2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRESABUN2"]);
                    txtWOAPPREJKCD2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCD2"]);

                    txtWOAPPREJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCDNM2"]);
                    txtWOAPPRENAME2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRENAME2"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPREDATE2"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPREDATE2"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPRETIME2"];

                        txtWOAPPREDATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPRETIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R2', DataSet.Tables[0].Rows[0]["WOAPPRESABUN2"], DataSet.Tables[0].Rows[0]["REIMGNAME2"])

                        // 현재 수신결재순번
                        fshdnREApproval = "2";
                    }
                    else {
                        txtWOAPPREDATE2.SetValue("");
                        txtWOAPPRETIME2.SetValue("");
                    }

                    txtWOAPPRESABUN3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRESABUN3"]);
                    txtWOAPPREJKCD3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCD3"]);

                    txtWOAPPREJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCDNM3"]);
                    txtWOAPPRENAME3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRENAME3"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPREDATE3"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPREDATE3"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPRETIME3"];

                        txtWOAPPREDATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPRETIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R3', DataSet.Tables[0].Rows[0]["WOAPPRESABUN3"], DataSet.Tables[0].Rows[0]["REIMGNAME3"])

                        // 현재 수신결재순번
                        fshdnREApproval = "3";
                    }
                    else {
                        txtWOAPPREDATE3.SetValue("");
                        txtWOAPPRETIME3.SetValue("");
                    }

                    txtWOAPPRESABUN4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRESABUN4"]);
                    txtWOAPPREJKCD4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCD4"]);

                    txtWOAPPREJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCDNM4"]);
                    txtWOAPPRENAME4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRENAME4"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPREDATE4"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPREDATE4"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPRETIME4"];

                        txtWOAPPREDATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPRETIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R4', DataSet.Tables[0].Rows[0]["WOAPPRESABUN4"], DataSet.Tables[0].Rows[0]["REIMGNAME4"])

                        // 현재 수신결재순번
                        fshdnREApproval = "4";
                    }
                    else {
                        txtWOAPPREDATE4.SetValue("");
                        txtWOAPPRETIME4.SetValue("");
                    }

                    txtWOAPPRESABUN5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRESABUN5"]);
                    txtWOAPPREJKCD5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCD5"]);

                    txtWOAPPREJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCDNM5"]);
                    txtWOAPPRENAME5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRENAME5"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPREDATE5"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPREDATE5"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPRETIME5"];

                        txtWOAPPREDATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPRETIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R5', DataSet.Tables[0].Rows[0]["WOAPPRESABUN5"], DataSet.Tables[0].Rows[0]["REIMGNAME5"])

                        // 현재 수신결재순번
                        fshdnREApproval = "5";
                    }
                    else {
                        txtWOAPPREDATE5.SetValue("");
                        txtWOAPPRETIME5.SetValue("");
                    }

                    /* 의견 */
                    txtWOAPPSOCOMMENT1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOCOMMENT1"]);
                    txtWOAPPSOCOMMENT2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOCOMMENT2"]);
                    txtWOAPPSOCOMMENT3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOCOMMENT3"]);
                    txtWOAPPSOCOMMENT4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOCOMMENT4"]);
                    txtWOAPPSOCOMMENT5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOCOMMENT5"]);

                    txtWOAPPRECOMMENT1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRECOMMENT1"]);
                    txtWOAPPRECOMMENT2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRECOMMENT2"]);
                    txtWOAPPRECOMMENT3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRECOMMENT3"]);
                    txtWOAPPRECOMMENT4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRECOMMENT4"]);
                    txtWOAPPRECOMMENT5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRECOMMENT5"]);

                    // 요청자
                    txtWOORSABUN.SetValue(DataSet.Tables[0].Rows[0]["WOORSABUN"]);
                    if (txtWOORSABUN.GetValue() != "") {
                        pnlWOORSABUN.SetValue(DataSet.Tables[0].Rows[0]["WOORSABUNNM"]);
                    }
                    // 요청팀
                    txtWOSOTEAM.SetValue(DataSet.Tables[0].Rows[0]["WOSOTEAM"]);
                    pnlWOSOTEAM.SetValue(DataSet.Tables[0].Rows[0]["WOSOTEAMNM"]);
                    // 수신팀
                    txtWORETEAM.SetValue(DataSet.Tables[0].Rows[0]["WORETEAM"]);
                    pnlWORETEAM.SetValue(DataSet.Tables[0].Rows[0]["WORETEAMNM"]);

                    // 작업일자
                    if (DataSet.Tables[0].Rows[0]["WODSDATE1"] != "") {
                        sDate = DataSet.Tables[0].Rows[0]["WODSDATE1"];
                        txtWODSDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                    }
                    else {
                        txtWODSDATE1.SetValue("");
                    }

                    if (DataSet.Tables[0].Rows[0]["WODSDATE2"] != "") {
                        txtWODSDATE2.SetValue(DataSet.Tables[0].Rows[0]["WODSDATE2"].substr(0, 4) + DataSet.Tables[0].Rows[0]["WODSDATE2"].substr(4, 2) + DataSet.Tables[0].Rows[0]["WODSDATE2"].substr(6, 2));
                    }
                    else {
                        txtWODSDATE2.SetValue("");
                    }


                    // 설비코드
                    txtWOLOCATIONCODE1.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE1"]);
                    if (txtWOLOCATIONCODE1.GetValue() != "") {
                        pnlWOLOCATIONCODE1.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE1NM"]);
                    }

                    txtWOLOCATIONCODE2.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE2"]);
                    if (txtWOLOCATIONCODE2.GetValue() != "") {
                        pnlWOLOCATIONCODE2.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE2NM"]);
                    }

                    txtWOLOCATIONCODE3.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE3"]);
                    if (txtWOLOCATIONCODE3.GetValue() != "") {
                        pnlWOLOCATIONCODE3.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE3NM"]);
                    }

                    txtWOLOCATIONCODE4.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE4"]);
                    if (txtWOLOCATIONCODE4.GetValue() != "") {
                        pnlWOLOCATIONCODE4.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE4NM"]);
                    }

                    txtWOLOCATIONCODE5.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE5"]);
                    if (txtWOLOCATIONCODE5.GetValue() != "") {
                        pnlWOLOCATIONCODE5.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE5NM"]);
                    }


                    // 작업구역
                    txtWOAREACODE1.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE1"]);
                    if (txtWOAREACODE1.GetValue() != "") {
                        pnlWOAREACODE1.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE1NM"]);
                    }

                    txtWOAREACODE2.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE2"]);
                    if (txtWOAREACODE2.GetValue() != "") {
                        pnlWOAREACODE2.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE2NM"]);
                    }

                    txtWOAREACODE3.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE3"]);
                    if (txtWOAREACODE3.GetValue() != "") {
                        pnlWOAREACODE3.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE3NM"]);
                    }

                    txtWOAREACODE4.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE4"]);
                    if (txtWOAREACODE4.GetValue() != "") {
                        pnlWOAREACODE4.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE4NM"]);
                    }

                    txtWOAREACODE5.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE5"]);
                    if (txtWOAREACODE5.GetValue() != "") {
                        pnlWOAREACODE5.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE5NM"]);
                    }

                    // 작업명
                    txtWOWORKTITLE.SetValue(DataSet.Tables[0].Rows[0]["WOWORKTITLE"]);

                    // 작업내용
                    txtWOWORKDOC.SetValue(DataSet.Tables[0].Rows[0]["WOWORKDOC"]);

                    // 완료일자
                    if (DataSet.Tables[0].Rows[0]["WOFINISHDATE"] != "") {
                        txtWOFINISHDATE.SetValue(DataSet.Tables[0].Rows[0]["WOFINISHDATE"].substr(0, 4) + "-" + DataSet.Tables[0].Rows[0]["WOFINISHDATE"].substr(4, 2) + "-" + DataSet.Tables[0].Rows[0]["WOFINISHDATE"].substr(6, 2));
                    }
                    else {
                        txtWOFINISHDATE.SetValue("");
                    }

                    // 승인자
                    $("#svWOFINISHSABUN_KBSABUN").val(DataSet.Tables[0].Rows[0]["WOFINISHSABUN"]);
                    $("#svWOFINISHSABUN_KBHANGL").val(DataSet.Tables[0].Rows[0]["WOFINISHSABUNNM"]);
                    //txtWOFINISHSABUN.SetValue(DataSet.Tables[0].Rows[0]["WOFINISHSABUN"]);
                    //if (txtWOFINISHSABUN.GetValue() != "") {
                    //    pnlWOFINISHSABUN.SetValue(DataSet.Tables[0].Rows[0]["WOFINISHSABUNNM"]);
                    //}

                    // 의견
                    txtWOFINISHTEXT.SetValue(DataSet.Tables[0].Rows[0]["WOFINISHTEXT"]);

                    // 조치 확인 완료일자
                    if (DataSet.Tables[0].Rows[0]["WOIMMEDDATE"] != "") {
                        txtWOIMMEDDATE.SetValue(DataSet.Tables[0].Rows[0]["WOIMMEDDATE"].substr(0, 4) + "-" + DataSet.Tables[0].Rows[0]["WOIMMEDDATE"].substr(4, 2) + "-" + DataSet.Tables[0].Rows[0]["WOIMMEDDATE"].substr(6, 2));
                    }
                    else {
                        txtWOIMMEDDATE.SetValue("");
                    }

                    // 확인자
                    $("#svWOIMMEDSABUN_KBSABUN").val(DataSet.Tables[0].Rows[0]["WOIMMEDSABUN"]);
                    $("#svWOIMMEDSABUN_KBHANGL").val(DataSet.Tables[0].Rows[0]["WOIMMEDSABUNNM"]);

                    //txtWOIMMEDSABUN.SetValue(DataSet.Tables[0].Rows[0]["WOIMMEDSABUN"]);
                    //if (txtWOIMMEDSABUN.GetValue() != "") {
                    //    pnlWOIMMEDSABUN.SetValue(DataSet.Tables[0].Rows[0]["WOIMMEDSABUNNM"]);
                    //}

                    // 조치내용
                    txtWOIMMEDTEXT.SetValue(DataSet.Tables[0].Rows[0]["WOIMMEDTEXT"]);

                    // 작업내용
                    this.cboWOCHANGEWKJOB.SetValue(DataSet.Tables[0].Rows[0]["WOCHANGEWKJOB"]);
                    // 작업구분
                    this.cboWOCHANGEWKDIV.SetValue(DataSet.Tables[0].Rows[0]["WOCHANGEWKDIV"]);

                    // 허가서 발행일자
                    txtSMWKORAPPDATE.SetValue(DataSet.Tables[0].Rows[0]["SMWKORAPPDATE"]);

                    // 취소자
                    txtWOCANCELSABUN1.SetValue(DataSet.Tables[0].Rows[0]["WOCANCELSABUN1"]);
                    if (txtWOCANCELSABUN1.GetValue() != "") {
                        pnlWOCANCELSABUN1.SetValue(DataSet.Tables[0].Rows[0]["WOCANCELSABUN1NM"]);
                    }

                    if (DataSet.Tables[0].Rows[0]["WOCANCELDATE1"] != "") {
                        sDate = DataSet.Tables[0].Rows[0]["WOCANCELDATE1"];
                        sTime = DataSet.Tables[0].Rows[0]["WOCANCELTIME1"];

                        txtWOCANCELDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOCANCELTIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));
                    }
                    else
                    {
                        txtWOCANCELDATE1.SetValue("");
                        txtWOCANCELTIME1.SetValue("");
                    }

                    txtWOCANCELCOMMENT1.SetValue(DataSet.Tables[0].Rows[0]["WOCANCELCOMMENT1"]);

                    txtWOCANCELSABUN2.SetValue(DataSet.Tables[0].Rows[0]["WOCANCELSABUN2"]);
                    if (txtWOCANCELSABUN2.GetValue() != "") {
                        pnlWOCANCELSABUN2.SetValue(DataSet.Tables[0].Rows[0]["WOCANCELSABUN2NM"]);
                    }

                    if (DataSet.Tables[0].Rows[0]["WOCANCELDATE2"] != "") {
                        sDate = DataSet.Tables[0].Rows[0]["WOCANCELDATE2"];
                        sTime = DataSet.Tables[0].Rows[0]["WOCANCELTIME2"];

                        txtWOCANCELDATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOCANCELTIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));
                    }
                    else {
                        txtWOCANCELDATE2.SetValue("");
                        txtWOCANCELTIME2.SetValue("");
                    }

                    txtWOCANCELCOMMENT2.SetValue(DataSet.Tables[0].Rows[0]["WOCANCELCOMMENT2"]);

                    txtWOCANCELSABUN3.SetValue(DataSet.Tables[0].Rows[0]["WOCANCELSABUN3"]);
                    if (txtWOCANCELSABUN3.GetValue() != "") {
                        pnlWOCANCELSABUN3.SetValue(DataSet.Tables[0].Rows[0]["WOCANCELSABUN3NM"]);
                    }

                    if (DataSet.Tables[0].Rows[0]["WOCANCELDATE3"] != "") {
                        sDate = DataSet.Tables[0].Rows[0]["WOCANCELDATE3"];
                        sTime = DataSet.Tables[0].Rows[0]["WOCANCELTIME3"];

                        txtWOCANCELDATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOCANCELTIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));
                    }
                    else {
                        txtWOCANCELDATE3.SetValue("");
                        txtWOCANCELTIME3.SetValue("");
                    }

                    txtWOCANCELCOMMENT3.SetValue(DataSet.Tables[0].Rows[0]["WOCANCELCOMMENT3"]);

                    // 그룹웨어
                    txtWOGRDOC1.SetValue(DataSet.Tables[0].Rows[0]["WOGRDOC1"]);
                    txtWOGRURL1.SetValue(DataSet.Tables[0].Rows[0]["WOGRURL1"]);

                    txtWOGRDOC2.SetValue(DataSet.Tables[0].Rows[0]["WOGRDOC2"]);
                    txtWOGRURL2.SetValue(DataSet.Tables[0].Rows[0]["WOGRURL2"]);

                    // 발주번호1
                    txtWOPONUM1.SetValue(DataSet.Tables[0].Rows[0]["WOPONUM1"]);
                    // 발주번호2
                    txtWOPONUM2.SetValue(DataSet.Tables[0].Rows[0]["WOPONUM2"]);
                    // 발주번호3
                    txtWOPONUM3.SetValue(DataSet.Tables[0].Rows[0]["WOPONUM3"]);
                    // 발주번호4
                    txtWOPONUM4.SetValue(DataSet.Tables[0].Rows[0]["WOPONUM4"]);
                    // 발주번호5
                    txtWOPONUM5.SetValue(DataSet.Tables[0].Rows[0]["WOPONUM5"]);

                    // 위험성평가 존재 체크
                    fsRMWKTEAM = DataSet.Tables[0].Rows[0]["RMWKTEAM"];

                    // 공통코드 가져오기
                    fn_Dataset_Common(txtWOAPPSOSABUN1.GetValue(), txtWOAPPSODATE1.GetValue(),
                                      txtWOAPPSOSABUN2.GetValue(), txtWOAPPSODATE2.GetValue(),
                                      txtWOAPPSOSABUN3.GetValue(), txtWOAPPSODATE3.GetValue(),
                                      txtWOAPPSOSABUN4.GetValue(), txtWOAPPSODATE4.GetValue(),
                                      txtWOAPPSOSABUN5.GetValue(), txtWOAPPSODATE5.GetValue(),
                                      txtWOAPPRESABUN1.GetValue(), txtWOAPPREDATE1.GetValue(),
                                      txtWOAPPRESABUN2.GetValue(), txtWOAPPREDATE2.GetValue(),
                                      txtWOAPPRESABUN3.GetValue(), txtWOAPPREDATE3.GetValue(),
                                      txtWOAPPRESABUN4.GetValue(), txtWOAPPREDATE4.GetValue(),
                                      txtWOAPPRESABUN5.GetValue(), txtWOAPPREDATE5.GetValue());
                }
            }, function (e) {

                // Biz 연결오류
                alert(e.get_message());
                alert("Error");
            });
        }

        function fn_Dataset_Common(sSOSABUN1, sSODATE1,
                                   sSOSABUN2, sSODATE2,
                                   sSOSABUN3, sSODATE3,
                                   sSOSABUN4, sSODATE4,
                                   sSOSABUN5, sSODATE5,            
                                   sRESABUN1, sREDATE1,
                                   sRESABUN2, sREDATE2,
                                   sRESABUN3, sREDATE3,
                                   sRESABUN4, sREDATE4,
                                   sRESABUN5, sREDATE5) {

            var REDOCID;
            var REDOCNUM;

            var sNOWAPP_SOSABUN = ""; // 현재 요청 결재할 사람
            var sNOWAPP_RESABUN = ""; // 현재 요청 결재할 사람

            var sLoginBuseo = "";
            var sRESABUN = "";
            var sRENAME = "";
            
            var today = new Date();
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            // 현재 요청 결재할 사람
            if (sSOSABUN1.toString() != "" && sSODATE1.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN1.toString();
            }
            else if (sSOSABUN2.toString() != "" && sSODATE2.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN2.toString();
            }
            else if (sSOSABUN3.toString() != "" && sSODATE3.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN3.toString();
            }
            else if (sSOSABUN4.toString() != "" && sSODATE4.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN4.toString();
            }
            else if (sSOSABUN5.toString() != "" && sSODATE5.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN5.toString();
            }

            // 현재 요청 결재할 사람
            if (sRESABUN1.toString() != "" && sREDATE1.toString() == "") {
                sNOWAPP_RESABUN = sRESABUN1.toString();
            }
            else if (sRESABUN2.toString() != "" && sREDATE2.toString() == "") {
                sNOWAPP_RESABUN = sRESABUN2.toString();
            }
            else if (sRESABUN3.toString() != "" && sREDATE3.toString() == "") {
                sNOWAPP_RESABUN = sRESABUN3.toString();
            }
            else if (sRESABUN4.toString() != "" && sREDATE4.toString() == "") {
                sNOWAPP_RESABUN = sRESABUN4.toString();
            }
            else if (sRESABUN5.toString() != "" && sREDATE5.toString() == "") {
                sNOWAPP_RESABUN = sRESABUN5.toString();
            }

            // 현재 요청 결재할 사람의 부서코드
            if (sSOSABUN1.toString() != "") {
                ht["P_NOWSOSABUN"] = sNOWAPP_SOSABUN.toString();
            }
            else {
                ht["P_NOWSOSABUN"] = "";
            }
            // 현재 수신 결재할 사람의 부서코드
            if (sRESABUN1.toString() != "") {
                ht["P_NOWRESABUN"] = sNOWAPP_RESABUN.toString();
            }
            else {
                ht["P_NOWRESABUN"] = "";
            }

            ht["P_GUBUN"]      = "INDEX";
            ht["P_DATE"]       = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());
            ht["P_LoginSABUN"] = fshdnLoginSabun;

            ht["P_REDOCID"]    = '01';
            ht["P_REDOCNUM"]   = txtWOORTEAM.GetValue() + Get_Date(txtWOORDATE.GetValue().replace("-", "")) + Set_Fill3(txtWOSEQ.GetValue());
            ht["P_GUBN"]       = "WK";

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_Get_Ds_Common", function (e) {

                var dsComm = eval(e);

                if (ObjectCount(dsComm.Tables[0].Rows) > 0) {

                    sLoginBuseo = dsComm.Tables[0].Rows[0]["LOGINBUSEO"];

                    sRESABUN    = dsComm.Tables[0].Rows[0]["RESABUN"];
                    sRENAME     = dsComm.Tables[0].Rows[0]["RENAME"];

                    // 완료 및 확인자
                    fn_WOFINISH(sLoginBuseo);

                    debugger;

                    // 참조자
                    fn_REFERENCE("INDEX", sRESABUN, sRENAME);

                    // 첨부파일 업로드
                    AttachFileLod();
                    /*AttachFileLod("WK", txtWOORTEAM.GetValue() + txtWOORDATE.GetValue() + Set_Fill3(txtWOSEQ.GetValue()));*/

                    fn_GET_Site();

                    fn_ReadOnly();
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="로딩중 승인자 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

        function Img_Read(gubun, imgsabun, imgname) {

            // 첨부파일 바인딩
            // 조회시에 파일명/SIZE/등을 가져온다.
            var data = "";
            var filename = imgname;
            //var _filesize = parseInt(imgsize);
            //var filesize = getSize(_filesize);
            // 다운로드 경로는 예외처리 되어야함
            var filepath = "/Portal/PSM/PSM10/PSM1100_Down.aspx?sabun=" + imgsabun + "&name=" + imgname;


            // 미리보기임, 값이 안나오면 소스보기(F12해서 ID값 확인해야 함)
            if (gubun.substr(0, 1) == 'S') {
                $("#conBody_ImgWOAPPSOPHOTO" + gubun.substr(1, 1)).attr("src", filepath);
            }
            else {
                $("#conBody_ImgWOAPPREPHOTO" + gubun.substr(1, 1)).attr("src", filepath);
            }
        }

        function fn_BLANK_IMAGE() {
            $("#conBody_ImgWOAPPSOPHOTO1").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgWOAPPSOPHOTO2").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgWOAPPSOPHOTO3").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgWOAPPSOPHOTO4").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgWOAPPSOPHOTO5").attr("src", "/Resources/Framework/blank.gif");

            $("#conBody_ImgWOAPPREPHOTO1").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgWOAPPREPHOTO2").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgWOAPPREPHOTO3").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgWOAPPREPHOTO4").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgWOAPPREPHOTO5").attr("src", "/Resources/Framework/blank.gif");
        }

        function fn_REFERENCE(gubun, sRESABUN, sRENAME) {

            var ht  = new Object();

            var REDOCID;
            var REDOCNUM;

            ht["P_REDOCID"]  = '01';
            ht["P_REDOCNUM"] = txtWOORTEAM.GetValue() + Get_Date(txtWOORDATE.GetValue().replace("-", "")) + Set_Fill3(txtWOSEQ.GetValue());
            ht["P_RESABUN"]  = fsRESABUN;
            //ht["P_RESABUN"]  = txtRESABUN.GetValue();
            ht["P_RENAME"]   = txtRENAME.GetValue();

            if (gubun == 'INDEX') {
                fsRESABUN = sRESABUN;
                /*txtRESABUN.SetValue(sRESABUN);*/
                txtRENAME.SetValue(sRENAME);
            }

            // WORKORDER 프로시저 등록 및 삭제시 로직 추가하였음(23.07.20)
            if (gubun == 'SAVE')
            {
                // 수정
                ht["P_GUBUN"] = 'A';
                PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "PSM_REFERENCE_UPDATE", function (e) {

                }, function (e) {
                    //// Biz 연결오류
                    //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });

            }

            if (gubun == 'DEL') {
                // 삭제
                ht["P_GUBUN"] = 'D';
                PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "PSM_REFERENCE_UPDATE", function (e) {

                }, function (e) {
                    //// Biz 연결오류
                    //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        function fn_GET_Mail_Sabun(iSO_Cnt,   sSO_Cnt,   iRE_Cnt,   sRE_Cnt,
                                   sSOSABUN1, sSOSABUN2, sSOSABUN3, sSOSABUN4, sSOSABUN5,
                                   sRESABUN1, sRESABUN2, sRESABUN3, sRESABUN4, sRESABUN5) {
            var sMail_Send;

            var i = 0;

            i = 0;

            // 요청 결재자
            for (i = parseInt(Get_Numeric(sSO_Cnt.toString())); i < iSO_Cnt; i++) {

                if (i + 1 == iSO_Cnt) {
                    if (iSO_Cnt == 1) {
                        sMail_Send = sRESABUN1.toString();
                    }
                    else if (iSO_Cnt == 2) {
                        sMail_Send = sRESABUN1.toString();
                    }
                    else if (iSO_Cnt == 3) {
                        sMail_Send = sRESABUN1.toString();
                    }
                    else if (iSO_Cnt == 4) {
                        sMail_Send = sRESABUN1.toString();
                    }
                    else if (iSO_Cnt == 5) {
                        sMail_Send = sRESABUN1.toString();
                    }
                }
                else if (i == 0) {
                    sMail_Send = sSOSABUN2.toString();

                    break;
                }
                else if (i == 1) {
                    sMail_Send = sSOSABUN3.toString();

                    break;
                }
                else if (i == 2) {
                    sMail_Send = sSOSABUN4.toString();

                    break;
                }
                else if (i == 3) {
                    sMail_Send = sSOSABUN5.toString();

                    break;
                }
                else if (i == 4) {
                    sMail_Send = sRESABUN1.toString();

                    break;
                }
            }

            i = 0;


            // 수신 결재자
            if (iSO_Cnt == parseInt(Get_Numeric(sSO_Cnt.toString()))) {
                for (i = parseInt(Get_Numeric(sRE_Cnt.toString())); i < iRE_Cnt; i++)
                {
                    if (i + 1 == iRE_Cnt) {
                        if (iRE_Cnt == 1) {
                            sMail_Send = sSOSABUN1.toString();
                        }
                        else if (iRE_Cnt == 2) {
                            sMail_Send = sSOSABUN1.toString();
                        }
                        else if (iRE_Cnt == 3) {
                            sMail_Send = sSOSABUN1.toString();
                        }
                        else if (iRE_Cnt == 4) {
                            sMail_Send = sSOSABUN1.toString();
                        }
                        else if (iRE_Cnt == 5) {
                            sMail_Send = sSOSABUN1.toString();
                        }
                    }
                    else if (i == 0) {
                        sMail_Send = sRESABUN2.toString();

                        break;
                    }
                    else if (i == 1) {
                        sMail_Send = sRESABUN3.toString();

                        break;
                    }
                    else if (i == 2) {
                        sMail_Send = sRESABUN4.toString();

                        break;
                    }
                    else if (i == 3) {
                        sMail_Send = sRESABUN5.toString();

                        break;
                    }
                    else if (i == 4) {
                        sMail_Send = sSOSABUN1.toString();

                        break;
                    }
                }
            }

            return sMail_Send;
        }

        function Set_Fill2(sFirst)
        {
            if (sFirst.Length == 1) {
                sFirst = "0" + sFirst;
            }
            else if (sFirst.Length == 2) {
                sFirst = sFirst;
            }
            else sFirst = "00";

            return sFirst;
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

        function Set_Fill4(sFirst) {

            if (sFirst.toString().length == 1) {

                sFirst = "000" + sFirst.toString();
            }
            else if (sFirst.toString().length == 2) {

                sFirst = "00" + sFirst.toString();
            }
            else if (sFirst.toString().length == 3) {

                sFirst = "01" + sFirst.toString();
            }
            else if (sFirst.toString().length == 4) {
                sFirst = sFirst.toString();
            }
            else {
                sFirst = '0000';
            }

            return sFirst;
        }

        function Get_Numeric(sStr)
        {
            if (sStr == "") return "0";
            else return sStr.replace(",", "");
        }

        function Get_Date(sStr) {

            if (sStr == "") return "";
            else return sStr.replace("-", "");
        }

        function fn_WOFINISH(sLoginBuseo) {

            var iRE_COUNT = 0;

            if (txtWOAPPRESABUN5.GetValue() != "") {
                iRE_COUNT = 5;
            }
            else if (txtWOAPPRESABUN4.GetValue() != "") {
                iRE_COUNT = 4;
            }
            else if (txtWOAPPRESABUN3.GetValue() != "") {
                iRE_COUNT = 3;
            }
            else if (txtWOAPPRESABUN2.GetValue() != "") {
                iRE_COUNT = 2;
            }
            else if (txtWOAPPRESABUN1.GetValue() != "") {
                iRE_COUNT = 1;
            }

            fshdnREApproval = "0";

            if (txtWOAPPREDATE1.GetValue() != "") {
                // 현재 수신결재순번
                fshdnREApproval = "1";
            }

            if (txtWOAPPREDATE2.GetValue() != "") {
                // 현재 수신결재순번
                fshdnREApproval = "2";
            }

            if (txtWOAPPREDATE3.GetValue() != "") {
                // 현재 수신결재순번
                fshdnREApproval = "3";
            }

            if (txtWOAPPREDATE4.GetValue() != "") {
                // 현재 수신결재순번
                fshdnREApproval = "4";
            }

            if (txtWOAPPREDATE5.GetValue() != "") {
                // 현재 수신결재순번
                fshdnREApproval = "5";
            }

            var DataSet;

            if ($("#svWOFINISHSABUN_KBSABUN").val() == "" && txtWOFINISHTEXT.GetValue() == "") {

                sBuseo = sLoginBuseo;

                if (txtWORETEAM.GetValue() == sBuseo)
                {
                    if (iRE_COUNT == fshdnREApproval) {

                        svWOFINISHSABUN.SetDisabled(false);
                        $("#svWOFINISHSABUN_KBSABUN_img").attr("style", "display:yes");
                        
                        txtWOFINISHTEXT.SetDisabled(false);

                        btnWOFINISH.Show();
                    }
                    else {
                        svWOFINISHSABUN.SetDisabled(true);
                        $("#svWOFINISHSABUN_KBSABUN_img").attr("style", "display:none");

                        txtWOFINISHTEXT.SetDisabled(true);

                        btnWOFINISH.Hide();
                    }
                }
            }
            else {

                svWOFINISHSABUN.SetDisabled(true);
                $("#svWOFINISHSABUN_KBSABUN_img").attr("style", "display:none");
                
                txtWOFINISHTEXT.SetDisabled(true);

                btnWOFINISH.Hide();

                // 요청부서에서 공사가 제대로 완료가 되었는지 확인
                if ($("#svWOIMMEDSABUN_KBSABUN").val() == "" && txtWOIMMEDTEXT.GetValue() == "") {

                    sBuseo = sLoginBuseo;

                    if (txtWOSOTEAM.GetValue() == sBuseo) {

                        svWOIMMEDSABUN.SetDisabled(false);
                        $("#svWOIMMEDSABUN_KBSABUN_img").attr("style", "display:yes");

                        txtWOIMMEDTEXT.SetDisabled(false);

                        btnWOIMMED.Show();
                    }
                }
                else {

                    svWOIMMEDSABUN.SetDisabled(true);
                    $("#svWOIMMEDSABUN_KBSABUN_img").attr("style", "display:none");

                    txtWOIMMEDTEXT.SetDisabled(true);

                    btnWOIMMED.Hide();
                }
            }
        }

        // 결재선지정 버튼 이벤트
        function btnSOApproval_Click() {
            var param;

            param = "";

            param += "../POP/SabunMultiChkPopup5.aspx?callback=fn_PopupCallBack&Data_Cnt1=5&Data_Cnt2=5&GUBUN=WK";

            param += "&param1=" + txtWOAPPSOSABUN1.GetValue();
            param += "&param2=" + txtWOAPPSOSABUN2.GetValue();
            param += "&param3=" + txtWOAPPSOSABUN3.GetValue();
            param += "&param4=" + txtWOAPPSOSABUN4.GetValue();
            param += "&param5=" + txtWOAPPSOSABUN5.GetValue();
            param += "&param6=" + fshdnSOApproval;

            param += "&param11=" + txtWOAPPSONAME1.GetValue();
            param += "&param12=" + txtWOAPPSONAME2.GetValue();
            param += "&param13=" + txtWOAPPSONAME3.GetValue();
            param += "&param14=" + txtWOAPPSONAME4.GetValue();
            param += "&param15=" + txtWOAPPSONAME5.GetValue();

            param += "&param21=" + txtWOAPPSOJKCD1.GetValue();
            param += "&param22=" + txtWOAPPSOJKCD2.GetValue();
            param += "&param23=" + txtWOAPPSOJKCD3.GetValue();
            param += "&param24=" + txtWOAPPSOJKCD4.GetValue();
            param += "&param25=" + txtWOAPPSOJKCD5.GetValue();

            param += "&param31=" + txtWOAPPSOJKCDNM1.GetValue();
            param += "&param32=" + txtWOAPPSOJKCDNM2.GetValue();
            param += "&param33=" + txtWOAPPSOJKCDNM3.GetValue();
            param += "&param34=" + txtWOAPPSOJKCDNM4.GetValue();
            param += "&param35=" + txtWOAPPSOJKCDNM5.GetValue();

            param += "&param61=" + txtWOAPPRESABUN1.GetValue();
            param += "&param62=" + txtWOAPPRESABUN2.GetValue();
            param += "&param63=" + txtWOAPPRESABUN3.GetValue();
            param += "&param64=" + txtWOAPPRESABUN4.GetValue();
            param += "&param65=" + txtWOAPPRESABUN5.GetValue();
            param += "&param66=" + fshdnREApproval;


            param += "&param71=" + txtWOAPPRENAME1.GetValue();
            param += "&param72=" + txtWOAPPRENAME2.GetValue();
            param += "&param73=" + txtWOAPPRENAME3.GetValue();
            param += "&param74=" + txtWOAPPRENAME4.GetValue();
            param += "&param75=" + txtWOAPPRENAME5.GetValue();

            param += "&param81=" + txtWOAPPREJKCD1.GetValue();
            param += "&param82=" + txtWOAPPREJKCD2.GetValue();
            param += "&param83=" + txtWOAPPREJKCD3.GetValue();
            param += "&param84=" + txtWOAPPREJKCD4.GetValue();
            param += "&param85=" + txtWOAPPREJKCD5.GetValue();

            param += "&param91=" + txtWOAPPREJKCDNM1.GetValue();
            param += "&param92=" + txtWOAPPREJKCDNM2.GetValue();
            param += "&param93=" + txtWOAPPREJKCDNM3.GetValue();
            param += "&param94=" + txtWOAPPREJKCDNM4.GetValue();
            param += "&param95=" + txtWOAPPREJKCDNM5.GetValue();

            param += "&SOSign=" + fshdnSOSign;
            param += "&RESign=" + fshdnRESign;
            param += "&SABUN=" + fsRESABUN;
            /*param += "&SABUN=" + txtRESABUN.GetValue();*/
            param += "&NAME=" + txtRENAME.GetValue();

            fn_OpenPop(param, 600, 400);
        }

        function fn_PopupCallBack(items1, items2, items3) {

            var sabun = "";
            var name = "";

            // 결재요청
            // 필드 클리어
            fn_Field_clear(1);

            if (items1.length > 0) {

                txtWOAPPSOSABUN1.SetValue(items1[0].data.KBSABUN);
                txtWOAPPSOJKCD1.SetValue(items1[0].data.JKCODE);
                txtWOAPPSOJKCDNM1.SetValue(items1[0].data.CDDESC1);
                txtWOAPPSONAME1.SetValue(items1[0].data.KBHANGL);
            }

            if (items1.length > 1) {

                if (txtWOAPPSOSABUN1.GetValue() == items1[1].data.KBSABUN)
                {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청승인자를 확인하세요." Literal="true"></Ctl:Text>');
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtWOAPPSOSABUN2.SetValue(items1[1].data.KBSABUN);
                txtWOAPPSOJKCD2.SetValue(items1[1].data.JKCODE);
                txtWOAPPSOJKCDNM2.SetValue(items1[1].data.CDDESC1);
                txtWOAPPSONAME2.SetValue(items1[1].data.KBHANGL);
            }

            if (items1.length > 2) {

                if (txtWOAPPSOSABUN1.GetValue() == items1[2].data.KBSABUN)
                {
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtWOAPPSOSABUN3.SetValue(items1[2].data.KBSABUN);
                txtWOAPPSOJKCD3.SetValue(items1[2].data.JKCODE);
                txtWOAPPSOJKCDNM3.SetValue(items1[2].data.CDDESC1);
                txtWOAPPSONAME3.SetValue(items1[2].data.KBHANGL);
            }

            if (items1.length > 3) {

                if (txtWOAPPSOSABUN1.GetValue() == items1[3].data.KBSABUN)
                {
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtWOAPPSOSABUN4.SetValue(items1[3].data.KBSABUN);
                txtWOAPPSOJKCD4.SetValue(items1[3].data.JKCODE);
                txtWOAPPSOJKCDNM4.SetValue(items1[3].data.CDDESC1);
                txtWOAPPSONAME4.SetValue(items1[3].data.KBHANGL);
            }

            if (items1.length > 4) {

                if (txtWOAPPSOSABUN1.GetValue() == items1[4].data.KBSABUN)
                {
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtWOAPPSOSABUN5.SetValue(items1[4].data.KBSABUN);
                txtWOAPPSOJKCD5.SetValue(items1[4].data.JKCODE);
                txtWOAPPSOJKCDNM5.SetValue(items1[4].data.CDDESC1);
                txtWOAPPSONAME5.SetValue(items1[4].data.KBHANGL);
            }

            // 수신결재
            // 필드 클리어
            fn_Field_clear(2);

            if (items2.length > 0) {
                    txtWOAPPRESABUN1.SetValue(items2[0].data.KBSABUN);
                    txtWOAPPREJKCD1.SetValue(items2[0].data.JKCODE);
                    txtWOAPPREJKCDNM1.SetValue(items2[0].data.CDDESC1);
                    txtWOAPPRENAME1.SetValue(items2[0].data.KBHANGL);
            }
            if (items2.length > 1) {
                    txtWOAPPRESABUN2.SetValue(items2[1].data.KBSABUN);
                    txtWOAPPREJKCD2.SetValue(items2[1].data.JKCODE);
                    txtWOAPPREJKCDNM2.SetValue(items2[1].data.CDDESC1);
                    txtWOAPPRENAME2.SetValue(items2[1].data.KBHANGL);
            }
            if (items2.length > 2) {
                    txtWOAPPRESABUN3.SetValue(items2[2].data.KBSABUN);
                    txtWOAPPREJKCD3.SetValue(items2[2].data.JKCODE);
                    txtWOAPPREJKCDNM3.SetValue(items2[2].data.CDDESC1);
                    txtWOAPPRENAME3.SetValue(items2[2].data.KBHANGL);
            }
            if (items2.length > 3) {
                    txtWOAPPRESABUN4.SetValue(items2[3].data.KBSABUN);
                    txtWOAPPREJKCD4.SetValue(items2[3].data.JKCODE);
                    txtWOAPPREJKCDNM4.SetValue(items2[3].data.CDDESC1);
                    txtWOAPPRENAME4.SetValue(items2[3].data.KBHANGL);
            }
            if (items2.length > 4) {
                    txtWOAPPRESABUN5.SetValue(items2[4].data.KBSABUN);
                    txtWOAPPREJKCD5.SetValue(items2[4].data.JKCODE);
                    txtWOAPPREJKCDNM5.SetValue(items2[4].data.CDDESC1);
                    txtWOAPPRENAME5.SetValue(items2[4].data.KBHANGL);
            }

            fn_Field_clear(3);

            for (i = 0; i < items3.length; i++) {
                if (sabun.length > 0) {
                    sabun += ",";
                    name += ",";
                }

                sabun += items3[i].data.KBSABUN;
                name += items3[i].data.KBHANGL;
            }

            fsRESABUN = sabun;
            //txtRESABUN.SetValue(sabun);
            txtRENAME.SetValue(name);

            if (items2.length > 0) {

                var today = new Date();

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["P_DATE"] = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());
                ht["P_KBSABUN"] = txtWOAPPRESABUN1.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        txtWORETEAM.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEO"]);
                        pnlWORETEAM.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEONM"]);
                        
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재선 지정 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
            else {
                txtWORETEAM.SetValue('');
                pnlWORETEAM.SetValue('');
            }

            // 결재선 지정 후 결재버튼 보이게 함.
            if (items1.length > 0 && items2.length > 0) {
                // 반려버튼
                btnCancel.Hide();

                // 결재버튼
                btnApproval.Show();
            }
        }

        function fn_Field_clear(gubun) {

            if (gubun == '1') {
                txtWOAPPSOSABUN2.SetValue('');
                txtWOAPPSOJKCD2.SetValue('');
                txtWOAPPSOJKCDNM2.SetValue('');
                txtWOAPPSONAME2.SetValue('');

                txtWOAPPSOSABUN3.SetValue('');
                txtWOAPPSOJKCD3.SetValue('');
                txtWOAPPSOJKCDNM3.SetValue('');
                txtWOAPPSONAME3.SetValue('');

                txtWOAPPSOSABUN4.SetValue('');
                txtWOAPPSOJKCD4.SetValue('');
                txtWOAPPSOJKCDNM4.SetValue('');
                txtWOAPPSONAME4.SetValue('');

                txtWOAPPSOSABUN5.SetValue('');
                txtWOAPPSOJKCD5.SetValue('');
                txtWOAPPSOJKCDNM5.SetValue('');
                txtWOAPPSONAME5.SetValue('');
            }
            else if (gubun == '2') {
                txtWOAPPRESABUN1.SetValue('');
                txtWOAPPREJKCD1.SetValue('');
                txtWOAPPREJKCDNM1.SetValue('');
                txtWOAPPRENAME1.SetValue('');

                txtWOAPPRESABUN2.SetValue('');
                txtWOAPPREJKCD2.SetValue('');
                txtWOAPPREJKCDNM2.SetValue('');
                txtWOAPPRENAME2.SetValue('');

                txtWOAPPRESABUN3.SetValue('');
                txtWOAPPREJKCD3.SetValue('');
                txtWOAPPREJKCDNM3.SetValue('');
                txtWOAPPRENAME3.SetValue('');

                txtWOAPPRESABUN4.SetValue('');
                txtWOAPPREJKCD4.SetValue('');
                txtWOAPPREJKCDNM4.SetValue('');
                txtWOAPPRENAME4.SetValue('');

                txtWOAPPRESABUN5.SetValue('');
                txtWOAPPREJKCD5.SetValue('');
                txtWOAPPREJKCDNM5.SetValue('');
                txtWOAPPRENAME5.SetValue('');
            }
            else {
                fsRESABUN = '';
                //txtRESABUN.SetValue('');
                txtRENAME.SetValue('');
            }
        }

        // 결재 버튼 이벤트
        function btnApproval_Click() {

            var iSO_COUNT = 0;
            var iRE_COUNT = 0;

            if (txtWOAPPSOSABUN5.GetValue() != "") {
                iSO_COUNT = 5;
            }
            else if (txtWOAPPSOSABUN4.GetValue() != "") {
                iSO_COUNT = 4;
            }
            else if (txtWOAPPSOSABUN3.GetValue() != "") {
                iSO_COUNT = 3;
            }
            else if (txtWOAPPSOSABUN2.GetValue() != "") {
                iSO_COUNT = 2;
            }
            else if (txtWOAPPSOSABUN1.GetValue() != "") {
                iSO_COUNT = 1;
            }

            if (txtWOAPPRESABUN5.GetValue() != "") {
                iRE_COUNT = 5;
            }
            else if (txtWOAPPRESABUN4.GetValue() != "") {
                iRE_COUNT = 4;
            }
            else if (txtWOAPPRESABUN3.GetValue() != "") {
                iRE_COUNT = 3;
            }
            else if (txtWOAPPRESABUN2.GetValue() != "") {
                iRE_COUNT = 2;
            }
            else if (txtWOAPPRESABUN1.GetValue() != "") {
                iRE_COUNT = 1;
            }

            if (iSO_COUNT != parseInt(Get_Numeric(fshdnSOApproval))) {

                _id = "APPROVAL";

                // 결재 창
                fn_OpenPop("PSM4012.aspx?param=APPROVAL", 385, 180);
            }
            else {

                if (iRE_COUNT == parseInt(Get_Numeric(fshdnREApproval)) + 1) {

                    fsWOIMMEDGUBN = "";
                    _id = "APPROVAL";
                    // 결재 창
                    fn_OpenPop("PSM4013.aspx?param=" + txtWOORTEAM.GetValue() + "&param1=" + txtWOORDATE.GetValue() + "&param2=" + Set_Fill3(txtWOSEQ.GetValue()), 500, 315);
                }
                else {
                    _id = "APPROVAL";

                    // 결재 창
                    fn_OpenPop("PSM4012.aspx?param=APPROVAL", 385, 180);
                }
            }
        }

        // 결재 철회 이벤트
        function btnRETRACT_Click() {

            _id = "RETRACT";

            // 결재 창
            fn_OpenPop("PSM4012.aspx?param=RETRACT", 385, 180);
        }
        
        // 반려 버튼 이벤트
        function btnCancel_Click() {

            _id = "CANCEL";

            // 결재 창
            fn_OpenPop("PSM4012.aspx?param=CANCEL", 385, 180);
        }

        // 저장 버튼 이벤트
        function btnSave_Click() {

            doDisplay();

            fn_Screen_Save("SAVE", "");

            setTimeout("doDisplay()", '3000');
        }

        // 삭제 버튼 이벤트
        function btnDel_Click() {

            doDisplay();

            // 위험성평가 자료 체크
            if (fsRMWKTEAM != "") {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="위험성평가 자료가 존재하므로 삭제가 불가합니다." Literal="true"></Ctl:Text>');
                return;
            }

            // 안전작업허가서 자료 존재 체크
            if (txtSMWKORAPPDATE.GetValue() != "") {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전 작업허가서 자료가 존재하므로 삭제가 불가합니다." Literal="true"></Ctl:Text>');
                return;
            }

            var ht = new Object();

            ht["P_ATTACH_TYPE"] = "WK";
            ht["P_ATTACH_NO"]   = txtWOORTEAM.GetValue() + Get_Date(txtWOORDATE.GetValue().replace("-", "")) + Set_Fill3(txtWOSEQ.GetValue());
            ht["P_WOORTEAM"]    = txtWOORTEAM.GetValue();
            ht["P_WOORDATE"]    = Get_Date(txtWOORDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"]       = Set_Fill3(txtWOSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_WORKORDER_DEL", function (e) {

                var DataSet = eval(e);

                debugger;
                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        fn_REFERENCE('DEL', '', '');

                        // BIN 상태관리 업데이트
                        fn_BIN_STATUSMF_UPDATE();

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                        debugger;
                        if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                            opener.btnSearch_Click();

                            this.close();
                        }

                        this.close();
                    }
                    else {
                        var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                    }
                }
                else {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });

            /*setTimeout("doDisplay()", '3000');*/
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            //if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
            //    opener.btnSearch_Click();
            //}

            this.close();
        }

        function fn_BIN_STATUSMF_UPDATE() {

            var ht = new Object();

            ht["P_WOLOCATIONCODE1"] = txtWOLOCATIONCODE1.GetValue();
            ht["P_WOLOCATIONCODE2"] = txtWOLOCATIONCODE2.GetValue();
            ht["P_WOLOCATIONCODE3"] = txtWOLOCATIONCODE3.GetValue();
            ht["P_WOLOCATIONCODE4"] = txtWOLOCATIONCODE4.GetValue();
            ht["P_WOLOCATIONCODE5"] = txtWOLOCATIONCODE5.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_BIN_STATUSMF_UPDATE", function (e) {

            }, function (e) {
            });
        }

        // 철회 함수
        function fn_RETRACT_Proc() {

            var sPGURL        = "";
            var sAPNUM        = "";

            sAPNUM = txtWOORTEAM.GetValue() + "-" + Get_Date(txtWOORDATE.GetValue().replace("-", "")) + "-" + Set_Fill3(txtWOSEQ.GetValue());

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            sPGURL = "/Portal/PSM/PSM40/PSM4011.aspx?";
            sPGURL = sPGURL + "param=UPT&param1=";
            sPGURL = sPGURL + sAPNUM;

            //sPGURL = "/Portal/PSM/PSM40/PSM4011.aspx?";
            //sPGURL = sPGURL + "APP_NUM=";
            //sPGURL = sPGURL + sAPNUM;

            ht["P_WOORTEAM"]    = txtWOORTEAM.GetValue();
            ht["P_WOORDATE"]    = Get_Date(txtWOORDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"]       = Set_Fill3(txtWOSEQ.GetValue());

            ht["P_RTDOCID"]     = "01";
            ht["P_RTDOCNUM"]    = txtWOORTEAM.GetValue() + Get_Date(txtWOORDATE.GetValue().replace("-","")) + Set_Fill3(txtWOSEQ.GetValue());
            ht["P_RTCOMMENT"]   = fsRETRACTCOMMENT;
            ht["P_RTHISAB"]     = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
            ht["P_APNUM"]       = txtWOORTEAM.GetValue() + Get_Date(txtWOORDATE.GetValue().replace("-", "")) + Set_Fill3(txtWOSEQ.GetValue());
            ht["P_WOWORKTITLE"] = txtWOWORKTITLE.GetValue();
            ht["P_SENDER"]      = txtWOAPPSOSABUN1.GetValue();
            ht["P_RECEIVER"]    = txtWOAPPSOSABUN1.GetValue();

            // 작업요청서 철회
            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_WORKORDER_RETRACT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        // BIN 상태관리 업데이트
                        fn_BIN_STATUSMF_UPDATE();

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재가 철회 되었습니다." Literal="true"></Ctl:Text>');

                        fn_Btn_Visible('3');

                        fn_GET_Display();

                        fn_GET_Site();

                        fn_ReadOnly();

                        // 공백이미지
                        fn_BLANK_IMAGE();

                        // 현재 요청결재순번
                        fshdnSOApproval = "0";
                        // 현재 수신결재순번
                        fshdnREApproval = "0";
                    }
                }
            }, function (e) {
            });

        }

        // 취소 함수
        function fn_CANCEL_Proc() {

            var gubun = "";
            var WOCANCELCOMMENT = "";
            var WOAPPSOSABUN1 = "";
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_WOORTEAM"] = txtWOORTEAM.GetValue();
            ht["P_WOORDATE"] = Get_Date(txtWOORDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"]    = Set_Fill3(txtWOSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_WORKORDER_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    if (txtWOCANCELCOMMENT3.GetValue() != "") {
                        gubun = "3";
                        WOCANCELCOMMENT = txtWOCANCELCOMMENT3.GetValue();
                    }
                    else if (txtWOCANCELCOMMENT2.GetValue() != "") {
                        gubun = "2";
                        WOCANCELCOMMENT = txtWOCANCELCOMMENT2.GetValue();
                    }
                    else if (txtWOCANCELCOMMENT1.GetValue() != "") {
                        gubun = "1";
                        WOCANCELCOMMENT = txtWOCANCELCOMMENT1.GetValue();
                    }

                    WOAPPSOSABUN1 = DataSet.Tables[0].Rows[0]["WOAPPSOSABUN1"].toString();

                    ht["P_GUBUN"]           = gubun;
                    ht["P_WOCANCELCOMMENT"] = WOCANCELCOMMENT;
                    ht["P_WOCANCELSABUN"]   = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";

                    // 작업요청서 취소 의견
                    PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_WORKORDER_CANCEL_COMMENT", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                            if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                                // 작업요청서 취소
                                PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_WORKORDER_CANCEL", function (e) {

                                    var DataSet = eval(e);

                                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                                            // BIN 상태관리 업데이트
                                            fn_BIN_STATUSMF_UPDATE();

                                            // 메일 발송
                                            fn_Mail_Send(txtWOORTEAM.GetValue(), Get_Date(txtWOORDATE.GetValue().replace("-", "")), txtWOSEQ.GetValue(), WOCANCELCOMMENT, WOAPPSOSABUN1.toString(), "CANCEL", "");

                                            //fn_GET_Display();

                                            //fn_GET_Site();

                                            //// 현재 요청결재순번
                                            //fshdnSOApproval = "0";
                                            //// 현재 수신결재순번
                                            //fshdnREApproval = "0";

                                            //// BIN 상태관리 업데이트
                                            //fn_BIN_STATUSMF_UPDATE();

                                            //// 공백 이미지
                                            //fn_BLANK_IMAGE();

                                            ///*alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업요청서 취소 처리가 되었습니다." Literal="true"></Ctl:Text>');*/

                                            //fn_Btn_Visible('3');

                                            //this.close();
                                        }
                                        else {

                                        }
                                    }


                                }, function (e) {
                                });
                            }
                            else {

                            }
                        }


                    }, function (e) {
                    });
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업요청서 취소 처리가 되었습니다." Literal="true"></Ctl:Text>');

                this.close();
            });

        }


        function fn_Screen_Save(Gubun, Finish) {

            fn_Save
                (
                    txtWOORTEAM.GetValue(),
                    Get_Date(txtWOORDATE.GetValue().replace("-", "")),
                    txtWOSEQ.GetValue(),
                    txtWOORSABUN.GetValue(),
                    txtWOWORKTITLE.GetValue(),
                    txtWOLOCATIONCODE1.GetValue(),
                    txtWOLOCATIONCODE2.GetValue(),
                    txtWOLOCATIONCODE3.GetValue(),
                    txtWOLOCATIONCODE4.GetValue(),
                    txtWOLOCATIONCODE5.GetValue(),
                    txtWOAREACODE1.GetValue(),
                    txtWOAREACODE2.GetValue(),
                    txtWOAREACODE3.GetValue(),
                    txtWOAREACODE4.GetValue(),
                    txtWOAREACODE5.GetValue(),
                    txtWODSDATE1.GetValue(),
                    txtWODSDATE2.GetValue(),
                    txtWOSOTEAM.GetValue(),
                    txtWORETEAM.GetValue(),
                    "", // 허가자
                    txtWOFINISHDATE.GetValue(),
                    $("#svWOFINISHSABUN_KBSABUN").val(),
                    cboWOCHANGEWKJOB.GetValue(),
                    cboWOCHANGEWKDIV.GetValue(),
                    txtWOAPPSOSABUN1.GetValue(),
                    txtWOAPPSONAME1.GetValue(),
                    txtWOAPPSOJKCD1.GetValue(),
                    txtWOAPPSOJKCDNM1.GetValue(),
                    txtWOAPPSODATE1.GetValue(),
                    txtWOAPPSOTIME1.GetValue(),
                    txtWOAPPSOCOMMENT1.GetValue(),
                    txtWOAPPSOSABUN2.GetValue(),
                    txtWOAPPSONAME2.GetValue(),
                    txtWOAPPSOJKCD2.GetValue(),
                    txtWOAPPSOJKCDNM2.GetValue(),
                    txtWOAPPSODATE2.GetValue(),
                    txtWOAPPSOTIME2.GetValue(),
                    txtWOAPPSOCOMMENT2.GetValue(),
                    txtWOAPPSOSABUN3.GetValue(),
                    txtWOAPPSONAME3.GetValue(),
                    txtWOAPPSOJKCD3.GetValue(),
                    txtWOAPPSOJKCDNM3.GetValue(),
                    txtWOAPPSODATE3.GetValue(),
                    txtWOAPPSOTIME3.GetValue(),
                    txtWOAPPSOCOMMENT3.GetValue(),
                    txtWOAPPSOSABUN4.GetValue(),
                    txtWOAPPSONAME4.GetValue(),
                    txtWOAPPSOJKCD4.GetValue(),
                    txtWOAPPSOJKCDNM4.GetValue(),
                    txtWOAPPSODATE4.GetValue(),
                    txtWOAPPSOTIME4.GetValue(),
                    txtWOAPPSOCOMMENT4.GetValue(),
                    txtWOAPPSOSABUN5.GetValue(),
                    txtWOAPPSONAME5.GetValue(),
                    txtWOAPPSOJKCD5.GetValue(),
                    txtWOAPPSOJKCDNM5.GetValue(),
                    txtWOAPPSODATE5.GetValue(),
                    txtWOAPPSOTIME5.GetValue(),
                    txtWOAPPSOCOMMENT5.GetValue(),
                    txtWOAPPRESABUN1.GetValue(),
                    txtWOAPPRENAME1.GetValue(),
                    txtWOAPPREJKCD1.GetValue(),
                    txtWOAPPREJKCDNM1.GetValue(),
                    txtWOAPPREDATE1.GetValue(),
                    txtWOAPPRETIME1.GetValue(),
                    txtWOAPPRECOMMENT1.GetValue(),
                    txtWOAPPRESABUN2.GetValue(),
                    txtWOAPPRENAME2.GetValue(),
                    txtWOAPPREJKCD2.GetValue(),
                    txtWOAPPREJKCDNM2.GetValue(),
                    txtWOAPPREDATE2.GetValue(),
                    txtWOAPPRETIME2.GetValue(),
                    txtWOAPPRECOMMENT2.GetValue(),
                    txtWOAPPRESABUN3.GetValue(),
                    txtWOAPPRENAME3.GetValue(),
                    txtWOAPPREJKCD3.GetValue(),
                    txtWOAPPREJKCDNM3.GetValue(),
                    txtWOAPPREDATE3.GetValue(),
                    txtWOAPPRETIME3.GetValue(),
                    txtWOAPPRECOMMENT3.GetValue(),
                    txtWOAPPRESABUN4.GetValue(),
                    txtWOAPPRENAME4.GetValue(),
                    txtWOAPPREJKCD4.GetValue(),
                    txtWOAPPREJKCDNM4.GetValue(),
                    txtWOAPPREDATE4.GetValue(),
                    txtWOAPPRETIME4.GetValue(),
                    txtWOAPPRECOMMENT4.GetValue(),
                    txtWOAPPRESABUN5.GetValue(),
                    txtWOAPPRENAME5.GetValue(),
                    txtWOAPPREJKCD5.GetValue(),
                    txtWOAPPREJKCDNM5.GetValue(),
                    txtWOAPPREDATE5.GetValue(),
                    txtWOAPPRETIME5.GetValue(),
                    txtWOAPPRECOMMENT5.GetValue(),
                    txtWOGRDOC1.GetValue(),
                    txtWOGRURL1.GetValue(),
                    txtWOGRDOC2.GetValue(),
                    txtWOGRURL2.GetValue(),
                    txtWOWORKDOC.GetValue(),
                    Gubun.toString(),
                    fshdnExists,
                    fshdnSOApproval,
                    fshdnREApproval,
                    Finish.toString(),
                    txtWOPONUM1.GetValue(),
                    txtWOPONUM2.GetValue(),
                    txtWOPONUM3.GetValue(),
                    txtWOPONUM4.GetValue(),
                    txtWOPONUM5.GetValue()
            );
        }

        function fn_Save(sWOORTEAM,        sWOORDATE,        sWOSEQ,
                         sWOORSABUN,       sWOWORKTITLE,     sWOLOCATIONCODE1,
                         sWOLOCATIONCODE2, sWOLOCATIONCODE3, sWOLOCATIONCODE4,
                         sWOLOCATIONCODE5, sWOAREACODE1,     sWOAREACODE2,
                         sWOAREACODE3,     sWOAREACODE4,     sWOAREACODE5,
                         sWODSDATE1,       sWODSDATE2,       sWOSOTEAM,
                         sWORETEAM,        sWOSAFESABUN,     sWOFINISHDATE,
                         sWOFINISHSABUN,   sWOCHANGEWKJOB,   sWOCHANGEWKDIV,
                         sWOAPPSOSABUN1,   sWOAPPSONAME1,    sWOAPPSOJKCD1,
                         sWOAPPSOJKCDNM1,  sWOAPPSODATE1,    sWOAPPSOTIME1,
                         sWOAPPSOCOMMENT1, sWOAPPSOSABUN2,   sWOAPPSONAME2,
                         sWOAPPSOJKCD2,    sWOAPPSOJKCDNM2,  sWOAPPSODATE2,
                         sWOAPPSOTIME2,    sWOAPPSOCOMMENT2, sWOAPPSOSABUN3,
                         sWOAPPSONAME3,    sWOAPPSOJKCD3,    sWOAPPSOJKCDNM3,
                         sWOAPPSODATE3,    sWOAPPSOTIME3,    sWOAPPSOCOMMENT3,
                         sWOAPPSOSABUN4,   sWOAPPSONAME4,    sWOAPPSOJKCD4,
                         sWOAPPSOJKCDNM4,  sWOAPPSODATE4,    sWOAPPSOTIME4,
                         sWOAPPSOCOMMENT4, sWOAPPSOSABUN5,   sWOAPPSONAME5,
                         sWOAPPSOJKCD5,    sWOAPPSOJKCDNM5,  sWOAPPSODATE5,
                         sWOAPPSOTIME5,    sWOAPPSOCOMMENT5, sWOAPPRESABUN1,
                         sWOAPPRENAME1,    sWOAPPREJKCD1,    sWOAPPREJKCDNM1,
                         sWOAPPREDATE1,    sWOAPPRETIME1,    sWOAPPRECOMMENT1,
                         sWOAPPRESABUN2,   sWOAPPRENAME2,    sWOAPPREJKCD2,
                         sWOAPPREJKCDNM2,  sWOAPPREDATE2,    sWOAPPRETIME2,
                         sWOAPPRECOMMENT2, sWOAPPRESABUN3,   sWOAPPRENAME3,
                         sWOAPPREJKCD3,    sWOAPPREJKCDNM3,  sWOAPPREDATE3,
                         sWOAPPRETIME3,    sWOAPPRECOMMENT3, sWOAPPRESABUN4,
                         sWOAPPRENAME4,    sWOAPPREJKCD4,    sWOAPPREJKCDNM4,
                         sWOAPPREDATE4,    sWOAPPRETIME4,    sWOAPPRECOMMENT4,
                         sWOAPPRESABUN5,   sWOAPPRENAME5,    sWOAPPREJKCD5,
                         sWOAPPREJKCDNM5,  sWOAPPREDATE5,    sWOAPPRETIME5,
                         sWOAPPRECOMMENT5, sWOGRDOC1,        sWOGRURL1,
                         sWOGRDOC2,        sWOGRURL2,        sWOWORKDOC,
                         sGUBUN,           sExists,          sSOApproval,
                         sREApproval,      sFinish,          sWOPONUM1,
                         sWOPONUM2,        sWOPONUM3,        sWOPONUM4,
                         sWOPONUM5) {
            var i = 0;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            // 설비코드1
            if (sWOLOCATIONCODE1.toString() != "") {

                if (sWOLOCATIONCODE1.length != 10) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드1을 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 설비코드2
            if (sWOLOCATIONCODE2.toString() != "") {

                if (sWOLOCATIONCODE2.length != 10) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드2를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 설비코드3
            if (sWOLOCATIONCODE3.toString() != "") {

                if (sWOLOCATIONCODE3.length != 10) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드3을 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 설비코드4
            if (sWOLOCATIONCODE4.toString() != "") {

                if (sWOLOCATIONCODE4.length != 10) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드4를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 설비코드5
            if (sWOLOCATIONCODE5.toString() != "") {

                if (sWOLOCATIONCODE5.length != 10) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드5를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 작업구역1
            if (sWOAREACODE1.toString() != "") {
                if (sWOAREACODE1.length != 9) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 구역1을 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 작업구역2
            if (sWOAREACODE2.toString() != "") {
                if (sWOAREACODE2.length != 9) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 구역2를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 작업구역3
            if (sWOAREACODE3.toString() != "") {
                if (sWOAREACODE3.length != 9) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 구역3을 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 작업구역4
            if (sWOAREACODE4.toString() != "") {
                if (sWOAREACODE4.length != 9) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 구역4를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 작업구역5
            if (sWOAREACODE5.toString() != "") {
                if (sWOAREACODE5.length != 9) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 구역5를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            ht["P_WOORSABUN"] = sWOORSABUN.toString();
            ht["P_DATE"]      = sWOORDATE.toString();
            ht["P_WOSOTEAM"]  = sWOSOTEAM.toString();
            ht["P_WORETEAM"]  = sWORETEAM.toString();
            ht["P_WOPONUM1"]  = sWOPONUM1.toString();
            ht["P_WOPONUM2"]  = sWOPONUM2.toString();
            ht["P_WOPONUM3"]  = sWOPONUM3.toString();
            ht["P_WOPONUM4"]  = sWOPONUM4.toString();
            ht["P_WOPONUM5"]  = sWOPONUM5.toString();
            ht["P_FXCCODE1"]  = sWOLOCATIONCODE1.toString();
            ht["P_FXCCODE2"]  = sWOLOCATIONCODE2.toString();
            ht["P_FXCCODE3"]  = sWOLOCATIONCODE3.toString();
            ht["P_FXCCODE4"]  = sWOLOCATIONCODE4.toString();
            ht["P_FXCCODE5"]  = sWOLOCATIONCODE5.toString();
            ht["P_L3CODE1"]   = sWOAREACODE1.toString();
            ht["P_L3CODE2"]   = sWOAREACODE2.toString();
            ht["P_L3CODE3"]   = sWOAREACODE3.toString();
            ht["P_L3CODE4"]   = sWOAREACODE4.toString();
            ht["P_L3CODE5"]   = sWOAREACODE5.toString();



            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_FIELDCHECK", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    if (sWOORDATE.toString() == "") {


                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청일자를 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    // 요청자
                    if (sWOORSABUN.toString() == "") {

                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자 사번을 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else {
                        // DB 체크
                        // 1.
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            if (i == 0) {
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "1") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlWOORSABUN.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자 사번을 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자 사번을 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }
                    }

                    // 요청팀
                    if (sWOSOTEAM.toString() == "") {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청팀을 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else {
                        // DB 체크
                        // 2.
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            if (i == 1) {
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "2") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlWOSOTEAM.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청팀을 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청팀을 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }
                    }

                    // 수신팀
                    if (sWORETEAM.toString() == "") {

                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="수신팀을 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else {
                        // DB 체크
                        // 3.
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            if (i == 2) {
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "3") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlWORETEAM.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="수신팀을 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="수신팀을 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }
                    }

                    if (sWODSDATE1.toString() == "") {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 시작일자를 확인하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    if (sWODSDATE2.toString() == "") {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 종료일자를 확인하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    if (parseInt(Get_Numeric(sWODSDATE1.toString())) > parseInt(Get_Numeric(sWODSDATE2.toString()))) {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 일자를 확인하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    // 설비코드
                    if (sWOLOCATIONCODE1.toString() == "") {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드1을 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else {
                        if (sWOLOCATIONCODE2.toString() == "") {
                            if (sWOLOCATIONCODE3.toString() != "" || sWOLOCATIONCODE4.toString() != "" || sWOLOCATIONCODE5.toString() != "") {
                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드를 입력하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }

                        if (sWOLOCATIONCODE3.toString() == "") {
                            if (sWOLOCATIONCODE4.toString() != "" || sWOLOCATIONCODE5.toString() != "") {
                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드를 입력하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }

                        if (sWOLOCATIONCODE4.toString() == "") {
                            if (sWOLOCATIONCODE5.toString() != "") {
                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드를 입력하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }
                    }

                    // 발주번호1
                    if (sWOPONUM1.toString() != "") {
                        // DB 체크
                        // 4.
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            if (i == 3) {
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] != "4") {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="발주번호1을 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }
                    }

                    // 발주번호2
                    if (sWOPONUM2.toString() != "") {
                        // DB 체크
                        // 5.
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            if (i == 4) {
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] != "5") {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="발주번호2를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }
                    }

                    // 발주번호3
                    if (sWOPONUM3.toString() != "") {
                        // DB 체크
                        // 6.
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            if (i == 5) {
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] != "6") {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="발주번호3을 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }
                    }

                    // 발주번호4
                    if (sWOPONUM4.toString() != "") {
                        // DB 체크
                        // 7.
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            if (i == 6) {
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] != "7") {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="발주번호4를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }
                    }

                    // 발주번호5
                    if (sWOPONUM5.toString() != "") {
                        // DB 체크
                        // 8.
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            if (i == 7) {
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] != "8") {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="발주번호5를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }
                    }

                    // 설비코드1
                    if (sWOLOCATIONCODE1.toString() != "") {

                        if (sWOLOCATIONCODE1.length == 10) {
                            // DB 체크
                            // 9.
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                if (i == 8) {
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "9") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                            pnlWOLOCATIONCODE1.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                            break;
                                        }
                                        else {
                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드1을 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드1을 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드1을 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 설비코드2
                    if (sWOLOCATIONCODE2.toString() != "") {
                        if (sWOLOCATIONCODE2.length == 10) {
                            // DB 체크
                            // 10.

                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                if (i == 9) {
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "10") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                            pnlWOLOCATIONCODE2.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                            break;
                                        }
                                        else {
                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드2를 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드2를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }
                        }
                        else {
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드2를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 설비코드3
                    if (sWOLOCATIONCODE3.toString() != "") {
                        if (sWOLOCATIONCODE3.length == 10) {
                            // DB 체크
                            // 11.

                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                if (i == 10) {
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "11") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                            pnlWOLOCATIONCODE3.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                            break;
                                        }
                                        else {
                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드3을 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드3을 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드3을 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 설비코드4
                    if (sWOLOCATIONCODE4.toString() != "") {
                        if (sWOLOCATIONCODE4.length == 10) {
                            // DB 체크
                            // 12.

                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                if (i == 11) {
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "12") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                            pnlWOLOCATIONCODE4.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                            break;
                                        }
                                        else {
                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드4를 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드4를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드4를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 설비코드5
                    if (sWOLOCATIONCODE5.toString() != "") {
                        if (sWOLOCATIONCODE5.length == 10) {
                            // DB 체크
                            // 13.

                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                if (i == 12) {
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "13") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                            pnlWOLOCATIONCODE5.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                            break;
                                        }
                                        else {
                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드5를 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드5를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드5를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }




                    // 구역 코드            
                    if (sWOAREACODE1.toString() == "") {
                        if (sWOAREACODE2.toString() != "" || sWOAREACODE3.toString() != "" || sWOAREACODE4.toString() != "" || sWOAREACODE5.toString() != "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역 코드를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (sWOAREACODE2.toString() == "") {
                        if (sWOAREACODE3.toString() != "" || sWOAREACODE4.toString() != "" || sWOAREACODE5.toString() != "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역 코드를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (sWOAREACODE3.toString() == "") {
                        if (sWOAREACODE4.toString() != "" || sWOAREACODE5.toString() != "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역 코드를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (sWOAREACODE4.toString() == "") {
                        if (sWOAREACODE5.toString() != "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역 코드를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 구역코드1
                    if (sWOAREACODE1.toString() != "") {
                        if (sWOAREACODE1.length == 9) {
                            // DB 체크
                            // 14.

                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                if (i == 13) {
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "14") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                            pnlWOAREACODE1.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                            break;
                                        }
                                        else {
                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드1을 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드1을 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드1을 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 구역코드2
                    if (sWOAREACODE2.toString() != "") {
                        if (sWOAREACODE2.length == 9) {
                            // DB 체크
                            // 15.

                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                if (i == 14) {
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "15") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                            pnlWOAREACODE2.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                            break;
                                        }
                                        else {
                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드2를 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드2를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드2를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 구역코드3
                    if (sWOAREACODE3.toString() != "") {
                        if (sWOAREACODE3.length == 9) {
                            // DB 체크
                            // 16.

                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                if (i == 15) {
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "16") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                            pnlWOAREACODE3.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                            break;
                                        }
                                        else {
                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드3을 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드3을 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드3을 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 구역코드4
                    if (sWOAREACODE4.toString() != "") {
                        if (sWOAREACODE4.length == 9) {
                            // DB 체크
                            // 17.

                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                if (i == 16) {
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "17") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                            pnlWOAREACODE4.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                            break;
                                        }
                                        else {
                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드4를 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드4를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드4를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 구역코드5
                    if (sWOAREACODE5.toString() != "") {
                        if (sWOAREACODE5.length == 9) {
                            // DB 체크
                            // 18.

                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                if (i == 17) {
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "18") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                            pnlWOAREACODE5.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);
                                            break;
                                        }
                                        else {
                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드5를 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드5를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드5를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (sWOLOCATIONCODE1.toString() != "" && sWOLOCATIONCODE2.toString() != "" && sWOLOCATIONCODE3.toString() != "" && sWOLOCATIONCODE4.toString() != "" && sWOLOCATIONCODE5.toString() != "") {
                        if ((sWOLOCATIONCODE1.toString().substr(0, 1) != sWOLOCATIONCODE2.toString().substr(0, 1)) ||
                            (sWOLOCATIONCODE1.toString().substr(0, 1) != sWOLOCATIONCODE3.toString().substr(0, 1)) ||
                            (sWOLOCATIONCODE1.toString().substr(0, 1) != sWOLOCATIONCODE4.toString().substr(0, 1)) ||
                            (sWOLOCATIONCODE1.toString().substr(0, 1) != sWOLOCATIONCODE5.toString().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (sWOLOCATIONCODE1.toString() != "" && sWOLOCATIONCODE2.toString() != "" && sWOLOCATIONCODE3.toString() != "" && sWOLOCATIONCODE4.toString() != "") {
                        if ((sWOLOCATIONCODE1.toString().substr(0, 1) != sWOLOCATIONCODE2.toString().substr(0, 1)) ||
                            (sWOLOCATIONCODE1.toString().substr(0, 1) != sWOLOCATIONCODE3.toString().substr(0, 1)) ||
                            (sWOLOCATIONCODE1.toString().substr(0, 1) != sWOLOCATIONCODE4.toString().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (sWOLOCATIONCODE1.toString() != "" && sWOLOCATIONCODE2.toString() != "" && sWOLOCATIONCODE3.toString() != "") {
                        if ((sWOLOCATIONCODE1.toString().substr(0, 1) != sWOLOCATIONCODE2.toString().substr(0, 1)) ||
                            (sWOLOCATIONCODE1.toString().substr(0, 1) != sWOLOCATIONCODE3.toString().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (sWOLOCATIONCODE1.toString() != "" && sWOLOCATIONCODE2.toString() != "") {
                        if ((sWOLOCATIONCODE1.toString().substr(0, 1) != sWOLOCATIONCODE2.toString().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (sWOAREACODE1.toString() != "" && sWOAREACODE2.toString() != "" && sWOAREACODE3.toString() != "" && sWOAREACODE4.toString() != "" && sWOAREACODE5.toString() != "") {
                        if ((sWOAREACODE1.toString().substr(0, 1) != sWOAREACODE2.toString().substr(0, 1)) ||
                            (sWOAREACODE1.toString().substr(0, 1) != sWOAREACODE3.toString().substr(0, 1)) ||
                            (sWOAREACODE1.toString().substr(0, 1) != sWOAREACODE4.toString().substr(0, 1)) ||
                            (sWOAREACODE1.toString().substr(0, 1) != sWOAREACODE5.toString().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (sWOAREACODE1.toString() != "" && sWOAREACODE2.toString() != "" && sWOAREACODE3.toString() != "" && sWOAREACODE4.toString() != "") {
                        if ((sWOAREACODE1.toString().substr(0, 1) != sWOAREACODE2.toString().substr(0, 1)) ||
                            (sWOAREACODE1.toString().substr(0, 1) != sWOAREACODE3.toString().substr(0, 1)) ||
                            (sWOAREACODE1.toString().substr(0, 1) != sWOAREACODE4.toString().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (sWOAREACODE1.toString() != "" && sWOAREACODE2.toString() != "" && sWOAREACODE3.toString() != "") {
                        if ((sWOAREACODE1.toString().substr(0, 1) != sWOAREACODE2.toString().substr(0, 1)) ||
                            (sWOAREACODE1.toString().substr(0, 1) != sWOAREACODE3.toString().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (sWOAREACODE1.toString() != "" && sWOAREACODE2.toString() != "") {
                        if ((sWOAREACODE1.toString().substr(0, 1) != sWOAREACODE2.toString().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 설비코드 및 구역
                    if (sWOLOCATIONCODE1.toString() != "" && sWOAREACODE1.toString() != "") {
                        if (sWOLOCATIONCODE1.toString().substr(0, 1) != sWOAREACODE1.toString().substr(0, 1)) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="구역코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 설비코드 및 구역
                    if (sWOLOCATIONCODE2.toString() != "" && sWOAREACODE2.toString() != "") {
                        if (sWOLOCATIONCODE2.toString().substr(0, 1) != sWOAREACODE2.toString().substr(0, 1)) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드 및 구역의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 설비코드 및 구역
                    if (sWOLOCATIONCODE3.toString() != "" && sWOAREACODE3.toString() != "") {
                        if (sWOLOCATIONCODE3.toString().substr(0, 1) != sWOAREACODE3.toString().substr(0, 1)) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드 및 구역의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 설비코드 및 구역
                    if (sWOLOCATIONCODE4.toString() != "" && sWOAREACODE4.toString() != "") {
                        if (sWOLOCATIONCODE4.toString().substr(0, 1) != sWOAREACODE4.toString().substr(0, 1)) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드 및 구역의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 설비코드 및 구역
                    if (sWOLOCATIONCODE5.toString() != "" && sWOAREACODE5.toString() != "") {
                        if (sWOLOCATIONCODE5.toString().substr(0, 1) != sWOAREACODE5.toString().substr(0, 1)) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드 및 구역의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 작업명
                    if (sWOWORKTITLE.toString() == "") {

                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업명을 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    if (sGUBUN.toString() == "APPROVAL") {
                        if (sWOAPPSOSABUN1.toString() == "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청 결재선을 지정하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }

                        if (sWOAPPRESABUN1.toString() == "") {


                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="수신 결재선을 지정하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    for (var i = 0; i < FILEUPLOAD[0].uploader.files.length; i++) {

                        //10메가 제한
                        if (FILEUPLOAD[0].uploader.files[i].size > 10000000) {
                            alert("첨부파일은 10메가를 초과할수 없습니다!");
                            return;
                        }
                    }

                    var iSO_COUNT = 0;
                    var iRE_COUNT = 0;

                    if (sWOAPPSOSABUN5.toString() != "") {
                        iSO_COUNT = 5;
                    }
                    else if (sWOAPPSOSABUN4.toString() != "") {
                        iSO_COUNT = 4;
                    }
                    else if (sWOAPPSOSABUN3.toString() != "") {
                        iSO_COUNT = 3;
                    }
                    else if (sWOAPPSOSABUN2.toString() != "") {
                        iSO_COUNT = 2;
                    }
                    else if (sWOAPPSOSABUN1.toString() != "") {
                        iSO_COUNT = 1;
                    }

                    if (sWOAPPRESABUN5.toString() != "") {
                        iRE_COUNT = 5;
                    }
                    else if (sWOAPPRESABUN4.toString() != "") {
                        iRE_COUNT = 4;
                    }
                    else if (sWOAPPRESABUN3.toString() != "") {
                        iRE_COUNT = 3;
                    }
                    else if (sWOAPPRESABUN2.toString() != "") {
                        iRE_COUNT = 2;
                    }
                    else if (sWOAPPRESABUN1.toString() != "") {
                        iRE_COUNT = 1;
                    }


                    //if (iSO_COUNT == parseInt(Get_Numeric(sSOApproval.toString())) + 1) // 요청 마지막 결재자
                    //{
                    //    iSO_COUNT = iSO_COUNT;
                    //}
                    //else // 요청 다음 결재자
                    //{
                    //    if (iSO_COUNT != parseInt(Get_Numeric(sSOApproval.toString()))) {
                    //        if (sSOApproval.toString() == "") {
                    //            iSO_COUNT = 1;
                    //        }
                    //        else if (sSOApproval.toString() == "1") {
                    //            iSO_COUNT = 2;
                    //        }
                    //        else if (sSOApproval.toString() == "2") {
                    //            iSO_COUNT = 3;
                    //        }
                    //        else if (sSOApproval.toString() == "3") {
                    //            iSO_COUNT = 4;
                    //        }
                    //        else if (sSOApproval.toString() == "4") {
                    //            iSO_COUNT = 5;
                    //        }
                    //    }
                    //}

                    //if (iSO_COUNT == parseInt(Get_Numeric(sSOApproval.toString()))) {
                    //    if (iRE_COUNT == parseInt(Get_Numeric(sREApproval.toString())) + 1) // 수신 마지막 결재자
                    //    {
                    //        iSO_COUNT = 0;

                    //        iRE_COUNT = iRE_COUNT;
                    //    }
                    //    else // 수신 다음 결재자
                    //    {
                    //        iSO_COUNT = 0;

                    //        if (sREApproval.toString() == "") {
                    //            iRE_COUNT = 1;
                    //        }
                    //        else if (sREApproval.toString() == "1") {
                    //            iRE_COUNT = 2;
                    //        }
                    //        else if (sREApproval.toString() == "2") {
                    //            iRE_COUNT = 3;
                    //        }
                    //        else if (sREApproval.toString() == "3") {
                    //            iRE_COUNT = 4;
                    //        }
                    //        else if (sREApproval.toString() == "4") {
                    //            iRE_COUNT = 5;
                    //        }
                    //    }
                    //}

                    if (fshdnExists.toString() == "NEW") {

                        ht["P_WOORTEAM"] = sWOORTEAM.toString();
                        ht["P_WOORDATE"] = sWOORDATE.toString();

                        PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_PSM4011_GET_MAX_WOSEQ", function (e) {

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                                txtWOSEQ.SetValue(DataSet.Tables[0].Rows[0]["WOSEQ"]);

                                sWOSEQ = txtWOSEQ.GetValue();

                                var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                                // 저장
                                // 순번 값 가져오고 난후 저장
                                ht1["P_WOORTEAM"]        = sWOORTEAM.toString();                                      
                                ht1["P_WOORDATE"]        = sWOORDATE.toString();
                                ht1["P_WOSEQ"]           = sWOSEQ.toString();
                                ht1["P_WOORSABUN"]       = sWOORSABUN.toString();
                                ht1["P_WOWORKTITLE"]     = sWOWORKTITLE.toString();
                                ht1["P_WOLOCATIONCODE1"] = sWOLOCATIONCODE1.toString();
                                ht1["P_WOLOCATIONCODE2"] = sWOLOCATIONCODE2.toString();
                                ht1["P_WOLOCATIONCODE3"] = sWOLOCATIONCODE3.toString();
                                ht1["P_WOLOCATIONCODE4"] = sWOLOCATIONCODE4.toString();
                                ht1["P_WOLOCATIONCODE5"] = sWOLOCATIONCODE5.toString();
                                ht1["P_WOAREACODE1"]     = sWOAREACODE1.toString();
                                ht1["P_WOAREACODE2"]     = sWOAREACODE2.toString();
                                ht1["P_WOAREACODE3"]     = sWOAREACODE3.toString();
                                ht1["P_WOAREACODE4"]     = sWOAREACODE4.toString();
                                ht1["P_WOAREACODE5"]     = sWOAREACODE5.toString();
                                ht1["P_WODSDATE1"]       = sWODSDATE1.toString();
                                ht1["P_WODSDATE2"]       = sWODSDATE2.toString();
                                ht1["P_WOSOTEAM"]        = sWOSOTEAM.toString();
                                ht1["P_WORETEAM"]        = sWORETEAM.toString();
                                ht1["P_WOSAFESABUN"]     = sWOSAFESABUN.toString();
                                ht1["P_WOCHANGEWKJOB"]   = sWOCHANGEWKJOB.toString();
                                ht1["P_WOCHANGEWKDIV"]   = sWOCHANGEWKDIV.toString();
                                ht1["P_WOAPPSOSABUN1"]   = sWOAPPSOSABUN1.toString();
                                ht1["P_WOAPPSONAME1"]    = sWOAPPSONAME1.toString();
                                ht1["P_WOAPPSOJKCD1"]    = sWOAPPSOJKCD1.toString();
                                ht1["P_WOAPPSOJKCDNM1"]  = sWOAPPSOJKCDNM1.toString();
                                ht1["P_WOAPPSOCOMMENT1"] = sWOAPPSOCOMMENT1.toString();
                                ht1["P_WOAPPSOSABUN2"]   = sWOAPPSOSABUN2.toString();
                                ht1["P_WOAPPSONAME2"]    = sWOAPPSONAME2.toString();
                                ht1["P_WOAPPSOJKCD2"]    = sWOAPPSOJKCD2.toString();
                                ht1["P_WOAPPSOJKCDNM2"]  = sWOAPPSOJKCDNM2.toString();
                                ht1["P_WOAPPSOCOMMENT2"] = sWOAPPSOCOMMENT2.toString();
                                ht1["P_WOAPPSOSABUN3"]   = sWOAPPSOSABUN3.toString();
                                ht1["P_WOAPPSONAME3"]    = sWOAPPSONAME3.toString();
                                ht1["P_WOAPPSOJKCD3"]    = sWOAPPSOJKCD3.toString();
                                ht1["P_WOAPPSOJKCDNM3"]  = sWOAPPSOJKCDNM3.toString();
                                ht1["P_WOAPPSOCOMMENT3"] = sWOAPPSOCOMMENT3.toString();
                                ht1["P_WOAPPSOSABUN4"]   = sWOAPPSOSABUN4.toString();
                                ht1["P_WOAPPSONAME4"]    = sWOAPPSONAME4.toString();
                                ht1["P_WOAPPSOJKCD4"]    = sWOAPPSOJKCD4.toString();
                                ht1["P_WOAPPSOJKCDNM4"]  = sWOAPPSOJKCDNM4.toString();
                                ht1["P_WOAPPSOCOMMENT4"] = sWOAPPSOCOMMENT4.toString();
                                ht1["P_WOAPPSOSABUN5"]   = sWOAPPSOSABUN5.toString();
                                ht1["P_WOAPPSONAME5"]    = sWOAPPSONAME5.toString();
                                ht1["P_WOAPPSOJKCD5"]    = sWOAPPSOJKCD5.toString();
                                ht1["P_WOAPPSOJKCDNM5"]  = sWOAPPSOJKCDNM5.toString();
                                ht1["P_WOAPPSOCOMMENT5"] = sWOAPPSOCOMMENT5.toString();
                                ht1["P_WOAPPRESABUN1"]   = sWOAPPRESABUN1.toString();
                                ht1["P_WOAPPRENAME1"]    = sWOAPPRENAME1.toString();
                                ht1["P_WOAPPREJKCD1"]    = sWOAPPREJKCD1.toString();
                                ht1["P_WOAPPREJKCDNM1"]  = sWOAPPREJKCDNM1.toString();
                                ht1["P_WOAPPRECOMMENT1"] = sWOAPPRECOMMENT1.toString();
                                ht1["P_WOAPPRESABUN2"]   = sWOAPPRESABUN2.toString();
                                ht1["P_WOAPPRENAME2"]    = sWOAPPRENAME2.toString();
                                ht1["P_WOAPPREJKCD2"]    = sWOAPPREJKCD2.toString();
                                ht1["P_WOAPPREJKCDNM2"]  = sWOAPPREJKCDNM2.toString();
                                ht1["P_WOAPPRECOMMENT2"] = sWOAPPRECOMMENT2.toString();
                                ht1["P_WOAPPRESABUN3"]   = sWOAPPRESABUN3.toString();
                                ht1["P_WOAPPRENAME3"]    = sWOAPPRENAME3.toString();
                                ht1["P_WOAPPREJKCD3"]    = sWOAPPREJKCD3.toString();
                                ht1["P_WOAPPREJKCDNM3"]  = sWOAPPREJKCDNM3.toString();
                                ht1["P_WOAPPRECOMMENT3"] = sWOAPPRECOMMENT3.toString();
                                ht1["P_WOAPPRESABUN4"]   = sWOAPPRESABUN4.toString();
                                ht1["P_WOAPPRENAME4"]    = sWOAPPRENAME4.toString();
                                ht1["P_WOAPPREJKCD4"]    = sWOAPPREJKCD4.toString();
                                ht1["P_WOAPPREJKCDNM4"]  = sWOAPPREJKCDNM4.toString();
                                ht1["P_WOAPPRECOMMENT4"] = sWOAPPRECOMMENT4.toString();
                                ht1["P_WOAPPRESABUN5"]   = sWOAPPRESABUN5.toString();
                                ht1["P_WOAPPRENAME5"]    = sWOAPPRENAME5.toString();
                                ht1["P_WOAPPREJKCD5"]    = sWOAPPREJKCD5.toString();
                                ht1["P_WOAPPREJKCDNM5"]  = sWOAPPREJKCDNM5.toString();
                                ht1["P_WOAPPRECOMMENT5"] = sWOAPPRECOMMENT5.toString();
                                ht1["P_WOGRDOC1"]        = sWOGRDOC1.toString();
                                ht1["P_WOGRURL1"]        = sWOGRURL1.toString();
                                ht1["P_WOGRDOC2"]        = sWOGRDOC2.toString();
                                ht1["P_WOGRURL2"]        = sWOGRURL2.toString();
                                ht1["P_WOSTATUS"]        = '1';
                                ht1["P_WOWORKDOC"]       = sWOWORKDOC.toString();
                                ht1["P_WOPONUM1"]        = sWOPONUM1.toString();
                                ht1["P_WOPONUM2"]        = sWOPONUM2.toString();
                                ht1["P_WOPONUM3"]        = sWOPONUM3.toString();
                                ht1["P_WOPONUM4"]        = sWOPONUM4.toString();
                                ht1["P_WOPONUM5"]        = sWOPONUM5.toString();
                                ht1["P_WOHISAB"]         = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
                                ht1["P_RESABUN"]         = fsRESABUN;
                                /*ht1["P_RESABUN"] = txtRESABUN.GetValue();*/
                                ht1["P_RENAME"]          = txtRENAME.GetValue();
                                ht1["P_SOCOUNT"]         = iSO_COUNT;
                                ht1["P_RECOUNT"]         = iRE_COUNT;
                                ht1["P_SOAPPROVAL"]      = Get_Numeric(sSOApproval);
                                ht1["P_REAPPROVAL"]      = Get_Numeric(sREApproval);
                                ht1["P_GUBUN"]           = sGUBUN;

                                PageMethods.InvokeServiceTable(ht1, "PSM.PSM4010", "UP_WORKORDER_APPROVAL", function (e) {

                                    var DataSet1 = eval(e);

                                    if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                                        // 첨부파일 저장
                                        UploadStart(GetAttachFile_Callback);

                                        fshdnExists = "EXISTS";

                                        if (sGUBUN.toString() == "APPROVAL") {

                                            // 메일수신자 가져오기
                                            sKBSABUN = fn_GET_Mail_Sabun(iSO_COUNT, sSOApproval, iRE_COUNT, sREApproval,
                                                sWOAPPSOSABUN1, sWOAPPSOSABUN2, sWOAPPSOSABUN3, sWOAPPSOSABUN4, sWOAPPSOSABUN5,
                                                sWOAPPRESABUN1, sWOAPPRESABUN2, sWOAPPRESABUN3, sWOAPPRESABUN4, sWOAPPRESABUN5);

                                            txtWOORTEAM.SetValue(sWOORTEAM);
                                            txtWOORDATE.SetValue(sWOORDATE.substr(0, 4) + "-" + sWOORDATE.substr(4, 2) + "-" + sWOORDATE.substr(6, 2));
                                            txtWOSEQ.SetValue(sWOSEQ);

                                            // 결재 사인 DISPLAY
                                            fn_APPROVAL_Display(sWOORTEAM.toString(), sWOORDATE.toString(), sWOSEQ.toString(), "", sKBSABUN.toString(), "OK", sFinish);

                                            //if (sFinish == "FINISH") {

                                            //    debugger;

                                            //    fn_FINISH_UPT();
                                            //}

                                            //// 메일 발송
                                            //fn_Mail_Send(sWOORTEAM.toString(), sWOORDATE.toString(), sWOSEQ.toString(), "", sKBSABUN.toString(), "OK", sFinish);

                                            // READONLY 해야 함
                                            fn_ReadOnly();

                                            fn_Btn_Visible('3');

                                            /*alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');*/
                                        }
                                        else {
                                            fn_Field_ReadOnly(false, false, true);

                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 처리 되었습니다." Literal="true"></Ctl:Text>');
                                        }
                                    }

                                }, function (e) {
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                });
                            }
                        }, function (e) {
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        });
                    }
                    else {

                        var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                        ht1["P_WOORTEAM"]        = sWOORTEAM.toString();
                        ht1["P_WOORDATE"]        = sWOORDATE.toString();
                        ht1["P_WOSEQ"]           = sWOSEQ.toString();
                        ht1["P_WOORSABUN"]       = sWOORSABUN.toString();
                        ht1["P_WOWORKTITLE"]     = sWOWORKTITLE.toString();
                        ht1["P_WOLOCATIONCODE1"] = sWOLOCATIONCODE1.toString();
                        ht1["P_WOLOCATIONCODE2"] = sWOLOCATIONCODE2.toString();
                        ht1["P_WOLOCATIONCODE3"] = sWOLOCATIONCODE3.toString();
                        ht1["P_WOLOCATIONCODE4"] = sWOLOCATIONCODE4.toString();
                        ht1["P_WOLOCATIONCODE5"] = sWOLOCATIONCODE5.toString();
                        ht1["P_WOAREACODE1"]     = sWOAREACODE1.toString();
                        ht1["P_WOAREACODE2"]     = sWOAREACODE2.toString();
                        ht1["P_WOAREACODE3"]     = sWOAREACODE3.toString();
                        ht1["P_WOAREACODE4"]     = sWOAREACODE4.toString();
                        ht1["P_WOAREACODE5"]     = sWOAREACODE5.toString();
                        ht1["P_WODSDATE1"]       = sWODSDATE1.toString();
                        ht1["P_WODSDATE2"]       = sWODSDATE2.toString();
                        ht1["P_WOSOTEAM"]        = sWOSOTEAM.toString();
                        ht1["P_WORETEAM"]        = sWORETEAM.toString();
                        ht1["P_WOSAFESABUN"]     = sWOSAFESABUN.toString();
                        ht1["P_WOCHANGEWKJOB"]   = sWOCHANGEWKJOB.toString();
                        ht1["P_WOCHANGEWKDIV"]   = sWOCHANGEWKDIV.toString();
                        ht1["P_WOAPPSOSABUN1"]   = sWOAPPSOSABUN1.toString();
                        ht1["P_WOAPPSONAME1"]    = sWOAPPSONAME1.toString();
                        ht1["P_WOAPPSOJKCD1"]    = sWOAPPSOJKCD1.toString();
                        ht1["P_WOAPPSOJKCDNM1"]  = sWOAPPSOJKCDNM1.toString();
                        ht1["P_WOAPPSOCOMMENT1"] = sWOAPPSOCOMMENT1.toString();
                        ht1["P_WOAPPSOSABUN2"]   = sWOAPPSOSABUN2.toString();
                        ht1["P_WOAPPSONAME2"]    = sWOAPPSONAME2.toString();
                        ht1["P_WOAPPSOJKCD2"]    = sWOAPPSOJKCD2.toString();
                        ht1["P_WOAPPSOJKCDNM2"]  = sWOAPPSOJKCDNM2.toString();
                        ht1["P_WOAPPSOCOMMENT2"] = sWOAPPSOCOMMENT2.toString();
                        ht1["P_WOAPPSOSABUN3"]   = sWOAPPSOSABUN3.toString();
                        ht1["P_WOAPPSONAME3"]    = sWOAPPSONAME3.toString();
                        ht1["P_WOAPPSOJKCD3"]    = sWOAPPSOJKCD3.toString();
                        ht1["P_WOAPPSOJKCDNM3"]  = sWOAPPSOJKCDNM3.toString();
                        ht1["P_WOAPPSOCOMMENT3"] = sWOAPPSOCOMMENT3.toString();
                        ht1["P_WOAPPSOSABUN4"]   = sWOAPPSOSABUN4.toString();
                        ht1["P_WOAPPSONAME4"]    = sWOAPPSONAME4.toString();
                        ht1["P_WOAPPSOJKCD4"]    = sWOAPPSOJKCD4.toString();
                        ht1["P_WOAPPSOJKCDNM4"]  = sWOAPPSOJKCDNM4.toString();
                        ht1["P_WOAPPSOCOMMENT4"] = sWOAPPSOCOMMENT4.toString();
                        ht1["P_WOAPPSOSABUN5"]   = sWOAPPSOSABUN5.toString();
                        ht1["P_WOAPPSONAME5"]    = sWOAPPSONAME5.toString();
                        ht1["P_WOAPPSOJKCD5"]    = sWOAPPSOJKCD5.toString();
                        ht1["P_WOAPPSOJKCDNM5"]  = sWOAPPSOJKCDNM5.toString();
                        ht1["P_WOAPPSOCOMMENT5"] = sWOAPPSOCOMMENT5.toString();
                        ht1["P_WOAPPRESABUN1"]   = sWOAPPRESABUN1.toString();
                        ht1["P_WOAPPRENAME1"]    = sWOAPPRENAME1.toString();
                        ht1["P_WOAPPREJKCD1"]    = sWOAPPREJKCD1.toString();
                        ht1["P_WOAPPREJKCDNM1"]  = sWOAPPREJKCDNM1.toString();
                        ht1["P_WOAPPRECOMMENT1"] = sWOAPPRECOMMENT1.toString();
                        ht1["P_WOAPPRESABUN2"]   = sWOAPPRESABUN2.toString();
                        ht1["P_WOAPPRENAME2"]    = sWOAPPRENAME2.toString();
                        ht1["P_WOAPPREJKCD2"]    = sWOAPPREJKCD2.toString();
                        ht1["P_WOAPPREJKCDNM2"]  = sWOAPPREJKCDNM2.toString();
                        ht1["P_WOAPPRECOMMENT2"] = sWOAPPRECOMMENT2.toString();
                        ht1["P_WOAPPRESABUN3"]   = sWOAPPRESABUN3.toString();
                        ht1["P_WOAPPRENAME3"]    = sWOAPPRENAME3.toString();
                        ht1["P_WOAPPREJKCD3"]    = sWOAPPREJKCD3.toString();
                        ht1["P_WOAPPREJKCDNM3"]  = sWOAPPREJKCDNM3.toString();
                        ht1["P_WOAPPRECOMMENT3"] = sWOAPPRECOMMENT3.toString();
                        ht1["P_WOAPPRESABUN4"]   = sWOAPPRESABUN4.toString();
                        ht1["P_WOAPPRENAME4"]    = sWOAPPRENAME4.toString();
                        ht1["P_WOAPPREJKCD4"]    = sWOAPPREJKCD4.toString();
                        ht1["P_WOAPPREJKCDNM4"]  = sWOAPPREJKCDNM4.toString();
                        ht1["P_WOAPPRECOMMENT4"] = sWOAPPRECOMMENT4.toString();
                        ht1["P_WOAPPRESABUN5"]   = sWOAPPRESABUN5.toString();
                        ht1["P_WOAPPRENAME5"]    = sWOAPPRENAME5.toString();
                        ht1["P_WOAPPREJKCD5"]    = sWOAPPREJKCD5.toString();
                        ht1["P_WOAPPREJKCDNM5"]  = sWOAPPREJKCDNM5.toString();
                        ht1["P_WOAPPRECOMMENT5"] = sWOAPPRECOMMENT5.toString();
                        ht1["P_WOGRDOC1"]        = sWOGRDOC1.toString();
                        ht1["P_WOGRURL1"]        = sWOGRURL1.toString();
                        ht1["P_WOGRDOC2"]        = sWOGRDOC2.toString();
                        ht1["P_WOGRURL2"]        = sWOGRURL2.toString();
                        ht1["P_WOSTATUS"]        = '1';
                        ht1["P_WOWORKDOC"]       = sWOWORKDOC.toString();
                        ht1["P_WOPONUM1"]        = sWOPONUM1.toString();
                        ht1["P_WOPONUM2"]        = sWOPONUM2.toString();
                        ht1["P_WOPONUM3"]        = sWOPONUM3.toString();
                        ht1["P_WOPONUM4"]        = sWOPONUM4.toString();
                        ht1["P_WOPONUM5"]        = sWOPONUM5.toString();
                        ht1["P_WOHISAB"]         = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
                        ht1["P_RESABUN"]         = fsRESABUN.toString();
                        /*ht1["P_RESABUN"]         = txtRESABUN.GetValue();*/
                        ht1["P_RENAME"]          = txtRENAME.GetValue();
                        ht1["P_SOCOUNT"]         = iSO_COUNT;
                        ht1["P_RECOUNT"]         = iRE_COUNT;
                        ht1["P_SOAPPROVAL"]      = sSOApproval;
                        ht1["P_REAPPROVAL"]      = sREApproval;
                        ht1["P_GUBUN"]           = sGUBUN;

                        PageMethods.InvokeServiceTable(ht1, "PSM.PSM4010", "UP_WORKORDER_APPROVAL", function (e) {

                            fshdnExists = "EXISTS";

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                                // 첨부파일 저장
                                UploadStart(GetAttachFile_Callback);

                                if (sGUBUN.toString() == "APPROVAL") {

                                    // 메일수신자 가져오기
                                    sKBSABUN = fn_GET_Mail_Sabun(iSO_COUNT, sSOApproval, iRE_COUNT, sREApproval,
                                        sWOAPPSOSABUN1, sWOAPPSOSABUN2, sWOAPPSOSABUN3, sWOAPPSOSABUN4, sWOAPPSOSABUN5,
                                        sWOAPPRESABUN1, sWOAPPRESABUN2, sWOAPPRESABUN3, sWOAPPRESABUN4, sWOAPPRESABUN5);

                                    txtWOORTEAM.SetValue(sWOORTEAM);
                                    txtWOORDATE.SetValue(sWOORDATE.substr(0, 4) + "-" + sWOORDATE.substr(4, 2) + "-" + sWOORDATE.substr(6, 2));
                                    txtWOSEQ.SetValue(sWOSEQ);

                                    // 결재 사인 DISPLAY
                                    fn_APPROVAL_Display(sWOORTEAM.toString(), sWOORDATE.toString(), sWOSEQ.toString(), "", sKBSABUN.toString(), "OK", sFinish);

                                    //if (sFinish == "FINISH") {

                                    //    debugger;

                                    //    fn_FINISH_UPT();
                                    //}

                                    //// 메일 발송
                                    //fn_Mail_Send(sWOORTEAM.toString(), sWOORDATE.toString(), sWOSEQ.toString(), "", sKBSABUN.toString(), "OK", sFinish);

                                    // READONLY 해야 함
                                    fn_ReadOnly();

                                    fn_Btn_Visible('3');

                                    /*alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');*/
                                }
                                else {

                                    fn_Field_ReadOnly(false, false, true);

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 처리 되었습니다." Literal="true"></Ctl:Text>');
                                }
                            }

                        }, function (e) {
                            //// Biz 연결오류
                            if (sGUBUN.toString() == "APPROVAL") {
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                            }
                            else {
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                            }

                        });

                        fshdnExists = "EXISTS";
                    }
                }
            }, function (e) {
                // Biz 연결오류

                alert(e.get_message());
                alert('<Ctl:Text runat="server" Description="필드 체크 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

        function GetAttachFile_Callback() {

            debugger;

            var WKNUM = "";

            WKNUM = txtWOORTEAM.GetValue() + Get_Date(txtWOORDATE.GetValue().replace("-", "")) + Set_Fill3(txtWOSEQ.GetValue());

            fuName1.FileSave("WK", WKNUM.toString(), function () { });

            // 첨부파일 load
            AttachFileLod();
        }

        function AttachFileLod() {

            debugger;

            var WKNUM = "";

            WKNUM = txtWOORTEAM.GetValue() + Get_Date(txtWOORDATE.GetValue().replace("-", "")) + Set_Fill3(txtWOSEQ.GetValue());


            if (document.getElementById("fuName1_filedata").value != "") {
                var item = document.getElementById("fuName1_filedata").value;
                item = item.split("^");

                for (var i = 0; i < item.length - 1; i++) {

                    var data = item[i].split("|");
                    var sht = new Object();

                    // 0: 실제파일명, 1: 파일사이즈, 2:파일 타입, 3:파일경로, 4:파일 확장자, 5: 저장파일명
                    sht["IMGFILENAME"] = data[0];                             // 실제 파일명
                    sht["IMGFILESIZE"] = data[1];                             // 파일 사이즈
                    sht["FILE_PATH"]   = data[3];                             // 파일 경로
                }
            }

            document.getElementById("fuName1_filedata").value = "";

            fuName1.FileLoad("WK", WKNUM, function () {
                // 로드완료

                // 프로그래스바 닫기
                PageProgressHide();
            });

        }


        function fn_Mail_Send(sWOORTEAM, sWOORDATE, sWOSEQ, sWOCANCELCOMMENT, sMail_Receiver, sGUBUN, sFinish) {

            var sTitle     = "";

            var sPGURL     = "";
            var sWOWORKDOC = "";
            var sAPNUM     = "";

            var iSO_COUNT = 0;
            var iRE_COUNT = 0;

            sAPNUM = sWOORTEAM.toString() + "-" + sWOORDATE.toString() + "-" + Set_Fill3(sWOSEQ.toString());

            //sPGURL = "/Portal/PSM/PSM40/PSM4011.aspx?";
            //sPGURL = sPGURL + "APP_NUM=";
            //sPGURL = sPGURL + sAPNUM;
            //sPGURL = sPGURL + "^GUBUN=G";

            sPGURL = "/Portal/PSM/PSM40/PSM4011.aspx?";
            sPGURL = sPGURL + "param=UPT&param1=";
            sPGURL = sPGURL + sAPNUM;

            if (sGUBUN == 'OK') {

                if (txtWOAPPRESABUN5.GetValue() != "") {
                    iRE_COUNT = 5;
                }
                else if (txtWOAPPRESABUN4.GetValue() != "") {
                    iRE_COUNT = 4;
                }
                else if (txtWOAPPRESABUN3.GetValue() != "") {
                    iRE_COUNT = 3;
                }
                else if (txtWOAPPRESABUN2.GetValue() != "") {
                    iRE_COUNT = 2;
                }
                else if (txtWOAPPRESABUN1.GetValue() != "") {
                    iRE_COUNT = 1;
                }

                if (parseInt(Get_Numeric(fshdnREApproval)) == iRE_COUNT) {
                    if (sFinish != "FINISH") {
                        sTitle = txtWOWORKTITLE.GetValue() + " - 작업요청서 완료";
                    }
                    else {
                        sTitle = txtWOWORKTITLE.GetValue() + " - 작업요청서 즉시조치 완료";
                    }

                    sWOWORKDOC = txtWOWORKDOC.GetValue();
                }
                else {
                    sTitle = txtWOWORKTITLE.GetValue() + " - 작업요청서 제출";
                }
            }
            else {
                sTitle = txtWOWORKTITLE.GetValue() + " - 작업요청서 취소";
            }

            if (txtWOAPPSOSABUN5.GetValue() != "") {
                iSO_COUNT = 5;
            }
            else if (txtWOAPPSOSABUN4.GetValue() != "") {
                iSO_COUNT = 4;
            }
            else if (txtWOAPPSOSABUN3.GetValue() != "") {
                iSO_COUNT = 3;
            }
            else if (txtWOAPPSOSABUN2.GetValue() != "") {
                iSO_COUNT = 2;
            }
            else if (txtWOAPPSOSABUN1.GetValue() != "") {
                iSO_COUNT = 1;
            }

            var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht1["P_APNUM"]           = sAPNUM.toString();
            ht1["P_WOORTEAM"]        = sWOORTEAM.toString();
            ht1["P_WOORDATE"]        = sWOORDATE.toString();
            ht1["P_WOSEQ"]           = sWOSEQ.toString();
            ht1["P_SENDER"]          = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";
            ht1["P_RECEIVER"]        = sMail_Receiver.toString();
            ht1["P_PGURL"]           = sPGURL.toString();
            ht1["P_TITLE"]           = sTitle.toString();
            ht1["P_WOWORKTITLE"]     = txtWOWORKTITLE.GetValue();
            ht1["P_WOWORKDOC"]       = sWOWORKDOC.toString();
            ht1["P_WOIMMEDTEXT"]     = txtWOIMMEDTEXT.GetValue();
            ht1["P_WOCANCELCOMMENT"] = sWOCANCELCOMMENT;
            ht1["P_GUBUN"]           = sGUBUN.toString();
            ht1["P_FINISH"]          = sFinish.toString();
            ht1["P_RENAME"]          = txtRENAME.GetValue();
            ht1["P_SOCOUNT"]         = iSO_COUNT;
            ht1["P_RECOUNT"]         = iRE_COUNT;
            ht1["P_SOAPPROVAL"]      = Get_Numeric(fshdnSOApproval);
            ht1["P_REAPPROVAL"]      = Get_Numeric(fshdnREApproval);
            ht1["P_WOCHANGEWKDIV"]   = cboWOCHANGEWKDIV.GetValue();

            PageMethods.InvokeServiceTable(ht1, "PSM.PSM4010", "UP_Get_Mail_List", function (e) {            

                var DataSet1 = eval(e);

                if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                    if (sGUBUN == 'OK') {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');

                        if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                            opener.btnSearch_Click();

                            this.close();
                        }

                        this.close();
                    }
                    else if (sGUBUN == 'CANCEL') {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업요청서 취소 처리가 되었습니다." Literal="true"></Ctl:Text>');

                        this.close();
                    }
                }

            }, function (e) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');

            });

        }

        function fn_APPROVAL_Display(sWOORTEAM, sWOORDATE, sWOSEQ, sWOCANCELCOMMENT, sMail_Receiver, sGUBUN, sFinish) {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_WOORTEAM"] = txtWOORTEAM.GetValue();
            ht["P_WOORDATE"] = Get_Date(txtWOORDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"]    = txtWOSEQ.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_PSM4011_APPROVAL_DISPLAY", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    if (DataSet.Tables[0].Rows[0]["WOAPPSODATE1"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPSODATE1"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPSOTIME1"];

                        txtWOAPPSODATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPSOTIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S1', DataSet.Tables[0].Rows[0]["WOAPPSOSABUN1"], DataSet.Tables[0].Rows[0]["SOIMGNAME1"])

                        fshdnSOApproval = "1";
                    }

                    txtWOAPPSOSABUN2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOSABUN2"]);
                    txtWOAPPSOJKCD2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCD2"]);

                    txtWOAPPSOJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCDNM2"]);
                    txtWOAPPSONAME2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSONAME2"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPSODATE2"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPSODATE2"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPSOTIME2"];

                        txtWOAPPSODATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPSOTIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S2', DataSet.Tables[0].Rows[0]["WOAPPSOSABUN2"], DataSet.Tables[0].Rows[0]["SOIMGNAME2"])

                        fshdnSOApproval = "2";
                    }

                    txtWOAPPSOSABUN3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOSABUN3"]);
                    txtWOAPPSOJKCD3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCD3"]);

                    txtWOAPPSOJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCDNM3"]);
                    txtWOAPPSONAME3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSONAME3"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPSODATE3"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPSODATE3"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPSOTIME3"];

                        txtWOAPPSODATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPSOTIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S3', DataSet.Tables[0].Rows[0]["WOAPPSOSABUN3"], DataSet.Tables[0].Rows[0]["SOIMGNAME3"])

                        fshdnSOApproval = "3";
                    }

                    txtWOAPPSOSABUN4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOSABUN4"]);
                    txtWOAPPSOJKCD4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCD4"]);

                    txtWOAPPSOJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCDNM4"]);
                    txtWOAPPSONAME4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSONAME4"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPSODATE4"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPSODATE4"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPSOTIME4"];

                        txtWOAPPSODATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPSOTIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S4', DataSet.Tables[0].Rows[0]["WOAPPSOSABUN4"], DataSet.Tables[0].Rows[0]["SOIMGNAME4"])

                        fshdnSOApproval = "4";
                    }

                    txtWOAPPSOSABUN5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOSABUN5"]);
                    txtWOAPPSOJKCD5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCD5"]);

                    txtWOAPPSOJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSOJKCDNM5"]);
                    txtWOAPPSONAME5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPSONAME5"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPSODATE5"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPSODATE5"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPSOTIME5"];

                        txtWOAPPSODATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPSOTIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S5', DataSet.Tables[0].Rows[0]["WOAPPSOSABUN5"], DataSet.Tables[0].Rows[0]["SOIMGNAME5"])

                        fshdnSOApproval = "5";
                    }

                    /* 수신승인자 */
                    txtWOAPPRESABUN1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRESABUN1"]);
                    txtWOAPPREJKCD1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCD1"]);

                    txtWOAPPREJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCDNM1"]);
                    txtWOAPPRENAME1.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRENAME1"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPREDATE1"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPREDATE1"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPRETIME1"];

                        txtWOAPPREDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPRETIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R1', DataSet.Tables[0].Rows[0]["WOAPPRESABUN1"], DataSet.Tables[0].Rows[0]["REIMGNAME1"])

                        // 현재 수신결재순번
                        fshdnREApproval = "1";
                    }

                    txtWOAPPRESABUN2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRESABUN2"]);
                    txtWOAPPREJKCD2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCD2"]);

                    txtWOAPPREJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCDNM2"]);
                    txtWOAPPRENAME2.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRENAME2"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPREDATE2"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPREDATE2"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPRETIME2"];

                        txtWOAPPREDATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPRETIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R2', DataSet.Tables[0].Rows[0]["WOAPPRESABUN2"], DataSet.Tables[0].Rows[0]["REIMGNAME2"])

                        // 현재 수신결재순번
                        fshdnREApproval = "2";
                    }

                    txtWOAPPRESABUN3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRESABUN3"]);
                    txtWOAPPREJKCD3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCD3"]);

                    txtWOAPPREJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCDNM3"]);
                    txtWOAPPRENAME3.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRENAME3"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPREDATE3"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPREDATE3"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPRETIME3"];

                        txtWOAPPREDATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPRETIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R3', DataSet.Tables[0].Rows[0]["WOAPPRESABUN3"], DataSet.Tables[0].Rows[0]["REIMGNAME3"])

                        // 현재 수신결재순번
                        fshdnREApproval = "3";
                    }

                    txtWOAPPRESABUN4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRESABUN4"]);
                    txtWOAPPREJKCD4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCD4"]);

                    txtWOAPPREJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCDNM4"]);
                    txtWOAPPRENAME4.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRENAME4"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPREDATE4"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPREDATE4"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPRETIME4"];

                        txtWOAPPREDATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPRETIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R4', DataSet.Tables[0].Rows[0]["WOAPPRESABUN4"], DataSet.Tables[0].Rows[0]["REIMGNAME4"])

                        // 현재 수신결재순번
                        fshdnREApproval = "4";
                    }

                    txtWOAPPRESABUN5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRESABUN5"]);
                    txtWOAPPREJKCD5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCD5"]);

                    txtWOAPPREJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPREJKCDNM5"]);
                    txtWOAPPRENAME5.SetValue(DataSet.Tables[0].Rows[0]["WOAPPRENAME5"]);

                    if (DataSet.Tables[0].Rows[0]["WOAPPREDATE5"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["WOAPPREDATE5"];
                        sTime = DataSet.Tables[0].Rows[0]["WOAPPRETIME5"];

                        txtWOAPPREDATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtWOAPPRETIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R5', DataSet.Tables[0].Rows[0]["WOAPPRESABUN5"], DataSet.Tables[0].Rows[0]["REIMGNAME5"])

                        // 현재 수신결재순번
                        fshdnREApproval = "5";
                    }

                    debugger;

                    if (sFinish == "FINISH") {

                        fn_FINISH_UPT();
                    }

                    // 결재 완료 업데이트
                    fn_APPSTATUS_UPT();

                    // 메일 발송
                    fn_Mail_Send(sWOORTEAM, sWOORDATE, sWOSEQ, sWOCANCELCOMMENT, sMail_Receiver, sGUBUN, sFinish);
                }
            }, function (e) {
                //// Biz 연결오류
                if (sGUBUN.toString() == "APPROVAL") {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                }
                else {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                }

            });

        }

        //function AttachFileLod(gubun, key) {

        //    document.getElementById("fuName1_filedata").value = "";

        //    fuName1.FileLoad(gubun, key, function () {
        //        // 로드완료

        //        // 프로그래스바 닫기
        //        PageProgressHide();
        //    });

        //}

        function fn_FINISH_Visible(gubun) {

            if (gubun == "false") {
                btnWOFINISH.Hide();
            }
            else {
                btnWOFINISH.Show();
            }
        }

        function fn_WK_Confirm_Visible(gubun) {

            if (gubun == "false") {
                btnWOIMMED.Hide();
            }
            else {
                btnWOIMMED.Show();
            }
        }

        function btnWOFINISH_Click() {
            // 승인자 확인버튼

            if ($("#svWOFINISHSABUN_KBSABUN").val() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="승인자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtWOFINISHTEXT.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="의견을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var today = new Date();

            txtWOFINISHDATE.SetValue(today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate()));

            fsWOIMMEDGUBN = "Y";

            // 작업요청 작업완료 사번,일자,의견 업데이트

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_WOIMMEDGUBN"]   = fsWOIMMEDGUBN;
            ht["P_WOFINISHDATE"]  = txtWOFINISHDATE.GetValue();
            ht["P_WOFINISHSABUN"] = $("#svWOFINISHSABUN_KBSABUN").val();
            ht["P_WOFINISHTEXT"]  = txtWOFINISHTEXT.GetValue();
            ht["P_WOORTEAM"]      = txtWOORTEAM.GetValue();
            ht["P_WOORDATE"]      = Get_Date(txtWOORDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"]         = txtWOSEQ.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_WORKORDER_FINISH_UPT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        fn_FINISH_Visible(false);

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업이 완료 되었습니다." Literal="true"></Ctl:Text>');
                    }
                    else {
                        //var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                    }
                }
                else {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

        function btnWOIMMED_Click() {
            
            // 조치확인 버튼

            if ($("#svWOIMMEDSABUN_KBSABUN").val() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="확인자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtWOIMMEDTEXT.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="조치내용을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var today = new Date();

            txtWOIMMEDDATE.SetValue(today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate()));

            // 작업요청 작업완료 사번,일자,의견 업데이트

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_WOIMMEDDATE"]  = txtWOIMMEDDATE.GetValue();
            ht["P_WOIMMEDSABUN"] = $("#svWOIMMEDSABUN_KBSABUN").val();
            ht["P_WOIMMEDTEXT"]  = txtWOIMMEDTEXT.GetValue();
            ht["P_WOORTEAM"]     = txtWOORTEAM.GetValue();
            ht["P_WOORDATE"] = Get_Date(txtWOORDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"]        = txtWOSEQ.GetValue();
            ht["P_GUBUN"]        = "CONFIRM";

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_WORKORDER_IMMED_UPT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        fn_WK_Confirm_Visible(false);

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 완료 되었습니다." Literal="true"></Ctl:Text>');
                    }
                    else {
                        //var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                    }
                }
                else {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

        function fn_COMMENT(COMMENT) {

            var iSO_COUNT = 0;
            var iRE_COUNT = 0;

            if (txtWOAPPSOSABUN5.GetValue() != "") {
                iSO_COUNT = 5;
            }
            else if (txtWOAPPSOSABUN4.GetValue() != "") {
                iSO_COUNT = 4;
            }
            else if (txtWOAPPSOSABUN3.GetValue() != "") {
                iSO_COUNT = 3;
            }
            else if (txtWOAPPSOSABUN2.GetValue() != "") {
                iSO_COUNT = 2;
            }
            else if (txtWOAPPSOSABUN1.GetValue() != "") {
                iSO_COUNT = 1;
            }

            if (txtWOAPPRESABUN5.GetValue() != "") {
                iRE_COUNT = 5;
            }
            else if (txtWOAPPRESABUN4.GetValue() != "") {
                iRE_COUNT = 4;
            }
            else if (txtWOAPPRESABUN3.GetValue() != "") {
                iRE_COUNT = 3;
            }
            else if (txtWOAPPRESABUN2.GetValue() != "") {
                iRE_COUNT = 2;
            }
            else if (txtWOAPPRESABUN1.GetValue() != "") {
                iRE_COUNT = 1;
            }

            debugger;

            if (iSO_COUNT == parseInt(Get_Numeric(fshdnSOApproval)) + 1) // 요청 마지막 결재자
            {
                if (iSO_COUNT == 1) {
                    txtWOAPPSOCOMMENT1.SetValue(COMMENT);
                }
                else if (iSO_COUNT == 2) {
                    txtWOAPPSOCOMMENT2.SetValue(COMMENT);
                }
                else if (iSO_COUNT == 3) {
                    txtWOAPPSOCOMMENT3.SetValue(COMMENT);
                }
                else if (iSO_COUNT == 4) {
                    txtWOAPPSOCOMMENT4.SetValue(COMMENT);
                }
                else if (iSO_COUNT == 5) {
                    txtWOAPPSOCOMMENT5.SetValue(COMMENT);
                }
            }
            else // 요청 다음 결재자
            {
                if (iSO_COUNT != parseInt(Get_Numeric(fshdnSOApproval))) {
                    if (Get_Numeric(fshdnSOApproval) == "0") {
                        txtWOAPPSOCOMMENT1.SetValue(COMMENT);
                    }
                    else if (Get_Numeric(fshdnSOApproval) == "1") {
                        txtWOAPPSOCOMMENT2.SetValue(COMMENT);
                    }
                    else if (Get_Numeric(fshdnSOApproval) == "2") {
                        txtWOAPPSOCOMMENT3.SetValue(COMMENT);
                    }
                    else if (Get_Numeric(fshdnSOApproval) == "3") {
                        txtWOAPPSOCOMMENT4.SetValue(COMMENT);
                    }
                    else if (Get_Numeric(fshdnSOApproval) == "4") {
                        txtWOAPPSOCOMMENT5.SetValue(COMMENT);
                    }
                }
            }

            if (iSO_COUNT == parseInt(Get_Numeric(fshdnSOApproval))) {
                if (iRE_COUNT == parseInt(Get_Numeric(fshdnREApproval)) + 1) // 수신 마지막 결재자
                {
                    if (iRE_COUNT == 1) {
                        txtWOAPPRECOMMENT1.SetValue(COMMENT);
                    }
                    else if (iRE_COUNT == 2) {
                        txtWOAPPRECOMMENT2.SetValue(COMMENT);
                    }
                    else if (iRE_COUNT == 3) {
                        txtWOAPPRECOMMENT3.SetValue(COMMENT);
                    }
                    else if (iRE_COUNT == 4) {
                        txtWOAPPRECOMMENT4.SetValue(COMMENT);
                    }
                    else if (iRE_COUNT == 5) {
                        txtWOAPPRECOMMENT5.SetValue(COMMENT);
                    }
                }
                else // 수신 다음 결재자
                {
                    if (iRE_COUNT != parseInt(Get_Numeric(fshdnREApproval))) {
                        if (Get_Numeric(fshdnREApproval) == "0") {
                            txtWOAPPRECOMMENT1.SetValue(COMMENT);
                        }
                        else if (Get_Numeric(fshdnREApproval) == "1") {
                            txtWOAPPRECOMMENT2.SetValue(COMMENT);
                        }
                        else if (Get_Numeric(fshdnREApproval) == "2") {
                            txtWOAPPRECOMMENT3.SetValue(COMMENT);
                        }
                        else if (Get_Numeric(fshdnREApproval) == "3") {
                            txtWOAPPRECOMMENT4.SetValue(COMMENT);
                        }
                        else if (Get_Numeric(fshdnREApproval) == "4") {
                            txtWOAPPRECOMMENT5.SetValue(COMMENT);
                        }
                    }
                }
            }
        }

        function fn_APPSTATUS_UPT() {

            var iRE_COUNT = 0;

            if (txtWOAPPRESABUN5.GetValue() != "") {

                iRE_COUNT = 5;
            }
            else if (txtWOAPPRESABUN4.GetValue() != "") {

                iRE_COUNT = 4;
            }
            else if (txtWOAPPRESABUN3.GetValue() != "") {

                iRE_COUNT = 3;
            }
            else if (txtWOAPPRESABUN2.GetValue() != "") {

                iRE_COUNT = 2;
            }
            else if (txtWOAPPRESABUN1.GetValue() != "") {

                iRE_COUNT = 1;
            }


            // 수신 마지막 결재자일 경우
            // 조치완료이면 공사완료 처리를 함.
            if (iRE_COUNT == parseInt(Get_Numeric(fshdnREApproval))) {

                var ht2 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht2["P_WOORTEAM"] = txtWOORTEAM.GetValue();
                ht2["P_WOORDATE"] = Get_Date(txtWOORDATE.GetValue().replace("-", ""));
                ht2["P_WOSEQ"]    = Set_Fill3(txtWOSEQ.GetValue());

                PageMethods.InvokeServiceTable(ht2, "PSM.PSM4010", "UP_WORKORDER_APPSTATUS_UPT", function (e) {

                    var DataSet2 = eval(e);

                    if (ObjectCount(DataSet2.Tables[0].Rows) == 1) {

                        if (DataSet2.Tables[0].Rows[0]["STATE"] == "OK") {
                            

                        }
                        else {
                            //var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        function fn_FINISH_UPT() {

            var iRE_COUNT = 0;

            if (txtWOAPPRESABUN5.GetValue() != "") {

                iRE_COUNT = 5;
            }
            else if (txtWOAPPRESABUN4.GetValue() != "") {

                iRE_COUNT = 4;
            }
            else if (txtWOAPPRESABUN3.GetValue() != "") {

                iRE_COUNT = 3;
            }
            else if (txtWOAPPRESABUN2.GetValue() != "") {

                iRE_COUNT = 2;                
            }
            else if (txtWOAPPRESABUN1.GetValue() != "") {

                iRE_COUNT = 1;
            }


            // 수신 마지막 결재자일 경우
            // 조치완료이면 공사완료 처리를 함.
            if (iRE_COUNT == parseInt(Get_Numeric(fshdnREApproval))) {

                if (fsWOIMMEDGUBN == "Y") {

                    var ht2 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                    ht2["P_WOIMMEDGUBN"]   = fsWOIMMEDGUBN;
                    ht2["P_WOFINISHDATE"]  = txtWOFINISHDATE.GetValue();
                    ht2["P_WOFINISHSABUN"] = $("#svWOFINISHSABUN_KBSABUN").val();
                    ht2["P_WOFINISHTEXT"]  = txtWOFINISHTEXT.GetValue();
                    ht2["P_WOORTEAM"]      = txtWOORTEAM.GetValue();
                    ht2["P_WOORDATE"]      = Get_Date(txtWOORDATE.GetValue().replace("-", ""));
                    ht2["P_WOSEQ"]         = Set_Fill3(txtWOSEQ.GetValue());

                    PageMethods.InvokeServiceTable(ht2, "PSM.PSM4010", "UP_WORKORDER_FINISH_UPT", function (e) {

                        var DataSet2 = eval(e);

                        if (ObjectCount(DataSet2.Tables[0].Rows) == 1) {

                            if (DataSet2.Tables[0].Rows[0]["STATE"] == "OK") {

                                fn_FINISH_Visible(false);

                                // 작업요청 작업완료 사번,일자,의견 업데이트

                                var ht3 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                                ht3["P_WOIMMEDDATE"] = txtWOIMMEDDATE.GetValue();
                                ht3["P_WOIMMEDSABUN"] = $("#svWOIMMEDSABUN_KBSABUN").val();
                                ht3["P_WOIMMEDTEXT"] = txtWOIMMEDTEXT.GetValue();
                                ht3["P_WOORTEAM"] = txtWOORTEAM.GetValue();
                                ht3["P_WOORDATE"] = Get_Date(txtWOORDATE.GetValue().replace("-", ""));
                                ht3["P_WOSEQ"] = Set_Fill3(txtWOSEQ.GetValue());
                                ht3["P_GUBUN"] = "FINISH";

                                PageMethods.InvokeServiceTable(ht3, "PSM.PSM4010", "UP_WORKORDER_IMMED_UPT", function (e) {

                                    var DataSet3 = eval(e);

                                    if (ObjectCount(DataSet3.Tables[0].Rows) == 1) {

                                        if (DataSet3.Tables[0].Rows[0]["STATE"] == "OK") {

                                            fn_WK_Confirm_Visible(false);
                                        }
                                        else {
                                        }
                                    }
                                    else {
                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                    }

                                }, function (e) {
                                    // Biz 연결오류
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                });

                            }
                            else {
                                //var msg = DataSet.Tables[0].Rows[0]["MSG"];
                                //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                            }
                        }
                        else {
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        }

                    }, function (e) {
                        // Biz 연결오류
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    });
                }
            }
            else {

                // 작업요청 작업완료 사번,일자,의견 업데이트

                var ht3 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht3["P_WOIMMEDDATE"] = txtWOIMMEDDATE.GetValue();
                ht3["P_WOIMMEDSABUN"] = $("#svWOIMMEDSABUN_KBSABUN").val();
                ht3["P_WOIMMEDTEXT"] = txtWOIMMEDTEXT.GetValue();
                ht3["P_WOORTEAM"] = txtWOORTEAM.GetValue();
                ht3["P_WOORDATE"] = Get_Date(txtWOORDATE.GetValue().replace("-", ""));
                ht3["P_WOSEQ"] = Set_Fill3(txtWOSEQ.GetValue());
                ht3["P_GUBUN"] = "FINISH";

                PageMethods.InvokeServiceTable(ht3, "PSM.PSM4010", "UP_WORKORDER_IMMED_UPT", function (e) {

                    var DataSet3 = eval(e);

                    if (ObjectCount(DataSet3.Tables[0].Rows) == 1) {

                        if (DataSet3.Tables[0].Rows[0]["STATE"] == "OK") {

                            fn_WK_Confirm_Visible(false);
                        }
                        else {
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }

        }


        // 코드헬프
        function btnPopup_Click(id) {
            _id = id;

            if (id == "WOPONUM1" || id == "WOPONUM2" || id == "WOPONUM3" || id == "WOPONUM4" || id == "WOPONUM5") {
                // 발주조회
                fn_OpenPop("../POP/PurchsePoPopup.aspx", 1000, 600);
            }
            else if (id == "WOLOCATIONCODE1" || id == "WOLOCATIONCODE2" || id == "WOLOCATIONCODE3" || id == "WOLOCATIONCODE4" || id == "WOLOCATIONCODE5") {
                // 설비코드
                fn_OpenPop("../POP/PSP1030.aspx", 1000, 600);
            }
        }

        // 콜백 함수
        function btnPopup_Last_Callback(COMMENT, WOIMMEDGUBN, WOIMMEDTEXT) {

            var sFinish   = "";
            var iRE_COUNT = 0;
            var sSABUN    = "";
            var sSABUNNM = "";

            fsWOIMMEDGUBN = "";

            fsWOIMMEDGUBN = WOIMMEDGUBN;

            fsRETRACTCOMMENT = "";

            fn_COMMENT(COMMENT);

            if (txtWOAPPRESABUN5.GetValue() != "") {

                iRE_COUNT = 5;
                sSABUN = txtWOAPPRESABUN5.GetValue();
                sSABUNNM = txtWOAPPRENAME5.GetValue();
            }
            else if (txtWOAPPRESABUN4.GetValue() != "") {

                iRE_COUNT = 4;
                sSABUN = txtWOAPPRESABUN4.GetValue();
                sSABUNNM = txtWOAPPRENAME4.GetValue();
            }
            else if (txtWOAPPRESABUN3.GetValue() != "") {

                iRE_COUNT = 3;
                sSABUN = txtWOAPPRESABUN3.GetValue();
                sSABUNNM = txtWOAPPRENAME3.GetValue();
            }
            else if (txtWOAPPRESABUN2.GetValue() != "") {

                iRE_COUNT = 2;
                sSABUN = txtWOAPPRESABUN2.GetValue();
                sSABUNNM = txtWOAPPRENAME2.GetValue();
            }
            else if (txtWOAPPRESABUN1.GetValue() != "") {

                iRE_COUNT = 1;
                sSABUN = txtWOAPPRESABUN1.GetValue();
                sSABUNNM = txtWOAPPRENAME1.GetValue();
            }

            if (WOIMMEDGUBN == "Y") {

                var today = new Date();

                sFinish = "FINISH";

                txtWOFINISHDATE.SetValue(today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate()));
                
                $("#svWOFINISHSABUN_KBSABUN").val(sSABUN);
                $("#svWOFINISHSABUN_KBHANGL").val(sSABUNNM);
                txtWOFINISHTEXT.GetValue(COMMENT);
            }

            // 조치내용
            txtWOIMMEDTEXT.SetValue(WOIMMEDTEXT);

            fn_Screen_Save("APPROVAL", sFinish);

            //// 수신 마지막 결재자일 경우
            //// 조치완료이면 공사완료 처리를 함.
            //if (iRE_COUNT == parseInt(Get_Numeric(fshdnREApproval))) {

            //    debugger;

            //    if (WOIMMEDGUBN == "Y") {

            //        debugger;

            //        txtWOFINISHDATE.GetValue(Get_NowDate(today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate())));

            //        $("#svWOFINISHSABUN_KBSABUN").val(sSABUN);
            //        $("#svWOFINISHSABUN_KBHANGL").val(sSABUNNM);
            //        txtWOFINISHTEXT.GetValue(COMMENT);

            //        var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            //        ht["P_WOFINISHDATE"]  = txtWOFINISHDATE.GetValue();
            //        ht["P_WOFINISHSABUN"] = $("#svWOFINISHSABUN_KBSABUN").val();
            //        ht["P_WOFINISHTEXT"]  = txtWOFINISHTEXT.GetValue();
            //        ht["P_WOORTEAM"]      = txtWOORTEAM.GetValue();
            //        ht["P_WOORDATE"]      = txtWOORDATE.GetValue();
            //        ht["P_WOSEQ"]         = txtWOSEQ.GetValue();

            //        PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_WORKORDER_FINISH_UPT", function (e) {

            //            var DataSet = eval(e);

            //            if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

            //                if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

            //                    fn_FINISH_Visible(false);

            //                    // 작업요청 작업완료 사번,일자,의견 업데이트

            //                    var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            //                    ht1["P_WOIMMEDDATE"]  = txtWOIMMEDDATE.GetValue();
            //                    ht1["P_WOIMMEDSABUN"] = $("#svWOIMMEDSABUN_KBSABUN").val();
            //                    ht1["P_WOIMMEDTEXT"]  = txtWOIMMEDTEXT.GetValue();
            //                    ht1["P_WOORTEAM"]     = txtWOORTEAM.GetValue();
            //                    ht1["P_WOORDATE"]     = txtWOORDATE.GetValue();
            //                    ht1["P_WOSEQ"]        = txtWOSEQ.GetValue();
            //                    ht1["P_GUBUN"]        = "FINISH";

            //                    PageMethods.InvokeServiceTable(ht1, "PSM.PSM4010", "UP_WORKORDER_IMMED_UPT", function (e) {

            //                        var DataSet1 = eval(e);

            //                        if (ObjectCount(DataSet1.Tables[0].Rows) == 1) {

            //                            if (DataSet1.Tables[0].Rows[0]["STATE"] == "OK") {

            //                                fn_WK_Confirm_Visible(false);
            //                            }
            //                            else {
            //                            }
            //                        }
            //                        else {
            //                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            //                        }

            //                    }, function (e) {
            //                        // Biz 연결오류
            //                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            //                    });
                                
            //                }
            //                else {
            //                    //var msg = DataSet.Tables[0].Rows[0]["MSG"];
            //                    //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
            //                }
            //            }
            //            else {
            //                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            //            }

            //        }, function (e) {
            //            // Biz 연결오류
            //            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            //        });
            //    }
            //}
            //else {

            //    // 작업요청 작업완료 사번,일자,의견 업데이트

            //    var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            //    ht["P_WOIMMEDDATE"]  = txtWOIMMEDDATE.GetValue();
            //    ht["P_WOIMMEDSABUN"] = $("#svWOIMMEDSABUN_KBSABUN").val();
            //    ht["P_WOIMMEDTEXT"]  = txtWOIMMEDTEXT.GetValue();
            //    ht["P_WOORTEAM"]     = txtWOORTEAM.GetValue();
            //    ht["P_WOORDATE"]     = txtWOORDATE.GetValue();
            //    ht["P_WOSEQ"]        = txtWOSEQ.GetValue();
            //    ht["P_GUBUN"]        = "FINISH";

            //    PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_WORKORDER_IMMED_UPT", function (e) {

            //        var DataSet = eval(e);

            //        if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

            //            if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

            //                fn_WK_Confirm_Visible(false);
            //            }
            //            else {
            //            }
            //        }
            //        else {
            //            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            //        }

            //    }, function (e) {
            //        // Biz 연결오류
            //        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="조치 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            //    });
            //}
        }
        // 콜백 함수
        function btnPopup_Callback(ht)
        {
            fsRETRACTCOMMENT = "";

            // 결재 의견
            if (_id == "APPROVAL") {

                fn_COMMENT(ht);

                doDisplay();

                fn_Screen_Save(_id, "");
            }

            // 철회 의견
            if (_id == "RETRACT") {

                fsRETRACTCOMMENT = ht;

                doDisplay();

                fn_RETRACT_Proc();

                setTimeout("doDisplay()", '3000');
            }

            // 취소 의견
            if (_id == "CANCEL") {

                if (txtWOCANCELCOMMENT1.GetValue() == "") {

                    txtWOCANCELCOMMENT1.SetValue(ht);
                }
                else if (txtWOCANCELCOMMENT2.GetValue() == "") {

                    txtWOCANCELCOMMENT2.SetValue(ht);
                }
                else if (txtWOCANCELCOMMENT3.GetValue() == "") {

                    txtWOCANCELCOMMENT3.SetValue(ht);
                }

                doDisplay();

                fn_CANCEL_Proc();

                /*setTimeout("doDisplay()", '3000');*/
            }
            

            // 발주 조회
            if (_id == "WOPONUM1") {
                txtWOPONUM1.SetValue(ht["POM1000"] + ht["POM1010"] + ht["POM1020"] + Set_Fill4(ht["POM1030"]));
            }

            // 설비코드
            if (_id == "WOLOCATIONCODE1") {
                txtWOLOCATIONCODE1.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                pnlWOLOCATIONCODE1.SetValue(ht["C3NAME"]);
            }
            else if (_id == "WOLOCATIONCODE2") {
                txtWOLOCATIONCODE2.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                pnlWOLOCATIONCODE2.SetValue(ht["C3NAME"]);
            }
            else if (_id == "WOLOCATIONCODE3") {
                txtWOLOCATIONCODE3.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                pnlWOLOCATIONCODE3.SetValue(ht["C3NAME"]);
            }
            else if (_id == "WOLOCATIONCODE4") {
                txtWOLOCATIONCODE4.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                pnlWOLOCATIONCODE4.SetValue(ht["C3NAME"]);
            }
            else if (_id == "WOLOCATIONCODE5") {
                txtWOLOCATIONCODE5.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                pnlWOLOCATIONCODE5.SetValue(ht["C3NAME"]);
            }
        }

        // 작업구역 코드헬프
        function btnAreaPopup_Click(id) {
            _id = id;

            if (txtWOLOCATIONCODE1.GetValue() == '')
            {
                alert('<Ctl:Text runat="server" Description="설비 코드1을 선택하세요." Literal="true"></Ctl:Text>');
                return;
            }

            var gubun;

            var sTeam = txtWOLOCATIONCODE1.GetValue();

            if (sTeam.substr(0, 1) == "T" || sTeam == "E10100") {
                gubun = "T";
            }
            else {
                if (sTeam.substr(0, 2) == "D1") {
                    if (fshdnLoginSabun == "0404-M")
                    {
                        gubun = "S";
                    }
                    else
                    {
                        gubun = "T";
                    }
                }
                else {
                    gubun = "S";
                }
            }

            //주변지역
            var data = '';

            for (var i = 1; i < 6; i++) {
                if ($("#txtWOAREACODE" + i).val().length >= 9) {

                    data = data + $("#txtWOAREACODE" + i).val() + "^" + $("#pnlWOAREACODE" + i).val() + "^";
                }
            }

            if (gubun == "T") {
                fn_OpenPop("../POP/PSP1031.aspx?param=" + data, 1650, 800);
            }
            else {
                fn_OpenPop("../POP/PSP1032.aspx?param=" + data, 1650, 800);
            }
            
        }

        // 콜백 함수
        function btnAreaPopup_Callback(ht) {

            for (var i = 0; i < ObjectCount(ht.Rows); i++) {
                index = i + 1;
                $("#txtWOAREACODE" + index).val(ht.Rows[i]["AREACODE"]);
                $("#pnlWOAREACODE" + index).val(ht.Rows[i]["AREACODENM"]);
            }
        }

        // 출력버튼
        function btnPrt_Click() {

            fn_OpenPop("../../Common/ReportView.aspx?RPT=PSM4011_RPT&TEAM=" + txtWOORTEAM.GetValue() + "&DATE=" + txtWOORDATE.GetValue() + "&SEQ=" + txtWOSEQ.GetValue(), 1000, 600);
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
    <!--컨텐츠시작-->
    <div id="content" >
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server" Title="작업요청등록" DefaultHide="False">

            <div class="btn_bx" id ="div_btn" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="100px" />
                        <col width="300px" />
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left">
                            <Ctl:Text ID="lblWOORTEAM" runat="server" LangCode="lblWOORTEAM" Description="요청부서" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left;border-right :hidden;">
                            <Ctl:TextBox ID="txtWOORTEAM" Width ="60px" runat="server"></Ctl:TextBox>
                            <Ctl:Text ID="lblsprate1" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtWOORDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                            <Ctl:Text ID="lblsprate2" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtWOSEQ" Width ="30px" style ="text-align:right;" runat="server" ReadOnly="true"></Ctl:TextBox>
                        </td>
                        <td>
                            <Ctl:Button ID="btnRETRACT"    runat="server" LangCode="btnRETRACT"    Description="철회"   OnClientClick="btnRETRACT_Click('RETRACT');" ></Ctl:Button>
                            <Ctl:Button ID="btnSOApproval" runat="server" LangCode="btnSOApproval" Description="결재선" OnClientClick="btnSOApproval_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnSave"       runat="server" LangCode="btnSave"       Description="저장"   OnClientClick="btnSave_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnDel"        runat="server" LangCode="btnDel"        Description="삭제"   OnClientClick="btnDel_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnApproval"   runat="server" LangCode="btnApproval"   Description="결재"   OnClientClick="btnApproval_Click('APPROVAL');" ></Ctl:Button>
                            <Ctl:Button ID="btnCancel"     runat="server" LangCode="btnCancel"     Description="반려"   OnClientClick="btnCancel_Click('CANCEL');" ></Ctl:Button>
                            <Ctl:Button ID="btnPrt"        runat="server" LangCode="btnPrt"        Description="출력"   OnClientClick="btnPrt_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnClose"      runat="server" LangCode="btnClose"      Description="닫기"   OnClientClick="btnClose_Click();" ></Ctl:Button>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="80px" />
                        <col width="80px" />
                        <col width="80px" />
                        <col width="80px" />
                        <col width="80px" />
                        <col width="5px" />
                        <col width="80px" />
                        <col width="80px" />
                        <col width="80px" />
                        <col width="80px" />
                        <col width="80px" />
                    </colgroup>
                    <tr>
                        
                        <th style="text-align:left;" colspan ="5">
                            <Ctl:Text ID="Text1" runat="server" LangCode="lblWOORTEAM" Description="결재"></Ctl:Text>
                        </th>

                        <td rowspan ="4" style="border-top:hidden;border-bottom:hidden;"></td>

                        <th style="text-align:left" colspan ="5">
                            <Ctl:Text ID="Text2" runat="server" LangCode="lblWOORTEAM" Description="수신"></Ctl:Text>
                        </th>
                        
                    </tr>
                    <tr>
                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPSOSABUN1"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSOJKCD1"   runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSOJKCDNM1" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSONAME1"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPSOSABUN2"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSOJKCD2"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtWOAPPSOJKCDNM2" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSONAME2"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPSOSABUN3"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSOJKCD3"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtWOAPPSOJKCDNM3" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSONAME3"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPSOSABUN4"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSOJKCD4"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtWOAPPSOJKCDNM4" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSONAME4"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPSOSABUN5"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSOJKCD5"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtWOAPPSOJKCDNM5" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSONAME5"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPRESABUN1"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPREJKCD1"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtWOAPPREJKCDNM1" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPRENAME1"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPRESABUN2"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPREJKCD2"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtWOAPPREJKCDNM2" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPRENAME2"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPRESABUN3"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPREJKCD3"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtWOAPPREJKCDNM3" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPRENAME3"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPRESABUN4"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPREJKCD4"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtWOAPPREJKCDNM4" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPRENAME4"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPRESABUN5"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPREJKCD5"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtWOAPPREJKCDNM5" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPRENAME5"   runat="server" ></Ctl:Text>
                        </td>
                    </tr>

                    <tr style="height:100px;">

                        <td style="text-align:center;" >
                            <img ID="ImgWOAPPSOPHOTO1" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPSOPHOTO1" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgWOAPPSOPHOTO2" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPSOPHOTO2" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgWOAPPSOPHOTO3" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPSOPHOTO3" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgWOAPPSOPHOTO4" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPSOPHOTO4" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgWOAPPSOPHOTO5" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPSOPHOTO5" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgWOAPPREPHOTO1" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPREPHOTO1" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgWOAPPREPHOTO2" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPREPHOTO2" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgWOAPPREPHOTO3" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPREPHOTO3" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgWOAPPREPHOTO4" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPREPHOTO4" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgWOAPPREPHOTO5" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPREPHOTO5" visible ="true"></img>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPSODATE1" runat="server" LangCode="txtWOAPPSODATE1"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSOTIME1" runat="server" LangCode="txtWOAPPSOTIME1"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPSODATE2" runat="server" LangCode="txtWOAPPSODATE2"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSOTIME2" runat="server" LangCode="txtWOAPPSOTIME2"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPSODATE3" runat="server" LangCode="txtWOAPPSODATE3"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSOTIME3" runat="server" LangCode="txtWOAPPSOTIME3"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPSODATE4" runat="server" LangCode="txtWOAPPSODATE4"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSOTIME4" runat="server" LangCode="txtWOAPPSOTIME4"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPSODATE5" runat="server" LangCode="txtWOAPPSODATE5"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPSOTIME5" runat="server" LangCode="txtWOAPPSOTIME5"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPREDATE1" runat="server" LangCode="txtWOAPPREDATE1"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPRETIME1" runat="server" LangCode="txtWOAPPRETIME1"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPREDATE2" runat="server" LangCode="txtWOAPPREDATE2"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPRETIME2" runat="server" LangCode="txtWOAPPRETIME2"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPREDATE3" runat="server" LangCode="txtWOAPPREDATE3"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPRETIME3" runat="server" LangCode="txtWOAPPRETIME3"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPREDATE4" runat="server" LangCode="txtWOAPPREDATE4"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPRETIME4" runat="server" LangCode="txtWOAPPRETIME4"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtWOAPPREDATE5" runat="server" LangCode="txtWOAPPREDATE5"></Ctl:Text>
                            <Ctl:Text ID="txtWOAPPRETIME5" runat="server" LangCode="txtWOAPPRETIME5"></Ctl:Text>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="150px" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                        <th style="text-align:left;" colspan ="2">
                            <Ctl:Text ID="lblreference" runat="server" LangCode="lblreference" Description="참조"></Ctl:Text>
                        </th>
                    </tr>
                    <%--<tr >
                        <td style="text-align:center; ">
                            <Ctl:Text ID="lblRESABUN" runat="server" LangCode="lblRESABUN" Description="사번"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" >
                            <Ctl:TextBox ID="txtRESABUN" runat="server" LangCode="txtRESABUN" Height ="50px" TextMode ="MultiLine" ReadOnly ="true" Width ="1095px"></Ctl:TextBox>
                        </td>
                    </tr>--%>
                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblRENAME" runat="server" LangCode="lblRENAME" Description="이름"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" >
                            <Ctl:TextBox ID="txtRENAME" runat="server" LangCode="txtRENAME" Height ="50px" TextMode ="MultiLine" ReadOnly ="true" Width ="1095px"></Ctl:TextBox>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="70px" />
                        <col width="150px" />
			            <col width="70px" />
                        <col width="150px" />
                        <col width="70px" />
                        <col width="150px" />
                        <col width="70px" />
                        <col width="350px" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="8">
                            <Ctl:Text ID="Text4" runat="server" LangCode="lblreference" Description="작업내용"></Ctl:Text>
                        </th>
                    </tr>
                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOORSABUN" runat="server" LangCode="lblWOORSABUN" Description="요청자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOORSABUN" runat="server" LangCode="txtWOORSABUN" ReadOnly ="true" Width ="50px"></Ctl:TextBox>
			                <Ctl:TextBox ID="pnlWOORSABUN" runat="server" LangCode="pnlWOORSABUN" ReadOnly ="true" Width ="80px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOSOTEAM" runat="server" LangCode="lblWOSOTEAM" Description="요청팀"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOSOTEAM" runat="server" LangCode="txtWOSOTEAM" ReadOnly ="true" Width ="50px"></Ctl:TextBox>
			                <Ctl:TextBox ID="pnlWOSOTEAM" runat="server" LangCode="pnlWOSOTEAM" ReadOnly ="true" Width ="80px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWORETEAM" runat="server" LangCode="lblWORETEAM" Description="수신팀"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWORETEAM" runat="server" LangCode="txtWORETEAM" ReadOnly ="true" Width ="50px"></Ctl:TextBox>
			                <Ctl:TextBox ID="pnlWORETEAM" runat="server" LangCode="pnlWORETEAM" ReadOnly ="true" Width ="80px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWODSDATE1" runat="server" LangCode="lblWODSDATE1" Description="요청일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWODSDATE1" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px"></Ctl:TextBox>
			                <Ctl:Text ID="lblWODSDATE2" runat="server" LangCode="lblWODSDATE2" Description="~"></Ctl:Text>
			                <Ctl:TextBox ID="txtWODSDATE2"  runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px"></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOPONUM1" runat="server" LangCode="lblWOPONUM1" Description="발주번호1"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOPONUM1" runat="server" LangCode="txtWOPONUM1" Width ="105px"></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnWOPONUM1" alt="발주번호1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOPONUM1');"  />
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOLOCATIONCODE1" runat="server" LangCode="lblWOLOCATIONCODE1" Description="설비코드1"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtWOLOCATIONCODE1" runat="server" LangCode="txtWOLOCATIONCODE1" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOLOCATIONCODE1" alt="연관설비1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOLOCATIONCODE1');"  />
			                <Ctl:TextBox ID="pnlWOLOCATIONCODE1" runat="server" LangCode="pnlWOLOCATIONCODE1" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOAREACODE1" runat="server" LangCode="lblWOAREACODE1" Description="작업구역1"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOAREACODE1" runat="server" LangCode="txtWOAREACODE1" Width ="80px"></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnWOAREACODE1" alt="작업구역1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('WOAREACODE1');"  />
			                <Ctl:TextBox ID="pnlWOAREACODE1" runat="server" LangCode="pnlWOAREACODE1" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			            </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOPONUM2" runat="server" LangCode="lblWOPONUM2" Description="발주번호2"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOPONUM2" runat="server" LangCode="txtWOPONUM2" Width ="105px"></Ctl:TextBox>
			                <img src="/Resources/Images/btn_search.gif" ID="btnWOPONUM2" alt="발주번호2조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOPONUM2');"  />
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOLOCATIONCODE2" runat="server" LangCode="lblWOLOCATIONCODE2" Description="설비코드2"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtWOLOCATIONCODE2" runat="server" LangCode="txtWOLOCATIONCODE2" Width ="80px"></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnWOLOCATIONCODE2" alt="연관설비2조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOLOCATIONCODE2');"  />
			                <Ctl:TextBox ID="pnlWOLOCATIONCODE2" runat="server" LangCode="pnlWOLOCATIONCODE2" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOAREACODE2" runat="server" LangCode="lblWOAREACODE2" Description="작업구역2"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOAREACODE2" runat="server" LangCode="txtWOAREACODE2" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOAREACODE2" alt="작업구역2조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('WOAREACODE2');"  />
			                <Ctl:TextBox ID="pnlWOAREACODE2" runat="server" LangCode="pnlWOAREACODE2" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			            </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOPONUM3" runat="server" LangCode="lblWOPONUM3" Description="발주번호3"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOPONUM3" runat="server" LangCode="txtWOPONUM3" Width ="105px"></Ctl:TextBox>
			                <img src="/Resources/Images/btn_search.gif" ID="btnWOPONUM3" alt="발주번호3조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOPONUM3');"  />
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOLOCATIONCODE3" runat="server" LangCode="lblWOLOCATIONCODE3" Description="설비코드3"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtWOLOCATIONCODE3" runat="server" LangCode="txtWOLOCATIONCODE3" Width ="80px"></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnWOLOCATIONCODE3" alt="연관설비3조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOLOCATIONCODE3');"  />
			                <Ctl:TextBox ID="pnlWOLOCATIONCODE3" runat="server" LangCode="pnlWOLOCATIONCODE3" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOAREACODE3" runat="server" LangCode="lblWOAREACODE3" Description="작업구역3"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOAREACODE3" runat="server" LangCode="txtWOAREACODE3" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOAREACODE3" alt="작업구역3조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('WOAREACODE3');"  />
			                <Ctl:TextBox ID="pnlWOAREACODE3" runat="server" LangCode="pnlWOAREACODE3" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			            </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOPONUM4" runat="server" LangCode="lblWOPONUM4" Description="발주번호4"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOPONUM4" runat="server" LangCode="txtWOPONUM4" Width ="105px"></Ctl:TextBox>
			                <img src="/Resources/Images/btn_search.gif" ID="btnWOPONUM4" alt="발주번호4조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOPONUM4');"  />
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOLOCATIONCODE4" runat="server" LangCode="lblWOLOCATIONCODE4" Description="설비코드4"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtWOLOCATIONCODE4" runat="server" LangCode="txtWOLOCATIONCODE4" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOLOCATIONCODE4" alt="연관설비4조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOLOCATIONCODE4');"  />
			                <Ctl:TextBox ID="pnlWOLOCATIONCODE4" runat="server" LangCode="pnlWOLOCATIONCODE4" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOAREACODE4" runat="server" LangCode="lblWOAREACODE4" Description="작업구역4"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOAREACODE4" runat="server" LangCode="txtWOAREACODE4" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOAREACODE4" alt="작업구역4조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('WOAREACODE4');"  />
			                <Ctl:TextBox ID="pnlWOAREACODE4" runat="server" LangCode="pnlWOAREACODE4" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			            </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOPONUM5" runat="server" LangCode="lblWOPONUM5" Description="발주번호5"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOPONUM5" runat="server" LangCode="txtWOPONUM5" Width ="105px"></Ctl:TextBox>
			                <img src="/Resources/Images/btn_search.gif" ID="btnWOPONUM5" alt="발주번호5조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOPONUM5');"  />
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOLOCATIONCODE5" runat="server" LangCode="lblWOLOCATIONCODE5" Description="설비코드5"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtWOLOCATIONCODE5" runat="server" LangCode="txtWOLOCATIONCODE5" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOLOCATIONCODE5" alt="연관설비5조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOLOCATIONCODE5');"  />
			                <Ctl:TextBox ID="pnlWOLOCATIONCODE5" runat="server" LangCode="pnlWOLOCATIONCODE5" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOAREACODE5" runat="server" LangCode="lblWOAREACODE5" Description="작업구역5"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOAREACODE5" runat="server" LangCode="txtWOAREACODE5" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOAREACODE5" alt="작업구역5조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('WOAREACODE5');"  />
			                <Ctl:TextBox ID="pnlWOAREACODE5" runat="server" LangCode="pnlWOAREACODE5" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			            </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOWORKTITLE" runat="server" LangCode="lblWOWORKTITLE" Description="작업명"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="7">
                            <Ctl:TextBox ID="txtWOWORKTITLE" runat="server" LangCode="txtWOWORKTITLE" Width ="1090px"></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOWORKDOC" runat="server" LangCode="lblWOWORKDOC" Description="작업내용"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="7">
                            <Ctl:TextBox ID="txtWOWORKDOC" runat="server" LangCode="txtWOWORKDOC" SetType="Text" TextMode ="MultiLine" Validation ="false" Height ="100"></Ctl:TextBox>
                        </td>
                    </tr>

                </table>
            </div>

            <div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="70px" />
                        <col width="500px" />
			            <col width="70px" />
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="8">
                            <Ctl:Text ID="Text14" runat="server" LangCode="lblreference" Description="변경관리판정"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text15" runat="server" LangCode="lblWOCHANGEWKJOB" Description="작업내용"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:Combo ID="cboWOCHANGEWKJOB" Width="100px" runat="server">
                                <asp:ListItem Text="고정장치"   Value="1" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="배관계"     Value="2" ></asp:ListItem>
                                <asp:ListItem Text="회전기기"   Value="3" ></asp:ListItem>
                                <asp:ListItem Text="전기/계장"  Value="4" ></asp:ListItem>
                                <asp:ListItem Text="저장물질"   Value="5" ></asp:ListItem>
                                <asp:ListItem Text="기타"       Value="6" ></asp:ListItem>
                            </Ctl:Combo>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text16" runat="server" LangCode="lblWOIMMEDDATE" Description="작업구분"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:Radio ID="cboWOCHANGEWKDIV" runat="server" DataMember="IDX" ReadMode="false">
                                    <asp:ListItem Text="단순교체" Value="1" Selected="true"></asp:ListItem>
                                    <asp:ListItem Text="변경대상" Value="2" ></asp:ListItem>
                            </Ctl:Radio>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="8">
                            <Ctl:Text ID="Text33" runat="server" LangCode="lblreference" Description="파일첨부"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td>
                            <Ctl:FileUpload ID="fuName1" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                        </td>
                    </tr>
                </table>
            </div>
            
            <div class="tab_wk">
                <ul class="tabnav_wk">
                    <li><a id="tabli01_wk" href="#tab01_wk">작업완료 승인</a></li>
                    <li><a id="tabli02_wk" href="#tab02_wk">작업완료 확인</a></li>
                    <li><a id="tabli03_wk" href="#tab03_wk">그룹웨어</a></li>
                </ul>
                
                <div class="tabcontent_wk";>
                    <div id="tab01_wk">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="70px" />
                                <col width="250px" />
			                    <col width="70px" />
                                <col width="150px" />
                                <col width="120px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text6" runat="server" LangCode="lblWOFINISHSABUN" Description="승인자"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:SearchView ID="svWOFINISHSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                    <Ctl:Button ID="btnWOFINISH" runat="server" Style="Orange" Description="완료" Hidden ="true"   OnClientClick="btnWOFINISH_Click();" ></Ctl:Button>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text7" runat="server" LangCode="lblWOFINISHDATE" Description="일자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOFINISHDATE" runat="server" LangCode="txtWOFINISHDATE" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text8" runat="server" LangCode="lblSMWKORAPPDATE" Description="허가서발행일자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMWKORAPPDATE" runat="server" LangCode="txtSMWKORAPPDATE" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text9" runat="server" LangCode="lblWOFINISHTEXT" Description="의견"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" colspan ="5">
                                    <Ctl:TextBox ID="txtWOFINISHTEXT" runat="server" LangCode="txtWOFINISHTEXT" TextMode ="MultiLine"></Ctl:TextBox>
                                </td>
                            </tr>

                        </table>		                
                    </div>

                    <div id="tab02_wk">
		                <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="70px" />
                                <col width="300px" />
			                    <col width="70px" />
                                <col width="*" />
                            </colgroup>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text11" runat="server" LangCode="lblWOIMMEDSABUN" Description="확인자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">

                                    <Ctl:SearchView ID="svWOIMMEDSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                    <Ctl:Button ID="btnWOIMMED" runat="server" Style="Orange" LangCode="btnWOIMMED" Description="완료" Hidden ="true" OnClientClick="btnWOIMMED_Click();" ></Ctl:Button>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text12" runat="server" LangCode="lblWOIMMEDDATE" Description="조치일자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOIMMEDDATE" runat="server" LangCode="txtWOIMMEDDATE" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text13" runat="server" LangCode="lblWOIMMEDTEXT" Description="의견"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" colspan ="3">
                                    <Ctl:TextBox ID="txtWOIMMEDTEXT" runat="server" LangCode="txtWOIMMEDTEXT" TextMode ="MultiLine"></Ctl:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div id="tab03_wk">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="70px" />
                                <col width="550px"/>
			                    <col width="*"/>
                            </colgroup>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text31" runat="server" LangCode="lblWOGRDOC1" Description="결재문서1"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOGRDOC1" runat="server" LangCode="txtWOGRDOC1" ReadOnly ="true" Width ="430px"></Ctl:TextBox>
			                        <Ctl:Button ID="btnWOGRDOC1" runat="server" LangCode="btnWOGRDOC1" Description="결재문서" Visible ="false" OnClientClick="btnWOGRDOC1_Click(1);" ></Ctl:Button>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOGRURL1" runat="server" LangCode="txtWOGRURL1" ReadOnly ="true" Width ="430px"></Ctl:TextBox>
			                        <Ctl:Button ID="btnWOGRURL1" runat="server" LangCode="btnWOGRURL1" Description="바로가기" Visible ="false" OnClientClick="btnWOGRURL1_Click(1);" ></Ctl:Button>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text32" runat="server" LangCode="lblWOGRDOC2" Description="결재문서2"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOGRDOC2" runat="server" LangCode="txtWOGRDOC2" ReadOnly ="true" Width ="430px"></Ctl:TextBox>
			                        <Ctl:Button ID="btnWOGRDOC2" runat="server" LangCode="btnWOGRDOC2" Description="결재문서" Visible ="false" OnClientClick="btnWOGRDOC1_Click(2);" ></Ctl:Button>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOGRURL2" runat="server" LangCode="txtWOGRURL2" ReadOnly ="true" Width ="430px"></Ctl:TextBox>
			                        <Ctl:Button ID="btnWOGRURL2" runat="server" LangCode="btnWOGRURL2" Description="바로가기" Visible ="false" OnClientClick="btnWOGRURL1_Click(2);" ></Ctl:Button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <div class="tab_op">
                <ul class="tabnav_op">
                    <li><a id="tabli01_op" href="#tab01_op">요청 및 수신의견</a></li>
                    <li><a id="tabli02_op" href="#tab02_op">요청승인반려이력</a></li>
                </ul>
                
                <div class="tabcontent_op";>
                    <div id="tab01_op">
		                <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="150px" />
                                <col width="*" />
			                    <col width="150px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblWOAPPSOCOMMENT1" runat="server" LangCode="lblWOAPPSOCOMMENT1" Description="요청의견1"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" >
                                    <Ctl:TextBox ID="txtWOAPPSOCOMMENT1" runat="server" LangCode="txtWOAPPSOCOMMENT1" ReadOnly ="true" Width ="500px"></Ctl:TextBox>
                                </td>

			                    <td style="text-align:center;">
                                    <Ctl:Text ID="lblWOAPPRECOMMENT1" runat="server" LangCode="lblWOAPPRECOMMENT1" Description="수신의견1"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" >
                                    <Ctl:TextBox ID="txtWOAPPRECOMMENT1" runat="server" LangCode="txtWOAPPRECOMMENT1" ReadOnly ="true" Width ="500px"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblWOAPPSOCOMMENT2" runat="server" LangCode="lblWOAPPSOCOMMENT2" Description="요청의견2"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" >
                                    <Ctl:TextBox ID="txtWOAPPSOCOMMENT2" runat="server" LangCode="txtWOAPPSOCOMMENT2" ReadOnly ="true" Width ="500px"></Ctl:TextBox>
                                </td>

			                    <td style="text-align:center;">
                                    <Ctl:Text ID="lblWOAPPRECOMMENT2" runat="server" LangCode="lblWOAPPRECOMMENT2" Description="수신의견2"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" >
                                    <Ctl:TextBox ID="txtWOAPPRECOMMENT2" runat="server" LangCode="txtWOAPPRECOMMENT2" ReadOnly ="true" Width ="500px"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblWOAPPSOCOMMENT3" runat="server" LangCode="lblWOAPPSOCOMMENT3" Description="요청의견3"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" >
                                    <Ctl:TextBox ID="txtWOAPPSOCOMMENT3" runat="server" LangCode="txtWOAPPSOCOMMENT3" ReadOnly ="true" Width ="500px"></Ctl:TextBox>
                                </td>

			                    <td style="text-align:center;">
                                    <Ctl:Text ID="lblWOAPPRECOMMENT3" runat="server" LangCode="lblWOAPPRECOMMENT3" Description="수신의견3"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" >
                                    <Ctl:TextBox ID="txtWOAPPRECOMMENT3" runat="server" LangCode="txtWOAPPRECOMMENT3" ReadOnly ="true" Width ="500px"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblWOAPPSOCOMMENT4" runat="server" LangCode="lblWOAPPSOCOMMENT4" Description="요청의견4"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" >
                                    <Ctl:TextBox ID="txtWOAPPSOCOMMENT4" runat="server" LangCode="txtWOAPPSOCOMMENT4" ReadOnly ="true" Width ="500px"></Ctl:TextBox>
                                </td>

			                    <td style="text-align:center;">
                                    <Ctl:Text ID="lblWOAPPRECOMMENT4" runat="server" LangCode="lblWOAPPRECOMMENT4" Description="수신의견4"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" >
                                    <Ctl:TextBox ID="txtWOAPPRECOMMENT4" runat="server" LangCode="txtWOAPPRECOMMENT4" ReadOnly ="true" Width ="500px"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblWOAPPSOCOMMENT5" runat="server" LangCode="lblWOAPPSOCOMMENT5" Description="요청의견5"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" >
                                    <Ctl:TextBox ID="txtWOAPPSOCOMMENT5" runat="server" LangCode="txtWOAPPSOCOMMENT5" ReadOnly ="true" Width ="500px"></Ctl:TextBox>
                                </td>

			                    <td style="text-align:center;">
                                    <Ctl:Text ID="lblWOAPPRECOMMENT5" runat="server" LangCode="lblWOAPPRECOMMENT5" Description="수신의견5"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" >
                                    <Ctl:TextBox ID="txtWOAPPRECOMMENT5" runat="server" LangCode="txtWOAPPRECOMMENT5" ReadOnly ="true" Width ="500px"></Ctl:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>


                    <div id="tab02_op">
		                <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="70px" />
                                <col width="400px"/>
			                    <col width="70px" />
                                <col width="200px"/>
                                <col width="70px" />
                                <col width="120px"/>
                                <col width="70px" />
                                <col width="120px"/>
                            </colgroup>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text18" runat="server" LangCode="lblWOCANCELCOMMENT1" Description="내용"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELCOMMENT1" runat="server" LangCode="txtWOCANCELCOMMENT1" ReadOnly ="true" Width ="370px"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text19" runat="server" LangCode="lblWOCANCELSABUN1" Description="이름"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELSABUN1" runat="server" LangCode="txtWOCANCELSABUN1" ReadOnly ="true" Width ="60px"></Ctl:TextBox>
                                    <Ctl:TextBox ID="pnlWOCANCELSABUN1" runat="server" LangCode="pnlWOCANCELSABUN1" ReadOnly ="true" Width ="90px"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text20" runat="server" LangCode="lblWOCANCELDATE1" Description="일자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELDATE1" runat="server" LangCode="txtWOCANCELDATE1" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text21" runat="server" LangCode="lblWOCANCELTIME1" Description="시간"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELTIME1" runat="server" LangCode="txtWOCANCELTIME1" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text22" runat="server" LangCode="lblWOCANCELCOMMENT2" Description="내용"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELCOMMENT2" runat="server" LangCode="txtWOCANCELCOMMENT2" ReadOnly ="true" Width ="370px"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text23" runat="server" LangCode="lblWOCANCELSABUN2" Description="이름"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELSABUN2" runat="server" LangCode="txtWOCANCELSABUN2" ReadOnly ="true" Width ="60px"></Ctl:TextBox>
                                    <Ctl:TextBox ID="pnlWOCANCELSABUN2" runat="server" LangCode="pnlWOCANCELSABUN2" ReadOnly ="true" Width ="90px"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text24" runat="server" LangCode="lblWOCANCELDATE2" Description="일자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELDATE2" runat="server" LangCode="txtWOCANCELDATE2" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text25" runat="server" LangCode="lblWOCANCELTIME2" Description="시간"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELTIME2" runat="server" LangCode="txtWOCANCELTIME2" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text26" runat="server" LangCode="lblWOCANCELCOMMENT3" Description="내용"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELCOMMENT3" runat="server" LangCode="txtWOCANCELCOMMENT3" ReadOnly ="true" Width ="370px"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text27" runat="server" LangCode="lblWOCANCELSABUN3" Description="이름"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELSABUN3" runat="server" LangCode="txtWOCANCELSABUN3" ReadOnly ="true" Width ="60px"></Ctl:TextBox>
                                    <Ctl:TextBox ID="pnlWOCANCELSABUN3" runat="server" LangCode="pnlWOCANCELSABUN3" ReadOnly ="true" Width ="90px"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text28" runat="server" LangCode="lblWOCANCELDATE3" Description="일자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELDATE3" runat="server" LangCode="txtWOCANCELDATE3" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text29" runat="server" LangCode="lblWOCANCELTIME3" Description="시간"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtWOCANCELTIME3" runat="server" LangCode="txtWOCANCELTIME3" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>
            </div>

            <%--<div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="70px" />
                        <col width="150px" />
			            <col width="70px" />
                        <col width="150px" />
                        <col width="70px" />
                        <col width="150px" />
                        <col width="70px" />
                        <col width="350px" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="8">
                            <Ctl:Text ID="Text4" runat="server" LangCode="lblreference" Description="작업내용"></Ctl:Text>
                        </th>
                    </tr>
                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOORSABUN" runat="server" LangCode="lblWOORSABUN" Description="요청자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOORSABUN" runat="server" LangCode="txtWOORSABUN" ReadOnly ="true" Width ="50px"></Ctl:TextBox>
			                <Ctl:TextBox ID="pnlWOORSABUN" runat="server" LangCode="pnlWOORSABUN" ReadOnly ="true" Width ="80px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOSOTEAM" runat="server" LangCode="lblWOSOTEAM" Description="요청팀"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOSOTEAM" runat="server" LangCode="txtWOSOTEAM" ReadOnly ="true" Width ="50px"></Ctl:TextBox>
			                <Ctl:TextBox ID="pnlWOSOTEAM" runat="server" LangCode="pnlWOSOTEAM" ReadOnly ="true" Width ="80px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWORETEAM" runat="server" LangCode="lblWORETEAM" Description="수신팀"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWORETEAM" runat="server" LangCode="txtWORETEAM" ReadOnly ="true" Width ="50px"></Ctl:TextBox>
			                <Ctl:TextBox ID="pnlWORETEAM" runat="server" LangCode="pnlWORETEAM" ReadOnly ="true" Width ="80px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWODSDATE1" runat="server" LangCode="lblWODSDATE1" Description="요청일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWODSDATE1" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px"></Ctl:TextBox>
			                <Ctl:Text ID="lblWODSDATE2" runat="server" LangCode="lblWODSDATE2" Description="~"></Ctl:Text>
			                <Ctl:TextBox ID="txtWODSDATE2"  runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px"></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOPONUM1" runat="server" LangCode="lblWOPONUM1" Description="발주번호1"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOPONUM1" runat="server" LangCode="txtWOPONUM1" Width ="105px"></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnWOPONUM1" alt="발주번호1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOPONUM1');"  />
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOLOCATIONCODE1" runat="server" LangCode="lblWOLOCATIONCODE1" Description="설비코드1"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtWOLOCATIONCODE1" runat="server" LangCode="txtWOLOCATIONCODE1" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOLOCATIONCODE1" alt="연관설비1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOLOCATIONCODE1');"  />
			                <Ctl:TextBox ID="pnlWOLOCATIONCODE1" runat="server" LangCode="pnlWOLOCATIONCODE1" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOAREACODE1" runat="server" LangCode="lblWOAREACODE1" Description="작업구역1"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOAREACODE1" runat="server" LangCode="txtWOAREACODE1" Width ="80px"></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnWOAREACODE1" alt="작업구역1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('WOAREACODE1');"  />
			                <Ctl:TextBox ID="pnlWOAREACODE1" runat="server" LangCode="pnlWOAREACODE1" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			            </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOPONUM2" runat="server" LangCode="lblWOPONUM2" Description="발주번호2"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOPONUM2" runat="server" LangCode="txtWOPONUM2" Width ="105px"></Ctl:TextBox>
			                <img src="/Resources/Images/btn_search.gif" ID="btnWOPONUM2" alt="발주번호2조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOPONUM2');"  />
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOLOCATIONCODE2" runat="server" LangCode="lblWOLOCATIONCODE2" Description="설비코드2"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtWOLOCATIONCODE2" runat="server" LangCode="txtWOLOCATIONCODE2" Width ="80px"></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnWOLOCATIONCODE2" alt="연관설비2조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOLOCATIONCODE2');"  />
			                <Ctl:TextBox ID="pnlWOLOCATIONCODE2" runat="server" LangCode="pnlWOLOCATIONCODE2" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOAREACODE2" runat="server" LangCode="lblWOAREACODE2" Description="작업구역2"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOAREACODE2" runat="server" LangCode="txtWOAREACODE2" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOAREACODE2" alt="작업구역2조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('WOAREACODE2');"  />
			                <Ctl:TextBox ID="pnlWOAREACODE2" runat="server" LangCode="pnlWOAREACODE2" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			            </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOPONUM3" runat="server" LangCode="lblWOPONUM3" Description="발주번호3"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOPONUM3" runat="server" LangCode="txtWOPONUM3" Width ="105px"></Ctl:TextBox>
			                <img src="/Resources/Images/btn_search.gif" ID="btnWOPONUM3" alt="발주번호3조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOPONUM3');"  />
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOLOCATIONCODE3" runat="server" LangCode="lblWOLOCATIONCODE3" Description="설비코드3"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtWOLOCATIONCODE3" runat="server" LangCode="txtWOLOCATIONCODE3" Width ="80px"></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnWOLOCATIONCODE3" alt="연관설비3조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOLOCATIONCODE3');"  />
			                <Ctl:TextBox ID="pnlWOLOCATIONCODE3" runat="server" LangCode="pnlWOLOCATIONCODE3" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOAREACODE3" runat="server" LangCode="lblWOAREACODE3" Description="작업구역3"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOAREACODE3" runat="server" LangCode="txtWOAREACODE3" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOAREACODE3" alt="작업구역3조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('WOAREACODE3');"  />
			                <Ctl:TextBox ID="pnlWOAREACODE3" runat="server" LangCode="pnlWOAREACODE3" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			            </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOPONUM4" runat="server" LangCode="lblWOPONUM4" Description="발주번호4"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOPONUM4" runat="server" LangCode="txtWOPONUM4" Width ="105px"></Ctl:TextBox>
			                <img src="/Resources/Images/btn_search.gif" ID="btnWOPONUM4" alt="발주번호4조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOPONUM4');"  />
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOLOCATIONCODE4" runat="server" LangCode="lblWOLOCATIONCODE4" Description="설비코드4"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtWOLOCATIONCODE4" runat="server" LangCode="txtWOLOCATIONCODE4" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOLOCATIONCODE4" alt="연관설비4조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOLOCATIONCODE4');"  />
			                <Ctl:TextBox ID="pnlWOLOCATIONCODE4" runat="server" LangCode="pnlWOLOCATIONCODE4" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOAREACODE4" runat="server" LangCode="lblWOAREACODE4" Description="작업구역4"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOAREACODE4" runat="server" LangCode="txtWOAREACODE4" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOAREACODE4" alt="작업구역4조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('WOAREACODE4');"  />
			                <Ctl:TextBox ID="pnlWOAREACODE4" runat="server" LangCode="pnlWOAREACODE4" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			            </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOPONUM5" runat="server" LangCode="lblWOPONUM5" Description="발주번호5"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOPONUM5" runat="server" LangCode="txtWOPONUM5" Width ="105px"></Ctl:TextBox>
			                <img src="/Resources/Images/btn_search.gif" ID="btnWOPONUM5" alt="발주번호5조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOPONUM5');"  />
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOLOCATIONCODE5" runat="server" LangCode="lblWOLOCATIONCODE5" Description="설비코드5"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtWOLOCATIONCODE5" runat="server" LangCode="txtWOLOCATIONCODE5" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOLOCATIONCODE5" alt="연관설비5조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('WOLOCATIONCODE5');"  />
			                <Ctl:TextBox ID="pnlWOLOCATIONCODE5" runat="server" LangCode="pnlWOLOCATIONCODE5" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblWOAREACODE5" runat="server" LangCode="lblWOAREACODE5" Description="작업구역5"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOAREACODE5" runat="server" LangCode="txtWOAREACODE5" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnWOAREACODE5" alt="작업구역5조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('WOAREACODE5');"  />
			                <Ctl:TextBox ID="pnlWOAREACODE5" runat="server" LangCode="pnlWOAREACODE5" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			            </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOWORKTITLE" runat="server" LangCode="lblWOWORKTITLE" Description="작업명"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="7">
                            <Ctl:TextBox ID="txtWOWORKTITLE" runat="server" LangCode="txtWOWORKTITLE" Width ="1090px"></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblWOWORKDOC" runat="server" LangCode="lblWOWORKDOC" Description="작업내용"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="7">
                            <Ctl:TextBox ID="txtWOWORKDOC" runat="server" LangCode="txtWOWORKDOC" TextMode ="MultiLine"></Ctl:TextBox>
                        </td>
                    </tr>

                </table>
            </div>--%>


            <%--<div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="70px" />
                        <col width="250px" />
			            <col width="70px" />
                        <col width="150px" />
                        <col width="120px" />
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="8">
                            <Ctl:Text ID="Text5" runat="server" LangCode="lblreference" Description="작업완료"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text6" runat="server" LangCode="lblWOFINISHSABUN" Description="승인자"></Ctl:Text>
                        </td>

                        <td style="text-align:left;">
                            <Ctl:SearchView ID="svWOFINISHSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                            </Ctl:SearchView>
                            <Ctl:Button ID="btnWOFINISH" runat="server" Style="Orange" Description="완료" Hidden ="true"   OnClientClick="btnWOFINISH_Click();" ></Ctl:Button>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text7" runat="server" LangCode="lblWOFINISHDATE" Description="일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOFINISHDATE" runat="server" LangCode="txtWOFINISHDATE" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text8" runat="server" LangCode="lblSMWKORAPPDATE" Description="허가서발행일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtSMWKORAPPDATE" runat="server" LangCode="txtSMWKORAPPDATE" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text9" runat="server" LangCode="lblWOFINISHTEXT" Description="의견"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="5">
                            <Ctl:TextBox ID="txtWOFINISHTEXT" runat="server" LangCode="txtWOFINISHTEXT" TextMode ="MultiLine"></Ctl:TextBox>
                        </td>
                    </tr>

                </table>
            </div>--%>

            <%--<div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="70px" />
                        <col width="300px" />
			            <col width="70px" />
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="8">
                            <Ctl:Text ID="Text10" runat="server" LangCode="lblreference" Description="작업완료 확인"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text11" runat="server" LangCode="lblWOIMMEDSABUN" Description="확인자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">

                            <Ctl:SearchView ID="svWOIMMEDSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                            </Ctl:SearchView>
                            <Ctl:Button ID="btnWOIMMED" runat="server" Style="Orange" LangCode="btnWOIMMED" Description="완료" Hidden ="true" OnClientClick="btnWOIMMED_Click();" ></Ctl:Button>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text12" runat="server" LangCode="lblWOIMMEDDATE" Description="조치일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOIMMEDDATE" runat="server" LangCode="txtWOIMMEDDATE" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text13" runat="server" LangCode="lblWOIMMEDTEXT" Description="의견"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtWOIMMEDTEXT" runat="server" LangCode="txtWOIMMEDTEXT" TextMode ="MultiLine"></Ctl:TextBox>
                        </td>
                    </tr>
                </table>
            </div>--%>
            
            <%--<div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="70px" />
                        <col width="400px"/>
			            <col width="70px" />
                        <col width="200px"/>
                        <col width="70px" />
                        <col width="120px"/>
                        <col width="70px" />
                        <col width="120px"/>
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="8">
                            <Ctl:Text ID="Text17" runat="server" LangCode="lblreference" Description="요청승인반려이력"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text18" runat="server" LangCode="lblWOCANCELCOMMENT1" Description="내용"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELCOMMENT1" runat="server" LangCode="txtWOCANCELCOMMENT1" ReadOnly ="true" Width ="370px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text19" runat="server" LangCode="lblWOCANCELSABUN1" Description="이름"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELSABUN1" runat="server" LangCode="txtWOCANCELSABUN1" ReadOnly ="true" Width ="60px"></Ctl:TextBox>
                            <Ctl:TextBox ID="pnlWOCANCELSABUN1" runat="server" LangCode="pnlWOCANCELSABUN1" ReadOnly ="true" Width ="90px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text20" runat="server" LangCode="lblWOCANCELDATE1" Description="일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELDATE1" runat="server" LangCode="txtWOCANCELDATE1" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text21" runat="server" LangCode="lblWOCANCELTIME1" Description="시간"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELTIME1" runat="server" LangCode="txtWOCANCELTIME1" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text22" runat="server" LangCode="lblWOCANCELCOMMENT2" Description="내용"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELCOMMENT2" runat="server" LangCode="txtWOCANCELCOMMENT2" ReadOnly ="true" Width ="370px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text23" runat="server" LangCode="lblWOCANCELSABUN2" Description="이름"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELSABUN2" runat="server" LangCode="txtWOCANCELSABUN2" ReadOnly ="true" Width ="60px"></Ctl:TextBox>
                            <Ctl:TextBox ID="pnlWOCANCELSABUN2" runat="server" LangCode="pnlWOCANCELSABUN2" ReadOnly ="true" Width ="90px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text24" runat="server" LangCode="lblWOCANCELDATE2" Description="일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELDATE2" runat="server" LangCode="txtWOCANCELDATE2" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text25" runat="server" LangCode="lblWOCANCELTIME2" Description="시간"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELTIME2" runat="server" LangCode="txtWOCANCELTIME2" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text26" runat="server" LangCode="lblWOCANCELCOMMENT3" Description="내용"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELCOMMENT3" runat="server" LangCode="txtWOCANCELCOMMENT3" ReadOnly ="true" Width ="370px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text27" runat="server" LangCode="lblWOCANCELSABUN3" Description="이름"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELSABUN3" runat="server" LangCode="txtWOCANCELSABUN3" ReadOnly ="true" Width ="60px"></Ctl:TextBox>
                            <Ctl:TextBox ID="pnlWOCANCELSABUN3" runat="server" LangCode="pnlWOCANCELSABUN3" ReadOnly ="true" Width ="90px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text28" runat="server" LangCode="lblWOCANCELDATE3" Description="일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELDATE3" runat="server" LangCode="txtWOCANCELDATE3" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text29" runat="server" LangCode="lblWOCANCELTIME3" Description="시간"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOCANCELTIME3" runat="server" LangCode="txtWOCANCELTIME3" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                        </td>
                    </tr>

                </table>
            </div>--%>

            <%--<div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="70px" />
                        <col width="550px"/>
			            <col width="*"/>
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="8">
                            <Ctl:Text ID="Text30" runat="server" LangCode="lblreference" Description="그룹웨어"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text31" runat="server" LangCode="lblWOGRDOC1" Description="결재문서1"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOGRDOC1" runat="server" LangCode="txtWOGRDOC1" ReadOnly ="true" Width ="430px"></Ctl:TextBox>
			                <Ctl:Button ID="btnWOGRDOC1" runat="server" LangCode="btnWOGRDOC1" Description="결재문서" Visible ="false" OnClientClick="btnWOGRDOC1_Click(1);" ></Ctl:Button>
                        </td>

                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOGRURL1" runat="server" LangCode="txtWOGRURL1" ReadOnly ="true" Width ="430px"></Ctl:TextBox>
			                <Ctl:Button ID="btnWOGRURL1" runat="server" LangCode="btnWOGRURL1" Description="바로가기" Visible ="false" OnClientClick="btnWOGRURL1_Click(1);" ></Ctl:Button>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text32" runat="server" LangCode="lblWOGRDOC2" Description="결재문서2"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOGRDOC2" runat="server" LangCode="txtWOGRDOC2" ReadOnly ="true" Width ="430px"></Ctl:TextBox>
			                <Ctl:Button ID="btnWOGRDOC2" runat="server" LangCode="btnWOGRDOC2" Description="결재문서" Visible ="false" OnClientClick="btnWOGRDOC1_Click(2);" ></Ctl:Button>
                        </td>

                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtWOGRURL2" runat="server" LangCode="txtWOGRURL2" ReadOnly ="true" Width ="430px"></Ctl:TextBox>
			                <Ctl:Button ID="btnWOGRURL2" runat="server" LangCode="btnWOGRURL2" Description="바로가기" Visible ="false" OnClientClick="btnWOGRURL1_Click(2);" ></Ctl:Button>
                        </td>
                    </tr>
                </table>
            </div>--%>

            <%--<div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="8">
                            <Ctl:Text ID="Text33" runat="server" LangCode="lblreference" Description="파일첨부"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td>
                            <Ctl:FileUpload ID="fuName1" runat="server" ReadMode="false" SetUploadType="list" SimpleMode="false" ></Ctl:FileUpload>
                        </td>
                    </tr>
                </table>
            </div>--%>
		</Ctl:Layer>
	</div>

</asp:content>