<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><{$smarty.const.COMPANY_NAME}> <{$smarty.const.PRODUCT_NAME}></title>
<link href="<{$smarty.const.THEME_PATH}>/<{$smarty.cookies.web_locale}>/css/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="login_bg">
	<div id="login_left"></div>
    <div id="login_center">
    	<div id="login_c_bg"></div>
        <div id="login_top"></div>
      <div id="login_nav">
       	<div id="nav_name"><{$n.welcome}></div>
        <div id="nav_lang">
            	<input name="lang" type="hidden" value="<{$smarty.cookies.web_locale|default: 'zh_CN.UTF-8'}>" id="lang"/>
       	  		<span id="nav_lang_c"><{$n.langZh}></span>
                <span id="nav_lang_flag"><span id="switch_lang" class="zhc"><img src="<{$smarty.const.THEME_PATH}>/<{$smarty.cookies.web_locale}>/images/login_<{$smarty.cookies.web_locale}>.gif"/></span></span>
       			<span id="nav_lang_e" ><{$n.langUs}></span>
        </div>
        </div>
        <div id="login_cen">
            <form action="index.php?R=login/login/login" method="post" id="loginform">
                <div id="cen_input">
                    <label><span><{$n.account}></span><input type="text" name="account" id="account" /></label>
                    <label><span><{$n.passwd}></span><input type="password" name="passwd" id="passwd" /></label>
                    <div id="user_error"></div>
                    <div id="passwd_error"></div>
                    <div id="login_error"><{$errMsg}></div>
                 </div>
                 <div id="btn">
                    <input type="submit" value="" id="submitbtn"
                        name="<{$n.submitBtn}>">
                    <input type="reset" value=""  id="resetbtn"
                        name="<{$n.resetBtn}>">
                 </div>
             </form>
        </div>
        <div id="login_bottom"></div>
        <div id="login_b_bg"></div>
    </div>
    <div id="login_right"></div>
</div>
</body>
</html>
<script type="text/javascript" src="Public/js/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript">
	if(window.self!=window.top){
		 window.top.location.href=window.self.location.href;
	 }
     $(document).ready(function() {
		$('#loginform').submit(function() {
            var isValid = true;
			if ($("#account").val()=="") {
				$('#user_error').html('<{$n.userReq}>').show();
                isValid = false;
			}
            if ($("#passwd").val() == "") {
				$('#passwd_error').html('<{$n.pwdReq}>').show();
                isValid = false;
			}
            if (isValid) {
                $('#loginform').submit();
            } else {
                return false;
            }
		});
		$("#switch_lang").click(function(){
			var lang    = $("#lang").val();
            var newLang = 'zh_CN.UTF-8';
            if (lang == 'zh_CN.UTF-8') {
                newLang = 'en_US.UTF-8';
            }
            var imgPath = '<{$smarty.const.THEME_PATH}>/' +
                '<{$smarty.cookies.web_locale}>/images/login_' +
                newLang + '.gif';
            $("#lang").val(newLang);
            $("#switch_lang img").attr("src", imgPath);
            window.location.href =
                'index.php?R=developTools/lang/switchLang&lang=' + newLang;
		});
	}); 
</script>
