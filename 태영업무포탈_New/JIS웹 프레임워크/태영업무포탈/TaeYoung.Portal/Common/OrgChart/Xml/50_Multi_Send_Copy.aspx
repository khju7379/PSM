﻿<?xml version="1.0" encoding="utf-8" ?>
<%@ Page Language="C#"%>
<script runat="server">
protected override void InitializeCulture()
{
	if(!string.IsNullOrEmpty(Request.Params["_culture"]))
	{
		if (Request.Params["_culture"].ToLower().Equals("cn"))
			this.UICulture = "zh-CHT";
		else
			this.UICulture = Request.Params["_culture"];
	}
	else
	{
		this.UICulture = "ko";
	}

	base.InitializeCulture();
}
</script>
<root>
	<meta>
	</meta>
	<select>
	    <tab id="left_tab01" visible="true" img="org_btbg02" src="/ENF/OrgChart/Org.aspx" framename="hiframeRight">
	        <tbtitle><asp:literal runat="server" text="<%$ Resources:WebOrg, SetLine %>"/></tbtitle>
	    </tab>
	    <tab id="left_tab02" visible="true" img="org_btbg01" src="/ENF/OrgChart/MyLine.aspx" framename="">
	        <tbtitle><asp:literal runat="server" text="<%$ Resources:WebOrg, MyLine %>"/></tbtitle>
	    </tab>
	</select>
	<ui seq="0">
		<tab id="tab01" img="org_btbg02" type="approveragree">
		    <tbtitle><asp:literal runat="server" text="<%$ Resources:WebOrg, C_TB_TITLE1 %>"/></tbtitle>
			<list id="approval" type="normal">
				<lstitle><asp:literal runat="server" text="<%$ Resources:WebOrg, C_LS_TITLE1 %>"/></lstitle>
				<ritem id="app0" seq="0" disabled="true" change="true" validation="true"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_APP_TITLE1 %>"/></ritem>
				<ritem id="r0003" seq="0" disabled="true" change="true" validation="false"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE3 %>"/></ritem>
				<ritem id="r0002" seq="0" disabled="true" change="true" validation="false"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE2 %>"/></ritem>
				<ritem id="r0001" seq="0" disabled="true" change="true" validation="false"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE1 %>"/></ritem>
				<ritem id="emp0" seq="0" disabled="true" change="true" validation="true"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EMP_TITLE1 %>"/></ritem>
			</list>
			<list id="multi" type="agree">
				<tab id="emp0" seq="0" img="org_btbg01"><tbtitle>기안후협조</tbtitle></tab>
				<tab id="r0001" seq="1" img="org_btbg01"><tbtitle>검토1후협조</tbtitle></tab>
				<tab id="r0002" seq="2" img="org_btbg01"><tbtitle>검토2후협조</tbtitle></tab>
				<tab id="r0003" seq="3" img="org_btbg01"><tbtitle>검토3후협조</tbtitle></tab>
				<item id="emp0_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
				<item id="r0001_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
				<item id="r0002_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
				<item id="r0003_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
			</list>
		</tab>
		<tab id="tab02" img="org_btbg01" type="acl">
			<tbtitle><asp:literal runat="server" text="<%$ Resources:WebOrg, C_TB_TITLE2 %>"/></tbtitle>
			<list id="send" type="sendto" min="0" max="0" size="8">
				<lstitle><asp:literal runat="server" text="<%$ Resources:WebOrg, C_LS_TITLE3 %>"/></lstitle>
			</list>
			<list id="copy" type="sendto" min="0" max="0" size="8">
				<lstitle><asp:literal runat="server" text="<%$ Resources:WebOrg, C_LS_TITLE4 %>"/></lstitle>
			</list>
		</tab>
	</ui>
</root>