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
      <td class="tdheader">用户名过滤组:</td>
      <td class="tdbody">
        <label>
          <select name="select" class="w200" id="select">
          </select>
        </label>
      </td>
    </tr>
    <tr>
      <td class="tdheader">SQL语句过滤组:</td>
      <td class="tdbody">
        <label>
          <select name="select" class="w200" id="select">
          </select>
        </label>
      </td>
    </tr>
    <tr>
      <td class="tdheader">流病毒扫描:</td>
      <td class="tdbody">
        <label>
          <input type="checkbox" name="checkbox" id="checkbox" />
        </label>
	</td>
    </tr>
    <tr>
      <td class="tdheader">备注:</td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
      </td>
    </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript">
$(document).ready(function() {
						   
});
</script>