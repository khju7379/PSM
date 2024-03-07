<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TYDefault2.aspx.cs" Inherits="TaeYoung.Template.TYDefault2" %>
<asp:content id="HeaderContent" runat="server" contentplaceholderid="conHead">
    <script type="text/javascript">

        function OnLoad() {

            // PageLoad시 이벤트 정의부분
            // PageLoad시 이벤트 정의부분
            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.
            // CurrentPageIndex 및 PageSize값은 자동으로 입력되며 필요시 선언하여 넣을수 있다. (Biz에서 해당 항목은 반드시 정의해줘야함)
            // 페이지 갯수 변경 예제 ( 기본 10개 )
            ht["SearchCondition"] = "00";

            gridIndex.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridIndex.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

        }

        function Grid1RowClick(r, c) {
            var dr = gridIndex.GetRow(r);

            var ht = new Object(); // 쿼리에 파라미터를 넘길 Object를 선언한다.

            ht["SearchCondition"] = dr["CDCODE"];

            gridCodeList.Params(ht); // 선언한 파라미터를 그리드에 전달함
            gridCodeList.BindList(1); // 페이징 번호를 1로하여 (CurrentPageIndex=1) 그리드를 바인딩

            gridCodeList.CallBack = function () {
                // 편집 이벤트 제거
                // id+row번호+cell번호 : gridCodeList_0_1
                var dt = gridCodeList.GetAllRow();
                for (var i = 0; i < ObjectCount(dt.Rows); i++) {
                    gridCodeList.EditModeDisable(i, 1); // CODE 번호(1)
                    gridCodeList.EditModeDisable(i, 2); // 내용 번호(2)
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
        } 
      
    </script>
</asp:content>

<asp:content id="BodyContent" runat="server" contentplaceholderid="conBody">
    <!--타이틀시작-->
    <div id="title">
        <h4><Ctl:Text ID="tSubject" runat="server" LangCode="tSubject" Description="페이지 제목을 입력하세요" Literal="true"></Ctl:Text></h4>

        <div class="btn_bx">
            <!-- 상단의 버튼을 정의 -->
            <Ctl:Button ID="btnSearch" runat="server" LangCode="btnSearch" Description="조회" OnClientClick="btnSearch_Click();"></Ctl:Button>

            <Ctl:Button ID="btnRowAdd" runat="server" LangCode="btnRowAdd" Description="행추가" OnClientClick="btnRowAdd_Click();"></Ctl:Button>
        </div>
        <div class="clear"></div>
    </div>
    <!--//타이틀끝-->

    <!--컨텐츠시작-->
    <div id="content">
        <Ctl:Layer ID="layer1" runat="server" Title="레이어 제목을 입력하세요" DefaultHide="False">
        <table class="table_01" style="width: 100%;">
                <colgroup>
                    <col width="25%" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <td valign="top">
                        
                         <Ctl:WebSheet ID="gridIndex" runat="server" Paging="true" CheckBox="false" Width="100%" TypeName="QM.QMBiz" MethodName="UP_HRCODE" UseColumnSort="true">
                            <Ctl:SheetField DataField="CDCODE" TextField="CDCODE" Description="CODE" Width="60"  HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />
                            <Ctl:SheetField DataField="CDDESC1" TextField="CDDESC1" Description="내 용" Width="*" HAlign="center" Align="left" runat="server" OnClick="Grid1RowClick" />                            
                        </Ctl:WebSheet>
                        
                    </td>
                    <td valign="top">
                    
                         <Ctl:WebSheet ID="gridCodeList" runat="server" Paging="true" CheckBox="true" Width="100%" TypeName="QM.QMBiz" MethodName="UP_HRCODE" UseColumnSort="true">
                            <Ctl:SheetField DataField="CDINDEX" TextField="CDCODE" Description="CODE" Width="60"  HAlign="center" Align="left"  runat="server" OnClick="" />
                            <Ctl:SheetField DataField="CDCODE" TextField="CDCODE" Description="CODE" Width="60"  HAlign="center" Align="left" Edit="true" runat="server" OnClick="" />
                            <Ctl:SheetField DataField="CDDESC1" TextField="CDDESC1" Description="내 용" Width="*" HAlign="center" Align="left" Edit="true" runat="server" OnClick="" />                            
                        </Ctl:WebSheet>
                    
                    </td>
                </tr>
            </table>        
        </Ctl:Layer> 


    </div>
</asp:content>