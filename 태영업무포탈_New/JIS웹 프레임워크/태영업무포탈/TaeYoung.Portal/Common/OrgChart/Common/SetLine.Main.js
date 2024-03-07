/*
* SetLine.Main.js
* 결재선 지정창 메인
*/
GW.SetLine.Main = function () {
    // 다국어 처리를 위한 Global Ajax Parameter 정의
    //Ext.Ajax.extraParams = { 'langCode' : g_langCode };
    Ext.Ajax.timeout = 60000;
    GW.SetLine.Main.superclass.constructor.call(this);
    Ext.QuickTips.init();
    Ext.apply(Ext.QuickTips.getQuickTip(), {
        //trackMouse: true,
        showDelay: 700,
        dismissDelay: 0
    });

    if (Ext.get('loading') != null) {
        if (Ext.get('loading').dom.innerHTML == "") {
            Ext.get('loading').dom.innerHTML = "<div class='loading-indicator'><img src='common/ext/resources/images/default/shared/blue-loading.gif' onload='MoveCenterLoadMask();' width='32' height='32' style='margin-right:8px;' align='absmiddle'/>" + GetResource('LoadingMsg') + "<div>";
        }
    }

    GW.Org.GetInitialize
    (
	    function () {
	        GW.Org.Render();
	        this.InitTab();
	        this.RenderContents();
	        this.FadeOutMainLoadMask();
	    }
    , this
    );
};

Ext.extend(GW.SetLine.Main, GW.SetLine.Common, {

    InitTab: function () {
        var leftTabNodes = $(FormXml).find("select")[0];
        var rightTabNodes = $(FormXml).find("ui[seq='" + app_seq + "']")[0];

        LeftTabContainer = this.GetLeftTabContainer(leftTabNodes, leftWidth, pHeight);
        RightTabContainer = this.GetRightTabContainer(rightTabNodes, rightWidth, pHeight);

        LeftTabContainer.on('tabchange', function (thistab, tab) {
            if (thistab.activeTab.id.split("_")[0].indexOf("AclArchive") > -1) {
                var AclList = RightTabContainer.getItem("Acl_tab02");
                RightTabContainer.activate(AclList);
            }
            else if (thistab.activeTab.id.split("_")[0].indexOf("AppArchive") > -1) {
                var ArchiveList = RightTabContainer.getItem("ApproverAgree_tab01");
                RightTabContainer.activate(ArchiveList);
            }
        }, this);
    },

    GetLeftTabContainer: function (tabsNode, width, height) {

        var tabs = new Ext.TabPanel({
            activeTab: 0,
            width: parseInt(width),
            height: parseInt(height)
        });

        if (tabsNode == null) return;

        var tabNodes = $(tabsNode).find("tab");

        for (var i = 0; i < tabNodes.length; i++) {
            var src = tabNodes[i].getAttribute("src");
            var objKey = src.substring(src.lastIndexOf('/') + 1, src.lastIndexOf('.'));

            switch (objKey.toLowerCase()) {
                case "org":
                    objKey = "Org";
                    break;

                case "myline":
                    //is_word ? objKey = "AppArchiveWord" : objKey = "AppArchive";
                    objKey = "AppArchive";
                    break;

                case "lobchargerlist":
                    objKey = "ClxCharger";
                    break;

                case "aclarchive":
                    //is_word ? objKey = "AclArchiveWord" : objKey = "AclArchive";
                    objKey = "AclArchive";
                    break;
            }

            try {
                var obj = eval("GW." + objKey + ".ReturnPanel");

                tabs.add({
                    id: objKey + "_" + tabNodes[i].getAttribute("id"),
                    title: $(tabNodes[i]).find("tbtitle")[0].textContent,
                    items: obj,
                    layout: 'fit'
                })
            }
            catch (e) {
                tabs.add({
                    id: tabNodes[i].getAttribute("id"),
                    title: $(tabNodes[i]).find("tbtitle")[0].textContent,
                    layout: 'fit'
                })
            }
        }
        return tabs;
    },

    GetRightTabContainer: function (tabsNode, width, height) {
        var tabs = new Ext.TabPanel({
            activeTab: 0,
            width: parseInt(width),
            height: parseInt(height)
        });

        if (tabsNode == null) return;

        var tabNodes = $(tabsNode).find(">tab"); // $(tabsNode).find("tab");
        for (var i = 0; i < tabNodes.length; i++) {
            var objKey = tabNodes[i].getAttribute("type");

            switch (objKey.toLowerCase()) {
                case "approveragree":
                    objKey = "ApproverAgree";
                    break;

                case "charge":
                    objKey = "Charge";
                    break;

                case "chargeagree":
                    objKey = "ChargeAgree";
                    break;

                case "acl":
                    objKey = "Acl";
                    break;

                case "receive":
                    objKey = "Receive";
                    break;
            }

            try {
                var obj = eval("GW." + objKey + ".ReturnPanel");

                tabs.add({
                    id: objKey + "_" + tabNodes[i].getAttribute("id"),
                    title: $(tabNodes[i]).find("tbtitle")[0].textContent,
                    items: obj,
                    layout: 'fit'
                })
            }
            catch (e) {
                tabs.add({
                    id: tabNodes[i].getAttribute("id"),
                    title: $(tabNodes[i]).find("tbtitle")[0].textContent,
                    layout: 'fit'
                })
            }
        }

        return tabs;
    },

    RenderContents: function () {
        var body = Ext.getBody();
        var padding = document.createElement('div');
        padding.id = 'padding';
        body.appendChild(padding);

        var mainPanel = new Ext.Panel
		({
		    id: 'mainPanel',
		    layout: 'border',
		    region: 'north',
		    border: false,
		    height: pHeight + 5,
		    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
		    items:
			[{
			    region: 'north',
			    border: false,
			    applyTo: 'padding',
			    height: 5
			}
			,
			{
			    region: 'west',
			    border: false,
			    bodyStyle: 'padding-left:5px; padding-right:1px;',
			    width: leftWidth + 10,
			    items: LeftTabContainer
			}
			,
			{
			    region: 'center',
			    border: false,
			    bodyStyle: 'padding-right:5px;',
			    width: rightWidth,
			    items: RightTabContainer
			}]
		});

        var viewport = new Ext.Viewport
		({
		    layout: 'border',
		    style: 'background: #FFFFFF none repeat scroll 0 0;',
		    items:
		    [
			mainPanel
			,
		    {
		        region: 'center',
		        border: false,
		        buttons: [
				{
				    text: GetResource('OkBtn'),
				    handler: this.OnConfirm,
				    scope: this
				},
				{
				    text: GetResource('CancelBtn'),
				    handler: this.OnCancel,
				    scope: this
				}],
		        buttonAlign: 'center'

		    }]
		    //		    items: [
		    //			{
		    //			    region: 'north',
		    //			    border: false,
		    //			    applyTo: 'padding',
		    //			    height: 5
		    //			}
		    //			,
		    //			{
		    //			    region: 'west',
		    //			    border: false,
		    //			    bodyStyle: 'padding-left:5px; padding-right:1px;',
		    //			    width: leftWidth+10,
		    //			    items: LeftTabContainer
		    //			}
		    //			,
		    //			{
		    //			    region: 'center',
		    //			    border: true,
		    //			    bodyStyle: 'padding-right:5px;',
		    //			    width: rightWidth,
		    //			    items: RightTabContainer
		    //			}
		    //			,
		    //			{
		    //			    region: 'south',
		    //			    border: true,
		    ////			    collapsible: false,
		    ////			    split: false,
		    ////			    height: 30,
		    ////			    minHeight: 15,
		    //			    buttons: [
		    //				{
		    //				    text: GetResource('OkBtn'),
		    //				    handler: this.OnConfirm,
		    //				    scope: this
		    //				},
		    //				{
		    //				    text: GetResource('CancelBtn'),
		    //				    handler: this.OnCancel,
		    //				    scope: this
		    //				}],
		    //			    buttonAlign: 'center'
		    //			}
		    //			]
		});
    },

    ValidationCheck: function () {

        //기본결재자
        var Approver = GW.ApproverAgree.ApproverResult;

        //        if (is_word) {
        //            if (Approver != undefined && Approver != null) {
        //                for (var i = 0; i < Approver.data.items.length; i++) {
        //                    if (Approver.data.items[i].get("TaskId") != undefined && Approver.data.items[i].get("TaskId") != "") {
        //                        if (Approver.data.items[i].get('TaskId') == "emp0" || Approver.data.items[i].get('TaskId') == "app0") {
        //                            if (Approver.data.items[i].get('LoginID') == null || Approver.data.items[i].get('LoginID') == "" || Approver.data.items[i].get('LoginID') == undefined) {
        //                                if (Approver.data.items[i].get('TaskId') == "emp0") {
        //                                    this.WarningMessageBox(GetResource("AppointApprovalMustAppointWriter"));
        //                                }
        //                                else if (Approver.data.items[i].get('TaskId') == "app0") {
        //                                    this.WarningMessageBox(GetResource("AppointApprovalMustAppointApprover"));
        //                                }
        //                                return false;
        //                            }
        //                        }
        //                    }

        //                    if (i > 0 && i < Approver.data.items.length - 1) {
        //                        var next_task_id = Approver.data.items[i + 1].get('TaskId');
        //                        var next_name = Approver.data.items[i + 1].get('LoginID');
        //                        var curr_task_id = Approver.data.items[i].get('TaskId');
        //                        var curr_name = Approver.data.items[i].get('LoginID');

        //                        if (curr_task_id.indexOf("r") == 0 && (curr_name != "" && curr_name != undefined && curr_name != null) && next_task_id.indexOf("r") == 0 && (next_name == "" || next_name == undefined || next_name == null)) {
        //                            this.WarningMessageBox(GetResource("AppointApprovalMustAppointSequence"));
        //                            return false;
        //                        }
        //                    }
        //                }
        //            }
        //        }
        //        else 
        {
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

                var history_node = $(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0];
                for (var i = 0; i < history_node.childNodes.length; i++) {
                    if (history_node.childNodes[i].nodeName == "Agree") {
                        var agree_node = $(history_node.childNodes[i]).find('[Ref="before"]');
                        if (agree_node.length > 0) {
                            if (agree_node[0].childNodes.length > 0 && is_exa == false) {
                                //검토전 협조를 지정하면 검토자가 지정되어야 합니다.
                                this.WarningMessageBox(GetResource("ArchiveValidationExaMsg"));
                                return false;
                            }
                        }
                    }
                }
            }

            //기본결재 승인자
            if (GW.ApproverAgree.CRowCount > 0) {
                var Charge = GW.ApproverAgree.ChargeResult;

                for (var i = 0; i < Charge.data.items.length; i++) {
                    is_validation = Charge.data.items[i].get("Validation");

                    if (is_validation == "true") {
                        if (Charge.data.items[i].get('LoginID') == null || Charge.data.items[i].get('LoginID') == "" || Charge.data.items[i].get('LoginID') == undefined) {
                            this.WarningMessageBox(GetResource("ValidationCheck", Charge.data.items[i].get('Depth')));
                            return false;
                        }
                    }

                    if (i > 0 && i < Approver.data.items.length - 1) {
                        var next_task_id = Charge.data.items[i + 1].get('TaskId');
                        var next_name = Charge.data.items[i + 1].get('LoginID');
                        var curr_task_id = Charge.data.items[i].get('TaskId');
                        var curr_name = Charge.data.items[i].get('LoginID');

                        if (curr_task_id.indexOf("r") == 0 && (curr_name != "" && curr_name != undefined && curr_name != null)) is_exa = true;

                        if (curr_task_id.indexOf("r") == 0 && (curr_name != "" && curr_name != undefined && curr_name != null) && next_task_id.indexOf("r") == 0 && (next_name == "" || next_name == undefined || next_name == null)) {
                            this.WarningMessageBox(GetResource("AppointApprovalMustAppointSequence"));
                            return false;
                        }
                    }
                }
            }

            //담당자
            var Charger = GW.Charge.ChargeResult;

            if (Charger != undefined && Charger != null) {
                for (var i = 0; i < Charger.data.items.length; i++) {
                    is_validation = Charger.data.items[i].get("Validation");

                    if (is_validation == "true") {
                        if (Charger.data.items[i].get('LoginID') == null || Charger.data.items[i].get('LoginID') == "" || Charger.data.items[i].get('LoginID') == undefined) {
                            this.WarningMessageBox(GetResource("ValidationCheck", Charger.data.items[i].get('Depth')));
                            return false;
                        }
                    }

                    if (i > 0 && i < Charger.data.items.length - 1) {
                        var next_task_id = Charger.data.items[i + 1].get('TaskId');
                        var next_name = Charger.data.items[i + 1].get('LoginID');
                        var curr_task_id = Charger.data.items[i].get('TaskId');
                        var curr_name = Charger.data.items[i].get('LoginID');

                        if (curr_task_id.indexOf("r") == 0 && (curr_name != "" && curr_name != undefined && curr_name != null) && next_task_id.indexOf("r") == 0 && (next_name == "" || next_name == undefined || next_name == null)) {
                            this.WarningMessageBox(GetResource("AppointApprovalMustAppointSequence"));
                            return false;
                        }
                    }
                }
            }

            var dept_name = "";
            var rank_name = "";
            var duty_name = "";
            var user_name = "";
            var user_info = "";
            var job_name = "";

            //팀장 정보 반영 (1단결재 최종승인자)
            //결재선 지정을 하는 사람이 기안자(emp0)일 경우에만 팀리더 정보를 업데이트 한다.
            if ($(AwxXml).find("CurrentUser")[0].attributes.getNamedItem("TaskID").value == "emp0") {
                var leader_node = $(AwxXml).find("Histories History[Seq=0] Approver[TaskID = 'app0']")[0];
                if (leader_node != null) {
                    dept_name = leader_node.getAttribute("DeptName");
                    rank_name = leader_node.getAttribute("RankName");
                    user_name = leader_node.getAttribute("UserName");
                    job_name = leader_node.getAttribute("JobName");
                    user_info = (dept_name = "" ? "" : dept_name + " ") + (rank_name = "" ? "" : rank_name + " ") + user_name;
                }
            }

            //수신처 값이 있으면 Awx에 반영
            var send_node = $(AwxXml).find("Histories Acl[Type='send']")[0];
            if (send_node != null) {
                if (send_node.childNodes.length > 1) {
                    $(AwxXml).find("Fields")[0].attributes.getNamedItem("Separate").value = GetResource("SendReference");
                }
                else if (send_node.childNodes.length == 1) {
                    is_chief = send_node.childNodes[0].getAttribute("TeamChiefYN");
                    rank_name = send_node.childNodes[0].getAttribute("RankName");
                    duty_name = send_node.childNodes[0].getAttribute("DutyName");
                    user_name = send_node.childNodes[0].getAttribute("UserName");
                    job_name = send_node.childNodes[0].getAttribute("JobName");
                    dept_name = send_node.childNodes[0].getAttribute("DeptName");

                    user_info = (dept_name = "" ? "" : dept_name + " ") + (rank_name = "" ? "" : rank_name + " ") + user_name;

                    $(AwxXml).find("Fields")[0].attributes.getNamedItem("Separate").value = user_info;
                }
            }
        }

        return true;
    },
    // 확인
    OnConfirm: function () {
        if (this.ValidationCheck()) {
            if (window.dialogArguments) {
                try { window.dialogArguments.window.document.all['AuthorDept'].innerText = $(AwxXml).find("Histories History[Seq='0'] Approver[TaskID='emp0'] DeptName")[0].text; } catch (e) { }
                window.dialogArguments.awx = Awx;
                window.dialogArguments.return_value = true;
                window.close();
            }
            if (parent.opener) {
                try { parent.opener.window.document.all['AuthorDept'].innerText = $(AwxXml).find("Histories History[Seq='0'] Approver[TaskID='emp0'] DeptName")[0].text; } catch (e) { }
                parent.opener.args.awx = new XMLSerializer().serializeToString(Awx);
                parent.opener.args.return_value = true;
                if (parent.opener.args.Command == undefined || parent.opener.args.Command == "setline") {
                    parent.opener.on_setline_selected();
                }
                else if (parent.opener.args.Command == "changeline") {
                    parent.opener.on_changeline_selected();
                }
                else if (parent.opener.args.Command == "changeworker") {
                    parent.opener.on_changeworker_selected();
                }

                if (parent.opener.SetLineCallBack) {
                    parent.opener.SetLineCallBack();
                }

                parent.window.close();
            }
        }
    },
    // 닫기
    OnCancel: function () {
        if (parent.opener) {
            parent.opener.args.return_value = null;
            //parent.opener.args.awx
            parent.opener.on_setline_selected();

            if (parent.opener.SetLineCallBack) {
                parent.opener.SetLineCallBack();
            }

            parent.window.close();
        }
    }

});
