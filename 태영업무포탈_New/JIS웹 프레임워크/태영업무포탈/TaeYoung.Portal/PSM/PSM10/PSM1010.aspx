<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PSM1010.aspx.cs" Inherits="TaeYoung.Portal.PSM.PSM10.PSM1010" %>

<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {

            // PageLoad시 이벤트 정의부분
            // PageLoad시 이벤트 정의부분
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            // CurrentPageIndex 및 PageSize값은 자동으로 입력되며 필요시 선언하여 넣을수 있다. (Biz에서 해당 항목은 반드시 정의해줘야함)
            // 페이지 갯수 변경 예제 ( 기본 10개 )
            ht["PageSize"] = 15;
            ht["SearchCondition"] = "00";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            //$("#btnSearch").css("background-image", "url(/Resources/Framework/TreeImages/base.gif)");
            //$("#btnSearch").css("background-repeat", "no-repeat");
            //$("#btnSearch").css("background-position", "left");
            //$("#btnSearch").css("padding-left", "20px");

        }

        function Grid1RowClick(r, c) {
            var dr = gridIndex.GetRow(r);

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            ht["PageSize"] = 15;
            ht["SearchCondition"] = dr["CDCODE"];

            gridCodeList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridCodeList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridCodeList.CallBack = function () {
                // 편집 이벤트 제거
                // id+row번호+cell번호 : gridCodeList_0_1
                var dt = gridCodeList.GetAllRow();
                for (var i = 0; i < ObjectCount(dt.Rows); i++) {
                    gridCodeList.EditModeDisable(i, 1); // CODE 번호(1)
                    //gridCodeList.EditModeDisable(i, 2); // 내용 번호(2)
                }
            }
        }

        function btnRowAdd_Click() {

            gridCodeList.InsertRow();

            // 컬럼에 값추가
            // 신규컬럼 : Row의 갯수-1 -> ObjectCount(gridCodeList.GetAllRow().Rows) - 1
            // 바인딩할 컬럼명 : CDINDEX
            // 입력할 값 : gridIndex그리드에서 선택한 값(SelectedRow) -> gridIndex.GetRow(gridIndex.SelectedRow)["CDCODE"]
            gridCodeList.SetValue(ObjectCount(gridCodeList.GetAllRow().Rows) - 1, "CDINDEX", gridIndex.GetRow(gridIndex.SelectedRow)["CDCODE"]);
            gridCodeList.SetValue(ObjectCount(gridCodeList.GetAllRow().Rows) - 1, "CDSTATE", "A");
        }

        function btnSearch_Click() {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["SearchCondition"] = "00";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩
        }

        function btnSave_Click() {

            var ht = new Object();
            var hts = new Array();
            
            var checkRows = gridCodeList.GetCheckRow();
            var cdindex = checkRows[0]['CDINDEX'];

            if (checkRows.length > 0) {

                for (i = 0; i < checkRows.length; i++) {

                    if (checkRows[i]['CDINDEX'] == "")
                    {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG01" Description="인덱스를 입력 하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    if (checkRows[i]['CDCODE'] == "")
                    {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG02" Description="코드를 입력 하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }
                    if (checkRows[i]['CDDESC1'] == "")
                    {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="코드명을 입력 하세요." Literal="true"></Ctl:Text>');
                        return false;
                    }

                    for (j = 0; j < checkRows.length; j++) {
                        if (checkRows[i]['CDCODE'] == checkRows[j]['CDCODE'] && i != j) {
                            alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG03" Description="동일한 코드가 존재합니다." Literal="true"></Ctl:Text>');
                            return false;
                        }
                    }

                    ht = new Object();

                    ht["CDSTATE"] = checkRows[i]['CDSTATE'];
                    ht["CDINDEX"] = checkRows[i]['CDINDEX'];
                    ht["CDCODE"] = checkRows[i]['CDCODE'];
                    ht["CDDESC1"] = checkRows[i]['CDDESC1'];
                    ht["CDDESC2"] = checkRows[i]['CDDESC2'];
                    ht["CDBIGO"] = checkRows[i]['CDBIGO'];

                    hts.push(ht);
                }

                PageMethods.InvokeServiceTableArray(ht, hts, "PSM.PSM1010", "UP_CODE_ADD", function (e) {
                    var DataSet = eval(e);

                    if (ObjectCount(DataSet.Tables[0].Rows) == 1) {

                        if (DataSet.Tables[0].Rows[0]["STATE"] == "OK") {

                            alert('<Ctl:Text runat="server" Description="저장이 완료 되었습니다." Literal="true"></Ctl:Text>');

                            UP_GridList_Serarch(cdindex);
                        }
                        else {
                            var msg = DataSet.Tables[0].Rows[0]["MSG"];
                            alert('<Ctl:Text runat="server" Description="' + msg + '" Literal="true"></Ctl:Text>');
                        }
                    }
                    else {
                        alert('<Ctl:Text runat="server" Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    }
                }, function (e) {
                    // Biz 연결오류
                    alert('<Ctl:Text runat="server"  Description="저장 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                });

                
            }
            else {
                alert("저장할 자료가 없습니다!");
            }

            
        }

        function btnDel_Click() {

            var ht = new Object();
            var hts = new Array();
            var result;

            var checkRows = gridCodeList.GetCheckRow();
            var cdindex = checkRows[0]['CDINDEX'];

            //alert(checkRows.length);
            if (checkRows.length > 0) {
                result = UP_DelCheck(checkRows);
                
                if (UP_DelCheck(checkRows) == true) {

                    for (i = 0; i < checkRows.length; i++) {

                        ht = new Object();

                        ht["CDINDEX"] = checkRows[i]['CDINDEX'];
                        ht["CDCODE"] = checkRows[i]['CDCODE'];

                        hts.push(ht);
                    }

                    PageMethods.InvokeServiceTableArray(ht, hts, "PSM.PSM1010", "UP_CODE_DEL", function (e) {
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 완료 되었습니다." Literal="true"></Ctl:Text>');
                    }, function (e) {
                        // Biz 연결오류
                        alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG20" Description="삭제 중 오류가 발생하였습니다." Literal="true"></Ctl:Text>');
                    });

                    UP_GridList_Serarch(cdindex);
                }
                else
                {
                    alert('<Ctl:Text runat="server" LangCode="btnSearch_MSG04" Description="하위코드가 존재합니다." Literal="true"></Ctl:Text>');
                    return false;
                }
            }
            else {
                alert("삭제할 자료가 없습니다!");
            }
            
        }

        function UP_DelCheck(checkRows)
        {
            var ht2 = new Object();
            var result = true;

            for (i = 0; i < checkRows.length; i++) {

                // CDINEX가 "00" 인 경우 하위코드 존재여부 체크

                if (checkRows[i]['CDINDEX'] == "00") {
                    ht2["CDCODE"] = checkRows[i]['CDCODE'];

                    PageMethods.InvokeServiceTableSync(ht2, "PSM.PSM1010", "UP_CODE_CHECK", function (e) {

                        var DataSet = eval(e);

                        if (ObjectCount(DataSet.Tables[0].Rows) > 0) {

                            result = false;
                        }

                    }, function (e) {
                        // Biz 연결오류
                        alert("Error");
                    });
                }
                if (result == false)
                {
                    break;
                }
            }
            return result;
        }

        function UP_GridList_Serarch(Index) {

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["PageSize"] = 15;
            ht["SearchCondition"] = Index;

            gridCodeList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridCodeList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridCodeList.CallBack = function () {
                // 편집 이벤트 제거
                // id+row번호+cell번호 : gridCodeList_0_1
                var dt = gridCodeList.GetAllRow();
                for (var i = 0; i < ObjectCount(dt.Rows); i++) {
                    gridCodeList.EditModeDisable(i, 1); // CODE 번호(1)
                    //gridCodeList.EditModeDisable(i, 2); // 내용 번호(2)
                }
            }
        }

        
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">  

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="코드관리" DefaultHide="False">
        
        <table style="width: 100%;">
                <colgroup>
                    <col width="25%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td valign="top">
                        <div class="btn_bx">
                            <table class="table_01" style="width: 100%;">    
                                <colgroup>
                                    <col width="*" />
                                </colgroup>
                                <tr>
                                    <td style="text-align:right"";>
                                        <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();">                                            
                                        </Ctl:Button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="PSM.PSM1010" MethodName="UP_CODEINDEX_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30" >
                            <Ctl:SheetField DataField="CDCODE" TextField="CDCODE" Description="CODE" Width="60"  HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                            <Ctl:SheetField DataField="CDDESC1" TextField="CDDESC1" Description="내 용" Width="*" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />                            
                        </Ctl:WebSheet>
                        
                    </td>
                    <td valign="top">
                        <div class="btn_bx">
                            <table class="table_01" style="width: 100%;">    
                                <colgroup>
                                    <col width="*" />
                                </colgroup>
                                <tr>
                                    <td style="text-align:right"";>
                        
                                        <Ctl:Button ID="btnRowAdd" runat="server" LangCode="btnRowAdd" Description="행추가" OnClientClick="btnRowAdd_Click();"></Ctl:Button>
                                        <Ctl:Button ID="btnSave" runat="server" LangCode="btnSave" Description="저장" OnClientClick="btnSave_Click();"></Ctl:Button>
                                        <Ctl:Button ID="btnDel" runat="server" LangCode="btnDel" Description="삭제" OnClientClick="btnDel_Click();"></Ctl:Button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <Ctl:WebSheet ID="gridCodeList" runat="server" Paging="true" CheckBox="true" Width="100%" TypeName="PSM.PSM1010" MethodName="UP_CODEINDEX_LIST" UseColumnSort="true" HeaderHeight="20" CellHeight="30">
                            <Ctl:SheetField DataField="CDSTATE" TextField="CDSTATE" Description="CDSTATE" Width="50"  HAlign="center" Align="left"  runat="server" OnClick="" Hidden="true" />
                            <Ctl:SheetField DataField="CDINDEX" TextField="INDEX" Description="INDEX" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="" />
                            <Ctl:SheetField DataField="CDCODE" TextField="코 드" Description="코 드" Width="100"  HAlign="center" Align="left" Edit="true" runat="server" OnClick="" />
                            <Ctl:SheetField DataField="CDDESC1" TextField="내 용1" Description="내 용1" Width="230" HAlign="center" Align="left" Edit="true" runat="server" OnClick="" />                            
                            <Ctl:SheetField DataField="CDDESC2" TextField="내 용2" Description="내 용2" Width="230" HAlign="center" Align="left" Edit="true" runat="server" OnClick="" />                            
                            <Ctl:SheetField DataField="CDBIGO" TextField="비 고" Description="비 고" Width="*" HAlign="center" Align="left" Edit="true" runat="server" OnClick="" />                            
                        </Ctl:WebSheet>
                    
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 
    </div>
</asp:content>
