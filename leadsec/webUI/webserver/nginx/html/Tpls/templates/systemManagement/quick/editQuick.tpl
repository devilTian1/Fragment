<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
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
<ul class="listIcon">
  <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>豆瓣音乐</span><a href="#" class="add" id="123" title="豆瓣音乐">添加应用</a></li>
    <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>豆瓣音乐</span><a href="#" class="add" id="23" title="豆瓣音乐">添加应用</a></li>
  <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>豆瓣音乐</span><a href="#" class="add" id="345" title="豆瓣音乐">添加应用</a></li>
  <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>豆瓣音乐</span><a href="#" class="add" id="56" title="豆瓣音乐">添加应用</a></li>
  <li><a href="#" class="img"><img src="Public/js/jquery/desktop/icon/icon7.png" alt="" /></a><span>豆瓣音乐</span><a href="#" class="add" id="567" title="豆瓣音乐">添加应用</a></li>
 </ul>
<script type="text/javascript">
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
