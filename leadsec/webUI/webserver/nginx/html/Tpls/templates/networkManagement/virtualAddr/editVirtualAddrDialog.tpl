<form action="Function/networkManagement/virtualAddr/virtualAddr.php" method="POST" id="editVirtualAddrForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>定义虚拟地址</legend>
        <div class="row">
            <label for="ifname">网络接口:<em class="required">*</em></label>
            <{html_options class="ifname" name="ifname" id="ifname"
                onChange="showSpecIpMask('change')"
                options=$ifNameList selected=$res.ifname|default: ''}>
        </div>       
        <div class="row">
            <label for="addr">地址/掩码:<em class="required">*</em></label>
            <{html_options class="ipmask" name="addr" id="addr"
                options=$aliasAddrList selected=$res.addr|default: ''
                onChange="$('#editVirtualAddrForm').valid()"}>
        </div>
        <div class="row">
            <label>说明:</label>
            <label class="simpleLabel">地址/掩码为别名设备的地址和掩码。<br/>别名设备可以在网络设备 >> 网络设备 >> 别名设备 进行添加。</label>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editVirtualAddrForm"));
    showSpecIpMask('init');
});
</script>
