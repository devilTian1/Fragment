/*-----------------------------------------------------------------------------
*作者:Muzi*lei , email:530624206@qq.com
*http://www.muzilei.com/
*version:1.0  , 时间：2011-09-14
*desktop需引入myLib.js创建命名空间，和jquery 及 jquery ui,contextMenu jquery插件
-----------------------------------------------------------------------------*/
//声明desktop空间,封装相关操作
myLib.NS("desktop");
myLib.desktop={
	winWH:function(){
		$('body').data('winWh',{'w':$(window).width(),'h':$(window).height()});
 	},
	desktopPanel:function(){
		$('body')
		.data('panel',{
					   'taskBar':{
					   '_this':$('#taskBar'),
					   'task_lb':$('#task_lb')
										},
					   'navBar':$('#navBar'),
					   'wallpaper':$('#wallpapers'),
					   'lrBar':{
					   '_this':$('#lr_bar'),	   
					   'default_app':$('#default_app'),
				       'start_block':$('#start_block'),
				       'start_btn':$('#start_btn'),
					   'start_item':$('#start_item'),
					   'default_tools':$('#default_tools')
							},		
					   'desktopPanel':{
							'_this':$('#desktopPanel'),
							'innerPanel':$('#desktopInnerPanel'),
							'deskIcon':$('ul.deskIcon')
							},
						'powered_by':$('a.powered_by')
						});
		},
	iconDataInit:function(data){
		 for(var a in data){
			 $("#"+a).data("iconData",data[a]);
			 }
		},	
	getMydata:function(){
		return $('body').data();
		},
	mouseXY:function(){
		var mouseXY=[];
		$(document).bind('mousemove',function(e){ 
			mouseXY[0]=e.pageX;
			mouseXY[1]=e.pageY;
           });
		return mouseXY;
		},	
	contextMenu:function(jqElem,data,menuName,textLimit){
		  var _this=this
		      ,mXY=_this.mouseXY();
		  
          jqElem
		  .smartMenu(data,{
            name: menuName,
			textLimit:textLimit,
			afterShow:function(){
				var menu=$("#smartMenu_"+menuName);
				var myData=myLib.desktop.getMydata(),
		            wh=myData.winWh;//获取当前document宽高
 				var menuXY=menu.offset(),menuH=menu.height(),menuW=menu.width();
				if(menuXY.top>wh['h']-menuH){
					menu.css('top',mXY[1]-menuH-2);
					}
				if(menuXY.left>wh['w']-menuW){
					menu.css('left',mXY[0]-menuW-2);
					}	
				}
           });
		  $(document.body).click(function(event){
			event.preventDefault(); 			  
			$.smartMenu.hide();
						  });
		}	
	}
/*----------------------------------------------------------------------------------	
//声明任务栏空间，任务栏相关js操作
----------------------------------------------------------------------------------*/
myLib.NS("desktop.taskBar");
myLib.desktop.taskBar={
	timer:function(obj){
		 var curDaytime=new Date().toLocaleString().split(" ");
		 obj.innerHTML=curDaytime[1];
		 obj.title=curDaytime[0];
		 setInterval(function(){obj.innerHTML=new Date().toLocaleString().split(" ")[1];},1000);
		},
	upTaskWidth:function(){
		var myData=myLib.desktop.getMydata()
		    ,$task_bar=myData.panel.taskBar['_this'];
		var maxHdTabNum=Math.floor($(window).width()/100);
		    //计算任务栏宽度
		    $task_bar.width(maxHdTabNum*100);	
			//存储活动任务栏tab默认组数
			$('body').data("maxHdTabNum",maxHdTabNum-2);
		},	
	init:function(){
		//读取元素对象数据
		var myData=myLib.desktop.getMydata();
 		var $task_lb=myData.panel.taskBar['task_lb']
		    ,$task_bar=myData.panel.taskBar['_this']
			,wh=myData.winWh;
 
		 var _this=this;
		 _this.upTaskWidth();
		 //当改变浏览器窗口大小时，重新计算任务栏宽度
		 $(window).wresize(function(){
						_this.upTaskWidth();   
								   });
  		 
 		},
	contextMenu:function(tab,id){
		var _this=this;
		 //初始化任务栏Tab右键菜单
		 var data=[
					[{
					text:"最大化",
					func:function(){
 						$("#myWin_"+tab.data('win')).find('a.winMaximize').trigger('click');
						}
					  },{
					text:"最小化",
					func:function(){
						myLib.desktop.win.minimize($("#myWin_"+tab.data('win')));
						}
						  }]
					,[{
					  text:"关闭",
					  func:function(){
						  $("#smartMenu_taskTab_menu"+id).remove();
 						  myLib.desktop.win.closeWin($("#myWin_"+tab.data('win')));
						  } 
					  }]
					];
		 myLib.desktop.contextMenu(tab,data,"taskTab_menu"+id,10);
		},
	addWinTab:function(text,id){
		var myData=myLib.desktop.getMydata();
 		var $task_lb=myData.panel.taskBar['task_lb']
		    ,$task_bar=myData.panel.taskBar['_this']
			,$navBar=myData.panel.navBar
 			,$navTab=$navBar.find("a")
		    ,tid="myWinTab_"+id
			,allTab=$task_lb.find('a')
			,curTabNum=allTab.size()
		    ,docHtml="<a href='#' id='"+tid+"'>"+text+"</a>";
			
			//添加新的tab
		    $task_lb.append($(docHtml));
			var $newTab=$("#"+tid);
			//右键菜单
			this.contextMenu($newTab,id);
			
			$task_lb
			.find('a.selectTab')
			.removeClass('selectTab')
			.addClass('defaultTab');
			 
			$newTab
			.data('win',id)
			.addClass('selectTab')
			.click(function(){
					var win=$("#myWin_"+$(this).data('win')),
					    tabId=this.id,
						iconId=tabId.split("_")[1],
						desk=$("#"+iconId).parent(),
 						i=desk.index("ul.deskIcon");	//判断窗口在那个桌面区域
 				    
					if(i<0){
						i=$("#"+iconId).data("currPanel");
						}
						
 					//如果是当前桌面
					if(desk.is(".currDesktop")){
						if(win.is(".hideWin")){
						//win.show();
						win.css({"left":win.position().left+10000,"visibility":"visible"}).removeClass("hideWin");
						
 						$(this).removeClass('defaultTab').addClass('selectTab');//当只有一个窗口时
						myLib.desktop.win.switchZindex(win);
  						}else{
							if($(this).hasClass('selectTab')){
							myLib.desktop.win.minimize(win);
  							}else{
								myLib.desktop.win.switchZindex(win);
								} 
							  }
							  
				    //如果不在当前窗口			  
				    }else{
					 if(win.is(".hideWin")){
						//win.show();
						win.css({"left":win.position().left+10000,"visibility":"visible"}).removeClass("hideWin");
						
 						$(this).removeClass('defaultTab').addClass('selectTab');//当只有一个窗口时
						myLib.desktop.win.switchZindex(win);
  						}	
					 $navTab.eq(i).trigger("click");
							}
 							  
 							});
			
			$('body').data("topWinTab",$newTab);
			
			//当任务栏活动窗口数超出时
			if(curTabNum>myData.maxHdTabNum-1){
				var LeftBtn=$('#leftBtn')
				    ,rightBtn=$('#rightBtn')
					,bH;
				
                LeftBtn
				.show()
				.find("a")
				.click(function(){
							        var pos=$task_lb.position();
									if(pos.top<0){
										$task_lb.animate({
                                                  "top":pos.top+40
                                                      }, 50);
										}
									 });
				
				rightBtn
				.show()
				.find("a")
				.click(function(){
									var pos=$task_lb.position(),h=$task_lb.height(),row=h/40;
									if(pos.top>(row-1)*(-40)){
									$task_lb.animate({
                                                  "top": pos.top-40
                                                      }, 50); 
									}
									   });
				
				$task_lb.parent().css("margin","0 100");
				}
	 
		},
	delWinTab:function(wObj){
		var myData=myLib.desktop.getMydata()
 		    ,$task_lb=myData.panel.taskBar['task_lb']
			,$task_bar=myData.panel.taskBar['_this']
			,LeftBtn=$('#leftBtn')
			,rightBtn=$('#rightBtn')
		    ,pos=$task_lb.position();
			
		this.findWinTab(wObj).remove();
		
		var newH=$task_lb.height();
		if(Math.abs(pos.top)==newH){
			LeftBtn.find('a').trigger("click");
			}
		if(newH==40){
			LeftBtn.hide();
			rightBtn.hide();
			$task_lb.parent().css("margin",0);
			}	
		},
	findWinTab:function(wObj){
		var myData=myLib.desktop.getMydata(),
		    $task_lb=myData.panel.taskBar['task_lb'],
		    objTab;
		    $task_lb.find('a').each(function(index){
								var id="#myWin_"+$(this).data("win");		 
								if($(id).is(wObj)){
									objTab=$(this);
									}		 
 										 });
		    return objTab;
		}	
	}
//navbar
myLib.NS("desktop.navBar");
myLib.desktop.navBar={
	init:function(){
		 var myData=myLib.desktop.getMydata()
			 ,$navBar=myData.panel.navBar
			 ,$innerPanel=myData.panel.desktopPanel.innerPanel
			 ,$navTab=$navBar.find("a")
			 ,$deskIcon=myData.panel.desktopPanel['deskIcon']
			 ,desktopWidth=$deskIcon.width()
			 ,lBarWidth=myData.panel.lrBar["_this"].outerWidth();
			 
			 $navBar
			 .draggable({
 					scroll:false
						});
			 
			 $navTab
			 .droppable({
				scope:'a',
				over:function(event,ui){
					$(this).trigger("click");
					var i=$navTab.index($(this));
					//ui.draggable
					//.css({left:event.pageX+$deskIcon.width()*i});
 					},
                drop: function(event,ui) {
				var i=$navTab.index($(this));	
 				ui.draggable
				.addClass("desktop_icon")
				.insertBefore($deskIcon.eq(i).find(".add_icon"))
				.find("span")
				.addClass("icon"); 
                myLib.desktop.deskIcon.init();
				//myLib.desktop.lrBar.init();
					}
			 })
			 .click(function(event){
					event.preventDefault();
					event.stopPropagation();
					var i=$navTab.index($(this));
 					myLib.desktop.deskIcon.desktopMove($innerPanel,$deskIcon,$navTab,500,desktopWidth+lBarWidth,i);
							 });
		}
	};

//桌面背景
myLib.NS("desktop.wallpaper");
myLib.desktop.wallpaper={
	init:function(imgUrl){
		    //将当前窗口宽度和高度数据存储在body元素上
		    myLib.desktop.winWH();
		    var myData=myLib.desktop.getMydata()
		         ,winWh=myData.winWh
			     ,wallpaper=myData.panel.wallpaper
				 ,_this=this;
 				 
				 if(imgUrl!==null){
				 wallpaper.html("<img src='"+imgUrl+"'></img>");
			     var img=wallpaper.find("img");	
 				
					 myLib.getImgWh(imgUrl,function(imgW,imgH){
 								 if(imgW<=winWh.w){
								      img.css('width',winWh.w);
									}else{
										img.css({"margin-left":-(imgW-winWh.w)/2});
										}
								if(imgH<=winWh.h){
								img.css('height',winWh.h);
									}else{
										img.css({"margin-top":-(imgH-winWh.h)/2});
										}	
												});	
				 }
				 
		//如果窗口大小改变，更新背景布局大小
		 window.onresize=function(){
     							_this.init(imgUrl);
								};
		}
	};

//桌面图标区域
myLib.NS("desktop.deskIcon");
myLib.desktop.deskIcon={
	addIcon:function(data){
		var _this=this;
		if(!$('ul.deskIcon').find("#"+data.id).size()){
		var iconHtml="<li class='desktop_icon' id='"+data.id+"'><span class='icon'><img src='"+data.iconSrc+"'/></span><div class='text'>"+data.title+"<s></s></div></li>"; 
		$(iconHtml).insertBefore("ul.currDesktop .add_icon");
		_this.init();
		$("#"+data.id).data("iconData",{
							'title':data.title,
					        'url':data.url
							});
		
		}
	},
	delIcon:function(elem){
		var _this=this;
		elem.remove();
		_this.init();
	},
 	//桌面图标排列
	arrangeIcons:function(desktop){
          var myData=myLib.desktop.getMydata()
		     ,winWh=myData.winWh
			 ,$navBar=myData.panel.navBar
			 ,navBarHeight=$navBar.outerHeight()
		     //计算一共有多少图标
		     ,iconNum=desktop.find("li").size();
			
		 //存储当前总共有多少桌面图标
		 desktop.data('deskIconNum',iconNum);
		 
		 var gH=120;//一个图标总高度，包括上下margin
		 var gW=120;//图标总宽度,包括左右margin
		 var rows=Math.floor((winWh['h']-navBarHeight-75)/gH);
		 var cols=Math.ceil(iconNum/rows);
		 var curcol=0,currow=0;

		 desktop.
		 find("li")
		 .css({
				   "position":"absolute",
				   "margin":0,
				   "left":function(index,value){
					       var v=curcol*gW+30;
					           if((index+1)%rows==0){
							       curcol=curcol+1;
					              }
						   return v;	 
 						},
					"top":function(index,value){
 							var v=(index-rows*currow)*gH+20;
								if((index+1)%rows==0){
									 currow=currow+1;
									}
						    return v;
							}});
		},
	upDesktop:function($deskIcon,$deskIconBlock,$innerPanel,$deskIconNum,navBarHeight,lBarWidth){
		 var myData=myLib.desktop.getMydata()
		    ,winWh=myData.winWh
		    ,w=winWh['w']-lBarWidth
		    ,h=(winWh['h']-75-navBarHeight)
		    ,_this=this;
		 
		//设置桌面图标容器元素区域大小
		 $innerPanel.css({"width":((w+lBarWidth)*$deskIconNum)+"px","height":h+"px"});
		 $deskIcon.css({"width":w+"px","height":h+"px",'margin-right':lBarWidth});
		 $deskIconBlock.css({"width":w+"px","height":h+"px","margin-top":navBarHeight,'margin-left':lBarWidth+'px','margin-bottom':75+"px"});
		 
		 $deskIcon.each(function(){
				_this.arrangeIcons($(this));
				
				$(this)
				.droppable({
				scope:'a',
                drop: function(event,ui) {
 				ui.draggable
				.addClass("desktop_icon")
				.insertBefore($(this).find(".add_icon"))
				.find("span")
				.addClass("icon"); 
                _this.init();
				//myLib.desktop.lrBar.init();
					}
					});
								 });
		},
	desktopMove:function($innerPanel,$deskIcon,$navTab,dates,moveDx,nextIndex){
		 $innerPanel
		 .stop()
		 .animate({
				 left:-(nextIndex)*moveDx
				},dates,function(){
							$deskIcon
							.removeClass("currDesktop")
							.eq(nextIndex)
							.addClass("currDesktop");
												 
							$navTab
							.removeClass("currTab")
							.eq(nextIndex)
							.addClass("currTab");
 							});
		},	
	init:function(iconData){
 		 
 		 var myData=myLib.desktop.getMydata()
		    ,winWh=myData.winWh
			,$deskIconBlock=myData.panel.desktopPanel['_this']
			,$innerPanel=myData.panel.desktopPanel.innerPanel
			,$deskIcon=myData.panel.desktopPanel['deskIcon']
			,$deskIconNum=$deskIcon.size()
			,$navBar=myData.panel.navBar
			,navBarHeight=$navBar.outerHeight()
			,$navTab=$navBar.find("a")
			,lBarWidth=myData.panel.lrBar["_this"].outerWidth()
			,_this=this;
  		 
		 _this.upDesktop($deskIcon,$deskIconBlock,$innerPanel,$deskIconNum,navBarHeight,lBarWidth);
		
		 //如果窗口大小改变，则重新排列图标
		 $(window).wresize(function(){
							myLib.desktop.winWH();//更新窗口大小数据
							_this.upDesktop($deskIcon,$deskIconBlock,$innerPanel,$deskIconNum,navBarHeight,lBarWidth);
   								   });
 		 //附加data数据
		 myLib.desktop.iconDataInit(iconData);
		 //给添加按钮附件data数据
		 $deskIcon.find("li.add_icon").data("iconData",{
						'title':"添加应用",
					    'url':'yingyong.html',
					    'winWidth':600,
					    'winHeight':400
						});
 		 
		 //桌面可使用鼠标拖动切换
		 var timeStart,timeEnd,dxStart,dxEnd;
		 
		 $innerPanel
		 .draggable({
					axis:'x',
					start:function(event,ui){
						 
						$(this).css("cursor","move");
						timeStart=new Date().getTime();
						dxStart=event.pageX;
						},
					stop:function(event,ui){
						$(this).css("cursor","inherit");
						timeEnd=new Date().getTime();
						dxEnd=event.pageX;
						var timeCha=timeEnd-timeStart
						    ,dxCha=dxEnd-dxStart
							,currDesktop=$(this).find("ul.currDesktop")
							,deskIndex=$deskIcon.index(currDesktop)
							,moveDx=$deskIcon.width()+lBarWidth
							,dates=1000+timeCha;
						
						//左移	
						if(dxCha < -150 && deskIndex<3){
 						_this.desktopMove($(this),$deskIcon,$navTab,dates,moveDx,deskIndex+1);
						//右移	 
 						}else if(dxCha > 150 && deskIndex>0){
 						_this.desktopMove($(this),$deskIcon,$navTab,dates,moveDx,deskIndex-1);
 						}else{
						$(this)
						.animate({
								left:-(deskIndex)*moveDx
								},500);
						}
 						}	
					});
		 
 		 
		 //单击添加应用
		 $deskIcon
		 .find("li.add_icon")
		 .click(function(){
						   var screenNum=$deskIcon.size(),id=this.id;
						   openNewQuickDialog();
						   /*for(var i=0;i<screenNum;i++){
							   var w=$("#myWin_addIcon"+i);
							    
							   if(w.size() && id!=="addIcon"+i){
								   myLib.desktop.win.closeWin(w);
								   }
							   }
						   
						   var data=$(this).data("iconData"),id=this.id;
							myLib.desktop.win.newWin({
													 WindowTitle:data.title,
													 iframSrc:data.url,
													 WindowsId:id,
													 WindowAnimation:'none', 
													 WindowWidth:data.winWidth,
													 WindowHeight:data.winHeight
 													 });*/
						 });
		 
		 //图标鼠标经过效果
		 $deskIcon
		 .find("li")
 		 .hover(function(){
						 $(this).addClass("desktop_icon_over");
						 },
						 function(){
							  $(this).removeClass("desktop_icon_over");
							 })
		 .not("li.add_icon")
 		 //双击图标打开窗口
		 .click(function(){
						   var data=$(this).data("iconData"),id=this.id;
						   showPageByAjax(data.url);
 							})
 		 .draggable({
					helper: "clone",
					scroll:false,
					opacity: 0.7,
					scope:'a',
					appendTo: 'body' ,
					zIndex:91,
					start: function(event, ui) {
 						ui.helper.removeClass("desktop_icon_over");
						} 
					})
		 .droppable({
				scope:'a',
                drop: function(event,ui) {
 				ui.draggable
				.unbind("dblclick")
				.addClass("desktop_icon")
				.insertBefore($(this))
				.find("span")
				.addClass("icon"); 
                _this.init();
				//myLib.desktop.lrBar.init();
					}
           });
		 
 		 
		 //初始化桌面右键菜单
		 var data=[
					[{
					text:"打开模块",
					func:function(){
						 var data=$(this).data("iconData"),id=this.id;
						   showPageByAjax(data.url);
						}
						}]
					,[{
					  text:"卸载模块",
					  func:function(){
						  myLib.desktop.deskIcon.delIcon($(this));
						  var id=$(this).attr('id');
	 					  $.post("Function/systemManagement/quick/quick.php", {type:'del',id:id});
						 // alert("根据"+id+"来改变服务器数据");
						} 
					  }]
					];
		 myLib.desktop.contextMenu($deskIcon.find("li.desktop_icon").not("li.add_icon"),data,"body",10);
		// myLib.desktop.contextMenu($(document.body),data,"body",10);
		}
	}
