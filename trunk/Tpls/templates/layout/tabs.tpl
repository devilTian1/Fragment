<div class="tabinfo">
    <div class="tabinfo_left"></div>
    <div class="tabinfo_cen" id="tabinfo_cen"><strong>当前位置：</strong>
        <{if isset($tabinfo) }>
        <{foreach $tabinfo as $seq => $t}>
            <span <{if $seq neq $tabnum|default:0}>class="hide"<{/if}>
                id="show_text<{$t@index}>">
                <{$t.breadCrumbs}>&nbsp;&nbsp;&nbsp;&nbsp;<{$t.note}>
            </span>
        <{/foreach}>
        <{/if}>
    </div>
    <div class="tabinfo_right"></div>
</div>
<div class="tabs">
     <ul>
        <{if isset($tabs) }>
        <{foreach $tabs as $seq => $tab}>
            <li
            <{if $seq eq $tabnum|default:0}>
                class="visitedTab"
            <{/if}>
            name="<{$tab.link}>" title="<{$tab.title}>"
            onClick="freshModStat('<{$baseurl}>', '<{$tab.link}>');showPageByAjax('<{$baseurl|cat:'/'|cat:$tab.link|cat:'.tpl'}>')">
            <{$tab.name}>
            </li>
        <{/foreach}>
        <{/if}>
    </ul>
    <!--
    <{if $modStat['active'] eq 'on'}>
        <span name="modechk|<{$modStat['mod']}>|<{$modStat['serv']}>"
            id="modechk" class="modelchk_on"
            onClick="switchModStat()"></span>
    <{else if $modStat['active'] eq 'off'}>
        <span name="modechk|<{$modStat['mod']}>|<{$modStat['serv']}>"
            id="modechk" class="modelchk_off"
            onClick="switchModStat()"></span>
    <{/if}>
    -->
</div>
<script type="text/javascript">
    <{if isset($tabs) && count($tabs) != 0}>
        showPageByAjax("<{$baseurl|cat:'/'|cat:$tabs[$tabnum|default:0].link|cat:'.tpl'}>");
    <{/if}>
    var mainZoneWidth=document.getElementById("mainZone").scrollWidth;
    document.getElementById("tabinfo_cen").style.width=(mainZoneWidth-200)+"px";
    /*
    <{if $modStat['active'] eq 'on'}>
        $("#modechk").attr("title","点击后将关闭服务");
        $("#modechk").tooltip();
    <{else if $modStat['active'] eq 'off'}>
        $("#modechk").attr("title","点击后将启动服务");
        $("#modechk").tooltip();
    <{/if}>
    */
</script>
