<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>LeadSec网御 安全隔离网闸</title>
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
       	       <form action="index.php" method="post" id="loginform">
			       <div id="user">账 号
			         <input type="text" name="account" id="account" />
                     <div id="user_error">帐号不能为空</div>
			       </div>
                   
				   <div id="password">密   码
				     <input type="password" name="passwd" id="passwd" />
                      <div id="passwd_error">帐号不能为空</div>
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
					   <span class="copyright">@ 2010-2020 北京网御星云信息技术有限公司版权所有</span>
			      </div>
			  </div>
			  <div id="down_center">
              		<div id="login_error"></div>
              </div>		 
		 </div>

	</div>

</body>
</html>
<script type="text/javascript">
if(window.self!=window.top){
		alert('sdf');
		window.top=window.self;
}
</script>
<script type="text/javascript" src="Public/js/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="Public/js/formvalidator/formValidator-4.1.3.min.js"></script>
<script type="text/javascript">
	if(window.self!=window.top){
			window.top.location.href=window.self.location.href;
	 }
     $(document).ready(function() {
	    $.formValidator.initConfig({formID:"loginform",theme:"Default",
			ajaxForm:{
				type : "POST",
				url: "index.php?chkusr=ok",
				success:function(data){
					if(data==='sucess'){
						location.href='index.php';
					}else{
						$('#login_error').html(data).show();
						$('#login_error').fadeOut(3000);
					}
				}
			},
			submitAfterAjaxPrompt : '身份正在验证中，请稍等...'
		});
		$("#account").formValidator({tipID:"user_error",onShowText:"请输入账号",onShow:"请输入账号",onFocus:"账号不能为空",onCorrect:""}).inputValidator({min:5,max:15,onError:"账号非法"});
	
		$("#passwd").formValidator({tipID:"passwd_error",onShow:"请输入密码",onFocus:"至少1个长度",onCorrect:""}).inputValidator({min:1,empty:{leftEmpty:false,rightEmpty:false,emptyError:"密码两边不能有空符号"},onError:"密码不能为空"});
								
	}); 
</script>
