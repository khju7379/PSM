<?xml version="1.0" encoding="utf-8" ?>
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
	</select>
	<ui seq="0">
		<tab id="tab01" img="org_btbg02" type="charge">
			<tbtitle><asp:literal runat="server" text="<%$ Resources:WebOrg, C_TB_TITLE4 %>"/></tbtitle>
			<list id="charge" type="normal">
				<lstitle><asp:literal runat="server" text="<%$ Resources:WebOrg, C_LS_TITLE5 %>"/></lstitle>
				<ritem id="emp1" seq="1" disabled="true" change="true" validation="true"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EMP_TITLE2 %>"/></ritem>
			</list>
		</tab>
	</ui>
</root>