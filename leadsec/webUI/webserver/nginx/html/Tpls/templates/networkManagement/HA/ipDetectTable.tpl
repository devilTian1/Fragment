<{foreach $list as $value }>
    <tr>
        <td><{$value@index+1}></td>
        <td><{$value.ip}></td>
        <td title="<{$value.comment|escape}>"><{$value.comment|escape|truncate:30:"... ..."}></td>
        <td>
            <a href="#" class="edit" onclick="openIpDetectDialog('<{$value.ip}>')">编辑</a>
      	    <a href="#" class="delete"
                onclick="openDelIpDetectDialog('<{$value.ip}>', '<{$value.ifname}>')">
                删除</a>	

        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='4'>无数据</td></tr>
<{/foreach}>
