<form action="index.php?R=systemManagement/networkConf/interfaceConf/physical/setSpecPhysicalDev" method="POST" id="editPhysicalForm" onSubmit="return false;">
    <input type="hidden" name="type" value="edit"/>
    <fieldset>
        <legend>修改物理设备</legend>
        <ul class="hide" id="summary">
        </ul>
        <div class="row">
        	 <label for="external_name">接口名称:</label>
             <input type="text" name="external_name" value="<{$res.external_name}>" readonly="readonly"/>(不能修改)
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
         
        <div class="row">
            <label for="workmode">工作模式:</label>
            <{html_options name="workmode" id="workmode" class="select"
            output=array('透明模式','路由模式','冗余模式','trunk模式') values=array(0,1,2,3)
            selected=$res.workmode }>
        </div>
        
        <hr class="clearFloat"/>
        <div id="div_vlan" style="display:none">
        <div class="row">            
                <label for="vlan_packrule">VLAN封装标准:</label>
                <{html_options name="vlan_packrule" id="vlan_packrule" class="select"
                output=array('dot1q','isl','nego') values=array(1,2,0)
                selected=$res.vlan_encap }>
        </div>

        <div class="row">
                <label for="vlan_bindrange">绑定VLAN区间:</label>
                <input type="checkbox" class="simpleLabel" name="checkBindRange" id="checkBindRange" onclick="bindRangeCtrl()" 
                <{if $res.bind_vlanrange neq '' && $res.bind_vlanrange neq '-1'}>checked="checked"<{/if}>/>
                <input type="text" name="vlan_bindrange" id="vlan_bindrange" <{if $res.bind_vlanrange neq '' && $res.bind_vlanrange neq '-1'}>value="<{$res.bind_vlanrange}>"<{else}> value=""<{/if}> class="width132"/>(VLAN ID:1 - 4094) 
        </div>
            
        <div class="row">
                <label for="vlan_id">Native VLAN ID:</label>
                <input type="checkbox" class="simpleLabel" name="checkVlanId" id="checkVlanId" onclick="vlanIdCtrl()"
                <{if $res.native_vlanid neq '-1' && $res.native_vlanid neq ''}>checked="checked"<{/if}>/>
                <input type="text" name="vlan_id" id="vlan_id" <{if $res.native_vlanid neq '-1' && $res.native_vlanid neq ''}>value="<{$res.native_vlanid}>"<{else}> value=""<{/if}> class="width132"/>(VLAN ID:1 - 4094) 
            </div>
            <hr class="clearFloat"/>
        </div>

        <div id="addrDiv" <{if $res.workmode neq 1}> class="hide" <{/if}>>
            <div class="row"><label for="ipaddr_type">IP地址获取:</label>
                <{html_options name="ipaddr_type" id="ipaddr_type" class="select"
                output=array('静态IP地址','DHCP获得') values=array(1,3)
                selected=$res.ipaddr_type }>
            </div>
            <div id="ipaddr_type_div" <{if $res.ipaddr_type neq 1}> class="hide" <{/if}>>
                <div class="row"><label for="ipv4">IP地址：</label>
                    <input type="text" name="devIpv4" id="devIpv4" value="<{$res.ip}>" class="ipv4"/><label class="maskLabel">/</label>
                    <input class="ipv4Netmask" type="text" name="devIpv4Netmask" value="<{$res.mask}>"/>
                </div>
            </div>
            <hr class="clearFloat"/>
        </div>
        
        <div id="routeDiv">
        <div class="row"><label for="admin">用于管理:</label>
          <input type="checkbox" name="admin" class="checkbox" <{if $res.admin eq 1}> checked="checked" <{/if}> />
        </div>
         
        <div class="row"><label for="ping">允许 PING:</label>
          <input type="checkbox" name="ping" class="checkbox" <{if $res.ping eq 1}> checked="checked" <{/if}> />
        </div>
         
        <div class="row"><label for="traceroute">允许 Traceroute:</label>
          <input type="checkbox" name="traceroute" class="checkbox" <{if $res.traceroute eq 1}> checked="checked" <{/if}> />
        </div>        
        <hr class="clearFloat"/>
        </div>
        
        <div class="row"><label for="enable">是否启用:</label>
          <input type="checkbox" name="enable" class="checkbox" <{if $res.enable eq 1}> checked="checked" <{/if}> />
      	</div>
      	
        <div class="row">
            <button class="standard floatLeft" style="position: static"  onclick="displayAdvanced()">高级</button>
        </div>
        
        <div class="row" id="div_advanced" style="display:none">
                             
            <div class="row">
                <label for="remark_name">备注名称:</label>
                <input type="text" name="remark_name" value="<{$comment}>" />(1-15位中文、字母、数字、减号、下划线组合)
	   </div>      	
            <div class="row"><label for="mac_address">MAC 地址:</label>
              <input type="text" name="mac_address" value="<{$res.mac_address}>" class="width132"/>
            </div>
            
            <div class="row" id="workmode_div" <{if $res.workmode eq 2}> class="hide" <{/if}>>
                <label for="mtu">MTU:</label>
                <input type="text" name="mtu" value="<{$res.mtu}>" class="width132"/>(68-9216)
            </div>
            
            <div id="routeDiv2">
            <div class="row">
                <label for="switchDynDomain">开启动态域:</label>
                <input type="checkbox" name="chkDynDomain" class="checkbox" <{if $res.dns_enable eq 1}> checked="checked" <{/if}> onclick="dynDomainCtrl()"/>
             </div>
             
             <div class="row">
                <label for="DynDomain">动态域名:</label>
                <input type="text" name="DynDomain" value="<{$res.domain_name}>" />
             </div>             
             
             <div class="row">
                <label for="antiARPAttack">开启抗ARP攻击:</label>
                <input type="checkbox" name="chkAntiARPAttack" class="checkbox" <{if $antiARP eq 'on'}> checked="checked" <{/if}> />
             </div>
             
             <div class="row">
                <label for="checkIPConflict">开启检测网内IP地址冲突:</label>
                <input type="checkbox" name="chkIPConflict" class="checkbox" <{if $ipConflict eq 'on'}> checked="checked" <{/if}> />
             </div>
             </div>
             
             <div class="row"><label for="ipmac_check">开启IPMAC地址绑定:</label>
              <input type="checkbox" name="ipmac_check" class="checkbox" <{if $res.ipmac_check eq 1}> checked="checked" <{/if}> 
              onclick="checkIpmacCheck()"/>
            </div>
            
            <div class="row"><label for="ipmac_check_policy">允许未绑定的IPMAC地址通过:</label>
              <input type="checkbox" name="ipmac_check_policy" class="checkbox" <{if $res.ipmac_check_policy eq 1}> checked="checked" <{/if}> />
            </div>
             
            <div id="divAntispoof" class="row"><label for="antispoof">开启IP地址欺骗检查:</label>
              <input type="checkbox" name="antispoof" class="checkbox" <{if $res.antispoof eq 1}> checked="checked" <{/if}> />
            </div>
             
             <div class="row">
                <label for="BandwidthManage">开启带宽管理:</label>
                <input type="checkbox" name="chkBandwidthManage" id="chkBandwidthManage" class="checkbox" <{if $res.qos_enable eq 1}> checked="checked" <{/if}> onclick="bindwidthOnCtrl()"/>
                <input type="text" name="BandwidthValue" id="BandwidthValue" value="<{$res.qos_device_bw}>" />Kbps <button class="standard floatLeft" style="position: static"  onclick="">自动检测</button>
             </div>
             
             <div class="row">
                <label for="openDHCP">开启DHCP中继:</label>
                <input type="checkbox" name="chkOpenDHCP" id="chkOpenDHCP" class="checkbox" <{if $res.dhcp_relay eq 1}> checked="checked" <{/if}> onclick="dhcpOnCtrl()"/>                
             </div>
             
             <div class="row">
                <label for="DHCPAddr">DHCP服务器地址:</label>
                <input type="text" name="DHCPAddr" id="DHCPAddr" value="<{$res.dhcpserver}>" />(多个IP以英文逗号分隔)       
             </div>
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
        dhcpOnCtrl();
        bindwidthOnCtrl();
        dynDomainCtrl();
		$("#ipaddr_type").change(function(){
            var val = this.value;
            if (val == 1) {
                $('#ipaddr_type_div').show();
                $('#workmode').removeAttr("disabled");
                $("input[name='chkAntiARPAttack']").removeAttr("disabled");
                $("input[name='chkIPConflict']").removeAttr("disabled");
            } else {
                $('#ipaddr_type_div').hide();
                $('#workmode').attr("disabled",'disabled');
                $("input[name='chkAntiARPAttack']").attr("disabled",'disabled');
                $("input[name='chkIPConflict']").attr("disabled",'disabled');
            }
        });
		$("#workmode").change(function(){
            var val = this.value;
            if (val == 0) {
            // trans
                switchRouteWorkMode(0);
                $("#div_vlan").hide();    
                $("#chkBandwidthManage").attr("disabled",'disabled');
                $("#chkOpenDHCP").removeAttr("disabled");
                bindwidthOnCtrl();
                dhcpOnCtrl();
            } else if (val == 2) {
            // rd
                switchRouteWorkMode(0);
                $("#div_vlan").hide(); 
                $("#chkBandwidthManage").attr("disabled",'disabled');
                $("#chkOpenDHCP").attr("disabled",'disabled');
                bindwidthOnCtrl();
                dhcpOnCtrl();
            } else if (val == 3) {         
            // trunk     
                switchRouteWorkMode(0);  
                $("#div_vlan").show(); 
                vlanOnCtrl(); 
                $("#chkBandwidthManage").removeAttr("disabled");
                $("#chkOpenDHCP").removeAttr("disabled");
                bindwidthOnCtrl();
                dhcpOnCtrl();
            } else {
            // route
                switchRouteWorkMode(1);
                $("#div_vlan").hide();           
                $("#chkBandwidthManage").removeAttr("disabled");
                $("#chkOpenDHCP").removeAttr("disabled");
                bindwidthOnCtrl();
                dhcpOnCtrl();
            } 
        });
		$("#linkmode").change(function(){
			var val = this.value;
			if (val == 0) {
			// auto
				$('#speed_type_div').hide();
			} else if (val == 1) {
			// full
			        $('#speed_type_div').show();
			        if($('select[name="speed"] option').length <= 2) {
			           $("<option value='1000'>1000</option>").appendTo($("#speed"));
			        }
			} else {
			// half
				$('#speed_type_div').show();
				if($('select[name="speed"] option').length >= 3) {
				    $('#speed option:last').remove();
				}
			}
		});
	});
</script>
