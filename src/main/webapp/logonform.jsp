<%-- 
    Document   : registryform
    Created on : 21.07.2015, 13:56:02
    Author     : Aset
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class='gf_browser_chrome gform_wrapper' id='gform_wrapper_1' >
    <form method='get' enctype='multipart/form-data'  id='gform_1'  action='logon.jsp' data-abide>
        <div class='gform_body'>
            <ul id='gform_fields_1' class='gform_fields top_label description_below'>
                <!--                <li id='field_1_1' class='gfield gfield_contains_required'>
                                    <label class='gfield_label' for='input_1'>Компания<span class='gfield_required'></span></label>
                                    <div class='ginput_container'>
                                        <input name='input_1' id='input_1' type='text' value='' class='medium'  tabindex='1'/>
                                    </div>
                                </li>
                                <li id='field_1_2' class='gfield gfield_contains_required'>
                                    <label class='gfield_label' for='input_2'>Имя<span class='gfield_required'>*</span></label>
                                    <div class='ginput_container'>
                                        <input name='input_2' id='input_2' type='text' value='' class='medium'  tabindex='2'/>
                                    </div>
                                </li>-->
                <li id='field_1_3' class='gfield gfield_contains_required' >
                    <label class='gfield_label' for='input_3'>Email<span class='gfield_required'>*</span></label>
                    <div class='ginput_container'>
                        <input name='input_3' id='input_3' type='email' value='' class='medium'  tabindex='3' required=""  />
                    </div>
                    <small class="error">Email формат неверен.</small>
                </li>
                <li id='field_1_4' class='gfield gfield_contains_required' >
                    <label class='gfield_label' for='input_4'>Пароль<span class='gfield_required'>*</span></label>
                    <div class='ginput_container'>
                        <input name='input_4' id='input_4' type='password' value='' class='medium'  tabindex='4' required=""  />
                    </div>
                    <small class="error">Пароль обязателен.</small>
                </li>
                <!--                <li id='field_1_5' class='gfield gfield_contains_required' >
                                    <label class='gfield_label' for='input_5'>Ключевое слово<span class='gfield_required'></span></label>
                                    <div class='ginput_container'>
                                        <input name='input_5' id='input_5' type='text' value='' class='medium'  tabindex='5'   />
                                    </div>
                                </li>
                                <li id='field_1_6' class='gfield gfield_contains_required' >
                                    <label class='gfield_label' for='input_6'>Ключевое слово<span class='gfield_required'></span></label>
                                    <div class='ginput_container'>
                                        <input name='input_6' id='input_6' type='text' value='' class='medium'  tabindex='6'   />
                                    </div>
                                </li>
                                <li id='field_1_7' class='gfield gfield_contains_required' >
                                    <label class='gfield_label' for='input_7'>Ключевое слово<span class='gfield_required'></span></label>
                                    <div class='ginput_container'>
                                        <input name='input_7' id='input_7' type='text' value='' class='medium'  tabindex='7'   />
                                    </div>
                                </li>-->
            </ul>
        </div>
        <div class='gform_footer top_label'> <input type='submit' id='gform_submit_button_1' class='button gform_button' value='Отправить данные' tabindex='11' />
            <!--            <input type='hidden' class='gform_hidden' name='is_submit_1' value='1' />
                        <input type='hidden' class='gform_hidden' name='gform_submit' value='1' />
                        <input type='hidden' class='gform_hidden' name='gform_unique_id' value='' />
                        <input type='hidden' class='gform_hidden' name='state_1' value='WyJhOjA6e30iLCIxYjQxOTEwMWE4NWZkYWE0ZTI3MmM1ZmQ5ZDQ4NmNhNCJd' />
                        <input type='hidden' class='gform_hidden' name='gform_target_page_number_1' id='gform_target_page_number_1' value='0' />
                        <input type='hidden' class='gform_hidden' name='gform_source_page_number_1' id='gform_source_page_number_1' value='1' />
                        <input type='hidden' name='gform_field_values' value='' />-->

        </div>
    </form>
</div>
<script 
    type='text/javascript'> jQuery(document).ready(function () {
            jQuery(document).trigger('gform_post_render', [1, 1])
        });
</script>
