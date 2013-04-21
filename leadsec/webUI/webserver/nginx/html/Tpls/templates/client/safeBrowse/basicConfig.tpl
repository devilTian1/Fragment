<form action="Function/client/safeBrowse/basicConfig.php" method="POST" id="setBasicConfigForm"
    onSubmit="return false;">
    <table class="column_95">
        <caption>基本配置</caption>
        <tbody>
        <tr>
            <td class="tdheader" width="250">本机监听地址:</td>
            <td class="tdbody">
                <{html_options class="select" name="nativeIp"
                options=$interfaceList selected=$editBasicConfig.service_ip|default: 'any_ipv4'}>
            </td>
        </tr>
        <tr>
            <td class="tdheader">本机监听端口:</td>
            <td class="tdbody">
            	<input class='floatLeft' type="text" name="nativePort" 
            	value="<{$editBasicConfig.service_port|default:'80'}>" size="5" maxlength="5"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader">允许的Http方法:</td>
            <td class="tdbody">
            	<div>
	            	<label class="column column_20"><input type="checkbox" class="checkbox" name="httpGet" 
	            		<{if $httpGet eq 1}>checked="checked"<{/if}>/>GET</label>
	            	<label class="column column_20"><input type="checkbox" class="checkbox" name="httpPost" 
	            		<{if $httpPost eq 1}>checked="checked"<{/if}>/>POST</label>
	            	<label class="column column_20"><input type="checkbox" class="checkbox" name="httpConnect" 
	            		<{if $httpConnect eq 1}>checked="checked"<{/if}>/>CONNECT</label>
	            	<label class="column column_20"><input type="checkbox" class="checkbox" name="httpHead" 
	            		<{if $httpHead eq 1}>checked="checked"<{/if}>/>HEAD</label>
	            </div>
            </td>
        </tr>
        <tr>
            <td class="tdheader">Http协议可访问端口:<em class="required">*</em></td>
            <td class="tdbody">
            	<input class='floatLeft' type="text" name="httpPort" value="<{$httpPort}>" size="50"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader">Https协议可访问端口:<em class="required">*</em></td>
            <td class="tdbody">
            	<input class='floatLeft' type="text" name="httpsPort" value="<{$httpsPort}>" size="50"/>
            </td>
        </tr>
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" class="inputbtn standard" onclick="setBasicConfigForm()">确定</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>

<script type="text/javascript" src="Public/js/client/safeBrowse/basicConfig.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	validateForm($("#setBasicConfigForm"));
    renderStandardUi();
});
</script>