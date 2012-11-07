    <input type="hidden" id="dataCount" value="<{$dataCount}>"/>
    <label class="floatLeft">每页显示
    <{html_options class="pagesize" name=rowsCount
        output=array(10,20,50,100,'全部') values=array(10,20,50,100,all)
        selected=<{$rowsCount|default: 10}> onChange="modifyRowsCount()" id="rowsCount"}>
    行&nbsp;&nbsp;&nbsp;
    </label>
    <ol class="pagination floatLeft">
        <li><a href="#" rel="first" onClick="freshTableByPageNo('1')">首页</a></li>
        <li><a href="#" onClick="freshTableByPageNo('<{$prev}>')" rel="prev">上一页</a></li>
        <{for $pageNo=1 to $pageCount }>
            <{if $clickedPageNo == $pageNo}>
                <li class="selected"><{$pageNo}></li>
            <{else}>
                <li><a href="#" onClick="freshTableByPageNo('<{$pageNo}>')"><{$pageNo}></a></li>
            <{/if}>
        <{forelse}>
            <li class="selected">1</li>
        <{/for}>
        <li><a href="#" onClick="freshTableByPageNo('<{$next}>')" rel="next">下一页</a></li>
        <li><a href="#" rel="last" onClick="freshTableByPageNo('<{$pageCount}>')">尾页</a></li>
    </ol>
