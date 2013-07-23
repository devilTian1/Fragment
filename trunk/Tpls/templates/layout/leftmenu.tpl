<{foreach $leftmenu as $l1}>
    <!--[if IE 8]>
    <p style="margin: 0px; padding: 0px; height: 9px;"></p>
    <![endif]-->
    <div class="l1 l1_close_<{$l1.link}>" name="<{$l1.link}>">
        <span><{$l1.name}></span>
    </div>
    <div class="l2" name="<{$l1.link}>">
        <ul>
        <{foreach $l1.children as $l2}>
            <li>
                <span class="l2span" name="<{$l2.link}>" title="<{$l2.name}>">
                    <{$l2.name}>
                </span>
                <ul class="l3" name="<{$l2.link}>">
                <{foreach $l2.children as $l3}>
                    <li>
                    <a name="<{$l3.link}>" title="<{$l3.name}>"><{$l3.name}></a>
                    </li>
                <{/foreach}>
                </ul>
            </li>
        <{/foreach}>
        </ul>
    </div>
<{/foreach}>
