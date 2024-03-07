/******************************************************************************************
* JS명   : Org.js
* 설  명 : 조직도 검색을 위한 Javascript
* 작성일 : 2014-11-24
* 작성자 : 장경환
******************************************************************************************/
// 조직검색결과 칼럼 정의
var __org_Columns = ["DEPTNAME", "DUTYNAME", "RANKNAME", "USERNAME", "JOBDESC", "EMAIL", "EMPID", "COMPANYCODE", "EXTENSIONNUMBER", "ORGCOMCODE"];
var __org_Columns_Align = ["","", "", "", "left", "", "", "", "", ""];
var __org_Columns_Hidden = [false,true, false, false, false, false, true, true, false, true];
var _KEY = "SJ00";

var __mail_url = "https://mail.google.com/mail/u/0/?view=cm";
var __post_url = "/GW/Post/Popup/PP0101011.aspx";

function treeEDMS1_Loaded() {
    treeMenu1.Search("--")[0].ChildOpen();
}
function treeEDMS2_Loaded() {
    treeMenu2.Search("--")[0].ChildOpen();
}
function treeEDMS3_Loaded() {
    treeMenu3.Search("--")[0].ChildOpen();
}

function treeEDMS_click(o, s) {
    var objValue = ObjectMaxValue(s.Item.Values);
    var node_type = "";
    var tree_type = "";

    if (s.Item.Values.length < 6) {
        node_type = s.Item.Values[3];
        tree_type = s.Item.Values[4];
    } else {
        node_type = s.Item.Values[s.Item.Values.length-2];
        tree_type = s.Item.Values[s.Item.Values.length-1];
    }

    if (node_type == "F") {
        s.Item.ChildOpen();
    }
    else if (s.Item.Values[objValue].startsWith("ShowPopup")) {
        eval(s.Item.Values[objValue]);
    }
    else if (s.Item.Values[objValue].startsWith("Location")) {
        eval(s.Item.Values[objValue]);
    }
    else {
        if (location.href.toString().indexOf("ED0102020") == -1) {
            location.href = "./ED0102020.aspx";
        }

        PageProgressShow();

        setList(cboEdms.GetValue(), tree_type, s.Item.Values[0]);
        TXT01.SetValue("<h4>" + Title.GetValue() + "(" + document.getElementById("leftmenu_bx").querySelector("ul[class=title_02] a[class=on]").innerText + "-" + s.Item.Text + ")</h4>");
    }
}

function cboEdms_Change() {
    $("#treeMenu2 .myTreeCSS").remove();
    $("#treeMenu3 .myTreeCSS").remove();
    treeMenu2.BindTree();
    treeMenu3.BindTree();
}

/******************************************************************************************
* 함수명 : treeOrg_Loaded 
* 설  명 : 트리 로드 완료 후 이벤트
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function treeOrg_Loaded() {
    treeOrg.AllChildClose();
    var itemList = treeOrg.Search(DEPTCD);
    if (itemList.length > 0) {
        itemList[0].Select();
        bindGridInit(DEPTCD, "");
    }
    //bindcboGrp();
}

/******************************************************************************************
* 함수명 : treeOrg_click 
* 설  명 : 트리 부서 클릭
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function treeOrg_click(o, s) {
    common_search_org.SetValue("");
    var deptcd = s.Item.Values[0];
    var searchString = common_search_org.GetValue();

    bindGrid(deptcd, searchString);
}

/******************************************************************************************
* 함수명 : gridOrg_RowClick 
* 설  명 : 조직검색 결과 row 클릭
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function gridOrg_RowClick(obj) {
    var tr = obj.parentElement;

    OrgPopup(tr.cells[6].innerText, tr.cells[7].innerText);
}

/******************************************************************************************
* 함수명 : OrgPopup 
* 설  명 : 사용자 조직정보 검색
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function OrgPopup(empid, companycode, fw) {
    if (empid == "" || empid == null || empid == undefined || empid == "undefined") return;
    if (fw) {
        if (event == undefined || event == null) {
            var x = $("body").width() / 2;
            var y = $("body").height() / 2;
            x = (x + 400) > $("body").width() ? $("body").width() - 400 : x;
            y = (y + 250) > $("body").height() ? $("body").height() - 250 : y;
            grdOrgUser_SetPosition(x, y);
        } else {
            var x = (event.pageX + 400) > $("body").width() ? $("body").width() - 400 : event.pageX;
            var y = (event.pageY + 250) > $("body").height() ? $("body").height() - 250 : event.pageY;
            grdOrgUser_SetPosition(x, y);
        }
    }
    else {
        // iframe안에 위치함으로 위치를 고정시킨다
        grdOrgUser_SetPosition(200, 40);
    }
    
    //grdOrgUser_SetPosition(200, 40);

    var ht = new Object();
    ht["EMPID"] = empid;
    //ht["COMPANYCODE"] = "1000";
    //ht["LANGCODE"] = "ko";
    ht["COMPANYCODE"] = companycode;// $("#cboOrg").val();
    ht["LANGCODE"] = Use_Language;

    PageMethods.InvokeServiceTable(ht, "Common.OrgChartBiz", "GetUserInfo", bindUser_Callback);
}

/******************************************************************************************
* 함수명 : bindUser_Callback 
* 설  명 : 조직정보 바인딩
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function bindUser_Callback(e) {
    var ds = eval(e);

    if(ds.Tables[0].Rows.length < 1 || ds == undefined){
        alert('오류');
        return;
    }
    if (ds.Tables[0].Rows[0]["EMPID"] != "") { // 사진처리부
        //document.getElementById("divOrgUser_photo").style.background = "url(/Resources/Framework/OrgImageViewer.aspx?id=" + ds.Tables[0].Rows[0]["EMPID"].trim() + ") no-repeat";
        //document.getElementById("divOrgUser_photo").style.backgroundSize = "100% 100%";
        //document.getElementById("divOrgUser_photo").style.backgroundPosition = "center top";
    }
    else {
        //document.getElementById("divOrgUser_photo").style.background = "url(/Resources/Images/none_user_photo2.png) no-repeat"; // no-repeat;width:100%;height:100%;'></div>";
        //document.getElementById("divOrgUser_photo").style.backgroundPosition = "center top";
    }

    document.getElementById("divOrgUser_Name").innerText = ds.Tables[0].Rows[0]["DISPLAYNAME"];
    document.getElementById("divOrgUser_Company").innerText = ds.Tables[0].Rows[0]["COMPANYNAME"];
    document.getElementById("divOrgUser_Dept").innerText = ds.Tables[0].Rows[0]["MAINDEPTNAME"];

    //회장,부회장,사장 공백처리
    var RankText = '';
    if(ds.Tables[0].Rows[0]["EMPID"] == 'A2150403' || ds.Tables[0].Rows[0]["EMPID"] == 'A2040401' || ds.Tables[0].Rows[0]["EMPID"] == 'A2061002')
        RankText = ''
    else
        RankText = NullString(ds.Tables[0].Rows[0]["DUTYNAME"]) + " / " + NullString(ds.Tables[0].Rows[0]["RANKNAME"]);

    document.getElementById("divOrgUser_Rank").innerText = RankText;
    //document.getElementById("divOrgUser_Job").innerText = NullString(ds.Tables[0].Rows[0]["JOBNAME"]);
    document.getElementById("divOrgUser_Job").innerText = "";
    document.getElementById("divOrgUser_Mail").innerText = NullString(ds.Tables[0].Rows[0]["EMAIL"]);
    document.getElementById("divOrgUser_Tel1").innerText = NullString(ds.Tables[0].Rows[0]["CELLPHONE"]);
    document.getElementById("divOrgUser_Tel2").innerText = NullString(ds.Tables[0].Rows[0]["EXTENSIONNUMBER"]);
//    document.getElementById("divOrgUser_Tel3").innerText = NullString(ds.Tables[0].Rows[0]["PHONE1"]);
//    document.getElementById("divOrgUser_Tel4").innerText = NullString(ds.Tables[0].Rows[0]["PHONE2"]);
    document.getElementById("divOrgUser_Emp").innerText = ds.Tables[0].Rows[0]["EMPID"];

    //임시 사용자교육 보여주기용
    //if (ds.Tables[0].Rows[0]["EMPID"] == 'A2044081')
    //    document.getElementById("divOrgUser_Bar").innerText = '전산총괄,NAIS(생산,영업,원가),중국ERP,보안,TOS';
    //else
    document.getElementById("divOrgUser_Bar").innerText = ds.Tables[0].Rows[0]["JOBDESC"];

    grdOrgUser_Show();

    if (isAdmin == "True") {
        var ht = new Object();
        ht["LOGINID"] = ds.Tables[0].Rows[0]["EMPID"];
        ht["COMPANYCODE"] = ds.Tables[0].Rows[0]["COMPANYCODE"]; // $("#cboOrg").val();

        PageMethods.InvokeServiceTable(ht, "Common.OrgChartBiz", "GetPassword", function (e) {
            var ds = eval(e);
            $("#pwd").text(ds.Tables[0].Rows[0]["PASSWORD"]);
        });
    }
}

function pwd_Clear() {
    var ht = new Object();
    ht["LOGINID"] = document.getElementById("divOrgUser_Emp").innerText;
    ht["COMPANYCODE"] = "TY"; // $("#cboOrg").val();
    PageMethods.InvokeServiceTable(ht, "Common.OrgChartBiz", "ResetPassword", function (e) {
        alert("비밀번호를 초기화했습니다.");
    });

}

/******************************************************************************************
* 함수명 : txtSearch_click 
* 설  명 : 조직검색 버튼 클릭
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function txtSearch_click() {
    var deptcd = "";
    //$(".org_combo").val("");
    //var searchString = common_search_org.GetValue();
    var searchString = document.getElementById("search").value; // common_search_org.GetValue();

    if (searchString.length < 2) {
        alert("검색어를 2글자 이상 입력하십시오.");
        return;
    }

    bindGrid(deptcd, searchString);
}

/******************************************************************************************
* 함수명 : bindGrid 
* 설  명 : 조직검색
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function bindGrid(dept, search) {
    if (dept != '') {
        search = "";
    }

    if (!OrgOpen) org_Show();

    var ht = new Object();
    ht["DEPTCODE"] = dept;
    ht["SEARCHSTRING"] = search;
    var companycode = "";
    // 검색조건이 있을시 회사코드는 ""으로 지정되아함
    //if ($("#common_search_org").val() == "") 
    companycode = $("#cboOrg").val();
    //else companycode = "";
    ht["COMPANYCODE"] = companycode;
    ht["LANGCODE"] = LANGCODE;
    grdOrg_ProgressShow();
    PageMethods.InvokeServiceTableSync(ht, "Common.OrgChartBiz", "GetOrgSearchMember", bindGrid_Callback);
}

/******************************************************************************************
* 함수명 : bindGrid 
* 설  명 : 조직검색
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 : 이씨 제대로 안만들어?
******************************************************************************************/
function bindGridInit(dept, search) {
    if (dept != '') {
        search = "";
    }

    //if (!OrgOpen) org_Show();

    var ht = new Object();
    ht["DEPTCODE"] = dept;
    ht["SEARCHSTRING"] = search;
    ht["COMPANYCODE"] = $("#cboOrg").val();
    ht["LANGCODE"] = LANGCODE;
    grdOrg_ProgressShow();
    PageMethods.InvokeServiceTableSync(ht, "Common.OrgChartBiz", "GetOrgSearchMember", bindGrid_Callback);
}

function bindGridDomino(dept, search) {
    if (dept != '') {
        search = "";
    }

    //if (!OrgOpen) org_Show();

    var ht = new Object();
    ht["DEPTCODE"] = dept;
    ht["SEARCHSTRING"] = search;
    ht["COMPANYCODE"] = "";// $("#cboOrg").val();
    ht["LANGCODE"] = LANGCODE;
    grdOrg_ProgressShow();
    PageMethods.InvokeServiceTableSync(ht, "Common.OrgChartBiz", "GetOrgSearchMember", bindGrid_Callback);
}

/******************************************************************************************
* 함수명 : bindGrid_Callback 
* 설  명 : 조직검색 결과 바인딩
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function bindGrid_Callback(e) {
    var ds = eval(e);

    var tbl = document.getElementById("grdOrg_Cont");

    if (tbl.tBodies[0] != null) {
        for (var i = tbl.tBodies[0].rows.length - 1; i >= 0; i--) {
            tbl.tBodies[0].deleteRow(i);
        }

        for (var i = 0; i < ds.Tables[0].Rows.length; i++) {
            var tr = tbl.tBodies[0].insertRow();
            tr.id = "grdOrg_Cont_tr_" + i;
            tr.style.cursor = "pointer";
            
            //var chkTd = tr.insertCell();
            //chkTd.innerHTML = '<input type="checkbox" id="grdOrg_Chk_' + i + '" name="grdOrg_Chk" title="' + ds.Tables[0].Rows[i]["REMPID"] + '" value="' + ds.Tables[0].Rows[i]["EMAIL"] + '" style="background:transparent;border:0;" />';
            
            //if (i % 2 == 0) chkTd.className = "bg2";

            for (var j = 0; j < __org_Columns.length; j++) {
                var td = tr.insertCell();
                var data = ds.Tables[0].Rows[i][__org_Columns[j]];
                if (__org_Columns[j] == "EMAIL") {
                    data = data.split('@')[0];
                }
                if (__org_Columns[j] == "JOBDESC") {
                    data = "";
                }
//                if (__org_Columns[j] == "DEPTNAME") {
//                    if (ds.Tables[0].Rows[i]["DEPTCODE"] == 'ITAAAA' || ds.Tables[0].Rows[i]["DEPTCODE"] == 'ITBBAA' || ds.Tables[0].Rows[i]["DEPTCODE"] == 'ITBCAA') {
//                        data = "<img src='/Resources/Images/Company/ITCENTER.gif' alt='" + ds.Tables[0].Rows[i]["COMPANYNAME"] + "' />&nbsp;" + data;
//                    }
//                    else {
//                        data = "<img src='/Resources/Images/Company/" + ds.Tables[0].Rows[i]["COMPANYCODE"] + ".gif' onerror='this.src=\"/Resources/Images/Company/NONE.gif\"' alt='" + ds.Tables[0].Rows[i]["COMPANYNAME"] + "' />&nbsp;" + data;
//                    }
//                }
                td.innerHTML = '<div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' + data + '</div>';
                td.title = data;
                td.onclick = function () { gridOrg_RowClick(this); };

                if (__org_Columns_Align[j] != "") td.style.textAlign = __org_Columns_Align[j];
                if (__org_Columns_Hidden[j]) td.style.display = "none";
                if (i % 2 == 0) td.className = "bg2";
            }
        }

        var txtSearch = ds.Tables[1].Rows[0]["SEARCH"] == "" ? ds.Tables[1].Rows[0]["DEPTNAME"] : "[" + ds.Tables[1].Rows[0]["SEARCH"] + "] 검색결과";

        grdOrg_SearchText.SetValue(txtSearch);
        grdOrg_SearchCount.SetValue("(총 " + ds.Tables[1].Rows[0]["TOTALCOUNT"] + " 명)");

        grdOrg_ProgressHide();
    }
}

/******************************************************************************************
* 함수명 : cboOrg_Changed 
* 설  명 : 회사 선택 이벤트
* 작성일 : 2015-01-26
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function cboOrg_Changed(obj) {
    $("#treeOrg .myTreeCSS").remove();

    var ht = new Object();
    ht["COMPANYCODE"] = obj.value;
    ht["LANGCODE"] = LANGCODE;
    ht["SEARCHSTRING"] = "";
    treeOrg.Params(ht);
    treeOrg.BindTree("treeOrg");
}
/******************************************************************************************
* 함수명 : cboGrp_Changed 
* 설  명 : 그룹 선택 이벤트
* 작성일 : 2015-01-26
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function cboGrp_Changed(obj) {
    var ht = new Object();
    ht["COMPANYCODE"] = $("#cboOrg").val();
    ht["GROUPCODE"] = obj.value;
    ht["LANGCODE"] = LANGCODE;

    grdOrg_ProgressShow();
    PageMethods.InvokeServiceTable(ht, "Common.OrgChartBiz", "GetOrgGroupMember", cboGrp_Callback);
}

function bindcboGrp() {
    var ht = new Object();

    ht["BUKRS"] = $("#cboOrg").val();
    ht["LANGCD"] = _LANGCD;
    PageMethods.InvokeServiceTableCommon(ht, "UserBiz", "GetGroup", bindcboGrp_Callback);
}

function bindcboGrp_Callback(e) {
    var ds = eval(e);

    $("#cboGrp").find("option").remove();

    $("#cboGrp").append("<option value=''>=== SELECT ===</option>");

    for (i = 0; i < ObjectCount(ds.Tables[0].Rows); i++) {
        $("#cboGrp").append("<option value='" + ds.Tables[0].Rows[i]["GroupCode"] + "'>" + ds.Tables[0].Rows[i]["GroupName"] + "</option>");
    }
}

/******************************************************************************************
* 함수명 : bindGrid_Callback 
* 설  명 : 조직검색 결과 바인딩
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function cboGrp_Callback(e) {
    var ds = eval(e);

    var tbl = document.getElementById("grdOrg_Cont");

    if (tbl.tBodies[0] != null) {
        for (var i = tbl.tBodies[0].rows.length - 1; i >= 0; i--) {
            tbl.tBodies[0].deleteRow(i);
        }

        for (var i = 0; i < ds.Tables[1].Rows.length; i++) {
            var tr = tbl.tBodies[0].insertRow();
            tr.id = "grdOrg_Cont_tr_" + i;
            tr.style.cursor = "pointer";

            var chkTd = tr.insertCell();
            chkTd.innerHTML = '<input type="checkbox" id="grdOrg_Chk_' + i + '" name="grdOrg_Chk" title="' + ds.Tables[1].Rows[i]["REMPID"] + '" value="' + ds.Tables[1].Rows[i]["EMAIL"] + '" />';

            if (i % 2 == 0) chkTd.className = "bg2";

            for (var j = 0; j < __org_Columns.length; j++) {
                var td = tr.insertCell();
                td.innerHTML = '<div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' + ds.Tables[1].Rows[i][__org_Columns[j]] + '</div>';
                td.title = ds.Tables[1].Rows[i][__org_Columns[j]];
                td.onclick = function () { gridOrg_RowClick(this); };

                if (__org_Columns_Align[j] != "") td.style.textAlign = __org_Columns_Align[j];
                if (__org_Columns_Hidden[j]) td.style.display = "none";
                if (i % 2 == 0) td.className = "bg2";
            }
        }
        if (ds.Tables[0].Rows.length > 0) {
            var txtSearch = ds.Tables[0].Rows[0]["GROUPNAME"];

            grdOrg_SearchText.SetValue(txtSearch);
            grdOrg_SearchCount.SetValue("(총 " + ds.Tables[1].Rows.length + " 명)");
        }
        grdOrg_ProgressHide();
    }
}

/******************************************************************************************
* 함수명 : grdOrg_ProgressShow 
* 설  명 : 조직검색 프로그레스바 show
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function grdOrg_ProgressShow() {
    // 레이어가 위치할 좌표를 정의
    var width = $("#grdOrg").width();
    var height = $("#grdOrg").height();
    var table_height = $("#grdOrg").find("table").height();
    // 레이어의 크기를 조절한다.
    $("#grdOrg_progress").css("width", width + "px");
    $("#grdOrg_progress").css("height", height + "px");
    // 레이어의 좌표를 조절한다.
    $("#grdOrg_progress").css("margin-top", "-" + height + "px");
    // 프로그래스의 좌표를 지정한다.
    $("#grdOrg_progress").find("div").css("top", (height / 2 - 16 + 28) + "px");
    $("#grdOrg_progress").find("div").css("left", (width / 2 - 16) + "px");
    $("#grdOrg_progress").show();
}

/******************************************************************************************
* 함수명 : grdOrg_ProgressHide 
* 설  명 : 조직검색 프로그레스바 hide
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function grdOrg_ProgressHide() {
    $("#grdOrg_progress").hide();
}

/******************************************************************************************
* 함수명 : grdOrgUser_SetPosition 
* 설  명 : 조직도 레이어 팝업의 위치를 셋팅
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function grdOrgUser_SetPosition(x, y) {
    var width = $("#divOrgUser").width();
    var height = y - $("#divOrgUser").height();
    height = (height < 0) ? 60 : height;

    $("#divOrgUser").css("top", height + "px");
    $("#divOrgUser").css("left", x + "px");
}

/******************************************************************************************
* 함수명 : grdOrgUser_Show 
* 설  명 : 조직도 팝업을 Open
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function grdOrgUser_Show() {
    $("#divOrgUser").show();
}

/******************************************************************************************
* 함수명 : grdOrgUser_Close 
* 설  명 : 조직도 팝업을 Hide
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function grdOrgUser_Close() {
    $("#divOrgUser").hide();
    document.getElementById("divOrgUser_photo").style.background = "url(/Resources/Images/none_user_photo2.png) no-repeat"; // no-repeat;width:100%;height:100%;'></div>";
    document.getElementById("divOrgUser_photo").style.backgroundPosition = "center top";
    document.getElementById("divOrgUser_Name").innerText = "";
    document.getElementById("divOrgUser_Company").innerText = "";
    document.getElementById("divOrgUser_Dept").innerText = "";
    document.getElementById("divOrgUser_Rank").innerText = "";
    document.getElementById("divOrgUser_Job").innerText = "";
    document.getElementById("divOrgUser_Mail").innerText = "";
    document.getElementById("divOrgUser_Tel1").innerText = "";
    document.getElementById("divOrgUser_Tel2").innerText = "";
//    document.getElementById("divOrgUser_Tel3").innerText = "";
//    document.getElementById("divOrgUser_Tel4").innerText = "";
    document.getElementById("divOrgUser_Emp").innerText = "";

    //document.getElementById("divOrgUser_OrgCard").style.display = "none";       // 인사기록카드 숨기기
    //document.getElementById("divOrgUser_OrgCard").onclick = null;               // 인사기록카드 클릭이벤트 해제
    $("#divOrgUser_OrgCard").attr("onclick", "");                               // 인사기록카드 클릭이벤트 해제
}

function fnDefaultText(obj, type) {
    if (type == 0) {
        obj.value = "";
    } else {
        if (obj.value == "") {
            obj.value = "성명/사번/직무 검색";
        }
    }
}

/******************************************************************************************
* 함수명 : grdOrg_ChkAll_Click 
* 설  명 : 체크박스 전체 선택
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function grdOrg_ChkAll_Click(obj) {
    $('input:checkbox[name="grdOrg_Chk"]').each(function () {
        this.checked = obj.checked;
    });
}

/******************************************************************************************
* 함수명 : SendMailGrid 
* 설  명 : 대상 선택 메일 발송
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function SendMailGrid() {
    var to = "";
    $('input:checkbox[name="grdOrg_Chk"]').each(function () {
        if (this.checked && NullString(this.value) != "-") {
            to += this.value + ";";
        }
    });
    if (to == "") {
        alert("대상을 선택하십시오.");
        return;
    }
    SendMail(to);
}

/******************************************************************************************
* 함수명 : SendMail 
* 설  명 : 메일 발송
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function SendMail(to) {
    var url = __mail_url + "&to=" + to;
    ShowPopup(url, "mail", 800, 800);
}
/******************************************************************************************
* 함수명 : SendMailTo 
* 설  명 : 대상자 메일 발송
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function SendMailTo() {
//    if (NullString(document.getElementById("divOrgUser_Mail").innerText) == "-") {
//        alert("등록된 이메일이 없습니다.");
//        return;
//    }

    //    SendMail(document.getElementById("divOrgUser_Mail").innerText);
    alert('기능구현중');
}
/******************************************************************************************
* 함수명 : SendMailTo 
* 설  명 : 대상 선택 사서함 발송
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function SendPostGrid() {
    var to = "";
    $('input:checkbox[name="grdOrg_Chk"]').each(function () {
        if (this.checked && NullString(this.title) != "-") {
            to += this.title + ",";
        }
    });
    if (to == "") {
        alert("대상을 선택하십시오.");
        return;
    }
    SendPost(to);
}
/******************************************************************************************
* 함수명 : SendPost 
* 설  명 : 사서함 발송
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function SendPost(to) {
    var url = __post_url + "?to=" + to;
    ShowPopup(url, "post", 800, 800);
}
/******************************************************************************************
* 함수명 : SendPostTo 
* 설  명 : 대상자 메일 발송
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function SendPostTo() {
    alert('기능구현중');
//    SendPost(document.getElementById("divOrgUser_Emp").innerText);
}

/******************************************************************************************
* 함수명 : WebSheet_OrgShow 
* 설  명 : Websheet 사용자 선택시 조직도 팝업
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function WebSheet_OrgShow(grid, row, cell, target_id) {
    var _id = eval(grid).GetRow(row)[target_id]
    if (_id == "") return;
    OrgPopup(_id);
}

/******************************************************************************************
* 함수명 : OpenBanner 
* 설  명 : OpenBanner
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function OpenBanner(loca) {
    var _loca = $("#topmenu_banner").attr("title");
    var isLoad = false;
    var display = "none";

    if (_loca == loca && $("#topmenu_banner").css("display") != "none") {
        isLoad = false;
    }
    else {
        isLoad = true;
    }

    if (isLoad) {
        $($("#banner_cont")[0].children).hide();
        display = "block";
        $("#topmenu_banner").attr("title", loca);

        var x = $("#topmenu_banner").width() - ($("body").width() - event.pageX - 35);
        x = (x < 10) ? 10 : (x > 310 ? 310 : x);
        $("#banner_top").css("padding-left", x + "px");

        if ((loca != "POST") && $("#banner_cont div[name='" + loca + "']").length > 0) {
            $("#banner_cont div[name='" + loca + "']").show();
        }
        else {
            var ht = new Object();
            ht["LOCA"] = loca;

            if (loca == "POST") {
                ht["EMPID"] = EMPID;
                PageMethods.InvokeServiceTableCommon(ht, "GWBiz", "GetPostNotRead", bindPost_Callback);
            }
            else {
                PageMethods.InvokeServiceTableCommon(ht, "GWBiz", "GetBannerMain", bindBanner_Callback);
            }
            
        }
    }
    else {
        display = "none";
        if ($("#banner_cont div[name='" + loca + "']").length > 0) {
            $("#banner_cont div[name='" + loca + "']").hide();
        }
    }
    
    $("#topmenu_banner").css("display", display);
}

/******************************************************************************************
* 함수명 : CloseBanner 
* 설  명 : CloseBanner
* 작성일 : 2014-01-26
* 작성자 : 장세현
* 수  정 :
******************************************************************************************/
function CloseBanner() {
    if ($("#topmenu_banner").css("display") != "none") {
        $("#banner_cont div[name^='']").hide();
    }

    $("#topmenu_banner").css("display", "none");
    grdOrgUser_Close();
}

/******************************************************************************************
* 함수명 : bindPost_Callback 
* 설  명 : 사서함 Banner Callback
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function bindPost_Callback(e) {
    var ds = eval(e);
    var url = 'ShowPopup("/GW/POST/Popup/PP0101012.aspx?seq={0}", "POST", 800, 800);';
    

    if ($("#banner_cont div[name='" + $("#topmenu_banner").attr("title") + "']").length > 0) {
        $("#banner_cont div[name='" + $("#topmenu_banner").attr("title") + "']").remove();
    }

    var strHTML = "";

    strHTML = "<div name='" + $("#topmenu_banner").attr("title") + "'>";

    for (var i = 0; i < ds.Tables[0].Rows.length; i++) {
        strHTML += "<div class='banner_post' title='" + ds.Tables[0].Rows[i]["TITLE"] + "'";
        strHTML += " onclick='" + url.replace("{0}", ds.Tables[0].Rows[i]["SEQ"]) + "'";
        strHTML += ">";
        strHTML += "<div class='subject'>";
        strHTML += ds.Tables[0].Rows[i]["TITLE"];
        strHTML += "</div>";
        strHTML += "<div class='name'>";
        strHTML += ds.Tables[0].Rows[i]["SNDIDNM"];
        strHTML += "</div>";
        strHTML += "<div class='time' style='float:right;'>";
        strHTML += ds.Tables[0].Rows[i]["SNDDT"];
        strHTML += "</div>";
        strHTML += "</div>";
    }
    strHTML += "<div class='banner_post_view' onclick='location.href=\"/GW/Post/PP0101010.aspx\"'>모두보기";
    strHTML += "</div>";
    strHTML += "</div>";

    $("#banner_cont").append(strHTML);
}

/******************************************************************************************
* 함수명 : bindBanner_Callback 
* 설  명 : Banner Callback
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function bindBanner_Callback(e) {
    var ds = eval(e);
    var strHTML = "";
    strHTML = "<div name='" + $("#topmenu_banner").attr("title") + "'>"; 

    for (var i = 0; i < ds.Tables[0].Rows.length; i++) {
        strHTML += "<div class='banner' title='" + ds.Tables[0].Rows[i]["TITLE"] + "'>";
        strHTML += "<a target='_blank' href='";
        strHTML += ds.Tables[0].Rows[i]["URL"];
        strHTML += "'>"
        strHTML += "<div class='banner_icon' style='background:url(/Resources/Framework/ImageResize.aspx?src=" + ds.Tables[0].Rows[i]["IMGPATH"] + ") no-repeat;'>";
        strHTML += "</div>";
        strHTML += "<div>";
        strHTML += ds.Tables[0].Rows[i]["TITLE"];
        strHTML += "</div>";
        strHTML += "</a>";
        strHTML += "</div>";
    }
    strHTML += "</div>";

    $("#banner_cont").append(strHTML);
}

function OpenWindow(url) {
    var win = window.open(url, "_blank");
    win.focus();
}

function GetPost() {
    var ht = new Object();
    ht["EMPID"] = EMPID;

    PageMethods.InvokeServiceTableCommon(ht, "GWBiz", "GetPostCNT", GetPost_Callback);
}

function GetPost_Callback(e) {
    var ds = eval(e);

    if (ds.Tables[0].Rows.length > 0) {
        var cnt = Number(ds.Tables[0].Rows[0]["CNT"]);
        var appv_cnt = Number(ds.Tables[0].Rows[0]["APPV_CNT"]);
        var circluar_cnt = Number(ds.Tables[0].Rows[0]["CIRCULAR_CNT"]);
        var extdoc_cnt = Number(ds.Tables[0].Rows[0]["EXTDOC_CNT"]);

        // 사서함 건수
        var txt = $("#PP0101010_text").html();
        if (txt !=null && txt != undefined && txt != "") {
            txt = txt.substring(0, (txt.indexOf('<') > 0 ? txt.indexOf('<') : txt.length));
            $("#PP0101010_text").html(txt + ' <span style="' + (cnt > 0 ? 'color:#ff0000;' : 'color:#0000ff;') + '">(' + cnt + ')</span>');
        }
        $(".info[name='PP0101010']").html(cnt);

        // 미결함 건수
        txt = $("#EA0102010_text").html();
        if (txt != null && txt != undefined && txt != "") {
            txt = txt.substring(0, (txt.indexOf('<') > 0 ? txt.indexOf('<') : txt.length));
            $("#EA0102010_text").html(txt + ' <span style="' + (appv_cnt > 0 ? 'color:#ff0000;' : 'color:#0000ff;') + '">(' + appv_cnt + ')</span>');
        }
        $(".info[name='EA0102010']").html(appv_cnt);

        // 공람함 건수
        txt = $("#EA0102060_text").html();
        if (txt != null && txt != undefined && txt != "") {
            txt = txt.substring(0, (txt.indexOf('<') > 0 ? txt.indexOf('<') : txt.length));
            $("#EA0102060_text").html(txt + ' <span style="' + (circluar_cnt > 0 ? 'color:#ff0000;' : 'color:#0000ff;') + '">(' + circluar_cnt + ')</span>');
        }
        $(".info[name='EA0102060']").html(circluar_cnt);

        txt = $("#EA0301030_text").html();
        if (txt != null && txt != undefined && txt != "") {
            txt = txt.substring(0, (txt.indexOf('<') > 0 ? txt.indexOf('<') : txt.length));
            $("#EA0301030_text").html(txt + ' <span style="' + (extdoc_cnt > 0 ? 'color:#ff0000;' : 'color:#0000ff;') + '">(' + extdoc_cnt + ')</span>');
        }

        if (cnt == 0) {
            $("#post_cnt").html(0);
            $("#post_cnt").css("display", "none");
        }
        else {
            cnt = (cnt >= 100) ? "99+" : cnt + "";
            $("#post_cnt").html(cnt);
            $("#post_cnt").css("display", "block");
        }
        
    }
}

/******************************************************************************************
* 함수명 : base64Encoding 
* 설  명 : base64Encoding
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function base64Encoding(s) {
    var key = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';

    var i = 0, len = s.length,
      c1, c2, c3,
      e1, e2, e3, e4,
      result = [];

    while (i < len) {
        c1 = s.charCodeAt(i++);
        c2 = s.charCodeAt(i++);
        c3 = s.charCodeAt(i++);

        e1 = c1 >> 2;
        e2 = ((c1 & 3) << 4) | (c2 >> 4);
        e3 = ((c2 & 15) << 2) | (c3 >> 6);
        e4 = c3 & 63;

        if (isNaN(c2)) {
            e3 = e4 = 64;
        } else if (isNaN(c3)) {
            e4 = 64;
        }

        result.push(e1, e2, e3, e4);
    }

    return result.map(function (e) { return key.charAt(e); }).join('');
}

function ShowSJLink(sys) {
    switch (sys) {
        case "EIS":
            ShowPopup("http://152.168.1.180/MainSSO.jsp?ID=" + eval("base64Encoding(_KEY + EMPID)"), "eis", window.screen.width, window.screen.height);
            break;
    }
}

/******************************************************************************************
* 함수명 : getWorldClock 
* 설  명 : 세계시간을 가져옴
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function getWorldClock(zone, region, company) {
    var dst = 0;
    var time = new Date();
    var gmtMS = time.getTime() + (time.getTimezoneOffset() * 60000);
    var gmtTime = new Date(gmtMS);
    var day = gmtTime.getDate();
    var month = gmtTime.getMonth();
    var year = gmtTime.getYear();
    if (year < 1000) {
        year += 1900;
    }
    var monthArray = new Array("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12");
    var monthDays = new Array("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31");
    if (year % 4 == 0) {
        monthDays = new Array("31", "29", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31");
    }
    if (year % 100 == 0 && year % 400 != 0) {
        monthDays = new Array("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31");
    }

    var hr = gmtTime.getHours() + zone;
    var min = gmtTime.getMinutes();
    var sec = gmtTime.getSeconds();

    if (hr >= 24) {
        hr = hr - 24;
        day -= -1;
    }
    if (hr < 0) {
        hr -= -24;
        day -= 1;
    }
    if (hr < 10) {
        hr = "0" + hr;
    }
    if (min < 10) {
        min = "0" + min;
    }
    if (sec < 10) {
        sec = "0" + sec;
    }
    if (day <= 0) {
        if (month == 0) {
            month = 11;
            year -= 1;
        }
        else {
            month = month - 1;
        }
        day = monthDays[month];
    }
    if (day > monthDays[month]) {
        day = 1;
        if (month == 11) {
            month = 0;
            year -= -1;
        }
        else {
            month -= -1;
        }
    }

    day = ((day < 10) ? "0" : "") + day;

    if (region == "NA") {   // North America
        var startDST = new Date();
        var endDST = new Date();
        startDST.setMonth(2);
        startDST.setHours(2);
        startDST.setDate(1);
        var dayDST = startDST.getDay();
        if (dayDST != 0) {
            startDST.setDate(8 - dayDST);
        }
        else {
            startDST.setDate(1);
        }
        endDST.setMonth(9);
        endDST.setHours(1);
        endDST.setDate(31);
        dayDST = endDST.getDay();
        endDST.setDate(31 - dayDST);
        var currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDST && currentTime < endDST) {
            dst = 1;
        }
    }
    else if (region == "EU") {       // Europe
        var startDST = new Date();
        var endDST = new Date();
        startDST.setMonth(2);
        startDST.setHours(1);
        startDST.setDate(31);
        var dayDST = startDST.getDay();
        startDST.setDate(31 - dayDST);
        endDST.setMonth(9);
        endDST.setHours(0);
        endDST.setDate(31);
        dayDST = endDST.getDay();
        endDST.setDate(31 - dayDST);
        var currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDST && currentTime < endDST) {
            dst = 1;
        }
    }

    else if (region == "SA") {       // SAmerica
        var startDST = new Date();
        var endDST = new Date();
        startDST.setMonth(9);
        startDST.setHours(0);
        startDST.setDate(1);
        var dayDST = startDST.getDay();
        if (dayDST != 0) {
            startDST.setDate(22 - dayDST);
        }
        else {
            startDST.setDate(15);
        }
        endDST.setMonth(1);
        endDST.setHours(11);
        endDST.setDate(1);
        dayDST = endDST.getDay();
        if (dayDST != 0) {
            endDST.setDate(21 - dayDST);
        }
        else {
            endDST.setDate(14);
        }
        var currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDST || currentTime < endDST) {
            dst = 1;
        }
    }
    else if (region == "CA") {            // Cairo
        var startDST = new Date();
        var endDST = new Date();
        startDST.setMonth(3);
        startDST.setHours(0);
        startDST.setDate(30);
        var dayDST = startDST.getDay();
        if (dayDST < 5) {
            startDST.setDate(28 - dayDST);
        }
        else {
            startDST.setDate(35 - dayDST);
        }
        endDST.setMonth(8);
        endDST.setHours(11);
        endDST.setDate(30);
        dayDST = endDST.getDay();
        if (dayDST < 4) {
            endDST.setDate(27 - dayDST);
        }
        else {
            endDST.setDate(34 - dayDST);
        }
        var currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDST && currentTime < endDST) {
            dst = 1;
        }
    }
    else if (region == "IS") {       // Israel
        var startDST = new Date();
        var endDST = new Date();
        startDST.setMonth(3);
        startDST.setHours(2);
        startDST.setDate(1);
        endDST.setMonth(8);
        endDST.setHours(2);
        endDST.setDate(25);
        dayDST = endDST.getDay();
        if (dayDST != 0) {
            endDST.setDate(32 - dayDST);
        }
        else {
            endDST.setDate(1);
            endDST.setMonth(9);
        }
        var currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDST && currentTime < endDST) {
            dst = 1;
        }
    }
    else if (region == "BE") {       // Beirut
        var startDST = new Date();
        var endDST = new Date();
        startDST.setMonth(2);
        startDST.setHours(0);
        startDST.setDate(31);
        var dayDST = startDST.getDay();
        startDST.setDate(31 - dayDST);
        endDST.setMonth(9);
        endDST.setHours(11);
        endDST.setDate(31);
        dayDST = endDST.getDay();
        endDST.setDate(30 - dayDST);
        var currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDST && currentTime < endDST) {
            dst = 1;
        }
    }
    else if (region == "BA") {       // Baghdad
        var startDST = new Date();
        var endDST = new Date();
        startDST.setMonth(3);
        startDST.setHours(3);
        startDST.setDate(1);
        endDST.setMonth(9);
        endDST.setHours(3);
        endDST.setDate(1);
        dayDST = endDST.getDay();
        var currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDST && currentTime < endDST) {
            dst = 1;
        }
    }
    else if (region == "AU") {       // Australia
        var startDST = new Date();
        var endDST = new Date();
        startDST.setMonth(9);
        startDST.setHours(2);
        startDST.setDate(31);
        var dayDST = startDST.getDay();
        startDST.setDate(31 - dayDST);
        endDST.setMonth(2);
        endDST.setHours(2);
        endDST.setDate(31);
        dayDST = endDST.getDay();
        endDST.setDate(31 - dayDST);
        var currentTime = new Date();
        currentTime.setMonth(month);
        currentTime.setYear(year);
        currentTime.setDate(day);
        currentTime.setHours(hr);
        if (currentTime >= startDST || currentTime < endDST) {
            dst = 1;
        }
    }

    var strDst = "";
    if (dst == 1) {
        hr -= -1
        if (hr >= 24) {
            hr = hr - 24;
            day -= -1;
        }
        if (hr < 10) {
            hr = "0" + hr;
        }
        if (day > monthDays[month]) {
            day = 1;
            if (month == 11) {
                month = 0;
                year -= -1;
            }
            else {
                month -= -1;
            }
        }
        strDst = "";  //DST
        //return year + "-" + monthArray[month] + "-" + day + "<br />" + hr + ":" + min + ":" + sec + " DST";
    }
    else {
        //return year + "-" + monthArray[month] + "-" + day + "<br />" + hr + ":" + min + ":" + sec;
    }

    return '<ul><li class="company">' + company + '</li><li class="date">' + year + "-" + monthArray[month] + "-" + day + '</li>' + '<li class="time">' + hr + ":" + min + '</li></ul>'; //":" + sec +
}

function WorldTime() {
    var cont = "";

    cont += getWorldClock(9, "", "대한민국");
    cont += getWorldClock(8, "", "중국");
    cont += getWorldClock(3, "", "러시아");
    cont += getWorldClock(1, "EU", "체코 / 슬로박");
    cont += getWorldClock(-5, "NA", "조지아");
    cont += getWorldClock(-6, "NA", "알라바마"); // / 멕시코
    $(".time_bx").html(cont);

    setTimeout("WorldTime()", 10000)
}

function OpenHelpdesk() {
    var pid = ProgramID;
    var pnm = $($("#title").children()[0]).text().trim();

    var url = '/WRK/HD/HD010/HD0101030.aspx?pid=' + pid + '&pnm=' + escape(pnm);

    ShowPopup(url, 'helpdesk__', 1000, 900);
    
    return false;

}

function fn_OpenFIList(tp, url, mid) {
    if (typeof (BindFIList) != "undefined" || typeof (BindFIList) == "function") {
        BindFIList(tp);
        MenuID = mid;
        var itemList = treeMenu.Search(MenuID);
        if (itemList.length > 0) {
            itemList[ObjectCount(itemList) - 1].Select();
        }
    }
    else {
        location.href = unescape(url) + '?T=' + tp + '&MENUID=' + mid;
    }
}

/******************************************************************************************
* 함수명 : fn_OpenApvInfo 
* 설  명 : 전자결재정보 오픈
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function fn_OpenApvInfo(unid) {

    var strUri = "/Approval/Form/Misc/ApprovalInfo.aspx?unid=" + unid;
    var retfeature = '';
    retfeature = retfeature + "Height=800px";
    retfeature = retfeature + ",Width=1200px";
    retfeature = retfeature + ",center=yes";
    retfeature = retfeature + ",help=no";
    retfeature = retfeature + ",edge=raised";
    retfeature = retfeature + ",scroll=no";
    retfeature = retfeature + ",resizable=no";
    retfeature = retfeature + ",status=no";
    retfeature = retfeature + ",unadorned=no";

    var win = window.open(strUri, strUri, retfeature);
    win.focus();
}