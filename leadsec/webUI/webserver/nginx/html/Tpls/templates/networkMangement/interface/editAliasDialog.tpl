<form action="Function/networkMangement/interface/alias.php" method="POST" id="editAliasForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>定义别名设备</legend>
		<div class="row"><label for="external_name">选择绑定设备:<em class="required">*</em></label>
            <select name="external_name" id="external_name" class="select"
                <{if $res.phy_device}>disabled="disabled"<{/if}>>
            <{html_options output=$res.bindDev values=$res.bindDev selected=$res.phy_device}>
            </select>
        </div>
        
        <div class="row"><label for="aliasId">选择别名ID:<em class="required">*</em></label>
            <select name="aliasId" id="aliasId" class="select">
                <{for $i=0 to 252}>
                    <{if $res.alias_id eq $i}>
                    <option value="<{$i}>" selected="selected"><{$i}></option>
                    <{else}>
                    <option value="<{$i}>"><{$i}></option>
                    <{/if}>
                <{/for}>
            </select>
        </div>
        
        <div class="row"><label for="ip">地址:<em class="required">*</em></label>
          <input type="text" name="ip" value="<{$res.ip }>" />
        </div>
        
        <div class="row"><label for="mask">掩码:<em class="required">*</em></label>
          <select name="mask" id="mask" class="select">
          	<{html_options output=array('255.255.255.0','255.255.0.0','255.0.0.0','255.255.255.255')
                values=array('255.255.255.0','255.255.0.0','255.0.0.0','255.255.255.255')
                selected=$addr.mask|default: '255.255.255.0'}>
          </select>
        </div>
      
        <div class="row"><label for="admin">用于管理:</label>
          <input type="checkbox" name="admin" class="checkbox" <{if $res.admin eq 1}> checked="checked" <{/if}> />
        </div>
         
        <div class="row"><label for="ping">允许 PING:</label>
          <input type="checkbox" name="ping" class="checkbox" <{if $res.ping eq 1}> checked="checked" <{/if}> />
        </div>
         
        <div class="row"><label for="traceroute">允许 Traceroute:</label>
          <input type="checkbox" name="traceroute" class="checkbox" <{if $res.traceroute eq 1}> checked="checked" <{/if}> />
        </div>
        
        <div class="row"><label for="enable">是否启用:</label>
          <input type="checkbox" name="enable" class="checkbox" <{if $res.enable eq 1}> checked="checked" <{/if}> />
      	</div>
  </fieldset>
</form>
<style type="text/css">
	fieldset label {
		width:15em;
	}
</style>
<script type="text/javascript">
    $(document).ready(function(){
        validateForm($("#editAliasForm"));
    });
</script>
