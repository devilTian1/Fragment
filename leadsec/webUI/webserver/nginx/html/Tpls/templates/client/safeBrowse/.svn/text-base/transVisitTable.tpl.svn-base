<{foreach $TransAcc as $key => $array }>
    <tr>
        <td><{$beginId++}></td>        
        <td><{$array.sip}></td>
        <td><{$array.dip}></td>
        <td><{$array.port}></td>
        <td>
            <{if $array.https eq 1}>
                是
            <{else if $array.https eq 0}>
                否
            <{else}>
                Error
            <{/if}>
        </td>
        <td>
        	<{if $array.time != 'none'}>
        		<{$array.time}>
        	<{/if}>
        </td>       
        <td><{$array.usergrp}></td>
        <td title="<{$array.comment|escape}>"><{$array.comment|escape|truncate:16:"... ..."}></td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditTransAccessCtrlDialog('<{$array.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelTransAccessCtrlDialog('<{$array.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='8'>No Data</td></tr>
<{/foreach}>
