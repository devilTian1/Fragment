<form action="Function/networkManagement/basic/staticRoute.php" method="POST" id="editStaticRouteForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
    <fieldset>
        <!--<legend>别名设备</legend>-->
        <div class="hide" id="summary">
        </div>
        <div class="row">
          <label for="ip">目的地址:<em class="required">*</em></label>
          <input class="w150" type="text" name="ip" value="<{$res.destip}>" /><label class="maskLabel">/</label>
          <input class="w150" type="text" name="netmask" value="<{$res.destmask}>"/>
        </div>
        <div class="row">
          <label for="nexthopip">下一跳地址:<em class="required">*</em></label>
          <input class="w150" type="text" name="nexthopip" value="<{$res.nexthopip}>" />
        </div>
        
        <div class="row"><label for="interface">网络接口:<em class="required">*</em></label>
          <select name="interface" id="interface" class="select">
          	 <{html_options output=$interface values=$interface selected=$res.interface }>
          </select>
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
        validateForm($("#editStaticRouteForm"), 'summary');
    });
</script>
