<form action="Function/networkManagement/lvs/schedule.php" method="POST" id="editRealAddrForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: add}>"/>
    <fieldset>
        <legend>负载均衡</legend>
        <div class="hide" id="erroDiv"></div>
        <div class="hide" id="summary"></div>
        <div class="row">
            <label for="vAddr">虚拟地址:<em class="required">*</em></label>
            <div class="column column_60">
                <{html_options name="virtualAddr" id="virtualAddr"
                    class="select ipv4" options=$virtualAddrList 
                    selected=$result.virtual_ip|default: ''}>
                <label class="virtualPortLabel" for="vPort">虚拟端口:<em class="required">*</em></label>
                <input class="port" type="text" name="virtualPort" <{if $type === 'edit'}>disabled="disabled"<{/if}>
                    value="<{$result.virtual_port}>" size="5" maxlength="5"/>
                <{if $type === 'edit'}>
                    <input type="hidden" name="delVirtualIp" value="<{$result.virtual_ip}>"/>
                    <input type="hidden" name="delVirtualPort" value="<{$result.virtual_port}>"/>
                <{/if}>
        	</div>
	    </div>
        <{for $i=1 to 16}>
            <div class="row">
                <label for="realAddr">真实地址<{$i}>:
                    <{if $i < 3}>
                    <em class="required">*</em>
                    <{/if}>
                </label>
                <div class="column column_60">
                    <input class="ipv4" type="text" name="realAddr<{$i}>"
                        id="realAddr<{$i}>"
                        value="<{$result.rAddrBuf[$i-1]}>"/>
                    <label class="virtualPortLabel"
                        for="vPort">端口<{$i}>:
                        <{if $i < 3}>
                        <em class="required">*</em>
                        <{/if}>
                    </label>
                    <input class="port" type="text" name="realPort<{$i}>"
                        id="realPort<{$i}>"
                        value="<{$result.rPortBuf[$i-1]}>" size="5" maxlength="5"/>
                </div>
            </div>
        <{/for}>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
        validateForm($("#editRealAddrForm"), 'summary');
        
        if ('<{$type}>' === 'edit') {
            $('#virtualAddr').attr('disabled',"disabled");
        }
        
       $('#virtualAddr').change(function() {
            checkIpAndPort();
        });
    
        $('input[name="virtualPort"]').keyup(function() {
            checkIpAndPort();
        });
    });
</script>
