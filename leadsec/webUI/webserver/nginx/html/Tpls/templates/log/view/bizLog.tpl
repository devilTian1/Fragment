<form action="Function/log/view/bizLog.php?search=1" method="POST"
    id="logSearchParamsForm" onSubmit="return false">
    <fieldset class="searchFieldset">
        <legend>查询条件</legend>
        <div class="hide" id="summary">
        </div>
        <div class="row">
            <label class="logLabel" for="pri">级别:</label>
            <{html_options name="pri" id="pri" class="select"
                output=array('所有', '紧急', '警报', '临界', '出错', '预警', '提示', '通知', '调试')
                values=array('all', '0', '1', '2', '3', '4', '5', '6', '7')}>

            <label class="logLabel" for="logType">日志类型:</label>
            <{html_options name="logType" id="logType" class="select"
                output=$logTypeArr values=$logTypeVal}>

            <label class="s_time" for="startTime_log">时间:  从</label>
            <input name="startTime_log" id="startTime_log" value=""/>
            <label class="e_time" for="endTime_log">至</label>
            <input name="endTime_log" id="endTime_log" style="position: relative;left:4px;" value=""/>

            <button type="button" class="standard" onclick="search()" id="searchBtn" 
            	style="position: relative;left:20px;">
                查询
            </button>

            <a class="advSearch floatRight" href="#" onClick="showAdvSearchDiv()" 
            	id="advSearchLink" >高级搜索</a>
        </div>
        <br class="clearFloat"/>
        <div class="hide row" id="advSearchDiv">
            <hr/>
            <a class="fold floatRight" href="#" onClick="hideAdvSearchDiv()" id="foldLink"> 收 起 </a>
            <div class="row">
                <label class="logLabel" for="sAddr">源地址:</label>
                <input name="sAddr" id="sAddr" value=""/>
                <label class="logLabel" for="dAddr">目的地址:</label>
                <input name="dAddr" id="dAddr" value=""/>
                <label class="logLabel" for="keyword">关键字:</label>
                <input name="keyword" id="keyword" value=""/>
                <br class="clearFloat"/>
            </div>
            <div class="row">
                <label class="logLabel" for="sport">源端口:</label>
                <input name="sport" id="sport" value=""/>
                <label class="logLabel" for="dport">目的端口:</label>
                <input name="dport" id="dport" value=""/>
                <br class="clearFloat"/>
            </div>
        </div>
    </fieldset>
</form>

<table class="column_95 textMid tablesorter" id="logTable">
    <caption>业务日志列表</caption>
    <thead>
        <tr>
            <th class="column_20" name="time">时间</th>
            <th class="column_10" name="pri">级别</th>
            <th class="column_10">模块</th>
            <th class="column_60">事件</th>
        </tr>
        <tbody>
            <tr>
                <td colspan='4'>Loading ... ...</td>
            </tr>
        </tbody>
</table>
<!--  
<form class="inline" action="Function/log/view/bizLog.php" method="POST">
	<input type="hidden" name="action" value="exportFwlog"/>
	<button class="inputbtn standard" type="submit">
		导出</button>
</form>-->
<form class="inline" action="Function/log/view/bizLog.php" method="POST"
    id="cleanLogForm">
	<input type="hidden" name="action" value="cleanFwlog"/>
    <button class="inputbtn standard" type="button" onclick="cleanLog()">
        清空全部日志信息</button>
</form>

<div class="pager floatRight">
    <{include file='log/view/pagination.tpl' func='Function/log/view/bizLog.php'}>
</div>
<script type="text/javascript" src="Public/js/log/view/bizLog.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        freshLogTable('Function/log/view/bizLog.php', $('#logTable'),
            'ORDER BY time DESC LIMIT 10 OFFSET 0');
        sortTableInit($('#logTable'), {2: {sorter: false}, 3: {sorter: false}},
            [[0,1]]);
        validateForm($("#logSearchParamsForm"), 'summary');
    });
</script>
