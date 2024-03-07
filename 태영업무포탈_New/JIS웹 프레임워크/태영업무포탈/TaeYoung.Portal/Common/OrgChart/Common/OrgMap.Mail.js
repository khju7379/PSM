/**
 * orgmap.mail.js
 * Outlook addin 이나 Outlook Web Access에서 불려지는 조직도
 * 홍정화(caoko@miksystem.com)
 * 2009-01-16 SK 에너지 데모버전 작성
 */
 
// 메일에서 사용하는 데이터
var MailDataFields = [
	{ name: 'EmpID' }, 			// mandatory (사번)
	{name: 'ADDisplayName' }, 	// mandatory
	{name: 'Email' }, 			// mandatory
	{name: 'Type' }, 			// mandatory : '', 'USER', 'DEPT', 'GROUP'
	{name: 'RankName' }, 		// option : 직책
	{name: 'DutyName' }, 		// option : 직급
	{name: 'DeptName' }, 		// option : 부서
	{name: 'UserName' }, 		// option
	{name: 'CellPhone' }, 		// option : 휴대폰
	{name: 'ExtensionNumber' }, // option : 사내전화번호
	{name: 'FaxNumber' }, 		// option : Fax
	{name: 'CompanyName' }, 	// option : 회사이름
    {name: 'JobName' }          // option : 직무
];

// outlook이나 owa 에서 불려지는 조직도
GW.OrgMap.Common.Mail = function(callFrom, overlap, OutlookItemType) {
	GW.OrgMap.Common.Mail.superclass.constructor.call(this);
	this.OrgChartType = "MAIL";
	this.Application = callFrom || 'owa';
	this.Overlap = overlap || 'false';
	this.preData = null;
	// OutlookItemType: "Mail", "Appointment", "Contact", "Task"
	// 2009.03.09 FaxForm 추가
	this.OutlookItemType = OutlookItemType || "Mail";
	// FaxForm 조직도에서 관계사는 안나오게 한다.
	if(this.OutlookItemType === "FaxForm"){
		this.NoShowRelativeCompany = true;
	}
	
	if(window.dialogArguments){
		// 기존 데이터를 넘겨준다.
		if(window.dialogArguments.orgmapData){
			this.preData = window.dialogArguments.orgmapData;		
		}
	}
		
	this.dsSource = new Ext.data.JsonStore({
        url: g_OrgMapServerURL,
		baseParams:{ action: 'getMemberListForMail' },
		root: 'dataRoot',
        fields: MailDataFields,
        remoteSort: false	
	});
	
	// 받는 사람
	this.dsTOResult = new Ext.data.JsonStore({
        fields: MailDataFields
    });
	// 참조
	this.dsCCResult = new Ext.data.JsonStore({
        fields: MailDataFields
    });
	// 숨은 참조
	this.dsBCCResult = new Ext.data.JsonStore({
        fields: MailDataFields
    });
    
    this.dsSource.on('datachanged', this.OnDsSourceDataChanged, this);
	
	this.dsSource.on('beforeload', function(store, options) {
		// DATA가 변경될 때 Presence 정보를 초기화
		GW.NameControl.UnRegisterPresenceAll();
	}, this);
	
	this.InitializeGrid();
			
	this.getInitialize(function(){	
		this.Render();
		if(this.OutlookItemType === "Task" || this.OutlookItemType === "FaxForm"){
			this.InitializeDragdropOnlyTo();
		}else if(this.OutlookItemType != "Contact"){
			this.InitializeDragdrop();
		}
		this.fadeoutMainLoadMask();
		
		if(this.Application === 'outlook' && this.OutlookItemType != "Contact"){
			// outlook의 받는사람, 참조, 숨은 참조를 가져옴
			if(window.external){
				var data = null;
				if(window.external.GetRecipients){
					data = window.external.GetRecipients();
				}
				
				if(data && typeof data == "string"){
					//alert(data);
					data = Ext.decode(data);
					this.preData = data;
				}				
			}
		}
		
		if(this.preData){
			try{
				if(this.preData.To && this.preData.To.length > 0){
					this.dsTOResult.loadData(this.preData.To);
				}
				if(this.preData.Cc && this.preData.Cc.length > 0){
					this.dsCCResult.loadData(this.preData.Cc);
				}
				if(this.preData.Bcc && this.preData.Bcc.length > 0){
					this.dsBCCResult.loadData(this.preData.Bcc);
				}
			}catch(e){
				//alert(e.message);
			}
		}
	}, this);
};

Ext.extend(GW.OrgMap.Common.Mail, GW.OrgMap.Common, {
    InitializeGrid: function () {
        if (this.OutlookItemType === "Contact") {
            this.SelectCheck = new Ext.grid.CheckboxSelectionModel({ singleSelect: true, header: '' });
        } else {
            this.SelectCheck = new Ext.grid.CheckboxSelectionModel();
        }
        this.SelectColumn = new Ext.grid.ColumnModel([
			this.SelectCheck,
			{ header: getResource("UserRank"), dataIndex: 'RankName', menuDisabled: true, width: 45, renderer: this.RendererWithTooltip },
			{ header: getResource("UserName"), dataIndex: 'UserName', menuDisabled: true, width: 65, renderer: this.RendererUserName.createDelegate(this) },
			{ header: getResource("UserEmpID"), dataIndex: 'EmpID', menuDisabled: true, width: 55, renderer: this.RendererWithTooltip },
			{ header: getResource("UserJob"), dataIndex: 'JobName', menuDisabled: true, width: 80, renderer: this.RendererWithTooltip },

			{ header: getResource("UserDept"), dataIndex: 'DeptName', menuDisabled: true, width: 80, renderer: this.RendererWithTooltip, hidden: true },
			{ header: getResource("UserCellPhone"), dataIndex: 'CellPhone', menuDisabled: true, width: 95, renderer: this.RendererWithTooltip, hidden: true },
			{ header: getResource("UserOfficeTel"), dataIndex: 'ExtensionNumber', menuDisabled: true, width: 95, renderer: this.RendererWithTooltip, hidden: true },
			{ header: getResource("UserFax"), dataIndex: 'FaxNumber', menuDisabled: true, width: 80, renderer: this.RendererWithTooltip, hidden: true }
		]);
        this.SelectGrid = new Ext.grid.GridPanel({
            region: 'center',
            margins: '5 5 0 5',
            ddGroup: 'srcDDGroup',
            enableDragDrop: true,
            enableColumnMove: false,
            ds: this.dsSource,
            cm: this.SelectColumn,
            sm: this.SelectCheck,
            stripeRows: true,
            //viewConfig: {
            //	autoFill:true
            //},
            title: '&nbsp;&nbsp;',
            loadMask: { msg: getResource("WaitMsg") }
        });

        // OutlookItemType: "Mail", "Appointment", "Contact", "Task" , "FaxForm"
        var ToBoxName = getResource("ToBox");
        var CcBoxName = getResource("CcBox");
        var BccBoxName = getResource("BccBox");

        var ToAddTooltip = { title: getResource("Add"), text: getResource("ToAddTip") };
        var ToRemoveTooltip = { title: getResource("Remove"), text: getResource("ToRemoveTip") };
        var ToRemoveAllTooltip = { title: getResource("RemoveAll"), text: getResource("ToRemoveAllTip") };

        var CcAddTooltip = { title: getResource("Add"), text: getResource("CcAddTip") };
        var CcRemoveTooltip = { title: getResource("Remove"), text: getResource("CcRemoveTip") };
        var CcRemoveAllTooltip = { title: getResource("RemoveAll"), text: getResource("CcRemoveAllTip") };

        var BccAddTooltip = { title: getResource("Add"), text: getResource("BccAddTip") };
        var BccRemoveTooltip = { title: getResource("Remove"), text: getResource("BccRemoveTip") };
        var BccRemoveAllTooltip = { title: getResource("RemoveAll"), text: getResource("BccRemoveAllTip") };

        if (this.OutlookItemType === "Appointment") {
            ToBoxName = getResource("AppointmentToBoxName");
            CcBoxName = getResource("AppointmentCcBoxName");
            BccBoxName = getResource("AppointmentBccBoxName");

            ToAddTooltip = { text: getResource("Add") };
            ToRemoveTooltip = { text: getResource("Remove") };
            ToRemoveAllTooltip = { text: getResource("RemoveAll") };

            CcAddTooltip = { text: getResource("Add") };
            CcRemoveTooltip = { text: getResource("Remove") };
            CcRemoveAllTooltip = { text: getResource("RemoveAll") };

            BccAddTooltip = { text: getResource("Add") };
            BccRemoveTooltip = { text: getResource("Remove") };
            BccRemoveAllTooltip = { text: getResource("RemoveAll") };
        } else if (this.OutlookItemType === "FaxForm") {
            ToBoxName = getResource("FaxFormToBoxName");
            ToAddTooltip = { text: getResource("Add") };
            ToRemoveTooltip = { text: getResource("Remove") };
            ToRemoveAllTooltip = { text: getResource("RemoveAll") };
        }

        this.ToCheck = new Ext.grid.CheckboxSelectionModel();
        this.ToColumn = new Ext.grid.ColumnModel([
			this.ToCheck,
			{ header: getResource("UserName"), dataIndex: 'ADDisplayName', menuDisabled: true, width: 50, renderer: this.RendererADDisplayName.createDelegate(this) }
		]);
        this.ToGrid = new Ext.grid.GridPanel({
            ddGroup: 'toDDGroup',
            enableDragDrop: true,
            enableColumnMove: false,
            border: false,
            ds: this.dsTOResult,
            cm: this.ToColumn,
            sm: this.ToCheck,
            stripeRows: true,
            viewConfig: {
                //autoFill:true,
                forceFit: true
            },
            bbar: ['->',
				{
				    tooltip: ToAddTooltip,
				    iconCls: 'add',
				    text: getResource("Add"),
				    handler: this.OnTOAddHandler,
				    scope: this
				},
				{
				    tooltip: ToRemoveTooltip,
				    iconCls: 'delete',
				    text: getResource("Remove"),
				    handler: this.OnTORemoveHandler,
				    scope: this
				},
				{
				    tooltip: ToRemoveAllTooltip,
				    iconCls: 'cross',
				    text: getResource("RemoveAll"),
				    handler: this.OnTORemoveAllHandler,
				    scope: this
				}
			],
            title: ToBoxName,
            rowHeight: 1
        });

        this.CcCheck = new Ext.grid.CheckboxSelectionModel();
        this.CcColumn = new Ext.grid.ColumnModel([
			this.CcCheck,
			{ header: getResource("UserName"), dataIndex: 'ADDisplayName', menuDisabled: true, width: 50, renderer: this.RendererADDisplayName.createDelegate(this) }
		]);
        this.CcGrid = new Ext.grid.GridPanel({
            ddGroup: 'ccDDGroup',
            enableDragDrop: true,
            enableColumnMove: false,
            border: false,
            ds: this.dsCCResult,
            cm: this.CcColumn,
            sm: this.CcCheck,
            stripeRows: true,
            viewConfig: {
                //autoFill:true,
                forceFit: true
            },
            bbar: ['->',
				{
				    tooltip: CcAddTooltip,
				    iconCls: 'add',
				    text: getResource("Add"),
				    handler: this.OnCCAddHandler,
				    scope: this
				},
				{
				    tooltip: CcRemoveTooltip,
				    iconCls: 'delete',
				    text: getResource("Remove"),
				    handler: this.OnCCRemoveHandler,
				    scope: this
				},
				{
				    tooltip: CcRemoveAllTooltip,
				    iconCls: 'cross',
				    text: getResource("RemoveAll"),
				    handler: this.OnCCRemoveAllHandler,
				    scope: this
				}
			],
            title: CcBoxName,
            height: Ext.isIE6 ? 121 : 113
        });

        this.BccCheck = new Ext.grid.CheckboxSelectionModel();
        this.BccColumn = new Ext.grid.ColumnModel([
			this.BccCheck,
			{ header: getResource("UserName"), dataIndex: 'ADDisplayName', menuDisabled: true, width: 50, renderer: this.RendererADDisplayName.createDelegate(this) }
		]);
        this.BccGrid = new Ext.grid.GridPanel({
            ddGroup: 'bccDDGroup',
            enableDragDrop: true,
            enableColumnMove: false,
            border: false,
            ds: this.dsBCCResult,
            cm: this.BccColumn,
            sm: this.BccCheck,
            stripeRows: true,
            viewConfig: {
                //autoFill:true,
                forceFit: true
            },
            bbar: ['->',
				{
				    tooltip: BccAddTooltip,
				    iconCls: 'add',
				    text: getResource("Add"),
				    handler: this.OnBCCAddHandler,
				    scope: this
				},
				{
				    tooltip: BccRemoveTooltip,
				    iconCls: 'delete',
				    text: getResource("Remove"),
				    handler: this.OnBCCRemoveHandler,
				    scope: this
				},
				{
				    tooltip: BccRemoveAllTooltip,
				    iconCls: 'cross',
				    text: getResource("RemoveAll"),
				    handler: this.OnBCCRemoveAllHandler,
				    scope: this
				}
			],
            title: BccBoxName,
            height: Ext.isIE6 ? 121 : 113
        });

        if (this.OutlookItemType === "Task" || this.OutlookItemType === "FaxForm") {
            this.ResultBox = new Ext.Panel({
                region: 'east',
                layout: 'ux.row',
                margins: '5 5 0 0',
                bodyStyle: 'background:#DFE8F6;',
                width: 240,
                items: [this.ToGrid]
            });
        } else {
            this.ResultBox = new Ext.Panel({
                region: 'east',
                layout: 'ux.row',
                margins: '5 5 0 0',
                bodyStyle: 'background:#DFE8F6;',
                width: 240,
                items: [this.ToGrid, this.CcGrid, this.BccGrid]
            });
        }
    },

    OnDsSourceDataChanged: function (store) {
        if (store.reader.jsonData.NumOfPerson) {
            var num = store.reader.jsonData.NumOfPerson;
            var title = this.SelectGrid.title;
            title += " <span style='color:#e6ffff'>(" + getResource("Total") + num + getResource("PersonCount") + ")</span>";
            this.SelectGrid.setTitle(title);
        }
    },

    SetCoulumVisiable: function (eventFrom) {
        if (this.OutlookItemType === "FaxForm") {
            this.SelectColumn.setHidden(3, false); 	// 사번
            this.SelectColumn.setHidden(4, true); 	// 직무
            this.SelectColumn.setHidden(5, true); 	// 부서
            this.SelectColumn.setHidden(6, true); 	// 휴대폰
            this.SelectColumn.setHidden(7, true); 	// 사내전화
            this.SelectColumn.setHidden(8, false); 	// Fax
        } else {
            switch (eventFrom) {
                case "group":
                    this.SelectColumn.setHidden(1, true); 	// 직위
                    this.SelectColumn.setHidden(3, true); 	// 사번
                    this.SelectColumn.setHidden(4, true); 	// 직무
                    this.SelectColumn.setHidden(5, true); 	// 부서
                    this.SelectColumn.setHidden(6, true); 	// 휴대폰
                    this.SelectColumn.setHidden(7, true); 	// 사내전화
                    this.SelectColumn.setHidden(8, true); 	// Fax
                    break;
                case "teamcontact":
                    // 팀연락처
                    this.SelectColumn.setHidden(1, false); 	// 직위
                    this.SelectColumn.setHidden(3, true); 	// 사번
                    this.SelectColumn.setHidden(4, true); 	// 직무
                    this.SelectColumn.setHidden(5, true); 	// 부서
                    this.SelectColumn.setHidden(6, false); 	// 휴대폰
                    this.SelectColumn.setHidden(7, false); 	// 사내전화
                    this.SelectColumn.setHidden(8, false); 	// Fax
                    break;
                case "personalcontact":
                    // 개인주소록
                    this.SelectColumn.setHidden(1, false); 	// 직위
                    this.SelectColumn.setHidden(3, true); 	// 사번
                    this.SelectColumn.setHidden(4, true); 	// 직무
                    this.SelectColumn.setHidden(5, true); 	// 부서
                    this.SelectColumn.setHidden(6, false); 	// 휴대폰
                    this.SelectColumn.setHidden(7, false); 	// 사내전화
                    this.SelectColumn.setHidden(8, false); 	// Fax
                    break;
                case "search":
                    //break;
                case "company":
                    this.SelectColumn.setHidden(1, false); 	// 직위
                    if (this.isInnerCompany()) {
                        // 자회사
                        this.SelectColumn.setHidden(3, false); 	// 사번
                        this.SelectColumn.setHidden(4, false); 	// 직무
                        this.SelectColumn.setHidden(5, true); 	// 부서
                        this.SelectColumn.setHidden(6, true); 	// 휴대폰
                        this.SelectColumn.setHidden(7, true); 	// 사내전화
                        this.SelectColumn.setHidden(8, true); 	// Fax
                    } else {
                        // 관계사
                        this.SelectColumn.setHidden(3, false); 	// 사번
                        this.SelectColumn.setHidden(4, true); 	// 직무
                        this.SelectColumn.setHidden(5, false); 	// 부서
                        this.SelectColumn.setHidden(6, true); 	// 휴대폰
                        this.SelectColumn.setHidden(7, true); 	// 사내전화
                        this.SelectColumn.setHidden(8, true); 	// Fax
                    }
                default:
                    break;
            }
            if (eventFrom == "group") {
                this.SelectColumn.setColumnHeader(2, getResource("MailGroup")); // 메일그룹이름으로 변경
                this.SelectColumn.setColumnWidth(2, 800); // 메일그룹이름 size
            } else {
                this.SelectColumn.setColumnHeader(2, getResource("UserName")); // 이름으로 변경
                if (this.isInnerCompany()) {
                    if (g_langCode == "en") {
                        this.SelectColumn.setColumnWidth(2, 140); // 이름
                    } else {
                        this.SelectColumn.setColumnWidth(2, 65); // 이름
                    }
                } else {
                    this.SelectColumn.setColumnWidth(2, 65); // 이름
                }
            }
        }
    },

    ComboClearSelect: function () {
        this.GroupCombo.clearSelect();
        if (this.IsExistTeamRoom == true) {
            this.ContactMenu.clearSelect();
        }
    },

    Render: function () {
        var titleBox = null;
        switch (this.OutlookItemType) {
            case "Appointment":
                titleBox = this.getHeaderTitleBox(getResource("AppointmentOrgChartTitle"));
                break;
            case "Contact":
                titleBox = this.getHeaderTitleBox(getResource("ContactOrgChartTitle"));
                break;
            case "Task":
                titleBox = this.getHeaderTitleBox(getResource("TaskOrgChartTitle"));
                break;
            case "FaxForm":
                titleBox = this.getHeaderTitleBox(getResource("FaxFormOrgChartTitle"));
                break;
            case "Mail":
            default:
                titleBox = this.getHeaderTitleBox(getResource("MailOrgChartTitle"));
                break;
        }

        var searchBox = this.getEmpNameSearchBox();
        var treeBox = this.getCompanyDeptTree();
        var langCombo = new Ext.ux.LanguageCycleButton();

        var clearSearchBox = function () {
            var node = treeBox.getSelectionModel().getSelectedNode();
            if (node) {
                var company = this.getCurrentCompany();
                this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'dept', query: node.id} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                this.SetCoulumVisiable("company");
            }
            //searchBox.fireEvent('blur', searchBox);
            searchBox.focus(true, 300);
        };
        searchBox.ClearClick = clearSearchBox.createDelegate(this);

        var doSearchBox = function () {
            var strName = searchBox.getValue();
            if (strName != '') {
                if (strName.length >= 2 && strName.length < 8) {
                    var special = /.*[$\\@\\\#%\^\&\*\(\)\[\]\+\_\;\'\{\}\`\\\~\<\>\=\|\.\,\:\?\/\"\!\-].*/;
                    var alphanum = /^[a-zA-Z0-9_]+$/;
                    if (strName.search(special) == 0) {
                        searchBox.setValue('');
                        this.WarningMessageBox(getResource("NoUseSpecialMsg"), function () {
                            searchBox.focus();
                        });
                        return false;
                    } else if (alphanum.test(strName)) {
                        // 사번검색  --> NOTE: 사번검색할 때 3자로 제한해야함. sk로 검색하면 대박.
                        if (strName.length < 3) {
                            searchBox.setValue('');
                            this.WarningMessageBox(getResource("NoUseAlphaNumTwoWord"), function () {
                                searchBox.focus();
                            });
                            return false;
                        }
                    }
                    var company = this.getCurrentCompany();
                    this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'member', query: strName} });
                    this.SetCoulumVisiable("search");
                    this.SelectGrid.setTitle('[' + strName + '] ' + getResource("SearchResult"));
                    this.ComboClearSelect();
                    return true;
                } else {
                    searchBox.setValue('');
                    this.WarningMessageBox(getResource("UseSearch"), function () {
                        searchBox.focus();
                    });
                    return false;
                }
            }
            return false;
        };
        searchBox.SearchClick = doSearchBox.createDelegate(this);

        treeBox.getLoader().on('load', function (treeLoader, node, response) {
            if (this.isInnerCompany()) {
                if (node == treeBox.root) {
                    node.expandChildNodes();
                }
            }
            else if (treeBox.root.children && treeBox.root.children.length == 1) {
                treeBox.root.expandChildNodes();
            }
        }, this);

        treeBox.getSelectionModel().on('selectionchange', function (t, node) {
            if (node) {
                node.ensureVisible();
                searchBox.onTrigger1Click(true);
                var company = this.getCurrentCompany();
                this.SetCoulumVisiable("company");
                this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'dept', query: node.id} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                this.ComboClearSelect();
            }
        }, this);

        treeBox.getLoader().on('beforeload', function (treeLoader, node) {
            if (treeLoader.baseParams) {
                var company = this.getCurrentCompany();
                treeLoader.baseParams.companyCode = company.companyCode;
                treeLoader.baseParams.isRelative = company.isRelative;
            }
        }, this);

        this.GroupCombo.on("change", function (combo, item) {
            if (!this.isInnerCompany()) return;
            if (this.IsExistTeamRoom == true) {
                this.ContactMenu.clearSelect();
            }
            var company = this.getCurrentCompany();
            this.SetCoulumVisiable("group");
            searchBox.onTrigger1Click(true);
            this.dsSource.load({ params: { companyCode: company.companyCode, mode: 'group', query: item.groupTypeCode} });
            this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(item.groupTypeName));
        }, this);

        this.CompanyCombo.on("change", function (combo, item) {
            this.ComboClearSelect();
            treeBox.getRootNode().children = null;
            treeBox.getRootNode().reload();
            if (item.isRelative === "N") {
                this.GroupCombo.show();
                if (item.companyCode === this.MyCompanyCode) {
                    treeBox.expandPath(this.MyDeptSelectPath);
                    treeBox.selectPath(this.MyDeptSelectPath);
                }
            } else {
                this.GroupCombo.hide();
            }
        }, this);

        var mainPanelItems = [treeBox, this.SelectGrid, this.ResultBox];
        if (this.OutlookItemType === "Contact") {
            mainPanelItems = [treeBox, this.SelectGrid];
        }
        var mainPanelBtn = [{ text: getResource("OkBtn"), handler: this.OnOK, scope: this },
			{ text: getResource("CancelBtn"), handler: this.OnCancel, scope: this}];
        if (this.OutlookItemType === "Mail" && this.CMGAdmin === true) {
            mainPanelBtn = [{ text: getResource("OkBtn"), handler: this.OnOK, scope: this },
			{ text: getResource("CancelBtn"), handler: this.OnCancel, scope: this },
			{ text: getResource("CMGTitle"), handler: this.OnCMGManager, scope: this}];
        }

        if (this.IsExistTeamRoom == true) {
            this.ContactMenu.on("change", function (combo, item) {
                this.GroupCombo.clearSelect();
                searchBox.onTrigger1Click(true);
                var contactItem = combo.getActiveItem();
                if (contactItem) {
                    if (contactItem.menuID == "OC") {
                        this.OnPersonalContacts();
                    } else if (contactItem.menuID == "TC") {
                        this.OnTeamContacts(contactItem.CoPName, contactItem.CoPID);
                    } else if (contactItem.menuID == "GC") {
                        this.OnAddrBookGrpContacts(contactItem.CoPName, contactItem.CoPID);
                    }

                }
            }, this);
        }

        //var mainToolBar = ['-', this.CompanyCombo, '-', this.ContactMenu, '-', this.GroupCombo, '->', '-', searchBox, '-', langCombo, '-'];
        var mainToolBar = ['-', this.CompanyCombo, '-', this.ContactMenu, '-', '->', '-', searchBox, '-', langCombo, '-'];
        if (this.OutlookItemType === "FaxForm") {
            mainToolBar = ['-', this.CompanyCombo, '-', this.ContactMenu, '->', '-', searchBox, '-', langCombo, '-'];
        }

        var mainPanel = new Ext.Panel({
            region: 'center',
            layout: 'border',
            border: false,
            bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
            tbar: mainToolBar,
            items: mainPanelItems,
            buttons: mainPanelBtn,
            buttonAlign: 'center'
        });

        var viewport = new Ext.Viewport({
            layout: 'border',
            items: [titleBox, mainPanel]
        });

        viewport.doLayout();

        mainPanel.footer.applyStyles('background: #FFFFFF none repeat scroll 0 0;');

        treeBox.expandPath(this.MyDeptSelectPath);
        treeBox.selectPath(this.MyDeptSelectPath);
    },

    AllSelectionClear: function () {
        this.SelectCheck.clearSelections();
        this.ToCheck.clearSelections();
        this.CcCheck.clearSelections();
        this.BccCheck.clearSelections();

        var selectHeader = this.SelectGrid.getView().getHeaderCell(0).childNodes[0];
        var toHeader = this.ToGrid.getView().getHeaderCell(0).childNodes[0];
        var ccHeader = this.CcGrid.getView().getHeaderCell(0).childNodes[0];
        var bccHeader = this.BccGrid.getView().getHeaderCell(0).childNodes[0];

        Ext.get(selectHeader).removeClass('x-grid3-hd-checker-on');
        Ext.get(toHeader).removeClass('x-grid3-hd-checker-on');
        Ext.get(ccHeader).removeClass('x-grid3-hd-checker-on');
        Ext.get(bccHeader).removeClass('x-grid3-hd-checker-on');
    },

    OnOK: function () {
        var result = {};
        result.To = [];
        result.Cc = [];
        result.Bcc = [];

        if (this.OutlookItemType === "Contact") {
            this.dsTOResult.removeAll();
            if (this.SelectCheck) {
                var data = this.SelectCheck.getSelected();
                if (data) {
                    this.dsTOResult.add(data);
                }
            }
        }

        if (this.dsTOResult.getCount() > 0) {
            this.dsTOResult.each(function (record) {
                result.To[result.To.length] = record.data;
            });
        }
        if (this.dsCCResult.getCount() > 0) {
            this.dsCCResult.each(function (record) {
                result.Cc[result.Cc.length] = record.data;
            });
        }
        if (this.dsBCCResult.getCount() > 0) {
            this.dsBCCResult.each(function (record) {
                result.Bcc[result.Bcc.length] = record.data;
            });
        }

        if (this.Application == 'outlook') {
            var orgchartData = Ext.encode(result);
            window.external.Ok(orgchartData);
        }
        else {
            window.returnValue = result;
            window.close();
        }
    },

    OnCancel: function () {
        if (this.Application == 'outlook') {
            window.external.Cancel();
        }
        else {
            // OWA에서 기존에 반영된 것을 유지해야 한다.
            window.returnValue = null;
            window.close();
        }
    },

    OnCMGManager: function () {
        var params = Ext.urlDecode(window.location.search.substring(1), true);
        params.app = "CustomMailGroup";
        window.location.search = Ext.urlEncode(params);
    },

    // 팀연락처
    OnTeamContacts: function (CoPName, CoPID) {
        if (this.GroupCombo.getActiveItem()) this.GroupCombo.clearSelect();
        this.dsSource.load({ params: { mode: 'team', query: CoPID} });
        this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(CoPName));
        this.SetCoulumVisiable("teamcontact");
    },

    // 팀연락처
    OnAddrBookGrpContacts: function (name, id) {
        if (this.GroupCombo.getActiveItem()) this.GroupCombo.clearSelect();
        this.dsSource.load({ params: { mode: 'addgrp', query: id} });
        this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(name));
        this.SetCoulumVisiable("teamcontact");
    },

    OnPersonalContacts: function () {
        if (this.GroupCombo.getActiveItem()) this.GroupCombo.clearSelect();
        this.dsSource.load({ params: { mode: 'contacts'} });
        this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(getResource("AddressBook")));
        this.SetCoulumVisiable("personalcontact");
    },

    ToSelectionClear: function () {
        this.SelectCheck.clearSelections();
        this.ToCheck.clearSelections();

        var selectHeader = this.SelectGrid.getView().getHeaderCell(0).childNodes[0];
        var toHeader = this.ToGrid.getView().getHeaderCell(0).childNodes[0];

        Ext.get(selectHeader).removeClass('x-grid3-hd-checker-on');
        Ext.get(toHeader).removeClass('x-grid3-hd-checker-on');
    },

    InitializeDragdropOnlyTo: function () {
        var mask = new Ext.LoadMask(this.ToGrid.getView().el, { msg: getResource("WaitMsg") });
        var dsTo = this.dsTOResult;
        var clearCheck = this.ToSelectionClear.createDelegate(this);
        var validateEmail = this.ValidateEmail;
        var warningMsgBox = this.WarningMessageBox;

        var isFaxForm = (this.OutlookItemType === "FaxForm")

        this.SelectDropTarget = new Ext.dd.DropTarget(this.SelectGrid.getView().el.dom.childNodes[0].childNodes[1], {
            ddGroup: 'toDDGroup',
            notifyDrop: function (ddSource, e, data) {
                function HandlerSelectDrop(record, index, allItems) {
                    ddSource.grid.store.remove(record);
                };
                mask.show();
                if (ddSource.dragData.selections.length == ddSource.grid.store.getCount())
                    ddSource.grid.store.removeAll();
                else
                    Ext.each(ddSource.dragData.selections, HandlerSelectDrop);
                mask.hide();
                clearCheck();
                return (true);
            }
        });

        this.ToDropTarget = new Ext.dd.DropTarget(this.ToGrid.getView().el.dom.childNodes[0].childNodes[1], {
            ddGroup: 'srcDDGroup',
            notifyDrop: function (ddSource, e, data) {
                function HandlerToDrop(record, index, allItems) {
                    var isFound = dsTo.find('Email', record.data.Email);
                    if (isFound == -1) {
                        dsTo.add(record);
                        ddSource.grid.store.remove(record);
                    }
                };
                mask.show();
                var strNoEmailUserList = "";
                Ext.each(ddSource.dragData.selections, function (record, index, allItems) {
                    if (isFaxForm) {
                        if (record.data.FaxNumber == "") return true;
                    }
                    if (!validateEmail(record.data.Email) && record.data.Type != "CONTACTS_GROUP") {
                        strNoEmailUserList += record.data.UserName + ', ';
                        return true;
                    }
                    var isFound = dsTo.find('Email', record.data.Email);
                    if (isFound == -1)
                        dsTo.add(record);
                });
                mask.hide();
                if (strNoEmailUserList.length > 1) {
                    strNoEmailUserList = strNoEmailUserList.substring(0, strNoEmailUserList.length - 2);
                    warningMsgBox(getResource("NoEmailUserAdd") + "<br/>" + strNoEmailUserList);
                }
                clearCheck();
                return (true);
            }
        });
    },

    InitializeDragdrop: function () {
        var dsTo = this.dsTOResult;
        var dsCc = this.dsCCResult;
        var dsBcc = this.dsBCCResult;

        var sGrid = this.SelectGrid;
        var tGrid = this.ToGrid;
        var cGrid = this.CcGrid;
        var bGrid = this.BccGrid;

        var clearCheck = this.AllSelectionClear.createDelegate(this);
        var validateEmail = this.ValidateEmail;
        var warningMsgBox = this.WarningMessageBox;

        var toMask = new Ext.LoadMask(this.ToGrid.getView().el, { msg: getResource("WaitMsg") });
        var ccMask = new Ext.LoadMask(this.CcGrid.getView().el, { msg: getResource("WaitMsg") });
        var bccMask = new Ext.LoadMask(this.BccGrid.getView().el, { msg: getResource("WaitMsg") });

        // truefree 2009-04-11
        // 중복옵션 처리를 위해 변수 신규 설정
        var overlap = this.Overlap;
        var CheckIsExist = this.CheckIsExist;

        this.ToDropTarget = new Ext.dd.DropTarget(tGrid.getView().el.dom.childNodes[0].childNodes[1], {
            ddGroup: 'srcDDGroup',
            notifyDrop: function (ddSource, e, data) {
                function HandlerToDrop(record, index, allItems) {
                    var isFound = dsTo.find('Email', record.data.Email);
                    if (isFound == -1) {
                        dsTo.add(record);
                        ddSource.grid.store.remove(record);
                    }
                };
                switch (ddSource.ddGroup) {
                    case 'srcDDGroup':
                        toMask.show();
                        var strNoEmailUserList = "";
                        Ext.each(ddSource.dragData.selections, function (record, index, allItems) {
                            if (!validateEmail(record.data.Email) && record.data.Type != "CONTACTS_GROUP") {
                                strNoEmailUserList += record.data.UserName + ', ';
                                return true;
                            }
                            var isFound = dsTo.find('Email', record.data.Email);
                            if (isFound == -1) {
                                var isExist = false;

                                if (overlap == "false")
                                    isExist = CheckIsExist(record, dsCc, dsBcc);

                                if (isExist == false)
                                    dsTo.add(record);
                            }
                        });
                        toMask.hide();
                        if (strNoEmailUserList.length > 1) {
                            strNoEmailUserList = strNoEmailUserList.substring(0, strNoEmailUserList.length - 2);
                            warningMsgBox(getResource("NoEmailUserAdd") + "<br/>" + strNoEmailUserList);
                        }
                        break;
                    case 'ccDDGroup':
                        toMask.show();
                        ccMask.show();
                        Ext.each(ddSource.dragData.selections, HandlerToDrop);
                        ccMask.hide();
                        toMask.hide();
                        break;
                    case 'bccDDGroup':
                        bccMask.show();
                        toMask.show();
                        Ext.each(ddSource.dragData.selections, HandlerToDrop);
                        toMask.hide();
                        bccMask.hide();
                        break;
                    default:
                        break;
                }
                clearCheck();
                return (true);
            }
        });
        this.ToDropTarget.addToGroup('ccDDGroup');
        this.ToDropTarget.addToGroup('bccDDGroup');

        this.CcDropTarget = new Ext.dd.DropTarget(cGrid.getView().el.dom.childNodes[0].childNodes[1], {
            ddGroup: 'srcDDGroup',
            notifyDrop: function (ddSource, e, data) {
                function HandlerCcDrop(record, index, allItems) {
                    var isFound = dsCc.find('Email', record.data.Email);
                    if (isFound == -1) {
                        dsCc.add(record);
                        ddSource.grid.store.remove(record);
                    }
                };
                switch (ddSource.ddGroup) {
                    case 'srcDDGroup':
                        ccMask.show();
                        var strNoEmailUserList = "";
                        Ext.each(ddSource.dragData.selections, function (record, index, allItems) {
                            if (!validateEmail(record.data.Email) && record.data.Type != "CONTACTS_GROUP") {
                                strNoEmailUserList += record.data.UserName + ', ';
                                return true;
                            }
                            var isFound = dsCc.find('Email', record.data.Email);
                            if (isFound == -1) {
                                var isExist = false;

                                if (overlap == "false")
                                    isExist = CheckIsExist(record, dsTo, dsBcc);

                                if (isExist == false)
                                    dsCc.add(record);
                            }
                        });
                        ccMask.hide();
                        if (strNoEmailUserList.length > 1) {
                            strNoEmailUserList = strNoEmailUserList.substring(0, strNoEmailUserList.length - 2);
                            warningMsgBox(getResource("NoEmailUserAdd") + "<br/>" + strNoEmailUserList);
                        }
                        break;
                    case 'toDDGroup':
                        toMask.show();
                        ccMask.show();
                        Ext.each(ddSource.dragData.selections, HandlerCcDrop);
                        ccMask.hide();
                        toMask.hide();
                        break;
                    case 'bccDDGroup':
                        bccMask.show();
                        ccMask.show();
                        Ext.each(ddSource.dragData.selections, HandlerCcDrop);
                        ccMask.hide();
                        bccMask.hide();
                        break;
                    default:
                        break;
                }
                clearCheck();
                return (true);
            }
        });
        this.CcDropTarget.addToGroup('toDDGroup');
        this.CcDropTarget.addToGroup('bccDDGroup');

        this.BccDropTarget = new Ext.dd.DropTarget(bGrid.getView().el.dom.childNodes[0].childNodes[1], {
            ddGroup: 'srcDDGroup',
            notifyDrop: function (ddSource, e, data) {
                function HandlerBccDrop(record, index, allItems) {
                    var isFound = dsBcc.find('Email', record.data.Email);
                    if (isFound == -1) {
                        dsBcc.add(record);
                        ddSource.grid.store.remove(record);
                    }
                };
                switch (ddSource.ddGroup) {
                    case 'srcDDGroup':
                        bccMask.show();
                        var strNoEmailUserList = "";
                        Ext.each(ddSource.dragData.selections, function (record, index, allItems) {
                            if (!validateEmail(record.data.Email) && record.data.Type != "CONTACTS_GROUP") {
                                strNoEmailUserList += record.data.UserName + ', ';
                                return true;
                            }
                            var isFound = dsBcc.find('Email', record.data.Email);
                            if (isFound == -1) {
                                var isExist = false;

                                if (overlap == "false")
                                    isExist = CheckIsExist(record, dsTo, dsCc);

                                if (isExist == false)
                                    dsBcc.add(record);
                            }
                        });
                        bccMask.hide();
                        if (strNoEmailUserList.length > 1) {
                            strNoEmailUserList = strNoEmailUserList.substring(0, strNoEmailUserList.length - 2);
                            warningMsgBox(getResource("NoEmailUserAdd") + "<br/>" + strNoEmailUserList);
                        }
                        break;
                    case 'toDDGroup':
                        toMask.show();
                        bccMask.show();
                        Ext.each(ddSource.dragData.selections, HandlerBccDrop);
                        bccMask.hide();
                        toMask.hide();
                        break;
                    case 'ccDDGroup':
                        bccMask.show();
                        ccMask.show();
                        Ext.each(ddSource.dragData.selections, HandlerBccDrop);
                        ccMask.hide();
                        bccMask.hide();
                        break;
                    default:
                        break;
                }
                clearCheck();
                return (true);
            }
        });
        this.BccDropTarget.addToGroup('toDDGroup');
        this.BccDropTarget.addToGroup('ccDDGroup');

        this.SelectDropTarget = new Ext.dd.DropTarget(sGrid.getView().el.dom.childNodes[0].childNodes[1], {
            ddGroup: 'toDDGroup',
            notifyDrop: function (ddSource, e, data) {
                function HandlerSelectDrop(record, index, allItems) {
                    ddSource.grid.store.remove(record);
                };
                switch (ddSource.ddGroup) {
                    case 'toDDGroup':
                        toMask.show();
                        if (ddSource.dragData.selections.length == ddSource.grid.store.getCount())
                            ddSource.grid.store.removeAll();
                        else
                            Ext.each(ddSource.dragData.selections, HandlerSelectDrop);
                        toMask.hide();
                        break;
                    case 'ccDDGroup':
                        ccMask.show();
                        if (ddSource.dragData.selections.length == ddSource.grid.store.getCount())
                            ddSource.grid.store.removeAll();
                        else
                            Ext.each(ddSource.dragData.selections, HandlerSelectDrop);
                        ccMask.hide();
                        break;
                    case 'bccDDGroup':
                        bccMask.show();
                        if (ddSource.dragData.selections.length == ddSource.grid.store.getCount())
                            ddSource.grid.store.removeAll();
                        else
                            Ext.each(ddSource.dragData.selections, HandlerSelectDrop);
                        bccMask.hide();
                        break;
                    default:
                        break;
                }
                clearCheck();
                return (true);
            }
        });
        this.SelectDropTarget.addToGroup('ccDDGroup');
        this.SelectDropTarget.addToGroup('bccDDGroup');
    },

    // truefree 2009-04-11
    // 중복 체크를 위한 함수 - Drag&Drop Handler용
    CheckIsExist: function (record, ds1, ds2) {
        var isExist = false;

        // DS1 에 있는지 검사
        for (var iResult = 0; iResult < ds1.getCount(); iResult++) {
            if (record.data.Email == "" && record.data.Type == "USER") {// 사번비교
                var isFound = ds1.find('EmpID', record.data.EmpID);
                if (isFound > -1) {
                    isExist = true;
                    break;
                }
            } else {// 메일주소로 비교
                var isFound = ds1.find('Email', record.data.Email);
                if (isFound > -1) {
                    isExist = true;
                    break;
                }
            }
        }

        // ds2 에 있는지 검사
        for (var iResult = 0; iResult < ds2.getCount(); iResult++) {
            if (record.data.Email == "" && record.data.Type == "USER") {// 사번비교
                var isFound = ds2.find('EmpID', record.data.EmpID);
                if (isFound > -1) {
                    isExist = true;
                    break;
                }
            } else {// 메일주소로 비교
                var isFound = ds2.find('Email', record.data.Email);
                if (isFound > -1) {
                    isExist = true;
                    break;
                }
            }
        }

        return isExist;
    },

    OnTOAddHandler: function () {
        var mask = new Ext.LoadMask(this.ToGrid.getView().el, { msg: getResource("WaitMsg") });
        if (this.SelectCheck.getSelections().length > 0) {
            mask.show();
            var strNoEmailUserList = "";
            Ext.each(this.SelectCheck.getSelections(), function (record, index, allItems) {
                if (this.OutlookItemType === "FaxForm") {
                    if (record.data.FaxNumber == "") return true;
                }
                if (!this.ValidateEmail(record.data.Email) && record.data.Type != "CONTACTS_GROUP") {
                    strNoEmailUserList += record.data.UserName + ', ';
                    return true;
                }
                // Email 유일키
                var foundItem = this.dsTOResult.find('Email', record.data.Email);
                if (foundItem == -1) {
                    var isExist = false;

                    // 중복 옵션이 false면 중복 체크
                    if (this.Overlap == "false")
                        isExist = this.CheckIsExist(record, this.dsCCResult, this.dsBCCResult);

                    if (isExist == false)
                        this.dsTOResult.add(record);
                }
            }, this);
            this.dsTOResult.fireEvent("datachanged", this.dsTOResult);
            mask.hide();
            if (strNoEmailUserList.length > 1) {
                strNoEmailUserList = strNoEmailUserList.substring(0, strNoEmailUserList.length - 2);
                this.WarningMessageBox(getResource("NoEmailUserAdd") + "<br/>" + strNoEmailUserList);
            }
        }
        if (this.OutlookItemType === "Task" || this.OutlookItemType === "FaxForm") {
            this.ToSelectionClear();
        } else {
            this.AllSelectionClear();
        }
    },

    OnTORemoveHandler: function () {
        var mask = new Ext.LoadMask(this.ToGrid.getView().el, { msg: getResource("WaitMsg") });
        if (this.ToCheck.getSelections().length > 0) {
            mask.show();
            if (this.ToCheck.getSelections().length == this.dsTOResult.getCount()) {
                this.dsTOResult.removeAll();
            }
            else {
                Ext.each(this.ToCheck.getSelections(), function (record, index, allItems) {
                    this.dsTOResult.remove(record);
                }, this);
            }
            this.dsTOResult.fireEvent("datachanged", this.dsTOResult);
            mask.hide();
        }
        if (this.OutlookItemType === "Task" || this.OutlookItemType === "FaxForm") {
            this.ToSelectionClear();
        } else {
            this.AllSelectionClear();
        }
    },

    OnTORemoveAllHandler: function () {
        var mask = new Ext.LoadMask(this.ToGrid.getView().el, { msg: getResource("WaitMsg") });
        if (this.dsTOResult.getCount() > 0) {
            mask.show();
            this.dsTOResult.removeAll();
            this.dsTOResult.fireEvent("datachanged", this.dsTOResult);
            mask.hide();
        }
        if (this.OutlookItemType === "Task" || this.OutlookItemType === "FaxForm") {
            this.ToSelectionClear();
        } else {
            this.AllSelectionClear();
        }
    },

    OnCCAddHandler: function () {
        var mask = new Ext.LoadMask(this.CcGrid.getView().el, { msg: getResource("WaitMsg") });
        if (this.SelectCheck.getSelections().length > 0) {
            mask.show();
            var strNoEmailUserList = "";
            Ext.each(this.SelectCheck.getSelections(), function (record, index, allItems) {
                if (this.OutlookItemType === "FaxForm") {
                    if (record.data.FaxNumber == "") return true;
                }
                if (!this.ValidateEmail(record.data.Email) && record.data.Type != "CONTACTS_GROUP") {
                    strNoEmailUserList += record.data.UserName + ', ';
                    return true;
                }
                // Email 유일키
                var foundItem = this.dsCCResult.find('Email', record.data.Email);
                if (foundItem == -1) {
                    var isExist = false;

                    // 중복검사 옵션이 false면 중복 체크
                    if (this.Overlap == "false")
                        isExist = this.CheckIsExist(record, this.dsTOResult, this.dsBCCResult);

                    if (isExist == false)
                        this.dsCCResult.add(record);
                }
            }, this);

            this.dsCCResult.fireEvent("datachanged", this.dsCCResult);
            mask.hide();
            if (strNoEmailUserList.length > 1) {
                strNoEmailUserList = strNoEmailUserList.substring(0, strNoEmailUserList.length - 2);
                this.WarningMessageBox(getResource("NoEmailUserAdd") + "<br/>" + strNoEmailUserList);
            }
        }
        this.AllSelectionClear();
    },

    OnCCRemoveHandler: function () {
        var mask = new Ext.LoadMask(this.CcGrid.getView().el, { msg: getResource("WaitMsg") });
        if (this.CcCheck.getSelections().length > 0) {
            mask.show();
            if (this.CcCheck.getSelections().length == this.dsCCResult.getCount()) {
                this.dsCCResult.removeAll();
            }
            else {
                Ext.each(this.CcCheck.getSelections(), function (record, index, allItems) {
                    this.dsCCResult.remove(record);
                }, this);
            }
            this.dsCCResult.fireEvent("datachanged", this.dsCCResult);
            mask.hide();
        }
        this.AllSelectionClear();
    },

    OnCCRemoveAllHandler: function () {
        var mask = new Ext.LoadMask(this.CcGrid.getView().el, { msg: getResource("WaitMsg") });
        if (this.dsCCResult.getCount() > 0) {
            mask.show();
            this.dsCCResult.removeAll();
            this.dsCCResult.fireEvent("datachanged", this.dsCCResult);
            mask.hide();
        }
        this.AllSelectionClear();
    },

    OnBCCAddHandler: function () {
        var mask = new Ext.LoadMask(this.BccGrid.getView().el, { msg: getResource("WaitMsg") });
        if (this.SelectCheck.getSelections().length > 0) {
            mask.show();
            var strNoEmailUserList = "";

            Ext.each(this.SelectCheck.getSelections(), function (record, index, allItems) {
                if (this.OutlookItemType === "FaxForm") {
                    if (record.data.FaxNumber == "") return true;
                }
                if (!this.ValidateEmail(record.data.Email) && record.data.Type != "CONTACTS_GROUP") {
                    strNoEmailUserList += record.data.UserName + ', ';
                    return true;
                }
                // Email 유일키
                var foundItem = this.dsBCCResult.find('Email', record.data.Email);
                if (foundItem == -1) {
                    var isExist = false;

                    // 중복검사 옵션이 false면 중복 체크
                    if (this.Overlap == "false")
                        isExist = this.CheckIsExist(record, this.dsTOResult, this.dsCCResult);

                    if (isExist == false)
                        this.dsBCCResult.add(record);
                }
            }, this);

            this.dsBCCResult.fireEvent("datachanged", this.dsBCCResult);
            mask.hide();
            if (strNoEmailUserList.length > 1) {
                strNoEmailUserList = strNoEmailUserList.substring(0, strNoEmailUserList.length - 2);
                this.WarningMessageBox(getResource("NoEmailUserAdd") + "<br/>" + strNoEmailUserList);
            }
        }
        this.AllSelectionClear();
    },

    OnBCCRemoveHandler: function () {
        var mask = new Ext.LoadMask(this.BccGrid.getView().el, { msg: getResource("WaitMsg") });
        if (this.BccCheck.getSelections().length > 0) {
            mask.show();
            if (this.BccCheck.getSelections().length == this.dsBCCResult.getCount()) {
                this.dsBCCResult.removeAll();
            }
            else {
                Ext.each(this.BccCheck.getSelections(), function (record, index, allItems) {
                    this.dsBCCResult.remove(record);
                }, this);
            }
            this.dsBCCResult.fireEvent("datachanged", this.dsBCCResult);
            mask.hide();
        }
        this.AllSelectionClear();
    },

    OnBCCRemoveAllHandler: function () {
        var mask = new Ext.LoadMask(this.BccGrid.getView().el, { msg: getResource("WaitMsg") });
        if (this.dsBCCResult.getCount() > 0) {
            mask.show();
            this.dsBCCResult.removeAll();
            this.dsBCCResult.fireEvent("datachanged", this.dsBCCResult);
            mask.hide();
        }
        this.AllSelectionClear();
    },

    RendererUserName: function (value, meta, record, rowIndex, colIndex, store) {
        var strName = value;
        // 메일 조직도에서는 리스트에 자회사일 경우 부서가 보여진다.
        if (record.data.Type != "USER" && record.data.Type != "CONTACTS_USER") {
            // 부서 또는 그룹이다
            // 스타일 변경
            meta.attr = meta.attr + ' style="position:relative;overflow:visible;font-weight:700;color:#800000;" ';
        }
        // 자회사인 경우에만
        //if(this.isInnerCompany())

        //{

        // Presence 삭제 (2010-11-25)
        // Presence를 렌더링 해준다.
        // 자회사인 경우는 사번이 항상 있다.
        //			if(record.data.Email != "" && record.data.Type == "USER")
        //			{
        //				if(record.data.EmpID.length < 1) { 
        //					//alert('사번이 없는 유저');
        //				} else {
        //					var presence = GW.NameControl.toHTMLString(record.data.Email, record.data.EmpID);
        //					strName = presence + strName;
        //				}
        //			}
        //}

        // tooltip의 내용을 자세하게 ~
        if (typeof value == "string" && value.length > 0) {
            var title = record.data.ADDisplayName;
            if (record.data.Type != "USER" || title == "") {
                title = record.data.UserName;
            }
            var qtiptitle = ' ext:qtitle="' + Ext.util.Format.htmlEncode(Ext.util.Format.htmlEncode(title)) + '"  ext:qtip="';
            var qtip = '';

            if (record.data.CompanyName != "") qtip += getResource("UserCompany") + ': ' + Ext.util.Format.htmlEncode(record.data.CompanyName) + '<br/>';
            if (record.data.EmpID != "" && record.data.Type == "USER") qtip += getResource("UserEmpID") + ': ' + Ext.util.Format.htmlEncode(record.data.EmpID) + '<br/>';
            if (record.data.RankName != "") qtip += getResource("UserRank") + ': ' + Ext.util.Format.htmlEncode(record.data.RankName) + '<br/>';
            if (record.data.DutyName != "") qtip += getResource("UserDuty") + ': ' + Ext.util.Format.htmlEncode(record.data.DutyName) + '<br/>';
            if (record.data.DeptName != "") qtip += getResource("UserDept") + ': ' + Ext.util.Format.htmlEncode(record.data.DeptName) + '<br/>';
            if (record.data.Email != "" && record.data.Type != "CONTACTS_GROUP") qtip += getResource("UserEmail") + ': ' + Ext.util.Format.htmlEncode(record.data.Email) + '<br/>';
            if (record.data.CellPhone != "") qtip += getResource("UserCellPhone") + ': ' + Ext.util.Format.htmlEncode(record.data.CellPhone) + '<br/>';
            if (record.data.ExtensionNumber != "") qtip += getResource("UserOfficeTel") + ': ' + Ext.util.Format.htmlEncode(record.data.ExtensionNumber) + '<br/>';
            if (record.data.FaxNumber != "") qtip += getResource("UserFax") + ': ' + Ext.util.Format.htmlEncode(record.data.FaxNumber) + '<br/>';

            if (qtip === '') {
                meta.attr = meta.attr + 'ext:qtip="' + Ext.util.Format.htmlEncode(title) + '" ';
            } else {
                meta.attr = meta.attr + qtiptitle + qtip + '" ';
            }
        }
        return strName;
    },

    RendererADDisplayName: function (value, meta, record, rowIndex, colIndex, store) {
        // ADDisplayName이 공백일 수 있다. (부서, 그룹, 없을 경우) UserName으로 보여준다.
        var strName = value;

        if (record.data.Type != "USER" || strName == "") {
            if (record.data.UserName != "")
                strName = record.data.UserName;
        }

        //tootip ( ext:qtip="")
        if (typeof strName == "string" && strName.length > 0) {
            if (this.ValidateEmail(record.data.Email)) {
                meta.attr = meta.attr + ' ext:qtitle="' + Ext.util.Format.htmlEncode(Ext.util.Format.htmlEncode(strName)) + '"  ext:qtip="' + getResource("UserEmail") + ': ' + Ext.util.Format.htmlEncode(record.data.Email) + '<br/>' + '" ';
            } else {
                meta.attr = meta.attr + ' ext:qtip="' + Ext.util.Format.htmlEncode(strName) + '" ';
            }
        }
        return strName;
    }
});

// 사용자 그룹 관리
GW.OrgMap.Common.CustomMailGroup = function (callFrom) {
    GW.OrgMap.Common.CustomMailGroup.superclass.constructor.call(this);
    this.OrgChartType = "CUSTOMMAILGROUP";
    this.Application = callFrom || 'owa';

    this.CustomMailGroupData = [
		{ name: 'GroupCode' },
		{ name: 'CompanyCode' },
		{ name: 'CompanyName' },
		{ name: 'GroupOrder', type: 'int' },
		{ name: 'DisplayYN' },
		{ name: 'CreatorLoginID' },
		{ name: 'CreatorUserName' },
		{ name: 'CreateDT', type: 'date', dateFormat: 'Y-m-d H:i:s' },
		{ name: 'ADCommonName' },
		{ name: 'GroupMail' },
		{ name: 'GroupName' },
		{ name: 'Description' }
	];

    this.dsCustomMailGroup = new Ext.data.JsonStore({
        url: g_OrgMapServerURL,
        baseParams: { action: 'getCustomGroup' },
        fields: this.CustomMailGroupData,
        remoteSort: false
    });

    this.CMGCheck = new Ext.grid.CheckboxSelectionModel({ singleSelect: true, header: "" });
    this.CMGColumn = new Ext.grid.ColumnModel([
		this.CMGCheck,
		new Ext.grid.RowNumberer(),
		{ header: getResource("CMGName"), dataIndex: 'GroupName', width: 150, menuDisabled: true, renderer: this.RendererCMGName.createDelegate(this) },
		{ header: getResource("CMGDisplay"), dataIndex: 'DisplayYN', width: 35, menuDisabled: true, renderer: this.RendererWithTooltip },
		{ header: getResource("UserCompany"), dataIndex: 'CompanyName', width: 105, menuDisabled: true, renderer: this.RendererWithTooltip },
		{ header: getResource("CMGOrder"), dataIndex: 'GroupOrder', width: 50, menuDisabled: true, renderer: this.RendererWithTooltip },
		{ header: getResource("UserEmail"), dataIndex: 'GroupMail', width: 150, menuDisabled: true, renderer: this.RendererWithTooltip },
		{ header: getResource("CMGCreator"), dataIndex: 'CreatorUserName', width: 50, menuDisabled: true, renderer: this.RendererWithTooltip },
		{ header: getResource("CMGCreateDate"), dataIndex: 'CreateDT', width: 120, menuDisabled: true, renderer: Ext.util.Format.dateRenderer('Y-m-d H:i:s') },
		{ header: 'ADCommonName', dataIndex: 'ADCommonName', width: 125, menuDisabled: true, renderer: this.RendererWithTooltip }
	]);
    this.CMGGrid = new Ext.grid.GridPanel({
        region: 'center',
        margins: '5 0 0 5',
        enableColumnMove: false,
        ds: this.dsCustomMailGroup,
        cm: this.CMGColumn,
        sm: this.CMGCheck,
        stripeRows: true,
        viewConfig: {
            autoFill: true
        },
        title: getResource("CMG"),
        loadMask: { msg: getResource("WaitMsg") },
        bbar: ['->', {
            tooltip: { title: getResource("CMGAddGroup"), text: getResource("CMGAddGroupTip") },
            text: getResource("CMGAddGroup"),
            iconCls: 'add',
            handler: this.AddCustomGroup,
            scope: this
        }, '-', {
            tooltip: { title: getResource("CMGModGroup"), text: getResource("CMGModGroupTip") },
            text: getResource("CMGModGroup"),
            iconCls: 'x-tbar-loading',
            handler: this.UpdateCustomGroup,
            scope: this
        }, '-', {
            tooltip: { title: getResource("CMGDelGroup"), text: getResource("CMGDelGroupTip") },
            text: getResource("CMGDelGroup"),
            iconCls: 'delete',
            handler: this.DeleteCustomGroup,
            scope: this
        }]
    });

    this.CMGContextMenu = new Ext.menu.Menu({
        items: [{
            text: getResource("CMGAddGroup"),
            iconCls: 'add',
            handler: this.AddCustomGroup,
            scope: this
        }, {
            text: getResource("CMGModGroup"),
            iconCls: 'x-tbar-loading',
            handler: this.UpdateCustomGroup,
            scope: this
        }, {
            text: getResource("CMGDelGroup"),
            iconCls: 'delete',
            handler: this.DeleteCustomGroup,
            scope: this
        }
		]
    });
    this.CMGGrid.on("rowcontextmenu", function (grid, index, e) {
        this.CMGContextMenu.showAt(e.getXY());
    }, this);

    // AD Property
    this.CMGMemberData = [
		{ name: "sAMAccountName" }, // primary key(로그인ID)
		{name: "title" }, 			// 직책
		{name: "displayName" }, 	// AD Display Name
		{name: "employeeNumber" }, // 사번
		{name: "company" }, 		// 회사
		{name: "department" }, 	// 부서
		{name: "dutyName" }, 			// extensionAttribute3 직무
		{name: "mail" }, 				// 메일주소
		{name: "telephoneNumber"} 	// 사내전화
	];
    this.dsCMGMember = new Ext.data.JsonStore({
        url: g_OrgMapServerURL,
        baseParams: { action: 'getCustomGroupMember' },
        root: 'dataRoot',
        fields: this.CMGMemberData,
        remoteSort: false
    });

    this.CMGMemberCheck = new Ext.grid.CheckboxSelectionModel();
    this.CMGMemberColumn = new Ext.grid.ColumnModel([
		this.CMGMemberCheck,
		new Ext.grid.RowNumberer(),
		{ header: getResource("UserJob"), dataIndex: 'title', width: 45, sortable: true, menuDisabled: true, renderer: this.RendererWithTooltip },
		{ header: getResource("UserName"), dataIndex: 'displayName', width: 80, sortable: true, menuDisabled: true, renderer: this.RendererCMGADDisplayName.createDelegate(this) },
		{ header: getResource("UserEmpID"), dataIndex: 'employeeNumber', width: 55, sortable: true, menuDisabled: true, renderer: this.RendererWithTooltip },
		{ header: getResource("UserDuty"), dataIndex: 'dutyName', width: 80, sortable: true, menuDisabled: true, renderer: this.RendererWithTooltip }
	]);
    this.CMGMemberGrid = new Ext.grid.GridPanel({
        region: 'east',
        width: 324,
        margins: '5 5 0 5',
        enableColumnMove: false,
        ds: this.dsCMGMember,
        cm: this.CMGMemberColumn,
        sm: this.CMGMemberCheck,
        stripeRows: true,
        viewConfig: {
            autoFill: true//,
            //forceFit:true
        },
        title: '&nbsp;&nbsp;',
        loadMask: { msg: getResource("WaitMsg") },
        bbar: ['->', {
            tooltip: { title: getResource("CMGRefresh"), text: getResource("CMGRefreshTip") },
            text: getResource("CMGRefresh"),
            iconCls: 'x-tbar-loading',
            handler: function () {
                this.dsCMGMember.reload();
            },
            scope: this
        }, '-', {
            tooltip: { title: getResource("CMGAddMember"), text: getResource("CMGAddMemberTip") },
            text: getResource("CMGAddMember"),
            iconCls: 'add',
            handler: this.AddMemberToCustomGroup,
            scope: this
        }, '-', {
            tooltip: { title: getResource("CMGDelMember"), text: getResource("CMGDelMemberTip") },
            text: getResource("CMGDelMember"),
            iconCls: 'delete',
            handler: this.DeleteMemberToCustomGroup,
            scope: this
        }]
    });

    this.InitCMGManager(function () {
        this.Render();
        this.fadeoutMainLoadMask();
    }, this);
    
};

Ext.extend(GW.OrgMap.Common.CustomMailGroup, GW.OrgMap.Common, {
    InitCMGManager: function (callback, scope) {
        Ext.Ajax.request({
            url: g_OrgMapServerURL,
            params: { action: 'CMGInitialize' },
            method: 'POST',
            success: function (response, option) {
                var data = Ext.util.JSON.decode(response.responseText);
                if (data) {
                    if (data.result == false) {
                        this.fadeoutMainLoadMask();
                        this.ErrorMessageBox(getResource("AjaxErrorMsg1") +
							Ext.util.Format.htmlEncode(data.ErrorMessage) + getResource("AjaxErrorMsg2"), function () {
							    this.OnClose();
							});
                        return;
                    }
                    this.commonData = data;
                    this.MyCompanyCode = data.MyCompanyCode;
                    this.MyDeptSelectPath = '/company-root' + data.MyDeptSelectPath;
                    this.MyEmail = data.UserEmail;
                    this.MyLoginID = data.MyLoginID;

                    this.CMGSuperAdmin = data.CMGSuperAdmin;
                    this.CMGCompanyRule = [];

                    //회사선택
                    var companyItems = [];
                    var mycompany = null;
                    for (var i = 0; i < data.InnerCompany.length; i++) {
                        companyItems[companyItems.length] = data.InnerCompany[i];
                        if (data.InnerCompany[i].checked) {
                            mycompany = data.InnerCompany[i];
                        }
                        this.CMGCompanyRule[this.CMGCompanyRule.length] = [
							data.InnerCompany[i].companyCode,
							data.InnerCompany[i].companyName,
							data.InnerCompany[i].MailDomainURI,
							data.InnerCompany[i].NameRulePrefix,
							data.InnerCompany[i].NameRuleSuffix
						];
                    }

                    this.CompanyCombo = new GW.OrgMap.ComboMenuButton({
                        items: companyItems
                    });
                    this.CompanyCombo.activeItem = mycompany;

                    if (callback) {
                        scope = scope || window;
                        callback.call(scope);
                    }
                }
            },
            failure: function (response, option) {
                this.fadeoutMainLoadMask();
                debugger;
                this.ErrorMessageBox(getResource("AjaxFailMsg"), function () {
                    window.close();
                });
            },
            scope: this
        });
    },

    Render: function () {
        var titleBox = this.getHeaderTitleBox(getResource("CMGTitle"));
        var params = Ext.urlDecode(window.location.search.substring(1), true);

        //        if (params.grp != undefined && params.grp != "") {
        //            this.dsCMGMember.load({ params: { groupADCN: params.grp} });
        //        }

        this.dsCustomMailGroup.on('datachanged', function (store) {
            this.dsCMGMember.removeAll();
            this.CMGMemberGrid.setTitle('&nbsp;&nbsp;');
        }, this);
        this.dsCMGMember.on('datachanged', this.OnDsCMGMemberDataChanged, this);
        this.dsCMGMember.on('load', function (s, r, o) {
            this.dsCMGMember.sort("title", "ASC");
        }, this);
        this.CMGCheck.on("selectionchange", function (sm) {
            var group = sm.getSelected();
            if (group) {
                this.dsCMGMember.load({ params: { groupADCN: group.get("GroupCode")} });
            }
        }, this);
        this.CompanyCombo.on("change", function (combo, item) {
            var company = this.CompanyCombo.getActiveItem();
            this.dsCustomMailGroup.load({ params: { companyCode: company.companyCode} });
        }, this);

        var mainPanel = new Ext.Panel({
            region: 'center',
            layout: 'border',
            border: false,
            bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
            //tbar:[ '-',this.CompanyCombo,'-'],
            items: [this.CMGGrid, this.CMGMemberGrid],
            buttons: [
				{
				    text: getResource("OrgMapTitle"),
				    handler: this.OnBack,
				    scope: this
				},
				{
				    text: getResource("CloseBtn"),
				    handler: this.OnClose,
				    scope: this
				}
			],
            buttonAlign: 'center'
        });

        var viewport = new Ext.Viewport({
            layout: 'border',
            items: [titleBox, mainPanel]
        });
        this.dsCustomMailGroup.load({ params: { companyCode: this.MyCompanyCode} });
        viewport.doLayout();

        mainPanel.footer.applyStyles('background: #FFFFFF none repeat scroll 0 0;');
    },

    OnDsCMGMemberDataChanged: function (store) {
        if (store.reader.jsonData.NumOfPerson) {
            var num = store.reader.jsonData.NumOfPerson;
            var group = this.CMGCheck.getSelected();
            if (group) {
                if (num != 0) {
                    this.CMGMemberGrid.setTitle(group.get("GroupName")
					+ " <span style='color:#e6ffff'>(" + getResource("Total", "ko") + num + getResource("PersonCount", "ko") + ")</span>");
                } else {
                    this.CMGMemberGrid.setTitle(group.get("GroupName"));
                }
            }
        }
    },

    RendererCMGName: function (value, meta, record, rowIndex, colIndex, store) {
        var strName = value;

        // tooltip의 내용을 자세하게 ~
        if (typeof value == "string" && value.length > 0) {
            var title = record.data.GroupName;
            var qtiptitle = ' ext:qtitle="' + Ext.util.Format.htmlEncode(Ext.util.Format.htmlEncode(title)) + '"  ext:qtip="';
            var qtip = '';

            if (record.data.GroupMail != "") qtip += getResource("UserEmail") + ': ' + Ext.util.Format.htmlEncode(record.data.GroupMail) + '<br/>';
            if (record.data.CompanyName != "") qtip += getResource("UserCompany") + ': ' + Ext.util.Format.htmlEncode(record.data.CompanyName) + '<br/>';
            if (record.data.DisplayYN != "") {
                qtip += getResource("CMGDisplay") + ': ' + Ext.util.Format.htmlEncode(record.data.DisplayYN) + '<br/>';
            }
            if (record.data.CreatorUserName != "") qtip += getResource("CMGCreator") + ': ' + Ext.util.Format.htmlEncode(record.data.CreatorUserName) + '<br/>';
            if (record.data.Description != "") qtip += getResource("CMGDesc") + ': ' + Ext.util.Format.htmlEncode(record.data.Description) + '<br/>';
            if (record.data.ADCommonName != "") qtip += 'AD Common Name: CN=' + Ext.util.Format.htmlEncode(record.data.ADCommonName) + '<br/>';

            if (qtip === '') {
                meta.attr = meta.attr + 'ext:qtip="' + Ext.util.Format.htmlEncode(title) + '" ';
            } else {
                meta.attr = meta.attr + qtiptitle + qtip + '" ';
            }
        }
        return strName;
    },

    AddCustomGroup: function () {
        if (!this.AddCustomGroupWindow) {
            function onSubmit() {
                if (!groupNameField.validate()) {
                    this.ErrorMessageBox(getResource("CMGMSG_InvalidGroupName"), function () { groupNameField.setRawValue(""); groupNameField.focus(); });
                } else {
                    this.AddCustomGroupWindow.hide();
                    Ext.MessageBox.show({ title: getResource("CMGMSG_CreateGroup"), msg: getResource("CMGMSG_CreateGroupInprogress"), width: 280, closable: false, icon: 'sk-wait-box' });
                    //var companyCode = companyCombo.getValue();
                    var groupOrder = form.items.get(1).getValue();
                    //var MailDomainURI = "skcorp.net";
                    //                    var rule = RuleStore.find("companyCode", companyCode);
                    //                    if (rule != -1) {
                    //                        rule = RuleStore.getAt(rule);
                    //                        MailDomainURI = rule.data.MailDomainURI;
                    //                    }
                    var groupName = groupNameField.getValue();
                    var description = form.items.get(2).getValue();

                    Ext.Ajax.request({
                        url: g_OrgMapServerURL,
                        params: {
                            action: 'createCustomGroup',
                            //companyCode: companyCode,
                            groupOrder: groupOrder,
                            //MailDomainURI: MailDomainURI,
                            groupName: groupName,
                            description: description
                        },
                        method: 'POST',
                        success: function (response, option) {
                            var callResult = Ext.util.JSON.decode(response.responseText);
                            if (callResult) {
                                if (callResult.result == false) {
                                    Ext.MessageBox.hide();
                                    this.ErrorMessageBox(getResource("CMGMSG_CreateGroupFail") +
										Ext.util.Format.htmlEncode(callResult.ErrorMessage));
                                } else {
                                    this.dsCustomMailGroup.reload();
                                    Ext.MessageBox.updateText(getResource("CMGMSG_CreateGroupSucceed"));
                                    setTimeout(function () { Ext.MessageBox.hide(); }, 800);
                                }
                            }
                        },
                        failure: function (response, option) {
                            Ext.MessageBox.hide();
                            debugger;
                            this.ErrorMessageBox(getResource("AjaxFailMsg"), function () {
                                window.close();
                            });
                        },
                        scope: this
                    });

                }
            };
            var RuleStore = new Ext.data.SimpleStore({
                fields: ['companyCode', 'companyName', 'MailDomainURI', 'NameRulePrefix', 'NameRuleSuffix'],
                data: this.CMGCompanyRule
            });
            //            var companyCombo = new Ext.ux.SelectBox({
            //                fieldLabel: getResource("UserCompany"),
            //                store: RuleStore,
            //                displayField: 'companyName',
            //                valueField: 'companyCode',
            //                //anchor:'95%',
            //                mode: 'local'
            //            });
            var groupNameField = new Ext.form.TextField({
                fieldLabel: getResource("CMGName"),
                name: 'GroupName',
                allowBlank: false,
                emptyText: getResource("CMGMSG_GroupNameRule"),
                blankText: getResource("CMGMSG_GroupNameRule"),
                anchor: '95%',
                maxLength: 200,
                validator: function (val) {
                    var special = /.*[$\\@\\\#%\^\&\*\+\;\'\{\}\`\\\~\=\|\.\,\:\?\"\!\-].*/;
                    if (val.search(special) == 0) {
                        return getResource("CMGMSG_GroupNameRuleSymbol");
                    } else {
                        if (val.length > 200) {
                            return getResource("CMGMSG_GroupNameRuleLength");
                        }
                        return true;
                    }
                }
            });
            //companyCombo.on("select", function (cb, rec, idx) { groupNameField.setRawValue(""); }, this);
            groupNameField.on("change", function (field, newValue, oldValue) {
                if (newValue && newValue != "") {
                    //var companyCode = companyCombo.getValue();
                    //                    var rule = RuleStore.find("companyCode", companyCode);
                    //                    if (rule != -1) {
                    //                        rule = RuleStore.getAt(rule);
                    //                        field.setValue(rule.data.NameRulePrefix + newValue + rule.data.NameRuleSuffix);
                    //                    }
                }
            }, this);
            var form = new Ext.FormPanel({
                bodyStyle: 'padding:10px 0px 10px 10px;background: #FFFFFF none repeat scroll 0 0;',
                border: false,
                autoHeight: true,
                defaultType: 'textfield',
                labelWidth: 60,
                frame: true,
                //keys: {
                //	key: [13], // enter key
                //	fn: onSubmit,
                //	scope:this
                //},
                items: [groupNameField, {
                    fieldLabel: getResource("CMGOrder"),
                    name: 'GroupOrder',
                    value: 999,
                    anchor: '95%',
                    maxValue: 32767,
                    xtype: 'numberfield'
                }, {
                    fieldLabel: getResource("CMGDesc"),
                    name: 'GroupDescription',
                    anchor: '95%',
                    value: '',
                    maxLength: 500,
                    xtype: 'textarea'
                }],
                buttons: [{
                    text: getResource("OkBtn"),
                    handler: onSubmit.createDelegate(this),
                    scope: this
                }, {
                    text: getResource("CancelBtn"),
                    handler: function () {
                        this.AddCustomGroupWindow.hide();
                    },
                    scope: this
                }],
                buttonAlign: 'right'
            });
            this.AddCustomGroupWindow = new Ext.Window({
                layout: 'fit',
                plain: true,
                width: 420,
                autoHeight: true,
                modal: true,
                title: getResource("CMGMSG_CreateGroupTitle"),
                items: form,
                draggable: false,
                resizable: false,
                closeAction: 'hide'
            });
            this.AddCustomGroupWindow.on("show", function (window) {
                //companyCombo.setValue(this.MyCompanyCode);
                //if (this.CMGSuperAdmin == false) companyCombo.setDisabled(true);
                form.items.get(2).setValue("");
                groupNameField.setRawValue("");
                groupNameField.fireEvent("blur", groupNameField);
                //form.getForm().getEl().dom.GroupName.value = "";
                //groupNameField.focus(true, 500);
            }, this);
        }
        this.AddCustomGroupWindow.show();
    },

    UpdateCustomGroup: function () {
        var customGroup = this.CMGCheck.getSelected();
        if (!customGroup) return;
        else if (this.CMGSuperAdmin == false) {
            var creator = customGroup.get("CreatorLoginID");
            if (creator != this.MyLoginID) {
                this.InfoMessageBox(getResrouce("CMGMSG_ModGroupProhibit"));
                return;
            }
        }
        if (!this.UpdateCustomGroupWindow) {
            function onUpdateSubmit() {
                if (!groupNameField.validate()) {
                    this.ErrorMessageBox(getResource("CMGMSG_GroupNameIncorrect"), function () { groupNameField.setRawValue(""); groupNameField.focus(); });
                } else {
                    this.UpdateCustomGroupWindow.hide();
                    Ext.MessageBox.show({ title: getResource("CMGModGroup"), msg: getResource("CMGMSG_ModGroup"), width: 280, closable: false, icon: 'sk-wait-box' });

                    var customGroup = this.CMGCheck.getSelected();

                    //var companyCode = customGroup.get("CompanyCode");
                    var groupCode = customGroup.get("GroupCode");
                    var groupOrder = form.items.get(1).getValue();
                    var groupName = groupNameField.getValue();
                    var description = form.items.get(3).getValue();
                    var displayYN = "N";
                    if (form.items.get(2).getValue() == true) displayYN = "Y";

                    Ext.Ajax.request({
                        url: g_OrgMapServerURL,
                        params: {
                            action: 'editCustomGroup',
                            groupCode: groupCode,
                            groupOrder: groupOrder,
                            groupName: groupName,
                            description: description,
                            displayYN: displayYN
                        },
                        method: 'POST',
                        success: function (response, option) {
                            var callResult = Ext.util.JSON.decode(response.responseText);
                            if (callResult) {
                                if (callResult.result == false) {
                                    Ext.MessageBox.hide();
                                    this.ErrorMessageBox(getResource("CMGMSG_ModGroupFail") +
										Ext.util.Format.htmlEncode(callResult.ErrorMessage));
                                } else {
                                    this.dsCustomMailGroup.reload();
                                    Ext.MessageBox.updateText(getResource("CMGMSG_ModGroupSucceed"));
                                    setTimeout(function () { Ext.MessageBox.hide(); }, 800);
                                }
                            }
                        },
                        failure: function (response, option) {
                            Ext.MessageBox.hide();
                            debugger;
                            this.ErrorMessageBox(getResource("AjaxFailMsg"), function () {
                                window.close();
                            });
                        },
                        scope: this
                    });
                }
            };
            //            var RuleStore = new Ext.data.SimpleStore({
            //                fields: ['companyCode', 'companyName', 'MailDomainURI', 'NameRulePrefix', 'NameRuleSuffix'],
            //                data: this.CMGCompanyRule
            //            });
            var groupNameField = new Ext.form.TextField({
                fieldLabel: getResource("CMGName"),
                name: 'GroupName',
                emptyText: getResource("CMGMSG_GroupNameRule"),
                blankText: getResource("CMGMSG_GroupNameRule"),
                allowBlank: false,
                anchor: '95%',
                maxLength: 200,
                validator: function (val) {
                    var special = /.*[$\\@\\\#%\^\&\*\+\;\'\{\}\`\\\~\=\|\.\,\:\?\"\!\-].*/;
                    if (val.search(special) == 0) {
                        return getResource("CMGMSG_GroupNameRuleSymbol");
                    } else {
                        if (val.length > 200) {
                            return getResource("CMGMSG_GroupNameRuleLength");
                        }
                        return true;
                    }
                }
            });
            groupNameField.on("change", function (field, newValue, oldValue) {
                if (newValue && newValue != "") {
                    //                    var customGroup = this.CMGCheck.getSelected();
                    //                    var rule = RuleStore.find("companyCode", customGroup.get("CompanyCode"));
                    //                    if (rule != -1) {
                    //                        rule = RuleStore.getAt(rule);
                    //                        field.setValue(rule.data.NameRulePrefix + newValue + rule.data.NameRuleSuffix);
                    //                    }
                }
            }, this);
            var form = new Ext.FormPanel({
                bodyStyle: 'padding:10px 0px 10px 10px;background: #FFFFFF none repeat scroll 0 0;',
                border: false,
                autoHeight: true,
                defaultType: 'textfield',
                labelWidth: 60,
                frame: true,
                //keys: {
                //	key: [13], // enter key
                //	fn: onUpdateSubmit,
                //	scope:this
                //},
                items: [groupNameField, {
                    fieldLabel: getResource("CMGOrder"),
                    name: 'GroupOrder',
                    value: 999,
                    anchor: '95%',
                    maxValue: 32767,
                    xtype: 'numberfield'
                }, {
                    fieldLabel: getResource("CMGDisplay"),
                    //checked:true,
                    boxLabel: getResource("CMGMSG_DisplayDesc"),
                    name: 'IsDisplay',
                    xtype: 'checkbox'
                }, {
                    fieldLabel: getResource("CMGDesc"),
                    name: 'GroupDescription',
                    anchor: '95%',
                    value: '',
                    maxLength: 500,
                    xtype: 'textarea'
                }],
                buttons: [{
                    text: getResource("OkBtn"),
                    handler: onUpdateSubmit.createDelegate(this),
                    scope: this
                }, {
                    text: getResource("CancelBtn"),
                    handler: function () {
                        this.UpdateCustomGroupWindow.hide();
                    },
                    scope: this
                }],
                buttonAlign: 'right'
            });
            this.UpdateCustomGroupWindow = new Ext.Window({
                layout: 'fit',
                plain: true,
                width: 420,
                autoHeight: true,
                modal: true,
                title: getResource("CMGModGroup"),
                items: form,
                draggable: false,
                resizable: false,
                closeAction: 'hide'
            });
            this.UpdateCustomGroupWindow.on("show", function (window) {
                var customGroup = this.CMGCheck.getSelected();
                groupNameField.setRawValue(customGroup.get("GroupName"));
                form.items.get(1).setRawValue(customGroup.get("GroupOrder"));
                form.items.get(2).setValue(true);
                if (customGroup.get("DisplayYN") == "N") form.items.get(2).setValue(false);
                form.items.get(3).setRawValue(customGroup.get("Description"));
                //groupNameField.setRawValue(customGroup.get("GroupName"));
                //form.items.get(4).setValue(true);
                //groupNameField.setRawValue("");
                groupNameField.fireEvent("blur", groupNameField);
                //groupNameField.focus(true, 500);
            }, this);
        }
        this.UpdateCustomGroupWindow.show();
    },

    DeleteCustomGroup: function () {
        var customGroup = this.CMGCheck.getSelected();
        if (!customGroup) return;
        else if (this.CMGSuperAdmin == false) {
            var creator = customGroup.get("CreatorLoginID");
            if (creator != this.MyLoginID) {
                this.InfoMessageBox(getResource("CMGMSG_DelGroupProhibit"));
                return;
            }
        }
        Ext.MessageBox.confirm(getResource("CMGDelGroup"), '＂<span style="color:#800000;">' + customGroup.get("GroupName")
			+ getResource("CMGMSG_DelGroupConfirm"),
		function (btn) {
		    if (btn == "yes") {
		        Ext.MessageBox.show({ title: getResource("CMGDelGroup"), msg: getResource("CMGMSG_DelGroup"), width: 280, closable: false, icon: 'sk-wait-box' });

		        var groupCode = customGroup.get("GroupCode");


		        Ext.Ajax.request({
		            url: g_OrgMapServerURL,
		            params: {
		                action: 'deleteCustomGroup',
		                groupCode: groupCode
		            },
		            method: 'POST',
		            success: function (response, option) {
		                var callResult = Ext.util.JSON.decode(response.responseText);
		                if (callResult) {
		                    if (callResult.result == false) {
		                        Ext.MessageBox.hide();
		                        this.ErrorMessageBox(getResource("CMGMSG_DelGroupFail") +
									Ext.util.Format.htmlEncode(callResult.ErrorMessage));
		                    } else {
		                        this.dsCustomMailGroup.reload();
		                        Ext.MessageBox.updateText(getResource("CMGMSG_DelGroupSucceed"));
		                        setTimeout(function () { Ext.MessageBox.hide(); }, 800);
		                    }
		                }
		            },
		            failure: function (response, option) {
		                Ext.MessageBox.hide();
		                debugger;
		                this.ErrorMessageBox(getResource("AjaxFailMsg"), function () {
		                    window.close();
		                });
		            },
		            scope: this
		        });
		    }
		}, this);
    },

    AddMemberToCustomGroup: function () {
        var customGroup = this.CMGCheck.getSelected();
        if (!customGroup) return;
        else if (this.CMGSuperAdmin == false) {
            var creator = customGroup.get("CreatorLoginID");
            if (creator != this.MyLoginID) {
                this.InfoMessageBox(getResource("CMGMSG_ModGroupMemberProhibit"));
                return;
            }
        }
        if (!this.MiniOrgMap) {
            Ext.Ajax.extraParams = { 'langCode': "ko" };
            // App 조직도 DATA
            var APPDataFields = [
				{ name: 'DisplayName' }, 	// Name
				{name: 'ADDisplayName' }, 	// AD의 DisplayName(사용자의 경우)
				{name: 'entryType' }, 		// 0: 부서, 1: 그룹, 2:사용자
				{name: 'addr' }, 			// 이메일주소	
				{name: 'AccountId' }, 		// 사용자 로그인 ID(도메인 없음)
				{name: 'DeptName' }, 		// 부서이름
				{name: 'DeptCode' }, 		// 부서코드
				{name: 'RankName' }, 		// 직위
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
            this.dsMiniSource = new Ext.data.JsonStore({
                url: g_OrgMapServerURL,
                root: 'dataRoot',
                baseParams: { action: 'getMemberListForApp', isOnlyUser: "Y" },
                fields: APPDataFields,
                remoteSort: false
            });
            this.dsMiniSource.on('datachanged', this.OnMiniDsSourceDataChanged, this);
            this.dsMiniResult = new Ext.data.JsonStore({ fields: APPDataFields });
            this.MiniSelectCheck = new Ext.grid.CheckboxSelectionModel();
            this.MiniSelectColumn = new Ext.grid.ColumnModel([
				this.MiniSelectCheck,
				{ header: getResource("UserRank"), dataIndex: 'RankName', menuDisabled: true, width: 45, renderer: this.RendererWithTooltip },
				{ header: getResource("UserName"), dataIndex: 'DisplayName', menuDisabled: true, width: 60, renderer: this.MiniRendererDisplayName.createDelegate(this) },
				{ header: getResource("UserEmpID"), dataIndex: 'EmpID', menuDisabled: true, width: 55, renderer: this.RendererWithTooltip },
				{ header: getResource("UserJob"), dataIndex: 'JobName', menuDisabled: true, width: 55, renderer: this.RendererWithTooltip }
			]);
            this.MiniSelectGrid = new Ext.grid.GridPanel({
                region: 'center',
                margins: '5 5 0 5',
                ddGroup: 'SelectGridDDGroup',
                enableDragDrop: true,
                enableColumnMove: false,
                ds: this.dsMiniSource,
                cm: this.MiniSelectColumn,
                sm: this.MiniSelectCheck,
                stripeRows: true,
                title: '&nbsp;&nbsp;',
                loadMask: { msg: getResource("WaitMsg") }
            });
            this.MiniResultCheck = new Ext.grid.CheckboxSelectionModel();
            this.MiniResultColumn = new Ext.grid.ColumnModel([
				this.MiniResultCheck,
				{ header: getResource("UserName"), dataIndex: 'ADDisplayName', menuDisabled: true, width: 50, renderer: this.MiniRendererADDisplayName.createDelegate(this) }
			]);
            this.MiniResultGrid = new Ext.grid.GridPanel({
                region: 'east',
                margins: '5 5 0 0',
                ddGroup: 'ResultGridDDGroup',
                enableDragDrop: true,
                enableColumnMove: false,
                ds: this.dsMiniResult,
                cm: this.MiniResultColumn,
                sm: this.MiniResultCheck,
                stripeRows: true,
                viewConfig: {
                    //autoFill:true,
                    forceFit: true
                },
                bbar: ['->',
					{
					    iconCls: 'add',
					    handler: this.OnMiniAddHandler,
					    scope: this
					},
					{
					    iconCls: 'delete',
					    handler: this.OnMiniRemoveHandler,
					    scope: this
					},
					{
					    iconCls: 'cross',
					    handler: this.OnMiniRemoveAllHandler,
					    scope: this
					}
				],
                title: getResource("CMGMSG_AddGroupMember"),
                width: 200
            });

            var searchBox = this.getEmpNameSearchBox();
            var treeBox = this.getCompanyDeptTree(210);
            var companyArray = this.commonData.InnerCompany;
            var companyComboData = [];
            var myCompanyObj = null;
            for (var i = 1; i < companyArray.length; i++) {
                companyComboData[companyComboData.length] = {
                    companyCode: companyArray[i].companyCode,
                    companyName: companyArray[i].companyName,
                    text: companyArray[i].text,
                    isRelative: "N",
                    checked: false
                };
                if (companyComboData[companyComboData.length - 1].companyCode == this.MyCompanyCode) {
                    companyComboData[companyComboData.length - 1].checked = true;
                    myCompanyObj = companyComboData[companyComboData.length - 1];
                }
            }
            var miniCompanyCombo = new GW.OrgMap.ComboMenuButton({ items: companyComboData });
            miniCompanyCombo.activeItem = myCompanyObj;

            // 개인주소록
            var onMiniPersonalContacts = function () {
                var company = miniCompanyCombo.getActiveItem();
                this.dsMiniSource.load({ params: { mode: '_contacts'} });
                this.MiniSelectGrid.setTitle(Ext.util.Format.htmlEncode(getResource("AddressBook")));
            }

            var miniContactMenu = {
                tooltip: { title: getResource("AddressBook"), text: getResource("AddressBookTip") },
                iconCls: 'contact',
                text: getResource("AddressBook"),
                handler: onMiniPersonalContacts,
                scope: this
            };



            // 검색박스
            var clearSearchBox = function () {
                var node = treeBox.getSelectionModel().getSelectedNode();
                if (node) {
                    var company = miniCompanyCombo.getActiveItem();
                    this.dsMiniSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'dept', query: node.id} });
                    this.MiniSelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                }
                searchBox.fireEvent('blur', searchBox);
            };
            searchBox.ClearClick = clearSearchBox.createDelegate(this);
            var doSearchBox = function () {
                var strName = searchBox.getValue();
                if (strName != '') {
                    if (strName.length >= 2 && strName.length < 8) {
                        var special = /.*[$\\@\\\#%\^\&\*\(\)\[\]\+\_\;\'\{\}\`\\\~\<\>\=\|\.\,\:\?\/\"\!\-].*/;
                        var alphanum = /^[a-zA-Z0-9_]+$/;
                        if (strName.search(special) == 0) {
                            searchBox.setValue('');
                            this.WarningMessageBox(getResource("NoUseSpecialMsg"), function () {
                                searchBox.focus();
                            });
                            return false;
                        } else if (alphanum.test(strName)) {
                            // 사번검색  --> NOTE: 사번검색할 때 3자로 제한해야함. sk로 검색하면 대박.
                            if (strName.length < 3) {
                                searchBox.setValue('');
                                this.WarningMessageBox(getResource("NoUseAlphaNumTwoWord"), function () {
                                    searchBox.focus();
                                });
                                return false;
                            }
                        }
                        var company = miniCompanyCombo.getActiveItem();
                        this.dsMiniSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'member', query: strName} });
                        this.MiniSelectGrid.setTitle('[' + strName + '] ' + getResource("SearchResult"));
                        return true;
                    } else {
                        searchBox.setValue('');
                        this.WarningMessageBox(getResource("UseSearch"), function () {
                            searchBox.focus();
                        });
                        return false;
                    }
                }
                return false;
            };
            searchBox.SearchClick = doSearchBox.createDelegate(this);

            treeBox.getLoader().on('load', function (treeLoader, node, response) {
                if (node == treeBox.root) {
                    node.expandChildNodes();
                }
            }, this);

            treeBox.getSelectionModel().on('selectionchange', function (t, node) {
                if (node) {
                    node.ensureVisible();
                    searchBox.onTrigger1Click(true);
                    var company = miniCompanyCombo.getActiveItem();
                    this.dsMiniSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'dept', query: node.id} });
                    this.MiniSelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                }
            }, this);

            treeBox.getLoader().on('beforeload', function (treeLoader, node) {
                if (treeLoader.baseParams) {
                    var company = miniCompanyCombo.getActiveItem();
                    treeLoader.baseParams.companyCode = company.companyCode;
                    treeLoader.baseParams.isRelative = company.isRelative;
                }
            }, this);

            miniCompanyCombo.on("change", function (combo, item) {
                treeBox.getRootNode().children = null;
                treeBox.getRootNode().reload();
                if (item.companyCode === this.MyCompanyCode) {
                    treeBox.expandPath(this.MyDeptSelectPath);
                    treeBox.selectPath(this.MyDeptSelectPath);
                }
            }, this);

            var miniMainPanel = new Ext.Panel({
                region: 'center',
                layout: 'border',
                border: false,
                bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
                tbar: ['-', miniCompanyCombo, '-', miniContactMenu, '->', '-', searchBox, '-'],
                items: [treeBox, this.MiniSelectGrid, this.MiniResultGrid],
                buttons: [{
                    text: getResource("OkBtn"),
                    handler: this.OnMiniOk,
                    scope: this
                }, {
                    text: getResource("CancelBtn"),
                    handler: this.OnMiniCancel,
                    scope: this
                }],
                buttonAlign: 'right'
            });
            this.MiniOrgMap = new Ext.Window({
                layout: 'fit',
                plain: true,
                width: 700,
                height: 485,
                modal: true,
                title: getResource("CMGMSG_AddGroupMemberTitle"),
                items: miniMainPanel,
                closeAction: 'hide',
                draggable: false,
                resizable: false
            });
            this.MiniOrgMap.on("show", function (window) {
                miniMainPanel.footer.applyStyles('background: #FFFFFF none repeat scroll 0 0;');
                var customGroup = this.CMGCheck.getSelected();
                window.setTitle('＂<span style="color:#800000;">' + customGroup.get('GroupName') + '</span>＂' + getResource("CMGMSG_AddGroupMemberTitle"));
                this.dsMiniResult.removeAll();
                if (this.IsMiniDD != true) {
                    var miniMask = new Ext.LoadMask(this.MiniResultGrid.getView().el, { msg: getResource("WaitMsg") });
                    var dsResult = this.dsMiniResult;
                    var clearCheck = this.MiniAllSelectionClear.createDelegate(this);
                    var validateEmail = this.ValidateEmail;
                    var warningMsgBox = this.WarningMessageBox;

                    var miniSelectDropTarget = new Ext.dd.DropTarget(this.MiniSelectGrid.getView().el.dom.childNodes[0].childNodes[1], {
                        ddGroup: 'ResultGridDDGroup',
                        notifyDrop: function (ddSource, e, data) {
                            function removeRow(record, index, allItems) {
                                ddSource.grid.store.remove(record);
                            }
                            miniMask.show();
                            if (ddSource.dragData.selections.length == ddSource.grid.store.getCount()) {
                                ddSource.grid.store.removeAll();
                            } else {
                                Ext.each(ddSource.dragData.selections, removeRow);
                            }
                            miniMask.hide();
                            clearCheck();
                            return (true);
                        }
                    });
                    var MiniResultDropTarget = new Ext.dd.DropTarget(this.MiniResultGrid.getView().el.dom.childNodes[0].childNodes[1], {
                        ddGroup: 'SelectGridDDGroup',
                        notifyDrop: function (ddSource, e, data) {
                            miniMask.show();
                            var sNoEmpNoUsers = "";
                            Ext.each(ddSource.dragData.selections, function (record, index, allItems) {
                                if (record.data.entryType == 2 && record.data.AccountId && record.data.AccountId != "") {
                                    var foundItem = dsResult.find('AccountId', record.data.AccountId);
                                    if (foundItem == -1) {
                                        dsResult.add(record);
                                    }
                                } else {
                                    sNoEmpNoUsers += record.data.DisplayName + ', ';
                                }
                            }, this);
                            dsResult.fireEvent("datachanged", dsResult);
                            miniMask.hide();
                            clearCheck();
                            if (sNoEmpNoUsers.length > 1) {
                                sNoEmpNoUsers = sNoEmpNoUsers.substring(0, sNoEmpNoUsers.length - 2);
                                warningMsgBox(getResource("CMGMSG_AddGroupMemberHIOKFail") + sNoEmpNoUsers);
                            }
                            return (true);
                        }
                    });
                    this.IsMiniDD = true;
                } else { this.MiniAllSelectionClear(); }
                treeBox.expandPath(this.MyDeptSelectPath);
                treeBox.selectPath(this.MyDeptSelectPath);
            }, this);
        }
        this.MiniOrgMap.show();
    },

    DeleteMemberToCustomGroup: function () {
        var customGroup = this.CMGCheck.getSelected();
        if (!customGroup) return;
        else if (this.CMGSuperAdmin == false) {
            var creator = customGroup.get("CreatorLoginID");
            if (creator != this.MyLoginID) {
                this.InfoMessageBox(getResource("CMGMSG_ModGroupMemberProhibit"));
                return;
            }
        }
        var members = this.CMGMemberCheck.getSelections();
        if (members && members.length > 0) {
            Ext.MessageBox.confirm(getResource("CMGDelMember"), '<span style="color:red;">' + members.length + getResource("CMGMSG_DelGroupMemberConfirm"),
			function (btn) {
			    if (btn == "yes") {
			        Ext.MessageBox.show({ title: getResource("CMGDelMember"), msg: getResource("CMGMSG_DelGroupMemberProgress"), width: 280, closable: false, icon: 'sk-wait-box' });

			        var groupADCN = customGroup.get("GroupCode");
			        var groupMembers = "";
			        var delimiter = "$";
			        Ext.each(members, function (record, index, allItems) { groupMembers += record.get('mail') + delimiter; }, this);
			        groupMembers = groupMembers.substring(0, groupMembers.length - 1);

			        Ext.Ajax.request({
			            url: g_OrgMapServerURL,
			            params: {
			                action: 'deleteCustomGroupMember',
			                groupADCN: groupADCN,
			                groupMembers: groupMembers
			            },
			            method: 'POST',
			            success: function (response, option) {
			                var callResult = Ext.util.JSON.decode(response.responseText);
			                if (callResult) {
			                    if (callResult.result == false) {
			                        Ext.MessageBox.hide();
			                        this.ErrorMessageBox(getResource("CMGMSG_DelGroupMemberFail") +
										Ext.util.Format.htmlEncode(callResult.ErrorMessage));
			                    } else {
			                        this.dsCMGMember.reload();
			                        Ext.MessageBox.updateText(getResource("CMGMSG_DelGroupMemberSucceed"));
			                        setTimeout(function () { Ext.MessageBox.hide(); }, 800);
			                    }
			                }
			            },
			            failure: function (response, option) {
			                Ext.MessageBox.hide();
			                debugger;
			                this.ErrorMessageBox(getResource("AjaxFailMsg"), function () {
			                    window.close();
			                });
			            },
			            scope: this
			        });
			    }
			}, this);
        }
    },

    RendererCMGADDisplayName: function (value, meta, record, rowIndex, colIndex, store) {
        var strName = value;

        // tooltip의 내용을 자세하게 ~
        if (typeof value == "string" && value.length > 0) {
            var title = record.data.displayName;
            var qtiptitle = ' ext:qtitle="' + Ext.util.Format.htmlEncode(Ext.util.Format.htmlEncode(title)) + '"  ext:qtip="';
            var qtip = '';

            if (record.data.title && record.data.title != "") qtip += getResource("UserJob") + ': ' + Ext.util.Format.htmlEncode(record.data.title) + '<br/>';
            if (record.data.employeeNumber && record.data.employeeNumber != "") qtip += getResource("UserEmpID") + ': ' + Ext.util.Format.htmlEncode(record.data.employeeNumber) + '<br/>';
            if (record.data.company && record.data.company != "") qtip += getResource("UserCompany") + ': ' + Ext.util.Format.htmlEncode(record.data.company) + '<br/>';
            if (record.data.department && record.data.department != "") qtip += getResource("UserDept") + ': ' + Ext.util.Format.htmlEncode(record.data.department) + '<br/>';
            if (record.data.dutyName && record.data.dutyName != "") qtip += getResource("UserDuty") + ': ' + Ext.util.Format.htmlEncode(record.data.dutyName) + '<br/>';
            if (record.data.mail && record.data.mail != "") qtip += getResource("UserEmail") + ': ' + Ext.util.Format.htmlEncode(record.data.mail) + '<br/>';
            if (record.data.telephoneNumber && record.data.telephoneNumber != "") qtip += getResource("UserOfficeTel") + ': ' + Ext.util.Format.htmlEncode(record.data.telephoneNumber) + '<br/>';

            if (qtip === '') {
                meta.attr = meta.attr + 'ext:qtip="' + Ext.util.Format.htmlEncode(title) + '" ';
            } else {
                meta.attr = meta.attr + qtiptitle + qtip + '" ';
            }
        }
        return strName;
    },

    MiniAllSelectionClear: function () {
        this.MiniSelectCheck.clearSelections();
        this.MiniResultCheck.clearSelections();

        // header force uncheck
        var selectHeader = this.MiniSelectGrid.getView().getHeaderCell(0).childNodes[0];
        var resultHeader = this.MiniResultGrid.getView().getHeaderCell(0).childNodes[0];

        Ext.get(selectHeader).removeClass('x-grid3-hd-checker-on');
        Ext.get(resultHeader).removeClass('x-grid3-hd-checker-on');
    },

    MiniRendererDisplayName: function (value, meta, record, rowIndex, colIndex, store) {
        var strName = value;

        // tooltip의 내용을 자세하게 ~
        if (typeof value == "string" && value.length > 0) {
            var title = record.data.ADDisplayName; //유저
            if (record.data.entryType != 2 || title == "") {
                title = record.data.DisplayName;
            }
            var qtiptitle = ' ext:qtitle="' + Ext.util.Format.htmlEncode(Ext.util.Format.htmlEncode(title)) + '"  ext:qtip="';
            var qtip = '';

            if (record.data.CompanyName != "") qtip += getResource("UserCompany") + ': ' + Ext.util.Format.htmlEncode(record.data.CompanyName) + '<br/>';
            if (record.data.EmpID != "" && record.data.Type == "USER") qtip += getResource("UserEmpID") + ': ' + Ext.util.Format.htmlEncode(record.data.EmpID) + '<br/>';
            if (record.data.RankName != "") qtip += getResource("UserRank") + ': ' + Ext.util.Format.htmlEncode(record.data.RankName) + '<br/>';
            if (record.data.DutyName != "") qtip += getResource("UserDuty") + ': ' + Ext.util.Format.htmlEncode(record.data.DutyName) + '<br/>';
            if (record.data.JobName != "") qtip += getResource("UserJob") + ': ' + Ext.util.Format.htmlEncode(record.data.JobName) + '<br/>';
            if (record.data.DeptName != "") qtip += getResource("UserDept") + ': ' + Ext.util.Format.htmlEncode(record.data.DeptName) + '<br/>';
            if (record.data.addr != "") qtip += getResource("UserEmail") + ': ' + Ext.util.Format.htmlEncode(record.data.addr) + '<br/>';
            if (record.data.CellPhone != "") qtip += getResource("UserCellPhone") + ': ' + Ext.util.Format.htmlEncode(record.data.CellPhone) + '<br/>';
            if (record.data.ExtensionNumber != "") qtip += getResource("UserOfficeTel") + ': ' + Ext.util.Format.htmlEncode(record.data.ExtensionNumber) + '<br/>';
            if (record.data.FaxNumber != "") qtip += getResource("UserFax") + ': ' + Ext.util.Format.htmlEncode(record.data.FaxNumber) + '<br/>';

            if (qtip === '') {
                meta.attr = meta.attr + 'ext:qtip="' + Ext.util.Format.htmlEncode(title) + '" ';
            } else {
                meta.attr = meta.attr + qtiptitle + qtip + '" ';
            }
        }
        return strName;
    },

    MiniRendererADDisplayName: function (value, meta, record, rowIndex, colIndex, store) {
        // ADDisplayName이 공백일 수 있다. (부서, 그룹, 없을 경우) DisplayName으로 보여준다.
        var strName = value;

        if (record.data.entryType != 2 || strName == "") {
            if (record.data.DisplayName != "") strName = record.data.DisplayName;
            else strName = record.data.DeptName;
        }

        //tootip ( ext:qtip="")
        if (typeof strName == "string" && strName.length > 0) {
            if (this.ValidateEmail(record.data.addr)) {
                meta.attr = meta.attr + ' ext:qtitle="' + Ext.util.Format.htmlEncode(Ext.util.Format.htmlEncode(strName)) + '"  ext:qtip="'
				+ getResource("UserEmail") + ': ' + Ext.util.Format.htmlEncode(record.data.addr) + '<br/>' + '" ';
            } else {
                meta.attr = meta.attr + ' ext:qtip="' + Ext.util.Format.htmlEncode(strName) + '" ';
            }
        }
        return strName;
    },

    OnMiniAddHandler: function () {
        var mask = new Ext.LoadMask(this.MiniResultGrid.getView().el, { msg: getResource("WaitMsg", "ko") });
        if (this.MiniSelectCheck.getSelections().length > 0) {
            mask.show();
            var sNoEmpNoUsers = "";
            Ext.each(this.MiniSelectCheck.getSelections(), function (record, index, allItems) {
                if (record.data.entryType == 2 && record.data.AccountId && record.data.AccountId != "") {
                    var foundItem = this.dsMiniResult.find('AccountId', record.data.AccountId);
                    if (foundItem == -1) {
                        this.dsMiniResult.add(record);
                    }
                } else {
                    sNoEmpNoUsers += record.data.DisplayName + ', ';
                }
            }, this);
            this.dsMiniResult.fireEvent("datachanged", this.dsMiniResult);
            mask.hide();
        }
        this.MiniAllSelectionClear();
        if (sNoEmpNoUsers.length > 1) {
            sNoEmpNoUsers = sNoEmpNoUsers.substring(0, sNoEmpNoUsers.length - 2);
            this.WarningMessageBox(getResource("CMGMSG_AddGroupMemberHIOKFail") + sNoEmpNoUsers);
        }
    },

    OnMiniRemoveHandler: function () {
        var mask = new Ext.LoadMask(this.MiniResultGrid.getView().el, { msg: getResource("WaitMsg") });
        if (this.MiniResultCheck.getSelections().length > 0) {
            mask.show();
            if (this.MiniResultCheck.getSelections().length == this.dsMiniResult.getCount()) {
                this.dsMiniResult.removeAll();
            }
            else {
                Ext.each(this.MiniResultCheck.getSelections(), function (record, index, allItems) {
                    this.dsMiniResult.remove(record);
                }, this);
            }
            this.dsMiniResult.fireEvent("datachanged", this.dsMiniResult);
            mask.hide();
        }
        this.MiniAllSelectionClear();
    },

    OnMiniRemoveAllHandler: function () {
        var mask = new Ext.LoadMask(this.MiniResultGrid.getView().el, { msg: getResource("WaitMsg") });
        if (this.dsMiniResult.getCount() > 0) {
            mask.show();
            this.dsMiniResult.removeAll();
            this.dsMiniResult.fireEvent("datachanged", this.dsMiniResult);
            mask.hide();
        }
        this.MiniAllSelectionClear();
    },

    OnMiniDsSourceDataChanged: function (store) {
        // 총 인원 수를 제목에 렌더링해준다.
        if (store.reader.jsonData.NumOfPerson) {
            var num = store.reader.jsonData.NumOfPerson;
            var title = this.MiniSelectGrid.title;
            title += " <span style='color:#e6ffff'>(" + getResource("Total") + num + getResource("PersonCount") + ")</span>";
            this.MiniSelectGrid.setTitle(title);
        }
    },

    OnMiniOk: function () {
        this.MiniOrgMap.hide();
        if (this.dsMiniResult.getCount() > 0) {
            Ext.MessageBox.show({ title: getResource("CMGAddMember"), msg: getResource("CMGMSG_AddGroupMemberProgress"), width: 280, closable: false, icon: 'sk-wait-box' });

            var customGroup = this.CMGCheck.getSelected();

            var groupADCN = customGroup.get("GroupCode");
            var groupMembers = "";
            var delimiter = "$";
            this.dsMiniResult.each(function (record) {
                var userAccountID = record.get('addr');
                if (userAccountID && userAccountID != "") {
                    groupMembers += userAccountID + delimiter;
                }
            }, this);
            groupMembers = groupMembers.substring(0, groupMembers.length - 1);

            Ext.Ajax.request({
                url: g_OrgMapServerURL,
                params: {
                    action: 'addCustomGroupMember',
                    groupADCN: groupADCN,
                    groupMembers: groupMembers
                },
                method: 'POST',
                success: function (response, option) {
                    var callResult = Ext.util.JSON.decode(response.responseText);
                    if (callResult) {
                        if (callResult.result == false) {
                            Ext.MessageBox.hide();
                            this.ErrorMessageBox(getResource("CMGMSG_AddGroupMemberFail") +
								Ext.util.Format.htmlEncode(callResult.ErrorMessage));
                        } else {
                            this.dsCMGMember.reload();
                            if (callResult.unKnownUser.length > 0) {
                                Ext.MessageBox.hide();
                                this.WarningMessageBox(getResource("CMGMSG_AddGroupMemberADFail1") +
									getResource("CMGMSG_AddGroupMemberADFail2") + callResult.unKnownUser);
                            } else {
                                Ext.MessageBox.updateText(getResource("CMGMSG_AddGroupMemberSucceed"));
                                setTimeout(function () { Ext.MessageBox.hide(); }, 800);
                            }
                        }
                    }
                },
                failure: function (response, option) {
                    Ext.MessageBox.hide();
                    debugger;
                    this.ErrorMessageBox(getResource("AjaxFailMsg"), function () {
                        window.close();
                    });
                },
                scope: this
            });
        }
    },

    OnMiniCancel: function () {
        this.MiniOrgMap.hide();
    },

    OnBack: function () {
        var params = Ext.urlDecode(window.location.search.substring(1), true);
        params.app = "";
        window.location.search = Ext.urlEncode(params);
    },

    OnClose: function () {
        if (this.Application == 'outlook') {
            window.external.Cancel();
        }
        else {
            window.close();
        }
    }
});