<{foreach $lockUser as $array }>
    <tr>
        <td><{$array@iteration}></td>        
        <td><{$array.user_name}></td> 
        <td><{$array.role_name}></td>        
        <td><{$array.unlock_time|date_format: '%Y/%m/%d %H:%M:%S'}></td> 
        <td class="no_search">
            <button class="standard" style="position: static" type="button"
                onclick="unlockUserDialog('<{$array.user_name}>')"
                id="unlockUserBtn">
           		解锁
            </button>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>无数据</td></tr>
<{/foreach}>
