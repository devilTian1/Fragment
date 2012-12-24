<div id="stepTabDiv" class="stepTabDivImg4_1">
	<ul>
    	<li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/safeBrowse_url.php");changeTabClass(1)'>URL过滤</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/safeBrowse_mime.php");changeTabClass(2)'>MIME类型过滤</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/safeBrowse_extend.php");changeTabClass(3)'>文件扩展名过滤</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/safeBrowse_options.php");changeTabClass(4)'>过滤选项集</a></li>
    </ul>
</div>
<div id="stepDivContent">
 
</div>
<script type="text/javascript">
$(document).ready(function() {
	showStepPageByAjax("resConf/addrBind/safeBrowse_url.php");
});
function changeTabClass(num){
	$("#stepTabDiv").removeClass().addClass("stepTabDivImg4_"+num);
}
</script>