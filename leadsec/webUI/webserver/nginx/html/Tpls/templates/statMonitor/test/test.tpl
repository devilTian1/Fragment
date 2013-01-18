<style>
	#consolept { 
		height:100; 
		border:0px; 
		margin:0px;
		background-color:#000000;
		color:#CCCCCC;
		font-family:FixedSys, Terminal, system, verdana, arial;
		font-size:12px;
		/*font-weight:bold;*/
	}
	
	a {
		text-decoration:none;
		color:#CCCCCC;
	}
	
	a:hover {
		text-decoration:none;
		color:#CCCCCC;
	}
	
	b {
		font-weight:normal;
	}
	
	strong {
		font-weight:normal;
	}
	
	.entryBox {
       	position:absolute;
		bottom:0px;
		left:-300px;
		border-color:white;
		border:1px;
	}
</style>
<table id="terminal" cellpadding="0" cellspacing="0" border="0" height="100%" width="100%">
    <tr>
        <td height="100%" width="100%" onClick="setFocusToEntryBox();" valign="top">
            <div style="width:100%;overflow:scroll;height:400px" id="consolept" onblur="setFocusToEntryBox();">
                <span id="commandPrompt"></span><span id="commandContainer"></span><img src="../imgs/cursor.gif"  />
                <input type="text" id="entryBox" class="entryBox"  onkeyup="keyEvent()">
            </div>
        </td>
    </tr>
</table>
<table class="column_95">
    <caption>网络调试工具</caption>
    <thead>
  	<tr>
        <th width="120">调试工具</th>
        <th class="tdbody">调试参数</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td><label><input name="test" type="radio" value="" />Ping</label></td>
      <td class="tdbody"><label>IP地址<input name="" type="text" /></label></td>
    </tr>
    <tr>
      <td><label><input name="test" type="radio" value="" />traceroute</label></td>
      <td class="tdbody"><label>IP地址<input name="" type="text" /></label></td>
    </tr>
    <tr>
      <td><label><input name="test" type="radio" value="" />tcpdump</label></td>
      <td class="tdbody"><label>网络接口
        <select name="select" id="select">
        </select>
      </label></td>
    </tr>
    <tr>
      <td><label><input name="test" type="radio" value="" />arp</label></td>
      <td class="tdbody">&nbsp;</td>
    </tr>
    <tr>
      <td><label><input name="test" type="radio" value="" />routeshow</label></td>
      <td class="tdbody">&nbsp;</td>
    </tr>
    <tr>
      <td></td>
      <td class="tdbody"><input type="button" class="button" name="button" id="button" value="开启调试" /></td>
    </tr>
   </tbody>
</table>
<script type="text/javascript">
$(document).ready(function() {
    $(".button").button();
});
</script>
