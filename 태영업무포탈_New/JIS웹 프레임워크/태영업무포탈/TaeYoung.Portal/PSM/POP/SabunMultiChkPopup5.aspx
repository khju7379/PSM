﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SabunMultiChkPopup5.aspx.cs" Inherits="TaeYoung.Portal.PSM.POP.SabunMultiChkPopup5"%>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="conHead" runat="server">

    <link rel="Stylesheet" href="/Resources/Styles/Common.css" />
    <script type="text/javascript" src="/Resources/Scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/Resources/Scripts/jquery-ui.min.js"></script> 
    <script type="text/javascript" src="/Resources/Scripts/Common.js"></script>

    <style>
            label
            {
                position:relative;
                overflow:visible;
                visibility:visible;
            }
    </style>

    <ext:ResourceManager ID="ResourceManager1" runat="server" />

    <ext:XScript ID="XScript1" runat="server">
        <script type="text/javascript">

            var SABUNSelector = {
                add: function (record) {
                    source = source || GridPanel1;
                    destination = destination || #{GridPanel2};
                    if (source.selModel.hasSelection()) {
                        var records = source.selModel.getSelection();
                        source.store.remove(records);
                        destination.store.add(records);
                    }
                },
                addAll: function (source, destination) {
                    source = source || GridPanel1;
                    destination = destination || GridPanel2;
                    var records = source.store.getRange();
                    source.store.removeAll();
                    destination.store.add(records);
                },
                addByName: function (name) {
                    if (!Ext.isEmpty(name)) {
                        var result = Store1.queryBy(function (r) {
                            return r.get("Name") === name;
                        });
                        if (!Ext.isEmpty(result.items)) {
                            GridPanel1.store.remove(result.items[0]);
                            GridPanel2.store.add(result.items[0]);
                        }
                    }
                },
                addByNames: function (name) {
                    for (var i = 0; i < name.length; i++) {
                        this.addByName(name[i]);
                    }
                },
                remove: function (source) {
                    source = source || #{GridPanel2};
                    if (source.selModel.hasSelection()) {
                        var records = source.selModel.getSelection();
                        source.store.remove(records);
                    }
                },
                removeAll: function (destination) {
                    destination.store.removeAll();
                }
            }

            

            function Select_Remove() {

                if (#{HdnCheck}.getValue() == '1') <%-- 요청 결재 --%>
                {
                    var iSeq = 0;
                    var i = 0;

                    if (#{HdnSOCnt}.getValue() == '')
                    {
                        iSeq = 1;
                    }
                    else
                    {
                        iSeq = parseInt(#{HdnSOCnt}.getValue()) + 1;
                    }

                    var records = #{RowSel2}.getSelection();
                    for (i = 0; i < records.length; i++) {
                        if (records[i].data.SEQ > iSeq) {
                            #{GridPanel2}.store.remove(records[i]);
                        }
                    }
                } <%-- 수신 결재 --%>
                else if (#{HdnCheck}.getValue() == '2')
                {
                    var iSeq = 0;

                    if (#{HdnRECnt}.getValue() == '')
                    {
                        iSeq = 1;
                    }
                    else
                    {
                        iSeq = parseInt(#{HdnRECnt}.getValue()) + 1;
                    }

                    var records = #{RowSel3}.getSelection();
                    for (i = 0; i < records.length; i++) {
                        if (records[i].data.SEQ > iSeq) {
                            #{GridPanel3}.store.remove(records[i]);
                        }

                        // 추가(20150916)
                        if (iSeq == 1) {
                            #{GridPanel3}.store.remove(records[i]);
                        }
                    }
                } <%-- 참조자 --%>
                else
                {
                    var records = #{RowSel5}.getSelection();
                    for (var i = 0; i < records.length; i++) {
                        #{GridPanel5}.store.remove(records[i]);
                    }
                }
            };

            function btnSelect_ClientClick() {
                try {

                    debugger;

                    if (#{HdnCnt2}.getValue() != '0')
                    {
                        var data1 = #{Store2}.data.items;
                        var data2 = #{Store3}.data.items;
                        var data3 = #{Store5}.data.items;
                        eval("opener." + #{hdnCallBack}.getValue() + "(data1,data2,data3);");
                    }
                        else
                    {
                        var data = #{Store2}.data.items;
                        eval("opener." + #{hdnCallBack}.getValue() + "(data);");
                    }
                }
                catch (ex) { }
                finally {
                    window.close();
                }
            }


            /********************************************************************************************
            *   GridPanel1 -> GridPanel2로 복사
            ********************************************************************************************/
            function grd_ClientCellDblClick(item, td, cellIndex, record, tr, rowIndex, e) {
                #{GridPanel2}.store.add
                    (
                        {
                            KBSABUN: record.data.KBSABUN,
                            KBHANGL: record.data.KBHANGL,
                            CDDESC1: record.data.CDDESC1
                        }
                    );
            };





            /********************************************************************************************
            *   함수명      : LoadPage(TabPanel, Node)
            *   작성목적    : 트리메뉴의 노드 클릭시 해당 페이지를 탭 컨트롤에 위치시킨다.
            *   수정내역    : 2012-11-13 MenuID 관련 제거
            *                 2012-11-27 Ext.NET 2.1 컨버젼 작업 중 수정
            *                 2013-03-19 주요업무정보 등 바로가기를 위한 파라미터 변경
            ********************************************************************************************/
            var LoadPage = function (sabun, name, jkcd) {
                var JIKGUB;
                var JKCD;
                var SABUN;
                var IRUM;
                var check;
                var data;
                var i;

                check = "";

                SABUN = sabun;

                if (name.split(" ").length == 2) {
                    JIKGUB = name.split(" ")[0];
                    IRUM = name.split(" ")[1];
                }

                if (jkcd.split(" ").length == 2) {
                    JKCD = jkcd.split(" ")[1];
                }

                // 요청자
                if (#{HdnCheck}.getValue() == '1')
                {
                    if (#{HdnSOSign}.getValue() == 'Complete')
                    {
                        check = "pass";
                    }
                    else
                    {
                        data = #{Store2}.data.items;

                        for (i = 0; i < data.length; i++) {
                            if (data[i].data.KBHANGL == IRUM) {
                                check = "pass";
                            }
                        }

                        if (data.length == #{HdnCnt1}.getValue())
                        {
                            Ext.MessageBox.alert('알림', "결재선 인원수를 확인하세요.");
                            return;
                        }
                    }

                    
                }
                else // 수신자
                {
                    data = #{Store3}.data.items;

                    for (i = 0; i < data.length; i++) {
                        if (data[i].data.KBHANGL == IRUM) {
                            check = "pass";
                        }
                    }

                    if (data.length == #{HdnCnt2}.getValue())
                    {
                        Ext.MessageBox.alert('알림', "수신 결재선 인원수를 확인하세요.");
                        return;
                    }

                    if (#{HdnSOSign}.getValue() != 'Complete')
                    {
                        if (#{HdnRECnt}.getValue() == '')
                        {
                            if (data.length == 1) {
                                Ext.MessageBox.alert('알림', "요청자는 수신결재자를 한명만 지정할 수 있습니다.");
                                return;
                            }
                        }
                    }
                }

                if (check == "") {
                    if (#{HdnCheck}.getValue() == '1')
                    {
                            #{GridPanel2}.store.add
                            (
                                {
                                    SEQ: data.length + 1,
                                    KBSABUN: SABUN,
                                    KBHANGL: IRUM,
                                    CDDESC1: JIKGUB,
                                    JKCODE: JKCD
                                }
                            )
                    }
                    else
                    {
                            #{GridPanel3}.store.add
                            (
                                {
                                    SEQ: data.length + 1,
                                    KBSABUN: SABUN,
                                    KBHANGL: IRUM,
                                    CDDESC1: JIKGUB,
                                    JKCODE: JKCD
                                }
                            )
                    }
                }
            }

            /********************************************************************************************
            *   작성목적    : 
            *   수정내역    :
            ********************************************************************************************/
            function BindMenu() {
                var menu = #{pnlMenu};
                menu.removeAll();

                App.direct.GetMenuJson(true, {
                    success: function (result) {
                        var nodes = eval(result);
                        if (nodes.length > 0) {
                            var tmpTree, nodeID;
                            for (var i = 0; i < nodes.length; i++) {
                                nodeID = nodes[i].id;
                                tmpTree = Ext.create("Ext.tree.Panel", {
                                    id: "treMenu" + nodeID,
                                    menu_no: nodeID,
                                    border: false,
                                    xtype: "treepanel",
                                    autoScroll: true,
                                    animCollapse: false,
                                    collapsed: (nodeID != "PS4171Y980"),
                                    title: nodes[i].text,
                                    animate: false,
                                    rootVisible: false,
                                    checked: false,
                                    root: nodes[i],
                                    listeners: {
                                        itemclick: {
                                            fn: function (item, record, node, index, e) {
                                                if (record.data.href) {
                                                    e.stopEvent();
                                                    LoadPage(record.getId(), record.data.text, record.data.href, record.data.dataPath);
                                                }
                                            }
                                        }
                                    }
                                });
                                menu.add(tmpTree);
                                tmpTree.expandAll();
                                if (nodeID == "A10000") {
                                    tmpTree.expand();
                                }
                            }
                        }
                    },
                    eventMask: {
                        showMask: true,
                        msg: "로딩중...",
                        target: "customtarget",
                        customTarget: menu
                    }
                });
            }

            /********************************************************************************************
            *   작성목적    : 요청 및 수신결재 선택
            *   수정내역    :
            ********************************************************************************************/
            function chk_ClientChange(gubun) {

                #{HdnCheck}.setValue(gubun);

                if (#{HdnCnt2}.getValue() == '0')
                {
                    #{rdoGUBUN2}.setReadOnly(true);
               }

                if (gubun == '1') {
                    #{pnlMenu}.setVisible(true);
                    #{pnlMove}.setVisible(false);
                    #{pnlReference}.setVisible(false);

                    #{GridPanel2}.setVisible(true);
                    #{GridPanel3}.setVisible(false);
                    #{GridPanel5}.setVisible(false);
               }
                else if (gubun == '2') {
                    #{pnlMenu}.setVisible(true);
                    #{pnlMove}.setVisible(false);
                    #{pnlReference}.setVisible(false);

                    #{GridPanel2}.setVisible(false);
                    #{GridPanel3}.setVisible(true);
                    #{GridPanel5}.setVisible(false);
               }
                else if (gubun == '3') {
                    #{pnlMenu}.setVisible(false);
                    #{pnlMove}.setVisible(true);
                    #{pnlReference}.setVisible(true);

                    #{GridPanel2}.setVisible(false);
                    #{GridPanel3}.setVisible(false);
                    #{GridPanel5}.setVisible(true);
                }
            }

            function checkchange(node, checked, object) {
                // 하위 트리 선택되게 하는 부분
                node.cascadeBy(function (n) {
                    n.set('checked', checked);
                });
            }

            var getCheckedNodes = function () {

                var selNodes = #{pnlReference}.getChecked();
                var id, data, check;

                Ext.each(selNodes, function (node) {

                    id = node.data.id.substr(0, 1);

                    check = "";

                    // 팀 및 파트 코드가 아닌 경우 그리드에 보여줌
                    if (id != 'Z' && id != 'A' && id != 'D' && id != 'E' && id != 'S' && id != 'T') {
                        data = #{Store5}.data.items;

                        for (i = 0; i < data.length; i++) {
                            if (data[i].data.KBSABUN == node.data.id) {
                                check = "pass";
                            }
                        }

                        if (check == "") {
                            #{GridPanel5}.store.add
                                (
                                    {
                                        KBSABUN: node.data.id,
                                        KBHANGL: node.data.text
                                    }
                                )
                        }
                    }
                });
            };

        </script>

        
    </ext:XScript>
    
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="conBody" runat="server">
    <ext:Hidden ID="hdnCallBack" runat="server"></ext:Hidden>
    <ext:Hidden ID="HdnCnt1"     runat="server"></ext:Hidden> <%-- 요청 결재라인수  --%>
    <ext:Hidden ID="HdnCnt2"     runat="server"></ext:Hidden> <%-- 수신 결재라인수  --%>
    <ext:Hidden ID="HdnSOCnt"    runat="server"></ext:Hidden> <%-- 현재 요청 결재라인자리  --%>
    <ext:Hidden ID="HdnRECnt"    runat="server"></ext:Hidden> <%-- 현재 수신 결재라인자리  --%>
    <ext:Hidden ID="HdnGubun"    runat="server"></ext:Hidden> <%-- 결재에 따른 구분 --%>
    <ext:Hidden ID="HdnCheck"    runat="server"></ext:Hidden> <%-- 요청 및 수신, 참조자 옵션 선택 --%>
    <ext:Hidden ID="HdnSOAPPROVAL" runat="server"></ext:Hidden><%-- 요청 현재 결재자 --%>
    <ext:Hidden ID="HdnREAPPROVAL" runat="server"></ext:Hidden><%-- 수신 현재 결재자 --%>
    <ext:Hidden ID="HdnSOSign" runat="server"></ext:Hidden><%-- 요청완료구분 --%>

    <div>
        <ext:Label ID="Label1" runat="server"></ext:Label>
            
        <ext:Panel ID="pnlMain" runat="server" Layout="VBoxLayout" Icon="Money" Title="결재자 조회" Border="true" Padding="2" Width = "600" Height = "380">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Stretch"></ext:VBoxLayoutConfig>
            </LayoutConfig>
            <Items>
                <ext:Panel ID="Panel1" runat="server" Region="North" Border="false" Frame = "true" width = "600">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:ToolbarFill ID="ToolbarFill2" runat="server"></ext:ToolbarFill>
                        <ext:Button ID="Button6" runat="server" Text="결재선 지정" Icon="Accept">
                            <Listeners>
                                <Click Handler="btnSelect_ClientClick();" />
                            </Listeners>
                        </ext:Button>
                        <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10"></ext:ToolbarSpacer>
                        <ext:Button ID="Button7" runat="server" Text="결재선 삭제" Icon="Delete">
                            <Listeners>
                                <Click Handler="Select_Remove()" />
                                <%--<Click Handler="SABUNSelector.removeAll(#{GridPanel2});" />--%>
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="grdList" runat="server" Region="Center" Layout = "HBoxLayout" width = "600" Height = "300">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Panel ID="Panel2" runat = "server" Layout = "VBoxLayout" Width = "260" Height = "300">
                            <LayoutConfig>
                                <ext:VBoxLayoutConfig Align="Stretch"></ext:VBoxLayoutConfig>
                            </LayoutConfig>
                            <Items>
                                <ext:Panel ID="pnlMenu" runat="server" Layout="AccordionLayout" Border="true" Width="240px"  Frame="false" OverflowY = "Auto" Height = "300" AnimCollapse="false">
                                    <LayoutConfig>
                                        <ext:AccordionLayoutConfig OriginalHeader="true" Animate="false" />
                                    </LayoutConfig>
                                </ext:Panel>

                                <ext:TreePanel ID="pnlReference" runat="server" Border="true" WIDTH ="240px" Frame ="false" OverflowY = "Auto" Height = "300"
                                    AnimCollapse="false" RootVisible="false">
                                    <Root>
                                        <ext:Node NodeID="Tree" Text="메뉴"></ext:Node>                                                
                                    </Root>                   
                                    <ColumnModel>
                                        <Columns>
                                            <ext:TreeColumn ID="TreeColumn2" runat="server" Flex="1"  DataIndex="text" Text="참조자" Sortable="false">

                                            </ext:TreeColumn>
                                        </Columns>
                                    </ColumnModel>
                                    <%--<SelectionModel>
                                        <ext:CheckboxSelectionModel  runat="server" Mode="Multi"></ext:CheckboxSelectionModel>
                                    </SelectionModel>--%>
                                    <%--<Listeners>
                                        <CheckChange Handler = "if(checked) { #{pnlReference}.getId('Tree').ui.toggleCheck(true);}" ></CheckChange>
                                    </Listeners>--%>


                                    <Listeners>
                                        <CheckChange fn="checkchange" ></CheckChange>

                                        <%--<CheckChange Handler="Ext.Msg.alert('CheckChange', checked);" ></CheckChange>--%>
                                    </Listeners>
                                </ext:TreePanel>
                            </Items>
                        </ext:Panel>

                        <ext:Panel runat="server" Width="70" BodyStyle="background-color: transparent;" Border="false">
                            <Items>
                                <ext:Panel runat="server" Border="false" BodyStyle="background-color: transparent;" AnchorVertical="40%" />
                                <ext:Panel runat="server" Border="false" BodyStyle="background-color: transparent;" BodyPadding="5">
                                    <Items>
                                        <ext:Panel ID = "pnlMove" runat = "server" Layout = "VBoxLayout" Border = "false">
                                            <LayoutConfig>
                                                <ext:VBoxLayoutConfig Align="Center"></ext:VBoxLayoutConfig>
                                            </LayoutConfig>
                                            <Items>
                                                <ext:Panel ID="Panel6" runat = "server" Layout = "HBoxLayout" Border = "false" Height = "300">
                                                    <LayoutConfig>
                                                        <ext:HBoxLayoutConfig Align="Middle"></ext:HBoxLayoutConfig>
                                                    </LayoutConfig>
                                                    <Items>
                                                        <ext:Button ID="Button1" runat="server" Icon = "PlayGreen" Text="이동">
                                                            <Listeners>
                                                                    <Click Handler="getCheckedNodes()"></Click>
                                                            </Listeners>
                                                        </ext:Button>
                                                    </Items>
                                                </ext:Panel>
                                            </Items>
                                        </ext:Panel>
                                    </Items>
                                </ext:Panel>
                            </Items>
                        </ext:Panel>

                        <ext:Panel ID="Panel3" runat = "server" Layout = "VBoxLayout" Width = "260">
                            <LayoutConfig>
                                <ext:VBoxLayoutConfig Align="Stretch"></ext:VBoxLayoutConfig>
                            </LayoutConfig>
                            <Items>
                                <ext:Panel ID="Panel5" runat="server" Layout="HBoxLayout" Border="false" Region="North">
                                    <LayoutConfig>
                                        <ext:HBoxLayoutConfig Align="Middle"></ext:HBoxLayoutConfig>
                                    </LayoutConfig>
                                    <Items>
                                        <ext:RadioGroup ID="RadioGroup1" runat="server" Layout="HBoxLayout" flex = "1">
                                            <LayoutConfig>
                                                <ext:HBoxLayoutConfig Align="Stretch" ></ext:HBoxLayoutConfig>
                                            </LayoutConfig>
                                            <Items>

                                                <ext:Radio ID="rdoGUBUN1" runat="server" Margins="0 0 0 5" Checked = "true">
                                                    <Listeners>
                                                        <%--<Blur Handler="chk_ClientChange(2);"></Blur>--%>
                                                        <Focus Handler="chk_ClientChange(1);"></Focus>
                                                    </Listeners>
                                                </ext:Radio>
                                                <ext:Label ID="Label2" runat="server" Width ="60" Text="요청결재" Margins="1 0 0 5"></ext:Label>

                                                <ext:Radio ID="rdoGUBUN2" runat="server" Margins="0 0 0 5">
                                                    <Listeners>
                                                        <%--<Blur Handler="chk_ClientChange(1);"></Blur>--%>
                                                        <Focus Handler="chk_ClientChange(2);"></Focus>
                                                    </Listeners>
                                                </ext:Radio>
                                                <ext:Label ID="lblGUBUN2" runat="server" Width ="60" Text="수신결재" Margins="1 0 0 5"></ext:Label>

                                                <ext:Radio ID="rdoGUBUN3" runat="server" Margins="1 0 0 5">
                                                    <Listeners>
                                                        <%--<Blur Handler="chk_ClientChange(1);"></Blur>--%>
                                                        <Focus Handler="chk_ClientChange(3);"></Focus>
                                                    </Listeners>
                                                </ext:Radio>
                                                <ext:Label ID="Label3" runat="server" Width ="70" Text="참조자" Margins="1 0 0 5"></ext:Label>

                                            </Items>
                                        </ext:RadioGroup>
                                    </Items>
                                </ext:Panel>

                                <ext:Panel ID="Panel4" runat="server" Layout="HBoxLayout" Border="false" width = "260" Region="Center">
                                    <LayoutConfig>
                                        <ext:HBoxLayoutConfig Align="Middle"></ext:HBoxLayoutConfig>
                                    </LayoutConfig>
                                    <Items>
                                        <ext:GridPanel runat="server" ID="GridPanel2" EnableDragDrop="false" Width = "260" Height = "300">
                                            <Store>
                                                <ext:Store runat="server" ID="Store2">
                                                    <Model>
                                                        <ext:Model ID="Model4" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="SEQ" />
                                                                <ext:ModelField Name="KBSABUN" />
                                                                <ext:ModelField Name="KBHANGL" />
                                                                <ext:ModelField Name="CDDESC1" />
                                                                <ext:ModelField Name="JKCODE" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="ColumnModel2" runat="server">
	                                            <Columns>
                                                    <ext:Column runat="server" Text="순번"     DataIndex="SEQ"     Sortable = "true" width = "30"  Hidden = "true"></ext:Column>
                                                    <ext:Column runat="server" Text="사번"     DataIndex="KBSABUN" Flex="30"></ext:Column>
                                                    <ext:Column runat="server" Text="이름"     DataIndex="KBHANGL" Flex="70"></ext:Column>
                                                    <ext:Column runat="server" Text="직급"     DataIndex="CDDESC1" Flex="1" Hidden = "true"></ext:Column>
                                                    <ext:Column runat="server" Text="직급코드" DataIndex="JKCODE" Flex="1" Hidden = "true"></ext:Column>
	                                            </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:CheckboxSelectionModel ID="RowSel2" runat="server"></ext:CheckboxSelectionModel>
                                                <%--<ext:RowSelectionModel ID="RowSel" runat="server" Mode="Multi" />--%>
                                            </SelectionModel>  
                                        </ext:GridPanel>

                                        <ext:GridPanel runat="server" ID="GridPanel3" EnableDragDrop="false" Width = "260" Height = "300">
                                            <Store>
                                                <ext:Store runat="server" ID="Store3">
                                                    <Model>
                                                        <ext:Model ID="Model1" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="SEQ" />
                                                                <ext:ModelField Name="KBSABUN" />
                                                                <ext:ModelField Name="KBHANGL" />
                                                                <ext:ModelField Name="CDDESC1" />
                                                                <ext:ModelField Name="JKCODE" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="ColumnModel1" runat="server">
	                                            <Columns>
                                                    <ext:Column runat="server" Text="순번"     DataIndex="SEQ"     Sortable = "true" width = "30"  Hidden = "true"></ext:Column>
                                                    <ext:Column runat="server" Text="사번"     DataIndex="KBSABUN" Flex="30"></ext:Column>
                                                    <ext:Column runat="server" Text="이름"     DataIndex="KBHANGL" Flex="70"></ext:Column>
                                                    <ext:Column runat="server" Text="직급"     DataIndex="CDDESC1" Flex="1" Hidden = "true"></ext:Column>
                                                    <ext:Column runat="server" Text="직급코드" DataIndex="JKCODE" Flex="1" Hidden = "true"></ext:Column>
	                                            </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:CheckboxSelectionModel ID="RowSel3" runat="server"></ext:CheckboxSelectionModel>
                                                <%--<ext:RowSelectionModel ID="RowSel" runat="server" Mode="Multi" />--%>
                                            </SelectionModel>  
                                        </ext:GridPanel>

                                        <ext:GridPanel runat="server" ID="GridPanel5" EnableDragDrop="false" OverflowY = "Auto" Width = "260" Height = "270">
                                            <Store>
                                                <ext:Store runat="server" ID="Store5">
                                                    <Model>
                                                        <ext:Model ID="Model2" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="KBSABUN" />
                                                                <ext:ModelField Name="KBHANGL" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="ColumnModel3" runat="server">
	                                            <Columns>
                                                    <ext:Column ID="Column1" runat="server" Text="사번" DataIndex="KBSABUN" Flex="30"></ext:Column>
                                                    <ext:Column ID="Column2" runat="server" Text="이름" DataIndex="KBHANGL" Flex="70"></ext:Column>
	                                            </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:CheckboxSelectionModel ID="RowSel5" runat="server"></ext:CheckboxSelectionModel>
                                                <%--<ext:RowSelectionModel ID="RowSel" runat="server" Mode="Multi" />--%>
                                            </SelectionModel>  
                                        </ext:GridPanel>

                                    </Items>
                                </ext:Panel>
                            
                            </Items>
                        </ext:Panel>
                                        
                    </Items>
                </ext:Panel>

            </Items>
        </ext:Panel>
        
    </div>
    
</asp:Content>