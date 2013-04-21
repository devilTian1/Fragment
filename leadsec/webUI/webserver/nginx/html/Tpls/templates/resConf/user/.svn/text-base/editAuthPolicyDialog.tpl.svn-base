<form action="Function/resConf/user/auth.php" method="POST" id="editAuthPolicyForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>定义认证策略</legend>
        <div id="summary"></div>
		<div class="row"><label for="AuthPolicyName">策略名称:<em class="required">*</em></label>
            <input type="text" name="AuthPolicyName" id="AuthPolicyName" value="<{$autopolicy.auth_policy_name}>" <{if $type === 'edit'}>readonly="readonly"<{/if}>/>
        </div>
        <div class="row">
            <label for="scraddr">定义地址的方式:</label>
            <{html_radios class="radio" name="addrType" label_ids=true values=array('default', 'range' , 'object')
              output=array('IP地址/掩码', '地址范围', '地址对象')
              selected=$autopolicy.sa_type|default: 'default' onClick="changeAddrType()"
            }>
        </div>
        <div class="row">
            <label>地址:</label>
            <div class="floatLeft" id="addrDiv">
                <input class="ip" type="text" name="authIp" value="<{$autopolicy.ip}>"/><label class="maskLabel">/</label>
                <input type="text" name="authNetmask" value="<{$autopolicy.netmask}>"/>
                <br class="clearFloat"/>
            </div>
            <div class="floatLeft" id="rangeDiv">
                <input class="ip" type="text" name="authRange_s" value="<{$autopolicy.ip}>"/><b> - </b>
                <input class="ip" type="text" name="authRange_e" value="<{$autopolicy.netmask}>"/>
            </div>
            <div class="floatLeft" id="objDiv">
                <select class="select" name="objaddr" id="objaddr">
                    <{html_options output=$autopolicy.addrname values=$autopolicy.addrname selected=$autopolicy.addrname}>
                </select>
            </div>
        </div>
		<div class="row"><label for="pname">入接口:</label>
            <select class="select" name="ingress" id="ingress">
                <{html_options output=$autopolicy.iflist values=$autopolicy.iflist selected=$autopolicy.ingress}>
            </select>
        </div>
        <div class="row"><label for="dport">目的端口:</label>
            <input type="text" name="dport" value="<{$autopolicy.port}>" />
        </div>
        <div class="row"><label for="active">状态:</label>
            <{html_radios class="radio" name="active" label_ids=true
                    output=array('启用', '停止') values=array(1, 0)
                    selected=$autopolicy.active|default: 0}>
        </div>
        <div class="row">
            <label for="comment">备注:</label>
            <input class="comment" name="comment" id="comment" value="<{$autopolicy.comment|escape}>"/>
        </div>
  </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	changeAddrType();
	renderStandardUi();
    validateForm($("#editAuthPolicyForm"), 'summary');
});
</script>
