<style type="text/css">
	#filter label{ display:block; width:120px; float:left; cursor:pointer; height:32px;}
	.floatLeft input[type="radio"]{ width:10px;}
</style>
<form action="Function/client/safeBrowse/transVisit.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
         <div class="row">
          <label for="destip">任务号:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(同一端的任务号必须唯一)
        </div>
        
        <div class="row">
          <label for="destip">源地此:</label>
          <select name="select" class="w200" id="select">
          </select>
        </div>
        
        <div class="row">
          <label for="destip">目的地此:</label>
          <select name="select" class="w200" id="select">
          </select>
        </div>
        
         <div class="row">
          <label for="destip">目的端口:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-65535)(输入形如:1200或2000：3000)
        </div>
        
          <hr class="clearFloat"/>
        
        <div class="row">
            <label>过滤选项:</label><br/>
            <div id="filter">
              	<div class="floatLeft"><label><input name="filter" type="radio" value="" checked="checked"/>无</label></div>
                <div class="floatLeft"><label title="过滤选项1" rel="test.php"><input name="filter" type="radio" value="1" />过滤选项1</label></div>
                <div class="floatLeft"><label title="过滤选项1" rel="test.php"><input name="filter" type="radio" value="1" />过滤选项1</label></div>
                <div class="floatLeft"><label title="过滤选项1" rel="test.php"><input name="filter" type="radio" value="1" />过滤选项1</label></div>
                <div class="floatLeft"><label title="过滤选项1" rel="test.php"><input name="filter" type="radio" value="1" />过滤选项1</label></div>
                <div class="floatLeft"><label title="过滤选项1" rel="test.php"><input name="filter" type="radio" value="1" />过滤选项1</label></div>
              </div>
        </div>
		<hr class="clearFloat"/>
        
        <div class="row">
            <label>是否启动:</label>
            <div class="floatLeft">
               <input name="radio" type="radio" id="radio" value="radio" checked="checked" />启动
            </div>
            <div class="floatLeft">
                <input type="radio" name="radio" id="radio2" value="radio" />停止
            </div>
        </div>
        
        <div class="row">
          <label for="destip">认证用户组:</label>
          <select name="select" class="w200" id="select">
          </select>
        </div>
        
        <div class="row">
          <label for="destip">生效时段:</label>
          <select name="select" class="w200" id="select">
          </select>
        </div>
        
        <div class="row">
          <label for="destip">备注:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />
        </div>
    </fieldset>
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