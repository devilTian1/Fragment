<table class="column_95">
    <tbody>
    <tr>
      <td colspan="7">
      自动域名解析服务:
        <input type="button" name="button" id="button" value="启动" class="inputbtn" />&nbsp;
      </td>
      </tr>
    </tbody>
</table>
  
<{include file='layout/search.tpl' tableId='realmAddrTable'}>
<table class="column_95 textMid tablesorter" id="realmAddrTable">
    <caption>
  	    域名地址
    </caption> 
    <thead>
        <tr>
            <th class="column_10" name="id">序号</th>
            <th class="column_10" name="name">名称</th>
            <th class="column_10" name="domain">域名</th>
            <th class="column_15">DNS服务器</th>
            <th class="column_20">静态IP列表</th>
            <th class="column_20">动态IP列表</th>
            <th class="column_15">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan='7'>Loading ... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openAddRealmAddrDialog()"
    id="addRealmAddr">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl' func='Function/resConf/addr/realmAddr.php'}>
</div>
<script type="text/javascript" src="Public/js/resConf/addr/realmAddr.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        appendRealmAddrData();
        sortTableInit($('#realmAddrTable'),
            {3: {sorter: false},4: {sorter: false},5: {sorter: false},6: {sorter: false}});
    });
</script>
