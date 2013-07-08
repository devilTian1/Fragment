<{foreach $keywordFilter as $key => $array }>
    <tr>
        <td><{$offset+$key+1}></td>        
        <td><{$array.name}></td>
        <td><{$array.context|regex_replace: "/,/" : "<br>"}></td>
        <td title="<{$array.comment|escape}>"><{$array.comment|escape|truncate:30:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditKeywordFilterDialog('<{$array.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelKeywordFilterDialog('<{$array.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>无数据</td></tr>
<{/foreach}>
<script type="text/javascript"> 
    $(document).ready(function() {
        $('#keywordFilterTable').bind("sortEnd",function(){
            var trDoms   = $('#keywordFilterTable tbody tr');
                if (trDoms.length > 1) {
                var icnt = 0;
                trDoms.each(function() {
                    icnt++;
                    $(this).find('td:eq(0)').html(icnt+<{$offset}>);
                });
            }
        });        
    });
</script>