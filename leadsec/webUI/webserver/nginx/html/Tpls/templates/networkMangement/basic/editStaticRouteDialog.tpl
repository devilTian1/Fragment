<form action="Function/networkMangement/basic/staticRoute.php" method="POST" id="editStaticRouteForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <!--<legend>别名设备</legend>-->
		<div class="row">
          <label for="destip">目的地此:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />
        </div>
        
        <div class="row"><label for="destmask">掩码:</label>
          <select name="destmask" id="destmask" class="select">
          	<{html_options output=array('255.255.255.0','255.255.0.0','255.0.0.0','255.255.255.255') values=array('255.255.255.0','255.255.0.0','255.0.0.0','255.255.255.255') selected=$res.destmask|default: '255.255.255.0' }>
          </select>
        </div>
        
        <div class="row">
          <label for="nexthopip">下一跳地此:<em class="required">*</em></label>
          <input type="text" name="nexthopip" value="<{$res.nexthopip}>" />
        </div>
        
        <div class="row"><label for="interface">网络接口:<em class="required">*</em></label>
          <select name="interface" id="interface" class="select">
          	<{html_options output=array('自适应','全双工','半双工') values=array(0,1,2) selected=$res.interface}>
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
        validateForm($("#editStaticRouteForm"));
    });
</script>
