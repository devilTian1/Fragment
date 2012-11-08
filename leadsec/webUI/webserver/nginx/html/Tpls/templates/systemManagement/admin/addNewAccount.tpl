<form action="" method="POST" id="accountForm">
    <fieldset>
        <legend>管理员帐号维护</legend>
        <div class="row">
            <label for="account">帐号:<em class="required">*</em></label>
            <input type="text" name="account" maxlength="15" value="<{$account}>" id="account"/>
            <span class="tip" id="accountTip"></span>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="passwd">口令:<em class="required">*</em></label>
            <input type="password" name="passwd" maxlength="15" id="passwd"/>
            <span class="tip" id="passwdTip">(8-15位字母和数字的组合)</span>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="passwd_c">确认口令:<em class="required">*</em></label>
            <input type="password" name="passwd_c" maxlength="15" id="passwd_c"/>
            <span class="tip" id="paswd_cTip"></span>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="passwd_c">帐号类型:</label>
            <input class="checkbox" type="checkbox" name="confAdmin"/>
            <label for="confAdmin">配置管理员</label>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>&nbsp;</label>
            <input class="checkbox" type="checkbox" name="policyAdmin"/>
            <label for="policyAdmin">策略管理员</label>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>&nbsp;</label>
            <input class="checkbox" type="checkbox" name="logAdmin"/>
            <label for="logAdmin">日志审计员</label>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>

<script type="text/javascript">
    $(document).ready(function(){
        $.formValidator.initConfig({formID:"accountForm",theme:"Default",
		    ajaxForm:{
			    type : "POST",
				url  : "index.php",
				success:function(data){
					if(data==='sucess'){
						//tipAutoHide(2);//修改成功
					}else{
						//tipAutoHide(1);//修改失败
					}
				}
			},
			submitAfterAjaxPrompt : '身份正在验证中，请稍等...'
		});
		$("#account").formValidator({onShow:"请输入主机ip,不能为空",onfocus:"例如：172.16.201.18",onCorrect:""}).regexValidator({regExp:"username",dataType:"json",onError:"格式不正确"}).ajaxValidator({
                         dataType: 'json',
                         async: true,
                         url: 'Function/login.php',
                         success: function(data) {alert(data.msg)},
                         error: function() {alert('error')},
                         onError: 'onerror',
                         onWait: 'wait'
                     }).defaultPassed();
    });
</script>
