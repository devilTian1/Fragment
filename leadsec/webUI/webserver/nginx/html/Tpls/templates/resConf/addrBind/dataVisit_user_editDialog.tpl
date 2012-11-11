<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
    <tr>
      <td class="tdheader"><span class="red">*</span>名称:</td>
      <td class="tdbody">
        <input type="text" name="inputtext2" class="inputtext"/>
        &nbsp;( 1-19个合法安符)</td>
    </tr>
    <tr>
      <td class="tdheader">过滤模式:</td>
      <td class="tdbody">
      <label>
       <input type="radio" name="radio" id="radio" value="radio" />允许
      </label>
      <label>
        <input type="radio" name="radio" id="radio2" value="radio" />阻止
      </label>
      
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>用户名列表:</td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
      （1-1024个字符）</td>
    </tr>
    <tr>
      <td class="tdheader"></td>
      <td class="tdbody">说明：<br/>
       1.该用户名针对数据库访问用户;<br/>
        2.多个用户名之间用（",")隔开</br></td>
    </tr>
    <tr>
      <td class="tdheader">备注：</td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
        &nbsp;( 0-253个字符. ) </div></td>
    </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript">
$(document).ready(function() {
	 $("#add, .inputbtn").button();					   
});
</script>