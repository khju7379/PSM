Ext.override(Ext.menu.Menu, {
    showAt : function(xy, parentMenu, /* private: */_e){
        this.parentMenu = parentMenu;
        if(!this.el){
            this.render();
        }
        if(_e !== false){
            this.fireEvent("beforeshow", this);
            xy = this.el.adjustForConstraints(xy);
        }
        this.el.setXY(xy);
        
        // get max height from body height minus y cordinate from this.el
        var maxHeight = Ext.getBody().getHeight() - xy[1];
        // store orig element height
        if (!this.el.origHeight) {
            this.el.origHeight = this.el.getHeight();
        }
        // if orig height bigger than max height
        if (this.el.origHeight > maxHeight) {
            // set element with max height and apply scrollbar
            this.el.setHeight(maxHeight);
            this.el.applyStyles('overflow-y: auto;');
        } else {
            // set the orig height
            this.el.setHeight(this.el.origHeight);
        }

        this.el.show();
        this.hidden = false;
        this.focus();
        this.fireEvent("show", this);
    }
}); 

/**
 * Makes a ComboBox more closely mimic an HTML SELECT.  Supports clicking and dragging
 * through the list, with item selection occurring when the mouse button is released.
 * When used will automatically set {@link #editable} to false and call {@link Ext.Element#unselectable}
 * on inner elements.  Re-enabling editable after calling this will NOT work.
 *
 * @author Corey Gilmore
 * http://extjs.com/forum/showthread.php?t=6392
 *
 * @history 2007-07-08 jvs
 * Slight mods for Ext 2.0
 */
Ext.ux.SelectBox = function(config){                                            
	this.searchResetDelay = 1000;
	config = config || {};
	config = Ext.apply(config || {}, {
		editable: false,
		forceSelection: true,
		rowHeight: false,
		lastSearchTerm: false,
        triggerAction: 'all',
        mode: 'local'
    });

	Ext.ux.SelectBox.superclass.constructor.apply(this, arguments);

	this.lastSelectedIndex = this.selectedIndex || 0;
};

Ext.extend(Ext.ux.SelectBox, Ext.form.ComboBox, {
    lazyInit: false,
	initEvents : function(){
		Ext.ux.SelectBox.superclass.initEvents.apply(this, arguments);
		// you need to use keypress to capture upper/lower case and shift+key, but it doesn't work in IE
		this.el.on('keydown', this.keySearch, this, true);
		this.cshTask = new Ext.util.DelayedTask(this.clearSearchHistory, this);
	},

	keySearch : function(e, target, options) {
		var raw = e.getKey();
		var key = String.fromCharCode(raw);
		var startIndex = 0;

		if( !this.store.getCount() ) {
			return;
		}

		switch(raw) {
			case Ext.EventObject.HOME:
				e.stopEvent();
				this.selectFirst();
				return;

			case Ext.EventObject.END:
				e.stopEvent();
				this.selectLast();
				return;

			case Ext.EventObject.PAGEDOWN:
				this.selectNextPage();
				e.stopEvent();
				return;

			case Ext.EventObject.PAGEUP:
				this.selectPrevPage();
				e.stopEvent();
				return;
		}

		// skip special keys other than the shift key
		if( (e.hasModifier() && !e.shiftKey) || e.isNavKeyPress() || e.isSpecialKey() ) {
			return;
		}
		if( this.lastSearchTerm == key ) {
			startIndex = this.lastSelectedIndex;
		}
		this.search(this.displayField, key, startIndex);
		this.cshTask.delay(this.searchResetDelay);
	},

	onRender : function(ct, position) {
		this.store.on('load', this.calcRowsPerPage, this);
		Ext.ux.SelectBox.superclass.onRender.apply(this, arguments);
		if( this.mode == 'local' ) {
			this.calcRowsPerPage();
		}
	},

//	onSelect : function(record, index, skipCollapse){
//		if(this.fireEvent('beforeselect', this, record, index) !== false){
//			this.setValue(record.data[this.valueField || this.displayField]);
//			if( !skipCollapse ) {
//				this.collapse();
//			}
//			this.lastSelectedIndex = index + 1;
//			this.fireEvent('select', this, record, index);
//		}
//	},
	onSelect : function(record, index, skipCollapse){

		// THIS ISEXPANDED CHECK IS NEW, THE REST IS UNCHANGED
		// The authors implementation of this causes this method to be called twice,
		// once while expanded, and again after closed.
		// We only want this called once, so we check for expanded.
		if (this.isExpanded()) {

			if(this.fireEvent('beforeselect', this, record, index) !== false){
				this.setValue(record.data[this.valueField || this.displayField]);
				if( !skipCollapse ) {
					this.collapse();
				}
				this.lastSelectedIndex = index + 1;
				this.fireEvent('select', this, record, index);
			}
		}
	},

	render : function(ct) {
		Ext.ux.SelectBox.superclass.render.apply(this, arguments);
		if( Ext.isSafari ) {
			this.el.swallowEvent('mousedown', true);
		}
		this.el.unselectable();
		this.innerList.unselectable();
		this.trigger.unselectable();
		this.innerList.on('mouseup', function(e, target, options) {
			if( target.id && target.id == this.innerList.id ) {
				return;
			}
			this.onViewClick();
		}, this);

		this.innerList.on('mouseover', function(e, target, options) {
			if( target.id && target.id == this.innerList.id ) {
				return;
			}
			this.lastSelectedIndex = this.view.getSelectedIndexes()[0] + 1;
			this.cshTask.delay(this.searchResetDelay);
		}, this);

		this.trigger.un('click', this.onTriggerClick, this);
		this.trigger.on('mousedown', function(e, target, options) {
			e.preventDefault();
			this.onTriggerClick();
		}, this);

		this.on('collapse', function(e, target, options) {
			Ext.getDoc().un('mouseup', this.collapseIf, this);
		}, this, true);

		this.on('expand', function(e, target, options) {
			Ext.getDoc().on('mouseup', this.collapseIf, this);
		}, this, true);
	},

	clearSearchHistory : function() {
		this.lastSelectedIndex = 0;
		this.lastSearchTerm = false;
	},

	selectFirst : function() {
		this.focusAndSelect(this.store.data.first());
	},

	selectLast : function() {
		this.focusAndSelect(this.store.data.last());
	},

	selectPrevPage : function() {
		if( !this.rowHeight ) {
			return;
		}
		var index = Math.max(this.selectedIndex-this.rowsPerPage, 0);
		this.focusAndSelect(this.store.getAt(index));
	},

	selectNextPage : function() {
		if( !this.rowHeight ) {
			return;
		}
		var index = Math.min(this.selectedIndex+this.rowsPerPage, this.store.getCount() - 1);
		this.focusAndSelect(this.store.getAt(index));
	},

	search : function(field, value, startIndex) {
		field = field || this.displayField;
		this.lastSearchTerm = value;
		var index = this.store.find.apply(this.store, arguments);
		if( index !== -1 ) {
			this.focusAndSelect(index);
		}
	},

//	focusAndSelect : function(record) {
//		var index = typeof record === 'number' ? record : this.store.indexOf(record);
//		this.select(index, this.isExpanded());
//		this.onSelect(this.store.getAt(record), index, this.isExpanded());
//	},
    focusAndSelect : function(record) {
        var index = typeof record === 'number' ? record : this.store.indexOf(record);
        this.select(index, this.isExpanded());
        // => bug: this.store.getAt(record) returns undefined, because record is not always numeric
        // => fixed: this.store.getAt(index) returns a record
        this.onSelect(this.store.getAt(index), index, this.isExpanded());
    },

	calcRowsPerPage : function() {
		if( this.store.getCount() ) {
			this.rowHeight = Ext.fly(this.view.getNode(0)).getHeight();
			this.rowsPerPage = this.maxHeight / this.rowHeight;
		} else {
			this.rowHeight = false;
		}
	}

});

Ext.app.TriggerField = Ext.extend(Ext.form.TextField, {


    defaultAutoCreate: { tag: "input", type: "text", size: "16", autocomplete: "off" },

    hideTrigger: false,


    autoSize: Ext.emptyFn,
    monitorTab: true,
    deferHeight: true,
    mimicing: false,

    onResize: function (w, h) {
        Ext.form.TriggerField.superclass.onResize.call(this, w, h);
        if (typeof w == 'number') {
            this.el.setWidth(this.adjustWidth('input', w - this.trigger.getWidth()));
        }
        this.wrap.setWidth(this.el.getWidth() + this.trigger.getWidth());
    },

    adjustSize: Ext.BoxComponent.prototype.adjustSize,

    getResizeEl: function () {
        return this.wrap;
    },

    getPositionEl: function () {
        return this.wrap;
    },

    alignErrorIcon: function () {
        if (this.wrap) {
            this.errorIcon.alignTo(this.wrap, 'tl-tr', [2, 0]);
        }
    },

    onRender: function (ct, position) {
        Ext.form.TriggerField.superclass.onRender.call(this, ct, position);
        this.wrap = this.el.wrap({ cls: "x-form-field-wrap" });
        this.trigger = this.wrap.createChild(this.triggerConfig ||
                { tag: "img", src: Ext.BLANK_IMAGE_URL, cls: "x-form-trigger " + this.triggerClass });
        if (this.hideTrigger) {
            this.trigger.setDisplayed(false);
        }
        this.initTrigger();
        if (!this.width) {
            this.wrap.setWidth(this.el.getWidth() + this.trigger.getWidth());
        }
    },

    afterRender: function () {
        Ext.form.TriggerField.superclass.afterRender.call(this);
        var y; var y1;
        if (Ext.isIE && (y1 = this.el.getY() + this.el.getHeight()) != (y = this.trigger.getTop() + this.trigger.getHeight())) {
            this.el.position();
            this.el.setY(y - this.el.getHeight());
        }
    },

    initTrigger: function () {
        this.trigger.on("click", this.onTriggerClick, this, { preventDefault: true });
        this.trigger.addClassOnOver('x-form-trigger-over');
        this.trigger.addClassOnClick('x-form-trigger-click');
    },

    onDestroy: function () {
        if (this.trigger) {
            this.trigger.removeAllListeners();
            this.trigger.remove();
        }
        if (this.wrap) {
            this.wrap.remove();
        }
        Ext.form.TriggerField.superclass.onDestroy.call(this);
    },

    onFocus: function () {
        Ext.form.TriggerField.superclass.onFocus.call(this);
        if (!this.mimicing) {
            this.wrap.addClass('x-trigger-wrap-focus');
            this.mimicing = true;
            Ext.get(Ext.isIE ? document.body : document).on("mousedown", this.mimicBlur, this, { delay: 10 });
            if (this.monitorTab) {
                this.el.on("keydown", this.checkTab, this);
            }
        }
    },

    checkTab: function (e) {
        if (e.getKey() == e.TAB) {
            this.triggerBlur();
        }
    },

    onBlur: function () {
    },

    mimicBlur: function (e) {
        if (!this.wrap.contains(e.target) && this.validateBlur(e)) {
            this.triggerBlur();
        }
    },

    triggerBlur: function () {
        this.mimicing = false;
        Ext.get(Ext.isIE ? document.body : document).un("mousedown", this.mimicBlur, this);
        if (this.monitorTab) {
            this.el.un("keydown", this.checkTab, this);
        }
        this.beforeBlur();
        this.wrap.removeClass('x-trigger-wrap-focus');
        Ext.form.TriggerField.superclass.onBlur.call(this);
    },

    beforeBlur: Ext.emptyFn,

    validateBlur: function (e) {
        return true;
    },

    onDisable: function () {
        Ext.form.TriggerField.superclass.onDisable.call(this);
        if (this.wrap) {
            this.wrap.addClass(this.disabledClass);
            this.el.removeClass(this.disabledClass);
        }
    },

    onEnable: function () {
        Ext.form.TriggerField.superclass.onEnable.call(this);
        if (this.wrap) {
            this.wrap.removeClass(this.disabledClass);
        }
    },

    onShow: function () {
        if (this.wrap) {
            this.wrap.dom.style.display = '';
            this.wrap.dom.style.visibility = 'visible';
        }
    },

    onHide: function () {
        this.wrap.dom.style.display = 'none';
    },


    onTriggerClick: Ext.emptyFn




});

Ext.app.TwinTriggerField = Ext.extend(Ext.app.TriggerField, {
    initComponent: function () {
        Ext.form.TwinTriggerField.superclass.initComponent.call(this);

        this.triggerConfig = {
            tag: 'span', cls: 'x-form-twin-triggers', cn: [
            { tag: "img", src: Ext.BLANK_IMAGE_URL, cls: "x-form-trigger " + this.trigger1Class },
            { tag: "img", src: Ext.BLANK_IMAGE_URL, cls: "x-form-trigger " + this.trigger2Class }
        ]
        };
    },

    getTrigger: function (index) {
        return this.triggers[index];
    },

    initTrigger: function () {
        var ts = this.trigger.select('.x-form-trigger', true);
        this.wrap.setStyle('overflow', 'hidden');
        var triggerField = this;
        ts.each(function (t, all, index) {
            t.hide = function () {
                var w = triggerField.wrap.getWidth();
                this.dom.style.display = 'none';
                triggerField.el.setWidth(w - triggerField.trigger.getWidth());
            };
            t.show = function () {
                var w = triggerField.wrap.getWidth();
                this.dom.style.display = '';
                triggerField.el.setWidth(w - triggerField.trigger.getWidth());
            };
            var triggerIndex = 'Trigger' + (index + 1);

            if (this['hide' + triggerIndex]) {
                t.dom.style.display = 'none';
            }
            t.on("click", this['on' + triggerIndex + 'Click'], this, { preventDefault: true });
            t.addClassOnOver('x-form-trigger-over');
            t.addClassOnClick('x-form-trigger-click');
        }, this);
        this.triggers = ts.elements;
    },

    onTrigger1Click: Ext.emptyFn,
    onTrigger2Click: Ext.emptyFn
});

//검색박스
Ext.app.SearchField = Ext.extend(Ext.app.TwinTriggerField, {
    initComponent : function(){
        Ext.app.SearchField.superclass.initComponent.call(this);
        this.on('specialkey', function(f, e){
            if(e.getKey() == e.ENTER){
                this.onTrigger2Click();
            }
        }, this);
    },

    validationEvent:false,
    validateOnBlur:false,
    trigger1Class:'x-form-clear-trigger',
    trigger2Class:'x-form-search-trigger',
    hideTrigger1:true,
    //width:180,
    hasSearch : false,
    paramName : 'query',
    
    SearchClick : Ext.emptyFn,
    ClearClick : Ext.emptyFn,

    onTrigger1Click : function(){
        if(this.hasSearch) {
            this.el.dom.value = '';
			this.setValue('');
            //var o = {start: 0};
            //this.store.baseParams = this.store.baseParams || {};
            //this.store.baseParams[this.paramName] = '';
            //this.store.reload({params:o});
            this.triggers[0].hide();
            this.hasSearch = false;
            if(this.ClearClick) this.ClearClick();
			this.fireEvent('blur', this);
        }
    },

    onTrigger2Click : function() {
        var v = this.getRawValue();
        if(v.length < 1) {
            this.onTrigger1Click();
            //2자이상...
            return;
        }
        //var o = {start: 0};
        //this.store.baseParams = this.store.baseParams || {};
        //this.store.baseParams[this.paramName] = v;
        //this.store.reload({params:o});
		var isSearch = false;
		if(this.SearchClick) {
			isSearch = this.SearchClick();
		}
		if(isSearch) {
	        this.hasSearch = true;
	        this.triggers[0].show();
			this.fireEvent('blur', this);
		}
    }
});

//GRID 체크박스 BUG 패치
Ext.grid.RowSelectionModel.override(
{
    // FIX: added this function so it could be overrided in CheckboxSelectionModel
    handleDDRowClick: function(grid, rowIndex, e)
    {
        if(e.button === 0 && !e.shiftKey && !e.ctrlKey) {
            this.selectRow(rowIndex, false);
            grid.view.focusRow(rowIndex);
        }
    },
    
    initEvents: function ()
    {
        if(!this.grid.enableDragDrop && !this.grid.enableDrag){
            this.grid.on("rowmousedown", this.handleMouseDown, this);
        }else{ // allow click to work like normal
            // FIX: made this handler function overrideable
            this.grid.on("rowclick", this.handleDDRowClick, this);
        }

        this.rowNav = new Ext.KeyNav(this.grid.getGridEl(), {
            "up" : function(e){
                if(!e.shiftKey){
                    this.selectPrevious(e.shiftKey);
                }else if(this.last !== false && this.lastActive !== false){
                    var last = this.last;
                    this.selectRange(this.last,  this.lastActive-1);
                    this.grid.getView().focusRow(this.lastActive);
                    if(last !== false){
                        this.last = last;
                    }
                }else{
                    this.selectFirstRow();
                }
            },
            "down" : function(e){
                if(!e.shiftKey){
                    this.selectNext(e.shiftKey);
                }else if(this.last !== false && this.lastActive !== false){
                    var last = this.last;
                    this.selectRange(this.last,  this.lastActive+1);
                    this.grid.getView().focusRow(this.lastActive);
                    if(last !== false){
                        this.last = last;
                    }
                }else{
                    this.selectFirstRow();
                }
            },
            scope: this
        });

        var view = this.grid.view;
        view.on("refresh", this.onRefresh, this);
        view.on("rowupdated", this.onRowUpdated, this);
        view.on("rowremoved", this.onRemove, this);
    }
});

Ext.grid.CheckboxSelectionModel.override(
{
    // FIX: added this function to check if the click occured on the checkbox.
    //      If so, then this handler should do nothing...
    handleDDRowClick: function(grid, rowIndex, e)
    {
        var t = Ext.lib.Event.getTarget(e);
        if (t.className != "x-grid3-row-checker") {
            Ext.grid.CheckboxSelectionModel.superclass.handleDDRowClick.apply(this, arguments);
        }
    }
});

Ext.grid.GridDragZone.override(
{
    getDragData: function (e)
    {
        var t = Ext.lib.Event.getTarget(e);
        var rowIndex = this.view.findRowIndex(t);
        if(rowIndex !== false){
            var sm = this.grid.selModel;
            // FIX: Added additional check (t.className != "x-grid3-row-checker"). It may not
            //      be beautiful solution but it solves my problem at the moment.
            if ( (t.className != "x-grid3-row-checker") && (!sm.isSelected(rowIndex) || e.hasModifier()) ){
                sm.handleMouseDown(this.grid, rowIndex, e);
            }
            return {grid: this.grid, ddel: this.ddel, rowIndex: rowIndex, selections:sm.getSelections()};
        }

        return false;
    }
});


Ext.ns('Ext.ux.layout');
/*
 * ================  RowLayout  =======================
 */
/**
 * @class Ext.ux.layout.RowLayout
 * @extends Ext.layout.ContainerLayout
 * <p>This is the layout style of choice for creating structural layouts in a multi-row format where the height of
 * each row can be specified as a percentage or fixed height.  Row widths can also be fixed, percentage or auto.
 * This class is intended to be extended or created via the layout:'ux.row' {@link Ext.Container#layout} config,
 * and should generally not need to be created directly via the new keyword.</p>
 * <p>RowLayout does not have any direct config options (other than inherited ones), but it does support a
 * specific config property of <b><tt>rowHeight</tt></b> that can be included in the config of any panel added to it.  The
 * layout will use the rowHeight (if present) or height of each panel during layout to determine how to size each panel.
 * If height or rowHeight is not specified for a given panel, its height will default to the panel's height (or auto).</p>
 * <p>The height property is always evaluated as pixels, and must be a number greater than or equal to 1.
 * The rowHeight property is always evaluated as a percentage, and must be a decimal value greater than 0 and
 * less than 1 (e.g., .25).</p>
 * <p>The basic rules for specifying row heights are pretty simple.  The logic makes two passes through the
 * set of contained panels.  During the first layout pass, all panels that either have a fixed height or none
 * specified (auto) are skipped, but their heights are subtracted from the overall container height.  During the second
 * pass, all panels with rowHeights are assigned pixel heights in proportion to their percentages based on
 * the total <b>remaining</b> container height.  In other words, percentage height panels are designed to fill the space
 * left over by all the fixed-height and/or auto-height panels.  Because of this, while you can specify any number of rows
 * with different percentages, the rowHeights must always add up to 1 (or 100%) when added together, otherwise your
 * layout may not render as expected.  Example usage:</p>
 * <pre><code>
// All rows are percentages -- they must add up to 1
var p = new Ext.Panel({
    title: 'Row Layout - Percentage Only',
    layout:'ux.row',
    items: [{
        title: 'Row 1',
        rowHeight: .25 
    },{
        title: 'Row 2',
        rowHeight: .6
    },{
        title: 'Row 3',
        rowHeight: .15
    }]
});

// Mix of height and rowHeight -- all rowHeight values must add
// up to 1. The first row will take up exactly 120px, and the last two
// rows will fill the remaining container height.
var p = new Ext.Panel({
    title: 'Row Layout - Mixed',
    layout:'ux.row',
    items: [{
        title: 'Row 1',
        height: 120,
        // standard panel widths are still supported too:
        width: '50%' // or 200
    },{
        title: 'Row 2',
        rowHeight: .8,
        width: 300
    },{
        title: 'Row 3',
        rowHeight: .2
    }]
});
</code></pre>
 */
Ext.ux.layout.RowLayout = Ext.extend(Ext.layout.ContainerLayout, {
    // private
    monitorResize:true,

    // private
    isValidParent : function(c, target){
        return c.getEl().dom.parentNode == this.innerCt.dom;
    },

    // private
    onLayout : function(ct, target){
        var rs = ct.items.items, len = rs.length, r, i;

        if(!this.innerCt){
            target.addClass('ux-row-layout-ct');
            this.innerCt = target.createChild({cls:'x-row-inner'});
        }
        this.renderAll(ct, this.innerCt);

        var size = target.getViewSize();

        if(size.width < 1 && size.height < 1){ // display none?
            return;
        }

        var h = size.height - target.getPadding('tb'),
            ph = h;

        this.innerCt.setSize({height:h});
        
        // some rows can be percentages while others are fixed
        // so we need to make 2 passes
        
        for(i = 0; i < len; i++){
            r = rs[i];
            if(!r.rowHeight){
                ph -= (r.getSize().height + r.getEl().getMargins('tb'));
            }
        }

        ph = ph < 0 ? 0 : ph;

        for(i = 0; i < len; i++){
            r = rs[i];
            if(r.rowHeight){
                r.setSize({height: Math.floor(r.rowHeight*ph) - r.getEl().getMargins('tb')});
            }
        }
    }
    
    /**
     * @property activeItem
     * @hide
     */
});
Ext.Container.LAYOUTS['ux.row'] = Ext.ux.layout.RowLayout;

/*********************************************************************************************
 * TabScrollerMenu
 *********************************************************************************************/

