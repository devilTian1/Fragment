<div id="stepTabDiv" class="stepTabDivImg4_1">
	<ul>
    	<li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/fileExchange_filename.php");changeTabClass(1)'>文件名控制</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/fileExchange_blacklist.php");changeTabClass(2)'>内容黑名单</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/fileExchange_whitelist.php");changeTabClass(3)'>内容白名单</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/fileExchange_options.php");changeTabClass(4)'>文件属性控制</a></li>
    </ul>
</div>
<div id="stepDivContent">
  
</div>
<script type="text/javascript">
$(document).ready(function() {
	showStepPageByAjax("resConf/addrBind/fileExchange_filename.php");
});

function changeTabClass(num){
	$("#stepTabDiv").removeClass().addClass("stepTabDivImg4_"+num);
}
</script>