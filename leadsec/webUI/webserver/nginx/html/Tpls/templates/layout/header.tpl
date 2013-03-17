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
              <img class="fishEyeItem" src="<{$smarty.const.THEME_PATH}>/images/<{$header.img}>" />
          </a>
          </form>
          <span><{$header.name}></span>
        </li>
      <{/foreach}> 
     <li>         
          <a href="index.php?logout=1"  onClick="function() {window.Location.href='index.php'}">
              <img class="fishEyeItem" src="<{$smarty.const.THEME_PATH}>/images/top_icon_7.png" />
          </a>          
          <span>退出</span>
       </li>     
     </ul>
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

