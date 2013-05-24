<script type="text/javascript" src="Public/js/jquery/desktop/jsLib/myLib.js"></script>
<link type="text/css" rel="stylesheet" href="Public/js/jquery/desktop/themes/default/css/desktop.css"/>
<link type="text/css" rel="stylesheet" href="Public/js/jquery/desktop/jsLib/jquery-smartMenu/css/smartMenu.css"/>
<script type="text/javascript" src="Public/js/jquery/desktop/jsLib/jquery.winResize.js"></script>
<script type="text/javascript" src="Public/js/jquery/desktop/jsLib/jquery-smartMenu/js/mini/jquery-smartMenu-min.js"></script>
<script type="text/javascript" src="Public/js/jquery/desktop/jsLib/desktop.js"></script>
<!--[if IE 6]>
<script type="text/javascript" src="Public/js/jquery/desktop/jsLib/DD_belatedPNG_0.0.8a.js" ></script>
<script type="text/javascript">
	DD_belatedPNG.fix('#navBar,.icon img,.desktop_icon .text,.desktop_icon .text s');
</script>
<![endif]-->
<script type="text/javascript">
$(function(){
		   //myLib.progressBar();
		  // myLib.stopProgress();
		//这里本应从数据库读取json数据，这里直接将数据写在页面上			   
		 /* var deskIconData={
			  		'leshiwang':{
					   'title':'乐视网',
					   'url':'systemManagement/overview/overview.php'
						},
			  };*/
		  if($("#smartMenu_body").length>0){$("#smartMenu_body").remove();}//解决页面跳转后再跳回来时,右键函数不起作用bug
		  var deskIconData={
			  <{foreach from=$resall item=res_all name=res_all}>
				'<{$res_all.id}>':{
				   'title':'<{$res_all.title}>',
				   'pmenu':'<{$res_all.pmenu}>',
				   'smenu':'<{$res_all.smenu}>'
					}
					<{if $smarty.foreach.res_all.last}><{else}>,<{/if}>
			  <{/foreach}>
				
		  };
 		   
		  //存储桌面布局元素的jquery对象
		   myLib.desktop.desktopPanel();
 		   
		   //初始化桌面背景
		   myLib.desktop.wallpaper.init("");
		   
		   //初始化桌面图标
		   myLib.desktop.deskIcon.init(deskIconData);
		   
		   //初始化桌面导航栏
		   myLib.desktop.navBar.init();
  		  
		  });		

//添加应用函数
var addFlag_time=0;//判断是否正在处于添加快捷配置
function addIcon(data){
	 if(addFlag_time==1){return;}
	 var id=data.id;//得到当前的id
	 var index= $("#navBar").find("a").index($('.currTab'))+1;//判断是哪个桌面添加的
	 if(!$('ul.deskIcon').find("#"+data.id).size()){
		addFlag_time=1;
	 	$.post("Function/systemManagement/quick/quick.php", {type:'add',id:id, index:index});
		myLib.desktop.deskIcon.addIcon(data);
	 }
}
</script>
<div id="wallpapers"></div>
<div id="navBar"><a href="#" class="currTab" title="桌面1"></a><a href="#" title="桌面2"></a><a href="#" title="桌面3"></a><a href="#" title="桌面4"></a></div>

<div id="desktopPanel" style="overflow:hidden;">
<div id="desktopInnerPanel">
<!--<li class="desktop_icon" id="leshiwang"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon4.png"/></span> <div class="text">乐视网<s></s></div> </li>-->
  
<ul class="deskIcon currDesktop">
<{foreach from=$res1 item=res_1 name=res_1}>
  <li class="desktop_icon" id="<{$res_1.id}>"> <span class="icon"><img src="Public/js/jquery/desktop/icon/<{$res_1.img}>.png"/></span> <div class="text"><{$res_1.title}><s></s></div> </li>
<{/foreach}>
  <li class="desktop_icon add_icon" id="addIcon0"> <span class="icon"><img src="Public/js/jquery/desktop/themes/default/images/add_icon.png"/></span> <div class="text" style="color:#06C; font-weight:bold; letter-spacing:2px;">添加 <s></s></div> </li>
</ul>

<ul class="deskIcon">
<{foreach from=$res2 item=res_2 name=res_2}>
  <li class="desktop_icon" id="<{$res_2.id}>"> <span class="icon"><img src="Public/js/jquery/desktop/icon/<{$res_2.img}>.png"/></span> <div class="text"><{$res_2.title}><s></s></div> </li>
<{/foreach}>
   <li class="desktop_icon add_icon" id="addIcon1" > <span class="icon"><img src="Public/js/jquery/desktop/themes/default/images/add_icon.png"/></span> <div class="text">添加 <s></s></div> </li>
</ul>


<ul class="deskIcon">
<{foreach from=$res3 item=res_3 name=res_3}>
  <li class="desktop_icon" id="<{$res_3.id}>"><span class="icon"><img src="Public/js/jquery/desktop/icon/<{$res_3.img}>.png"/></span> <div class="text"><{$res_3.title}><s></s></div> </li>
<{/foreach}>
  <li class="desktop_icon add_icon" id="addIcon2"> <span class="icon"><img src="Public/js/jquery/desktop/themes/default/images/add_icon.png"/></span> <div class="text">添加 <s></s></div> </li>
</ul>


<ul class="deskIcon">
<{foreach from=$res4 item=res_4 name=res_4}>
  <li class="desktop_icon" id="<{$res_4.id}>"> <span class="icon"><img src="Public/js/jquery/desktop/icon/<{$res_4.img}>.png"/></span> <div class="text"><{$res_4.title}><s></s></div> </li>
<{/foreach}>
    <li class="desktop_icon add_icon" id="addIcon3"> <span class="icon"><img src="Public/js/jquery/desktop/themes/default/images/add_icon.png"/></span> <div class="text">添加 <s></s></div> </li>
</ul>
  
</div>
</div>
<script type="text/javascript" src="Public/js/systemManagement/quick/quick.js"></script>