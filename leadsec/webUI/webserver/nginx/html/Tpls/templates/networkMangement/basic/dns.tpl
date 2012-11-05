<table class="column_95">
    <caption>
域名服务器
  </caption>
  <form action="" method="POST" id="form1">
    <tbody>
    <tr>
      <td class="tdheader" width="250">域名服务器IP1:</td>
      <td class="tdbody">
        <input type="text" name="serverip1" id="serverip1" style="float:left"/>
        <span id="serverip1Tip" style="width:300px; float:left"></span>
       </td>
    </tr>
    <tr>
      <td class="tdheader">域名服务器IP2:</td>
      <td class="tdbody">
      	<input type="text" name="serverip2" id="serverip2" style="float:left"/>
      	<span id="serverip2Tip" style="width:300px; float:left"></span>
      </td>
    </tr>
    <tr>
      <td class="tdheader"></td>
      <td class="tdbody"><input type="submit" value="确定" width="50" class="inputbtn" /></td>
    </tr>
    </tbody>
    </form>
  </table>
<script type="text/javascript">
$(document).ready(function() {
    $(".inputbtn").button();
	$.formValidator.initConfig({formID:"form1",theme:"126",
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
	$("#serverip1").formValidator({onShow:"请输入ip4",onfocus:"例如：172.16.201.18",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"ip4格式不正确"});
	$("#serverip2").formValidator({onShow:"请输入ip4",onfocus:"例如：172.16.201.18",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"ip4格式不正确"});

});
</script>
