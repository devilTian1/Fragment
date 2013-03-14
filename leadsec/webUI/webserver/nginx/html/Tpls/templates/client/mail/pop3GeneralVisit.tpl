<{include file='layout/search.tpl' tableId='pop3GeneralVisitTable'}>
<table class="column_95 textMid tablesorter" id="pop3GeneralVisitTable">
    <caption>信息列表</caption>
    <thead>
    <tr>
        <th class="column_10" name="id">任务号</th>
        <th class="column_10" name="sa">源地址</th>
        <th class="column_15" name="lip">本机地址</th>
        <th class="column_10" name="lport">本机端口</th>
        <th class="column_10" name="filter">过滤选项</th>
        <th class="column_10" name="time">生效时间</th>
        <th class="column_10" name="active">是否启动</th>
        <th class="column_10" name="comment">内容</th>
        <th class="column_15">操作</th>
    </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="9">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewPop3CommClientAclDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/mail/pop3GeneralVisit.php'}>
</div>
<script type="text/javascript" src="Public/js/client/mail/pop3GeneralVisit.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/mail/pop3GeneralVisit.php', $('#pop3GeneralVisitTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#pop3GeneralVisitTable'), {8: {sorter: false}}, [[0,0]]);
    });
</script>
