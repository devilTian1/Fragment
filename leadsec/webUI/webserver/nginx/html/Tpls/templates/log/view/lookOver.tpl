<form action="Function/log/view/lookOver.php" method="POST" id="logSearchParamsForm" 
    onSubmit="return false">
    <fieldset class="searchFieldset">
        <legend>查询条件</legend>
        <div class="hide" id="summary">
        </div>
        <div class="row">
            <label class="logLabel" for="type">级别:</label>
            <{html_options name="type" id="type" class="select"
                output=array('所有', '紧急', '警报', '临界', '出错', '预警', '提示', '通知', '调试')
                values=array('all', 'emergency' , 'critical', 'error', 'warning', 'notice', 'information', 'debug')}>

            <label class="logLabel" for="model">模块:</label>
            <{html_options name="model" id="model" class="select"
                output=$modelArr values=$modelArr}>

            <label class="s_time" for="startTime_log">时间:  从</label>
            <input name="startTime_log" id="startTime_log" value=""/>
            <label class="e_time" for="endTime_log">至</label>
            <input name="endTime_log" id="endTime_log" value=""/>

            <button type="button" class="standard floatLeft" onclick="search()" id="searchBtn">
                查询
            </button>

            <a class="advSearch floatRight" href="#" onClick="showAdvSearchDiv()" id="advSearchLink">高级搜索</a>
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
                <br class="clearFloat"/>
            </div>
            <div class="row">
                <label class="logLabel" for="sport">源端口:</label>
                <input name="sport" id="sport" value=""/>
                <label class="logLabel" for="dport">目的端口:</label>
                <input name="dport" id="dport" value=""/>
                <br class="clearFloat"/>
            </div>
            <div class="row">
                <label class="userTraceLabel checkboxLabel" for="userTrace">用户操作跟踪:</label>
                <input class="checkbox" type="checkbox" name="userTrace" id="userTrace"/>
                <br class="clearFloat"/>
            </div>
        </div>
    </fieldset>
</form>

<table class="column_95 textMid tablesorter">
    <caption>版本日志信息</caption>
    <thead>
        <tr>
            <th class="column_10">生效</th>
            <th class="column_15">文件名</th>
            <th class="column_55">详细信息</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <{foreach $result_list as $k => $val}>
        <tr>
            <td><{$val.id}></td>
            <td><{$val.up_version}></td>
            <td><{$val.del_bugs}></td>
            <td><{$val.up_time}></td>
        </tr>
    <{foreachelse}>
        <tr><td colspan='4'>No Upgrade History Data</td></tr>
    <{/foreach}>
    <tr>
        <td colspan="4">
            <form class="inline" action="Function/systemManagement/maintain/upgrade.php" method="POST">
                <input type="hidden" name="action" value="exportUpgradeHistory"/>
                <button class="inputbtn standard" type="submit">
                    asd
                </button>
            </form>
        </td>
    </tr>
</table>
<script type="text/javascript" src="Public/js/log/view/lookOver.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        renderStandardUi();
        validateForm($("#logSearchParamsForm"), 'summary');
    });
</script>
