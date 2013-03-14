<link type="text/css" rel="stylesheet" href="<{$smarty.const.THEME_PATH}>/css/ha.css"/>
<div id="hotstandby">
   <!--中间部分-->
   <div id="midBox">
     <!--左边部分-->
   		<div id="midBox_left"></div>
        <div id="midBox_cen">
        	<!--主网闸-->
            <div id="mainBox">
             	<div class="toptitle">
                	<div class="title">
                    	<img src="<{$smarty.const.THEME_PATH}>/images/imgha/icon_title.png" width="96" height="39" />
                    </div>
                    <!--网闸正常-->
                    <{if $master_in.status eq "正常"}>
                        <div class="gapstatus gap_exact">
                            <span><{$master_in.status}></span>
                        </div>
                    <{elseif $master_in.status eq "异常"}>
                    <!--网闸异常-->
                    <div class="gapstatus gap_unusual">
                    	<span><{$master_in.status}></span>
   				    </div>
                    <!--网闸未启动-->
                    <{else}>
                    <div class="gapstatus gap_nostart">
                    	<span><{$master_in.status}></span>
   				    </div>
                    <{/if}>
             	    <div class="name">
                    	当前网闸:<span><{$master_in.hastatus}></span>
                    </div>
                </div>
                <div class="netcardtop">
                	<{foreach from=$master_in.ifstatus item=val key=key}>
						<div id="<{$key}>_master_in" class="networkCard  
                        	<{if $val.enable eq 0}>
                            	 netcard_nostart
                            <{elseif $val.active eq 1}>					
                        		 netcard_exact
                            <{else}>
                            	netcard_unusual
                            <{/if}>"
                        <{if $key == 'fe1'}> 
                        title="主闸内网HA端口<{$key}><br/>CPU使用率:<{$master_in.cpu}><br/>内存使用率:<{$master_in.mem}>"
                        <{/if}>></div>
					<{/foreach}>
                	<!--<div class="networkCard netcard_unusual" title="eth0_0"></div>-->
                </div>
                <div class="netcardbottom">
                	<{foreach from=$master_out.ifstatus item=val key=key}>
						<div id="<{$key}>_master_out" class="networkCard  
                        	<{if $val.enable eq 0}>
                            	 netcard_nostart
                            <{elseif $val.active eq 1}>					
                        		 netcard_exact
                            <{else}>
                            	netcard_unusual
                            <{/if}>"
                        <{if $key == 'fe1'}> 
                        title="主闸外网HA端口<{$key}><br/>CPU使用率:<{$master_out.cpu}><br/>内存使用率:<{$master_out.mem}>"
                        <{/if}>></div>
					<{/foreach}>
                </div>
            </div>
            <!--从网闸-->
            <div id="chongBox">
                <div class="toptitle">
                	<div class="title">
                    	<img src="<{$smarty.const.THEME_PATH}>/images/imgha/icon_title.png" width="96" height="39" />
                    </div>
                     <!--网闸正常-->
                    <{if $slave_in.status eq "正常"}>
                        <div class="gapstatus gap_exact">
                            <span><{$slave_in.status}></span>
                        </div>
                    <{elseif $slave_in.status eq "异常"}>
                    <!--网闸异常-->
                    <div class="gapstatus gap_unusual">
                    	<span><{$slave_in.status}></span>
   				    </div>
                    <!--网闸未启动-->
                    <{else}>
                    <div class="gapstatus gap_nostart">
                    	<span><{$slave_in.status}></span>
   				    </div>
                    <{/if}>
             	    <div class="name">
                    	当前网闸:<span><{$slave_in.hastatus}></span>
                    </div>
                </div>
                <div class="netcardtop">
                	<{foreach from=$slave_in.ifstatus item=val key=key}>
						<div id="<{$key}>_slave_in" class="networkCard  
                        	<{if $val.enable eq 0}>
                            	 netcard_nostart
                            <{elseif $val.active eq 1}>					
                        		 netcard_exact
                            <{else}>
                            	netcard_unusual
                            <{/if}>"
                        <{if $key == 'fe1'}> 
                        title="备闸内网HA端口<{$key}><br/>CPU使用率:<{$slave_in.cpu}><br/>内存使用率:<{$slave_in.mem}>"
                        <{/if}>></div>
					<{/foreach}>
                </div>
                <div class="netcardbottom">
                	<{foreach from=$slave_out.ifstatus item=val key=key}>
						<div id="<{$key}>_slave_out" class="networkCard  
                        	<{if $val.enable eq 0}>
                            	 netcard_nostart
                            <{elseif $val.active eq 1}>					
                        		 netcard_exact
                            <{else}>
                            	netcard_unusual
                            <{/if}>"
                        <{if $key == 'fe1'}> 
                        title="备闸外网HA端口<{$key}><br/>CPU使用率:<{$slave_out.cpu}><br/>内存使用率:<{$slave_out.mem}>"
                        <{/if}>></div>
					<{/foreach}>
                </div>
            </div>
        </div>
     <div id="midBox_right"></div>
</div>
 <ul id="tipinfo">
    <li class="gap_exact">正常</li>
    <li class="gap_unusual">异常</li>
    <li class="gap_nostart">未启动</li>
 </ul>
 
 <!--外网-->
<{if $linkstatus.out_to_out eq 1}>
<!--心跳线正常-->
   <div id="leftline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_l_exact.png" width="55" height="294" /></div>
<{elseif $linkstatus.out_to_out eq 0}>
<!--心跳线未启动-->
   <div id="leftline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_l_nostart.png" width="55" height="294" /></div>
<{else}> 
<!--心跳线异常-->
	<div id="leftline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_l_unusual.png" width="55" height="294" /></div>
<{/if}>
  
<!--内网-->
<{if $linkstatus.in_to_in eq 1}> 
<!--心跳线正常-->
   <div id="rightline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_r_exact.png" width="55" height="294" /></div>
<{elseif $linkstatus.in_to_in eq 0}> 
<!--心跳线未启动-->
	<div id="rightline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_r_nostart.png" width="55" height="294" /></div>
<{else}>
<!--心跳线异常-->
	<div id="rightline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_r_unusual.png" width="55" height="294" /></div>
<{/if}>
</div>

<!--[if IE 6]>
<script type="text/javascript">
	DD_belatedPNG.fix('.gap_exact,.gap_nostart,.gap_unusual');
</script>
<![endif]-->
<script type="text/javascript">
function max_int(){
	var maxNum=0;
	for(var i=0;i<arguments.length;i++){
		if(arguments[i]>maxNum){
			maxNum=arguments[i];
		}
	}
	return maxNum;
}

$(document).ready(function() {
	var size1=$("#mainBox .netcardtop .networkCard").size(),
		size2=$("#mainBox .netcardbottom .networkCard").size(),
		size3=$("#chongBox .netcardtop .networkCard").size(),
		size4=$("#chongBox .netcardbottom .networkCard").size(),
		sizeNum=max_int(size1,size2,size3,size4);
	$("#midBox_cen").width(45*sizeNum);
	$("#rightline").css({ left: (45*sizeNum+120)+"px"});
	$("#hotstandby").width(45*sizeNum+200);

    var intval;
	$(".networkCard[id^='fe1_']").mouseover(function(){
        var me = $(this);
        intval = setTimeout(function() {
        $('#tooltip>h3').html(getMessage('loading'));
        var id = me.attr('id');
		$.get("Function/networkManagement/HA/ha.php", { act: "getstatus", id: id, rannum:Math.random() },
		  function(data) {
			if(data.stat == 1){
				me.removeClass("netcard_exact netcard_nostart netcard_unusual").addClass("netcard_exact");
			} else if(data.stat == -1){
				me.removeClass("netcard_exact netcard_nostart netcard_unusual").addClass("netcard_unusual");
			} else if(data.stat == 0){
				me.removeClass("netcard_exact netcard_nostart netcard_unusual").addClass("netcard_nostart");
			}
            me.attr('title', data.msg);  
            me.tooltip({content: data.msg});
            $('#tooltip>h3').html(data.msg);
		  }, 'json');
        }, 1000);
	}).mouseout(function() {
        window.clearTimeout(intval);
    });
    $('.networkCard').tooltip();
});
</script>
