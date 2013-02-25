<form action="Function/client/msgTrans/msgTrans.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label >任务号:<em class="required">*</em></label>
          <input type="text" name="msgTransId" value="<{$res.id}>" 
           <{if $type ==='edit'}>disabled="disabled"<{/if}>
           />(同一端的任务号必须唯一)
         <{if $type ==='edit'}>
             <input type="hidden" name="msgTransId" value="<{$res.id}>"/>
         <{/if}>
        </div>
        <div class="row">
            <label for="active">ip地址类型:</label>
            <{html_radios class="radio" name=ipType label_ids=true
                output=array('ipv4', 'ipv6')
                values=array('ipv4', 'ipv6')
                selected=$res.ip_ver|default: 'ipv4'
                onClick="filterRes()"}>
        </div>
        <div class="row">
          <label>源地址:</label>
          <{html_options  class="w200" name="sAddress" id="sAddress"
                    output=$addrOptions values=$addrOptionsvalue
                    selected=$res.sa|default: $res.sa}>
        </div>
        
        <div class="row">
          <label>本机地址:<em class="required">*</em></label>
          <{html_options  class="w200" name="lAddress" id="lAddress"
                    output=$localIp values=$localIp
                    selected=$res.lip|default: 'any'}>
        </div>
        
  		<div class="row">
          <label>本机端口:<em class="required">*</em></label>
          <input type="text" name="lport" value="<{$res.lport}>" />(1-65535)
        </div>
        
       <div class="row">
            <label>HTTP身份认证及传输加密:</label>
            <{html_radios class="radio" name=ssl label_ids=true values=array('Y', 'N')
                output=array('是', '否') selected=$res.ssl|default: 'N'}>
       </div>
       
       <div class="row">
            <label>病毒扫描:</label>
            <{html_radios class="radio" name=scanvirus label_ids=true values=array('Y', 'N')
                output=array('是', '否') selected=$res.scanvirus|default: 'N'}>
       </div>
        
       <div class="row">
            <label>本机备份:</label>
            <{html_radios class="radio" name=backup label_ids=true values=array('Y', 'N')
                output=array('是', '否') selected=$res.backup|default: 'N'  
                disabled="disabled"}>
       </div>
        
       <div class="row">
            <label>是否启动:</label>
            <{html_radios class="radio" name=active label_ids=true values=array('ok', 'erro')
                output=array('是', '否') selected=$res.active|default: 'ok'}>
       </div>
        
       <div class="row">
          <label for="destip">生效时段:</label>
           <{html_options  class="w200" name="timeList" id="timeList"
                    output=$timeList values=$timeList
                    selected=$res.time|default: 'empty'}>
        </div>
        
        <div class="row">
          <label >备注:</label>
          <textarea cols="30" name="comment"><{$res.comment}></textarea>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function(){
	filterRes();
    renderStandardUi();
    validateForm($("#editForm"));
});
</script>