<form action="Function/systemManagement/admin/host.php" method="POST" id="editHostForm"
    onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加管理主机</legend>
        <div class="row">
            <label for="type">IP类型:<em class="required">*</em></label>
            <{html_radios class="radio" name=ipType values=array('ipv4', 'ipv6') output=array('IPV4', 'IPV6')
              selected=$ipChecked|default: 'ipv4' onClick="changeIpType()"
            }>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="ip">管理主机IP:<em class="required">*</em></label>
            <input type="text" name="<{$ipChecked|default: 'ipv4'}>" value="<{$ip}>" id="ip"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="netmask">子网掩码:<em class="required">*</em></label>
            <input type="text" name="netmask" value="<{$netmask}>" id="netmask"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="comment">说明:</label>
            <textarea rows="10" cols="30" name="comment" id="comment"><{$comment}></textarea>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>

<script type="text/javascript">
    $(document).ready(function(){
        validateForm($("#editHostForm"));
        changeIpType();
    });
</script>
