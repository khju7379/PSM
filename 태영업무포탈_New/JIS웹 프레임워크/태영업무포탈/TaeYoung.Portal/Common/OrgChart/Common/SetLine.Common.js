/*
* SetLine.Common.js
* 공통으로 쓸 컴포넌트 정의
*/

//var GW.Org = null;
//var GW.NameControl = null;
//var GW.ApproverAgree = null;
//var GW.Charge = null;
//var GW.Acl = null;
//var GW.Receive = null;


// App 조직도 DATA
if (!APPDataFields) {
    var APPDataFields = [
		{ name: 'EmpID' },
		{ name: 'LoginID' },
		{ name: 'ADDisplayName' },
		{ name: 'UserName' },
		{ name: 'Email' },
		{ name: 'Type' },
		{ name: 'DeptCode' },
		{ name: 'DeptName' },
		{ name: 'DutyCode' },
		{ name: 'DutyName' },
		{ name: 'JobCode' },
        { name: 'JobName' },
		{ name: 'RankCode' },
		{ name: 'RankName' },
		{ name: 'CellPhone' },
		{ name: 'TeamChiefYN' },
        { name: 'CompanyCode' },
        { name: 'CompanyName' },
        { name: 'SignID' },
		{ name: 'ExtensionNumber' },
		{ name: 'FaxNumber' },
		{ name: 'Depth' },
		{ name: 'TaskId' },
		{ name: 'Seq' },
		{ name: 'Validation' },
		{ name: 'Change' },
		{ name: 'DisplayName' },
		{ name: 'Information' }
        
	];
}

//결재선 DataRecord
var ApproverRecord = Ext.data.Record.create([
	{ name: 'EmpID', mapping: 'EmpID' },
	{ name: 'LoginID', mapping: 'LoginID' },
	{ name: 'ADDisplayName', mapping: 'ADDisplayName' },
	{ name: 'UserName', mapping: 'UserName' },
	{ name: 'Email', mapping: 'Email' },
	{ name: 'Type', mapping: 'Type' },
	{ name: 'DeptCode', mapping: 'DeptCode' },
	{ name: 'DeptName', mapping: 'DeptName' },
	{ name: 'DutyCode', mapping: 'DutyCode' },
	{ name: 'DutyName', mapping: 'DutyName' },
	{ name: 'JobCode', mapping: 'JobCode' },
    { name: 'JobName', mapping: 'JobName' },
	{ name: 'RankCode', mapping: 'RankCode' },
	{ name: 'RankName', mapping: 'RankName' },
	{ name: 'CellPhone', mapping: 'CellPhone' },
	{ name: 'TeamChiefYN', mapping: 'TeamChiefYN' },
    { name: 'CompanyCode', mapping: 'CompanyCode' },
    { name: 'CompanyName', mapping: 'CompanyName' },
    { name: 'SignID', mapping: 'SignID' },
	{ name: 'ExtensionNumber', mapping: 'ExtensionNumber' },
	{ name: 'FaxNumber', mapping: 'FaxNumber' },
	{ name: 'Depth', mapping: 'Depth' },
	{ name: 'TaskId', mapping: 'TaskId' },
	{ name: 'Seq', mapping: 'Seq' },
	{ name: 'Validation', mapping: 'Validation' },
	{ name: 'Change', mapping: 'Change' },
	{ name: 'DisplayName', mapping: 'DisplayName' },
	{ name: 'Information', mapping: 'Information' }
    
]);

//수신처사본처 DataRecord
var ApproverRecordACL = Ext.data.Record.create([
	{ name: 'EmpID', mapping: 'EmpID' },
	{ name: 'LoginID', mapping: 'LoginID' },
	{ name: 'Key', mapping: 'Key' },
	{ name: 'ADDisplayName', mapping: 'ADDisplayName' },
	{ name: 'UserName', mapping: 'UserName' },
	{ name: 'Email', mapping: 'Email' },
	{ name: 'Type', mapping: 'Type' },
	{ name: 'DeptCode', mapping: 'DeptCode' },
	{ name: 'DeptName', mapping: 'DeptName' },
	{ name: 'DutyCode', mapping: 'DutyCode' },
	{ name: 'DutyName', mapping: 'DutyName' },
	{ name: 'JobCode', mapping: 'JobCode' },
    { name: 'JobName', mapping: 'JobName' },
	{ name: 'RankCode', mapping: 'RankCode' },
	{ name: 'RankName', mapping: 'RankName' },
	{ name: 'CellPhone', mapping: 'CellPhone' },
	{ name: 'TeamChiefYN', mapping: 'TeamChiefYN' },
    { name: 'CompanyCode', mapping: 'CompanyCode' },
    { name: 'CompanyName', mapping: 'CompanyName' },
    { name: 'SignID', mapping: 'SignID' },
	{ name: 'ExtensionNumber', mapping: 'ExtensionNumber' },
	{ name: 'FaxNumber', mapping: 'FaxNumber' },
	{ name: 'Depth', mapping: 'Depth' },
	{ name: 'TaskId', mapping: 'TaskId' },
	{ name: 'Seq', mapping: 'Seq' },
	{ name: 'Validation', mapping: 'Validation' },
	{ name: 'Change', mapping: 'Change' },
	{ name: 'DisplayName', mapping: 'DisplayName' },
	{ name: 'Information', mapping: 'Information' }
    
]);

// 탭 컨테이너
var LeftTabContainer = null;
var RightTabContainer = null;

// AWX xml 객체
var Awx = null;
// 결재선지정창 구성 XML
var Form = null;

var parser = new DOMParser();

var AwxXml;


var FormXml;

// 결재단계
var app_seq = null;	

// 왼쪽탭영역 너비
var leftWidth = 581;
// 오른쪽탭영역 너비
var rightWidth = 367;
// 높이
var pHeight = 450;

var strUrl = '';

//결재선
var line_type = null;
//결재선 예외 타입
var app_type = null;
//다중협조
var is_agree_multi = null;
//검토전 협조
var is_agree_before = null;
//검토후 협조
var is_agree_after = null;
//수신
var is_send = null;
//참조
var is_copy = null;
//담당자가 1단 결재선 지정에서 보일지 여부
var is_charge = null;
//담당자 변경 여부
var charge_change = null;
//직위를 콤보박스로 선택 여부
var is_combo = null;
//결재단계
var is_seq = null;
//양식명
var form_name = null;
//워드결재(비정형)
var is_word = null;
//사용언어
var ui_culture = null;
//중복체크
var is_overlap = false;

//기본결재 노드
var approverlistNodes = null;
//담당자 노드
var chargelistNodes = null;
//수신처/사본처 노드
var acllistNodes = null;

if (parent.opener.args.awx) {
	Awx = $.parseXML(parent.opener.args.awx);
	AwxXml = Awx.documentElement;
	line_type = parent.opener.args.line;
	app_type = parent.opener.args.type;
	is_agree_multi = parent.opener.args.agree_multi;
	is_agree_before = parent.opener.args.agree_before;
	is_agree_after = parent.opener.args.agree_after;
	is_send = parent.opener.args.send;
	is_copy = parent.opener.args.copy;
	is_charge = parent.opener.args.charge;
	charge_change = parent.opener.args.charge_change;
	is_combo = parent.opener.args.combo;
	is_seq = parent.opener.args.seq;
	form_name = null;
	is_word = parent.opener.args.word;
	ui_culture = parent.opener.args.culture.toLowerCase();
	if (parent.opener.args.overlap_check != undefined)
		is_overlap = parent.opener.args.overlap_check;

	Initialization();
}

Ext.onReady(function () {
    //alert("Ext OnReady");
    functionLoad();
});

var isXmlLoaded = false;

function functionLoad() {
    var t = setInterval(function () {
        if (isXmlLoaded) {
            functionInit();
            isXmlLoaded = false;
            clearInterval(t);
        }
    }, 100);
}

function functionInit() {
    GW.Org = new GW.SetLine.Org();
    GW.NameControl = new GW.PresenceMgr();
    GW.ApproverAgree = new GW.SetLine.ApproverAgree();
    GW.Charge = new GW.SetLine.Charge();
    GW.Acl = new GW.SetLine.Acl();
    GW.Receive = new GW.SetLine.Receive();
    //Ext.onReady(function () { alert(); });
    //Ext.onReady(function () { new GW.SetLine.Main(); })
    GW.Line = new GW.SetLine.Main();
}

function Initialization() {
    
	if(AwxXml != null)
	{
		// 운영예산(증감) 결재선 지정시 협조자 타이틀을 검토자로 변경하기 위해 올림 2007.10.23 이영호	
		if(AwxXml.attributes.getNamedItem('FormFile').value == undefined || AwxXml.attributes.getNamedItem('FormFile').value == null)
		{
			form_name = "";
		}
		else
		{
			form_name = AwxXml.attributes.getNamedItem('FormFile').value; 
		}
		
		var tmp_name = line_type;
		if(app_type != undefined) tmp_name = tmp_name + app_type;
		if(is_agree_multi) tmp_name = tmp_name + "_Multi";
		if(is_agree_before) tmp_name = tmp_name + "_Before";
		if(is_agree_after) tmp_name = (form_name.toUpperCase() == "ERPBUDGETCHANGE") ? tmp_name + "_After_1" : tmp_name + "_After";
		if(is_send) tmp_name = tmp_name + "_Send";
		if(is_copy) tmp_name = tmp_name + "_Copy";
		if(is_charge) tmp_name = tmp_name + "_Charge";
		if(charge_change) tmp_name = tmp_name + "_Change";
		if(is_combo) tmp_name = tmp_name + "_Combo";
		if(is_word) tmp_name = tmp_name + "_Word";
		
		// 결재단계
		app_seq = 0;
		//언어 설정
		//if(ui_culture != undefined && ui_culture != "") g_langCode = ui_culture;
		
		//울산예외처리
		if(app_type != undefined && app_type.toLowerCase() == "lobchange") is_send = true;
		if(tmp_name.toLowerCase() == "clxlobsend2") is_send = true;
		
        //인천예외처리 2009-10-15 추가
        if(tmp_name.toLowerCase() == "icoclxlobsend2") is_send = true;

		var history_node = $(AwxXml).find("Histories History");
		// 결재 단계를 확인. (결재단계 예외처리 때문에 수정 2007.07.12)
		if(is_seq == undefined)
		{
			for(var i=0; i<history_node.length; i++)
			{
			    var history_seq = history_node[i].getAttribute("Seq");
				var app_node = $(history_node[i]).find("Approver[TaskID='app" + history_seq + "']")[0];

				if(app_node != null)
				{
					if(app_node.getAttribute("State") != "")
					{
						app_seq++;
					}
				}
			}			
		}
		else
		{
			app_seq = is_seq;
		}

		strUrl = location.href.substring(0, location.href.lastIndexOf('/')) + '/Xml/' + tmp_name + '.aspx?_culture=' + g_langCode;

		$.get(strUrl, function (e) {
		    Form = $.parseXML(e);
		    FormXml = Form.documentElement;
		    if (FormXml == null) {
		        //debugger;
		        alert(Language.NotApprovalLineTemplate);
		        window.close();
		    }
		    else {
		        var approverNode = $(FormXml).find("ui[seq='" + app_seq + "'] tab[type='approveragree']")[0];
		        var chargeNode = $(FormXml).find("ui[seq='" + app_seq + "'] tab[type='charge']")[0];
		        var aclNode = $(FormXml).find("ui[seq='" + app_seq + "'] tab[type='acl']")[0];
		        if (approverNode != null) {
		            approverlistNodes = $(approverNode).find("list");
		        }

		        if (aclNode != null) {
		            acllistNodes = $(aclNode).find("list");
		        }

		        if (chargeNode != null) {
		            chargelistNodes = $(chargeNode).find("list");
		        }

		        isXmlLoaded = true;
		    }
		});
	}
}

// 다국어처리
function GetResource(resourceName, args)
{
	var sName = resourceName + "_" + g_langCode;
	
	if(args == undefined)
	{
		if(typeof GW.SetLine.Resource[sName] != "undefined"){
			return GW.SetLine.Resource[sName];
		}
	}
	else
	{
		if(typeof GW.SetLine.Resource[sName] != "undefined"){
			if(typeof(args) == "string")
			{
				var ret_value = String.format(GW.SetLine.Resource[sName], args)
				return ret_value;			
			}
			else if(typeof(args) == "object")
			{
				var ret_value = ""
				
				for(var i=0; i<args.length; i++)
				{
					if(ret_value == "")
					{
						ret_value = "String.format(GW.SetLine.Resource[sName], '" + args[i] + "'";
					}
					else
					{
						ret_value = ret_value + ", '" + args[i] + "'";
					}
				}
				ret_value = ret_value + ")";
				return eval(ret_value);
			}
		}	
	}
	return "Undefined resource";//return "미정의리소스";
};

//결재선지정창에 공통적으로 들어가는 Component를 정의
GW.SetLine.Common = function() {
    // truefree 2009-09-15 AJAX 호출시 langCode를 넘겨줌
    Ext.Ajax.extraParams = { 'langCode' : g_langCode };
};

GW.SetLine.Common.prototype =
{
	On_Approver_DbClickItem : function(record, index, allItems)
	{
		var id = RightTabContainer.activeTab.id.split("_")[0];
		var tp = eval("GW." + id);
		var fn = eval("tp.On_" + id + "_DbClickItem");

		if(typeof(fn) == 'function')
		{
			eval("tp.On_" + id + "_DbClickItem(record, index, allItems)");
		}
	},
	
	On_Send_DbClickItem : function(record, index, allItems)
	{
		var id = RightTabContainer.activeTab.id.split("_")[0];
		var tp = eval("GW." + id);
		var fn = eval("tp.On_" + id + "_Send_DbClickItem");

		if(typeof(fn) == 'function')
		{
			eval("tp.On_" + id + "_Send_DbClickItem(record, index, allItems)");
		}
	},

	On_Copy_DbClickItem : function(record, index, allItems)
	{
		var id = RightTabContainer.activeTab.id.split("_")[0];
		var tp = eval("GW." + id);
		var fn = eval("tp.On_" + id + "_Copy_DbClickItem");

		if(typeof(fn) == 'function')
		{
			eval("tp.On_" + id + "_Copy_DbClickItem(record, index, allItems)");
		}
	},
	
    ShowMask: function() {
        var BodyElement = Ext.getBody();
        var mask = new Ext.LoadMask(BodyElement, { msg: GetResource('LoadingMsg') });
        mask.show();
    },
    
    HideMask: function(){
        var BodyElement = Ext.getBody();
        var mask = new Ext.LoadMask(BodyElement, { msg: GetResource('LoadingMsg') });
        mask.hide();        
    },
    
	ValidateEmail : function(value) {
		var email = /^([\w]+)(.[\w]+)*@([\w-]+\.){1,5}([A-Za-z]){2,4}$/;
		return email.test(value);
	},

	FadeOutMainLoadMask : function() {
		setTimeout(function(){
			Ext.get('loading').remove();
			Ext.get('loading-mask').fadeOut({remove:true});
		}, 1000);
	},

	ConfirmMessageBox : function(text, callback) {
		if(callback) {
			Ext.MessageBox.show({
				title: GetResource("Confirm"),
				msg: text,
				fn: callback,
				scope: this,
				buttons: Ext.MessageBox.YESNO,
				icon: Ext.MessageBox.QUESTION
			});		
		
		} else {
			Ext.MessageBox.show({
				title: GetResource("Confirm"),
				msg: text,
				scope: this,
				fn: function(buttonId, text)
				{
					if(buttonId == "no") return false;
				},
				buttons: Ext.MessageBox.YESNO,
				icon: Ext.MessageBox.QUESTION
			});		
		}
	},	
	
	ErrorMessageBox : function(text, callback) {
		if(callback) {
			Ext.MessageBox.show({
				title: GetResource("Error"),
				msg: text,
				fn: callback,
				scope: this,
				buttons: Ext.MessageBox.OK,
				icon: Ext.MessageBox.ERROR
			});		
		
		} else {
			Ext.MessageBox.show({
				title: GetResource("Error"),
				msg: text,
				buttons: Ext.MessageBox.OK,
				icon: Ext.MessageBox.ERROR
			});		
		}
	},

	InfoMessageBox : function(text, callback) {
		if(callback) {
			Ext.MessageBox.show({
				title: GetResource("Info"),
				msg: text,
				fn: callback,
				scope: this,				
				buttons: Ext.MessageBox.OK,
				icon: Ext.MessageBox.INFO
			});		
		} else {
			Ext.MessageBox.show({
				title: GetResource("Info"),
				msg: text,
				buttons: Ext.MessageBox.OK,
				icon: Ext.MessageBox.INFO
			});		
		}
	},

	WarningMessageBox : function(text, callback) {
		if(callback) {
			Ext.MessageBox.show({
				title: GetResource("Warning"),
				msg: text,
				fn: callback,
				scope: this,				
				buttons: Ext.MessageBox.OK,
				icon: Ext.MessageBox.WARNING
			});		
		} else {
			Ext.MessageBox.show({
				title: GetResource("Warning"),
				msg: text,
				buttons: Ext.MessageBox.OK,
				icon: Ext.MessageBox.WARNING
			});		
		}
	},
	
    RendererWithTooltip: function(value, meta, record, rowIndex, colIndex, store) {
		if(typeof value == "string" && value.length > 0)
			meta.attr = meta.attr + ' ext:qtip="' + value + '" ';
			
		if(record.data.Change != undefined)
		{
			if(record.data.Change != "" && record.data.Change != "true")
			{
				//debugger;
				meta.attr = meta.attr + ' style="color:gray"'
			}
		}
		
		return value;
    },

    RenderIcon: function(value, meta, record, rowIndex, colIndex, store) {
        if (typeof value == "string" && value.length > 0) {
            return "<img src='/Resources/Images/Icon/" + value + ".png' alt='' />";
        }
        return value;
    },

	IsInnerCompany : function(){
		if(this.CompanyCombo){
			return this.CompanyCombo.getActiveItem().isRelative === "N";
		}else{
			return true;
		}
	},
	
    RendererUserName: function(value, meta, record, rowIndex, colIndex, store) {
		var strName = value;
		// 메일 조직도에서는 리스트에 자회사일 경우 부서가 보여진다.
		if(record.data.Type != "USER")
		{
			// 부서 또는 그룹이다
			// 스타일 변경
			meta.attr = meta.attr + ' style="position:relative;overflow:visible;font-weight:700;color:#800000;" ';
		}
		// 자회사인 경우에만
		if(this.IsInnerCompany()) {
		    // Presence 삭제 (2010-11-25)
			// Presence를 렌더링 해준다.
			// 자회사인 경우는 사번이 항상 있다.
//			if(record.data.Email != "" && record.data.Type == "USER")
//			{
//				if(record.data.LoginID.length < 1) { 
//					alert("Employee number information doesn't exist.");//alert('사번이 없는 유저');
//				} else {
//					var presence = GW.NameControl.toHTMLString(record.data.Email, record.data.LoginID);
//					strName = presence + strName;
//				}
//			}
		}
		
		// tooltip의 내용을 자세하게 ~
		if(typeof value == "string" && value.length > 0) {
			var title = record.data.ADDisplayName;
			if(record.data.Type != "USER" || title == "")
			{
				title = record.data.UserName;
			}
			var qtiptitle = ' ext:qtitle="' + Ext.util.Format.htmlEncode(title) + '"  ext:qtip="';
			var qtip = '';
			if(record.data.LoginID != "") {
				if(record.data.Type == "USER") {
					qtip += GetResource("UserEmpID") + ': ' + Ext.util.Format.htmlEncode(record.data.EmpID) + '<br/>';
				}
			}			
			if(record.data.RankName != "") {
				qtip += GetResource("UserRank") + ': ' + Ext.util.Format.htmlEncode(record.data.RankName) + '<br/>';
			}			
			if(record.data.DeptName != "") {
				qtip += GetResource("UserDept") + ': ' + Ext.util.Format.htmlEncode(record.data.DeptName) + '<br/>';
			}
			if(record.data.Email != "") {
				qtip += GetResource("UserEmail") + ': ' + Ext.util.Format.htmlEncode(record.data.Email) + '<br/>';
			}
			if(record.data.CellPhone != "") qtip += GetResource("UserCellPhone") + ': ' + Ext.util.Format.htmlEncode(record.data.CellPhone) + '<br/>';
			if(record.data.ExtensionNumber != "") qtip += GetResource("UserOfficeTel") + ': ' + Ext.util.Format.htmlEncode(record.data.ExtensionNumber) + '<br/>';
			if(record.data.FaxNumber != "") qtip += GetResource("UserFax") + ': ' + Ext.util.Format.htmlEncode(record.data.FaxNumber) + '<br/>';
			
			if(qtip === '') {
				meta.attr = meta.attr + 'ext:qtip="' + Ext.util.Format.htmlEncode(title) + '" ';
			} else {
				meta.attr = meta.attr + qtiptitle + qtip + '" ';
			}

			if(record.data.Change != undefined)
			{
				if(record.data.Change != "" && record.data.Change != "true")
				{
					//debugger;
					meta.attr = meta.attr + ' style="color:gray"'
				}
			}
		}
		return strName;
    }
};

// 다국어처리를 위한 버튼
Ext.ux.LanguageCycleButton = Ext.extend(Ext.CycleButton, {
	languageItems:[
		{ language: 'ko', text: '한글', iconCls: 'sk-korea' },
		{ language: 'en', text: 'English', iconCls: 'sk-english' },
		{ language: 'cn', text: '中文', iconCls: 'sk-china' },
        { language: 'es', text: 'Español', iconCls: 'sk-spanish' }
	],
	
	initComponent: function() {
		Ext.apply(this, {
		    showText: true,
			prependText: '&nbsp;',
   			items: this.languageItems
		});
		if(g_langCode) {
        	var selectedLanguage = g_langCode; 
            if(selectedLanguage){ 
				for(var i=0; i<this.items.length;i++){
					if (this.items[i].language == selectedLanguage){
						this.items[i].checked = true;
						break;
					}
				}
            } 
        } else {
			// 디폴트 한국어
			this.items[0].checked = true;
        }
		Ext.ux.LanguageCycleButton.superclass.initComponent.apply(this, arguments);
	},
	
	changeHandler: function(o, i) {
		var params = Ext.urlDecode(window.location.search.substring(1), true);
		params.langCode = i.language;
		window.location.search = Ext.urlEncode(params);
	}
});

GW.Common = new GW.SetLine.Common();

function fn_GetUserInfo(record)
{
	var user = new Object();

	user.UserName			= record.data.UserName;
	user.Email				= record.data.Email;
	user.LoginID				= record.data.LoginID;
	user.AccountType		= record.data.Type;
	user.DeptCode			= record.data.DeptCode;
	user.DeptName			= record.data.DeptName;
	user.RankCode           = record.data.RankCode;
	user.RankName           = record.data.RankName;
	user.JobCode            = record.data.JobCode;
	user.JobName			= record.data.JobName;
	user.DutyName			= record.data.DutyName;
	user.DutyCode			= record.data.DutyCode;
	user.EmpID				= record.data.EmpID;
	user.CellPhone			= record.data.CellPhone;
	user.TeamChiefYN = record.data.TeamChiefYN;
	user.CompanyCode = record.data.CompanyCode;
	user.CompanyName = record.data.CompanyName;
	user.SignID = record.data.SignID;
	user.InternalPhone = record.data.ExtensionNumber;
	user.Culture				= g_langCode;
	user.ExtraInfo			= "";
	user.AgentId				= "";
	user.AgentName = "";
	
	if(record.data.Information != null && record.data.Information != undefined)
		user.Information			= record.data.Information;
	else
		user.Information			= "";
	
	return user;
}

function fn_AddNode(parent, name)
{
	var node = null;
    
	node = Awx.createElement(name);
	parent.appendChild(node);
    
	return node;
}

function fn_AddAttribute(node, name, value)
{
	var attribute = null;
	if(value == null) value = "";
	    
	attribute = Awx.createAttribute(name);
	attribute.value = value;
	node.attributes.setNamedItem(attribute);
    
	return attribute;
}

function fn_AddHistory(parent, ref)
{
    var node = null;
    
    node = fn_AddNode(parent, "History");
    fn_AddAttribute(node, "Seq", ref);
    
    return node;
}

function fn_AddAgree(parent, ref)
{
	var node = null;
    
	node = fn_AddNode(parent, "Agree");
	fn_AddAttribute(node, "Ref", ref);
    
	return node;
}

function fn_AddAcl(parent, ref)
{
	var node = null;
    
	node = fn_AddNode(parent, "Acl");
	fn_AddAttribute(node, "Type", ref);
    
	return node;
}

function fn_AddApprover(parent, user, task_id, order)
{
    var node = null;
    var attribute = null;
    
    node = fn_AddNode(parent, "Approver");
    
    fn_AddAttribute(node, "EmpID",			user.EmpID);
    fn_AddAttribute(node, "LoginID",			user.LoginID);
    fn_AddAttribute(node, "UserName",		user.UserName);
    fn_AddAttribute(node, "DeptCode",		user.DeptCode);
    fn_AddAttribute(node, "DeptName",		user.DeptName);
    fn_AddAttribute(node, "RankCode",		user.RankCode);
    fn_AddAttribute(node, "RankName",		user.RankName);
    fn_AddAttribute(node, "DutyCode",		user.DutyCode);
    fn_AddAttribute(node, "DutyName",		user.DutyName);
	fn_AddAttribute(node, "JobCode",		user.JobCode);
	fn_AddAttribute(node, "JobName",		""); //user.JobName);
    fn_AddAttribute(node, "Email",			user.Email);
    fn_AddAttribute(node, "CellPhone",		user.CellPhone);
    fn_AddAttribute(node, "InternalPhone",	user.InternalPhone);
    fn_AddAttribute(node, "Culture",			user.Culture);
    fn_AddAttribute(node, "TeamChiefYN", user.TeamChiefYN);
    fn_AddAttribute(node, "CompanyCode", user.CompanyCode);
    fn_AddAttribute(node, "CompanyName", user.CompanyName);
    fn_AddAttribute(node, "SignID", user.SignID);
    fn_AddAttribute(node, "TaskID",			task_id);
    fn_AddAttribute(node, "WorkItem",      "");
    fn_AddAttribute(node, "State",			"");
    fn_AddAttribute(node, "Status",			"");
    fn_AddAttribute(node, "Opinion",			"");
    fn_AddAttribute(node, "Date",				"");
    fn_AddAttribute(node, "Updated",       "0");
    fn_AddAttribute(node, "Order",			order);
    fn_AddAttribute(node, "ExtraInfo",		user.ExtraInfo);
    fn_AddAttribute(node, "AgentId",        user.AgentId);
    fn_AddAttribute(node, "AgentName",	user.AgentName);
    fn_AddAttribute(node, "Information",	user.Information);
    
    return node;
}

function fn_AddMember(parent, user) {
    var node = null;
    var attribute = null;

    node = fn_AddNode(parent[0], "Member");

    fn_AddAttribute(node, "EmpID", user.EmpID);
    fn_AddAttribute(node, "LoginID", user.LoginID);
    fn_AddAttribute(node, "UserName", user.UserName);
    fn_AddAttribute(node, "DeptCode", user.DeptCode);
    fn_AddAttribute(node, "DeptName", user.DeptName);
    fn_AddAttribute(node, "RankCode", user.RankCode);
    fn_AddAttribute(node, "RankName", user.RankName);
    fn_AddAttribute(node, "DutyCode", user.DutyCode);
    fn_AddAttribute(node, "DutyName", user.DutyName);
    fn_AddAttribute(node, "JobCode", user.JobCode);
    fn_AddAttribute(node, "JobName", ""); //user.JobName);
    fn_AddAttribute(node, "Email", user.Email);
    fn_AddAttribute(node, "CellPhone", user.CellPhone);
    fn_AddAttribute(node, "InternalPhone", user.InternalPhone);
    fn_AddAttribute(node, "Culture", user.Culture);
    fn_AddAttribute(node, "TeamChiefYN", user.TeamChiefYN);
    fn_AddAttribute(node, "CompanyCode", user.CompanyCode);
    fn_AddAttribute(node, "CompanyName", user.CompanyName);
    fn_AddAttribute(node, "SignID", user.SignID);

    return node;
}

function fn_CreateUserInfo(strUserInfo) {
    var user_info = strUserInfo.split("|");
    var user = null;

    user = new Object();

    user.EmpID = user_info[0];
    user.LoginID = user_info[1];
    user.UserName = user_info[2];
    user.DeptCode = user_info[3];
    user.DeptName = user_info[4];
    user.RankCode = user_info[5];
    user.RankName = user_info[6];
    user.JobCode = "";
    user.JobName = "";
    user.DutyCode = user_info[7];
    user.DutyName = user_info[8];
    user.Email = user_info[9];
    user.CellPhone = user_info[10];
    user.InternalPhone = user_info[11];
    user.Culture = user_info[12];
    user.TeamChiefYN = user_info[13];
    user.CompanyCode = user_info[14];
    user.CompanyName = user_info[15];
    user.SignID = user_info[16];
    user.TaskID = user_info[17];
    user.State = user_info[18];
    user.Status = user_info[19];
    user.Opinion = user_info[20];
    user.Date = user_info[21];
    user.Updated = user_info[22];
    user.Order = user_info[23];
    user.ExtraInfo = user_info[24];
    user.AgentId = user_info[25];
    user.AgentName = user_info[26];
    user.Information = user_info[27];

    return user;
}

function fn_GetOrder(strUserInfo)
{
    var user_info = strUserInfo.split("|");
    return user_info[22]; 
}


function fn_IsAgree(taskId)
{
    var tmp = taskId.split("_");
    if(tmp[0].toLowerCase() == "before" || tmp[0].toLowerCase() == "after")
    {
        return true; 
    }
    if(tmp.length > 1)
    {
		if(tmp[1].toLowerCase() == "after")
		{
			return true;
		}
    }
    return false;
}

function LoadWord(strAwx, line, multi, send, copy, culture)
{
	Awx.loadXML(strAwx);
	AwxXml = Awx.documentElement;
	
	var formType = null;
	
	formType = AwxXml.getAttribute("FormFile");
		
	//결재선
	line_type = line;
	//다중협조
	is_agree_multi = multi;
	
	if(formType != null)
	{
		switch(formType)
		{
			case "0" :
				//통보서
				//수신
				is_send = send;
				//참조
				is_copy = copy;
				break;
				
			case "1" :
				//품의서
				break;

			case "2" :
				//대외공문
				//참조
				is_copy = copy;
				break;
				
			default :
				//수신
				is_send = send;
				//참조
				is_copy = copy;
				break;
		}
	}
	
	//결재단계
	is_seq = 0;
	//워드결재(비정형)
	is_word = true;
	//사용언어
	if(culture != "" && culture != null && culture != undefined)
	{
		ui_culture = culture;
	}

	Initialization();
	
	GW.Org = new GW.SetLine.Org();
	GW.NameControl = new GW.PresenceMgr();
	GW.AppArchiveWord = new GW.SetLine.AppArchiveWord();
	GW.AclArchiveWord = new GW.SetLine.AclArchiveWord();
	GW.Acl = new GW.SetLine.Acl();
	GW.ApproverAgree = new GW.SetLine.ApproverAgree();
	
	Ext.onReady( function() { new GW.SetLine.Main(); } );
}

/********************************************************************************************
    함수명        : fn_PresenceRender()
    작성목적     : Presence 렌더링
                        Parameter :
                        Return : 
    작성자        : 
    최초작성일   : 2007-08-17
    최종작성일   :
    수정내역      :
********************************************************************************************/ 
var strHTML = "";

function fn_PresenceRender()
{
	var histories_node = $(AwxXml).find('Histories History');
	var app_title = GetResource("Approver");
	
	strHTML += '<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #eeeeee; background-color:#ffffff; FONT-SIZE: 12px; COLOR: #333333;">';
	strHTML += '<tr height="20" bgcolor="#E9E6D4">';
	strHTML += '<td>';
	strHTML += '<span style="font-weight:bold; FONT-SIZE: 12px; COLOR: #5B5B5B;">' + app_title + '</span>';
	strHTML += '</td>';
	strHTML += '</tr>';

	for(var k=0; k< histories_node.length; k++)
	{
	    var history_node = $(AwxXml).find('Histories History[Seq=' + k + ']')[0];
		
		if(history_node != null)
		{
			var ext_cnt = 0;
			var emp_node = null;
			var app_node = null;
			var ext_node = null;
			
			for(var i=0; i<history_node.childNodes.length; i++)
			{
				if(history_node.childNodes[i].nodeName == "Approver")
				{
					task_id = history_node.childNodes[i].attributes.getNamedItem("TaskID").value;

					if(task_id.indexOf("r") == 0)
					{
						ext_cnt++;
					}
					else if(task_id.indexOf("e") == 0)
					{
						emp_node = $(history_node).find("Approver[TaskID='emp" + k + "']")[0];
					}
					else if(task_id.indexOf("a") == 0)
					{
						app_node = $(history_node).find("Approver[TaskID='app" + k + "']")[0];						
					}
				}
			}
			
			//기안자
			fn_ApproverRender(emp_node);
			for(var j=1; j<ext_cnt+1; j++)
			{
				ext_node = $(history_node).find("Approver[TaskID='r" + k + "00" + j + "']");
				//검토자
				fn_ApproverRender(ext_node)
			}
			//승인자
			fn_ApproverRender(app_node);
		}
	}
	strHTML += '</table><br/>';

	for(var k=0; k< histories_node.length; k++)
	{
	    var history_node = $(AwxXml).find('Histories History[Seq=' + k + ']')[0];

		if(history_node != null)
		{
			var before_agrees = null;
			var after_agrees = null;
			
			if(is_agree_before)
			{
				before_agrees = $(history_node).find("Agree[Ref='before'] Approver")[0];
				
				if(before_agrees != null)
				{
					if(before_agrees.length > 0)
					{
						if(k < 1)
						{   
							strHTML += '<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #eeeeee; background-color:#ffffff; FONT-SIZE: 12px; COLOR: #333333;">';
							strHTML += '<tr height="20" bgcolor="#E9E6D4">';
							strHTML += '<td>';
							if (form_name.toUpperCase() == "ERPBUDGETCHANGE") // 운영예산(증감) 양식일 경우 결재선 협조자 타이틀 변경 2007.10.23 이영호
							{
							    strHTML += '<span style="font-weight:bold; FONT-SIZE: 12px; COLOR: #5B5B5B;">' + GetResource("BeforeApproves") + '</span>';									
							}
							else
							{
								strHTML += '<span style="font-weight:bold; FONT-SIZE: 12px; COLOR: #5B5B5B;">' + GetResource("BeforeAgrees") + '</span>';
							}
							//strHTML += '<span style="font-weight:bold; FONT-SIZE: 12px; COLOR: #5B5B5B;"><asp:literal runat="server" text="<%$ Resources:Document, BeforeAgrees %>"/></span>';
							strHTML += '</td>';
							strHTML += '</tr>';							
						}

						for(var b=0; b<before_agrees.length; b++)
						{
							//전협조
							fn_ApproverRender(before_agrees[b]);
						}
						
						if(k == histories_node.length-1)
						{
							strHTML += '</table><br/>';
						}
					}
				}
			}
			
			if(is_agree_before && is_agree_after)
			{
				after_agrees = $(history_node).find("Agree[Ref='after'] Approver");
				
				if(after_agrees != null)
				{
					if(after_agrees.length > 0)
					{
						if(k < 1)
						{
							strHTML += '<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #eeeeee; background-color:#ffffff; FONT-SIZE: 12px; COLOR: #333333;">';
							strHTML += '<tr height="20" bgcolor="#E9E6D4">';
							strHTML += '<td>';
							
							if (form_name.toUpperCase() == "ERPBUDGETCHANGE") // 운영예산(증감) 양식일 경우 결재선 협조자 타이틀 변경 2007.10.23 이영호
							{
								strHTML += '<span style="font-weight:bold; FONT-SIZE: 12px; COLOR: #5B5B5B;">' + GetResource("AfterApproves") + '</span>';
							}
							else
							{
							    strHTML += '<span style="font-weight:bold; FONT-SIZE: 12px; COLOR: #5B5B5B;">' + GetResource("AfterAgrees") + '</span>';									
							}
							//strHTML += '<span style="font-weight:bold; FONT-SIZE: 12px; COLOR: #5B5B5B;"><asp:literal runat="server" text="<%$ Resources:Document, AfterAgrees %>"/></span>';
							strHTML += '</td>';
							strHTML += '</tr>';							
						}
						
						for(var a=0; a<after_agrees.length; a++)
						{
							//후협조
							fn_ApproverRender(after_agrees[a]);
						}
						
						if(k == histories_node.length-1)
						{
							strHTML += '</table>';
						}							
					}
				}
			}

			if(!is_agree_before && is_agree_after)
			{
				after_agrees = $(history_node).find("Agree[Ref='after'] Approver");

				if(after_agrees != null)
				{
					if(after_agrees.length > 0)
					{
						if(k < 1)
						{
							strHTML += '<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #eeeeee; background-color:#ffffff; FONT-SIZE: 12px; COLOR: #333333;">';
							strHTML += '<tr height="20" bgcolor="#E9E6D4">';
							strHTML += '<td>';
							strHTML += '<span style="font-weight:bold; FONT-SIZE: 12px; COLOR: #5B5B5B;">' + GetResource("Agree") + '</span>';
							strHTML += '</td>';
							strHTML += '</tr>';							
						}
						
						for(var a=0; a<after_agrees.length; a++)
						{
							//협조
							fn_ApproverRender(after_agrees[a]);
						}
						
						if(k == histories_node.length-1)
						{
							strHTML += '</table>';
						}
					}
				}
			}				
		}
	}
	return strHTML;
}

/********************************************************************************************
    함수명        : fn_ApproverRender(node)
    작성목적     : 해당 노드의 이메일과 사용자 이름으로 Presence를 렌더링 한다.
                        Parameter :
                        Return : 
    작성자        :
    최초작성일   : 2007-08-17
    최종작성일   :
    수정내역      :
********************************************************************************************/ 
function fn_ApproverRender(node)
{
	var user_name = null;
	var email = null;
	
	if(node != null)
	{
		user_name = node.getAttribute("UserName");
		email = node.getAttribute("Email");

		if(user_name != "" && user_name != null)
		{
			strHTML += '<tr height="20">';
			strHTML += '<td style="padding-top:2px; padding-left:10px">';
			strHTML += '<table border="0" border="0" cellpadding="0" cellspacing="0">';
			strHTML += '<tr>';
			strHTML += '<td width="23" style="vertical-align:top; text-align:left"><img src="/CmnApv/Images/normal/presence/blank.gif" ShowOfflinePawn="1" border="0" onload="IMNRC(\'' + email + '\')" id="' + Math.random() + '"></td>';
			strHTML += '<td>' + user_name + "</td>"; 
			strHTML += '</td>';
			strHTML += '</tr>';
			strHTML += '</table>';
			strHTML += '</td>';
			strHTML += '</tr>';
		}
	}
}
