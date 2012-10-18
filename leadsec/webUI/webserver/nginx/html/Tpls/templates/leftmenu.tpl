{foreach name=outer item=secondmenu from=$menuArr}
<div class="l1" name="{$secondmenu.href}">
    <span>{$secondmenu.name}</span>
</div>
<div class="l2" name="{$secondmenu.href}">
    <ul>
        {foreach item=submenu from=$secondmenu.children}
        <li title="{$submenu.href}">
            <a href="#"> {$submenu.name}</a></li>
        {/foreach}
    </ul>
</div>
{/foreach}

