<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
    <tr>
      <td class="tdheader"><span class="red">*</span>名称:</td>
      <td class="tdbody">
        <input type="text" name="inputtext2" class="inputtext"/>
        &nbsp;( 1-19合法字符，9个中文汉字)</td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red">*</span>  URL过滤列表:</td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
        &nbsp;(1-1024个字符）</td>
    </tr>
    <tr>
      <td class="tdheader"></td>
      <td class="tdbody"><div>说明：</div>
        <p>1）域名前加.表示该域名以及其子域名，否则表示其本身</p>
        <p>2）多个域名之间用 ; 隔开</p>
        <p>3）支持通配符*以及？;</p>
         <p>4）支持自己定义域名，可分为三部分：首/中/尾,之间可以用通配符代替，如http://*.sina.*.com;</p>
        </td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>备注：</td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
        &nbsp;( 0-253字符. )</td>
    </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript">
$(document).ready(function() {
						   
});
</script>