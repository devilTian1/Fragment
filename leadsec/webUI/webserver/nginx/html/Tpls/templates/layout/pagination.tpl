    <input type="hidden" id="dataCount" value="<{$dataCount}>"/>
    <label class="floatLeft">每页显示
    <{html_options class="pagesize" name=rowsCount
        output=array(10,20,50,100,'全部') values=array(10,20,50,100,all)
        selected=<{$rowsCount|default: 10}> onChange="freshTableAndPage()" id="rowsCount"}>
    行&nbsp;&nbsp;&nbsp;
    </label>
    <ol class="pagination floatLeft">
        <li><a href="#page=1" rel="first">首页</a></li>
        <li><a href="#page=<{$prev}>" rel="prev">上一页</a></li>
        <{for $pageNo=1 to $pageCount }>
            <{if $clickedPageNo == $pageNo}>
                <li class="selected"><{$pageNo}></li>
            <{else}>
                <li><a href="#page=<{$pageNo}>"><{$pageNo}></a></li>
            <{/if}>
        <{forelse}>
            <li class="selected">1</li>
        <{/for}>
        <li><a href="#page=<{$next}>" rel="next">下一页</a></li>
        <li><a href="#page=<{$pageCount}>" rel="last">尾页</a></li>
    </ol>
<script type="text/javascript">
    $(document).ready(function() {
        $('ol.pagination>li').click(function() {
            // remove class 'selected'
            var liSelected = $('ol.pagination>li.selected');
            var liSelectedText = liSelected.text();
            var prevDom  = $('ol.pagination>li').eq(1);
            var nextDom  = $('ol.pagination>li').last().prev();

            var rel = $(this).children('a').attr('rel');
            liSelected.removeClass('selected');
            liSelected.html('<a href="#page=' + liSelectedText +
                '">' + liSelectedText + '</a>');
            if (rel === 'first') {
                var firstPageDom = $('ol.pagination>li').eq(2);
                firstPageDom.addClass('selected').html(firstPageDom.text());
            } else if (rel === 'prev') {
				var prevPageDom = liSelected.prev();
				if(liSelected.text()==1){
					prevPageDom=liSelected;
				}
                prevPageDom.addClass('selected').html(prevPageDom.text());
				
            } else if (rel === 'next') {
                var nextPageDom = liSelected.next();
				if(liSelected.text()=='<{$pageCount}>'){
					nextPageDom=liSelected;
				}
                nextPageDom.addClass('selected').html(nextPageDom.text());
            } else if (rel === 'last') {
                var lastPageDom = $('ol.pagination>li').last().prev().prev();
                lastPageDom.addClass('selected').html(lastPageDom.text());
            } else {
                $(this).addClass('selected').html($(this).text());
            }
            freshTable('<{$func}>', <{$tableDom|default: "$('.tablesorter')"}>);
        });
    });
</script>
