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
    {foreach $tabinfo as $t}
        <span
        {if !$t@first}
            class="hide"
        {/if}
        id="show_text{$t@index}">
        {$t.breadCrumbs}&nbsp;&nbsp;&nbsp;&nbsp;{$t.note}
        </span>
        
    {/foreach}
</div>
<br class="clearFloat"/>
