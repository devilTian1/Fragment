<{foreach $urlFilter as $key => $array }>
    <tr>
        <td><{$offset+$key+1}></td>        
        <td><{$array.list}></td>
        <td title="<{$array.comment|escape}>"><{$array.comment|escape|truncate:40:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditUrlFilterDialog('<{$array.list}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelUrlFilterDialog('<{$array.list}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='4'>无数据</td></tr>
<{/foreach}>
<script type="text/javascript"> 
    $(document).ready(function() {
        $('#urlFilterTable').bind("sortEnd",function(){
            var trDoms   = $('#urlFilterTable tbody tr');
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