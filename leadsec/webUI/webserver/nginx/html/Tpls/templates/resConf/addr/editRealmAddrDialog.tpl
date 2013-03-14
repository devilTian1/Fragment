<form action="Function/resConf/addr/realmAddr.php" method="POST" id="editRealmAddrForm"
    onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>域名地址维护</legend>
        <div class="row">
            <label for="addrName">名称:<em class="required">*</em></label>
            <input type="text" name="addrName" maxlength="15" value="<{$realmAddr.name}>"
            <{if $type === 'edit'}>readonly="readonly"<{/if}> id="addrName"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="domainName">域名:</label>
            <input type="text" name="domainName" value="<{$realmAddr.domain}>"
            	id="domainName"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="addStaticAddr">添加静态IP:</label>
            <div class="column column_65">
                <input type="text" name="addStaticAddr" id="addStaticAddr"/>
                <button class="standard floatLeft addBtn" onClick="addStaticAddrList()">
                    添加</button>
            </div>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="staticAddrList">静态IP列表:</label>
            <div class="column column_30">
                <{html_options class='multiSelect' size="5" name="staticAddrList[]"
                    multiple="multiple" id="staticAddrList"
                    output=$realmAddr.staticIpList values=$realmAddr.staticIpList}>
            </div>
            <div class="column column_25">
                <button class="standard floatLeft" onClick="deleteStaticAddr()">删除</button>
                <br/><br/>
                <button class="standard floatLeft" onClick="cleanAllStaticAddr()">清空</button>
            </div>
            <br class="clearFloat"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="auto_resolve">自动解析:</label>
            <input class="checkbox" type="checkbox" name="auto_resolve" id="auto_resolve"
                <{if $realmAddr.auto_resolve == 1}>checked="checked"<{/if}>/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label>解析记录:<em class="required">*</em></label>
            <div class="column">
                <input class="checkbox record_type" type="checkbox" name="record_type_a" value="A"
                    <{if $realmAddr.record_type === '1' || $realmAddr.record_type === '3' || $realmAddr.record_type == '' }>checked="checked"<{/if}>/>
                <label for="record_type_a">A</label>
                <br/>
                <input class="checkbox record_type" type="checkbox" name="record_type_mx" value="MX"
                    <{if $realmAddr.record_type === '2' || $realmAddr.record_type === '3' }>checked="checked"<{/if}>/>
                <label for="record_type_mx">MX</label>
            </div>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="max_record">最大记录数:<em class="required">*</em></label>
            <input type="text" name="max_record" id="max_record"
                value="<{$realmAddr.max_record|default:64}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="interval">自动解析间隔(单位:分钟):
                <em class="required">*</em></label>
            <input type="text" name="interval" id="interval"
                value="<{$realmAddr.interval|default: 30}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
                <label for="autoParseErrInterval">自动解析记录失效间隔:<em class="required">*</em></label>
            <input type="text" name="autoParseErrInterval" id="autoParseErrInterval"
                value="<{$realmAddr.expire|default:2}>"/>
            （是自动解析间隔的多少倍）
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="primaryDns">主DNS服务器:</label>
            <input type="text" name="primaryDns" id="primaryDns"
                value="<{$realmAddr.primary_dns}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="secondaryDns">次DNS服务器:</label>
            <input type="text" name="slaveDns" id="slaveDns"
                value="<{$realmAddr.slave_dns}>"/>
        </div>
        <br class="clearFloat"/>
        <div class="row">
                <label for="DynamicAddrList">动态IP列表:</label>
            <{html_options class='multiSelect' size="5" name="DynamicAddrList[]"
                multiple="multiple" id="DynamicAddrList"
                    output=array() values=array()}>
        </div>
        <br class="clearFloat"/>
        <div class="row">
            <label for="comment">备注:</label>            
            <input class="comment" name="comment" id="comment" value="<{$realmAddr.comment}>"/>
        </div>
        <br class="clearFloat"/>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function(){
        renderStandardUi();
        validateForm($("#editRealmAddrForm"));
    });
</script>
