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
    <tr><td colspan='7'>没有入侵检测记录！</td></tr>
<{/foreach}>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
    });
</script>
