/*
* SetLine.Org.js
* 조직도
*/

var OrgServerURL = 'OrgServer.aspx';

var NoRelativeCompany = false;

var OrgDataFields = [
	{ name: 'EmpID' },
	{ name: 'LoginID' },
	{ name: 'ADDisplayName' },
	{ name: 'UserName' },
	{ name: 'Email' },
	{ name: 'Type' },	// mandatory : '', 'USER', 'DEPT', 'GROUP'
	{ name: 'DeptCode' },
	{ name: 'DeptName' },
	{ name: 'CompanyCode' },
	{ name: 'CompanyName' },
    { name: 'SignID' },
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
    { name: 'Icon' },
];

//조직도에 공통적으로 들어가는 Component를 정의
    GW.SetLine.Org = function () {

        this.ReturnPanel = null;
        this.DeptTree = null;
        this.MembersGridDropTarget = null;
        //debugger;
        this.MembersResult = new Ext.data.JsonStore({
            url: OrgServerURL,
            baseParams: { action: 'GetMemberListForApp' },
            root: 'dataRoot',
            fields: OrgDataFields,
            remoteSort: false
        });

        this.MembersGridCheckBox = new Ext.grid.CheckboxSelectionModel();
        this.MembersCM = new Ext.grid.ColumnModel([
		        this.MembersGridCheckBox
            , { header: GetResource("UserDuty"), dataIndex: 'DutyName', menuDisabled: true, width: 45, renderer: this.RendererWithTooltip }
		    , { header: GetResource("UserRank"), dataIndex: 'RankName', menuDisabled: true, width: 60, renderer: this.RendererWithTooltip }
	        , { header: GetResource("UserEmpty"), dataIndex: 'Icon', menuDisabled: true, width: 20, renderer: this.RenderIcon }
		    , { header: GetResource("UserName"), dataIndex: 'UserName', menuDisabled: true, width: 160, renderer: this.RendererUserName.createDelegate(this) }
		    , { header: GetResource("UserEmpID"), dataIndex: 'EmpID', menuDisabled: true, width: 55, renderer: this.RendererWithTooltip, hidden: true }
		    , { header: GetResource("UserJob"), dataIndex: 'JobName', menuDisabled: true, width: 120, renderer: this.RendererWithTooltip, hidden: true }

		    , { header: GetResource("UserDept"), dataIndex: 'DeptName', menuDisabled: true, width: 140, renderer: this.RendererWithTooltip, hidden: true }
		    , { header: GetResource("UserCellPhone"), dataIndex: 'CellPhone', menuDisabled: true, width: 95, renderer: this.RendererWithTooltip, hidden: true }
		    , { header: GetResource("UserOfficeTel"), dataIndex: 'ExtensionNumber', menuDisabled: true, width: 95, renderer: this.RendererWithTooltip, hidden: true }
		    , { header: GetResource("UserFax"), dataIndex: 'FaxNumber', menuDisabled: true, width: 80, renderer: this.RendererWithTooltip, hidden: true }
	    ]);
        this.MembersCM.defaultSortable = true;

        this.MembersGrid = new Ext.grid.GridPanel({
            region: 'center',
            margins: '5 5 5 5',
            ddGroup: 'DDGSelect',
            enableDragDrop: true,
            enableColumnMove: false,
            ds: this.MembersResult,
            cm: this.MembersCM,
            sm: this.MembersGridCheckBox,
            stripeRows: true,
            title: '&nbsp;&nbsp;',
            loadMask: { msg: GetResource("WaitMsg") },
            bbar: [
                '->',
            // 2017-02-02 (장윤호)
            //{ xtype: 'tbspacer' },
            //{
            //    xtype: 'box',
            //    autoEl: { tag: 'img', src: '/Resources/Images/Icon/00.png' }
            //},
            //GetResource("doc00"),
            //{ xtype: 'tbspacer' },
            //{ xtype: 'tbspacer' },
            //{ xtype: 'tbspacer' },
            //{ xtype: 'tbspacer' },
            //{
            //    xtype: 'box',
            //    autoEl: { tag: 'img', src: '/Resources/Images/Icon/01.png' }
            //},
            //GetResource("doc01"),
            //{ xtype: 'tbspacer' },
            //{ xtype: 'tbspacer' },
            //{ xtype: 'tbspacer' },
            //{ xtype: 'tbspacer' },
            //{
            //    xtype: 'box',
            //    autoEl: { tag: 'img', src: '/Resources/Images/Icon/02.png' }
            //},
            //GetResource("doc02"),
            //{ xtype: 'tbspacer' },
            //{ xtype: 'tbspacer' },
            //{ xtype: 'tbspacer' },
            //{ xtype: 'tbspacer' },
                {
                xtype: 'box',
                autoEl: { tag: 'img', src: '/Resources/Images/Icon/addj.png' }
            },
                GetResource("Addj")
            ]
        });

        this.MembersResult.on('datachanged', this.OnMembersDataChanged, this);
        this.MembersResult.on('beforeload', function (store, options) {
            // DATA가 변경될 때 Presence 정보를 초기화
            GW.NameControl.UnRegisterPresenceAll();
        }, this);

        this.MembersGrid.on('dblclick', this.On_DbClick, this);
        this.MembersGrid.on('render', function () { this.DragDropSetting(); }, this);
    };

    Ext.extend(GW.SetLine.Org, GW.SetLine.Common, {

        SetCoulumVisiable: function (eventFrom) {
            switch (eventFrom) {
                case "group":
                    this.MembersCM.setHidden(1, false); 	// 직책
                    this.MembersCM.setHidden(2, false); 	// 직위
                    // 자회사
                    //this.MembersCM.setHidden(5, false); 	// 사번
                    //this.MembersCM.setHidden(6, true); 	// 직무
                    //this.MembersCM.setHidden(7, false); 	// 부서
                    //this.MembersCM.setHidden(8, true); 	// 휴대폰
                    //this.MembersCM.setHidden(9, true); 	// 사내전화
                    //this.MembersCM.setHidden(10, true); 	// Fax
                    break;
                case "search":
                    //break;
                case "company":
                    this.MembersCM.setHidden(1, false); 	// 직책
                    this.MembersCM.setHidden(2, false); 	// 직위
                    // 자회사
                    //this.MembersCM.setHidden(5, false); 	// 사번
                    //this.MembersCM.setHidden(6, false); 	// 직무
                    //this.MembersCM.setHidden(7, true); 	// 부서
                    //this.MembersCM.setHidden(8, true); 	// 휴대폰
                    //this.MembersCM.setHidden(9, true); 	// 사내전화
                    //this.MembersCM.setHidden(10, true); 	// Fax
                    break;
                default:
                    break;
            }
            //	        if (eventFrom == "group") {
            //	            this.MembersCM.setColumnHeader(3, GetResource("GroupName")); // 메일그룹이름으로 변경
            //	            this.MembersCM.setColumnWidth(3, 293); // 메일그룹이름 size
            //	        } else {
            this.MembersCM.setColumnHeader(4, GetResource("UserName")); // 이름으로 변경

            // 첫로딩후 이름 컬럼이 줄어듬으로 주석 처리 2017-07-01 장윤호
            //if (g_langCode == "en") {
            //    this.MembersCM.setColumnWidth(4, 140); // 이름
            //} else {
            //    this.MembersCM.setColumnWidth(4, 60); // 이름
            //}
            //	        }

            //this.MembersCM.setHidden(5, true); 	// 사번
        },

        On_DbClick: function () {
            Ext.each(this.MembersGrid.getSelectionModel().getSelections(), function (record, index, allItems) {
                this.On_Approver_DbClickItem(record, index, allItems);
            }
		, this);
        },

        ReturnSourceGrid: function () {
            return this.MembersGrid;
        },

        DragDropSetting: function () {
            var MembersGridDropTargetEl = this.MembersGrid.getView().el.dom.childNodes[0].childNodes[1]
            this.MembersGridDropTarget = new Ext.dd.DropTarget(MembersGridDropTargetEl, {
                ddGroup: 'DDGApprover',
                notifyDrop: function (ddSource, e, data) {

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

            this.MembersGridDropTarget.addToGroup('DDGAgree1');
            this.MembersGridDropTarget.addToGroup('DDGAgree2');
            this.MembersGridDropTarget.addToGroup('DDGAgree3');
            this.MembersGridDropTarget.addToGroup('DDGAgree4');
            this.MembersGridDropTarget.addToGroup('DDGAgreeBefore');
            this.MembersGridDropTarget.addToGroup('DDGAgreeAfter');
            this.MembersGridDropTarget.addToGroup('DDGACharge');
            this.MembersGridDropTarget.addToGroup('DDGSend');
            this.MembersGridDropTarget.addToGroup('DDGCopy');
            this.MembersGridDropTarget.addToGroup('DDGCharge');
            this.MembersGridDropTarget.addToGroup('DDGReceive');
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

                    // 협력업체 클릭시                     2017-04-10 장윤호
                    //if (node.id == "ZZZZZZZZZZ") {
                    //    this.MembersCM.setColumnWidth(4, 300);      // 이름
                    //    this.MembersCM.setHidden(1, true);          // 직책
                    //    this.MembersCM.setHidden(2, true);          // 직위
                    //    this.MembersCM.setHidden(3, true);          // 겸직 아이콘
                    //    this.MembersCM.setHidden(6, true);          // 주요업무
                    //}
                    //else {
                    //    this.MembersCM.setColumnWidth(4, 60);       // 이름
                    //    this.MembersCM.setHidden(1, false);         // 직책
                    //    this.MembersCM.setHidden(2, false);         // 직위
                    //    this.MembersCM.setHidden(3, false);         // 겸직 아이콘
                    //    this.MembersCM.setHidden(6, false);         // 주요업무
                    //}
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
                    this.MembersResult.load({ params: { companyCode: company.companyCode, mode: 'group', query: item.groupTypeCode, type: item.type} });
                    this.MembersGrid.setTitle(Ext.util.Format.htmlEncode(item.groupTypeName));
                }
                else {
                    this.SetCoulumVisiable("group");
                    this.MembersResult.load({ params: { companyCode: company.companyCode, mode: 'group', query: item.groupCode, type: item.type} });
                    var title = item.groupName;
                    if (item.groupName.length > 25) {
                        title = item.groupName.substring(0, 24) + "...";
                    }
                    this.MembersGrid.setTitle(Ext.util.Format.htmlEncode(title));
                }
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

                                groupItems[groupItems.length] = { text: GetResource('GroupIndividual'), menu: { items: data.AddGroup} };

                                if (data.Group != null) {
                                    for (var i = 0; i < data.Group.length; i++) {
                                        groupItems[groupItems.length] = data.Group[i];
                                    }
                                }

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

            treeBox.on('render', function () {
                treeBox.selectPath(this.MyDeptSelectPath);
                treeBox.expandPath(this.MyDeptSelectPath);
            }, this);

            this.ReturnPanel = new Ext.Panel
		({
		    id: 'Org',
		    layout: 'border',
		    border: false,
		    bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
		    // 그룹선택, 다국어 콤보박스 숨기기
		    //tbar: ['-', this.CompanyCombo, '-', this.GroupCombo, '->', '-', searchBox, '-', langCombo, '-'],
		    tbar: ['-', this.CompanyCombo, '->', '-', searchBox, '-'],
		    items: [treeBox, this.MembersGrid]
		});
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
            var width = width ? width : 170;
            //var searchBox = new Ext.form.TwinTriggerField({
            var searchBox = new Ext.app.SearchField({
                id: 'searchBox',
                emptyText: GetResource("SearchBox"),
                minLength: 2,
                maxLength: 8,
                width: width
            });
            //		Ext.override(Ext.app.SearchField, {
            //			afterRender : Ext.app.SearchField.prototype.afterRender.createSequence(function(){
            //				var qt = this.qtip;
            //				if(qt){
            //					Ext.QuickTips.register({
            //						target: this,
            //						text: qt,
            //						enabled: true,
            //						showDelay: 0
            //					});
            //				}
            //		})});
            return searchBox;
        },

        // 회사부서 트리
        GetCompanyDeptTree: function (width) {
            var width = width ? width : 230;

            var tree = new Ext.tree.TreePanel({
                id: 'company-tree',
                region: 'west',
                width: width,
                margins: '5 0 5 5',
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

                        this.CompanyCombo = new GW.SetLine.ComboMenuButton({
                            items: companyItems
                        });
                        this.CompanyCombo.activeItem = mycompany;

                        //그룹선택
                        var groupItems = [];

                        groupItems[groupItems.length] = { text: GetResource('GroupIndividual'), menu: { items: data.AddGroup} };

                        if (data.Group != null) {
                            for (var i = 0; i < data.Group.length; i++) {
                                groupItems[groupItems.length] = data.Group[i];
                            }
                        }

                        this.GroupCombo = new GW.SetLine.ComboMenuButton({
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
                // 컬럼 헤더 소팅가능할때 클릭시 (총 X명) 중첩으로 쌓이는것 수정     2017-04-10 장윤호
                var total_str = " <span style='color:#e6ffff'>(" + GetResource("Total") + num + GetResource("PersonCount") + ")</span>";
                if (title.indexOf(total_str) == -1) {
                    title += total_str;
                }

                this.MembersGrid.setTitle(title);
            }
            if (!this.IsInnerCompany()) {
                //  사용자 이름      첫 로딩후 다시 줄어 들음으로 주석 2017-07-01
                //this.MembersCM.setColumnWidth(4, 60);
            } else {
                // 사용자 이름 변경 수정 막기      2017-04-10 장윤호
                //if (g_langCode == "en") {
                //    this.MembersCM.setColumnWidth(4, 140);
                //} else {
                //    this.MembersCM.setColumnWidth(4, 60);
                //}
            }
        }
    });

// 회사선택이나 그룹선택을 위한 Custom 버튼 메뉴
	GW.SetLine.ComboMenuButton = Ext.extend(Ext.Button, {

	    getItemText: function (item) {
	        if (item) {
	            var text = item.text;
	            return text;
	        }
	        return undefined;
	    },

	    setActiveItem: function (item, suppressEvent) {
	        if (item && typeof item != 'object') {
	            item = this.menu.items.get(item);
	        }
	        if (item) {
	            if (!this.rendered) {
	                this.text = this.getItemText(item);
	                this.iconCls = item.iconCls;
	            } else {
	                var t = this.getItemText(item);
	                if (t) {
	                    this.setText(t);
	                }
	                this.setIconClass(item.iconCls);
	            }
	            this.activeItem = item;
	            if (!item.checked) {
	                item.setChecked(true, true);
	            }
	            if (this.forceIcon) {
	                this.setIconClass(this.forceIcon);
	            }
	            if (!suppressEvent) {
	                this.fireEvent('change', this, item);
	            }
	        } else {
	            if (!this.rendered) {
	                this.text = this.emptyText || 'blank';
	                this.iconCls = undefined;
	            } else {
	                var t = this.emptyText || 'blank';
	                if (t) {
	                    this.setText(t);
	                }
	                this.setIconClass(undefined);
	            }
	            if (this.activeItem) {
	                if (this.activeItem.checked) {
	                    this.activeItem.setChecked(false, true);
	                }
	            }
	            this.activeItem = undefined;
	            if (this.forceIcon) {
	                this.setIconClass(this.forceIcon);
	            }
	        }
	    },

	    getActiveItem: function () {
	        return this.activeItem;
	    },

	    assertMenuHeight: function (m) {
	        var maxHeight = Ext.getBody().getHeight() - 30;
	        if (m.el.getHeight() > maxHeight) {
	            m.el.setHeight(maxHeight);
	            m.el.applyStyles('overflow:auto;');
	        }
	    },

	    initComponent: function () {
	        this.addEvents("change");

	        if (this.changeHandler) {
	            this.on('change', this.changeHandler, this.scope || this);
	            delete this.changeHandler;
	        }
	        this.itemCount = this.items.length;

	        //this.menu = {items:[], listeners:{beforeshow:this.assertMenuHeight}};
	        this.menu = { items: [] };
	        this.menu.width = 165;
	        var checked;

	        for (var i = 0, len = this.itemCount; i < len; i++) {
	            var item = this.items[i];

	            if (item.menu) {
	                var subMenuItems = item.menu.items;
	                for (var j = 0, jlen = subMenuItems.length; j < jlen; j++) {
	                    var subItem = subMenuItems[j];
	                    subItem.text = Ext.util.Format.htmlEncode(subItem.text);
	                    subItem.type = "member";
	                    subItem.group = subItem.group || this.id;
	                    subItem.itemIndex = j;
	                    subItem.checkHandler = this.checkHandler;
	                    subItem.scope = this;
	                    subItem.checked = subItem.checked || false;
	                    if (subItem.checked) {
	                        checked = subItem;
	                    }
	                }
	                this.menu.items.push(item);
	            }
	            else {
	                item.text = Ext.util.Format.htmlEncode(item.text);
	                item.type = "member";
	                item.group = item.group || this.id;
	                item.itemIndex = i;
	                item.checkHandler = this.checkHandler;
	                item.scope = this;
	                item.checked = item.checked || false;
	                this.menu.items.push(item);
	                if (item.checked) {
	                    checked = item;
	                }
	            }
	        }
	        this.setActiveItem(checked, true);
	        GW.SetLine.ComboMenuButton.superclass.initComponent.call(this);
	    },

	    clearSelect: function () {
	        this.setActiveItem(null, false);
	    },

	    // private
	    checkHandler: function (item, pressed) {
	        if (pressed) {
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

//GW.Org = new GW.SetLine.Org();
