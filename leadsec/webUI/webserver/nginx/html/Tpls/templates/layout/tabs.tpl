<div class="tabinfo">
    <div class="tabinfo_left"></div>
    <div class="tabinfo_cen" id="tabinfo_cen"><strong>当前位置：</strong>
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
<script type="text/javascript">
 <{if isset($tabs) && count($tabs) != 0}>
	 showPageByAjax("<{$baseurl|cat:'/'|cat:$tabs[0].link|cat:'.php'}>");
 <{/if}>
 var mainZoneWidth=document.getElementById("mainZone").scrollWidth;
 document.getElementById("tabinfo_cen").style.width=(mainZoneWidth-200)+"px";
</script>
