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
      <td class="tdheader"><span class="red">*</span>身份认证及加密传输: :</td>
      <td class="tdbody">
        <input name="radio" type="radio" id="radio" value="radio" checked="checked" />
        是
        <input type="radio" name="radio" id="radio2" value="radio" />
        否
      </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>客户端证书公共名:</td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
( 0-3650 天，0表示不限制 ) </td>
    </tr>
    <tr>
      <td class="tdheader">病毒扫描：</td>
      <td class="tdbody">
        <input name="radio1" type="radio" id="radio3" value="radio" checked="checked" />
        否
        <label></label>
        <input type="radio" name="radio1" id="radio4" value="radio" />
        <label></label>
二进制文件扫描
<label></label>
        <input type="radio" name="radio1" id="radio9" value="radio" />
全扫描</td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>是否启动： </td>
      <td class="tdbody">
        <input name="radio2" type="radio" id="radio5" value="radio" checked="checked" />
        启动
        <input type="radio" name="radio2" id="radio6" value="radio" />
        停止</td>
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