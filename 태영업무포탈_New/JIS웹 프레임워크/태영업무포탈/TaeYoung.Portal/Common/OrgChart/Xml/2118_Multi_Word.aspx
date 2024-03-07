<?xml version="1.0" encoding="utf-8" ?>
<%@ Page Language="C#" CodeBehind="XsltBase.aspx.cs" Inherits="TaeYoung.Approval.Form.Xslt.XsltBase"%>
<script runat="server">
protected override void InitializeCulture()
{
	if(!string.IsNullOrEmpty(Request.Params["_culture"]))
	{
		if (Request.Params["_culture"].Equals("zh"))
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
	    <tab id="left_tab02" visible="true" img="btbg01" src="/ENF/OrgChart/MyLine.aspx" framename="">
	        <tbtitle><Ctl:Text runat="server" ID="Text15" LangCode="MyLine" Description="결재선 보관" Literal="true"/></tbtitle> 
	    </tab>
	</select>
	<ui seq="0">
        <tab id="tab01" img="org_btbg02" type="approveragree">
		    <tbtitle>
                <Ctl:Text runat="server" ID="tC_TB_TITLE1" LangCode="TTILE01" Description="발신 및 협조" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text4" LangCode="C_TB_TITLE3" Description="결재자" Literal="true"/>--%>
            </tbtitle>
			<list id="approval" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="txtLTITLE01" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text7" LangCode="C_LS_TITLE1" Description="결재자" Literal="true"/>--%>
                </lstitle>
                <ritem id="app0" seq="0" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="tC_R_APP_TITLE1" LangCode="ORG_C_R_APP_TITLE1" Description="승인" Literal="true"/></ritem>
				<ritem id="emp0" seq="0" disabled="true" change="false" validation="true"><Ctl:Text runat="server" ID="tC_R_EMP_TITLE1" LangCode="ORG_C_R_EMP_TITLE1" Description="기안" Literal="true"/></ritem>
			</list>
            <list id="multi" type="agree">
				<tab id="emp0" seq="0" img="org_btbg01"><tbtitle>기안후협조</tbtitle></tab>
				<item id="emp0_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
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
                    <Ctl:Text runat="server" ID="Text7" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text29" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" />--%>
                </lstitle>
				<ritem id="emp1" seq="1" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="Text30" LangCode="C_R_EMP_TITLE2" Description="담당" Literal="true" /></ritem>
			</list>
		</tab>
	</ui>
    <ui seq="1">
		<tab id="tab01" img="org_btbg02" type="approveragree">
			<tbtitle>
                <Ctl:Text runat="server" ID="Text4" LangCode="TTILE01" Description="발신 및 협조" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text12" LangCode="C_TB_TITLE3" Description="결재자" Literal="true"/>--%>
            </tbtitle>
            <list id="multi" type="agree">
				<tab id="emp1" seq="0" img="org_btbg01"><tbtitle>담당후협조</tbtitle></tab>
				<item id="emp1_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
			</list>
		</tab>
        <tab id="tab02" img="org_btbg01" type="charge">
			<tbtitle>
                <Ctl:Text runat="server" ID="Text1" LangCode="TTILE03" Description="수신" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text31" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" />--%>
            </tbtitle>
			<list id="charge" type="normal" size="1">
				<lstitle>
                    <Ctl:Text runat="server" ID="Text11" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text32" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" />--%>
                </lstitle>
				<ritem id="emp2" seq="2" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="Text33" LangCode="C_R_EMP_TITLE2" Description="담당" Literal="true" /></ritem>
			</list>
		</tab>
	</ui>
    <ui seq="2">
		<tab id="tab01" img="org_btbg02" type="approveragree">
			<tbtitle>
                <Ctl:Text runat="server" ID="Text8" LangCode="TTILE01" Description="발신 및 협조" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text18" LangCode="C_TB_TITLE3" Description="결재자" Literal="true"/>--%>
            </tbtitle>
            <list id="multi" type="agree">
				<tab id="emp2" seq="0" img="org_btbg01"><tbtitle>담당후협조</tbtitle></tab>
				<item id="emp2_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
			</list>
		</tab>
        <tab id="tab02" img="org_btbg01" type="charge">
			<tbtitle>
                <Ctl:Text runat="server" ID="Text10" LangCode="TTILE03" Description="수신" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text37" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" />--%>
            </tbtitle>
			<list id="charge" type="normal" size="1">
				<lstitle>
                    <Ctl:Text runat="server" ID="Text12" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text38" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" />--%>
                </lstitle>
				<ritem id="emp3" seq="3" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="Text39" LangCode="C_R_EMP_TITLE2" Description="담당" Literal="true" /></ritem>
			</list>
		</tab>
	</ui>
    <ui seq="3">
		<tab id="tab01" img="org_btbg02" type="approveragree">
			<tbtitle>
                <Ctl:Text runat="server" ID="Text9" LangCode="TTILE01" Description="발신 및 협조" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text1" LangCode="C_TB_TITLE3" Description="결재자" Literal="true"/>--%>
            </tbtitle>
            <list id="approval" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="Text13" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text5" LangCode="C_LS_TITLE1" Description="담당자" Literal="true"/>--%>
                </lstitle>
				<ritem id="app3" seq="3" disabled="true" change="true" validation="fasle"><Ctl:Text runat="server" ID="Text6" LangCode="C_R_APP_TITLE1" Description="승인" Literal="true"/></ritem>
                <ritem id="r3006" seq="3" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text16" LangCode="C_R_EXA_TITLE6" Description="검토6" Literal="true"/></ritem>
                <ritem id="r3005" seq="3" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text17" LangCode="C_R_EXA_TITLE5" Description="검토5" Literal="true"/></ritem>
                <ritem id="r3004" seq="3" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text34" LangCode="C_R_EXA_TITLE4" Description="검토4" Literal="true"/></ritem>
                <ritem id="r3003" seq="3" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text35" LangCode="C_R_EXA_TITLE3" Description="검토3" Literal="true"/></ritem>
                <ritem id="r3002" seq="3" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text36" LangCode="C_R_EXA_TITLE2" Description="검토2" Literal="true"/></ritem>
				<ritem id="r3001" seq="3" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text2" LangCode="C_R_EXA_TITLE1" Description="검토1" Literal="true"/></ritem>
				<ritem id="emp3" seq="3" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="Text3" LangCode="C_R_EMP_TITLE2" Description="담당" Literal="true"/></ritem>
			</list>
            <list id="multi" type="agree">
				<tab id="emp3" seq="0" img="org_btbg01"><tbtitle>담당후협조</tbtitle></tab>
				<tab id="r3001" seq="1" img="org_btbg01"><tbtitle>검토1후협조</tbtitle></tab>
				<tab id="r3002" seq="2" img="org_btbg01"><tbtitle>검토2후협조</tbtitle></tab>
				<tab id="r3003" seq="3" img="org_btbg01"><tbtitle>검토3후협조</tbtitle></tab>
                <tab id="r3004" seq="4" img="org_btbg01"><tbtitle>검토4후협조</tbtitle></tab>
                <tab id="r3005" seq="5" img="org_btbg01"><tbtitle>검토5후협조</tbtitle></tab>
                <tab id="r3006" seq="6" img="org_btbg01"><tbtitle>검토6후협조</tbtitle></tab>
				<item id="emp3_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
				<item id="r3001_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
				<item id="r3002_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
				<item id="r3003_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
                <item id="r3004_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
                <item id="r3005_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
                <item id="r3006_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
			</list>
		</tab>
	</ui>
</root>