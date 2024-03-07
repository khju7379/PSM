<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrgChart.aspx.cs" Inherits="TaeYoung.Portal.OrgChart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <%--<link rel="stylesheet" type="text/css" href="/Resources/Css/GW_Import.css" />--%>
    <link rel="stylesheet" type="text/css" href="/Resources/Css/Control.css" />

    <title></title>
    <style type="text/css">
        body
        {
            text-align: center;
            height: auto;
        }
        #wapper
        {
            position: relative;
            width: 100%;
        }
        #wapper #title2
        {
            position: fixed;
            top: 0px;
            left: 0px;
            width: 100%;
            height: 79px;
            font-size: 35px;
            color: #FFFFFF;
            line-height: 79px;
            text-align: center;
            border-bottom: 1px solid #37414B;
            background: #464B5A;
            z-index: 50;
        }
        #wapper #topBar
        {
            position: fixed;
            top: 80px;
            left: 30px;
            /*width: 260px;*/
            width: 320px;
            /*height: 30px;*/
            background: #464B5A;
            border: 1px solid #37414B;
            border-top: none;
            z-index: 50;
            border-radius: 0 0 5px 5px;
            -webkit-border-radius: 0 0 5px 5px;
            -moz-border-radius: 0 0 5px 5px;
            text-align: center;
        }
        
        #wapper #topBar ul
        {
            text-align: center;
            width: 100%;
            height: 100%;
        }
        #wapper #topBar ul > li
        {
            display: table-cell;
            padding: 6px 3px 6px 3px;
            width: 33px;
        }
        #wapper #topBar ul > li > img
        {
            cursor:pointer;
        }
        
        #wapper #content_bx
        {
            position: relative;
            margin-top: 100px;
        }
        
        /*Now the CSS*/
        #OrgChart,#OrgChart_Sub
        {
            /* 중앙 정렬 */
            float:left;
            width:100%;
            padding-right:20px;
            padding-left:25px;
            margin:0 auto;
            text-align:center;
        }
        .tree ul
        {
            padding-top: 20px;
            position: relative;
            transition: all 0.5s;
            -webkit-transition: all 0.5s;
            -moz-transition: all 0.5s;
        }
        
        .tree ul > li
        {
            text-align: center;
            list-style-type: none;
            position: relative;
            padding: 20px 5px 0 5px;
            transition: all 0.5s;
            -webkit-transition: all 0.5s;
            -moz-transition: all 0.5s;
            display: table-cell;
            vertical-align: top;
        }
        
        #OrgChart>ul>li,#OrgChart_Sub>ul>li
        {
            display:inline-block;
        }
        
        .tree li::before, .tree li::after
        {
            content: '';
            position: absolute;
            top: 0;
            right: 50%;
            border-top: 1px solid #ccc;
            width: 50%;
            height: 20px;
            z-index: 0;
        }
        .tree li::after
        {
            right: auto;
            left: 50%;
            border-left: 1px solid #ccc;
        }
        
        .tree ul > li.step2
        {
            text-align: center;
            list-style-type: none;
            position: relative;
            padding: 220px 5px 0 5px;
            transition: all 0.5s;
            -webkit-transition: all 0.5s;
            -moz-transition: all 0.5s;
            display: table-cell;
            vertical-align: top;
        }
        .tree li.step2::before, .tree li.step2::after
        {
            content: '';
            position: absolute;
            top: 0;
            right: 50%;
            border-top: 1px solid #ccc;
            width: 50%;
            height: 220px;
            z-index: 0;
        }
        .tree ul > li.step3
        {
            text-align: center;
            list-style-type: none;
            position: relative;
            padding: 414px 5px 0 5px;
            transition: all 0.5s;
            -webkit-transition: all 0.5s;
            -moz-transition: all 0.5s;
            display: table-cell;
            vertical-align: top;
        }
        .tree li.step3::before, .tree li.step3::after
        {
            content: '';
            position: absolute;
            top: 0;
            right: 50%;
            border-top: 1px solid #ccc;
            width: 50%;
            height: 420px;
            z-index: 0;
        }
        .tree ul > li.step4
        {
            text-align: center;
            list-style-type: none;
            position: relative;
            padding: 611px 5px 0 5px;
            transition: all 0.5s;
            -webkit-transition: all 0.5s;
            -moz-transition: all 0.5s;
            display: table-cell;
            vertical-align: top;
        }
        .tree li.step4::before, .tree li.step4::after
        {
            content: '';
            position: absolute;
            top: 0;
            right: 50%;
            border-top: 1px solid #ccc;
            width: 50%;
            height: 620px;
            z-index: 0;
        }
        /*Remove left connector from first child and 
        right connector from last child*/
        .tree li:first-child::before, .tree li:last-child::after
        {
            border: 0 none;
        }
        /*Adding back the vertical connector to the last nodes*/
        .tree li:last-child::before
        {
            border-right: 1px solid #ccc;
            border-radius: 0 5px 0 0;
            -webkit-border-radius: 0 5px 0 0;
            -moz-border-radius: 0 5px 0 0;
        }
        .tree li:first-child::after
        {
            border-radius: 5px 0 0 0;
            -webkit-border-radius: 5px 0 0 0;
            -moz-border-radius: 5px 0 0 0;
        }
        
        .tree ul.root > li:only-child::after, .tree ul.root > li:only-child::before
        {
            display: none;
        }
        
        /*We need to remove left-right connectors from elements without 
        any siblings*/
        .tree li:only-child::after
        {
            border-left: 1px solid #ccc;
            border-radius: 0 0 0 0;
            -webkit-border-radius: 0 0 0 0;
            -moz-border-radius: 0 0 0 0;
        }
        .tree li:only-child::before
        {
            border: 0 none;
            border-radius: 0 0 0 0;
            -webkit-border-radius: 0 0 0 0;
            -moz-border-radius: 0 0 0 0;
        }
        
        /*Remove space from the top of single children*/
        .tree li:only-child
        {
            padding-left: 5px;
            padding-top: 22px;
        }
        
        
        /*Time to add downward connectors from parents*/
        .tree ul ul::before
        {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            border-left: 1px solid #ccc;
            width: 0;
            height: 20px;
        }
        
        .tree li a
        {
            border: 1px solid #ccc;
            text-decoration: none;
            color: #666;
            font-size: 11px;
            display: inline-block;
            border-radius: 5px;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            transition: all 0.5s;
            -webkit-transition: all 0.5s;
            -moz-transition: all 0.5s;
            background: #FFFFFF;
        }
        .ceo
        {
            border: 1px solid #ccc;
            text-decoration: none;
            color: #666;
            font-size: 11px;
            display: inline-block;
            border-radius: 5px;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            transition: all 0.5s;
            -webkit-transition: all 0.5s;
            -moz-transition: all 0.5s;
            float: left;
            margin: 15px;
        }
        .ceo_title
        {
            width: 300px;
            height: 90px;
            text-align: center;
            line-height: 90px;
            font-size: 18px;
            font-weight: bold;
            background: #4B64A0;
            color: #FFFFFF;
            vertical-align: middle;
        }
        
        .tree li table
        {
            width: 100px;
        }
        .tree li table th
        {
            background: rgba(200,200,200,0.1);
            border-right: 1px solid #EAEAEA;
            border-bottom: 1px solid #EAEAEA;
            padding-top: 2px;
            padding-bottom: 2px;
        }
        .tree li table td
        {
            border-bottom: 1px solid #EAEAEA;
            padding-top: 2px;
            padding-bottom: 2px;
        }
        
        /*Time for some hover effects*/
        /*We will apply the hover effect the the lineage of the element also*/
        .tree li a
        {
            cursor: default;
        }
        .tree li a:hover, .tree li a:hover + ul li a
        {
            background: #c8e4f8;
            color: #000;
            border: 1px solid #94a0b4;
        }
        /*Connector styles on hover*/
        .tree li a:hover + ul li::after, .tree li a:hover + ul li::before, .tree li a:hover + ul::before, .tree li a:hover + ul ul::before
        {
            border-color: #94a0b4;
        }
        .tree li a div.user, .tree li a div.user_team, .tree li a div.user_sil
        {
            width: 90px;
            height: 155px;
            position: relative;
            z-index: 1;
        }
        .tree li a div.user_duty_ceo
        {
            border-radius: 5px 5px 0px 0px;
            -moz-border-radius: 5px 5px 0px 0px;
            -webkit-border-radius: 5px 5px 0px 0px;
            background: #4B64A0;
            color: #FFFFFF;
            width: 100%;
            height: 35px;
            line-height: 15px;
            padding-top: 5px;
        }
        
        .tree li a div.user_duty
        {
            cursor: pointer;
            border-radius: 5px 5px 0px 0px;
            -moz-border-radius: 5px 5px 0px 0px;
            -webkit-border-radius: 5px 5px 0px 0px;
            background: #3278D2;
            color: #FFFFFF;
            width: 100%;
            height: 25px;
            line-height: 25px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .tree li a div.user_duty_team
        {
        }
        .tree li a div.user_rank
        {
            color: #505050;
            width: 100%;
            height: 15px;
            line-height: 15px;
        }
        .tree li a div.user_image
        {
           /* border-radius: 39px 39px 39px 39px;
            -moz-border-radius: 39px 39px 39px 39px;
            -webkit-border-radius: 39px 39px 39px 39px;*/
            border-radius: 3px 3px 3px 3px;
            -moz-border-radius: 3px 3px 3px 3px;
            -webkit-border-radius: 3px 3px 3px 3px;
            width: 78px;
            height: 78px;
            margin: 6px 6px 6px 6px;
            cursor: pointer;
        }
        .tree li a div.user_name
        {
            font-size: 15px;
            position: relative;
        }
        
        .tree li a div.user_name div.addjob
        {
            position: absolute;
            background: url('/Resources/Images/Icon/addj2.png') no-repeat center center;
            width: 16px;
            height: 16px;
            top: 0px;
            left: 5px;
        }
        
        
        /**/
        .tree li a div.user_sil div.user_duty
        {
            cursor: pointer;
            border-radius: 5px 5px 0px 0px;
            -moz-border-radius: 5px 5px 0px 0px;
            -webkit-border-radius: 5px 5px 0px 0px;
            background: #179F8B;
            color: #FFFFFF;
            width: 100%;
            height: 25px;
            line-height: 25px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .tree li a div.user_team div.user_duty
        {
            border-radius: 5px 5px 0px 0px;
            -moz-border-radius: 5px 5px 0px 0px;
            -webkit-border-radius: 5px 5px 0px 0px;
            background: #77AF3B;
            color: #FFFFFF;
            width: 100%;
            height: 25px;
            line-height: 25px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .tree li a div.user_part2 div.user_duty
        {
            border-radius: 5px 5px 0px 0px;
            -moz-border-radius: 5px 5px 0px 0px;
            -webkit-border-radius: 5px 5px 0px 0px;
            background: #E890B6;
            color: #FFFFFF;
            width: 100%;
            height: 25px;
            line-height: 25px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .tree li a div.user_part
        {
            width: 90px;
            height: 45px;
            position: relative;
        }
        
        .tree li a div.user_part div.user_duty
        {
            border-radius: 5px 5px 5px 5px;
            -moz-border-radius: 5px 5px 5px 5px;
            -webkit-border-radius: 5px 5px 5px 5px;
            background: #E890B6; /*#D23278;*/
            color: #FFFFFF;
            width: 100%;
            height: 45px;
            line-height: 45px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .tree li a div.user_part div.user_rank
        {
            color: #505050;
            width: 100%;
            height: 15px;
            line-height: 15px;
            display: none;
        }
        .tree li a div.user_part div.user_image
        {
            border-radius: 39px 39px 39px 39px;
            -moz-border-radius: 39px 39px 39px 39px;
            -webkit-border-radius: 39px 39px 39px 39px;
            width: 78px;
            height: 78px;
            margin: 6px 6px 6px 6px;
            display: none;
        }
        .tree li a div.user_part div.user_name
        {
            font-size: 15px;
            display: none;
        }
        
        .tree li a div.expand
        {
            position: absolute;
            bottom: 4px;
            right: 4px;
            width: 15px;
            height: 15px; /* border: 1px solid #000000; */
            line-height: 15px;
            font-weight: bold;
            color: blue;
            background: url('/Resources/Images/Icon/expand.png') no-repeat 50% 50%;
            cursor: pointer;
        }
        
        /*Thats all. I hope you enjoyed it.
        Thanks :)*/
        #Org_Sub
        {
            position: fixed;
            top: 0px;
            left: 0px;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.8);
            display: none;
            z-index: 50;
        }
        #Org_Sub div.close
        {
            position: fixed;
            top: 120px;
            width: 50px;
            height: 30px;
            text-align: center;
            line-height: 30px;
            font-size: 20px;
            color: #FFFFFF;
            right: 70px;
            background: rgba(0,0,0,0.8);
            cursor: pointer;
            z-index: 20;
            border-radius: 0 0 5px 5px;
            -webkit-border-radius: 0 0 5px 5px;
            -moz-border-radius: 0 0 5px 5px;
        }

        ul, ul li
        {
            list-style:none;
        }
        
        @font-face {
			font-family: NanumGothicBold;
			font-style: normal;
		   font-weight: normal;
		   src: url('/Resources/Font/NanumGothicBold.eot');
		   src: local('?'),
				url('/Resources/Font/NanumGothicBold.eot?#iefix') format('embedded-opentype'), 
				url('/Resources/Font/NanumGothicBold.ttf') format('truetype'),
				url('/Resources/Font/NanumGothicBold.otf') format('opentype'),
				url('/Resources/Font/NanumGothicBold.woff') format('woff'),
				url('/Resources/Font/NanumGothicBold.svg#NanumGothicBold') format('svg');
		}

        * {
	        margin: 0px; padding: 0px;
	        font-family: NanumGothicBold, 나눔고딕볼드, Dotum, 돋움, Gulim, 굴림, AppleGothic, Sans-serif; font-size: 12px; color: #000000; line-height: 18px;
	        word-break: keep-all;
        }
    </style>
    <script type="text/javascript" src="/Resources/Framework/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/Resources/Framework/jquery-ui.min.js"></script>
    <script type="text/javascript" src="/Resources/Script/Common.js"></script>
    <script type="text/javascript" src="/Resources/Script/Org.js"></script>
    <script type="text/javascript">

        var plant = "<%= TaeYoung.Biz.Document.UserInfo.LocationCode %>";
        var corpcd = "<%= TaeYoung.Biz.Document.UserInfo.SiteCompanyCode %>";
        var langcd = "<%= TaeYoung.Biz.Document.ClientCultureName %>";
        var regid = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
        var loginid = "<%= TaeYoung.Biz.Document.UserInfo.LoginID %>";
        var deptcd = "<%= TaeYoung.Biz.Document.UserInfo.DeptCode %>";
        var userName = "<%= TaeYoung.Biz.Document.UserInfo.UserName %>";
        var Use_Language = "<%= TaeYoung.Biz.Document.ClientCultureName %>";
        var zoomLevel = 1;
        var org_acl = "<%= ORG_ACL %>";

        $(document).bind('keydown', function (event) {
            if (event.keyCode == 107 || event.keyCode == 187) {
                ZoomOrg(0.1);
            }
            else if (event.keyCode == 109 || event.keyCode == 189) {
                ZoomOrg(-0.1);
            }
        });

        function OnLoad() {
            // 법인 콤보 바인딩
            var ht = new Object();
            ht["LANGCD"] = langcd;
            cboCOMPANYCODE.TypeName = "Common.OrgChartBiz";
            cboCOMPANYCODE.MethodName = "GetCompanyComboOrg";
            cboCOMPANYCODE.DataTextField = "COMPANY";
            cboCOMPANYCODE.DataValueField = "COMPANYCODE";
            cboCOMPANYCODE.Params(ht);
            cboCOMPANYCODE.BindList();
            cboCOMPANYCODE.SetValue(corpcd);
            //cboCOMPANYCODE.Control.find("option").eq(0).remove();

            bindTree();
        }
        function _createUser(dr) {
            //http://tos.nvhkorea.com/pilot/Thumbnail.nsf/ByEmpNo/사번/$FILE/ThumbNail.jpg
            var strHTML = "";
            strHTML += '<a value="' + dr["DEPTCODE"] + '">';
            //strHTML += '    <div class="ceo" style="width:100px; height:170px;">';
            strHTML += '        <div class="user_duty_ceo" style="line-height:30px;" onclick="openChild(this);">' + dr["RANKNAME"] + '</div>';
            strHTML += '        <div class="user_image" onclick="OrgPopup(\'' + dr["EMPID"] + '\',\'' + dr["COMPANYCODE"] + '\');" style="background: url(/Resources/Framework/OrgImageViewer.aspx?id=' + dr["EMPID"].trim() + ') 50% 10% no-repeat;"><img src="/Resources/Framework/OrgImageViewer.aspx?id=' + dr["EMPID"].trim() + '" style="width:78px;height:78px;" /></div>';
            strHTML += '        <div class="user_name">' + dr["USERNAME"] + '</div>';
            //strHTML += '        <div class="expand" onclick="OrgTreePop(\'' + dr["DEPTCODE"] + '\', \'' + dr["EMPID"] + '\')"></div>';
            //strHTML += '    </div>';
            strHTML += '</a>';

            return strHTML;
        }

        function createUser(dr, isPop) {
            var _class = "user";

            //switch (dr["ORGLEVEL"]) {
            switch (dr["ORGSORT"]) {
                case 4:
                    _class += "_sil";
                    break;
                case 5:
                    _class += "_team";
                    break;
                case 6:
                    _class += "_part";
                    break;
            }
            var strHTML = "";

            var addj = (dr["ADDJOB"] == "1") ? '<div class="addjob"></div>' : '';

            strHTML += '<a value="' + dr["DEPTCODE"] + '">';
            strHTML += '    <div class="' + _class + '">';
            strHTML += '        <div class="user_duty" onclick="openChild(this);">' + dr["DEPTNAME"] + '</div>';
            strHTML += '        <div class="user_image" onclick="OrgPopup(\'' + dr["EMPID"] + '\',\'' + dr["COMPANYCODE"] + '\');" style="background: url(/Resources/Framework/OrgImageViewer.aspx?id=' + dr["EMPID"].trim() + ') 50% 10% no-repeat;"><img src="/Resources/Framework/OrgImageViewer.aspx?id=' + dr["EMPID"].trim() + '" style="width:78px;height:78px;" /></div>';
            strHTML += '        <div class="user_rank">' + dr["RANKNAME"] + '</div>';
            strHTML += '        <div class="user_name">' + dr["USERNAME"] + addj + '</div>';
            //strHTML += (((dr["ORGSORT"] == 5 || dr["ORGSORT"] == 5) && isPop && dr["USERNAME"] != "") ? '        <div class="expand" onclick="OrgTreePop(\'' + dr["DEPTCODE"] + '\', \'' + dr["EMPID"] + '\')"></div>' : '');
            //strHTML += ((dr["ORGSORT"] > (dr["COMPANYCODE"] == "PSALES" ? 1 : 2) && isPop && dr["USERNAME"] != "") ? '        <div class="expand" onclick="OrgTreePop(\'' + dr["DEPTCODE"] + '\', \'' + dr["EMPID"] + '\')"></div>' : '');
            //strHTML += ((dr["ORGSORT"] > 1 && isPop && dr["USERNAME"] != "") ? '        <div class="expand" onclick="OrgTreePop(\'' + dr["DEPTCODE"] + '\', \'' + dr["EMPID"] + '\')"></div>' : '');
            if (dr["USERNAME"] == "") {
            }
            //else if (dr["ORGSORT"] == "1") {
            //    //strHTML += '        <div class="expand" onclick="OrgTreePop(\'' + dr["DEPTCODE"] + '\', \'' + dr["EMPID"] + '\')"></div>';
            //}
            else {
                strHTML += '        <div class="expand" onclick="OrgTreePop(\'' + dr["DEPTCODE"] + '\', \'' + dr["EMPID"] + '\')"></div>';
            }
            strHTML += '    </div>';
            strHTML += '</a>';

            return strHTML;
        }

        function createTeamUser(dr) {
            var strHTML = '';
            strHTML += '<tr onclick="OrgPopup(\'' + dr["EMPID"] + '\',\'' + dr["COMPANYCODE"] + '\')">';
            strHTML += '    <th style="width:40%;">' + (langcd.toLowerCase() == "ko" && dr["RANKNAME"].length > 3 ? dr["RANKNAME"].substr(0, 2) : dr["RANKNAME"]) + '</th>';
            strHTML += '    <td style="width:60%;">' + dr["USERNAME"] + '</td>';
            strHTML += '</tr>';
            return strHTML;
        }

        function openChild(obj) {
            var _div = obj.parentElement.parentElement;
            var c_node = $(_div).parent().children();
            if (c_node[c_node.length - 1].tagName.toUpperCase() == "UL") {
                if (c_node[c_node.length - 1].style.display == "none") {
                    $(c_node[c_node.length - 1]).animate({ height: "show", width: "show" });
                }
                else {
                    $(c_node[c_node.length - 1]).animate({ height: "hide", width: "hide" });
                }
            }
        }

        function bindTree() {
            var ht = new Object();
            ht["COMPANYCODE"] = cboCOMPANYCODE.GetValue();
            ht["LANGCD"] = langcd;

            $("#OrgChart").html("");

            PageMethods.InvokeServiceTable(ht, "Common.OrgChartBiz", "GetUserListTree", bindTree_Callback);
        }

        function bindTree_Callback(e) {
            var ds = eval(e);

            if (ds != null && ds != undefined && ds.Tables.length > 0 && ds.Tables[0].Rows.length > 0) {

                for (var i = 0; i < ds.Tables[0].Rows.length; i++) {
                    var dr = ds.Tables[0].Rows[i];
                    //var html = createUser(dr, true);

                    // 캄텍 예외처리
                    if (dr["COMPANYCODE"] == "KAMTEC") {
                        dr["DEPTNAME"] = dr["DEPTNAME"].replace('파워트레인', 'PT');
                    }

                    if (dr["ORGSORT"] == "1") {
                        html = _createUser(dr);
                        var p_node = $("#OrgChart").find("ul li a[value='" + dr["DEPTCODE"] + "']");

                        if (dr["PARENTDEPTCODE"] == "" && p_node.length == 0) {
                            // 사장 예외처리
                            if (dr["COMPANYCODE"] == "PLANNING" ||
                                dr["COMPANYCODE"] == "PRDTECH" ||
                                dr["COMPANYCODE"] == "PSALES" ||
                                dr["COMPANYCODE"] == "PURCHASE" ||
                                dr["COMPANYCODE"] == "SALES" ||
                                dr["COMPANYCODE"] == "TECHLAB"
                            ) {
                                if (p_node.length == 0) {
                                    $("#OrgChart").append('<ul class="root"><li><a value="' + dr["DEPTCODE"] + '">' + "<div class='ceo_title'>" + dr["DEPTNAME"] + "</div>" + '</a></li></ul>');
                                }
                                p_node = $("#OrgChart").find("ul li a[value='" + dr["DEPTCODE"] + "']");
                                if (p_node.length == 0) {
                                    p_node = $("#OrgChart").find("ul li a[value='" + dr["PARENTDEPTCODE"] + "']");  //.parent();
                                }
                                p_node = $(p_node[p_node.length - 1]).parent();
                                //if (p_node.find('ul').length == 0) p_node.append('<ul></ul>');
                                //if (p_node.find('ul').length == 0) p_node.append('<ul></ul>');
                                if (dr["COMPANYCODE"].trim() == "PSALES") { // 파워트레인영업실 디자인 예외처리
                                    p_node.append('<ul><li style="left:95px;">' + html + '</li></ul>');
                                }
                                else {
                                    p_node.append('<ul><li>' + html + '</li></ul>');
                                }
                            }
                            else {
                                $("#OrgChart").append('<ul class="root"><li><a value="' + dr["DEPTCODE"] + '">' + "<div class='ceo_title'>" + dr["DEPTNAME"] + "</div>" + '</a></li></ul>'); //+ '<div class="ceo_title">&nbsp;<img src="/Resources/Images/logo.gif" />&nbsp;</div>'
                            }
                        }
                        
                        if (dr["PARENTDEPTCODE"] != "") {
                            if (p_node.length == 0) {
                                $("#OrgChart").append('<ul class="root"><li><a value="' + dr["PARENTDEPTCODE"] + '">' + '<div class="ceo_title">&nbsp;<img src="/Resources/Images/ci_' + dr["COMPANYCODE"] + '.png" />&nbsp;</div>' + '</a></li></ul>');
                            }
                            p_node = $("#OrgChart").find("ul li a[value='" + dr["DEPTCODE"] + "']");
                            if (p_node.length == 0) {
                                p_node = $("#OrgChart").find("ul li a[value='" + dr["PARENTDEPTCODE"] + "']");  //.parent();
                            }
                            p_node = $(p_node[p_node.length - 1]).parent();
                            p_node.append('<ul><li>' + html + '</li></ul>');
                        }

                    }
                    //else if (dr["DEPTCODE"].trim() == "B00000") { // 임원
                    //    //var html = createUser(dr, true);
                    //    //$("#OrgChart").append(html);
                    //}
                }

                for (var i = 0; i < ds.Tables[0].Rows.length; i++) {
                    var dr = ds.Tables[0].Rows[i];


                    if (dr["ORGSORT"] == "1") {// || dr["DEPTCODE"].trim() == "B00000") {
                    } else {
                        var html = createUser(dr, true);

                        var p_node = $("ul li a[value='" + dr["PARENTDEPTCODE"] + "']");

                        var diff = (Number(dr["DIFF"]) > 1) ? ' class="step' + dr["DIFF"] + '"' : '';

                        if (dr["LEAF"] == "1") {
                            p_node = $("ul li a[value='" + dr["DEPTCODE"] + "']");
                        }

                        if (i > 0 && p_node.length == 0) continue;

                        var c_node = $(p_node[p_node.length - 1]).parent().children();

                        if (dr["LEAF"] == "1") {
                            c_node = $(p_node).parent().find("ul li a table");
                            html = createTeamUser(dr);
                            if (c_node.length == 0) {
                                $(p_node[p_node.length - 1]).parent().append('<ul><li><a><table>' + html + '</table></a></li></table>');
                            } else {
                                $(c_node[c_node.length - 1]).append(html);
                            }
                        }
                        else {
                            if (p_node.length == 0 && i == 0) {
                                $("#OrgChart").append('<ul><li' + diff + '>' + html + "</li></ul>");
                            }
                            else if (c_node[c_node.length - 1].tagName.toUpperCase() == "UL") {
                                if (dr["DEPTCODE"] == "KTBCBA") { // 감사실 예외처리
                                    $(c_node[c_node.length - 1]).prepend('<li' + diff + '>' + html + '</li>');
                                }
                                else if (dr["DEPTCODE"] == "800000") { // 기획실 예외처리
                                    $(c_node[c_node.length - 1]).append('<li' + diff + '>' + html + '</li>');
                                }
                                else {
                                    // 마지막값이 기획실이 있을시 기획실 앞에 html을 추가한다.
                                    if ($(c_node[c_node.length - 1]).find("a[value='800000']").length > 0) {
                                        $(c_node[c_node.length - 1]).find("li:last").before('<li' + diff + '>' + html + '</li>');
                                    }
                                    // 마지막값이 기획실이 없을시 마지막에 html을 추가한다.
                                    else {
                                        $(c_node[c_node.length - 1]).append('<li' + diff + '>' + html + '</li>');
                                    }
                                }
                                //$(c_node[c_node.length - 1]).append('<li' + diff + '>' + html + '</li>');
                            }
                            else {
                                if (dr["DEPTCODE"] == "200000" || dr["DEPTCODE"] == "800000") {
                                    $(p_node[p_node.length - 1]).parent().prepend('<ul style="display:block;"><li' + diff + '>' + html + '</li></ul>');
                                }
                                else {
                                    $(p_node[p_node.length - 1]).parent().append('<ul style="display:block;"><li' + diff + '>' + html + '</li></ul>');
                                }
                                //$(p_node[p_node.length - 1]).parent().append('<ul style="display:block;"><li' + diff + '>' + html + '</li></ul>');
                            }
                        }
                    }
                }

                //ZoomFitOrg();

                // 좌우스크롤 중앙정렬
                //var docWidth = $(document).width();
                //$(document).scrollLeft(docWidth / 2);
                var myDiv = $(document);
                if (myDiv.offset() != null) {
                    var scrollto = myDiv.offset().left + (myDiv.width() / 2);
                    myDiv.animate({ scrollLeft: scrollto });
                    $(document).scrollTo('#orderBookMiddleRow', 500, { offset: -$(window).height() / 2 })
                }
            }
        }

        function ZoomOrg(lvl) {
            zoomLevel += Number(lvl);
            if (zoomLevel > 1 || zoomLevel <= 0) {
                zoomLevel -= lvl;
                return;
            }
            $("#OrgChart").animate({ 'zoom': (zoomLevel * 100) + "%" }, 'fast');
        }

        function ZoomFitOrg() {
            //zoomLevel = 1;
            //$("#OrgChart").animate({ 'zoom': '100%' }, 'fast');
            $("#OrgChart").animate({ 'zoom': ((($("#OrgChart").width() - 50) / $("#OrgChart").find("ul li").width()) * 100) + "%" }, 'fast');
            zoomLevel = Number(($("#OrgChart").width() / $("#OrgChart").find("ul li").width()).toFixed(1));
            //if ((($("#OrgChart").width() - 50) / $("#OrgChart").find("ul li").width()) >= 1) {
            //    $("#OrgChart").animate({ 'zoom': '100%' }, 'fast');
            //    zoomLevel = 1;
            //}
            //else {
            //    $("#OrgChart").animate({ 'zoom': (($("#OrgChart").width() - 50) / $("#OrgChart").find("ul li").width()) }, 'fast');
            //    zoomLevel = Number(($("#OrgChart").width() / $("#OrgChart").find("ul li").width()).toFixed(1));
            //}
        }

        function OrgTreePop(deptcd, empid) {
            var ht = new Object();
            ht["COMPANYCODE"] = cboCOMPANYCODE.GetValue();
            ht["DEPTCODE"] = deptcd;
            ht["LANGCD"] = langcd;

            PageMethods.InvokeServiceTable(ht, "Common.OrgChartBiz", "GetUserListTreeSub", bindTreeSub_Callback);
        }
        // 재정의
        function OrgPopup(empid, companycode) {
            if (empid == "" || empid == null || empid == undefined || empid == "undefined") return;
            if (event == undefined || event == null) {
                var x = $("body").width() / 2;
                var y = $("body").height() / 2;
                x = (x + 400) > $("body").width() ? $("body").width() - 400 : x;
                y = (y + 250) > $("body").height() ? $("body").height() - 250 : y;
                grdOrgUser_SetPosition(x, y);
            } else {
                var x = (event.pageX + 400) > $("body").width() ? $("body").width() - 400 : event.pageX;
                var y = (event.pageY + 250) > $("body").height() ? $("body").height() - 250 : event.pageY;
                grdOrgUser_SetPosition(x, y);
            }
            // iframe안에 위치함으로 위치를 고정시킨다
            //grdOrgUser_SetPosition(200, 40);
            
            document.getElementById("divOrgUser_OrgCard").style.display = "none";       // 인사기록카드 숨기기
            $("#divOrgUser_OrgCard").attr("onclick", "");                               // 인사기록카드 클릭이벤트 해제


            var ht = new Object();
            ht["EMPID"] = empid;
            //ht["COMPANYCODE"] = "1000";
            //ht["LANGCODE"] = "ko";
            ht["COMPANYCODE"] = companycode; // $("#cboOrg").val();
            ht["LANGCODE"] = Use_Language;
            ht["REGID"] = regid;

            PageMethods.InvokeServiceTable(ht, "Common.OrgChartBiz", "GetUserInfoCard", bindUser_Callback);
        }

        /******************************************************************************************
        * 함수명 : bindUser_Callback 
        * 설  명 : 조직정보 바인딩
        * 작성일 : 2014-11-24
        * 작성자 : 장경환
        * 수  정 :
        ******************************************************************************************/
        function bindUser_Callback(e) {
            var ds = eval(e);

            if (ds.Tables[0].Rows.length < 1 || ds == undefined) {
                alert('오류');
                return;
            }
            if (ds.Tables[0].Rows[0]["EMPID"] != "") {
                //http://tos.nvhkorea.com/pilot/Thumbnail.nsf/ByEmpNo/사번/$FILE/ThumbNail.jpg
                document.getElementById("divOrgUser_photo").style.background = "url(/Resources/Framework/OrgImageViewer.aspx?id=" + ds.Tables[0].Rows[0]["EMPID"].trim() + ") no-repeat";
                document.getElementById("divOrgUser_photo").style.backgroundSize = "100% 100%";
                document.getElementById("divOrgUser_photo").style.backgroundPosition = "center top";
            }
            else {
                document.getElementById("divOrgUser_photo").style.background = "url(/Resources/Images/none_user_photo2.png) no-repeat"; // no-repeat;width:100%;height:100%;'></div>";
                document.getElementById("divOrgUser_photo").style.backgroundPosition = "center top";
            }

            document.getElementById("divOrgUser_Name").innerText = ds.Tables[0].Rows[0]["DISPLAYNAME"];
            document.getElementById("divOrgUser_Company").innerText = ds.Tables[0].Rows[0]["COMPANYNAME"];
            document.getElementById("divOrgUser_Dept").innerText = ds.Tables[0].Rows[0]["MAINDEPTNAME"];

            //회장,부회장,사장 공백처리
            var RankText = '';
            if (ds.Tables[0].Rows[0]["EMPID"] == 'A2150403' || ds.Tables[0].Rows[0]["EMPID"] == 'A2040401' || ds.Tables[0].Rows[0]["EMPID"] == 'A2061002')
                RankText = ''
            else
                RankText = NullString(ds.Tables[0].Rows[0]["DUTYNAME"]) + " / " + NullString(ds.Tables[0].Rows[0]["RANKNAME"]);

            document.getElementById("divOrgUser_Rank").innerText = RankText;
            //document.getElementById("divOrgUser_Job").innerText = NullString(ds.Tables[0].Rows[0]["JOBNAME"]);
            document.getElementById("divOrgUser_Job").innerText = "";
            document.getElementById("divOrgUser_Mail").innerText = NullString(ds.Tables[0].Rows[0]["EMAIL"]);
            document.getElementById("divOrgUser_Tel1").innerText = NullString(ds.Tables[0].Rows[0]["CELLPHONE"]);
            document.getElementById("divOrgUser_Tel2").innerText = NullString(ds.Tables[0].Rows[0]["EXTENSIONNUMBER"]);
            //    document.getElementById("divOrgUser_Tel3").innerText = NullString(ds.Tables[0].Rows[0]["PHONE1"]);
            //    document.getElementById("divOrgUser_Tel4").innerText = NullString(ds.Tables[0].Rows[0]["PHONE2"]);
            document.getElementById("divOrgUser_Emp").innerText = ds.Tables[0].Rows[0]["EMPID"];

            //임시 사용자교육 보여주기용
            //if (ds.Tables[0].Rows[0]["EMPID"] == 'A2044081')
            //    document.getElementById("divOrgUser_Bar").innerText = '전산총괄,NAIS(생산,영업,원가),중국ERP,보안,TOS';
            //else
            document.getElementById("divOrgUser_Bar").innerText = ds.Tables[0].Rows[0]["JOBDESC"];
            
            <% if (ORG_ACL == "Y") { %>
                $("#divOrgUser_OrgCard").attr("onclick", "orgCard_Open('" + ds.Tables[0].Rows[0]["COMPANYCODE"] + "', '" + ds.Tables[0].Rows[0]["EMPID"] + "');");
                $("#divOrgUser_OrgCard").show();
            <% } else { %>
                if((ds.Tables[1] != null && ObjectCount(ds.Tables[1]) > 0 && ds.Tables[1].Rows != null && ObjectCount(ds.Tables[1].Rows) > 0) || ds.Tables[0].Rows[0]["EMPID"] == regid) {
                    $("#divOrgUser_OrgCard").attr("onclick", "orgCard_Open('" + ds.Tables[0].Rows[0]["COMPANYCODE"] + "', '" + ds.Tables[0].Rows[0]["EMPID"] + "');");
                    $("#divOrgUser_OrgCard").show();
                }
            <% } %>

            grdOrgUser_Show();
        }

        function orgCard_Open(companycode, empid) {
            ShowPopup("/Portal/PersonnelCard.aspx?COMPANYCODE=" + companycode + "&EMPID=" + empid, Math.floor(Math.random() * 999) + 1, "1300", "950");
        }

        function ShowPopup(url, name, width, height) {
            var retfeature = "";
            nLeft = (window.screen.width - width) / 2;
            nTop = (window.screen.height - height - 100) / 2;
            retfeature += "Height=" + height;
            retfeature += ",Width=" + width;
            retfeature += ",left=" + nLeft;
            retfeature += ",top=" + nTop;
            //retfeature += ",center=yes";
            retfeature += ",help=no";
            retfeature += ",edge=raised";
            retfeature += ",scrollbars=yes";
            retfeature += ",resizable=yes";
            retfeature += ",status=no";
            retfeature += ",unadorned=no";

            var win = window.open(url, name, retfeature);
            win.focus();
        }

        // 재정의
        function bindTreeSub_Callback(e) {
            $("#OrgChart_Sub").html("");
            var ds = eval(e);
            var depth = 0;
            if (ds != null && ds != undefined && ds.Tables.length > 0 && ds.Tables[0].Rows.length > 0) {
                for (var i = 0; i < ds.Tables[0].Rows.length; i++) {
                    var dr = ds.Tables[0].Rows[i];
                    var html = createUser(dr, false);

                    if (dr["ORGLEVEL"] == "1") {
                        html = _createUser(dr);
                        var p_node = $("#OrgChart_Sub").find("ul li a[value='" + dr["DEPTCODE"] + "']");

                        if (p_node.length == 0) {
                            $("#OrgChart_Sub").append('<ul><li><a value="' + dr["DEPTCODE"] + '">' + '<div class="ceo_title">&nbsp;<img src="/Resources/Images/ci.png" />&nbsp;</div>' + '</a></li></ul>');
                            //' + dr["DeptName"] + '
                        }
                        else {
                            //p_node.append(html);
                        }

                    } else {
                        var p_node = $("#OrgChart_Sub ul li a[value='" + dr["PARENTDEPTCODE"] + "']");

                        var diff = (Number(dr["DIFF"]) > 1) ? ' class="step' + dr["DIFF"] + '"' : '';

                        if (Number(dr["ORGLEVEL"]) >= 7) {
                            p_node = $("#OrgChart_Sub ul li a[value='" + dr["PARENTDEPTCODE"] + "']");
                        }

                        //if (i > 0 && p_node.length == 0) continue;

                        var c_node = $(p_node[p_node.length - 1]).parent().children();

                        if (Number(dr["ORGLEVEL"]) >= 7) {
                            c_node = $(p_node).parent().find("ul li a table[value='" + dr["DEPTCODE"] + "']");
                            html = createTeamUser(dr);
                            if (c_node.length == 0) {
                                $(p_node.parent().children()[p_node.parent().children().length - 1]).append('<li><a><div class="user_part2"><div class="user_duty">' + dr["DEPTNAME"] + '</div><table value="' + dr["DEPTCODE"] + '">' + html + '</table></div></a></li>');
                            } else {
                                $(c_node[c_node.length - 1]).append(html);
                            }
                        }
                        else {
                            if (p_node.length == 0 && i == 0) {
                                $("#OrgChart_Sub").append('<ul><li' + diff + '>' + html + "</li></ul>");
                                depth++;
                            }
                            else if (c_node[c_node.length - 1].tagName.toUpperCase() == "UL") {
                                $(c_node[c_node.length - 1]).append('<li' + diff + '>' + html + '</li>');
                            }
                            else {
                                $(p_node[p_node.length - 1]).parent().append('<ul name="c_dept" style="' + ((depth > 1 && dr["LEAF"] == "1") ? 'display:none;' : '') + '"><li' + diff + '>' + html + '</li></ul>');
                                depth++;
                            }
                        }
                    }
                }

                // 위치 조절
                
                $("#Org_Sub").show();
            }
        }

        function closeOrgSub() {
            $("#Org_Sub").hide();
            $("#OrgChart_Sub").html("");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <script type="text/javascript" src="/Resources/Framework/JIS.Control.js"></script>
    <div id="content">
        <div id="wapper" onclick="grdOrgUser_Close();">
            <div id="title2">
                <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="전사조직도"></Ctl:Text>
            </div>
            <div id="topBar">
                <ul>
                    <li style="padding-right: 5px; padding-left: 5px;">
                        <Ctl:Combo ID="cboCOMPANYCODE" runat="server" OnChange="bindTree()">
                        </Ctl:Combo>
                    </li>
                    <li onclick="ZoomOrg(-0.1);">
                        <img src="/Resources/Images/Icon/zoom_in.png" title="Zoom in" alt="Zoom In" /></li>
                    <li onclick="ZoomFitOrg();">
                        <img src="/Resources/Images/Icon/zoom_fit.png" title="Fit" alt="Fit" /></li>
                    <li onclick="ZoomOrg(0.1);">
                        <img src="/Resources/Images/Icon/zoom_out.png" title="Zoom Out" alt="Zoom Out" /></li>
                </ul>
            </div>
            <div id="content_bx">
                <div id="OrgChart" class="tree">
                </div>
            </div>
        </div>
    </div>
    <div id="Org_Sub" style="">
        <div class="close" onclick="closeOrgSub();">
            ×</div>
        <div style="margin: 120px 30px 30px 30px; background: rgba(255,255,255,0.98); width: auto;
            height: 80%; overflow: auto;">
            <div id="OrgChart_Sub" class="tree">
            </div>
        </div>
    </div>
    <!-- //조직도 검색 -->
    <div id="divOrgUser">
        <div id="divOrgUser_close" onclick="grdOrgUser_Close()">
            ×</div>
        <div id="divOrgUser_photo">
        </div>
        <ul style="float: left;">
            <li id="divOrgUser_Cont" style="float: left;">
                <div id="divOrgUser_Name">
                </div>
                <div id="divOrgUser_Company">
                </div>
                <div id="divOrgUser_Dept">
                </div>
                <div id="divOrgUser_Rank">
                </div>
                <div id="divOrgUser_Job">
                </div>
                <div id="divOrgUser_Mail" title="Mail">
                </div>
                <div id="divOrgUser_Tel1" title="Mobile">
                </div>
                <div id="divOrgUser_Tel2" title="Office">
                </div>
                <div id="divOrgUser_OrgCard" style="cursor:pointer; display:none;">인사기록카드</div>
                <div id="divOrgUser_Tel3" title="Internet Call" style="display: none;">
                </div>
                <div id="divOrgUser_Tel4" title="Conference Call" style="display: none;">
                </div>
                <div id="divOrgUser_Emp" style="display: none;">
                </div>
            </li>
        </ul>
        <div id="divOrgUser_Bar">
            <ul>
                <li>
                    <div class="gmail" onclick="SendMailTo();">
                    </div>
                </li>
                <li>
                    <div class="post" onclick="SendPostTo();">
                    </div>
                </li>
                <li>
                    <div class="push" onclick="SendPushTo();">
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <!-- //조직도 검색 종료 -->
    </form>
</body>
</html>
