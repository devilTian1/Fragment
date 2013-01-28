<div id="stepTabDiv" class="stepTabDivImg4_1">
	<ul>
    	<li><a href="#" onclick='showStepPageByAjax("client/safeBrowse/usrAuthen.php");changeTabClass(1)'>用户认证方式</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/safeBrowse/localUsrManage.php");changeTabClass(2)'>本地用户管理</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/safeBrowse/filterGl.php");changeTabClass(3)'>过滤配置</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/safeBrowse/urlFilter.php");changeTabClass(4)'>URL过滤</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/safeBrowse/postfixFilter.php");changeTabClass(5)'>文件名过滤</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/safeBrowse/keywordFilter.php");changeTabClass(6)'>关键字过滤</a></li>
    </ul>
</div>
<div id="stepDivContent">
 
</div>
<script type="text/javascript">
$(document).ready(function() {
	showStepPageByAjax("client/safeBrowse/usrAuthen.php");
});
function changeTabClass(num){
	$("#stepTabDiv").removeClass().addClass("stepTabDivImg4_"+num);
}
</script>