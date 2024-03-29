﻿<?xml version="1.0" encoding="utf-8" ?>
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
	        <tbtitle><asp:literal runat="server" text="<%$ Resources:WebOrg, SetLine %>"/></tbtitle> 
	    </tab>
	    <tab id="left_tab02" visible="true" img="org_btbg01" src="/ENF/OrgChart/MyLine.aspx" framename="">
	        <tbtitle><asp:literal runat="server" text="<%$ Resources:WebOrg, MyLine %>"/></tbtitle> 
	    </tab> 
	</select>
	<ui seq="0">
		<tab id="tab01" img="org_btbg02" type="approveragree">
			<tbtitle>
                <Ctl:Text runat="server" ID="tC_TB_TITLE1" LangCode="TTILE02" Description="발신" Literal="true"/>
                <%--<asp:literal runat="server" text="<%$ Resources:WebOrg, C_TB_TITLE3 %>"/>--%>
            </tbtitle>
			<list id="approval_0" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="txtLTITLE01" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<asp:literal runat="server" text="<%$ Resources:WebOrg, C_LS_TITLE1 %>"/>--%>
                </lstitle>
				<ritem id="app0" seq="0" disabled="true" change="true" validation="true"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_APP_TITLE1 %>"/></ritem>
                <ritem id="r0006" seq="0" disabled="true" change="true" validation="fasle"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE6 %>"/></ritem>
                <ritem id="r0005" seq="0" disabled="true" change="true" validation="fasle"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE5 %>"/></ritem>
                <ritem id="r0004" seq="0" disabled="true" change="true" validation="fasle"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE4 %>"/></ritem>
                <ritem id="r0003" seq="0" disabled="true" change="true" validation="fasle"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE3 %>"/></ritem>
				<ritem id="r0002" seq="0" disabled="true" change="true" validation="fasle"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE2 %>"/></ritem>
				<ritem id="r0001" seq="0" disabled="true" change="true" validation="fasle"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE1 %>"/></ritem>
				<ritem id="emp0" seq="0" disabled="true" change="true" validation="true"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EMP_TITLE1 %>"/></ritem>
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
	<ui seq="1">
		<tab id="tab01" img="org_btbg02" type="charge">
			<tbtitle>
                <Ctl:Text runat="server" ID="Text2" LangCode="TTILE02" Description="발신" Literal="true"/>
                <%--<asp:literal runat="server" text="<%$ Resources:WebOrg, C_TB_TITLE3 %>"/>--%>
            </tbtitle>
			<list id="charge" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="Text1" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<asp:literal runat="server" text="<%$ Resources:WebOrg, C_LS_TITLE1 %>"/>--%>
                </lstitle>
				<ritem id="app1" seq="1" disabled="true" change="true" validation="fasle"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_APP_TITLE1 %>"/></ritem>
                <ritem id="r1006" seq="1" disabled="true" change="true" validation="false"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE6 %>"/></ritem>
                <ritem id="r1005" seq="1" disabled="true" change="true" validation="false"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE5 %>"/></ritem>
                <ritem id="r1004" seq="1" disabled="true" change="true" validation="false"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE4 %>"/></ritem>
                <ritem id="r1003" seq="1" disabled="true" change="true" validation="false"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE3 %>"/></ritem>
                <ritem id="r1002" seq="1" disabled="true" change="true" validation="false"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE2 %>"/></ritem>
				<ritem id="r1001" seq="1" disabled="true" change="true" validation="false"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE1 %>"/></ritem>
				<ritem id="emp1" seq="1" disabled="true" change="false" validation="true"><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EMP_TITLE2 %>"/></ritem>
			</list>
		</tab>
	</ui>
</root>