<div class="logo">
     <img src="<{$smarty.const.THEME_PATH}>/images/top_logo.gif" />
</div>
 <!-- rightNav-->
<div class="right_nav">
    <!--icon nav-->
    <div class="dock" id="dock2">
        <div class="dock-container2">
        <{foreach $result as $header}>
		    <form action="Function/header.php" method="POST"
	            id="headerFormId_<{$header.id}>" onSubmit="return false;">
	        <input type="hidden" name="headerName_<{$header.id}>" value="<{$header.name}>"/>
	        <{if $header.id === 'exportconf'}><input type="hidden" name="export_format" value="normal"/><{/if}>
            <a class="dock-item2" href="#" onClick="headerSpan('<{$header.name}>','<{$header.id}>')"><span class="black"><{$header.name}></span><img src="<{$smarty.const.THEME_PATH}>/images/<{$header.img}>" alt="<{$header.name}>"/></a>
            </form>
        <{/foreach}> 
            <a class="dock-item2" href="index.php?logout=1" onClick="function() {window.Location.href='index.php'}"><span class="black">退出</span><img src="<{$smarty.const.THEME_PATH}>/images/top_icon_7.png" alt="<{$header.name}>"/></a>          
        </div>
    </div>
    <!-- userinfo -->
    <div class="top_userinfo">
        <div class="paddingLeft30">
            <span>欢迎</span>,&nbsp;<strong><{$loginname}></strong>
            <br>
            [<a href="javascript:openEditUserDialog('<{$loginname}>')"><{$loginname}></a>,&nbsp;<a href="index.php?logout=1" onClick="function() {window.Location.href='index.php'}">退出</a>]
        </div>
   </div>
</div>
<script type="text/javascript" src="Public/js/systemManagement/admin/account.js"></script>
