<form action="Function/systemManagement/admin/host.php" method="POST" id="editHostForm"
    onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加管理主机</legend>
        <div class="row">
            <label>
                <input class="radio" type="radio" name="ipType" value="ipv4"
                    onClick="changeIpType('ipv4')"/>
                IPV4
            </label>
            <label>
                <input class="radio" type="radio" name="ipType" value="ipv6"
                    onClick="changeIpType('ipv6')"/>
                IPV6
            </label>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="ip">管理主机IP:<em class="required">*</em></label>
            <input type="text" name="ip" value="<{$ip}>" id="ip"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="netmask">子网掩码:<em class="required">*</em></label>
            <input type="text" name="netmask" value="<{$netmask}>" id="netmask"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="comment">说明:</label>
            <textarea rows="10" cols="30" name="comment" value="<{$comment}>" id="comment"/>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>

<script type="text/javascript">
    $(document).ready(function(){
        validateForm($("#editHostForm"));
    });
    function changeIpType(type) {
        $('#ip').attr('name', type);
    }
</script>
