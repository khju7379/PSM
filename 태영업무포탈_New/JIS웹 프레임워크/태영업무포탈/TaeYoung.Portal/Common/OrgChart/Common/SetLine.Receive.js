/*
* SetLine.Receive.js
* 수신처/사본처
*/
GW.SetLine.Receive = function() {
    //GW.SetLine.Receive.superclass.constructor.call(this);

    this.ReceiveResult = new Ext.data.JsonStore
	({
	    id: 'ReceiveResult',
	    title: GetResource("Send"),
	    fields: APPDataFields
	});

    this.ReceiveGridDropTarget = null;
    this.ReturnPanel = null;

    this.CurrentGridSet = this.InitGird();
    this.LoadAwx();
    this.Render();

    this.CurrentGridSet.Receive.on('dblclick', function() {
        this.HandlerRemoveReceive(this.CurrentGridSet.Receive, this.ReceiveResult)
    }, this);

	this.CurrentGridSet.Receive.on('render', function() { this.DragDropSetting(); }, this);
};

Ext.extend(GW.SetLine.Receive, GW.SetLine.Common, {

	On_Receive_DbClickItem : function(record, index, allItems)
	{
		this.On_Receive_DbClickItem_Handle(record, index, allItems);
	},
	
	On_Receive_DbClickItem_Handle : function(record, index, allItems)
	{
		var dataGrid = this.CurrentGridSet.Receive;
		var dsResult = this.ReceiveResult;
		
		this.HandlerAddReceive(dataGrid, dsResult);
		this.AllSelectionClear();
	},
	
    LoadAclArchive: function() {
        //그리드 리셋
		this.ReceiveResult.removeAll();
        this.LoadAwx();
    },

    LoadAwx: function() {
		var app_node = $(AwxXml).find('Histories History');
		
		for(var k=0; k< app_node.length; k++)
		{
		    var history_node = $(AwxXml).find('Histories History[Seq=' + k + ']')[0];

		    if(history_node != null)
		    {
			    //기본결재, 협조 바인딩.
			    for(var i=0; i< history_node.childNodes.length; i++)
			    {
					if(history_node.childNodes[i].nodeName == "Agree")
					{
						var agreeId = history_node.childNodes[i].getAttribute("Ref").toLowerCase();
						
						if(agreeId == "receive")
						{
							if($(history_node.childNodes[i]).find('.[Ref="' + agreeId + '"]')[0] == null)
							{
								fn_AddAgree(history_node.childNodes[i], agreeId);
							}

							var agree_node = $(history_node.childNodes[i]).find('.[Ref="' + agreeId + '"]')[0];
							
							if(agree_node != null)
							{
								var newRecords = new Array();
								
								for(var j=0; j<agree_node.childNodes.length; j++)
								{
									var foundItem = this.ReceiveResult.find('EmpID', agree_node.childNodes[j].getAttribute("EmpID"));
									if(foundItem == -1) {
										var change_flag = "true";
										
										if(agree_node.childNodes[j].getAttribute("State") == "C")
										{
											change_flag = "false";
										}
										
										var info = "";
										if(agree_node.childNodes[j].getAttribute("Information") != null) info = agree_node.childNodes[j].getAttribute("Information");
										
										var newRecord = new ApproverRecord({
											EmpID: agree_node.childNodes[j].getAttribute("EmpID"),
											LoginID: agree_node.childNodes[j].getAttribute("LoginID"),
											ADDisplayName: agree_node.childNodes[j].getAttribute("UserName") + "(" + agree_node.childNodes[j].getAttribute("LoginID") + ")/" + agree_node.childNodes[j].getAttribute("DeptName"),
											UserName: agree_node.childNodes[j].getAttribute("UserName"),	
											Email: agree_node.childNodes[j].getAttribute("Email"),	
											Type: 'USER',
											DeptCode: agree_node.childNodes[j].getAttribute("DeptCode"),
											DeptName: agree_node.childNodes[j].getAttribute("DeptName"),
											CompanyCode: agree_node.childNodes[j].getAttribute("CompanyCode"),
											CompanyName: agree_node.childNodes[j].getAttribute("CompanyName"),
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
											Information: info,
											Change: change_flag
										});
										newRecords[j] = newRecord;
									}
								}
								this.ReceiveResult.add(newRecords);
							}							
						}
					}
			    }
		    }
		}
    },

    InitGird: function() {
        // 수신처
        var ReceiveGridCheckBox = new Ext.grid.CheckboxSelectionModel();
        var ReceiveResultCM = new Ext.grid.ColumnModel
		([
			ReceiveGridCheckBox,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', width: 85, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', width: 75, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserEmpID"), dataIndex: 'LoginID', width: 50, renderer: this.RendererWithTooltip }
		]);

        var ReceiveResultGrid = new Ext.grid.GridPanel
		({
			id: 'ReceiveResultGrid',
			region: 'center',
			margins: '5 5 5 5',
		    ddGroup: 'DDGReceive',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    border: true,
		    ds: this.ReceiveResult,
		    cm: ReceiveResultCM,
		    sm: ReceiveGridCheckBox,
		    stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
		    bbar: [
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("ApproverAddTooltip" , GetResource("Send")) },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function() {
				        this.OnButtonClick('Add', 'Receive')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("ApproverRemoveTooltip" , GetResource("Send")) },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function() {
				        this.OnButtonClick('Remove', 'Receive')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("ApproverRemoveAllTooltip" , GetResource("Send")) },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function() {
				        this.OnButtonClick('RemoveAll', 'Receive')
				    },
				    scope: this
				}, '->',
				{
				    tooltip: { title: GetResource("Up"), text: GetResource("ApproverUpTooltip" , GetResource("Send")) },
				    iconCls: 'up',
				    text: GetResource("Up"),
				    handler: function() {
				        this.OnButtonClick('Up', 'Receive')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Down"), text: GetResource("ApproverDownTooltip" , GetResource("Send")) },
				    iconCls: 'down',
				    text: GetResource("Down"),
				    handler: function() {
				        this.OnButtonClick('Down', 'Receive')
				    },
				    scope: this
				}
			],
			title: GetResource("Send"),
		    loadMask: { msg: GetResource("WaitMsg") }
		});
		
        var gridSet =
		{
		    Receive: ReceiveResultGrid
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
				if(objKey == "receive")
				{
					var listNode = $(tabNodes[i]).find("list[id='receive']");
					
					if(listNode != null)
					{
						var title = $(listNode).find("lstitle").attr("text");
						this.CurrentGridSet.Receive.setTitle(title);
					}
					break;
				}
			}
		}

		this.ReturnPanel = new Ext.Panel
		({
			id: 'Receive',
			layout: 'border',
			border: false,
			bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
			items : 
			[
		    {
				region: 'north',
				height: 0,
				border: false
			}
			, this.CurrentGridSet.Receive
			]
		});
    },

    DragDropSetting: function() {
        var grids = this.CurrentGridSet;

        function HandlerReceiveGridDrop(ddSource, dsResult) {
            var strNoEmailList = "";
			var strOverLapUserList = "";
			
			Ext.each(ddSource.dragData.selections, function(record, index, allItems) {
				var receive_cnt = dsResult.data.items.length;
                if (dsResult.data.items.length >= 200) {
					var args = new Array();
					args.push(GetResource("Send"));
					args.push("200");
					GW.Common.WarningMessageBox(GetResource("ApproverMaxMsg", args));
					return false;
                }

                if (record.data.Email.length == 0) {
                    strNoEmailList += record.data.UserName + ', ';
                    return true;
                }

				// Email 유일키
				if(is_overlap)
				{
					for(var i=0; i<dsResult.data.length; i++)
					{
						if(dsResult.data.items[i].get("Email") == record.data.Email)
						{
							var foundItem = true;
							break;
						}
					}
				}
				else
				{
					var foundItem = false;
				}

                if (!foundItem) {
                
					if($(AwxXml).find('Histories History[Seq = ' + app_seq + ']')[0] == null)
					{
						fn_AddHistory($(AwxXml).find('Histories')[0], app_seq);
					}
                
					if($(AwxXml).find('Histories History Agree[Ref="receive"]')[0] == null)
					{
						fn_AddAgree($(AwxXml).find("Histories History[Seq='" + app_seq + "']"), "receive");
					}
				
					var idx = dsResult.data.items.length + 1;
					var receive_task = "receive" + '_' + (idx < 10 ? "0" : "") + idx.toString();
					
					var info = "";
					if(record.data.Information != undefined) info = record.data.Information;
					
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
						JobCode: record.data.JobCode,
						JobName: record.data.JobName,
						RankCode: record.data.RankCode,
						RankName: record.data.RankName,
						CellPhone: record.data.CellPhone,
						TeamChiefYN: record.data.TeamChiefYN,
						ExtensionNumber: record.data.ExtensionNumber,
						FaxNumber: record.data.FaxNumber,
						Depth: dsResult.title,
						TaskId: receive_task,
						Seq: '',
						Validation: '',
						Information: info,
						Change: 'true'
                    });
                    dsResult.add(newRecord);
					//AWX에 결재자 정보 추가
					fn_AddApprover($(AwxXml).find("Histories History[Seq='" + app_seq + "'] Agree[Ref='receive']")[0], fn_GetUserInfo(newRecord), receive_task, idx); 
                }
                else
                {
					if(strOverLapUserList == "")
						strOverLapUserList = record.get("UserName");
					else
						strOverLapUserList = strOverLapUserList + ", " + record.get("UserName");
                }
            }, this);

			if(strOverLapUserList != "")
			{
				var args = new Array();
				args[0] = strOverLapUserList;
				args[1] = GetResource("Send");
				GW.Common.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));			
			}
			
            if (strNoEmailList.length > 1) {
                GW.Common.WarningMessageBox(strNoEmailList + GetResource("NoInfoAddMsg"));
            }

            GW.Receive.AllSelectionClear();
        }

		var ReceiveGridDropTargetEl = grids.Receive.getView().el.dom.childNodes[0].childNodes[1];
		this.ReceiveGridDropTarget = new Ext.dd.DropTarget(ReceiveGridDropTargetEl, {
			ddGroup: 'DDGSelect',
			notifyDrop: function(ddSource, e, data) {
				var mask = new Ext.LoadMask(grids.Receive.getView().el, { msg: GetResource("WaitMsg") });
				mask.show();
				HandlerReceiveGridDrop(ddSource, grids.Receive.store);
				mask.hide();
				return true;
			}
		}, this);
    },

    HandlerAddReceive: function(dataGrid, dsResult) {
		this.InitSelectGrid();
		if(this.CurrentGridSet.Select == undefined) return;
		if(this.CurrentGridSet.Select.getSelectionModel().getSelections().length == 0)
		{
			this.WarningMessageBox(GetResource("SelectOrgMsg"));
			return false;		
		} 
        var strNoEmailList = "";
		var strOverLapUserList = "";
        Ext.each(this.CurrentGridSet.Select.getSelectionModel().getSelections(), function(record, index, allItems) {
            var receive_cnt = dsResult.data.items.length;
            if (dsResult.data.items.length >= 200) 
            {
				var args = new Array();
				args.push(GetResource("Send"));
				args.push("200");
				this.WarningMessageBox(GetResource("ApproverMaxMsg", args));
				return false;
            }

			if (record.data.Email.length == 0) 
			{
				strNoEmailList += record.data.UserName + ', ';
				return true;
			}

			// Email 유일키
			if(is_overlap)
			{
				for(var i=0; i<dsResult.data.length; i++)
				{
					if(dsResult.data.items[i].get("Email") == record.data.Email)
					{
						var foundItem = true;
						break;
					}
				}
			}
			else
			{
				var foundItem = false;			
			}

			if (!foundItem) {

				if($(AwxXml).find('Histories History[Seq = ' + app_seq + ']')[0] == null)
				{
					fn_AddHistory($(AwxXml).find('Histories')[0], app_seq);
				}
				
				if($(AwxXml).find('Histories History Agree[Ref="receive"]') == null)
				{
					fn_AddAgree($(AwxXml).find("Histories History[Seq='" + app_seq + "']"), "receive");
				}
					
				var idx = dsResult.data.items.length + 1;
				var receive_task = "receive" + '_' + (idx < 10 ? "0" : "") + idx.toString();
				
				var info = "";
				if(record.data.Information != undefined) info = record.data.Information;
				
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
					CompanyCode: record.data.CompanyCode,
					DutyCode: record.data.DutyCode,
					DutyName: record.data.DutyName,
					JobCode: record.data.JobCode,
					JobName: record.data.JobName,
					RankCode: record.data.RankCode,
					RankName: record.data.RankName,
					CellPhone: record.data.CellPhone,
					TeamChiefYN: record.data.TeamChiefYN,
					ExtensionNumber: record.data.ExtensionNumber,
					FaxNumber: record.data.FaxNumber,
					Depth: dsResult.title,
					TaskId: receive_task,
					Information: info,
					Seq: '',
					Validation: '',
					Change: 'true'
				});
				dsResult.add(newRecord);
				//AWX에 결재자 정보 추가
				fn_AddApprover($(AwxXml).find("Histories History[Seq='" + app_seq + "'] Agree[Ref='receive']"), fn_GetUserInfo(newRecord), receive_task, idx);
			}
			else
			{
				if(strOverLapUserList == "")
					strOverLapUserList = record.get("UserName");
				else
					strOverLapUserList = strOverLapUserList + ", " + record.get("UserName");
			}
        }, this);

		if(strOverLapUserList != "")
		{
			var args = new Array();
			args[0] = strOverLapUserList;
			args[1] = GetResource("Send");
			this.WarningMessageBox(GetResource("ApproveValidationCheckMsg", args));		
		}
		
        if (strNoEmailList.length > 1) {
            this.WarningMessageBox(strNoEmailList + GetResource("NoInfoAddMsg"));
        }

        this.AllSelectionClear();
    },

    HandlerRemoveReceive: function(dataGrid, dsResult) {

		var receives = $(AwxXml).find("Histories History[Seq='" + app_seq + "'] Agree[Ref='receive']")[0];

		if(receives != null)
		{
			Ext.each(dataGrid.getSelectionModel().getSelections(), function(record, index, allItems) {
				var approver = $(receives).find('Approver[TaskID = \'' + record.get('TaskId') + '\']')[0];

				if(approver != null)
				{
					var status = approver.getAttribute("State");
					
					if(status == "C")
					{
						this.WarningMessageBox(GetResource("ApproverCompleteNoChangeMsg"));
						return;
					}
					//AWX에 결재자 정보 삭제
					receives.removeChild(approver);
					dsResult.remove(record);
				}
			}, this);
			
			//순차적으로 TaskID부여
			var receive_cnt = 0;
			var receive_task;
			
			for(var j=0; j<receives.childNodes.length; j++)
			{
				receive_cnt++;
				receive_task = 'receive_' + (receive_cnt < 10 ? "0" : "") + receive_cnt.toString();
				receives.childNodes[j].setAttribute("TaskID", receive_task);
				receives.childNodes[j].setAttribute("Order", j+1);
				dsResult.data.items[j].set("TaskId", receive_task);
				dsResult.data.items[j].commit();
			}
		}
        this.AllSelectionClear();
    },

    HandlerUpDownReceive: function(dataGrid, dsResult, strType) {
        if (dataGrid.getSelectionModel().getSelections().length > 1) {
            this.WarningMessageBox(GetResource("OnlyOneSelectMsg"));
            this.AllSelectionClear();
            return;
        }

		var history = $(AwxXml).find('Histories History[Seq = ' + app_seq + ']')[0];
		if(history == null) return;
			
        Ext.each(dataGrid.getSelectionModel().getSelections(), function(record, index, allItems) {
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
			var cinfo = "";
			if(currRow.data.Information != undefined) cinfo = currRow.data.Information;
            var currRecord = new ApproverRecord({
				EmpID: currRow.data.EmpID,
				LoginID: currRow.data.LoginID,
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
				JobCode: currRow.data.JobCode,
				JobName: currRow.data.JobName,
				RankCode: currRow.data.RankCode,
				RankName: currRow.data.RankName,
				CellPhone: currRow.data.CellPhone,
				TeamChiefYN: currRow.data.TeamChiefYN,
				ExtensionNumber: currRow.data.ExtensionNumber,
				FaxNumber: currRow.data.FaxNumber,
				Depth: currRow.data.Depth,
				TaskId: currRow.data.TaskId,
				Information: cinfo,
				Seq: currRow.data.Seq,
				Validation: currRow.data.Validation,
				Change: currRow.data.Change
            });

			var ninfo = "";
			if(newRow.data.Information != undefined) ninfo = newRow.data.Information;
            var newRecord = new ApproverRecord({
				EmpID: newRow.data.EmpID,
				LoginID: newRow.data.LoginID,
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
				JobCode: newRow.data.JobCode,
				JobName: newRow.data.JobName,
				RankCode: newRow.data.RankCode,
				RankName: newRow.data.RankName,
				CellPhone: newRow.data.CellPhone,
				TeamChiefYN: newRow.data.TeamChiefYN,
				ExtensionNumber: newRow.data.ExtensionNumber,
				FaxNumber: newRow.data.FaxNumber,
				Depth: newRow.data.Depth,
				TaskId: newRow.data.TaskId,
				Information: ninfo,
				Seq: newRow.data.Seq,
				Validation: newRow.data.Validation,
				Change: newRow.data.Change
            });

            dsResult.remove(currRow);
            dsResult.insert(idx, newRecord);
            dsResult.remove(newRow);
            dsResult.insert(newidx, currRecord);

            //AWX에 결재 정보 수정
			var receives = $(AwxXml).find("Histories History[Seq='" + app_seq + "'] Agree[Ref='receive']")[0];
			
			if(receives != null)
			{
				var curr_receive = $(receives).find('Approver[TaskID = \'' + currRow.data.TaskId + '\']')[0];

				// 데이터 이동
				var new_receive = curr_receive.previousSibling;
				curr_receive = receives.removeChild(curr_receive);
				curr_receive = receives.insertBefore(curr_receive, new_receive);
			
				//순차적으로 TaskID부여
				var receive_cnt = 0;
				var receive_task;
				
				for(var i=0; i<receives.childNodes.length; i++)
				{
					receive_cnt++;
					receive_task = 'receive_' + (receive_cnt < 10 ? "0" : "") + receive_cnt.toString();
					receives.childNodes[i].setAttribute("TaskID", receive_task);
					receives.childNodes[i].setAttribute("Order", i+1);
					dsResult.data.items[i].set("TaskId", receive_task);
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

    HandlerRemoveAllReceive: function(dataGrid, dsResult) {

		var receives = $(AwxXml).find("Histories History[Seq='" + app_seq + "'] Agree[Ref='receive']")[0];
		
		if(receives != null)
		{
			// 협조노드에서 제거
			for(var i=0; i<dsResult.data.items.length; i++)
			{
				var approver = $(receives).find('Approver[TaskID = \'' + dsResult.data.items[i].get('TaskId') + '\']')[0];
				
				if(approver != null)
				{
					receives.removeChild(approver);
				}
			}
			dsResult.removeAll();
		}
        this.AllSelectionClear();
    },

    OnButtonClick: function(strType) {
         if (!this.CurrentGridSet) return;
        var dataGrid = this.CurrentGridSet.Receive;
        var dsResult = this.ReceiveResult;
        var sourceGrid = null;

        var mask = new Ext.LoadMask(dataGrid.getView().el, { msg: GetResource("WaitMsg") });
        mask.show();

        switch (strType) {
            case 'Add':
                this.HandlerAddReceive(dataGrid, dsResult);
                break;
               
            case 'Remove':
                if (dataGrid.getSelectionModel().getSelections().length > 0)
                    this.HandlerRemoveReceive(dataGrid, dsResult);
                break;

            case 'Up':
            case 'Down':
                if (dataGrid.getSelectionModel().getSelections().length > 0)
                    this.HandlerUpDownReceive(dataGrid, dsResult, strType);
                break;

            case 'RemoveAll':
                if (dsResult.getCount() > 0)
                    this.HandlerRemoveAllReceive(dataGrid, dsResult);
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

    AllSelectionClear: function() {
        if (this.CurrentGridSet) {
        
            if (this.CurrentGridSet.Select == null) this.InitSelectGrid();

			this.CurrentGridSet.Select.getSelectionModel().clearSelections();
			var selectHeader = this.CurrentGridSet.Select.getView().getHeaderCell(0).childNodes[0];
			Ext.get(selectHeader).removeClass('x-grid3-hd-checker-on');
			
			this.CurrentGridSet.Receive.getSelectionModel().clearSelections();
			var receiveHeader = this.CurrentGridSet.Receive.getView().getHeaderCell(0).childNodes[0];
			Ext.get(receiveHeader).removeClass('x-grid3-hd-checker-on');			
		}
    }
});

//GW.Receive = new GW.SetLine.Receive();
