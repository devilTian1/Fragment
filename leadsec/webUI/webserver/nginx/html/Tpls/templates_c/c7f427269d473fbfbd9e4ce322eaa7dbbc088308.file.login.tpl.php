<?php /* Smarty version Smarty-3.1.11, created on 2013-07-08 10:57:50
         compiled from "D:\leadsec\Fragment\leadsec\webUI\webserver\nginx\html\Tpls\templates\login\login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:465451da9b2e4ab872-39018385%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c7f427269d473fbfbd9e4ce322eaa7dbbc088308' => 
    array (
      0 => 'D:\\leadsec\\Fragment\\leadsec\\webUI\\webserver\\nginx\\html\\Tpls\\templates\\login\\login.tpl',
      1 => 1366726990,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '465451da9b2e4ab872-39018385',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.11',
  'unifunc' => 'content_51da9b2e51bc40_30854694',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_51da9b2e51bc40_30854694')) {function content_51da9b2e51bc40_30854694($_smarty_tpl) {?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><?php echo @COMPANY_NAME;?>
 <?php echo @PRODUCT_NAME;?>
</title>
<link href="<?php echo @THEME_PATH;?>
/css/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="login_bg">
	<div id="login_left"></div>
    <div id="login_center">
    	<div id="login_c_bg"></div>
        <div id="login_top"></div>
      <div id="login_nav">
       	<div id="nav_name">欢迎使用<?php echo @PRODUCT_NAME;?>
</div>
        <div id="nav_lang" style=display:none>
       	  		<span id="nav_lang_c">中文</span>
                <span id="nav_lang_flag"><span id="switch_lang" class="zhc"><img src="<?php echo @THEME_PATH;?>
/images/login_zhc.gif"/></span></span>
       			<span id="nav_lang_e" >英文</span>
        </div>
        </div>
        <div id="login_cen">
        	  <form action="index.php" method="post" id="loginform" onsubmit="return false">
            	<input name="lang" type="hidden" value="zhc" id="lang" />
                <div id="cen_input">
                    <label><span>账号</span><input type="text" name="account" id="account" /></label>
                    <label><span>密码</span><input type="password" name="passwd" id="passwd" /></label>
                    <div id="user_error"></div>
                    <div id="passwd_error"></div>
                    <div id="login_error"></div>
                 </div>
                 <div id="btn">
                    <input type="submit" value="" id="submitbtn" name="提交">
                    <input type="reset" value=""  id="resetbtn" name="重置">
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
		$('#submitbtn').click(function(){
			if($("#account").val()==""){
				$('#user_error').html("用户名不能为空").show();
				$('#user_error').fadeOut(3000);
			}else if($("#passwd").val()==""){
				$('#passwd_error').html("密码不能为空").show();
				$('#passwd_error').fadeOut(3000);
			}else{
				$.post("index.php?chkusr=ok", $("#loginform").serialize(),
				   function(data){
					if(data==='sucess'){
							window.location.href='index.php';
						}else{
							$('#login_error').html(data).show();
							$('#login_error').fadeOut(3000);
						}
					});	
			}
		});
		$("#switch_lang").click(function(){
			var lang=$("#lang").val();
			    if(lang=="zhc"){
					$("#lang").val("en");
					$("#switch_lang img").attr("src","<?php echo @THEME_PATH;?>
/images/login_en.gif")
				}else if(lang=="en"){
					$("#lang").val("zhc");
					$("#switch_lang img").attr("src","<?php echo @THEME_PATH;?>
/images/login_zhc.gif")
				}
			})
	}); 
</script>
<?php }} ?>