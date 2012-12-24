<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
      <td class="tdheader"><span class="red">*</span> 任务号</td>
      <td class="tdbody">
        <input type="text" name="inputtext3" class="inputtext"/>(同一端的任务号必须唯一)</td>
    </tr>  <tr>
        <td class="tdheader">源地此:</td>
        <td class="tdbody"><label>
          <select name="select" class="w200" id="select">
          </select>
        </label>
          </td>
      </tr>
      <tr>
        <td class="tdheader"><span class="red">*</span>本机地此:</td>
        <td class="tdbody"><label>
          <select name="select" class="w200" id="select3">
          </select>
        </label>
          </td>
      </tr>
      <tr>
        <td class="tdheader"><span class="red">*</span>本机端口:</td>
        <td class="tdbody"><input type="text" name="inputtext2"  class="inputtext"/>(1-65535)</td>
      </tr>
      <tr>
        <td class="tdheader">本机备份：</td>
        <td class="tdbody"><input name="radio3" type="radio" id="radio3" value="radio" checked="checked" />
          是
          <label></label>
          <input type="radio" name="radio3" id="radio4" value="radio" />
          <label></label>
          否
          <label></label></td>
      </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>身份认证及传输加密:</td>
      <td class="tdbody">
        <input name="radio" type="radio" id="radio" value="radio" checked="checked" />
        是
        <input type="radio" name="radio" id="radio2" value="radio" />
        否
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>客户端证书公共名:</td>
      <td class="tdbody"><input type="text" name="inputtext4"  class="inputtext"/></td>
    </tr>
    <tr>
      <td class="tdheader">病毒扫描：</td>
      <td class="tdbody"><input name="radio1" type="radio" id="radio7" value="radio" checked="checked" />
        是
        <label></label>
        <input type="radio" name="radio1" id="radio8" value="radio" />
        <label></label>
        否
        <label></label></td>
    </tr>
    <tr>
      <td class="tdheader">生效时段:</td>
      <td class="tdbody">
        <label>
          <select name="select2" class="w200" id="select2">
          </select>
        </label></td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>备注：</td>
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