<{foreach $GeneralAcc as $key => $array }>
    <tr>
        <td><{$beginId++}></td>        
        <td><{$array.sip}></td>
        <td>
        	<{if $array.time != 'none'}>
        		<{$array.time}>
        	<{/if}>
        </td>       
        <td><{$array.usergrp}></td>
        <td title="<{$array.comment|escape}>"><{$array.comment|escape|truncate:20:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditGeneralAccessCtrlDialog('<{$array.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelGeneralAccessCtrlDialog('<{$array.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>No Data</td></tr>
<{/foreach}>
