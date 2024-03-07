/**
* @author Jisman
*/
var YHCalendar = {
    version: '1.4.2C',
    creator: 'neohoen',
    mail: 'yhlee@jisman.co.kr',
    homepage: 'www.jisman.co.kr',
    updated: '2008.12.18'
}
YHCalendar.position = {
    elementLeft: function (obj) {
        if (typeof obj == 'string') obj = document.getElementById(obj);
        if (obj) {
            if (obj.offsetParent == document.body)
                return obj.offsetLeft + obj.offsetParent.offsetLeft;
            else return obj.offsetLeft + this.elementLeft(obj.offsetParent);
        }
    },
    elementTop: function (obj) {
        if (typeof obj == 'string') obj = document.getElementById(obj);
        if (obj) {
            if (obj.offsetParent == document.body)
                return obj.offsetTop + obj.offsetParent.offsetTop;
            else return obj.offsetTop + this.elementTop(obj.offsetParent);
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
}
YHCalendar.Calendar = {

    today: new Date,
    selectedDayCell: '',
    settedDate: new Date,
    selectedMonth: new Date,
    target: null,
    targetId: '',
    selectMode: 'date',
    subSelectMode: 'date',
    splitChar: '-',
    language: 'korean',
    wrapperMode: 'layer',
    resizingFunction: null,
    drawCallBack: null,
    dateToString: function (date) {
        if (!date) {
            date = this.today;
        }
        if (date.getDate()) {
            var yearString, monthString, dayString;
            yearString = date.getFullYear().toString();
            monthString = (date.getMonth() + 1).toString();
            dayString = date.getDate().toString();
            if (monthString.length == 1) monthString = '0' + monthString;
            if (dayString.length == 1) dayString = '0' + dayString;

            return yearString + this.splitChar + monthString + this.splitChar + dayString;
        }
    },
    stringToDate: function (dateStr) {
        var dateInfo = new Array;
        var repl = dateStr.replace(/[^0-9]/g, '-');

        dateInfo = repl.split('-');
        var date = new Date;
        if (dateInfo.length == 3 && dateInfo[0].length == 4 && dateInfo[1].length == 2 && dateInfo[2].length == 2) {
            date.setFullYear(parseFloat(dateInfo[0]), parseFloat(dateInfo[1]) - 1, parseFloat(dateInfo[2]));
            return date;
        }
    },
    browser: {
        IE: !!(window.attachEvent && !window.opera),
        Opera: !!window.opera,
        WebKit: navigator.userAgent.indexOf('AppleWebKit/') > -1,
        Gecko: navigator.userAgent.indexOf('Gecko') > -1 && navigator.userAgent.indexOf('KHTML') == -1
    },
    trim: function (str) {
        return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
    },
    getLastDate: function (year, month) {
        date = new Date;
        date.setFullYear(year, month, 0);
        return date.getDate();
    },
    calendarGenerator: function (el, year, month) {
        if (document.getElementById('yhdateHeader')) document.getElementById('yhdateHeader').style.display = 'block';
        if (document.getElementById('yhdateWrapDiv')) document.getElementById('yhdateWrapDiv').style.display = 'block';
        if (document.getElementById('yhMonthSelector')) document.getElementById('yhMonthSelector').style.display = 'none';
        if (document.getElementById('yhYearSelector')) document.getElementById('yhYearSelector').style.display = 'none';

        var lastOfMonth = this.getLastDate(year, month);
        var date = new Date;
        date.setFullYear(year, month - 1, 1);

        var count = 0;
        count = Math.floor((date.getDay() + lastOfMonth) / 7) * 7;
        if ((date.getDay() + lastOfMonth) % 7 > 0) count = count + 7;
        count = 42;
        var firstDay = date.getDay();

        var ul;
        if (document.getElementById('yhdateWrap')) {
            ul = document.getElementById('yhdateWrap')
        } else {
            ul = document.createElement('ul');
            ul.setAttribute('id', 'yhdateWrap');
            ul.className = 'yhdateWrapper';
        }

        var liString = '';
        var liStrings = new Array;

        for (var i = 1; i <= count; i++) {
            var OddEvenWeek = '';
            if ((parseInt((i - 1) / 7, 10) % 2) == 1) {
                OddEvenWeek = ' EvenWeek';
            } else {
                OddEvenWeek = ' OddWeek';
            }
            if (i > firstDay && i <= lastOfMonth + firstDay) {
                date.setDate(i - firstDay);
                var datestyle = '';
                var SelectStyle = '';
                var todayStyle = '';

                liString = '<li class="yhdateCell';
                liString += OddEvenWeek;

                if (this.target.value != '' && date.getDate() == this.settedDate.getDate() && date.getFullYear() == this.settedDate.getFullYear() && date.getMonth() == this.settedDate.getMonth()) {
                    //liString += ' Selected';
                    SelectStyle = ' Selected';
                }
                if (date.getDate() == this.today.getDate() && date.getFullYear() == this.today.getFullYear() && date.getMonth() == this.today.getMonth()) {
                    //liString += ' Today';
                    todayStyle = ' Today';
                }

                if (YHCalendar.holyDay.holyDays[dateColc.dateToString(date)]) {
                    //liString += ' yhdateHoly';
                    datestyle = ' yhdateHoly';
                } else if (date.getDay() == 0) {
                    //liString += ' yhdateSun';
                    datestyle = ' yhdateSun';
                } else if (date.getDay() == 6) {
                    //liString += ' yhdateSat';
                    datestyle = ' yhdateSat';
                }

                liString += '"';
                //liString += ' id="pick' + this.dateToString(date) + '" ';
                if (YHCalendar.holyDay.holyDays[dateColc.dateToString(date)]) {
                    liString += 'title="' + YHCalendar.holyDay.holyDays[dateColc.dateToString(date)] + '" ';
                }
                liString += ' onclick="YHCalendar.Calendar.appendDateField(\'' + this.targetId + '\',\'' + this.dateToString(date) + '\')"> ';
                liString += '<div class="datewrap' + datestyle + SelectStyle + todayStyle + '" id="pick' + this.dateToString(date) + '" >' + date.getDate() + '</div>';
                liString += '<div class="datewrapAddInfo" id="pickaddInfo' + this.dateToString(date) + '"></div>';
                liString += '</li>';
            } else {
                liString = '<li class="yhdateCell ' + OddEvenWeek + '"><div class="datewrap"></div></li>';
            }
            liStrings.push(liString);
        }
        ul.innerHTML = liStrings.join('');
        el.appendChild(ul);
        if (this.resizingFunction) this.resizingFunction();
        if (this.drawCallBack) this.drawCallBack();
    },
    dayOnClick: function (dayPosition) {
        if (document.getElementById(this.selectedDayCell) && this.selectedDayCell != '') {
            var classNames = document.getElementById(this.selectedDayCell).className.split(' ');
            var tmpArray = new Array;
            for (var i = 0; i < classNames.length; i++) {
                if (this.trim(classNames[i]) != 'yhdateSelected') {
                    tmpArray.push(classNames[i]);
                }
            }
            document.getElementById(this.selectedDayCell).className = tmpArray.join(' ');
        }
        el = document.getElementById(dayPosition);
        el.className += ' yhdateSelected';
        this.selectedDayCell = dayPosition;
    },
    getCalendar: function (targetInstance, targetId, callback) {
        this.target = targetInstance;
        this.targetId = targetId;

        var tmpDateStr = this.target.value.replace(/[^0-9]/g, '-');

        var regExpDate = /^[12][0-9]{3}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/;
        var regExpMonth = /^[12][0-9]{3}-(0[1-9]|1[0-2])$/;
        var regExpYear = /^[12][0-9]{3}$/;

        var tmpDate = new Date;
        if (tmpDateStr != '' && tmpDateStr != null) {
            if (regExpDate.test(tmpDateStr)) {
                if (this.stringToDate(tmpDateStr)) {
                    this.selectedMonth = this.stringToDate(tmpDateStr);
                } else {
                    this.selectedMonth = tmpDate;
                }
            } else if (regExpMonth.test(tmpDateStr)) {
                tmpDate.setFullYear(parseInt(tmpDateStr.split('-')[0], 10));
                tmpDate.setMonth(parseInt(tmpDateStr.split('-')[1], 10) - 1);
                this.selectedMonth = tmpDate;
            } else if (regExpYear.test(tmpDateStr)) {
                tmpDate.setFullYear(parseInt(tmpDateStr, 10));
                this.selectedMonth = tmpDate;
            } else {
                this.selectedMonth = tmpDate;
            }
        } else {
            this.selectedMonth = tmpDate;
        }

        this.settedDate.setFullYear(this.selectedMonth.getFullYear(), this.selectedMonth.getMonth(), this.selectedMonth.getDate());

        var div;
        if (document.getElementById('yhdateBox')) {
            div = document.getElementById('yhdateBox');
            div.style.display = 'block';
        } else {
            div = document.createElement('div');
            div.setAttribute('id', 'yhdateBox');
        }

        var controllUl;
        if (document.getElementById('yhdateControll')) {
            controllUl = document.getElementById('yhdateControll');
        } else {
            controllUl = document.createElement('ul');
            controllUl.setAttribute('id', 'yhdateControll');
        }
        this.refreshControllUl(controllUl);
        div.appendChild(controllUl);

        if (this.wrapperMode == 'parent') {
            var wrapper = this.target.parentNode;
            wrapper.appendChild(div);
        } else {
            if (this.wrapperMode == 'layer') {
                div.style.position = 'absolute';
                div.style.top = (YHCalendar.position.elementTop(this.target) + this.target.offsetHeight) + 'px';
                div.style.left = YHCalendar.position.elementLeft(this.target) + 'px';
                div.style.zIndex = '9999';
                div.onmouseleave = function () { document.getElementById('yhdateBox').style.display = 'none' }
            }
            document.body.appendChild(div);
        }

        if (this.selectMode == 'month') {
            this.subSelectMode = 'month';
            this.monthSelectorGenerator(div, this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
        } else if (this.selectMode == 'year') {
            this.subSelectMode = 'year';
            this.yearSelectorGenerator(div, this.selectedMonth.getFullYear());
        } else {
            this.subSelectMode = 'date';
            YHCalendar.holyDay.setHolyDay(this.selectedMonth.getFullYear(), this.language);

            var ul;
            if (document.getElementById('yhdateHeader')) {
                ul = document.getElementById('yhdateHeader');
            } else {
                ul = document.createElement('ul');
                ul.setAttribute('id', 'yhdateHeader');
            }
            this.setDayOfWeek(ul);
            div.appendChild(ul);

            var dateWrapDiv;
            if (document.getElementById('yhdateWrapDiv')) {
                dateWrapDiv = document.getElementById('yhdateWrapDiv');
            } else {
                dateWrapDiv = document.createElement('div');
                dateWrapDiv.setAttribute('id', 'yhdateWrapDiv');
            }
            div.appendChild(dateWrapDiv);
            this.calendarGenerator(dateWrapDiv, this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
        }
        //if(this.selectMode == 'date') this.dayOnClick('pick'+this.dateToString(this.selectedMonth));
        if (callback) {
            if (typeof (callback) == 'function') {
                callback();
            }
        }
    },
    setDayOfWeek: function (ul) {

    },
    refreshControllUl: function (controllUl) {

    },
    moveMonth: function (flag) {
        if (this.subSelectMode == 'month') {
            if (flag == 0) {
                this.selectedMonth.setFullYear(this.selectedMonth.getFullYear() - 1, this.selectedMonth.getMonth());
            } else if (flag == 1) {
                this.selectedMonth.setFullYear(this.selectedMonth.getFullYear() + 1, this.selectedMonth.getMonth());
            }
            //YHCalendar.holyDay.setHolyDay(this.selectedMonth.getFullYear(), this.language);
            document.getElementById('yhmonthTitle').innerHTML = this.getMonthString(this.selectedMonth);
            this.monthSelectorGenerator(document.getElementById('yhdateBox'), this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
        } else if (this.subSelectMode == 'year') {
            if (flag == 0) {
                this.selectedMonth.setFullYear(this.selectedMonth.getFullYear() - 10);
            } else if (flag == 1) {
                this.selectedMonth.setFullYear(this.selectedMonth.getFullYear() + 10);
            }
            //YHCalendar.holyDay.setHolyDay(this.selectedMonth.getFullYear(), this.language);
            document.getElementById('yhmonthTitle').innerHTML = this.getMonthString(this.selectedMonth);
            this.yearSelectorGenerator(document.getElementById('yhdateBox'), this.selectedMonth.getFullYear());
        } else {
            if (flag == 0) {
                this.selectedMonth.setMonth(this.selectedMonth.getMonth() - 1);
            } else if (flag == 1) {
                this.selectedMonth.setMonth(this.selectedMonth.getMonth() + 1);
            }
            YHCalendar.holyDay.setHolyDay(this.selectedMonth.getFullYear(), this.language);
            document.getElementById('yhmonthTitle').innerHTML = this.getMonthString(this.selectedMonth);
            this.calendarGenerator(document.getElementById('yhdateWrapDiv'), this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
        }
    },
    moveYear: function (flag) {
        if (this.subSelectMode == 'month') {
            if (flag == 0) {
                this.selectedMonth.setFullYear(this.selectedMonth.getFullYear() - 5, this.selectedMonth.getMonth());
            } else if (flag == 1) {
                this.selectedMonth.setFullYear(this.selectedMonth.getFullYear() + 5, this.selectedMonth.getMonth());
            }
            //YHCalendar.holyDay.setHolyDay(this.selectedMonth.getFullYear(), this.language);
            document.getElementById('yhmonthTitle').innerHTML = this.getMonthString(this.selectedMonth);
            this.monthSelectorGenerator(document.getElementById('yhdateBox'), this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
        } else if (this.subSelectMode == 'year') {
            if (flag == 0) {
                this.selectedMonth.setFullYear(this.selectedMonth.getFullYear() - 20);
            } else if (flag == 1) {
                this.selectedMonth.setFullYear(this.selectedMonth.getFullYear() + 20);
            }
            //YHCalendar.holyDay.setHolyDay(this.selectedMonth.getFullYear(), this.language);
            document.getElementById('yhmonthTitle').innerHTML = this.getMonthString(this.selectedMonth);
            this.yearSelectorGenerator(document.getElementById('yhdateBox'), this.selectedMonth.getFullYear());
        } else {
            if (flag == 0) {
                this.selectedMonth.setFullYear(this.selectedMonth.getFullYear() - 1);
            } else if (flag == 1) {
                this.selectedMonth.setFullYear(this.selectedMonth.getFullYear() + 1);
            }
            YHCalendar.holyDay.setHolyDay(this.selectedMonth.getFullYear(), this.language);
            document.getElementById('yhmonthTitle').innerHTML = this.getMonthString(this.selectedMonth);
            this.calendarGenerator(document.getElementById('yhdateWrapDiv'), this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
        }
    },
    getMonthString: function (date) {
        var monthString = "";
        switch (date.getMonth()) {
            case 0: monthString += "January"; break;
            case 1: monthString += "February"; break;
            case 2: monthString += "March"; break;
            case 3: monthString += "April"; break;
            case 4: monthString += "May"; break;
            case 5: monthString += "June"; break;
            case 6: monthString += "July"; break;
            case 7: monthString += "August"; break;
            case 8: monthString += "September"; break;
            case 9: monthString += "October"; break;
            case 10: monthString += "November"; break;
            case 11: monthString += "December"; break;
        }
        monthString += '&nbsp;' + date.getFullYear().toString();
        return monthString;
    },
    selectMonthLayerPounce: function () {
        if (this.selectMode == 'date') {
            if (this.subSelectMode == 'month') {
                this.subSelectMode = 'date';
                this.calendarGenerator(document.getElementById('yhdateWrapDiv'), this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
                return;
            } else {
                this.subSelectMode = 'month';
            }
            this.monthSelectorGenerator(document.getElementById('yhdateBox'), this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
        }
    },
    monthSelectorGenerator: function (el, year, month) {
        if (document.getElementById('yhdateHeader')) document.getElementById('yhdateHeader').style.display = 'none';
        if (document.getElementById('yhdateWrapDiv')) document.getElementById('yhdateWrapDiv').style.display = 'none';
        if (document.getElementById('yhYearSelector')) document.getElementById('yhYearSelector').style.display = 'none';
        var ul;
        if (document.getElementById('yhMonthSelector')) {
            ul = document.getElementById('yhMonthSelector');
        } else {
            ul = document.createElement('ul');
            ul.setAttribute('id', 'yhMonthSelector');
            ul.className = 'yhdateWrapper';
        }
        var liString = '';
        var liStrings = new Array;

        for (var i = 1; i <= 12; i++) {
            liString = '<li class="yhmonthCell';
            if (month == i) {
                liString += 'Selected';
            }
            liString += '" ';
            if (this.selectMode == 'month') {
                liString += 'onclick="YHCalendar.Calendar.appendDateField(\'' + this.targetId + '\',\'' + this.getMonthReturnString(i) + '\')"> ';
            } else {
                liString += 'onclick="YHCalendar.Calendar.innerMonthOnClick(' + i + ')"> ';
            }
            liString += i;
            liString += '</li>';
            liStrings.push(liString);
        }
        var liStringsSet = new Array;
        var DivCount = Math.ceil(liStrings.length / 2);
        for (var i = 0; i < DivCount; i++) {
            liStringsSet.push(liStrings[i]);
            if (liStrings.length >= (i + DivCount)) {
                liStringsSet.push(liStrings[i + DivCount]);
            }
        }
        ul.innerHTML = liStringsSet.join('');
        ul.style.display = 'block';
        el.appendChild(ul);
        if (this.resizingFunction) this.resizingFunction();
    },
    getMonthReturnString: function (month) {
        var monthStr = '';
        var tmpDate = new Date;
        tmpDate.setFullYear(this.selectedMonth.getFullYear(), this.selectedMonth.getMonth(), this.selectedMonth.getDate());
        tmpDate.setMonth(month - 1);
        var dateel = this.dateToString(tmpDate).split(this.splitChar);
        return dateel[0] + this.splitChar + dateel[1];
    },
    innerMonthOnClick: function (month) {
        this.selectedMonth.setMonth(month - 1);
        this.subSelectMode = 'date';
        document.getElementById('yhmonthTitle').innerHTML = this.getMonthString(this.selectedMonth);
        this.calendarGenerator(document.getElementById('yhdateWrapDiv'), this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
    },
    selectYearLayerPounce: function () {
        if (this.selectMode == 'date') {
            if (this.subSelectMode == 'year') {
                this.subSelectMode = 'date';
                this.calendarGenerator(document.getElementById('yhdateWrapDiv'), this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
                return;
            } else {
                this.subSelectMode = 'year';
            }
            this.yearSelectorGenerator(document.getElementById('yhdateBox'), this.selectedMonth.getFullYear());
        } else if (this.selectMode == 'month') {
            if (this.subSelectMode == 'year') {
                this.subSelectMode = 'month';
                this.monthSelectorGenerator(document.getElementById('yhdateBox'), this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
                return;
            } else {
                this.subSelectMode = 'year';
            }
            this.yearSelectorGenerator(document.getElementById('yhdateBox'), this.selectedMonth.getFullYear());
        }
    },
    yearSelectorGenerator: function (el, year) {
        if (document.getElementById('yhdateHeader')) document.getElementById('yhdateHeader').style.display = 'none';
        if (document.getElementById('yhdateWrapDiv')) document.getElementById('yhdateWrapDiv').style.display = 'none';
        if (document.getElementById('yhMonthSelector')) document.getElementById('yhMonthSelector').style.display = 'none';
        var ul;
        if (document.getElementById('yhYearSelector')) {
            ul = document.getElementById('yhYearSelector');
        } else {
            ul = document.createElement('ul');
            ul.setAttribute('id', 'yhYearSelector');
            ul.className = 'yhdateWrapper';
        }
        var liString = '';
        var liStrings = new Array;
        for (var i = year - 7; i <= year + 6; i++) {
            liString = '<li class="yhyearCell';
            if (year == i) {
                liString += 'Selected';
            }
            liString += '" ';
            if (this.selectMode == 'year') {
                liString += 'onclick="YHCalendar.Calendar.appendDateField(\'' + this.targetId + '\',\'' + i + '\')"> ';
            } else {
                liString += 'onclick="YHCalendar.Calendar.innerYearOnClick(' + i + ')"> ';
            }
            liString += i;
            liString += '</li>';
            liStrings.push(liString);
        }
        var liStringsSet = new Array;
        var DivCount = Math.ceil(liStrings.length / 2);
        for (var i = 0; i < DivCount; i++) {
            liStringsSet.push(liStrings[i]);
            if (liStrings.length >= (i + DivCount)) {
                liStringsSet.push(liStrings[i + DivCount]);
            }
        }

        ul.innerHTML = liStringsSet.join('');
        ul.style.display = 'block';
        el.appendChild(ul);
        if (this.resizingFunction) this.resizingFunction();
    },
    innerYearOnClick: function (year) {
        this.selectedMonth.setFullYear(year);

        if (this.selectMode == 'month') {
            this.subSelectMode = 'month';
            document.getElementById('yhmonthTitle').innerHTML = this.getMonthString(this.selectedMonth);
            this.monthSelectorGenerator(document.getElementById('yhdateBox'), this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
        } else {
            this.subSelectMode = 'date';
            YHCalendar.holyDay.setHolyDay(this.selectedMonth.getFullYear(), this.language);
            document.getElementById('yhmonthTitle').innerHTML = this.getMonthString(this.selectedMonth);
            this.calendarGenerator(document.getElementById('yhdateWrapDiv'), this.selectedMonth.getFullYear(), this.selectedMonth.getMonth() + 1);
        }
    },
    appendDateField: function (target, dateString) {
        //기본코드
        /*
        if (target) {
        var targetInstance = document.getElementById(target);
        var o2 = document.getElementsByName(target);
		
        var d = 0;
        while (targetInstance || d == 0) {
        if (targetInstance && targetInstance.tagName.toLowerCase() == 'input') {
        break;
        }
        targetInstance = o2[d++];
        }
		
        if (!targetInstance) {
        alert('The Field id or name is not found');
        return;
        }
        } else {
        alert('Id property is required');
        return;
        }
        targetInstance.value = dateString;
        */
        //this.getCalendar(targetInstance, target);
        alert(dateString);
        //window.returnValue = dateString;
        //self.close();
    }
}
var DatePicker = {
    show: function (target, option, callback) {
        if (target) {
            var targetInstance = document.getElementById(target);
            var o2 = document.getElementsByName(target);

            var d = 0;
            while (targetInstance || d == 0) {
                if (targetInstance && targetInstance.tagName.toLowerCase() == 'input') {
                    break;
                }
                targetInstance = o2[d++];
            }

            if (!targetInstance) {
                alert('The Wrapper id or name is not found');
                return;
            }
        } else {
            alert('Id property is required');
            return;
        }
        if (option) {
            if (option.separator && option.separator != '') {
                YHCalendar.Calendar.splitChar = option.separator;
            } else {
                YHCalendar.Calendar.splitChar = '-';
            }
            if (option.language) {
                if (option.language.toLowerCase() == 'korean') {
                    YHCalendar.Calendar.setDayOfWeek = this.setDayOfWeekKr;
                    YHCalendar.Calendar.getMonthString = this.getMonthStringKr;
                    YHCalendar.Calendar.language = 'korean';
                } else {
                    YHCalendar.Calendar.setDayOfWeek = this.setDayOfWeek;
                    YHCalendar.Calendar.getMonthString = this.getMonthString;
                    YHCalendar.Calendar.language = 'english';
                }
            } else {
                YHCalendar.Calendar.setDayOfWeek = this.setDayOfWeek;
                YHCalendar.Calendar.getMonthString = this.getMonthString;
            }
            if (option.mode) {
                if (option.mode.toLowerCase() == 'advance') {
                    YHCalendar.Calendar.refreshControllUl = this.refreshControllUlad;
                } else {
                    YHCalendar.Calendar.refreshControllUl = this.refreshControllUl;
                }
            } else {
                YHCalendar.Calendar.refreshControllUl = this.refreshControllUl;
            }
            if (option.selectmode) {
                if (option.selectmode.toLowerCase() == 'month') {
                    YHCalendar.Calendar.selectMode = 'month';
                } else if (option.selectmode.toLowerCase() == 'year') {
                    YHCalendar.Calendar.selectMode = 'year';
                } else {
                    YHCalendar.Calendar.selectMode = 'date';
                }
            } else {
                YHCalendar.Calendar.selectMode = 'date';
            }
            if (option.wrappermode) {
                YHCalendar.Calendar.wrapperMode = option.wrappermode;
            } else {
                YHCalendar.Calendar.wrapperMode = 'layer';
            }
            if (option.resizing) {
                YHCalendar.Calendar.resizingFunction = option.resizing;
            }
            if (option.drawCallBack) {
                YHCalendar.Calendar.drawCallBack = option.drawCallBack;
            }
        } else {
            YHCalendar.Calendar.splitChar = '-';
            YHCalendar.Calendar.language = 'korean';
            YHCalendar.Calendar.setDayOfWeek = this.setDayOfWeek;
            YHCalendar.Calendar.getMonthString = this.getMonthString;
            YHCalendar.Calendar.refreshControllUl = this.refreshControllUl;
        }

        YHCalendar.Calendar.getCalendar(targetInstance, target, callback);
    },
    setDayOfWeek: function (ul) {
        var liStrings = new Array;
        liStrings.push('<li class="yhdayOfWeek">Su</li>');
        liStrings.push('<li class="yhdayOfWeek">Mo</li>');
        liStrings.push('<li class="yhdayOfWeek">Tu</li>');
        liStrings.push('<li class="yhdayOfWeek">We</li>');
        liStrings.push('<li class="yhdayOfWeek">Th</li>');
        liStrings.push('<li class="yhdayOfWeek">Fr</li>');
        liStrings.push('<li class="yhdayOfWeek">Sa</li>');

        ul.innerHTML = liStrings.join('');
    },
    setDayOfWeekKr: function (ul) {
        var liStrings = new Array;
        liStrings.push('<li class="yhdayOfWeek"><div class="yhdayOfWeekSub yhdateSun">SUN</div></li>');
        liStrings.push('<li class="yhdayOfWeek"><div class="yhdayOfWeekSub">MON</div></li>');
        liStrings.push('<li class="yhdayOfWeek"><div class="yhdayOfWeekSub">TUE</div></li>');
        liStrings.push('<li class="yhdayOfWeek"><div class="yhdayOfWeekSub">WED</div></li>');
        liStrings.push('<li class="yhdayOfWeek"><div class="yhdayOfWeekSub">THU</div></li>');
        liStrings.push('<li class="yhdayOfWeek"><div class="yhdayOfWeekSub">FRI</div></li>');
        liStrings.push('<li class="yhdayOfWeek"><div class="yhdayOfWeekSub yhdateSat">SAT</div></li>');

        ul.innerHTML = liStrings.join('');
    },
    getMonthString: function (date) {
        var monthString = '';
        var tmpmonthStr = '';
        switch (date.getMonth()) {
            case 0: tmpmonthStr += "Jan."; break;
            case 1: tmpmonthStr += "Feb."; break;
            case 2: tmpmonthStr += "Mar."; break;
            case 3: tmpmonthStr += "Apr."; break;
            case 4: tmpmonthStr += "May"; break;
            case 5: tmpmonthStr += "Jun."; break;
            case 6: tmpmonthStr += "Jul."; break;
            case 7: tmpmonthStr += "Aug."; break;
            case 8: tmpmonthStr += "Sep."; break;
            case 9: tmpmonthStr += "Oct."; break;
            case 10: tmpmonthStr += "Nov."; break;
            case 11: tmpmonthStr += "Dec."; break;
        }
        if (this.selectMode != 'year') {
            monthString += '<span class="yhmonthbutton" onclick="YHCalendar.Calendar.selectMonthLayerPounce();">' + tmpmonthStr + '</span>&nbsp;';
        }
        monthString += '<span class="yhyearbutton" onclick="YHCalendar.Calendar.selectYearLayerPounce();">' + date.getFullYear().toString() + '</span>';
        return monthString;
    },
    getMonthStringKr: function (date) {
        var monthString = '';
        monthString += '<span class="yhyearbutton" onclick="YHCalendar.Calendar.selectYearLayerPounce();">' + date.getFullYear().toString() + '년</span>&nbsp;';
        //monthString += '<span class="yhyearbutton" onclick="YHCalendar.Calendar.selectYearLayerPounce();">' + date.getFullYear().toString() + '</span> &nbsp;';
        if (this.selectMode != 'year') {
            monthString += ' <span class="yhmonthbutton" onclick="YHCalendar.Calendar.selectMonthLayerPounce();">' + (date.getMonth() + 1) + '월</span>';
            //monthString += ' <span class="yhmonthbutton" onclick="YHCalendar.Calendar.selectMonthLayerPounce();">' + (date.getMonth() + 1) + '</span> ';
        }
        return monthString;
    },
    refreshControllUl: function (controllUl) {
        var controllLi = new Array;

        controllLi.push('<li id="yhmonthTitle" class="yhmonthTitleSimple">' + this.getMonthString(this.selectedMonth) + '</li>');
        controllLi.push('<li class="yharrowLeft" onclick="YHCalendar.Calendar.moveMonth(0);">&nbsp;</li>');
        controllLi.push('<li class="yharrowRight" onclick="YHCalendar.Calendar.moveMonth(1);">&nbsp;</li>');
        controllUl.innerHTML = controllLi.join('');
    },
    refreshControllUlad: function (controllUl) {
        var controllLi = new Array;
        controllLi.push('<li class="yharrowLeft1" onclick="YHCalendar.Calendar.moveYear(0);"><div></div></li>');
        controllLi.push('<li class="yharrowLeft" onclick="YHCalendar.Calendar.moveMonth(0);"><div></div></li>');
        controllLi.push('<li id="yhmonthTitle"  class="yhmonthTitleAdvance">' + this.getMonthString(this.selectedMonth) + '</li>');
        controllLi.push('<li class="yharrowRight" onclick="YHCalendar.Calendar.moveMonth(1);"><div></div></li>');
        controllLi.push('<li class="yharrowRight1" onclick="YHCalendar.Calendar.moveYear(1);"><div></div></li>');
        controllUl.innerHTML = controllLi.join('');
    }
}

/**
* @author Jisman
*/
var dateColc = {
    baseDate: ['1841-01-01', '1841-01-23'],
    splitChar: '-',
    lunarDateDiff: function (lunarModern) {
        if (typeof lunarModern == 'string') {

            var lunarDate = lunarModern.replace(/[^0-9]/g, '-').split('-');

            if (parseInt(lunarDate[0]) >= 1841 && parseInt(lunarDate[0]) <= 2043) {
                var dt = 0;
                for (i = 1841; i < parseFloat(lunarDate[0]); i++) {
                    for (j = 0; j < 12; j++) {
                        dt += this.getLunarMonthDays(i, j + 1);
                    }
                }
                for (j = 0; j < parseFloat(lunarDate[1]) - 1; j++) {
                    dt += this.getLunarMonthDays(parseFloat(lunarDate[0]), j + 1);
                }
                dt += (parseFloat(lunarDate[2]) - 1);
                return dt;
            } else return null;
        }
    },
    lunar2Solar: function (lunarModern) {
        var lunarDiff = this.lunarDateDiff(lunarModern);
        if (lunarDiff) {
            var baseDateSolar = this.stringToDate(this.baseDate[1]);
            var date = new Date;
            date.setTime(baseDateSolar.getTime() + lunarDiff * 86400000);
            return this.dateToString(date);
        } else return null;
    },
    solar2Lunar: function (solarModern) {
        var modern = this.stringToDate(solarModern);
        if (modern && modern.getFullYear() >= 1841 && modern.getFullYear() <= 2043) {
            var baseDateSolar = this.stringToDate(this.baseDate[1]);
            var solarDiff = (modern.getTime() - baseDateSolar.getTime()) / 86400000 + 1;
            var lunarYear = 0;
            var lunarMonth = 0;
            var escapeFlag = 0;

            for (var i = 0; i < this.lunarArray.length; i++) {
                for (var j = 0; j < 12; j++) {
                    if (solarDiff >= this.getLunarMonthDays(i + 1841, j + 1)) {
                        solarDiff = solarDiff - this.getLunarMonthDays(i + 1841, j + 1);
                    } else {
                        lunarYear = 1841 + i;
                        lunarMonth = j + 1;
                        escapeFlag = 2;
                        break;
                    }
                }
                if (escapeFlag == 2) break;
            }
            if (lunarMonth.toString().length == 1) lunarMonth = '0' + lunarMonth;
            if ((solarDiff).toString().length == 1) solarDiff = '0' + (solarDiff);
            return lunarYear + "-" + lunarMonth + "-" + solarDiff;
        } else return null;
    },
    getLunarMonthDays: function (year, month) {
        var mm = 0;
        switch (this.lunarArray[year - 1841][month - 1]) {
            case 1: mm = 29;
                break;
            case 2: mm = 30;
                break;
            case 3: mm = 58;   /* 29+29 */
                break;
            case 4: mm = 59;   /* 29+30 */
                break;
            case 5: mm = 59;   /* 30+29 */
                break;
            case 6: mm = 60;   /* 30+30 */
                break;
        }
        return mm;
    },
    lunarArray: [
    //1841
	[1, 2, 4, 1, 1, 2, 1, 2, 1, 2, 2, 1], [2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 1],
	[2, 2, 2, 1, 2, 1, 4, 1, 2, 1, 2, 1], [2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2],
	[1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1], [2, 1, 2, 1, 5, 2, 1, 2, 2, 1, 2, 1],
	[2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2], [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
	[2, 1, 2, 3, 2, 1, 2, 1, 2, 1, 2, 2], [2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
    //1851
	[2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 5, 2], [2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 1, 2],
	[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2], [1, 2, 1, 2, 1, 2, 5, 2, 1, 2, 1, 2],
	[1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1], [2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
	[1, 2, 1, 1, 5, 2, 1, 2, 1, 2, 2, 2], [1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],
	[2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2], [2, 1, 6, 1, 1, 2, 1, 1, 2, 1, 2, 2],
    //1861
	[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2], [2, 1, 2, 1, 2, 2, 1, 2, 2, 3, 1, 2],
	[1, 2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2], [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
	[2, 1, 1, 2, 4, 1, 2, 2, 1, 2, 2, 1], [2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2],
	[1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2], [1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 2, 1],
	[2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1], [2, 2, 2, 1, 2, 1, 2, 1, 1, 5, 2, 1],
    //1871
	[2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1, 2], [1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
	[1, 1, 2, 1, 2, 4, 2, 1, 2, 2, 1, 2], [1, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 1],
	[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1], [2, 2, 1, 1, 5, 1, 2, 1, 2, 2, 1, 2],
	[2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2], [2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
	[2, 2, 4, 2, 1, 2, 1, 1, 2, 1, 2, 1], [2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2],
    //1881
	[1, 2, 1, 2, 1, 2, 5, 2, 2, 1, 2, 1], [1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
	[1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2], [2, 1, 1, 2, 3, 2, 1, 2, 2, 1, 2, 2],
	[2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2], [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
	[2, 2, 1, 5, 2, 1, 1, 2, 1, 2, 1, 2], [2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],
	[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2], [1, 5, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2],
    //1891
	[1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2], [1, 1, 2, 1, 1, 5, 2, 2, 1, 2, 2, 2],
	[1, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2], [1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
	[2, 1, 2, 1, 5, 1, 2, 1, 2, 1, 2, 1], [2, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
	[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1], [2, 1, 5, 2, 2, 1, 2, 1, 2, 1, 2, 1],
	[2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2], [1, 2, 1, 1, 2, 1, 2, 5, 2, 2, 1, 2],
    //1901
	[1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1], [2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
	[1, 2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2], [2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1],
	[2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2], [1, 2, 2, 4, 1, 2, 1, 2, 1, 2, 1, 2],
	[1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1], [2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
	[1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2], [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
    //1911
	[2, 1, 2, 1, 1, 5, 1, 2, 2, 1, 2, 2], [2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2],
	[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2], [2, 2, 1, 2, 5, 1, 2, 1, 2, 1, 1, 2],
	[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2], [1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
	[2, 3, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1], [2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 5, 2, 2, 1, 2, 2], [1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2],
    //1921
	[2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2], [2, 1, 2, 2, 3, 2, 1, 1, 2, 1, 2, 2],
	[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2], [2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
	[2, 1, 2, 5, 2, 1, 2, 2, 1, 2, 1, 2], [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
	[2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2], [1, 5, 1, 2, 1, 1, 2, 2, 1, 2, 2, 2],
	[1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2], [1, 2, 2, 1, 1, 5, 1, 2, 1, 2, 2, 1],
    //1931
	[2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1], [2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
	[1, 2, 2, 1, 6, 1, 2, 1, 2, 1, 1, 2], [1, 2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2],
	[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1], [2, 1, 4, 1, 2, 1, 2, 1, 2, 2, 2, 1],
	[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1], [2, 2, 1, 1, 2, 1, 4, 1, 2, 2, 1, 2],
	[2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 2], [2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
    //1941
	[2, 2, 1, 2, 2, 4, 1, 1, 2, 1, 2, 1], [2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 1, 2],
	[1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2], [1, 1, 2, 4, 1, 2, 1, 2, 2, 1, 2, 2],
	[1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2], [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
	[2, 5, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2], [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
	[2, 2, 1, 2, 1, 2, 3, 2, 1, 2, 1, 2], [2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1],
    //1951
	[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2], [1, 2, 1, 2, 4, 2, 1, 2, 1, 2, 1, 2],
	[1, 2, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2], [1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
	[2, 1, 4, 1, 1, 2, 1, 2, 1, 2, 2, 2], [1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
	[2, 1, 2, 1, 2, 1, 1, 5, 2, 1, 2, 2], [1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
	[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1], [2, 1, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1],
    //1961
	[2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2], [1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
	[2, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2, 1], [2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
	[1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1], [2, 2, 5, 2, 1, 1, 2, 1, 1, 2, 2, 1],
	[2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2], [1, 2, 2, 1, 2, 1, 5, 2, 1, 2, 1, 2],
	[1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1], [2, 1, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
    //1971
	[1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1, 2], [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
	[2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2, 1], [2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1, 2],
	[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2], [2, 2, 1, 2, 1, 2, 1, 5, 2, 1, 1, 2],
	[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 1], [2, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1],
	[2, 1, 1, 2, 1, 6, 1, 2, 2, 1, 2, 1], [2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2],
    //1981
	[1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2], [2, 1, 2, 3, 2, 1, 1, 2, 2, 1, 2, 2],
	[2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2], [2, 1, 2, 2, 1, 1, 2, 1, 1, 5, 2, 2],
	[1, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2], [1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1, 1],
	[2, 1, 2, 2, 1, 5, 2, 2, 1, 2, 1, 2], [1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1],
	[2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2], [1, 2, 1, 1, 5, 1, 2, 1, 2, 2, 2, 2],
    //1991
	[1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2], [1, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2],
	[1, 2, 5, 2, 1, 2, 1, 1, 2, 1, 2, 1], [2, 2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2],
	[1, 2, 2, 1, 2, 2, 1, 5, 2, 1, 1, 2], [1, 2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2],
	[1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1], [2, 1, 1, 2, 3, 2, 2, 1, 2, 2, 2, 1],
	[2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1], [2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1],
    //2001
	[2, 2, 2, 3, 2, 1, 1, 2, 1, 2, 1, 2], [2, 2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1],
	[2, 2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2], [1, 5, 2, 2, 1, 2, 1, 2, 2, 1, 1, 2],
	[1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2], [1, 1, 2, 1, 2, 1, 5, 2, 2, 1, 2, 2],
	[1, 1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2], [2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2],
	[2, 2, 1, 1, 5, 1, 2, 1, 2, 1, 2, 2], [2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2],
    //2011
	[2, 1, 2, 2, 1, 2, 1, 1, 2, 1, 2, 1], [2, 1, 6, 2, 1, 2, 1, 1, 2, 1, 2, 1],
	[2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2], [1, 2, 1, 2, 1, 2, 1, 2, 5, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 2], [1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2],
	[2, 1, 1, 2, 3, 2, 1, 2, 1, 2, 2, 2], [1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2],
	[2, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2], [2, 1, 2, 5, 2, 1, 1, 2, 1, 2, 1, 2],
    //2021
	[1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1], [2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2],
	[1, 5, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2], [1, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1],
	[2, 1, 2, 1, 1, 5, 2, 1, 2, 2, 2, 1], [2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2],
	[1, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 2], [1, 2, 2, 1, 5, 1, 2, 1, 1, 2, 2, 1],
	[2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2], [1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1],
    //2031
	[2, 1, 5, 2, 1, 2, 2, 1, 2, 1, 2, 1], [2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 5, 2, 2, 2, 1, 2], [1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1],
	[2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2], [2, 2, 1, 2, 1, 4, 1, 1, 2, 1, 2, 2],
	[2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 1, 2], [2, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 1],
	[2, 2, 1, 2, 5, 2, 1, 2, 1, 2, 1, 1], [2, 1, 2, 2, 1, 2, 2, 1, 2, 1, 2, 1],
    //2041
	[2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 2], [1, 5, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2],
	[1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2]
	],
    dateToString: function (date) {
        if (!date) {
            date = this.today;
        }
        if (date.getDate()) {
            var yearString, monthString, dayString;
            yearString = date.getFullYear().toString();
            monthString = (date.getMonth() + 1).toString();
            dayString = date.getDate().toString();
            if (monthString.length == 1) monthString = '0' + monthString;
            if (dayString.length == 1) dayString = '0' + dayString;

            return yearString + this.splitChar + monthString + this.splitChar + dayString;
        }
    },
    stringToDate: function (dateStr) {
        var dateInfo = new Array;
        var repl = dateStr.replace(/[^0-9]/g, '-');

        dateInfo = repl.split('-');
        var date = new Date;
        if (dateInfo.length == 3 && dateInfo[0].length == 4 && dateInfo[1].length == 2 && dateInfo[2].length == 2) {
            date.setFullYear(parseFloat(dateInfo[0]), parseFloat(dateInfo[1]) - 1, parseFloat(dateInfo[2]));
            return date;
        }
    }
}

YHCalendar.holyDay = {
    setedYear: '',
    setHolyDay: function (year, language) {
        language = language || 'korean';
        var description = '';
        if (year.toString() != this.setedYear) {
            for (var i = 0; i < this.holyDayInfo.length; i++) {
                if (this.holyDayInfo[i].calMode == 'lunar') {
                    var holyDate = dateColc.lunar2Solar(year + '-' + this.holyDayInfo[i].date);
                    if (!holyDate) continue;
                    description = (language != 'korean' ? (this.holyDayInfo[i].descEn || this.holyDayInfo[i].desc) : this.holyDayInfo[i].desc);
                    if (this.holyDays[holyDate] && this.holyDays[holyDate].indexOf(description) == -1) {
                        this.holyDays[holyDate] += ',' + description;
                    } else {
                        this.holyDays[holyDate] = description;
                    }
                    if (this.holyDayInfo[i].date == '01-01' || this.holyDayInfo[i].date == '08-15') {
                        var date = dateColc.stringToDate(holyDate);
                        date.setDate(date.getDate() - 1);
                        if (this.holyDayInfo[i].date == '01-01') {
                            description = (language != 'korean' ? 'Holydays' : '설연휴');
                        } else {
                            description = (language != 'korean' ? 'Holydays' : '추석연휴');
                        }
                        if (this.holyDays[dateColc.dateToString(date)] && this.holyDays[dateColc.dateToString(date)].indexOf(description) == -1) {
                            this.holyDays[dateColc.dateToString(date)] += ',' + description;
                        } else {
                            this.holyDays[dateColc.dateToString(date)] = description;
                        }

                        date.setDate(date.getDate() + 2);
                        if (this.holyDayInfo[i].date == '01-01') {
                            description = (language != 'korean' ? 'Holydays' : '설연휴');
                        } else {
                            description = (language != 'korean' ? 'Holydays' : '추석연휴');
                        }
                        if (this.holyDays[dateColc.dateToString(date)] && this.holyDays[dateColc.dateToString(date)].indexOf(description) == -1) {
                            this.holyDays[dateColc.dateToString(date)] += ',' + description;
                        } else {
                            this.holyDays[dateColc.dateToString(date)] = description;
                        }
                    }
                } else {
                    description = (language != 'korean' ? (this.holyDayInfo[i].descEn || this.holyDayInfo[i].desc) : this.holyDayInfo[i].desc);
                    if (this.holyDays[year + '-' + this.holyDayInfo[i].date] && this.holyDays[year + '-' + this.holyDayInfo[i].date].indexOf(description) == -1) {
                        this.holyDays[year + '-' + this.holyDayInfo[i].date] += ',' + description;
                    } else {
                        this.holyDays[year + '-' + this.holyDayInfo[i].date] = description;
                    }
                }
            }
            this.setedYear = year;
        }
    },
    holyDays: new Array,
    holyDayInfo: [
		{ calMode: 'solar', date: '01-01', desc: '신정', descEn: 'New Year\'s Day' },
		{ calMode: 'lunar', date: '01-01', desc: '설날', descEn: 'Lunar New Year' },
		{ calMode: 'lunar', date: '08-15', desc: '추석', descEn: 'Chuseok' },
		{ calMode: 'solar', date: '03-01', desc: '삼일절', descEn: 'Samil Independence Movement Day' },
		{ calMode: 'lunar', date: '04-08', desc: '석가탄신일', descEn: 'Buddha\'s Birthday' },
		{ calMode: 'solar', date: '05-05', desc: '어린이날', descEn: 'Children\'s Day' },
		{ calMode: 'solar', date: '06-06', desc: '현충일', descEn: 'Memorial Day' },
		{ calMode: 'solar', date: '08-15', desc: '광복절', descEn: 'National Liberation Day' },
		{ calMode: 'solar', date: '10-03', desc: '개천절', descEn: 'the National foundation Day of Korea' },
        { calMode: 'solar', date: '10-09', desc: '한글날', descEn: 'Hangul' },
		{ calMode: 'solar', date: '12-25', desc: '크리스마스', descEn: 'Christmas' }
	]
}

var onKeyPressMask = function (el, e, pt) {
    var els = new String(el.value);
    var pts = pt.substring(els.length, els.length + 1);
    var exp = /[0-9]/g;
    var keyCode = e.keyCode || e.charCode;

    if (keyCode == 8 || keyCode == 9 || keyCode == 13) return;
    if (pts == '') return false;
    if (pts == '#') {
        exp = /[0-9]/g;
        if (exp.test(String.fromCharCode(keyCode))) {
            return;
        } else return exp.test(String.fromCharCode(keyCode));
    } else if (pts == '*') {
        exp = /[a-zA-Z]/g;
        if (exp.test(String.fromCharCode(keyCode))) {
            return;
        } else return exp.test(String.fromCharCode(keyCode));
    } else {
        if (String.fromCharCode(keyCode) != pts) return false;
    }
}
/*
* ver 1.0.0
* 기본 DatePicker
* 
* ver 1.1.1
* 한글옵션생성
* 구분자옵션생성
* 년도 증감을 사용할 수있는 advence 모드 생성 
* 
* ver 1.2.2 
* 레이어 우측 하단 닫기 버튼 생성
* 대상 필드가 비어 있거나 올바른 값이 아닐시 현제 일자 기준의 달력 표시가 안됬던점 수정
* 
* ver 1.3.2
* 공휴일 표시기능 추가 
* 
* ver 1.4.2
* 기존 닫기 기능을 제거하고 마우스 이동시 자동으로 닫김(iE)
* 
* ver 1.4.2C
* 최적화및 디자인커스터마이징
*/