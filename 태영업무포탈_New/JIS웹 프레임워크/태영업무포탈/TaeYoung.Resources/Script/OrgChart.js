// orgchart URL
var g_orgchart_url = '/Portal/Common/OrgChart/OrgMapiFrame.aspx?section=app';
var vArguments = new Array();

function IsIE7() {
    var ua = navigator.userAgent.toLowerCase();
    return ua.indexOf("opera") == -1 && ua.indexOf("msie 7") > -1;
};

// Helper, 조직도의 결과 XML을 Javascript Object로 변경
function parseXML(strXML, tagName) {
    var parseTargetTagName = './person/';
    if (typeof (tagName) == "undefined") {
        tagName = "To";
    }
    parseTargetTagName = parseTargetTagName + tagName;
    if (!strXML || typeof strXML != "string") return null;

    var dom = null;
    try {
        dom = $.parseXML(strXML);
    }
    catch (e) { dom = null; }
//    if (window.ActiveXObject) {
//        // IE
//        try {
//            dom = new ActiveXObject('Microsoft.XMLDOM');
//            dom.async = false;
//            if (!dom.loadXML(strXML)) // parse error ..
//                window.alert(dom.parseError.reason + dom.parseError.srcText);
//        }
//        catch (e) { dom = null; }
//    } else {
//        alert(Language.MSIESupport);
//        return null;
//    }

    var fields = [
		{name: 'DisplayName' }, 	// Name
		{name: 'ADDisplayName' }, 	// AD의 DisplayName(사용자의 경우)
		{name: 'entryType' }, 		// 0: 부서, 1: 그룹, 2:사용자
		{name: 'addr' }, 			// 이메일주소	
		{name: 'AccountId' }, 		// 사용자 로그인 ID(도메인 없음)
		{name: 'DeptName' }, 		// 부서이름
		{name: 'DeptCode' }, 		// 부서코드
		{name: 'RankName' }, 		// 직위
		{name: 'JobName' }, 		// 직책
		{name: 'DutyCode' }, 		// 직무코드
		{name: 'DutyName' }, 		// 직무
		{name: 'CompanyCode' }, 	// 회사코드
		{name: 'CompanyName' }, 	// 회사이름
		{name: 'EmpID' }, 			// 사번
		{name: 'CellPhone' }, 		// 휴대폰
		{name: 'ExtensionNumber' }, // 사내전화번호
		{name: 'FaxNumber' }, 		// Fax번호
		{name: 'TeamChiefYN'},		// 팀장여부	
        {name: 'SendYN'}		    // 발송여부	
    ];

    if (!dom) {
        alert(Language.ParsingError);
        return null;
    } else {
        var records = [];
        var ns = null;
        try {
            ns = $(dom).find(parseTargetTagName);
        } catch (ex) {
            //alert("XML String을 파싱하는데 에러가 발생했습니다. (" + ex.message + ")"); 
        }
        if (!ns) return null;

        for (var i = 0, len = ns.length; i < len; i++) {
            var n = ns[i];
            var values = {};
            for (var j = 0, jlen = fields.length; j < jlen; j++) {
                var f = fields[j];
                var v = "";
                try {
                    v = n.selectSingleNode(f.name).text;
                } catch (ex) { } // ignore
                values[f.name] = v;
            }
            records[records.length] = values;
        }
        return records;
    }
};

var __obj;
function om_FlexOrg(obj, config) {
    __obj = obj;
    om_OpenOrgChart(config)
}

function om_OpenOrgChart(config) {
    if (!config && !config.callback) {
        alert(Language.OrganizationChartCallError);
        return false;
    }
    var d_height = 485;
    var d_width = 850; //540, 280

    var sURL = g_orgchart_url;
    var sFeatures = "toolbar=0,location=0,status=0,scrollbars=0,resizable=1";
    //vArguments = new Array();

    vArguments['CallBack'] = config.callback;
    vArguments['CustomApp'] = config.custom || null;

    var appType = config.appType || "deptuser";
    appType = appType.toUpperCase();
    var returnType = config.returnType || "json";
    returnType = returnType.toUpperCase();
    var isOneSelect = config.oneSelect === true ? true : false;

    vArguments['SelectCompany'] = config.selectCompany === false ? false : true;
    if (config.title) vArguments['OrgMapTitle'] = config.title;
    vArguments['ReturnType'] = returnType;

    if (appType === "DEPTUSER") {
        if (isOneSelect) d_width = d_width - 240;
    }
    else if (appType === "USER") {
        if (isOneSelect) d_width = d_width - 240;
    }
    else if (appType === "DEPT") {
        if (isOneSelect == true) d_width = d_width - 480;
    }
    else { }
    if (config.custom) {
        if (config.custom.height) {
            d_height = config.custom.height;
        }
        else {
            alert(Language.HeightSpecify); return false;
        }
    }
    vArguments['OnlyOneSelect'] = isOneSelect;
    vArguments['AppType'] = appType;

    vArguments['ShowMailGroup'] = config.showMailGroup == false ? false : true;

    var data = null;
    if (!isOneSelect) {
        try {
            if (typeof (config.data) == "string" && config.data.length > 2) {
                if (config.data.toLowerCase().indexOf("<?xml") != -1) {
                    if (config.custom) {
                        data = {};
                        var items = config.custom.items;
                        for (var i = 0; i < items.length; i++) {
                            var name = "" + items[i].name + "";
                            data[name] = parseXML(config.data, name);
                        }
                    }
                    else {
                        data = parseXML(config.data);
                    }
                } else {
                    data = eval(config.data);
                }
            }
        } catch (e) { alert(Language.InvalidData); return false; }
    }

    vArguments['OrgMapData'] = data;
    

    if (!IsIE7()) {
        // IE6: XP 디폴트 테마
        d_height = d_height + 34;
        d_width = d_width + 4;
        //sFeatures += ",height=:" + d_height + "px;dialogWidth:" + d_width + "px;";
    } 

    sFeatures += ",height=" + d_height + "px,width=" + d_width + "px;";

    if (config.langCode) {
        sURL += "&langCode=" + config.langCode;
    }
    var win = window.open(sURL, "OrgMap", sFeatures, true);
    win.focus();
    //window.showModalDialog(sURL, vArguments, sFeatures);
    return;
};




var MailOrgMapData = function () { };
var OrgMapData = function () { };
OrgMapData.prototype = {
    EmpID: "",
    ADDisplayName: "",
    Email: "",
    Type: "",
    RankName: "",
    DutyName: "",
    DeptName: "",
    UserName: "",
    CellPhone: "",
    ExtensionNumber: "",
    FaxNumber: "",
    CompanyName: ""
};
MailOrgMapData.prototype = {
    To: [],
    Cc: [],
    Bcc: []
};
//--> 추가 끝

function om_OpenCustomGroup() {
    var orgmapData = null;
    //var sURL = _ApplicationRoot + '/Common/OrgChart/orgmapiframe.aspx?section=mail&a=PickRecipients&app=CustomMailGroup';
    var sURL = '/Common/OrgChart/orgmapiframe.aspx?section=mail&a=PickRecipients&app=CustomMailGroup';
    var sFeatures = "dialogHide:yes;resizable:no;status:no;unadorned:yes;zoominherit:yes;";

    var d_width = 780;
    var d_height = 500;
    if (!IsIE7()) {
        // XP 디폴트 테마
        d_width = d_width + 4;
        d_height = d_height + 34;

        sFeatures += "dialogHeight:" + d_height + "px;dialogWidth:" + d_width + "px;";
    }
    else {
        sFeatures += "dialogHeight:" + d_height + "px;dialogWidth:" + d_width + "px;";
    }

    var vArguments = new Array();
    vArguments['orgmapData'] = orgmapData;

    var data = window.showModalDialog(sURL, vArguments, sFeatures); //shwDlg(sURL, d_width, d_height, DLG_MOD | DLG_CTR | DLG_STA, vArguments, "&a=" + sA);
}

function om_OpenCustomGroup(grp) {
    var orgmapData = null;
    //var sURL = _ApplicationRoot + '/OrgChart/orgmapiframe.aspx?section=mail&a=PickRecipients&app=CustomMailGroup&grp=' + grp;
    var sURL = '/Common/OrgChart/orgmapiframe.aspx?section=mail&a=PickRecipients&app=CustomMailGroup&grp=' + grp;
    var sFeatures = "dialogHide:yes;resizable:no;status:no;unadorned:yes;zoominherit:yes;";

    var d_width = 780;
    var d_height = 500;
    if (!IsIE7()) {
        // XP 디폴트 테마
        d_width = d_width + 4;
        d_height = d_height + 34;

        sFeatures += "dialogHeight:" + d_height + "px;dialogWidth:" + d_width + "px;";
    }
    else {
        sFeatures += "dialogHeight:" + d_height + "px;dialogWidth:" + d_width + "px;";
    }

    var vArguments = new Array();
    vArguments['orgmapData'] = orgmapData;

    var data = window.showModalDialog(sURL, vArguments, sFeatures); //shwDlg(sURL, d_width, d_height, DLG_MOD | DLG_CTR | DLG_STA, vArguments, "&a=" + sA);
}

function om_OpenOrgChartMail() {
    var orgmapData = null;
    //var sURL = _ApplicationRoot + '/OrgChart/orgmapiframe.aspx?section=mail&a=PickRecipients';
    var sURL = '/Common/OrgChart/orgmapiframe.aspx?section=mail&a=PickRecipients';
    var sFeatures = "dialogHide:yes;resizable:no;status:no;unadorned:yes;zoominherit:yes;";
    
    var d_width = 780;
    var d_height = 500;
    if (!IsIE7()) {
        // XP 디폴트 테마
        d_width = d_width + 4;
        d_height = d_height + 34;

        sFeatures += "dialogHeight:" + d_height + "px;dialogWidth:" + d_width + "px;";
    }
    else {
        sFeatures += "dialogHeight:" + d_height + "px;dialogWidth:" + d_width + "px;";
    }
    
    var orgmapData = new MailOrgMapData();
    var ToList = new Array();
    var CcList = new Array();
    var BccList = new Array();

    if (divTo) {
        for (var i = 0; i < divTo.childNodes.length; i++) {
            if ((divTo.childNodes[i].nodeValue != ", ") && (divTo.childNodes[i].innerText != "")) {
                if (divTo.childNodes[i].childNodes[0]) {
                    if ((divTo.childNodes[i].childNodes[0]._rt == "EX") || (divTo.childNodes[i].childNodes[0]._rt == "SMTP")) {
                        var temp = new OrgMapData();
                        temp.ADDisplayName = divTo.childNodes[i].childNodes[0]._dn;
                        temp.Email = divTo.childNodes[i].childNodes[0]._sa;
                        ToList[ToList.length] = temp;
                    } else if (divTo.childNodes[i].childNodes[0]._rt == "MAPIPDL") {
                        var temp = new OrgMapData();
                        temp.ADDisplayName = divTo.childNodes[i].innerText;
                        temp.Email = divTo.childNodes[i].innerText;
                        ToList[ToList.length] = temp;
                    }
                }
            }
        }
    }

    if (divCc) {
        for (var i = 0; i < divCc.childNodes.length; i++) {
            if ((divCc.childNodes[i].nodeValue != ", ") && (divCc.childNodes[i].innerText != "")) {
                if (divCc.childNodes[i].childNodes[0]) {
                    if ((divCc.childNodes[i].childNodes[0]._rt == "EX") || (divCc.childNodes[i].childNodes[0]._rt == "SMTP")) {
                        var temp = new OrgMapData();
                        temp.ADDisplayName = divCc.childNodes[i].childNodes[0]._dn;
                        temp.Email = divCc.childNodes[i].childNodes[0]._sa;
                        CcList[CcList.length] = temp;
                    } else if (divCc.childNodes[i].childNodes[0]._rt == "MAPIPDL") {
                        var temp = new OrgMapData();
                        temp.ADDisplayName = divCc.childNodes[i].innerText;
                        temp.Email = divCc.childNodes[i].innerText;
                        CcList[CcList.length] = temp;
                    }
                }
            }
        }
    }

    if (divBcc) {
        for (var i = 0; i < divBcc.childNodes.length; i++) {
            if ((divBcc.childNodes[i].nodeValue != ", ") && (divBcc.childNodes[i].innerText != "")) {
                if (divBcc.childNodes[i].childNodes[0]) {
                    if ((divBcc.childNodes[i].childNodes[0]._rt == "EX") || (divBcc.childNodes[i].childNodes[0]._rt == "SMTP")) {
                        var temp = new OrgMapData();
                        temp.ADDisplayName = divBcc.childNodes[i].childNodes[0]._dn;
                        temp.Email = divBcc.childNodes[i].childNodes[0]._sa;
                        BccList[BccList.length] = temp;
                    } else if (divBcc.childNodes[i].childNodes[0]._rt == "MAPIPDL") {
                        var temp = new OrgMapData();
                        temp.ADDisplayName = divBcc.childNodes[i].innerText;
                        temp.Email = divBcc.childNodes[i].innerText;
                        BccList[BccList.length] = temp;
                    }
                }
            }
        }
    }

    orgmapData.To = ToList;
    orgmapData.Cc = CcList;
    orgmapData.Bcc = BccList;

    var vArguments = new Array();
    var check = true;
    vArguments['orgmapData'] = orgmapData;

    var data = window.showModalDialog(sURL, vArguments, sFeatures); //shwDlg(sURL, d_width, d_height, DLG_MOD | DLG_CTR | DLG_STA, vArguments, "&a=" + sA);
    
    if (data) {
        divTo.innerHTML = "";
        divCc.innerHTML = "";
        divBcc.innerHTML = "";

        if (data.To && data.To.length >= 1) {
            for (var i = 0; i < data.To.length; i++) {
                check = true;
                for (var j = 0; j < divTo.innerHTML.split(",").length - 1; j++) {
                    if (divTo.innerHTML.split(",")[j] == data.To[i].ADDisplayName + "(" + data.To[i].Email + ")") check = false;
                }
                if (check) divTo.innerHTML += data.To[i].ADDisplayName + "(" + data.To[i].Email + "),";
            }
        }

        if (data.Cc && data.Cc.length >= 1) {
            for (var i = 0; i < data.Cc.length; i++) {
                divCc.innerHTML += data.Cc[i].ADDisplayName + "(" + data.Cc[i].Email + "),";
            }
        }

        if (data.Bcc && data.Bcc.length >= 1) {
            for (var i = 0; i < data.Bcc.length; i++) {
                divBcc.innerHTML += data.Bcc[i].ADDisplayName + "(" + data.Bcc[i].Email + "),";
            }
        }
    }


    //if (divBcc.innerHTML != "") shwBcc(1);
    //rslvNms(OP_ANR);
}

function om_SortOrgChartObj(array, key, asc) {
    return array.sort(function (a, b) {
        var x = eval("a." + key); 
        var y = eval("b." + key);
        return ((x < y) ? -1 : ((x > y) ? 1 : 0)) * (asc ? 1 : -1);
    });
}


//
var navName = navigator.appName; //브라우져 이름...
var brVer = navigator.userAgent; //브라우져 정보
// -->변경 끝