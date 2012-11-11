<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
      <td class="tdheader"><span class="red">*</span> 名称:</td>
      <td class="tdbody">
        <input type="text" name="inputtext3" class="inputtext"/>
        &nbsp;( 1-15 字母、数字、减号、下划线、点的组合 )</td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>协议类型:</td>
      <td class="tdbody">
        <input name="radio" type="radio" id="radio" value="radio" checked="checked" />
        smtp
        <input type="radio" name="radio" id="radio2" value="radio" />
        pop3
      </td>
    </tr>
    <tr>
      <td class="tdheader">允许最大附件:</td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
        &nbsp;( 单位M,默认为100M)</td>
    </tr>
    <tr>
      <td class="tdheader">允许的扩展名组:</td>
      <td class="tdbody">
        <label>
          <select name="select2" class="w200" id="select2">
          </select>
        </label>
        （附件扩展名组名称）</td>
    </tr>
    <tr>
      <td class="tdheader">发件人地此组:</td>
      <td class="tdbody">
        <label>
          <select name="select2" class="w200" id="select2">
            </select>
        </label>
      （来源邮件地此组名称）</td>
    </tr>
    <tr>
      <td class="tdheader">发件人过滤类别:</td>
      <td class="tdbody">
        <input name="radio1" type="radio" id="radio3" value="radio" checked="checked" />
        黑名单
        <input type="radio" name="radio1" id="radio4" value="radio" />
        白名单
      </td>
    </tr>
    <tr>
      <td class="tdheader">收件人地此组:</td>
      <td class="tdbody">
        <label>
          <select name="select2" class="w200" id="select2">
          </select>
        </label>
        （来源邮件地此组名称）</td>
    </tr>
    <tr>
      <td class="tdheader">收件人过滤类别: </td>
      <td class="tdbody">
        <input name="radio2" type="radio" id="radio5" value="radio" checked="checked" />
        黑名单
        <input type="radio" name="radio2" id="radio6" value="radio" />
        白名单 </td>
    </tr>
    <tr>
      <td class="tdheader">主题关键字黑名单:</td>
      <td class="tdbody">
        <label>
          <select name="select2" class="w200" id="select2">
          </select>
        </label>
        （来源于内容关键字名称）</td>
    </tr>
    <tr>
      <td class="tdheader">正文关键字黑名单:</td>
      <td class="tdbody">
        <label>
          <select name="select2" class="w200" id="select2">
          </select>
        </label>
        （来源于内容关键字名称）</td>
    </tr>
    <tr>
      <td class="tdheader">病毒扫描: </td>
      <td class="tdbody">
        <input name="radio3" type="radio" id="radio7" value="radio" checked="checked" />
        黑名单
        <input type="radio" name="radio3" id="radio8" value="radio" />
        白名单 </td>
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