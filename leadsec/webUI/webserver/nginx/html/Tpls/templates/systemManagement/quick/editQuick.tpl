<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<{$smarty.const.THEME_PATH}>/css/quicktab.css" type="text/css" />
<title></title>
<style type="text/css">
<!--
*{
	margin:0;
	padding:0;
	}
body,td,th {
	font-size: 12px;
	color: #333;
	background-color:#FFF
}
a {
	font-size: 12px;
	color: #666;
}
a:visited {
	color: #666;
}
a:hover {
	color: #666;
}
a:active {
	color: #666;
}
ul{
	list-style:none;
	}

.listIcon{
	width:90%;
	overflow:hidden;
	zoom:-1;
	margin:10px auto;
	}
.listIcon li{
	height:110px;
	width:64px;
	float:left;
	margin:5px 10px;
	}
.listIcon li a.img{
	display:block;
	width:64px;
	height:64px;
	}	
.listIcon li a.add{
	display:block;
	height:25px;
	background-color:#F0F0F0;
	text-align:center;
	line-height:25px;
	}	
.listIcon li span{
	height:30px;
	line-height:30px;
	text-align:center;
	display:block
	}	
-->
</style></head>
<body>
<div id="con">
    <UL id="tags">
      <li class="selectTag"><A onClick="selectTag('tagContent0',this)" href="javascript:void(0)">系统管理</A> </li>
      <li><A onClick="selectTag('tagContent1',this)" href="javascript:void(0)">网络管理</A> </li>
      <li><A onClick="selectTag('tagContent2',this)" href="javascript:void(0)">资源配置</A> </li>
      <li><A onClick="selectTag('tagContent3',this)" href="javascript:void(0)">客户端</A> </li>
      <li><A onClick="selectTag('tagContent4',this)" href="javascript:void(0)">服务端</A> </li>
      <li><A onClick="selectTag('tagContent5',this)" href="javascript:void(0)">应用防护 </A></li>
      <li><A onClick="selectTag('tagContent6',this)" href="javascript:void(0)">状态监控 </A></li>
      <li><A onClick="selectTag('tagContent7',this)" href="javascript:void(0)">日志与报表 </A></li>
    </UL>
    <div id="tagContent">
        <div class="tagContent selectTag" id="tagContent0">
        	 <div class="dhooo_tab">
                 <ul class="tab_btn" id="myTab_btns1">
                      <li class="hot">系统概览</li>
                      <li>系统配置</li>
                      <li>管理员设置</li>
                      <li>系统维护</li>
                 </ul>
                <div class="main" id="main1">
                    <div class="shell">
                        <ul id="content1">
                         <li>
                         	<ul class="listIcon">
                                  <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>系统概览</span><a href="#" class="add" id="123" title="系统概览">添加应用</a></li>
                                
                            </ul>
                         </li>
                         <li>
                         	<ul class="listIcon">
                                  <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>日期时间</span><a href="#" class="add" id="123" title="日期时间">添加应用 </a></li>
                                  <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>系统参数</span><a href="#" class="add" id="23" title="系统参数">添加应用 </a></li>
                                  <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>集中管理</span><a href="#" class="add" id="23" title="集中管理">添加应用</a></li>
                            </ul>
                         </li>
                         <li>
                         	<ul class="listIcon">
                                 <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>管理员帐号</span><a href="#" class="add" id="345" title="管理员帐号">添加应用</a></li>
                                  <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>管理主机</span><a href="#" class="add" id="56" title="管理主机">添加应用</a></li>
                                  <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>管理证书</span><a href="#" class="add" id="567" title="管理证书">添加应用</a></li>
                                 <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>管理方式</span><a href="#" class="add" id="567" title="豆瓣音乐">添加应用</a></li>
                            </ul>
                         </li>
                         <li>
                         	<ul class="listIcon">
                                 <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>系统更新</span><a href="#" class="add" id="345" title="系统更新">添加应用 </a></li>
                                 <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>备份与恢复</span><a href="#" class="add" id="56" title="备份与恢复">添加应用</a></li>
                                 <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>许可证管理</span><a href="#" class="add" id="56" title="许可证管理">添加应用 </a></li>
                                 <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>生产</span><a href="#" class="add" id="56" title="生产">添加应用</a></li>
                                 <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>批处理工具</span><a href="#" class="add" id="56" title="批处理工具">添加应用</a></li>
                                 
                            </ul>
                         </li>
                        </ul>
                    </div>
                </div>
            </div>
      </div>
        <div class="tagContent" id="tagContent1">第二个标签的内容</div>
        <div class="tagContent" id="tagContent2">第三个标签的内容</div>
        <div class="tagContent" id="tagContent3">第4个标签的内容</div>
        <div class="tagContent" id="tagContent4">第5个标签的内容</div>
        <div class="tagContent" id="tagContent5">第6个标签的内容</div>
        <div class="tagContent" id="tagContent6">第7个标签的内容</div>
        <div class="tagContent" id="tagContent7">第8个标签的内容</div>
    </div>
</div>
<script type="text/javascript" src="Public/js/systemManagement/quick/quick.js"></script>
<script type="text/javascript">
 initdbhooo();
var $listIcon=$("ul.listIcon");
$listIcon.find("a.add")
.click(function(){
				var id=this.id,title=this.title;
				//这里的data本应该使用ajax方法从数据库获取，这里直接写到页面
				var data={
					'id':id,
					'title':title,
					'iconSrc':"Public/js/jquery/desktop/icon/icon7.png",
					'url':"systemManagement/overview/overview.php"
					}
					parent.addIcon(data);
				});
</script>
</body>
</html>