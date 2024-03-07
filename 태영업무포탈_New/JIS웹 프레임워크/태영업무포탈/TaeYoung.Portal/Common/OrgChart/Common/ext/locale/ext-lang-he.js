/**
 * Hebrew Translations
 * By spartacus (from forums) 06-12-2007
 */

Ext.UpdateManager.defaults.indicatorText = '<div class="loading-indicator">...猥瓆</div>';

if(Ext.View){
  Ext.View.prototype.emptyText = "";
}

if(Ext.grid.GridPanel){
  Ext.grid.GridPanel.prototype.ddText = "緘袍?趙懊勵 {0}";
}

if(Ext.TabPanelItem){
  Ext.TabPanelItem.prototype.closeText = "竣予 稔儼澐";
}

if(Ext.form.Field){
  Ext.form.Field.prototype.invalidText = "曖鮑 嫂宸 輦 喊彦";
}

if(Ext.LoadMask){
  Ext.LoadMask.prototype.msg = "...猥瓆";
}

Date.monthNames = [
  "昱魚?,
  "疊袍星",
  "廛?,
  "宬飽?,
  "績?,
  "虞族",
  "虞一",
  "齧橓茁",
  "曾姚壽",
  "齧婆齬?,
  "釣灑壽",
  "迅翟?
];

Date.getShortMonthName = function(month) {
  return Date.monthNames[month].substring(0, 3);
};

Date.monthNumbers = {
  Jan : 0,
  Feb : 1,
  Mar : 2,
  Apr : 3,
  May : 4,
  Jun : 5,
  Jul : 6,
  Aug : 7,
  Sep : 8,
  Oct : 9,
  Nov : 10,
  Dec : 11
};

Date.getMonthNumber = function(name) {
  return Date.monthNumbers[name.substring(0, 1).toUpperCase() + name.substring(1, 3).toLowerCase()];
};

Date.dayNames = [
  "?,
  "?,
  "?,
  "?,
  "?,
  "?,
  "?
];

Date.getShortDayName = function(day) {
  return Date.dayNames[day].substring(0, 3);
};

if(Ext.MessageBox){
  Ext.MessageBox.buttonText = {
    ok     : "纖緘?,
    cancel : "誦猥?,
    yes    : "倚",
    no     : "茵"
  };
}

if(Ext.util.Format){
  Ext.util.Format.date = function(v, format){
    if(!v) return "";
    if(!(v instanceof Date)) v = new Date(Date.parse(v));
    return v.dateFormat(format || "d/m/Y");
  };
}

if(Ext.DatePicker){
  Ext.apply(Ext.DatePicker.prototype, {
    todayText         : "昻孼",
    minText           : ".睍飽?輦 傲 特臣 臨星隅 狎賢臨?陜投?,
    maxText           : ".睍飽?輦 傲 茵懊 掖星隅 愛淹?陜投?,
    disabledDaysText  : "",
    disabledDatesText : "",
    monthNames        : Date.monthNames,
    dayNames          : Date.dayNames,
    nextText          : '(Control+Right) 央憶?闇?,
    prevText          : '(Control+Left) 央憶?靄憶?,
    monthYearText     : '(藺五表 陜?Control+Up/Down) 淞?銳實',
    todayTip          : "展?袍偃) {0})",
    format            : "d/m/Y",
    okText            : "&#160;纖緘?#160;",
    cancelText        : "誦猥?,
    startDay          : 0
  });
}

if(Ext.PagingToolbar){
  Ext.apply(Ext.PagingToolbar.prototype, {
    beforePageText : "桎憶",
    afterPageText  : "{0} 戰焉",
    firstText      : "桎憶 胞緘?,
    prevText       : "桎憶 特臣",
    nextText       : "桎憶 闇?,
    lastText       : "桎憶 暹袍?,
    refreshText    : "剽卒",
    displayMsg     : "專羽 {0} - {1} 戰焉 {2}",
    emptyMsg       : '纖?迹訊 隣他?
  });
}

if(Ext.form.TextField){
  Ext.apply(Ext.form.TextField.prototype, {
    minLengthText : "{0} 菴予?哀昱彧閃?稔宸 輦 鴨?,
    maxLengthText : "{0} 菴予?哀橒誦 稔宸 輦 鴨?,
    blankText     : "檻?輦 秧逋?,
    regexText     : "",
    emptyText     : null
  });
}

if(Ext.form.NumberField){
  Ext.apply(Ext.form.NumberField.prototype, {
    minText : "{0} 曖鮑 哀昱彧閃?稔宸 輦 鴨?,
    maxText : "{0} 曖鮑 哀橒誦 稔宸 輦 鴨?,
    nanText : "鴨?茵 前初 {0}"
  });
}

if(Ext.form.DateField){
  Ext.apply(Ext.form.DateField.prototype, {
    disabledDaysText  : "典堰暴",
    disabledDatesText : "典堰暴",
    minText           : "{0} 掖星隅 嫂宸 輦 五紆 隣虞?茵懊",
    maxText           : "{0} 掖星隅 嫂宸 輦 五紆 隣虞?妊族",
    invalidText       : "{1} 鴨?茵 睍飽?脇族 - 五紆 隣虞?受予迪 {0}",
    format            : "m/d/y",
    altFormats        : "m/d/Y|m-d-y|m-d-Y|m/d|m-d|md|mdy|mdY|d|Y-m-d"
  });
}

if(Ext.form.ComboBox){
  Ext.apply(Ext.form.ComboBox.prototype, {
    loadingText       : "...猥瓆",
    valueNotFoundText : undefined
  });
}

if(Ext.form.VTypes){
  Ext.apply(Ext.form.VTypes, {
    emailText    : '"user@domain.com" 檻?輦 晫隅 隣虞?艤齬?愼星 閃婆袍族 受予迪',
    urlText      : '"http:/'+'/www.domain.com" 檻?輦 晫隅 隣虞?艤齬?纖鳥輻?受予迪',
    alphaText    : '_檻?輦 雨諺 隣邑?漂 齧顯勵 ?,
    alphanumText : '_檻?輦 雨諺 隣邑?漂 齧顯勵, 前初勖 ?
  });
}

if(Ext.form.HtmlEditor){
  Ext.apply(Ext.form.HtmlEditor.prototype, {
    createLinkText : ':燮?靄認 猩 艤齬?菴昱曜鳥 賑予 靄殞予',
    buttonTips : {
      bold : {
        title: '(Ctrl+B) 赤呻?,
        text: '.押戌 猩 怏琶?崖淞?,
        cls: 'x-html-editor-tip'
      },
      italic : {
        title: '(Ctrl+I) 鳥彦',
        text: '.怏?猩 怏琶?崖淞?,
        cls: 'x-html-editor-tip'
      },
      underline : {
        title: '(Ctrl+U) 特 賢顯',
        text: '.鴨憎 派 賢顯 賑予 怏琶?崖淞?,
        cls: 'x-html-editor-tip'
      },
      increasefontsize : {
        title: '壓腎 料茁',
        text: '.壓腎 橓剃 賑予 怏琶?崖淞?,
        cls: 'x-html-editor-tip'
      },
      decreasefontsize : {
        title: '靄寥 料茁',
        text: '.靄寥 橓剃 賑予 怏琶?崖淞?,
        cls: 'x-html-editor-tip'
      },
      backcolor : {
        title: '快?漂?麟琶?,
        text: '.陜?猩 快?厄破 賑予 怏琶?崖淞?,
        cls: 'x-html-editor-tip'
      },
      forecolor : {
        title: '快?橓剃',
        text: '.陜?猩 快?壓淹?賑予 怏琶?崖淞?,
        cls: 'x-html-editor-tip'
      },
      justifyleft : {
        title: '殞予 稔績?,
        text: '.殞?閤閃?猩 怏琶?崖淞?,
        cls: 'x-html-editor-tip'
      },
      justifycenter : {
        title: '殞予 溢幅?,
        text: '.殞?溢幅?猩 怏琶?崖淞?,
        cls: 'x-html-editor-tip'
      },
      justifyright : {
        title: '殞予 一迹?,
        text: '.殞?彧昱?猩 怏琶?崖淞?,
        cls: 'x-html-editor-tip'
      },
      insertunorderedlist : {
        title: '票彧?棕憶勵',
        text: '.掖傲 票彧?棕憶勵',
        cls: 'x-html-editor-tip'
      },
      insertorderedlist : {
        title: '票彧?傳嚴初?,
        text: '.掖傲 票彧?傳嚴初?,
        cls: 'x-html-editor-tip'
      },
      createlink : {
        title: '巴緘?,
        text: '.碍焉 猩 怏琶?崖淞?林殞予',
        cls: 'x-html-editor-tip'
      },
      sourceedit : {
        title: '斟雨?特?展予',
        text: '.隘?特?展予',
        cls: 'x-html-editor-tip'
      }
    }
  });
}

if(Ext.grid.GridView){
  Ext.apply(Ext.grid.GridView.prototype, {
    sortAscText  : "迹旭 衰室 鎭隣",
    sortDescText : "迹旭 衰室 虞葡",
    lockText     : "倧?桎憶?,
    unlockText   : "銜瓢 桎憶?,
    columnsText  : "桎憶勵"
  });
}

if(Ext.grid.GroupingView){
  Ext.apply(Ext.grid.GroupingView.prototype, {
    emptyGroupText : '(飽?',
    groupByText    : '隘?垂悚墮?妊?檻?輦',
    showGroupsText : '隘?垂悚墮?
  });
}

if(Ext.grid.PropertyColumnModel){
  Ext.apply(Ext.grid.PropertyColumnModel.prototype, {
    nameText   : "蛤",
    valueText  : "斟?,
    dateFormat : "m/j/Y"
  });
}

if(Ext.layout.BorderLayout && Ext.layout.BorderLayout.SplitRegion){
  Ext.apply(Ext.layout.BorderLayout.SplitRegion.prototype, {
    splitTip            : ".悛焉 稔昱彦 橓腎",
    collapsibleSplitTip : ".悛焉 稔昱彦 橓腎. 鱗云?擬諺?隣蒸蒲"
  });
}
