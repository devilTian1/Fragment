<div id="stepTabDiv" class="stepTabDivImg4_1">
	<ul>
    	<li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/emailVisit_addr.php");changeTabClass(1)'>邮件地此</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/emailVisit_content.php");changeTabClass(2)'>内容关键字</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/emailVisit_affix.php");changeTabClass(3)'>附件扩展名</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/emailVisit_options.php");changeTabClass(4)'>过滤选项集</a></li>
    </ul>
</div>
<div id="stepDivContent">
  
</div>
<script type="text/javascript">
$(document).ready(function() {
	showStepPageByAjax("resConf/addrBind/emailVisit_addr.php","addr");
});

function changeTabClass(num){
	$("#stepTabDiv").removeClass().addClass("stepTabDivImg4_"+num);
}
</script>