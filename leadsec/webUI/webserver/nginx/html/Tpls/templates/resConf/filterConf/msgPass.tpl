<div id="stepTabDiv" class="stepTabDivImg3_1">
	<ul>
    	<li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/msgPass_filename.php");changeTabClass(1)'>文件名控制</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/msgPass_blacklist.php");changeTabClass(2)'>内容黑名单</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/msgPass_whitelist.php");changeTabClass(3)'>内容白名单</a></li>
    </ul>
</div>
<div id="stepDivContent">
  
</div>
<script type="text/javascript">
$(document).ready(function() {
	showStepPageByAjax("resConf/addrBind/msgPass_filename.php");
});

function changeTabClass(num){
	$("#stepTabDiv").removeClass().addClass("stepTabDivImg3_"+num);
}
</script>