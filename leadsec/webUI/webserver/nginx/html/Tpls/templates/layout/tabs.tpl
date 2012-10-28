<!-- tabs -->
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
                <{if $seq eq 0}>
                    class="visitedTab"
                <{/if}>
                name="<{$tab.link}>" title="<{$tab.title}>"
                onClick="showPageByAjax('<{$baseurl|cat:'/'|cat:$tab.link|cat:'.php'}>')">
                <{$tab.name}>
                </li>
            <{/foreach}>
        <{/if}>
    </ul>
</div>
<div class="tabinfo">
    &nbsp;&nbsp;<img src="<{$smarty.const.THEME_PATH}>/images/hi.gif" />&nbsp;
    <{foreach $tabinfo as $t}>
        <span
        <{if !$t@first}>
            class="hide"
        <{/if}>
        id="show_text<{$t@index}>">
        <{$t.breadCrumbs}>&nbsp;&nbsp;&nbsp;&nbsp;<{$t.note}>
        </span>
        
    <{/foreach}>
</div>
<br class="clearFloat"/>
<script type="text/javascript">
 <{if isset($tabs)}>
	 showPageByAjax("<{$baseurl|cat:'/'|cat:$tabs[0].link|cat:'.php'}>");
 <{/if}>
</script>
