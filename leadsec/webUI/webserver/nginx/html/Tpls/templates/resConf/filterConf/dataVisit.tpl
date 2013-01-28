<div id="stepTabDiv" class="stepTabDivImg3_1">
	<ul>
    	<li><a href="#" onclick='showStepPageByAjax("resConf/filterConf/dataVisit_user.php");changeTabClass(1)'>用户过滤</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/filterConf/dataVisit_sql.php");changeTabClass(2)'>SQL语句过滤</a></li>
        <li><a href="#" onclick='showStepPageByAjax("resConf/filterConf/dataVisit_options.php");changeTabClass(3)'>过滤选项集</a></li>
    </ul>
</div>
<div id="stepDivContent">
  
</div>
<script type="text/javascript">
$(document).ready(function() {
	showStepPageByAjax("resConf/filterConf/dataVisit_user.php","user");
});

function changeTabClass(num){
	$("#stepTabDiv").removeClass().addClass("stepTabDivImg3_"+num);
}
</script>