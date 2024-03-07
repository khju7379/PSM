/*
* GW.SetLine.ChargeAgree.js
* 결재자/협조자
*/
GW.SetLine.ChargeAgree = function () {

    //GW.SetLine.ChargeAgree.superclass.constructor.call(this);
    if (approverlistNodes == null || approverlistNodes == undefined) return false;

    // 결재자
    this.ApproverResult = new Ext.data.JsonStore
	({
	    fields: APPDataFields
	});

    // 기안후 협조
    this.Agree1Result = new Ext.data.JsonStore
	({
	    id: 'A101',
	    fields: APPDataFields
	});

    // 검토1후 협조
    this.Agree2Result = new Ext.data.JsonStore
	({
	    id: 'A102',
	    fields: APPDataFields
	});

    // 검토2후 협조
    this.Agree3Result = new Ext.data.JsonStore
	({
	    id: 'A103',
	    fields: APPDataFields
	});

    // 검토3후 협조
    this.Agree4Result = new Ext.data.JsonStore
	({
	    id: 'A104',
	    fields: APPDataFields
	});

    // 검토4후 협조
    this.Agree5Result = new Ext.data.JsonStore
	({
	    id: 'A105',
	    fields: APPDataFields
	});

    // 검토5후 협조
    this.Agree6Result = new Ext.data.JsonStore
	({
	    id: 'A106',
	    fields: APPDataFields
	});

    // 검토6후 협조
    this.Agree7Result = new Ext.data.JsonStore
	({
	    id: 'A107',
	    fields: APPDataFields
	});

	// 담당후 협조
	this.CAgree1Result = new Ext.data.JsonStore
	({
	    id: 'CA101',
	    fields: APPDataFields
	});

	// 담당검토1후 협조
	this.CAgree2Result = new Ext.data.JsonStore
	({
	    id: 'CA102',
	    fields: APPDataFields
	});

	// 담당검토2후 협조
	this.CAgree3Result = new Ext.data.JsonStore
	({
	    id: 'CA103',
	    fields: APPDataFields
	});

	// 담당검토3후 협조
	this.CAgree4Result = new Ext.data.JsonStore
	({
	    id: 'CA104',
	    fields: APPDataFields
	});

	// 담당검토4후 협조
	this.CAgree5Result = new Ext.data.JsonStore
	({
	    id: 'CA105',
	    fields: APPDataFields
	});

	// 담당검토5후 협조
	this.CAgree6Result = new Ext.data.JsonStore
	({
	    id: 'CA106',
	    fields: APPDataFields
	});

	// 담당검토6후 협조
	this.CAgree7Result = new Ext.data.JsonStore
	({
	    id: 'CA107',
	    fields: APPDataFields
	});

	// 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)
	// 담당2후 협조
	this.C2Agree1Result = new Ext.data.JsonStore
	({
	    id: 'CA201',
	    fields: APPDataFields
	});

	// 담당2검토1후 협조
	this.C2Agree2Result = new Ext.data.JsonStore
	({
	    id: 'CA202',
	    fields: APPDataFields
	});

	// 담당2검토2후 협조
	this.C2Agree3Result = new Ext.data.JsonStore
	({
	    id: 'CA203',
	    fields: APPDataFields
	});

	// 담당2검토3후 협조
	this.C2Agree4Result = new Ext.data.JsonStore
	({
	    id: 'CA204',
	    fields: APPDataFields
	});

	// 담당2검토4후 협조
	this.C2Agree5Result = new Ext.data.JsonStore
	({
	    id: 'CA205',
	    fields: APPDataFields
	});

	// 담당2검토5후 협조
	this.C2Agree6Result = new Ext.data.JsonStore
	({
	    id: 'CA206',
	    fields: APPDataFields
	});

	// 담당2검토6후 협조
	this.C2Agree7Result = new Ext.data.JsonStore
	({
	    id: 'CA207',
	    fields: APPDataFields
	});

    // 전협조
    this.AgreeBeforeResult = new Ext.data.JsonStore
	({
	    id: 'AB101',
	    fields: APPDataFields
	});

    // 후협조
    this.AgreeAfterResult = new Ext.data.JsonStore
	({
	    id: 'AF101',
	    fields: APPDataFields
	});

    // 승인자
    this.ChargeResult = new Ext.data.JsonStore
	({
	    id: 'C101',
	    fields: APPDataFields
	});

    this.ApproverGridDropTarget = null;
    this.Agree1GridDropTarget = null;
    this.Agree2GridDropTarget = null;
    this.Agree3GridDropTarget = null;
    this.Agree4GridDropTarget = null;
    this.Agree5GridDropTarget = null;
    this.Agree6GridDropTarget = null;
    this.Agree7GridDropTarget = null;
    this.AgreeBeforeGridDropTarget = null;
    this.AgreeAfterGridDropTarget = null;
    this.ChargeGridDropTarget = null;

    this.CAgree1GridDropTarget = null;
    this.CAgree2GridDropTarget = null;
    this.CAgree3GridDropTarget = null;
    this.CAgree4GridDropTarget = null;
    this.CAgree5GridDropTarget = null;
    this.CAgree6GridDropTarget = null;
    this.CAgree7GridDropTarget = null;

    // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)
    this.C2Agree1GridDropTarget = null;
    this.C2Agree2GridDropTarget = null;
    this.C2Agree3GridDropTarget = null;
    this.C2Agree4GridDropTarget = null;
    this.C2Agree5GridDropTarget = null;
    this.C2Agree6GridDropTarget = null;
    this.C2Agree7GridDropTarget = null;

    this.ReturnPanel = null;
    this.TabAgreeContainerMulti = null;
    this.TabAgreeContainerBeforeAfter = null;
    this.AgreePanel = null;
    this.RowCount = null;
    this.CRowCount = null;

    //비정형(Word)문서 때문에 추가
    this.CheckUserId = false;
    //현재 결재자
    this.CurrentUser = null;
    //현재 문서 상태
    this.DocState = null;
    //현재 결재자 TASKID
    this.CurrentUserTaskID = null;

    this.Initialize();
    this.InitGirdRows();
    this.CurrentGridSet = this.InitGird();

    this.Render();
    this.LoadAwx();

    this.CurrentGridSet.Approver.on('dblclick', function () { this.HandlerRemoveApprover(this.CurrentGridSet.Approver, this.ApproverResult) }, this);
    this.CurrentGridSet.Agree1.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.Agree1, this.Agree1Result) }, this);
    this.CurrentGridSet.Agree2.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.Agree2, this.Agree2Result) }, this);
    this.CurrentGridSet.Agree3.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.Agree3, this.Agree3Result) }, this);
    this.CurrentGridSet.Agree4.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.Agree4, this.Agree4Result) }, this);
    this.CurrentGridSet.Agree5.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.Agree5, this.Agree5Result) }, this);
    this.CurrentGridSet.Agree6.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.Agree6, this.Agree6Result) }, this);
    this.CurrentGridSet.Agree7.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.Agree7, this.Agree7Result) }, this);
    this.CurrentGridSet.AgreeBefore.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.AgreeBefore, this.AgreeBeforeResult) }, this);
    this.CurrentGridSet.AgreeAfter.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.AgreeAfter, this.AgreeAfterResult) }, this);
    this.CurrentGridSet.Charge.on('dblclick', function () { this.HandlerRemoveCharge(this.CurrentGridSet.Charge, this.ChargeResult) }, this);

    /* 담당협조 추가 */
    this.CurrentGridSet.CAgree1.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.CAgree1, this.CAgree1Result) }, this);
    this.CurrentGridSet.CAgree2.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.CAgree2, this.CAgree2Result) }, this);
    this.CurrentGridSet.CAgree3.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.CAgree3, this.CAgree3Result) }, this);
    this.CurrentGridSet.CAgree4.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.CAgree4, this.CAgree4Result) }, this);
    this.CurrentGridSet.CAgree5.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.CAgree5, this.CAgree5Result) }, this);
    this.CurrentGridSet.CAgree6.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.CAgree6, this.CAgree6Result) }, this);
    this.CurrentGridSet.CAgree7.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.CAgree7, this.CAgree7Result) }, this);

    // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)
    this.CurrentGridSet.C2Agree1.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.C2Agree1, this.C2Agree1Result) }, this);
    this.CurrentGridSet.C2Agree2.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.C2Agree2, this.C2Agree2Result) }, this);
    this.CurrentGridSet.C2Agree3.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.C2Agree3, this.C2Agree3Result) }, this);
    this.CurrentGridSet.C2Agree4.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.C2Agree4, this.C2Agree4Result) }, this);
    this.CurrentGridSet.C2Agree5.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.C2Agree5, this.C2Agree5Result) }, this);
    this.CurrentGridSet.C2Agree6.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.C2Agree6, this.C2Agree6Result) }, this);
    this.CurrentGridSet.C2Agree7.on('dblclick', function () { this.HandlerRemoveAgree(this.CurrentGridSet.C2Agree7, this.C2Agree7Result) }, this);

    if (is_agree_multi) {
        this.isEnable = false;

        for (var i = 0; i < this.TabAgreeContainerMulti.items.length; i++) {
            if (!this.TabAgreeContainerMulti.items.items[i].disabled) {
                isEnable = true;
                //var agreeGrid = eval("this.CurrentGridSet.Agree" + (i + 1));
                var agreeGrid = eval("this.CurrentGridSet." + ((app_seq == 1) ? "C" : (app_seq == 2) ? "C2" : "") + "Agree" + (i + 1));
                agreeGrid.on('render', function () { this.DragDropSetting(); }, this);

//                agreeGrid = eval("this.CurrentGridSet.CAgree" + (i + 1));
//                agreeGrid.on('render', function () { this.DragDropSetting(); }, this);

//                // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)
//                agreeGrid = eval("this.CurrentGridSet.C2Agree" + (i + 1));
//                agreeGrid.on('render', function () { this.DragDropSetting(); }, this);

                break;
            }
        }
        if (!this.isEnable) this.CurrentGridSet.Approver.on('render', function () { this.DragDropSetting(); }, this);
    }
    if (is_agree_before && is_agree_after) this.CurrentGridSet.AgreeBefore.on('render', function () { this.DragDropSetting(); }, this);
    if (is_agree_before && !is_agree_after) this.CurrentGridSet.AgreeBefore.on('render', function () { this.DragDropSetting(); }, this);
    if (!is_agree_before && is_agree_after) this.CurrentGridSet.AgreeAfter.on('render', function () { this.DragDropSetting(); }, this);
    if (!is_agree_before && !is_agree_after && !is_agree_multi && this.CRowCount == null) this.CurrentGridSet.Approver.on('render', function () { this.DragDropSetting(); }, this);
    if (!is_agree_before && !is_agree_after && !is_agree_multi && this.CRowCount > 0) this.CurrentGridSet.Charge.on('render', function () { this.DragDropSetting(); }, this);

    //	this.CurrentGridSet.Approver.on('rowclick', function(grid, rowIndex, e) {
    //		if(grid.store.data.items[rowIndex].get("Change") != undefined)
    //		{
    //			if(grid.store.data.items[rowIndex].get("Change") == "false")
    //			{
    //				e.stopEvent();
    //			}
    //		}
    //	}, this);

};

Ext.extend(GW.SetLine.ChargeAgree, GW.SetLine.Common, {

    Initialize: function () {
        var state = AwxXml.getAttribute("State");
        var current_node = $(AwxXml).find("CurrentUser")[0];

        if (current_node != null) {
            if (is_word)
                var currentId = current_node.getAttribute("EmpID");
            else
                var currentId = current_node.getAttribute("LoginID");

            var currentTaskID = current_node.getAttribute("TaskID");

            switch (currentTaskID) {
                case "emp":
                    currentTaskID = "emp0";
                    break;
                //                case "r0004":            
                //                    currentTaskID = "app0";            
                //                    break;            
            }
            this.CurrentUser = currentId;
            this.CurrentUserTaskID = currentTaskID;
        }

        if (state != null && state != undefined) {
            this.DocState = state;

            if (state != "" && state != "0" && state != "1" && state != "new" && state != "temp") {
                this.CheckUserId = true;
            }
        }
    },

    On_ChargeAgree_DbClickItem: function (record, index, allItems) {
        this.On_AddApprover_DbClickItem_Handle(record, index, allItems);
    },

    On_AddApprover_DbClickItem_Handle: function (record, index, allItems) {
        var dataGrid = this.CurrentGridSet.Approver;
        var dsResult = this.ApproverResult;

        this.HandlerAddApprover(dataGrid, dsResult);
        this.AllSelectionClear();
    },

    LoadArchive: function () {
        //그리드 리셋
        var gridArry = new Array("Approver", "Agree1", "Agree2", "Agree3", "Agree4", "Agree5", "Agree6", "Agree7", "AgreeBefore", "AgreeAfter", "Charge", "CAgree1", "CAgree2", "CAgree3", "CAgree4", "CAgree5", "CAgree6", "CAgree7", "C2Agree1", "C2Agree2", "C2Agree3", "C2Agree4", "C2Agree5", "C2Agree6", "C2Agree7");
        for (var i = 0; i < gridArry.length; i++) {
            var dsResult = eval("this." + gridArry[i] + "Result");
            dsResult.removeAll();
        }
        this.InitGirdRows();
        this.LoadAwx();
    },

    LoadAwx: function () {
        var app_node = $(AwxXml).find('Histories History');

        var dsApprover = this.ApproverResult;
        var dsCharge = this.ChargeResult;

        for (var k = 0; k < app_node.length; k++) {
            var history_node = $(AwxXml).find('Histories History[Seq=' + k + ']')[0];

            if (history_node != null) {
                //기본결재, 협조 바인딩.
                for (var i = 0; i < history_node.childNodes.length; i++) {

                    switch (history_node.childNodes[i].nodeName) {
                        case "Approver":
                            // 기본결재
                            var task_id = history_node.childNodes[i].getAttribute("TaskID");

                            if ($(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0] == null) {
                                fn_AddHistory($(AwxXml).find('Histories')[0], app_seq);
                            }

                            var foundItem = dsApprover.find('TaskId', task_id);
                            if (foundItem != -1) {
                                dsApprover.data.items[foundItem].set('EmpID', history_node.childNodes[i].getAttribute("EmpID"));
                                dsApprover.data.items[foundItem].set('LoginID', history_node.childNodes[i].getAttribute("LoginID"));
                                dsApprover.data.items[foundItem].set('ADDisplayName', history_node.childNodes[i].getAttribute("UserName") + "(" + history_node.childNodes[i].getAttribute("LoginID") + ")/" + history_node.childNodes[i].getAttribute("DeptName"));
                                dsApprover.data.items[foundItem].set('UserName', history_node.childNodes[i].getAttribute("UserName"));
                                dsApprover.data.items[foundItem].set('Email', history_node.childNodes[i].getAttribute("Email"));
                                dsApprover.data.items[foundItem].set('Type', 'USER');
                                dsApprover.data.items[foundItem].set('DeptCode', history_node.childNodes[i].getAttribute("DeptCode"));
                                dsApprover.data.items[foundItem].set('DeptName', history_node.childNodes[i].getAttribute("DeptName"));
                                dsApprover.data.items[foundItem].set('CompanyName', history_node.childNodes[i].getAttribute("CompanyName"));
                                dsApprover.data.items[foundItem].set('SignID', history_node.childNodes[i].getAttribute("SignID"));
                                dsApprover.data.items[foundItem].set('DutyCode', history_node.childNodes[i].getAttribute("DutyCode"));
                                dsApprover.data.items[foundItem].set('DutyName', history_node.childNodes[i].getAttribute("DutyName"));
                                dsApprover.data.items[foundItem].set('JobCode', history_node.childNodes[i].getAttribute("JobCode"));
                                dsApprover.data.items[foundItem].set('JobName', history_node.childNodes[i].getAttribute("JobName"));
                                dsApprover.data.items[foundItem].set('RankCode', history_node.childNodes[i].getAttribute("RankCode"));
                                dsApprover.data.items[foundItem].set('RankName', history_node.childNodes[i].getAttribute("RankName"));
                                dsApprover.data.items[foundItem].set('CellPhone', history_node.childNodes[i].getAttribute("CellPhone"));
                                dsApprover.data.items[foundItem].set('TeamChiefYN', history_node.childNodes[i].getAttribute("TeamChiefYN"));
                                dsApprover.data.items[foundItem].set('ExtensionNumber', history_node.childNodes[i].getAttribute("ExtensionNumber"));
                                dsApprover.data.items[foundItem].set('FaxNumber', history_node.childNodes[i].getAttribute("FaxNumber"));
                                dsApprover.data.items[foundItem].set('TaskId', task_id);

                                if (history_node.childNodes[i].getAttribute("Status") == "") {
                                    //협조탭 Enable처리
                                    this.EnableAgreeTab(task_id, true);
                                }
                                else if (history_node.childNodes[i].getAttribute("Status") != "") {
                                    //TO DO : Row disable 처리
                                    dsApprover.data.items[foundItem].set('Change', "false");
                                }
                                dsApprover.data.items[foundItem].commit();
                            }

                            //정형 승인자 예외 처리
                            if (this.CRowCount > 0) {
                                var foundItem = dsCharge.find('TaskId', task_id);
                                if (foundItem != -1) {
                                    dsCharge.data.items[foundItem].set('EmpID', history_node.childNodes[i].getAttribute("EmpID"));
                                    dsCharge.data.items[foundItem].set('LoginID', history_node.childNodes[i].getAttribute("LoginID"));
                                    dsCharge.data.items[foundItem].set('ADDisplayName', history_node.childNodes[i].getAttribute("UserName") + "(" + history_node.childNodes[i].getAttribute("LoginID") + ")/" + history_node.childNodes[i].getAttribute("DeptName"));
                                    dsCharge.data.items[foundItem].set('UserName', history_node.childNodes[i].getAttribute("UserName"));
                                    dsCharge.data.items[foundItem].set('Email', history_node.childNodes[i].getAttribute("Email"));
                                    dsCharge.data.items[foundItem].set('Type', 'USER');
                                    dsCharge.data.items[foundItem].set('DeptCode', history_node.childNodes[i].getAttribute("DeptCode"));
                                    dsCharge.data.items[foundItem].set('DeptName', history_node.childNodes[i].getAttribute("DeptName"));
                                    dsCharge.data.items[foundItem].set('CompanyName', history_node.childNodes[i].getAttribute("CompanyName"));
                                    dsCharge.data.items[foundItem].set('SignID', history_node.childNodes[i].getAttribute("SignID"));
                                    dsCharge.data.items[foundItem].set('DutyCode', history_node.childNodes[i].getAttribute("DutyCode"));
                                    dsCharge.data.items[foundItem].set('DutyName', history_node.childNodes[i].getAttribute("DutyName"));
                                    dsCharge.data.items[foundItem].set('JobCode', history_node.childNodes[i].getAttribute("JobCode"));
                                    dsCharge.data.items[foundItem].set('JobName', history_node.childNodes[i].getAttribute("JobName"));
                                    dsCharge.data.items[foundItem].set('RankCode', history_node.childNodes[i].getAttribute("RankCode"));
                                    dsCharge.data.items[foundItem].set('RankName', history_node.childNodes[i].getAttribute("RankName"));
                                    dsCharge.data.items[foundItem].set('CellPhone', history_node.childNodes[i].getAttribute("CellPhone"));
                                    dsCharge.data.items[foundItem].set('TeamChiefYN', history_node.childNodes[i].getAttribute("TeamChiefYN"));
                                    dsCharge.data.items[foundItem].set('ExtensionNumber', history_node.childNodes[i].getAttribute("ExtensionNumber"));
                                    dsCharge.data.items[foundItem].set('FaxNumber', history_node.childNodes[i].getAttribute("FaxNumber"));
                                    dsCharge.data.items[foundItem].set('TaskId', task_id);

                                    if (history_node.childNodes[i].getAttribute("Status") != "") {
                                        //TO DO : Row disable 처리
                                        dsCharge.data.items[foundItem].set('Change', "false");
                                    }
                                    dsCharge.data.items[foundItem].commit();
                                }
                            }

                            break;

                        case "Agree":
                            // 협조
                            var agreeId = history_node.childNodes[i].getAttribute("Ref").toLowerCase();
                            var dsAgree = null;
                            switch (agreeId) {
                                case 'emp0_after':
                                    dsAgree = this.Agree1Result;
                                    break;
                                case 'r0001_after':
                                    dsAgree = this.Agree2Result;
                                    break;
                                case 'r0002_after':
                                    dsAgree = this.Agree3Result;
                                    break;
                                case 'r0003_after':
                                    dsAgree = this.Agree4Result;
                                    break;
                                case 'r0004_after':
                                    dsAgree = this.Agree5Result;
                                    break;
                                case 'r0005_after':
                                    dsAgree = this.Agree6Result;
                                    break;
                                case 'r0006_after':
                                    dsAgree = this.Agree7Result;
                                    break;
                                case 'before':
                                    dsAgree = this.AgreeBeforeResult;
                                    break;
                                case 'after':
                                    dsAgree = this.AgreeAfterResult;
                                    break;

                                /* 담당 협조 추가 */ 
                                case 'emp1_after':
                                    dsAgree = this.CAgree1Result;
                                    break;
                                case 'r1001_after':
                                    dsAgree = this.CAgree2Result;
                                    break;
                                case 'r1002_after':
                                    dsAgree = this.CAgree3Result;
                                    break;
                                case 'r1003_after':
                                    dsAgree = this.CAgree4Result;
                                    break;
                                case 'r1004_after':
                                    dsAgree = this.CAgree5Result;
                                    break;
                                case 'r1005_after':
                                    dsAgree = this.CAgree6Result;
                                    break;
                                case 'r1006_after':
                                    dsAgree = this.CAgree7Result;
                                    break;

                                // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)      
                                case 'emp2_after':
                                    dsAgree = this.C2Agree1Result;
                                    break;
                                case 'r2001_after':
                                    dsAgree = this.C2Agree2Result;
                                    break;
                                case 'r2002_after':
                                    dsAgree = this.C2Agree3Result;
                                    break;
                                case 'r2003_after':
                                    dsAgree = this.C2Agree4Result;
                                    break;
                                case 'r2004_after':
                                    dsAgree = this.C2Agree5Result;
                                    break;
                                case 'r2005_after':
                                    dsAgree = this.C2Agree6Result;
                                    break;
                                case 'r2006_after':
                                    dsAgree = this.C2Agree7Result;
                                    break;

                                default:
                                    break;
                            }

                            if (dsAgree != null) {
                                if ($(history_node).find('Agree[Ref="' + agreeId + '"]')[0] == null) {
                                    fn_AddAgree(history_node.childNodes[i], agreeId);
                                }

                                var agree_node = (history_node.childNodes[i]);

                                if (agree_node != null) {
                                    var newRecords = new Array();

                                    for (var j = 0; j < agree_node.childNodes.length; j++) {
                                        var foundItem = dsAgree.find('LoginID', agree_node.childNodes[j].getAttribute("LoginID"));
                                        if (foundItem == -1) {
                                            var change_flag = "true";

                                            if (agree_node.childNodes[j].getAttribute("State") == "C") {
                                                change_flag = "false";
                                            }
                                            var newRecord = new ApproverRecord({
                                                EmpID: agree_node.childNodes[j].getAttribute("EmpID"),
                                                LoginID: agree_node.childNodes[j].getAttribute("LoginID"),
                                                ADDisplayName: agree_node.childNodes[j].getAttribute("UserName") + "(" + agree_node.childNodes[j].getAttribute("LoginID") + ")/" + agree_node.childNodes[j].getAttribute("DeptName"),
                                                UserName: agree_node.childNodes[j].getAttribute("UserName"),
                                                Email: agree_node.childNodes[j].getAttribute("Email"),
                                                Type: 'USER',
                                                DeptCode: agree_node.childNodes[j].getAttribute("DeptCode"),
                                                DeptName: agree_node.childNodes[j].getAttribute("DeptName"),
                                                CompanyName: agree_node.childNodes[j].getAttribute("CompanyName"),
                                                SignID: agree_node.childNodes[j].getAttribute("SignID"),
                                                DutyCode: agree_node.childNodes[j].getAttribute("DutyCode"),
                                                DutyName: agree_node.childNodes[j].getAttribute("DutyName"),
                                                JobCode: agree_node.childNodes[j].getAttribute("JobCode"),
                                                JobName: agree_node.childNodes[j].getAttribute("JobName"),
                                                RankCode: agree_node.childNodes[j].getAttribute("RankCode"),
                                                RankName: agree_node.childNodes[j].getAttribute("RankName"),
                                                CellPhone: agree_node.childNodes[j].getAttribute("CellPhone"),
                                                TeamChiefYN: agree_node.childNodes[j].getAttribute("TeamChiefYN"),
                                                ExtensionNumber: agree_node.childNodes[j].getAttribute("ExtensionNumber"),
                                                FaxNumber: agree_node.childNodes[j].getAttribute("FaxNumber"),
                                                TaskId: agree_node.childNodes[j].getAttribute("TaskID"),
                                                Change: change_flag
                                            });
                                            newRecords[j] = newRecord;
                                        }
                                    }
                                    dsAgree.add(newRecords);
                                    //협조 탭 타이틀 변경
                                    //this.ChangeTabTitle(agreeId, dsAgree);
                                }
                            }
                            break;

                        default:
                            break;
                    }
                }
            }
        }

        //협조선 추가지시 예외 처리
        if (this.DocState == "9") {
            var history_node = $(AwxXml).find("Histories History[Seq='0']")[0];
            for (var i = 0; i < history_node.childNodes.length; i++) {
                if (history_node.childNodes[i].nodeName == "Approver") {
                    if (this.CurrentUser == history_node.childNodes[i].getAttribute("LoginID")) {
                        var taskId = history_node.childNodes[i].getAttribute("TaskID");
                        if (this.CurrentUserTaskID == taskId) {
                            this.EnableAgreeTab(taskId, true);
                            break;
                        }
                        //						var taskId = history_node.childNodes[i].getAttribute("TaskID");
                        //						if(taskId.indexOf('r') == 0)
                        //						{
                        //							//협조탭 Enable처리
                        //							this.EnableAgreeTab(taskId, true);
                        //						}
                    }
                }
            }
        }
        //Activate Tab선택
        this.ActivateAgreeTab();
    },

    InitGirdRows: function () {

        for (var i = 0; i < approverlistNodes.length; i++) {
            var listId = approverlistNodes[i].getAttribute("id");
            var listType = approverlistNodes[i].getAttribute("type");

            if (listType == "normal") {
                var itemNodes = $(approverlistNodes[i]).find("ritem");
                if (listId.indexOf("approval") > -1) this.RowCount = itemNodes.length;
                if (listId == "charge") this.CRowCount = itemNodes.length;

                for (var j = 0; j < itemNodes.length; j++) {
                    if (listId.indexOf("approval") > -1) {
                        this.ApproverResult.add(new ApproverRecord({ EmpID: "", LoginID: "", ADDisplayName: "", UserName: "", Email: "", Type: "", DeptCode: "", DeptName: "", DutyCode: "", DutyName: "", JobCode: "", JobName: "", RankCode: "", RankName: "", CellPhone: "", TeamChiefYN: "", CompanyCode: "", CompanyName: "", SignID: "", ExtensionNumber: "", FaxNumber: "", Depth: itemNodes[j].textContent, TaskId: itemNodes[j].getAttribute("id"), Seq: itemNodes[j].getAttribute("seq"), Validation: itemNodes[j].getAttribute("validation"), Change: itemNodes[j].getAttribute("change") }));
                    }
                    else if (listId == "charge") {
                        this.ChargeResult.add(new ApproverRecord({ EmpID: "", LoginID: "", ADDisplayName: "", UserName: "", Email: "", Type: "", DeptCode: "", DeptName: "", DutyCode: "", DutyName: "", JobCode: "", JobName: "", RankCode: "", RankName: "", CellPhone: "", TeamChiefYN: "", CompanyCode: "", CompanyName: "", SignID: "", ExtensionNumber: "", FaxNumber: "", Depth: itemNodes[j].textContent, TaskId: itemNodes[j].getAttribute("id"), Seq: itemNodes[j].getAttribute("seq"), Validation: itemNodes[j].getAttribute("validation"), Change: itemNodes[j].getAttribute("change") }));
                    }
                }
            }
        }
    },

    DragDropSetting: function () {
        this.InitSelectGrid();
        var grids = this.CurrentGridSet;

        if (this.RowCount > 0) {
            this.CurrentGridSet.Approver.view.mainBody.on('mouseup', function (e, t) {
                index = this.CurrentGridSet.Approver.getView().findRowIndex(t);
                if (this.ApproverGridDropTarget.DDM.dragCurrent != null) {
                    if (this.ApproverGridDropTarget.DDM.dragCurrent.dragData.selections.length == 1) {
                        this.CurrentGridSet.Approver.getSelectionModel().selectRow(index, false);
                    }
                }
            }
			, this);
        }

        function HandlerApproverGridDrop(ddSource, dsResult) {
            var strNoEmpIDUserList = "";
            var cnt = 0;
            var isGroup = false;

            Ext.each(ddSource.dragData.selections, function (record, index, allItems) {
                if (record.data.Type != "GROUP") {
                    if (record.data.EmpID.length == 0) {
                        strNoEmpIDUserList += record.data.UserName + ', ';
                        return true;
                    }

                    var history = $(AwxXml).find('Histories History[Seq = ' + app_seq + ']')[0];
                    if (history == null) {
                        history = fn_AddHistory($(AwxXml).find('Histories')[0], app_seq);
                    }

                    // EmpId 유일키
                    if (is_overlap)
                        var foundItem = dsResult.store.find('EmpID', record.data.EmpID);
                    else
                        var foundItem = -1;

                    if (foundItem == -1) {
                        // 기본결재라인
                        if (dsResult.getSelectionModel().getSelections().length > 0) {
                            // Row가 선택되었을때
                            Ext.each(dsResult.getSelectionModel().getSelections(), function (trecord, tindex, tallItems) {
                                //대리작성인 경우 기안자 변경 불가.
                                if (trecord.get('TaskId') == "emp0") {
                                    if ($(AwxXml).find('Fields')[0] != null) {
                                        if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null) {
                                            if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y") {
                                                GW.Common.WarningMessageBox(GetResource("ApproverDrafterNoChangeMsg"));
                                                //return;
                                            }
                                        }
                                    }
                                }
                                // 현재 member 노드 접근
                                var approver = $(history).find('Approver[TaskID = \'' + trecord.get('TaskId') + '\']')[0];
                                if (approver != null) {
                                    var status = approver.getAttribute("Status");

                                    if (status != "") {
                                        GW.Common.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                                        return;
                                    }

                                    if (GW.ChargeAgree.CheckUserId) {
                                        if (approver.getAttribute("LoginID") == GW.ChargeAgree.CurrentUser && approver.getAttribute("TaskID") == GW.ChargeAgree.CurrentUserTaskID) {
                                            GW.Common.WarningMessageBox(GetResource("AppointApprovalCurrentApprover"));
                                            return;
                                        }
                                    }
                                    history.removeChild(approver);
                                }

                                if (trecord.get('Change') == "false") {
                                    GW.Common.WarningMessageBox(GetResource("ImpossibleChange", trecord.get('Depth')));
                                    return;
                                }

                                if (record.data.DutyName == "") {
                                    if (trecord.get("TaskId").indexOf('app') > -1)
                                        record.data.DutyName = GetResource("TeamLeader");
                                    else
                                        record.data.DutyName = GetResource("TeamMember");
                                }
                                var newRecord = new ApproverRecord({
                                    EmpID: record.data.EmpID,
                                    LoginID: record.data.LoginID,
                                    ADDisplayName: record.data.ADDisplayName,
                                    UserName: record.data.UserName,
                                    Email: record.data.Email,
                                    Type: record.data.Type,
                                    DeptCode: record.data.DeptCode,
                                    DeptName: record.data.DeptName,

                                    DutyCode: record.data.DutyCode,
                                    DutyName: record.data.DutyName,
                                    JobCode: record.data.JobCode,
                                    JobName: record.data.JobName,
                                    RankCode: record.data.RankCode,
                                    RankName: record.data.RankName,
                                    CellPhone: record.data.CellPhone,
                                    TeamChiefYN: record.data.TeamChiefYN,
                                    CompanyCode: record.data.CompanyCode,
                                    CompanyName: record.data.CompanyName,
                                    SignID: record.data.SignID,
                                    ExtensionNumber: record.data.ExtensionNumber,
                                    FaxNumber: record.data.FaxNumber,
                                    Depth: trecord.get("Depth"),
                                    TaskId: trecord.get("TaskId"),
                                    Seq: trecord.get("Seq"),
                                    Validation: trecord.get("Validation"),
                                    Change: trecord.get("Change")
                                });

                                var idx = dsResult.store.indexOf(trecord);
                                dsResult.store.remove(trecord);
                                dsResult.store.insert(idx, newRecord);

                                var ord = dsResult.store.data.length - idx;

                                //AWX에 결재자 정보 추가
                                fn_AddApprover($(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0], fn_GetUserInfo(record), trecord.get('TaskId'), ord);

                                //협조탭 Enable처리
                                if (is_agree_multi) GW.ChargeAgree.EnableAgreeTab(trecord.get('TaskId'), true);
                            }, this);
                        }
                        else {
                            return;
                            // Row가 선택되지 않았을 경우 빈 Row에 채운다
                            if (cnt == dsResult.store.data.items.length) return;
                            for (var j = dsResult.store.data.items.length - 1; j > -1; j--) {
                                if (dsResult.store.data.items[j].data.EMPID == undefined || dsResult.store.data.items[j].data.EMPID == "") {
                                    //대리작성인 경우 기안자 변경 불가.
                                    if (dsResult.store.data.items[j].get('TaskId') == "emp0") {
                                        if ($(AwxXml).find('Fields')[0] != null) {
                                            if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null) {
                                                if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y") {
                                                    GW.Common.WarningMsgBox(GetResource("ApproverDrafterNoChangeMsg"));
                                                    return;
                                                }
                                            }
                                        }
                                    }

                                    var approver = $(history).find('Approver[TaskID = \'' + dsResult.store.data.items[j].get('TaskId') + '\']')[0];

                                    if (approver != null) {
                                        var status = approver.getAttribute("Status");

                                        if (status != "") {
                                            GW.Common.WarningMsgBox(GetResource("ApproverCompleteNoChangeMsg"));
                                            return;
                                        }

                                        if (GW.ChargeAgree.CheckUserId) {
                                            if (approver.getAttribute("LoginID") == GW.ChargeAgree.CurrentUser && approver.getAttribute("TaskID") == GW.ChargeAgree.CurrentUserTaskID) {
                                                GW.Common.WarningMessageBox(GetResource("AppointApprovalCurrentApprover"));
                                                //return;
                                            }
                                        }
                                        history.removeChild(approver);
                                    }

                                    if (record.data.DutyName == "") {
                                        if (dsResult.store.data.items[j].data.TaskId.indexOf('app') > -1)
                                            record.data.DutyName = GetResource("TeamLeader");
                                        else
                                            record.data.DutyName = GetResource("TeamMember");
                                    }
                                    var newRecord = new ApproverRecord({
                                        EmpID: record.data.EmpID,
                                        LoginID: record.data.LoginID,
                                        ADDisplayName: record.data.ADDisplayName,
                                        UserName: record.data.UserName,
                                        Email: record.data.Email,
                                        Type: record.data.Type,
                                        DeptCode: record.data.DeptCode,
                                        DeptName: record.data.DeptName,

                                        DutyCode: record.data.DutyCode,
                                        DutyName: record.data.DutyName,
                                        JobCode: record.data.JobCode,
                                        JobName: record.data.JobName,
                                        RankCode: record.data.RankCode,
                                        RankName: record.data.RankName,
                                        CellPhone: record.data.CellPhone,
                                        TeamChiefYN: record.data.TeamChiefYN,
                                        CompanyCode: record.data.CompanyCode,
                                        CompanyName: record.data.CompanyName,
                                        SignID: record.data.SignID,
                                        ExtensionNumber: record.data.ExtensionNumber,
                                        FaxNumber: record.data.FaxNumber,
                                        Depth: dsResult.store.data.items[j].data.Depth,
                                        TaskId: dsResult.store.data.items[j].data.TaskId,
                                        Seq: dsResult.store.data.items[j].data.Seq,
                                        Validation: dsResult.store.data.items[j].data.Validation,
                                        Change: dsResult.store.data.items[j].data.Change
                                    });

                                    dsResult.store.remove(dsResult.store.data.items[j]);
                                    dsResult.store.insert(j, newRecord);

                                    var ord = dsResult.store.data.items.length - j;
                                    cnt++;
                                    //AWX에 결재자 정보 추가
                                    fn_AddApprover($(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0], fn_GetUserInfo(record), dsResult.store.data.items[j].get('TaskId'), ord);
                                    //협조탭 Enable처리
                                    if (is_agree_multi) GW.ChargeAgree.EnableAgreeTab(dsResult.store.data.items[j].get('TaskId'), true);
                                    break;
                                }
                            }
                        }
                    }
                    else {
                        var args = new Array();
                        args[0] = record.get("UserName");
                        args[1] = dsResult.store.data.items[foundItem].get("Depth");
                        GW.ChargeAgree.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
                    }
                    //Activate Tab선택
                    if (is_agree_multi) GW.ChargeAgree.ActivateAgreeTab();
                }
                else {
                    isGroup = true;
                }
            }, this);

            if (isGroup) {
                GW.ChargeAgree.WarningMessageBox(GetResource("ApproverNotSetGroupMsg"));
            }

            if (strNoEmpIDUserList.length > 1) {
                GW.ChargeAgree.WarningMessageBox(strNoEmpIDUserList + GetResource("NoInfoAddMsg"));
            }
            GW.ChargeAgree.AllSelectionClear();
        }

        if (this.RowCount > 0) {
            var ApproverGridDropTargetEl = grids.Approver.getView().el.dom.childNodes[0].childNodes[1];
            this.ApproverGridDropTarget = new Ext.dd.DropTarget(ApproverGridDropTargetEl, {
                ddGroup: 'DDGSelect',
                notifyDrop: function (ddSource, e, data) {
                    var mask = new Ext.LoadMask(grids.Approver.getView().el, { msg: GetResource("WaitMsg") });
                    mask.show();
                    HandlerApproverGridDrop(ddSource, grids.Approver);
                    mask.hide();
                }
            }, this);

            this.ApproverGridDropTarget.addToGroup('DDGAgree1');
            this.ApproverGridDropTarget.addToGroup('DDGAgree2');
            this.ApproverGridDropTarget.addToGroup('DDGAgree3');
            this.ApproverGridDropTarget.addToGroup('DDGAgree4');
            this.ApproverGridDropTarget.addToGroup('DDGAgree5');
            this.ApproverGridDropTarget.addToGroup('DDGAgree6');
            this.ApproverGridDropTarget.addToGroup('DDGAgree7');
            this.ApproverGridDropTarget.addToGroup('DDGAgreeBefore');
            this.ApproverGridDropTarget.addToGroup('DDGAgreeAfter');

            /* 담당협조 추가 */
            this.ApproverGridDropTarget.addToGroup('DDGCAgree1');
            this.ApproverGridDropTarget.addToGroup('DDGCAgree2');
            this.ApproverGridDropTarget.addToGroup('DDGCAgree3');
            this.ApproverGridDropTarget.addToGroup('DDGCAgree4');
            this.ApproverGridDropTarget.addToGroup('DDGCAgree5');
            this.ApproverGridDropTarget.addToGroup('DDGCAgree6');
            this.ApproverGridDropTarget.addToGroup('DDGCAgree7');

            // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)
            this.ApproverGridDropTarget.addToGroup('DDGC2Agree1');
            this.ApproverGridDropTarget.addToGroup('DDGC2Agree2');
            this.ApproverGridDropTarget.addToGroup('DDGC2Agree3');
            this.ApproverGridDropTarget.addToGroup('DDGC2Agree4');
            this.ApproverGridDropTarget.addToGroup('DDGC2Agree5');
            this.ApproverGridDropTarget.addToGroup('DDGC2Agree6');
            this.ApproverGridDropTarget.addToGroup('DDGC2Agree7');
        }

        function HandlerAgreeGridDrop(ddSource, dsResult) {
            var strNoEmpIDUserList = "";
            var strOverLapUserList = "";

            var agreeId = "";
            var plResult = null;
            var resourceKey = "";
            var isGroup = false;
            switch (dsResult.id) {
                case 'A101':
                    agreeId = "emp0_after";
                    plResult = grids.Agree1;
                    resourceKey = "AfterDraft";
                    break;
                case 'A102':
                    agreeId = "r0001_after";
                    plResult = grids.Agree2;
                    resourceKey = "AfterRev1";
                    break;
                case 'A103':
                    agreeId = "r0002_after";
                    plResult = grids.Agree3;
                    resourceKey = "AfterRev2";
                    break;
                case 'A104':
                    agreeId = "r0003_after";
                    plResult = grids.Agree4;
                    resourceKey = "AfterRev3";
                    break;
                case 'A105':
                    agreeId = "r0004_after";
                    plResult = grids.Agree5;
                    resourceKey = "AfterRev4";
                    break;
                case 'A106':
                    agreeId = "r0005_after";
                    plResult = grids.Agree6;
                    resourceKey = "AfterRev5";
                    break;
                case 'A107':
                    agreeId = "r0006_after";
                    plResult = grids.Agree7;
                    resourceKey = "AfterRev6";
                    break;
                case 'AB101':
                    agreeId = "before";
                    plResult = grids.AgreeBefore;
                    resourceKey = "BeforeAgree";
                    break;
                case 'AF101':
                    agreeId = "after";
                    plResult = grids.AgreeAfter;
                    resourceKey = "AfterAgree";
                    break;

                /* 담당협조 추가 */ 
                case 'CA101':
                    agreeId = "emp1_after";
                    plResult = grids.CAgree1;
                    resourceKey = "AfterDraft";
                    break;
                case 'CA102':
                    agreeId = "r1001_after";
                    plResult = grids.CAgree2;
                    resourceKey = "AfterRev1";
                    break;
                case 'CA103':
                    agreeId = "r1002_after";
                    plResult = grids.CAgree3;
                    resourceKey = "AfterRev2";
                    break;
                case 'CA104':
                    agreeId = "r1003_after";
                    plResult = grids.CAgree4;
                    resourceKey = "AfterRev3";
                    break;
                case 'CA105':
                    agreeId = "r1004_after";
                    plResult = grids.CAgree5;
                    resourceKey = "AfterRev4";
                    break;
                case 'CA106':
                    agreeId = "r1005_after";
                    plResult = grids.CAgree6;
                    resourceKey = "AfterRev5";
                    break;
                case 'CA107':
                    agreeId = "r1006_after";
                    plResult = grids.CAgree7;
                    resourceKey = "AfterRev6";
                    break;

                // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)      
                case 'CA201':
                    agreeId = "emp2_after";
                    plResult = grids.C2Agree1;
                    resourceKey = "AfterDraft";
                    break;
                case 'CA202':
                    agreeId = "r2001_after";
                    plResult = grids.C2Agree2;
                    resourceKey = "AfterRev1";
                    break;
                case 'CA203':
                    agreeId = "r2002_after";
                    plResult = grids.C2Agree3;
                    resourceKey = "AfterRev2";
                    break;
                case 'CA204':
                    agreeId = "r2003_after";
                    plResult = grids.C2Agree4;
                    resourceKey = "AfterRev3";
                    break;
                case 'CA205':
                    agreeId = "r2004_after";
                    plResult = grids.C2Agree5;
                    resourceKey = "AfterRev4";
                    break;
                case 'CA206':
                    agreeId = "r2005_after";
                    plResult = grids.C2Agree6;
                    resourceKey = "AfterRev5";
                    break;
                case 'CA207':
                    agreeId = "r2006_after";
                    plResult = grids.C2Agree7;
                    resourceKey = "AfterRev6";
                    break;
            }

            //탭이 비활성인 경우 리턴
            if (plResult.disabled) return false;

            Ext.each(ddSource.dragData.selections, function (record, index, allItems) {
                if (record.data.Type != "GROUP") {
                    var agree_cnt = dsResult.data.items.length;

                    if (record.data.EmpID.length == 0) {
                        strNoEmpIDUserList += record.data.UserName + ', ';
                        return true;
                    }

                    // EmpId 유일키
                    if (is_overlap)
                        var foundItem = dsResult.find('EmpID', record.data.EmpID);
                    else
                        var foundItem = -1

                    if (foundItem == -1) {

                        if ($(AwxXml).find('Histories History Agree[Ref="' + agreeId + '"]')[0] == null) {
                            fn_AddAgree($(AwxXml).find("Histories History[Seq='" + app_seq + "']")[0], agreeId);
                        }

                        if (dsResult.data.items.length >= 20) {
                            var args = new Array();
                            args[0] = GetResource("Agree");
                            args[1] = "20";
                            GW.Common.WarningMessageBox(GetResource("ApproverMaxMsg", args));
                            return false;
                        }

                        var idx = dsResult.data.items.length + 1;
                        var agree_task = agreeId + '_' + (idx < 10 ? "0" : "") + idx.toString();

                        var newRecord = new ApproverRecord({
                            EmpID: record.data.EmpID,
                            LoginID: record.data.LoginID,
                            ADDisplayName: record.data.ADDisplayName,
                            UserName: record.data.UserName,
                            Email: record.data.Email,
                            Type: record.data.Type,
                            DeptCode: record.data.DeptCode,
                            DeptName: record.data.DeptName,

                            DutyCode: record.data.DutyCode,
                            DutyName: record.data.DutyName,
                            JobCode: record.data.JobCode,
                            JobName: record.data.JobName,
                            RankCode: record.data.RankCode,
                            RankName: record.data.RankName,
                            CellPhone: record.data.CellPhone,
                            TeamChiefYN: record.data.TeamChiefYN,
                            CompanyCode: record.data.CompanyCode,
                            CompanyName: record.data.CompanyName,
                            SignID: record.data.SignID,
                            ExtensionNumber: record.data.ExtensionNumber,
                            FaxNumber: record.data.FaxNumber,
                            Depth: dsResult.title,
                            TaskId: agree_task,
                            Seq: '',
                            Validation: '',
                            Change: 'true'
                        });
                        dsResult.add(newRecord);
                        //AWX에 결재자 정보 추가
                        fn_AddApprover($(AwxXml).find("Histories History[Seq='" + app_seq + "'] Agree[Ref='" + agreeId + "']")[0], fn_GetUserInfo(newRecord), agree_task, idx);
                    }
                    else {
                        if (strOverLapUserList == "")
                            strOverLapUserList = record.get("UserName");
                        else
                            strOverLapUserList = strOverLapUserList + ", " + record.get("UserName");
                    }
                }
                else {
                    isGroup = true;
                }
            }, this);

            if (isGroup) {
                GW.ChargeAgree.WarningMessageBox(GetResource("ApproverNotSetGroupMsg"));
            }

            if (strOverLapUserList != "") {
                var args = new Array();
                args[0] = strOverLapUserList;
                args[1] = GetResource(resourceKey);
                GW.ChargeAgree.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
            }

            //협조 탭 타이틀 변경
            //var agreeId = ChargeAgree.TabAgreeContainer.activeTab.id
            // ChargeAgree.ChangeTabTitle(agreeId, dsResult);

            if (strNoEmpIDUserList.length > 1) {
                GW.ChargeAgree.WarningMessageBox(strNoEmpIDUserList + GetResource("NoInfoAddMsg"));
            }
            GW.ChargeAgree.AllSelectionClear();
        }

        //다중협조 설정 시작 
        if (is_agree_multi) {
            for (var i = 0; i < this.TabAgreeContainerMulti.items.length; i++) {
                if (!this.TabAgreeContainerMulti.items.items[i].disabled) {
                    //var agreeGrid = eval("grids.Agree" + (i + 1));
                    var agreeGrid = eval("grids." + ((app_seq == 1) ? "C" : ((app_seq == 2) ? "C2" : "")) + "Agree" + (i + 1));
                    if (agreeGrid != null && agreeGrid != undefined) {
                        agreeGrid.on('render', function () {
                            var AgreeGridDropTargetEl = agreeGrid.getView().el.dom.childNodes[0].childNodes[1];
                            this.AgreeGridDropTarget = new Ext.dd.DropTarget(AgreeGridDropTargetEl, {
                                ddGroup: 'DDGSelect',
                                notifyDrop: function (ddSource, e, data) {
                                    var mask = new Ext.LoadMask(agreeGrid.getView().el, { msg: GetResource("WaitMsg") });
                                    mask.show();
                                    HandlerAgreeGridDrop(ddSource, agreeGrid.store);
                                    mask.hide();
                                }
                            });
                            this.AgreeGridDropTarget.addToGroup('DDGApprover');
                        });
                    }

                    break;
                }
            }

            this.TabAgreeContainerMulti.on('tabchange', function (tab, item) {
                var agreeId = tab.activeTab.id.split("_")[1];
                switch (agreeId) {
                    case "A101":
                        var Agree1GridDropTargetEl = grids.Agree1.getView().el.dom.childNodes[0].childNodes[1];
                        this.Agree1GridDropTarget = new Ext.dd.DropTarget(Agree1GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.Agree1.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.Agree1.store);
                                mask.hide();
                            }
                        });
                        this.Agree1GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "A102":
                        var Agree2GridDropTargetEl = grids.Agree2.getView().el.dom.childNodes[0].childNodes[1];
                        this.Agree2GridDropTarget = new Ext.dd.DropTarget(Agree2GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.Agree2.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.Agree2.store);
                                mask.hide();
                            }
                        });
                        this.Agree2GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "A103":
                        var Agree3GridDropTargetEl = grids.Agree3.getView().el.dom.childNodes[0].childNodes[1];
                        this.Agree3GridDropTarget = new Ext.dd.DropTarget(Agree3GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.Agree3.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.Agree3.store);
                                mask.hide();
                            }
                        });
                        this.Agree3GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "A104":
                        var Agree4GridDropTargetEl = grids.Agree4.getView().el.dom.childNodes[0].childNodes[1];
                        this.Agree4GridDropTarget = new Ext.dd.DropTarget(Agree4GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.Agree4.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.Agree4.store);
                                mask.hide();
                            }
                        });
                        this.Agree4GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "A105":
                        var Agree5GridDropTargetEl = grids.Agree5.getView().el.dom.childNodes[0].childNodes[1];
                        this.Agree5GridDropTarget = new Ext.dd.DropTarget(Agree5GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.Agree5.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.Agree5.store);
                                mask.hide();
                            }
                        });
                        this.Agree5GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "A106":
                        var Agree6GridDropTargetEl = grids.Agree6.getView().el.dom.childNodes[0].childNodes[1];
                        this.Agree6GridDropTarget = new Ext.dd.DropTarget(Agree6GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.Agree6.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.Agree6.store);
                                mask.hide();
                            }
                        });
                        this.Agree6GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "A107":
                        var Agree7GridDropTargetEl = grids.Agree7.getView().el.dom.childNodes[0].childNodes[1];
                        this.Agree7GridDropTarget = new Ext.dd.DropTarget(Agree7GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.Agree7.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.Agree7.store);
                                mask.hide();
                            }
                        });
                        this.Agree7GridDropTarget.addToGroup('DDGApprover');
                        break;

                    /*담당협조 추가*/ 
                    case "CA101":
                        var CAgree1GridDropTargetEl = grids.CAgree1.getView().el.dom.childNodes[0].childNodes[1];
                        this.CAgree1GridDropTarget = new Ext.dd.DropTarget(CAgree1GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.CAgree1.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.CAgree1.store);
                                mask.hide();
                            }
                        });
                        this.CAgree1GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA102":
                        var CAgree2GridDropTargetEl = grids.CAgree2.getView().el.dom.childNodes[0].childNodes[1];
                        this.CAgree2GridDropTarget = new Ext.dd.DropTarget(CAgree2GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.CAgree2.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.CAgree2.store);
                                mask.hide();
                            }
                        });
                        this.CAgree2GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA103":
                        var CAgree3GridDropTargetEl = grids.CAgree3.getView().el.dom.childNodes[0].childNodes[1];
                        this.CAgree3GridDropTarget = new Ext.dd.DropTarget(CAgree3GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.CAgree3.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.CAgree3.store);
                                mask.hide();
                            }
                        });
                        this.CAgree3GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA104":
                        var CAgree4GridDropTargetEl = grids.CAgree4.getView().el.dom.childNodes[0].childNodes[1];
                        this.CAgree4GridDropTarget = new Ext.dd.DropTarget(CAgree4GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.CAgree4.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.CAgree4.store);
                                mask.hide();
                            }
                        });
                        this.CAgree4GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA105":
                        var CAgree5GridDropTargetEl = grids.CAgree5.getView().el.dom.childNodes[0].childNodes[1];
                        this.CAgree5GridDropTarget = new Ext.dd.DropTarget(CAgree5GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.CAgree5.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.CAgree5.store);
                                mask.hide();
                            }
                        });
                        this.CAgree5GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA106":
                        var CAgree6GridDropTargetEl = grids.CAgree6.getView().el.dom.childNodes[0].childNodes[1];
                        this.CAgree6GridDropTarget = new Ext.dd.DropTarget(CAgree6GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.CAgree6.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.CAgree6.store);
                                mask.hide();
                            }
                        });
                        this.CAgree6GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA107":
                        var CAgree7GridDropTargetEl = grids.CAgree7.getView().el.dom.childNodes[0].childNodes[1];
                        this.CAgree7GridDropTarget = new Ext.dd.DropTarget(CAgree7GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.CAgree7.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.CAgree7.store);
                                mask.hide();
                            }
                        });
                        this.CAgree7GridDropTarget.addToGroup('DDGApprover');
                        break;

                    // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)      
                    case "CA201":
                        var C2Agree1GridDropTargetEl = grids.C2Agree1.getView().el.dom.childNodes[0].childNodes[1];
                        this.C2Agree1GridDropTarget = new Ext.dd.DropTarget(C2Agree1GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.C2Agree1.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.C2Agree1.store);
                                mask.hide();
                            }
                        });
                        this.C2Agree1GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA202":
                        var C2Agree2GridDropTargetEl = grids.C2Agree2.getView().el.dom.childNodes[0].childNodes[1];
                        this.C2Agree2GridDropTarget = new Ext.dd.DropTarget(C2Agree2GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.C2Agree2.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.C2Agree2.store);
                                mask.hide();
                            }
                        });
                        this.C2Agree2GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA203":
                        var C2Agree3GridDropTargetEl = grids.C2Agree3.getView().el.dom.childNodes[0].childNodes[1];
                        this.C2Agree3GridDropTarget = new Ext.dd.DropTarget(C2Agree3GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.C2Agree3.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.C2Agree3.store);
                                mask.hide();
                            }
                        });
                        this.C2Agree3GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA204":
                        var C2Agree4GridDropTargetEl = grids.C2Agree4.getView().el.dom.childNodes[0].childNodes[1];
                        this.C2Agree4GridDropTarget = new Ext.dd.DropTarget(C2Agree4GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.C2Agree4.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.C2Agree4.store);
                                mask.hide();
                            }
                        });
                        this.C2Agree4GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA205":
                        var C2Agree5GridDropTargetEl = grids.C2Agree5.getView().el.dom.childNodes[0].childNodes[1];
                        this.C2Agree5GridDropTarget = new Ext.dd.DropTarget(C2Agree5GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.C2Agree5.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.C2Agree5.store);
                                mask.hide();
                            }
                        });
                        this.C2Agree5GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA206":
                        var C2Agree6GridDropTargetEl = grids.C2Agree6.getView().el.dom.childNodes[0].childNodes[1];
                        this.C2Agree6GridDropTarget = new Ext.dd.DropTarget(C2Agree6GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.C2Agree6.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.C2Agree6.store);
                                mask.hide();
                            }
                        });
                        this.C2Agree6GridDropTarget.addToGroup('DDGApprover');
                        break;

                    case "CA207":
                        var C2Agree7GridDropTargetEl = grids.C2Agree7.getView().el.dom.childNodes[0].childNodes[1];
                        this.C2Agree7GridDropTarget = new Ext.dd.DropTarget(C2Agree7GridDropTargetEl, {
                            ddGroup: 'DDGSelect',
                            notifyDrop: function (ddSource, e, data) {
                                var mask = new Ext.LoadMask(grids.C2Agree7.getView().el, { msg: GetResource("WaitMsg") });
                                mask.show();
                                HandlerAgreeGridDrop(ddSource, grids.C2Agree7.store);
                                mask.hide();
                            }
                        });
                        this.C2Agree7GridDropTarget.addToGroup('DDGApprover');
                        break;
                }

            }, this)
        } //다중협조 설정 끝

        //전후협조 설정
        if (is_agree_before && is_agree_after) {
            var AgreeBeforeGridDropTargetEl = grids.AgreeBefore.getView().el.dom.childNodes[0].childNodes[1];
            this.AgreeBeforeGridDropTarget = new Ext.dd.DropTarget(AgreeBeforeGridDropTargetEl, {
                ddGroup: 'DDGSelect',
                notifyDrop: function (ddSource, e, data) {
                    var mask = new Ext.LoadMask(grids.AgreeBefore.getView().el, { msg: GetResource("WaitMsg") });
                    mask.show();
                    HandlerAgreeGridDrop(ddSource, grids.AgreeBefore.store);
                    mask.hide();
                }
            });
            this.AgreeBeforeGridDropTarget.addToGroup('DDGApprover');
            this.AgreeBeforeGridDropTarget.addToGroup('DDGAgreeAfter');

            this.TabAgreeContainerBeforeAfter.on('tabchange', function (tab, item) {
                if (tab.activeTab.id.split("_")[1] == "after") {
                    var AgreeAfterGridDropTargetEl = grids.AgreeAfter.getView().el.dom.childNodes[0].childNodes[1];
                    this.AgreeAfterGridDropTarget = new Ext.dd.DropTarget(AgreeAfterGridDropTargetEl, {
                        ddGroup: 'DDGSelect',
                        notifyDrop: function (ddSource, e, data) {
                            var mask = new Ext.LoadMask(grids.AgreeAfter.getView().el, { msg: GetResource("WaitMsg") });
                            mask.show();
                            HandlerAgreeGridDrop(ddSource, grids.AgreeAfter.store);
                            mask.hide();
                        }
                    });
                    this.AgreeAfterGridDropTarget.addToGroup('DDGApprover');
                    this.AgreeAfterGridDropTarget.addToGroup('DDGAgreeBefore');
                }
            });
        }
        else if (is_agree_before && !is_agree_after) {
            var AgreeBeforeGridDropTargetEl = grids.AgreeBefore.getView().el.dom.childNodes[0].childNodes[1];
            this.AgreeBeforeGridDropTarget = new Ext.dd.DropTarget(AgreeBeforeGridDropTargetEl, {
                ddGroup: 'DDGSelect',
                notifyDrop: function (ddSource, e, data) {
                    var mask = new Ext.LoadMask(grids.AgreeBefore.getView().el, { msg: GetResource("WaitMsg") });
                    mask.show();
                    HandlerAgreeGridDrop(ddSource, grids.AgreeBefore.store);
                    mask.hide();
                }
            });
            this.AgreeBeforeGridDropTarget.addToGroup('DDGApprover');
            this.AgreeBeforeGridDropTarget.addToGroup('DDGAgreeAfter');
        }
        else if (!is_agree_before && is_agree_after) {
            var AgreeAfterGridDropTargetEl = grids.AgreeAfter.getView().el.dom.childNodes[0].childNodes[1];
            this.AgreeAfterGridDropTarget = new Ext.dd.DropTarget(AgreeAfterGridDropTargetEl, {
                ddGroup: 'DDGSelect',
                notifyDrop: function (ddSource, e, data) {
                    var mask = new Ext.LoadMask(grids.AgreeAfter.getView().el, { msg: GetResource("WaitMsg") });
                    mask.show();
                    HandlerAgreeGridDrop(ddSource, grids.AgreeAfter.store);
                    mask.hide();
                }
            });
            this.AgreeAfterGridDropTarget.addToGroup('DDGApprover');
            this.AgreeAfterGridDropTarget.addToGroup('DDGAgreeBefore');
        }

        //승인자 관련
        if (this.CRowCount > 0) {
            this.CurrentGridSet.Charge.view.mainBody.on('mouseup', function (e, t) {
                index = this.CurrentGridSet.Charge.getView().findRowIndex(t);
                if (this.ChargeGridDropTarget.DDM.dragCurrent != null) {
                    if (this.ChargeGridDropTarget.DDM.dragCurrent.dragData.selections.length == 1) {
                        this.CurrentGridSet.Charge.getSelectionModel().selectRow(index, false);
                    }
                }
            }
			, this);
        }

        function HandlerChargeGridDrop(ddSource, dsResult) {
            var strNoEmpIDUserList = "";
            var cnt = 0;
            var isGroup = false;

            Ext.each(ddSource.dragData.selections, function (record, index, allItems) {
                if (record.data.Type != "GROUP") {
                    if (record.data.EmpID.length == 0) {
                        strNoEmpIDUserList += record.data.UserName + ', ';
                        return true;
                    }

                    // EmpId 유일키
                    if (is_overlap)
                        var foundItem = dsResult.store.find('EmpID', record.data.EmpID);
                    else
                        var foundItem = -1;

                    if (foundItem == -1) {
                        // 기본결재라인
                        if (dsResult.getSelectionModel().getSelections().length > 0) {
                            // Row가 선택되었을때
                            Ext.each(dsResult.getSelectionModel().getSelections(), function (trecord, tindex, tallItems) {

                                if (trecord.get('Change') == "false") {
                                    GW.Common.WarningMessageBox(GetResource("ImpossibleChange", trecord.get('Depth')));
                                    return;
                                }

                                var history = $(AwxXml).find('Histories History[Seq = ' + trecord.get('Seq') + ']')[0];
                                if (history == null) history = fn_AddHistory($(AwxXml).find('Histories')[0], trecord.get('Seq'));
                                // 현재 member 노드 접근
                                var approver = $(history).find('Approver[TaskID = \'' + trecord.get('TaskId') + '\']')[0];
                                if (approver != null) {
                                    var status = approver.getAttribute("Status");

                                    if (status != "") {
                                        GW.Common.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                                        return;
                                    }

                                    history.removeChild(approver);
                                }

                                if (record.data.DutyName == "") {
                                    if (trecord.get("TaskId").indexOf('app') > -1)
                                        record.data.DutyName = GetResource("TeamLeader");
                                    else
                                        record.data.DutyName = GetResource("TeamMember");
                                }
                                var newRecord = new ApproverRecord({
                                    EmpID: record.data.EmpID,
                                    LoginID: record.data.LoginID,
                                    ADDisplayName: record.data.ADDisplayName,
                                    UserName: record.data.UserName,
                                    Email: record.data.Email,
                                    Type: record.data.Type,
                                    DeptCode: record.data.DeptCode,
                                    DeptName: record.data.DeptName,

                                    DutyCode: record.data.DutyCode,
                                    DutyName: record.data.DutyName,
                                    JobCode: record.data.JobCode,
                                    JobName: record.data.JobName,
                                    RankCode: record.data.RankCode,
                                    RankName: record.data.RankName,
                                    CellPhone: record.data.CellPhone,
                                    CompanyCode: record.data.CompanyCode,
                                    CompanyName: record.data.CompanyName,
                                    SignID: record.data.SignID,
                                    TeamChiefYN: record.data.TeamChiefYN,
                                    ExtensionNumber: record.data.ExtensionNumber,
                                    FaxNumber: record.data.FaxNumber,
                                    Depth: trecord.get("Depth"),
                                    TaskId: trecord.get("TaskId"),
                                    Seq: trecord.get("Seq"),
                                    Validation: trecord.get("Validation"),
                                    Change: trecord.get("Change")
                                });

                                var idx = dsResult.store.indexOf(trecord);
                                dsResult.store.remove(trecord);
                                dsResult.store.insert(idx, newRecord);

                                var ord = dsResult.store.data.length - idx;

                                //AWX에 결재자 정보 추가
                                fn_AddApprover($(AwxXml).find('Histories History[Seq=' + trecord.get('Seq') + ']')[0], fn_GetUserInfo(record), trecord.get('TaskId'), ord);
                            }, this);
                        }
                        else {
                            return;
                            // Row가 선택되지 않았을 경우 빈 Row에 채운다
                            if (cnt == dsResult.store.data.items.length) return;
                            for (var j = dsResult.store.data.items.length - 1; j > -1; j--) {
                                if (dsResult.store.data.items[j].get('Change') != "false") {
                                    var history = $(AwxXml).find('Histories History[Seq = ' + dsResult.store.data.items[j].get('Seq') + ']')[0];
                                    if (history == null) history = fn_AddHistory($(AwxXml).find('Histories')[0], dsResult.store.data.items[j].get('Seq'));

                                    if (dsResult.store.data.items[j].data.EmpID == undefined || dsResult.store.data.items[j].data.EmpID == "") {

                                        var approver = $(history).find('Approver[TaskID = \'' + dsResult.store.data.items[j].get('TaskId') + '\']')[0];

                                        if (approver != null) {
                                            var status = approver.getAttribute("Status");

                                            if (status != "") {
                                                GW.Common.WarningMsgBox(GetResource("ApproverCompleteNoChangeMsg"));
                                                return;
                                            }
                                            history.removeChild(approver);
                                        }

                                        if (record.data.DutyName == "") {
                                            if (dsResult.store.data.items[j].data.TaskId.indexOf('app') > -1)
                                                record.data.DutyName = GetResource("TeamLeader");
                                            else
                                                record.data.DutyName = GetResource("TeamMember");
                                        }
                                        var newRecord = new ApproverRecord({
                                            EmpID: record.data.EmpID,
                                            LoginID: record.data.LoginID,
                                            ADDisplayName: record.data.ADDisplayName,
                                            UserName: record.data.UserName,
                                            Email: record.data.Email,
                                            Type: record.data.Type,
                                            DeptCode: record.data.DeptCode,
                                            DeptName: record.data.DeptName,

                                            DutyCode: record.data.DutyCode,
                                            DutyName: record.data.DutyName,
                                            JobCode: record.data.JobCode,
                                            JobName: record.data.JobName,
                                            RankCode: record.data.RankCode,
                                            RankName: record.data.RankName,
                                            CellPhone: record.data.CellPhone,
                                            TeamChiefYN: record.data.TeamChiefYN,
                                            CompanyCode: record.data.CompanyCode,
                                            CompanyName: record.data.CompanyName,
                                            SignID: record.data.SignID,
                                            ExtensionNumber: record.data.ExtensionNumber,
                                            FaxNumber: record.data.FaxNumber,
                                            Depth: dsResult.store.data.items[j].data.Depth,
                                            TaskId: dsResult.store.data.items[j].data.TaskId,
                                            Seq: dsResult.store.data.items[j].data.Seq,
                                            Validation: dsResult.store.data.items[j].data.Validation,
                                            Change: dsResult.store.data.items[j].data.Change
                                        });

                                        dsResult.store.remove(dsResult.store.data.items[j]);
                                        dsResult.store.insert(j, newRecord);

                                        var ord = dsResult.store.data.items.length - j;
                                        cnt++;
                                        //AWX에 결재자 정보 추가
                                        fn_AddApprover($(AwxXml).find('Histories History[Seq=' + dsResult.store.data.items[j].get('Seq') + ']')[0], fn_GetUserInfo(record), dsResult.store.data.items[j].get('TaskId'), ord);
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    else {
                        var args = new Array();
                        args[0] = record.get("UserName");
                        args[1] = dsResult.store.data.items[foundItem].get("Depth");
                        GW.ChargeAgree.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
                    }
                }
                else {
                    isGroup = true;
                }
            }, this);

            if (isGroup) {
                GW.ChargeAgree.WarningMessageBox(GetResource("ApproverNotSetGroupMsg"));
            }

            if (strNoEmpIDUserList.length > 1) {
                GW.Common.WarningMessageBox(strNoEmpIDUserList + GetResource("NoInfoAddMsg"));
            }
            GW.ChargeAgree.AllSelectionClear();
        }

        if (this.CRowCount > 0) {
            var ChargeGridDropTargetEl = grids.Charge.getView().el.dom.childNodes[0].childNodes[1];
            this.ChargeGridDropTarget = new Ext.dd.DropTarget(ChargeGridDropTargetEl, {
                ddGroup: 'DDGSelect',
                notifyDrop: function (ddSource, e, data) {
                    var mask = new Ext.LoadMask(grids.Charge.getView().el, { msg: GetResource("WaitMsg") });
                    mask.show();
                    HandlerChargeGridDrop(ddSource, grids.Charge);
                    mask.hide();
                }
            }, this);
        }
    },

    InitGird: function () {
        //결재자
        var ApproverGridCheckBox = new Ext.grid.CheckboxSelectionModel({ singleSelect: true });
        var ApproverResultCM = new Ext.grid.ColumnModel
		([
			{ header: GetResource("LevelTitle"), dataIndex: 'Depth', width: 40, fixed: true, menuDisabled: true, resizable: false, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserDuty"), dataIndex: 'DutyName', width: 45, renderer: this.RendererWithTooltip },
            { header: GetResource("UserRank"), dataIndex: 'RankName', width: 45, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
        //{ header: GetResource("UserEmpID"), dataIndex: 'EmpID', width: 55, renderer: this.RendererWithTooltip },
            {header: GetResource("UserJob"), dataIndex: 'JobName', width: 130, renderer: this.RendererWithTooltip }
		]);

        if (Ext.isIE6) {
            var tmpHeight = 76;
            tmpHeight = tmpHeight + (this.RowCount * 22);
        }
        else {
            var tmpHeight = 74;

            if (g_langCode != "zh")
                tmpHeight = tmpHeight + (this.RowCount * 20);
            else
                tmpHeight = tmpHeight + (this.RowCount * 22);
        }

        var ApproverResultGrid = new Ext.grid.GridPanel
		({
		    region: 'north',
		    margins: '5 5 0 5',
		    ddGroup: 'DDGApprover',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: true,
		    ds: this.ApproverResult,
		    cm: ApproverResultCM,
		    sm: ApproverGridCheckBox,
		    stripeRows: true,
		    height: tmpHeight,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Approver")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'Approver')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Approver")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'Approver')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Approver")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'Approver')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Approver")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'Approver')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Approver")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'Approver')
				    },
				    scope: this
				}
			],
		    title: GetResource("Approver"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 기안후 협조
        var Agree1GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var Agree1ResultCM = new Ext.grid.ColumnModel
		([
			Agree1GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var Agree1ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'emp0_A101',
		    ddGroup: 'DDGAgree1',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.Agree1Result,
		    cm: Agree1ResultCM,
		    sm: Agree1GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'Agree1')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'Agree1')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'Agree1')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'Agree1')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'Agree1')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterDraft"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토1후 협조
        var Agree2GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var Agree2ResultCM = new Ext.grid.ColumnModel
		([
			Agree2GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var Agree2ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r0001_A102',
		    ddGroup: 'DDGAgree2',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.Agree2Result,
		    cm: Agree2ResultCM,
		    sm: Agree2GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'Agree2')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'Agree2')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'Agree2')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'Agree2')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'Agree2')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev1"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토2후 협조
        var Agree3GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var Agree3ResultCM = new Ext.grid.ColumnModel
		([
			Agree3GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var Agree3ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r0002_A103',
		    ddGroup: 'DDGAgree3',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.Agree3Result,
		    cm: Agree3ResultCM,
		    sm: Agree3GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'Agree3')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'Agree3')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'Agree3')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'Agree3')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'Agree3')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev2"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토3후 협조
        var Agree4GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var Agree4ResultCM = new Ext.grid.ColumnModel
		([
			Agree4GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var Agree4ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r0003_A104',
		    ddGroup: 'DDGAgree4',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.Agree4Result,
		    cm: Agree4ResultCM,
		    sm: Agree4GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'Agree4')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'Agree4')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'Agree4')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'Agree4')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'Agree4')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev3"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토4후 협조
        var Agree5GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var Agree5ResultCM = new Ext.grid.ColumnModel
		([
			Agree5GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var Agree5ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r0004_A105',
		    ddGroup: 'DDGAgree5',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.Agree5Result,
		    cm: Agree5ResultCM,
		    sm: Agree5GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'Agree5')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'Agree5')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'Agree5')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'Agree5')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'Agree5')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev4"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토5후 협조
        var Agree6GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var Agree6ResultCM = new Ext.grid.ColumnModel
		([
			Agree6GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var Agree6ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r0005_A106',
		    ddGroup: 'DDGAgree6',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.Agree6Result,
		    cm: Agree6ResultCM,
		    sm: Agree6GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'Agree6')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'Agree6')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'Agree6')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'Agree6')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'Agree6')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev5"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토6후 협조
        var Agree7GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var Agree7ResultCM = new Ext.grid.ColumnModel
		([
			Agree7GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var Agree7ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r0006_A107',
		    ddGroup: 'DDGAgree7',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.Agree7Result,
		    cm: Agree7ResultCM,
		    sm: Agree7GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'Agree7')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'Agree7')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'Agree7')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'Agree7')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'Agree7')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev6"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 전 협조
        var AgreeBeforeGridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var AgreeBeforeResultCM = new Ext.grid.ColumnModel
		([
			AgreeBeforeGridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var AgreeBeforeResultGrid = new Ext.grid.GridPanel
		({
		    id: 'agree_before',
		    ddGroup: 'DDGAgreeBefore',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    style: 'padding:0 0 5 0',
		    ds: this.AgreeBeforeResult,
		    cm: AgreeBeforeResultCM,
		    sm: AgreeBeforeGridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'AgreeBefore')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'AgreeBefore')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'AgreeBefore')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'AgreeBefore')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'AgreeBefore')
				    },
				    scope: this
				}
			],
		    title: GetResource("BeforeAgree"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 후 협조
        var AgreeAfterGridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var AgreeAfterResultCM = new Ext.grid.ColumnModel
		([
			AgreeAfterGridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var AgreeAfterResultGrid = new Ext.grid.GridPanel
		({
		    id: 'agree_after',
		    ddGroup: 'DDGAgreeAfter',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    style: 'padding:0 0 5 0',
		    ds: this.AgreeAfterResult,
		    cm: AgreeAfterResultCM,
		    sm: AgreeAfterGridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'AgreeAfter')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'AgreeAfter')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'AgreeAfter')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'AgreeAfter')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'AgreeAfter')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterAgree"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        if (Ext.isIE6) {
            var tmpHeight = 76;
            tmpHeight = tmpHeight + (this.CRowCount * 22);
        }
        else {
            var tmpHeight = 74;

            if (g_langCode != "zh")
                tmpHeight = tmpHeight + (this.CRowCount * 20);
            else
                tmpHeight = tmpHeight + (this.CRowCount * 22);
        }

        /* 담당협조 추가 */
        // 기안후 협조
        var CAgree1GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var CAgree1ResultCM = new Ext.grid.ColumnModel
		([
			CAgree1GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var CAgree1ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'emp1_CA101',
		    ddGroup: 'DDGCAgree1',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.CAgree1Result,
		    cm: CAgree1ResultCM,
		    sm: CAgree1GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'CAgree1')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'CAgree1')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'CAgree1')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'CAgree1')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'CAgree1')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterDraft"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토1후 협조
        var CAgree2GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var CAgree2ResultCM = new Ext.grid.ColumnModel
		([
			CAgree2GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var CAgree2ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r1001_CA102',
		    ddGroup: 'DDGCAgree2',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.CAgree2Result,
		    cm: CAgree2ResultCM,
		    sm: CAgree2GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'CAgree2')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'CAgree2')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'CAgree2')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'CAgree2')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'CAgree2')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev1"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토2후 협조
        var CAgree3GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var CAgree3ResultCM = new Ext.grid.ColumnModel
		([
			CAgree3GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var CAgree3ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r1002_CA103',
		    ddGroup: 'DDGCAgree3',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.CAgree3Result,
		    cm: CAgree3ResultCM,
		    sm: CAgree3GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'CAgree3')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'CAgree3')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'CAgree3')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'CAgree3')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'CAgree3')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev2"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토3후 협조
        var CAgree4GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var CAgree4ResultCM = new Ext.grid.ColumnModel
		([
			CAgree4GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var CAgree4ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r1003_CA104',
		    ddGroup: 'DDGCAgree4',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.CAgree4Result,
		    cm: CAgree4ResultCM,
		    sm: CAgree4GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'CAgree4')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'CAgree4')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'CAgree4')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'CAgree4')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'CAgree4')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev3"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토4후 협조
        var CAgree5GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var CAgree5ResultCM = new Ext.grid.ColumnModel
		([
			CAgree5GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var CAgree5ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r1004_CA105',
		    ddGroup: 'DDGCAgree5',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.CAgree5Result,
		    cm: CAgree5ResultCM,
		    sm: CAgree5GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'CAgree5')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'CAgree5')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'CAgree5')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'CAgree5')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'CAgree5')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev4"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토5후 협조
        var CAgree6GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var CAgree6ResultCM = new Ext.grid.ColumnModel
		([
			CAgree6GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var CAgree6ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r1005_CA106',
		    ddGroup: 'DDGCAgree6',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.CAgree6Result,
		    cm: CAgree6ResultCM,
		    sm: CAgree6GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'CAgree6')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'CAgree6')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'CAgree6')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'CAgree6')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'CAgree6')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev5"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토6후 협조
        var CAgree7GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var CAgree7ResultCM = new Ext.grid.ColumnModel
		([
			CAgree7GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var CAgree7ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r1006_CA107',
		    ddGroup: 'DDGCAgree7',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.CAgree7Result,
		    cm: CAgree7ResultCM,
		    sm: CAgree7GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'CAgree7')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'CAgree7')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'CAgree7')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'CAgree7')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'CAgree7')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev6"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});
        /* 담당협조 추가 끝 */

        // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)
        /* 담당협조 추가 */
        // 기안후 협조
        var C2Agree1GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var C2Agree1ResultCM = new Ext.grid.ColumnModel
		([
			C2Agree1GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var C2Agree1ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'emp2_CA201',
		    ddGroup: 'DDGC2Agree1',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.C2Agree1Result,
		    cm: C2Agree1ResultCM,
		    sm: C2Agree1GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'C2Agree1')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'C2Agree1')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'C2Agree1')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'C2Agree1')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'C2Agree1')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterDraft"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토1후 협조
        var C2Agree2GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var C2Agree2ResultCM = new Ext.grid.ColumnModel
		([
			C2Agree2GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var C2Agree2ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r2001_CA202',
		    ddGroup: 'DDGC2Agree2',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.C2Agree2Result,
		    cm: C2Agree2ResultCM,
		    sm: C2Agree2GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'C2Agree2')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'C2Agree2')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'C2Agree2')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'C2Agree2')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'C2Agree2')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev1"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토2후 협조
        var C2Agree3GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var C2Agree3ResultCM = new Ext.grid.ColumnModel
		([
			C2Agree3GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var C2Agree3ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r2002_CA203',
		    ddGroup: 'DDGC2Agree3',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.C2Agree3Result,
		    cm: C2Agree3ResultCM,
		    sm: C2Agree3GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'C2Agree3')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'C2Agree3')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'C2Agree3')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'C2Agree3')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'C2Agree3')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev2"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토3후 협조
        var C2Agree4GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var C2Agree4ResultCM = new Ext.grid.ColumnModel
		([
			C2Agree4GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var C2Agree4ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r2003_CA204',
		    ddGroup: 'DDGC2Agree4',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.C2Agree4Result,
		    cm: C2Agree4ResultCM,
		    sm: C2Agree4GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'C2Agree4')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'C2Agree4')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'C2Agree4')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'C2Agree4')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'C2Agree4')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev3"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토4후 협조
        var C2Agree5GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var C2Agree5ResultCM = new Ext.grid.ColumnModel
		([
			C2Agree5GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var C2Agree5ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r2004_CA205',
		    ddGroup: 'DDGC2Agree5',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.C2Agree5Result,
		    cm: C2Agree5ResultCM,
		    sm: C2Agree5GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'C2Agree5')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'C2Agree5')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'C2Agree5')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'C2Agree5')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'C2Agree5')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev4"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토5후 협조
        var C2Agree6GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var C2Agree6ResultCM = new Ext.grid.ColumnModel
		([
			C2Agree6GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var C2Agree6ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r2005_CA206',
		    ddGroup: 'DDGC2Agree6',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.C2Agree6Result,
		    cm: C2Agree6ResultCM,
		    sm: C2Agree6GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'C2Agree6')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'C2Agree6')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'C2Agree6')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'C2Agree6')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'C2Agree6')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev5"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        // 검토6후 협조
        var C2Agree7GridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var C2Agree7ResultCM = new Ext.grid.ColumnModel
		([
			C2Agree7GridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 80, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 110, renderer: this.RendererWithTooltip }
		]);

        var C2Agree7ResultGrid = new Ext.grid.GridPanel
		({
		    id: 'r2006_CA207',
		    ddGroup: 'DDGC2Agree7',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: false,
		    ds: this.C2Agree7Result,
		    cm: C2Agree7ResultCM,
		    sm: C2Agree7GridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Agree")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'C2Agree7')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Agree")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'C2Agree7')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Agree")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'C2Agree7')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Agree")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'C2Agree7')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Agree")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'C2Agree7')
				    },
				    scope: this
				}
			],
		    title: GetResource("AfterRev6"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});
        /* 담당협조 추가 끝 */

        // 담당
        var ChargeGridCheckBox = new Ext.grid.CheckboxSelectionModel({ singleSelect: true });
        var ChargeResultCM = new Ext.grid.ColumnModel
		([
        //            { header: GetResource("LevelTitle"), dataIndex: 'Depth', width: 40, fixed: true, menuDisabled: true, resizable: false, renderer: this.RendererWithTooltip },
        //			{ header: GetResource("UserRank"), dataIndex: 'RankName', width: 60, renderer: this.RendererWithTooltip },
        //			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 80, renderer: this.RendererUserName.createDelegate(this) },
        //			{ header: GetResource("UserEmpID"), dataIndex: 'EmpID', width: 55, renderer: this.RendererWithTooltip },
        //            { header: GetResource("UserJob"), dataIndex: 'JobName', width: 97, renderer: this.RendererWithTooltip }

			{header: GetResource("LevelTitle"), dataIndex: 'Depth', width: 40, fixed: true, menuDisabled: true, resizable: false, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', width: 85, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 75, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserEmpID"), dataIndex: 'EmpID', width: 50, renderer: this.RendererWithTooltip }
		]);

        var ChargeResultGrid = new Ext.grid.GridPanel
		({
		    ddGroup: 'DDGACharge',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: true,
		    ds: this.ChargeResult,
		    cm: ChargeResultCM,
		    sm: ChargeGridCheckBox,
		    stripeRows: true,
		    height: tmpHeight,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("LastApprover")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'Charge')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("LastApprover")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'Charge')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("LastApprover")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'Charge')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("LastApprover")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function () {
				        this.OnButtonClick('Up', 'Charge')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("LastApprover")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function () {
				        this.OnButtonClick('Down', 'Charge')
				    },
				    scope: this
				}
			],
		    title: GetResource("Charger"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        var gridSet =
		{
		    Approver: ApproverResultGrid,
		    Agree1: Agree1ResultGrid,
		    Agree2: Agree2ResultGrid,
		    Agree3: Agree3ResultGrid,
		    Agree4: Agree4ResultGrid,
		    Agree5: Agree5ResultGrid,
		    Agree6: Agree6ResultGrid,
		    Agree7: Agree7ResultGrid,
		    AgreeBefore: AgreeBeforeResultGrid,
		    AgreeAfter: AgreeAfterResultGrid,
		    Charge: ChargeResultGrid,

		    /*담당협조 추가*/
		    CAgree1: CAgree1ResultGrid,
		    CAgree2: CAgree2ResultGrid,
		    CAgree3: CAgree3ResultGrid,
		    CAgree4: CAgree4ResultGrid,
		    CAgree5: CAgree5ResultGrid,
		    CAgree6: CAgree6ResultGrid,
		    CAgree7: CAgree7ResultGrid,
		    /*담당협조 추가 끝*/

		    // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)
		    /*담당협조 추가*/
		    C2Agree1: C2Agree1ResultGrid,
		    C2Agree2: C2Agree2ResultGrid,
		    C2Agree3: C2Agree3ResultGrid,
		    C2Agree4: C2Agree4ResultGrid,
		    C2Agree5: C2Agree5ResultGrid,
		    C2Agree6: C2Agree6ResultGrid,
		    C2Agree7: C2Agree7ResultGrid
		    /*담당2협조 추가 끝*/
		};

        return gridSet;
    },

    Render: function () {

        var divHeight = 0;

        if (Ext.isIE6) {
            var agreeHeight = 126;
        }
        else {
            if (g_langCode == "zh") divHeight = this.RowCount * 2;
            var agreeHeight = 140 - divHeight
        }

        // 협조탭 컨테이너(멀티)
        this.TabAgreeContainerMulti = new Ext.TabPanel
		({
		    activeTab: 0,
		    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
		    height: agreeHeight,
		    border: false,
		    enableTabScroll: true,
		    defaults: {
		        disabled: true
		    }

		});
        // 협조탭 컨테이너(전 후협조)
        this.TabAgreeContainerBeforeAfter = new Ext.TabPanel
		({
		    activeTab: 0,
		    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
		    height: agreeHeight,
		    border: false,
		    defaults: {
		        disabled: false
		    }
		});

        // TO DO : 
        // 전협조 후협조 일경우는 다른 패널을 넣도록 수정
        this.AgreePanel = new Ext.Panel
		({
		    id: 'AgreePanel',
		    region: 'center',
		    border: false,
		    margins: '5 5 0 5',
		    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;'
		})

        if (is_agree_multi) {
            this.AgreePanel = new Ext.Panel
			({
			    id: 'AgreePanel',
			    title: GetResource("Agree"),
			    region: 'center',
			    margins: '5 5 5 5',
			    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;'

			})

            // 협조자 Node 수만큼 추가한다.
            var tabsNode = $(FormXml).find("ui[seq='" + app_seq + "']")[0];

            if (tabsNode != null) {
                var tabNodes = $(tabsNode).find("tab");

                for (var i = 0; i < tabNodes.length; i++) {
                    var objKey = tabNodes[i].getAttribute("type");
                    if (objKey == "ChargeAgree") {
                        var listNode = $(tabNodes[i]).find("list[type='agree']")[0]

                        if (listNode != null) {
                            var itemNodes = $(listNode).find("item[type='agree']");

                            for (var j = 1; j <= itemNodes.length; j++) {
                                var agrGrid = eval("this.CurrentGridSet." + ((app_seq == 1) ? "C" : (app_seq == 2) ? "C2" : "") + "Agree" + j);
                                // eval("this.CurrentGridSet.Agree" + j);

                                if (agrGrid != null) {
                                    this.TabAgreeContainerMulti.add(agrGrid);
                                }
                            }
                        }
                    }
                }
            }

            var agrHeight = 0;
            var divH = 0;

            if (Ext.isIE6) {
                agrHeight = 284;
            }
            else {
                if (g_langCode == "zh") divH = this.RowCount * 2;
                agrHeight = 298 - divH;
            }

            this.TabAgreeContainerMulti.height = agrHeight - (22.5 * itemNodes.length);

            this.AgreePanel.add(this.TabAgreeContainerMulti);
        }
        else if (is_agree_before && is_agree_after) {
            this.AgreePanel = new Ext.Panel
			({
			    id: 'AgreePanel',
			    title: GetResource("Agree"),
			    region: 'center',
			    margins: '5 5 5 5',
			    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;'
			})
            this.TabAgreeContainerBeforeAfter.add(this.CurrentGridSet.AgreeBefore);
            this.TabAgreeContainerBeforeAfter.add(this.CurrentGridSet.AgreeAfter);
            this.AgreePanel.add(this.TabAgreeContainerBeforeAfter);
        }
        else if (is_agree_before && !is_agree_after) {
            //타이틀 변경
            var tabsNode = $(FormXml).find("ui[seq='" + app_seq + "']")[0];

            if (tabsNode != null) {
                var tabNodes = $(tabsNode).find("tab");

                for (var i = 0; i < tabNodes.length; i++) {
                    var objKey = tabNodes[i].getAttribute("type");
                    if (objKey == "ChargeAgree") {
                        var listNode = $(tabNodes[i]).find("list[id='before']")[0];

                        if (listNode != null) {
                            var title = $(listNode).find("lstitle")[0].text;
                            this.CurrentGridSet.AgreeBefore.setTitle(title);
                        }
                        break;
                    }
                }
            }

            this.CurrentGridSet.AgreeAfter.border = true;
            if (this.RowCount > 0) {
                if (Ext.isIE6)
                    this.CurrentGridSet.AgreeBefore.setHeight(223 - divHeight);
                else
                    this.CurrentGridSet.AgreeBefore.setHeight(237 - divHeight);
            }
            else {
                if (Ext.isIE6)
                    this.CurrentGridSet.AgreeBefore.setHeight(414);
                else
                    this.CurrentGridSet.AgreeBefore.setHeight(416);
            }
            this.AgreePanel.add(this.CurrentGridSet.AgreeBefore);
        }
        else if (!is_agree_before && is_agree_after) {
            //타이틀 변경
            var tabsNode = $(FormXml).find("ui[seq='" + app_seq + "']")[0];

            if (tabsNode != null) {
                var tabNodes = $(tabsNode).find("tab");

                for (var i = 0; i < tabNodes.length; i++) {
                    var objKey = tabNodes[i].getAttribute("type");
                    if (objKey == "ChargeAgree") {
                        var listNode = $(tabNodes[i]).find("list[id='after']")[0];

                        if (listNode != null) {
                            var title = $(listNode).find("lstitle")[0].attr("text");
                            this.CurrentGridSet.AgreeAfter.setTitle(title);
                        }
                        break;
                    }
                }
            }

            this.CurrentGridSet.AgreeAfter.border = true;
            if (this.RowCount > 0) {
                if (Ext.isIE6)
                    this.CurrentGridSet.AgreeAfter.setHeight(223 - divHeight);
                else
                    this.CurrentGridSet.AgreeAfter.setHeight(237 - divHeight);
            }
            else {
                if (Ext.isIE6)
                    this.CurrentGridSet.AgreeAfter.setHeight(414);
                else
                    this.CurrentGridSet.AgreeAfter.setHeight(416);
            }

            this.AgreePanel.add(this.CurrentGridSet.AgreeAfter);
        }

        if (this.CRowCount > 0) {
            this.CurrentGridSet.Charge.border = true;
            this.AgreePanel.add(this.CurrentGridSet.Charge);
        }

        //TO DO : 담당자가 포함 되어있을 경우 처리
        if (this.RowCount > 0) {
            this.ReturnPanel = new Ext.Panel
			({
			    id: 'ChargeAgree',
			    layout: 'border',
			    border: false,
			    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
			    items: [this.CurrentGridSet.Approver, this.AgreePanel]
			});
        }
        else {
            this.ReturnPanel = new Ext.Panel
			({
			    id: 'ChargeAgree',
			    layout: 'border',
			    border: false,
			    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
			    items: [
			    {
			        region: 'north',
			        height: 0,
			        border: false
			    }
				, this.AgreePanel]
			});
        }
    },

    HandlerAddApprover: function (dataGrid, dsResult) {
        this.InitSelectGrid();
        var strNoEmpIDUserList = "";
        var cnt = 0;
        var isGroup = false;

        if (this.CurrentGridSet.Select.Acl != undefined || this.CurrentGridSet.Select.Acl != null) {
            this.WarningMessageBox(GetResource("SelectOrgMsg"));
            return false;
        }

        if (this.CurrentGridSet.Select.getSelectionModel().getSelections().length == 0) {
            this.WarningMessageBox(GetResource("SelectOrgMsg"));
            return false;
        }

        Ext.each(this.CurrentGridSet.Select.getSelectionModel().getSelections(), function (record, index, allItems) {

            if (record.data.Type != "GROUP") {
                if (record.data.EmpID.length == 0) {
                    strNoEmpIDUserList += record.data.UserName + ', ';
                    return true;
                }

                var history = $(AwxXml).find('Histories History[Seq = ' + app_seq + ']')[0];
                if (history == null) {
                    history = fn_AddHistory($(AwxXml).find('Histories')[0], app_seq);
                }

                if (dataGrid.getSelectionModel().getSelections().length > 0 && allItems.length > 1) {
                    this.WarningMessageBox(GetResource("OnlyOneSelectMsg"));
                    return false;
                }
                // EmpId 유일키
                if (is_overlap)
                    var foundItem = dsResult.find('EmpID', record.data.EmpID);
                else
                    var foundItem = -1;

                if (foundItem == -1) {
                    // 기본결재라인
                    if (dataGrid.getSelectionModel().getSelections().length > 0) {
                        // Row가 선택되었을때
                        Ext.each(dataGrid.getSelectionModel().getSelections(), function (trecord, tindex, tallItems) {
                            //대리작성인 경우 기안자 변경 불가.
                            if (trecord.get('TaskId') == "emp0") {
                                if ($(AwxXml).find('Fields')[0] != null) {
                                    if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null) {
                                        if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y") {
                                            this.WarningMessageBox(GetResource("ApproverDrafterNoChangeMsg"));
                                            return;
                                        }
                                    }
                                }
                            }
                            // 현재 member 노드 접근
                            var approver = $(history).find('Approver[TaskID = \'' + trecord.get('TaskId') + '\']')[0];
                            if (approver != null) {
                                var status = approver.getAttribute("Status");

                                if (status != "") {
                                    this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                                    return;
                                }

                                if (this.CheckUserId) {
                                    if (approver.getAttribute("LoginID") == this.CurrentUser && approver.getAttribute("TaskID") == this.CurrentUserTaskID) {
                                        this.WarningMessageBox(GetResource("AppointApprovalCurrentApprover"));
                                        //return;
                                    }
                                }
                                history.removeChild(approver);
                            }

                            if (trecord.get('Change') == "false") {
                                this.WarningMessageBox(GetResource("ImpossibleChange", trecord.get('Depth')));
                                return;
                            }

                            if (record.data.DutyName == "") {
                                if (trecord.get("TaskId").indexOf('app') > -1)
                                    record.data.DutyName = GetResource("TeamLeader");
                                else
                                    record.data.DutyName = GetResource("TeamMember");
                            }

                            var newRecord = new ApproverRecord({
                                EmpID: record.data.EmpID,
                                LoginID: record.data.LoginID,
                                ADDisplayName: record.data.ADDisplayName,
                                UserName: record.data.UserName,
                                Email: record.data.Email,
                                Type: record.data.Type,
                                DeptCode: record.data.DeptCode,
                                DeptName: record.data.DeptName,
                                DutyCode: record.data.DutyCode,
                                DutyName: record.data.DutyName,
                                JobCode: record.data.JobCode,
                                JobName: record.data.JobName,
                                RankCode: record.data.RankCode,
                                RankName: record.data.RankName,
                                CellPhone: record.data.CellPhone,
                                TeamChiefYN: record.data.TeamChiefYN,
                                CompanyCode: record.data.CompanyCode,
                                CompanyName: record.data.CompanyName,
                                SignID: record.data.SignID,
                                ExtensionNumber: record.data.ExtensionNumber,
                                FaxNumber: record.data.FaxNumber,
                                Depth: trecord.get("Depth"),
                                TaskId: trecord.get("TaskId"),
                                Seq: trecord.get("Seq"),
                                Validation: trecord.get("Validation"),
                                Change: trecord.get("Change")
                            });

                            var idx = dsResult.indexOf(trecord);
                            dsResult.remove(trecord);
                            dsResult.insert(idx, newRecord);

                            var ord = dsResult.data.length - idx;
                            //AWX에 결재자 정보 추가
                            fn_AddApprover($(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0], fn_GetUserInfo(record), trecord.get('TaskId'), ord);
                            //협조탭 Enable처리
                            if (is_agree_multi) this.EnableAgreeTab(trecord.get('TaskId'), true);
                        }, this);
                    }
                    else {
                        // Row가 선택되지 않았을 경우 빈 Row에 채운다
                        if (cnt == dsResult.data.items.length) return;
                        for (var j = dsResult.data.items.length - 1; j > -1; j--) {
                            if (dsResult.data.items[j].get('Change') != "false") {
                                if (dsResult.data.items[j].data.EmpID == undefined || dsResult.data.items[j].data.EmpID == "") {
                                    //대리작성인 경우 기안자 변경 불가.
                                    if (dsResult.data.items[j].get('TaskId') == "emp0") {
                                        if ($(AwxXml).find('Fields')[0] != null) {
                                            if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null) {
                                                if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y") {
                                                    this.WarningMessageBox(GetResource("ApproverDrafterNoChangeMsg"));
                                                    return;
                                                }
                                            }
                                        }
                                    }
                                    var approver = $(history).find('Approver[TaskID = \'' + dsResult.data.items[j].get('TaskId') + '\']')[0];

                                    if (approver != null) {
                                        var status = approver.getAttribute("Status");

                                        if (status != "") {
                                            this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                                            return;
                                        }

                                        if (this.CheckUserId) {
                                            if (approver.getAttribute("LoginID") == this.CurrentUser && approver.getAttribute("TaskID") == this.CurrentUserTaskID) {
                                                this.WarningMessageBox(GetResource("AppointApprovalCurrentApprover"));
                                                //return;
                                            }
                                        }

                                        history.removeChild(approver);
                                    }

                                    if (record.data.DutyName == "") {
                                        if (dsResult.data.items[j].data.TaskId.indexOf('app') > -1)
                                            record.data.DutyName = GetResource("TeamLeader");
                                        else
                                            record.data.DutyName = GetResource("TeamMember");
                                    }
                                    var newRecord = new ApproverRecord({
                                        EmpID: record.data.EmpID,
                                        LoginID: record.data.LoginID,
                                        ADDisplayName: record.data.ADDisplayName,
                                        UserName: record.data.UserName,
                                        Email: record.data.Email,
                                        Type: record.data.Type,
                                        DeptCode: record.data.DeptCode,
                                        DeptName: record.data.DeptName,

                                        DutyCode: record.data.DutyCode,
                                        DutyName: record.data.DutyName,
                                        JobCode: record.data.JobCode,
                                        JobName: record.data.JobName,
                                        RankCode: record.data.RankCode,
                                        RankName: record.data.RankName,
                                        CellPhone: record.data.CellPhone,
                                        TeamChiefYN: record.data.TeamChiefYN,
                                        CompanyCode: record.data.CompanyCode,
                                        CompanyName: record.data.CompanyName,
                                        SignID: record.data.SignID,
                                        ExtensionNumber: record.data.ExtensionNumber,
                                        FaxNumber: record.data.FaxNumber,
                                        Depth: dsResult.data.items[j].data.Depth,
                                        TaskId: dsResult.data.items[j].data.TaskId,
                                        Seq: dsResult.data.items[j].data.Seq,
                                        Validation: dsResult.data.items[j].data.Validation,
                                        Change: dsResult.data.items[j].data.Change
                                    });
                                    dsResult.remove(dsResult.data.items[j]);
                                    dsResult.insert(j, newRecord);
                                    cnt++;

                                    var ord = dsResult.data.items.length - j;
                                    //AWX에 결재자 정보 추가
                                    fn_AddApprover($(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0], fn_GetUserInfo(record), dsResult.data.items[j].get('TaskId'), ord);
                                    //협조탭 Enable처리
                                    if (is_agree_multi) this.EnableAgreeTab(dsResult.data.items[j].get('TaskId'), true);
                                    break;
                                }
                            }
                        }
                    }
                }
                else {
                    var args = new Array();
                    args[0] = record.get("UserName");
                    args[1] = dsResult.data.items[foundItem].get("Depth");
                    this.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
                }
                //Activate Tab선택
                if (is_agree_multi) this.ActivateAgreeTab();
            }
            else {
                isGroup = true;
            }
        }, this);

        if (isGroup) {
            this.WarningMessageBox(GetResource("ApproverNotSetGroupMsg"));
        }

        if (strNoEmpIDUserList.length > 1) {
            this.WarningMessageBox(strNoEmpIDUserList + GetResource("NoInfoAddMsg"));
        }
        this.AllSelectionClear();
    },

    HandlerAddAgree: function (dataGrid, dsResult) {
        this.InitSelectGrid();

        if (this.CurrentGridSet.Select.Acl != undefined || this.CurrentGridSet.Select.Acl != null) {
            this.WarningMessageBox(GetResource("SelectOrgMsg"));
            return false;
        }

        if (this.CurrentGridSet.Select.getSelectionModel().getSelections().length == 0) {
            this.WarningMessageBox(GetResource("SelectOrgMsg"));
            return false;
        }
        var strNoEmpIDUserList = "";
        var strOverLapUserList = "";

        var agreeId = "";
        var resourceKey = "";
        var isGroup = false;
        switch (dsResult.id) {
            case 'A101':
                agreeId = "emp0_after";
                resourceKey = "AfterDraft";
                break;
            case 'A102':
                agreeId = "r0001_after";
                resourceKey = "AfterRev1";
                break;
            case 'A103':
                agreeId = "r0002_after";
                resourceKey = "AfterRev2";
                break;
            case 'A104':
                agreeId = "r0003_after";
                resourceKey = "AfterRev3";
                break;
            case 'A105':
                agreeId = "r0004_after";
                resourceKey = "AfterRev4";
                break;
            case 'A106':
                agreeId = "r0005_after";
                resourceKey = "AfterRev5";
                break;
            case 'A107':
                agreeId = "r0006_after";
                resourceKey = "AfterRev6";
                break;
            case 'AB101':
                agreeId = "before";
                resourceKey = "BeforeAgree";
                break;
            case 'AF101':
                agreeId = "after";
                resourceKey = "AfterAgree";
                break;

            /*담당협조 추가*/ 
            case 'CA101':
                agreeId = "emp1_after";
                resourceKey = "AfterDraft";
                break;
            case 'CA102':
                agreeId = "r1001_after";
                resourceKey = "AfterRev1";
                break;
            case 'CA103':
                agreeId = "r1002_after";
                resourceKey = "AfterRev2";
                break;
            case 'CA104':
                agreeId = "r1003_after";
                resourceKey = "AfterRev3";
                break;
            case 'CA105':
                agreeId = "r1004_after";
                resourceKey = "AfterRev4";
                break;
            case 'CA106':
                agreeId = "r1005_after";
                resourceKey = "AfterRev5";
                break;
            case 'CA107':
                agreeId = "r1006_after";
                resourceKey = "AfterRev6";
                break;

            // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)     
            /*담당2협조 추가*/ 
            case 'CA201':
                agreeId = "emp2_after";
                resourceKey = "AfterDraft";
                break;
            case 'CA202':
                agreeId = "r2001_after";
                resourceKey = "AfterRev1";
                break;
            case 'CA203':
                agreeId = "r2002_after";
                resourceKey = "AfterRev2";
                break;
            case 'CA204':
                agreeId = "r2003_after";
                resourceKey = "AfterRev3";
                break;
            case 'CA205':
                agreeId = "r2004_after";
                resourceKey = "AfterRev4";
                break;
            case 'CA206':
                agreeId = "r2005_after";
                resourceKey = "AfterRev5";
                break;
            case 'CA207':
                agreeId = "r2006_after";
                resourceKey = "AfterRev6";
                break;
        }

        Ext.each(this.CurrentGridSet.Select.getSelectionModel().getSelections(), function (record, index, allItems) {
            var agree_cnt = dsResult.data.items.length;
            if (dsResult.data.items.length >= 20) {
                var args = new Array();
                args[0] = GetResource("Agree");
                args[1] = "20";
                this.WarningMessageBox(GetResource("ApproverMaxMsg", args));
                return false;
            }

            if (record.data.Type != "GROUP") {
                if (record.data.EmpID.length == 0) {
                    strNoEmpIDUserList += record.data.UserName + ', ';
                    return true;
                }
                // EmpId 유일키
                if (is_overlap)
                    var foundItem = dsResult.find('EmpID', record.data.EmpID);
                else
                    var foundItem = -1;

                if (foundItem == -1) {
                    if ($(AwxXml).find('Histories History Agree[Ref="' + agreeId + '"]')[0] == null) {
                        fn_AddAgree($(AwxXml).find("Histories History[Seq='" + app_seq + "']")[0], agreeId);
                    }

                    if (dsResult.data.items.length >= 20) {
                        var args = new Array();
                        args[0] = GetResource("Agree");
                        args[1] = "20";
                        this.WarningMessageBox(GetResource("ApproverMaxMsg", args));
                        return false;
                    }

                    var idx = dsResult.data.items.length + 1;
                    var agree_task = agreeId + '_' + (idx < 10 ? "0" : "") + idx.toString();

                    var newRecord = new ApproverRecord({
                        EmpID: record.data.EmpID,
                        LoginID: record.data.LoginID,
                        ADDisplayName: record.data.ADDisplayName,
                        UserName: record.data.UserName,
                        Email: record.data.Email,
                        Type: record.data.Type,
                        DeptCode: record.data.DeptCode,
                        DeptName: record.data.DeptName,

                        DutyCode: record.data.DutyCode,
                        DutyName: record.data.DutyName,
                        JobCode: record.data.JobCode,
                        JobName: record.data.JobName,
                        RankCode: record.data.RankCode,
                        RankName: record.data.RankName,
                        CellPhone: record.data.CellPhone,
                        TeamChiefYN: record.data.TeamChiefYN,
                        CompanyCode: record.data.CompanyCode,
                        CompanyName: record.data.CompanyName,
                        SignID: record.data.SignID,
                        ExtensionNumber: record.data.ExtensionNumber,
                        FaxNumber: record.data.FaxNumber,
                        Depth: dsResult.title,
                        TaskId: agree_task,
                        Seq: '',
                        Validation: '',
                        Change: 'true'
                    });
                    dsResult.add(newRecord);
                    //AWX에 결재자 정보 추가
                    fn_AddApprover($(AwxXml).find("Histories History[Seq='" + app_seq + "'] Agree[Ref='" + agreeId + "']")[0], fn_GetUserInfo(newRecord), agree_task, idx);
                }
                else {
                    if (strOverLapUserList == "")
                        strOverLapUserList = record.get("UserName");
                    else
                        strOverLapUserList = strOverLapUserList + ", " + record.get("UserName");
                }
            }
            else {
                isGroup = true;
            }
        }, this);

        if (isGroup) {
            this.WarningMessageBox(GetResource("ApproverNotSetGroupMsg"));
        }

        if (strOverLapUserList != "") {
            var args = new Array();
            args[0] = strOverLapUserList;
            args[1] = GetResource(resourceKey);
            this.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
        }

        //협조 탭 타이틀 변경
        //var agreeId = this.TabAgreeContainerMulti.activeTab.id
        //this.ChangeTabTitle(agreeId, dsResult);
        if (strNoEmpIDUserList.length > 1) {
            this.WarningMessageBox(strNoEmpIDUserList + GetResource("NoInfoAddMsg"));
        }
        this.AllSelectionClear();
    },

    HandlerAddCharge: function (dataGrid, dsResult) {
        this.InitSelectGrid();
        if (this.CurrentGridSet.Select.getSelectionModel().getSelections().length == 0) {
            this.WarningMessageBox(GetResource("SelectOrgMsg"));
            return false;
        }
        var strNoEmpIDUserList = "";
        var cnt = 0;
        var isGroup = false;

        Ext.each(this.CurrentGridSet.Select.getSelectionModel().getSelections(), function (record, index, allItems) {
            if (record.data.Type != "GROUP") {
                if (record.data.EmpID.length == 0) {
                    strNoEmpIDUserList += record.data.UserName + ', ';
                    return true;
                }

                if (dataGrid.getSelectionModel().getSelections().length > 0 && allItems.length > 1) {
                    this.WarningMessageBox(GetResource("OnlyOneSelectMsg"));
                    return false;
                }
                // EmpId 유일키
                if (is_overlap)
                    var foundItem = dsResult.find('EmpID', record.data.EmpID);
                else
                    var foundItem = -1;

                if (foundItem == -1) {
                    // 기본결재라인
                    if (dataGrid.getSelectionModel().getSelections().length > 0) {
                        // Row가 선택되었을때
                        Ext.each(dataGrid.getSelectionModel().getSelections(), function (trecord, tindex, tallItems) {

                            if (trecord.get('Change') == "false") {
                                this.WarningMessageBox(GetResource("ImpossibleChange", trecord.get('Depth')));
                                return;
                            }

                            var history = $(AwxXml).find('Histories History[Seq = ' + trecord.get('Seq') + ']')[0];
                            if (history == null) history = fn_AddHistory($(AwxXml).find('Histories')[0], trecord.get('Seq'));

                            // 현재 member 노드 접근
                            var approver = $(history).find('Approver[TaskID = \'' + trecord.get('TaskId') + '\']')[0];
                            if (approver != null) {
                                var status = approver.getAttribute("Status");

                                if (status != "") {
                                    this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                                    return;
                                }

                                history.removeChild(approver);
                            }

                            if (record.data.DutyName == "") {
                                if (trecord.get("TaskId").indexOf('app') > -1)
                                    record.data.DutyName = GetResource("TeamLeader");
                                else
                                    record.data.DutyName = GetResource("TeamMember");
                            }

                            var newRecord = new ApproverRecord({
                                EmpID: record.data.EmpID,
                                LoginID: record.data.LoginID,
                                ADDisplayName: record.data.ADDisplayName,
                                UserName: record.data.UserName,
                                Email: record.data.Email,
                                Type: record.data.Type,
                                DeptCode: record.data.DeptCode,
                                DeptName: record.data.DeptName,

                                DutyCode: record.data.DutyCode,
                                DutyName: record.data.DutyName,
                                JobCode: record.data.JobCode,
                                JobName: record.data.JobName,
                                RankCode: record.data.RankCode,
                                RankName: record.data.RankName,
                                CellPhone: record.data.CellPhone,
                                TeamChiefYN: record.data.TeamChiefYN,
                                CompanyCode: record.data.CompanyCode,
                                CompanyName: record.data.CompanyName,
                                SignID: record.data.SignID,
                                ExtensionNumber: record.data.ExtensionNumber,
                                FaxNumber: record.data.FaxNumber,
                                Depth: trecord.get("Depth"),
                                TaskId: trecord.get("TaskId"),
                                Seq: trecord.get("Seq"),
                                Validation: trecord.get("Validation"),
                                Change: trecord.get("Change")
                            });

                            var idx = dsResult.indexOf(trecord);
                            dsResult.remove(trecord);
                            dsResult.insert(idx, newRecord);

                            var ord = dsResult.data.length - idx;
                            //AWX에 결재자 정보 추가
                            fn_AddApprover($(AwxXml).find('Histories History[Seq=' + trecord.get('Seq') + ']')[0], fn_GetUserInfo(record), trecord.get('TaskId'), ord);
                        }, this);
                    }
                    else {
                        // Row가 선택되지 않았을 경우 빈 Row에 채운다
                        if (cnt == dsResult.data.items.length) return;
                        for (var j = dsResult.data.items.length - 1; j > -1; j--) {

                            if (dsResult.data.items[j].get('Change') != "false") {
                                if (dsResult.data.items[j].data.EmpID == undefined || dsResult.data.items[j].data.EmpID == "") {
                                    var history = $(AwxXml).find('Histories History[Seq = ' + dsResult.data.items[j].get('Seq') + ']')[0];
                                    if (history == null) history = fn_AddHistory($(AwxXml).find('Histories')[0], dsResult.data.items[j].get('Seq'));

                                    var approver = $(history).find('Approver[TaskID = \'' + dsResult.data.items[j].get('TaskId') + '\']')[0];

                                    if (approver != null) {
                                        var status = approver.getAttribute("Status");

                                        if (status != "") {
                                            this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                                            return;
                                        }
                                        history.removeChild(approver);
                                    }

                                    if (record.data.DutyName == "") {
                                        if (dsResult.data.items[j].data.TaskId.indexOf('app') > -1)
                                            record.data.DutyName = GetResource("TeamLeader");
                                        else
                                            record.data.DutyName = GetResource("TeamMember");
                                    }
                                    var newRecord = new ApproverRecord({
                                        EmpID: record.data.EmpID,
                                        LoginID: record.data.LoginID,
                                        ADDisplayName: record.data.ADDisplayName,
                                        UserName: record.data.UserName,
                                        Email: record.data.Email,
                                        Type: record.data.Type,
                                        DeptCode: record.data.DeptCode,
                                        DeptName: record.data.DeptName,

                                        DutyCode: record.data.DutyCode,
                                        DutyName: record.data.DutyName,
                                        JobCode: record.data.JobCode,
                                        JobName: record.data.JobName,
                                        RankCode: record.data.RankCode,
                                        RankName: record.data.RankName,
                                        CellPhone: record.data.CellPhone,
                                        TeamChiefYN: record.data.TeamChiefYN,
                                        CompanyCode: record.data.CompanyCode,
                                        CompanyName: record.data.CompanyName,
                                        SignID: record.data.SignID,
                                        ExtensionNumber: record.data.ExtensionNumber,
                                        FaxNumber: record.data.FaxNumber,
                                        Depth: dsResult.data.items[j].data.Depth,
                                        TaskId: dsResult.data.items[j].data.TaskId,
                                        Seq: dsResult.data.items[j].data.Seq,
                                        Validation: dsResult.data.items[j].data.Validation,
                                        Change: dsResult.data.items[j].data.Change
                                    });
                                    dsResult.remove(dsResult.data.items[j]);
                                    dsResult.insert(j, newRecord);
                                    cnt++;

                                    var ord = dsResult.data.items.length - j;
                                    //AWX에 결재자 정보 추가
                                    fn_AddApprover($(AwxXml).find('Histories History[Seq=' + dsResult.data.items[j].get('Seq') + ']')[0], fn_GetUserInfo(record), dsResult.data.items[j].get('TaskId'), ord);
                                    break;
                                }
                            }
                        }
                    }
                }
                else {
                    var args = new Array();
                    args[0] = record.get("UserName");
                    args[1] = dsResult.data.items[foundItem].get("Depth");
                    this.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
                }
            }
            else {
                isGroup = true;
            }
        }, this);

        if (isGroup) {
            this.WarningMessageBox(GetResource("ApproverNotSetGroupMsg"));
        }

        if (strNoEmpIDUserList.length > 1) {
            this.WarningMessageBox(strNoEmpIDUserList + GetResource("NoInfoAddMsg"));
        }
        this.AllSelectionClear();
    },

    HandlerRemoveApprover: function (dataGrid, dsResult) {

        if (is_agree_multi) {
            Ext.each(dataGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
                //기본결재일경우
                if (record.get("EmpID") != undefined && record.get("EmpID") != "") {
                    var history = $(AwxXml).find('Histories History[Seq = ' + app_seq + ']')[0];
                    if (history == null) return;
                    //대리작성인 경우 기안자 변경 불가.
                    if (record.get('TaskId') == "emp0") {
                        if ($(AwxXml).find('Fields')[0] != null) {
                            if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null) {
                                if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y") {
                                    this.WarningMessageBox(GetResource("ApproverDrafterNoChangeMsg"));
                                    return;
                                }
                            }
                        }
                    }

                    // 현재 member 노드 접근
                    var approver = $(history).find('Approver[TaskID = \'' + record.get('TaskId') + '\']')[0];
                    if (approver != null) {
                        var status = approver.getAttribute("Status");

                        if (status != "") {
                            this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                            return;
                        }

                        if (this.CheckUserId) {
                            if (approver.getAttribute("LoginID") == this.CurrentUser && approver.getAttribute("TaskID") == this.CurrentUserTaskID) {
                                this.WarningMessageBox(GetResource("AppointApprovalCurrentApprover"));
                                //return;
                            }
                        }

                        if (record.get('Change') == "false") {
                            this.WarningMessageBox(GetResource("ImpossibleChange", record.get('Depth')));
                            return;
                        }
                        //AWX에 결재자 정보 삭제
                        history.removeChild(approver);
                    }

                    var newRecord = new ApproverRecord({
                        Depth: record.data.Depth,
                        TaskId: record.data.TaskId,
                        Seq: record.data.Seq,
                        Validation: record.data.Validation,
                        Change: record.data.Change
                    });

                    var isAgreeMembers = false;

                    for (var i = 0; i < this.TabAgreeContainerMulti.items.length; i++) {
                        var cnt = i + 1;

                        if (this.TabAgreeContainerMulti.items.items[i].id == record.get('TaskId') + "_" + ((app_seq == 1) ? "C" : (app_seq == 2) ? "C2" : "") + "A" + (app_seq == 2) ? "2" : "1" + "0" + cnt) {
                            //if (this.TabAgreeContainerMulti.items.items[i].id == record.get('TaskId') + "_A10" + cnt) {
                            if (this.TabAgreeContainerMulti.items.items[i].store.getCount() > 0) {
                                isAgreeMembers = true;
                                break;
                            }
                        }
                    }

                    if (isAgreeMembers) {
                        this.ConfirmMessageBox(GetResource("AgreeRemoveConfirmMsg"), function (buttonId, text) {
                            if (buttonId == "no") return;
                            var idx = dsResult.indexOf(record);
                            dsResult.remove(record);
                            dsResult.insert(idx, newRecord);

                            //결재자(검토자)를 제거하면 다음 협조자 목록도 Clear함.
                            this.RemoveAgreeNode(record.get('TaskId'))
                            // 단계별 협조자 Display
                            this.EnableAgreeTab(record.get('TaskId'), false);
                        });
                    }
                    else {
                        var idx = dsResult.indexOf(record);
                        dsResult.remove(record);
                        dsResult.insert(idx, newRecord);

                        //결재자(검토자)를 제거하면 다음 협조자 목록도 Clear함.
                        this.RemoveAgreeNode(record.get('TaskId'))
                        // 단계별 협조자 Display
                        this.EnableAgreeTab(record.get('TaskId'), false);
                    }
                }
                // Activate Tab선택
                this.ActivateAgreeTab();

            }, this);
        }
        else {
            Ext.each(dataGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
                //기본결재일경우
                if (record.get("EmpID") != undefined && record.get("EmpID") != "") {
                    var history = $(AwxXml).find('Histories History[Seq = ' + app_seq + ']')[0];
                    if (history == null) return;
                    //대리작성인 경우 기안자 변경 불가.
                    if (record.get('TaskId') == "emp0") {
                        if ($(AwxXml).find('Fields')[0] != null) {
                            if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null) {
                                if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y") {
                                    this.WarningMessageBox(GetResource("ApproverDrafterNoChangeMsg"));
                                    return;
                                }
                            }
                        }
                    }

                    // 현재 member 노드 접근
                    var approver = $(history).find('Approver[TaskID = \'' + record.get('TaskId') + '\']')[0];
                    if (approver != null) {
                        var status = approver.getAttribute("Status");

                        if (status != "") {
                            this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                            return;
                        }

                        if (this.CheckUserId) {
                            if (approver.getAttribute("LoginID") == this.CurrentUser && approver.getAttribute("TaskID") == this.CurrentUserTaskID) {
                                this.WarningMessageBox(GetResource("AppointApprovalCurrentApprover"));
                                //return;
                            }
                        }

                        if (record.get('Change') == "false") {
                            this.WarningMessageBox(GetResource("ImpossibleChange", record.get('Depth')));
                            return;
                        }
                        //AWX에 결재자 정보 삭제
                        history.removeChild(approver);
                    }

                    var newRecord = new ApproverRecord({
                        Depth: record.data.Depth,
                        TaskId: record.data.TaskId,
                        Seq: record.data.Seq,
                        Validation: record.data.Validation,
                        Change: record.data.Change
                    });

                    var idx = dsResult.indexOf(record);
                    dsResult.remove(record);
                    dsResult.insert(idx, newRecord);
                }
            }, this);
        }
        this.AllSelectionClear();
    },

    HandlerRemoveAgree: function (dataGrid, dsResult) {

        var agreeId = "";

        switch (dsResult.id) {
            case 'A101':
                agreeId = "emp0_after";
                break;
            case 'A102':
                agreeId = "r0001_after";
                break;
            case 'A103':
                agreeId = "r0002_after";
                break;
            case 'A104':
                agreeId = "r0003_after";
                break;
            case 'A105':
                agreeId = "r0004_after";
                break;
            case 'A106':
                agreeId = "r0005_after";
                break;
            case 'A107':
                agreeId = "r0006_after";
                break;
            case 'AB101':
                agreeId = "before";
                break;
            case 'AF101':
                agreeId = "after";
                break;

            /*담당협조 추가*/ 
            case 'CA101':
                agreeId = "emp1_after";
                break;
            case 'CA102':
                agreeId = "r1001_after";
                break;
            case 'CA103':
                agreeId = "r1002_after";
                break;
            case 'CA104':
                agreeId = "r1003_after";
                break;
            case 'CA105':
                agreeId = "r1004_after";
                break;
            case 'CA106':
                agreeId = "r1005_after";
                break;
            case 'CA107':
                agreeId = "r1006_after";
                break;

            // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)     
            case 'CA201':
                agreeId = "emp2_after";
                break;
            case 'CA202':
                agreeId = "r2001_after";
                break;
            case 'CA203':
                agreeId = "r2002_after";
                break;
            case 'CA204':
                agreeId = "r2003_after";
                break;
            case 'CA205':
                agreeId = "r2004_after";
                break;
            case 'CA206':
                agreeId = "r2005_after";
                break;
            case 'CA207':
                agreeId = "r2006_after";
                break;
        }

        // 협조노드
        var agrees = $(AwxXml).find("Histories History[Seq='" + app_seq + "'] Agree[Ref='" + agreeId + "']")[0];

        if (agrees != null) {
            Ext.each(dataGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
                var approver = $(agrees).find('Approver[TaskID = \'' + record.get('TaskId') + '\']')[0];

                if (approver != null) {
                    var status = approver.getAttribute("State");

                    if (status == "C") {
                        this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                        return;
                    }
                    //AWX에 결재자 정보 삭제
                    agrees.removeChild(approver);
                    dsResult.remove(record);
                }
            }, this);

            //순차적으로 TaskID부여
            var agree_cnt = 0;
            var agree_task;

            for (var j = 0; j < agrees.childNodes.length; j++) {
                agree_cnt++;
                agree_task = agreeId + '_' + (agree_cnt < 10 ? "0" : "") + agree_cnt.toString();
                agrees.childNodes[j].setAttribute("TaskID", agree_task);
                agrees.childNodes[j].setAttribute("Order", j + 1);
                dsResult.data.items[j].set("TaskId", agree_task);
                dsResult.data.items[j].commit();
            }
        }
        this.AllSelectionClear();
    },

    HandlerRemoveCharge: function (dataGrid, dsResult) {
        Ext.each(dataGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
            if (record.get('Change') == "false") {
                this.WarningMessageBox(GetResource("ImpossibleChange", record.get('Depth')));
                return;
            }
            //기본결재일경우
            if (record.get("EmpID") != undefined && record.get("EmpID") != "") {
                var history = $(AwxXml).find('Histories History[Seq = ' + record.get("Seq") + ']')[0];
                if (history == null) return;

                // 현재 member 노드 접근
                var approver = $(history).find('Approver[TaskID = \'' + record.get('TaskId') + '\']')[0];
                if (approver != null) {
                    var status = approver.getAttribute("Status");

                    if (status != "") {
                        this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                        return;
                    }
                    //AWX에 결재자 정보 삭제
                    history.removeChild(approver);
                }

                var newRecord = new ApproverRecord({
                    Depth: record.data.Depth,
                    TaskId: record.data.TaskId,
                    Seq: record.data.Seq,
                    Validation: record.data.Validation,
                    Change: record.data.Change
                });

                var idx = dsResult.indexOf(record);
                dsResult.remove(record);
                dsResult.insert(idx, newRecord);
            }
        }, this);

        this.AllSelectionClear();
    },

    HandlerUpDownApprover: function (dataGrid, dsResult, strType) {
        if (dataGrid.getSelectionModel().getSelections().length > 1) {
            this.WarningMessageBox(GetResource("OnlyOneSelectMsg"));
            this.AllSelectionClear();
            return;
        }

        var history = $(AwxXml).find('Histories History[Seq = ' + app_seq + ']')[0];
        if (history == null) return;

        Ext.each(dataGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
            var idx = dsResult.indexOf(record);
            var currRow = null;
            var newRow = null;
            var newidx = null;

            if (strType.toLowerCase() == 'up') {
                if (idx == 0) return;
                newRow = dsResult.data.items[idx - 1];
                newidx = idx - 1;
            }
            else {
                if (idx == dsResult.data.items.length) return;
                newRow = dsResult.data.items[idx + 1];
                newidx = idx + 1;
            }

            currRow = dsResult.data.items[idx];

            if (currRow == null || newRow == null) return;

            if (currRow.get('Change') == "false" || newRow.get('Change') == "false") return;

            //대리작성인 경우 기안자 변경 불가.
            if (currRow.data.TaskId == "emp0") {
                if ($(AwxXml).find('Fields')[0] != null) {
                    if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null) {
                        if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y") {
                            //대리작성된 문서이기 때문에 기안자를 변경할 수 없습니다.
                            this.WarningMessageBox(GetResource("ApproverDrafterNoChangeMsg"));
                            return;
                        }
                    }
                }
            }

            var approvers = $(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0];

            if (approvers != null) {
                var new_approver = $(approvers).find('Approver[TaskID = \'' + newRow.data.TaskId + '\']')[0];
                var curr_approver = $(approvers).find('Approver[TaskID = \'' + currRow.data.TaskId + '\']')[0];
            }

            if (curr_approver == null) return;

            var status = curr_approver.getAttribute("Status");

            if (status != "") {
                //결재가 완료된 사용자는 변경이 불가능합니다.
                this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                return;
            }

            if (this.CheckUserId) {
                if (curr_approver.getAttribute("LoginID") == this.CurrentUser && curr_approver.getAttribute("TaskID") == this.CurrentUserTaskID) {
                    this.WarningMessageBox(GetResource("AppointApprovalCurrentApprover"));
                    //return;
                }
            }

            if (new_approver != null) {
                var status = new_approver.getAttribute("Status");

                if (status != "") {
                    //결재가 완료된 사용자는 변경이 불가능합니다.
                    this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                    return;
                }

                if (this.CheckUserId) {
                    if (new_approver.getAttribute("LoginID") == this.CurrentUser && new_approver.getAttribute("TaskID") == this.CurrentUserTaskID) {
                        this.WarningMessageBox(GetResource("AppointApprovalCurrentApprover"));
                        //return;
                    }
                }
                new_approver.setAttribute("TaskID", currRow.data.TaskId);
                new_approver.setAttribute("Order", 8 - idx);
            }

            curr_approver.setAttribute("TaskID", newRow.data.TaskId);
            curr_approver.setAttribute("Order", 8 - newidx);

            var currRecord = new ApproverRecord({
                EmpID: currRow.data.EmpID,
                LoginID: currRow.data.LoginID,
                ADDisplayName: currRow.data.ADDisplayName,
                UserName: currRow.data.UserName,
                Email: currRow.data.Email,
                Type: currRow.data.Type,
                DeptCode: currRow.data.DeptCode,
                DeptName: currRow.data.DeptName,

                DutyCode: currRow.data.DutyCode,
                DutyName: currRow.data.DutyName,
                JobCode: currRow.data.JobCode,
                JobName: currRow.data.JobName,
                RankCode: currRow.data.RankCode,
                RankName: currRow.data.RankName,
                CellPhone: currRow.data.CellPhone,
                TeamChiefYN: currRow.data.TeamChiefYN,
                CompanyCode: currRow.data.CompanyCode,
                CompanyName: currRow.data.CompanyName,
                SignID: currRow.data.SignID,
                ExtensionNumber: currRow.data.ExtensionNumber,
                FaxNumber: currRow.data.FaxNumber,
                Depth: newRow.data.Depth,
                TaskId: newRow.data.TaskId,
                Seq: newRow.data.Seq,
                Validation: newRow.data.Validation,
                Change: newRow.data.Change
            });

            var newRecord = new ApproverRecord({
                EmpID: newRow.data.EmpID,
                LoginID: newRow.data.LoginID,
                ADDisplayName: newRow.data.ADDisplayName,
                UserName: newRow.data.UserName,
                Email: newRow.data.Email,
                Type: newRow.data.Type,
                DeptCode: newRow.data.DeptCode,
                DeptName: newRow.data.DeptName,
                DutyCode: newRow.data.DutyCode,
                DutyName: newRow.data.DutyName,
                JobCode: newRow.data.JobCode,
                JobName: newRow.data.JobName,
                RankCode: newRow.data.RankCode,
                RankName: newRow.data.RankName,
                CellPhone: newRow.data.CellPhone,
                TeamChiefYN: newRow.data.TeamChiefYN,
                CompanyCode: newRow.data.CompanyCode,
                CompanyName: newRow.data.CompanyName,
                SignID: newRow.data.SignID,
                ExtensionNumber: newRow.data.ExtensionNumber,
                FaxNumber: newRow.data.FaxNumber,
                Depth: currRow.data.Depth,
                TaskId: currRow.data.TaskId,
                Seq: currRow.data.Seq,
                Validation: currRow.data.Validation,
                Change: currRow.data.Change
            });

            dsResult.remove(currRow);
            dsResult.insert(idx, newRecord);

            dsResult.remove(newRow);
            dsResult.insert(newidx, currRecord);

            if (is_agree_multi) {
                // 이동시 하나라도 없는 공간으로 결재(검토)자를 이동하면 협조자를 모드 Clear 한다.
                if (currRow.data.EmpID == "" || currRow.data.EmpID == undefined) {
                    if (newRow.data.EmpID != "" && newRow.data.EmpID != undefined) {
                        // 단계별 협조자 Display
                        this.EnableAgreeTab(currRow.data.TaskId, true);
                    }
                    //결재자(검토자)를 제거하면 다음 협조자 목록도 Clear함.
                    this.RemoveAgreeNode(newRow.data.TaskId)
                    // 단계별 협조자 Display
                    this.EnableAgreeTab(newRow.data.TaskId, false);
                }
                else {
                    if (newRow.data.EmpID == "" || newRow.data.EmpID == undefined) {
                        //결재자(검토자)를 제거하면 다음 협조자 목록도 Clear함.
                        this.RemoveAgreeNode(currRow.data.TaskId)
                        // 단계별 협조자 Display
                        this.EnableAgreeTab(currRow.data.TaskId, false);
                    }
                    // 단계별 협조자 Display
                    this.EnableAgreeTab(newRow.data.TaskId, true);
                }
                // Activate Tab선택
                this.ActivateAgreeTab();
            }
            // 선택된 Row를 바꿈
            if (strType.toLowerCase() == 'up')
                dataGrid.getSelectionModel().selectPrevious();
            else
                dataGrid.getSelectionModel().selectNext();

        }, this);
    },

    HandlerUpDownAgree: function (dataGrid, dsResult, strType) {
        if (dataGrid.getSelectionModel().getSelections().length > 1) {
            this.WarningMessageBox(GetResource("OnlyOneSelectMsg"));
            return;
        }
        var history = $(AwxXml).find('Histories History[Seq = ' + app_seq + ']')[0];
        if (history == null) return;

        var agreeId = "";

        switch (dsResult.id) {
            case 'A101':
                agreeId = "emp0_after";
                break;
            case 'A102':
                agreeId = "r0001_after";
                break;
            case 'A103':
                agreeId = "r0002_after";
                break;
            case 'A104':
                agreeId = "r0003_after";
                break;
            case 'A105':
                agreeId = "r0004_after";
                break;
            case 'A106':
                agreeId = "r0005_after";
                break;
            case 'A107':
                agreeId = "r0006_after";
                break;
            case 'AB101':
                agreeId = "before";
                break;
            case 'AF101':
                agreeId = "after";
                break;

            /* 담당협조 추가 */ 
            case 'CA101':
                agreeId = "emp1_after";
                break;
            case 'CA102':
                agreeId = "r1001_after";
                break;
            case 'CA103':
                agreeId = "r1002_after";
                break;
            case 'CA104':
                agreeId = "r1003_after";
                break;
            case 'CA105':
                agreeId = "r1004_after";
                break;
            case 'CA106':
                agreeId = "r1005_after";
                break;
            case 'CA107':
                agreeId = "r1006_after";
                break;

            // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)     
            case 'CA201':
                agreeId = "emp2_after";
                break;
            case 'CA202':
                agreeId = "r2001_after";
                break;
            case 'CA203':
                agreeId = "r2002_after";
                break;
            case 'CA204':
                agreeId = "r2003_after";
                break;
            case 'CA205':
                agreeId = "r2004_after";
                break;
            case 'CA206':
                agreeId = "r2005_after";
                break;
            case 'CA207':
                agreeId = "r2006_after";
                break;
        }

        Ext.each(dataGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
            var idx = dsResult.indexOf(record);
            var currRow = null;
            var newRow = null;
            var newidx = null;

            if (strType.toLowerCase() == 'up') {
                if (idx == 0) return;
                newRow = dsResult.data.items[idx - 1];
                newidx = idx - 1;
            }
            else {
                if (idx == dsResult.data.items.length) return;
                newRow = dsResult.data.items[idx + 1];
                newidx = idx + 1;
            }

            currRow = dsResult.data.items[idx];

            if (currRow == null || newRow == null) return;

            var currRecord = new ApproverRecord({
                EmpID: currRow.data.EmpID,
                LoginID: currRow.data.LoginID,
                ADDisplayName: currRow.data.ADDisplayName,
                UserName: currRow.data.UserName,
                Email: currRow.data.Email,
                Type: currRow.data.Type,
                DeptCode: currRow.data.DeptCode,
                DeptName: currRow.data.DeptName,

                DutyCode: currRow.data.DutyCode,
                DutyName: currRow.data.DutyName,
                JobCode: currRow.data.JobCode,
                JobName: currRow.data.JobName,
                RankCode: currRow.data.RankCode,
                RankName: currRow.data.RankName,
                CellPhone: currRow.data.CellPhone,
                TeamChiefYN: currRow.data.TeamChiefYN,
                CompanyCode: currRow.data.CompanyCode,
                CompanyName: currRow.data.CompanyName,
                SignID: currRow.data.SignID,
                ExtensionNumber: currRow.data.ExtensionNumber,
                FaxNumber: currRow.data.FaxNumber,
                Depth: newRow.data.Depth,
                TaskId: newRow.data.TaskId,
                Seq: newRow.data.Seq,
                Validation: newRow.data.Validation,
                Change: newRow.data.Change
            });

            var newRecord = new ApproverRecord({
                EmpID: newRow.data.EmpID,
                LoginID: newRow.data.LoginID,
                ADDisplayName: newRow.data.ADDisplayName,
                UserName: newRow.data.UserName,
                Email: newRow.data.Email,
                Type: newRow.data.Type,
                DeptCode: newRow.data.DeptCode,
                DeptName: newRow.data.DeptName,

                DutyCode: newRow.data.DutyCode,
                DutyName: newRow.data.DutyName,
                JobCode: newRow.data.JobCode,
                JobName: newRow.data.JobName,
                RankCode: newRow.data.RankCode,
                RankName: newRow.data.RankName,
                CellPhone: newRow.data.CellPhone,
                TeamChiefYN: newRow.data.TeamChiefYN,
                CompanyCode: newRow.data.CompanyCode,
                CompanyName: newRow.data.CompanyName,
                SignID: newRow.data.SignID,
                ExtensionNumber: newRow.data.ExtensionNumber,
                FaxNumber: newRow.data.FaxNumber,
                Depth: currRow.data.Depth,
                TaskId: currRow.data.TaskId,
                Seq: currRow.data.Seq,
                Validation: currRow.data.Validation,
                Change: currRow.data.Change
            });

            dsResult.remove(currRow);
            dsResult.insert(idx, newRecord);
            dsResult.remove(newRow);
            dsResult.insert(newidx, currRecord);

            //AWX에 결재 정보 수정
            var agrees = $(AwxXml).find("Histories History[Seq='" + app_seq + "'] Agree[Ref='" + agreeId + "']")[0];

            if (agrees != null) {
                var curr_agree = $(agrees).find('Approver[TaskID = \'' + currRow.data.TaskId + '\']')[0];

                // 데이터 이동
                var new_agree = curr_agree.previousSibling;
                curr_agree = agrees.removeChild(curr_agree);
                curr_agree = agrees.insertBefore(curr_agree, new_agree);

                //순차적으로 TaskID부여
                var agree_cnt = 0;
                var agree_task;

                for (var i = 0; i < agrees.childNodes.length; i++) {
                    agree_cnt++;
                    agree_task = agreeId + '_' + (agree_cnt < 10 ? "0" : "") + agree_cnt.toString();
                    agrees.childNodes[i].setAttribute("TaskID", agree_task);
                    agrees.childNodes[i].setAttribute("Order", i + 1);
                    dsResult.data.items[i].set("TaskId", agree_task);
                    dsResult.data.items[i].commit();
                }
            }

            // 선택된 Row를 바꿈
            if (strType.toLowerCase() == 'up')
                dataGrid.getSelectionModel().selectPrevious();
            else
                dataGrid.getSelectionModel().selectNext();

        }, this);
    },

    HandlerUpDownCharge: function (dataGrid, dsResult, strType) {
        if (dataGrid.getSelectionModel().getSelections().length > 1) {
            this.WarningMessageBox(GetResource("OnlyOneSelectMsg"));
            this.AllSelectionClear();
            return;
        }

        Ext.each(dataGrid.getSelectionModel().getSelections(), function (record, index, allItems) {

            var history = $(AwxXml).find('Histories History[Seq = ' + record.get("Seq") + ']')[0];
            if (history == null) return;

            var idx = dsResult.indexOf(record);
            var currRow = null;
            var newRow = null;
            var newidx = null;

            if (strType.toLowerCase() == 'up') {
                if (idx == 0) return;
                newRow = dsResult.data.items[idx - 1];
                newidx = idx - 1;
            }
            else {
                if (idx == dsResult.data.items.length) return;
                newRow = dsResult.data.items[idx + 1];
                newidx = idx + 1;
            }

            currRow = dsResult.data.items[idx];

            if (currRow == null || newRow == null) return;

            var approvers = $(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0];

            var new_approver = $(approvers).find('Approver[TaskID = \'' + newRow.data.TaskId + '\']')[0];
            var curr_approver = $(approvers).find('Approver[TaskID = \'' + currRow.data.TaskId + '\']')[0];

            if (curr_approver == null) return;

            if (currRow.get('Change') == "false") {
                this.WarningMessageBox(GetResource("ImpossibleChange", currRow.get('Depth')));
                return;
            }

            if (newRow.get('Change') == "false") {
                this.WarningMessageBox(GetResource("ImpossibleChange", newRow.get('Depth')));
                return;
            }

            var status = curr_approver.getAttribute("Status");

            if (status != "") {
                //결재가 완료된 사용자는 변경이 불가능합니다.
                this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                return;
            }

            if (new_approver != null) {
                var status = new_approver.getAttribute("Status");

                if (status != "") {
                    //결재가 완료된 사용자는 변경이 불가능합니다.
                    this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                    return;
                }
                new_approver.setAttribute("TaskID", currRow.data.TaskId);
            }

            curr_approver.setAttribute("TaskID", newRow.data.TaskId);

            var currRecord = new ApproverRecord({
                EmpID: currRow.data.EmpID,
                LoginID: currRow.data.LoginID,
                ADDisplayName: currRow.data.ADDisplayName,
                UserName: currRow.data.UserName,
                Email: currRow.data.Email,
                Type: currRow.data.Type,
                DeptCode: currRow.data.DeptCode,
                DeptName: currRow.data.DeptName,

                DutyCode: currRow.data.DutyCode,
                DutyName: currRow.data.DutyName,
                JobCode: currRow.data.JobCode,
                JobName: currRow.data.JobName,
                RankCode: currRow.data.RankCode,
                RankName: currRow.data.RankName,
                CellPhone: currRow.data.CellPhone,
                TeamChiefYN: currRow.data.TeamChiefYN,
                CompanyCode: currRow.data.CompanyCode,
                CompanyName: currRow.data.CompanyName,
                SignID: currRow.data.SignID,
                ExtensionNumber: currRow.data.ExtensionNumber,
                FaxNumber: currRow.data.FaxNumber,
                Depth: newRow.data.Depth,
                TaskId: newRow.data.TaskId,
                Seq: newRow.data.Seq,
                Validation: newRow.data.Validation,
                Change: newRow.data.Change
            });

            var newRecord = new ApproverRecord({
                EmpID: newRow.data.EmpID,
                LoginID: newRow.data.LoginID,
                ADDisplayName: newRow.data.ADDisplayName,
                UserName: newRow.data.UserName,
                Email: newRow.data.Email,
                Type: newRow.data.Type,
                DeptCode: newRow.data.DeptCode,
                DeptName: newRow.data.DeptName,

                DutyCode: newRow.data.DutyCode,
                DutyName: newRow.data.DutyName,
                JobCode: newRow.data.JobCode,
                JobName: newRow.data.JobName,
                RankCode: newRow.data.RankCode,
                RankName: newRow.data.RankName,
                CellPhone: newRow.data.CellPhone,
                TeamChiefYN: newRow.data.TeamChiefYN,
                CompanyCode: newRow.data.CompanyCode,
                CompanyName: newRow.data.CompanyName,
                SignID: newRow.data.SignID,
                ExtensionNumber: newRow.data.ExtensionNumber,
                FaxNumber: newRow.data.FaxNumber,
                Depth: currRow.data.Depth,
                TaskId: currRow.data.TaskId,
                Seq: currRow.data.Seq,
                Validation: currRow.data.Validation,
                Change: currRow.data.Change
            });

            dsResult.remove(currRow);
            dsResult.insert(idx, newRecord);

            dsResult.remove(newRow);
            dsResult.insert(newidx, currRecord);

            // 선택된 Row를 바꿈
            if (strType.toLowerCase() == 'up')
                dataGrid.getSelectionModel().selectPrevious();
            else
                dataGrid.getSelectionModel().selectNext();

        }, this);
    },

    HandlerRemoveAllApprover: function (dataGrid, dsResult) {

        var mask = new Ext.LoadMask(dataGrid.getView().el, { msg: GetResource("WaitMsg") });
        mask.show();

        var history = $(AwxXml).find('Histories History[Seq = ' + app_seq + ']')[0];
        if (history == null) return;

        if (is_agree_multi) {
            var isAgreeMembers = false;

            for (var i = 0; i < this.TabAgreeContainerMulti.items.length; i++) {
                if (this.TabAgreeContainerMulti.items.items[i].store.getCount() > 0) {
                    isAgreeMembers = true;
                    break;
                }
            }

            if (isAgreeMembers) {
                this.ConfirmMessageBox(GetResource("AgreeRemoveConfirmMsg"), function (buttonId, text) {
                    if (buttonId == "no") return;
                    for (var i = 0; i < dsResult.data.items.length; i++) {
                        if (dsResult.data.items[i].get("EmpID") != undefined && dsResult.data.items[i].get("EmpID") != "") {
                            //대리작성인 경우 기안자 변경 불가.
                            if (dsResult.data.items[i].get('TaskId') == "emp0") {
                                if ($(AwxXml).find('Fields')[0] != null) {
                                    if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null) {
                                        if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y") {
                                            this.WarningMessageBox(GetResource("ApproverDrafterNoChangeMsg"));
                                        }
                                    }
                                }
                            }

                            if (dsResult.data.items[i].get("Change") != "false") {
                                // 현재 member 노드 접근
                                var approver = $(history).find('Approver[TaskID = \'' + dsResult.data.items[i].get('TaskId') + '\']')[0];
                                if (approver != null) {
                                    var status = approver.getAttribute("Status");

                                    if (status != "") {
                                        this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                                    }
                                    else {
                                        if (this.CheckUserId) {
                                            if (approver.getAttribute("LoginID") == this.CurrentUser && approver.getAttribute("TaskID") == this.CurrentUserTaskID) {
                                                this.WarningMessageBox(GetResource("AppointApprovalCurrentApprover"));
                                            }
                                            else {
                                                var newRecord = new ApproverRecord({
                                                    Depth: dsResult.data.items[i].get('Depth'),
                                                    TaskId: dsResult.data.items[i].get('TaskId'),
                                                    Seq: dsResult.data.items[i].get('Seq'),
                                                    Validation: dsResult.data.items[i].get('Validation'),
                                                    Change: dsResult.data.items[i].get('Change')
                                                });

                                                var idx = dsResult.indexOf(dsResult.data.items[i]);
                                                dsResult.remove(dsResult.data.items[i]);
                                                dsResult.insert(idx, newRecord);

                                                history.removeChild(approver);

                                                //결재자(검토자)를 제거하면 다음 협조자 목록도 Clear함.
                                                this.RemoveAgreeNode(dsResult.data.items[i].get('TaskId'))
                                                // 단계별 협조자 Display
                                                this.EnableAgreeTab(dsResult.data.items[i].get('TaskId'), false);
                                                // Activate Tab선택
                                                this.ActivateAgreeTab();
                                            }
                                        }
                                        else {
                                            var newRecord = new ApproverRecord({
                                                Depth: dsResult.data.items[i].get('Depth'),
                                                TaskId: dsResult.data.items[i].get('TaskId'),
                                                Seq: dsResult.data.items[i].get('Seq'),
                                                Validation: dsResult.data.items[i].get('Validation'),
                                                Change: dsResult.data.items[i].get('Change')
                                            });

                                            var idx = dsResult.indexOf(dsResult.data.items[i]);
                                            dsResult.remove(dsResult.data.items[i]);
                                            dsResult.insert(idx, newRecord);

                                            history.removeChild(approver);

                                            //결재자(검토자)를 제거하면 다음 협조자 목록도 Clear함.
                                            this.RemoveAgreeNode(dsResult.data.items[i].get('TaskId'))
                                            // 단계별 협조자 Display
                                            this.EnableAgreeTab(dsResult.data.items[i].get('TaskId'), false);
                                            // Activate Tab선택
                                            this.ActivateAgreeTab();
                                        }
                                    }
                                }
                            }
                        }
                    }
                });
            }
            else {
                for (var i = 0; i < dsResult.data.items.length; i++) {
                    if (dsResult.data.items[i].get("EmpID") != undefined && dsResult.data.items[i].get("EmpID") != "") {
                        //대리작성인 경우 기안자 변경 불가.
                        if (dsResult.data.items[i].get('TaskId') == "emp0") {
                            if ($(AwxXml).find('Fields')[0] != null) {
                                if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null) {
                                    if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y") {
                                        this.WarningMessageBox(GetResource("ApproverDrafterNoChangeMsg"));
                                    }
                                }
                            }
                        }

                        if (dsResult.data.items[i].get("Change") != "false") {
                            // 현재 member 노드 접근
                            var approver = $(history).find('Approver[TaskID = \'' + dsResult.data.items[i].get('TaskId') + '\']')[0];
                            if (approver != null) {
                                var status = approver.getAttribute("Status");

                                if (status != "") {
                                    this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                                }
                                else {
                                    if (this.CheckUserId) {
                                        if (approver.getAttribute("LoginID") == this.CurrentUser && approver.getAttribute("TaskID") == this.CurrentUserTaskID) {
                                            this.WarningMessageBox(GetResource("AppointApprovalCurrentApprover"));
                                        }
                                        else {
                                            var newRecord = new ApproverRecord({
                                                Depth: dsResult.data.items[i].get('Depth'),
                                                TaskId: dsResult.data.items[i].get('TaskId'),
                                                Seq: dsResult.data.items[i].get('Seq'),
                                                Validation: dsResult.data.items[i].get('Validation'),
                                                Change: dsResult.data.items[i].get('Change')
                                            });

                                            var idx = dsResult.indexOf(dsResult.data.items[i]);
                                            dsResult.remove(dsResult.data.items[i]);
                                            dsResult.insert(idx, newRecord);

                                            history.removeChild(approver);

                                            //결재자(검토자)를 제거하면 다음 협조자 목록도 Clear함.
                                            this.RemoveAgreeNode(dsResult.data.items[i].get('TaskId'))
                                            // 단계별 협조자 Display
                                            this.EnableAgreeTab(dsResult.data.items[i].get('TaskId'), false);
                                            // Activate Tab선택
                                            this.ActivateAgreeTab();
                                        }
                                    }
                                    else {
                                        var newRecord = new ApproverRecord({
                                            Depth: dsResult.data.items[i].get('Depth'),
                                            TaskId: dsResult.data.items[i].get('TaskId'),
                                            Seq: dsResult.data.items[i].get('Seq'),
                                            Validation: dsResult.data.items[i].get('Validation'),
                                            Change: dsResult.data.items[i].get('Change')
                                        });

                                        var idx = dsResult.indexOf(dsResult.data.items[i]);
                                        dsResult.remove(dsResult.data.items[i]);
                                        dsResult.insert(idx, newRecord);

                                        history.removeChild(approver);

                                        //결재자(검토자)를 제거하면 다음 협조자 목록도 Clear함.
                                        this.RemoveAgreeNode(dsResult.data.items[i].get('TaskId'))
                                        // 단계별 협조자 Display
                                        this.EnableAgreeTab(dsResult.data.items[i].get('TaskId'), false);
                                        // Activate Tab선택
                                        this.ActivateAgreeTab();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        else {
            for (var i = 0; i < dsResult.data.items.length; i++) {
                if (dsResult.data.items[i].get("EmpID") != undefined && dsResult.data.items[i].get("EmpID") != "") {
                    //대리작성인 경우 기안자 변경 불가.
                    if (dsResult.data.items[i].get('TaskId') == "emp0") {
                        if ($(AwxXml).find('Fields')[0] != null) {
                            if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null) {
                                if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y") {
                                    this.WarningMessageBox(GetResource("ApproverDrafterNoChangeMsg"));
                                }
                            }
                        }
                    }

                    if (dsResult.data.items[i].get("Change") != "false") {
                        // 현재 member 노드 접근
                        var approver = $(history).find('Approver[TaskID = \'' + dsResult.data.items[i].get('TaskId') + '\']')[0];
                        if (approver != null) {
                            var status = approver.getAttribute("Status");

                            if (status != "") {
                                this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                            }
                            else {
                                if (this.CheckUserId) {
                                    if (approver.getAttribute("LoginID") == this.CurrentUser && approver.getAttribute("TaskID") == this.CurrentUserTaskID) {
                                        this.WarningMessageBox(GetResource("AppointApprovalCurrentApprover"));
                                    }
                                    else {
                                        var newRecord = new ApproverRecord({
                                            Depth: dsResult.data.items[i].get('Depth'),
                                            TaskId: dsResult.data.items[i].get('TaskId'),
                                            Seq: dsResult.data.items[i].get('Seq'),
                                            Validation: dsResult.data.items[i].get('Validation'),
                                            Change: dsResult.data.items[i].get('Change')
                                        });

                                        var idx = dsResult.indexOf(dsResult.data.items[i]);
                                        dsResult.remove(dsResult.data.items[i]);
                                        dsResult.insert(idx, newRecord);

                                        history.removeChild(approver);
                                    }
                                }
                                else {
                                    var newRecord = new ApproverRecord({
                                        Depth: dsResult.data.items[i].get('Depth'),
                                        TaskId: dsResult.data.items[i].get('TaskId'),
                                        Seq: dsResult.data.items[i].get('Seq'),
                                        Validation: dsResult.data.items[i].get('Validation'),
                                        Change: dsResult.data.items[i].get('Change')
                                    });

                                    var idx = dsResult.indexOf(dsResult.data.items[i]);
                                    dsResult.remove(dsResult.data.items[i]);
                                    dsResult.insert(idx, newRecord);

                                    history.removeChild(approver);
                                }
                            }
                        }
                    }
                }
            }
        }
        this.AllSelectionClear();
    },

    HandlerRemoveAllAgree: function (dataGrid, dsResult) {
        var mask = new Ext.LoadMask(dataGrid.getView().el, { msg: GetResource("WaitMsg") });
        mask.show();

        switch (dsResult.id) {
            case 'A101':
                agreeId = "emp0_after";
                break;
            case 'A102':
                agreeId = "r0001_after";
                break;
            case 'A103':
                agreeId = "r0002_after";
                break;
            case 'A104':
                agreeId = "r0003_after";
                break;
            case 'A105':
                agreeId = "r0004_after";
                break;
            case 'A106':
                agreeId = "r0005_after";
                break;
            case 'A107':
                agreeId = "r0006_after";
                break;
            case 'AB101':
                agreeId = "before";
                break;
            case 'AF101':
                agreeId = "after";
                break;

            /* 담당협조 추가 */ 
            case 'CA101':
                agreeId = "emp1_after";
                break;
            case 'CA102':
                agreeId = "r1001_after";
                break;
            case 'CA103':
                agreeId = "r1002_after";
                break;
            case 'CA104':
                agreeId = "r1003_after";
                break;
            case 'CA105':
                agreeId = "r1004_after";
                break;
            case 'CA106':
                agreeId = "r1005_after";
                break;
            case 'CA107':
                agreeId = "r1006_after";
                break;

            // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)     
            case 'CA201':
                agreeId = "emp2_after";
                break;
            case 'CA202':
                agreeId = "r2001_after";
                break;
            case 'CA203':
                agreeId = "r2002_after";
                break;
            case 'CA204':
                agreeId = "r2003_after";
                break;
            case 'CA205':
                agreeId = "r2004_after";
                break;
            case 'CA206':
                agreeId = "r2005_after";
                break;
            case 'CA207':
                agreeId = "r2006_after";
                break;
        }

        // 협조노드
        var agrees = $(AwxXml).find("Histories History[Seq='" + app_seq + "'] Agree[Ref='" + agreeId + "']")[0];

        if (agrees != null) {
            // 협조노드에서 제거
            for (var i = 0; i < dsResult.data.items.length; i++) {
                var approver = $(agrees).find('Approver[TaskID = \'' + dsResult.data.items[i].get('TaskId') + '\']')[0];

                if (approver != null) {
                    agrees.removeChild(approver);
                }
            }
            dsResult.removeAll();
            //협조 탭 타이틀 변경
            //this.ChangeTabTitle(agreeId, dsResult);
        }
        mask.hide();
        this.AllSelectionClear();
    },

    HandlerRemoveAllCharge: function (dataGrid, dsResult) {

        var mask = new Ext.LoadMask(dataGrid.getView().el, { msg: GetResource("WaitMsg") });
        mask.show();
        for (var i = 0; i < dsResult.data.items.length; i++) {
            if (dsResult.data.items[i].get("Change") == "false") {
                this.WarningMessageBox(GetResource("ImpossibleChange", dsResult.data.items[i].get('Depth')));
                return;
            }

            var history = $(AwxXml).find('Histories History[Seq = ' + dsResult.data.items[i].get("Seq") + ']')[0];
            if (history == null) return;

            if (dsResult.data.items[i].get("EmpID") != undefined && dsResult.data.items[i].get("EmpID") != "") {
                //대리작성인 경우 기안자 변경 불가.
                if (dsResult.data.items[i].get('TaskId') == "emp0") {
                    if ($(AwxXml).find('Fields')[0] != null) {
                        if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null) {
                            if ($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y") {
                                this.WarningMessageBox(GetResource("ApproverDrafterNoChangeMsg"));
                            }
                        }
                    }
                }
                else {
                    // 현재 member 노드 접근
                    var approver = $(history).find('Approver[TaskID = \'' + dsResult.data.items[i].get('TaskId') + '\']')[0];
                    if (approver != null) {
                        var status = approver.getAttribute("Status");

                        if (status != "") {
                            this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                        }
                        else {
                            var newRecord = new ApproverRecord({
                                Depth: dsResult.data.items[i].get('Depth'),
                                TaskId: dsResult.data.items[i].get('TaskId'),
                                Seq: dsResult.data.items[i].get('Seq'),
                                Validation: dsResult.data.items[i].get('Validation'),
                                Change: dsResult.data.items[i].get('Change')
                            });

                            var idx = dsResult.indexOf(dsResult.data.items[i]);
                            dsResult.remove(dsResult.data.items[i]);
                            dsResult.insert(idx, newRecord);

                            history.removeChild(approver);
                        }
                    }
                }
            }
        }
        this.AllSelectionClear();
    },

    AllSelectionClear: function () {
        if (this.CurrentGridSet) {
            if (this.CurrentGridSet.Select == null) this.InitSelectGrid();
            this.CurrentGridSet.Select.getSelectionModel().clearSelections();
            var selectHeader = this.CurrentGridSet.Select.getView().getHeaderCell(0).childNodes[0];
            Ext.get(selectHeader).removeClass('x-grid3-hd-checker-on');

            if (this.RowCount > 0) {
                this.CurrentGridSet.Approver.getSelectionModel().clearSelections();
                var approverHeader = this.CurrentGridSet.Approver.getView().getHeaderCell(0).childNodes[0];
                Ext.get(approverHeader).removeClass('x-grid3-hd-checker-on');
            }

            if (this.CRowCount > 0) {
                this.CurrentGridSet.Charge.getSelectionModel().clearSelections();
                var chargeHeader = this.CurrentGridSet.Charge.getView().getHeaderCell(0).childNodes[0];
                Ext.get(chargeHeader).removeClass('x-grid3-hd-checker-on');
            }

            if (is_agree_multi) {
                for (var i = 0; i < this.TabAgreeContainerMulti.items.length; i++) {
                    if (!this.TabAgreeContainerMulti.items.items[i].disabled) {
                        //var agreeGrid = eval("this.CurrentGridSet.Agree" + (i + 1));
                        var agreeGrid = eval("this.CurrentGridSet." + ((app_seq == 1) ? "C" : (app_seq == 2) ? "C2" : "") + "Agree" + (i + 1));
                        agreeGrid.getSelectionModel().clearSelections();
                        var agreeHeader = agreeGrid.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agreeHeader).removeClass('x-grid3-hd-checker-on');
                        break;
                    }
                }

                switch (this.TabAgreeContainerMulti.activeTab.id.split('_')[1]) {
                    case 'A102':
                        this.CurrentGridSet.Agree2.getSelectionModel().clearSelections();
                        var agree2Header = this.CurrentGridSet.Agree2.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree2Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'A103':
                        this.CurrentGridSet.Agree3.getSelectionModel().clearSelections();
                        var agree3Header = this.CurrentGridSet.Agree3.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree3Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'A104':
                        this.CurrentGridSet.Agree4.getSelectionModel().clearSelections();
                        var agree4Header = this.CurrentGridSet.Agree4.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree4Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'A105':
                        this.CurrentGridSet.Agree5.getSelectionModel().clearSelections();
                        var agree5Header = this.CurrentGridSet.Agree5.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree5Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'A106':
                        this.CurrentGridSet.Agree6.getSelectionModel().clearSelections();
                        var agree6Header = this.CurrentGridSet.Agree6.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree6Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'A107':
                        this.CurrentGridSet.Agree7.getSelectionModel().clearSelections();
                        var agree7Header = this.CurrentGridSet.Agree7.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree7Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    /* 담당협조 추가 */ 
                    case 'CA101':
                        this.CurrentGridSet.CAgree1.getSelectionModel().clearSelections();
                        var agree1Header = this.CurrentGridSet.CAgree1.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree1Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA102':
                        this.CurrentGridSet.CAgree2.getSelectionModel().clearSelections();
                        var agree2Header = this.CurrentGridSet.CAgree2.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree2Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA103':
                        this.CurrentGridSet.CAgree3.getSelectionModel().clearSelections();
                        var agree3Header = this.CurrentGridSet.CAgree3.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree3Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA104':
                        this.CurrentGridSet.CAgree4.getSelectionModel().clearSelections();
                        var agree4Header = this.CurrentGridSet.CAgree4.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree4Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA105':
                        this.CurrentGridSet.CAgree5.getSelectionModel().clearSelections();
                        var agree5Header = this.CurrentGridSet.CAgree5.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree5Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA106':
                        this.CurrentGridSet.CAgree6.getSelectionModel().clearSelections();
                        var agree6Header = this.CurrentGridSet.CAgree6.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree6Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA107':
                        this.CurrentGridSet.CAgree7.getSelectionModel().clearSelections();
                        var agree7Header = this.CurrentGridSet.CAgree7.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree7Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)     
                    case 'CA201':
                        this.CurrentGridSet.C2Agree1.getSelectionModel().clearSelections();
                        var agree1Header = this.CurrentGridSet.C2Agree1.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree1Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA202':
                        this.CurrentGridSet.C2Agree2.getSelectionModel().clearSelections();
                        var agree2Header = this.CurrentGridSet.C2Agree2.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree2Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA203':
                        this.CurrentGridSet.C2Agree3.getSelectionModel().clearSelections();
                        var agree3Header = this.CurrentGridSet.C2Agree3.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree3Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA204':
                        this.CurrentGridSet.C2Agree4.getSelectionModel().clearSelections();
                        var agree4Header = this.CurrentGridSet.C2Agree4.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree4Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA205':
                        this.CurrentGridSet.C2Agree5.getSelectionModel().clearSelections();
                        var agree5Header = this.CurrentGridSet.C2Agree5.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree5Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA206':
                        this.CurrentGridSet.C2Agree6.getSelectionModel().clearSelections();
                        var agree6Header = this.CurrentGridSet.C2Agree6.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree6Header).removeClass('x-grid3-hd-checker-on');
                        break;

                    case 'CA207':
                        this.CurrentGridSet.C2Agree7.getSelectionModel().clearSelections();
                        var agree7Header = this.CurrentGridSet.C2Agree7.getView().getHeaderCell(0).childNodes[0];
                        Ext.get(agree7Header).removeClass('x-grid3-hd-checker-on');
                        break;
                }
            }

            if (is_agree_before && is_agree_after) {
                this.CurrentGridSet.AgreeBefore.getSelectionModel().clearSelections();
                var agreeBeforeHeader = this.CurrentGridSet.AgreeBefore.getView().getHeaderCell(0).childNodes[0];
                Ext.get(agreeBeforeHeader).removeClass('x-grid3-hd-checker-on');

                if (this.TabAgreeContainerBeforeAfter.activeTab.id.split('_')[1] == 'after') {
                    this.CurrentGridSet.AgreeAfter.getSelectionModel().clearSelections();
                    var agreeAfterHeader = this.CurrentGridSet.AgreeAfter.getView().getHeaderCell(0).childNodes[0];
                    Ext.get(agreeAfterHeader).removeClass('x-grid3-hd-checker-on');
                }
            }
            else if (is_agree_before && is_agree_after) {
                this.CurrentGridSet.AgreeBefore.getSelectionModel().clearSelections();
                var agreeBeforeHeader = this.CurrentGridSet.AgreeBefore.getView().getHeaderCell(0).childNodes[0];
                Ext.get(agreeBeforeHeader).removeClass('x-grid3-hd-checker-on');
            }
            else if (!is_agree_before && is_agree_after) {
                this.CurrentGridSet.AgreeAfter.getSelectionModel().clearSelections();
                var agreeAfterHeader = this.CurrentGridSet.AgreeAfter.getView().getHeaderCell(0).childNodes[0];
                Ext.get(agreeAfterHeader).removeClass('x-grid3-hd-checker-on');
            }
        }
    },

    OnButtonClick: function (strType, strId) {
        if (!this.CurrentGridSet) return;
        var dataGrid = eval("this.CurrentGridSet." + strId);
        var dsResult = eval("this." + strId + "Result");
        var sourceGrid = null;

        var mask = new Ext.LoadMask(dataGrid.getView().el, { msg: GetResource("WaitMsg") });
        mask.show();

        switch (strType) {
            case 'Add':
                if (strId == "Approver")
                    this.HandlerAddApprover(dataGrid, dsResult);
                else if (strId == "Charge")
                    this.HandlerAddCharge(dataGrid, dsResult);
                else
                    this.HandlerAddAgree(dataGrid, dsResult);
                break;

            case 'Remove':
                if (dataGrid.getSelectionModel().getSelections().length > 0) {
                    if (strId == "Approver")
                        this.HandlerRemoveApprover(dataGrid, dsResult);
                    else if (strId == "Charge")
                        this.HandlerRemoveCharge(dataGrid, dsResult);
                    else
                        this.HandlerRemoveAgree(dataGrid, dsResult);
                }
                break;

            case 'Up':
            case 'Down':
                if (dataGrid.getSelectionModel().getSelections().length > 0) {
                    if (strId == "Approver")
                        this.HandlerUpDownApprover(dataGrid, dsResult, strType);
                    else if (strId == "Charge")
                        this.HandlerUpDownCharge(dataGrid, dsResult, strType);
                    else
                        this.HandlerUpDownAgree(dataGrid, dsResult, strType);
                }
                break;

            case 'RemoveAll':
                if (dsResult.getCount() > 0) {
                    if (strId == "Approver")
                        this.HandlerRemoveAllApprover(dataGrid, dsResult);
                    else if (strId == "Charge")
                        this.HandlerRemoveAllCharge(dataGrid, dsResult);
                    else
                        this.HandlerRemoveAllAgree(dataGrid, dsResult);
                }
                break;
        }
        mask.hide();
    },

    InitSelectGrid: function () {
        var id = LeftTabContainer.activeTab.id.split('_')[0];
        var obj = eval("GW." + id);
        var fn = eval("obj.ReturnSourceGrid");

        if (typeof (fn) == 'function') {
            this.CurrentGridSet.Select = eval("obj.ReturnSourceGrid()");
        }
        this.HideDisabledAgreeTab();
    },

    EnableAgreeTab: function (id, visible) {
        for (var i = 0; i < this.TabAgreeContainerMulti.items.length; i++) {
            var idx = i + 1;

            if (this.TabAgreeContainerMulti.items.items[i].id == (id + "_" + ((app_seq == 1) ? "C" : (app_seq == 2) ? "C" : "") + "A" + ((app_seq == 2) ? "2" : "1") + "0" + idx)) {
                if (visible) {
                    this.TabAgreeContainerMulti.items.items[i].enable();
                    this.TabAgreeContainerMulti.unhideTabStripItem(this.TabAgreeContainerMulti.items.items[i]);
                    break;
                }
                else {
                    this.TabAgreeContainerMulti.hideTabStripItem(this.TabAgreeContainerMulti.items.items[i]);
                    this.TabAgreeContainerMulti.items.items[i].disable();
                    break;
                }
            }
        }
    },

    ActivateAgreeTab: function () {
        for (var j = 0; j < this.TabAgreeContainerMulti.items.length; j++) {
            if (!this.TabAgreeContainerMulti.items.items[j].disabled) {
                this.TabAgreeContainerMulti.activate(this.TabAgreeContainerMulti.items.items[j]);
                return true;
            }
        }
    },

    HideDisabledAgreeTab: function () {
        for (var j = 0; j < this.TabAgreeContainerMulti.items.length; j++) {
            if (this.TabAgreeContainerMulti.items.items[j].disabled) {
                this.TabAgreeContainerMulti.hideTabStripItem(this.TabAgreeContainerMulti.items.items[j]);
            }
        }
    },

    ChangeTabTitle: function (id, ds) {
        id = id.split('_')[0];
        var strTitle = "";

        switch (id) {
            case 'C101':
                //strTitle = String.format('기안({0})', ds.data.getCount());
                strTitle = String.format(GetResource("ChargeAgreeTabDraft"), ds.data.getCount());
                break;

            case 'E101':
                //strTitle = String.format('결재1({0})', ds.data.getCount())
                strTitle = String.format(GetResource("ChargeAgreeTabApp1"), ds.data.getCount());
                break;

            case 'E102':
                //strTitle = String.format('결재2({0})', ds.data.getCount())
                strTitle = String.format(GetResource("ChargeAgreeTabApp2"), ds.data.getCount());
                break;

            case 'E103':
                //strTitle = String.format('결재3({0})', ds.data.getCount())
                strTitle = String.format(GetResource("ChargeAgreeTabApp3"), ds.data.getCount());
                break;

            case 'E104':
                //strTitle = String.format('결재4({0})', ds.data.getCount())
                strTitle = String.format(GetResource("ChargeAgreeTabApp4"), ds.data.getCount());
                break;

            case 'E105':
                //strTitle = String.format('결재5({0})', ds.data.getCount())
                strTitle = String.format(GetResource("ChargeAgreeTabApp5"), ds.data.getCount());
                break;

            case 'E106':
                //strTitle = String.format('결재5({0})', ds.data.getCount())
                strTitle = String.format(GetResource("ChargeAgreeTabApp6"), ds.data.getCount());
                break;

            case 'E107':
                //strTitle = String.format('결재5({0})', ds.data.getCount())
                strTitle = String.format(GetResource("ChargeAgreeTabApp7"), ds.data.getCount());
                break;
        }

        for (var i = 0; i < this.TabAgreeContainerMulti.items.length; i++) {
            var idx = i + 1;
            if (this.TabAgreeContainerMulti.items.items[i].id == (id + "_" + ((app_seq == 1) ? "C" : (app_seq == 2) ? "C2" : "") + "A" + ((app_seq == 2) ? "2" : "1") + "0" + idx)) {
                //if (this.TabAgreeContainerMulti.items.items[i].id == id + "_A10" + idx) {
                this.TabAgreeContainerMulti.items.items[i].setTitle(strTitle);
            }
        }
    },

    RemoveAgreeNode: function (strId) {
        var agreeId = strId + "_after";
        var dsAgreeResult = null;

        switch (strId) {
            case 'emp0':
                dsAgreeResult = this.Agree1Result;
                break;

            case 'r0001':
                dsAgreeResult = this.Agree2Result;
                break;

            case 'r0002':
                dsAgreeResult = this.Agree3Result;
                break;

            case 'r0003':
                dsAgreeResult = this.Agree4Result;
                break;

            case 'r0004':
                dsAgreeResult = this.Agree5Result;
                break;

            case 'r0005':
                dsAgreeResult = this.Agree6Result;
                break;

            case 'r0006':
                dsAgreeResult = this.Agree7Result;
                break;

            /* 담당협조 추가 */ 
            case 'emp1':
                dsAgreeResult = this.CAgree1Result;
                break;

            case 'r1001':
                dsAgreeResult = this.CAgree2Result;
                break;

            case 'r1002':
                dsAgreeResult = this.CAgree3Result;
                break;

            case 'r1003':
                dsAgreeResult = this.CAgree4Result;
                break;

            case 'r1004':
                dsAgreeResult = this.CAgree5Result;
                break;

            case 'r1005':
                dsAgreeResult = this.CAgree6Result;
                break;

            case 'r1006':
                dsAgreeResult = this.CAgree7Result;
                break;

            // 888 협조로 인한 담당2 후 협조선 추가 (2014-06-16 / 장경환)     
            case 'emp2':
                dsAgreeResult = this.C2Agree1Result;
                break;

            case 'r2001':
                dsAgreeResult = this.C2Agree2Result;
                break;

            case 'r2002':
                dsAgreeResult = this.C2Agree3Result;
                break;

            case 'r2003':
                dsAgreeResult = this.C2Agree4Result;
                break;

            case 'r2004':
                dsAgreeResult = this.C2Agree5Result;
                break;

            case 'r2005':
                dsAgreeResult = this.C2Agree6Result;
                break;

            case 'r2006':
                dsAgreeResult = this.C2Agree7Result;
                break;
        }

        // 협조노드
        var agrees = $(AwxXml).find("Histories History[Seq='" + app_seq + "'] Agree[Ref='" + agreeId + "']")[0];

        if (agrees != null && dsAgreeResult != null) {
            // 협조노드에서 제거
            $(AwxXml).find("Histories History[Seq='" + app_seq + "']")[0].removeChild(agrees);
            dsAgreeResult.removeAll();
        }
    }
});

//GW.ChargeAgree = new GW.SetLine.ChargeAgree();
