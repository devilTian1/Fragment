<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
      <td class="tdheader"><span class="red">*</span> 名称:</td>
      <td class="tdbody">
        <input type="text" name="inputtext2" class="inputtext"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 )</td>
    </tr>  <tr>
        <td class="tdheader">禁止的内容:</td>
        <td class="tdbody"><input type="text" name="inputtext3"  class="inputtext"/></td>
      </tr>
    <tr>
      <td class="tdheader"></td>
      <td class="tdbody">
      	支持的通配符:
        <div class="pl50">*代表任意字符，包括空格</div>
        <div class="pl50">？代表任意单个字符</div>
        <div class="pl50">\\代表单个\</div>
        <div class="pl50">\*代表单个*</div>
        <div class="pl50">\?代表单个?</div>
      </td>
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
	 $("#add, .inputbtn").button();					   
});
</script>