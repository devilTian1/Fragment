<table class="column_95">
    <tr>
      <td class="tdbody" width="150">
      <label>
        <input type="checkbox" name="checkbox" id="checkbox" />启动文件名控制
      </label>
      </td>
      <td class="tdbody">
      <label>
        <input type="checkbox" name="checkbox2" id="checkbox2" />允许二进制文件
      </label>
      </td>
    </tr>
</table>
<{include file='layout/search.tpl' tableId='msgPass_filenameTable'}>
<table class="column_95 textMid tablesorter" id="msgPass_filenameTable">
    <caption>
      文件名控制
   </caption>
   <thead>
    <tr>
      <th class="column_10">序号</th>
      <th class="column_70">允许以下扩展名</th>
      <th class="column_20">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td colspan="3">Loading……</td>
    </tr>
    </tbody>
  </table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addrBind/msgPass_filename.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addrBind/msgPass_filename.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/resConf/addrBind/msgPass_filename.php', $('#msgPass_filenameTable'), 'ORDER BY id ASC LIMIT 10');
        sortTableInit($('#msgPass_filenameTable'), {2: {sorter: false}}, [[0,0]]);
    });
</script>