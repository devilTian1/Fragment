<{include file='layout/search.tpl' tableId='tcpGeneralVisitTable'}>
<table class="column_95 textMid tablesorter" id="tcpGeneralVisitTable">
    <caption>信息列表</caption>
    <thead>
        <tr>
            <th class="column_10" name="id">任务号</th>
            <th class="column_10" name="sa">源地址</th>
            <th class="column_10" name="lip">本机地址</th>
            <th class="column_10" name="lport">本机端口</th>
            <th class="column_10" name="time">生效时段</th>
            <th class="column_10" name="active">是否启动</th>
            <th class="column_20" name="comment">备注</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="8">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewTcpCommClientAclDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/customized/tcpGeneralVisit.php'}>
</div>
<script type="text/javascript" src="Public/js/client/customized/tcpGeneralVisit.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/customized/tcpGeneralVisit.php',
            $('#tcpGeneralVisitTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#tcpGeneralVisitTable'), {7: {sorter: false}}, [[0,0]]);
    });
</script>
