/*
* GW.SetLine.Acl.js
* 수신처/사본처
*/
GW.SetLine.Acl = function() {
    //GW.SetLine.Acl.superclass.constructor.call(this);

    // 수신처
    this.SendResult = new Ext.data.JsonStore
	({
	    id: 'SENDTO',
	    title: GetResource("Send"),
	    fields: APPDataFields
	});

    // 사본처
    this.CopyResult = new Ext.data.JsonStore
	({
	    id: 'COPYTO',
	    title: GetResource("Copy"),
	    fields: APPDataFields
	});

    this.SendGridDropTarget = null;
    this.CopyGridDropTarget = null;
	this.AclPanel = null;
    this.ReturnPanel = null;

    this.CurrentGridSet = this.InitGird();
    this.LoadAwx();
    this.Render();

    this.CurrentGridSet.Send.on('dblclick', function() {
        this.HandlerRemoveAcl(this.CurrentGridSet.Send, this.SendResult, 'Send')
    }, this);

    this.CurrentGridSet.Copy.on('dblclick', function() {
        this.HandlerRemoveAcl(this.CurrentGridSet.Copy, this.CopyResult, 'Copy')
    }, this);

	if(is_send && !is_copy)
		this.CurrentGridSet.Send.on('render', function() { this.DragDropSetting(); }, this);
	else
		this.CurrentGridSet.Copy.on('render', function() { this.DragDropSetting(); }, this);
};

Ext.extend(GW.SetLine.Acl, GW.SetLine.Common, {

    On_Acl_Send_DbClickItem: function (record, index, allItems) {
        this.On_Acl_Send_DbClickItem_Handle(record, index, allItems);
    },

    On_Acl_Send_DbClickItem_Handle: function (record, index, allItems) {
        var dataGrid = this.CurrentGridSet.Send;
        var dsResult = this.SendResult;

        this.HandlerAddAcl(dataGrid, dsResult, 'Send');
        this.AllSelectionClear();
    },

    On_Acl_Copy_DbClickItem: function (record, index, allItems) {
        this.On_Acl_Copy_DbClickItem_Handle(record, index, allItems);
    },

    On_Acl_Copy_DbClickItem_Handle: function (record, index, allItems) {
        var dataGrid = this.CurrentGridSet.Copy;
        var dsResult = this.CopyResult;

        this.HandlerAddAcl(dataGrid, dsResult, 'Copy');
        this.AllSelectionClear();
    },

    LoadAclArchive: function () {
        //그리드 리셋
        var gridArry = new Array("Send", "Copy");
        for (var i = 0; i < gridArry.length; i++) {
            var dsResult = eval("this." + gridArry[i] + "Result");
            dsResult.removeAll();
        }
        this.LoadAwx();
    },

    LoadAwx: function () {
        //수신, 사본처 바인딩
        var acls_node = $(AwxXml).find('Histories Acl');

        if (acls_node != null) {
            for (var i = 0; i < acls_node.length; i++) {
                var acls_id = acls_node[i].getAttribute("Type").toLowerCase();
                if (acls_id == "circular") continue;
                var dsAcl = null;
                var newRecords = new Array();

                switch (acls_id) {
                    case 'send':
                        dsAcl = this.SendResult;
                        break;

                    case 'copy':
                        dsAcl = this.CopyResult;
                        break;
                }

                if ($(AwxXml).find('Histories Acl[Type="' + acls_id + '"]') == null) {
                    fn_AddAcl($(AwxXml).find('Histories'), acls_id);
                }

                var acl_node = $(AwxXml).find("Histories Acl[Type='" + acls_id + "']")[0];

                if (acl_node != null) {
                    for (var j = 0; j < acl_node.childNodes.length; j++) {
                        if (!is_overlap) {
                            for (var k = 0; k < dsAcl.data.length; k++) {
                                if ((dsAcl.data.items[k].get("EmpID") == acl_node.childNodes[j].getAttribute("EmpID"))
                                && (dsAcl.data.items[k].get("DeptCode") == acl_node.childNodes[j].getAttribute("DeptCode"))) {
                                    var foundItem = true;
                                    break;
                                }
                            }
                        }
                        else {
                            var foundItem = false;
                        }

                        //var foundItem = dsAcl.find('Email', acl_node.childNodes[j].getAttribute("Email"));
                        if (!foundItem) {

                            var tmpDisplayName = "";
                            var tmpType = "";

                            if (acl_node.childNodes[j].getAttribute("LoginID").indexOf("@") != -1)
                                tmpType = "GROUP";
                            else
                                tmpType = "USER";

                            if (tmpType == "GROUP") {
                                tmpDisplayName = acl_node.childNodes[j].getAttribute("UserName");
                            }
                            else {
                                tmpDisplayName = acl_node.childNodes[j].getAttribute("DeptName") + ' ' + acl_node.childNodes[j].getAttribute("RankName") + ' ' + acl_node.childNodes[j].getAttribute("UserName");
                                //								if(acl_node.childNodes[j].getAttribute("DutyName") != "")
                                //								{
                                //									if(acl_node.childNodes[j].getAttribute("DutyName") == acl_node.childNodes[j].getAttribute("UserName"))
                                //									{
                                //										tmpDisplayName = acl_node.childNodes[j].getAttribute("DutyName");
                                //									}
                                //									else
                                //									{
                                //										tmpDisplayName = acl_node.childNodes[j].getAttribute("DutyName") + ' ' + acl_node.childNodes[j].getAttribute("UserName")
                                //									}
                                //								}
                                //								else
                                //								{
                                //									tmpDisplayName = acl_node.childNodes[j].getAttribute("DeptName") + ' ' + acl_node.childNodes[j].getAttribute("RankName") + ' ' + acl_node.childNodes[j].getAttribute("UserName");
                                //								}
                            }

                            var newRecord = new ApproverRecordACL({
                                EmpID: acl_node.childNodes[j].getAttribute("EmpID"),
                                LoginID: acl_node.childNodes[j].getAttribute("LoginID"),
                                Key: acl_node.childNodes[j].getAttribute("LoginID") + acl_node.childNodes[j].getAttribute("DeptCode"),
                                ADDisplayName: acl_node.childNodes[j].getAttribute("UserName") + "(" + acl_node.childNodes[j].getAttribute("LoginID") + ")/" + acl_node.childNodes[j].getAttribute("DeptName"),
                                UserName: acl_node.childNodes[j].getAttribute("UserName"),
                                Email: acl_node.childNodes[j].getAttribute("Email"),
                                Type: tmpType,
                                DeptCode: acl_node.childNodes[j].getAttribute("DeptCode"),
                                DeptName: acl_node.childNodes[j].getAttribute("DeptName"),
                                CompanyCode: acl_node.childNodes[j].getAttribute("CompanyCode"),
                                CompanyName: acl_node.childNodes[j].getAttribute("CompanyName"),
                                DutyCode: acl_node.childNodes[j].getAttribute("DutyCode"),
                                DutyName: acl_node.childNodes[j].getAttribute("DutyName"),
                                JobName: acl_node.childNodes[j].getAttribute("JobName"),
                                RankName: acl_node.childNodes[j].getAttribute("RankName"),
                                CellPhone: acl_node.childNodes[j].getAttribute("CellPhone"),
                                TeamChiefYN: acl_node.childNodes[j].getAttribute("TeamChiefYN"),
                                ExtensionNumber: acl_node.childNodes[j].getAttribute("ExtensionNumber"),
                                FaxNumber: acl_node.childNodes[j].getAttribute("FaxNumber"),
                                TaskId: acl_node.childNodes[j].getAttribute("TaskID"),
                                DisplayName: tmpDisplayName,
                                SignID : acl_node.childNodes[j].getAttribute("SignID")
                            });

                            newRecords[j] = newRecord;
                        }
                    }
                    dsAcl.add(newRecords);
                }
            }
        }
    },

    InitGird: function () {
        //수신처
        var SendGridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var SendResultCM = new Ext.grid.ColumnModel
		([
			SendGridCheckBox,
			{ header: '&nbsp;', dataIndex: 'DisplayName', width: 75, renderer: this.RendererUserName.createDelegate(this) }
		]);

        var tmpMarings = '5 5 0 5';

        if (is_send && !is_copy) tmpMarings = '5 5 5 5';

        if (Ext.isIE6) {
            var sendHeight = 202;
        }
        else {
            var sendHeight = 203;
        }

        var SendResultGrid = new Ext.grid.GridPanel
		({
		    region: 'north',
		    margins: tmpMarings,
		    ddGroup: 'DDGSend',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: true,
		    ds: this.SendResult,
		    cm: SendResultCM,
		    sm: SendGridCheckBox,
		    stripeRows: true,
		    height: sendHeight,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Send")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'Send')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("GroupAdd"), text: GetResource("ApproverGroupAddTooltip", GetResource("Send")) },
				    iconCls: 'add',
				    text: GetResource("GroupAdd"),
				    handler: function () {
				        this.OnButtonClick('AddGroup', 'Send')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Send")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'Send')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Send")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'Send')
				    },
				    scope: this
				}, '->'
		    /*
		    ,
		    {
		    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Send")) },
		    iconCls: 'up',
		    text: GetResource("Up"),
		    handler: function () {
		    this.OnButtonClick('Up', 'Send')
		    },
		    scope: this
		    },
		    {
		    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Send")) },
		    iconCls: 'down',
		    text: GetResource("Down"),
		    handler: function () {
		    this.OnButtonClick('Down', 'Send')
		    },
		    scope: this
		    }
		    */
			],
		    title: GetResource("Send"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        //참조처
        var CopyGridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var CopyResultCM = new Ext.grid.ColumnModel
		([
			CopyGridCheckBox,
			{ header: '&nbsp;', dataIndex: 'DisplayName', width: 75, renderer: this.RendererUserName.createDelegate(this) }
		]);

        var CopyResultGrid = new Ext.grid.GridPanel
		({
		    region: 'center',
		    margins: '5 5 5 5',
		    ddGroup: 'DDGCopy',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: true,
		    ds: this.CopyResult,
		    cm: CopyResultCM,
		    sm: CopyGridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip", GetResource("Copy")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.OnButtonClick('Add', 'Copy')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("GroupAdd"), text: GetResource("ApproverGroupAddTooltip", GetResource("Copy")) },
				    iconCls: 'add',
				    text: GetResource("GroupAdd"),
				    handler: function () {
				        this.OnButtonClick('AddGroup', 'Copy')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip", GetResource("Copy")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.OnButtonClick('Remove', 'Copy')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip", GetResource("Copy")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.OnButtonClick('RemoveAll', 'Copy')
				    },
				    scope: this
				}, '->'
		    /*
		    ,
		    {
		    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip", GetResource("Copy")) },
		    iconCls: 'up',
		    text: GetResource("Up"),
		    handler: function () {
		    this.OnButtonClick('Up', 'Copy')
		    },
		    scope: this
		    },
		    {
		    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip", GetResource("Copy")) },
		    iconCls: 'down',
		    text: GetResource("Down"),
		    handler: function () {
		    this.OnButtonClick('Down', 'Copy')
		    },
		    scope: this
		    }
		    */
			],
		    title: GetResource("Copy"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        //수신처/사본처 보관함이 없는 경우 그룹추가 숨김
        var isAclArchive = false;
        var leftTabNodes = $(FormXml).find("select tab");

        //alert(leftTabNodes.length);

        for (var i = 0; i < leftTabNodes.length; i++) {
            var src = leftTabNodes[i].getAttribute("src");
            var objKey = src.substring(src.lastIndexOf('/') + 1, src.lastIndexOf('.'));

            if (objKey.toLowerCase() == "aclarchive") {
                isAclArchive = true;
                break;
            }
        }

        if (!isAclArchive) {
            SendResultGrid.bottomToolbar.remove(SendResultGrid.bottomToolbar[1]);
            CopyResultGrid.bottomToolbar.remove(CopyResultGrid.bottomToolbar[1]);
        }

        var gridSet =
		{
		    Send: SendResultGrid,
		    Copy: CopyResultGrid
		};

        return gridSet;
    },

    Render: function () {

        this.ReturnPanel = new Ext.Panel
		({
		    id: 'Acl',
		    layout: 'border',
		    border: false,
		    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;'
		});

        var formType = null;

        formType = AwxXml.getAttribute("FormFile");

        if (formType != null && is_word) {
            if (formType == "2") {
                //대외공문일경우(사내사본처) 
                this.CurrentGridSet.Copy.setTitle(GetResource("AppointApprovalInternalCopy"));
            }
        }

        if (is_send && is_copy) {
            this.ReturnPanel.add(this.CurrentGridSet.Send);
            this.ReturnPanel.add(this.CurrentGridSet.Copy);
        }
        else if (is_send && !is_copy) {
            this.CurrentGridSet.Send.region = 'center';
            this.ReturnPanel.add(this.CurrentGridSet.Send);
        }
        else if (!is_send && is_copy) {
            this.ReturnPanel.add(this.CurrentGridSet.Copy);
        }
    },

    DragDropSetting: function () {
        var grids = this.CurrentGridSet;

        function HandlerAclGridDrop(ddSource, dsResult, strId) {
            var strNoEmailList = "";
            var strOverLapUserList = "";
            var resourceKey = "";

            var aclId = strId.toLowerCase();

            if (aclId == "send")
                resourceKey = "Send";
            else
                resourceKey = "Copy";

            if ($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']').length == 0) {
                fn_AddAcl($(AwxXml).find('Histories'), aclId);
            }

            Ext.each(ddSource.dragData.selections, function (record, index, allItems) {
                if (dsResult.data.items.length >= 200) {
                    var args = new Array();
                    if (aclId == "send") {
                        args.push(GetResource("Send"));
                    }
                    else {
                        args.push(GetResource("Copy"));
                    }
                    args.push("200");
                    GW.Acl.WarningMessageBox(GetResource("ApproverMaxMsg", args));
                    return false;
                }

                //if (record.data.Email.length == 0) {
                if (record.data.EmpID.length == 0) {
                    strNoEmailList += record.data.UserName + ', ';
                    return true;
                }

                // Email 유일키
                if (!is_overlap) {
                    for (var i = 0; i < dsResult.data.length; i++) {
                        //if (dsResult.data.items[i].get("Email") == record.data.Email) {
                        if ((dsResult.data.items[i].get("EmpID") == record.data.EmpID)
                        && (dsResult.data.items[i].get("DeptCode") == record.data.DeptCode)) {
                            var foundItem = true;
                            break;
                        }
                    }
                }
                else {
                    var foundItem = false;
                }

                //var foundItem = dsResult.find('Email', record.data.Email);

                if (!foundItem) {
                    if (record.data.Type == "GROUP") {
                        record.data.DisplayName = record.data.UserName;
                    }
                    else {

                        record.data.DisplayName = record.data.DeptName + ' ' + record.data.RankName + ' ' + record.data.UserName;
                        //						if(record.data.DutyName != "")
                        //						{
                        //							if(record.data.DutyName == record.data.UserName)
                        //							{
                        //								record.data.DisplayName = record.data.UserName;
                        //							}
                        //							else
                        //							{
                        //								record.data.DisplayName = record.data.DutyName + ' ' + record.data.UserName;
                        //							}
                        //						}
                        //						else
                        //						{
                        //							record.data.DisplayName = record.data.DeptName + ' ' + record.data.RankName + ' ' + record.data.UserName;
                        //						}
                    }

                    var newRecord = new ApproverRecordACL({
                        EmpID: record.data.EmpID,
                        LoginID: record.data.LoginID,
                        Key: record.data.LoginID + record.data.DeptCode,
                        ADDisplayName: record.data.ADDisplayName,
                        UserName: record.data.UserName,
                        Email: record.data.Email,
                        Type: record.data.Type,
                        DeptCode: record.data.DeptCode,
                        DeptName: record.data.DeptName,
                        CompanyCode: record.data.CompanyCode,
                        CompanyName: record.data.CompanyName,
                        DutyCode: record.data.DutyCode,
                        DutyName: record.data.DutyName,
                        JobName: record.data.JobName,
                        RankName: record.data.RankName,
                        CellPhone: record.data.CellPhone,
                        TeamChiefYN: record.data.TeamChiefYN,
                        ExtensionNumber: record.data.ExtensionNumber,
                        FaxNumber: record.data.FaxNumber,
                        Depth: dsResult.title,
                        TaskId: dsResult.id,
                        Seq: '',
                        Validation: '',
                        Change: '',
                        DisplayName: record.data.DisplayName,
                        SignID: record.data.SignID
                    });

                    dsResult.add(newRecord);
                    //AWX에 정보 추가
                    fn_AddMember($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']'), fn_GetUserInfo(record));
                }
                else {
                    if (strOverLapUserList == "")
                        strOverLapUserList = record.get("UserName");
                    else
                        strOverLapUserList = strOverLapUserList + ", " + record.get("UserName");
                }
            }, this);

            if (strOverLapUserList != "") {
                var args = new Array();
                args[0] = strOverLapUserList;
                args[1] = GetResource(resourceKey);
                GW.Acl.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
            }

            if (strNoEmailList.length > 1) {
                GW.Acl.WarningMessageBox(strNoEmailList + GetResource("NoInfoAddMsg"));
            }

            GW.Acl.AllSelectionClear();
        }

        function HandlerAclGroupGridDrop(ddSource, dsResult, strId) {
            var strNoEmailList = "";
            var strOverLapUserList = "";
            var resourceKey = "";

            var aclId = strId.toLowerCase();

            if (aclId == "send")
                resourceKey = "Send";
            else
                resourceKey = "Copy";

            if ($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']') == null) {
                fn_AddAcl($(AwxXml).find('Histories'), aclId);
            }

            Ext.each(ddSource.dragData.selections, function (record, index, allItems) {

                if (dsResult.data.items.length >= 200) {
                    var args = new Array();
                    if (aclId == "send") {
                        args.push(GetResource("Send"));
                    }
                    else {
                        args.push(GetResource("Copy"));
                    }
                    args.push("200");
                    GW.Acl.WarningMessageBox(GetResource("ApproverMaxMsg", args));
                }

                if (record.data.TYPE == "GROUP") {
                    var AclLines = record.data.XML_LINE;
                    var AclLineInfo = AclLines.split("^");
                    var sendEmails = "";
                    var copyEmails = "";

                    for (var i = 0; i < AclLineInfo.length; i++) {
                        var task_id = AclLineInfo[i].split("*")[0];
                        var userInfo = AclLineInfo[i].split("*")[1];
                        var user_info = fn_CreateUserInfo(userInfo);

                        if (task_id.indexOf("send") > -1) {
                            if (sendEmails == "")
                                sendEmails = user_info.Email;
                            else
                                sendEmails = sendEmails + "; " + user_info.Email;
                        }
                        else if (task_id.indexOf("copy") > -1) {
                            if (copyEmails == "")
                                copyEmails = user_info.Email;
                            else
                                copyEmails = copyEmails + "; " + user_info.Email;
                        }
                    }

                    if (aclId == "send") {
                        // Email 유일키
                        if (is_overlap) {
                            for (var k = 0; k < dsResult.data.length; k++) {
                                if (dsResult.data.items[k].get("Email") == sendEmails) {
                                    var foundItem = true;
                                    break;
                                }
                            }
                        }
                        else {
                            var foundItem = false;
                        }

                        //var foundItem = dsResult.find('Email', sendEmails);

                        if (!foundItem) {
                            if ($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']') == null) {
                                fn_AddAcl($(AwxXml).find('Histories'), aclId);
                            }

                            var newRecord = new ApproverRecordACL({
                                EmpID: "",
                                LoginID: "",
                                Key: "",
                                ADDisplayName: record.data.SUBJECT,
                                UserName: record.data.SUBJECT,
                                Email: sendEmails,
                                Type: "",
                                DeptCode: "",
                                DeptName: "",
                                CompanyCode: "",
                                CompanyName: "",
                                DutyCode: "",
                                DutyName: "",
                                JobName: "",
                                RankName: "",
                                CellPhone: "",
                                TeamChiefYN: "",
                                ExtensionNumber: "",
                                FaxNumber: "",
                                Depth: "",
                                TaskId: "",
                                Seq: "",
                                Validation: "",
                                Change: "",
                                DisplayName: record.data.SUBJECT,
                                SignID : ""
                            });
                            dsResult.add(newRecord);
                            //AWX에 결재자 정보 추가
                            fn_AddMember($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']'), fn_GetUserInfo(newRecord));
                        }
                        else {
                            if (strOverLapUserList == "")
                                strOverLapUserList = record.data.SUBJECT;
                            else
                                strOverLapUserList = strOverLapUserList + ", " + record.data.SUBJECT;
                        }
                    }
                    else if (aclId == "copy") {
                        // Email 유일키
                        if (is_overlap) {
                            for (var k = 0; k < dsResult.data.length; k++) {
                                if (dsResult.data.items[k].get("Email") == copyEmails) {
                                    var foundItem = true;
                                    break;
                                }
                            }
                        }
                        else {
                            var foundItem = false;
                        }

                        //var foundItem = dsResult.find('Email', copyEmails);

                        if (!foundItem) {
                            if ($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']') == null) {
                                fn_AddAcl($(AwxXml).find('Histories'), aclId);
                            }

                            var newRecord = new ApproverRecordACL({
                                EmpID: "",
                                LoginID: "",
                                Key: "",
                                ADDisplayName: record.data.SUBJECT,
                                UserName: record.data.SUBJECT,
                                Email: copyEmails,
                                Type: "",
                                DeptCode: "",
                                DeptName: "",
                                CompanyCode: "",
                                CompanyName: "",
                                DutyCode: "",
                                DutyName: "",
                                JobName: "",
                                RankName: "",
                                CellPhone: "",
                                TeamChiefYN: "",
                                ExtensionNumber: "",
                                FaxNumber: "",
                                Depth: "",
                                TaskId: "",
                                Seq: "",
                                Validation: "",
                                Change: "",
                                DisplayName: record.data.SUBJECT,
                                SignID: ""
                            });
                            dsResult.add(newRecord);
                            //AWX에 결재자 정보 추가
                            fn_AddMember($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']'), fn_GetUserInfo(newRecord));
                        }
                        else {
                            if (strOverLapUserList == "")
                                strOverLapUserList = record.data.SUBJECT;
                            else
                                strOverLapUserList = strOverLapUserList + ", " + record.data.SUBJECT;
                        }
                    }
                }
            }, this);

            if (strOverLapUserList != "") {
                var args = new Array();
                args[0] = strOverLapUserList;
                args[1] = GetResource(resourceKey);
                GW.Acl.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
            }

            if (strNoEmailList.length > 1) {
                GW.Acl.WarningMessageBox(strNoEmailList + GetResource("NoInfoAddMsg"));
            }

            GW.Acl.AllSelectionClear()
        }

        if (is_send) {
            var SendGridDropTargetEl = grids.Send.getView().el.dom.childNodes[0].childNodes[1];
            this.SendGridDropTarget = new Ext.dd.DropTarget(SendGridDropTargetEl, {
                ddGroup: 'DDGSelect',
                notifyDrop: function (ddSource, e, data) {
                    var mask = new Ext.LoadMask(grids.Send.getView().el, { msg: GetResource("WaitMsg") });
                    mask.show();
                    if (ddSource.ddGroup == "DDGArchiveAcl")
                        HandlerAclGroupGridDrop(ddSource, grids.Send.store, 'Send');
                    else
                        HandlerAclGridDrop(ddSource, grids.Send.store, 'Send');
                    mask.hide();
                    return true;
                }
            }, this);
            this.SendGridDropTarget.addToGroup('DDGCopy');
            this.SendGridDropTarget.addToGroup('DDGArchiveSend');
            this.SendGridDropTarget.addToGroup('DDGArchiveAcl');
        }

        if (is_copy) {
            var CopyGridDropTargetEl = grids.Copy.getView().el.dom.childNodes[0].childNodes[1];
            this.CopyGridDropTarget = new Ext.dd.DropTarget(CopyGridDropTargetEl, {
                ddGroup: 'DDGSelect',
                notifyDrop: function (ddSource, e, data) {
                    var mask = new Ext.LoadMask(grids.Copy.getView().el, { msg: GetResource("WaitMsg") });
                    mask.show();
                    if (ddSource.ddGroup == "DDGArchiveAcl")
                        HandlerAclGroupGridDrop(ddSource, grids.Copy.store, 'Copy');
                    else
                        HandlerAclGridDrop(ddSource, grids.Copy.store, 'Copy');
                    mask.hide();
                    return true;
                }
            }, this);
            this.CopyGridDropTarget.addToGroup('DDGSend');
            this.CopyGridDropTarget.addToGroup('DDGArchiveCopy');
            this.CopyGridDropTarget.addToGroup('DDGArchiveAcl');
        }
    },

    HandlerAddAcl: function (dataGrid, dsResult, strId) {
        this.InitSelectGrid();
        var id = LeftTabContainer.activeTab.id.split('_')[0];
        var obj = eval("GW." + id);
        var fn = eval("obj.ReturnSourceGrid");

        if (typeof (fn) == 'function') {
            if (id.indexOf("AclArchive") > -1) {
                var grids = eval("obj.ReturnSourceGrid()");
                if (strId.toLowerCase() == "send") {
                    this.CurrentGridSet.Select = grids.Send;
                    if (this.CurrentGridSet.Select.getSelectionModel().getSelections().length == 0) {
                        this.WarningMessageBox(GetResource("SelectSendArchiveMemberMsg"));
                        return false;
                    }
                }
                else if (strId.toLowerCase() == "copy") {
                    this.CurrentGridSet.Select = grids.Copy;
                    if (this.CurrentGridSet.Select.getSelectionModel().getSelections().length == 0) {
                        this.WarningMessageBox(GetResource("SelectCopyArchiveMemberMsg"));
                        return false;
                    }
                }
            }
        }

        if (this.CurrentGridSet.Select == undefined) return;

        var strNoEmailList = "";
        var strOverLapUserList = "";
        var resourceKey = "";

        var aclId = strId.toLowerCase();

        if (aclId == "send")
            resourceKey = "Send";
        else
            resourceKey = "Copy";

        if (this.CurrentGridSet.Select.getSelectionModel().getSelections().length == 0) {
            this.WarningMessageBox(GetResource("SelectOrgMsg"));
            return false;
        }
        Ext.each(this.CurrentGridSet.Select.getSelectionModel().getSelections(), function (record, index, allItems) {
            var aclId = strId.toLowerCase();
            if (dsResult.data.items.length >= 200) {

                var args = new Array();
                if (aclId == "send") {
                    args.push(GetResource("Send"));
                }
                else {
                    args.push(GetResource("Copy"));
                }
                args.push("200");
                this.WarningMessageBox(GetResource("ApproverMaxMsg", args));

                return false;
            }

            if (record.data.EmpID.length == 0) {
                strNoEmailList += record.data.UserName + ', ';
                return true;
            }

            // Email 유일키
            if (!is_overlap) {
                for (var i = 0; i < dsResult.data.length; i++) {
                    if ((dsResult.data.items[i].get("EmpID") == record.data.EmpID)
                    && (dsResult.data.items[i].get("DeptCode") == record.data.DeptCode)) {
                        var foundItem = true;
                        break;
                    }
                }
            }
            else {
                var foundItem = false;
            }

            if (!foundItem) {

                if ($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']') == null) {
                    fn_AddAcl($(AwxXml).find('Histories'), aclId);
                }

                if (record.data.Type == "GROUP") {
                    record.data.DisplayName = record.data.UserName;
                }
                else {
                    record.data.DisplayName = record.data.DeptName + ' ' + record.data.RankName + ' ' + record.data.UserName;
                    //					if(record.data.DutyName != "")
                    //					{
                    //						if(record.data.DutyName == record.data.UserName)
                    //						{
                    //							record.data.DisplayName = record.data.UserName;
                    //						}
                    //						else
                    //						{
                    //							record.data.DisplayName = record.data.DutyName + ' ' + record.data.UserName;
                    //						}
                    //					}
                    //					else
                    //					{
                    //						record.data.DisplayName = record.data.DeptName + ' ' + record.data.RankName + ' ' + record.data.UserName;
                    //					}
                }

                var newRecord = new ApproverRecordACL({
                    EmpID: record.data.EmpID,
                    LoginID: record.data.LoginID,
                    Key: record.data.LoginID + record.data.DeptCode,
                    ADDisplayName: record.data.ADDisplayName,
                    UserName: record.data.UserName,
                    Email: record.data.Email,
                    Type: record.data.Type,
                    DeptCode: record.data.DeptCode,
                    DeptName: record.data.DeptName,
                    CompanyCode: record.data.CompanyCode,
                    CompanyName: record.data.CompanyName,
                    DutyCode: record.data.DutyCode,
                    DutyName: record.data.DutyName,
                    JobName: record.data.JobName,
                    RankName: record.data.RankName,
                    CellPhone: record.data.CellPhone,
                    TeamChiefYN: record.data.TeamChiefYN,
                    ExtensionNumber: record.data.ExtensionNumber,
                    FaxNumber: record.data.FaxNumber,
                    Depth: dsResult.title,
                    TaskId: dsResult.id,
                    Seq: '',
                    Validation: '',
                    Change: '',
                    DisplayName: record.data.DisplayName,
                    SignID: record.data.SignID
                });
                dsResult.add(newRecord);
                //AWX에 결재자 정보 추가
                fn_AddMember($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']'), fn_GetUserInfo(record));
            }
            else {
                if (strOverLapUserList == "")
                    strOverLapUserList = record.data.UserName;
                else
                    strOverLapUserList = strOverLapUserList + ", " + record.data.UserName;
            }
        }, this);

        if (strOverLapUserList != "") {
            var args = new Array();
            args[0] = strOverLapUserList;
            args[1] = GetResource(resourceKey);
            this.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
        }

        if (strNoEmailList.length > 1) {
            this.WarningMessageBox(strNoEmailList + GetResource("NoInfoAddMsg"));
        }

        this.AllSelectionClear();
    },

    HandlerGroupAddAcl: function (dataGrid, dsResult, strId) {
        this.InitSelectGrid();
        var id = LeftTabContainer.activeTab.id.split('_')[0];
        var obj = eval("GW." + id);
        var fn = eval("obj.ReturnSourceGrid");

        if (typeof (fn) == 'function') {
            if (id.indexOf("AclArchive") > -1) {
                var grids = eval("obj.ReturnSourceGrid()");
                this.CurrentGridSet.Select = grids.Acl;
            }
        }

        if (this.CurrentGridSet.Select == undefined) return;

        var strNoEmailList = "";
        var strOverLapUserList = "";
        var resourceKey = "";

        var aclId = strId.toLowerCase();

        if (aclId == "send")
            resourceKey = "Send";
        else
            resourceKey = "Copy";

        if (this.CurrentGridSet.Select.getSelectionModel().getSelections().length == 0) {
            this.WarningMessageBox(GetResource("SelectAclGroupMsg"));
            return false;
        }
        Ext.each(this.CurrentGridSet.Select.getSelectionModel().getSelections(), function (record, index, allItems) {
            var aclId = strId.toLowerCase();

            if (dsResult.data.items.length >= 200) {

                var args = new Array();
                if (aclId == "send") {
                    args.push(GetResource("Send"));
                }
                else {
                    args.push(GetResource("Copy"));
                }
                args.push("200");
                this.WarningMessageBox(GetResource("ApproverMaxMsg", args));

                return false;
            }

            if (record.data.TYPE == "GROUP") {
                var AclLines = record.data.XML_LINE;
                var AclLineInfo = AclLines.split("^");
                var sendEmails = "";
                var copyEmails = "";

                for (var i = 0; i < AclLineInfo.length; i++) {
                    var task_id = AclLineInfo[i].split("*")[0];
                    var userInfo = AclLineInfo[i].split("*")[1];
                    var user_info = fn_CreateUserInfo(userInfo);

                    if (task_id.indexOf("send") > -1) {
                        if (sendEmails == "")
                            sendEmails = user_info.Email;
                        else
                            sendEmails = sendEmails + "; " + user_info.Email;
                    }
                    else if (task_id.indexOf("copy") > -1) {
                        if (copyEmails == "")
                            copyEmails = user_info.Email;
                        else
                            copyEmails = copyEmails + "; " + user_info.Email;
                    }
                }

                if (aclId == "send") {
                    // Email 유일키
                    if (is_overlap) {
                        for (var i = 0; i < dsResult.data.length; i++) {
                            if (dsResult.data.items[i].get("Email") == sendEmails) {
                                var foundItem = true;
                                break;
                            }
                        }
                    }
                    else {
                        var foundItem = false;
                    }

                    //var foundItem = dsResult.find('Email', sendEmails);

                    if (!foundItem) {
                        if ($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']') == null) {
                            fn_AddAcl($(AwxXml).find('Histories'), aclId);
                        }

                        var newRecord = new ApproverRecordACL({
                            EmpID: "",
                            LoginID: "",
                            Key: "",
                            ADDisplayName: record.data.SUBJECT,
                            UserName: record.data.SUBJECT,
                            Email: sendEmails,
                            Type: "",
                            DeptCode: "",
                            DeptName: "",
                            CompanyCode: "",
                            CompanyName: "",
                            DutyCode: "",
                            DutyName: "",
                            JobName: "",
                            RankName: "",
                            CellPhone: "",
                            TeamChiefYN: "",
                            ExtensionNumber: "",
                            FaxNumber: "",
                            Depth: "",
                            TaskId: "",
                            Seq: "",
                            Validation: "",
                            Change: "",
                            DisplayName: record.data.SUBJECT,
                            SignID: ""
                        });
                        dsResult.add(newRecord);
                        //AWX에 결재자 정보 추가
                        fn_AddMember($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']'), fn_GetUserInfo(newRecord));
                    }
                    else {
                        if (strOverLapUserList == "")
                            strOverLapUserList = record.data.SUBJECT;
                        else
                            strOverLapUserList = strOverLapUserList + ", " + record.data.SUBJECT;
                    }
                }
                else if (aclId == "copy") {
                    // Email 유일키
                    if (is_overlap) {
                        for (var i = 0; i < dsResult.data.length; i++) {
                            if (dsResult.data.items[i].get("Email") == copyEmails) {
                                var foundItem = true;
                                break;
                            }
                        }
                    }
                    else {
                        var foundItem = false;
                    }

                    //var foundItem = dsResult.find('Email', copyEmails);

                    if (!foundItem) {
                        if ($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']').length == 0) {
                            fn_AddAcl($(AwxXml).find('Histories'), aclId);
                        }

                        var newRecord = new ApproverRecordACL({
                            EmpID: "",
                            LoginID: "",
                            Key: "",
                            ADDisplayName: record.data.SUBJECT,
                            UserName: record.data.SUBJECT,
                            Email: copyEmails,
                            Type: "",
                            DeptCode: "",
                            DeptName: "",
                            CompanyCode: "",
                            CompanyName: "",
                            DutyCode: "",
                            DutyName: "",
                            JobName: "",
                            RankName: "",
                            CellPhone: "",
                            TeamChiefYN: "",
                            ExtensionNumber: "",
                            FaxNumber: "",
                            Depth: "",
                            TaskId: "",
                            Seq: "",
                            Validation: "",
                            Change: "",
                            DisplayName: record.data.SUBJECT,
                            SignID: ""
                        });
                        dsResult.add(newRecord);
                        //AWX에 결재자 정보 추가
                        fn_AddMember($(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']'), fn_GetUserInfo(newRecord));
                    }
                    else {
                        if (strOverLapUserList == "")
                            strOverLapUserList = record.data.SUBJECT;
                        else
                            strOverLapUserList = strOverLapUserList + ", " + record.data.SUBJECT;
                    }
                }
            }
        }, this);

        if (strOverLapUserList != "") {
            var args = new Array();
            args[0] = strOverLapUserList;
            args[1] = GetResource(resourceKey);
            this.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
        }

        if (strNoEmailList.length > 1) {
            this.WarningMessageBox(strNoEmailList + GetResource("NoInfoAddMsg"));
        }

        this.AllSelectionClear();
    },

    HandlerRemoveAcl: function (dataGrid, dsResult, strId) {
        var aclId = strId.toLowerCase();
        // 수신/참조 노드
        var acl = $(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']')[0];
        if (acl == null) return;

        Ext.each(dataGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
            //AWX에 정보 삭제
            member = $(acl).find('Member[Email = \'' + record.get('Email') + '\']')[0];
            acl.removeChild(member);
            // Record 삭제
            dsResult.remove(record);
        }, this);
        this.AllSelectionClear();
    },

    HandlerUpDownAcl: function (dataGrid, dsResult, strType, strId) {
        if (dataGrid.getSelectionModel().getSelections().length > 1) {
            this.WarningMessageBox(GetResource("OnlyOneSelectMsg"));
            this.AllSelectionClear();
            return;
        }

        var aclId = strId.toLowerCase();
        // 현재 수신/참조 노드 접근
        var acls = $(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']');
        if (acls == null) return;

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

            var currRecord = new ApproverRecordACL({
                EmpID: currRow.data.EmpID,
                LoginID: currRow.data.LoginID,
                //겸직 Patch(09.11.20)
                Key: currRow.data.LoginID + currRow.data.DeptCode,
                ADDisplayName: currRow.data.ADDisplayName,
                UserName: currRow.data.UserName,
                Email: currRow.data.Email,
                Type: currRow.data.Type,
                DeptCode: currRow.data.DeptCode,
                DeptName: currRow.data.DeptName,
                CompanyCode: currRow.data.CompanyCode,
                CompanyName: currRow.data.CompanyName,
                DutyCode: currRow.data.DutyCode,
                DutyName: currRow.data.DutyName,
                JobName: currRow.data.JobName,
                RankName: currRow.data.RankName,
                CellPhone: currRow.data.CellPhone,
                TeamChiefYN: currRow.data.TeamChiefYN,
                ExtensionNumber: currRow.data.ExtensionNumber,
                FaxNumber: currRow.data.FaxNumber,
                Depth: currRow.data.Depth,
                TaskId: currRow.data.TaskId,
                Seq: currRow.data.Seq,
                Validation: currRow.data.Validation,
                Change: currRow.data.Change,
                DisplayName: currRow.data.DisplayName,
                SignID: currRow.data.SignID
            });

            var newRecord = new ApproverRecordACL({
                EmpID: newRow.data.EmpID,
                LoginID: newRow.data.LoginID,
                //겸직 Patch(09.11.20)				
                Key: newRow.data.LoginID + newRow.data.DeptCode,
                ADDisplayName: newRow.data.ADDisplayName,
                UserName: newRow.data.UserName,
                Email: newRow.data.Email,
                Type: newRow.data.Type,
                DeptCode: newRow.data.DeptCode,
                DeptName: newRow.data.DeptName,
                CompanyCode: newRow.data.CompanyCode,
                CompanyName: newRow.data.CompanyName,
                DutyCode: newRow.data.DutyCode,
                DutyName: newRow.data.DutyName,
                JobName: newRow.data.JobName,
                RankName: newRow.data.RankName,
                CellPhone: newRow.data.CellPhone,
                TeamChiefYN: newRow.data.TeamChiefYN,
                ExtensionNumber: newRow.data.ExtensionNumber,
                FaxNumber: newRow.data.FaxNumber,
                Depth: newRow.data.Depth,
                TaskId: newRow.data.TaskId,
                Seq: newRow.data.Seq,
                Validation: newRow.data.Validation,
                Change: newRow.data.Change,
                DisplayName: newRow.data.DisplayName,
                SignID : newRow.data.SignID
            });

            dsResult.remove(currRow);
            dsResult.insert(idx, newRecord);
            dsResult.remove(newRow);
            dsResult.insert(newidx, currRecord);

            //겸직 Patch(09.11.20)
            //var length = acls.childNodes.length;
            var length = acls.children().length;

            for (index = 0; index < length; index++) {
                //var childNode = acls.childNodes.item(index);
                var childNode = acls.children()[index];
                fn_AddAttribute(childNode, "Key", childNode.getAttribute("LoginID") + childNode.getAttribute("DeptCode"));
            }

            //AWX 정보 수정
            //겸직 Patch(09.11.20)
            var curr_acl = $(acls).find('Member[Key = \'' + currRow.data.Key + '\']');

            // 데이터 이동
            if (strType.toLowerCase() == 'up') {
                var new_acl = curr_acl.previousSibling;
            }
            else {
                var new_acl = curr_acl.nextSibling;
            }

            if (strType.toLowerCase() == 'up') {
                curr_acl = acls.removeChild(curr_acl);
                curr_acl = acls.insertBefore(curr_acl, new_acl);
            }
            else {
                curr_acl = acls.removeChild(curr_acl);
                curr_acl = acls.insertBefore(curr_acl, new_acl.nextSibling);
            }

            // 선택된 Row를 바꿈
            if (strType.toLowerCase() == 'up')
                dataGrid.getSelectionModel().selectPrevious();
            else
                dataGrid.getSelectionModel().selectNext();

            //겸직 Patch(09.11.20)
            for (index = 0; index < length; index++) {
                //var childNode = acls.childNodes.item(index);
                var childNode = acls.children()[index];
                childNode.removeAttribute("Key");
            }

        }, this);
    },

    HandlerRemoveAllAcl: function (dataGrid, dsResult, strId) {
        var aclId = strId.toLowerCase();
        // 수신/참조 노드
        var acl = $(AwxXml).find('Histories Acl[Type=\'' + aclId + '\']');
        if (acl == null) return;
        dsResult.removeAll();
        //AWX 정보 삭제
        acl.find("Member").each(function () {
            $(this).remove(); 
        });

        this.AllSelectionClear();
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
                this.HandlerAddAcl(dataGrid, dsResult, strId);
                break;

            case 'AddGroup':
                this.HandlerGroupAddAcl(dataGrid, dsResult, strId);
                break;

            case 'Remove':
                if (dataGrid.getSelectionModel().getSelections().length > 0)
                    this.HandlerRemoveAcl(dataGrid, dsResult, strId);
                break;

            case 'Up':
            case 'Down':
                if (dataGrid.getSelectionModel().getSelections().length > 0)
                    this.HandlerUpDownAcl(dataGrid, dsResult, strType, strId);
                break;

            case 'RemoveAll':
                if (dsResult.getCount() > 0)
                    this.HandlerRemoveAllAcl(dataGrid, dsResult, strId);
                break;
        }
        mask.hide();
    },

    InitSelectGrid: function () {
        var id = LeftTabContainer.activeTab.id.split('_')[0];
        var obj = eval("GW." + id);
        var fn = eval("obj.ReturnSourceGrid");

        if (typeof (fn) == 'function') {
            if (id.indexOf("AclArchive") == -1 && this.CurrentGridSet.Select == undefined) {
                this.CurrentGridSet.Select = eval("obj.ReturnSourceGrid()");
            }
        }
    },

    AllSelectionClear: function () {
        if (this.CurrentGridSet) {

            if (this.CurrentGridSet.Select == null) this.InitSelectGrid();

            var id = LeftTabContainer.activeTab.id.split('_')[0];
            var obj = eval("GW." + id);
            var fn = eval("obj.ReturnSourceGrid");

            if (typeof (fn) == 'function') {
                if (id.indexOf("AclArchive") > -1) {
                    var grids = eval("obj.ReturnSourceGrid()");
                    grids.Send.getSelectionModel().clearSelections();
                    var sHeader = grids.Send.getView().getHeaderCell(0).childNodes[0];
                    Ext.get(sHeader).removeClass('x-grid3-hd-checker-on');
                    grids.Copy.getSelectionModel().clearSelections();
                    var cHeader = grids.Copy.getView().getHeaderCell(0).childNodes[0];
                    Ext.get(cHeader).removeClass('x-grid3-hd-checker-on');
                    grids.Acl.getSelectionModel().clearSelections();
                    var aHeader = grids.Acl.getView().getHeaderCell(0).childNodes[0];
                    Ext.get(aHeader).removeClass('x-grid3-hd-checker-on');
                }
                else {
                    this.CurrentGridSet.Select.getSelectionModel().clearSelections();
                    var selectHeader = this.CurrentGridSet.Select.getView().getHeaderCell(0).childNodes[0];
                    Ext.get(selectHeader).removeClass('x-grid3-hd-checker-on');
                }
            }

            if (is_send) {
                this.CurrentGridSet.Send.getSelectionModel().clearSelections();
                var sendrHeader = this.CurrentGridSet.Send.getView().getHeaderCell(0).childNodes[0];
                Ext.get(sendrHeader).removeClass('x-grid3-hd-checker-on');
            }
            if (is_copy) {
                this.CurrentGridSet.Copy.getSelectionModel().clearSelections();
                var copyHeader = this.CurrentGridSet.Copy.getView().getHeaderCell(0).childNodes[0];
                Ext.get(copyHeader).removeClass('x-grid3-hd-checker-on');
            }
        }
    }
});

//GW.Acl = new GW.SetLine.Acl();
