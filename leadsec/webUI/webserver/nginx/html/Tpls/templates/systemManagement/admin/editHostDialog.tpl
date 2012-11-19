<form action="Function/systemManagement/admin/host.php" method="POST"
    id="editHostForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加管理主机</legend>
        <div class="row">
            <label for="ip">管理主机IP:<em class="required">*</em></label>
            <input type="text" name="ip" value="<{$ip}>" id="ip"/>
            <input type="hidden" name="oldIp" value="<{$ip}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="netmask">子网掩码:<em class="required">*</em></label>
            <input type="text" name="netmask" value="<{$netmask}>"
                id="netmask"/>
            <input type="hidden" name="oldNetmask" value="<{$netmask}>"/>
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
    });
</script>
