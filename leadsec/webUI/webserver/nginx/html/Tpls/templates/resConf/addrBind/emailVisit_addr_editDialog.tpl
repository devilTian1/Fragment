<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
      <td class="tdheader" width="120"><span class="red">*</span> 名称:</td>
      <td class="tdbody">
        <input type="text" name="inputtext3" class="inputtext"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 ) </div></td>
    </tr>
    <tr>
      <td class="tdheader">邮件地此:</td>
      <td class="tdbody">
        <input type="text" name="inputtext3"  class="inputtext"/>
        &nbsp;( 如test@sina.com.cn)</td>
    </tr>
    <tr>
      <td class="tdheader">
        <input type="button" name="button" id="button" value="&gt;&gt;" class="inputbtn" />
        <br />
        <br />
        <input type="button" name="button2" id="button2" value="&lt;&lt;" class="inputbtn" />
        <br /></td>
      <td class="tdbody">
        <label>
          <select name="select" size="7" class="w200" id="select">
          </select>
        </label>
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>类别:</td>
      <td class="tdbody">
        <label>
          <input name="radio" type="radio" id="radio" value="radio" checked="checked" /> 收件人
        </label>
        <label>
          <input type="radio" name="radio" id="radio2" value="radio" />发件人
        </label>
        </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>备注:</td>
      <td class="tdbody">
        <input type="text" name="inputtext3"  class="inputtext"/>
      </td>
    </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript">
$(document).ready(function() {
	 $("#add, .inputbtn").button();					   
});
</script>