<div class="logo">
     <img src="<{$smarty.const.THEME_PATH}>/images/top_logo.gif" />
</div>
 <!-- rightNav-->
<div class="right_nav">
    <!--icon nav-->
    <div class="top_icon">
     <ul>
      <{foreach $result as $header}>
        <li>
		  <form action="Function/header.php" method="POST"
	          id="headerFormId_<{$header.id}>" onSubmit="return false;">
	      <input type="hidden" name="headerName_<{$header.id}>" value="<{$header.name}>"/>
          <a href="#" onClick="headerSpan('<{$header.name}>','<{$header.id}>')">
              <img src="<{$smarty.const.THEME_PATH}>/images/<{$header.img}>" />
          </a>
          </form>
          <span><{$header.name}></span>
        </li>
      <{/foreach}>   
     </ul>
    </div>
    <!-- userinfo -->
    <div class="top_userinfo">
        <div class="paddingLeft30">
            <span>Welcome</span>,&nbsp;<strong>DavidTian</strong>
            [<a href="#">Administrator</a>,&nbsp;<a href="index.php?logout=1" onClick="function() {window.Location.href='index.php'}">logout</a>]
        </div>
   </div>
</div>
