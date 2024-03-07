<?xml version="1.0" encoding="utf-8" ?>
<%@ Page Language="C#" CodeBehind="XsltBase.aspx.cs" Inherits="TaeYoung.Approval.Form.Xslt.XsltBase"%>
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
	        <tbtitle><Ctl:Text runat="server" ID="tSetLine" LangCode="ORG_SetLine" Description="SetLine" Literal="true"/></tbtitle>
	    </tab>
	    <tab id="left_tab02" visible="true" img="org_btbg01" src="/ENF/OrgChart/MyLine.aspx" framename="">
	        <tbtitle><Ctl:Text runat="server" ID="tMyLine" LangCode="ORG_MyLine" Description="MyLine" Literal="true"/></tbtitle>
	    </tab>
	    <%--<tab id="left_tab03" visible="true" img="org_btbg01" src="/ENF/OrgChart/AclArchive.aspx" framename="">
	        <tbtitle><Ctl:Text runat="server" ID="" LangCode="AclArchive" Description=""/></tbtitle>
	    </tab> --%>
	</select>
	<ui seq="0">
		<tab id="tab01" img="org_btbg02" type="approveragree">
		    <tbtitle>
                <Ctl:Text runat="server" ID="tC_TB_TITLE1" LangCode="TTILE02" Description="발신" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="tC_TB_TITLE1" LangCode="ORG_C_TB_TITLE1" Description="C_TB_TITLE1" Literal="true"/>--%>
            </tbtitle>
			<list id="approval" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="txtLTITLE01" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="tC_LS_TITLE1" LangCode="ORG_C_LS_TITLE1" Description="C_LS_TITLE1" Literal="true"/>--%>
                </lstitle>
				<ritem id="emp0" seq="0" disabled="true" change="false" validation="true"><Ctl:Text runat="server" ID="tC_R_EMP_TITLE1" LangCode="ORG_C_R_EMP_TITLE1" Description="C_R_EMP_TITLE1" Literal="true"/></ritem>
			</list>
		</tab>
	</ui>
</root>