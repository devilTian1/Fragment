<{foreach $licenseInformation as $k => $val }>
    <tr>
        <td><{$val@index+1}></td>
        <td><{$val.ch_name}></td>
        <td><{$val.stopTime}></td>
        <td><{$val.status}></td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>������</td></tr>
<{/foreach}>

