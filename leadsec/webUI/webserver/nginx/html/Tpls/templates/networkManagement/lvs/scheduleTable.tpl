<{foreach $schedule as $id => $arr }>
    <tr>
        <td><{$id+1}></td>
        <td><{$arr.virtual_ip}></td>
        <td><{$arr.virtual_port}></td>
        <td><{$arr.real_ip1}></td>        	    
        <td><{$arr.real_port1}></td>
        <td><{$arr.real_ip2}></td>        	    
        <td><{$arr.real_port2}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditRealAddrDialog('<{$arr.virtual_ip}>','<{$arr.virtual_port}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelRealAddrDialog('<{$arr.virtual_ip}>','<{$arr.virtual_port}>')">删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='8'>No Schedule Data.</td></tr>
<{/foreach}>
<script type="text/javascript"> 
    $(document).ready(function() {
        $('#scheduleTable').bind("sortEnd",function(){
            var trDoms   = $('#scheduleTable tbody tr');
            var icnt = 0;
            trDoms.each(function() {
                icnt++;
                $(this).find('td:eq(0)').html(icnt);
            })
        });        
    });
</script>