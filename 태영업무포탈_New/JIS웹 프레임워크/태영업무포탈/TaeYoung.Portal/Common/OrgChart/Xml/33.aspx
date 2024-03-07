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
	        <tbtitle><Ctl:Text runat="server" ID="Text14" Text="결재선 지정" LangCode="SetLine" Description="결재선 지정" Literal="true"/></tbtitle> 
	    </tab>
	    <tab id="left_tab02" visible="true" img="btbg01" src="/ENF/OrgChart/MyLine.aspx" framename="">
	        <tbtitle><Ctl:Text runat="server" ID="Text15" Text="결재선 보관" LangCode="MyLine" Description="결재선 보관" Literal="true"/></tbtitle> 
	    </tab>
	</select>
	<ui seq="0">
		<tab id="tab01" img="org_btbg02" type="approveragree">
			<tbtitle>
                <Ctl:Text runat="server" ID="tC_TB_TITLE1" LangCode="TTILE02" Description="발신" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text18" Text="결재자" LangCode="C_TB_TITLE3" Description="결재자" Literal="true"/>--%>
            </tbtitle>
			<list id="approval_0" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="txtLTITLE01" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text19" Text="담당자" LangCode="C_LS_TITLE1" Description="담당자" Literal="true"/>--%>
                </lstitle>
				<ritem id="app0" seq="0" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="tC_R_APP_TITLE1" LangCode="ORG_C_R_APP_TITLE1" Text="승인" Description="승인" Literal="true"/></ritem>
				<ritem id="r0001" seq="0" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="tC_R_EXA_TITLE1" LangCode="ORG_C_R_EXA_TITLE1" Text="검토1" Description="검토1" Literal="true"/></ritem>
				<ritem id="emp0" seq="0" disabled="true" change="false" validation="true"><Ctl:Text runat="server" ID="tC_R_EMP_TITLE1" LangCode="ORG_C_R_EMP_TITLE1" Text="기안" Description="기안" Literal="true"/></ritem>
			</list>
		</tab>
		<tab id="tab02" img="org_btbg01" type="charge">
			<tbtitle>
                <Ctl:Text runat="server" ID="txtTTILE01" LangCode="TTILE03" Description="수신" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text31" Text="담당자" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" />--%>
            </tbtitle>
			<list id="charge" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="Text1" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text32" Text="담당자" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" />--%>
                </lstitle>
				<ritem id="emp1" seq="1" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="Text30" Text="담당" LangCode="C_R_EMP_TITLE2" Description="담당" Literal="true" /></ritem>
			</list>
		</tab>
	</ui>
	<ui seq="1">
		<tab id="tab01" img="org_btbg02" type="charge">
			<tbtitle>
                <Ctl:Text runat="server" ID="Text3" LangCode="TTILE02" Description="발신" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text1" Text="결재자" LangCode="C_TB_TITLE3" Description="결재자" Literal="true"/>--%>
            </tbtitle>
			<list id="charge" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="Text5" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text2" Text="담당자" LangCode="C_LS_TITLE1" Description="담당자" Literal="true"/>--%>
                </lstitle>
				<ritem id="app1" seq="1" disabled="true" change="true" validation="fasle"><Ctl:Text runat="server" ID="Text4" LangCode="C_R_APP_TITLE1" Text="승인" Description="승인" Literal="true"/></ritem>
				<ritem id="r1001" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text10" LangCode="C_R_EXA_TITLE1" Text="검토1" Description="검토1" Literal="true"/></ritem>
				<ritem id="emp1" seq="1" disabled="true" change="false" validation="true"><Ctl:Text runat="server" ID="Text11" LangCode="C_R_EMP_TITLE2" Text="담당" Description="담당" Literal="true"/></ritem>
			</list>
		</tab>
	</ui>
</root>