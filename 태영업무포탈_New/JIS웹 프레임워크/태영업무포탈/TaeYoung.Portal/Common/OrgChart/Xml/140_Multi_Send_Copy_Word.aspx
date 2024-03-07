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
	    <tab id="left_tab01" visible="true" img="btbg02" src="/ENF/OrgChart/Org.aspx" framename="hiframeRight">
	        <tbtitle><Ctl:Text runat="server" ID="Text14" LangCode="SetLine" Description="결재선 지정" Literal="true"/></tbtitle> 
	    </tab>
	    <tab id="left_tab02" visible="true" img="btbg01" src="/ENF/OrgChart/MyLine.aspx" framename="">
	        <tbtitle><Ctl:Text runat="server" ID="Text15" LangCode="MyLine" Description="결재선 보관" Literal="true"/></tbtitle> 
	    </tab>
	</select>
	<ui seq="0">
		<tab id="tab02" img="org_btbg01" type="charge">
			<tbtitle>
                <Ctl:Text runat="server" ID="Text5" LangCode="TTILE03" Description="수신" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text28" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" />--%>
            </tbtitle>
			<list id="charge" type="normal" size="1">
				<lstitle>
                    <Ctl:Text runat="server" ID="txtLTITLE01" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text29" LangCode="C_TB_TITLE4" Description="담당자" Literal="true" />--%>
                </lstitle>
				<ritem id="emp1" seq="1" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="Text30" LangCode="C_R_EMP_TITLE2" Description="담당" Literal="true" /></ritem>
			</list>
		</tab>
	</ui>
    <ui seq="1">
		<tab id="tab01" img="org_btbg02" type="approveragree">
			<tbtitle>
                <Ctl:Text runat="server" ID="txtTTILE01" LangCode="TTILE01" Description="발신 및 협조" Literal="true"/>
                <%--<Ctl:Text runat="server" ID="Text12" LangCode="C_TB_TITLE3" Description="결재자" Literal="true"/>--%>
            </tbtitle>
			<list id="approval" type="normal">
				<lstitle>
                    <Ctl:Text runat="server" ID="Text6" LangCode="LTITLE01" Description="결재자" Literal="true"/>
                    <%--<Ctl:Text runat="server" ID="Text13" LangCode="C_LS_TITLE1" Description="담당자" Literal="true"/>--%>
                </lstitle>
				<ritem id="app1" seq="1" disabled="true" change="true" validation="fasle"><Ctl:Text runat="server" ID="Text4" LangCode="C_140_APP_TITLE1" Description="공정검사" Literal="true"/></ritem>
                <ritem id="r1002" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text9" LangCode="C_140_EXA_TITLE2" Description="생산관리" Literal="true"/></ritem>
				<ritem id="r1001" seq="1" disabled="true" change="true" validation="false"><Ctl:Text runat="server" ID="Text10" LangCode="C_140_EXA_TITLE1" Description="입고검사" Literal="true"/></ritem>
				<ritem id="emp1" seq="1" disabled="true" change="true" validation="true"><Ctl:Text runat="server" ID="Text11" LangCode="C_140_EMP_TITLE2" Description="업체협력" Literal="true"/></ritem>
			</list>
            <list id="multi" type="agree">
				<tab id="emp1" seq="0" img="org_btbg01"><tbtitle>담당후협조</tbtitle></tab>
				<tab id="r1001" seq="1" img="org_btbg01"><tbtitle>검토1후협조</tbtitle></tab>
				<tab id="r1002" seq="2" img="org_btbg01"><tbtitle>검토2후협조</tbtitle></tab>
				<item id="emp1_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
				<item id="r1001_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
				<item id="r1002_after" type="agree" min="0" max="0" size="5">
					<lstitle></lstitle>
				</item>
			</list>
		</tab>
        <tab id="tab02" img="org_btbg01" type="acl">
			<tbtitle><Ctl:Text runat="server" ID="Text1" LangCode="C_TB_TITLE2" Description="수신처" Literal="true"/></tbtitle>
			<%--<tbtitle><Ctl:Text runat="server" ID="Text5" LangCode="C_TB_TITLE2" Description="수신처/사본처" Literal="true"/></tbtitle>--%>
			<list id="send" type="sendto" min="0" max="0" size="8">
				<lstitle><Ctl:Text runat="server" ID="Text2" LangCode="C_LS_TITLE3" Description="수신처" Literal="true"/></lstitle>
			</list>
            <list id="copy" type="sendto" min="0" max="0" size="8">
				<lstitle><Ctl:Text runat="server" ID="Text3" LangCode="C_LS_TITLE4" Description="사본처" Literal="true"/></lstitle>
			</list>
		</tab>
	</ui>
</root>