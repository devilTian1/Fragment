<table class="column_95">
  <caption>
  客户端TCP访问表
  </caption>
  <tbody>
    <tr>
      <td class="tdheader"><input name="web" type="checkbox" checked="checked" disabled="disabled"/></td>
      <td class="tdbody">Web (https) 管理</td>
    </tr>
    <tr>
      <td class="tdheader"><input name="cmd" type="checkbox" checked="checked" disabled="disabled"/></td>
      <td class="tdbody"> 串口命令行 </td>
    </tr>
    <tr>
      <td class="tdheader"><input type="checkbox" name="ssh" id="ssh" value="1" /></td>
      <td class="tdbody"> 启用远程 SSH </td>
    </tr>
    <tr>
      <td></td>
      <td class="tdbody">
          <input type="button" value="确定" width="50" id="submitbtn" class="inputbtn" />
       </td>
    </tr>
   </tbody>
</table>
<script type="text/javascript">
	 $(document).ready(function() {
		$('#submitbtn').click(function(){
			var flag=$('#ssh').attr('checked');
			tipAutoHide(4,'数据正在处理，请稍后',5);//显示提示
			$.post("test.php", { ssh: $('#ssh').val(), flag: flag },
				   function(data){
					 alert("Data Loaded: " + data);
			});
			//tipAutoHide(4,'数据正在处理，请稍后',5);//显示提示
			//tipAutoHide(1);
		})
	})
</script>