
$(document).ready(function () {
    bindOverlay()
    bindCloseBtn()
    submitModal()
    submitBtn()
});

//$(".modal .phone-masked").mask("+7 (999) 999 - 99 - 99", { placeholder: " " });

function hideModals() {
    if ($('#reg-modal-form').css('display') == 'block') {
        ga('send', 'pageview', '/short-regist-close1')
    }

    var formname = $('input[name="formname"]').val();
    if (formname.toLowerCase().indexOf("платн") >= 0) {
        ga('send', 'pageview', '/popup_uslugi2')
    }

    $('#overlay').hide()
    $('.modal').hide()
}

function showModal(id, formname) {

    if (id == "#reg-modal-form") {
        ga('send', 'pageview', '/short-regist-enter-page')
        ga('send', 'pageview', '/short-regist-enter-page1')
    }

    if (formname.toLowerCase().indexOf("платн") >= 0) {
        ga('send', 'pageview', '/popup_uslugi1')
    }

    $('#overlay').show()
    resetModal(id)
    //$(id).center()
    $(id).show();
    $('input[name=formname]').val(formname)
}

function bindOverlay() {
    $('#overlay').click(function () {
        hideModals();
    })
}

function thx() {
    var text = '';
    var date = new Date();
    var day = date.getDay();
    if (day == 0) { day = 7; }

    if (day != 7 && date.getHours() >= 9 && date.getHours() <= 18) {
        text = "В течении 5 минут</br>с вами свяжется наш специалист"
    } else if (day != 7 && (date.getHours() < 9 || (date.getHours() > 18 && day!=6))) {
        text = "Специалист свяжется с вами</br>в рабочее время (с 09:00 до 18:00)"
    } else {
        text = "Специалист свяжется с вами</br>в понедельник,</br>в рабочее время (с 09:00 до 18:00)"
    }
    $('#thx-modal-form p').html(text);

    showModal('#thx-modal-form','')
}

function bindCloseBtn() {
    $('.modal .close').click(function () {
        hideModals();
    })
}

function resetModal(id) {
    $(id).find('input[type=text],textarea').val('');
}

function resetErrors(formContainer) {
    $(formContainer).find('.error').val('');
}

function submitBtn() {

    $('.submitBtn').click(function () {
        $(this).parent().parent().find('form').submit();
    })
}

function submitModal() {
    $('.modal').submit(function () {

        var modal = $(this);
        var formContainer = $(this).find('form')
        resetErrors(formContainer)
        var isCorrect = checkForm(formContainer);

        var url = formContainer.attr('action');

        if (isCorrect != false) {
            var $form = formContainer,
			name = $('input[name="name"]', $form).val(),
			phone = $('input[name="phone"]', $form).val(),
            fullname = $('input[name="fullname"]', $form).val(),
			email = $('input[name="email"]', $form).val(),
            cityId = $('select[name="cityId"]', $form).val(),
            company = $('input[name="company"]', $form).val(),
            directorFullname = $('input[name="directorFullname"]', $form).val(),
			ques = $('textarea[name="ques"]', $form).val();

            var source = $('input[name="source"]').val();
            var medium = $('input[name="medium"]').val();
            var campaign = $('input[name="campaign"]').val();
            var content = $('input[name="content"]').val();
            var term = $('input[name="term"]').val();
            var ref = $('input[name="referer"]').val();

            var formname = $('input[name="formname"]').val();

            if (url != "/user/registration") {
                modal.hide();
                ga('send', 'pageview', '/uslugi_zayavka')
                thx();
            }

            $.ajax({
                type: 'POST',
                url: url,
                dataType: 'json',
                cache: false,
                data: "source=" + source + "&medium=" + medium + "&campaign=" + campaign + "&content=" + content + "&term=" + term + "&fullname=" + fullname + "&name=" + name + "&phone=" + phone + "&email=" + email + "&cityId=" + cityId + "&company=" + company + "&directorFullname=" + directorFullname + "&formname=" + formname + "&ques=" + ques + "&ref=" + ref,
                success: function (data, text) {
                    if (url == "/user/registration") {
                        if (data == 200) {
                            ga('send', 'pageview', '/short-regist-end')
                            ga('send', 'pageview', '/short-regist-end1')
                            window.location.href = '/user/mailingkeywords';
                        } else {
                            var errs = data.split(',');
                            
                            for (i = 0; i < errs.length; i++) {
                                if (errs[i] == '3') {
                                    $('.email-e').show()
                                    $('.email-e').text('(Почта уже используется)');
                                }
                                else if (errs[i] == '7') {
                                    $('.phone-e').show()
                                    $('.phone-e').text('(Телефон уже используется)');
                                }
                            }
                        }
                    }
                },
                error: function () {

                }
            }).always(function () {
                
            });

            
        }

        return false;
    });
}

function checkForm(formContainer) {

    var $form = $(formContainer),
        checker = true,
        name = $("input[name='name']", $form).val(),
        fullname = $("input[name='fullname']", $form).val(),
        phone = $("input[name='phone']", $form).val(),
        email = $("input[name='email']", $form).val(),
        ques = $("textarea[name='ques']", $form).val();

    var nameC = $form.find("input[name='name']"),
        fullnameC = $form.find("input[name='fullname']"),
        phoneC = $form.find("input[name='phone']"),
        emailC = $form.find("input[name='email']"),
        quesC = $form.find("textarea[name='ques']");

    if (nameC.hasClass("required")) {
        if (!name) {
            $form.find('.name-e').text('Введите имя')
            $form.find('.name-e').show()
            checker = false;
        } else {
            $form.find('.name-e').hide()
        }
    }

    if (fullnameC.hasClass("required")) {
        if (!fullname) {
            $form.find('.fullname-e').text('Введите имя')
            $form.find('.fullname-e').show()
            checker = false;
        } else {
            $form.find('.fullname-e').hide()
        }
    }

    if (phoneC.hasClass("required")) {
        if (!phone) {
            $form.find('.phone-e').text('Введите телефон')
            $form.find('.phone-e').show()
            checker = false;
        } else {
            $form.find('.phone-e').hide()
        }
    }

    if (emailC.hasClass("required")) {

        if (!email) {
            $form.find('.email-e').text('Введите почту')
            $form.find('.email-e').show()
            checker = false;
        } else if (!/^[\.A-z0-9_\-\+]+[@][A-z0-9_\-]+([.][A-z0-9_\-]+)+[A-z]{1,4}$/.test(email)) {
            $form.find('.email-e').text('Введите правильную почту')
            $form.find('.email-e').show()
            checker = false;
        } else {
            $form.find('.email-e').hide()
        }
    }

    if (quesC.hasClass("required")) {
        if (!ques) {
            $form.find('.ques-e').text('Введите сообщение')
            $form.find('.ques-e').show()
            checker = false;
        } else {
            $form.find('.ques-e').hide()
        }
    }

    if (checker != true) { return false; }
}