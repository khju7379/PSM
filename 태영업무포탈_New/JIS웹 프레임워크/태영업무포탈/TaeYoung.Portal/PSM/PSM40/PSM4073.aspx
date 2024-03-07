<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4073.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4073" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <style>           
            html,body {width:100%;  }
            body,div,ul,li{margin:0; padding:0;}
            ul,li {list-style:none;}
            
    </style>

    <script type="text/javascript">

        function doDisplay() {

            var obj = document.getElementById("div_btn");

            if (obj.style.display == 'none') {
                obj.style.display = '';
            } else {
                obj.style.display = 'none';
            }
        }

        // 작업구분
        var fshdnExists = "";

        // 요청 결재순서
        var fshdnApproval = "";
        var fshdnSign = "";

        // 사번
        var fshdnLoginSabun = "";

        var fsRETRACTCOMMENT = "";

        // 체크화면 잠금 여부
        var fsCheckLock = "";

        // 점검완료 구분
        var fsINSPECTGUBUN = "";

        var _id = "";

        // 페이지 로드
        function OnLoad() {

            $("#btnRETRACT").css("background-image", "url(/Resources/Images/Approval/reject.png)");
            $("#btnRETRACT").css("background-repeat", "no-repeat");
            $("#btnRETRACT").css("background-position", "3px 4px");
            $("#btnRETRACT").css("background-size", "17px,17px");
            $("#btnRETRACT").css("padding-left", "30px");

            $("#btnSOApproval").css("background-image", "url(/Resources/Images/Approval/setline.png)");
            $("#btnSOApproval").css("background-repeat", "no-repeat");
            $("#btnSOApproval").css("background-position", "3px 4px");
            $("#btnSOApproval").css("background-size", "17px,17px");
            $("#btnSOApproval").css("padding-left", "30px");

            $("#btnSave").css("background-image", "url(/Resources/Images/Approval/save.png)");
            $("#btnSave").css("background-repeat", "no-repeat");
            $("#btnSave").css("background-position", "3px 4px");
            $("#btnSave").css("background-size", "17px,17px");
            $("#btnSave").css("padding-left", "30px");

            $("#btnDel").css("background-image", "url(/Resources/Images/Approval/delete.png)");
            $("#btnDel").css("background-repeat", "no-repeat");
            $("#btnDel").css("background-position", "3px 4px");
            $("#btnDel").css("background-size", "17px,17px");
            $("#btnDel").css("padding-left", "30px");

            $("#btnApproval").css("background-image", "url(/Resources/Images/Approval/Approval.png)");
            $("#btnApproval").css("background-repeat", "no-repeat");
            $("#btnApproval").css("background-position", "3px 4px");
            $("#btnApproval").css("background-size", "17px,17px");
            $("#btnApproval").css("padding-left", "30px");

            $("#btnCancel").css("background-image", "url(/Resources/Images/Approval/reject.png)");
            $("#btnCancel").css("background-repeat", "no-repeat");
            $("#btnCancel").css("background-position", "3px 4px");
            $("#btnCancel").css("background-size", "17px,17px");
            $("#btnCancel").css("padding-left", "30px");

            $("#btnPrt").css("background-image", "url(/Resources/Images/Approval/print.png)");
            $("#btnPrt").css("background-repeat", "no-repeat");
            $("#btnPrt").css("background-position", "3px 4px");
            $("#btnPrt").css("background-size", "17px,17px");
            $("#btnPrt").css("padding-left", "30px");

            $("#btnClose").css("background-image", "url(/Resources/Images/Approval/close.png)");
            $("#btnClose").css("background-repeat", "no-repeat");
            $("#btnClose").css("background-position", "3px 4px");
            $("#btnClose").css("background-size", "17px,17px");
            $("#btnClose").css("padding-left", "30px");
            
            fshdnLoginSabun = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";

            fshdnExists = "<%= Request.QueryString["param"] %>";

            var Num = "<%= Request.QueryString["param1"] %>";

            var data = Num.split('^');

            if (fshdnExists == "NEW") {

                txtPECWOTEAM.SetValue(data[0].substr(0, 6));
                txtPECWODATE.SetValue(data[0].substr(7, 8));
                txtPECWOSEQ.SetValue(data[0].substr(16, 3));

                // 점검부서 가져오기
                fn_SET_Buseo();
                fn_Btn_Visible('0');

                UP_init();
            }
            else {

                txtPECWOTEAM.SetValue(data[0].substr(0, 6));
                txtPECWODATE.SetValue(data[0].substr(7, 8));
                txtPECWOSEQ.SetValue(data[0].substr(16, 3));
                txtPECTEAM.SetValue(data[1].substr(0, 6));
                txtPECDATE.SetValue(data[1].substr(7, 8));
                txtPECSEQ.SetValue(data[1].substr(16, 3));

                fn_GET_Display();
                
            }

            cboPECSGUBUN.SetDisabled(true);
        }

        function fn_ReadOnly() {

            var bReadOnly;
            var bReadOnly1;

            if (txtPECDATE1.GetValue() != "") {
                bReadOnly = true;
            }
            else {
                bReadOnly = false;
            }

            if (fshdnExists == "NEW") {
                fn_Field_ReadOnly(bReadOnly, false);
            }
            else {
                fn_Field_ReadOnly(bReadOnly, true);
            }
        }

        function fn_Field_ReadOnly(bReadOnly, bReadOnly1) {

            txtPECDATE.SetDisabled(bReadOnly1);         // 점검번호(일자)

            txtPECTITLE.SetDisabled(bReadOnly);         // 제목
            txtPECINSDATE.SetDisabled(bReadOnly);       // 점검일자

        }

        function fn_GET_Site() {

            var i_COUNT = 0;

            // 요청 결재자
            fn_Btn_Visible('0');

            if (txtPECSABUN6.GetValue() != "") {
                i_COUNT = 6;
            }
            else if (txtPECSABUN5.GetValue() != "") {
                i_COUNT = 5;
            }
            else if (txtPECSABUN4.GetValue() != "") {
                i_COUNT = 4;
            }
            else if (txtPECSABUN3.GetValue() != "") {
                i_COUNT = 3;
            }
            else if (txtPECSABUN2.GetValue() != "") {
                i_COUNT = 2;
            }
            else if (txtPECSABUN1.GetValue() != "") {
                i_COUNT = 1;
            }
            fshdnApproval = "0";

            if (txtPECDATE1.GetValue() != "") {

                fn_Get_Image('1');

                fshdnApproval = "1";
            }

            if (txtPECDATE2.GetValue() != "") {
                fn_Get_Image('2');

                fshdnApproval = "2";
            }

            if (txtPECDATE3.GetValue() != "") {
                fn_Get_Image('3');

                fshdnApproval = "3";
            }

            if (txtPECDATE4.GetValue() != "") {
                fn_Get_Image('4');

                fshdnApproval = "4";
            }

            if (txtPECDATE5.GetValue() != "") {
                fn_Get_Image('5');

                fshdnApproval = "5";
            }

            if (txtPECDATE6.GetValue() != "") {
                fn_Get_Image('6');

                fshdnApproval = "6";
            }

            fshdnSign = "";

            fn_Get_Approval_Line(i_COUNT, fshdnApproval,
                txtPECSABUN1.GetValue(), txtPECDATE1.GetValue(),
                txtPECSABUN2.GetValue(), txtPECDATE2.GetValue(),
                txtPECSABUN3.GetValue(), txtPECDATE3.GetValue(),
                txtPECSABUN4.GetValue(), txtPECDATE4.GetValue(),
                txtPECSABUN5.GetValue(), txtPECDATE5.GetValue(),
                txtPECSABUN6.GetValue(), txtPECDATE6.GetValue(),
            );
        }

        function fn_Get_Approval_Line(i_Cnt, s_Cnt,
            sSABUN1, sDATE1,
            sSABUN2, sDATE2,
            sSABUN3, sDATE3,
            sSABUN4, sDATE4,
            sSABUN5, sDATE5,
            sSABUN6, sDATE6
        ) {
            var sExists = "";
            var s_BUSEO = ""; // 첫 요청자 부서코드
            var sLOGIN_BUSEO = ""; // 로그인 부서코드

            var sNOWAPP_SABUN = ""; // 현재 요청 결재할 사람

            var today = new Date();
            var date = "";

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            // 현재 요청 결재할 사람
            if (sSABUN1.toString() != "" && sDATE1.toString() == "") {
                sNOWAPP_SABUN = sSABUN1.toString();
            }
            else if (sSABUN2.toString() != "" && sDATE2.toString() == "") {
                sNOWAPP_SABUN = sSABUN2.toString();
            }
            else if (sSABUN3.toString() != "" && sDATE3.toString() == "") {
                sNOWAPP_SABUN = sSABUN3.toString();
            }
            else if (sSABUN4.toString() != "" && sDATE4.toString() == "") {
                sNOWAPP_SABUN = sSABUN4.toString();
            }
            else if (sSABUN5.toString() != "" && sDATE5.toString() == "") {
                sNOWAPP_SABUN = sSABUN5.toString();
            }
            else if (sSABUN6.toString() != "" && sDATE6.toString() == "") {
                sNOWAPP_SABUN = sSABUN6.toString();
            }
            

            ht1["P_DATE"] = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());

            ht1["P_KBSABUN"] = fshdnLoginSabun;

            // 로그인 부서코드
            sLOGIN_BUSEO = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode%>";

            if (Get_Numeric(s_Cnt) == "0") {

                if (sSABUN1 == fshdnLoginSabun) {

                    fn_Btn_Visible('0');
                }
                else {
                    if (s_BUSEO == sLOGIN_BUSEO) {

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
                if (sSABUN1.toString() != "") {

                    ht["P_KBSABUN"] = sNOWAPP_SABUN.toString();

                    PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                            // 첫 요청자 부서코드
                            s_BUSEO = DataSet.Tables[0].Rows[0]["KBBUSEO"];


                            // 요청 결재자
                            for (var i = parseInt(Get_Numeric(s_Cnt)); i <= i_Cnt; i++) {
                                if (i == i_Cnt) {

                                    if (i == 1) {
                                        if (sSABUN1 == fshdnLoginSabun) {
                                            if (sDATE1 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }

                                            sExists = "EXISTS";
                                            break;
                                        }
                                        else {
                                            if (sDATE1 == "") {
                                                if (s_BUSEO == sLOGIN_BUSEO) {

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
                                        if (sSABUN2 == fshdnLoginSabun) {
                                            if (sDATE2 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }

                                            sExists = "EXISTS";
                                            break;
                                        }
                                        else {
                                            if (sDATE2 == "") {
                                                if (s_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSABUN1 == fshdnLoginSabun) {
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
                                        if (sSABUN3 == fshdnLoginSabun) {
                                            if (sDATE3 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }

                                            sExists = "EXISTS";
                                            break;
                                        }
                                        else {
                                            if (sDATE3 == "") {
                                                if (s_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSABUN1 == fshdnLoginSabun) {
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
                                        if (sSABUN4 == fshdnLoginSabun) {
                                            if (sDATE4 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }

                                            sExists = "EXISTS";
                                            break;
                                        }
                                        else {
                                            if (sDATE4 == "") {
                                                if (s_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSABUN1 == fshdnLoginSabun) {
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
                                        if (sSABUN5 == fshdnLoginSabun) {
                                            if (sDATE5 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }

                                            sExists = "EXISTS";
                                            break;
                                        }
                                        else {
                                            if (sDATE5 == "") {
                                                if (s_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSABUN1 == fshdnLoginSabun) {
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
                                    else if (i == 6) {
                                        if (sSABUN6 == fshdnLoginSabun) {
                                            if (sDATE6 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }

                                            sExists = "EXISTS";
                                            break;
                                        }
                                        else {
                                            if (sDATE6 == "") {
                                                if (s_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSABUN1 == fshdnLoginSabun) {
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
                                else {
                                    if ((i + 1) == 1) {
                                        if (sSABUN1 == fshdnLoginSabun) {
                                            if (sDATE1 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }
                                        else {
                                            if (sDATE1 == "") {
                                                if (s_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSABUN1 == fshdnLoginSabun) {
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
                                        if (sSABUN2 == fshdnLoginSabun) {
                                            if (sDATE2 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }
                                        else {
                                            if (sDATE2 == "") {
                                                if (s_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSABUN1 == fshdnLoginSabun) {
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
                                        if (sSABUN3 == fshdnLoginSabun) {
                                            if (sDATE3 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }
                                        else {
                                            if (sDATE3 == "") {
                                                if (s_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSABUN1 == fshdnLoginSabun) {
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
                                        if (sSABUN4 == fshdnLoginSabun) {
                                            if (sDATE4 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }
                                        else {
                                            if (sDATE4 == "") {
                                                if (s_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSABUN1 == fshdnLoginSabun) {
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
                                    else if ((i + 1) == 5) {
                                        if (sSABUN5 == fshdnLoginSabun) {
                                            if (sDATE5 == "") {
                                                fn_Btn_Visible('1');
                                            }
                                            else {
                                                fn_Btn_Visible('3');
                                            }
                                        }
                                        else {
                                            if (sDATE5 == "") {
                                                if (s_BUSEO == sLOGIN_BUSEO) {
                                                    if (sSABUN1 == fshdnLoginSabun) {
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
                if (i_Cnt == parseInt(Get_Numeric(s_Cnt))) {
                    fshdnSign = "Complete";

                }

                if (sExists == "") {
                    fn_Btn_Visible('3');
                }

                // 요청 결재 진행중
                if (i_Cnt != parseInt(Get_Numeric(s_Cnt))) {
                    if (Get_Numeric(s_Cnt) != "0") {
                        if (sSABUN1.toString() == fshdnLoginSabun) {
                            fn_Btn_Visible('50');
                        }
                    }
                }
            }
        }

        // 버튼 숨김처리
        function fn_Btn_Visible(gubun) {

            $("#btnRETRACT").hide();

            // 결재 요청자 결재전
            if (gubun == '0') {
                $("#btnSOApproval").show();     // 결재선
                $("#btnSave").show();           // 저장
                $("#btnDel").show();            // 삭제
                
                $("#btnPrt").hide();            // 출력
                $("#btnCancel").hide();         // 반려

                // 점검 완료 후 결재버튼 표시
                if (fsINSPECTGUBUN == "Y") {
                    $("#btnApproval").show();   // 결재
                }
                else{
                    $("#btnApproval").hide();   // 결재
                }
            }
            else {
                $("#btnDel").hide();            // 삭제
                $("#btnSave").hide();           // 저장
                $("#tsPrt").show();             // 출력

            }

            // 현재 결재자 
            if (gubun == '1') {
                $("#btnCancel").show();         // 반려
                $("#btnApproval").show();       // 결재
                $("#btnSOApproval").show();     // 결재선
            }

            // 결재 완료자
            if (gubun == '3') {
                $("#btnSOApproval").hide();     // 결재선
                $("#btnApproval").hide();       // 결재
                $("#btnSave").hide();           // 저장
                $("#btnDel").hide();            // 삭제
                $("#btnPrt").show();            // 출력
                $("#btnCancel").hide();         // 반려

            }

            if (gubun == '5') {
                $("#btnCancel").show();         // 반려
                $("#btnSOApproval").show();     // 결재선
            }

            if (gubun == '6') {
                $("#btnCancel").hide();         // 반려
                $("#btnApproval").hide();       // 결재
                $("#btnSOApproval").show();     // 결재선  
            }

            if (gubun == '30') {
                $("#btnSOApproval").hide();     // 결재선
            }

            if (gubun == '50') {
                $("#btnRETRACT").show();        // 철회
            }

            // 결재 요청자 결재후
            if (gubun == '70') {
                
                $("#btnRETRACT").show();        // 철회
            }
        }

        function UP_init() {

            var today = new Date();

            txtPECDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            txtPECINSDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

            $("#COMMENTTITLE").attr("style", "display:none;");
            $("#COMMENTLINE1").attr("style", "display:none;");
            $("#COMMENTLINE2").attr("style", "display:none;");
            $("#COMMENTLINE3").attr("style", "display:none;");
            $("#COMMENTLINE4").attr("style", "display:none;");
            $("#COMMENTLINE5").attr("style", "display:none;");
            $("#COMMENTLINE6").attr("style", "display:none;");

            $("#btnREPORT").attr("style", "display:none");

            btnMail.Hide();
            btnDel.Hide();
            btnDetailSave.Hide();
            btnCheckAll.Hide();
            fsCheckLock = "Y";

            // 마지막 점검자 저장 내역 조회

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_WKGUBUN"] = "NEW";
            ht["P_PECSABUN1"] = fshdnLoginSabun;

            gridInspect.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridInspect.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridInspect.CallBack = function () {
                var InspectRows = gridInspect.GetAllRow();

                for (i = 0; i < ObjectCount(InspectRows.Rows); i++) {
                    gridInspect.EditModeDisable(i, 2);
                }
            }
        }

        // 사이 이미지
        function fn_Get_Image(gubun) {

            var Num = "";
            var data = "";
            var control = "";

            Num = document.getElementById("conBody_ImgPECPHOTO" + gubun.substr(0, 1)).src;

            data = Num.split('&');

            control = $("#txtPECSABUN" + gubun.substr(0, 1)).val();

            Img_Read(gubun, control, data[1]);

            fshdnApproval = gubun.substr(0, 1);

        }
        // 로그인 사용자 부서 조회
        function fn_SET_Buseo() {

            var DataSet;
            var DataSet1;

            var ht = new Object();
            var ht1 = new Object();

            var today = new Date();

            ht["P_DATE"] = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());
            ht["P_KBSABUN"] = fshdnLoginSabun

            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    // 요청자1
                    txtPECSABUN1.SetValue("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>");
                    txtPECNAME1.SetValue(DataSet.Tables[0].Rows[0]["KBHANGL"]);
                    txtPECJKCD1.SetValue(DataSet.Tables[0].Rows[0]["KBJKCD"]);
                    txtPECJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["CDDESC1"]);

                    // 점검부서
                    txtPECTEAM.SetValue(DataSet.Tables[0].Rows[0]["KBBUSEO"]);
                }

                ht1["P_BUSEO1"] = "ALL";
                ht1["P_BUSEO2"] = "ALL";
                ht1["P_BUSEO3"] = "ALL";
                ht1["P_BUSEO4"] = "ALL";
                ht1["P_BUSEO5"] = "ALL";
                ht1["P_BUSEO6"] = "ALL";
                ht1["P_BUSEO7"] = "ALL";
                ht1["P_BUSEO8"] = "ALL";
                ht1["P_SABUN"] = fshdnLoginSabun

                PageMethods.InvokeServiceTable(ht1, "PSM.PSMBiz", "UP_ORG_GETDATA", function (e) {

                    DataSet1 = eval(e);

                    if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                        txtPECJKCD1.SetValue(DataSet1.Tables[0].Rows[0]["JCCD"]);
                        txtPECJKCDNM1.SetValue(DataSet1.Tables[0].Rows[0]["JKDESC"]);
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
            var sComment = false;

            fshdnApproval = "0";

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   
            var ht2 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            var ht3 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_PECTEAM"] = txtPECTEAM.GetValue();
            ht["P_PECDATE"] = txtPECDATE.GetValue();
            ht["P_PECSEQ"] = txtPECSEQ.GetValue();
            ht["P_PECWOTEAM"] = txtPECWOTEAM.GetValue();
            ht["P_PECWODATE"] = txtPECWODATE.GetValue().split("-").join("");
            ht["P_PECWOSEQ"] = txtPECWOSEQ.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_EXAM_CHECK_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    // 요청번호
                    txtPECTEAM.SetValue(DataSet.Tables[0].Rows[0]["PECTEAM"]);
                    txtPECTEAMNM.SetValue(DataSet.Tables[0].Rows[0]["PECTEAMNM"]);
                    txtPECDATE.SetValue(DataSet.Tables[0].Rows[0]["PECDATE"]);
                    txtPECSEQ.SetValue(Set_Fill3(DataSet.Tables[0].Rows[0]["PECSEQ"]));

                    // 점검번호
                    txtPECWOTEAM.SetValue(DataSet.Tables[0].Rows[0]["PECWOTEAM"]);
                    txtPECWODATE.SetValue(DataSet.Tables[0].Rows[0]["PECWODATE"]);
                    txtPECWOSEQ.SetValue(Set_Fill3(DataSet.Tables[0].Rows[0]["PECWOSEQ"]));

                    // 제목, 일자
                    txtPECTITLE.SetValue(DataSet.Tables[0].Rows[0]["PECTITLE"]);
                    txtPECINSDATE.SetValue(DataSet.Tables[0].Rows[0]["PECINSDATE"]);

                    // 점검표번호
                    cboPECSGUBUN.SetValue(DataSet.Tables[0].Rows[0]["PECSGUBUN"]);
                    txtPECSDATE.SetValue(DataSet.Tables[0].Rows[0]["PECSDATE"]);
                    txtPECSSEQ.SetValue(DataSet.Tables[0].Rows[0]["PECSSEQ"]);

                    // 보고서번호
                    txtPECRDATE.SetValue(DataSet.Tables[0].Rows[0]["PECRDATE"]);
                    if(DataSet.Tables[0].Rows[0]["PECRDATE"] != "")
                    {
                        txtPECRSEQ.SetValue(DataSet.Tables[0].Rows[0]["PECRSEQ"]);
                        //$("#btnREPORT").attr("style", "display:;cursor:pointer;height: 25px;width: 25px;");
                    }
                    else
                    {
                        txtPECRSEQ.SetValue("");
                        //$("#btnREPORT").attr("style", "display:none");
                    }

                    // 결재자1
                    txtPECJKCD1.SetValue(DataSet.Tables[0].Rows[0]["PECJKCD1"]);
                    txtPECJKCDNM1.SetValue(DataSet.Tables[0].Rows[0]["PECJKCDNM1"]);
                    txtPECNAME1.SetValue(DataSet.Tables[0].Rows[0]["PECNAME1"]);
                    txtPECSABUN1.SetValue(DataSet.Tables[0].Rows[0]["PECSABUN1"]);

                    if (DataSet.Tables[0].Rows[0]["PECDATE1"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE1"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME1"];

                        txtPECDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('1', DataSet.Tables[0].Rows[0]["PECSABUN1"], DataSet.Tables[0].Rows[0]["IMGNAME1"])

                        fshdnApproval = "1";

                        if (DataSet.Tables[0].Rows[0]["PECCOMMENT1"] != "") {
                            txtPECCOMMENT1.SetValue(DataSet.Tables[0].Rows[0]["PECCOMMENT1"]);
                            $("#COMMENTLINE1").attr("style", "display:;");
                            sComment = true;
                        }
                        else {
                            txtPECCOMMENT1.SetValue("");
                            $("#COMMENTLINE1").attr("style", "display:none;");
                        }
                    }
                    else {
                        txtPECDATE1.SetValue("");
                        txtPECTIME1.SetValue("");
                        $("#COMMENTLINE1").attr("style", "display:none;");
                    }

                    // 결재자2
                    txtPECJKCD2.SetValue(DataSet.Tables[0].Rows[0]["PECJKCD2"]);
                    txtPECJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["PECJKCDNM2"]);
                    txtPECNAME2.SetValue(DataSet.Tables[0].Rows[0]["PECNAME2"]);
                    txtPECSABUN2.SetValue(DataSet.Tables[0].Rows[0]["PECSABUN2"]);

                    if (DataSet.Tables[0].Rows[0]["PECDATE2"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE2"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME2"];

                        txtPECDATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('2', DataSet.Tables[0].Rows[0]["PECSABUN2"], DataSet.Tables[0].Rows[0]["IMGNAME2"])

                        fshdnApproval = "2";

                        if (DataSet.Tables[0].Rows[0]["PECCOMMENT2"] != "") {
                            txtPECCOMMENT2.SetValue(DataSet.Tables[0].Rows[0]["PECCOMMENT2"]);
                            $("#COMMENTLINE2").attr("style", "display:;");
                            sComment = true;
                        }
                        else {
                            txtPECCOMMENT2.SetValue("");
                            $("#COMMENTLINE2").attr("style", "display:none;");
                        }
                    }
                    else {
                        txtPECDATE2.SetValue("");
                        txtPECTIME2.SetValue("");
                        $("#COMMENTLINE2").attr("style", "display:none;");
                    }

                    // 결재자3
                    txtPECJKCD3.SetValue(DataSet.Tables[0].Rows[0]["PECJKCD3"]);
                    txtPECJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["PECJKCDNM3"]);
                    txtPECNAME3.SetValue(DataSet.Tables[0].Rows[0]["PECNAME3"]);
                    txtPECSABUN3.SetValue(DataSet.Tables[0].Rows[0]["PECSABUN3"]);

                    if (DataSet.Tables[0].Rows[0]["PECDATE3"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE3"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME3"];

                        txtPECDATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('3', DataSet.Tables[0].Rows[0]["PECSABUN3"], DataSet.Tables[0].Rows[0]["IMGNAME3"])

                        fshdnApproval = "3";

                        if (DataSet.Tables[0].Rows[0]["PECCOMMENT3"] != "") {
                            txtPECCOMMENT3.SetValue(DataSet.Tables[0].Rows[0]["PECCOMMENT3"]);
                            $("#COMMENTLINE3").attr("style", "display:;");
                            sComment = true;
                        }
                        else {
                            txtPECCOMMENT3.SetValue("");
                            $("#COMMENTLINE3").attr("style", "display:none;");
                        }
                    }
                    else {
                        txtPECDATE3.SetValue("");
                        txtPECTIME3.SetValue("");
                        $("#COMMENTLINE3").attr("style", "display:none;");
                    }

                    // 결재자4
                    txtPECJKCD4.SetValue(DataSet.Tables[0].Rows[0]["PECJKCD4"]);
                    txtPECJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["PECJKCDNM4"]);
                    txtPECNAME4.SetValue(DataSet.Tables[0].Rows[0]["PECNAME4"]);
                    txtPECSABUN4.SetValue(DataSet.Tables[0].Rows[0]["PECSABUN4"]);

                    if (DataSet.Tables[0].Rows[0]["PECDATE4"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE4"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME4"];

                        txtPECDATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('4', DataSet.Tables[0].Rows[0]["PECSABUN4"], DataSet.Tables[0].Rows[0]["IMGNAME4"])

                        fshdnApproval = "4";

                        if (DataSet.Tables[0].Rows[0]["PECCOMMENT4"] != "") {
                            txtPECCOMMENT4.SetValue(DataSet.Tables[0].Rows[0]["PECCOMMENT4"]);
                            $("#COMMENTLINE4").attr("style", "display:;");
                            sComment = true;
                        }
                        else {
                            txtPECCOMMENT4.SetValue("");
                            $("#COMMENTLINE4").attr("style", "display:none;");
                        }
                    }
                    else {
                        txtPECDATE4.SetValue("");
                        txtPECTIME4.SetValue("");
                        $("#COMMENTLINE4").attr("style", "display:none;");
                    }

                    // 결재자5
                    txtPECJKCD5.SetValue(DataSet.Tables[0].Rows[0]["PECJKCD5"]);
                    txtPECJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["PECJKCDNM5"]);
                    txtPECNAME5.SetValue(DataSet.Tables[0].Rows[0]["PECNAME5"]);
                    txtPECSABUN5.SetValue(DataSet.Tables[0].Rows[0]["PECSABUN5"]);

                    if (DataSet.Tables[0].Rows[0]["PECDATE5"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE5"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME5"];

                        txtPECDATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('5', DataSet.Tables[0].Rows[0]["PECSABUN5"], DataSet.Tables[0].Rows[0]["IMGNAME5"])

                        fshdnApproval = "5";

                        if (DataSet.Tables[0].Rows[0]["PECCOMMENT5"] != "") {
                            txtPECCOMMENT5.SetValue(DataSet.Tables[0].Rows[0]["PECCOMMENT5"]);
                            $("#COMMENTLINE5").attr("style", "display:;");
                            sComment = true;
                        }
                        else {
                            txtPECCOMMENT5.SetValue("");
                            $("#COMMENTLINE5").attr("style", "display:none;");
                        }
                    }
                    else {
                        txtPECDATE5.SetValue("");
                        txtPECTIME5.SetValue("");
                        $("#COMMENTLINE5").attr("style", "display:none;");
                    }

                    // 결재자6
                    txtPECJKCD6.SetValue(DataSet.Tables[0].Rows[0]["PECJKCD6"]);
                    txtPECJKCDNM6.SetValue(DataSet.Tables[0].Rows[0]["PECJKCDNM6"]);
                    txtPECNAME6.SetValue(DataSet.Tables[0].Rows[0]["PECNAME6"]);
                    txtPECSABUN6.SetValue(DataSet.Tables[0].Rows[0]["PECSABUN6"]);

                    if (DataSet.Tables[0].Rows[0]["PECDATE6"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE6"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME6"];

                        txtPECDATE6.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME6.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('6', DataSet.Tables[0].Rows[0]["PECSABUN6"], DataSet.Tables[0].Rows[0]["IMGNAME6"])

                        fshdnApproval = "6";

                        if (DataSet.Tables[0].Rows[0]["PECCOMMENT6"] != "") {
                            txtPECCOMMENT6.SetValue(DataSet.Tables[0].Rows[0]["PECCOMMENT6"]);
                            $("#COMMENTLINE6").attr("style", "display:;");
                            sComment = true;
                        }
                        else {
                            txtPECCOMMENT6.SetValue("");
                            $("#COMMENTLINE6").attr("style", "display:none;");
                        }
                    }
                    else {
                        txtPECDATE6.SetValue("");
                        txtPECTIME6.SetValue("");
                        $("#COMMENTLINE6").attr("style", "display:none;");
                    }

                    if (sComment == false) {
                        $("#COMMENTTITLE").attr("style", "display:none;");
                    }
                    else {
                        $("#COMMENTTITLE").attr("style", "display:;");
                    }

                    // 점검완료 구분
                    fsINSPECTGUBUN = DataSet.Tables[0].Rows[0]["INSPECTGUBUN"];

                    // 점검항목 조회
                    ht2["P_WKGUBUN"] = "UPT";

                    ht2["P_PECDTCTEAM"] = txtPECTEAM.GetValue();
                    ht2["P_PECDTCDATE"] = txtPECDATE.GetValue();
                    ht2["P_PECDTCSEQ"] = txtPECSEQ.GetValue();
                    ht2["P_PECDGUBUN"] = cboPECSGUBUN.GetValue();
                    ht2["P_PECDDATE"] = txtPECSDATE.GetValue().split("-").join("");
                    ht2["P_PECDSEQ"] = txtPECSSEQ.GetValue();

                    gridDetail.Params(ht2); // 선언한 파라미터를 그리드에 전달함
                    gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                    gridDetail.CallBack = function () {

                        gridDataChange("UPT");

                        // 점검자 조회
                        ht3["P_WKGUBUN"] = "";
                        ht3["P_PEICTEAM"] = txtPECTEAM.GetValue();
                        ht3["P_PEICDATE"] = txtPECDATE.GetValue();
                        ht3["P_PEICSEQ"] = txtPECSEQ.GetValue();

                        gridInspect.Params(ht3); // 선언한 파라미터를 그리드에 전달함
                        gridInspect.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                        gridInspect.CallBack = function () {

                            fn_Inspect_check();
                        }
                    }

                    // 공통코드 가져오기
                    fn_Dataset_Common(txtPECSABUN1.GetValue(), txtPECDATE1.GetValue(),
                        txtPECSABUN2.GetValue(), txtPECDATE2.GetValue(),
                        txtPECSABUN3.GetValue(), txtPECDATE3.GetValue(),
                        txtPECSABUN4.GetValue(), txtPECDATE4.GetValue(),
                        txtPECSABUN5.GetValue(), txtPECDATE5.GetValue(),
                        txtPECSABUN6.GetValue(), txtPECDATE6.GetValue());

                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        // 점검자 점검여부 확인
        function fn_Inspect_check() {

            var DetailRows = gridDetail.GetAllRow();
            var InspectRows = gridInspect.GetAllRow();
            var InspectCheck = false;
            var Inspect = false;

            for (i = 0; i < ObjectCount(InspectRows.Rows); i++) {

                dr = InspectRows.Rows[i];

                gridInspect.EditModeDisable(i, 0); // 점검자(0)

                if (dr['PEICHKDATE'] != "") {
                    InspectCheck = true;
                }
                if (dr['PEISABUN'] == fshdnLoginSabun) {
                    Inspect = true;
                }
                else {
                    gridInspect.EditModeDisable(i, 2); // 점검일자(2)
                }
            }
            for (i = 0; i < ObjectCount(DetailRows.Rows); i++) {

                dr = DetailRows.Rows[i];

                if (dr['PECDCHECK_G'] == "▣" || dr['PECDCHECK_F'] == "▣" || dr['PECDCHECK_N'] == "▣") {

                    InspectCheck = true;
                }
            }

            // 점검자 점검전 && 로그인 사번과 첫 결재자 사번이 같은경우 
            if (!InspectCheck && fshdnLoginSabun == txtPECSABUN1.GetValue()) {

                $("#btnEXAM").attr("style", "display:;cursor:pointer;height: 25px;width: 25px;");
                btnRowAdd.Show();
                btnMail.Show();
                btnDetailSave.Hide();
                btnCheckAll.Hide();
                fsCheckLock = "Y";

                if (txtPECDATE1.GetValue() == "") {
                    // 점검자인 경우
                    if (Inspect) {

                        if (txtPECDATE1.GetValue() == "") {
                            btnDetailSave.Show();
                            btnCheckAll.Show();
                            fsCheckLock = "";
                        }
                    }
                }
            }
            else {
                $("#btnEXAM").attr("style", "display:none");
                btnRowAdd.Hide();
                btnMail.Hide();
                btnDetailSave.Hide();
                btnCheckAll.Hide();
                fsCheckLock = "Y";

                if (txtPECDATE1.GetValue() == "") {
                    // 점검자인 경우
                    if (Inspect) {
                        if (txtPECDATE1.GetValue() == "") {
                            btnDetailSave.Show();
                            btnCheckAll.Show();
                            fsCheckLock = "";
                        }
                    }
                }

                for (i = 0; i < ObjectCount(InspectRows.Rows); i++) {

                    gridInspect.SetValue(i, "ROWDEL", "");
                }
            }
        }

        function fn_Dataset_Common(sSABUN1, sDATE1,
                                   sSABUN2, sDATE2,
                                   sSABUN3, sDATE3,
                                   sSABUN4, sDATE4,
                                   sSABUN5, sDATE5,
                                   sSABUN6, sDATE6) {

            var REDOCID;
            var REDOCNUM;

            var sNOWAPP_SABUN = ""; // 현재 요청 결재할 사람

            var sLoginBuseo = "";

            var today = new Date();
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            // 현재 요청 결재할 사람
            if (sSABUN1.toString() != "" && sDATE1.toString() == "") {
                sNOWAPP_SABUN = sSABUN1.toString();
            }
            else if (sSABUN2.toString() != "" && sDATE2.toString() == "") {
                sNOWAPP_SABUN = sSABUN2.toString();
            }
            else if (sSABUN3.toString() != "" && sDATE3.toString() == "") {
                sNOWAPP_SABUN = sSABUN3.toString();
            }
            else if (sSABUN4.toString() != "" && sDATE4.toString() == "") {
                sNOWAPP_SABUN = sSABUN4.toString();
            }
            else if (sSABUN5.toString() != "" && sDATE5.toString() == "") {
                sNOWAPP_SABUN = sSABUN5.toString();
            }
            else if (sSABUN6.toString() != "" && sDATE6.toString() == "") {
                sNOWAPP_SABUN = sSABUN6.toString();
            }

            // 현재 요청 결재할 사람의 부서코드
            if (sSABUN1.toString() != "") {
                ht["P_NOWSABUN"] = sNOWAPP_SABUN.toString();
            }
            else {
                ht["P_NOWSABUN"] = "";
            }

            ht["P_GUBUN"] = "INDEX";
            ht["P_DATE"] = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());
            ht["P_LoginSABUN"] = fshdnLoginSabun;

            ht["P_GUBN"] = "WK";

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_Get_Ds_Common", function (e) {

                var dsComm = eval(e);

                if (ObjectCount(dsComm.Tables[0].Rows) > 0) {

                    sLoginBuseo = dsComm.Tables[0].Rows[0]["LOGINBUSEO"];

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
            $("#conBody_ImgPECPHOTO" + gubun.substr(0, 1)).attr("src", filepath);
        }

        function fn_BLANK_IMAGE() {
            $("#conBody_ImgPECPHOTO1").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgPECPHOTO2").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgPECPHOTO3").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgPECPHOTO4").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgPECPHOTO5").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgPECPHOTO6").attr("src", "/Resources/Framework/blank.gif");
        }

        function fn_GET_Mail_Sabun(i_Cnt, s_Cnt,
            sSABUN1, sSABUN2, sSABUN3,
            sSABUN4, sSABUN5, sSABUN6) {
            var sMail_Send;

            var i = 0;

            i = 0;

            // 요청 결재자
            for (i = parseInt(Get_Numeric(s_Cnt.toString())); i < i_Cnt; i++) {

                if (i + 1 == i_Cnt) {
                    if (i_Cnt == 1) {
                        sMail_Send = sSABUN1.toString();
                    }
                    else if (i_Cnt == 2) {
                        sMail_Send = sSABUN1.toString();
                    }
                    else if (i_Cnt == 3) {
                        sMail_Send = sSABUN1.toString();
                    }
                    else if (i_Cnt == 4) {
                        sMail_Send = sSABUN1.toString();
                    }
                    else if (i_Cnt == 5) {
                        sMail_Send = sSABUN1.toString();
                    }
                    else if (i_Cnt == 6) {
                        sMail_Send = sSABUN1.toString();
                    }
                }
                else if (i == 0) {
                    sMail_Send = sSABUN2.toString();

                    break;
                }
                else if (i == 1) {
                    sMail_Send = sSABUN3.toString();

                    break;
                }
                else if (i == 2) {
                    sMail_Send = sSABUN4.toString();

                    break;
                }
                else if (i == 3) {
                    sMail_Send = sSABUN5.toString();

                    break;
                }
                else if (i == 4) {
                    sMail_Send = sSABUN6.toString();

                    break;
                }
                else if (i == 5) {
                    sMail_Send = sSABUN1.toString();

                    break;
                }
            }

            return sMail_Send;
        }


        // 결재선지정 버튼 이벤트
        function btnSOApproval_Click() {
            var param;

            param = "";

            param += "../POP/SabunMultiChkPopup7.aspx?callback=fn_PopupCallBack&Data_Cnt1=6";

            param += "&param1=" + txtPECSABUN1.GetValue();
            param += "&param2=" + txtPECSABUN2.GetValue();
            param += "&param3=" + txtPECSABUN3.GetValue();
            param += "&param4=" + txtPECSABUN4.GetValue();
            param += "&param5=" + txtPECSABUN5.GetValue();
            param += "&param6=" + txtPECSABUN6.GetValue();
            param += "&param7=" + fshdnApproval;

            param += "&param11=" + txtPECNAME1.GetValue();
            param += "&param12=" + txtPECNAME2.GetValue();
            param += "&param13=" + txtPECNAME3.GetValue();
            param += "&param14=" + txtPECNAME4.GetValue();
            param += "&param15=" + txtPECNAME5.GetValue();
            param += "&param16=" + txtPECNAME6.GetValue();

            param += "&param21=" + txtPECJKCD1.GetValue();
            param += "&param22=" + txtPECJKCD2.GetValue();
            param += "&param23=" + txtPECJKCD3.GetValue();
            param += "&param24=" + txtPECJKCD4.GetValue();
            param += "&param25=" + txtPECJKCD5.GetValue();
            param += "&param26=" + txtPECJKCD6.GetValue();

            param += "&param31=" + txtPECJKCDNM1.GetValue();
            param += "&param32=" + txtPECJKCDNM2.GetValue();
            param += "&param33=" + txtPECJKCDNM3.GetValue();
            param += "&param34=" + txtPECJKCDNM4.GetValue();
            param += "&param35=" + txtPECJKCDNM5.GetValue();
            param += "&param36=" + txtPECJKCDNM6.GetValue();

            param += "&SOSign=" + fshdnSign;

            fn_OpenPop(param, 600, 400);
        }

        function fn_PopupCallBack(items1) {

            var sabun = "";
            var name = "";

            // 결재요청
            // 필드 클리어
            fn_Field_clear(1);

            if (items1.length > 0) {

                txtPECSABUN1.SetValue(items1[0].data.KBSABUN);
                txtPECJKCD1.SetValue(items1[0].data.JKCODE);
                txtPECJKCDNM1.SetValue(items1[0].data.CDDESC1);
                txtPECNAME1.SetValue(items1[0].data.KBHANGL);
            }

            if (items1.length > 1) {

                if (txtPECSABUN1.GetValue() == items1[1].data.KBSABUN) {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재승인자를 확인하세요." Literal="true"></Ctl:Text>');
                    Ext.MessageBox.alert('알림', "결재승인자를 확인하세요.");
                    return;
                }

                txtPECSABUN2.SetValue(items1[1].data.KBSABUN);
                txtPECJKCD2.SetValue(items1[1].data.JKCODE);
                txtPECJKCDNM2.SetValue(items1[1].data.CDDESC1);
                txtPECNAME2.SetValue(items1[1].data.KBHANGL);
            }

            if (items1.length > 2) {

                if (txtPECSABUN1.GetValue() == items1[2].data.KBSABUN) {
                    Ext.MessageBox.alert('알림', "결재승인자를 확인하세요.");
                    return;
                }

                txtPECSABUN3.SetValue(items1[2].data.KBSABUN);
                txtPECJKCD3.SetValue(items1[2].data.JKCODE);
                txtPECJKCDNM3.SetValue(items1[2].data.CDDESC1);
                txtPECNAME3.SetValue(items1[2].data.KBHANGL);
            }

            if (items1.length > 3) {

                if (txtPECSABUN1.GetValue() == items1[3].data.KBSABUN) {
                    Ext.MessageBox.alert('알림', "결재승인자를 확인하세요.");
                    return;
                }

                txtPECSABUN4.SetValue(items1[3].data.KBSABUN);
                txtPECJKCD4.SetValue(items1[3].data.JKCODE);
                txtPECJKCDNM4.SetValue(items1[3].data.CDDESC1);
                txtPECNAME4.SetValue(items1[3].data.KBHANGL);
            }

            if (items1.length > 4) {

                if (txtPECSABUN1.GetValue() == items1[4].data.KBSABUN) {
                    Ext.MessageBox.alert('알림', "결재승인자를 확인하세요.");
                    return;
                }

                txtPECSABUN5.SetValue(items1[4].data.KBSABUN);
                txtPECJKCD5.SetValue(items1[4].data.JKCODE);
                txtPECJKCDNM5.SetValue(items1[4].data.CDDESC1);
                txtPECNAME5.SetValue(items1[4].data.KBHANGL);
            }

            if (items1.length > 5) {

                if (txtPECSABUN1.GetValue() == items1[5].data.KBSABUN) {
                    Ext.MessageBox.alert('알림', "결재승인자를 확인하세요.");
                    return;
                }

                txtPECSABUN6.SetValue(items1[5].data.KBSABUN);
                txtPECJKCD6.SetValue(items1[5].data.JKCODE);
                txtPECJKCDNM6.SetValue(items1[5].data.CDDESC1);
                txtPECNAME6.SetValue(items1[5].data.KBHANGL);
            }

            // 결재선 지정 후 결재버튼 보이게 함.
            //if (items1.length > 0 ) {
            //    // 반려버튼
            //    btnCancel.Hide();

            //    // 결재버튼
            //    btnApproval.Show();
            //}
        }

        function fn_Field_clear(gubun) {

            if (gubun == '1') {
                txtPECSABUN2.SetValue('');
                txtPECJKCD2.SetValue('');
                txtPECJKCDNM2.SetValue('');
                txtPECNAME2.SetValue('');

                txtPECSABUN3.SetValue('');
                txtPECJKCD3.SetValue('');
                txtPECJKCDNM3.SetValue('');
                txtPECNAME3.SetValue('');

                txtPECSABUN4.SetValue('');
                txtPECJKCD4.SetValue('');
                txtPECJKCDNM4.SetValue('');
                txtPECNAME4.SetValue('');

                txtPECSABUN5.SetValue('');
                txtPECJKCD5.SetValue('');
                txtPECJKCDNM5.SetValue('');
                txtPECNAME5.SetValue('');

                txtPECSABUN6.SetValue('');
                txtPECJKCD6.SetValue('');
                txtPECJKCDNM6.SetValue('');
                txtPECNAME6.SetValue('');
            }
        }

        // 결재 버튼 이벤트
        function btnApproval_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            // 결재 전 보고서 번호 다시 조회
            ht["P_PECTEAM"] = txtPECTEAM.GetValue();
            ht["P_PECDATE"] = txtPECDATE.GetValue();
            ht["P_PECSEQ"] = txtPECSEQ.GetValue();
            ht["P_PECWOTEAM"] = txtPECWOTEAM.GetValue();
            ht["P_PECWODATE"] = txtPECWODATE.GetValue().split("-").join("");
            ht["P_PECWOSEQ"] = txtPECWOSEQ.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_EXAM_CHECK_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    // 보고서번호
                    txtPECRDATE.SetValue(DataSet.Tables[0].Rows[0]["PECRDATE"]);
                    if (DataSet.Tables[0].Rows[0]["PECRDATE"] != "") {
                        txtPECRSEQ.SetValue(DataSet.Tables[0].Rows[0]["PECRSEQ"]);
                        //$("#btnREPORT").attr("style", "display:;cursor:pointer;height: 25px;width: 25px;");
                    }
                    else {
                        txtPECRSEQ.SetValue("");
                        //$("#btnREPORT").attr("style", "display:none");
                    }

                    PECRDATE = DataSet.Tables[0].Rows[0]["PECRDATE"];
                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });

            var i_COUNT = 0;

            if (txtPECSABUN6.GetValue() != "") {
                i_COUNT = 6;
            }
            else if (txtPECSABUN5.GetValue() != "") {
                i_COUNT = 5;
            }
            else if (txtPECSABUN4.GetValue() != "") {
                i_COUNT = 4;
            }
            else if (txtPECSABUN3.GetValue() != "") {
                i_COUNT = 3;
            }
            else if (txtPECSABUN2.GetValue() != "") {
                i_COUNT = 2;
            }
            else if (txtPECSABUN1.GetValue() != "") {
                i_COUNT = 1;
            }

            if (i_COUNT != parseInt(Get_Numeric(fshdnApproval))) {

                _id = "APPROVAL";

                // 결재 창
                fn_OpenPop("PSM4012.aspx?param=APPROVAL", 385, 180);
            }
            else {

                // 최종결재
                
                sFinish = "FINISH";
                _id = "APPROVAL";

                // 결재 창
                fn_OpenPop("PSM4012.aspx?param=APPROVAL", 385, 180);
            }
        }

        // 결재 철회 이벤트
        function btnRETRACT_Click() {

            _id = "RETRACT";

            // 결재 창
            fn_OpenPop("PSM4012.aspx?param=RETRACT", 385, 180);
        }

        // 철회 함수
        function fn_RETRACT_Proc() {

            var sPGURL = "";
            var sAPNUM = "";
            var sPECNUM = "";

            sAPNUM = txtPECWOTEAM.GetValue() + "-" + txtPECWODATE.GetValue().split("-").join("") + "-" + Set_Fill3(txtPECWOSEQ.GetValue());
            sPECNUM = txtPECTEAM.GetValue() + "-" + txtPECDATE.GetValue() + "-" + Set_Fill3(txtPECSEQ.GetValue());

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            sPGURL = "/Portal/PSM/PSM40/PSM4073.aspx?";
            sPGURL = sPGURL + "param=UPT&param1=";
            sPGURL = sPGURL + sAPNUM + "^" + sPECNUM;

            ht["P_APNUM"] = sAPNUM.toString();
            ht["P_PECNUM"] = sPECNUM.toString();
            ht["P_PECWOTEAM"] = txtPECWOTEAM.GetValue();
            ht["P_PECWODATE"] = txtPECWODATE.GetValue().split("-").join("");
            ht["P_PECWOSEQ"] = Set_Fill3(txtPECWOSEQ.GetValue());
            ht["P_PECTEAM"] = txtPECTEAM.GetValue();
            ht["P_PECDATE"] = txtPECDATE.GetValue();
            ht["P_PECSEQ"] = Set_Fill3(txtPECSEQ.GetValue());
            ht["P_SENDER"] = txtPECSABUN1.GetValue();
            ht["P_RECEIVER"] = txtPECSABUN1.GetValue();
            ht["P_PGURL"] = sPGURL.toString();
            ht["P_PECTITLE"] = txtPECTITLE.GetValue();
            ht["P_RTCOMMENT"] = fsRETRACTCOMMENT;

            // 작업요청서 철회
            PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_EXAM_CHECK_RETRACT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        fn_Btn_Visible('3');

                        fn_GET_Display();

                        fn_GET_Site();

                        fn_ReadOnly();

                        // 공백이미지
                        fn_BLANK_IMAGE();

                        // 현재 요청결재순번
                        fshdnApproval = "0";

                        doDisplay();

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재가 철회 되었습니다." Literal="true"></Ctl:Text>');
                    }
                }
            }, function (e) {
            });

        }

        // 반려 버튼 이벤트
        function btnCancel_Click() {

            _id = "CANCEL";

            // 결재 창
            fn_OpenPop("PSM4012.aspx?param=CANCEL", 385, 180);
        }

        // 취소 함수
        function fn_CANCEL_Proc() {

            var gubun = "";
            var PECSABUN1 = "";
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_PECTEAM"] = txtPECTEAM.GetValue();
            ht["P_PECDATE"] = txtPECDATE.GetValue().split("-").join("");
            ht["P_PECSEQ"] = Set_Fill3(txtPECSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_EXAM_CHECK_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    PECSABUN1 = DataSet.Tables[0].Rows[0]["PECSABUN1"].toString();

                    // 작업요청서 취소
                    PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_EXAM_CHECK_CANCEL", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                            if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                                // 메일 발송
                                fn_Mail_Send(txtPECWOTEAM.GetValue(), txtPECWODATE.GetValue().split("-").join(""), Set_Fill3(txtPECWOSEQ.GetValue()), txtPECTEAM.GetValue(), txtPECDATE.GetValue().split("-").join(""), Set_Fill3(txtPECSEQ.GetValue()), fsRETRACTCOMMENT, PECSABUN1.toString(), "CANCEL", "");

                                //fn_GET_Display();

                                //fn_GET_Site();

                                // 현재 요청결재순번
                                //fshdnApproval = "0";

                                // 공백 이미지
                                //fn_BLANK_IMAGE();

                                //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="가동전 점검 취소 처리가 되었습니다." Literal="true"></Ctl:Text>');

                                //fn_Btn_Visible('3');
                            }
                            else {
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="가동전 점검 취소 처리중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                doDisplay();
                            }
                        }


                    }, function (e) {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="가동전 점검 취소 처리중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        doDisplay();
                    });
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="가동전 점검 취소 처리중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                doDisplay();
            });

        }

        // 저장 버튼 이벤트
        function btnSave_Click() {         

            doDisplay();

            fn_Screen_Save("SAVE", "");

            //setTimeout("doDisplay()", '3000');
        }

        function fn_Screen_Save(sGubun, sFinish) {

            var DetailRows = gridDetail.GetAllRow();
            var InspectRows = gridInspect.GetAllRow();
            var dr;
            var WKGUBUN = "";
            var i_COUNT = 0;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            var hts = new Array();

            if (txtPECTITLE.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="제목을 입력하세요." Literal="true"></Ctl:Text>');
                doDisplay();
                return false;
            }
            if (txtPECINSDATE.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="점검일자를 입력하세요." Literal="true"></Ctl:Text>');
                doDisplay();
                return false;
            }
            if (cboPECSGUBUN.GetValue() == "" || txtPECSDATE.GetValue() == "" || txtPECSSEQ.GetValue() == "") {
                alert('<Ctl:Text runat="server" Description="점검표를 선택하세요." Literal="true"></Ctl:Text>');
                doDisplay();
                return false;
            }
            if (InspectRows == null) {
                alert('<Ctl:Text runat="server" Description="점검자를 입력하세요." Literal="true"></Ctl:Text>');
                doDisplay();
                return false;
            }else if (ObjectCount(InspectRows.Rows) == 0) {
                alert('<Ctl:Text runat="server" Description="점검자를 입력하세요." Literal="true"></Ctl:Text>');
                doDisplay();
                return false;
            }
            if (sGubun == "APPROVAL") {

                if (txtPECRSEQ.GetValue() == "") {
                    alert('<Ctl:Text runat="server" Description="보고서가 작성되지 않았습니다." Literal="true"></Ctl:Text>');
                    doDisplay();
                    return false;
                }

                // 점검 항목 체크여부 확인
                if (DetailRows == null) {
                    alert('<Ctl:Text runat="server" Description="점검항목이 존재하지 않습니다." Literal="true"></Ctl:Text>');
                    doDisplay();
                    return false;
                }
                else {
                    for (x = 0; x < ObjectCount(DetailRows.Rows); x++) {

                        dr = DetailRows.Rows[x];

                        if (dr['PECDCHECK_G'] == "□" && dr['PECDCHECK_F'] == "□" && dr['PECDCHECK_N'] == "□") {

                            alert('<Ctl:Text runat="server" Description="점검하지 않은 항목이 있습니다." Literal="true"></Ctl:Text>');
                            doDisplay();
                            return false;
                        }
                    }
                }

                // 점검자 점검여부 확인
                if (InspectRows == null) {
                    alert('<Ctl:Text runat="server" Description="점검자가 존재하지 않습니다." Literal="true"></Ctl:Text>');
                    doDisplay();
                    return false;
                }
                else {
                    for (x = 0; x < ObjectCount(InspectRows.Rows); x++) {

                        dr = InspectRows.Rows[x];

                        if (dr['PEICHKDATE'] == "") {
                            alert('<Ctl:Text runat="server" Description="점검하지 않은 점검자가 있습니다." Literal="true"></Ctl:Text>');
                            doDisplay();
                            return false;
                        }
                    }
                }
            }

            if (txtPECSABUN6.GetValue().toString() != "") {
                i_COUNT = 6;
            }
            else if (txtPECSABUN5.GetValue().toString() != "") {
                i_COUNT = 5;
            }
            else if (txtPECSABUN4.GetValue().toString() != "") {
                i_COUNT = 4;
            }
            else if (txtPECSABUN3.GetValue().toString() != "") {
                i_COUNT = 3;
            }
            else if (txtPECSABUN2.GetValue().toString() != "") {
                i_COUNT = 2;
            }
            else if (txtPECSABUN1.GetValue().toString() != "") {
                i_COUNT = 1;
            }

            ht["P_PECTEAM"] = txtPECTEAM.GetValue();
            ht["P_PECDATE"] = txtPECDATE.GetValue();
            ht["P_PECSEQ"] = txtPECSEQ.GetValue();

            ht["P_PECWOTEAM"] = txtPECWOTEAM.GetValue();
            ht["P_PECWODATE"] = txtPECWODATE.GetValue().split("-").join("");
            ht["P_PECWOSEQ"] = txtPECWOSEQ.GetValue();

            ht["P_PECTITLE"] = txtPECTITLE.GetValue();
            ht["P_PECINSDATE"] = txtPECINSDATE.GetValue();

            ht["P_PECSGUBUN"] = cboPECSGUBUN.GetValue();
            ht["P_PECSDATE"] = txtPECSDATE.GetValue().split("-").join("");
            ht["P_PECSSEQ"] = txtPECSSEQ.GetValue();

            ht["P_PECTANKNO"] = "";
            ht["P_PECFAULTNM"] = "";
            ht["P_PECIMPROVE"] = "";

            ht["P_PECJKCD1"] = txtPECJKCD1.GetValue();
            ht["P_PECJKCDNM1"] = txtPECJKCDNM1.GetValue();
            ht["P_PECNAME1"] = txtPECNAME1.GetValue();
            ht["P_PECSABUN1"] = txtPECSABUN1.GetValue();
            ht["P_PECCOMMENT1"] = txtPECCOMMENT1.GetValue();

            ht["P_PECJKCD2"] = txtPECJKCD2.GetValue();
            ht["P_PECJKCDNM2"] = txtPECJKCDNM2.GetValue();
            ht["P_PECNAME2"] = txtPECNAME2.GetValue();
            ht["P_PECSABUN2"] = txtPECSABUN2.GetValue();
            ht["P_PECCOMMENT2"] = txtPECCOMMENT2.GetValue();

            ht["P_PECJKCD3"] = txtPECJKCD3.GetValue();
            ht["P_PECJKCDNM3"] = txtPECJKCDNM3.GetValue();
            ht["P_PECNAME3"] = txtPECNAME3.GetValue();
            ht["P_PECSABUN3"] = txtPECSABUN3.GetValue();
            ht["P_PECCOMMENT3"] = txtPECCOMMENT3.GetValue();

            ht["P_PECJKCD4"] = txtPECJKCD4.GetValue();
            ht["P_PECJKCDNM4"] = txtPECJKCDNM4.GetValue();
            ht["P_PECNAME4"] = txtPECNAME4.GetValue();
            ht["P_PECSABUN4"] = txtPECSABUN4.GetValue();
            ht["P_PECCOMMENT4"] = txtPECCOMMENT4.GetValue();

            ht["P_PECJKCD5"] = txtPECJKCD5.GetValue();
            ht["P_PECJKCDNM5"] = txtPECJKCDNM5.GetValue();
            ht["P_PECNAME5"] = txtPECNAME5.GetValue();
            ht["P_PECSABUN5"] = txtPECSABUN5.GetValue();
            ht["P_PECCOMMENT5"] = txtPECCOMMENT5.GetValue();

            ht["P_PECJKCD6"] = txtPECJKCD6.GetValue();
            ht["P_PECJKCDNM6"] = txtPECJKCDNM6.GetValue();
            ht["P_PECNAME6"] = txtPECNAME6.GetValue();
            ht["P_PECSABUN6"] = txtPECSABUN6.GetValue();
            ht["P_PECCOMMENT6"] = txtPECCOMMENT6.GetValue();

            ht["P_COUNT"] = i_COUNT;
            ht["P_APPROVAL"] = Get_Numeric(fshdnApproval);
            ht["P_GUBUN"] = sGubun;

            ht["P_WOSTATUS"] = "3";  // 가동전 점검 결재
            ht["P_WOORTEAM"] = txtPECWOTEAM.GetValue();
            ht["P_WOORDATE"] = txtPECWODATE.GetValue().split("-").join("");
            ht["P_WOSEQ"] = txtPECWOSEQ.GetValue();
            

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_EXAM_CHECK_ADD", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        txtPECSEQ.SetValue(Set_Fill3(DataSet.Tables[0].Rows[0]["MSG"]));

                        // 점검표 저장
                        if (ObjectCount(DetailRows.Rows) > 0) {

                            for (i = 0; i < ObjectCount(DetailRows.Rows); i++) {
                                ht = new Object();
                                var PECDCHECK = "";
                                dr = DetailRows.Rows[i];

                                ht["P_PECDTCTEAM"] = txtPECTEAM.GetValue();
                                ht["P_PECDTCDATE"] = txtPECDATE.GetValue();
                                ht["P_PECDTCSEQ"] = txtPECSEQ.GetValue();

                                ht["P_PECDGUBUN"] = cboPECSGUBUN.GetValue();
                                ht["P_PECDDATE"] = txtPECSDATE.GetValue().split("-").join("");
                                ht["P_PECDSEQ"] = txtPECSSEQ.GetValue();

                                ht["P_PECDNUM"] = dr['PECDNUM'];
                                ht["P_PECDDESC"] = dr['PECDDESC'];

                                if (dr['PECDCHECK_G'] == "▣") {
                                    PECDCHECK = "G";
                                }
                                else if (dr['PECDCHECK_F'] == "▣") {
                                    PECDCHECK = "F";
                                }
                                else if (dr['PECDCHECK_N'] == "▣") {
                                    PECDCHECK = "N";
                                }

                                ht["P_PECDCHECK"] = PECDCHECK;
                                ht["P_GUBUN"] = "A";

                                hts.push(ht);
                            }

                            PageMethods.InvokeServiceTableArray(ht, hts, "PSM.PSM4070", "UP_EXAM_CHECK_DETAIL_ADD", function (e) {

                                DataSet = eval(e);

                                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                                        if (ObjectCount(InspectRows.Rows) > 0) {

                                            hts = new Array();

                                            if (document.getElementById('btnRowAdd').style.display == "") {
                                                for (j = 0; j < ObjectCount(InspectRows.Rows); j++) {

                                                    ht = new Object();
                                                    dr = InspectRows.Rows[j];

                                                    ht["P_PEICTEAM"] = txtPECTEAM.GetValue();
                                                    ht["P_PEICDATE"] = txtPECDATE.GetValue();
                                                    ht["P_PEICSEQ"] = txtPECSEQ.GetValue();

                                                    ht["P_PEINUM"] = j + 1;
                                                    ht["P_PEISABUN"] = dr['PEISABUN'];
                                                    ht["P_PEICHKDATE"] = dr['PEICHKDATE'].split("-").join("");
                                                    ht["P_GUBUN"] = "A";

                                                    hts.push(ht);
                                                }
                                            }

                                            PageMethods.InvokeServiceTableArray(ht, hts, "PSM.PSM4070", "UP_EXAM_INSPECT_ADD", function (e) {

                                                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                                                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                                                        fshdnExists = "EXISTS";

                                                        if (sGubun.toString() == "APPROVAL") {

                                                            // 메일수신자 가져오기
                                                            sKBSABUN = fn_GET_Mail_Sabun(i_COUNT, fshdnApproval,
                                                                txtPECSABUN1.GetValue(), txtPECSABUN2.GetValue(), txtPECSABUN3.GetValue(),
                                                                txtPECSABUN4.GetValue(), txtPECSABUN5.GetValue(), txtPECSABUN6.GetValue());

                                                            // 결재 사인 DISPLAY
                                                            fn_APPROVAL_Display(txtPECWOTEAM.GetValue(), txtPECWODATE.GetValue().split("-").join(""), txtPECWOSEQ.GetValue(),
                                                                                txtPECTEAM.GetValue(), txtPECDATE.GetValue(), txtPECSEQ.GetValue(), "", sKBSABUN.toString(), "OK", sFinish);

                                                            //fn_ReadOnly();
                                                            //fn_Btn_Visible('3');

                                                            //alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');
                                                        }
                                                        else {

                                                            fn_Field_ReadOnly(false, false, true);

                                                            if (txtPECSEQ.GetValue() != "") {
                                                                
                                                                btnApproval.Show();
                                                                btnDel.Show();
                                                                $("#btnREPORT").attr("style", "display:;cursor:pointer;height: 25px;width: 25px;");

                                                                dr = InspectRows.Rows[0];

                                                                if (dr['PEICHKDATE'].split("-").join("") == "") {
                                                                    btnMail.Show();
                                                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 처리 되었습니다. 점검자에게 메일을 발송하세요." Literal="true"></Ctl:Text>');
                                                                }
                                                                else {
                                                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 처리 되었습니다." Literal="true"></Ctl:Text>');
                                                                }
                                                                doDisplay();
                                                            }
                                                        }
                                                    }
                                                    else {
                                                        alert('<Ctl:Text runat="server" Description="처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                                        doDisplay();
                                                    }
                                                }
                                                else {
                                                    alert('<Ctl:Text runat="server" Description="처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                                    doDisplay();
                                                }

                                            }, function (e) {
                                                // Biz 연결오류
                                                alert('<Ctl:Text runat="server" Description="처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                                doDisplay();
                                            });
                                        }
                                    }
                                    else {
                                        alert('<Ctl:Text runat="server" Description="처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                        doDisplay();
                                    }
                                }
                                else {
                                    alert('<Ctl:Text runat="server" Description="처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                    doDisplay();
                                }

                            }, function (e) {
                                // Biz 연결오류
                                alert('<Ctl:Text runat="server" Description="처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                doDisplay();
                            });
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" Description="처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        doDisplay();
                    }
                }
                else {
                    alert('<Ctl:Text runat="server" Description="처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    doDisplay();
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" Description="처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                doDisplay();
            });
        }

        // 점검자 저장 버튼 이벤트
        function btnDetailSave_Click() {

            // 로그인 사번과 점검자 사번이 동일한 항목에 대해서만 점검일자를 입력하도록 해야함.
            
            var DetailRows = gridDetail.GetAllRow();
            var InspectRows = gridInspect.GetCheckRow();
            var InspectAllRows = gridInspect.GetAllRow();
            var dr;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            var hts = new Array();

            var PEICHKDATE = "";
            var LastInspect = true;

            // 마지막 점검자인 경우 점검항목 체크
            for (i = 0; i < ObjectCount(InspectAllRows.Rows); i++) {
                dr = InspectAllRows.Rows[i];

                if (fshdnLoginSabun != dr['PEISABUN'] && dr['PEICHKDATE'] == "") {
                    var LastInspect = false;
                }
            }
            if (LastInspect == true) {


                for (x = 0; x < ObjectCount(DetailRows.Rows); x++) {

                    dr = DetailRows.Rows[x];

                    if (dr['PECDCHECK_G'] == "□" && dr['PECDCHECK_F'] == "□" && dr['PECDCHECK_N'] == "□") {

                        alert('<Ctl:Text runat="server" Description="점검하지 않은 항목이 있습니다." Literal="true"></Ctl:Text>');
                        return false;
                    }
                }
            }

            // 점검표 저장
            if (ObjectCount(DetailRows.Rows) > 0) {

                for (i = 0; i < ObjectCount(DetailRows.Rows); i++) {
                    ht = new Object();
                    var PECDCHECK = "";
                    dr = DetailRows.Rows[i];

                    ht["P_PECDTCTEAM"] = txtPECTEAM.GetValue();
                    ht["P_PECDTCDATE"] = txtPECDATE.GetValue();
                    ht["P_PECDTCSEQ"] = txtPECSEQ.GetValue();

                    ht["P_PECDGUBUN"] = cboPECSGUBUN.GetValue();
                    ht["P_PECDDATE"] = txtPECSDATE.GetValue().split("-").join("");
                    ht["P_PECDSEQ"] = txtPECSSEQ.GetValue();

                    ht["P_PECDNUM"] = dr['PECDNUM'];
                    ht["P_PECDDESC"] = dr['PECDDESC'];

                    if (dr['PECDCHECK_G'] == "▣") {
                        PECDCHECK = "G";
                    }
                    else if (dr['PECDCHECK_F'] == "▣") {
                        PECDCHECK = "F";
                    }
                    else if (dr['PECDCHECK_N'] == "▣") {
                        PECDCHECK = "N";
                    }

                    ht["P_PECDCHECK"] = PECDCHECK;
                    ht["P_GUBUN"] = "C";

                    hts.push(ht);
                }

                PageMethods.InvokeServiceTableArray(ht, hts, "PSM.PSM4070", "UP_EXAM_CHECK_DETAIL_ADD", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            if (InspectRows.length > 0) {

                                hts = new Array();

                                for (j = 0; j < InspectRows.length; j++) {

                                    ht = new Object();
                                    dr = InspectRows[j];

                                    ht["P_PEICTEAM"] = txtPECTEAM.GetValue();
                                    ht["P_PEICDATE"] = txtPECDATE.GetValue();
                                    ht["P_PEICSEQ"] = txtPECSEQ.GetValue();

                                    ht["P_PEINUM"] = dr['PEINUM'];
                                    ht["P_PEISABUN"] = dr['PEISABUN'];
                                    ht["P_PEICHKDATE"] = dr['PEICHKDATE'].split("-").join("");
                                    ht["P_GUBUN"] = "C";

                                    PEICHKDATE = dr['PEICHKDATE'].split("-").join("");

                                    hts.push(ht);
                                }

                                PageMethods.InvokeServiceTableArray(ht, hts, "PSM.PSM4070", "UP_EXAM_INSPECT_ADD", function (e) {

                                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                                            if (PEICHKDATE != "") {
                                                fn_Inspect_Mail_Send();
                                            }
                                            fn_GET_Display();
                                            btnDel.Show();

                                            if (LastInspect == true && txtPECRSEQ.GetValue() == "") {
                                                alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다. 보고서를 작성하세요." Literal="true"></Ctl:Text>');
                                            }
                                            else {
                                                alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
                                            }
                                        }
                                        else {
                                            alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
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
                            else {
                                alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
                            }
                        }
                        else {
                            alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
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

        function fn_Inspect_Mail_Send() {
            var sTitle = "";

            var sPGURL = "";
            var sWOWORKDOC = "";
            var sAPNUM = "";

            var gridRows = gridInspect.GetAllRow();

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            if (ObjectCount(gridRows.Rows) > 0) {

                // 점검표 저장여부 체크(점검 순번체크)
                if (txtPECSEQ.GetValue() == "" || txtPECSEQ.GetValue() == null) {
                    alert('<Ctl:Text runat="server" Description="저장 후 작업하세요." Literal="true"></Ctl:Text>');
                    return false;
                }

                ht["P_PECTEAM"] = txtPECTEAM.GetValue();
                ht["P_PECDATE"] = txtPECDATE.GetValue();
                ht["P_PECSEQ"] = txtPECSEQ.GetValue();

                ht["P_PECWOTEAM"] = txtPECWOTEAM.GetValue();
                ht["P_PECWODATE"] = txtPECWODATE.GetValue().split("-").join("");
                ht["P_PECWOSEQ"] = txtPECWOSEQ.GetValue();

                ht["P_PECTITLE"] = txtPECTITLE.GetValue();

                ht["P_SENDER"] = txtPECSABUN1.GetValue();

                // 메일 발송
                PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_Mail_Inspect_Send", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        if (DataSet.Tables[0].Rows[0]["STATE"].toString() == "OK") {


                        }
                        else {

                            alert('<Ctl:Text runat="server" Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        }
                    }

                }, function (e) {
                    alert('<Ctl:Text runat="server" Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');

                });
            }
            else {
                alert('<Ctl:Text runat="server" Description="점검자를 입력하세요." Literal="true"></Ctl:Text>');
            }
        }

        // 해당없음 일괄처리 버튼 이벤트
        function btnCheckAll_Click() {

            var DetailRows = gridDetail.GetAllRow();
            var dr;

            // 점검 항목 체크여부 확인
            for (i = 0; i < ObjectCount(DetailRows.Rows); i++) {

                dr = DetailRows.Rows[i];

                if (dr['PECDCHECK_N'] == "□") {

                    gridDetail.SetValue(i, "PECDCHECK_G", "□");
                    gridDetail.SetValue(i, "PECDCHECK_F", "□");
                    gridDetail.SetValue(i, "PECDCHECK_N", "▣");
                }
            }
        }

        // 삭제 버튼 이벤트
        function btnDel_Click() {

            doDisplay();

            // 보고서 번호 체크
            if (txtPECRSEQ.GetValue() != "") {

                alert('<Ctl:Text runat="server" Description="가동전 안전점검 보고서 자료가 존재하므로 삭제가 불가합니다." Literal="true"></Ctl:Text>');
                //setTimeout("doDisplay()", '1000');
                doDisplay();
                return;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

            ht["P_PECTEAM"] = txtPECTEAM.GetValue();
            ht["P_PECDATE"] = txtPECDATE.GetValue();
            ht["P_PECSEQ"] = txtPECSEQ.GetValue();

            ht["P_PECDGUBUN"] = cboPECSGUBUN.GetValue();
            ht["P_PECDDATE"] = txtPECSDATE.GetValue().split("-").join("");
            ht["P_PECDSEQ"] = txtPECSSEQ.GetValue();


            if (confirm('<Ctl:Text runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_EXAM_CHECK_DEL", function (e) {
        
                    alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                    if (opener != null && typeof (opener.board_popup_callback) == "function") {
                        opener.board_popup_callback(txtPECWOTEAM.GetValue(), txtPECWODATE.GetValue().split("-").join(""), txtPECWOSEQ.GetValue());
                    }

                    btnClose_Click();

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    doDisplay();
                });
            }

            //setTimeout("doDisplay()", '3000');
        }

        // 출력 버튼 이벤트
        function btnPrt_Click() {

            fn_OpenPop("../../Common/ReportView.aspx?RPT=PSM4073_RPT&PECTEAM=" + txtPECTEAM.GetValue() + "&PECDATE=" + txtPECDATE.GetValue().split("-").join("") +
                "&PECSEQ=" + txtPECSEQ.GetValue(), 1000, 600);
        }

        // 닫기 버튼 이벤트
        function btnClose_Click() {

            
            this.close();            
        }

        // 코드헬프
        function btnPopup_Click(gubn) {

            if (gubn == "1") {
                _id = "CODEHELP";
                fn_OpenPopCustom("PSM4071.aspx?param=CHK&param2=1", 1400, 800, "Excon");
            }
            else {

                var param = txtPECTEAM.GetValue() + "^" + txtPECDATE.GetValue().split("-").join("") + "^" + txtPECSEQ.GetValue() + "^" + txtPECRDATE.GetValue().split("-").join("") + "^" + txtPECRSEQ.GetValue() + "^" + txtPECTEAMNM.GetValue();

                fn_OpenPopCustom("PSM4081.aspx?param=" + param + "&param1=", 1000, 800, param);
            }
        }

        function btnReport_Callback() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            // 결재 전 보고서 번호 다시 조회
            ht["P_PECTEAM"] = txtPECTEAM.GetValue();
            ht["P_PECDATE"] = txtPECDATE.GetValue();
            ht["P_PECSEQ"] = txtPECSEQ.GetValue();
            ht["P_PECWOTEAM"] = txtPECWOTEAM.GetValue();
            ht["P_PECWODATE"] = txtPECWODATE.GetValue().split("-").join("");
            ht["P_PECWOSEQ"] = txtPECWOSEQ.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_EXAM_CHECK_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    // 보고서번호
                    txtPECRDATE.SetValue(DataSet.Tables[0].Rows[0]["PECRDATE"]);
                    if (DataSet.Tables[0].Rows[0]["PECRDATE"] != "") {
                        txtPECRSEQ.SetValue(DataSet.Tables[0].Rows[0]["PECRSEQ"]);
                    }
                    else {
                        txtPECRSEQ.SetValue("");
                    }

                    PECRDATE = DataSet.Tables[0].Rows[0]["PECRDATE"];
                }
            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        // 결재콜백 함수
        function btnPopup_Callback(ht) {

            var i_COUNT = 0;

            if (txtPECSABUN6.GetValue() != "") {
                i_COUNT = 6;
            }
            else if (txtPECSABUN5.GetValue() != "") {
                i_COUNT = 5;
            }
            else if (txtPECSABUN4.GetValue() != "") {
                i_COUNT = 4;
            }
            else if (txtPECSABUN3.GetValue() != "") {
                i_COUNT = 3;
            }
            else if (txtPECSABUN2.GetValue() != "") {
                i_COUNT = 2;
            }
            else if (txtPECSABUN1.GetValue() != "") {
                i_COUNT = 1;
            }

            fsRETRACTCOMMENT = "";

            // 결재 의견
            if (_id == "APPROVAL") {
                
                fn_COMMENT(ht);

                doDisplay();

                if (i_COUNT == parseInt(Get_Numeric(fshdnApproval)) + 1) {
                    fn_Screen_Save(_id, "FINISH");
                }
                else {
                    fn_Screen_Save(_id, "");
                }

                //setTimeout("doDisplay()", '5000');
            }

            // 철회 의견
            if (_id == "RETRACT") {

                fsRETRACTCOMMENT = ht;

                doDisplay();

                fn_RETRACT_Proc();

                //setTimeout("doDisplay()", '3000');
            }

            // 취소 의견
            if (_id == "CANCEL") {

                fsRETRACTCOMMENT = ht;

                doDisplay();

                fn_CANCEL_Proc();

                //setTimeout("doDisplay()", '3000');
            }

            // 점검표 선택
            if (_id == "CODEHELP") {

                var ht2 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                cboPECSGUBUN.SetValue(ht["PECCGUBUN"]);
                txtPECSDATE.SetValue(ht["PECCDATE"]);
                txtPECSSEQ.SetValue(ht["PECCSEQ"]);

                ht2["P_WKGUBUN"] = "NEW";
                ht2["P_PECCGUBUN"] = ht["PECCGUBUN"];
                ht2["P_PECCDATE"] = ht["PECCDATE"];
                ht2["P_PECCSEQ"] = ht["PECCSEQ"];

                gridDetail.Params(ht2); // 선언한 파라미터를 그리드에 전달함
                gridDetail.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                gridDetail.CallBack = function () {

                    gridDataChange("NEW");
                }
            }
        }

        function fn_COMMENT(COMMENT) {

            var i_COUNT = 0;

            if (txtPECSABUN6.GetValue() != "") {
                i_COUNT = 6;
            }
            else if (txtPECSABUN5.GetValue() != "") {
                i_COUNT = 5;
            }
            else if (txtPECSABUN4.GetValue() != "") {
                i_COUNT = 4;
            }
            else if (txtPECSABUN3.GetValue() != "") {
                i_COUNT = 3;
            }
            else if (txtPECSABUN2.GetValue() != "") {
                i_COUNT = 2;
            }
            else if (txtPECSABUN1.GetValue() != "") {
                i_COUNT = 1;
            }

            if (i_COUNT == parseInt(Get_Numeric(fshdnApproval)) + 1) // 요청 마지막 결재자
            {   
                if (i_COUNT == 1) {
                    txtPECCOMMENT1.SetValue(COMMENT);
                }
                else if (i_COUNT == 2) {
                    txtPECCOMMENT2.SetValue(COMMENT);
                }
                else if (i_COUNT == 3) {
                    txtPECCOMMENT3.SetValue(COMMENT);
                }
                else if (i_COUNT == 4) {
                    txtPECCOMMENT4.SetValue(COMMENT);
                }
                else if (i_COUNT == 5) {
                    txtPECCOMMENT5.SetValue(COMMENT);
                }
                else if (i_COUNT == 6) {
                    txtPECCOMMENT6.SetValue(COMMENT);
                }
            }
            else // 요청 다음 결재자
            {   
                if (i_COUNT != parseInt(Get_Numeric(fshdnApproval))) {
                    if (Get_Numeric(fshdnApproval) == "0") {
                        txtPECCOMMENT1.SetValue(COMMENT);
                    }
                    else if (Get_Numeric(fshdnApproval) == "1") {
                        txtPECCOMMENT2.SetValue(COMMENT);
                    }
                    else if (Get_Numeric(fshdnApproval) == "2") {
                        txtPECCOMMENT3.SetValue(COMMENT);
                    }
                    else if (Get_Numeric(fshdnApproval) == "3") {
                        txtPECCOMMENT4.SetValue(COMMENT);
                    }
                    else if (Get_Numeric(fshdnApproval) == "4") {
                        txtPECCOMMENT5.SetValue(COMMENT);
                    }
                    else if (Get_Numeric(fshdnApproval) == "5") {
                        txtPECCOMMENT6.SetValue(COMMENT);
                    }
                }
            }
        }

        // 체크박스 데이터  변환
        function gridDataChange(gubun) {

            var dt = gridDetail.GetAllRow();

            if (gubun == "NEW") {

                for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                    var dr = dt.Rows[i];

                    if (dr['PECDCHECK_G'] == "Y") {
                        gridDetail.SetValue(i, "PECDCHECK_G", "□");
                    }
                    else {
                        gridDetail.SetValue(i, "PECDCHECK_G", "");
                    }

                    if (dr['PECDCHECK_F'] == "Y") {
                        gridDetail.SetValue(i, "PECDCHECK_F", "□");
                    }
                    else {
                        gridDetail.SetValue(i, "PECDCHECK_F", "");
                    }

                    if (dr['PECDCHECK_N'] == "Y") {
                        gridDetail.SetValue(i, "PECDCHECK_N", "□");
                    }
                    else {
                        gridDetail.SetValue(i, "PECDCHECK_N", "");
                    }

                    var space = "";

                    for (var j = 1; j < dr['PECLEVEL']; j++) {
                        space += "　";
                    }
                    gridDetail.SetValue(i, "PECDDESC", space + dr['PECDDESC']);
                }
            }
            else {
                for (var i = 0; i < ObjectCount(dt.Rows); i++) {

                    var dr = dt.Rows[i];

                    if (dr['PECCCHECK'] == "Y")
                    {
                        if (dr['PECDCHECK_G'] == "Y") {
                            gridDetail.SetValue(i, "PECDCHECK_G", "▣");
                        }
                        else {
                            gridDetail.SetValue(i, "PECDCHECK_G", "□");
                        }

                        if (dr['PECDCHECK_F'] == "Y") {
                            gridDetail.SetValue(i, "PECDCHECK_F", "▣");
                        }
                        else {
                            gridDetail.SetValue(i, "PECDCHECK_F", "□");
                        }

                        if (dr['PECDCHECK_N'] == "Y") {
                            gridDetail.SetValue(i, "PECDCHECK_N", "▣");
                        }
                        else {
                            gridDetail.SetValue(i, "PECDCHECK_N", "□");
                        }
                    }

                    var space = "";

                    for (var j = 1; j < dr['PECLEVEL']; j++) {
                        space += "　";
                    }
                    gridDetail.SetValue(i, "PECDDESC", space + dr['PECDDESC']);
                }
            }
        }

        // 점검자 추가 버튼
        function btnRowAdd_Click() {

            var param;

            var sSABUN = "";
            var sNAME = "";

            var InspectRows = gridInspect.GetAllRow();

            if (InspectRows != null) {

                for (i = 0; i < ObjectCount(InspectRows.Rows); i++) {

                    dr = InspectRows.Rows[i];

                    if (dr['PEISABUN'] != "") { 
                        if (sSABUN == "") {
                            sSABUN = dr['PEISABUN'];
                        }
                        else {
                            sSABUN = sSABUN + "," + dr['PEISABUN'];
                        }
                        if (sNAME == "") {
                            sNAME = dr['KBHANGL'];
                        }
                        else {
                            sNAME = sNAME + "," + dr['KBHANGL'];
                        }
                    }
                }
            }

            param = "";

            param += "../POP/SabunMultiChkPopup8.aspx?callback=fn_InspectCallBack&Data_Cnt1=5&Data_Cnt2=5&GUBUN=WK";

            param += "&SABUN=" + sSABUN;
            param += "&NAME=" + sNAME;

            fn_OpenPop(param, 600, 400);
        }

        function fn_InspectCallBack(items) {

            gridInspect.RemoveAllRow();

            if (items.length > 0) {
                gridInspect.InsertRow();

                for (i = 0; i < items.length; i++) {

                    if (i == 0) {
                        gridInspect.SetValue(ObjectCount(gridInspect.GetAllRow().Rows) - 1, "PEISABUN", items[i].data.KBSABUN);
                        gridInspect.SetValue(ObjectCount(gridInspect.GetAllRow().Rows) - 1, "KBHANGL", items[i].data.KBHANGL);
                    }
                    else {
                        gridInspect.InsertRow();

                        gridInspect.SetValue(ObjectCount(gridInspect.GetAllRow().Rows) - 1, "PEISABUN", items[i].data.KBSABUN);
                        gridInspect.SetValue(ObjectCount(gridInspect.GetAllRow().Rows) - 1, "KBHANGL", items[i].data.KBHANGL);
                    }
                    gridInspect.EditModeDisable(i, 2); // 점검일자(2)
                }
            }
        }

        // 점검자 메일발송 버튼
        function btnMail_Click() {

            var sTitle = "";

            var sPGURL = "";
            var sWOWORKDOC = "";
            var sAPNUM = "";

            var gridRows = gridInspect.GetAllRow();

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            if (ObjectCount(gridRows.Rows) > 0) {

                // 점검표 저장여부 체크(점검 순번체크)
                if (txtPECSEQ.GetValue() == "" || txtPECSEQ.GetValue() == null) {
                    alert('<Ctl:Text runat="server" Description="저장 후 작업하세요." Literal="true"></Ctl:Text>');
                    return false;
                }

                ht["P_PECTEAM"] = txtPECTEAM.GetValue();
                ht["P_PECDATE"] = txtPECDATE.GetValue();
                ht["P_PECSEQ"] = txtPECSEQ.GetValue();

                ht["P_PECWOTEAM"] = txtPECWOTEAM.GetValue();
                ht["P_PECWODATE"] = txtPECWODATE.GetValue().split("-").join("");
                ht["P_PECWOSEQ"] = txtPECWOSEQ.GetValue();

                ht["P_PECTITLE"] = txtPECTITLE.GetValue();

                ht["P_SENDER"] = txtPECSABUN1.GetValue();

                // 메일 발송
                PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_Mail_Inspect_Send", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                        
                        if (DataSet.Tables[0].Rows[0]["STATE"].toString() == "OK") {
                            
                            alert('<Ctl:Text runat="server" Description="메일을 발송 하였습니다." Literal="true"></Ctl:Text>');
                        }
                        else {
                            
                            alert('<Ctl:Text runat="server" Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        }
                    }

                }, function (e) {
                    alert('<Ctl:Text runat="server" Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');

                });
            }
            else {
                alert('<Ctl:Text runat="server" Description="점검자를 입력하세요." Literal="true"></Ctl:Text>');
            }
        }

        function fn_FINISH_UPT() {


            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_WOFINISHDATE"] = $("#txtPECDATE" + fshdnApproval).val().split("-").join("");      // 최종결재일자
            ht["P_WOFINISHTIME"] = $("#txtPECTIME" + fshdnApproval).val().split(":").join("");      // 최종결재시간
            ht["P_WOFINISHSABUN"] = $("#txtPECSABUN" + fshdnApproval).val(); // 최종결재자사번
            ht["P_WOFINISHTEXT"] = "가동전 점검 완료";
            ht["P_WOORTEAM"] = txtPECWOTEAM.GetValue();
            ht["P_WOORDATE"] = txtPECWODATE.GetValue().split("-").join("");
            ht["P_WOSEQ"] = Set_Fill3(txtPECWOSEQ.GetValue());
            ht["P_WOSTATUS"] = "5";  // 가동전 점검 완료

            ht["P_PECTEAM"] = txtPECTEAM.GetValue();
            ht["P_PECDATE"] = txtPECDATE.GetValue().split("-").join("");
            ht["P_PECSEQ"] = txtPECSEQ.GetValue();
            ht["P_PECTITLE"] = txtPECTITLE.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_WORKORDER_FINISH_UPT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        //alert("요청서 업데이트 완료");
                        alert('<Ctl:Text runat="server" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');

                        if (opener != null && typeof (opener.board_popup_callback) == "function") {
                            opener.board_popup_callback(txtPECWOTEAM.GetValue(), txtPECWODATE.GetValue().split("-").join(""), txtPECWOSEQ.GetValue());
                        }

                        btnClose_Click();
                    }
                    else {
                        alert('<Ctl:Text runat="server" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        doDisplay();
                    }
                }
                else {
                    alert('<Ctl:Text runat="server" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    doDisplay();
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" Description="작업 완료 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                doDisplay();
            });
        }

        // 그리드 체크박스 선택 이벤트
        function gridClick(r, c) {

            if (fsCheckLock != "Y") {
                var rw = gridDetail.GetRow(r);

                // 체크여부 컬럼

                if (rw['PECCCHECK'] = "Y") {
                    if (c == 1) {

                        if (rw["PECDCHECK_G"] == "▣") {

                            gridDetail.SetValue(r, "PECDCHECK_G", "□");
                        }
                        else if (rw["PECDCHECK_G"] == "□") {

                            gridDetail.SetValue(r, "PECDCHECK_G", "▣");
                            gridDetail.SetValue(r, "PECDCHECK_F", "□");
                            gridDetail.SetValue(r, "PECDCHECK_N", "□");
                        }
                    }
                    else if (c == 2) {

                        if (rw["PECDCHECK_F"] == "▣") {

                            gridDetail.SetValue(r, "PECDCHECK_F", "□");
                        }
                        else if (rw["PECDCHECK_F"] == "□") {

                            gridDetail.SetValue(r, "PECDCHECK_G", "□");
                            gridDetail.SetValue(r, "PECDCHECK_F", "▣");
                            gridDetail.SetValue(r, "PECDCHECK_N", "□");
                        }
                    }
                    else if (c == 3) {

                        if (rw["PECDCHECK_N"] == "▣") {

                            gridDetail.SetValue(r, "PECDCHECK_N", "□");
                        }
                        else if (rw["PECDCHECK_N"] == "□") {

                            gridDetail.SetValue(r, "PECDCHECK_G", "□");
                            gridDetail.SetValue(r, "PECDCHECK_F", "□");
                            gridDetail.SetValue(r, "PECDCHECK_N", "▣");
                        }
                    }
                }
            }
        }

        // 우측 그리드 삭제버튼 이벤트
        function gridInspectClick(r, c) {

            gridInspect.RemoveRows([r]);
        }

        // 메일 발송
        function fn_Mail_Send(sPECWOTEAM, sPECWODATE, sPECWOSEQ, sPECTEAM, sPECDATE, sPECSEQ, sPECCANCELCOMMENT, sMail_Receiver, sGUBUN, sFinish) {

            var sTitle = "";

            var sPGURL = "";
            var sWOWORKDOC = "";
            var sAPNUM = "";
            var sPECNUM = "";

            var i_COUNT = 0;

            sAPNUM = sPECWOTEAM.toString() + "-" + sPECWODATE.toString() + "-" + Set_Fill3(sPECWOSEQ.toString());
            sPECNUM = sPECTEAM.toString() + "-" + sPECDATE.toString() + "-" + Set_Fill3(sPECSEQ.toString());

            sPGURL = "/Portal/PSM/PSM40/PSM4073.aspx?";
            sPGURL = sPGURL + "param=UPT&param1=";
            sPGURL = sPGURL + sAPNUM + "^" + sPECNUM;
            

            if (sGUBUN == 'OK') {

                if (txtPECSABUN6.GetValue() != "") {
                    i_COUNT = 6;
                }
                else if (txtPECSABUN5.GetValue() != "") {
                    i_COUNT = 5;
                }
                else if (txtPECSABUN4.GetValue() != "") {
                    i_COUNT = 4;
                }
                else if (txtPECSABUN3.GetValue() != "") {
                    i_COUNT = 3;
                }
                else if (txtPECSABUN2.GetValue() != "") {
                    i_COUNT = 2;
                }
                else if (txtPECSABUN1.GetValue() != "") {
                    i_COUNT = 1;
                }

                if (sFinish == "FINISH") {
                    sTitle = txtPECTITLE.GetValue() + " - 가동전 점검 완료";
                }
                else {
                    sTitle = txtPECTITLE.GetValue() + " - 가동전 점검 제출";
                }
            }
            else {
                sTitle = txtPECTITLE.GetValue() + " - 가동전 점검 취소";
            }

            var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht1["P_APNUM"] = sAPNUM.toString();
            ht1["P_PECNUM"] = sPECNUM.toString();
            ht1["P_PECWOTEAM"] = sPECWOTEAM.toString();
            ht1["P_PECWODATE"] = sPECWODATE.toString();
            ht1["P_PECWOSEQ"] = sPECWOSEQ.toString();
            ht1["P_PECTEAM"] = sPECTEAM.toString();
            ht1["P_PECDATE"] = sPECDATE.toString();
            ht1["P_PECSEQ"] = sPECSEQ.toString();
            ht1["P_SENDER"] = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";
            ht1["P_RECEIVER"] = sMail_Receiver.toString();
            ht1["P_PGURL"] = sPGURL.toString();
            ht1["P_TITLE"] = sTitle.toString();
            ht1["P_PECTITLE"] = txtPECTITLE.GetValue();
            ht1["P_PECCANCELCOMMENT"] = sPECCANCELCOMMENT;
            ht1["P_GUBUN"] = sGUBUN.toString();
            ht1["P_FINISH"] = sFinish.toString();

            PageMethods.InvokeServiceTable(ht1, "PSM.PSM4070", "UP_Get_Mail_List", function (e) {

                var DataSet1 = eval(e);

                if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                    if (sGUBUN == "OK") {

                        if (sFinish == "FINISH") {

                            fn_FINISH_UPT();
                        }
                        else {
                            alert('<Ctl:Text runat="server" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');

                            if (opener != null && typeof (opener.board_popup_callback) == "function") {
                                opener.board_popup_callback(txtPECWOTEAM.GetValue(), txtPECWODATE.GetValue().split("-").join(""), txtPECWOSEQ.GetValue());
                            }

                            btnClose_Click();
                        }
                    }
                    else if (sGUBUN == 'CANCEL') {
                        alert('<Ctl:Text runat="server" Description="가동전 점검 취소 처리가 되었습니다." Literal="true"></Ctl:Text>');

                        this.close();
                    }
                } else {
                    alert('<Ctl:Text runat="server"  Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    doDisplay();
                }

            }, function (e) {
                alert('<Ctl:Text runat="server"  Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                doDisplay();
            });

        }
        

        function fn_APPROVAL_Display(sPECWOTEAM, sPECWODATE, sPECWOSEQ, sPECTEAM, sPECDATE, sPECSEQ, sPECCANCELCOMMENT, sMail_Receiver, sGUBUN, sFinish) {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_PECTEAM"] = txtPECTEAM.GetValue();
            ht["P_PECDATE"] = txtPECDATE.GetValue();
            ht["P_PECSEQ"] = txtPECSEQ.GetValue();
            ht["P_PECWOTEAM"] = txtPECWOTEAM.GetValue();
            ht["P_PECWODATE"] = txtPECWODATE.GetValue().split("-").join("");
            ht["P_PECWOSEQ"] = txtPECWOSEQ.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4070", "UP_EXAM_CHECK_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    if (DataSet.Tables[0].Rows[0]["WOAPPSODATE1"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE1"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME1"];

                        txtPECDATE1.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME1.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('1', DataSet.Tables[0].Rows[0]["PECSABUN1"], DataSet.Tables[0].Rows[0]["IMGNAME1"])

                        fshdnApproval = "1";
                    }

                    txtPECJKCD2.SetValue(DataSet.Tables[0].Rows[0]["PECJKCD2"]);
                    txtPECJKCDNM2.SetValue(DataSet.Tables[0].Rows[0]["PECJKCDNM2"]);
                    txtPECNAME2.SetValue(DataSet.Tables[0].Rows[0]["PECNAME2"]);
                    txtPECSABUN2.SetValue(DataSet.Tables[0].Rows[0]["PECSABUN2"]);

                    if (DataSet.Tables[0].Rows[0]["PECDATE2"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE2"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME2"];

                        txtPECDATE2.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME2.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('2', DataSet.Tables[0].Rows[0]["PECSABUN2"], DataSet.Tables[0].Rows[0]["IMGNAME2"])

                        fshdnApproval = "2";
                    }

                    txtPECJKCD3.SetValue(DataSet.Tables[0].Rows[0]["PECJKCD3"]);
                    txtPECJKCDNM3.SetValue(DataSet.Tables[0].Rows[0]["PECJKCDNM3"]);
                    txtPECNAME3.SetValue(DataSet.Tables[0].Rows[0]["PECNAME3"]);
                    txtPECSABUN3.SetValue(DataSet.Tables[0].Rows[0]["PECSABUN3"]);

                    if (DataSet.Tables[0].Rows[0]["PECDATE3"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE3"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME3"];

                        txtPECDATE3.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME3.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('3', DataSet.Tables[0].Rows[0]["PECSABUN3"], DataSet.Tables[0].Rows[0]["IMGNAME3"])

                        fshdnApproval = "3";
                    }

                    txtPECJKCD4.SetValue(DataSet.Tables[0].Rows[0]["PECJKCD4"]);
                    txtPECJKCDNM4.SetValue(DataSet.Tables[0].Rows[0]["PECJKCDNM4"]);
                    txtPECNAME4.SetValue(DataSet.Tables[0].Rows[0]["PECNAME4"]);
                    txtPECSABUN4.SetValue(DataSet.Tables[0].Rows[0]["PECSABUN4"]);

                    if (DataSet.Tables[0].Rows[0]["PECDATE4"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE4"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME4"];

                        txtPECDATE4.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME4.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('4', DataSet.Tables[0].Rows[0]["PECSABUN4"], DataSet.Tables[0].Rows[0]["IMGNAME4"])

                        fshdnApproval = "4";
                    }

                    txtPECJKCD5.SetValue(DataSet.Tables[0].Rows[0]["PECJKCD5"]);
                    txtPECJKCDNM5.SetValue(DataSet.Tables[0].Rows[0]["PECJKCDNM5"]);
                    txtPECNAME5.SetValue(DataSet.Tables[0].Rows[0]["PECNAME5"]);
                    txtPECSABUN5.SetValue(DataSet.Tables[0].Rows[0]["PECSABUN5"]);

                    if (DataSet.Tables[0].Rows[0]["PECDATE5"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE5"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME5"];

                        txtPECDATE5.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME5.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('5', DataSet.Tables[0].Rows[0]["PECSABUN5"], DataSet.Tables[0].Rows[0]["IMGNAME5"])

                        fshdnApproval = "5";
                    }

                    txtPECJKCD6.SetValue(DataSet.Tables[0].Rows[0]["PECJKCD6"]);
                    txtPECJKCDNM6.SetValue(DataSet.Tables[0].Rows[0]["PECJKCDNM6"]);
                    txtPECNAME6.SetValue(DataSet.Tables[0].Rows[0]["PECNAME6"]);
                    txtPECSABUN6.SetValue(DataSet.Tables[0].Rows[0]["PECSABUN6"]);

                    if (DataSet.Tables[0].Rows[0]["PECDATE6"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["PECDATE6"];
                        sTime = DataSet.Tables[0].Rows[0]["PECTIME6"];

                        txtPECDATE6.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtPECTIME6.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('6', DataSet.Tables[0].Rows[0]["PECSABUN6"], DataSet.Tables[0].Rows[0]["IMGNAME6"])

                        fshdnApproval = "6";
                    }

                    // 메일 발송
                    fn_Mail_Send(sPECWOTEAM, sPECWODATE, sPECWOSEQ, sPECTEAM, sPECDATE, sPECSEQ, sPECCANCELCOMMENT, sMail_Receiver, sGUBUN, sFinish);

                    //if (sFinish == "FINISH") {

                    //    fn_FINISH_UPT();
                    //}
                }
            }, function (e) {
                //// Biz 연결오류
                if (sGUBUN.toString() == "APPROVAL") {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    doDisplay();
                }
                else {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    doDisplay();
                }

            });

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

        function Get_Numeric(sStr) {
            if (sStr == "") return "0";
            else return sStr.replace(",", "");
        }

        function Get_Date(sStr) {

            if (sStr == "") return "";
            else return sStr.replace("-", "");
        }
              
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   	<!--컨텐츠시작-->
    <div id="content">
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server" Title="가동전 안전점검표" DefaultHide="False">

            <div class="btn_bx" id ="div_btn" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="100px" />
                        <col width="250px" />
                        <col width="100px" />
                        <col width="250px" />
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:center">
                            <Ctl:Text ID="lblPECWOTEAM" runat="server" LangCode="lblPECWOTEAM" Description="요청번호" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtPECWOTEAM" Width ="60px" runat="server" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:Text ID="Text3" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtPECWODATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ReadOnly="true"></Ctl:TextBox> 
                            <Ctl:Text ID="Text5" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtPECWOSEQ" Width ="30px" style ="text-align:right;" runat="server" ReadOnly="true"></Ctl:TextBox>
                        </td>

                        <th style="text-align:center">
                            <Ctl:Text ID="lblPECTEAM" runat="server" LangCode="lblPECTEAM" Description="점검번호" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left;border-right :hidden;">
                            <Ctl:TextBox ID="txtPECTEAM" Width ="60px" runat="server" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:Text ID="txtPECTEAMNM"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="Text1" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtPECDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                            <Ctl:Text ID="Text2" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtPECSEQ" Width ="30px" style ="text-align:right;" runat="server" ReadOnly="true"></Ctl:TextBox>
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
                        <col width="120px" />
                        <col width="120px" />
                        <col width="120px" />
                        <col width="120px" />
                        <col width="120px" />
                        <col width="120px" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                        
                        <th style="text-align:left;" colspan ="6">
                            <Ctl:Text ID="Text7" runat="server" LangCode="lblWOORTEAM" Description="결재"></Ctl:Text>
                        </th>
                        <td rowspan ="4" style="border-top:hidden;border-bottom:hidden;border-right:hidden"></td>
                    </tr>
                    <tr>
                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECSABUN1"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtPECJKCD1"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtPECJKCDNM1" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtPECNAME1"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECSABUN2"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtPECJKCD2"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtPECJKCDNM2" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtPECNAME2"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECSABUN3"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtPECJKCD3"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtPECJKCDNM3" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtPECNAME3"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECSABUN4"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtPECJKCD4"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtPECJKCDNM4" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtPECNAME4"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECSABUN5"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtPECJKCD5"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtPECJKCDNM5" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtPECNAME5"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECSABUN6"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtPECJKCD6"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtPECJKCDNM6" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtPECNAME6"   runat="server" ></Ctl:Text>
                        </td>
                    </tr>

                    <tr style="height:100px;">

                        <td style="text-align:center;" >
                            <img ID="ImgPECPHOTO1" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgPECPHOTO1" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgPECPHOTO2" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgPECPHOTO2" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgPECPHOTO3" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgPECPHOTO3" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgPECPHOTO4" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgPECPHOTO4" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgPECPHOTO5" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgPECPHOTO5" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgPECPHOTO6" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgPECPHOTO6" visible ="true"></img>
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECDATE1" runat="server" LangCode="txtPECDATE1"></Ctl:Text>
                            <Ctl:Text ID="txtPECTIME1" runat="server" LangCode="txtPECTIME1"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECDATE2" runat="server" LangCode="txtPECDATE2"></Ctl:Text>
                            <Ctl:Text ID="txtPECTIME2" runat="server" LangCode="txtPECTIME2"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECDATE3" runat="server" LangCode="txtPECDATE3"></Ctl:Text>
                            <Ctl:Text ID="txtPECTIME3" runat="server" LangCode="txtPECTIME3"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECDATE4" runat="server" LangCode="txtPECDATE4"></Ctl:Text>
                            <Ctl:Text ID="txtPECTIME4" runat="server" LangCode="txtPECTIME4"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECDATE5" runat="server" LangCode="txtPECDATE5"></Ctl:Text>
                            <Ctl:Text ID="txtPECTIME5" runat="server" LangCode="txtPECTIME5"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtPECDATE6" runat="server" LangCode="txtPECDATE6"></Ctl:Text>
                            <Ctl:Text ID="txtPECTIME6" runat="server" LangCode="txtPECTIME6"></Ctl:Text>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;" border="0">
                    <colgroup>
                        <col width="100px" />
                        <col width="*" />
                    </colgroup>
                    <tr id="COMMENTTITLE">
                        <th style="text-align:left;" colspan ="2">
                            <Ctl:Text ID="Text9" runat="server" LangCode="Text9" Description="결재의견"></Ctl:Text>
                        </th>
                    </tr>
                    <tr id="COMMENTLINE1">
                        <td style="text-align:center">
                            <Ctl:Text ID="lblPECCOMMENT1" runat="server" LangCode="lblPECCOMMENT1" Description="결재자1"></Ctl:Text>
                        </td>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtPECCOMMENT1" Width="100%" runat="server" LangCode="txtPECCOMMENT1" ReadOnly="true"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr id="COMMENTLINE2">
                        <td style="text-align:center">
                            <Ctl:Text ID="lblPECCOMMENT2" runat="server" LangCode="lblPECCOMMENT2" Description="결재자2"></Ctl:Text>
                        </td>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtPECCOMMENT2" Width="100%" runat="server" LangCode="txtPECCOMMENT2" ReadOnly="true"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr id="COMMENTLINE3">
                        <td style="text-align:center">
                            <Ctl:Text ID="lblPECCOMMENT3" runat="server" LangCode="lblPECCOMMENT3" Description="결재자3"></Ctl:Text>
                        </td>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtPECCOMMENT3" Width="100%" runat="server" LangCode="txtPECCOMMENT3" ReadOnly="true"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr id="COMMENTLINE4">
                        <td style="text-align:center">
                            <Ctl:Text ID="lblPECCOMMENT4" runat="server" LangCode="lblPECCOMMENT4" Description="결재자4"></Ctl:Text>
                        </td>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtPECCOMMENT4" Width="100%" runat="server" LangCode="txtPECCOMMENT4" ReadOnly="true"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr id="COMMENTLINE5">
                        <td style="text-align:center">
                            <Ctl:Text ID="lblPECCOMMENT5" runat="server" LangCode="lblPECCOMMENT5" Description="결재자5"></Ctl:Text>
                        </td>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtPECCOMMENT5" Width="100%" runat="server" LangCode="txtPECCOMMENT5" ReadOnly="true"></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr id="COMMENTLINE6">
                        <td style="text-align:center">
                            <Ctl:Text ID="lblPECCOMMENT6" runat="server" LangCode="lblPECCOMMENT6" Description="결재자6"></Ctl:Text>
                        </td>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtPECCOMMENT6" Width="100%" runat="server" LangCode="txtPECCOMMENT6" ReadOnly="true"></Ctl:TextBox>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="btn_bx" >
		        <table class="table_01" style="width:100%;" border="0">
                    <colgroup>
                        <col width="100px" />
                        <col width="100px" />
                        <col width="100px" />
                        <col width="70px" />
                        <col width="100px" />
                        <col width="180px" />
                        <col width="100px" />
                        <col width="180px" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                        <th colspan="9" style="text-align:left">
                            <Ctl:Text ID="Text8" runat="server" LangCode="Text8" Description="점검내용"></Ctl:Text>
                        </th>
                    </tr>
                    <tr>
                        <td style="text-align:center">
                            <Ctl:Text ID="lblPECTITLE" runat="server" LangCode="lblPECTITLE" Description="제목"></Ctl:Text>
                        </td>
                        <td colspan="8" style="text-align:left">
                            <Ctl:TextBox ID="txtPECTITLE" Width="100%" runat="server" LangCode="txtPECTITLE" ></Ctl:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center">
                            <Ctl:Text ID="lblPECINSDATE" runat="server" LangCode="lblPECINSDATE" Description="점검일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtPECINSDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px"></Ctl:TextBox>
                        </td>
                        <td style="text-align:center">
                            <Ctl:Text ID="lblPECSGUBUN" runat="server" LangCode="lblPECSGUBUN" Description="작업구분"></Ctl:Text>
                        </td>
                        <td style="text-align:left">
                            <Ctl:Combo ID="cboPECSGUBUN" Width="100%" runat="server">
                                <asp:ListItem Text="일반" Value="1" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="화물" Value="2"></asp:ListItem>
                            </Ctl:Combo>
                        </td>
                        <td style="text-align:center">
                            <Ctl:Text ID="lblPECSDATE" runat="server" LangCode="lblPECSDATE" Description="점검표 번호"></Ctl:Text>
                        </td>
                        <td style="text-align:left">
                            <Ctl:TextBox ID="txtPECSDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:Text ID="Text4" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtPECSSEQ" Width="30px" runat="server" style ="text-align:right;" LangCode="txtPECSSEQ" ReadOnly="true" ></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnEXAM" alt="점검표조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('1');"  />
                        </td>
                        <td style="text-align:center">
                            <Ctl:Text ID="lblPECRDATE" runat="server" LangCode="lblPECRDATE" Description="보고서 번호"></Ctl:Text>
                        </td>
                        <td style="text-align:left;border-right :hidden;">
                            <Ctl:TextBox ID="txtPECRDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:Text ID="Text6" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtPECRSEQ" Width="30px" runat="server" style ="text-align:right;" LangCode="txtPECRSEQ" ReadOnly="true" ></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnREPORT" alt="점검표조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('2');"  />
                        </td>
                        <td style="text-align:right;">
                            
                        </td>
                    </tr>
                </table>
            </div>
            <table style="width:100%;">
                <colgroup>
                    <col width="78%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td colspan="2" style="text-align:right;">
                        <Ctl:Button ID="btnCheckAll"   runat="server" LangCode="btnCheckAll"    Description="해당없음 일괄체크" OnClientClick="btnCheckAll_Click();" ></Ctl:Button>
                        <Ctl:Button ID="btnDetailSave" runat="server" LangCode="btnDetailSave"  Description="점검표 저장"       OnClientClick="btnDetailSave_Click();" ></Ctl:Button>
                        <Ctl:Button ID="btnRowAdd"     runat="server" LangCode="btnRowAdd"      Description="점검자선택"        OnClientClick="btnRowAdd_Click();" ></Ctl:Button>
                        <Ctl:Button ID="btnMail"       runat="server" LangCode="btnMail"        Description="메일발송"          OnClientClick="btnMail_Click();" ></Ctl:Button>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <Ctl:WebSheet ID="gridDetail" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="460" TypeName="PSM.PSM4070" MethodName="UP_GET_EXAM_CHECK_DETAIL_LIST" UseColumnSort="false" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="PECDTCTEAM" TextField="PECDTCTEAM" Description="가동전점검팀" Width="0"  HAlign="center" Align="left" runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECDTCDATE" TextField="PECDTCDATE" Description="가동전점검일자" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>                            
                            <Ctl:SheetField DataField="PECDTCSEQ" TextField="PECDTCSEQ" Description="가동전점검순번" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                            <Ctl:SheetField DataField="PECDGUBUN" TextField="PECDGUBUN" Description="일반,화물 구분" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>
                            <Ctl:SheetField DataField="PECDDATE" TextField="PECDDATE" Description="최종적용일자" Width="0" HAlign="center" Align="center" runat="server" OnClick="" Hidden="true"/>
                            <Ctl:SheetField DataField="PECDSEQ" TextField="PECDSEQ" Description="최종적용순번" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECDNUM" TextField="PECDNUM" Description="순번" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECLEVEL" TextField="PECLEVEL" Description="LEVEL" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECCCHECK" TextField="PECCCHECK" Description="체크여부" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="PECDDESC" TextField="PECDDESC" Description="점검항목" Width="*" HAlign="center" Align="left" runat="server" OnClick="" Hidden="false" />
                            <Ctl:SheetField DataField="PECDCHECK_G" TextField="PECDCHECK_G" Description="양호" Width="70" HAlign="center" Align="center" runat="server" OnClick="gridClick" Hidden="false" />
                            <Ctl:SheetField DataField="PECDCHECK_F" TextField="PECDCHECK_F" Description="보완" Width="70" HAlign="center" Align="center" runat="server" OnClick="gridClick" Hidden="false" />
                            <Ctl:SheetField DataField="PECDCHECK_N" TextField="PECDCHECK_N" Description="해당없음" Width="70" HAlign="center" Align="center" runat="server" OnClick="gridClick" Hidden="false" />
                        </Ctl:WebSheet>
                    </td>
                    <td valign="top">
                        <Ctl:WebSheet ID="gridInspect" runat="server" Paging="false" CheckBox="true" Width="100%" HFixation="true" Height="460" TypeName="PSM.PSM4070" MethodName="UP_GET_EXAM_INSPECT_LIST" UseColumnSort="false" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="PEINUM" TextField="PEINUM" Description="순번" Width="0" HAlign="center" Align="left" runat="server" OnClick="" Hidden="true"/>   
                            <Ctl:SheetField DataField="PEISABUN" TextField="PEISABUN" Description="점검자" Width="70" Edit="false" DataType="text" EditType="searchview" HAlign="center" Align="left" runat="server" OnClick="" Hidden="false" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" >
                                <Ctl:SearchViewField runat="server" DataField="KBSABUN" TextField="KBSABUN" Description="사 번" Hidden="false" TextBox="true" Width="100" Default="true"  />
                                <Ctl:SearchViewField runat="server" DataField="KBHANGL" TextField="KBHANGL" Description="이 름" Hidden="false" TextBox="true" Width="100" />
                                
                            </Ctl:SheetField>
                            <Ctl:SheetField DataField="KBHANGL" TextField="KBHANGL" Description="성명" Width="80" HAlign="center" Align="left" runat="server" OnClick="" Hidden="false" />
                            <Ctl:SheetField DataField="PEICHKDATE" TextField="PEICHKDATE" Description="점검일자" Width="90" Edit="true" DataType="text" EditType="Calendar" HAlign="center" Align="left" runat="server" OnClick="" Hidden="false" />
                            <Ctl:SheetField DataField="ROWDEL" TextField="ROWDEL" Description="  " Width="50" DataType="Button" HAlign="center" Align="left" runat="server" Hidden="true" OnClick="gridInspectClick"/>
                        </Ctl:WebSheet>
                    </td>
                </tr>
            </table>        
		</Ctl:Layer>

        
	</div>

</asp:content>