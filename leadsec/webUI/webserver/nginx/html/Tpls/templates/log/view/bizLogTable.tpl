<{foreach $result as $r}>
    <tr>
        <td><{$r.date}></td>
        <td><{$priArr[$r.pri]}></td>
        <td><{$modArr[$r.mod]|default:$r.mod}></td>
        <td style="text-align: left; padding-left: 2em">
            <{assign var='replace' value="<font color='red'>`$keyword`</font>"}>
            <{$r.event|replace:$keyword:$replace}>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='4'>无数据</td></tr>
<{/foreach}>
