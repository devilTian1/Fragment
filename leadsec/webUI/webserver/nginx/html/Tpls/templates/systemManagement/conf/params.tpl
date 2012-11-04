<form action="" method="post" name="form1" id="form1">
<table class="column_95">
  <caption>
  安全隔离网闸名称
  </caption>
  <tbody>
    <tr>
      <td width="250" class="tdheader">安全隔离网闸名称:</td>
      <td class="tdbody"><input name="netname" value="napname" type="text" id="netname" style="float:left" /><span id="netnameTip" style="width:280px; float:left"></span></td>
    </tr>
    <tr>
      <td></td>
      <td class="tdbody">
          <input type="submit" value="确定" width="50" id="submitbtn" class="inputbtn" />
       </td>
    </tr>
   </tbody>
</table>
</form>
<script type="text/javascript">
$(document).ready(function() {
	$("#submitbtn").button();
 	$.formValidator.initConfig({formID:"form1",theme:"126",
			ajaxForm:{
				type : "POST",
				url: "index.php?chkusr=ok",
				success:function(data){
					
				}
			},
			submitAfterAjaxPrompt : '身份正在验证中，请稍等...'
		});
		$("#netname").formValidator({tipID:"netnameTip",onShow:"( 1-20 个ASCII字符 )",onShowText:"( 1-20 个ASCII字符 )",onFocus:"名称不能为空",onCorrect:""}).inputValidator({min:1,max:20,onError:"名称非法"})
 
});
</script>