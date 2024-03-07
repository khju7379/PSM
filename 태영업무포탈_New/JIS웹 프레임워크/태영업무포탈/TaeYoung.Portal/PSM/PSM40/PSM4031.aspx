 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4031.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4031" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <style>           
            html,body {width:100%;  }
            body,div,ul,li{margin:0; padding:0;}
            ul,li {list-style:none;}
            
    </style>

    <script type="text/javascript" id="변경검토서">

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

        var fsCAASKSTEPGN = "";
        var fshdnApproval = "0";

        var fsboolean;

        // 작업구분
        var fshdnExists = "";

        // 요청 결재순서
        var fshdnApproval = "";

        var fshdnSign = "";

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

            txtCRASKTEAM.SetValue(data[0]);
            txtCRASKDATE.SetValue(data[1]);
            txtCRASKSEQ.SetValue(data[2]);

            txtCRWOTEAM.SetValue(data[3]);
            txtCRWODATE.SetValue(data[4]);
            txtCRWOSEQ.SetValue(data[5]);

            txtCRREVACYEAR.SetValue(data[6]);
            txtCRREVACSEQ.SetValue(data[7]);
            txtCARECEIPTDATE.SetValue(data[8]);

            fsCAASKSTEPGN = data[9];

            if (fshdnExists == 'NEW') {

                var today = new Date();

                txtCRREVTEAM.SetValue(data[0]);
                txtCRREVDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
                txtCRREVSEQ.SetValue("");

                // 요청부서 가져오기
                fn_SET_Buseo();

                btnDel.Hide();

                //fn_GET_Site();

                // 요청 결재자
                fn_Btn_Visible('0');

                // 요구서 작성자      = 변경 종류만 수정
                // 수신자(안전환경팀) = 변경등급만 수정
                fn_Field_ReadOnly(false, false, true);
            }
            else {
                if (data.length > 1) {

                    txtCRREVTEAM.SetValue(data[10]);
                    txtCRREVDATE.SetValue(data[11]);
                    txtCRREVSEQ.SetValue(data[12]);

                    fn_GET_Display();
                }
            }
        }

        function fn_Field_ReadOnly(bReadOnly1, bReadOnly2, bReadOnly3) {
            //txtCRREVDATE.SetDisabled(bReadOnly1);
            //txtCRREVCONTENT.SetDisabled(bReadOnly1);
            //txtCRREVSUMMARY.SetDisabled(bReadOnly1);

            //// 요구서 작성자만 수정
            //cboCRREVSTEPGN.SetDisabled(bReadOnly2);

            //// 안전환경팀 작성자만 수정
            //cboCRREVCLASS.SetDisabled(bReadOnly3);
            
        }

        function fn_GET_Site() {

            var iCOUNT = 0;

            // 요청 결재자
            fn_Btn_Visible('0');

            if (txtCRREVSABUN6.GetValue() != "") {
                iCOUNT = 6;
            }
            else if (txtCRREVSABUN5.GetValue() != "") {
                iCOUNT = 5;
            }
            else if (txtCRREVSABUN4.GetValue() != "") {
                iCOUNT = 4;
            }
            else if (txtCRREVSABUN3.GetValue() != "") {
                iCOUNT = 3;
            }
            else if (txtCRREVSABUN2.GetValue() != "") {
                iCOUNT = 2;
            }
            else if (txtCRREVSABUN1.GetValue() != "") {
                iCOUNT = 1;
            }

            fshdnApproval = "0";

            if (txtCRREVDATE1.GetValue() != "") {

                fn_Get_Image('S1');

                fshdnApproval = "1";
            }

            if (txtCRREVDATE2.GetValue() != "") {
                fn_Get_Image('S2');

                fshdnApproval = "2";
            }

            if (txtCRREVDATE3.GetValue() != "") {
                fn_Get_Image('S3');

                fshdnApproval = "3";
            }

            if (txtCRREVDATE4.GetValue() != "") {
                fn_Get_Image('S4');

                fshdnApproval = "4";
            }

            if (txtCRREVDATE5.GetValue() != "") {
                fn_Get_Image('S5');

                fshdnApproval = "5";
            }

            if (txtCRREVDATE6.GetValue() != "") {
                fn_Get_Image('S6');

                fshdnApproval = "6";
            }

            fshdnSign = "";
            
            fn_Get_Approval_Line(iCOUNT,                   fshdnApproval,
                                 txtCRREVSABUN1.GetValue(), txtCRREVDATE1.GetValue(),
                                 txtCRREVSABUN2.GetValue(), txtCRREVDATE2.GetValue(),
                                 txtCRREVSABUN3.GetValue(), txtCRREVDATE3.GetValue(),
                                 txtCRREVSABUN4.GetValue(), txtCRREVDATE4.GetValue(),
                                 txtCRREVSABUN5.GetValue(), txtCRREVDATE5.GetValue(),
                                 txtCRREVSABUN6.GetValue(), txtCRREVDATE6.GetValue());
        }

        function fn_Get_Approval_Line(iSO_Cnt,   sSO_Cnt,
                                      sSOSABUN1, sSODATE1,
                                      sSOSABUN2, sSODATE2,
                                      sSOSABUN3, sSODATE3,
                                      sSOSABUN4, sSODATE4,
                                      sSOSABUN5, sSODATE5,
                                      sSOSABUN6, sSODATE6) {
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
            else if (sSOSABUN6.toString() != "" && sSODATE6.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN6.toString();
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

            debugger;

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
                                    //if (parseInt(Get_Numeric(sRE_Cnt)) + 1 != iRE_Cnt) {
                                    //    if (sRESABUN1 == fshdnLoginSabun) {
                                    //        if (sREDATE1 == "") {
                                    //            fn_Btn_Visible('1');
                                    //        }
                                    //        else {
                                    //            fn_Btn_Visible('3');
                                    //        }

                                    //        sExists = "EXISTS";
                                    //        break;
                                    //    }
                                    //    else {
                                    //        if (i == 1) {
                                    //            if (sSOSABUN1 == fshdnLoginSabun) {
                                    //                if (sSODATE1 == "") {
                                    //                    fn_Btn_Visible('1');
                                    //                }
                                    //                else {
                                    //                    fn_Btn_Visible('3');
                                    //                }

                                    //                sExists = "EXISTS";
                                    //                break;
                                    //            }
                                    //            else {
                                    //                if (sSODATE1 == "") {
                                    //                    if (sSO_BUSEO == sLOGIN_BUSEO) {

                                    //                        fn_Btn_Visible('6');
                                    //                    }
                                    //                    else {
                                    //                        fn_Btn_Visible('3');
                                    //                    }
                                    //                }
                                    //                else {
                                    //                    fn_Btn_Visible('3');
                                    //                }

                                    //                sExists = "EXISTS";
                                    //                break;
                                    //            }
                                    //        }
                                    //        else if (i == 2) {
                                    //            if (sSOSABUN2 == fshdnLoginSabun) {
                                    //                if (sSODATE2 == "") {
                                    //                    fn_Btn_Visible('1');
                                    //                }
                                    //                else {
                                    //                    fn_Btn_Visible('3');
                                    //                }

                                    //                sExists = "EXISTS";
                                    //                break;
                                    //            }
                                    //            else {
                                    //                if (sSODATE2 == "") {
                                    //                    if (sSO_BUSEO == sLOGIN_BUSEO) {
                                    //                        if (sSOSABUN1 == fshdnLoginSabun) {
                                    //                            fn_Btn_Visible('70');
                                    //                        }
                                    //                        else {
                                    //                            fn_Btn_Visible('6');
                                    //                        }
                                    //                    }
                                    //                    else {
                                    //                        fn_Btn_Visible('3');
                                    //                    }
                                    //                }
                                    //                else {
                                    //                    fn_Btn_Visible('3');
                                    //                }

                                    //                sExists = "EXISTS";
                                    //                break;
                                    //            }
                                    //        }
                                    //        else if (i == 3) {
                                    //            if (sSOSABUN3 == fshdnLoginSabun) {
                                    //                if (sSODATE3 == "") {
                                    //                    fn_Btn_Visible('1');
                                    //                }
                                    //                else {
                                    //                    fn_Btn_Visible('3');
                                    //                }

                                    //                sExists = "EXISTS";
                                    //                break;
                                    //            }
                                    //            else {
                                    //                if (sSODATE3 == "") {
                                    //                    if (sSO_BUSEO == sLOGIN_BUSEO) {
                                    //                        if (sSOSABUN1 == fshdnLoginSabun) {
                                    //                            fn_Btn_Visible('70');
                                    //                        }
                                    //                        else {
                                    //                            fn_Btn_Visible('6');
                                    //                        }
                                    //                    }
                                    //                    else {
                                    //                        fn_Btn_Visible('3');
                                    //                    }
                                    //                }
                                    //                else {
                                    //                    fn_Btn_Visible('3');
                                    //                }

                                    //                sExists = "EXISTS";
                                    //                break;
                                    //            }
                                    //        }
                                    //        else if (i == 4) {
                                    //            if (sSOSABUN4 == fshdnLoginSabun) {
                                    //                if (sSODATE4 == "") {
                                    //                    fn_Btn_Visible('1');
                                    //                }
                                    //                else {
                                    //                    fn_Btn_Visible('3');
                                    //                }

                                    //                sExists = "EXISTS";
                                    //                break;
                                    //            }
                                    //            else {
                                    //                if (sSODATE4 == "") {
                                    //                    if (sSO_BUSEO == sLOGIN_BUSEO) {
                                    //                        if (sSOSABUN1 == fshdnLoginSabun) {
                                    //                            fn_Btn_Visible('70');
                                    //                        }
                                    //                        else {
                                    //                            fn_Btn_Visible('6');
                                    //                        }
                                    //                    }
                                    //                    else {
                                    //                        fn_Btn_Visible('3');
                                    //                    }
                                    //                }
                                    //                else {
                                    //                    fn_Btn_Visible('3');
                                    //                }

                                    //                sExists = "EXISTS";
                                    //                break;
                                    //            }
                                    //        }
                                    //        else if (i == 5) {
                                    //            if (sSOSABUN5 == fshdnLoginSabun) {
                                    //                if (sSODATE5 == "") {
                                    //                    fn_Btn_Visible('1');
                                    //                }
                                    //                else {
                                    //                    fn_Btn_Visible('3');
                                    //                }

                                    //                sExists = "EXISTS";
                                    //                break;
                                    //            }
                                    //            else {
                                    //                if (sSODATE5 == "") {
                                    //                    if (sSO_BUSEO == sLOGIN_BUSEO) {
                                    //                        if (sSOSABUN1 == fshdnLoginSabun) {
                                    //                            fn_Btn_Visible('70');
                                    //                        }
                                    //                        else {
                                    //                            fn_Btn_Visible('6');
                                    //                        }
                                    //                    }
                                    //                    else {
                                    //                        fn_Btn_Visible('3');
                                    //                    }
                                    //                }
                                    //                else {
                                    //                    fn_Btn_Visible('3');
                                    //                }

                                    //                sExists = "EXISTS";
                                    //                break;
                                    //            }
                                    //        }
                                    //    }
                                    //}
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


                //// 수신 결재자
                //if (iSO_Cnt == parseInt(Get_Numeric(sSO_Cnt))) {
                //    fshdnSign = "Complete";

                //    if ((parseInt(Get_Numeric(sRE_Cnt)) == 0) && (sRESABUN1 == fshdnLoginSabun)) {
                //        fn_Btn_Visible('5');

                //        sExists = "EXISTS";
                //    }
                //    else {

                //        // 현재 수신 결재할 사람의 부서코드
                //        if (sRESABUN1.toString() != "") {

                //            ht["P_KBSABUN"] = sNOWAPP_RESABUN.toString();

                //            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                //                var DataSet = eval(e);

                //                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                //                    // 첫 수신자 부서코드
                //                    sRE_BUSEO = DataSet.Tables[0].Rows[0]["KBBUSEO"];


                //                    for (var i = parseInt(Get_Numeric(sRE_Cnt)); i <= iRE_Cnt; i++) {
                //                        if (parseInt(Get_Numeric(sRE_Cnt)) + 1 == iRE_Cnt) {
                //                            if (i == 0) {
                //                                if (sRESABUN1 == fshdnLoginSabun) {
                //                                    if (sREDATE1 == "") {
                //                                        fn_Btn_Visible('1');
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }

                //                                    sExists = "EXISTS";
                //                                    break;
                //                                }
                //                                else {
                //                                    if (sREDATE1 == "") {
                //                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                //                                            fn_Btn_Visible('6');
                //                                        }
                //                                        else {
                //                                            fn_Btn_Visible('3');
                //                                        }
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }

                //                                    sExists = "EXISTS";
                //                                    break;
                //                                }
                //                            }
                //                            else if (i == 1) {
                //                                if (sRESABUN2 == fshdnLoginSabun) {
                //                                    if (sREDATE2 == "") {
                //                                        fn_Btn_Visible('1');
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }

                //                                    sExists = "EXISTS";
                //                                    break;
                //                                }
                //                                else {
                //                                    if (sREDATE2 == "") {
                //                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                //                                            fn_Btn_Visible('6');
                //                                        }
                //                                        else {
                //                                            fn_Btn_Visible('3');
                //                                        }
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }

                //                                    sExists = "EXISTS";
                //                                    break;
                //                                }
                //                            }
                //                            else if (i == 2) {
                //                                if (sRESABUN3 == fshdnLoginSabun) {
                //                                    if (sREDATE3 == "") {
                //                                        fn_Btn_Visible('1');
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }

                //                                    sExists = "EXISTS";
                //                                    break;
                //                                }
                //                                else {
                //                                    if (sREDATE3 == "") {
                //                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                //                                            fn_Btn_Visible('6');
                //                                        }
                //                                        else {
                //                                            fn_Btn_Visible('3');
                //                                        }
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }

                //                                    sExists = "EXISTS";
                //                                    break;
                //                                }
                //                            }
                //                            else if (i == 3) {
                //                                if (sRESABUN4 == fshdnLoginSabun) {
                //                                    if (sREDATE4 == "") {
                //                                        fn_Btn_Visible('1');
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }

                //                                    sExists = "EXISTS";
                //                                    break;
                //                                }
                //                                else {
                //                                    if (sREDATE4 == "") {
                //                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                //                                            fn_Btn_Visible('6');
                //                                        }
                //                                        else {
                //                                            fn_Btn_Visible('3');
                //                                        }
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }

                //                                    sExists = "EXISTS";
                //                                    break;
                //                                }
                //                            }
                //                            else if (i == 4) {
                //                                if (sRESABUN5 == fshdnLoginSabun) {
                //                                    if (sREDATE5 == "") {
                //                                        fn_Btn_Visible('1');
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }

                //                                    sExists = "EXISTS";
                //                                    break;
                //                                }
                //                                else {
                //                                    if (sREDATE5 == "") {
                //                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                //                                            fn_Btn_Visible('6');
                //                                        }
                //                                        else {
                //                                            fn_Btn_Visible('3');
                //                                        }
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }

                //                                    sExists = "EXISTS";
                //                                    break;
                //                                }
                //                            }
                //                        }
                //                        else {
                //                            if (i == 4) {
                //                                if (sRESABUN5 == fshdnLoginSabun) {
                //                                    if (sREDATE5 == "") {
                //                                        fn_Btn_Visible('1');
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }
                //                                }
                //                                else {
                //                                    if (sREDATE5 == "") {
                //                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                //                                            fn_Btn_Visible('6');
                //                                        }
                //                                        else {
                //                                            fn_Btn_Visible('3');
                //                                        }
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }
                //                                }

                //                                sExists = "EXISTS";
                //                                break;
                //                            }
                //                            else if (i == 3) {
                //                                if (sRESABUN4 == fshdnLoginSabun) {
                //                                    if (sREDATE4 == "") {
                //                                        fn_Btn_Visible('1');
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }
                //                                }
                //                                else {
                //                                    if (sREDATE4 == "") {
                //                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                //                                            fn_Btn_Visible('6');
                //                                        }
                //                                        else {
                //                                            fn_Btn_Visible('3');
                //                                        }
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }
                //                                }

                //                                sExists = "EXISTS";
                //                                break;
                //                            }
                //                            else if (i == 2) {
                //                                if (sRESABUN3 == fshdnLoginSabun) {
                //                                    if (sREDATE3 == "") {
                //                                        fn_Btn_Visible('1');
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }
                //                                }
                //                                else {
                //                                    if (sREDATE3 == "") {
                //                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                //                                            fn_Btn_Visible('6');
                //                                        }
                //                                        else {
                //                                            fn_Btn_Visible('3');
                //                                        }
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }
                //                                }

                //                                sExists = "EXISTS";
                //                                break;
                //                            }
                //                            else if (i == 1) {
                //                                if (sRESABUN2 == fshdnLoginSabun) {
                //                                    if (sREDATE2 == "") {
                //                                        fn_Btn_Visible('1');
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }
                //                                }
                //                                else {
                //                                    if (sREDATE2 == "") {
                //                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                //                                            fn_Btn_Visible('6');
                //                                        }
                //                                        else {
                //                                            fn_Btn_Visible('3');
                //                                        }
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }
                //                                }

                //                                sExists = "EXISTS";
                //                                break;
                //                            }
                //                            else {
                //                                if (sRESABUN1 == fshdnLoginSabun) {
                //                                    if (sREDATE1 == "") {
                //                                        UP_Btn_Show(2);
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }
                //                                }
                //                                else {
                //                                    if (sREDATE1 == "") {
                //                                        if (sRE_BUSEO == sLOGIN_BUSEO) {
                //                                            fn_Btn_Visible('6');
                //                                        }
                //                                        else {
                //                                            fn_Btn_Visible('3');
                //                                        }
                //                                    }
                //                                    else {
                //                                        fn_Btn_Visible('3');
                //                                    }
                //                                }

                //                                sExists = "EXISTS";
                //                                break;
                //                            }
                //                        }
                //                    }

                //                }
                //            }, function (e) {
                //                // Biz 연결오류
                //                alert('<Ctl:Text runat="server" Description="로딩중 첫 수신자 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                //            });
                //        }
                //    }
                //}

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

                Num = document.getElementById("conBody_ImgCRREVPHOTO" + gubun.substr(1, 1)).src;

                data = Num.split('&');

                control = $("#txtCRREVSABUN" + gubun.substr(1, 1)).val();

                Img_Read(gubun, control, data[1]);

                fshdnApproval = gubun.substr(1, 1);
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
                    txtCRREVSABUN1.SetValue("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>");
                    txtCRREVNAME1.SetValue(DataSet.Tables[0].Rows[0]["KBHANGL"]);
                    txtCRREVJKCD1.SetValue(DataSet.Tables[0].Rows[0]["KBJKCD"]);
                    txtCRREVJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["CDDESC1"]);

                    // 변경요구부서
                    txtCRREVTEAM.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEO"]);

                    // 발의부서
                    //txtCRREVBUSEO.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEO"]);
                    //pnlCRREVBUSEO.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEONM"]);
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

                        txtCRREVJKCD1.SetValue(DataSet1.Tables[0].Rows[0]["JCCD"]);
                        txtCRREVJKCDNM1.SetValue(DataSet1.Tables[0].Rows[0]["JKDESC"]);
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

            var iCOUNT = 0;

            var sDate = "";
            var sTime = "";

            fsboolean = false;

            fshdnApproval = "0";

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_CRREVTEAM"] = txtCRREVTEAM.GetValue();
            ht["P_CRREVDATE"] = Get_Date(txtCRREVDATE.GetValue().replace("-", ""));
            ht["P_CRREVSEQ"]  = Set_Fill3(txtCRREVSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4030", "UP_CHANGEREV_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    //txtCRASKTEAM.SetValue(DataSet.Tables[0].Rows[0]["CRASKTEAM"]);
                    //txtCRASKDATE.SetValue(DataSet.Tables[0].Rows[0]["CRASKDATE"]);
                    //txtCRASKSEQ.SetValue(DataSet.Tables[0].Rows[0]["CRASKSEQ"]);

                    // 첨부파일 로드
                    AttachFileLod();

                    /* 요청승인자 */
                    txtCRREVSABUN1.SetValue(DataSet.Tables[0].Rows[0]["CRREVSABUN1"]);
                    txtCRREVJKCD1.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCD1"]);

                    txtCRREVJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCDNM1"]);
                    txtCRREVNAME1.SetValue(DataSet.Tables[0].Rows[0]["CRREVNAME1"]);

                    if (DataSet.Tables[0].Rows[0]["CRREVDATE1"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CRREVDATE1"];
                        sTime = DataSet.Tables[0].Rows[0]["CRREVTIME1"];

                        txtCRREVDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCRREVTIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S1', DataSet.Tables[0].Rows[0]["CRREVSABUN1"], DataSet.Tables[0].Rows[0]["SOIMGNAME1"])

                        fshdnApproval = "1";

                        fsboolean = true;
                    }
                    else {
                        txtCRREVDATE1.SetValue("");
                        txtCRREVTIME1.SetValue("");
                    }

                    txtCRREVSABUN2.SetValue(DataSet.Tables[0].Rows[0]["CRREVSABUN2"]);
                    txtCRREVJKCD2.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCD2"]);

                    txtCRREVJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCDNM2"]);
                    txtCRREVNAME2.SetValue(DataSet.Tables[0].Rows[0]["CRREVNAME2"]);

                    if (DataSet.Tables[0].Rows[0]["CRREVDATE2"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CRREVDATE2"];
                        sTime = DataSet.Tables[0].Rows[0]["CRREVTIME2"];

                        txtCRREVDATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCRREVTIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S2', DataSet.Tables[0].Rows[0]["CRREVSABUN2"], DataSet.Tables[0].Rows[0]["SOIMGNAME2"])

                        fshdnApproval = "2";
                    }
                    else {
                        txtCRREVDATE2.SetValue("");
                        txtCRREVTIME2.SetValue("");
                    }

                    txtCRREVSABUN3.SetValue(DataSet.Tables[0].Rows[0]["CRREVSABUN3"]);
                    txtCRREVJKCD3.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCD3"]);

                    txtCRREVJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCDNM3"]);
                    txtCRREVNAME3.SetValue(DataSet.Tables[0].Rows[0]["CRREVNAME3"]);

                    if (DataSet.Tables[0].Rows[0]["CRREVDATE3"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CRREVDATE3"];
                        sTime = DataSet.Tables[0].Rows[0]["CRREVTIME3"];

                        txtCRREVDATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCRREVTIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S3', DataSet.Tables[0].Rows[0]["CRREVSABUN3"], DataSet.Tables[0].Rows[0]["SOIMGNAME3"])

                        fshdnApproval = "3";
                    }
                    else {
                        txtCRREVDATE3.SetValue("");
                        txtCRREVTIME3.SetValue("");
                    }

                    txtCRREVSABUN4.SetValue(DataSet.Tables[0].Rows[0]["CRREVSABUN4"]);
                    txtCRREVJKCD4.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCD4"]);

                    txtCRREVJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCDNM4"]);
                    txtCRREVNAME4.SetValue(DataSet.Tables[0].Rows[0]["CRREVNAME4"]);

                    if (DataSet.Tables[0].Rows[0]["CRREVDATE4"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CRREVDATE4"];
                        sTime = DataSet.Tables[0].Rows[0]["CRREVTIME4"];

                        txtCRREVDATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCRREVTIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S4', DataSet.Tables[0].Rows[0]["CRREVSABUN4"], DataSet.Tables[0].Rows[0]["SOIMGNAME4"])

                        fshdnApproval = "4";
                    }
                    else {
                        txtCRREVDATE4.SetValue("");
                        txtCRREVTIME4.SetValue("");
                    }

                    txtCRREVSABUN5.SetValue(DataSet.Tables[0].Rows[0]["CRREVSABUN5"]);
                    txtCRREVJKCD5.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCD5"]);

                    txtCRREVJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCDNM5"]);
                    txtCRREVNAME5.SetValue(DataSet.Tables[0].Rows[0]["CRREVNAME5"]);

                    if (DataSet.Tables[0].Rows[0]["CRREVDATE5"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CRREVDATE5"];
                        sTime = DataSet.Tables[0].Rows[0]["CRREVTIME5"];

                        txtCRREVDATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCRREVTIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S5', DataSet.Tables[0].Rows[0]["CRREVSABUN5"], DataSet.Tables[0].Rows[0]["SOIMGNAME5"])

                        fshdnApproval = "5";
                    }
                    else {
                        txtCRREVDATE5.SetValue("");
                        txtCRREVTIME5.SetValue("");
                    }



                    txtCRREVSABUN6.SetValue(DataSet.Tables[0].Rows[0]["CRREVSABUN6"]);
                    txtCRREVJKCD6.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCD6"]);

                    txtCRREVJKCDNM6.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCDNM6"]);
                    txtCRREVNAME6.SetValue(DataSet.Tables[0].Rows[0]["CRREVNAME6"]);

                    if (DataSet.Tables[0].Rows[0]["CRREVDATE6"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["CRREVDATE6"];
                        sTime = DataSet.Tables[0].Rows[0]["CRREVTIME6"];

                        txtCRREVDATE6.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtCRREVTIME6.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('S6', DataSet.Tables[0].Rows[0]["CRREVSABUN6"], DataSet.Tables[0].Rows[0]["SOIMGNAME6"])

                        fshdnApproval = "6";
                    }
                    else {
                        txtCRREVDATE6.SetValue("");
                        txtCRREVTIME6.SetValue("");
                    }

                    // 검토항목
                    txtCRREVCONTENT.SetValue(DataSet.Tables[0].Rows[0]["CRREVCONTENT"]);

                    // 검토자료
                    txtCRREVDATA.SetValue(DataSet.Tables[0].Rows[0]["CRREVDATA"]);

                    // 검토내용
                    txtCRREVSUMMARY.SetValue(DataSet.Tables[0].Rows[0]["CRREVSUMMARY"]);

                    // 승인여부
                    cboCRREVAPPROVAL.SetValue(DataSet.Tables[0].Rows[0]["CRREVAPPROVAL"]);

                    // 사 유
                    txtCRREVREASION.SetValue(DataSet.Tables[0].Rows[0]["CRREVREASION"]);


                    if (txtCRREVSABUN6.GetValue() != "") {
                        iCOUNT = 6;
                    }
                    else if (txtCRREVSABUN5.GetValue() != "") {
                        iCOUNT = 5;
                    }
                    else if (txtCRREVSABUN4.GetValue() != "") {
                        iCOUNT = 4;
                    }
                    else if (txtCRREVSABUN3.GetValue() != "") {
                        iCOUNT = 3;
                    }
                    else if (txtCRREVSABUN2.GetValue() != "") {
                        iCOUNT = 2;
                    }
                    else if (txtCRREVSABUN1.GetValue() != "") {
                        iCOUNT = 1;
                    }

                    //if (iCOUNT == parseInt(Get_Numeric(fshdnApproval))) // 요청 마지막 결재자
                    //{
                    //    // 요구서 작성자      = 변경 종류만 수정
                    //    // 수신자(안전환경팀) = 변경등급만 수정
                    //    fn_Field_ReadOnly(true, true, false);
                    //}
                    //else {
                    //    if (parseInt(Get_Numeric(fshdnApproval)) > 0) {

                    //        // 요구서 작성자      = 변경 종류만 수정
                    //        // 수신자(안전환경팀) = 변경등급만 수정
                    //        fn_Field_ReadOnly(true, true, true);
                    //    }
                    //    else {

                    //        if (parseInt(Get_Numeric(fshdnApproval)) == 0) {

                    //            // 요구서 작성자      = 변경 종류만 수정
                    //            // 수신자(안전환경팀) = 변경등급만 수정
                    //            fn_Field_ReadOnly(false, false, true);
                    //        }
                    //    }
                    //}

                    // 공통코드 가져오기
                    fn_Dataset_Common(txtCRREVSABUN1.GetValue(),   txtCRREVDATE1.GetValue(),
                                      txtCRREVSABUN2.GetValue(),   txtCRREVDATE2.GetValue(),
                                      txtCRREVSABUN3.GetValue(),   txtCRREVDATE3.GetValue(),
                                      txtCRREVSABUN4.GetValue(),   txtCRREVDATE4.GetValue(),
                                      txtCRREVSABUN5.GetValue(),   txtCRREVDATE5.GetValue(),
                                      txtCRREVSABUN6.GetValue(),   txtCRREVDATE6.GetValue());
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
                                   sSOSABUN6, sSODATE6)
        {

            var REDOCID;
            var REDOCNUM;

            var sNOWAPP_SOSABUN = ""; // 현재 요청 결재할 사람
            var sNOWAPP_RESABUN = ""; // 현재 요청 결재할 사람

            var sLoginBuseo = "";
            var sRESABUN = "";
            var sRENAME = "";

            var iCOUNT = 0;
            
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
            else if (sSOSABUN6.toString() != "" && sSODATE6.toString() == "") {
                sNOWAPP_SOSABUN = sSOSABUN6.toString();
            }

            // 현재 요청 결재할 사람의 부서코드
            if (sSOSABUN1.toString() != "") {
                ht["P_NOWSOSABUN"] = sNOWAPP_SOSABUN.toString();
            }
            else {
                ht["P_NOWSOSABUN"] = "";
            }

            ht["P_NOWRESABUN"] = "";
            

            ht["P_GUBUN"]      = "INDEX";
            ht["P_DATE"]       = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());
            ht["P_LoginSABUN"] = fshdnLoginSabun;

            ht["P_REDOCID"]    = 'RE';
            ht["P_REDOCNUM"] = txtCRREVTEAM.GetValue() + Get_Date(txtCRREVDATE.GetValue().replace("-", "")) + Set_Fill3(txtCRREVSEQ.GetValue());
            ht["P_GUBN"]       = "RE";

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4010", "UP_Get_Ds_Common", function (e) {

                var dsComm = eval(e);

                if (ObjectCount(dsComm.Tables[0].Rows) > 0) {

                    sLoginBuseo = dsComm.Tables[0].Rows[0]["LOGINBUSEO"];

                    sRESABUN    = dsComm.Tables[0].Rows[0]["RESABUN"];
                    sRENAME     = dsComm.Tables[0].Rows[0]["RENAME"];

                    //// 완료 및 확인자
                    //fn_WOFINISH(sLoginBuseo);

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
                $("#conBody_ImgCRREVPHOTO" + gubun.substr(1, 1)).attr("src", filepath);
            }
        }

        function fn_BLANK_IMAGE() {
            $("#conBody_ImgCRREVPHOTO1").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCRREVPHOTO2").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCRREVPHOTO3").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCRREVPHOTO4").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgCRREVPHOTO5").attr("src", "/Resources/Framework/blank.gif");
        }

        function fn_REFERENCE(gubun, sRESABUN, sRENAME) {

            var ht  = new Object();

            var REDOCID;
            var REDOCNUM;

            ht["P_REDOCID"]  = 'RE';
            ht["P_REDOCNUM"] = txtCRREVTEAM.GetValue() + Get_Date(txtCRREVDATE.GetValue().replace("-", "")) + Set_Fill3(txtCRREVSEQ.GetValue()) + txtCRASKTEAM.GetValue() + Get_Date(txtCRASKDATE.GetValue().replace("-", "")) + Set_Fill3(txtCRASKSEQ.GetValue());
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

        function fn_GET_Mail_Sabun(iSO_Cnt, sSOSABUN1, sSOSABUN2, sSOSABUN3, sSOSABUN4, sSOSABUN5, sSOSABUN6) {
            var sMail_Send;

            var i = 0;

            i = parseInt(Get_Numeric(fshdnApproval));

            if (iSO_Cnt == parseInt(Get_Numeric(fshdnApproval))) {

                if (i == 1) {
                    sMail_Send = sSOSABUN1.toString();
                }
                else if (i == 2) {
                    sMail_Send = sSOSABUN2.toString();
                }
                else if (i == 3) {
                    sMail_Send = sSOSABUN3.toString();
                }
                else if (i == 4) {
                    sMail_Send = sSOSABUN4.toString();
                }
                else if (i == 5) {
                    sMail_Send = sSOSABUN5.toString();
                }
                else if (i == 6) {
                    sMail_Send = sSOSABUN6.toString();
                }
            }
            else {

                if (i == 1) {
                    sMail_Send = sSOSABUN2.toString();
                }
                else if (i == 2) {
                    sMail_Send = sSOSABUN3.toString();
                }
                else if (i == 3) {
                    sMail_Send = sSOSABUN4.toString();
                }
                else if (i == 4) {
                    sMail_Send = sSOSABUN5.toString();
                }
                else if (i == 5) {
                    sMail_Send = sSOSABUN6.toString();
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

                sFirst = "0" + sFirst.toString();
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

        // 결재선지정 버튼 이벤트
        function btnSOApproval_Click() {
            var param;

            param = "";

            param += "../POP/SabunMultiChkPopup7.aspx?callback=fn_PopupCallBack&Data_Cnt1=5&Data_Cnt2=5&GUBUN=RE";

            param += "&param1=" + txtCRREVSABUN1.GetValue();
            param += "&param2=" + txtCRREVSABUN2.GetValue();
            param += "&param3=" + txtCRREVSABUN3.GetValue();
            param += "&param4=" + txtCRREVSABUN4.GetValue();
            param += "&param5=" + txtCRREVSABUN5.GetValue();
            param += "&param6=" + txtCRREVSABUN6.GetValue();
            param += "&param7=" + fshdnApproval;

            param += "&param11=" + txtCRREVNAME1.GetValue();
            param += "&param12=" + txtCRREVNAME2.GetValue();
            param += "&param13=" + txtCRREVNAME3.GetValue();
            param += "&param14=" + txtCRREVNAME4.GetValue();
            param += "&param15=" + txtCRREVNAME5.GetValue();
            param += "&param16=" + txtCRREVNAME6.GetValue();

            param += "&param21=" + txtCRREVJKCD1.GetValue();
            param += "&param22=" + txtCRREVJKCD2.GetValue();
            param += "&param23=" + txtCRREVJKCD3.GetValue();
            param += "&param24=" + txtCRREVJKCD4.GetValue();
            param += "&param25=" + txtCRREVJKCD5.GetValue();
            param += "&param26=" + txtCRREVJKCD6.GetValue();

            param += "&param31=" + txtCRREVJKCDNM1.GetValue();
            param += "&param32=" + txtCRREVJKCDNM2.GetValue();
            param += "&param33=" + txtCRREVJKCDNM3.GetValue();
            param += "&param34=" + txtCRREVJKCDNM4.GetValue();
            param += "&param35=" + txtCRREVJKCDNM5.GetValue();
            param += "&param36=" + txtCRREVJKCDNM6.GetValue();

            param += "&SOSign=" + fshdnSign;
            param += "&SABUN=" + fsRESABUN;
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

                txtCRREVSABUN1.SetValue(items1[0].data.KBSABUN);
                txtCRREVJKCD1.SetValue(items1[0].data.JKCODE);
                txtCRREVJKCDNM1.SetValue(items1[0].data.CDDESC1);
                txtCRREVNAME1.SetValue(items1[0].data.KBHANGL);
            }

            if (items1.length > 1) {

                if (txtCRREVSABUN1.GetValue() == items1[1].data.KBSABUN)
                {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청승인자를 확인하세요." Literal="true"></Ctl:Text>');
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtCRREVSABUN2.SetValue(items1[1].data.KBSABUN);
                txtCRREVJKCD2.SetValue(items1[1].data.JKCODE);
                txtCRREVJKCDNM2.SetValue(items1[1].data.CDDESC1);
                txtCRREVNAME2.SetValue(items1[1].data.KBHANGL);
            }

            if (items1.length > 2) {

                if (txtCRREVSABUN1.GetValue() == items1[2].data.KBSABUN)
                {
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtCRREVSABUN3.SetValue(items1[2].data.KBSABUN);
                txtCRREVJKCD3.SetValue(items1[2].data.JKCODE);
                txtCRREVJKCDNM3.SetValue(items1[2].data.CDDESC1);
                txtCRREVNAME3.SetValue(items1[2].data.KBHANGL);
            }

            if (items1.length > 3) {

                if (txtCRREVSABUN1.GetValue() == items1[3].data.KBSABUN)
                {
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtCRREVSABUN4.SetValue(items1[3].data.KBSABUN);
                txtCRREVJKCD4.SetValue(items1[3].data.JKCODE);
                txtCRREVJKCDNM4.SetValue(items1[3].data.CDDESC1);
                txtCRREVNAME4.SetValue(items1[3].data.KBHANGL);
            }

            if (items1.length > 4) {

                if (txtCRREVSABUN1.GetValue() == items1[4].data.KBSABUN)
                {
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtCRREVSABUN5.SetValue(items1[4].data.KBSABUN);
                txtCRREVJKCD5.SetValue(items1[4].data.JKCODE);
                txtCRREVJKCDNM5.SetValue(items1[4].data.CDDESC1);
                txtCRREVNAME5.SetValue(items1[4].data.KBHANGL);
            }

            if (items1.length > 5) {

                if (txtCRREVSABUN1.GetValue() == items1[5].data.KBSABUN) {
                    Ext.MessageBox.alert('알림', "요청승인자를 확인하세요.");
                    return;
                }

                txtCRREVSABUN6.SetValue(items1[5].data.KBSABUN);
                txtCRREVJKCD6.SetValue(items1[5].data.JKCODE);
                txtCRREVJKCDNM6.SetValue(items1[5].data.CDDESC1);
                txtCRREVNAME6.SetValue(items1[5].data.KBHANGL);
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
                ht["P_KBSABUN"] = txtCRREVSABUN1.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        //txtCRREVBUSEO.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEO"]);
                        //pnlCRREVBUSEO.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEONM"]);
                        
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재선 지정 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
            else {
                //txtCRREVBUSEO.SetValue('');
                //pnlCRREVBUSEO.SetValue('');
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
                txtCRREVSABUN2.SetValue('');
                txtCRREVJKCD2.SetValue('');
                txtCRREVJKCDNM2.SetValue('');
                txtCRREVNAME2.SetValue('');

                txtCRREVSABUN3.SetValue('');
                txtCRREVJKCD3.SetValue('');
                txtCRREVJKCDNM3.SetValue('');
                txtCRREVNAME3.SetValue('');

                txtCRREVSABUN4.SetValue('');
                txtCRREVJKCD4.SetValue('');
                txtCRREVJKCDNM4.SetValue('');
                txtCRREVNAME4.SetValue('');

                txtCRREVSABUN5.SetValue('');
                txtCRREVJKCD5.SetValue('');
                txtCRREVJKCDNM5.SetValue('');
                txtCRREVNAME5.SetValue('');

                txtCRREVSABUN6.SetValue('');
                txtCRREVJKCD6.SetValue('');
                txtCRREVJKCDNM6.SetValue('');
                txtCRREVNAME6.SetValue('');
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

            setTimeout("doDisplay()", '3000');
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

            setTimeout("doDisplay()", '3000');
        }

        // 삭제 버튼 이벤트
        function btnDel_Click() {
            doDisplay();

            // 접수일자 체크
            if (fsboolean == true) {

                doDisplay();
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="변경검토서 결재가 처리되었으므로 삭제가 불가합니다." Literal="true"></Ctl:Text>');
                return;
            }

            var ht = new Object();

            ht["P_ATTACH_TYPE"] = "RE";
            ht["P_ATTACH_NO"]   = txtCRREVTEAM.GetValue() + Get_Date(txtCRREVDATE.GetValue().replace("-", "")) + Set_Fill3(txtCRREVSEQ.GetValue());
            ht["P_CRREVTEAM"]   = txtCRREVTEAM.GetValue();
            ht["P_CRREVDATE"]   = Get_Date(txtCRREVDATE.GetValue().replace("-", ""));
            ht["P_CRREVSEQ"]    = Set_Fill3(txtCRREVSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4030", "UP_CHANGEREV_DEL", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        fn_REFERENCE('DEL', '', '');

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

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

        // 철회 함수
        function fn_RETRACT_Proc() {

            var sPGURL        = "";
            var sAPNUM        = "";

            sAPNUM = txtCRREVTEAM.GetValue() + "-" + Get_Date(txtCRREVDATE.GetValue().replace("-", "")) + "-" + Set_Fill3(txtCRREVSEQ.GetValue());

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            sPGURL = "/Portal/PSM/PSM40/PSM4031.aspx?";
            sPGURL = sPGURL + "APP_NUM=";
            sPGURL = sPGURL + sAPNUM;

            ht["P_CRREVTEAM"]    = txtCRREVTEAM.GetValue();
            ht["P_CRREVDATE"]    = Get_Date(txtCRREVDATE.GetValue().replace("-", ""));
            ht["P_CRREVSEQ"]     = Set_Fill3(txtCRREVSEQ.GetValue());

            ht["P_APNUM"]        = txtCRREVTEAM.GetValue() + Get_Date(txtCRREVDATE.GetValue().replace("-", "")) + Set_Fill3(txtCRREVSEQ.GetValue());
            ht["P_CRREVCONTENT"] = txtCRREVCONTENT.GetValue();
            ht["P_SENDER"]       = txtCRREVSABUN1.GetValue();
            ht["P_RECEIVER"]     = txtCRREVSABUN1.GetValue();

            // 변경요구서 철회
            PageMethods.InvokeServiceTable(ht, "PSM.PSM4030", "UP_CHANGEREV_RETRACT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재가 철회 되었습니다." Literal="true"></Ctl:Text>');

                        fn_Btn_Visible('3');

                        fn_GET_Display();

                        fn_GET_Site();

                        // 요구서 작성자      = 변경 종류만 수정
                        // 수신자(안전환경팀) = 변경등급만 수정
                        fn_Field_ReadOnly(false, false, true);

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
            var CRREVSABUN1 = "";
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_CRREVTEAM"] = txtCRREVTEAM.GetValue();
            ht["P_CRREVDATE"] = Get_Date(txtCRREVDATE.GetValue().replace("-", ""));
            ht["P_CRREVSEQ"]  = Set_Fill3(txtCRREVSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4030", "UP_CHANGEREV_CANCEL", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        // 메일 발송
                        fn_Mail_Send(txtCRREVTEAM.GetValue(), Get_Date(txtCRREVDATE.GetValue().replace("-", "")), txtCRREVSEQ.GetValue(), txtCRREVSABUN1.GetValue(), "CANCEL");

                        //fn_GET_Display();

                        //fn_GET_Site();

                        //// 공백 이미지
                        //fn_BLANK_IMAGE();

                        ////alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="변경검토서 취소 처리가 되었습니다." Literal="true"></Ctl:Text>');

                        //fn_Btn_Visible('3');
                    }
                    else {

                    }
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="변경검토서 취소 처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });

        }


        function fn_Screen_Save(Gubun) {

            fn_Save
                (
                    txtCRREVTEAM.GetValue(),
                    Get_Date(txtCRREVDATE.GetValue().replace("-", "")),
                    txtCRREVSEQ.GetValue(),
                    txtCRASKTEAM.GetValue(),                               // 요구번호(팀)
                    Get_Date(txtCRASKDATE.GetValue().replace("-", "")),    // 요구번호(일자)
                    txtCRASKSEQ.GetValue(),                                // 요구번호(순번)
                    txtCRWOTEAM.GetValue(),                                // 요청번호(팀)
                    Get_Date(txtCRWODATE.GetValue().replace("-", "")),     // 요청번호(일자)
                    txtCRWOSEQ.GetValue(),                                 // 요청번호(순번)
                    txtCRREVCONTENT.GetValue(),                            // 설비명 또는 변경요소
                    txtCRREVDATA.GetValue(),                               // 검토자료
                    txtCRREVSUMMARY.GetValue(),                            // 검토내용
                    cboCRREVAPPROVAL.GetValue(),                           // 승인, 미승인
                    txtCRREVREASION.GetValue(),                            // 사유
                    txtCRREVSABUN1.GetValue(),
                    txtCRREVNAME1.GetValue(),
                    txtCRREVJKCD1.GetValue(),
                    txtCRREVJKCDNM1.GetValue(),
                    "",//txtCRREVCOMMENT1.GetValue(),
                    txtCRREVSABUN2.GetValue(),
                    txtCRREVNAME2.GetValue(),
                    txtCRREVJKCD2.GetValue(),
                    txtCRREVJKCDNM2.GetValue(),
                    "",//txtCRREVCOMMENT2.GetValue(),
                    txtCRREVSABUN3.GetValue(),
                    txtCRREVNAME3.GetValue(),
                    txtCRREVJKCD3.GetValue(),
                    txtCRREVJKCDNM3.GetValue(),
                    "",//txtCRREVCOMMENT3.GetValue(),
                    txtCRREVSABUN4.GetValue(),
                    txtCRREVNAME4.GetValue(),
                    txtCRREVJKCD4.GetValue(),
                    txtCRREVJKCDNM4.GetValue(),
                    "",//txtCRREVCOMMENT4.GetValue(),
                    txtCRREVSABUN5.GetValue(),
                    txtCRREVNAME5.GetValue(),
                    txtCRREVJKCD5.GetValue(),
                    txtCRREVJKCDNM5.GetValue(),
                    "",//txtCRREVCOMMENT5.GetValue(),
                    txtCRREVSABUN6.GetValue(),
                    txtCRREVNAME6.GetValue(),
                    txtCRREVJKCD6.GetValue(),
                    txtCRREVJKCDNM6.GetValue(),
                    "",//txtCRREVCOMMENT6.GetValue(),
                    Gubun.toString()
            );
        }

        
        function fn_Save(
            sCRREVTEAM,       sCRREVDATE,       sCRREVSEQ,
            sCRASKTEAM,       sCRASKDATE,       sCRASKSEQ,
            sCRWOTEAM,        sCRWODATE,        sCRWOSEQ,
            sCRREVCONTENT,    sCRREVDATA,       sCRREVSUMMARY,
            sCRREVAPPROVAL,   sCRREVREASION,    
            sCRREVSABUN1,     sCRREVNAME1,      sCRREVJKCD1,
            sCRREVJKCDNM1,    sCRREVCOMMENT1,
            sCRREVSABUN2,     sCRREVNAME2,      sCRREVJKCD2,
            sCRREVJKCDNM2,    sCRREVCOMMENT2,
            sCRREVSABUN3,     sCRREVNAME3,      sCRREVJKCD3,
            sCRREVJKCDNM3,    sCRREVCOMMENT3,
            sCRREVSABUN4,     sCRREVNAME4,      sCRREVJKCD4,
            sCRREVJKCDNM4,    sCRREVCOMMENT4,
            sCRREVSABUN5,     sCRREVNAME5,      sCRREVJKCD5,
            sCRREVJKCDNM5,    sCRREVCOMMENT5,
            sCRREVSABUN6,     sCRREVNAME6,      sCRREVJKCD6,
            sCRREVJKCDNM6,    sCRREVCOMMENT6,   sGUBUN)
        {
            if (sCRREVCONTENT.toString() == "") {

                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="검토 항목을 입력하세요." Literal="true"></Ctl:Text>');

                return false;
            }

            if (sCRREVDATA.toString() == "") {

                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="검토 자료를 입력하세요." Literal="true"></Ctl:Text>');

                return false;
            }

            if (sCRREVSUMMARY.toString() == "") {

                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="검토 내용을 입력하세요." Literal="true"></Ctl:Text>');

                return false;
            }

            var i = 0;

            var iCOUNT = 0;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_WOORTEAM"] = sCRWOTEAM.toString();
            ht["P_WOORDATE"] = sCRWODATE.toString();
            ht["P_WOSEQ"]    = sCRWOSEQ.toString();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4030", "UP_WORKORDER_CHECK", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    if (txtCRREVSABUN6.GetValue() != "") {
                        iCOUNT = 6;
                    }
                    else if (txtCRREVSABUN5.GetValue() != "") {
                        iCOUNT = 5;
                    }
                    else if (txtCRREVSABUN4.GetValue() != "") {
                        iCOUNT = 4;
                    }
                    else if (txtCRREVSABUN3.GetValue() != "") {
                        iCOUNT = 3;
                    }
                    else if (txtCRREVSABUN2.GetValue() != "") {
                        iCOUNT = 2;
                    }
                    else if (txtCRREVSABUN1.GetValue() != "") {
                        iCOUNT = 1;
                    }

                    var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                    ht1["P_CRREVTEAM"]       = sCRREVTEAM;
                    ht1["P_CRREVDATE"]       = sCRREVDATE;
                    ht1["P_CRASKTEAM"]       = sCRASKTEAM;
                    ht1["P_CRASKDATE"]       = sCRASKDATE;
                    ht1["P_CRASKSEQ"]        = sCRASKSEQ;
                    ht1["P_CRWOTEAM"]        = sCRWOTEAM;
                    ht1["P_CRWODATE"]        = sCRWODATE;
                    ht1["P_CRWOSEQ"]         = sCRWOSEQ;
                    ht1["P_CRREVCONTENT"]    = sCRREVCONTENT;
                    ht1["P_CRREVDATA"]       = sCRREVDATA;
                    ht1["P_CRREVSUMMARY"]    = sCRREVSUMMARY;
                    ht1["P_CRREVAPPROVAL"]   = sCRREVAPPROVAL;
                    ht1["P_CRREVREASION"]    = sCRREVREASION;
                    ht1["P_CRREVSABUN1"]     = sCRREVSABUN1;
                    ht1["P_CRREVNAME1"]      = sCRREVNAME1;
                    ht1["P_CRREVJKCD1"]      = sCRREVJKCD1;
                    ht1["P_CRREVJKCDNM1"]    = sCRREVJKCDNM1;
                    ht1["P_CRREVCOMMENT1"]   = sCRREVCOMMENT1;
                    ht1["P_CRREVSABUN2"]     = sCRREVSABUN2;
                    ht1["P_CRREVNAME2"]      = sCRREVNAME2;
                    ht1["P_CRREVJKCD2"]      = sCRREVJKCD2;
                    ht1["P_CRREVJKCDNM2"]    = sCRREVJKCDNM2;
                    ht1["P_CRREVCOMMENT2"]   = sCRREVCOMMENT2;
                    ht1["P_CRREVSABUN3"]     = sCRREVSABUN3;
                    ht1["P_CRREVNAME3"]      = sCRREVNAME3;
                    ht1["P_CRREVJKCD3"]      = sCRREVJKCD3;
                    ht1["P_CRREVJKCDNM3"]    = sCRREVJKCDNM3;
                    ht1["P_CRREVCOMMENT3"]   = sCRREVCOMMENT3;
                    ht1["P_CRREVSABUN4"]     = sCRREVSABUN4;
                    ht1["P_CRREVNAME4"]      = sCRREVNAME4;
                    ht1["P_CRREVJKCD4"]      = sCRREVJKCD4;
                    ht1["P_CRREVJKCDNM4"]    = sCRREVJKCDNM4;
                    ht1["P_CRREVCOMMENT4"]   = sCRREVCOMMENT4;
                    ht1["P_CRREVSABUN5"]     = sCRREVSABUN5;
                    ht1["P_CRREVNAME5"]      = sCRREVNAME5;
                    ht1["P_CRREVJKCD5"]      = sCRREVJKCD5;
                    ht1["P_CRREVJKCDNM5"]    = sCRREVJKCDNM5;
                    ht1["P_CRREVCOMMENT5"]   = sCRREVCOMMENT5;
                    ht1["P_CRREVSABUN6"]     = sCRREVSABUN6;
                    ht1["P_CRREVNAME6"]      = sCRREVNAME6;
                    ht1["P_CRREVJKCD6"]      = sCRREVJKCD6;
                    ht1["P_CRREVJKCDNM6"]    = sCRREVJKCDNM6;
                    ht1["P_CRREVCOMMENT6"]   = sCRREVCOMMENT6;

                    ht1["P_CRREVHISAB"]      = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
                    ht1["P_RESABUN"]         = fsRESABUN;
                    ht1["P_RENAME"]          = txtRENAME.GetValue();
                    ht1["P_COUNT"]           = iCOUNT;
                    ht1["P_APPROVAL"]        = Get_Numeric(fshdnApproval);
                    ht1["P_GUBUN"] = sGUBUN;

                    if (fshdnExists.toString() == "NEW") {

                        ht["P_CRREVTEAM"] = sCRREVTEAM.toString();
                        ht["P_CRREVDATE"] = sCRREVDATE.toString();

                        PageMethods.InvokeServiceTable(ht, "PSM.PSM4030", "UP_PSM4031_GET_MAX_SEQ", function (e) {

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                                txtCRREVSEQ.SetValue(DataSet.Tables[0].Rows[0]["CRREVSEQ"]);

                                sCRREVSEQ = txtCRREVSEQ.GetValue();

                                ht1["P_CRREVSEQ"] = sCRREVSEQ;

                                // 저장 및 결재
                                PageMethods.InvokeServiceTable(ht1, "PSM.PSM4030", "UP_CHANGEREV_DOC_APPROVAL", function (e) {

                                    var DataSet1 = eval(e);

                                    if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                                        // 첨부파일 저장
                                        UploadStart(GetAttachFile_Callback);

                                        fshdnExists = "EXISTS";

                                        if (sGUBUN.toString() == "APPROVAL") {

                                            txtCRREVTEAM.SetValue(sCRREVTEAM);
                                            txtCRREVDATE.SetValue(sCRREVDATE.substr(0, 4) + "-" + sCRREVDATE.substr(4, 2) + "-" + sCRREVDATE.substr(6, 2));
                                            txtCRREVSEQ.SetValue(sCRREVSEQ);

                                            // 결재 사인 DISPLAY
                                            fn_APPROVAL_Display(DataSet1, txtCRREVTEAM.GetValue(), txtCRREVDATE.GetValue(), txtCRREVSEQ.GetValue(), "OK");

                                            fn_Btn_Visible('3');

                                            /*alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');*/
                                        }
                                        else {
                                            // 요구서 작성자      = 변경 종류만 수정
                                            // 수신자(안전환경팀) = 변경등급만 수정
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

                        ht1["P_CRREVSEQ"] = sCRREVSEQ;

                        PageMethods.InvokeServiceTable(ht1, "PSM.PSM4030", "UP_CHANGEREV_DOC_APPROVAL", function (e) {

                            fshdnExists = "EXISTS";

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                                // 첨부파일 저장
                                UploadStart(GetAttachFile_Callback);

                                if (sGUBUN.toString() == "APPROVAL") {

                                    txtCRREVTEAM.SetValue(sCRREVTEAM);
                                    txtCRREVDATE.SetValue(sCRREVDATE.substr(0, 4) + "-" + sCRREVDATE.substr(4, 2) + "-" + sCRREVDATE.substr(6, 2));
                                    txtCRREVSEQ.SetValue(sCRREVSEQ);

                                    // 결재 사인 DISPLAY
                                    fn_APPROVAL_Display(DataSet, txtCRREVTEAM.GetValue(), txtCRREVDATE.GetValue(), txtCRREVSEQ.GetValue(), "OK");

                                    fn_Btn_Visible('3');

                                    //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');
                                }
                                else {

                                    // 요구서 작성자      = 변경 종류만 수정
                                    // 수신자(안전환경팀) = 변경등급만 수정
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

            var WKNUM = "";

            WKNUM = txtCRREVTEAM.GetValue() + Get_Date(txtCRREVDATE.GetValue().replace("-", "")) + Set_Fill3(txtCRREVSEQ.GetValue());

            fuName1.FileSave("RE", WKNUM.toString(), function () { });

            // 첨부파일 load
            AttachFileLod();
        }

        function AttachFileLod() {

            var WKNUM = "";

            WKNUM = txtCRREVTEAM.GetValue() + Get_Date(txtCRREVDATE.GetValue().replace("-", "")) + Set_Fill3(txtCRREVSEQ.GetValue());


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

            fuName1.FileLoad("RE", WKNUM, function () {
                // 로드완료

                // 프로그래스바 닫기
                PageProgressHide();
            });

        }


        function fn_Mail_Send(sCRREVTEAM, sCRREVDATE, sCRREVSEQ, sMail_Receiver, sGUBUN) {


            var sASKNUM  = "";
            var sWORKNUM = "";
            var sCAASKNO = "";
            var sCARECEIPTDATE = "";
            var sCAASKSTEPGN   = "";
            var sREVNUM        = "";

            var sTitle     = "";

            var sPGURL     = "";
            var sWOWORKDOC = "";
            var sAPNUM     = "";

            var sFINISH = "";

            /*sAPNUM = sCRREVTEAM.toString() + "-" + sCRREVDATE.toString() + "-" + Set_Fill3(sCRREVSEQ.toString());*/

            //sPGURL = "/Portal/PSM/PSM40/PSM4031.aspx?";
            //sPGURL = sPGURL + "APP_NUM=";
            //sPGURL = sPGURL + sAPNUM;
            //sPGURL = sPGURL + "^GUBUN=G";

            // 변경요구번호
            sASKNUM = txtCRASKTEAM.GetValue() + "-" + Get_Date(txtCRASKDATE.GetValue().replace("-", "")) + "-" + Set_Fill3(txtCRASKSEQ.GetValue());

            // 작업요청번호
            sWORKNUM = txtCRWOTEAM.GetValue() + "-" + Get_Date(txtCRWODATE.GetValue().replace("-", "")) + "-" + Set_Fill3(txtCRWOSEQ.GetValue());

            // 요구접수번호
            sCAASKNO = txtCRREVACYEAR.GetValue() + "-" + Set_Fill4(txtCRREVACSEQ.GetValue());

            // 접수일자
            sCARECEIPTDATE = Get_Date(txtCARECEIPTDATE.GetValue().replace("-", ""));

            // 변경검토번호
            sREVNUM = sCRREVTEAM.toString() + "-" + sCRREVDATE.toString() + "-" + Set_Fill3(sCRREVSEQ.toString());

            sAPNUM = sASKNUM.toString() + "-" + sWORKNUM.toString() + "-" + sCAASKNO.toString() + "-" + sCARECEIPTDATE.toString() + "-" + fsCAASKSTEPGN + "-" + sREVNUM.toString();

            sPGURL = "/Portal/PSM/PSM40/PSM4031.aspx?";
            sPGURL = sPGURL + "param=UPT&param1=";
            sPGURL = sPGURL + sAPNUM;

            if (sGUBUN == 'OK') {

                if (txtCRREVSABUN6.GetValue() != "") {
                    iCOUNT = 6;
                }
                else if (txtCRREVSABUN5.GetValue() != "") {
                    iCOUNT = 5;
                }
                else if (txtCRREVSABUN4.GetValue() != "") {
                    iCOUNT = 4;
                }
                else if (txtCRREVSABUN3.GetValue() != "") {
                    iCOUNT = 3;
                }
                else if (txtCRREVSABUN2.GetValue() != "") {
                    iCOUNT = 2;
                }
                else if (txtCRREVSABUN1.GetValue() != "") {
                    iCOUNT = 1;
                }


                if (parseInt(Get_Numeric(fshdnApproval)) == iCOUNT) {

                    sTitle = txtCRREVCONTENT.GetValue() + " - 변경검토서 완료";
                    sFINISH = "FINISH";
                }
                else {
                    sTitle = txtCRREVCONTENT.GetValue() + " - 변경검토서 제출";
                }
            }
            else {
                sTitle = txtCRREVCONTENT.GetValue() + " - 변경검토서 취소";
            }


            // 여기부터 할 차례
            var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht1["P_APNUM"]        = sAPNUM.toString();
            ht1["P_CRREVTEAM"]    = sCRREVTEAM.toString();
            ht1["P_CRREVDATE"]    = sCRREVDATE.toString();
            ht1["P_CRREVSEQ"]     = sCRREVSEQ.toString();
            ht1["P_SENDER"]       = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";
            ht1["P_RECEIVER"]     = sMail_Receiver.toString();
            ht1["P_PGURL"]        = sPGURL.toString();
            ht1["P_TITLE"]        = sTitle.toString();

            ht1["P_CRREVCONTENT"] = txtCRREVCONTENT.GetValue(); // 검토항목
            ht1["P_CRREVSUMMARY"] = txtCRREVSUMMARY.GetValue(); // 검토내용
            ht1["P_CRREVREASION"] = txtCRREVREASION.GetValue(); // 사유

            ht1["P_CAASKSTEPGN"]  = fsCAASKSTEPGN;
            ht1["P_FINISH"]       = sFINISH.toString();            
            ht1["P_GUBUN"]        = sGUBUN.toString();


            ht1["P_WOORTEAM"]     = txtCRWOTEAM.GetValue();
            ht1["P_WOORDATE"]     = Get_Date(txtCRWODATE.GetValue().replace("-",""));
            ht1["P_WOSEQ"]        = Set_Fill3(txtCRWOSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht1, "PSM.PSM4030", "UP_Get_Mail_List", function (e) {            

                var DataSet1 = eval(e);

                if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                    if (sGUBUN == "OK") {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');

                        if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                            opener.btnSearch_Click();
                        }

                        this.close();
                    }
                    else if (sGUBUN == "CANCEL") {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="변경검토서 취소 처리가 되었습니다." Literal="true"></Ctl:Text>');

                        this.close();
                    }
                }

            }, function (e) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');

                this.close();

            });

        }

        function fn_APPROVAL_Display(DataSet, sCRREVTEAM, sCRREVDATE, sCRREVSEQ, sGUBUN) {

            var iCOUNT = 0;
            var sMail_Receiver = "";

            fsboolean = false;

            if (DataSet.Tables[0].Rows[0]["CRREVDATE1"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CRREVDATE1"];
                sTime = DataSet.Tables[0].Rows[0]["CRREVTIME1"];

                txtCRREVDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCRREVTIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('S1', DataSet.Tables[0].Rows[0]["CRREVSABUN1"], DataSet.Tables[0].Rows[0]["SOIMGNAME1"])

                fshdnApproval = "1";

                fsboolean = true;
            }

            txtCRREVSABUN2.SetValue(DataSet.Tables[0].Rows[0]["CRREVSABUN2"]);
            txtCRREVJKCD2.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCD2"]);

            txtCRREVJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCDNM2"]);
            txtCRREVNAME2.SetValue(DataSet.Tables[0].Rows[0]["CRREVNAME2"]);

            if (DataSet.Tables[0].Rows[0]["CRREVDATE2"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CRREVDATE2"];
                sTime = DataSet.Tables[0].Rows[0]["CRREVTIME2"];

                txtCRREVDATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCRREVTIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('S2', DataSet.Tables[0].Rows[0]["CRREVSABUN2"], DataSet.Tables[0].Rows[0]["SOIMGNAME2"])

                fshdnApproval = "2";
            }

            txtCRREVSABUN3.SetValue(DataSet.Tables[0].Rows[0]["CRREVSABUN3"]);
            txtCRREVJKCD3.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCD3"]);

            txtCRREVJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCDNM3"]);
            txtCRREVNAME3.SetValue(DataSet.Tables[0].Rows[0]["CRREVNAME3"]);

            if (DataSet.Tables[0].Rows[0]["CRREVDATE3"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CRREVDATE3"];
                sTime = DataSet.Tables[0].Rows[0]["CRREVTIME3"];

                txtCRREVDATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCRREVTIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('S3', DataSet.Tables[0].Rows[0]["CRREVSABUN3"], DataSet.Tables[0].Rows[0]["SOIMGNAME3"])

                fshdnApproval = "3";
            }

            txtCRREVSABUN4.SetValue(DataSet.Tables[0].Rows[0]["CRREVSABUN4"]);
            txtCRREVJKCD4.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCD4"]);

            txtCRREVJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCDNM4"]);
            txtCRREVNAME4.SetValue(DataSet.Tables[0].Rows[0]["CRREVNAME4"]);

            if (DataSet.Tables[0].Rows[0]["CRREVDATE4"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CRREVDATE4"];
                sTime = DataSet.Tables[0].Rows[0]["CRREVTIME4"];

                txtCRREVDATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCRREVTIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('S4', DataSet.Tables[0].Rows[0]["CRREVSABUN4"], DataSet.Tables[0].Rows[0]["SOIMGNAME4"])

                fshdnApproval = "4";
            }

            txtCRREVSABUN5.SetValue(DataSet.Tables[0].Rows[0]["CRREVSABUN5"]);
            txtCRREVJKCD5.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCD5"]);

            txtCRREVJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCDNM5"]);
            txtCRREVNAME5.SetValue(DataSet.Tables[0].Rows[0]["CRREVNAME5"]);

            if (DataSet.Tables[0].Rows[0]["CRREVDATE5"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CRREVDATE5"];
                sTime = DataSet.Tables[0].Rows[0]["CRREVTIME5"];

                txtCRREVDATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCRREVTIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('S5', DataSet.Tables[0].Rows[0]["CRREVSABUN5"], DataSet.Tables[0].Rows[0]["SOIMGNAME5"])

                fshdnApproval = "5";
            }





            txtCRREVSABUN6.SetValue(DataSet.Tables[0].Rows[0]["CRREVSABUN6"]);
            txtCRREVJKCD6.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCD6"]);

            txtCRREVJKCDNM6.SetValue(DataSet.Tables[0].Rows[0]["CRREVJKCDNM6"]);
            txtCRREVNAME6.SetValue(DataSet.Tables[0].Rows[0]["CRREVNAME6"]);

            if (DataSet.Tables[0].Rows[0]["CRREVDATE6"] != "") {

                sDate = DataSet.Tables[0].Rows[0]["CRREVDATE6"];
                sTime = DataSet.Tables[0].Rows[0]["CRREVTIME6"];

                txtCRREVDATE6.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                txtCRREVTIME6.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                Img_Read('S6', DataSet.Tables[0].Rows[0]["CRREVSABUN6"], DataSet.Tables[0].Rows[0]["SOIMGNAME6"])

                fshdnApproval = "6";
            }

            // 접수번호년도
            //txtCRREVACYEAR.SetValue(DataSet.Tables[0].Rows[0]["CRREVACYEAR"]);
            // 접수번호순번
            //txtCRREVACSEQ.SetValue(DataSet.Tables[0].Rows[0]["CRREVACSEQ"]);
            // 접수일자
            //txtCARECEIPTDATE.SetValue(DataSet.Tables[0].Rows[0]["CARECEIPTDATE"]);

            if (txtCRREVSABUN6.GetValue() != "") {
                iCOUNT = 6;
            }
            else if (txtCRREVSABUN5.GetValue() != "") {
                iCOUNT = 5;
            }
            else if (txtCRREVSABUN4.GetValue() != "") {
                iCOUNT = 4;
            }
            else if (txtCRREVSABUN3.GetValue() != "") {
                iCOUNT = 3;
            }
            else if (txtCRREVSABUN2.GetValue() != "") {
                iCOUNT = 2;
            }
            else if (txtCRREVSABUN1.GetValue() != "") {
                iCOUNT = 1;
            }

            // 메일수신자 가져오기
            sMail_Receiver = fn_GET_Mail_Sabun(iCOUNT, txtCRREVSABUN1.GetValue(), txtCRREVSABUN2.GetValue(), txtCRREVSABUN3.GetValue(), txtCRREVSABUN4.GetValue(), txtCRREVSABUN5.GetValue(), txtCRREVSABUN6.GetValue());

            //// 결재 완료 업데이트
            //fn_APPSTATUS_UPT();

            //// 메일 발송
            //fn_Mail_Send(sCRREVTEAM, sCRREVDATE, sCRREVSEQ, sMail_Receiver, sGUBUN);

            if (iCOUNT == parseInt(Get_Numeric(fshdnApproval))) // 요청 마지막 결재자
            {
                // 요구서 작성자      = 변경 종류만 수정
                // 수신자(안전환경팀) = 변경등급만 수정
                fn_Field_ReadOnly(fsboolean, true, false);
            }
            else {
                // 요구서 작성자      = 변경 종류만 수정
                // 수신자(안전환경팀) = 변경등급만 수정
                fn_Field_ReadOnly(fsboolean, true, true);
            }

            // 결재 완료 업데이트
            fn_APPSTATUS_UPT(sCRREVTEAM, sCRREVDATE, sCRREVSEQ, sMail_Receiver, sGUBUN);
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
            ht["P_WOORTEAM"]      = txtCRREVTEAM.GetValue();
            ht["P_WOORDATE"]      = Get_Date(txtCRREVDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"]         = txtCRREVSEQ.GetValue();

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
            ht["P_WOORTEAM"]     = txtCRREVTEAM.GetValue();
            ht["P_WOORDATE"] = Get_Date(txtCRREVDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"]        = txtCRREVSEQ.GetValue();
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

            var iCOUNT = 0;

            if (txtCRREVSABUN6.GetValue() != "") {
                iCOUNT = 6;
            }
            else if (txtCRREVSABUN5.GetValue() != "") {
                iCOUNT = 5;
            }
            else if (txtCRREVSABUN4.GetValue() != "") {
                iCOUNT = 4;
            }
            else if (txtCRREVSABUN3.GetValue() != "") {
                iCOUNT = 3;
            }
            else if (txtCRREVSABUN2.GetValue() != "") {
                iCOUNT = 2;
            }
            else if (txtCRREVSABUN1.GetValue() != "") {
                iCOUNT = 1;
            }
        }

        function fn_APPSTATUS_UPT(sCRREVTEAM, sCRREVDATE, sCRREVSEQ, sMail_Receiver, sGUBUN) {

            var iCOUNT = 0;

            if (txtCRREVSABUN6.GetValue() != "") {
                iCOUNT = 6;
            }
            else if (txtCRREVSABUN5.GetValue() != "") {
                iCOUNT = 5;
            }
            else if (txtCRREVSABUN4.GetValue() != "") {
                iCOUNT = 4;
            }
            else if (txtCRREVSABUN3.GetValue() != "") {
                iCOUNT = 3;
            }
            else if (txtCRREVSABUN2.GetValue() != "") {
                iCOUNT = 2;
            }
            else if (txtCRREVSABUN1.GetValue() != "") {
                iCOUNT = 1;
            }

            // 접수일자 업데이트
            // 결재라인에서 마지막 결재자 전결시 접수번호 및 접수일자 업데이트함
            if (iCOUNT == parseInt(Get_Numeric(fshdnApproval))) {

                //var ht3 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                //ht3["P_CRREVTEAM"] = txtCRREVTEAM.GetValue();
                //ht3["P_CRREVDATE"] = Get_Date(txtCRREVDATE.GetValue().replace("-", ""));
                //ht3["P_CRREVSEQ"] = Set_Fill3(txtCRREVSEQ.GetValue());

                //PageMethods.InvokeServiceTable(ht3, "PSM.PSM4030", "UP_CHANGEREV_RECEIPT_UPT", function (e) {

                //    var DataSet3 = eval(e);

                //    if (ObjectCount(DataSet3.Tables[0].Rows) == 1) {

                //        // 접수번호년도
                //        txtCRREVACYEAR.SetValue(DataSet3.Tables[0].Rows[0]["CRREVACYEAR"]);
                //        // 접수번호순번
                //        txtCRREVACSEQ.SetValue(DataSet3.Tables[0].Rows[0]["CRREVACSEQ"]);
                //        // 접수일자
                //        txtCARECEIPTDATE.SetValue(DataSet3.Tables[0].Rows[0]["CARECEIPTDATE"]);
                //    }
                //    else {
                //        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                //    }

                //}, function (e) {
                //    // Biz 연결오류
                //    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                //});


                // 수신 마지막 결재자일 경우
                // 작업요청서에 진행상태 업데이트함
                var ht2 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht2["P_WOSTATUS"] = "R";
                ht2["P_WOORTEAM"] = txtCRWOTEAM.GetValue();
                ht2["P_WOORDATE"] = Get_Date(txtCRWODATE.GetValue().replace("-", ""));
                ht2["P_WOSEQ"] = Set_Fill3(txtCRWOSEQ.GetValue());

                PageMethods.InvokeServiceTable(ht2, "PSM.PSM4030", "UP_WORKORDER_WOSTATUS_UPT", function (e) {

                    var DataSet2 = eval(e);

                    if (ObjectCount(DataSet2.Tables[0].Rows) == 1) {

                        if (DataSet2.Tables[0].Rows[0]["STATE"] == "OK") {

                            // 메일 발송
                            fn_Mail_Send(sCRREVTEAM, sCRREVDATE, sCRREVSEQ, sMail_Receiver, sGUBUN);
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
                fn_Mail_Send(sCRREVTEAM, sCRREVDATE, sCRREVSEQ, sMail_Receiver, sGUBUN);
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

        //// 콜백 함수
        //function btnPopup_Last_Callback(COMMENT, WOIMMEDGUBN, WOIMMEDTEXT) {

        //    var sSABUN    = "";
        //    var sSABUNNM = "";

        //    fsWOIMMEDGUBN = "";

        //    fsWOIMMEDGUBN = WOIMMEDGUBN;

        //    fsRETRACTCOMMENT = "";

        //    fn_COMMENT(COMMENT);

        //    // 조치내용
        //    txtWOIMMEDTEXT.SetValue(WOIMMEDTEXT);

        //    fn_Screen_Save("APPROVAL");
            
        //}
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

                doDisplay();

                fn_RETRACT_Proc();

                setTimeout("doDisplay()", '3000');
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

            fn_OpenPop("../../Common/ReportView.aspx?RPT=PSM4031_RPT&TEAM=" + txtCRREVTEAM.GetValue() + "&DATE=" + txtCRREVDATE.GetValue() + "&SEQ=" + txtCRREVSEQ.GetValue(), 1000, 600);
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
    <!--컨텐츠시작-->
    <div id="content" >
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server" Title="변경검토등록" DefaultHide="False">

            <div class="btn_bx" id ="div_btn" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="100px" />
                        <col width="300px" />
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left">
                            <Ctl:Text ID="lblCRASKTEAM" runat="server" LangCode="lblWOORTEAM" Description="변경요구번호" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtCRASKTEAM" Width ="60px" runat="server" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:Text ID="Text3" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtCRASKDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ReadOnly="true"></Ctl:TextBox> 
                            <Ctl:Text ID="Text5" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtCRASKSEQ" Width ="30px" style ="text-align:right;" runat="server" ReadOnly="true"></Ctl:TextBox>
                        </td>

                        <th style="text-align:left">
                            <Ctl:Text ID="lblCRREVTEAM" runat="server" LangCode="lblWOORTEAM" Description="변경검토번호" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left;border-right :hidden;">
                            <Ctl:TextBox ID="txtCRREVTEAM" Width ="60px" runat="server" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:Text ID="lblsprate1" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtCRREVDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                            <Ctl:Text ID="lblsprate2" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtCRREVSEQ" Width ="30px" style ="text-align:right;" runat="server" ReadOnly="true"></Ctl:TextBox>
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
                        <col width="80px" />
                        <col width="5px" />
                        <col width="70px" />
                        <col width="70px" />
                        <col width="70px" />
                        <col width="70px" />
                        <col width="70px" />
                    </colgroup>
                    <tr>
                        
                        <th style="text-align:left;" colspan ="6">
                            <Ctl:Text ID="Text1" runat="server" LangCode="lblWOORTEAM" Description="결재"></Ctl:Text>
                        </th>
                        
                    </tr>
                    <tr>
                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVSABUN1"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVJKCD1"   runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVJKCDNM1" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCRREVNAME1"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVSABUN2"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVJKCD2"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCRREVJKCDNM2" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCRREVNAME2"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVSABUN3"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVJKCD3"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCRREVJKCDNM3" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCRREVNAME3"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVSABUN4"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVJKCD4"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCRREVJKCDNM4" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCRREVNAME4"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVSABUN5"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVJKCD5"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCRREVJKCDNM5" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCRREVNAME5"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVSABUN6"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVJKCD6"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtCRREVJKCDNM6" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtCRREVNAME6"   runat="server" ></Ctl:Text>
                        </td>
                    </tr>

                    <tr style="height:100px;">

                        <td style="text-align:center;" >
                            <img ID="ImgCRREVPHOTO1" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCRREVPHOTO1" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCRREVPHOTO2" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCRREVPHOTO2" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCRREVPHOTO3" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCRREVPHOTO3" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCRREVPHOTO4" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCRREVPHOTO4" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgCRREVPHOTO5" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCRREVPHOTO5" visible ="true"></img>
                        </td>
                        <td style="text-align:center;" >
                            <img ID="ImgCRREVPHOTO6" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgCRREVPHOTO5" visible ="true"></img>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVDATE1" runat="server" LangCode="txtCRREVDATE1"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVTIME1" runat="server" LangCode="txtCRREVTIME1"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVDATE2" runat="server" LangCode="txtCRREVDATE2"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVTIME2" runat="server" LangCode="txtCRREVTIME2"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVDATE3" runat="server" LangCode="txtCRREVDATE3"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVTIME3" runat="server" LangCode="txtCRREVTIME3"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVDATE4" runat="server" LangCode="txtCRREVDATE4"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVTIME4" runat="server" LangCode="txtCRREVTIME4"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVDATE5" runat="server" LangCode="txtCRREVDATE5"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVTIME5" runat="server" LangCode="txtCRREVTIME5"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtCRREVDATE6" runat="server" LangCode="txtCRREVDATE5"></Ctl:Text>
                            <Ctl:Text ID="txtCRREVTIME6" runat="server" LangCode="txtCRREVTIME5"></Ctl:Text>
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
                            <Ctl:Text ID="lblCRREVCONTENT" runat="server" Description="검토항목"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtCRREVCONTENT" runat="server" Width ="1090px"></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblCRREVDATA" runat="server" Description="검토자료"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtCRREVDATA" runat="server" Width ="1090px"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblCRREVSUMMARY" runat="server" Description="검토내용"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtCRREVSUMMARY" runat="server" TextMode ="MultiLine"></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblCRREVCLASS" runat="server" Description="승인여부"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:Combo ID="cboCRREVAPPROVAL" Width="150px" runat="server">
                                <asp:ListItem Text="승인"   Value="Y" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="미승인" Value="N" ></asp:ListItem>
                            </Ctl:Combo>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblCRREVREASION" runat="server" Description="사 유"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtCRREVREASION" runat="server" Width ="1090px"></Ctl:TextBox>
                        </td>
                    </tr>

                </table>
            </div>

            <div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="10%" />
                        <col width="20%" />
                        <col width="10%" />
                        <col width="20%" />
                        <col width="10%" />
                        <col width="30%" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="6">
                            <Ctl:Text ID="Text14" runat="server" Description="변경요구"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblCRREVACYEAR" runat="server" Description="접수번호"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtCRREVACYEAR" runat="server" ReadOnly ="true" Width ="80px"></Ctl:TextBox>
                            <Ctl:Text ID="Text8" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
			                <Ctl:TextBox ID="txtCRREVACSEQ" runat="server" ReadOnly ="true" Width ="50px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text6" runat="server" Description="접수일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtCARECEIPTDATE" runat="server" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text9" runat="server" Description="요청번호"></Ctl:Text>
                        </td>

                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtCRWOTEAM" Width ="60px" runat="server" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:Text ID="Text11" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtCRWODATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ReadOnly="true"></Ctl:TextBox> 
                            <Ctl:Text ID="Text12" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtCRWOSEQ" Width ="30px" style ="text-align:right;" runat="server" ReadOnly="true"></Ctl:TextBox>
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
                            <Ctl:Text ID="Text2" runat="server" Description="변경검토"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text7" runat="server" Description="검토자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtCRREVAPPSABUN"  runat ="server" ReadOnly ="true" Width ="60px"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtCRREVAPPSABUNNM" runat="server" ReadOnly ="true" Width ="150px"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="Text10" runat="server" Description="검토완료일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="TextBox3" runat="server" ReadOnly ="true" Width ="100px"></Ctl:TextBox>
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