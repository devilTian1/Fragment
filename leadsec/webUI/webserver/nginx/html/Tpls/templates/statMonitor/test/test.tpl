<link rel="stylesheet" href="Public/default/css/console.css" type="text/css" />
<script type="text/javascript" src="Public/js/statMonitor/test/console.js"></script>
<div style="overflow:scroll;height:100%" id="consolept" onblur="setFocusToEntryBox();" onclick="setFocusToEntryBox();">
  <p>Welcome to Web Console System</p>
  <p>Version 1.0</p>
  <br />
  <span id="commandPrompt"></span><span id="commandContainer"></span><img src="Public/default/images/cursor.gif"  />
  <input type="text" id="entryBox" class="entryBox"  onkeyup="keyEvent()">
</div>
<script type="text/javascript">
$(document).ready(function() {
    $(".button").button();
	$('#commandPrompt').html('utm:\>');
	setFocusToEntryBox();
});
</script>