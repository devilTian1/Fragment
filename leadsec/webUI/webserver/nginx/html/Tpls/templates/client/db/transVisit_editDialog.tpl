<form action="Function/client/db/transVisit.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label >任务号:<em class="required">*</em></label>
          <input class="id" type="text" name="clientId" value="<{$res.id}>" 
              <{if $type ==='edit'}>disabled="disabled"<{/if}>
              size="4" maxlength="4"/>
          (同一端的任务号必须唯一)
         <{if $type ==='edit'}>
             <input type="hidden" name="clientId" value="<{$res.id}>"/>
         <{/if}>
        </div>       
         <div class="row">
         	<label >数据库类型:<em class="required">*</em></label>
         	<{if $type === 'add'}>
          		<{html_options  class="w150" name="dbType" id="dbType"
                    output=array('oracle','mysql','sysbase','sqlserver2000','sqlserver2005','sqlserver2008','sqlserver2012') 
                    values=array('oracle','mysql','sysbase','sqlserver2000','sqlserver2005','sqlserver2008','sqlserver2012')
                    selected=$res.dbtype|default: 'oracle'  }>
        	<{else}>
        		<input type="text"  value="<{$res.dbtype}>" 
                	<{if $type ==='edit'}>disabled="disabled"<{/if}> /> 
                <{if $type ==='edit'}>
             		<input type="hidden" name="dbType" value="<{$res.dbtype}>"/>
         		<{/if}>            
        	<{/if}>
        </div>        
        <div class="row">
          <label>源地址:<em class="required">*</em></label>
          <{html_options  class="select sa" name="sAddress" id="sAddress"
                    output=$addrOptions values=$addrOptionsvalue
                    selected=$res.sa|default: 'any'}>
        </div>       
        <div class="row">
          <label>目的地址:<em class="required">*</em></label>
          <{html_options  class="select lip" name="lAddress" id="lAddress"
                    output=$localIp values=$localIpValue
                    selected=$res.da|default: 'any'}>
        </div>       
         <div class="row">
          <label>目的端口:<em class="required">*</em></label>
          <input class="port" type="text" name="dportReq" value="<{$res.dport}>" size="5" maxlength="5"/>
        </div>
        
        <div class="row">
          <label>过滤选项:</label>
          <{html_options  class="select time" name="filter" id="filter"
                    output=$filterOptions values=$filterOptions
                    selected=$res.filter|default: 'empty'}>
        </div>
        
         <div class="row">
            <label>是否启动:<em class="required">*</em></label>
            <{html_radios class="radio" name=active label_ids=true values=array('Y', 'N')
                output=array('开', '关') selected=$res.active|default: 'Y'}>
        </div>
        
         <div class="row">
          <label> 认证用户组:</label>
           <{html_options  class="select time" name="roleList" id="roleList"
                    output=$roleList values=$roleList
                    selected=$res.usergrp|default: 'empty'}>
        </div>
        
        <div class="row">
          <label >生效时段:</label>
           <{html_options  class="select time" name="timeList" id="timeList"
                    output=$timeList values=$timeList
                    selected=$res.time|default: 'empty'}>
        </div>
        
        <div class="row">
          <label >备注:</label>          
           <input class="comment" name="comment" id="comment" value="<{$res.comment}>"/>
        </div>
    </fieldset>
</form>
<link rel="stylesheet" href="Public/js/clueTip/jquery.cluetip.css" type="text/css" />
<script type="text/javascript" src="Public/js/clueTip/jquery.hoverIntent.js"></script>
<script type="text/javascript" src="Public/js/clueTip/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="Public/js/clueTip/jquery.cluetip.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	filterRes();
    renderStandardUi();
    validateForm($("#editForm"));
});
</script>