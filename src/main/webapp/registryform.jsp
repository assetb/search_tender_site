<%-- 
    Document   : registryform
    Created on : 21.07.2015, 13:56:02
    Author     : Aset
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class='gf_browser_chrome gform_wrapper' id='gform_wrapper_1' >
    <form method='get' enctype='multipart/form-data'  id='gform_1'  action='registry.jsp' data-abide>
        <div class='gform_body'>
            <ul id='gform_fields_1' class='gform_fields top_label description_below'>
                <li id='field_1_1'>
                    <label class='gfield_label' for='input_1'>Компания</label>
                    <div class='ginput_container'>
                        <input name='input_1' id='input_1' type='text' value='' class='medium'  tabindex='1'/>
                    </div>
                </li>
                <li id='field_1_2'>
                    <label class='gfield_label' for='input_2'>Имя</label>
                    <div class='ginput_container'>
                        <input name='input_2' id='input_2' type='text' value='' class='medium'  tabindex='2'/>
                    </div>
                </li>
                <li id='field_1_6'>
                    <label class='gfield_label' for='input_6'>Фамилия</label>
                    <div class='ginput_container'>
                        <input name='input_6' id='input_6' type='text' value='' class='medium'  tabindex='3'/>
                    </div>
                </li>
                <li id='field_1_3' class='gfield gfield_contains_required' >
                    <label class='gfield_label' for='input_3'>Email<span class='gfield_required'>*</span></label>
                    <div class='ginput_container'>
                        <input name='input_3' id='input_3' type='email' value='' class='medium'  tabindex='4' required=""/>
                    </div>
                    <small class="error">Введите Email правильно.</small>
                </li>
                <li id='field_1_5' class='gfield gfield_contains_required' >
                    <label class='gfield_label' for='input_5'>Телефон<span class='gfield_required'>*</span></label>
                    <div class='ginput_container'>
                        <!--                        <input name='input_5' id='input_5' type='tel' value='' class='medium'  tabindex='5' required="" onkeypress="if (this.value.length > 13)
                                                            event.preventDefault();
                                                        if (this.value.match(/^[[0-9]-]/))
                                                            this.value = this.value.replace(/\D/g, '');
                                                        if (this.value.length === 1 || this.value.length === 5 || this.value.length === 9)
                                                            this.value = this.value + '-';"
                                                                    onkeyup="if (this.value.length > 13)
                                                            event.preventDefault();
                                                        if (this.value.match(/^[[0-9]-]/))
                                                            this.value = this.value.replace(/\D/g, '');
                                                        if (this.value.length === 1 || this.value.length === 5 || this.value.length === 9)
                                                            this.value = this.value + '-';"/>-->
                        <input name='input_5' id='input_5' type='tel' value='' class='medium'  tabindex='5' required=""/>
                    </div>
                    <small class="error">Телефон обязателен.</small>
                </li>
                <li id='field_1_4' class='gfield gfield_contains_required' >
                    <label class='gfield_label' for='input_4'>Пароль<span class='gfield_required'>*</span></label>
                    <div class='ginput_container'>
                        <input name='input_4' id='input_4' type='password' value='' class='medium'  tabindex='6' required=""/>
                    </div>
                    <small class="error">Пароль не верен.</small>
                </li>
            </ul>
        </div>
        <div class='gform_footer top_label'> <input type='submit' id='gform_submit_button_1' class='button gform_button' value='Отправить данные' tabindex='11' />
        </div>
    </form>
</div>
