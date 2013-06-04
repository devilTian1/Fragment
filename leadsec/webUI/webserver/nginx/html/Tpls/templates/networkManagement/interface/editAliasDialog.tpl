<form action="Function/networkManagement/interface/alias.php" method="POST" id="editAliasForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>定义别名设备</legend>
        <div class="hide" id="summary"></div>
		<div class="row"><label for="external_name">选择绑定设备:<em class="required">*</em></label>
            <select class="select" name="external_name" id="external_name"
                <{if $res.phy_device}>disabled="disabled"<{/if}>>
            <{html_options output=$res.bindDev values=$res.bindDev selected=$res.phy_device}>
            </select>
            <{if $res.phy_device}><input type="hidden" name="external_name" value="<{$res.phy_device}>_<{$res.alias_id}>"/><{/if}>
        </div>
        
        <div class="row"><label for="aliasId">选择别名ID:<em class="required">*</em></label>
            <select class="select" name="aliasId" id="aliasId" <{if $res.phy_device}>disabled="disabled"<{/if}>>
                <{for $i=0 to 252}>
                    <{if $res.alias_id eq $i}>
                    <option value="<{$i}>" selected="selected"><{$i}></option>
                    <{else}>
                    <option value="<{$i}>"><{$i}></option>
                    <{/if}>
                <{/for}>
            </select>
        </div>
        
        <div class="row"><label for="ipv4">IPV4地址:<em class="required">*</em></label>
            <input class="ipv4" type="text" name="devIpv4" value="<{$res.ip}>" /><label class="simpleLabel">/</label>
            <input class="ipv4Netmask" type="text" name="ipv4Netmask" value="<{$res.mask}>"/>
        </div>

        <div class="row"><label for="ipv6">IPV6地址:<em class="required">*</em></label>
            <input class="ipv6" type="text" name="devIpv6" value="<{$res.ipv6}>" /><label class="simpleLabel">/</label>
            <input class="ipv6Netmask" type="text" name="ipv6Netmask" value="<{$res.ipv6_mask}>"/>
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
        validateForm($("#editAliasForm"), 'summary');
        <{if $res.phy_device!=='fe2'}>
            $("input[name='admin']").attr("disabled",'disabled');
       <{/if}>
        
        $("#external_name").bind("change",function(){
            var selectOption = $("#external_name option:selected");
            if(selectOption.val() === 'fe2') {
                $("input[name='admin']").removeAttr("disabled");
            } else {
                $("input[name='admin']").attr("disabled",'disabled');
            }
        });
    });
</script>
