    <input type="hidden" name="dataCount" value="<{$initData.dataCount}>"/>
    <label class="floatLeft">每页显示
    <{html_options class="pagesize" name=rowsCount
        output=array(10,20,50,100,'全部') values=array(10,20,50,100,all)
        selected=<{$rowsCount|default: 10}>
        onChange="freshTableAndPage(<{$tableDom|default: '$(".tablesorter")'}>, <{$pageDom|default: '$(".pager")'}>)"
        id="rowsCount"}>
    行&nbsp;&nbsp;&nbsp;
    </label>
    <ol class="pagination floatLeft">
        <li><a href="#page=1" rel="first">首页</a></li>
        <li><a href="#page=<{$initData.prev}>" rel="prev">上一页</a></li>
        <{for $pageNo=1 to $initData.pageCount }>
            <{assign var='a' value="`$initData.clickedPageNo-$pageNo`"}>
            <{assign var='b' value="`$pageNo-$initData.clickedPageNo`"}>
            <{if ($pageNo != 1 && $pageNo != $initData.pageCount) && ($a > 3 || $b > 2)}>
                <{continue}>
            <{/if}>
            <{if $initData.clickedPageNo == $pageNo or $initData.clickedPageNo > $initData.pageCount}>
                <li name="<{$pageNo}>" class="selected"><{$pageNo}></li>
            <{else}>
                <{if $a > 2 && $pageNo === 1}>
                    <li name="<{$pageNo}>"><a href="#page=<{$pageNo}>"><{$pageNo}> ...</a></li>
                    <{continue}>
                <{/if}>
                <{if $b > 2 && $pageNo == $initData.pageCount}>
                    <li name="<{$pageNo}>"><a href="#page=<{$pageNo}>">... <{$pageNo}></a></li><{continue}>
                <{/if}>
                <li name="<{$pageNo}>"><a href="#page=<{$pageNo}>"><{$pageNo}></a></li>
            <{/if}>
        <{forelse}>
            <li class="selected" name="1">1</li>
        <{/for}>
        <li><a href="#page=<{$initData.next}>" rel="next">下一页</a></li>
        <li><a href="#page=<{$initData.pageCount}>" rel="last">尾页</a></li>
    </ol>
<script type="text/javascript">
    $(document).ready(function() {
        /*<{if $pageDom}>
            var li = <{$pageDom}>.find('ol.pagination>li');
        <{else}>
            var li = $('ol.pagination>li');
        <{/if}>*/
		 var li = $('ol.pagination>li');
        li.click(function() {
            // remove class 'selected'
            var liSelected = li.filter('.selected');
            var liSelectedText = liSelected.text();
            var prevDom  = li.eq(1);
            var nextDom  = li.last().prev();

            var rel = $(this).children('a').attr('rel');
            liSelected.removeClass('selected');
            liSelected.html('<a href="#page=' + liSelectedText +
                '">' + liSelectedText + '</a>');
            if (rel === 'first') {
                var firstPageDom = li.eq(2);
                firstPageDom.addClass('selected').html(firstPageDom.text());
            } else if (rel === 'prev') {
				var prevPageDom = liSelected.prev();
				if(liSelected.text()==1){
					prevPageDom=liSelected;
				}
                prevPageDom.addClass('selected').html(prevPageDom.text());
            } else if (rel === 'next') {
                var nextPageDom = liSelected.next();
				if(liSelected.text()>=<{$initData.pageCount}>){
					nextPageDom=liSelected;
				}
                nextPageDom.addClass('selected').html(nextPageDom.text());
            } else if (rel === 'last') {
                var lastPageDom = li.last().prev().prev();
                lastPageDom.addClass('selected').html(lastPageDom.text());
            } else {
                $(this).addClass('selected').html($(this).text());
            }
            freshTable('<{$func}>', <{$tableDom|default: "$('.tablesorter')"}>,
                '', <{$pageDom|default: "$('.pager')"}>);
            freshPagination('<{$func}>', <{$pageDom|default: "$('.pager')"}>, <{$tableDom|default: "$('.tablesorter')"}>);
        });
    });
</script>
