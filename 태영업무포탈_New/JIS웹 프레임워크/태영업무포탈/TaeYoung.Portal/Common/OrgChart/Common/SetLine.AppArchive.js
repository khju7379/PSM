/*
* SetLine.AppArchive.js
* 결재선 보관
*/

//서버 Ajax요청시
var AppArchiveServerURL = '/Portal/Common/OrgChart/AppArchiveServer.aspx';

// 결재선보관 DATA
var AppArchiveDataFields = [
	{name: 'STORED_HIST_ID' }, //결재선 아이디
	{name: 'SUBJECT' }, //결재선명
	{name: 'APPROVER_INFO' }, //결재선정보
	{name: 'FORM_NAME'} //양식명
];

	GW.SetLine.AppArchive = function () {

	    this.ArchiveBox = this.GetAppArchiveNameBox();

	    this.ReturnPanel = null;
	    this.AppArchivePanel = null;
	    //alert(AwxXml);
	    this.FormName = AwxXml.getAttribute("FormFile");

	    // 결재선 보관
	    this.AppArchiveResult = new Ext.data.JsonStore
	({
	    url: AppArchiveServerURL,
	    baseParams: { form_name: this.FormName, seq: app_seq },
	    root: 'dataRoot',
	    fields: AppArchiveDataFields,
	    remoteSort: false
	});

	    this.AppArchiveResult.load();

	    //결재선 보관
	    this.AppArchiveGridCheckBox = new Ext.grid.CheckboxSelectionModel();
	    this.ArchiveReaultCM = new Ext.grid.ColumnModel
	([
		this.AppArchiveGridCheckBox,
		{ header: GetResource("AppLineName"), dataIndex: 'SUBJECT', menuDisabled: true, width: 533, renderer: this.RendererWithTooltip }
	]);

	    this.AppArchiveGrid = new Ext.grid.GridPanel
	({
	    region: 'center',
	    margins: '5 5 5 5',
	    ddGroup: 'archiveDDGroup',
	    enableDragDrop: false,
	    enableColumnMove: false,
	    border: true,
	    ds: this.AppArchiveResult,
	    cm: this.ArchiveReaultCM,
	    sm: this.AppArchiveGridCheckBox,
	    stripeRows: true,
	    viewConfig:
		{
		    autoFill: true,
		    forceFit: true
		},
	    loadMask: { msg: GetResource("WaitMsg") }
	});
	    // Grid Double-Click event
	    this.AppArchiveGrid.on("dblclick", this.OnAppArchiveLoadHandler, this);

	    this.Render();
	};

	Ext.extend(GW.SetLine.AppArchive, GW.SetLine.Common, {

	    ReturnSourceGrid: function () {
	        return this.AppArchiveGrid;
	    },

	    Render: function () {

	        var langCombo = new Ext.ux.LanguageCycleButton();
	        // 결재선보관 탭

	        this.ReturnPanel = new Ext.Panel
		({
		    //title: '결재선보관함',
		    id: 'AppArchive',
		    layout: 'border',
		    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
		    border: false,
		    tbar: ['&nbsp;', '->', '-', GetResource("AppLineName"), '&nbsp;&nbsp;',
			this.ArchiveBox, '&nbsp;',
			{
			    tooltip: { title: GetResource("Register"), text: GetResource("ArchiveRegisterTooltip") },
			    iconCls: 'add',
			    text: GetResource("Register"),
			    handler: function () {
			        this.OnAppArchiveAddHandler();
			    },
			    scope: this
			}
			, '-', langCombo, '-'],
		    items:
			[
				{
				    region: 'north',
				    border: false,
				    height: 0
				}
				,
				this.AppArchiveGrid
			],
		    bbar: ['->',
			{
			    tooltip: { title: GetResource("Delete"), text: GetResource("RemoveTooltip") },
			    iconCls: 'delete',
			    text: GetResource("Delete"),
			    handler: function () {
			        this.OnAppArchiveRemoveHandler();
			    },
			    scope: this
			}
			,
			{
			    tooltip: { title: GetResource("Load"), text: GetResource("ArchiveLoadTooltip") },
			    iconCls: 'load',
			    text: GetResource("Load"),
			    handler: function () {
			        this.OnAppArchiveLoadHandler();
			    },
			    scope: this
			}
		]
		});
	    },

	    GetAppArchiveNameBox: function (width) {
	        var width = width ? width : 125;
	        var box = new Ext.form.TextField
		({
		    width: width
		});

	        return box;
	    },

	    OnAppArchiveAddHandler: function () {
	        var ArchiveBox = this.ArchiveBox;
	        var strValue = ArchiveBox.getValue();

	        if (strValue.trim() == '') {
	            this.WarningMessageBox(GetResource("ArchiveNoNameMsg"), function () {
	                ArchiveBox.focus();
	            });
	            return false;
	        }
	        else {
	            var foundItem = "";

	            for (var i = 0; i < this.AppArchiveResult.data.length; i++) {
	                if (this.AppArchiveResult.data.items[i].data.SUBJECT == strValue) {
	                    foundItem = this.AppArchiveResult.data.items[i].data.STORED_HIST_ID;
	                    break;
	                }
	            }

	            if (foundItem == "") {
	                //기본결재자
	                var Approver = GW.ApproverAgree.ApproverResult;

	                var is_validation = null;
	                var is_exa = false;

	                //기본결재
	                if (Approver != undefined && Approver != null) {
	                    for (var i = 0; i < Approver.data.items.length; i++) {
	                        is_validation = Approver.data.items[i].get("Validation");

	                        if (is_validation == "true") {
	                            if (Approver.data.items[i].get('LoginID') == null || Approver.data.items[i].get('LoginID') == "" || Approver.data.items[i].get('LoginID') == undefined) {
	                                this.WarningMessageBox(GetResource("ValidationCheck", Approver.data.items[i].get('Depth')));
	                                return false;
	                            }
	                        }

	                        if (i > 0 && i < Approver.data.items.length - 1) {
	                            var next_task_id = Approver.data.items[i + 1].get('TaskId');
	                            var next_name = Approver.data.items[i + 1].get('LoginID');
	                            var curr_task_id = Approver.data.items[i].get('TaskId');
	                            var curr_name = Approver.data.items[i].get('LoginID');

	                            if (curr_task_id.indexOf("r") == 0 && (curr_name != "" && curr_name != undefined && curr_name != null)) is_exa = true;

	                            if (curr_task_id.indexOf("r") == 0 && (curr_name != "" && curr_name != undefined && curr_name != null) && next_task_id.indexOf("r") == 0 && (next_name == "" || next_name == undefined || next_name == null)) {
	                                this.WarningMessageBox(GetResource("AppointApprovalMustAppointSequence"));
	                                return false;
	                            }
	                        }
	                    }
                        /*
	                    var history_node = $(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0];
	                    for (var i = 0; i < history_node.childNodes.length; i++) {
	                        if (history_node.childNodes[i].nodeName == "Agree") {
	                            var agree_node = $(history_node.childNodes[i]).find('.[Ref="before"]');
	                            if (agree_node != null) {
	                                if (agree_node.childNodes.length > 0 && is_exa == false) {
	                                    //검토전 협조를 지정하면 검토자가 지정되어야 합니다.
	                                    this.WarningMessageBox(GetResource("ArchiveValidationExaMsg"));
	                                    return false;
	                                }
	                            }
	                        }
	                    }
                        */
	                }

	                this.ConfirmMessageBox(GetResource("AddAppArchiveConfirmMsg", strValue), function (buttonId, text) {
	                    if (buttonId == "no") return;

	                    // 결재정보
	                    var appInfo = this.GetAppLineInfo();

	                    Ext.Ajax.request({
	                        url: AppArchiveServerURL,
	                        params: { form_name: this.FormName,
	                            seq: app_seq,
	                            action: 'add',
	                            name: strValue,
	                            data: appInfo
	                        },
	                        method: 'POST',
	                        success: function (response, option) {
	                            var data = Ext.util.JSON.decode(response.responseText);
	                            if (data) {
	                                if (data.result == false) {
	                                    this.ErrorMessageBox(GetResource("AjaxErrorMsg1") +
										data.ErrorMessage + GetResource("AjaxErrorMsg2"), function () {
										    window.close();
										});
	                                    return;
	                                }
	                                this.AppArchiveResult.load();
	                                this.WarningMessageBox(GetResource("AddAppArchiveMsg"));
	                                ArchiveBox.setValue('');
	                            }
	                        },
	                        failure: function (response, option) {
	                            this.ErrorMessageBox(GetResource("AjaxFailMsg"), function () {
	                                window.close();
	                            });
	                        },
	                        scope: this,
	                        async: false
	                    });
	                });
	            }
	            else {
	                this.WarningMessageBox('\'' + strValue + '\' ' + GetResource("ArchiveValidationNameMsg"), function () {
	                    ArchiveBox.focus();
	                });
	                return false;
	            }
	            return true;
	        }
	    },

	    OnAppArchiveRemoveHandler: function () {
	        var chkValue = new Array();
	        var strList = "";

	        Ext.each(this.AppArchiveGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
	            chkValue.push(record.data.STORED_HIST_ID);
	            if (strList == "")
	                strList = record.data.SUBJECT;
	            else
	                strList = strList + ", " + record.data.SUBJECT;
	        }, this);

	        if (chkValue.length == 0) {
	            this.WarningMessageBox(GetResource("ArchiveRemoveTooltip"));
	            return;
	        }

	        this.ConfirmMessageBox(GetResource("RemoveAppArchiveConfirmMsg", strList), function (buttonId, text) {
	            if (buttonId == "no") return;

	            Ext.Ajax.request({
	                url: AppArchiveServerURL,
	                params: { form_name: this.FormName, seq: app_seq, action: 'remove', dellines: chkValue },
	                method: 'POST',
	                success: function (response, option) {
	                    var data = Ext.util.JSON.decode(response.responseText);
	                    if (data) {
	                        if (data.result == false) {
	                            this.ErrorMessageBox(GetResource("AjaxErrorMsg1") +
								data.ErrorMessage + GetResource("AjaxErrorMsg2"), function () {
								    window.close();
								});
	                            return;
	                        }
	                        this.AppArchiveResult.load();
	                        this.WarningMessageBox(GetResource("RemoveAppArchiveMsg"));
	                    }
	                },
	                failure: function (response, option) {
	                    this.ErrorMessageBox(GetResource("AjaxFailMsg"), function () {
	                        window.close();
	                    });
	                },
	                scope: this,
	                async: false
	            });

	            this.AppArchiveGrid.getSelectionModel().clearSelections();
	            var archiveHeader = this.AppArchiveGrid.getView().getHeaderCell(0).childNodes[0];
	            Ext.get(archiveHeader).removeClass('x-grid3-hd-checker-on');
	        });
	    },

	    OnAppArchiveLoadHandler: function () {
	        var chkValue = 0;

	        var mask = new Ext.LoadMask(this.AppArchiveGrid.getView().el, { msg: GetResource("WaitMsg") });
	        mask.show();

	        Ext.each(this.AppArchiveGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
	            chkValue = allItems.length;

	            if (allItems.length > 1) {
	                this.WarningMessageBox(GetResource("ArchiveOneSelectMsg"));
	                mask.hide();
	                return;
	            }
	            var AppLines = record.data.APPROVER_INFO;

	            var AppLineInfo = AppLines.split("^");
	            var histories_node = $(AwxXml).find('Histories')[0];
	            var history_node = $(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0];

	            if (history_node != null) {
	                var approvers = $(history_node).find('Approver');
	                if (approvers != null) {
	                    for (var i = 0; i < approvers.length; i++) {
	                        var status = approvers[i].getAttribute("Status");

	                        if (status != "") {
	                            this.WarningMessageBox(GetResource("ArchiveCompleteAppMsg"));
	                            mask.hide();
	                            this.AppArchiveGrid.getSelectionModel().clearSelections();
	                            var archiveHeader = this.AppArchiveGrid.getView().getHeaderCell(0).childNodes[0];
	                            Ext.get(archiveHeader).removeClass('x-grid3-hd-checker-on');
	                            return;
	                        }
	                    }
	                }

	                histories_node.removeChild(history_node);
	            }

	            var send_node = $(AwxXml).find("Histories Acl[Type='send']")[0];
	            var copy_node = $(AwxXml).find("Histories Acl[Type='copy']")[0];

	            if (send_node != null) { histories_node.removeChild(send_node); fn_AddAcl(histories_node, 'send'); }
	            if (copy_node != null) { histories_node.removeChild(copy_node); fn_AddAcl(histories_node, 'copy'); }

	            this.ConfirmMessageBox(GetResource("LoadAppArchiveConfirmMsg", record.get("SUBJECT")), function (buttonId, text) {
	                if (buttonId == "no") return;
	                // Awx에 결재 정보 반영
	                for (var i = 0; i < AppLineInfo.length; i++) {
	                    var task_id = AppLineInfo[i].split("*")[0];
	                    var userInfo = AppLineInfo[i].split("*")[1];
	                    var user_info = fn_CreateUserInfo(userInfo);
	                    var order = fn_GetOrder(userInfo);

	                    if (task_id == "send" || task_id == "copy") {
	                        var acl = $(AwxXml).find('Histories Acl[Type="' + task_id + '"]');
	                        if (acl.length < 1) fn_AddAcl($(AwxXml).find('Histories'), task_id);

	                        fn_AddMember(acl, user_info);
	                    }
	                    else if (fn_IsAgree(task_id)) {
	                        var ref = task_id.substring(0, task_id.lastIndexOf('_'));

	                        if ($(AwxXml).find('Histories History[Seq=' + app_seq + '] Agree[Ref="' + ref + '"]')[0] == null) {
	                            if ($(AwxXml).find('Histories History[Seq="' + app_seq + '"]')[0] == null) {
	                                fn_AddHistory($(AwxXml).find('Histories')[0], app_seq);
	                            }
	                            fn_AddAgree($(AwxXml).find('Histories History[Seq="' + app_seq + '"]')[0], ref);
	                        }
	                        fn_AddApprover($(AwxXml).find('Histories History[Seq="' + app_seq + '"] Agree[Ref="' + ref + '"]')[0], user_info, task_id, order);
	                    }
	                    else {
	                        //결재선에 해당 TaskId가 있으면 값을 셋팅
	                        if (GW.ApproverAgree.RowCount != null && GW.ApproverAgree.RowCount != undefined) {
	                            var dsApprover = GW.ApproverAgree.ApproverResult;

	                            var foundItem = dsApprover.find('TaskId', task_id);
	                            if (foundItem != -1) {
	                                if ($(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0] == null) {
	                                    fn_AddHistory($(AwxXml).find('Histories')[0], app_seq);
	                                }
	                                fn_AddApprover($(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0], user_info, task_id, order);
	                            }
	                        }

	                        if (GW.ApproverAgree.CRowCount != null && GW.ApproverAgree.CRowCount != undefined) {
	                            var dsLastApprver = GW.ApproverAgree.ChargeResult;

	                            var foundItem = dsLastApprver.find('TaskId', task_id);
	                            if (foundItem != -1) {
	                                if ($(AwxXml).find('Histories History[Seq=' + dsLastApprver.data.items[foundItem].get("Seq") + ']')[0] == null) {
	                                    fn_AddHistory($(AwxXml).find('Histories')[0], dsLastApprver.data.items[foundItem].get("Seq"));
	                                }
	                                fn_AddApprover($(AwxXml).find('Histories History[Seq=' + dsLastApprver.data.items[foundItem].get("Seq") + ']')[0], user_info, task_id, order);
	                            }
	                        }

	                        if (GW.Charge.RowCount != null && GW.Charge.RowCount != undefined) {
	                            var dsCharge = GW.Charge.ChargeResult;

	                            var foundItem = dsCharge.find('TaskId', task_id);
	                            if (foundItem != -1) {
	                                if ($(AwxXml).find('Histories History[Seq=' + dsCharge.data.items[foundItem].get("Seq") + ']')[0] == null) {
	                                    fn_AddHistory($(AwxXml).find('Histories')[0], dsCharge.data.items[foundItem].get("Seq"));
	                                }
	                                fn_AddApprover($(AwxXml).find('Histories History[Seq=' + dsCharge.data.items[foundItem].get("Seq") + ']')[0], user_info, task_id, order);
	                            }
	                        }
	                    }
	                }

	                
	                // TO DO 오른쪽 영역 패널 찾는 부분 수정
	                for (var i = 0; i < RightTabContainer.items.length; i++) {
	                    var tab = eval("GW." + RightTabContainer.getItem(i).id.split('_')[0]);

	                    //오른쪽 탭영역에 LoadArchive함수가 있으면 호출한다
	                    var fnLoad = eval("tab.LoadArchive");
	                    if (typeof (fnLoad) == 'function') { eval("tab.LoadArchive()"); }

	                    //오른쪽 탭영역에 LoadAclArchive함수가 있으면 호출한다
	                    fnLoad = eval("tab.LoadAclArchive");
	                    if (typeof (fnLoad) == 'function') { eval("tab.LoadAclArchive()"); }
	                }

	                this.InfoMessageBox(GetResource("LoadAppArchiveCompleteMsg", record.get("SUBJECT")));

	                this.AppArchiveGrid.getSelectionModel().clearSelections();
	                var archiveHeader = this.AppArchiveGrid.getView().getHeaderCell(0).childNodes[0];
	                Ext.get(archiveHeader).removeClass('x-grid3-hd-checker-on');
	            });
	            mask.hide();
	        }, this);

	        if (chkValue == 0) {
	            this.WarningMessageBox(GetResource("ArchiveLoadMsg"));
	            mask.hide();
	            return;
	        }
	    },

	    GetAppLineInfo: function () {
	        var history_node = $(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0];
	        var UserInfo = null;
	        var AppLineInfo = null;

	        if (history_node != null) {
	            for (var i = 0; i < history_node.childNodes.length; i++) {
	                switch (history_node.childNodes[i].nodeName) {
	                    case "Approver":
	                        var EmpID = history_node.childNodes[i].getAttribute("EmpID");
	                        var LoginID = history_node.childNodes[i].getAttribute("LoginID");
	                        var UserName = history_node.childNodes[i].getAttribute("UserName");
	                        var DeptCode = history_node.childNodes[i].getAttribute("DeptCode");
	                        var DeptName = history_node.childNodes[i].getAttribute("DeptName");
	                        var RankCode = history_node.childNodes[i].getAttribute("RankCode");
	                        var RankName = history_node.childNodes[i].getAttribute("RankName");
	                        var DutyCode = history_node.childNodes[i].getAttribute("DutyCode");
	                        var DutyName = history_node.childNodes[i].getAttribute("DutyName");
	                        var Email = history_node.childNodes[i].getAttribute("Email");
	                        var CellPhone = history_node.childNodes[i].getAttribute("CellPhone");
	                        var InternalPhone = history_node.childNodes[i].getAttribute("InternalPhone");
	                        var Culture = history_node.childNodes[i].getAttribute("Culture");
	                        var TeamChiefYN = history_node.childNodes[i].getAttribute("TeamChiefYN");
	                        var CompanyCode = history_node.childNodes[i].getAttribute("CompanyCode");
	                        var CompanyName = history_node.childNodes[i].getAttribute("CompanyName");
	                        var SignID = history_node.childNodes[i].getAttribute("SignID");
	                        var TaskID = history_node.childNodes[i].getAttribute("TaskID");
	                        var State = ""; //history_node.childNodes[i].getAttribute("State");
	                        var Status = ""; //history_node.childNodes[i].getAttribute("Status");
	                        var Opinion = ""; //history_node.childNodes[i].getAttribute("Opinion");
	                        var Date = ""; //history_node.childNodes[i].getAttribute("Date");
	                        var Updated = ""; //history_node.childNodes[i].getAttribute("Updated");
	                        var Order = history_node.childNodes[i].getAttribute("Order");
	                        var ExtraInfo = ""; //history_node.childNodes[i].getAttribute("ExtraInfo");
	                        var AgentId = ""; //history_node.childNodes[i].getAttribute("AgentId");
	                        var AgentName = ""; //history_node.childNodes[i].getAttribute("AgentName");

	                        UserInfo = EmpID + "|" + LoginID + "|" + UserName + "|" + DeptCode + "|" + DeptName + "|" + RankCode + "|" + RankName
						         + "|" + DutyCode + "|" + DutyName + "|" + Email + "|" + CellPhone + "|" + InternalPhone + "|" + Culture + "|" + TeamChiefYN
                                 + "|" + CompanyCode + "|" + CompanyName + "|" + SignID + "|" + TaskID + "|" + State
						         + "|" + Status + "|" + Opinion + "|" + Date + "|" + Updated + "|" + Order + "|" + ExtraInfo + "|" + AgentId + "|" + AgentName;

	                        if (AppLineInfo == null) {
	                            AppLineInfo = TaskID + "*" + UserInfo
	                        }
	                        else {
	                            AppLineInfo += "^" + TaskID + "*" + UserInfo
	                        }
	                        break;

	                    case "Agree":
	                        var agree_node = $(history_node).find('Agree[Ref="' + history_node.childNodes[i].getAttribute("Ref").toLowerCase() + '"]')[0];

	                        for (var j = 0; j < agree_node.childNodes.length; j++) {
	                            var EmpID = agree_node.childNodes[j].getAttribute("EmpID");
	                            var LoginID = agree_node.childNodes[j].getAttribute("LoginID");
	                            var UserName = agree_node.childNodes[j].getAttribute("UserName");
	                            var DeptCode = agree_node.childNodes[j].getAttribute("DeptCode");
	                            var DeptName = agree_node.childNodes[j].getAttribute("DeptName");
	                            var RankCode = agree_node.childNodes[j].getAttribute("RankCode");
	                            var RankName = agree_node.childNodes[j].getAttribute("RankName");
	                            var DutyCode = agree_node.childNodes[j].getAttribute("DutyCode");
	                            var DutyName = agree_node.childNodes[j].getAttribute("DutyName");
	                            var Email = agree_node.childNodes[j].getAttribute("Email");
	                            var CellPhone = agree_node.childNodes[j].getAttribute("CellPhone");
	                            var InternalPhone = agree_node.childNodes[j].getAttribute("InternalPhone");
	                            var Culture = agree_node.childNodes[j].getAttribute("Culture");
	                            var TeamChiefYN = agree_node.childNodes[j].getAttribute("TeamChiefYN");
	                            var CompanyCode = agree_node.childNodes[j].getAttribute("CompanyCode");
	                            var CompanyName = agree_node.childNodes[j].getAttribute("CompanyName");
	                            var SignID = agree_node.childNodes[j].getAttribute("SignID");
	                            var TaskID = agree_node.childNodes[j].getAttribute("TaskID");
	                            var State = ""; //agree_node.childNodes[j].getAttribute("State");
	                            var Status = ""; //agree_node.childNodes[j].getAttribute("Status");
	                            var Opinion = ""; //agree_node.childNodes[j].getAttribute("Opinion");
	                            var Date = ""; //agree_node.childNodes[j].getAttribute("Date");
	                            var Updated = ""; //agree_node.childNodes[j].getAttribute("Updated");
	                            var Order = agree_node.childNodes[j].getAttribute("Order");
	                            var ExtraInfo = ""; //agree_node.childNodes[i].getAttribute("ExtraInfo");
	                            var AgentId = ""; //agree_node.childNodes[i].getAttribute("AgentId");
	                            var AgentName = ""; //agree_node.childNodes[i].getAttribute("AgentName"); 
	                            var Information = ""; //agree_node.childNodes[i].getAttribute("AgentName"); 

	                            UserInfo = EmpID + "|" + LoginID + "|" + UserName + "|" + DeptCode + "|" + DeptName + "|" + RankCode + "|" + RankName
                                    + "|" + DutyCode + "|" + DutyName + "|" + Email + "|" + CellPhone + "|" + InternalPhone + "|" + Culture + "|" + TeamChiefYN
                                    + "|" + CompanyCode + "|" + CompanyName + "|" + SignID + "|" + TaskID + "|" + State
                                    + "|" + Status + "|" + Opinion + "|" + Date + "|" + Updated + "|" + Order + "|" + ExtraInfo + "|" + AgentId + "|" + AgentName;

	                            if (AppLineInfo == null) {
	                                AppLineInfo = TaskID + "*" + UserInfo
	                            }
	                            else {
	                                AppLineInfo += "^" + TaskID + "*" + UserInfo
	                            }
	                        }
	                        break;
	                }
	            }
	        }

	        var acl_node = $(AwxXml).find('Histories Acl');

	        for (var i = 0; i < acl_node.length; i++) {
	            var acls_id = acl_node[i].getAttribute("Type").toLowerCase();
	            if (acls_id == "circular") continue;

	            for (var j = 0; j < acl_node[i].childNodes.length; j++) {
	                var EmpID = acl_node[i].childNodes[j].getAttribute("EmpID");
	                var LoginID = acl_node[i].childNodes[j].getAttribute("LoginID");
	                var UserName = acl_node[i].childNodes[j].getAttribute("UserName");
	                var DeptCode = acl_node[i].childNodes[j].getAttribute("DeptCode");
	                var DeptName = acl_node[i].childNodes[j].getAttribute("DeptName");
	                var RankCode = acl_node[i].childNodes[j].getAttribute("RankCode");
	                var RankName = acl_node[i].childNodes[j].getAttribute("RankName");
	                var DutyCode = acl_node[i].childNodes[j].getAttribute("DutyCode");
	                var DutyName = acl_node[i].childNodes[j].getAttribute("DutyName");
	                var Email = acl_node[i].childNodes[j].getAttribute("Email");
	                var CellPhone = acl_node[i].childNodes[j].getAttribute("CellPhone");
	                var InternalPhone = acl_node[i].childNodes[j].getAttribute("InternalPhone");
	                var Culture = acl_node[i].childNodes[j].getAttribute("Culture");
	                var TeamChiefYN = acl_node[i].childNodes[j].getAttribute("TeamChiefYN");
	                var CompanyCode = acl_node[i].childNodes[j].getAttribute("CompanyCode");
	                var CompanyName = acl_node[i].childNodes[j].getAttribute("CompanyName");
	                var SignID = acl_node[i].childNodes[j].getAttribute("SignID");
	                var TaskID = acls_id;
	                var State = "";
	                var Status = "";
	                var Opinion = "";
	                var Date = "";
	                var Updated = "";
	                var Order = "";
	                var ExtraInfo = "";
	                var AgentId = "";
	                var AgentName = "";
	                var Information = "";

	                UserInfo = EmpID + "|" + LoginID + "|" + UserName + "|" + DeptCode + "|" + DeptName + "|" + RankCode + "|" + RankName
                                    + "|" + DutyCode + "|" + DutyName + "|" + Email + "|" + CellPhone + "|" + InternalPhone + "|" + Culture + "|" + TeamChiefYN
                                    + "|" + CompanyCode + "|" + CompanyName + "|" + SignID + "|" + TaskID + "|" + State
                                    + "|" + Status + "|" + Opinion + "|" + Date + "|" + Updated + "|" + Order + "|" + ExtraInfo + "|" + AgentId + "|" + AgentName;

	                if (AppLineInfo == null) {
	                    AppLineInfo = TaskID + "*" + UserInfo
	                }
	                else {
	                    AppLineInfo += "^" + TaskID + "*" + UserInfo
	                }
	            }

	        }
	        return AppLineInfo;
	    }
	});

GW.AppArchive = new GW.SetLine.AppArchive();
