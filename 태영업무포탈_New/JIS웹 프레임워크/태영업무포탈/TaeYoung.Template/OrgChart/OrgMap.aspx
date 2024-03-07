<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrgMap.aspx.cs" Inherits="TaeYoung.WebTemplate.OrgChart.OrgMap" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="conHead">
<script type="text/javascript" src="/Resources/Script/Org.js"></script>
<script type="text/javascript" src="/Resources/Script/OrgChart.js"></script>
<script type="text/javascript">
    var DEPTCD = "<%= DEPTCD %>";
    var LANGCODE = "<%= LANGCODE %>";
    var OrgOpen = false;

    $(document).ready(function () {
        $("#common_search_org").keyup(function (e) {
            if (e.keyCode == 13) {
                txtSearch_click();
            }
        });
    });

    function org_Show() {
        var width = 560;

        if (!OrgOpen) {
            $("#common_img_org").attr("src", "/Resources/Images/btn_quickmenu_move_btm.gif");
            $("#divOrg").animate({ "width": "+=" + width + "px", "height": "+=490px" }, { "duration": "300", "complete": function () { $(window).trigger('resize'); } });

            if (MenuFold) $("#divOrg").animate({ "left": "+=160px" }, "fast");

            if ($(top.document).find("#frmOrgMap").length > 0) {
                $(top.document).find("#frmOrgMap").animate({ "width": "+=" + width + "px", "height": "+=490px" }, { "duration": "300", "complete": function () { $(window).trigger('resize'); } });
            }

            $("#trOrg").show();
            //$("#treeMenu").show();
            OrgOpen = true;
        }
        else {
            $("#common_img_org").attr("src", "/Resources/Images/btn_quickmenu_move_top.gif");
            $("#divOrg").animate({ "width": "-=" + width + "px", "height": "-=490px" }, { "duration": "300", "complete": function () { $(window).trigger('resize'); } });

            if (MenuFold) $("#divOrg").animate({ "left": "-=160px" }, "fast");

            if ($(top.document).find("#frmOrgMap").length > 0) {
                $(top.document).find("#frmOrgMap").animate({ "width": "-=" + width + "px", "height": "-=490px" }, { "duration": "300", "complete": function () { $(window).trigger('resize'); } });
            }

            $("#trOrg").hide();
            OrgOpen = false;
        }

    }

</script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="conBody">
    <!-- //조직도 검색 시작 -->
    <div id="divOrg" style="">
        <table style="width:100%; height:100%;">
            <tr style="height:30px;">
                <td colspan="2" style="text-align:center; vertical-align:middle;">
                    <ul>
                        <li style="float:left; padding-left:10px;">
                            <input type="text" id="common_search_org" title="" />
                            <script type="text/javascript">var common_search_org = new SearchText('common_search_org');</script>
                        </li>
                        <li style="float:right; padding:3px 10px 3px 3px;">
                            <img id="common_img_org" src="/Resources/Images/btn_quickmenu_move_top.gif" alt="" title="" style="cursor:pointer;" onclick="org_Show();"  />
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding:5px 5px 5px 10px; background:rgba(0,0,0,0.3);">
                    <select id="cboOrg" runat="server" class="org_combo" onchange="cboOrg_Changed(this);">
                    </select>
                    <span class="saperator"></span>
                </td>
            </tr>
            <tr id="trOrg" style="display:none; vertical-align:top;">
                <td style="width:190px; padding:5px 7px 7px 7px;">
                    <div style="width:100%; height:440px; background:rgba(255,255,255,0.09); overflow:visible;">
                        <Ctl:WebTree ID="treeOrg" runat="server" />
                    </div>
                </td>
                <td style="padding:0px 7px 7px 7px;">
                    <div id="grdOrg">
                        <div style="overflow-y:scroll;">
                            <table cellspacing="0" cellpadding="0" style="table-layout:fixed;width:100%; border-bottom:0px">
                                <colgroup>
                                    <col width="25px" />
                                    <col width="70px" />
                                    <col width="70px" />
                                    <col width="100px" />
                                    <col width="*" />
                                    <col width="120px" />
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
    <%--                                                    <li style="float:right;width:200px; text-align:right;">
                                                    <span class="btn"><a onclick="SendMailGrid();">메일발송</a></span>
                                                    <span class="btn"><a onclick="SendPostGrid();">사서함발송</a></span>
                                                </li>--%>
                                            </ul>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th style="width:25px;height:25px; text-align:center;">
                                            <input type="checkbox" id="grdOrg_ChkAll" name="grdOrg_ChkAll" onclick="grdOrg_ChkAll_Click(this)" style="background:transparent;border:0;" /></th>
                                        <th style="width:70px;;height:25px; text-align:center;">
                                            <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">직책</div><span id="grdOrg_sortflag_0"></span></th>
                                        <th style="width:70px;;height:25px; text-align:center;">
                                            <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">직위</div><span id="grdOrg_sortflag_1"></span></th>
                                        <th style="width:100px;;height:25px; text-align:center;">
                                            <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">성명</div><span id="grdOrg_sortflag_2"></span></th>
                                        
                                        <th style="width:*;height:25px; text-align:center;">
                                            <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">담당업무</div><span id="grdOrg_sortflag_3"></span></th>
                                        <th style="width:120px;height:25px; text-align:center;">
                                            <div style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">휴대번호</div><span id="grdOrg_sortflag_4"></span></th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="grdOrg_Body" style="overflow-y:scroll;">
                            <table id="grdOrg_Cont" cellspacing="0" cellpadding="0" style="table-layout:fixed;width:100%; border-bottom:0px">
                                <colgroup>
                                    <col width="25px" />
                                    <col width="70px" />
                                    <col width="70px" />
                                    <col width="100px" />
                                    <col width="*" />
                                    <col width="120px" />
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
                <div id="divOrgUser_Tel3"></div>
                <div id="divOrgUser_Tel4"></div>
                <div id="divOrgUser_Emp" style="display:none;"></div>
            </li>
            <%--<li style="float:right;">
                    
            </li>--%>
        </ul>
        <div id="divOrgUser_Bar">
            <ul style="float:left;">
                <li style="float:left;">
                    <div class="gmail" onclick="SendMailTo();"></div>
                </li>
                <%--<li style="float:left;">
                    <div class="post" onclick="SendPostTo();"></div>
                </li>--%>
            </ul>
        </div>
    </div>
    <!-- //조직도 검색 종료 -->
</asp:Content>