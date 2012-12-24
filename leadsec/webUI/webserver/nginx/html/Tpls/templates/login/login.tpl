<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><{$smarty.const.COMPANY_NAME}> <{$smarty.const.PRODUCT_NAME}></title>
<link href="<{$smarty.const.THEME_PATH}>/css/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
 <div id="login">
	     <div id="top">
		      <div id="top_left"><img src="<{$smarty.const.THEME_PATH}>/images/login_03.gif" /></div>
			  <div id="top_center"></div>
		 </div>
		 
		 <div id="center">
		      <div id="center_left"></div>
			  <div id="center_middle">
       	       <form action="index.php" method="post" id="loginform" onsubmit="return false">
			       <div id="user">账 号
			         <input type="text" name="account" id="account" /><br/>
                     <div id="user_error"></div>
			       </div>
                   
				   <div id="password">密   码
				     <input type="password" name="passwd" id="passwd" /><br/>
                      <div id="passwd_error"></div>
				   </div>
				   <div id="btn">
                   	<input name="提交" type="submit" id="submitbtn" value="登录" />
                    <input name="重置" type="reset" value="清空" />
                   </div>
                  
			  	</form>
			  </div>
			  <div id="center_right"></div>		 
		 </div>
		 <div id="down">
		      <div id="down_left">
			      <div id="inf">
                       <span class="inf_text">版权信息</span>
					   <span class="copyright">@ 2010-2020 <{$smarty.const.COMPANY_NAME}>版权所有</span>
			      </div>
			  </div>
			  <div id="down_center">
              		<div id="login_error"></div>
              </div>		 
		 </div>

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
							location.href='index.php';
						}else{
							$('#login_error').html(data).show();
							$('#login_error').fadeOut(3000);
						}
					});	
			}
		})						
	}); 
</script>
