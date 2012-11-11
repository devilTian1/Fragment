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
       	 <input type="radio" name="radio" id="radio2" value="radio" />禁止
     	</label>
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>SQL语句列表:</td>
      <td class="tdbody">
          <label>
            <input type="checkbox" name="checkbox" id="checkbox" />CREATE
          </label>
          <label>
            <input type="checkbox" name="checkbox2" id="checkbox2" />DELETE
          </label>
          <label>
         	<input type="checkbox" name="checkbox3" id="checkbox3" />INTERT
          </label>
          <label>
          	<input type="checkbox" name="checkbox4" id="checkbox4" />UPDATE
          </label>
          <label>
          	<input type="checkbox" name="checkbox5" id="checkbox5" />ALTER
          </label>
          <label>
          	<input type="checkbox" name="checkbox6" id="checkbox6" />DROP
          </label>
          <label>
          <input type="checkbox" name="checkbox7" id="checkbox7" />SELECT
          </label>
      </td>
    </tr>
    <tr>
      <td class="tdheader"></td>
      <td class="tdbody"><span class="red">注：禁用SELECT命令会造成数据库连接不成功</span></td>
    </tr>
    <tr>
      <td class="tdheader">备注：</td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
      </td>
    </tr>
  <tbody>
</table>
</form>
<script type="text/javascript">
$(document).ready(function() {
	 $("#add, .inputbtn").button();					   
});
</script>