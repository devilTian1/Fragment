<form action="Function/networkMangement/interface/redundance.php" method="POST" id="editRedundanceForm" onSubmit="return false;">
  <!--  <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>-->
    <fieldset>
        <!--<legend>别名设备</legend>-->
		<div class="row">
          <label for="external_name">选择设备名称:<em class="required">*</em></label>
          <input type="text" name="ip" value="<{$res.ip}>" />
          <!--<select name="linkmode" id="external_name" class="select">
          	<{html_options output=array('自适应','全双工','半双工') values=array(0,1,2) selected=$res.external_name}>
          </select>-->
        </div>
        
        <div class="row"><label for="linkmode">工作模式:<em class="required">*</em></label>
          <select name="linkmode" id="linkmode" class="select">
          	<{html_options output=array('自适应','全双工','半双工') values=array(0,1,2) selected=$res.linkmode}>
          </select>
        </div>
        
        <div class="row"><label for="ipaddr_type">IP地址获取:</label>
          <select name="ipaddr_type" id="ipaddr_type" class="select">
          	 <{html_options output=array('未指定','静态IP地址','无效','DHCP获得') values=array(0,1,2,3) selected=$res.ipaddr_type }>
          </select>
        </div>
        <div id="ipaddr_type_div" <{if $res.ipaddr_type neq 1}> style="display:none" <{/if}>>
        <div class="row"><label for="ip">IP地此：</label>
          <input type="text" name="ip" value="<{$res.ip}>" />
        </div>
         <div class="row"><label for="mask">掩码:</label>
          <input type="text" name="mask" value="<{$res.mask}>" />
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
        
         <div class="row">
            <label>绑定设备选择:</label>
            <div class="column column_25">
            <label for="addrList">可选绑定设备列表</label>
                <{html_options class='multiSelect' size="5" name="addrList" multiple="multiple" id="addrList"
                    output=$addrListArr values=$addrListArr}>
            </div>
            <div class="column column_15">
                <br/>
                <button class="standard floatLeft" onClick="moveToAddrGrpMember()"> &gt;&gt;
                </button>
                <br/><br/>
                <button class="standard floatLeft" onClick="moveToAddrList()"> &lt;&lt;
                </button>
            </div>
            <div class="column column_25">
                <label for="addrGrpMember">绑定设备列表</label>
                <{html_options class='multiSelect' size="5" multiple="multiple"
                    name="addrGrpMember[]" id="addrGrpMember"
                    output=$addrGrpMemberArr values=$addrGrpMemberArr}>
	        </div>
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
		$("#ipaddr_type").change(function(){
					var val=this.value;
					if(val==1){
						$('#ipaddr_type_div').show();
					}else{
						$('#ipaddr_type_div').hide();
					}
								  
				})
    });
</script>
