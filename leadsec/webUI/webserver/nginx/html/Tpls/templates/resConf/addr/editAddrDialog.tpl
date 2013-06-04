<form action="Function/resConf/addr/addrList.php" method="POST" id="editAddrListForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$id}>"/>
    <fieldset>
        <legend>地址列表维护</legend>
        <div class="hide" id="summary"></div>
        <div class="row">
            <label for="addrName">名称:<em class="required">*</em></label>
            <input class="width10em" type="text" name="addrName" maxlength="15" value="<{$addr.name}>"
            <{if $type ==='edit'}>disabled="disabled"<{/if}> id="addrName"/>
            <{if $type ==='edit'}>
            <input type="hidden" name="addrName" value="<{$addr.name}>"/>
            <{/if}>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="addrType">定义地址的方式:</label>
            <{html_radios class="radio" name=addrType label_ids=true values=array('default', 'range')
              output=array('IP地址/掩码', '地址范围')
              selected=$addr.type|default: 'default' onClick="changeAddrType()"
            }>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>IPv4或IPv6地址:<em class="required">*</em></label>
            <div class="floatLeft" id="addrDiv">
                <input class="width10em ip" type="text" name="ip" value="<{$addr.ip}>"/><label class="maskLabel">/</label>
                <input class="width10em netmask" type="text" name="netmask" value="<{$addr.mask}>"/>
                <br class="clearFloat"/>
            </div>
            <div class="floatLeft" id="rangeDiv">
                <input class="width10em ip" type="text" name="range_s" value="<{$addr.ip}>"/><b> - </b>
                <input class="width10em ip" type="text" name="range_e" value="<{$addr.mask}>"/>
            </div>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="comment">备注:</label>
            <input class="width10em comment" name="comment" id="comment" value="<{$addr.comment|escape}>"/>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function(){
    	validateForm($("#editAddrListForm"), 'summary');
        changeAddrType();
    });
</script>
