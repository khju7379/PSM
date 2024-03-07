/**
* OrgMap.Common.js
* 공통으로 쓸 컴포넌트 정의
*/

Ext.BLANK_IMAGE_URL = 'common/ext/resources/images/default/s.gif';
// 네임스페이스
Ext.namespace('GW.OrgMap');

// ################# 전역 변수, 함수 #################
// 서버 Ajax요청시
var g_OrgMapServerURL = 'OrgMapServer.aspx';

// 다국어처리
function getResource(resourceName, _langCode) {
    var lang = _langCode || g_langCode;
    var sName = resourceName + "_" + lang;
    // typeof GW.OrgMap.Resource[sName] == "string" && GW.OrgMap.Resource[sName] === ""
    if (typeof GW.OrgMap.Resource[sName] != "undefined") {
        return GW.OrgMap.Resource[sName];
    } else {
        //return "미정의리소스";
        return "undefined resource";
    }
};
// #################################################

//조직도에 공통적으로 들어가는 Component를 정의
GW.OrgMap.Common = function () {
    // 다국어 처리를 위한 Global Ajax Parameter 정의
    Ext.Ajax.extraParams = { 'langCode': g_langCode };
    Ext.Ajax.timeout = 60000;

    Ext.QuickTips.init();
    Ext.apply(Ext.QuickTips.getQuickTip(), {
        //trackMouse: true,
        showDelay: 700,
        dismissDelay: 0
    });
    this.OrgChartType = "";
    this.OrgMapTitle = getResource("OrgMapTitle");
    this.NoShowRelativeCompany = false;
};

GW.OrgMap.Common.prototype = {

    getInitialize: function (callback, scope) {
        Ext.Ajax.request({
            url: g_OrgMapServerURL,
            params: { action: 'getInitialize', OrgChartType: this.OrgChartType },
            method: 'POST',
            success: function (response, option) {
                var data = Ext.util.JSON.decode(response.responseText);
                if (data) {
                    if (data.result == false) {
                        this.fadeoutMainLoadMask();
                        this.ErrorMessageBox(getResource("AjaxErrorMsg1") +
							Ext.util.Format.htmlEncode(data.ErrorMessage) + getResource("AjaxErrorMsg2"), function () {
							    window.close();
							});
                        return;
                    }
                    this.commonData = data;
                    this.MyCompanyCode = data.MyCompanyCode;
                    this.MyDeptSelectPath = '/company-root' + data.MyDeptSelectPath;
                    this.MyEmail = data.UserEmail;

                    // 사용자 메일 그룹 관리 권한
                    this.CMGAdmin = data.CMGAdmin;

                    //회사선택
                    var companyItems = [];
                    var mycompany = null;
                    for (var i = 0; i < data.InnerCompany.length; i++) {
                        companyItems[companyItems.length] = data.InnerCompany[i];
                        if (data.InnerCompany[i].checked) {
                            mycompany = data.InnerCompany[i];
                        }
                    }

                    //                    if (this.NoShowRelativeCompany == false) {
                    //                        //companyItems[companyItems.length] = '<b class="menu-title"><span class="menu-title-text">' + getResource("SKRelative") + '</span></b>';
                    //                        //for(var i=0; i<data.RelativeCompany.length; i++){
                    //                        //	companyItems[companyItems.length] = data.RelativeCompany[i];
                    //                        //}
                    //                        companyItems[companyItems.length] = { text: getResource("SKRelative"), menu: { items: data.RelativeCompany} };
                    //                    }

                    this.CompanyCombo = new GW.OrgMap.ComboMenuButton({
                        items: companyItems
                    });
                    this.CompanyCombo.activeItem = mycompany;

                    if (this.OrgChartType == "MAIL" || this.OrgChartType == "APP") {
                        // 그룹선택
                        var groupItems = [];
                        groupItems[groupItems.length] = { text: getResource('GroupIndividual'), menu: { items: data.AddGroup} };
                        if (data.GroupType != null) {
                            for (var i = 0; i < data.GroupType.length; i++) {
                                groupItems[groupItems.length] = data.GroupType[i];
                            }
                        }
                        // 사용자 메일그룹을 추가한다.
                        //                        groupItems[groupItems.length] = {
                        //                            groupTypeCode: "TYPECMG",
                        //                            groupTypeName: getResource("UserCustomGroup"),
                        //                            text: getResource("UserCustomGroup")
                        //                        };
                        this.GroupCombo = new GW.OrgMap.ComboMenuButton({
                            emptyText: getResource("GroupCombo"),
                            items: groupItems
                        });

                        //                        if (this.OrgChartType == "MAIL") {
                        //                            // 연락처
                        //                            this.IsExistTeamRoom = false;
                        //                            if (data.MyAddressBookGroup && data.MyAddressBookGroup.length > 0) {
                        //                                this.IsExistTeamRoom = true;
                        //                                var contactItems = [];
                        //                                contactItems[0] = { menuID: 'OC', text: getResource("AddressBook"), checked: false };
                        //                                contactItems[1] = { text: getResource("AddressBookGroup"), menu: { items: data.MyAddressBookGroup} };
                        //                                //contactItems[2] = { text: getResource("TeamContacts"), menu: { items: data.MyTeamRoom} };
                        //                                this.ContactMenu = new GW.OrgMap.ComboMenuButton({
                        //                                    emptyText: getResource("ContactMenu"),
                        //                                    items: contactItems
                        //                                });
                        //                            } else {
                        //                                // 개인주소록
                        //                                this.ContactMenu = {
                        //                                    tooltip: { title: getResource("AddressBook"), text: getResource("AddressBookTip") },
                        //                                    iconCls: 'contact',
                        //                                    text: getResource("AddressBook"),
                        //                                    handler: this.OnPersonalContacts,
                        //                                    scope: this
                        //                                };
                        //                            }
                        //                        }
                        //                        else if (this.OrgChartType == "APP") {
                        //                            
                        //                        }
                    }
                    if (callback) {
                        scope = scope || window;
                        callback.call(scope);
                    }
                }
            },
            failure: function (response, option) {
                this.fadeoutMainLoadMask();
                //debugger;
                this.ErrorMessageBox(getResource("AjaxFailMsg"), function () {
                    window.close();
                });
            },
            scope: this,
            async: false  //동작안함?   
        });
    },

    getCurrentCompany: function () {
        if (this.CompanyCombo) {
            return this.CompanyCombo.getActiveItem();
        } else {
            //alert("회사메뉴 초기화 안됬음");
            alert(getResource("CompanyGetErrorMsg"));
        }
    },

    isInnerCompany: function () {
        if (this.CompanyCombo) {
            return this.CompanyCombo.getActiveItem().isRelative === "N";
        } else {
            return true;
        }
    },
    // 비활성자 체크박스
    getDeactiveCheckBox: function () {
        var checkBox = new Ext.form.Checkbox ({
            xtype: 'checkbox',
            //name: 'deactive',
            //itemId: 'deactive',
            id:'deactive',
            boxLabel: getResource('Deactive'),
            inputValue: 'Y'
        });
        return checkBox;
    },

    // 성명/사번 검색
    getEmpNameSearchBox: function (width) {
        var width = width || 170;
        var searchBox = new Ext.app.SearchField({
            emptyText: getResource("SearchBox"),
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
    getCompanyDeptTree: function (width) {
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
        return tree;
    },

    // 타이틀바
    getHeaderTitleBox: function (text) {
        var strTitle = text || this.OrgMapTitle;
        var body = Ext.getBody();
        var header = document.createElement('div');
        var title = document.createElement('h1');
        header.id = 'header';
        title.innerHTML = Ext.util.Format.htmlEncode(strTitle);
        header.appendChild(title);
        body.appendChild(header);

        var box = new Ext.BoxComponent({
            region: 'north',
            applyTo: 'header',
            height: 30
        });

        return box;
    },

    RendererWithTooltip: function (value, meta, record, rowIndex, colIndex, store) {
        if (typeof value == "string" && value.length > 0)
            meta.attr = meta.attr + ' ext:qtip="' + Ext.util.Format.htmlEncode(value) + '" ';

        return value;
    },

    RenderIcon: function (value, meta, record, rowIndex, colIndex, store) {
        if (typeof value == "string" && value.length > 0) {
            return "<img src='/Resources/Images/Icon/" + value + ".png' alt='' />";
        }
        return value;
    },

    // 이메일인지 체크해봅니다.
    ValidateEmail: function (value) {
        var email = /^([\w]+)(.[\w]+)*@([\w-]+\.){1,5}([A-Za-z]){2,4}$/;

        // truefree 2009-05-04
        // 개인 연락처 관련 LegacyExchangeDN도 pass 시킴
        var email2 = /^\/o=(.)*sk[0-9]{5}$/;
        var result = false;

        if (!email.test(value)) {
            result = email2.test(value);
        } else {
            result = true;
        }

        return result;
    },

    fadeoutMainLoadMask: function () {
        if (Ext.get('loading')) {
            setTimeout(function () {
                Ext.get('loading').remove();
                Ext.get('loading-mask').fadeOut({ remove: true });
            }, 250);
        } else {
            debugger;
        }
    },

    ErrorMessageBox: function (text, callback) {
        if (callback) {
            Ext.MessageBox.show({
                title: getResource("Error"),
                msg: text,
                fn: callback,
                scope: this,
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.ERROR
            });

        } else {
            Ext.MessageBox.show({
                title: getResource("Error"),
                msg: text,
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.ERROR
            });
        }
    },

    InfoMessageBox: function (text, callback) {
        if (callback) {
            Ext.MessageBox.show({
                title: getResource("Info"),
                msg: text,
                fn: callback,
                scope: this,
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });
        } else {
            Ext.MessageBox.show({
                title: getResource("Info"),
                msg: text,
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.INFO
            });
        }
    },

    WarningMessageBox: function (text, callback) {
        if (callback) {
            Ext.MessageBox.show({
                title: getResource("Warning"),
                msg: text,
                fn: callback,
                scope: this,
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.WARNING
            });
        } else {
            Ext.MessageBox.show({
                title: getResource("Warning"),
                msg: text,
                buttons: Ext.MessageBox.OK,
                icon: Ext.MessageBox.WARNING
            });
        }
    }
};

// 회사선택이나 그룹선택을 위한 Custom 버튼 메뉴
GW.OrgMap.ComboMenuButton = Ext.extend(Ext.Button, {

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
        GW.OrgMap.ComboMenuButton.superclass.initComponent.call(this);
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
    onClick: function (e) {
        var t;
        if (t = this.findTargetItem(e)) {
            if (t.menu) {
                t.expandMenu();
            } else {
                t.onClick(e);
                this.fireEvent("click", this, t, e);
            }
        }
    }
});

// SK에너지 다국어처리를 위한 버튼 2009-01-14 홍정화
Ext.ux.LanguageCycleButton = Ext.extend(Ext.CycleButton, {
    languageItems: [
		{ language: 'ko', text: '한글', iconCls: 'sk-korea' },
		{ language: 'en', text: 'English', iconCls: 'sk-english' },
		{ language: 'cn', text: '中文', iconCls: 'sk-china' },
        { language: 'es', text: 'Español', iconCls: 'sk-spanish' }
	],

    initComponent: function () {
        Ext.apply(this, {
            showText: true,
            prependText: '&nbsp;',
            items: this.languageItems
        });
        if (g_langCode) {
            var selectedLanguage = g_langCode;
            if (selectedLanguage) {
                for (var i = 0; i < this.items.length; i++) {
                    if (this.items[i].language == selectedLanguage) {
                        this.items[i].checked = true;
                        break;
                    }
                }
            }
        } else {
            // 디폴트 한국어
            this.items[0].checked = true;
        }
        Ext.ux.LanguageCycleButton.superclass.initComponent.apply(this, arguments);
    },

    changeHandler: function (o, i) {
        var params = Ext.urlDecode(window.location.search.substring(1), true);
        params.langCode = i.language;
        window.location.search = Ext.urlEncode(params);
    }
});