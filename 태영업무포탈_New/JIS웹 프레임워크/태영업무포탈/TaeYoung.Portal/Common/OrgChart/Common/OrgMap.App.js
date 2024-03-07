/**
* orgmap.app.js
* application에서 불려지는 조직도
* 홍정화(caoko@miksystem.com) 2009-02-16
*/
// App 조직도 DATA
var APPDataFields = [
    {name: 'DisplayName' }, 	    // Name
    {name: 'ADDisplayName' }, 	    // AD의 DisplayName(사용자의 경우)
	{name: 'entryType' }, 		    // 0: 부서, 1: 그룹, 2:사용자
	{name: 'addr' }, 			    // 이메일주소	
	{name: 'AccountId' }, 		    // 사용자 로그인 ID(도메인 없음)
	{name: 'DeptName' }, 		    // 부서이름
	{name: 'DeptCode' }, 		    // 부서코드
	{name: 'RankCode' }, 		    // 직위
    {name: 'RankName' }, 		    // 직위
	{name: 'JobCode' }, 		    // 직책
	{name: 'JobName' }, 		    // 직책
	{name: 'DutyCode' }, 		    // 직무코드
	{name: 'DutyName' }, 		    // 직무
	{name: 'CompanyCode' }, 	    // 회사코드
	{name: 'CompanyName' }, 	    // 회사이름
	{name: 'EmpID' }, 			    // 사번
	{name: 'CellPhone' }, 		    // 휴대폰
	{name: 'ExtensionNumber' },     // 사내전화번호
	{name: 'FaxNumber' }, 		    // Fax번호
	{name: 'TeamChiefYN' }, 	    // 팀장여부	
    {name: 'Kostl' }, 	            // 코스트센터
    {name: 'SignID' },
    {name: 'SendYN' },
    {name: 'Icon' },
	{name: 'SiteCompanyCode' }, 	// Site 회사코드
	{name: 'SiteCompanyName'},   	// Site 회사이름
    {name: 'Culture' }
];

// 조직도가 Application에서 불려졌을 경우
	GW.OrgMap.Common.App = function () {
	    GW.OrgMap.Common.App.superclass.constructor.call(this);
	    this.OrgChartType = "APP";
	    // 관계사정보 선택 불가
	    this.NoShowRelativeCompany = true;
	    // 선택그리드의 Data를 저장할 객체
	    // 각각의 구현에서 초기화 해줘야 한다.
	    this.dsSource = null;
	    // 결과그리드의 Data를 저장할 객체
	    this.dsResult = new Ext.data.JsonStore({
	        fields: APPDataFields
	    });

	    // 조직도가 window.dialogArguments로 받을 수 있는 옵션 (디폴트값)
	    //this.OrgMapTitle
	    this.CustomApp = null;
	    this.AppType = "deptuser";
	    this.SelectCompany = true;
	    this.OnlyOneSelect = false;
	    this.ReturnType = "JSON";

	    // 부모 윈도우한테 받은 값
	    this.OrgMapData = null;
	    Ext.apply(this, parent.opener.vArguments);
	    //Ext.apply(this, window.dialogArguments);
	};
	Ext.extend(GW.OrgMap.Common.App, GW.OrgMap.Common, {
	    // Javascript Object를 XML로 Convert, XML Attribute는 고려안함.
	    toXML: function (obj) {
	        var strXML = '<?xml version="1.0" encoding="UTF-8"?><person></person>';
	        var dom = null;
	        try {
	            dom = $.parseXML(strXML);
	        }
	        catch (e) {
	            return null;
	        }

	        //        if (window.ActiveXObject) {
	        //            // IE
	        //            try {
	        //                dom = new ActiveXObject('Microsoft.XMLDOM');
	        //                dom.async = false;
	        //                dom.loadXML(strXML)
	        //            }
	        //            catch (e) {
	        //                alert("Microsoft.XMLDOM Exception :" + e.message);
	        //                return null;
	        //            }
	        //        } else {
	        //            alert(getResource("IEOnlyMSG"));
	        //            return null;
	        //        }
	        try {
	            var root = dom.documentElement;
	            if (obj instanceof Array) {
	                for (var i = 0, size = obj.length; i < size; i++) {
	                    var To = dom.createElement("To");
	                    var nodeObj = obj[i];
	                    for (var prop in nodeObj) {
	                        var record = dom.createElement(prop);
	                        var value = dom.createCDATASection(nodeObj[prop]);
	                        record.appendChild(value);
	                        To.appendChild(record);
	                    }
	                    root.appendChild(To);
	                }
	            }
	            else if (typeof obj == "object") {
	                var To = dom.createElement("To");
	                for (var prop in obj) {
	                    var record = dom.createElement(prop);
	                    var value = dom.createCDATASection(obj[prop]);
	                    record.appendChild(value);
	                    To.appendChild(record);
	                }
	                root.appendChild(To);
	            }
	            else return null;
	        }
	        catch (e) {
	            alert("Microsoft.XMLDOM Exception :" + e.message);
	            return null;
	        }
	        return dom.xml;
	    },

	    // 확인 버튼 처리
	    OnOk: function () {
	        var _window = parent.opener;
	        if (this.dsResult.getCount() > 0) {
	            var orgmapData = new Array();
	            this.dsResult.each(function (store) {
	                orgmapData[orgmapData.length] = store.data;
	            });
	            var sJSON = Ext.encode(orgmapData);

	            if (this.CallBack) {
	                if (this.ReturnType == 'JSON') {
	                    // JSON으로 반환
	                    this.CallBack.call(_window, sJSON);
	                } else if (this.ReturnType == 'XML') {
	                    // XML로 반환
	                    var sXML = this.toXML(orgmapData);
	                    this.CallBack.call(_window, sXML);
	                }
	            }
	        } else {
	            if (this.CallBack) {
	                if (this.ReturnType == 'JSON') {
	                    // JSON으로 반환
	                    this.CallBack.call(_window, "[]");
	                } else if (this.ReturnType == 'XML') {
	                    // XML로 반환
	                    this.CallBack.call(_window, '<?xml version="1.0"?><person></person>');
	                }
	            }
	        }
	        parent.window.close();
	    },

	    OnOneSelectOk: function () {
	        this.dsResult.removeAll();
	        if (this.SelectCheck) {
	            var data = this.SelectCheck.getSelected();
	            if (data) {
	                this.dsResult.add(data);
	            }
	        }
	        return this.OnOk();
	    },

	    // 취소 버튼 처리
	    OnCancel: function () {
	        if (parent.opener) {
	            parent.window.close();
	        }

	    },

	    // 선택그리드와 결과그리드 초기화
	    InitBothGrid: function () {
	        // 선택그리드
	        this.SelectCheck = new Ext.grid.CheckboxSelectionModel();
	        this.SelectColumn = new Ext.grid.ColumnModel([
			    this.SelectCheck,
                { header: getResource("UserDuty"), dataIndex: 'DutyName', menuDisabled: true, width: 50, renderer: this.RendererWithTooltip },
			    { header: getResource("UserRank"), dataIndex: 'RankName', menuDisabled: true, width: 50, renderer: this.RendererWithTooltip },
                { header: getResource("UserEmpty"), dataIndex: 'Icon', menuDisabled: true, width: 20, renderer: this.RenderIcon },
			    { header: getResource("UserName"), dataIndex: 'DisplayName', menuDisabled: true, width: 195, renderer: this.RendererDisplayName.createDelegate(this) },
	            { header: getResource("UserEmpID"), dataIndex: 'EmpID', menuDisabled: true, width: 55, renderer: this.RendererWithTooltip, hidden: true },
			    { header: getResource("UserJob"), dataIndex: 'JobName', menuDisabled: true, width: 130, renderer: this.RendererWithTooltip, hidden: true },
                { header: getResource("UserDept"), dataIndex: 'DeptName', menuDisabled: true, width: 130, renderer: this.RendererWithTooltip, hidden: true }
		    ]);

	        this.SelectGrid = new Ext.grid.GridPanel({
	            region: 'center',
	            margins: '5 5 0 5',
	            ddGroup: 'SelectGridDDGroup',
	            enableDragDrop: true,
	            enableColumnMove: false,
	            ds: this.dsSource,
	            cm: this.SelectColumn,
	            sm: this.SelectCheck,
	            stripeRows: true,
	            title: '&nbsp;&nbsp;',
	            loadMask: { msg: getResource("WaitMsg") },
	            bbar: [
                    '->',
	                // 2017-05-08 (장윤호)
                    //{ xtype: 'tbspacer' },
                    //{
                    //    xtype: 'box',
                    //    autoEl: { tag: 'img', src: '/Resources/Images/Icon/01.png' }
                    //},
                    //getResource("doc01"),
                    //{ xtype: 'tbspacer' },
                    //{ xtype: 'tbspacer' },
                    //{ xtype: 'tbspacer' },
                    //{ xtype: 'tbspacer' },
                    //{
                    //    xtype: 'box',
                    //    autoEl: { tag: 'img', src: '/Resources/Images/Icon/02.png' }
                    //},
                    //getResource("doc02"),
                    //{ xtype: 'tbspacer' },
                    //{ xtype: 'tbspacer' },
                    //{ xtype: 'tbspacer' },
                    //{ xtype: 'tbspacer' },
                    {
                        xtype: 'box',
                        autoEl: { tag: 'img', src: '/Resources/Images/Icon/addj.png' }
                    },
                    getResource("Addj")
                ]
	        });
	        // 결과그리드
	        this.ResultCheck = new Ext.grid.CheckboxSelectionModel();
	        this.ResultColumn = new Ext.grid.ColumnModel([
			this.ResultCheck,
			{ header: getResource("UserName"), dataIndex: 'ADDisplayName', menuDisabled: true, width: 195, renderer: this.RendererADDisplayName.createDelegate(this) }
		]);
	        this.ResultGrid = new Ext.grid.GridPanel({
	            region: 'east',
	            margins: '5 5 0 0',
	            ddGroup: 'ResultGridDDGroup',
	            enableDragDrop: true,
	            enableColumnMove: false,
	            ds: this.dsResult,
	            cm: this.ResultColumn,
	            sm: this.ResultCheck,
	            stripeRows: true,
	            viewConfig: {
	                //autoFill:true,
	                forceFit: true
	            },
	            bbar: ['->',
				{
				    tooltip: { title: getResource("Add"), text: getResource("AddTooltip") },
				    iconCls: 'add',
				    text: getResource("Add"),
				    handler: this.OnAddHandler,
				    scope: this
				},
				{
				    tooltip: { title: getResource("Remove"), text: getResource("RemoveTooltip") },
				    iconCls: 'delete',
				    text: getResource("Remove"),
				    handler: this.OnRemoveHandler,
				    scope: this
				},
				{
				    tooltip: { title: getResource("RemoveAll"), text: getResource("RemoveAllTooltip") },
				    iconCls: 'cross',
				    text: getResource("RemoveAll"),
				    handler: this.OnRemoveAllHandler,
				    scope: this
				}
			],
	            title: getResource("ResultBox"),
	            width: 240
	        });
	    },

	    // 선택그리드만 렌더링 될 경우에, Only One Select
	    InitSelectGrid: function () {
	        this.SelectCheck = new Ext.grid.CheckboxSelectionModel({ singleSelect: true, header: '' });
	        this.SelectColumn = new Ext.grid.ColumnModel([
			this.SelectCheck,
			    { header: getResource("UserDuty"), dataIndex: 'DutyName', menuDisabled: true, width: 50, renderer: this.RendererWithTooltip },
			    { header: getResource("UserRank"), dataIndex: 'RankName', menuDisabled: true, width: 50, renderer: this.RendererWithTooltip },
                { header: getResource("UserEmpty"), dataIndex: 'Icon', menuDisabled: true, width: 20, renderer: this.RenderIcon },
			    { header: getResource("UserName"), dataIndex: 'DisplayName', menuDisabled: true, width: 195, renderer: this.RendererDisplayName.createDelegate(this) },
	            { header: getResource("UserEmpID"), dataIndex: 'EmpID', menuDisabled: true, width: 55, renderer: this.RendererWithTooltip, hidden: true },
			    { header: getResource("UserJob"), dataIndex: 'JobName', menuDisabled: true, width: 130, renderer: this.RendererWithTooltip, hidden: true },
                { header: getResource("UserDept"), dataIndex: 'DeptName', menuDisabled: true, width: 130, renderer: this.RendererWithTooltip, hidden: true }
		]);
	        this.SelectGrid = new Ext.grid.GridPanel({
	            region: 'center',
	            margins: '5 5 0 5',
	            enableDragDrop: true,
	            enableColumnMove: false,
	            ds: this.dsSource,
	            cm: this.SelectColumn,
	            sm: this.SelectCheck,
	            stripeRows: true,
	            title: '&nbsp;&nbsp;',
	            loadMask: { msg: getResource("WaitMsg") }
	        });
	    },

	    // 선택그리드의 DisplayName 렌더링, Presence와 함께
	    RendererDisplayName: function (value, meta, record, rowIndex, colIndex, store) {
	        var strName = value;
	        // 부서 또는 그룹 Style
	        if (record.data.entryType != 2) {
	            // 부서 또는 그룹이다
	            // 스타일 변경
	            meta.attr = meta.attr + ' style="position: relative; overflow: visible; font-weight: 700; color: #800000;" ';
	        }
	        // 자회사인 경우에만
	        if (this.isInnerCompany()) {
	            // Presence를 렌더링 해준다.
	            // 자회사인 경우는 사번이 항상 있다.
	            //            if (record.data.addr != "" && record.data.entryType === 2) {
	            //                if (record.data.EmpID.length < 1) {
	            //                    //alert('사번이 없는 유저');
	            //                } else {
	            //                    var presence = GW.NameControl.toHTMLString(record.data.addr, record.data.EmpID);
	            //                    strName = presence + strName;
	            //                }
	            //            }
	        }

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

	    // 결과그리드의 이름 렌더링
	    RendererADDisplayName: function (value, meta, record, rowIndex, colIndex, store) {
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

	    // 선택그리드와 결과그리드가 있을 경우 명시적으로 체크를 취소한다.
	    AllSelectionClear: function () {
	        this.SelectCheck.clearSelections();
	        this.ResultCheck.clearSelections();

	        // header force uncheck
	        var selectHeader = this.SelectGrid.getView().getHeaderCell(0).childNodes[0];
	        var resultHeader = this.ResultGrid.getView().getHeaderCell(0).childNodes[0];

	        Ext.get(selectHeader).removeClass('x-grid3-hd-checker-on');
	        Ext.get(resultHeader).removeClass('x-grid3-hd-checker-on');
	    },

	    // 선택그리드와 결과그리드가 있을 경우 둘 간의 Drag&Drop을 설정한다.
	    // 그리드가 렌더링 된 후에 적용할 수 있다.
	    InitializeDragdrop: function () {
	        var mask = new Ext.LoadMask(this.ResultGrid.getView().el, { msg: getResource("WaitMsg") });
	        var dsResult = this.dsResult;
	        var clearCheck = this.AllSelectionClear.createDelegate(this);
	        var validateEmail = this.ValidateEmail;
	        var warningMsgBox = this.WarningMessageBox;

	        this.SelectDropTarget = new Ext.dd.DropTarget(this.SelectGrid.getView().el.dom.childNodes[0].childNodes[1], {
	            ddGroup: 'ResultGridDDGroup',
	            notifyDrop: function (ddSource, e, data) {
	                function removeRow(record, index, allItems) {
	                    ddSource.grid.store.remove(record);
	                }
	                mask.show();
	                if (ddSource.dragData.selections.length == ddSource.grid.store.getCount()) {
	                    ddSource.grid.store.removeAll();
	                } else {
	                    Ext.each(ddSource.dragData.selections, removeRow);
	                }
	                mask.hide();
	                clearCheck();
	                return (true);
	            }
	        });

	        this.ResultDropTarget = new Ext.dd.DropTarget(this.ResultGrid.getView().el.dom.childNodes[0].childNodes[1], {
	            ddGroup: 'SelectGridDDGroup',
	            notifyDrop: function (ddSource, e, data) {
	                function addRow(record, index, allItems) {
	                    if (record.data.addr == "" && record.data.entryType == 2) {// 사번비교
	                        var foundItem = dsResult.find('EmpID', record.data.EmpID);
	                        if (foundItem == -1) {
	                            dsResult.add(record);
	                        }
	                    } else {// 메일주소로 비교
	                        var foundItem = dsResult.find('addr', record.data.addr);
	                        if (foundItem == -1) {
	                            dsResult.add(record);
	                        }
	                    }
	                }
	                mask.show();
	                if (ddSource.dragData.selections.length == ddSource.grid.store.getCount()
					&& dsResult.getCount() == 0) {
	                    dsResult.data = ddSource.grid.store.data.clone();
	                }
	                else {
	                    Ext.each(ddSource.dragData.selections, addRow);
	                }
	                mask.hide();
	                dsResult.fireEvent("datachanged", dsResult);
	                clearCheck();
	                return (true);
	            }
	        });
	    },

	    // 결과그리드의 추가버튼 처리
	    OnAddHandler: function () {
	        var mask = new Ext.LoadMask(this.ResultGrid.getView().el, { msg: getResource("WaitMsg") });
	        if (this.SelectCheck.getSelections().length > 0) {
	            mask.show();
	            if (this.dsResult.getCount() == 0 && this.dsSource.getCount() == this.SelectCheck.getSelections().length) {
	                this.dsResult.data = this.dsSource.data.clone();
	            }
	            else {
	                Ext.each(this.SelectCheck.getSelections(), function (record, index, allItems) {
	                    if (record.data.addr == "" && record.data.entryType == 2) {// 사번비교
	                        var foundItem = this.dsResult.find('EmpID', record.data.EmpID);
	                        if (foundItem == -1) {
	                            this.dsResult.add(record);
	                        }
	                    } else {// 메일주소로 비교
	                        var foundItem = this.dsResult.find('addr', record.data.addr);
	                        if (foundItem == -1) {
	                            this.dsResult.add(record);
	                        }
	                    }
	                }, this);
	            }
	            this.dsResult.fireEvent("datachanged", this.dsResult);
	            mask.hide();
	        }
	        this.AllSelectionClear();
	    },

	    // 결과그리드의 제거버튼 처리
	    OnRemoveHandler: function () {
	        var mask = new Ext.LoadMask(this.ResultGrid.getView().el, { msg: getResource("WaitMsg") });
	        if (this.ResultCheck.getSelections().length > 0) {
	            mask.show();
	            if (this.ResultCheck.getSelections().length == this.dsResult.getCount()) {
	                this.dsResult.removeAll();
	            }
	            else {
	                Ext.each(this.ResultCheck.getSelections(), function (record, index, allItems) {
	                    this.dsResult.remove(record);
	                }, this);
	            }
	            this.dsResult.fireEvent("datachanged", this.dsResult);
	            mask.hide();
	        }
	        this.AllSelectionClear();
	    },

	    // 결과그리드의 모두제거버튼 처리
	    OnRemoveAllHandler: function () {
	        var mask = new Ext.LoadMask(this.ResultGrid.getView().el, { msg: getResource("WaitMsg") });
	        if (this.dsResult.getCount() > 0) {
	            mask.show();
	            this.dsResult.removeAll();
	            this.dsResult.fireEvent("datachanged", this.dsResult);
	            mask.hide();
	        }
	        this.AllSelectionClear();
	    },

	    // 선택그리드의 datachanage 이벤트
	    OnDsSourceDataChanged: function (store) {
	        // 총 인원 수를 제목에 렌더링해준다.
	        if (store.reader.jsonData.NumOfPerson) {
	            var num = store.reader.jsonData.NumOfPerson;
	            var title = this.SelectGrid.title;
	            title += " <span style='color:#e6ffff'>(" + getResource("Total") + num + getResource("PersonCount") + ")</span>";
	            this.SelectGrid.setTitle(title);
	        }
	    },

	    SetCoulumVisiable: function (eventFrom) {
            // 직무,부서 컬럼 히든관련 주석 2017-07-01 장윤호
	        if (this.ShowMailGroup == true) {
	            if (eventFrom == "group") {
	                this.SelectColumn.setColumnHeader(4, getResource("MailGroup")); // 메일그룹이름으로 변경
	                this.SelectColumn.setColumnWidth(4, 800); // 메일그룹이름 size

	                this.SelectColumn.setHidden(1, true); 	// 직책
	                this.SelectColumn.setHidden(2, true); 	// 직위
	                this.SelectColumn.setHidden(3, true); 	// icon
	                //this.SelectColumn.setHidden(5, true); 	// 직무
	                //this.SelectColumn.setHidden(6, true); 	// 부서
	            } else if (eventFrom == "groupmember") {
	                this.SelectColumn.setColumnHeader(4, getResource("UserName")); // 이름으로 변경
	                this.SelectColumn.setColumnWidth(4, 195); // 이름

	                this.SelectColumn.setHidden(1, false); 	// 직책
	                this.SelectColumn.setHidden(2, false); 	// 직위
	                this.SelectColumn.setHidden(3, false); 	// icon
	                //this.SelectColumn.setHidden(5, true); 	// 직무
	                //this.SelectColumn.setHidden(6, false); 	// 부서
	            } else {
	                this.GroupCombo.clearSelect();

	                this.SelectColumn.setColumnHeader(4, getResource("UserName")); // 이름으로 변경
	                this.SelectColumn.setColumnWidth(4, 195); // 이름

	                this.SelectColumn.setHidden(1, false); 	// 직책
	                this.SelectColumn.setHidden(2, false); 	// 직위
	                this.SelectColumn.setHidden(3, false); 	// icon
	                //this.SelectColumn.setHidden(5, false); 	// 직무
	                //this.SelectColumn.setHidden(6, true); 	// 부서
	            }
	        }
	    }
	});

GW.OrgMap.Common.App.Form = function () {
    GW.OrgMap.Common.App.Form.superclass.constructor.call(this);

    if (!this.CustomApp) {
        if (this.AppType === "DEPTUSER") {
            this.dsSource = new Ext.data.JsonStore({
                url: g_OrgMapServerURL,
                root: 'dataRoot',
                baseParams: { action: 'getMemberListForApp', isOnlyUser: "N" },
                fields: APPDataFields,
                remoteSort: false
            });
            if (this.OnlyOneSelect) this.InitSelectGrid();
            else this.InitBothGrid();
            this.dsSource.on('datachanged', this.OnDsSourceDataChanged, this);
            this.dsSource.on('beforeload', function () {
                // DATA가 변경될 때 Presence 정보를 reset 해줍니다.
                GW.NameControl.UnRegisterPresenceAll();
            }, this);
            this.getInitialize(function () {
                this.Render();
                if (!this.OnlyOneSelect) {
                    this.InitializeDragdrop();
                    if (this.OrgMapData) {
                        try {
                            this.dsResult.loadData(this.OrgMapData);
                        } catch (ex) { }
                    }
                }
                this.fadeoutMainLoadMask();
            }, this);
        }
        else if (this.AppType === "USER") {
            this.dsSource = new Ext.data.JsonStore({
                url: g_OrgMapServerURL,
                root: 'dataRoot',
                baseParams: { action: 'getMemberListForApp', isOnlyUser: "Y" },
                fields: APPDataFields,
                remoteSort: false
            });
            if (this.OnlyOneSelect) this.InitSelectGrid();
            else this.InitBothGrid();
            this.dsSource.on('datachanged', this.OnDsSourceDataChanged, this);
            this.dsSource.on('beforeload', function () {
                // DATA가 변경될 때 Presence 정보를 reset 해줍니다.
                GW.NameControl.UnRegisterPresenceAll();
            }, this);
            this.getInitialize(function () {
                this.Render();
                if (!this.OnlyOneSelect) {
                    this.InitializeDragdrop();
                    if (this.OrgMapData) {
                        try {
                            this.dsResult.loadData(this.OrgMapData);
                        } catch (ex) { }
                    }
                }
                this.fadeoutMainLoadMask();
            }, this);
        }
        else if (this.AppType === "DEPT") {
            if (this.OnlyOneSelect) {
                this.getInitialize(function () {
                    this.RenderSelectOneDept();
                    this.fadeoutMainLoadMask();
                }, this);
            } else {
                this.dsSource = new Ext.data.JsonStore({
                    url: g_OrgMapServerURL,
                    root: 'dataRoot',
                    baseParams: { action: 'getMemberListForApp', isOnlyUser: "N" },
                    fields: APPDataFields,
                    remoteSort: false
                });
                this.InitBothGrid();
                // 선택그리드
                this.SelectCheck = new Ext.grid.CheckboxSelectionModel();
                this.SelectColumn = new Ext.grid.ColumnModel([
					this.SelectCheck,
					{ header: getResource("UserDept"), dataIndex: 'DisplayName', menuDisabled: true, width: 100, renderer: this.RendererDisplayName.createDelegate(this) }
				]);
                this.SelectGrid = new Ext.grid.GridPanel({
                    region: 'center',
                    margins: '5 5 0 5',
                    ddGroup: 'SelectGridDDGroup',
                    enableDragDrop: true,
                    enableColumnMove: false,
                    ds: this.dsSource,
                    cm: this.SelectColumn,
                    sm: this.SelectCheck,
                    stripeRows: true,
                    viewConfig: {
                        //autoFill:true,
                        forceFit: true
                    },
                    title: '&nbsp;&nbsp;',
                    loadMask: { msg: getResource("WaitMsg") }
                });
                this.getInitialize(function () {
                    this.RenderSelectDept();
                    this.InitializeDragdrop();
                    if (this.OrgMapData) {
                        try {
                            this.dsResult.loadData(this.OrgMapData);
                        } catch (ex) { }
                    }
                    this.fadeoutMainLoadMask();
                }, this);
            }
        }
        else {
            this.fadeoutMainLoadMask();
            this.ErrorMessageBox(getResource("InvalidAPPTYPE") +
				Ext.util.Format.htmlEncode(data.ErrorMessage) + getResource("AjaxErrorMsg2"), function () {
				    window.close();
				});
        }
    }
    else {
        this.CustomApp.overlap_check = this.CustomApp.overlap_check == true ? true : false;
        this.dsResult = [];
        if (this.AppType === "DEPTUSER") {
            this.dsSource = new Ext.data.JsonStore({
                url: g_OrgMapServerURL,
                root: 'dataRoot',
                baseParams: { action: 'getMemberListForApp', isOnlyUser: "N" },
                fields: APPDataFields,
                remoteSort: false
            });
        }
        else if (this.AppType === "USER") {
            this.dsSource = new Ext.data.JsonStore({
                url: g_OrgMapServerURL,
                root: 'dataRoot',
                baseParams: { action: 'getMemberListForApp', isOnlyUser: "Y" },
                fields: APPDataFields,
                remoteSort: false
            });
        }
        else {
            this.fadeoutMainLoadMask();
            this.ErrorMessageBox(getResource("WrongAPPTYPE") +
				Ext.util.Format.htmlEncode(data.ErrorMessage) + getResource("AjaxErrorMsg2"), function () {
				    window.close();
				});
        }

        this.InitCustomAppGrid();
        this.dsSource.on('datachanged', this.OnDsSourceDataChanged, this);
        this.dsSource.on('beforeload', function () {
            // DATA가 변경될 때 Presence 정보를 reset 해줍니다.
            GW.NameControl.UnRegisterPresenceAll();
        }, this);
        this.getInitialize(function () {
            this.RenderCustomApp();
            this.InitializeCustomAppDragdrop();
            if (this.OrgMapData) {
                try {
                    for (var idx = 0; idx < this.CustomApp.items.length; idx++) {
                        var name = this.CustomApp.items[idx].name;
                        if (this.dsResult[idx]) this.dsResult[idx].loadData(this.OrgMapData["" + name + ""]);
                    }
                } catch (ex) { }
            }
            this.fadeoutMainLoadMask();
        }, this);
    }
};
Ext.extend(GW.OrgMap.Common.App.Form, GW.OrgMap.Common.App, {
    InitCustomAppGrid: function () {
        // 선택그리드
        this.SelectCheck = new Ext.grid.CheckboxSelectionModel();
        this.SelectColumn = new Ext.grid.ColumnModel([
			this.SelectCheck,
			{ header: getResource("UserRank"), dataIndex: 'RankName', menuDisabled: true, width: 45, renderer: this.RendererWithTooltip },
			{ header: getResource("UserName"), dataIndex: 'DisplayName', menuDisabled: true, width: 195, renderer: this.RendererDisplayName.createDelegate(this) },
			{ header: getResource("UserEmpID"), dataIndex: 'EmpID', menuDisabled: true, width: 55, renderer: this.RendererWithTooltip },
			{ header: getResource("UserJob"), dataIndex: 'JobName', menuDisabled: true, width: 80, renderer: this.RendererWithTooltip, hidden: true }
		]);
        this.SelectGrid = new Ext.grid.GridPanel({
            region: 'center',
            margins: '5 5 0 5',
            ddGroup: 'SelectGridDDGroup',
            enableDragDrop: true,
            enableColumnMove: false,
            ds: this.dsSource,
            cm: this.SelectColumn,
            sm: this.SelectCheck,
            stripeRows: true,
            title: '&nbsp;&nbsp;',
            loadMask: { msg: getResource("WaitMsg") }
        });
        var items = this.CustomApp.items;
        this.ResultCheck = [];
        this.ResultColumn = [];
        this.ResultGrid = [];

        var rowHeight = 1 / items.length;
        for (var idx = 0; idx < items.length; idx++) {
            this.dsResult[idx] = new Ext.data.JsonStore({ fields: APPDataFields });
            this.ResultCheck[idx] = new Ext.grid.CheckboxSelectionModel();
            this.ResultColumn[idx] = new Ext.grid.ColumnModel([
				this.ResultCheck[idx],
				{ header: getResource("UserName"), dataIndex: 'ADDisplayName', menuDisabled: true, width: 195, renderer: this.RendererADDisplayName.createDelegate(this) }
			]);
            var ddGroupName = items[idx].name + "DDGroup";
            var gridTitle = items[idx].title || '&nbsp;&nbsp;';
            this.ResultGrid[idx] = new Ext.grid.GridPanel({
                ddGroup: ddGroupName,
                enableDragDrop: true,
                ds: this.dsResult[idx],
                cm: this.ResultColumn[idx],
                sm: this.ResultCheck[idx],
                stripeRows: true,
                border: false,
                viewConfig: { forceFit: true },
                bbar: ['->', {
                    iconCls: 'add',
                    text: getResource("Add"),
                    handler: this.OnCustomAddHandler.createDelegate(this, [idx])
                }, {
                    iconCls: 'delete',
                    text: getResource("Remove"),
                    handler: this.OnCustomRemoveHandler.createDelegate(this, [idx])
                }, {
                    iconCls: 'cross',
                    text: getResource("RemoveAll"),
                    handler: this.OnCustomRemoveAllHandler.createDelegate(this, [idx])
                }],
                title: gridTitle,
                rowHeight: rowHeight
            });
        } //for
    },

    OnCustomAddHandler: function (index) {
        if (this.ResultGrid[index]) {
            var mask = new Ext.LoadMask(this.ResultGrid[index].getView().el, { msg: getResource("WaitMsg") });
            if (this.SelectCheck.getSelections().length > 0) {
                mask.show();
                if (this.CustomApp.overlap_check == true) {
                    Ext.each(this.SelectCheck.getSelections(), function (record, idx, allItems) {
                        var isExist = false;
                        for (var iResult = 0; iResult < this.dsResult.length; iResult++) {
                            if (record.data.addr == "" && record.data.entryType == 2) {// 사번비교
                                var isFound = this.dsResult[iResult].find('EmpID', record.data.EmpID);
                                if (isFound > -1) {
                                    isExist = true;
                                    break;
                                }
                            } else {// 메일주소로 비교
                                var isFound = this.dsResult[iResult].find('addr', record.data.addr);
                                if (isFound > -1) {
                                    isExist = true;
                                    break;
                                }
                            }
                        }
                        if (isExist == false) {
                            this.dsResult[index].add(record);
                        }
                    }, this);
                }
                else {
                    if (this.dsResult[index].getCount() == 0 && this.dsSource.getCount() == this.SelectCheck.getSelections().length) {
                        this.dsResult[index].data = this.dsSource.data.clone();
                    }
                    else {
                        Ext.each(this.SelectCheck.getSelections(), function (record, idx, allItems) {
                            if (record.data.addr == "" && record.data.entryType == 2) {// 사번비교
                                var foundItem = this.dsResult[index].find('EmpID', record.data.EmpID);
                                if (foundItem == -1) {
                                    this.dsResult[index].add(record);
                                }
                            } else {// 메일주소로 비교
                                var foundItem = this.dsResult[index].find('addr', record.data.addr);
                                if (foundItem == -1) {
                                    this.dsResult[index].add(record);
                                }
                            }
                        }, this);
                    }
                }
                this.dsResult[index].fireEvent("datachanged", this.dsResult[index]);
                mask.hide();
            }
            this.CustomAppAllClearSelection();
        }
    },

    OnCustomRemoveHandler: function (index) {
        if (this.ResultGrid[index]) {
            var mask = new Ext.LoadMask(this.ResultGrid[index].getView().el, { msg: getResource("WaitMsg") });
            if (this.ResultCheck[index].getSelections().length > 0) {
                mask.show();
                if (this.ResultCheck[index].getSelections().length == this.dsResult[index].getCount()) {
                    this.dsResult[index].removeAll();
                }
                else {
                    Ext.each(this.ResultCheck[index].getSelections(), function (record, idx, allItems) {
                        this.dsResult[index].remove(record);
                    }, this);
                }
                this.dsResult[index].fireEvent("datachanged", this.dsResult[index]);
                mask.hide();
            }
            this.CustomAppAllClearSelection();
        }
    },

    OnCustomRemoveAllHandler: function (index) {
        if (this.ResultGrid[index]) {
            var mask = new Ext.LoadMask(this.ResultGrid[index].getView().el, { msg: getResource("WaitMsg") });
            if (this.dsResult[index].getCount() > 0) {
                mask.show();
                this.dsResult[index].removeAll();
                this.dsResult[index].fireEvent("datachanged", this.dsResult[index]);
                mask.hide();
            }
            this.CustomAppAllClearSelection();
        }
    },

    InitializeCustomAppDragdrop: function () {
        var items = this.CustomApp.items;

        this.ResultRemoveDropTarget = [];
        this.ResultAddDropTarget = [];

        for (var i = 0; i < items.length; i++) {
            (function () {
                var index = i;
                var ddGroupName = items[index].name + "DDGroup";
                var mask = new Ext.LoadMask(this.ResultGrid[index].getView().el, { msg: getResource("WaitMsg") });

                this.ResultRemoveDropTarget[index] = new Ext.dd.DropTarget(this.SelectGrid.getView().el.dom.childNodes[0].childNodes[1], {
                    ddGroup: ddGroupName,
                    notifyDrop: (function (ddSource, e, data) {
                        function removeRow(record, index, allItems) {
                            ddSource.grid.store.remove(record);
                        }
                        mask.show();
                        if (ddSource.dragData.selections.length == ddSource.grid.store.getCount()) {
                            ddSource.grid.store.removeAll();
                        } else {
                            Ext.each(ddSource.dragData.selections, removeRow);
                        }
                        mask.hide();
                        this.CustomAppAllClearSelection();
                        return (true);
                    }).createDelegate(this)
                });

                function addRow(record, idx, allItems) {
                    if (record.data.addr == "" && record.data.entryType == 2) {// 사번비교
                        var foundItem = this.dsResult[index].find('EmpID', record.data.EmpID);
                        if (foundItem == -1) {
                            this.dsResult[index].add(record);
                        }
                    } else {// 메일주소로 비교
                        var foundItem = this.dsResult[index].find('addr', record.data.addr);
                        if (foundItem == -1) {
                            this.dsResult[index].add(record);
                        }
                    }
                };

                function addDupCheckRow(record, idx, allItems) {
                    var isExist = false;
                    for (var iResult = 0; iResult < this.dsResult.length; iResult++) {
                        if (record.data.addr == "" && record.data.entryType == 2) {// 사번비교
                            var isFound = this.dsResult[iResult].find('EmpID', record.data.EmpID);
                            if (isFound > -1) {
                                isExist = true;
                                break;
                            }
                        } else {// 메일주소로 비교
                            var isFound = this.dsResult[iResult].find('addr', record.data.addr);
                            if (isFound > -1) {
                                isExist = true;
                                break;
                            }
                        }
                    }
                    if (isExist == false) {
                        this.dsResult[index].add(record);
                    }
                };

                this.ResultAddDropTarget = new Ext.dd.DropTarget(this.ResultGrid[index].getView().el.dom.childNodes[0].childNodes[1], {
                    ddGroup: 'SelectGridDDGroup',
                    notifyDrop: (function (ddSource, e, data) {
                        mask.show();
                        if (this.CustomApp.overlap_check == true) {
                            Ext.each(ddSource.dragData.selections, addDupCheckRow.createDelegate(this));
                        }
                        else {
                            if (ddSource.dragData.selections.length == ddSource.grid.store.getCount()
						    && this.dsResult[index].getCount() == 0) {
                                this.dsResult[index].data = ddSource.grid.store.data.clone();
                            }
                            else {
                                Ext.each(ddSource.dragData.selections, addRow.createDelegate(this));
                            }
                        }
                        mask.hide();
                        this.dsResult[index].fireEvent("datachanged", this.dsResult[index]);
                        this.CustomAppAllClearSelection();
                        return (true);
                    }).createDelegate(this)
                });
            }).createDelegate(this)();
        } //for
    },

    RenderCustomApp: function () {
        var titleBox = this.getHeaderTitleBox();
        var searchBox = this.getEmpNameSearchBox();
        var treeBox = this.getCompanyDeptTree();
        var langCombo = new Ext.ux.LanguageCycleButton();

        // 검색박스
        var clearSearchBox = function () {
            var node = treeBox.getSelectionModel().getSelectedNode();
            if (node) {
                var company = this.getCurrentCompany();
                this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'dept', query: node.id} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                this.SetCoulumVisiable();
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
                    this.SelectGrid.setTitle('[' + strName + '] ' + getResource("SearchResult"));
                    this.SetCoulumVisiable();
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
                this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'dept', query: node.id} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                this.SetCoulumVisiable();
            }
        }, this);

        treeBox.getLoader().on('beforeload', function (treeLoader, node) {
            if (treeLoader.baseParams) {
                var company = this.getCurrentCompany();
                treeLoader.baseParams.companyCode = company.companyCode;
                treeLoader.baseParams.isRelative = company.isRelative;
            }
        }, this);

        this.CompanyCombo.on("change", function (combo, item) {
            if (this.ShowMailGroup == true) this.GroupCombo.clearSelect();
            treeBox.getRootNode().children = null;
            treeBox.getRootNode().reload();
            if (item.isRelative === "N") {
                if (item.companyCode === this.MyCompanyCode) {
                    treeBox.expandPath(this.MyDeptSelectPath);
                    treeBox.selectPath(this.MyDeptSelectPath);
                }
            }
        }, this);

        if (this.ShowMailGroup == true) {
            this.GroupCombo.on("change", function (combo, item) {
                if (!this.isInnerCompany()) return;
                var company = this.getCurrentCompany();
                this.SetCoulumVisiable("group");
                searchBox.onTrigger1Click(true);
                this.dsSource.load({ params: { companyCode: company.companyCode, mode: 'group', query: item.groupTypeCode} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(item.groupTypeName));
            }, this);
        }

        var resultContainer = new Ext.Panel({
            region: 'east',
            layout: 'ux.row',
            margins: '5 5 0 0',
            bodyStyle: 'background:#DFE8F6;',
            width: 240,
            items: this.ResultGrid
        });

        var toolbar = null;
        if (this.SelectCompany == true) {
            //toolbar = ['-', this.CompanyCombo, '-', '->', '-', searchBox, '-', langCombo, '-'];
            //if (this.ShowMailGroup == true) {
            //    toolbar = ['-', this.CompanyCombo, '-', this.GroupCombo, '->', '-', searchBox, '-', langCombo, '-'];
            //}
            // 조직도 툴바 수정. 그룹콤보, 비활성자포함, 언어선택 콤보 숨기기 2017-07-01 장윤호
            toolbar = ['-', this.CompanyCombo, '->', '-', searchBox, '-'];
        }
        else {
            //toolbar = ['->', '-', searchBox, '-', langCombo, '-'];
            //if (this.ShowMailGroup == true) {
            //    toolbar = ['-', this.GroupCombo, '->', '-', searchBox, '-', langCombo, '-'];
            //}
            // 조직도 툴바 수정. 그룹콤보, 비활성자포함, 언어선택 콤보 숨기기 2017-07-01 장윤호
            toolbar = ['->', '-', searchBox, '-'];
        }

        var mainPanel = new Ext.Panel({
            region: 'center',
            layout: 'border',
            border: false,
            bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
            tbar: toolbar,
            items: [treeBox, this.SelectGrid, resultContainer],
            buttons: [{
                text: getResource("OkBtn"),
                handler: this.OnCustomAppOk,
                scope: this
            }, {
                text: getResource("CancelBtn"),
                handler: this.OnCancel,
                scope: this
            }],
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

    OnCustomAppOk: function () {
        if (this.CallBack) {
            var orgmapData = {};
            var items = this.CustomApp.items;
            for (var i = 0; i < this.dsResult.length; i++) {
                var boxData = [];
                if (this.dsResult[i].getCount() > 0) {
                    this.dsResult[i].each(function (store) {
                        boxData[boxData.length] = store.data;
                    });
                }
                orgmapData["" + items[i].name + ""] = boxData;
            }
            if (this.ReturnType == 'JSON') {
                // JSON으로 반환
                var sJSON = Ext.encode(orgmapData);
                sJSON = "(" + sJSON + ")";
                this.CallBack.call(window, sJSON);
            } else if (this.ReturnType == 'XML') {
                // XML로 반환
                var sXML = '<?xml version="1.0"?><person></person>';
                var domXML = null;
                if (window.ActiveXObject) {
                    // IE
                    try {
                        domXML = new ActiveXObject('Microsoft.XMLDOM');
                        domXML.async = false;
                        domXML.loadXML(sXML);
                    }
                    catch (e) {
                        alert("Microsoft.XMLDOM Exception :" + e.message);
                    }
                }
                else {
                    alert(getResource("IEOnlyMSG"));
                }
                try {
                    var rootEl = domXML.documentElement;
                    if (orgmapData && orgmapData instanceof Object) {
                        for (var prop in orgmapData) {
                            var obj = orgmapData[prop];
                            if (obj && obj instanceof Array) {
                                if (obj.length > 0) {
                                    for (var i = 0; i < obj.length; i++) {
                                        var container = domXML.createElement(prop);
                                        var nodeObj = obj[i];
                                        for (var nodeProp in nodeObj) {
                                            var record = domXML.createElement(nodeProp);
                                            var value = domXML.createCDATASection(nodeObj[nodeProp]);
                                            record.appendChild(value);
                                            container.appendChild(record);
                                        }
                                        rootEl.appendChild(container);
                                    }
                                }
                            }
                        }
                    }
                    sXML = domXML.xml;
                }
                catch (e) {
                    alert("Microsoft.XMLDOM Exception :" + e.message);
                }
                this.CallBack.call(window, sXML);
            }
        }
        window.close();
    },

    CustomAppAllClearSelection: function () {
        this.SelectGrid.getSelectionModel().clearSelections();
        Ext.get(this.SelectGrid.getView().getHeaderCell(0).childNodes[0]).removeClass('x-grid3-hd-checker-on');
        for (var i = 0; i < this.ResultGrid.length; i++) {
            this.ResultGrid[i].getSelectionModel().clearSelections();
            Ext.get(this.ResultGrid[i].getView().getHeaderCell(0).childNodes[0]).removeClass('x-grid3-hd-checker-on');
        }
    },

    OnDeptTreeOneSelectOk: function () {
        this.dsResult.removeAll();
        var node = this.deptTree.getSelectionModel().getSelectedNode();
        if (node) {
            var record = [];
            var data = {};
            data.DisplayName = node.text;
            data.ADDisplayName = "";
            data.entryType = 0; // 부서
            data.addr = node.attributes.deptEmail;
            data.AccountId = "";
            data.DeptName = node.text;
            data.DeptCode = node.id;
            data.RankCode = "";
            data.RankName = "";
            data.JobCode = "";
            data.JobName = "";
            data.DutyCode = "";
            data.DutyName = "";
            data.CompanyCode = node.attributes.CompanyCode;
            data.CompanyName = node.attributes.CompanyName;
            data.EmpID = "";
            data.CellPhone = "";
            data.ExtensionNumber = "";
            data.FaxNumber = "";
            data.TeamChiefYN = "";
            data.Kostl = "";
            data.SignID = "";
            data.SendYN = "";
            data.SiteCompanyCode = node.attributes.SiteCompanyCode;
            data.SiteCompanyName = node.attributes.SiteCompanyName;
            data.Culture = node.attributes.Culture;

            record[0] = data;
            this.dsResult.loadData(record);
        }
        return this.OnOk();
    },

    RenderSelectOneDept: function () {
        var titleBox = this.getHeaderTitleBox();
        var langCombo = new Ext.ux.LanguageCycleButton();

        var toolbar = null;
        if (this.SelectCompany == true) {
            //toolbar = ['-', this.CompanyCombo, '-', '->', '-', langCombo, '-'];
            // 조직도 툴바 수정. 그룹콤보, 비활성자포함, 언어선택 콤보 숨기기 2017-07-01 장윤호
            toolbar = ['-', this.CompanyCombo];
        }
        // 조직도 툴바 수정. 그룹콤보, 비활성자포함, 언어선택 콤보 숨기기 2017-07-01 장윤호
        //else {
        //    toolbar = ['->', , '-', langCombo, '-'];
        //}
        this.deptTree = new Ext.tree.TreePanel({
            id: 'company-tree',
            region: 'center',
            margins: '5 5 0 5',
            bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
            rootVisible: false,
            lines: true,
            autoScroll: true,
            loader: new Ext.tree.TreeLoader({
                url: g_OrgMapServerURL,
                baseParams: { action: 'getCompanyDeptTree' },
                requestMethod: 'POST'
            }),
            root: new Ext.tree.AsyncTreeNode({
                text: 'company',
                id: 'company-root',
                expanded: true
            }),
            collapseFirst: false
        });

        this.deptTree.getLoader().on('load', function (treeLoader, node, response) {
            if (this.isInnerCompany()) {
                if (node == this.deptTree.root) {
                    node.expandChildNodes();
                }
            }
            else if (this.deptTree.root.children && this.deptTree.root.children.length == 1) {
                this.deptTree.root.expandChildNodes();
            }
        }, this);

        this.deptTree.getLoader().on('beforeload', function (treeLoader, node) {
            if (treeLoader.baseParams) {
                var company = this.getCurrentCompany();
                treeLoader.baseParams.companyCode = company.companyCode;
                treeLoader.baseParams.isRelative = company.isRelative;
            }
        }, this);

        this.CompanyCombo.on("change", function (combo, item) {
            this.deptTree.getRootNode().children = null;
            this.deptTree.getRootNode().reload();
            if (item.isRelative === "N") {
                if (item.companyCode === this.MyCompanyCode) {
                    this.deptTree.expandPath(this.MyDeptSelectPath);
                    this.deptTree.selectPath(this.MyDeptSelectPath);
                }
            }
        }, this);

        var mainPanel = new Ext.Panel({
            region: 'center',
            layout: 'border',
            border: false,
            bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
            tbar: toolbar,
            items: this.deptTree,
            buttons: [{
                text: getResource("OkBtn"),
                handler: this.OnDeptTreeOneSelectOk,
                scope: this
            }, {
                text: getResource("CancelBtn"),
                handler: this.OnCancel,
                scope: this
            }],
            buttonAlign: 'center'
        });

        var viewport = new Ext.Viewport({
            layout: 'border',
            items: [titleBox, mainPanel]
        });
        viewport.doLayout();

        mainPanel.footer.applyStyles('background: #FFFFFF none repeat scroll 0 0;');

        this.deptTree.expandPath(this.MyDeptSelectPath);
        this.deptTree.selectPath(this.MyDeptSelectPath);
    },

    Render: function () {
        var titleBox = this.getHeaderTitleBox();
        var searchBox = this.getEmpNameSearchBox();
        var treeBox = this.getCompanyDeptTree();
        var langCombo = new Ext.ux.LanguageCycleButton();
        var chkBox = this.getDeactiveCheckBox();

        // 검색박스
        var clearSearchBox = function () {
            var node = treeBox.getSelectionModel().getSelectedNode();
            if (node) {
                var company = this.getCurrentCompany();
                var strChk = Ext.getCmp('deactive').checked ? "Y" : "";
                this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'dept', query: node.id, isDeactive: strChk} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                this.SetCoulumVisiable();
            }
            //searchBox.fireEvent('blur', searchBox);
            searchBox.focus(true, 300);
        };
        searchBox.ClearClick = clearSearchBox.createDelegate(this);
        //chkBox.onClick = clearSearchBox.createDelegate(this);
        chkBox.onClick = (function (a, b, c, d) {
            if (b.tagName.toUpperCase() == "LABEL") return;
            var node = treeBox.getSelectionModel().getSelectedNode();
            if (node) {
                var company = this.getCurrentCompany();
                Ext.getCmp('deactive').toggleValue()
                var strChk = Ext.getCmp('deactive').checked ? "Y" : "";
                this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'dept', query: node.id, isDeactive: strChk} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                this.SetCoulumVisiable();
            }
        }).createDelegate(this);

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
                    var strChk = Ext.getCmp('deactive').checked ? "Y" : "";
                    this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'member', query: strName, isDeactive: strChk} });
                    this.SelectGrid.setTitle('[' + strName + '] ' + getResource("SearchResult"));
                    this.SetCoulumVisiable();
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
                var strChk = Ext.getCmp('deactive').checked ? "Y" : "";
                this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'dept', query: node.id, isDeactive: strChk} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                this.SetCoulumVisiable();
            }
        }, this);

        treeBox.getLoader().on('beforeload', function (treeLoader, node) {
            if (treeLoader.baseParams) {
                var company = this.getCurrentCompany();
                treeLoader.baseParams.companyCode = company.companyCode;
                treeLoader.baseParams.isRelative = company.isRelative;
            }
        }, this);

        this.CompanyCombo.on("change", function (combo, item) {
            if (this.ShowMailGroup == true) this.GroupCombo.clearSelect();
            treeBox.getRootNode().children = null;
            treeBox.getRootNode().reload();
            if (item.isRelative === "N") {
                if (item.companyCode === this.MyCompanyCode) {
                    treeBox.expandPath(this.MyDeptSelectPath);
                    treeBox.selectPath(this.MyDeptSelectPath);
                }
                Ext.Ajax.request({
                    url: g_OrgMapServerURL,
                    params: { action: 'getCompanyGroup', companyCode: item.companyCode },
                    method: 'POST',
                    success: function (response, option) {
                        /*
                        var data = Ext.util.JSON.decode(response.responseText);
                        if (data) {
                            if (data.result == false) {
                                this.FadeOutMainLoadMask();
                                this.ErrorMessageBox(getResource("AjaxErrorMsg1") +
									data.ErrorMessage + getResource("AjaxErrorMsg2"), function () {
									    window.close();
									});
                                return;
                            }

                            //그룹선택
                            var groupItems = [];

                            groupItems[groupItems.length] = { text: getResource('GroupIndividual'), menu: { items: data.AddGroup} };

                            for (var i = 0; i < data.Group.length; i++) {
                                groupItems[groupItems.length] = data.Group[i];
                            }

                            this.GroupCombo.items = groupItems;
                            this.GroupCombo.initComponent();
                        }
                        */
                    },
                    failure: function (response, option) {
                        this.FadeOutMainLoadMask();
                        this.ErrorMessageBox(getResource("AjaxFailMsg"), function () {
                            window.close();
                        });
                    },
                    scope: this,
                    async: false  //동작안함?   
                });
            }
        }, this);

        if (this.ShowMailGroup == true) {
            this.GroupCombo.on("change", function (combo, item) {
                if (!this.isInnerCompany()) return;
                var company = this.getCurrentCompany();

                this.SetCoulumVisiable("groupmember");
                searchBox.onTrigger1Click(true);
                this.dsSource.load({ params: { companyCode: company.companyCode, mode: 'group', query: item.groupCode, type: 'member'} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(item.groupName));
            }, this);
        }

        var btns = null;
        var renderItems = null;
        if (this.OnlyOneSelect) {
            btns = [{
                text: getResource("OkBtn"),
                handler: this.OnOneSelectOk,
                scope: this
            }, {
                text: getResource("CancelBtn"),
                handler: this.OnCancel,
                scope: this
            }];
            renderItems = [treeBox, this.SelectGrid];
        }
        else {
            btns = [{
                text: getResource("OkBtn"),
                handler: this.OnOk,
                scope: this
            }, {
                text: getResource("CancelBtn"),
                handler: this.OnCancel,
                scope: this
            }];
            renderItems = [treeBox, this.SelectGrid, this.ResultGrid];
        }
        var toolbar = null;
        if (this.SelectCompany == true) {
            //toolbar = ['-', this.CompanyCombo, '-', '->', '-', chkBox, '-', searchBox, '-', langCombo, '-'];
            //if (this.ShowMailGroup == true) {
            //    toolbar = ['-', this.CompanyCombo, '-', this.GroupCombo, '->', '-', chkBox, '-', searchBox, '-', langCombo, '-'];
            //}
            // 조직도 툴바 수정. 그룹콤보, 비활성자포함, 언어선택 콤보 숨기기 2017-07-01 장윤호
            toolbar = ['-', this.CompanyCombo, '->', '-', searchBox, '-'];
        }
        else {
            //toolbar = ['->', '-', searchBox, '-', langCombo, '-'];
            //if (this.ShowMailGroup == true) {
            //    toolbar = ['-', this.GroupCombo, '->', '-', searchBox, '-', langCombo, '-'];
            //}
            // 조직도 툴바 수정. 그룹콤보, 비활성자포함, 언어선택 콤보 숨기기 2017-07-01 장윤호
            toolbar = ['->', '-', searchBox, '-'];
        }

        var mainPanel = new Ext.Panel({
            region: 'center',
            layout: 'border',
            border: false,
            bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
            tbar: toolbar,
            items: renderItems,
            buttons: btns,
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

    RenderSelectDept: function () {
        var titleBox = this.getHeaderTitleBox();
        var searchBox = new Ext.app.SearchField({
            emptyText: getResource("SearchDept"),
            minLength: 2,
            maxLength: 150,
            width: 195
        });
        var treeBox = this.getCompanyDeptTree();
        var langCombo = new Ext.ux.LanguageCycleButton();

        // 검색박스
        var clearSearchBox = function () {
            var node = treeBox.getSelectionModel().getSelectedNode();
            if (node) {
                var company = this.getCurrentCompany();
                this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'onlyDept', query: node.id} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                if (this.ShowMailGroup == true) {
                    this.GroupCombo.clearSelect();
                    this.SelectColumn.setColumnHeader(1, getResource("UserDept"));
                }
            }
            //searchBox.fireEvent('blur', searchBox);
            searchBox.focus(true, 300);
        };
        searchBox.ClearClick = clearSearchBox.createDelegate(this);
        var doSearchBox = function () {
            var strName = searchBox.getValue();
            if (strName != '') {
                if (strName.length >= 2 && strName.length < 150) {
                    var special = /.*[$\\@\\\#%\^\&\*\(\)\[\]\+\_\;\'\{\}\`\\\~\<\>\=\|\.\,\:\?\/\"\!\-].*/;
                    if (strName.search(special) == 0) {
                        searchBox.setValue('');
                        this.WarningMessageBox(getResource("NoUseSpecialMsg"), function () {
                            searchBox.focus();
                        });
                        return false;
                    }
                    var company = this.getCurrentCompany();
                    this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'searchDept', query: strName} });
                    this.SelectGrid.setTitle('[' + strName + '] ' + getResource("SearchResult"));
                    if (this.ShowMailGroup == true) {
                        this.GroupCombo.clearSelect();
                        this.SelectColumn.setColumnHeader(1, getResource("UserDept"));
                    }
                    return true;
                } else {
                    searchBox.setValue('');
                    searchBox.focus(true, 300);
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
                this.dsSource.load({ params: { companyCode: company.companyCode, isRelative: company.isRelative, mode: 'onlyDept', query: node.id} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(node.text));
                if (this.ShowMailGroup == true) {
                    this.GroupCombo.clearSelect();
                    this.SelectColumn.setColumnHeader(1, getResource("UserDept"));
                }
            }
        }, this);

        treeBox.getLoader().on('beforeload', function (treeLoader, node) {
            if (treeLoader.baseParams) {
                var company = this.getCurrentCompany();
                treeLoader.baseParams.companyCode = company.companyCode;
                treeLoader.baseParams.isRelative = company.isRelative;
            }
        }, this);

        this.CompanyCombo.on("change", function (combo, item) {
            if (this.ShowMailGroup == true) this.GroupCombo.clearSelect();
            treeBox.getRootNode().children = null;
            treeBox.getRootNode().reload();
            if (item.isRelative === "N") {
                if (item.companyCode === this.MyCompanyCode) {
                    treeBox.expandPath(this.MyDeptSelectPath);
                    treeBox.selectPath(this.MyDeptSelectPath);
                }
            }
        }, this);

        if (this.ShowMailGroup == true) {
            this.GroupCombo.on("change", function (combo, item) {
                if (!this.isInnerCompany()) return;
                var company = this.getCurrentCompany();
                this.SelectColumn.setColumnHeader(1, getResource("MailGroup"));
                searchBox.onTrigger1Click(true);
                this.dsSource.load({ params: { companyCode: company.companyCode, mode: 'group', query: item.groupTypeCode} });
                this.SelectGrid.setTitle(Ext.util.Format.htmlEncode(item.groupTypeName));
            }, this);
        }

        var btns = null;
        var renderItems = null;
        if (this.OnlyOneSelect) {
            btns = [{
                text: getResource("OkBtn"),
                handler: this.OnOneSelectOk,
                scope: this
            }, {
                text: getResource("CancelBtn"),
                handler: this.OnCancel,
                scope: this
            }];
            renderItems = [treeBox, this.SelectGrid];
        }
        else {
            btns = [{
                text: getResource("OkBtn"),
                handler: this.OnOk,
                scope: this
            }, {
                text: getResource("CancelBtn"),
                handler: this.OnCancel,
                scope: this
            }];
            renderItems = [treeBox, this.SelectGrid, this.ResultGrid];
        }
        var toolbar = null;
        if (this.SelectCompany == true) {
            //toolbar = ['-', this.CompanyCombo, '-', '->', '-', searchBox, '-', langCombo, '-'];
            //if (this.ShowMailGroup == true) {
            //    toolbar = ['-', this.CompanyCombo, '->', '-', searchBox, '-', langCombo, '-'];
            //    //toolbar = ['-', this.CompanyCombo, '-', this.GroupCombo, '->', '-', searchBox, '-', langCombo, '-'];
            //}
            // 조직도 툴바 수정. 그룹콤보, 비활성자포함, 언어선택 콤보 숨기기 2017-07-01 장윤호
            toolbar = ['-', this.CompanyCombo, '->', '-', searchBox, '-'];
        }
        else {
            //toolbar = ['->', '-', searchBox, '-', langCombo, '-'];
            //if (this.ShowMailGroup == true) {
            //    toolbar = ['-', this.GroupCombo, '->', '-', searchBox, '-', langCombo, '-'];
            //}
            // 조직도 툴바 수정. 그룹콤보, 비활성자포함, 언어선택 콤보 숨기기 2017-07-01 장윤호
            toolbar = ['->', '-', searchBox, '-'];
        }

        var mainPanel = new Ext.Panel({
            region: 'center',
            layout: 'border',
            border: false,
            bodyStyle: 'background: #FFFFFF none repeat scroll 0 0;',
            tbar: toolbar,
            items: renderItems,
            buttons: btns,
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
    }
});