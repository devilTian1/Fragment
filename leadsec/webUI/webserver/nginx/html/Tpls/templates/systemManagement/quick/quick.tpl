<script type="text/javascript" src="Public/js/jquery/desktop/jsLib/myLib.js"></script>
<link type="text/css" rel="stylesheet" href="Public/js/jquery/desktop/themes/default/css/desktop.css"/>
<link type="text/css" rel="stylesheet" href="Public/js/jquery/desktop/jsLib/jquery-smartMenu/css/smartMenu.css"/>
<script type="text/javascript" src="Public/js/jquery/desktop/jsLib/jquery.winResize.js"></script>
<script type="text/javascript" src="Public/js/jquery/desktop/jsLib/jquery-smartMenu/js/mini/jquery-smartMenu-min.js"></script>
<script type="text/javascript" src="Public/js/jquery/desktop/jsLib/desktop.js"></script>
<script type="text/javascript">
$(function(){
		   //myLib.progressBar();
		  // myLib.stopProgress();
		//这里本应从数据库读取json数据，这里直接将数据写在页面上			   
		  var deskIconData={
			  		'leshiwang':{
					   'title':'乐视网',
					   'url':'systemManagement/overview/overview.php'
						},
			        'kuwoMusic':{
					   'title':'酷我音乐盒',
					   'url':'systemManagement/conf/time.php'
						},
					'hudong':{
					   'title':'互动百科',
					   'url':'systemManagement/conf/params.php'
						},
					'dubianFim':{
					   'title':'豆瓣FIM',
					   'url':'systemManagement/conf/snmp.php'
						},
					'Pixlr':{
					   'title':'Pixlr',
					   'url':'systemManagement/overview/overview.php'
						},
					'qidian':{
					   'title':'起点中文',
					   'url':'systemManagement/overview/overview.php'
						},
					'qianqianMusic':{
					   'title':'千千音乐',
					   'url':'systemManagement/overview/overview.php'
						},
					'zfMeishi':{
					   'title':'主妇美食',
					   'url':'systemManagement/overview/overview.php'
						},
					'mglvyou':{
						'title':'芒果旅游',
					   'url':'systemManagement/overview/overview.php'
						},	
					'taobao':{
						'title':'淘宝网',
					   'url':'systemManagement/overview/overview.php'
						},	
					'qingshu':{
						'title':'情书',
					   'url':'systemManagement/overview/overview.php'
						},
					'fenghuang':{
					   'title':'凤凰网',
					   'url':'systemManagement/overview/overview.php'
						},	
					'zhongguancun':{
						'title':'中关村在线',
					   'url':'systemManagement/overview/overview.php'
						},
					'win35':{
						'title':'搜狐汽车',
					   'url':'systemManagement/overview/overview.php'
						},	
					'win36':{
						'title':'布丁电影票',
					   'url':'systemManagement/overview/overview.php'
						},	
					'win37':{
						'title':'中国数学资源网',
					   'url':'systemManagement/overview/overview.php'
						},
					'win38':{
						'title':'火影忍者漫画动画',
					   'url':'systemManagement/overview/overview.php'
						},	
					'win39':{
					   'title':'潇湘书院',
					   'url':'systemManagement/overview/overview.php'
						}  
			  };			   
 		   
		  //存储桌面布局元素的jquery对象
		   myLib.desktop.desktopPanel();
 		   
		   //初始化桌面背景
		   myLib.desktop.wallpaper.init("");
		   
		   //初始化任务栏
		   myLib.desktop.taskBar.init();
		   
		   //初始化桌面图标
		   myLib.desktop.deskIcon.init(deskIconData);
		   
		   //初始化桌面导航栏
		   myLib.desktop.navBar.init();
  		  
		  });		

//添加应用函数
function addIcon(data){
	 myLib.desktop.deskIcon.addIcon(data);
}
</script>
<div id="wallpapers"></div>
<div id="navBar"><a href="#" class="currTab" title="桌面1"></a><a href="#"  title="桌面2"></a><a href="#"  title="桌面3"></a><a href="#"  title="桌面4"></a></div>

<div id="desktopPanel">
<div id="desktopInnerPanel">
<ul class="deskIcon currDesktop">
  <li class="desktop_icon" id="leshiwang"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon4.png"/></span> <div class="text">乐视网<s></s></div> </li>
  <li class="desktop_icon" id="Pixlr"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon6.png"/></span> <div class="text">Pixlr<s></s></div> </li>
  <li class="desktop_icon" id="dubianFim"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon7.png"/></span> <div class="text">豆瓣FIM <s></s></div> </li>
  <li class="desktop_icon" id="kuwoMusic"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon8.png"/></span> <div class="text">酷我音乐盒 <s></s></div> </li>
  <li class="desktop_icon" id="qidian"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon9.png"/></span> <div class="text">起点中文 <s></s></div> </li>
  <li class="desktop_icon" id="hudong"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon10.png"/></span> <div class="text">互动百科 <s></s></div> </li>
  <li class="desktop_icon" id="qianqianMusic"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon5.png"/></span> <div class="text">千千音乐 <s></s></div> </li>
  <li class="desktop_icon add_icon" id="addIcon0"> <span class="icon"><img src="Public/js/jquery/desktop/themes/default/images/add_icon.png"/></span> <div class="text">添加 <s></s></div> </li>
</ul>

<ul class="deskIcon">
  <li class="desktop_icon" id="zfMeishi"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon13.png"/></span> <div class="text">主妇美食<s></s></div> </li>
  <li class="desktop_icon" id="mglvyou"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon12.png"/></span> <div class="text">芒果旅游<s></s></div> </li>
  <li class="desktop_icon" id="taobao"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon14.png"/></span> <div class="text">淘宝网<s></s></div> </li>
  <li class="desktop_icon" id="qingshu"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon15.png"/></span> <div class="text">情书 <s></s></div> </li>
  <li class="desktop_icon" id="fenghuang"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon16.png"/></span> <div class="text">凤凰网 <s></s></div> </li>
  <li class="desktop_icon" id="zhongguancun"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon17.png"/></span> <div class="text">中关村在线 <s></s></div> </li>
   <li class="desktop_icon add_icon" id="addIcon1" > <span class="icon"><img src="Public/js/jquery/desktop/themes/default/images/add_icon.png"/></span> <div class="text">添加 <s></s></div> </li>
</ul>


<ul class="deskIcon">
  <li class="desktop_icon" id="win35"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon18.png"/></span> <div class="text">搜狐汽车<s></s></div> </li>
  <li class="desktop_icon" id="win36"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon19.png"/></span> <div class="text">布丁电影票<s></s></div> </li>
  <li class="desktop_icon" id="win37"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon8.png"/></span> <div class="text">中国数学资源网 <s></s></div> </li>
  <li class="desktop_icon add_icon" id="addIcon2"> <span class="icon"><img src="Public/js/jquery/desktop/themes/default/images/add_icon.png"/></span> <div class="text">添加 <s></s></div> </li>
</ul>


<ul class="deskIcon">
  <li class="desktop_icon" id="win38"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon20.png"/></span> <div class="text">火影忍者漫画动画<s></s></div> </li>
  <li class="desktop_icon" id="win39"> <span class="icon"><img src="Public/js/jquery/desktop/icon/icon21.png"/></span> <div class="text">潇湘书院 <s></s></div> </li>
  <li class="desktop_icon add_icon" id="addIcon3"> <span class="icon"><img src="Public/js/jquery/desktop/themes/default/images/add_icon.png"/></span> <div class="text">添加 <s></s></div> </li>
</ul>
</div>
</div>
<script type="text/javascript" src="Public/js/systemManagement/quick/quick.js"></script>