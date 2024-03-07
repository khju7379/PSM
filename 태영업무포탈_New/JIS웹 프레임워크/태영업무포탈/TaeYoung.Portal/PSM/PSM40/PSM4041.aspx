 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM4041.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM40.PSM4041" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <style>           
            html,body {width:100%;  }
            body,div,ul,li{margin:0; padding:0;}
            ul,li {list-style:none;}

            /*tab css*/
            .tab_verify{float:left; width:100%; height:115px; }
            .tabnav_verify{font-size:0; width:500px; border:0px solid #ddd;}
            
            .tabnav_verify li{display: inline-block;  height:30px; text-align:center; border-right:1px solid #ddd;}

            .tabnav_verify li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:2px; }

            .tabnav_verify li a.active:before{background:#A32958;}

            .tabnav_verify li a.active{border-bottom:1px solid #fff;}
            .tabnav_verify li a{ position:relative; display:block; background: #f8f8f8; color: #646464; padding:0 30px; line-height:30px; text-decoration:none; font-size:13px;}
            .tabnav_verify li a:hover,
            .tabnav_verify li a.active{background:#fff; color:#A32958; }            
            .tabcontent_verify{padding: 5px; border:1px solid #ddd; border-top:none;}
            
            /*tab css*/
            .tab_complete{float:left; width:100%; height:195px; }
            .tabnav_complete{font-size:0; width:500px; border:0px solid #ddd;}
            
            .tabnav_complete li{display: inline-block;  height:30px; text-align:center; border-right:1px solid #ddd;}

            .tabnav_complete li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:2px; }

            .tabnav_complete li a.active:before{background:#A32958;}

            .tabnav_complete li a.active{border-bottom:1px solid #fff;}
            .tabnav_complete li a{ position:relative; display:block; background: #f8f8f8; color: #646464; padding:0 30px; line-height:30px; text-decoration:none; font-size:13px;}
            .tabnav_complete li a:hover,
            .tabnav_complete li a.active{background:#fff; color:#A32958; }            
            .tabcontent_complete{padding: 5px; border:1px solid #ddd; }

            /*tab css*/
            .tab_sulby{float:left; width:100%; height:220px; }
            .tabnav_sulby{font-size:0; width:500px; border:0px solid #ddd;}
            
            .tabnav_sulby li{display: inline-block;  height:30px; text-align:center; border-right:1px solid #ddd;}

            .tabnav_sulby li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:2px; }

            .tabnav_sulby li a.active:before{background:#A32958;}

            .tabnav_sulby li a.active{border-bottom:1px solid #fff;}
            .tabnav_sulby li a{ position:relative; display:block; background: #f8f8f8; color: #646464; padding:0 30px; line-height:30px; text-decoration:none; font-size:13px;}
            .tabnav_sulby li a:hover,
            .tabnav_sulby li a.active{background:#fff; color:#A32958; }
            .tabcontent_sulby{padding: 5px; border:1px solid #ddd; border-top:none;}

            /*tab css*/
            .tab_safe{float:left; width:100%; height:370px; }
            .tabnav_safe{font-size:0; width:1100px; border:0px solid #ddd;}
            
            .tabnav_safe li{display: inline-block;  height:17px; text-align:center; border-right:1px solid #ddd;}

            .tabnav_safe li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:2px; }

            .tabnav_safe li a.active:before{background:#A32958;}

            .tabnav_safe li a.active{border-bottom:1px solid #fff;}
            .tabnav_safe li a{ position:relative; display:block; background: #f8f8f8; color: #646464; padding:0 30px; line-height:30px; text-decoration:none; font-size:13px;}
            .tabnav_safe li a:hover,
            .tabnav_safe li a.active{background:#fff; color:#A32958; }
            .tabcontent_safe{padding: 5px; border:1px solid #ddd; border-top:none;}

            /*tab css*/
            .tab_inspect{float:left; width:100%; height:215px; }
            .tabnav_inspect{font-size:0; width:1100px; border:0px solid #ddd;}
            
            .tabnav_inspect li{display: inline-block;  height:17px; text-align:center; border-right:1px solid #ddd;}

            .tabnav_inspect li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:2px; }

            .tabnav_inspect li a.active:before{background:#A32958;}

            .tabnav_inspect li a.active{border-bottom:1px solid #fff;}
            .tabnav_inspect li a{ position:relative; display:block; background: #f8f8f8; color: #646464; padding:0 30px; line-height:30px; text-decoration:none; font-size:13px;}
            .tabnav_inspect li a:hover,
            .tabnav_inspect li a.active{background:#fff; color:#A32958; }
            .tabcontent_inspect{padding: 5px; border:1px solid #ddd; border-top:none;}
    </style>

    <script type="text/javascript" id="$(&quot;input:checkbox[name=chkSWWKCODE7]&quot;).prop('checked')">

        function doDisplay() {

            var obj = document.getElementById("div_btn");

            if (obj.style.display == 'none') {
                obj.style.display = '';
            } else {
                obj.style.display = 'none';
            }
        }

        // 신규, 수정 작업구분
        var fshdnGubun = "";
        // 결재순서
        var fshdnApprovalSite = "";
        var fshdnAppNum = "";
        // 안전구분
        var fshdnSafe = "";
        var fsHidSession = "";
        // 로그인 사번
        var fsHdnSabun = "";
        // 요청자 부서
        var fsHdnBuseo = "";

        // 안전작업허가서 권한 
        var fsAuth = '';



        var fshdnREApproval = "0";

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

            $("#btnSign").css("background-image", "url(/Resources/Images/Approval/setline.png)");
            $("#btnSign").css("background-repeat", "no-repeat");
            $("#btnSign").css("background-position", "3px 4px");
            $("#btnSign").css("background-size", "17px, 17px");
            $("#btnSign").css("padding-left", "30px");

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

            // 안전 및 운영팀 확인
            tabControl_verify();

            // 작업완료 및 취소
            tabControl_complete("agree");            

            // 설비코드 및 작업구역
            tabControl_sulby();

            // 안전 내용
            tabControl_safe();

            // 점검 내용
            tabControl_inspect();

            fshdnLoginSabun = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";

            fshdnGubun = "<%= Request.QueryString["param"] %>";

            var Num = "<%= Request.QueryString["param1"] %>";

            var data = Num.split('-');

            fshdnApprovalSite = '';

            debugger;

            if (fshdnGubun == 'NEW') {

                var today = new Date();

                txtSMWKTEAM.SetValue(data[0]);
                datSMWKDATE.SetValue(data[1]);
                txtSMWKSEQ.SetValue(data[2]);

                datSMWKORAPPDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));

                txtSMWKORSEQ.SetValue("");

                // 작업요청서 값 가져오기
                fn_GET_WorkOrder();

                // 안전 작업 허가서 권한 가져오기
                fn_GET_Auth();

                //// 요청부서 가져오기
                //fn_SET_Buseo();

                //fn_Cancel_Visible();

                //// 조치요구사항 체크박스 Readonly
                //fn_Chk_SaCode_ReadOnly('');

                //fn_btnSMFOK_Visible(true, false, false, true, true);

                //// 요청 결재자
                //fn_Btn_Visible('9');

                //fn_ReadOnly();
            }
            else {


                if (data.length > 1) {

                    datSMWKORAPPDATE.SetDisabled(false);
                    txtSMWKORSEQ.SetDisabled(false);


                    txtSMWKTEAM.SetValue(data[0]);
                    datSMWKDATE.SetValue(data[1]);
                    txtSMWKSEQ.SetValue(data[2]);
                    datSMWKORAPPDATE.SetValue(data[3]);
                    txtSMWKORSEQ.SetValue(data[4]);

                    fn_GET_Display();

                    //// 작업내용 가져오기
                    //fn_GET_Wkcode();

                    //// 조치요구사항 가져오기
                    //fn_SaCode_GetData();

                    //// 굴착 조치요구사항 가져오기
                    //fn_DRCode_GetData();

                    //// 안전 작업 허가서 권한 가져오기
                    //fn_GET_Auth();

                    //// SIGN 및 버튼
                    //fn_Get_Sign();

                    //// 연장 결재
                    //fn_Get_SMOT_Display();

                    //// 조치요구사항 체크박스 Readonly
                    //fn_Chk_SaCode_ReadOnly();
                }
            }

            // 요청자 부서코드 가져오기
            fn_SMORSABUN_BUSEO();
        }


        










        function tabControl_complete(gubun) {

            if (gubun == "agree") {
                $('.tabcontent_complete > div').hide();

                $('.tabnav_complete a').click(function () {
                    $('.tabcontent_complete > div').hide().filter(this.hash).fadeIn();
                    $('.tabnav_complete a').removeClass('active');
                    $(this).addClass('active');
                    return false;
                }).filter(':eq(0)').click();
            }
            else {
                $('.tabcontent_complete > div').hide();

                $('.tabnav_complete a').click(function () {
                    $('.tabcontent_complete > div').hide().filter(this.hash).fadeIn();
                    $('.tabnav_complete a').removeClass('active');
                    $(this).addClass('active');
                    return false;
                }).filter(':eq(1)').click();
            }
        }

        function tabControl_verify() {

            $('.tabcontent_verify > div').hide();

            $('.tabnav_verify a').click(function () {
                $('.tabcontent_verify > div').hide().filter(this.hash).fadeIn();
                $('.tabnav_verify a').removeClass('active');
                $(this).addClass('active');
                return false;
            }).filter(':eq(0)').click();
        }

        function tabControl_sulby() {

            $('.tabcontent_sulby > div').hide();

            $('.tabnav_sulby a').click(function () {
                $('.tabcontent_sulby > div').hide().filter(this.hash).fadeIn();
                $('.tabnav_sulby a').removeClass('active');
                $(this).addClass('active');
                return false;
            }).filter(':eq(0)').click();
        }

        function tabControl_safe() {

            $('.tabcontent_safe > div').hide();

            $('.tabnav_safe a').click(function () {
                $('.tabcontent_safe > div').hide().filter(this.hash).fadeIn();
                $('.tabnav_safe a').removeClass('active');
                $(this).addClass('active');
                return false;
            }).filter(':eq(0)').click();

            // 탭 숨기기
            $("#li02_safe").hide();
            $("#li03_safe").hide();
            $("#li04_safe").hide();
            $("#li05_safe").hide();
            $("#li06_safe").hide();
            $("#li07_safe").hide();
            $("#li08_safe").hide();
            //$("#li09_safe").hide();
        }

        function tabControl_inspect() {

            $('.tabcontent_inspect > div').hide();

            $('.tabnav_inspect a').click(function () {
                $('.tabcontent_inspect > div').hide().filter(this.hash).fadeIn();
                $('.tabnav_inspect a').removeClass('active');
                $(this).addClass('active');
                return false;
            }).filter(':eq(0)').click();
        }

        function fn_ReadOnly() {

            var bReadOnly;
            var bReadOnly1;


            //if (txtWOAPPSODATE1.GetValue() != "") {
            //    bReadOnly = true;
            //}
            //else {
            //    bReadOnly = false;
            //}

            // 위험성평가 자료 체크
            if (fsRMWKTEAM != "") {
                bReadOnly1 = true;
            }
            else {
                bReadOnly1 = false;
            }

            
        }

        function fn_Field_SetDisabled(bReadOnly) {

            svSMREVTEAM.SetDisabled(bReadOnly);

            rdoSMWKMETHOD.SetDisabled(bReadOnly);

            txtSMSUBVEND.SetDisabled(bReadOnly);
            txtSMSUBPERSON.SetDisabled(bReadOnly);
            txtSMSUBTEL.SetDisabled(bReadOnly);

            txtSMWKMAN.SetDisabled(bReadOnly);

            datSMTADATE1.SetDisabled(bReadOnly);

            txtSMTATIME1_ST.SetDisabled(bReadOnly);
            txtSMTATIME1_ED.SetDisabled(bReadOnly);

            datSMTADATE2.SetDisabled(bReadOnly);

            txtSMTATIME2_ST.SetDisabled(bReadOnly);
            txtSMTATIME2_ED.SetDisabled(bReadOnly);

            datSMOTDATE1.SetDisabled(bReadOnly);

            txtSMOTTIME1_ST.SetDisabled(bReadOnly);
            txtSMOTTIME1_ED.SetDisabled(bReadOnly);

            datSMOTDATE2.SetDisabled(bReadOnly);

            txtSMOTTIME2_ST.SetDisabled(bReadOnly);
            txtSMOTTIME2_ED.SetDisabled(bReadOnly);

            // 설비코드
            txtSMSYSTEMCODE1.SetDisabled(bReadOnly);
            txtSMSYSTEMCODE2.SetDisabled(bReadOnly);
            txtSMSYSTEMCODE3.SetDisabled(bReadOnly);
            txtSMSYSTEMCODE4.SetDisabled(bReadOnly);
            txtSMSYSTEMCODE5.SetDisabled(bReadOnly);

            txtSMCONNCODE11.SetDisabled(bReadOnly);
            txtSMCONNCODE12.SetDisabled(bReadOnly);
            txtSMCONNCODE21.SetDisabled(bReadOnly);
            txtSMCONNCODE22.SetDisabled(bReadOnly);
            txtSMCONNCODE31.SetDisabled(bReadOnly);
            txtSMCONNCODE32.SetDisabled(bReadOnly);
            txtSMCONNCODE41.SetDisabled(bReadOnly);
            txtSMCONNCODE42.SetDisabled(bReadOnly);
            txtSMCONNCODE51.SetDisabled(bReadOnly);
            txtSMCONNCODE52.SetDisabled(bReadOnly);

            txtSMAREACODE1.SetDisabled(bReadOnly);
            txtSMAREACODE2.SetDisabled(bReadOnly);
            txtSMAREACODE3.SetDisabled(bReadOnly);
            txtSMAREACODE4.SetDisabled(bReadOnly);
            txtSMAREACODE5.SetDisabled(bReadOnly);

            txtSMAREATEXT1.SetDisabled(bReadOnly);
            txtSMAREATEXT2.SetDisabled(bReadOnly);
            txtSMAREATEXT3.SetDisabled(bReadOnly);
            txtSMAREATEXT4.SetDisabled(bReadOnly);
            txtSMAREATEXT5.SetDisabled(bReadOnly);

            txtSMMATERTEXT2.SetDisabled(bReadOnly);

            ChkSMNOTE_BURN.SetDisabled(bReadOnly);
            ChkSMNOTE_SUFF.SetDisabled(bReadOnly);
            ChkSMNOTE_ELE.SetDisabled(bReadOnly);
            ChkSMNOTE_FIR.SetDisabled(bReadOnly);
            ChkSMNOTE_EXP.SetDisabled(bReadOnly);
            ChkSMNOTE_DROP.SetDisabled(bReadOnly);
            ChkSMNOTE_LEAK.SetDisabled(bReadOnly);
            ChkSMNOTE_NARR.SetDisabled(bReadOnly);
            ChkSMNOTE_COLL.SetDisabled(bReadOnly);

            svSMCHKSABUN1.SetDisabled(bReadOnly);
            txtSMCHKTIME1_HH.SetDisabled(bReadOnly);
            txtSMCHKTIME1_MM.SetDisabled(bReadOnly);
            txtSMCHKOXYGEN1.SetDisabled(bReadOnly);
            cboSMCHKOXYGENUNIT1.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM1.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM1DS.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM1CO2.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM1CO.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM1H2S.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT1.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT1DS.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT1CO2.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT1CO.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT1H2S.SetDisabled(bReadOnly);

            svSMCHKSABUN2.SetDisabled(bReadOnly);
            txtSMCHKTIME2_HH.SetDisabled(bReadOnly);
            txtSMCHKTIME2_MM.SetDisabled(bReadOnly);
            txtSMCHKOXYGEN2.SetDisabled(bReadOnly);
            cboSMCHKOXYGENUNIT2.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM2.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM2DS.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM2CO2.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM2CO.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM2H2S.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT2.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT2DS.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT2CO2.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT2CO.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT2H2S.SetDisabled(bReadOnly);

            svSMCHKSABUN3.SetDisabled(bReadOnly);
            txtSMCHKTIME3_HH.SetDisabled(bReadOnly);
            txtSMCHKTIME3_MM.SetDisabled(bReadOnly);
            txtSMCHKOXYGEN3.SetDisabled(bReadOnly);
            cboSMCHKOXYGENUNIT3.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM3.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM3DS.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM3CO2.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM3CO.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM3H2S.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT3.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT3DS.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT3CO2.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT3CO.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT3H2S.SetDisabled(bReadOnly);

            svSMCHKSABUN4.SetDisabled(bReadOnly);
            txtSMCHKTIME4_HH.SetDisabled(bReadOnly);
            txtSMCHKTIME4_MM.SetDisabled(bReadOnly);
            txtSMCHKOXYGEN4.SetDisabled(bReadOnly);
            cboSMCHKOXYGENUNIT4.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM4.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM4DS.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM4CO2.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM4CO.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM4H2S.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT4.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT4DS.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT4CO2.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT4CO.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT4H2S.SetDisabled(bReadOnly);

            svSMCHKSABUN5.SetDisabled(bReadOnly);
            txtSMCHKTIME5_HH.SetDisabled(bReadOnly);
            txtSMCHKTIME5_MM.SetDisabled(bReadOnly);
            txtSMCHKOXYGEN5.SetDisabled(bReadOnly);
            cboSMCHKOXYGENUNIT5.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM5.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM5DS.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM5CO2.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM5CO.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM5H2S.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT5.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT5DS.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT5CO2.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT5CO.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT5H2S.SetDisabled(bReadOnly);

            svSMCHKSABUN6.SetDisabled(bReadOnly);
            txtSMCHKTIME6_HH.SetDisabled(bReadOnly);
            txtSMCHKTIME6_MM.SetDisabled(bReadOnly);
            txtSMCHKOXYGEN6.SetDisabled(bReadOnly);
            cboSMCHKOXYGENUNIT6.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM6.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM6DS.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM6CO2.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM6CO.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM6H2S.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT6.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT6DS.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT6CO2.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT6CO.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT6H2S.SetDisabled(bReadOnly);

            svSMCHKSABUN7.SetDisabled(bReadOnly);
            txtSMCHKTIME7_HH.SetDisabled(bReadOnly);
            txtSMCHKTIME7_MM.SetDisabled(bReadOnly);
            txtSMCHKOXYGEN7.SetDisabled(bReadOnly);
            cboSMCHKOXYGENUNIT7.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM7.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM7DS.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM7CO2.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM7CO.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM7H2S.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT7.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT7DS.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT7CO2.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT7CO.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT7H2S.SetDisabled(bReadOnly);

            svSMCHKSABUN8.SetDisabled(bReadOnly);
            txtSMCHKTIME8_HH.SetDisabled(bReadOnly);
            txtSMCHKTIME8_MM.SetDisabled(bReadOnly);
            txtSMCHKOXYGEN8.SetDisabled(bReadOnly);
            cboSMCHKOXYGENUNIT8.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM8.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM8DS.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM8CO2.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM8CO.SetDisabled(bReadOnly);
            txtSMCHKTOXNUM8H2S.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT8.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT8DS.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT8CO2.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT8CO.SetDisabled(bReadOnly);
            cboSMCHKTOXUNIT8H2S.SetDisabled(bReadOnly);

            txtSMORDERTEXT1.SetDisabled(bReadOnly);

            

            datSMWKDATE.SetDisabled(bReadOnly);

            /*txtWOWORKTITLE.SetDisabled(bReadOnly);*/
            txtSMSYSTEMCODE1.SetDisabled(bReadOnly);
            txtSMSYSTEMCODE2.SetDisabled(bReadOnly);
            txtSMSYSTEMCODE3.SetDisabled(bReadOnly);
            txtSMSYSTEMCODE4.SetDisabled(bReadOnly);
            txtSMSYSTEMCODE5.SetDisabled(bReadOnly);

            txtSMAREACODE1.SetDisabled(bReadOnly);
            txtSMAREACODE2.SetDisabled(bReadOnly);
            txtSMAREACODE3.SetDisabled(bReadOnly);
            txtSMAREACODE4.SetDisabled(bReadOnly);
            txtSMAREACODE5.SetDisabled(bReadOnly);
            //txtWODSDATE1.SetDisabled(bReadOnly);
            //txtWODSDATE2.SetDisabled(bReadOnly);

            //cboWOCHANGEWKJOB.SetDisabled(bReadOnly);
            //cboWOCHANGEWKDIV.SetDisabled(bReadOnly1);
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

            fshdnSOSign = "";
        }

        
        function fn_oracle_test() {

            fsAuth = '';

            var DataSet;
            var ht = new Object();

            debugger;

            ht["P_BINNO"]  = '101';
            ht["P_STBIN"]  = '2';
            ht["P_WKTEXT"] = '';

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "up_oracle_test", function (e) {

                debugger;
                DataSet = eval(e);

                debugger;

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    debugger;

                    alert(DataSet.Tables[0].Rows[0]["MSG"]);
                }
            }, function (e) {

                debugger;

                alert(e);
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="로딩중 사번 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

        

        function fn_Get_Image(gubun) {

            var Num = "";
            var data = "";
            var control = "";

            if (gubun == 'OR') {

                Num = document.getElementById("conBody_ImgSMORPHOTO").src;

                data = Num.split('&');

                control = $("#txtSMORSABUN").val();

                Img_Read(gubun, control, data[1]);
            }
            else if (gubun == 'GR') {

                Num = document.getElementById("conBody_ImgSMGRPHOTO").src;

                data = Num.split('&');

                control = $("#txtSMGRSABUN").val();

                Img_Read(gubun, control, data[1]);
            }
            else if (gubun == 'CO') {

                Num = document.getElementById("conBody_ImgSMCOPHOTO").src;

                data = Num.split('&');

                control = $("#txtSMCOSABUN").val();

                Img_Read(gubun, control, data[1]);
            }
        }


        // 안전 작업 허가서 권한 가져오기
        function fn_GET_Auth() {

            fsAuth = '';

            var DataSet;
            var ht = new Object();

            ht["P_USRID"] = fshdnLoginSabun;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_GET_AUTH", function (e) {

                DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    fsAuth = DataSet.Tables[0].Rows[0]["GRPID"];

                    //// 조치요구사항 체크박스 Readonly
                    //fn_Chk_SaCode_ReadOnly('');

                    if (fshdnGubun == 'NEW') {
                        // 요청부서 가져오기
                        fn_SET_Buseo();

                        fn_Cancel_Visible();

                        // 조치요구사항 체크박스 Readonly
                        fn_Chk_SaCode_ReadOnly('');

                        fn_btnSMFOK_Visible(true, false, false, true, true);

                        // 요청 결재자
                        fn_Btn_Visible('9');

                        fn_ReadOnly();
                    }
                    else {

                        // SIGN 및 버튼
                        fn_Get_Sign();

                        // 연장 결재
                        fn_Get_SMOT_Display();

                        // 조치요구사항 체크박스 Readonly
                        fn_Chk_SaCode_ReadOnly('');
                    }
                }
                else {

                    fsAuth = '';

                    // 조치요구사항 체크박스 Readonly
                    //fn_Chk_SaCode_ReadOnly('');

                    if (fshdnGubun == 'NEW') {
                        // 요청부서 가져오기
                        fn_SET_Buseo();

                        fn_Cancel_Visible();

                        // 조치요구사항 체크박스 Readonly
                        fn_Chk_SaCode_ReadOnly('');

                        fn_btnSMFOK_Visible(true, false, false, true, true);

                        // 요청 결재자
                        fn_Btn_Visible('9');

                        fn_ReadOnly();
                    }
                    else {

                        // SIGN 및 버튼
                        fn_Get_Sign();

                        // 연장 결재
                        fn_Get_SMOT_Display();

                        // 조치요구사항 체크박스 Readonly
                        fn_Chk_SaCode_ReadOnly('');
                    }
                }
            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="로딩중 사번 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

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

                    // 요청자
                    txtSMORSABUN.SetValue("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>");
                    txtSMORNAME.SetValue(DataSet.Tables[0].Rows[0]["KBHANGL"]);
                    txtSMORJKCD.SetValue(DataSet.Tables[0].Rows[0]["KBJKCD"]);
                    txtSMORJKCDNM.SetValue(DataSet.Tables[0].Rows[0]["CDDESC1"]);
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
                        txtSMORJKCD.SetValue(DataSet1.Tables[0].Rows[0]["JCCD"]);
                        txtSMORJKCDNM.SetValue(DataSet1.Tables[0].Rows[0]["JKDESC"]);
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

        // 요청자 부서코드 가져오기
        function fn_SMORSABUN_BUSEO() {

            var DataSet;
            

            var ht = new Object();
            
            var today = new Date();

            ht["P_DATE"] = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());
            ht["P_KBSABUN"] = txtSMORSABUN.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    fsHdnBuseo = DataSet.Tables[0].Rows[0]["KBBUSEO"];
                }
            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="로딩중 직급 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

        // 데이터 바인딩
        function fn_GET_Display() {

            var sLoginBuseo = "";
            var sRESABUN    = "";
            var sRENAME     = "";

            fn_Field_Clear();

            var sDate = "";
            var sTime = "";

            fshdnApprovalSite = "";

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_SMWKTEAM"]      = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMWKSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMWKORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_MASTER_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    // 첨부파일 로드
                    AttachFileLod();


                    if (DataSet.Tables[0].Rows[0]["SMWORKTITLE"].toString() == "") {
                        txtSMWORKTITLE.SetValue(DataSet.Tables[0].Rows[0]["WOWORKTITLE"].toString());
                    }
                    else {
                        txtSMWORKTITLE.SetValue(DataSet.Tables[0].Rows[0]["SMWORKTITLE"].toString());
                    }

                    txtSMFIREINS.SetValue(DataSet.Tables[0].Rows[0]["SMFIREINS"].toString());

                    $("#svSMREVTEAM_BUSEO").val(DataSet.Tables[0].Rows[0]["SMREVTEAM"]);
                    $("#svSMREVTEAM_BUSEONM").val(DataSet.Tables[0].Rows[0]["SMREVTEAMNM"]);

                    rdoSMWKMETHOD.SetValue(DataSet.Tables[0].Rows[0]["SMWKMETHOD"].toString())

                    txtSMSUBVEND.SetValue(DataSet.Tables[0].Rows[0]["SMSUBVEND"].toString());
                    txtSMSUBPERSON.SetValue(DataSet.Tables[0].Rows[0]["SMSUBPERSON"].toString());
                    txtSMSUBTEL.SetValue(DataSet.Tables[0].Rows[0]["SMSUBTEL"].toString());

                    txtSMWKMAN.SetValue(DataSet.Tables[0].Rows[0]["SMWKMAN"].toString());

                    // 작업일자
                    if (DataSet.Tables[0].Rows[0]["SMTADATE1"].toString() != "") {
                        datSMTADATE1.SetValue(DataSet.Tables[0].Rows[0]["SMTADATE1"].toString().substr(0, 4) + "-" + DataSet.Tables[0].Rows[0]["SMTADATE1"].toString().substr(4, 2) + "-" + DataSet.Tables[0].Rows[0]["SMTADATE1"].toString().substr(6, 2));
                    }

                    txtSMTATIME1_ST.SetValue(Set_Fill2(DataSet.Tables[0].Rows[0]["SMTATIME1_HH"].toString()));
                    txtSMTATIME1_ED.SetValue(Set_Fill2(DataSet.Tables[0].Rows[0]["SMTATIME1_MM"].toString()));

                    if (DataSet.Tables[0].Rows[0]["SMTADATE2"].toString() != "") {
                        datSMTADATE2.SetValue(DataSet.Tables[0].Rows[0]["SMTADATE2"].toString().substr(0, 4) + "-" + DataSet.Tables[0].Rows[0]["SMTADATE2"].toString().substr(4, 2) + "-" + DataSet.Tables[0].Rows[0]["SMTADATE2"].toString().substr(6, 2));
                    }

                    txtSMTATIME2_ST.SetValue(Set_Fill2(DataSet.Tables[0].Rows[0]["SMTATIME2_HH"].toString()));
                    txtSMTATIME2_ED.SetValue(Set_Fill2(DataSet.Tables[0].Rows[0]["SMTATIME2_MM"].toString()));

                    // 연장일자
                    if (DataSet.Tables[0].Rows[0]["SMOTDATE1"].toString() != "") {
                        datSMOTDATE1.SetValue(DataSet.Tables[0].Rows[0]["SMOTDATE1"].toString().substr(0, 4) + "-" + DataSet.Tables[0].Rows[0]["SMOTDATE1"].toString().substr(4, 2) + "-" + DataSet.Tables[0].Rows[0]["SMOTDATE1"].toString().substr(6, 2));

                        txtSMOTTIME1_ST.SetValue(Set_Fill2(DataSet.Tables[0].Rows[0]["SMOTTIME1_HH"].toString()));
                        txtSMOTTIME1_ED.SetValue(Set_Fill2(DataSet.Tables[0].Rows[0]["SMOTTIME1_MM"].toString()));
                    }

                    if (DataSet.Tables[0].Rows[0]["SMOTDATE2"].toString() != "") {
                        datSMOTDATE2.SetValue(DataSet.Tables[0].Rows[0]["SMOTDATE2"].toString().substr(0, 4) + "-" + DataSet.Tables[0].Rows[0]["SMOTDATE2"].toString().substr(4, 2) + "-" + DataSet.Tables[0].Rows[0]["SMOTDATE2"].toString().substr(6, 2));

                        txtSMOTTIME2_ST.SetValue(Set_Fill2(DataSet.Tables[0].Rows[0]["SMOTTIME2_HH"].toString()));
                        txtSMOTTIME2_ED.SetValue(Set_Fill2(DataSet.Tables[0].Rows[0]["SMOTTIME2_MM"].toString()));
                    }

                    // 설비코드
                    txtSMSYSTEMCODE1.SetValue(DataSet.Tables[0].Rows[0]["SMSYSTEMCODE1"]);
                    pnlSMSYSTEMCODE1.SetValue(DataSet.Tables[0].Rows[0]["SMSYSTEMCODE1NM"]);
                    
                    txtSMSYSTEMCODE2.SetValue(DataSet.Tables[0].Rows[0]["SMSYSTEMCODE2"]);
                    pnlSMSYSTEMCODE2.SetValue(DataSet.Tables[0].Rows[0]["SMSYSTEMCODE2NM"]);

                    txtSMSYSTEMCODE3.SetValue(DataSet.Tables[0].Rows[0]["SMSYSTEMCODE3"]);
                    pnlSMSYSTEMCODE3.SetValue(DataSet.Tables[0].Rows[0]["SMSYSTEMCODE3NM"]);

                    txtSMSYSTEMCODE4.SetValue(DataSet.Tables[0].Rows[0]["SMSYSTEMCODE4"]);
                    pnlSMSYSTEMCODE4.SetValue(DataSet.Tables[0].Rows[0]["SMSYSTEMCODE4NM"]);

                    txtSMSYSTEMCODE5.SetValue(DataSet.Tables[0].Rows[0]["SMSYSTEMCODE5"]);
                    pnlSMSYSTEMCODE5.SetValue(DataSet.Tables[0].Rows[0]["SMSYSTEMCODE5NM"]);

                    txtSMCONNCODE11.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE11"]);
                    pnlSMCONNCODE11.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE11NM"]);

                    txtSMCONNCODE12.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE12"]);
                    pnlSMCONNCODE12.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE12NM"]);

                    txtSMCONNCODE21.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE21"]);
                    pnlSMCONNCODE21.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE21NM"]);
                    
                    txtSMCONNCODE22.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE22"]);
                    pnlSMCONNCODE22.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE22NM"]);

                    txtSMCONNCODE31.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE31"]);
                    pnlSMCONNCODE31.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE31NM"]);

                    txtSMCONNCODE32.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE32"]);
                    pnlSMCONNCODE32.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE32NM"]);

                    txtSMCONNCODE41.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE41"]);
                    pnlSMCONNCODE41.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE41NM"]);

                    txtSMCONNCODE42.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE42"]);
                    pnlSMCONNCODE42.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE42NM"]);

                    txtSMCONNCODE51.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE51"]);
                    pnlSMCONNCODE51.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE51NM"]);

                    txtSMCONNCODE52.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE52"]);
                    pnlSMCONNCODE52.SetValue(DataSet.Tables[0].Rows[0]["SMCONNCODE52NM"]);

                    txtSMAREACODE1.SetValue(DataSet.Tables[0].Rows[0]["SMAREACODE1"]);
                    pnlSMAREACODE1.SetValue(DataSet.Tables[0].Rows[0]["SMAREACODE1NM"]);

                    txtSMAREACODE2.SetValue(DataSet.Tables[0].Rows[0]["SMAREACODE2"]);
                    pnlSMAREACODE2.SetValue(DataSet.Tables[0].Rows[0]["SMAREACODE2NM"]);
                    
                    txtSMAREACODE3.SetValue(DataSet.Tables[0].Rows[0]["SMAREACODE3"]);
                    pnlSMAREACODE3.SetValue(DataSet.Tables[0].Rows[0]["SMAREACODE3NM"]);
                    
                    txtSMAREACODE4.SetValue(DataSet.Tables[0].Rows[0]["SMAREACODE4"]);
                    pnlSMAREACODE4.SetValue(DataSet.Tables[0].Rows[0]["SMAREACODE4NM"]);
                    
                    txtSMAREACODE5.SetValue(DataSet.Tables[0].Rows[0]["SMAREACODE5"]);
                    pnlSMAREACODE5.SetValue(DataSet.Tables[0].Rows[0]["SMAREACODE5NM"]);

                    txtSMAREATEXT1.SetValue(DataSet.Tables[0].Rows[0]["SMAREATEXT1"]);
                    txtSMAREATEXT2.SetValue(DataSet.Tables[0].Rows[0]["SMAREATEXT2"]);
                    txtSMAREATEXT3.SetValue(DataSet.Tables[0].Rows[0]["SMAREATEXT3"]);
                    txtSMAREATEXT4.SetValue(DataSet.Tables[0].Rows[0]["SMAREATEXT4"]);
                    txtSMAREATEXT5.SetValue(DataSet.Tables[0].Rows[0]["SMAREATEXT5"]);

                    txtSMMATERTEXT2.SetValue(DataSet.Tables[0].Rows[0]["SMMATERTEXT2"]);

                    if (DataSet.Tables[0].Rows[0]["SMNOTE_BURN"].toString() == "Y") {
                        $('input:checkbox[name="ChkSMNOTE_BURN"]').attr("checked", true);
                    }

                    if (DataSet.Tables[0].Rows[0]["SMNOTE_SUFF"].toString() == "Y") {
                        $('input:checkbox[name="ChkSMNOTE_SUFF"]').attr("checked", true);
                    }

                    if (DataSet.Tables[0].Rows[0]["SMNOTE_ELE"].toString() == "Y") {
                        $('input:checkbox[name="ChkSMNOTE_ELE"]').attr("checked", true);
                    }

                    if (DataSet.Tables[0].Rows[0]["SMNOTE_FIR"].toString() == "Y") {
                        $('input:checkbox[name="ChkSMNOTE_FIR"]').attr("checked", true);
                    }

                    if (DataSet.Tables[0].Rows[0]["SMNOTE_EXP"].toString() == "Y") {
                        $('input:checkbox[name="ChkSMNOTE_EXP"]').attr("checked", true);
                    }

                    if (DataSet.Tables[0].Rows[0]["SMNOTE_DROP"].toString() == "Y") {
                        $('input:checkbox[name="ChkSMNOTE_DROP"]').attr("checked", true);
                    }

                    if (DataSet.Tables[0].Rows[0]["SMNOTE_LEAK"].toString() == "Y") {
                        $('input:checkbox[name="ChkSMNOTE_LEAK"]').attr("checked", true);
                    }

                    if (DataSet.Tables[0].Rows[0]["SMNOTE_NARR"].toString() == "Y") {
                        $('input:checkbox[name="ChkSMNOTE_NARR"]').attr("checked", true);
                    }

                    if (DataSet.Tables[0].Rows[0]["SMNOTE_COLL"].toString() == "Y") {
                        $('input:checkbox[name="ChkSMNOTE_COLL"]').attr("checked", true);
                    }

                    $("#svSMCHKSABUN1_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN1"]);
                    $("#svSMCHKSABUN1_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN1NM"]);
                    
                    txtSMCHKTIME1_HH.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME1_HH"].toString());
                    txtSMCHKTIME1_MM.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME1_MM"].toString());
                    txtSMCHKOXYGEN1.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGEN1"].toString());
                    cboSMCHKOXYGENUNIT1.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGENUNIT1"].toString());
                    txtSMCHKTOXNUM1.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM1"].toString());
                    cboSMCHKTOXUNIT1.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT1"].toString());
                    txtSMCHKTOXNUM1DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM1DS"].toString());
                    cboSMCHKTOXUNIT1DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT1DS"].toString());
                    txtSMCHKTOXNUM1CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM1CO2"].toString());
                    cboSMCHKTOXUNIT1CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT1CO2"].toString());
                    txtSMCHKTOXNUM1CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM1CO"].toString());
                    cboSMCHKTOXUNIT1CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT1CO"].toString());
                    txtSMCHKTOXNUM1H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM1H2S"].toString());
                    cboSMCHKTOXUNIT1H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT1H2S"].toString());
                    //cboSMCHKTOXGUBN1.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXGUBN1"].toString());

                    $("#svSMCHKSABUN2_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN2"]);
                    $("#svSMCHKSABUN2_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN2NM"]);
                    txtSMCHKTIME2_HH.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME2_HH"].toString());
                    txtSMCHKTIME2_MM.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME2_MM"].toString());
                    txtSMCHKOXYGEN2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGEN2"].toString());
                    cboSMCHKOXYGENUNIT2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGENUNIT2"].toString());
                    txtSMCHKTOXNUM2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM2"].toString());
                    cboSMCHKTOXUNIT2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT2"].toString());
                    txtSMCHKTOXNUM2DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM2DS"].toString());
                    cboSMCHKTOXUNIT2DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT2DS"].toString());
                    txtSMCHKTOXNUM2CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM2CO2"].toString());
                    cboSMCHKTOXUNIT2CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT2CO2"].toString());
                    txtSMCHKTOXNUM2CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM2CO"].toString());
                    cboSMCHKTOXUNIT2CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT2CO"].toString());
                    txtSMCHKTOXNUM2H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM2H2S"].toString());
                    cboSMCHKTOXUNIT2H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT2H2S"].toString());
                    //cboSMCHKTOXGUBN2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXGUBN2"].toString());

                    $("#svSMCHKSABUN3_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN3"]);
                    $("#svSMCHKSABUN3_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN3NM"]);
                    txtSMCHKTIME3_HH.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME3_HH"].toString());
                    txtSMCHKTIME3_MM.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME3_MM"].toString());
                    txtSMCHKOXYGEN3.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGEN3"].toString());
                    cboSMCHKOXYGENUNIT3.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGENUNIT3"].toString());
                    txtSMCHKTOXNUM3.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM3"].toString());
                    cboSMCHKTOXUNIT3.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT3"].toString());
                    txtSMCHKTOXNUM3DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM3DS"].toString());
                    cboSMCHKTOXUNIT3DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT3DS"].toString());
                    txtSMCHKTOXNUM3CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM3CO2"].toString());
                    cboSMCHKTOXUNIT3CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT3CO2"].toString());
                    txtSMCHKTOXNUM3CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM3CO"].toString());
                    cboSMCHKTOXUNIT3CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT3CO"].toString());
                    txtSMCHKTOXNUM3H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM3H2S"].toString());
                    cboSMCHKTOXUNIT3H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT3H2S"].toString());
                    //cboSMCHKTOXGUBN3.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXGUBN3"].toString());

                    $("#svSMCHKSABUN4_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN4"]);
                    $("#svSMCHKSABUN4_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN4NM"]);
                    txtSMCHKTIME4_HH.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME4_HH"].toString());
                    txtSMCHKTIME4_MM.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME4_MM"].toString());
                    txtSMCHKOXYGEN4.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGEN4"].toString());
                    cboSMCHKOXYGENUNIT4.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGENUNIT4"].toString());
                    txtSMCHKTOXNUM4.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM4"].toString());
                    cboSMCHKTOXUNIT4.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT4"].toString());
                    txtSMCHKTOXNUM4DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM4DS"].toString());
                    cboSMCHKTOXUNIT4DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT4DS"].toString());
                    txtSMCHKTOXNUM4CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM4CO2"].toString());
                    cboSMCHKTOXUNIT4CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT4CO2"].toString());
                    txtSMCHKTOXNUM4CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM4CO"].toString());
                    cboSMCHKTOXUNIT4CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT4CO"].toString());
                    txtSMCHKTOXNUM4H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM4H2S"].toString());
                    cboSMCHKTOXUNIT4H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT4H2S"].toString());
                    //cboSMCHKTOXGUBN4.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXGUBN4"].toString());

                    $("#svSMCHKSABUN5_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN5"]);
                    $("#svSMCHKSABUN5_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN5NM"]);
                    txtSMCHKTIME5_HH.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME5_HH"].toString());
                    txtSMCHKTIME5_MM.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME5_MM"].toString());
                    txtSMCHKOXYGEN5.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGEN5"].toString());
                    cboSMCHKOXYGENUNIT5.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGENUNIT5"].toString());
                    txtSMCHKTOXNUM5.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM5"].toString());
                    cboSMCHKTOXUNIT5.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT5"].toString());
                    txtSMCHKTOXNUM5DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM5DS"].toString());
                    cboSMCHKTOXUNIT5DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT5DS"].toString());
                    txtSMCHKTOXNUM5CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM5CO2"].toString());
                    cboSMCHKTOXUNIT5CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT5CO2"].toString());
                    txtSMCHKTOXNUM5CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM5CO"].toString());
                    cboSMCHKTOXUNIT5CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT5CO"].toString());
                    txtSMCHKTOXNUM5H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM5H2S"].toString());
                    cboSMCHKTOXUNIT5H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT5H2S"].toString());
                    //cboSMCHKTOXGUBN5.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXGUBN5"].toString());

                    $("#svSMCHKSABUN6_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN6"]);
                    $("#svSMCHKSABUN6_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN6NM"]);
                    txtSMCHKTIME6_HH.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME6_HH"].toString());
                    txtSMCHKTIME6_MM.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME6_MM"].toString());
                    txtSMCHKOXYGEN6.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGEN6"].toString());
                    cboSMCHKOXYGENUNIT6.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGENUNIT6"].toString());
                    txtSMCHKTOXNUM6.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM6"].toString());
                    cboSMCHKTOXUNIT6.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT6"].toString());
                    txtSMCHKTOXNUM6DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM6DS"].toString());
                    cboSMCHKTOXUNIT6DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT6DS"].toString());
                    txtSMCHKTOXNUM6CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM6CO2"].toString());
                    cboSMCHKTOXUNIT6CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT6CO2"].toString());
                    txtSMCHKTOXNUM6CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM6CO"].toString());
                    cboSMCHKTOXUNIT6CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT6CO"].toString());
                    txtSMCHKTOXNUM6H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM6H2S"].toString());
                    cboSMCHKTOXUNIT6H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT6H2S"].toString());

                    $("#svSMCHKSABUN7_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN7"]);
                    $("#svSMCHKSABUN7_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN7NM"]);
                    txtSMCHKTIME7_HH.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME7_HH"].toString());
                    txtSMCHKTIME7_MM.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME7_MM"].toString());
                    txtSMCHKOXYGEN7.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGEN7"].toString());
                    cboSMCHKOXYGENUNIT7.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGENUNIT7"].toString());
                    txtSMCHKTOXNUM7.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM7"].toString());
                    cboSMCHKTOXUNIT7.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT7"].toString());
                    txtSMCHKTOXNUM7DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM7DS"].toString());
                    cboSMCHKTOXUNIT7DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT7DS"].toString());
                    txtSMCHKTOXNUM7CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM7CO2"].toString());
                    cboSMCHKTOXUNIT7CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT7CO2"].toString());
                    txtSMCHKTOXNUM7CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM7CO"].toString());
                    cboSMCHKTOXUNIT7CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT7CO"].toString());
                    txtSMCHKTOXNUM7H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM7H2S"].toString());
                    cboSMCHKTOXUNIT7H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT7H2S"].toString());

                    $("#svSMCHKSABUN8_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN8"]);
                    $("#svSMCHKSABUN8_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMCHKSABUN8NM"]);
                    txtSMCHKTIME8_HH.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME8_HH"].toString());
                    txtSMCHKTIME8_MM.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTIME8_MM"].toString());
                    txtSMCHKOXYGEN8.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGEN8"].toString());
                    cboSMCHKOXYGENUNIT8.SetValue(DataSet.Tables[0].Rows[0]["SMCHKOXYGENUNIT8"].toString());
                    txtSMCHKTOXNUM8.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM8"].toString());
                    cboSMCHKTOXUNIT8.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT8"].toString());
                    txtSMCHKTOXNUM8DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM8DS"].toString());
                    cboSMCHKTOXUNIT8DS.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT8DS"].toString());
                    txtSMCHKTOXNUM8CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM8CO2"].toString());
                    cboSMCHKTOXUNIT8CO2.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT8CO2"].toString());
                    txtSMCHKTOXNUM8CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM8CO"].toString());
                    cboSMCHKTOXUNIT8CO.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT8CO"].toString());
                    txtSMCHKTOXNUM8H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXNUM8H2S"].toString());
                    cboSMCHKTOXUNIT8H2S.SetValue(DataSet.Tables[0].Rows[0]["SMCHKTOXUNIT8H2S"].toString());

                    this.txtSMORDERTEXT1.SetValue(DataSet.Tables[0].Rows[0]["SMORDERTEXT1"].toString());

                    txtSMORSABUN.SetValue(DataSet.Tables[0].Rows[0]["SMORSABUN"].toString());
                    txtSMORNAME.SetValue(DataSet.Tables[0].Rows[0]["SMORNAME"].toString());
                    txtSMORJKCD.SetValue(DataSet.Tables[0].Rows[0]["SMORJKCD"].toString());
                    txtSMORJKCDNM.SetValue(DataSet.Tables[0].Rows[0]["SMORJKCDNM"].toString());

                    // 복사시 한글 때문에 로직 추가
                    if (txtSMORSABUN.GetValue() != "" && txtSMORNAME.GetValue() == "") {

                        fn_SET_Buseo();
                    }

                    if (DataSet.Tables[0].Rows[0]["SMORAPPDATE"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["SMORAPPDATE"];
                        sTime = DataSet.Tables[0].Rows[0]["SMORAPPTIME"];

                        txtSMORAPPDATE.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtSMORAPPTIME.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('OR', DataSet.Tables[0].Rows[0]["SMORSABUN"], DataSet.Tables[0].Rows[0]["ORIMGNAME"]);

                        fshdnApprovalSite = "1";
                    }
                    else {
                        txtSMORAPPDATE.SetValue("");
                        txtSMORAPPTIME.SetValue("");
                    }

                    txtSMGRSABUN.SetValue(DataSet.Tables[0].Rows[0]["SMGRSABUN"]);
                    txtSMGRNAME.SetValue(DataSet.Tables[0].Rows[0]["SMGRNAME"]);
                    txtSMGRJKCD.SetValue(DataSet.Tables[0].Rows[0]["SMGRJKCD"]);
                    txtSMGRJKCDNM.SetValue(DataSet.Tables[0].Rows[0]["SMGRJKCDNM"]);

                    if (DataSet.Tables[0].Rows[0]["SMGRAPPDATE"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["SMGRAPPDATE"];
                        sTime = DataSet.Tables[0].Rows[0]["SMGRAPPTIME"];

                        txtSMGRAPPDATE.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtSMGRAPPTIME.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('GR', DataSet.Tables[0].Rows[0]["SMGRSABUN"], DataSet.Tables[0].Rows[0]["GRIMGNAME"]);

                        fshdnApprovalSite = "2";
                    }
                    else {
                        txtSMGRAPPDATE.SetValue("");
                        txtSMGRAPPTIME.SetValue("");
                    }

                    txtSMCOSABUN.SetValue(DataSet.Tables[0].Rows[0]["SMCOSABUN"]);
                    txtSMCONAME.SetValue(DataSet.Tables[0].Rows[0]["SMCONAME"]);
                    txtSMCOJKCD.SetValue(DataSet.Tables[0].Rows[0]["SMCOJKCD"]);
                    txtSMCOJKCDNM.SetValue(DataSet.Tables[0].Rows[0]["SMCOJKCDNM"]);

                    if (DataSet.Tables[0].Rows[0]["SMCOAPPDATE"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["SMCOAPPDATE"];
                        sTime = DataSet.Tables[0].Rows[0]["SMCOAPPTIME"];

                        txtSMCOAPPDATE.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtSMCOAPPTIME.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('CO', DataSet.Tables[0].Rows[0]["SMCOSABUN"], DataSet.Tables[0].Rows[0]["COIMGNAME"]);

                        fshdnApprovalSite = "3";
                    }
                    else {
                        txtSMCOAPPDATE.SetValue("");
                        txtSMCOAPPTIME.SetValue("");
                    }

                    // 안전환경팀
                    $("#svSMSMSABUN_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMSMSABUN"]);
                    $("#svSMSMSABUN_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMSMSABUNNM"]);
                    txtSMSMCOMMENT.SetValue(DataSet.Tables[0].Rows[0]["SMSMCOMMENT"].toString());

                    if (DataSet.Tables[0].Rows[0]["SMSMAPPDATE"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["SMSMAPPDATE"];
                        sTime = DataSet.Tables[0].Rows[0]["SMSMAPPTIME"];

                        if (sDate != "") {
                            txtSMSMAPPDATE.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        }
                        if (sTime != "") {
                            txtSMSMAPPTIME.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));
                        }
                    }
                    else {
                        txtSMSMAPPDATE.SetValue("");
                        txtSMSMAPPTIME.SetValue("");
                    }


                    // 운영팀 확인
                    $("#svSMOPSABUN_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMOPSABUN"]);
                    $("#svSMOPSABUN_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMOPSABUNNM"]);
                    txtSMOPCOMMENT.SetValue(DataSet.Tables[0].Rows[0]["SMOPCOMMENT"].toString());

                    if (DataSet.Tables[0].Rows[0]["SMOPAPPDATE"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["SMOPAPPDATE"];
                        sTime = DataSet.Tables[0].Rows[0]["SMOPAPPTIME"];

                        if (sDate != "") {
                            txtSMOPAPPDATE.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        }
                        if (sTime != "") {
                            txtSMOPAPPTIME.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));
                        }
                    }
                    else {
                        txtSMOPAPPDATE.SetValue("");
                        txtSMOPAPPTIME.SetValue("");
                    }


                    // 연장승인자
                    $("#svSMOTAPPSABUN_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMOTAPPSABUN"]);
                    $("#svSMOTAPPSABUN_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMOTAPPSABUNNM"]);

                    $("#svSMFSSABUN_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMFSSABUN"]);
                    $("#svSMFSSABUN_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMFSSABUNNM"]);



                    if (DataSet.Tables[0].Rows[0]["SMFSDATE"].toString() != "") {
                        sDate = DataSet.Tables[0].Rows[0]["SMFSDATE"].toString();
                        sTime = DataSet.Tables[0].Rows[0]["SMFSTIME"].toString();

                        txtSMFSDATE.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtSMFSTIME_HH.SetValue(sTime.substr(0, 2));
                        txtSMFSTIME_MM.SetValue(sTime.substr(2, 2));
                        txtSMFSTIME_SS.SetValue(sTime.substr(4, 2));
                        
                    }

                    // 작업취소
                    $("#svSMCNSABUN_KBSABUN").val(DataSet.Tables[0].Rows[0]["SMCNSABUN"])
                    $("#svSMCNSABUN_KBHANGL").val(DataSet.Tables[0].Rows[0]["SMCNSABUNNM"])

                    if (DataSet.Tables[0].Rows[0]["SMCNDATE"].toString() != "") {
                        sDate = DataSet.Tables[0].Rows[0]["SMCNDATE"].toString();
                        sTime = DataSet.Tables[0].Rows[0]["SMCNTIME"].toString();

                        txtSMCNDATE.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtSMCNTIME.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));
                    }

                    txtSMCNREASON.SetValue(DataSet.Tables[0].Rows[0]["SMCNREASON"].toString());

                    //공사완료
                    if (DataSet.Tables[0].Rows[0]["SMFSWKCLOSE"].toString() == "Y") {
                        $('input:checkbox[name="chkSMFSWKCLOSE"]').attr("checked", true);
                    }
                    else {
                        $('input:checkbox[name="chkSMFSWKCLOSE"]').attr("checked", false);
                    }

                    txtSMFSWKTEXT.SetValue(DataSet.Tables[0].Rows[0]["SMFSWKTEXT"].toString());

                    // 요청자 부서코드 가져오기
                    fn_SMORSABUN_BUSEO();

                    var today = new Date();
                    var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                    ht1["P_GUBUN"]      = "INDEX";
                    ht1["P_DATE"]       = today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate());
                    ht1["P_LoginSABUN"] = fshdnLoginSabun;

                    ht1["P_REDOCID"]  = '05';
                    ht1["P_REDOCNUM"] = txtSMWKTEAM.GetValue() + Get_Date(datSMWKDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKSEQ.GetValue()) + Get_Date(datSMWKORAPPDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKORSEQ.GetValue());
                    ht1["P_GUBN"]     = "SA";

                    PageMethods.InvokeServiceTable(ht1, "PSM.PSM4010", "UP_Get_Ds_Common", function (e) {

                        var dsComm = eval(e);

                        if (ObjectCount(dsComm.Tables[0].Rows) > 0) {

                            sLoginBuseo = dsComm.Tables[0].Rows[0]["LOGINBUSEO"];

                            sRESABUN    = dsComm.Tables[0].Rows[0]["RESABUN"];
                            sRENAME     = dsComm.Tables[0].Rows[0]["RENAME"];

                            // 참조자
                            fn_REFERENCE("INDEX", sRESABUN, sRENAME);

                            // 첨부파일 업로드
                            AttachFileLod();
                        }
                    }, function (e) {

                        // Biz 연결오류
                        alert(e.get_message());
                        alert("Error");
                    });

                    // 작업내용 가져오기
                    fn_GET_Wkcode();

                    // 조치요구사항 가져오기
                    fn_SaCode_GetData();

                    // 굴착 조치요구사항 가져오기
                    fn_DRCode_GetData();

                    // 안전 작업 허가서 권한 가져오기
                    fn_GET_Auth();

                    // SIGN 및 버튼
                    fn_Get_Sign();

                    // 연장 결재
                    fn_Get_SMOT_Display();

                    // 조치요구사항 체크박스 Readonly
                    fn_Chk_SaCode_ReadOnly('');
                }
            }, function (e) {

                // Biz 연결오류
                alert(e.get_message());
                alert("Error");
            });
        }

        // 작업내용 가져오기
        function fn_GET_Wkcode() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_SWWKTEAM"]    = txtSMWKTEAM.GetValue();
            ht["P_SWWKDATE"]    = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SWWKSEQ"]     = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SWORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SWORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_GET_WKCODE", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {

                        if (DataSet.Tables[0].Rows[i]["SWWKCODE"].toString() == "01") {
                            $('input:checkbox[name="chkSWWKCODE1"]').attr("checked", true);
                            $("#li01_safe").show();

                            $("#chkSWWKCODE1").css("font-color", "red");
                        }
                        else if (DataSet.Tables[0].Rows[i]["SWWKCODE"].toString() == "02") {
                            $('input:checkbox[name="chkSWWKCODE2"]').attr("checked", true);
                            $("#li02_safe").show();
                        }
                        else if (DataSet.Tables[0].Rows[i]["SWWKCODE"].toString() == "03") {
                            $('input:checkbox[name="chkSWWKCODE3"]').attr("checked", true);
                            $("#li03_safe").show();
                        }
                        else if (DataSet.Tables[0].Rows[i]["SWWKCODE"].toString() == "04") {
                            $('input:checkbox[name="chkSWWKCODE4"]').attr("checked", true);
                            $("#li03_safe").show();
                        }
                        else if (DataSet.Tables[0].Rows[i]["SWWKCODE"].toString() == "05") {
                            $('input:checkbox[name="chkSWWKCODE5"]').attr("checked", true);
                            $("#li03_safe").show();
                        }
                        else if (DataSet.Tables[0].Rows[i]["SWWKCODE"].toString() == "06") {
                            $('input:checkbox[name="chkSWWKCODE6"]').attr("checked", true);
                            $("#li04_safe").show();
                        }
                        else if (DataSet.Tables[0].Rows[i]["SWWKCODE"].toString() == "07") {
                            $('input:checkbox[name="chkSWWKCODE7"]').attr("checked", true);
                            $("#li05_safe").show();
                        }
                        else if (DataSet.Tables[0].Rows[i]["SWWKCODE"].toString() == "08") {
                            $('input:checkbox[name="chkSWWKCODE8"]').attr("checked", true);
                            $("#li06_safe").show();
                        }
                        else if (DataSet.Tables[0].Rows[i]["SWWKCODE"].toString() == "09") {
                            $('input:checkbox[name="chkSWWKCODE9"]').attr("checked", true);
                            $("#li07_safe").show();
                        }
                        else if (DataSet.Tables[0].Rows[i]["SWWKCODE"].toString() == "10") {
                            $('input:checkbox[name="chkSWWKCODE10"]').attr("checked", true);
                            $("#li08_safe").show();
                        }
                    }
                }
            }, function (e) {

                // Biz 연결오류
                alert(e.get_message());
                alert("Error");
            });
        }

        // 조치요구사항 가져오기
        function fn_SaCode_GetData() {

            var bCHK1;
            var bCHK2;
            var bCHK3;

            var i = 0;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_SSWKTEAM"]    = txtSMWKTEAM.GetValue();
            ht["P_SSWKDATE"]    = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SSWKSEQ"]     = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SSORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SSORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_GET_SACODE", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {

                        bCHK1 = false;
                        bCHK2 = false;
                        bCHK3 = false;

                        if (DataSet.Tables[0].Rows[i]["SSPUBSEL"].toString() == "Y") {
                            bCHK1 = true;
                        }

                        if (txtSMORAPPDATE.GetValue() != "" && txtSMGRAPPDATE.GetValue() == "") {
                            if (DataSet.Tables[0].Rows[i]["SSPUBSEL"].toString() == "Y") {
                                bCHK2 = true;
                            }
                        }
                        else {
                            if (DataSet.Tables[0].Rows[i]["SSREVSEL"].toString() == "Y") {
                                bCHK2 = true;
                            }
                        }

                        if (DataSet.Tables[0].Rows[i]["SSFIXSEL"].toString() == "Y") {
                            bCHK3 = true;
                        }
                        
                        fn_Set_SACODE_Check(DataSet.Tables[0].Rows[i]["SSSACODE"].toString(), bCHK1, bCHK2, bCHK3);
                    }
                }
            }, function (e) {

                // Biz 연결오류
                alert(e.get_message());
                alert("Error");
            });
        }

        function fn_Set_SACODE_Check(sCODE, bCHK1, bCHK2, bCHK3) {

            switch (sCODE) {
                case "101":
                    $('input:checkbox[name="Chk101_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk101_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk101_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "102":

                    $('input:checkbox[name="Chk102_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk102_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk102_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "103":

                    $('input:checkbox[name="Chk103_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk103_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk103_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "104":

                    $('input:checkbox[name="Chk104_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk104_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk104_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "105":

                    $('input:checkbox[name="Chk105_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk105_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk105_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "106":

                    $('input:checkbox[name="Chk106_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk106_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk106_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "107":

                    $('input:checkbox[name="Chk107_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk107_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk107_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "108":

                    $('input:checkbox[name="Chk108_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk108_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk108_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "109":

                    $('input:checkbox[name="Chk109_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk109_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk109_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "110":

                    $('input:checkbox[name="Chk110_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk110_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk110_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "111":

                    $('input:checkbox[name="Chk111_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk111_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk111_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "112":

                    $('input:checkbox[name="Chk112_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk112_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk112_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "113":

                    $('input:checkbox[name="Chk113_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk113_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk113_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "114":

                    $('input:checkbox[name="Chk114_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk114_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk114_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "115":

                    $('input:checkbox[name="Chk115_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk115_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk115_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "116":

                    $('input:checkbox[name="Chk116_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk116_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk116_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "201":

                    $('input:checkbox[name="Chk201_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk201_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk201_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "202":

                    $('input:checkbox[name="Chk202_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk202_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk202_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "203":

                    $('input:checkbox[name="Chk203_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk203_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk203_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "204":

                    $('input:checkbox[name="Chk204_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk204_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk204_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "205":

                    $('input:checkbox[name="Chk205_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk205_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk205_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "206":

                    $('input:checkbox[name="Chk206_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk206_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk206_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "207":

                    $('input:checkbox[name="Chk207_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk207_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk207_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "208":

                    $('input:checkbox[name="Chk208_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk208_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk208_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "209":

                    $('input:checkbox[name="Chk209_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk209_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk209_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "210":

                    $('input:checkbox[name="Chk210_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk210_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk210_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "211":

                    $('input:checkbox[name="Chk211_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk211_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk211_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "212":

                    $('input:checkbox[name="Chk212_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk212_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk212_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "213":

                    $('input:checkbox[name="Chk213_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk213_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk213_SSFIXSEL"]').attr("checked", bCHK3);

                    break;



                case "214":

                    $('input:checkbox[name="Chk214_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk214_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk214_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "215":

                    $('input:checkbox[name="Chk215_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk215_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk215_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "216":

                    $('input:checkbox[name="Chk216_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk216_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk216_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "217":

                    $('input:checkbox[name="Chk217_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk217_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk217_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "218":

                    $('input:checkbox[name="Chk218_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk218_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk218_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "301":

                    $('input:checkbox[name="Chk301_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk301_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk301_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "302":

                    $('input:checkbox[name="Chk302_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk302_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk302_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "303":

                    $('input:checkbox[name="Chk303_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk303_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk303_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "304":

                    $('input:checkbox[name="Chk304_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk304_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk304_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "305":

                    $('input:checkbox[name="Chk305_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk305_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk305_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "306":

                    $('input:checkbox[name="Chk306_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk306_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk306_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "307":

                    $('input:checkbox[name="Chk307_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk307_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk307_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "308":

                    $('input:checkbox[name="Chk308_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk308_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk308_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "309":

                    $('input:checkbox[name="Chk309_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk309_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk309_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "310":

                    $('input:checkbox[name="Chk310_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk310_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk310_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "311":

                    $('input:checkbox[name="Chk311_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk311_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk311_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "312":

                    $('input:checkbox[name="Chk312_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk312_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk312_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "313":

                    $('input:checkbox[name="Chk313_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk313_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk313_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "314":

                    $('input:checkbox[name="Chk314_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk314_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk314_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "401":

                    $('input:checkbox[name="Chk401_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk401_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk401_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "402":

                    $('input:checkbox[name="Chk402_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk402_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk402_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "403":

                    $('input:checkbox[name="Chk403_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk403_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk403_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "404":

                    $('input:checkbox[name="Chk404_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk404_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk404_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "405":

                    $('input:checkbox[name="Chk405_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk405_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk405_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "406":

                    $('input:checkbox[name="Chk406_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk406_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk406_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "407":

                    $('input:checkbox[name="Chk407_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk407_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk407_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "408":

                    $('input:checkbox[name="Chk408_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk408_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk408_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "409":

                    $('input:checkbox[name="Chk409_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk409_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk409_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "501":

                    $('input:checkbox[name="Chk501_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk501_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk501_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "502":

                    $('input:checkbox[name="Chk502_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk502_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk502_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "503":

                    $('input:checkbox[name="Chk503_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk503_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk503_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "504":

                    $('input:checkbox[name="Chk504_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk504_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk504_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "601":

                    $('input:checkbox[name="Chk601_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk601_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk601_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "602":

                    $('input:checkbox[name="Chk602_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk602_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk602_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "603":

                    $('input:checkbox[name="Chk603_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk603_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk603_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "701":

                    $('input:checkbox[name="Chk701_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk701_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk701_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "702":

                    $('input:checkbox[name="Chk702_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk702_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk702_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "703":

                    $('input:checkbox[name="Chk703_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk703_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk703_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "704":

                    $('input:checkbox[name="Chk704_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk704_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk704_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "705":

                    $('input:checkbox[name="Chk705_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk705_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk705_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "706":

                    $('input:checkbox[name="Chk706_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk706_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk706_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "707":

                    $('input:checkbox[name="Chk707_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk707_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk707_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "708":

                    $('input:checkbox[name="Chk708_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk708_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk708_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "901":

                    $('input:checkbox[name="Chk901_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk901_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk901_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "902":

                    $('input:checkbox[name="Chk902_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk902_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk902_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "903":

                    $('input:checkbox[name="Chk903_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk903_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk903_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "904":

                    $('input:checkbox[name="Chk904_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk904_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk904_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "905":

                    $('input:checkbox[name="Chk905_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk905_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk905_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "906":

                    $('input:checkbox[name="Chk906_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk906_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk906_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "907":

                    $('input:checkbox[name="Chk907_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk907_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk907_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "908":

                    $('input:checkbox[name="Chk908_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk908_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk908_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "909":

                    $('input:checkbox[name="Chk909_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk909_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk909_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "910":

                    $('input:checkbox[name="Chk910_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk910_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk910_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "911":

                    $('input:checkbox[name="Chk911_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk911_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk911_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "912":

                    $('input:checkbox[name="Chk912_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk912_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk912_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "913":

                    $('input:checkbox[name="Chk913_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk913_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk913_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "914":

                    $('input:checkbox[name="Chk914_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk914_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk914_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "915":

                    $('input:checkbox[name="Chk915_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk915_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk915_SSFIXSEL"]').attr("checked", bCHK3);

                    break;

                case "916":

                    $('input:checkbox[name="Chk916_SSPUBSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk916_SSREVSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk916_SSFIXSEL"]').attr("checked", bCHK3);

                    break;
            }
        }

        function fn_DRCode_GetData() {

            var bCHK1;
            var bCHK2;
            var bCHK3;

            var i = 0;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_DRWKTEAM"]    = txtSMWKTEAM.GetValue();
            ht["P_DRWKDATE"]    = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_DRWKSEQ"]     = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_DRORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_DRORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_GET_DRCODE", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {

                        bCHK1 = false;
                        bCHK2 = false;
                        bCHK3 = false;

                        if (DataSet.Tables[0].Rows[i]["DRYESSEL"].toString() == "Y") {
                            bCHK1 = true;
                        }

                        if (DataSet.Tables[0].Rows[i]["DRNOSEL"].toString() == "Y") {
                            bCHK2 = true;
                        }
                        
                        if (DataSet.Tables[0].Rows[i]["DRNASEL"].toString() == "Y") {
                            bCHK3 = true;
                        }

                        fn_Set_DRCODE_Check(DataSet.Tables[0].Rows[i]["DRCODE"].toString(), bCHK1, bCHK2, bCHK3);

                        if (i == 0) {
                            txt801_Kind.SetValue(ds.Tables[0].Rows[i]["DRSORT"].toString());
                            txt801_Std.SetValue(ds.Tables[0].Rows[i]["DRSTAND"].toString());
                            txt801_Depth.SetValue(ds.Tables[0].Rows[i]["DRDEPTH"].toString());
                            $("#sv801_Sabun_KBSABUN").val(ds.Tables[0].Rows[i]["DRSABUN"].toString());
                            $("#sv801_Sabun_KBHANGL").val(ds.Tables[0].Rows[i]["KBHANGL"].toString());
                        }
                        else if (i == 1) {
                            txt802_Kind.SetValue(ds.Tables[0].Rows[i]["DRSORT"].toString());
                            txt802_Std.SetValue(ds.Tables[0].Rows[i]["DRSTAND"].toString());
                            txt802_Depth.SetValue(ds.Tables[0].Rows[i]["DRDEPTH"].toString());
                            $("#sv802_Sabun_KBSABUN").val(ds.Tables[0].Rows[i]["DRSABUN"].toString());
                            $("#sv802_Sabun_KBHANGL").val(ds.Tables[0].Rows[i]["KBHANGL"].toString());
                        }
                        else if (i == 2) {
                            txt803_Kind.SetValue(ds.Tables[0].Rows[i]["DRSORT"].toString());
                            txt803_Std.SetValue(ds.Tables[0].Rows[i]["DRSTAND"].toString());
                            txt803_Depth.SetValue(ds.Tables[0].Rows[i]["DRDEPTH"].toString());
                            $("#sv803_Sabun_KBSABUN").val(ds.Tables[0].Rows[i]["DRSABUN"].toString());
                            $("#sv803_Sabun_KBHANGL").val(ds.Tables[0].Rows[i]["KBHANGL"].toString());
                        }
                        else if (i == 3) {
                            txt804_Kind.SetValue(ds.Tables[0].Rows[i]["DRSORT"].toString());
                            txt804_Std.SetValue(ds.Tables[0].Rows[i]["DRSTAND"].toString());
                            txt804_Depth.SetValue(ds.Tables[0].Rows[i]["DRDEPTH"].toString());
                            $("#sv804_Sabun_KBSABUN").val(ds.Tables[0].Rows[i]["DRSABUN"].toString());
                            $("#sv804_Sabun_KBHANGL").val(ds.Tables[0].Rows[i]["KBHANGL"].toString());
                        }
                        else if (i == 4) {
                            txt805_Kind.SetValue(ds.Tables[0].Rows[i]["DRSORT"].toString());
                            txt805_Std.SetValue(ds.Tables[0].Rows[i]["DRSTAND"].toString());
                            txt805_Depth.SetValue(ds.Tables[0].Rows[i]["DRDEPTH"].toString());
                            $("#sv805_Sabun_KBSABUN").val(ds.Tables[0].Rows[i]["DRSABUN"].toString());
                            $("#sv805_Sabun_KBHANGL").val(ds.Tables[0].Rows[i]["KBHANGL"].toString());
                        }
                    }
                }
            }, function (e) {

                // Biz 연결오류
                alert(e.get_message());
                alert("Error");
            });
        }

        function fn_Set_DRCODE_Check(sCODE, bCHK1, bCHK2, bCHK3) {

            switch (sCODE) {
                case "801":

                    $('input:checkbox[name="Chk801_DRYESSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk801_DRNOSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk801_DRNASEL"]').attr("checked", bCHK3);

                    break;

                case "802":

                    $('input:checkbox[name="Chk802_DRYESSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk802_DRNOSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk802_DRNASEL"]').attr("checked", bCHK3);

                    break;

                case "803":

                    $('input:checkbox[name="Chk803_DRYESSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk803_DRNOSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk803_DRNASEL"]').attr("checked", bCHK3);

                    break;

                case "804":

                    $('input:checkbox[name="Chk804_DRYESSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk804_DRNOSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk804_DRNASEL"]').attr("checked", bCHK3);

                    break;

                case "805":

                    $('input:checkbox[name="Chk805_DRYESSEL"]').attr("checked", bCHK1);
                    $('input:checkbox[name="Chk805_DRNOSEL"]').attr("checked", bCHK2);
                    $('input:checkbox[name="Chk805_DRNASEL"]').attr("checked", bCHK3);

                    break;
            }
        }

        // 연장결재
        function fn_Get_SMOT_Display() {


            if ($("#svSMFSSABUN_KBSABUN").val() == "" && txtSMFSDATE.GetValue() == "" && txtSMFSTIME_HH.GetValue() == "") {

                if (fshdnLoginSabun == txtSMORSABUN.GetValue() || fshdnLoginSabun == txtSMGRSABUN.GetValue() || fshdnLoginSabun == txtSMCOSABUN.GetValue()) {
                    if (txtSMORAPPDATE.GetValue() != "" && txtSMGRAPPDATE.GetValue() != "" && txtSMCOAPPDATE.GetValue() != "") {
                        fn_btnSMOT_Visible(true, false);
                    }
                    else {
                        fn_btnSMOT_Visible(false, false);
                    }
                }
                else {

                    var sSMOR_BUSEO = ''; // 요청자   부서코드
                    var sLogin_BUSEO = ''; // 로그인자 부서코드

                    // 안전환경팀, 작업요청자 동일 부서일 경우
                    // 작업요청에 대해 마지막 안전작업 허가서일 경우 허가서가 완료 되었더라도
                    // 공사 완료를 체크할 수 있도록 수정.


                    var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
                    var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
                    var ht2 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                    ht["P_KBSABUN"] = txtSMORSABUN.GetValue();

                    // 요청자 사람의 부서코드
                    PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                            // 요청자 부서코드
                            sSMOR_BUSEO = DataSet.Tables[0].Rows[0]["KBBUSEO"];
                        }
                    }, function (e) {
                        // Biz 연결오류
                        alert('<Ctl:Text runat="server" Description="로딩중 로그인 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    });


                    ht1["P_KBSABUN"] = fshdnLoginSabun;

                    // 로그인 부서코드
                    PageMethods.InvokeServiceTable(ht1, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                        var DataSet1 = eval(e);

                        if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                            // 로그인 부서코드
                            sLogin_BUSEO = DataSet1.Tables[0].Rows[0]["KBBUSEO"];
                        }
                    }, function (e) {
                        // Biz 연결오류
                        alert('<Ctl:Text runat="server" Description="로딩중 로그인 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    });

                    if (sSMOR_BUSEO != '' && sLogin_BUSEO != '') {

                        if (fsAuth == 'SAFE_MAG' || sSMOR_BUSEO == sLogin_BUSEO) {
                            fn_btnSMOT_Visible(true, false);
                        }
                        else {
                            fn_btnSMOT_Visible(false, true);
                        }
                    }
                    else {
                        fn_btnSMOT_Visible(false, true);
                    }
                }
            }
            else {
                if (fsAuth == 'SAFE_MAG') {
                    fn_btnSMOT_Visible(true, false);
                }
                else {
                    fn_btnSMOT_Visible(false, true);
                }
            }
        }

        function fn_btnSMOT_Visible(bVisible1, bVisible2) {

            datSMOTDATE1.SetDisabled(bVisible2);
			txtSMOTTIME1_ST.SetDisabled(bVisible2);
			txtSMOTTIME1_ED.SetDisabled(bVisible2);
			datSMOTDATE2.SetDisabled(bVisible2);
			txtSMOTTIME2_ST.SetDisabled(bVisible2);
			txtSMOTTIME2_ED.SetDisabled(bVisible2);
			txtSMOTAPPSABUN.SetDisabled(bVisible2);

            if (bVisible1 == true) {
                btnSMOT.Show();
            }
            else {
                btnSMOT.Hide();
            }
        }

        // SIGN 및 버튼
        function fn_Get_Sign() {

            var iCOUNT = 0;

            if (txtSMCOSABUN.GetValue() != "") {
                iCOUNT = 3;
            }
            else if (txtSMGRSABUN.GetValue != "") {
                iCOUNT = 2;
            }
            else if (txtSMORSABUN.GetValue != "") {
                iCOUNT = 1;
            }

            fshdnApprovalSite = "";

            if (txtSMORAPPDATE.GetValue() != "") {

                fn_Get_Image('OR');

                fshdnApprovalSite = "1";
            }

            if (txtSMGRAPPDATE.GetValue() != "") {

                fn_Get_Image('GR');

                fshdnApprovalSite = "2";
            }

            if (txtSMCOAPPDATE.GetValue() != "") {

                fn_Get_Image('CO');

                fshdnApprovalSite = "3";
            }

            // 현재 결재라인
            fn_GET_APPROVAL_Line(iCOUNT,                  fshdnApprovalSite,
                                 txtSMORSABUN.GetValue(), txtSMORAPPDATE.GetValue(),
                                 txtSMGRSABUN.GetValue(), txtSMGRAPPDATE.GetValue(),
                                 txtSMCOSABUN.GetValue(), txtSMCOAPPDATE.GetValue());

            // 작업승인 완료
            fn_Complete_Visible();

            // 작업 취소
            fn_Cancel_Visible();
        }

        // 현재 결재라인
        function fn_GET_APPROVAL_Line(iCnt,    sCnt,
                                      sSABUN1, sDATE1,
                                      sSABUN2, sDATE2,
                                      sSABUN3, sDATE3) {

            var sSO_BUSEO       = ''; // 첫 요청자 부서코드
            var sLOGIN_BUSEO    = ''; // 로그인 부서코드

            var sNOWAPP_SOSABUN = ''; // 현재 요청 결재할 사람

            // 현재 요청 결재할 사람
            if (sSABUN1 != "" && sDATE1 == "") {
                sNOWAPP_SOSABUN = sSABUN1;
            }
            else if (sSABUN2 != "" && sDATE2 == "") {
                sNOWAPP_SOSABUN = sSABUN2;
            }
            else if (sSABUN3 != "" && sDATE3 == "") {
                sNOWAPP_SOSABUN = sSABUN3;
            }


            var ht  = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_KBSABUN"] = sNOWAPP_SOSABUN;

            // 현재 결재할 사람의 부서코드
            PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    // 현재 결재자의 부서코드
                    sSO_BUSEO = DataSet.Tables[0].Rows[0]["KBBUSEO"];
                }
            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" Description="로딩중 로그인 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });


            ht1["P_KBSABUN"] = fshdnLoginSabun;

            // 로그인 부서코드
            PageMethods.InvokeServiceTable(ht1, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                var DataSet1 = eval(e);

                if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                    // 로그인 부서코드
                    sLogin_BUSEO = DataSet1.Tables[0].Rows[0]["KBBUSEO"];
                }
            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" Description="로딩중 로그인 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });

            //if (sSO_BUSEO != "" && sLogin_BUSEO != "") {

            if ($("#svSMCNSABUN_KBSABUN").val() != "" && txtSMCNDATE.GetValue() != "" && txtSMCNTIME.GetValue() != "" && txtSMCNREASON.GetValue() != "") {

                fn_Btn_Visible("3"); // 작업 취소인 경우
            }
            else {
                if (sCnt == "") {
                    if (sSABUN1 == fshdnLoginSabun) {
                        fn_Btn_Visible("0"); // 요청자 결재
                    }
                    else {
                        if (sSO_BUSEO == sLOGIN_BUSEO) {
                            fn_Btn_Visible("10");
                        }
                        else {
                            fn_Btn_Visible("3"); // 결재자 외 직원이 로그인한 경우
                        }
                    }
                }
                else if (sCnt == "1") {
                    if (sSABUN2 == fshdnLoginSabun) {
                        if (sDATE2 == "") {
                            fn_Btn_Visible("5");
                        }
                        else {
                            fn_Btn_Visible("3");
                        }
                    }
                    else {
                        if (sDATE2 == "") {
                            if (sSO_BUSEO == sLOGIN_BUSEO) {
                                fn_Btn_Visible("15");
                            }
                            else {
                                if ((sSO_BUSEO == "E10000" || sSO_BUSEO == "E10100") &&
                                    (sLOGIN_BUSEO == "E10000" || sLOGIN_BUSEO == "E10100")) {
                                    fn_Btn_Visible("15");
                                }
                                else {
                                    fn_Btn_Visible("3"); // 결재자 외 직원이 로그인한 경우
                                }
                            }
                        }
                        else {
                            fn_Btn_Visible("3");
                        }
                    }
                }
                else if (sCnt == "2") {
                    if (sSABUN3 == fshdnLoginSabun) {
                        if (sDATE3 == "") {
                            fn_Btn_Visible("7");
                        }
                        else {
                            fn_Btn_Visible("3");
                        }
                    }
                    else {
                        if (sDATE3 == "") {
                            if (sSO_BUSEO == sLOGIN_BUSEO) {
                                fn_Btn_Visible("15");
                            }
                            else {
                                if ((sSO_BUSEO == "E10000" || sSO_BUSEO == "E10100") &&
                                    (sLOGIN_BUSEO == "E10000" || sLOGIN_BUSEO == "E10100")) {
                                    fn_Btn_Visible("15");
                                }
                                else {
                                    fn_Btn_Visible("3"); // 결재자 외 직원이 로그인한 경우
                                }
                            }
                        }
                        else {
                            fn_Btn_Visible("3");
                        }
                    }
                }
                else if (sCnt == "3") {
                    fn_Btn_Visible("3");
                }

                // 요청 결재 진행중
                if (sCnt != "" && sCnt != "3") {
                    if (sSABUN1 == fshdnLoginSabun) {
                        fn_Btn_Visible("50");
                    }
                }

                // 안전환경팀 및 운영, 관리 관리직은 문서 수정 권한 부여
                if (fsAuth == 'SAFE_MAG' || fsAuth == 'SAFE_OPERA') {
                    fn_Btn_Visible("6");
                }

                // 운영팀 담당자가 로그인하면 확인버튼 활성화
                if (sCnt == "2") {

                    if ($("#svSMOPSABUN_KBSABUN").val() != "") {

                        var sBUSEO = '';

                        var i = 0;

                        var ht2 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                        ht["P_KBSABUN"] = $("#svSMOPSABUN_KBSABUN").val();
                        ht["P_LOGINID"] = fshdnLoginSabun;

                        // 현재 결재할 사람의 부서코드
                        PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_OPERA_BUSEO_CHECK", function (e) {

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                                if (sDATE3 == "") {
                                    fn_Btn_Visible("30");
                                }

                            }
                        }, function (e) {
                        });
                    }
                }
            }
            //}
        }

        // 작업승인 완료
        function fn_Complete_Visible() {

            if (txtSMFSDATE.GetValue()  != "") {
                var sSMOR_BUSEO  = ''; // 요청자   부서코드
                var sLogin_BUSEO = ''; // 로그인자 부서코드

                // 안전환경팀, 작업요청자 동일 부서일 경우
                // 작업요청에 대해 마지막 안전작업 허가서일 경우 허가서가 완료 되었더라도
                // 공사 완료를 체크할 수 있도록 수정.


                var ht  = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
                var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
                var ht2 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["P_KBSABUN"] = txtSMORSABUN.GetValue();

                // 요청자 사람의 부서코드
                PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        // 요청자 부서코드
                        sSMOR_BUSEO = DataSet.Tables[0].Rows[0]["KBBUSEO"];

                        ht1["P_KBSABUN"] = fshdnLoginSabun;

                        // 로그인 부서코드
                        PageMethods.InvokeServiceTable(ht1, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                            var DataSet1 = eval(e);

                            if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                                // 로그인 부서코드
                                sLogin_BUSEO = DataSet1.Tables[0].Rows[0]["KBBUSEO"];

                                if (fsAuth == 'SAFE_MAG' || sSMOR_BUSEO == sLogin_BUSEO) {

                                    ht["P_SMWKTEAM"] = txtSMWKTEAM.GetValue();
                                    ht["P_SMWKDATE"] = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
                                    ht["P_SMWKSEQ"] = Set_Fill3(txtSMWKSEQ.GetValue());

                                    // 작업요청서의 마지막 안전작업허가서일 경우
                                    // 요청자 사람의 부서코드
                                    PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                                        var DataSet2 = eval(e);

                                        if (ObjectCount(DataSet2.Tables[0].Rows) > 0) {

                                            if (datSMWKORAPPDATE.GetValue() == DataSet2.Tables[0].Rows[0]["SMWKORAPPDATE"] &&
                                                Set_Fill3(txtSMWKORSEQ.GetValue()) == Set_Fill3(DataSet2.Tables[0].Rows[0]["SMWKORSEQ"])) {

                                                fn_btnSMFOK_Visible(false, true, true, true, false);

                                                fn_btnSMFSWKCANCEL_Visible(false, true);
                                            }
                                        }
                                    }, function (e) {
                                        // Biz 연결오류
                                        alert('<Ctl:Text runat="server" Description="로딩중 로그인 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                                    });
                                }
                                else {
                                    // 2018-05-11 안전환경팀 요청 점검 후 내용 삭제
                                    if (fsAuth == 'SAFE_OPERA') {
                                        fn_btnSMFOK_Visible(false, true, true, true, false);
                                    }
                                    else {
                                        fn_btnSMFOK_Visible(true, false, true, false, true);
                                    }

                                    fn_btnSMFSWKCANCEL_Visible(false, true);
                                }
                            }
                        }, function (e) {
                            // Biz 연결오류
                            alert('<Ctl:Text runat="server" Description="로딩중 로그인 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        });
                    }
                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" Description="로딩중 로그인 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
            else {
                // 감독자 결재 완료후 누구나 들어와서 완료 가능 함.
                if (txtSMCOAPPDATE.GetValue() != "") {
                    fn_btnSMFOK_Visible(false, true, true, true, false);
                }
                else {
                    fn_btnSMFOK_Visible(false, false, false, true, false);
                }

                fn_btnSMFSWKCANCEL_Visible(true, false);
            }
        }

        // 작업 취소
        function fn_Cancel_Visible() {

            var sSMOR_BUSEO;
            var sLogin_BUSEO;

            if ($("#svSMCNSABUN_KBSABUN").val() != "" && txtSMCNDATE.GetValue() != "" && txtSMCNTIME.GetValue() != "" && txtSMCNREASON.GetValue() != "") {

                fn_btnSMCanCel_Visible(true, false);
            }
            else {

                // 안전감독자 결재전에 작업 취소 가능
                if (txtSMCOAPPDATE.GetValue() == "") {
                    // 작업요청자 결재후 취소 가능
                    if (txtSMORAPPDATE.GetValue() != "") {

                        var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
                        var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                        ht["P_KBSABUN"] = txtSMORSABUN.GetValue();

                        // 로그인 부서코드
                        PageMethods.InvokeServiceTable(ht, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                                // 로그인 부서코드
                                sSMOR_BUSEO = DataSet.Tables[0].Rows[0]["KBBUSEO"];
                            }
                        }, function (e) {
                            // Biz 연결오류
                            alert('<Ctl:Text runat="server" Description="로딩중 로그인 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        });


                        ht1["P_KBSABUN"] = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";

                        // 로그인 부서코드
                        PageMethods.InvokeServiceTable(ht1, "PSM.PSMBiz", "UP_SABUN_GET_BUSEO", function (e) {

                            var DataSet1 = eval(e);

                            if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                                // 로그인 부서코드
                                sLogin_BUSEO = DataSet1.Tables[0].Rows[0]["KBBUSEO"];

                                debugger;

                                if (sSMOR_BUSEO != "" && sLogin_BUSEO != "") {
                                    // 요청자와 같은 팀이 로그인 할 경우 취소 가능
                                    if (sSMOR_BUSEO == sLogin_BUSEO) {
                                        fn_btnSMCanCel_Visible(false, true);
                                    }
                                    else {
                                        fn_btnSMCanCel_Visible(true, false);
                                    }
                                }
                            }
                        }, function (e) {
                            // Biz 연결오류
                            alert('<Ctl:Text runat="server" Description="로딩중 로그인 부서 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        });
                    }
                    else {
                        fn_btnSMCanCel_Visible(true, false);
                    }
                }
                else {
                    fn_btnSMCanCel_Visible(true, false);
                }
            }
        }

        function fn_Btn_Visible(gubun) {

            $("#btnRETRACT").hide();

            if (gubun == '0') {
                $("#btnSign").show();
                $("#btnSave").show();
                $("#btnDel").show();
                $("#btnApproval").show();

                $("#btnCancel").hide();

                svSMSMSABUN.SetDisabled(false);
                $("#btnSafe").hide();

                svSMOPSABUN.SetDisabled(false);
                $("#btnOPerate").hide();
            }

            if (gubun == '1') {
                $("#btnSign").hide();
                $("#btnSave").hide();
                $("#btnDel").hide();
                $("#btnApproval").show();

                $("#btnCancel").hide();

                svSMSMSABUN.SetDisabled(true);
                $("#btnSafe").hide();

                svSMOPSABUN.SetDisabled(true);
                $("#btnOPerate").hide();
            }

            if (gubun == '3') {
                $("#btnSign").hide();
                $("#btnSave").hide();
                $("#btnDel").hide();
                $("#btnApproval").hide();

                $("#btnCancel").hide();

                svSMSMSABUN.SetDisabled(true);
                $("#btnSafe").hide();

                svSMOPSABUN.SetDisabled(true);
                $("#btnOPerate").hide();
            }

            if (gubun == '5') {
                // 결재선지정
                $("#btnSign").show();
                $("#btnSave").hide();
                $("#btnDel").hide();
                $("#btnApproval").show();
                $("#btnCancel").show();

                svSMSMSABUN.SetDisabled(true);
                $("#btnSafe").hide();

                svSMOPSABUN.SetDisabled(true);
                $("#btnOPerate").hide();
            }

            if (gubun == '6') {
                $("#btnSave").show();

                svSMSMSABUN.SetDisabled(false);
                $("#btnSafe").show();

                svSMOPSABUN.SetDisabled(false);
                $("#btnOPerate").show();

                $("#btnSMOT").show();

                $("#btnCancel").hide();
            }

            if (gubun == '7') {
                $("#btnSign").hide();      // 결재선지정
                $("#btnSave").hide();      // 저장
                $("#btnDel").hide();       // 삭제
                $("#btnApproval").show();   // 결재
                $("#btnCancel").hide();    // 반려

                svSMSMSABUN.SetDisabled(true); // 안전환경팀 담당자
                $("#btnSafe").hide();      // 안전환경팀 확인버튼

                svSMOPSABUN.SetDisabled(true);
                $("#btnOPerate").hide();
            }

            if (gubun == '9') {
                svSMSMSABUN.SetDisabled(false);
                $("#btnSafe").hide();

                svSMOPSABUN.SetDisabled(false);
                $("#btnOPerate").hide();

                $("#btnCancel").hide();
            }

            if (gubun == '10') {
                $("#btnSign").show();      // 결재선 지정
                $("#btnSave").show();
                $("#btnDel").show();
                $("#btnApproval").hide(); // 결재

                svSMSMSABUN.SetDisabled(false);
                $("#btnSafe").hide();

                svSMOPSABUN.SetDisabled(false);
                $("#btnOPerate").hide();

                $("#btnCancel").hide();
            }

            if (gubun == '15') {
                $("#btnSign").show();      // 결재선 지정
                $("#btnSave").hide();
                $("#btnDel").hide();
                $("#btnApproval").hide(); // 결재

                svSMSMSABUN.SetDisabled(true);
                $("#btnSafe").hide();

                svSMOPSABUN.SetDisabled(true);
                $("#btnOPerate").hide();

                $("#btnCancel").hide();
            }

            if (gubun == '30') {
                svSMOPSABUN.SetDisabled(true);
                $("#btnOPerate").show();

                $("#btnCancel").hide();
            }

            if (gubun == '50') {
                $("#btnRETRACT").show();

                $("#btnCancel").hide();
            }
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

            if (gubun == 'OR') {
                $("#conBody_ImgSMORPHOTO").attr("src", filepath);
            }

            if (gubun == 'GR') {
                $("#conBody_ImgSMGRPHOTO").attr("src", filepath);
            }

            if (gubun == 'CO') {
                $("#conBody_ImgSMCOPHOTO").attr("src", filepath);
            }
        }

        function fn_BLANK_IMAGE() {
            $("#conBody_ImgSMORPHOTO").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgSMGRPHOTO").attr("src", "/Resources/Framework/blank.gif");
            $("#conBody_ImgSMCOPHOTO").attr("src", "/Resources/Framework/blank.gif");
        }

        function fn_REFERENCE(gubun, sRESABUN, sRENAME) {

            var ht = new Object();

            var REDOCID;
            var REDOCNUM;

            ht["P_REDOCID"]  = '05';
            ht["P_REDOCNUM"] = txtSMWKTEAM.GetValue() + Get_Date(datSMWKDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKSEQ.GetValue()) + Get_Date(datSMWKORAPPDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKORSEQ.GetValue());
            ht["P_RESABUN"]  = fsRESABUN;
            //ht["P_RESABUN"]  = txtRESABUN.GetValue();
            ht["P_RENAME"]   = txtRENAME.GetValue();

            if (gubun == 'INDEX') {
                fsRESABUN = sRESABUN;
                /*txtRESABUN.SetValue(sRESABUN);*/
                txtRENAME.SetValue(sRENAME);
            }

            // WORKORDER 프로시저 등록 및 삭제시 로직 추가하였음(23.07.20)
            if (gubun == 'SAVE') {
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

        function fn_GET_Mail_Sabun(iTotal_Cnt, sNow_Site, sSABUN1, sSABUN2, sSABUN3) {

            var sMail_Send;

            var i = 0;

            i = 0;

            // 요청 결재자
            for (i = parseInt(Set_Fill3(sNow_Site)); i < iTotal_Cnt; i++)
            {
                if (i == 0) // 요청자 결재
                {
                    // 승인자 메일발송
                    sMail_Send = sSABUN2;
                    break;
                }
                else if (i == 1) // 승인자 결재
                {
                    // 현장안전감독자 메일발송
                    sMail_Send = sSABUN3;
                    break;
                }
                else if (i == 2) // 현장안전감독자 결재
                {
                    // 요청자 메일발송
                    sMail_Send = sSABUN1;
                }
            }

            return sMail_Send;
        }

        function Set_Fill2(sFirst) {
            if (sFirst.length == 1) {
                sFirst = "0" + sFirst;
            }
            else if (sFirst.length == 2) {
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

        function Get_Date(sStr) {

            if (sStr == "") return "";
            else return sStr.replace("-", "");
        }

        function Get_Numeric(sStr) {
            if (sStr == "") return "0";
            else return sStr.replace(",", "");
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

                if (txtWORETEAM.GetValue() == sBuseo) {
                    if (iRE_COUNT == fshdnREApproval) {

                        svWOFINISHSABUN.SetDisabled(false);
                        //$("#svWOFINISHSABUN_KBSABUN_img").attr("style", "display:yes");

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
                        //$("#svWOIMMEDSABUN_KBSABUN_img").attr("style", "display:yes");

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



        function fn_Sabun_Field_clear() {
            txtSMORSABUN.SetValue('');
            txtSMORJKCD.SetValue('');
            txtSMORJKCDNM.SetValue('');
            txtSMORNAME.SetValue('');

            txtSMGRSABUN.SetValue('');
            txtSMGRJKCD.SetValue('');
            txtSMGRJKCDNM.SetValue('');
            txtSMGRNAME.SetValue('');

            txtSMCOSABUN.SetValue('');
            txtSMCOJKCD.SetValue('');
            txtSMCOJKCDNM.SetValue('');
            txtSMCONAME.SetValue('');

            fsRESABUN = '';
            txtRENAME.SetValue('');
        }


        // 결재선지정 버튼 이벤트
        function btnSign_Click() {
            var param;

            param = "";

            debugger;

            if (fshdnSafe == 'safe') {
                param += "../POP/SabunMultiChkPopup6.aspx?callback=fn_PopupCallBack&Data_Cnt=4";

                param += "&param1=" + txtSMORSABUN.GetValue();
                param += "&param2=" + txtSMGRSABUN.GetValue();
                param += "&param3=" + $("#svSMSMSABUN_KBSABUN").val();
                param += "&param4=" + txtSMCOSABUN.GetValue();
                param += "&param5=" + fshdnSafe;
                param += "&param6=" + fshdnApprovalSite;
                param += "&param7=" + txtSMSYSTEMCODE1.GetValue();
                param += "&SABUN=" + txtRESABUN.GetValue();
                param += "&NAME=" + txtRENAME.GetValue();
            }
            else {

                param += "../POP/SabunMultiChkPopup6.aspx?callback=fn_PopupCallBack&Data_Cnt=3";

                param += "&param1=" + txtSMORSABUN.GetValue();
                param += "&param2=" + txtSMGRSABUN.GetValue();
                param += "&param3=" + txtSMCOSABUN.GetValue();
                param += "&param5=" + fshdnSafe;
                param += "&param6=" + fshdnApprovalSite;
                param += "&param7=" + txtSMSYSTEMCODE1.GetValue();
                param += "&SABUN=" + fsRESABUN.toString();
                param += "&NAME=" + txtRENAME.GetValue();
            }

            fn_OpenPop(param, 600, 400);
        }

        function fn_PopupCallBack(items, items2) {

            var sabun = "";
            var name = "";

            // 결재요청
            // 필드 클리어
            fn_Sabun_Field_clear(1);

            if (items.length > 0) {

                txtSMORSABUN.SetValue(items[0].data.KBSABUN);
                txtSMORJKCD.SetValue(items[0].data.JKCODE);
                txtSMORJKCDNM.SetValue(items[0].data.CDDESC1);
                txtSMORNAME.SetValue(items[0].data.KBHANGL);
            }

            if (fshdnSafe == 'safe')
            {
                if (items.length > 1) {
                    if (items[1].data.SEQ == 1) {
                        txtSMGRSABUN.SetValue(items[1].data.KBSABUN);
                        txtSMGRJKCD.SetValue(items[1].data.JKCODE);
                        txtSMGRJKCDNM.SetValue(items[1].data.CDDESC1);
                        txtSMGRNAME.SetValue(items[1].data.KBHANGL);
                    }

                    if (items[1].data.SEQ == 2) {
                        $("#svSMSMSABUN_KBSABUN").val(items[1].data.KBSABUN);
                        txtSMSMJKCD.SetValue(items[1].data.JKCODE);
                        txtSMSMJKCDNM.SetValue(items[1].data.CDDESC1);
                        txtSMSMNAME.SetValue(items[1].data.KBHANGL);
                    }

                    if (items[1].data.SEQ == 3) {
                        txtSMCOSABUN.SetValue(items[1].data.KBSABUN);
                        txtSMCOJKCD.SetValue(items[1].data.JKCODE);
                        txtSMCOJKCDNM.SetValue(items[1].data.CDDESC1);
                        txtSMCONAME.SetValue(items[1].data.KBHANGL);
                    }
                }

                if (items.length > 2) {
                    if (items[2].data.SEQ == 2) {
                        $("#svSMSMSABUN_KBSABUN").val(items[2].data.KBSABUN);
                        txtSMSMJKCD.SetValue(items[2].data.JKCODE);
                        txtSMSMJKCDNM.SetValue(items[2].data.CDDESC1);
                        txtSMSMNAME.SetValue(items[2].data.KBHANGL);
                    }

                    if (items[2].data.SEQ == 3) {
                        txtSMCOSABUN.SetValue(items[2].data.KBSABUN);
                        txtSMCOJKCD.SetValue(items[2].data.JKCODE);
                        txtSMCOJKCDNM.SetValue(items[2].data.CDDESC1);
                        txtSMCONAME.SetValue(items[2].data.KBHANGL);
                    }
                }

                if (items.length > 3) {
                    if (items[3].data.SEQ == 3) {
                        txtSMCOSABUN.SetValue(items[3].data.KBSABUN);
                        txtSMCOJKCD.SetValue(items[3].data.JKCODE);
                        txtSMCOJKCDNM.SetValue(items[3].data.CDDESC1);
                        txtSMCONAME.SetValue(items[3].data.KBHANGL);
                    }

                    $("#btnApproval").show();
                }

                fshdnSafe = 'safe';
            }
            else
            {
                if (items.length > 1) {
                    if (items[1].data.SEQ == 1) {
                        txtSMGRSABUN.SetValue(items[1].data.KBSABUN);
                        txtSMGRJKCD.SetValue(items[1].data.JKCODE);
                        txtSMGRJKCDNM.SetValue(items[1].data.CDDESC1);
                        txtSMGRNAME.SetValue(items[1].data.KBHANGL);
                    }

                    if (items[1].data.SEQ == 2) {
                        txtSMCOSABUN.SetValue(items[1].data.KBSABUN);
                        txtSMCOJKCD.SetValue(items[1].data.JKCODE);
                        txtSMCOJKCDNM.SetValue(items[1].data.CDDESC1);
                        txtSMCONAME.SetValue(items[1].data.KBHANGL);
                    }

                    $("#btnApproval").show();
                }

                if (items.length > 2) {
                    if (items[2].data.SEQ == 2) {
                        txtSMCOSABUN.SetValue(items[2].data.KBSABUN);
                        txtSMCOJKCD.SetValue(items[2].data.JKCODE);
                        txtSMCOJKCDNM.SetValue(items[2].data.CDDESC1);
                        txtSMCONAME.SetValue(items[2].data.KBHANGL);
                    }

                    $("#btnApproval").show();
                }

                fshdnSafe = '';
            }

            for (i = 0; i < items2.length; i++) {
                if (sabun.length > 0) {
                    sabun += ",";
                    name += ",";
                }

                sabun += items2[i].data.KBSABUN;
                name += items2[i].data.KBHANGL;
            }

            if (items2.length > 0) {
                fsRESABUN = sabun;
                txtRENAME.SetValue(name);
            }
        }

        function fn_Field_Clear() {

            rdoSMWKMETHOD.SetValue('1');

            $("#svSMREVTEAM_BUSEO").val('');
            $("#svSMREVTEAM_BUSEONM").val('');

            txtSMSUBVEND.SetValue('');
            txtSMSUBPERSON.SetValue('');
            txtSMSUBTEL.SetValue('');

            txtSMWKMAN.SetValue('');

            datSMTADATE1.SetValue("");

            txtSMTATIME1_ST.SetValue('');
            txtSMTATIME1_ED.SetValue('');

            datSMTADATE2.SetValue("");

            txtSMTATIME2_ST.SetValue('');
            txtSMTATIME2_ED.SetValue('');

            // 연장일자
            datSMOTDATE1.SetValue("");

            txtSMOTTIME1_ST.SetValue('');
            txtSMOTTIME1_ED.SetValue('');

            datSMOTDATE2.SetValue("");

            txtSMOTTIME2_ST.SetValue('');
            txtSMOTTIME2_ED.SetValue('');

            // 설비코드
            txtSMSYSTEMCODE1.SetValue('');
            pnlSMSYSTEMCODE1.SetValue('');
            txtSMSYSTEMCODE2.SetValue('');
            pnlSMSYSTEMCODE2.SetValue('');
            txtSMSYSTEMCODE3.SetValue('');
            pnlSMSYSTEMCODE3.SetValue('');
            txtSMSYSTEMCODE4.SetValue('');
            pnlSMSYSTEMCODE4.SetValue('');
            txtSMSYSTEMCODE5.SetValue('');
            pnlSMSYSTEMCODE5.SetValue('');

            txtSMCONNCODE11.SetValue('');
            pnlSMCONNCODE11.SetValue('');
            txtSMCONNCODE12.SetValue('');
            pnlSMCONNCODE12.SetValue('');
            txtSMCONNCODE21.SetValue('');
            pnlSMCONNCODE21.SetValue('');
            txtSMCONNCODE22.SetValue('');
            pnlSMCONNCODE22.SetValue('');
            txtSMCONNCODE31.SetValue('');
            pnlSMCONNCODE31.SetValue('');
            txtSMCONNCODE32.SetValue('');
            pnlSMCONNCODE32.SetValue('');
            txtSMCONNCODE41.SetValue('');
            pnlSMCONNCODE41.SetValue('');
            txtSMCONNCODE42.SetValue('');
            pnlSMCONNCODE42.SetValue('');
            txtSMCONNCODE51.SetValue('');
            pnlSMCONNCODE51.SetValue('');
            txtSMCONNCODE52.SetValue('');
            pnlSMCONNCODE52.SetValue('');

            txtSMAREACODE1.SetValue('');
            txtSMAREACODE2.SetValue('');
            txtSMAREACODE3.SetValue('');
            txtSMAREACODE4.SetValue('');
            txtSMAREACODE5.SetValue('');

            txtSMAREATEXT1.SetValue('');
            txtSMAREATEXT2.SetValue('');
            txtSMAREATEXT3.SetValue('');
            txtSMAREATEXT4.SetValue('');
            txtSMAREATEXT5.SetValue('');

            txtSMMATERTEXT2.SetValue('');

            $('input:checkbox[name="ChkSMNOTE_BURN"]').attr("checked", false);
            $('input:checkbox[name="ChkSMNOTE_SUFF"]').attr("checked", false);
            $('input:checkbox[name="ChkSMNOTE_ELE"]').attr("checked", false);
            $('input:checkbox[name="ChkSMNOTE_FIR"]').attr("checked", false);
            $('input:checkbox[name="ChkSMNOTE_EXP"]').attr("checked", false);
            $('input:checkbox[name="ChkSMNOTE_DROP"]').attr("checked", false);
            $('input:checkbox[name="ChkSMNOTE_LEAK"]').attr("checked", false);
            $('input:checkbox[name="ChkSMNOTE_NARR"]').attr("checked", false);
            $('input:checkbox[name="ChkSMNOTE_COLL"]').attr("checked", false);

            $("#svSMCHKSABUN1_KBSABUN").val('');
            $("#svSMCHKSABUN1_KBHANGL").val('');
            txtSMCHKTIME1_HH.SetValue('');
            txtSMCHKTIME1_MM.SetValue('');
            txtSMCHKOXYGEN1.SetValue('');
            cboSMCHKOXYGENUNIT1.SetValue('1');
            txtSMCHKTOXNUM1.Text = "0";
            cboSMCHKTOXUNIT1.SetValue('1');
            txtSMCHKTOXNUM1DS.Text = "0";
            cboSMCHKTOXUNIT1DS.SetValue('2');
            txtSMCHKTOXNUM1CO2.Text = "0";
            cboSMCHKTOXUNIT1CO2.SetValue('1');
            txtSMCHKTOXNUM1CO.Text = "0";
            cboSMCHKTOXUNIT1CO.SetValue('2');
            txtSMCHKTOXNUM1H2S.Text = "0";
            cboSMCHKTOXUNIT1H2S.SetValue('2');

            $("#svSMCHKSABUN2_KBSABUN").val('');
            $("#svSMCHKSABUN2_KBHANGL").val('');
            txtSMCHKTIME2_HH.SetValue('');
            txtSMCHKTIME2_MM.SetValue('');
            txtSMCHKOXYGEN2.SetValue('');
            cboSMCHKOXYGENUNIT2.SetValue('1');
            txtSMCHKTOXNUM2.Text = "0";
            cboSMCHKTOXUNIT2.SetValue('1');
            txtSMCHKTOXNUM2DS.Text = "0";
            cboSMCHKTOXUNIT2DS.SetValue('2');
            txtSMCHKTOXNUM2CO2.Text = "0";
            cboSMCHKTOXUNIT2CO2.SetValue('1');
            txtSMCHKTOXNUM2CO.Text = "0";
            cboSMCHKTOXUNIT2CO.SetValue('2');
            txtSMCHKTOXNUM2H2S.Text = "0";
            cboSMCHKTOXUNIT2H2S.SetValue('2');

            $("#svSMCHKSABUN3_KBSABUN").val('');
            $("#svSMCHKSABUN3_KBHANGL").val('');
            txtSMCHKTIME3_HH.SetValue('');
            txtSMCHKTIME3_MM.SetValue('');
            txtSMCHKOXYGEN3.SetValue('');
            cboSMCHKOXYGENUNIT3.SetValue('1');
            txtSMCHKTOXNUM3.Text = "0";
            cboSMCHKTOXUNIT3.SetValue('1');
            txtSMCHKTOXNUM3DS.Text = "0";
            cboSMCHKTOXUNIT3DS.SetValue('2');
            txtSMCHKTOXNUM3CO2.Text = "0";
            cboSMCHKTOXUNIT3CO2.SetValue('1');
            txtSMCHKTOXNUM3CO.Text = "0";
            cboSMCHKTOXUNIT3CO.SetValue('2');
            txtSMCHKTOXNUM3H2S.Text = "0";
            cboSMCHKTOXUNIT3H2S.SetValue('2');

            $("#svSMCHKSABUN4_KBSABUN").val('');
            $("#svSMCHKSABUN4_KBHANGL").val('');
            txtSMCHKTIME4_HH.SetValue('');
            txtSMCHKTIME4_MM.SetValue('');
            txtSMCHKOXYGEN4.SetValue('');
            cboSMCHKOXYGENUNIT4.SetValue('1');
            txtSMCHKTOXNUM4.Text = "0";
            cboSMCHKTOXUNIT4.SetValue('1');
            txtSMCHKTOXNUM4DS.Text = "0";
            cboSMCHKTOXUNIT4DS.SetValue('2');
            txtSMCHKTOXNUM4CO2.Text = "0";
            cboSMCHKTOXUNIT4CO2.SetValue('1');
            txtSMCHKTOXNUM4CO.Text = "0";
            cboSMCHKTOXUNIT4CO.SetValue('2');
            txtSMCHKTOXNUM4H2S.Text = "0";
            cboSMCHKTOXUNIT4H2S.SetValue('2');

            $("#svSMCHKSABUN5_KBSABUN").val('');
            $("#svSMCHKSABUN5_KBHANGL").val('');
            txtSMCHKTIME5_HH.SetValue('');
            txtSMCHKTIME5_MM.SetValue('');
            txtSMCHKOXYGEN5.SetValue('');
            cboSMCHKOXYGENUNIT5.SetValue('1');
            txtSMCHKTOXNUM5.Text = "0";
            cboSMCHKTOXUNIT5.SetValue('1');
            txtSMCHKTOXNUM5DS.Text = "0";
            cboSMCHKTOXUNIT5DS.SetValue('2');
            txtSMCHKTOXNUM5CO2.Text = "0";
            cboSMCHKTOXUNIT5CO2.SetValue('1');
            txtSMCHKTOXNUM5CO.Text = "0";
            cboSMCHKTOXUNIT5CO.SetValue('2');
            txtSMCHKTOXNUM5H2S.Text = "0";
            cboSMCHKTOXUNIT5H2S.SetValue('2');

            $("#svSMCHKSABUN6_KBSABUN").val('');
            $("#svSMCHKSABUN6_KBHANGL").val('');
            txtSMCHKTIME6_HH.SetValue('');
            txtSMCHKTIME6_MM.SetValue('');
            txtSMCHKOXYGEN6.SetValue('');
            cboSMCHKOXYGENUNIT6.SetValue('1');
            txtSMCHKTOXNUM6.Text = "0";
            cboSMCHKTOXUNIT6.SetValue('1');
            txtSMCHKTOXNUM6DS.Text = "0";
            cboSMCHKTOXUNIT6DS.SetValue('2');
            txtSMCHKTOXNUM6CO2.Text = "0";
            cboSMCHKTOXUNIT6CO2.SetValue('1');
            txtSMCHKTOXNUM6CO.Text = "0";
            cboSMCHKTOXUNIT6CO.SetValue('2');
            txtSMCHKTOXNUM6H2S.Text = "0";
            cboSMCHKTOXUNIT6H2S.SetValue('2');

            $("#svSMCHKSABUN7_KBSABUN").val('');
            $("#svSMCHKSABUN7_KBHANGL").val('');
            txtSMCHKTIME7_HH.SetValue('');
            txtSMCHKTIME7_MM.SetValue('');
            txtSMCHKOXYGEN7.SetValue('');
            cboSMCHKOXYGENUNIT7.SetValue('1');
            txtSMCHKTOXNUM7.Text = "0";
            cboSMCHKTOXUNIT7.SetValue('1');
            txtSMCHKTOXNUM7DS.Text = "0";
            cboSMCHKTOXUNIT7DS.SetValue('2');
            txtSMCHKTOXNUM7CO2.Text = "0";
            cboSMCHKTOXUNIT7CO2.SetValue('1');
            txtSMCHKTOXNUM7CO.Text = "0";
            cboSMCHKTOXUNIT7CO.SetValue('2');
            txtSMCHKTOXNUM7H2S.Text = "0";
            cboSMCHKTOXUNIT7H2S.SetValue('2');

            $("#svSMCHKSABUN8_KBSABUN").val('');
            $("#svSMCHKSABUN8_KBHANGL").val('');
            txtSMCHKTIME8_HH.SetValue('');
            txtSMCHKTIME8_MM.SetValue('');
            txtSMCHKOXYGEN8.SetValue('');
            cboSMCHKOXYGENUNIT8.SetValue('1');
            txtSMCHKTOXNUM8.Text = "0";
            cboSMCHKTOXUNIT8.SetValue('1');
            txtSMCHKTOXNUM8DS.Text = "0";
            cboSMCHKTOXUNIT8DS.SetValue('2');
            txtSMCHKTOXNUM8CO2.Text = "0";
            cboSMCHKTOXUNIT8CO2.SetValue('1');
            txtSMCHKTOXNUM8CO.Text = "0";
            cboSMCHKTOXUNIT8CO.SetValue('2');
            txtSMCHKTOXNUM8H2S.Text = "0";
            cboSMCHKTOXUNIT8H2S.SetValue('2');

            txtSMORDERTEXT1.SetValue('');

            txtSMORSABUN.SetValue('');
            txtSMORNAME.SetValue('');
            txtSMORJKCDNM.SetValue('');
            txtSMORAPPDATE.SetValue('');
            txtSMORAPPTIME.SetValue('');

            txtSMGRSABUN.SetValue('');
            txtSMGRNAME.SetValue('');
            txtSMGRJKCDNM.SetValue('');
            txtSMGRAPPDATE.SetValue('');
            txtSMGRAPPTIME.SetValue('');

            txtSMCOSABUN.SetValue('');
            txtSMCONAME.SetValue('');
            txtSMCOJKCDNM.SetValue('');
            txtSMCOAPPDATE.SetValue('');
            txtSMCOAPPTIME.SetValue('');

            $("#svSMSMSABUN_KBSABUN").val('');
            $("#svSMSMSABUN_KBHANGL").val('');
            txtSMSMAPPDATE.SetValue('');
            txtSMSMAPPTIME.SetValue('');
            txtSMSMCOMMENT.SetValue('');

            $("#svSMOTAPPSABUN_KBSABUN").val('');
            $("#svSMOTAPPSABUN_KBHANGL").val('');

            $("#svSMFSSABUN_KBSABUN").val('');
            $("#svSMFSSABUN_KBHANGL").val('');

            txtSMFSDATE.SetValue('');
            txtSMFSTIME_HH.SetValue('');
            txtSMFSTIME_MM.SetValue('');
            txtSMFSTIME_SS.SetValue('');

            fsRESABUN = '';
            txtRENAME.SetValue('');
        }
        

        // 결재 버튼 이벤트
        function btnApproval_Click() {

            doDisplay();

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            // 일일 JSA가 먼저 작성 되어야 함.
            ht["P_WKGUBN"]   = "D";
            ht["P_WKTEAM"]   = txtSMWKTEAM.GetValue();
            ht["P_WKDATE"]   = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_WKSEQ"]    = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_COPYDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_JSACHANGE_MASTER_EXISTS", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    fn_Field_Check("APPROVAL");
                }
                else {

                    doDisplay();
                    alert('<Ctl:Text runat="server" Description="일일 JSA를 먼저 작성하세요." Literal="true"></Ctl:Text>');
                }
            }, function (e) {
                alert(e.get_message());
            });

            /*setTimeout("doDisplay()", '5000');*/
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

            debugger;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            // 일일 JSA가 먼저 작성 되어야 함.
            ht["P_WKGUBN"]   = "D";
            ht["P_WKTEAM"]   = txtSMWKTEAM.GetValue();
            ht["P_WKDATE"]   = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_WKSEQ"]    = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_COPYDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_JSACHANGE_MASTER_EXISTS", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {
                    fn_Field_Check("SAVE");
                }
                else {
                    
                    alert('<Ctl:Text runat="server" Description="일일 JSA를 먼저 작성하세요." Literal="true"></Ctl:Text>');
                }
            }, function (e) {
                alert(e.get_message());
            });

            debugger;

            setTimeout("doDisplay()", '3000');
        }

        // 삭제 버튼 이벤트
        function btnDel_Click() {

            debugger;

            doDisplay();

            var ht = new Object();

            ht["P_ATTACH_TYPE"] = "SA";
            ht["P_ATTACH_NO"]   = txtSMWKTEAM.GetValue() + Get_Date(datSMWKDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKSEQ.GetValue()) + Get_Date(datSMWKORAPPDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKORSEQ.GetValue());
            ht["P_SMTEAM"]      = txtSMWKTEAM.GetValue();
            ht["P_SMDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_MASTER_ALL_DEL", function (e) {

                var DataSet = eval(e);

                debugger;

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    debugger;

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

            ht["P_SMSYSTEMCODE1"] = txtSMSYSTEMCODE1.GetValue();
            ht["P_SMSYSTEMCODE2"] = txtSMSYSTEMCODE2.GetValue();
            ht["P_SMSYSTEMCODE3"] = txtSMSYSTEMCODE3.GetValue();
            ht["P_SMSYSTEMCODE4"] = txtSMSYSTEMCODE4.GetValue();
            ht["P_SMSYSTEMCODE5"] = txtSMSYSTEMCODE5.GetValue();

            ht["P_SMWKTEAM"]      = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMWKSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMWKORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_BIN_STATUSMF_CHECK", function (e) {

            }, function (e) {
            });
        }

        // 철회 함수
        function fn_RETRACT_Proc() {

            var sAPNUM = "";
            var sRONUM = "";

            sAPNUM = txtSMWKTEAM.GetValue() + "-" + Get_Date(datSMWKDATE.GetValue().replace("-", "")) + "-" + Set_Fill3(txtSMWKSEQ.GetValue());
            sRONUM = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", "")) + "-" + Set_Fill3(txtSMWKORSEQ.GetValue());
            

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_SMWKTEAM"]      = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMWKSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMWKORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

            ht["P_RTDOCID"]       = "02";
            ht["P_RTDOCNUM"]      = txtSMWKTEAM.GetValue() + Get_Date(datSMWKDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKSEQ.GetValue()) + Get_Date(datSMWKORAPPDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKORSEQ.GetValue());
            ht["P_RTCOMMENT"]     = fsRETRACTCOMMENT;
            ht["P_RTHISAB"]       = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
            ht["P_APNUM"]         = txtSMWKTEAM.GetValue() + Get_Date(datSMWKDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SENDER"]        = txtSMORSABUN.GetValue();
            ht["P_RECEIVER"]      = txtSMORSABUN.GetValue();

            ht["P_SMAREATEXT1"]   = txtSMAREATEXT1.GetValue();

            debugger;

            // 안전작업허가서 철회
            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_RETRACT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        fn_Btn_Visible('3');

                        // 공백이미지
                        fn_BLANK_IMAGE();

                        fn_GET_Display();

                        //// 연장 결재
                        //fn_Get_SMOT_Display();

                        //// SIGN 및 버튼
                        //fn_Get_Sign();

                        //// 조치요구사항 체크박스 Readonly
                        //fn_Chk_SaCode_ReadOnly();


                        //// 현재 요청결재순번
                        //fshdnSOApproval = "0";
                        //// 현재 수신결재순번
                        //fshdnREApproval = "0";

                        fshdnApprovalSite = '';

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재가 철회 되었습니다." Literal="true"></Ctl:Text>');
                    }
                }
            }, function (e) {
            });

        }

        // 반려 함수
        function fn_CANCEL_Proc() {

            var sAPNUM = "";
            var sRONUM = "";

            sAPNUM = txtSMWKTEAM.GetValue() + "-" + Get_Date(datSMWKDATE.GetValue().replace("-", "")) + "-" + Set_Fill3(txtSMWKSEQ.GetValue());
            sRONUM = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", "")) + "-" + Set_Fill3(txtSMWKORSEQ.GetValue());

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_SMWKTEAM"]      = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMWKSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMWKORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());
            ht["P_CANCELCOMMENT"] = fsRETRACTCOMMENT;

            ht["P_APNUM"]         = txtSMWKTEAM.GetValue() + Get_Date(datSMWKDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SENDER"]        = txtSMORSABUN.GetValue();

            ht["P_SMAREATEXT1"]   = txtSMAREATEXT1.GetValue();

            ht["P_ApprovalSite"]  = fshdnApprovalSite;

            // 안전작업허가서 철회
            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_CANCEL", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        fn_Btn_Visible('3');

                        // 공백이미지
                        fn_BLANK_IMAGE();

                        fn_GET_Display();

                        fshdnApprovalSite = '';

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재가 반려 되었습니다." Literal="true"></Ctl:Text>');

                        this.close();
                    }
                }
            }, function (e) {
            });

        }


        function fn_Field_Check(sGUBUN) {

            var sMsg = "";
            var i = 0;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            // 설비코드1
            if (txtSMSYSTEMCODE1.GetValue().toString() != "") {

                if (txtSMSYSTEMCODE1.GetValue().length != 10) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드1을 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 설비코드2
            if (txtSMSYSTEMCODE2.GetValue().toString() != "") {

                if (txtSMSYSTEMCODE2.GetValue().length != 10) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드2를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 설비코드3
            if (txtSMSYSTEMCODE3.GetValue().toString() != "") {

                if (txtSMSYSTEMCODE3.GetValue().length != 10) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드3을 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 설비코드4
            if (txtSMSYSTEMCODE4.GetValue().toString() != "") {

                if (txtSMSYSTEMCODE4.GetValue().length != 10) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드4를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 설비코드5
            if (txtSMSYSTEMCODE5.GetValue().toString() != "") {

                if (txtSMSYSTEMCODE5.GetValue().length != 10) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드5를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 작업구역1
            if (txtSMAREACODE1.GetValue().toString() != "") {
                if (txtSMAREACODE1.GetValue().length != 9) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 구역1을 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 작업구역2
            if (txtSMAREACODE2.GetValue().toString() != "") {
                if (txtSMAREACODE2.GetValue().length != 9) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 구역2를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 작업구역3
            if (txtSMAREACODE3.GetValue().toString() != "") {
                if (txtSMAREACODE3.GetValue().length != 9) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 구역3을 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 작업구역4
            if (txtSMAREACODE4.GetValue().toString() != "") {
                if (txtSMAREACODE4.GetValue().length != 9) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 구역4를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            // 작업구역5
            if (txtSMAREACODE5.GetValue().toString() != "") {
                if (txtSMAREACODE5.GetValue().length != 9) {
                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 구역5를 확인하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            ht["P_SMSMSABUN"]    = $("#svSMSMSABUN_KBSABUN").val();
            ht["P_DATE"]         = datSMWKORAPPDATE.GetValue();
            ht["P_SMREVTEAM"]    = $("#svSMREVTEAM_BUSEO").val();
            ht["P_LOGINID"]      = txtSMORSABUN.GetValue();
            ht["svSMOTAPPSABUN_KBSABUN"] = $("#svSMOTAPPSABUN_KBSABUN").val();
            ht["svSMFSSABUN_KBSABUN"]    = $("#svSMFSSABUN_KBSABUN").val();
            ht["svSMCNSABUN_KBSABUN"]    = $("#svSMCNSABUN_KBSABUN").val();

            ht["P_SMCHKSABUN1"]  = $("#svSMCHKSABUN1_KBSABUN").val();
            ht["P_SMCHKSABUN2"]  = $("#svSMCHKSABUN2_KBSABUN").val();
            ht["P_SMCHKSABUN3"]  = $("#svSMCHKSABUN3_KBSABUN").val();
            ht["P_SMCHKSABUN4"]  = $("#svSMCHKSABUN4_KBSABUN").val();


            ht["P_SMCHKSABUN5"]  = $("#svSMCHKSABUN5_KBSABUN").val();
            ht["P_SMCHKSABUN6"]  = $("#svSMCHKSABUN6_KBSABUN").val();
            ht["P_SMCHKSABUN7"]  = $("#svSMCHKSABUN7_KBSABUN").val();
            ht["P_SMCHKSABUN8"]  = $("#svSMCHKSABUN8_KBSABUN").val();

            ht["P_FXCCODE1"]     = txtSMSYSTEMCODE1.GetValue();
            ht["P_FXCCODE2"]     = txtSMSYSTEMCODE2.GetValue();
            ht["P_FXCCODE3"]     = txtSMSYSTEMCODE3.GetValue();
            ht["P_FXCCODE4"]     = txtSMSYSTEMCODE4.GetValue();
            ht["P_FXCCODE5"]     = txtSMSYSTEMCODE5.GetValue()

            ht["P_L3CODE1"]      = txtSMAREACODE1.GetValue();
            ht["P_L3CODE2"]      = txtSMAREACODE2.GetValue();
            ht["P_L3CODE3"]      = txtSMAREACODE3.GetValue();
            ht["P_L3CODE4"]      = txtSMAREACODE4.GetValue();
            ht["P_L3CODE5"]      = txtSMAREACODE5.GetValue();

            ht["P_801Sabun"]     = $("#sv801_Sabun_KBSABUN").val();
            ht["P_802Sabun"]     = $("#sv802_Sabun_KBSABUN").val();
            ht["P_803Sabun"]     = $("#sv803_Sabun_KBSABUN").val();
            ht["P_804Sabun"]     = $("#sv804_Sabun_KBSABUN").val();
            ht["P_805Sabun"]     = $("#sv805_Sabun_KBSABUN").val();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_FIELDCHECK", function (e) {

                var DataSet = eval(e);

                debugger;

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    debugger;

                    // 결재라인 체크
                    if (txtSMORSABUN.GetValue() == "" || txtSMGRSABUN.GetValue() == "" || txtSMCOSABUN.GetValue() == "") {

                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재선을 확인하세요." Literal="true"></Ctl:Text>');

                        return false;
                    }

                    // 주요작업일 경우 안전환경팀 확인 이후 안전감독자 결재 가능
                    if (sGUBUN == "APPROVAL") {
                        // 주요작업일 경우 안전환경팀 확인 이후 안전감독자 결재 가능
                        if ($("input:checkbox[name=chkSWWKCODE2]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE3]").prop('checked') == true ||
                            $("input:checkbox[name=chkSWWKCODE4]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE5]").prop('checked') == true ||
                            $("input:checkbox[name=chkSWWKCODE7]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE8]").prop('checked') == true ||
                            $("input:checkbox[name=chkSWWKCODE9]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE10]").prop('checked') == true) {

                            if (fshdnApprovalSite == "2") // 승인자까지 결재
                            {
                                if ($("#svSMSMSABUN_KBSABUN").val() == "" || txtSMSMAPPDATE.GetValue() == "" || txtSMSMAPPTIME.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="주요 작업일 경우 안전환경팀 확인 후 결재가 가능합니다." Literal="true"></Ctl:Text>');

                                    return false;
                                }
                            }
                        }

                        // 운영팀 확인(20170706)
                        if (fshdnApprovalSite == "2") // 승인자까지 결재
                        {
                            if ($("#svSMOPSABUN_KBSABUN").val() != "") {
                                if (txtSMOPAPPDATE.GetValue() == "" || txtSMOPAPPTIME.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="운영팀 확인 후 결재가 가능합니다." Literal="true"></Ctl:Text>');

                                    return false;
                                }
                            }
                        }
                    }

                    if (Get_Date(datSMWKORAPPDATE.GetValue().replace("-", "")) == "") {

                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="허가 일자를 입력하세요" Literal="true"></Ctl:Text>');
                        return false;
                    }

                    if (txtSMORSABUN.GetValue() == "") {

                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자를 선택하세요" Literal="true"></Ctl:Text>');
                        return false;
                    }

                    if ($("input:checkbox[name=chkSWWKCODE1]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE2]").prop('checked') == false &&
                        $("input:checkbox[name=chkSWWKCODE3]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE4]").prop('checked') == false &&
                        $("input:checkbox[name=chkSWWKCODE5]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE6]").prop('checked') == false &&
                        $("input:checkbox[name=chkSWWKCODE7]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE8]").prop('checked') == false &&
                        $("input:checkbox[name=chkSWWKCODE9]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE10]").prop('checked') == false) {

                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업을 한가지 이상 선택하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    if ($("input:checkbox[name=chkSWWKCODE1]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE6]").prop('checked') == true) {
                        if ($("input:checkbox[name=chkSWWKCODE2]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE3]").prop('checked') == false &&
                            $("input:checkbox[name=chkSWWKCODE4]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE5]").prop('checked') == false &&
                            $("input:checkbox[name=chkSWWKCODE7]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE8]").prop('checked') == false &&
                            $("input:checkbox[name=chkSWWKCODE9]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE10]").prop('checked') == false) {
                            if ($("#svSMSMSABUN_KBSABUN").val() != "") {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="일반위험, 전기작업의 경우 안전환경팀 확인이 필요하지 않습니다." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }
                    }

                    if ($("input:checkbox[name=chkSWWKCODE2]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE3]").prop('checked') == true ||
                        $("input:checkbox[name=chkSWWKCODE4]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE5]").prop('checked') == true ||
                        $("input:checkbox[name=chkSWWKCODE7]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE8]").prop('checked') == true ||
                        $("input:checkbox[name=chkSWWKCODE9]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE10]").prop('checked') == true) {

                        if ($("#svSMSMSABUN_KBSABUN").val() == "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자를 입력하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                        else {

                            // DB 체크
                            // 1.

                            sMsg = "";
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "1") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        $("#svSMSMSABUN_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                        sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            if (sMsg == "") {
                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }
                    }


                    if (rdoSMWKMETHOD.GetValue() == "") {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 방법을 선택하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    
                    // 협력업체 선택
                    if (rdoSMWKMETHOD.GetValue() == '3') {
                        if (txtSMSUBVEND.GetValue() == "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="협력 업체를 입력하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 작업부서
                    if ($("#svSMREVTEAM_BUSEO").val() == "") {

                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 부서를 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else {

                        // DB 체크
                        // 2.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "2") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    $("#svSMREVTEAM_BUSEONM").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 부서를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }                            
                        }

                        if (sMsg == "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 부서를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (Get_Date(datSMTADATE1.GetValue().replace("-", "")) == "") {

                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 시작일자를 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    if (txtSMTATIME1_ST.GetValue() == "") {

                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="시작 시를 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    if (txtSMTATIME1_ED.GetValue() == "") {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="시작 분을 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    if (Get_Date(datSMTADATE2.GetValue().replace("-", "")) == "") {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 종료일자를 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    if (txtSMTATIME2_ST.GetValue() == "") {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="종료 시를 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    if (txtSMTATIME2_ED.GetValue() == "") {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="종료 분을 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    // 연장허가자
                    if ($("#svSMOTAPPSABUN_KBSABUN").val() != "") {

                        // DB 체크
                        // 3.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "3") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    $("#svSMOTAPPSABUN_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 연장 허가자의 부서가 다릅니다. 연장허가자를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }                            
                        }

                        if (sMsg == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 연장 허가자의 부서가 다릅니다. 연장허가자를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 완료허가자
                    if ($("#svSMFSSABUN_KBSABUN").val() != "") {

                        // DB 체크
                        // 4.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {

                            debugger;
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "4") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    debugger;

                                    $("#svSMFSSABUN_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {
                                    debugger;
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 완료 허가자의 부서가 다릅니다. 완료허가자를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }

                        if (sMsg == "") {
                            debugger;
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 완료 허가자의 부서가 다릅니다. 완료허가자를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 취소사번
                    if ($("#svSMCNSABUN_KBSABUN").val() != "") {

                        // DB 체크
                        // 5.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "5") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    $("#svSMCNSABUN_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 취소자의 부서가 다릅니다. 취소자를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }

                        if (sMsg == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 취소자의 부서가 다릅니다. 취소자를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 점검자1
                    if ($("#svSMCHKSABUN1_KBSABUN").val() != "") {

                        debugger;

                        // DB 체크
                        // 6.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "6") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    $("#svSMCHKSABUN1_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }

                        if (sMsg == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 점검자2
                    if ($("#svSMCHKSABUN2_KBSABUN").val() != "") {

                        // DB 체크
                        // 7.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                        
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "7") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    $("#svSMCHKSABUN2_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }

                        if (sMsg == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 점검자3
                    if ($("#svSMCHKSABUN3_KBSABUN").val() != "") {

                        // DB 체크
                        // 8.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "8") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    $("#svSMCHKSABUN3_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }

                        if (sMsg == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 점검자4
                    if ($("#svSMCHKSABUN4_KBSABUN").val() != "") {

                        // DB 체크
                        // 9.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                        
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "9") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    $("#svSMCHKSABUN4_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }

                        if (sMsg == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 점검자5
                    if ($("#svSMCHKSABUN5_KBSABUN").val() != "") {

                        // DB 체크
                        // 10.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                        
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "10") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    $("#svSMCHKSABUN5_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 점검자를 확인하세요" Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }

                        if (sMsg == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 점검자를 확인하세요" Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 점검자6
                    if ($("#svSMCHKSABUN6_KBSABUN").val() != "") {

                        // DB 체크
                        // 11.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "11") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    $("#svSMCHKSABUN6_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 점검자를 확인하세요" Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }

                        if (sMsg == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 점검자를 확인하세요" Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 점검자7
                    if ($("#svSMCHKSABUN7_KBSABUN").val() != "") {

                        // DB 체크
                        // 12.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "12") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    $("#svSMCHKSABUN7_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 점검자를 확인하세요" Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }

                        if (sMsg == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 점검자를 확인하세요" Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 점검자8
                    if ($("#svSMCHKSABUN8_KBSABUN").val() != "") {

                        // DB 체크
                        // 13.

                        sMsg = "";
                        i = 0;
                        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                            
                            if (DataSet.Tables[0].Rows[i]["GUBUN"] == "13") {
                                if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                    $("#svSMCHKSABUN8_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                    sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                    break;
                                }
                                else {
                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 점검자를 확인하세요" Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }

                        if (sMsg == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 점검자를 확인하세요" Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }


                    var sHOUR  = "";

                    var sSDATE = "";
                    var sSHH   = "";
                    var sSMM   = "";
                    var sSTIME = "";

                    var sEDATE = "";
                    var sEHH   = "";
                    var sEMM   = "";
                    var sETIME = "";

                    var now = new Date();

                    txtSMOPAPPTIME.SetValue(Set_Fill2(now.getHours().toString()) + ':' + Set_Fill2(now.getMinutes().toString()) + ':' + Set_Fill2(now.getSeconds().toString()));

                    // 작업허가 시간 8시간 초과금지
                    sSDATE = Get_Date(datSMTADATE1.GetValue().replace("-", ""));
                    sSHH = Set_Fill2(txtSMTATIME1_ST.GetValue());
                    sSMM = Set_Fill2(txtSMTATIME1_ED.GetValue());

                    sHOUR = sSDATE + sSHH + sSMM;

                    if (parseInt(sSHH) < 12) {
                        sSTIME = sSDATE + (parseInt(sSHH) + 9) + sSMM;
                    }
                    else {
                        sSTIME = sSDATE + (parseInt(sSHH) + 8) + sSMM;
                    }


                    sEDATE = Get_Date(datSMTADATE2.GetValue().replace("-", ""));
                    sEHH = Set_Fill2(txtSMTATIME2_ST.GetValue());
                    sEMM = Set_Fill2(txtSMTATIME2_ED.GetValue());

                    sETIME = sEDATE + sEHH + sEMM;

                    if (parseInt(sETIME) > parseInt(sSTIME)) {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업시간은 8시간을 초과 할 수 없습니다." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    sSTIME = sSDATE + sSHH + sSMM;

                    if (parseInt(sETIME) < parseInt(sSTIME)) {
                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업시간을 확인하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }


                    // 연장예정일자
                    if (Get_Date(datSMOTDATE1.GetValue().replace("-", "")) != "") {

                        if (txtSMOTTIME1_ST.GetValue() == "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 시작 시간을 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }

                        if (txtSMOTTIME1_ED.GetValue() == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 시작 분을 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }

                        if (Get_Date(datSMOTDATE2.GetValue().replace("-", "")) == "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장종료일을 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }

                        if (txtSMOTTIME2_ST.GetValue() == "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 종료 시간을 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }

                        if (txtSMOTTIME2_ED.GetValue() == "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 종료 분을 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }

                        sSDATE = "";
                        sSHH   = "";
                        sSMM   = "";

                        sEDATE = "";
                        sEHH   = "";
                        sEMM   = "";

                        // 연장시간 3시간 미만 초과 금지
                        sSDATE = Get_Date(datSMOTDATE1.GetValue().replace("-", ""));
                        sSHH   = Set_Fill2(txtSMOTTIME1_ST.GetValue());
                        sSMM   = Set_Fill2(txtSMOTTIME1_ED.GetValue());

                        sHOUR = sSDATE + sSHH + sSMM;

                        sSTIME = sSDATE + (parseInt(sSHH) + 3) + sSMM;

                        sEDATE = Get_Date(datSMOTDATE2.GetValue().replace("-", ""));
                        sEHH   = Set_Fill2(txtSMOTTIME2_ST.GetValue());
                        sEMM   = Set_Fill2(txtSMOTTIME2_ED.GetValue());

                        sETIME = sEDATE + sEHH + sEMM;

                        if (parseInt(sETIME) < parseInt(sSTIME)) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 작업시간을 확인하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    // 설비코드
                    if (txtSMSYSTEMCODE1.GetValue() == "") {
                        if (txtSMSYSTEMCODE2.GetValue() != "" || txtSMSYSTEMCODE3.GetValue() != "" || txtSMSYSTEMCODE4.GetValue() != "" || txtSMSYSTEMCODE5.GetValue() != "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비 코드를 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMSYSTEMCODE2.GetValue() == "") {
                        if (txtSMSYSTEMCODE3.GetValue() != "" || txtSMSYSTEMCODE4.GetValue() != "" || txtSMSYSTEMCODE5.GetValue() != "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비 코드를 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMSYSTEMCODE3.GetValue() == "") {
                        if (txtSMSYSTEMCODE4.GetValue() != "" || txtSMSYSTEMCODE5.GetValue() != "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비 코드를 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMSYSTEMCODE4.GetValue() == "") {
                        if (txtSMSYSTEMCODE5.GetValue() != "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비 코드를 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    // 설비코드1
                    if (txtSMSYSTEMCODE1.GetValue() != "") {
                        if (txtSMSYSTEMCODE1.GetValue().length == 10) {

                            // DB 체크
                            // 14.

                            sMsg = "";
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "14") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlSMSYSTEMCODE1.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);

                                        sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드1을 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            if (sMsg == "") {
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

                    // 설비코드2
                    if (txtSMSYSTEMCODE2.GetValue() != "") {
                        if (txtSMSYSTEMCODE2.GetValue().length == 10) {

                            // DB 체크
                            // 15.

                            sMsg = "";
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "15") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlSMSYSTEMCODE2.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);

                                        sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드2를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            if (sMsg == "") {
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

                    // 설비코드3
                    if (txtSMSYSTEMCODE3.GetValue() != "") {
                        if (txtSMSYSTEMCODE3.GetValue().length == 10) {

                            // DB 체크
                            // 16.

                            sMsg = "";
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "16") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlSMSYSTEMCODE3.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);

                                        sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드3을 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            if (sMsg == "") {
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

                    // 설비코드4
                    if (txtSMSYSTEMCODE4.GetValue() != "") {
                        if (txtSMSYSTEMCODE4.GetValue().length == 10) {

                            // DB 체크
                            // 17.

                            sMsg = "";
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "17") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlSMSYSTEMCODE4.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);

                                        sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드4를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            if (sMsg == "") {
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

                    // 설비코드5
                    if (txtSMSYSTEMCODE5.GetValue() != "") {
                        if (txtSMSYSTEMCODE5.GetValue().length == 10) {

                            // DB 체크
                            // 18.

                            sMsg = "";
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "18") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlSMSYSTEMCODE5.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);

                                        sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드5를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            if (sMsg == "") {
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

                    // 구역 코드            
                    if (txtSMAREACODE1.GetValue() == "") {
                        if (txtSMAREACODE2.GetValue() != "" || txtSMAREACODE3.GetValue() != "" || txtSMAREACODE4.GetValue() != "" || txtSMAREACODE5.GetValue() != "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (txtSMAREACODE2.GetValue() == "") {
                        if (txtSMAREACODE3.GetValue() != "" || txtSMAREACODE4.GetValue() != "" || txtSMAREACODE5.GetValue() != "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (txtSMAREACODE3.GetValue() == "") {
                        if (txtSMAREACODE4.GetValue() != "" || txtSMAREACODE5.GetValue() != "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    if (txtSMAREACODE4.GetValue() == "") {
                        if (txtSMAREACODE5.GetValue() != "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 장소 코드1
                    if (txtSMAREACODE1.GetValue() != "") {
                        if (txtSMAREACODE1.GetValue().length == 9) {

                            // DB 체크
                            // 19.

                            sMsg = "";
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "19") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlSMAREACODE1.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);

                                        sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드1을 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            if (sMsg == "") {
                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드1을 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드1을 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 장소 코드2
                    if (txtSMAREACODE2.GetValue() != "") {
                        if (txtSMAREACODE2.GetValue().length == 9) {

                            // DB 체크
                            // 20.

                            sMsg = "";
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "20") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlSMAREACODE2.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);

                                        sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드2를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            if (sMsg == "") {
                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드2를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드2를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 장소 코드3
                    if (txtSMAREACODE3.GetValue() != "") {
                        if (txtSMAREACODE3.GetValue().length == 9) {

                            // DB 체크
                            // 21.

                            sMsg = "";
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "21") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlSMAREACODE3.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);

                                        sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드3을 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            if (sMsg == "") {
                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드3을 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드3을 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 장소 코드4
                    if (txtSMAREACODE4.GetValue() != "") {
                        if (txtSMAREACODE4.GetValue().length == 9) {

                            // DB 체크
                            // 22.

                            sMsg = "";
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "22") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlSMAREACODE4.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);

                                        sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드4를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            if (sMsg == "") {
                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드4를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드4를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    // 장소 코드5
                    if (txtSMAREACODE5.GetValue() != "") {
                        if (txtSMAREACODE5.GetValue().length == 9) {

                            // DB 체크
                            // 23.

                            sMsg = "";
                            i = 0;
                            for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                
                                if (DataSet.Tables[0].Rows[i]["GUBUN"] == "23") {
                                    if (DataSet.Tables[0].Rows[i]["DATA"] != "") {

                                        pnlSMAREACODE5.SetValue(DataSet.Tables[0].Rows[i]["DATA"]);

                                        sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                        break;
                                    }
                                    else {
                                        if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드5를 확인하세요." Literal="true"></Ctl:Text>');
                                        return false;
                                    }
                                }
                            }

                            if (sMsg == "") {
                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드5를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }
                        else {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소 코드5를 확인하세요." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }




                    if (txtSMSYSTEMCODE1.GetValue() != "" && txtSMSYSTEMCODE2.GetValue() != "" && txtSMSYSTEMCODE3.GetValue() != "" && txtSMSYSTEMCODE4.GetValue() != "" && txtSMSYSTEMCODE5.GetValue() != "") {
                        if ((txtSMSYSTEMCODE1.GetValue().substr(0, 1) != txtSMSYSTEMCODE2.GetValue().substr(0, 1)) ||
                            (txtSMSYSTEMCODE1.GetValue().substr(0, 1) != txtSMSYSTEMCODE3.GetValue().substr(0, 1)) ||
                            (txtSMSYSTEMCODE1.GetValue().substr(0, 1) != txtSMSYSTEMCODE4.GetValue().substr(0, 1)) ||
                            (txtSMSYSTEMCODE1.GetValue().substr(0, 1) != txtSMSYSTEMCODE5.GetValue().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMSYSTEMCODE1.GetValue() != "" && txtSMSYSTEMCODE2.GetValue() != "" && txtSMSYSTEMCODE3.GetValue() != "" && txtSMSYSTEMCODE4.GetValue() != "") {
                        if ((txtSMSYSTEMCODE1.GetValue().substr(0, 1) != txtSMSYSTEMCODE2.GetValue().substr(0, 1)) ||
                            (txtSMSYSTEMCODE1.GetValue().substr(0, 1) != txtSMSYSTEMCODE3.GetValue().substr(0, 1)) ||
                            (txtSMSYSTEMCODE1.GetValue().substr(0, 1) != txtSMSYSTEMCODE4.GetValue().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMSYSTEMCODE1.GetValue() != "" && txtSMSYSTEMCODE2.GetValue() != "" && txtSMSYSTEMCODE3.GetValue() != "") {
                        if ((txtSMSYSTEMCODE1.GetValue().substr(0, 1) != txtSMSYSTEMCODE2.GetValue().substr(0, 1)) ||
                            (txtSMSYSTEMCODE1.GetValue().substr(0, 1) != txtSMSYSTEMCODE3.GetValue().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMSYSTEMCODE1.GetValue() != "" && txtSMSYSTEMCODE2.GetValue() != "") {
                        if ((txtSMSYSTEMCODE1.GetValue().substr(0, 1) != txtSMSYSTEMCODE2.GetValue().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="설비코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMAREACODE1.GetValue() != "" && txtSMAREACODE2.GetValue() != "" && txtSMAREACODE3.GetValue() != "" && txtSMAREACODE4.GetValue() != "" && txtSMAREACODE5.GetValue() != "") {
                        if ((txtSMAREACODE1.GetValue().substr(0, 1) != txtSMAREACODE2.GetValue().substr(0, 1)) ||
                            (txtSMAREACODE1.GetValue().substr(0, 1) != txtSMAREACODE3.GetValue().substr(0, 1)) ||
                            (txtSMAREACODE1.GetValue().substr(0, 1) != txtSMAREACODE4.GetValue().substr(0, 1)) ||
                            (txtSMAREACODE1.GetValue().substr(0, 1) != txtSMAREACODE5.GetValue().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMAREACODE1.GetValue() != "" && txtSMAREACODE2.GetValue() != "" && txtSMAREACODE3.GetValue() != "" && txtSMAREACODE4.GetValue() != "") {
                        if ((txtSMAREACODE1.GetValue().substr(0, 1) != txtSMAREACODE2.GetValue().substr(0, 1)) ||
                            (txtSMAREACODE1.GetValue().substr(0, 1) != txtSMAREACODE3.GetValue().substr(0, 1)) ||
                            (txtSMAREACODE1.GetValue().substr(0, 1) != txtSMAREACODE4.GetValue().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMAREACODE1.GetValue() != "" && txtSMAREACODE2.GetValue() != "" && txtSMAREACODE3.GetValue() != "") {
                        if ((txtSMAREACODE1.GetValue().substr(0, 1) != txtSMAREACODE2.GetValue().substr(0, 1)) ||
                            (txtSMAREACODE1.GetValue().substr(0, 1) != txtSMAREACODE3.GetValue().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMAREACODE1.GetValue() != "" && txtSMAREACODE2.GetValue() != "") {
                        if ((txtSMAREACODE1.GetValue().substr(0, 1) != txtSMAREACODE2.GetValue().substr(0, 1))) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    // 설비코드 및 장소
                    if (txtSMSYSTEMCODE1.GetValue() != "" && txtSMAREACODE1.GetValue() != "") {
                        if (txtSMSYSTEMCODE1.GetValue().substr(0, 1) != txtSMAREACODE1.GetValue().substr(0, 1)) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    // 설비코드 및 장소
                    if (txtSMSYSTEMCODE2.GetValue() != "" && txtSMAREACODE2.GetValue() != "") {
                        if (txtSMSYSTEMCODE2.GetValue().substr(0, 1) != txtSMAREACODE2.GetValue().substr(0, 1)) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    // 설비코드 및 장소
                    if (txtSMSYSTEMCODE3.GetValue() != "" && txtSMAREACODE3.GetValue() != "") {
                        if (txtSMSYSTEMCODE3.GetValue().substr(0, 1) != txtSMAREACODE3.GetValue().substr(0, 1)) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    // 설비코드 및 장소
                    if (txtSMSYSTEMCODE4.GetValue() != "" && txtSMAREACODE4.GetValue() != "") {
                        if (txtSMSYSTEMCODE4.GetValue().substr(0, 1) != txtSMAREACODE4.GetValue().substr(0, 1)) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    // 설비코드 및 장소
                    if (txtSMSYSTEMCODE5.GetValue() != "" && txtSMAREACODE5.GetValue() != "") {
                        if (txtSMSYSTEMCODE5.GetValue().substr(0, 1) != txtSMAREACODE5.GetValue().substr(0, 1)) {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="장소코드의 사업부가 일치하지 않습니다." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMAREACODE1.GetValue() != "") {
                        if (txtSMAREATEXT1.GetValue() == "") {

                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="내용1을 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMAREACODE2.GetValue() != "") {
                        if (txtSMAREATEXT2.GetValue() == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="내용2를 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMAREACODE3.GetValue() != "") {
                        if (txtSMAREATEXT3.GetValue() == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="내용3을 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMAREACODE4.GetValue() != "") {
                        if (txtSMAREATEXT4.GetValue() == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="내용4를 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    if (txtSMAREACODE5.GetValue() != "") {
                        if (txtSMAREATEXT5.GetValue() == "") {
                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="내용5를 입력하세요." Literal="true"></Ctl:Text>');

                            return false;
                        }
                    }

                    fn_Clear_SACODE();

                    fn_Clear_DRCODE();

                    if (sGUBUN == "APPROVAL") {
                        // 주요작업일 경우 안전환경팀 확인 이후 안전감독자 결재 가능
                        if ($("input:checkbox[name=chkSWWKCODE2]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE3]").prop('checked') == true ||
                            $("input:checkbox[name=chkSWWKCODE4]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE5]").prop('checked') == true ||
                            $("input:checkbox[name=chkSWWKCODE7]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE8]").prop('checked') == true ||
                            $("input:checkbox[name=chkSWWKCODE9]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE10]").prop('checked') == true) {

                            if (fshdnApprovalSite == "1")
                            {
                                // 100
                                if ($("input:checkbox[name=Chk101_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk101_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk102_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk102_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk103_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk103_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk104_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk104_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk105_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk105_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk106_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk106_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk107_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk107_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk108_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk108_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk109_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk109_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk110_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk110_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk111_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk111_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk112_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk112_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk113_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk113_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk114_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk114_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk115_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk115_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk116_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk116_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }


                                // 200
                                if ($("input:checkbox[name=Chk201_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk201_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk202_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk202_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk203_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk203_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk204_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk204_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk205_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk205_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk206_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk206_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk207_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk207_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk208_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk208_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk209_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk209_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk210_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk210_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk211_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk211_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk212_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk212_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk213_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk213_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk214_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk214_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk215_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk215_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk216_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk216_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk217_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk217_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk218_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk218_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }



                                // 300
                                if ($("input:checkbox[name=Chk301_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk301_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk302_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk302_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk303_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk303_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk304_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk304_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk305_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk305_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk306_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk306_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk307_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk307_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk308_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk308_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk309_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk309_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk310_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk310_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk311_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk311_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk312_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk312_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk313_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk313_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk314_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk314_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }


                                // 400
                                if ($("input:checkbox[name=Chk401_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk401_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk402_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk402_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk403_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk403_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk404_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk404_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk405_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk405_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk406_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk406_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk407_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk407_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk408_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk408_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk409_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk409_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }


                                // 500
                                if ($("input:checkbox[name=Chk501_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk501_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk502_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk502_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk503_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk503_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk504_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk504_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }


                                // 600
                                if ($("input:checkbox[name=Chk601_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk601_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk602_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk602_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk603_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk603_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }


                                // 700
                                if ($("input:checkbox[name=Chk701_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk701_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk702_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk702_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk703_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk703_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk704_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk704_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk705_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk705_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk706_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk706_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk707_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk707_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk708_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk708_SSREVSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }



                            if (fshdnApprovalSite == "2" || fshdnApprovalSite == "3")
                            {
                                // 100
                                if ($("input:checkbox[name=Chk101_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk101_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk102_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk102_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk103_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk103_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk104_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk104_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk105_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk105_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk106_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk106_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk107_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk107_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk108_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk108_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk109_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk109_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk110_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk110_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk111_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk111_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk112_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk112_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk113_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk113_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk114_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk114_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk115_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk115_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk116_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk116_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                // 200
                                if ($("input:checkbox[name=Chk201_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk201_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk202_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk202_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk203_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk203_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk204_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk204_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk205_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk205_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk206_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk206_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk207_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk207_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk208_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk208_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk209_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk209_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk210_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk210_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk211_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk211_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk212_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk212_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk213_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk213_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk214_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk214_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk215_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk215_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk216_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk216_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk217_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk217_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk218_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk218_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                // 300
                                if ($("input:checkbox[name=Chk301_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk301_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk302_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk302_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk303_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk303_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk304_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk304_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk305_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk305_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk306_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk306_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk307_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk307_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk308_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk308_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk309_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk309_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk310_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk310_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk311_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk311_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk312_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk312_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk313_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk313_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk314_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk314_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                // 400
                                if ($("input:checkbox[name=Chk401_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk401_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk402_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk402_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk403_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk403_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk404_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk404_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk405_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk405_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk406_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk406_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk407_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk407_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk408_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk408_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk409_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk409_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                // 500
                                if ($("input:checkbox[name=Chk501_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk501_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk502_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk502_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk503_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk503_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk504_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk504_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                // 600
                                if ($("input:checkbox[name=Chk601_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk601_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk602_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk602_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk603_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk603_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                        

                                // 700
                                if ($("input:checkbox[name=Chk701_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk701_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk702_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk702_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk703_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk703_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk704_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk704_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk705_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk705_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk706_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk706_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk707_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk707_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if ($("input:checkbox[name=Chk708_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk708_SSFIXSEL]").prop('checked') == false) {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }                        
                            }
                        }

                        if ($("input:checkbox[name=chkSWWKCODE10]").prop('checked') == true) {

                            var iCNT = 0;

                            // 지하배관 유무
                            if ($("input:checkbox[name=Chk801_DRYESSEL]").prop('checked') == true) {
                                iCNT++;
                            }

                            if ($("input:checkbox[name=Chk801_DRNOSEL]").prop('checked') == true) {
                                iCNT++;
                            }

                            if ($("input:checkbox[name=Chk801_DRNASEL]").prop('checked') == true) {
                                iCNT++;
                            }


                            if (iCNT > 1 || iCNT == 0) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "굴착작업 - 지하배관 유무를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk801_DRYESSEL]").prop('checked') == true) {
                                if (txt801_Kind.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 종류1을 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if (txt801_Std.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 규격1을 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if (txt801_Depth.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 깊이1을 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                            else {
                                txt801_Kind.SetValue("");
                                txt801_Std.SetValue("");
                                txt801_Depth.SetValue("");
                            }

                            // 확인자1
                            if ($("#sv801_Sabun_KBSABUN").val() == "") {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 확인자1을 입력하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                            else {

                                // DB 체크
                                // 24.

                                sMsg = "";
                                i = 0;
                                for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                    
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "24") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {
                                            $("#sv801_Sabun_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                            sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                            break;
                                        }
                                        else {

                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자1을 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                }

                                if (sMsg == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자1을 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }

                            iCNT = 0;

                            // 소방배관, 배출구 유무
                            if ($("input:checkbox[name=Chk802_DRYESSEL]").prop('checked') == true) {
                                iCNT++;
                            }

                            if ($("input:checkbox[name=Chk802_DRNOSEL]").prop('checked') == true) {
                                iCNT++;
                            }

                            if ($("input:checkbox[name=Chk802_DRNASEL]").prop('checked') == true) {
                                iCNT++;
                            }


                            if (iCNT > 1 || iCNT == 0) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "굴착작업 - 소방배관, 배출구 유무를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                            
                            if ($("input:checkbox[name=Chk802_DRYESSEL]").prop('checked') == true) {
                                if (txt802_Kind.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 종류2를 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if (txt802_Std.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 규격2를 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if (txt802_Depth.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 깊이2를 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                            else {
                                txt802_Kind.SetValue("");
                                txt802_Std.SetValue("");
                                txt802_Depth.SetValue("");
                            }

                            // 확인자2
                            if ($("#sv802_Sabun_KBSABUN").val() == "") {
                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 확인자2를 입력하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                            else {

                                // DB 체크
                                // 25.

                                sMsg = "";
                                i = 0;
                                for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                    
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "25") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {
                                            $("#sv802_Sabun_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                            sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                            break;
                                        }
                                        else {

                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자2를 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                }

                                if (sMsg == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자2를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }




                            iCNT = 0;

                            // 전기동력선 유무
                            if ($("input:checkbox[name=Chk803_DRYESSEL]").prop('checked') == true) {
                                iCNT++;
                            }

                            if ($("input:checkbox[name=Chk803_DRNOSEL]").prop('checked') == true) {
                                iCNT++;
                            }

                            if ($("input:checkbox[name=Chk803_DRNASEL]").prop('checked') == true) {
                                iCNT++;
                            }


                            if (iCNT > 1 || iCNT == 0) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "굴착작업 - 전기동력선 유무를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk803_DRYESSEL]").prop('checked') == true) {
                                if (txt803_Kind.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 종류3을 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if (txt803_Std.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 규격3을 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if (txt803_Depth.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 깊이3을 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                            else {
                                txt803_Kind.SetValue("");
                                txt803_Std.SetValue("");
                                txt803_Depth.SetValue("");
                            }

                            // 확인자3
                            if ($("#sv803_Sabun_KBSABUN").val() == "") {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 확인자3을 입력하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                            else {

                                // DB 체크
                                // 26.

                                sMsg = "";
                                i = 0;
                                for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                    
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "26") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {
                                            $("#sv803_Sabun_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                            sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                            break;
                                        }
                                        else {

                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자3을 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                }

                                if (sMsg == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자3을 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }



                            iCNT = 0;

                            // 제어용 케이블 유무
                            if ($("input:checkbox[name=Chk804_DRYESSEL]").prop('checked') == true) {
                                iCNT++;
                            }

                            if ($("input:checkbox[name=Chk804_DRNOSEL]").prop('checked') == true) {
                                iCNT++;
                            }

                            if ($("input:checkbox[name=Chk804_DRNASEL]").prop('checked') == true) {
                                iCNT++;
                            }


                            if (iCNT > 1 || iCNT == 0) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "굴착작업 - 제어용 케이블 유무를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk804_DRYESSEL]").prop('checked') == true) {
                                if (txt804_Kind.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 종류4를 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if (txt804_Std.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 규격4를 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if (txt804_Depth.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 깊이4를 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                            else {
                                txt804_Kind.SetValue("");
                                txt804_Std.SetValue("");
                                txt804_Depth.SetValue("");
                            }

                            // 확인자4
                            if ($("#sv804_Sabun_KBSABUN").val() == "") {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 확인자4를 입력하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                            else {

                                // DB 체크
                                // 27.

                                sMsg = "";
                                i = 0;
                                for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                    
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "27") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {
                                            $("#sv804_Sabun_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                            sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                            break;
                                        }
                                        else {

                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자4를 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                }

                                if (sMsg == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자4를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }


                            iCNT = 0;

                            // 전화선,접지선 유무
                            if ($("input:checkbox[name=Chk805_DRYESSEL]").prop('checked') == true) {
                                iCNT++;
                            }

                            if ($("input:checkbox[name=Chk805_DRNOSEL]").prop('checked') == true) {
                                iCNT++;
                            }

                            if ($("input:checkbox[name=Chk805_DRNASEL]").prop('checked') == true) {
                                iCNT++;
                            }


                            if (iCNT > 1 || iCNT == 0) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "굴착작업 - 전화선,접지선 유무를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk805_DRYESSEL]").prop('checked') == true) {
                                if (txt805_Kind.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 종류5를 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if (txt805_Std.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 규격5를 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }

                                if (txt805_Depth.GetValue() == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 깊이5를 입력하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                            else {
                                txt805_Kind.SetValue("");
                                txt805_Std.SetValue("");
                                txt805_Depth.SetValue("");
                            }

                            // 확인자5
                            if ($("#sv805_Sabun_KBSABUN").val() == "") {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= " - 굴착작업 - 확인자5를 입력하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                            else {

                                // DB 체크
                                // 28.

                                sMsg = "";
                                i = 0;
                                for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {
                                    
                                    if (DataSet.Tables[0].Rows[i]["GUBUN"] == "28") {
                                        if (DataSet.Tables[0].Rows[i]["DATA"] != "") {
                                            $("#sv805_Sabun_KBHANGL").val(DataSet.Tables[0].Rows[i]["DATA"]);

                                            sMsg = DataSet.Tables[0].Rows[i]["DATA"];
                                            break;
                                        }
                                        else {

                                            if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자5를 확인하세요." Literal="true"></Ctl:Text>');
                                            return false;
                                        }
                                    }
                                }

                                if (sMsg == "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="확인자5를 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }

                        if (fshdnApprovalSite == "1") {

                            if ($("input:checkbox[name=Chk901_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk901_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk902_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk902_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk903_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk903_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk904_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk904_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk905_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk905_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk906_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk906_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk907_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk907_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk908_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk908_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk909_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk909_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk910_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk910_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk911_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk911_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk912_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk912_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk913_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk913_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk914_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk914_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk915_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk915_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk916_SSPUBSEL]").prop('checked') == true && $("input:checkbox[name=Chk916_SSREVSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "검토 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }

                        if (fshdnApprovalSite == "2" || fshdnApprovalSite == "3") {

                            if ($("input:checkbox[name=Chk901_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk901_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk902_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk902_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk903_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk903_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk904_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk904_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk905_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk905_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk906_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk906_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk907_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk907_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk908_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk908_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk909_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk909_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk910_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk910_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk911_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk911_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk912_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk912_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk913_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk913_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk914_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk914_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk915_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk915_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }

                            if ($("input:checkbox[name=Chk916_SSREVSEL]").prop('checked') == true && $("input:checkbox[name=Chk916_SSFIXSEL]").prop('checked') == false) {

                                if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "확인 체크를 확인하세요." Literal="true"></Ctl:Text>');
                                return false;
                            }
                        }

                        // BIN CLEANING 작업인 경우 설비코드 하나만 등록가능
                        if ($("input:checkbox[name=chkSWWKCODE5]").prop('checked') == true) {
                            if (txtSMSYSTEMCODE1.GetValue() != "") {
                                if (txtSMSYSTEMCODE2.GetValue() != "" || txtSMSYSTEMCODE3.GetValue() != "" || txtSMSYSTEMCODE4.GetValue() != "" || txtSMSYSTEMCODE5.GetValue() != "") {

                                    if (sGUBUN.toString() == "APPROVAL") { doDisplay(); }

                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description= "BIN CLEANING 작업시 설비코드는 하나만 등록가능합니다." Literal="true"></Ctl:Text>');

                                    return false;
                                }
                            }
                        }
                    }

                    fn_Save(sGUBUN);

                }

            }, function (e) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="필드 체크 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

        function fn_Save(sGUBUN) {

            var chkSWWKCODE1;
            var chkSWWKCODE2;
            var chkSWWKCODE3;
            var chkSWWKCODE4;
            var chkSWWKCODE5;
            var chkSWWKCODE6;
            var chkSWWKCODE7;
            var chkSWWKCODE8;
            var chkSWWKCODE9;
            var chkSWWKCODE10;

            var Chk801_DRYESSEL;
            var Chk801_DRNOSEL;
            var Chk801_DRNASEL;

            var Chk802_DRYESSEL;
            var Chk802_DRNOSEL;
            var Chk802_DRNASEL;

            var Chk803_DRYESSEL;
            var Chk803_DRNOSEL;
            var Chk803_DRNASEL;

            var Chk804_DRYESSEL;
            var Chk804_DRNOSEL;
            var Chk804_DRNASEL;

            var Chk805_DRYESSEL;
            var Chk805_DRNOSEL;
            var Chk805_DRNASEL;

            var Chk101_SSPUBSEL = "N";
            var Chk102_SSPUBSEL = "N";
            var Chk103_SSPUBSEL = "N";
            var Chk104_SSPUBSEL = "N";
            var Chk105_SSPUBSEL = "N";
            var Chk106_SSPUBSEL = "N";
            var Chk107_SSPUBSEL = "N";
            var Chk108_SSPUBSEL = "N";
            var Chk109_SSPUBSEL = "N";
            var Chk110_SSPUBSEL = "N";
            var Chk111_SSPUBSEL = "N";
            var Chk112_SSPUBSEL = "N";
            var Chk113_SSPUBSEL = "N";
            var Chk114_SSPUBSEL = "N";
            var Chk115_SSPUBSEL = "N";
            var Chk116_SSPUBSEL = "N";
            var Chk101_SSREVSEL = "N";
            var Chk102_SSREVSEL = "N";
            var Chk103_SSREVSEL = "N";
            var Chk104_SSREVSEL = "N";
            var Chk105_SSREVSEL = "N";
            var Chk106_SSREVSEL = "N";
            var Chk107_SSREVSEL = "N";
            var Chk108_SSREVSEL = "N";
            var Chk109_SSREVSEL = "N";
            var Chk110_SSREVSEL = "N";
            var Chk111_SSREVSEL = "N";
            var Chk112_SSREVSEL = "N";
            var Chk113_SSREVSEL = "N";
            var Chk114_SSREVSEL = "N";
            var Chk115_SSREVSEL = "N";
            var Chk116_SSREVSEL = "N";
            var Chk101_SSFIXSEL = "N";
            var Chk102_SSFIXSEL = "N";
            var Chk103_SSFIXSEL = "N";
            var Chk104_SSFIXSEL = "N";
            var Chk105_SSFIXSEL = "N";
            var Chk106_SSFIXSEL = "N";
            var Chk107_SSFIXSEL = "N";
            var Chk108_SSFIXSEL = "N";
            var Chk109_SSFIXSEL = "N";
            var Chk110_SSFIXSEL = "N";
            var Chk111_SSFIXSEL = "N";
            var Chk112_SSFIXSEL = "N";
            var Chk113_SSFIXSEL = "N";
            var Chk114_SSFIXSEL = "N";
            var Chk115_SSFIXSEL = "N";
            var Chk116_SSFIXSEL = "N";
            var Chk201_SSPUBSEL = "N";
            var Chk202_SSPUBSEL = "N";
            var Chk203_SSPUBSEL = "N";
            var Chk204_SSPUBSEL = "N";
            var Chk205_SSPUBSEL = "N";
            var Chk206_SSPUBSEL = "N";
            var Chk207_SSPUBSEL = "N";
            var Chk208_SSPUBSEL = "N";
            var Chk209_SSPUBSEL = "N";
            var Chk210_SSPUBSEL = "N";
            var Chk211_SSPUBSEL = "N";
            var Chk212_SSPUBSEL = "N";
            var Chk213_SSPUBSEL = "N";
            var Chk214_SSPUBSEL = "N";
            var Chk215_SSPUBSEL = "N";
            var Chk216_SSPUBSEL = "N";
            var Chk217_SSPUBSEL = "N";
            var Chk218_SSPUBSEL = "N";
            var Chk201_SSREVSEL = "N";
            var Chk202_SSREVSEL = "N";
            var Chk203_SSREVSEL = "N";
            var Chk204_SSREVSEL = "N";
            var Chk205_SSREVSEL = "N";
            var Chk206_SSREVSEL = "N";
            var Chk207_SSREVSEL = "N";
            var Chk208_SSREVSEL = "N";
            var Chk209_SSREVSEL = "N";
            var Chk210_SSREVSEL = "N";
            var Chk211_SSREVSEL = "N";
            var Chk212_SSREVSEL = "N";
            var Chk213_SSREVSEL = "N";
            var Chk214_SSREVSEL = "N";
            var Chk215_SSREVSEL = "N";
            var Chk216_SSREVSEL = "N";
            var Chk217_SSREVSEL = "N";
            var Chk218_SSREVSEL = "N";
            var Chk201_SSFIXSEL = "N";
            var Chk202_SSFIXSEL = "N";
            var Chk203_SSFIXSEL = "N";
            var Chk204_SSFIXSEL = "N";
            var Chk205_SSFIXSEL = "N";
            var Chk206_SSFIXSEL = "N";
            var Chk207_SSFIXSEL = "N";
            var Chk208_SSFIXSEL = "N";
            var Chk209_SSFIXSEL = "N";
            var Chk210_SSFIXSEL = "N";
            var Chk211_SSFIXSEL = "N";
            var Chk212_SSFIXSEL = "N";
            var Chk213_SSFIXSEL = "N";
            var Chk214_SSFIXSEL = "N";
            var Chk215_SSFIXSEL = "N";
            var Chk216_SSFIXSEL = "N";
            var Chk217_SSFIXSEL = "N";
            var Chk218_SSFIXSEL = "N";
            var Chk301_SSPUBSEL = "N";
            var Chk302_SSPUBSEL = "N";
            var Chk303_SSPUBSEL = "N";
            var Chk304_SSPUBSEL = "N";
            var Chk305_SSPUBSEL = "N";
            var Chk306_SSPUBSEL = "N";
            var Chk307_SSPUBSEL = "N";
            var Chk308_SSPUBSEL = "N";
            var Chk309_SSPUBSEL = "N";
            var Chk310_SSPUBSEL = "N";
            var Chk311_SSPUBSEL = "N";
            var Chk312_SSPUBSEL = "N";
            var Chk313_SSPUBSEL = "N";
            var Chk314_SSPUBSEL = "N";
            var Chk301_SSREVSEL = "N";
            var Chk302_SSREVSEL = "N";
            var Chk303_SSREVSEL = "N";
            var Chk304_SSREVSEL = "N";
            var Chk305_SSREVSEL = "N";
            var Chk306_SSREVSEL = "N";
            var Chk307_SSREVSEL = "N";
            var Chk308_SSREVSEL = "N";
            var Chk309_SSREVSEL = "N";
            var Chk310_SSREVSEL = "N";
            var Chk311_SSREVSEL = "N";
            var Chk312_SSREVSEL = "N";
            var Chk313_SSREVSEL = "N";
            var Chk314_SSREVSEL = "N";
            var Chk301_SSFIXSEL = "N";
            var Chk302_SSFIXSEL = "N";
            var Chk303_SSFIXSEL = "N";
            var Chk304_SSFIXSEL = "N";
            var Chk305_SSFIXSEL = "N";
            var Chk306_SSFIXSEL = "N";
            var Chk307_SSFIXSEL = "N";
            var Chk308_SSFIXSEL = "N";
            var Chk309_SSFIXSEL = "N";
            var Chk310_SSFIXSEL = "N";
            var Chk311_SSFIXSEL = "N";
            var Chk312_SSFIXSEL = "N";
            var Chk313_SSFIXSEL = "N";
            var Chk314_SSFIXSEL = "N";
            var Chk401_SSPUBSEL = "N";
            var Chk402_SSPUBSEL = "N";
            var Chk403_SSPUBSEL = "N";
            var Chk404_SSPUBSEL = "N";
            var Chk405_SSPUBSEL = "N";
            var Chk406_SSPUBSEL = "N";
            var Chk407_SSPUBSEL = "N";
            var Chk408_SSPUBSEL = "N";
            var Chk409_SSPUBSEL = "N";
            var Chk401_SSREVSEL = "N";
            var Chk402_SSREVSEL = "N";
            var Chk403_SSREVSEL = "N";
            var Chk404_SSREVSEL = "N";
            var Chk405_SSREVSEL = "N";
            var Chk406_SSREVSEL = "N";
            var Chk407_SSREVSEL = "N";
            var Chk408_SSREVSEL = "N";
            var Chk409_SSREVSEL = "N";
            var Chk401_SSFIXSEL = "N";
            var Chk402_SSFIXSEL = "N";
            var Chk403_SSFIXSEL = "N";
            var Chk404_SSFIXSEL = "N";
            var Chk405_SSFIXSEL = "N";
            var Chk406_SSFIXSEL = "N";
            var Chk407_SSFIXSEL = "N";
            var Chk408_SSFIXSEL = "N";
            var Chk409_SSFIXSEL = "N";
            var Chk501_SSPUBSEL = "N";
            var Chk502_SSPUBSEL = "N";
            var Chk503_SSPUBSEL = "N";
            var Chk504_SSPUBSEL = "N";
            var Chk501_SSREVSEL = "N";
            var Chk502_SSREVSEL = "N";
            var Chk503_SSREVSEL = "N";
            var Chk504_SSREVSEL = "N";
            var Chk501_SSFIXSEL = "N";
            var Chk502_SSFIXSEL = "N";
            var Chk503_SSFIXSEL = "N";
            var Chk504_SSFIXSEL = "N";
            var Chk601_SSPUBSEL = "N";
            var Chk602_SSPUBSEL = "N";
            var Chk603_SSPUBSEL = "N";
            var Chk601_SSREVSEL = "N";
            var Chk602_SSREVSEL = "N";
            var Chk603_SSREVSEL = "N";
            var Chk601_SSFIXSEL = "N";
            var Chk602_SSFIXSEL = "N";
            var Chk603_SSFIXSEL = "N";
            var Chk701_SSPUBSEL = "N";
            var Chk702_SSPUBSEL = "N";
            var Chk703_SSPUBSEL = "N";
            var Chk704_SSPUBSEL = "N";
            var Chk705_SSPUBSEL = "N";
            var Chk706_SSPUBSEL = "N";
            var Chk707_SSPUBSEL = "N";
            var Chk708_SSPUBSEL = "N";
            var Chk701_SSREVSEL = "N";
            var Chk702_SSREVSEL = "N";
            var Chk703_SSREVSEL = "N";
            var Chk704_SSREVSEL = "N";
            var Chk705_SSREVSEL = "N";
            var Chk706_SSREVSEL = "N";
            var Chk707_SSREVSEL = "N";
            var Chk708_SSREVSEL = "N";
            var Chk701_SSFIXSEL = "N";
            var Chk702_SSFIXSEL = "N";
            var Chk703_SSFIXSEL = "N";
            var Chk704_SSFIXSEL = "N";
            var Chk705_SSFIXSEL = "N";
            var Chk706_SSFIXSEL = "N";
            var Chk707_SSFIXSEL = "N";
            var Chk708_SSFIXSEL = "N";
            var Chk901_SSPUBSEL = "N";
            var Chk902_SSPUBSEL = "N";
            var Chk903_SSPUBSEL = "N";
            var Chk904_SSPUBSEL = "N";
            var Chk905_SSPUBSEL = "N";
            var Chk906_SSPUBSEL = "N";
            var Chk907_SSPUBSEL = "N";
            var Chk908_SSPUBSEL = "N";
            var Chk909_SSPUBSEL = "N";
            var Chk910_SSPUBSEL = "N";
            var Chk911_SSPUBSEL = "N";
            var Chk912_SSPUBSEL = "N";
            var Chk913_SSPUBSEL = "N";
            var Chk914_SSPUBSEL = "N";
            var Chk915_SSPUBSEL = "N";
            var Chk916_SSPUBSEL = "N";
            var Chk901_SSREVSEL = "N";
            var Chk902_SSREVSEL = "N";
            var Chk903_SSREVSEL = "N";
            var Chk904_SSREVSEL = "N";
            var Chk905_SSREVSEL = "N";
            var Chk906_SSREVSEL = "N";
            var Chk907_SSREVSEL = "N";
            var Chk908_SSREVSEL = "N";
            var Chk909_SSREVSEL = "N";
            var Chk910_SSREVSEL = "N";
            var Chk911_SSREVSEL = "N";
            var Chk912_SSREVSEL = "N";
            var Chk913_SSREVSEL = "N";
            var Chk914_SSREVSEL = "N";
            var Chk915_SSREVSEL = "N";
            var Chk916_SSREVSEL = "N";
            var Chk901_SSFIXSEL = "N";
            var Chk902_SSFIXSEL = "N";
            var Chk903_SSFIXSEL = "N";
            var Chk904_SSFIXSEL = "N";
            var Chk905_SSFIXSEL = "N";
            var Chk906_SSFIXSEL = "N";
            var Chk907_SSFIXSEL = "N";
            var Chk908_SSFIXSEL = "N";
            var Chk909_SSFIXSEL = "N";
            var Chk910_SSFIXSEL = "N";
            var Chk911_SSFIXSEL = "N";
            var Chk912_SSFIXSEL = "N";
            var Chk913_SSFIXSEL = "N";
            var Chk914_SSFIXSEL = "N";
            var Chk915_SSFIXSEL = "N";
            var Chk916_SSFIXSEL = "N";

            // 저장 및 결재
            var sSMWKMETHOD  = "";
            var sSMTATIME1   = "";
            var sSMTATIME2   = "";

            var sSMOTTIME1   = "";
            var sSMOTTIME2   = "";

            var sSMNOTE_BURN = "";
            var sSMNOTE_SUFF = "";
            var sSMNOTE_ELE  = "";
            var sSMNOTE_FIR  = "";
            var sSMNOTE_EXP  = "";
            var sSMNOTE_DROP = "";
            var sSMNOTE_LEAK = "";
            var sSMNOTE_NARR = "";
            var sSMNOTE_COLL = "";

            var sSMCHKTIME1  = "";
            var sSMCHKTIME2  = "";
            var sSMCHKTIME3  = "";
            var sSMCHKTIME4  = "";
            var sSMCHKTIME5  = "";
            var sSMCHKTIME6  = "";
            var sSMCHKTIME7  = "";
            var sSMCHKTIME8  = "";

            chkSWWKCODE1  = "N";
            chkSWWKCODE2  = "N";
            chkSWWKCODE3  = "N";
            chkSWWKCODE4  = "N";
            chkSWWKCODE5  = "N";
            chkSWWKCODE6  = "N";
            chkSWWKCODE7  = "N";
            chkSWWKCODE8  = "N";
            chkSWWKCODE9  = "N";
            chkSWWKCODE10 = "N";


            Chk801_DRYESSEL = "N";
            Chk801_DRNOSEL  = "N";
            Chk801_DRNASEL  = "N";

            Chk802_DRYESSEL = "N";
            Chk802_DRNOSEL  = "N";
            Chk802_DRNASEL  = "N";

            Chk803_DRYESSEL = "N";
            Chk803_DRNOSEL  = "N";
            Chk803_DRNASEL  = "N";

            Chk804_DRYESSEL = "N";
            Chk804_DRNOSEL  = "N";
            Chk804_DRNASEL  = "N";

            Chk805_DRYESSEL = "N";
            Chk805_DRNOSEL  = "N";
            Chk805_DRNASEL  = "N";

            if ($("input:checkbox[name=Chk801_DRYESSEL]").prop('checked') == true) {
                Chk801_DRYESSEL = "Y";
            }

            if ($("input:checkbox[name=Chk801_DRNOSEL]").prop('checked') == true) {
                Chk801_DRNOSEL = "Y";
            }

            if ($("input:checkbox[name=Chk801_DRNASEL]").prop('checked') == true) {
                Chk801_DRNASEL = "Y";
            }

            if ($("input:checkbox[name=Chk802_DRYESSEL]").prop('checked') == true) {
                Chk802_DRYESSEL = "Y";
            }

            if ($("input:checkbox[name=Chk802_DRNOSEL]").prop('checked') == true) {
                Chk802_DRNOSEL = "Y";
            }

            if ($("input:checkbox[name=Chk802_DRNASEL]").prop('checked') == true) {
                Chk802_DRNASEL = "Y";
            }

            if ($("input:checkbox[name=Chk803_DRYESSEL]").prop('checked') == true) {
                Chk803_DRYESSEL = "Y";
            }

            if ($("input:checkbox[name=Chk803_DRNOSEL]").prop('checked') == true) {
                Chk803_DRNOSEL = "Y";
            }

            if ($("input:checkbox[name=Chk803_DRNASEL]").prop('checked') == true) {
                Chk803_DRNASEL = "Y";
            }

            if ($("input:checkbox[name=Chk804_DRYESSEL]").prop('checked') == true) {
                Chk804_DRYESSEL = "Y";
            }

            if ($("input:checkbox[name=Chk804_DRNOSEL]").prop('checked') == true) {
                Chk804_DRNOSEL = "Y";
            }

            if ($("input:checkbox[name=Chk804_DRNASEL]").prop('checked') == true) {
                Chk804_DRNASEL = "Y";
            }

            if ($("input:checkbox[name=Chk805_DRYESSEL]").prop('checked') == true) {
                Chk805_DRYESSEL = "Y";
            }

            if ($("input:checkbox[name=Chk805_DRNOSEL]").prop('checked') == true) {
                Chk805_DRNOSEL = "Y";
            }

            if ($("input:checkbox[name=Chk805_DRNASEL]").prop('checked') == true) {
                Chk805_DRNASEL = "Y";
            }



            if ($("input:checkbox[name=chkSWWKCODE1]").prop('checked') == true) {
                chkSWWKCODE1 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE2]").prop('checked') == true) {
                chkSWWKCODE2 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE3]").prop('checked') == true) {
                chkSWWKCODE3 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE4]").prop('checked') == true) {
                chkSWWKCODE4 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE5]").prop('checked') == true) {
                chkSWWKCODE5 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE6]").prop('checked') == true) {
                chkSWWKCODE6 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE7]").prop('checked') == true) {
                chkSWWKCODE7 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE8]").prop('checked') == true) {
                chkSWWKCODE8 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE9]").prop('checked') == true) {
                chkSWWKCODE9 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE10]").prop('checked') == true) {
                chkSWWKCODE10 = "Y";
            }


            sSMWKMETHOD = rdoSMWKMETHOD.GetValue();

            if (txtSMTATIME1_ST.GetValue() != "" && txtSMTATIME1_ED.GetValue() != "") {
                sSMTATIME1 = Set_Fill2(txtSMTATIME1_ST.GetValue()) + Set_Fill2(txtSMTATIME1_ED.GetValue());
            }

            if (txtSMTATIME2_ST.GetValue() != "" && txtSMTATIME2_ED.GetValue() != "") {
                sSMTATIME2 = Set_Fill2(txtSMTATIME2_ST.GetValue()) + Set_Fill2(txtSMTATIME2_ED.GetValue());
            }

            if (txtSMOTTIME1_ST.GetValue() != "" && txtSMOTTIME1_ED.GetValue() != "") {
                sSMOTTIME1 = Set_Fill2(txtSMOTTIME1_ST.GetValue()) + Set_Fill2(txtSMOTTIME1_ED.GetValue());
            }

            if (txtSMOTTIME2_ST.GetValue() != "" && txtSMOTTIME2_ED.GetValue() != "") {
                sSMOTTIME2 = Set_Fill2(txtSMOTTIME2_ST.GetValue()) + Set_Fill2(txtSMOTTIME2_ED.GetValue());
            }

            sSMNOTE_BURN = "N";
            sSMNOTE_SUFF = "N";
            sSMNOTE_ELE  = "N";
            sSMNOTE_FIR  = "N";
            sSMNOTE_EXP  = "N";
            sSMNOTE_DROP = "N";
            sSMNOTE_LEAK = "N";
            sSMNOTE_NARR = "N";
            sSMNOTE_COLL = "N";



            if ($("input:checkbox[name=ChkSMNOTE_BURN]").prop('checked') == true) {
                sSMNOTE_BURN = "Y";
            }
            if ($("input:checkbox[name=ChkSMNOTE_SUFF]").prop('checked') == true) {
                sSMNOTE_SUFF = "Y";
            }
            if ($("input:checkbox[name=ChkSMNOTE_ELE]").prop('checked') == true) {
                sSMNOTE_ELE = "Y";
            }
            if ($("input:checkbox[name=ChkSMNOTE_FIR]").prop('checked') == true) {
                sSMNOTE_FIR = "Y";
            }
            if ($("input:checkbox[name=ChkSMNOTE_EXP]").prop('checked') == true) {
                sSMNOTE_EXP = "Y";
            }
            if ($("input:checkbox[name=ChkSMNOTE_DROP]").prop('checked') == true) {
                sSMNOTE_DROP = "Y";
            }
            if ($("input:checkbox[name=ChkSMNOTE_LEAK]").prop('checked') == true) {
                sSMNOTE_LEAK = "Y";
            }
            if ($("input:checkbox[name=ChkSMNOTE_NARR]").prop('checked') == true) {
                sSMNOTE_NARR = "Y";
            }
            if ($("input:checkbox[name=ChkSMNOTE_COLL]").prop('checked') == true) {
                sSMNOTE_COLL = "Y";
            }

            if ($("input:checkbox[name=Chk101_SSPUBSEL]").prop('checked') == true) { Chk101_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk102_SSPUBSEL]").prop('checked') == true) { Chk102_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk103_SSPUBSEL]").prop('checked') == true) { Chk103_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk104_SSPUBSEL]").prop('checked') == true) { Chk104_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk105_SSPUBSEL]").prop('checked') == true) { Chk105_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk106_SSPUBSEL]").prop('checked') == true) { Chk106_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk107_SSPUBSEL]").prop('checked') == true) { Chk107_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk108_SSPUBSEL]").prop('checked') == true) { Chk108_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk109_SSPUBSEL]").prop('checked') == true) { Chk109_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk110_SSPUBSEL]").prop('checked') == true) { Chk110_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk111_SSPUBSEL]").prop('checked') == true) { Chk111_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk112_SSPUBSEL]").prop('checked') == true) { Chk112_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk113_SSPUBSEL]").prop('checked') == true) { Chk113_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk114_SSPUBSEL]").prop('checked') == true) { Chk114_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk115_SSPUBSEL]").prop('checked') == true) { Chk115_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk116_SSPUBSEL]").prop('checked') == true) { Chk116_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk101_SSREVSEL]").prop('checked') == true) { Chk101_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk102_SSREVSEL]").prop('checked') == true) { Chk102_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk103_SSREVSEL]").prop('checked') == true) { Chk103_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk104_SSREVSEL]").prop('checked') == true) { Chk104_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk105_SSREVSEL]").prop('checked') == true) { Chk105_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk106_SSREVSEL]").prop('checked') == true) { Chk106_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk107_SSREVSEL]").prop('checked') == true) { Chk107_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk108_SSREVSEL]").prop('checked') == true) { Chk108_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk109_SSREVSEL]").prop('checked') == true) { Chk109_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk110_SSREVSEL]").prop('checked') == true) { Chk110_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk111_SSREVSEL]").prop('checked') == true) { Chk111_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk112_SSREVSEL]").prop('checked') == true) { Chk112_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk113_SSREVSEL]").prop('checked') == true) { Chk113_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk114_SSREVSEL]").prop('checked') == true) { Chk114_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk115_SSREVSEL]").prop('checked') == true) { Chk115_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk116_SSREVSEL]").prop('checked') == true) { Chk116_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk101_SSFIXSEL]").prop('checked') == true) { Chk101_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk102_SSFIXSEL]").prop('checked') == true) { Chk102_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk103_SSFIXSEL]").prop('checked') == true) { Chk103_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk104_SSFIXSEL]").prop('checked') == true) { Chk104_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk105_SSFIXSEL]").prop('checked') == true) { Chk105_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk106_SSFIXSEL]").prop('checked') == true) { Chk106_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk107_SSFIXSEL]").prop('checked') == true) { Chk107_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk108_SSFIXSEL]").prop('checked') == true) { Chk108_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk109_SSFIXSEL]").prop('checked') == true) { Chk109_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk110_SSFIXSEL]").prop('checked') == true) { Chk110_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk111_SSFIXSEL]").prop('checked') == true) { Chk111_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk112_SSFIXSEL]").prop('checked') == true) { Chk112_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk113_SSFIXSEL]").prop('checked') == true) { Chk113_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk114_SSFIXSEL]").prop('checked') == true) { Chk114_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk115_SSFIXSEL]").prop('checked') == true) { Chk115_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk116_SSFIXSEL]").prop('checked') == true) { Chk116_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk201_SSPUBSEL]").prop('checked') == true) { Chk201_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk202_SSPUBSEL]").prop('checked') == true) { Chk202_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk203_SSPUBSEL]").prop('checked') == true) { Chk203_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk204_SSPUBSEL]").prop('checked') == true) { Chk204_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk205_SSPUBSEL]").prop('checked') == true) { Chk205_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk206_SSPUBSEL]").prop('checked') == true) { Chk206_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk207_SSPUBSEL]").prop('checked') == true) { Chk207_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk208_SSPUBSEL]").prop('checked') == true) { Chk208_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk209_SSPUBSEL]").prop('checked') == true) { Chk209_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk210_SSPUBSEL]").prop('checked') == true) { Chk210_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk211_SSPUBSEL]").prop('checked') == true) { Chk211_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk212_SSPUBSEL]").prop('checked') == true) { Chk212_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk213_SSPUBSEL]").prop('checked') == true) { Chk213_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk214_SSPUBSEL]").prop('checked') == true) { Chk214_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk215_SSPUBSEL]").prop('checked') == true) { Chk215_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk216_SSPUBSEL]").prop('checked') == true) { Chk216_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk217_SSPUBSEL]").prop('checked') == true) { Chk217_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk218_SSPUBSEL]").prop('checked') == true) { Chk218_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk201_SSREVSEL]").prop('checked') == true) { Chk201_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk202_SSREVSEL]").prop('checked') == true) { Chk202_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk203_SSREVSEL]").prop('checked') == true) { Chk203_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk204_SSREVSEL]").prop('checked') == true) { Chk204_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk205_SSREVSEL]").prop('checked') == true) { Chk205_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk206_SSREVSEL]").prop('checked') == true) { Chk206_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk207_SSREVSEL]").prop('checked') == true) { Chk207_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk208_SSREVSEL]").prop('checked') == true) { Chk208_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk209_SSREVSEL]").prop('checked') == true) { Chk209_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk210_SSREVSEL]").prop('checked') == true) { Chk210_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk211_SSREVSEL]").prop('checked') == true) { Chk211_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk212_SSREVSEL]").prop('checked') == true) { Chk212_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk213_SSREVSEL]").prop('checked') == true) { Chk213_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk214_SSREVSEL]").prop('checked') == true) { Chk214_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk215_SSREVSEL]").prop('checked') == true) { Chk215_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk216_SSREVSEL]").prop('checked') == true) { Chk216_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk217_SSREVSEL]").prop('checked') == true) { Chk217_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk218_SSREVSEL]").prop('checked') == true) { Chk218_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk201_SSFIXSEL]").prop('checked') == true) { Chk201_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk202_SSFIXSEL]").prop('checked') == true) { Chk202_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk203_SSFIXSEL]").prop('checked') == true) { Chk203_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk204_SSFIXSEL]").prop('checked') == true) { Chk204_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk205_SSFIXSEL]").prop('checked') == true) { Chk205_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk206_SSFIXSEL]").prop('checked') == true) { Chk206_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk207_SSFIXSEL]").prop('checked') == true) { Chk207_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk208_SSFIXSEL]").prop('checked') == true) { Chk208_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk209_SSFIXSEL]").prop('checked') == true) { Chk209_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk210_SSFIXSEL]").prop('checked') == true) { Chk210_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk211_SSFIXSEL]").prop('checked') == true) { Chk211_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk212_SSFIXSEL]").prop('checked') == true) { Chk212_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk213_SSFIXSEL]").prop('checked') == true) { Chk213_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk214_SSFIXSEL]").prop('checked') == true) { Chk214_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk215_SSFIXSEL]").prop('checked') == true) { Chk215_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk216_SSFIXSEL]").prop('checked') == true) { Chk216_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk217_SSFIXSEL]").prop('checked') == true) { Chk217_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk218_SSFIXSEL]").prop('checked') == true) { Chk218_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk301_SSPUBSEL]").prop('checked') == true) { Chk301_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk302_SSPUBSEL]").prop('checked') == true) { Chk302_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk303_SSPUBSEL]").prop('checked') == true) { Chk303_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk304_SSPUBSEL]").prop('checked') == true) { Chk304_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk305_SSPUBSEL]").prop('checked') == true) { Chk305_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk306_SSPUBSEL]").prop('checked') == true) { Chk306_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk307_SSPUBSEL]").prop('checked') == true) { Chk307_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk308_SSPUBSEL]").prop('checked') == true) { Chk308_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk309_SSPUBSEL]").prop('checked') == true) { Chk309_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk310_SSPUBSEL]").prop('checked') == true) { Chk310_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk311_SSPUBSEL]").prop('checked') == true) { Chk311_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk312_SSPUBSEL]").prop('checked') == true) { Chk312_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk313_SSPUBSEL]").prop('checked') == true) { Chk313_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk314_SSPUBSEL]").prop('checked') == true) { Chk314_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk301_SSREVSEL]").prop('checked') == true) { Chk301_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk302_SSREVSEL]").prop('checked') == true) { Chk302_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk303_SSREVSEL]").prop('checked') == true) { Chk303_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk304_SSREVSEL]").prop('checked') == true) { Chk304_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk305_SSREVSEL]").prop('checked') == true) { Chk305_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk306_SSREVSEL]").prop('checked') == true) { Chk306_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk307_SSREVSEL]").prop('checked') == true) { Chk307_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk308_SSREVSEL]").prop('checked') == true) { Chk308_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk309_SSREVSEL]").prop('checked') == true) { Chk309_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk310_SSREVSEL]").prop('checked') == true) { Chk310_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk311_SSREVSEL]").prop('checked') == true) { Chk311_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk312_SSREVSEL]").prop('checked') == true) { Chk312_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk313_SSREVSEL]").prop('checked') == true) { Chk313_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk314_SSREVSEL]").prop('checked') == true) { Chk314_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk301_SSFIXSEL]").prop('checked') == true) { Chk301_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk302_SSFIXSEL]").prop('checked') == true) { Chk302_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk303_SSFIXSEL]").prop('checked') == true) { Chk303_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk304_SSFIXSEL]").prop('checked') == true) { Chk304_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk305_SSFIXSEL]").prop('checked') == true) { Chk305_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk306_SSFIXSEL]").prop('checked') == true) { Chk306_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk307_SSFIXSEL]").prop('checked') == true) { Chk307_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk308_SSFIXSEL]").prop('checked') == true) { Chk308_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk309_SSFIXSEL]").prop('checked') == true) { Chk309_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk310_SSFIXSEL]").prop('checked') == true) { Chk310_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk311_SSFIXSEL]").prop('checked') == true) { Chk311_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk312_SSFIXSEL]").prop('checked') == true) { Chk312_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk313_SSFIXSEL]").prop('checked') == true) { Chk313_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk314_SSFIXSEL]").prop('checked') == true) { Chk314_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk401_SSPUBSEL]").prop('checked') == true) { Chk401_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk402_SSPUBSEL]").prop('checked') == true) { Chk402_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk403_SSPUBSEL]").prop('checked') == true) { Chk403_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk404_SSPUBSEL]").prop('checked') == true) { Chk404_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk405_SSPUBSEL]").prop('checked') == true) { Chk405_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk406_SSPUBSEL]").prop('checked') == true) { Chk406_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk407_SSPUBSEL]").prop('checked') == true) { Chk407_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk408_SSPUBSEL]").prop('checked') == true) { Chk408_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk409_SSPUBSEL]").prop('checked') == true) { Chk409_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk401_SSREVSEL]").prop('checked') == true) { Chk401_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk402_SSREVSEL]").prop('checked') == true) { Chk402_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk403_SSREVSEL]").prop('checked') == true) { Chk403_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk404_SSREVSEL]").prop('checked') == true) { Chk404_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk405_SSREVSEL]").prop('checked') == true) { Chk405_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk406_SSREVSEL]").prop('checked') == true) { Chk406_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk407_SSREVSEL]").prop('checked') == true) { Chk407_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk408_SSREVSEL]").prop('checked') == true) { Chk408_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk409_SSREVSEL]").prop('checked') == true) { Chk409_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk401_SSFIXSEL]").prop('checked') == true) { Chk401_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk402_SSFIXSEL]").prop('checked') == true) { Chk402_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk403_SSFIXSEL]").prop('checked') == true) { Chk403_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk404_SSFIXSEL]").prop('checked') == true) { Chk404_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk405_SSFIXSEL]").prop('checked') == true) { Chk405_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk406_SSFIXSEL]").prop('checked') == true) { Chk406_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk407_SSFIXSEL]").prop('checked') == true) { Chk407_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk408_SSFIXSEL]").prop('checked') == true) { Chk408_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk409_SSFIXSEL]").prop('checked') == true) { Chk409_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk501_SSPUBSEL]").prop('checked') == true) { Chk501_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk502_SSPUBSEL]").prop('checked') == true) { Chk502_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk503_SSPUBSEL]").prop('checked') == true) { Chk503_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk504_SSPUBSEL]").prop('checked') == true) { Chk504_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk501_SSREVSEL]").prop('checked') == true) { Chk501_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk502_SSREVSEL]").prop('checked') == true) { Chk502_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk503_SSREVSEL]").prop('checked') == true) { Chk503_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk504_SSREVSEL]").prop('checked') == true) { Chk504_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk501_SSFIXSEL]").prop('checked') == true) { Chk501_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk502_SSFIXSEL]").prop('checked') == true) { Chk502_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk503_SSFIXSEL]").prop('checked') == true) { Chk503_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk504_SSFIXSEL]").prop('checked') == true) { Chk504_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk601_SSPUBSEL]").prop('checked') == true) { Chk601_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk602_SSPUBSEL]").prop('checked') == true) { Chk602_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk603_SSPUBSEL]").prop('checked') == true) { Chk603_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk601_SSREVSEL]").prop('checked') == true) { Chk601_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk602_SSREVSEL]").prop('checked') == true) { Chk602_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk603_SSREVSEL]").prop('checked') == true) { Chk603_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk601_SSFIXSEL]").prop('checked') == true) { Chk601_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk602_SSFIXSEL]").prop('checked') == true) { Chk602_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk603_SSFIXSEL]").prop('checked') == true) { Chk603_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk701_SSPUBSEL]").prop('checked') == true) { Chk701_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk702_SSPUBSEL]").prop('checked') == true) { Chk702_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk703_SSPUBSEL]").prop('checked') == true) { Chk703_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk704_SSPUBSEL]").prop('checked') == true) { Chk704_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk705_SSPUBSEL]").prop('checked') == true) { Chk705_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk706_SSPUBSEL]").prop('checked') == true) { Chk706_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk707_SSPUBSEL]").prop('checked') == true) { Chk707_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk708_SSPUBSEL]").prop('checked') == true) { Chk708_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk701_SSREVSEL]").prop('checked') == true) { Chk701_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk702_SSREVSEL]").prop('checked') == true) { Chk702_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk703_SSREVSEL]").prop('checked') == true) { Chk703_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk704_SSREVSEL]").prop('checked') == true) { Chk704_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk705_SSREVSEL]").prop('checked') == true) { Chk705_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk706_SSREVSEL]").prop('checked') == true) { Chk706_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk707_SSREVSEL]").prop('checked') == true) { Chk707_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk708_SSREVSEL]").prop('checked') == true) { Chk708_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk701_SSFIXSEL]").prop('checked') == true) { Chk701_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk702_SSFIXSEL]").prop('checked') == true) { Chk702_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk703_SSFIXSEL]").prop('checked') == true) { Chk703_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk704_SSFIXSEL]").prop('checked') == true) { Chk704_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk705_SSFIXSEL]").prop('checked') == true) { Chk705_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk706_SSFIXSEL]").prop('checked') == true) { Chk706_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk707_SSFIXSEL]").prop('checked') == true) { Chk707_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk708_SSFIXSEL]").prop('checked') == true) { Chk708_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk901_SSPUBSEL]").prop('checked') == true) { Chk901_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk902_SSPUBSEL]").prop('checked') == true) { Chk902_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk903_SSPUBSEL]").prop('checked') == true) { Chk903_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk904_SSPUBSEL]").prop('checked') == true) { Chk904_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk905_SSPUBSEL]").prop('checked') == true) { Chk905_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk906_SSPUBSEL]").prop('checked') == true) { Chk906_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk907_SSPUBSEL]").prop('checked') == true) { Chk907_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk908_SSPUBSEL]").prop('checked') == true) { Chk908_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk909_SSPUBSEL]").prop('checked') == true) { Chk909_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk910_SSPUBSEL]").prop('checked') == true) { Chk910_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk911_SSPUBSEL]").prop('checked') == true) { Chk911_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk912_SSPUBSEL]").prop('checked') == true) { Chk912_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk913_SSPUBSEL]").prop('checked') == true) { Chk913_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk914_SSPUBSEL]").prop('checked') == true) { Chk914_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk915_SSPUBSEL]").prop('checked') == true) { Chk915_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk916_SSPUBSEL]").prop('checked') == true) { Chk916_SSPUBSEL = "Y"; }
            if ($("input:checkbox[name=Chk901_SSREVSEL]").prop('checked') == true) { Chk901_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk902_SSREVSEL]").prop('checked') == true) { Chk902_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk903_SSREVSEL]").prop('checked') == true) { Chk903_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk904_SSREVSEL]").prop('checked') == true) { Chk904_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk905_SSREVSEL]").prop('checked') == true) { Chk905_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk906_SSREVSEL]").prop('checked') == true) { Chk906_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk907_SSREVSEL]").prop('checked') == true) { Chk907_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk908_SSREVSEL]").prop('checked') == true) { Chk908_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk909_SSREVSEL]").prop('checked') == true) { Chk909_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk910_SSREVSEL]").prop('checked') == true) { Chk910_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk911_SSREVSEL]").prop('checked') == true) { Chk911_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk912_SSREVSEL]").prop('checked') == true) { Chk912_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk913_SSREVSEL]").prop('checked') == true) { Chk913_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk914_SSREVSEL]").prop('checked') == true) { Chk914_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk915_SSREVSEL]").prop('checked') == true) { Chk915_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk916_SSREVSEL]").prop('checked') == true) { Chk916_SSREVSEL = "Y"; }
            if ($("input:checkbox[name=Chk901_SSFIXSEL]").prop('checked') == true) { Chk901_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk902_SSFIXSEL]").prop('checked') == true) { Chk902_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk903_SSFIXSEL]").prop('checked') == true) { Chk903_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk904_SSFIXSEL]").prop('checked') == true) { Chk904_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk905_SSFIXSEL]").prop('checked') == true) { Chk905_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk906_SSFIXSEL]").prop('checked') == true) { Chk906_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk907_SSFIXSEL]").prop('checked') == true) { Chk907_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk908_SSFIXSEL]").prop('checked') == true) { Chk908_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk909_SSFIXSEL]").prop('checked') == true) { Chk909_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk910_SSFIXSEL]").prop('checked') == true) { Chk910_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk911_SSFIXSEL]").prop('checked') == true) { Chk911_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk912_SSFIXSEL]").prop('checked') == true) { Chk912_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk913_SSFIXSEL]").prop('checked') == true) { Chk913_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk914_SSFIXSEL]").prop('checked') == true) { Chk914_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk915_SSFIXSEL]").prop('checked') == true) { Chk915_SSFIXSEL = "Y"; }
            if ($("input:checkbox[name=Chk916_SSFIXSEL]").prop('checked') == true) { Chk916_SSFIXSEL = "Y"; }

            if (txtSMCHKTIME1_HH.GetValue() != "" && txtSMCHKTIME1_MM.GetValue() != "") {
                sSMCHKTIME1 = Set_Fill2(txtSMCHKTIME1_HH.GetValue()) + Set_Fill2(txtSMCHKTIME1_MM.GetValue());
            }

            if (txtSMCHKTIME2_HH.GetValue() != "" && txtSMCHKTIME2_MM.GetValue() != "") {
                sSMCHKTIME2 = Set_Fill2(txtSMCHKTIME2_HH.GetValue()) + Set_Fill2(txtSMCHKTIME2_MM.GetValue());
            }

            if (txtSMCHKTIME3_HH.GetValue() != "" && txtSMCHKTIME3_MM.GetValue() != "") {
                sSMCHKTIME3 = Set_Fill2(txtSMCHKTIME3_HH.GetValue()) + Set_Fill2(txtSMCHKTIME3_MM.GetValue());
            }

            if (txtSMCHKTIME4_HH.GetValue() != "" && txtSMCHKTIME4_MM.GetValue() != "") {
                sSMCHKTIME4 = Set_Fill2(txtSMCHKTIME4_HH.GetValue()) + Set_Fill2(txtSMCHKTIME4_MM.GetValue());
            }


            if (txtSMCHKTIME5_HH.GetValue() != "" && txtSMCHKTIME5_MM.GetValue() != "") {
                sSMCHKTIME5 = Set_Fill2(txtSMCHKTIME5_HH.GetValue()) + Set_Fill2(txtSMCHKTIME5_MM.GetValue());
            }

            if (txtSMCHKTIME6_HH.GetValue() != "" && txtSMCHKTIME6_MM.GetValue() != "") {
                sSMCHKTIME6 = Set_Fill2(txtSMCHKTIME6_HH.GetValue()) + Set_Fill2(txtSMCHKTIME6_MM.GetValue());
            }

            if (txtSMCHKTIME7_HH.GetValue() != "" && txtSMCHKTIME7_MM.GetValue() != "") {
                sSMCHKTIME7 = Set_Fill2(txtSMCHKTIME7_HH.GetValue()) + Set_Fill2(txtSMCHKTIME7_MM.GetValue());
            }

            if (txtSMCHKTIME8_HH.GetValue() != "" && txtSMCHKTIME8_MM.GetValue() != "") {
                sSMCHKTIME8 = Set_Fill2(txtSMCHKTIME8_HH.GetValue()) + Set_Fill2(txtSMCHKTIME8_MM.GetValue());
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_SMWKTEAM"] = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"] = datSMWKDATE.GetValue().replace("-", "");
            ht["P_SMWKSEQ"] = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"] = datSMWKORAPPDATE.GetValue().replace("-", "");
            ht["P_SMWKORSEQ"] = Set_Fill3(txtSMWKORSEQ.GetValue());
            ht["P_SMREVTEAM"] = $("#svSMREVTEAM_BUSEO").val();
            ht["P_SMWKMETHOD"] = sSMWKMETHOD;
            ht["P_SMSUBVEND"] = txtSMSUBVEND.GetValue();
            ht["P_SMSUBPERSON"] = txtSMSUBPERSON.GetValue();
            ht["P_SMSUBTEL"] = txtSMSUBTEL.GetValue();
            ht["P_SMRESSABUN"] = "";                                                // 책임사번;
            ht["P_SMWKMAN"] = txtSMWKMAN.GetValue();
            ht["P_SMTADATE1"] = datSMTADATE1.GetValue().replace("-", "");
            ht["P_SMTATIME1"] = sSMTATIME1;
            ht["P_SMTADATE2"] = datSMTADATE2.GetValue().replace("-", "");
            ht["P_SMTATIME2"] = sSMTATIME2;
            ht["P_SMOTDATE1"] = datSMOTDATE1.GetValue().replace("-", "");
            ht["P_SMOTTIME1"] = sSMOTTIME1;
            ht["P_SMOTDATE2"] = datSMOTDATE2.GetValue().replace("-", "");
            ht["P_SMOTTIME2"] = sSMOTTIME2;
            ht["P_SMOTAPPSABUN"] = $("#svSMOTAPPSABUN_KBSABUN").val();                // 연장승인자;
            ht["P_SMSYSTEMCODE1"] = txtSMSYSTEMCODE1.GetValue();
            ht["P_SMSYSTEMCODE2"] = txtSMSYSTEMCODE2.GetValue();
            ht["P_SMSYSTEMCODE3"] = txtSMSYSTEMCODE3.GetValue();
            ht["P_SMSYSTEMCODE4"] = txtSMSYSTEMCODE4.GetValue();
            ht["P_SMSYSTEMCODE5"] = txtSMSYSTEMCODE5.GetValue();
            ht["P_SMCONNCODE11"] = txtSMCONNCODE11.GetValue();
            ht["P_SMCONNCODE12"] = txtSMCONNCODE12.GetValue();
            ht["P_SMCONNCODE21"] = txtSMCONNCODE21.GetValue();
            ht["P_SMCONNCODE22"] = txtSMCONNCODE22.GetValue();
            ht["P_SMCONNCODE31"] = txtSMCONNCODE31.GetValue();
            ht["P_SMCONNCODE32"] = txtSMCONNCODE32.GetValue();
            ht["P_SMCONNCODE41"] = txtSMCONNCODE41.GetValue();
            ht["P_SMCONNCODE42"] = txtSMCONNCODE42.GetValue();
            ht["P_SMCONNCODE51"] = txtSMCONNCODE51.GetValue();
            ht["P_SMCONNCODE52"] = txtSMCONNCODE52.GetValue();
            ht["P_SMAREACODE1"] = txtSMAREACODE1.GetValue();
            ht["P_SMAREACODE2"] = txtSMAREACODE2.GetValue();
            ht["P_SMAREACODE3"] = txtSMAREACODE3.GetValue();
            ht["P_SMAREACODE4"] = txtSMAREACODE4.GetValue();
            ht["P_SMAREACODE5"] = txtSMAREACODE5.GetValue();
            ht["P_SMAREATEXT1"] = txtSMAREATEXT1.GetValue();
            ht["P_SMAREATEXT2"] = txtSMAREATEXT2.GetValue();
            ht["P_SMAREATEXT3"] = txtSMAREATEXT3.GetValue();
            ht["P_SMAREATEXT4"] = txtSMAREATEXT4.GetValue();
            ht["P_SMAREATEXT5"] = txtSMAREATEXT5.GetValue();
            ht["P_SMMATERTEXT1"] = "";                                                // 기기명;
            ht["P_SMMATERTEXT2"] = txtSMMATERTEXT2.GetValue();
            ht["P_SMNOTE_BURN"] = sSMNOTE_BURN;
            ht["P_SMNOTE_SUFF"] = sSMNOTE_SUFF;
            ht["P_SMNOTE_ELE"] = sSMNOTE_ELE;
            ht["P_SMNOTE_FIR"] = sSMNOTE_FIR;
            ht["P_SMNOTE_EXP"] = sSMNOTE_EXP;
            ht["P_SMNOTE_DROP"] = sSMNOTE_DROP;
            ht["P_SMNOTE_LEAK"] = sSMNOTE_LEAK;
            ht["P_SMNOTE_NARR"] = sSMNOTE_NARR;
            ht["P_SMNOTE_COLL"] = sSMNOTE_COLL;
            ht["P_SMCHKSABUN1"] = $("#svSMCHKSABUN1_KBSABUN").val();
            ht["P_SMCHKTIME1"] = sSMCHKTIME1;
            ht["P_SMCHKOXYGEN1"] = txtSMCHKOXYGEN1.GetValue();
            ht["P_SMCHKOXYGENUNIT1"] = cboSMCHKOXYGENUNIT1.GetValue();
            ht["P_SMCHKTOXNUM1"] = Get_Numeric(txtSMCHKTOXNUM1.GetValue());
            ht["P_SMCHKTOXUNIT1"] = cboSMCHKTOXUNIT1.GetValue();
            ht["P_SMCHKTOXNUM1DS"] = Get_Numeric(txtSMCHKTOXNUM1DS.GetValue());
            ht["P_SMCHKTOXUNIT1DS"] = cboSMCHKTOXUNIT1DS.GetValue();
            ht["P_SMCHKTOXNUM1CO2"] = Get_Numeric(txtSMCHKTOXNUM1CO2.GetValue());
            ht["P_SMCHKTOXUNIT1CO2"] = cboSMCHKTOXUNIT1CO2.GetValue();
            ht["P_SMCHKTOXNUM1CO"] = Get_Numeric(txtSMCHKTOXNUM1CO.GetValue());
            ht["P_SMCHKTOXUNIT1CO"] = cboSMCHKTOXUNIT1CO.GetValue();
            ht["P_SMCHKTOXNUM1H2S"] = Get_Numeric(txtSMCHKTOXNUM1H2S.GetValue());
            ht["P_SMCHKTOXUNIT1H2S"] = cboSMCHKTOXUNIT1H2S.GetValue();
            ht["P_SMCHKSABUN2"] = $("#svSMCHKSABUN2_KBSABUN").val();
            ht["P_SMCHKTIME2"] = sSMCHKTIME2;
            ht["P_SMCHKOXYGEN2"] = txtSMCHKOXYGEN2.GetValue();
            ht["P_SMCHKOXYGENUNIT2"] = cboSMCHKOXYGENUNIT2.GetValue();
            ht["P_SMCHKTOXNUM2"] = Get_Numeric(txtSMCHKTOXNUM2.GetValue());
            ht["P_SMCHKTOXUNIT2"] = cboSMCHKTOXUNIT2.GetValue();
            ht["P_SMCHKTOXNUM2DS"] = Get_Numeric(txtSMCHKTOXNUM2DS.GetValue());
            ht["P_SMCHKTOXUNIT2DS"] = cboSMCHKTOXUNIT2DS.GetValue();
            ht["P_SMCHKTOXNUM2CO2"] = Get_Numeric(txtSMCHKTOXNUM2CO2.GetValue());
            ht["P_SMCHKTOXUNIT2CO2"] = cboSMCHKTOXUNIT2CO2.GetValue();
            ht["P_SMCHKTOXNUM2CO"] = Get_Numeric(txtSMCHKTOXNUM2CO.GetValue());
            ht["P_SMCHKTOXUNIT2CO"] = cboSMCHKTOXUNIT2CO.GetValue();
            ht["P_SMCHKTOXNUM2H2S"] = Get_Numeric(txtSMCHKTOXNUM2H2S.GetValue());
            ht["P_SMCHKTOXUNIT2H2S"] = cboSMCHKTOXUNIT2H2S.GetValue();
            ht["P_SMCHKSABUN3"] = $("#svSMCHKSABUN3_KBSABUN").val();
            ht["P_SMCHKTIME3"] = sSMCHKTIME3;
            ht["P_SMCHKOXYGEN3"] = txtSMCHKOXYGEN3.GetValue();
            ht["P_SMCHKOXYGENUNIT3"] = cboSMCHKOXYGENUNIT3.GetValue();
            ht["P_SMCHKTOXNUM3"] = Get_Numeric(txtSMCHKTOXNUM3.GetValue());
            ht["P_SMCHKTOXUNIT3"] = cboSMCHKTOXUNIT3.GetValue();
            ht["P_SMCHKTOXNUM3DS"] = Get_Numeric(txtSMCHKTOXNUM3DS.GetValue());
            ht["P_SMCHKTOXUNIT3DS"] = cboSMCHKTOXUNIT3DS.GetValue();
            ht["P_SMCHKTOXNUM3CO2"] = Get_Numeric(txtSMCHKTOXNUM3CO2.GetValue());
            ht["P_SMCHKTOXUNIT3CO2"] = cboSMCHKTOXUNIT3CO2.GetValue();
            ht["P_SMCHKTOXNUM3CO"] = Get_Numeric(txtSMCHKTOXNUM3CO.GetValue());
            ht["P_SMCHKTOXUNIT3CO"] = cboSMCHKTOXUNIT3CO.GetValue();
            ht["P_SMCHKTOXNUM3H2S"] = Get_Numeric(txtSMCHKTOXNUM3H2S.GetValue());
            ht["P_SMCHKTOXUNIT3H2S"] = cboSMCHKTOXUNIT3H2S.GetValue();
            ht["P_SMCHKSABUN4"] = $("#svSMCHKSABUN4_KBSABUN").val();
            ht["P_SMCHKTIME4"] = sSMCHKTIME4;
            ht["P_SMCHKOXYGEN4"] = txtSMCHKOXYGEN4.GetValue();
            ht["P_SMCHKOXYGENUNIT4"] = cboSMCHKOXYGENUNIT4.GetValue();
            ht["P_SMCHKTOXNUM4"] = Get_Numeric(txtSMCHKTOXNUM4.GetValue());
            ht["P_SMCHKTOXUNIT4"] = cboSMCHKTOXUNIT4.GetValue();
            ht["P_SMCHKTOXNUM4DS"] = Get_Numeric(txtSMCHKTOXNUM4DS.GetValue());
            ht["P_SMCHKTOXUNIT4DS"] = cboSMCHKTOXUNIT4DS.GetValue();
            ht["P_SMCHKTOXNUM4CO2"] = Get_Numeric(txtSMCHKTOXNUM4CO2.GetValue());
            ht["P_SMCHKTOXUNIT4CO2"] = cboSMCHKTOXUNIT4CO2.GetValue();
            ht["P_SMCHKTOXNUM4CO"] = Get_Numeric(txtSMCHKTOXNUM4CO.GetValue());
            ht["P_SMCHKTOXUNIT4CO"] = cboSMCHKTOXUNIT4CO.GetValue();
            ht["P_SMCHKTOXNUM4H2S"] = Get_Numeric(txtSMCHKTOXNUM4H2S.GetValue());
            ht["P_SMCHKTOXUNIT4H2S"] = cboSMCHKTOXUNIT4H2S.GetValue();
            ht["P_SMCHKSABUN5"] = $("#svSMCHKSABUN5_KBSABUN").val();
            ht["P_SMCHKTIME5"] = sSMCHKTIME5;
            ht["P_SMCHKOXYGEN5"] = txtSMCHKOXYGEN5.GetValue();
            ht["P_SMCHKOXYGENUNIT5"] = cboSMCHKOXYGENUNIT5.GetValue();
            ht["P_SMCHKTOXNUM5"] = Get_Numeric(txtSMCHKTOXNUM5.GetValue());
            ht["P_SMCHKTOXUNIT5"] = cboSMCHKTOXUNIT5.GetValue();
            ht["P_SMCHKTOXNUM5DS"] = Get_Numeric(txtSMCHKTOXNUM5DS.GetValue());
            ht["P_SMCHKTOXUNIT5DS"] = cboSMCHKTOXUNIT5DS.GetValue();
            ht["P_SMCHKTOXNUM5CO2"] = Get_Numeric(txtSMCHKTOXNUM5CO2.GetValue());
            ht["P_SMCHKTOXUNIT5CO2"] = cboSMCHKTOXUNIT5CO2.GetValue();
            ht["P_SMCHKTOXNUM5CO"] = Get_Numeric(txtSMCHKTOXNUM5CO.GetValue());
            ht["P_SMCHKTOXUNIT5CO"] = cboSMCHKTOXUNIT5CO.GetValue();
            ht["P_SMCHKTOXNUM5H2S"] = Get_Numeric(txtSMCHKTOXNUM5H2S.GetValue());
            ht["P_SMCHKTOXUNIT5H2S"] = cboSMCHKTOXUNIT5H2S.GetValue();
            ht["P_SMCHKSABUN6"] = $("#svSMCHKSABUN6_KBSABUN").val();
            ht["P_SMCHKTIME6"] = sSMCHKTIME6;
            ht["P_SMCHKOXYGEN6"] = txtSMCHKOXYGEN6.GetValue();
            ht["P_SMCHKOXYGENUNIT6"] = cboSMCHKOXYGENUNIT6.GetValue();
            ht["P_SMCHKTOXNUM6"] = Get_Numeric(txtSMCHKTOXNUM6.GetValue());
            ht["P_SMCHKTOXUNIT6"] = cboSMCHKTOXUNIT6.GetValue();
            ht["P_SMCHKTOXNUM6DS"] = Get_Numeric(txtSMCHKTOXNUM6DS.GetValue());
            ht["P_SMCHKTOXUNIT6DS"] = cboSMCHKTOXUNIT6DS.GetValue();
            ht["P_SMCHKTOXNUM6CO2"] = Get_Numeric(txtSMCHKTOXNUM6CO2.GetValue());
            ht["P_SMCHKTOXUNIT6CO2"] = cboSMCHKTOXUNIT6CO2.GetValue();
            ht["P_SMCHKTOXNUM6CO"] = Get_Numeric(txtSMCHKTOXNUM6CO.GetValue());
            ht["P_SMCHKTOXUNIT6CO"] = cboSMCHKTOXUNIT6CO.GetValue();
            ht["P_SMCHKTOXNUM6H2S"] = Get_Numeric(txtSMCHKTOXNUM6H2S.GetValue());
            ht["P_SMCHKTOXUNIT6H2S"] = cboSMCHKTOXUNIT6H2S.GetValue();
            ht["P_SMCHKSABUN7"] = $("#svSMCHKSABUN7_KBSABUN").val();
            ht["P_SMCHKTIME7"] = sSMCHKTIME7;
            ht["P_SMCHKOXYGEN7"] = txtSMCHKOXYGEN7.GetValue();
            ht["P_SMCHKOXYGENUNIT7"] = cboSMCHKOXYGENUNIT7.GetValue();
            ht["P_SMCHKTOXNUM7"] = Get_Numeric(txtSMCHKTOXNUM7.GetValue());
            ht["P_SMCHKTOXUNIT7"] = cboSMCHKTOXUNIT7.GetValue();
            ht["P_SMCHKTOXNUM7DS"] = Get_Numeric(txtSMCHKTOXNUM7DS.GetValue());
            ht["P_SMCHKTOXUNIT7DS"] = cboSMCHKTOXUNIT7DS.GetValue();
            ht["P_SMCHKTOXNUM7CO2"] = Get_Numeric(txtSMCHKTOXNUM7CO2.GetValue());
            ht["P_SMCHKTOXUNIT7CO2"] = cboSMCHKTOXUNIT7CO2.GetValue();
            ht["P_SMCHKTOXNUM7CO"] = Get_Numeric(txtSMCHKTOXNUM7CO.GetValue());
            ht["P_SMCHKTOXUNIT7CO"] = cboSMCHKTOXUNIT7CO.GetValue();
            ht["P_SMCHKTOXNUM7H2S"] = Get_Numeric(txtSMCHKTOXNUM7H2S.GetValue());
            ht["P_SMCHKTOXUNIT7H2S"] = cboSMCHKTOXUNIT7H2S.GetValue();
            ht["P_SMCHKSABUN8"] = $("#svSMCHKSABUN8_KBSABUN").val();
            ht["P_SMCHKTIME8"] = sSMCHKTIME8;
            ht["P_SMCHKOXYGEN8"] = txtSMCHKOXYGEN8.GetValue();
            ht["P_SMCHKOXYGENUNIT8"] = cboSMCHKOXYGENUNIT8.GetValue();
            ht["P_SMCHKTOXNUM8"] = Get_Numeric(txtSMCHKTOXNUM8.GetValue());
            ht["P_SMCHKTOXUNIT8"] = cboSMCHKTOXUNIT8.GetValue();
            ht["P_SMCHKTOXNUM8DS"] = Get_Numeric(txtSMCHKTOXNUM8DS.GetValue());
            ht["P_SMCHKTOXUNIT8DS"] = cboSMCHKTOXUNIT8DS.GetValue();
            ht["P_SMCHKTOXNUM8CO2"] = Get_Numeric(txtSMCHKTOXNUM8CO2.GetValue());
            ht["P_SMCHKTOXUNIT8CO2"] = cboSMCHKTOXUNIT8CO2.GetValue();
            ht["P_SMCHKTOXNUM8CO"] = Get_Numeric(txtSMCHKTOXNUM8CO.GetValue());
            ht["P_SMCHKTOXUNIT8CO"] = cboSMCHKTOXUNIT8CO.GetValue();
            ht["P_SMCHKTOXNUM8H2S"] = Get_Numeric(txtSMCHKTOXNUM8H2S.GetValue());
            ht["P_SMCHKTOXUNIT8H2S"] = cboSMCHKTOXUNIT8H2S.GetValue();
            ht["P_SMCHKTOXGUBN1"] = "";
            ht["P_SMCHKTOXGUBN2"] = "";
            ht["P_SMCHKTOXGUBN3"] = "";
            ht["P_SMCHKTOXGUBN4"] = "";
            ht["P_SMCHKTOXGUBN5"] = "";
            ht["P_SMCHKTOXGUBN6"] = "";
            ht["P_SMORDERTEXT1"] = txtSMORDERTEXT1.GetValue();
            ht["P_SMORDERTEXT2"] = "";// 지시사항2;
            ht["P_SMORSABUN"] = txtSMORSABUN.GetValue();
            ht["P_SMORNAME"] = txtSMORNAME.GetValue();
            ht["P_SMORJKCD"] = txtSMORJKCD.GetValue();
            ht["P_SMORJKCDNM"] = txtSMORJKCDNM.GetValue();
            ht["P_SMGRSABUN"] = txtSMGRSABUN.GetValue();
            ht["P_SMGRNAME"] = txtSMGRNAME.GetValue();
            ht["P_SMGRJKCD"] = txtSMGRJKCD.GetValue();
            ht["P_SMGRJKCDNM"] = txtSMGRJKCDNM.GetValue();
            ht["P_SMCOSABUN"] = txtSMCOSABUN.GetValue();
            ht["P_SMCONAME"] = txtSMCONAME.GetValue();
            ht["P_SMCOJKCD"] = txtSMCOJKCD.GetValue();
            ht["P_SMCOJKCDNM"] = txtSMCOJKCDNM.GetValue();
            ht["P_SMSMSABUN"] = $("#svSMSMSABUN_KBSABUN").val();
            ht["P_SMSMCOMMENT"] = txtSMSMCOMMENT.GetValue();
            ht["P_SMWORKTITLE"] = txtSMWORKTITLE.GetValue();
            ht["P_SMOPSABUN"] = $("#svSMOPSABUN_KBSABUN").val();
            ht["P_SMOPCOMMENT"] = txtSMOPCOMMENT.GetValue();
            ht["P_SMFIREINS"] = txtSMFIREINS.GetValue();
            ht["P_RESABUN"]     = fsRESABUN;
            ht["P_RENAME"]      = txtRENAME.GetValue();
            ht["P_SMHISAB"] = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
            
            ht["P_WKGUBUN"]     = fshdnGubun;
            ht["P_GUBUN"]       = sGUBUN;
            ht["P_SWWKCODE1"]   = chkSWWKCODE1;
            ht["P_SWWKCODE2"]   = chkSWWKCODE2;
            ht["P_SWWKCODE3"]   = chkSWWKCODE3;
            ht["P_SWWKCODE4"]   = chkSWWKCODE4;
            ht["P_SWWKCODE5"]   = chkSWWKCODE5;
            ht["P_SWWKCODE6"]   = chkSWWKCODE6;
            ht["P_SWWKCODE7"]   = chkSWWKCODE7;
            ht["P_SWWKCODE8"]   = chkSWWKCODE8;
            ht["P_SWWKCODE9"]   = chkSWWKCODE9;
            ht["P_SWWKCODE10"]  = chkSWWKCODE10;
            ht["P_SITE"]        = fshdnApprovalSite;

            ht["801_DRCODE"]     = "801";
            ht["801_DRCODENAME"] = "기계배관 관련 확인 사항 : 지하배관 유무";
            ht["801_DRYESSEL"]   = Chk801_DRYESSEL;
            ht["801_DRNOSEL"]    = Chk801_DRNOSEL;
            ht["801_DRNASEL"]    = Chk801_DRNASEL;
            ht["801_DRSORT"]     = txt801_Kind.GetValue();
            ht["801_DRSTAND"]    = txt801_Std.GetValue();
            ht["801_DRDEPTH"]    = txt801_Depth.GetValue();
            ht["801_DRSABUN"]    = $("#sv801_Sabun_KBSABUN").val();

            ht["802_DRCODE"]     = "802";
            ht["802_DRCODENAME"] = "소방관련 확인사항 : 소방배관 및 배출구 유무";
            ht["802_DRYESSEL"]   = Chk802_DRYESSEL;
            ht["802_DRNOSEL"]    = Chk802_DRNOSEL;
            ht["802_DRNASEL"]    = Chk802_DRNASEL;
            ht["802_DRSORT"]     = txt802_Kind.GetValue();
            ht["802_DRSTAND"]    = txt802_Std.GetValue();
            ht["802_DRDEPTH"]    = txt802_Depth.GetValue();
            ht["802_DRSABUN"]    = $("#sv802_Sabun_KBSABUN").val();

            ht["803_DRCODE"]     = "803";
            ht["803_DRCODENAME"] = "전기관련 확인사항 : 전기동력선 유무";
            ht["803_DRYESSEL"]   = Chk803_DRYESSEL;
            ht["803_DRNOSEL"]    = Chk803_DRNOSEL;
            ht["803_DRNASEL"]    = Chk803_DRNASEL;
            ht["803_DRSORT"]     = txt803_Kind.GetValue();
            ht["803_DRSTAND"]    = txt803_Std.GetValue();
            ht["803_DRDEPTH"]    = txt803_Depth.GetValue();
            ht["803_DRSABUN"]    = $("#sv803_Sabun_KBSABUN").val();

            ht["804_DRCODE"]     = "804";
            ht["804_DRCODENAME"] = "계장관련 확인사항 : 제어용 케이블 유무";
            ht["804_DRYESSEL"]   = Chk804_DRYESSEL;
            ht["804_DRNOSEL"]    = Chk804_DRNOSEL;
            ht["804_DRNASEL"]    = Chk804_DRNASEL;
            ht["804_DRSORT"]     = txt804_Kind.GetValue();
            ht["804_DRSTAND"]    = txt804_Std.GetValue();
            ht["804_DRDEPTH"]    = txt804_Depth.GetValue();
            ht["804_DRSABUN"]    = $("#sv804_Sabun_KBSABUN").val();

            ht["805_DRCODE"]     = "805";
            ht["805_DRCODENAME"] = "기타관련 확인사항 : 전화선 및 접지선 유무";
            ht["805_DRYESSEL"]   = Chk805_DRYESSEL;
            ht["805_DRNOSEL"]    = Chk805_DRNOSEL;
            ht["805_DRNASEL"]    = Chk805_DRNASEL;
            ht["805_DRSORT"]     = txt805_Kind.GetValue();
            ht["805_DRSTAND"]    = txt805_Std.GetValue();
            ht["805_DRDEPTH"]    = txt805_Depth.GetValue();
            ht["805_DRSABUN"]    = $("#sv805_Sabun_KBSABUN").val();


            ht["101_SACODE"] = "101";
            ht["102_SACODE"] = "102";
            ht["103_SACODE"] = "103";
            ht["104_SACODE"] = "104";
            ht["105_SACODE"] = "105";
            ht["106_SACODE"] = "106";
            ht["107_SACODE"] = "107";
            ht["108_SACODE"] = "108";
            ht["109_SACODE"] = "109";
            ht["110_SACODE"] = "110";
            ht["111_SACODE"] = "111";
            ht["112_SACODE"] = "112";
            ht["113_SACODE"] = "113";
            ht["114_SACODE"] = "114";
            ht["115_SACODE"] = "115";
            ht["116_SACODE"] = "116";
            ht["201_SACODE"] = "201";
            ht["202_SACODE"] = "202";
            ht["203_SACODE"] = "203";
            ht["204_SACODE"] = "204";
            ht["205_SACODE"] = "205";
            ht["206_SACODE"] = "206";
            ht["207_SACODE"] = "207";
            ht["208_SACODE"] = "208";
            ht["209_SACODE"] = "209";
            ht["210_SACODE"] = "210";
            ht["211_SACODE"] = "211";
            ht["212_SACODE"] = "212";
            ht["213_SACODE"] = "213";
            ht["214_SACODE"] = "214";
            ht["215_SACODE"] = "215";
            ht["216_SACODE"] = "216";
            ht["217_SACODE"] = "217";
            ht["218_SACODE"] = "218";
            ht["301_SACODE"] = "301";
            ht["302_SACODE"] = "302";
            ht["303_SACODE"] = "303";
            ht["304_SACODE"] = "304";
            ht["305_SACODE"] = "305";
            ht["306_SACODE"] = "306";
            ht["307_SACODE"] = "307";
            ht["308_SACODE"] = "308";
            ht["309_SACODE"] = "309";
            ht["310_SACODE"] = "310";
            ht["311_SACODE"] = "311";
            ht["312_SACODE"] = "312";
            ht["313_SACODE"] = "313";
            ht["314_SACODE"] = "314";
            ht["401_SACODE"] = "401";
            ht["402_SACODE"] = "402";
            ht["403_SACODE"] = "403";
            ht["404_SACODE"] = "404";
            ht["405_SACODE"] = "405";
            ht["406_SACODE"] = "406";
            ht["407_SACODE"] = "407";
            ht["408_SACODE"] = "408";
            ht["409_SACODE"] = "409";
            ht["501_SACODE"] = "501";
            ht["502_SACODE"] = "502";
            ht["503_SACODE"] = "503";
            ht["504_SACODE"] = "504";
            ht["601_SACODE"] = "601";
            ht["602_SACODE"] = "602";
            ht["603_SACODE"] = "603";
            ht["701_SACODE"] = "701";
            ht["702_SACODE"] = "702";
            ht["703_SACODE"] = "703";
            ht["704_SACODE"] = "704";
            ht["705_SACODE"] = "705";
            ht["706_SACODE"] = "706";
            ht["707_SACODE"] = "707";
            ht["708_SACODE"] = "708";
            ht["901_SACODE"] = "901";
            ht["902_SACODE"] = "902";
            ht["903_SACODE"] = "903";
            ht["904_SACODE"] = "904";
            ht["905_SACODE"] = "905";
            ht["906_SACODE"] = "906";
            ht["907_SACODE"] = "907";
            ht["908_SACODE"] = "908";
            ht["909_SACODE"] = "909";
            ht["910_SACODE"] = "910";
            ht["911_SACODE"] = "911";
            ht["912_SACODE"] = "912";
            ht["913_SACODE"] = "913";
            ht["914_SACODE"] = "914";
            ht["915_SACODE"] = "915";
            ht["916_SACODE"] = "916";

            ht["101_SACODENM"] = "작업구역 설정(출입경고 표지)";
            ht["102_SACODENM"] = "가스 농도 측정";
            ht["103_SACODENM"] = "분진 농도 측정";
            ht["104_SACODENM"] = "밸브차단 및 차단표지부착";
            ht["105_SACODENM"] = "맹판설치 및 표지부착";
            ht["106_SACODENM"] = "용기개방 및 압력방출";
            ht["107_SACODENM"] = "위험물질방출 및 처리";
            ht["108_SACODENM"] = "용기내부 세정 및 처리";
            ht["109_SACODENM"] = "불황성가스 치환 및 환기";
            ht["110_SACODENM"] = "정전/잠금/표지부착";
            ht["111_SACODENM"] = "환기장비";
            ht["112_SACODENM"] = "조명장비";
            ht["113_SACODENM"] = "소 화 기";
            ht["114_SACODENM"] = "안전장구";
            ht["115_SACODENM"] = "안전교육";
            ht["116_SACODENM"] = "운전요원의 입회";
            ht["201_SACODENM"] = "작업구역 설정(출입경고 표지)";
            ht["202_SACODENM"] = "가스 농도 측정";
            ht["203_SACODENM"] = "분진 농도 측정";
            ht["204_SACODENM"] = "밸브차단 및 차단표지부착";
            ht["205_SACODENM"] = "맹판설치 및 표지부착";
            ht["206_SACODENM"] = "용기개방 및 압력방출";
            ht["207_SACODENM"] = "위험물질방출 및 처리";
            ht["208_SACODENM"] = "용기내부 세정 및 처리";
            ht["209_SACODENM"] = "불황성가스 치환 및 환기";
            ht["210_SACODENM"] = "비산불티차단막 설치";
            ht["211_SACODENM"] = "정전/잠금/표지부착";
            ht["212_SACODENM"] = "환기장비";
            ht["213_SACODENM"] = "조명장비";
            ht["214_SACODENM"] = "소 화 기";
            ht["215_SACODENM"] = "안전장구";
            ht["216_SACODENM"] = "안전교육";
            ht["217_SACODENM"] = "운전요원의 입회";
            ht["218_SACODENM"] = "주변지역 가연성/인화성 물질 확인 및 제거,차단";
            ht["301_SACODENM"] = "밸브차단 및 차단표식부착";
            ht["302_SACODENM"] = "가스 농도 측정";
            ht["303_SACODENM"] = "산소 농도 측정";
            ht["304_SACODENM"] = "분진 농도 측정";
            ht["305_SACODENM"] = "맹판설치 및 표지부착";
            ht["306_SACODENM"] = "압력방출";
            ht["307_SACODENM"] = "용기세척 후 공기/물 치환 및 환기";
            ht["308_SACODENM"] = "정전/잠금/표지부착";
            ht["309_SACODENM"] = "환기장비";
            ht["310_SACODENM"] = "조명장비";
            ht["311_SACODENM"] = "소 화 기";
            ht["312_SACODENM"] = "안전장구(구명선 등)";
            ht["313_SACODENM"] = "안전교육";
            ht["314_SACODENM"] = "운전요원의 입회";
            ht["401_SACODENM"] = "[제어반]";
            ht["402_SACODENM"] = "주 차단 스위치 내림";
            ht["403_SACODENM"] = "제어차단기 내림";
            ht["404_SACODENM"] = "잠금장치";
            ht["405_SACODENM"] = "시험전원 차단";
            ht["406_SACODENM"] = "차단표지판 부착";
            ht["407_SACODENM"] = "[현장기기]";
            ht["408_SACODENM"] = "현장스위치 내림";
            ht["409_SACODENM"] = "차단표지판 부착";
            ht["501_SACODENM"] = "작업구역에 차단선 설치";
            ht["502_SACODENM"] = "제한구역의 비인가자 출입제한";
            ht["503_SACODENM"] = "방사선 위험표지";
            ht["504_SACODENM"] = "경고 등(전멸등)";
            ht["601_SACODENM"] = "작업에 적합한 작업발판 및 안전난간설치 여부";
            ht["602_SACODENM"] = "안전대 착용 및 부착 여부";
            ht["603_SACODENM"] = "추락 방지용 방망 설치 여부";
            ht["701_SACODENM"] = "기상상태";
            ht["702_SACODENM"] = "신호수배치";
            ht["703_SACODENM"] = "조명설비";
            ht["704_SACODENM"] = "통행금지 표지판 부착";
            ht["705_SACODENM"] = "전원설비 간섭여부";
            ht["706_SACODENM"] = "매트 등 부속장구";
            ht["707_SACODENM"] = "노면상태";
            ht["708_SACODENM"] = "중장비 명허증/검사증 확인";
            ht["901_SACODENM"] = "안 전 모";
            ht["902_SACODENM"] = "안 전 화";
            ht["903_SACODENM"] = "고글.보안경";
            ht["904_SACODENM"] = "방진마스크";
            ht["905_SACODENM"] = "방독마스크";
            ht["906_SACODENM"] = "송기마스크";
            ht["907_SACODENM"] = "공기호흡기";
            ht["908_SACODENM"] = "내화학장갑";
            ht["909_SACODENM"] = "안전장화";
            ht["910_SACODENM"] = "오염방지복";
            ht["911_SACODENM"] = "화 학 복";
            ht["912_SACODENM"] = "안전그네";
            ht["913_SACODENM"] = "방폭조명등";
            ht["914_SACODENM"] = "비상용호각";
            ht["915_SACODENM"] = "방폭무전기";
            ht["916_SACODENM"] = "구명줄";


            ht["101_SSPUBSEL"] = Chk101_SSPUBSEL;
            ht["102_SSPUBSEL"] = Chk102_SSPUBSEL;
            ht["103_SSPUBSEL"] = Chk103_SSPUBSEL;
            ht["104_SSPUBSEL"] = Chk104_SSPUBSEL;
            ht["105_SSPUBSEL"] = Chk105_SSPUBSEL;
            ht["106_SSPUBSEL"] = Chk106_SSPUBSEL;
            ht["107_SSPUBSEL"] = Chk107_SSPUBSEL;
            ht["108_SSPUBSEL"] = Chk108_SSPUBSEL;
            ht["109_SSPUBSEL"] = Chk109_SSPUBSEL;
            ht["110_SSPUBSEL"] = Chk110_SSPUBSEL;
            ht["111_SSPUBSEL"] = Chk111_SSPUBSEL;
            ht["112_SSPUBSEL"] = Chk112_SSPUBSEL;
            ht["113_SSPUBSEL"] = Chk113_SSPUBSEL;
            ht["114_SSPUBSEL"] = Chk114_SSPUBSEL;
            ht["115_SSPUBSEL"] = Chk115_SSPUBSEL;
            ht["116_SSPUBSEL"] = Chk116_SSPUBSEL;
            ht["101_SSREVSEL"] = Chk101_SSREVSEL;
            ht["102_SSREVSEL"] = Chk102_SSREVSEL;
            ht["103_SSREVSEL"] = Chk103_SSREVSEL;
            ht["104_SSREVSEL"] = Chk104_SSREVSEL;
            ht["105_SSREVSEL"] = Chk105_SSREVSEL;
            ht["106_SSREVSEL"] = Chk106_SSREVSEL;
            ht["107_SSREVSEL"] = Chk107_SSREVSEL;
            ht["108_SSREVSEL"] = Chk108_SSREVSEL;
            ht["109_SSREVSEL"] = Chk109_SSREVSEL;
            ht["110_SSREVSEL"] = Chk110_SSREVSEL;
            ht["111_SSREVSEL"] = Chk111_SSREVSEL;
            ht["112_SSREVSEL"] = Chk112_SSREVSEL;
            ht["113_SSREVSEL"] = Chk113_SSREVSEL;
            ht["114_SSREVSEL"] = Chk114_SSREVSEL;
            ht["115_SSREVSEL"] = Chk115_SSREVSEL;
            ht["116_SSREVSEL"] = Chk116_SSREVSEL;
            ht["101_SSFIXSEL"] = Chk101_SSFIXSEL;
            ht["102_SSFIXSEL"] = Chk102_SSFIXSEL;
            ht["103_SSFIXSEL"] = Chk103_SSFIXSEL;
            ht["104_SSFIXSEL"] = Chk104_SSFIXSEL;
            ht["105_SSFIXSEL"] = Chk105_SSFIXSEL;
            ht["106_SSFIXSEL"] = Chk106_SSFIXSEL;
            ht["107_SSFIXSEL"] = Chk107_SSFIXSEL;
            ht["108_SSFIXSEL"] = Chk108_SSFIXSEL;
            ht["109_SSFIXSEL"] = Chk109_SSFIXSEL;
            ht["110_SSFIXSEL"] = Chk110_SSFIXSEL;
            ht["111_SSFIXSEL"] = Chk111_SSFIXSEL;
            ht["112_SSFIXSEL"] = Chk112_SSFIXSEL;
            ht["113_SSFIXSEL"] = Chk113_SSFIXSEL;
            ht["114_SSFIXSEL"] = Chk114_SSFIXSEL;
            ht["115_SSFIXSEL"] = Chk115_SSFIXSEL;
            ht["116_SSFIXSEL"] = Chk116_SSFIXSEL;
            ht["201_SSPUBSEL"] = Chk201_SSPUBSEL;
            ht["202_SSPUBSEL"] = Chk202_SSPUBSEL;
            ht["203_SSPUBSEL"] = Chk203_SSPUBSEL;
            ht["204_SSPUBSEL"] = Chk204_SSPUBSEL;
            ht["205_SSPUBSEL"] = Chk205_SSPUBSEL;
            ht["206_SSPUBSEL"] = Chk206_SSPUBSEL;
            ht["207_SSPUBSEL"] = Chk207_SSPUBSEL;
            ht["208_SSPUBSEL"] = Chk208_SSPUBSEL;
            ht["209_SSPUBSEL"] = Chk209_SSPUBSEL;
            ht["210_SSPUBSEL"] = Chk210_SSPUBSEL;
            ht["211_SSPUBSEL"] = Chk211_SSPUBSEL;
            ht["212_SSPUBSEL"] = Chk212_SSPUBSEL;
            ht["213_SSPUBSEL"] = Chk213_SSPUBSEL;
            ht["214_SSPUBSEL"] = Chk214_SSPUBSEL;
            ht["215_SSPUBSEL"] = Chk215_SSPUBSEL;
            ht["216_SSPUBSEL"] = Chk216_SSPUBSEL;
            ht["217_SSPUBSEL"] = Chk217_SSPUBSEL;
            ht["218_SSPUBSEL"] = Chk218_SSPUBSEL;
            ht["201_SSREVSEL"] = Chk201_SSREVSEL;
            ht["202_SSREVSEL"] = Chk202_SSREVSEL;
            ht["203_SSREVSEL"] = Chk203_SSREVSEL;
            ht["204_SSREVSEL"] = Chk204_SSREVSEL;
            ht["205_SSREVSEL"] = Chk205_SSREVSEL;
            ht["206_SSREVSEL"] = Chk206_SSREVSEL;
            ht["207_SSREVSEL"] = Chk207_SSREVSEL;
            ht["208_SSREVSEL"] = Chk208_SSREVSEL;
            ht["209_SSREVSEL"] = Chk209_SSREVSEL;
            ht["210_SSREVSEL"] = Chk210_SSREVSEL;
            ht["211_SSREVSEL"] = Chk211_SSREVSEL;
            ht["212_SSREVSEL"] = Chk212_SSREVSEL;
            ht["213_SSREVSEL"] = Chk213_SSREVSEL;
            ht["214_SSREVSEL"] = Chk214_SSREVSEL;
            ht["215_SSREVSEL"] = Chk215_SSREVSEL;
            ht["216_SSREVSEL"] = Chk216_SSREVSEL;
            ht["217_SSREVSEL"] = Chk217_SSREVSEL;
            ht["218_SSREVSEL"] = Chk218_SSREVSEL;
            ht["201_SSFIXSEL"] = Chk201_SSFIXSEL;
            ht["202_SSFIXSEL"] = Chk202_SSFIXSEL;
            ht["203_SSFIXSEL"] = Chk203_SSFIXSEL;
            ht["204_SSFIXSEL"] = Chk204_SSFIXSEL;
            ht["205_SSFIXSEL"] = Chk205_SSFIXSEL;
            ht["206_SSFIXSEL"] = Chk206_SSFIXSEL;
            ht["207_SSFIXSEL"] = Chk207_SSFIXSEL;
            ht["208_SSFIXSEL"] = Chk208_SSFIXSEL;
            ht["209_SSFIXSEL"] = Chk209_SSFIXSEL;
            ht["210_SSFIXSEL"] = Chk210_SSFIXSEL;
            ht["211_SSFIXSEL"] = Chk211_SSFIXSEL;
            ht["212_SSFIXSEL"] = Chk212_SSFIXSEL;
            ht["213_SSFIXSEL"] = Chk213_SSFIXSEL;
            ht["214_SSFIXSEL"] = Chk214_SSFIXSEL;
            ht["215_SSFIXSEL"] = Chk215_SSFIXSEL;
            ht["216_SSFIXSEL"] = Chk216_SSFIXSEL;
            ht["217_SSFIXSEL"] = Chk217_SSFIXSEL;
            ht["218_SSFIXSEL"] = Chk218_SSFIXSEL;
            ht["301_SSPUBSEL"] = Chk301_SSPUBSEL;
            ht["302_SSPUBSEL"] = Chk302_SSPUBSEL;
            ht["303_SSPUBSEL"] = Chk303_SSPUBSEL;
            ht["304_SSPUBSEL"] = Chk304_SSPUBSEL;
            ht["305_SSPUBSEL"] = Chk305_SSPUBSEL;
            ht["306_SSPUBSEL"] = Chk306_SSPUBSEL;
            ht["307_SSPUBSEL"] = Chk307_SSPUBSEL;
            ht["308_SSPUBSEL"] = Chk308_SSPUBSEL;
            ht["309_SSPUBSEL"] = Chk309_SSPUBSEL;
            ht["310_SSPUBSEL"] = Chk310_SSPUBSEL;
            ht["311_SSPUBSEL"] = Chk311_SSPUBSEL;
            ht["312_SSPUBSEL"] = Chk312_SSPUBSEL;
            ht["313_SSPUBSEL"] = Chk313_SSPUBSEL;
            ht["314_SSPUBSEL"] = Chk314_SSPUBSEL;
            ht["301_SSREVSEL"] = Chk301_SSREVSEL;
            ht["302_SSREVSEL"] = Chk302_SSREVSEL;
            ht["303_SSREVSEL"] = Chk303_SSREVSEL;
            ht["304_SSREVSEL"] = Chk304_SSREVSEL;
            ht["305_SSREVSEL"] = Chk305_SSREVSEL;
            ht["306_SSREVSEL"] = Chk306_SSREVSEL;
            ht["307_SSREVSEL"] = Chk307_SSREVSEL;
            ht["308_SSREVSEL"] = Chk308_SSREVSEL;
            ht["309_SSREVSEL"] = Chk309_SSREVSEL;
            ht["310_SSREVSEL"] = Chk310_SSREVSEL;
            ht["311_SSREVSEL"] = Chk311_SSREVSEL;
            ht["312_SSREVSEL"] = Chk312_SSREVSEL;
            ht["313_SSREVSEL"] = Chk313_SSREVSEL;
            ht["314_SSREVSEL"] = Chk314_SSREVSEL;
            ht["301_SSFIXSEL"] = Chk301_SSFIXSEL;
            ht["302_SSFIXSEL"] = Chk302_SSFIXSEL;
            ht["303_SSFIXSEL"] = Chk303_SSFIXSEL;
            ht["304_SSFIXSEL"] = Chk304_SSFIXSEL;
            ht["305_SSFIXSEL"] = Chk305_SSFIXSEL;
            ht["306_SSFIXSEL"] = Chk306_SSFIXSEL;
            ht["307_SSFIXSEL"] = Chk307_SSFIXSEL;
            ht["308_SSFIXSEL"] = Chk308_SSFIXSEL;
            ht["309_SSFIXSEL"] = Chk309_SSFIXSEL;
            ht["310_SSFIXSEL"] = Chk310_SSFIXSEL;
            ht["311_SSFIXSEL"] = Chk311_SSFIXSEL;
            ht["312_SSFIXSEL"] = Chk312_SSFIXSEL;
            ht["313_SSFIXSEL"] = Chk313_SSFIXSEL;
            ht["314_SSFIXSEL"] = Chk314_SSFIXSEL;
            ht["401_SSPUBSEL"] = Chk401_SSPUBSEL;
            ht["402_SSPUBSEL"] = Chk402_SSPUBSEL;
            ht["403_SSPUBSEL"] = Chk403_SSPUBSEL;
            ht["404_SSPUBSEL"] = Chk404_SSPUBSEL;
            ht["405_SSPUBSEL"] = Chk405_SSPUBSEL;
            ht["406_SSPUBSEL"] = Chk406_SSPUBSEL;
            ht["407_SSPUBSEL"] = Chk407_SSPUBSEL;
            ht["408_SSPUBSEL"] = Chk408_SSPUBSEL;
            ht["409_SSPUBSEL"] = Chk409_SSPUBSEL;
            ht["401_SSREVSEL"] = Chk401_SSREVSEL;
            ht["402_SSREVSEL"] = Chk402_SSREVSEL;
            ht["403_SSREVSEL"] = Chk403_SSREVSEL;
            ht["404_SSREVSEL"] = Chk404_SSREVSEL;
            ht["405_SSREVSEL"] = Chk405_SSREVSEL;
            ht["406_SSREVSEL"] = Chk406_SSREVSEL;
            ht["407_SSREVSEL"] = Chk407_SSREVSEL;
            ht["408_SSREVSEL"] = Chk408_SSREVSEL;
            ht["409_SSREVSEL"] = Chk409_SSREVSEL;
            ht["401_SSFIXSEL"] = Chk401_SSFIXSEL;
            ht["402_SSFIXSEL"] = Chk402_SSFIXSEL;
            ht["403_SSFIXSEL"] = Chk403_SSFIXSEL;
            ht["404_SSFIXSEL"] = Chk404_SSFIXSEL;
            ht["405_SSFIXSEL"] = Chk405_SSFIXSEL;
            ht["406_SSFIXSEL"] = Chk406_SSFIXSEL;
            ht["407_SSFIXSEL"] = Chk407_SSFIXSEL;
            ht["408_SSFIXSEL"] = Chk408_SSFIXSEL;
            ht["409_SSFIXSEL"] = Chk409_SSFIXSEL;
            ht["501_SSPUBSEL"] = Chk501_SSPUBSEL;
            ht["502_SSPUBSEL"] = Chk502_SSPUBSEL;
            ht["503_SSPUBSEL"] = Chk503_SSPUBSEL;
            ht["504_SSPUBSEL"] = Chk504_SSPUBSEL;
            ht["501_SSREVSEL"] = Chk501_SSREVSEL;
            ht["502_SSREVSEL"] = Chk502_SSREVSEL;
            ht["503_SSREVSEL"] = Chk503_SSREVSEL;
            ht["504_SSREVSEL"] = Chk504_SSREVSEL;
            ht["501_SSFIXSEL"] = Chk501_SSFIXSEL;
            ht["502_SSFIXSEL"] = Chk502_SSFIXSEL;
            ht["503_SSFIXSEL"] = Chk503_SSFIXSEL;
            ht["504_SSFIXSEL"] = Chk504_SSFIXSEL;
            ht["601_SSPUBSEL"] = Chk601_SSPUBSEL;
            ht["602_SSPUBSEL"] = Chk602_SSPUBSEL;
            ht["603_SSPUBSEL"] = Chk603_SSPUBSEL;
            ht["601_SSREVSEL"] = Chk601_SSREVSEL;
            ht["602_SSREVSEL"] = Chk602_SSREVSEL;
            ht["603_SSREVSEL"] = Chk603_SSREVSEL;
            ht["601_SSFIXSEL"] = Chk601_SSFIXSEL;
            ht["602_SSFIXSEL"] = Chk602_SSFIXSEL;
            ht["603_SSFIXSEL"] = Chk603_SSFIXSEL;
            ht["701_SSPUBSEL"] = Chk701_SSPUBSEL;
            ht["702_SSPUBSEL"] = Chk702_SSPUBSEL;
            ht["703_SSPUBSEL"] = Chk703_SSPUBSEL;
            ht["704_SSPUBSEL"] = Chk704_SSPUBSEL;
            ht["705_SSPUBSEL"] = Chk705_SSPUBSEL;
            ht["706_SSPUBSEL"] = Chk706_SSPUBSEL;
            ht["707_SSPUBSEL"] = Chk707_SSPUBSEL;
            ht["708_SSPUBSEL"] = Chk708_SSPUBSEL;
            ht["701_SSREVSEL"] = Chk701_SSREVSEL;
            ht["702_SSREVSEL"] = Chk702_SSREVSEL;
            ht["703_SSREVSEL"] = Chk703_SSREVSEL;
            ht["704_SSREVSEL"] = Chk704_SSREVSEL;
            ht["705_SSREVSEL"] = Chk705_SSREVSEL;
            ht["706_SSREVSEL"] = Chk706_SSREVSEL;
            ht["707_SSREVSEL"] = Chk707_SSREVSEL;
            ht["708_SSREVSEL"] = Chk708_SSREVSEL;
            ht["701_SSFIXSEL"] = Chk701_SSFIXSEL;
            ht["702_SSFIXSEL"] = Chk702_SSFIXSEL;
            ht["703_SSFIXSEL"] = Chk703_SSFIXSEL;
            ht["704_SSFIXSEL"] = Chk704_SSFIXSEL;
            ht["705_SSFIXSEL"] = Chk705_SSFIXSEL;
            ht["706_SSFIXSEL"] = Chk706_SSFIXSEL;
            ht["707_SSFIXSEL"] = Chk707_SSFIXSEL;
            ht["708_SSFIXSEL"] = Chk708_SSFIXSEL;
            ht["901_SSPUBSEL"] = Chk901_SSPUBSEL;
            ht["902_SSPUBSEL"] = Chk902_SSPUBSEL;
            ht["903_SSPUBSEL"] = Chk903_SSPUBSEL;
            ht["904_SSPUBSEL"] = Chk904_SSPUBSEL;
            ht["905_SSPUBSEL"] = Chk905_SSPUBSEL;
            ht["906_SSPUBSEL"] = Chk906_SSPUBSEL;
            ht["907_SSPUBSEL"] = Chk907_SSPUBSEL;
            ht["908_SSPUBSEL"] = Chk908_SSPUBSEL;
            ht["909_SSPUBSEL"] = Chk909_SSPUBSEL;
            ht["910_SSPUBSEL"] = Chk910_SSPUBSEL;
            ht["911_SSPUBSEL"] = Chk911_SSPUBSEL;
            ht["912_SSPUBSEL"] = Chk912_SSPUBSEL;
            ht["913_SSPUBSEL"] = Chk913_SSPUBSEL;
            ht["914_SSPUBSEL"] = Chk914_SSPUBSEL;
            ht["915_SSPUBSEL"] = Chk915_SSPUBSEL;
            ht["916_SSPUBSEL"] = Chk916_SSPUBSEL;
            ht["901_SSREVSEL"] = Chk901_SSREVSEL;
            ht["902_SSREVSEL"] = Chk902_SSREVSEL;
            ht["903_SSREVSEL"] = Chk903_SSREVSEL;
            ht["904_SSREVSEL"] = Chk904_SSREVSEL;
            ht["905_SSREVSEL"] = Chk905_SSREVSEL;
            ht["906_SSREVSEL"] = Chk906_SSREVSEL;
            ht["907_SSREVSEL"] = Chk907_SSREVSEL;
            ht["908_SSREVSEL"] = Chk908_SSREVSEL;
            ht["909_SSREVSEL"] = Chk909_SSREVSEL;
            ht["910_SSREVSEL"] = Chk910_SSREVSEL;
            ht["911_SSREVSEL"] = Chk911_SSREVSEL;
            ht["912_SSREVSEL"] = Chk912_SSREVSEL;
            ht["913_SSREVSEL"] = Chk913_SSREVSEL;
            ht["914_SSREVSEL"] = Chk914_SSREVSEL;
            ht["915_SSREVSEL"] = Chk915_SSREVSEL;
            ht["916_SSREVSEL"] = Chk916_SSREVSEL;
            ht["901_SSFIXSEL"] = Chk901_SSFIXSEL;
            ht["902_SSFIXSEL"] = Chk902_SSFIXSEL;
            ht["903_SSFIXSEL"] = Chk903_SSFIXSEL;
            ht["904_SSFIXSEL"] = Chk904_SSFIXSEL;
            ht["905_SSFIXSEL"] = Chk905_SSFIXSEL;
            ht["906_SSFIXSEL"] = Chk906_SSFIXSEL;
            ht["907_SSFIXSEL"] = Chk907_SSFIXSEL;
            ht["908_SSFIXSEL"] = Chk908_SSFIXSEL;
            ht["909_SSFIXSEL"] = Chk909_SSFIXSEL;
            ht["910_SSFIXSEL"] = Chk910_SSFIXSEL;
            ht["911_SSFIXSEL"] = Chk911_SSFIXSEL;
            ht["912_SSFIXSEL"] = Chk912_SSFIXSEL;
            ht["913_SSFIXSEL"] = Chk913_SSFIXSEL;
            ht["914_SSFIXSEL"] = Chk914_SSFIXSEL;
            ht["915_SSFIXSEL"] = Chk915_SSFIXSEL;
            ht["916_SSFIXSEL"] = Chk916_SSFIXSEL;
            

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_MASTER_SAVE", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    var i = 0;

                    for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {

                        if (fshdnGubun.toString() == "NEW") {

                            if (DataSet.Tables[0].Rows[i]["MSG"] == "SEQ") {

                                txtSMWKORSEQ.SetValue(DataSet.Tables[0].Rows[i]["DATA"].toString());
                            }
                        }
                    }

                    if (fshdnGubun.toString() == "NEW") {
                        fshdnGubun = "UPT";
                    }

                    // 첨부파일 저장
                    UploadStart(GetAttachFile_Callback);

                    // 작업내용 가져오기
                    fn_GET_Wkcode();

                    // 작업종류에 따른 조치요구사항 클리어
                    fn_Clear_SACODE();

                    // 조치요구사항 체크박스 Readonly
                    fn_Chk_SaCode_ReadOnly('APPROVAL');

                    // 조치요구사항 가져오기
                    fn_SaCode_GetData();

                    if (chkSWWKCODE10.Checked == true) {

                        // 굴착 조치요구사항 가져오기
                        fn_DRCode_GetData();
                    }

                    if (sGUBUN == "APPROVAL") {

                        fn_Approval(sGUBUN);
                    }

                    if (sGUBUN == "APPROVAL") {
                        /*alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');*/
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 되었습니다." Literal="true"></Ctl:Text>');
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
        }


        function fn_Clear_SACODE() {

            if ($("input:checkbox[name=chkSWWKCODE1]").prop('checked') == false)
            {
                $('input:checkbox[name="Chk101_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk102_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk103_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk104_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk105_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk106_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk107_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk108_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk109_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk110_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk111_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk112_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk113_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk114_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk115_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk116_SSPUBSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk101_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk102_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk103_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk104_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk105_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk106_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk107_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk108_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk109_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk110_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk111_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk112_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk113_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk114_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk115_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk116_SSREVSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk101_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk102_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk103_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk104_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk105_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk106_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk107_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk108_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk109_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk110_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk111_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk112_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk113_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk114_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk115_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk116_SSFIXSEL"]').attr("checked", false);
            }

            if ($("input:checkbox[name=chkSWWKCODE2]").prop('checked') == false)
            {
                $('input:checkbox[name="Chk201_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk202_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk203_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk204_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk205_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk206_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk207_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk208_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk209_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk210_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk211_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk212_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk213_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk214_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk215_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk216_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk217_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk218_SSPUBSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk201_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk202_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk203_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk204_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk205_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk206_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk207_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk208_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk209_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk210_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk211_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk212_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk213_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk214_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk215_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk216_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk217_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk218_SSREVSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk201_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk202_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk203_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk204_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk205_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk206_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk207_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk208_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk209_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk210_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk211_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk212_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk213_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk214_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk215_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk216_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk217_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk218_SSFIXSEL"]').attr("checked", false);
            }

            if ($("input:checkbox[name=chkSWWKCODE3]").prop('checked') == false &&
                $("input:checkbox[name=chkSWWKCODE4]").prop('checked') == false &&
                $("input:checkbox[name=chkSWWKCODE5]").prop('checked') == false)
            {
                $('input:checkbox[name="Chk301_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk302_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk303_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk304_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk305_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk306_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk307_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk308_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk309_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk310_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk311_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk312_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk313_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk314_SSPUBSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk301_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk302_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk303_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk304_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk305_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk306_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk307_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk308_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk309_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk310_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk311_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk312_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk313_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk314_SSREVSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk301_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk302_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk303_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk304_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk305_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk306_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk307_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk308_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk309_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk310_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk311_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk312_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk313_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk314_SSFIXSEL"]').attr("checked", false);
            }

            if ($("input:checkbox[name=chkSWWKCODE6]").prop('checked') == false)
            {
                $('input:checkbox[name="Chk401_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk402_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk403_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk404_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk405_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk406_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk407_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk408_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk409_SSPUBSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk401_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk402_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk403_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk404_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk405_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk406_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk407_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk408_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk409_SSREVSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk401_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk402_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk403_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk404_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk405_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk406_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk407_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk408_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk409_SSFIXSEL"]').attr("checked", false);
            }

            if ($("input:checkbox[name=chkSWWKCODE7]").prop('checked') == false)
            {
                $('input:checkbox[name="Chk501_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk502_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk503_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk504_SSPUBSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk501_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk502_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk503_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk504_SSREVSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk501_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk502_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk503_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk504_SSFIXSEL"]').attr("checked", false);
            }

            if ($("input:checkbox[name=chkSWWKCODE8]").prop('checked') == false)
            {
                $('input:checkbox[name="Chk601_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk602_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk603_SSPUBSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk601_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk602_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk603_SSREVSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk601_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk602_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk603_SSFIXSEL"]').attr("checked", false);
            }

            if ($("input:checkbox[name=chkSWWKCODE9]").prop('checked') == false)
            {
                $('input:checkbox[name="Chk701_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk702_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk703_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk704_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk705_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk706_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk707_SSPUBSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk708_SSPUBSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk701_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk702_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk703_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk704_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk705_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk706_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk707_SSREVSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk708_SSREVSEL"]').attr("checked", false);

                $('input:checkbox[name="Chk701_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk702_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk703_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk704_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk705_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk706_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk707_SSFIXSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk708_SSFIXSEL"]').attr("checked", false);
            }
        }

        function fn_Clear_DRCODE() {

            if ($("input:checkbox[name=chkSWWKCODE10]").prop('checked') == false)
            {
                $('input:checkbox[name="Chk801_DRYESSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk801_DRNOSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk801_DRNASEL"]').attr("checked", false);

                $('input:checkbox[name="Chk802_DRYESSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk802_DRNOSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk802_DRNASEL"]').attr("checked", false);

                $('input:checkbox[name="Chk803_DRYESSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk803_DRNOSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk803_DRNASEL"]').attr("checked", false);

                $('input:checkbox[name="Chk804_DRYESSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk804_DRNOSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk804_DRNASEL"]').attr("checked", false);

                $('input:checkbox[name="Chk805_DRYESSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk805_DRNOSEL"]').attr("checked", false);
                $('input:checkbox[name="Chk805_DRNASEL"]').attr("checked", false);

                txt801_Kind.SetValue("");
                txt801_Std.SetValue("");
                txt801_Depth.SetValue("");
                $("#sv801_Sabun_KBSABUN").val('');
                $("#sv801_Sabun_KBHANGL").val('');

                txt802_Kind.SetValue("");
                txt802_Std.SetValue("");
                txt802_Depth.SetValue("");
                $("#sv802_Sabun_KBSABUN").val('');
                $("#sv802_Sabun_KBHANGL").val('');

                txt803_Kind.SetValue("");
                txt803_Std.SetValue("");
                txt803_Depth.SetValue("");
                $("#sv803_Sabun_KBSABUN").val('');
                $("#sv803_Sabun_KBHANGL").val('');

                txt804_Kind.SetValue("");
                txt804_Std.SetValue("");
                txt804_Depth.SetValue("");
                $("#sv804_Sabun_KBSABUN").val('');
                $("#sv804_Sabun_KBHANGL").val('');

                txt805_Kind.SetValue("");
                txt805_Std.SetValue("");
                txt805_Depth.SetValue("");
                $("#sv805_Sabun_KBSABUN").val('');
                $("#sv805_Sabun_KBHANGL").val('');
            }
        }

        function GetAttachFile_Callback() {

            var WKNUM = "";

            WKNUM = txtSMWKTEAM.GetValue() + Get_Date(datSMWKDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKSEQ.GetValue()) + Get_Date(datSMWKORAPPDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKORSEQ.GetValue());

            fuName1.FileSave("SA", WKNUM.toString(), function () { });

            // 첨부파일 load
            AttachFileLod();
        }

        function AttachFileLod() {

            var WKNUM = "";

            WKNUM = txtSMWKTEAM.GetValue() + Get_Date(datSMWKDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKSEQ.GetValue()) + Get_Date(datSMWKORAPPDATE.GetValue().replace("-", "")) + Set_Fill3(txtSMWKORSEQ.GetValue());

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

            fuName1.FileLoad("SA", WKNUM, function () {
                // 로드완료

                // 프로그래스바 닫기
                PageProgressHide();
            });

        }


        <%--function fn_Mail_Send(sWOORTEAM, sWOORDATE, sWOSEQ, sWOCANCELCOMMENT, sMail_Receiver, sGUBUN, sFinish) {

            var sTitle     = "";

            var sPGURL     = "";
            var sWOWORKDOC = "";
            var sAPNUM     = "";

            var iRE_COUNT = 0;

            sAPNUM = sWOORTEAM.toString() + "-" + sWOORDATE.toString() + "-" + Set_Fill3(sWOSEQ.toString());

            sPGURL = "/Portal/PSM/PSM40/PSM4041.aspx?";
            sPGURL = sPGURL + "APP_NUM=";
            sPGURL = sPGURL + sAPNUM;
            sPGURL = sPGURL + "^GUBUN=G";

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

            var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht1["P_APNUM"]           = sAPNUM.toString();
            ht1["P_WOORTEAM"]        = sWOORTEAM.toString();
            ht1["P_WOORDATE"]        = sWOORDATE.toString();
            ht1["P_WOSEQ"]           = sWOSEQ.toString();
            ht1["P_SENDER"]          = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";
            ht1["P_RECEIVER"] = sMail_Receiver.toString();
            ht1["P_PGURL"] = sPGURL.toString();
            ht1["P_TITLE"] = sTitle.toString();
            ht1["P_WOWORKTITLE"] = txtWOWORKTITLE.GetValue();
            ht1["P_WOWORKDOC"] = sWOWORKDOC.toString();
            ht1["P_WOIMMEDTEXT"] = txtWOIMMEDTEXT.GetValue();
            ht1["P_WOCANCELCOMMENT"] = sWOCANCELCOMMENT;
            ht1["P_GUBUN"] = sGUBUN.toString();
            ht1["P_FINISH"] = sFinish.toString();

            PageMethods.InvokeServiceTable(ht1, "PSM.PSM4010", "UP_Get_Mail_List", function (e) {

                var DataSet1 = eval(e);

                if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {
                }

            }, function (e) {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');

            });

        }--%>

        function fn_Approval(sGUBUN) {


            debugger;

            var sKBSABUN = "";

            var iCOUNT = 0;

            if (txtSMCOSABUN.GetValue() != "") {
                iCOUNT = 3;
            }
            else if (txtSMGRSABUN.GetValue() != "") {
                iCOUNT = 2;
            }
            else if (txtSMORSABUN.GetValue() != "") {
                iCOUNT = 1;
            }

            var ht3 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            // 메일수신자
            sKBSABUN = fn_GET_Mail_Sabun(iCOUNT, fshdnApprovalSite, txtSMORSABUN.GetValue(), txtSMGRSABUN.GetValue(), txtSMCOSABUN.GetValue());

            if (iCOUNT != parseInt(Set_Fill3(fshdnApprovalSite))) {

                ht3["P_SMWKTEAM"]      = txtSMWKTEAM.GetValue();
                ht3["P_SMWKDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
                ht3["P_SMWKSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
                ht3["P_SMWKORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
                ht3["P_SMWKORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());
                ht3["P_APPROVALSITE"]  = fshdnApprovalSite;

                PageMethods.InvokeServiceTable(ht3, "PSM.PSM4040", "UP_SAFEORDER_APPROVAL_UPT", function (e) {

                    var DataSet3 = eval(e);

                    if (ObjectCount(DataSet3.Tables[0].Rows) > 0) {

                        fn_GET_Sign_Display(sKBSABUN, sGUBUN);

                    }
                }, function (e) {

                    alert(e);
                    //// Biz 연결오류
                    if (sGUBUN == "APPROVAL") {

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                });
            }
            else {

                fn_GET_Sign_Display(sKBSABUN, sGUBUN);
            }
        }


        function fn_GET_Sign_Display(sKBSABUN, sGUBUN) {

            var chkSWWKCODE1;
            var chkSWWKCODE2;
            var chkSWWKCODE3;
            var chkSWWKCODE4;
            var chkSWWKCODE5;
            var chkSWWKCODE7;
            var chkSWWKCODE8;
            var chkSWWKCODE9;
            var chkSWWKCODE10;

            chkSWWKCODE1 = "N";
            chkSWWKCODE2 = "N";
            chkSWWKCODE3 = "N";
            chkSWWKCODE4 = "N";
            chkSWWKCODE5 = "N";
            chkSWWKCODE7 = "N";
            chkSWWKCODE8 = "N";
            chkSWWKCODE9 = "N";
            chkSWWKCODE10 = "N";

            if ($("input:checkbox[name=chkSWWKCODE1]").prop('checked') == true) {
                chkSWWKCODE1 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE2]").prop('checked') == true) {
                chkSWWKCODE2 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE3]").prop('checked') == true) {
                chkSWWKCODE3 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE4]").prop('checked') == true) {
                chkSWWKCODE4 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE5]").prop('checked') == true) {
                chkSWWKCODE5 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE7]").prop('checked') == true) {
                chkSWWKCODE7 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE8]").prop('checked') == true) {
                chkSWWKCODE8 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE9]").prop('checked') == true) {
                chkSWWKCODE9 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE10]").prop('checked') == true) {
                chkSWWKCODE10 = "Y";
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_SMWKTEAM"]        = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"]        = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMWKSEQ"]         = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"]   = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMWKORSEQ"]       = Set_Fill3(txtSMWKORSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_APPROVAL_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtSMORSABUN.SetValue(DataSet.Tables[0].Rows[0]["SMORSABUN"].toString());
                    txtSMORNAME.SetValue(DataSet.Tables[0].Rows[0]["SMORNAME"].toString());
                    txtSMORJKCD.SetValue(DataSet.Tables[0].Rows[0]["SMORJKCD"].toString());
                    txtSMORJKCDNM.SetValue(DataSet.Tables[0].Rows[0]["SMORJKCDNM"].toString());

                    if (DataSet.Tables[0].Rows[0]["SMORAPPDATE"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["SMORAPPDATE"];
                        sTime = DataSet.Tables[0].Rows[0]["SMORAPPTIME"];

                        txtSMORAPPDATE.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtSMORAPPTIME.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('OR', DataSet.Tables[0].Rows[0]["SMORSABUN"], DataSet.Tables[0].Rows[0]["ORIMGNAME"]);

                        fshdnApprovalSite = "1";
                    }

                    txtSMGRSABUN.SetValue(DataSet.Tables[0].Rows[0]["SMGRSABUN"]);
                    txtSMGRNAME.SetValue(DataSet.Tables[0].Rows[0]["SMGRNAME"]);
                    txtSMGRJKCD.SetValue(DataSet.Tables[0].Rows[0]["SMGRJKCD"]);
                    txtSMGRJKCDNM.SetValue(DataSet.Tables[0].Rows[0]["SMGRJKCDNM"]);

                    if (DataSet.Tables[0].Rows[0]["SMGRAPPDATE"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["SMGRAPPDATE"];
                        sTime = DataSet.Tables[0].Rows[0]["SMGRAPPTIME"];

                        txtSMGRAPPDATE.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtSMGRAPPTIME.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('GR', DataSet.Tables[0].Rows[0]["SMGRSABUN"], DataSet.Tables[0].Rows[0]["GRIMGNAME"]);

                        fshdnApprovalSite = "2";
                    }

                    txtSMCOSABUN.SetValue(DataSet.Tables[0].Rows[0]["SMCOSABUN"]);
                    txtSMCONAME.SetValue(DataSet.Tables[0].Rows[0]["SMCONAME"]);
                    txtSMCOJKCD.SetValue(DataSet.Tables[0].Rows[0]["SMCOJKCD"]);
                    txtSMCOJKCDNM.SetValue(DataSet.Tables[0].Rows[0]["SMCOJKCDNM"]);

                    if (DataSet.Tables[0].Rows[0]["SMCOAPPDATE"] != "") {

                        sDate = DataSet.Tables[0].Rows[0]["SMCOAPPDATE"];
                        sTime = DataSet.Tables[0].Rows[0]["SMCOAPPTIME"];

                        txtSMCOAPPDATE.SetValue(sDate.substr(0, 4) + "-" + sDate.substr(4, 2) + "-" + sDate.substr(6, 2));
                        txtSMCOAPPTIME.SetValue(sTime.substr(0, 2) + ":" + sTime.substr(2, 2) + ":" + sTime.substr(4, 2));

                        Img_Read('CO', DataSet.Tables[0].Rows[0]["SMCOSABUN"], DataSet.Tables[0].Rows[0]["COIMGNAME"]);

                        fshdnApprovalSite = "3";
                    }

                    // this.close하면서 주석처리함
                    //fn_Get_Sign();

                    var ht1 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                    ht1["P_SMWKTEAM"]        = txtSMWKTEAM.GetValue();
                    ht1["P_SMWKDATE"]        = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
                    ht1["P_SMWKSEQ"]         = Set_Fill3(txtSMWKSEQ.GetValue());
                    ht1["P_SMWKORAPPDATE"]   = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
                    ht1["P_SMWKORSEQ"]       = Set_Fill3(txtSMWKORSEQ.GetValue());
                    ht1["P_KBSABUN"]         = sKBSABUN;
                    ht1["P_SMSMSABUN"]       = $("#svSMSMSABUN_KBSABUN").val();
                    ht1["P_hdnApprovalSite"] = fshdnApprovalSite;

                    ht1["chkSWWKCODE1"]  = chkSWWKCODE1;
                    ht1["chkSWWKCODE2"]  = chkSWWKCODE2;
                    ht1["chkSWWKCODE3"]  = chkSWWKCODE3;
                    ht1["chkSWWKCODE4"]  = chkSWWKCODE4;
                    ht1["chkSWWKCODE5"]  = chkSWWKCODE5;
                    ht1["chkSWWKCODE7"]  = chkSWWKCODE7;
                    ht1["chkSWWKCODE8"]  = chkSWWKCODE8;
                    ht1["chkSWWKCODE9"]  = chkSWWKCODE9;
                    ht1["chkSWWKCODE10"] = chkSWWKCODE10;

                    ht1["P_SMCOSABUN"]   = txtSMCOSABUN.GetValue();
                    ht1["P_SMGRSABUN"]   = txtSMGRSABUN.GetValue();
                    ht1["P_SMORSABUN"]   = txtSMORSABUN.GetValue();
                    ht1["P_SMWORKTITLE"] = txtSMWORKTITLE.GetValue();
                    ht1["P_SMAREATEXT1"] = txtSMAREATEXT1.GetValue();

                    ht1["P_SMOPSABUN"]   = $("#svSMOPSABUN_KBSABUN").val();

                    ht1["P_SMSYSTEMCODE1"] = txtSMSYSTEMCODE1.GetValue();
                    ht1["P_SMSYSTEMCODE2"] = txtSMSYSTEMCODE2.GetValue();
                    ht1["P_SMSYSTEMCODE3"] = txtSMSYSTEMCODE3.GetValue();
                    ht1["P_SMSYSTEMCODE4"] = txtSMSYSTEMCODE4.GetValue();
                    ht1["P_SMSYSTEMCODE5"] = txtSMSYSTEMCODE5.GetValue();

                    ht1["P_SHH"]           = Set_Fill2(txtSMTATIME1_ST.GetValue());
                    ht1["P_SMM"]           = Set_Fill2(txtSMTATIME1_ED.GetValue());

                    ht1["P_EHH"]           = Set_Fill2(txtSMTATIME2_ST.GetValue());
                    ht1["P_EMM"]           = Set_Fill2(txtSMTATIME2_ED.GetValue());

                    PageMethods.InvokeServiceTable(ht1, "PSM.PSM4040", "UP_MAIL", function (e) {

                        var DataSet1 = eval(e);

                        if (ObjectCount(DataSet1.Tables[0].Rows) > 0) {

                            if (DataSet1.Tables[0].Rows[0]["STATE"].toString() == "OK") {

                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="결재 처리 되었습니다." Literal="true"></Ctl:Text>');

                                fn_Field_ReadOnly();

                                debugger;

                                if (opener != null && typeof (opener.btnSearch_Click()) == "function") {
                                    opener.btnSearch_Click();
                                }

                                this.close();
                            }
                            else {
                                
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                            }
                        }

                    }, function (e) {
                        //// Biz 연결오류
                        if (sGUBUN.toString() == "APPROVAL") {
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="메일 발송 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        }
                        else {
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                        }

                    });

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

        function fn_btnSMCanCel_Visible(bVisible1, bVisible2) {

            svSMCNSABUN.SetDisabled(bVisible1);
            //$("#svSMCNSABUN_KBSABUN").SetDisabled(bVisible1);

            txtSMCNREASON.SetDisabled(bVisible1);

            if (bVisible2 == true) {
                btnSMCanCel.Show();
            }
            else if (bVisible2 == false) {
                btnSMCanCel.Hide();
            }
        }

        //function AttachFileLod(gubun, key) {

        //    document.getElementById("fuName1_filedata").value = "";

        //    fuName1.FileLoad(gubun, key, function () {
        //        // 로드완료

        //        // 프로그래스바 닫기
        //        PageProgressHide();
        //    });

        //}

        function fn_btnSMFOK_Visible(bVisible1, bVisible2, bVisible3, bVisible5, bVisible6) {

            svSMFSSABUN.SetDisabled(bVisible1);

            if (bVisible1 == true) {                
                $("#svSMFSSABUN_KBSABUN_img").attr("style", "display:yes");
            }
            else if (bVisible1 == true) {
                $("#svSMFSSABUN_KBSABUN_img").attr("style", "display:none");                
            }

            if (bVisible2 == true) {
                btnSMFOK.Show();
            }
            else if (bVisible2 == false) {
                btnSMFOK.Hide();
            }

            if (bVisible3 == true) {
                btnPrt.Show();
            }
            else if (bVisible3 == false) {
                btnPrt.Hide();
            }

            if (bVisible5 == true) {
                btnGas1.Show();
                btnGas2.Show();
            }
            else if (bVisible5 == false) {
                btnGas1.Hide();
                btnGas2.Hide();
            }

            chkSMFSWKCLOSE.SetDisabled(bVisible6);
        }

        function fn_btnSMFSWKCANCEL_Visible(bVisible, bVisible3) {

            chkSMFSWKCANCEL.SetDisabled(bVisible);

            if (bVisible3 == true) {
                btnSMFSWKCANCEL.Show();
            }
            else if (bVisible3 == false) {
                btnSMFSWKCANCEL.Hide();
            }
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

        // 안전환경팀 확인
        function btnSAFE_Click() {

            if ($("#svSMSMSABUN_KBSABUN").val() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="안전팀 확인자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtSMSMCOMMENT.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="의견을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var today = new Date();

            var now = new Date();

            txtSMSMAPPDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            txtSMSMAPPTIME.SetValue(Set_Fill2(now.getHours().toString()) + ':' + Set_Fill2(now.getMinutes().toString()) + ':' + Set_Fill2(now.getSeconds().toString()));


            
            // 작업요청 작업완료 사번,일자,의견 업데이트

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_SMSMSABUN"]     = $("#svSMSMSABUN_KBSABUN").val();
            ht["P_SMSMAPPDATE"] = txtSMSMAPPDATE.GetValue().replace("-", "");
            ht["P_SMSMAPPTIME"]   = txtSMSMAPPTIME.GetValue().replace(":","");
            ht["P_SMSMCOMMENT"]   = txtSMSMCOMMENT.GetValue();

            ht["P_SMWKTEAM"]      = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMWKSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMWKORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

            // 업데이트 및 확인 해야 함

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_SAFETY_UPT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        fn_btnSMFOK_Visible(true, false, true, false, true);

                        fn_Field_ReadOnly();

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 담장자가 확인하였습니다." Literal="true"></Ctl:Text>');
                    }
                    else {
                        var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                    }
                }
                else {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 담장자 확인 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 담장자 확인 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

        // 운영팀 확인
        function btnOPerate_Click() {

            $("#svSMSMSABUN_KBSABUN").val("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>");

            if (txtSMOPCOMMENT.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="의견을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var today = new Date();

            var now = new Date();

            txtSMOPAPPDATE.SetValue(today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate()));
            txtSMOPAPPTIME.SetValue(Set_Fill2(now.getHours().toString()) + ':' + Set_Fill2(now.getMinutes().toString()) + ':' + Set_Fill2(now.getSeconds().toString()));

            // 작업요청 작업완료 사번,일자,의견 업데이트

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_SMOPSABUN"]     = $("#svSMOPSABUN_KBSABUN").val();
            ht["P_SMOPAPPDATE"]   = txtSMOPAPPDATE.GetValue();
            ht["P_SMOPAPPTIME"]   = txtSMOPAPPTIME.GetValue().replace(":", "");
            ht["P_SMOPCOMMENT"]   = txtSMOPCOMMENT.GetValue();

            ht["P_SMWKTEAM"]      = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMWKSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMWKORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_OPERA_UPT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        fn_btnSMFOK_Visible(true, false, true, false, true);

                        fn_Field_ReadOnly();

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="운영팀 담장자가 확인하였습니다." Literal="true"></Ctl:Text>');
                    }
                    else {
                        var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                    }
                }
                else {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="운영팀 담장자 확인 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="운영팀 담장자 확인 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }








        // 작업 완료
        function btnSMFOK_Click() {

            var today = new Date();
            var now   = new Date();
            var sSMFSTIME = '';

            var sChkValue;

            debugger;

            if ($("input:checkbox[name=chkSMFSWKCLOSE]").prop('checked') == true) {
                sChkValue = "Y";
            }
            else {
                sChkValue = "N";
            }

            debugger;

            if (sChkValue == "Y") {

                if (txtSMFSWKTEXT.GetValue() == "") {

                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="의견을 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }
            else {
                txtSMFSWKTEXT.SetValue("");
            }

            if ($("#svSMFSSABUN_KBSABUN").val() == "") {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="작업 승인자를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            else {
                if (txtSMFSDATE.GetValue() == "") {
                    txtSMFSDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
                }
            }

            debugger;

            if ($("input:checkbox[name=chkSWWKCODE2]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE3]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE4]").prop('checked') == true ||
                $("input:checkbox[name=chkSWWKCODE5]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE7]").prop('checked') == true ||
                $("input:checkbox[name=chkSWWKCODE8]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE9]").prop('checked') == true) {

                if ($("#svSMSMSABUN_KBSABUN").val() == "") {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="안전환경팀 확인자를 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }

                if (txtSMSMCOMMENT.GetValue() == "") {

                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="의견을 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }

                if (txtSMSMAPPDATE.GetValue() == "" || txtSMSMAPPTIME.GetValue() == "") {

                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="안전환경팀에서 확인을 해야 합니다." Literal="true"></Ctl:Text>');
                    return false;
                }
            }

            debugger;

            // BIN CLEANING체크될 경우에만 실행 됨
            if ($("input:checkbox[name=chkSWWKCODE5]").prop('checked') == true) {

                // BIN 상태관리 업데이트
                fn_BIN_STATUSMF_UPDATE();
            }

            if (txtSMFSDATE.GetValue() == "") {
                txtSMFSDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
            }

            debugger;
            if (txtSMFSTIME_HH.GetValue() == '') {
                txtSMFSTIME_HH.SetValue(Set_Fill2(now.getHours().toString()));
                txtSMFSTIME_MM.SetValue(Set_Fill2(now.getMinutes().toString()));
                txtSMFSTIME_SS.SetValue(Set_Fill2(now.getSeconds().toString()));
            }

            sSMFSTIME = Set_Fill2(txtSMFSTIME_HH.GetValue()) + Set_Fill2(txtSMFSTIME_MM.GetValue()) + Set_Fill2(txtSMFSTIME_SS.GetValue());
            
            debugger;

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_SMSYSTEMCODE1"] = txtSMSYSTEMCODE1.GetValue();
            ht["P_SMSYSTEMCODE2"] = txtSMSYSTEMCODE2.GetValue();
            ht["P_SMSYSTEMCODE3"] = txtSMSYSTEMCODE3.GetValue();
            ht["P_SMSYSTEMCODE4"] = txtSMSYSTEMCODE4.GetValue();
            ht["P_SMSYSTEMCODE5"] = txtSMSYSTEMCODE5.GetValue();
            ht["P_SMSUBVEND"]     = txtSMSUBVEND.GetValue();

            ht["P_HDNBUSEO"]      = fsHdnBuseo;

            ht["P_SMWORKTITLE"]   = txtSMWORKTITLE.GetValue();
            ht["P_SMAREATEXT1"]   = txtSMAREATEXT1.GetValue();

            ht["P_SMFSSABUN"]     = $("#svSMFSSABUN_KBSABUN").val();
            ht["P_SMFSDATE"]      = txtSMFSDATE.GetValue();
            ht["P_SMFSTIME"]      = sSMFSTIME;
            ht["P_SMFSWKCLOSE"]   = sChkValue;
            ht["P_SMFSWKTEXT"]    = txtSMFSWKTEXT.GetValue();

            ht["P_SMWKTEAM"]      = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMWKSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMWKORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

            debugger;

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_FINISH_UPT", function (e) {

                debugger;

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        debugger;

                        fn_btnSMFOK_Visible(true, false, true, false, true);

                        fn_btnSMFSWKCANCEL_Visible(false, true);

                        fn_Field_ReadOnly();

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업이 완료 되었습니다." Literal="true"></Ctl:Text>');
                    }
                    else {
                        var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
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


        // 공사완료 취소
        function btnSMFSWKCANCEL_Click() {

            var today = new Date();
            var now = new Date();

            var sChkValue;

            if ($("input:checkbox[name=chkSMFSWKCANCEL]").prop('checked') == true) {
                sChkValue = "Y";
            }
            else {
                sChkValue = "N";
            }

            debugger;

            if (sChkValue == "Y") {

                $("#svSMFSSABUN_KBSABUN").val('');
                $("#svSMFSSABUN_KBHANGL").val('');

                txtSMFSWKTEXT.SetValue('');

                txtSMFSDATE.SetValue('');

                txtSMFSTIME_HH.SetValue('');
                txtSMFSTIME_MM.SetValue('');
                txtSMFSTIME_SS.SetValue('');


                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["P_SMFSSABUN"]     = "";
                ht["P_SMFSDATE"]      = "";
                ht["P_SMFSTIME"]      = "";
                ht["P_SMFSWKCLOSE"]   = "";
                ht["P_SMFSWKTEXT"]    = txtSMFSWKTEXT.GetValue();
                ht["P_SMFSWKCANCEL"]  = sChkValue;

                ht["P_SMWKTEAM"]      = txtSMWKTEAM.GetValue();
                ht["P_SMWKDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
                ht["P_SMWKSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
                ht["P_SMWKORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
                ht["P_SMWKORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

                debugger;

                PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_CANCEL_UPT", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            fn_btnSMFOK_Visible(false, true, true, true, false);

                            fn_btnSMFSWKCANCEL_Visible(true, false);

                            fn_Field_ReadOnly();

                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="공사 취소작업이 완료 되었습니다." Literal="true"></Ctl:Text>');
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="공사 취소작업 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="공사 취소작업 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        // 작업 취소
        function btnSMCanCel_Click() {

            var chkSWWKCODE2;
            var chkSWWKCODE3;
            var chkSWWKCODE4;
            var chkSWWKCODE5;
            var chkSWWKCODE7;
            var chkSWWKCODE8;
            var chkSWWKCODE9;
            var chkSWWKCODE10;

            if ($("#svSMCNSABUN_KBSABUN").val() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="취소 사번을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            if (txtSMCNREASON.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="취소 의견을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var today = new Date();

            var now = new Date();

            // 취소일자
            txtSMCNDATE.SetValue(today.getFullYear() + CalLpad((today.getMonth() + 1)) + CalLpad(today.getDate()));
            // 취소시간
            txtSMCNTIME.SetValue(Set_Fill2(now.getHours().toString()) + ':' + Set_Fill2(now.getMinutes().toString()) + ':' + Set_Fill2(now.getSeconds().toString()));


            chkSWWKCODE2 = "N";
            chkSWWKCODE3 = "N";
            chkSWWKCODE4 = "N";
            chkSWWKCODE5 = "N";
            chkSWWKCODE7 = "N";
            chkSWWKCODE8 = "N";
            chkSWWKCODE9 = "N";
            chkSWWKCODE10 = "N";

            if ($("input:checkbox[name=chkSWWKCODE2]").prop('checked') == true) {
                chkSWWKCODE2 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE3]").prop('checked') == true) {
                chkSWWKCODE3 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE4]").prop('checked') == true) {
                chkSWWKCODE4 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE5]").prop('checked') == true) {
                chkSWWKCODE5 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE7]").prop('checked') == true) {
                chkSWWKCODE7 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE8]").prop('checked') == true) {
                chkSWWKCODE8 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE9]").prop('checked') == true) {
                chkSWWKCODE9 = "Y";
            }

            if ($("input:checkbox[name=chkSWWKCODE10]").prop('checked') == true) {
                chkSWWKCODE10 = "Y";
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["P_HDNBUSEO"]      = fsHdnBuseo;

            ht["P_SMCNSABUN"]     = $("#svSMCNSABUN_KBSABUN").val();
            ht["P_SMCNSABUNNM"]   = $("#svSMCNSABUN_KBHANGL").val();
            ht["P_SMCNDATE"]      = txtSMCNDATE.GetValue();
            ht["P_SMCNTIME"]      = txtSMCNTIME.GetValue().replace(':', '');
            ht["P_SMCNREASON"]    = txtSMCNREASON.GetValue();


            ht["P_SWWKCODE2"]     = chkSWWKCODE2;
            ht["P_SWWKCODE3"]     = chkSWWKCODE3;
            ht["P_SWWKCODE4"]     = chkSWWKCODE4;
            ht["P_SWWKCODE5"]     = chkSWWKCODE5;
            ht["P_SWWKCODE7"]     = chkSWWKCODE7;
            ht["P_SWWKCODE8"]     = chkSWWKCODE8;
            ht["P_SWWKCODE9"]     = chkSWWKCODE9;
            ht["P_SWWKCODE10"]    = chkSWWKCODE10;

            ht["P_SMORSABUN"]     = txtSMORSABUN.GetValue();
            ht["P_SMGRSABUN"]     = txtSMGRSABUN.GetValue();
            ht["P_SMCOSABUN"]     = txtSMCOSABUN.GetValue();
            ht["P_SMCNREASON"]    = txtSMCNREASON.GetValue();

            ht["P_SMWKTEAM"]      = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMWKSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMWKORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_SAFEORDER_WORK_CANCEL", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                        fn_btnSMFOK_Visible(false, true, true, true, false);

                        fn_Field_ReadOnly();

                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 취소가 완료 되었습니다." Literal="true"></Ctl:Text>');
                    }
                    else {
                        var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                    }
                }
                else {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 취소 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                }

            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="작업 취소 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }
        

        function fn_Field_ReadOnly() {
            var buseo;

            buseo = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode%>";

            if ((txtSMSYSTEMCODE1.GetValue().toString().substr(0, 1) == 'S' || txtSMSYSTEMCODE1.GetValue().toString().substr(0, 1) == 'T') &&
                buseo.toString().substr(0, 2) == 'D1') {
                fn_Field_SetDisabled(true);
            }
            else {
                fn_Field_SetDisabled(false);
            }
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

                    ht2["P_WOFINISHDATE"]  = txtWOFINISHDATE.GetValue();
                    ht2["P_WOFINISHSABUN"] = $("#svWOFINISHSABUN_KBSABUN").val();
                    ht2["P_WOFINISHTEXT"]  = txtWOFINISHTEXT.GetValue();
                    ht2["P_WOORTEAM"]      = txtSMWKTEAM.GetValue();
                    ht2["P_WOORDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
                    ht2["P_WOSEQ"]         = Set_Fill3(txtSMWKSEQ.GetValue());

                    PageMethods.InvokeServiceTable(ht2, "PSM.PSM4010", "UP_WORKORDER_FINISH_UPT", function (e) {

                        var DataSet2 = eval(e);

                        if (ObjectCount(DataSet2.Tables[0].Rows) == 1) {

                            if (DataSet2.Tables[0].Rows[0]["STATE"] == "OK") {

                                fn_FINISH_Visible(false);

                                // 작업요청 작업완료 사번,일자,의견 업데이트

                                var ht3 = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                                ht3["P_WOIMMEDDATE"]  = txtWOIMMEDDATE.GetValue();
                                ht3["P_WOIMMEDSABUN"] = $("#svWOIMMEDSABUN_KBSABUN").val();
                                ht3["P_WOIMMEDTEXT"]  = txtWOIMMEDTEXT.GetValue();
                                ht3["P_WOORTEAM"]     = txtSMWKTEAM.GetValue();
                                ht3["P_WOORDATE"]     = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
                                ht3["P_WOSEQ"]        = Set_Fill3(txtSMWKSEQ.GetValue());
                                ht3["P_GUBUN"]        = "FINISH";

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

                ht3["P_WOIMMEDDATE"]  = txtWOIMMEDDATE.GetValue();
                ht3["P_WOIMMEDSABUN"] = $("#svWOIMMEDSABUN_KBSABUN").val();
                ht3["P_WOIMMEDTEXT"]  = txtWOIMMEDTEXT.GetValue();
                ht3["P_WOORTEAM"]     = txtSMWKTEAM.GetValue();
                ht3["P_WOORDATE"]     = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
                ht3["P_WOSEQ"]        = Set_Fill3(txtSMWKSEQ.GetValue());
                ht3["P_GUBUN"]        = "FINISH";

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
            else if (id == "SMSYSTEMCODE1" || id == "SMSYSTEMCODE2" || id == "SMSYSTEMCODE3" || id == "SMSYSTEMCODE4" || id == "SMSYSTEMCODE5") {
                // 설비코드
                fn_OpenPop("../POP/PSP1030.aspx", 1000, 600);
            }
        }

        // 콜백 함수
        function btnPopup_Last_Callback(COMMENT, WOIMMEDGUBN, WOIMMEDTEXT) {

            var sFinish = "";
            var iRE_COUNT = 0;
            var sSABUN = "";
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
            //        ht["P_WOORTEAM"]      = txtSMWKTEAM.GetValue();
            //        ht["P_WOORDATE"]      = datSMWKDATE.GetValue();
            //        ht["P_WOSEQ"]         = txtSMWKSEQ.GetValue();

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
            //                    ht1["P_WOORTEAM"]     = txtSMWKTEAM.GetValue();
            //                    ht1["P_WOORDATE"]     = datSMWKDATE.GetValue();
            //                    ht1["P_WOSEQ"]        = txtSMWKSEQ.GetValue();
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
            //    ht["P_WOORTEAM"]     = txtSMWKTEAM.GetValue();
            //    ht["P_WOORDATE"]     = datSMWKDATE.GetValue();
            //    ht["P_WOSEQ"]        = txtSMWKSEQ.GetValue();
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




        // 버튼

        // 연장허가자 버튼
        function btnSMOT_Click() {

            debugger;
            // 오라클 테스트
            //fn_oracle_test();

            debugger;

            if (Get_Date(datSMOTDATE1.GetValue().replace("-", "")) == "") {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 시작일자를 입력하세요." Literal="true"></Ctl:Text>');

                return;
            }

            if (txtSMOTTIME1_ST.GetValue() == "") {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 시작 시를 입력하세요." Literal="true"></Ctl:Text>');

                return;
            }

            if (txtSMOTTIME1_ED.GetValue() == "") {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 시작 분을 입력하세요." Literal="true"></Ctl:Text>');

                return;
            }

            if (Get_Date(datSMOTDATE2.GetValue().replace("-", "")) == "") {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 종료일자를 입력하세요." Literal="true"></Ctl:Text>');

                return;
            }

            if (txtSMOTTIME2_ST.GetValue() == "") {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 종료 시를 입력하세요." Literal="true"></Ctl:Text>');

                return;
            }

            if (txtSMOTTIME2_ED.GetValue() == "") {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 종료 분을 입력하세요." Literal="true"></Ctl:Text>');

                return;
            }

            var sSDATE;
            var sSHH;
            var sSMM;
            var sEDATE;
            var sEHH;
            var sEMM;

            var sHOUR;
            var sSTIME;
            var sETIME;

            sSDATE = Get_Date(datSMOTDATE1.GetValue().replace("-", ""));
            sSHH   = Set_Fill2(txtSMOTTIME1_ST.GetValue());
            sSMM   = Set_Fill2(txtSMOTTIME1_ED.GetValue());

            sHOUR = sSDATE.toString() + sSHH.toString() + sSMM.toString();

            sSTIME = parseFloat(sHOUR);

            sEDATE = Get_Date(datSMOTDATE2.GetValue().replace("-", ""));
            sEHH   = Set_Fill2(txtSMOTTIME2_ST.GetValue());
            sEMM   = Set_Fill2(txtSMOTTIME2_ED.GetValue());

            sHOUR = sEDATE.toString() + sEHH.toString() + sEMM.toString();

            sETIME = parseFloat(sHOUR);

            if (parseFloat(sETIME) < parseFloat(sSTIME)) {

                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장 작업시간을 확인하세요." Literal="true"></Ctl:Text>');

                return;
            }

            var sSMOTTIME1;
            var sSMOTTIME2;

            if (txtSMOTTIME1_ST.GetValue() != "" && txtSMOTTIME1_ED.GetValue() != "") {
                sSMOTTIME1 = Set_Fill2(txtSMOTTIME1_ST.GetValue()) + Set_Fill2(txtSMOTTIME1_ED.GetValue());
            }

            if (txtSMOTTIME2_ST.GetValue() != "" && txtSMOTTIME2_ED.GetValue() != "") {
                sSMOTTIME2 = Set_Fill2(txtSMOTTIME2_ST.GetValue()) + Set_Fill2(txtSMOTTIME2_ED.GetValue());
            }

            var i = 0;
            var DataSet;
            var ht = new Object();

            ht["P_HDNBUSEO"]      = fsHdnBuseo;
            ht["P_SMOTDATE1"]     = Get_Date(datSMOTDATE1.GetValue().replace("-", ""));
            ht["P_SMOTTIME1"]     = sSMOTTIME1;
            ht["P_SMOTDATE2"]     = Get_Date(datSMOTDATE2.GetValue().replace("-", ""));
            ht["P_SMOTTIME2"]     = sSMOTTIME2;
            ht["P_SMOTAPPSABUN"]  = $("#svSMOTAPPSABUN_KBSABUN").val();
            ht["P_SMWKTEAM"]      = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"]      = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMWKSEQ"]       = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"] = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMWKORSEQ"]     = Set_Fill3(txtSMWKORSEQ.GetValue());


            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_EXTENSION_CONFIRM", function (e) {

                DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {

                        if (DataSet.Tables[0].Rows[i]["SEQ"] == "1") {

                            $("#svSMOTAPPSABUN_KBHANGL").val(DataSet.Tables[0].Rows[0]["KBHANGL"]);

                            if (DataSet.Tables[0].Rows[i]["STATE"] == "ERR") {
                                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 연장 허가자의 부서가 다릅니다. 연장허가자를 확인하세요." Literal="true"></Ctl:Text>');

                                return;
                            }
                        }

                        if (DataSet.Tables[0].Rows[i]["SEQ"] == "2") {
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장시간이 수정 되었습니다." Literal="true"></Ctl:Text>');
                        }
                    }

                }
            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="연장시간 수정 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }

        // 점검자 버튼
        function btnGas_Click(gubun) {

            var sSMCHKTIME1 = "";
            var sSMCHKTIME2 = "";
            var sSMCHKTIME3 = "";
            var sSMCHKTIME4 = "";
            var sSMCHKTIME5 = "";
            var sSMCHKTIME6 = "";
            var sSMCHKTIME7 = "";
            var sSMCHKTIME8 = "";

            if (txtSMCHKTIME1_HH.GetValue() != "" && txtSMCHKTIME1_MM.GetValue() != "") {

                sSMCHKTIME1 = Set_Fill2(txtSMCHKTIME1_HH.GetValue()) + Set_Fill2(txtSMCHKTIME1_MM.GetValue());
            }

            if (txtSMCHKTIME2_HH.GetValue() != "" && txtSMCHKTIME2_MM.GetValue() != "") {

                sSMCHKTIME2 = Set_Fill2(txtSMCHKTIME2_HH.GetValue()) + Set_Fill2(txtSMCHKTIME2_MM.GetValue());
            }

            if (txtSMCHKTIME3_HH.GetValue() != "" && txtSMCHKTIME3_MM.GetValue() != "") {

                sSMCHKTIME3 = Set_Fill2(txtSMCHKTIME3_HH.GetValue()) + Set_Fill2(txtSMCHKTIME3_MM.GetValue());
            }

            if (txtSMCHKTIME4_HH.GetValue() != "" && txtSMCHKTIME4_MM.GetValue() != "") {

                sSMCHKTIME4 = Set_Fill2(txtSMCHKTIME4_HH.GetValue()) + Set_Fill2(txtSMCHKTIME4_MM.GetValue());
            }

            if (txtSMCHKTIME5_HH.GetValue() != "" && txtSMCHKTIME5_MM.GetValue() != "") {

                sSMCHKTIME5 = Set_Fill2(txtSMCHKTIME5_HH.GetValue()) + Set_Fill2(txtSMCHKTIME5_MM.GetValue());
            }

            if (txtSMCHKTIME6_HH.GetValue() != "" && txtSMCHKTIME6_MM.GetValue() != "") {

                sSMCHKTIME6 = Set_Fill2(txtSMCHKTIME6_HH.GetValue()) + Set_Fill2(txtSMCHKTIME6_MM.GetValue());
            }

            if (txtSMCHKTIME7_HH.GetValue() != "" && txtSMCHKTIME7_MM.GetValue() != "") {

                sSMCHKTIME7 = Set_Fill2(txtSMCHKTIME7_HH.GetValue()) + Set_Fill2(txtSMCHKTIME7_MM.GetValue());
            }

            if (txtSMCHKTIME8_HH.GetValue() != "" && txtSMCHKTIME8_MM.GetValue() != "") {

                sSMCHKTIME8 = Set_Fill2(txtSMCHKTIME8_HH.GetValue()) + Set_Fill2(txtSMCHKTIME8_MM.GetValue());
            }

            var chk = '';

            var i = 0;
            var ht = new Object();

            ht["P_GUBUN"]             = gubun;
            ht["P_HDNBUSEO"]          = fsHdnBuseo;
            ht["P_SMCHKSABUN1"]       = $("#svSMCHKSABUN1_KBSABUN").val();
            ht["P_SMCHKTIME1"]        = sSMCHKTIME1;
            ht["P_SMCHKOXYGEN1"]      = txtSMCHKOXYGEN1.GetValue();
            ht["P_SMCHKOXYGENUNIT1"]  = cboSMCHKOXYGENUNIT1.GetValue();
            ht["P_SMCHKTOXNUM1"]      = Get_Numeric(txtSMCHKTOXNUM1.GetValue());
            ht["P_SMCHKTOXUNIT1"]     = cboSMCHKTOXUNIT1.GetValue();
            ht["P_SMCHKTOXNUM1DS"]    = Get_Numeric(txtSMCHKTOXNUM1DS.GetValue());
            ht["P_SMCHKTOXUNIT1DS"]   = cboSMCHKTOXUNIT1DS.GetValue();
            ht["P_SMCHKTOXNUM1CO2"]   = Get_Numeric(txtSMCHKTOXNUM1CO2.GetValue());
            ht["P_SMCHKTOXUNIT1CO2"]  = cboSMCHKTOXUNIT1CO2.GetValue();
            ht["P_SMCHKTOXNUM1CO"]    = Get_Numeric(txtSMCHKTOXNUM1CO.GetValue());
            ht["P_SMCHKTOXUNIT1CO"]   = cboSMCHKTOXUNIT1CO.GetValue();
            ht["P_SMCHKTOXNUM1H2S"]   = Get_Numeric(txtSMCHKTOXNUM1H2S.GetValue());
            ht["P_SMCHKTOXUNIT1H2S"]  = cboSMCHKTOXUNIT1H2S.GetValue();
            ht["P_SMCHKSABUN2"]       = $("#svSMCHKSABUN2_KBSABUN").val();
            ht["P_SMCHKTIME2"]        = sSMCHKTIME2;
            ht["P_SMCHKOXYGEN2"]      = txtSMCHKOXYGEN2.GetValue();
            ht["P_SMCHKOXYGENUNIT2"]  = cboSMCHKOXYGENUNIT2.GetValue();
            ht["P_SMCHKTOXNUM2"]      = Get_Numeric(txtSMCHKTOXNUM2.GetValue());
            ht["P_SMCHKTOXUNIT2"]     = cboSMCHKTOXUNIT2.GetValue();
            ht["P_SMCHKTOXNUM2DS"]    = Get_Numeric(txtSMCHKTOXNUM2DS.GetValue());
            ht["P_SMCHKTOXUNIT2DS"]   = cboSMCHKTOXUNIT2DS.GetValue();
            ht["P_SMCHKTOXNUM2CO2"]   = Get_Numeric(txtSMCHKTOXNUM2CO2.GetValue());
            ht["P_SMCHKTOXUNIT2CO2"]  = cboSMCHKTOXUNIT2CO2.GetValue();
            ht["P_SMCHKTOXNUM2CO"]    = Get_Numeric(txtSMCHKTOXNUM2CO.GetValue());
            ht["P_SMCHKTOXUNIT2CO"]   = cboSMCHKTOXUNIT2CO.GetValue();
            ht["P_SMCHKTOXNUM2H2S"]   = Get_Numeric(txtSMCHKTOXNUM2H2S.GetValue());
            ht["P_SMCHKTOXUNIT2H2S"]  = cboSMCHKTOXUNIT2H2S.GetValue();
            ht["P_SMCHKSABUN3"]       = $("#svSMCHKSABUN3_KBSABUN").val();
            ht["P_SMCHKTIME3"]        = sSMCHKTIME3;
            ht["P_SMCHKOXYGEN3"]      = txtSMCHKOXYGEN3.GetValue();
            ht["P_SMCHKOXYGENUNIT3"]  = cboSMCHKOXYGENUNIT3.GetValue();
            ht["P_SMCHKTOXNUM3"]      = Get_Numeric(txtSMCHKTOXNUM3.GetValue());
            ht["P_SMCHKTOXUNIT3"]     = cboSMCHKTOXUNIT3.GetValue();
            ht["P_SMCHKTOXNUM3DS"]    = Get_Numeric(txtSMCHKTOXNUM3DS.GetValue());
            ht["P_SMCHKTOXUNIT3DS"]   = cboSMCHKTOXUNIT3DS.GetValue();
            ht["P_SMCHKTOXNUM3CO2"]   = Get_Numeric(txtSMCHKTOXNUM3CO2.GetValue());
            ht["P_SMCHKTOXUNIT3CO2"]  = cboSMCHKTOXUNIT3CO2.GetValue();
            ht["P_SMCHKTOXNUM3CO"]    = Get_Numeric(txtSMCHKTOXNUM3CO.GetValue());
            ht["P_SMCHKTOXUNIT3CO"]   = cboSMCHKTOXUNIT3CO.GetValue();
            ht["P_SMCHKTOXNUM3H2S"]   = Get_Numeric(txtSMCHKTOXNUM3H2S.GetValue());
            ht["P_SMCHKTOXUNIT3H2S"]  = cboSMCHKTOXUNIT3H2S.GetValue();
            ht["P_SMCHKSABUN4"]       = $("#svSMCHKSABUN4_KBSABUN").val();
            ht["P_SMCHKTIME4"]        = sSMCHKTIME4;
            ht["P_SMCHKOXYGEN4"]      = txtSMCHKOXYGEN4.GetValue();
            ht["P_SMCHKOXYGENUNIT4"]  = cboSMCHKOXYGENUNIT4.GetValue();
            ht["P_SMCHKTOXNUM4"]      = Get_Numeric(txtSMCHKTOXNUM4.GetValue());
            ht["P_SMCHKTOXUNIT4"]     = cboSMCHKTOXUNIT4.GetValue();
            ht["P_SMCHKTOXNUM4DS"]    = Get_Numeric(txtSMCHKTOXNUM4DS.GetValue());
            ht["P_SMCHKTOXUNIT4DS"]   = cboSMCHKTOXUNIT4DS.GetValue();
            ht["P_SMCHKTOXNUM4CO2"]   = Get_Numeric(txtSMCHKTOXNUM4CO2.GetValue());
            ht["P_SMCHKTOXUNIT4CO2"]  = cboSMCHKTOXUNIT4CO2.GetValue();
            ht["P_SMCHKTOXNUM4CO"]    = Get_Numeric(txtSMCHKTOXNUM4CO.GetValue());
            ht["P_SMCHKTOXUNIT4CO"]   = cboSMCHKTOXUNIT4CO.GetValue();
            ht["P_SMCHKTOXNUM4H2S"]   = Get_Numeric(txtSMCHKTOXNUM4H2S.GetValue());
            ht["P_SMCHKTOXUNIT4H2S"]  = cboSMCHKTOXUNIT4H2S.GetValue();
            ht["P_SMCHKSABUN5"]       = $("#svSMCHKSABUN5_KBSABUN").val();
            ht["P_SMCHKTIME5"]        = sSMCHKTIME5;
            ht["P_SMCHKOXYGEN5"]      = txtSMCHKOXYGEN5.GetValue();
            ht["P_SMCHKOXYGENUNIT5"]  = cboSMCHKOXYGENUNIT5.GetValue();
            ht["P_SMCHKTOXNUM5"]      = Get_Numeric(txtSMCHKTOXNUM5.GetValue());
            ht["P_SMCHKTOXUNIT5"]     = cboSMCHKTOXUNIT5.GetValue();
            ht["P_SMCHKTOXNUM5DS"]    = Get_Numeric(txtSMCHKTOXNUM5DS.GetValue());
            ht["P_SMCHKTOXUNIT5DS"]   = cboSMCHKTOXUNIT5DS.GetValue();
            ht["P_SMCHKTOXNUM5CO2"]   = Get_Numeric(txtSMCHKTOXNUM5CO2.GetValue());
            ht["P_SMCHKTOXUNIT5CO2"]  = cboSMCHKTOXUNIT5CO2.GetValue();
            ht["P_SMCHKTOXNUM5CO"]    = Get_Numeric(txtSMCHKTOXNUM5CO.GetValue());
            ht["P_SMCHKTOXUNIT5CO"]   = cboSMCHKTOXUNIT5CO.GetValue();
            ht["P_SMCHKTOXNUM5H2S"]   = Get_Numeric(txtSMCHKTOXNUM5H2S.GetValue());
            ht["P_SMCHKTOXUNIT5H2S"]  = cboSMCHKTOXUNIT5H2S.GetValue();
            ht["P_SMCHKSABUN6"]       = $("#svSMCHKSABUN6_KBSABUN").val();
            ht["P_SMCHKTIME6"]        = sSMCHKTIME6;
            ht["P_SMCHKOXYGEN6"]      = txtSMCHKOXYGEN6.GetValue();
            ht["P_SMCHKOXYGENUNIT6"]  = cboSMCHKOXYGENUNIT6.GetValue();
            ht["P_SMCHKTOXNUM6"]      = Get_Numeric(txtSMCHKTOXNUM6.GetValue());
            ht["P_SMCHKTOXUNIT6"]     = cboSMCHKTOXUNIT6.GetValue();
            ht["P_SMCHKTOXNUM6DS"]    = Get_Numeric(txtSMCHKTOXNUM6DS.GetValue());
            ht["P_SMCHKTOXUNIT6DS"]   = cboSMCHKTOXUNIT6DS.GetValue();
            ht["P_SMCHKTOXNUM6CO2"]   = Get_Numeric(txtSMCHKTOXNUM6CO2.GetValue());
            ht["P_SMCHKTOXUNIT6CO2"]  = cboSMCHKTOXUNIT6CO2.GetValue();
            ht["P_SMCHKTOXNUM6CO"]    = Get_Numeric(txtSMCHKTOXNUM6CO.GetValue());
            ht["P_SMCHKTOXUNIT6CO"]   = cboSMCHKTOXUNIT6CO.GetValue();
            ht["P_SMCHKTOXNUM6H2S"]   = Get_Numeric(txtSMCHKTOXNUM6H2S.GetValue());
            ht["P_SMCHKTOXUNIT6H2S"]  = cboSMCHKTOXUNIT6H2S.GetValue();
            ht["P_SMCHKSABUN7"]       = $("#svSMCHKSABUN7_KBSABUN").val();
            ht["P_SMCHKTIME7"]        = sSMCHKTIME7;
            ht["P_SMCHKOXYGEN7"]      = txtSMCHKOXYGEN7.GetValue();
            ht["P_SMCHKOXYGENUNIT7"]  = cboSMCHKOXYGENUNIT7.GetValue();
            ht["P_SMCHKTOXNUM7"]      = Get_Numeric(txtSMCHKTOXNUM7.GetValue());
            ht["P_SMCHKTOXUNIT7"]     = cboSMCHKTOXUNIT7.GetValue();
            ht["P_SMCHKTOXNUM7DS"]    = Get_Numeric(txtSMCHKTOXNUM7DS.GetValue());
            ht["P_SMCHKTOXUNIT7DS"]   = cboSMCHKTOXUNIT7DS.GetValue();
            ht["P_SMCHKTOXNUM7CO2"]   = Get_Numeric(txtSMCHKTOXNUM7CO2.GetValue());
            ht["P_SMCHKTOXUNIT7CO2"]  = cboSMCHKTOXUNIT7CO2.GetValue();
            ht["P_SMCHKTOXNUM7CO"]    = Get_Numeric(txtSMCHKTOXNUM7CO.GetValue());
            ht["P_SMCHKTOXUNIT7CO"]   = cboSMCHKTOXUNIT7CO.GetValue();
            ht["P_SMCHKTOXNUM7H2S"]   = Get_Numeric(txtSMCHKTOXNUM7H2S.GetValue());
            ht["P_SMCHKTOXUNIT7H2S"]  = cboSMCHKTOXUNIT7H2S.GetValue();
            ht["P_SMCHKSABUN8"]       = $("#svSMCHKSABUN8_KBSABUN").val();
            ht["P_SMCHKTIME8"]        = sSMCHKTIME8;
            ht["P_SMCHKOXYGEN8"]      = txtSMCHKOXYGEN8.GetValue();
            ht["P_SMCHKOXYGENUNIT8"]  = cboSMCHKOXYGENUNIT8.GetValue();
            ht["P_SMCHKTOXNUM8"]      = Get_Numeric(txtSMCHKTOXNUM8.GetValue());
            ht["P_SMCHKTOXUNIT8"]     = cboSMCHKTOXUNIT8.GetValue();
            ht["P_SMCHKTOXNUM8DS"]    = Get_Numeric(txtSMCHKTOXNUM8DS.GetValue());
            ht["P_SMCHKTOXUNIT8DS"]   = cboSMCHKTOXUNIT8DS.GetValue();
            ht["P_SMCHKTOXNUM8CO2"]   = Get_Numeric(txtSMCHKTOXNUM8CO2.GetValue());
            ht["P_SMCHKTOXUNIT8CO2"]  = cboSMCHKTOXUNIT8CO2.GetValue();
            ht["P_SMCHKTOXNUM8CO"]    = Get_Numeric(txtSMCHKTOXNUM8CO.GetValue());
            ht["P_SMCHKTOXUNIT8CO"]   = cboSMCHKTOXUNIT8CO.GetValue();
            ht["P_SMCHKTOXNUM8H2S"]   = Get_Numeric(txtSMCHKTOXNUM8H2S.GetValue());
            ht["P_SMCHKTOXUNIT8H2S"]  = cboSMCHKTOXUNIT8H2S.GetValue();
            ht["P_SMWKTEAM"]          = txtSMWKTEAM.GetValue();
            ht["P_SMWKDATE"]          = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_SMWKSEQ"]           = Set_Fill3(txtSMWKSEQ.GetValue());
            ht["P_SMWKORAPPDATE"]     = Get_Date(datSMWKORAPPDATE.GetValue().replace("-", ""));
            ht["P_SMWKORSEQ"]         = Set_Fill3(txtSMWKORSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_INSPECT_UPT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {

                        if (gubun == '1') {
                            chk = '';
                            if (DataSet.Tables[0].Rows[i]["SEQ"] == "1") {

                                $("#svSMCHKSABUN1_KBHANGL").val(DataSet.Tables[0].Rows[i]["KBHANGL"]);

                                if (DataSet.Tables[0].Rows[i]["STATE"] == "ERR") {
                                    chk = 'ERR';
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 첫번째 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                }
                            }

                            if (DataSet.Tables[0].Rows[i]["SEQ"] == "2") {

                                $("#svSMCHKSABUN2_KBHANGL").val(DataSet.Tables[0].Rows[i]["KBHANGL"]);

                                if (DataSet.Tables[0].Rows[i]["STATE"] == "ERR") {
                                    chk = 'ERR';
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 두번째 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                }
                            }

                            if (DataSet.Tables[0].Rows[i]["SEQ"] == "3") {

                                $("#svSMCHKSABUN3_KBHANGL").val(DataSet.Tables[0].Rows[i]["KBHANGL"]);

                                if (DataSet.Tables[0].Rows[i]["STATE"] == "ERR") {
                                    chk = 'ERR';
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 세번째 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                }
                            }

                            if (DataSet.Tables[0].Rows[i]["SEQ"] == "4") {

                                $("#svSMCHKSABUN4_KBHANGL").val(DataSet.Tables[0].Rows[i]["KBHANGL"]);

                                if (DataSet.Tables[0].Rows[i]["STATE"] == "ERR") {
                                    chk = 'ERR';
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="요청자의 부서코드와 네번째 점검자의 부서가 다릅니다. 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                }
                            }
                        }
                        else {

                            chk = '';

                            if (DataSet.Tables[0].Rows[i]["SEQ"] == "5") {

                                $("#svSMCHKSABUN5_KBHANGL").val(DataSet.Tables[0].Rows[i]["KBHANGL"]);

                                if (DataSet.Tables[0].Rows[i]["STATE"] == "ERR") {
                                    chk = 'ERR';
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 첫번째 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                }
                            }

                            if (DataSet.Tables[0].Rows[i]["SEQ"] == "6") {

                                $("#svSMCHKSABUN6_KBHANGL").val(DataSet.Tables[0].Rows[i]["KBHANGL"]);

                                if (DataSet.Tables[0].Rows[i]["STATE"] == "ERR") {
                                    chk = 'ERR';
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 두번째 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                }
                            }

                            if (DataSet.Tables[0].Rows[i]["SEQ"] == "7") {

                                $("#svSMCHKSABUN7_KBHANGL").val(DataSet.Tables[0].Rows[i]["KBHANGL"]);

                                if (DataSet.Tables[0].Rows[i]["STATE"] == "ERR") {
                                    chk = 'ERR';
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 세번째 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                }
                            }

                            if (DataSet.Tables[0].Rows[i]["SEQ"] == "8") {

                                $("#svSMCHKSABUN8_KBHANGL").val(DataSet.Tables[0].Rows[i]["KBHANGL"]);

                                if (DataSet.Tables[0].Rows[i]["STATE"] == "ERR") {
                                    chk = 'ERR';
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="안전환경팀 - 네번째 점검자를 확인하세요." Literal="true"></Ctl:Text>');
                                }
                            }
                        }
                    }

                    if (chk == '') {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="가스 측정 데이터가 저장 되었습니다." Literal="true"></Ctl:Text>');
                    }
                }
                else {

                    // 조치요구사항 체크박스 Readonly
                    fn_Chk_SaCode_ReadOnly('');
                }
            }, function (e) {

                debugger;
                alert(e);
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="점검자 확인 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }




        <%-- 체크박스 --%>
        function fn_Check_Sacode_Enable(gubun) {

            if (gubun == '') {
                // 검토
                Chk101_SSREVSEL.SetDisabled(true);
                Chk102_SSREVSEL.SetDisabled(true);
                Chk103_SSREVSEL.SetDisabled(true);
                Chk104_SSREVSEL.SetDisabled(true);
                Chk105_SSREVSEL.SetDisabled(true);
                Chk106_SSREVSEL.SetDisabled(true);
                Chk107_SSREVSEL.SetDisabled(true);
                Chk108_SSREVSEL.SetDisabled(true);
                Chk109_SSREVSEL.SetDisabled(true);
                Chk110_SSREVSEL.SetDisabled(true);
                Chk111_SSREVSEL.SetDisabled(true);
                Chk112_SSREVSEL.SetDisabled(true);
                Chk113_SSREVSEL.SetDisabled(true);
                Chk114_SSREVSEL.SetDisabled(true);
                Chk115_SSREVSEL.SetDisabled(true);
                Chk116_SSREVSEL.SetDisabled(true);

                Chk201_SSREVSEL.SetDisabled(true);
                Chk202_SSREVSEL.SetDisabled(true);
                Chk203_SSREVSEL.SetDisabled(true);
                Chk204_SSREVSEL.SetDisabled(true);
                Chk205_SSREVSEL.SetDisabled(true);
                Chk206_SSREVSEL.SetDisabled(true);
                Chk207_SSREVSEL.SetDisabled(true);
                Chk208_SSREVSEL.SetDisabled(true);
                Chk209_SSREVSEL.SetDisabled(true);
                Chk210_SSREVSEL.SetDisabled(true);
                Chk211_SSREVSEL.SetDisabled(true);
                Chk212_SSREVSEL.SetDisabled(true);
                Chk213_SSREVSEL.SetDisabled(true);
                Chk214_SSREVSEL.SetDisabled(true);
                Chk215_SSREVSEL.SetDisabled(true);
                Chk216_SSREVSEL.SetDisabled(true);
                Chk217_SSREVSEL.SetDisabled(true);
                Chk218_SSREVSEL.SetDisabled(true);

                Chk301_SSREVSEL.SetDisabled(true);
                Chk302_SSREVSEL.SetDisabled(true);
                Chk303_SSREVSEL.SetDisabled(true);
                Chk304_SSREVSEL.SetDisabled(true);
                Chk305_SSREVSEL.SetDisabled(true);
                Chk306_SSREVSEL.SetDisabled(true);
                Chk307_SSREVSEL.SetDisabled(true);
                Chk308_SSREVSEL.SetDisabled(true);
                Chk309_SSREVSEL.SetDisabled(true);
                Chk310_SSREVSEL.SetDisabled(true);
                Chk311_SSREVSEL.SetDisabled(true);
                Chk312_SSREVSEL.SetDisabled(true);
                Chk313_SSREVSEL.SetDisabled(true);
                Chk314_SSREVSEL.SetDisabled(true);

                Chk401_SSREVSEL.SetDisabled(true);
                Chk402_SSREVSEL.SetDisabled(true);
                Chk403_SSREVSEL.SetDisabled(true);
                Chk404_SSREVSEL.SetDisabled(true);
                Chk405_SSREVSEL.SetDisabled(true);
                Chk406_SSREVSEL.SetDisabled(true);
                Chk407_SSREVSEL.SetDisabled(true);
                Chk408_SSREVSEL.SetDisabled(true);
                Chk409_SSREVSEL.SetDisabled(true);

                Chk501_SSREVSEL.SetDisabled(true);
                Chk502_SSREVSEL.SetDisabled(true);
                Chk503_SSREVSEL.SetDisabled(true);
                Chk504_SSREVSEL.SetDisabled(true);

                Chk601_SSREVSEL.SetDisabled(true);
                Chk602_SSREVSEL.SetDisabled(true);
                Chk603_SSREVSEL.SetDisabled(true);

                Chk701_SSREVSEL.SetDisabled(true);
                Chk702_SSREVSEL.SetDisabled(true);
                Chk703_SSREVSEL.SetDisabled(true);
                Chk704_SSREVSEL.SetDisabled(true);
                Chk705_SSREVSEL.SetDisabled(true);
                Chk706_SSREVSEL.SetDisabled(true);
                Chk707_SSREVSEL.SetDisabled(true);
                Chk708_SSREVSEL.SetDisabled(true);

                Chk901_SSREVSEL.SetDisabled(true);
                Chk902_SSREVSEL.SetDisabled(true);
                Chk903_SSREVSEL.SetDisabled(true);
                Chk904_SSREVSEL.SetDisabled(true);
                Chk905_SSREVSEL.SetDisabled(true);
                Chk906_SSREVSEL.SetDisabled(true);
                Chk907_SSREVSEL.SetDisabled(true);
                Chk908_SSREVSEL.SetDisabled(true);
                Chk909_SSREVSEL.SetDisabled(true);
                Chk910_SSREVSEL.SetDisabled(true);
                Chk911_SSREVSEL.SetDisabled(true);
                Chk912_SSREVSEL.SetDisabled(true);
                Chk913_SSREVSEL.SetDisabled(true);
                Chk914_SSREVSEL.SetDisabled(true);
                Chk915_SSREVSEL.SetDisabled(true);
                Chk916_SSREVSEL.SetDisabled(true);






                // 확인
                Chk101_SSFIXSEL.SetDisabled(true);
                Chk102_SSFIXSEL.SetDisabled(true);
                Chk103_SSFIXSEL.SetDisabled(true);
                Chk104_SSFIXSEL.SetDisabled(true);
                Chk105_SSFIXSEL.SetDisabled(true);
                Chk106_SSFIXSEL.SetDisabled(true);
                Chk107_SSFIXSEL.SetDisabled(true);
                Chk108_SSFIXSEL.SetDisabled(true);
                Chk109_SSFIXSEL.SetDisabled(true);
                Chk110_SSFIXSEL.SetDisabled(true);
                Chk111_SSFIXSEL.SetDisabled(true);
                Chk112_SSFIXSEL.SetDisabled(true);
                Chk113_SSFIXSEL.SetDisabled(true);
                Chk114_SSFIXSEL.SetDisabled(true);
                Chk115_SSFIXSEL.SetDisabled(true);
                Chk116_SSFIXSEL.SetDisabled(true);

                Chk201_SSFIXSEL.SetDisabled(true);
                Chk202_SSFIXSEL.SetDisabled(true);
                Chk203_SSFIXSEL.SetDisabled(true);
                Chk204_SSFIXSEL.SetDisabled(true);
                Chk205_SSFIXSEL.SetDisabled(true);
                Chk206_SSFIXSEL.SetDisabled(true);
                Chk207_SSFIXSEL.SetDisabled(true);
                Chk208_SSFIXSEL.SetDisabled(true);
                Chk209_SSFIXSEL.SetDisabled(true);
                Chk210_SSFIXSEL.SetDisabled(true);
                Chk211_SSFIXSEL.SetDisabled(true);
                Chk212_SSFIXSEL.SetDisabled(true);
                Chk213_SSFIXSEL.SetDisabled(true);
                Chk214_SSFIXSEL.SetDisabled(true);
                Chk215_SSFIXSEL.SetDisabled(true);
                Chk216_SSFIXSEL.SetDisabled(true);
                Chk217_SSFIXSEL.SetDisabled(true);
                Chk218_SSFIXSEL.SetDisabled(true);

                Chk301_SSFIXSEL.SetDisabled(true);
                Chk302_SSFIXSEL.SetDisabled(true);
                Chk303_SSFIXSEL.SetDisabled(true);
                Chk304_SSFIXSEL.SetDisabled(true);
                Chk305_SSFIXSEL.SetDisabled(true);
                Chk306_SSFIXSEL.SetDisabled(true);
                Chk307_SSFIXSEL.SetDisabled(true);
                Chk308_SSFIXSEL.SetDisabled(true);
                Chk309_SSFIXSEL.SetDisabled(true);
                Chk310_SSFIXSEL.SetDisabled(true);
                Chk311_SSFIXSEL.SetDisabled(true);
                Chk312_SSFIXSEL.SetDisabled(true);
                Chk313_SSFIXSEL.SetDisabled(true);
                Chk314_SSFIXSEL.SetDisabled(true);

                Chk401_SSFIXSEL.SetDisabled(true);
                Chk402_SSFIXSEL.SetDisabled(true);
                Chk403_SSFIXSEL.SetDisabled(true);
                Chk404_SSFIXSEL.SetDisabled(true);
                Chk405_SSFIXSEL.SetDisabled(true);
                Chk406_SSFIXSEL.SetDisabled(true);
                Chk407_SSFIXSEL.SetDisabled(true);
                Chk408_SSFIXSEL.SetDisabled(true);
                Chk409_SSFIXSEL.SetDisabled(true);

                Chk501_SSFIXSEL.SetDisabled(true);
                Chk502_SSFIXSEL.SetDisabled(true);
                Chk503_SSFIXSEL.SetDisabled(true);
                Chk504_SSFIXSEL.SetDisabled(true);

                Chk601_SSFIXSEL.SetDisabled(true);
                Chk602_SSFIXSEL.SetDisabled(true);
                Chk603_SSFIXSEL.SetDisabled(true);

                Chk701_SSFIXSEL.SetDisabled(true);
                Chk702_SSFIXSEL.SetDisabled(true);
                Chk703_SSFIXSEL.SetDisabled(true);
                Chk704_SSFIXSEL.SetDisabled(true);
                Chk705_SSFIXSEL.SetDisabled(true);
                Chk706_SSFIXSEL.SetDisabled(true);
                Chk707_SSFIXSEL.SetDisabled(true);
                Chk708_SSFIXSEL.SetDisabled(true);

                Chk901_SSFIXSEL.SetDisabled(true);
                Chk902_SSFIXSEL.SetDisabled(true);
                Chk903_SSFIXSEL.SetDisabled(true);
                Chk904_SSFIXSEL.SetDisabled(true);
                Chk905_SSFIXSEL.SetDisabled(true);
                Chk906_SSFIXSEL.SetDisabled(true);
                Chk907_SSFIXSEL.SetDisabled(true);
                Chk908_SSFIXSEL.SetDisabled(true);
                Chk909_SSFIXSEL.SetDisabled(true);
                Chk910_SSFIXSEL.SetDisabled(true);
                Chk911_SSFIXSEL.SetDisabled(true);
                Chk912_SSFIXSEL.SetDisabled(true);
                Chk913_SSFIXSEL.SetDisabled(true);
                Chk914_SSFIXSEL.SetDisabled(true);
                Chk915_SSFIXSEL.SetDisabled(true);
                Chk916_SSFIXSEL.SetDisabled(true);
            }

            if (gubun == '1') {
                // 확인
                Chk101_SSFIXSEL.SetDisabled(true);
                Chk102_SSFIXSEL.SetDisabled(true);
                Chk103_SSFIXSEL.SetDisabled(true);
                Chk104_SSFIXSEL.SetDisabled(true);
                Chk105_SSFIXSEL.SetDisabled(true);
                Chk106_SSFIXSEL.SetDisabled(true);
                Chk107_SSFIXSEL.SetDisabled(true);
                Chk108_SSFIXSEL.SetDisabled(true);
                Chk109_SSFIXSEL.SetDisabled(true);
                Chk110_SSFIXSEL.SetDisabled(true);
                Chk111_SSFIXSEL.SetDisabled(true);
                Chk112_SSFIXSEL.SetDisabled(true);
                Chk113_SSFIXSEL.SetDisabled(true);
                Chk114_SSFIXSEL.SetDisabled(true);
                Chk115_SSFIXSEL.SetDisabled(true);
                Chk116_SSFIXSEL.SetDisabled(true);

                Chk201_SSFIXSEL.SetDisabled(true);
                Chk202_SSFIXSEL.SetDisabled(true);
                Chk203_SSFIXSEL.SetDisabled(true);
                Chk204_SSFIXSEL.SetDisabled(true);
                Chk205_SSFIXSEL.SetDisabled(true);
                Chk206_SSFIXSEL.SetDisabled(true);
                Chk207_SSFIXSEL.SetDisabled(true);
                Chk208_SSFIXSEL.SetDisabled(true);
                Chk209_SSFIXSEL.SetDisabled(true);
                Chk210_SSFIXSEL.SetDisabled(true);
                Chk211_SSFIXSEL.SetDisabled(true);
                Chk212_SSFIXSEL.SetDisabled(true);
                Chk213_SSFIXSEL.SetDisabled(true);
                Chk214_SSFIXSEL.SetDisabled(true);
                Chk215_SSFIXSEL.SetDisabled(true);
                Chk216_SSFIXSEL.SetDisabled(true);
                Chk217_SSFIXSEL.SetDisabled(true);
                Chk218_SSFIXSEL.SetDisabled(true);

                Chk301_SSFIXSEL.SetDisabled(true);
                Chk302_SSFIXSEL.SetDisabled(true);
                Chk303_SSFIXSEL.SetDisabled(true);
                Chk304_SSFIXSEL.SetDisabled(true);
                Chk305_SSFIXSEL.SetDisabled(true);
                Chk306_SSFIXSEL.SetDisabled(true);
                Chk307_SSFIXSEL.SetDisabled(true);
                Chk308_SSFIXSEL.SetDisabled(true);
                Chk309_SSFIXSEL.SetDisabled(true);
                Chk310_SSFIXSEL.SetDisabled(true);
                Chk311_SSFIXSEL.SetDisabled(true);
                Chk312_SSFIXSEL.SetDisabled(true);
                Chk313_SSFIXSEL.SetDisabled(true);
                Chk314_SSFIXSEL.SetDisabled(true);

                Chk401_SSFIXSEL.SetDisabled(true);
                Chk402_SSFIXSEL.SetDisabled(true);
                Chk403_SSFIXSEL.SetDisabled(true);
                Chk404_SSFIXSEL.SetDisabled(true);
                Chk405_SSFIXSEL.SetDisabled(true);
                Chk406_SSFIXSEL.SetDisabled(true);
                Chk407_SSFIXSEL.SetDisabled(true);
                Chk408_SSFIXSEL.SetDisabled(true);
                Chk409_SSFIXSEL.SetDisabled(true);

                Chk501_SSFIXSEL.SetDisabled(true);
                Chk502_SSFIXSEL.SetDisabled(true);
                Chk503_SSFIXSEL.SetDisabled(true);
                Chk504_SSFIXSEL.SetDisabled(true);

                Chk601_SSFIXSEL.SetDisabled(true);
                Chk602_SSFIXSEL.SetDisabled(true);
                Chk603_SSFIXSEL.SetDisabled(true);

                Chk701_SSFIXSEL.SetDisabled(true);
                Chk702_SSFIXSEL.SetDisabled(true);
                Chk703_SSFIXSEL.SetDisabled(true);
                Chk704_SSFIXSEL.SetDisabled(true);
                Chk705_SSFIXSEL.SetDisabled(true);
                Chk706_SSFIXSEL.SetDisabled(true);
                Chk707_SSFIXSEL.SetDisabled(true);
                Chk708_SSFIXSEL.SetDisabled(true);

                Chk901_SSFIXSEL.SetDisabled(true);
                Chk902_SSFIXSEL.SetDisabled(true);
                Chk903_SSFIXSEL.SetDisabled(true);
                Chk904_SSFIXSEL.SetDisabled(true);
                Chk905_SSFIXSEL.SetDisabled(true);
                Chk906_SSFIXSEL.SetDisabled(true);
                Chk907_SSFIXSEL.SetDisabled(true);
                Chk908_SSFIXSEL.SetDisabled(true);
                Chk909_SSFIXSEL.SetDisabled(true);
                Chk910_SSFIXSEL.SetDisabled(true);
                Chk911_SSFIXSEL.SetDisabled(true);
                Chk912_SSFIXSEL.SetDisabled(true);
                Chk913_SSFIXSEL.SetDisabled(true);
                Chk914_SSFIXSEL.SetDisabled(true);
                Chk915_SSFIXSEL.SetDisabled(true);
                Chk916_SSFIXSEL.SetDisabled(true);
            }

            if (gubun == '2') {
                // 발행
                Chk101_SSPUBSEL.SetDisabled(true);
                Chk102_SSPUBSEL.SetDisabled(true);
                Chk103_SSPUBSEL.SetDisabled(true);
                Chk104_SSPUBSEL.SetDisabled(true);
                Chk105_SSPUBSEL.SetDisabled(true);
                Chk106_SSPUBSEL.SetDisabled(true);
                Chk107_SSPUBSEL.SetDisabled(true);
                Chk108_SSPUBSEL.SetDisabled(true);
                Chk109_SSPUBSEL.SetDisabled(true);
                Chk110_SSPUBSEL.SetDisabled(true);
                Chk111_SSPUBSEL.SetDisabled(true);
                Chk112_SSPUBSEL.SetDisabled(true);
                Chk113_SSPUBSEL.SetDisabled(true);
                Chk114_SSPUBSEL.SetDisabled(true);
                Chk115_SSPUBSEL.SetDisabled(true);
                Chk116_SSPUBSEL.SetDisabled(true);

                Chk201_SSPUBSEL.SetDisabled(true);
                Chk202_SSPUBSEL.SetDisabled(true);
                Chk203_SSPUBSEL.SetDisabled(true);
                Chk204_SSPUBSEL.SetDisabled(true);
                Chk205_SSPUBSEL.SetDisabled(true);
                Chk206_SSPUBSEL.SetDisabled(true);
                Chk207_SSPUBSEL.SetDisabled(true);
                Chk208_SSPUBSEL.SetDisabled(true);
                Chk209_SSPUBSEL.SetDisabled(true);
                Chk210_SSPUBSEL.SetDisabled(true);
                Chk211_SSPUBSEL.SetDisabled(true);
                Chk212_SSPUBSEL.SetDisabled(true);
                Chk213_SSPUBSEL.SetDisabled(true);
                Chk214_SSPUBSEL.SetDisabled(true);
                Chk215_SSPUBSEL.SetDisabled(true);
                Chk216_SSPUBSEL.SetDisabled(true);
                Chk217_SSPUBSEL.SetDisabled(true);
                Chk218_SSPUBSEL.SetDisabled(true);

                Chk301_SSPUBSEL.SetDisabled(true);
                Chk302_SSPUBSEL.SetDisabled(true);
                Chk303_SSPUBSEL.SetDisabled(true);
                Chk304_SSPUBSEL.SetDisabled(true);
                Chk305_SSPUBSEL.SetDisabled(true);
                Chk306_SSPUBSEL.SetDisabled(true);
                Chk307_SSPUBSEL.SetDisabled(true);
                Chk308_SSPUBSEL.SetDisabled(true);
                Chk309_SSPUBSEL.SetDisabled(true);
                Chk310_SSPUBSEL.SetDisabled(true);
                Chk311_SSPUBSEL.SetDisabled(true);
                Chk312_SSPUBSEL.SetDisabled(true);
                Chk313_SSPUBSEL.SetDisabled(true);
                Chk314_SSPUBSEL.SetDisabled(true);

                Chk401_SSPUBSEL.SetDisabled(true);
                Chk402_SSPUBSEL.SetDisabled(true);
                Chk403_SSPUBSEL.SetDisabled(true);
                Chk404_SSPUBSEL.SetDisabled(true);
                Chk405_SSPUBSEL.SetDisabled(true);
                Chk406_SSPUBSEL.SetDisabled(true);
                Chk407_SSPUBSEL.SetDisabled(true);
                Chk408_SSPUBSEL.SetDisabled(true);
                Chk409_SSPUBSEL.SetDisabled(true);

                Chk501_SSPUBSEL.SetDisabled(true);
                Chk502_SSPUBSEL.SetDisabled(true);
                Chk503_SSPUBSEL.SetDisabled(true);
                Chk504_SSPUBSEL.SetDisabled(true);

                Chk601_SSPUBSEL.SetDisabled(true);
                Chk602_SSPUBSEL.SetDisabled(true);
                Chk603_SSPUBSEL.SetDisabled(true);

                Chk701_SSPUBSEL.SetDisabled(true);
                Chk702_SSPUBSEL.SetDisabled(true);
                Chk703_SSPUBSEL.SetDisabled(true);
                Chk704_SSPUBSEL.SetDisabled(true);
                Chk705_SSPUBSEL.SetDisabled(true);
                Chk706_SSPUBSEL.SetDisabled(true);
                Chk707_SSPUBSEL.SetDisabled(true);
                Chk708_SSPUBSEL.SetDisabled(true);

                Chk901_SSPUBSEL.SetDisabled(true);
                Chk902_SSPUBSEL.SetDisabled(true);
                Chk903_SSPUBSEL.SetDisabled(true);
                Chk904_SSPUBSEL.SetDisabled(true);
                Chk905_SSPUBSEL.SetDisabled(true);
                Chk906_SSPUBSEL.SetDisabled(true);
                Chk907_SSPUBSEL.SetDisabled(true);
                Chk908_SSPUBSEL.SetDisabled(true);
                Chk909_SSPUBSEL.SetDisabled(true);
                Chk910_SSPUBSEL.SetDisabled(true);
                Chk911_SSPUBSEL.SetDisabled(true);
                Chk912_SSPUBSEL.SetDisabled(true);
                Chk913_SSPUBSEL.SetDisabled(true);
                Chk914_SSPUBSEL.SetDisabled(true);
                Chk915_SSPUBSEL.SetDisabled(true);
                Chk916_SSPUBSEL.SetDisabled(true);




                // 검토
                Chk101_SSREVSEL.SetDisabled(true);
                Chk102_SSREVSEL.SetDisabled(true);
                Chk103_SSREVSEL.SetDisabled(true);
                Chk104_SSREVSEL.SetDisabled(true);
                Chk105_SSREVSEL.SetDisabled(true);
                Chk106_SSREVSEL.SetDisabled(true);
                Chk107_SSREVSEL.SetDisabled(true);
                Chk108_SSREVSEL.SetDisabled(true);
                Chk109_SSREVSEL.SetDisabled(true);
                Chk110_SSREVSEL.SetDisabled(true);
                Chk111_SSREVSEL.SetDisabled(true);
                Chk112_SSREVSEL.SetDisabled(true);
                Chk113_SSREVSEL.SetDisabled(true);
                Chk114_SSREVSEL.SetDisabled(true);
                Chk115_SSREVSEL.SetDisabled(true);
                Chk116_SSREVSEL.SetDisabled(true);

                Chk201_SSREVSEL.SetDisabled(true);
                Chk202_SSREVSEL.SetDisabled(true);
                Chk203_SSREVSEL.SetDisabled(true);
                Chk204_SSREVSEL.SetDisabled(true);
                Chk205_SSREVSEL.SetDisabled(true);
                Chk206_SSREVSEL.SetDisabled(true);
                Chk207_SSREVSEL.SetDisabled(true);
                Chk208_SSREVSEL.SetDisabled(true);
                Chk209_SSREVSEL.SetDisabled(true);
                Chk210_SSREVSEL.SetDisabled(true);
                Chk211_SSREVSEL.SetDisabled(true);
                Chk212_SSREVSEL.SetDisabled(true);
                Chk213_SSREVSEL.SetDisabled(true);
                Chk214_SSREVSEL.SetDisabled(true);
                Chk215_SSREVSEL.SetDisabled(true);
                Chk216_SSREVSEL.SetDisabled(true);
                Chk217_SSREVSEL.SetDisabled(true);
                Chk218_SSREVSEL.SetDisabled(true);

                Chk301_SSREVSEL.SetDisabled(true);
                Chk302_SSREVSEL.SetDisabled(true);
                Chk303_SSREVSEL.SetDisabled(true);
                Chk304_SSREVSEL.SetDisabled(true);
                Chk305_SSREVSEL.SetDisabled(true);
                Chk306_SSREVSEL.SetDisabled(true);
                Chk307_SSREVSEL.SetDisabled(true);
                Chk308_SSREVSEL.SetDisabled(true);
                Chk309_SSREVSEL.SetDisabled(true);
                Chk310_SSREVSEL.SetDisabled(true);
                Chk311_SSREVSEL.SetDisabled(true);
                Chk312_SSREVSEL.SetDisabled(true);
                Chk313_SSREVSEL.SetDisabled(true);
                Chk314_SSREVSEL.SetDisabled(true);

                Chk401_SSREVSEL.SetDisabled(true);
                Chk402_SSREVSEL.SetDisabled(true);
                Chk403_SSREVSEL.SetDisabled(true);
                Chk404_SSREVSEL.SetDisabled(true);
                Chk405_SSREVSEL.SetDisabled(true);
                Chk406_SSREVSEL.SetDisabled(true);
                Chk407_SSREVSEL.SetDisabled(true);
                Chk408_SSREVSEL.SetDisabled(true);
                Chk409_SSREVSEL.SetDisabled(true);

                Chk501_SSREVSEL.SetDisabled(true);
                Chk502_SSREVSEL.SetDisabled(true);
                Chk503_SSREVSEL.SetDisabled(true);
                Chk504_SSREVSEL.SetDisabled(true);

                Chk601_SSREVSEL.SetDisabled(true);
                Chk602_SSREVSEL.SetDisabled(true);
                Chk603_SSREVSEL.SetDisabled(true);

                Chk701_SSREVSEL.SetDisabled(true);
                Chk702_SSREVSEL.SetDisabled(true);
                Chk703_SSREVSEL.SetDisabled(true);
                Chk704_SSREVSEL.SetDisabled(true);
                Chk705_SSREVSEL.SetDisabled(true);
                Chk706_SSREVSEL.SetDisabled(true);
                Chk707_SSREVSEL.SetDisabled(true);
                Chk708_SSREVSEL.SetDisabled(true);

                Chk901_SSREVSEL.SetDisabled(true);
                Chk902_SSREVSEL.SetDisabled(true);
                Chk903_SSREVSEL.SetDisabled(true);
                Chk904_SSREVSEL.SetDisabled(true);
                Chk905_SSREVSEL.SetDisabled(true);
                Chk906_SSREVSEL.SetDisabled(true);
                Chk907_SSREVSEL.SetDisabled(true);
                Chk908_SSREVSEL.SetDisabled(true);
                Chk909_SSREVSEL.SetDisabled(true);
                Chk910_SSREVSEL.SetDisabled(true);
                Chk911_SSREVSEL.SetDisabled(true);
                Chk912_SSREVSEL.SetDisabled(true);
                Chk913_SSREVSEL.SetDisabled(true);
                Chk914_SSREVSEL.SetDisabled(true);
                Chk915_SSREVSEL.SetDisabled(true);
                Chk916_SSREVSEL.SetDisabled(true);



                // 확인
                Chk101_SSFIXSEL.SetDisabled(false);
                Chk102_SSFIXSEL.SetDisabled(false);
                Chk103_SSFIXSEL.SetDisabled(false);
                Chk104_SSFIXSEL.SetDisabled(false);
                Chk105_SSFIXSEL.SetDisabled(false);
                Chk106_SSFIXSEL.SetDisabled(false);
                Chk107_SSFIXSEL.SetDisabled(false);
                Chk108_SSFIXSEL.SetDisabled(false);
                Chk109_SSFIXSEL.SetDisabled(false);
                Chk110_SSFIXSEL.SetDisabled(false);
                Chk111_SSFIXSEL.SetDisabled(false);
                Chk112_SSFIXSEL.SetDisabled(false);
                Chk113_SSFIXSEL.SetDisabled(false);
                Chk114_SSFIXSEL.SetDisabled(false);
                Chk115_SSFIXSEL.SetDisabled(false);
                Chk116_SSFIXSEL.SetDisabled(false);

                Chk201_SSFIXSEL.SetDisabled(false);
                Chk202_SSFIXSEL.SetDisabled(false);
                Chk203_SSFIXSEL.SetDisabled(false);
                Chk204_SSFIXSEL.SetDisabled(false);
                Chk205_SSFIXSEL.SetDisabled(false);
                Chk206_SSFIXSEL.SetDisabled(false);
                Chk207_SSFIXSEL.SetDisabled(false);
                Chk208_SSFIXSEL.SetDisabled(false);
                Chk209_SSFIXSEL.SetDisabled(false);
                Chk210_SSFIXSEL.SetDisabled(false);
                Chk211_SSFIXSEL.SetDisabled(false);
                Chk212_SSFIXSEL.SetDisabled(false);
                Chk213_SSFIXSEL.SetDisabled(false);
                Chk214_SSFIXSEL.SetDisabled(false);
                Chk215_SSFIXSEL.SetDisabled(false);
                Chk216_SSFIXSEL.SetDisabled(false);
                Chk217_SSFIXSEL.SetDisabled(false);
                Chk218_SSFIXSEL.SetDisabled(false);

                Chk301_SSFIXSEL.SetDisabled(false);
                Chk302_SSFIXSEL.SetDisabled(false);
                Chk303_SSFIXSEL.SetDisabled(false);
                Chk304_SSFIXSEL.SetDisabled(false);
                Chk305_SSFIXSEL.SetDisabled(false);
                Chk306_SSFIXSEL.SetDisabled(false);
                Chk307_SSFIXSEL.SetDisabled(false);
                Chk308_SSFIXSEL.SetDisabled(false);
                Chk309_SSFIXSEL.SetDisabled(false);
                Chk310_SSFIXSEL.SetDisabled(false);
                Chk311_SSFIXSEL.SetDisabled(false);
                Chk312_SSFIXSEL.SetDisabled(false);
                Chk313_SSFIXSEL.SetDisabled(false);
                Chk314_SSFIXSEL.SetDisabled(false);

                Chk401_SSFIXSEL.SetDisabled(false);
                Chk402_SSFIXSEL.SetDisabled(false);
                Chk403_SSFIXSEL.SetDisabled(false);
                Chk404_SSFIXSEL.SetDisabled(false);
                Chk405_SSFIXSEL.SetDisabled(false);
                Chk406_SSFIXSEL.SetDisabled(false);
                Chk407_SSFIXSEL.SetDisabled(false);
                Chk408_SSFIXSEL.SetDisabled(false);
                Chk409_SSFIXSEL.SetDisabled(false);

                Chk501_SSFIXSEL.SetDisabled(false);
                Chk502_SSFIXSEL.SetDisabled(false);
                Chk503_SSFIXSEL.SetDisabled(false);
                Chk504_SSFIXSEL.SetDisabled(false);

                Chk601_SSFIXSEL.SetDisabled(false);
                Chk602_SSFIXSEL.SetDisabled(false);
                Chk603_SSFIXSEL.SetDisabled(false);

                Chk701_SSFIXSEL.SetDisabled(false);
                Chk702_SSFIXSEL.SetDisabled(false);
                Chk703_SSFIXSEL.SetDisabled(false);
                Chk704_SSFIXSEL.SetDisabled(false);
                Chk705_SSFIXSEL.SetDisabled(false);
                Chk706_SSFIXSEL.SetDisabled(false);
                Chk707_SSFIXSEL.SetDisabled(false);
                Chk708_SSFIXSEL.SetDisabled(false);

                Chk901_SSFIXSEL.SetDisabled(false);
                Chk902_SSFIXSEL.SetDisabled(false);
                Chk903_SSFIXSEL.SetDisabled(false);
                Chk904_SSFIXSEL.SetDisabled(false);
                Chk905_SSFIXSEL.SetDisabled(false);
                Chk906_SSFIXSEL.SetDisabled(false);
                Chk907_SSFIXSEL.SetDisabled(false);
                Chk908_SSFIXSEL.SetDisabled(false);
                Chk909_SSFIXSEL.SetDisabled(false);
                Chk910_SSFIXSEL.SetDisabled(false);
                Chk911_SSFIXSEL.SetDisabled(false);
                Chk912_SSFIXSEL.SetDisabled(false);
                Chk913_SSFIXSEL.SetDisabled(false);
                Chk914_SSFIXSEL.SetDisabled(false);
                Chk915_SSFIXSEL.SetDisabled(false);
                Chk916_SSFIXSEL.SetDisabled(false);
            }

            if (gubun == '3') {
                // 발행
                Chk101_SSPUBSEL.SetDisabled(false);
                Chk102_SSPUBSEL.SetDisabled(false);
                Chk103_SSPUBSEL.SetDisabled(false);
                Chk104_SSPUBSEL.SetDisabled(false);
                Chk105_SSPUBSEL.SetDisabled(false);
                Chk106_SSPUBSEL.SetDisabled(false);
                Chk107_SSPUBSEL.SetDisabled(false);
                Chk108_SSPUBSEL.SetDisabled(false);
                Chk109_SSPUBSEL.SetDisabled(false);
                Chk110_SSPUBSEL.SetDisabled(false);
                Chk111_SSPUBSEL.SetDisabled(false);
                Chk112_SSPUBSEL.SetDisabled(false);
                Chk113_SSPUBSEL.SetDisabled(false);
                Chk114_SSPUBSEL.SetDisabled(false);
                Chk115_SSPUBSEL.SetDisabled(false);
                Chk116_SSPUBSEL.SetDisabled(false);

                Chk201_SSPUBSEL.SetDisabled(false);
                Chk202_SSPUBSEL.SetDisabled(false);
                Chk203_SSPUBSEL.SetDisabled(false);
                Chk204_SSPUBSEL.SetDisabled(false);
                Chk205_SSPUBSEL.SetDisabled(false);
                Chk206_SSPUBSEL.SetDisabled(false);
                Chk207_SSPUBSEL.SetDisabled(false);
                Chk208_SSPUBSEL.SetDisabled(false);
                Chk209_SSPUBSEL.SetDisabled(false);
                Chk210_SSPUBSEL.SetDisabled(false);
                Chk211_SSPUBSEL.SetDisabled(false);
                Chk212_SSPUBSEL.SetDisabled(false);
                Chk213_SSPUBSEL.SetDisabled(false);
                Chk214_SSPUBSEL.SetDisabled(false);
                Chk215_SSPUBSEL.SetDisabled(false);
                Chk216_SSPUBSEL.SetDisabled(false);
                Chk217_SSPUBSEL.SetDisabled(false);
                Chk218_SSPUBSEL.SetDisabled(false);

                Chk301_SSPUBSEL.SetDisabled(false);
                Chk302_SSPUBSEL.SetDisabled(false);
                Chk303_SSPUBSEL.SetDisabled(false);
                Chk304_SSPUBSEL.SetDisabled(false);
                Chk305_SSPUBSEL.SetDisabled(false);
                Chk306_SSPUBSEL.SetDisabled(false);
                Chk307_SSPUBSEL.SetDisabled(false);
                Chk308_SSPUBSEL.SetDisabled(false);
                Chk309_SSPUBSEL.SetDisabled(false);
                Chk310_SSPUBSEL.SetDisabled(false);
                Chk311_SSPUBSEL.SetDisabled(false);
                Chk312_SSPUBSEL.SetDisabled(false);
                Chk313_SSPUBSEL.SetDisabled(false);
                Chk314_SSPUBSEL.SetDisabled(false);

                Chk401_SSPUBSEL.SetDisabled(false);
                Chk402_SSPUBSEL.SetDisabled(false);
                Chk403_SSPUBSEL.SetDisabled(false);
                Chk404_SSPUBSEL.SetDisabled(false);
                Chk405_SSPUBSEL.SetDisabled(false);
                Chk406_SSPUBSEL.SetDisabled(false);
                Chk407_SSPUBSEL.SetDisabled(false);
                Chk408_SSPUBSEL.SetDisabled(false);
                Chk409_SSPUBSEL.SetDisabled(false);

                Chk501_SSPUBSEL.SetDisabled(false);
                Chk502_SSPUBSEL.SetDisabled(false);
                Chk503_SSPUBSEL.SetDisabled(false);
                Chk504_SSPUBSEL.SetDisabled(false);

                Chk601_SSPUBSEL.SetDisabled(false);
                Chk602_SSPUBSEL.SetDisabled(false);
                Chk603_SSPUBSEL.SetDisabled(false);

                Chk701_SSPUBSEL.SetDisabled(false);
                Chk702_SSPUBSEL.SetDisabled(false);
                Chk703_SSPUBSEL.SetDisabled(false);
                Chk704_SSPUBSEL.SetDisabled(false);
                Chk705_SSPUBSEL.SetDisabled(false);
                Chk706_SSPUBSEL.SetDisabled(false);
                Chk707_SSPUBSEL.SetDisabled(false);
                Chk708_SSPUBSEL.SetDisabled(false);

                Chk901_SSPUBSEL.SetDisabled(false);
                Chk902_SSPUBSEL.SetDisabled(false);
                Chk903_SSPUBSEL.SetDisabled(false);
                Chk904_SSPUBSEL.SetDisabled(false);
                Chk905_SSPUBSEL.SetDisabled(false);
                Chk906_SSPUBSEL.SetDisabled(false);
                Chk907_SSPUBSEL.SetDisabled(false);
                Chk908_SSPUBSEL.SetDisabled(false);
                Chk909_SSPUBSEL.SetDisabled(false);
                Chk910_SSPUBSEL.SetDisabled(false);
                Chk911_SSPUBSEL.SetDisabled(false);
                Chk912_SSPUBSEL.SetDisabled(false);
                Chk913_SSPUBSEL.SetDisabled(false);
                Chk914_SSPUBSEL.SetDisabled(false);
                Chk915_SSPUBSEL.SetDisabled(false);
                Chk916_SSPUBSEL.SetDisabled(false);




                // 검토
                Chk101_SSREVSEL.SetDisabled(false);
                Chk102_SSREVSEL.SetDisabled(false);
                Chk103_SSREVSEL.SetDisabled(false);
                Chk104_SSREVSEL.SetDisabled(false);
                Chk105_SSREVSEL.SetDisabled(false);
                Chk106_SSREVSEL.SetDisabled(false);
                Chk107_SSREVSEL.SetDisabled(false);
                Chk108_SSREVSEL.SetDisabled(false);
                Chk109_SSREVSEL.SetDisabled(false);
                Chk110_SSREVSEL.SetDisabled(false);
                Chk111_SSREVSEL.SetDisabled(false);
                Chk112_SSREVSEL.SetDisabled(false);
                Chk113_SSREVSEL.SetDisabled(false);
                Chk114_SSREVSEL.SetDisabled(false);
                Chk115_SSREVSEL.SetDisabled(false);
                Chk116_SSREVSEL.SetDisabled(false);

                Chk201_SSREVSEL.SetDisabled(false);
                Chk202_SSREVSEL.SetDisabled(false);
                Chk203_SSREVSEL.SetDisabled(false);
                Chk204_SSREVSEL.SetDisabled(false);
                Chk205_SSREVSEL.SetDisabled(false);
                Chk206_SSREVSEL.SetDisabled(false);
                Chk207_SSREVSEL.SetDisabled(false);
                Chk208_SSREVSEL.SetDisabled(false);
                Chk209_SSREVSEL.SetDisabled(false);
                Chk210_SSREVSEL.SetDisabled(false);
                Chk211_SSREVSEL.SetDisabled(false);
                Chk212_SSREVSEL.SetDisabled(false);
                Chk213_SSREVSEL.SetDisabled(false);
                Chk214_SSREVSEL.SetDisabled(false);
                Chk215_SSREVSEL.SetDisabled(false);
                Chk216_SSREVSEL.SetDisabled(false);
                Chk217_SSREVSEL.SetDisabled(false);
                Chk218_SSREVSEL.SetDisabled(false);

                Chk301_SSREVSEL.SetDisabled(false);
                Chk302_SSREVSEL.SetDisabled(false);
                Chk303_SSREVSEL.SetDisabled(false);
                Chk304_SSREVSEL.SetDisabled(false);
                Chk305_SSREVSEL.SetDisabled(false);
                Chk306_SSREVSEL.SetDisabled(false);
                Chk307_SSREVSEL.SetDisabled(false);
                Chk308_SSREVSEL.SetDisabled(false);
                Chk309_SSREVSEL.SetDisabled(false);
                Chk310_SSREVSEL.SetDisabled(false);
                Chk311_SSREVSEL.SetDisabled(false);
                Chk312_SSREVSEL.SetDisabled(false);
                Chk313_SSREVSEL.SetDisabled(false);
                Chk314_SSREVSEL.SetDisabled(false);

                Chk401_SSREVSEL.SetDisabled(false);
                Chk402_SSREVSEL.SetDisabled(false);
                Chk403_SSREVSEL.SetDisabled(false);
                Chk404_SSREVSEL.SetDisabled(false);
                Chk405_SSREVSEL.SetDisabled(false);
                Chk406_SSREVSEL.SetDisabled(false);
                Chk407_SSREVSEL.SetDisabled(false);
                Chk408_SSREVSEL.SetDisabled(false);
                Chk409_SSREVSEL.SetDisabled(false);

                Chk501_SSREVSEL.SetDisabled(false);
                Chk502_SSREVSEL.SetDisabled(false);
                Chk503_SSREVSEL.SetDisabled(false);
                Chk504_SSREVSEL.SetDisabled(false);

                Chk601_SSREVSEL.SetDisabled(false);
                Chk602_SSREVSEL.SetDisabled(false);
                Chk603_SSREVSEL.SetDisabled(false);

                Chk701_SSREVSEL.SetDisabled(false);
                Chk702_SSREVSEL.SetDisabled(false);
                Chk703_SSREVSEL.SetDisabled(false);
                Chk704_SSREVSEL.SetDisabled(false);
                Chk705_SSREVSEL.SetDisabled(false);
                Chk706_SSREVSEL.SetDisabled(false);
                Chk707_SSREVSEL.SetDisabled(false);
                Chk708_SSREVSEL.SetDisabled(false);

                Chk901_SSREVSEL.SetDisabled(false);
                Chk902_SSREVSEL.SetDisabled(false);
                Chk903_SSREVSEL.SetDisabled(false);
                Chk904_SSREVSEL.SetDisabled(false);
                Chk905_SSREVSEL.SetDisabled(false);
                Chk906_SSREVSEL.SetDisabled(false);
                Chk907_SSREVSEL.SetDisabled(false);
                Chk908_SSREVSEL.SetDisabled(false);
                Chk909_SSREVSEL.SetDisabled(false);
                Chk910_SSREVSEL.SetDisabled(false);
                Chk911_SSREVSEL.SetDisabled(false);
                Chk912_SSREVSEL.SetDisabled(false);
                Chk913_SSREVSEL.SetDisabled(false);
                Chk914_SSREVSEL.SetDisabled(false);
                Chk915_SSREVSEL.SetDisabled(false);
                Chk916_SSREVSEL.SetDisabled(false);






                // 확인
                Chk101_SSFIXSEL.SetDisabled(false);
                Chk102_SSFIXSEL.SetDisabled(false);
                Chk103_SSFIXSEL.SetDisabled(false);
                Chk104_SSFIXSEL.SetDisabled(false);
                Chk105_SSFIXSEL.SetDisabled(false);
                Chk106_SSFIXSEL.SetDisabled(false);
                Chk107_SSFIXSEL.SetDisabled(false);
                Chk108_SSFIXSEL.SetDisabled(false);
                Chk109_SSFIXSEL.SetDisabled(false);
                Chk110_SSFIXSEL.SetDisabled(false);
                Chk111_SSFIXSEL.SetDisabled(false);
                Chk112_SSFIXSEL.SetDisabled(false);
                Chk113_SSFIXSEL.SetDisabled(false);
                Chk114_SSFIXSEL.SetDisabled(false);
                Chk115_SSFIXSEL.SetDisabled(false);
                Chk116_SSFIXSEL.SetDisabled(false);

                Chk201_SSFIXSEL.SetDisabled(false);
                Chk202_SSFIXSEL.SetDisabled(false);
                Chk203_SSFIXSEL.SetDisabled(false);
                Chk204_SSFIXSEL.SetDisabled(false);
                Chk205_SSFIXSEL.SetDisabled(false);
                Chk206_SSFIXSEL.SetDisabled(false);
                Chk207_SSFIXSEL.SetDisabled(false);
                Chk208_SSFIXSEL.SetDisabled(false);
                Chk209_SSFIXSEL.SetDisabled(false);
                Chk210_SSFIXSEL.SetDisabled(false);
                Chk211_SSFIXSEL.SetDisabled(false);
                Chk212_SSFIXSEL.SetDisabled(false);
                Chk213_SSFIXSEL.SetDisabled(false);
                Chk214_SSFIXSEL.SetDisabled(false);
                Chk215_SSFIXSEL.SetDisabled(false);
                Chk216_SSFIXSEL.SetDisabled(false);
                Chk217_SSFIXSEL.SetDisabled(false);
                Chk218_SSFIXSEL.SetDisabled(false);

                Chk301_SSFIXSEL.SetDisabled(false);
                Chk302_SSFIXSEL.SetDisabled(false);
                Chk303_SSFIXSEL.SetDisabled(false);
                Chk304_SSFIXSEL.SetDisabled(false);
                Chk305_SSFIXSEL.SetDisabled(false);
                Chk306_SSFIXSEL.SetDisabled(false);
                Chk307_SSFIXSEL.SetDisabled(false);
                Chk308_SSFIXSEL.SetDisabled(false);
                Chk309_SSFIXSEL.SetDisabled(false);
                Chk310_SSFIXSEL.SetDisabled(false);
                Chk311_SSFIXSEL.SetDisabled(false);
                Chk312_SSFIXSEL.SetDisabled(false);
                Chk313_SSFIXSEL.SetDisabled(false);
                Chk314_SSFIXSEL.SetDisabled(false);

                Chk401_SSFIXSEL.SetDisabled(false);
                Chk402_SSFIXSEL.SetDisabled(false);
                Chk403_SSFIXSEL.SetDisabled(false);
                Chk404_SSFIXSEL.SetDisabled(false);
                Chk405_SSFIXSEL.SetDisabled(false);
                Chk406_SSFIXSEL.SetDisabled(false);
                Chk407_SSFIXSEL.SetDisabled(false);
                Chk408_SSFIXSEL.SetDisabled(false);
                Chk409_SSFIXSEL.SetDisabled(false);

                Chk501_SSFIXSEL.SetDisabled(false);
                Chk502_SSFIXSEL.SetDisabled(false);
                Chk503_SSFIXSEL.SetDisabled(false);
                Chk504_SSFIXSEL.SetDisabled(false);

                Chk601_SSFIXSEL.SetDisabled(false);
                Chk602_SSFIXSEL.SetDisabled(false);
                Chk603_SSFIXSEL.SetDisabled(false);

                Chk701_SSFIXSEL.SetDisabled(false);
                Chk702_SSFIXSEL.SetDisabled(false);
                Chk703_SSFIXSEL.SetDisabled(false);
                Chk704_SSFIXSEL.SetDisabled(false);
                Chk705_SSFIXSEL.SetDisabled(false);
                Chk706_SSFIXSEL.SetDisabled(false);
                Chk707_SSFIXSEL.SetDisabled(false);
                Chk708_SSFIXSEL.SetDisabled(false);

                Chk901_SSFIXSEL.SetDisabled(false);
                Chk902_SSFIXSEL.SetDisabled(false);
                Chk903_SSFIXSEL.SetDisabled(false);
                Chk904_SSFIXSEL.SetDisabled(false);
                Chk905_SSFIXSEL.SetDisabled(false);
                Chk906_SSFIXSEL.SetDisabled(false);
                Chk907_SSFIXSEL.SetDisabled(false);
                Chk908_SSFIXSEL.SetDisabled(false);
                Chk909_SSFIXSEL.SetDisabled(false);
                Chk910_SSFIXSEL.SetDisabled(false);
                Chk911_SSFIXSEL.SetDisabled(false);
                Chk912_SSFIXSEL.SetDisabled(false);
                Chk913_SSFIXSEL.SetDisabled(false);
                Chk914_SSFIXSEL.SetDisabled(false);
                Chk915_SSFIXSEL.SetDisabled(false);
                Chk916_SSFIXSEL.SetDisabled(false);
            }

            if (gubun == '5') {

                // 발행
                Chk101_SSPUBSEL.SetDisabled(true);
                Chk102_SSPUBSEL.SetDisabled(true);
                Chk103_SSPUBSEL.SetDisabled(true);
                Chk104_SSPUBSEL.SetDisabled(true);
                Chk105_SSPUBSEL.SetDisabled(true);
                Chk106_SSPUBSEL.SetDisabled(true);
                Chk107_SSPUBSEL.SetDisabled(true);
                Chk108_SSPUBSEL.SetDisabled(true);
                Chk109_SSPUBSEL.SetDisabled(true);
                Chk110_SSPUBSEL.SetDisabled(true);
                Chk111_SSPUBSEL.SetDisabled(true);
                Chk112_SSPUBSEL.SetDisabled(true);
                Chk113_SSPUBSEL.SetDisabled(true);
                Chk114_SSPUBSEL.SetDisabled(true);
                Chk115_SSPUBSEL.SetDisabled(true);
                Chk116_SSPUBSEL.SetDisabled(true);

                Chk201_SSPUBSEL.SetDisabled(true);
                Chk202_SSPUBSEL.SetDisabled(true);
                Chk203_SSPUBSEL.SetDisabled(true);
                Chk204_SSPUBSEL.SetDisabled(true);
                Chk205_SSPUBSEL.SetDisabled(true);
                Chk206_SSPUBSEL.SetDisabled(true);
                Chk207_SSPUBSEL.SetDisabled(true);
                Chk208_SSPUBSEL.SetDisabled(true);
                Chk209_SSPUBSEL.SetDisabled(true);
                Chk210_SSPUBSEL.SetDisabled(true);
                Chk211_SSPUBSEL.SetDisabled(true);
                Chk212_SSPUBSEL.SetDisabled(true);
                Chk213_SSPUBSEL.SetDisabled(true);
                Chk214_SSPUBSEL.SetDisabled(true);
                Chk215_SSPUBSEL.SetDisabled(true);
                Chk216_SSPUBSEL.SetDisabled(true);
                Chk217_SSPUBSEL.SetDisabled(true);
                Chk218_SSPUBSEL.SetDisabled(true);

                Chk301_SSPUBSEL.SetDisabled(true);
                Chk302_SSPUBSEL.SetDisabled(true);
                Chk303_SSPUBSEL.SetDisabled(true);
                Chk304_SSPUBSEL.SetDisabled(true);
                Chk305_SSPUBSEL.SetDisabled(true);
                Chk306_SSPUBSEL.SetDisabled(true);
                Chk307_SSPUBSEL.SetDisabled(true);
                Chk308_SSPUBSEL.SetDisabled(true);
                Chk309_SSPUBSEL.SetDisabled(true);
                Chk310_SSPUBSEL.SetDisabled(true);
                Chk311_SSPUBSEL.SetDisabled(true);
                Chk312_SSPUBSEL.SetDisabled(true);
                Chk313_SSPUBSEL.SetDisabled(true);
                Chk314_SSPUBSEL.SetDisabled(true);

                Chk401_SSPUBSEL.SetDisabled(true);
                Chk402_SSPUBSEL.SetDisabled(true);
                Chk403_SSPUBSEL.SetDisabled(true);
                Chk404_SSPUBSEL.SetDisabled(true);
                Chk405_SSPUBSEL.SetDisabled(true);
                Chk406_SSPUBSEL.SetDisabled(true);
                Chk407_SSPUBSEL.SetDisabled(true);
                Chk408_SSPUBSEL.SetDisabled(true);
                Chk409_SSPUBSEL.SetDisabled(true);

                Chk501_SSPUBSEL.SetDisabled(true);
                Chk502_SSPUBSEL.SetDisabled(true);
                Chk503_SSPUBSEL.SetDisabled(true);
                Chk504_SSPUBSEL.SetDisabled(true);

                Chk601_SSPUBSEL.SetDisabled(true);
                Chk602_SSPUBSEL.SetDisabled(true);
                Chk603_SSPUBSEL.SetDisabled(true);

                Chk701_SSPUBSEL.SetDisabled(true);
                Chk702_SSPUBSEL.SetDisabled(true);
                Chk703_SSPUBSEL.SetDisabled(true);
                Chk704_SSPUBSEL.SetDisabled(true);
                Chk705_SSPUBSEL.SetDisabled(true);
                Chk706_SSPUBSEL.SetDisabled(true);
                Chk707_SSPUBSEL.SetDisabled(true);
                Chk708_SSPUBSEL.SetDisabled(true);

                Chk901_SSPUBSEL.SetDisabled(true);
                Chk902_SSPUBSEL.SetDisabled(true);
                Chk903_SSPUBSEL.SetDisabled(true);
                Chk904_SSPUBSEL.SetDisabled(true);
                Chk905_SSPUBSEL.SetDisabled(true);
                Chk906_SSPUBSEL.SetDisabled(true);
                Chk907_SSPUBSEL.SetDisabled(true);
                Chk908_SSPUBSEL.SetDisabled(true);
                Chk909_SSPUBSEL.SetDisabled(true);
                Chk910_SSPUBSEL.SetDisabled(true);
                Chk911_SSPUBSEL.SetDisabled(true);
                Chk912_SSPUBSEL.SetDisabled(true);
                Chk913_SSPUBSEL.SetDisabled(true);
                Chk914_SSPUBSEL.SetDisabled(true);
                Chk915_SSPUBSEL.SetDisabled(true);
                Chk916_SSPUBSEL.SetDisabled(true);







                // 검토
                Chk101_SSREVSEL.SetDisabled(true);
                Chk102_SSREVSEL.SetDisabled(true);
                Chk103_SSREVSEL.SetDisabled(true);
                Chk104_SSREVSEL.SetDisabled(true);
                Chk105_SSREVSEL.SetDisabled(true);
                Chk106_SSREVSEL.SetDisabled(true);
                Chk107_SSREVSEL.SetDisabled(true);
                Chk108_SSREVSEL.SetDisabled(true);
                Chk109_SSREVSEL.SetDisabled(true);
                Chk110_SSREVSEL.SetDisabled(true);
                Chk111_SSREVSEL.SetDisabled(true);
                Chk112_SSREVSEL.SetDisabled(true);
                Chk113_SSREVSEL.SetDisabled(true);
                Chk114_SSREVSEL.SetDisabled(true);
                Chk115_SSREVSEL.SetDisabled(true);
                Chk116_SSREVSEL.SetDisabled(true);

                Chk201_SSREVSEL.SetDisabled(true);
                Chk202_SSREVSEL.SetDisabled(true);
                Chk203_SSREVSEL.SetDisabled(true);
                Chk204_SSREVSEL.SetDisabled(true);
                Chk205_SSREVSEL.SetDisabled(true);
                Chk206_SSREVSEL.SetDisabled(true);
                Chk207_SSREVSEL.SetDisabled(true);
                Chk208_SSREVSEL.SetDisabled(true);
                Chk209_SSREVSEL.SetDisabled(true);
                Chk210_SSREVSEL.SetDisabled(true);
                Chk211_SSREVSEL.SetDisabled(true);
                Chk212_SSREVSEL.SetDisabled(true);
                Chk213_SSREVSEL.SetDisabled(true);
                Chk214_SSREVSEL.SetDisabled(true);
                Chk215_SSREVSEL.SetDisabled(true);
                Chk216_SSREVSEL.SetDisabled(true);
                Chk217_SSREVSEL.SetDisabled(true);
                Chk218_SSREVSEL.SetDisabled(true);

                Chk301_SSREVSEL.SetDisabled(true);
                Chk302_SSREVSEL.SetDisabled(true);
                Chk303_SSREVSEL.SetDisabled(true);
                Chk304_SSREVSEL.SetDisabled(true);
                Chk305_SSREVSEL.SetDisabled(true);
                Chk306_SSREVSEL.SetDisabled(true);
                Chk307_SSREVSEL.SetDisabled(true);
                Chk308_SSREVSEL.SetDisabled(true);
                Chk309_SSREVSEL.SetDisabled(true);
                Chk310_SSREVSEL.SetDisabled(true);
                Chk311_SSREVSEL.SetDisabled(true);
                Chk312_SSREVSEL.SetDisabled(true);
                Chk313_SSREVSEL.SetDisabled(true);
                Chk314_SSREVSEL.SetDisabled(true);

                Chk401_SSREVSEL.SetDisabled(true);
                Chk402_SSREVSEL.SetDisabled(true);
                Chk403_SSREVSEL.SetDisabled(true);
                Chk404_SSREVSEL.SetDisabled(true);
                Chk405_SSREVSEL.SetDisabled(true);
                Chk406_SSREVSEL.SetDisabled(true);
                Chk407_SSREVSEL.SetDisabled(true);
                Chk408_SSREVSEL.SetDisabled(true);
                Chk409_SSREVSEL.SetDisabled(true);

                Chk501_SSREVSEL.SetDisabled(true);
                Chk502_SSREVSEL.SetDisabled(true);
                Chk503_SSREVSEL.SetDisabled(true);
                Chk504_SSREVSEL.SetDisabled(true);

                Chk601_SSREVSEL.SetDisabled(true);
                Chk602_SSREVSEL.SetDisabled(true);
                Chk603_SSREVSEL.SetDisabled(true);

                Chk701_SSREVSEL.SetDisabled(true);
                Chk702_SSREVSEL.SetDisabled(true);
                Chk703_SSREVSEL.SetDisabled(true);
                Chk704_SSREVSEL.SetDisabled(true);
                Chk705_SSREVSEL.SetDisabled(true);
                Chk706_SSREVSEL.SetDisabled(true);
                Chk707_SSREVSEL.SetDisabled(true);
                Chk708_SSREVSEL.SetDisabled(true);

                Chk901_SSREVSEL.SetDisabled(true);
                Chk902_SSREVSEL.SetDisabled(true);
                Chk903_SSREVSEL.SetDisabled(true);
                Chk904_SSREVSEL.SetDisabled(true);
                Chk905_SSREVSEL.SetDisabled(true);
                Chk906_SSREVSEL.SetDisabled(true);
                Chk907_SSREVSEL.SetDisabled(true);
                Chk908_SSREVSEL.SetDisabled(true);
                Chk909_SSREVSEL.SetDisabled(true);
                Chk910_SSREVSEL.SetDisabled(true);
                Chk911_SSREVSEL.SetDisabled(true);
                Chk912_SSREVSEL.SetDisabled(true);
                Chk913_SSREVSEL.SetDisabled(true);
                Chk914_SSREVSEL.SetDisabled(true);
                Chk915_SSREVSEL.SetDisabled(true);
                Chk916_SSREVSEL.SetDisabled(true);






                // 확인
                Chk101_SSFIXSEL.SetDisabled(true);
                Chk102_SSFIXSEL.SetDisabled(true);
                Chk103_SSFIXSEL.SetDisabled(true);
                Chk104_SSFIXSEL.SetDisabled(true);
                Chk105_SSFIXSEL.SetDisabled(true);
                Chk106_SSFIXSEL.SetDisabled(true);
                Chk107_SSFIXSEL.SetDisabled(true);
                Chk108_SSFIXSEL.SetDisabled(true);
                Chk109_SSFIXSEL.SetDisabled(true);
                Chk110_SSFIXSEL.SetDisabled(true);
                Chk111_SSFIXSEL.SetDisabled(true);
                Chk112_SSFIXSEL.SetDisabled(true);
                Chk113_SSFIXSEL.SetDisabled(true);
                Chk114_SSFIXSEL.SetDisabled(true);
                Chk115_SSFIXSEL.SetDisabled(true);
                Chk116_SSFIXSEL.SetDisabled(true);

                Chk201_SSFIXSEL.SetDisabled(true);
                Chk202_SSFIXSEL.SetDisabled(true);
                Chk203_SSFIXSEL.SetDisabled(true);
                Chk204_SSFIXSEL.SetDisabled(true);
                Chk205_SSFIXSEL.SetDisabled(true);
                Chk206_SSFIXSEL.SetDisabled(true);
                Chk207_SSFIXSEL.SetDisabled(true);
                Chk208_SSFIXSEL.SetDisabled(true);
                Chk209_SSFIXSEL.SetDisabled(true);
                Chk210_SSFIXSEL.SetDisabled(true);
                Chk211_SSFIXSEL.SetDisabled(true);
                Chk212_SSFIXSEL.SetDisabled(true);
                Chk213_SSFIXSEL.SetDisabled(true);
                Chk214_SSFIXSEL.SetDisabled(true);
                Chk215_SSFIXSEL.SetDisabled(true);
                Chk216_SSFIXSEL.SetDisabled(true);
                Chk217_SSFIXSEL.SetDisabled(true);
                Chk218_SSFIXSEL.SetDisabled(true);

                Chk301_SSFIXSEL.SetDisabled(true);
                Chk302_SSFIXSEL.SetDisabled(true);
                Chk303_SSFIXSEL.SetDisabled(true);
                Chk304_SSFIXSEL.SetDisabled(true);
                Chk305_SSFIXSEL.SetDisabled(true);
                Chk306_SSFIXSEL.SetDisabled(true);
                Chk307_SSFIXSEL.SetDisabled(true);
                Chk308_SSFIXSEL.SetDisabled(true);
                Chk309_SSFIXSEL.SetDisabled(true);
                Chk310_SSFIXSEL.SetDisabled(true);
                Chk311_SSFIXSEL.SetDisabled(true);
                Chk312_SSFIXSEL.SetDisabled(true);
                Chk313_SSFIXSEL.SetDisabled(true);
                Chk314_SSFIXSEL.SetDisabled(true);

                Chk401_SSFIXSEL.SetDisabled(true);
                Chk402_SSFIXSEL.SetDisabled(true);
                Chk403_SSFIXSEL.SetDisabled(true);
                Chk404_SSFIXSEL.SetDisabled(true);
                Chk405_SSFIXSEL.SetDisabled(true);
                Chk406_SSFIXSEL.SetDisabled(true);
                Chk407_SSFIXSEL.SetDisabled(true);
                Chk408_SSFIXSEL.SetDisabled(true);
                Chk409_SSFIXSEL.SetDisabled(true);

                Chk501_SSFIXSEL.SetDisabled(true);
                Chk502_SSFIXSEL.SetDisabled(true);
                Chk503_SSFIXSEL.SetDisabled(true);
                Chk504_SSFIXSEL.SetDisabled(true);

                Chk601_SSFIXSEL.SetDisabled(true);
                Chk602_SSFIXSEL.SetDisabled(true);
                Chk603_SSFIXSEL.SetDisabled(true);

                Chk701_SSFIXSEL.SetDisabled(true);
                Chk702_SSFIXSEL.SetDisabled(true);
                Chk703_SSFIXSEL.SetDisabled(true);
                Chk704_SSFIXSEL.SetDisabled(true);
                Chk705_SSFIXSEL.SetDisabled(true);
                Chk706_SSFIXSEL.SetDisabled(true);
                Chk707_SSFIXSEL.SetDisabled(true);
                Chk708_SSFIXSEL.SetDisabled(true);

                Chk901_SSFIXSEL.SetDisabled(true);
                Chk902_SSFIXSEL.SetDisabled(true);
                Chk903_SSFIXSEL.SetDisabled(true);
                Chk904_SSFIXSEL.SetDisabled(true);
                Chk905_SSFIXSEL.SetDisabled(true);
                Chk906_SSFIXSEL.SetDisabled(true);
                Chk907_SSFIXSEL.SetDisabled(true);
                Chk908_SSFIXSEL.SetDisabled(true);
                Chk909_SSFIXSEL.SetDisabled(true);
                Chk910_SSFIXSEL.SetDisabled(true);
                Chk911_SSFIXSEL.SetDisabled(true);
                Chk912_SSFIXSEL.SetDisabled(true);
                Chk913_SSFIXSEL.SetDisabled(true);
                Chk914_SSFIXSEL.SetDisabled(true);
                Chk915_SSFIXSEL.SetDisabled(true);
                Chk916_SSFIXSEL.SetDisabled(true);

                chkSWWKCODE1.SetDisabled(true);
                chkSWWKCODE2.SetDisabled(true);
                chkSWWKCODE3.SetDisabled(true);
                chkSWWKCODE4.SetDisabled(true);
                chkSWWKCODE5.SetDisabled(true);
                chkSWWKCODE6.SetDisabled(true);
                chkSWWKCODE7.SetDisabled(true);
                chkSWWKCODE8.SetDisabled(true);
                chkSWWKCODE9.SetDisabled(true);
                chkSWWKCODE10.SetDisabled(true);
            }

            if (gubun == '6') {
                // 확인
                Chk101_SSFIXSEL.SetDisabled(false);
                Chk102_SSFIXSEL.SetDisabled(false);
                Chk103_SSFIXSEL.SetDisabled(false);
                Chk104_SSFIXSEL.SetDisabled(false);
                Chk105_SSFIXSEL.SetDisabled(false);
                Chk106_SSFIXSEL.SetDisabled(false);
                Chk107_SSFIXSEL.SetDisabled(false);
                Chk108_SSFIXSEL.SetDisabled(false);
                Chk109_SSFIXSEL.SetDisabled(false);
                Chk110_SSFIXSEL.SetDisabled(false);
                Chk111_SSFIXSEL.SetDisabled(false);
                Chk112_SSFIXSEL.SetDisabled(false);
                Chk113_SSFIXSEL.SetDisabled(false);
                Chk114_SSFIXSEL.SetDisabled(false);
                Chk115_SSFIXSEL.SetDisabled(false);
                Chk116_SSFIXSEL.SetDisabled(false);

                Chk201_SSFIXSEL.SetDisabled(false);
                Chk202_SSFIXSEL.SetDisabled(false);
                Chk203_SSFIXSEL.SetDisabled(false);
                Chk204_SSFIXSEL.SetDisabled(false);
                Chk205_SSFIXSEL.SetDisabled(false);
                Chk206_SSFIXSEL.SetDisabled(false);
                Chk207_SSFIXSEL.SetDisabled(false);
                Chk208_SSFIXSEL.SetDisabled(false);
                Chk209_SSFIXSEL.SetDisabled(false);
                Chk210_SSFIXSEL.SetDisabled(false);
                Chk211_SSFIXSEL.SetDisabled(false);
                Chk212_SSFIXSEL.SetDisabled(false);
                Chk213_SSFIXSEL.SetDisabled(false);
                Chk214_SSFIXSEL.SetDisabled(false);
                Chk215_SSFIXSEL.SetDisabled(false);
                Chk216_SSFIXSEL.SetDisabled(false);
                Chk217_SSFIXSEL.SetDisabled(false);
                Chk218_SSFIXSEL.SetDisabled(false);

                Chk301_SSFIXSEL.SetDisabled(false);
                Chk302_SSFIXSEL.SetDisabled(false);
                Chk303_SSFIXSEL.SetDisabled(false);
                Chk304_SSFIXSEL.SetDisabled(false);
                Chk305_SSFIXSEL.SetDisabled(false);
                Chk306_SSFIXSEL.SetDisabled(false);
                Chk307_SSFIXSEL.SetDisabled(false);
                Chk308_SSFIXSEL.SetDisabled(false);
                Chk309_SSFIXSEL.SetDisabled(false);
                Chk310_SSFIXSEL.SetDisabled(false);
                Chk311_SSFIXSEL.SetDisabled(false);
                Chk312_SSFIXSEL.SetDisabled(false);
                Chk313_SSFIXSEL.SetDisabled(false);
                Chk314_SSFIXSEL.SetDisabled(false);

                Chk401_SSFIXSEL.SetDisabled(false);
                Chk402_SSFIXSEL.SetDisabled(false);
                Chk403_SSFIXSEL.SetDisabled(false);
                Chk404_SSFIXSEL.SetDisabled(false);
                Chk405_SSFIXSEL.SetDisabled(false);
                Chk406_SSFIXSEL.SetDisabled(false);
                Chk407_SSFIXSEL.SetDisabled(false);
                Chk408_SSFIXSEL.SetDisabled(false);
                Chk409_SSFIXSEL.SetDisabled(false);

                Chk501_SSFIXSEL.SetDisabled(false);
                Chk502_SSFIXSEL.SetDisabled(false);
                Chk503_SSFIXSEL.SetDisabled(false);
                Chk504_SSFIXSEL.SetDisabled(false);

                Chk601_SSFIXSEL.SetDisabled(false);
                Chk602_SSFIXSEL.SetDisabled(false);
                Chk603_SSFIXSEL.SetDisabled(false);

                Chk701_SSFIXSEL.SetDisabled(false);
                Chk702_SSFIXSEL.SetDisabled(false);
                Chk703_SSFIXSEL.SetDisabled(false);
                Chk704_SSFIXSEL.SetDisabled(false);
                Chk705_SSFIXSEL.SetDisabled(false);
                Chk706_SSFIXSEL.SetDisabled(false);
                Chk707_SSFIXSEL.SetDisabled(false);
                Chk708_SSFIXSEL.SetDisabled(false);

                Chk901_SSFIXSEL.SetDisabled(false);
                Chk902_SSFIXSEL.SetDisabled(false);
                Chk903_SSFIXSEL.SetDisabled(false);
                Chk904_SSFIXSEL.SetDisabled(false);
                Chk905_SSFIXSEL.SetDisabled(false);
                Chk906_SSFIXSEL.SetDisabled(false);
                Chk907_SSFIXSEL.SetDisabled(false);
                Chk908_SSFIXSEL.SetDisabled(false);
                Chk909_SSFIXSEL.SetDisabled(false);
                Chk910_SSFIXSEL.SetDisabled(false);
                Chk911_SSFIXSEL.SetDisabled(false);
                Chk912_SSFIXSEL.SetDisabled(false);
                Chk913_SSFIXSEL.SetDisabled(false);
                Chk914_SSFIXSEL.SetDisabled(false);
                Chk915_SSFIXSEL.SetDisabled(false);
                Chk916_SSFIXSEL.SetDisabled(false);
            }
        }

        <%-- 신규 확인 --%>
        function fn_GET_WorkOrder() {

            var DataSet;
            var ht = new Object();

            ht["P_WOORTEAM"] = txtSMWKTEAM.GetValue();
            ht["P_WOORDATE"] = Get_Date(datSMWKDATE.GetValue().replace("-", ""));
            ht["P_WOSEQ"]    = Set_Fill3(txtSMWKSEQ.GetValue());

            PageMethods.InvokeServiceTable(ht, "PSM.PSM4040", "UP_WORKORDER_RUN", function (e) {

                DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtSMWORKTITLE.SetValue(DataSet.Tables[0].Rows[0]["WOWORKTITLE"]);

                    // 작업부서
                    $("#svSMREVTEAM_BUSEO").val(DataSet.Tables[0].Rows[0]["WOSOTEAM"]);
                    $("#svSMREVTEAM_BUSEONM").val(DataSet.Tables[0].Rows[0]["WOSOTEAMNM"]);

                    // 설비코드(1~5)
                    txtSMSYSTEMCODE1.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE1"]);
                    pnlSMSYSTEMCODE1.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE1NM"]);

                    txtSMSYSTEMCODE2.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE2"]);
                    pnlSMSYSTEMCODE2.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE2NM"]);

                    txtSMSYSTEMCODE3.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE3"]);
                    pnlSMSYSTEMCODE3.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE3NM"]);

                    txtSMSYSTEMCODE4.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE4"]);
                    pnlSMSYSTEMCODE4.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE4NM"]);

                    txtSMSYSTEMCODE5.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE5"]);
                    pnlSMSYSTEMCODE5.SetValue(DataSet.Tables[0].Rows[0]["WOLOCATIONCODE5NM"]);

                    // 연관설비1(1~5)
                    txtSMCONNCODE11.SetValue(DataSet.Tables[0].Rows[0]["C3CODE11"]);
                    pnlSMCONNCODE11.SetValue(DataSet.Tables[0].Rows[0]["C3CODE11NM"]);

                    txtSMCONNCODE21.SetValue(DataSet.Tables[0].Rows[0]["C3CODE21"]);
                    pnlSMCONNCODE21.SetValue(DataSet.Tables[0].Rows[0]["C3CODE21NM"]);

                    txtSMCONNCODE31.SetValue(DataSet.Tables[0].Rows[0]["C3CODE31"]);
                    pnlSMCONNCODE31.SetValue(DataSet.Tables[0].Rows[0]["C3CODE31NM"]);

                    txtSMCONNCODE41.SetValue(DataSet.Tables[0].Rows[0]["C3CODE41"]);
                    pnlSMCONNCODE41.SetValue(DataSet.Tables[0].Rows[0]["C3CODE41NM"]);

                    txtSMCONNCODE51.SetValue(DataSet.Tables[0].Rows[0]["C3CODE51"]);
                    pnlSMCONNCODE51.SetValue(DataSet.Tables[0].Rows[0]["C3CODE51NM"]);

                    // 연관설비2(1~5)
                    txtSMCONNCODE12.SetValue(DataSet.Tables[0].Rows[0]["C3CODE12"]);
                    pnlSMCONNCODE12.SetValue(DataSet.Tables[0].Rows[0]["C3CODE12NM"]);

                    txtSMCONNCODE22.SetValue(DataSet.Tables[0].Rows[0]["C3CODE22"]);
                    pnlSMCONNCODE22.SetValue(DataSet.Tables[0].Rows[0]["C3CODE22NM"]);

                    txtSMCONNCODE32.SetValue(DataSet.Tables[0].Rows[0]["C3CODE32"]);
                    pnlSMCONNCODE32.SetValue(DataSet.Tables[0].Rows[0]["C3CODE32NM"]);

                    txtSMCONNCODE42.SetValue(DataSet.Tables[0].Rows[0]["C3CODE42"]);
                    pnlSMCONNCODE42.SetValue(DataSet.Tables[0].Rows[0]["C3CODE42NM"]);

                    txtSMCONNCODE52.SetValue(DataSet.Tables[0].Rows[0]["C3CODE52"]);
                    pnlSMCONNCODE52.SetValue(DataSet.Tables[0].Rows[0]["C3CODE52NM"]);

                    // 작업구역
                    txtSMAREACODE1.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE1"]);
                    pnlSMAREACODE1.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE1NM"]);

                    txtSMAREACODE2.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE2"]);
                    pnlSMAREACODE2.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE2NM"]);

                    txtSMAREACODE3.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE3"]);
                    pnlSMAREACODE3.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE3NM"]);

                    txtSMAREACODE4.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE4"]);
                    pnlSMAREACODE4.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE4NM"]);

                    txtSMAREACODE5.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE5"]);
                    pnlSMAREACODE5.SetValue(DataSet.Tables[0].Rows[0]["WOAREACODE5NM"]);

                    // 조치요구사항 체크박스 Readonly
                    fn_Chk_SaCode_ReadOnly('');
                }
                else {

                    // 조치요구사항 체크박스 Readonly
                    fn_Chk_SaCode_ReadOnly('');
                }
            }, function (e) {
                // Biz 연결오류
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="로딩중 사번 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
            });
        }


        <%-- 확인 --%>


        <%-- 저장 --%>

        <%-- 수정 --%>

        <%-- 삭제 --%>

        <%-- 체크 --%>



        function fn_Chk_SaCode_ReadOnly(gubun) {

            if (gubun = '') {
                // 수정시
                if (fshdnGubun == 'UPT') {

                    // SIGN 및 버튼
                    fn_Get_Sign();

                    // 연장 결재
                    fn_Get_SMOT_Display();
                }
            }

            if (txtSMFSDATE.GetValue() == '') {

                if ($("input:checkbox[name=chkSWWKCODE2]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE3]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE4]").prop('checked') == true ||
                    $("input:checkbox[name=chkSWWKCODE5]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE7]").prop('checked') == true ||
                    $("input:checkbox[name=chkSWWKCODE8]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE9]").prop('checked') == true) {
                    if (fshdnApprovalSite == "") {
                        fn_Check_Sacode_Enable("");
                    }
                    else if (fshdnApprovalSite == "1") {
                        fn_Check_Sacode_Enable("1");
                    }
                    else if (fshdnApprovalSite == "2") {
                        fn_Check_Sacode_Enable("2");
                    }
                    else if (fshdnApprovalSite == "3") {
                        fn_Check_Sacode_Enable("2");
                    }
                }
                else {
                    if (fshdnApprovalSite == "") {
                        fn_Check_Sacode_Enable("");
                    }
                    else if (fshdnApprovalSite == "1") {
                        fn_Check_Sacode_Enable("1");
                    }
                    else if (fshdnApprovalSite == "2") {
                        fn_Check_Sacode_Enable("2");
                    }
                    else {
                        //fn_Check_Sacode_Enable("3");
                    }
                }

                if (fsAuth == 'SAFE_MAG') {
                    fn_Check_Sacode_Enable("3");
                }
            }
            else {

                if (fsAuth == 'SAFE_MAG' || fsAuth == 'SAFE_OPERA') {
                    fn_Check_Sacode_Enable("3");
                }
                else {
                    fn_Check_Sacode_Enable("5");
                }
            }
        }

        <%-- 콜백 --%>

        // 콜백 함수
        function btnPopup_Callback(ht) {
            fsRETRACTCOMMENT = "";

            // 결재 의견
            if (_id == "APPROVAL") {

                fn_COMMENT(ht);

                doDisplay();

                fn_Screen_Save(_id, "");

                /*setTimeout("doDisplay()", '5000');*/
            }

            // 철회 의견
            if (_id == "RETRACT") {

                debugger;
                fsRETRACTCOMMENT = ht;

                doDisplay();

                fn_RETRACT_Proc();

                setTimeout("doDisplay()", '3000');
            }

            // 반려 의견
            if (_id == "CANCEL") {

                debugger;
                fsRETRACTCOMMENT = ht;

                doDisplay();

                fn_CANCEL_Proc();

                /*setTimeout("doDisplay()", '3000');*/
            }


            // 발주 조회
            if (_id == "WOPONUM1") {
                txtWOPONUM1.SetValue(ht["POM1000"] + ht["POM1010"] + ht["POM1020"] + Set_Fill4(ht["POM1030"]));
            }

            // 설비코드
            if (_id == "SMSYSTEMCODE1") {
                txtSMSYSTEMCODE1.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                pnlSMSYSTEMCODE1.SetValue(ht["C3NAME"]);
                txtSMCONNCODE11.SetValue(ht["C3LINKCODE1"]);
                pnlSMCONNCODE11.SetValue(ht["C3LINKCODE1NM"]);
                txtSMCONNCODE12.SetValue(ht["C3LINKCODE2"]);
                pnlSMCONNCODE12.SetValue(ht["C3LINKCODE2NM"]);
            }
            else if (_id == "SMSYSTEMCODE2") {
                txtSMSYSTEMCODE2.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                pnlSMSYSTEMCODE2.SetValue(ht["C3NAME"]);
                txtSMCONNCODE21.SetValue(ht["C3LINKCODE1"]);
                pnlSMCONNCODE21.SetValue(ht["C3LINKCODE1NM"]);
                txtSMCONNCODE22.SetValue(ht["C3LINKCODE2"]);
                pnlSMCONNCODE22.SetValue(ht["C3LINKCODE2NM"]);
            }
            else if (_id == "SMSYSTEMCODE3") {
                txtSMSYSTEMCODE3.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                pnlSMSYSTEMCODE3.SetValue(ht["C3NAME"]);
                txtSMCONNCODE31.SetValue(ht["C3LINKCODE1"]);
                pnlSMCONNCODE31.SetValue(ht["C3LINKCODE1NM"]);
                txtSMCONNCODE32.SetValue(ht["C3LINKCODE2"]);
                pnlSMCONNCODE32.SetValue(ht["C3LINKCODE2NM"]);
            }
            else if (_id == "SMSYSTEMCODE4") {
                txtSMSYSTEMCODE4.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                pnlSMSYSTEMCODE4.SetValue(ht["C3NAME"]);
                txtSMCONNCODE41.SetValue(ht["C3LINKCODE1"]);
                pnlSMCONNCODE41.SetValue(ht["C3LINKCODE1NM"]);
                txtSMCONNCODE42.SetValue(ht["C3LINKCODE2"]);
                pnlSMCONNCODE42.SetValue(ht["C3LINKCODE2NM"]);
            }
            else if (_id == "SMSYSTEMCODE5") {
                txtSMSYSTEMCODE5.SetValue(ht["C3SAUP"] + ht["C3BCODE"] + ht["C3MCODE"] + ht["C3SCODE"]);
                pnlSMSYSTEMCODE5.SetValue(ht["C3NAME"]);
                txtSMCONNCODE51.SetValue(ht["C3LINKCODE1"]);
                pnlSMCONNCODE51.SetValue(ht["C3LINKCODE1NM"]);
                txtSMCONNCODE52.SetValue(ht["C3LINKCODE2"]);
                pnlSMCONNCODE52.SetValue(ht["C3LINKCODE2NM"]);
            }
        }

        // 작업구역 코드헬프
        function btnAreaPopup_Click(id) {
            _id = id;

            if (txtSMSYSTEMCODE1.GetValue() == '') {
                alert('<Ctl:Text runat="server" Description="설비 코드1을 선택하세요." Literal="true"></Ctl:Text>');
                return;
            }

            var gubun;

            var sTeam = txtSMSYSTEMCODE1.GetValue();

            if (sTeam.substr(0, 1) == "T" || sTeam == "E10100") {
                gubun = "T";
            }
            else {
                if (sTeam.substr(0, 2) == "D1") {
                    if (fshdnLoginSabun == "0404-M") {
                        gubun = "S";
                    }
                    else {
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
                if ($("#txtSMAREACODE" + i).val().length >= 9) {

                    data = data + $("#txtSMAREACODE" + i).val() + "^" + $("#pnlSMAREACODE" + i).val() + "^";
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
                $("#txtSMAREACODE" + index).val(ht.Rows[i]["AREACODE"]);
                $("#pnlSMAREACODE" + index).val(ht.Rows[i]["AREACODENM"]);
            }
        }

        // 출력버튼
        function btnPrt_Click() {

            var sSMWKORAPPDATE = datSMWKORAPPDATE.GetValue().split("-").join("");
            var DOCNAME = "";

            if (sSMWKORAPPDATE > 20231114) {
                DOCNAME = "PSM4041_RPT_6";
            }
            else if (sSMWKORAPPDATE > 20180130) {
                DOCNAME = "PSM4041_RPT_5";
            }
            else if (sSMWKORAPPDATE > 20170705) {
                DOCNAME = "PSM4041_RPT_4";
            }
            else if (sSMWKORAPPDATE > 2017011) {
                DOCNAME = "PSM4041_RPT_3";
            }
            else if (sSMWKORAPPDATE > 20160608) {
                DOCNAME = "PSM4041_RPT_2";
            }
            else {
                DOCNAME = "PSM4041_RPT_1";
            }

            fn_OpenPop("../../Common/ReportView.aspx?RPT=" + DOCNAME + "&CMWKTEAM=" + txtSMWKTEAM.GetValue() + "&CMWKDATE=" + datSMWKDATE.GetValue().split("-").join("") 
                + "&CMWKSEQ=" + Set_Fill3(txtSMWKSEQ.GetValue()) + "&SMWKORAPPDATE=" + datSMWKORAPPDATE.GetValue().split("-").join("") + "&SMWKORSEQ=" + Set_Fill3(txtSMWKORSEQ.GetValue()), 1000, 600);

            //fn_OpenPop("../../Common/ReportView.aspx?RPT=" + DOCNAME + "&CMWKTEAM=" + txtSMWKTEAM.GetValue() + "&CMWKDATE=" + Get_Date(datSMWKDATE.GetValue().replace("-", "")) + "&CMWKSEQ="
            //    + Set_Fill3(txtSMWKSEQ.GetValue()), 1000, 600);
        }

        //작업구분 체크박스 선택 이벤트
        function UP_WKCODE_Click(index) {

            var exists;

            exists = '';

            if ((txtSMFSDATE.GetValue() == '') || fsAuth == 'SAFE_MAG' || fsAuth == 'SAFE_OPERA') {
                //if (index == 1) {

                //    if ($("input:checkbox[name=chkSWWKCODE1]").prop('checked') == true) {

                //        for (i = 2; i < 10; i++) {
                //            $('input:checkbox[name=chkSWWKCODE' + i + "]").prop("checked", false);
                //        }
                //    }
                //}
                //else {
                //    $("input:checkbox[name=chkSWWKCODE1]").prop('checked', false);
                //}


                if (index == 1 || index == 2) {
                    if ($("input:checkbox[name=chkSWWKCODE" + index + "]").prop('checked') == true) {

                        $("#li0" + index + "_safe").show();
                    }
                    else {
                        $("#li0" + index + "_safe").hide();
                    }
                }
                else if (index == 3 || index == 4 || index == 5) {

                    if (exists == '') {
                        if ($("input:checkbox[name=chkSWWKCODE3]").prop('checked') == true) {

                            $("#li03_safe").show();

                            exists = 'exists';
                        }
                        else {
                            $("#li03_safe").hide();
                        }
                    }

                    if (exists == '') {
                        if ($("input:checkbox[name=chkSWWKCODE4]").prop('checked') == true) {

                            $("#li03_safe").show();

                            exists = 'exists';
                        }
                        else {
                            $("#li03_safe").hide();
                        }
                    }

                    if (exists == '') {
                        if ($("input:checkbox[name=chkSWWKCODE5]").prop('checked') == true) {

                            $("#li03_safe").show();

                            exists = 'exists';
                        }
                        else {
                            $("#li03_safe").hide();
                        }
                    }
                }
                else if (index >= 6) {
                    if ($("input:checkbox[name=chkSWWKCODE" + index + "]").prop('checked') == true) {

                        $("#li0" + (index - 2) + "_safe").show();
                    }
                    else {
                        $("#li0" + (index - 2) + "_safe").hide();
                    }
                }


                if ($("input:checkbox[name=chkSWWKCODE1]").prop('checked') == true || $("input:checkbox[name=chkSWWKCODE6]").prop('checked') == true) {

                    if ($("input:checkbox[name=chkSWWKCODE2]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE3]").prop('checked') == false &&
                        $("input:checkbox[name=chkSWWKCODE4]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE5]").prop('checked') == false &&
                        $("input:checkbox[name=chkSWWKCODE7]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE8]").prop('checked') == false &&
                        $("input:checkbox[name=chkSWWKCODE9]").prop('checked') == false && $("input:checkbox[name=chkSWWKCODE10]").prop('checked') == false) {

                        $("#svSMSMSABUN_KBSABUN").val('');
                        $("#svSMSMSABUN_KBHANGL").val('');
                    }
                }
            }
        }

    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
    <!--컨텐츠시작-->
    <div id="content" >
		<!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server" Title="안전작업등록" DefaultHide="False">

            <div class="btn_bx" id ="div_btn" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="100px" />
                        <col width="230px" />
                        <col width="100px" />
                        <col width="150px" />
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left">
                            <Ctl:Text ID="lblSMWKTEAM" runat="server" LangCode="lblWOORTEAM" Description="요청번호" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtSMWKTEAM" Width ="60px" runat="server" ReadOnly="true"></Ctl:TextBox>
                            <Ctl:Text ID="lblsprate1" runat="server" LangCode="sprate1" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="datSMWKDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ReadOnly="true"></Ctl:TextBox> 
                            <Ctl:Text ID="lblsprate2" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtSMWKSEQ" Width ="30px" style ="text-align:right;" runat="server" ReadOnly="true"></Ctl:TextBox>
                        </td>
                        <th style="text-align:left">
                            <Ctl:Text ID="lblSMWKORAPPDATE" runat="server" LangCode="lblWOORTEAM" Description="허가일자" Required = "true"></Ctl:Text>
                        </th>
                        <td style="text-align:left;border-right :hidden;">
                            <Ctl:TextBox ID="datSMWKORAPPDATE" Width ="80px" SetCalendarFormat="YYYYMMDD" SetType="Calendar" runat="server"></Ctl:TextBox>
                            <Ctl:Text ID="Text5" runat="server" LangCode="sprate2" Description="-"></Ctl:Text>
                            <Ctl:TextBox ID="txtSMWKORSEQ" Width ="30px" style ="text-align:right;" runat="server" ReadOnly="true"></Ctl:TextBox>
                        </td>
                        <td>
                            <Ctl:Button ID="btnRETRACT"   runat="server" LangCode="btnRETRACT"  Description="철회"   OnClientClick="btnRETRACT_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnSign"      runat="server" LangCode="btnSign"     Description="결재선" OnClientClick="btnSign_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnSave"      runat="server" LangCode="btnSave"     Description="저장"   OnClientClick="btnSave_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnDel"       runat="server" LangCode="btnDel"      Description="삭제"   OnClientClick="btnDel_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnApproval"  runat="server" LangCode="btnApproval" Description="결재"   OnClientClick="btnApproval_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnCancel"    runat="server" LangCode="btnCancel"   Description="반려"   OnClientClick="btnCancel_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnPrt"       runat="server" LangCode="btnPrt"      Description="출력"   OnClientClick="btnPrt_Click();" ></Ctl:Button>
                            <Ctl:Button ID="btnClose"     runat="server" LangCode="btnClose"    Description="닫기"   OnClientClick="btnClose_Click();" ></Ctl:Button>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="150px" />
                        <col width="150px" />
                        <col width="*" />
                        <col width="150px" />
                        <col width="500px" />
                    </colgroup>
                    <tr>
                        <th style="text-align:center">
                            <Ctl:Text ID="Text1" runat="server" Description="작업요청자"></Ctl:Text>
                        </th>
                        <th style="text-align:center">
                            <Ctl:Text ID="Text2" runat="server" Description="허가자"></Ctl:Text>
                        </th>

                        <td rowspan ="4" style="border-top:hidden;border-bottom:hidden;"></td>

                        <th style="text-align:center">
                            <Ctl:Text ID="Text10" runat="server" Description="현장안전감독자"></Ctl:Text>
                        </th>
                    </tr>
                    <tr>
                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtSMORSABUN"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtSMORJKCD"   runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtSMORJKCDNM" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtSMORNAME"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtSMGRSABUN"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtSMGRJKCD"   runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtSMGRJKCDNM" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtSMGRNAME"   runat="server" ></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtSMCOSABUN"  runat="server" Hidden="true"></Ctl:Text>
                            <Ctl:Text ID="txtSMCOJKCD"   runat="server" Hidden="true"></Ctl:Text>

                            <Ctl:Text ID="txtSMCOJKCDNM" runat="server" ></Ctl:Text>
                            <Ctl:Text ID="txtSMCONAME"   runat="server" ></Ctl:Text>
                        </td>
                    </tr>

                    <tr style="height:100px;">

                        <td style="text-align:center;" >
                            <img ID="ImgSMORPHOTO" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPSOPHOTO1" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgSMGRPHOTO" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPSOPHOTO2" visible ="true"></img>
                        </td>

                        <td style="text-align:center;" >
                            <img ID="ImgSMCOPHOTO" runat="server" src="/Resources/Framework/blank.gif" LangCode="ImgWOAPPSOPHOTO3" visible ="true"></img>
                        </td>
                        
                    </tr>

                    <tr>
                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtSMORAPPDATE" runat="server" LangCode="txtWOAPPSODATE1"></Ctl:Text>
                            <Ctl:Text ID="txtSMORAPPTIME" runat="server" LangCode="txtWOAPPSOTIME1"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtSMGRAPPDATE" runat="server" LangCode="txtWOAPPSODATE2"></Ctl:Text>
                            <Ctl:Text ID="txtSMGRAPPTIME" runat="server" LangCode="txtWOAPPSOTIME2"></Ctl:Text>
                        </td>

                        <td style="text-align:center; height:15px" >
                            <Ctl:Text ID="txtSMCOAPPDATE" runat="server" LangCode="txtWOAPPSODATE3"></Ctl:Text>
                            <Ctl:Text ID="txtSMCOAPPTIME" runat="server" LangCode="txtWOAPPSOTIME3"></Ctl:Text>
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
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="2">
                            <Ctl:Text ID="lblSMWORKTITLE" runat="server" LangCode="lblSMWORKTITLE" Description="작업명"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtSMWORKTITLE" runat="server" LangCode="txtRENAME" Width ="1090" ></Ctl:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <th style="text-align:left;" colspan ="2">
                            <Ctl:Text ID="Text6" runat="server" LangCode="lblSMWORKTITLE" Description="작업종류"></Ctl:Text>
                        </th>
                    </tr>
                    <tr>
                        <td style="text-align:left;">

                            <Ctl:CheckBox ID="chkSWWKCODE1" runat="server" ReadMode="false" onclick="UP_WKCODE_Click(1)" >
                                <asp:ListItem Text="일반위험작업" Value="01" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="chkSWWKCODE2" runat="server" ReadMode="false" onclick="UP_WKCODE_Click(2)" >
                                <asp:ListItem Text="열간(화기)작업" Value="02" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="chkSWWKCODE3" runat="server" ReadMode="false" onclick="UP_WKCODE_Click(3)" >
                                <asp:ListItem Text="밀폐공간출입작업[" Value="03" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="chkSWWKCODE4" runat="server" ReadMode="false" onclick="UP_WKCODE_Click(3)" >
                                <asp:ListItem Text="Tank Cleaning," Value="03" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="chkSWWKCODE5" runat="server" ReadMode="false" onclick="UP_WKCODE_Click(3)" >
                                <asp:ListItem Text="Bin Cleaning]" Value="03" ></asp:ListItem>
                            </Ctl:CheckBox>

                            <Ctl:CheckBox ID="chkSWWKCODE6" runat="server" ReadMode="false" onclick="UP_WKCODE_Click(6)" >
                                <asp:ListItem Text="전기(정전)작업" Value="06" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="chkSWWKCODE7" runat="server" ReadMode="false" onclick="UP_WKCODE_Click(7)" >
                                <asp:ListItem Text="방사선사용작업" Value="07" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="chkSWWKCODE8" runat="server" ReadMode="false" onclick="UP_WKCODE_Click(8)" >
                                <asp:ListItem Text="고소작업" Value="08" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="chkSWWKCODE9" runat="server" ReadMode="false" onclick="UP_WKCODE_Click(9)" >
                                <asp:ListItem Text="인양(중장비사용)작업" Value="09" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="chkSWWKCODE10" runat="server" ReadMode="false" onclick="UP_WKCODE_Click(10)" >
                                <asp:ListItem Text="굴착작업" Value="10" ></asp:ListItem>
                            </Ctl:CheckBox>

                        </td>
                    </tr>
                </table>
            </div>

            <div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="80px" />
                        <col width="350px" />
                        <col width="80px" />
                        <col width="350px" />
                        <col width="80px" />
                        <col width="*" />
                        
                    </colgroup>

                    <tr>
                        <th style="text-align:left;" colspan ="6">
                            <Ctl:Text ID="Text3" runat="server" LangCode="lblSMWORKTITLE" Description="작업내용"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblSMREVTEAM" runat="server" Description="작업부서"></Ctl:Text>
                        </td>
                        <td style="text-align:left; ">
                            <Ctl:SearchView ID="svSMREVTEAM" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_GETDATA" Params="{'P_DATE':datSMWKORAPPDATE.GetValue() }" >
                                <Ctl:SearchViewField DataField="BUSEO"   TextField="BUSEO"   Description="부서"   Hidden="false" Width="70"  TextBox="true" runat="server" />
                                <Ctl:SearchViewField DataField="BUSEONM" TextField="BUSEONM" Description="부서명" Hidden="false" Width="110" TextBox="true" Default="true" runat="server" />
                            </Ctl:SearchView>
                        </td>
                        <td style="text-align:center;border-right:hidden">
                        </td>
                        <td style="text-align:center;border-right:hidden">
                        </td>
                        <td style="text-align:center;border-right:hidden">
                        </td>
                        <td style="text-align:center;">
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text7" runat="server" Description="공사팀"></Ctl:Text>
                        </td>

                        <td style="text-align:left; ">
                            <Ctl:Radio ID="rdoSMWKMETHOD" runat="server" DataMember="IDX" ReadMode="false" OnChanged="return true;">
                                <asp:ListItem Text="자체"     Value="1" Selected="true"></asp:ListItem>
                                <asp:ListItem Text="일용"     Value="2" ></asp:ListItem>
                                <asp:ListItem Text="협력업체" Value="3" ></asp:ListItem>
                            </Ctl:Radio>
                        </td>
                        <td style="text-align:center;">
                            <Ctl:Text ID="Text12" runat="server" Description="업체명"></Ctl:Text>
                        </td>

                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtSMSUBVEND"   runat="server" width ="150"></Ctl:TextBox>
                            <Ctl:Text ID="Text8"             runat="server" Description="(책임자&연락처:"></Ctl:Text>
                            <Ctl:TextBox ID="txtSMSUBPERSON" runat="server" width ="60"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtSMSUBTEL"    runat="server" width ="100"></Ctl:TextBox>
                            <Ctl:Text    ID="Text9"          runat="server" Description=")/"></Ctl:Text>
                            <Ctl:TextBox ID="txtSMWKMAN"     runat="server" width ="30"></Ctl:TextBox>
                            <Ctl:Text    ID="Text11"         runat="server" Description="명]"></Ctl:Text>
                        </td>

                    </tr>
                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblSMTADATE" runat="server" Description="작업일자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="datSMTADATE1"    runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px"></Ctl:TextBox>
			                <Ctl:TextBox ID="txtSMTATIME1_ST" runat="server" width ="25"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtSMTATIME1_ED" runat="server" width ="25"></Ctl:TextBox>
                            <Ctl:Text ID="lblWODSDATE2"       runat="server" LangCode="lblWODSDATE2" Description="~"></Ctl:Text>

                            <Ctl:TextBox ID="datSMTADATE2"    runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtSMTATIME2_ST" runat="server" width ="25"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtSMTATIME2_ED" runat="server" width ="25"></Ctl:TextBox>
                        </td>

                        <td style="text-align:center;">
                            <Ctl:Text ID="lblSMOTDATE1"       runat="server" Description="연장예정일"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="datSMOTDATE1"    runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px"></Ctl:TextBox>
			                <Ctl:TextBox ID="txtSMOTTIME1_ST" runat="server" width ="25"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtSMOTTIME1_ED" runat="server" width ="25"></Ctl:TextBox>
                            <Ctl:Text ID="lblSMOTDATE2"       runat="server" Description="~"></Ctl:Text>

                            <Ctl:TextBox ID="datSMOTDATE2"    runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtSMOTTIME2_ST" runat="server" width ="25"></Ctl:TextBox>
                            <Ctl:TextBox ID="txtSMOTTIME2_ED" runat="server" width ="25"></Ctl:TextBox>
                        </td>
                        <td style="text-align:center;">
                            <Ctl:Text ID="txtSMOTAPPSABUN"    runat="server" Description="연장허가자"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:SearchView ID="svSMOTAPPSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_EMPOYEE_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" Default="true" />
                                <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="70" TextBox="true" runat="server" />
                            </Ctl:SearchView>
                            <Ctl:Button ID="btnSMOT" runat="server" Style="Orange" Description="확인" OnClientClick="btnSMOT_Click();" ></Ctl:Button>
                        </td>

                    </tr>
                    <tr>
                        <td style="text-align:center;">
                            <Ctl:Text ID="lblSMFIREINS" runat="server" Description="화기감시자"></Ctl:Text>
                        </td>

                        <td style="text-align:left;" colspan ="5">
                            <Ctl:TextBox ID="txtSMFIREINS" runat="server" width ="150"></Ctl:TextBox>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="tab_sulby" style="padding-top:10px;">
                <ul class="tabnav_sulby">
                    <li><a id="tabli01_sulby" href="#tab01_sulby">설비코드</a></li>
                    <li><a id="tabli02_sulby" href="#tab02_sulby">작업내용</a></li>
                </ul>
                
                <div class="tabcontent_sulby";>
                    <div id="tab01_sulby">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="80px" />
                                <col width="280px" />
			                    <col width="80px" />
                                <col width="280px" />
                                <col width="80px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
				                <td style="text-align:center;">
				                    <Ctl:Text ID="Text18" runat="server" LangCode="lblSMSYSTEMCODE1" Description="설비코드1"></Ctl:Text>
				                </td>

				                <td style="text-align:left;">
				                    <Ctl:TextBox ID="txtSMSYSTEMCODE1" runat="server" Width ="80px"></Ctl:TextBox>
					                <img src="/Resources/Images/btn_search.gif" ID="btnSMSYSTEMCODE1" alt="연관설비1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('SMSYSTEMCODE1');"  />
				                    <Ctl:TextBox ID="pnlSMSYSTEMCODE1" runat="server" ReadOnly ="true" Width ="150px"></Ctl:TextBox>
				                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text19" runat="server" Description="연관설비1"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCONNCODE11" runat="server" ReadOnly ="true"></Ctl:TextBox>
				                    <Ctl:TextBox ID="pnlSMCONNCODE11" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text20" runat="server" Description="연관설비2"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCONNCODE12" runat="server" ReadOnly ="true"></Ctl:TextBox>
				                    <Ctl:TextBox ID="pnlSMCONNCODE12" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>

                            </tr>

                            <tr>
				                <td style="text-align:center;">
				                    <Ctl:Text ID="Text4" runat="server" LangCode="lblSMSYSTEMCODE2" Description="설비코드2"></Ctl:Text>
				                </td>

				                <td style="text-align:left;">
				                    <Ctl:TextBox ID="txtSMSYSTEMCODE2" runat="server" Width ="80px"></Ctl:TextBox>
					                <img src="/Resources/Images/btn_search.gif" ID="btnSMSYSTEMCODE2" alt="연관설비1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('SMSYSTEMCODE2');"  />
				                    <Ctl:TextBox ID="pnlSMSYSTEMCODE2" runat="server" ReadOnly ="true" Width ="150px"></Ctl:TextBox>
				                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text26" runat="server" Description="연관설비1"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCONNCODE21" runat="server" ReadOnly ="true"></Ctl:TextBox>
				                    <Ctl:TextBox ID="pnlSMCONNCODE21" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text27" runat="server" Description="연관설비2"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCONNCODE22" runat="server" ReadOnly ="true"></Ctl:TextBox>
				                    <Ctl:TextBox ID="pnlSMCONNCODE22" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>

                            </tr>

                            <tr>
				                <td style="text-align:center;">
				                    <Ctl:Text ID="Text28" runat="server" LangCode="lblSMSYSTEMCODE3" Description="설비코드3"></Ctl:Text>
				                </td>

				                <td style="text-align:left;">
				                    <Ctl:TextBox ID="txtSMSYSTEMCODE3" runat="server" Width ="80px"></Ctl:TextBox>
					                <img src="/Resources/Images/btn_search.gif" ID="btnSMSYSTEMCODE3" alt="연관설비1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('SMSYSTEMCODE3');"  />
				                    <Ctl:TextBox ID="pnlSMSYSTEMCODE3" runat="server" ReadOnly ="true" Width ="150px"></Ctl:TextBox>
				                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text29" runat="server" Description="연관설비1"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCONNCODE31" runat="server" ReadOnly ="true"></Ctl:TextBox>
				                    <Ctl:TextBox ID="pnlSMCONNCODE31" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text30" runat="server" Description="연관설비2"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCONNCODE32" runat="server" ReadOnly ="true"></Ctl:TextBox>
				                    <Ctl:TextBox ID="pnlSMCONNCODE32" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>

                            </tr>

                            <tr>
				                <td style="text-align:center;">
				                    <Ctl:Text ID="Text34" runat="server" LangCode="lblSMSYSTEMCODE4" Description="설비코드4"></Ctl:Text>
				                </td>

				                <td style="text-align:left;">
				                    <Ctl:TextBox ID="txtSMSYSTEMCODE4" runat="server" Width ="80px"></Ctl:TextBox>
					                <img src="/Resources/Images/btn_search.gif" ID="btnSMSYSTEMCODE4" alt="연관설비1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('SMSYSTEMCODE4');"  />
				                    <Ctl:TextBox ID="pnlSMSYSTEMCODE4" runat="server" ReadOnly ="true" Width ="150px"></Ctl:TextBox>
				                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text42" runat="server" Description="연관설비1"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCONNCODE41" runat="server" ReadOnly ="true"></Ctl:TextBox>
				                    <Ctl:TextBox ID="pnlSMCONNCODE41" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text43" runat="server" Description="연관설비2"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCONNCODE42" runat="server" ReadOnly ="true"></Ctl:TextBox>
				                    <Ctl:TextBox ID="pnlSMCONNCODE42" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>

                            </tr>

                            <tr>
				                <td style="text-align:center;">
				                    <Ctl:Text ID="Text44" runat="server" LangCode="lblSMSYSTEMCODE5" Description="설비코드5"></Ctl:Text>
				                </td>

				                <td style="text-align:left;">
				                    <Ctl:TextBox ID="txtSMSYSTEMCODE5" runat="server" Width ="80px"></Ctl:TextBox>
					                <img src="/Resources/Images/btn_search.gif" ID="btnSMSYSTEMCODE5" alt="연관설비1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('SMSYSTEMCODE5');"  />
				                    <Ctl:TextBox ID="pnlSMSYSTEMCODE5" runat="server" ReadOnly ="true" Width ="150px"></Ctl:TextBox>
				                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text45" runat="server" Description="연관설비1"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCONNCODE51" runat="server" ReadOnly ="true"></Ctl:TextBox>
				                    <Ctl:TextBox ID="pnlSMCONNCODE51" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text46" runat="server" Description="연관설비2"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCONNCODE52" runat="server" ReadOnly ="true"></Ctl:TextBox>
				                    <Ctl:TextBox ID="pnlSMCONNCODE52" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>

                            </tr>

                        </table>		                
                    </div>

                    <div id="tab02_sulby">
		                <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="80px" />
                                <col width="370px" />
			                    <col width="100px" />
                                <col width="*" />
                            </colgroup>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblSMAREACODE1" runat="server" Description="작업구역1"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMAREACODE1" runat="server" Width ="80px"></Ctl:TextBox>
                                    <img src="/Resources/Images/btn_search.gif" ID="btnSMAREACODE1" alt="작업구역1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('SMAREACODE1');"  />
			                        <Ctl:TextBox ID="pnlSMAREACODE1" runat="server" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			                    </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text21" runat="server" Description="내용"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMAREATEXT1" runat="server" width ="600"></Ctl:TextBox>
                                </td>

                            </tr>
                            
                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblSMAREACODE2" runat="server" Description="작업구역2"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMAREACODE2" runat="server" Width ="80px"></Ctl:TextBox>
                                    <img src="/Resources/Images/btn_search.gif" ID="btnSMAREACODE2" alt="작업구역2조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('SMAREACODE2');"  />
			                        <Ctl:TextBox ID="pnlSMAREACODE2" runat="server" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			                    </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text23" runat="server" Description="내용"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMAREATEXT2" runat="server" width ="600"></Ctl:TextBox>
                                </td>

                            </tr>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblSMAREACODE3" runat="server" Description="작업구역3"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMAREACODE3" runat="server" Width ="80px"></Ctl:TextBox>
                                    <img src="/Resources/Images/btn_search.gif" ID="btnSMAREACODE3" alt="작업구역3조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('SMAREACODE3');"  />
			                        <Ctl:TextBox ID="pnlSMAREACODE3" runat="server" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			                    </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text24" runat="server" Description="내용"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMAREATEXT3" runat="server" width ="600"></Ctl:TextBox>
                                </td>

                            </tr>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblSMAREACODE4" runat="server" Description="작업구역4"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMAREACODE4" runat="server" Width ="80px"></Ctl:TextBox>
                                    <img src="/Resources/Images/btn_search.gif" ID="btnSMAREACODE4" alt="작업구역4조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('SMAREACODE4');"  />
			                        <Ctl:TextBox ID="pnlSMAREACODE4" runat="server" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			                    </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text25" runat="server" Description="내용"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMAREATEXT4" runat="server" width ="600"></Ctl:TextBox>
                                </td>

                            </tr>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblSMAREACODE5" runat="server" Description="작업구역5"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMAREACODE5" runat="server" Width ="80px"></Ctl:TextBox>
                                    <img src="/Resources/Images/btn_search.gif" ID="btnSMAREACODE5" alt="작업구역5조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('SMAREACODE5');"  />
			                        <Ctl:TextBox ID="pnlSMAREACODE5" runat="server" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
			                    </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text47" runat="server" Description="내용"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMAREATEXT5" runat="server" width ="600"></Ctl:TextBox>
                                </td>

                            </tr>

                        </table>
                    </div>
                    
                </div>
            </div>

            <div class="btn_bx" style="padding-top:10px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="70px" />
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;">
                            <Ctl:Text ID="lblSMMATERTEXT2" runat="server" Description="내용물질"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:left;" colspan="2">
                            <Ctl:TextBox ID="txtSMMATERTEXT2" runat="server" SetType="Text" TextMode ="MultiLine" Validation ="false" Height ="100" Width ="1150px"></Ctl:TextBox>
                        </td>
                    </tr>
                </table>
            </div>




            <div class="btn_bx" style="padding-top:5px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="70px" />
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;">
                            <Ctl:Text ID="Text48" runat="server" Description="안전관련"></Ctl:Text>
                        </th>
                    </tr>
                    <tr>
                        <th style="text-align:left;">
                            <Ctl:Text ID="Text49" runat="server" Description="이 작업에 관한 위험 및 유의사항"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:left;">

                            <Ctl:CheckBox ID="ChkSMNOTE_BURN" runat="server" ReadMode="false" >
                                <asp:ListItem Text="화상" Value="" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="ChkSMNOTE_SUFF" runat="server" ReadMode="false" >
                                <asp:ListItem Text="질식" Value="" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="ChkSMNOTE_ELE" runat="server" ReadMode="false" >
                                <asp:ListItem Text="감전" Value="" ></asp:ListItem>
                            </Ctl:CheckBox>

                            <Ctl:CheckBox ID="ChkSMNOTE_FIR" runat="server" ReadMode="false" >
                                <asp:ListItem Text="화재" Value="" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="ChkSMNOTE_EXP" runat="server" ReadMode="false" >
                                <asp:ListItem Text="폭발" Value="" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="ChkSMNOTE_DROP" runat="server" ReadMode="false" >
                                <asp:ListItem Text="추락" Value="" ></asp:ListItem>
                            </Ctl:CheckBox>

                            <Ctl:CheckBox ID="ChkSMNOTE_LEAK" runat="server" ReadMode="false" >
                                <asp:ListItem Text="화학물질 누출" Value="" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="ChkSMNOTE_NARR" runat="server" ReadMode="false" >
                                <asp:ListItem Text="협착" Value="" ></asp:ListItem>
                            </Ctl:CheckBox>
                            <Ctl:CheckBox ID="ChkSMNOTE_COLL" runat="server" ReadMode="false" >
                                <asp:ListItem Text="충돌" Value="" ></asp:ListItem>
                            </Ctl:CheckBox>
                        </td>
                    </tr>
                </table>
            </div>
           
            <div class="tab_safe" style="padding-top:5px;">
                <ul class="tabnav_safe">
                    <li id ="li01_safe"><a id="tabli01_safe" href="#tab01_safe">일반위험작업</a></li>
                    <li id ="li02_safe"><a id="tabli02_safe" href="#tab02_safe">열간(화기)작업</a></li>
                    <li id ="li03_safe"><a id="tabli03_safe" href="#tab03_safe">밀폐공간출입작업</a></li>
                    <li id ="li04_safe"><a id="tabli04_safe" href="#tab04_safe">전기(정전)작업</a></li>
                    <li id ="li05_safe"><a id="tabli05_safe" href="#tab05_safe">방사선사용작업</a></li>
                    <li id ="li06_safe"><a id="tabli06_safe" href="#tab06_safe">고소작업</a></li>
                    <li id ="li07_safe"><a id="tabli07_safe" href="#tab07_safe">중장비사용작업</a></li>
                    <li id ="li08_safe"><a id="tabli08_safe" href="#tab08_safe">굴착작업</a></li>
                    <li id ="li09_safe"><a id="tabli09_safe" href="#tab09_safe">안전보호구</a></li>

                </ul>

                <div class="tabcontent_safe";>
                    <div id="tab01_safe">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="420px" />
                                <col width="30px" />
			                    <col width="30px" />
                                <col width="30px" />
				                <col width="420px" />
                                <col width="30px" />
            			        <col width="30px" />
                                <col width="30px" />
                            </colgroup>
                            <tr>
                                <th style="text-align:left;" colspan="8">
                                    <Ctl:Text ID="Text50" runat="server" Description="안전/환경조치요구사항(요청-신청자, 승인-허가자, 확인-현장안전감독자[허가자 지정])"></Ctl:Text>
                                </th>
                            </tr>
                            <tr style="height:25px;background: #E1E1E1;">
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl101" runat = "server" Text = "작업구역 설정(출입경고 표지)"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk101_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk101_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk101_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl109" runat = "server" Text = "불황성가스 치환 및 환기"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk109_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk109_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk109_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl102" runat = "server" Text = "가스 농도 측정"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk102_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk102_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk102_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl110" runat = "server" Text = "정전/잠금/표지부착"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk110_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk110_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk110_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl103" runat = "server" Text = "분진 농도 측정"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk103_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk103_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk103_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl111" runat = "server" Text = "환기장비"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk111_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk111_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk111_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl104" runat = "server" Text = "밸브차단 및 차단표지부착"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk104_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk104_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk104_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl112" runat = "server" Text = "조명장비"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk112_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk112_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
                                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk112_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl105" runat = "server" Text = "맹판설치 및 표지부착"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk105_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk105_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk105_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl113" runat = "server" Text = "소 화 기"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk113_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk113_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk113_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl106" runat = "server" Text = "용기개방 및 압력방출"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk106_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk106_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk106_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl114" runat = "server" Text = "안전장구"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk114_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk114_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk114_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl107" runat = "server" Text = "위험물질방출 및 처리"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk107_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk107_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk107_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl115" runat = "server" Text = "안전교육"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk115_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk115_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk115_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl108" runat = "server" Text = "용기내부 세정 및 처리"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk108_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk108_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk108_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl116" runat = "server" Text = "운전요원의 입회"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk116_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk116_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk116_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                        </table>
                    </div>
                
                    <div id="tab02_safe">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="420px" />
                                <col width="30px" />
			                    <col width="30px" />
                                <col width="30px" />
				                <col width="420px" />
                                <col width="30px" />
            			        <col width="30px" />
                                <col width="30px" />
                            </colgroup>
                            <tr>
                                <th style="text-align:left;" colspan="8">
                                    <Ctl:Text ID="Text51" runat="server" Description="안전/환경조치요구사항(요청-신청자, 승인-허가자, 확인-현장안전감독자[허가자 지정])"></Ctl:Text>
                                </th>
                            </tr>
                            <tr style="height:25px;background: #E1E1E1;">
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl201" runat = "server" Text = "작업구역 설정(출입경고 표지)"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk201_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk201_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk201_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl210" runat = "server" Text = "비산불티차단막 설치"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk210_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk210_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk210_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl202" runat = "server" Text = "가스 농도 측정"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk202_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk202_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk202_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl211" runat = "server" Text = "정전/잠금/표지부착"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk211_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk211_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk211_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl203" runat = "server" Text = "분진 농도 측정"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk203_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk203_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk203_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl212" runat = "server" Text = "환기장비"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk212_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk212_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk212_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl204" runat = "server" Text = "밸브차단 및 차단표지부착"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk204_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk204_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk204_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl213" runat = "server" Text = "조명장비"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk213_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk213_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk213_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl205" runat = "server" Text = "맹판설치 및 표지부착"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk205_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk205_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk205_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl214" runat = "server" Text = "소 화 기"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk214_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk214_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk214_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl206" runat = "server" Text = "용기개방 및 압력방출"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk206_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk206_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk206_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl215" runat = "server" Text = "안전장구"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk215_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk215_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk215_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl207" runat = "server" Text = "위험물질방출 및 처리"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk207_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk207_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk207_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl216" runat = "server" Text = "안전교육"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk216_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk216_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk216_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl208" runat = "server" Text = "용기내부 세정 및 처리"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk208_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk208_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk208_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl217" runat = "server" Text = "운전요원의 입회"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk217_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk217_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk217_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

				            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl209" runat = "server" Text = "불황성가스 치환 및 환기"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk209_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk209_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk209_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl218" runat = "server" Text = "주변지역 가연성/인화성 물질 확인 및 제거,차단"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk218_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk218_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk218_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                        </table>
                    </div>

                    
                    
                    <div id="tab03_safe">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="420px" />
                                <col width="30px" />
			                    <col width="30px" />
                                <col width="30px" />
				                <col width="420px" />
                                <col width="30px" />
            			        <col width="30px" />
                                <col width="30px" />
                            </colgroup>
                            <tr>
                                <th style="text-align:left;" colspan="8">
                                    <Ctl:Text ID="Text52" runat="server" Description="안전/환경조치요구사항(요청-신청자, 승인-허가자, 확인-현장안전감독자[허가자 지정])"></Ctl:Text>
                                </th>
                            </tr>
                            <tr style="height:25px;background: #E1E1E1;">
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl301" runat = "server" Text = "밸브차단 및 차단표식부착"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk301_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk301_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk301_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl309" runat = "server" Text = "정전/잠금/표지부착"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk308_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk308_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk308_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl302" runat = "server" Text = "가스 농도 측정"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk302_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk302_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk302_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="Label1" runat = "server" Text = "환기장비"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk309_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk309_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk309_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl303" runat = "server" Text = "산소 농도 측정"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk303_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk303_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk303_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl310" runat = "server" Text = "조명장비"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk310_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk310_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk310_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl304" runat = "server" Text = "분진 농도 측정"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk304_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk304_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk304_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl311" runat = "server" Text = "소 화 기"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk311_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk311_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk311_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl305" runat = "server" Text = "맹판설치 및 표지부착"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk305_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk305_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk305_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl312" runat = "server" Text = "안전장구(구명선 등)"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk312_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk312_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk312_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl306" runat = "server" Text = "압력방출"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk306_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk306_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk306_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl313" runat = "server" Text = "안전교육"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk313_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk313_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk313_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl307" runat = "server" Text = "용기세척 후 공기/물 치환 및 환기"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk307_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk307_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk307_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl314" runat = "server" Text = "운전요원의 입회"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk314_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk314_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk314_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>                         

                        </table>
                    </div>



                    <div id="tab04_safe">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="420px" />
                                <col width="30px" />
			                    <col width="30px" />
                                <col width="30px" />
				                <col width="420px" />
                                <col width="30px" />
            			        <col width="30px" />
                                <col width="30px" />
                            </colgroup>
                            <tr>
                                <th style="text-align:left;" colspan="8">
                                    <Ctl:Text ID="Text53" runat="server" Description="안전/환경조치요구사항(요청-신청자, 승인-허가자, 확인-현장안전감독자[허가자 지정])"></Ctl:Text>
                                </th>
                            </tr>
                            <tr style="height:25px;background: #E1E1E1;">
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl401" runat = "server" Text = "[제어반]"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk401_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk401_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk401_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl407" runat = "server" Text = "[현장기기]"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk407_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk407_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk407_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl402" runat = "server" Text = "주 차단 스위치 내림"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk402_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk402_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk402_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl408" runat = "server" Text = "현장스위치 내림"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk408_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk408_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk408_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl403" runat = "server" Text = "제어차단기 내림"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk403_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk403_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk403_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl409" runat = "server" Text = "차단표지판 부착"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk409_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk409_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk409_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl404" runat = "server" Text = "분진 농도 측정"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk404_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk404_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk404_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"></td>
				                <td style="width:30px;text-align:right;"></td>
				                <td style="width:30px;text-align:right;"></td>
				                <td style="width:30px;text-align:right;"></td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl405" runat = "server" Text = "시험전원 차단"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk405_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk405_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk405_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"></td>
				                <td style="width:30px;text-align:right;"></td>
				                <td style="width:30px;text-align:right;"></td>
				                <td style="width:30px;text-align:right;"></td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl406" runat = "server" Text = "차단표지판 부착"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk406_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk406_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk406_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"></td>
				                <td style="width:30px;text-align:right;"></td>
				                <td style="width:30px;text-align:right;"></td>
				                <td style="width:30px;text-align:right;"></td>
				            </tr>

                                                   

                        </table>
                    </div>



                    <div id="tab05_safe">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="420px" />
                                <col width="30px" />
			                    <col width="30px" />
                                <col width="30px" />
				                <col width="420px" />
                                <col width="30px" />
            			        <col width="30px" />
                                <col width="30px" />
                            </colgroup>

                            <tr>
                                <th style="text-align:left;" colspan="8">
                                    <Ctl:Text ID="Text54" runat="server" Description="안전/환경조치요구사항(요청-신청자, 승인-허가자, 확인-현장안전감독자[허가자 지정])"></Ctl:Text>
                                </th>
                            </tr>
                            <tr style="height:25px;background: #E1E1E1;">
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl501" runat = "server" Text = "작업구역에 차단선 설치"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk501_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk501_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk501_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl503" runat = "server" Text = "방사선 위험표지"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk503_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk503_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk503_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl502" runat = "server" Text = "제한구역의 비인가자 출입제한"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk502_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk502_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk502_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl504" runat = "server" Text = "경고 등(전멸등)"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk504_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk504_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk504_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                        </table>
                    </div>



                    <div id="tab06_safe">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="420px" />
                                <col width="30px" />
			                    <col width="30px" />
                                <col width="30px" />
				                <col width="420px" />
                                <col width="30px" />
            			        <col width="30px" />
                                <col width="30px" />
                            </colgroup>

                            <tr>
                                <th style="text-align:left;" colspan="8">
                                    <Ctl:Text ID="Text55" runat="server" Description="안전/환경조치요구사항(요청-신청자, 승인-허가자, 확인-현장안전감독자[허가자 지정])"></Ctl:Text>
                                </th>
                            </tr>

                            <tr style="height:25px;background: #E1E1E1;">
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl601" runat = "server" Text = "작업에 적합한 작업발판 및 안전난간설치 여부"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk601_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk601_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk601_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl603" runat = "server" Text = "추락 방지용 방망 설치 여부"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk603_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk603_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk603_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl602" runat = "server" Text = "안전대 착용 및 부착 여부"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk602_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk602_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk602_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"></td>
				                <td style="width:30px;text-align:right;"></td>
				                <td style="width:30px;text-align:right;"></td>
				                <td style="width:30px;text-align:right;"></td>
				            </tr>

                        </table>
                    </div>



                    <div id="tab07_safe">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="420px" />
                                <col width="30px" />
			                    <col width="30px" />
                                <col width="30px" />
				                <col width="420px" />
                                <col width="30px" />
            			        <col width="30px" />
                                <col width="30px" />
                            </colgroup>

                            <tr>
                                <th style="text-align:left;" colspan="8">
                                    <Ctl:Text ID="Text56" runat="server" Description="안전/환경조치요구사항(요청-신청자, 승인-허가자, 확인-현장안전감독자[허가자 지정])"></Ctl:Text>
                                </th>
                            </tr>

                            <tr style="height:25px;background: #E1E1E1;">
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl701" runat = "server" Text = "기상상태"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk701_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk701_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk701_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl705" runat = "server" Text = "전원설비 간섭여부"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk705_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk705_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk705_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl702" runat = "server" Text = "신호수배치"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk702_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk702_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk702_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl706" runat = "server" Text = "매트 등 부속장구"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk706_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk706_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk706_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl703" runat = "server" Text = "조명설비"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk703_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk703_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk703_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl707" runat = "server" Text = "노면상태"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk707_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk707_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk707_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl704" runat = "server" Text = "통행금지 표지판 부착"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk704_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk704_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk704_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl708" runat = "server" Text = "중장비 명허증/검사증 확인"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk708_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk708_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk708_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>


                        </table>
                    </div>



                    <div id="tab08_safe">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="380px" />
                                <col width="30px" />
			                    <col width="30px" />
                                <col width="30px" />
				                <col width="150px" />
                                <col width="120px" />
            			        <col width="120px" />
                                <col width="150px" />
                            </colgroup>

                            <tr>
                                <th style="text-align:left;" colspan="8">
                                    <Ctl:Text ID="Text57" runat="server" Description="안전/환경조치요구사항(요청-신청자, 승인-허가자, 확인-현장안전감독자[허가자 지정])"></Ctl:Text>
                                </th>
                            </tr>

                            <tr style="height:25px;background: #E1E1E1;">
                                <th style=" text-align:center; font-weight:bold; width:380px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">Yes</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">No</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">NA</th>
                                <th style=" text-align:center; font-weight:bold; width:150px;">종류</th>
                                <th style=" text-align:center; font-weight:bold; width:120px;">규격</th>
                                <th style=" text-align:center; font-weight:bold; width:120px;">깊이</th>
                                <th style=" text-align:center; font-weight:bold; width:150px;">확인자</th>
                            </tr>

                            <tr style="height:20px">
                                <td style="width:380px"><asp:Label ID ="lbl801" runat = "server" Text = "기계배관 관련 확인 사항 : 지하배관 유무"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk801_DRYESSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk801_DRNOSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk801_DRNASEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:150px">
							        <Ctl:TextBox ID="txt801_Kind" runat="server" Width ="150px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:TextBox ID="txt801_Std" runat="server" Width ="120px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:TextBox ID="txt801_Depth" runat="server" Width ="120px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:SearchView ID="sv801_Sabun" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="70" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
						        </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:380px"><asp:Label ID ="lbl802" runat = "server" Text = "소방관련 확인사항 : 소방배관 및 배출구 유무"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk802_DRYESSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk802_DRNOSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk802_DRNASEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:150px">
							        <Ctl:TextBox ID="txt802_Kind" runat="server" Width ="150px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:TextBox ID="txt802_Std" runat="server" Width ="120px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:TextBox ID="txt802_Depth" runat="server" Width ="120px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:SearchView ID="sv802_Sabun" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="70" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
						        </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:380px"><asp:Label ID ="lbl803" runat = "server" Text = "전기관련 확인사항 : 전기동력선 유무"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk803_DRYESSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk803_DRNOSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk803_DRNASEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:150px">
							        <Ctl:TextBox ID="txt803_Kind" runat="server" Width ="150px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:TextBox ID="txt803_Std" runat="server" Width ="120px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:TextBox ID="txt803_Depth" runat="server" Width ="120px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:SearchView ID="sv803_Sabun" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="70" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
						        </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:380px"><asp:Label ID ="lbl804" runat = "server" Text = "계장관련 확인사항 : 제어용 케이블 유무"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk804_DRYESSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk804_DRNOSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk804_DRNASEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:150px">
							        <Ctl:TextBox ID="txt804_Kind" runat="server" Width ="150px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:TextBox ID="txt804_Std" runat="server" Width ="120px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:TextBox ID="txt804_Depth" runat="server" Width ="120px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:SearchView ID="sv804_Sabun" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="70" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
						        </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:380px"><asp:Label ID ="lbl805" runat = "server" Text = "기타관련 확인사항 : 전화선 및 접지선 유무"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk805_DRYESSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk805_DRNOSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk805_DRNASEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:150px">
							        <Ctl:TextBox ID="txt805_Kind" runat="server" Width ="150px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:TextBox ID="txt805_Std" runat="server" Width ="120px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:TextBox ID="txt805_Depth" runat="server" Width ="120px"></Ctl:TextBox>
						        </td>

						        <td style="width:120px">
							        <Ctl:SearchView ID="sv805_Sabun" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="70" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="70" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
						        </td>
				            </tr>

                        </table>
                    </div>



                    <div id="tab09_safe">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="420px" />
                                <col width="30px" />
			                    <col width="30px" />
                                <col width="30px" />
				                <col width="420px" />
                                <col width="30px" />
            			        <col width="30px" />
                                <col width="30px" />
                            </colgroup>

                            <tr>
                                <th style="text-align:left;" colspan="8">
                                    <Ctl:Text ID="Text58" runat="server" Description="안전/환경조치요구사항(요청-신청자, 승인-허가자, 확인-현장안전감독자[허가자 지정])"></Ctl:Text>
                                </th>
                            </tr>

                            <tr style="height:25px;background: #E1E1E1;">
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                                <th style=" text-align:center; font-weight:bold; width:420px;"></th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">발행</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">검토</th>
                                <th style=" text-align:center; font-weight:bold; width:30px;">확인</th>
                            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl901" runat = "server" Text = "안 전 모"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk901_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk901_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk901_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl909" runat = "server" Text = "안전장화"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk909_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk909_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk909_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl902" runat = "server" Text = "안 전 화"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk902_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk902_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk902_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl910" runat = "server" Text = "오염방지복"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk910_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk910_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk910_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl903" runat = "server" Text = "고글.보안경"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk903_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk903_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk903_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl911" runat = "server" Text = "화 학 복"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk911_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk911_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk911_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl904" runat = "server" Text = "방진마스크"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk904_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk904_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk904_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl912" runat = "server" Text = "안전그네"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk912_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk912_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk912_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl905" runat = "server" Text = "방독마스크"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk905_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk905_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk905_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl913" runat = "server" Text = "방폭조명등"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk913_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk913_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk913_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl906" runat = "server" Text = "송기마스크"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk906_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk906_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk906_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl914" runat = "server" Text = "비상용호각"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk914_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk914_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk914_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl907" runat = "server" Text = "공기호흡기"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk907_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk907_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk907_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl915" runat = "server" Text = "방폭무전기"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk915_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk915_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk915_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                            <tr style="height:20px">
                                <td style="width:420px"><asp:Label ID ="lbl908" runat = "server" Text = "내화학장갑"></asp:Label></td>
				                <td style="width:30px;text-align:right;" >
					                <Ctl:CheckBox ID="Chk908_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk908_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk908_SSFIXSEL" runat="server" ReadMode="false">
                                            <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				                <td style="width:420px"><asp:Label ID ="lbl916" runat = "server" Text = "구명줄"></asp:Label></td>

				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk916_SSPUBSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
					                <Ctl:CheckBox ID="Chk916_SSREVSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
					                </Ctl:CheckBox>
				                </td>
				                <td style="width:30px;text-align:right;">
				   	                <Ctl:CheckBox ID="Chk916_SSFIXSEL" runat="server" ReadMode="false">
                                        <asp:ListItem Text="" ></asp:ListItem>
				   	                </Ctl:CheckBox>
				                </td>
				            </tr>

                        </table>
                    </div>
                </div>
            </div>


            <div class="tab_inspect" style="padding-top:10px;">
                <ul class="tabnav_inspect">
                    <li><a id="tabli01_inspect" href="#tab01_inspect">점검 - 현장안전감독자</a></li>
                    <li><a id="tabli02_inspect" href="#tab02_inspect">점검 - 안전환경팀</a></li>
                </ul>
                
                <div class="tabcontent_inspect";>
                    <div id="tab01_inspect">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="100px" />
                                <col width="130px" />
			                    <col width="130px" />
                                <col width="130px" />
                                <col width="130px" />
                                <col width="130px" />
                                <col width="130px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text85" runat="server" Description="시간"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text86" runat="server" Description="산소(%)"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text87" runat="server" Description="가연성"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text88" runat="server" Description="독성"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text89" runat="server" Description="CO2"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text90" runat="server" Description="CO"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text91" runat="server" Description="H2S"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text92" runat="server" Description="점검자"></Ctl:Text>
                                    <Ctl:Button ID="btnGas1" runat="server" Style="Orange" Description="확인" OnClientClick="btnGas_Click('1');" ></Ctl:Button>
                                </th>
                            </tr>
                            <tr>
                                <%-- 시간 --%>
				                <td style="text-align:center;">
				                    <Ctl:TextBox ID="txtSMCHKTIME1_HH" runat="server" Width ="30px"></Ctl:TextBox>
					                <Ctl:Text ID="Text93" runat="server" Description=":"></Ctl:Text>
				                    <Ctl:TextBox ID="txtSMCHKTIME1_MM" runat="server" Width ="30px"></Ctl:TextBox>
				                </td>

                                <%-- 산소 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKOXYGEN1" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKOXYGENUNIT1" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 가연성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM1" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT1" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 독성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM1DS" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT1DS" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO2 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM1CO2" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT1CO2" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM1CO" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT1CO" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- H2S --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM1H2S" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT1H2S" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 점검자 --%>
                                <td style="text-align:center;">
                                    <Ctl:SearchView ID="svSMCHKSABUN1" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_EMPOYEE_LIST" Params="">
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                </td>
                            </tr>

                            <tr>
                                <%-- 시간 --%>
				                <td style="text-align:center;">
				                    <Ctl:TextBox ID="txtSMCHKTIME2_HH" runat="server" Width ="30px"></Ctl:TextBox>
					                <Ctl:Text ID="Text60" runat="server" Description=":"></Ctl:Text>
				                    <Ctl:TextBox ID="txtSMCHKTIME2_MM" runat="server" Width ="30px"></Ctl:TextBox>
				                </td>

                                <%-- 산소 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKOXYGEN2" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKOXYGENUNIT2" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 가연성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM2" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT2" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 독성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM2DS" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT2DS" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO2 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM2CO2" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT2CO2" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM2CO" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT2CO" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- H2S --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM2H2S" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT2H2S" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 점검자 --%>
                                <td style="text-align:center;">
                                    <Ctl:SearchView ID="svSMCHKSABUN2" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_EMPOYEE_LIST" Params="">
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                </td>
                            </tr>


                            <tr>
                                <%-- 시간 --%>
				                <td style="text-align:center;">
				                    <Ctl:TextBox ID="txtSMCHKTIME3_HH" runat="server" Width ="30px"></Ctl:TextBox>
					                <Ctl:Text ID="Text61" runat="server" Description=":"></Ctl:Text>
				                    <Ctl:TextBox ID="txtSMCHKTIME3_MM" runat="server" Width ="30px"></Ctl:TextBox>
				                </td>

                                <%-- 산소 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKOXYGEN3" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKOXYGENUNIT3" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 가연성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM3" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT3" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 독성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM3DS" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT3DS" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO2 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM3CO2" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT3CO2" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM3CO" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT3CO" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- H2S --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM3H2S" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT3H2S" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 점검자 --%>
                                <td style="text-align:center;">
                                    <Ctl:SearchView ID="svSMCHKSABUN3" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_EMPOYEE_LIST" Params="">
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                </td>

                            </tr>

                            <tr>
                                <%-- 시간 --%>
				                <td style="text-align:center;">
				                    <Ctl:TextBox ID="txtSMCHKTIME4_HH" runat="server" Width ="30px"></Ctl:TextBox>
					                <Ctl:Text ID="Text62" runat="server" Description=":"></Ctl:Text>
				                    <Ctl:TextBox ID="txtSMCHKTIME4_MM" runat="server" Width ="30px"></Ctl:TextBox>
				                </td>

                                <%-- 산소 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKOXYGEN4" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKOXYGENUNIT4" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 가연성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM4" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT4" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 독성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM4DS" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT4DS" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO2 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM4CO2" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT4CO2" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM4CO" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT4CO" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- H2S --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM4H2S" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT4H2S" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 점검자 --%>
                                <td style="text-align:center;">
                                    <Ctl:SearchView ID="svSMCHKSABUN4" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_EMPOYEE_LIST" Params="">
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                </td>

                            </tr>

                        </table>
                    </div>

                    <div id="tab02_inspect">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="100px" />
                                <col width="130px" />
			                    <col width="130px" />
                                <col width="130px" />
                                <col width="130px" />
                                <col width="130px" />
                                <col width="130px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text17" runat="server" Description="시간"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text59" runat="server" Description="산소(%)"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text63" runat="server" Description="가연성"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text64" runat="server" Description="독성"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text65" runat="server" Description="CO2"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text66" runat="server" Description="CO"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text67" runat="server" Description="H2S"></Ctl:Text>
                                </th>
                                <th style="text-align:center;" >
                                    <Ctl:Text ID="Text68" runat="server" Description="점검자"></Ctl:Text>
                                    <Ctl:Button ID="btnGas2" runat="server" Style="Orange" Description="확인" OnClientClick="btnGas_Click('2');" ></Ctl:Button>
                                </th>
                            </tr>

                            <tr>
                                <%-- 시간 --%>
				                <td style="text-align:center;">
				                    <Ctl:TextBox ID="txtSMCHKTIME5_HH" runat="server" Width ="30px"></Ctl:TextBox>
					                <Ctl:Text ID="Text71" runat="server" Description=":"></Ctl:Text>
				                    <Ctl:TextBox ID="txtSMCHKTIME5_MM" runat="server" Width ="30px"></Ctl:TextBox>
				                </td>

                                <%-- 산소 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKOXYGEN5" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKOXYGENUNIT5" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 가연성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM5" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT5" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 독성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM5DS" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT5DS" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO2 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM5CO2" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT5CO2" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM5CO" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT5CO" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- H2S --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM5H2S" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT5H2S" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 점검자 --%>
                                <td style="text-align:center;">
                                    <Ctl:SearchView ID="svSMCHKSABUN5" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_SAFE_KBSABUN_LIST" Params="{'GRPID':'SAFE_MAG'}" PagingSize="10" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                </td>
                            </tr>



                            <tr>
                                <%-- 시간 --%>
				                <td style="text-align:center;">
				                    <Ctl:TextBox ID="txtSMCHKTIME6_HH" runat="server" Width ="30px"></Ctl:TextBox>
					                <Ctl:Text ID="Text72" runat="server" Description=":"></Ctl:Text>
				                    <Ctl:TextBox ID="txtSMCHKTIME6_MM" runat="server" Width ="30px"></Ctl:TextBox>
				                </td>

                                <%-- 산소 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKOXYGEN6" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKOXYGENUNIT6" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 가연성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM6" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT6" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 독성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM6DS" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT6DS" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO2 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM6CO2" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT6CO2" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM6CO" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT6CO" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- H2S --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM6H2S" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT6H2S" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 점검자 --%>
                                <td style="text-align:center;">
                                    <Ctl:SearchView ID="svSMCHKSABUN6" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_SAFE_KBSABUN_LIST" Params="{'GRPID':'SAFE_MAG'}" PagingSize="10" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                </td>
                            </tr>


                            <tr>
                                <%-- 시간 --%>
				                <td style="text-align:center;">
				                    <Ctl:TextBox ID="txtSMCHKTIME7_HH" runat="server" Width ="30px"></Ctl:TextBox>
					                <Ctl:Text ID="Text73" runat="server" Description=":"></Ctl:Text>
				                    <Ctl:TextBox ID="txtSMCHKTIME7_MM" runat="server" Width ="30px"></Ctl:TextBox>
				                </td>

                                <%-- 산소 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKOXYGEN7" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKOXYGENUNIT7" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 가연성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM7" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT7" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 독성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM7DS" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT7DS" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO2 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM7CO2" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT7CO2" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM7CO" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT7CO" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- H2S --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM7H2S" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT7H2S" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 점검자 --%>
                                <td style="text-align:center;">
                                    <Ctl:SearchView ID="svSMCHKSABUN7" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_SAFE_KBSABUN_LIST" Params="{'GRPID':'SAFE_MAG'}" PagingSize="10" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                </td>

                            </tr>

                            <tr>
                                <%-- 시간 --%>
				                <td style="text-align:center;">
				                    <Ctl:TextBox ID="txtSMCHKTIME8_HH" runat="server" Width ="30px"></Ctl:TextBox>
					                <Ctl:Text ID="Text74" runat="server" Description=":"></Ctl:Text>
				                    <Ctl:TextBox ID="txtSMCHKTIME8_MM" runat="server" Width ="30px"></Ctl:TextBox>
				                </td>

                                <%-- 산소 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKOXYGEN8" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKOXYGENUNIT8" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 가연성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM8" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT8" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 독성 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM8DS" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT8DS" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO2 --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM8CO2" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT8CO2" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" Selected="True" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- CO --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM8CO" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT8CO" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- H2S --%>
                                <td style="text-align:center;">
                                    <Ctl:TextBox ID="txtSMCHKTOXNUM8H2S" runat="server" Width ="45px"></Ctl:TextBox>
                                    <Ctl:Combo ID="cboSMCHKTOXUNIT8H2S" Width="60px" runat="server">
                                        <asp:ListItem Text="%"     Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="ppm"   Value="2" Selected="True" ></asp:ListItem>
                                    </Ctl:Combo>
                                </td>

                                <%-- 점검자 --%>
                                <td style="text-align:center;">
                                    <Ctl:SearchView ID="svSMCHKSABUN8" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_SAFE_KBSABUN_LIST" Params="{'GRPID':'SAFE_MAG'}" PagingSize="10" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                </td>

                            </tr>

                        </table>
                    </div>
                </div>
            </div>


            <div class="tab_verify" style="padding-top:10px;">
                <ul class="tabnav_verify">
                    <li><a id="tabli01_verify" href="#tab01_verify">안전환경팀 확인</a></li>
                    <li><a id="tabli02_verify" href="#tab02_verify">운영팀 확인</a></li>
                </ul>
                
                <div class="tabcontent_verify";>
                    <div id="tab01_verify">
                        <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="100px" />
                                <col width="250px" />
			                    <col width="100px" />
                                <col width="150px" />
                                <col width="120px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblSMSMSABUN" runat="server" Description="사번"></Ctl:Text>
                                </td>

                                <td style="text-align:left;">
                                    <Ctl:SearchView ID="svSMSMSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_SAFE_KBSABUN_LIST" Params="{'GRPID':'SAFE_MAG'}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                    <Ctl:Button ID="btnSafe" runat="server" Style="Orange" Description="확인" Hidden ="true"   OnClientClick="btnSAFE_Click();" ></Ctl:Button>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text36" runat="server" Description="확인일자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMSMAPPDATE" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text37" runat="server" Description="확인시간"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMSMAPPTIME" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text38" runat="server" Description="의견"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" colspan ="5">
                                    <Ctl:TextBox ID="txtSMSMCOMMENT" runat="server" Width="1080" ></Ctl:TextBox>
                                </td>
                            </tr>

                        </table>		                
                    </div>

                    <div id="tab02_verify">
		                <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="100px" />
                                <col width="250px" />
			                    <col width="100px" />
                                <col width="150px" />
                                <col width="120px" />
                                <col width="*" />
                            </colgroup>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblSMOPSABUN" runat="server" Description="사 번"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">

                                    <Ctl:SearchView ID="svSMOPSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_OPERA_KBSABUN_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                    <Ctl:Button ID="btnOPerate" runat="server" Style="Orange" Description="확인" Hidden ="true" OnClientClick="btnOPerate_Click();" ></Ctl:Button>
                                </td>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblSMOPAPPDATE" runat="server" Description="확인일자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMOPAPPDATE" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblSMOPAPPTIME" runat="server" Description="확인시간"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMOPAPPTIME" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="lblSMOPCOMMENT" runat="server" Description="의견"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" colspan ="5">
                                    <Ctl:TextBox ID="txtSMOPCOMMENT" runat="server" width ="1080"></Ctl:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    
                </div>
            </div>

            <div class="tab_complete" style="padding-top:10px;">
                <ul class="tabnav_complete">
                    <li><a id="tabli01_complete" href="#tab01_complete">작업완료</a></li>
                    <li><a id="tabli02_complete" href="#tab02_complete">작업취소</a></li>
                </ul>
                
                <div class="tabcontent_complete";>
                    <div id="tab01_complete">
		                <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="80px" />
                                <col width="250px" />
			                    <col width="100px" />
                                <col width="150px" />
                                <col width="100px" />
                                <col width="150px" />
                                <col width="100px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text13" runat="server" Description="완료허가자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">

                                    <Ctl:SearchView ID="svSMFSSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_EMPOYEE_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                    <Ctl:Button ID="btnSMFOK" runat="server" Style="Orange" Description="확인" OnClientClick="btnSMFOK_Click();" ></Ctl:Button>
                                </td>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text31"       runat="server" Description="완료일자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMFSDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px"></Ctl:TextBox>
                                </td>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text32"       runat="server" Description="완료시간"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMFSTIME_HH" runat="server" ReadOnly ="false" MaxLength ="2" Width = "30px"></Ctl:TextBox>
                                    <Ctl:TextBox ID="txtSMFSTIME_MM" runat="server" ReadOnly ="false" MaxLength ="2" Width = "30px"></Ctl:TextBox>
                                    <Ctl:TextBox ID="txtSMFSTIME_SS" runat="server" ReadOnly ="false" MaxLength ="2" Width = "30px"></Ctl:TextBox>
                                </td>

                                <td style="text-align:left">
                                    <Ctl:CheckBox ID="chkSMFSWKCLOSE" runat="server" ReadMode="false" >
                                        <asp:ListItem Text="공사완료" Value="Y" ></asp:ListItem>
                                    </Ctl:CheckBox>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:CheckBox ID="chkSMFSWKCANCEL" runat="server" ReadMode="false" >
                                        <asp:ListItem Text="완료취소" Value="Y" ></asp:ListItem>
                                    </Ctl:CheckBox>
                                    <Ctl:Button ID="btnSMFSWKCANCEL" runat="server" Style="Orange" Description="취소" OnClientClick="btnSMFSWKCANCEL_Click();" ></Ctl:Button>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text35" runat="server" Description="의견"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" colspan ="7">
                                    <Ctl:TextBox ID="txtSMFSWKTEXT" runat="server" SetType="Text" TextMode ="MultiLine" Validation ="false" Height ="100" Width ="1070px"></Ctl:TextBox>
                                </td>
                            </tr>
                            
                        </table>
                    </div>


                    <div id="tab02_complete">
		                <table class="table_01" style="width:100%;">
                            <colgroup>
                                <col width="100px" />
                                <col width="250px" />
			                    <col width="100px" />
                                <col width="250px" />
                                <col width="100px" />
                                <col width="*" />
                            </colgroup>

                            <tr>

                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text39" runat="server" Description="취소자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">

                                    <Ctl:SearchView ID="svSMCNSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_BUSEO_EMPOYEE_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                    <Ctl:Button ID="btnSMCanCel" runat="server" Style="Orange" Description="취소" OnClientClick="btnSMCanCel_Click();" ></Ctl:Button>
                                </td>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text40"       runat="server" Description="취소일자"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCNDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" Width ="80px"></Ctl:TextBox>
                                </td>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text41"       runat="server" Description="취소시간"></Ctl:Text>
                                </td>
                                <td style="text-align:left;">
                                    <Ctl:TextBox ID="txtSMCNTIME" runat="server" ReadOnly ="true"></Ctl:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td style="text-align:center;">
                                    <Ctl:Text ID="Text22" runat="server" LangCode="lblWOCANCELCOMMENT2" Description="취소의견"></Ctl:Text>
                                </td>
                                <td style="text-align:left;" colspan="5">
                                    <Ctl:TextBox ID="txtSMCNREASON" runat="server" SetType="Text" TextMode ="MultiLine" Validation ="false" Height ="100" Width ="1100px"></Ctl:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

            <div class="btn_bx" style="padding-top:10px;">
		        <table class="table_01" style="width:100%;">
                    <colgroup>
                        <col width="70px" />
                        <col width="*" />
                    </colgroup>

                    <tr>
                        <th style="text-align:left;">
                            <Ctl:Text ID="Text76" runat="server" LangCode="lblSMORDERTEXT1" Description="특별지시사항"></Ctl:Text>
                        </th>
                    </tr>

                    <tr>
                        <td style="text-align:left;" colspan="2">
                            <Ctl:TextBox ID="txtSMORDERTEXT1" runat="server" SetType="Text" TextMode ="MultiLine" Validation ="false" Height ="100" Width ="1150px"></Ctl:TextBox>
                        </td>
                    </tr>
                </table>
            </div>




            <div class="btn_bx" style="padding-top:10px;">
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
                            <Ctl:Text ID="Text16" runat="server" LangCode="lblWOCHANGEWKDIV" Description="작업구분"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:Combo ID="cboWOCHANGEWKDIV" Width="100px" runat="server">
                                <asp:ListItem Text="단순교체"   Value="1" Selected="True" ></asp:ListItem>
                                <asp:ListItem Text="변경대상"   Value="2" ></asp:ListItem>
                            </Ctl:Combo>
                        </td>
                    </tr>
                </table>
            </div>

            <%--<div class="tab_wk">
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
                                    <Ctl:SearchView ID="svWOFINISHSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" ReadMode="false"  >
                                        <Ctl:SearchViewField DataField="KBSABUN" TextField="KBSABUN" Description="사번" Hidden="false" Width="80" TextBox="true"  runat="server" Default="true" />
                                        <Ctl:SearchViewField DataField="KBHANGL" TextField="KBHANGL" Description="이름" Hidden="false" Width="80" TextBox="true" runat="server" />
                                    </Ctl:SearchView>
                                    <Ctl:Button ID="btnWOFINISH" runat="server" Style="Orange" Description="완료" Hidden ="true"   OnClientClick="btnSAFE_Click();" ></Ctl:Button>
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
            </div>--%>

            

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
                            <Ctl:Text ID="lblSMSYSTEMCODE1" runat="server" LangCode="lblSMSYSTEMCODE1" Description="설비코드1"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtSMSYSTEMCODE1" runat="server" LangCode="txtSMSYSTEMCODE1" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnSMSYSTEMCODE1" alt="연관설비1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('SMSYSTEMCODE1');"  />
			                <Ctl:TextBox ID="pnlSMSYSTEMCODE1" runat="server" LangCode="pnlSMSYSTEMCODE1" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblSMAREACODE1" runat="server" LangCode="lblSMAREACODE1" Description="작업구역1"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtSMAREACODE1" runat="server" LangCode="txtSMAREACODE1" Width ="80px"></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnSMAREACODE1" alt="작업구역1조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('SMAREACODE1');"  />
			                <Ctl:TextBox ID="pnlSMAREACODE1" runat="server" LangCode="pnlSMAREACODE1" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
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
                            <Ctl:Text ID="lblSMSYSTEMCODE2" runat="server" LangCode="lblSMSYSTEMCODE2" Description="설비코드2"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtSMSYSTEMCODE2" runat="server" LangCode="txtSMSYSTEMCODE2" Width ="80px"></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnSMSYSTEMCODE2" alt="연관설비2조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('SMSYSTEMCODE2');"  />
			                <Ctl:TextBox ID="pnlSMSYSTEMCODE2" runat="server" LangCode="pnlSMSYSTEMCODE2" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblSMAREACODE2" runat="server" LangCode="lblSMAREACODE2" Description="작업구역2"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtSMAREACODE2" runat="server" LangCode="txtSMAREACODE2" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnSMAREACODE2" alt="작업구역2조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('SMAREACODE2');"  />
			                <Ctl:TextBox ID="pnlSMAREACODE2" runat="server" LangCode="pnlSMAREACODE2" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
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
                            <Ctl:Text ID="lblSMSYSTEMCODE3" runat="server" LangCode="lblSMSYSTEMCODE3" Description="설비코드3"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtSMSYSTEMCODE3" runat="server" LangCode="txtSMSYSTEMCODE3" Width ="80px"></Ctl:TextBox>
                            <img src="/Resources/Images/btn_search.gif" ID="btnSMSYSTEMCODE3" alt="연관설비3조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('SMSYSTEMCODE3');"  />
			                <Ctl:TextBox ID="pnlSMSYSTEMCODE3" runat="server" LangCode="pnlSMSYSTEMCODE3" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblSMAREACODE3" runat="server" LangCode="lblSMAREACODE3" Description="작업구역3"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtSMAREACODE3" runat="server" LangCode="txtSMAREACODE3" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnSMAREACODE3" alt="작업구역3조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('SMAREACODE3');"  />
			                <Ctl:TextBox ID="pnlSMAREACODE3" runat="server" LangCode="pnlSMAREACODE3" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
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
                            <Ctl:Text ID="lblSMSYSTEMCODE4" runat="server" LangCode="lblSMSYSTEMCODE4" Description="설비코드4"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtSMSYSTEMCODE4" runat="server" LangCode="txtSMSYSTEMCODE4" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnSMSYSTEMCODE4" alt="연관설비4조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('SMSYSTEMCODE4');"  />
			                <Ctl:TextBox ID="pnlSMSYSTEMCODE4" runat="server" LangCode="pnlSMSYSTEMCODE4" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblSMAREACODE4" runat="server" LangCode="lblSMAREACODE4" Description="작업구역4"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtSMAREACODE4" runat="server" LangCode="txtSMAREACODE4" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnSMAREACODE4" alt="작업구역4조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('SMAREACODE4');"  />
			                <Ctl:TextBox ID="pnlSMAREACODE4" runat="server" LangCode="pnlSMAREACODE4" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
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
                            <Ctl:Text ID="lblSMSYSTEMCODE5" runat="server" LangCode="lblSMSYSTEMCODE5" Description="설비코드5"></Ctl:Text>
                        </td>
                        <td style="text-align:left;" colspan ="3">
                            <Ctl:TextBox ID="txtSMSYSTEMCODE5" runat="server" LangCode="txtSMSYSTEMCODE5" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnSMSYSTEMCODE5" alt="연관설비5조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopup_Click('SMSYSTEMCODE5');"  />
			                <Ctl:TextBox ID="pnlSMSYSTEMCODE5" runat="server" LangCode="pnlSMSYSTEMCODE5" ReadOnly ="true" Width ="240px"></Ctl:TextBox>
                        </td>

			            <td style="text-align:center;">
                            <Ctl:Text ID="lblSMAREACODE5" runat="server" LangCode="lblSMAREACODE5" Description="작업구역5"></Ctl:Text>
                        </td>
                        <td style="text-align:left;">
                            <Ctl:TextBox ID="txtSMAREACODE5" runat="server" LangCode="txtSMAREACODE5" Width ="80px"></Ctl:TextBox>
					        <img src="/Resources/Images/btn_search.gif" ID="btnSMAREACODE5" alt="작업구역5조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnAreaPopup_Click('SMAREACODE5');"  />
			                <Ctl:TextBox ID="pnlSMAREACODE5" runat="server" LangCode="pnlSMAREACODE5" ReadOnly ="true" Width ="230px"></Ctl:TextBox>
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
                            <Ctl:Button ID="btnWOFINISH" runat="server" Style="Orange" Description="완료" Hidden ="true"   OnClientClick="btnSAFE_Click();" ></Ctl:Button>
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