<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetLineMain.aspx.cs" Inherits="TaeYoung.Portal.Common.OrgChart.SetLineMain" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" type="text/css" href="Common/ext/resources/css/ext-all.css" />
    <link rel="stylesheet" type="text/css" href="Common/ext/resources/css/xtheme-gray.css" />
    <link rel="stylesheet" type="text/css" href="Common/SetLine.Common.css" />
    
</head>
<body>
    <script type="text/javascript" language="javascript" src="/Resources/Script/Domain.js"></script>
    <%--<script type="text/javascript" language="javascript" src="Common/ext/adapter/ext/ext-base.js"></script>--%>
    <script type="text/javascript" language="javascript" src="/Resources/Framework/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" language="javascript" src="Common/ext/adapter/jquery/ext-jquery-adapter.js"></script>
    
    <%--<script type="text/javascript" language="javascript" src="Common/ext/ext-all.js"></script>--%>
    <script type="text/javascript" language="javascript" src="Common/ext/ext-all-debug.js"></script>
    
    <script type="text/javascript" language="javascript" src="Common/ext/ext-ux.js"></script>
    <script type="text/javascript" language="javascript">
        // 다국어 처리
        var g_langCode = '<%= LangCode %>'.toLowerCase(); //'ko';

        var params = Ext.urlDecode(window.location.search.substring(1));

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
    <script type="text/javascript" language="javascript" src="/Approval/Common/Scripts/LanguageJS.aspx"></script>
    <script type="text/javascript" language="javascript" src="Common/SetLine.Resource.js"></script>
    <script type="text/javascript" language="javascript" src="Common/SetLine.Common.js"></script>
    <script type="text/javascript" language="javascript" src="Common/Recipients.js"></script>
    <script type="text/javascript" language="javascript">
        // 승인후 협조 라인 추가에 따른 협조탭명 변경 로직 추가 (2016-12-14 장윤호)
        var nodes = Awx.documentElement.childNodes;             // Awx의 자식 노드들
        var node = null;                                        // fields 노드
        var line = "";                                          // line명
        // 노드의 7번째가 fields 면 ok 아니면 루프를 돌면서 fields를 찾음
        if (nodes[7].nodeName.toLowerCase() == "fields") {
            node = nodes[7];
        } else {
            for (var i = 0; i < nodes.length; i++) {
                if (nodes[i].nodeName.toLowerCase() == "fields") {
                    node = nodes[7];
                    break;
                }
            }
        }

        var taskid = Awx.documentElement.getElementsByTagName("CurrentUser")[0].attributes["TaskID"].value;
        var seq = "";
        switch (taskid) {
            case "emp0":
            case "r0001":
            case "r0002":
            case "r0003":
            case "r0004":
            case "r0005":
            case "r0006":
            case "app0":
                seq = "0";
                break;
            case "emp1":
            case "r1001":
            case "r1002":
            case "r1003":
            case "r1004":
            case "r1005":
            case "r1006":
            case "app1":
                seq = "1";
                break;
            case "emp2":
            case "r2001":
            case "r2002":
            case "r2003":
            case "r2004":
            case "r2005":
            case "r2006":
            case "app2":
                seq = "2";
                break;
        }

        // fields를 정상적으로 찾았을시 line 정보를 찾아 line에 맞는 협조탭의 명을 수정
        // GW.SetLine.Resource 는 /Portal/Common/OrgChart/Common/SetLine.Resource.js 에서 생성
        if (node != null) {
            line = node.attributes["SetLine"].value.split(";")[0];

            // 4M 변경검토 의뢰서(업체) 사용
            if (line == "168A") {
                if (seq == "1") {
                    GW.SetLine.Resource.AfterRev5_ko = "승인 후";
                    GW.SetLine.Resource.AfterRev5_en = "After approve review";
                    GW.SetLine.Resource.AfterRev5_es = "After approve review";
                    GW.SetLine.Resource.AfterRev5_cn = "승인 후";
                }
            }
            else if (line == "861A") {
                if (seq == "1") {
                    GW.SetLine.Resource.AfterRev5_ko = "승인 후";
                    GW.SetLine.Resource.AfterRev5_en = "After approve review";
                    GW.SetLine.Resource.AfterRev5_es = "After approve review";
                    GW.SetLine.Resource.AfterRev5_cn = "승인 후";
                }
            }
            else if (line == "780A") {
                if (seq == "0") {
                    GW.SetLine.Resource.AfterRev6_ko = "승인 후";
                    GW.SetLine.Resource.AfterRev6_en = "After approve review";
                    GW.SetLine.Resource.AfterRev6_es = "After approve review";
                    GW.SetLine.Resource.AfterRev6_cn = "승인 후";
                }
            }
            else if (line == "700A") {
                if (seq == "0") {
                    GW.SetLine.Resource.AfterRev6_ko = "승인 후";
                    GW.SetLine.Resource.AfterRev6_en = "After approve review";
                    GW.SetLine.Resource.AfterRev6_es = "After approve review";
                    GW.SetLine.Resource.AfterRev6_cn = "승인 후";
                }
            }
            else if (line == "133A") {
                if (seq == "1") {
                    GW.SetLine.Resource.AfterRev2_ko = "승인 후";
                    GW.SetLine.Resource.AfterRev2_en = "After approve review";
                    GW.SetLine.Resource.AfterRev2_es = "After approve review";
                    GW.SetLine.Resource.AfterRev2_cn = "승인 후";
                }
            }
            // 품질신고서 및 평가 기준서 사용
            else if (line == "133QDS") {
                if (seq == "1") {
                    GW.SetLine.Resource.ValidationCheck_ko = "수신 담당 (한영민 사원) 지정 후 진행 하십시오.";
                    GW.SetLine.Resource.ValidationCheck_en = "수신 담당 (한영민 사원) 지정 후 진행 하십시오.";
                    GW.SetLine.Resource.ValidationCheck_es = "수신 담당 (한영민 사원) 지정 후 진행 하십시오.";
                    GW.SetLine.Resource.ValidationCheck_cn = "수신 담당 (한영민 사원) 지정 후 진행 하십시오.";
                }
            }
        }
    </script>
    
    <form id="form1" runat="server">
        <div id="loading-mask" style=""></div>
        <div id="loading"></div>
        <div></div>
    </form>
</body>
</html>
