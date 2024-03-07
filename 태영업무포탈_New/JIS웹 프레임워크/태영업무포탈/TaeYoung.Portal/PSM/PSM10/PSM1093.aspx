<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1093.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1093" %>

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

            if (data.length == 7) {

                DataGubn = "";

                txtJSRBLASS.SetValue(data[0]);
                //txtJSRBLASSNM.SetValue(data[1]);
                txtJSRMLASS.SetValue(data[1]);
                //txtJSRMLASSNM.SetValue(data[3]);
                txtJSRSLASS.SetValue(data[2]);
                //txtJSRSLASSNM.SetValue(data[5]);
                txtJSRSEQ.SetValue(data[3]);
                //txtJSMWKNAME.SetValue(data[7]);
                txtJSRITEMSEQ.SetValue(data[4]);
                //txtJSDITEMTEXT.SetValue(data[9]);

                txtJSEBLASS.SetValue(data[0]);
                //txtJSEBLASSNM.SetValue(data[1]);
                txtJSEMLASS.SetValue(data[1]);
                //txtJSEMLASSNM.SetValue(data[3]);
                txtJSESLASS.SetValue(data[2]);
                //txtJSESLASSNM.SetValue(data[5]);
                txtJSESEQ.SetValue(data[3]);
                //txtJSEWKNAME.SetValue(data[7]);
                txtJSEITEMSEQ.SetValue(data[4]);
                //txtJSEITEMTEXT.SetValue(data[9]);

                if (data[6] == "RISK") {
                    if (data[5] != "99999") {
                        txtJSRSUBSEQ.SetValue(data[5]);
                    }
                }
                else {
                    if (data[5] != "99999") {
                        txtJSESUBSEQ.SetValue(data[5]);
                    }
                }

                UP_DataDetailBind();

                ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                ht["JSDBLASS"] = txtJSRBLASS.GetValue();
                ht["JSDMLASS"] = txtJSRMLASS.GetValue();
                ht["JSDSLASS"] = txtJSRSLASS.GetValue();
                ht["JSDSEQ"] = txtJSRSEQ.GetValue();
                ht["JSDITEMSEQ"] = txtJSRITEMSEQ.GetValue();

                gridRisk.Params(ht); // 선언한 파라미터를 그리드에 전달함
                gridRisk.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                gridReform.Params(ht); // 선언한 파라미터를 그리드에 전달함
                gridReform.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

                tabControl(data[6]);

                UP_DataBind_Run(data[6]);
            }
        }

        function tabControl(gubun) {

            if (gubun == "RISK") {
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

        // JSA 내역 조회
        function UP_DataDetailBind() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.  

            ht["JSDBLASS"] = txtJSRBLASS.GetValue();
            ht["JSDMLASS"] = txtJSRMLASS.GetValue();
            ht["JSDSLASS"] = txtJSRSLASS.GetValue();
            ht["JSDSEQ"] = txtJSRSEQ.GetValue();
            ht["JSDITEMSEQ"] = txtJSRITEMSEQ.GetValue();

            PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_DETAIL_RUN", function (e) {

                var DataSet = eval(e);

                if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                    txtJSRBLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JBCODE"]);
                    txtJSRMLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JMCODE"]);
                    txtJSRSLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JSCODE"]);
                    txtJSMWKNAME.SetValue(DataSet.Tables[0].Rows[0]["JSMWKNAME"]);
                    txtJSDITEMTEXT.SetValue(DataSet.Tables[0].Rows[0]["JSDITEMTEXT"]);
                        
                    txtJSEBLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JBCODE"]);
                    txtJSEMLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JMCODE"]);
                    txtJSESLASSNM.SetValue(DataSet.Tables[0].Rows[0]["JSCODE"]);
                    txtJSEWKNAME.SetValue(DataSet.Tables[0].Rows[0]["JSMWKNAME"]);
                    txtJSEITEMTEXT.SetValue(DataSet.Tables[0].Rows[0]["JSDITEMTEXT"]);

                }

            }, function (e) {
                // Biz 연결오류
                alert("Error");
            });
        }

        // 데이터 바인딩
        function UP_DataBind_Run(gubun) {

            if (gubun == "RISK") {
                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.  

                if (txtJSRSUBSEQ.GetValue() != "") {

                    ht["JSRBLASS"] = txtJSRBLASS.GetValue();
                    ht["JSRMLASS"] = txtJSRMLASS.GetValue();
                    ht["JSRSLASS"] = txtJSRSLASS.GetValue();
                    ht["JSRSEQ"] = txtJSRSEQ.GetValue();
                    ht["JSRITEMSEQ"] = txtJSRITEMSEQ.GetValue();
                    ht["JSRSUBSEQ"] = txtJSRSUBSEQ.GetValue();

                    PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_RISK_RUN", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                            txtJSRSUBSEQ.SetValue(DataSet.Tables[0].Rows[0]["JSRSUBSEQ"]);
                            txtJSRRISKTEXT.SetValue(DataSet.Tables[0].Rows[0]["JSRRISKTEXT"]);
                            txtJSRRISKCNT.SetValue(DataSet.Tables[0].Rows[0]["JSRRISKCNT"]);
                            txtJSRRISKSOLID.SetValue(DataSet.Tables[0].Rows[0]["JSRRISKSOLID"]);
                            txtJSRRISKDEGREE.SetValue(DataSet.Tables[0].Rows[0]["JSRRISKDEGREE"]);

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
            else {
                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.   

                if (txtJSESUBSEQ.GetValue() != "") {

                    ht["JSEBLASS"] = txtJSEBLASS.GetValue();
                    ht["JSEMLASS"] = txtJSEMLASS.GetValue();
                    ht["JSESLASS"] = txtJSESLASS.GetValue();
                    ht["JSESEQ"] = txtJSESEQ.GetValue();
                    ht["JSEITEMSEQ"] = txtJSEITEMSEQ.GetValue();
                    ht["JSESUBSEQ"] = txtJSESUBSEQ.GetValue();

                    PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_REFORM_RUN", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                            txtJSESUBSEQ.SetValue(DataSet.Tables[0].Rows[0]["JSESUBSEQ"]);
                            txtJSEREFORMTEXT.SetValue(DataSet.Tables[0].Rows[0]["JSEREFORMTEXT"]);
                            txtJSEREFORMCNT.SetValue(DataSet.Tables[0].Rows[0]["JSEREFORMCNT"]);
                            txtJSEREFORMSOLID.SetValue(DataSet.Tables[0].Rows[0]["JSEREFORMSOLID"]);
                            txtJSEREFORMDEGREE.SetValue(DataSet.Tables[0].Rows[0]["JSEREFORMDEGREE"]);

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

            ht["JSDBLASS"] = txtJSRBLASS.GetValue();
            ht["JSDMLASS"] = txtJSRMLASS.GetValue();
            ht["JSDSLASS"] = txtJSRSLASS.GetValue();
            ht["JSDSEQ"] = txtJSRSEQ.GetValue();
            ht["JSDITEMSEQ"] = txtJSRITEMSEQ.GetValue();

            if ($('#tabli01').attr('class') != "") {

                gridRisk.Params(ht); // 선언한 파라미터를 그리드에 전달함
                gridRisk.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
            }
            else {

                gridReform.Params(ht); // 선언한 파라미터를 그리드에 전달함
                gridReform.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
            }
        }

        // 신규 버튼
        function btnNew_Click()
        {
            if ($('#tabli01').attr('class') != "") {

                txtJSRSUBSEQ.SetValue("");
                txtJSRRISKTEXT.SetValue("");
                txtJSRRISKCNT.SetValue("");
                txtJSRRISKSOLID.SetValue("");
                txtJSRRISKDEGREE.SetValue("");}
            else {

                txtJSESUBSEQ.SetValue("");
                txtJSEREFORMTEXT.SetValue("");
                txtJSEREFORMCNT.SetValue("");
                txtJSEREFORMSOLID.SetValue("");
                txtJSEREFORMDEGREE.SetValue("");
            }

            DataGubn = "ADD";

            btnDel.Hide();
        }

        // 저장 버튼
        function btnSave_Click() {         

            // 위험성
            if ($('#tabli01').attr('class') != "") {
                if (txtJSRBLASS.GetValue() != "" && txtJSRMLASS.GetValue() != "" && txtJSRSLASS.GetValue() != "" && txtJSRSEQ.GetValue() != "" && txtJSRITEMSEQ.GetValue() != "") {
                    if (txtJSRRISKTEXT.GetValue() == "" || txtJSRRISKTEXT.GetValue() == null) {
                        alert('<Ctl:Text runat="server" Description="위험성을 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                    ht["JSRBLASS"] = txtJSRBLASS.GetValue();
                    ht["JSRMLASS"] = txtJSRMLASS.GetValue();
                    ht["JSRSLASS"] = txtJSRSLASS.GetValue();
                    ht["JSRSEQ"] = txtJSRSEQ.GetValue();
                    ht["JSRITEMSEQ"] = txtJSRITEMSEQ.GetValue();

                    if (DataGubn == 'ADD' || txtJSRSUBSEQ.GetValue() == "") {
                        ht["JSRSUBSEQ"] = "0";
                    }
                    else {
                        ht["JSRSUBSEQ"] = txtJSRSUBSEQ.GetValue();
                    }

                    ht["JSRRISKTEXT"] = txtJSRRISKTEXT.GetValue();

                    if (txtJSRRISKCNT.GetValue() == "") {
                        ht["JSRRISKCNT"] = "0";
                    }
                    else {
                        ht["JSRRISKCNT"] = txtJSRRISKCNT.GetValue();
                    }
                    if (txtJSRRISKSOLID.GetValue() == "") {
                        ht["JSRRISKSOLID"] = "0";
                    }
                    else {
                        ht["JSRRISKSOLID"] = txtJSRRISKSOLID.GetValue();
                    }
                    if (txtJSRRISKDEGREE.GetValue() == "") {
                        ht["JSRRISKDEGREE"] = "0";
                    }
                    else {
                        ht["JSRRISKDEGREE"] = txtJSRRISKDEGREE.GetValue();
                    }


                    if (confirm('<Ctl:Text ID="MSG02" runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                        PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_RISK_ADD", function (e) {

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                                DataGubn = "";
                                txtJSRSUBSEQ.SetValue(DataSet.Tables[0].Rows[0]["JSRSUBSEQ"]);

                                UP_DataBind_Run("RISK");
                                btnSearch_Click();

                                alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                                if (opener != null && typeof (opener.jsa_popup_callback) == "function") {
                                    opener.jsa_popup_callback();
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
                    alert('<Ctl:Text runat="server" Description="작업단계를 등록 후 작업하세요." Literal="true"></Ctl:Text>');
                }
            }
            else {  // 개선대책
                if (txtJSEBLASS.GetValue() != "" && txtJSEMLASS.GetValue() != "" && txtJSESLASS.GetValue() != "" && txtJSESEQ.GetValue() != "" && txtJSEITEMSEQ.GetValue() != "") {

                    if (txtJSEREFORMTEXT.GetValue() == "" || txtJSEREFORMTEXT.GetValue() == null) {
                        alert('<Ctl:Text runat="server" Description="개선대책을 입력하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

                    ht["JSEBLASS"] = txtJSEBLASS.GetValue();
                    ht["JSEMLASS"] = txtJSEMLASS.GetValue();
                    ht["JSESLASS"] = txtJSESLASS.GetValue();
                    ht["JSESEQ"] = txtJSESEQ.GetValue();
                    ht["JSEITEMSEQ"] = txtJSEITEMSEQ.GetValue();

                    if (DataGubn == 'ADD' || txtJSESUBSEQ.GetValue() == "") {
                        ht["JSESUBSEQ"] = "0";
                    }
                    else {
                        ht["JSESUBSEQ"] = txtJSESUBSEQ.GetValue();
                    }

                    ht["JSEREFORMTEXT"] = txtJSEREFORMTEXT.GetValue();

                    if (txtJSEREFORMCNT.GetValue() == "") {
                        ht["JSEREFORMCNT"] = "0";
                    }
                    else {
                        ht["JSEREFORMCNT"] = txtJSEREFORMCNT.GetValue();
                    }
                    if (txtJSEREFORMSOLID.GetValue() == "") {
                        ht["JSEREFORMSOLID"] = "0";
                    }
                    else {
                        ht["JSEREFORMSOLID"] = txtJSEREFORMSOLID.GetValue();
                    }
                    if (txtJSEREFORMDEGREE.GetValue() == "") {
                        ht["JSEREFORMDEGREE"] = "0";
                    }
                    else {
                        ht["JSEREFORMDEGREE"] = txtJSEREFORMDEGREE.GetValue();
                    }

                    if (confirm('<Ctl:Text ID="MSG05" runat="server" Description="저장 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                        PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_REFORM_ADD", function (e) {

                            var DataSet = eval(e);

                            if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                                DataGubn = "";
                                txtJSESUBSEQ.SetValue(DataSet.Tables[0].Rows[0]["JSESUBSEQ"]);

                                UP_DataBind_Run("REFORM");
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
                else {
                    alert('<Ctl:Text runat="server" Description="작업단계를 등록 후 작업하세요." Literal="true"></Ctl:Text>');
                }
            }
        }

        // 삭제 버튼
        function btnDel_Click() {

            // 위험성
            if ($('#tabli01').attr('class') != "") {
                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

                ht["JSRBLASS"] = txtJSRBLASS.GetValue();
                ht["JSRMLASS"] = txtJSRMLASS.GetValue();
                ht["JSRSLASS"] = txtJSRSLASS.GetValue();
                ht["JSRSEQ"] = txtJSRSEQ.GetValue();
                ht["JSRITEMSEQ"] = txtJSRITEMSEQ.GetValue();
                ht["JSRSUBSEQ"] = txtJSRSUBSEQ.GetValue();

                if (confirm('<Ctl:Text runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_RISK_DEL", function (e) {

                        btnNew_Click();
                        btnSearch_Click();

                        alert('<Ctl:Text runat="server" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');

                    }, function (e) {
                        // Biz 연결오류
                        alert('<Ctl:Text runat="server" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    });
                }
            }
            else { // 개선대책
                var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.            

                ht["JSEBLASS"] = txtJSEBLASS.GetValue();
                ht["JSEMLASS"] = txtJSEMLASS.GetValue();
                ht["JSESLASS"] = txtJSESLASS.GetValue();
                ht["JSESEQ"] = txtJSESEQ.GetValue();
                ht["JSEITEMSEQ"] = txtJSEITEMSEQ.GetValue();
                ht["JSESUBSEQ"] = txtJSESUBSEQ.GetValue();

                if (confirm('<Ctl:Text runat="server" Description="삭제 하시겠습니까?" Literal="true"></Ctl:Text>') == true) {

                    PageMethods.InvokeServiceTable(ht, "PSM.PSM1090", "UP_JSA_REFORM_DEL", function (e) {
    
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
        function gridRiskClick(r, c) {
            var rw = gridRisk.GetRow(r);

            DataGubn = "";
            txtJSRSUBSEQ.SetValue(rw["JSRSUBSEQ"]);

            UP_DataBind_Run("RISK");
        }

        function gridReformClick(r, c) {
            var rw = gridReform.GetRow(r);

            DataGubn = "";
            txtJSESUBSEQ.SetValue(rw["JSESUBSEQ"]);

            UP_DataBind_Run("REFORM");
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
                  <li><a id="tabli01" href="#tab01">위험성</a></li>
                  <li><a id="tabli02" href="#tab02">개선대책</a></li>
                </ul>
                <div class="tabcontent">
                  <div id="tab01">
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
                                <Ctl:Text ID="lblJSRBLASS" runat="server" LangCode="lblCISBCODE" Description="대분류" ></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="txtJSRBLASS" runat="server" LangCode="txtJSRBLASS" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                <Ctl:Text ID="txtJSRBLASSNM" runat="server" LangCode="txtJSRBLASSNM" Description="" ForeColor="Blue"></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="lblJSRMLASS" runat="server" LangCode="lblCIGRCODE" Description="중분류" ></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="txtJSRMLASS" runat="server" LangCode="txtJSRMLASS" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                <Ctl:Text ID="txtJSRMLASSNM" runat="server" LangCode="txtJSRMLASSNM" Description="" ForeColor="Blue"></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="lblJSRSLASS" runat="server" LangCode="lblJSRSLASS" Description="소분류" ></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="txtJSRSLASS" runat="server" LangCode="txtJSRSLASS" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                <Ctl:Text ID="txtJSRSLASSNM" runat="server" LangCode="txtJSRSLASSNM" Description="" ForeColor="Blue"></Ctl:Text>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:left">
                                <Ctl:Text ID="lblJSMWKNAME" runat="server" LangCode="lblCISBCODE" Description="작업명" ></Ctl:Text>
                            </td>
                            <td colspan="3" style="text-align:left">
                                <Ctl:Text ID="txtJSRSEQ" runat="server" LangCode="txtJSRSEQ" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                <Ctl:Text ID="txtJSMWKNAME" runat="server" LangCode="txtJSMWKNAME" Description="" ForeColor="Blue"></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="lblJSDITEMTEXT" runat="server" LangCode="lblCIGRCODE" Description="작업단계" ></Ctl:Text>
                            </td>
                            <td style="text-align:left">
                                <Ctl:Text ID="txtJSRITEMSEQ" runat="server" LangCode="txtJSRITEMSEQ" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                <Ctl:Text ID="txtJSDITEMTEXT" runat="server" LangCode="txtJSDITEMTEXT" Description="" ForeColor="Blue"></Ctl:Text>
                            </td>
                        </tr>
                    </table>
                    <Ctl:WebSheet ID="gridRisk" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="260" TypeName="PSM.PSM1090" MethodName="UP_JSA_RISK_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                        <Ctl:SheetField DataField="JBCODE" TextField="대분류코드" Description="대분류코드" Width="60"  HAlign="center" Align="left" runat="server" hidden="true" />
                        <Ctl:SheetField DataField="JMCODE" TextField="중분류코드" Description="중분류코드" Width="60"  HAlign="center" Align="left" runat="server" hidden="true" />
                        <Ctl:SheetField DataField="JSCODE" TextField="소분류코드" Description="소분류코드" Width="60"  HAlign="center" Align="left" runat="server" hidden="true" />
                        <Ctl:SheetField DataField="JSDITEMTEXT" TextField="작업명" Description="작업명" Width="60"  HAlign="center" Align="left"  runat="server" hidden="true" />
                        <Ctl:SheetField DataField="JSRSUBSEQ" TextField="순번" Description="순번" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="gridRiskClick" />
                        <Ctl:SheetField DataField="JSRRISKTEXT" TextField="위험성" Description="위험성" Width="*"  HAlign="center" Align="left"  runat="server" OnClick="gridRiskClick" />
                        <Ctl:SheetField DataField="JSRRISKCNT" TextField="빈도" Description="빈도" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridRiskClick" />
                        <Ctl:SheetField DataField="JSRRISKSOLID" TextField="강도" Description="강도" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridRiskClick" />
                        <Ctl:SheetField DataField="JSRRISKDEGREE" TextField="위험성" Description="위험성" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridRiskClick" />
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
                                <Ctl:Text ID="lblJSRSUBSEQ" runat="server" LangCode="lblJSRSUBSEQ" Description="순번" ></Ctl:Text>

                            </th>
                            <td colspan="5">                                          
                                <Ctl:TextBox ID="txtJSRSUBSEQ" Width="80px" runat="server" LangCode="txtJSRSUBSEQ" Description="순번" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <Ctl:Text ID="lblJSRRISKTEXT" runat="server" LangCode="lblJSRRISKTEXT" Description="위험성" Required = "true"></Ctl:Text>
                            </th>
                            <td colspan="5">
                                <Ctl:TextBox ID="txtJSRRISKTEXT" Width="550px" runat="server" LangCode="txtJSRRISKTEXT" Description="위험성"></Ctl:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                <Ctl:Text ID="lblJSRRISKCNT" runat="server" LangCode="lblJSRRISKCNT" Description="빈도"></Ctl:Text>
                            </th>
                            <td>
                                <Ctl:TextBox ID="txtJSRRISKCNT" Width="100px" runat="server" LangCode="txtJSRRISKCNT" Description="빈도" MaxLength="1"></Ctl:TextBox>
                            </td>
                            <th>
                                <Ctl:Text ID="lblJSRRISKSOLID" runat="server" LangCode="lblJSRRISKSOLID" Description="강도"></Ctl:Text>
                            </th>
                            <td>
                                <Ctl:TextBox ID="txtJSRRISKSOLID" Width="100px" runat="server" LangCode="txtJSRRISKSOLID" Description="강도" MaxLength="1"></Ctl:TextBox>
                            </td>
                            <th>
                                <Ctl:Text ID="lblJSRRISKDEGREE" runat="server" LangCode="lblJSRRISKDEGREE" Description="위험도"></Ctl:Text>
                            </th>
                            <td>
                                <Ctl:TextBox ID="txtJSRRISKDEGREE" Width="100px" runat="server" LangCode="txtJSRRISKDEGREE" Description="위험도" MaxLength="1"></Ctl:TextBox>
                            </td>
                        </tr>
                    </table>
                  </div>
                    <div id="tab02">
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
                                    <Ctl:Text ID="lblJSEBLASS" runat="server" LangCode="lblJSEBLASS" Description="대분류" ></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="txtJSEBLASS" runat="server" LangCode="txtJSEBLASS" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                    <Ctl:Text ID="txtJSEBLASSNM" runat="server" LangCode="txtJSEBLASSNM" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="lblJSEMLASS" runat="server" LangCode="lblJSEMLASS" Description="중분류" ></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="txtJSEMLASS" runat="server" LangCode="txtJSEMLASS" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                    <Ctl:Text ID="txtJSEMLASSNM" runat="server" LangCode="txtJSEMLASSNM" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="lblJSESLASS" runat="server" LangCode="lblJSESLASS" Description="소분류" ></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="txtJSESLASS" runat="server" LangCode="txtJSESLASS" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                    <Ctl:Text ID="txtJSESLASSNM" runat="server" LangCode="txtJSESLASSNM" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:left">
                                    <Ctl:Text ID="lblJSESEQ" runat="server" LangCode="lblJSESEQ" Description="작업명" ></Ctl:Text>
                                </td>
                                <td colspan="3" style="text-align:left">
                                    <Ctl:Text ID="txtJSESEQ" runat="server" LangCode="txtJSESEQ" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                    <Ctl:Text ID="txtJSEWKNAME" runat="server" LangCode="txtJSEWKNAME" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="lblJSEITEMSEQ" runat="server" LangCode="lblJSEITEMSEQ" Description="작업단계" ></Ctl:Text>
                                </td>
                                <td style="text-align:left">
                                    <Ctl:Text ID="txtJSEITEMSEQ" runat="server" LangCode="txtJSEITEMSEQ" Description="" ForeColor="Blue" hidden="true"></Ctl:Text>
                                    <Ctl:Text ID="txtJSEITEMTEXT" runat="server" LangCode="txtJSEITEMTEXT" Description="" ForeColor="Blue"></Ctl:Text>
                                </td>
                            </tr>
                        </table>
                        <Ctl:WebSheet ID="gridReform" runat="server" Paging="false" CheckBox="false" Width="100%" HFixation="true" Height="260" TypeName="PSM.PSM1090" MethodName="UP_JSA_REFORM_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="20">
                            <Ctl:SheetField DataField="JBCODE" TextField="대분류코드" Description="대분류코드" Width="60"  HAlign="center" Align="left"  runat="server" hidden="true" />
                            <Ctl:SheetField DataField="JMCODE" TextField="중분류코드" Description="중분류코드" Width="100"  HAlign="center" Align="left"  runat="server" hidden="true" />
                            <Ctl:SheetField DataField="JSCODE" TextField="소분류코드" Description="소분류코드" Width="150" HAlign="center" Align="left"  runat="server" hidden="true" />
                            <Ctl:SheetField DataField="JSDITEMTEXT" TextField="작업명" Description="작업명" Width="60" HAlign="center" Align="left"  runat="server" hidden="true" />
                            <Ctl:SheetField DataField="JSESUBSEQ" TextField="순번" Description="순번" Width="60" HAlign="center" Align="left"  runat="server" OnClick="gridReformClick" />
                            <Ctl:SheetField DataField="JSEREFORMTEXT" TextField="개선대첵" Description="개선대첵" Width="*" HAlign="center" Align="left"  runat="server" OnClick="gridReformClick" />
                            <Ctl:SheetField DataField="JSEREFORMCNT" TextField="빈도" Description="빈도" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridReformClick" />
                            <Ctl:SheetField DataField="JSEREFORMSOLID" TextField="강도" Description="강도" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridReformClick" />
                            <Ctl:SheetField DataField="JSEREFORMDEGREE" TextField="위험도" Description="위험도" Width="80" HAlign="center" Align="left"  runat="server" OnClick="gridReformClick" />
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
                                    <Ctl:Text ID="lblJSESUBSEQ" runat="server" LangCode="lblCSTSEQ" Description="순번" ></Ctl:Text>

                                </th>
                                <td colspan="5">                                          
                                    <Ctl:TextBox ID="txtJSESUBSEQ" Width="80px" runat="server" LangCode="txtJSESUBSEQ" Description="순번" ReadOnly="true" PlaceHolder ="자동부여"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblJSEREFORMTEXT" runat="server" LangCode="lblJSEREFORMTEXT" Description="개선대책" Required = "true"></Ctl:Text>
                                </th>
                                <td colspan="5">
                                    <Ctl:TextBox ID="txtJSEREFORMTEXT" Width="550px" runat="server" LangCode="txtJSEREFORMTEXT" Description="개선대책"></Ctl:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <Ctl:Text ID="lblJSEREFORMCNT" runat="server" LangCode="lblJSEREFORMCNT" Description="빈도"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtJSEREFORMCNT" Width="100px" runat="server" LangCode="txtJSEREFORMCNT" Description="빈도" MaxLength="1"></Ctl:TextBox>
                                </td>
                                <th>
                                    <Ctl:Text ID="lblJSEREFORMSOLID" runat="server" LangCode="lblJSEREFORMSOLID" Description="강도"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtJSEREFORMSOLID" Width="100px" runat="server" LangCode="txtJSEREFORMSOLID" Description="강도" MaxLength="1"></Ctl:TextBox>
                                </td>
                                <th>
                                    <Ctl:Text ID="lblJSEREFORMDEGREE" runat="server" LangCode="lblJSEREFORMDEGREE" Description="위험도"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:TextBox ID="txtJSEREFORMDEGREE" Width="100px" runat="server" LangCode="txtJSEREFORMDEGREE" Description="위험도" MaxLength="1"></Ctl:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div><!--tab-->
		</Ctl:Layer>
	</div>
</asp:content>