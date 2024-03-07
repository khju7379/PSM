<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1072.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1072" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">

    <style>           
             html,body {width:100%;  }
            body,div,ul,li{margin:0; padding:0;}
            ul,li {list-style:none;}

            /*tab css*/
            .tab{float:left; width:100%; height:600px;}
            .tabnav{font-size:0; width:600px; border:0px solid #ddd;}
            
            .tabnav li{display: inline-block;  height:30px; text-align:center; border-right:1px solid #ddd;}

            .tabnav li a:before{content:""; position:absolute; left:0; top:0px; width:100%; height:2px; }

            .tabnav li a.active:before{background:#A32958;}

            .tabnav li a.active{border-bottom:1px solid #fff;}
            .tabnav li a{ position:relative; display:block; background: #f8f8f8; color: #646464; padding:0 30px; line-height:30px; text-decoration:none; font-size:13px;}
            .tabnav li a:hover,
            .tabnav li a.active{background:#fff; color:#A32958; }            
            .tabcontent{padding: 5px; height:680px; border:1px solid #ddd; border-top:none;}
           
    </style>
    <script type="text/javascript">

        var DataGubn = "";

        // 페이지 로드
        function OnLoad() {

            var Code = "<%= Request.QueryString["CODE"] %>";

            var data = Code.split('^');

            txtCISBCODE.SetValue(data[0]);
            txtCISBCODENM.SetValue(data[1]);
            txtCIGRCODE.SetValue(data[2]);
            txtCIGRCODENM.SetValue(data[3]);
            txtCIGRSEQ.SetValue(data[4]);
            txtCIMCNUM.SetValue(data[5]);

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["CISBCODE"] = txtCISBCODE.GetValue();
            ht["CIGRCODE"] = txtCIGRCODE.GetValue();
            ht["CIGRSEQ"] = txtCIGRSEQ.GetValue();

            gridDCode.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridDCode.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            tabControl("DCODE");

            if (data.length == 6) {

                DataGubn = "ADD";

                UP_FiledInit();

                btnDel.Hide();
            }
            else if (data.length == 7) {

                DataGubn = "";

                txtCIITEMNUM.SetValue(data[6]);

                UP_DataBind_Run("DCODE");
            }
            else {

                DataGubn = "";

                txtCSTSBCODE.SetValue(data[0]);
                txtCSTSBCODENM.SetValue(data[1]);
                txtCSTGRCODE.SetValue(data[2]);
                txtCSTGRCODENM.SetValue(data[3]);
                txtCSTGRSEQ.SetValue(data[4]);
                txtCSMCNUM.SetValue(data[5]);
                txtCSTITEMNUM.SetValue(data[6]);
                txtCIEVAITEM2.SetValue(data[7]);
                txtCIEVASTD2.SetValue(data[8]);
                txtCSTSEQ.SetValue(data[9]);

                ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["CSTSBCODE"] = txtCSTSBCODE.GetValue();
                ht["CSTGRCODE"] = txtCSTGRCODE.GetValue();
                ht["CSTGRSEQ"] = txtCSTGRSEQ.GetValue();
                ht["CSTITEMNUM"] = txtCSTITEMNUM.GetValue();

                gridResult.Params(ht); // 선언한 파라미터를 그리드에 전달함
                gridResult.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                tabControl("RESULT");

                UP_DataBind_Run("RESULT");
            }
        }

        function UP_FiledInit() {

            var today = new Date();
            txtCIWRDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));  //작성일자

            svCIWRSABUN.SetValue("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>");    //작성자
        }

        function tabControl(gubun) {

            if (gubun == "DCODE") {
                $('.tabcontent > div').hide();

                $('.tabnav a').click(function () {
                    $('.tabcontent > div').hide().filter(this.hash).fadeIn();
                    $('.tabnav a').removeClass('active');
                    $(this).addClass('active');
                    return false;
                }).filter(':eq(0)').click();
            }
            else {
                $('.tabcontent > div').hide();

                $('.tabnav a').click(function () {
                    $('.tabcontent > div').hide().filter(this.hash).fadeIn();
                    $('.tabnav a').removeClass('active');
                    $(this).addClass('active');
                    return false;
                }).filter(':eq(1)').click();
            }
            
        }

        // 데이터 바인딩
        function UP_DataBind_Run(gubun) {

            if (gubun == "DCODE") {
                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

                ht["CISBCODE"] = txtCISBCODE.GetValue();
                ht["CIGRCODE"] = txtCIGRCODE.GetValue();
                ht["CIGRSEQ"] = txtCIGRSEQ.GetValue();
                ht["CIITEMNUM"] = txtCIITEMNUM.GetValue();

                PageMethods.InvokeServiceTable(ht, "PSM.PSM1070", "UP_GET_CHECKLIST_DCODE_RUN", function (e) {

                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                        txtCIITEMNUM.SetValue(DataSet.Tables[0].Rows[0]["CIITEMNUM"]);
                        txtCIEVAITEM.SetValue(DataSet.Tables[0].Rows[0]["CIEVAITEM"]);
                        txtCIEVASTD.SetValue(DataSet.Tables[0].Rows[0]["CIEVASTD"]);
                        svCIWRSABUN.SetValue(DataSet.Tables[0].Rows[0]["CIWRSABUN"]);
                        txtCIWRDATE.SetValue(DataSet.Tables[0].Rows[0]["CIWRDATE"]);

                        txtCSTSBCODE.SetValue(txtCISBCODE.GetValue());
                        txtCSTSBCODENM.SetValue(txtCISBCODENM.GetValue());
                        txtCSTGRCODE.SetValue(txtCIGRCODE.GetValue());
                        txtCSTGRCODENM.SetValue(txtCIGRCODENM.GetValue());
                        txtCSTGRSEQ.SetValue(txtCIGRSEQ.GetValue());
                        txtCSMCNUM.SetValue(txtCIMCNUM.GetValue());
                        txtCSTITEMNUM.SetValue(DataSet.Tables[0].Rows[0]["CIITEMNUM"]);
                        txtCIEVAITEM2.SetValue(DataSet.Tables[0].Rows[0]["CIEVAITEM"]);
                        txtCIEVASTD2.SetValue(DataSet.Tables[0].Rows[0]["CIEVASTD"]);

                        ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                        ht["CSTSBCODE"] = txtCSTSBCODE.GetValue();
                        ht["CSTGRCODE"] = txtCSTGRCODE.GetValue();
                        ht["CSTGRSEQ"] = txtCSTGRSEQ.GetValue();
                        ht["CSTITEMNUM"] = txtCSTITEMNUM.GetValue();

                        gridResult.Params(ht); // 선언한 파라미터를 그리드에 전달함
                        gridResult.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                        if (DataSet.Tables[0].Rows[0]["LTGUBUN"] == "Y") {
                            btnDel.Hide();
                        }
                        else {
                            btnDel.Show();
                        }
                    }
                }, function (e) {
                    // Biz 연결오류
                    alert("Error");
                });
            }
            else {
                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

                if (txtCSTSBCODE.GetValue() != "" && txtCSTGRCODE.GetValue() != "" && txtCSTGRSEQ.GetValue() != "" && txtCSTITEMNUM.GetValue() != "" && txtCSTSEQ.GetValue() != "") {

                    ht["CSTSBCODE"] = txtCSTSBCODE.GetValue();
                    ht["CSTGRCODE"] = txtCSTGRCODE.GetValue();
                    ht["CSTGRSEQ"] = txtCSTGRSEQ.GetValue();
                    ht["CSTITEMNUM"] = txtCSTITEMNUM.GetValue();
                    ht["CSTSEQ"] = txtCSTSEQ.GetValue();

                    PageMethods.InvokeServiceTable(ht, "PSM.PSM1070", "UP_GET_CHECKLIST_STRESULT_RUN", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                            txtCSTSEQ.SetValue(DataSet.Tables[0].Rows[0]["CSTSEQ"]);
                            txtCSTACTDESC.SetValue(DataSet.Tables[0].Rows[0]["CSTACTDESC"]);
                            txtCSTADVDESC.SetValue(DataSet.Tables[0].Rows[0]["CSTADVDESC"]);
                            svCSTWRSABUN.SetValue(DataSet.Tables[0].Rows[0]["CSTWRSABUN"]);
                            txtCSTWRDATE.SetValue(DataSet.Tables[0].Rows[0]["CSTWRDATE"]);

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
        }

        // 조회 버튼
        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            if ($('#tabli01').attr('class') != "") {

                ht["CISBCODE"] = txtCISBCODE.GetValue();
                ht["CIGRCODE"] = txtCIGRCODE.GetValue();
                ht["CIGRSEQ"] = txtCIGRSEQ.GetValue();

                gridDCode.Params(ht); // 선언한 파라미터를 그리드에 전달함
                gridDCode.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
            }
            else {

                if (txtCSTSBCODE.GetValue() != "" && txtCSTGRCODE.GetValue() != "" && txtCSTGRSEQ.GetValue() != "" && txtCSTITEMNUM.GetValue() != "") {

                    ht["CSTSBCODE"] = txtCSTSBCODE.GetValue();
                    ht["CSTGRCODE"] = txtCSTGRCODE.GetValue();
                    ht["CSTGRSEQ"] = txtCSTGRSEQ.GetValue();
                    ht["CSTITEMNUM"] = txtCSTITEMNUM.GetValue();

                    gridResult.Params(ht); // 선언한 파라미터를 그리드에 전달함
                    gridResult.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
                }
                else {
                    alert('<Ctl:Text runat="server" Description="평가항목을 선택 후 조회하세요." Literal="true"></Ctl:Text>');
                }
                
            }
        }

        // 신규 버튼
        function btnNew_Click()
        {
            var today = new Date();

            if ($('#tabli01').attr('class') != "") {

                txtCIITEMNUM.SetValue("");
                txtCIEVAITEM.SetValue("");
                txtCIEVASTD.SetValue("");
                svCIWRSABUN.SetValue("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>");    //작성자
                txtCIWRDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));  //작성일자
            }
            else {

                txtCSTSEQ.SetValue("");
                txtCSTACTDESC.SetValue("");
                txtCSTADVDESC.SetValue("");
                svCSTWRSABUN.SetValue("<%= TaeYoung.Biz.Document.UserInfo.EmpID %>");    //작성자
                txtCSTWRDATE.SetValue(today.getFullYear() + "-" + CalLpad((today.getMonth() + 1)) + "-" + CalLpad(today.getDate()));  //작성일자
            }

            DataGubn = "ADD";

            btnDel.Hide();
        }

        // 저장 버튼
        function btnSave_Click() {         

            // 평가항목
            if ($('#tabli01').attr('class') != "") {

                if (txtCIEVAITEM.GetValue() == "" || txtCIEVAITEM.GetValue() == null) {
                    alert('<Ctl:Text runat="server" Description="평가항목을 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
                if (txtCIEVASTD.GetValue() == "" || txtCIEVASTD.GetValue() == null) {
                    alert('<Ctl:Text runat="server" Description="평가기준을 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
                if (svCIWRSABUN.GetValue() == "" || svCIWRSABUN.GetValue() == null) {
                    alert('<Ctl:Text runat="server" Description="작성자를 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }
                if (txtCIWRDATE.GetValue() == "" || txtCIWRDATE.GetValue() == null) {
                    alert('<Ctl:Text runat="server" Description="작성일자를 입력하세요." Literal="true"></Ctl:Text>');
                    return false;
                }

                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["CISBCODE"] = txtCISBCODE.GetValue();
                ht["CIGRCODE"] = txtCIGRCODE.GetValue();
                ht["CIGRSEQ"] = txtCIGRSEQ.GetValue();

                if (DataGubn == 'ADD') {
                    ht["CIITEMNUM"] = "0";
                }
                else {
                    ht["CIITEMNUM"] = txtCIITEMNUM.GetValue();
                }
                ht["CIEVAITEM"] = txtCIEVAITEM.GetValue();
                ht["CIEVASTD"] = txtCIEVASTD.GetValue();
                ht["CIWRSABUN"] = svCIWRSABUN.GetValue();
                ht["CIWRDATE"] = txtCIWRDATE.GetValue();
                
                if (confirm('<Ctl:Text ID="MSG02" runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    PageMethods.InvokeServiceTable(ht, "PSM.PSM1070", "UP_CHECKLIST_DCODE_ADD", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                            DataGubn = "";
                            txtCIITEMNUM.SetValue(DataSet.Tables[0].Rows[0]["CIITEMNUM"]);

                            UP_DataBind_Run("DCODE");
                            btnSearch_Click();

                            alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');
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
            else {  // 안전조치
                if (txtCSTSBCODE.GetValue() != "" && txtCSTGRCODE.GetValue() != "" && txtCSTGRSEQ.GetValue() != "" && txtCSTITEMNUM.GetValue() != "") {

                    if (txtCSTACTDESC.GetValue() == "" || txtCSTACTDESC.GetValue() == null) {
                        alert('<Ctl:Text runat="server" Description="안전조치를 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    if (svCSTWRSABUN.GetValue() == "" || svCSTWRSABUN.GetValue() == null) {
                        alert('<Ctl:Text runat="server" Description="작성자를 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    if (txtCSTWRDATE.GetValue() == "" || txtCSTWRDATE.GetValue() == null) {
                        alert('<Ctl:Text runat="server" Description="작성일자를 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                    ht["CSTSBCODE"] = txtCSTSBCODE.GetValue();
                    ht["CSTGRCODE"] = txtCSTGRCODE.GetValue();
                    ht["CSTGRSEQ"] = txtCSTGRSEQ.GetValue();
                    ht["CSTITEMNUM"] = txtCSTITEMNUM.GetValue();

                    if (DataGubn == 'ADD') {
                        ht["CSTSEQ"] = "0";
                    }
                    else {
                        ht["CSTSEQ"] = txtCSTSEQ.GetValue();
                    }

                    ht["CSTACTDESC"] = txtCSTACTDESC.GetValue();
                    ht["CSTADVDESC"] = txtCSTADVDESC.GetValue();
                    ht["CSTWRSABUN"] = svCSTWRSABUN.GetValue();
                    ht["CSTWRDATE"] = txtCSTWRDATE.GetValue();

                    if (confirm('<Ctl:Text ID="MSG05" runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                        PageMethods.InvokeServiceTable(ht, "PSM.PSM1070", "UP_CHECKLIST_STRESULT_ADD", function (e) {

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                                DataGubn = "";
                                txtCSTSEQ.SetValue(DataSet.Tables[0].Rows[0]["CSTSEQ"]);

                                UP_DataBind_Run("RESULT");
                                btnSearch_Click();

                                alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                                if (opener != null && typeof (opener.checklist_popup_callback) == "function") {
                                    opener.checklist_popup_callback();
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
                else {
                    alert('<Ctl:Text runat="server" Description="평가항목을 선택 후 작업하세요." Literal="true"></Ctl:Text>');
                }
            }
        }

        // 삭제 버튼
        function btnDel_Click() {

            // 평가항목
            if ($('#tabli01').attr('class') != "") {
                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

                ht["CISBCODE"] = txtCISBCODE.GetValue();
                ht["CIGRCODE"] = txtCIGRCODE.GetValue();
                ht["CIGRSEQ"] = txtCIGRSEQ.GetValue();
                ht["CIITEMNUM"] = txtCIITEMNUM.GetValue();


                if (confirm('<Ctl:Text ID="MSG03" runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    PageMethods.InvokeServiceTable(ht, "PSM.PSM1070", "UP_CHECKLIST_DCODE_DEL", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                            if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {
                                btnNew_Click();
                                btnSearch_Click();

                                alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                                if (opener != null && typeof (opener.checklist_popup_callback) == "function") {
                                    opener.checklist_popup_callback();
                                }
                                
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
            else { // 안전조치
                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

                ht["CSTSBCODE"] = txtCSTSBCODE.GetValue();
                ht["CSTGRCODE"] = txtCSTGRCODE.GetValue();
                ht["CSTGRSEQ"] = txtCSTGRSEQ.GetValue();
                ht["CSTITEMNUM"] = txtCSTITEMNUM.GetValue();
                ht["CSTSEQ"] = txtCSTSEQ.GetValue();

                if (confirm('<Ctl:Text ID="MSG07" runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    PageMethods.InvokeServiceTable(ht, "PSM.PSM1070", "UP_CHECKLIST_STRESULT_DEL", function (e) {
    
                        btnNew_Click();
                        btnSearch_Click();

                        alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                    }, function (e) {
                        // Biz 연결오류
                        alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    });
                }
            }
        }

        // 닫기 버튼
        function btnClose_Click() {

            this.close();            
        }

        // 그리드 선택 이벤트
        function gridDCodeClick(r, c) {
            var rw = gridDCode.GetRow(r);

            DataGubn = "";
            txtCIITEMNUM.SetValue(rw["CIITEMNUM"]);

            UP_DataBind_Run("DCODE");
        }

        function gridResultClick(r, c) {
            var rw = gridResult.GetRow(r);

            DataGubn = "";
            txtCSTSEQ.SetValue(rw["CSTSEQ"]);

            UP_DataBind_Run("RESULT");
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

            <div class="tab">
                <ul class="tabnav">
                  <li><a id="tabli01" href="#tab01">평가항목</a></li>
                  <li><a id="tabli02" href="#tab02">안전조치</a></li>
                </ul>
                <div class="tabcontent">
                  <div id="tab01">
                    <table class="table_01" style="width:100%;" border="0">
                        <colgroup>
                            <col width="60px" />
                            <col width="50px" />
                            <col width="60px" />
                            <col width="170px" />
                            <col width="60px" />
                            <col width="60px" />
                            <col width="60px" />
                            <col width="60px" />
                            <col width="*" />
                        </colgroup>
                        <tr>
                            <td style="text-align:left">
                                <Ctl:Text ID="lblCISBCODE" runat="server" LangCode="lblCISBCODE" Description="사업부:" ></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="txtCISBCODE" runat="server" LangCode="txtCISBCODE" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                <Ctl:Text ID="txtCISBCODENM" runat="server" LangCode="txtCISBCODENM" Description="" ForeColor="Blue"></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="lblCIGRCODE" runat="server" LangCode="lblCIGRCODE" Description="그룹:" ></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="txtCIGRCODE" runat="server" LangCode="txtCIGRCODE" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                <Ctl:Text ID="txtCIGRCODENM" runat="server" LangCode="txtCIGRCODENM" Description="" ForeColor="Blue"></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="lblCIGRSEQ" runat="server" LangCode="lblCIGRSEQ" Description="그룹순번:" ></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="txtCIGRSEQ" runat="server" LangCode="txtCIGRSEQ" Description="" ForeColor="Blue"></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="lblCIMCNUM" runat="server" LangCode="lblCIMCNUM" Description="장치번호:" ></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="txtCIMCNUM" runat="server" LangCode="txtCIMCNUM" Description="" ForeColor="Blue"></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                            </td>
                        </tr>
                    </table>
                    <Ctl:WebSheet ID="gridDCode" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="260" TypeName="PSM.PSM1070" MethodName="UP_GET_CHECKLIST_DCODE_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                        <Ctl:SheetField DataField="CISBCODE" TextField="사업부" Description="사업부" Width="60"  HAlign="center" Align="left"  runat="server" hidden="true" OnClick="gridDCodeClick" />
                        <Ctl:SheetField DataField="CIGRCODE" TextField="그룹코드" Description="그룹코드" Width="100"  HAlign="center" Align="left"  runat="server" hidden="true" OnClick="gridDCodeClick" />
                        <Ctl:SheetField DataField="CIGRSEQ" TextField="그룹순번" Description="그룹순번" Width="150" HAlign="center" Align="left"  runat="server" hidden="true" OnClick="gridDCodeClick" />
                        <Ctl:SheetField DataField="CIITEMNUM" TextField="번호" Description="번호" Width="60" HAlign="center" Align="left"  runat="server" OnClick="gridDCodeClick" />
                        <Ctl:SheetField DataField="CIEVAITEM" TextField="평가항목" Description="평가항목" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridDCodeClick" />
                        <Ctl:SheetField DataField="CIEVASTD" TextField="평가기준" Description="평가기준" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridDCodeClick" />
                        <Ctl:SheetField DataField="CIWRSABUN" TextField="작성자" Description="작성자" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridDCodeClick" />
                        <Ctl:SheetField DataField="CIWRDATE" TextField="작성일자" Description="작성일자" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridDCodeClick" />
                    </Ctl:WebSheet>
                    <table class="table_01" style="width:100%;" border="0">
                        <colgroup>
                            <col width="100px" />
                            <col width="*" />
                        </colgroup>
                        <tr>
                            <th>
                                <Ctl:Text ID="lblCIITEMNUM" runat="server" LangCode="lblCIITEMNUM" Description="번호" ></Ctl:Text>

                            </th>
                            <td>                                          
                                <Ctl:TextBox ID="txtCIITEMNUM" Width="80px" runat="server" LangCode="txtCIITEMNUM" Description="번호" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <Ctl:Text ID="lblCIEVAITEM" runat="server" LangCode="lblCIEVAITEM" Description="평가항목" Required = "true"></Ctl:Text>
                            </th>
                            <td>
                                <Ctl:TextBox ID="txtCIEVAITEM" Width="550px" runat="server" LangCode="txtCIEVAITEM" Description="평가항목"></Ctl:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <Ctl:Text ID="lblCIEVASTD" runat="server" LangCode="lblCIEVASTD" Description="평가기준" Required = "true"></Ctl:Text>
                            </th>
                            <td>
                                <Ctl:TextBox ID="txtCIEVASTD" Width="550px" runat="server" LangCode="txtCIEVASTD" Description="평가기준"></Ctl:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <Ctl:Text ID="lblCIWRSABUN" runat="server" LangCode="lblCIWRSABUN" Description="작성자" Required = "true"></Ctl:Text>
                            </th>
                            <td>
                                <Ctl:SearchView ID="svCIWRSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                                    <Ctl:SearchViewField runat="server" DataField="KBSABUN"   TextField="KBSABUN"   Description="사 번" Hidden="false" TextBox="true" Width="100" Default="true"  />
                                    <Ctl:SearchViewField runat="server" DataField="KBHANGL" TextField="KBHANGL" Description="이 름"     Hidden="false" TextBox="true" Width="100" />                                            
                                </Ctl:SearchView>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <Ctl:Text ID="lblCIWRDATE" runat="server" LangCode="lblCIWRDATE" Description="작성일자" Required = "true"></Ctl:Text>
                            </th>
                            <td>
                                <Ctl:TextBox ID="txtCIWRDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                            </td>
                        </tr>
                    </table>
                  </div>
                    <div id="tab02">
                        <table class="table_01" style="width:100%;" border="0">
                            <colgroup>
                                <col width="60px" />
                                <col width="50px" />
                                <col width="60px" />
                                <col width="170px" />
                                <col width="60px" />
                                <col width="60px" />
                                <col width="60px" />
                                <col width="60px" />
                                <col width="60px" />
                                <col width="60px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <td style="text-align:left">
                                    <Ctl:Text ID="lblCSTSBCODE" runat="server" LangCode="lblCSTSBCODE" Description="사업부:" ></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="txtCSTSBCODE" runat="server" LangCode="txtCSTSBCODE" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                    <Ctl:Text ID="txtCSTSBCODENM" runat="server" LangCode="txtCSTSBCODENM" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="lblCSTGRCODE" runat="server" LangCode="lblCSTGRCODE" Description="그룹:" ></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="txtCSTGRCODE" runat="server" LangCode="txtCSTGRCODE" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                    <Ctl:Text ID="txtCSTGRCODENM" runat="server" LangCode="txtCSTGRCODENM" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="lblCSTGRSEQ" runat="server" LangCode="lblCSTGRSEQ" Description="그룹순번:" ></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="txtCSTGRSEQ" runat="server" LangCode="txtCSTGRSEQ" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="lblCSMCNUM" runat="server" LangCode="lblCSMCNUM" Description="장치번호:" ></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="txtCSMCNUM" runat="server" LangCode="txtCSMCNUM" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="lblCSTITEMNUM" runat="server" LangCode="lblCSTITEMNUM" Description="항목번호:" ></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="txtCSTITEMNUM" runat="server" LangCode="txtCSTITEMNUM" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:left">
                                    <Ctl:Text ID="lblCIEVAITEM2" runat="server" LangCode="lblCIEVAITEM2" Description="평가항목:" ></Ctl:Text>
                                </td>
                                <td colspan="10" style="text-align:left">
                                    <Ctl:Text ID="txtCIEVAITEM2" runat="server" LangCode="txtCIEVAITEM2" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:left">
                                    <Ctl:Text ID="lblCIEVASTD2" runat="server" LangCode="lblCIEVASTD2" Description="평가기준:" ></Ctl:Text>
                                </td>
                                <td colspan="10" style="text-align:left">
                                    <Ctl:Text ID="txtCIEVASTD2" runat="server" LangCode="txtCIEVASTD2" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                            </tr>
                        </table>
                        <Ctl:WebSheet ID="gridResult" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="200" TypeName="PSM.PSM1070" MethodName="UP_GET_CHECKLIST_STRESULT_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="CSTSBCODE" TextField="사업부" Description="사업부" Width="60"  HAlign="center" Align="left"  runat="server" hidden="true" OnClick="gridResultClick" />
                            <Ctl:SheetField DataField="CSTGRCODE" TextField="그룹코드" Description="그룹코드" Width="100"  HAlign="center" Align="left"  runat="server" hidden="true" OnClick="gridResultClick" />
                            <Ctl:SheetField DataField="CSTGRSEQ" TextField="그룹순번" Description="그룹순번" Width="150" HAlign="center" Align="left"  runat="server" hidden="true" OnClick="gridResultClick" />
                            <Ctl:SheetField DataField="CSTITEMNUM" TextField="항목번호" Description="항목번호" Width="60" HAlign="center" Align="left"  runat="server" hidden="true" OnClick="gridResultClick" />
                            <Ctl:SheetField DataField="CSTSEQ" TextField="번호" Description="번호" Width="60" HAlign="center" Align="left"  runat="server" OnClick="gridResultClick" />
                            <Ctl:SheetField DataField="CSTACTDESC" TextField="안전조치" Description="안전조치" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridResultClick" />
                            <Ctl:SheetField DataField="CSTADVDESC" TextField="권고사항" Description="권고사항" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridResultClick" />
                            <Ctl:SheetField DataField="CSTWRSABUN" TextField="작성자" Description="작성자" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridResultClick" />
                            <Ctl:SheetField DataField="CSTWRDATE" TextField="작성일자" Description="작성일자" Width="100" HAlign="center" Align="left"  runat="server" OnClick="gridResultClick" />
                        </Ctl:WebSheet>
                        <table class="table_01" style="width:100%;" border="0">
                            <colgroup>
                                <col width="100px" />
                                <col width="*" />
                            </colgroup>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblCSTSEQ" runat="server" LangCode="lblCSTSEQ" Description="번호" ></Ctl:Text>

                                </th>
                                <td>                                          
                                    <Ctl:TextBox ID="txtCSTSEQ" Width="80px" runat="server" LangCode="txtCSTSEQ" Description="번호" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblCSTACTDESC" runat="server" LangCode="lblCSTACTDESC" Description="안전조치" Required = "true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtCSTACTDESC" Width="550px" runat="server" LangCode="txtCSTACTDESC" Description="안전조치"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblCSTADVDESC" runat="server" LangCode="lblCSTADVDESC" Description="권고사항" ></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtCSTADVDESC" Width="550px" runat="server" LangCode="txtCSTADVDESC" Description="권고사항"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblCSTWRSABUN" runat="server" LangCode="lblCSTWRSABUN" Description="작성자" Required = "true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:SearchView ID="svCSTWRSABUN" runat="server" TypeName="PSM.PSMBiz" MethodName="UP_KBSABUN_LIST" Params="{'PageSize':10}" PagingSize="10" PlaceHolder="" ReadMode="false"  >
                                        <Ctl:SearchViewField runat="server" DataField="KBSABUN"   TextField="KBSABUN"   Description="사 번" Hidden="false" TextBox="true" Width="100" Default="true"  />
                                        <Ctl:SearchViewField runat="server" DataField="KBHANGL" TextField="KBHANGL" Description="이 름"     Hidden="false" TextBox="true" Width="100" />                                            
                                    </Ctl:SearchView>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblCSTWRDATE" runat="server" LangCode="lblCSTWRDATE" Description="작성일자" Required = "true"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtCSTWRDATE" runat="server" SetCalendarFormat="YYYYMMDD" SetType="Calendar"></Ctl:TextBox> 
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div><!--tab-->
		</Ctl:Layer>
	</div>
</asp:content>