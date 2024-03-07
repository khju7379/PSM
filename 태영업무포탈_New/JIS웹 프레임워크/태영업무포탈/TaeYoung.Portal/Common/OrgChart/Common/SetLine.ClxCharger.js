/*
* SetLine.ClxCharger.js
* 울산 담당자
*/
var ClxChargerServerURL = 'ClxChargerServer.aspx';

var ClxChargerDataFields = [
	{ name: 'EmpID' },
	{ name: 'LoginID' },
	{ name: 'CellPhone' },
	{ name: 'TeamChiefYN' },
	{ name: 'UserName' },
	{ name: 'ADDisplayName' },	
	{ name: 'Email' },
	{ name: 'DeptCode' },
	{ name: 'DeptName' },
	{ name: 'JobName' },
	{ name: 'CompanyCode' },
	{ name: 'CompanyName' },
	{ name: 'RankName' },
	{ name: 'DutyCode' },
	{ name: 'DutyName' },
	{ name: 'DataKind' },
	{ name: 'DataKindName' },
	{ name: 'ChrgSphe' },
	{ name: 'Type' },// mandatory : '', 'USER', 'DEPT', 'GROUP'
	{ name: 'Information' },
	{ name: 'Display1' },
	{ name: 'Display2' }
];

var strDocCode = "";

var leftTabNodes = $(FormXml).find("select")[0];

var tabNodes = $(leftTabNodes).find("tab");

for(var i=0; i<tabNodes.length; i++)
{
	var src = tabNodes[i].getAttribute("src");
	var objKey = src.substring(src.lastIndexOf('/') + 1, src.lastIndexOf('.'));
	
	if(objKey.toLowerCase() == "lobchargerlist")
	{
		if(src.lastIndexOf('?docCode=') > -1)
		{
			strDocCode = src.substring(src.lastIndexOf('=') + 1, src.length);
		}
	}
}

//조직도에 공통적으로 들어가는 Component를 정의
GW.SetLine.ClxCharger = function() {

    this.ReturnPanel = null;
    this.ClxTree = null;
    this.ClxMembersGrid = null;
    this.ClxMembersGridDropTarget = null;
    this.ClxMembersCM = null;
	
    this.ClxMembersResult = new Ext.data.JsonStore
    ({
        url: ClxChargerServerURL,
        baseParams: { action: 'GetMemberList', docCode: strDocCode },
        root: 'dataRoot',
        fields: ClxChargerDataFields,
        remoteSort: false
    });

	this.CurrentGridSet = this.InitGrid();
    this.Render();
    
    this.ClxMembersResult.on('datachanged', this.OnMembersDataChanged, this);
	this.ClxMembersResult.on('beforeload', function(store, options) {
		// DATA가 변경될 때 Presence 정보를 초기화
		GW.NameControl.UnRegisterPresenceAll();
	}, this); 
	
    this.CurrentGridSet.ClxCharger.on('render', function() { this.DragDropSetting(); }, this);
};

Ext.extend(GW.SetLine.ClxCharger, GW.SetLine.Common, {

    ReturnSourceGrid: function() {
        return this.CurrentGridSet.ClxCharger;
    },
    
    InitGrid: function(){
    
		this.ClxMembersGridCheckBox = new Ext.grid.CheckboxSelectionModel();
		this.ClxMembersCM = new Ext.grid.ColumnModel
		([
			this.ClxMembersGridCheckBox,
			{header: GetResource("CLXChargerChargeDiv"),	dataIndex: 'Display1', 	menuDisabled: true,	width: 150,	renderer: this.RendererWithTooltip},
			{header: GetResource("CLXChargerNameGrade"),			dataIndex: 'Display2',	menuDisabled: true,	width: 150,	renderer: this.RendererUserName.createDelegate(this)}
//			{header: "담당분야 <font color='blue'>자료종류</font>",	dataIndex: 'Display1', 	menuDisabled: true,	width: 150,	renderer: this.RendererWithTooltip},
//			{header: "이름(사번)<font color='gray'>직위</font>",			dataIndex: 'Display2',	menuDisabled: true,	width: 150,	renderer: this.RendererUserName.createDelegate(this)}
//			{header: GetResource("UserDept"),		dataIndex: 'DeptName',				menuDisabled: true,	width: 80,		renderer: this.RendererWithTooltip},
//			{header: GetResource("UserCellPhone"),	dataIndex: 'CellPhone',				menuDisabled: true,	width: 95,		renderer: this.RendererWithTooltip},
//			{header: GetResource("UserOfficeTel"),	dataIndex: 'ExtensionNumber',	menuDisabled: true,	width: 95,		renderer: this.RendererWithTooltip}
		]);

		this.ClxMembersGrid = new Ext.grid.GridPanel
		({
			region: 'center',
			margins: '5 5 5 5',
			ddGroup: 'DDGSelect',
			enableDragDrop: true,
			enableColumnMove: false,
			ds: this.ClxMembersResult,
			cm: this.ClxMembersCM,
			sm: this.ClxMembersGridCheckBox,
			stripeRows: true,
		    viewConfig:
			{
			    autoFill: true,
			    forceFit: true
			},
			title: '&nbsp;&nbsp;',
			loadMask:{msg:GetResource("WaitMsg")}
		});
		
        var gridSet =
		{
		    ClxCharger: this.ClxMembersGrid
		};

        return gridSet;
    },
    
    DragDropSetting: function() {
        var ClxMembersGridDropTargetEl = this.ClxMembersGrid.getView().el.dom.childNodes[0].childNodes[1]
        this.ClxMembersGridDropTarget = new Ext.dd.DropTarget(ClxMembersGridDropTargetEl, {
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
                    case 'DDGACharge':
                        GW.Charge.HandlerRemoveCharge(GW.ApproverAgree.CurrentGridSet.Charge, GW.ApproverAgree.ChargeResult);
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
                    case 'DDGReceive':
                        GW.Receive.HandlerRemoveReceive(GW.Receive.CurrentGridSet.Receive, GW.Receive.ReceiveResult);
                        break;                        
                    default:
                        break;
                }
            }
        });

        this.ClxMembersGridDropTarget.addToGroup('DDGAgree1');
        this.ClxMembersGridDropTarget.addToGroup('DDGAgree2');
        this.ClxMembersGridDropTarget.addToGroup('DDGAgree3');
        this.ClxMembersGridDropTarget.addToGroup('DDGAgree4');
        this.ClxMembersGridDropTarget.addToGroup('DDGAgreeBefore');
        this.ClxMembersGridDropTarget.addToGroup('DDGAgreeAfter');
        this.ClxMembersGridDropTarget.addToGroup('DDGACharge'); 
        this.ClxMembersGridDropTarget.addToGroup('DDGSend');
        this.ClxMembersGridDropTarget.addToGroup('DDGCopy');
        this.ClxMembersGridDropTarget.addToGroup('DDGCharge'); 
		this.ClxMembersGridDropTarget.addToGroup('DDGReceive');  
    },

    Render: function() {
    
		var searchBox = this.GetEmpNameSearchBox();
		var treeBox = this.GetChargerTree();
		
		var clearSearchBox = function(){
			var node = treeBox.getSelectionModel().getSelectedNode();
			if(node){
				var company = this.GetCurrentCompany();
				this.ClxMembersResult.load({params:{companyCode:company.companyCode, isRelative:company.isRelative, mode:'dept', query:node.id}});
				this.ClxMembersGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
				//this.ClxMembersCM.setHidden(3, true);
			}
			searchBox.fireEvent('blur', searchBox);
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
						this.WarningMessageBox(GetResource("NoUseSpecialMsg"), function(){
							searchBox.focus();
						});
						return false;
					} else if(alphanum.test(strName)) {
						// 사번검색  --> NOTE: 사번검색할 때 3자로 제한해야함. sk로 검색하면 대박.
						if(strName.length < 3) {
							searchBox.setValue('');
							this.WarningMessageBox(GetResource("NoUseAlphaNumTwoWord"), function(){
								searchBox.focus();
							});
							return false;
						}
					}
					var company = this.GetCurrentCompany();
					this.ClxMembersResult.load({params:{companyCode:company.companyCode, isRelative:company.isRelative, mode:'member', query:strName}});
					//this.ClxMembersCM.setHidden(3, false);
					this.ClxMembersGrid.setTitle('[' + strName + '] ' + GetResource("SearchResult"));
					return true;
				} else{
					searchBox.setValue('');
					this.WarningMessageBox(GetResource("UseSearch"), function(){
						searchBox.focus();
					});	
					return false;					
				}
			}
			return false;
		};
		searchBox.SearchClick = doSearchBox.createDelegate(this);

		treeBox.getLoader().on('load', function(treeLoader, node, response) {
			if(node == treeBox.root){
				node.expandChildNodes();
			}
			else if(treeBox.root.children && treeBox.root.children.length == 1){
				treeBox.root.expandChildNodes();
			}
		}, this);
		
		treeBox.getSelectionModel().on('selectionchange', function(t, node){
			if(node){
				//this.ClxMembersCM.setHidden(3, true);
				this.ClxMembersResult.load({params:{deptID:node.id}});
				this.ClxMembersGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
				searchBox.onTrigger1Click();
			}
		}, this);
		
	    treeBox.getLoader().on('beforeload', function(treeLoader, node) {
	        if(treeLoader.baseParams){
				treeLoader.baseParams.pcode = node.pcode;
	        }
		}, this);
		
       treeBox.on('render', function() {
//            treeBox.selectPath(this.MyDeptSelectPath);
//            treeBox.expandPath(this.MyDeptSelectPath);
        }, this);
        
		this.ReturnPanel = new Ext.Panel
		({
			id: 'ClxCharger',
			layout: 'border',
			border: false,
			bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
			items: [treeBox, this.ClxMembersGrid]
		});
    },

	// 성명/사번 검색
	GetEmpNameSearchBox : function(width) {
		var width = width || 125;
		var searchBox = new Ext.app.SearchField({
			qtip: GetResource("SearchBox"),
			minLength:2,
			maxLength:8,
			width: width
		});
		Ext.override(Ext.app.SearchField, {
			afterRender : Ext.app.SearchField.prototype.afterRender.createSequence(function(){
				var qt = this.qtip;
				if(qt){
					Ext.QuickTips.register({
						target: this,
						text: qt,
						enabled: true,
						showDelay: 0
					});
				}
		})});
		return searchBox;
	},

	// 담당자 트리
	GetChargerTree : function(width) {
		var width = width ? width : 230;
		
		var tree = new Ext.tree.TreePanel({
			id:'charger-tree',
			region:'west',
			width:width,
			margins: '5 0 5 5',
			rootVisible:false,
			lines:true,
			autoScroll:true,
			loader:new Ext.tree.TreeLoader({
				url: ClxChargerServerURL,
				baseParams:{ action: 'GetTree', docCode: strDocCode},
				requestMethod:'POST'
			}),
			root: new Ext.tree.AsyncTreeNode({
				text:'root',
				id:'charger-root',
				expanded:true
			}),
			collapseFirst:false				
		});
		return tree;
	},
	
    OnMembersDataChanged: function(store) {
		if(store.reader.jsonData.NumOfPerson){
			var num = store.reader.jsonData.NumOfPerson;
			var title = this.ClxMembersGrid.title;
			title += " <span style='color:#e6ffff'>(" + GetResource("Total") + num + GetResource("PersonCount") + ")</span>";
			this.ClxMembersGrid.setTitle(title);
		}
    }
});

//GW.ClxCharger = new GW.SetLine.ClxCharger();
