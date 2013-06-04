<{foreach $network as $arr }>
    <tr>
        <td><{$arr.external_name}></td>
        <td>
            <{if $arr.deviceOn === 'on'}>
                <img src="<{$smarty.const.THEME_PATH}>/images/icon/showlink.gif" width="16" height="16" />
            <{else}>
                <img src="<{$smarty.const.THEME_PATH}>/images/icon/stoplink.gif" width="16" height="16" />
            <{/if}>
        </td>
        <td>发送 <{$arr.transmitByte}> 字节</td>        	    
        <td>接收 <{$arr.receiveByte}> 字节</td>
        <td class="no_search">
            <a href="#" onclick="openNetworkDialog('<{$arr.external_name}>')">当前状态</a>
            <a href="#" onclick="openNetworkChartDialog('<{$arr.external_name}>')">统计图</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='5'>无数据.</td></tr>
<{/foreach}>
