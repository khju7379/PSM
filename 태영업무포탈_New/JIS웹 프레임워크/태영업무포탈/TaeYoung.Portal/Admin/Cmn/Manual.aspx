<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manual.aspx.cs" Inherits="TaeYoung.Portal.Admin.Cmn.Manual" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="conHead">
  <style type="text/css">
      img.IMG_lazy
      {
          width  :100%;
          height : 100%;
          margin-bottom : 5px;
      }
      #grid_list
      {
          display : none;
      }
  </style>
  <script type="text/javascript" src="/Resources/Framework/jquery.lazyload.js"></script>
    <script type="text/javascript">
        var P_PROGRAMID = '<%= base.GetQueryString("PROGRAMID") %>';

        /********************************************************************************************
        * 함수명      : OnLoad()
        * 작성목적    : OnLoad
        * Parameter   :
        * Return
        * 작성자      : 장윤호
        * 최초작성일  : 2017-02-10
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function OnLoad() {
            if (P_PROGRAMID == "") {
                $("#grid_list").css("display", "block");
            }

            GetDataGrid();
        }
        var GetDataGrid = function () {
            grid1.Params({ 'PROGRAMID': P_PROGRAMID });

            grid1.BindList(1);
            grid1.CallBack = function () {
                var all = grid1.GetAllRow();
                for (var i = 0; i < ObjectCount(all.Rows); i++) {
                    var row = all.Rows[i];

                    var blankText = "";
                    var levCnt = parseInt(row["LEV"]) * 3;
                    for (var j = 0; j < levCnt; j++) {
                        blankText += "&nbsp;";
                    }

                    var apvLink = "";
                    if (row["ATTACH_CNT"] != "0") {
                        apvLink = '&nbsp;&nbsp;<img src="/Resources/Images/Icon/icon_doc_link.gif" style= "cursor : pointer;" alt="" title="" />';
                    }

                    grid1.SetValue(i, "PROGRMNAME", blankText + row["PROGRMNAME"] + apvLink);
                }

                if (P_PROGRAMID != "") grid1_Onclick(0, 0);
            }


        }

        var grid1_Onclick = function (r, c) {

            var row = grid1.GetRow(r);


            txtLabel.SetValue(row["PROGRMNAME"].replace(/&nbsp;/ig,''));

            document.getElementById("fuATT_FILE_viewdata").value = "";
            document.getElementById("fuATT_FILE_filedata").value = "";

            FILEUPLOAD[0].Init();

            //첨부파일 그리드
            var ht = new Object();
            ht["ATTACH_TYPE"] = "MENUAL_PPT";
            ht["ATTACH_NO"] = row["PROGRAMID"];

            PageMethods.InvokeServiceTable(ht, "Common.CommonBiz", "GetAttachFileList", GetAttachFile_Callback);


            var ht2 = new Object();
            ht2["ATTACH_TYPE"] = "MENUAL_IMG";
            ht2["ATTACH_NO"] = row["PROGRAMID"];
            PageMethods.InvokeServiceTable(ht2, "Common.CommonBiz", "GetAttachFileList", GetAttachImg_Callback);
        }
        /********************************************************************************************
        * 함수명      : GetAttachFile_Callback()
        * 작성목적    : 온로드 콜백 함수
        * Parameter   :
        * Return
        * 작성자      : 김희섭
        * 최초작성일  : 2016-09-22
        * 최종작성일  :
        * 수정내역    :
        ********************************************************************************************/
        function GetAttachFile_Callback(e) {
            var ds = eval(e);

            if (ds.Tables[0].Rows.length > 0) {
                var data = "";
                for (var i = 0; i < ds.Tables[0].Rows.length; i++) {
                    var filename = ds.Tables[0].Rows[i]["FILE_NAME"];
                    var _filesize = parseInt(ds.Tables[0].Rows[i]["FILE_SIZE"]);
                    var filesize = getSize(_filesize);
                    var filepath = "/Resources/Framework/FileDownload.aspx?UNID=" + ds.Tables[0].Rows[i]["ATTACH_UNID"];
                    data += filename + "|" + filesize + "|" + filepath + "^";
                }

                data = data.substring(0, data.length - 1);
                document.getElementById("fuATT_FILE_viewdata").value = data;

                FILEUPLOAD[0].Init();
                $(".ui-icon-circle-minus").hide();
            }
        };
        function GetAttachImg_Callback(e) {
            var ds = eval(e);

            ds.Tables[0].Rows.sort(
                function (a, b) {
                    if (parseInt(a["FILE_NAME"].replace(/[^0-9]/g, '')) >= parseInt(b["FILE_NAME"].replace(/[^0-9]/g, ''))) return 1;
                    else return -1;
                }
            );

            if (ds.Tables[0].Rows.length > 0) {
                for (var i = 0; i < ObjectCount(ds.Tables[0].Rows); i++) {
                    var str = "";
                    str = '<img id="imgManual' + i + '" req="' + i + '" data-original="' + location.origin + "/Resources/Framework/ImageResize.aspx?UNID=" + ds.Tables[0].Rows[i]["ATTACH_UNID"] + '&width=1310&height=720" alt="" title="" class="IMG_lazy" onclick="img_Thum_Click(' + i + ', \'IR\')" />';
                    $("#divIMG").append(str);
                    if (i != ObjectCount(ds.Tables[0].Rows) - 1) {
                        $("#divIMG").append("<br/>");
                    }
                }

                // 이미지 로딩
                $("img.IMG_lazy").lazyload({
                    threshold: 300,        //뷰포트에 보이기 300px 전에 미리 로딩
                    effect: "fadeIn"       //효과
                });
            }
        };
  </script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="conBody">

  <!--타이틀시작-->
    <div id="title">
        <h4>
            <Ctl:Text ID="TXT01" runat="server" LangCode="TXT01" Description="메뉴얼 조회" Literal="true"></Ctl:Text>
            <Ctl:Text ID="txtLabel" runat="server" LangCode="txtLabel" Description="메뉴얼"></Ctl:Text>
        </h4>

        <div class="btn_bx">
        </div>
        <div class="clear"></div>
    </div>
  <!--//타이틀끝-->

  <div id="Msg_box_bg" onclick="return closeLayerPop();"></div>

  <!--컨텐츠시작-->
    <div id="content">
    <!-- 레이어 영역시작 -->
        <Ctl:Layer ID="layer1" runat="server">
            <table style="width:100%;">
                <colgroup>
                    <col style="width:20%;" />
                    <col style="width:80%;" />
                </colgroup>
                <tr>
                    <td id = "grid_list" style="vertical-align:top; border-left:1px solid #EAEAEA;">
                        <Ctl:WebSheet ID="grid1" runat="server" Paging="false" CheckBox="false" Fixation = "false"  Width="100%" TypeName="Common.MenuBiz" MethodName="GetCMN_MENU_TREE_PPT_GET">
                            <Ctl:SheetField DataField="PROGRMNAME" TextField="PROGRMNAME" Description="메뉴명" Width="*"  HAlign="center" Align="left" OnClick="grid1_Onclick" runat="server" Fix = "false" />
                        </Ctl:WebSheet>
                    </td>
                    <td style="border:1px solid #EAEAEA; vertical-align:top;">
                        <table style="width:100%;">
                            <colgroup>
                                <col style="width:20%;" />
                                <col style="width:80%;" />
                            </colgroup>
                            <tr>
                                <th style="color:#646464; font-weight:normal; background:#F1F1F1; border:1px solid #DCDCDCDC;">
                                    <Ctl:Text ID="TXT44" runat="server" LangCode="TXT41" Description="첨부파일"></Ctl:Text>
                                </th>
                                <td>
                                    <Ctl:FileUpload ID="fuATT_FILE" runat="server" ReadMode = "true"></Ctl:FileUpload>
                                </td>
                            </tr>

                            <tr>
                               <td colspan = "2" style="border:1px solid #EAEAEA; vertical-align:top;">
                                    <div id="divIMG" style="width:auto; height:100%; text-align:center; overflow:auto; background-color : #000000; padding : 3px;">
                                    </div>
                               </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
    </Ctl:Layer>
  </div>
</asp:Content>