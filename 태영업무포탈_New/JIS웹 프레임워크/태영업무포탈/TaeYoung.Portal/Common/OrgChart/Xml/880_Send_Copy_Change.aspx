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
	        <tbtitle><Ctl:Text runat="server" ID="Text9" LangCode="SetLine" Description="결재선 지정" Literal="true"/></tbtitle> 
	    </tab>
	    <tab id="left_tab02" visible="true" img="org_btbg01" src="/ENF/OrgChart/MyLine.aspx" framename="">
	        <tbtitle><Ctl:Text runat="server" ID="Text10" LangCode="MyLine" Description="결재선 보관" Literal="true"/></tbtitle> 
	    </tab> 
	</select>
	<ui seq="0">
		<tab id="tab01" img="org_btbg02" type="approveragree">
			<tbtitle>
                <Ctl:Text runat="server" ID="tC_TB_TITLE1" LangCode="TTILE02" Description="발신" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text11" LangCode="C_TB_TITLE3" Description="결재자" Literal="true"/>--%>
            </tbtitle>
			<list id="approval_0" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="Text16" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text12" LangCode="C_LS_TITLE1" Description="담당자" Literal="true"/>--%>
                </lstitle>
				<ritem id="app0" seq="0" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="tC_R_APP_TITLE1" LangCode="ORG_C_R_APP_TITLE1" Description="C_R_APP_TITLE1" Literal="true"/></ritem>
                <ritem id="r0006" seq="0" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="tC_R_EXA_TITLE6" LangCode="ORG_C_R_EXA_TITLE6" Description="C_R_EXA_TITLE6" Literal="true"/></ritem>
                <ritem id="r0005" seq="0" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="tC_R_EXA_TITLE5" LangCode="ORG_C_R_EXA_TITLE5" Description="C_R_EXA_TITLE5" Literal="true"/></ritem>
                <ritem id="r0004" seq="0" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="tC_R_EXA_TITLE4" LangCode="ORG_C_R_EXA_TITLE4" Description="C_R_EXA_TITLE4" Literal="true"/></ritem>
				<ritem id="r0003" seq="0" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="tC_R_EXA_TITLE3" LangCode="ORG_C_R_EXA_TITLE3" Description="C_R_EXA_TITLE3" Literal="true"/></ritem>
				<ritem id="r0002" seq="0" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="tC_R_EXA_TITLE2" LangCode="ORG_C_R_EXA_TITLE2" Description="C_R_EXA_TITLE2" Literal="true"/></ritem>
				<ritem id="r0001" seq="0" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="tC_R_EXA_TITLE1" LangCode="ORG_C_R_EXA_TITLE1" Description="C_R_EXA_TITLE1" Literal="true"/></ritem>
				<ritem id="emp0" seq="0" disabled="true" change="false" validation="true"><Ctl:Text runat="server" ID="tC_R_EMP_TITLE1" LangCode="ORG_C_R_EMP_TITLE1" Description="C_R_EMP_TITLE1" Literal="true"/></ritem>
			</list>
		</tab>
        <tab id="tab02" img="org_btbg01" type="acl">
			<tbtitle><Ctl:Text runat="server" ID="Text13" LangCode="C_TB_TITLE2" Description="수신처" Literal="true"/></tbtitle>
			<%--<tbtitle><Ctl:Text runat="server" ID="Text18" LangCode="C_TB_TITLE2" Description="수신처/사본처" Literal="true"/></tbtitle>--%>
			<list id="send" type="sendto" min="0" max="0" size="8">
				<lstitle><Ctl:Text runat="server" ID="Text14" LangCode="C_LS_TITLE3" Description="수신처" Literal="true"/></lstitle>
			</list>
			<list id="copy" type="sendto" min="0" max="0" size="8">
				<lstitle><Ctl:Text runat="server" ID="Text15" LangCode="C_LS_TITLE4" Description="사본처" Literal="true"/></lstitle>
			</list>
		</tab>
	</ui>
	<ui seq="1">
		<tab id="tab01" img="org_btbg02" type="charge">
			<tbtitle>
                <Ctl:Text runat="server" ID="Text11" LangCode="TTILE02" Description="발신" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text16" LangCode="C_TB_TITLE3" Description="결재자" Literal="true"/>--%>
            </tbtitle>
			<list id="charge" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="txtLTITLE01" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text17" LangCode="C_LS_TITLE1" Description="결재자" Literal="true"/>--%>
                </lstitle>
				<ritem id="app1" seq="1" disabled="true" change="true" validation="fasle"><Ctl:Text runat="server" ID="Text1" LangCode="ORG_C_R_APP_TITLE1" Description="C_R_APP_TITLE1" Literal="true"/><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_APP_TITLE1 %>"/></ritem>
                <ritem id="r1006" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text2" LangCode=C_R_EXA_TITLE6" Description="C_R_EXA_TITLE6" Literal="true"/><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE6 %>"/></ritem>
                <ritem id="r1005" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text3" LangCode=C_R_EXA_TITLE5" Description="C_R_EXA_TITLE5" Literal="true"/><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE5 %>"/></ritem>
                <ritem id="r1004" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text4" LangCode=C_R_EXA_TITLE4" Description="C_R_EXA_TITLE4" Literal="true"/><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE4 %>"/></ritem>
                <ritem id="r1003" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text5" LangCode=C_R_EXA_TITLE3" Description="C_R_EXA_TITLE3" Literal="true"/><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE3 %>"/></ritem>
                <ritem id="r1002" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text6" LangCode=C_R_EXA_TITLE2" Description="C_R_EXA_TITLE2" Literal="true"/><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE2 %>"/></ritem>
				<ritem id="r1001" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text7" LangCode=C_R_EXA_TITLE1" Description="C_R_EXA_TITLE1" Literal="true"/><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EXA_TITLE1 %>"/></ritem>
				<ritem id="emp1" seq="1" disabled="true" change="false" validation="true"><Ctl:Text runat="server" ID="Text8" LangCode="C_R_EMP_TITLE2" Description="C_R_EMP_TITLE2" Literal="true"/><asp:literal runat="server" text="<%$ Resources:WebOrg, C_R_EMP_TITLE2 %>"/></ritem>
			</list>
		</tab>
	</ui>
</root>