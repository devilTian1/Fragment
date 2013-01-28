<{include file='layout/search.tpl' tableId='smtpTransVisitTable'}>
<table class="column_95 textMid tablesorter" id="smtpTransVisitTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">任务号</th>
            <th class="column_10" name="sa">源地址</th>
            <th class="column_10" name="da">目的地址</th>
            <th class="column_10" name="dport">目的端口</th>
            <th class="column_10" name="filter">过滤选项</th>
            <th class="column_10" name="time">生效时间</th>
            <th class="column_10" name="active">是否启动</th>
            <th class="column_10" name="comment">备注</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="9">Loading... ...</td>
        </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewSmtpTransClientAclDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/mail/smtpTransVisit.php'}>
</div>
<script type="text/javascript" src="Public/js/client/mail/smtpTransVisit.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/mail/smtpTransVisit.php', $('#smtpTransVisitTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#smtpTransVisitTable'), {8: {sorter: false}}, [[0,0]]);
    });
</script>