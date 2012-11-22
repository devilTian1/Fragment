<form action="Function/systemManagement/admin/account.php" method="POST" id="expTimeForm"
onSubmit="return false;">
  <table class="column_95">
   <caption>
    自动升级
    </caption>
    <tbody>
    <tr>
      <td class="tdheader" width="200"><label>
        <input type="checkbox" name="checkbox" id="checkbox" />
        启用 </label>:</td>
      <td class="tdbody">升级服务器地此：
        <input type="text" name="inputtext2"/>
        &nbsp;&nbsp;升级服务器端口：
        <input type="text" name="inputtext2"/>
      </td>
    </tr>
    <tr>
      <td class="tdheader"><label>
        <input type="radio" name="radio" id="radio" value="radio" />
        实时升级 </label>:</td>
      <td class="tdbody">&nbsp;</td>
    </tr>
    <tr>
      <td class="tdheader"><input type="radio" name="radio" id="radio2" value="radio" />
        定时升级:</td>
      <td class="tdbody">
      <div>
        <label>
          <input type="radio" name="radio3" id="radio3" value="radio3" />
        </label>
        每隔
        <label>
          <select name="select" id="select">
          </select>
          小时</label>
        </div>  
        <div class="rowElem">
          <label>
            <input type="radio" name="radio3" id="radio4" value="radio3" />
          </label>
          每天
          <label>
            <select name="select2" id="select2">
            </select>
            点（小时） </label>
        </div>
        <div class="rowElem">
          <label>
            <input type="radio" name="radio3" id="radio5" value="radio3" />
          </label>
          每周
          <label>
            <select name="select3" id="select3">
            </select>
            天
            <select name="select4" id="select4">
            </select>
            点（小时） </label>
        </div>
      </td>
    </tr>
    <tr>
      <td class="tdheader"></td>
      <td>
        <input name="按钮" type="button" value="确定" width="50" class="inputbtn"  />
        <input name="按钮" type="button" value="立即升级" width="50" class="inputbtn" />
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
    手动升级
    </caption>
    <tbody>
        <tr>
            <td class="tdheader" width="200">病毒库当前版本：</td>
            <td class="tdbody"><span class="red">2001.8.1</span></td>
        </tr>
        <tr>
            <td class="tdheader"><span class="red">*</span>升级文件:</td>
            <td class="tdbody">
               <input name="" type="file" />
            </td>
        </tr>
        <tr>
            <td></td>
            <td class="tdbody">
                <button class="inputbtn standard" type="button"
                    id="setLimitErrTimeBtn" onClick="setLimitErrTime()">
                升级
                </button>
            </td>
        </tr>
    </tbody>
</table>
</form>
<br/>
<table class="column_95 textMid tablesorter" id="accountTable">
    <caption>导出升级历史</caption>
    <thead>
        <tr>
            <th class="column_20">序号</th>
            <th class="column_30">更新版本</th>
            <th class="column_30">当前时间</th>
            <th class="column_20">时间</th>
        </tr>
    </thead>
    <tbody>
        <tr><td colspan='4'>Loading ...</td></tr>
    </tbody>
</table>
<button class="floatLeft inputbtn" type="button"
    onClick="openNewAccountDialog()" id="add">
导出升级历史</button>

<script type="text/javascript">
$(document).ready(function() {
   $('.inputbtn').button();
});
</script>
