<form action="Function/systemManagement/admin/account.php" method="POST" id="expTimeForm"
onSubmit="return false;">
  <table class="column_95">
    <caption>
     地址绑定服务
    </caption>
    <tbody>
      <tr>
        <td class="tdheader" width="200">当前服务状态:</td>
        <td class="tdbody"><span class="red">停止</span></td>
      </tr>
      <tr>
        <td></td>
        <td class="tdbody"><button class="inputbtn standard" type="button"
                    id="setLimitErrTimeBtn" onclick="setLimitErrTime()">启动服务</button>
                    <button class="inputbtn standard" type="button"
                     onclick="setLimitErrTime()">停止服务</button>
        </td>
      </tr>
    </tbody>
  </table>
</form>
<br/>
<form action="Function/systemManagement/admin/account.php" method="POST" id="limitErrForm"
onSubmit="return false;">
  <table class="column_95">
    <caption>
      主动探测IP/MAC对
    </caption>
    <tbody>
      <tr>
        <td width="200" class="tdheader"><label>
          <input type="radio" name="radio" id="radio" value="radio" />
          按网口探测:</label>
          </td>
        <td class="tdbody"><label>
          <input type="checkbox" name="checkbox" id="checkbox" />
        </label></td>
      </tr>
      <tr>
        <td class="tdheader"><input type="radio" name="radio" id="radio2" value="radio" />
        按 IP 探测:</td>
        <td class="tdbody">
        	<input name="" type="text" />
        </td>
      </tr>
      <tr>
        <td class="tdheader"></td>
        <td><input name="按钮" type="button" value="探测" width="50" class="inputbtn"  />
          <input name="按钮" type="button" value="探测到的IP与地此对" width="50" class="inputbtn" /></td>
      </tr>
    </tbody>
</table>
</form>
<br/>
<table class="column_95 textMid tablesorter" id="accountTable">
    <caption>已绑定IP/MAC对</caption>
    <thead>
        <tr>
            <th class="column_20">IP地址</th>
            <th class="column_30">MAC地址</th>
            <th class="column_30">唯一性检查</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr><td colspan='4'>Loading ...</td></tr>
    </tbody>
</table>
<button class="floatLeft inputbtn" type="button"
    onClick="openNewAccountDialog()" id="add">
添加</button>

<script type="text/javascript">
$(document).ready(function() {
   $('.inputbtn').button();
});
</script>
