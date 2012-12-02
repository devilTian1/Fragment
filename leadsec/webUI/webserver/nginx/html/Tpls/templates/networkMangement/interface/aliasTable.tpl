<{foreach $list as $value }>
    <tr>
      <td><{$value.external_name}></td>
      <td><{$value.ip}>/<{$value.mask}></td>
      <td>
      	<{$propertyArr[$value.external_name]}>
      </td>
      <td><{$ipaddrArr[$value.alias_id]}></td>
      <td>
      	<{if $value.enable eq 1}>
      		<img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
        <{else}>
        	<img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
        <{/if}>
       </td>
      <td>
      	  <a href="#" class="edit" onclick="openEditPhysicalDialog('<{$value.external_name}>')">编辑</a>
      	  <a href="#" class="delete" onclick="openDelAliasDialog('<{$value.external_name}>')">删除</a>	
      </td>
   </tr>
<{foreachelse}>
    <tr><td colspan='5'>No Address Data</td></tr>
<{/foreach}>
