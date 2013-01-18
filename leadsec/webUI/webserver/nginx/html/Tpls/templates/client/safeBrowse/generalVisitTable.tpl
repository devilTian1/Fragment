<{foreach $GeneralAcc as $key => $array }>
    <tr>
        <td><{$key+1}></td>        
        <td><{$array.sip}></td>
        <td>
        	<{if $array.time != 'none'}>
        		<{$array.time}>
        	<{/if}>
        </td>       
        <td><{$array.comment}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditGeneralAccessCtrlDialog('<{$array.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelGeneralAccessCtrlDialog('<{$array.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Data</td></tr>
<{/foreach}>
