<div id="stepTabDiv" class="stepTabDivImg4_1">
	<ul>
    	<li><a href="#" onclick='showStepPageByAjax("client/fileEx/allowedFile.php");changeTabClass(1)'>文件名控制</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/fileEx/bannedContent.php");changeTabClass(2)'>内容黑名单</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/fileEx/allowedContent.php");changeTabClass(3)'>内容白名单</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/fileEx/filter.php");changeTabClass(4)'>文件属性控制</a></li>
    </ul>
</div>
<div id="stepDivContent">
  
</div>
<script type="text/javascript">
$(document).ready(function() {
	showStepPageByAjax("client/fileEx/allowedFile.php");
});

function changeTabClass(num){
	$("#stepTabDiv").removeClass().addClass("stepTabDivImg4_"+num);
}
</script>
