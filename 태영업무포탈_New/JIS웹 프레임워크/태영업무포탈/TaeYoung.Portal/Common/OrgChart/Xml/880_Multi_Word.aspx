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
	</select>
	<ui seq="0">
		<tab id="tab01" img="org_btbg02" type="approveragree">
		    <tbtitle>
                <Ctl:Text runat="server" ID="tC_TB_TITLE1" LangCode="TTILE01" Description="발신 및 협조" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="tC_TB_TITLE1" LangCode="ORG_C_TB_TITLE1" Description="C_TB_TITLE1" Literal="true"/>--%>
            </tbtitle>
			<list id="approval" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="txtLTITLE01" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="tC_LS_TITLE1" LangCode="ORG_C_LS_TITLE1" Description="C_LS_TITLE1" Literal="true"/>--%>
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
            <list id="multi" type="agree">
				<tab id="emp0" seq="0" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterDraft" LangCode="DraftAfterAgree" Description="기안후협조" Literal="true"/></tbtitle></tab>
				<tab id="r0001" seq="1" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev1" LangCode="ConsiderAfterAgree1" Description="검토1후협조" Literal="true"/></tbtitle></tab>
				<tab id="r0002" seq="2" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev2" LangCode="ConsiderAfterAgree2" Description="검토2후협조" Literal="true"/></tbtitle></tab>
				<tab id="r0003" seq="3" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev3" LangCode="ConsiderAfterAgree3" Description="검토3후협조" Literal="true"/></tbtitle></tab>
                <tab id="r0004" seq="4" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev4" LangCode="ConsiderAfterAgree4" Description="검토4후협조" Literal="true"/></tbtitle></tab>
                <tab id="r0005" seq="5" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev5" LangCode="ConsiderAfterAgree5" Description="검토5후협조" Literal="true"/></tbtitle></tab>
                <tab id="r0006" seq="6" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev6" LangCode="ConsiderAfterAgree6" Description="검토6후협조" Literal="true"/></tbtitle></tab>
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
                <item id="r0004_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
                <item id="r0005_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
                <item id="r0006_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
			</list>
		</tab>
        <tab id="tab02" img="org_btbg01" type="charge">
			<tbtitle>
                <Ctl:Text runat="server" ID="txtTTILE01" LangCode="TTILE03" Description="수신" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text28" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" />--%>
            </tbtitle>
			<list id="charge" type="normal" size="1">
				<lstitle>
                    <Ctl:Text runat="server" ID="Text2" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text29" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" />--%>
                </lstitle>
				<ritem id="emp1" seq="1" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="Text30" LangCode="C_R_EMP_TITLE2" Description="담당" Literal="true" /></ritem>
			</list>
		</tab>
	</ui>
    <ui seq="1">
		<tab id="tab01" img="org_btbg02" type="approveragree">
			<tbtitle>
                <Ctl:Text runat="server" ID="Text1" LangCode="TTILE01" Description="발신 및 협조" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text12" LangCode="C_TB_TITLE3" Description="결재자" Literal="true"/>--%>
            </tbtitle>
			<list id="approval" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="Text3" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text13" LangCode="C_LS_TITLE1" Description="담당자" Literal="true"/>--%>
                </lstitle>
				<ritem id="app1" seq="1" disabled="true" change="true" validation="fasle"><Ctl:Text runat="server" ID="Text4" LangCode="C_R_APP_TITLE1" Description="승인" Literal="true"/></ritem>
                <ritem id="r1006" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text5" LangCode="C_R_EXA_TITLE6" Description="검토6" Literal="true"/></ritem>
                <ritem id="r1005" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text6" LangCode="C_R_EXA_TITLE5" Description="검토5" Literal="true"/></ritem>
                <ritem id="r1004" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text7" LangCode="C_R_EXA_TITLE4" Description="검토4" Literal="true"/></ritem>
                <ritem id="r1003" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text8" LangCode="C_R_EXA_TITLE3" Description="검토3" Literal="true"/></ritem>
                <ritem id="r1002" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text9" LangCode="C_R_EXA_TITLE2" Description="검토2" Literal="true"/></ritem>
				<ritem id="r1001" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text10" LangCode="C_R_EXA_TITLE1" Description="검토1" Literal="true"/></ritem>
				<ritem id="emp1" seq="1" disabled="true" change="false" validation="true"><Ctl:Text runat="server" ID="Text11" LangCode="C_R_EMP_TITLE2" Description="담당" Literal="true"/></ritem>
			</list>
            <list id="multi" type="agree">
				<tab id="emp1" seq="0" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev10" LangCode="ChargerAfterAgree" Description="담당후협조" Literal="true"/></tbtitle></tab>
				<tab id="r1001" seq="1" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev11" LangCode="ConsiderAfterAgree1" Description="검토1후협조" Literal="true"/></tbtitle></tab>
				<tab id="r1002" seq="2" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev12" LangCode="ConsiderAfterAgree2" Description="검토2후협조" Literal="true"/></tbtitle></tab>
				<tab id="r1003" seq="3" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev13" LangCode="ConsiderAfterAgree3" Description="검토3후협조" Literal="true"/></tbtitle></tab>
                <tab id="r1003" seq="4" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev14" LangCode="ConsiderAfterAgree4" Description="검토4후협조" Literal="true"/></tbtitle></tab>
                <tab id="r1003" seq="5" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev15" LangCode="ConsiderAfterAgree5" Description="검토5후협조" Literal="true"/></tbtitle></tab>
                <tab id="r1003" seq="6" img="org_btbg01"><tbtitle><Ctl:Text runat="server" ID="tAfterRev16" LangCode="ConsiderAfterAgree6" Description="검토6후협조" Literal="true"/></tbtitle></tab>
				<item id="emp1_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
				<item id="r1001_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
				<item id="r1002_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
				<item id="r1003_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
                <item id="r1004_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
                <item id="r1005_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
                <item id="r1006_after" type="agree" min="0" max="0" size="5">
					<lstitle><asp:literal runat="server" text=""/></lstitle>
				</item>
			</list>
		</tab>
	</ui>
</root>