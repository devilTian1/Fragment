<style type="text/css">
	#filetypeLable label{ display:block; float:left; width:60px;}
</style>
<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
      <td class="tdheader"><span class="red">*</span> 名称:</td>
      <td class="tdbody">
        <input type="text" name="inputtext3" class="inputtext"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 )</td>
    </tr>  <tr>
        <td class="tdheader">允许文件组名:</td>
        <td class="tdbody"><label>
          <select name="select" class="w200" id="select3">
          </select>
        </label></td>
      </tr>
      <tr>
        <td class="tdheader">内容黑名单:</td>
        <td class="tdbody"><label>
          <select name="select" class="w200" id="select4">
          </select>
        </label></td>
      </tr>
      <tr>
        <td class="tdheader">内容白名单:</td>
        <td class="tdbody"><label>
          <select name="select" class="w200" id="select">
          </select>
        </label></td>
      </tr>
    <tr>
      <td class="tdheader">文件类型:</td>
      <td class="tdbody" id="filetypeLable">
      	<label><input name="EXE" type="checkbox" value="EXE" />EXE</label>
        <label><input name="PDF" type="checkbox" value="PDF" />PDF</label>
        <label><input name="RAR" type="checkbox" value="RAR" />RAR</label>
        <label><input name="ZIP" type="checkbox" value="ZIP" />ZIP</label>
        <label><input name="MSO" type="checkbox" value="MSO" />MSO</label>
        <label><input name="ELF" type="checkbox" value="ELF" />ELF</label>
        <label><input name="JPG" type="checkbox" value="JPG" />JPG</label>
        <label><input name="TGZ" type="checkbox" value="TGZ" />TGZ</label>
       <br/><span class="red"> 所有微软office文件都属于MSO类型</span>
      </td>
    </tr>
    <tr>
      <td class="tdheader">类型过滤操作:</td>
      <td class="tdbody"><input name="radio1" type="radio" id="radio11" value="radio" checked="checked" />
        允许
          <input type="radio" name="radio1" id="radio12" value="radio" />
        禁止 </td>
    </tr>
    <tr>
      <td class="tdheader">文件大小</td>
      <td class="tdbody">下限
        <input type="text" name="inputtext2"  class="inputtext"/>
        上限
        <input type="text" name="inputtext4"  class="inputtext"/>
        K</td>
    </tr>
    <tr>
      <td class="tdheader">文件修改时间</td>
      <td class="tdbody">下限
        <input type="text" name="inputtext4"  class="inputtext"/>
        上限
        <input type="text" name="inputtext4"  class="inputtext"/></td>
    </tr>
    <tr>
      <td class="tdheader">&nbsp;</td>
      <td class="tdbody">有效时间格式(YYYY/MM/DD-hh:mm:ss)</td>
    </tr>
    <tr>
      <td class="tdheader">备注：</td>
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