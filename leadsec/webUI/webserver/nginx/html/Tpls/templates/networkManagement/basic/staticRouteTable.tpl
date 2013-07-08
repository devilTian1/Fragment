<{foreach $list as $value }>
    <tr>
      <td><{$value.destip}>/<{$value.destmask}></td>
      <td><{$value.nexthopip}></td>
      <td><{$value.interface}></td>
      <td>
      	<{if $value.active eq 1}>
         <a href="#" onclick="changeStaticRouteActive('<{$value.id}>','off')">
      		<img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
         </a>
        <{else}>
       	 <a href="#" onclick="changeStaticRouteActive('<{$value.id}>','on')">
        	<img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
         </a>
        <{/if}>
       </td>
      <td>
      	  <a href="#" class="edit" onclick="openEditStaticRouteDialog('<{$value.id}>')">编辑</a>
      	  <a href="#" class="delete" onclick="openDelStaticRouteDialog('<{$value.id}>')">删除</a>	
      </td>
   </tr>
<{foreachelse}>
    <tr><td colspan='5'>无数据</td></tr>
<{/foreach}>
