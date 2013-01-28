<{include file='layout/search.tpl' tableId='filterTable'}>
<table class="column_95 textMid tablesorter" id="filterTable">
    <caption>
           信息列表
    </caption>
    <thead>
    <tr>
        <th class="column_5" name="id">序号</th>
        <th class="column_10" name="name">名称</th>
        <th class="column_5" name="protocol">协议</th>
        <th class="column_10" name="attachmaxsize">允许最大附件(M)</th>
        <th class="column_10" name="allowext">允许扩展名</th>
        <th class="column_10" name="allowsender">发件人</th>
        <th class="column_10" name="allowrecv">收件人</th>
        <th class="column_10" name="skeyword">主题关键字</th>
        <th class="column_10" name="ckeyword">正文关键字</th>
        <th class="column_10" name="fileav">文件病毒扫描</th>
        <th class="column_10">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td colspan="11">Loading... ...</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewFilterDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/client/mail/filter.php'}>
</div>
<script type="text/javascript" src="Public/js/client/mail/filter.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/mail/filter.php', $('#filterTable'), 'ORDER BY name ASC LIMIT 10');
        sortTableInit($('#filterTable'), {10: {sorter: false}}, [[1,0]]);
    });
</script>
