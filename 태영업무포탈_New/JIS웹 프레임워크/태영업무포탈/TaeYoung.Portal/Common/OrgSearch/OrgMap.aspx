<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrgMap.aspx.cs" Inherits="TaeYoung.Portal.Common.OrgSearch.OrgMap" %>

<!DOCTYPE html>
<html lang='ko'>
<head runat="server">
    <meta charset="utf-8" />
    <link rel="shortcut icon" type="image/x-icon" href="/Resources/Images/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="/Resources/Css/Import.css" />
    <link rel="stylesheet" type="text/css" href="/Resources/Css/Control.css" />
    <link href="/Resources/Framework/JIS.Control.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        <asp:LIteral ID="ltlCustomStyle" runat="server" />
        html, body { overflow: hidden; }
        span.COMPANY {background: #3F7DD0;}
		/*span.KOFCO {background: #8DAAE4;}
		span.SEOHAN{background: #5F85C3;}
		span.KAMTEC{background: #5d9bdf;}
		span.EMTES{background: #6173c8;}
		span.ENP {background: #66B6F3;}
		span.SNB {background: #37beb4;}
		span.GLOBIZ{background: #5ac55d;}
		span.AUTOUSA{background: #9169b9;}
		span.HANSHIN{background: #8246be;}
		span.SEOHANAUTOMEXICO{background: #8c69d5;}
		span.PLANNING{background: #41b9cd;}
		span.FINANCE{background: #B2EBF4;}
		span.PURCHASE{background: #6464c8;}
		span.PRDTECH{background: #4673e3;}
		span.SALES{background: #0baccc;}
		span.PSALES{background: #148cc3;}
		span.TECHLAB{background: #49bee6;}
		span.Beijing NTN Seohan{background: #aad74b;}
		span.Chongqing NTN Seohan{background: #32af6e;}
		span.AMG{background: #9E9E9E;}
		span.Zhangjiagang{background: #F15F5F;}
		span.erp{background: #aad74b;}
		span.plm{background: #aad74b;}*/
    </style>
    <script type="text/javascript" src="/Resources/Script/Domain.js"></script>
    <script type="text/javascript" src="/Resources/Framework/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="/Resources/Framework/jquery-migrate-3.0.0.min.js"></script>
    <script type="text/javascript" src="/Resources/Framework/jquery-ui.min.js"></script>
    <script type="text/javascript" src="/Resources/Framework/moxie.min.js"></script>
    <script type="text/javascript" src="/Resources/Framework/plupload.dev.js"></script>
    <script type="text/javascript" src="/Resources/Framework/jquery.ui.plupload.js"></script>
    <script type="text/javascript" src="/Resources/Script/Common.js"></script>
    <script type="text/javascript" src="/Resources/Script/Site.UI.js"></script>
    <script type="text/javascript" src="/Resources/Script/Org.js"></script>
    <script type="text/javascript" src="/Resources/Script/OrgChart.js"></script>
    <script type="text/javascript" src="/Resources/Framework/JIS.Control.js"></script>
    <script type="text/javascript" src="/Resources/Script/Org.js"></script>
    <script type="text/javascript" src="/Resources/Script/OrgChart.js"></script>

    <script type="text/javascript">
        var ControlLoad = [];
        //window.onerror = function () {
        //    var message = "\nMessage: " + arguments[0];
        //    message += "\nURL: " + arguments[1];
        //    message += "\nLine: " + arguments[2];
        //    message += "\nColumn: " + arguments[3];
        //    alert("스크립트에서 오류가 발생하였습니다."+message);
        //};

		var ProgramID = "<asp:LIteral ID="ltlProgramID" runat="server" />";
        var TopMenuID = "<asp:LIteral ID="ltlTopMenuID" runat="server" />";
		var MenuID = "<asp:LIteral ID="ltlMenuID" runat="server" />";
        var MenuFold = false;
		var IsPopup = false;
		var EMPID = "<%= TaeYoung.Biz.Document.UserInfo.EmpID %>";
		var COMPANYCODE = "<%= TaeYoung.Biz.Document.UserInfo.CompanyCode %>";
        var ACL = "<%= ACL %>";
        var Use_Language = "<%= TaeYoung.Biz.Document.ClientCultureName %>"; 
		var ManualExist = "<asp:LIteral ID="ltlManualExist" runat="server" />";
        var SessionUserInfoString = "<%= HttpContext.Current.Session["UserInfo"] != null ? System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(HttpContext.Current.Session["UserInfo"].ToString())) : "" %>";
        var isAdmin = "<%= IsAdmin %>";

        // 조직도 설정
        var DEPTCD = "<%= DEPTCD %>";
        var LANGCODE = "<%= LANGCODE %>";
        var OrgOpen = false;

        $(document).ready(function(){
            $("#search").on("click",function(){
                $(this).val("");
                org_View();
            });
            $("#search").on("keypress",function(e){
                if(e.keyCode == '13'){
                    txtSearch_click();
                    return false;
                }
                //OrgPopup();
                //return false;
            });
            $("#search").on("blur",function(){
                if($(this).val()==""){
                    $(this).val("임직원 검색");
                }
            });

            org_Show();
        });

        function org_Close(){
            //OrgOpen = false;
            //var width = 620;
            //$("#divOrg").animate(
            //    { "width": "-=" + width + "px", "height": "-=490px" }, 
            //    { "duration": "300", "complete": function () { 
            //            //$(window).trigger('resize'); 
            //            $("#divOrg").hide();
            //        } 
            //    });

            $("#frmCloseEvt").attr("src","http://<%= GetDominoDomain %>/pilot/Main.nsf/mainFnRun?ReadForm&act=orgshow");
        }

        function org_View(){
            if(!OrgOpen){
                var width = 880;
                $("#divOrg").show();
                $("#divOrg").animate(
                    { "width": "+=" + width + "px", "height": "+=490px" }, 
                    { "duration": "300", "complete": function () { 
                            //$(window).trigger('resize'); 
                        OrgOpen = true;
                        } 
                    });
            }
        }

        function org_Show() {
            var width = 880;

            $("#divOrg").show();

            //$("#common_img_org").attr("src", "/Resources/Images/btn_quickmenu_move_btm.gif");
            $("#divOrg").css("width",width+"px");
            $("#divOrg").css("height","490px");
//            $("#divOrg").animate(
//                { "width": "+=" + width + "px", "height": "+=490px" }, 
//                { "duration": "300", "complete": function () { 
//                        $(window).trigger('resize'); 
//                    } 
//                });

            if (MenuFold) $("#divOrg").animate({ "left": "+=160px" }, "fast");

//            if ($(top.document).find("#frmOrgMap").length > 0) {
//                $(top.document).find("#frmOrgMap").animate({ "width": "+=" + width + "px", "height": "+=490px" }, { "duration": "300", "complete": function () { 
//                    $(window).trigger('resize'); 
//                } });
//            }

                
            $("#treeMenu").show();
            OrgOpen = true;

//            if (!OrgOpen) {
//                $("#divOrg").show();

//                $("#common_img_org").attr("src", "/Resources/Images/btn_quickmenu_move_btm.gif");
//                $("#divOrg").animate(
//                    { "width": "+=" + width + "px", "height": "+=490px" }, 
//                    { "duration": "300", "complete": function () { 
//                            $(window).trigger('resize'); 
//                        } 
//                    });

//                if (MenuFold) $("#divOrg").animate({ "left": "+=160px" }, "fast");

//                if ($(top.document).find("#frmOrgMap").length > 0) {
//                    $(top.document).find("#frmOrgMap").animate({ "width": "+=" + width + "px", "height": "+=490px" }, { "duration": "300", "complete": function () { 
//                        $(window).trigger('resize'); 
//                    } });
//                }

//                
//                $("#treeMenu").show();
//                OrgOpen = true;
//            }
//            else {
//                //$("#common_img_org").hide();
//                $("#common_img_org").attr("src", "/Resources/Images/btn_quickmenu_move_top.gif");
//                $("#divOrg").animate({ "width": "-=" + width + "px", "height": "-=490px" }, { "duration": "300", "complete": function () { 
//                    $(window).trigger('resize'); 
//                    //$("#divOrg").hide();
//                    //$("#common_img_org").show();
//                } });

//                if (MenuFold) $("#divOrg").animate({ "left": "-=160px" }, "fast");

//                if ($(top.document).find("#frmOrgMap").length > 0) {
//                    $(top.document).find("#frmOrgMap").animate({ "width": "-=" + width + "px", "height": "-=490px" }, { "duration": "300", "complete": function () { 
//                        $(window).trigger('resize'); 

//                        //$("#divOrg").hide();
//                    } });
//                }

//                
//                OrgOpen = false;
//            }

        }
        //
        var common_search_org = new SearchText('search');
        
    </script>
</head>
<body id="wrapper">
    <form id="form1" runat="server">
    <!--메인시작-->
    <div id="sub_body">
        <!--상단시작-->
        <div id="header" style="display:none;">
            <!--탑소메뉴시작-->
            <div id="topsmenu_bx">
               
                <div id="member_search">
                    <fieldset>
                        <legend>임직원검색</legend>
                        <label for="FindTxt">
                            임직원검색어입력</label>
                        <input type="text" id="search" name="search" title="임직원검색어를 입력하세요." value="임직원 검색" /><a
                            href="javascript:;" onclick="txtSearch_click();"><img src="/Resources/Images/btn_search.png" alt="검색" /></a> <a href="#">
                                <img src="/Resources/Images/btn_member_search.png" alt="조직도검색" /></a>
                    </fieldset>
                </div>

            </div>
            <!--//탑메뉴끝-->
            <!--//상단끝-->
        </div>
        <!--//메인끝-->

    <!-- //조직도 검색 시작 -->
    <div id="divOrg" style="">
        <table style="width:100%; height:100%;">
            <tr>
                <td colspan="2" style="padding:5px 5px 5px 10px; background:rgba(0,0,0,0.3);">
                    <select id="cboOrg" runat="server" class="org_combo" onchange="cboOrg_Changed(this);">
                    </select>
                    <span class="saperator"></span>
                </td>
                <td width="25">
                    <img id="common_img_org" src="/Resources/Images/btn_quickmenu_move_top.gif" alt="" title="" style="cursor:pointer;" onclick="org_Close();"  />
                </td>
            </tr>
            <tr id="trOrg" style="vertical-align:top;">
                <td style="width:190px; padding:5px 7px 7px 7px;">
                    <div style="width:100%; height:440px; background:rgba(255,255,255,0.09); overflow:visible;">
                        <Ctl:WebTree ID="treeOrg" runat="server" />
                    </div>
                </td>
                <td style="padding:0px 7px 7px 7px;" colspan="2">
                    <div id="grdOrg">
                        <div style="overflow-y:scroll;">
                            <table cellspacing="0" cellpadding="0" style="table-layout:fixed;width:100%; border-bottom:0px">
                                <colgroup>
                                    <col width="120px" />
                                    <col width="60px" />
                                    <col width="60px" />
                                    <col width="70px" />
                                    <col width="100px" />
                                    <col width="100px" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th colspan="6" style="height:25px; text-align:justify">
                                            <ul>
                                                <li style="float:left;width:200px;">
                                                    <span id="grdOrg_SearchText" style="font-size:14px;""></span> <span id="grdOrg_SearchCount" style="color:#cccccc;"></span> 
                                                    <script type="text/javascript">
                                                        var grdOrg_SearchText = new SearchText('grdOrg_SearchText');
                                                        var grdOrg_SearchCount = new SearchText('grdOrg_SearchCount');
                                                    </script>
                                                </li>
                                            </ul>
                                        </th>
                                    </tr>
                                    <tr>
                                        <%--<th style="width:25px;height:25px; text-align:center;display:none;">
                                            <input type="checkbox" id="grdOrg_ChkAll" name="grdOrg_ChkAll" onclick="grdOrg_ChkAll_Click(this)" style="background:transparent;border:0;" /></th>--%>
                                        <th style="width:120px;height:25px; text-align:center;">
                                            <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">부서</div><span id="grdOrg_sortflag_0"></span></th>
                                        <th style="width:60px;height:25px; text-align:center;">
                                            <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">직급</div><span id="grdOrg_sortflag_1"></span></th>
                                        <th style="width:60px;height:25px; text-align:center;">
                                            <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">성명</div><span id="grdOrg_sortflag_2"></span></th>
                                        <th style="width:70px;height:25px; text-align:center;">
                                            <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">담당업무</div><span id="grdOrg_sortflag_3"></span></th>
                                        <th style="width:100px;height:25px; text-align:center;">
                                            <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">휴대번호</div><span id="grdOrg_sortflag_4"></span></th>
                                        <th style="width:100px;height:25px; text-align:center;">
                                            <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">내선번호</div><span id="grdOrg_sortflag_5"></span></th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="grdOrg_Body" style="overflow-y:scroll;">
                            <table id="grdOrg_Cont" cellspacing="0" cellpadding="0" style="table-layout:fixed;width:100%; border-bottom:0px">
                                <colgroup>
                                    <col width="120px" />
                                    <col width="60px" />
                                    <col width="60px" />
                                    <col width="70px" />
                                    <col width="100px" />
                                    <col width="100px" />
                                </colgroup>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div id='grdOrg_progress' class='progress'><div style="text-align:center; padding-top:150px;"><img src='/Resources/Framework/ajax_loding.gif' alt='' /></div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div id="divOrgUser">
        <div id="divOrgUser_close" onclick="grdOrgUser_Close()">×</div>
        <div id="divOrgUser_photo"></div>
            
        <ul style="float:left;">
            <li id="divOrgUser_Cont" style="float:left;">
                <div id="divOrgUser_Name"></div>
                <div id="divOrgUser_Company"></div>
                <div id="divOrgUser_Dept"></div>
                <div id="divOrgUser_Rank"></div>
                <div id="divOrgUser_Job"></div>
                <div id="divOrgUser_Mail"></div>
                <div id="divOrgUser_Tel1"></div>
                <div id="divOrgUser_Tel2"></div>
                <div id="divOrgUser_Tel3" style="display:none;"></div>
                <div id="divOrgUser_Tel4" style="display:none;"></div>
                <div id="divOrgUser_Emp" style="display:none;"></div>
            </li>
        </ul>
        <div id="divOrgUser_Bar" style="display:none;">
            <ul style="float:left;">
                <li style="float:left;">
                    <div class="gmail" onclick="SendMailTo();"></div>
                </li>   
            </ul>
        </div>
         <div id="passwd_clear" style="margin-top:200px;" runat="server" visible="false">
            <div>비밀번호 : <span id="pwd"></span></div>
            <input type="button" value="비밀번호 초기화" onclick="pwd_Clear();" />
        </div>
    </div>
    <!-- //조직도 검색 종료 -->
    <br />
    <div style="display:none;">
        <iframe id="frmCloseEvt" src="about:blank;"></iframe>
    </div>
    </form>
</body>
</html>
