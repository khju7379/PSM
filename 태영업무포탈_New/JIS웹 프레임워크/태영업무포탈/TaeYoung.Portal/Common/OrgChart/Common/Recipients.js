//	XML 
var XMLDOMPROCESSINGINSTRUCTION = "<?xml version=\"1.0\"?>";
var XMLDOMROOTNODESTARTTAG = "<person>"; //"<Recipients>";
var XMLDOMROOTNODEENDTAG = "</person>"; //"</Recipients>";

var XMLNODE_DN = "DisplayName"; // displayName
var XMLNODE_ENTRYTYPE = "entryType";     // 0 : 부서, 1: DL, 2: 사용자, 3:연락처, 4:메일그룹
var XMLNODE_ADDR = "addr"; 		// 메일주소
var XMLNODE_ACCOUNTID = "AccountId";      // DOMAIN/user account
var XMLNODE_ACCOUNTTYPE = "AccountType";    // user or group type
var XMLNODE_DEPTCODE = "DeptCode";       // 부서코드
var XMLNODE_DEPTNAME = "DeptName";       // 부서명
var XMLNODE_RANKNAME = "RankName";       // 직위
var XMLNODE_JOBNAME = "JobName";        // 직무
var XMLNODE_DUTYCODE = "DutyCode";       // 직책코드
var XMLNODE_DUTYNAME = "DutyName";       // 직책
var XMLNODE_COMPANYCODE = "CompanyCode";    // 회사코드
var XMLNODE_COMPANYNAME = "CompanyName";    // 회사명
var XMLNODE_EMPID = "EmpID";          // 사번
var XMLNODE_CELLPHONE = "CellPhone";      // 전화번호
var XMLNODE_TEAMCHIEFYN = "TeamChiefYN";    // 팀장여부
var XMLNODE_EXTENSIONNUMBER = "ExtensionNumber";    // 사내전화번호
//var XMLNODE_ETC  = "ect";				    // 기타정보

var ENTRYTYPE_DEPT = "0"; 					//	부서
var ENTRYTYPE_DL = "1"; 					//	DL
var ENTRYTYPE_USR = "2"; 					//	사용자
var ENTRYTYPE_ADDR = "3"; 					//	연락처
var ENTRYTYPE_PDL = "4"; 					//	메일그룹
var ENTRYTYPE_EXT = "5"; 					//	외부메일

var DIVNAME = "hdivMenu"; 			// contextmenu가 담은 div tag id
//var REGIONNAME			= "hdControlName";			// textbox name들을 담은 hidden box NAME
var RESOLVINGTEXTPREFIX = "Msg"; 				// 이름풀이한 textbox ctrol tag
var RESOLVEDLABELPREFIX = "hfldset"; 			// 이름풀이된 항목을 display할 control tag
var DELEMETER = "|";

var URL_MANAGEDATA = "Orgmap_Data.aspx"; // Data Handler Page

var g_xmlContainerID; 								// xml data  container control id
var g_xmlObj;
var g_xmlHTTP;
var g_rgRecips = new Array(); g_rgRecips[0] = "To"; g_rgRecips[1] = "Cc"; g_rgRecips[2] = "Bcc";
var m_requestType = "";
var m_checkName = "";
var m_rgRecip = "";
var m_checked = true;
var m_isUser = false;


// init
function InitNameResolutionControl(xmlContainerID) {
    var strXml;
    var oNewNode;
    var IsExistsRecp = false;
    try {
        /*
        XDN_Fn_DisableImageButton(document.all.himgDelRecpTo);
        XDN_Fn_DisableImageButton(document.all.himgDelRecpCc);
        XDN_Fn_DisableImageButton(document.all.himgDelRecpBcc);	
        */
        g_xmlContainerID = xmlContainerID;
        if (document.all.item(xmlContainerID).value.length > 0) {
            IsExistsRecp = true;
        } else {
            document.all.item(xmlContainerID).value =
				(XMLDOMPROCESSINGINSTRUCTION + XMLDOMROOTNODESTARTTAG + XMLDOMROOTNODEENDTAG);
        }

        fn_GetXmlDomString(document.all.item(xmlContainerID).value);
        if (IsExistsRecp) {
            ProcessResolvedXmlData();
        }


    } catch (exception) {
        //fn_OpenErrorMessage(exception.description);
        alert(exception.description);
    }
}

// 이름확인
function CheckName() {
    var strRegionName;
    var arrRegionName;
    var oTextCtrl;
    var strCheckName;
    var arrCheckName;
    var bExist = false;
    var bReturn = true;

    try {

        for (var i = 0; i < g_rgRecips.length; i++) {
            oTextCtrl = document.all.item(RESOLVINGTEXTPREFIX + g_rgRecips[i]);

            if (oTextCtrl == null) continue;
            strCheckName = oTextCtrl.value;

            if (strCheckName.length > 0) {

                if (strCheckName.substr(strCheckName.length - 1, 1) == ";")
                    strCheckName = strCheckName.substr(0, strCheckName.length - 1);
                arrCheckName = strCheckName.split(";");
                for (var j = 0; j < arrCheckName.length; j++) {
                    m_checkName = arrCheckName[j];
                    m_rgRecip = g_rgRecips[i].replace("Msg", "");
                    SendGetRequest("searchObj", arrCheckName[j]);
                    if (j == arrCheckName.length - 1)
                        oTextCtrl.value = oTextCtrl.value.replace(arrCheckName[j], "");
                    else
                        oTextCtrl.value = oTextCtrl.value.replace(arrCheckName[j] + ";", "");

                }


                m_rgRecip = g_rgRecips[i];
                //SendGetRequest("searchObj",strCheckName);
            }
        }
    } catch (exception) {
        alert(exception.description);
    }
    return bReturn;
}



// private 입력된 값이 외부 메일 주소일 경우의 처리
function SetExternalEmailXml() {
    var arrName;
    var arrData;

    try {
        arrName = new Array();
        arrData = new Array();
        arrName[0] = XMLNODE_DN;
        arrName[1] = XMLNODE_ADDR;
        arrName[2] = XMLNODE_ENTRYTYPE;
        arrData[0] = m_checkName;
        arrData[1] = m_checkName;
        arrData[2] = ENTRYTYPE_EXT;

        if (!IsExists(arrName[1], arrData[1])) {
            GenerateXml(m_rgRecip, arrName, arrData);
            ResolveName(m_rgRecip, arrData);
        }
    } catch (exception) {
        throw exception;
        //fn_OpenErrorMessage(exception.description);
    }
}

// private
// xml data생성
// recpTypeElementName : 수신자영역타입
// arrName : Element Name 배열
// arrData : Element Text 배열
function GenerateXml(recpTypeElementName, arrName, arrData) {
    var oRoot;
    var oRegionElement;
    var oNewElement;
    var oNewChildElement;
    var oCDATASection;

    try {
        oRoot = g_xmlObj.documentElement;
        oRegionElement = g_xmlObj.createElement(recpTypeElementName); /* Receiver Type 영역 Element */
        oRoot.appendChild(oRegionElement);

        for (var i = 0; i < arrData.length; i++) {
            oNewChildElement = g_xmlObj.createElement(arrName[i]); 		/*  Type Element */
            oCDATASection = g_xmlObj.createCDATASection(arrData[i]); 	/*  데이터 Element */
            oNewChildElement.appendChild(oCDATASection);
            oRegionElement.appendChild(oNewChildElement);
        }
    } catch (exception) {
        throw exception;
        //fn_OpenErrorMessage(exception.description);		
    }
}

// private
// 이름확인된 데이터의 display처리
// recpType : 수신자영역타입
// arrData : 데이터 배열
function ResolveName(recpType, arrData) {
    var strContextMenuFunction;
    var strSelectNodeFunction;
    var strParam = "";
    var strDisplayName;
    var oHfldset;

    try {
        if (document.all.item("hddlRecp" + recpType) != null || document.all.item("hddlRecp" + recpType) != undefined) {
            var oOption = document.createElement("OPTION");
            document.all.item("hddlRecp" + recpType).add(oOption);
            oOption.innerText = arrData[0];
            oOption.value = arrData[1];
            oOption.type = arrData[2];
            if (document.all.item(RESOLVEDLABELPREFIX + recpType)) {

                if (document.all.item(RESOLVEDLABELPREFIX + recpType).style.display != "") {
                    document.all.item(RESOLVEDLABELPREFIX + recpType).style.display = ""
                    ResizePopupWindow(40);
                }
            }
        }
        /*
        strParam = "'" + recpType + "',";
		
        for (var i=0; i<arrData.length; i++)
        {
        if (i==arrData.length-1)
        {
        strParam += ("'"+arrData[i]+"'");
        }
        else
        {
        strParam += ("'"+arrData[i]+"',");
        }
        }
		
        strContextMenuFunction = "return ShowContextMenu("+strParam+");";			//	ContextMenu 설정
        strSelectNodeFunction = "return ShowProperty("+strParam+");";			//	SelectedNode 설정 
		
        //alert(strParam);
        strDisplayName = arrData[0];
		
        if (document.all.item(RESOLVEDLABELPREFIX + recpType).innerHTML.length == 0)
        document.all.item(RESOLVEDLABELPREFIX + recpType).innerHTML += "<a class=\"divRcpResCIn\" href=\"#\" oncontextmenu=\""+strContextMenuFunction+"\" onClick=\""+strSelectNodeFunction+"\">" +strDisplayName+ "</a>";	
        else
        document.all.item(RESOLVEDLABELPREFIX + recpType).innerHTML += ";<a class=\"divRcpResCIn\" href=\"#\" oncontextmenu=\""+strContextMenuFunction+"\" onClick=\""+strSelectNodeFunction+"\">" +strDisplayName+ "</a>";	
		
        if (document.all.item(RESOLVEDLABELPREFIX + recpType).style.display != ""){
        document.all.item(RESOLVEDLABELPREFIX + recpType).style.display = ""
        ResizePopupWindow(18);
        }
        */
        g_resolved = true;
    } catch (exception) {
        throw exception;
        //fn_OpenErrorMessage(exception.description);		
    }
}

// private
// 중복체크
function IsExists(keyName, keyValue) {
    var bExists = false;
    var oXmlNodeList;

    try {

        oXmlNodeList = g_xmlObj.documentElement.selectNodes("*");
        for (var i = 0; i < oXmlNodeList.length; i++) {
            for (var j = 0; j < oXmlNodeList.item(i).childNodes.length; j++) {
                if (oXmlNodeList.item(i).childNodes.item(j).tagName == keyName) {
                    if (oXmlNodeList.item(i).childNodes.item(j).text == keyValue) {
                        bExists = true;
                        break;
                    }
                }
            }
        }
    } catch (e) {
        throw e;
    }
    return bExists;
}


// Recipient의 속성 보여주기
function ShowProperty() {
    var strObjInfo = "";
    var strRegion;
    var strContextMenuID;
    var arrObjInfo;
    var dn;
    var addr;
    var entryType;

    try {

        //strRegion = arguments[0];					                                                  
        /* 선택된 항목에 대한 value setting */

        if (arguments) {
            for (var i = 0; i < arguments.length; i++) {
                if (i == arguments.length - 1)
                    strObjInfo += arguments[i];
                else
                    strObjInfo += (arguments[i] + DELEMETER);
            }
        }

        if (arguments[2]) {// 해당 수신자를 클릭했을때
            dn = arguments[1];
            addr = arguments[2];
            entryType = arguments[3];
            document.all.hdSelectedData.value = strObjInfo;
        } else {	// context menu에서 등록정보를 클릭했을때
            strObjInfo = document.all.hdSelectedData.value;
            if (strObjInfo.indexOf(DELEMETER) == -1) return;
            arrObjInfo = strObjInfo.split(DELEMETER);
            dn = arrObjInfo[1];
            addr = arrObjInfo[2];
            entryType = arrObjInfo[3];
        }

        if (entryType == ENTRYTYPE_USR)
            OpenUserInfo(addr);
        else if (entryType == ENTRYTYPE_PDL)
            OpenObjectInfo(dn, dn);
        else if (entryType == "") {
            SendGetRequest("checkUser", addr);
            if (m_isUser)
                OpenUserInfo(addr);
            else
                OpenObjectInfo(dn, addr);
        } else
            OpenObjectInfo(dn, addr);


        //	정보보기
        //	USERTYPE 이면 사용자 정보, 그 이외에는 Object정보
        //	단, USERTYPE일 경우 userAccount가 없으면 Object정보
        /*
        if(arguments[1] == USERTYPE)
        {
        if(arguments[5] != "")
        ShowInfo("",arguments[7]);
        else
        OpenObjectInfo(arguments[2],arguments[7]);
        }
        else
        OpenObjectInfo(arguments[3],arguments[4]);
			
		
        //	삭제 (원래 소스)
        //RemoveNode(strRegion);	
        */
    } catch (exception) {
        alert(exception.description);
        //fn_OpenErrorMessage(exception.description);
    }
}

// Recpients control에서의 context menu
function ShowContextMenu() {
    var recpInfo = "";
    var contextMenuID;

    try {
        /* 선택된 항목에 대한 value setting */
        for (var i = 0; i < arguments.length; i++) {
            if (i == arguments.length - 1)
                recpInfo += arguments[i];
            else
                recpInfo += (arguments[i] + DELEMETER);
        }

        document.all.hdSelectedData.value = recpInfo;
        contextMenuID = DIVNAME;
        document.all.item(contextMenuID).style.posTop = event.clientY;
        document.all.item(contextMenuID).style.posLeft = event.clientX;
        /*	마우스 오른쪽 클릭했을때, 이벤트 정의및 Function */
        ContextElement = event.srcElement;
        document.all.item(contextMenuID).style.leftPos += 10;
        document.all.item(contextMenuID).style.display = "";
        //document.all.item(strContextMenuID).setCapture();		
    } catch (exception) {
        //fn_OpenErrorMessage(exception.description);
        alert(exception.description);
    }
    return false;
}

// context menu에서의 click event 처리
function ClickMenu() {
    try {
        //document.all.item(DIVNAME+region).releaseCapture();
        document.all.item(DIVNAME).style.display = "none";

        if (event.srcElement.action != null) {
            eval(event.srcElement.action);
            //alert(event.srcElement.action);
        }
    }
    catch (exception) {
        alert(exception.description);
        //fn_OpenErrorMessage(exception.description);
    }

    return false;
}

// context menu를 숨김
function hideRecipContextMenu() {
    document.all.item(DIVNAME).style.display = "none";
}

// 수신자삭제
function RemoveRecipient(recpType) {
    var recpInfo;
    var arrRecpInfo;
    var xmlValue;
    var oRmNode;
    var recpType;
    var oSelect;
    var bSelected = false;

    try {

        /*
        xmlValue = document.all.item(g_xmlContainerID).value;
        if (!g_xmlObj){
        fn_GetXmlDomString(xmlValue);
        }else{
        g_xmlObj.loadXML(xmlValue);
        }
        */

        oSelect = document.all.item("hddlRecp" + recpType);
        for (var i = oSelect.options.length - 1; i >= 0; i--) {
            if (oSelect.options[i].selected) {
                bSelected = true;
                oRmNode = g_xmlObj.documentElement.selectSingleNode(recpType + "[" + XMLNODE_ADDR + "='" + oSelect.options[i].value + "']");
                oRmNode.parentNode.removeChild(oRmNode);
                oSelect.remove(i);
            }
        }

        if (bSelected) {

            document.all.item(g_xmlContainerID).value = g_xmlObj.xml;

            if (oSelect.options.length == 0) {
                //XDN_Fn_DisableImageButton(document.all.item("himgDelRecp"+recpType));
                if (document.all.item(RESOLVEDLABELPREFIX + recpType))
                    document.all.item(RESOLVEDLABELPREFIX + recpType).style.display = "none";
                ResizePopupWindow(-40);
            }

        }

        document.all.htxtXmlContainer.value = g_xmlObj.xml;
        //recpInfo = document.all.hdSelectedData.value;
        //alert(recpInfo);
        //arrRecpInfo = recpInfo.split(DELEMETER);

        //recpType = arrRecpInfo[0];		
        //ProcessResolvedXmlData(recpType);
    } catch (e) {
        alert(e.description);
    }
}

// 이름확인된 데이터의 label처리
function ProcessResolvedXmlData(recpType) {
    var oXmlNodeList;
    var oXmlNodeListChild;
    var arrName;
    var arrData;
    var recpType;

    try {
        //return;
        //if (!g_xmlObj){				
        //	fn_GetXmlDomString(document.all.item(g_xmlContainerID).value);
        //}else{
        //	g_xmlObj.loadXML(document.all.item(g_xmlContainerID).value);
        //}

        //if (recpType){			
        //	document.all.item(RESOLVEDLABELPREFIX + recpType).innerHTML = "";
        //	oXmlNodeList = g_xmlObj.documentElement.selectNodes("//"+recpType);
        //}else{
        //document.all.item(RESOLVEDLABELPREFIX + g_rgRecips[0]).innerHTML = "";
        //document.all.item(RESOLVEDLABELPREFIX + g_rgRecips[1]).innerHTML = "";
        //document.all.item(RESOLVEDLABELPREFIX + g_rgRecips[2]).innerHTML = "";
        oXmlNodeList = g_xmlObj.documentElement.selectNodes("*");
        //}

        if (oXmlNodeList.length == 0) {
            if (document.all.item(RESOLVEDLABELPREFIX + g_rgRecips[0])) {
                document.all.item(RESOLVEDLABELPREFIX + g_rgRecips[0]).style.display = "none";
                document.all.item(RESOLVEDLABELPREFIX + g_rgRecips[1]).style.display = "none";
                document.all.item(RESOLVEDLABELPREFIX + g_rgRecips[2]).style.display = "none";
            }
        }

        arrName = new Array();
        arrData = new Array();

        for (var i = 0; i < oXmlNodeList.length; i++) {
            recpType = oXmlNodeList.item(i).tagName;
            oXmlNodeListChild = oXmlNodeList.item(i).selectNodes("*");
            if (oXmlNodeListChild.length == 0) {
                //document.all.item(RESOLVEDLABELPREFIX + recpType).style.display = "none";
                //ResizePopupWindow(-18);
            } else {
                for (var j = 0; j < oXmlNodeListChild.length; j++) {
                    arrData[j] = oXmlNodeListChild.item(j).text;
                }
                ResolveName(recpType, arrData); /* label처리 */
            }
        }

        document.all.item(g_xmlContainerID).value = g_xmlObj.xml;
    } catch (e) {
        throw e;
    }
}

//이름확인시 팝업사이즈 재조정
function ResizePopupWindow(height) {
    if (window.opener) {
        window.resizeBy(0, height);
    }
}

// 개체속성창 띄우기
function OpenObjectInfo(displayName, mailAddress) {
    //var strFeature = "dialogHeight:150px;dialogWidth:400px;status:no;resizable:no;help:no;scroll=no";	//	Win2K용

    var strFeature = "dialogHeight:163px;dialogWidth:400px;status:no;resizable:no;help:no;scroll=no"; //	XP용

    var arrParam = new Array();
    arrParam["displayName"] = displayName;
    arrParam["mailAddress"] = mailAddress;
    window.showModalDialog("./RecpInfo.htm", arrParam, strFeature);
}

// 개체속성창 띄우기
function OpenUserInfo(mailAddress) {
    //var strFeature = "dialogHeight:150px;dialogWidth:400px;status:no;resizable:no;help:no;scroll=no";	//	Win2K용

    var strFeature = "dialogHeight:468px;dialogWidth:510px;status:no;resizable:no;help:no;scroll=no"; //	XP용

    window.showModalDialog("./OrgUserInfo.aspx?InternalMail=" + mailAddress, null, strFeature);
}

// 서버에 요청처리
function SendGetRequest(requestType, keyword) {
    try {
        m_requestType = requestType;
        m_checkName = keyword;
        if (!g_xmlHTTP)
            g_xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP");
        g_xmlHTTP.Open("GET", URL_MANAGEDATA + "?requestType=" + requestType + "&keyword=" + escape(keyword), false);
        g_xmlHTTP.onreadystatechange = event_onreadystatechange_GetData;
        g_xmlHTTP.Send();
    } catch (e) {
        throw e;
    }
}

// 서버에 요청처리
function SendGetRequest(requestType, keyword, langCode, companyCode) {
    try {
        m_requestType = requestType;
        m_checkName = keyword;
        if (!g_xmlHTTP)
            g_xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP");
        g_xmlHTTP.Open("GET", URL_MANAGEDATA + "?requestType=" + requestType + "&keyword=" + escape(keyword) + "&langCode=" + langCode + "&companyCode=" + companyCode, false);
        g_xmlHTTP.onreadystatechange = event_onreadystatechange_GetData;
        g_xmlHTTP.Send();
    } catch (e) {
        throw e;
    }
}
// xml state change
function event_onreadystatechange_GetData() {
    if (g_xmlHTTP.readystate == 4) {
        g_xmlHTTP.onreadystatechange = event_nop;
        if (g_xmlHTTP.status == 200) {
            GetDataFromResponseXML();
        } else {
            throw new Error(g_xmlHTTP.status, g_xmlHTTP.statusText);
        }
    }
}

function event_nop()
{ return; }

// response 받은 데이터 처리
function GetDataFromResponseXML() {
    var objHtbRows;
    var childLen = 0;
    var vReturn;
    var nHeight = 410;
    var nWidth = 580;

    try {
        switch (m_requestType) {
            case "searchUser":
                document.all.htrSearchResult.cells(0).innerHTML = "<span style=\"valign:top;width:100%;height:470;overflow-y:auto\">" + g_xmlHTTP.responsetext + "</div>";
                //alert(document.all.htrSearchResult.cells(0).childNodes(0).rows.length);	
                objHtbRows = document.all.htrSearchResult.cells(0).childNodes(0).childNodes(0).rows;
                childLen = objHtbRows.length - 1; // 헤더는 제외

                if (childLen == 0) {
                    alert("'" + m_checkName + "' " + Language.NotExist);
                    document.all.htxtKeyword.value = "";
                    m_checked = false;
                    return;
                } else if (childLen == 1) {
                    objEntryType = objHtbRows[1].cells.namedItem(XMLNODE_ENTRYTYPE);
                    if (objEntryType != null && objEntryType.innerText == ENTRYTYPE_PDL) {
                        AddSearchedRecipient(objHtbRows[1]);
                    } else {
                        //AddSearchedRecipient(objHtbRows[1]);
                        document.all.htrSearchResult.style.display = "";
                        document.all.htrDisplay.style.display = "none";
                    }
                    g_searched = true;
                } else {
                    document.all.htrSearchResult.style.display = "";
                    document.all.htrDisplay.style.display = "none";
                    g_searched = true;
                }

                document.all.htxtKeyword.value = "";

                break;
            case "searchObj":
                document.all.hdivSearchResult.innerHTML = g_xmlHTTP.responsetext;
                objHtbRows = document.all.hdivSearchResult.childNodes(0).rows;
                childLen = objHtbRows.length - 1; // 헤더는 제외

                if (childLen == 0) {
                    if (XDN_Fn_CheckEmailAddress(m_checkName)) {
                        SetExternalEmailXml();
                    } else {
                        alert("'" + m_checkName + "' " + Language.NotExist);
                        document.all.item(RESOLVINGTEXTPREFIX + m_rgRecip).value = "";
                        m_checked = false;
                        return;
                    }
                } else if (childLen == 1) {
                    AddSearchedRecipient(objHtbRows[1]);
                } else {
                    vReturn = window.showModalDialog("./OrgSearchResult.aspx", g_xmlHTTP, "dialogHeight:" + nHeight + "px;dialogWidth:" + nWidth + "px;status:no;resizable:no;help:no;scroll=no");
                    if (vReturn) {
                        document.all.hdivSearchResult.innerHTML = vReturn;

                        objHtbRows = document.all.hdivSearchResult.childNodes(0).rows;
                        childLen = objHtbRows.length;
                        for (var i = 0; i < childLen; i++) {
                            AddSearchedRecipient(objHtbRows[i]);
                        }
                    }
                    //document.all.htrSearchResult.style.display = "";
                    //document.all.htrDisplay.style.display = "none";
                    //g_searched = true;
                }

                document.all.item(RESOLVINGTEXTPREFIX + m_rgRecip).value = "";
                //g_searched = true;
                //document.all.htxtKeyword.value = "";
                break;
            case "checkUser":
                if (g_xmlHTTP.responsetext == "true")
                    m_isUser = true;
                else
                    m_isUser = false;
                break;
        }

        if (m_requestType != "checkUser") {
            document.all.item(g_xmlContainerID).value = g_xmlObj.xml;
            m_checked = true;
        }

        //g_searched = false;
    } catch (e) {
        alert(e.description);
    }
}

// 검색된 수신자 추가
function AddSearchedRecipient(objHtbRow) {
    var objDn;
    var objAddr;
    var objEntryType;
    var arrName;
    var arrData;

    try {
        arrName = new Array();
        arrData = new Array();
        objDn = objHtbRow.cells.namedItem(XMLNODE_DN);
        objAddr = objHtbRow.cells.namedItem(XMLNODE_ADDR);
        objEntryType = objHtbRow.cells.namedItem(XMLNODE_ENTRYTYPE);

        arrName[0] = objDn.id;
        arrName[1] = objAddr.id;
        arrName[2] = XMLNODE_ENTRYTYPE;
        arrData[0] = objDn.innerText;
        arrData[1] = objAddr.innerText;
        arrData[2] = (objEntryType == null ? ENTRYTYPE_USR : objEntryType.innerText);

        if (!IsExists(arrName[1], arrData[1])) {
            GenerateXml(m_rgRecip, arrName, arrData);
            ResolveName(m_rgRecip, arrData);
        }
    } catch (e) {
        throw e;
    }
}

// 동명이인 결과창에서의 확인 클릭시의 처리
function hacConfirm_onClick() {
    var objParent;
    var objReturnHTML = "";
    var bChecked = false;
    var objChk = document.all.item("info");
    if (objChk) {
        for (var i = 0; i < objChk.length; i++) {
            if (i == 0) {
                objChk[i].checked = false;
                continue;
            }

            if (objChk[i].checked) {
                bChecked = true;
                objParent = objChk[i].parentElement;
                while (objParent) {
                    if (objParent.tagName.toLowerCase() == "tr") {
                        break;
                    }
                    objParent = objParent.parentElement;
                }
                objReturnHTML += objParent.outerHTML;
            }
        }
    }

    if (!bChecked) {
        alert(Language.SelectRecipients);
        return;
    }
    //alert(objReturnHTML);
    window.returnValue = "<table>" + objReturnHTML + "</table>";
    window.close();
}	
