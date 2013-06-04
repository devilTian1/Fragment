<{foreach $ftpTransClientAcl as $r }>
    <tr>
        <td><{$r.id}></td>
        <td><{$r.sa|regex_replace: "/_ipv(4|6)/" : ""}></td>
        <td><{$r.da|regex_replace: "/_ipv(4|6)/" : ""}></td>
        <td><{$r.dport}></td>
        <td><{$r.filter}></td>
        <td><{$r.time}></td>
        <td>
            <form action="Function/client/ftp/transVisit.php"
                method="POST" id="switchFtpTransClientForm_<{$r.id}>"
                onSubmit="return false;">
                <input type="hidden" name="ftpTransId" value="<{$r.id}>"/>
                <input type="hidden" name="sa" value="<{$r.sa}>"/>
                <input type="hidden" name="da" value="<{$r.da}>"/>
                <input type="hidden" name="ftpTranslportReq" value="<{$r.dport}>"/>
                <input type="hidden" name="time" value="<{$r.time}>"/>
                <input type="hidden" name="filter" value="<{$r.filter}>"/>
                <input type="hidden" name="usergrp" value="<{$r.usergrp}>"/>
                <input type="hidden" name="comment" value="<{$r.comment|escape}>"/>
                <{if $r.active eq 1 || $r.active eq 'Y'}>
                    <a href="#" onClick="switchFtpTransClientAcl('<{$r.id}>', 'disable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16"/>
                        <input type="hidden" name="action" value="disable"/>
                    </a>
                <{else}>
                    <a href="#" onClick="switchFtpTransClientAcl('<{$r.id}>', 'enable')">
                        <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png"
                        width="16" height="16"/>
                        <input type="hidden" name="action" value="enable"/>
                    </a>
                <{/if}> 
            </form>
        </td>        
        <td> 
                <{if $r.virus === 'Y' || $r.virus === '1'}>
           			 开
            	<{else}>
            		关
          		  <{/if}>
         </td>  
        <td class="no_search">
            <a href="#" class="edit"
                onclick="editFtpTransClientAclDialog('<{$r.id}>')">编辑</a>
            <a href="#" class="delete"
                onclick="delFtpTransClientAclDialog('<{$r.id}>')">
                删除</a> 
        </td>
    </tr>
<{foreachelse}>
    <tr><td colspan='8'>无数据.</td></tr>
<{/foreach}>
