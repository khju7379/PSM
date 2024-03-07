<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSI3011.aspx.cs" Inherits="TaeYoung.Portal.TYCSI.CSI.CSI3011" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    
   

    <script type="text/javascript">

        var idx = "";

        var HwajuCode = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";

        function OnLoad() {

            var NUM = "<%= Request.QueryString["NUM"] %>";
            var data = NUM.split('^');

            if (data.length == 2)
            {
                txtJIYYMM.SetValue(data[0]);
                txtJISEQ.SetValue(data[1]);
            }

            if(txtJISEQ.GetValue() == "")
            {
                btnNew_Click("init");
            }
            else{
                SelectIndex();
                btnSearch_Click();
            }
        }

        function getHeajuCode() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["USERID"] = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";

            PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_GET_HWAJUCODE", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtJIJGHWAJU.SetValue(DataSet.Tables[0].Rows[0]["EMHWAJU"]);
                    txtVNCODE.SetValue(DataSet.Tables[0].Rows[0]["EMHWAJU"]);
                    txtJIJGHWAJUNM.SetValue("<%= TaeYoung.Biz.Document.UserInfo.UserName %>");
                    svJICHHJ.SetValue("<%= TaeYoung.Biz.Document.UserInfo.UserName %>");
                    $("#svJICHHJ_CDCODE").val(DataSet.Tables[0].Rows[0]["EMHWAJU"]);
                    JIHISAB.SetValue(DataSet.Tables[0].Rows[0]["EMSABUN"]);
                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        function SelectIndex() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   
            var sCHSTAT;      

            ht["JIYYMM"] = txtJIYYMM.GetValue();           
            ht["JISEQ"] = txtJISEQ.GetValue();
            ht["JIJGHWAJU"] = "<%= TaeYoung.Biz.Document.UserInfo.KOSTL %>";
            
            PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_GET_CSI3011_UTIORDERF_SELECT", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtJIIPHANG.SetValue(DataSet.Tables[0].Rows[0]["JIIPHANG"]);    //접안일자  OK
                    txtVSDESC1.SetValue(DataSet.Tables[0].Rows[0]["VSDESC1"]);      //본선    OK
                    txtVNSANGHO.SetValue(DataSet.Tables[0].Rows[0]["VEND"]);        //입고화주  OK
                    txtHMDESC1.SetValue(DataSet.Tables[0].Rows[0]["HMDESC1"]);      //화물    OK
                    txtJIBLNO.SetValue(DataSet.Tables[0].Rows[0]["JIBLNO"]);        //B/L 번호   OK
                    txtJIMSNSEQ.SetValue(DataSet.Tables[0].Rows[0]["JIMSNSEQ"]);    //MSN   OK
                    txtJIHSNSEQ.SetValue(DataSet.Tables[0].Rows[0]["JIHSNSEQ"]);    //HSN   OK

                    txtJICUSTIL.SetValue(DataSet.Tables[0].Rows[0]["JICUSTIL"]);    //통관일자  OK
                    txtCJJEQTY.SetValue(DataSet.Tables[0].Rows[0]["CJJEQTY"]);      //재고수량  OK

                    txtJINAME.SetValue(DataSet.Tables[0].Rows[0]["JINAME"]);        //담당자   OK
                    txtJIPHONE.SetValue(DataSet.Tables[0].Rows[0]["JIPHONE"]);      //휴대폰   OK

                    if (DataSet.Tables[0].Rows[0]["JISEND"] == "Y") {
                        $('input:checkbox[name="chkSMSSEND"]').attr("checked", true);  //문자수신 OK
                    }

                    txtJIJGHWAJUNM.SetValue(DataSet.Tables[0].Rows[0]["JGVEND"]);   //출고화주,재고화주 OK
                    txtJITANKNO.SetValue(DataSet.Tables[0].Rows[0]["JITANKNO"]);    //출고탱크  OK
                    txtJIIPTANK.SetValue(DataSet.Tables[0].Rows[0]["JIIPTANK"]);    //입고탱크  OK

                    svJICHHJ.SetValue(DataSet.Tables[0].Rows[0]["DCDESC1"]);        //도착지, 출고화주 OK
                    cmbJIWKTYPE.SetValue(DataSet.Tables[0].Rows[0]["JIWKTYPE"]);    //출고유형  OK
                    $("#svJICARNO2_TRNUMN").val(DataSet.Tables[0].Rows[0]["JICARNO2"]); //차량번호  OK

                    txtJISTMTQTY.SetValue(DataSet.Tables[0].Rows[0]["JISTMTQTY"]);  //지시수량MT    OK
                    txtJIEDMTQTY.SetValue(DataSet.Tables[0].Rows[0]["JIEDMTQTY"]);  //지시수량MT    OK
                    txtJISTLTQTY.SetValue(DataSet.Tables[0].Rows[0]["JISTLTQTY"]);  //지시수량L     OK
                    txtJIEDLTQTY.SetValue(DataSet.Tables[0].Rows[0]["JIEDLTQTY"]);  //지시수량L     OK
                    txtJICONTNUM.SetValue(DataSet.Tables[0].Rows[0]["JICONTNUM"]);  //컨테이너      OK

                    cmbJITMGUBN.SetValue(DataSet.Tables[0].Rows[0]["JITMGUBN"]);    //특허구분      OK
                    txtJITIMEHH.SetValue(DataSet.Tables[0].Rows[0]["JITIMEHH"]);    //시간        OK
                    txtJITIMEMM.SetValue(DataSet.Tables[0].Rows[0]["JITIMEMM"]);    //시간        OK
                    svJIDNST.SetValue(DataSet.Tables[0].Rows[0]["DNDESC1"]);        //목적국       OK

                    JIHISAB.SetValue(DataSet.Tables[0].Rows[0]["JIHISAB"]);      //태영담당자 OK
                    txtJICARNO1.SetValue(DataSet.Tables[0].Rows[0]["JICARNO1"]);    //지시사항  OK

                    if (DataSet.Tables[0].Rows[0]["JISICNT"] > 0) {
                         sCHSTAT = "지시완료"
                     } else {
                         sCHSTAT = "대 기"
                     }
                     if (DataSet.Tables[0].Rows[0]["CHULCNT"] > 0) {
                         sCHSTAT = "출고완료"
                     }
                    txtCHULSTATUS.SetValue(sCHSTAT);                                //출고상태  OK

                    txtJIHWAMUL.SetValue(DataSet.Tables[0].Rows[0]["JIHWAMUL"]);    //출고화물  OK
                    txtCJACTHJ.SetValue(DataSet.Tables[0].Rows[0]["JIACTHJ"]);      //통관화주  OK
                    txtJIJGHWAJU.SetValue(DataSet.Tables[0].Rows[0]["JIJGHWAJU"]);  //재고화주  OK
                    txtJIBONSUN.SetValue(DataSet.Tables[0].Rows[0]["JIBONSUN"]);    //본선    OK
                    txtCJCHASU.SetValue(DataSet.Tables[0].Rows[0]["JICHASU"]);      //통관차수  OK
                    txtCJYSHWAJU.SetValue(DataSet.Tables[0].Rows[0]["JIYSHWAJU"]);  //양수화주  OK
                    txtCJYDHWAJU.SetValue(DataSet.Tables[0].Rows[0]["JIYDHWAJU"]);  //양도화주  OK
                    txtCJYSDATE.SetValue(DataSet.Tables[0].Rows[0]["JIYSDATE"]);    //양수일자  OK
                    txtCJYDSEQ.SetValue(DataSet.Tables[0].Rows[0]["JIYDSEQ"]);      //양도차수  OK
                    txtCJYSSEQ.SetValue(DataSet.Tables[0].Rows[0]["JIYSSEQ"]);      //양수순번  OK
                    txtCJHWAJU.SetValue(DataSet.Tables[0].Rows[0]["JIHWAJU"]);      //입고화주  OK

                    txtJICHJANG.SetValue(DataSet.Tables[0].Rows[0]["JICHJANG"]);    //출하장소  OK
                    $("#svJICHHJ_CDCODE").val(DataSet.Tables[0].Rows[0]["JICHHJ"]); //도착지, 출고화주 OK
                    $("#svJIDNST_CDCODE").val(DataSet.Tables[0].Rows[0]["JIDNST"]); //목적국   OK

                    txtJICHTYPE.SetValue(DataSet.Tables[0].Rows[0]["JICHTYPE"]);    //출하방법  OK
                    txtJIUNIT.SetValue(DataSet.Tables[0].Rows[0]["JIUNIT"]);        //출고단위  OK
                    txtJIJANGB.SetValue(DataSet.Tables[0].Rows[0]["JIJANGB"]);      //잔량처리  OK
                    txtJIIPQTY.SetValue(DataSet.Tables[0].Rows[0]["JIIPQTY"]);      //입고수량  OK
                    txtJIJEQTY.SetValue(DataSet.Tables[0].Rows[0]["JIJEQTY"]);      //재고수량  OK
                    txtJIJANQTY.SetValue(DataSet.Tables[0].Rows[0]["JIJANQTY"]);    //통관잔량  OK
                    txtSUMCHQTY.SetValue(DataSet.Tables[0].Rows[0]["SUMCHQTY"]);    //당일출고량  OK
                    
                    txtVNCODE.SetValue(DataSet.Tables[0].Rows[0]["JIJGHWAJU"]);
                    txtJOB.SetValue("C");

                    if(sCHSTAT != "대 기")
                    {   
                        txtMESSAGE.SetValue("출고지시가 접수되어 수정이 불가합니다.");
                        $("#btnSave").attr("style", "display:none");
                        $("#btnUpt").attr("style", "display:none");
                        $("#btnDel").attr("style", "display:none");
                    }
                    else {
                        txtMESSAGE.SetValue("");
                        $("#btnSave").attr("style", "display:none");
                        $("#btnUpt").attr("style", "display:");
                        $("#btnDel").attr("style", "display:");
                    }
                }
                else{
                    btnNew_Click("");
                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        //코드헬프 팝업 호출
        function btnPopUp_Click(gubn) {

            var NUM;

            if (gubn == "JIJGHWAJU") {

                NUM = txtJIJGHWAJU.GetValue() + "^" + txtJIJGHWAJUNM.GetValue();

                fn_OpenPop("CSB0001.aspx?NUM=" + NUM, 1400, 650);
            }
            else if (gubn == "JITANKNO") {
                if(txtHMDESC1.GetValue() != "")
                {
                    NUM = txtJIIPHANG.GetValue() + "^" + txtJIBONSUN.GetValue() + "^" + txtVSDESC1.GetValue() + "^" + txtCJHWAJU.GetValue() + "^" + txtVNSANGHO.GetValue() + "^" + txtJIHWAMUL.GetValue() + "^" + txtHMDESC1.GetValue();
                    
                    fn_OpenPop("CSB0002.aspx?NUM=" + NUM, 1400, 650);
                }
                else{
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG02" Description="재고조회 후 선택 가능합니다." Literal="true"></Ctl:Text>');
                }
            }
            else if (gubn == "JIIPTANK") {
                if(txtHMDESC1.GetValue() != "")
                {
                    NUM = txtJIIPHANG.GetValue() + "^" + txtJIBONSUN.GetValue() + "^" + txtVSDESC1.GetValue() + "^" + txtCJHWAJU.GetValue() + "^" + txtVNSANGHO.GetValue() + "^" + txtJIHWAMUL.GetValue() + "^" + txtHMDESC1.GetValue() + "^" + txtJITANKNO.GetValue();

                    fn_OpenPop("CSB0003.aspx?NUM=" + NUM, 1400, 650);
                }
                else{
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG02" Description="재고조회 후 선택 가능합니다." Literal="true"></Ctl:Text>');
                }
            }

        }

        //코드헬프 팝업 선택한 row 받아서 표시
        function btnPopup_Callback(htM, htD) {

            var ht = new Object();

            txtHMDESC1.SetValue(htM["HMDESC1"]);     // 출고화물명
            txtJICUSTIL.SetValue(htM["CJCUSTIL"]);   // 통관일자 히든
            txtVSDESC1.SetValue(htM["VSDESC1"]);     // 본선명 히든
            txtCJJEQTY.SetValue(htM["CJJEQTY"]);     // 재고수량
            txtCJACTHJ.SetValue(htM["CJACTHJ"]);     // 통관화주 히든
            txtJIJGHWAJU.SetValue(htM["CJJGHWAJU"]); // 재고화주
            txtJIJGHWAJUNM.SetValue(htM["JGVEND"]);  // 재고화주명
            txtJIIPHANG.SetValue(htM["CJIPHANG"]);   // 접안일자 히든
            txtJIBONSUN.SetValue(htM["CJBONSUN"]);   // 본선 히든
            txtCJHWAJU.SetValue(htM["CJHWAJU"]);     // 입고화주 히든
            txtVNSANGHO.SetValue(htM["IPVEND"]);     // 입고화주명 히든
            txtJIHWAMUL.SetValue(htM["CJHWAMUL"]);   // 화물코드 히든
            txtJIBLNO.SetValue(htM["CJBLNO"]);       // B/L 히든
            txtJIMSNSEQ.SetValue(htM["CJMSNSEQ"]);   // MSN 히든
            txtJIHSNSEQ.SetValue(htM["CJHSNSEQ"]);   // HSN 히든
            txtCJCHASU.SetValue(htM["CJCHASU"]);     // 차수 히든
            txtCJYSHWAJU.SetValue(htM["CJYSHWAJU"]); // 양수화주 히든
            txtCJYDHWAJU.SetValue(htM["CJYDHWAJU"]); // 양도화주 히든
            txtCJYSDATE.SetValue(htM["CJYSDATE"]);   // 양수일자 히든
            txtCJYDSEQ.SetValue(htM["CJYDSEQ"]);     // 양도순번 히든
            txtCJYSSEQ.SetValue(htM["CJYSSEQ"]);     // 양수순번 히든

            txtJITANKNO.SetValue(htD["SVTANKNO"]);   // 출고탱크

            if (txtJITANKNO.GetValue() > 5000) {     // 출하장 히든
                txtJICHJANG.SetValue("7");
            }
            else {
                if (txtJITANKNO.GetValue() > 100 && txtJITANKNO.GetValue() <= 501) {
                    txtJICHJANG.SetValue("2");
                }
                else {
                    txtJICHJANG.SetValue("1");
                }
            }

            // 출고 담당자 조회

            ht["HWAJU"] = txtJIJGHWAJU.GetValue();

            PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_GET_CSI3011_LASTSAB", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    //JIHISAB.SetValue(DataSet.Tables[0].Rows[0]["EMSABUN"])  // 태영담당자 JIHISAB
                    //cmbJITMGUBN.SetValue(DataSet.Tables[0].Rows[0]["JITMGUBN"]) // 특허구분 JITMGUBN
                    cmbJIWKTYPE.SetValue(DataSet.Tables[0].Rows[0]["JIWKTYPE"]) // 출고유형 JIWKTYPE
                    
                    //txtJINAME.SetValue(DataSet.Tables[0].Rows[0]["JINAME"])     // 담당자 JIODERNAME
                    //txtJIPHONE.SetValue(DataSet.Tables[0].Rows[0]["JIPHONE"])  // 전화번호 JIODERNAME
                    //if(DataSet.Tables[0].Rows[0]["JISEND"] == "Y")
                    //{
                    //    $('input:checkbox[name="chkSMSSEND"]').attr("checked", true);
                    //}
                    //else{
                    //    $('input:checkbox[name="chkSMSSEND"]').attr("checked", false);
                    //}
                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });

            // 입고탱크 조회
            getIptankList(htD["SVIPHANG"], htD["SVBONSUN"], htD["SVHWAJU"], htD["SVHWAMUL"]);
        }

        function btnPopup_CHTANK_Callback(ht) {

            txtJITANKNO.SetValue(ht["SVTANKNO"]);   // 출고탱크

            // 입고탱크 조회
            getIptankList(ht["SVIPHANG"], ht["SVBONSUN"], ht["SVHWAJU"], ht["SVHWAMUL"]);
        }

        function btnPopup_IPTANK_Callback(ht) {

            txtJIIPTANK.SetValue(ht["COTANKNO"]);   // 입고탱크
        }

        function getIptankList(SVIPHANG, SVBONSUN, SVHWAJU, SVHWAMUL) {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"] = 15;
            ht["IPHANG"] = SVIPHANG;
            ht["BONSUN"] = SVBONSUN;
            ht["HWAJU"] = SVHWAJU;
            ht["HWAMUL"] = SVHWAMUL;
            ht["JITANKNO"] = txtJITANKNO.GetValue();

            PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_GET_CSB0003_IPTANK_LIST", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                    txtJIIPTANK.SetValue(DataSet.Tables[0].Rows[0]["COTANKNO"]);
                }
                else {
                    txtJIIPTANK.SetValue("");
                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        function btnSearch_Click() {

            if (txtJIYYMM.GetValue() == "") {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="지시일자를 입력 하세요." Literal="true"></Ctl:Text>');
                return false;
            }

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.         

            ht["CurrentPageIndex"] = 1;
            ht["PageSize"]         = 10;
            ht["SearchCondition"]  = "";

            ht["IPHWAJU"]          = HwajuCode;
            ht["SDATE"]            = txtJIYYMM.GetValue();
            ht["EDATE"]            = txtJIYYMM.GetValue();
            ht["HWAMUL"]           = "";
            ht["CHHJ"]             = "";
            ht["CARNO"]            = "";
            ht["TANKNO"]           = "";
            
            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        function btnNew_Click(gubn)
        {
            if (gubn == "init") {
                var today = new Date();
                txtJIYYMM.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));
                txtJIIPHANG.SetValue("");   //접안일자  OK
                txtVSDESC1.SetValue("");    //본선    OK
                txtVNSANGHO.SetValue("");   //입고화주  OK
                txtHMDESC1.SetValue("");    //화물    OK
                txtJIBLNO.SetValue("");     //B/L 번호   OK
                txtJIMSNSEQ.SetValue("");   //MSN   OK
                txtJIHSNSEQ.SetValue("");   //HSN   OK
                txtJICUSTIL.SetValue("");   //통관일자  OK
                txtCJJEQTY.SetValue("");    //재고수량  OK
                //txtJINAME.SetValue("");     //담당자   OK
                txtJINAME.SetValue("<%= TaeYoung.Biz.Document.UserInfo.JobName %>")     // 담당자 JIODERNAME
                txtJIPHONE.SetValue("");    //휴대폰   OK
                $('input:checkbox[name="chkSMSSEND"]').attr("checked", false);  //문자수신 OK
                txtJIJGHWAJUNM.SetValue(""); //출고화주,재고화주 OK
                txtJITANKNO.SetValue("");   //출고탱크  OK
                txtJIIPTANK.SetValue("");   //입고탱크  OK
                svJICHHJ.SetValue("");      //도착지, 출고화주 OK
                cmbJIWKTYPE.SetValue("01");   //출고유형  OK
                JIHISAB.SetValue("");    //태영담당자 OK
                txtJIHWAMUL.SetValue("");   //출고화물  OK
                txtCJACTHJ.SetValue("");    //통관화주  OK
                txtJIJGHWAJU.SetValue("");  //재고화주  OK
                txtJIBONSUN.SetValue("");   //본선    OK
                txtCJCHASU.SetValue("");    //통관차수  OK
                txtCJYSHWAJU.SetValue("");  //양수화주  OK
                txtCJYDHWAJU.SetValue("");  //양도화주  OK
                txtCJYSDATE.SetValue("");   //양수일자  OK
                txtCJYDSEQ.SetValue("");    //양도차수  OK
                txtCJYSSEQ.SetValue("");    //양수순번  OK
                txtCJHWAJU.SetValue("");    //입고화주  OK
                txtJICHJANG.SetValue("");   //출하장소  OK
                $("#svJICHHJ_CDCODE").val(""); //도착지, 출고화주 OK
                $("#svJIDNST_CDCODE").val(""); //목적국   OK
                txtJICHTYPE.SetValue("1");  //출하방법  OK
                txtJIUNIT.SetValue("1");     //출고단위  OK
                txtJIJANGB.SetValue("");    //잔량처리  OK
                txtJIIPQTY.SetValue("");    //입고수량  OK
                txtJIJEQTY.SetValue("");    //재고수량  OK
                txtJIJANQTY.SetValue("");   //통관잔량  OK
                txtSUMCHQTY.SetValue("");   //당일출고량  OK

                getHeajuCode();
                btnSearch_Click();
            }
            txtJISEQ.SetValue("");
            $("#svJICARNO2_TRNUMN").val(""); //차량번호  OK
            txtJISTMTQTY.SetValue("");  //지시수량MT    OK
            txtJIEDMTQTY.SetValue("");  //지시수량MT    OK
            txtJISTLTQTY.SetValue("");  //지시수량L     OK
            txtJIEDLTQTY.SetValue("");  //지시수량L     OK
            txtJITIMEHH.SetValue("");   //시간        OK
            txtJITIMEMM.SetValue("");   //시간        OK
            txtJICONTNUM.SetValue("");  //컨테이너      OK
            svJIDNST.SetValue("");      //목적국       OK
            cmbCARCNT.SetValue("1");    //지시대수
            txtJICARNO1.SetValue("");   //지시사항  OK
            txtCHULSTATUS.SetValue(""); //출고상태  OK
            cmbJITMGUBN.SetValue("1");   //특허구분      OK
            txtJOB.SetValue("A");
            txtMESSAGE.SetValue("");

            $("#btnSave").attr("style", "display:");
            $("#btnUpt").attr("style", "display:none");
            $("#btnDel").attr("style", "display:none");
        }

        function btnSave_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            var sCONTNUM = "";
            
            var JITMGUBNNM = "";
            var SMSSEND;
            SMSSEND = ObjectCount(chkSMSSEND.GetValue()) == 1 ? "Y" : "N";

            if(txtJIYYMM.GetValue() == "")
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="지시 일자를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJITANKNO.GetValue() == "")
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG04" Description="출고 탱크번호를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (txtJIIPTANK.GetValue() == "")
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG05" Description="입고 탱크번호를 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if ($("#svJICHHJ_CDCODE").val() == "")
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG06" Description="도착지를 확인하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cmbJIWKTYPE.GetValue() == "01")
            {
                if ($("#svJICARNO2_TRNUMN").val() == "")
                {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG07" Description="차량번호를 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
            }
            else{

                if (txtJICONTNUM.GetValue() == "")
                {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG08" Description="컨테이너 번호를 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
                else{
                    if (txtJICONTNUM.GetValue().length != 11)
                    {   
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG09" Description="컨테이너 번호 자릿수는 11자리입니다." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    else{
                        sCONTNUM = txtJICONTNUM.GetValue().toUpperCase();

                        for (var i = 0; i < 11; i++)
                        {
                            if (i == 0 || i == 1 || i == 2 || i == 3)
                            {
                                if (sCONTNUM.substr(i, 1) != "A" &&
                                    sCONTNUM.substr(i, 1) != "B" &&
                                    sCONTNUM.substr(i, 1) != "C" &&
                                    sCONTNUM.substr(i, 1) != "D" &&
                                    sCONTNUM.substr(i, 1) != "E" &&
                                    sCONTNUM.substr(i, 1) != "F" &&
                                    sCONTNUM.substr(i, 1) != "G" &&
                                    sCONTNUM.substr(i, 1) != "H" &&
                                    sCONTNUM.substr(i, 1) != "I" &&
                                    sCONTNUM.substr(i, 1) != "J" &&
                                    sCONTNUM.substr(i, 1) != "K" &&
                                    sCONTNUM.substr(i, 1) != "L" &&
                                    sCONTNUM.substr(i, 1) != "M" &&
                                    sCONTNUM.substr(i, 1) != "N" &&
                                    sCONTNUM.substr(i, 1) != "O" &&
                                    sCONTNUM.substr(i, 1) != "P" &&
                                    sCONTNUM.substr(i, 1) != "Q" &&
                                    sCONTNUM.substr(i, 1) != "R" &&
                                    sCONTNUM.substr(i, 1) != "S" &&
                                    sCONTNUM.substr(i, 1) != "T" &&
                                    sCONTNUM.substr(i, 1) != "U" &&
                                    sCONTNUM.substr(i, 1) != "V" &&
                                    sCONTNUM.substr(i, 1) != "W" &&
                                    sCONTNUM.substr(i, 1) != "X" &&
                                    sCONTNUM.substr(i, 1) != "Y" &&
                                    sCONTNUM.substr(i, 1) != "Z")
                                {   
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG10" Description="컨테이너 번호 1~4자리까지는 알파벳입니다. 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                            else
                            {

                                if (sCONTNUM.substr(i, 1) != "0" &&
                                    sCONTNUM.substr(i, 1) != "1" &&
                                    sCONTNUM.substr(i, 1) != "2" &&
                                    sCONTNUM.substr(i, 1) != "3" &&
                                    sCONTNUM.substr(i, 1) != "4" &&
                                    sCONTNUM.substr(i, 1) != "5" &&
                                    sCONTNUM.substr(i, 1) != "6" &&
                                    sCONTNUM.substr(i, 1) != "7" &&
                                    sCONTNUM.substr(i, 1) != "8" &&
                                    sCONTNUM.substr(i, 1) != "9")
                                {
                                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG11" Description="컨테이너 번호 5~11자리까지는 숫자입니다. 확인하세요." Literal="true"></Ctl:Text>');
                                    return false;
                                }
                            }
                        }
                    }
                }
            }

            if (cmbJIWKTYPE.GetValue() == "" || cmbJIWKTYPE.GetValue() == null)
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG12" Description="출고 유형을 선택하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if ((txtJISTMTQTY.GetValue() == 0 || txtJISTMTQTY.GetValue() == "") && (txtJISTLTQTY.GetValue() == 0 || txtJISTLTQTY.GetValue() == ""))
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG13" Description="지시수량을 입력하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (cmbJITMGUBN.GetValue() == "" || cmbJITMGUBN.GetValue() == null)
            {
                alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG14" Description="특허 구분을 선택하세요." Literal="true"></Ctl:Text>');
                return false;
            }
            if (SMSSEND == "Y")
            {
                if (txtVNCODE.GetValue() == "SSM" || txtVNCODE.GetValue() == "SSQ")
                {   
                    $('input:checkbox[name="chkSMSSEND"]').attr("checked", false);
                    SMSSEND = "N";
                    txtJINAME.SetValue("");
                    txtJIPHONE.SetValue("");
                }
                else
                {
                    if (txtJINAME.GetValue() == "")
                    {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG16" Description="담당자를 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    if (txtJIPHONE.GetValue() == "")
                    {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG17" Description="휴대폰 번호를 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }
                }
            }
            else
            {
                $('input:checkbox[name="chkSMSSEND"]').attr("checked", false);
                SMSSEND = "N";
                //txtJINAME.SetValue("");
                //txtJIPHONE.SetValue("");
            }

            if (cmbJITMGUBN.GetValue() == "1") {
                JITMGUBNNM = "일반";
            }
            else if (cmbJITMGUBN.GetValue() == "2") {
                JITMGUBNNM = "조출";
            }
            else if (cmbJITMGUBN.GetValue() == "3") {
                JITMGUBNNM = "특허";
            }

            ht["Job"] = txtJOB.GetValue();
            ht["JIYYMM"] = txtJIYYMM.GetValue();
            ht["JISEQ"] = txtJISEQ.GetValue();
            ht["JIIPHANG"] = txtJIIPHANG.GetValue();
            ht["JIBONSUN"] = txtJIBONSUN.GetValue();
            ht["JIHWAJU"] = txtCJHWAJU.GetValue();
            ht["JIHWAMUL"] = txtJIHWAMUL.GetValue();
            ht["JIBLNO"] = txtJIBLNO.GetValue();
            ht["JIMSNSEQ"] = txtJIMSNSEQ.GetValue();
            ht["JIHSNSEQ"] = txtJIHSNSEQ.GetValue();
            ht["JICUSTIL"] = txtJICUSTIL.GetValue();
            ht["JIJANGB"] = txtJIJANGB.GetValue();
            ht["JICHASU"] = txtCJCHASU.GetValue();
            ht["JICHHJ"] = $("#svJICHHJ_CDCODE").val();
            ht["JITANKNO"] = txtJITANKNO.GetValue();
            ht["JIIPTANK"] = txtJIIPTANK.GetValue();
            ht["JIIPQTY"] = txtJIIPQTY.GetValue();
            ht["JIJEQTY"] = txtJIJEQTY.GetValue();
            ht["JIJANQTY"] = txtJIJANQTY.GetValue();
            ht["JICARNO1"] = txtJICARNO1.GetValue();
            ht["JICARNO2"] = $("#svJICARNO2_TRNUMN").val();
            ht["JICHJANG"] = txtJICHJANG.GetValue();
            ht["JIORDNAME"] = txtJINAME.GetValue();
            ht["JIHISAB"] = JIHISAB.GetValue();
            ht["JICHTYPE"] = txtJICHTYPE.GetValue();
            ht["JIUNIT"] = txtJIUNIT.GetValue();
            ht["JINAME"] = txtJINAME.GetValue();
            ht["JIPHONE"] = txtJIPHONE.GetValue();
            ht["SMSchk"] = SMSSEND; 
            ht["JIJGHWAJU"] = txtJIJGHWAJU.GetValue();
            ht["JIYSHWAJU"] = txtCJYSHWAJU.GetValue();
            ht["JIHWAMULNM"] = txtHMDESC1.GetValue();
            ht["JICHHJNM"] = $("#svJICHHJ_CDDESC1").val();
            ht["CJJEQTY"] = txtCJJEQTY.GetValue();
            ht["JIYDHWAJU"] = txtCJYDHWAJU.GetValue();
            ht["JIYSDATE"] = txtCJYSDATE.GetValue();
            ht["JIYDSEQ"] = txtCJYDSEQ.GetValue();
            ht["JIYSSEQ"] = txtCJYSSEQ.GetValue();
            ht["JISTMTQTY"] = txtJISTMTQTY.GetValue();
            ht["JIEDMTQTY"] = txtJIEDMTQTY.GetValue();
            ht["JISTLTQTY"] = txtJISTLTQTY.GetValue();
            ht["JIEDLTQTY"] = txtJIEDLTQTY.GetValue();
            ht["JICONTNUM"] = sCONTNUM;
            ht["JITMGUBN"] = cmbJITMGUBN.GetValue();
            ht["JIWKTYPE"] = cmbJIWKTYPE.GetValue();
            ht["JITIMEHH"] = txtJITIMEHH.GetValue();
            ht["JITIMEMM"] = txtJITIMEMM.GetValue();
            ht["JIDNST"] = $("#svJIDNST_CDCODE").val();
            ht["JIACTHJ"] = txtCJACTHJ.GetValue();
            ht["JITMGUBNNM"] = JITMGUBNNM;
            ht["VNCODE"] = txtVNCODE.GetValue();
            ht["CARCNT"] = cmbCARCNT.GetValue();
            ht["JIJGHWAJUNM"] = txtJIJGHWAJUNM.GetValue();

            if (confirm('<Ctl:Text ID="MSG02" runat="server" LangCode="MSG18" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_CSI3011_SAVE", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                            txtJISEQ.SetValue(DataSet.Tables[0].Rows[0]["JISEQ"]);
                            SelectIndex();
                            btnSearch_Click();
                        }
                        var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG19" Description="' + msg + '" Literal="true"></Ctl:Text>');
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        function btnDel_Click()
        {
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["Job"] = "D";
            ht["JIYYMM"] = txtJIYYMM.GetValue();
            ht["JISEQ"] = txtJISEQ.GetValue();

            if (confirm('<Ctl:Text ID="MSG03" runat="server" LangCode="MSG21" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                PageMethods.InvokeServiceTable(ht, "CSI.CSIBiz", "UP_CSI3011_DEL", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {
                    
                        if(DataSet.Tables[0].Rows[0]["STATE"] == "OK")
                        {
                            btnNew_Click("");
                            btnSearch_Click();
                        }
                        var msg = DataSet.Tables[0].Rows[0]["MSG"];
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG22" Description="' + msg + '" Literal="true"></Ctl:Text>');
                    }
                    else {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG23" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }

                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG23" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });
            }
        }

        function btnClose_Click() {

            this.close();
            //return false;
        }

        function btnCDCODE_Click() {
            
            fn_OpenPop("CSB0005.aspx", 520, 170);            
        }
        function btnCAR_Click(){
            fn_OpenPop("CSB0006.aspx", 520, 450);
        }

        function btnPatent_Click(){
            fn_OpenPop("CSB0007.aspx", 520, 260);
        }
        function GridClick(r, c) {

            var rows = gridIndex.GetRow(gridIndex.SelectedRow);

            txtJIYYMM.SetValue(rows["JIYYMM"]);
            txtJISEQ.SetValue(rows["JISEQ"]);

            SelectIndex();
        }
       
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
   
   <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="출고지시관리" Literal="true"></Ctl:Text>
        </h4>

        <div class="btn_bx">
            <Ctl:Button ID="btnSearch" runat="server" Style="Orange" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>
            <Ctl:Button ID="btnNew" runat="server" Style="Orange" LangCode="btnNew" Description="신규" OnClientClick="btnNew_Click('');" ></Ctl:Button>
		    <Ctl:Button ID="btnSave" runat="server" Style="Orange" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();" ></Ctl:Button>
            <Ctl:Button ID="btnUpt" runat="server" Style="Orange" LangCode="btnUpt" Description="수정" OnClientClick="btnSave_Click();" ></Ctl:Button>
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
                    <col style="width:10%;" />
                    <col style="width:15%;" />
                    <col style="width:10%;" />
                    <col style="width:15%;" />
                    <col style="width:10%;" />
                    <col style="width:15%;" />
                </colgroup>
            <tr>
                <th><Ctl:Text ID="TXT06" runat="server" LangCode="TXT06" Description="출고일자" Required = "true"></Ctl:Text></th>
                <td colspan="3">
                     
                     <Ctl:TextBox ID="txtJIYYMM" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar" ></Ctl:TextBox>
                     <Ctl:TextBox ID="txtJISEQ" readonly="true" style="background-color:LightGray" Width="50px" runat="server"></Ctl:TextBox>
                </td>
                <td colspan="2">
                    <Ctl:Button ID="btnDCCODE" runat="server" Style="Orange" LangCode="btnDCCODE" Description="신규도착지등록" OnClientClick="btnCDCODE_Click();" ></Ctl:Button>
                    <Ctl:Button ID="btnCAR" runat="server" Style="Orange" LangCode="btnCAR" Description="신규차량등록" OnClientClick="btnCAR_Click();" ></Ctl:Button>
                </td>
            </tr>
            <tr>
                <th><Ctl:Text ID="TXT07" runat="server" LangCode="TXT07" Description="출고화주" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtJIJGHWAJU" Width="50px" runat="server"></Ctl:TextBox>                    
                    <img src="/Resources/Images/btn_search.gif" ID="btnJEGO" alt="출고화주조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('JIJGHWAJU');"  />
                    <Ctl:TextBox ID="txtJIJGHWAJUNM" readonly="true" style="background-color:LightGray"  Width="175px" runat="server"></Ctl:TextBox>
                </td>
                <th><Ctl:Text ID="TXT08" runat="server" LangCode="TXT08" Description="출고화물"></Ctl:Text></th>
                <td><Ctl:TextBox ID="txtHMDESC1" readonly="true" style="background-color:LightGray" Width="220px" runat="server"></Ctl:TextBox></td>
                <th><Ctl:Text ID="TXT12" runat="server" LangCode="TXT12" Description="당일출고량"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtSUMCHQTY" readonly="true" style="background-color:LightGray;text-align:right" runat="server"></Ctl:TextBox>
                </td>
            </tr>
             <tr>
                <th><Ctl:Text ID="TXT10" runat="server" LangCode="TXT10" Description="출고탱크" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtJITANKNO" readonly="true" Width="80" runat="server"></Ctl:TextBox>      
                    <img src="/Resources/Images/btn_search.gif" ID="btnCHTANK" alt="출고탱크조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('JITANKNO');"  />               
                </td>
                <th><Ctl:Text ID="TXT11" runat="server" LangCode="TXT11" Description="입고탱크" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtJIIPTANK" readonly="true" Width="80" runat="server"></Ctl:TextBox>
                    <img src="/Resources/Images/btn_search.gif" ID="btnIPTANK" alt="입고탱크조회" style="cursor:pointer;height: 25px;width: 25px;" onclick="btnPopUp_Click('JIIPTANK');"  />               
                </td>
                <th><Ctl:Text ID="TXT13" runat="server" LangCode="TXT13" Description="재고량"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtCJJEQTY" readonly="true" style="background-color:LightGray;text-align:right"  runat="server"></Ctl:TextBox>                     
                </td>
            </tr>  
            
            
             <tr>
                <th><Ctl:Text ID="TXT15" runat="server" LangCode="TXT15" Description="도착지" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:SearchView ID="svJICHHJ" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'DC'}" >                       
                       <Ctl:SearchViewField DataField="CDCODE" TextField="CDCODE" Description="코드" Hidden="false" Width="50" TextBox="true" runat="server" />
                       <Ctl:SearchViewField DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" Width="200" TextBox="false" Default="true" runat="server" />
                    </Ctl:SearchView>
                </td>
                <th><Ctl:Text ID="TXT16" runat="server" LangCode="TXT16" Description="차량번호"></Ctl:Text></th>
                <td>
                    <Ctl:SearchView ID="svJICARNO2" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_CARNO_LIST" >                       
                       <Ctl:SearchViewField DataField="TRNUMN" TextField="TRNUMN" Description="차량번호" Hidden="false" Width="120" TextBox="true" Default="true" runat="server" />
                       <Ctl:SearchViewField DataField="SOSOK" TextField="SOSOK" Description="차량소속" Hidden="false" Width="130" TextBox="false" runat="server" />
                    </Ctl:SearchView>
                    <Ctl:Text ID="TXTJICHHJ" runat="server" LangCode="TXTJICHHJ" style="color:red" Description="(예시) 2555 / 차량뒷번호4자리"></Ctl:Text>
                </td>
                <th><Ctl:Text ID="TXT17" runat="server" LangCode="TXT17" Description="출고유형" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:Combo ID="cmbJIWKTYPE" runat="server" RepeatColumns="2">
                            <asp:ListItem Selected="True" Text="TANK LORRY" Value="01"></asp:ListItem>
                            <asp:ListItem Text="ISO TANK" Value="02"></asp:ListItem>
                            <asp:ListItem Text="FLEXI BAG" Value="03"></asp:ListItem>
                    </Ctl:Combo>
                </td>
            </tr>    
            
            <tr>   
                <th><Ctl:Text ID="TXT18" runat="server" LangCode="TXT18" Description="지시수량(MT)"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtJISTMTQTY" Width="60" style="text-align:right" runat="server" SetType="Number"></Ctl:TextBox> 
                    ~
                    <Ctl:TextBox ID="txtJIEDMTQTY" Width="60" style="text-align:right" runat="server" SetType="Number"></Ctl:TextBox>  
                </td>
                <th><Ctl:Text ID="TXT19" runat="server" LangCode="TXT19" Description="지시수량(Liter)"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtJISTLTQTY" Width="60" style="text-align:right" runat="server" SetType="Number"></Ctl:TextBox>  
                    ~
                    <Ctl:TextBox ID="txtJIEDLTQTY" Width="60" style="text-align:right" runat="server" SetType="Number"></Ctl:TextBox>  
                </td>
                <th><Ctl:Text ID="TXT20" runat="server" LangCode="TXT20" Description="컨테이너 NO"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtJICONTNUM" runat="server" maxlength="11"></Ctl:TextBox>  
                </td>
            </tr>    

            <tr>
                <th><Ctl:Text ID="TXT21" runat="server" LangCode="TXT21" Description="특허구분" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:Combo ID="cmbJITMGUBN" runat="server" RepeatColumns="2">
                            <asp:ListItem Selected="True" Text="일반" Value="1"></asp:ListItem>
                            <asp:ListItem Text="조출" Value="2"></asp:ListItem>
                            <asp:ListItem Text="특허" Value="3"></asp:ListItem>
                    </Ctl:Combo>
                    <Ctl:Button ID="btnPatent" runat="server" Style="Orange" LangCode="btnPatent" Description="할증시간안내" OnClientClick="btnPatent_Click();" ></Ctl:Button>
                </td>
                <th><Ctl:Text ID="TXT22" runat="server" LangCode="TXT22" Description="시간"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtJITIMEHH" Width="40" runat="server" style="text-align:left" maxlength="2" SetType="Number"></Ctl:TextBox>  
                    :
                    <Ctl:TextBox ID="txtJITIMEMM" Width="40" runat="server" style="text-align:left" maxlength="2" SetType="Number"></Ctl:TextBox>  
                </td>
                <th><Ctl:Text ID="TXT23" runat="server" LangCode="TXT23" Description="목적국"></Ctl:Text></th>
                <td>
                    <Ctl:SearchView ID="svJIDNST" runat="server" TypeName="CSI.CSIBiz" MethodName="UP_GET_CODE_LIST" Params="{'INDEX':'GS'}" >                       
                       <Ctl:SearchViewField DataField="CDCODE" TextField="CDCODE" Description="코드" Hidden="false" Width="50" TextBox="true" runat="server" />
                       <Ctl:SearchViewField DataField="CDDESC1" TextField="CDDESC1" Description="코드명" Hidden="false" Width="200" TextBox="false" Default="true" runat="server" />
                    </Ctl:SearchView>
                </td>
            </tr>  
                <th><Ctl:Text ID="TXT29" runat="server" LangCode="TXT29" Description="지시대수" Required = "true"></Ctl:Text></th>
                <td>
                    <Ctl:Combo ID="cmbCARCNT" Width="60" runat="server" RepeatColumns="2">
                            <asp:ListItem Selected="True" Text="1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                            <asp:ListItem Text="6" Value="6"></asp:ListItem>
                            <asp:ListItem Text="7" Value="7"></asp:ListItem>
                            <asp:ListItem Text="8" Value="8"></asp:ListItem>
                            <asp:ListItem Text="9" Value="9"></asp:ListItem>
                            <asp:ListItem Text="10" Value="10"></asp:ListItem>
                    </Ctl:Combo>
                </td>
                <th><Ctl:Text ID="TXT25" runat="server" LangCode="TXT25" Description="지시사항"></Ctl:Text></th>
                <td colspan="3">
                    <Ctl:TextBox ID="txtJICARNO1" Width="450" runat="server"></Ctl:TextBox>  
                </td>
            <tr>
                <th><Ctl:Text ID="TXT27" runat="server" LangCode="TXT27" Description="오더입력담당자"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtJINAME" runat="server"></Ctl:TextBox>  
                </td>
                <th><Ctl:Text ID="TXT28" runat="server" LangCode="TXT28" Description="오더입력담당자휴대폰(-제외)"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtJIPHONE" runat="server" style="text-align:left" SetType="Number" maxlength="11"></Ctl:TextBox>  
                    <Ctl:CheckBox ID="chkSMSSEND" runat="server" ReadMode="false" >
                            <asp:ListItem Text="문자수신" Value="Y" ></asp:ListItem>
                        </Ctl:CheckBox>
                </td>
                <th><Ctl:Text ID="TXT14" runat="server" LangCode="TXT14" Description="출고상태"></Ctl:Text></th>
                <td>
                    <Ctl:TextBox ID="txtCHULSTATUS" readonly="true" style="background-color:LightGray" runat="server"></Ctl:TextBox>
                </td>
            </tr>
            <tr>
                <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" HFixation="true"  Fixation = "true" Height="380" CheckBox="false" Width="100%" TypeName="CSI.CSIBiz" MethodName="UP_CSI3010_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            
                <Ctl:SheetField DataField="JIYYMM"    TextField="JIYYMM"    Description="출고일자" Width="85" HAlign="center" Align="left"   runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="JISEQ"     TextField="JISEQ"     Description="순번"     Width="50"  HAlign="center" Align="left"  runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="HMDESC1"   TextField="HMDESC1"   Description="출고화물" Width="190" HAlign="center" Align="left"  runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="DCDESC1"   TextField="DCDESC1"   Description="도착지"   Width="200" HAlign="center" Align="left"  runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="JITANKNO"  TextField="JITANKNO"  Description="출고탱크" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="JICHQTY"   TextField="JICHQTY"   Description="출고수량" Width="85"  HAlign="right"  Align="right" runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="JICARNO2"  TextField="JICARNO2"  Description="차량번호" Width="120" HAlign="center" Align="left"  runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="JICONTNUM" TextField="JICONTNUM" Description="CONNO"    Width="150" HAlign="center" Align="left"  runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="JITMGUBN"  TextField="JITMGUBN"  Description="특허구분" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="JIWKTYPE"  TextField="JIWKTYPE"  Description="출고유형" Width="90"  HAlign="center" Align="left"  runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="JIQTY"     TextField="JIQTY"     Description="지시수량" Width="200" HAlign="right"  Align="right" runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="JISTATUS"  TextField="JISTATUS"  Description="출고상태" Width="80"  HAlign="center" Align="left"  runat="server" OnClick="GridClick"/>
                <Ctl:SheetField DataField="JICARNO1"  TextField="JICARNO1"  Description="지시사항" Width="300" HAlign="center" Align="left"  runat="server" OnClick="GridClick"/>

                </Ctl:WebSheet>  
            </tr>
            <tr>
                
                <td colspan="6">
                    <Ctl:TextBox ID="txtMESSAGE" style="width:100%;color:red;text-align:center" readonly="true" runat="server"></Ctl:TextBox>
                </td>
            </tr>
            <Ctl:TextBox ID="txtJICUSTIL" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtVSDESC1" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtCJACTHJ" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtJIIPHANG" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtJIBONSUN" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtCJHWAJU" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtVNSANGHO" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtJIHWAMUL" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtJIBLNO" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtJIMSNSEQ" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtJIHSNSEQ" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtCJCHASU" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtCJYSHWAJU" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtCJYDHWAJU" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtCJYSDATE" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtCJYDSEQ" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtCJYSSEQ" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtJICHJANG" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtJICHTYPE" Hidden="true" runat="server"></Ctl:TextBox> 
            <Ctl:TextBox ID="txtJIUNIT" Hidden="true" runat="server"></Ctl:TextBox> 
            <Ctl:TextBox ID="txtJIJANGB" Hidden="true" runat="server"></Ctl:TextBox> 
            <Ctl:TextBox ID="txtJIIPQTY" Hidden="true" runat="server"></Ctl:TextBox> 
            <Ctl:TextBox ID="txtJIJEQTY" Hidden="true" runat="server"></Ctl:TextBox> 
            <Ctl:TextBox ID="txtJIJANQTY" Hidden="true" runat="server"></Ctl:TextBox> 
            <Ctl:TextBox ID="txtVNCODE" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="txtJOB" Hidden="true" runat="server"></Ctl:TextBox>  
            <Ctl:TextBox ID="JIHISAB" Hidden="true" runat="server"></Ctl:TextBox>  
            
            
            </table>
		</Ctl:Layer>

        
	</div>

</asp:content>