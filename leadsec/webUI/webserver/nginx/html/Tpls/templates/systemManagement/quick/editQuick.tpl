<link rel="stylesheet" href="<{$smarty.const.THEME_PATH}>/css/quicktab.css" type="text/css" />
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
.shell ul.listIcon li a.add {
	font-size: 12px;
	color:#F00;
}
.shell ul.listIcon li a.add:visited {
	color:#F00;
}
.shell ul.listIcon li a.add:hover {
	color:#30F;
}
.shell ul.listIcon li a.add:active {
	color: #666;
}
ul{
	list-style:none;
}
.shell ul.listIcon{
	width:90%;
	overflow:hidden;
	zoom:-1;
	margin:10px auto;
	}
.shell ul.listIcon li{
	height:120px;
	width:64px;
	float:left;
	margin:5px 10px;
	}
.shell ul.listIcon li img{
	display:block;
	height:60px;
}	
.shell ul.listIcon li a.add{
	display:block;
	height:25px;
	background:#eee;
	border:1px solid #CCC;
	text-align:center;
	line-height:25px;
	}	
.shell ul.listIcon li span{
	font-size:10px;
	height:25px;
	line-height:25px;
	text-align:center;
	display:block
	}	
-->
</style>
<div id="con">
    <UL id="tags">
      <!--<li class="selectTag"><A onClick="selectTag('tagContent0',this)" href="javascript:void(0)">系统管理</A> </li> -->
       <{foreach from=$res key=key item=resitem name=restop}>
      		<li <{if $smarty.foreach.restop.first}>class="selectTag"<{/if}>><a onClick="selectTag('tagContent<{$key}>',this)" href="#"><{$resitem.toptitle}></a></li>
      <{/foreach}>
      
    </UL>
    <div id="tagContent">
    	<{foreach from=$res key=key item=resitem name=restop2}>
        <div class="tagContent <{if $smarty.foreach.restop2.first}>selectTag<{/if}>" id="tagContent<{$key}>">
        	 <div class="dhooo_tab">
                 <ul class="tab_btn" id="myTab_btns<{$key}>">
                 	<{foreach from=$resitem.subarr item=subitem name=ressub}>
                      	<li <{if $smarty.foreach.ressub.first}> class="hot" <{/if}>><{$subitem.subtitle}></li>
                    <{/foreach}>
                 </ul>
                <div class="main" id="main<{$key}>">
                    <div class="shell">
                        <ul>
                        <{foreach from=$resitem.subarr item=subitem}>
                             <li>
                                <ul class="listIcon">
                                <{foreach from=$subitem.children item=childitem}>
                                      <li><img src="Public/js/jquery/desktop/icon/<{$childitem.img}>.png" alt="" /><span><{$childitem.title}></span><a href="#" class="add" id="<{$childitem.id}>" rev="<{$childitem.url}>" rel="<{$childitem.img}>" title="<{$childitem.title}>">添加应用</a></li>
                                <{/foreach}>
                                </ul>
                             </li>
                         <{/foreach}>
                        </ul>
                    </div>
                </div>
            </div>
         </div>
         <{/foreach}>
    </div>
</div>
<script type="text/javascript" src="Public/js/systemManagement/quick/quick.js"></script>
<script type="text/javascript">
 initdbhooo();
$(document).ready(function(){
	$("ul.listIcon li").find("a.add").click(function(){
				var id=this.id,title=this.title,img=this.rel,url=this.rev;
				//这里的data本应该使用ajax方法从数据库获取，这里直接写到页面
				var data={
					'id':id,
					'title':title,
					'iconSrc':"Public/js/jquery/desktop/icon/"+img+".png",
					'url':url
					}
					parent.addIcon(data);
					return false;
				});							
});
</script>