<{foreach $list as $value }>
 <tr>
    <td>序号</td>
    <td>虚拟地址</td>
    <td>端口</td>
    <td>真实地址1</td>
    <td>真实端口1</td>
    <td>真实地址2</td>
    <td>真实端口2</td>
    <td>
     <a href="#" class="edit" onclick="openEditLvsDialog('<{$value.id}>')">编辑</a>
     <a href="#" class="delete" onclick="openDelLvsDialog('<{$value.id}>')">删除</a>	
    </td>
 </tr>  
<{foreachelse}>
    <tr><td colspan='5'>No Address Data</td></tr>
<{/foreach}>
