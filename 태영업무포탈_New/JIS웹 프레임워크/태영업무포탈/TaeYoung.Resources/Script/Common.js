/******************************************************************************************
* 함수명 : createCookie 
* 설  명 : Cookie 생성
* 작성일 : 2013-12-23
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    }
    else var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}
/******************************************************************************************
* 함수명 : readCookie 
* 설  명 : Cookie 읽기
* 작성일 : 2013-12-23
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}
/******************************************************************************************
* 함수명 : eraseCookie 
* 설  명 : Cookie 삭제
* 작성일 : 2013-12-23
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function eraseCookie(name) {
    createCookie(name, "", -1);
}

/******************************************************************************************
* 함수명 : fn_OpenPop
* 설  명 : 팝업을 Open 한다.
* 작성일 : 2014-01-08
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function fn_OpenPop(url, w, h) {
    if (url == "" || url == null || url == undefined) return;

    w = (w == undefined || w == null) ? 600 : w;
    h = (h == undefined || h == null) ? 400 : h;

    var strLeft = (window.screen.width - w) / 2;
    var strTop = (window.screen.height - h) / 2;

    var feat = "toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=" + w + ",height=" + h + ",top=" + strTop + ",left=" + strLeft;

    var win = window.open(url, "_blank", feat);
    win.focus();
}



/******************************************************************************************
* 함수명 : fn_ToggleArea(obj, target_id)
* 설  명 : 레이어의 숨김 , 열림 처리
* 작성일 : 2014-01-10
* 작성자 : 장경환
* 수  정 : 
******************************************************************************************/
function fn_ToggleArea(obj, target_id) {
    var target = document.getElementById(target_id);
    if (target == null || target == undefined) return;

    if (target.style.display == "none") {
        //obj.innerText = "▲";
        $(obj).find("img").attr("src", "/Resources/Images/btn_table_close.gif");
        target.style.display = "block";

        // 그리드의 검색레이어 추가열림
        //$(".WebSheetGridSearchBx").show();
    }
    else {
        //obj.innerText = "▼";
        $(obj).find("img").attr("src", "/Resources/Images/btn_table_open.gif");
        target.style.display = "none";

        // 그리드의 검색레이어 추가숨김
        //$(".WebSheetGridSearchBx").hide();
    }
}

/******************************************************************************************
* 함수명		: fn_OpenDialogAppv
* 작성목적	: 전자결재 팝업창을 띄운다.
* Parameter   :   sUrl - 띄울 URL
* sFrame - 띄울 Frame
* unid - 전자결재UNID
* mode - 전자결재 Open 모드 r: read, e: edit
* 
* Return      :
* 
* 작 성 자	: 
* 최초작성일	: 
* 최종작성일	:
* 수정내역	:
******************************************************************************************/
function fn_OpenDialogAppv(sUrl, sFrame, unid, mode) {
    var sFeature = '';
    var strWidth = 850;
    var strHeight = 700;

    var url = sUrl + "?unid=" + unid + "&mode=" + mode;

    var strLeft = (window.screen.width - strWidth) / 2;
    var strTop = (window.screen.height - strHeight) / 2;

    // 익스플로러 스크롤바 문제에 따른 scrollbars=no 에서 scrollbars=yes 로 수정 (2016-12-08 장윤호)   resizable=no 에서 yes로 수정 (2017-06-19 장윤호)
    sFeature = "left=" + strLeft + ",top=" + strTop + ",width=" + strWidth + ",height=" + strHeight + ",directories=no,location=no,menubar=no,resizable=yes,scrollbars=yes,toolbar=no";

    var win = window.open(url, sFrame, sFeature);
    win.focus();
    return win;
}

/********************************************************************************************
* 함수명      : fn_ConvertNumber()
* 작성목적    : 자리 구분의 통화를 숫자형태로 변환한다.
* Parameter   :
* Return
* 작성자     : 장경환
* 최초작성일   : 2014-09-22
* 최종작성일   :
* 수정내역    :
********************************************************************************************/
function fn_ConvertNumber(str) {
    var value = String(str);

    value = isNaN(value.replace(/,/gi, "")) ? value : value.replace(/,/gi, "");
    value = (value == "") ? "0" : value;

    return value;
}

/********************************************************************************************
* 함수명      : OpenHelp()
* 작성목적    : help 버튼 클릭 이벤트
* Parameter   :
* Return
* 작성자     : 장경환
* 최초작성일   : 2014-09-22
* 최종작성일   :
* 수정내역    :
********************************************************************************************/
function OpenHelp() {
    if (ProgramID == null || ProgramID == undefined || ProgramID == "") {
        return;
    }

    var strUri = "http://ngw.sjku.co.kr/GW/CM040/CM040.aspx?VER=0&PID=" + ProgramID;
     var retfeature = "Height=643px";
        retfeature += ",Width=844px";
        retfeature += ",center=yes";
        retfeature += ",help=no";
        retfeature += ",edge=raised";
        retfeature += ",scroll=no";
        retfeature += ",resizable=no";
        retfeature += ",status=no";
        retfeature += ",unadorned=no";
    var win = window.open(strUri, strUri, retfeature);
    win.focus();
}

/********************************************************************************************
* 함수명      : dext_editor_loaded_event()
* 작성목적    : DEXT5 Editor Loaded Event
* Parameter   :
* Return
* 작성자     : 장경환
* 최초작성일   : 2014-09-22
* 최종작성일   :
* 수정내역    :
********************************************************************************************/
function dext_editor_loaded_event() {
    try {
        var dext5 = document.getElementsByName("dext5editor");

        for (var i = 0; i < dext5.length; i++) {
            var ctl_id = dext5[i].id.substr(3, dext5[i].id.length - 3);
            DEXT5.setBodyValue(dext5[i].value, ctl_id);
        }
    }
    catch (ex) {
        return false;
    }

    return true;
}


/******************************************************************************************
* 함수명 : readCookie 
* 설  명 : Cookie 읽기
* 작성일 : 2014-11-24
* 작성자 : 장경환
* 수  정 :
******************************************************************************************/
function NullString(str) {
    if (str == null || str == undefined || str == "") {
        return "-";
    }
    return str.trim();
}

function treeMenu_click(r, s) {
    if (s.Item.Values[5].indexOf('.aspx') < 0) {
        if (s.Item.Flg) {
            s.Item.ChildClose();
        }
        else {
            s.Item.ChildOpen();
        }

        if (s.Item.Values[6] == "E") {
            document.getElementById("frmErpPrm").src = "http://127.0.0.1:12345/" + SiteCompanyCode + "^" + EMPID + ", " + s.Item.Values[5];
        }
        return;
    }
    //팝업 여부 예 : 1
    if (s.Item.Values[6] == "1") {
        var size = s.Item.Values[7].split(',');
        fn_OpenPop(s.Item.Values[5], size[0], size[1]);
    }
    else {
        if (QueryString("Chk")) {
            if (s.Item.Values[5].indexOf('?') > -1) {
                PageProgressShow();
                location.href = s.Item.Values[5] + "&Chk=1";
            }
            else {
                PageProgressShow();
                location.href = s.Item.Values[5] + "?Chk=1";
            }
        }
        else if (QueryString("AllChk")) {
            if (s.Item.Values[5].indexOf('?') > -1) {
                PageProgressShow();
                location.href = s.Item.Values[5] + "&AllChk=1";
            }
            else {
                PageProgressShow();
                location.href = s.Item.Values[5] + "?AllChk=1";
            }
        }
        else {
            PageProgressShow();
            location.href = s.Item.Values[5];
        }
    }
}

var GetLOTNOByDate = function (co_gb, date) {
    var rtnValue = "";
    if (co_gb == "SEOHAN" || co_gb == "KOFCO" || co_gb == "ENP") {
        switch (date.substr(0, 4)) {
            case "2004": rtnValue += "D"; break;
            case "2005": rtnValue += "E"; break;
            case "2006": rtnValue += "F"; break;
            case "2007": rtnValue += "G"; break;
            case "2008": rtnValue += "H"; break;
            case "2009": rtnValue += "I"; break;
            case "2010": rtnValue += "J"; break;
            case "2011": rtnValue += "K"; break;
            case "2012": rtnValue += "L"; break;
            case "2013": rtnValue += "M"; break;
            case "2014": rtnValue += "N"; break;
            case "2015": rtnValue += "O"; break;
            case "2016": rtnValue += "P"; break;
            case "2017": rtnValue += "Q"; break;
            case "2018": rtnValue += "R"; break;
            case "2019": rtnValue += "S"; break;
            case "2020": rtnValue += "T"; break;
        }
    }
    else {
        switch (date.substr(0, 4)) {
            case "2005": rtnValue += "A"; break;
            case "2006": rtnValue += "B"; break;
            case "2007": rtnValue += "C"; break;
            case "2008": rtnValue += "D"; break;
            case "2009": rtnValue += "E"; break;
            case "2010": rtnValue += "F"; break;
            case "2011": rtnValue += "G"; break;
            case "2012": rtnValue += "H"; break;
            case "2013": rtnValue += "I"; break;
            case "2014": rtnValue += "J"; break;
            case "2015": rtnValue += "K"; break;
            case "2016": rtnValue += "L"; break;
            case "2017": rtnValue += "M"; break;
            case "2018": rtnValue += "N"; break;
            case "2019": rtnValue += "O"; break;
            case "2020": rtnValue += "P"; break;
        }
    }
    switch (date.substr(4, 2)) {
        case "01": rtnValue += "A"; break;
        case "02": rtnValue += "B"; break;
        case "03": rtnValue += "C"; break;
        case "04": rtnValue += "D"; break;
        case "05": rtnValue += "E"; break;
        case "06": rtnValue += "F"; break;
        case "07": rtnValue += "G"; break;
        case "08": rtnValue += "H"; break;
        case "09": rtnValue += "I"; break;
        case "10": rtnValue += "J"; break;
        case "11": rtnValue += "K"; break;
        case "12": rtnValue += "L"; break;
    }
    switch (date.substr(6, 2)) {
        case "01": rtnValue += "A"; break;
        case "02": rtnValue += "B"; break;
        case "03": rtnValue += "C"; break;
        case "04": rtnValue += "D"; break;
        case "05": rtnValue += "E"; break;
        case "06": rtnValue += "F"; break;
        case "07": rtnValue += "G"; break;
        case "08": rtnValue += "H"; break;
        case "09": rtnValue += "I"; break;
        case "10": rtnValue += "J"; break;
        case "11": rtnValue += "K"; break;
        case "12": rtnValue += "L"; break;
        case "13": rtnValue += "M"; break;
        case "14": rtnValue += "N"; break;
        case "15": rtnValue += "O"; break;
        case "16": rtnValue += "P"; break;
        case "17": rtnValue += "Q"; break;
        case "18": rtnValue += "R"; break;
        case "19": rtnValue += "S"; break;
        case "20": rtnValue += "T"; break;
        case "21": rtnValue += "U"; break;
        case "22": rtnValue += "V"; break;
        case "23": rtnValue += "W"; break;
        case "24": rtnValue += "X"; break;
        case "25": rtnValue += "Y"; break;
        case "26": rtnValue += "Z"; break;
        case "27": rtnValue += "2"; break;
        case "28": rtnValue += "3"; break;
        case "29": rtnValue += "4"; break;
        case "30": rtnValue += "5"; break;
        case "31": rtnValue += "6"; break;
    }
    return rtnValue;
};
var GetDateByLOTNO = function (co_gb, lotno) {
    var rtnValue = new Date();
    var year, month, day;

    if (co_gb == "SEOHAN" || co_gb == "KOFCO" || co_gb == "ENP") {
        switch (lotno.substr(0, 1)) {
            case "D": year = 2004; break;
            case "E": year = 2005; break;
            case "F": year = 2006; break;
            case "G": year = 2007; break;
            case "H": year = 2008; break;
            case "I": year = 2009; break;
            case "J": year = 2010; break;
            case "K": year = 2011; break;
            case "L": year = 2012; break;
            case "M": year = 2013; break;
            case "N": year = 2014; break;
            case "O": year = 2015; break;
            case "P": year = 2016; break;
            case "Q": year = 2017; break;
            case "R": year = 2018; break;
            case "S": year = 2019; break;
            case "T": year = 2020; break;
        }
    } else {
        switch (lotno.substr(0, 1)) {
            case "A": year = 2005; break;
            case "B": year = 2006; break;
            case "C": year = 2007; break;
            case "D": year = 2008; break;
            case "E": year = 2009; break;
            case "F": year = 2010; break;
            case "G": year = 2011; break;
            case "H": year = 2012; break;
            case "I": year = 2013; break;
            case "J": year = 2014; break;
            case "K": year = 2015; break;
            case "L": year = 2016; break;
            case "M": year = 2017; break;
            case "N": year = 2018; break;
            case "O": year = 2019; break;
            case "P": year = 2020; break;
        }
    }

    switch (lotno.substr(1, 1)) {
        case "A": month = 01; break;
        case "B": month = 02; break;
        case "C": month = 03; break;
        case "D": month = 04; break;
        case "E": month = 05; break;
        case "F": month = 06; break;
        case "G": month = 07; break;
        case "H": month = 08; break;
        case "I": month = 09; break;
        case "J": month = 10; break;
        case "K": month = 11; break;
        case "L": month = 12; break;
    }

    switch (lotno.substr(2, 1)) {
        case "A": day = 01; break;
        case "B": day = 02; break;
        case "C": day = 03; break;
        case "D": day = 04; break;
        case "E": day = 05; break;
        case "F": day = 06; break;
        case "G": day = 07; break;
        case "H": day = 08; break;
        case "I": day = 09; break;
        case "J": day = 10; break;
        case "K": day = 11; break;
        case "L": day = 12; break;
        case "M": day = 13; break;
        case "N": day = 14; break;
        case "O": day = 15; break;
        case "P": day = 16; break;
        case "Q": day = 17; break;
        case "R": day = 18; break;
        case "S": day = 19; break;
        case "T": day = 20; break;
        case "U": day = 21; break;
        case "V": day = 22; break;
        case "W": day = 23; break;
        case "X": day = 24; break;
        case "Y": day = 25; break;
        case "Z": day = 26; break;
        case "2": day = 27; break;
        case "3": day = 28; break;
        case "4": day = 29; break;
        case "5": day = 30; break;
        case "6": day = 31; break;
    }
    if (year != null && year != undefined) {
        rtnValue.setFullYear(year, 0, 1);   //맨처음 date 선언하면 오늘 날짜가 박히는데 이때 오늘이 29 이상일 경우 월을 2월로 바꾸게 되면 자동으로 3월로 넘어가게 됨. -> '일' 을 먼저 설정하자! -> 오늘이 9월1일인데 31일자 로트를 쓸 경우 자동으로 1로 변경: 이것도 답이 아님. -> 아예 처음 연도 설정할때 월/일까지 1/1 로 초기화하고 바꾸자!
    }
    if (day != null && day != undefined) {
        rtnValue.setDate(day);
    }
    if (month != null && month != undefined) {
        rtnValue.setMonth(month - 1);
    }
    return rtnValue;
};
var CheckLOTNO = function (co_gb, lotno) {
    var rtnValue = true;
    if (co_gb == "SEOHAN" || co_gb == "KOFCO" || co_gb == "ENP") {
        switch (lotno.substr(0, 1)) {
            case "D":
            case "E":
            case "F":
            case "G":
            case "H":
            case "I":
            case "J":
            case "K":
            case "L":
            case "M":
            case "N":
            case "O":
            case "P":
            case "Q":
            case "R":
            case "S":
            case "T":
                break;
            default:
                rtnValue = false;
                break;
        }
    } else {
        switch (lotno.substr(0, 1)) {
            case "A":
            case "B":
            case "C":
            case "D":
            case "E":
            case "F":
            case "G":
            case "H":
            case "I":
            case "J":
            case "K":
            case "L":
            case "M":
            case "N":
            case "O":
            case "P":
                break;
            default:
                rtnValue = false;
                break;
        }
    }
    switch (lotno.substr(1, 1)) {
        case "A":
        case "B":
        case "C":
        case "D":
        case "E":
        case "F":
        case "G":
        case "H":
        case "I":
        case "J":
        case "K":
        case "L":
            break;
        default:
            rtnValue = false;
            break;
    }
    switch (lotno.substr(2, 1)) {
        case "A":
        case "B":
        case "C":
        case "D":
        case "E":
        case "F":
        case "G":
        case "H":
        case "I":
        case "J":
        case "K":
        case "L":
        case "M":
        case "N":
        case "O":
        case "P":
        case "Q":
        case "R":
        case "S":
        case "T":
        case "U":
        case "V":
        case "W":
        case "X":
        case "Y":
        case "Z":
        case "2":
        case "3":
        case "4":
        case "5":
        case "6":
            break;
        default:
            rtnValue = false;
            break;
    }
    return rtnValue;
};

// 상단 조직도 검색 처리
var ORG_VISIBLE = false;
$(document).ready(function () {
    //$("#Org_Layer").width(0);
    //$("#Org_Layer").height(0);

    $("#member_search2 #search").on("click", function () {
        // 클릭시 iframe 내부 함수 재정의
        document.getElementById("frmOrgMap").contentWindow.org_Close = TopOrgCloseButtonEventReset;

        if ($(this).val().trim() == "임직원 검색") {
            $(this).val("");
        }

        if (!ORG_VISIBLE) TopOrgShow();
        else TopOrgHide();
    });
    $("#member_search2 #search").on("blur", function () {
        if ($(this).val().trim() == "") {
            $(this).val("임직원 검색");
        }
    });
    $("#member_search2 #search").on("keydown", function (e) {
        if (e.keyCode == 13) {
            TopOrgSearch();
        }
    });
});

function TopOrgShow() {
    $("#Org_Layer").show();
    $("#Org_Layer").animate({
        "width": "+=880px",
        "height": "+=490px"
    }, {
        "duration": "300",
        "complete": function () {
            $(window).trigger('resize');
            ORG_VISIBLE = true;
        }
    });

}

function TopOrgHide() {
    $("#Org_Layer").animate({
        "width": "-=880px",
        "height": "-=490px"
    }, {
        "duration": "300",
        "complete": function () {
            $(window).trigger('resize');
            $("#Org_Layer").hide();
            ORG_VISIBLE = false;
        }
    });
}

function TopOrgSearch() {
    if (!ORG_VISIBLE) TopOrgShow();
    // 클릭시 iframe 내부 함수 재정의
    document.getElementById("frmOrgMap").contentWindow.org_Close = TopOrgCloseButtonEventReset;

    var search_text = $("#member_search2 #search").val();
    document.getElementById("frmOrgMap").contentWindow.bindGrid("", search_text);

}

function TopOrgCloseButtonEventReset() {
    TopOrgHide();
}

function PDFViewer(id, src) {

    var html = "";

    html += "<object data=\"" + src + "\" type=\"application/pdf\" width='100%' height='100%'>";
    html += "    <p>It appears you don't have Adobe Reader or PDF support in this web browser. ";
    html += "        <a href=\"" + src + "\">Click here to download the PDF</a>. Or ";
    html += "        <a href=\"http://get.adobe.com/reader/\" target=\"_blank\">click here to install Adobe Reader</a>.";
    html += "    </p>";
    html += "    <embed src=\"" + src + "\" type=\"application/pdf\" />";
    html += "</object>";

    $("#" + id + " *").remove();
    $("#" + id).append(html);
}


/********************************************************************************************
*   작성목적    : 값이 0인경우 표시하지 않음
*   파라미터    : value : 값
********************************************************************************************/
function FormatNoZero(value, format) {
    var rtnValue = Ext.util.Format.number(value, format);

    if (value == 0 || value == "0") {
        rtnValue = " ";
    }

    return rtnValue;
}

/******************************************************************************************
* 함수명 : fn_OpenPopCustom
* 설  명 : 팝업을 Open 한다.
* 작성일 : 2023-08-17
* 작성자 : 임경화
* 수  정 :
******************************************************************************************/
function fn_OpenPopCustom(url, w, h, name) {

    var winPop;

            if (url == "" || url == null || url == undefined) return;

            w = (w == undefined || w == null) ? 600 : w;
            h = (h == undefined || h == null) ? 400 : h;

            var strLeft = (window.screen.width - w) / 2;
            var strTop = (window.screen.height - h) / 2;

            var feat = "toolbar=0,location=0,status=0,menubar=0,scrollbars=1,resizable=1,width=" + w + ",height=" + h + ",top=" + strTop + ",left=" + strLeft;

            if (!winPop || (winPop && winPop.closed)) {
                winPop = window.open(url, name, feat);
            } else {
                winPop.location.href = url;
            }
            //winPop.focus();
}
