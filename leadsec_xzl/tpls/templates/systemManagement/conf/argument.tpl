<!-- tabs -->
<div class="tabs">
    <ul>
     <{foreach name=tabmenu item=limenu from=$tabmenu}>
       		<{if $subtype eq $limenu.cfgname}>
       			<li class='visitedTab' title="<{$mainmenu}>__<{$typemenu}>__<{$limenu.cfgname}>">
             <{else}>
             	<li title="<{$mainmenu}>__<{$typemenu}>__<{$limenu.cfgname}>">
            <{/if}>
            	<{$limenu.name}>
            	</li>
      <{/foreach}>
    </ul>
</div>
<div class="tabinfo">
    &nbsp;&nbsp;<img src="images/hi.gif" />&nbsp;
    <span id="show_text"><{$picmenu}></span>
</div>
<br class="clearFloat"/>
<!-- mainContent -->
<div class="mainContent">
 <table width="99%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
    <tr>
      <td width="18%"><{$label_0}>:</td>
      <td width="82%"><input type="text" name="inputtext" id="hostname" value="<{$hostname}>"/>&nbsp;&nbsp;&nbsp;( <{$explain_0}> )</td>
    </tr>
    <tr>
      <td></td>
      <td><input name="°´Å¥" type="button" value="<{$btn_0}>" width="50" id="ti_btn" /></td>
    </tr>
  </table>
</div>
<script type="text/javascript">
 $(document).ready(function() {
	$('#ti_btn').click(function(){
		var hostname=$.trim($('#hostname').val());
		$.get("control/system.php?act=hostname",{ hostname: hostname},
				  function(data){
					alert(data);
				  });
								
	})
 })
</script>

