<{$priC = array('紧急', '警报', '临界', '<em class="error">出错</em>',
                '预警', '提示', '通知', '调试')}>
<{foreach $result as $r}>
    <tr>
        <td><{$r.date}></td>
        <td><{$priArr[$r.pri]}></td>
        <td style="text-align: left; padding-left: 2em">
            <{assign var='replace' value="<font color='red'>`$keyword`</font>"}>
            <{$r.event|replace:$keyword:$replace}>
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='3'>No Log Data</td></tr>
<{/foreach}>
