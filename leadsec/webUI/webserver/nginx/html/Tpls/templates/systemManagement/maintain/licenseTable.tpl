<{foreach $licenseInformation   as $k => $val }>
    <tr>
        <td><{$val@index}></td>
        <td><{$val.function}></td>
        <td><{$val.stopTime}></td>
        <td><{$val.status}></td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>No  Data</td></tr>
<{/foreach}>

