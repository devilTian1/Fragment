<!-- mainContent -->
<table class="floatLeft column_45">
    <caption>设备信息</caption>
    <tr>
        <th class="column_30">名称</th>
        <th class="column_70">内容</th>
    </tr>
    <tr>
        <th><{$smarty.const.PRODUCT_NAME}>序列号</th>
        <td><{$devinfo.serialnum}></td>
    </tr>
    <tr>
        <th>硬件版本号</th>
        <td><{$devinfo.devnum}></td>
    </tr>
    <tr>
        <th>软件版本号</th>
        <td><{$devinfo.softnum}></td>
    </tr>
    <tr>
        <th><{$smarty.const.PRODUCT_NAME}>名称</th>
        <td><{$devinfo.hostname}></td>
    </tr>
</table>
<table class="floatLeft column_45">
    <caption>
        网口状态图状态
         <a href="#">更多</a>
    </caption>
    <tr>
        <th class="column_30">名称</th>
        <th class="column_70">内容</th>
    </tr>
    <tr>
        <th>网络设备fe1</th>
        <td>发送0字节， 接收0字节</td>
    </tr>
    <tr>
        <th>网络设备fe2</th>
        <td>发送0字节， 接收0字节</td>
    </tr>
    <tr>
        <th>网络设备fe3</th>
        <td>发送0字节， 接收0字节</td>
    </tr>
    <tr>
        <th>网络设备fe4</th>
        <td>发送0字节， 接收0字节</td>
    </tr>
</table>
<br class="clearFloat"/>
<hr/>
<table class="floatLeft column_90">
    <caption>
        license
        <a href="#">更多</a>
    </caption>
    <tr>
        <th class="column_30">服务名称</th>
        <th class="column_10 textCenter">状态</th>
        <th class="column_60 textCenter">描述</th>
    </tr>
    <{foreach from=$liceinfo key=myId item=val}>

    <tr>
        <th><{$val.name}></th>
        <td class="textCenter">
        <{if $val.status eq 1}>
            <img src="<{$smarty.const.THEME_PATH}>/images/icon/select.png" width="16" height="16" />
        <{else}>
            <img src="<{$smarty.const.THEME_PATH}>/images/icon/stop.png" width="16" height="16" />
        <{/if}>
        </th>
        <td class="textCenter"><{$val.remark}></td>
    </tr>
    <{/foreach}>
</table>
<br class="clearFloat"/>
<hr/>

  <table class="floatLeft column_45">
    <caption>
        负载均衡状态
         <a href="#">更多</a>
    </caption>
    <tr>
        <th class="column_30">名称</th>
        <th class="column_70">内容</th>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
</table>
<table class="floatLeft column_45">
<caption>
        双击热备状态
         <a href="#">更多</a>
    </caption>
    <tr>
        <th class="column_30">名称</th>
        <th class="column_70">内容</th>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <th>&nbsp;</th>
        <td>&nbsp;</td>
    </tr>
</table>
<br class="clearFloat"/>
<script type="text/javascript" src="Public/js/systemManagement/overview/overview.js"></script>
