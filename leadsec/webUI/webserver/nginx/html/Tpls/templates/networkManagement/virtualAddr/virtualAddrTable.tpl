<{foreach $list as $value }>
    <tr>
        <td><{$value@index+1}></td>
        <td><{$value.phyDevice}></td>
        <td><{$value.ip|cat:'/'|cat:$value.mask}></td>
        <td>
            <a href="#" class="edit" onclick="openEditVirtualAddrDialog('<{$value.ifname}>')">编辑</a>
      	    <a href="#" class="delete"
                onclick="openDelVirtualAddrDialog('<{$value.phyDevice}>', '<{$value.ifname}>')">
                删除</a>	

        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='4'>无数据</td></tr>
<{/foreach}>
