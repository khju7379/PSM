// 주차 구하기
Date.prototype.getWeek = function() {
	var onejan = new Date(this.getFullYear(),0,1);
	return Math.ceil((((this - onejan) / 86400000) + onejan.getDay()+1)/7);
}

// 날짜 정보 객체
function DayInfo(_year, _month, _day, _title, _body, _holiday, _holdYear, _category, _isDefault) {
	this.year = _year;			// int		년도
	this.month = _month;		// int		월
	this.day = _day;			// int		일
	this.title = _title;		// string	제목
	this.body = _body;			// string	본문
	this.holiday = _holiday;	// bool		휴일여부
	this.holdYear = _holdYear;	// bool		년도고정(매년반복되면false)
	this.category = _category;	// string 	분류
	this.isDefault = _isDefault;// bool 	달력 기본일정
}
	
// myCalendar 객체 정의
function myCalendar(name,yyyy,mm,categories,viewDefaultDayTitle) {
	this.Name = name;
	if (categories) {
		this.Categories = categories;
	} else {
		this.Categories = new Array();
	}
    this.categories_bgColorTable = ["#ffe25c", "#c1e673", "#98b7e8", "#e25FFF"];
	this.DefaultDayTitleIsView = (viewDefaultDayTitle === undefined ? true : viewDefaultDayTitle);	//기본일정 표시여부
	this.legendTag = "";
	myCalendar_initialization(this,yyyy,mm);
	this.memorialDays = GetDefaultMemorialDays();
	this.addMemorialDay = AddMemorialDay;
	
	// 날짜 정보 타이틀 가져오기(string)
	this.GetDayTitle = function (year, month, date, showDefault) {
		if (showDefault === undefined) showDefault = true;
		var dayinfo = this.memorialDays[month][date];
		var retVal = new Array();
		if (dayinfo) {
			for (var i=0; i<dayinfo.length; i++) {
				if (dayinfo[i].isDefault == false || showDefault) {
					if (dayinfo[i].title) {
						if(dayinfo[i].holdYear) {
							if(dayinfo[i].year == year) retVal.push(dayinfo[i].title);
						} else {
							retVal.push(dayinfo[i].title);
						}
					}
				}
			}
		}
		return retVal;
	}

	// 날짜 정보 본문 가져오기(string)
	this.GetDayBody = function (year, month, date, category) {
		var IsViewAll = (category ? false : true);
		var dayinfo = this.memorialDays[month][date];
		var retVal = new Array();
		if (dayinfo) {
			for (var i=0; i<dayinfo.length; i++) {
				if (dayinfo[i].category == category || IsViewAll) {
					if (dayinfo[i].body) {
						if(dayinfo[i].holdYear) {
							if(dayinfo[i].year == year) retVal.push(dayinfo[i].body);
						} else {
							retVal.push(dayinfo[i].body);
						}
					}
				}
			}
		}
		return retVal;
	}

	// 휴일여부 출력(bool)
	this.isHoliday = function (year, month, date) {
		var dayinfo = this.memorialDays[month][date];
		var retVal = false;
		if (dayinfo) {
			for (var i=0; i<dayinfo.length; i++) {
				if(dayinfo[i].holdYear) {
					if(dayinfo[i].year == year) {
						if (dayinfo[i].holiday) return true;
					}
				} else {
					if (dayinfo[i].holiday) return true;
				}
			}
		}
		return retVal;
	}

	this.monthCnt = GetMonthCnt();
	this.Show = _ShowCalendar;
	
	this._PrevYear = function() {
		this.Year--;
		if (this.Year < 1900) {
			this.Year = 1900;
		}
	}
	
	this._NextYear = function() {
		this.Year++;
	}
	
	this.PrevYear = function() {
		this._PrevYear();
		this.onReload(this.Year, this.Month+1);
	}
	
	this.NextYear = function() {
		this._NextYear();
		this.onReload(this.Year, this.Month+1);
	}
	
	this.PrevMonth = function() {
		this.Month--;
		if (this.Month < 0) {
			this.Month = 11;
			this._PrevYear();
		}
		this.onReload(this.Year, this.Month+1);
	}
	this.NextMonth = function() {
		this.Month++;
		if (this.Month > 11) {
			this.Month = 0;
			this._NextYear();
		}
		this.onReload(this.Year, this.Month+1);
	}
	
	this.GetlunDate = function(cnt) {
		var mm = this.lunMonth;
		var dd = this.lunDay + cnt - 1;
		if(this.lunbig) {
			if (dd > 30) {
				mm++;
				dd = dd-30;
			}
		}
		else {
			if (dd > 29) {
				mm++;
				dd = dd-29;
			}
		}
		return " (" + mm + "." + dd +")";
	}
	// 2008-09-01 기준 음력날짜
	this.lunYear = 2008;
	this.lunMonth = 8;
	this.lunDay = 2;
	this.lunbig = false;
	
	// 이벤트 정의
	
	// 달력 새로고침
	this.onReload = function(year, month) {
		this.Show();
	}
	
	// 날짜 클릭
	this.onClickTitle = function(year, month, day) {
		tmpDay = new Date(year, month, day);
		alert(dateToString(tmpDay, "-"));
	}
}	

// 기본 날짜 정보
function GetDefaultMemorialDays() {
    memorialDays = new Array();

	// 1월
	memorialDays[0] = new Array();
	//memorialDays[0][0] = new Array();
	//memorialDays[0][0].push(new DayInfo(0,1,1,"신정","",true,false,true));
	// 2월
	memorialDays[1] = new Array();
	// 3월
	memorialDays[2] = new Array();
	// 4월
	memorialDays[3] = new Array();
	// 5월
	memorialDays[4] = new Array();
	// 6월
	memorialDays[5] = new Array();
	// 7월
	memorialDays[6] = new Array();
	// 8월
	memorialDays[7] = new Array();
	// 9월
	memorialDays[8] = new Array();
	// 10월
	memorialDays[9] = new Array();
	// 11월
	memorialDays[10] = new Array();
	// 12월
	memorialDays[11] = new Array();

	return memorialDays;
}

function AddMemorialDay(_year, _month, _day, _title, _body, _holiday, _holdYear, _category, _isDefault) {
	if (!this.memorialDays[_month-1][_day-1]) {
		this.memorialDays[_month-1][_day-1] = new Array();
	}
	this.memorialDays[_month-1][_day-1].push(new DayInfo(_year, _month, _day, _title, _body, _holiday, _holdYear, _category, _isDefault));
}

// 월별 일수
function GetMonthCnt() {
	var _monthCnt = new Array();
	_monthCnt[0] = 31;	//1월 일수
	_monthCnt[1] = 28;	//2월 일수
	_monthCnt[2] = 31;	//3월 일수
	_monthCnt[3] = 30;	//4월 일수
	_monthCnt[4] = 31;	//5월 일수
	_monthCnt[5] = 30;	//6월 일수
	_monthCnt[6] = 31;	//7월 일수
	_monthCnt[7] = 31;	//8월 일수
	_monthCnt[8] = 30;	//9월 일수
	_monthCnt[9] = 31;	//10월 일수
	_monthCnt[10] = 30;	//11월 일수
	_monthCnt[11] = 31;	//12월 일수
	return _monthCnt;
}

// myCalendar 초기설정
function myCalendar_initialization(parent,yyyy,mm) {
	var today;
	// 입력 년도 월 유효성 검사
	if (yyyy) {
		if (yyyy < 1900) {
			yyyy = 1900;
			mm = 0;
		}
		if (mm) {
			if (mm < 0) {
				yyyy--;
				mm = 11;
			} else if (mm > 11) {
				yyyy++;
				mm = 0;
			}
		}
	}
	parent.Year = yyyy;
	parent.Month = mm;
	parent.leapYear = (yyyy%400 == 0 || yyyy%100 !=0 && yyyy%4 == 0);
}

// myCalendar.Show() 함수 정의
function _ShowCalendar(contain) {
	if (!contain) {
		contain = this.contain;
	}
	else {
		this.contain = contain;
	}
	
	if (!contain) return;
	var name = this.Name;
	var year = this.Year;
	var month = this.Month;
	var tmpDay = new Date(year, month, 1);
	var tag = "";
	var colWidth;
	
	
	tag += '<div class="calendar_Day">';
	tag += '	<img src="/Resources/Framework/btn_pre02.gif" alt="Prev Year" title="" onclick="' + name + '.PrevYear();" style="cursor:pointer;"/>&nbsp;';
	tag += '<img src="/Resources/Framework/btn_pre01.gif" alt="Prev Month" title="" onclick="' + name + '.PrevMonth();" style="cursor:pointer;"/>&nbsp;' + dateToString(tmpDay).substr(0, 7) + '&nbsp;';
	tag += '<img src="/Resources/Framework/btn_next02.gif" alt="Next Month" title="" onclick="' + name + '.NextMonth();" style="cursor:pointer;"/>&nbsp;';
	tag += '<img src="/Resources/Framework/btn_next01.gif" alt="Next Year" title="" onclick="' + name + '.NextYear();" style="cursor:pointer;"/>';
	tag += '<div class="calendar_Legend">' + this.legendTag + "</div>";
	tag += '</div>';

	tag += '<table cellpadding="0" cellspacing="0" border="0" width="100%" class="calendar_Body" style="border-top:1px solid #AAAAAA;border-bottom:1px solid #AAAAAA;">';
	tag += '	<colgroup>';
	tag += '		<col style="width:3%;" />';
	tag += '		<col style="width:3%;" />';
	if (this.Categories.length > 0) {
		tag += '		<col style="width:5%;" />';
		colWidth = (89/7).toFixed(2);
	} else {
		colWidth = (94/7).toFixed(2);
	}
	tag += '		<col style="width:' + colWidth + '%;" />';
	tag += '		<col style="width:' + colWidth + '%;" />';
	tag += '		<col style="width:' + colWidth + '%;" />';
	tag += '		<col style="width:' + colWidth + '%;" />';
	tag += '		<col style="width:' + colWidth + '%;" />';
	tag += '		<col style="width:' + colWidth + '%;" />';
	tag += '		<col style="width:' + colWidth + '%;" />';
	tag += '	</colgroup>';
	
	tag += '	<tr>';
	tag += '		<th>M</th>';
	tag += '		<th>W</th>';
	if (this.Categories.length > 0) {
		tag += '		<th>Shift</th>';
	}
	tag += '		<th style="color:#FF0000;">Sun</th>';
	tag += '		<th>Mon</th>';
	tag += '		<th>Tue</th>';
	tag += '		<th>Wed</th>';
	tag += '		<th>Thu</th>';
	tag += '		<th>Fri</th>';
	tag += '		<th style="color:#0000FF;">Sat</th>';
	tag += '	</tr>';
				
					
	var dateCnt = 1;
	var startIdx = tmpDay.getDay();
	var endIdx = this.monthCnt[month] + startIdx;
	var dayClass = "";
	var dayColor = "";
	var rowCount = 0
	if ((year % 400 == 0 || year % 100 != 0 && year % 4 == 0) && (month == 1)) endIdx++;
	var RetVal = 0;
	
	rowCount = Math.floor(endIdx/7);
	if (rowCount%7 > 0) rowCount++;
	if (this.Categories.length > 0) {
		rowCount = rowCount * this.Categories.length;
	}
	tag += '<tr>';
	tag += '<th rowspan="' + rowCount + '">' + (month+1) + '</th>';
	for(var i=0;i<endIdx; i+=7) {
		if (this.Categories.length > 0) {
			if (i == 0) {
				tmpDay = new Date(year, month, (i-startIdx+7));
			} else {
				tmpDay = new Date(year, month, (i-startIdx+1));
			}
            tag += '<th rowspan="' + this.Categories.length + '" style="background:#ffffff;height:100px;font-size: 13px;">' + tmpDay.getWeek() + '</th>';
			for (var c=0; c<this.Categories.length; c++) {
			    tag += '<th style="color:#333333;background:' + this.categories_bgColorTable[c] + ';font-size: 13px;font-family: NanumGothicBold, 나눔고딕볼드, Dotum, 돋움, Gulim, 굴림, AppleGothic, Sans-serif;">' + this.Categories[c] + '</th>';
				for(var j=0;j<7;j++) {
					tmpDay = new Date(year, month, (i+j-startIdx+1));
					tag += '<td valign="top"';
					dayClass = "";
					dayColor = "#000000";
					if (this.isHoliday(tmpDay.getFullYear(),tmpDay.getMonth(),tmpDay.getDate()-1)) dayColor = "#FF0000";
					else if(j==0) dayColor = "#FF0000";
					else if(j==6) dayColor = "#0000FF";
					if(j==0) dayClass += ' end';
					tag += ' class="' + dayClass + '"';
                    tag += ' style="';

					var t_today = new Date();
					var t_month = t_today.getMonth();     // 월
					var t_day = t_today.getDate();        // 일

					if (t_month == tmpDay.getMonth() && t_day == tmpDay.getDate()) tag += 'background:#FFE0E0;';
                    
					tag += 'border:1px solid #CCCCCC;">';
					if (c == 0) {
					    if ((tmpDay.getMonth()) == month) { // 해당월만 출력하도록 변경
					        tag += '<div id="' + name + '_body_day' + (tmpDay.getMonth() + 1) + "_" + tmpDay.getDate() + '" height="20px"';
					        tag += ' onClick="' + name + '.onClickTitle(' + tmpDay.getFullYear() + ', ' + (tmpDay.getMonth() + 1) + ", " + tmpDay.getDate() + ');"';
					        tag += " style=\"padding:3px;\">";
					        tag += '<span style="color:' + dayColor + ';font-weight:bold;cursor:pointer;">' + (tmpDay.getMonth() + 1) + "/" + tmpDay.getDate() + '</span>';
					        tag += '&nbsp;<span style="color:#4080FF;font-weight:bold">' + this.GetDayTitle(tmpDay.getFullYear(), tmpDay.getMonth(), tmpDay.getDate() - 1, this.DefaultDayTitleIsView).join(", ") + '</span>';
					        tag += '</div>';
					    }
					}
					tag += '<div>';
					tag += this.GetDayBody(tmpDay.getFullYear(),tmpDay.getMonth(),tmpDay.getDate()-1, this.Categories[c]).join(" ");
					tag += '</div>';
					tag += "</td>";
				}
				if (c < this.Categories.length-1) {
					tag += "</tr><tr>";
				}
			}
		} else {
			tmpDay = new Date(year, month, (i-startIdx+1));
			tag += '<th rowspan="' + this.Categories.length + '" style="background:#ffffff;">' + tmpDay.getWeek() + '</th>';
			for(j=0;j<7;j++) {
				tag += '<td valign="top" style="height:75px;"';
				dayClass = "";
				dayColor = "#000000";
				if (this.isHoliday(year,month,dateCnt-1)) dayColor = "#FF0000";
				else if(j==0) dayColor = "#FF0000";
				else if(j==6) dayColor = "#0000FF";
				if(j==0) dayClass += ' end';
				tag += ' class="' + dayClass + '"';
				//tag += ' style="border:1px solid #CCCCCC;">';
				tag += ' style="';
				var t_today = new Date();
				var t_month = t_today.getMonth();     // 월
				var t_day = t_today.getDate();        // 일

				//if (t_month == tmpDay.getMonth() && t_day == dateCnt) tag += 'background:#FFE0E0;';
				tag += ' border:1px solid #CCCCCC;">';
				tag += '<div id="' + name + '_body_day' + dateCnt;//  +'" height="20px"';
				if(((i+j)>=startIdx) && ((i+j)<endIdx)) {
					tag += ' onClick="SetOpenCal(\'' + dateCnt + '\');"';
					tag += " style=\"color:" + dayColor + ";font-weight:bold;cursor:pointer; height:20px; float:left;\" class=\"state_000\">";
						tag += dateCnt;
						dateCnt++;
					tag += '</div>';
					tag += '<div style="padding:0px;">';
					tag += this.GetDayBody(year, month, dateCnt-2).join("<br />");
					tag += '</div>';
				} else {
	                tag += ' class=\"state_000\">&nbsp;';
				}
				tag += "</td>";
			}
		}
		tag += "</tr><tr>";
	}
	tag += "</tr>";
	tag += "</table>";	
	
	//document.getElementById(contain + "_Month").innerHTML = year + '년 ' + (month+1) + "월";
	document.getElementById(contain).innerHTML = tag;
	//ShowContents(year, month, selScheduleDay);
}


// 날짜->문자로
function dateToString(date, splitChar) {
	if(!date) {
		date = new Date();
	}
	if (!splitChar) {
		splitChar = "-";
	}
	if (date.getDate()) {
		var yearString,monthString,dayString;
		yearString = date.getFullYear().toString();
		monthString = (date.getMonth() + 1).toString();
		dayString = date.getDate().toString();
		if(monthString.length == 1) monthString = '0'+monthString;
		if(dayString.length == 1) dayString = '0'+dayString;
		
		return yearString+splitChar+monthString+splitChar+dayString;
	}
}
// 문자 -> 날짜로
function stringToDate(string, splitChar) {
	if(!string) {
		return new Date();
	}
	if (!splitChar) {
		splitChar = "-";
	}
	var dateInfo = string.split(splitChar);
	return new Date(parseInt(dateInfo[0], 10), (parseInt(dateInfo[1],10)-1), parseInt(dateInfo[2], 10));
}