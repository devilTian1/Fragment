<{foreach $res as $value }>
    <tr>
    	<td><{$value.id}></td>
        <td><{$value.name}></td>
        <td><{$value.usergrp}></td>
        <td><{$value.sqlgrp}></td>
        <td><{$value.comment}></td>
        <td>
      	    <a href="#" class="edit"  onclick="openEditOptionsDialog('<{$value.id}>')">编辑</a>
      	    <a href="#" class="delete"  onclick="openDelOptionsDialog('<{$value.id}>')">删除</a>	
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='6'>No Data</td></tr>
<{/foreach}>