<form action="Function/networkManagement/interface/physical.php" method="POST" id="editPhysicalForm" onSubmit="return false;">
    <input type="hidden" name="type" value="edit"/>
    <fieldset>
       <legend>修改物理设备</legend>
        <div class="hide" id="summary">
        </div>
        <div class="row">
        	 <label for="external_name">名称:</label>
             <input type="text" name="external_name" value="<{$res.external_name}>" readonly="readonly"/>(不能修改)
		</div>
        
        <div class="row"><label for="mac_address">MAC 地址:</label>
          <input type="text" name="mac_address" value="<{$res.mac_address}>"/>
        </div>
       
        <div class="row"><label for="linkmode">链路工作模式:</label>
            <{html_options name="linkmode" id="linkmode" class="select"
                output=array('自适应','全双工','半双工') values=array(0,1,2)
                selected=$res.linkmode}>
        </div>
        
		<div id="speed_type_div" <{if $res.linkmode eq 0}> class="hide" <{/if}>>
			<div class="row"><label for="speed">链路速度:</label>
				<{html_options name="speed" id="speed" class="select"
					output=array('10','100','1000') values=array(10,100,1000)
					selected=$res.speed }>
			</div>
		</div>
        
        <div class="row" id="workmode_div" <{if $res.workmode eq 2}> class="hide" <{/if}>>
            <label for="mtu">MTU:</label>
            <input type="text" name="mtu" value="<{$res.mtu}>" />
        </div>
        
        <div class="row">
            <label for="workmode">工作模式:</label>
            <{html_options name="workmode" id="workmode" class="select"
            output=array('未指定','路由模式','冗余模式') values=array(0,1,3)
            selected=$res.workmode }>
        </div>

        <div id="unRedundanceDiv" <{if $res.workmode eq 3}> class="hide" <{/if}>>
            <div class="row"><label for="ipaddr_type">IP地址获取:</label>
                <{html_options name="ipaddr_type" id="ipaddr_type" class="select"
                output=array('未指定','静态IP地址','无效','DHCP获得') values=array(0,1,2,3)
                selected=$res.ipaddr_type }>
            </div>
            <div id="ipaddr_type_div" <{if $res.ipaddr_type neq 1}> class="hide" <{/if}>>
                <div class="row"><label for="ipv4">IPV4地址：</label>
                    <input type="text" name="ipv4" id="ipv4" value="<{$res.ip}>"/><label class="maskLabel">/</label>
                    <input class="ipv4Netmask" type="text" name="ipv4Netmask" value="<{$res.mask}>"/>
                </div>
                <div class="row"><label for="ipv6">IPV6地址：</label>
                    <input type="text" name="ipv6" id="ipv6" value="<{$res.ipv6}>"/><label class="maskLabel">/</label>
                    <input class="ipv6Netmask" type="text" name="ipv6Netmask" value="<{$res.ipv6_mask}>" />
                </div>
            </div>
        </div>
        
        <div class="row"><label for="ipmac_check">开启IPMAC地址绑定:</label>
          <input type="checkbox" name="ipmac_check" class="checkbox" <{if $res.ipmac_check eq 1}> checked="checked" <{/if}> />
        </div>
        
        <div class="row"><label for="ipmac_check_policy">允许未绑定的IPMAC地址通过:</label>
          <input type="checkbox" name="ipmac_check_policy" class="checkbox" <{if $res.ipmac_check_policy eq 1}> checked="checked" <{/if}> />
        </div>
         
        <div class="row"><label for="antispoof">开启IP地址欺骗检查:</label>
          <input type="checkbox" name="antispoof" class="checkbox" <{if $res.antispoof eq 1}> checked="checked" <{/if}> />
        </div>
         
        <div class="row"><label for="admin">用于管理:</label>
          <input type="checkbox" name="admin" class="checkbox" disabled='disabled' <{if $res.admin eq 1}> checked="checked" <{/if}> />
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
        validateForm($("#editPhysicalForm"), 'summary');
		$("#ipaddr_type").change(function(){
            var val = this.value;
            if (val == 1) {
                $('#ipaddr_type_div').show();
            } else {
                $('#ipaddr_type_div').hide();
            }
        });
		$("#workmode").change(function(){
            var val = this.value;
            if (val == 0) {
                $('#workmode_div').hide();
                $('#unRedundanceDiv').show();
            } else if (val == 3) {
                $('#workmode_div').show();
                $('#unRedundanceDiv').hide();
            } else {
                $('#workmode_div').show();
                $('#unRedundanceDiv').show();
            } 
        });
		$("#linkmode").change(function(){
			var val = this.value;
			if (val == 0) {
				$('#speed_type_div').hide();
			} else {
				$('#speed_type_div').show();
			}
		});
	});
</script>
