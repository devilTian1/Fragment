<{foreach $filter as $key => $array }>
    <tr>
        <td><{$key+1}></td>
        <td><{$array.name}></td>
        <td><{$array.protocol}></td>
        <td><{$array.attachmaxsize}></td>
        <td><{if $array.allowext !== 'novalue'}><{$array.allowext}><{/if}></td>
        <td><{if $array.allowsender !== 'novalue'}><{$array.allowsender}><{/if}></td>
        <td><{if $array.allowrecv !== 'novalue'}><{$array.allowrecv}><{/if}></td>
        <td><{if $array.skeyword !== 'novalue'}><{$array.skeyword}><{/if}></td>
        <td><{if $array.ckeyword !== 'novalue'}><{$array.ckeyword}><{/if}></td>
        <td>
        	<{if $array.fileav === 'off'}>
        		关
        	<{else}>
        		开
        	<{/if}>
        </td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditFilterDialog('<{$array.id}>')">编辑</a>
            <a href="#" class="delete" onclick="openDelFilterDialog('<{$array.id}>', '<{$array.name}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='11'>No Data</td></tr>
<{/foreach}>
