/*
* OrgMap.Org.js
* 조직도
*/

var OrgServerURL = 'OrgMapServer.aspx';

var NoRelativeCompany = false;

var OrgDataFields = [
	{ name: 'EmpID' },
	{ name: 'ADDisplayName' },
	{ name: 'UserName' },
	{ name: 'Email' },
	{ name: 'Type' },	// mandatory : '', 'USER', 'DEPT', 'GROUP'
	{ name: 'DeptCode' },
	{ name: 'DeptName' },
	{ name: 'CompanyName' },
	{ name: 'DutyCode' },
	{ name: 'DutyName' },
	{ name: 'JobCode' },
    { name: 'JobName' },
	{ name: 'RankCode' },
	{ name: 'RankName' },
	{ name: 'CellPhone' },
	{ name: 'TeamChiefYN' },
	{ name: 'ExtensionNumber' },
	{ name: 'FaxNumber' },
    { name: 'SignID' },
    { name: 'Kostl' }
];

var PersonDataFields = [
	{ name: 'EmpID' },
	{ name: 'ADDisplayName' },
	{ name: 'UserName' },
	{ name: 'Email' },
	{ name: 'Type' },	// mandatory : '', 'USER', 'DEPT', 'GROUP'
	{ name: 'DeptCode' },
	{ name: 'DeptName' },
	{ name: 'CompanyName' },
	{ name: 'DutyCode' },
	{ name: 'DutyName' },
	{ name: 'JobCode' },
    { name: 'JobName' },
	{ name: 'RankCode' },
	{ name: 'RankName' },
	{ name: 'CellPhone' },
	{ name: 'TeamChiefYN' },
	{ name: 'ExtensionNumber' },
	{ name: 'FaxNumber' },
    { name: 'SignID' },
    { name: 'Kostl' }
];

//결재선 DataRecord
var OrgDataRecord = Ext.data.Record.create([
	{ name: 'EmpID', mapping: 'EmpID'},
	{ name: 'ADDisplayName', mapping: 'ADDisplayName' },
	{ name: 'UserName', mapping: 'UserName' },
	{ name: 'Email', mapping: 'Email' },
	{ name: 'Type', mapping: 'Type' },	// mandatory : '', 'USER', 'DEPT', 'GROUP'
	{ name: 'DeptCode', mapping: 'DeptCode' },
	{ name: 'DeptName', mapping: 'DeptName' },
	{ name: 'CompanyName', mapping: 'CompanyName' },
	{ name: 'DutyCode', mapping: 'DutyCode' },
	{ name: 'DutyName', mapping: 'DutyName' },
	{ name: 'JobCode', mapping: 'JobCode' },
    { name: 'JobName', mapping: 'JobName' },
	{ name: 'RankCode', mapping: 'RankCode' },
	{ name: 'RankName', mapping: 'RankName' },
	{ name: 'CellPhone', mapping: 'CellPhone' },
	{ name: 'TeamChiefYN', mapping: 'TeamChiefYN' },
	{ name: 'ExtensionNumber', mapping: 'ExtensionNumber' },
	{ name: 'FaxNumber', mapping: 'FaxNumber' },
    { name: 'SignID' },
	{ name: 'Kostl', mapping: 'Kostl' }
]);

//조직도에 공통적으로 들어가는 Component를 정의
GW.OrgMap.Person = function() {
	Ext.Ajax.extraParams = { 'langCode' : g_langCode };
	Ext.Ajax.timeout = 60000;
	GW.OrgMap.Person.superclass.constructor.call(this);
	Ext.QuickTips.init();
	Ext.apply(Ext.QuickTips.getQuickTip(), {
		//trackMouse: true,
		showDelay: 700,
		dismissDelay: 0
	});
	
    this.DeptTree = null;
    this.MembersGridDropTarget = null;
	this.PersonsGridDropTarget = null;
	
    this.MembersResult = new Ext.data.JsonStore
    ({
        url: OrgServerURL,
        baseParams: { action: 'GetMemberListForApp' },
        root: 'dataRoot',
        fields: OrgDataFields,
        remoteSort: false
    });

	this.PersonsResult = new Ext.data.JsonStore({
        fields: PersonDataFields
    });
    
	this.CurrentGridSet = this.InitGird();

    this.MembersResult.on('datachanged', this.OnMembersDataChanged, this);
	this.MembersResult.on('beforeload', function(store, options) {
		GW.NameControl.UnRegisterPresenceAll();
	}, this); 
	
	this.MembersGrid.on('dblclick', this.On_Member_DbClick, this);
	this.PersonsGrid.on('dblclick', this.On_Person_DbClick, this);
   
    this.GetInitialize
    (
	    function() {
	        this.Render();
			this.LoadPersons();
	        this.DragDropSetting();
 			this.FadeOutMainLoadMask();
	    }
    , this
    );
};

Ext.extend(GW.OrgMap.Person, GW.OrgMap.Common, {
    LoadPersons: function () {
        //TO:DO XML값으로 값 셋팅.
        if (PersonXml != null && PersonXml != undefined) {
            var personNodes = PersonXml.selectNodes('Person');

            var dsPersons = this.PersonsResult;

            for (var i = 0; i < personNodes.length; i++) {
                var personNode = personNodes[i];

                var strEmpID = "";
                var strADDisplayName = "";
                var strUserName = "";
                var strEmail = "";
                var strType = "";
                var strDeptCode = "";
                var strDeptName = "";
                var strCompanyName = "";
                var strDutyCode = "";
                var strDutyName = "";
                var strJobCode = "";
                var strJobName = "";
                var strRankCode = "";
                var strRankName = "";
                var strCellPhone = "";
                var strTeamChiefYN = "";
                var strExtensionNumber = "";
                var strFaxNumber = "";
                var strSignID = "";
                var strKostl = "";

                if (personNode != null && personNode != undefined) {
                    if (personNode.selectSingleNode("EmpID") != null) strEmpID = personNode.selectSingleNode("EmpID").text;
                    if (personNode.selectSingleNode("ADDisplayName") != null) strADDisplayName = personNode.selectSingleNode("ADDisplayName").text;
                    if (personNode.selectSingleNode("UserName") != null) strUserName = personNode.selectSingleNode("UserName").text;
                    if (personNode.selectSingleNode("Email") != null) strEmail = personNode.selectSingleNode("Email").text;
                    if (personNode.selectSingleNode("Type") != null) strType = personNode.selectSingleNode("Type").text;
                    if (personNode.selectSingleNode("DeptCode") != null) strDeptCode = personNode.selectSingleNode("DeptCode").text;
                    if (personNode.selectSingleNode("DeptName") != null) strDeptName = personNode.selectSingleNode("DeptName").text;
                    if (personNode.selectSingleNode("CompanyName") != null) strCompanyName = personNode.selectSingleNode("CompanyName").text;
                    if (personNode.selectSingleNode("DutyCode") != null) strDutyCode = personNode.selectSingleNode("DutyCode").text;
                    if (personNode.selectSingleNode("DutyName") != null) strDutyName = personNode.selectSingleNode("DutyName").text;
                    if (personNode.selectSingleNode("JobCode") != null) strJobName = personNode.selectSingleNode("JobCode").text;
                    if (personNode.selectSingleNode("JobName") != null) strJobName = personNode.selectSingleNode("JobName").text;
                    if (personNode.selectSingleNode("RankCode") != null) strRankName = personNode.selectSingleNode("RankCode").text;
                    if (personNode.selectSingleNode("RankName") != null) strRankName = personNode.selectSingleNode("RankName").text;
                    if (personNode.selectSingleNode("CellPhone") != null) strCellPhone = personNode.selectSingleNode("CellPhone").text;
                    if (personNode.selectSingleNode("TeamChiefYN") != null) strTeamChiefYN = personNode.selectSingleNode("TeamChiefYN").text;
                    if (personNode.selectSingleNode("ExtensionNumber") != null) strExtensionNumber = personNode.selectSingleNode("ExtensionNumber").text;
                    if (personNode.selectSingleNode("FaxNumber") != null) strFaxNumber = personNode.selectSingleNode("FaxNumber").text;
                    if (personNode.selectSingleNode("SignID") != null) strSignID = personNode.selectSingleNode("SignID").text;
                    if (personNode.selectSingleNode("Kostl") != null) strKostl = personNode.selectSingleNode("Kostl").text;

                    var newRecord = new OrgDataRecord({
                        EmpID: strEmpID,
                        ADDisplayName: strADDisplayName,
                        UserName: strUserName,
                        Email: strEmail,
                        Type: strType,
                        DeptCode: strDeptCode,
                        DeptName: strDeptName,
                        CompanyName: strCompanyName,
                        DutyCode: strDutyCode,
                        DutyName: strDutyName,
                        JobCode: strJobCode,
                        JobName: strJobName,
                        RankCode: strRankCode,
                        RankName: strRankName,
                        CellPhone: strCellPhone,
                        TeamChiefYN: strTeamChiefYN,
                        ExtensionNumber: strExtensionNumber,
                        FaxNumber: strFaxNumber,
                        SignID: strSignID,
                        Kostl: strKostl
                    });
                    dsPersons.add(newRecord);
                }
            }
        }
    },

    InitGird: function () {
        this.MembersGridCheckBox = new Ext.grid.CheckboxSelectionModel();
        this.MembersCM = new Ext.grid.ColumnModel
		([
			this.MembersGridCheckBox,
			{ header: GetResource("UserRank"), dataIndex: 'RankName', menuDisabled: true, width: 45, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserName"), dataIndex: 'UserName', menuDisabled: true, width: 75, renderer: this.RendererUserName.createDelegate(this) },
			{ header: GetResource("UserEmpID"), dataIndex: 'EmpID', menuDisabled: true, width: 55, renderer: this.RendererWithTooltip },
			{ header: GetResource("UserJob"), dataIndex: 'JobName', menuDisabled: true, width: 118, renderer: this.RendererWithTooltip }
			,
			{ header: GetResource("UserDept"), dataIndex: 'DeptName', menuDisabled: true, width: 80, renderer: this.RendererWithTooltip, hidden: true },
			{ header: GetResource("UserCellPhone"), dataIndex: 'CellPhone', menuDisabled: true, width: 95, renderer: this.RendererWithTooltip, hidden: true },
			{ header: GetResource("UserOfficeTel"), dataIndex: 'ExtensionNumber', menuDisabled: true, width: 95, renderer: this.RendererWithTooltip, hidden: true },
			{ header: GetResource("UserFax"), dataIndex: 'FaxNumber', menuDisabled: true, width: 80, renderer: this.RendererWithTooltip, hidden: true }
		]);

        this.MembersGrid = new Ext.grid.GridPanel
		({
		    region: 'center',
		    margins: '5 5 0 5',
		    ddGroup: 'DDGSelect',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    ds: this.MembersResult,
		    cm: this.MembersCM,
		    sm: this.MembersGridCheckBox,
		    stripeRows: true,
		    title: '&nbsp;&nbsp;',
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        this.PersonsGridCheckBox = new Ext.grid.CheckboxSelectionModel();
        this.PersonsCM = new Ext.grid.ColumnModel
		([
			this.PersonsGridCheckBox,
			{ header: GetResource("UserName"), dataIndex: 'ADDisplayName', menuDisabled: true, width: 50, renderer: this.RendererADDisplayName.createDelegate(this) }
		]);

        this.PersonsGrid = new Ext.grid.GridPanel
		({
		    margins: '5 5 0 5',
		    ddGroup: 'DDGPersons',
		    enableDragDrop: true,
		    enableColumnMove: false,
		    ds: this.PersonsResult,
		    cm: this.PersonsCM,
		    sm: this.PersonsGridCheckBox,
		    stripeRows: true,
		    title: GetResource("SelectedEmployee"),
		    viewConfig: {
		        //autoFill:true,
		        forceFit: true
		    },
		    bbar: ['->',
				{
				    tooltip: { title: GetResource("Add"), text: GetResource("AddTooltip") },
				    iconCls: 'add',
				    text: GetResource("Add"),
				    handler: function () {
				        this.On_ButtonClick('Add')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("Remove"), text: GetResource("RemoveTooltip") },
				    iconCls: 'delete',
				    text: GetResource("Remove"),
				    handler: function () {
				        this.On_ButtonClick('Remove')
				    },
				    scope: this
				},
				{
				    tooltip: { title: GetResource("RemoveAll"), text: GetResource("RemoveAllTooltip") },
				    iconCls: 'cross',
				    text: GetResource("RemoveAll"),
				    handler: function () {
				        this.On_ButtonClick('RemoveAll')
				    },
				    scope: this
				}
			],
		    rowHeight: 1,
		    loadMask: { msg: GetResource("WaitMsg") }
		});

        var gridSet =
		{
		    Member: this.MembersGrid,
		    Person: this.PersonsGrid
		};

        return gridSet;
    },

    SetCoulumVisiable: function (eventFrom) {
        switch (eventFrom) {
            case "group":
                this.MembersCM.setHidden(1, true); 	// 직위
                this.MembersCM.setHidden(3, true); 	// 사번
                this.MembersCM.setHidden(4, true); 	// 직무
                this.MembersCM.setHidden(5, true); 	// 부서
                this.MembersCM.setHidden(6, true); 	// 휴대폰
                this.MembersCM.setHidden(7, true); 	// 사내전화
                this.MembersCM.setHidden(8, true); 	// Fax
                break;
            case "search":
                //break;
            case "company":
                this.MembersCM.setHidden(1, false); 	// 직위
                // 자회사
                this.MembersCM.setHidden(3, false); 	// 사번
                this.MembersCM.setHidden(4, false); 	// 직무
                this.MembersCM.setHidden(5, true); 	// 부서
                this.MembersCM.setHidden(6, true); 	// 휴대폰
                this.MembersCM.setHidden(7, true); 	// 사내전화
                this.MembersCM.setHidden(8, true); 	// Fax
            default:
                break;
        }
        if (eventFrom == "group") {
            this.MembersCM.setColumnHeader(2, GetResource("GroupName")); // 메일그룹이름으로 변경
            this.MembersCM.setColumnWidth(2, 293); // 메일그룹이름 size
        } else {
            this.MembersCM.setColumnHeader(2, GetResource("UserName")); // 이름으로 변경
            if (g_langCode == "en") {
                this.MembersCM.setColumnWidth(2, 140); // 이름
            } else {
                this.MembersCM.setColumnWidth(2, 65); // 이름
            }
        }
    },

    On_Member_DbClick: function () {
        this.HandlerAddPerson(this.MembersGrid, this.PersonsResult);
    },

    On_Person_DbClick: function () {
        this.HandlerRemovePerson(this.PersonsGrid, this.PersonsResult);
    },

    On_ButtonClick: function (strType) {
        var dataGrid = this.PersonsGrid;
        var dsResult = this.PersonsResult;

        var mask = new Ext.LoadMask(dataGrid.getView().el, { msg: GetResource("WaitMsg") });
        mask.show();

        switch (strType) {
            case 'Add':
                this.HandlerAddPerson(dataGrid, dsResult);
                break;

            case 'Remove':
                if (dataGrid.getSelectionModel().getSelections().length > 0)
                    this.HandlerRemovePerson(dataGrid, dsResult);
                break;

            case 'RemoveAll':
                if (dsResult.getCount() > 0)
                    this.HandlerRemoveAllPerson(dataGrid, dsResult);
                break;
        }
        mask.hide();
    },

    HandlerAddPerson: function (dataGrid, dsResult) {
        Ext.each(this.MembersGrid.getSelectionModel().getSelections(), function (record, index, allItems) {

            if (record.data.Email.ADDisplayName == 0) return;

            var foundItem = dsResult.find('EmpID', record.data.EmpID);

            if (foundItem == -1) {
                var newRecord = new OrgDataRecord({
                    EmpID: record.data.EmpID,
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
                    SignID: record.data.SignID,
                    Kostl: record.data.Kostl
                });
                dsResult.add(newRecord);
            }
        }, this);

        this.AllSelectionClear();
    },

    HandlerRemovePerson: function (dataGrid, dsResult) {
        Ext.each(dataGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
            dsResult.remove(record);
        }, this);
        this.AllSelectionClear();
    },

    HandlerRemoveAllPerson: function (dataGrid, dsResult) {
        dsResult.removeAll();
        this.AllSelectionClear();
    },

    DragDropSetting: function () {

        var dsPerson = this.PersonsResult;
        var grids = this.CurrentGridSet;

        function AllSelectionClear() {
            grids.Member.getSelectionModel().clearSelections();
            var membersHeader = grids.Member.getView().getHeaderCell(0).childNodes[0];
            Ext.get(membersHeader).removeClass('x-grid3-hd-checker-on');

            grids.Person.getSelectionModel().clearSelections();
            var personsHeader = grids.Person.getView().getHeaderCell(0).childNodes[0];
            Ext.get(personsHeader).removeClass('x-grid3-hd-checker-on');
        }

        function HandlerRemovePerson(ddSource) {
            Ext.each(ddSource.dragData.selections, function (record, index, allItems) {
                ddSource.grid.store.remove(record);
            }, this)

            AllSelectionClear();
        }

        function HandlerAddPerson(ddSource) {
            Ext.each(ddSource.dragData.selections, function (record, index, allItems) {

                if (record.data.Email.ADDisplayName == 0) return;

                var foundItem = dsPerson.find('EmpID', record.data.EmpID);

                if (foundItem == -1) {
                    var newRecord = new OrgDataRecord({
                        EmpID: record.data.EmpID,
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
                        SignID: record.data.SignID,
                        Kostl: record.data.Kostl
                    });
                    dsPerson.add(newRecord);
                }
            }, this)

            AllSelectionClear();
        }

        var MembersGridDropTargetEl = this.CurrentGridSet.Member.getView().el.dom.childNodes[0].childNodes[1]
        this.MembersGridDropTarget = new Ext.dd.DropTarget(MembersGridDropTargetEl, {
            ddGroup: 'DDGPersons',
            notifyDrop: function (ddSource, e, data) {
                HandlerRemovePerson(ddSource)
            }
        });

        var PersonsGridDropTargetEl = this.CurrentGridSet.Person.getView().el.dom.childNodes[0].childNodes[1]
        this.PersonsGridDropTarget = new Ext.dd.DropTarget(PersonsGridDropTargetEl, {
            ddGroup: 'DDGSelect',
            notifyDrop: function (ddSource, e, data) {
                HandlerAddPerson(ddSource);
            }
        });
    },

    Render: function () {

        var searchBox = this.GetEmpNameSearchBox();
        var treeBox = this.GetCompanyDeptTree();
        var langCombo = new Ext.ux.LanguageCycleButton();

        var clearSearchBox = function () {
            var node = treeBox.getSelectionModel().getSelectedNode();
            if (node) {
                var company = this.GetCurrentCompany();
                this.MembersResult.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'dept', query: node.id} });
                this.MembersGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                this.SetCoulumVisiable("company");
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
                        this.WarningMessageBox(GetResource("NoUseSpecialMsg"), function () {
                            searchBox.focus();
                        });
                        return false;
                    } else if (alphanum.test(strName)) {
                        // 사번검색  --> NOTE: 사번검색할 때 3자로 제한해야함. sk로 검색하면 대박.
                        if (strName.length < 3) {
                            searchBox.setValue('');
                            this.WarningMessageBox(GetResource("NoUseAlphaNumTwoWord"), function () {
                                searchBox.focus();
                            });
                            return false;
                        }
                    }
                    var company = this.GetCurrentCompany();
                    this.MembersResult.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'member', query: strName} });
                    this.SetCoulumVisiable("search");
                    this.MembersGrid.setTitle('[' + strName + '] ' + GetResource("SearchResult"));
                    this.GroupCombo.clearSelect();
                    return true;
                } else {
                    searchBox.setValue('');
                    this.WarningMessageBox(GetResource("UseSearch"), function () {
                        searchBox.focus();
                    });
                    return false;
                }
            }
            return false;
        };
        searchBox.SearchClick = doSearchBox.createDelegate(this);

        treeBox.getLoader().on('load', function (treeLoader, node, response) {
            if (this.IsInnerCompany()) {
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
                var company = this.GetCurrentCompany();
                this.SetCoulumVisiable("company");
                this.MembersResult.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'dept', query: node.id} });
                this.MembersGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                searchBox.onTrigger1Click();
                this.GroupCombo.clearSelect();
            }
        }, this);

        treeBox.getLoader().on('beforeload', function (treeLoader, node) {
            if (treeLoader.baseParams) {
                var company = this.GetCurrentCompany();
                treeLoader.baseParams.companyCode = company.companyCode;
                treeLoader.baseParams.isRelative = company.isRelative;
            }
        }, this);

        this.GroupCombo.on("change", function (combo, item) {
            if (!this.IsInnerCompany()) return;
            var company = this.GetCurrentCompany();
            if (item.groupTypeCode != undefined) {
                this.SetCoulumVisiable("group");
                this.MembersResult.load({ params: { companyCode: company.companyCode, mode: 'mailgroup', query: item.groupTypeCode, type: item.type} });
            }
            else {
                this.SetCoulumVisiable("company");
                this.MembersResult.load({ params: { companyCode: company.companyCode, mode: 'group', query: item.groupCode, type: item.type} });
            }
            this.MembersGrid.setTitle(Ext.util.Format.htmlEncode(item.groupName));
            searchBox.onTrigger1Click();
        }, this);

        this.CompanyCombo.on("change", function (combo, item) {
            if (this.GroupCombo.getActiveItem()) {
                this.GroupCombo.clearSelect();
            }
            treeBox.getRootNode().children = null;
            treeBox.getRootNode().reload();
            if (item.isRelative == "N") {
                this.GroupCombo.show();
                if (item.companyCode === this.MyCompanyCode) {
                    treeBox.expandPath(this.MyDeptSelectPath);
                    treeBox.selectPath(this.MyDeptSelectPath);
                }
                Ext.Ajax.request({
                    url: OrgServerURL,
                    params: { action: 'GetCompanyGroup', companyCode: item.companyCode },
                    method: 'POST',
                    success: function (response, option) {
                        var data = Ext.util.JSON.decode(response.responseText);
                        if (data) {
                            if (data.result == false) {
                                this.FadeOutMainLoadMask();
                                this.ErrorMessageBox(GetResource("AjaxErrorMsg1") +
									data.ErrorMessage + GetResource("AjaxErrorMsg2"), function () {
									    window.close();
									});
                                return;
                            }

                            //그룹선택
                            var groupItems = [];

                            for (var i = 0; i < data.Group.length; i++) {
                                groupItems[groupItems.length] = data.Group[i];
                            }
                            groupItems[groupItems.length] = { text: GetResource('GroupIndividual'), menu: { items: data.AddGroup} };

                            this.GroupCombo.items = groupItems;
                            this.GroupCombo.initComponent();
                        }
                    },
                    failure: function (response, option) {
                        this.FadeOutMainLoadMask();
                        this.ErrorMessageBox(GetResource("AjaxFailMsg"), function () {
                            window.close();
                        });
                    },
                    scope: this,
                    async: false  //동작안함?   
                });
            } else {
                this.GroupCombo.hide();
            }
        }, this);

        this.ResultBox = new Ext.Panel({
            region: 'east',
            layout: 'ux.row',
            margins: '5 5 0 0',
            border: false,
            bodyStyle: 'background:#DFE8F6;',
            width: 240,
            items: [this.PersonsGrid]
        });

        treeBox.on('render', function () {
            treeBox.selectPath(this.MyDeptSelectPath);
            treeBox.expandPath(this.MyDeptSelectPath);
        }, this);

        var titleBox = this.GetHeaderTitleBox(GetResource("EmployeeSearch"));

        var mainPanelItems = [treeBox, this.MembersGrid, this.ResultBox];

        var mainPanelBtn = [{ text: GetResource("OkBtn"), handler: this.OnOK, scope: this },
			{ text: GetResource("CancelBtn"), handler: this.OnCancel, scope: this}];

        var mainToolBar = ['-', this.CompanyCombo, '-', this.GroupCombo, '->', '-', searchBox, '-', langCombo, '-'];

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
    },

    GetCurrentCompany: function () {
        if (this.CompanyCombo) {
            return this.CompanyCombo.getActiveItem();
        } else {
            alert("Company menu didn't initialized."); //alert("회사메뉴 초기화 안됬음");
        }
    },

    SetCurrentCompanyCode: function (companyCode) {
        this.CurrentCompanyCode = companyCode;
    },

    // 성명/사번 검색
    GetEmpNameSearchBox: function (width) {
        var width = width || 170;
        var searchBox = new Ext.app.SearchField({
            emptyText: GetResource("SearchBox"),
            minLength: 2,
            maxLength: 8,
            width: width
        });
        //Ext.override(Ext.app.SearchField, {
        //	afterRender : Ext.app.SearchField.prototype.afterRender.createSequence(function(){
        //		var qt = this.qtip;
        //		if(qt){
        //			Ext.QuickTips.register({
        //				target: this,
        //				text: qt,
        //				enabled: true,
        //				showDelay: 0
        //			});
        //		}
        //})});
        return searchBox;
    },

    // 회사부서 트리
    GetCompanyDeptTree: function (width) {
        var width = width ? width : 230;

        var tree = new Ext.tree.TreePanel({
            id: 'company-tree',
            region: 'west',
            width: width,
            margins: '5 0 0 5',
            rootVisible: false,
            lines: true,
            autoScroll: true,
            loader: new Ext.tree.TreeLoader({
                url: OrgServerURL,
                baseParams: { action: 'GetCompanyDeptTree' },
                requestMethod: 'POST'
            }),
            root: new Ext.tree.AsyncTreeNode({
                text: 'company',
                id: 'company-root',
                expanded: true
            }),
            collapseFirst: false
        });
        return tree;
    },

    GetInitialize: function (callback, scope) {
        Ext.Ajax.request({
            url: OrgServerURL,
            params: { action: 'GetInitialize' },
            method: 'POST',
            success: function (response, option) {
                var data = Ext.util.JSON.decode(response.responseText);
                if (data) {
                    if (data.result == false) {
                        this.FadeOutMainLoadMask();
                        this.ErrorMessageBox(GetResource("AjaxErrorMsg1") +
							data.ErrorMessage + GetResource("AjaxErrorMsg2"), function () {
							    window.close();
							});
                        return;
                    }
                    this.commonData = data;
                    this.MyCompanyCode = data.MyCompanyCode;
                    this.MyDeptSelectPath = '/company-root' + data.MyDeptSelectPath;
                    this.MyEmail = data.UserEmail;

                    //회사선택
                    var companyItems = [];
                    var mycompany = null;
                    for (var i = 0; i < data.InnerCompany.length; i++) {
                        companyItems[companyItems.length] = data.InnerCompany[i];
                        if (data.InnerCompany[i].checked) {
                            mycompany = data.InnerCompany[i];
                        }
                    }

                    //결재선 지정창에서는 관계사를 제외함.
                    //					if(NoRelativeCompany == false){
                    //						companyItems[companyItems.length] = '<b class="menu-title"><span class="menu-title-text">' + GetResource("SKRelative") + '</span></b>';
                    //						for(var i=0; i<data.RelativeCompany.length; i++){
                    //							companyItems[companyItems.length] = data.RelativeCompany[i];
                    //						}
                    //					}

                    this.CompanyCombo = new GW.OrgMap.ComboMenuButton({
                        items: companyItems
                    });
                    this.CompanyCombo.activeItem = mycompany;

                    //그룹선택
                    var groupItems = [];

                    for (var i = 0; i < data.Group.length; i++) {
                        groupItems[groupItems.length] = data.Group[i];
                    }
                    groupItems[groupItems.length] = { text: GetResource('GroupIndividual'), menu: { items: data.AddGroup} };

                    this.GroupCombo = new GW.OrgMap.ComboMenuButton({
                        emptyText: GetResource("GroupCombo"),
                        items: groupItems
                    });

                    if (callback) {
                        scope = scope || window;
                        callback.call(scope);
                    }
                }
            },
            failure: function (response, option) {
                this.FadeOutMainLoadMask();
                this.ErrorMessageBox(GetResource("AjaxFailMsg"), function () {
                    window.close();
                });
            },
            scope: this,
            async: false  //동작안함?   
        });
    },

    OnMembersDataChanged: function (store) {
        if (store.reader.jsonData.NumOfPerson) {
            var num = store.reader.jsonData.NumOfPerson;
            var title = this.MembersGrid.title;
            title += " <span style='color:#e6ffff'>(" + GetResource("Total") + num + GetResource("PersonCount") + ")</span>";
            this.MembersGrid.setTitle(title);
        }
        if (!this.IsInnerCompany()) {
            //  사용자 이름
            this.MembersCM.setColumnWidth(2, 58);
        } else {
            if (g_langCode == "en") {
                this.MembersCM.setColumnWidth(2, 145);
            } else {
                this.MembersCM.setColumnWidth(2, 75);
            }
        }
    },

    AllSelectionClear: function () {
        this.MembersGrid.getSelectionModel().clearSelections();
        var membersHeader = this.MembersGrid.getView().getHeaderCell(0).childNodes[0];
        Ext.get(membersHeader).removeClass('x-grid3-hd-checker-on');

        this.PersonsGrid.getSelectionModel().clearSelections();
        var personsHeader = this.PersonsGrid.getView().getHeaderCell(0).childNodes[0];
        Ext.get(personsHeader).removeClass('x-grid3-hd-checker-on');
    },

    OnOK: function () {
        var pXML = '<?xml version="1.0" encoding="UTF-8"?><Persons></Persons>';
        if (this.PersonsResult.getCount() > 0) {
            var orgmapData = new Array();
            this.PersonsResult.each(function (store) {
                orgmapData[orgmapData.length] = store.data;
            });
            //var sJSON = Ext.encode(orgmapData);
            pXML = this.toXML(orgmapData);
        }
        window.external.Ok(pXML);
    },

    OnCancel: function () {
        window.external.Cancel();
    },

    toXML: function (obj) {
        var strXML = '<?xml version="1.0" encoding="UTF-8"?><Persons></Persons>';
        var dom = null;
        if (window.ActiveXObject) {
            // IE
            try {
                dom = new ActiveXObject('Microsoft.XMLDOM');
                dom.async = false;
                dom.loadXML(strXML)
            }
            catch (e) {
                alert("Microsoft.XMLDOM Exception :" + e.message);
                return null;
            }
        } else {
            alert("This function support IE only."); //alert("IE만 지원되는 함수입니다.");
            return null;
        }
        try {
            var root = dom.documentElement;
            if (obj instanceof Array) {
                for (var i = 0, size = obj.length; i < size; i++) {
                    var person = dom.createElement("Person");
                    var nodeObj = obj[i];
                    for (var prop in nodeObj) {
                        var record = dom.createElement(prop);
                        //	                    var value = dom.createCDATASection(nodeObj[prop]);
                        //	                    record.appendChild(value);
                        record.text = nodeObj[prop];
                        person.appendChild(record);
                    }
                    root.appendChild(person);
                }
            }
            else if (typeof obj == "object") {
                var person = dom.createElement("Person");
                for (var prop in obj) {
                    var record = dom.createElement(prop);
                    //	                var value = dom.createCDATASection(obj[prop]);
                    //	                record.appendChild(value);
                    record.text = nodeObj[prop];
                    person.appendChild(record);
                }
                root.appendChild(person);
            }
            else return null;
        }
        catch (e) {
            alert("Microsoft.XMLDOM Exception :" + e.message);
            return null;
        }
        return dom.xml;
    }
});

// 회사선택이나 그룹선택을 위한 Custom 버튼 메뉴
GW.OrgMap.ComboMenuButton = Ext.extend(Ext.Button, {
	
	getItemText : function(item){
        if(item){
            var text = item.text;
            return text;
        }
        return undefined;
    },
	
	setActiveItem : function(item, suppressEvent){
        if(item && typeof item != 'object'){
            item = this.menu.items.get(item);
        }
        if(item){
            if(!this.rendered){
                this.text = this.getItemText(item);
                this.iconCls = item.iconCls;
            }else{
                var t = this.getItemText(item);
                if(t){
                    this.setText(t);
                }
                this.setIconClass(item.iconCls);
            }
            this.activeItem = item;
            if(!item.checked){
                item.setChecked(true, true);
            }
            if(this.forceIcon){
                this.setIconClass(this.forceIcon);
            }
            if(!suppressEvent){
                this.fireEvent('change', this, item);
            }
        }else{
            if(!this.rendered){
                this.text = this.emptyText || 'blank';
                this.iconCls = undefined;
            }else{
                var t = this.emptyText || 'blank';
                if(t){
                    this.setText(t);
                }
                this.setIconClass(undefined);
            }
            if(this.activeItem){
				if(this.activeItem.checked){
					this.activeItem.setChecked(false, true);
				}
            }
            this.activeItem = undefined;       
			if(this.forceIcon){
                this.setIconClass(this.forceIcon);
            }
        }
    },
    
    getActiveItem : function(){
        return this.activeItem;
    },
    
    assertMenuHeight: function(m){
		var maxHeight = Ext.getBody().getHeight() - 30;
		if (m.el.getHeight() > maxHeight) {
			m.el.setHeight(maxHeight);
			m.el.applyStyles('overflow:auto;');
		} 
    },
    
	initComponent : function(){
        this.addEvents("change");

        if(this.changeHandler){
            this.on('change', this.changeHandler, this.scope||this);
            delete this.changeHandler;
        }
        this.itemCount = this.items.length;
		
		//this.menu = {items:[], listeners:{beforeshow:this.assertMenuHeight}};
		this.menu = {items:[]};
        var checked;

		for(var i = 0, len = this.itemCount; i < len; i++){
            var item = this.items[i];
            if(item.menu){
				var subMenuItems = item.menu.items;
				for(var j = 0, jlen = subMenuItems.length; j < jlen; j++){
					var subItem = subMenuItems[j];
					subItem.text = Ext.util.Format.htmlEncode(subItem.text);
					subItem.type = "member";
					subItem.group = subItem.group || this.id;
					subItem.itemIndex = j;
					subItem.checkHandler = this.checkHandler;
					subItem.scope = this;
					subItem.checked = subItem.checked || false;
					if(subItem.checked){
						checked = subItem;
					}
				}
				this.menu.items.push(item);
            }
            else{
				item.text = Ext.util.Format.htmlEncode(item.text);
				item.type = "group";
				item.group = item.group || this.id;
				item.itemIndex = i;
				item.checkHandler = this.checkHandler;
				item.scope = this;
				item.checked = item.checked || false;
				this.menu.items.push(item);
				if(item.checked){
					checked = item;
				}
            }
        }
        this.setActiveItem(checked, true);
        GW.OrgMap.ComboMenuButton.superclass.initComponent.call(this);
    },
    
    clearSelect : function(){
		this.setActiveItem(null, false);
    },

    // private
    checkHandler : function(item, pressed){
        if(pressed){
            this.setActiveItem(item);
        }
    }    
 });

 Ext.override(Ext.menu.Menu, {
    onClick : function(e){
        var t;
        if(t = this.findTargetItem(e)){
            if(t.menu){
                t.expandMenu();
                e.stopEvent();
            }else{
            	t.onClick(e);
            	this.fireEvent("click", this, t, e);
            }
        }
    }
});

