
/**
 * OrgMap.Org.Presence.js
 * 조직도 화면에서 보여줄 Presence (OCS Presence NameCtrl)
 * 참고:http://msdn.microsoft.com/en-us/library/ms455335.aspx
 * 홍정화(caoko@miksystem.com) 2008-09-04
 * revision 73 2008-09-08 버그 수정 : namectl은 office sp1과 ocs버전이 동일한 상태에서만 작동한다.
 * revision 90 2008-09-29 ver 1.0 beta 
 */
 
function Browseris () {
	var agt=navigator.userAgent.toLowerCase();
	this.osver=1.0;
	if (agt)
	{
		var stOSVer=agt.substring(agt.indexOf("windows ")+11);
		this.osver=parseFloat(stOSVer);
	}
	this.major=parseInt(navigator.appVersion);
	this.nav=((agt.indexOf('mozilla')!=-1)&&((agt.indexOf('spoofer')==-1) && (agt.indexOf('compatible')==-1)));
	this.nav6=this.nav && (this.major==5);
	this.nav6up=this.nav && (this.major >=5);
	this.nav7up=false;
	if (this.nav6up)
	{
		var navIdx=agt.indexOf("netscape/");
		if (navIdx >=0 )
			this.nav7up=parseInt(agt.substring(navIdx+9)) >=7;
	}
	this.ie=(agt.indexOf("msie")!=-1);
	this.aol=this.ie && agt.indexOf(" aol ")!=-1;
	if (this.ie)
		{
		var stIEVer=agt.substring(agt.indexOf("msie ")+5);
		this.iever=parseInt(stIEVer);
		this.verIEFull=parseFloat(stIEVer);
		}
	else
		this.iever=0;
	this.ie4up=this.ie && (this.major >=4);
	this.ie5up=this.ie && (this.iever >=5);
	this.ie55up=this.ie && (this.verIEFull >=5.5);
	this.ie6up=this.ie && (this.iever >=6);
	this.winnt=((agt.indexOf("winnt")!=-1)||(agt.indexOf("windows nt")!=-1));
	this.win32=((this.major >=4) && (navigator.platform=="Win32")) ||
		(agt.indexOf("win32")!=-1) || (agt.indexOf("32bit")!=-1);
	this.mac=(agt.indexOf("mac")!=-1);
	this.w3c=this.nav6up;
	this.safari=(agt.indexOf("safari")!=-1);
	this.safari125up=false;
	if (this.safari && this.major >=5)
	{
		var navIdx=agt.indexOf("safari/");
		if (navIdx >=0)
			this.safari125up=parseInt(agt.substring(navIdx+7)) >=125;
	}
}


var L_IMNOnline_Text = Language.Online;
var L_IMNOffline_Text = Language.Offline;
var L_IMNAway_Text = Language.Away;
var L_IMNBusy_Text = Language.Busy;
var L_IMNDoNotDisturb_Text = Language.DoNotDisturb;
var L_IMNIdle_Text = Language.Away;
var L_IMNBlocked_Text = Language.Block;
var L_IMNOnline_OOF_Text = Language.OnlineAbsent;
var L_IMNOffline_OOF_Text = Language.OfflineAbsent;
var L_IMNAway_OOF_Text = Language.AwayAbsent;
var L_IMNBusy_OOF_Text = Language.BusyAbsent;
var L_IMNDoNotDisturb_OOF_Text = Language.DoNotDisturbAbsent;
var L_IMNIdle_OOF_Text = Language.AwayAbsent;

GW.OrgMap.Presence = function(el, name) {
    this.type = "GW.OrgMap.Presence";
	this.name = name;
	this.status = null;
	this.imgEl = el;
	this.imgCurrentClassName = "gw-presence-unk";
	
	this.el = new Ext.Element(el.parent());
	this.parent = new Ext.Element(this.el.parent());
	
	this.el.on('mouseover', this.OnMouseOver, this);
	this.el.on('focusin', this.OnFocusIn, this);
	this.el.on('mouseout', this.OnMouseOut, this);
	this.el.on('focusout', this.OnFocusOut, this);
};

GW.OrgMap.Presence.idSeed = 0;
GW.OrgMap.Presence.BLANK_IMAGE_URL = "Common/presence.image/BLANK.GIF";

// singleton
GW.OrgMap.Presence.Templates = new Ext.Template(
	'<span id="{id}" class="gw-presence">',
		'<img class="gw-presence-icon gw-presence-unk" onload="GW.NameControl.Bind(this, \'{name}\');" src="' + GW.OrgMap.Presence.BLANK_IMAGE_URL + '" />',
	'</span>'
);

GW.OrgMap.Presence.prototype = {

	OnMouseOver : function(e) {
	    var x = this.parent.getLeft();
	    var y = this.parent.getTop();
	    GW.NameControl.Show(this.name, 0, x, y);
	},

	OnFocusIn : function(e) {
	    var x = this.parent.getLeft();
	    var y = this.parent.getTop();
	    GW.NameControl.Show(this.name, 1, x, y);
	},	
	
	OnMouseOut : function(e) {
		GW.NameControl.Hide();
	},

	OnFocusOut : function(e) {
		GW.NameControl.Hide();
	},
	
	getName : function() {
		return this.name;
	},
	
	getStatus : function() {
		return this.status;
	},
	
	setStatus : function(status) {
		this.status = status;
		this.updateIcon();
	},
	
	getId : function() {
		return this.el.id; 
	},
	
	updateIcon : function() {
		var showoffline = true;
		var img = "";
		var alt = "";
		switch (this.status)
		{
			case 0:
				img="gw-presence-on";
				alt=L_IMNOnline_Text;
			break;
			case 11:
				img="gw-presence-onoof";
				alt=L_IMNOnline_OOF_Text;
			break;
			case 1:
				if (showoffline)
				{
					img="gw-presence-off";
					alt=L_IMNOffline_Text;
				}
				else
				{
					img="";
					alt="";
				}
			break;
			case 12:
				if (showoffline)
				{
					img="gw-presence-offoof";
					alt=L_IMNOffline_OOF_Text;
				}
				else
				{
					img="";
					alt="";
				}
			break;
			case 2:
				img="gw-presence-away";
				alt=L_IMNAway_Text;
			break;
			case 13:
				img="gw-presence-awayoof";
				alt=L_IMNAway_OOF_Text;
			break;
			case 3:
				img="gw-presence-busy";
				alt=L_IMNBusy_Text;
			break;
			case 14:
				img="gw-presence-busyoof";
				alt=L_IMNBusy_OOF_Text;
			break;
			case 4:
				img="gw-presence-away";
				alt=L_IMNAway_Text;
			break;
			case 5:
				img="gw-presence-busy";
				alt=L_IMNBusy_Text;
			break;
			case 6:
				img="gw-presence-away";
				alt=L_IMNAway_Text;
			break;
			case 7:
				img="gw-presence-busy";
				alt=L_IMNBusy_Text;
			break;
			case 8:
				img="gw-presence-away";
				alt=L_IMNAway_Text;
			break;
			case 9:
				img="gw-presence-dnd";
				alt=L_IMNDoNotDisturb_Text;
			break;
			case 15:
				img="gw-presence-dndoof";
				alt=L_IMNDoNotDisturb_OOF_Text;
			break;
			case 10:
				img="gw-presence-busy";
				alt=L_IMNBusy_Text;
			break;
			case 16:
				img="gw-presence-idle";
				alt=L_IMNIdle_Text;
			break;
			case 17:
				img="gw-presence-idleoof";
				alt=L_IMNIdle_OOF_Text;
			break;
			case 18:
				img="gw-presence-blocked";
				alt=L_IMNBlocked_Text;
			break;
			case 19:
				img="gw-presence-idlebusy";
				alt=L_IMNBusy_Text;
			break;
			case 20:
				img="gw-presence-idlebusyoof";
				alt=L_IMNBusy_OOF_Text;
			break;
			default:
				return;
			break;
		}
        this.imgEl.removeClass(this.imgCurrentClassName);
		this.imgCurrentClassName = img;
        this.imgEl.addClass(img);
		//this.imgEl.className = img;
		this.imgEl.alt = alt;
	}
};

function IMNOnStatusChange(name, state, id)
{
	GW.NameControl.OnStatusChanage(name, state, id);
};

// private
GW.PresenceMgr = function() {
	
	this.isCanUse = false;
	this.IMNControlObj = null;

	var browseris = new Browseris();
	if(browseris.ie5up && browseris.win32)
	{
		try	
		{
			this.IMNControlObj = new ActiveXObject("Name.NameCtrl.1");
		} 
		catch(e) { 
            // alert('Name.NameCtrl failed to get instnace.'); 
            return; 
        };
		// 버그 수정 2008-11-03
		try
		{
		    if(this.IMNControlObj)
		    {
			    this.IMNControlObj.OnStatusChange = IMNOnStatusChange;
			    this.isCanUse = true;
		    }
		}
		catch(e) { this.isCanUse = false; return; }
	}
	
	this.PresenceTable = new Ext.util.MixedCollection();
};

// private
GW.PresenceMgr.prototype = {

	OnStatusChanage : function(name, status, key) {
		if(this.PresenceTable && this.PresenceTable.getCount() > 0)
		{
			var presence = null;
			presence = this.PresenceTable.get(key);
			if(presence && presence.getName() === name)
			{
				if(presence.getStatus() != status)
				{
					presence.setStatus(status);
				}
			}
		}
	},
	
	Show : function(name, inputType, ouiX, ouiY) {
		if(this.isCanUse)
		{
			this.IMNControlObj.ShowOOUI(name, inputType, ouiX, ouiY);
		}
	},
	
	Hide : function() {
		if(this.isCanUse)
		{
			this.IMNControlObj.HideOOUI();
			return false;
		}
		return true;
	},
	
	RegisterPresence : function(key, presence) {
		if(this.PresenceTable)
		{
			if(presence.type === "GW.OrgMap.Presence") 
			{
				this.PresenceTable.add(key, presence);
				return true;
			}
		}
		return false;
	},
	
	UnRegisterPresenceAll : function() {
		if(this.PresenceTable)
		{
			this.PresenceTable.clear();
		}
	},
	
	Bind : function(el, name) {
		el = new Ext.Element(el);
		var presence = new GW.OrgMap.Presence(el, name);
		if(this.isCanUse)
		{
			if(this.IMNControlObj.PresenceEnabled)
			{
				this.RegisterPresence(presence.getId(), presence);
				this.IMNControlObj.GetStatus(name, presence.getId());
				var state = this.IMNControlObj.GetStatus(name, presence.getId());
				if(state != 1)
					presence.setStatus(state);
			}
		}
	},
	
	toHTMLString : function(name, id) {
		var id = id || "gw-presence-" + (++GW.OrgMap.Presence.idSeed);
		return GW.OrgMap.Presence.Templates.apply({id:id, name:name});
	}
};

// singleton
GW.NameControl = new GW.PresenceMgr();