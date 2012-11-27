<{foreach $realmAddr as $k => $ra}>
    <tr>
        <td><{$ra.id}></td>
        <td><{$ra.name}></td>
        <td><{$ra.domain}></td>
        <td>
            primary:<{$ra.primary_dns|default:Empty}><br/>
            slave:<{$ra.slave_dns|default:Empty}><br/>
        </td>
        <td>
            <{$ra.staticIpList}>
        </td>
        <td>
            <{$ra.dynamicIpList}>
        </td>
        <td class="no_search">
            <a href="#" class="edit" onclick="openEditRealmAddrDialog('<{$ra.id}>')">
                编辑</a>
            <a href="#" class="delete" onclick="openDelRealmAddrDialog('<{$ra.name}>')">
                删除</a> 
            <a href="#" class="reflesh" onclick="refreshRealmAddr('<{$ra.name}>')">刷新</a>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='7'>No Realm Address Data</td></tr>
<{/foreach}>
