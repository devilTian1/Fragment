<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
      <td class="tdheader"><span class="red">*</span> 名称:</td>
      <td class="tdbody">
        <input type="text" name="inputtext2" class="inputtext"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 )</td>
    </tr>
    <tr>
      <td class="tdheader">关键字:</td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
        &nbsp;( 如法轮功，关键字最大长度为30)</td>
    </tr>
    <tr>
      <td class="tdheader">
        <input type="button" name="button3" id="button3" value="&gt;&gt;" class="inputbtn" />
        <br />
        <br />
        <input type="button" name="button3" id="button4" value="&lt;&lt;" class="inputbtn" />
        <br /></td>
      <td class="tdbody">
        <label>
          <select name="select2" size="7" class="w200" id="select2">
          </select>
        </label>
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>类别:</td>
      <td class="tdbody">
        <label>
          <input name="radio" type="radio" id="radio3" value="radio" checked="checked" />主题
        </label>
        <label>
          <input type="radio" name="radio" id="radio4" value="radio" />正文
        </label>
        </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>备注:</td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
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