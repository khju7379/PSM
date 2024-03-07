<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrgMap.aspx.cs" Inherits="TaeYoung.Portal.Common.OrgChart.OrgMap" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8" />
<script type="text/javascript" language="javascript" src="/Resources/Script/Domain.js"></script>

<%--Note: Ext gray 테마--%>
<link rel="stylesheet" type="text/css" href="common/ext/resources/css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="common/ext/resources/css/xtheme-gray.css" />

<script type="text/javascript" src="common/ext/adapter/ext/ext-base.js"></script>
<%--Note: Ext에 prototypejs를 쓸수 있지만 테스트 결과 약간 이상한 동작을 할 때가 있는 거 같음--%>
<%--<script type="text/javascript" src="common/ext/adapter/prototype/prototype.js"></script>
<script type="text/javascript" src="common/ext/adapter/prototype/scriptaculous.js?load=effects"></script>
<script type="text/javascript" src="common/ext/adapter/prototype/ext-prototype-adapter.js"></script>--%>

<%--Note: Ext 버전 2.2--%>
<script type="text/javascript" src="common/ext/ext-all.js"></script>
<%--Note: Ext Debug용 파일--%>
<%--<script type="text/javascript" src="common/ext/ext-all-debug.js"></script>--%>
<script type="text/javascript" language="javascript" src="/Portal/Common/LanguageJS.aspx"></script>
<script type="text/javascript" src="common/ext/ext-ux.js"></script>
<%--<script type="text/javascript" src="common/ext/locale/ext-lang-ko.js"></script>--%>
<script type="text/javascript" src="common/orgmap.resource.js"></script>
<script type="text/javascript" src="common/GW.Presence.js"></script>

<script type="text/javascript" src="/Resources/Framework/jquery-1.10.2.min.js"></script>
<%--<script src="common/Common.js" language="javascript" type="text/javascript"></script>--%>
<script type="text/javascript">
    // 다국어 처리
    var params = Ext.urlDecode(window.location.search.substring(1));
    var g_langCode = "<%= this.GetLangCode() %>".toLowerCase();
    if (params.langCode) {
        g_langCode = params.langCode;
    }

    var extLocale = g_langCode;
    if (extLocale.toLowerCase() == 'zh' || extLocale.toLowerCase() == 'cn') extLocale = 'zh_CN';

    var s = document.createElement("script");
    s.type = 'text/javascript';
    s.src = "common/ext/locale/ext-lang-" + extLocale + ".js";
    document.getElementsByTagName("head")[0].appendChild(s);

    // LoadMask를 center로
    function MoveCenterLoadMask() {
        var body = Ext.getBody();
        var width = body.dom.clientWidth;
        if (width) {
            var loadmask = Ext.get('loading');
            if (width <= 750) {
                if (width >= 300) {
                    loadmask.applyStyles('left:40%;');
                } else {
                    loadmask.applyStyles('left:30%;');
                }
            }
        }
    }
</script>
<link rel="stylesheet" type="text/css" href="common/orgmap.css" />
<script type="text/javascript" src="common/orgmap.common.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="loading-mask" style=""></div>
        <div id="loading">
            <div class="loading-indicator"><img src="common/ext/resources/images/default/shared/blue-loading.gif" onload="MoveCenterLoadMask();" width="32" height="32" style="margin-right:8px;" align="absmiddle"/>Loading...</div>
        </div>
        <div></div>
    </form>
</body>
</html>
