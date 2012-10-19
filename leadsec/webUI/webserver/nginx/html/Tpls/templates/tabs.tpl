<!-- tabs -->
<div class="tabs">
    <ul>
        {if !isset($tabs) }
            <li class="visitedTab">1</li>
            <li>2</li>
            <li>3</li>
            <li>4</li>
            <li>5</li>
        {else}
            {foreach $tabs as $seq => $tab}
                {if $seq eq 0}
                    <li class="visitedTab" title="{$tab.title}">
                {else}
                    <li>
                {/if}
                    {$tab.name}
                    </li>
            {/foreach}
        {/if}
    </ul>
</div>
<div class="tabinfo">
    &nbsp;&nbsp;<img src="{$smarty.const.THEME_PATH}/images/hi.gif" />&nbsp;
    <span id="show_text">headline</span>
</div>
<br class="clearFloat"/>
