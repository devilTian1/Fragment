<{foreach name=outer item=secondmenu from=$menu}>
<div class="l1" name="<{$secondmenu.cfgname}>">
    <span><{$secondmenu.name}></span>
</div>
<div class="l2" name="<{$secondmenu.cfgname}>">
    <ul>
    	<{foreach item=submenu from=$secondmenu.subMenu}>
        <li title="<{$submenu.cfgname}>">
        	<a href="#"
            	 <{if $submenu.subMenu|@count neq 0}> 
                    <{foreach item=submenu2 from=$submenu.subMenu name='foo'}>
                        <{if $smarty.foreach.foo.first}> title='<{$submenu2.cfgname}>' <{/if}>
                    <{/foreach}>
                    <{else}> title=''<{/if}>
        
        ><{$submenu.name}></a></li>
        <{/foreach}>
    </ul>
</div>
<{/foreach}>
<script type="text/javascript">
    function showPageByAjax(groupName,liTitle,toHref) {
        $("#mainZone").html("loading... ...").load(groupName+".php?type="+liTitle+'&subtype='+toHref, { page : groupName+'/'+toHref}, function() {
            var contentH  = $("#mainZone>.mainContent").outerHeight();
            var leftmenuH = $("#leftmenu").outerHeight();
            contentH > leftmenuH ? $("#leftmenu").outerHeight(contentH) : $("#mainZone>.mainContent").outerHeight(leftmenuH);
            refreshTab();
            $("#clientTcp").tablesorter();
        });
    }
    $(document).ready(function() {
        $("#leftmenu a").click(function() {
            var toHref = $(this).attr("title");
			var liTitle=$(this).parents("li").attr("title");
            var groupName  = $(this).parents("div.l2").attr("name");
            $("#leftmenu a").removeClass("link");
            $(this).addClass("link");
            showPageByAjax(groupName,liTitle,toHref);
            return false;
        });
    });
</script>
