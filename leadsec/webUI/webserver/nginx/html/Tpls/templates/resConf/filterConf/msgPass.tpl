<div id="stepTabDiv" class="stepTabDivImg3_1">
	<ul>
    	<li><a href="#" onclick='showStepPageByAjax("client/msgTrans/callowedFile.php");changeTabClass(1)'>文件名控制</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/msgTrans/cbannedContent.php");changeTabClass(2)'>内容黑名单</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/msgTrans/callowedContent.php");changeTabClass(3)'>内容白名单</a></li>      
    </ul>
</div>
<div id="stepDivContent">
  
</div>
<script type="text/javascript">
$(document).ready(function() {
	showStepPageByAjax("client/msgTrans/callowedFile.php");
});

function changeTabClass(num){
	$("#stepTabDiv").removeClass().addClass("stepTabDivImg3_"+num);
}
</script>
