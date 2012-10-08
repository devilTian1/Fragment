<?php /* Smarty version Smarty-3.1.12, created on 2012-10-06 16:36:25
         compiled from "D:\WEB\PHP\APMServ5.2.6\www\htdocs\leadsec\tpls\templates\content.tpl" */ ?>
<?php /*%%SmartyHeaderCode:585150705e09a8faf7-88940362%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4ea7b55f4441fac857f79e5f025633fb12305f75' => 
    array (
      0 => 'D:\\WEB\\PHP\\APMServ5.2.6\\www\\htdocs\\leadsec\\tpls\\templates\\content.tpl',
      1 => 1349275188,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '585150705e09a8faf7-88940362',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.12',
  'unifunc' => 'content_50705e09ab06f3_54925651',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_50705e09ab06f3_54925651')) {function content_50705e09ab06f3_54925651($_smarty_tpl) {?><!-- tabs -->
<div class="tabs">
    <ul>
        <li>First</li>
        <li>网络配置</li>
        <li>Second</li>
    </ul>
</div>
<div class="tabinfo">
    &nbsp;&nbsp;<img src="images/hi.gif" />&nbsp;
    <span id="show_text">headline</span>
</div>

<br class="clearFloat"/>
<!-- mainContent -->
<div class="mainContent">
    <table class="floatLeft column_50">
        <tr>
            <th class="column_30">名称</th>
            <th class="column_70">内容</th>
        </tr>
        <tr>
            <th>安全隔离网闸序列号</th>
            <td>d6757df2b05c23cb</td>
        </tr>
        <tr>
            <th>硬件版本号</th>
            <td>SIS-3000-Z6101</td>
        </tr>
        <tr>
            <th>软件版本号</th>
            <td>1.0.200.31</td>
        </tr>
        <tr>
            <th>安全隔离网闸名称</th>
            <td>NetGap</td>
        </tr>
    </table>
    <br class="clearFloat"/><br/>
    <hr/>
    <table class="floatLeft column_75">
        <caption>
            最近事件
            <a href="#">更多</a>
        </caption>
        <tr>
            <th class="column_30">日期 / 时间</th>
            <th class="column_10 textCenter">级别</th>
            <th class="column_50">详细信息</th>
        </tr>
        <tr>
            <td>2012/08/31 19:02:25 </th>
            <td class="textCenter">注意</td>
            <td>Sep 2 00:36:19 127.1.0.1 snmpd: devid=3 date="2012/08/31 19:02:25" dname=NetGap logtype=8 pri=5 mod=snmp act=trap result=0 admin= serial=d6757df2b05c23cb msg="CPU threshold trap: threshold=85%, used=100%"</td>
        </tr>
        <tr>
            <td>2012/08/31 19:02:25</td>
            <td class="textCenter">注意</td>
            <td>Sep 2 00:36:19 127.1.0.1 snmpd: devid=3 date="2012/08/31 19:02:25" dname=NetGap logtype=8 pri=5 mod=snmp act=trap result=0 admin= serial=d6757df2b05c23cb msg="CPU threshold trap: threshold=85%, used=100%"</td>
        </tr>
        <tr>
            <td>2012/08/31 19:02:25</td>
            <td class="error textCenter">注意</td>
            <td>Sep 2 00:36:19 127.1.0.1 snmpd: devid=3 date="2012/08/31 19:02:25" dname=NetGap logtype=8 pri=5 mod=snmp act=trap result=0 admin= serial=d6757df2b05c23cb msg="CPU threshold trap: threshold=85%, used=100%"</td>
        </tr>
        <tr>
            <td>2012/08/31 19:02:25</td>
            <td class="textCenter">注意</td>
            <td>Sep 2 00:36:19 127.1.0.1 snmpd: devid=3 date="2012/08/31 19:02:25" dname=NetGap logtype=8 pri=5 mod=snmp act=trap result=0 admin= serial=d6757df2b05c23cb msg="CPU threshold trap: threshold=85%, used=100%"</td>
        </tr>
    </table>
</div>
<?php }} ?>