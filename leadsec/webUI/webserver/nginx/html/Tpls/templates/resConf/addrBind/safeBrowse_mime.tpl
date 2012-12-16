<{include file='layout/search.tpl' tableId='safeBrowse_mimeTable'}>
<table class="column_95 textMid tablesorter" id="safeBrowse_mimeTable">
    <caption>
        MIME过滤
    </caption>
    <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_20">名称</th>
      <th class="column_10">应用程序类</th>
      <th class="column_10">视频类</th>
      <th class="column_10">音频类</th>
      <th class="column_10">图像类</th>
      <th class="column_10">文本类</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
     <tr>
      <td colspan="8">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/safeBrowse_mime.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/safeBrowse_mime.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/safeBrowse_mime.php', $('#safeBrowse_mimeTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#safeBrowse_mimeTable'), {7: {sorter: false}}, [[0,0]]);
    });
</script>