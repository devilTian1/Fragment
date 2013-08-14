<div class="tabinfo">
    <div class="tabinfo_left"></div>
    <div class="tabinfo_cen" id="tabinfo_cen"><strong>当前位置：</strong>
    	<{foreach $tabinfo as $seq => $t}>
        <span
        <{if $seq neq $tabnum|default:0}>
            class="hide"
        <{/if}>
        id="show_text<{$t@index}>">
        <{$t.breadCrumbs}>&nbsp;&nbsp;&nbsp;&nbsp;<{$t.note}>
        </span>
    <{/foreach}>
    </div>
    <div class="tabinfo_right"></div>
</div>
<div class="tabs">
     <ul>
        <{if !isset($tabs)}>
            <{$tabinfo = array(1,2,3,4)}>
            <li class="visitedTab">1</li>
            <li>2</li>
            <li>3</li>
            <li>4</li>
            <li>5</li>
        <{else}>
            <{foreach $tabs as $seq => $tab}>
                <li
                <{if $seq eq $tabnum|default:0}>
                    class="visitedTab"
                <{/if}>
                name="<{$tab.link}>" title="<{$tab.title}>"
                onClick="freshModStat('<{$baseurl}>', '<{$tab.link}>');showPageByAjax('<{$baseurl|cat:'/'|cat:$tab.link|cat:'.php'}>')">
                <{$tab.name}>
                </li>
            <{/foreach}>
        <{/if}>
    </ul>
    <{if $modStat['active'] eq 'on'}>
        <span name="modechk|<{$modStat['mod']}>|<{$modStat['serv']}>"
            id="modechk" class="modelchk_on"
            onClick="switchModStat()"></span>
    <{else if $modStat['active'] eq 'off'}>
        <span name="modechk|<{$modStat['mod']}>|<{$modStat['serv']}>"
            id="modechk" class="modelchk_off"
            onClick="switchModStat()"></span>
    <{/if}>
</div>
<script type="text/javascript">
    <{if isset($tabs) && count($tabs) != 0}>
        showPageByAjax("<{$baseurl|cat:'/'|cat:$tabs[$tabnum|default:0].link|cat:'.php'}>");
    <{/if}>
    <{if $modStat['active'] eq 'on'}>
        $("#modechk").attr("title","点击后将关闭服务。");
        $("#modechk").tooltip();
    <{else if $modStat['active'] eq 'off'}>
        $("#modechk").attr("title","点击后将启动服务。");
        $("#modechk").tooltip();
    <{/if}>    
</script>
