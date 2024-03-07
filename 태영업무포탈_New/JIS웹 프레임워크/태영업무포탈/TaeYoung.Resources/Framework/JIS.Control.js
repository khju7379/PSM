//*************************************************************************************************
// 페이지로드
//*************************************************************************************************
$(document).ready(function () {
    // 페이지 로드전 컨트롤 바인딩(콤보,체크,라디오)
    if (typeof (ControlLoad) != 'undefined') {
        for (var i = 0; i < ControlLoad.length; i++) {
            ControlLoad[i].BindList();
        }
    }

    if (typeof (OnLoad) == 'function') {
        OnLoad();
    }
    
    // 달력 닫기 이벤트를 body onclick 에 바인딩
    $(document.body).bind("click", function () {
        HideCalendar();
    });

    // SearchView 전체삭제버튼
    $(".SearchConditionAllRemove").on("click", function () {
        $("#" + $(this).attr("id").replace("_img", "")).val("");
        // 값 삭제
        (eval($(this).attr("sid") + "_Layer")).Clear();
    });

    // TEXTAREA에서 enter키가 안먹는 문제 수정(강제로 이벤트 발생)
    $("textarea").on("keydown", function (e) {
        if (e.keyCode == 13) {
            insertAtCursorEnter($(this).attr("id"));
        }
    });

    // 벨리데이션 컨트롤의 유효성검사 지움
    $(document).find("input[ValidationCheck]").on("keypress", function () {
        $(this).parent().find(".validation_text").hide();
    });
});

// TEXTAREA에서 enter키를 누를시 강제로 줄바꿈
function insertAtCursorEnter(areaId) {
    return;
    var text = "\r\n"; // 강제로 추가할 문자열
    var txtarea = document.getElementById(areaId);
    var scrollPos = txtarea.scrollTop;
    var strPos = 0;
    var br = ((txtarea.selectionStart || txtarea.selectionStart == '0') ?
        "ff" : (document.selection ? "ie" : false));
    if (br == "ie") {
        txtarea.focus();
        var range = document.selection.createRange();
        range.moveStart('character', -txtarea.value.length);
        strPos = range.text.length;
    }
    else if (br == "ff") strPos = txtarea.selectionStart;

    var front = (txtarea.value).substring(0, strPos);
    var back = (txtarea.value).substring(strPos, txtarea.value.length);
    txtarea.value = front + text + back;
    strPos = strPos + text.length - 1;
    if (br == "ie") {
        txtarea.focus();
        var range = document.selection.createRange();
        range.moveStart('character', -txtarea.value.length);
        range.moveStart('character', strPos);
        range.moveEnd('character', 0);
        range.select();
    }
    else if (br == "ff") {
        txtarea.selectionStart = strPos;
        txtarea.selectionEnd = strPos;
        txtarea.focus();
    }
    txtarea.scrollTop = scrollPos;
}

// CS에서 리턴한 JSON DataTable값을 Hashtable[] 형태로 변환한다.
// cs 에서 리턴한 값을 InvokeServiceTable Parameter로 전송하기 위하여 
// 재처리함
function ConvertHashtable(dt) {
    var hts = new Array();

    if (dt.Rows != undefined) {
        for (var i = 0; i < dt.Rows.length; i++) {
            hts.push(dt.Rows[i]);
        }
    }
    else {
        for (var i = 0; i < dt.length; i++) {
            hts.push(dt[i]);
        }
    }

    return hts;
}

/*************************************************************************************************/
// 함수 재정의
/*************************************************************************************************/
// Object의 갯수를 리턴 : Jquery와 충돌함으로 일반함수로 변경함
function ObjectCount(o) {
	return Object.keys(o).length;
}

// Object상의 최대값 리턴
function ObjectMaxValue(data) {
	var maxValue = 0;
	for (var prop in data) {
		if (data.hasOwnProperty(prop)) {
			if (prop * 1 > maxValue) {
				maxValue = prop * 1;
			}
		}
	}

	return maxValue;
}

// 문자열의 공백 제거 
String.prototype.trim = function () {
	return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
};

// 문자열에서 숫자3자리마다 콤마 적용
String.prototype.numberFormat = function () {

	var n = this;

	var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
	n += '';                          // 숫자를 문자열로 변환

	while (reg.test(n))
		n = n.replace(reg, '$1' + ',' + '$2');

	return n;

};

// 숫자형 문자열의 , 제거 및 숫자형 리턴
String.prototype.number = function () {
    var n = this;
    n = n.replace(/,/ig, '');
    return n * 1;
};
// 값이 문자형이 아닐시 오류 예외처리
Number.prototype.number = function () {
    return this;
};

// 문자열을 시간형식으로 변경
String.prototype.timeFormat = function () {
	var result = false, m;
	var re = /^\s*([01]?\d|2[0-3]):?([0-5]\d)\s*$/;
	if ((m = this.match(re))) {
		result = (m[1].length == 2 ? "" : "0") + m[1] + ":" + m[2];
	}
	return result;
};

// 문자열 길이 (한글 2바이트로 인식)
String.prototype.bytes = function (str) {
	str = this != window ? this : str;
	var l_intLength = 0;
	for (var l_intIndex = 0; l_intIndex < str.length; l_intIndex++) {
		var l_strChar = str.charAt(l_intIndex);
		l_intLength += (l_strChar.charCodeAt() > 128) ? 2 : 1;
	}
	return l_intLength;
};

// 자바스크립트 StartWidth
if (typeof String.prototype.startsWith != 'function') {
	String.prototype.startsWith = function (str) {
		return this.indexOf(str) == 0;
	};
}

// 개체의 열거 가능한 속성 및 메서드 이름을 반환합니다.
// IE8 미지원 함수 재정의
Object.keys = Object.keys || function (o) {
	var result = [];
	for (var name in o) {
		if (o.hasOwnProperty(name))
			result.push(name);
	}
	return result;
};

// 숫자를 ###,###,###.###### 형태로 변환
Number.prototype.format = function (format) {
    /* 123456.789.format("000,0.00000") -> 123,456.78900 */
    if (typeof (format) != 'string') { return ''; }
    var hasComma = -1 < format.indexOf(','), psplit = format.split('.'), that = this;
    if (2 == psplit.length) {
        that = that.toFixed(psplit[1].length);
    }
    else if (2 < psplit.length) {
        throw ('NumberFormatException: invalid format, formats should have no more than 1 period: ' + format);
    }
    else {
        that = that.toFixed(0);
    }
    var fnum = that.toString();
    if (hasComma) {
        psplit = fnum.split('.');
        var cnum = psplit[0], parr = [], j = cnum.length, m = Math.floor(j / 3), n = cnum.length % 3 || 3;
        for (var i = 0; i < j; i += n) {
            if (i != 0) { n = 3; }
            parr[parr.length] = cnum.substr(i, n);
            m -= 1;
        }
        fnum = parr.join(',');
        if (psplit[1]) { fnum += '.' + psplit[1]; }
    }
    return fnum;// format.replace(/[d,?.?]+/, fnum);
};

// String.format 구현 ex) "Test {0} 입니다.".format("중"); = "Test 중 입니다."
String.prototype.format = function () {
	var exp = this;
	for (var i = 0; i < arguments.length; i++) {
		var prttern = "{" + (i) + "}";
		exp = exp.replace(prttern, arguments[i])
	}
	return exp;
};

// xml로 변환시 특수문자를 변경
String.prototype.XMLConvertEncode = function () {

	var l_text = this;
	for (j = 1; j < 5000; j++) {
		if (l_text.indexOf("&amp;") != -1) {
			l_text = l_text.replace("&amp;", "&");
		} else if (l_text.indexOf("&lt;") != -1 || l_text.indexOf("&gt;") != -1) {
            l_text = l_text.replace("&lt;", "<").replace("&gt;", ">");
        } else if (l_text.indexOf("&#40;") != -1 || l_text.indexOf("&#41;") != -1) {
            l_text = l_text.replace("&#40;", "(").replace("&#41;", ")");
        } else if (l_text.indexOf("&#35;") != -1) {
            l_text = l_text.replace("&#35;", "#");
		} else if (l_text.indexOf("&quot;") != -1) {
			l_text = l_text.replace("&quot;", "\"");
		} else {
			l_text = l_text.replace("", "");
			break;
		}
	}

	return l_text;
};

// xml 로 변환 시 특수문자를 변경해야한다. 
String.prototype.XMLConvertDecode = function () {
	// 
	var l_text = this;

	if (l_text.indexOf("&") != -1) {
		l_text = l_text.replace(/&/gi, '&amp;');
	}

	if (l_text.indexOf(">") != -1) {
		l_text = l_text.replace(/>/gi, '&gt;');
	}

	if (l_text.indexOf("<") != -1) {
		l_text = l_text.replace(/</gi, '&lt;');
	}

	if (l_text.indexOf("\"") != -1) {
		l_text = l_text.replace(/"/gi, '&quot;');
	}

	l_text = l_text.replace("", "");

	return l_text;
};

// chrome에서 알림창 숨기는 기능이 있음으로 alert, confirm, prompt 함수는 재정의하여 사용
//window.alert = function (message, fn) {
//	MsgBox.show(message, fn);
//};
//window.confirm = function (message, fn) {
//	MsgBox.confirm(message, fn);
//};
//window.prompt = function (head, body, fn) {
//	MsgBox.prompt(head, body, fn);
//};

// 날자형에서 yyyymmdd로 리턴
Date.prototype.yyyymmdd = function () {
	var yyyy = this.getFullYear().toString();
	var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
	var dd = this.getDate().toString();
	return yyyy + (mm[1] ? mm : "0" + mm[0]) + (dd[1] ? dd : "0" + dd[0]); // padding
};
// 날자형에서 yyyy-mm-dd로 리턴
Date.prototype.yyyy_mm_dd = function () {
	var yyyy = this.getFullYear().toString();
	var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
	var dd = this.getDate().toString();
	return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]); // padding
};
// 날자형에서 yyyy-mm-dd로 리턴
Date.prototype.ymdtime = function () {
	var yyyy = this.getFullYear().toString();
	var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
	var dd = this.getDate().toString();
	var hh = this.getHours().toString();
	var MM = this.getMinutes().toString();
	return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]) + " " + hh + ":" + MM; // padding
};

// 월추가기능구현
Date.isLeapYear = function (year) {
    return (((year % 4 === 0) && (year % 100 !== 0)) || (year % 400 === 0));
};

Date.getDaysInMonth = function (year, month) {
    return [31, (Date.isLeapYear(year) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month];
};

Date.prototype.isLeapYear = function () {
    return Date.isLeapYear(this.getFullYear());
};

Date.prototype.getDaysInMonth = function () {
    return Date.getDaysInMonth(this.getFullYear(), this.getMonth());
};

Date.prototype.addMonths = function (value) {
    var n = this.getDate();
    this.setDate(1);
    this.setMonth(this.getMonth() + value);
    this.setDate(Math.min(n, this.getDaysInMonth()));
    return this;
};

Date.prototype.format = function (f) {
    if (!this.valueOf()) return " ";

    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;

    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function ($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};

String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
Number.prototype.zf = function (len) { return this.toString().zf(len); };

/*************************************************************************************************/
// jquery 재정의
/*************************************************************************************************/

// querystring to object
(function ($) {
	var re = /([^&=]+)=?([^&]*)/g;
	var decodeRE = /\+/g;  // Regex for replacing addition symbol with a space
	var decode = function (str) { return decodeURIComponent(str.replace(decodeRE, " ")); };
	$.parseParams = function (query) {
		var params = {}, e;
		while (e = re.exec(query)) {
			var k = decode(e[1]), v = decode(e[2]);
			if (k.substring(k.length - 2) === '[]') {
				k = k.substring(0, k.length - 2);
				(params[k] || (params[k] = [])).push(v);
			}
			else params[k] = v;
		}
		return params;
	};
})(jQuery);

// 값을 검색하여 변경시 이벤트발생
jQuery.fn.watch = function (id, fn) {

	return this.each(function () {

		var self = this;

		var oldVal = self[id];
		$(self).data(
            'watch_timer',
            setInterval(function () {
            	if (self[id] !== oldVal) {
            		fn.call(self, id, oldVal, self[id]);
            		oldVal = self[id];
            	}
            }, 100)
        );

	});

	return self;
};

// 값 변경 이벤트 해제
jQuery.fn.unwatch = function (id) {

	return this.each(function () {
		clearInterval($(this).data('watch_timer'));
	});

};

// 스크롤 시작,중지 이벤트 바인딩
(function (window, undefined) {
	'$:nomunge'; // Used by YUI compressor.

	// Since jQuery really isn't required for this plugin, use `jQuery` as the
	// namespace only if it already exists, otherwise use the `Cowboy` namespace,
	// creating it if necessary.
	var $ = window.jQuery || window.Cowboy || (window.Cowboy = {}),

	// Internal method reference.
    jq_throttle;

	$.throttle = jq_throttle = function (delay, no_trailing, callback, debounce_mode) {
		// After wrapper has stopped being called, this timeout ensures that
		// `callback` is executed at the proper times in `throttle` and `end`
		// debounce modes.
		var timeout_id,

		// Keep track of the last time `callback` was executed.
      last_exec = 0;

		// `no_trailing` defaults to falsy.
		if (typeof no_trailing !== 'boolean') {
			debounce_mode = callback;
			callback = no_trailing;
			no_trailing = undefined;
		}

		// The `wrapper` function encapsulates all of the throttling / debouncing
		// functionality and when executed will limit the rate at which `callback`
		// is executed.
		function wrapper() {
			var that = this,
        elapsed = +new Date() - last_exec,
        args = arguments;

			// Execute `callback` and update the `last_exec` timestamp.
			function exec() {
				last_exec = +new Date();
				callback.apply(that, args);
			};

			// If `debounce_mode` is true (at_begin) this is used to clear the flag
			// to allow future `callback` executions.
			function clear() {
				timeout_id = undefined;
			};

			if (debounce_mode && !timeout_id) {
				// Since `wrapper` is being called for the first time and
				// `debounce_mode` is true (at_begin), execute `callback`.
				exec();
			}

			// Clear any existing timeout.
			timeout_id && clearTimeout(timeout_id);

			if (debounce_mode === undefined && elapsed > delay) {
				// In throttle mode, if `delay` time has been exceeded, execute
				// `callback`.
				exec();

			} else if (no_trailing !== true) {
				timeout_id = setTimeout(debounce_mode ? clear : exec, debounce_mode === undefined ? delay - elapsed : delay);
			}
		};
		// callback as a reference.
		if ($.guid) {
			wrapper.guid = callback.guid = callback.guid || $.guid++;
		}

		// Return the wrapper function.
		return wrapper;
	};

	$.debounce = function (delay, at_begin, callback) {
		return callback === undefined
      ? jq_throttle(delay, at_begin, false)
      : jq_throttle(delay, callback, at_begin !== false);
	};

})(this);

/*************************************************************************************************/
// 사용자함수
/*************************************************************************************************/

// Guid 생성
var guid = (function () {
	function s4() {
		return Math.floor((1 + Math.random()) * 0x10000)
               .toString(16)
               .substring(1);
	}
	return function () {
		return s4() + s4() + s4() + s4() + s4() + s4() + s4() + s4();
	};
})();

// 다국어 처리
function GetLangCode(langCode, country, callback) {
	var Param = new Object();
	Param["langCode"] = langCode;
	Param["country"] = country;
	PageMethods.InvokeServiceTable(Param, "Common.LangBiz", "GetLangCodeScript", function (e) {
		var ds = eval(e);

		if (typeof (callback) == "function") {
			callback(ds.Tables[0].Rows[0]["LANG_TEXT"]);
		}
	}, function (e) {
		alert(e.get_message());
	});
}

// 엑셀 스타일의 반올림 함수 정의
function roundXL(n, digits) {
	if (digits >= 0) return parseFloat(n.toFixed(digits)); // 소수부 반올림

	digits = Math.pow(10, digits); // 정수부 반올림
	var t = Math.round(n * digits) / digits;

	return parseFloat(t.toFixed(0));
}

// input text에 숫자만 입력
function TextboxNumber(event) {
	var theEvent = event || window.event;
	var key = theEvent.keyCode || theEvent.which;
	if (key == 190 || key == 8 || key == 109 || key == 189) {

	}
	// 탭키 풀기 (2017-03-31 장윤호)
	else if (key == 9) {
	    //document.forms.elements[this.tabIndex].focus();
	}
	else {
	    key = String.fromCharCode(key);
	    //alert(key);
	    var regex = /[0-9]|\.|\`|[a-i]|[n]|[%]|[']/;
	    if (!regex.test(key)) {
	        theEvent.returnValue = false;
	        if (theEvent.preventDefault) theEvent.preventDefault();
	    }
	}
}

// input text에 숫자만 입력(max값은 100, 100이상의 값일시 100으로 고정함)
function TextboxPercent(o) {
	if ($(o).val() * 1 > 100) {
		$(o).val("100");
	}
}
// input text에 콤마
function TextboxComma(o) {
	var n = $(o).val();

	n = n.replace(/,/gi, "");

	var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
	n += '';                          // 숫자를 문자열로 변환

	while (reg.test(n))
		n = n.replace(reg, '$1' + ',' + '$2');

	$(o).val(n);
}

// TimePicker 유효성검사
function dPickerTimeChecker(t, id) {
	if (t == "hour") {
		var hour = $("#" + id).val() * 1;
		if (hour < 1) hour = 1;
		if (hour > 12) hour = 12;
		$("#" + id).val(hour);
	}
	else {
		var hour = $("#" + id).val() * 1;
		if (hour < 1) hour = 1;
		if (hour > 59) hour = 59;
		$("#" + id).val(hour);
	}
}

// 컨트롤의 입력값 유효성검사
function ValidationCheck() {
    $(document).find("input[ValidationCheck]").each(function () {
        if (eval($(this).attr("id")).GetValue().trim() == "") {
            $(this).parent().find(".validation_text").show();
            $(this).parent().find(".validation_text").css("left", ($(this).width() + 5) + "px");
        }
    });
}

// 체크박스, 라디오 컨트롤 클릭 이벤트
function ControlClick(obj) {
    
    var ctl = $(obj).prev("input");
    if (!$(ctl).prop("disabled")) {
      // $(ctl).prop("checked", !$(ctl).prop("checked"));

        //alert('chk');
    }
    //$(obj.find("input").eq(0)).prop("checked", !$(obj.find("input").eq(0)).prop("checked"));
}

// DateTime구현
var DateTime = function () {
    // arguments는 6개까지만 적용함(기타 언어관련 제외)
    var year, month, day, hour, minute, second;
    var arg_cnt = arguments.length;
    var date = new Date();
    
    this.Date = function () {
        return date;
    };
    this.Year = function () {
        if (arguments.length > 0) {
            date.setFullYear(arguments[0]);
        }
        else {
            return date.getFullYear();
        }
    };
    this.Month = function () {
        if (arguments.length > 0) {
            date.setMonth(arguments[0] - 1);
        }
        else {
            return date.getMonth() + 1;
        }
    };
    this.Day = function () {
        if (arguments.length > 0) {
            date.setDate(arguments[0]);
        }
        else {
            return date.getDate();
        }
    };
    this.Hour = function () {
        if (arguments.length > 0) {
            date.setHours(arguments[0]);
        }
        else {
            return date.getHours();
        }
    };
    this.Minute = function () {
        if (arguments.length > 0) {
            date.setMinutes(arguments[0]);
        }
        else {
            return date.getMinutes();
        }
    };
    this.Second = function () {
        if (arguments.length > 0) {
            date.setSeconds(arguments[0]);
        }
        else {
            return date.getSeconds();
        }
    };

    // 시간 추가
    this.AddYears = function (s) {
        date.setFullYear(date.getFullYear() + s);
    };
    this.AddMonths = function (s) {
        date.addMonths(s);
    };
    this.AddDays = function (s) {
        date.setTime(date.getTime() + (s * 24 * 60 * 60 * 1000));
    };
    this.AddHours = function (s) {
        date.setTime(date.getTime() + (s * 60 * 60 * 1000));
    };
    this.AddMinutes = function (s) {
        date.setTime(date.getTime() + (s * 60 * 1000));
    };
    this.AddSeconds = function (s) {
        date.setTime(date.getTime() + (s * 1000));
    };

    this.ToString = function (format) {
        return date.format(format);
    };

    //    this.Year = {
    //        get: function () {
    //            return "111";
    //        }
    //    };
    //var dt = 

    switch (arg_cnt) {
        case 0:
            //date = new Date();
            break;
        case 1:
            // ISO Format 확인
            if (typeof (arguments[0]) == "string") {
                date = new Date(arguments[0]);
            }
            else {
                this.Year(arguments[0]);
                this.Month(1);
                this.Day(1);
                this.Hour(0);
                this.Minute(0);
                this.Second(0);
            }
            break;
        case 2:
            this.Year(arguments[0]);
            this.Month(arguments[1]);
            this.Day(1);
            this.Hour(0);
            this.Minute(0);
            this.Second(0);
            break;
        case 3:
            this.Year(arguments[0]);
            this.Month(arguments[1]);
            this.Day(arguments[2]);
            this.Hour(0);
            this.Minute(0);
            this.Second(0);
            break;
        case 4:
            this.Year(arguments[0]);
            this.Month(arguments[1]);
            this.Day(arguments[2]);
            this.Hour(arguments[3]);
            this.Minute(0);
            this.Second(0);
            break;
        case 5:
            this.Year(arguments[0]);
            this.Month(arguments[1]);
            this.Day(arguments[2]);
            this.Hour(arguments[3]);
            this.Minute(arguments[4]);
            this.Second(0);
            break;
        case 6:
            this.Year(arguments[0]);
            this.Month(arguments[1]);
            this.Day(arguments[2]);
            this.Hour(arguments[3]);
            this.Minute(arguments[4]);
            this.Second(arguments[5]);
            break;
    }
};

var UtilStr = function () {
    this.ThisMonthFirstDay = function () {
        var dt = new DateTime();
        dt.Day(1);
        return dt;
    };
    this.ThisMonthLastDay = function () {
        var dt = new DateTime();
        dt.AddMonths(1);
        dt.Day(1);
        dt.AddDays(-1);
        return dt;
    };
    this.ThisYearFirstDay = function () {
        var dt1 = new DateTime();
        var dt2 = new DateTime(dt1.Year(), 1, 1);
        return dt2;
    };
    this.ThisYearLastDay = function () {
        var dt1 = new DateTime();
        var dt2 = new DateTime(dt1.Year(), 12, 31);
        return dt2;
    };
    this.ConvertToPhoneNumber = function (num) {
        var formatNum = '';

        if (num.length == 11) {
            formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
        } else if (num.length == 8) {
            formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');
        } else {
            if (num.indexOf('02') == 0) {
                formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
            } else {
                formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
            }
        }
        return formatNum;
    };
    this.GetCRT_YMDByLOTNO = function (co_gb, lotno) {
        var year = "";
        var month = "";
        var day = "";

        if (co_gb == "SEOHAN" || co_gb == "KOFCO" || co_gb == "ENP") {
            switch (lotno.substr(0, 1)) {
                case "D": year = "2004"; break;
                case "E": year = "2005"; break;
                case "F": year = "2006"; break;
                case "G": year = "2007"; break;
                case "H": year = "2008"; break;
                case "I": year = "2009"; break;
                case "J": year = "2010"; break;
                case "K": year = "2011"; break;
                case "L": year = "2012"; break;
                case "M": year = "2013"; break;
                case "N": year = "2014"; break;
                case "O": year = "2015"; break;
                case "P": year = "2016"; break;
                case "Q": year = "2017"; break;
                case "R": year = "2018"; break;
                case "S": year = "2019"; break;
                case "T": year = "2020"; break;
            }
        }
        else {
            switch (lotno.substr(0, 1)) {
                case "A": year = "2005"; break;
                case "B": year = "2006"; break;
                case "C": year = "2007"; break;
                case "D": year = "2008"; break;
                case "E": year = "2009"; break;
                case "F": year = "2010"; break;
                case "G": year = "2011"; break;
                case "H": year = "2012"; break;
                case "I": year = "2013"; break;
                case "J": year = "2014"; break;
                case "K": year = "2015"; break;

                case "L": year = "2016"; break;
                case "M": year = "2017"; break;
                case "N": year = "2018"; break;
                case "O": year = "2019"; break;
                case "P": year = "2020"; break;
            }
        }

        switch (lotno.substr(1, 1)) {
            case "A": month = "01"; break;
            case "B": month = "02"; break;
            case "C": month = "03"; break;
            case "D": month = "04"; break;
            case "E": month = "05"; break;
            case "F": month = "06"; break;
            case "G": month = "07"; break;
            case "H": month = "08"; break;
            case "I": month = "09"; break;
            case "J": month = "10"; break;
            case "K": month = "11"; break;
            case "L": month = "12"; break;
        }

        switch (lotno.substr(2, 1)) {
            case "A": day = "01"; break;
            case "B": day = "02"; break;
            case "C": day = "03"; break;
            case "D": day = "04"; break;
            case "E": day = "05"; break;
            case "F": day = "06"; break;
            case "G": day = "07"; break;
            case "H": day = "08"; break;
            case "I": day = "09"; break;
            case "J": day = "10"; break;
            case "K": day = "11"; break;
            case "L": day = "12"; break;
            case "M": day = "13"; break;
            case "N": day = "14"; break;
            case "O": day = "15"; break;
            case "P": day = "16"; break;
            case "Q": day = "17"; break;
            case "R": day = "18"; break;
            case "S": day = "19"; break;
            case "T": day = "20"; break;
            case "U": day = "21"; break;
            case "V": day = "22"; break;
            case "W": day = "23"; break;
            case "X": day = "24"; break;
            case "Y": day = "25"; break;
            case "Z": day = "26"; break;
            case "2": day = "27"; break;
            case "3": day = "28"; break;
            case "4": day = "29"; break;
            case "5": day = "30"; break;
            case "6": day = "31"; break;
        }

        return year + "-" + month + "-" + day;
    };
    this.GetLOTNOByDate = function (co_gb, date) {
        date = date.replace(/-/ig, '');
        if (date.length != 8) {
            return;
        }
        //date = date.substr(0, 4) + "-" + date.substr(4, 2) + "-" + date.substr(6, 2);
        //date = new DateTime(date).ToString("yyyyMMdd");

        var rtnValue = "";

        if (co_gb == "SEOHAN" || co_gb == "KOFCO" || co_gb == "ENP") {
            switch (date.substr(0, 4)) {
                case "2004": rtnValue += "D"; break;
                case "2005": rtnValue += "E"; break;
                case "2006": rtnValue += "F"; break;
                case "2007": rtnValue += "G"; break;
                case "2008": rtnValue += "H"; break;
                case "2009": rtnValue += "I"; break;
                case "2010": rtnValue += "J"; break;
                case "2011": rtnValue += "K"; break;
                case "2012": rtnValue += "L"; break;
                case "2013": rtnValue += "M"; break;
                case "2014": rtnValue += "N"; break;
                case "2015": rtnValue += "O"; break;
                case "2016": rtnValue += "P"; break;
                case "2017": rtnValue += "Q"; break;
                case "2018": rtnValue += "R"; break;
                case "2019": rtnValue += "S"; break;
                case "2020": rtnValue += "T"; break;
            }
        }
        else {
            switch (date.substr(0, 4)) {
                case "2005": rtnValue += "A"; break;
                case "2006": rtnValue += "B"; break;
                case "2007": rtnValue += "C"; break;
                case "2008": rtnValue += "D"; break;
                case "2009": rtnValue += "E"; break;
                case "2010": rtnValue += "F"; break;
                case "2011": rtnValue += "G"; break;
                case "2012": rtnValue += "H"; break;
                case "2013": rtnValue += "I"; break;
                case "2014": rtnValue += "J"; break;
                case "2015": rtnValue += "K"; break;
                case "2016": rtnValue += "L"; break;
                case "2017": rtnValue += "M"; break;
                case "2018": rtnValue += "N"; break;
                case "2019": rtnValue += "O"; break;
                case "2020": rtnValue += "P"; break;
            }
        }

        switch (date.substr(4, 2)) {
            case "01": rtnValue += "A"; break;
            case "02": rtnValue += "B"; break;
            case "03": rtnValue += "C"; break;
            case "04": rtnValue += "D"; break;
            case "05": rtnValue += "E"; break;
            case "06": rtnValue += "F"; break;
            case "07": rtnValue += "G"; break;
            case "08": rtnValue += "H"; break;
            case "09": rtnValue += "I"; break;
            case "10": rtnValue += "J"; break;
            case "11": rtnValue += "K"; break;
            case "12": rtnValue += "L"; break;
        }

        switch (date.substr(6, 2)) {
            case "01": rtnValue += "A"; break;
            case "02": rtnValue += "B"; break;
            case "03": rtnValue += "C"; break;
            case "04": rtnValue += "D"; break;
            case "05": rtnValue += "E"; break;
            case "06": rtnValue += "F"; break;
            case "07": rtnValue += "G"; break;
            case "08": rtnValue += "H"; break;
            case "09": rtnValue += "I"; break;
            case "10": rtnValue += "J"; break;
            case "11": rtnValue += "K"; break;
            case "12": rtnValue += "L"; break;
            case "13": rtnValue += "M"; break;
            case "14": rtnValue += "N"; break;
            case "15": rtnValue += "O"; break;
            case "16": rtnValue += "P"; break;
            case "17": rtnValue += "Q"; break;
            case "18": rtnValue += "R"; break;
            case "19": rtnValue += "S"; break;
            case "20": rtnValue += "T"; break;
            case "21": rtnValue += "U"; break;
            case "22": rtnValue += "V"; break;
            case "23": rtnValue += "W"; break;
            case "24": rtnValue += "X"; break;
            case "25": rtnValue += "Y"; break;
            case "26": rtnValue += "Z"; break;
            case "27": rtnValue += "2"; break;
            case "28": rtnValue += "3"; break;
            case "29": rtnValue += "4"; break;
            case "30": rtnValue += "5"; break;
            case "31": rtnValue += "6"; break;
        }

        return rtnValue;
    };
    this.FormatITMNO = function (itmno) {
        var rtnValue;
        var strItmno = itmno + "";

        if (strItmno.length == 10) {
            rtnValue = strItmno.substr(0, 5) + "-" + strItmno.substr(5, 5);
        }
        else if (strItmno.length == 11) {
            if (strItmno.substr(0, 1) == "P" || strItmno.substr(0, 1) == "M" || strItmno.substr(0, 1) == "A" || strItmno.substr(0, 1) == "B") {
                rtnValue = strItmno.substr(0, 6) + "-" + strItmno.substr(6, 5);
            }
            else {
                rtnValue = strItmno.substr(0, 5) + "-" + strItmno.substr(5, 6);

            }
        }
        else {
            rtnValue = strItmno.substr(0, 5) + "-" + strItmno.substr(5);
        }

        return rtnValue;
    };
};

var Util = new UtilStr();

// rgraph 차트 데이터변환
function ChartDataConvert(o) {

    var keys = Object.keys(o[0]);
    var result = [];
    for (var key in keys) {
        var sub_result = [];
        for (var i = 0; i < ObjectCount(o); i++) {
            sub_result.push(o[i][keys[key]]);
        }
        result.push(sub_result);
    }

    return result;
}

// 현재 웹 브라우져의 스크롤바 넓이를 강제로 가져온다
function getScrollBarWidth() {
    var inner = document.createElement('p');
    inner.style.width = "100%";
    inner.style.height = "200px";
    var outer = document.createElement('div');
    outer.style.position = "absolute";
    outer.style.top = "0px";
    outer.style.left = "0px";
    outer.style.visibility = "hidden";
    outer.style.width = "200px";
    outer.style.height = "150px";
    outer.style.overflow = "hidden";
    outer.appendChild(inner);
    document.body.appendChild(outer);
    var w1 = inner.offsetWidth; outer.style.overflow = 'scroll';
    var w2 = inner.offsetWidth;
    if (w1 == w2) w2 = outer.clientWidth; document.body.removeChild(outer);
    return (w1 - w2);
};


/*************************************************************************************************/
// 파일업로드
/*************************************************************************************************/

// 페이지의 파일업로드 갯수 로드
var FILEUPLOADCNT = 0;
var FILEUPLOADEVENT;

// 파일업로드 시작
function UploadStart(e) {

    FILEUPLOADCNT = 0;
	for (var i = 0; i < FILEUPLOAD.length; i++) {
	    if (FILEUPLOAD[i] != undefined || FILEUPLOAD[i] != null) {
	        for (var j = 0; j < FILEUPLOAD[i].uploader.files.length; j++) {
	            if (FILEUPLOAD[i].uploader.files[j].status != 5) { // 완료가 아닌거만
	                //FILEUPLOADCNT += FILEUPLOAD[i].uploader.files.length;
	                FILEUPLOADCNT++;
	            }
	        }
	    }
    }

    
	if (FILEUPLOADCNT == 0) {
		e();
	}
	else {
		// 업로드 시작
		$(".plupload_start").click();
	}

    
	// 업로드 완료후 실행할 콜백함수
    FILEUPLOADEVENT = e;

    
}

// 파일업로드 전체완료
function __UploadComplete() {   

    
	FILEUPLOADCNT = FILEUPLOADCNT - 1
	if (FILEUPLOADCNT == 0) {
        if(typeof FILEUPLOADEVENT == "function")
	        FILEUPLOADEVENT();
	}
}

// 파일 다운로드 링크
function __FileDownloadLink(unid) {
    //location.href = unid;
    window.open(unid);
}

// 이미지 크게보기
function __ImageViewer(unid) {
	// 레이어의 크기
	var l_width = 600;
	var l_height = 400;
	// 기존 데이터 삭제
	$("#Image_Layer div").remove();
	// 레이어 위치
	$("#Image_Layer").show();
	$("#Image_Layer").css("position", "absolute");
	$("#Image_Layer").css("top", "124px");
	$("#Image_Layer").css("left", "199px");
	// 이미지 로드
	$("#Image_Layer").append("<div style='border:solid 1px #646464;'><img src=\"/Resources/Framework/ImageResize.aspx?UNID=" + unid + "&width=" + l_width + "&height=" + l_height + "\" style='cursor:pointer;' /></div>");
	$("#Image_Layer div").on("click", function () {
		$("#Image_Layer div").remove();
		$("#Image_Layer").hide();
	});
	// 로드된 이미지의 크기만큼 레이어 크기 조절
	$("#Image_Layer").css("width", $("#Image_Layer").find("img").width() + 2 + "px");
	$("#Image_Layer").css("height", $("#Image_Layer").find("img").height() + "px");
}

function __FileDelete(obj, unid) {
	var ht = new Object();
	ht["UNID"] = unid;

	if (window.confirm("파일을 삭제하시겠습니까?")) {
	    PageMethods.InvokeServiceTable(ht, "Common.CommonBiz", "RemoveAttach", function () {
	        // close에 숫자 변경함
	        for (var i = 0; i < $(obj).parent().parent().parent().parent().parent().find(".ui-button-text").length; i++) {
	            var txt = $(obj).parent().parent().parent().parent().parent().find(".ui-button-text")[i].innerHTML;
	            if (txt.indexOf('Close') != -1) {
	                var cnt = parseInt(txt.replace("Close(", "").replace(")", "") == '' ? 0 : txt.replace("Close(", "").replace(")", ""), 10);
	                cnt = cnt - 1;
	                if (cnt < 0) cnt = 0;
	                if (cnt == 0) {
	                    txt = "Close";
	                } else {
	                    txt = "Close(" + cnt + ")";
	                }
	                $(obj).parent().parent().parent().parent().parent().find(".ui-button-text")[i].innerHTML = txt;
	            }
	        }
	        //결재 첨부의 경우 해당 정보 삭제
	        try {
	            if (Awx && Body && fnFxOnLoad) {
	                var INPUTS = Body.getElementsByTagName('INPUT');
	                for (var i = 0; i < INPUTS.length; i++) {
	                    if (INPUTS[i].getAttribute('Type') == 'file' && INPUTS[i].getAttribute('text').indexOf(decodeURIComponent(unid).split('§')[0]) != -1) {
	                        INPUTS[i].setAttribute('text', '');
	                    }
	                }
	                fnFxOnLoad();
	            }
	        } catch (e) {
	        }

	        $(obj).parent().parent().remove();
	    }, function () {
	        alert("파일삭제중 오류가 발생하였습니다.");
	    });
		// 삭제 콜백 함수 추가   2014-12-12 장윤호
		if (typeof BeforeFileRemove == "function") {
			BeforeFileRemove();
		}
	}
}
//파일사이즈 가져오기
function getSize(bytes) {
    var thresh = 1024;
    if (Math.abs(bytes) < thresh) {
        return bytes + ' B';
    }
    var units = ['kb', 'mb', 'gb', 'tb', 'pb', 'eb', 'zb', 'yb'];

    var u = -1;
    do {
        bytes /= thresh;
        ++u;
    } while (Math.abs(bytes) >= thresh && u < units.length - 1);
    return bytes.toFixed(1) + ' ' + units[u];

}

function __FILESave(id, t, n, event) {

    var hts = new Array();
   
    if (document.getElementById(id + "_filedata").value != "") {
       
        var item = document.getElementById(id+"_filedata").value;
        item = item.split("^");

        for (var k = 0; k < item.length - 1; k++) {
            var data = item[k].split("|");
            var ht = new Object();

            // 0: 실제파일명, 1: 파일사이즈, 2:파일 타입, 3:파일경로, 4:파일 확장자, 5: 저장파일명
            ht["ATTACH_TYPE"] = t;          //파일명
            ht["ATTACH_NO"] = n;            //문서번호
            ht["FILE_NAME"] = data[0];      // 실제 파일명
            ht["FILE_SIZE"] = data[1];      // 파일 사이즈
            ht["FILE_MIME"] = data[2];      // 파일 타입
            ht["FILE_PATH"] = data[3];      // 파일 경로
            ht["FILE_EXT"] = data[4];       // 파일 확장자
            ht["ATTACH_UNID"] = data[5];    // 저장 파일명

            hts.push(ht);
        }        

        PageMethods.InvokeServiceTableArraySync(new Object(), hts, "Common.CommonBiz", "AddAttachFile", function () {
            if (event != undefined && typeof (event) == "function") {
                event();
            }
        }, function (e) {
            alert(e.responseText);
        });
    }
}

function __FILELoad(id,t,n,event) {
    var ht = new Object();
    ht["ATTACH_TYPE"] = t;              // 파일타입
    ht["ATTACH_NO"] = n;     // 문서번호
    //PageProgressShow();
    PageMethods.InvokeServiceTableSync(ht, "Common.CommonBiz", "GetAttachFileList", function (e) {
        var DataSet = eval(e);
        var data = "";

        if (DataSet) {
            for (var i = 0; i < DataSet.Tables[0].Rows.length; i++) {
                var filename = DataSet.Tables[0].Rows[i]["FILE_NAME"];
                var _filesize = parseInt(DataSet.Tables[0].Rows[i]["FILE_SIZE"]);
                var filesize = getSize(_filesize);
                var filepath = "/Resources/Framework/FileDownload.aspx?UNID=" + DataSet.Tables[0].Rows[i]["ATTACH_UNID"] + "&ATTACH_TYPE=" + DataSet.Tables[0].Rows[i]["ATTACH_TYPE"];
                data += filename + "|" + filesize + "|" + filepath + "^";
            }
            data = data.substring(0, data.length - 1);
        }
        document.getElementById(id + "_viewdata").value = data;

        for (var i = 0; i < FILEUPLOAD.length; i++) {
            if (FILEUPLOAD[i].id == id) {
                FILEUPLOAD[i].Init();
            }
        }
        //eval(id).Init(); // 첫번쨰 첨부컨트롤 초기화

        if (event != undefined && typeof (event) == "function") {
            event();
        }
    }, function (e) {
        alert(e.responseText);
    });
}

function __FILEUpload(id, e) {
    FILEUPLOADCNT = 1;

    $("#" + id + " .plupload_start").click();

    if (e != undefined && typeof (e) == "function") {
        FILEUPLOADEVENT = e;
    }
}

function __FILEReadMode(id, e) {
    //plupload_add
    if (e) {
        $("#" + id + " .plupload_add").show();
    }
    else {
        $("#" + id + " .plupload_add").hide();
    }
}


/*************************************************************************************************/
// 리스트 WebSheet
/*************************************************************************************************/
//var WebSheetItems;
var _ExcelFileDownloadName = "";
var JinWebSheet = function (strId, strPName, strUsePage, strPageSize, strPagingSize, strUseCheckBox, strColumnCnt, strHeight, intPageNum, strFix, strHFix, ChkAutoMerge, UseColumnSort) {
    this.Items = strId; 				// 컨트롤의 ID
    Grids.push(this);
    this.PNames = strPName;
    this.ArgArr = null;
    this.DefaultLine = false;
    this.UsePage = strUsePage;          // 페이징사용여부(false 일 경우 페이지 네비게이터 바가 나타나지않음)
    this.PageSize = strPageSize;        // 한페이지 사이즈(세션으로 연동)
    this.PagingSize = strPagingSize;    // 페이지 네비게이터 바의 출력 갯수
    //this.TotalListCnt = intTotCnt;    // 전체 리스트 카운트
    this.UseCheckBox = strUseCheckBox;  // 체크박스 사용여부        
    this.ColumnCnt = strColumnCnt;      // 칼럼수
    this.UseFix = strFix;               // 틀고정 여부
    this.UseHFix = strHFix;             // Height 틀고정 여부
    this.Progress = null;               // Progress Bar 생성 방법
    this.ProgressChk = true;            // Progress Bar 출력 Flag
    this.UseColumnSort = UseColumnSort; // 컬럼 Sort 여부
    this.sortOrderBy = "";
    this.sortColumnIdx = 0;
    this.AutoSave = false;
    this.AutoSaveTarget = null;
    this.ColumnsAlign = null;           // 칼럼 정렬
    this.ColumnsDatatype = null;        // 칼럼 데이터타입(date, length 등)
    this.ColumnsType = null;            // 칼럼 편집타입(text, combo 등)
    this.ColumnsComboList = null;       // 칼럼 리스트박스 목록
    this.ColumnsHidden = null;          // 칼럼 숨김
    this.ColumnsFix = null;             // 칼럼 고정
    this.ColumnsText = null;            // 칼럼 Text
    this.ColumnsName = null;            // 칼럼 DB필드명
    this.ColumnsEditable = null;        // 칼럼 편집가능
    this.ColumnsLink = null;            // 칼럼 링크속성(함수를 등록)
    this.CellHeight = strHeight;        // 칼럼 높이
    this.CellWidth = null;              // 칼럼 넓이
    this.CurrData = null;
    this.CurrPageNum = intPageNum; 	// 현재 페지징의 번호
    this.CheckBoxAutoMerge = ChkAutoMerge;  //체크박스 자동머지
    this.ColumnsAutoMerge = null;
    this.ColumnsStripeColor = null;     // Stripe Color
    this.ChkMerge = false;
    this.OverEvent = true;
    this.Title = null;
    this.SelectedRow = null; 		// 선택된 아이템 목록
    this.TargetID = null; 			// 컨트롤에 바인딩할 타겟ID
    this.DateFormat = null; 			// 날자형태
    this.AutoHeightMargin = null;
    this.BgColor01 = "#FFFFFF"; // 그리드 첫번쨰 컬럼 색상
    this.BgColor02 = "#F9F9F9"; // 그리드 두번쨰 컬럼 색상
    this.BgOverColor = "#E6F0FA"; // 그리드 행 마우스 오버시 색상
    this.SelectColor = "#EAEAEA"; // 그리드 행 선택시 색상
    this.NumberFormat = null;

    // 내부의 커스텀 컨트롤을 검색한다.
    this.FindControl = function () {
        var ctl = new Array();
        $("." + this.Items).each(function () {
            ctl.push(eval($(this).attr("id")));
        });
        return ctl;
    };

    // 자동으로 합칠 칼럼을 설정한다.
    this.SetAutoMergeColumns = function (Args) {
        this.ColumnsAutoMerge = Args;
    };
    this.SetTargetID = function (Args) {
        this.TargetID = Args;
    };
    // 칼럼의 헤더 텍스트를 설정한다.
    this.SetColumnsText = function (Args) {
        this.ColumnCnt = Args.length;
        this.ColumnsComboList = new Array();
        for (var i = 0; i < Args.length; i++) this.ColumnsComboList[i] = "";
        this.ColumnsText = Args;
    };
    // 칼럼에 바인딩할 데이터명을 설정한다.
    this.SetColumnsName = function (Args) {
        this.ColumnsName = Args;
    };
    // 칼럼의 정렬 속성을 설정한다.
    this.SetColumnsAlign = function (Args) {
        this.ColumnsAlign = Args;
    };
    // 칼럼 속성을 설정한다.
    this.SetColumnsType = function (Args) {
        this.ColumnsType = Args;
    };
    // 칼럼의 편집여부를 설정한다.
    this.SetColumnsEditable = function (Args) {
        this.ColumnsEditable = Args;
    };
    // 칼럼의 숨김여부를 설정한다.
    this.SetColumnsHidden = function (Args) {
        this.ColumnsHidden = Args;
    };
    // 칼럼을 선택시 실핼할 함수명을 설정한다.
    this.SetColumnsLink = function (Args) {
        this.ColumnsLink = Args;
    };
    // 칼럼의 데이터 속성을 설정한다.
    this.SetDatatype = function (Args) {
        this.ColumnsDatatype = Args;
    };
    // 칼럼의 틀고정 여부를 설정한다.
    this.SetFixtype = function (Args) {
        this.ColumnsFix = Args;
    };
    // 칼럼의 Stripe Color를 설정한다.
    this.SetStripeColor = function (Args) {
        this.ColumnsStripeColor = Args;
    };
    // 칼럼의 넓이를 설정한다.
    this.SetColumnsWidth = function (Args) {
        this.CellWidth = Args;
    };
    // 칼럼에 수정시 자동저장여부를 설정한다.
    this.SetAutoSaveFunction = function (Args) {
        if (typeof (Args) == "function") {
            this.AutoSave = true;
            this.AutoSaveTarget = Args;
        } else {
            this.AutoSave = false;
            this.AutoSaveTarget = null;
        }
    };
    // 칼럼에 달력형태일시 날짜타입 입력
    this.SetDateFormat = function (Args) {
        this.DateFormat = Args;
    };
    this.SetArgs = function (Args) {
        this.ArgArr = Args;

    };
    this.SetPkg = function (PName) {
        this.PNames = PName;
    };
    this.SetNumberFormat = function (Args) {
        this.NumberFormat = Args;
    };

    // Biz의 클래스명
    this.TypeName = "";
    // Biz의 메소드명
    this.MethodName = "";
    // Biz에 전송할 파라미터변수
    this.Param = [];
    // Biz를 호출하기위한 클래스명, 메소드명을 Sheet에 설정한다.
    this.DataSource = function (typeName, methodName) {
        // 페이징을 사용하지 않을 경우 숨김
        if (this.UsePage != "true") {
            var thisGrid_navbar = "#" + this.Items + "_navbar";

            setTimeout(function () {
                $(thisGrid_navbar).hide();
            }, 500);
        }

        this.TypeName = typeName;
        this.MethodName = methodName;
    };
    // Biz에 전송할 파라미터를 설정한다.
    this.Params = function (params) {
        // 기본값 체크
        if (params["CurrentPageIndex"] == undefined) params["CurrentPageIndex"] = this.PagingNumber();
        if (document.getElementById(this.Items + "_PageSize") != null) {
            this.PageSize = document.getElementById(this.Items + "_PageSize").value;
            params["PageSize"] = this.PageSize;
        }

        if (params["PageSize"] == undefined) {
            params["PageSize"] = this.PageSize;
        }
        else {
            this.PageSize = params["PageSize"];
        }
        this.Param = params;
    };
    this.AddColumns = function (text, value, width, link, align, editable, hidden, datatype, columnstype, fix, automerge, targetid, dateformat) {
        // 필수요소 체크
        if (text.trim() == "" || value.trim() == "") {
            alert("컬럼의 이름이나 값이 없습니다.");
        }
        if (width.trim() == "") {
            width = "100";
        }
        if (align == undefined || align.trim() == "") {
            align = "Center";
        }
        if (editable == undefined || editable.trim() == "") {
            editable = "false";
        }
        if (hidden == undefined || hidden.trim() == "") {
            hidden = "false";
        }
        if (datatype == undefined || datatype.trim() == "") {
            datatype = "Text";
        }
        if (columnstype == undefined || columnstype.trim() == "") {
            columnstype = "Text";
        }
        if (fix == undefined || fix.trim() == "") {
            fix = "false";
        }
        if (automerge == undefined) automerge = false;
        if (link == undefined) link = null;
        var color = "#000000";

        // 설정한 값 배열에서 추가
        this.ColumnsText.push(text);
        this.ColumnsName.push(value);
        this.CellWidth.push(width);
        this.ColumnsAlign.push(align);
        this.ColumnsEditable.push(editable);
        this.ColumnsHidden.push(hidden);
        this.ColumnsLink.push(link);
        this.ColumnsDatatype.push(datatype);
        this.ColumnsType.push(columnstype);
        this.ColumnsFix.push(fix);
        this.ColumnsAutoMerge.push(automerge);
        this.TargetID.push(targetid);
        this.DateFormat.push(dateformat);
        this.ColumnsStripeColor.push(color);

        // 헤더 추가
        var head_html = "";

        head_html += "<th class='JINSheet_Hcell' name ='AddHead' style= 'width : " + width + "px; height: 28px;'>";
        head_html += "<div style='overflow: hidden; white-space: nowrap; -ms-text-overflow: ellipsis;'>";
        head_html += text;
        head_html += "<span id='" + this.Items + "_sortflag_" + this.ColumnsName.length + "'></span>";
        head_html += "<div></div>";
        head_html += "</div>";
        head_html += "</th>";

        if (eval(this.UseFix)) {
            $("#" + this.Items + "_Bodyhead").parent().find("tr").append(head_html);
        }
        else {
            $("#" + this.Items + "_Mainhead").find("tr").append(head_html);
        }
    };
    // Biz를 호출하여 Sheet에 데이터를 바인딩한다.
    this.BindList = function (num, pageSize) {
        // 프로그래스바 활성
        this.ProgressShow();

        // SelectedRow 초기화
        if (pageSize != undefined && pageSize != null) {
            this.Param["PageSize"] = pageSize;
            this.PageSize = pageSize;
        }
        this.SelectedRow = null;
        this.CurrPageNum = num; // 현제페이지를 설정
        var WebSheetItems = this; // 콜백실행위치설정
        this.Param["CurrentPageIndex"] = num;

        PageMethods.InvokeServiceTable(this.Param, this.TypeName, this.MethodName, function (e) {
            var ds = eval(e);
            if (ds == undefined || ds == "") {
                alert("데이터가 없습니다");
                return;
            }
            WebSheetItems.DataBind(ds.Tables[0], ds.Tables[1]);
        }, function (e) {
            ProgressBar.hide();
            alert(e.get_message());
        });
    };
    // Biz호출후 콜백에서 JSON 데이터로 HTML을 생성 
    this.DataBind = function (dataObj, TotCount) {
        this.BeforeDataBind();
        if (dataObj != undefined) this.CurrData = dataObj;
        if (TotCount != undefined && TotCount.Rows.length > 0) this.TotalListCnt = TotCount.Rows[0]["TOTALCOUNT"] * 1;
        // 바인딩시 정렬표시 제거
        $("#" + this.Items + " .grid_sort").html("");
        this.MakeTableRows(this.CurrData);
        this.SheetLoadEnd(); // 디자인관련처리부분추가(사용자는 CallBack()을 사용함)
        // 각종 이벤트 처리후 틀고정일시 크기 재조정이 필요함(틀고정 꺠짐 예외처리)
        if (this.UseFix == "true") {
            setTimeout(this.SheetLoadEnd, 300);
            setTimeout(this.SheetLoadEnd, 600);
        }
        this.CallBack();
        this.ProgressHide();
        $(window).resize();
    };
    // Biz를 호출하여 CS단에서 엑셀자료를 생성한후 다운로드 한다
    // 2015.06.02 장상휘 추가
    //this.ExcelFileName = "";
    this.ExcelDownload = function (filename) {
        this.ProgressShow();
        // 프로그래스바 활성
        this.SelectedRow = null;
        this.CurrPageNum = 1; // 현재페이지를 설정
        var WebSheetItems = this; // 콜백실행위치설정
        _ExcelFileDownloadName = "";
        if (filename != undefined) {
            _ExcelFileDownloadName = filename;
        }
        if (_ExcelFileDownloadName == "") {
            _ExcelFileDownloadName = "ExcelDownload.xls";
        }

        if (this.Param.length == 0) {
            this.Params(new Object());
        }

        this.Param["CurrentPageIndex"] = 1;
        var tmpCntExcel = this.Param["PageSize"];
        this.Param["PageSize"] = 99999;

        // 헤더 생성
        var div = document.createElement("div");
        $(div).append("<meta http-equiv='Content-Type' content='text/html;charset=utf-8'>");
        $(div).append("<table border='1'></table>");
        var table = $(div).find("table");


        // 멀티헤더 적용시 
        if ($("#" + this.Items + "_main").find(".multihead").length > 0) {
            var tbody = $("#" + this.Items + "_main").find(".multihead").eq(0).parent().parent();
            var html = "";

            for (var i = 0; i < $(tbody).find("tr").length; i++) {
                html += "<tr>";

                $(tbody).find("tr").eq(i).find("th").each(function (j) {
                    html += "<td ";
                    if ($(this).attr("rowspan") != "") {
                        html += "rowspan='" + $(this).attr("rowspan") + "'";
                    }
                    if ($(this).attr("colspan") != "") {
                        html += "colspan='" + $(this).attr("colspan") + "'";
                    }
                    html += " style='background-color:#DCDCDC;'>";
                    html += $(this).find("div").text();
                    html += "</td>";
                });

                // 틀 고정 시
                if ($("#" + this.Items + "_body table tbody").length == 2) {
                    $("#" + this.Items + "_body table tbody").eq(0).find("tr").eq(i).find("th").each(function (j) {
                        html += "<td ";
                        if ($(this).attr("rowspan") != "") {
                            html += "rowspan='" + $(this).attr("rowspan") + "'";
                        }
                        if ($(this).attr("colspan") != "") {
                            html += "colspan='" + $(this).attr("colspan") + "'";
                        }
                        html += " style='background-color:#DCDCDC;'>";
                        html += $(this).find("div").text();
                        html += "</td>";
                    });
                }
            };
            //});

            html += "</tr>";
            html += "<tr><td>jini</td></tr>";

            $(table).append(html);
        }
        else {
            $(table).append("<tr></tr>");

            $("#" + this.Items + "_Mainhead tr th div").each(function () {
                if ($(this).text() != "") {
                    $(table).find("tr").append("<td style='background-color:#DCDCDC;'>" + $(this).text() + "</td>");
                }
            });
            $("#" + this.Items + "_Bodyhead tr th div").each(function () {
                if ($(this).text() != "") {
                    $(table).find("tr").append("<td style='background-color:#DCDCDC;'>" + $(this).text() + "</td>");
                }
            });

            // 틀 고정 시 
            if ($("#" + this.Items + "_Mainhead tr th div").length == 0
                        && $("#" + this.Items + "_Bodyhead tr th div").length == 0) {
                $("#" + this.Items + "_head div").each(function () {
                    if ($(this).text() != "") {
                        $(table).find("tr").append("<td style='background-color:#DCDCDC;'>" + $(this).text() + "</td>");
                    }
                });
            }

            $(table).append("<tr><td>jini</td></tr>");
        }

        var ht = new Array();
        ht.push(div.outerHTML);


        for (var j = 0; j < this.ColumnsName.length; j++) {
            if (this.ColumnsHidden[j] == "false") {
                ht.push(this.ColumnsName[j]);
            }
        }

        PageMethods.InvokeServiceTable_Excel(this.Param, ht, this.TypeName, this.MethodName, function (e) {
            WebSheetItems.ExcelBind(e);
        }, function (e) {
            ProgressBar.hide();
            alert(e.get_message());
        });
        this.Param["PageSize"] = tmpCntExcel;
    };
    this.ExcelBind = function (e) {
        var ds = eval(e);
        if (ds == undefined || ds == "") {
            alert("데이터가 없습니다");
            this.ProgressHide();
            return;
        }

        var excelfile = ds.Tables[0].Rows[0]["HTML"].toString();

        location.href = "/Resources/Framework/FileExcelDownload.aspx?PATH=" + excelfile + "|" + _ExcelFileDownloadName + "&ExcelDown=Y";

        this.ProgressHide();
    };

    // 컨트롤에서 로드 완료후 호출되는부분 (cs에서 재정의함)
    this.SheetLoadEnd = function () {
        // 첨부가있을시 처리
        //$("#" + this.Items).find(".FileUploadControl").each(function () {
        //    $(this).plupload({ runtimes: 'html5,flash,silverlight,html4', url: '/Resources/Framework/plupload.ashx', max_file_count: 0, chunk_size: '200kb', rename: false, unique_names: true, sortable: false, dragdrop: true, multiple_queues: true, readmode: false, filters: { max_file_size: '200mb' }, views: { list: true, thumbs: true, active: 'list' }, flash_swf_url: '/Resources/Framework/Moxie.swf', silverlight_xap_url: '/Resources/Framework/Moxie.xap' });
        //});

        // 틀고정시 레이어 크기 변경
        if (this.UseFix == "true" && this.UseHFix == "true") {  // 이중 틀고정 추가부분

            var div_width = $("#" + this.Items + "_layer").width();
            var div_main = $("#" + this.Items + "_main").width();
            if (div_main == 1) {
                $("#" + this.Items + "_body").width(div_width-2);
                $("#" + this.Items + "_body").css("float", "left");
                $("#" + this.Items + "_body").css("padding", "0px");
                $("#" + this.Items + "_body").css("margin-left", "-1px");
            }
            else {
                $("#" + this.Items + "_body").width(div_width - div_main - 2);
            }
            //$("#" + this.Items + "_main>table").css("border-right", "1px solid #DCDCDC");
            $("#" + this.Items + "_body").css("overflow", "scroll").css("overflow-y", "hidden");
            $("#" + this.Items + "_main").css("overflow", "hidden").css("overflow-y", "hidden");

            var SheetObj_layer = document.getElementById(this.Items + "_layer");
            var SheetObj_body = document.getElementById(this.Items + "_body");
            var SheetObj_body_ScrollDiv = document.getElementById(this.Items + "_body_ScrollDiv");
            var SheetObj_main_ScrollDiv = document.getElementById(this.Items + "_main_ScrollDiv");

            // 모바일 예외처리
            $(SheetObj_main_ScrollDiv).width(div_main + getScrollBarWidth());
            // 사파리 예외처리
            //$(".JINSheet_HFCell, .JINSheet_HCell").css("padding", "5px 0px 5px 0px");
            $(".JINSheet_HFCell, .JINSheet_HCell").css("padding", "0px");
            $(".JINSheet_HFCell, .JINSheet_HCell").css("margin", "0px 5px");
            $(".JINSheet_HFCell, .JINSheet_HCell").find("div:first").css("margin", "5px");


            $(".JINSheet_ScrollBody").eq(1).find("table:first").find("th:last div").css("margin-right", "15px");

            var agent = navigator.userAgent.toLowerCase();
            if (agent.indexOf("chrome") != -1) {

            } else if (agent.indexOf("safari") != -1) {
                var fix_width = $(".JINSheet_ScrollBody>table").eq(0).width();
                $(".JINSheet_ScrollBody>div>table").eq(0).width(fix_width + 2);
                fix_width = $(".JINSheet_ScrollBody>table").eq(1).width();
                $(".JINSheet_ScrollBody>div>table").eq(1).width(fix_width + 2);

            } else if (agent.indexOf("firefox") != -1) {

            }

            if (SheetObj_body.onscroll == null) {
                SheetObj_body.onscroll = function (e) {
                    SheetObj_body_ScrollDiv.style.width = (e.target.clientWidth + e.target.scrollLeft - 1) + "px";
                    //SheetObj_body_ScrollDiv.style.width = $(SheetObj_main_ScrollDiv).width();// (e.target.clientWidth + e.target.scrollLeft - 1) + "px";
                }
            }

            if (SheetObj_body_ScrollDiv.onscroll == null) {
                SheetObj_body_ScrollDiv.onscroll = function (e) {
                    SheetObj_main_ScrollDiv.scrollTop = SheetObj_body_ScrollDiv.scrollTop;
                }
            }

            if (SheetObj_main_ScrollDiv.onscroll == null) {
                SheetObj_main_ScrollDiv.onscroll = function (e) {
                    SheetObj_body_ScrollDiv.scrollTop = SheetObj_main_ScrollDiv.scrollTop;
                }
            }

            //            // 화면 사이즈 변경 시 스크롤바 위치
            //            SheetObj_body_ScrollDiv.style.width = (SheetObj_body_ScrollDiv.parentNode.clientWidth + SheetObj_body_ScrollDiv.parentNode.scrollLeft - 1) + "px";

            //            // 틀고정 보정
            //            if (Math.abs(Number($(SheetObj_body_ScrollDiv).offset().top) - Number($(SheetObj_main_ScrollDiv).offset().top)) > 10) {
            //                for (var i = 0; i < 50; i++) {
            //                    if (Math.abs(Number($(SheetObj_body_ScrollDiv).offset().top) - Number($(SheetObj_main_ScrollDiv).offset().top)) > 10) {
            //                        $(SheetObj_body).css("width", ($(SheetObj_body).width() - 2));
            //                    } else break;
            //                }

            //                var gridMinSize = $(SheetObj_body).width();
            //                var gridMaxSize = gridMinSize;

            //                for (var i = 0; i < 50; i++) {
            //                    if (Math.abs(Number($(SheetObj_body_ScrollDiv).offset().top) - Number($(SheetObj_main_ScrollDiv).offset().top)) <= 10) {
            //                        gridMaxSize = $(SheetObj_body).width();
            //                        $(SheetObj_body).css("width", ($(SheetObj_body).width() + 2));
            //                    } else break;
            //                }

            //                for (var i = 0; i < 50; i++) {
            //                    if (Math.abs(Number($(SheetObj_body_ScrollDiv).offset().top) - Number($(SheetObj_main_ScrollDiv).offset().top)) > 10) $(SheetObj_body).css("width", gridMinSize);
            //                    else break;
            //                }

            //                $(SheetObj_body).css("width", Math.floor(gridMaxSize));
            //            }

            //            // content_bx의 Height가 내용보다 길어 스크롤이 생길경우 께짐 방지
            //            if (window.onscroll == null) {
            //                window.onscroll = function (e) {
            //                    SheetObj_body.style.width = (SheetObj_layer.clientWidth - div_main - 2) + "px";
            //                }
            //            }



        } else if (this.UseFix == "true") {
            var div_width = $("#" + this.Items + "_layer").width();
            var div_main = $("#" + this.Items + "_main").width();
            $("#" + this.Items + "_body").width(div_width - div_main - 2);
            $("#" + this.Items + "_main>table").css("border-right", "1px solid #DCDCDC");
            $("#" + this.Items + "_body").css("overflow", "scroll").css("overflow-y", "hidden");
            $("#" + this.Items + "_main").css("overflow", "scroll").css("overflow-y", "hidden");
        }
        else {
            var div_main = $("#" + this.Items + "_main").width();
            var default_width = $("#content").width();
            if (div_main > default_width) {
                $("#" + this.Items + "_main").width(default_width);
                $("#" + this.Items + "_main").css("overflow-x", "scroll");
            }
            else {
                $("#" + this.Items + "_main").css("width", "100%");
                $("#" + this.Items + "_main").css("overflow-x", "scroll");
            }
            if (div_main == 0) { // ie버그처리
                $("#" + this.Items + "_main").css("width", "100%");
                $("#" + this.Items + "_main").css("overflow-x", "scroll");
            }

            if (this.UseHFix == "true") {
                //                var main_width = $("#" + this.Items).width();
                //                var sub_width = $("#" + this.Items + "_main").find("table").eq(0).width();

                ////                $("#" + this.Items + "_main>div").each(function (i) {
                ////                    if (i == 0 || i == 1) {
                ////                        if (main_width > sub_width) {
                ////                            $(this).width(main_width);
                ////                        }
                ////                        else {
                ////                            $(this).width(sub_width);
                ////                        }
                ////                    }
                ////                });

                //                $(".JINSheet_NormalTable tr").each(function () {
                //                    $(this).find("th:last, td:last").find("div").css("margin-right",getScrollBarWidth() + "px");
                //                });

                //                $(".JINSheet_HFCell, .JINSheet_HCell").css("padding", "0px");
                //                $(".JINSheet_HFCell, .JINSheet_HCell").css("margin", "0px 5px");

                //                $(".JINSheet_ScrollBodyHeight").css("overflow", "scroll");
                //                $(".NoneScroll").css("overflow-y", "scroll");
                //                $(".NoneScroll").css("overflow-x", "hidden");
                //                $("#" + this.Items + "_main").css("overflow", "hidden").css("overflow-y", "hidden");

                //              
                //                $(".JINSheet_HFCell, .JINSheet_HCell").css("padding", "0px");
                //                $(".JINSheet_HFCell, .JINSheet_HCell").css("margin", "0px 5px");
                //                $(".JINSheet_HFCell, .JINSheet_HCell").find("div:first").css("margin", "5px");
                //                //var scroll_width = $(".JINSheet_ScrollBodyHeight").width();
                //                //$(".NoneScroll").width(scroll_width);
                //                //                var table1 = $("#" + this.Items + "_main").find("table").eq(0);
                //                //                var table2 = $("#" + this.Items + "_main").find("table").eq(1);
                //                //                $(table2).width($(table1).width());
                //                var layer_width = $(".con_data_02").width();
                //                $(".con_data_02").find("table").eq(0).width(layer_width);


                //                var scroll1 = $(".NoneScroll")[0];
                //                var scroll2 = $(".JINSheet_ScrollBodyHeight")[0];

                //                if (scroll1.onscroll == null) {
                //                    scroll1.onscroll = function (e) {
                //                        scroll2.scrollLeft = scroll1.scrollLeft;
                //                    }
                //                }

                //                if (scroll2.onscroll == null) {
                //                    scroll2.onscroll = function (e) {
                //                        scroll1.scrollLeft = scroll2.scrollLeft;
                //                    }
                //                }
            }
        }
    };
    // 사용자가 컨트롤 로드 완료후 호출하는부분 (각 페이지별로 재정의함)
    this.CallBack = function () {
    };
    // 사용자가 Invoke 완료후 DataBind 전 호출하는부분 (각 페이지 별로 재정의함)
    this.BeforeDataBind = function () {
    };
    // 현재 설정된 페이징의 번호를 가져온다.
    this.PagingNumber = function (num) {
        if (num == undefined) {
            return document.getElementById(this.Items + "_Paging").value;
        }
        else {
            document.getElementById(this.Items + "_Paging").value = num;
        }
    };
    // JSON데이터로 테이블의 Row를 생성
    this.MakeTableRows = function (CellDatas) {

        // 동적컬럼 적용시 헤더 스크립트로 처리
        if (this.AutoColumns) {
            // 컬럼의 헤더 속성을 컬럼명으로 자동으로 지정한다.
            var columns_name = Object.keys(CellDatas.Rows[0]);
            for (var i = 0; i < columns_name.length; i++) {
                var head_html = "";
                head_html += "<th class='JINSheet_Hcell'>" + columns_name[i] + "</th>";
                $("#" + this.Items + "_Mainhead").find("tr").append(head_html);
            }

            //alert(columns_name);
            var false_val = [];
            var color_val = [];
            for (var i = 0; i < columns_name.length; i++) {
                false_val.push("false");
                color_val.push("#000000");
            }
            this.SetColumnsText(columns_name);
            this.SetColumnsName(columns_name);
            this.SetColumnsHidden(false_val);
            this.SetStripeColor(color_val);

            var hederHtml = "";
            hederHtml += "";
            hederHtml += "";

            //$("#" + this.Items + "_main").find("table").prepend();
        }

        var SheetObj_Main = document.getElementById(this.Items + "_Mainbody"); // TBODY(틀고정시 고정영역)
        var SheetObj_Body = document.getElementById(this.Items + "_Bodybody"); // TBODY(틀고정시 비고정영역)
        var tmpID = "";
        var CellText = "";
        var CMergeCount = 0;
        var MergeCount = new Array();
        var MergeListCount = -1;
        // 현SHEET에 Row 가 존재한다면 제거..
        for (var i = SheetObj_Main.rows.length - 1; i > -1; i--) {
            SheetObj_Main.deleteRow(i);
            if (SheetObj_Body.rows.length > i) SheetObj_Body.deleteRow(i);
        }

        var CName = "";
        for (var i = 0; i < ObjectCount(CellDatas.Rows); i++) {
            var RowObj_Main = document.createElement("tr"); // 고정영역 ROW 생성
            var RowObj_Body = document.createElement("tr"); // 비고정영역 ROW 생성
            var FChk = false;

            // 행배경색 지정
            if (i % 2 == 0) BgColor = this.BgColor01;
            else BgColor = this.BgColor02;

            RowObj_Main.setAttribute("OrgBgColor", BgColor);
            RowObj_Body.setAttribute("OrgBgColor", BgColor);
            RowObj_Main.style.background = BgColor;
            RowObj_Body.style.background = BgColor;
            // 행 클래서 설정 (필요시 css에 정의)
            RowObj_Main.className = "JINSheet_Row";
            RowObj_Body.className = "JINSheet_Row";
            // Row의 번호
            RowObj_Main.id = this.Items + "_MainRow_" + i;
            RowObj_Body.id = this.Items + "_BodyRow_" + i;
            if (this.OverEvent == true) {
                RowObj_Main.onmouseover = function () { SheetMouseEvent(this, true); };
                RowObj_Main.onmouseout = function () { SheetMouseEvent(this, false); };

                RowObj_Body.onmouseover = function () { SheetMouseEvent(this, true); };
                RowObj_Body.onmouseout = function () { SheetMouseEvent(this, false); };
            }
            if (this.UseCheckBox == "true" && CMergeCount == 0) {
                if (this.CheckBoxAutoMerge > 0) {// 체크박스 Merge수정
                    CMergeCount = this.CheckBoxAutoMerge;
                    //CMergeCount = 1;
                    //for (var ii = i + 1; ii < ObjectCount(CellDatas.Rows); ii++) {
                    //    if (CellDatas.Rows[i][this.CheckBoxAutoMerge] == CellDatas.Rows[ii][this.CheckBoxAutoMerge]) CMergeCount++;
                    //    else break;
                    //}
                }
                RowObj_Main.appendChild(this.MakeChkTdCell(i, CMergeCount, CellDatas.length));
                FChk = true;
            }
            if (CMergeCount > 0) CMergeCount--;
            for (var tmpii = 0; tmpii < MergeCount.length; tmpii++) {
                if (MergeCount[tmpii] > 0) MergeCount[tmpii]--;
            }

            for (var j = 0; j < this.ColumnsName.length; j++) {
                if (i == 0) MergeCount.push(0);
                if (this.ColumnsHidden[j] == "false") {
                    var CellMakeChk = true;
                    if (MergeCount[j] > 0) CellMakeChk = false;
                    CellText = CellDatas.Rows[i][this.ColumnsName[j]];
                    if (FChk) {
                        CName = "JINSheet_Cell";
                    }
                    else {
                        FChk = true;
                        CName = "JINSheet_FCell"
                    }

                    if (this.ColumnsAutoMerge[j] && MergeCount[j] == 0) {
                        MergeCount[j] = 1;
                        for (var ii = i + 1; ii < ObjectCount(CellDatas.Rows); ii++) {
                            if (CellDatas.Rows[i][this.ColumnsName[j]] == CellDatas.Rows[ii][this.ColumnsName[j]]) MergeCount[j]++;
                            else break;
                        }
                        for (var tmpMi = j - 1; tmpMi > -1; tmpMi--) {
                            if (this.ColumnsAutoMerge[tmpMi]) {
                                if (MergeCount[tmpMi] < MergeCount[j]) MergeCount[j] = MergeCount[tmpMi];
                                break;
                            }
                        }
                        this.ChkMerge = true;
                    }
                    if (CellMakeChk) {
                        if (this.UseFix == "true" && this.ColumnsFix[j] == "false") {
                            if (FChk) RowObj_Body.appendChild(this.MakeTextTdCell(CellText, this.ColumnsAlign[j], this.ColumnsEditable[j], this.ColumnsLink[j], i, j, this.Items, CName, MergeCount[j]));
                            else {
                                RowObj_Body.appendChild(this.MakeTextTdCell(CellText, this.ColumnsAlign[j], this.ColumnsEditable[j], this.ColumnsLink[j], i, j, this.Items, CName, MergeCount[j]));
                            }
                        } else {
                            RowObj_Main.appendChild(this.MakeTextTdCell(CellText, this.ColumnsAlign[j], this.ColumnsEditable[j], this.ColumnsLink[j], i, j, this.Items, CName, MergeCount[j]));
                        }
                    }
                }
            }

            // 가로,세로 틀고정 시 마지막 TD 오른쪽 스크롤바 만큼 Padding 값 추가
            if (this.UseFix == "true" && this.UseHFix == "true") {
                RowObj_Body.cells[RowObj_Body.cells.length - 1].style.paddingRight = "22px";
            }

            SheetObj_Main.appendChild(RowObj_Main);
            SheetObj_Body.appendChild(RowObj_Body);
        }

        if (this.Defaultline == true) {
            for (var i = 0; i < this.PageSize - CellDatas.length; i++) {
                var RowObj_Main = document.createElement("tr");
                var RowObj_Body = document.createElement("tr");
                var FChk = false;

                if ((CellDatas.length + i) % 2 == 0) BgColor = this.BgColor01;
                else BgColor = this.BgColor02; //F4F8FB

                RowObj_Main.setAttribute("OrgBgColor", BgColor);
                RowObj_Body.setAttribute("OrgBgColor", BgColor);
                RowObj_Main.style.background = BgColor;
                RowObj_Body.style.background = BgColor;

                RowObj_Main.className = "JINSheet_Row";
                RowObj_Body.className = "JINSheet_Row";
                RowObj_Main.id = this.Items + "_MainRow_" + i;
                RowObj_Body.id = this.Items + "_BodyRow_" + i;

                if (this.UseCheckBox == "true") {
                    RowObj_Main.appendChild(this.MakeBlankTdCell());
                }

                for (var j = 0; j < this.ColumnsName.length; j++) {
                    if (this.ColumnsHidden[j] == "false") {
                        RowObj_Main.appendChild(this.MakeBlankTdCell());
                    }
                }

                SheetObj_Main.appendChild(RowObj_Main);
                SheetObj_Body.appendChild(RowObj_Body);
            }
        }
        // 페이징을 추가
        // 페이징 없을 경우 해당 영역 display none;
        if (this.UsePage != "true") {

            document.getElementById(this.Items + "_navbar").style.display = "none";
            document.getElementById(this.Items + "_body").style.display = "none";
        }

        document.getElementById(this.Items + "_navbar").innerHTML = "<div class='paging_bx'><div class=\"total\">문서건수 : <span class=\"point\"></span> 건</div><div class='paging_combo'>" + this.CreatePageSizeCombo() + "</div><div class='paging'>" + this.CreateNavi() + "</div><div class='clear'></div></div>";

        // 전체 문서갯수 표시
        $("#" + this.Items + "_navbar .point").text(this.TotalListCnt);

        // 틀고정시 body div 넓이 조절
        if (this.UseFix == "true") {
            document.getElementById(this.Items + "_body").style.display = "block";
            var div_width = $("#" + this.Items + "_layer").width();
            var div_main = $("#" + this.Items + "_main").width();
            $("#" + this.Items + "_body").width(div_width - div_main - 1);
            $("#" + this.Items + "_main>table").css("border-right", "1px solid #DCDCDC");
            $("#" + this.Items + "_body").css("overflow", "scroll").css("overflow-y", "hidden");
            $("#" + this.Items + "_main").css("overflow", "scroll").css("overflow-y", "hidden");
        }
    };
    // PageSize Combobox 를 생성한다.
    this.CreatePageSizeCombo = function () {
        var cboObj = "<select id=\"" + this.Items + "_PageSize\" style=\"width: 50px;\" onchange=\"" + this.Items + ".BindList(1, this.value)\">";
        var arr = [5, 10, 15, 20, 30, 50, 100];

        for (var i = 0; i < arr.length; i++) {
            cboObj += "<option value=\"" + arr[i] + "\""
            if (arr[i] == this.PageSize) {
                cboObj += " selected";
            }
            cboObj += ">" + arr[i] + "</option>";
        }
        cboObj += "</select>";
        return cboObj;
    };
    // html에 빈 td를 생성하여 추가한다.
    this.MakeBlankTdCell = function () {
        var CellObj = document.createElement("td");
        CellObj.style.height = this.CellHeight + "px";
        return CellObj;
    };
    // html에 td를 생성하여 데이터를 바인딩한다.
    this.MakeTextTdCell = function (CellData, strAlign, isEditable, LinkFnc, RNum, CNum, ObjID, ClassName, rowspanCnt) {
        var CellObj = document.createElement("td");
        CellObj.className = ClassName;
        CellObj.style.textAlign = strAlign;
        CellObj.style.height = this.CellHeight + "px";
        CellObj.setAttribute("EditMode", "0");
        CellObj.id = this.Items + "_" + RNum + "_" + CNum;
        var width = this.CellWidth[CNum];
        if (!isNaN(width)) {
            width = width + "px";
        }
        $(CellObj).css("width", width);

        // 사용자 지정 Stripe Color 처리
        var stripeColors = this.ColumnsStripeColor[CNum].split(',');

        if (stripeColors.length == 2 && (stripeColors[0] != "#000000" || stripeColors[1] != "#000000")) {
            if (RNum % 2 == 0) BgColor = stripeColors[1];
            else BgColor = stripeColors[0];

            $(CellObj).css("backgroundColor", BgColor);
        }

        // 데이터의 타입에 따른 문자열 처리
        if (this.ColumnsDatatype[CNum] == "amount") { // 사용안함
            if (CellData.isNumber() == true) {
                CellObj.innerHTML = String(parseFloat(CellData)).comma();
                CellObj.setAttribute("OrgData", String(parseFloat(CellData)));
                this.CurrData[RNum][this.ColumnsName[CNum]] = String(parseFloat(CellData));
            } else {
                CellObj.innerHTML = CellData.comma();
                CellObj.innerHTML = CellData;
            }

        }
        else if (this.ColumnsDatatype[CNum] == "Number") { // 숫자일시
            var data = 0;
            // NumberFormat가 있을시
            if (this.NumberFormat[CNum] != "") {
                data = (CellData * 1).format(this.NumberFormat[CNum]);
            }
            else {
                data = (CellData + "").numberFormat();
            }
            //var data = CellData;
            CellObj.innerHTML = data;
            CellObj.setAttribute("OrgData", CellData);
        }
        else if (this.ColumnsDatatype[CNum] == "Date") { // 날짜일시
            CellData = CellData.split(' ')[0];
            CellObj.innerHTML = CellData.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
            CellObj.setAttribute("OrgData", CellData);
        }
        else if (this.ColumnsDatatype[CNum] == "DateTime") { // 날짜시간일시
            CellObj.innerHTML = CellData;
            CellObj.setAttribute("OrgData", CellData);
        }
        else if (this.ColumnsDatatype[CNum] == "YN") {  // Yes or No
            CellObj.innerHTML = (CellData == "1") ? "Y" : "N";
            CellObj.setAttribute("OrgData", CellData);
        }
        else if (this.ColumnsDatatype[CNum] == "Button") { // 버튼일시
            var BtnObj = document.createElement("input");
            BtnObj.type = "button";
            BtnObj.value = CellData;
            BtnObj.style.width = "98%";
            BtnObj.style.height = "auto"; // (this.CellHeight - 4) + "px";
            BtnObj.style.padding = "2px 2px 2px 2px";
            BtnObj.style.cursor = "pointer";
            BtnObj.id = this.Items + "_" + RNum + "_" + CNum + "_btn";
            $(BtnObj).on("mouseover", function () {
                this.style.backgroundColor = "#F58714";
                this.style.color = "#FFFFFF";
            });
            $(BtnObj).on("mouseout", function () {
                this.style.backgroundColor = "#FFFFFF";
                this.style.color = "#646464";
            });
            if (typeof (LinkFnc) == "function") {
                //행 삭제 후 RNum 오류로 변경 : 2015-02-23
                BtnObj.onclick = function () {
                    LinkFnc(BtnObj.id.split('_')[1], BtnObj.id.split('_')[2]);
                };
            }
            CellObj.appendChild(BtnObj);
            CellObj.setAttribute("OrgData", CellData);
            CellObj.style.paddingLeft = "5px";
            CellObj.style.paddingRight = "5px";
        }
        else if (this.ColumnsDatatype[CNum] == "Attach") { // 첨부일시
            var attach_html = "";

            var attach_id = this.Items + "_" + RNum; // this.Items + guid();

            attach_html += "<div id=\"fu" + attach_id + "\" class=\"FileUploadControl\" SimpleMode=\"True\">";
            attach_html += "    <p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>";
            attach_html += "</div>";
            //attach_html += "<script type=\"text/javascript\">";

            //attach_html += "</script>";
            attach_html += "<input type=\"hidden\" name=\"fu" + attach_id + "_filedata\" id=\"fu" + attach_id + "_filedata\" />";
            attach_html += "<input type=\"hidden\" name=\"fu" + attach_id + "_viewdata\" id=\"fu" + attach_id + "_viewdata\" />";
            attach_html += "<input type=\"hidden\" name=\"fu" + attach_id + "_drivedata\" id=\"fu" + attach_id + "_drivedata\" />";
            $(CellObj).append(attach_html);


        }
        else { // 일반적인 텍스트
            // 편집모드 콤보일시
            if (this.ColumnsType[CNum] == "Combo") {
                var cDataText = "";
                $("#" + eval(this.TargetID[CNum]).items).find("option").each(function () {
                    if ($(this).attr("value") == CellData) {
                        cDataText = $(this).html();
                    }
                });
                CellObj.innerHTML = cDataText;
                CellObj.setAttribute("OrgData", CellData);
            }
            else {
                CellObj.innerHTML = CellData;
                CellObj.setAttribute("OrgData", CellData);
            }
        }

        if (CellObj.childNodes.length > 0 && CellObj.childNodes[0].nodeName == "#text") CellObj.innerHTML = "<div style='overflow:hidden;text-overflow:ellipsis;white-space:nowrap;'>" + CellObj.innerHTML + "</div>";

        if (rowspanCnt > 0) {
            CellObj.rowSpan = rowspanCnt;
        }

        // 타이틀 추가 
        CellObj.title = CellData;

        // 버튼 타입 제외하고 처리함.
        if (this.ColumnsDatatype[CNum] != "Button") {
            // 칼럼이 편집모드일시
            if (this.ColumnsEditable[CNum] == "true") {
                var tval = "CellObj.onclick = function() { " + this.Items + ".rowItem_Click(this); if($(CellObj).css('background-image') != 'none'){ SetEditMode(ObjID, this.id.split('_')[1], this.id.split('_')[2])};};";
                eval(tval);
                CellObj.style.cursor = "pointer";
                CellObj.style.backgroundImage = "url('/Resources/Framework/blue_angle.gif')";
                CellObj.style.backgroundPosition = "right top";
                CellObj.style.backgroundRepeat = "no-repeat";

            } else if (typeof (LinkFnc) == "function") {
                var tval = "";
                if (this.ColumnsDatatype[CNum] == "Org") {
                    tval = "CellObj.onclick = function() { LinkFnc(this.id.split('_')[0], this.id.split('_')[1], this.id.split('_')[2], '" + this.TargetID[CNum] + "');};";
                } else {
                    tval = "CellObj.onclick = function() { " + this.Items + ".rowItem_Click(this); LinkFnc(this.id.split('_')[1], this.id.split('_')[2]);};";
                }
                eval(tval);
                CellObj.style.cursor = "pointer";
            } else {
                var tval = "CellObj.onclick = function() { " + this.Items + ".rowItem_Click(this);};";
                eval(tval);
            }
        }
        return CellObj;
    };
    // td에 체크박스 컨트롤을 추가한다.
    this.MakeChkTdCell = function (tmpNum, rowspanCnt, maxRowNum) {
        var CellObj = document.createElement("td");

        if (tmpNum == maxRowNum - 1) CellObj.className = "JINSheet_ChkCellb";
        else CellObj.className = "JINSheet_ChkCell";

        CellObj.style.textAlign = "center";
        CellObj.style.height = this.CellHeight + "px";
        CellObj.style.width = "29px";
        var ChkObj = document.createElement("input");
        ChkObj.id = this.Items + "_chk";
        ChkObj.setAttribute("name", this.Items + "_chk");
        ChkObj.setAttribute("type", "checkbox");
        ChkObj.setAttribute("value", tmpNum);
        if (rowspanCnt > 0) {
            CellObj.rowSpan = rowspanCnt;
        }
        ChkObj.style.border = "0";
        ChkObj.style.width = "18px";
        var tval = "ChkObj.onclick = function() { " + this.Items + ".chkItem_Click(" + tmpNum + ");};";
        eval(tval);
        CellObj.appendChild(ChkObj);
        return CellObj;
    };
    // 페이징 html을 생성한다.
    this.CreateNavi = function () {
        var NavString = "";
        if (this.UsePage != "true") return "";
        // 페이징
        // 페이징싸이즈 / 전체갯수
        // 페이징 데이터 바인딩
        //this.PageSize         //한페이지 사이즈(세션으로 연동)
        //this.PagingSize       //페이지 네비게이터 바의 출력 갯수
        //this.TotalListCnt     //전체 리스트 카운트

        var TotPageCnt = Math.ceil(this.TotalListCnt / this.PageSize);
        var TotLocCnt = Math.ceil(TotPageCnt / this.PagingSize);
        var CurrLocCnt = Math.ceil(this.CurrPageNum / this.PagingSize);
        var LocEnd = (CurrLocCnt * this.PagingSize);
        var LocStart = LocEnd - (this.PagingSize - 1);
        var LinkStr = this.Items + ".MovePage({0});";
        if (LocEnd > TotPageCnt) LocEnd = TotPageCnt;

        // 무조건 나오게
        if (LocStart - 1 < 1) {
            NavString += "<a onclick=\"" + LinkStr.format(1) + "\">Previous</a>";
        }
        else {
            NavString += "<a onclick=\"" + LinkStr.format((LocStart - 1)) + "\">Previous</a>";
        }

        if (LocStart > this.PagingSize) {
            // 젤처음 디자인에서 제외됨
            //NavString += "<a onclick=\"" + LinkStr.format(1) + "\" style=\"cursor:pointer;\"><img src=\"/Resources/Images/btn_list_first.gif\" style=\"vertical-align:middle;\"/></a>";
            //NavString += "<a onclick=\"" + LinkStr.format((LocStart - 1)) + "\" style=\"cursor:pointer;\"><img src=\"/Resources/Images/btn_list_pre.gif\" style=\"vertical-align:middle;\"/></a>&nbsp;";
            //NavString += "<a href=\"" + LinkStr.format((LocStart -1)) + "\">Previous</a>";
        }
        for (var i = LocStart; i < LocEnd + 1; i++) {
            //if (this.CurrPageNum == i) NavString += "&nbsp;<span class=\"class\" style=\"font-size:13px; padding:0px 3px 0px 3px;color:#ff5a00;\">" + i + "</span>"; //"&nbsp;<a onclick=\"" + LinkStr.format(i) + "\" style=\"font-weight:bold; font-size:13px; padding:0px 3px 0px 3px;\">" + i + "</a>";
            //else NavString += "&nbsp;<a onclick=\"" + LinkStr.format(i) + "\" style=\"cursor:pointer; font-size:13px; padding:0px 3px 0px 3px;\">" + i + "</a>";
            if (this.CurrPageNum == i) NavString += "<a class='on'>" + i + "</a>";
            else NavString += "<a onclick=\"" + LinkStr.format(i) + "\">" + i + "</a>";
        }

        // 무조건 나오게
        NavString += "<a onclick=\"" + LinkStr.format((LocEnd + 1)) + "\">Next</a>";

        if (TotPageCnt > LocEnd) {
            //NavString += "&nbsp;&nbsp;<a onclick=\"" + LinkStr.format((LocEnd + 1)) + "\" style=\"cursor:pointer;\"><img src=\"/Resources/Images/btn_list_next.gif\" style=\"vertical-align:middle;\"/></a>";
            //NavString += "<a onclick=\"" + LinkStr.format((LocEnd + 1)) + "\">Next</a>";
            // 젤마지막 디자인에서 제외됨
            //NavString += "<a onclick=\"" + LinkStr.format(TotPageCnt) + "\" style=\"cursor:pointer;\"><img src=\"/Resources/Images/btn_list_end.gif\" style=\"vertical-align:middle;\"/></a>";
        }

        return NavString;
    };

    // 해당 컬럼을 기준으로 정렬 한다.
    this.ColumnSort = function (cIdx) {
        if (!this.UseColumnSort) return;
        var sortObj = document.getElementById(this.Items + "_sortflag_" + this.sortColumnIdx);
        if (sortObj) {
            sortObj.innerHTML = "";
        }
        if (this.sortColumnIdx != cIdx) {
            sortObj = document.getElementById(this.Items + "_sortflag_" + cIdx);
            this.sortColumnIdx = cIdx;
            this.sortOrderBy = "desc";
            sortObj.innerHTML = " ▼";
        } else {
            sortObj = document.getElementById(this.Items + "_sortflag_" + cIdx);
            if (this.sortOrderBy == "desc") {
                this.sortOrderBy = "asc";
                sortObj.innerHTML = " ▲";
            } else {
                this.sortOrderBy = "desc";
                sortObj.innerHTML = " ▼";
            }
        }

        var scKey = this.ColumnsName[cIdx];
        var dataType = this.ColumnsDatatype[cIdx];
        // 정렬형식에 따라 정렬
        if (this.sortOrderBy == "desc") {
            this.CurrData.Rows.sort(
                function (a, b) {
                    var A = dataType == 'Number' ? (isNaN(parseFloat(a[scKey].number())) ? a[scKey] : parseFloat(a[scKey].number())) : a[scKey];
                    var B = dataType == 'Number' ? (isNaN(parseFloat(b[scKey].number())) ? b[scKey] : parseFloat(b[scKey].number())) : b[scKey];
                    if (A <= B) return 1;
                    else return -1;
                }
            );
        } else if (this.sortOrderBy == "asc") {
            this.CurrData.Rows.sort(
                function (a, b) {
                    var A = dataType == 'Number' ? (isNaN(parseFloat(a[scKey].number())) ? a[scKey] : parseFloat(a[scKey].number())) : a[scKey];
                    var B = dataType == 'Number' ? (isNaN(parseFloat(b[scKey].number())) ? b[scKey] : parseFloat(b[scKey].number())) : b[scKey];
                    if (A >= B) return 1;
                    else return -1;
                }
            );
        }

        this.MakeTableRows(this.CurrData);
        this.SheetLoadEnd(); // 디자인관련처리부분추가(사용자는 CallBack()을 사용함)
        this.CallBack();
    };

    // 바인딩된 Row의 데이터를 가져온다.
    this.GetRow = function (RNum, CNum) {
        if (CNum == undefined) return this.CurrData.Rows[RNum];
        else {
            if (isNaN(CNum)) return this.CurrData.Rows[RNum][CNum];
            else return this.CurrData.Rows[RNum][this.ColumnsName[CNum]];
        }
    };
    // Cell에 데이터를 설정한다.
    this.SetValue = function (RNum, CNum, strValue) {
        if (isNaN(CNum)) this.CurrData.Rows[RNum][CNum] = strValue;
        else this.CurrData.Rows[RNum][this.ColumnsName[CNum]] = strValue;
        this.ChangeViewValue(RNum, CNum, strValue);
    };
    // Cell에 데이터를 설정한다.
    this.SetValueCal = function (RNum, CNum, strValue) {
        if (isNaN(CNum)) this.CurrData.Rows[RNum][CNum] = strValue.replace(/-/ig, '');
        else this.CurrData.Rows[RNum][this.ColumnsName[CNum]] = strValue.replace(/-/ig, '');
        this.ChangeViewValueCal(RNum, CNum, strValue.replace(/-/ig, ''));
    };
    // Cell에 데이터를 원래 데이터로 변경한다.
    this.RollValue = function (RNum, CNum) {
        var CObj = this.GetCell(RNum, CNum);
        if (CObj.getAttribute("OrgData") == undefined) CObj.innerHTML = "";
        else CObj.innerHTML = CObj.getAttribute("OrgData");
    };
    // Cell에 바인딩된 원본데이터를 변경한다.
    this.ChangeViewValue = function (RNum, CNum, strValue) {
        //처음 this.DataBind() 를 사용하다가 속도문제로 새로 만듬 ㅠㅠ
        var tmpCNum = 0;
        if (isNaN(CNum)) {
            for (var i = 0; i < this.ColumnsName.length; i++) {
                if (this.ColumnsName[i] == CNum) {
                    tmpCNum = i;
                    break;
                }
            }
        } else tmpCNum = CNum;
        if (this.ColumnsHidden[tmpCNum] == "true") return false;

        var CObj = this.GetCell(RNum, tmpCNum);
        var retVal = "";
        if (CObj.firstChild != null && CObj.firstChild.type == "text") retVal = CObj.firstChild.value;
        else retVal = CObj.innerHTML;
        CObj.setAttribute("OrgData", retVal);
        if (this.ColumnsType[CNum] == "Combo") {
            var cDataText = "";
            $("#" + eval(this.TargetID[CNum]).items).find("option").each(function () {
                if ($(this).attr("value") == strValue) {
                    cDataText = $(this).html();
                }
            });
            $(CObj).html(cDataText);
        }
        else {
            $(CObj).html(strValue);
        }

        if (CObj.childNodes.length > 0 && CObj.childNodes[0].nodeName == "#text") CObj.innerHTML = "<div style='overflow:hidden;text-overflow:ellipsis;white-space:nowrap;'>" + CObj.innerHTML + "</div>";
    };
    // Cell에 바인딩된 원본데이터를 변경한다.(달력 예외처리)
    this.ChangeViewValueCal = function (RNum, CNum, strValue) {
        //처음 this.DataBind() 를 사용하다가 속도문제로 새로 만듬 ㅠㅠ
        var tmpCNum = 0;
        if (isNaN(CNum)) {
            for (var i = 0; i < this.ColumnsName.length; i++) {
                if (this.ColumnsName[i] == CNum) {
                    tmpCNum = i;
                    break;
                }
            }
        } else tmpCNum = CNum;
        if (this.ColumnsHidden[tmpCNum] == "true") return false;

        var CObj = this.GetCell(RNum, tmpCNum);
        var retVal = "";
        if (CObj.firstChild != null && CObj.firstChild.type == "text") retVal = CObj.firstChild.value;
        else retVal = CObj.innerHTML;
        CObj.setAttribute("OrgData", retVal.replace(/-/ig, ''));
        // 보여지는값
        var val = strValue;
        if (val.length > 6) {
            val = val.toString().replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
        }
        else if (val.length > 4) {
            val = val.toString().replace(/(\d{4})(\d{2})/g, '$1-$2');
        }

        $(CObj).html(val);

        if (CObj.childNodes.length > 0 && CObj.childNodes[0].nodeName == "#text")
            CObj.innerHTML = "<div style='overflow:hidden;text-overflow:ellipsis;white-space:nowrap;'>" + CObj.innerHTML + "</div>";
    };
    // Cell의 데이터를 가져온다.
    this.GetCell = function (RNum, CNum) {
        var rNum = RNum;
        var cNum = CNum;
        var TObj = null;

        if (this.ChkMerge) {
            return document.getElementById(this.Items + "_" + RNum + "_" + CNum);
        } else {
            if (this.UseFix == "true" && this.ColumnsFix[CNum] == "false") {
                TObj = document.getElementById(this.Items + "_Bodybody");
                for (var i = 0; i < this.ColumnsFix.length; i++) {
                    if (this.ColumnsFix[i] == "false") {
                        cNum -= i;
                        break;
                    }
                }
            } else {
                TObj = document.getElementById(this.Items + "_Mainbody");
                //cNum++;
                if (this.UseCheckBox == "true") {
                    if ($(TObj.rows[rNum]).find("input[name=" + this.Items + "_chk]").length > 0) cNum++;
                }
            }
            return TObj.rows[rNum].cells[cNum];
        }
    };
    // Cell의 데이터를 Column명으로 가져온다.
    this.GetCellColumnName = function (RNum, CName) {
        var rNum = RNum;
        var cNum = -1;
        var TObj = null;

        for (var i = 0; i < this.ColumnsName.length; i++) {
            if (this.ColumnsName[i] == CName) {
                cNum = i;
                break;
            }
        }

        if (this.ChkMerge) {
            return document.getElementById(this.Items + "_" + RNum + "_" + cNum);
        } else {
            if (this.UseFix == "true" && this.ColumnsFix[cNum] == "false") {
                TObj = document.getElementById(this.Items + "_Bodybody");
                for (var i = 0; i < this.ColumnsFix.length; i++) {
                    if (this.ColumnsFix[i] == "false") {
                        cNum -= i;
                        break;
                    }
                }
            } else {
                TObj = document.getElementById(this.Items + "_Mainbody");
                if (this.UseCheckBox == "true") cNum++;
            }
            return TObj.rows[rNum].cells[cNum];
        }
    };
    // sheet에 체크된 데이터를 가져온다.
    this.GetCheckRow = function (idxType) {
        if (this.UseCheckBox == "true") {
            var chkObjs = document.getElementsByName(this.Items + "_chk");
            var retArr = new Array();
            for (var i = 0; i < chkObjs.length; i++) {
                if (chkObjs[i].checked) {
                    //CheckBox 병합에 따른 처리
                    var RowCnt = 1;
                    if (this.CheckBoxAutoMerge > 0) RowCnt = this.CheckBoxAutoMerge;
                    //if (this.CheckBoxAutoMerge != "") {
                    //    if (parseInt(chkObjs[i].value, 10) + RowCnt < this.CurrData.length) {
                    //        while (this.CurrData[chkObjs[i].value][this.CheckBoxAutoMerge] == this.CurrData[parseInt(chkObjs[i].value, 10) + RowCnt][this.CheckBoxAutoMerge]) {
                    //            RowCnt++;
                    //            if (parseInt(chkObjs[i].value, 10) + RowCnt >= this.CurrData.length) break;
                    //        }
                    //    }
                    //}
                    for (var k = 0; k < RowCnt; k++) {
                        if (idxType == "num") {
                            var tmpArr = new Array();
                            for (var j = 0; j < this.ColumnsName.length; j++) {
                                tmpArr[j] = this.CurrData[parseInt(chkObjs[i].value, 10) + k][this.ColumnsName[j]];
                            }
                            retArr.push(tmpArr);
                        }
                        else retArr.push(this.GetRow(parseInt(chkObjs[i].value, 10) + k));
                    }
                }
            }
            return retArr;
        } else {
            if (idxType == "num") {
                var tmpArr = new Array();
                for (var i = 0; i < this.CurrData.length; i++) {
                    for (var j = 0; j < this.ColumnsName.length; j++) {
                        tmpArr[i] = new Array();
                        tmpArr[i][j] = this.CurrData[i][this.ColumnsName[j]];
                    }
                }
            } else tmpArr = this.CurrData;
            return tmpArr;
        }
    };
    // sheet에 체크되지 않은 데이터를 가져온다.
    this.GetNotCheckRow = function (idxType) {

        var chkObjs = document.getElementsByName(this.Items + "_chk");
        var retArr = new Array();
        for (var i = 0; i < chkObjs.length; i++) {
            if (!chkObjs[i].checked) {
                var RowCnt = 1;
                if (this.CheckBoxAutoMerge > 0) RowCnt = this.CheckBoxAutoMerge;

                for (var k = 0; k < RowCnt; k++) {
                    if (idxType == "num") {
                        var tmpArr = new Array();
                        for (var j = 0; j < this.ColumnsName.length; j++) {
                            tmpArr[j] = this.CurrData[parseInt(chkObjs[i].value, 10) + k][this.ColumnsName[j]];
                        }
                        retArr.push(tmpArr);
                    }
                    else retArr.push(this.GetRow(parseInt(chkObjs[i].value, 10) + k));
                }

                //f (idxType == "num") {
                //   var tmpArr = new Array();
                //   for (var j = 0; j < this.ColumnsName.length; j++) {
                //       tmpArr[j] = this.CurrData[chkObjs[i].value][this.ColumnsName[j]];
                //   }
                //   retArr.push(tmpArr);
                // else retArr.push(this.GetRow(chkObjs[i].value));
            }
        }
        return retArr;

    };
    // sheet에 체크된 Row의 번호를 가져온다.
    this.GetCheckRowNumber = function (idxType) {
        if (this.UseCheckBox == "true") {
            var chkObjs = document.getElementsByName(this.Items + "_chk");
            var retArr = new Array();
            for (var i = 0; i < chkObjs.length; i++) {
                if (chkObjs[i].checked) {
                    retArr.push(i);
                }
            }
            return retArr;
        }
    };
    // sheet에 바인딩된 모든데이터를 가져온다.
    this.GetAllRow = function (idxType) {
        if (idxType == "num") {
            var tmpArr = new Array();
            for (var i = 0; i < this.CurrData.length; i++) {
                for (var j = 0; j < this.ColumnsName.length; j++) {
                    tmpArr[i] = new Array();
                    tmpArr[i][j] = this.CurrData[i][this.ColumnsName[j]];
                }
            }
        } else tmpArr = this.CurrData;
        return tmpArr;
    };
    // sheet에 바인딩된 모든데이터를 cs로 전송하기위하여 히든필드에 에디터를 적제한다.
    this.SetAllRow = function () {
        document.getElementById(this.Items + "_CValue").value = JSON.stringify(this.GetAllRow());
    };
    // 페이지를 해당 번호로 변경한다.
    this.MovePage = function (PNum) {
        this.BindList(PNum);
    };
    this.ChkValue = function () {
        return true;
    };
    this.chkItem_Click = function (chkIdx) {
        if (this.UseCheckBox == "true") {
            var chkObjs = document.getElementsByName(this.Items + "_chk");
            var chkObj = chkObjs[chkIdx];
            if (chkObj) {
                if (chkObj.checked) {
                    //$(chkObj.parentNode.parentNode).addClass("select");
                } else {
                    //$(chkObj.parentNode.parentNode).removeClass("select");
                }
            }

        }
        this.SetAllRow();
    };
    this.rowItem_Click = function (obj) {
        var rowIdx = obj.id.split('_')[1];
        var rowObj = document.getElementById(this.Items + "_MainRow_" + rowIdx);
        if (rowObj) {
            if (this.SelectedRow == rowIdx) {
            } else {

                $(rowObj).parent().find("tr").each(function () {
                    $(this).css("background", $(this).attr("OrgBgColor"));
                });
                $(rowObj).css("background", this.SelectColor);
                if (this.SelectedRow !== null) {
                    rowObj = document.getElementById(this.Items + "_MainRow_" + this.SelectedRow);
                }
                this.SelectedRow = rowIdx;    //선택설정

                rowObj2 = document.getElementById(this.Items + "_BodyRow_" + rowIdx);
                if (rowObj2) {
                    $(rowObj2).parent().find("tr").each(function () {
                        $(this).css("background", $(this).attr("OrgBgColor"));
                    });
                    $(rowObj2).css("background", this.SelectColor);
                }
            }
        }
    };
    // Row가 모두 삭제되었을시 한Row를 백업하여 데이터 형태를 유지함
    this.CurrDataBackup;
    // Row 추가
    this.InsertRow = function () {

        var SheetObj_Main = document.getElementById(this.Items + "_Mainbody"); // TBODY(틀고정시 고정영역)
        var SheetObj_Body = document.getElementById(this.Items + "_Bodybody"); // TBODY(틀고정시 비고정영역)
        var tmpID = "";
        var CellText = "";
        var CMergeCount = 0;
        var MergeCount = new Array();
        var MergeListCount = -1;

        var CName = "";

        // Binding을 안한 경우에도 CurrData를 초기화하여 입력가능 하도록 변경
        if (this.CurrData == null || this.CurrData.Rows == null) this.CurrData = { Rows: [] };

        // 데이터를 강제로 추가한다.
        var data_cnt = ObjectCount(this.CurrData.Rows); // 그리드에 바인딩된 row 갯수
        if (this.CurrData.Rows[data_cnt - 1] == undefined) { // 데이터가 없을시 백업을 체크하여 입력
            if (this.CurrDataBackup == undefined || this.CurrDataBackup.Rows[0] == undefined) {
                this.CurrData = { Rows: [] };
                this.CurrData.Rows[0] = new Object();
                for (i = 0; i < this.ColumnsName.length; i++) {
                    this.CurrData.Rows[0][this.ColumnsName[i]] = "";
                }
            }
            else {
                this.CurrData.Rows[data_cnt] = JSON.parse(JSON.stringify(this.CurrDataBackup.Rows[0])); // 신규 생성된 Row의 데이터를 추가한다.
            }
        }
        else {
            this.CurrData.Rows[data_cnt] = JSON.parse(JSON.stringify(this.CurrData.Rows[data_cnt - 1])); // 신규 생성된 Row의 데이터를 추가한다.
        }

        var columnName = Object.keys(this.CurrData.Rows[data_cnt]); // 컬렴명

        // 신규 생성된 Row의 데이터 초기화
        for (j = 0; j < columnName.length; j++) {
            this.CurrData.Rows[data_cnt][columnName[j]] = "";
        }

        // Row 추가
        var RowObj_Main = document.createElement("tr"); // 고정영역 ROW 생성
        var RowObj_Body = document.createElement("tr"); // 비고정영역 ROW 생성
        var FChk = false;

        // 행배경색 지정
        if (data_cnt % 2 == 0) BgColor = this.BgColor01;
        else BgColor = this.BgColor02;

        RowObj_Main.setAttribute("OrgBgColor", BgColor);
        RowObj_Body.setAttribute("OrgBgColor", BgColor);
        RowObj_Main.style.background = BgColor;
        RowObj_Body.style.background = BgColor;
        // 스타일
        RowObj_Main.className = "JINSheet_Row";
        RowObj_Body.className = "JINSheet_Row";
        // Row의 번호
        RowObj_Main.id = this.Items + "_MainRow_" + data_cnt;
        RowObj_Body.id = this.Items + "_BodyRow_" + data_cnt;
        if (this.OverEvent == true) {
            RowObj_Main.onmouseover = function () { SheetMouseEvent(this, true); };
            RowObj_Main.onmouseout = function () { SheetMouseEvent(this, false); };

            RowObj_Body.onmouseover = function () { SheetMouseEvent(this, true); };
            RowObj_Body.onmouseout = function () { SheetMouseEvent(this, false); };
        }
        if (this.UseCheckBox == "true" && CMergeCount == 0) {
            if (this.CheckBoxAutoMerge > 0) {
                CMergeCount = this.CheckBoxAutoMerge;
                //CMergeCount = 1;
                //for (var ii = data_cnt + 1; ii < ObjectCount(this.CurrData.Rows); ii++) {
                //    if (this.CurrData.Rows[data_cnt][this.CheckBoxAutoMerge] == this.CurrData.Rows[ii][this.CheckBoxAutoMerge]) CMergeCount++;
                //    else break;
                //}
            }
            RowObj_Main.appendChild(this.MakeChkTdCell(data_cnt, CMergeCount, this.CurrData.length));
            FChk = true;
        }
        if (CMergeCount > 0) CMergeCount--;
        for (var tmpii = 0; tmpii < MergeCount.length; tmpii++) {
            if (MergeCount[tmpii] > 0) MergeCount[tmpii]--;
        }

        for (var j = 0; j < this.ColumnsName.length; j++) {
            if (data_cnt == 0) MergeCount.push(0);
            if (this.ColumnsHidden[j] == "false") {
                var CellMakeChk = true;
                if (MergeCount[j] > 0) CellMakeChk = false;
                CellText = this.CurrData.Rows[data_cnt][this.ColumnsName[j]];
                if (FChk) {
                    CName = "JINSheet_Cell";
                }
                else {
                    FChk = true;
                    CName = "JINSheet_FCell"
                }

                if (this.ColumnsAutoMerge[j] && MergeCount[j] == 0) {
                    MergeCount[j] = 1;
                    for (var ii = data_cnt + 1; ii < ObjectCount(this.CurrData.Rows); ii++) {
                        if (this.CurrData.Rows[data_cnt][this.ColumnsName[j]] == this.CurrData.Rows[ii][this.ColumnsName[j]]) MergeCount[j]++;
                        else break;
                    }
                    for (var tmpMi = j - 1; tmpMi > -1; tmpMi--) {
                        if (this.ColumnsAutoMerge[tmpMi]) {
                            if (MergeCount[tmpMi] < MergeCount[j]) MergeCount[j] = MergeCount[tmpMi];
                            break;
                        }
                    }
                    this.ChkMerge = true;
                }
                if (CellMakeChk) {
                    if (this.UseFix == "true" && this.ColumnsFix[j] == "false") {
                        if (FChk) RowObj_Body.appendChild(this.MakeTextTdCell(CellText, this.ColumnsAlign[j], this.ColumnsEditable[j], this.ColumnsLink[j], data_cnt, j, this.Items, CName, MergeCount[j]));
                        else {
                            RowObj_Body.appendChild(this.MakeTextTdCell(CellText, this.ColumnsAlign[j], this.ColumnsEditable[j], this.ColumnsLink[j], data_cnt, j, this.Items, CName, MergeCount[j]));
                        }
                    } else {
                        RowObj_Main.appendChild(this.MakeTextTdCell(CellText, this.ColumnsAlign[j], this.ColumnsEditable[j], this.ColumnsLink[j], data_cnt, j, this.Items, CName, MergeCount[j]));
                    }
                }
            }
        }

        // 가로,세로 틀고정 시 마지막 TD 오른쪽 스크롤바 만큼 Padding 값 추가
        if (this.UseFix == "true" && this.UseHFix == "true") {
            RowObj_Body.cells[RowObj_Body.cells.length - 1].style.paddingRight = "22px";
        }

        SheetObj_Main.appendChild(RowObj_Main);
        SheetObj_Body.appendChild(RowObj_Body);

        // 행배경색 지정
        var color_num = 0;
        $(SheetObj_Main).find("tr").each(function () {
            if (color_num % 2 == 0) BgColor = this.BgColor01;
            else BgColor = this.BgColor02;

            $(this).css("background", BgColor);
            $(this).attr("OrgBgColor", BgColor);

            color_num++;
        });
        color_num = 0;
        $(SheetObj_Body).find("tr").each(function () {
            if (color_num % 2 == 0) BgColor = this.BgColor01;
            else BgColor = this.BgColor02;

            $(this).css("background", BgColor);
            $(this).attr("OrgBgColor", BgColor);

            color_num++;
        });

        // id 재설정
        this.RowsTagReset();
    };
    // Row 추가 (특정 Row 앞에 추가함)
    this.InsertAtRow = function (data_cnt) {
        var SheetObj_Main = document.getElementById(this.Items + "_Mainbody"); // TBODY(틀고정시 고정영역)
        var SheetObj_Body = document.getElementById(this.Items + "_Bodybody"); // TBODY(틀고정시 비고정영역)
        var tmpID = "";
        var CellText = "";
        var CMergeCount = 0;
        var MergeCount = new Array();
        var MergeListCount = -1;

        var CName = "";

        var IsBackup = false;

        // Binding을 안한 경우에도 CurrData를 초기화하여 입력가능 하도록 변경
        if (this.CurrData == null || this.CurrData.Rows == null) {
            this.InsertRow();
            return;
        }

        if (this.CurrData.Rows[data_cnt] == undefined) { // 데이터가 없을시 백업을 체크하여 입력
            if (data_cnt == 0) {
                if (this.CurrDataBackup == undefined || this.CurrDataBackup.Rows[0] == undefined) {
                    this.CurrData = { Rows: [] };
                    this.CurrData.Rows[0] = new Object();
                    for (i = 0; i < this.ColumnsName.length; i++) {
                        this.CurrData.Rows[0][this.ColumnsName[i]] = "";
                    }
                }
                else {
                    this.CurrData.Rows[data_cnt] = JSON.parse(JSON.stringify(this.CurrDataBackup.Rows[0])); // 신규 생성된 Row의 데이터를 추가한다.
                    IsBackup = true;
                }
            }
            else {
                alert("추가할 행이 없습니다.");
                return;
            }
        }

        if (!IsBackup) {
            // 끼워넣을 데이터를 보정한다 (row번호를 뒤로 1씩 미룬다)
            for (i = ObjectMaxValue(this.CurrData.Rows); i > data_cnt - 1; i--) {
                this.CurrData.Rows[i + 1] = JSON.parse(JSON.stringify(this.CurrData.Rows[i])); // 신규 생성된 Row의 데이터를 추가한다.
            }
        }

        var columnName = Object.keys(this.CurrData.Rows[data_cnt]); // 컬렴명

        // 신규 생성된 Row의 데이터 초기화
        for (j = 0; j < columnName.length; j++) {
            this.CurrData.Rows[data_cnt][columnName[j]] = "";
        }

        // Row 추가
        var RowObj_Main = document.createElement("tr"); // 고정영역 ROW 생성
        var RowObj_Body = document.createElement("tr"); // 비고정영역 ROW 생성
        var FChk = false;

        // 행배경색 지정
        if (data_cnt % 2 == 0) BgColor = this.BgColor01;
        else BgColor = this.BgColor02;

        RowObj_Main.setAttribute("OrgBgColor", BgColor);
        RowObj_Body.setAttribute("OrgBgColor", BgColor);
        RowObj_Main.style.background = BgColor;
        RowObj_Body.style.background = BgColor;
        // 스타일
        RowObj_Main.className = "JINSheet_Row";
        RowObj_Body.className = "JINSheet_Row";
        // Row의 번호
        RowObj_Main.id = this.Items + "_MainRow_" + data_cnt;
        RowObj_Body.id = this.Items + "_BodyRow_" + data_cnt;
        if (this.OverEvent == true) {
            RowObj_Main.onmouseover = function () { SheetMouseEvent(this, true); };
            RowObj_Main.onmouseout = function () { SheetMouseEvent(this, false); };

            RowObj_Body.onmouseover = function () { SheetMouseEvent(this, true); };
            RowObj_Body.onmouseout = function () { SheetMouseEvent(this, false); };
        }
        if (this.UseCheckBox == "true" && CMergeCount == 0) {
            if (this.CheckBoxAutoMerge > 0) {
                CMergeCount = this.CheckBoxAutoMerge;
                //CMergeCount = 1;
                //for (var ii = data_cnt + 1; ii < ObjectCount(this.CurrData.Rows); ii++) {
                //    if (this.CurrData.Rows[data_cnt][this.CheckBoxAutoMerge] == this.CurrData.Rows[ii][this.CheckBoxAutoMerge]) CMergeCount++;
                //    else break;
                //}
            }
            RowObj_Main.appendChild(this.MakeChkTdCell(data_cnt, CMergeCount, this.CurrData.length));
            FChk = true;
        }
        if (CMergeCount > 0) CMergeCount--;
        for (var tmpii = 0; tmpii < MergeCount.length; tmpii++) {
            if (MergeCount[tmpii] > 0) MergeCount[tmpii]--;
        }

        for (var j = 0; j < this.ColumnsName.length; j++) {
            if (data_cnt == 0) MergeCount.push(0);
            if (this.ColumnsHidden[j] == "false") {
                var CellMakeChk = true;
                if (MergeCount[j] > 0) CellMakeChk = false;
                CellText = this.CurrData.Rows[data_cnt][this.ColumnsName[j]];
                if (FChk) {
                    CName = "JINSheet_Cell";
                }
                else {
                    FChk = true;
                    CName = "JINSheet_FCell"
                }

                if (this.ColumnsAutoMerge[j] && MergeCount[j] == 0) {
                    MergeCount[j] = 1;
                    for (var ii = data_cnt + 1; ii < ObjectCount(this.CurrData.Rows); ii++) {
                        if (this.CurrData.Rows[data_cnt][this.ColumnsName[j]] == this.CurrData.Rows[ii][this.ColumnsName[j]]) MergeCount[j]++;
                        else break;
                    }
                    for (var tmpMi = j - 1; tmpMi > -1; tmpMi--) {
                        if (this.ColumnsAutoMerge[tmpMi]) {
                            if (MergeCount[tmpMi] < MergeCount[j]) MergeCount[j] = MergeCount[tmpMi];
                            break;
                        }
                    }
                    this.ChkMerge = true;
                }
                if (CellMakeChk) {
                    if (this.UseFix == "true" && this.ColumnsFix[j] == "false") {
                        if (FChk) RowObj_Body.appendChild(this.MakeTextTdCell(CellText, this.ColumnsAlign[j], this.ColumnsEditable[j], this.ColumnsLink[j], data_cnt, j, this.Items, CName, MergeCount[j]));
                        else {
                            RowObj_Body.appendChild(this.MakeTextTdCell(CellText, this.ColumnsAlign[j], this.ColumnsEditable[j], this.ColumnsLink[j], data_cnt, j, this.Items, CName, MergeCount[j]));
                        }
                    } else {
                        RowObj_Main.appendChild(this.MakeTextTdCell(CellText, this.ColumnsAlign[j], this.ColumnsEditable[j], this.ColumnsLink[j], data_cnt, j, this.Items, CName, MergeCount[j]));
                    }
                }
            }
        }

        // 가로,세로 틀고정 시 마지막 TD 오른쪽 스크롤바 만큼 Padding 값 추가
        if (this.UseFix == "true" && this.UseHFix == "true") {
            RowObj_Body.cells[RowObj_Body.cells.length - 1].style.paddingRight = "22px";
        }

        if ($(SheetObj_Main).find("tr").eq(data_cnt).length > 0) {
            $(SheetObj_Main).find("tr").eq(data_cnt).before(RowObj_Main);
            $(SheetObj_Body).find("tr").eq(data_cnt).before(RowObj_Body);
        }
        else {
            $(SheetObj_Main).append(RowObj_Main);
            $(SheetObj_Body).append(RowObj_Body);
        }

        // 배경색 변경
        // 행배경색 지정
        var color_num = 0;
        $(SheetObj_Main).find("tr").each(function () {
            if (color_num % 2 == 0) BgColor = this.BgColor01;
            else BgColor = this.BgColor02;

            $(this).css("background", BgColor);
            $(this).attr("OrgBgColor", BgColor);

            color_num++;
        });
        color_num = 0;
        $(SheetObj_Body).find("tr").each(function () {
            if (color_num % 2 == 0) BgColor = this.BgColor01;
            else BgColor = this.BgColor02;

            $(this).css("background", BgColor);
            $(this).attr("OrgBgColor", BgColor);

            color_num++;
        });
        // id 재설정
        this.RowsTagReset();
    };
    // Row 삭제 
    this.RemoveRows = function (rownums) {

        // 데이터를 역순으로 정렬
        rownums.sort(function (a, b) { return b - a });

        var SheetObj_Main = document.getElementById(this.Items + "_Mainbody"); // TBODY(틀고정시 고정영역)
        var SheetObj_Body = document.getElementById(this.Items + "_Bodybody"); // TBODY(틀고정시 비고정영역)

        // 데이터 삭제
        for (i = 0; i < rownums.length; i++) {
            // 삭제할 데이터 확인
            if (this.CurrData.Rows[rownums[i]*1] == undefined) {
                continue;
            }
            // 마지막 데이터는 백업
            if (ObjectCount(this.CurrData.Rows) == 1) {
                this.CurrDataBackup = JSON.parse(JSON.stringify(this.CurrData));
            }
            // 데이터 삭제
            delete this.CurrData.Rows[rownums[i] * 1];
            // Row 삭제
            SheetObj_Main.deleteRow(rownums[i] * 1);
            if (SheetObj_Body.rows.length > i) {
                SheetObj_Body.deleteRow(rownums[i] * 1);
            }
            // 데이터 보정
            var objCnt = ObjectMaxValue(this.CurrData.Rows);
            for (j = rownums[i] * 1; j < objCnt; j++) {
                this.CurrData.Rows[j] = JSON.parse(JSON.stringify(this.CurrData.Rows[j + 1]));
            }

            // 마지막 데이터 삭제
            if (this.CurrData.Rows[rownums[i] * 1] != undefined) { // 마지막 데이터가 삭제한 데이터일시 예외처리함
                // tag 삭제
                delete this.CurrData.Rows[objCnt];
            }
        }

        // 행배경색 지정
        var color_num = 0;
        $(SheetObj_Main).find("tr").each(function () {
            if (color_num % 2 == 0) BgColor = this.BgColor01;
            else BgColor = this.BgColor02;

            $(this).css("background", BgColor);
            $(this).attr("OrgBgColor", BgColor);

            color_num++;
        });
        color_num = 0;
        $(SheetObj_Body).find("tr").each(function () {
            if (color_num % 2 == 0) BgColor = this.BgColor01;
            else BgColor = this.BgColor02;

            $(this).css("background", BgColor);
            $(this).attr("OrgBgColor", BgColor);

            color_num++;
        });
        // id 재설정
        this.RowsTagReset();

       

    };
    // 전체 Row 삭제
    this.RemoveAllRow = function () {
        var SheetObj_Main = document.getElementById(this.Items + "_Mainbody"); // TBODY(틀고정시 고정영역)
        var SheetObj_Body = document.getElementById(this.Items + "_Bodybody"); // TBODY(틀고정시 비고정영역)
        // 기존 데이터 백업
        this.CurrDataBackup = JSON.parse(JSON.stringify(this.CurrData));
        // 현SHEET에 Row 가 존재한다면 제거
        for (var i = SheetObj_Main.rows.length - 1; i > -1; i--) {
            delete this.CurrData.Rows[i];
            SheetObj_Main.deleteRow(i);
            if (SheetObj_Body.rows.length > i) SheetObj_Body.deleteRow(i);
        }
        // id 재설정
        this.RowsTagReset();
    };
    this.RowsTagReset = function () {
        var SheetObj_Main = document.getElementById(this.Items + "_Mainbody"); // TBODY(틀고정시 고정영역)
        var SheetObj_Body = document.getElementById(this.Items + "_Bodybody"); // TBODY(틀고정시 비고정영역)
        var id = this.Items;
        // tr 갯수만큼 반복
        var cnt = 0;
        var c_cnt = 0;
        $(SheetObj_Main).find("tr").each(function () {
            $(this).attr("id", id + "_MainRow_" + cnt);
            var c = 0;
            c_cnt = $(this).find("td").length;
            $(this).find("td").each(function () {
                if ($(this).attr("class") != "JINSheet_ChkCell") {
                    $(this).attr("id", id + "_" + cnt + "_" + c);

                    if ($(this).find("input[type='button']").length > 0) {
                        $(this).find("input[type='button']").eq(0).attr("id", id + "_" + cnt + "_" + c + "_btn");
                    }

                    c++;
                }
                else {
                    $(this).find("input").attr("value", cnt);
                }
            });

            cnt++;
        });
        cnt = 0;
        $(SheetObj_Body).find("tr").each(function () {
            $(this).attr("id", id + "_BodyRow_" + cnt);
            var c = c_cnt;
            $(this).find("td").each(function () {
                if ($(this).attr("class") != "JINSheet_ChkCell") {
                    $(this).attr("id", id + "_" + cnt + "_" + c);

                    if ($(this).find("input[type='button']").length > 0) {
                        $(this).find("input[type='button']").eq(0).attr("id", id + "_" + cnt + "_" + c + "_btn");
                    }

                    c++;
                }
                else {
                    $(this).find("input").attr("value", cnt);
                }
            });

            cnt++;
        });
    };
    // 프로그래스바 활성
    this.ProgressShow = function () {
        // 레이어가 위치할 좌표를 정의
        var width = $("#" + this.Items + "_layer").width();
        var height = $("#" + this.Items + "_layer").height();
        var table_height = $("#" + this.Items + "_layer").find("table").height();
        // 레이어의 크기를 조절한다.
        $("#" + this.Items + "_progress").css("width", width + "px");
        $("#" + this.Items + "_progress").css("height", height + "px");
        // 레이어의 좌표를 조절한다.
        $("#" + this.Items + "_progress").css("margin-top", "-" + table_height + "px");
        // 프로그래스의 좌표를 지정한다.
        $("#" + this.Items + "_progress").find("div").css("top", (height / 2 - 16 + 28) + "px");
        $("#" + this.Items + "_progress").find("div").css("left", (width / 2 - 16) + "px");
        $("#" + this.Items + "_progress").show();
    };
    // 프로그래스바 비활성
    this.ProgressHide = function () {
        $("#" + this.Items + "_progress").hide();
    };
    // 높이가 고정된 하나의 그리드 사용 시
    // 브라우저 크기에 따라 그리드 높이 자동으로 재조정
    this.AutoHeight = function (marginHeight) {
        if (this.UseHFix == "true") {
            var gridObjectID = this.Items;
            var gridObject = this;
            this.AutoHeightMargin = marginHeight;
            $("#content").css("padding-bottom", "0px");
            $("#container").css("height", "auto");

            $("#" + gridObjectID + "_main").children().eq(1).css("height", $(window).height() - gridObject.AutoHeightMargin);
            $("#" + gridObjectID + "_body").children().eq(1).css("height", $(window).height() - gridObject.AutoHeightMargin);
            $(window).bind("resize", function () {
                $("#content").css("padding-bottom", "0px");
                $("#container").css("height", "auto");
                $("#" + gridObjectID + "_main").children().eq(1).css("height", $(window).height() - gridObject.AutoHeightMargin);
                $("#" + gridObjectID + "_body").children().eq(1).css("height", $(window).height() - gridObject.AutoHeightMargin);
            });
        }
    };

    this.ChangeAutoHeightMargin = function (marginHeight) {
        if (this.UseHFix == "true") {
            var gridObjectID = this.Items;
            var gridObject = this;
            this.AutoHeightMargin = marginHeight;
            $("#content").css("padding-bottom", "0px");
            $("#container").css("height", "auto");

            $("#" + gridObjectID + "_main").children().eq(1).css("height", $(window).height() - gridObject.AutoHeightMargin);
            $("#" + gridObjectID + "_body").children().eq(1).css("height", $(window).height() - gridObject.AutoHeightMargin);
        }
    };

    this.HideMultiHeader = function (RNum, CNum) {
        if (this.UseFix == "true") {
            $("div[id=" + this.Items + "_body] table[id=" + this.Items + "] tr:eq(" + RNum + ") th:eq(" + CNum + ")").hide();
        } else {
            $("div[id=" + this.Items + "_main] table[id=" + this.Items + "] tr:eq(" + RNum + ") th:eq(" + CNum + ")").hide();
        }
    }

    this.ShowMultiHeader = function (RNum, CNum) {
        if (this.UseFix == "true") {
            $("div[id=" + this.Items + "_body] table[id=" + this.Items + "] tr:eq(" + RNum + ") th:eq(" + CNum + ")").show();
        } else {
            $("div[id=" + this.Items + "_main] table[id=" + this.Items + "] tr:eq(" + RNum + ") th:eq(" + CNum + ")").show();
        }
    }

    // 특정 컬럼 숨기기
    this.HideColumn = function (CNum) {
        if (this.UseFix == "true") {
            $("div[id=" + this.Items + "_body] table[id=" + this.Items + "] tr:last-child() th:eq(" + CNum + ")").hide();

            $("div[id=" + this.Items + "_body] table[class=JINSheet_NormalTable] td:nth-child(" + (CNum + 1) + ")").hide();
            $("div[id=" + this.Items + "_body] table[class=JINSheet_NormalTable] colgroup col:nth-child(" + (CNum + 1) + ")").hide();

            var totalTdWidth = 0;

            $("#" + this.Items + "_body table tr:last-child() th:visible").each(function () {
                totalTdWidth += parseInt(this.style.width) + parseInt($(this).css("padding-left")) + parseInt($(this).css("padding-right"));
            });

            $("#" + this.Items + "_body table").css("width", totalTdWidth);
        } else {
            $("div[id=" + this.Items + "_main] table[id=" + this.Items + "] tr:last-child() th:eq(" + CNum + ")").hide();

            $("div[id=" + this.Items + "_main] table[class=JINSheet_NormalTable] td:nth-child(" + (CNum + 1) + ")").hide();
            $("div[id=" + this.Items + "_main] table[class=JINSheet_NormalTable] colgroup col:nth-child(" + (CNum + 1) + ")").hide();
        }
    };

    // 특정 컬럼 보이기(HideColumn으로 숨긴 컬럼만 동작)
    this.ShowColumn = function (CNum) {
        if (this.UseFix == "true") {
            $("div[id=" + this.Items + "_body] table[id=" + this.Items + "] tr:last-child() th:eq(" + CNum + ")").show();

            $("div[id=" + this.Items + "_body] table[class=JINSheet_NormalTable] td:nth-child(" + (CNum + 1) + ")").show();
            $("div[id=" + this.Items + "_body] table[class=JINSheet_NormalTable] colgroup col:nth-child(" + (CNum + 1) + ")").show();

            var totalTdWidth = 0;

            $("#" + this.Items + "_body table tr:last-child() th:visible").each(function () {
                totalTdWidth += parseInt(this.style.width) + parseInt($(this).css("padding-left")) + parseInt($(this).css("padding-right"));
            });

            $("#" + this.Items + "_body table").css("width", totalTdWidth);
        } else {
            $("div[id=" + this.Items + "_main] table[id=" + this.Items + "] tr:last-child() th:eq(" + CNum + ")").show();

            $("div[id=" + this.Items + "_main] table[class=JINSheet_NormalTable] td:nth-child(" + (CNum + 1) + ")").show();
            $("div[id=" + this.Items + "_main] table[class=JINSheet_NormalTable] colgroup col:nth-child(" + (CNum + 1) + ")").show();
        }
    };

    this.GetHeader = function (RNum, CNum) {
        if (this.UseFix == "true") {
            return $("div[id=" + this.Items + "_body] table[id=" + this.Items + "] tr:eq(" + RNum + ") th:eq(" + CNum + ")");
        } else {
            return $("div[id=" + this.Items + "_main] table[id=" + this.Items + "] tr:eq(" + RNum + ") th:eq(" + CNum + ")");
        }
    };

    this.ChangeHeaderText = function (CNum, Text, RNum) {
        if (RNum == null || RNum == undefined || RNum == "" || isNaN(Number(RNum))) RNum = 0;

        if (this.GetHeader(RNum, CNum).find("div").length > 0) this.GetHeader(RNum, CNum).find("div").text(Text);
        else this.GetHeader(RNum, CNum).text(Text);
    };

    this.ChangeColumnStyle = function (CNum, Prop, Value) {
        if (this.UseFix == "true") {
            $("div[id=" + this.Items + "_body] table[class=JINSheet_NormalTable] td:nth-child(" + (CNum + 1) + ")").css(Prop, Value);
        } else {
            $("div[id=" + this.Items + "_main] table[class=JINSheet_NormalTable] td:nth-child(" + (CNum + 1) + ")").css(Prop, Value);
        }
    };

    this.FixationGridWidthSize = function (obj) {
        if (obj == null) obj = this;

        if (obj.UseFix == "true") {
            if (Math.abs($("#" + obj.Items + "_main").parent().outerWidth() - $("#" + obj.Items + "_main").outerWidth() - $("#" + obj.Items + "_body").outerWidth()) > 5) {
                $(window).resize();
            }
            setTimeout(function () { obj.FixationGridWidthSize(obj); }, 1000);
        }
    };

    this.EditModeDisable = function (r, c) {
        $("#" + this.Items + "_" + r + "_" + c).css("background-image", "none");
    };
};

// sheet에서 row 마우스오버 이벤트
function SheetMouseEvent(tmpobj, ChkFlag) {
	try {
		// grid의 id
		var grid_s = tmpobj.id.split('_');
		var grid = eval(grid_s[0]);
		var num = grid_s[grid_s.length - 1];

		var sObj = tmpobj.id.indexOf("_MainRow_") > -1 ? document.getElementById(tmpobj.id.replace("_MainRow_", "_BodyRow_")) : document.getElementById(tmpobj.id.replace("_BodyRow_", "_MainRow_"));
		var sObj2 = tmpobj.id.indexOf("_MainRow_") > -1 ? document.getElementById(tmpobj.id.replace("_BodyRow_", "_MainRow_")) : document.getElementById(tmpobj.id.replace("_MainRow_", "_BodyRow_"));

		if (ChkFlag) {
		    if (grid.SelectedRow != null && grid.SelectedRow == num) {
		    }
		    else {
		        tmpobj.style.background = grid.BgOverColor;
		        if (sObj != null) sObj.style.background = grid.BgOverColor;
		        if (sObj2 != null) sObj2.style.background = grid.BgOverColor;
		    }
		}
		else {
			if (grid.SelectedRow != null && grid.SelectedRow == num) {
//			    tmpobj.style.background = grid.BgOverColor;
//			    if (sObj != null) sObj.style.background = grid.BgOverColor;
//			    if (sObj2 != null) sObj2.style.background = grid.BgOverColor; 
			}
			else {
				tmpobj.style.background = tmpobj.getAttribute("OrgBgColor");
				if (sObj != null) sObj.style.background = tmpobj.getAttribute("OrgBgColor");
				if (sObj2 != null) sObj2.style.background = tmpobj.getAttribute("OrgBgColor");
			}
		}
	} catch (e) { }

};

// sheet에서 체크박스 이벤트
function JinSheet_check_all(strID) {
	var chkObjs = document.getElementsByName(strID + "_chk");
	var ChkValue = document.getElementById(strID + "_chkall").checked;
	var SelectedRow = eval(strID).SelectedRow;
	for (var i = 0; i < chkObjs.length; i++) {
		chkObjs[i].checked = ChkValue;
	}
};

function chkLength(evt, Obj) {
	var charCode = (evt.which) ? evt.which : window.event.keyCode;
	if (Obj.value.bytes() + 1 > Obj.getAttribute("chkLength")) {
		alert(Message("00001").format(JisObjs.GetObjById(Obj.id).TextName, Obj.getAttribute("chkLength")));
		return false;
	}
	return true;
};
function chkValue(Obj) {
	if (Obj.type == "hidden") return true;
	if ((Obj.getAttribute("tmpType") == "number" || Obj.getAttribute("tmpType") == "amount") && Obj.value != "" && !Obj.value.isNumber()) {
		alert(Message("00083"));
		Obj.select();
		Obj.focus();
		return false;
	}
	var lang = Obj.getAttribute("chkLength");
	if (lang == "0" || lang == "") return true;

	if (Obj.value.bytes() > Obj.getAttribute("chkLength")) {
		alert(Message("00001").format(JisObjs.GetObjById(Obj.id).TextName, Obj.getAttribute("chkLength")));
		Obj.select();
		Obj.focus();
		return false;
	}

	// 특수문자 삽입 시 변환 후 Length Check 한다.
	if (Obj.getAttribute("tmpType") == "convert") {
		if (Obj.value.XMLConvertDecode().bytes() > Obj.getAttribute("chkLength")) {
			alert(Message("00001").format(JisObjs.GetObjById(Obj.id).TextName, Obj.getAttribute("chkLength")));
			Obj.select();
			Obj.focus();
			return false;
		}
	}

	return true;
};
// SearchView에서 닫기시 오류로 인하여 이전값을 전역에 정의한다.
var tmpRNum = -1, tmpCNum = -1;
// sheet에서 편집모드로 변경한다.
// 그리드안의 달력컨트롤에서 사용할 그리드ID를 저장
var tmpGridID = "";
var prtObj; // 이전 컨트롤의 id
var prtRnum; // 이전 컨트롤의 rownum
var prtCNum; // 이전 컨트롤의 columnnum

function SetEditMode(ObjId, RNum, CNum) {
	// 이전 편집모드를 닫는다.
//	if (!(prtObj == undefined || prtObj == null)) {
//		SetTextMode(prtObj, prtRnum, prtCNum);
//		prtObj = null;
//		prtRnum = null;
//		prtCNum = null;
//	}
	var tmpObj = eval(ObjId);
	tmpGridID = ObjId;
	var CellObj = tmpObj.GetCell(RNum, CNum);
	CellObj.onclick = null;

	tmpObj.SelectedRow = RNum;
	// Edit Mode Column 이있는경우(특정 조건으로 Edit 불가하도록 추가: 이재일)
	if (tmpObj != null && tmpObj != undefined && tmpObj.GetAllRow() != null && tmpObj.GetAllRow() != undefined) {
		if (tmpObj.GetAllRow().Rows[RNum]["JINSheetEditMode"] != null && tmpObj.GetAllRow().Rows[RNum]["JINSheetEditMode"] != undefined && tmpObj.GetAllRow().Rows[RNum]["JINSheetEditMode"] != "Y") {
			if (tmpObj.GetAllRow().Rows[RNum]["JINSheetEditCNum"] != null && tmpObj.GetAllRow().Rows[RNum]["JINSheetEditCNum"] != undefined && tmpObj.GetAllRow().Rows[RNum]["JINSheetEditCNum"].length > 0) {
				var targetCNums = tmpObj.GetAllRow().Rows[RNum]["JINSheetEditCNum"].split(',');

				for (var i = 0; i < targetCNums.length; i++) {
					if (targetCNums[i] == CNum) return false;
				}
			}
		}
	}

	if (CellObj.getAttribute("EditMode") == "2") return false;
	if (CellObj.className != "JINSheet_EditedCell") CellObj.className = "JINSheet_EditingCell";
	else CellObj.className = "JINSheet_EditingCell2";
	var EditObj = null;

	if (tmpObj.ColumnsType[CNum] == "Combo") {
	    // html 가져오기
	    EditObj = $("#" + eval(tmpObj.TargetID[CNum]).items).clone()[0];

	    $(EditObj).val(tmpObj.GetRow(RNum, CNum));

	    $(EditObj).css("height", this.CellHeight + "px");
	    $(EditObj).css("width", "100%");
	    $(EditObj).on("keydown", function (e) {
	        GetKoyboardEvt(e, ObjId, RNum, CNum);
	    });
	    $(EditObj).on("blur", function () {
	        SetTextMode(ObjId, RNum, CNum);
	    });
	}
	else if (tmpObj.ColumnsType[CNum] == "CheckBox") {
	    // html 가져오기
	    EditObj = $("#" + eval(tmpObj.TargetID[CNum]).items).clone()[0];
	    $(EditObj).attr("name", "c" + Math.floor(Math.random() * 10000) + 1);

	    $(EditObj).val(tmpObj.GetRow(RNum, CNum));

	    $(EditObj).on("blur", function () {
	        SetTextMode(ObjId, RNum, CNum);
	    });
	    $(EditObj).on("keydown", function (e) {
	        GetKoyboardEvt(e, ObjId, RNum, CNum);
	    });
	}
	else if (tmpObj.ColumnsType[CNum] == "Radio") {
	    // html 가져오기
	    EditObj = $("#" + eval(tmpObj.TargetID[CNum]).items).clone()[0];
	    $(EditObj).find("input").attr("name", "c" + Math.floor(Math.random() * 10000) + 1);
	    //EditObj.id = "c" + Math.floor(Math.random() * 10000) + 1;
	    var v = tmpObj.GetRow(RNum, CNum);

	    $(EditObj).find("input").each(function () {
	        if ($(this).val() == v) $(this).prop("checked", true);
	    });

	    $(EditObj).find("input").on("change", function () {
	        SetTextMode(ObjId, RNum, CNum);
	    });
	    $(EditObj).on("keydown", function (e) {
	        GetKoyboardEvt(e, ObjId, RNum, CNum);
	    });
	}
	else if (tmpObj.ColumnsType[CNum] == "SearchView") {
	    // html 가져오기
	    EditObj = document.createElement('input'); // $("#" + eval(tmpObj.TargetID[CNum]).items).clone()[0];
	    EditObj.id = tmpObj.Items + "_" + RNum + "_" + CNum + "_" + Math.floor(Math.random() * 10000) + 1;
	    EditObj.className = 'JINSheet_EditObj';
	    var v = tmpObj.GetRow(RNum, CNum);

	    EditObj.value = v;
	    // 기존값에 바인딩할 값을 적용한다.
	    $("#" + eval(tmpObj.TargetID[CNum]).items).val(v);
	    $(EditObj).css("background-image", "none");
	    $(EditObj).css("height", "26px");
	    $(EditObj).css("width", "99%");
	    $(EditObj).on("keyup", function () {
	        SearchViewKeyUp(eval(tmpObj.TargetID[CNum] + "_Layer"), event, this);
	    });

	    $(EditObj).on("keydown", function () {
	        SearchViewKeyDown(eval(tmpObj.TargetID[CNum] + "_Layer"), event, this);
	    });

	    $(EditObj).on("focus", function () {
	        // 강제호출
	        OpenChk = false;
	        SearchViewClick(eval(tmpObj.TargetID[CNum] + "_Layer"), this);
	    });
	    $(EditObj).on("blur", function () {
	        tmpRNum = RNum;
	        tmpCNum = CNum;
	    });
	    $(EditObj).on("click", function () {
	        tmpRNum = RNum;
	        tmpCNum = CNum;
	    });
	    eval(tmpObj.TargetID[CNum] + "_Layer").fnOnClose = function (o) {
	        if (tmpRNum >= 0) {
	            SetTextMode(ObjId, tmpRNum, tmpCNum);
	        }
	    };
	}
	else if (tmpObj.ColumnsType[CNum] == "Calendar") {
	    // CellData = CellData.split(' ')[0];
	    EditObj = document.createElement('input');
	    EditObj.id = "c" + Math.floor(Math.random() * 10000) + 1;
	    EditObj.style.width = "99%";
	    EditObj.style.height = "26px";
	    EditObj.style.textAlign = "center";
	    EditObj.readOnly = true;
	    EditObj.className = 'JINSheet_EditObj';
	    EditObj.setAttribute("CType", "Calendar");
	    // Calendar 일시 이벤트 시점문제로 달력이 닫혔을시 이벤트를 처리하도록 변경함
	    //EditObj.onblur = function () { SetTextMode(ObjId, RNum, CNum); }
	    GridInCalendarEventable = true;
	    // 이전 정보 저장
	    ParentGridInCalendarParams1 = GridInCalendarParams1;
	    ParentGridInCalendarParams2 = GridInCalendarParams2;
	    ParentGridInCalendarParams3 = GridInCalendarParams3;

	    GridInCalendarParams1 = ObjId;
	    GridInCalendarParams2 = RNum;
	    GridInCalendarParams3 = CNum;

	    if (tmpObj.ColumnsDatatype[CNum] == "convert") {
	        EditObj.value = tmpObj.GetRow(RNum, CNum).XMLConvertEncode();
	    }
	    else {
	        EditObj.value = CellData = tmpObj.GetRow(RNum, CNum).split(' ')[0];

	    }
	    $(EditObj).on("keydown", function (e) {
	        GetKoyboardEvt(e, ObjId, RNum, CNum);
	    });
	}
	else if (tmpObj.ColumnsType[CNum] == "Text") {

	    if (tmpObj.ColumnsDatatype[CNum] == "TextArea") {

	        EditObj = document.createElement('textarea');
	        EditObj.style.width = "99%";
	        EditObj.style.height = CellObj.style.height == "" ? "26px" : CellObj.style.height;
	        EditObj.style.textAlign = CellObj.style.textAlign;
	        EditObj.className = 'JINSheet_EditObj';
	        //EditObj.onkeydown = function (e) { GetKoyboardEvt(e, ObjId, RNum, CNum); };
	        EditObj.onblur = function () { SetTextMode(ObjId, RNum, CNum); }
	        EditObj.value = tmpObj.GetRow(RNum, CNum);
	    }
	    else {

	        EditObj = document.createElement('input');
	        EditObj.style.width = "99%";
	        //EditObj.style.height = "26px";
	        EditObj.style.height = CellObj.style.height == "" ? "26px" : CellObj.style.height;
	        EditObj.style.textAlign = CellObj.style.textAlign;
	        EditObj.className = 'JINSheet_EditObj';
	        if (tmpObj.ColumnsDatatype[CNum] == "Number") {
	            EditObj.onkeydown = function (e) { GetKoyboardEvt(e, ObjId, RNum, CNum); TextboxNumber(); };
	            //EditObj.onkeyup = function (e) { TextboxComma(this); };
	            EditObj.onblur = function () { TextboxComma(this); SetTextMode(ObjId, RNum, CNum); }
	        }
	        else {
	            EditObj.onkeydown = function (e) { GetKoyboardEvt(e, ObjId, RNum, CNum); };
	            EditObj.onblur = function () { SetTextMode(ObjId, RNum, CNum); }
	        }

	        if (tmpObj.ColumnsDatatype[CNum] == "convert") {
	            EditObj.value = tmpObj.GetRow(RNum, CNum).XMLConvertEncode();
	        }
	        else if (tmpObj.ColumnsDatatype[CNum] == "Number") {
	            EditObj.value = typeof (tmpObj.GetRow(RNum, CNum)) != "number" ? tmpObj.GetRow(RNum, CNum).replace(/,/ig, '') : tmpObj.GetRow(RNum, CNum);
	        }
	        else {
	            EditObj.value = tmpObj.GetRow(RNum, CNum);
	        }
	    }
	}

	if (CellObj.firstChild == null) CellObj.appendChild(EditObj);
	else CellObj.replaceChild(EditObj, CellObj.firstChild);

	if (tmpObj.ColumnsType[CNum] == "Calendar") {
		if (tmpObj.DateFormat[CNum] != "") {
			ShowCalendar(EditObj, tmpObj.DateFormat[CNum]);
		}
		else {
		    ShowCalendar(EditObj, 'yyyy-mm-dd');
		}
	}
	else if (tmpObj.ColumnsType[CNum] == "SearchView") {
		// 강제 호출후 위치변경
		
	}

	if (window.SetEditModeAdditionalAction) {
	    SetEditModeAdditionalAction(ObjId, RNum, CNum);
	}
    

	// 이전컨트롤에 지정(컨트롤 변경시 이전 컨트롤을 TextMode로 변경해야함
	prtObj = ObjId;
	prtRnum = RNum;
	prtCNum = CNum;

	EditObj.focus();
}
// 그리드안 달력 선택여부
var GridInCalendarEventable = false;
// 그리드 안 달력 선택시 사용할 임시변수
var GridInCalendarParams1, GridInCalendarParams2, GridInCalendarParams3;
// 이전 달력 정보 변수
var ParentGridInCalendarParams1, ParentGridInCalendarParams2, ParentGridInCalendarParams3;

// 그리드안에 달력 처리를 위한 예외처리
function SelectCalendarInGrid(ObjId) {
	if (GridInCalendarEventable == true) {
		SetTextMode(ParentGridInCalendarParams1, ParentGridInCalendarParams2, ParentGridInCalendarParams3);
		SetTextMode(GridInCalendarParams1, GridInCalendarParams2, GridInCalendarParams3);
		GridInCalendarEventable = false;
	}
}
// sheet에서 읽기모드로 수정한다.
function SetTextMode(ObjId, RNum, CNum) {
	if (ObjId == undefined) return;
	var tmpObj = eval(ObjId);
	var CellObj = tmpObj.GetCell(RNum, CNum);

	var retValue = "";
	var EditObj = CellObj.firstChild;
	if (EditObj == null) { // 예외처리

	}
	else {

	    if (EditObj.type == "text") {
	        retValue = EditObj.value;
	    }
	    else if (EditObj.type == "textarea") {
	        retValue = EditObj.value;
	    }
	    else if (EditObj.type == "select-one") {
	        retValue = $(EditObj).find("option:selected").val(); //.value;
	    }
	    else if (EditObj.type == undefined) { // aspnet custom control은 span내부에 위치하기 떄문에 type이 나타나지 않음
	        if ($(EditObj).find("input:checked").length > 0) {
	            retValue = $(EditObj).find("input:checked").val();
	        }
	        else if ($(EditObj).find("input:radio").length > 0) {
	            $(EditObj).find("input:radio").each(function () {
	                if ($(this).prop("checked")) retValue = $(this).val();
	            });
	        }
	        else {
	            retValue = EditObj.textContent; // SearchView 두번클릭시 컨트롤이 삭제됨으로 이전값을 다시 지정
	        }
	    }
	}

	var ChangeChk = false;
	if (CellObj.getAttribute("OrgData").trim().XMLConvertEncode() != retValue.trim()) {
		if (typeof (ObjId) == "object" && $(ObjId).attr("Items") != undefined) ObjId = $(ObjId).attr("Items");

		if (tmpObj.UseCheckBox == "true" && tmpObj.CheckBoxAutoMerge == 0) //document.getElementsByName(ObjId + "_chk")[RNum].checked = "checked";
		{
		    $(CellObj).parent().find("input[name=" + ObjId + "_chk]").prop("checked", true);
		    //$(document.getElementsByName(ObjId + "_chk")).each(function () {
		    //    if ($(this).val() == (RNum + "")) {
		    //        //$(this).attr("checked", "checked");
		    //        $(this).prop("checked", true);
		    //    }
		    //});
		} // document.getElementsByName(ObjId + "_chk")[RNum].checked = "checked";
		else if (tmpObj.UseCheckBox == "true" && tmpObj.CheckBoxAutoMerge > 0) {
		    //CellObj
		    var trObj = $(CellObj).parent();//.find("input[name=" + ObjId + "_chk]");
            for (var i = 0; i < tmpObj.CheckBoxAutoMerge; i++) {
                if (trObj.find("input[name=" + ObjId + "_chk]").length > 0) {
                    trObj.find("input[name=" + ObjId + "_chk]").prop("checked", true);
                    break;
                }
                else {
                    trObj = trObj.prev("tr");
                }
		    }

            //if(trObj.find("input[name=" + ObjId + "_chk]").length>0){
            //    tdObj.prop("checked",true);
            //}
            //else{
		    //    for (var i = 0; i < tmpObj.CheckBoxAutoMerge-1; i++) {
            //        trObj = trObj.prev("tr");
		    //    }
            //}
		}
		ChangeChk = true;
		CellObj.className = "JINSheet_EditedCell";
		$(CellObj).css("background-image", "url(/Resources/Framework/orange_angle.gif)");
	} else {
		if (CellObj.className == "JINSheet_EditingCell2") CellObj.className = "JINSheet_EditedCell";
		else CellObj.className = "JINSheet_Cell";
		$(CellObj).css("background-image", "url(/Resources/Framework/blue_angle.gif)");

		// 그리드를 SetEditMode 함수로 컬럼 수정모드로 만들시 백그라운드 이미지 추가 스타일 지정 (2017-08-03 장윤호)
		$(CellObj).css("backgroundPosition", "right top");
		$(CellObj).css("backgroundRepeat", "no-repeat");
	}

	if (tmpObj.ColumnsDatatype[CNum] == "convert") {
		tmpObj.SetValue(RNum, CNum, retValue.XMLConvertDecode());
	}
    else {
        if ($(EditObj).attr("CType") != undefined && $(EditObj).attr("CType") == "Calendar") {
            tmpObj.SetValueCal(RNum, CNum, retValue.replace(/-/ig,''));
        }
        else {
            tmpObj.SetValue(RNum, CNum, retValue);
        }
		
	}
	CellObj.setAttribute("isEdit", "false");
	CellObj.onclick = function () {
        //if($(CellObj).css("background-image") == "none") return;
	    SetEditMode(ObjId, RNum, CNum);
	};
	CellObj.title = retValue;
	if (ChangeChk) {
		if (typeof (tmpObj.AutoSaveTarget) == "function") tmpObj.AutoSaveTarget(RNum, CNum);
	}
}

// sheet에서 키보드 이벤트 처리
function GetKoyboardEvt(e, ObjId, RNum, CNum) {
	var evt = e || window.event;
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	//var tmpObj = JisObjs.GetObjById(ObjId);
	var tmpObj = eval(ObjId);
	var CellObj = tmpObj.GetCell(RNum, CNum);
	switch (charCode) {
		case 27: //ESC
			tmpObj.RollValue(RNum, CNum);
			CellObj.setAttribute("isEdit", "false");
			if (CellObj.className == "JINSheet_EditingCell2") CellObj.className = "JINSheet_EditedCell";
			else CellObj.className = "JINSheet_Cell";
			CellObj.onclick = function () {
			    //if ($(CellObj).css("background-image") == "none") return;
			    SetEditMode(ObjId, RNum, CNum) 
            };
			break;
		case 13: //ENTER
			SetTextMode(ObjId, RNum, CNum);
			break;
		case 38: //위로
			if (RNum > 0) {
				SetTextMode(ObjId, RNum, CNum);
				SetEditMode(ObjId, RNum - 1, CNum);
			}
			break;
		case 40: //아래로
			if (parseInt(tmpObj.TotalListCnt, 10) > RNum + 1) {
				SetTextMode(ObjId, RNum, CNum);
				SetEditMode(ObjId, RNum + 1, CNum);
			}
			break;
		case 9: //TAB
			var CEditNum = 0;
			var REditNum = RNum;
			for (var i = 0; i < tmpObj.ColumnsEditable.length; i++) {
				if (tmpObj.ColumnsEditable[i] == "true") {
					if (CEditNum == 0 && CNum >= i) CEditNum = i;
					else if (CNum < i) CEditNum = i;
					if (CNum < i) break;
				}
			}
			if (parseInt(tmpObj.TotalListCnt, 10) > RNum + 1) {
				if (CEditNum <= CNum) REditNum++;
			}

			SetTextMode(ObjId, RNum, CNum);
			SetEditMode(ObjId, REditNum, CEditNum);

			var isWindowEvent = window.event ? true : false;
			if (!isWindowEvent) {
				evt.preventDefault();
			} else {
				evt.returnValue = false;
			}
			break;
	}
}

/*************************************************************************************************/
// SearchView
/*************************************************************************************************/
// 문서의 전체갯수
var TotalCnt = 0;
// 브라우져의 ie여부
var isIE = true;
// 구분자
var Separators = "^*#";
if (navigator.appName != "Microsoft Internet Explorer") isIE = false;
// 브라우져 확인
if (isIE) {
    B = "IE";
} else {
    B = "FF";
}
//B = (function x() { })[-5] == 'x' ? 'FF3' : (function x() { })[-6] == 'x' ? 'FF2' : /a/[-1] == 'a' ? 'FF' : '\v' == 'v' ? 'IE' : /a/.__proto__ == '//' ? 'Saf' : /s/.test(/a/.toString) ? 'Chr' : /^function \(/.test([].sort) ? 'Op' : 'FF';

//XML데이터를 String 배열로 리턴, ChkFlag가 true면 숫자인덱스 배열, 아니면 문자 인덱스 배열리턴
function GetXml2Strs(tmpObj, ChkFlag) {

	var tmpType = tmpObj.getAttribute('type');
	var RetObj = null;
	switch (tmpType) {
		case "STRS":
			var tmpVars = tmpObj.getElementsByTagName("Field");
			RetObj = new Array();
			for (var i = 0; i < tmpVars.length; i++) {
				RetObj[i] = GetNodeValue(tmpObj, "Field", i);
			}
			break;
		case "STR":
			RetObj = new Array();
			RetObj[0] = GetNodeValue(tmpObj, "Field", 0);
			break;
		case "DT":
			if (ChkFlag == "DTCustom") {
				var tmpVars = tmpObj.getElementsByTagName("RowData");
				TmpObj = new Array();
				RetObj = new Array();
				RetObj[0] = tmpObj.getAttribute('totcnt'); ;
				for (var i = 0; i < tmpVars.length; i++) {
					TmpObj[i] = new Array();
					for (var j = 0; j < tmpVars[i].childNodes.length; j++) {
						if (ChkFlag) {
							TmpObj[i][j] = GetNodeValue(tmpVars[i], "Field", j);
						} else {
							TmpObj[i][tmpVars[i].childNodes[j].getAttribute("fieldName")] = GetNodeValue(tmpVars[i], "Field", j);
						}
					}
				}
				RetObj[1] = TmpObj;
			} else {
				var tmpVars = tmpObj.getElementsByTagName("RowData");
				RetObj = new Array();
				for (var i = 0; i < tmpVars.length; i++) {
					RetObj[i] = new Array();
					for (var j = 0; j < tmpVars[i].childNodes.length; j++) {
						if (ChkFlag) {
							RetObj[i][j] = GetNodeValue(tmpVars[i], "Field", j);
						} else {
							RetObj[i][tmpVars[i].childNodes[j].getAttribute("fieldName")] = GetNodeValue(tmpVars[i], "Field", j);
						}
					}
				}
			}
			break;
	}
	return RetObj;
}

// XML 노드의 값을 리턴
function GetNodeValue(xmlDoc, NodeName, IdxNum) {
	if (xmlDoc.getElementsByTagName(NodeName).length > IdxNum) {
		if (xmlDoc.getElementsByTagName(NodeName).item(IdxNum).childNodes.length > 0) {
			return xmlDoc.getElementsByTagName(NodeName).item(IdxNum).firstChild.nodeValue;
		} else {
			return "";
		}
	}
}

// 컨트롤의 Top 위치를 구한다
function GetObjTop(obj) {
	if (obj.offsetParent == document.body) return obj.offsetTop;
	else return obj.offsetTop + GetObjTop(obj.offsetParent);
}

// 컨트롤의 Left 위치를 구한다.
function GetObjLeft(obj) {
	if (obj.offsetParent == document.body) return obj.offsetLeft;
	else return obj.offsetLeft + GetObjLeft(obj.offsetParent);
}

function GetMode(id) {
	if (document.getElementById(id) != null) {
		return document.getElementById(id).getAttribute("OnFocus");
	} else {
		return "";
	}
}

function GetTodate(Kubun) {
	try {
		var d = new Date();
		var date = "";
		if (Kubun == "Now") {
		    date = d.getFullYear() + "-" + CalLpad(d.getMonth() + 1) + "-" + CalLpad(d.getDate());
		    //date = d.getFullYear() + "" + CalLpad(d.getMonth() + 1) + "" + CalLpad(d.getDate());
		} else {
		    date = d.getFullYear() + "-" + CalLpad(d.getMonth() + 1) + "-01";
		    //date = d.getFullYear() + "" + CalLpad(d.getMonth() + 1) + "01";
		}

		return date;
	} catch (e) { return ""; }
}

function GetMonth() {
	try {
		var d = new Date();
		var date = "";
		date = d.getFullYear() + "-" + CalLpad(d.getMonth() + 1);
		//date = d.getFullYear() + "" + CalLpad(d.getMonth() + 1);
		return date;
	} catch (e) { return ""; }
}

function GetYear() {
	try {
		var d = new Date();
		var date = "";
		date = d.getFullYear();
		return date;
	} catch (e) { return ""; }
}

// ***************************************************************//
// Search_View 의 부모창에서 실행될 함수
var Onclick_Chk = 0;
var ClickChk = false; // false : 화면 닫힘,    true : 열림
var ChkTest = false;
var BDiv_ID = "";  // 이전 열었던 Div
var NDiv_ID = "";  // 현재 열려는 Div
var BObj_ID = "";  // 이전 열었단 Obj
var NObj_ID = "";  // 현재 열려는 Obj
var BIfr_ID = "";  // 이전 열었던 IFrame
var NIfr_ID = "";  // 현재 열려는 IFrame

function Search_View(obj_Search, e) {
	try {
		if (obj_Search.items != null) {
			NObj_ID = obj_Search.items;
			NDiv_ID = obj_Search.Div;
			NIfr_ID = obj_Search.Iframe;

			if (BObj_ID != NObj_ID) {
				if (BObj_ID == "") { }
				else {
					document.getElementById(BDiv_ID).style.visibility = "hidden";
					document.getElementById(BDiv_ID).style.left = "-1000px";
					ClickChk = false;

				}
			}

			BObj_ID = NObj_ID;
			BDiv_ID = NDiv_ID;
			BIfr_ID = NIfr_ID;

			if (e.keyCode == 0 && ClickChk == true) {
				document.getElementById(BDiv_ID).style.left = "-1000px";
				document.getElementById(BDiv_ID).style.visibility = "hidden";
			} else {
				document.getElementById(NIfr_ID).contentWindow.Search(obj_Search);
			}
		}
	} catch (e) { }
}

// Div 활성화 숨기기2 -> KeyDown 일경우 이벤트를 두어 처리
function Search_Hide2(Div, obj_id, e) {
	try {
		if (e.keyCode == 9) {
			if (document.getElementById(obj_id) != null) {
				document.getElementById(Div).style.left = "-1000px";
				document.getElementById(Div).style.visibility = "hidden";
				ClickChk = false;
			}
		}
	} catch (e) { }
}

// Div 활성화 숨기기 -> 일반 클릭일 경우
function Search_Hide(DIv, obj_id) {
	try {
		if (ClickChk == true) {
			if (document.getElementById(obj_id) != null) {
				document.getElementById(DIv).style.left = "-1000px";
				document.getElementById(DIv).style.visibility = "hidden";
				ClickChk = false;
			}
		}
	} catch (e) { }
}

// Div 활성화 보이기
var Height;
var Width;
var DObj_div = "";
var DObj_id = "";

function Search_Show(obj_div, obj_id) {
	try {
		DObj_div = obj_div; DObj_id = obj_id;
		if (Onclick_Chk == 0) {
			$(document.body).bind("click", function () {
				Search_Hide(DObj_div, DObj_id, event);
			});
			//document.body.onclick = function () { Search_Hide(DObj_div, DObj_id, event); }
			Onclick_Chk = 1;
		}
		setTimeout("ClickChk = true;", 500);
	} catch (e) { }
}

function SetViewHeight(iframe_id, obj_id, obj_div) {
	try {
		var obj_View = document.getElementById(iframe_id);
		var obj_View2 = document.getElementById(iframe_id).contentWindow;
		obj_View.style.height = "189px";
		if (ChkWidth == false) {
			obj_View.style.width =
                obj_View2.document.body.offsetWidth - obj_View2.document.body.clientWidth + obj_View2.document.body.scrollWidth + "px";
		} else {
			obj_View.style.width =
                obj_View2.document.body.offsetWidth - obj_View2.document.body.clientWidth + obj_View2.document.body.scrollWidth + "px";
		}

		// 현재 클릭한 컨트롤
		var obj_tbo = document.getElementById(obj_id);
		var obj_Div = document.getElementById(obj_div);
		//alert();
		if (obj_tbo != null) {
			var width = Delete_px(obj_View.style.width);
			var height = Delete_px(obj_View.style.height);
			var obj_width = Delete_px(obj_tbo.style.width);
			var obj_height = Delete_px(obj_tbo.style.height);
			var obj_top = GetObjTop(obj_tbo);
			var obj_left = GetObjLeft(obj_tbo);

			// 가로위치 
			if (obj_left + width > document.body.clientWidth) {
				obj_Div.style.left = obj_left - width + obj_width;
			} else { obj_Div.style.left = obj_left; }

			//세로위치
			var lochref = location.href;
			if (lochref.indexOf("8080") > -1) {
				if (obj_top + 222 > document.body.clientHeight) {
					//if (obj_top +  height > parent.document.body.clientHeight ) {
					obj_Div.style.top = obj_top - height - obj_height + 15;
				} else { obj_Div.style.top = obj_top + obj_height + 10; }
			}
			else {
				if (obj_top + height > parent.document.body.clientHeight) {
					obj_Div.style.top = obj_top - height - obj_height + 15;
				} else { obj_Div.style.top = obj_top + obj_height + 10; }
			}



			var div_id = obj_Div.getAttribute("id");
			var tbo_id = obj_tbo.getAttribute("id");

			//Search_Show (div_id, tbo_id);
		}
		document.getElementById(obj_div).style.visibility = "visible";
		ChkWidth = true;
	} catch (e) { }
}

// Search_View 의 부모창에서 실행될 함수 완료
// *************************************************************** //

// px 제거 후 숫자로 변경
function Delete_px(val) {
	try {
		if (val == "" || val == null) { return 0; }
		else { return eval(val.replace("px", "")); }
	} catch (e) { return 0; }
}

var ChkWidth = false;
function SetHeight() {
	try {
		var availHeight = Number(window.screen.availHeight) - 214;

		if (isIE) { // Internet Explorer
			if (parent.top.document.getElementById("SubBody") != null) {

				parent.top.document.getElementById("SubBody").style.width = "970px";

				// var availHeight = 536
				if (parent.top.document.getElementById("SubBody").contentWindow.document.body.offsetHeight - parent.top.document.getElementById("SubBody").contentWindow.document.body.clientHeight + parent.top.document.getElementById("SubBody").contentWindow.document.body.scrollHeight + 10 > availHeight) {
					parent.top.document.getElementById("SubBody").style.height = parent.top.document.getElementById("SubBody").contentWindow.document.body.offsetHeight - parent.top.document.getElementById("SubBody").contentWindow.document.body.clientHeight + parent.top.document.getElementById("SubBody").contentWindow.document.body.scrollHeight + 8 + "px";
				} else {
					parent.top.document.getElementById("SubBody").style.height = availHeight + "px"; //"537px";    
				}
			}
		} else { // Firefox, Safari
			if (parent.top.document.getElementById("SubBody") != null) {
				if (parent.top.document.getElementById("SubBody").contentWindow.document.body.offsetHeight + 10 > availHeight) {
					parent.top.document.getElementById("SubBody").style.height = parent.top.document.getElementById("SubBody").contentWindow.document.body.offsetHeight + 5 + "px";
				} else {
					parent.top.document.getElementById("SubBody").style.height = availHeight + "px";
				}
			}
			if (parent.top.document.getElementById("PopBody") != null) {
				parent.top.document.getElementById("PopBody").style.height = "671px";
				parent.top.document.getElementById("PopBody").style.width = "808px";

				if (parent.top.document.getElementById("PopBody").contentWindow.document.body.offsetHeight - parent.top.document.getElementById("PopBody").contentWindow.document.body.clientHeight + parent.top.document.getElementById("PopBody").contentWindow.document.body.scrollHeight + 10 > 430) {
					parent.top.document.getElementById("PopBody").style.height = parent.top.document.getElementById("PopBody").contentWindow.document.body.offsetHeight - parent.top.document.getElementById("PopBody").contentWindow.document.body.clientHeight + parent.top.document.getElementById("PopBody").contentWindow.document.body.scrollHeight + 50 + "px";
				}

				if (parent.top.document.getElementById("PopBody").contentWindow.document.body.offsetWidth - parent.top.document.getElementById("PopBody").contentWindow.document.body.clientWidth + parent.top.document.getElementById("PopBody").contentWindow.document.body.scrollWidth + 0 > 620) {
					parent.top.document.getElementById("PopBody").style.width = parent.top.document.getElementById("PopBody").contentWindow.document.body.offsetWidth - parent.top.document.getElementById("PopBody").contentWindow.document.body.clientWidth + parent.top.document.getElementById("PopBody").contentWindow.document.body.scrollWidth + 0 + "px";
				}
			}
		}
		// 메뉴이동
		parent.onScroll();
	}
	catch (ex) { }

}


// 날짜포맷변경
function SetDateFormat(OrgDate, OrgFormat, TargetFormat) {
	if (OrgFormat == TargetFormat) {
		return OrgDate;
	} else if (OrgDate.split("-").length != 3) {
		return OrgDate;
	}
	var strDate = "", strTime = "";
	if (OrgDate.indexOf(' ') > 0) {
		var ValDateTime = OrgDate.split(" ");
		strDate = ValDateTime[0];
		for (var i = 1; i < ValDateTime.length; i++) {
			strTime += " " + ValDateTime[i];
		}
	} else {
		strDate = OrgDate;
	}
	var tmpVal = OrgDate.split("-");
	var tmpYear = "";
	var tmpMonth = "";
	var tmpDate = "";
	if (OrgFormat == "MDY" || OrgFormat == "mdy") {
		tmpYear = tmpVal[2];
		tmpMonth = getMonthValue(tmpVal[0]);
		tmpDate = tmpVal[1];
	} else if (OrgFormat == "DMY" || OrgFormat == "dmy") {
		tmpYear = tmpVal[2];
		tmpMonth = getMonthValue(tmpVal[1]);
		tmpDate = tmpVal[0];
	} else {
		tmpYear = tmpVal[0];
		tmpMonth = tmpVal[1];
		tmpDate = tmpVal[2];
	}
	var retDate = "";
	if (TargetFormat == "MDY" || TargetFormat == "mdy") {
		retDate = Months[tmpMonth - 1] + "-" + tmpDate + "-" + tmpYear;
	} else if (TargetFormat == "DMY" || TargetFormat == "dmy") {
		retDate = tmpDate + "-" + Months[tmpMonth - 1] + "-" + tmpYear;
	} else {
		retDate = tmpYear + "-" + tmpMonth + "-" + tmpDate;
	}
	if (strTime != "") retDate += strTime;
	return retDate;
}


function wincenter(siz, opt) {
	if (opt == 1) {
		return (screen.availWidth - siz) / 2;
	}
	else if (opt == 2) {
		return (screen.availHeight - siz) / 2;
	}
	else {
		return false;
	}
}



var ProgressManager = function () {
	this.show = function () {
		if (document.getElementById("progress_layer")) {
			if (isIE) {
				document.getElementById("progress_layer").style.left = document.body.clientWidth / 2 + "px";
				document.getElementById("progress_layer").style.top = 757 / 2 - 49 + document.documentElement.scrollTop + "px";
				document.getElementById("progress_layer").style.display = "block";
			} else {
				document.getElementById("progress_layer").style.left = window.innerWidth / 2 + "px";
				document.getElementById("progress_layer").style.top = 757 / 2 - 49 + document.documentElement.scrollTop + "px";
				document.getElementById("progress_layer").style.display = "block";
			}
		}
	}
	this.hide = function () {
		if (document.getElementById("progress_layer")) {
			document.getElementById("progress_layer").style.display = "none";
		}
	}
}

var ProgressBar = new ProgressManager();

function getMonthBefor(orgYear, orgMonth, orgDate) {
	var chkMonth = GetLastDate(orgYear, orgMonth, orgDate);
	var orgDate1;
	if (chkMonth) {
		orgDate1 = new Date(orgYear, orgMonth - 1, orgDate + 1);
	} else {
		//orgDate1 = new Date(orgYear, orgMonth + 1, 1 - 1);
		orgDate1 = new Date(orgYear, orgMonth, 1);
	}
	return orgDate1;
}

function getYearBefor(orgYear, orgMonth, orgDate) {
	var orgDate1;
	orgDate1 = new Date(orgYear - 1, orgMonth, orgDate);

	return orgDate1;
}

function GetLastDate(orgYear, orgMonth, orgDate) {
	var checkMonth1 = new Date(orgYear, orgMonth - 1, orgDate).getMonth();
	var checkMonth2 = new Date(orgYear, orgMonth, 1 - 1).getMonth();
	return checkMonth1 == checkMonth2;
}

function CalLpad(num) {
	if (num < 10) {
		return "0" + num;
	} else {
		return num;
	}
}

function GetSdate(format) {
	var today = new Date();
	var tmpYear = today.getFullYear();
	var tmpMonth = today.getMonth();
	var tmpDate = today.getDate();
	var tmpDate2 = getMonthBefor(tmpYear, tmpMonth, tmpDate);
	var rtnEdate = "";

	rtnEdate = tmpDate2.getFullYear() + "-" + CalLpad((tmpDate2.getMonth() + 1)) + "-" + CalLpad(tmpDate2.getDate());

	return SetDateFormat(rtnEdate, "YMD", format);
}

function GetSdate_Year(format) {
	var today = new Date();
	var tmpYear = today.getFullYear();
	var tmpMonth = today.getMonth();
	var tmpDate = today.getDate();
	var tmpDate2 = getYearBefor(tmpYear, tmpMonth, tmpDate);
	var rtnEdate = "";

	rtnEdate = tmpDate2.getFullYear() + "-" + CalLpad((tmpDate2.getMonth() + 1)) + "-" + CalLpad(tmpDate2.getDate());

	return SetDateFormat(rtnEdate, "YMD", format);
}

function GetEdate(format) {
	var tmpDate1 = new Date();
	var rtnSdate = "";
	rtnSdate = tmpDate1.getFullYear() + "-" + CalLpad((tmpDate1.getMonth() + 1)) + "-" + CalLpad(tmpDate1.getDate());

	return SetDateFormat(rtnSdate, "YMD", format);
}

function GetThisMonth() {
	var today = new Date();
	var tmpYear = today.getFullYear();
	var tmpMonth = today.getMonth();

	return tmpYear + "-" + CalLpad(tmpMonth + 1);
}



function GetTopObj(id, height, top) {
	//                                                                                                                                                                                                                                              debugger;
	var obj = document.getElementById(id);
	//var height     = Delete_px(height);
	var obj_height = Delete_px(obj.style.height);
	var obj_top = top;
	//세로위치
	if (obj_top + height + obj_height > document.body.clientHeight) {
		return obj_top - height - obj_height + 12;
	} else { return obj_top + obj_height + 7; }
}

function GetLeftObj(id, width, left) {
	var obj = document.getElementById(id);
	var width = Delete_px(width);
	var obj_width = Delete_px(obj.style.width);
	var obj_left = left;

	if (obj_left + width > document.body.clientWidth) {
		return obj_left - width + obj_width;
	} else { return obj_left; }
}
var SearchViewItems;
var SearchView = function (layer, id, PNames, Arg, ColName, ShowCol, ControlName, CellWidth, OnViewClick, clickitem) {
    Controls.push(layer); // 전체 컨트롤 목록에 바인딩할 컨트롤 ID 입력

    // 휠이벤트 추가
//    $("#" + id).on('mousewheel DOMMouseScroll', function (e) {
//        var E = e.originalEvent;
//        delta = 0;
//        console.log(E);
//        if (E.detail) {
//            delta = E.detail * -40;
//            //$('body').text(delta);
//        } else {
//            delta = E.wheelDelta;
//            //$('body').text(delta);
//        };
//    });

    this.clickItem = clickitem ? clickitem : id;
    this.items = id;                        // 클릭한 컨트롤 id
    this.layer = layer; 			        // Search_View Layer ID
    this.Pnames = PNames;                   // Search_View 를 조회할 Procedures Name
    this.Arg = Arg;                         // Search_View 를 조회할 파라메터  
    this.ArgT = Arg;                        // Search_View 를 조회할 파라메터  
    //this.Object_Sheet = SheetCol;               // Search_View 에서 가져갈 컬럼명
    this.Object_Control = ControlName;            // Search_View 의 데이터를 담을 컨트롤명
    this.top = "";                     // Search_View 의 상단 좌표
    this.left = "";                     // Search_View 의 좌측 좌표
    this.width = "";
    this.height = "";
    this.layerid = "Search_dView"; // 실제로 데이터를 넣을 div
    this.iframeid = "Search_iView"; // 실제로 데이터를 넣을 iframe
    this.Alignment = new Array("left", "left", "left", "left", "left", "left", "left"); //Alignment;      // 가운데 정렬 구분
    this.ShowCol = ShowCol;        // 보일 컬럼
    this.MouseOverColor = "#EAEAEA";      // 마우스 오버시 색
    this.DefaultColumnColor1 = "#FFFFFF";      // 마우스 아웃시 색
    this.DefaultColumnColor2 = "#F6F6FA"; //F4F8FB
    //this.FontFamily = "맑은 고딕"; // 폰트는 SearchViewCommon.html 에 헤더에 정의함
    this.FontSize = "12px";
    this.CellWidth = CellWidth;      // 각 셀의 가로길이
    this.CellHeight = "18px"; //CellHeight;     // 각 셀의 세로길이
    this.ColName = ColName;        // 헤더명
    this.PagingSize = 8; //PagingSize;     // Paging 기본수 ( 기본 조회 라인 )
    this.Colspan = 0;              // Paging Bar 를 위한 가로병합
    this.RowCnt = 0;              // 줄마다 색변경을 위한 로우 카운트
    this.Param = [];
    this.Params = [];
    this.PageSize = 10; //PageSize;
    this.TotalCnt = 0;
    this.Datatype = new Array("text", "text"); //Datatype;
    this.DefaultPosition = ""; // Position;
    this.tmpParam = "";
    this.fnOnViewClick = OnViewClick;
    this.fnOnClose = null;
    this.DataSet = new Object();
    this.SelectedRow = new Object();
    this.IsSearchEnter = false;   // Enter 이벤트 만 검색 동작 가능 여부
    this.CustomParams = function (o) {
        this.Params = o;
    };
    this.ControlParams = "";
    this.Show = function (target) {

        // 스크롤 생성 문제로 SearchView를 생성후 활성화한다. (특정 페이지 문제로 롤백)
        document.getElementById(this.layerid).style.display = "block";

        // 레이어 및 iframe 크기설정
        document.getElementById(this.layerid).style.width = this.width; // +"px";
        document.getElementById(this.iframeid).style.width = this.width; // +"px";

        var height = document.getElementById(this.iframeid).contentWindow.document.body.offsetHeight -
            document.getElementById(this.iframeid).contentWindow.document.body.clientHeight +
            document.getElementById(this.iframeid).contentWindow.document.body.scrollHeight;

        document.getElementById(this.layerid).style.height = height + "px";
        document.getElementById(this.iframeid).style.height = height + "px";

        var width = this.width.replace(/[^0-9]/g, '');
        if (target == undefined) {
            target = document.getElementById(this.clickItem);
        }

        var winHigh = $(document).height(); //document.body.offsetHeight;
        var eHigh = YHposition.elementTop(target) + target.offsetHeight; // -YHposition.eScrollTop(target);
        var winWidth = $(document).width(); // document.body.offsetWidth;
        var eWidth = YHposition.elementLeft(target); // -YHposition.eScrollLeft(target);

        //var lochref = location.href;
        if ((winHigh - eHigh) >= height) {
            // 컨트롤 하단에 위치
            this.top = (YHposition.elementTop(target) + target.offsetHeight); // - YHposition.eScrollTop(target));
            $((eval(SearchViewItems.iframeid)).document).find(".arrow_top").show();
            $((eval(SearchViewItems.iframeid)).document).find(".arrow_bottom").hide();
        }
        else {
            // 컨트롤 상단에 위치
            this.top = (YHposition.elementTop(target) - height - 5); // - YHposition.eScrollTop(target)) - 50;
            $((eval(SearchViewItems.iframeid)).document).find(".arrow_top").hide();
            $((eval(SearchViewItems.iframeid)).document).find(".arrow_bottom").show();
        }

        if ((winWidth - eWidth) >= width) {
            this.left = (YHposition.elementLeft(target) - YHposition.eScrollLeft(target));
        }
        else {
            this.left = (YHposition.elementLeft(target) + target.offsetWidth - width); // - YHposition.eScrollLeft(target));
        }
        if (this.left < 0) this.left = 0;
        // 레이어의 위치 조절
        document.getElementById(this.layerid).style.left = this.left - 2 + "px";
        document.getElementById(this.layerid).style.top = this.top + 0 + "px"; ;

        setTimeout("OpenChk=true", 100);
    }
    this.Hide = function () {
        if (OpenChk == true) {
            document.getElementById(this.layerid).style.display = "none";
            if (typeof (AfterViewClick) == "function") {
                AfterViewClick(this.items, this.tmpParam);
            }

            // 값 체크후 없으면 데이터 클리어
            if (document.getElementById(this.Object_Control[0]).value == "") {
                for (i = 0; i < this.Object_Control.length; i++) {
                    if (document.getElementById(this.Object_Control[i]))
                        document.getElementById(this.Object_Control[i]).value = "";
                }
            }

            setTimeout("OpenChk=false", 100);

            if (typeof (this.fnOnClose) == "function") {
                this.fnOnClose(this.Object_Control);
            }

        }
    };
    this.Clear = function () {
        document.getElementById(this.layerid).style.display = "none";
        //AfterViewClick(this.items, this.tmpParam);

        // 값 체크후 없으면 데이터 클리어
        document.getElementById(this.Object_Control[0]).value = "";
        for (i = 0; i < this.Object_Control.length; i++) {
            if (document.getElementById(this.Object_Control[i]))
                document.getElementById(this.Object_Control[i]).value = "";
        }
    };
    this.TypeName = "";
    this.MethodName = "";
    this.DataSource = function (typeName, methodName) {
        this.TypeName = typeName;
        this.MethodName = methodName;
    };
    this.Target;
    this.Bind = function (PageNum, target) {
        // 타겟
        if (target == undefined) { // 타겟이 undefined는 페이지 이동일시 임으로 기본 타겟이 설정되어있다고 보고 처리함
            target = this.Target;
        }

        this.Target = target;

        // 페이징 갯수 안먹음에 따른 추가 2017-09-08 장윤호
        if (!(this.Params.PageSize == undefined)) {
            this.PagingSize = this.Params.PageSize;
        }

        var ht = new Object();
        ht["CurrentPageIndex"] = PageNum;
        ht["PageSize"] = this.PagingSize;
        if (target == undefined) {
            ht["SearchCondition"] = document.getElementById(this.items).value;
        }
        else {
            ht["SearchCondition"] = target.value;
        }

        for (i = 0; i < ObjectCount(this.Params); i++) {
            ht[Object.keys(this.Params)[i]] = this.Params[Object.keys(this.Params)[i]];
        }
        var params = eval(this.ControlParams); // 커스텀 파라미터 추가
        if (params != undefined) {
            params = params[0]; // 첫번째값만
            for (i = 0; i < ObjectCount(params); i++) {
                ht[Object.keys(params)[i]] = params[Object.keys(params)[i]];
            }
        }

        SearchViewItems = this; // 콜백실행위치설정
        PageMethods.InvokeServiceTableSync(ht, this.TypeName, this.MethodName, function (e) {
            var ds = eval(e);
            if (ds == undefined || ds == "") {
                alert("데이터가 없습니다");
                return;
            }
            var DataObj = ds.Tables[0];
            SearchViewItems.DataSet = DataObj;
            SearchViewItems.TotalCnt = ds.Tables[1].Rows[0]["TOTALCOUNT"];  //TotalCnt; 

            if (DataObj.Rows.length == 1) {
                movenum = 0;
                ViewTableKeyMove(movenum, this, this.Target);
            } else {
                movenum = -1;
            }

            var tmpObj = document.createElement("div");
            //tmpObj.style.padding = "10px 10px 10px 10px";

            tmpObj.appendChild(SearchViewItems.CreateTable(DataObj, PageNum));
            document.getElementById(SearchViewItems.iframeid).contentWindow.DrawSheet(tmpObj.innerHTML);
            SearchViewItems.Show(target);
        }, function (e) {
            ProgressBar.hide();
            alert(e.get_message());
        });
    };
    this.CreateHRow = function () {
        var tr = document.createElement("tr");
        var width = 0;
        for (var i = 0; i < this.ColName.length; i++) {
            if (ShowCol[i] == true) {
                var td = document.createElement("td");
                var textNode = document.createTextNode(ColName[i]);
                td.className = "header";
                td.style.height = this.CellHeight;
                //td.style.textAlign = "center";
                width += parseInt(this.CellWidth[i].replace("px", ""), 10);
                td.style.width = this.CellWidth[i];
                //td.style.color = "#7882A0";
                //td.style.color = "#FFFFFF";
                //td.style.background = "#3F51B5";
                //td.style.fontFamily = this.FontFamily;
                td.style.fontSize = this.FontSize;
                td.appendChild(textNode);
                tr.appendChild(td);
            }
        }
        //tr.style.background = "#F4F8FB";
        tr.style.background = "#DFE3F0";
        tr.style.width = width;
        this.width = width + "px";
        return tr;
    }
    // 페이징 태그 생성
    this.CreatePageing = function (PageNum) {
        // 가로병합 사이즈 체크
        this.Colspan = 0;
        for (var i = 0; i < this.ShowCol.length; i++) {
            if (this.ShowCol[i] == true) {
                this.Colspan += 1;
            }
        }

        var tr = document.createElement("tr");
        var td = document.createElement("td");

        //////////////////////////////////////////////////////////////////////////////////////////////////////
        //
        //  ** 변수 선언 설명 **
        //  1.Block : 현재 블럭이 몇번째 블럭인지 설명
        //  2.Block_S : 현재블럭의 첫번째 번호
        //  3.Block_E : 현재블럭의 마지막 번호
        //  4.Pre_Num : 현재블럭의 첫번째 바로 앞번호
        //  5.Next_Num : 현재블럭의 마지막 바로 다음번호
        // 
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        var MaxCnt = Math.ceil(this.TotalCnt / this.PagingSize);
        var Block = Math.ceil(PageNum / this.PageSize);
        var Block_S = ((Block - 1) * this.PageSize) + 1;
        var Block_E = (Block * this.PageSize);
        var Pre_Num = Block_S - 1;
        var Next_Num = Block_E + 1;

        var PageStr = "";
        if (Pre_Num != 0) {
            PageStr += "<img id=\"prev02\" src=\"/Resources/Images/btn_list_first.gif\" style=\"vertical-align:middle; cursor:pointer;\" onclick=\"parent." + this.layer + "_Layer.Bind(1)\" />";
            PageStr += "&nbsp;<img id=\"prev01\" src=\"/Resources/Images/btn_list_pre.gif\" style=\"vertical-align:middle; cursor:pointer;\" onclick=\"parent." + this.layer + "_Layer.Bind(" + Pre_Num + ")\" />";
        }
        for (var i = Block_S; i < Block_E + 1; i++) {
            if (i <= MaxCnt) {
                if (i == PageNum) {
                    PageStr += "&nbsp;<span id=\"layer_num" + i + "\" onclick=\"parent." + this.layer + "_Layer.Bind(" + i + ")\" style=\"cursor:pointer;font-weight:bold; font-size:11px;color:#ff5a00;\"> " + i + "</span>";
                } else {
                    PageStr += "&nbsp;<span id=\"layer_num" + i + "\" onclick=\"parent." + this.layer + "_Layer.Bind(" + i + ")\" style=\"cursor:pointer; font-size:11px;\"> " + i + "</span>";
                }
            }
        }
        if (Next_Num <= MaxCnt) {
            PageStr += "&nbsp;<img id=\"next01\" src=\"/Resources/Images/btn_list_next.gif\" style=\"vertical-align:middle; cursor:pointer;\" onclick=\"parent." + this.layer + "_Layer.Bind(" + Next_Num + ")\" />";
            PageStr += "&nbsp;<img id=\"next02\" src=\"/Resources/Images/btn_list_end.gif\" style=\"vertical-align:middle; cursor:pointer;\" onclick=\"parent." + this.layer + "_Layer.Bind(" + MaxCnt + ")\" />";
        }

        td.innerHTML = PageStr;
        td.setAttribute("colspan", this.Colspan);
        td.style.background = "#FFFFFF";
        td.style.textAlign = "center";
        td.style.height = "25px";
        tr.appendChild(td);
        return tr;
    }
    // Bottom 영역 Render
    this.CreateBottom = function () {
        var tr = document.createElement("tr");
        var td = document.createElement("td");
        td.innerHTML = this.SearchMethod();
        td.innerHTML += "<div style='float:right; color:#FFFFCE;'>Total: " + (new String(this.TotalCnt)).numberFormat() + "</div>";

        td.setAttribute("colspan", this.Colspan);
        td.style.background = "#3F51B5";
        td.style.color = "#E0E0E0";
        td.style.textAlign = "left";
        td.style.height = "25px";
        td.style.paddingLeft = "5px";
        td.style.paddingRight = "5px";
        tr.appendChild(td);
        return tr;
    };
    this.SearchMethod = function () {
        var _ko_true = "검색 : ENTER 이벤트";
        var _ko_false = "검색 : KEY PRESS 이벤트";
        var _cn_true = "SEARCH : ENTER";
        var _cn_false = "SEARCH : KEY PRESS";
        var _en_true = "SEARCH : ENTER";
        var _en_false = "SEARCH : KEY PRESS";
        var _us_true = "SEARCH : ENTER";
        var _us_false = "SEARCH : KEY PRESS";
        var _es_true = "Buscar : Entrar";
        var _es_false = "Buscar : Pulsar la tecla";
        var _mx_true = "Buscar : Entrar";
        var _mx_false = "Buscar : Pulsar la tecla";

        //return (eval("_" + Use_Language.toLowerCase() + "_" + this.IsSearchEnter));
        return (eval("_ko_" + this.IsSearchEnter));
    };
    // 테이블 태그 생성
    this.CreateTable = function (dac, PageNum) {
        this.RowCnt = 0;
        var Table = document.createElement("table");
        Table = document.createElement("table");
        Table.setAttribute("id", this.items + "_table");
        Table.setAttribute("cellpadding", "0");
        Table.setAttribute("cellspacing", "0");
        //Table.style.borderWidth = "1px";
        //Table.style.borderStyle = "solid";
        //Table.style.borderColor = "#3D6AAE";
        //Table.style.borderColor = "#C3CAD7";
        Table.style.border = "1px solid #3F51B5";

        //Table.style.background = "#3D6AAE"; 테이블 내부의 테두리
        //Table.style.background = "#C3CAD7";
        Table.appendChild(this.CreateHRow());

        Table.style.height = 53 + this.PagingSize * 23 + "px";

        this.height = 53 + this.PagingSize * 23 + "px";

        if (ObjectCount(dac.Rows) > 0) {
            for (var i = 0; i < this.PagingSize; i++) {
                if (i < ObjectCount(dac.Rows)) {
                    Table.appendChild(this.CreateRow(dac.Rows[i], i));
                } else {
                    Table.appendChild(this.CreateRowBlank(i));
                }
                this.RowCnt += 1;
            }
        } else {
            for (var i = 0; i < this.PagingSize; i++) {
                Table.appendChild(this.CreateRowBlank(i));
                this.RowCnt += 1;
            }
        }
        Table.appendChild(this.CreatePageing(PageNum));
        Table.appendChild(this.CreateBottom());
        return Table;
    }
    this.CreateRowBlank = function (rownum) {
        var tr = document.createElement("tr");
        if (this.RowCnt % 2 == 0) {
            tr.style.background = "#FFFFFF";
            tr.setAttribute("onmouseout", "this.style.backgroundColor = \"" + this.DefaultColumnColor1 + "\";");
        }
        else {
            tr.style.background = "#FAFAFF"; //F4F8FB
            tr.setAttribute("onmouseout", "this.style.backgroundColor = \"" + this.DefaultColumnColor2 + "\";");
        }

        for (var i = 0; i < ShowCol.length; i++) {
            if (this.ShowCol[i] == true) {
                var td = document.createElement("td");
                td.style.height = this.CellHeight;
                td.className = "content";
                var textNode = document.createTextNode("");
                td.appendChild(textNode);
                tr.appendChild(td);
            }
        }

        return tr;
    }
    this.CreateRow = function (rowdata, rownum) {
        var Param = "";
        var tr = document.createElement("tr");
        tr.style.cursor = "pointer";
        tr.setAttribute("id", this.items + "_tr_" + rownum);
        tr.setAttribute("onmouseover", "this.style.backgroundColor = \"" + this.MouseOverColor + "\";");
        if (this.RowCnt % 2 == 0) {
            tr.style.background = "#FFFFFF";
            tr.setAttribute("onmouseout", "this.style.backgroundColor = \"" + this.DefaultColumnColor1 + "\";");
        }
        else {
            tr.style.background = "#F6F6FA"; //F4F8FB
            tr.setAttribute("onmouseout", "this.style.backgroundColor = \"" + this.DefaultColumnColor2 + "\";");
        }

        var width = 0;
        for (var i = 0; i < this.Arg.length; i++) {
            if (this.ShowCol[i] == true) {
                tr.appendChild(this.CreateCell(rowdata[this.Arg[i]], i));
                width += parseInt(this.CellWidth[i].replace("px", ""), 10);
            }

            this.Param.push(rowdata[this.Arg[i]]);
            if (Param == "") {
                Param = rowdata[this.Arg[i]];
            } else {
                Param += "$$" + rowdata[this.Arg[i]];
            }
        }
        this.width = width + "px";
        Param = Param.replace(/\"/ig, "\\\"");
        tr.setAttribute("onclick", "parent." + this.layer + "_Layer.ReturnsValues(\"" + Param + "\"," + rownum + "); ");

        return tr;
    };

    this.CreateCell = function (celldata, colnum) {
        celldata = ReConvertString(celldata);
        var td = document.createElement("td");
        td.setAttribute("id", this.items + "_td_" + colnum);
        try {
            td.style.textAlign = this.Alignment[colnum];
        }
        catch (e) { }
        td.style.width = this.CellWidth[colnum];
        td.style.height = this.CellHeight;

        //td.style.fontFamily = this.FontFamily;
        td.className = "content";
        td.style.fontSize = this.FontSize;
        td.style.color = "#000000";

        if (this.Datatype[colnum] == "amount") {
            if (celldata.isNumber() == true) {
                celldata = String(parseFloat(celldata)).comma();
            }
        }

        td.style.paddingLeft = "5px";

        var textNode = document.createTextNode(celldata);
        var divNode = document.createElement("div");
        var divwidth = this.CellWidth[colnum].replace(/[^(0-9)]/g, '');
        divNode.style.width = parseInt(divwidth, 10) > 20 ? (parseInt(divwidth, 10) - 20) + 'px' : '100%';
        divNode.style.overflow = "hidden";
        divNode.style.textOverflow = "ellipsis";
        divNode.style.whiteSpace = "nowrap";
        //<div style='overflow:hidden;text-overflow:ellipsis;white-space:nowrap;'>
        divNode.appendChild(textNode);
        //td.appendChild(textNode);
        td.appendChild(divNode);
        return td;
    };
    this.ReturnsValues = function (Param, rownum) {
        var ParamArray = Param.split("$$");

        for (var i = 0; i < this.Object_Control.length; i++) {
            if (document.getElementById(this.Object_Control[i]) != null) {
                if (ParamArray.length > i) {
                    document.getElementById(this.Object_Control[i]).value = ParamArray[i];
                    if (i == 0) { // 첫번째값
                        if (this.Target != undefined) {
                            $(this.Target).val(ParamArray[i]);
                            document.getElementById(this.Object_Control[i]).value = "";
                        }
                    }
                }
            }
        }
        this.tmpParam = Param;
        // 선택한 값을 SelectedRow에 저장
        this.SelectedRow = this.DataSet.Rows[rownum];
        this.Hide();
        //onviewclick 이벤트 실행부분(김영우 2010-02-26 추가)
        if (typeof (this.fnOnViewClick) == "function") {
            this.fnOnViewClick(ParamArray, this.SelectedRow, this.Target);
        }
    };

    // 업체사용자로 로그인 시 업체코드 SearchView 를 숨기기 위함
    this.NoneDisplay = function (CurrCode) {
        var CodeObj = document.getElementById(this.items);
        var ValueObj = document.getElementById(this.items + "_txt");
        CodeObj.value = CurrCode;
        CodeObj.style.display = "none";
        ValueObj.style.display = "none";
    };
}

function GetModeFireFox(id) {
	if (document.getElementById(id) != null) {
		return document.getElementById(id).style.backgroundColor;
	} else {
		return "";
	}
}

var BodyClickEvt = false;
var OpenChk = false;
var ObjectId = "";
var Onclick_Chk = 0;
//function AfterViewClick(id, Param) { }
//function BeforeViewClick() { return true; }
function SearchViewClick(obj, target) {
	// 신규시 선택내용 초기화
	movenum = -1;

	if (typeof BeforeViewClick == "function") {
		BeforeViewClick();
	}
	if (B == "IE") {
		if (GetMode(obj.items) == null || GetMode(obj.items) == "") {
			if (Onclick_Chk == 0) {
				$(document.body).bind("click", function () {
					if (BodyClickEvt == false) {
						obj.Hide();
					}
					BodyClickEvt = false;
				});
				//                    document.body.onclick = function () {
				//                        if (BodyClickEvt == false) {
				//                            obj.Hide();
				//                        }
				//                        BodyClickEvt = false;
				//                    }
				Onclick_Chk = 1;
			}

			// 닫힌상태이므로 열어서 조회
			if (OpenChk == false) {
				obj.Bind(1, target);
			} else {
				if (ObjectId != obj.items) {
					obj.Bind(1, target);
					BodyClickEvt = true;
				} else {
					obj.Hide();
				}
			}
			ObjectId = obj.items;
		}
	} else if (B == "FF") {
		if (GetModeFireFox(obj.items) != "rgb(233, 233, 233)") {
			if (Onclick_Chk == 0) {
				$(document.body).bind("click", function () {
					if (BodyClickEvt == false) {
						obj.Hide();
					}
					BodyClickEvt = false;
				});
				//                    document.body.onclick = function () {
				//                        if (BodyClickEvt == false) {
				//                            obj.Hide();
				//                        }
				//                        BodyClickEvt = false;
				//                    }
				Onclick_Chk = 1;
			}

			// 닫힌상태이므로 열어서 조회
			if (OpenChk == false) {
				obj.Bind(1, target);
			} else {
				if (ObjectId != obj.items) {
					obj.Bind(1, target);
					BodyClickEvt = true;
				} else {
					obj.Hide();
				}
			}
			ObjectId = obj.items;
		}
	}
}

// 텍스트 박스에 키다운 이벤트
function SearchViewKeyDown(obj, e, target) {

    if (e.keyCode == 9) {
        var num = $(target).parent().attr("id").split('_');

        var RNum = num[1] * 1;
        var CNum = num[2] * 1;
        var tmpObj = eval(num[0]);

        var CEditNum = 0;
        var REditNum = RNum;
        for (var i = 0; i < tmpObj.ColumnsEditable.length; i++) {
            if (tmpObj.ColumnsEditable[i] == "true") {
                if (CEditNum == 0 && CNum >= i) CEditNum = i;
                else if (CNum < i) CEditNum = i;
                if (CNum < i) break;
            }
        }
        if (parseInt(tmpObj.TotalListCnt, 10) > RNum + 1) {
            if (CEditNum <= CNum) REditNum++;
        }
        if (e.srcElement.value != "") {
            var frame = document.getElementById("Search_iView").contentWindow;
            // onclick의 함수를 문자열로 변환후 파라미터값 추출
            var fnStr = ((frame.document.getElementById(obj.items + "_tr_0") != null) ? (frame.document.getElementById(obj.items + "_tr_0").getAttribute("onclick") + "").split('"')[1] : '');

            // 선택값 리턴
            obj.ReturnsValues(fnStr);
        }
        // 값 초기화
        movenum = -1;
        nowPagingNum = 1;

        SetTextMode(tmpObj, RNum, CNum);
        
        obj.Hide();

        //var isWindowEvent = window.event ? true : false;
        //if (!isWindowEvent) {
        //    window.event.preventDefault();
        //} //else {
        //    evt.returnValue = false;
        //}
        setTimeout(function () {
            SetEditMode(tmpObj, REditNum, CEditNum);
        }, 100);
        
    }
    //else {
    //    obj.Bind(1, target);
    //    BodyClickEvt = false;
    //    ObjectId = obj.items;
    //    //obj.Show(); 입력 및 검색시 위치조정부분 제거(속도문제로 인하여)
    //}

    return true;
}

// 텍스트 박스에 키 입력 이벤트
function SearchViewKeyPress(obj, e, target) {
    
    if (e.keyCode == 9) {
        var num = $(target).parent().attr("id").split('_');

        var RNum = num[1] * 1;
        var CNum = num[2] * 1;
        var tmpObj = eval(num[0]);

        var CEditNum = 0;
        var REditNum = RNum;
        for (var i = 0; i < tmpObj.ColumnsEditable.length; i++) {
            if (tmpObj.ColumnsEditable[i] == "true") {
                if (CEditNum == 0 && CNum >= i) CEditNum = i;
                else if (CNum < i) CEditNum = i;
                if (CNum < i) break;
            }
        }
        if (parseInt(tmpObj.TotalListCnt, 10) > RNum + 1) {
            if (CEditNum <= CNum) REditNum++;
        }

        SetTextMode(tmpObj, RNum, CNum);
        SetEditMode(tmpObj, REditNum, CEditNum);

        //var isWindowEvent = window.event ? true : false;
        //if (!isWindowEvent) {
        //    evt.preventDefault();
        //} else {
        //    evt.returnValue = false;
        //}
    }
    //else {
    //    obj.Bind(1, target);
    //    BodyClickEvt = false;
    //    ObjectId = obj.items;
    //    //obj.Show(); 입력 및 검색시 위치조정부분 제거(속도문제로 인하여)
    //}

	return true;
}
function SearchViewKeyUp(obj, e, target) {
    if (e.keyCode == 13) {
        // enter
        if (movenum > -1) { // 선택된 값이 있을시
            var frame = document.getElementById("Search_iView").contentWindow;
            // onclick의 함수를 문자열로 변환후 파라미터값 추출
            var fnStr = "";
            if (frame.document.getElementById(obj.items + "_tr_" + movenum)) {
                fnStr = (frame.document.getElementById(obj.items + "_tr_" + movenum).getAttribute("onclick") + "").split('"')[1];
            }
            else {// 검색후 계산시 오류로 인한 예외처리
                fnStr = (frame.document.getElementById(obj.items + "_tr_" + (movenum-1)).getAttribute("onclick") + "").split('"')[1];
            }

            // 선택값 리턴
            obj.ReturnsValues(fnStr, movenum);

            // 값 초기화
            movenum = -1;
            nowPagingNum = 1;
        }
        else {
            // 선택된 값이 없을시 검색
            obj.Bind(1, target);
            BodyClickEvt = false;
            ObjectId = obj.items;
            //obj.Show(); 입력 및 검색시 위치조정부분 제거(속도문제로 인하여)
        }
    }
    else if (e.keyCode == 38 || e.keyCode == 40) {
        // 위, 아래키
        if (e.keyCode == 38) {
            // 위로

            movenum--;

            if (movenum < 0) {
                // 상위 페이지가 존재시 페이징 이동
                if (nowPagingNum != 1) {
                    nowPagingNum--;
                    obj.Bind(nowPagingNum, target);
                    movenum = 7;
                }
            }
        }
        else {
            // 아래로

            movenum++;

            if (movenum > 7) {
                // 하위 페이지가 존재시 페이징 이동
                if (obj.TotalCnt != nowPagingNum) {
                    nowPagingNum++;
                    obj.Bind(nowPagingNum, target);
                    movenum = 0;
                }
            }
        }
        // 이동없을시 해당 값 고정함
        if (movenum == -1) {
            movenum = 0;
        }
        if (movenum == obj.TotalCnt + 1) {
            movenum = obj.TotalCnt;
        }
        // 키보드에 따른 bg변경
        ViewTableKeyMove(movenum, obj, target);

    }
    else if (e.KeyCode == 9) {
    }
    else {
        obj.Bind(1, target);
        BodyClickEvt = false;
        ObjectId = obj.items;
        //obj.Show();
    }
	return true;
}
// 시작점은 0으로 시작
var movenum = -1;
// 현재 지정된 페이징
var nowPagingNum = 1;

// 키보드로 테이블 이동
function ViewTableKeyMove(num, obj, target) {
	var id = obj.items;
	var over_color = obj.MouseOverColor;
	var row1_color = obj.DefaultColumnColor1;
	var row2_color = obj.DefaultColumnColor2;

	// iframe안의 객체 접근 (Search_dView)
	var frame = document.getElementById("Search_iView").contentWindow;

	if (frame.document.getElementById(id + "_tr_" + (num))) {

		frame.document.getElementById(id + "_tr_" + (num)).style.backgroundColor = over_color;
		// 앞, 뒤 bg색상 변경
		if (num == 0) {
			// 밑에만 적용
			if (frame.document.getElementById(id + "_tr_1")) frame.document.getElementById(id + "_tr_1").style.backgroundColor = row2_color;
		}
		else if (num == 7) {
			// 위에만 적용
			if (frame.document.getElementById(id + "_tr_6")) frame.document.getElementById(id + "_tr_6").style.backgroundColor = row1_color;
		}
		else {
			// 위, 아래 다적용

			if (num % 2 == 0) {
				frame.document.getElementById(id + "_tr_" + (num - 1)).style.backgroundColor = row2_color;
				frame.document.getElementById(id + "_tr_" + (num + 1)).style.backgroundColor = row2_color;
			}
			else {
				frame.document.getElementById(id + "_tr_" + (num - 1)).style.backgroundColor = row1_color;
				frame.document.getElementById(id + "_tr_" + (num + 1)).style.backgroundColor = row1_color;
			}
		}
	}
}

// 페이지의 전체컨트롤 목록
var WebControls = function () {
    this.controls = new Array();
    this.push = function (v) {
        this.controls.push(v);
    };
    this.GetValue = function () {
        var ht = new Object();
        for (var i = 0; i < this.controls.length; i++) {
            try {
                if (typeof eval(this.controls[i]).GetValue == "function") {
                    ht[this.controls[i]] = eval(this.controls[i]).GetValue();
                }
            } catch (e) {
                ht[this.controls[i]] = $("#" + this.controls[i]).val();
            }
        }
        return ht;
    };
    this.GetID = function () {
        return this.controls;
    };
    //return this.controls;
};
var Controls = new WebControls();

// 촤측메뉴 숨기고 보여주기
var LeftMenuHide = false;
function LeftMenuHideShow() {
    if (!LeftMenuHide) {
        $("#leftmenu_bx").animate({
            left: '-=190'
        }, 600, function () {
            $("#leftmenu_bx").find("#treeMenu").hide();
            $("#leftmenu_bx>div").find("a").text("▶");
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
            $("#leftmenu_bx>div").find("a").text("◀");
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

var WebGrids = function () {
    this.controls = new Array();
    this.push = function (v) {
        this.controls.push(v);
    };
};
var Grids = new WebGrids();
//Controls.prototype.GetValue = function () {
//    var ht = new Object();
//    for (var i = 0; i < this.length; i++) {
//        ht[this[i]] = eval(i).GetValue();
//    }
//    return ht;
//};

//*************************************************************************************************/
// 서버컨트롤의 GetValue, SetValue 처리
//*************************************************************************************************/
var SearchText = function (id, ctype) {
    Controls.push(id); // 전체 컨트롤 목록에 바인딩할 컨트롤 ID 입력
    this.items = id;
    this.Control = $("#" + id).eq(0);
    this.CType = ctype;

    this.IsSearchView;
    this.SearchView;
    // 버튼 예외처리
    this.Hide = function () {
        $("#" + id).hide();
    };
    this.Show = function () {
        $("#" + id).show();
    };
    // SearchView에서 데이터 초기화시
    this.Clear = function () {
        if (this.IsSearchView) {
            (eval(this.items.split('_')[0] + "_Layer")).Clear();
        }
    };

    this.SetDisabled = function (value) {
        if (document.getElementById(id).nodeName == "INPUT") {
            $("#" + id).attr("disabled", value);
        }
        else if (document.getElementById(id).nodeName == "TEXTAREA") {
            $("#" + id).attr("disabled", value);
        }
        else if (document.getElementById(id).nodeName == "SELECT") {
            $("#" + id).attr("disabled", value);
        }
        else {
            // radio일시
            if ($("#" + id).find("input[type=radio]").length > 0) {
                $("#" + id).find("input[type=radio]").attr("disabled", value);
            }
            // checkbox일시
            else if ($("#" + id).find("input[type=checkbox]").length > 0) {
                $("#" + id).find("input[type=checkbox]").attr("disabled", value);
            }
        }
    };

    this.SetReadOnly = function (value) {

    };

    this.GetValue = function () {
        // 노드네임에 따른 값 가져오기
        if (document.getElementById(id).nodeName == "INPUT") {
            if ($(document.getElementById(id)).attr("onclick") != null
                && $(document.getElementById(id)).attr("onclick") != undefined
                && $(document.getElementById(id)).attr("onclick").indexOf("ShowCalendar") == 0) {
                //return document.getElementById(id).value; //.replace(/-/gi, '');
                return document.getElementById(id).value.replace(/-/gi, '');
            }
            else {
                return document.getElementById(id).value.XMLConvertDecode();
            }
        }
        else if (document.getElementById(id).nodeName == "TEXTAREA") {
            return $("#" + id).val();
        }
        else if (document.getElementById(id).nodeName == "SELECT") {
            return $("#" + id).val();
        }
        else if (document.getElementById(id).nodeName == "SPAN" && document.getElementById(id).getAttribute("timepicker") == "timepicker") {
            var time = "";
            $("#" + id).find("input").each(function () {
                time += $(this).val() + " ";
            });
            time += $("#" + id).find("select").val();
            return time;
        }
        else { // SPAN 이면 CHECKBOX, RADEO
            // radio일시
            if ($("#" + id).find("input[type=radio]").length > 0) {
                var chkValue = null;

                $("#" + id).find("input[type=radio]").each(function () {
                    if ($(this).prop("checked")) {
                        chkValue = $(this).val();
                    }
                });

                return chkValue;
            }
            // checkbox일시
            else if ($("#" + id).find("input[type=checkbox]").length > 0) {
                var chkValue = new Array();

                $("#" + id).find("input[type=checkbox]").each(function () {
                    if ($(this).prop("checked")) {
                        chkValue.push($(this).val());
                    }
                });

                return chkValue;
            }
            // Text 일시
            else {
                return $("#" + id).text();
            }
        }
    };
    this.GetText = function () {
        if (document.getElementById(id).nodeName == "SELECT") {
            return $("#" + id).find("option:checked").text();
        }
        else { // SPAN 이면 CHECKBOX, RADEO
            // radio일시
            if ($("#" + id).find("input[type=radio]").length > 0) {
                var chkValue = null;

                $("#" + id).find("input[type=radio]").each(function () {
                    if ($(this).prop("checked")) {
                        chkValue = $(this).next("label").text();
                    }
                });

                return chkValue;
            }
            // checkbox일시
            else if ($("#" + id).find("input[type=checkbox]").length > 0) {
                var chkValue = new Array();

                $("#" + id).find("input[type=checkbox]").each(function () {
                    if ($(this).prop("checked")) {
                        chkValue.push($(this).next("label").text());
                    }
                });

                return chkValue;
            }
        }
    };
    this.SetValue = function (Values) {
        if (document.getElementById(id).nodeName == "INPUT") {
            document.getElementById(id).value = ReConvertString(Values);

            // SearchView IsSearchView
            if (this.IsSearchView) {

                // Values가 없을시 return
                if (Values == "") return;

                var ht = new Object();
                ht["CurrentPageIndex"] = 1;
                ht["PageSize"] = 8;
                ht["SearchCondition"] = Values;

                for (i = 0; i < ObjectCount(this.SearchView.Params); i++) {
                    ht[Object.keys(this.SearchView.Params)[i]] = this.SearchView.Params[Object.keys(this.SearchView.Params)[i]];
                }

                if (this.SearchView.Commonable == true) {
                    PageMethods.InvokeServiceTable(ht, this.SearchView.TypeName, this.SearchView.MethodName, function (e) {
                        var ds = eval(e);
                        if (ds == undefined || ds == "") return;

                        var DataObj = ds.Tables[0];

                        // ID + 컬럼명으로 컨트롤을 검색
                        var svID = id.split('_')[0];

                        for (var key in DataObj.Rows[0]) {
                            var o = $("#" + svID + "_" + key);
                            if (o.length > 0) {
                                o.val(DataObj.Rows[0][key]);
                            }
                        }

                    }, function (e) {
                        alert(e.get_message());
                    });
                }
                else {
                    PageMethods.InvokeServiceTable(ht, this.SearchView.TypeName, this.SearchView.MethodName, function (e) {
                        var ds = eval(e);
                        if (ds == undefined || ds == "") return;

                        var DataObj = ds.Tables[0];

                        // ID + 컬럼명으로 컨트롤을 검색
                        var svID = id.split('_')[0];

                        for (var key in DataObj.Rows[0]) {
                            var o = $("#" + svID + "_" + key);
                            if (o.length > 0) {
                                o.val(DataObj.Rows[0][key]);
                            }
                        }

                    }, function (e) {
                        alert(e.get_message());
                    });
                }
            }
        }
        else if (document.getElementById(id).nodeName == "TEXTAREA") {
            Values = Values.replace(/\<br\>/ig, '\n').replace(/\<br\/\>/ig, '\n').replace(/\<br \/\>/ig, '\n').replace(/\<BR\>/ig, '\n').replace(/\<BR\/\>/ig, '\n').replace(/\<BR \/\>/ig, '\n').replace(/\₩n/ig, '\n');

            $("#" + id).val(Values);
        }
        else if (document.getElementById(id).nodeName == "SELECT") {
            $("#" + id).val(Values);
            // 읽기모드처리
            if (this.ReadMode) {
                $("#" + id + "_text").text($("#" + id).find("option:checked").text());
            }
        }
        else if (document.getElementById(id).nodeName == "SPAN" && document.getElementById(id).getAttribute("timepicker") == "timepicker") {
            var times = Values.split(' ');
            if (times.length != 3) {
                alert("날자형식이 맞지않습니다.");
            }
            else {
                $("$" + id).find("input")[0].value = times[0];
                $("$" + id).find("input")[1].value = times[1];
                $("$" + id).find("select").val(times[2]);
            }
        }
        else { // SPAN 이면 CHECKBOX, RADEO
            // radio일시
            if ($("#" + id).find("input[type=radio]").length > 0) {
                $("#" + id).find("input[type=radio]").each(function () {
                    if ($(this).val() == Values) {
                        $(this).prop("checked", true);
                    } else if (Values == "") {
                        $(this).prop("checked", false);
                    }
                });
                // 읽기모드처리
                if (this.ReadMode) {
                    var chkValue = null;
                    $("#" + id).find("input[type=radio]").each(function () {
                        if ($(this).prop("checked")) {
                            chkValue = $(this).next("label").text();
                        }
                    });
                    // 읽기모드 마지막 콤마삭제
                    $("#" + id + "_text").text(chkValue);
                }
            }
            // checkbox일시
            else if ($("#" + id).find("input[type=checkbox]").length > 0) {
                //                $("#" + id).find("input[type=checkbox]").each(function () {
                //                    $(this).prop("checked", false);
                //                });
                $("#" + id).find("input[type=checkbox]").each(function () {
                    if ($(this).val() == Values) {
                        $(this).prop("checked", true);
                    } else if (Values == "") {
                        $(this).prop("checked", false);
                    }
                });
                // 읽기모드처리
                if (this.ReadMode) {
                    var readmode_text = "";
                    $("#" + id).find("input[type=checkbox]").each(function () {
                        if ($(this).prop("checked")) {
                            readmode_text += $(this).next("label").text() + ", ";
                        }
                    });
                    // 읽기모드 마지막 콤마삭제
                    if (readmode_text.length > 0) {
                        readmode_text = readmode_text.substr(0, readmode_text.length - 2);
                    }
                    $("#" + id + "_text").text(readmode_text);
                }
            }
            else {
                //$("#" + id).text(Values); // (2014-07-26 SPAN HTML 오류)
                $("#" + id).html(Values);
            }
        }

        if (document.getElementById(id) != null) {
            if (this.CType != undefined && (this.CType == "Calendar" || this.CType == "Calendar_FrTo")) {
                document.getElementById(id).value = Values.toString().replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
            }
            else {
                document.getElementById(id).value = ReConvertString(Values);
            }
        }
    };
    this.DataSource = function (typeName, methodName) {
        eval(id + "_Layer.DataSource('" + typeName + "','" + methodName + "');");
    };

    this.GetValueFromText = function (Text) {
        var retStr = "";
        $("#" + this.items).find("option").each(function () {
            if ($(this).html() == Text) retStr = $(this).attr("value");
        });
        return retStr;
    };

    // 컨트롤 바인딩 (콤보,라디오,체크박스)
    this.Param = new Object();
    this.TypeName;
    this.MethodName;
    this.DataValueField;
    this.DataTextField;
    this.SelectedIndex = -1;
    this.SelectedValue = "";
    this.CallBack = function () { };
    this.ReadMode;
    this.ControlType;
    this.Async = false;

    this.Params = function (ht) {
        this.Param = ht;
    };
    this.ControlParams = "";

    this.BindList = function () {
        var controlType = this.ControlType;
        var params = eval(this.ControlParams); // 커스텀 파라미터 추가
        if (params != undefined) {
            params = params[0]; // 첫번째값만
            for (i = 0; i < ObjectCount(params); i++) {
                this.Param[Object.keys(params)[i]] = params[Object.keys(params)[i]];
            }
        }
        if (this.Async) {
            PageMethods.InvokeServiceTable(this.Param, this.TypeName, this.MethodName, function (e) {
                var ds = eval(e);
                if (ds == undefined || ds == "") {
                    alert("데이터가 없습니다");
                    return;
                }
                // 처리구문
                if (document.getElementById(id).nodeName == "SELECT") {
                    $("#" + id).empty(); // 하위노드 삭제
                    for (var i = 0; i < ds.Tables[0].Rows.length; i++) {
                        var option_text = "<option value='" + ds.Tables[0].Rows[i][eval(id).DataValueField] + "'";
                        if (eval(id).SelectedIndex > 0 && eval(id).SelectedIndex == i) {
                            option_text += " selected='selected'";
                        }
                        if (eval(id).SelectedValue != "" && eval(id).SelectedValue == ds.Tables[0].Rows[i][eval(id).DataValueField]) {
                            option_text += "selected='selected'";
                        }
                        option_text += ">" + ds.Tables[0].Rows[i][eval(id).DataTextField] + "</option>";

                        $("#" + id).append(option_text);
                    }
                    // 읽기모드체크
                    if (eval(id).ReadMode) {
                        $("#" + id + "_text").text($("#" + id).find("option:checked").text());
                    }
                    eval(id + ".CallBack();");
                }
                else { // radio, checkbox
                    //var type = "";
                    //if ($("#" + id).find("[type=radio]").length > 0) {
                    //    type = "radio";
                    //}
                    //else {
                    //    type = "checkbox";
                    //}

                    $("#" + id).empty(); // 하위노드 삭제
                    for (var i = 0; i < ds.Tables[0].Rows.length; i++) {
                        var option_text = "<input type='" + controlType + "' name='" + id + "' value='" + ds.Tables[0].Rows[i][eval(id).DataValueField] + "'";
                        if (eval(id).SelectedIndex > 0 && eval(id).SelectedIndex == i) {
                            option_text += " selected='selected'";
                        }
                        if (eval(id).SelectedValue != "" && eval(id).SelectedValue == ds.Tables[0].Rows[i][eval(id).DataValueField]) {
                            option_text += "selected='selected'";
                        }
                        option_text += "/><label onclick='ControlClick(this);' class='control_rabel'>" + ds.Tables[0].Rows[i][eval(id).DataTextField] + "</label>";

                        $("#" + id).append(option_text);
                    }
                    // 읽기모드체크
                    if (eval(id).ReadMode) {
                        $("#" + id + "_text").text(eval(id).GetValue());
                    }
                    eval(id + ".CallBack();");
                }
            }, function (e) {
                alert(e.get_message());
                //ProgressBar.hide();
            });
        }
        else {
            PageMethods.InvokeServiceTableSync(this.Param, this.TypeName, this.MethodName, function (e) {
                var ds = eval(e);
                if (ds == undefined || ds == "") {
                    alert("데이터가 없습니다");
                    return;
                }
                // 처리구문
                if (document.getElementById(id).nodeName == "SELECT") {
                    $("#" + id).empty(); // 하위노드 삭제
                    for (var i = 0; i < ds.Tables[0].Rows.length; i++) {
                        var option_text = "<option value='" + ds.Tables[0].Rows[i][eval(id).DataValueField] + "'";
                        if (eval(id).SelectedIndex > 0 && eval(id).SelectedIndex == i) {
                            option_text += " selected='selected'";
                        }
                        if (eval(id).SelectedValue != "" && eval(id).SelectedValue == ds.Tables[0].Rows[i][eval(id).DataValueField]) {
                            option_text += "selected='selected'";
                        }
                        option_text += ">" + ds.Tables[0].Rows[i][eval(id).DataTextField] + "</option>";

                        $("#" + id).append(option_text);
                    }
                    // 읽기모드체크
                    if (eval(id).ReadMode) {
                        $("#" + id + "_text").text($("#" + id).find("option:checked").text());
                    }
                    eval(id + ".CallBack();");
                }
                else { // radio, checkbox
                    //var type = "";
                    //if ($("#" + id).find("[type=radio]").length > 0) {
                    //    type = "radio";
                    //}
                    //else {
                    //    type = "checkbox";
                    //}

                    $("#" + id).empty(); // 하위노드 삭제
                    for (var i = 0; i < ds.Tables[0].Rows.length; i++) {
                        var option_text = "<input type='" + controlType + "' name='" + id + "' value='" + ds.Tables[0].Rows[i][eval(id).DataValueField] + "'";
                        if (eval(id).SelectedIndex > 0 && eval(id).SelectedIndex == i) {
                            option_text += " selected='selected'";
                        }
                        if (eval(id).SelectedValue != "" && eval(id).SelectedValue == ds.Tables[0].Rows[i][eval(id).DataValueField]) {
                            option_text += "selected='selected'";
                        }
                        option_text += "/><label onclick='ControlClick(this);' class='control_rabel'>" + ds.Tables[0].Rows[i][eval(id).DataTextField] + "</label>";

                        $("#" + id).append(option_text);
                    }
                    // 읽기모드체크
                    if (eval(id).ReadMode) {
                        $("#" + id + "_text").text(eval(id).GetValue());
                    }
                    eval(id + ".CallBack();");
                }
            }, function (e) {
                alert(e.get_message());
                //ProgressBar.hide();
            });
        }
    };
}

// 쿼리스트링 다음부분 배열로 반환(문광복) -  멀티 쿼리스트링
/*| Function : QueryString(ars_name) |*/
/*| Description : url의 querystring을 리턴 |*/
/*| Argument : 체크할 querystring 값  |*/
/*| Return : querystring을 리턴  |*/
function QueryString(ars_name) {
	var lo_result = new Array;
	var ls_url_query = location.search; // url에서 ? 부터의 문자열
	var lo_array1 = new Array; // & 로 분리시킨 값이 들어갈배열
	var lo_array2 = new Array; // = 로 분리시킨 값이 들어갈배열
	var i = 0;


	ls_url_query = ls_url_query.slice(1); // 첫문자 ?는 자르고
	lo_array1 = ls_url_query.split("&"); // & 배열로 나눈다.


	for (i = 0; i < lo_array1.length; i++) {
		lo_array2 = lo_array1[i].split("="); // = 배열나누기
		lo_result[lo_array2[0]] = lo_array2[1]; // 결과를 lo_result에 저장
	}


	if (lo_result[ars_name] != null) {
		return lo_result[ars_name];
	}
	else {
		return false;
	}
}



/********************************************************************************************
함수명      : ConvertString(val)
파라미터    : val - 원본 값
작성목적    : Command Injection을 방지를 위해 String을 Convert합니다.
작성자      : 김영우
작성일      : 2010-01-29
수정내역    :
********************************************************************************************/
function ConvertString(val) {
	var rtnVal;

	if (val == null) {
		rtnVal = null;
	}
	else {
		rtnVal = val.toString();

		// 복원작업 (여러번 저장하는 경우 문자열의 변형을 막기 위해서)
		rtnVal = ReConvertString(rtnVal);

		// 변환작업
		rtnVal = rtnVal.replace("\'", "\\'");
		rtnVal = rtnVal.replace("&", "&amp;");
		rtnVal = rtnVal.replace("#", "&#35;");
		rtnVal = rtnVal.replace("\"", "&quot;");
		rtnVal = rtnVal.replace("<", "&lt;");
		rtnVal = rtnVal.replace(">", "&gt;");
		rtnVal = rtnVal.replace("(", "&#40;");
		rtnVal = rtnVal.replace(")", "&#41;");

		rtnVal = rtnVal.trim();
	}

	return rtnVal;
}

/********************************************************************************************
함수명      : ReConvertString(val)
파라미터    : val - 원본 값
작성목적    : Command Injection을 방지를 위해 String을 ReConvert합니다.
작성자      : 김영우
작성일      : 2010-01-29
수정내역    :
********************************************************************************************/
function ReConvertString(val) {
	var rtnVal;

	if (val == null) {
		rtnVal = null;
	}
	else {
		rtnVal = val.toString();

		// 변환작업
		rtnVal = rtnVal.replace("&#41;", ")");
		rtnVal = rtnVal.replace("&#40;", "(");
		rtnVal = rtnVal.replace("&gt;", ">");
		rtnVal = rtnVal.replace("&lt;", "<");
		rtnVal = rtnVal.replace("&quot;", "\"");
		rtnVal = rtnVal.replace("&#35;", "#");
		rtnVal = rtnVal.replace("&amp;", "&");
		rtnVal = rtnVal.replace("\\'", "\'");
	}

	return rtnVal;
}
/********************************************************************************************
함수명      : YHposition.elementLeft, YHposition.elementTop, YHposition.eScrollLeft ,YHposition.eScrollTop
파라미터    : 컨트롤 객체
작성목적    : 입력된 컨트롤 객체의 좌표값을 리턴한다.
작성자      : 문광복
작성일      : 
수정내역    :
********************************************************************************************/
var YHposition = {
	elementLeft: function (obj) {
		if (typeof obj == 'string') obj = document.getElementById(obj);
		if (obj) {
			return $(obj).offset().left;
		}
	},
	elementTop: function (obj) {
		if (typeof obj == 'string') obj = document.getElementById(obj);
		if (obj) {
			return $(obj).offset().top;
		}
	},
	eScrollLeft: function (obj) {
		if (typeof obj == 'string') obj = document.getElementById(obj);
		if (obj) {
			if (obj.parentNode == document.body)
				return obj.scrollLeft + obj.parentNode.scrollLeft;
			else return obj.scrollLeft + this.eScrollLeft(obj.parentNode);
		}
	},
	eScrollTop: function (obj) {
		if (typeof obj == 'string') obj = document.getElementById(obj);
		if (obj) {
			if (obj.parentNode == document.body)
				return obj.scrollTop + obj.parentNode.scrollTop;
			else return obj.scrollTop + this.eScrollTop(obj.parentNode);
		}
	}
};

/*
달력사용법
yyyy-mm-dd : 년-월-일
yyyy-mm : 년-월
yyyy    : 년
*/

var tmpCalCheck = false;
var CalViewCheck = 0;
var tmpObjId = "";
var TargetMode2Date = "";
var TargetMode2Month = "";
// 월의 텍스트 정의
var Months = new Array();
Months[0] = "-01";
Months[1] = "-02";
Months[2] = "-03";
Months[3] = "-04";
Months[4] = "-05";
Months[5] = "-06";
Months[6] = "-07";
Months[7] = "-08";
Months[8] = "-09";
Months[9] = "-10";
Months[10] = "-11";
Months[11] = "-12";

function CheckCalendar(id, e) {
	// 숫자만 입력받는다
	if ((event.keyCode < 45) || (event.keyCode > 57)) {
		event.returnValue = false;
		return;
	}

	// 입력 문자열을 체크하여 데이터의 유효성을 검사한다.
	var obj = document.getElementById(id);
	var str = obj.value;

	//str = str.replace(/-/ig, "");

	obj.value = str;
}

// 입력창에 키보드 입력시 숫자만 입력받음
function CalendarKeyPress(e) {
	if ((e.keyCode < 45) || (e.keyCode > 57)) {
		e.returnValue = false;
	}
}
// 입력창에 키보드 입력후 날자형변환
function CalendarBlur() {
	//alert(calendarObj.id);

	var str = calendarObj.value;

	//str = str.replace(/-/ig, "");

	// 4,2,2 자리로 자른후 - 추가
	//if (str.length > 4) {
	//	str = str.substr(0, 4) + "-" + str.substr(4, str.length - 4);
	//}
	//if (str.length > 7) {
	//	str = str.substr(0, 7) + "-" + str.substr(7, str.length - 7);
	//}


	calendarObj.value = str;

	//HideCalendar();
}
var calendarObj;



// 달력 시작 (입력 텍스트, 날자 표시모드, 레이어 위치)
function ShowCalendar(OrgObj, strMode, positionObj) {
	// 열려있는 calendar가 있을시 닫음
	if (CalViewCheck == "2") HideCalendar();
	// 숫자만 입력 이벤트 추가
	$(OrgObj).unbind("keypress", CalendarKeyPress);
	$(OrgObj).bind("keypress", CalendarKeyPress);
	//removeEvent(OrgObj, "keypress", CalendarKeyPress);
	//addEvent(OrgObj, "keypress", CalendarKeyPress);
	// maxlangth 지정
	OrgObj.maxLength = 10;
	// 입력수 날자변환
	calendarObj = OrgObj;
	$(OrgObj).unbind("blur", CalendarBlur);
	$(OrgObj).bind("blur", CalendarBlur);
	//removeEvent(OrgObj, "blur", CalendarBlur);
	//addEvent(OrgObj, "blur", CalendarBlur);

	CalViewCheck = 1;
	TargetMode2Date = "";
	TargetMode2Month = "";

	document.getElementById("frmCalendar_FT").style.display = "none";
	document.getElementById("frmCalendar").style.display = "block";

	var LayerObj = document.getElementById("Calendar_Layer");
	if (LayerObj.style.display == "block") {
		if (tmpObjId == OrgObj.id) {
			LayerObj.style.display = "none";
			CalViewCheck = false;
			return;
		}
	}

	tmpObjId = OrgObj.id;

	var tmpHtml = "";
	var CurrVal = OrgObj.value;

	LayerObj.TargetId = OrgObj.id;
	LayerObj.Mode = strMode;

	var tmpDate;
	var CurrDate = new Date();
	var CurrYear;
	var CurrMonth;
	var CurrDay;

	if (strMode == "") strMode = "yyyy-mm";
	if (CurrVal == "") {
		CurrYear = CurrDate.getFullYear();
		CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
		CurrDay = CurrDate.getDate();
	}
	else {
		if (strMode == "yyyy") {
			//yyyy
			if (OrgObj.value.length == 4 && parseInt(OrgObj.value, 10) > 0 && parseInt(OrgObj.value, 10) < 3000) {
				CurrYear = OrgObj.value;
			}
			else {
				CurrYear = CurrDate.getFullYear();
			}
		}
		else if (strMode == "yyyy-mm") {
			//yyyy-mm
			if (OrgObj.value.length == 7 && OrgObj.value.indexOf("-") > 0) {
				CurrYear = OrgObj.value.split("-")[0];
				CurrMonth = OrgObj.value.split("-")[1];
			}
			else {
				CurrYear = CurrDate.getFullYear();
				CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
			}
		}
		else if (strMode == "yyyymm") {
			//yyyy-mm
			if (OrgObj.value.length == 6) {
				CurrYear = OrgObj.value.substr(0, 4);
				CurrMonth = OrgObj.value.substr(4, 2);
			}
			else {
				CurrYear = CurrDate.getFullYear();
				CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
			}
		}
		else if (strMode == "yyyy-mm-dd") {
			//yyyy-mm-dd
			if (OrgObj.value.length == 10 && OrgObj.value.indexOf("-") > 0) {
				CurrYear = OrgObj.value.split("-")[0];
				CurrMonth = OrgObj.value.split("-")[1];
				CurrDay = OrgObj.value.split("-")[2];
			}
			else {
				CurrYear = CurrDate.getFullYear();
				CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
				CurrDay = (100 + CurrDate.getDate()).toString().substr(1);
			}
		}
		else if (strMode == "yyyymmdd") {
			//yyyy-mm-dd
			if (OrgObj.value.length == 8) {
				CurrYear = OrgObj.value.substr(0, 4);
				CurrMonth = OrgObj.value.substr(4, 2);
				CurrDay = OrgObj.value.substr(6, 2);
			}
			else {
				CurrYear = CurrDate.getFullYear();
				CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
				CurrDay = (100 + CurrDate.getDate()).toString().substr(1);
			}
		}
		else if (strMode == "mm-dd-yyyy") {
			//mm-dd-yyyy
			if ((OrgObj.value.length == 10 || OrgObj.value.length == 11) && OrgObj.value.indexOf("-") > 0) {
				CurrYear = OrgObj.value.split("-")[2];
				CurrMonth = getMonthValue(OrgObj.value.split("-")[0]);
				CurrDay = OrgObj.value.split("-")[1];
			}
			else {
				CurrYear = CurrDate.getFullYear();
				CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
				CurrDay = (100 + CurrDate.getDate()).toString().substr(1);
			}
		}
		else if (strMode == "dd-mm-yyyy") {
			//dd-mm-yyyy
			if ((OrgObj.value.length == 10 || OrgObj.value.length == 11) && OrgObj.value.indexOf("-") > 0) {
				CurrYear = OrgObj.value.split("-")[2];
				CurrMonth = getMonthValue(OrgObj.value.split("-")[1]);
				CurrDay = OrgObj.value.split("-")[0];
			}
			else {
				CurrYear = CurrDate.getFullYear();
				CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
				CurrDay = (100 + CurrDate.getDate()).toString().substr(1);
			}
		}
		else {
			return;
		}
	}
	if (strMode == "yyyy") {
		//yyyy
		SetCalendarYear(CurrYear);
	}
	else if (strMode == "yyyy-mm") {
		//yyyy-mm
		SetCalendarMonth(CurrYear + "-" + CurrMonth);
	}
	else if (strMode == "yyyymm") {
		//yyyy-mm
		SetCalendarMonth(CurrYear + "-" + CurrMonth);
	}
	else if (strMode == "yyyy-mm-dd") {
		SetCalendarDate(CurrYear + "-" + CurrMonth + "-" + CurrDay, strMode);
	}
	else if (strMode == "yyyymmdd") {
		SetCalendarDate(CurrYear + "-" + CurrMonth + "-" + CurrDay, strMode);
	}
	else if (strMode == "mm-dd-yyyy") {
		SetCalendarDate(CurrYear + "-" + CurrMonth + "-" + CurrDay, strMode);
	}
	else if (strMode == "dd-mm-yyyy") {
		SetCalendarDate(CurrYear + "-" + CurrMonth + "-" + CurrDay, strMode);
	}

	var ObjX;
    var ObjY;
	try {
	    ObjX = GetObjTop(OrgObj);
	    ObjY = GetObjLeft(OrgObj);
	} catch (e) {
	    CalViewCheck = 2;
	    HideCalendar();
	}
	// 띄울 객체가 존재시
	if (positionObj != undefined) {//debugger;
		ObjX = GetObjTop(positionObj);
		ObjY = GetObjLeft(positionObj);
	}

	if (document.getElementById("sub_popup_left_content")) {
		if (document.body.clientHeight < ObjX + 270 - document.getElementById("sub_popup_left_content").scrollTop && ObjX > 280 - document.getElementById("sub_popup_left_content").scrollTop) {
			ObjX -= 263 + document.getElementById("sub_popup_left_content").scrollTop;
		} else {
			ObjX += 18 - document.getElementById("sub_popup_left_content").scrollTop;
		}

		if (document.body.clientWidth < ObjY + 270 && ObjY > 280) {
			ObjY -= 268 - parseInt(OrgObj.style.width.replace("px", ""));
		}
	}
	else if (document.getElementById("documentScrollBody")) {
		if (document.body.clientHeight < ObjX + 270 - document.getElementById("documentScrollBody").scrollTop && ObjX > 280 - document.getElementById("documentScrollBody").scrollTop) {
			ObjX -= 263 + document.getElementById("documentScrollBody").scrollTop;
		} else {
			ObjX += 18 - document.getElementById("documentScrollBody").scrollTop;
		}

		if (document.body.clientWidth < ObjY + 270 && ObjY > 280) {
			ObjY -= 268 - parseInt(OrgObj.style.width.replace("px", ""));
		}
	}
	else if (IsPopup && tmpGridID != "") { // 달력이 팝업이고 그리드 안에 위치할시
		var obj = $("#" + tmpGridID + "_main .JINSheet_ScrollBodyHeight")[0];
		if (obj) {
			if (document.body.clientHeight < ObjX + 270 - obj.scrollTop && ObjX > 280 - obj.scrollTop) {
				ObjX -= 263 + obj.scrollTop;
			} else {
				ObjX += 18 - obj.scrollTop;
			}
		}

		if (document.body.clientWidth < ObjY + 270 && ObjY > 280) {
			ObjY -= 268 - parseInt(OrgObj.style.width.replace("px", ""));
		}
		// 그리드 ID 초기화
		tmpGridID = "";
	}
	else {
		if (document.body.clientHeight < ObjX + 270 && ObjX > 280) {
			ObjX -= 263;
		} else {
			ObjX += 18;
		}

		if (document.body.clientWidth < ObjY + 270 && ObjY > 280) {
			ObjY -= 268 - parseInt(OrgObj.style.width.replace("px", ""));
		}
	}

	LayerObj.style.left = ObjY + "px";
	LayerObj.style.top = ObjX + "px";
	LayerObj.style.display = "block";
	setTimeout("CalViewCheck = 2;", 100);
};

// 월 데이터 반환
function getMonthValue(tmpMM) {
	for (var i = 0; i < Months.length; i++) {
		if (Months[i] == tmpMM) break;
	}
	if (i == 12) return tmpMM;
	else {
		var tmpRetVal;
		i++;
		if (i < 10) tmpRetVal = "0" + i;
		else tmpRetVal = i.toString();
		return tmpRetVal;
	}
};

// 날짜를 형식에 맞추어 변환
function getDateFormat(tmpY, tmpM, tmpD, strFormat) {
	if (strFormat == "MDY") {
		return Months[parseInt(tmpM, 10) - 1] + "-" + tmpD + "-" + tmpY;
	} else if (strFormat == "DMY") {
		return tmpD + "-" + Months[parseInt(tmpM, 10) - 1] + "-" + tmpY;
	} else {
		return tmpY + "-" + tmpM + "-" + tmpD;
	}
};

// 다음 월
function getNextMonth(tmpY, tmpM) {
	if (tmpM == "12") {
		tmpY = parseInt(tmpY, 10) + 1;
		tmpM = "01";
	} else tmpM = parseInt(tmpM, 10) + 1;
	if (parseInt(tmpM, 10) < 10) tmpM = "0" + parseInt(tmpM, 10).toString();
	return tmpY + "-" + tmpM;
};

// 이전월
function getPrevMonth(tmpY, tmpM) {
	if (tmpM == "01") {
		tmpY = parseInt(tmpY, 10) - 1;
		tmpM = "12";
	} else tmpM = parseInt(tmpM, 10) - 1;
	if (parseInt(tmpM, 10) < 10) tmpM = "0" + parseInt(tmpM, 10).toString();
	return tmpY + "-" + tmpM;
};

// 년 선택 달력
function SetCalendarYear(tmpYear) {
	frmCalendar.document.getElementById("SmallCal").style.display = 'block';
	frmCalendar.document.getElementById("FullCal").style.display = 'none';

	var sYear = parseInt(tmpYear, 10) - 9;
	var pYear = parseInt(tmpYear, 10) + 12;
	var nYear = parseInt(tmpYear, 10) - 12;
	var tmpHeader = sYear + " ~ " + (String)(sYear + 11);
	frmCalendar.document.getElementById("Cld_hm").innerHTML = tmpHeader;
    // 화살표 크기가 작음에 따른 수정 2017-09-06 장윤호
	//frmCalendar.document.getElementById("Cld_hl").innerHTML = "<img src='arrLeft.gif' border='0' onclick=\"parent.SetCalendarYear('" + nYear + "');\" style='cursor:pointer;'>";
	//frmCalendar.document.getElementById("Cld_hr").innerHTML = "<img src='arrRight.gif' border='0' onclick=\"parent.SetCalendarYear('" + pYear + "');\" style='cursor:pointer;'>";
	frmCalendar.document.getElementById("Cld_hl").innerHTML = "<span onclick=\"parent.SetCalendarYear('" + nYear + "');\" style='cursor:pointer;'>◀</span>";
	frmCalendar.document.getElementById("Cld_hr").innerHTML = "<span onclick=\"parent.SetCalendarYear('" + pYear + "');\" style='cursor:pointer;'>▶</span>";
	for (var i = 0; i < 12; i++) {
		if (sYear + i == tmpYear) {
			frmCalendar.document.getElementById("Cld_m" + (String)(i + 1)).innerHTML = "<font color='#9876FF'>" + (sYear + i) + "</font>";
			frmCalendar.document.getElementById("Cld_m" + (String)(i + 1)).tmpValue = sYear + i;
		} else {
			frmCalendar.document.getElementById("Cld_m" + (String)(i + 1)).innerHTML = sYear + i;
			frmCalendar.document.getElementById("Cld_m" + (String)(i + 1)).tmpValue = sYear + i;
		}
	}
	var tmpDate;
	var CurrDate = new Date();
	var CurrYear = CurrDate.getFullYear();
	var CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
	var CurrDate = (100 + CurrDate.getDate()).toString().substr(1);
	frmCalendar.document.getElementById("Cld_b").tmpValue = CurrYear;
	frmCalendar.document.getElementById("Cld_b").innerHTML = "Today : " + CurrYear + "-" + CurrMonth + "-" + CurrDate;
};

// 월 선택 달력
function SetCalendarMonth(tmpYM) {

	frmCalendar.document.getElementById("SmallCal").style.display = 'block';
	frmCalendar.document.getElementById("FullCal").style.display = 'none';

	var Months = new Array();
	Months[0] = "01";
	Months[1] = "02";
	Months[2] = "03";
	Months[3] = "04";
	Months[4] = "05";
	Months[5] = "06";
	Months[6] = "07";
	Months[7] = "08";
	Months[8] = "09";
	Months[9] = "10";
	Months[10] = "11";
	Months[11] = "12";
	var tmpDate;
	var CurrDate = new Date();
	var CurrYear = CurrDate.getFullYear();
	var CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
	var CurrDate = (100 + CurrDate.getDate()).toString().substr(1);

	var tmpYear = tmpYM.split("-")[0];
	var tmpMonth = tmpYM.split("-")[1];
	var tmpHeader = "<a onclick=\"parent.TargetMode2Month = '" + tmpMonth + "'; parent.SetCalendarYear('" + tmpYear + "');\" style='curosr:hand;'>" + tmpYear + "</a>";
	frmCalendar.document.getElementById("Cld_hm").innerHTML = tmpHeader;

	// 화살표 크기가 작음에 따른 수정 2017-09-06 장윤호
	//frmCalendar.document.getElementById("Cld_hl").innerHTML = "<img src='arrLeft.gif' border='0' onclick=\"parent.SetCalendarMonth('" + (String)(parseInt(tmpYear, 10) - 1) + "-" + tmpMonth + "');\" style='cursor:pointer;'>";
	//frmCalendar.document.getElementById("Cld_hr").innerHTML = "<img src='arrRight.gif' border='0' onclick=\"parent.SetCalendarMonth('" + (String)(parseInt(tmpYear, 10) + 1) + "-" + tmpMonth + "');\" style='cursor:pointer;'>";
	frmCalendar.document.getElementById("Cld_hl").innerHTML = "<span onclick=\"parent.SetCalendarMonth('" + (String)(parseInt(tmpYear, 10) - 1) + "-" + tmpMonth + "');\" style='cursor:pointer;'>◀</span>";
	frmCalendar.document.getElementById("Cld_hr").innerHTML = "<span onclick=\"parent.SetCalendarMonth('" + (String)(parseInt(tmpYear, 10) + 1) + "-" + tmpMonth + "');\" style='cursor:pointer;'>▶</span>";
	var tmpValue = "";
	//debugger;
	for (var i = 0; i < 12; i++) {
		if (i < 9) tmpValue = "0" + (String)(i + 1);
		else tmpValue = (String)(i + 1);
		if (CurrYear == tmpYear && i + 1 == CurrMonth) {
			frmCalendar.document.getElementById("Cld_m" + (String)(i + 1)).innerHTML = "<font color='#9876FF'>" + Months[i] + "</font>";
			frmCalendar.document.getElementById("Cld_m" + (String)(i + 1)).tmpValue = tmpYear + "-" + tmpValue;
			//frmCalendar.document.getElementById("Cld_m" + (String)(i + 1)).tmpValue = tmpYear + tmpValue;
		} else {
			frmCalendar.document.getElementById("Cld_m" + (String)(i + 1)).innerHTML = Months[i];
			frmCalendar.document.getElementById("Cld_m" + (String)(i + 1)).tmpValue = tmpYear + "-" + tmpValue;
			//frmCalendar.document.getElementById("Cld_m" + (String)(i + 1)).tmpValue = tmpYear + tmpValue;
		}
	}

	frmCalendar.document.getElementById("Cld_b").tmpValue = CurrYear + "-" + CurrMonth;
	frmCalendar.document.getElementById("Cld_b").innerHTML = "Today : " + CurrYear + "-" + CurrMonth + "-" + CurrDate;
};

// 일 선택 달력
function SetCalendarDate(tmpODate, strFormat) {
	//debugger;
	frmCalendar.document.getElementById("SmallCal").style.display = "none";
	frmCalendar.document.getElementById("FullCal").style.display = "block";

	var MDays = new Array();
	MDays[0] = 31;
	MDays[1] = 28;
	MDays[2] = 31;
	MDays[3] = 30;
	MDays[4] = 31;
	MDays[5] = 30;
	MDays[6] = 31;
	MDays[7] = 31;
	MDays[8] = 30;
	MDays[9] = 31;
	MDays[10] = 30;
	MDays[11] = 31;

	var tmpDate;
	var CurrDate = new Date();
	var CurrYear = CurrDate.getFullYear();

	// 윤년이 있을시 29일까지 표시
	//if (CurrYear % 4 == 0) MDays[1] = 29;

	var CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
	var CurrDay = (100 + CurrDate.getDate()).toString().substr(1);
	var tmpYear = tmpODate.split("-")[0];
	var tmpMonth = tmpODate.split("-")[1];
	var tmpDay = tmpODate.split("-")[2];

	var OrgObjValue = "";
	if (document.getElementById(document.getElementById("Calendar_Layer").TargetId) != null) {
        document.getElementById(document.getElementById("Calendar_Layer").TargetId).value;
    }
	var OrgYear = "", OrgMonth = "", OrgDay = "";
	if (OrgObjValue != "") {
		if (strFormat == "YMD") {
			OrgYear = OrgObjValue.split("-")[0];
			OrgMonth = OrgObjValue.split("-")[1];
			OrgDay = OrgObjValue.split("-")[2];
		} else if (strFormat == "MDY") {
			OrgYear = OrgObjValue.split("-")[2];
			OrgMonth = getMonthValue(OrgObjValue.split("-")[0]);
			OrgDay = OrgObjValue.split("-")[1];
		} else if (strFormat == "DMY") {
			OrgYear = OrgObjValue.split("-")[2];
			OrgMonth = getMonthValue(OrgObjValue.split("-")[1]);
			OrgDay = OrgObjValue.split("-")[0];
		}
	}

    // 윤년 체크 로직 수정 (2015-02-15)
    if (tmpYear % 400 == 0 || (tmpYear % 4 == 0 && tmpYear % 100 != 0)) {
	//if ((tmpYear % 4) == 0 && (tmpYear % 100) == 0 && (tmpYear % 400) != 0) {
		MDays[1] = 29;
	}

	var tmpDate4Day = new Date();
	tmpDate4Day.setMonth(parseInt(tmpMonth, 10) - 1);
	tmpDate4Day.setMonth(tmpMonth * 1 - 1);
	tmpDate4Day.setFullYear(tmpYear);
	tmpDate4Day.setDate(1);
	var SDay = tmpDate4Day.getDay();
	tmpDate4Day.setDate(MDays[parseInt(tmpMonth, 10) - 1]);
	//var EDay = tmpDate4Day.getDay();

	var tmpHeader = "<a onclick=\"parent.TargetMode2Date = '" + strFormat + "'; parent.TargetMode2Month = '" + tmpMonth + "'; parent.SetCalendarYear('" + tmpYear + "');\" style='curosr:hand;'>" + tmpYear + "</a><a onclick=\"parent.TargetMode2Date = '" + strFormat + "'; parent.SetCalendarMonth('" + tmpYear + "-" + tmpMonth + "');\" style='curosr:hand;'>" + Months[parseInt(tmpMonth, 10) - 1] + "</a>";
	frmCalendar.document.getElementById("Cld_hm").innerHTML = tmpHeader;

	var tmpPM = getPrevMonth(tmpYear, tmpMonth);
	var tmpNM = getNextMonth(tmpYear, tmpMonth);

	// 화살표 크기가 작음에 따른 수정 2017-09-06 장윤호
	//frmCalendar.document.getElementById("Cld_hl").innerHTML = "<img src='arrLeft.gif' border='0' onclick=\"parent.SetCalendarDate('" + tmpPM + "-01" + "', '" + strFormat + "');\" style='cursor:pointer;'>";
	frmCalendar.document.getElementById("Cld_hl").innerHTML = "<span onclick=\"parent.SetCalendarDate('" + tmpPM + "-01" + "', '" + strFormat + "');\" style='cursor:pointer;'>◀</span>";
	//frmCalendar.document.getElementById("Cld_hl").innerHTML = "<img src='arrLeft.gif' border='0' />";
	//frmCalendar.document.getElementById("Cld_hl").style.cursor = "pointer";
	//frmCalendar.document.getElementById("Cld_hl").onclick = function () { parent.SetCalendarDate(tmpPM + "-01", strFormat); };
	//frmCalendar.document.getElementById("Cld_hl").onmouseover = function () { this.style.backgroundColor = "white"; };
	//frmCalendar.document.getElementById("Cld_hl").onmouseout = function () { this.style.backgroundColor = ""; };

	//frmCalendar.document.getElementById("Cld_hr").innerHTML = "<img src='arrRight.gif' border='0' onclick=\"parent.SetCalendarDate('" + tmpNM + "-01" + "', '" + strFormat + "');\" style='cursor:pointer;'>";
	frmCalendar.document.getElementById("Cld_hr").innerHTML = "<span onclick=\"parent.SetCalendarDate('" + tmpNM + "-01" + "', '" + strFormat + "');\" style='cursor:pointer;'>▶</span>";
	//frmCalendar.document.getElementById("Cld_hr").innerHTML = "<img src='arrRight.gif' border='0' />";
	//frmCalendar.document.getElementById("Cld_hr").style.cursor = "pointer";
	//frmCalendar.document.getElementById("Cld_hr").onclick = function () { parent.SetCalendarDate(tmpNM + "-01", strFormat); };
	//frmCalendar.document.getElementById("Cld_hr").onmouseover = function () { this.style.backgroundColor = "white"; };
	//frmCalendar.document.getElementById("Cld_hr").onmouseout = function () { this.style.backgroundColor = ""; };

	var tmpValue = "";

	var tmpPPM = tmpPM.split("-");
	var tmpNNM = tmpNM.split("-");
	var tmpDivNum = 0, tmpDivStr = "";
	if (SDay == 0) SDay = 7;

	for (var i = 0; i < SDay; i++) {
		tmpDivNum = MDays[parseInt(tmpPPM[1], 10) - 1] - SDay + i + 1;
		if (tmpDivNum < 10) tmpDivStr = "0" + tmpDivNum;
		else tmpDivStr = tmpDivNum;
		frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).innerHTML = "<font color='#DDDDDD'>" + tmpDivNum + "</font>";
		frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).tmpFormat = strFormat;
		frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).tmpValue = getDateFormat(tmpPM.split("-")[0], tmpPM.split("-")[1], tmpDivStr, strFormat);
	}
	var tmpCntNum = 0;

	for (var i = SDay; i < SDay + MDays[parseInt(tmpMonth, 10) - 1]; i++) {
		var date = new Date(tmpYear, (tmpMonth - 1), (i - SDay + 1));

		if (i - SDay < 9) tmpValue = "0" + (String)(i - SDay + 1);
		else tmpValue = (String)(i - SDay + 1);
		if (CurrYear == tmpYear && tmpMonth == CurrMonth && CurrDay == i - SDay + 1) {
			frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).innerHTML = "<font color='#9876FF'>" + (i - SDay + 1) + "</font>";
			frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).tmpFormat = strFormat;
			frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).tmpValue = getDateFormat(tmpYear, tmpMonth, tmpValue, strFormat);
		} else if (OrgYear == tmpYear && OrgMonth == tmpMonth && OrgDay == i - SDay + 1) {
			frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).innerHTML = "<font color='#987654'>" + (i - SDay + 1) + "</font>";
			frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).tmpFormat = strFormat;
			frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).tmpValue = getDateFormat(tmpYear, tmpMonth, tmpValue, strFormat);
		} else {
			if (date.getDay() == 0 || holiday(getDateFormat(tmpYear, tmpMonth, tmpValue, strFormat).replace(/-/gi, ""))) frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).innerHTML = "<font color='#ff7373'>" + (i - SDay + 1) + "</font>";
			else if (date.getDay() == 6) frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).innerHTML = "<font color='#1973d2'>" + (i - SDay + 1) + "</font>";
			else frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).innerHTML = (i - SDay + 1);

			frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).tmpValue = getDateFormat(tmpYear, tmpMonth, tmpValue, strFormat);
			frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).tmpFormat = strFormat;
		}
		tmpCntNum = i + 1;
	}

	for (var i = tmpCntNum; i < 42; i++) {
		tmpDivNum = i - tmpCntNum + 1;
		if (tmpDivNum < 10) tmpDivStr = "0" + tmpDivNum;
		else tmpDivStr = tmpDivNum;
		frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).innerHTML = "<font color='#DDDDDD'>" + tmpDivNum + "</font>";
		frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).tmpFormat = strFormat;
		frmCalendar.document.getElementById("Cld_f" + (String)(i + 1)).tmpValue = getDateFormat(tmpNM.split("-")[0], tmpNM.split("-")[1], tmpDivStr, strFormat);
	}
	frmCalendar.document.getElementById("Cld_b").tmpValue = getDateFormat(CurrYear, CurrMonth, CurrDay, strFormat);
	frmCalendar.document.getElementById("Cld_b").tmpFormat = strFormat;
	frmCalendar.document.getElementById("Cld_b").innerHTML = "Today : " + CurrYear + "-" + CurrMonth + "-" + CurrDay;
};

// 입력선택
function SelectCalendar(tmpObj) {
	var hy_date = "";
	if (TargetMode2Month != "") {
		//월 선택창으로 이동
		SetCalendarMonth(tmpObj.tmpValue + "-01");
		TargetMode2Month = "";
	} else if (TargetMode2Date != "") {
		//일 선택창으로 이동
		SetCalendarDate(tmpObj.tmpValue + "-01", TargetMode2Date);
		TargetMode2Date = "";
	} else {
		var LayerObj = document.getElementById("Calendar_Layer");
		if (tmpObj.tmpFormat == "yyyymmdd" || tmpObj.tmpFormat == "yyyymm") {
			document.getElementById(LayerObj.TargetId).value = (tmpObj.tmpValue + "").replace(/-/ig, "");
			//		    if (document.getElementById(LayerObj.TargetId).getAttribute("OnCalendarChanged") && typeof (OnCalendarChanged) == 'function') {
			//		        OnCalendarChanged();
			//		    }
		}
		else {
			document.getElementById(LayerObj.TargetId).value = (tmpObj.tmpValue + "");//.replace(/-/ig, "");
			hy_date = (tmpObj.tmpValue + "");
			//			if (document.getElementById(LayerObj.TargetId).getAttribute("OnCalendarChanged") && typeof (OnCalendarChanged) == 'function') {
			//				OnCalendarChanged();
			//			}
		}
		LayerObj.style.display = "none";

		document.getElementById(LayerObj.TargetId).value = document.getElementById(LayerObj.TargetId).value;//.replace(/-/ig, "");

		//2017-02-15  "-" 삭제  김희섭
		//if (tmpObj.tmpFormat == "yyyy-mm-dd")
		//if (tmpObj.tmpFormat == "yyyy-mm-dd" || LayerObj.Mode == "yyyy-mm")
		//	document.getElementById(LayerObj.TargetId).value = hy_date;

		// 날짜 선택후 실행할 함수 
		try {
			//SelectedCalendar(tmpObj);
			SelectCalendarInGrid(document.getElementById(tmpObjId));
			SelectedCalendar(document.getElementById(tmpObjId));

		} catch (e) {
		}
		try {
			var event = $("#" + tmpObjId).attr("OnCalendarChanged");
			eval(event + "(" + document.getElementById(tmpObjId).value + ", \"" + tmpObjId + "\")");
		} catch (e) {
		}
	}
};

// 선택값 삭제
function CalendarClear(tmpObj) {
	// 입력된 값 삭제
	var LayerObj = document.getElementById("Calendar_Layer");
	document.getElementById(LayerObj.TargetId).value = ""; //.replace(/-/ig, "");
	LayerObj.style.display = "none";

	// 날짜 선택후 실행할 함수 
	try {
		//SelectedCalendar(tmpObj);
		SelectCalendarInGrid(document.getElementById(tmpObjId));
		SelectedCalendar(document.getElementById(tmpObjId));
	} catch (e) {
	}
	try {
		var event = $("#" + tmpObjId).attr("OnCalendarChanged");
		eval(event + "(" + document.getElementById(tmpObjId).value.replace(/-/gi, "") + ")");
	} catch (e) {
	}
}

// 달력 숨기기
function HideCalendar() {
	if (CalViewCheck == 2) {//alert(calendarObj.value);
		//document.body.click = function () { }
		var LayerObj = document.getElementById("Calendar_Layer");
		if (LayerObj.style.display == "block") {
			LayerObj.style.display = "none";
			CalViewCheck = 0;
			// 그리드 내부의 달력편집 수정
			SelectCalendarInGrid();
			return;
		}
	}
};

// 달력에 값을 설정한다.
function SetDateFormat(OrgDate, OrgFormat, TargetFormat) {
	if (OrgFormat == TargetFormat) {
		return OrgDate;
	} else if (OrgDate.split("-").length != 3) {
		return OrgDate;
	}
	var strDate = "", strTime = "";
	if (OrgDate.indexOf(' ') > 0) {
		var ValDateTime = OrgDate.split(" ");
		strDate = ValDateTime[0];
		for (var i = 1; i < ValDateTime.length; i++) {
			strTime += " " + ValDateTime[i];
		}
	} else {
		strDate = OrgDate;
	}
	var tmpVal = OrgDate.split("-");
	var tmpYear = "";
	var tmpMonth = "";
	var tmpDate = "";
	var retDate = "";
	if (OrgFormat == "mm-dd-yyyy") {
		tmpYear = tmpVal[2];
		tmpMonth = tmpVal[0];
		tmpDate = tmpVal[1];
		retDate = tmpMonth + "-" + tmpDate + "-" + tmpYear;
	} else if (OrgFormat == "dd-mm-yyyy") {
		tmpYear = tmpVal[2];
		tmpMonth = tmpVal[1];
		tmpDate = tmpVal[0];
		retDate = tmpDate + "-" + tmpMonth + "-" + tmpYear;
	} else {
		tmpYear = tmpVal[0];
		tmpMonth = tmpVal[1];
		tmpDate = tmpVal[2];
		retDate = tmpYear + "-" + tmpMonth + "-" + tmpDate;
	}

	if (strTime != "") retDate += strTime;
	return retDate;
};

// 음력날짜를 계산한다
var lunarMonthTable = [
[2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 5, 2, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],   /* 1901 */
[2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
[1, 2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2],
[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1],
[2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2],
[1, 2, 2, 4, 1, 2, 1, 2, 1, 2, 1, 2],
[1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
[2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
[1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
[2, 1, 2, 1, 1, 5, 1, 2, 2, 1, 2, 2],   /* 1911 */
[2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
[2, 2, 1, 2, 5, 1, 2, 1, 2, 1, 1, 2],
[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
[1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
[2, 3, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1],
[2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 5, 2, 2, 1, 2, 2],
[1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],
[2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],   /* 1921 */
[2, 1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 2],
[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2],
[2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
[2, 1, 2, 5, 2, 1, 2, 2, 1, 2, 1, 2],
[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
[1, 5, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2],
[1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],
[1, 2, 2, 1, 1, 5, 1, 2, 1, 2, 2, 1],
[2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1],   /* 1931 */
[2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
[1, 2, 2, 1, 6, 1, 2, 1, 2, 1, 1, 2],
[1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2],
[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 4, 1, 2, 1, 2, 1, 2, 2, 2, 1],
[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
[2, 2, 1, 1, 2, 1, 4, 1, 2, 2, 1, 2],
[2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2],
[2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
[2, 2, 1, 2, 2, 4, 1, 1, 2, 1, 2, 1],   /* 1941 */
[2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2],
[1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
[1, 1, 2, 4, 1, 2, 1, 2, 2, 1, 2, 2],
[1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
[2, 5, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
[2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
[2, 2, 1, 2, 1, 2, 3, 2, 1, 2, 1, 2],
[2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],
[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],   /* 1951 */
[1, 2, 1, 2, 4, 2, 1, 2, 1, 2, 1, 2],
[1, 2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2],
[1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
[2, 1, 4, 1, 1, 2, 1, 2, 1, 2, 2, 2],
[1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
[2, 1, 2, 1, 2, 1, 1, 5, 2, 1, 2, 2],
[1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],
[2, 1, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1],
[2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],   /* 1961 */
[1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2, 1],
[2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
[1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2],
[1, 2, 5, 2, 1, 1, 2, 1, 1, 2, 2, 1],
[2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2],
[1, 2, 2, 1, 2, 1, 5, 2, 1, 2, 1, 2],
[1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
[2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
[1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1, 2],   /* 1971 */
[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
[2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2, 1],
[2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1, 2],
[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
[2, 2, 1, 2, 1, 2, 1, 5, 2, 1, 1, 2],
[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1],
[2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
[2, 1, 1, 2, 1, 6, 1, 2, 2, 1, 2, 1],
[2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
[1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],   /* 1981 */
[2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2, 2],
[2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
[2, 1, 2, 2, 1, 1, 2, 1, 1, 5, 2, 2],
[1, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
[1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
[2, 1, 2, 2, 1, 5, 2, 2, 1, 2, 1, 2],
[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
[1, 2, 1, 1, 5, 1, 2, 1, 2, 2, 2, 2],
[1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2],   /* 1991 */
[1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
[1, 2, 5, 2, 1, 2, 1, 1, 2, 1, 2, 1],
[2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
[1, 2, 2, 1, 2, 2, 1, 5, 2, 1, 1, 2],
[1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 1, 2, 3, 2, 2, 1, 2, 2, 2, 1],
[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1],
[2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1],
[2, 2, 2, 3, 2, 1, 1, 2, 1, 2, 1, 2],   /* 2001 */
[2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
[2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2],
[1, 5, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
[1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1],
[2, 1, 2, 1, 2, 1, 5, 2, 2, 1, 2, 2],
[1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2],
[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
[2, 2, 1, 1, 5, 1, 2, 1, 2, 1, 2, 2],
[2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
[2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],   /* 2011 */
[2, 1, 6, 2, 1, 2, 1, 1, 2, 1, 2, 1],
[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2],
[1, 2, 1, 2, 1, 2, 1, 2, 5, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 1],
[2, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
[2, 1, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2],
[1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
[2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
[2, 1, 2, 5, 2, 1, 1, 2, 1, 2, 1, 2],
[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1],   /* 2021 */
[2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2],
[1, 5, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
[2, 1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1],
[2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
[1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2],
[1, 2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1],
[2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2],
[1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1],
[2, 1, 5, 2, 1, 2, 2, 1, 2, 1, 2, 1],   /* 2031 */
[2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 5, 2],
[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
[2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
[2, 2, 1, 2, 1, 4, 1, 1, 2, 2, 1, 2],
[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2],
[2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1],
[2, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1, 1],
[2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1],
[2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],   /* 2041 */
[1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
[1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2]];

function myDate(year, month, day, leapMonth) {
	this.year = year;
	this.month = month;
	this.day = day;
	this.leapMonth = leapMonth;
}

function lunarCalc(year, month, day, type, leapmonth) {
	var solYear, solMonth, solDay;
	var lunYear, lunMonth, lunDay;
	var lunLeapMonth, lunMonthDay;
	var i, lunIndex;

	var solMonthDay = [31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	/* range check */
	if (year < 1900 || year > 2040) {
		alert('1900년부터 2040년까지만 지원합니다');
		return;
	}

	/* 속도 개선을 위해 기준 일자를 여러개로 한다 */
	if (year >= 2000) {
		/* 기준일자 양력 2000년 1월 1일 (음력 1999년 11월 25일) */
		solYear = 2000;
		solMonth = 1;
		solDay = 1;
		lunYear = 1999;
		lunMonth = 11;
		lunDay = 25;
		lunLeapMonth = 0;

		solMonthDay[1] = 29;    /* 2000 년 2월 28일 */
		lunMonthDay = 30;   /* 1999년 11월 */
	}
	else if (year >= 1970) {
		/* 기준일자 양력 1970년 1월 1일 (음력 1969년 11월 24일) */
		solYear = 1970;
		solMonth = 1;
		solDay = 1;
		lunYear = 1969;
		lunMonth = 11;
		lunDay = 24;
		lunLeapMonth = 0;

		solMonthDay[1] = 28;    /* 1970 년 2월 28일 */
		lunMonthDay = 30;   /* 1969년 11월 */
	}
	else if (year >= 1940) {
		/* 기준일자 양력 1940년 1월 1일 (음력 1939년 11월 22일) */
		solYear = 1940;
		solMonth = 1;
		solDay = 1;
		lunYear = 1939;
		lunMonth = 11;
		lunDay = 22;
		lunLeapMonth = 0;

		solMonthDay[1] = 29;    /* 1940 년 2월 28일 */
		lunMonthDay = 29;   /* 1939년 11월 */
	}
	else {
		/* 기준일자 양력 1900년 1월 1일 (음력 1899년 12월 1일) */
		solYear = 1900;
		solMonth = 1;
		solDay = 1;
		lunYear = 1899;
		lunMonth = 12;
		lunDay = 1;
		lunLeapMonth = 0;

		solMonthDay[1] = 28;    /* 1900 년 2월 28일 */
		lunMonthDay = 30;   /* 1899년 12월 */
	}

	lunIndex = lunYear - 1899;

	while (true) {
		if (type == 1 &&
            year == solYear &&
            month == solMonth &&
            day == solDay) {
			return new myDate(lunYear, lunMonth, lunDay, lunLeapMonth);
		}

		else if (type == 2 &&
                year == lunYear &&
                month == lunMonth &&
                day == lunDay &&
                leapmonth == lunLeapMonth) {
			return new myDate(solYear, solMonth, solDay, 0);
		}
		/* add a day of solar calendar */
		if (solMonth == 12 && solDay == 31) {
			solYear++;
			solMonth = 1;
			solDay = 1;

			/* set monthDay of Feb */
			if (solYear % 400 == 0)
				solMonthDay[1] = 29;
			else if (solYear % 100 == 0)
				solMonthDay[1] = 28;
			else if (solYear % 4 == 0)
				solMonthDay[1] = 29;
			else
				solMonthDay[1] = 28;

		}
		else if (solMonthDay[solMonth - 1] == solDay) {
			solMonth++;
			solDay = 1;
		}
		else
			solDay++;

		/* add a day of lunar calendar */
		if (lunMonth == 12 &&
            ((lunarMonthTable[lunIndex][lunMonth - 1] == 1 && lunDay == 29) ||
            (lunarMonthTable[lunIndex][lunMonth - 1] == 2 && lunDay == 30))) {
			lunYear++;
			lunMonth = 1;
			lunDay = 1;

			if (lunYear > 2043) {
				alert("입력하신 달은 없습니다.");
				break;
			}

			lunIndex = lunYear - 1899;

			if (lunarMonthTable[lunIndex][lunMonth - 1] == 1)
				lunMonthDay = 29;
			else if (lunarMonthTable[lunIndex][lunMonth - 1] == 2)
				lunMonthDay = 30;
		}
		else if (lunDay == lunMonthDay) {
			if (lunarMonthTable[lunIndex][lunMonth - 1] >= 3
                && lunLeapMonth == 0) {
				lunDay = 1;
				lunLeapMonth = 1;
			}
			else {
				lunMonth++;
				lunDay = 1;
				lunLeapMonth = 0;
			}

			if (lunarMonthTable[lunIndex][lunMonth - 1] == 1)
				lunMonthDay = 29;
			else if (lunarMonthTable[lunIndex][lunMonth - 1] == 2)
				lunMonthDay = 30;
			else if (lunarMonthTable[lunIndex][lunMonth - 1] == 3)
				lunMonthDay = 29;
			else if (lunarMonthTable[lunIndex][lunMonth - 1] == 4 &&
                    lunLeapMonth == 0)
				lunMonthDay = 29;
			else if (lunarMonthTable[lunIndex][lunMonth - 1] == 4 &&
                    lunLeapMonth == 1)
				lunMonthDay = 30;
			else if (lunarMonthTable[lunIndex][lunMonth - 1] == 5 &&
                    lunLeapMonth == 0)
				lunMonthDay = 30;
			else if (lunarMonthTable[lunIndex][lunMonth - 1] == 5 &&
                    lunLeapMonth == 1)
				lunMonthDay = 29;
			else if (lunarMonthTable[lunIndex][lunMonth - 1] == 6)
				lunMonthDay = 30;
		}
		else
			lunDay++;
	}
}

function dayCalcDisplay(startYear, startMonth, startDay) {
	if (!startYear || startYear == 0 ||
         !startMonth || startMonth == 0 ||
         !startDay || startDay == 0) {
		alert('날짜를 입력해주세요');
		return;
	}

	var solMonthDay = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	if (startYear % 400 == 0 || (startYear % 4 == 0 && startYear % 100 != 0)) solMonthDay[1] += 1;


	if (startMonth < 1 || startMonth > 12 ||
         startDay < 1 || startDay > solMonthDay[startMonth - 1]) {
		if (solMonthDay[1] == 28 && startMonth == 2 && startDay > 28)
			alert("윤년이 아닙니다. 다시 입력해주세요");
		else
			alert("날짜 범위를 벗어났습니다. 다시 입력해주세요");
		return;
	}

	var startDate = new Date(startYear, startMonth - 1, startDay);

	/* 양력/음력 변환 */
	var date = lunarCalc(startYear, startMonth, startDay, 1);

	return (date.month.toString().length < 2 ? "0" + date.month : date.month) + "" + (date.day.toString().length < 2 ? "0" + date.day : date.day);
}

//공휴일인지 체크한다. (필요시 해당부분 DB화 처리)
function holiday(date) {
	var solar_cal = ["0101", "0301", "0505", "0606", "0815", "1003", "1225"];
	var lunar_cal = ["1230", "0101", "0102", "0408", "0814", "0815", "0816"];
	var return_data = false;
	var solar_date = date.toString().substr(4, 2) + "" + date.toString().substr(6, 2);
	var lunar_date = dayCalcDisplay(date.toString().substr(0, 4), date.toString().substr(4, 2), date.toString().substr(6, 2));

	for (var i = 0; i < solar_cal.length; i++) {
		if (solar_cal[i] == solar_date) {
			return true;
		}
		else if (lunar_cal[i] == lunar_date) return true;
	}
}

/************************************************************************************************************************/
/******************************************* 로케일 설정으로 인한 달력 컨트롤 개선 *******************************************/
/************************************************************************************************************************/
function GetCultureCode(langCode) {
    // 1. 연도-월-일 순으로 표기하는 국가들 (예) 2008년 6월 28일 = 2008-06-28
    // 한국, 중국, 대만, 마카오, 일본, 몽골, 중동, 네팔, 덴마크, 헝가리, 라트비아, 리투아니아, 스웨덴,남아프리카 공화국, 캐나다(다른 표기방식들도 사용)
    // 
    // 2. 월-일-연도 순으로 표기하는 국가들 (예) 2008년 6월 28일 = 06/28/08
    // 미국, 캐나다(단, 대부분의 공식 문서에는 연도-월-일로 표기), 미크로네시아 연방공화국, 팔라우, 필리핀
    // 
    // 3. 일-월-연도 순으로 표기하는 국가들 (예) 2008년 6월 28일 = 28/06/2008
    // 가이아나, 그레나다, 그루지야, 그리스, 네덜란드, 노르웨이, 뉴질랜드, 덴마크, 도미니카 공화국, 도미니카 연방, 독일, 라트비아, 러시아, 리비아, 마카오, 말레이시아, 멕스코, 몬테네그로, 바베이도스, 방글라데시, 벨기에, 베네주엘라, 베트남, 벨로루시,벨리즈, 볼리비아, 불가리아, 브라질, 사우디 아라비아 (주요 기업들의 경우 미국 방식으로 월/일/연도 표기를 따름), 세르비아, 세인트 빈센트 그레나딘, 세인트 루시아, 세인트 키츠 네비스, 스페인, 스위스, 스웨덴(연도-월-일 방식이 더 자주 쓰임), 슬로바키아, 슬로베니아, 싱가포르, 아르메니아, 아르헨티나, 아일랜드, 알바니아, 아이슬란드, 아제르바이잔, 영국, 에스토니아, 에콰도르, 엘 살바도르, 오스트리아, 우크라이나,우루과이, 우즈베키스탄, 요르단, 이라크, 이란, 이스라엘, 이집트, 이탈리아, 인도, 인도네시아, 자메이카, 체코, 칠레, 카자흐스탄, 캐나다(다른 표기방식들도 사용), 케냐, 콜롬비아, 크로아티아, 키르기즈스탄, 키프로스, 타지키스탄, 태국, 트리니다드 토바고 공화국, 터키, 투르키메니스탄, 파나마, 파라과이, 파키스탄, 페루, 포르투갈, 폴란드,푸에토리코, 프랑스, 핀란드, 필리핀, 호주, 홍콩

    langCode = langCode.toLowerCase();

    if (langCode == "ko" || langCode == "zh" || langCode == "ja" || langCode == "da" || langCode == "hu" || langCode == "sv" || langCode == "cn" || langCode == "us" || langCode == "jp") { // 한국어,중국어,일본어,덴마크어,헝가리어 * 캐나다 및 미국(영어)은 mm/dd/yyyy로함
        return "ymd";
    }
    else if (langCode == "en") { // 영국은 dd/mm/yyyy 이지만 언어코드 문제로 인하여 미국쪽을 사용해야함
        return "ymd";
    }
    else {
        return "dmy";
    }
}

// 날짜 형식을 국가별로 변경
function GetCalendarCulture(strDate, langCode) {

    var cultureType = GetCultureCode(langCode);

    // ymd형식의 데이터일시 그대로 리턴
    if (cultureType == "ymd") {
        return strDate;
    }

    var calDate = strDate.split('-');
    if (calDate.length == 1) {
        if (strDate.length == 6) {
            return strDate.substring(4, 6) + "/" + strDate.substring(0, 4);
        }
        else if (strDate.length == 8 && cultureType == "mdy") {
            return strDate.substring(4, 6) + "/" + strDate.substring(6, 8) + "/" + strDate.substring(0, 4);
        }
        else if (strDate.length == 8 && cultureType == "dmy") {
            return strDate.substring(6, 8) + "/" + strDate.substring(4, 6) + "/" + strDate.substring(0, 4);
        }
        else {
            return strDate;
        }
    }
    // 입력된 날짜가 년-월일경우
    if (calDate.length == 2) {
        return calDate[1] + "/" + calDate[0];
    }
    else {
        // 3자리일경우
        if (cultureType == "mdy") {
            return calDate[1] + "/" + calDate[2] + "/" + calDate[0];
        }
        else {
            return calDate[2] + "/" + calDate[1] + "/" + calDate[0];
        }
    }
}

function ConvertCalendarCulture(strDate, langCode) {
    var cultureType = GetCultureCode(langCode);
    if (cultureType == "ymd") {
        //return strDate.replace(/-/gi, "");
        return strDate;
    }
    var calDate = strDate.split('/');
    if (calDate.length == 2) {
        return (calDate[1] + "-" + calDate[0]).replace(/-/gi, "");
    }
    else if (calDate.length == 1) {
        return strDate.replace(/-/gi, "");
    }
    else {
        // 3자리일경우
        if (cultureType == "mdy") {
            return (calDate[2] + "-" + calDate[0] + "-" + calDate[1]).replace(/-/gi, "");
        }
        else {
            return (calDate[2] + "-" + calDate[1] + "-" + calDate[0]).replace(/-/gi, "");
        }
    }
}

// 날짜 형식을 국가별로 변경
function GetDateTimeCulture(strDate, langCode) {
    strDate = new String(strDate);
    var cultureType = GetCultureCode(langCode);
    var _tmpDate = strDate.split(' ');

    if (_tmpDate.length == 1) {
        if (_tmpDate[0].indexOf(':') >= 0) {
            return _tmpDate[0];
        }
        else {
            return GetCalendarCulture(_tmpDate[0], langCode);
        }
    }
    else {
        return GetCalendarCulture(_tmpDate[0], langCode) + " " + _tmpDate[1];
    }
}

function GetNumberFromLocaleString(strData, langCode) {
    langCode = langCode.toLowerCase();
    var _commaRegion = "ko;kr;cn;zh;jp;au;us;en;gb;mx";   //한국;한국;중국;중국;일본;호주;미국;미국;영국;멕시코 

    if (langCode == "ch") { // 스위스일 경우 ' 로 숫자 구분
        strData = strData.replace(/'/gi, '');
    }
    else if (_commaRegion.indexOf(langCode) >= 0) { // 한국,중국,일본,호주,미국,영국,멕시코 는 , 로 숫자 구분
        strData = strData.replace(/,/gi, '');
    }
    else {  // 그이외의 유럽 및 남미 지역은 . 로 숫자 구분
        strData = strData.replace(/\./gi, '').replace(/,/gi, '.');
    }

    return isNaN(Number(strData)) ? null : Number(strData);
}

function GetNumberLocale(strData, langCode) {
    if (strData == "" || strData == null || strData == undefined || strData == "NaN") return "";
    langCode = langCode.toLowerCase();
    var _commaRegion = "ko;kr;cn;zh;jp;au;us;en;gb;mx";   //한국;한국;중국;중국;일본;호주;미국;미국;영국;멕시코

    var arrData = new String(strData).split('.');
    var splitChar = ',';
    var floatChar = '.';

    if (langCode == "ch") { // 스위스일 경우 ' 로 숫자 구분
        var splitChar = "'";
        var floatChar = ".";
        langCode = "de-ch";
    }
    else if (_commaRegion.indexOf(langCode) >= 0) { // 한국,중국,일본,호주,미국,영국,멕시코 는 , 로 숫자 구분
        var splitChar = ",";
        var floatChar = ".";
    }
    else {  // 그이외의 유럽 및 남미 지역은 . 로 숫자 구분
        var splitChar = ".";
        var floatChar = ",";
    }

    return Number(arrData[0]).toLocaleString(langCode) + (arrData.length > 1 ? floatChar + arrData[1] : "");
}
/************************************************************************************************************************/

/*********************************************************************************************************************************
* Multiple Datepikcer
* 다중 일자 입력 컨트롤
* 장경환 (2016-04-07 추가)
*********************************************************************************************************************************/
var _mon_en = ["Jan.", "Feb.", "Mar.", "Apr.", "May.", "June.", "July.", "Aug.", "Sept.", "Oct.", "Nov.", "Dec."];
var _mon_us = ["Jan.", "Feb.", "Mar.", "Apr.", "May.", "June.", "July.", "Aug.", "Sept.", "Oct.", "Nov.", "Dec."];
var _mon_es = ["enero", "feb.", "marzo", "abr.", "mayo", "jun.", "jul.", "agosto", "sept.", "oct.", "nov.", "dic."];
var _mon_ko = ["Jan.", "Feb.", "Mar.", "Apr.", "May.", "June.", "July.", "Aug.", "Sept.", "Oct.", "Nov.", "Dec."];
var _mon_cn = ["Jan.", "Feb.", "Mar.", "Apr.", "May.", "June.", "July.", "Aug.", "Sept.", "Oct.", "Nov.", "Dec."];
var _mon_mx = ["enero", "feb.", "marzo", "abr.", "mayo", "jun.", "jul.", "agosto", "sept.", "oct.", "nov.", "dic."];

// 달력 시작 (입력 텍스트, 날자 표시모드, 그룹, 레이어 위치)
function ShowCalendar_FT(OrgObj, strMode, grp, positionObj) {
    // 열려있는 calendar가 있을시 닫음
    if (CalViewCheck == "2") HideCalendar();
    // 숫자만 입력 이벤트 추가
    $(OrgObj).unbind("keypress", CalendarKeyPress);
    $(OrgObj).bind("keypress", CalendarKeyPress);
    // maxlangth 지정
    OrgObj.maxLength = 10;
    // 입력수 날자변환
    calendarObj = OrgObj;

    $(OrgObj).unbind("blur", CalendarBlur);
    $(OrgObj).bind("blur", CalendarBlur);

    document.getElementById("frmCalendar_FT").style.display = "block";
    document.getElementById("frmCalendar").style.display = "none";

    CalViewCheck = 1;
    TargetMode2Date = "";
    TargetMode2Month = "";

    var grp_cnt = $(OrgObj.tagName + "[group='" + grp + "']").length;

    var LayerObj = document.getElementById("Calendar_Layer");
    if (LayerObj.style.display == "block") {
        if (tmpObjId == OrgObj.id) {
            LayerObj.style.display = "none";
            CalViewCheck = false;
            return;
        }
    }

    tmpObjId = OrgObj.id;

    var tmpHtml = "";
    var CurrVal = OrgObj.value;

    LayerObj.TargetId = OrgObj.id;
    LayerObj.Mode = strMode;

    var tmpDate;
    var CurrDate = new Date();
    var CurrYear;
    var CurrMonth;
    var CurrDay;

    var _currYear = CurrDate.getFullYear();
    var _currMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
    var _currDay = CurrDate.getDate();

    if (strMode == "") strMode = "yyyy-mm";
    if (CurrVal == "") {
        CurrYear = CurrDate.getFullYear();
        CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
        CurrDay = CurrDate.getDate();
    }
    else {
        if (strMode == "yyyy") {
            //yyyy
            if (OrgObj.value.length == 4 && parseInt(OrgObj.value, 10) > 0 && parseInt(OrgObj.value, 10) < 3000) {
                CurrYear = OrgObj.value;
            }
            else {
                CurrYear = CurrDate.getFullYear();
            }
        }
        else if (strMode == "yyyy-mm") {
            //yyyy-mm
            if (OrgObj.value.length == 7 && OrgObj.value.indexOf("-") > 0) {
                CurrYear = OrgObj.value.split("-")[0];
                CurrMonth = OrgObj.value.split("-")[1];
            }
            else {
                CurrYear = CurrDate.getFullYear();
                CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
            }
        }
        else if (strMode == "yyyymm") {
            //yyyy-mm
            if (OrgObj.value.length == 6) {
                CurrYear = OrgObj.value.substr(0, 4);
                CurrMonth = OrgObj.value.substr(4, 2);
            }
            else {
                CurrYear = CurrDate.getFullYear();
                CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
            }
        }
        else if (strMode == "yyyy-mm-dd") {
            //yyyy-mm-dd
            if (OrgObj.value.length == 10 && OrgObj.value.indexOf("-") > 0) {
                CurrYear = OrgObj.value.split("-")[0];
                CurrMonth = OrgObj.value.split("-")[1];
                CurrDay = OrgObj.value.split("-")[2];
            }
            else {
                CurrYear = CurrDate.getFullYear();
                CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
                CurrDay = (100 + CurrDate.getDate()).toString().substr(1);
            }
        }
        else if (strMode == "yyyymmdd") {
            //yyyy-mm-dd
            if (OrgObj.value.length == 8) {
                CurrYear = OrgObj.value.substr(0, 4);
                CurrMonth = OrgObj.value.substr(4, 2);
                CurrDay = OrgObj.value.substr(6, 2);
            }
            else {
                CurrYear = CurrDate.getFullYear();
                CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
                CurrDay = (100 + CurrDate.getDate()).toString().substr(1);
            }
        }
        else if (strMode == "mm-dd-yyyy") {
            //mm-dd-yyyy
            if ((OrgObj.value.length == 10 || OrgObj.value.length == 11) && OrgObj.value.indexOf("-") > 0) {
                CurrYear = OrgObj.value.split("-")[2];
                CurrMonth = getMonthValue(OrgObj.value.split("-")[0]);
                CurrDay = OrgObj.value.split("-")[1];
            }
            else {
                CurrYear = CurrDate.getFullYear();
                CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
                CurrDay = (100 + CurrDate.getDate()).toString().substr(1);
            }
        }
        else if (strMode == "dd-mm-yyyy") {
            //dd-mm-yyyy
            if ((OrgObj.value.length == 10 || OrgObj.value.length == 11) && OrgObj.value.indexOf("-") > 0) {
                CurrYear = OrgObj.value.split("-")[2];
                CurrMonth = getMonthValue(OrgObj.value.split("-")[1]);
                CurrDay = OrgObj.value.split("-")[0];
            }
            else {
                CurrYear = CurrDate.getFullYear();
                CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
                CurrDay = (100 + CurrDate.getDate()).toString().substr(1);
            }
        }
        else {
            return;
        }
    }

    var _btm = frmCalendar_FT.document.getElementById("Cld_bt");

    if (strMode == "yyyy") {
        //yyyy
        SetCalendarYear_FT(CurrYear);
        $(_btm).attr("onclick", "parent.SetCalendarYear_FT('" + _currYear + "');");
    }
    else if (strMode == "yyyy-mm") {
        //yyyy-mm
        SetCalendarMonth_FT(CurrYear + "-" + CurrMonth);
        $(_btm).attr("onclick", "parent.SetCalendarMonth_FT('" + _currYear + "-" + _currMonth + "');");
    }
    else if (strMode == "yyyymm") {
        //yyyy-mm
        SetCalendarMonth_FT(CurrYear + "-" + CurrMonth);
        $(_btm).attr("onclick", "parent.SetCalendarMonth_FT('" + _currYear + "-" + _currMonth + "');");
    }
    else if (strMode == "yyyy-mm-dd") {
        SetCalendarDate_FT(CurrYear + "-" + CurrMonth + "-" + CurrDay, strMode, grp_cnt);
        $(_btm).attr("onclick", "parent.SetCalendarDate_FT('" + _currYear + "-" + _currMonth + "-" + _currDay + "', '" + strMode + "', '" + grp_cnt + "');");
    }
    else if (strMode == "yyyymmdd") {
        SetCalendarDate_FT(CurrYear + "-" + CurrMonth + "-" + CurrDay, strMode, grp_cnt);
        $(_btm).attr("onclick", "parent.SetCalendarDate_FT('" + _currYear + "-" + _currMonth + "-" + _currDay + "', '" + strMode + "', '" + grp_cnt + "');");
    }
    else if (strMode == "mm-dd-yyyy") {
        SetCalendarDate_FT(CurrYear + "-" + CurrMonth + "-" + CurrDay, strMode, grp_cnt);
        $(_btm).attr("onclick", "parent.SetCalendarDate_FT('" + _currYear + "-" + _currMonth + "-" + _currDay + "', '" + strMode + "', '" + grp_cnt + "');");
    }
    else if (strMode == "dd-mm-yyyy") {
        SetCalendarDate_FT(CurrYear + "-" + CurrMonth + "-" + CurrDay, strMode, grp_cnt);
        $(_btm).attr("onclick", "parent.SetCalendarDate_FT('" + _currYear + "-" + _currMonth + "-" + _currDay + "', '" + strMode + "', '" + grp_cnt + "');");
    }

    var ObjX;
    var ObjY;
    try {
        ObjX = GetObjTop(OrgObj);
        ObjY = GetObjLeft(OrgObj);

    } catch (e) {
        HideCalendar();
    }
    // 띄울 객체가 존재시
    if (positionObj != undefined) {//debugger;
        ObjX = GetObjTop(positionObj);
        ObjY = GetObjLeft(positionObj);
    }

    if (document.getElementById("sub_popup_left_content")) {
        if (document.body.clientHeight < ObjX + 170 - document.getElementById("sub_popup_left_content").scrollTop && ObjX > 180 - document.getElementById("sub_popup_left_content").scrollTop) {
            ObjX -= 163 + document.getElementById("sub_popup_left_content").scrollTop;
        } else {
            ObjX += 18 - document.getElementById("sub_popup_left_content").scrollTop;
        }

        if (document.body.clientWidth < ObjY + 170 && ObjY > 180) {
            ObjY -= 168 - parseInt(OrgObj.style.width.replace("px", ""));
        }
    }
    else if (document.getElementById("documentScrollBody")) {
        if (document.body.clientHeight < ObjX + 170 - document.getElementById("documentScrollBody").scrollTop && ObjX > 180 - document.getElementById("documentScrollBody").scrollTop) {
            ObjX -= 163 + document.getElementById("documentScrollBody").scrollTop;
        } else {
            ObjX += 18 - document.getElementById("documentScrollBody").scrollTop;
        }

        if (document.body.clientWidth < ObjY + 170 && ObjY > 180) {
            ObjY -= 168 - parseInt(OrgObj.style.width.replace("px", ""));
        }
    }
    else if (IsPopup && tmpGridID != "") { // 달력이 팝업이고 그리드 안에 위치할시
        var obj = $("#" + tmpGridID + "_main .JINSheet_ScrollBodyHeight")[0];
        if (obj) {
            if (document.body.clientHeight < ObjX + 170 - obj.scrollTop && ObjX > 180 - obj.scrollTop) {
                ObjX -= 163 + obj.scrollTop;
            } else {
                ObjX += 18 - obj.scrollTop;
            }
        }

        if (document.body.clientWidth < ObjY + 170 && ObjY > 180) {
            ObjY -= 168 - parseInt(OrgObj.style.width.replace("px", ""));
        }
        // 그리드 ID 초기화
        tmpGridID = "";
    }
    else {
        if (document.body.clientHeight < ObjX + 170 && ObjX > 180) {
            ObjX -= 163;
        } else {
            ObjX += 18;
        }

        if (document.body.clientWidth < ObjY + 170 && ObjY > 180) {
            ObjY -= 168 - parseInt(OrgObj.style.width.replace("px", ""));
        }
    }

    LayerObj.style.left = ObjY + "px";
    LayerObj.style.top = ObjX + "px";
    LayerObj.style.display = "block";
    setTimeout("CalViewCheck = 2;", 100);
    LayerObj.style.width = "660px";
};


// 다음 월
function getNextMonth_FT(tmpY, tmpM) {
    var d = new Date(parseInt(tmpY, 10), parseInt(tmpM, 10) - 1, 1);
    d.setMonth(d.getMonth() + 2);
    return d.yyyy_mm_dd().substr(0, 7);
};

// 이전월
function getPrevMonth_FT(tmpY, tmpM) {
    var d = new Date(parseInt(tmpY, 10), parseInt(tmpM, 10) - 1, 1);
    d.setMonth(d.getMonth() - 2);
    return d.yyyy_mm_dd().substr(0, 7);
};

function SetCalendarDate_FT(tmpODate, strFormat, grpCnt) {
    //debugger;
    frmCalendar_FT.document.getElementById("SmallCal0").style.display = "none";
    frmCalendar_FT.document.getElementById("FullCal0").style.display = "block";
    frmCalendar_FT.document.getElementById("SmallCal1").style.display = "none";
    frmCalendar_FT.document.getElementById("FullCal1").style.display = "block";

    if (grpCnt != null && grpCnt != undefined)
        frmCalendar_FT.document.getElementById("Cld_cnt").innerText = grpCnt;

    var MDays = new Array();
    MDays[0] = 31;
    MDays[1] = 28;
    MDays[2] = 31;
    MDays[3] = 30;
    MDays[4] = 31;
    MDays[5] = 30;
    MDays[6] = 31;
    MDays[7] = 31;
    MDays[8] = 30;
    MDays[9] = 31;
    MDays[10] = 30;
    MDays[11] = 31;

    var tmpDate;
    var CurrDate = new Date();
    var CurrYear = CurrDate.getFullYear();
    var CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
    var CurrDay = (100 + CurrDate.getDate()).toString().substr(1);
    var tmpYear = tmpODate.split("-")[0];
    var tmpMonth = tmpODate.split("-")[1];
    var tmpDay = tmpODate.split("-")[2];

    // 윤년이 있을시 29일까지 표시 2016-02-03 추가
    //if (CurrYear % 4 == 0) MDays[1] = 29;

    if (strFormat == "") {
        strFormat = document.getElementById("Calendar_Layer").Mode;
    }

    var OrgObjValue = document.getElementById(document.getElementById("Calendar_Layer").TargetId).value;
    var OrgYear = "", OrgMonth = "", OrgDay = "";
    if (OrgObjValue != "") {
        if (strFormat == "YMD") {
            OrgYear = OrgObjValue.split("-")[0];
            OrgMonth = OrgObjValue.split("-")[1];
            OrgDay = OrgObjValue.split("-")[2];
        } else if (strFormat == "MDY") {
            OrgYear = OrgObjValue.split("-")[2];
            OrgMonth = getMonthValue(OrgObjValue.split("-")[0]);
            OrgDay = OrgObjValue.split("-")[1];
        } else if (strFormat == "DMY") {
            OrgYear = OrgObjValue.split("-")[2];
            OrgMonth = getMonthValue(OrgObjValue.split("-")[1]);
            OrgDay = OrgObjValue.split("-")[0];
        }
    }


    var tmpPM = getPrevMonth_FT(tmpYear, tmpMonth);
    var tmpNM = getNextMonth_FT(tmpYear, tmpMonth);

    frmCalendar_FT.document.getElementById("Cld_hl").innerHTML = "<a onclick = 'parent.SetCalendarDate_FT( \"" + tmpPM + "-01" + "\"  , \"" + strFormat + "\" );'>◀</a>";
    frmCalendar_FT.document.getElementById("Cld_hl").style.cursor = "pointer";
    //frmCalendar_FT.document.getElementById("Cld_hl").onclick = function () { parent.SetCalendarDate_FT(tmpPM + "-01", strFormat); };
    frmCalendar_FT.document.getElementById("Cld_hl").onmouseover = function () { this.style.backgroundColor = "white"; };
    frmCalendar_FT.document.getElementById("Cld_hl").onmouseout = function () { this.style.backgroundColor = ""; };

    frmCalendar_FT.document.getElementById("Cld_hr").innerHTML = "<a onclick = 'parent.SetCalendarDate_FT( \"" + tmpNM + "-01" + "\"  , \"" + strFormat + "\" );'>▶</a>";
    frmCalendar_FT.document.getElementById("Cld_hr").style.cursor = "pointer";
    //frmCalendar_FT.document.getElementById("Cld_hr").onclick = function () { parent.SetCalendarDate_FT(tmpNM + "-01", strFormat); };
    frmCalendar_FT.document.getElementById("Cld_hr").onmouseover = function () { this.style.backgroundColor = "white"; };
    frmCalendar_FT.document.getElementById("Cld_hr").onmouseout = function () { this.style.backgroundColor = ""; };

    var tmpValue = "";

    var tmpPPM = getPrevMonth(tmpYear, tmpMonth).split("-");
    var tmpNNM = getNextMonth(tmpYear, tmpMonth).split("-");
    var tmpDivNum = 0, tmpDivStr = "";


    for (var idx = 0; idx < 2; idx++) {
        var d = new Date(tmpYear, tmpMonth * 1 - 1, tmpDay);
        d.setMonth(d.getMonth() + idx);

        tmpYear = d.yyyy_mm_dd().split('-')[0];
        tmpMonth = d.yyyy_mm_dd().split('-')[1];
        tmpDay = d.yyyy_mm_dd().split('-')[2];

        var tmpHeader = "<a onclick=\"parent.TargetMode2Date = '" + strFormat + "'; parent.TargetMode2Month = '" + tmpMonth + "'; parent.SetCalendarYear_FT('" + tmpYear + "');\" style='curosr:hand;'>" + tmpYear + "</a><a onclick=\"parent.TargetMode2Date = '" + strFormat + "'; parent.SetCalendarMonth_FT('" + tmpYear + "-" + tmpMonth + "');\" style='curosr:hand;'>" + Months[parseInt(tmpMonth, 10) - 1] + "</a>";
        frmCalendar_FT.document.getElementById("Cld_hm" + idx).innerHTML = tmpHeader;

        var tmpDate4Day = new Date();
        tmpDate4Day.setMonth(parseInt(tmpMonth, 10) - 1);
        tmpDate4Day.setMonth(tmpMonth * 1 - 1);
        tmpDate4Day.setFullYear(tmpYear);
        tmpDate4Day.setDate(1);
        var SDay = tmpDate4Day.getDay();
        tmpDate4Day.setDate(MDays[parseInt(tmpMonth, 10) - 1]);

        //if (SDay == 0) SDay = 7;

        // 윤년 체크 로직 수정 (2015-02-15)
        if (tmpYear % 400 == 0 || (tmpYear % 4 == 0 && tmpYear % 100 != 0)) {
            MDays[1] = 29;
        }

        for (var i = 0; i < SDay; i++) {
            var _objCell = frmCalendar_FT.document.getElementById("Cld_f" + (String)(idx) + (String)(i + 1));
            _objCell.tmpValue = ""
            _objCell.innerHTML = "";
            _objCell.style.cursor = "default";
            _objCell.style.border = "1px solid #FFFFFF";
            _objCell.style.background = "#FFFFFF"
        }
        var tmpCntNum = 0;

        for (var i = SDay; i < SDay + MDays[parseInt(tmpMonth, 10) - 1]; i++) {
            var date = new Date(tmpYear, (tmpMonth - 1), (i - SDay + 1));
            var _objCell = frmCalendar_FT.document.getElementById("Cld_f" + (String)(idx) + (String)(i + 1));

            if (i - SDay < 9)
                tmpValue = "0" + (String)(i - SDay + 1);
            else
                tmpValue = (String)(i - SDay + 1);

            if (CurrYear == tmpYear && tmpMonth == CurrMonth && CurrDay == i - SDay + 1) {
                _objCell.innerHTML = "<font color='#9876FF'>" + (i - SDay + 1) + "</font>";
                _objCell.tmpFormat = strFormat;
            } else if (OrgYear == tmpYear && OrgMonth == tmpMonth && OrgDay == i - SDay + 1) {
                _objCell.innerHTML = "<font color='#987654'>" + (i - SDay + 1) + "</font>";
                _objCell.tmpFormat = strFormat;
            } else {
                if (date.getDay() == 0 || holiday(getDateFormat(tmpYear, tmpMonth, tmpValue, strFormat).replace(/-/gi, "")))
                    _objCell.innerHTML = "<font color='#ff7373'>" + (i - SDay + 1) + "</font>";
                else if (date.getDay() == 6)
                    _objCell.innerHTML = "<font color='#1973d2'>" + (i - SDay + 1) + "</font>";
                else
                    _objCell.innerHTML = (i - SDay + 1);

                _objCell.tmpFormat = strFormat;
            }

            _objCell.tmpValue = getDateFormat(tmpYear, tmpMonth, tmpValue, strFormat);
            _objCell.style.cursor = "pointer";

            if (_selectedValues.indexOf(_objCell.tmpValue) >= 0) {
                _objCell.style.border = "1px solid #8888FF";
                _objCell.style.background = "#EEEEFF"
            }
            else {
                _objCell.style.border = "1px solid #FFFFFF";
                _objCell.style.background = "#FFFFFF"
            }

            tmpCntNum = i + 1;
        }

        for (var i = tmpCntNum; i < 42; i++) {
            var _objCell = frmCalendar_FT.document.getElementById("Cld_f" + (String)(idx) + (String)(i + 1));

            _objCell.tmpValue = ""
            _objCell.innerHTML = "";
            _objCell.style.cursor = "default";
            _objCell.style.border = "1px solid #FFFFFF";
            _objCell.style.background = "#FFFFFF"
        }
    }

    frmCalendar_FT.document.getElementById("Cld_b").tmpValue = getDateFormat(CurrYear, CurrMonth, CurrDay, strFormat);
    frmCalendar_FT.document.getElementById("Cld_b").tmpFormat = strFormat;
    frmCalendar_FT.document.getElementById("Cld_b").innerHTML = CurrYear + "<br/><span style='font-size:20px;font-weight:bold;'>" + (eval("_mon_" + Use_Language.toLowerCase()))[parseInt(CurrMonth, 10) - 1] + " " + CurrDay + "</span>";

    // 날짜 변경시 호출 콜백(이재일)
    //if (parent != null && parent != undefined && parent.CalendarChangeDateCallBack != undefined) {
    //    parent.CalendarChangeDateCallBack();
    //}
};

// 월 선택 달력
function SetCalendarMonth_FT(tmpYM) {

    frmCalendar_FT.document.getElementById("SmallCal0").style.display = 'block';
    frmCalendar_FT.document.getElementById("FullCal0").style.display = 'none';
    frmCalendar_FT.document.getElementById("SmallCal1").style.display = 'block';
    frmCalendar_FT.document.getElementById("FullCal1").style.display = 'none';

    var Months = new Array();
    Months[0] = "01";
    Months[1] = "02";
    Months[2] = "03";
    Months[3] = "04";
    Months[4] = "05";
    Months[5] = "06";
    Months[6] = "07";
    Months[7] = "08";
    Months[8] = "09";
    Months[9] = "10";
    Months[10] = "11";
    Months[11] = "12";
    var tmpDate;
    var CurrDate = new Date();
    var CurrYear = CurrDate.getFullYear();
    var CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
    var CurrDate = (100 + CurrDate.getDate()).toString().substr(1);

    var tmpYear = tmpYM.split("-")[0];
    var tmpMonth = tmpYM.split("-")[1];

    frmCalendar_FT.document.getElementById("Cld_hl").innerHTML = "<a onclick = 'parent.SetCalendarMonth_FT((String)(parseInt(\"" + tmpYear + "\", 10) - 3) + \" - \" + \"" + tmpMonth + "\");'>◀</a>";
    frmCalendar_FT.document.getElementById("Cld_hl").style.cursor = "pointer";
    //frmCalendar_FT.document.getElementById("Cld_hl").onclick = function () { parent.SetCalendarMonth_FT((String)(parseInt(tmpYear, 10) - 3) + "-" + tmpMonth); };

    frmCalendar_FT.document.getElementById("Cld_hr").innerHTML = "<a onclick = 'parent.SetCalendarMonth_FT((String)(parseInt(\"" + tmpYear + "\", 10) + 1) + \" - \" + \"" + tmpMonth + "\");'>▶</a>";
    frmCalendar_FT.document.getElementById("Cld_hr").style.cursor = "pointer";
    //frmCalendar_FT.document.getElementById("Cld_hr").onclick = function () { parent.SetCalendarMonth_FT((String)(parseInt(tmpYear, 10) + 1) + "-" + tmpMonth); };

    for (var idx = 0; idx < 2; idx++) {
        tmpYear = new String(parseInt(tmpYear, 10) + idx);
        var tmpHeader = "<a onclick=\"parent.TargetMode2Month = '" + tmpMonth + "'; parent.SetCalendarYear_FT('" + tmpYear + "');\" style='curosr:hand;'>" + tmpYear + "</a>";
        frmCalendar_FT.document.getElementById("Cld_hm" + idx).innerHTML = tmpHeader;

        var tmpValue = "";
        //debugger;
        for (var i = 0; i < 12; i++) {
            var _objCell = frmCalendar_FT.document.getElementById("Cld_m" + (String)(idx) + (String)(i + 1));

            if (i < 9) tmpValue = "0" + (String)(i + 1);
            else tmpValue = (String)(i + 1);
            if (CurrYear == tmpYear && i + 1 == CurrMonth) {
                _objCell.innerHTML = "<font color='#9876FF'>" + Months[i] + "</font>";
                _objCell.tmpValue = tmpYear + "-" + tmpValue;
                _objCell.style.border = "1px solid #8888FF";
                _objCell.style.background = "#EEEEFF"
            } else {
                _objCell.innerHTML = Months[i];
                _objCell.tmpValue = tmpYear + "-" + tmpValue;
                _objCell.style.border = "1px solid #FFFFFF";
                _objCell.style.background = "#FFFFFF"
            }
        }
    }

    frmCalendar_FT.document.getElementById("Cld_b").tmpValue = CurrYear + "-" + CurrMonth;
    frmCalendar_FT.document.getElementById("Cld_b").innerHTML = CurrYear + "<br/><span style='font-size:20px;font-weight:bold;'>" + (eval("_mon_" + Use_Language.toLowerCase()))[parseInt(CurrMonth, 10) - 1] + " " + CurrDate + "</span>";
};

function SetCalendarYear_FT(tmpYear) {

    frmCalendar_FT.document.getElementById("SmallCal0").style.display = 'block';
    frmCalendar_FT.document.getElementById("FullCal0").style.display = 'none';
    frmCalendar_FT.document.getElementById("SmallCal1").style.display = 'block';
    frmCalendar_FT.document.getElementById("FullCal1").style.display = 'none';

    var tmpDate;
    var CurrDate = new Date();
    var CurrYear = CurrDate.getFullYear();
    var CurrMonth = (100 + (CurrDate.getMonth() + 1)).toString().substr(1);
    var CurrDate = (100 + CurrDate.getDate()).toString().substr(1);

    var sYear = parseInt(tmpYear, 10) - 9;
    var pYear = parseInt(tmpYear, 10) + 12;
    var nYear = parseInt(tmpYear, 10) - 12;

    frmCalendar_FT.document.getElementById("Cld_hl").innerHTML = "<a onclick = 'parent.SetCalendarYear_FT(\"" + nYear + "\");'>◀</a>";
    frmCalendar_FT.document.getElementById("Cld_hl").style.cursor = "pointer";
    //frmCalendar_FT.document.getElementById("Cld_hl").onclick = function () { parent.SetCalendarYear_FT(nYear); };

    for (var idx = 0; idx < 2; idx++) {
        tmpYear = new String(parseInt(tmpYear, 10) + idx * 12);
        sYear = parseInt(tmpYear, 10) - 9;
        pYear = parseInt(tmpYear, 10) + 12;

        var tmpHeader = sYear + " ~ " + (String)(sYear + 11);
        frmCalendar_FT.document.getElementById("Cld_hm" + (String)(idx)).innerHTML = tmpHeader;

        for (var i = 0; i < 12; i++) {
            var _objCell = frmCalendar_FT.document.getElementById("Cld_m" + (String)(idx) + (String)(i + 1));
            if (sYear + i == CurrYear) {
                _objCell.innerHTML = "<font color='#9876FF'>" + (sYear + i) + "</font>";
                _objCell.tmpValue = sYear + i;
            } else {
                _objCell.innerHTML = sYear + i;
                _objCell.tmpValue = sYear + i;
            }
        }
    }

    frmCalendar_FT.document.getElementById("Cld_hr").innerHTML = "<a onclick = 'parent.SetCalendarYear_FT(\"" + pYear + "\");'>▶</a>";
    frmCalendar_FT.document.getElementById("Cld_hr").style.cursor = "pointer";
    //frmCalendar_FT.document.getElementById("Cld_hr").onclick = function () { parent.SetCalendarYear_FT(pYear); };

    frmCalendar_FT.document.getElementById("Cld_b").tmpValue = CurrYear;
    frmCalendar_FT.document.getElementById("Cld_b").innerHTML = CurrYear + "<br/><span style='font-size:20px;font-weight:bold;'>" + (eval("_mon_" + Use_Language.toLowerCase()))[parseInt(CurrMonth, 10) - 1] + " " + CurrDate + "</span>"
};

var _selectedValues = new Array();
function RemoveSelectCalendar_FT(obj, idx) {
    var tmpVal = _selectedValues[idx];

    _selectedValues.splice(idx, 1);
    $(obj).remove();

    $(frmCalendar_FT.document).find("td").each(function () {
        if (this.tmpValue == tmpVal) {
            this.style.border = "1px solid #FFFFFF";
            this.style.background = "#FFFFFF"
        }
    });
};

function BtnCalendar_FT(type, seq) {
    var _tmpVal = "";

    if (_selectedValues.length == 0) {
        _tmpVal = new Date().yyyy_mm_dd();
        _selectedValues.push(_tmpVal + "")
    }
    else {
        _tmpVal = _selectedValues[_selectedValues.length - 1];
    }

    // yyyymm 타입일때 달력에서 년월 하나를 먼저 선택시 일(day)이 없어서 Nan-Nan-Nan으로 떨어지는것 수정
    if (_tmpVal.replace(/-/gi, "").length == 6) {
        _tmpVal = _tmpVal + "-01";
    }

    var d = new Date(_tmpVal.split('-')[0], parseInt(_tmpVal.split('-')[1], 10) - 1, _tmpVal.split('-')[2]);

    switch (type.toUpperCase()) {
        case "Y":
            d.setFullYear(d.getFullYear() + seq);
            d.setDate(d.getDate() + (seq > 0 ? -1 : 0));
            break;
        case "M":
            d.setMonth(d.getMonth() + seq);
            d.setDate(d.getDate() + (seq > 0 ? -1 : 0));
            break;
        case "D":
            d.setDate(d.getDate() + seq);
            break;
    }

    var yyyy = d.getFullYear().toString();
    var mm = (d.getMonth() + 1).toString(); // getMonth() is zero-based
    var dd = d.getDate().toString();
    val = yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]); // padding

    var hy_date = "";

    var LayerObj = document.getElementById("Calendar_Layer");
    var grp = $(document.getElementById(LayerObj.TargetId)).attr("group");
    var grps = $(document.getElementById(LayerObj.TargetId).tagName + "[group='" + grp + "']");
    var idx = _selectedValues.push(val + "") - 1;
    var tmp_selected = "<li onclick='parent.RemoveSelectCalendar_FT(this, " + (String)(idx) + ");'>" + GetCalendarCulture(val, Use_Language) + "</li>";
    $(frmCalendar_FT.document.getElementById("Cld_s")).append(tmp_selected);

    _selectedValues.sort();

    if (grps.length == _selectedValues.length) {
        for (var i = 0; i < grps.length; i++) {
            if (LayerObj.Mode == "yyyymmdd" || LayerObj.Mode == "yyyymm") {
                $(grps[i]).val(_selectedValues[i].replace(/-/ig, ""));
                hy_date = _selectedValues[i].replace(/-/ig, "");
            }
            else {
                if (LayerObj.Mode == "yyyymm" || LayerObj.Mode == "yyyy-mm") {
                    var dsplit = _selectedValues[i] = _selectedValues[i].split("-");
                    _selectedValues[i] = dsplit[0] + "-" + dsplit[1];
                }

                $(grps[i]).val(_selectedValues[i]);
                hy_date = _selectedValues[i];
            }
            $(grps[i]).attr("rawdata", _selectedValues[i].replace(/-/ig, ""));
            $(grps[i]).val(GetCalendarCulture(hy_date, Use_Language));
        }
        LayerObj.style.display = "none";
        _selectedValues = new Array();
        $(frmCalendar_FT.document.getElementById("Cld_s")).html("");

        try {
            //SelectCalendar_FT(document.getElementById(tmpObjId));
            var event = $("#" + tmpObjId).attr("OnCalendarChanged");
            eval(event + "(" + document.getElementById(tmpObjId).value.replace(/-/gi, "") + ")");
        } catch (e) {

        }
    }

};

function SelectCalendar_FT(tmpObj) {
    var hy_date = "";
    if (tmpObj.tmpValue == "") return;
    if (TargetMode2Month != "") {
        //월 선택창으로 이동
        SetCalendarMonth_FT(tmpObj.tmpValue + "-01");
        TargetMode2Month = "";
    } else if (TargetMode2Date != "") {
        //일 선택창으로 이동
        SetCalendarDate_FT(tmpObj.tmpValue + "-01", TargetMode2Date);
        TargetMode2Date = "";
    } else {
        var LayerObj = document.getElementById("Calendar_Layer");
        var grp = $(document.getElementById(LayerObj.TargetId)).attr("group");
        var grps = $(document.getElementById(LayerObj.TargetId).tagName + "[group='" + grp + "']");
        var idx = _selectedValues.push(tmpObj.tmpValue + "") - 1;
        var tmp_selected = "<li onclick='parent.RemoveSelectCalendar_FT(this, " + (String)(idx) + ");'>" + GetCalendarCulture(tmpObj.tmpValue, Use_Language) + "</li>";
        $(frmCalendar_FT.document.getElementById("Cld_s")).append(tmp_selected);

        if (grps.length == _selectedValues.length) {
            _selectedValues.sort();
            for (var i = 0; i < grps.length; i++) {
                if (tmpObj.tmpFormat == "yyyymmdd" || tmpObj.tmpFormat == "yyyymm") {
                    $(grps[i]).val(_selectedValues[i].replace(/-/ig, ""));
                    hy_date = _selectedValues[i].replace(/-/ig, "");
                }
                else {
                    $(grps[i]).val(_selectedValues[i]);
                    hy_date = _selectedValues[i];
                }
                $(grps[i]).attr("rawdata", _selectedValues[i].replace(/-/ig, ""));
                $(grps[i]).val(GetCalendarCulture(hy_date, Use_Language));
            }
            LayerObj.style.display = "none";
            _selectedValues = new Array();
            $(frmCalendar_FT.document.getElementById("Cld_s")).html("");

            try {
                //SelectCalendar_FT(document.getElementById(tmpObjId));
                var event = $("#" + tmpObjId).attr("OnCalendarChanged");
                eval(event + "(" + document.getElementById(tmpObjId).value.replace(/-/gi, "") + ")");
            } catch (e) {

            }
        }

        // 날짜 선택후 실행할 함수 
        try {
            //SelectCalendarInGrid(document.getElementById(tmpObjId));
            //SelectCalendar_FT(document.getElementById(tmpObjId));

        } catch (e) {
        }
    }
};
/*********************************************************************************************************************************
* Multiple Datepikcer End
*********************************************************************************************************************************/


/************************************************트리컨트롤*********************************************/
/* 
제  작 : 손용호
버  전 : 1.0.0
수정일 : 2010/10/14
*/

var domHelper = {
	GetChildNodesByName: function (pNode, nodeName) {
		var list = new Array();
		for (var i = 0; i < pNode.childNodes.length; i++) {
			if (pNode.childNodes[i].nodeName == nodeName) {
				list.push(pNode.childNodes[i]);
			}
		}
		return list;
	},
	GetNodeString: function (node) {
		var text = "";
		for (var i = 0; i < node.childNodes.length; i++) {
			if (node.childNodes[i].nodeName == "#text") {
				text += node.childNodes[i].nodeValue;
			}
		}
		return text;
	}
}

function Tree2Parser4XML(node) {
	var item;
	var text = "";
	if (node.nodeType == 3) {
		//if (node.nodeName == "#text") return text;
		text = node.nodeValue;
	}
	else {
		switch (node.nodeName) {
			case "Table":
				//<Table>
				//	<IDX>1</IDX>
				//	<TEXT>첫번째</TEXT>
				//	<VALUE>1</VALUE>
				//	<PRTIDX/>
				//	<URL>111</URL>
				//	<GLEVEL>1</GLEVEL>
				//	<SORT>1</SORT>
				//</Table>

				var indexBindFiledName = (this.IndexBindFiledName ? this.IndexBindFiledName : "IDX");
				var parentBindFieldName = (this.ParentBindFieldName ? this.ParentBindFieldName : "PRTIDX");
				var textBindFieldName = (this.TextBindFieldName ? this.TextBindFieldName : "TEXT");

				var pItem = null;
				var idx = domHelper.GetNodeString(domHelper.GetChildNodesByName(node, indexBindFiledName)[0]);
				var text = domHelper.GetNodeString(domHelper.GetChildNodesByName(node, textBindFieldName)[0]);
				var values = new Array();
				for (var i = 0; i < node.childNodes.length; i++) {

					if (this.ParserXMLNode(node.childNodes[i]).trim() != "") {

						values.push(this.ParserXMLNode(node.childNodes[i]));

					}
				}
				var pID = domHelper.GetNodeString(domHelper.GetChildNodesByName(node, parentBindFieldName)[0]);

				if (pID != "") {
					pItem = this.FindItem(pID);
				}

				if (pItem == null) {
					item = this.AddItem(new myTreeItem(idx, text, values));
					//item.Icon = 3; // 아이콘을 삭제하기 위하여 주석처리함
				} else {
					item = pItem.AddItem(new myTreeItem(idx, text, values));
					//pItem.Icon = 1;
					//pItem.OpenIcon = 2;
				}
				return;
				break;
			default:
				for (var i = 0; i < node.childNodes.length; i++) {
					text += this.ParserXMLNode(node.childNodes[i]);
				}
				break;
		}
	}
	return text;
}

function DominoViewParser(node) {
	var item;
	var text = "";
	if (node.nodeType == 3) {
		//if (node.nodeName == "#text") return text;
		text = node.nodeValue;
	}
	else {
		switch (node.nodeName) {
			case "Table":
				var idx = -1;
				var tItem;
				var values = new Array();
				for (var i = 0; i < node.childNodes.length; i++) {
					text = this.ParserXMLNode(node.childNodes[i]).trim();
					if (text) {
						if (text != "\n") {
							values.push(text);
							if (tItem) {
								idx = tItem.IndexOf(text);
								if (idx < 0) {
									tItem.Icon = 1;
									tItem.OpenIcon = 2;
									tItem = tItem.AddItem(new myTreeItem("", text, values));
									tItem.Icon = 3;
								}
								else tItem = tItem.Items[idx];
							} else {
								idx = this.IndexOf(text);
								if (idx < 0) item = this.AddItem(new myTreeItem("", text, values));
								else item = this.Items[idx];
								tItem = item;
							}
						}
					}
				}
				return;
				break;
			default:
				for (var i = 0; i < node.childNodes.length; i++) {
					text += this.ParserXMLNode(node.childNodes[i]);
				}
				break;
		}
	}
	return text;
}

//var WebTreeItems;
var myTreeView = function (name, text, values) {
    // property
    this.nodeName = "myTreeView";
    this.Name = name;
    this.Text = text;
    this.Values = values;
    this.Contain = null;
    this.TreeView = this;
    this.Point = "";
    this.Flg = true;
    this.RootNodeHidden = false;
    this.Column = new Array(); 				// 속성 출력용 컬럼
    this.UseColumn = false; 					// 컬럼 사용
    this.UseLine = false; 					// 라인사용
    this.UseAllChildSelect = false; 			// 자식 아이템 자동 선택
    this.UseSelect = true; 					// 선택 가능
    this.AutoResized = false; 				// 컬럼 넓이 자동 조절
    this.Items = new Array(); 				// 자식 아이템 목록
    this.PointItem = null; 					// 선택박스 사용시 임시선택 아이템
    this.SelectedItems = new Array(); 		// 선택된 아이템 목록
    this.CheckBox = false; 					// 선택박스 표시
    this.CheckBox_Type = "checkbox"; 			// 선택박스 타입
    this.ItemMoving = false; 				// 아이템드래그 사용 표시
    this.title = "";                        // 트리 타이틀
    this.hideTitle = false;                 // 트리 타이틀 숨김

    this.IsMouseDrag = false; 				// 마우스 드래크 상태
    this.IsEditMode = false; 				// 텍스트 수정모드
    this.EditModeTarget = "allItem"; 			// 수정모드적용대상 ("allItem" : 모두적용, "treeItem" : 트리 아이템, "columnItem" : 컬럼에사용중인 아이템)
    this.DragItem = myTreeViewDragItem;

    this.ImgList; 							// 이미지 리스트
    this.Icon; 								// 아이콘 이미지(숫자:리스트에서순번의 이미지출력, 문자:이미지주소)

    this.HTMLNode;
    this.ColumnHeadNode;
    this.ColumnBodyNode;
    this.TreeNode;

    this.ColumnNode = new Array();
    this.ColumnSelfNode = new Array();
    this.ColumnTextNode = new Array();
    this.ColumnChildNode = new Array();

    //this.BgColor = "#EAF0F7";
    this.BgColor = "#FBFBFB";

    // 이미지 리스트 초기화
    this.ImgList = new Array();
    this.ImgList.push("/Resources/Framework/TreeImages/base.gif"); 		// 0
    this.ImgList.push("/Resources/Framework/TreeImages/folder.gif"); 	// 1
    this.ImgList.push("/Resources/Framework/TreeImages/folderopen.gif"); // 2
    this.ImgList.push("/Resources/Framework/TreeImages/page.gif"); 		// 3
    this.Icon = 0;

    this.AutoResized = true;
    this.UseLine = true; 				// 라인 사용
    this.ItemMoving = false; 			// 드래그 이동 사용
    this.IsEditMode = false; 			// 텍스트 수정 가능

    //this.CheckBox = false;
    //this.CheckBox_Type = "radio";
    //this.CheckBox_Type = "checkbox";

    //this.Flg = false; 				// 펼친상태

    // style

    // 로드완료후 실행할 함수 정의
    this.Loaded;

    this.Title = function (t) {
        this.title = t;
    };

    this.HideTitle = function (t) {
        this.hideTitle = t;
    };

    // method
    this.Rander = function (contain) {
        if (typeof (contain) == "string") contain = document.getElementById(contain);
        if (contain) this.Contain = contain;
        if (typeof (this.Contain) != "object") {
            alert("TreeView를 표시할 공간이 없습니다. \n" + this.nodeName + ".Rander()");
            return;
        }
        this.HTMLNode = this.GetHTMLNode();
        if (this.HTMLNode) this.Contain.appendChild(this.HTMLNode);
        this.AutoReSize();
        // 트리 바인딩후 처리할 함수를 정의한다.
        if (this.Loaded != "") {
            // 공통처리를 위한 예외처리(세종)
            Site_UI_Loaded();
            eval(this.Loaded + "()");
        }
        this.ProgressHide();
    };

    this.TypeName = "";
    this.MethodName = "";
    this.Param = [];

    // json 형태로 변경함
    this.Json = true;

    this.DataSource = function (typeName, methodName) {
        this.TypeName = typeName;
        this.MethodName = methodName;
    };
    this.Params = function (params) {
        this.Param = params;
    };
    this.Clear = function (id) {
        $("#" + id).find("#" + id).remove();
        this.Items = new Array();
    }
    this.BindTree = function (id) {
        // 초기화
        $("#" + id).find("#" + id).remove();
        this.Items = new Array();

        this.ProgressShow();

        var WebTreeItems = this; // 콜백실행위치설정
        var test = "1";

        PageMethods.InvokeServiceTable(this.Param, this.TypeName, this.MethodName, function (e) {
            var DataSet = eval(e);
            //var xml = e.String2Xml();
            //WebTreeItems.ParserXMLNode = Tree2Parser4XML;
            // xml 파싱 함수 수행
            //WebTreeItems.ParserXML(xml);

            if (DataSet) {
                WebTreeItems.ParserJSON(DataSet);

                WebTreeItems.Rander(id);
            }
            else {
                ProgressBar.hide();
            }

        }, function (e) {
            alert(e.get_message());
            ProgressBar.hide();
        });
    };
    this.TreeViewSearch = function (id) {
        var key = document.getElementsByName(id)[0].value;
        var itemList = this.Search(key);
        if (itemList.length > 0) {
            itemList[0].Select();
        }
    };

    this.AddItem = function (item) {
        if (!item) return;
        this.Items.push(item);
        item.TreeView = this;
        item.Parent = this;
        this.SetItemsInfo();
        if (this.HTMLNode) {
            this.AutoReSize();
        }
        return item;
    }

    this.RemoveItem = function (item) {
        if (this.Items[item.Index] != item) return;
        this.Items.splice(item.Index, 1);

        //myObj.RemoveAllChild(item.HTMLNode);
        myObj.Remove(item.HTMLNode);
        for (var i = item.ColumnNode.length - 1; i >= 0; i--) {
            //myObj.RemoveAllChild(item.ColumnNode[i]);
            myObj.Remove(item.ColumnNode[i]);
        }

        if (item.Selected) {
            for (var i = this.SelectedItems.length - 1; i >= 0; i--) {
                if (this.SelectedItems[i] == item) {
                    this.SelectedItems.splice(i, 1);
                }
            }
        }

        this.SetItemsInfo();
        if (this.HTMLNode) {
            this.ChildOpen();
        }
        return item;
    }

    this.CreateItem = function (name, text, values) {
        var item = new myTreeItem(name, text, values);
        item.TreeView = this;
        return item;
    }

    this.CreateColumn = function (name, text, index, width) {
        var column = new myTreeViewColumn(name, text, index, width);
        column.TreeView = this;
        return column;
    }

    // 아이템 이동
    this.MoveItem = function () {
        var target = this.DragItem.TargetItem;
        var parent;
        for (var i = 0; i < this.SelectedItems.length; i++) {
            parent = this.SelectedItems[i].Parent ? this.SelectedItems[i].Parent : this;
            if (target != parent) {
                parent.Items.splice(this.SelectedItems[i].Index, 1);
                target.AddItem(this.SelectedItems[i]);
                this.SelectedItems[i].Parent.SetItemsInfo();
                parent.SetItemsInfo();
            }
            if (parent.Items.length > 0) parent.SetFlg(true);
            else parent.SetFlg(false);
        }
        target.SetFlg(true);
        myTreeViewHelper.SetCancelItem_TextNode(target.TextNode);
        var eventItem = {
            "Items": this.SelectedItems,
            "TargetItem": target
        }
        this.onmoveItem(eventItem, this);
    }

    // 아이템 추가시 하위 아이템 정보 수정
    this.SetItemsInfo = function () {
        if (this.Items.length > 0) {
            this.Sort();
            for (var i = 0; i < this.Items.length; i++) {
                this.Items[i].TreeView = this.TreeView;
                this.Items[i].Index = i;
                this.Items[i].Dept = 0;
                //this.Items[i].Point = String(i);
                //this.Items[i].NodeName = this.Name + "_" + String(i);
                //if (this.Items[i].Items.length > 0) this.Items[i].SetItemsInfo();
                if (this.ItemsNode) {
                    if (!this.Items[i].HTMLNode) this.Items[i].GetHTMLNode();

                    this.ItemsNode.appendChild(this.Items[i].HTMLNode);
                    if (this.ColumnNode) {
                        for (var j = 0; j < this.ColumnNode.length; j++) {
                            if (this.ColumnNode[j]) {
                                if (!this.Items[i].ColumnNode[j]) this.Items[i].GetColumnNode(j, this.ColumnNode[j].Column);
                                this.ColumnChildNode[j].appendChild(this.Items[i].ColumnNode[j]);
                            }
                        }
                    }
                    this.Items[i].GetLineNode();
                }
            }
        }
    }

    this.Sort = function () {
        this.Items.sort(this.sortItem);
    }

    this.sortItem = function (a, b) {
        if (a.Values > b.Values) return 1;
        else return -1;
    }

    this.GetPosition = function () {
        return "";
    }
    // HTML노드 생성
    this.GetHTMLNode = function () {
        this.HTMLNode = myObj.Create("div", this.Name);
        this.HTMLNode.TreeView = this;
        myTreeViewHelper.SetTreeView_HTMLNode(this.HTMLNode);

        this.TreeNode = myObj.Create("div", this.Name);
        $(this.TreeNode).css("margin-bottom", "10px");
        this.TreeNode.TreeView = this;
        this.TreeNode.Item = this;
        this.SetColumnNode();

        this.SelfNode = myObj.Create("div", this.Name);
        this.SelfNode.TreeView = this;
        this.SelfNode.Item = this;
        myTreeViewHelper.SetItem_SelfNode(this.SelfNode);
        if (!this.hideTitle) { // 타이틀 숨김여부
            this.TreeNode.appendChild(this.SelfNode);
        }

        if (this.RootNodeHidden) this.SelfNode.style.display = "none";

        // 선택박스 출력
        if (this.TreeView) {
            if (this.TreeView.CheckBox) {
                this.SelNode = myObj.Create("input", this.TreeView.Name + "_sel");
                this.SelNode.type = this.TreeView.CheckBox_Type;
                this.SelNode.value = this.value ? this.value : this.Text;
                this.SelNode.Item = this;
                myTreeViewHelper.SetItem_SelNode(this.SelNode);
                this.SelNode.onclick = function () {
                    //var list = document.getElementsByTagName(this.nodeName);
                    this.onchange();
                }
                this.SelNode.onchange = function (e) {
                    if (!e) e = window.event;
                    this.Item.TreeView.AllChildSelect();
                    this.Item.TreeView.SelectItem(this.Item);
                    this.Item.TreeView.onclickItem(e, this);
                }
                this.SelNode.onfocus = function () {
                    this.blur();
                }
                this.SelfNode.appendChild(this.SelNode);
            }
        }

        // 아이콘 출력
        if (((typeof (this.Icon) == "string") && (this.Icon != "")) || (typeof (this.Icon) == "number")) {
            this.IconNode = myObj.Create("img", this.NodeName + "_icon");
            if (typeof (this.Icon) == "string") {
                this.IconNode.src = this.Icon;
            }
            else {
                if (this.ImgList) {
                    if (this.ImgList.length > parseInt(this.Icon)) {
                        this.IconNode.src = this.ImgList[parseInt(this.Icon)];
                    }
                }
            }
            if (myTreeViewHelper.IconSize) {
                this.IconNode.width = myTreeViewHelper.IconSize;
                this.IconNode.height = myTreeViewHelper.IconSize;
            }
            //this.IconNode.hspace = 2;
            myTreeViewHelper.SetItem_IconNode(this.IconNode);
            this.IconNode.Item = this;
            this.SelfNode.appendChild(this.IconNode);
        }

        // 텍스트 출력
        this.TextNode = myObj.Create("div", this.NodeName + "_text");
        //this.TextNode.appendChild(document.createTextNode(this.Text));
        this.TextNode.appendChild(document.createTextNode(this.title)); // Title을 변경(기본적으로 <NewDataSet> 이 나오기때문 -> DataTable의 명)
        this.TextNode.Item = this;
        this.TextNode.value = this.Text;
        this.TextNode.title = this.Text;
        this.SetSelectFn(this.TextNode);
        myTreeViewHelper.SetItem_TextNode(this.TextNode);
        this.TextNode.onclick = function (e) {
            if (!e) e = window.event;
            this.Item.onclickItem(e, this);
        }
        if (this.IsEditMode) {
            if ((this.EditModeTarget == "allItem") || (this.EditModeTarget == "treeItem")) {
                this.TextNode.ondblclick = function (event) { this.Item.TreeView.SetItem_EditMode(this); }
            }
        }
        else {
            this.TextNode.ondblclick = function (e) {
                if (!e) e = window.event;
                this.Item.ondblclickItem(e, this);
            }
        }
        if (this.ItemMoving) {
            this.TextNode.onmouseup = function () { this.Item.IsMouseDrag = false; }
            this.TextNode.onmouseover = function () { this.Item.SetMovePosition(this.Item); }
            this.TextNode.onmouseout = function () { this.Item.SetMovePosition(""); }
            this.TextNode.onmousedown = function () {
                this.Item.TreeView.SelectItem(this.Item);
                this.blur();
            }
        }
        this.SelfNode.appendChild(this.TextNode);

        // 자식 노드 출력
        this.ItemsNode = myObj.Create("div", this.NodeName + "_Items");
        this.ItemsNode.style.display = this.Flg ? "block" : "none";
        this.ItemsNode.style.marginLeft = "2px";
        this.ItemsNode.Item = this;
        if (this.Items.length > 0) {
            for (var i = 0; i < this.Items.length; i++) {
                if (this.Items[i].GetHTMLNode) this.ItemsNode.appendChild(this.Items[i].GetHTMLNode());
            }
        }
        this.TreeNode.appendChild(this.ItemsNode);

        myObj.SetNotSelection(this.HTMLNode);
        return this.HTMLNode;
    }

    // 선택 함수 설정
    this.SetSelectFn = function (node) {
        node.onmousedown = function () {
            this.Item.SelectItem(this.Item);
            this.blur();
        }
    }

    this.SetColumnNode = function () {
        // 컬럼 설정
        this.ColumnHeadNode = myObj.Create("div", this.NodeName + "_ColumnCollectionHeader");
        this.ColumnBodyNode = myObj.Create("div", this.NodeName + "_ColumnCollectionBody");
        //this.ColumnHeadNode.style.backgroundImage = "url(" + myTreeViewImg.Column_Bg + ")";
        myTreeViewHelper.SetULNodeToList(this.ColumnHeadNode);
        myTreeViewHelper.SetULNodeToList(this.ColumnBodyNode);
        if (this.UseColumn) {
            if (this.Column.length > 0) {
                for (var i = 0; i < this.Column.length; i++) {
                    this.Column[i].TreeView = this;
                    //this.Column[i].Index = i-1;
                    this.ColumnHeadNode.appendChild(this.Column[i].GetHeadNode());
                    this.ColumnBodyNode.appendChild(this.Column[i].GetBodyNode());
                }
            }
            else {
                this.Column.push(this.CreateColumn("", this.Text));
                //this.Column[0].Index = -1;
                this.ColumnHeadNode.appendChild(this.Column[0].GetHeadNode());
                this.ColumnBodyNode.appendChild(this.Column[0].GetBodyNode());
            }
            this.Column[0].BodyNode.appendChild(this.TreeNode);
            //this.Column[0].BodyNode.style.backgroundColor = this.BgColor;
            this.Column[0].BodyNode.className = "myTreeCSS";
            this.ColumnHeadDummyNode = myObj.Create("div", "");
            myTreeViewHelper.SetTreeView_ColumnHeadNode(this.ColumnHeadDummyNode);
            //this.ColumnHeadDummyNode.style.width = "20px";
            this.ColumnHeadNode.appendChild(this.ColumnHeadDummyNode);
            this.HTMLNode.appendChild(this.ColumnHeadNode);
            this.HTMLNode.appendChild(this.ColumnBodyNode);
        }
        else {
            this.HTMLNode.appendChild(this.TreeNode);
            //this.HTMLNode.style.backgroundColor = this.BgColor;
            this.HTMLNode.className = "myTreeCSS";
        }
    }

    this.GetColumnNode = function (idx, column) {
        if (!this.ColumnNode[idx]) {
            this.ColumnNode[idx] = myObj.Create("div", this.NodeName + "_Column_" + idx);
            this.ColumnNode[idx].Item = this;
            this.ColumnNode[idx].Column = column;

            this.ColumnSelfNode[idx] = myObj.Create("div", this.NodeName + "_ColumnSelf_" + idx);
            this.ColumnSelfNode[idx].Item = this;
            this.ColumnSelfNode[idx].Column = column;
            this.ColumnSelfNode[idx].ColumnIndex = idx;
            myTreeViewHelper.SetColumn_BodySelfNode(this.ColumnSelfNode[idx]);
            this.ColumnSelfNode[idx].onmouseover = function () { if (!this.Item.Selected) myTreeViewHelper.SetOverItem_ColumnBodySelfNode(this.Item.ColumnSelfNode); }
            this.ColumnSelfNode[idx].onmouseout = function () { if (!this.Item.Selected) myTreeViewHelper.SetOutItem_ColumnBodySelfNode(this.Item.ColumnSelfNode); }
            this.ColumnNode[idx].appendChild(this.ColumnSelfNode[idx]);

            var value = "";
            if (this.Values) {
                if (this.Values[idx]) value = this.Values[idx];
            }
            this.ColumnTextNode[idx] = myObj.Create("div", this.NodeName + "_ColumnText_" + idx);
            this.ColumnTextNode[idx].Item = this;
            this.ColumnTextNode[idx].Column = column;
            this.ColumnTextNode[idx].ColumnIndex = idx;
            this.ColumnTextNode[idx].appendChild(document.createTextNode(value));
            this.ColumnTextNode[idx].value = value;
            this.ColumnTextNode[idx].title = value;
            myTreeViewHelper.SetColumn_BodyTextNode(this.ColumnTextNode[idx]);
            this.ColumnSelfNode[idx].appendChild(this.ColumnTextNode[idx]);

            this.ColumnChildNode[idx] = myObj.Create("div", this.NodeName + "_ColumnChild_" + idx);
            this.ColumnChildNode[idx].Item = this;
            if (this.Items.length > 0) {
                for (var i = 0; i < this.Items.length; i++) {
                    this.ColumnChildNode[idx].appendChild(this.Items[i].GetColumnNode(idx, column));
                }
            }

            if (this.IsEditMode) {
                if ((this.EditModeTarget == "allItem") || (this.EditModeTarget == "columnItem")) {
                    myTreeViewHelper.SetColumn_EditMode(this.ColumnSelfNode[idx]);
                    myTreeViewHelper.SetColumn_EditMode(this.ColumnTextNode[idx]);
                    this.ColumnTextNode[idx].ondblclick = function (event) { this.Item.SetItem_EditMode(this); }
                    this.ColumnSelfNode[idx].ondblclick = function (event) { this.Item.SetItem_EditMode(this.Item.ColumnTextNode[this.ColumnIndex]); }
                }
            }
            this.ColumnNode[idx].appendChild(this.ColumnChildNode[idx]);
        }
        this.ColumnChildNode[idx].style.display = this.Flg ? "block" : "none";
        return this.ColumnNode[idx];
    }

    this.AutoReSize = function () {
        if (this.UseColumn) {
            if (this.AutoResized) {
                for (var i = 0; i < this.Column.length; i++) {
                    this.Column[i].AutoReSize();
                }
            }
        }
        this.AutoReSize_Height();
        this.AutoReSize_Width();
    }

    this.AutoReSize_Width = function () {
        if (!this.UseColumn) return; // 트리 가로 넓이 설정(컬럼 사용시)
        var columns = this.Column;
        var totalWidth = 0;
        var limitWidth = this.HTMLNode.offsetWidth;
        for (var i = 0; i < columns.length; i++) {
            totalWidth += columns[i].Width;
        }

        if (this.HTMLNode.scrollHeight > this.HTMLNode.offsetHeight) limitWidth -= 18;
        if (limitWidth > totalWidth) {
            this.ColumnHeadDummyNode.style.width = (limitWidth - totalWidth) + "px";
            totalWidth = limitWidth;
        }
        else {
            this.ColumnHeadDummyNode.style.width = "0px";
        }
        this.ColumnHeadNode.style.width = totalWidth + "px";
        this.ColumnBodyNode.style.width = totalWidth + "px";
    }

    this.AutoReSize_Height = function () {
        if (!this.UseColumn) return; // 트리 세로 넓이 설정(컬럼 사용시)
        this.ColumnHeadDummyNode.style.width = "0px";
        var totalHeight = this.TreeNode.offsetHeight + 5;
        var limitHeight = this.HTMLNode.offsetHeight - this.ColumnHeadNode.offsetHeight;
        if (limitHeight > totalHeight) {
            totalHeight = limitHeight;
        }
        this.ColumnBodyNode.style.height = totalHeight + "px";
        var columns = this.Column;
        for (var i = 0; i < columns.length; i++) {
            columns[i].BodyNode.style.height = totalHeight + "px";
        }
    }

    // 플래그 설정
    this.SetFlg = function (flg) {
    }

    // 아이템 선택시 표시 엑션
    this.SelectItem = function (item) {
        if (!item.UseSelect) {
            if (this.CheckBox && (this.CheckBox_Type == "checkbox")) {
                return;
            }
            else {
                this.AllSelectCancelItem();
                return;
            }
        }
        if (this.CheckBox && (this.CheckBox_Type == "checkbox")) {
            // 포인트 아이템 지정
            if (this.PointItem) {
                if (this.PointItem.SelNode.checked == false) {
                    myTreeViewHelper.SetCancelItem_TextNode(this.PointItem.TextNode);
                    if (this.UseColumn) myTreeViewHelper.SetCancelItem_ColumnBodySelfNode(this.PointItem.ColumnSelfNode);
                }
            }
            myTreeViewHelper.SetSelectedItem_TextNode(item.TextNode);
            if (this.UseColumn) myTreeViewHelper.SetSelectedItem_ColumnBodySelfNode(item.ColumnSelfNode);
            this.PointItem = item;

            var tmpItem = null;
            for (var i = this.SelectedItems.length - 1; i >= 0; i--) {
                if ((this.SelectedItems[i].SelNode.checked == false) || (this.SelectedItems[i] == item)) {
                    tmpItem = this.SelectedItems.splice(i, 1);
                    tmpItem[0].Selected = false;
                    if (tmpItem[0].SelNode.checked == false) this.ParentItemSelBoxCancel(tmpItem[0]);
                    myTreeViewHelper.SetCancelItem_TextNode(tmpItem[0].TextNode);
                    if (this.UseColumn) myTreeViewHelper.SetCancelItem_ColumnBodySelfNode(tmpItem[0].ColumnSelfNode);
                }
            }
            if (item.SelNode.checked == true) {
                this.SelectedItems.push(item);
                item.Selected = true;
                myTreeViewHelper.SetSelectedItem_TextNode(item.TextNode);
                if (this.UseColumn) myTreeViewHelper.SetSelectedItem_ColumnBodySelfNode(item.ColumnSelfNode);
            }
        }
        else {
            if (this.SelectedItems.length > 0) {
                var tmpItem;
                while (this.SelectedItems.length > 0) {
                    tmpItem = this.SelectedItems.pop();
                    myTreeViewHelper.SetCancelItem_TextNode(tmpItem.TextNode);
                    if (this.UseColumn) myTreeViewHelper.SetCancelItem_ColumnBodySelfNode(tmpItem.ColumnSelfNode);
                    tmpItem.Selected = false;
                    if (tmpItem.SelNode) tmpItem.SelNode.checked = tmpItem.Selected;
                }
            }
            if (item) {
                this.SelectedItems.push(item);
                myTreeViewHelper.SetSelectedItem_TextNode(item.TextNode);
                if (this.UseColumn) myTreeViewHelper.SetSelectedItem_ColumnBodySelfNode(item.ColumnSelfNode);
                item.Selected = true;
                if (item.SelNode) item.SelNode.checked = item.Selected;
            }
        }
    }

    this.SelectCancelItem = function (item) {
        if (this.CheckBox && (this.CheckBox_Type == "checkbox")) {
            // 포인트 아이템 지정
            if (this.PointItem) {
                if (this.PointItem.SelNode.checked == false) {
                    myTreeViewHelper.SetCancelItem_TextNode(this.PointItem.TextNode);
                    if (this.UseColumn) myTreeViewHelper.SetCancelItem_ColumnBodySelfNode(this.PointItem.ColumnSelfNode);
                }
            }
            var tmpItem = null;
            for (var i = this.SelectedItems.length - 1; i >= 0; i--) {
                if (this.SelectedItems[i] == item) {
                    tmpItem = this.SelectedItems.splice(i, 1);
                    tmpItem[0].Selected = false;
                    tmpItem[0].SelNode.checked = false;
                    this.ParentItemSelBoxCancel(tmpItem[0]);
                    myTreeViewHelper.SetCancelItem_TextNode(tmpItem[0].TextNode);
                    if (this.UseColumn) myTreeViewHelper.SetCancelItem_ColumnBodySelfNode(tmpItem[0].ColumnSelfNode);
                }
            }
        }
        else {
            if (this.SelectedItems.length > 0) {
                var tmpItem;
                while (this.SelectedItems.length > 0) {
                    tmpItem = this.SelectedItems.pop();
                    myTreeViewHelper.SetCancelItem_TextNode(tmpItem.TextNode);
                    if (this.UseColumn) myTreeViewHelper.SetCancelItem_ColumnBodySelfNode(tmpItem.ColumnSelfNode);
                    tmpItem.Selected = false;
                    if (tmpItem.SelNode) tmpItem.SelNode.checked = tmpItem.Selected;
                }
            }
        }
    }

    this.AllSelectCancelItem = function () {
        if (this.CheckBox && (this.CheckBox_Type == "checkbox")) {
            // 포인트 아이템 지정
            if (this.PointItem) {
                if (this.PointItem.SelNode.checked == false) {
                    myTreeViewHelper.SetCancelItem_TextNode(this.PointItem.TextNode);
                    if (this.UseColumn) myTreeViewHelper.SetCancelItem_ColumnBodySelfNode(this.PointItem.ColumnSelfNode);
                }
            }
            var tmpItem = null;
            for (var i = this.SelectedItems.length - 1; i >= 0; i--) {
                tmpItem = this.SelectedItems.splice(i, 1);
                tmpItem[0].Selected = false;
                tmpItem[0].SelNode.checked = false;
                this.ParentItemSelBoxCancel(tmpItem[0]);
                myTreeViewHelper.SetCancelItem_TextNode(tmpItem[0].TextNode);
                if (this.UseColumn) myTreeViewHelper.SetCancelItem_ColumnBodySelfNode(tmpItem[0].ColumnSelfNode);
            }
        }
        else {
            if (this.SelectedItems.length > 0) {
                var tmpItem;
                while (this.SelectedItems.length > 0) {
                    tmpItem = this.SelectedItems.pop();
                    myTreeViewHelper.SetCancelItem_TextNode(tmpItem.TextNode);
                    if (this.UseColumn) myTreeViewHelper.SetCancelItem_ColumnBodySelfNode(tmpItem.ColumnSelfNode);
                    tmpItem.Selected = false;
                    if (tmpItem.SelNode) tmpItem.SelNode.checked = tmpItem.Selected;
                }
            }
        }
    }

    this.ParentItemSelBoxCancel = function (item) {
        if (this.UseAllChildSelect) {
            if (item.Parent) {
                item.Parent.SelNode.checked = false;
                if (item.Parent != this) this.ParentItemSelBoxCancel(item.Parent);
            }
        }
    }


    // 드래그 엑션 시작
    this.MovingItem = function () {
        if (this.IsEditItem) return; 					// 아이템 수정중일때 드래그 방지
        if (this.DragItem.IsUse) return;
        if (this.IsMouseDrag) {
            var position;
            if (this.SelectedItems.length > 1) {	// 이동 유효성 검사(상위가 같은 위치일경우 이동이 가능
                position = this.SelectedItems[0].Parent.GetPosition();
                for (var i = 1; i < this.SelectedItems.length; i++) {
                    if (this.SelectedItems[i].Parent.GetPosition() != position) {
                        this.IsMouseDrag = false;
                        return;
                    }
                }
            }

            this.DragItem.IsUse = true;
            this.DragItem.TreeView = this;
            this.DragItem.Item = myObj.Create("div", this.Name + "_DragItem");
            this.DragItem.Item.style.position = "absolute";
            this.DragItem.Item.style.fontSize = "9pt";
            this.DragItem.Item.style.border = "1px dotted #999999";
            this.DragItem.Item.style.padding = "2px";
            this.DragItem.Item.style.cursor = "pointer";
            this.DragItem.Item.style.backgroundColor = "#FFFFFF";
            this.DragItem.Item.style.opacity = 0.6;
            this.DragItem.Item.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=60)";
            var tmpDiv;
            var tmpItem;

            this.SelectedItems.sort(this.sortItem);
            for (var i = 0; i < this.SelectedItems.length; i++) {
                tmpDiv = myObj.Create("div");
                // 아이콘 출력
                if (this.SelectedItems[i].IconNode) {
                    tmpItem = myObj.Create("img", this.SelectedItems[i] + "_icon");
                    tmpItem.src = this.SelectedItems[i].IconNode.src;

                    if (myTreeViewHelper.IconSize) {
                        tmpItem.width = myTreeViewHelper.IconSize;
                        tmpItem.height = myTreeViewHelper.IconSize;
                    }
                    //tmpItem.hspace = 2;
                    tmpItem.style.verticalAlign = "middle";
                    tmpItem.Item = this.SelectedItems[i];
                    tmpDiv.appendChild(tmpItem);
                }
                tmpItem = myObj.Create("div", "");
                myTreeViewHelper.SetItem_TextNode(tmpItem);
                myTreeViewHelper.SetSelectedItem_TextNode(tmpItem);
                tmpItem.appendChild(document.createTextNode(this.SelectedItems[i].Text));
                tmpDiv.appendChild(tmpItem);
                this.DragItem.Item.appendChild(tmpDiv);
            }
            document.body.appendChild(this.DragItem.Item);
            myObj.SetNotSelection(this.DragItem.Item);
            myObj.attachEvent(document, "mousemove", this.DragItem.onmousemove);
            myObj.attachEvent(document, "mouseup", this.DragItem.onmouseup);
            this.DragItem.Interval = window.setInterval("myTreeViewDragItem.SetPosition()", 10);
        }
    }

    // 드래그 이동위치 아이템에 대한 설정
    this.SetMovePosition = function (item) {
        if (this.IsEditItem) return; 					// 아이템 수정중일때 드래그 방지
        if (item.Selected) return; 						// 선택된아이템으로 옴길수 없다.
        if (this.IsMouseDrag) {
            if (this.SelectedItems.length == 0) return; 	// 선택된아이템이 없으면 취소
            if (this.DragItem.TargetItem) {
                myTreeViewHelper.SetCancelItem_TextNode(this.DragItem.TargetItem.TextNode);
                this.DragItem.TargetItem = "";
            }
            if (item) {
                if (item.GetPosition().indexOf(this.SelectedItems[0].GetPosition() + ".") != 0) {
                    myTreeViewHelper.SetSelectedItem_TextNode(item.TextNode);
                    this.DragItem.TargetItem = item;
                }
            }
        }
    }

    // XML파싱
    this.ParserXML = function (xmlDoc) {
        var node;
        var attr;
        var node = xmlDoc.firstChild;
        if (node.nodeName == "xml") node = node.nextSibling;
        var text = node.nodeName;
        var values = new Array();
        if (node.attributes) {
            for (var i = 0; i < node.attributes.length; i++) {
                values.push(node.attributes[i].nodeName + "=" + node.attributes[i].nodeValue);
            }
            this.Values = values;
        }
        this.Text = "<" + text + ">";
        var tmp;
        for (var i = 0; i < node.childNodes.length; i++) {
            tmp = this.ParserXMLNode(node.childNodes[i]);
            if (tmp) {
                if (typeof (tmp) == "object") {
                    this.AddItem(tmp);
                }
            }
        }
    }

    // JSON파싱
    this.ParserJSON = function (DataSet) {
        if (DataSet == undefined) return;

        var indexBindFiledName = (this.IndexBindFiledName ? this.IndexBindFiledName : "IDX");
        var parentBindFieldName = (this.ParentBindFieldName ? this.ParentBindFieldName : "PRTIDX");
        var textBindFieldName = (this.TextBindFieldName ? this.TextBindFieldName : "TEXT");

        //var values = new Array();

        for (i = 0; i < ObjectCount(DataSet.Tables[0].Rows); i++) {



            //values.push(DataSet.Tables[0].Rows[i]);

            var pID = DataSet.Tables[0].Rows[i][parentBindFieldName];

            var idx = DataSet.Tables[0].Rows[i][indexBindFiledName];

            var text = DataSet.Tables[0].Rows[i][textBindFieldName];

            var objectKeys = Object.keys(DataSet.Tables[0].Rows[i]);

            var values = new Array();

            for (j = 0; j < objectKeys.length; j++) {
                values.push(DataSet.Tables[0].Rows[i][objectKeys[j]]);
            }
            //var values = DataSet.Tables[0].Rows[i];

            pItem = this.FindItem(pID);

            if (pItem == null) {
                item = this.AddItem(new myTreeItem(idx, text, values));
                //item.Icon = 3; // 아이콘을 삭제하기 위하여 주석처리함
            } else {
                item = pItem.AddItem(new myTreeItem(idx, text, values));
                //pItem.Icon = 1;
                //pItem.OpenIcon = 2;
            }

        }

        //this.Values = values;



        //var pID = domHelper.GetNodeString(domHelper.GetChildNodesByName(node, parentBindFieldName)[0]);
        //
        //if (pID != "") {
        //	pItem = this.FindItem(pID);
        //}
        //
        //if (pItem == null) {
        //	item = this.AddItem(new myTreeItem(idx, text, values));
        //	//item.Icon = 3; // 아이콘을 삭제하기 위하여 주석처리함
        //} else {
        //	item = pItem.AddItem(new myTreeItem(idx, text, values));
        //	//pItem.Icon = 1;
        //	//pItem.OpenIcon = 2;
        //}
    }

    // 노드에 대한 파싱 함수
    this.ParserXMLNode = function (node) {
        var item;
        var text = "";
        var values = new Array();
        if (node.nodeType == 3) {
            text = node.nodeValue;
        }
        else {
            text = "<" + node.nodeName;
            if (node.attributes) {
                for (var i = 0; i < node.attributes.length; i++) {
                    values.push(node.attributes[i].nodeName + "=" + node.attributes[i].nodeValue);
                }
            }
            text += ">";
        }
        if (text) {
            if (text != "\n") {
                item = this.CreateItem(etxt, text, values);
                item.Icon = 1;
                for (var i = 0; i < node.childNodes.length; i++) {
                    tmp = this.ParserXMLNode(node.childNodes[i]);
                    if (tmp) {
                        if (typeof (tmp) == "object") {
                            item.AddItem(tmp);
                            item.Icon = 0;
                        }
                    }
                }
            }
        }
        return item;
    }

    // 인덱스 검색
    this.IndexOf = function (key) {
        if (typeof (key) != "string") return -1;
        var idx = -1;
        if (this.Items.length > 0) {
            for (var i = 0; i < this.Items.length; i++) {
                if (this.Items[i].Name == key) idx = i;
                else if (this.Items[i].Text) {
                    if (this.Items[i].Text.indexOf(key) >= 0) idx = i;
                }
            }
        }
        return idx;
    }

    // Item찾기
    this.FindItem = function (itemName) {
        var node = null;
        if (this.Items.length > 0) {
            for (var i = 0; i < this.Items.length; i++) {
                if (this.Items[i].Name == itemName) {
                    return this.Items[i];
                }
                node = this.Items[i].FindItem(itemName);
                if (node != null) {
                    return node;
                }
            }
        }
        return null;
    }

    this.Search = function (key) {
        var sList = new Array();
        if (!key) return sList;
        var cList;
        if (this.Items.length > 0) {
            for (var i = 0; i < this.Items.length; i++) {
                cList = this.Items[i].Search(key);
                if (cList.length > 0) sList = sList.concat(cList);
            }
        }
        if (this.Name == key) {
            sList.push(this);
        }
        else if (this.Text == key) {
            sList.push(this);
        }
        return sList;
    }

    // 아이템 수정모드 설정
    this.SetItem_EditMode = function (node) {
        if (!node.Item.UseSelect) return; 		// 선택불가 아이템 수정불가
        if (!this.IsEditMode) return; 			// 수정모드인지 확인
        if (this.IsEditItem) return; 			// 아이템 수정중일때 드래그 방지
        this.IsEditItem = true; 					// 아이템 수정중 플래그 설정
        if (this.ondblclickItem(node) == false) return;
        var top = myObj.GetTop(node) - this.HTMLNode.scrollTop;
        var left = myObj.GetLeft(node) - this.HTMLNode.scrollLeft;
        var width = node.offsetWidth + 3;
        var EditNode = myObj.Create("input", node.Item.NodeName + "_EditNode");
        EditNode.Target = node;
        EditNode.type = "text";
        EditNode.value = node.value;
        EditNode.style.fontSize = "9pt";
        EditNode.style.border = "1px solid #000000";
        EditNode.style.position = "absolute";
        EditNode.style.top = top + "px";
        EditNode.style.left = left + "px";
        EditNode.style.width = width + "px";
        EditNode.style.overflow = "visible";
        document.body.appendChild(EditNode);
        EditNode.focus();
        EditNode.select();
        EditNode.onblur = function () {
            var eventItem = {
                "beforeValue": this.Target.value,
                "afterValue": this.value
            }
            if (this.value != "") this.Target.value = this.value;
            this.Target.title = this.Target.value;

            // 컬럼이면 Values로 수정, 아니면 Text수정
            if (this.Target.ColumnIndex != undefined) {
                this.Target.Item.Values[this.Target.ColumnIndex] = this.Target.value;
            }
            else this.Target.Item.Text = this.Target.value;
            this.Target.childNodes[0].nodeValue = this.Target.value;
            this.Target.Item.TreeView.IsEditItem = false;
            if (this.Target.Item.nodeName == "myTreeItem") this.Target.Item.Parent.SetItemsInfo();
            this.Target.Item.TreeView.onchangeItem(eventItem, this.Target.Item);
            myObj.detachEvent(document, "click", myTreeViewEditItem.onclick);
            window.clearInterval(myTreeViewEditItem.Interval);
            if (typeof (myTreeViewEditItem.EditItem) == "object") myTreeViewEditItem.EditItem = "";
            myObj.Remove(this);
        }
        EditNode.onkeydown = function (e) {
            if (!e) e = window.event;
            if (e.keyCode == 13) {
                this.blur();
                return;
            }
            else if (e.keyCode == 27) {
                this.value = "";
                this.blur();
                return;
            }
            else {
                this.Target.childNodes[0].nodeValue = this.value;
                this.style.width = (this.Target.offsetWidth + 7) + "px";
            }
        }
        EditNode.onmouseover = function (e) { myTreeViewEditItem.IsUse = true; }
        EditNode.onmouseout = function (e) { myTreeViewEditItem.IsUse = false; }
        myTreeViewEditItem.Item = node;
        myTreeViewEditItem.EditItem = EditNode;
        myTreeViewEditItem.IsUse = true;
        myObj.attachEvent(document, "click", myTreeViewEditItem.onclick);
        myTreeViewEditItem.TreeView = this;
        myTreeViewEditItem.scrollTop = this.HTMLNode.scrollTop;
        myTreeViewEditItem.scrollLeft = this.HTMLNode.scrollLeft;
        myTreeViewEditItem.Interval = window.setInterval("myTreeViewEditItem.onmovescroll();", 10);
    }

    this.ChildOpen = function () {
        this.SetFlg(true);
    }

    this.ChildClose = function () {
        this.SetFlg(false);
    }

    this.AllChildOpen = function () {
        this.ChildOpen();
        if (this.Items.length > 0) {
            for (var i = 0; i < this.Items.length; i++) {
                this.Items[i].AllChildOpen();
            }
        }
    }

    this.AllChildClose = function () {
        this.ChildClose();
        if (this.Items.length > 0) {
            for (var i = 0; i < this.Items.length; i++) {
                this.Items[i].AllChildClose();
            }
        }
    }

    this.AllChildSelect = function () {
        if (this.UseAllChildSelect) {
            this.SelectItem(this);
            if (this.Items.length > 0) {
                for (var i = 0; i < this.Items.length; i++) {
                    this.Items[i].SelNode.checked = this.SelNode.checked;
                    this.Items[i].AllChildSelect();
                }
            }
        }
    }

    this.Show = function () {
        this.ChildOpen();
    }

    this.Select = function () {
        this.TreeView.SelectItem(this);
        this.Show();
    }

    // event

    this.onmoveItem = function (e, sender) {
    }

    this.onclickItem = function (e, sender) {
    }

    this.onchangeItem = function (e, sender) {
    }

    this.ondblclickItem = function (e, sender) {
        return true;
    }

    this.ProgressShow = function () {
        var width = $("#" + this.Name).width();
        var height = $("#" + this.Name).height();

        $("#" + this.Name + "_progress").css("margin-top", "-" + height + "px");
        if (height == 0) {
            $("#" + this.Name + "_progress").find("div").css("top", 10 + "px");
        }
        else {
            $("#" + this.Name + "_progress").find("div").css("top", (height / 2 - 16) + "px");
        }
        $("#" + this.Name + "_progress").find("div").css("left", (width / 2 - 16) + "px");

        $("#" + this.Name + "_progress").show();
    };

    this.ProgressHide = function () {
        $("#" + this.Name + "_progress").hide();
    };
}

// 트리뷰 컬럼 개체
var myTreeViewColumn = function (name, text, index, width) {
	this.nodeName = "myTreeViewColumn";
	this.Name = name;
	this.Text = text;
	this.TreeView;
	this.Index = index;

	this.Width = (width) ? width : 200;
	this.UseMaxWidth = 20;
	this.Type;
	//this.

	this.HTMLNode;
	this.HeadNode;
	this.TextNode;
	this.BodyNode;
	this.SplitNode;
	this.EditNode;
	this.EditNodeType = text;

	this.GetHTMLNode = function () {
		/*
		this.HTMLNode = myObj.Create("li", this.nodeName + "_Column");
		this.HTMLNode.Item = this;
		this.HTMLNode.style.width = "400px";
		this.HTMLNode.style.styleFloat = "left";
			
		this.HTMLNode.appendChild(this.GetHeadNode());	// Hhead
		this.HTMLNode.appendChild(this.GetBodyNode());	// Body
		return this.HTMLNode;
		*/
	}

	this.GetHeadNode = function () {
		this.HeadNode = myObj.Create("div", this.nodeName + "_ColumnHead");
		this.HeadNode.Item = this;
		myTreeViewHelper.SetTreeView_ColumnHeadNode(this.HeadNode);
		this.HeadNode.style.width = this.Width + "px";
		this.HeadNode.onmouseover = function () {
			myTreeViewHelper.SetOverItem_ColumnHeadNode(this);
		}
		this.HeadNode.onmouseout = function () {
			myTreeViewHelper.SetOutItem_ColumnHeadNode(this);
		}
		/*
		// 컬럼 클릭시 정렬 방식 수정
		this.HeadNode.onclick = function() {
		this.Item.TreeView.sortItem = (this.Item.Index < 0) ? myTreeViewHelper.GetSortItemFunction("Text") : myTreeViewHelper.GetSortItemFunction("Values[" + this.Item.Index + "]");
		this.Item.TreeView.SetItemsInfo();
		}
		*/

		// 해드 텍스트 노드 삽입
		this.TextNode = myObj.Create("div", this.nodeName + "_ColumnText");
		this.TextNode.Item = this;
		myTreeViewHelper.SetTreeView_ColumnHeadTextNode(this.TextNode);
		this.TextNode.appendChild(document.createTextNode(this.Text));
		this.TextNode.style.width = (this.Width - 5) + "px";
		this.HeadNode.appendChild(this.TextNode);

		// 오른쪽 구분선
		this.SplitNode = myObj.Create("div", this.nodeName + "_ColumnSplit");
		this.SplitNode.Item = this;
		this.SplitNode.style.lineHeight = "12px";
		this.SplitNode.style.height = "12px";
		this.SplitNode.style.styleFloat = "right";
		this.SplitNode.style.cssFloat = "right";
		this.SplitNode.style.borderRight = "1px solid #FFFFFF";
		this.SplitNode.style.borderLeft = "1px solid #CCCCCC";
		this.SplitNode.style.cursor = "col-resize";
		this.SplitNode.onmousedown = function (e) {
			if (!e) e = window.event;
			myTreeViewColumnResizeDrag.TreeViewColumn = this.Item;
			myTreeViewColumnResizeDrag.Height = this.Item.TreeView.HTMLNode.offsetHeight;
			myTreeViewColumnResizeDrag.Y = myObj.GetTop(this.Item.TreeView.HTMLNode) - this.Item.TreeView.HTMLNode.scrollTop;
			myTreeViewColumnResizeDrag.X = myObj.GetLeft(this) + this.offsetWidth - this.Item.TreeView.HTMLNode.scrollLeft;
			myObj.attachEvent(document, "mousemove", myTreeViewColumnResizeDrag.onmousemove);
			myObj.attachEvent(document, "mouseup", myTreeViewColumnResizeDrag.onmouseup);
			myTreeViewColumnResizeDrag.Interval = window.setInterval("myTreeViewColumnResizeDrag.SetPosition()", 10);
		}
		this.SplitNode.ondblclick = function (e) {
			this.Item.AutoReSize();
		}

		this.HeadNode.appendChild(this.SplitNode);
		return this.HeadNode;
	}

	this.GetBodyNode = function () {
		this.BodyNode = myObj.Create("div", this.nodeName + "_ColumnBody");
		this.BodyNode.Item = this;
		myTreeViewHelper.SetTreeView_ColumnBodyNode(this.BodyNode);
		this.BodyNode.style.width = this.Width + "px";
		if (this.TreeView) {
			// TreeView 정보 가져오기
			if (this.Index >= 0) this.BodyNode.appendChild(this.TreeView.GetColumnNode(this.Index, this));
		}
		return this.BodyNode;
	}

	this.AutoReSize = function () {
		var tmpwidth = myTreeViewHelper.GetUsedMaxWidth(this.BodyNode, myObj.GetLeft(this.BodyNode));
		this.ReSizeTo(tmpwidth + 10);
	}

	this.ReSizeTo = function (width) {
		if (width < 22) width = 22;
		this.Width = width;
		this.HeadNode.style.width = width + "px";
		this.TextNode.style.width = (width - 5) + "px";
		this.BodyNode.style.width = width + "px";
		this.TreeView.AutoReSize_Height();
		this.TreeView.AutoReSize_Width();
	}

	this.HeadStyle;
	this.BodyStyle;
}
/* 
제  작 : 손용호
버  전 : 1.0.0
수정일 : 2010/10/14
*/


var myTreeItem = function (name, text, values) {
	// property
	this.nodeName = "myTreeItem";
	this.Name = name;
	this.Text = text;
	this.Values = (values) ? values : new Array();
	this.TreeView; 							// 표시트리뷰
	this.Parent; 							// 상위 아이템
	this.Items = new Array(); 				// 자식 아이템 목록
	this.Path = ""; 							// 절대경로	
	this.Point = ""; 							// 트리위치
	this.Dept = 0; 							// 깊이
	this.Index = 0; 							// 순서
	this.Flg = false;
	this.UseSelect = true; 						// 선택 가능
	this.Selected = false;
	this.Icon; 								// 아이콘 이미지(숫자: treeView에서 리스트에서순번의 이미지출력, 문자:이미지주소)
	this.OpenIcon; 							// 열었을때 아이콘 이미지

	this.NodeName = this.Name;
	this.HTMLNode;
	this.FlgNode;
	this.IconNode;
	this.SelNode;
	this.TextNode;
	this.ValueNode;
	this.ItemsNode;
	this.ColumnNode = new Array();
	this.ColumnSelfNode = new Array();
	this.ColumnTextNode = new Array();
	this.ColumnChildNode = new Array();

	// style

	// method
	// 아이템 추가
	this.AddItem = function (item) {
		if (!item) return;
		this.Items.push(item);
		item.Parent = this;
		if (this.TreeView) {
			item.TreeView = this.TreeView;
			this.SetItemsInfo();
			if (this.TreeView.HTMLNode) {
				this.ChildOpen();
			}
		}
		return item;
	}

	this.RemoveItem = function (item) {
		if (this.Items[item.Index] != item) return;
		this.Items.splice(item.Index, 1);

		//myObj.RemoveAllChild(item.HTMLNode);
		myObj.Remove(item.HTMLNode);
		for (var i = item.ColumnNode.length - 1; i >= 0; i--) {
			//myObj.RemoveAllChild(item.ColumnNode[i]);
			myObj.Remove(item.ColumnNode[i]);
		}

		if (this.TreeView) {
			if (item.Selected) {
				for (var i = this.TreeView.SelectedItems.length - 1; i >= 0; i--) {
					if (this.TreeView.SelectedItems[i] == item) {
						this.TreeView.SelectedItems.splice(i, 1);
					}
				}
			}
			this.SetItemsInfo();
			if (this.TreeView.HTMLNode) {
				this.ChildOpen();
			}
		}
		return item;
	}

	// 아이템 추가시 하위 아이템 정보 수정
	this.SetItemsInfo = function () {
		if (this.Items.length > 0) {
			this.Sort();
			for (var i = 0; i < this.Items.length; i++) {
				this.Items[i].TreeView = this.TreeView;
				this.Items[i].Index = i;
				this.Items[i].Dept = this.Dept + 1;
				//this.Items[i].Point = this.Point + "." + i;
				//this.Items[i].NodeName = this.TreeView.Name + "_" + this.Items[i].Point;
				//if (this.Items[i].Items.length > 0) this.Items[i].SetItemsInfo();
				if (this.ItemsNode) {
					if (!this.Items[i].HTMLNode) this.Items[i].GetHTMLNode();
					this.ItemsNode.appendChild(this.Items[i].HTMLNode);
					if (this.ColumnNode) {
						for (var j = 0; j < this.ColumnNode.length; j++) {
							if (this.ColumnNode[j]) {
								if (!this.Items[i].ColumnNode[j]) this.Items[i].GetColumnNode(j, this.ColumnNode[j].Column);
								this.ColumnChildNode[j].appendChild(this.Items[i].ColumnNode[j]);
							}
						}
					}
					this.Items[i].GetLineNode();
				}
			}
		}
	}

	this.GetPosition = function () {
		if (this.TreeView) {
			if (this.Parent == this.TreeView) {
				return String(this.Index);
			}
			else return this.Parent.GetPosition() + "." + this.Index;
		}
		else {
			if (!this.Parent) {
				return String(this.Index);
			}
			else return this.Parent.GetPosition() + "." + this.Index;
		}
	}

    this.Sort = function () {
        // 왼쪽 트리 메뉴 정렬은 쿼리에서 함으로 return 1; (2017-01-09 장윤호)
		return 1; // 정렬은 쿼리에서 실행함
		//if (this.TreeView) this.Items.sort(this.TreeView.sortItem);
		//else this.Items.sort(this.sortItem);
	}

	this.sortItem = function (a, b) {
		if (a.Name > b.Name) return 1;
		else return -1;
	}

	this.GetHTMLNode = function () {
		this.HTMLNode = myObj.Create("div", this.NodeName);
		this.HTMLNode.Item = this;
		this.HTMLNode.TreeView = this.TreeView;
		myTreeViewHelper.SetItem_HTMLNode(this.HTMLNode);

		this.SelfNode = myObj.Create("div", this.Name);
		this.SelfNode.TreeView = this;
		this.SelfNode.Item = this;
		myTreeViewHelper.SetItem_SelfNode(this.SelfNode);
		this.HTMLNode.appendChild(this.SelfNode);

		// 선 긋기(접기 펼치기 버튼 포함)
		this.SelfNode.appendChild(this.GetLineNode());

		// 선택박스 출력
		if (this.TreeView) {
			if (this.TreeView.CheckBox) {
				this.SelNode = myObj.Create("input", this.TreeView.Name + "_sel");
				this.SelNode.type = this.TreeView.CheckBox_Type;
				this.SelNode.value = this.value ? this.value : this.Text;
				this.SelNode.Item = this;
				myTreeViewHelper.SetItem_SelNode(this.SelNode);
				this.SelNode.onclick = function () {
					var list = document.getElementsByTagName(this.nodeName);
					this.onchange();
				}
				this.SelNode.onchange = function (e) {
					if (!e) e = window.event;
					this.Item.AllChildSelect();
					this.Item.TreeView.SelectItem(this.Item);
					this.Item.TreeView.onclickItem(e, this);
				}
				this.SelNode.onfocus = function () {
					this.blur();
				}
				this.SelfNode.appendChild(this.SelNode);
			}
		}

		// 아이콘 출력
		this.GetIconNode();
		if (this.IconNode) this.SelfNode.appendChild(this.IconNode);

		// 텍스트 출력
		this.TextNode = myObj.Create("div", this.NodeName + "_text");
		this.TextNode.Item = this;
		this.TextNode.appendChild(document.createTextNode(this.Text));
		this.TextNode.value = this.Text;
		this.TextNode.title = this.Text;
		myTreeViewHelper.SetItem_TextNode(this.TextNode);
		this.SetSelectFn(this.TextNode);
		this.SetItemMovingFn(this.TextNode);
		this.TextNode.onclick = function (e) {
			if (!e) e = window.event;
			this.Item.TreeView.onclickItem(e, this);
		}
		if (this.TreeView.IsEditMode) {
			if ((this.TreeView.EditModeTarget == "allItem") || (this.TreeView.EditModeTarget == "treeItem")) {
				this.TextNode.ondblclick = function (event) { this.Item.TreeView.SetItem_EditMode(this); }
			}
		} else {
			this.TextNode.ondblclick = function (e) {
				if (!e) e = window.event;
				this.Item.TreeView.ondblclickItem(e, this);
			}
		}
		this.SelfNode.appendChild(this.TextNode);

		// 자식 노드 출력
		this.HTMLNode.appendChild(this.GetItemsNode());
		return this.HTMLNode;
	}

	// 선택 함수 설정
	this.SetSelectFn = function (node) {
		node.onmousedown = function () {
			this.Item.TreeView.SelectItem(this.Item);
			if (this.Item.Selected) this.Item.TreeView.IsMouseDrag = true;
			this.blur();
		}
	}

	// 아이템 드래그 함수 설정
	this.SetItemMovingFn = function (node) {
		if (this.TreeView.ItemMoving) {
			node.onmouseup = function () { this.Item.TreeView.IsMouseDrag = false; }
			node.onmousemove = function () { this.Item.TreeView.MovingItem(); }
			node.onmouseover = function () { this.Item.TreeView.SetMovePosition(this.Item); }
			node.onmouseout = function () { this.Item.TreeView.SetMovePosition(""); }
		}
	}

	// 트리라인 노드(접기펼치기)
	this.GetLineNode = function () {
		if (!this.LineNode) this.LineNode = myObj.Create("img", this.NodeName + "_Line");
		if (!this.ItemsNode) this.GetItemsNode();
		this.LineNode.Item = this;
		myTreeViewHelper.SetItem_LineNode(this.LineNode);

		if (myTreeViewHelper.IconSize) {
			this.LineNode.width = myTreeViewHelper.IconSize;
			this.LineNode.height = myTreeViewHelper.IconSize;
		}

		// 라인 비표시
		if (this.TreeView.UseLine == false) {
			// 접기 펼치기
			if (this.Items.length > 0) {
				if (this.Flg) this.LineNode.src = myTreeViewImg.Minus;
				else this.LineNode.src = myTreeViewImg.Plus;
				this.LineNode.onclick = function () {
					if (this.Item.Flg == false) { //더하기 버튼 클릭(펼치기)
						this.Item.SetFlg(true);
					}
					else { //더하기 버튼 클릭(접기)
						this.Item.SetFlg(false);
					}
				}
				//this.LineNode.style.visibility = "inherit";
			}
			else {
				//this.LineNode.style.visibility = "hidden";
				this.LineNode.src = myTreeViewImg.None;
			}
			return this.LineNode;
		}

		var isLast = (this.Parent.Items[this.Parent.Items.length - 1] == this);

		// 접기 펼치기
		if (this.Items.length > 0) {
			if (this.Flg) this.LineNode.src = (isLast) ? myTreeViewImg.Line_MinusBottom : myTreeViewImg.Line_Minus;
			else this.LineNode.src = (isLast) ? myTreeViewImg.Line_PlusBottom : myTreeViewImg.Line_Plus;
			this.LineNode.onclick = function () {
				if (this.Item.Flg == false) { //더하기 버튼 클릭(펼치기)
					this.Item.SetFlg(true);
				}
				else { //더하기 버튼 클릭(접기)
					this.Item.SetFlg(false);
				}
			}
		}
		else {
			this.LineNode.src = (isLast) ? myTreeViewImg.Line_JoinBottom : myTreeViewImg.Line_Join;
		}

		// 마지막인지 확인
		if (isLast) {
			this.ItemsNode.style.backgroundImage = "";
		}
		else {
			this.ItemsNode.style.backgroundImage = "url(" + myTreeViewImg.Line + ")";
			this.ItemsNode.style.backgroundRepeat = "repeat-y";
		}
		return this.LineNode;
	}

	// 아이콘이미지 가져오기
	this.GetIconNode = function () {
		var icon;
		if (this.Flg) {
			if (this.OpenIcon != null) icon = this.OpenIcon;
			else icon = this.Icon;
		}
		else icon = this.Icon;

		if (((typeof (icon) == "string") && (icon != "")) || (typeof (icon) == "number")) {
			if (!this.IconNode) this.IconNode = myObj.Create("img", this.NodeName + "_icon");
			if (typeof (icon) == "string") {
				this.IconNode.src = icon;
			}
			else {
				if (this.TreeView) {
					if (this.TreeView.ImgList) {
						if (this.TreeView.ImgList.length > parseInt(icon)) this.IconNode.src = this.TreeView.ImgList[parseInt(icon)];
					}
				}
			}
			if (myTreeViewHelper.IconSize) {
				this.IconNode.width = myTreeViewHelper.IconSize;
				this.IconNode.height = myTreeViewHelper.IconSize;
			}
			//this.IconNode.hspace = 2;
			myTreeViewHelper.SetItem_IconNode(this.IconNode);
			this.IconNode.Item = this;
		}
		return this.IconNode;
	}

	this.GetItemsNode = function () {
		if (!this.ItemsNode) {
			this.ItemsNode = myObj.Create("div", this.NodeName + "_Items");
			this.ItemsNode.Item = this;
			if (this.Items.length > 0) {
				for (var i = 0; i < this.Items.length; i++) {
					this.ItemsNode.appendChild(this.Items[i].GetHTMLNode());
				}
			}
			this.ItemsNode.style.paddingLeft = "20px";
		}
		this.ItemsNode.style.display = this.Flg ? "block" : "none";
		return this.ItemsNode;
	}

	// 컬럼별 표시 노드
	this.GetColumnNode = function (idx, column) {
		if (!this.ColumnNode[idx]) {
			this.ColumnNode[idx] = myObj.Create("div", this.NodeName + "_Column_" + idx);
			this.ColumnNode[idx].Item = this;
			this.ColumnNode[idx].Column = column;

			this.ColumnSelfNode[idx] = myObj.Create("div", this.NodeName + "_ColumnSelf_" + idx);
			this.ColumnSelfNode[idx].Item = this;
			this.ColumnSelfNode[idx].Column = column;
			this.ColumnSelfNode[idx].ColumnIndex = idx;
			myTreeViewHelper.SetColumn_BodySelfNode(this.ColumnSelfNode[idx]);
			this.ColumnSelfNode[idx].onmouseover = function () { if (!this.Item.Selected) myTreeViewHelper.SetOverItem_ColumnBodySelfNode(this.Item.ColumnSelfNode); }
			this.ColumnSelfNode[idx].onmouseout = function () { if (!this.Item.Selected) myTreeViewHelper.SetOutItem_ColumnBodySelfNode(this.Item.ColumnSelfNode); }
			this.ColumnNode[idx].appendChild(this.ColumnSelfNode[idx]);

			var value = "";
			if (this.Values) {
				if (this.Values[idx]) value = this.Values[idx];
			}
			this.ColumnTextNode[idx] = myObj.Create("span", this.NodeName + "_ColumnText_" + idx);
			this.ColumnTextNode[idx].Item = this;
			this.ColumnTextNode[idx].Column = column;
			this.ColumnTextNode[idx].ColumnIndex = idx;
			this.ColumnTextNode[idx].appendChild(document.createTextNode(value));
			this.ColumnTextNode[idx].value = value;
			this.ColumnTextNode[idx].title = value;
			myTreeViewHelper.SetColumn_BodyTextNode(this.ColumnTextNode[idx]);
			this.ColumnSelfNode[idx].appendChild(this.ColumnTextNode[idx]);

			this.ColumnChildNode[idx] = myObj.Create("div", this.NodeName + "_ColumnChild_" + idx);
			this.ColumnChildNode[idx].Item = this;
			if (this.Items.length > 0) {
				for (var i = 0; i < this.Items.length; i++) {
					this.ColumnChildNode[idx].appendChild(this.Items[i].GetColumnNode(idx, column));
				}
			}
			//this.ColumnChildNode[idx].style.border = "1px solid #0000FF";

			if (this.TreeView.IsEditMode) {
				if ((this.TreeView.EditModeTarget == "allItem") || (this.TreeView.EditModeTarget == "columnItem")) {
					myTreeViewHelper.SetColumn_EditMode(this.ColumnSelfNode[idx]);
					myTreeViewHelper.SetColumn_EditMode(this.ColumnTextNode[idx]);
					this.ColumnTextNode[idx].ondblclick = function (event) { this.Item.TreeView.SetItem_EditMode(this); }
					this.ColumnSelfNode[idx].ondblclick = function (event) { this.Item.TreeView.SetItem_EditMode(this.Item.ColumnTextNode[this.ColumnIndex]); }
				}
			}
			this.ColumnNode[idx].appendChild(this.ColumnChildNode[idx]);
		}
		this.ColumnChildNode[idx].style.display = this.Flg ? "block" : "none";
		return this.ColumnNode[idx];
	}

	// 인덱스 검색
	this.IndexOf = function (key) {
		if (typeof (key) != "string") return -1;
		var idx = -1;
		if (this.Items.length > 0) {
			for (var i = 0; i < this.Items.length; i++) {
				if (this.Items[i].Name == key) idx = i;
				else if (this.Items[i].Text) {
					if (this.Items[i].Text.indexOf(key) >= 0) idx = i;
				}
			}
		}
		return idx;
	}

	// 아이템 검색
	this.Search = function (key) {
		var sList = new Array();
		if (!key) return sList;
		var cList;
		if (this.Items.length > 0) {
			for (var i = 0; i < this.Items.length; i++) {
				cList = this.Items[i].Search(key);
				if (cList.length > 0) {
					for (var j = 0; j < cList.length; j++) sList.push(cList[j]);
				}
			}
		}
		if (this.Name.indexOf(key) >= 0) {
			sList.push(this);
		}
		else if (this.Text.indexOf(key) >= 0) {
			sList.push(this);
		}
		return sList;
	}

	// Item찾기
	this.FindItem = function (itemName) {
		var node = null;
		if (this.Items.length > 0) {
			for (var i = 0; i < this.Items.length; i++) {
				if (this.Items[i].Name == itemName) {
					return this.Items[i];
				}
				node = this.Items[i].FindItem(itemName);
				if (node != null) {
					return node;
				}
			}
		}
		return null;
	}

	this.SetFlg = function (flg) {
		this.Flg = flg;
		var flgStr = this.Flg ? "block" : "none";
		if (this.LineNode) {
			//this.LineNode.src = this.Flg ? myTreeViewImg.Minus : myTreeViewImg.Plus;
			this.GetLineNode();
			this.GetIconNode();
		}
		if (this.ItemsNode) {
			this.ItemsNode.style.display = flgStr;
		}
		if (this.ColumnChildNode) {
			for (var i = 0; i < this.ColumnChildNode.length; i++) {
				if (this.ColumnChildNode[i]) {
					this.ColumnChildNode[i].style.display = flgStr;
				}
			}
		}
		this.TreeView.AutoReSize();
	}

	this.ChildOpen = function () {
		this.SetFlg(true);
	}

	this.ChildClose = function () {
		this.SetFlg(false);
	}

	this.AllChildOpen = function () {
		if (this.Items.length > 0) {
			var tmp = this.TreeView.AutoResized;
			this.TreeView.AutoResized = false;
			for (var i = 0; i < this.Items.length; i++) {
				this.Items[i].AllChildOpen();
			}
			this.ChildOpen();
			this.TreeView.AutoResized = tmp;
		}
	}

	this.AllChildClose = function () {
		if (this.Items.length > 0) {
			var tmp = this.TreeView.AutoResized;
			this.TreeView.AutoResized = false;
			for (var i = 0; i < this.Items.length; i++) {
				this.Items[i].AllChildClose();
			}
			this.ChildClose();
			this.TreeView.AutoResized = tmp;
		}
	}

	this.AllChildSelect = function () {
		if (this.TreeView.UseAllChildSelect) {
			this.TreeView.SelectItem(this);
			if (this.Items.length > 0) {
				for (var i = 0; i < this.Items.length; i++) {
					this.Items[i].SelNode.checked = this.SelNode.checked;
					this.Items[i].AllChildSelect();
				}
			}
		}
	}

	this.Show = function () {
		if (this.Parent) {
			this.Parent.Show();
			this.ChildOpen();
		}
		//document.body.scrollTop = myObj.GetTop(this.HTMLNode);
		if (this.TreeView) {
			this.TreeView.HTMLNode.scrollTop = (this.HTMLNode.offsetTop - parseInt((this.TreeView.HTMLNode.offsetHeight / 2), 10));
		}
	}

	this.Select = function () {
		//if (this.SelNode) this.SelNode.checked = true;
		this.TreeView.SelectItem(this);
		this.Show();
	}

	// method - static
	this.IsEqual = function (item, item2) {
		if (item2) {
		}
		else {
		}
	}

	// event


}

// 트리뷰 이미지 정보 개체
// Images/btn_leftmenu_close.gif
// Images/btn_leftmenu_open.gif
var myTreeViewImg = {
	// property
	"Line": "/Resources/Framework/TreeImages/line.gif",
	"Line_Join": "/Resources/Framework/TreeImages/join.gif",
	"Line_JoinBottom": "/Resources/Framework/TreeImages/joinbottom.gif",
	"Plus": "/Resources/Framework/TreeImages/nolines_plus.gif",
	"Minus": "/Resources/Framework/TreeImages/nolines_minus.gif",
	//"Plus": "/Resources/Images/btn_leftmenu_open.gif",
	//"Minus": "/Resources/Images/btn_leftmenu_close.gif",
	"None": "/Resources/Framework/TreeImages/empty.gif",
	"Line_Plus": "/Resources/Framework/TreeImages/plus.gif",
	"Line_Minus": "/Resources/Framework/TreeImages/minus.gif",
	//"Line_Plus": "/Resources/Images/btn_leftmenu_open.gif",
	//"Line_Minus": "/Resources/Images/btn_leftmenu_close.gif",
	"Line_PlusBottom": "/Resources/Framework/TreeImages/plusbottom.gif",
	"Line_MinusBottom": "/Resources/Framework/TreeImages/minusbottom.gif",
	"Column_Bg": "/Resources/Framework/myTreeViewColumn_HeaderBG.gif"
	// style

	// method
}


// 기본 설정 및 스타일 설정
var myTreeViewHelper = {
	"IconSize": 18,

	GetUsedMaxWidth: function (obj, left) {
		if (typeof obj == 'string') obj = document.getElementById(obj);
		var width = 0;
		var tmpWidth = 0;
		if (obj) {
			if (!obj.style) return 0;
			if (obj.style.display == "none") return 0;
			if (obj.style.display == "inline" || (obj.nodeName == "IMG" && obj.style.display == "")) {
				width = (myObj.GetLeft(obj) + obj.offsetWidth) - left;
			}
			for (var i = 0; i < obj.childNodes.length; i++) {
				tmpWidth = myTreeViewHelper.GetUsedMaxWidth(obj.childNodes[i], left);
				if (tmpWidth > width) width = tmpWidth;
			}
			return width;
		}
	},

	GetSortItemFunction: function (tName) {
		var fnStr = "var fn = function(a, b) {";
		fnStr += "	if (a." + tName + "> b." + tName + ") return 1;"
		fnStr += "	else return -1;"
		fnStr += " }";
		var fn = null;
		eval(fnStr);
		return fn;
	},

	// style
	SetTreeView_HTMLNode: function (obj) {
		obj.style.height = "100%";
		obj.style.width = "100%";
		obj.style.overflow = "auto";
		obj.style.display = "block";
	},

	SetTreeView_ColumnHeadNode: function (obj) {
		obj.style.overflow = "hidden";
		obj.style.margin = "0px";
		obj.style.padding = "0px";
		obj.style.styleFloat = "left";
		obj.style.cssFloat = "left";
		obj.style.fontSize = "9pt";
		obj.style.height = "16px";
		obj.style.lineHeight = "16px";
		obj.style.paddingTop = "2px";
		//obj.style.borderTop = "1px solid #FFFFFF";
		obj.style.borderBottom = "2px solid #CCCCCC";
		obj.style.backgroundColor = "#EEEEEE";
	},

	SetOverItem_ColumnHeadNode: function (obj) {
		//obj.style.borderTop = "1px solid #FFFFFF";
		obj.style.borderBottom = "2px solid #FFCC00";
		obj.style.backgroundColor = "#FFFFFF";
	},

	SetOutItem_ColumnHeadNode: function (obj) {
		//obj.style.borderTop = "1px solid #FFFFFF";
		obj.style.borderBottom = "2px solid #CCCCCC";
		obj.style.backgroundColor = "#EEEEEE";
	},

	SetTreeView_ColumnHeadTextNode: function (obj) {
		obj.style.styleFloat = "left";
		obj.style.cssFloat = "left";
		obj.style.paddingLeft = "3px";
		obj.style.fontSize = "9pt";
		obj.style.color = "#666666";
		obj.style.verticalAlign = "middle";
		obj.style.overflow = "hidden";
		obj.style.whiteSpace = "nowrap";
		obj.style.textAlign = "left";
	},

	SetTreeView_ColumnBodyNode: function (obj) {
		obj.style.overflow = "hidden";
		obj.style.styleFloat = "left";
		obj.style.cssFloat = "left";
	},

	SetColumn_BodySelfNode: function (obj) {
		obj.style.height = "18px";
		obj.style.minHeight = "17px";
		obj.style.whiteSpace = "nowrap";
		//obj.style.overflow = "hidden";
		obj.style.padding = "1px";
	},

	SetSelectedItem_ColumnBodySelfNode: function (objs) {
		var start = 0;
		if (objs[0].Item.TreeView.Column[0].Index < 0) start = 1;
		for (var i = 0; i < objs.length; i++) {
			if (objs[i]) {
				if (objs[i].Item.TreeView.Column[start] == objs[i].Column) objs[i].style.borderLeft = "1px solid #999999";
				if (objs[i].Item.TreeView.Column[objs[i].Item.TreeView.Column.length - 1] == objs[i].Column)
					objs[i].style.borderRight = "1px solid #999999";

				objs[i].style.color = "#000000";
				objs[i].style.backgroundColor = "#DDDDFF";
				objs[i].style.padding = "0px";
				objs[i].style.borderTop = "1px solid #999999";
				objs[i].style.borderBottom = "1px solid #999999";
			}
		}
	},

	SetCancelItem_ColumnBodySelfNode: function (objs) {
		var start = 0;
		if (objs[0].Item.TreeView.Column[0].Index < 0) start = 1;
		for (var i = 0; i < objs.length; i++) {
			if (objs[i]) {
				if (objs[i].Item.TreeView.Column[start] == objs[i].Column) objs[i].style.borderLeft = "0px none";
				if (objs[i].Item.TreeView.Column[objs[i].Item.TreeView.Column.length - 1] == objs[i].Column)
					objs[i].style.borderRight = "0px none";
				objs[i].style.color = "#000000";
				objs[i].style.backgroundColor = "#FFFFFF";
				objs[i].style.padding = "1px";
				objs[i].style.borderTop = "0px none";
				objs[i].style.borderBottom = "0px none";
			}
		}
	},

	SetOverItem_ColumnBodySelfNode: function (objs) {
		for (var i = 0; i < objs.length; i++) {
			if (objs[i]) {
				objs[i].style.backgroundColor = "#EEEEFF";
			}
		}
	},

	SetOutItem_ColumnBodySelfNode: function (objs) {
		for (var i = 0; i < objs.length; i++) {
			if (objs[i]) {
				objs[i].style.backgroundColor = "#FFFFFF";
			}
		}
	},

	SetColumn_BodyTextNode: function (obj) {
		obj.style.display = "inline";
		obj.style.fontSize = "9pt";
		obj.style.lineHeight = "16px";
		obj.style.padding = "0px 0px 0px 3px";
		//obj.style.margin = "0px 0px 0px 3px";
		obj.style.whiteSpace = "nowrap";
		obj.style.verticalAlign = "middle";
		//obj.style.overflow = "hidden";
	},

	SetColumn_LineNode: function (obj) {
		obj.style.backgroundColor = "#DDDDDD";
		obj.style.width = "1px";
		obj.style.height = "100%";
	},

	SetColumn_EditMode: function (obj) {
		obj.style.cursor = "pointer";
	},

	SetItem_HTMLNode: function (obj) {
		obj.style.margin = "0px";
	},

	SetItem_SelfNode: function (obj) {
		obj.style.whiteSpace = "nowrap";
	},

	SetItem_LineNode: function (obj) {
		obj.style.verticalAlign = "middle";
		obj.style.cursor = "pointer";
		obj.style.verticalAlign = "middle";
		obj.style.display = "inline";
	},

	SetItem_FlgNode: function (obj) {
		obj.style.verticalAlign = "middle";
		obj.style.cursor = "pointer";
	},

	SetItem_IconNode: function (obj) {
		obj.style.verticalAlign = "middle";
		obj.style.marginLeft = "2px";
	},

	SetItem_SelNode: function (obj) {
		obj.style.verticalAlign = "middle";
		obj.style.width = "15px";
		obj.style.height = "15px";
		obj.style.margin = "0px 0px 0px 2px";
		//obj.style.border = "1px dotted #FFFFFF";
	},

	SetItem_TextNode: function (obj) {
		obj.style.display = "inline";
		obj.style.cursor = "pointer";
		//obj.style.fontSize = "9pt";
        obj.style.fontSize = "9.3pt";
		obj.style.marginTop = "1px";
		obj.style.whiteSpace = "nowrap";
		obj.style.verticalAlign = "middle";
		obj.style.overflow = "hidden";
		obj.style.padding = "1px";
	},

	SetSelectedItem_TextNode: function (obj) {
		obj.style.color = "#FFFFFF";
		obj.style.backgroundColor = "#826B49";
		obj.style.border = "1px dotted #FFFFFF";
		obj.style.padding = "0px";
	},

	SetCancelItem_TextNode: function (obj) {
		obj.style.color = ""; // "#000000";
		obj.style.backgroundColor = ""; //;obj.Item.TreeView.BgColor;
		obj.style.border = "0px none";
		obj.style.padding = "1px";
	},

	SetULNodeToList: function (obj) {
		obj.style.overflow = "hidden";
		obj.style.margin = "0px";
		obj.style.padding = "0px";
	}
}

// 트리아이템 드래그 개체
var myTreeViewDragItem = {
	// property
	"TreeView": "",
	"Item": "",
	"TargetItem": "",
	"IsUse": false,
	"Width": "0",
	"Height": "0",
	"X": "0",
	"Y": "0",
	"Interval": "",
	// style

	// method
	SetPosition: function () {
		if (typeof (myTreeViewDragItem.Item) == "object") {
			var scroll = myObj.GetNowScroll();
			myTreeViewDragItem.Item.style.left = myTreeViewDragItem.X + scroll.X + 5 + "px";
			myTreeViewDragItem.Item.style.top = myTreeViewDragItem.Y + scroll.Y + 5 + "px";
		}
	},

	onmousemove: function (event) {
		if (typeof (myTreeViewDragItem.Item) == "object") {
			myTreeViewDragItem.X = event.clientX;
			myTreeViewDragItem.Y = event.clientY;
		}
	},

	onmouseup: function (event) {
		if (typeof (myTreeViewDragItem.Item) == "object") {
			window.clearInterval(myTreeViewDragItem.Interval);
			myObj.detachEvent(document, "mousemove", myTreeViewDragItem.onmousemove);
			myObj.detachEvent(document, "mouseup", myTreeViewDragItem.onmouseup);
			myObj.Remove(myTreeViewDragItem.Item);
			myTreeViewDragItem.TreeView.IsMouseDrag = false;
			myTreeViewDragItem.IsUse = false;
			if (myTreeViewDragItem.TargetItem) {
				myTreeViewDragItem.TargetItem.TreeView.MoveItem();
				myTreeViewDragItem.TargetItem.TextNode.style.backgroundColor = myTreeViewDragItem.TreeView.BgColor;
				myTreeViewDragItem.TargetItem.TextNode.style.border = "0px none";
				myTreeViewDragItem.TargetItem = "";
			}
		}
	}
}


// 트리뷰 컬럼 사이즈변경 드래그 개체
var myTreeViewColumnResizeDrag = {
	// property
	"TreeView": "",
	"TreeViewColumn": "",
	"Item": "",
	"IsUse": false,
	"Width": "1",
	"Height": "0",
	"Color": "#000000",
	"X": "0",
	"Y": "0",
	"LimitX": "0",
	"LimitWidth": "0",
	"Interval": "",
	"Timeout": "",
	// style

	// method
	SetPosition: function () {
		if (typeof (myTreeViewColumnResizeDrag.Item) == "object") {
			myTreeViewColumnResizeDrag.Item.style.left = myTreeViewColumnResizeDrag.X + document.body.scrollLeft + "px";
			myTreeViewColumnResizeDrag.Item.style.top = myTreeViewColumnResizeDrag.Y + document.body.scrollTop + "px";
			myTreeViewColumnResizeDrag.Item.style.height = myTreeViewColumnResizeDrag.Height + "px";
			myTreeViewColumnResizeDrag.Item.style.display = "block";
			document.body.style.cursor = "col-resize";
		}
		else {
			myTreeViewColumnResizeDrag.Item = myObj.Create("div", "myTreeViewColumnResizeDrag_Item");
			myObj.SetNotSelection(myTreeViewColumnResizeDrag.Item);
			document.body.appendChild(myTreeViewColumnResizeDrag.Item);
			myTreeViewColumnResizeDrag.Item.style.position = "absolute";
			myTreeViewColumnResizeDrag.Item.style.height = myTreeViewColumnResizeDrag.Height + "px";
			myTreeViewColumnResizeDrag.Item.style.width = myTreeViewColumnResizeDrag.Width + "px";
			myTreeViewColumnResizeDrag.Item.style.left = myTreeViewColumnResizeDrag.X + document.body.scrollLeft + "px";
			myTreeViewColumnResizeDrag.Item.style.top = myTreeViewColumnResizeDrag.Y + document.body.scrollTop + "px";
			myTreeViewColumnResizeDrag.Item.style.backgroundColor = myTreeViewColumnResizeDrag.Color;
			myTreeViewColumnResizeDrag.Item.style.display = "block";
		}
	},

	onmousemove: function (event) {
		if (typeof (myTreeViewColumnResizeDrag.Item) == "object") {
			myTreeViewColumnResizeDrag.X = event.clientX;
			//myTreeViewColumnResizeDrag.Y = event.clientY;
		}
	},

	onmouseup: function (event) {
		if (typeof (myTreeViewColumnResizeDrag.Item) == "object") {
			window.clearInterval(myTreeViewColumnResizeDrag.Interval);
			myObj.detachEvent(document, "mousemove", myTreeViewColumnResizeDrag.onmousemove);
			myObj.detachEvent(document, "mouseup", myTreeViewColumnResizeDrag.onmouseup);
			myTreeViewColumnResizeDrag.Item.style.display = "none";
			document.body.style.cursor = "auto";
			var colLeft = parseInt(myObj.GetLeft(myTreeViewColumnResizeDrag.TreeViewColumn.HeadNode), 10);
			var x = ((parseInt(myTreeViewColumnResizeDrag.X, 10) + myTreeViewColumnResizeDrag.TreeViewColumn.TreeView.HTMLNode.scrollLeft) - colLeft);
			myTreeViewColumnResizeDrag.TreeViewColumn.ReSizeTo(x);
		}
	}
}


var myTreeViewEditItem = {
	// property
	"TreeView": null,
	"Item": null,
	"EditItem": null,
	"IsUse": false,
	"Width": 0,
	"Height": 0,
	"scrollTop": 0,
	"scrollLeft": 0,
	"Interval": null,
	// style

	// method
	Cancel: function () {
		if (typeof (myTreeViewEditItem.EditItem) == "object") {
			myTreeViewEditItem.EditItem.blur();
			myTreeViewEditItem.EditItem = null;
		}
	},

	// 다른 위치 클릭시
	onclick: function (event) {
		if (!myTreeViewEditItem.IsUse) {
			myTreeViewEditItem.Cancel();
		}
	},

	// 스크롤 이동시
	onmovescroll: function () {
		if (myTreeViewEditItem.scrollTop != myTreeViewEditItem.TreeView.HTMLNode.scrollTop) myTreeViewEditItem.Cancel();
		else if (myTreeViewEditItem.scrollLeft != myTreeViewEditItem.TreeView.HTMLNode.scrollLeft) myTreeViewEditItem.Cancel();
	}
}

/////// EventItems
var myTreeViewEvent = {
	"ItemMove": "ItemMove",
	"ItemClick": "ItemClick"
}

var myTreeViewEventItem_ItemMove = function (before, after, Item) {
	this.beforeParent = before;
	this.afterParent = after;
	this.Item = Item;
}


// 테그 개체 관련 control
var myObj = {
	// 생성
	Create: function (type, name) {
		if (typeof (type) != "string") return;
		var obj = document.createElement(type);
		if (name) {
			obj.setAttribute("name", name, 0);
			obj.setAttribute("id", name, 0);
		}
		return obj;
	},
	// 삭제
	Remove: function (obj) {
		if (typeof (obj) == "string") {
			obj = document.getElementById(obj);
		}
		if (typeof (obj) != "object") return false;
		while (obj.childNodes.length > 0) {
			myObj.Remove(obj.childNodes[0]);
		}
		obj.parentNode.removeChild(obj);
		return;
	},
	// 모두 삭제
	RemoveAllChild: function (obj) {
		if (typeof (obj) == "string") {
			obj = document.getElementById(obj);
		}
		if (typeof (obj) != "object") return false;
		while (obj.childNodes.length > 0) {
			myObj.Remove(obj.childNodes[0]);
		}
	},
	// 이벤트 삽입
	attachEvent: function (obj, sEvent, fpNotify) {
		if (obj.addEventListener) {
			obj.addEventListener(sEvent, fpNotify, false)
		} else {
			obj.attachEvent("on" + sEvent, fpNotify)
		}
	},
	// 이벤트 제거
	detachEvent: function (obj, sEvent, fpNotify) {
		if (obj.removeEventListener) {
			obj.removeEventListener(sEvent, fpNotify, false)
		} else {
			obj.detachEvent("on" + sEvent, fpNotify)
		}
	},
	// 좌우 좌표
	GetLeft: function (obj) {
		if (typeof obj == 'string') obj = document.getElementById(obj);
		if (obj) {
			if (obj.offsetParent == document.body)
				return obj.offsetLeft + obj.offsetParent.offsetLeft;
			else return obj.offsetLeft + this.GetLeft(obj.offsetParent);
		}
		return 0;
	},
	// 상하 좌표
	GetTop: function (obj) {
		if (typeof obj == 'string') obj = document.getElementById(obj);
		if (obj) {
			if (obj.offsetParent == document.body)
				return obj.offsetTop + obj.offsetParent.offsetTop;
			else return obj.offsetTop + this.GetTop(obj.offsetParent);
		}
		return 0;
	},
	// 선택 방지 설정
	SetNotSelection: function (obj) {
		if (typeof obj == 'string') obj = document.getElementById(obj);
		if (obj) {
			if (typeof document.onselectstart != "undefined")
				obj.onselectstart = function () { return false; }
			else {
				document.onmousedown = function (e) {
					if (["input", "textarea", "select"].indexOf(e.target.tagName.toLowerCase()) == -1)
						return false;
				}
				obj.onmouseup = function () { return true; }
			}
		}
	},
	GetStyle: function (strClass) {
		var objStyle;
		for (var i = 0; i < document.styleSheets[0].rules.length; i++) {
			if (document.styleSheets[0].rules[i].selectorText == strClass) {
				objStyle = document.styleSheets[0].rules[i].style;
				break;
			}
		}  //cssRules
		return objStyle;
	},
	// 스크롤위치 알아내기
	GetNowScroll: function () {
		var de = document.documentElement;
		var b = document.body;
		var now = {};
		now.X = document.all ? (!de.scrollLeft ? b.scrollLeft : de.scrollLeft) : (window.pageXOffset ? window.pageXOffset : window.scrollX);
		now.Y = document.all ? (!de.scrollTop ? b.scrollTop : de.scrollTop) : (window.pageYOffset ? window.pageYOffset : window.scrollY);
		return now;
	}
};

// 레이어 컨트롤
var WebLayer = function (id) {
	this.Items = id;
	this.eq = function (num) {
		$("#" + id).parent().find(".title_02 li a").eq(num).click();
	};
	this.show = function () {
		$("#" + id).parent().find(".title_01 li a:last img").attr("src", "/Resources/Images/btn_table_close.gif");
		$("#" + id).parent().find(".title_02 li a:last img").attr("src", "/Resources/Images/btn_table_close.gif");
		$("#" + id).show();
	};
	this.hide = function () {
		$("#" + id).parent().find(".title_01 li a:last img").attr("src", "/Resources/Images/btn_table_open.gif");
		$("#" + id).parent().find(".title_02 li a:last img").attr("src", "/Resources/Images/btn_table_open.gif");
		$("#" + id).hide();
	};
};

// 보라에디터 컨트롤
function ClearEditorHtml() {
    var web_editor = document.getElementById("WEC");
    web_editor.NewDocument();
}

function GetEditorHtml() {
    // 에디터
    var web_editor = document.getElementById("WEC");
    // guid
    var unid = guid();
    // 이미지가 로드될 경로
    

    //var src = location.protocol + "//" + location.hostname + "/Resources/Framework/ImageFullsize.aspx?URL=" + unid + "/";
    var src = "/Resources/Framework/editorimage.aspx?URL=" + unid + "/";
    // 경로 재설정
    var html = web_editor.GetHtmlSrc().replace(/.\/boratemp.files\//ig, src);

    document.getElementById("WEC").UploadImageDomino(location.protocol + "//" + location.host + "/Resources/Framework/editorupload.ashx", unid);

    return html; // html을 리턴함
}
function SetEditorHtml(html) {
    if ($("#WEC").length == 0) return;// 없음 리턴
    if ($("#WEC").get(0).nodeName == "OBJECT") { // ActiveX일시 값 입력
        document.getElementById("WEC").PutHtmlSrc(html);
    }
    else { // 아닐시 읽기모드
        $("#WEC").contents().find("html").html(html);
    }
}

// JSON 처리
if (typeof JSON !== 'object') {
	JSON = {};
}

(function () {
	'use strict';

	function f(n) {
		// Format integers to have at least two digits.
		return n < 10 ? '0' + n : n;
	}

	if (typeof Date.prototype.toJSON !== 'function') {

		Date.prototype.toJSON = function () {

			return isFinite(this.valueOf())
                ? this.getUTCFullYear() + '-' +
                    f(this.getUTCMonth() + 1) + '-' +
                    f(this.getUTCDate()) + 'T' +
                    f(this.getUTCHours()) + ':' +
                    f(this.getUTCMinutes()) + ':' +
                    f(this.getUTCSeconds()) + 'Z'
                : null;
		};

		String.prototype.toJSON =
            Number.prototype.toJSON =
            Boolean.prototype.toJSON = function () {
            	return this.valueOf();
            };
	}

	var cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
        escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
        gap,
        indent,
        meta = {    // table of character substitutions
        	'\b': '\\b',
        	'\t': '\\t',
        	'\n': '\\n',
        	'\f': '\\f',
        	'\r': '\\r',
        	'"': '\\"',
        	'\\': '\\\\'
        },
        rep;


	function quote(string) {

		// If the string contains no control characters, no quote characters, and no
		// backslash characters, then we can safely slap some quotes around it.
		// Otherwise we must also replace the offending characters with safe escape
		// sequences.

		escapable.lastIndex = 0;
		return escapable.test(string) ? '"' + string.replace(escapable, function (a) {
			var c = meta[a];
			return typeof c === 'string'
                ? c
                : '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
		}) + '"' : '"' + string + '"';
	}


	function str(key, holder) {

		// Produce a string from holder[key].

		var i,          // The loop counter.
            k,          // The member key.
            v,          // The member value.
            length,
            mind = gap,
            partial,
            value = holder[key];

		// If the value has a toJSON method, call it to obtain a replacement value.

		if (value && typeof value === 'object' &&
                typeof value.toJSON === 'function') {
			value = value.toJSON(key);
		}

		// If we were called with a replacer function, then call the replacer to
		// obtain a replacement value.

		if (typeof rep === 'function') {
			value = rep.call(holder, key, value);
		}

		// What happens next depends on the value's type.

		switch (typeof value) {
			case 'string':
				return quote(value);

			case 'number':

				// JSON numbers must be finite. Encode non-finite numbers as null.

				return isFinite(value) ? String(value) : 'null';

			case 'boolean':
			case 'null':

				// If the value is a boolean or null, convert it to a string. Note:
				// typeof null does not produce 'null'. The case is included here in
				// the remote chance that this gets fixed someday.

				return String(value);

				// If the type is 'object', we might be dealing with an object or an array or
				// null.

			case 'object':

				// Due to a specification blunder in ECMAScript, typeof null is 'object',
				// so watch out for that case.

				if (!value) {
					return 'null';
				}

				// Make an array to hold the partial results of stringifying this object value.

				gap += indent;
				partial = [];

				// Is the value an array?

				if (Object.prototype.toString.apply(value) === '[object Array]') {

					// The value is an array. Stringify every element. Use null as a placeholder
					// for non-JSON values.

					length = value.length;
					for (i = 0; i < length; i += 1) {
						partial[i] = str(i, value) || 'null';
					}

					// Join all of the elements together, separated with commas, and wrap them in
					// brackets.

					v = partial.length === 0
                    ? '[]'
                    : gap
                    ? '[\n' + gap + partial.join(',\n' + gap) + '\n' + mind + ']'
                    : '[' + partial.join(',') + ']';
					gap = mind;
					return v;
				}

				// If the replacer is an array, use it to select the members to be stringified.

				if (rep && typeof rep === 'object') {
					length = rep.length;
					for (i = 0; i < length; i += 1) {
						if (typeof rep[i] === 'string') {
							k = rep[i];
							v = str(k, value);
							if (v) {
								partial.push(quote(k) + (gap ? ': ' : ':') + v);
							}
						}
					}
				} else {

					// Otherwise, iterate through all of the keys in the object.

					for (k in value) {
						if (Object.prototype.hasOwnProperty.call(value, k)) {
							v = str(k, value);
							if (v) {
								partial.push(quote(k) + (gap ? ': ' : ':') + v);
							}
						}
					}
				}

				// Join all of the member texts together, separated with commas,
				// and wrap them in braces.

				v = partial.length === 0
                ? '{}'
                : gap
                ? '{\n' + gap + partial.join(',\n' + gap) + '\n' + mind + '}'
                : '{' + partial.join(',') + '}';
				gap = mind;
				return v;
		}
	}

	// If the JSON object does not yet have a stringify method, give it one.

	if (typeof JSON.stringify !== 'function') {
		JSON.stringify = function (value, replacer, space) {

			// The stringify method takes a value and an optional replacer, and an optional
			// space parameter, and returns a JSON text. The replacer can be a function
			// that can replace values, or an array of strings that will select the keys.
			// A default replacer method can be provided. Use of the space parameter can
			// produce text that is more easily readable.

			var i;
			gap = '';
			indent = '';

			// If the space parameter is a number, make an indent string containing that
			// many spaces.

			if (typeof space === 'number') {
				for (i = 0; i < space; i += 1) {
					indent += ' ';
				}

				// If the space parameter is a string, it will be used as the indent string.

			} else if (typeof space === 'string') {
				indent = space;
			}

			// If there is a replacer, it must be a function or an array.
			// Otherwise, throw an error.

			rep = replacer;
			if (replacer && typeof replacer !== 'function' &&
                    (typeof replacer !== 'object' ||
                    typeof replacer.length !== 'number')) {
				throw new Error('JSON.stringify');
			}

			// Make a fake root object containing our value under the key of ''.
			// Return the result of stringifying the value.

			return str('', { '': value });
		};
	}


	// If the JSON object does not yet have a parse method, give it one.

	if (typeof JSON.parse !== 'function') {
		JSON.parse = function (text, reviver) {

			// The parse method takes a text and an optional reviver function, and returns
			// a JavaScript value if the text is a valid JSON text.

			var j;

			function walk(holder, key) {

				// The walk method is used to recursively walk the resulting structure so
				// that modifications can be made.

				var k, v, value = holder[key];
				if (value && typeof value === 'object') {
					for (k in value) {
						if (Object.prototype.hasOwnProperty.call(value, k)) {
							v = walk(value, k);
							if (v !== undefined) {
								value[k] = v;
							} else {
								delete value[k];
							}
						}
					}
				}
				return reviver.call(holder, key, value);
			}


			// Parsing happens in four stages. In the first stage, we replace certain
			// Unicode characters with escape sequences. JavaScript handles many characters
			// incorrectly, either silently deleting them, or treating them as line endings.

			text = String(text);
			cx.lastIndex = 0;
			if (cx.test(text)) {
				text = text.replace(cx, function (a) {
					return '\\u' +
                        ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
				});
			}

			// In the second stage, we run the text against regular expressions that look
			// for non-JSON patterns. We are especially concerned with '()' and 'new'
			// because they can cause invocation, and '=' because it can cause mutation.
			// But just to be safe, we want to reject all unexpected forms.

			// We split the second stage into 4 regexp operations in order to work around
			// crippling inefficiencies in IE's and Safari's regexp engines. First we
			// replace the JSON backslash pairs with '@' (a non-JSON character). Second, we
			// replace all simple value tokens with ']' characters. Third, we delete all
			// open brackets that follow a colon or comma or that begin the text. Finally,
			// we look to see that the remaining characters are only whitespace or ']' or
			// ',' or ':' or '{' or '}'. If that is so, then the text is safe for eval.

			if (/^[\],:{}\s]*$/
                    .test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@')
                        .replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']')
                        .replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {

				// In the third stage we use the eval function to compile the text into a
				// JavaScript structure. The '{' operator is subject to a syntactic ambiguity
				// in JavaScript: it can begin a block or an object literal. We wrap the text
				// in parens to eliminate the ambiguity.

				j = eval('(' + text + ')');

				// In the optional fourth stage, we recursively walk the new structure, passing
				// each name/value pair to a reviver function for possible transformation.

				return typeof reviver === 'function'
                    ? walk({ '': j }, '')
                    : j;
			}

			// If the text is not JSON parseable, then a SyntaxError is thrown.

			throw new SyntaxError('JSON.parse');
		};
	}
} ());

// 메시징 처리
var MessageBox = function () {
    this.show = function (str, fn) {
        // 이벤트 중복 방지를 위하여 호출시 이벤트 초기화
        $("#alert_btn").unbind("click");
        $("#MsgBoxCloseBtn").unbind("click");

        str = str == undefined ? "" : str;

        document.getElementById("digContents").innerHTML = str;

        // 현재페이지의 높이
        var nowPageHeight = $(document).height();
        // 현재 페이지의 넓이
        var nowPageWidth = $(document).width();
        // Msgbox 의 높이 : 210 Msgbox 의 넓이 : 342
        // 위치 공식

        // 상단이미지 변경
        $("#MsgBoxHeaderImg").attr("src", "/Resources/Images/MsgBox/icon_warning.png");

        if (document.getElementById("sub_popup_left_content")) {
            nowPageHeight = (nowPageHeight - document.getElementById("sub_popup_left_content").scrollTop) / 2 - 210 / 2;
        } else {
            //nowPageHeight = nowPageHeight / 2 - 210 / 2;
            // 높이는 스크롤높이 /2 + 윈도우높이
            nowPageHeight = $(window).height() / 2 + $(document).scrollTop() - 100;
        }
        nowPageWidth = nowPageWidth / 2 - 342 / 2;

        $("#Msg_box").css("top", nowPageHeight);
        $("#Msg_box").css("left", nowPageWidth);

        $("#Msg_box_bg").height($(document).height()); //screen.height);
        $("#Msg_box_bg").show();

        $("#Msg_box").show();
        $(".MsgBoxClass").hide();
        $("#alert_btn").show();
        // 처음 해재
        $(document).unbind('keydown');
        // space-bar, enter 키 이벤트 구독
        setTimeout(function () {
            $(document).bind('keydown', function (e) {
                if (e.keyCode == '13' || e.keyCode == '32' || e.keyCode == '27') {
                    $("#alert_btn").click();
                    return false;
                }
            });
        }, 100);

        $("#alert_btn").click(function () {
            $("#Msg_box_bg").hide();
            $('#Msg_box').hide();
            // space-bar, enter 키 이벤트 해제
            $(document).unbind('keydown');

            if (typeof (fn) == "function") {
                fn();
            }
        });

        $("#MsgBoxCloseBtn").click(function () {
            $("#alert_btn").click();

            $(document).unbind('keydown');
        });

        return false;
    };
    this.confirm = function (str, fn, fn2) {
        // 이벤트 중복 방지를 위하여 호출시 이벤트 초기화
        $("#MsgBoxConfirmOK").unbind("click");
        $("#MsgBoxConfirmCancel").unbind("click");
        $("#MsgBoxCloseBtn").unbind("click");

        document.getElementById("digContents").innerHTML = str;

        // 상단이미지 변경
        $("#MsgBoxHeaderImg").attr("src", "/Resources/Images/MsgBox/icon_question.png");

        // 현재페이지의 높이
        var nowPageHeight = $(document).height();
        // 현재 페이지의 넓이
        var nowPageWidth = $(document).width();
        // Msgbox 의 높이 : 210 Msgbox 의 넓이 : 342
        // 위치 공식
        if (document.getElementById("sub_popup_left_content")) {
            nowPageHeight = (nowPageHeight - document.getElementById("sub_popup_left_content").scrollTop) / 2 - 210 / 2;
        } else {
            nowPageHeight = nowPageHeight / 2 - 210 / 2;
        }
        nowPageWidth = nowPageWidth / 2 - 342 / 2;
        //$("#Msg_box").css("top", "40%");
        //$("#Msg_box").css("left", "40%");
        $("#Msg_box").css("top", nowPageHeight);
        $("#Msg_box").css("left", nowPageWidth);

        $("#Msg_box_bg").show();
        $("#Msg_box").show();

        // 처음 해재
        $(document).unbind('keydown');
        // space-bar, enter 키 이벤트 구독
        $(document).bind('keydown', function (e) {
            if (e.keyCode == '13' || e.keyCode == '32') {
                $("#MsgBoxConfirmOK").click();
            }
            else if (e.keyCode == '27') {
                $("#MsgBoxConfirmCancel").click();
            }
        });

        $(".MsgBoxClass").hide();
        $("#confirm_btn").show();

        $("#MsgBoxConfirmOK").click(function () {
            $("#Msg_box_bg").hide();
            $('#Msg_box').hide();

            // space-bar, enter 키 이벤트 해제
            $(document).unbind('keydown');

            if (typeof (fn) == "function") {
                fn();
            }
        });
        $("#MsgBoxConfirmCancel").click(function () {
            $("#Msg_box_bg").hide();
            $('#Msg_box').hide();

            // space-bar, enter 키 이벤트 해제
            $(document).unbind('keydown');

            if (typeof (fn2) == "function") {
                fn2();
            }
        });
        $("#MsgBoxCloseBtn").click(function () {
            $("#MsgBoxConfirmCancel").click();

            $(document).unbind('keydown');
        });
        return false;
    };
    this.prompt = function (title, body, fn) {
        // 이벤트 중복 방지를 위하여 호출시 이벤트 초기화
        $("#OpinionBoxOK").unbind("click");
        $("#OpinionBoxCancel").unbind("click");
        $("#OpinionBoxCloseBtn").unbind("click");
        $("#OpinTypeHeader").html(title);

        document.getElementById("OpinionBoxContentsBody").innerHTML = body;

        // 현재페이지의 높이
        var nowPageHeight = $(document).height();
        // 현재 페이지의 넓이
        var nowPageWidth = $(document).width();
        // Msgbox 의 높이 : 210 Msgbox 의 넓이 : 342
        // 위치 공식

        nowPageHeight = nowPageHeight / 2 - 210 / 2;
        nowPageWidth = nowPageWidth / 2 - 342 / 2;

        $("#OpinionBox").css("top", nowPageHeight);
        $("#OpinionBox").css("left", nowPageWidth);

        $("#Msg_box_bg").show();
        $("#OpinionBox").show();

        // space-bar, enter 키 이벤트 구독
        $(document).bind('keydown', function (e) {
            if (e.keyCode == '27') {
                $("#OpinionBoxCancel").click();
            }
        });

        $(".OpinionBoxClass").hide();
        $("#OpinionBoxBtn").show();

        $("#OpinionBoxOK").click(function () {
            $("#Msg_box_bg").hide();
            $('#OpinionBox').hide();

            $(document).unbind('keydown');

            if (typeof (fn) == "function") {
                fn(document.getElementById("OpinionBoxContentsBody").value);
            }

        });
        $("#OpinionBoxCancel").click(function () {
            $("#Msg_box_bg").hide();
            $('#OpinionBox').hide();

            $(document).unbind('keydown');
        });
        $("#OpinionBoxCloseBtn").click(function () {
            $("#OpinionBoxCancel").click();

            $(document).unbind('keydown');
        });

        $("#OpinionBoxContentsBody").focus();

        return false;
    };
}

// Message Box 호출
var MsgBox = new MessageBox();

// ScriptManeger PageMethods 대체하여 구현
var PageMethod = function () {
	this.urlString = location.href.split('?')[0];
	this.urlString = this.urlString.length - 1 == this.urlString.lastIndexOf('#') ? this.urlString.substr(0, this.urlString.length - 1) : this.urlString;

	this.Queue = new Array();
	this.Params = new Array();

	this.ExcuteMethodCnt = 0;

	this.InvokeServiceTable = function (data, type, method, _callback, _error) {
	    $.ajax({
	        type: "POST",
	        url: this.urlString + "/InvokeServiceTable",
	        data: "{ 'data': '" + ConvertEscapeString(JSON.stringify(data)) + "', 'typeString': '" + type + "', 'methodName': '" + method + "' }",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        success: function (res) {
	            // 리턴값은 res.d로 들어온다
	            if (_callback != undefined) {
	                _callback(res.d);
	            }
	        },
	        error: function (e) {
	            if (_error != undefined) {
	                e.get_message = function () {
	                    return this.responseJSON["Message"];
	                };
	                _error(e);
	            }
	        }
	    });
    };

    this.InvokeServiceTableSync = function (data, type, method, _callback, _error) {
        $.ajax({
            type: "POST",
            url: this.urlString + "/InvokeServiceTable",
            data: "{ 'data': '" + ConvertEscapeString(JSON.stringify(data)) + "', 'typeString': '" + type + "', 'methodName': '" + method + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (res) {
                // 리턴값은 res.d로 들어온다
                if (_callback != undefined) {
                    _callback(res.d);
                }
            },
            error: function (e) {
                if (_error != undefined) {
                    e.get_message = function () {
                        return this.responseJSON["Message"];
                    };
                    _error(e);
                }
            }
        });
    };

	this.InvokeServiceTableArray = function (data, dataArray, type, method, _callback, _error) {
	    $.ajax({
	        type: "POST",
	        url: this.urlString + "/InvokeServiceTableArray",
	        data: "{ 'data': '" + ConvertEscapeString(JSON.stringify(data)) + "', 'data2': '" + ConvertEscapeString(JSON.stringify(dataArray)) + "', 'typeString': '" + type + "', 'methodName': '" + method + "' }",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        success: function (res) {
	            // 리턴값은 res.d로 들어온다
	            if (_callback != undefined) {
	                _callback(res.d);
	            }
	        },
	        error: function (e) {
	            if (_error != undefined) {
	                e.get_message = function () {
	                    return this.responseJSON["Message"];
	                };
	                _error(e);
	            }
	        }
	    });
	};

	this.InvokeServiceTableArraySync = function (data, dataArray, type, method, _callback, _error) {
	    $.ajax({
	        type: "POST",
	        url: this.urlString + "/InvokeServiceTableArray",
	        data: "{ 'data': '" + ConvertEscapeString(JSON.stringify(data)) + "', 'data2': '" + ConvertEscapeString(JSON.stringify(dataArray)) + "', 'typeString': '" + type + "', 'methodName': '" + method + "' }",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        async: false,
	        success: function (res) {
	            // 리턴값은 res.d로 들어온다
	            if (_callback != undefined) {
	                _callback(res.d);
	            }
	        },
	        error: function (e) {
	            if (_error != undefined) {
	                e.get_message = function () {
	                    return this.responseJSON["Message"];
	                };
	                _error(e);
	            }
	        }
	    });
	};

	// 세션 유지
	this.InvokeSessionState = function () {
		var urlString = location.href.split('?')[0];
		urlString = urlString.length - 1 == urlString.lastIndexOf('#') ? urlString.substr(0, urlString.length - 1) : urlString;
		$.ajax({
			type: "POST",
			url: urlString + "/InvokeSessionState",
			data: "{}",
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function (res) {
				// 리턴값은 res.d로 들어온다
			}
		});
	};

    //Excel Download용 ajax 호출
    //2015.06.02 장상휘 추가
    this.InvokeServiceTable_Excel = function (data, dataArray, type, method, _callback, _error) {

        var urlString = location.href.split('?')[0];
        urlString = urlString.length - 1 == urlString.lastIndexOf('#') ? urlString.substr(0, urlString.length - 1) : urlString;
        $.ajax({
            type: "POST",
            url: urlString + "/InvokeServiceTable_Excel",
            data: "{ 'data': '" + ConvertEscapeString(JSON.stringify(data)) + "', 'data2': '" + ConvertEscapeString(JSON.stringify(dataArray)) + "', 'typeString': '" + type + "', 'methodName': '" + method + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (res) {
                // 리턴값은 res.d로 들어온다
                if (_callback != undefined) {
                    _callback(res.d);
                }
            },
            error: function (e) {
                if (_error != undefined) {
                    e.get_message = function () {
                        return this.responseJSON["Message"];
                    };
                    _error(e);
                }
            }
        });
    };

	function ConvertEscapeString(str) {
		str = str.replace(/\\/gi, "\\\\");
		str = str.replace(/"/gi, '\\"');
		str = str.replace(/'/gi, "\\'");

		return str;
	}
};

var PageMethods = new PageMethod();

/*****************************************************************************************************
* 별점평가(만족도) 컨트롤 JS
*****************************************************************************************************/
function rating_Click(id, obj) {
    $("#" + id).find("span.click_score").text(obj.value);
}

function svy_Click(svy, id, obj) {
    $("#" + id).find("span.click_score").text(obj.value);

    var cnt = svy.DetailCount == 0 ? 1 : svy.DetailCount;
    var score = 0.0;

    $("#" + svy.ID).find("input[type=radio]").each(function () {
        if ($(this).prop("checked")) {
            score += Number($(this).val());
        }
    });

    $("#" + svy.ID).find("span.svy_score").text((score / cnt).toFixed(2));
    $("#tmp_score").children(0).children(0).css("width", new String((score / cnt) * 10) + "%");
}


