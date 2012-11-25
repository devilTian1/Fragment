<style type="text/css">
	#filter label{ display:block; width:120px; float:left; cursor:pointer; height:32px;}
</style>
<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
      <td class="tdheader" width="100"><span class="red">*</span> 任务号:</td>
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
        <td class="tdheader">本机端口:</td>
        <td class="tdbody"><input type="text" name="inputtext2"  class="inputtext"/></td>
      </tr>
      <tr>
        <td class="tdheader">
        	过滤选项:
            <input type="button" value="添加过滤选项" class="inputbtn" />
        </td>
        <td class="tdbody">
        	<div id="filter">
            	<label><input name="filter" type="radio" value="" checked="checked"/>无</label>
                <label title="过滤选项1" rel="ajax2.html"><input name="filter" type="radio" value="1" />过滤选项1</label>
                <label title="过滤选项2" rel="ajax2.html"><input name="filter" type="radio" value="2" />过滤选项2</label>
                <label title="过滤选项3" rel="ajax2.html"><input name="filter" type="radio" value="3" />过滤选项3</label>
                <label title="过滤选项4" rel="ajax2.html"><input name="filter" type="radio" value="4" />过滤选项4</label>
                <label title="过滤选项5" rel="ajax2.html"><input name="filter" type="radio" value="5" />过滤选项5</label>
                <label title="过滤选项6" rel="ajax2.html"><input name="filter" type="radio" value="6" />过滤选项6</label>
                <label title="过滤选项7" rel="ajax2.html"><input name="filter" type="radio" value="7" />过滤选项7</label>
            </div>
            <a class="title" href="#" title="过滤选项说明|过滤选项是系统配置，过滤配置中根据不同的选项而设定的.">说明</a> 
        </td>
      </tr>
      <tr>
        <td class="tdheader"><span class="red">*</span>是否启动:</td>
        <td class="tdbody"><input name="radio2" type="radio" id="radio5" value="radio" checked="checked" />
          启动
          <input type="radio" name="radio2" id="radio6" value="radio" />
          停止</td>
      </tr>
      <tr>
        <td class="tdheader">认证用户组:</td>
        <td class="tdbody"><label>
          <select name="select4" class="w200" id="select5">
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
      <td class="tdheader"><span class="red"></span>备注:</td>
      <td class="tdbody">
        <input type="text" name="inputtext"  class="inputtext"/>
       </td>
    </tr>
    </tbody>
  </table>
</form>
<link rel="stylesheet" href="Public/js/clueTip/jquery.cluetip.css" type="text/css" />
<script type="text/javascript" src="Public/js/clueTip/jquery.hoverIntent.js"></script>
<script type="text/javascript" src="Public/js/clueTip/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="Public/js/clueTip/jquery.cluetip.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('a.title').cluetip({splitTitle: '|'});
	$('.inputbtn').button();
	$("#filter label").cluetip({titleAttribute:'title'});
	$("#filter label").mouseover(function(){
				var val=$(this).children('input').val();
				//	$(this).cluetip({titleAttribute:'title'});
												 })
	$("#filter label").mouseout(function(){
					//var val=$(this).children('input').val();
					
												 })
});
</script>