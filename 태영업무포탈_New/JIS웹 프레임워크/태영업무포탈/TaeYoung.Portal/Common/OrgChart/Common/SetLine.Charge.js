/*
* GW.SetLine.Charge.js
* 결재자/협조자
*/
GW.SetLine.Charge = function() {
    //GW.SetLine.Charge.superclass.constructor.call(this);
	if(chargelistNodes == null || chargelistNodes == undefined) return false;
	
    // 담당자
    this.ChargeResult = new Ext.data.JsonStore
	({
	    id: 'C101',
	    fields: APPDataFields
	});

    this.ChargeGridDropTarget = null;

    this.ReturnPanel = null;
	this.RowCount = null;
	
	this.InitGirdRows();
    this.CurrentGridSet = this.InitGird();

    this.Render();
    this.LoadAwx();
    
    this.CurrentGridSet.Charge.on('dblclick', function() { this.HandlerRemoveCharge(this.CurrentGridSet.Charge, this.ChargeResult) }, this);
	this.CurrentGridSet.Charge.on('render', function() { this.DragDropSetting(); }, this);
};

Ext.extend(GW.SetLine.Charge, GW.SetLine.Common, {

	On_Charge_DbClickItem : function(record, index, allItems)
	{
		this.On_AddCharge_DbClickItem_Handle(record, index, allItems);
	},
	
	On_AddCharge_DbClickItem_Handle : function(record, index, allItems)
	{
		var dataGrid = this.CurrentGridSet.Charge;
		var dsResult = this.ChargeResult;
		
		this.HandlerAddCharge(dataGrid, dsResult);
		this.AllSelectionClear();
	},
	
    LoadArchive: function() {
        //그리드 리셋
		this.ChargeResult.removeAll(); 
        this.InitGirdRows();
        this.LoadAwx();
    },

	LoadAwx : function() {
		var app_node = $(AwxXml).find('Histories History');
		var dsCharge = this.ChargeResult;
		
		for(var k=0; k< app_node.length; k++)
		{
		    var history_node = $(AwxXml).find('Histories History[Seq=' + k + ']')[0];

		    if(history_node != null)
		    {
			    //기본결재, 협조 바인딩.
			    for(var i=0; i< history_node.childNodes.length; i++)
			    {
				    switch (history_node.childNodes[i].nodeName)
				    {
					    case "Approver" :
					    
							var task_id = history_node.childNodes[i].getAttribute("TaskID");
						    // 기본결재
						    if($(AwxXml).find('Histories History[Seq=' + app_seq + ']')[0] == null)
						    {
							    fn_AddHistory($(AwxXml).find('Histories')[0], app_seq);
						    }

							var foundItem = dsCharge.find('TaskId', task_id);
							if(foundItem != -1)
							{
								dsCharge.data.items[foundItem].set('EmpID' , history_node.childNodes[i].getAttribute("EmpID"));
								dsCharge.data.items[foundItem].set('LoginID' , history_node.childNodes[i].getAttribute("LoginID"));
								dsCharge.data.items[foundItem].set('ADDisplayName' , history_node.childNodes[i].getAttribute("UserName") + "(" + history_node.childNodes[i].getAttribute("LoginID") + ")/" + history_node.childNodes[i].getAttribute("DeptName"));
								dsCharge.data.items[foundItem].set('UserName' , history_node.childNodes[i].getAttribute("UserName"));
								dsCharge.data.items[foundItem].set('Email' , history_node.childNodes[i].getAttribute("Email"));
								dsCharge.data.items[foundItem].set('Type' , 'USER');
								dsCharge.data.items[foundItem].set('DeptCode' , history_node.childNodes[i].getAttribute("DeptCode"));
								dsCharge.data.items[foundItem].set('DeptName' , history_node.childNodes[i].getAttribute("DeptName"));
								dsCharge.data.items[foundItem].set('CompanyName' , 'SK');
								dsCharge.data.items[foundItem].set('DutyCode' , history_node.childNodes[i].getAttribute("DutyCode"));
								dsCharge.data.items[foundItem].set('DutyName' , history_node.childNodes[i].getAttribute("DutyName"));
								dsCharge.data.items[foundItem].set('JobName' , history_node.childNodes[i].getAttribute("JobName"));
								dsCharge.data.items[foundItem].set('RankName' , history_node.childNodes[i].getAttribute("RankName"));
								dsCharge.data.items[foundItem].set('CellPhone' , history_node.childNodes[i].getAttribute("CellPhone"));
								dsCharge.data.items[foundItem].set('TeamChiefYN' , history_node.childNodes[i].getAttribute("TeamChiefYN"));
								dsCharge.data.items[foundItem].set('ExtensionNumber' , history_node.childNodes[i].getAttribute("ExtensionNumber"));
								dsCharge.data.items[foundItem].set('FaxNumber' , history_node.childNodes[i].getAttribute("FaxNumber"));
								dsCharge.data.items[foundItem].set('TaskId' , task_id);
								
								if(history_node.childNodes[i].getAttribute("Status") != "")
								{
									//TO DO : Row disable 처리
									dsCharge.data.items[foundItem].set('Change' , "false");
								}
								dsCharge.data.items[foundItem].commit();
							}
						    break;
				    }
			    }
		    }
		}
	},
	
    InitGirdRows: function() {
		for(var i=0; i<chargelistNodes.length; i++)
		{
			var listId = chargelistNodes[i].getAttribute("id");
			var listType = chargelistNodes[i].getAttribute("type");

			if(listType == "normal")
			{
				var itemNodes = $(chargelistNodes[i]).find("ritem");
				this.RowCount = itemNodes.length;
				
				for(var j=0; j<itemNodes.length; j++)
				{
					if(listId == "charge")
					{
						this.ChargeResult.add(new ApproverRecord({ EmpID: "", LoginID: "", ADDisplayName: "", UserName: "", Email: "", Type: "", DeptCode: "", DeptName: "", CompanyName: "", DutyCode: "", DutyName: "", JobName: "", RankName: "", CellPhone: "", TeamChiefYN: "", ExtensionNumber: "", FaxNumber: "", Depth: itemNodes[j].textContent, TaskId: itemNodes[j].getAttribute("id"), Seq: itemNodes[j].getAttribute("seq"), Validation: itemNodes[j].getAttribute("validation"), Change: itemNodes[j].getAttribute("change")}));
					}
				}
			}
		}
    },

	DragDropSetting: function() {
        this.InitSelectGrid();
        var grids = this.CurrentGridSet;
        this.CurrentGridSet.Charge.view.mainBody.on('mouseup', function(e, t) {
            index = this.CurrentGridSet.Charge.getView().findRowIndex(t);
            if (this.ChargeGridDropTarget.DDM.dragCurrent != null) {
                if (this.ChargeGridDropTarget.DDM.dragCurrent.dragData.selections.length == 1) {
                    this.CurrentGridSet.Charge.getSelectionModel().selectRow(index, false);
                }
            }
        }
		, this);

        function HandlerChargeGridDrop(ddSource, dsResult) {
            var strNoEmpIDUserList = "";
            var cnt = 0;
			var isGroup = false;
			
            Ext.each(ddSource.dragData.selections, function(record, index, allItems) {
				if(record.data.Type != "GROUP")
				{
					if (record.data.EmpID.length == 0) {
						strNoEmpIDUserList += record.data.UserName + ', ';
						return true;
					}
					
					// EmpId 유일키
					if(is_overlap)
						var foundItem = dsResult.store.find('EmpID', record.data.EmpID);
					else
						var foundItem = -1;
						
					if (foundItem == -1) {
						// 기본결재라인
						if (dsResult.getSelectionModel().getSelections().length > 0) {
							// Row가 선택되었을때
							Ext.each(dsResult.getSelectionModel().getSelections(), function(trecord, tindex, tallItems) {

								if(trecord.get('Change') == "false")
								{
									GW.Common.WarningMessageBox(GetResource("ImpossibleChange", trecord.get('Depth')));
									return;
								}
								
								var history = $(AwxXml).find('Histories History[Seq = ' + trecord.get('Seq') + ']')[0];
								if(history == null) history = fn_AddHistory($(AwxXml).find('Histories')[0], trecord.get('Seq'));
								// 현재 member 노드 접근
								var approver = $(history).find('Approver[TaskID = \'' + trecord.get('TaskId') + '\']')[0];
								if(approver != null)
								{
									var status = approver.getAttribute("Status");
									
									if(status != "")
									{
										GW.Common.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
										return;
									}
									
									history.removeChild(approver);
								}
								
								if(record.data.DutyName == "")
								{
									if(trecord.get("TaskId").indexOf('app') > -1)
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
									CompanyName: record.data.CompanyName,
									DutyCode: record.data.DutyCode,
									DutyName: record.data.DutyName,
									JobName: record.data.JobName,
									RankName: record.data.RankName,
									CellPhone: record.data.CellPhone,
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
								if(dsResult.store.data.items[j].get('Change') != "false")
								{
									var history = $(AwxXml).find('Histories History[Seq = ' + dsResult.store.data.items[j].get('Seq') + ']')[0];
									if(history == null) history = fn_AddHistory($(AwxXml).find('Histories')[0], dsResult.store.data.items[j].get('Seq'));
									
									if (dsResult.store.data.items[j].data.EmpID == undefined || dsResult.store.data.items[j].data.EmpID == "") {
										
										var approver = $(history).find('Approver[TaskID = \'' + dsResult.store.data.items[j].get('TaskId') + '\']')[0];
										
										if(approver != null)
										{
											var status = approver.getAttribute("Status");
											
											if(status != "")
											{
												GW.Common.WarningMsgBox(GetResource("ApproverCompleteNoChangeMsg"));
												return;
											}
											history.removeChild(approver);
										}
										
										if(record.data.DutyName == "")
										{
											if(dsResult.store.data.items[j].data.TaskId.indexOf('app') > -1)
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
											CompanyName: record.data.CompanyName,
											DutyCode: record.data.DutyCode,
											DutyName: record.data.DutyName,
											JobName: record.data.JobName,
											RankName: record.data.RankName,
											CellPhone: record.data.CellPhone,
											TeamChiefYN: record.data.TeamChiefYN,
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
					else
					{
						var args = new Array();
						args[0] = record.get("UserName");
						args[1] = dsResult.store.data.items[foundItem].get("Depth");
						GW.Charge.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
					}
				}
				else
				{
					isGroup = true;
				}
            }, this);

			if(isGroup)
			{
				GW.Charge.WarningMessageBox(GetResource("ApproverNotSetGroupMsg"));
			}
			
            if (strNoEmpIDUserList.length > 1) {
                GW.Charge.WarningMessageBox(strNoEmpIDUserList + GetResource("NoInfoAddMsg"));
            }
            GW.Charge.AllSelectionClear();
        }

        var ChargeGridDropTargetEl = grids.Charge.getView().el.dom.childNodes[0].childNodes[1];
        this.ChargeGridDropTarget = new Ext.dd.DropTarget(ChargeGridDropTargetEl, {
            ddGroup: 'DDGSelect',
            notifyDrop: function(ddSource, e, data) {
                var mask = new Ext.LoadMask(grids.Charge.getView().el, { msg: GetResource("WaitMsg") });
                mask.show();
				HandlerChargeGridDrop(ddSource, grids.Charge);
                mask.hide();
            }
        }, this);
    },
    
    InitGird: function() {
        // 담당자
        var ChargeGridCheckBox = new Ext.grid.CheckboxSelectionModel({ singleSelect: true });
        var ChargeResultCM = new Ext.grid.ColumnModel
		([
			{ header: GetResource("LevelTitle"), dataIndex: 'Depth', width: 40, fixed: true, menuDisabled: true, resizable: false, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserDuty"), dataIndex: 'DutyName', width: 45, renderer: this.RendererWithTooltip },
            { header: GetResource("UserRank"), dataIndex: 'RankName', width: 45, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 60, renderer: this.RendererUserName.createDelegate(this) },
            { header: GetResource("UserJob"), dataIndex: 'JobName', width: 130, renderer: this.RendererWithTooltip }
		]);

		if(Ext.isIE6)
		{
			var tmpHeight = 76;
			tmpHeight = tmpHeight + (this.RowCount * 22);
		}
		else
		{
			var tmpHeight = 74;

			if(g_langCode != "zh")
				tmpHeight = tmpHeight + (this.RowCount * 24);
			else
				tmpHeight = tmpHeight + (this.RowCount * 25);
		}

        var ChargeResultGrid = new Ext.grid.GridPanel
		({
			region: 'north',
			margins: '5 5 5 5',
		    ddGroup: 'DDGCharge',
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
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip" , GetResource("Approver")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function() {
				        this.OnButtonClick('Add', 'Charge')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip" , GetResource("Approver")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function() {
				        this.OnButtonClick('Remove', 'Charge')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip" , GetResource("Approver")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function() {
				        this.OnButtonClick('RemoveAll', 'Charge')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip" , GetResource("Approver")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function() {
				        this.OnButtonClick('Up', 'Charge')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip" , GetResource("Approver")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function() {
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
		    Charge: ChargeResultGrid
		};

        return gridSet;
    },

    Render: function() {
    
		//타이틀 변경
		var tabsNode = $(FormXml).find("ui[seq='" + app_seq + "']")[0];

		if(tabsNode != null)
		{
			var tabNodes = $(tabsNode).find("tab");
		
			for(var i=0; i<tabNodes.length; i++)
			{
				var objKey = tabNodes[i].getAttribute("type");
				if(objKey == "charge")
				{
					var listNode = $(tabNodes[i]).find("list[id='charge']")[0];
					
					if(listNode != null)
					{
					    var title = $(listNode).find("lstitle")[0].textContent;
						this.CurrentGridSet.Charge.setTitle(title);
					}
					break;
				}
			}
		}
		
        this.ReturnPanel = new Ext.Panel
		({
		    id: 'Charge',
		    layout: 'border',
		    border: false,
		    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
		    items: 
		    [ 
		    this.CurrentGridSet.Charge
		    ,
		    {
			    region: 'center',
			    border: false
		    }
		    ]
		});
    },

    HandlerAddCharge: function(dataGrid, dsResult) {
        this.InitSelectGrid();
        var strNoEmpIDUserList = "";
        var cnt = 0;
		var isGroup = false;
		 
		if(this.CurrentGridSet.Select.getSelectionModel().getSelections().length == 0)
		{
			this.WarningMessageBox(GetResource("SelectOrgMsg"));
			return false;		
		} 
        Ext.each(this.CurrentGridSet.Select.getSelectionModel().getSelections(), function(record, index, allItems) {
       		if(record.data.Type != "GROUP")
       		{
				if (record.data.EmpID.length == 0) {
					strNoEmpIDUserList += record.data.UserName + ', ';
					return true;
				}

				if (dataGrid.getSelectionModel().getSelections().length > 0 && allItems.length > 1) {
					this.WarningMessageBox(GetResource("OnlyOneSelectMsg"));
					return false;
				}
				// EmpId 유일키
				if(is_overlap)
					var foundItem = dsResult.find('EmpID', record.data.EmpID);
				else
					var foundItem = -1;
					
				if (foundItem == -1) {
					// 기본결재라인
					if (dataGrid.getSelectionModel().getSelections().length > 0) {
						// Row가 선택되었을때
						Ext.each(dataGrid.getSelectionModel().getSelections(), function(trecord, tindex, tallItems) {
						
							if(trecord.get('Change') == "false")
							{
								this.WarningMessageBox(GetResource("ImpossibleChange", trecord.get('Depth')));
								return;
							}
							
							var history = $(AwxXml).find('Histories History[Seq = ' + trecord.get('Seq') + ']')[0];
							if(history == null) history = fn_AddHistory($(AwxXml).find('Histories')[0], trecord.get('Seq'));
				
							// 현재 member 노드 접근
							var approver = $(history).find('Approver[TaskID = \'' + trecord.get('TaskId') + '\']')[0];
							if(approver != null)
							{
								var status = approver.getAttribute("Status");
								
								if(status != "")
								{
									this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
									return;
								}
								
								history.removeChild(approver);
							}
							
							if(record.data.DutyName == "")
							{
								if(trecord.get("TaskId").indexOf('app') > -1)
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
								CompanyName: record.data.CompanyName,
								DutyCode: record.data.DutyCode,
								DutyName: record.data.DutyName,
								JobName: record.data.JobName,
								RankName: record.data.RankName,
								CellPhone: record.data.CellPhone,
								TeamChiefYN: record.data.TeamChiefYN,
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
						
							if(dsResult.data.items[j].get('Change') != "false")
							{
								if (dsResult.data.items[j].data.EmpID == undefined || dsResult.data.items[j].data.EmpID == "") {
		
									var history = $(AwxXml).find('Histories History[Seq = ' + dsResult.data.items[j].get('Seq') + ']')[0];
									if(history == null) history = fn_AddHistory($(AwxXml).find('Histories')[0], dsResult.data.items[j].get('Seq'));
								
									var approver = $(history).find('Approver[TaskID = \'' + dsResult.data.items[j].get('TaskId') + '\']')[0];
									
									if(approver != null)
									{
										var status = approver.getAttribute("Status");
										
										if(status != "")
										{
											this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
											return;
										}
										history.removeChild(approver);
									}
									
									if(record.data.DutyName == "")
									{
										if(dsResult.data.items[j].data.TaskId.indexOf('app') > -1)
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
										CompanyName: record.data.CompanyName,
										DutyCode: record.data.DutyCode,
										DutyName: record.data.DutyName,
										JobName: record.data.JobName,
										RankName: record.data.RankName,
										CellPhone: record.data.CellPhone,
										TeamChiefYN: record.data.TeamChiefYN,
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
//							else
//							{
//								this.WarningMessageBox(GetResource("ImpossibleChange", dsResult.data.items[j].get('Depth')));
//								return;
//							}
						}
					}
				}
				else
				{
					var args = new Array();
					args[0] = record.get("UserName");
					args[1] = dsResult.data.items[foundItem].get("Depth");
					this.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));
				}
       		}
       		else
       		{
				isGroup = true;
       		}
        }, this);
       
		if(isGroup)
		{
			this.WarningMessageBox(GetResource("ApproverNotSetGroupMsg"));
		}
		
        if (strNoEmpIDUserList.length > 1) {
            this.WarningMessageBox(strNoEmpIDUserList + GetResource("NoInfoAddMsg"));
        }
        this.AllSelectionClear();
    },

    HandlerRemoveCharge: function(dataGrid, dsResult) {
        Ext.each(dataGrid.getSelectionModel().getSelections(), function(record, index, allItems) {
			if(record.get('Change') == "false")
			{
				this.WarningMessageBox(GetResource("ImpossibleChange", record.get('Depth')));
				return;
			} 
            //기본결재일경우
            if (record.get("EmpID") != undefined && record.get("EmpID") != "") {
				var history = $(AwxXml).find('Histories History[Seq = ' + record.get("Seq") + ']')[0];
				if(history == null) return;
				
				// 현재 member 노드 접근
				var approver = $(history).find('Approver[TaskID = \'' + record.get('TaskId') + '\']')[0];
				if(approver != null)
				{
					var status = approver.getAttribute("Status");

					if(status != "")
					{
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

    HandlerUpDownCharge: function(dataGrid, dsResult, strType) {
       if (dataGrid.getSelectionModel().getSelections().length > 1) {
            this.WarningMessageBox(GetResource("OnlyOneSelectMsg"));
            this.AllSelectionClear();
            return;
        }
		 
        Ext.each(dataGrid.getSelectionModel().getSelections(), function(record, index, allItems) {

			var history = $(AwxXml).find('Histories History[Seq = ' + record.get("Seq") + ']')[0];
			if(history == null) return; 
			
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
			
			var new_approver = $(history).find('Approver[TaskID = \'' + newRow.data.TaskId + '\']')[0];
			var curr_approver = $(history).find('Approver[TaskID = \'' + currRow.data.TaskId + '\']')[0];
			
			if(curr_approver == null) return;

			if(currRow.get('Change') == "false")
			{
				this.WarningMessageBox(GetResource("ImpossibleChange", currRow.get('Depth')));
				return;
			}

			if(newRow.get('Change') == "false")
			{
				this.WarningMessageBox(GetResource("ImpossibleChange", newRow.get('Depth')));
				return;
			}
			
			var status = curr_approver.getAttribute("Status");
		
            if(status != "")
            {
                //결재가 완료된 사용자는 변경이 불가능합니다.
                this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
                return;
            }
            
			if(new_approver != null)
			{
				var status = new_approver.getAttribute("Status");
			
				if(status != "")
				{
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
				CompanyName: currRow.data.CompanyName,
				DutyCode: currRow.data.DutyCode,
				DutyName: currRow.data.DutyName,
				JobName: currRow.data.JobName,
				RankName: currRow.data.RankName,
				CellPhone: currRow.data.CellPhone,
				TeamChiefYN: currRow.data.TeamChiefYN,
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
				CompanyName: newRow.data.CompanyName,
				DutyCode: newRow.data.DutyCode,
				DutyName: newRow.data.DutyName,
				JobName: newRow.data.JobName,
				RankName: newRow.data.RankName,
				CellPhone: newRow.data.CellPhone,
				TeamChiefYN: newRow.data.TeamChiefYN,
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

    HandlerRemoveAllCharge: function(dataGrid, dsResult) {
		var mask = new Ext.LoadMask(dataGrid.getView().el, {msg:GetResource("WaitMsg")});
		mask.show();
		 
		for(var i=0; i<dsResult.data.items.length; i++)
		{
//			if(dsResult.data.items[i].get("Change") == "false")
//			{
//				this.WarningMessageBox(GetResource("ImpossibleChange", dsResult.data.items[i].get('Depth')));
//				return;
//			}

			if(dsResult.data.items[i].get("Change") != "false")
			{
				var history = $(AwxXml).find('Histories History[Seq = ' + dsResult.data.items[i].get("Seq") + ']')[0];
				if(history == null) return;
				
				if(dsResult.data.items[i].get("EmpID") != undefined && dsResult.data.items[i].get("EmpID") != "")
				{
					//대리작성인 경우 기안자 변경 불가.
					if(dsResult.data.items[i].get('TaskId') == "emp0")
					{
						if($(AwxXml).find('Fields')[0] != null)
						{
							if($(AwxXml).find('Fields')[0].getAttribute("IsProxy") != null )
							{
								if($(AwxXml).find('Fields')[0].getAttribute("IsProxy") == "Y")
								{
									this.WarningMessageBox(GetResource("ApproverDrafterNoChangeMsg"));
								}
							}
						}
					}
					else
					{
						// 현재 member 노드 접근
						var approver = $(history).find('Approver[TaskID = \'' + dsResult.data.items[i].get('TaskId') + '\']')[0];
						if(approver != null)
						{
							var status = approver.getAttribute("Status");

							if(status != "")
							{
								this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
							}
							else
							{
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
        this.AllSelectionClear();
    },

    OnButtonClick: function(strType, strId) {
        if (!this.CurrentGridSet) return;
        var dataGrid = eval("this.CurrentGridSet." + strId);
        var dsResult = eval("this." + strId + "Result");
        var sourceGrid = null;

        var mask = new Ext.LoadMask(dataGrid.getView().el, { msg: GetResource("WaitMsg") });
        mask.show();

        switch (strType) {
            case 'Add':
				this.HandlerAddCharge(dataGrid, dsResult);
                break;

            case 'Remove':
                if (dataGrid.getSelectionModel().getSelections().length > 0) this.HandlerRemoveCharge(dataGrid, dsResult);
                break;

            case 'Up':
            case 'Down':
                if (dataGrid.getSelectionModel().getSelections().length > 0) this.HandlerUpDownCharge(dataGrid, dsResult, strType);
                break;

            case 'RemoveAll':
                if (dsResult.getCount() > 0) this.HandlerRemoveAllCharge(dataGrid, dsResult);
                break;
        }
        mask.hide();
    },

    InitSelectGrid: function() {
        var id = LeftTabContainer.activeTab.id.split('_')[0];
        var obj = eval("GW." + id);
        var fn = eval("obj.ReturnSourceGrid");

        if (typeof (fn) == 'function') {
            this.CurrentGridSet.Select = eval("obj.ReturnSourceGrid()");
        }
    },
    
    AllSelectionClear: function()
    {
        if (this.CurrentGridSet) {
            if (this.CurrentGridSet.Select == null) this.InitSelectGrid();
            this.CurrentGridSet.Select.getSelectionModel().clearSelections();
            this.CurrentGridSet.Charge.getSelectionModel().clearSelections();

            var selectHeader = this.CurrentGridSet.Select.getView().getHeaderCell(0).childNodes[0];
            var chargeHeader = this.CurrentGridSet.Charge.getView().getHeaderCell(0).childNodes[0];
            
            Ext.get(selectHeader).removeClass('x-grid3-hd-checker-on');
            Ext.get(chargeHeader).removeClass('x-grid3-hd-checker-on');
		}
    }
});

//GW.Charge = new GW.SetLine.Charge();
