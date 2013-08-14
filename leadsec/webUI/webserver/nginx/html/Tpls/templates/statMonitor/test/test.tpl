<link rel="stylesheet" href="Public/default/css/console.css" type="text/css" />
<script type="text/javascript" src="Public/js/statMonitor/test/console.js"></script>
<div style="overflow:scroll;height:100%" id="consolept" onblur="setFocusToEntryBox();" onclick="setFocusToEntryBox();">
    <span id="commandPrompt"></span><span id="commandContainer"></span><img src="Public/default/images/cursor.gif"  />
    <input type="text" id="entryBox" class="entryBox"/>
</div>
<script type="text/javascript">
$(document).ready(function(e) {
    $(".button").button();
	$('#commandPrompt').html('ac:\>');
	setFocusToEntryBox();
    $('#entryBox').keyup(function(e) {
        var textVal = $('#entryBox').val();
        var prompt  = $('#commandPrompt').html();
        var key=0;
        if (e == null) {
            key = event.keyCode;
        } else {
            key = e.which;
        }
        switch(key) {
            case 13:
                $('#commandContainer').html('');
                var tmpstr = "";
                if (textVal == "") {
                    tmpstr = prompt+textVal+'<br/>'+'ac:\>'; 
                    $('#commandPrompt').html(tmpstr); 
                    setFocusToEntryBox();
                } else {
                    tmpstr = prompt+textVal+'<br/>'; 
                    $('#commandPrompt').html(tmpstr);
                    filterParam(textVal);
                } 
                break;
            default :
                $('#commandContainer').html(textVal);
                break;
        }
    });
});
</script>
