/**
 * orgmap.ocs.js
 * OCS 2007 Tab에서 불려지는 조직도
 * 홍정화(caoko@miksystem.com)
 */
 
// 조직도 DATA
var APPDataFields = [
	{ name: 'DisplayName' }, 	// Name
	{name: 'ADDisplayName' }, 	// AD의 DisplayName(사용자의 경우)
	{name: 'entryType' }, 		// 0: 부서, 1: 그룹, 2:사용자
	{name: 'addr' }, 			// 이메일주소	
	{name: 'AccountId' }, 		// 사용자 로그인 ID(도메인 없음)
	{name: 'DeptName' }, 		// 부서이름
	{name: 'DeptCode' }, 		// 부서코드
	{name: 'RankCode' }, 		// 직위
    {name: 'RankName' }, 		// 직위
	{name: 'JobCode' }, 		// 직책
	{name: 'JobName' }, 		// 직책
	{name: 'DutyCode' }, 		// 직무코드
	{name: 'DutyName' }, 		// 직무
	{name: 'CompanyCode' }, 	// 회사코드
	{name: 'CompanyName' }, 	// 회사이름
	{name: 'EmpID' }, 			// 사번
	{name: 'CellPhone' }, 		// 휴대폰
	{name: 'ExtensionNumber' }, // 사내전화번호
	{name: 'FaxNumber' }, 		// Fax번호
	{name: 'TeamChiefYN'}		// 팀장여부	
];

// 조직도가 OC에서 불려졌을 경우, SMS 발송 기능, 메신저에 추가 기능
GW.OrgMap.Common.Ocs = function() {
	//private
	GW.OrgMap.Common.Ocs.superclass.constructor.call(this);
	this.OrgChartType = "OCS";
	
	this.OrgMapData = null;
	Ext.apply(this, window.dialogArguments);

	// NOTE: OCSSmartClient로 OC에 대화상대 추가 기능이 구현되어야 함.
	// <object> 태그 필요~
	// document load complete 전에 렌더링 되야 함.
	//this.OCSSmartClient = document.getElementById("OCSmart");
	
	this.dsSource = new Ext.data.JsonStore({
		url: g_OrgMapServerURL,
		root: 'dataRoot',
		baseParams:{ action: 'getMemberListForApp', isOnlyUser: "Y" },
		fields: APPDataFields,
		remoteSort: false
	});
	this.dsResult = new Ext.data.JsonStore({fields: APPDataFields});
	
	// 선택그리드
	this.SelectCheck = new Ext.grid.CheckboxSelectionModel();
	this.SelectColumn = new Ext.grid.ColumnModel([
		this.SelectCheck,
		{header:getResource("UserRank"),	  dataIndex: 'RankName', 		menuDisabled: true, width:45, renderer:this.RendererWithTooltip},
		{header:getResource("UserName"),	  dataIndex: 'DisplayName',		menuDisabled: true,	width:65, renderer:this.RendererDisplayName.createDelegate(this)},
		{header:getResource("UserEmpID"),	  dataIndex: 'EmpID',			menuDisabled: true,	width:55, renderer:this.RendererWithTooltip},
		{header:getResource("UserJob"), 	  dataIndex: 'JobName',		menuDisabled: true,	width:80, renderer:this.RendererWithTooltip}			
	]);
	this.SelectGrid = new Ext.grid.GridPanel({
		region:'center',
		margins: '5 5 0 5',
		ddGroup:'SelectGridDDGroup',
		enableDragDrop:true,
		enableColumnMove:false,
		ds: this.dsSource,
		cm: this.SelectColumn,
		sm: this.SelectCheck,
		stripeRows:true,
		title:'&nbsp;&nbsp;',
		loadMask:{msg:getResource("WaitMsg")}
	});
	// 결과그리드
	this.ResultCheck = new Ext.grid.CheckboxSelectionModel();
	this.ResultColumn = new Ext.grid.ColumnModel([
		this.ResultCheck,
		{header:getResource("UserName"), dataIndex: 'ADDisplayName', menuDisabled: true, width:50, renderer:this.RendererADDisplayName.createDelegate(this)}
	]);
	this.ResultGrid = new Ext.grid.GridPanel({
		region:'east',
		margins: '5 5 0 0',
		ddGroup:'ResultGridDDGroup',
		enableDragDrop:true,
		enableColumnMove:false,
		ds: this.dsResult,
		cm: this.ResultColumn,
		sm: this.ResultCheck,
		stripeRows:true,
		viewConfig: {
			//autoFill:true,
			forceFit:true
		},
		bbar:['->',
			{
				tooltip:{title:getResource("Add"), text:getResource("AddTooltip")},
				iconCls:'add',
				text:getResource("Add"),
				handler: this.OnAddHandler,
				scope: this
			},
			{
				tooltip:{title:getResource("Remove"), text:getResource("RemoveTooltip")},
				iconCls:'delete',
				text:getResource("Remove"),
				handler: this.OnRemoveHandler,
				scope: this
			},
			{
				tooltip:{title:getResource("RemoveAll"), text:getResource("RemoveAllTooltip")},
				iconCls:'cross',
				text:getResource("RemoveAll"),
				handler: this.OnRemoveAllHandler,
				scope: this
			}
		],
		title:getResource("ResultBox"),
		width:240
	});
	
	this.dsSource.on('datachanged', this.OnDsSourceDataChanged, this);
	this.dsSource.on('beforeload', function() {
		// DATA가 변경될 때 Presence 정보를 reset 해줍니다.
		GW.NameControl.UnRegisterPresenceAll();
	}, this);
	
	this.getInitialize(function() {
		this.Render();
		this.InitializeDragdrop();
		// NOTE: 기존에 선택되었던 User가 다시 팝업될 때 
		// 선택된 상태로 나오게 하려고 할 경우
		// 처리해야 할 곳, 기존에 선택된 대상을 보여주는 걸로...
		if(this.OrgMapData && typeof this.OrgMapData == "string") {
			try{
				this.OrgMapData = Ext.decode(this.OrgMapData);
				this.dsResult.loadData(this.OrgMapData);
			} catch(ex) { }
		}
		this.fadeoutMainLoadMask();
	}, this);
};

Ext.extend(GW.OrgMap.Common.Ocs , GW.OrgMap.Common, {
	// 선택그리드의 DisplayName 렌더링, Presence와 함께
	RendererDisplayName : function(value, meta, record, rowIndex, colIndex, store) {
		var strName = value;
		// // 부서 또는 그룹 Style --> OCS에서 부서는 안가져온다.
		//if(record.data.entryType != 2)
		//{
		//	 부서 또는 그룹이다
		//	 스타일 변경
		//	meta.attr = meta.attr + ' style="position: relative; overflow: visible; font-weight: 700; color: #800000;" ';
		//}		
		// Presence를 렌더링 해준다.
		// 자회사인 경우는 사번이 항상 있다.
		if(record.data.addr != "" && record.data.entryType === 2)
		{
			if(record.data.EmpID.length < 1) { 
				//alert('사번이 없는 유저');
			} else {
				var presence = GW.NameControl.toHTMLString(record.data.addr, record.data.EmpID);
				strName = presence + strName;				
			}
		}
		
		// tooltip의 내용을 자세하게 ~
		if(typeof value == "string" && value.length > 0) {
			var title = record.data.ADDisplayName; //유저
			if(record.data.entryType != 2 || title == ""){
				title = record.data.DisplayName;
			}
			var qtiptitle = ' ext:qtitle="' + Ext.util.Format.htmlEncode(Ext.util.Format.htmlEncode(title)) + '"  ext:qtip="';
			var qtip = '';
			
			if(record.data.CompanyName != "") qtip += getResource("UserCompany") + ': ' + Ext.util.Format.htmlEncode(record.data.CompanyName) + '<br/>';
			if(record.data.EmpID != "" && record.data.Type == "USER") qtip += getResource("UserEmpID") + ': ' + Ext.util.Format.htmlEncode(record.data.EmpID) + '<br/>';
			if(record.data.RankName != "") qtip += getResource("UserRank") + ': ' + Ext.util.Format.htmlEncode(record.data.RankName) + '<br/>';
			if(record.data.DutyName != "") qtip += getResource("UserDuty") + ': ' + Ext.util.Format.htmlEncode(record.data.DutyName) + '<br/>';
			if(record.data.JobName != "") qtip += getResource("UserJob") + ': ' + Ext.util.Format.htmlEncode(record.data.JobName) + '<br/>';
			if(record.data.DeptName != "") qtip += getResource("UserDept") + ': ' + Ext.util.Format.htmlEncode(record.data.DeptName) + '<br/>';
			if(record.data.addr != "") qtip += getResource("UserEmail") + ': ' + Ext.util.Format.htmlEncode(record.data.addr) + '<br/>';
			if(record.data.CellPhone != "") qtip += getResource("UserCellPhone") + ': ' + Ext.util.Format.htmlEncode(record.data.CellPhone) + '<br/>';
			if(record.data.ExtensionNumber != "") qtip += getResource("UserOfficeTel") + ': ' + Ext.util.Format.htmlEncode(record.data.ExtensionNumber) + '<br/>';
			if(record.data.FaxNumber != "") qtip += getResource("UserFax") + ': ' + Ext.util.Format.htmlEncode(record.data.FaxNumber) + '<br/>';
			
			if(qtip === '') {
				meta.attr = meta.attr + 'ext:qtip="' + Ext.util.Format.htmlEncode(title) + '" ';
			} else {
				meta.attr = meta.attr + qtiptitle + qtip + '" ';
			}
		}
		return strName;	
	},
	
	// 결과그리드의 이름 렌더링
	RendererADDisplayName : function(value, meta, record, rowIndex, colIndex, store) {
		// ADDisplayName이 공백일 수 있다. (부서, 그룹, 없을 경우) DisplayName으로 보여준다.
		var strName = value;
		
		if(record.data.entryType != 2 || strName == ""){
			if(record.data.DisplayName != "") strName = record.data.DisplayName;	
			else strName = record.data.DeptName;
		}
				
		//tootip ( ext:qtip="")
		if(typeof strName == "string" && strName.length > 0) {
			if(this.ValidateEmail(record.data.addr)) {
				meta.attr = meta.attr + ' ext:qtitle="' + Ext.util.Format.htmlEncode(Ext.util.Format.htmlEncode(strName)) + '"  ext:qtip="' 
				+ getResource("UserEmail") + ': ' + Ext.util.Format.htmlEncode(record.data.addr) + '<br/>' + '" ';
			} else {
				meta.attr = meta.attr + ' ext:qtip="' + Ext.util.Format.htmlEncode(strName) + '" ';
			}
		}
		return strName;
	},

	AllSelectionClear : function() {
		this.SelectCheck.clearSelections();
		this.ResultCheck.clearSelections();

		// header force uncheck
		var selectHeader = this.SelectGrid.getView().getHeaderCell(0).childNodes[0];
		var resultHeader = this.ResultGrid.getView().getHeaderCell(0).childNodes[0];
		
		Ext.get(selectHeader).removeClass('x-grid3-hd-checker-on');
		Ext.get(resultHeader).removeClass('x-grid3-hd-checker-on');	
	},
	
	// Drag & Drop 설정을 해준다.
	InitializeDragdrop : function() {
		var mask = new Ext.LoadMask(this.ResultGrid.getView().el, {msg:getResource("WaitMsg")});
		var dsResult = this.dsResult;
		var clearCheck = this.AllSelectionClear.createDelegate(this);
		var validateEmail = this.ValidateEmail;
		var warningMsgBox = this.WarningMessageBox;
		
		this.SelectDropTarget = new Ext.dd.DropTarget(this.SelectGrid.getView().el.dom.childNodes[0].childNodes[1], {
			ddGroup: 'ResultGridDDGroup',
			notifyDrop: function(ddSource, e, data) {
				function removeRow(record, index, allItems) {
					ddSource.grid.store.remove(record);
				}
				mask.show();
				if(ddSource.dragData.selections.length == ddSource.grid.store.getCount()){
					ddSource.grid.store.removeAll();
				}else{
					Ext.each(ddSource.dragData.selections, removeRow);
				}
				mask.hide();
				clearCheck();
				return(true);
			}
		});

		this.ResultDropTarget = new Ext.dd.DropTarget(this.ResultGrid.getView().el.dom.childNodes[0].childNodes[1], {
			ddGroup: 'SelectGridDDGroup',
			notifyDrop: function(ddSource, e, data) {
				function addRow(record, index, allItems) {
					if(record.data.addr == "" && record.data.entryType == 2){// 사번비교
						var foundItem = dsResult.find('EmpID', record.data.EmpID);
						if (foundItem  == -1) {
							dsResult.add(record);
						}
					}else{// 메일주소로 비교
						var foundItem = dsResult.find('addr', record.data.addr);
						if (foundItem  == -1) {
							dsResult.add(record);
						}
					}
				}
				mask.show();
				if(ddSource.dragData.selections.length == ddSource.grid.store.getCount()
					&& dsResult.getCount() == 0)
				{
					dsResult.data = ddSource.grid.store.data.clone();
				}
				else
				{
					Ext.each(ddSource.dragData.selections, addRow);
				}
				mask.hide();
				dsResult.fireEvent("datachanged", dsResult);
				clearCheck();
				return(true);
			}
		});		
	},

	// 결과그리드의 추가버튼 처리
	OnAddHandler : function() {
		var mask = new Ext.LoadMask(this.ResultGrid.getView().el, {msg:getResource("WaitMsg")});
		if(this.SelectCheck.getSelections().length > 0){
			mask.show();
			if(this.dsResult.getCount() == 0 && this.dsSource.getCount() == this.SelectCheck.getSelections().length)
			{
				this.dsResult.data = this.dsSource.data.clone();
			}
			else
			{
				Ext.each(this.SelectCheck.getSelections(), function(record, index, allItems) {
					if(record.data.addr == "" && record.data.entryType == 2){// 사번비교
						var foundItem = this.dsResult.find('EmpID', record.data.EmpID);
						if (foundItem  == -1) {
							this.dsResult.add(record);
						}
					}else{// 메일주소로 비교
						var foundItem = this.dsResult.find('addr', record.data.addr);
						if (foundItem  == -1) {
							this.dsResult.add(record);
						}
					}				
				}, this );
			}
			this.dsResult.fireEvent("datachanged", this.dsResult);
			mask.hide();
		}
		this.AllSelectionClear();
	},
	
	// 결과그리드의 제거버튼 처리
	OnRemoveHandler : function() {
		var mask = new Ext.LoadMask(this.ResultGrid.getView().el, {msg:getResource("WaitMsg")});
		if(this.ResultCheck.getSelections().length > 0)
		{
			mask.show();
			if(this.ResultCheck.getSelections().length == this.dsResult.getCount())
			{
				this.dsResult.removeAll();
			}
			else
			{
				Ext.each(this.ResultCheck.getSelections(), function(record, index, allItems) {
					this.dsResult.remove(record);					
				}, this);				
			}
			this.dsResult.fireEvent("datachanged", this.dsResult);
			mask.hide();
		}
		this.AllSelectionClear();
	},
	
	// 결과그리드의 모두제거버튼 처리
	OnRemoveAllHandler : function() {
		var mask = new Ext.LoadMask(this.ResultGrid.getView().el, {msg:getResource("WaitMsg")});
		if(this.dsResult.getCount() > 0)
		{
			mask.show();
			this.dsResult.removeAll();
			this.dsResult.fireEvent("datachanged", this.dsResult);
			mask.hide();
		}
		this.AllSelectionClear();
	},
	
	// 선택그리드의 datachanage 이벤트
	OnDsSourceDataChanged : function(store) {		
		// 총 인원 수를 제목에 렌더링해준다.
		if(store.reader.jsonData.NumOfPerson){
			var num = store.reader.jsonData.NumOfPerson;
			var title = this.SelectGrid.title;
			title += " <span style='color:#e6ffff'>(" + getResource("Total") + num + getResource("PersonCount") + ")</span>";
			this.SelectGrid.setTitle(title);
		}
	},
			
	Render : function() {
		// NOTE: 여기서 OCS 조직도 제목을 설정합니다.
		var titleBox = this.getHeaderTitleBox();
		var searchBox = this.getEmpNameSearchBox();
		var treeBox = this.getCompanyDeptTree();
		var langCombo = new Ext.ux.LanguageCycleButton();

		// 검색박스
		var clearSearchBox = function(){
			var node = treeBox.getSelectionModel().getSelectedNode();
			if(node){
				var company = this.getCurrentCompany();
				this.dsSource.load({params:{companyCode:company.companyCode, isRelative:company.isRelative, mode:'dept', query:node.id}});
				this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
			}
			//searchBox.fireEvent('blur', searchBox);
			searchBox.focus(true, 300);
		};
		searchBox.ClearClick = clearSearchBox.createDelegate(this);
		var doSearchBox = function(){
			var strName = searchBox.getValue();
			if(strName != ''){
				if(strName.length >= 2 && strName.length < 8) {
					var special = /.*[$\\@\\\#%\^\&\*\(\)\[\]\+\_\;\'\{\}\`\\\~\<\>\=\|\.\,\:\?\/\"\!\-].*/;
					var alphanum = /^[a-zA-Z0-9_]+$/;
					if(strName.search(special) == 0){
						searchBox.setValue('');
						this.WarningMessageBox(getResource("NoUseSpecialMsg"), function(){
							searchBox.focus();
						});
						return false;
					} else if(alphanum.test(strName)) {
						// 사번검색  --> NOTE: 사번검색할 때 3자로 제한해야함. sk로 검색하면 대박.
						if(strName.length < 3) {
							searchBox.setValue('');
							this.WarningMessageBox(getResource("NoUseAlphaNumTwoWord"), function(){
								searchBox.focus();
							});
							return false;
						}
					}
					var company = this.getCurrentCompany();
					this.dsSource.load({params:{companyCode:company.companyCode, isRelative:company.isRelative, mode:'member', query:strName}});
					this.SelectGrid.setTitle('[' + strName + '] ' + getResource("SearchResult"));
					return true;
				} else{
					searchBox.setValue('');
					this.WarningMessageBox(getResource("UseSearch"), function(){
						searchBox.focus();
					});	
					return false;					
				}
			}
			return false;
		};
		searchBox.SearchClick = doSearchBox.createDelegate(this);
				
		treeBox.getLoader().on('load', function(treeLoader, node, response) {
			if(this.isInnerCompany()){
				if(node == treeBox.root){
					node.expandChildNodes();
				}
			}
			else if(treeBox.root.children && treeBox.root.children.length == 1){
				treeBox.root.expandChildNodes();
			}
		}, this);
		
		treeBox.getSelectionModel().on('selectionchange', function(t, node){
			if(node){
				node.ensureVisible();
				searchBox.onTrigger1Click(true);
				var company = this.getCurrentCompany();
				this.dsSource.load({params:{companyCode:company.companyCode, isRelative:company.isRelative, mode:'dept', query:node.id}});
				this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
			}
		}, this);
		
	    treeBox.getLoader().on('beforeload', function(treeLoader, node) {
	        if(treeLoader.baseParams){
				var company = this.getCurrentCompany();
				treeLoader.baseParams.companyCode = company.companyCode;
				treeLoader.baseParams.isRelative = company.isRelative;
	        }
		}, this);
				
		this.CompanyCombo.on("change", function(combo, item){
			treeBox.getRootNode().children = null;
			treeBox.getRootNode().reload();
			if(item.isRelative === "N"){
				if(item.companyCode === this.MyCompanyCode){
					treeBox.expandPath(this.MyDeptSelectPath);
					treeBox.selectPath(this.MyDeptSelectPath);
				}
			}
		}, this);
		
		// NOTE: 다국어 처리가 필요합니다.
		var mainPanel = new Ext.Panel({
			region: 'center',
			layout: 'border',
			border: false,
			bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
			tbar: [ '-',this.CompanyCombo,'-','->','-',searchBox,'-',langCombo,'-' ],
			items: [ treeBox, this.SelectGrid, this.ResultGrid ],
			buttons:[
			{
			    text: Language.SMSSend,
				handler: this.OnSendSMS,
				scope: this
			},
			{
                Language.AddMessenger,
				handler: this.OnAddBuddy,
				scope: this
			},
			{
                text: Language.Cancle,
				handler: this.OnCancel,
				scope: this
			}],
			buttonAlign:'center'
		});
		
		var viewport = new Ext.Viewport({
			layout: 'border',
			items:[titleBox, mainPanel]
		});
		
		viewport.doLayout();
		
		mainPanel.footer.applyStyles('background: #FFFFFF none repeat scroll 0 0;');
		
		treeBox.expandPath(this.MyDeptSelectPath);
		if(typeof this.SearchKeyword != "string"){
			treeBox.selectPath(this.MyDeptSelectPath);
		} else if(this.SearchKeyword && typeof this.SearchKeyword == "string"){
				searchBox.setRawValue(this.SearchKeyword);
				searchBox.onTrigger2Click();
				this.SearchKeyword = false;
		}
	},
	
	OnSendSMS : function() {
		// NOTE: SMS 발송 구현, 아래 코드는 기존 SK E&S에서 사용되었던 예시.
		this.InfoMessageBox("SMS 발송 Event-> OnSendSMS()");
		
	    // SMS 페이지로 넘겨줄 핸드폰 번호를 가져오고
        // SMS 페이지를 showModelessDialog로 띄운다.
		//var strList = "";
		//var strNoPhoneList = "";
		
		//if(this.dsResult.getCount() == 0) {
		//	this.WarningMessageBox("SMS 전송 대상을 선택해주십시오.");
		//	return;
		//}
		
		//var count = 0;
		//this.dsResult.each(function(Record) {
		//	++count;
		//	if(Record.data.CellPhone && Record.data.CellPhone.length >= 10) {
		//		strList += Record.data.CellPhone + "$$";
		//	} else {
		//		strNoPhoneList += Record.data.UserName + ", ";
		//	}
		//}, this);
		
		//if(strList.length > 0) {
        //    var sURL = '/CmnWeb/AddIn/OCS/SMS.aspx?snd=' + encodeURIComponent(this.UserEmail);
            // width 221
        //    var sFeatures = 'dialogWidth:240px;dialogHeight:550px;status:no;resizable:no;help:no;scroll=no'; 
        //    if(Ext.isIE6) {
        //        sFeatures = 'dialogWidth:240px;dialogHeight:600px;status:no;resizable:no;help:no;scroll=no';  
        //    }
        //    var vArguments = new Array();
        //    vArguments['snd'] = this.UserEmail;
        //    vArguments['recv'] = strList;
            		
		//	if(strNoPhoneList.length > 0) {
		//	    strNoPhoneList = strNoPhoneList.substring(0, strNoPhoneList.length - 2);
		//		this.InfoMessageBox(strNoPhoneList + "의 휴대폰 번호 정보가 없습니다.", function() {
		//		    window.showModelessDialog(sURL, vArguments, sFeatures);
		//		});
		//	} else {
		//	    window.showModelessDialog(sURL, vArguments, sFeatures);
		//	}       
		//} else {
		//	if(strNoPhoneList.length > 0) {
		//	    strNoPhoneList = strNoPhoneList.substring(0, strNoPhoneList.length - 2);
		//		this.WarningMessageBox(strNoPhoneList + "의 휴대폰 번호 정보가 없습니다.");
		//	} else {
				// case가 없다.
		//		this.ErrorMessageBox("알수 없는 오류가 발생했습니다.");
		//	}
		//}
	},
	
	OnAddBuddy : function() {
		// NOTE: 대화상대 추가 처리,  아래 코드는 기존 SK E&S에서 사용되었던 예시.
        this.InfoMessageBox(Language.AddContactEvent + "-> OnAddBuddy()");
		
	    //if(this.OCSSmartClient) {
		//	var strList = "";
		//	var strNoEmailList = "";
			
		//	if(this.dsResult.getCount() == 0) {
		//		this.WarningMessageBox("메신저에 추가할 대상을 선택해주십시오.");
		//		return;
		//	}
			
		//	var count = 0;
		//	var isDoAddSelf = false;
		//	this.dsResult.each(function(Record) {
		//		++count;
		//		if(Record.data.Email && Record.data.Email.length > 2) {
		//		    if(this.UserEmail === Record.data.Email)
		//		    {
		//		        isDoAddSelf = true;
		//		    }
		//		    else
		//		    {
		//		        strList += Record.data.Email + ";";
		//		    }
		//		} else {
		//			strNoEmailList += Record.data.UserName + ", ";
		//		}
		//	}, this);
			
		//	if(strNoEmailList.length > 0) {
        //        strNoEmailList = strNoEmailList.substring(0, strNoEmailList.length - 2);   
		//	}
			
		//	if(strList.length > 0) {
		//		var result = "";
				
		//		try {
		//			result = this.OCSSmartClient.AddBuddy(strList);
		//		} catch (e) { 
		//		    this.ErrorMessageBox("OCS Smart Client에서 오류가 발생했습니다.<br/>예외메시지는 다음과 같습니다.<br/><br/>"
		//		        + e.message);
		//		    return; 
        //        }
				
		//		if(result != "OK") {
		//			this.ErrorMessageBox("OCS Smart Client의 대화상대 추가 호출이 실패하였습니다.");
		//			return;
		//		}
		//		if(strNoEmailList.length > 0) {
		//		    if(isDoAddSelf == true)
		//		    {
		//			    this.InfoMessageBox("자신은 추가대상에 포함되지 않습니다.<br/>"
		//			        + "선택된 리스트의 메일주소 정보가 없는 " + strNoEmailList 
		//			        + " 와<br/> 자신을 제외하고 추가되었습니다.");				    
		//		    }
		//		    else
		//		    {
		//			    this.InfoMessageBox("선택된 리스트의 메일주소 정보가 없는 " + strNoEmailList 
		//			        + " 를<br/> 제외하고 추가되었습니다.");
		//			}
		//		} else {
		//		    if(isDoAddSelf == true)
		//		    {
		//		        this.InfoMessageBox("자신은 추가대상에 포함되지 않습니다.<br/>자신을 제외한 대상이 추가되었습니다.");
		//		    }
		//		    else
		//		    {				
		//			    this.InfoMessageBox("추가되었습니다.");
		//			}
		//		}
		//	} else {
		//		if(strNoEmailList.length > 0) {
		//			this.WarningMessageBox("선택된 리스트의 " + strNoEmailList + " 모두 메일 주소 정보가 없어서 추가하지 못했습니다.");
		//		} else {
        //            if(isDoAddSelf == true)
		//		    {
		//			    this.WarningMessageBox("자신을 메신저에 추가할 수 없습니다.");				    
		//		    }
		//		    else
		//		    {
		//		        this.ErrorMessageBox("알수 없는 오류가 발생했습니다.");
		//		    }					
		//		}
		//	}
		//} else {
		//	this.WarningMessageBox("OCS Smart Client DLL이 로딩되어 있지 않습니다.");
		//}
	},
	
	OnCancel : function() {
		if(this.dsResult.getCount() > 0) {
		    var json = '';
		    this.dsResult.each(function(store) {
		        json += Ext.encode(store.data) + ',';
		    });
		    json = json.substring(0, json.length - 1);
		    json = "[" + json + "]";
			window.returnValue = json;
		} else {
			window.returnValue = '';
		}

	    window.close();
	}
});
