//
// 화면제어 스크립트
//
// 페이지 로드
$(document).ready(function () {
    FormResize();
    // 메뉴의 넓이를 재정의
    //$("#topmenu").width($("#topmenu_bx").width() - 400);
    //$("#topmenu").show();
    var isProgressLoadComplete = false;
    // 프로그래스바를 검색하여 모든 컨트롤이 로드 완료시 처리
    var progress_interval = setInterval(function () {
        isProgressLoadComplete = true;
        $(".websheet_progress").each(function () {
            if ($(this).css("display") != "none") {
                isProgressLoadComplete = false; 
            }
        });
        if (isProgressLoadComplete) {
            clearInterval(progress_interval); //822-805
            if (location.href.indexOf("Main.aspx") < 0 && location.href.indexOf("Main_Partner.aspx") < 0) {
                var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.  
                //$("#bottom_bx").css("top", (position + $(window).height()) + "px");
                $("#bottom_bx").fadeTo("slow", 1, function () {
                });
                // 팝업이 아닐시 화면의 크기를 조절
                if (IsPopup != true) {
                    //var doc_height = $("#sub_body").height();
                    //var win_height = $(window).height();
                    //if (win_height > doc_height) {
                    //    doc_height = win_height;
                    //}
                    //var win_height = $(window).height();
                    //var menu_height = $("#treeMenu").find("#treeMenu").eq(1).height(); // $("#treeMenu").height();
                    //
                    //if (doc_height > menu_height) {
                    //    $("#treeMenu").height(doc_height + 50);
                    //    $("#treeMenu").find("#treeMenu").height(doc_height + 50);
                    //}
                    //else if (doc_height <= menu_height) {
                    //    $("#sub_body").height(menu_height + 50);
                    //    $("#treeMenu").find("#treeMenu").height(menu_height + 50);
                    //}

                    var win_height = $(window).height();

                    // 문서의 높이 계산
                    var doc_height = $(document).height();
                    //$("#container").height(doc_height-100);//상단 100px 제외한 높이가 문서의 높이로 강제로 지정

                    //alert($("#container").height());
                    //alert($(document).height());
                    //if ($("#container").height() > $(document).height()) {
                    //    $("#container").css("height", ($(window).height() - 85) + "px");
                    //}
                    //else {
                    //    if ($("#topmenu_bx").length > 0) $("#container").css("height", ($(document).height() - 80) + "px");
                    //    else $("#container").css("height", ($(document).height()) + "px");
                    //}
                }
            }
            else {
                var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.  
                $("#bottom_bx2").fadeTo("slow", 1, function () {
                });
            }

            // 좌측메뉴 위치 재조정
            var win_height = $(window).height();
            var doc_height = $(document).height();
            var scrollTop = $(window).scrollTop();
            // 문서 - 화면 - 스크롤 = 보이는 최하단 위치
            $("#menuQList").css("bottom", (doc_height - win_height - scrollTop + 0) + "px");
            //$("#bottomLine").css("top", doc_height - 3 + "px");
            //$("#bottomLine").css("bottom", (doc_height - win_height - scrollTop) + "px");
            // 좌측메뉴의 높이 
            $("#leftmenu_bx").height(doc_height - 100);
            //            if ($("#leftmenu_bx").height() > $("#content").height()) {
            //                $("#content").height($("#leftmenu_bx").height());
            //            }
            //if(!IsPopup) $("#sub_body #container").css("background-color", "#A32958");
        }
    }, 250);
    setInterval(function () {
        var win_height = $(window).height();
        var doc_height = $(document).height();
        var scrollTop = $(window).scrollTop();
        // 문서 - 화면 - 스크롤 = 보이는 최하단 위치
        $("#menuQList").css("bottom", (doc_height - win_height - scrollTop + 0) + "px");
        $("#leftmenu_bx").height(doc_height - 100);
    }, 100);

    $(window).scroll(function () {
        // 좌측메뉴 위치 재조정
        var win_height = $(window).height();
        var doc_height = $(document).height();
        var scrollTop = $(window).scrollTop();
        // 문서 - 화면 - 스크롤 = 보이는 최하단 위치
        $("#menuQList").css("bottom", (doc_height - win_height - scrollTop + 0) + "px");
        $("#leftmenu_bx").height(doc_height - 100);
        //$("#bottomLine").css("top", doc_height + "px");
    });

    // 레이어에 탭이 있을시 탭의 처음 설정
    //$(".table .title_02 li:first").find("a").addClass("on");
    //$(".table .title_02_tapbody:first").show();
    // 탭이 다중일시 처리
    $(".table_tab").each(function () {
        $(this).find(".tab li:first").find("a").addClass("on");
        $(this).find(".title_02_tapbody:first").show();
    });

    // 레이어 선택시 화면처리
    $(".table_tab .tab li a").bind("click", function () {
        // 탭의 마지막은 숨겸 펼침 버튼이므로 예외처리함
        if ($(this).find("img").length > 0) return;

        $(this).parent().parent().find("a").removeClass("on");
        var i = 0;
        var o = this;
        var layer_num = 0;
        $(this).parent().parent().find("a").each(function () {
            if (this == o) {
                $(this).addClass("on");
                layer_num = i;
            }
            i++;
        });

        // 선택한 번호의 div 오픈
        //$(".table .title_02_tapbody").hide();
        //$($(".table .title_02_tapbody")[layer_num]).show();
        // 탭이 다중일시 처리
        $(this).parent().parent().parent().find(".title_02_tapbody").hide();
        $($(this).parent().parent().parent().find(".title_02_tapbody")[layer_num]).show();

        if (typeof TabChanged != "undefined") {
            TabChanged(layer_num);
        }
    });

    // 세션 유지를 위하여 메소드 강제호출
    setInterval(function () {
        PageMethods.InvokeSessionState(function () { }, function (e) {
            //alert(e.get_message());
        })
    }, 600000);

    // 좌측메뉴 소팅 적용
    //treeMenu.sortItem = function (a, b) {
    //    if (a.Values[11] > b.Values[11]) return 1;
    //    else return -1;
    //}



});

$(window).resize(function () {
    FormResize();
});

function FormResize() {
    // 폼의 넓이 높이가 안잡히는 문제로 인하여 강제로 지정
//    var width = $(document).width();
//    var height = $(document).height();
//    $("#form1").width(width);
    //    $("#form1").height(height);
    $(".JINSheet_ScrollBody").each(function () {
        var objWidth = $(this).parent().width();
        //$(this).width(objWidth);
    });
}

// 메뉴 이동
function fnMenuOpen(url) {
	if (url.startsWith("ShowPopup")) {
		eval(url);
	}
	else if (url.startsWith("Location")) {
		eval(url);
	}
	else {
		PageProgressShow();
		location.href = url;
	}
}

function Site_UI_Loaded() {
    
}

function ShowPopup(url, name ,width, height) {
    var retfeature = "";
    nLeft = (window.screen.width - width) / 2;
    nTop = (window.screen.height - height) / 2;
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
// 화면이동
function Location(url) {
	location.href = url;
}
// 프로그래스바 활성
function PageProgressShow() {
	$("form").append("<div id='pageProgressLayer' />");

	$("#pageProgressLayer").css("background-color", "rgba(0,0,0,0.2)");
	//$("#pageProgressLayer").fadeIn("slow");
	$("#pageProgressLayer").css("cursor", "wait");
	$("#pageProgressLayer").css("position", "absolute");
	$("#pageProgressLayer").css("left", "0px");
	$("#pageProgressLayer").css("top", "0px");
	$("#pageProgressLayer").css("z-index", "1000000");
	$("#pageProgressLayer").width($(document).width());
	$("#pageProgressLayer").height($(document).height());
}
// 프로그래스바 비활성
function PageProgressHide() {
    $("#pageProgressLayer").remove();   
}
// 퀵메뉴 환경설정
function fnQuickMenuEdit() {
	if ($("#quickmenu_config").length > 0) $("#quickmenu_config").remove();
	PageProgressShow();
	$("form").append("<div id='quickmenu_config' />");
	$.get("/Portal/QuickMenu.aspx?MasterPage=N", function (response) {
		$("#quickmenu_config").html($(response).find("#content").html());
		// 크기 980*606
		// 위치는 margin-top이 0일시 퀵메뉴 하단에 위치함으로 606+(화면크기 - 606)/2 만큼 위로 이동한다.
		var window_height = $(window).height();
		var margin_top = 606 + ((window_height - 600) / 2);
		// 위치는 margin-left이 0일시 화면 최좌측에 위치함으로 (화면크기 - 980)/2 만큼 우로 이동한다.
		var window_width = $(window).width();
		var margin_left = ((window_width - 980) / 2);
		$("#quickmenu_config").css("margin-top", "-" + margin_top + "px")
			.css("position", "absolute")
			.css("z-index", "10")
			.css("margin-left", margin_left + "px");

		//PageProgressHide();
	});
}

// ToDo
var ToDoList = function () {
	this.Add = function ( sgubun,  tgubun,  subject,  strdat,  enddat,  tuser,  tstate,  tkey,  tparm,  regdat,  tbigo,  companycode,  plant, formid) {
		var ht = new Object();

		ht["SGUBUN"] = sgubun;
		ht["TGUBUN"] = tgubun;
		ht["SUBJECT"] = subject;
		ht["STRDAT"] = strdat;
		ht["ENDDAT"] = enddat;
		ht["TUSER"] = tuser;
		ht["TSTATE"] = tstate;
		ht["TKEY"] = tkey;
		ht["TPARM"] = tparm;
		ht["REGDAT"] = regdat;
		ht["TBIGO"] = tbigo;
		ht["COMPANYCODE"] = companycode;
		ht["PLANT"] = plant;
		ht["FORMID"] = formid;

		PageProgressShow();
		PageMethods.InvokeServiceTableCommon(ht, "CommonBiz", "AddToDo", function (e) {
			var DataSet = eval(e);
			
			PageProgressHide();

		}, function (e) {
			alert(e.get_message());
			PageProgressHide();
		});
	};
	this.Modify = function ( tkey,  tuser,  formid,  companycode,  plant) {
		var ht = new Object();

		ht["TUSER"] = tuser;
		ht["TKEY"] = tkey;
		ht["COMPANYCODE"] = companycode;
		ht["PLANT"] = plant;
		ht["FORMID"] = formid;

		PageProgressShow();
		PageMethods.InvokeServiceTableCommon(ht, "CommonBiz", "ModifyToDo", function (e) {
			var DataSet = eval(e);

			PageProgressHide();

		}, function (e) {
			alert(e.get_message());
			PageProgressHide();
		});
	};
	//this.Remove = function (no) {
	//	var ht = new Object();
	//
	//	ht["NO"] = no;
	//
	//	PageProgressShow();
	//	PageMethods.InvokeServiceTableCommon(ht, "CommonBiz", "RemoveToDo", function (e) {
	//		var DataSet = eval(e);
	//
	//		PageProgressHide();
	//
	//	}, function (e) {
	//		alert(e.get_message());
	//		PageProgressHide();
	//	});
	//};
};

var ToDo = new ToDoList();

function LanguageClick() {
    if (document.getElementById("language_list").style.display == 'none') {
        if (event.srcElement.id != "language") {
            document.getElementById("language_list").style.left = (event.srcElement.offsetLeft - 12) + "px";
        }
        document.getElementById("language_list").style.display = "block";
    }
    else {
        document.getElementById("language_list").style.display = "none";
    }
}
function LanguageShow() {
    document.getElementById("language_list").style.display = "block";
}
function LanguageHidden() {
    document.getElementById("language_list").style.display = "none";
}
function LanguageChange(culture) {
    PageProgressShow();
    var ht = new Object();
    ht["CULTURE"] = culture;
    PageMethods.InvokeServiceTableCommon(ht, "UserBiz", "ChnageCulture", function (e) {
        var DataSet = eval(e);
        location.reload();

    }, function (e) {
        alert(e.get_message());
        PageProgressHide();
    });
}
function LanguageChange(culture) {
    PageProgressShow();
    var ht = new Object();
    ht["CULTURE"] = culture;
    PageMethods.InvokeServiceTable(ht, "Common.OrgChartBiz", "ChnageCulture", function (e) {
        var DataSet = eval(e);
        location.reload();

    }, function (e) {
        alert(e.get_message());
        PageProgressHide();
    });
}

// 메뉴 로드후 메뉴ID 선택
function LeftMenuLoaded() {
    treeMenu.AllChildClose();
    if (treeMenu.Items.length > 0) {
        if(treeMenu.FindItem(MenuID)) treeMenu.FindItem(MenuID).Select();
    }

    // 화면의 높이를 정의
}

// 촤측메뉴 숨기고 보여주기
var LeftMenuHide = false;
function LeftMenuHideShow() {
    if (!LeftMenuHide) {
        $("#leftmenu_bx").animate({
            left: '-=190'
        }, 600, function () {
            $("#leftmenu_bx").find("#treeMenu").hide();
            $("#leftmenu_bx>div").find("a:first").text("▶");
            LeftMenuHide = true;
        });
        $("#content_bx").animate({
            width: '+=190',
            left: '-=190'
        }, 600, function () {
            // 그리드 초기화
            for (var i = 0; i < Grids.controls.length; i++) {
                Grids.controls[i].SheetLoadEnd();
            }
        });
        
    }
    else {
        $("#leftmenu_bx").animate({
            left: '+=190'
        }, 600, function () {
            $("#leftmenu_bx").find("#treeMenu").show();
            $("#leftmenu_bx>div").find("a:first").text("◀");
            LeftMenuHide = false;
        });
        $("#content_bx").animate({
            width: '-=190',
            left: '+=190'
        }, 600, function () {
            // 그리드 초기화
            for (var i = 0; i < Grids.controls.length; i++) {
                Grids.controls[i].SheetLoadEnd();
            }
        });
    }
}

