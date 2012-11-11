<div id="stepTabDiv" class="stepTabDivImg3_1">
	<ul>
    	<li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/dataVisit.php","user");changeTabClass(1)'>用户过滤</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/dataVisit.php","sql");changeTabClass(2)'>SQL语句过滤</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/addrBind/dataVisit.php","options");changeTabClass(3)'>过滤选项集</a></li>
    </ul>
</div>
<div id="stepDivContent">
  
</div>
<script type="text/javascript">
$(document).ready(function() {
	showStepPageByAjax("resConf/addrBind/dataVisit.php","user");
});

function changeTabClass(num){
	$("#stepTabDiv").removeClass().addClass("stepTabDivImg3_"+num);
}
</script>
<script type="text/javascript" src="Public/js/resConf/addrBind/dataVisit.js"></script>