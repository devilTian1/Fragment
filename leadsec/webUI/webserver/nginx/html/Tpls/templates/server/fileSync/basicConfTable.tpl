<{foreach $status as $val }>
    <tr>
        <td><{$val.cert}></td>
        <td><{$val.name}></td>
        <td><{$val.overtime}></td>
        <td><{$val.status}></td>
        <td>
            <{if $val.value eq 1}>
                 <a href="#" class="delete" onclick="openDelDialog('<{$val.cert}>')">
                                               删除</a> 
            <{/if}>
        </td>       
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>无数据</td></tr>
<{/foreach}>
