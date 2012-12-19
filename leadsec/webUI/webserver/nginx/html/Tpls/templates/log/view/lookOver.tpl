<form action="Function/systemManagement/maintain/upgrade.php" method="POST" id="upgradeForm" 
    onSubmit="return false">
    <fieldset>
        <legend>查询条件</legend>
        <div class="searchParamRow">
            <label class="logLabel" for="type">级别:</label>
            <{html_options name="type" id="type" class="select"
                output=array('所有', '紧急', '警报', '临界', '出错', '预警', '提示', '通知', '调试')
                values=array('all', 'emergency' , 'critical', 'error', 'warning', 'notice', 'information', 'debug')}>

            <label class="logLabel" for="model">模块:</label>
            <{html_options name="model" id="model" class="select"
                output=$modelArr values=$modelArr}>

            <label class="logLabel" for="startTime">起始时间:</label>
            <input name="startTime" id="startTime" value=""/>
            <label class="logLabel" for="endTime">终止时间:</label>
            <input name="endTime" id="endTime" value=""/>

            <a class="advSearch floatRight" href="#" onClick="showAdvSearchDiv()">高级搜索</a>
        </div>
        <br class="clearFloat"/>
        <div class="hide" id="advSearchDiv">
            <hr/>
            <a class="fold floatRight" href="#" onClick="hideAdvSearchDiv()">^收起^</a>
            <div class="searchParamRow">
                <label class="logLabel" for="saddr">源地址:</label>
                <input name="saddr" id="saddr" value=""/>
                <label class="logLabel" for="daddr">目的地址:</label>
                <input name="daddr" id="daddr" value=""/>
                <br class="clearFloat"/>
            </div>
            <div class="searchParamRow">
                <label class="logLabel" for="sport">源端口:</label>
                <input name="sport" id="sport" value=""/>
                <label class="logLabel" for="dport">目的端口:</label>
                <input name="dport" id="dport" value=""/>
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
<script type="text/javascript">
    function showAdvSearchDiv() {
        $('#advSearchDiv').slideDown('slow');
    }
    function hideAdvSearchDiv() {
        $('#advSearchDiv').slideUp('slow');
    }
    $(document).ready(function() {
    });
</script>
