/*
* SetLine.AclArchiveWord.js
* 워드 수신처/사본처 보관
*/

//서버 Ajax요청시
var AclArchiveWordServerURL = 'AclArchiveWordServer.aspx';

// 결재선보관 DATA
var AclArchiveWordDataFields = [
	{name: 'LINE_ID' }, //수신처/사본처 아이디
	{name: 'SUBJECT' }, //수신처/사본처 그룹명
	{name: 'XML_LINE' }, //수신처/사본처 정보
	{name: 'TYPE' } //타입 GROUP
];
	
GW.SetLine.AclArchiveWord = function() {

    this.ArchiveBox = this.GetAclArchiveWordNameBox();

    this.ReturnPanel = null;

    this.FormName = AwxXml.getAttribute("FormFile");
            
    // 수신처/사본처 보관
    this.AclArchiveWordResult = new Ext.data.JsonStore
	({
	    url: AclArchiveWordServerURL,
		root: 'dataRoot', 
	    fields: AclArchiveWordDataFields,
	    remoteSort: false
	});

    // 수신처
    this.SendArchiveWordResult = new Ext.data.JsonStore
	({
	    id: 'ArchiveSend',
	    fields: APPDataFields
	});

    // 사본처
    this.CopyArchiveWordResult = new Ext.data.JsonStore
	({
	    id: 'ArchiveCopy',
	    fields: APPDataFields
	});
	
    this.AclArchiveWordResult.load();
    
    //수신처/사본처 보관
    this.AclArchiveWordGridCheckBox = new Ext.grid.CheckboxSelectionModel();
    this.AclArchiveWordGridCheckBox.singleSelect = true;
    
    this.AclArchiveReaultCM = new Ext.grid.ColumnModel
	([
		this.AclArchiveWordGridCheckBox,
		{header: GetResource("GroupName"),		dataIndex: 'SUBJECT', 			menuDisabled: true,	width: 533,	renderer: this.RendererWithTooltip}
	]);

    this.AclArchiveWordGrid = new Ext.grid.GridPanel
	({
	    region: 'west',
	    margins: '5 5 5 5',
		width: 300, 
	    ddGroup: 'DDGArchiveAcl',
	    enableDragDrop: true,
	    enableColumnMove: false,
	    border: true,
	    ds: this.AclArchiveWordResult,
	    cm: this.AclArchiveReaultCM,
	    sm: this.AclArchiveWordGridCheckBox,
	    stripeRows: true,
	    viewConfig:
		{
		    autoFill: true,
		    forceFit: true
		},
	    loadMask: { msg: GetResource("WaitMsg") }
	});

    //수신처
    this.SendArchiveWordGridCheckBox = new Ext.grid.CheckboxSelectionModel();
    this.SendArchiveReaultCM = new Ext.grid.ColumnModel
	([
		this.SendArchiveWordGridCheckBox,
		{header: '&nbsp',		dataIndex: 'DisplayName', 			menuDisabled: true,	width: 533,	renderer: this.RendererWithTooltip}
	]);

    this.SendArchiveWordGrid = new Ext.grid.GridPanel
	({
	    title: GetResource("ArchivedSend"),
	    region: 'north',
	    margins: '5 5 0 0',
		height: 170, 
	    ddGroup: 'DDGArchiveSend',
	    enableDragDrop: true,
	    enableColumnMove: false,
	    border: true,
	    ds: this.SendArchiveWordResult,
	    cm: this.SendArchiveReaultCM,
	    sm: this.SendArchiveWordGridCheckBox,
	    stripeRows: true,
	    viewConfig:
		{
		    autoFill: true,
		    forceFit: true
		},
	    loadMask: { msg: GetResource("WaitMsg") }
	});
	
    //사본처
    this.CopyArchiveWordGridCheckBox = new Ext.grid.CheckboxSelectionModel();
    this.CopyArchiveReaultCM = new Ext.grid.ColumnModel
	([
		this.CopyArchiveWordGridCheckBox,
		{header: '&nbsp',		dataIndex: 'DisplayName', 			menuDisabled: true,	width: 533,	renderer: this.RendererWithTooltip}
	]);

    this.CopyArchiveWordGrid = new Ext.grid.GridPanel
	({
	    title: GetResource("ArchivedCopy"),
	    region: 'center',
	    margins: '5 5 5 0',
	    ddGroup: 'DDGArchiveCopy',
	    enableDragDrop: true,
	    enableColumnMove: false,
	    border: true,
	    ds: this.CopyArchiveWordResult,
	    cm: this.CopyArchiveReaultCM,
	    sm: this.CopyArchiveWordGridCheckBox,
	    stripeRows: true,
	    viewConfig:
		{
		    autoFill: true,
		    forceFit: true
		},
	    loadMask: { msg: GetResource("WaitMsg") }
	});
	
	this.AclArchiveWordGrid.on("render", function(){
		if(this.AclArchiveWordResult.data.items.length == 0) return;
		this.AclArchiveWordGridCheckBox.selectFirstRow();
		this.AclArchiveWordGridCheckBox.clearSelections();
	},this);
	
	this.AclArchiveWordGridCheckBox.on("rowselect", function(sm, rowIndex, r){

		var AclLines = this.AclArchiveWordResult.data.items[rowIndex].data.XML_LINE;
        var AclLineInfo = AclLines.split("^");

		//수신처/사본처 리셋
		this.SendArchiveWordResult.removeAll();
		this.CopyArchiveWordResult.removeAll();

		var newSendRecords = new Array();
		var newCopyRecords = new Array();
		var cntSend = 0;
		var cntCopy = 0;
		
		// Grid에 수신처/사본처 정보 반영
        for(var i=0; i<AclLineInfo.length; i++)
        {
            var task_id = AclLineInfo[i].split("*")[0];
            var userInfo = AclLineInfo[i].split("*")[1];
            var user_info = fn_CreateUserInfo(userInfo);
            
			var tmpDisplayName = "";
			var tmpType = "";
				
			if(user_info.LoginID == "")
				tmpType = "GROUP";
			else
				tmpType = "USER";
			
			if(tmpType == "GROUP")
			{
				tmpDisplayName = user_info.UserName;
			}
			else
			{
				if(user_info.DutyName != "")
				{
					if(user_info.DutyName == user_info.UserName)
					{
						tmpDisplayName = user_info.DutyName;
					}
					else
					{
						tmpDisplayName = user_info.DutyName + ' ' + user_info.UserName;
					}
				}
				else
				{
					tmpDisplayName = user_info.DeptName + ' ' + user_info.RankName + ' ' + user_info.UserName;
				}
			}
				
			var newRecord = new ApproverRecord({
				EmpID: user_info.EmpID,
				LoginID: user_info.LoginID,
				ADDisplayName: user_info.UserName + "(" + user_info.LoginID + ")/" + user_info.DeptName,
				UserName: user_info.UserName,
				Email: user_info.Email,
				Type: tmpType,
				DeptCode: user_info.DeptCode,
				DeptName: user_info.DeptName,
				CompanyCode: user_info.CompanyCode,
				CompanyName: user_info.CompanyName,
				DutyCode: user_info.DutyCode,
				DutyName: user_info.DutyName,
				JobName: user_info.JobName,
				RankName: user_info.RankName,
				CellPhone: user_info.CellPhone,
				TeamChiefYN: user_info.TeamChiefYN,
				ExtensionNumber: user_info.ExtensionNumber,
				FaxNumber: user_info.FaxNumber,
				TaskId: user_info.TaskID,
				DisplayName: tmpDisplayName
			});
            
            if(task_id.indexOf("send") > -1)
            {
				var foundItem = this.SendArchiveWordResult.find('Email', user_info.Email);

				if(foundItem == -1) {
					newSendRecords[cntSend] = newRecord;
					cntSend ++;
					//this.SendArchiveWordResult.add(newRecord);
				}	
            }
			else if(task_id.indexOf("copy") > -1)
			{
				var foundItem = this.CopyArchiveWordResult.find('Email', user_info.Email);

				if(foundItem == -1) {
					newCopyRecords[cntCopy] = newRecord;
					cntCopy ++;
					//this.CopyArchiveWordResult.add(newRecord);
				}
			}
        }
        
		this.SendArchiveWordResult.add(newSendRecords);
		this.CopyArchiveWordResult.add(newCopyRecords);
	},this)
	
    this.Render();
    
	this.SendArchiveWordGrid.on('dblclick', this.On_Send_DbClick, this);
	this.CopyArchiveWordGrid.on('dblclick', this.On_Copy_DbClick, this);
    	
    this.CopyArchiveWordGrid.on('render', function() { this.DragDropSetting(); }, this);
};

Ext.extend(GW.SetLine.AclArchiveWord, GW.SetLine.Common, {
	
    On_Send_DbClick: function() {
        Ext.each(this.SendArchiveWordGrid.getSelectionModel().getSelections(), function(record, index, allItems) {
            this.On_Send_DbClickItem(record, index, allItems);
        }
		, this);
    },
    
    On_Copy_DbClick: function() {
        Ext.each(this.CopyArchiveWordGrid.getSelectionModel().getSelections(), function(record, index, allItems) {
            this.On_Copy_DbClickItem(record, index, allItems);
        }
		, this);
    },

    ReturnSourceGrid: function() {
    
        var gridSet =
		{
		    Send: this.SendArchiveWordGrid,
		    Copy: this.CopyArchiveWordGrid,
		    Acl: this.AclArchiveWordGrid
		};
		
        return gridSet;
    },
    
    DragDropSetting: function() {
        var SendGridDropTargetEl = this.SendArchiveWordGrid.getView().el.dom.childNodes[0].childNodes[1]
        this.SendGridDropTarget = new Ext.dd.DropTarget(SendGridDropTargetEl, {
            ddGroup: 'DDGApprover',
            notifyDrop: function(ddSource, e, data) {

                switch (ddSource.ddGroup) {
                    case 'DDGApprover':
                        GW.ApproverAgree.HandlerRemoveApprover(GW.ApproverAgree.CurrentGridSet.Approver, GW.ApproverAgree.ApproverResult);
                        break;
                    case 'DDGAgree1':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.Agree1, GW.ApproverAgree.Agree1Result);
                        break;
                    case 'DDGAgree2':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.Agree2, GW.ApproverAgree.Agree2Result);
                        break;
                    case 'DDGAgree3':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.Agree3, GW.ApproverAgree.Agree3Result);
                        break;
                    case 'DDGAgree4':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.Agree4, GW.ApproverAgree.Agree4Result);
                        break;
                    case 'DDGAgreeBefore':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.AgreeBefore, GW.ApproverAgree.AgreeBeforeResult);
                        break;
                    case 'DDGAgreeAfter':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.AgreeAfter, GW.ApproverAgree.AgreeAfterResult);
                        break;
                    case 'DDGSend':
                        GW.Acl.HandlerRemoveAcl(GW.Acl.CurrentGridSet.Send, GW.Acl.SendResult, 'Send');
                        break;
                    case 'DDGCopy':
                        GW.Acl.HandlerRemoveAcl(GW.Acl.CurrentGridSet.Copy, GW.Acl.CopyResult, 'Copy');
                        break;
                    case 'DDGCharge':
                        GW.Charge.HandlerRemoveCharge(GW.Charge.CurrentGridSet.Charge, GW.Charge.ChargeResult);
                        break;
                    default:
                        break;
                }
            }
        });

        this.SendGridDropTarget.addToGroup('DDGAgree1');
        this.SendGridDropTarget.addToGroup('DDGAgree2');
        this.SendGridDropTarget.addToGroup('DDGAgree3');
        this.SendGridDropTarget.addToGroup('DDGAgree4');
        this.SendGridDropTarget.addToGroup('DDGAgreeBefore');
        this.SendGridDropTarget.addToGroup('DDGAgreeAfter');
        this.SendGridDropTarget.addToGroup('DDGSend');
        this.SendGridDropTarget.addToGroup('DDGCopy');
		this.SendGridDropTarget.addToGroup('DDGCharge'); 
       
        var CopyGridDropTargetEl = this.CopyArchiveWordGrid.getView().el.dom.childNodes[0].childNodes[1]
        this.CopyGridDropTarget = new Ext.dd.DropTarget(CopyGridDropTargetEl, {
            ddGroup: 'DDGApprover',
            notifyDrop: function(ddSource, e, data) {

                switch (ddSource.ddGroup) {
                    case 'DDGApprover':
                        GW.ApproverAgree.HandlerRemoveApprover(GW.ApproverAgree.CurrentGridSet.Approver, GW.ApproverAgree.ApproverResult);
                        break;
                    case 'DDGAgree1':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.Agree1, GW.ApproverAgree.Agree1Result);
                        break;
                    case 'DDGAgree2':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.Agree2, GW.ApproverAgree.Agree2Result);
                        break;
                    case 'DDGAgree3':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.Agree3, GW.ApproverAgree.Agree3Result);
                        break;
                    case 'DDGAgree4':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.Agree4, GW.ApproverAgree.Agree4Result);
                        break;
                    case 'DDGAgreeBefore':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.AgreeBefore, GW.ApproverAgree.AgreeBeforeResult);
                        break;
                    case 'DDGAgreeAfter':
                        GW.ApproverAgree.HandlerRemoveAgree(GW.ApproverAgree.CurrentGridSet.AgreeAfter, GW.ApproverAgree.AgreeAfterResult);
                        break;
                    case 'DDGSend':
                        GW.Acl.HandlerRemoveAcl(GW.Acl.CurrentGridSet.Send, GW.Acl.SendResult, 'Send');
                        break;
                    case 'DDGCopy':
                        GW.Acl.HandlerRemoveAcl(GW.Acl.CurrentGridSet.Copy, GW.Acl.CopyResult, 'Copy');
                        break;
                    case 'DDGCharge':
                        GW.Charge.HandlerRemoveCharge(GW.Charge.CurrentGridSet.Charge, GW.Charge.ChargeResult);
                        break;
                    default:
                        break;
                }
            }
        });

        this.CopyGridDropTarget.addToGroup('DDGAgree1');
        this.CopyGridDropTarget.addToGroup('DDGAgree2');
        this.CopyGridDropTarget.addToGroup('DDGAgree3');
        this.CopyGridDropTarget.addToGroup('DDGAgree4');
        this.CopyGridDropTarget.addToGroup('DDGAgreeBefore');
        this.CopyGridDropTarget.addToGroup('DDGAgreeAfter');
        this.CopyGridDropTarget.addToGroup('DDGSend');
        this.CopyGridDropTarget.addToGroup('DDGCopy');
		this.CopyGridDropTarget.addToGroup('DDGCharge');    
    },
    
    Render: function() {
		var langCombo = new Ext.ux.LanguageCycleButton();
		
		this.AclPanel = new Ext.Panel
		({
		    id: 'AclArchiveWordPanel',
		    layout: 'border',
		    region: 'center', 
		    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
		    border: false,
		    items:
			[
				this.SendArchiveWordGrid
				, this.CopyArchiveWordGrid
			]
		});
		
        // 결재선보관 탭
        this.ReturnPanel = new Ext.Panel
		({
		    id: 'AclArchiveWord',
		    layout: 'border',
		    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
		    border: false,
		    tbar: ['&nbsp;', '->', '-', GetResource("AclGroupName"), '&nbsp;&nbsp;',
			this.ArchiveBox, '&nbsp;',
			{
			    tooltip: { title: GetResource("Register"), text: GetResource("AclArchiveAddTooltip") },
			    iconCls: 'add',
			    text: GetResource("Register"),
			    handler: this.OnAclArchiveWordAddHandler,
			    scope: this
			}
			,'-', langCombo, '-'],
		    items:
			[
				{
				    region: 'north',
				    border: false,
				    height: 0
				}
				,
				this.AclArchiveWordGrid
				,
				this.AclPanel
			]
			,
			bbar: ['->',
				{
					tooltip: { title: GetResource("Delete"), text:  GetResource("RemoveTooltip") },
					iconCls: 'delete',
					text: GetResource("Delete"),
					handler: this.OnAclArchiveWordRemoveHandler,
					scope: this
				}
				,
				{
					tooltip: { title: GetResource("Load"), text: GetResource("AclArchiveLoadTooltip") },
					iconCls: 'load',
					text: GetResource("Load"),
					handler: this.OnAclArchiveWordLoadHandler,
					scope: this
				}
			]
		});
    },

    GetAclArchiveWordNameBox: function(width) {
        var width = width ? width : 125;
        var box = new Ext.form.TextField
		({
		    width: width
		});

        return box;
    },

    OnAclArchiveWordAddHandler: function() {
        var ArchiveBox = this.ArchiveBox;
        var strValue = ArchiveBox.getValue();
	
        if (strValue.trim() == '') {
            this.WarningMessageBox(GetResource("AclArchiveAddMsg"), function() {
                ArchiveBox.focus();
            });
            return false;
        }
        else {
			var foundItem = "";
			
			for(var i=0; i<this.AclArchiveWordResult.data.length; i++)
			{
				if(this.AclArchiveWordResult.data.items[i].data.SUBJECT == strValue)
				{
					foundItem = this.AclArchiveWordResult.data.items[i].data.LINE_ID;
					break;
				}
			}
            // 결재정보
            var appInfo = this.GetAclLineInfo()
			if(appInfo == null) return;
			var appInfoArray = appInfo.split("^");
			var group_check = false;
			
			for(var i=0; i< appInfoArray.length; i++)
			{
				var tmpUserInfo = appInfoArray[i].split("*");
				if(tmpUserInfo[1].split("|")[0].trim() == "")
				{
					group_check = true;
					break;
				}
			}
			
			if(group_check)
			{
				this.WarningMessageBox(GetResource("AclArchiveGroupValidationMsg"));
				return false;
			}
			
			this.ConfirmMessageBox(GetResource("AclArchiveRegisterMsg" , strValue), function(buttonId, text) {
				if(buttonId == "no") return;
				if (foundItem == "") {
					this.AclArchiveWordResult.load({
						params: {
							action: 'add',
							subject: strValue,
							updated: 'false',
							xmlline: appInfo
						}
					});
					ArchiveBox.setValue('');
				}
				else {
					this.ConfirmMessageBox(GetResource("AclArchiveUpdateMsg"), function(buttonId, text) {
						if(buttonId == "no") return;
						this.AclArchiveWordResult.load({
							params: {
								action: 'add',
								subject: strValue,
								updated: 'true',
								lineid: foundItem,
								xmlline: appInfo
							}
						});
						ArchiveBox.setValue('');
					});
				}

				// 수신처
				this.SendArchiveWordResult.removeAll();
				// 사본처
				this.CopyArchiveWordResult.removeAll();
				
				this.AclArchiveWordGrid.getSelectionModel().clearSelections();
				var archiveHeader = this.AclArchiveWordGrid.getView().getHeaderCell(0).childNodes[0];
				Ext.get(archiveHeader).removeClass('x-grid3-hd-checker-on');
        
				return true;
			});
        }
    },

    OnAclArchiveWordRemoveHandler: function() {
        var chkValue = new Array();
		var strList = "";
		
        Ext.each(this.AclArchiveWordGrid.getSelectionModel().getSelections(), function(record, index, allItems) {
			chkValue.push(record.data.LINE_ID);
			if(strList == "")
				strList = record.data.SUBJECT;
			else
				strList = strList + ", " + record.data.SUBJECT;
        }, this);

        if (chkValue.length == 0) {
            this.WarningMessageBox(GetResource("AclArchiveRemoveMsg"));
            return;
        }

		this.ConfirmMessageBox(GetResource("RemoveAclArchiveConfirmMsg", strList), function(buttonId, text) {
			if(buttonId == "no") return;

			this.AclArchiveWordResult.load({
				params: {
					action: 'remove',
					dellines: chkValue
				}
			});

			// 수신처
			this.SendArchiveWordResult.removeAll();
			// 사본처
			this.CopyArchiveWordResult.removeAll();
			
			this.AclArchiveWordGrid.getSelectionModel().clearSelections();
			var archiveHeader = this.AclArchiveWordGrid.getView().getHeaderCell(0).childNodes[0];
			Ext.get(archiveHeader).removeClass('x-grid3-hd-checker-on');
		});
    },

    OnAclArchiveWordLoadHandler: function() {
        var chkValue = 0;
	
        var mask = new Ext.LoadMask(this.AclArchiveWordGrid.getView().el, { msg: GetResource("WaitMsg") });
        mask.show();

        Ext.each(this.AclArchiveWordGrid.getSelectionModel().getSelections(), function(record, index, allItems) {
            chkValue = allItems.length;
            if (allItems.length > 1) {
                this.WarningMessageBox(GetResource("OnlyOneSelectGroupMsg"));
                mask.hide();
                return;
            }

			this.ConfirmMessageBox(GetResource("AppointApprovalIsLoadLineSend", record.data.SUBJECT), function(buttonId, text) {
				if(buttonId == "no") return;
				var AppLines = record.data.XML_LINE;
				
				var AppLineInfo = AppLines.split("^");
				var histories_node =  $(AwxXml).find('Histories')[0];

				var send_node = $(AwxXml).find("Histories Acl[Type='send']")[0];
				var copy_node = $(AwxXml).find("Histories Acl[Type='copy']")[0];
	            
				if(send_node != null) histories_node.removeChild(send_node);
				if(copy_node != null) histories_node.removeChild(copy_node);
	            
				// Awx에 결재 정보 반영
				for(var i=0; i<AppLineInfo.length; i++)
				{
					var task_id = AppLineInfo[i].split("*")[0];
					var userInfo = AppLineInfo[i].split("*")[1];
					var user_info = fn_CreateUserInfo(userInfo);
					var order = fn_GetOrder(userInfo);
					
					if(task_id.indexOf("send") > -1)
					{
						if(is_send)
						{
							var sendNode = $(AwxXml).find("Histories Acl[Type='send']")[0];
							if(sendNode == null) fn_AddAcl($(AwxXml).find("Histories")[0], "send");
							//AWX에 결재자 정보 추가
							fn_AddMember($(AwxXml).find("Histories Acl[Type='send']")[0], user_info);						
						}
					}
					else if(task_id.indexOf("copy") > -1)
					{	
						if(is_copy)
						{
							var copy_node = $(AwxXml).find("Histories Acl[Type='copy']");
							if(copy_node == null) fn_AddAcl($(AwxXml).find("Histories")[0], "copy");
							//AWX에 결재자 정보 추가
							fn_AddMember($(AwxXml).find("Histories Acl[Type='copy']")[0], user_info);						
						}
					}
				}

				//오른쪽 탭영역에 LoadAclArchive함수가 있으면 호출한다
				// TO DO 오른쪽 영역 패널 찾는 부분 수정
				for (var i = 0; i < RightTabContainer.items.length; i++) {
					var tab = eval("GW." + RightTabContainer.getItem(i).id.split('_')[0]);
					var fnLoad = eval("tab.LoadAclArchive");
					if (typeof (fnLoad) == 'function') { eval("tab.LoadAclArchive()"); }
				}
			});
            
            this.AclArchiveWordGrid.getSelectionModel().clearSelections();
            var archiveHeader = this.AclArchiveWordGrid.getView().getHeaderCell(0).childNodes[0];
            Ext.get(archiveHeader).removeClass('x-grid3-hd-checker-on');
            mask.hide();
        }, this);

        if (chkValue == 0) {
            this.WarningMessageBox(GetResource("AclArchiveLoadMsg"));
            mask.hide();
            return;
        }
    },

	GetAclLineInfo: function()
	{
		var acl_nodes = $(AwxXml).find('Histories/Acl');
		var UserInfo = null;
		var AclLineInfo = null;
		
		if(acl_nodes != undefined && acl_nodes != null)
		{
			for(var i=0; i<acl_nodes.length; i++)
			{
				var acl_node = acl_nodes[i];
				
				var members_node = $(acl_node).find("Member");

				if(members_node != undefined && members_node != null)
				{
					for(var j=0; j<members_node.length; j++)
					{
						var member_node = members_node[j];
						var EmpID = member_node.getAttribute("EmpID");
						var LoginID = member_node.getAttribute("LoginID");
						var UserName = member_node.getAttribute("UserName");
						var DeptCode = member_node.getAttribute("DeptCode");
						var DeptName = member_node.getAttribute("DeptName");
						var RankCode = member_node.getAttribute("RankCode");
						var RankName = member_node.getAttribute("RankName");
						var DutyCode = member_node.getAttribute("DutyCode");
						var DutyName = member_node.getAttribute("DutyName");
						var Email = member_node.getAttribute("Email");
						var CellPhone = member_node.getAttribute("CellPhone");
						var InternalPhone = member_node.getAttribute("InternalPhone");
						var Culture = member_node.getAttribute("Culture");
						var TeamChiefYN = member_node.getAttribute("TeamChiefYN");
						var TaskID = acl_node.getAttribute("Type").toLowerCase() + "_" + (j + 1 < 10 ? "0" : "") + (j + 1);
						var SignID = member_node.getAttribute("SignID");
						var State = "";
						var Status = "";
						var Opinion = "";
						var Date = "";
						var Updated = "";
						var Order = (j+1);
						var ExtraInfo = "";
						var AgentId = "";
						var AgentName = "";

						UserInfo = EmpID + "|" + LoginID + "|" + UserName + "|" + DeptCode + "|" + DeptName + "|" + RankCode + "|" + RankName
						 + "|" + DutyCode + "|" + DutyName + "|" + Email + "|" + CellPhone + "|" + InternalPhone + "|" + Culture + "|" + TeamChiefYN + "|" + SignID + "|" + TaskID + "|" + State
						 + "|" + Status + "|" + Opinion + "|" + Date + "|" + Updated + "|" + Order + "|" + ExtraInfo + "|" + AgentId + "|" + AgentName;
						
						if(AclLineInfo == null)
							AclLineInfo = TaskID + "*" + UserInfo;
						else
							AclLineInfo += "^" + TaskID + "*" + UserInfo;
					}				
				}
			}
		}
		return AclLineInfo;
	}
});

//GW.AclArchiveWord = new GW.SetLine.AclArchiveWord();
