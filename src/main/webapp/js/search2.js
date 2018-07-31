

function initCounters() {
    $('.counter').each(function () {
        $(this).prop('Counter', 0).animate({
            Counter: $(this).text()
        }, {
            duration: 4000,
            easing: 'easeInOutQuart',
            step: function (now) {
                $(this).text(Math.ceil(now));
            }
        });
    });
}

function initDropDown(rightOffset, top,width, listMarginTop, className, defaultText, type) {
    $('.' + className).multiselect({
        buttonText: function (options, select) {
            if (options.length === 0) {
                return defaultText;
            }
            else {
                return wordMultipleFormFromNumber(type, options.length);
            }
        }
    });
    var regionsBtnGroup = $('.' + className).next();
    var ul = regionsBtnGroup.find('ul');
    var btn = regionsBtnGroup.find('button');

    ul.css({
        'display': 'none',
        'background-color': '#fff',
        'border': '1px solid #aaa',
        'z-index': '99999999',
        'min-width': '250px',
        'padding': '10px 5px',
        'margin-top': listMarginTop + 'px',
        'left': rightOffset + 'px'
    });
    ul.find('label').css({
        'padding-left': '0',
        'font-size': '14px'
    });

    ul.find('li').each(function (i) {
        if (type === "sources" && (i === 4 || i === 6)) {
            $(this).css({ 'height': '40px' });
        } else {
            $(this).css({ 'height': '20px' });
        }
       
    });
    ul.find('label input[type=checkbox]').css({
        'float': 'left',
        'margin-top': '2px'
    });
    
    btn.css({
        'background-color': '#EEEEEE',
        'border': '1px solid #ccc',
        'padding': '10px 7px',
        'font-size': '14px',
        'color': '#888',
        'border-radius': '1px',
        'outline': 'none',
        'width': width + 'px',
        'position': 'absolute',
        'left': rightOffset + 'px',
        'top': top + 'px',
        'background-image': 'url("img/triangle.png")',
        'background-repeat': 'no-repeat',
        'background-position': (width - 20) + 'px 50%',
        'text-align': 'left'
    });

    $(btn).click(function (event) {
        $('html').one('click', function () {
            // Hide the menus
            $('.multiselect-container').hide();
        });
        //ul.show();
        if (ul.css('display') === 'none') {
            $('.multiselect-container').hide();
            ul.show();
        } else {
            $('.multiselect-container').hide();
        }
        event.stopPropagation();
    });

    $('html').click(function () {
        $('.multiselect-container').hide();
    });

    //$(btn).click(function () {
       
    //    if (ul.css('display') == 'none') {
    //        ul.show();
    //    } else {
    //        //$('.multiselect-container').hide();
    //    }
        
    //    //$('html').one('click', function () {
    //    //    //ul.hide();
    //    //});
    //    event.stopPropagation();
    //});
}

function handleSorting() {
    $('.sorting a').click(function () {
        var val = $(this).attr('href').replace('#','');
        $('input[name=sortBy]').val(val);
        $('.form-tenders-search').submit();
        return false;
    });
}

function wordMultipleFormFromNumber(type, number) {
    var r_text = '';

    if (type === "regions") {
        if (number === 1) {
            r_text = 'область';
        } else if (number === 2 || number === 3 || number === 4) {
            r_text = 'области';
        } else {
            r_text = 'областей';
        }
        return number + ' ' + r_text + ' ';
    } else if (type === "payMethods") {
        if (number === 1) {
            r_text = 'способ закупки';
        } else if (number === 2 || number === 3 || number === 4) {
            r_text = 'способа закупки';
        } else {
            r_text = 'способов закупки';
        }
        return number + ' ' + r_text + ' ';
    } else if (type === "sources") {
        if (number === 1) {
            r_text = ' источник';
        } else if (number === 2 || number === 3 || number === 4) {
            r_text = 'источника';
        } else {
            r_text = 'источников';
        }
        return number + ' ' + r_text + ' ';
    } else if (type === "categories") {
        if (number === 1) {
            r_text = 'вид деятельности';
        } else if (number === 2 || number === 3 || number === 4) {
            r_text = 'вида деятельности';
        } else {
            r_text = 'видов деятельности';
        }
        return number + ' ' + r_text + ' ';
    } else if (type === "howmanytimes") {
        if (number === 1) {
            r_text = '1 раз в день';
        } else if (number === 2) {
            r_text = '2 раза в день';
        } else {
            r_text = '3 раза в день';
        }
        return r_text + ' ';
    }


    
}

function initDateSelector(selector, canGoPast) {
    $.datepicker.regional['ru'] = {
        closeText: 'Закрыть',
        prevText: '&#x3c;Пред',
        nextText: 'След&#x3e;',
        currentText: 'Сегодня',
        monthNames: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
        'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'],
        monthNamesShort: ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн',
        'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'],
        dayNames: ['воскресенье', 'понедельник', 'вторник', 'среда', 'четверг', 'пятница', 'суббота'],
        dayNamesShort: ['вск', 'пнд', 'втр', 'срд', 'чтв', 'птн', 'сбт'],
        dayNamesMin: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
        dateFormat: 'dd.mm.yy',
        firstDay: 1,
        isRTL: false
    };
    $.datepicker.setDefaults($.datepicker.regional['ru']);

    if (canGoPast) {
        $(selector).datepicker({ dateFormat: 'dd.mm.yy'});
    } else {
        $(selector).datepicker({ dateFormat: 'dd.mm.yy', minDate: 0 });
    }  
}

function handleFormAskQuestion(){
    $('#formaskquestion form').submit(function () {
        
        var isCorrect = checkForm($(this));
        var url = $(this).attr('action');

        if (isCorrect !== false) {
            var $form = $(this),
                name = $('input[name="name"]', $form).val(),
                phone = $('input[name="phone"]', $form).val(),
                email = $('input[name="email"]', $form).val(),
                ques = $('textarea[name="ques"]', $form).val();

            var source = $('input[name="source"]').val();
            var medium = $('input[name="medium"]').val();
            var campaign = $('input[name="campaign"]').val();
            var content = $('input[name="content"]').val();
            var term = $('input[name="term"]').val();
            var ref = $('input[name="referer"]').val();

            var formname = 'Подробнее о платных услугах по тендерам';

            ga('send', 'pageview', '/uslugi_zayavka');
            thx();

            $.ajax({
                type: 'POST',
                url: url,
                dataType: 'json',
                cache: false,
                data: "source=" + source + "&medium=" + medium + "&campaign=" + campaign + "&content=" + content + "&term=" + term + "&name=" + name + "&phone=" + phone + "&ques=" + ques + "&email=" + email + "&formname=" + formname + "&ref=" + ref,
                success: function (data, text) {
                },
                error: function () {
                }
            }).always(function () {
                
            });
        }

        return false;
    });
}

function handleMenuHover() {
    $('#navigation-common .right-part > ul > li').mouseover(function () {
        $(this).find('ul').css('display','block');
    }).mouseleave(function(){
        $(this).find('ul').css('display', 'none');
    });
}

$.fn.center = function (options) {

    if (options instanceof jQuery) {
        inside_el = options;
        options = null;
    }
    else inside_el = null;

    options = options || {};
    options.this = options.this || {};
    options.inside = options.inside || {};

    if (options.this.h === null) options.this.h = 0.5;
    if (options.this.v === null) options.this.v = 0.5;

    options.inside.el = $(options.inside.el || inside_el || this.parent());
    if (options.inside.h === null) options.inside.h = 0.5;
    if (options.inside.v === null) options.inside.v = 0.5;

    if (options.hOffset === null) options.hOffset = 0;
    if (options.vOffset === null) options.vOffset = 0;

    this.css("position", "absolute");

    this.css("left", (options.inside.el.width() * options.inside.h - this.width() * options.this.h + options.hOffset) + "px");

    this.css("top", (options.inside.el.height() * options.inside.v - this.height() * options.this.v + options.vOffset) + "px");

    return this;
};

function updateDate() {
    var curDate = new Date();

    var day = curDate.getDate().toString();
    var month = (curDate.getMonth() + 1).toString();
    var year = curDate.getFullYear().toString();

    var hours = curDate.getHours().toString();
    var minutes = curDate.getMinutes().toString();

    if (day.length < 2) day = '0' + day;
    if (month.length < 2) month = '0' + month;

    if (hours.length < 2) hours = '0' + hours;
    if (minutes.length < 2) minutes = '0' + minutes;

    curTime = day + "." + month + "." + year + "&nbsp;&nbsp;&nbsp;" + hours + ":" + minutes;
    $('.currentTime').html(curTime);
}

function inputWithNumbers(selector) {
    $(selector).keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl+A
            (e.keyCode === 65 && e.ctrlKey === true) ||
            // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
}

function inputWithoutPunctuation(selector) {
    $(selector).keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl+A
            (e.keyCode === 65 && e.ctrlKey === true) ||
            // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
}

function fixedTopMenu() {
    var secondaryNav = $('#navigation-common'),
	secondaryNavTopPosition = secondaryNav.offset().top;

    $(window).on('scroll', function () {

        if ($(window).scrollTop() > secondaryNavTopPosition) {
            secondaryNav.addClass('is-fixed');
            //setTimeout(function () {
            //    secondaryNav.addClass('animate-children');
            //    $('#cd-logo').addClass('slide-in');
            //    $('.cd-btn').addClass('slide-in');
            //}, 50);
        } else {
            secondaryNav.removeClass('is-fixed');
            //setTimeout(function () {
            //    secondaryNav.removeClass('animate-children');
            //    $('#cd-logo').removeClass('slide-in');
            //    $('.cd-btn').removeClass('slide-in');
            //}, 50);
        }
    });
}