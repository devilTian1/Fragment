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
                    <div class="gapstatus gap_exact">
                    	<span>正常</span>
   				    </div>
                    <!--网闸异常-->
                   <!-- <div class="gapstatus gap_unusual">
                    	<span>异常</span>
   				    </div>-->
                    <!--网闸未启动-->
                    <!--<div class="gapstatus gap_nostart">
                    	<span>未启动</span>
   				    </div>-->
                    
             	    <div class="name">
                    	当前网闸:<span>主闸</span>
                    </div>
                </div>
                <div class="netcardtop">
                	<div class="networdcard netcard_unusual" title="eth0_0"></div>
                    <div class="networdcard netcard_exact" title="eth0_1"></div>
                    <div class="networdcard netcard_exact" title="eth0_2"></div>
                    <div class="networdcard netcard_unusual" title="eth0_3"></div>
                    <div class="networdcard netcard_unusual" title="eth0_4"></div>
                    <div class="networdcard netcard_unusual" title="eth0_5"></div>
                    <div class="networdcard netcard_exact" title="eth0_6"></div>
                    <div class="networdcard netcard_unusual" title="eth0_7"></div>
                    <div class="networdcard netcard_exact" title="eth0_8"></div>
                    <div class="networdcard netcard_exact" title="eth0_9"></div>
                    <div class="networdcard netcard_unusual" title="eth0_10"></div>
                    <div class="networdcard netcard_unusual" title="eth0_11"></div>
                    <div class="networdcard netcard_unusual" title="eth0_12"></div>
                    <div class="networdcard netcard_exact" title="eth0_13"></div>
                
                </div>
                <div class="netcardbottom">
                	<div class="networdcard netcard_unusual" title="eth1_0"></div>
                    <div class="networdcard netcard_exact" title="eth1_1"></div>
                    <div class="networdcard netcard_exact" title="eth1_2"></div>
                    <div class="networdcard netcard_unusual" title="eth1_3"></div>
                    <div class="networdcard netcard_unusual" title="eth1_4"></div>
                    <div class="networdcard netcard_unusual" title="eth1_5"></div>
                    <div class="networdcard netcard_exact" title="eth1_6"></div>
                    <div class="networdcard netcard_exact" title="eth1_7"></div>
                </div>
            </div>
            <!--从网闸-->
            <div id="chongBox">
                <div class="toptitle">
                	<div class="title">
                    	<img src="<{$smarty.const.THEME_PATH}>/images/imgha/icon_title.png" width="96" height="39" />
                    </div>
                     <!--网闸正常-->
                    <div class="gapstatus gap_exact">
                    	<span>正常</span>
   				    </div>
                    <!--网闸异常-->
                   <!-- <div class="gapstatus gap_unusual">
                    	<span>异常</span>
   				    </div>-->
                    <!--网闸未启动-->
                    <!--<div class="gapstatus gap_nostart">
                    	<span>未启动</span>
   				    </div>-->
             	    <div class="name">
                    	当前网闸:<span>从闸</span>
                    </div>
                </div>
                <div class="netcardtop">
                	<div class="networdcard netcard_unusual" title="eth2_1"></div>
                    <div class="networdcard netcard_exact" title="eth2_2"></div>
                    <div class="networdcard netcard_exact" title="eth2_3"></div>
                    <div class="networdcard netcard_unusual" title="eth2_4"></div>
                    <div class="networdcard netcard_unusual" title="eth2_5"></div>
                    <div class="networdcard netcard_unusual" title="eth2_6"></div>
                    <div class="networdcard netcard_exact" title="eth2_7"></div>
                    <div class="networdcard netcard_exact" title="eth2_8"></div>
                </div>
                <div class="netcardbottom">
                	<div class="networdcard netcard_unusual" title="eth3_0"></div>
                    <div class="networdcard netcard_exact" title="eth3_1"></div>
                    <div class="networdcard netcard_exact" title="eth3_2"></div>
                    <div class="networdcard netcard_unusual" title="eth3_3"></div>
                    <div class="networdcard netcard_unusual" title="eth3_4"></div>
                    <div class="networdcard netcard_unusual" title="eth3_5"></div>
                    <div class="networdcard netcard_exact" title="eth3_6"></div>
                    <div class="networdcard netcard_exact" title="eth3_7"></div>
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
<!--心跳线正常-->
  <div id="leftline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_l_exact.png" width="55" height="294" /></div>
  <div id="rightline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_r_exact.png" width="55" height="294" /></div>
<!--心跳线异常-->
 <!-- <div id="leftline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_l_unusual.png" width="55" height="294" /></div>
  <div id="rightline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_r_unusual.png" width="55" height="294" /></div>
--><!--心跳线未启动-->
<!--  <div id="leftline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_l_nostart.png" width="55" height="294" /></div>
  <div id="rightline"><img src="<{$smarty.const.THEME_PATH}>/images/imgha/heartbeat_r_nostart.png" width="55" height="294" /></div>
-->
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
	var size1=$("#mainBox .netcardtop .networdcard").size(),
		size2=$("#mainBox .netcardbottom .networdcard").size(),
		size3=$("#chongBox .netcardtop .networdcard").size(),
		size4=$("#chongBox .netcardbottom .networdcard").size(),
		sizeNum=max_int(size1,size2,size3,size4);
	$("#midBox_cen").width(45*sizeNum);
	$("#rightline").css({ left: (45*sizeNum+120)+"px"});
	$("#hotstandby").width(45*sizeNum+200);
	
	$(".networdcard").mouseover(function(){
		var id=$(this).attr("title"),
			me=$(this);
		$.get("Function/networkManagement/HA/ha.php", { act: "getstatus", id: id, rannum:Math.random() },
		  function(data){
			if(data==1){
				me.removeClass("netcard_exact netcard_nostart netcard_unusual").addClass("netcard_exact");
			}else if(data==-1){
				me.removeClass("netcard_exact netcard_nostart netcard_unusual").addClass("netcard_unusual");
			}else if(data==0){
				me.removeClass("netcard_exact netcard_nostart netcard_unusual").addClass("netcard_nostart");
			}
		  });
	});
});
</script>