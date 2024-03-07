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
	    <tab id="left_tab01" visible="true" img="btbg02" src="/ENF/OrgChart/Org.aspx" framename="hiframeRight">
	        <tbtitle><Ctl:Text runat="server" ID="Text14" LangCode="SetLine" Description="결재선 지정" Literal="true"/></tbtitle> 
	    </tab>
	</select>
	<ui seq="1">
		<tab id="tab01" img="org_btbg02" type="charge">
			<tbtitle><Ctl:Text runat="server" ID="Text22" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" /></tbtitle>
			<list id="charge" type="normal" size="1">
				<lstitle><Ctl:Text runat="server" ID="Text23" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" /></lstitle>
				<ritem id="emp1" seq="1" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="Text24" LangCode="C_R_EMP_TITLE2" Description="담당" Literal="true" /></ritem>
			</list>
		</tab>
	</ui>
    <ui seq="2">
		<tab id="tab02" img="org_btbg02" type="charge">
			<tbtitle><Ctl:Text runat="server" ID="Text1" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" /></tbtitle>
			<list id="charge" type="normal">
				<lstitle><Ctl:Text runat="server" ID="Text2" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" /></lstitle>
				<ritem id="emp2" seq="2" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="Text3" LangCode="C_R_EMP_TITLE2" Description="담당" Literal="true" /></ritem>
			</list>
		</tab>
	</ui>
</root>