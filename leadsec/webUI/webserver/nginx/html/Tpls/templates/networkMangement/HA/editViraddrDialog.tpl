<form action="Function/networkMangement/HA/viraddr.php" method="POST" id="editViraddrForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
    <fieldset>
        <!--<legend>别名设备</legend>-->     
         <div class="row"><label for="interface">网络接口:<em class="required">*</em></label>
          <select name="interface" id="interface" class="select">
          	 <{html_options output=$interface values=$interface selected=$res.interface }>
          </select>
        </div>
           
        <div class="row"><label for="destmask">地此/掩码:<em class="required">*</em></label>
          <select name="destmask" id="destmask" class="select">
          	<{html_options output=array('255.255.255.0','255.255.0.0','255.0.0.0','255.255.255.255') values=array('255.255.255.0','255.255.0.0','255.0.0.0','255.255.255.255') selected=$res.destmask|default: '255.255.255.0' }>
          </select>
        </div>
        <div class="row"><label for="remark">&nbsp;</label>
         	说明:地此/掩码为别名设备的地此掩码
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
        validateForm($("#editViraddrForm"));
    });
</script>
