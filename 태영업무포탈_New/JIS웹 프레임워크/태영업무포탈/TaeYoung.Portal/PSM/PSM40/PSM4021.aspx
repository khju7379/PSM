 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4021.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4021" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <style>           
            html,body {width:100%;  }
            body,div,ul,li{margin:0; padding:0;}
            ul,li {list-style:none;}
            
    </style>

    <script type="text/javascript" id="GT">

        function doDisplay() {

            var obj = document.getElementById("div_btn");
            
            if (obj.style.display == 'none') {
                obj.style.display = '';
            } else {
                obj.style.display = 'none';
            }
        }
        
        var fsWOORTEAM = "";
        var fsWOORDATE = "";
        var fsWOSEQ = "0";

        var fshdnSOApproval = "0";
        var fshdnREApproval = "0";

        var fsboolean;

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

        fsboolean = false;

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

            fshdnLoginSabun = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";

            fshdnExists = "<%= Request.QueryString["param"] %>";

            var Num = "<%= Request.QueryString["param1"] %>";

            var data = Num.split('-');

            txtCAWOTEAM.SetValue(data[0]);
            txtCAWODATE.SetValue(data[1]);
            txtCAWOSEQ.SetValue(data[2]);

            if (fshdnExists == 'NEW') {

                var today = new Date();

                txtCAASKTEAM.SetValue(data[0]);
                txtCAASKDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
                txtCAASKSEQ.SetValue("");

                // 요청부서 가져오기
                fn_SET_Buseo();

                btnDel.Hide();

                //fn_GET_Site();

                // 요청 결재자
                fn_Btn_Visible('0');

                // 요구서 작성자      = 변경등급 , 변경종류 수정
                // 수신자(안전환경팀) = 변경등급만 수정
                fn_Field_ReadOnly(false, false, false);
            }
            else {
                if (data.length > 1) {

                    txtCAASKTEAM.SetValue(data[3]);
                    txtCAASKDATE.SetValue(data[4]);
                    txtCAASKSEQ.SetValue(data[5]);

                    fn_GET_Display();
                }
            }
        }

        function fn_Field_ReadOnly(bReadOnly1, bReadOnly2, bReadOnly3) {
            txtCAASKDATE.SetDisabled(bReadOnly1);
            txtCAASKCONTENT.SetDisabled(bReadOnly1);
            txtCAASKSUMMARY.SetDisabled(bReadOnly1);

            // 요구서 작성자만 수정
            cboCAASKSTEPGN.SetDisabled(bReadOnly2);

            // 안전환경팀 작성자만 수정
            cboCAASKCLASS.SetDisabled(bReadOnly3);
            
        }

        function fn_GET_Site() {

            var iSO_COUNT = 0;
            var iRE_COUNT = 0;

            // 요청 결재자
            fn_Btn_Visible('0');

            if (txtCAASKSABUN5.GetValue() != "") {
                iSO_COUNT = 5;
            }
            else if (txtCAASKSABUN4.GetValue() != "") {
                iSO_COUNT = 4;
            }
            else if (txtCAASKSABUN3.GetValue() != "") {
                iSO_COUNT = 3;
            }
            else if (txtCAASKSABUN2.GetValue() != "") {
                iSO_COUNT = 2;
            }
            else if (txtCAASKSABUN1.GetValue() != "") {
                iSO_COUNT = 1;
            }

            fshdnSOApproval = "0";

            if (txtCAASKDATE1.GetValue() != "") {

                fn_Get_Image('S1');

                fshdnSOApproval = "1";
            }

            if (txtCAASKDATE2.GetValue() != "") {
                fn_Get_Image('S2');

                fshdnSOApproval = "2";
            }

            if (txtCAASKDATE3.GetValue() != "") {
                fn_Get_Image('S3');

                fshdnSOApproval = "3";
            }

            if (txtCAASKDATE4.GetValue() != "") {
                fn_Get_Image('S4');

                fshdnSOApproval = "4";
            }

            if (txtCAASKDATE5.GetValue() != "") {
                fn_Get_Image('S5');

                fshdnSOApproval = "5";
            }

            // 수신 결재자
            if (txtCAASKRESABUN5.GetValue() != "") {
                iRE_COUNT = 5;
            }
            else if (txtCAASKRESABUN4.GetValue() != "") {
                iRE_COUNT = 4;
            }
            else if (txtCAASKRESABUN3.GetValue() != "") {
                iRE_COUNT = 3;
            }
            else if (txtCAASKRESABUN2.GetValue() != "") {
                iRE_COUNT = 2;
            }
            else if (txtCAASKRESABUN1.GetValue() != "") {
                iRE_COUNT = 1;
            }

            fshdnREApproval = "0";

            if (txtCAASKREDATE1.GetValue() != "") {
                fn_Get_Image('R1');

                fshdnREApproval = "1";
            }

            if (txtCAASKREDATE2.GetValue() != "") {
                fn_Get_Image('R2');

                fshdnREApproval = "2";
            }

            if (txtCAASKREDATE3.GetValue() != "") {
                fn_Get_Image('R3');

                fshdnREApproval = "3";
            }

            if (txtCAASKREDATE4.GetValue() != "") {
                fn_Get_Image('R4');

                fshdnREApproval = "4";
            }

            if (txtCAASKREDATE5.GetValue() != "") {
                fn_Get_Image('R5');

                fshdnREApproval = "5";
            }

            fshdnSOSign = "";
            
            fn_Get_Approval_Line(iSO_COUNT,                   fshdnSOApproval,
                                 txtCAASKSABUN1.GetValue(), txtCAASKDATE1.GetValue(),
                                 txtCAASKSABUN2.GetValue(), txtCAASKDATE2.GetValue(),
                                 txtCAASKSABUN3.GetValue(), txtCAASKDATE3.GetValue(),
                                 txtCAASKSABUN4.GetValue(), txtCAASKDATE4.GetValue(),
                                 txtCAASKSABUN5.GetValue(), txtCAASKDATE5.GetValue(),
                                 iRE_COUNT,                   fshdnREApproval,
                                 txtCAASKRESABUN1.GetValue(), txtCAASKREDATE1.GetValue(),
                                 txtCAASKRESABUN2.GetValue(), txtCAASKREDATE2.GetValue(),
                                 txtCAASKRESABUN3.GetValue(), txtCAASKREDATE3.GetValue(),
                                 txtCAASKRESABUN4.GetValue(), txtCAASKREDATE4.GetValue(),
                                 txtCAASKRESABUN5.GetValue(), txtCAASKREDATE5.GetValue());
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
            }
            else {
                $("#btnDel").hide();
                $("#btnSave").hide();
                $("#tsPrt").show();
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

                Num = document.getElementById("conBody_ImgCAASKPHOTO" + gubun.substr(1, 1)).src;

                data = Num.split('&');

                control = $("#txtCAASKSABUN" + gubun.substr(1, 1)).val();

                Img_Read(gubun, control, data[1]);

                fshdnSOApproval = gubun.substr(1, 1);
            }
            else {
                Num = document.getElementById("conBody_ImgCAASKREPHOTO" + gubun.substr(1, 1)).src;

                data = Num.split('&');

                control = $("#txtCAASKRESABUN" + gubun.substr(1, 1)).val();

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

            ht["P_DATE"]    = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());
            ht["P_KBSABUN"] = fshdnLoginSabun

            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    // 요청자1
                    txtCAASKSABUN1.SetValue("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>");
                    txtCAASKNAME1.SetValue(DataSet.Tables[0].Rows[0]["KBHANGL"]);
                    txtCAASKJKCD1.SetValue(DataSet.Tables[0].Rows[0]["KBJKCD"]);
                    txtCAASKJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["CDDESC1"]);

                    // 변경요구부서
                    txtCAASKTEAM.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEO"]);

                    // 발의부서
                    txtCAASKBUSEO.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEO"]);
                    pnlCAASKBUSEO.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEONM"]);
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

                        txtCAASKJKCD1.SetValue(DataSet1.Tables[0].Rows[0]["JCCD"]);
                        txtCAASKJKCDNM1.SetValue(DataSet1.Tables[0].Rows[0]["JKDESC"]);
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

            var iSO_COUNT = 0;
            var iRE_COUNT = 0;

            var sDate = "";
            var sTime = "";

            fsboolean = false;

            fshdnSOApproval = "0";
            fshdnREApproval = "0";

            debugger;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_CAASKTEAM"] = txtCAASKTEAM.GetValue();
            ht["P_CAASKDATE"] = Get_Date(txtCAASKDATE.GetValue().replace("-", ""));
            ht["P_CAASKSEQ"]  = Set_Fill3(txtCAASKSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4020", "UP_CHANGEASK_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    debugger;

                    txtCAWOTEAM.SetValue(DataSet.Tables[0].Rows[0]["CAWOTEAM"]);
                    txtCAWODATE.SetValue(DataSet.Tables[0].Rows[0]["CAWODATE"]);
                    txtCAWOSEQ.SetValue(DataSet.Tables[0].Rows[0]["CAWOSEQ"]);

                    // 첨부파일 로드
                    AttachFileLod();

                    /* 요청승인자 */
                    txtCAASKSABUN1.SetValue(DataSet.Tables[0].Rows[0]["CAASKSABUN1"]);
                    txtCAASKJKCD1.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCD1"]);

                    txtCAASKJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCDNM1"]);
                    txtCAASKNAME1.SetValue(DataSet.Tables[0].Rows[0]["CAASKNAME1"]);

                    if (DataSet.Tables[0].Rows[0]["CAASKDATE1"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CAASKDATE1"];
                        sTime = DataSet.Tables[0].Rows[0]["CAASKTIME1"];

                        txtCAASKDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCAASKTIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S1', DataSet.Tables[0].Rows[0]["CAASKSABUN1"], DataSet.Tables[0].Rows[0]["SOIMGNAME1"])

                        fshdnSOApproval = "1";

                        fsboolean = true;
                    }
                    else {
                        txtCAASKDATE1.SetValue("");
                        txtCAASKTIME1.SetValue("");
                    }

                    txtCAASKSABUN2.SetValue(DataSet.Tables[0].Rows[0]["CAASKSABUN2"]);
                    txtCAASKJKCD2.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCD2"]);

                    txtCAASKJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCDNM2"]);
                    txtCAASKNAME2.SetValue(DataSet.Tables[0].Rows[0]["CAASKNAME2"]);

                    if (DataSet.Tables[0].Rows[0]["CAASKDATE2"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CAASKDATE2"];
                        sTime = DataSet.Tables[0].Rows[0]["CAASKTIME2"];

                        txtCAASKDATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCAASKTIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S2', DataSet.Tables[0].Rows[0]["CAASKSABUN2"], DataSet.Tables[0].Rows[0]["SOIMGNAME2"])

                        fshdnSOApproval = "2";
                    }
                    else {
                        txtCAASKDATE2.SetValue("");
                        txtCAASKTIME2.SetValue("");
                    }

                    txtCAASKSABUN3.SetValue(DataSet.Tables[0].Rows[0]["CAASKSABUN3"]);
                    txtCAASKJKCD3.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCD3"]);

                    txtCAASKJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCDNM3"]);
                    txtCAASKNAME3.SetValue(DataSet.Tables[0].Rows[0]["CAASKNAME3"]);

                    if (DataSet.Tables[0].Rows[0]["CAASKDATE3"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CAASKDATE3"];
                        sTime = DataSet.Tables[0].Rows[0]["CAASKTIME3"];

                        txtCAASKDATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCAASKTIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S3', DataSet.Tables[0].Rows[0]["CAASKSABUN3"], DataSet.Tables[0].Rows[0]["SOIMGNAME3"])

                        fshdnSOApproval = "3";
                    }
                    else {
                        txtCAASKDATE3.SetValue("");
                        txtCAASKTIME3.SetValue("");
                    }

                    txtCAASKSABUN4.SetValue(DataSet.Tables[0].Rows[0]["CAASKSABUN4"]);
                    txtCAASKJKCD4.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCD4"]);

                    txtCAASKJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCDNM4"]);
                    txtCAASKNAME4.SetValue(DataSet.Tables[0].Rows[0]["CAASKNAME4"]);

                    if (DataSet.Tables[0].Rows[0]["CAASKDATE4"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CAASKDATE4"];
                        sTime = DataSet.Tables[0].Rows[0]["CAASKTIME4"];

                        txtCAASKDATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCAASKTIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S4', DataSet.Tables[0].Rows[0]["CAASKSABUN4"], DataSet.Tables[0].Rows[0]["SOIMGNAME4"])

                        fshdnSOApproval = "4";
                    }
                    else {
                        txtCAASKDATE4.SetValue("");
                        txtCAASKTIME4.SetValue("");
                    }

                    txtCAASKSABUN5.SetValue(DataSet.Tables[0].Rows[0]["CAASKSABUN5"]);
                    txtCAASKJKCD5.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCD5"]);

                    txtCAASKJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCDNM5"]);
                    txtCAASKNAME5.SetValue(DataSet.Tables[0].Rows[0]["CAASKNAME5"]);

                    if (DataSet.Tables[0].Rows[0]["CAASKDATE5"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CAASKDATE5"];
                        sTime = DataSet.Tables[0].Rows[0]["CAASKTIME5"];

                        txtCAASKDATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCAASKTIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S5', DataSet.Tables[0].Rows[0]["CAASKSABUN5"], DataSet.Tables[0].Rows[0]["SOIMGNAME5"])

                        fshdnSOApproval = "5";
                    }
                    else {
                        txtCAASKDATE5.SetValue("");
                        txtCAASKTIME5.SetValue("");
                    }

                    /* 수신승인자 */
                    txtCAASKRESABUN1.SetValue(DataSet.Tables[0].Rows[0]["CAASKRESABUN1"]);
                    txtCAASKREJKCD1.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCD1"]);

                    txtCAASKREJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCDNM1"]);
                    txtCAASKRENAME1.SetValue(DataSet.Tables[0].Rows[0]["CAASKRENAME1"]);

                    if (DataSet.Tables[0].Rows[0]["CAASKREDATE1"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CAASKREDATE1"];
                        sTime = DataSet.Tables[0].Rows[0]["CAASKRETIME1"];

                        txtCAASKREDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCAASKRETIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R1', DataSet.Tables[0].Rows[0]["CAASKRESABUN1"], DataSet.Tables[0].Rows[0]["REIMGNAME1"])

                        // 현재 수신결재순번
                        fshdnREApproval = "1";
                    }
                    else {
                        txtCAASKREDATE1.SetValue("");
                        txtCAASKRETIME1.SetValue("");
                    }

                    txtCAASKRESABUN2.SetValue(DataSet.Tables[0].Rows[0]["CAASKRESABUN2"]);
                    txtCAASKREJKCD2.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCD2"]);

                    txtCAASKREJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCDNM2"]);
                    txtCAASKRENAME2.SetValue(DataSet.Tables[0].Rows[0]["CAASKRENAME2"]);

                    if (DataSet.Tables[0].Rows[0]["CAASKREDATE2"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CAASKREDATE2"];
                        sTime = DataSet.Tables[0].Rows[0]["CAASKRETIME2"];

                        txtCAASKREDATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCAASKRETIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R2', DataSet.Tables[0].Rows[0]["CAASKRESABUN2"], DataSet.Tables[0].Rows[0]["REIMGNAME2"])

                        // 현재 수신결재순번
                        fshdnREApproval = "2";
                    }
                    else {
                        txtCAASKREDATE2.SetValue("");
                        txtCAASKRETIME2.SetValue("");
                    }

                    txtCAASKRESABUN3.SetValue(DataSet.Tables[0].Rows[0]["CAASKRESABUN3"]);
                    txtCAASKREJKCD3.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCD3"]);

                    txtCAASKREJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCDNM3"]);
                    txtCAASKRENAME3.SetValue(DataSet.Tables[0].Rows[0]["CAASKRENAME3"]);

                    if (DataSet.Tables[0].Rows[0]["CAASKREDATE3"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CAASKREDATE3"];
                        sTime = DataSet.Tables[0].Rows[0]["CAASKRETIME3"];

                        txtCAASKREDATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCAASKRETIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R3', DataSet.Tables[0].Rows[0]["CAASKRESABUN3"], DataSet.Tables[0].Rows[0]["REIMGNAME3"])

                        // 현재 수신결재순번
                        fshdnREApproval = "3";
                    }
                    else {
                        txtCAASKREDATE3.SetValue("");
                        txtCAASKRETIME3.SetValue("");
                    }

                    txtCAASKRESABUN4.SetValue(DataSet.Tables[0].Rows[0]["CAASKRESABUN4"]);
                    txtCAASKREJKCD4.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCD4"]);

                    txtCAASKREJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCDNM4"]);
                    txtCAASKRENAME4.SetValue(DataSet.Tables[0].Rows[0]["CAASKRENAME4"]);

                    if (DataSet.Tables[0].Rows[0]["CAASKREDATE4"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CAASKREDATE4"];
                        sTime = DataSet.Tables[0].Rows[0]["CAASKRETIME4"];

                        txtCAASKREDATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCAASKRETIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R4', DataSet.Tables[0].Rows[0]["CAASKRESABUN4"], DataSet.Tables[0].Rows[0]["REIMGNAME4"])

                        // 현재 수신결재순번
                        fshdnREApproval = "4";
                    }
                    else {
                        txtCAASKREDATE4.SetValue("");
                        txtCAASKRETIME4.SetValue("");
                    }

                    txtCAASKRESABUN5.SetValue(DataSet.Tables[0].Rows[0]["CAASKRESABUN5"]);
                    txtCAASKREJKCD5.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCD5"]);

                    txtCAASKREJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCDNM5"]);
                    txtCAASKRENAME5.SetValue(DataSet.Tables[0].Rows[0]["CAASKRENAME5"]);

                    if (DataSet.Tables[0].Rows[0]["CAASKREDATE5"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CAASKREDATE5"];
                        sTime = DataSet.Tables[0].Rows[0]["CAASKRETIME5"];

                        txtCAASKREDATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCAASKRETIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('R5', DataSet.Tables[0].Rows[0]["CAASKRESABUN5"], DataSet.Tables[0].Rows[0]["REIMGNAME5"])

                        // 현재 수신결재순번
                        fshdnREApproval = "5";
                    }
                    else {
                        txtCAASKREDATE5.SetValue("");
                        txtCAASKRETIME5.SetValue("");
                    }

                    /* 의견 */
                    //txtCAASKCOMMENT1.SetValue(DataSet.Tables[0].Rows[0]["CAASKCOMMENT1"]);
                    //txtCAASKCOMMENT2.SetValue(DataSet.Tables[0].Rows[0]["CAASKCOMMENT2"]);
                    //txtCAASKCOMMENT3.SetValue(DataSet.Tables[0].Rows[0]["CAASKCOMMENT3"]);
                    //txtCAASKCOMMENT4.SetValue(DataSet.Tables[0].Rows[0]["CAASKCOMMENT4"]);
                    //txtCAASKCOMMENT5.SetValue(DataSet.Tables[0].Rows[0]["CAASKCOMMENT5"]);

                    //txtCAASKRECOMMENT1.SetValue(DataSet.Tables[0].Rows[0]["CAASKRECOMMENT1"]);
                    //txtCAASKRECOMMENT2.SetValue(DataSet.Tables[0].Rows[0]["CAASKRECOMMENT2"]);
                    //txtCAASKRECOMMENT3.SetValue(DataSet.Tables[0].Rows[0]["CAASKRECOMMENT3"]);
                    //txtCAASKRECOMMENT4.SetValue(DataSet.Tables[0].Rows[0]["CAASKRECOMMENT4"]);
                    //txtCAASKRECOMMENT5.SetValue(DataSet.Tables[0].Rows[0]["CAASKRECOMMENT5"]);

                    // 발의부서
                    txtCAASKBUSEO.SetValue(DataSet.Tables[0].Rows[0]["CAASKBUSEO"]);
                    pnlCAASKBUSEO.SetValue(DataSet.Tables[0].Rows[0]["CAASKBUSEONM"]);
                    
                    // 설비명 또는 변경요소
                    txtCAASKCONTENT.SetValue(DataSet.Tables[0].Rows[0]["CAASKCONTENT"]);

                    // 변경등급
                    cboCAASKCLASS.SetValue(DataSet.Tables[0].Rows[0]["CAASKCLASS"]);

                    // 변경종류
                    cboCAASKSTEPGN.SetValue(DataSet.Tables[0].Rows[0]["CAASKSTEPGN"]);

                    // 변경개요
                    txtCAASKSUMMARY.SetValue(DataSet.Tables[0].Rows[0]["CAASKSUMMARY"]);

                    // 접수번호년도
                    txtCAASKACYEAR.SetValue(DataSet.Tables[0].Rows[0]["CAASKACYEAR"]);
                    // 접수번호순번
                    txtCAASKACSEQ.SetValue(DataSet.Tables[0].Rows[0]["CAASKACSEQ"]);
                    // 접수일자
                    txtCARECEIPTDATE.SetValue(DataSet.Tables[0].Rows[0]["CARECEIPTDATE"]);


                    if (txtCAASKSABUN5.GetValue() != "") {
                        iSO_COUNT = 5;
                    }
                    else if (txtCAASKSABUN4.GetValue() != "") {
                        iSO_COUNT = 4;
                    }
                    else if (txtCAASKSABUN3.GetValue() != "") {
                        iSO_COUNT = 3;
                    }
                    else if (txtCAASKSABUN2.GetValue() != "") {
                        iSO_COUNT = 2;
                    }
                    else if (txtCAASKSABUN1.GetValue() != "") {
                        iSO_COUNT = 1;
                    }

                    if (txtCAASKRESABUN5.GetValue() != "") {
                        iRE_COUNT = 5;
                    }
                    else if (txtCAASKRESABUN4.GetValue() != "") {
                        iRE_COUNT = 4;
                    }
                    else if (txtCAASKRESABUN3.GetValue() != "") {
                        iRE_COUNT = 3;
                    }
                    else if (txtCAASKRESABUN2.GetValue() != "") {
                        iRE_COUNT = 2;
                    }
                    else if (txtCAASKRESABUN1.GetValue() != "") {
                        iRE_COUNT = 1;
                    }

                    if (iSO_COUNT == parseInt(Get_Numeric(fshdnSOApproval))) // 요청 마지막 결재자
                    {
                        if (iRE_COUNT == parseInt(Get_Numeric(fshdnREApproval))) {
                            // 요구서 작성자      = 변경등급 , 변경종류 수정
                            // 수신자(안전환경팀) = 변경등급만 수정
                            fn_Field_ReadOnly(true, true, true);
                        }
                        else {
                            // 요구서 작성자      = 변경등급 , 변경종류 수정
                            // 수신자(안전환경팀) = 변경등급만 수정
                            fn_Field_ReadOnly(true, true, false);
                        }
                    }
                    else {
                        if (parseInt(Get_Numeric(fshdnSOApproval)) > 0) {
                            // 요구서 작성자      = 변경등급 , 변경종류 수정
                            // 수신자(안전환경팀) = 변경등급만 수정
                            fn_Field_ReadOnly(true, true, true);
                        }
                        else {
                            if (parseInt(Get_Numeric(fshdnSOApproval)) == 0) {

                                // 요구서 작성자      = 변경등급 , 변경종류 수정
                                // 수신자(안전환경팀) = 변경등급만 수정
                                fn_Field_ReadOnly(false, false, false);
                            }
                        }
                    }

                    // 공통코드 가져오기
                    fn_Dataset_Common(txtCAASKSABUN1.GetValue(),   txtCAASKDATE1.GetValue(),
                                      txtCAASKSABUN2.GetValue(),   txtCAASKDATE2.GetValue(),
                                      txtCAASKSABUN3.GetValue(),   txtCAASKDATE3.GetValue(),
                                      txtCAASKSABUN4.GetValue(),   txtCAASKDATE4.GetValue(),
                                      txtCAASKSABUN5.GetValue(),   txtCAASKDATE5.GetValue(),
                                      txtCAASKRESABUN1.GetValue(), txtCAASKREDATE1.GetValue(),
                                      txtCAASKRESABUN2.GetValue(), txtCAASKREDATE2.GetValue(),
                                      txtCAASKRESABUN3.GetValue(), txtCAASKREDATE3.GetValue(),
                                      txtCAASKRESABUN4.GetValue(), txtCAASKREDATE4.GetValue(),
                                      txtCAASKRESABUN5.GetValue(), txtCAASKREDATE5.GetValue());
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
                                   sRESABUN5, sREDATE5)
        {

            var REDOCID;
            var REDOCNUM;

            var sNOWAPP_SOSABUN = ""; // 현재 요청 결재할 사람
            var sNOWAPP_RESABUN = ""; // 현재 요청 결재할 사람

            var sLoginBuseo = "";
            var sRESABUN = "";
            var sRENAME = "";

            var iSO_COUNT = 0;
            
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

            ht["P_REDOCID"]    = 'CA';
            ht["P_REDOCNUM"]   = txtCAASKTEAM.GetValue() + Get_Date(txtCAASKDATE.GetValue().replace("-", "")) + Set_Fill3(txtCAASKSEQ.GetValue());
            ht["P_GUBN"]       = "CA";

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_Get_Ds_Common", function (e) {

                var dsComm = eval(e);

                if (ObjectCount(dsComm.Tables[0].Rows) > 0) {

                    sLoginBuseo = dsComm.Tables[0].Rows[0]["LOGINBUSEO"];

                    sRESABUN    = dsComm.Tables[0].Rows[0]["RESABUN"];
                    sRENAME     = dsComm.Tables[0].Rows[0]["RENAME"];

                    //// 완료 및 확인자
                    //fn_WOFINISH(sLoginBuseo);

                    debugger;

                    // 참조자
                    fn_REFERENCE("INDEX", sRESABUN, sRENAME);

                    // 첨부파일 업로드
                    AttachFileLod();

                    fn_GET_Site();
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
                $("#conBody_ImgCAASKPHOTO" + gubun.substr(1, 1)).attr("src", filepath);
            }
            else {
                $("#conBody_ImgCAASKREPHOTO" + gubun.substr(1, 1)).attr("src", filepath);
            }
        }

        function fn_BLANK_IMAGE() {
            $("#conBody_ImgCAASKPHOTO1").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCAASKPHOTO2").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCAASKPHOTO3").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCAASKPHOTO4").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCAASKPHOTO5").attr("src", "/Resources/Framework/blank.gif");

            $("#conBody_ImgCAASKREPHOTO1").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCAASKREPHOTO2").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCAASKREPHOTO3").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCAASKREPHOTO4").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCAASKREPHOTO5").attr("src", "/Resources/Framework/blank.gif");
        }

        function fn_REFERENCE(gubun, sRESABUN, sRENAME) {

            var ht  = new Object();

            var REDOCID;
            var REDOCNUM;

            ht["P_REDOCID"]  = 'CA';
            ht["P_REDOCNUM"] = txtCAASKTEAM.GetValue() + Get_Date(txtCAASKDATE.GetValue().replace("-", "")) + Set_Fill3(txtCAASKSEQ.GetValue());
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

        //function fn_WOFINISH(sLoginBuseo) {

        //    var iRE_COUNT = 0;

        //    if (txtCAASKRESABUN5.GetValue() != "") {
        //        iRE_COUNT = 5;
        //    }
        //    else if (txtCAASKRESABUN4.GetValue() != "") {
        //        iRE_COUNT = 4;
        //    }
        //    else if (txtCAASKRESABUN3.GetValue() != "") {
        //        iRE_COUNT = 3;
        //    }
        //    else if (txtCAASKRESABUN2.GetValue() != "") {
        //        iRE_COUNT = 2;
        //    }
        //    else if (txtCAASKRESABUN1.GetValue() != "") {
        //        iRE_COUNT = 1;
        //    }

        //    fshdnREApproval = "0";

        //    if (txtCAASKREDATE1.GetValue() != "") {
        //        // 현재 수신결재순번
        //        fshdnREApproval = "1";
        //    }

        //    if (txtCAASKREDATE2.GetValue() != "") {
        //        // 현재 수신결재순번
        //        fshdnREApproval = "2";
        //    }

        //    if (txtCAASKREDATE3.GetValue() != "") {
        //        // 현재 수신결재순번
        //        fshdnREApproval = "3";
        //    }

        //    if (txtCAASKREDATE4.GetValue() != "") {
        //        // 현재 수신결재순번
        //        fshdnREApproval = "4";
        //    }

        //    if (txtCAASKREDATE5.GetValue() != "") {
        //        // 현재 수신결재순번
        //        fshdnREApproval = "5";
        //    }
        //}

        // 결재선지정 버튼 이벤트
        function btnSOApproval_Click() {
            var param;

            param = "";

            param += "../POP/SabunMultiChkPopup5.aspx?callback=fn_PopupCallBack&Data_Cnt1=5&Data_Cnt2=5&GUBUN=CA";

            param += "&param1=" + txtCAASKSABUN1.GetValue();
            param += "&param2=" + txtCAASKSABUN2.GetValue();
            param += "&param3=" + txtCAASKSABUN3.GetValue();
            param += "&param4=" + txtCAASKSABUN4.GetValue();
            param += "&param5=" + txtCAASKSABUN5.GetValue();
            param += "&param6=" + fshdnSOApproval;

            param += "&param11=" + txtCAASKNAME1.GetValue();
            param += "&param12=" + txtCAASKNAME2.GetValue();
            param += "&param13=" + txtCAASKNAME3.GetValue();
            param += "&param14=" + txtCAASKNAME4.GetValue();
            param += "&param15=" + txtCAASKNAME5.GetValue();

            param += "&param21=" + txtCAASKJKCD1.GetValue();
            param += "&param22=" + txtCAASKJKCD2.GetValue();
            param += "&param23=" + txtCAASKJKCD3.GetValue();
            param += "&param24=" + txtCAASKJKCD4.GetValue();
            param += "&param25=" + txtCAASKJKCD5.GetValue();

            param += "&param31=" + txtCAASKJKCDNM1.GetValue();
            param += "&param32=" + txtCAASKJKCDNM2.GetValue();
            param += "&param33=" + txtCAASKJKCDNM3.GetValue();
            param += "&param34=" + txtCAASKJKCDNM4.GetValue();
            param += "&param35=" + txtCAASKJKCDNM5.GetValue();

            param += "&param61=" + txtCAASKRESABUN1.GetValue();
            param += "&param62=" + txtCAASKRESABUN2.GetValue();
            param += "&param63=" + txtCAASKRESABUN3.GetValue();
            param += "&param64=" + txtCAASKRESABUN4.GetValue();
            param += "&param65=" + txtCAASKRESABUN5.GetValue();
            param += "&param66=" + fshdnREApproval;


            param += "&param71=" + txtCAASKRENAME1.GetValue();
            param += "&param72=" + txtCAASKRENAME2.GetValue();
            param += "&param73=" + txtCAASKRENAME3.GetValue();
            param += "&param74=" + txtCAASKRENAME4.GetValue();
            param += "&param75=" + txtCAASKRENAME5.GetValue();

            param += "&param81=" + txtCAASKREJKCD1.GetValue();
            param += "&param82=" + txtCAASKREJKCD2.GetValue();
            param += "&param83=" + txtCAASKREJKCD3.GetValue();
            param += "&param84=" + txtCAASKREJKCD4.GetValue();
            param += "&param85=" + txtCAASKREJKCD5.GetValue();

            param += "&param91=" + txtCAASKREJKCDNM1.GetValue();
            param += "&param92=" + txtCAASKREJKCDNM2.GetValue();
            param += "&param93=" + txtCAASKREJKCDNM3.GetValue();
            param += "&param94=" + txtCAASKREJKCDNM4.GetValue();
            param += "&param95=" + txtCAASKREJKCDNM5.GetValue();

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

                txtCAASKSABUN1.SetValue(items1[0].data.KBSABUN);
                txtCAASKJKCD1.SetValue(items1[0].data.JKCODE);
                txtCAASKJKCDNM1.SetValue(items1[0].data.CDDESC1);
                txtCAASKNAME1.SetValue(items1[0].data.KBHANGL);
            }

            if (items1.length > 1) {

                if (txtCAASKSABUN1.GetValue() == items1[1].data.KBSABUN)
                {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청승인자를 확인하세요." Literal="true"></Ctl:Text>');
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtCAASKSABUN2.SetValue(items1[1].data.KBSABUN);
                txtCAASKJKCD2.SetValue(items1[1].data.JKCODE);
                txtCAASKJKCDNM2.SetValue(items1[1].data.CDDESC1);
                txtCAASKNAME2.SetValue(items1[1].data.KBHANGL);
            }

            if (items1.length > 2) {

                if (txtCAASKSABUN1.GetValue() == items1[2].data.KBSABUN)
                {
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtCAASKSABUN3.SetValue(items1[2].data.KBSABUN);
                txtCAASKJKCD3.SetValue(items1[2].data.JKCODE);
                txtCAASKJKCDNM3.SetValue(items1[2].data.CDDESC1);
                txtCAASKNAME3.SetValue(items1[2].data.KBHANGL);
            }

            if (items1.length > 3) {

                if (txtCAASKSABUN1.GetValue() == items1[3].data.KBSABUN)
                {
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtCAASKSABUN4.SetValue(items1[3].data.KBSABUN);
                txtCAASKJKCD4.SetValue(items1[3].data.JKCODE);
                txtCAASKJKCDNM4.SetValue(items1[3].data.CDDESC1);
                txtCAASKNAME4.SetValue(items1[3].data.KBHANGL);
            }

            if (items1.length > 4) {

                if (txtCAASKSABUN1.GetValue() == items1[4].data.KBSABUN)
                {
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtCAASKSABUN5.SetValue(items1[4].data.KBSABUN);
                txtCAASKJKCD5.SetValue(items1[4].data.JKCODE);
                txtCAASKJKCDNM5.SetValue(items1[4].data.CDDESC1);
                txtCAASKNAME5.SetValue(items1[4].data.KBHANGL);
            }

            // 수신결재
            // 필드 클리어
            fn_Field_clear(2);

            if (items2.length > 0) {
                    txtCAASKRESABUN1.SetValue(items2[0].data.KBSABUN);
                    txtCAASKREJKCD1.SetValue(items2[0].data.JKCODE);
                    txtCAASKREJKCDNM1.SetValue(items2[0].data.CDDESC1);
                    txtCAASKRENAME1.SetValue(items2[0].data.KBHANGL);
            }
            if (items2.length > 1) {
                    txtCAASKRESABUN2.SetValue(items2[1].data.KBSABUN);
                    txtCAASKREJKCD2.SetValue(items2[1].data.JKCODE);
                    txtCAASKREJKCDNM2.SetValue(items2[1].data.CDDESC1);
                    txtCAASKRENAME2.SetValue(items2[1].data.KBHANGL);
            }
            if (items2.length > 2) {
                    txtCAASKRESABUN3.SetValue(items2[2].data.KBSABUN);
                    txtCAASKREJKCD3.SetValue(items2[2].data.JKCODE);
                    txtCAASKREJKCDNM3.SetValue(items2[2].data.CDDESC1);
                    txtCAASKRENAME3.SetValue(items2[2].data.KBHANGL);
            }
            if (items2.length > 3) {
                    txtCAASKRESABUN4.SetValue(items2[3].data.KBSABUN);
                    txtCAASKREJKCD4.SetValue(items2[3].data.JKCODE);
                    txtCAASKREJKCDNM4.SetValue(items2[3].data.CDDESC1);
                    txtCAASKRENAME4.SetValue(items2[3].data.KBHANGL);
            }
            if (items2.length > 4) {
                    txtCAASKRESABUN5.SetValue(items2[4].data.KBSABUN);
                    txtCAASKREJKCD5.SetValue(items2[4].data.JKCODE);
                    txtCAASKREJKCDNM5.SetValue(items2[4].data.CDDESC1);
                    txtCAASKRENAME5.SetValue(items2[4].data.KBHANGL);
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

            if (items1.length > 0) {

                var today = new Date();

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["P_DATE"] = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());
                ht["P_KBSABUN"] = txtCAASKSABUN1.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        txtCAASKBUSEO.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEO"]);
                        pnlCAASKBUSEO.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEONM"]);
                        
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재선 지정 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
            else {
                txtCAASKBUSEO.SetValue('');
                pnlCAASKBUSEO.SetValue('');
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
                txtCAASKSABUN2.SetValue('');
                txtCAASKJKCD2.SetValue('');
                txtCAASKJKCDNM2.SetValue('');
                txtCAASKNAME2.SetValue('');

                txtCAASKSABUN3.SetValue('');
                txtCAASKJKCD3.SetValue('');
                txtCAASKJKCDNM3.SetValue('');
                txtCAASKNAME3.SetValue('');

                txtCAASKSABUN4.SetValue('');
                txtCAASKJKCD4.SetValue('');
                txtCAASKJKCDNM4.SetValue('');
                txtCAASKNAME4.SetValue('');

                txtCAASKSABUN5.SetValue('');
                txtCAASKJKCD5.SetValue('');
                txtCAASKJKCDNM5.SetValue('');
                txtCAASKNAME5.SetValue('');
            }
            else if (gubun == '2') {
                txtCAASKRESABUN1.SetValue('');
                txtCAASKREJKCD1.SetValue('');
                txtCAASKREJKCDNM1.SetValue('');
                txtCAASKRENAME1.SetValue('');

                txtCAASKRESABUN2.SetValue('');
                txtCAASKREJKCD2.SetValue('');
                txtCAASKREJKCDNM2.SetValue('');
                txtCAASKRENAME2.SetValue('');

                txtCAASKRESABUN3.SetValue('');
                txtCAASKREJKCD3.SetValue('');
                txtCAASKREJKCDNM3.SetValue('');
                txtCAASKRENAME3.SetValue('');

                txtCAASKRESABUN4.SetValue('');
                txtCAASKREJKCD4.SetValue('');
                txtCAASKREJKCDNM4.SetValue('');
                txtCAASKRENAME4.SetValue('');

                txtCAASKRESABUN5.SetValue('');
                txtCAASKREJKCD5.SetValue('');
                txtCAASKREJKCDNM5.SetValue('');
                txtCAASKRENAME5.SetValue('');
            }
            else {
                fsRESABUN = '';
                //txtRESABUN.SetValue('');
                txtRENAME.SetValue('');
            }
        }

        // 결재 버튼 이벤트
        function btnApproval_Click() {
            doDisplay();

            fn_Screen_Save("APPROVAL");

            //setTimeout("doDisplay()", '3000');
        }

        // 결재 철회 이벤트
        function btnRETRACT_Click() {
            doDisplay();

            fn_RETRACT_Proc();

            setTimeout("doDisplay()", '5000');
        }
        
        // 반려 버튼 이벤트
        function btnCancel_Click() {
            doDisplay();

            fn_CANCEL_Proc();

            //setTimeout("doDisplay()", '3000');
        }

        // 저장 버튼 이벤트
        function btnSave_Click() {
            doDisplay();

            fn_Screen_Save("SAVE");

            setTimeout("doDisplay()", '5000');
        }

        // 삭제 버튼 이벤트
        function btnDel_Click() {

            doDisplay();

            // 접수일자 체크
            if (fsboolean == true) {

                doDisplay();
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="변경요구서 결재가 처리되었으므로 삭제가 불가합니다." Literal="true"></Ctl:Text>');
                return;
            }

            var ht = new Object();

            ht["P_ATTACH_TYPE"] = "CA";
            ht["P_ATTACH_NO"]   = txtCAASKTEAM.GetValue() + Get_Date(txtCAASKDATE.GetValue().replace("-", "")) + Set_Fill3(txtCAASKSEQ.GetValue());
            ht["P_CAASKTEAM"]   = txtCAASKTEAM.GetValue();
            ht["P_CAASKDATE"]   = Get_Date(txtCAASKDATE.GetValue().replace("-", ""));
            ht["P_CAASKSEQ"]    = Set_Fill3(txtCAASKSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4020", "UP_CHANGEASK_DEL", function (e) {

                var DataSet = eval(e);

                debugger;
                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        fn_REFERENCE('DEL', '', '');

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

            setTimeout("doDisplay()", '3000');
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

            var sPGURL = "";
            var sAPNUM = "";

            debugger;

            sAPNUM = txtCAASKTEAM.GetValue() + "-" + Get_Date(txtCAASKDATE.GetValue().replace("-", "")) + "-" + Set_Fill3(txtCAASKSEQ.GetValue());

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            sPGURL = "/Portal/PSM/PSM40/PSM4021.aspx?";
            sPGURL = sPGURL + "APP_NUM=";
            sPGURL = sPGURL + sAPNUM;

            debugger;

            ht["P_CAASKTEAM"]    = txtCAASKTEAM.GetValue();
            ht["P_CAASKDATE"]    = Get_Date(txtCAASKDATE.GetValue().replace("-", ""));
            ht["P_CAASKSEQ"]     = Set_Fill3(txtCAASKSEQ.GetValue());

            ht["P_APNUM"]        = txtCAASKTEAM.GetValue() + Get_Date(txtCAASKDATE.GetValue().replace("-", "")) + Set_Fill3(txtCAASKSEQ.GetValue());
            ht["P_CAASKCONTENT"] = txtCAASKCONTENT.GetValue();
            ht["P_SENDER"]       = txtCAASKSABUN1.GetValue();
            ht["P_RECEIVER"]     = txtCAASKSABUN1.GetValue();

            // 작업요청서 철회
            PageMethods.InvokeServiceTable(ht, "PSM.PSM4020", "UP_CHANGEASK_RETRACT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재가 철회 되었습니다." Literal="true"></Ctl:Text>');

                        fn_Btn_Visible('3');

                        fn_GET_Display();

                        fn_GET_Site();

                        // 요구서 작성자      = 변경등급 , 변경종류 수정
                        // 수신자(안전환경팀) = 변경등급만 수정
                        fn_Field_ReadOnly(false, false, false);

                        // 공백이미지
                        fn_BLANK_IMAGE();
                    }
                }
            }, function (e) {
            });

        }

        // 취소 함수
        function fn_CANCEL_Proc() {

            var gubun = "";
            var WOCANCELCOMMENT = "";
            var CAASKSABUN1 = "";
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_CAASKTEAM"] = txtCAASKTEAM.GetValue();
            ht["P_CAASKDATE"] = Get_Date(txtCAASKDATE.GetValue().replace("-", ""));
            ht["P_CAASKSEQ"] = Set_Fill3(txtCAASKSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4020", "UP_CHANGEASK_CANCEL", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        debugger;
                        // 메일 발송
                        fn_Mail_Send(txtCAASKTEAM.GetValue(), Get_Date(txtCAASKDATE.GetValue().replace("-", "")), txtCAASKSEQ.GetValue(), txtCAASKSABUN1.GetValue(), "CANCEL");

                        debugger;
                        //fn_GET_Display();

                        //fn_GET_Site();

                        // 공백 이미지
                        //fn_BLANK_IMAGE();

                        //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="변경요구서 취소 처리가 되었습니다." Literal="true"></Ctl:Text>');

                        //fn_Btn_Visible('3');
                    }
                    else {

                    }
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="변경요구서 취소 처리중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });

        }


        function fn_Screen_Save(Gubun) {

            fn_Save
                (
                    txtCAASKTEAM.GetValue(),
                    Get_Date(txtCAASKDATE.GetValue().replace("-", "")),
                    txtCAASKSEQ.GetValue(),
                    txtCAWOTEAM.GetValue(),                                // 요청번호(팀)
                    Get_Date(txtCAWODATE.GetValue().replace("-", "")),     // 요청번호(일자)
                    txtCAWOSEQ.GetValue(),                                 // 요청번호(순번)
                    txtCAASKCONTENT.GetValue(),   // 설비명 또는 변경요소
                    txtCAASKBUSEO.GetValue(),     // 발의부서
                    cboCAASKCLASS.GetValue(),     // 변경등급
                    cboCAASKSTEPGN.GetValue(),    // 변경종류(1 = 화물(청소미포함), 2 = 화물(청소포함), 3 = 정상, 4 = 임시, 5 = 비상
	                txtCAASKSUMMARY.GetValue(),   // 변경개요
                    txtCAASKSABUN1.GetValue(),
                    txtCAASKNAME1.GetValue(),
                    txtCAASKJKCD1.GetValue(),
                    txtCAASKJKCDNM1.GetValue(),
                    "",//txtCAASKCOMMENT1.GetValue(),
                    txtCAASKSABUN2.GetValue(),
                    txtCAASKNAME2.GetValue(),
                    txtCAASKJKCD2.GetValue(),
                    txtCAASKJKCDNM2.GetValue(),
                    "",//txtCAASKCOMMENT2.GetValue(),
                    txtCAASKSABUN3.GetValue(),
                    txtCAASKNAME3.GetValue(),
                    txtCAASKJKCD3.GetValue(),
                    txtCAASKJKCDNM3.GetValue(),
                    "",//txtCAASKCOMMENT3.GetValue(),
                    txtCAASKSABUN4.GetValue(),
                    txtCAASKNAME4.GetValue(),
                    txtCAASKJKCD4.GetValue(),
                    txtCAASKJKCDNM4.GetValue(),
                    "",//txtCAASKCOMMENT4.GetValue(),
                    txtCAASKSABUN5.GetValue(),
                    txtCAASKNAME5.GetValue(),
                    txtCAASKJKCD5.GetValue(),
                    txtCAASKJKCDNM5.GetValue(),
                    "",//txtCAASKCOMMENT5.GetValue(),
                    txtCAASKRESABUN1.GetValue(),
                    txtCAASKRENAME1.GetValue(),
                    txtCAASKREJKCD1.GetValue(),
                    txtCAASKREJKCDNM1.GetValue(),
                    "",//txtCAASKRECOMMENT1.GetValue(),
                    txtCAASKRESABUN2.GetValue(),
                    txtCAASKRENAME2.GetValue(),
                    txtCAASKREJKCD2.GetValue(),
                    txtCAASKREJKCDNM2.GetValue(),
                    "",//txtCAASKRECOMMENT2.GetValue(),
                    txtCAASKRESABUN3.GetValue(),
                    txtCAASKRENAME3.GetValue(),
                    txtCAASKREJKCD3.GetValue(),
                    txtCAASKREJKCDNM3.GetValue(),
                    "",//txtCAASKRECOMMENT3.GetValue(),
                    txtCAASKRESABUN4.GetValue(),
                    txtCAASKRENAME4.GetValue(),
                    txtCAASKREJKCD4.GetValue(),
                    txtCAASKREJKCDNM4.GetValue(),
                    "",//txtCAASKRECOMMENT4.GetValue(),
                    txtCAASKRESABUN5.GetValue(),
                    txtCAASKRENAME5.GetValue(),
                    txtCAASKREJKCD5.GetValue(),
                    txtCAASKREJKCDNM5.GetValue(),
                    "",//txtCAASKRECOMMENT5.GetValue(),
                    Gubun.toString()
            );
        }

        
        function fn_Save(
            sCAASKTEAM,       sCAASKDATE,       sCAASKSEQ,
            sCAWOTEAM,        sCAWODATE,        sCAWOSEQ,
            sCAASKCONTENT,    sCAASKBUSEO,      sCAASKCLASS,
            sCAASKSTEPGN,     sCAASKSUMMARY,
            sCAASKSABUN1,     sCAASKNAME1,      sCAASKJKCD1,
            sCAASKJKCDNM1,    sCAASKCOMMENT1,
            sCAASKSABUN2,     sCAASKNAME2,      sCAASKJKCD2,
            sCAASKJKCDNM2,    sCAASKCOMMENT2,
            sCAASKSABUN3,     sCAASKNAME3,      sCAASKJKCD3,
            sCAASKJKCDNM3,    sCAASKCOMMENT3,
            sCAASKSABUN4,     sCAASKNAME4,      sCAASKJKCD4,
            sCAASKJKCDNM4,    sCAASKCOMMENT4,
            sCAASKSABUN5,     sCAASKNAME5,      sCAASKJKCD5,
            sCAASKJKCDNM5,    sCAASKCOMMENT5,
            sCAASKRESABUN1,   sCAASKRENAME1,    sCAASKREJKCD1,
            sCAASKREJKCDNM1,  sCAASKRECOMMENT1,
            sCAASKRESABUN2,   sCAASKRENAME2,    sCAASKREJKCD2,
            sCAASKREJKCDNM2,  sCAASKRECOMMENT2,
            sCAASKRESABUN3,   sCAASKRENAME3,    sCAASKREJKCD3,
            sCAASKREJKCDNM3,  sCAASKRECOMMENT3,
            sCAASKRESABUN4,   sCAASKRENAME4,    sCAASKREJKCD4,
            sCAASKREJKCDNM4,  sCAASKRECOMMENT4,
            sCAASKRESABUN5,   sCAASKRENAME5,    sCAASKREJKCD5,
            sCAASKREJKCDNM5,  sCAASKRECOMMENT5, sGUBUN)
        {
            if (sCAASKCONTENT.toString() == "") {

                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비명 또는 변경요소를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (sCAASKSUMMARY.toString() == "") {

                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="변경개요를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (sCAASKRESABUN1.toString() == "" || sCAASKRENAME1.toString() == "") {

                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="수신처를 선택하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var i = 0;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_WOORTEAM"] = sCAWOTEAM.toString();
            ht["P_WOORDATE"] = sCAWODATE.toString();
            ht["P_WOSEQ"]    = sCAWOSEQ.toString();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4020", "UP_FIELDCHECK", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    var iSO_COUNT = 0;
                    var iRE_COUNT = 0;

                    if (sCAASKSABUN5.toString() != "") {
                        iSO_COUNT = 5;
                    }
                    else if (sCAASKSABUN4.toString() != "") {
                        iSO_COUNT = 4;
                    }
                    else if (sCAASKSABUN3.toString() != "") {
                        iSO_COUNT = 3;
                    }
                    else if (sCAASKSABUN2.toString() != "") {
                        iSO_COUNT = 2;
                    }
                    else if (sCAASKSABUN1.toString() != "") {
                        iSO_COUNT = 1;
                    }

                    if (sCAASKRESABUN5.toString() != "") {
                        iRE_COUNT = 5;
                    }
                    else if (sCAASKRESABUN4.toString() != "") {
                        iRE_COUNT = 4;
                    }
                    else if (sCAASKRESABUN3.toString() != "") {
                        iRE_COUNT = 3;
                    }
                    else if (sCAASKRESABUN2.toString() != "") {
                        iRE_COUNT = 2;
                    }
                    else if (sCAASKRESABUN1.toString() != "") {
                        iRE_COUNT = 1;
                    }


                    //if (iSO_COUNT == parseInt(Get_Numeric(fshdnSOApproval.toString())) + 1) // 요청 마지막 결재자
                    //{
                    //    iSO_COUNT = iSO_COUNT;
                    //}
                    //else // 요청 다음 결재자
                    //{
                    //    if (iSO_COUNT != parseInt(Get_Numeric(fshdnSOApproval.toString()))) {
                    //        if (fshdnSOApproval.toString() == "") {
                    //            iSO_COUNT = 1;
                    //        }
                    //        else if (fshdnSOApproval.toString() == "1") {
                    //            iSO_COUNT = 2;
                    //        }
                    //        else if (fshdnSOApproval.toString() == "2") {
                    //            iSO_COUNT = 3;
                    //        }
                    //        else if (fshdnSOApproval.toString() == "3") {
                    //            iSO_COUNT = 4;
                    //        }
                    //        else if (fshdnSOApproval.toString() == "4") {
                    //            iSO_COUNT = 5;
                    //        }
                    //    }
                    //}

                    //if (iSO_COUNT == parseInt(Get_Numeric(fshdnSOApproval.toString()))) {
                    //    if (iRE_COUNT == parseInt(Get_Numeric(fshdnREApproval.toString())) + 1) // 수신 마지막 결재자
                    //    {
                    //        iSO_COUNT = 0;

                    //        iRE_COUNT = iRE_COUNT;
                    //    }
                    //    else // 수신 다음 결재자
                    //    {
                    //        iSO_COUNT = 0;

                    //        if (fshdnREApproval.toString() == "") {
                    //            iRE_COUNT = 1;
                    //        }
                    //        else if (fshdnREApproval.toString() == "1") {
                    //            iRE_COUNT = 2;
                    //        }
                    //        else if (fshdnREApproval.toString() == "2") {
                    //            iRE_COUNT = 3;
                    //        }
                    //        else if (fshdnREApproval.toString() == "3") {
                    //            iRE_COUNT = 4;
                    //        }
                    //        else if (fshdnREApproval.toString() == "4") {
                    //            iRE_COUNT = 5;
                    //        }
                    //    }
                    //}

                    var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                    ht1["P_CAASKTEAM"]       = sCAASKTEAM;
                    ht1["P_CAASKDATE"]       = sCAASKDATE;
                    ht1["P_CAWOTEAM"]        = sCAWOTEAM;
                    ht1["P_CAWODATE"]        = sCAWODATE;
                    ht1["P_CAWOSEQ"]         = sCAWOSEQ;
                    ht1["P_CAASKCONTENT"]    = sCAASKCONTENT;
                    ht1["P_CAASKBUSEO"]      = sCAASKBUSEO;
                    ht1["P_CAASKCLASS"]      = sCAASKCLASS;
                    ht1["P_CAASKSTEPGN"]     = sCAASKSTEPGN;
                    ht1["P_CAASKSUMMARY"]    = sCAASKSUMMARY;
                    ht1["P_CAASKSABUN1"]     = sCAASKSABUN1;
                    ht1["P_CAASKNAME1"]      = sCAASKNAME1;
                    ht1["P_CAASKJKCD1"]      = sCAASKJKCD1;
                    ht1["P_CAASKJKCDNM1"]    = sCAASKJKCDNM1;
                    ht1["P_CAASKCOMMENT1"]   = sCAASKCOMMENT1;
                    ht1["P_CAASKSABUN2"]     = sCAASKSABUN2;
                    ht1["P_CAASKNAME2"]      = sCAASKNAME2;
                    ht1["P_CAASKJKCD2"]      = sCAASKJKCD2;
                    ht1["P_CAASKJKCDNM2"]    = sCAASKJKCDNM2;
                    ht1["P_CAASKCOMMENT2"]   = sCAASKCOMMENT2;
                    ht1["P_CAASKSABUN3"]     = sCAASKSABUN3;
                    ht1["P_CAASKNAME3"]      = sCAASKNAME3;
                    ht1["P_CAASKJKCD3"]      = sCAASKJKCD3;
                    ht1["P_CAASKJKCDNM3"]    = sCAASKJKCDNM3;
                    ht1["P_CAASKCOMMENT3"]   = sCAASKCOMMENT3;
                    ht1["P_CAASKSABUN4"]     = sCAASKSABUN4;
                    ht1["P_CAASKNAME4"]      = sCAASKNAME4;
                    ht1["P_CAASKJKCD4"]      = sCAASKJKCD4;
                    ht1["P_CAASKJKCDNM4"]    = sCAASKJKCDNM4;
                    ht1["P_CAASKCOMMENT4"]   = sCAASKCOMMENT4;
                    ht1["P_CAASKSABUN5"]     = sCAASKSABUN5;
                    ht1["P_CAASKNAME5"]      = sCAASKNAME5;
                    ht1["P_CAASKJKCD5"]      = sCAASKJKCD5;
                    ht1["P_CAASKJKCDNM5"]    = sCAASKJKCDNM5;
                    ht1["P_CAASKCOMMENT5"]   = sCAASKCOMMENT5;
                    ht1["P_CAASKRESABUN1"]   = sCAASKRESABUN1;
                    ht1["P_CAASKRENAME1"]    = sCAASKRENAME1;
                    ht1["P_CAASKREJKCD1"]    = sCAASKREJKCD1;
                    ht1["P_CAASKREJKCDNM1"]  = sCAASKREJKCDNM1;
                    ht1["P_CAASKRECOMMENT1"] = sCAASKRECOMMENT1;
                    ht1["P_CAASKRESABUN2"]   = sCAASKRESABUN2;
                    ht1["P_CAASKRENAME2"]    = sCAASKRENAME2;
                    ht1["P_CAASKREJKCD2"]    = sCAASKREJKCD2;
                    ht1["P_CAASKREJKCDNM2"]  = sCAASKREJKCDNM2;
                    ht1["P_CAASKRECOMMENT2"] = sCAASKRECOMMENT2;
                    ht1["P_CAASKRESABUN3"]   = sCAASKRESABUN3;
                    ht1["P_CAASKRENAME3"]    = sCAASKRENAME3;
                    ht1["P_CAASKREJKCD3"]    = sCAASKREJKCD3;
                    ht1["P_CAASKREJKCDNM3"]  = sCAASKREJKCDNM3;
                    ht1["P_CAASKRECOMMENT3"] = sCAASKRECOMMENT3;
                    ht1["P_CAASKRESABUN4"]   = sCAASKRESABUN4;
                    ht1["P_CAASKRENAME4"]    = sCAASKRENAME4;
                    ht1["P_CAASKREJKCD4"]    = sCAASKREJKCD4;
                    ht1["P_CAASKREJKCDNM4"]  = sCAASKREJKCDNM4;
                    ht1["P_CAASKRECOMMENT4"] = sCAASKRECOMMENT4;
                    ht1["P_CAASKRESABUN5"]   = sCAASKRESABUN5;
                    ht1["P_CAASKRENAME5"]    = sCAASKRENAME5;
                    ht1["P_CAASKREJKCD5"]    = sCAASKREJKCD5;
                    ht1["P_CAASKREJKCDNM5"]  = sCAASKREJKCDNM5;
                    ht1["P_CAASKRECOMMENT5"] = sCAASKRECOMMENT5;
                    ht1["P_CAASKHISAB"]      = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
                    ht1["P_RESABUN"]         = fsRESABUN;
                    ht1["P_RENAME"]          = txtRENAME.GetValue();
                    ht1["P_SOCOUNT"]         = iSO_COUNT;
                    ht1["P_RECOUNT"]         = iRE_COUNT;
                    ht1["P_SOAPPROVAL"]      = Get_Numeric(fshdnSOApproval);
                    ht1["P_REAPPROVAL"]      = Get_Numeric(fshdnREApproval);
                    ht1["P_GUBUN"] = sGUBUN;

                    debugger;

                    if (fshdnExists.toString() == "NEW") {

                        debugger;

                        ht["P_CAASKTEAM"] = sCAASKTEAM.toString();
                        ht["P_CAASKDATE"] = sCAASKDATE.toString();

                        PageMethods.InvokeServiceTable(ht, "PSM.PSM4020", "UP_PSM4021_GET_MAX_SEQ", function (e) {

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                                txtCAASKSEQ.SetValue(DataSet.Tables[0].Rows[0]["CAASKSEQ"]);

                                sCAASKSEQ = txtCAASKSEQ.GetValue();

                                debugger;

                                ht1["P_CAASKSEQ"] = sCAASKSEQ;

                                // 저장 및 결재
                                PageMethods.InvokeServiceTable(ht1, "PSM.PSM4020", "UP_CHANGEASK_DOC_APPROVAL", function (e) {

                                    var DataSet1 = eval(e);

                                    debugger;

                                    if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                                        // 첨부파일 저장
                                        UploadStart(GetAttachFile_Callback);

                                        fshdnExists = "EXISTS";

                                        if (sGUBUN.toString() == "APPROVAL") {

                                            // 메일수신자 가져오기
                                            sKBSABUN = fn_GET_Mail_Sabun(iSO_COUNT,      fshdnSOApproval, iRE_COUNT,      fshdnREApproval,
                                                                         sCAASKSABUN1,   sCAASKSABUN2,    sCAASKSABUN3,   sCAASKSABUN4,    sCAASKSABUN5,
                                                                         sCAASKRESABUN1, sCAASKRESABUN2,  sCAASKRESABUN3, sCAASKRESABUN4,  sCAASKRESABUN5);

                                            txtCAASKTEAM.SetValue(sCAASKTEAM);
                                            txtCAASKDATE.SetValue(sCAASKDATE.substr(0, 4) + "-" + sCAASKDATE.substr(4, 2) + "-" + sCAASKDATE.substr(6, 2));
                                            txtCAASKSEQ.SetValue(sCAASKSEQ);

                                            // 결재 사인 DISPLAY
                                            fn_APPROVAL_Display(DataSet1, sCAASKTEAM, sCAASKDATE, sCAASKSEQ, sKBSABUN.toString(), "OK");

                                            fn_Btn_Visible('3');

                                            //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');
                                        }
                                        else {
                                            // 요구서 작성자      = 변경등급 , 변경종류 수정
                                            // 수신자(안전환경팀) = 변경등급만 수정
                                            fn_Field_ReadOnly(false, false, false);

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

                        ht1["P_CAASKSEQ"] = sCAASKSEQ;

                        PageMethods.InvokeServiceTable(ht1, "PSM.PSM4020", "UP_CHANGEASK_DOC_APPROVAL", function (e) {

                            fshdnExists = "EXISTS";

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                                // 첨부파일 저장
                                UploadStart(GetAttachFile_Callback);

                                if (sGUBUN.toString() == "APPROVAL") {

                                    // 메일수신자 가져오기
                                    sKBSABUN = fn_GET_Mail_Sabun(iSO_COUNT,      fshdnSOApproval, iRE_COUNT,      fshdnREApproval,
                                                                 sCAASKSABUN1,   sCAASKSABUN2,    sCAASKSABUN3,   sCAASKSABUN4,    sCAASKSABUN5,
                                                                 sCAASKRESABUN1, sCAASKRESABUN2,  sCAASKRESABUN3, sCAASKRESABUN4,  sCAASKRESABUN5);

                                    txtCAASKTEAM.SetValue(sCAASKTEAM);
                                    txtCAASKDATE.SetValue(sCAASKDATE.substr(0, 4) + "-" + sCAASKDATE.substr(4, 2) + "-" + sCAASKDATE.substr(6, 2));
                                    txtCAASKSEQ.SetValue(sCAASKSEQ);

                                    // 결재 사인 DISPLAY
                                    fn_APPROVAL_Display(DataSet, sCAASKTEAM, sCAASKDATE, sCAASKSEQ, sKBSABUN.toString(), "OK");

                                    fn_Btn_Visible('3');

                                    //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');
                                }
                                else {

                                    // 요구서 작성자      = 변경등급 , 변경종류 수정
                                    // 수신자(안전환경팀) = 변경등급만 수정
                                    fn_Field_ReadOnly(false, false, false);

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

            WKNUM = txtCAASKTEAM.GetValue() + Get_Date(txtCAASKDATE.GetValue().replace("-", "")) + Set_Fill3(txtCAASKSEQ.GetValue());

            fuName1.FileSave("CA", WKNUM.toString(), function () { });

            // 첨부파일 load
            AttachFileLod();
        }

        function AttachFileLod() {

            debugger;

            var WKNUM = "";

            WKNUM = txtCAASKTEAM.GetValue() + Get_Date(txtCAASKDATE.GetValue().replace("-", "")) + Set_Fill3(txtCAASKSEQ.GetValue());


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

            fuName1.FileLoad("CA", WKNUM, function () {
                // 로드완료

                // 프로그래스바 닫기
                PageProgressHide();
            });

        }


        function fn_Mail_Send(sCAASKTEAM, sCAASKDATE, sCAASKSEQ, sMail_Receiver, sGUBUN) {

            var sTitle     = "";

            var sPGURL     = "";
            var sWOWORKDOC = "";
            var sAPNUM     = "";

            var iRE_COUNT = 0;
            var sRE_GUBUN = "";
            var sCAASKCLASS = "";

            sAPNUM = txtCAWOTEAM.GetValue() + "-" + Get_Date(txtCAWODATE.GetValue().replace("-", "")) + "-" + Set_Fill3(txtCAWOSEQ.GetValue());

            sAPNUM = sAPNUM + "-" + sCAASKTEAM.toString() + "-" + sCAASKDATE.toString() + "-" + Set_Fill3(sCAASKSEQ.toString());

            //sPGURL = "/Portal/PSM/PSM40/PSM4021.aspx?";
            //sPGURL = sPGURL + "APP_NUM=";
            //sPGURL = sPGURL + sAPNUM;
            //sPGURL = sPGURL + "^GUBUN=G";

            sPGURL = "/Portal/PSM/PSM40/PSM4021.aspx?";
            sPGURL = sPGURL + "param=UPT&param1=";
            sPGURL = sPGURL + sAPNUM;

            if (sGUBUN == 'OK') {

                if (txtCAASKRESABUN5.GetValue() != "") {
                    iRE_COUNT = 5;
                }
                else if (txtCAASKRESABUN4.GetValue() != "") {
                    iRE_COUNT = 4;
                }
                else if (txtCAASKRESABUN3.GetValue() != "") {
                    iRE_COUNT = 3;
                }
                else if (txtCAASKRESABUN2.GetValue() != "") {
                    iRE_COUNT = 2;
                }
                else if (txtCAASKRESABUN1.GetValue() != "") {
                    iRE_COUNT = 1;
                }

                if (txtCAASKSABUN5.GetValue() != "") {
                    iSO_COUNT = 5;
                }
                else if (txtCAASKSABUN4.GetValue() != "") {
                    iSO_COUNT = 4;
                }
                else if (txtCAASKSABUN3.GetValue() != "") {
                    iSO_COUNT = 3;
                }
                else if (txtCAASKSABUN2.GetValue() != "") {
                    iSO_COUNT = 2;
                }
                else if (txtCAASKSABUN1.GetValue() != "") {
                    iSO_COUNT = 1;
                }


                sRE_GUBUN = "";

                if (iSO_COUNT == parseInt(Get_Numeric(fshdnSOApproval))) // 요청 마지막 결재자
                {
                    if (fshdnREApproval == "0") {

                        sRE_GUBUN = "FIRST";
                    }
                }

                if (parseInt(Get_Numeric(fshdnREApproval)) == iRE_COUNT) {

                    sRE_GUBUN = "LAST";

                    sTitle = txtCAASKCONTENT.GetValue() + " - 변경요구서 완료";
                    sCAASKCLASS = cboCAASKCLASS.GetValue();                    
                }
                else {
                    if (sRE_GUBUN == "FIRST") {
                        sTitle = txtCAASKCONTENT.GetValue() + " - 변경요구서 제출(변경등급판정 필요)";
                        sCAASKCLASS = "";
                    }
                    else {
                        sTitle = txtCAASKCONTENT.GetValue() + " - 변경요구서 제출";
                        sCAASKCLASS = "";
                    }
                    
                }
            }
            else {
                sTitle = txtCAASKCONTENT.GetValue() + " - 변경요구서 취소";
                sCAASKCLASS = "";
            }

            var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht1["P_APNUM"]        = sAPNUM.toString();
            ht1["P_CAASKTEAM"]    = sCAASKTEAM.toString();
            ht1["P_CAASKDATE"]    = sCAASKDATE.toString();
            ht1["P_CAASKSEQ"]     = sCAASKSEQ.toString();
            ht1["P_SENDER"]       = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";
            ht1["P_RECEIVER"]     = sMail_Receiver.toString();
            ht1["P_PGURL"]        = sPGURL.toString();
            ht1["P_TITLE"]        = sTitle.toString();

            ht1["P_CAASKCONTENT"] = txtCAASKCONTENT.GetValue();
            ht1["P_CAASKSUMMARY"] = txtCAASKSUMMARY.GetValue();
            ht1["P_GUBUN"]        = sGUBUN.toString();

            ht1["P_REGUBUN"]      = sRE_GUBUN;
            ht1["P_CAASKSTEPGN"]  = cboCAASKSTEPGN.GetValue();
            ht1["P_CAASKCLASS"]   = sCAASKCLASS;

            ht1["P_WOORTEAM"]     = txtCAWOTEAM.GetValue();
            ht1["P_WOORDATE"]     = Get_Date(txtCAWODATE.GetValue());
            ht1["P_WOSEQ"]        = Set_Fill3(txtCAWOSEQ.GetValue());

            debugger;

            PageMethods.InvokeServiceTable(ht1, "PSM.PSM4020", "UP_Get_Mail_List", function (e) {            

                var DataSet1 = eval(e);

                if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                    debugger;

                    if (sGUBUN == "OK") {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');

                        if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                            opener.btnSearch_Click();
                        }

                        this.close();
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="변경요구서 취소 처리가 되었습니다." Literal="true"></Ctl:Text>');

                        this.close();
                    }
                }

            }, function (e) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');

                this.close();

            });

        }

        function fn_APPROVAL_Display(DataSet, sCAASKTEAM, sCAASKDATE, sCAASKSEQ, sMail_Receiver, sGUBUN) {

            var iSO_COUNT = 0;
            var iRE_COUNT = 0;

            fsboolean = false;
            fshdnREApproval = "0";

            if (DataSet.Tables[0].Rows[0]["CAASKDATE1"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CAASKDATE1"];
                sTime = DataSet.Tables[0].Rows[0]["CAASKTIME1"];

                txtCAASKDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCAASKTIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('S1', DataSet.Tables[0].Rows[0]["CAASKSABUN1"], DataSet.Tables[0].Rows[0]["SOIMGNAME1"])

                fshdnSOApproval = "1";

                fsboolean = true;
            }

            txtCAASKSABUN2.SetValue(DataSet.Tables[0].Rows[0]["CAASKSABUN2"]);
            txtCAASKJKCD2.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCD2"]);

            txtCAASKJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCDNM2"]);
            txtCAASKNAME2.SetValue(DataSet.Tables[0].Rows[0]["CAASKNAME2"]);

            if (DataSet.Tables[0].Rows[0]["CAASKDATE2"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CAASKDATE2"];
                sTime = DataSet.Tables[0].Rows[0]["CAASKTIME2"];

                txtCAASKDATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCAASKTIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('S2', DataSet.Tables[0].Rows[0]["CAASKSABUN2"], DataSet.Tables[0].Rows[0]["SOIMGNAME2"])

                fshdnSOApproval = "2";
            }

            txtCAASKSABUN3.SetValue(DataSet.Tables[0].Rows[0]["CAASKSABUN3"]);
            txtCAASKJKCD3.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCD3"]);

            txtCAASKJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCDNM3"]);
            txtCAASKNAME3.SetValue(DataSet.Tables[0].Rows[0]["CAASKNAME3"]);

            if (DataSet.Tables[0].Rows[0]["CAASKDATE3"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CAASKDATE3"];
                sTime = DataSet.Tables[0].Rows[0]["CAASKTIME3"];

                txtCAASKDATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCAASKTIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('S3', DataSet.Tables[0].Rows[0]["CAASKSABUN3"], DataSet.Tables[0].Rows[0]["SOIMGNAME3"])

                fshdnSOApproval = "3";
            }

            txtCAASKSABUN4.SetValue(DataSet.Tables[0].Rows[0]["CAASKSABUN4"]);
            txtCAASKJKCD4.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCD4"]);

            txtCAASKJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCDNM4"]);
            txtCAASKNAME4.SetValue(DataSet.Tables[0].Rows[0]["CAASKNAME4"]);

            if (DataSet.Tables[0].Rows[0]["CAASKDATE4"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CAASKDATE4"];
                sTime = DataSet.Tables[0].Rows[0]["CAASKTIME4"];

                txtCAASKDATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCAASKTIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('S4', DataSet.Tables[0].Rows[0]["CAASKSABUN4"], DataSet.Tables[0].Rows[0]["SOIMGNAME4"])

                fshdnSOApproval = "4";
            }

            txtCAASKSABUN5.SetValue(DataSet.Tables[0].Rows[0]["CAASKSABUN5"]);
            txtCAASKJKCD5.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCD5"]);

            txtCAASKJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["CAASKJKCDNM5"]);
            txtCAASKNAME5.SetValue(DataSet.Tables[0].Rows[0]["CAASKNAME5"]);

            if (DataSet.Tables[0].Rows[0]["CAASKDATE5"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CAASKDATE5"];
                sTime = DataSet.Tables[0].Rows[0]["CAASKTIME5"];

                txtCAASKDATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCAASKTIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('S5', DataSet.Tables[0].Rows[0]["CAASKSABUN5"], DataSet.Tables[0].Rows[0]["SOIMGNAME5"])

                fshdnSOApproval = "5";
            }

            /* 수신승인자 */
            txtCAASKRESABUN1.SetValue(DataSet.Tables[0].Rows[0]["CAASKRESABUN1"]);
            txtCAASKREJKCD1.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCD1"]);

            txtCAASKREJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCDNM1"]);
            txtCAASKRENAME1.SetValue(DataSet.Tables[0].Rows[0]["CAASKRENAME1"]);

            if (DataSet.Tables[0].Rows[0]["CAASKREDATE1"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CAASKREDATE1"];
                sTime = DataSet.Tables[0].Rows[0]["CAASKRETIME1"];

                txtCAASKREDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCAASKRETIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('R1', DataSet.Tables[0].Rows[0]["CAASKRESABUN1"], DataSet.Tables[0].Rows[0]["REIMGNAME1"])

                // 현재 수신결재순번
                fshdnREApproval = "1";
            }

            txtCAASKRESABUN2.SetValue(DataSet.Tables[0].Rows[0]["CAASKRESABUN2"]);
            txtCAASKREJKCD2.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCD2"]);

            txtCAASKREJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCDNM2"]);
            txtCAASKRENAME2.SetValue(DataSet.Tables[0].Rows[0]["CAASKRENAME2"]);

            if (DataSet.Tables[0].Rows[0]["CAASKREDATE2"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CAASKREDATE2"];
                sTime = DataSet.Tables[0].Rows[0]["CAASKRETIME2"];

                txtCAASKREDATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCAASKRETIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('R2', DataSet.Tables[0].Rows[0]["CAASKRESABUN2"], DataSet.Tables[0].Rows[0]["REIMGNAME2"])

                // 현재 수신결재순번
                fshdnREApproval = "2";
            }

            txtCAASKRESABUN3.SetValue(DataSet.Tables[0].Rows[0]["CAASKRESABUN3"]);
            txtCAASKREJKCD3.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCD3"]);

            txtCAASKREJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCDNM3"]);
            txtCAASKRENAME3.SetValue(DataSet.Tables[0].Rows[0]["CAASKRENAME3"]);

            if (DataSet.Tables[0].Rows[0]["CAASKREDATE3"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CAASKREDATE3"];
                sTime = DataSet.Tables[0].Rows[0]["CAASKRETIME3"];

                txtCAASKREDATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCAASKRETIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('R3', DataSet.Tables[0].Rows[0]["CAASKRESABUN3"], DataSet.Tables[0].Rows[0]["REIMGNAME3"])

                // 현재 수신결재순번
                fshdnREApproval = "3";
            }

            txtCAASKRESABUN4.SetValue(DataSet.Tables[0].Rows[0]["CAASKRESABUN4"]);
            txtCAASKREJKCD4.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCD4"]);

            txtCAASKREJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCDNM4"]);
            txtCAASKRENAME4.SetValue(DataSet.Tables[0].Rows[0]["CAASKRENAME4"]);

            if (DataSet.Tables[0].Rows[0]["CAASKREDATE4"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CAASKREDATE4"];
                sTime = DataSet.Tables[0].Rows[0]["CAASKRETIME4"];

                txtCAASKREDATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCAASKRETIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('R4', DataSet.Tables[0].Rows[0]["CAASKRESABUN4"], DataSet.Tables[0].Rows[0]["REIMGNAME4"])

                // 현재 수신결재순번
                fshdnREApproval = "4";
            }

            txtCAASKRESABUN5.SetValue(DataSet.Tables[0].Rows[0]["CAASKRESABUN5"]);
            txtCAASKREJKCD5.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCD5"]);

            txtCAASKREJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["CAASKREJKCDNM5"]);
            txtCAASKRENAME5.SetValue(DataSet.Tables[0].Rows[0]["CAASKRENAME5"]);

            if (DataSet.Tables[0].Rows[0]["CAASKREDATE5"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CAASKREDATE5"];
                sTime = DataSet.Tables[0].Rows[0]["CAASKRETIME5"];

                txtCAASKREDATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCAASKRETIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('R5', DataSet.Tables[0].Rows[0]["CAASKRESABUN5"], DataSet.Tables[0].Rows[0]["REIMGNAME5"])

                // 현재 수신결재순번
                fshdnREApproval = "5";
            }

            // 접수번호년도
            txtCAASKACYEAR.SetValue(DataSet.Tables[0].Rows[0]["CAASKACYEAR"]);
            // 접수번호순번
            txtCAASKACSEQ.SetValue(DataSet.Tables[0].Rows[0]["CAASKACSEQ"]);
            // 접수일자
            txtCARECEIPTDATE.SetValue(DataSet.Tables[0].Rows[0]["CARECEIPTDATE"]);

            debugger;

            //// 결재 완료 업데이트
            //fn_APPSTATUS_UPT();

            //// 메일 발송
            //fn_Mail_Send(sCAASKTEAM, sCAASKDATE, sCAASKSEQ, sMail_Receiver, sGUBUN);

            if (txtCAASKSABUN5.GetValue() != "") {
                iSO_COUNT = 5;
            }
            else if (txtCAASKSABUN4.GetValue() != "") {
                iSO_COUNT = 4;
            }
            else if (txtCAASKSABUN3.GetValue() != "") {
                iSO_COUNT = 3;
            }
            else if (txtCAASKSABUN2.GetValue() != "") {
                iSO_COUNT = 2;
            }
            else if (txtCAASKSABUN1.GetValue() != "") {
                iSO_COUNT = 1;
            }

            if (iSO_COUNT == parseInt(Get_Numeric(fshdnSOApproval))) // 요청 마지막 결재자
            {
                // 요구서 작성자      = 변경등급 , 변경종류 수정
                // 수신자(안전환경팀) = 변경등급만 수정
                fn_Field_ReadOnly(fsboolean, true, false);
            }
            else {
                // 요구서 작성자      = 변경등급 , 변경종류 수정
                // 수신자(안전환경팀) = 변경등급만 수정
                fn_Field_ReadOnly(fsboolean, true, true);
            }

            // 결재 완료 업데이트
            fn_APPSTATUS_UPT(sCAASKTEAM, sCAASKDATE, sCAASKSEQ, sMail_Receiver, sGUBUN);
        }

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
            ht["P_WOORTEAM"]      = txtCAASKTEAM.GetValue();
            ht["P_WOORDATE"]      = Get_Date(txtCAASKDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"]         = txtCAASKSEQ.GetValue();

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
            ht["P_WOORTEAM"]     = txtCAASKTEAM.GetValue();
            ht["P_WOORDATE"] = Get_Date(txtCAASKDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"]        = txtCAASKSEQ.GetValue();
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

            if (txtCAASKSABUN5.GetValue() != "") {
                iSO_COUNT = 5;
            }
            else if (txtCAASKSABUN4.GetValue() != "") {
                iSO_COUNT = 4;
            }
            else if (txtCAASKSABUN3.GetValue() != "") {
                iSO_COUNT = 3;
            }
            else if (txtCAASKSABUN2.GetValue() != "") {
                iSO_COUNT = 2;
            }
            else if (txtCAASKSABUN1.GetValue() != "") {
                iSO_COUNT = 1;
            }

            if (txtCAASKRESABUN5.GetValue() != "") {
                iRE_COUNT = 5;
            }
            else if (txtCAASKRESABUN4.GetValue() != "") {
                iRE_COUNT = 4;
            }
            else if (txtCAASKRESABUN3.GetValue() != "") {
                iRE_COUNT = 3;
            }
            else if (txtCAASKRESABUN2.GetValue() != "") {
                iRE_COUNT = 2;
            }
            else if (txtCAASKRESABUN1.GetValue() != "") {
                iRE_COUNT = 1;
            }

            debugger;

            //if (iSO_COUNT == parseInt(Get_Numeric(fshdnSOApproval)) + 1) // 요청 마지막 결재자
            //{
            //    if (iSO_COUNT == 1) {
            //        txtCAASKCOMMENT1.SetValue(COMMENT);
            //    }
            //    else if (iSO_COUNT == 2) {
            //        txtCAASKCOMMENT2.SetValue(COMMENT);
            //    }
            //    else if (iSO_COUNT == 3) {
            //        txtCAASKCOMMENT3.SetValue(COMMENT);
            //    }
            //    else if (iSO_COUNT == 4) {
            //        txtCAASKCOMMENT4.SetValue(COMMENT);
            //    }
            //    else if (iSO_COUNT == 5) {
            //        txtCAASKCOMMENT5.SetValue(COMMENT);
            //    }
            //}
            //else // 요청 다음 결재자
            //{
            //    if (iSO_COUNT != parseInt(Get_Numeric(fshdnSOApproval))) {
            //        if (Get_Numeric(fshdnSOApproval) == "0") {
            //            txtCAASKCOMMENT1.SetValue(COMMENT);
            //        }
            //        else if (Get_Numeric(fshdnSOApproval) == "1") {
            //            txtCAASKCOMMENT2.SetValue(COMMENT);
            //        }
            //        else if (Get_Numeric(fshdnSOApproval) == "2") {
            //            txtCAASKCOMMENT3.SetValue(COMMENT);
            //        }
            //        else if (Get_Numeric(fshdnSOApproval) == "3") {
            //            txtCAASKCOMMENT4.SetValue(COMMENT);
            //        }
            //        else if (Get_Numeric(fshdnSOApproval) == "4") {
            //            txtCAASKCOMMENT5.SetValue(COMMENT);
            //        }
            //    }
            //}

            //if (iSO_COUNT == parseInt(Get_Numeric(fshdnSOApproval))) {
            //    if (iRE_COUNT == parseInt(Get_Numeric(fshdnREApproval)) + 1) // 수신 마지막 결재자
            //    {
            //        if (iRE_COUNT == 1) {
            //            txtCAASKRECOMMENT1.SetValue(COMMENT);
            //        }
            //        else if (iRE_COUNT == 2) {
            //            txtCAASKRECOMMENT2.SetValue(COMMENT);
            //        }
            //        else if (iRE_COUNT == 3) {
            //            txtCAASKRECOMMENT3.SetValue(COMMENT);
            //        }
            //        else if (iRE_COUNT == 4) {
            //            txtCAASKRECOMMENT4.SetValue(COMMENT);
            //        }
            //        else if (iRE_COUNT == 5) {
            //            txtCAASKRECOMMENT5.SetValue(COMMENT);
            //        }
            //    }
            //    else // 수신 다음 결재자
            //    {
            //        if (iRE_COUNT != parseInt(Get_Numeric(fshdnREApproval))) {
            //            if (Get_Numeric(fshdnREApproval) == "0") {
            //                txtCAASKRECOMMENT1.SetValue(COMMENT);
            //            }
            //            else if (Get_Numeric(fshdnREApproval) == "1") {
            //                txtCAASKRECOMMENT2.SetValue(COMMENT);
            //            }
            //            else if (Get_Numeric(fshdnREApproval) == "2") {
            //                txtCAASKRECOMMENT3.SetValue(COMMENT);
            //            }
            //            else if (Get_Numeric(fshdnREApproval) == "3") {
            //                txtCAASKRECOMMENT4.SetValue(COMMENT);
            //            }
            //            else if (Get_Numeric(fshdnREApproval) == "4") {
            //                txtCAASKRECOMMENT5.SetValue(COMMENT);
            //            }
            //        }
            //    }
            //}
        }

        function fn_APPSTATUS_UPT(sCAASKTEAM, sCAASKDATE, sCAASKSEQ, sMail_Receiver, sGUBUN) {

            var iSO_COUNT = 0;
            var iRE_COUNT = 0;

            if (txtCAASKSABUN5.GetValue() != "") {
                iSO_COUNT = 5;
            }
            else if (txtCAASKSABUN4.GetValue() != "") {
                iSO_COUNT = 4;
            }
            else if (txtCAASKSABUN3.GetValue() != "") {
                iSO_COUNT = 3;
            }
            else if (txtCAASKSABUN2.GetValue() != "") {
                iSO_COUNT = 2;
            }
            else if (txtCAASKSABUN1.GetValue() != "") {
                iSO_COUNT = 1;
            }

            if (txtCAASKRESABUN5.GetValue() != "") {

                iRE_COUNT = 5;
            }
            else if (txtCAASKRESABUN4.GetValue() != "") {

                iRE_COUNT = 4;
            }
            else if (txtCAASKRESABUN3.GetValue() != "") {

                iRE_COUNT = 3;
            }
            else if (txtCAASKRESABUN2.GetValue() != "") {

                iRE_COUNT = 2;
            }
            else if (txtCAASKRESABUN1.GetValue() != "") {

                iRE_COUNT = 1;
            }

            // 접수일자 업데이트
            // 결재라인에서 마지막 결재자 전결시 접수번호 및 접수일자 업데이트함
            if (iSO_COUNT == parseInt(Get_Numeric(fshdnSOApproval))) {

                var ht3 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht3["P_CAASKTEAM"] = txtCAASKTEAM.GetValue();
                ht3["P_CAASKDATE"] = Get_Date(txtCAASKDATE.GetValue().replace("-", ""));
                ht3["P_CAASKSEQ"] = Set_Fill3(txtCAASKSEQ.GetValue());

                PageMethods.InvokeServiceTable(ht3, "PSM.PSM4020", "UP_CHANGEASK_RECEIPT_UPT", function (e) {

                    var DataSet3 = eval(e);

                    if (ObjectCount(DataSet3.Tables[0].Rows) == 1) {

                        // 접수번호년도
                        txtCAASKACYEAR.SetValue(DataSet3.Tables[0].Rows[0]["CAASKACYEAR"]);
                        // 접수번호순번
                        txtCAASKACSEQ.SetValue(DataSet3.Tables[0].Rows[0]["CAASKACSEQ"]);
                        // 접수일자
                        txtCARECEIPTDATE.SetValue(DataSet3.Tables[0].Rows[0]["CARECEIPTDATE"]);

                        // 수신 마지막 결재자일 경우
                        // 작업요청서에 진행상태 업데이트함
                        if (iRE_COUNT == parseInt(Get_Numeric(fshdnREApproval))) {

                            var ht2 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                            ht2["P_WOSTATUS"] = "A";
                            ht2["P_WOORTEAM"] = txtCAWOTEAM.GetValue();
                            ht2["P_WOORDATE"] = Get_Date(txtCAWODATE.GetValue().replace("-", ""));
                            ht2["P_WOSEQ"] = Set_Fill3(txtCAWOSEQ.GetValue());

                            PageMethods.InvokeServiceTable(ht2, "PSM.PSM4020", "UP_WORKORDER_WOSTATUS_UPT", function (e) {

                                var DataSet2 = eval(e);

                                if (ObjectCount(DataSet2.Tables[0].Rows) == 1) {

                                    if (DataSet2.Tables[0].Rows[0]["STATE"] == "OK") {

                                        // 메일 발송
                                        fn_Mail_Send(sCAASKTEAM, sCAASKDATE, sCAASKSEQ, sMail_Receiver, sGUBUN);
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
                        else {
                            // 메일 발송
                            fn_Mail_Send(sCAASKTEAM, sCAASKDATE, sCAASKSEQ, sMail_Receiver, sGUBUN);
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
            else {
                // 메일 발송
                fn_Mail_Send(sCAASKTEAM, sCAASKDATE, sCAASKSEQ, sMail_Receiver, sGUBUN);
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

            var iRE_COUNT = 0;
            var sSABUN    = "";
            var sSABUNNM = "";

            fsWOIMMEDGUBN = "";

            fsWOIMMEDGUBN = WOIMMEDGUBN;

            fsRETRACTCOMMENT = "";

            fn_COMMENT(COMMENT);

            if (txtCAASKRESABUN5.GetValue() != "") {

                iRE_COUNT = 5;
                sSABUN = txtCAASKRESABUN5.GetValue();
                sSABUNNM = txtCAASKRENAME5.GetValue();
            }
            else if (txtCAASKRESABUN4.GetValue() != "") {

                iRE_COUNT = 4;
                sSABUN = txtCAASKRESABUN4.GetValue();
                sSABUNNM = txtCAASKRENAME4.GetValue();
            }
            else if (txtCAASKRESABUN3.GetValue() != "") {

                iRE_COUNT = 3;
                sSABUN = txtCAASKRESABUN3.GetValue();
                sSABUNNM = txtCAASKRENAME3.GetValue();
            }
            else if (txtCAASKRESABUN2.GetValue() != "") {

                iRE_COUNT = 2;
                sSABUN = txtCAASKRESABUN2.GetValue();
                sSABUNNM = txtCAASKRENAME2.GetValue();
            }
            else if (txtCAASKRESABUN1.GetValue() != "") {

                iRE_COUNT = 1;
                sSABUN = txtCAASKRESABUN1.GetValue();
                sSABUNNM = txtCAASKRENAME1.GetValue();
            }

            // 조치내용
            txtWOIMMEDTEXT.SetValue(WOIMMEDTEXT);

            fn_Screen_Save("APPROVAL");

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
            //        ht["P_WOORTEAM"]      = txtCAASKTEAM.GetValue();
            //        ht["P_WOORDATE"]      = txtCAASKDATE.GetValue();
            //        ht["P_WOSEQ"]         = txtCAASKSEQ.GetValue();

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
            //                    ht1["P_WOORTEAM"]     = txtCAASKTEAM.GetValue();
            //                    ht1["P_WOORDATE"]     = txtCAASKDATE.GetValue();
            //                    ht1["P_WOSEQ"]        = txtCAASKSEQ.GetValue();
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
            //    ht["P_WOORTEAM"]     = txtCAASKTEAM.GetValue();
            //    ht["P_WOORDATE"]     = txtCAASKDATE.GetValue();
            //    ht["P_WOSEQ"]        = txtCAASKSEQ.GetValue();
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
            //fsRETRACTCOMMENT = "";

            // 결재 의견
            if (_id == "APPROVAL") {

                //fn_COMMENT(ht);

                doDisplay();

                fn_Screen_Save(_id);
            }

            // 철회 의견
            if (_id == "RETRACT") {

                //fsRETRACTCOMMENT = ht;

                //fn_RETRACT_Proc();
            }

            // 취소 의견
            if (_id == "CANCEL") {

                //if (txtWOCANCELCOMMENT1.GetValue() == "") {

                //    txtWOCANCELCOMMENT1.SetValue(ht);
                //}
                //else if (txtWOCANCELCOMMENT2.GetValue() == "") {

                //    txtWOCANCELCOMMENT2.SetValue(ht);
                //}
                //else if (txtWOCANCELCOMMENT3.GetValue() == "") {

                //    txtWOCANCELCOMMENT3.SetValue(ht);
                //}

                doDisplay();

                fn_CANCEL_Proc();
            }
        }

        // 출력버튼
        function btnPrt_Click() {

            fn_OpenPop("../../Common/ReportView.aspx?RPT=PSM4021_RPT&TEAM=" + txtCAASKTEAM.GetValue() + "&DATE=" + txtCAASKDATE.GetValue() + "&SEQ=" + txtCAASKSEQ.GetValue(), 1000, 600);
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
    <!--컨텐츠시작-->
    <div id="content" >
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server" Title="변경요구등록" DefaultHide="False">

            <div class="btn_bx" id ="div_btn" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="100px" />
                        <col width="300px" />
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left">
                            <Ctl:Text ID="lblCAWOTEAM" runat="server" LangCode="lblWOORTEAM" Description="요청번호" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtCAWOTEAM" Width ="60px" runat="server" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:Text ID="Text3" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtCAWODATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ReadOnly="true"></Ctl:TextBox> 
                            <Ctl:Text ID="Text5" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtCAWOSEQ" Width ="30px" style ="text-align:right;" runat="server" ReadOnly="true"></Ctl:TextBox>
                        </td>

                        <th style="text-align:left">
                            <Ctl:Text ID="lblWOORTEAM" runat="server" LangCode="lblWOORTEAM" Description="변경번호" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left;border-right :hidden;">
                            <Ctl:TextBox ID="txtCAASKTEAM" Width ="60px" runat="server" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:Text ID="lblsprate1" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtCAASKDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                            <Ctl:Text ID="lblsprate2" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtCAASKSEQ" Width ="30px" style ="text-align:right;" runat="server" ReadOnly="true"></Ctl:TextBox>
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
                            <Ctl:Text ID="txtCAASKSABUN1"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKJKCD1"   runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKJKCDNM1" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCAASKNAME1"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKSABUN2"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKJKCD2"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCAASKJKCDNM2" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCAASKNAME2"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKSABUN3"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKJKCD3"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCAASKJKCDNM3" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCAASKNAME3"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKSABUN4"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKJKCD4"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCAASKJKCDNM4" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCAASKNAME4"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKSABUN5"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKJKCD5"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCAASKJKCDNM5" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCAASKNAME5"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKRESABUN1"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKREJKCD1"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCAASKREJKCDNM1" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCAASKRENAME1"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKRESABUN2"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKREJKCD2"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCAASKREJKCDNM2" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCAASKRENAME2"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKRESABUN3"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKREJKCD3"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCAASKREJKCDNM3" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCAASKRENAME3"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKRESABUN4"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKREJKCD4"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCAASKREJKCDNM4" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCAASKRENAME4"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKRESABUN5"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKREJKCD5"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCAASKREJKCDNM5" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCAASKRENAME5"   runat="server" ></Ctl:Text>
                        </td>
                    </tr>

                    <tr style="height:100px;">

                        <td style="text-align:center;" >
                            <img ID="ImgCAASKPHOTO1" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCAASKPHOTO1" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCAASKPHOTO2" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCAASKPHOTO2" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCAASKPHOTO3" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCAASKPHOTO3" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCAASKPHOTO4" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCAASKPHOTO4" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCAASKPHOTO5" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCAASKPHOTO5" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCAASKREPHOTO1" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCAASKREPHOTO1" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCAASKREPHOTO2" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCAASKREPHOTO2" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCAASKREPHOTO3" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCAASKREPHOTO3" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCAASKREPHOTO4" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCAASKREPHOTO4" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCAASKREPHOTO5" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCAASKREPHOTO5" visible ="true"></img>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKDATE1" runat="server" LangCode="txtCAASKDATE1"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKTIME1" runat="server" LangCode="txtCAASKTIME1"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKDATE2" runat="server" LangCode="txtCAASKDATE2"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKTIME2" runat="server" LangCode="txtCAASKTIME2"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKDATE3" runat="server" LangCode="txtCAASKDATE3"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKTIME3" runat="server" LangCode="txtCAASKTIME3"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKDATE4" runat="server" LangCode="txtCAASKDATE4"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKTIME4" runat="server" LangCode="txtCAASKTIME4"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKDATE5" runat="server" LangCode="txtCAASKDATE5"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKTIME5" runat="server" LangCode="txtCAASKTIME5"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKREDATE1" runat="server" LangCode="txtCAASKREDATE1"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKRETIME1" runat="server" LangCode="txtCAASKRETIME1"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKREDATE2" runat="server" LangCode="txtCAASKREDATE2"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKRETIME2" runat="server" LangCode="txtCAASKRETIME2"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKREDATE3" runat="server" LangCode="txtCAASKREDATE3"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKRETIME3" runat="server" LangCode="txtCAASKRETIME3"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKREDATE4" runat="server" LangCode="txtCAASKREDATE4"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKRETIME4" runat="server" LangCode="txtCAASKRETIME4"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCAASKREDATE5" runat="server" LangCode="txtCAASKREDATE5"></Ctl:Text>
                            <Ctl:Text ID="txtCAASKRETIME5" runat="server" LangCode="txtCAASKRETIME5"></Ctl:Text>
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
                        <col width="10%" />
                        <col width="40%" />
                        <col width="10%" />
                        <col width="40%" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="4">
                            <Ctl:Text ID="Text4" runat="server" Description="내용"></Ctl:Text>
                        </th>
                    </tr>
                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblCAASKBUSEO" runat="server" Description="발의부서"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtCAASKBUSEO" runat="server" ReadOnly ="true" Width ="50px"></Ctl:TextBox>
			                <Ctl:TextBox ID="pnlCAASKBUSEO" runat="server" ReadOnly ="true" Width ="80px"></Ctl:TextBox>
                        </td>
                    </tr>

                    

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblCAASKCONTENT" runat="server" Description="설비명 또는 변경요소"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtCAASKCONTENT" runat="server" Width ="1090px"></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblCAASKCLASS" runat="server" Description="변경등급"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:Combo ID="cboCAASKCLASS" Width="50px" runat="server">
                                <asp:ListItem Text="A" Value="A" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="B" Value="B" ></asp:ListItem>
                                <asp:ListItem Text="C" Value="C" ></asp:ListItem>
                            </Ctl:Combo>
                        </td>
                        <td style="text-align:center;">
                            <Ctl:Text ID="txtCAASKSTEPGN" runat="server" Description="변경종류"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:Combo ID="cboCAASKSTEPGN" Width="150px" runat="server">
                                <asp:ListItem Text="화물(청소 미포함)" Value="1" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="화물(청소 포함)"   Value="2" ></asp:ListItem>
                                <asp:ListItem Text="정상" Value="3" ></asp:ListItem>
                                <asp:ListItem Text="비상" Value="4" ></asp:ListItem>
                                <asp:ListItem Text="임시" Value="5" ></asp:ListItem>
                                
                            </Ctl:Combo>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblCAASKSUMMARY" runat="server" Description="변경개요"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtCAASKSUMMARY" runat="server" TextMode ="MultiLine"></Ctl:TextBox>
                        </td>
                    </tr>

                </table>
            </div>

            <div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="10%" />
                        <col width="40%" />
                        <col width="10%" />
                        <col width="40%" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="4">
                            <Ctl:Text ID="Text14" runat="server" Description="접수내용"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblCAASKACYEAR" runat="server" Description="접수번호"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtCAASKACYEAR" runat="server" ReadOnly ="true" Width ="80px"></Ctl:TextBox>
                            <Ctl:Text ID="Text8" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
			                <Ctl:TextBox ID="txtCAASKACSEQ" runat="server" ReadOnly ="true" Width ="50px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text6" runat="server" Description="접수일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtCARECEIPTDATE" runat="server" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
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
                        <th style="text-align:left;">
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
		</Ctl:Layer>
	</div>

</asp:content>