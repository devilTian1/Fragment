<form action="Function/resConf/addr/addrList.php" method="POST" id="editAddrListForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>地址列表维护</legend>
        <div class="row">
            <label for="addrName">名称:<em class="required">*</em></label>
            <input type="text" name="addrName" maxlength="15" value="<{$addr.name}>" id="addrName"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="addrType">定义地址的方式:</label>
            <{html_radios class="radio" name=addrType label_ids=true values=array('default', 'reverse', 'range')
              output=array('IP地址/掩码', '反IP地址/掩码', '地址范围')
              selected=$addr.type|default: 'default' onClick="changeAddrType()"
            }>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>地址:<em class="required">*</em></label>
            <div class="floatLeft" id="addrDiv">
                <input type="text" name="ip" value="<{$addr.ip}>"/><b>/</b>
                <{html_options name=netmask_default output=array('255.255.255.0','255.255.0.0','255.0.0.0','255.255.255.255') values=array('255.255.255.0','255.255.0.0','255.0.0.0','255.255.255.255') selected=$addr.mask|default: '255.255.255.0' }>
                <br class="clearFloat"/>
            </div>
            <div class="floatLeft" id="addr_rDiv">
               <b>!</b><input type="text" name="ipAddr_r" value="<{$addr.ip}>"/><b>/</b>
                <{html_options name=netmask_r output=array('255.255.255.0','255.255.0.0','255.0.0.0','255.255.255.255') values=array('255.255.255.0','255.255.0.0','255.0.0.0','255.255.255.255') selected=$addr.mask|default: '255.255.255.0' }>
            </div>
            <div class="floatLeft" id="rangeDiv">
                <input type="text" name="range_s" value="<{$addr.ip}>"/><b> - </b>
                <input type="text" name="range_e" value="<{$addr.mask}>"/>
            </div>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="comment">备注:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$addr.comment}></textarea>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function(){
        validateForm($("#editAddrListForm"));
        changeAddrType();
    });
</script>
