<div id="stepTabDiv" class="stepTabDivImg4_1">
	<ul>
    	<li><a href="#" onclick='showStepPageByAjax("client/mail/mailAddr.php");changeTabClass(1)'>邮件地此</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/mail/keyword.php");changeTabClass(2)'>内容关键字</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/mail/attachExt.php");changeTabClass(3)'>附件扩展名</a></li>
        <li><a href="#" onclick='showStepPageByAjax("client/mail/filter.php");changeTabClass(4)'>过滤选项集</a></li>
    </ul>
</div>
<div id="stepDivContent">
  
</div>
<script type="text/javascript">
$(document).ready(function() {
	showStepPageByAjax("client/mail/mailAddr.php");
});

function changeTabClass(num){
	$("#stepTabDiv").removeClass().addClass("stepTabDivImg4_"+num);
}
</script>
