<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
      <td class="tdheader"><span class="red">*</span> 任务号</td>
      <td class="tdbody">
        <input type="text" name="inputtext3" class="inputtext"/>(同一端的任务号必须唯一)</td>
    </tr>
      <tr>
        <td class="tdheader"><span class="red">*</span>服务器地此:</td>
        <td class="tdbody"><input type="text" name="inputtext4"  class="inputtext"/>(如10.0.0.1)</td>
      </tr>
      <tr>
        <td class="tdheader"><span class="red">*</span>服务器端口:</td>
        <td class="tdbody"><input type="text" name="inputtext2"  class="inputtext"/>(1-65535)</td>
      </tr>
      <tr>
        <td class="tdheader">公开端口:</td>
        <td class="tdbody"><input type="text" name="inputtext5"  class="inputtext"/>(1-65535) （如填写需与客户端目的端口一致）</td>
      </tr>
      <tr>
        <td class="tdheader">流出端口IP:</td>
        <td class="tdbody"><select name="select" class="w200">
        </select></td>
      </tr>
      <tr>
        <td class="tdheader">服务类型:</td>
        <td class="tdbody"><select name="select" class="w200">
        </select></td>
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
      <td class="tdheader">开启日志： </td>
      <td class="tdbody"><input name="radio" type="radio" id="radio" value="radio" checked="checked" />
        是
        <input type="radio" name="radio" id="radio2" value="radio" />
        否</td>
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