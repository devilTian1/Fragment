<form action="Function/client/db/transVisit.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">任务号:<em class="required">*</em></label>
          <input type="text" name="clientId" value="<{$res.id}>" 
              <{if $type ==='edit'}>disabled="disabled"<{/if}>
              size="4" maxlength="4"/>
          (同一端的任务号必须唯一)
         <{if $type ==='edit'}>
             <input type="hidden" name="clientId" value="<{$res.id}>"/>
         <{/if}>
        </div>       
        <div class="row">
          <label for="destip">数据库类型:<em class="required">*</em></label>
          <{html_options  class="w200" name="dbType" id="dbType"
                    output=array('oracle','sqlserver2005','sqlserver2008') 
                    values=array('oracle','sqlserver2005','sqlserver2008')
                    selected=$res.dbtype|default: 'oracle'}>
        </div>
        
        <div class="row">
          <label for="destip">源地址:<em class="required">*</em></label>
          <{html_options  class="w200" name="sAddress" id="sAddress"
                    output=$addrOptions values=$addrOptionsvalue
                    selected=$res.sa|default: 'any'}>
        </div>
        
        <div class="row">
          <label for="destip">目的地址:<em class="required">*</em></label>
          <{html_options  class="w200" name="lAddress" id="lAddress"
                    output=$localIp values=$localIpValue
                    selected=$res.dp|default: 'any'}>
        </div>
        
         <div class="row">
          <label for="destip">目的端口:<em class="required">*</em></label>
          <input type="text" name="localPort" value="<{$res.dport}>" />(1-65535)(输入形如:1200或2000：3000)
        </div>
        
        <div class="row">
          <label for="destip">过滤选项:</label>
          <{html_options  class="w200" name="filter" id="filter"
                    output=$filterOptions values=$filterOptions
                    selected=$res.filter|default: 'empty'}>
        </div>
        
         <div class="row">
            <label>是否启动:<em class="required">*</em></label>
            <{html_radios class="radio" name=active label_ids=true values=array('Y', 'N')
                output=array('开', '关') selected=$res.active|default: 'Y'}>
        </div>
        
         <div class="row">
          <label for="destip">认证用户组:</label>
           <{html_options  class="w200" name="roleList" id="roleList"
                    output=$roleList values=$roleList
                    selected=$res.usergrp|default: 'empty'}>
        </div>
        
        <div class="row">
          <label for="destip">生效时段:</label>
           <{html_options  class="w200" name="timeList" id="timeList"
                    output=$timeList values=$timeList
                    selected=$res.time|default: 'empty'}>
        </div>
        
        <div class="row">
          <label for="destip">备注:</label>
           <textarea rows="1" cols="30" name="comment" id="comment"><{$res.comment}></textarea>
        </div>
    </fieldset>
</form>
<link rel="stylesheet" href="Public/js/clueTip/jquery.cluetip.css" type="text/css" />
<script type="text/javascript" src="Public/js/clueTip/jquery.hoverIntent.js"></script>
<script type="text/javascript" src="Public/js/clueTip/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="Public/js/clueTip/jquery.cluetip.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
    validateForm($("#editForm"));
});
</script>