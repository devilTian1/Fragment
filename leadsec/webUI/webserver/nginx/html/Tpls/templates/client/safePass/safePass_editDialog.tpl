<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
      <td class="tdheader"><span class="red">*</span> 任务号</td>
      <td class="tdbody">
        <input type="text" name="inputtext3" class="inputtext"/>(同一端的任务号必须唯一)</td>
    </tr>  <tr>
        <td class="tdheader">访问类型:</td>
        <td class="tdbody"><input name="radio" type="radio" id="radio" value="radio" checked="checked" />
          普通访问
          <input type="radio" name="radio" id="radio2" value="radio" />
         透明访问</td>
      </tr>  
      <tr>
        <td class="tdheader">源地此:</td>
        <td class="tdbody"><label>
          <select name="select" class="w200" id="select">
          </select>
        </label>
          </td>
      </tr>
      <tr>
        <td class="tdheader">源端口:</td>
        <td class="tdbody"><input type="text" name="inputtext4"  class="inputtext"/>
(1-65535) （输入形如:1200或2000：3000）</td>
      </tr>
      <tr>
        <td class="tdheader"><span class="red">*</span>目的地此:</td>
        <td class="tdbody"><label>
          <select name="select" class="w200" id="select3">
          </select>
        </label>
          </td>
      </tr>
      <tr>
        <td class="tdheader"><span class="red">*</span>目的端口:</td>
        <td class="tdbody"><input type="text" name="inputtext2"  class="inputtext"/>
(1-65535) （输入形如:1200或2000：3000）</td>
      </tr>
      <tr>
        <td class="tdheader">服务类型:</td>
        <td class="tdbody"><label>
          <select name="select3" class="w200" id="select5">
          </select>
        </label></td>
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
      <td class="tdheader">开启日志：</td>
      <td class="tdbody"><input name="radio1" type="radio" id="radio3" value="radio" checked="checked" />
        是
          <label></label>
        <input type="radio" name="radio1" id="radio4" value="radio" />
        <label></label>
        否
        <label></label></td>
    </tr>
    <tr>
      <td class="tdheader">抗攻击:</td>
      <td class="tdbody">
      	<div><input name="" type="checkbox" value="" />抗SYN Flood<input name="" type="text" />个/秒</div>
        <div><input name="" type="checkbox" value="" />抗UDP Flood<input name="" type="text" />个/秒</div>
        <div><input name="" type="checkbox" value="" />抗ICMP Flood<input name="" type="text" />个/秒</div>
        <div><input name="" type="checkbox" value="" />抗Ping of Death</div>
      
      </td>
    </tr>
    <tr>
      <td class="tdheader">认证用户组:</td>
      <td class="tdbody"><label>
        <select name="select4" class="w200" id="select4">
        </select>
      </label></td>
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