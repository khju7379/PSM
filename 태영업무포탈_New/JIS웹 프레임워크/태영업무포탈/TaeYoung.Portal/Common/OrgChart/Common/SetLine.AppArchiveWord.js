/*
* SetLine.AppArchiveWord.js
* 워드 결재선 보관
*/

//서버 Ajax요청시
var AppArchiveWordServerURL = 'AppArchiveWordServer.aspx';

// 결재선보관 DATA
var AppArchiveWordDataFields = [
	{name: 'LINE_ID' }, //결재선 아이디
	{name: 'SUBJECT' }, //결재선명
	{name: 'XML_LINE' } //결재선정보
];
	
GW.SetLine.AppArchiveWord = function() {

    this.ArchiveBox = this.GetAppArchiveWordNameBox();

    this.ReturnPanel = null;

    this.FormName = AwxXml.getAttribute("FormFile");
            
    // 결재선 보관
    this.AppArchiveWordResult = new Ext.data.JsonStore
	({
	    url: AppArchiveWordServerURL,
	    //baseParams: { form_name: this.FormName, seq: app_seq },
		root: 'dataRoot', 
	    fields: AppArchiveWordDataFields,
	    remoteSort: false
	});

    this.AppArchiveWordResult.load();

    //결재선 보관
    this.AppArchiveWordGridCheckBox = new Ext.grid.CheckboxSelectionModel();
    this.ArchiveReaultCM = new Ext.grid.ColumnModel
	([
		this.AppArchiveWordGridCheckBox,
		{header: GetResource("AppLineName"),		dataIndex: 'SUBJECT', 			menuDisabled: true,	width: 533,	renderer: this.RendererWithTooltip}
	]);

    this.AppArchiveWordGrid = new Ext.grid.GridPanel
	({
	    region: 'center',
	    margins: '5 5 5 5',
	    ddGroup: 'archiveDDGroup',
	    enableDragDrop: false,
	    enableColumnMove: false,
	    border: true,
	    ds: this.AppArchiveWordResult,
	    cm: this.ArchiveReaultCM,
	    sm: this.AppArchiveWordGridCheckBox,
	    stripeRows: true,
	    viewConfig:
		{
		    autoFill: true,
		    forceFit: true
		},
	    loadMask: { msg: GetResource("WaitMsg") }
	});
		
    this.Render();
};

Ext.extend(GW.SetLine.AppArchiveWord, GW.SetLine.Common, {

    //    ReturnSourceGrid: function() {
    //        return this.AppArchiveWordGrid;
    //    },

    Render: function () {

        var langCombo = new Ext.ux.LanguageCycleButton();
        // 결재선보관 탭
        this.ReturnPanel = new Ext.Panel
		({
		    //title: '결재선보관함',
		    id: 'AppArchiveWord',
		    layout: 'border',
		    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
		    border: false,
		    tbar: ['&nbsp;', '->', '-', GetResource("AppLineName"), '&nbsp;&nbsp;',
			this.ArchiveBox, '&nbsp;',
			{
			    tooltip: { title: GetResource("Register"), text: GetResource("ArchiveRegisterTooltip") },
			    iconCls: 'add',
			    text: GetResource("Register"),
			    handler: this.OnAppArchiveWordAddHandler,
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
				this.AppArchiveWordGrid
			],
		    bbar: ['->',
			{
			    tooltip: { title: GetResource("Delete"), text: GetResource("RemoveTooltip") },
			    iconCls: 'delete',
			    text: GetResource("Delete"),
			    handler: this.OnAppArchiveWordRemoveHandler,
			    scope: this
			}
			,
			{
			    tooltip: { title: GetResource("Load"), text: GetResource("ArchiveLoadTooltip") },
			    iconCls: 'load',
			    text: GetResource("Load"),
			    handler: this.OnAppArchiveWordLoadHandler,
			    scope: this
			}
		]
		});
    },

    GetAppArchiveWordNameBox: function (width) {
        var width = width ? width : 125;
        var box = new Ext.form.TextField
		({
		    width: width
		});

        return box;
    },

    OnAppArchiveWordAddHandler: function () {
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

            for (var i = 0; i < this.AppArchiveWordResult.data.length; i++) {
                if (this.AppArchiveWordResult.data.items[i].data.SUBJECT == strValue) {
                    foundItem = this.AppArchiveWordResult.data.items[i].data.LINE_ID;
                    break;
                }
            }

            // 결재정보
            var appInfo = this.GetAppLineInfo()

            if (appInfo == null) {
                this.WarningMessageBox(GetResource("EmptyAppArchiveMsg"));
                return false;
            }

            if (foundItem == "") {
                this.ConfirmMessageBox(GetResource("AddAppArchiveConfirmMsg", strValue), function (buttonId, text) {
                    if (buttonId == "no") return;

                    Ext.Ajax.request({
                        url: AppArchiveWordServerURL,
                        params: {
                            action: 'add',
                            subject: strValue,
                            updated: 'false',
                            xmlline: appInfo
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
                                this.AppArchiveWordResult.load();
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
                this.ConfirmMessageBox(GetResource("ArchiveUpdateMsg"), function (buttonId, text) {
                    if (buttonId == "no") return;

                    Ext.Ajax.request({
                        url: AppArchiveWordServerURL,
                        params: {
                            action: 'add',
                            subject: strValue,
                            updated: 'true',
                            lineid: foundItem,
                            xmlline: appInfo
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
                                this.AppArchiveWordResult.load();
                                this.WarningMessageBox(GetResource("UpdateAppArchiveMsg"));
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
                return false;
            }
            return true;
        }
    },

    OnAppArchiveWordRemoveHandler: function () {
        var chkValue = new Array();
        var strList = "";

        Ext.each(this.AppArchiveWordGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
            chkValue.push(record.data.LINE_ID);
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
                url: AppArchiveWordServerURL,
                params: { action: 'remove', dellines: chkValue },
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
                        this.AppArchiveWordResult.load();
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

            this.AppArchiveWordGrid.getSelectionModel().clearSelections();
            var archiveHeader = this.AppArchiveWordGrid.getView().getHeaderCell(0).childNodes[0];
            Ext.get(archiveHeader).removeClass('x-grid3-hd-checker-on');
        });
    },

    OnAppArchiveWordLoadHandler: function () {
        var chkValue = 0;

        var mask = new Ext.LoadMask(this.AppArchiveWordGrid.getView().el, { msg: GetResource("WaitMsg") });
        mask.show();

        Ext.each(this.AppArchiveWordGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
            chkValue = allItems.length;
            if (allItems.length > 1) {
                this.WarningMessageBox(GetResource("ArchiveOneSelectMsg"));
                mask.hide();
                return;
            }
            var AppLines = record.data.XML_LINE;

            var AppLineInfo = AppLines.split("^");
            var histories_node = $(AwxXml).find('Histories')[0];
            var history_node = $(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0];

            if (history_node != null) {
                var approvers = $(history_node).find('Approver')[0];
                if (approvers != null) {
                    for (var i = 0; i < approvers.length; i++) {
                        var status = approvers[i].getAttribute("Status");

                        if (status != "") {
                            this.WarningMessageBox(GetResource("ArchiveCompleteAppMsg"));
                            mask.hide();
                            this.AppArchiveWordGrid.getSelectionModel().clearSelections();
                            var archiveHeader = this.AppArchiveWordGrid.getView().getHeaderCell(0).childNodes[0];
                            Ext.get(archiveHeader).removeClass('x-grid3-hd-checker-on');
                            return;
                        }
                    }
                }

                histories_node.removeChild(history_node);
            }

            this.ConfirmMessageBox(GetResource("LoadAppArchiveConfirmMsg", record.get("SUBJECT")), function (buttonId, text) {
                if (buttonId == "no") return;

                // Awx에 결재 정보 반영
                for (var i = 0; i < AppLineInfo.length; i++) {
                    var task_id = AppLineInfo[i].split("*")[0];
                    var userInfo = AppLineInfo[i].split("*")[1];
                    var user_info = fn_CreateUserInfo(userInfo);
                    var order = fn_GetOrder(userInfo);

                    if (fn_IsAgree(task_id)) {
                        var ref = task_id.substring(0, task_id.lastIndexOf('_'));

                        if ($(AwxXml).find('Histories History[Seq=' + app_seq + '] Agree[Ref="' + ref + '"]')[0] == null) {
                            if ($(AwxXml).find('Histories History')[0] == null) {
                                fn_AddHistory($(AwxXml).find('Histories')[0], app_seq);
                            }
                            fn_AddAgree($(AwxXml).find('Histories History')[0], ref);
                        }
                        fn_AddApprover($(AwxXml).find('Histories History Agree[Ref="' + ref + '"]')[0], user_info, task_id, order);
                    }
                    else {
                        if ($(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0] == null) {
                            fn_AddHistory($(AwxXml).find('Histories')[0], app_seq);
                        }
                        fn_AddApprover($(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0], user_info, task_id, order);
                    }
                }

                //오른쪽 탭영역에 LoadArchive함수가 있으면 호출한다
                // TO DO 오른쪽 영역 패널 찾는 부분 수정
                for (var i = 0; i < RightTabContainer.items.length; i++) {
                    var tab = eval("GW." + RightTabContainer.getItem(i).id.split('_')[0]);
                    var fnLoad = eval("tab.LoadArchive");
                    if (typeof (fnLoad) == 'function') { eval("tab.LoadArchive()"); }
                }

                this.InfoMessageBox(GetResource("LoadAppArchiveCompleteMsg", record.get("SUBJECT")));

                this.AppArchiveWordGrid.getSelectionModel().clearSelections();
                var archiveHeader = this.AppArchiveWordGrid.getView().getHeaderCell(0).childNodes[0];
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
        return AppLineInfo;
    }
});

//GW.AppArchiveWord = new GW.SetLine.AppArchiveWord();
