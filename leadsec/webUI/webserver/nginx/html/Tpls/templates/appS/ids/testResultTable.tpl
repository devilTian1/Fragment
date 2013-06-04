<{foreach $result as $r}>
    <tr>
        <td><{$r.rowsNum}></td>
        <td><{$r.date}></td>
        <td><{$r.sa}></td>
        <td><{$r.da}></td>
        <td><{$r.protocol}></td>
        <td><{$r.event}></td>
        <td><{$r.level}></td>
    </tr>
<{foreachelse}>
    <tr><td colspan='7'>无数据</td></tr>
<{/foreach}>
