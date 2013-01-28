<form action="Function/client/safeBrowse/usrAuthen.php" method="POST" id="setUsrAuthenForm"
    onSubmit="return false;">
    <table class="column_95">
        <caption>认证方式</caption>
        <tbody>
        <tr>
            <td class="tdheader" width="250"></td>
            <td class="tdbody">
                <input class='floatLeft' type="radio" name="usrAuthenChk" value="noauth"/>不认证
            </td>
        </tr>
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
            	<input class='floatLeft' type="radio" name="usrAuthenChk" value="local"/>本地认证
            </td>
        </tr>
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
            	<input class='floatLeft' type="radio" name="usrAuthenChk" value="radius"/>Radius认证
            </td>
        </tr>
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
            	<input class='floatLeft' type="radio" name="usrAuthenChk" value="ldap"/>LDAP认证
            </td>
        </tr>
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" class="inputbtn standard" onclick="setUsrAuthenForm()">确定</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>

<form action="Function/client/safeBrowse/usrAuthen.php?radius=1" method="POST" id="setRadiusForm"
    onSubmit="return false;">
    <table class="column_95">
        <caption>Radius配置</caption>
        <tbody>
        <tr>
        	<td class="tdheader" width="250">服务器IP地址:<em class="required">*</em></td>
            <td class="tdbody">
                <input class='floatLeft' type="text" name="radiusSIp" value="<{$usrAuthen.radius_ip}>" maxlength="15"/>
            </td>
        </tr>
        
        <tr>
        	<td class="tdheader" width="250">端口:<em class="required">*</em></td>
            <td class="tdbody">
                <input class='floatLeft' type="text" name="radiusPort" value="<{$usrAuthen.radius_port}>" size="5" maxlength="5"/>
            </td>
        </tr>
        
        <tr>
        	<td class="tdheader" width="250">共享密钥:<em class="required">*</em></td>
            <td class="tdbody">
                <input class='floatLeft' type="text" name="sharedKey" value="<{$usrAuthen.radius_passwd}>" maxlength="15"/>
            </td>
        </tr>
        
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" class="inputbtn standard" onclick="setRadiusConfigForm()">确定</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>

<form action="Function/client/safeBrowse/usrAuthen.php?ldap=1" method="POST" id="setLDAPForm"
    onSubmit="return false;">
    <table class="column_95">
        <caption>LDAP配置</caption>
        <tbody>
        <tr>
        	<td class="tdheader" width="250">LDAP服务器地址:<em class="required">*</em></td>
            <td class="tdbody">
                <input class='floatLeft' type="text" name="ldapSIp" value="<{$usrAuthen.ldap_ip}>" maxlength="15"/>
            </td>
        </tr>
        
        <tr>
        	<td class="tdheader" width="250">LDAP DN:<em class="required">*</em></td>
            <td class="tdbody">
                <input class='floatLeft' type="text" name="ldapDN" value="<{$usrAuthen.ldap_dn}>" maxlength="30"/>
            </td>
        </tr>
        
        <tr>
        	<td class="tdheader" width="250">搜索属性:</td>
            <td class="tdbody">
                <input class='floatLeft' type="text" name="searchProperty" value="<{$usrAuthen.ldap_attr}>" maxlength="30"/>
            </td>
        </tr>
        
        <tr>
        	<td class="tdheader" width="250">分支搜索:</td>
            <td class="tdbody">
                <input class='floatLeft' type="checkbox" name="branchSearch" 
                <{if <{$usrAuthen.ldap_opt}> eq 1}>checked="checked"<{/if}>/>
            </td>
        </tr>
        
         <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" class="inputbtn standard" onclick="setLDAPConfigForm()">确定</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<script type="text/javascript" src="Public/js/client/safeBrowse/usrAuthen.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    initUsrAuthenChk(); 
    validateForm($("#setRadiusForm"));
    validateForm($("#setLDAPForm"));
});

function initUsrAuthenChk() {
	if ('<{$usrAuthen.mode}>' == 'L') {
		$("input[name='usrAuthenChk']:eq(3)").attr("checked",'checked');
	} else if ('<{$usrAuthen.mode}>' == 'S'){
		$("input[name='usrAuthenChk']:eq(1)").attr("checked",'checked');
	} else if ('<{$usrAuthen.mode}>' == 'R'){
		$("input[name='usrAuthenChk']:eq(2)").attr("checked",'checked');	
	} else {
		$("input[name='usrAuthenChk']:eq(0)").attr("checked",'checked');
	}
}
</script>
