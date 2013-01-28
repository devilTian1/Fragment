<style type="text/css">
	#consolept{
		margin:0px;
		background-color:#000000;
		color:#CCCCCC;
		font-family:FixedSys, Terminal, system, verdana, arial;
		font-size:12px;
	}
	.entryBox {
       	position:absolute;
		bottom:0px;
		left:-300px;
		border-color:white;
		border:1px;
	}
</style>

      	<div style="overflow:scroll;height:100%" id="consolept" onblur="setFocusToEntryBox();" onclick="setFocusToEntryBox();">
					<p>Welcome to Web Console System</p>
					<p>Version 1.0</p>
					<p>Author: Huna</p>
					<p>Email: huna@leadsec.com</p>
          <br />
                    <span id="commandPrompt"></span><span id="commandContainer"></span><img src="../imgs/cursor.gif"  />
                    <input type="text" id="entryBox" class="entryBox"  onkeyup="keyEvent()">
		</div>
<script type="text/javascript">
$(document).ready(function() {
    $(".button").button();
	$('#commandPrompt').html('utm:\>');
	setFocusToEntryBox();
	//点击按钮时处理
	$('#startTestBtn').click(function(){
		var test=$("input[name='test']:checked").val();	
		switch(test){
			case "ping":
				var ip_ping=$("#ip_ping").val(),
					cmd="ping "+ip_ping;
					sendMessages(cmd);
				break;
			case "traceroute":
				alert("traceroute");
				break;
			case "tcpdump":
				alert("tcpdump");
				break;
			case "arp":
				alert("arp");
				break;
			case "routeshow":
				alert("routeshow");
				break;
			default:
				alert('error');
			break
		}
	});
});
//键盘处理
 function keyEvent()
 {
	// alert('sdfsdf');
	 var command=document.getElementById('commandContainer');
	 var text=document.getElementById('entryBox');
	 var prompt=document.getElementById('commandPrompt');
	 var key=0;
	 document.onkeyup = function(e){  
		 if(e==null){
		 key=event.keyCode;
	 }else{
		 key=e.which;
	 }
	 switch(key)
	 {
	   case 13:
		 command.innerHTML='';
		 prompt.innerHTML+=text.value+'<br/>'+'utm:\>'; 
		 var cmd=encodeURIComponent(text.value);
		 sendMessages(cmd); 
		 setFocusToEntryBox();
		 break;    
	   default :
		 command.innerHTML=text.value;
		 break;
	 }
	 }
 }  
 //调整显示位置以及聚焦
 function setFocusToEntryBox()
 {
	document.getElementById('consolept').scrollTop = document.getElementById('consolept').scrollHeight+200;
	$("#entryBox").focus();
}
//向后台发送处理结果数据
function sendMessages(cmd){
	if(cmd == "cls"){
        var prompt=document.getElementById('commandPrompt');
            prompt.innerHTML='utm:\>';
    }else{
	    document.getElementById('entryBox').value='';
		$.post("test.php", {cmd: cmd},
		   function(cmdstr){
				//alert(cmdstr);
				processRequest(cmdstr);
		   });
	   }
}
//处理结果
function processRequest(cmdstr){
	 var command=document.getElementById('commandPrompt');
	 if(cmdstr == "-1"||cmdstr=="0")
	 {
	  	setFocusToEntryBox();
	 }else{
	   var arr1 = new Array();
	   arr1 = cmdstr.split("\n");
	   if(arr1.length > 2)
	   {
		  cmdstr = arr1.join("<br/>");
	   }
	   command.innerHTML+=cmdstr+"<br/>"+'utm:\>'; 
	   setFocusToEntryBox();
	 }
}
</script>
