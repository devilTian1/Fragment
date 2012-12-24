<{foreach $result as $r}>
    <tr>
        <td><{$r.date}></td>
        <td><{$r.pri}></td>
        <td><{$r.logtype}></td>
        <td><{$r.dname}></td>
        <td><{$r.privateArea}></td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Log Data</td></tr>
<{/foreach}>
