<?php /* Smarty version Smarty-3.1.12, created on 2012-10-07 18:10:58
         compiled from "/usr/local/webserver/nginx/html/Fragment/leadsec_xzl/tpls/templates/content.tpl" */ ?>
<?php /*%%SmartyHeaderCode:81565663850722822e298f4-81235761%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c2851ed6ec2daa3c078a8f935c399a5aedf8cb29' => 
    array (
      0 => '/usr/local/webserver/nginx/html/Fragment/leadsec_xzl/tpls/templates/content.tpl',
      1 => 1349658477,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '81565663850722822e298f4-81235761',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.12',
  'unifunc' => 'content_50722822eae684_37072281',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_50722822eae684_37072281')) {function content_50722822eae684_37072281($_smarty_tpl) {?><!-- tabs -->
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