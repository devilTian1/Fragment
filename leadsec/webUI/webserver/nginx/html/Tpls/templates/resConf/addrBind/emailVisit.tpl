<div id="stepTabDiv" class="stepTabDivImg4_1">
	<ul>
    	<li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/emailVisit.php","addr");changeTabClass(1)'>邮件地此</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/emailVisit.php","content");changeTabClass(2)'>内容关键字</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/emailVisit.php","affix");changeTabClass(3)'>附件扩展名</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/emailVisit.php","options");changeTabClass(4)'>过滤选项集</a></li>
    </ul>
</div>
<div id="stepDivContent">
  
</div>
<script type="text/javascript">
$(document).ready(function() {
	showStepPageByAjax("resConf/addrBind/emailVisit.php","addr");
});

function changeTabClass(num){
	$("#stepTabDiv").removeClass().addClass("stepTabDivImg4_"+num);
}
</script>
<script type="text/javascript" src="Public/js/resConf/addrBind/emailVisit.js"></script>