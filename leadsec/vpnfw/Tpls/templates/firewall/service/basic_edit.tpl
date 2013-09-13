<style type="text/css">
.agreement{ width:260px;}
.agreement div{ width:60px; float:left;}
.agreement div input{ clear:both; width:10px;}

.portdiv{ width:140px; padding:3px 0;}
.portdiv input{ margin-left:10px; width:50px;}
.portdiv span{ margin-left:50px;}
.portdiv em{ font-style:normal; margin-left:50px;}
</style>
<form action="index.php?R=firewall/service/basic/addOrEditBasic" method="POST" id="editBasicListForm" onSubmit="return false;">
     <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>基本服务维护</legend>
        <div class="row">
            <label for="name">名称:<em class="required">*</em></label>
            <{if $type ==='edit'}>
                <span class="floatLeft"><{$basic.name}></span>
                <input type="hidden" name="basicName" value="<{$basic.name}>"/>
            <{elseif $type === 'add'}>
                 <input type="text" name="basicName" id="basicName" value="<{$basic.name}>"/>
            <{/if}>
      </div>
        
        <div class="row">
          <table width="100%" border="1">
  <tr>
    <td rowspan="2">序号</td>
    <td>源端口</td>
    <td>目的端口</td>
    <td rowspan="2">协议</td>
  </tr>
  <tr>
    <td class="portdiv"><span>低</span><em>高</em></td>
    <td class="portdiv"><span>低</span><em>高</em></td>
    </tr>
  <tr>
    <td>1</td>
    <td>
    <div class="portdiv">
       <input class="port" type="text" name="slport1" id="slport1" value="<{$basic.slport1}>"/>
       <input class="port" type="text" name="shport1" id="shport1" value="<{$basic.shport1}>"/>
    </div>
    </td>
    <td>
    <div class="portdiv">
       <input class="port" type="text" name="dlport1" id="dlport1" value="<{$basic.dlport1}>"/>
       <input class="port" type="text" name="dhport1" id="dhport1" value="<{$basic.dhport1}>"/>
    </div>
    </td>
    <td>
    <div class="agreement">
      <div><input type="radio" name="protocol1" value="TCP" checked="checked" />TCP</div>
      <div><input type="radio" name="protocol1" value="UDP" />UDP</div>
      <div><input type="radio" name="protocol1" value="Other" />Other</div>
      <input class="port" type="text" name="protocolv1" value=""/>
    </div>
    </td>
  </tr>
  <tr>
    <td>2</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="slport2" id="slport2" value="<{$basic.slport2}>"/>
      <input class="port" type="text" name="shport2" id="shport2" value="<{$basic.shport2}>"/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="dlport2" id="dlport2" value="<{$basic.dlport2}>"/>
      <input class="port" type="text" name="dhport2" id="dhport2" value="<{$basic.dhport2}>"/>
    </div></td>
    <td><div class="agreement">
      <div><input type="radio" name="protocol2" value="TCP" checked="checked" />TCP</div>
      <div><input type="radio" name="protocol2" value="UDP" />UDP</div>
      <div><input type="radio" name="protocol2" value="Other" />Other</div>
      <input class="port" type="text" name="protocolv2" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>3</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="slport3" id="slport3" value="<{$basic.slport3}>"/>
      <input class="port" type="text" name="shport3" id="shport3" value="<{$basic.shport3}>"/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="dlport3" id="dlport3" value="<{$basic.dlport3}>"/>
      <input class="port" type="text" name="dhport3" id="dhport3" value="<{$basic.dhport3}>"/>
    </div></td>
    <td><div class="agreement">
      <div><input type="radio" name="protocol3" value="TCP" checked="checked"/>TCP</div>
      <div><input type="radio" name="protocol3" value="UDP" />UDP</div>
      <div><input type="radio" name="protocol3" value="Other" />Other</div>
      <input class="port" type="text" name="protocolv3" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>4</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="slport4" id="slport4" value="<{$basic.slport4}>"/>
      <input class="port" type="text" name="shport4" id="shport4" value="<{$basic.shport4}>"/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="dlport4" id="dlport4" value="<{$basic.dlport4}>"/>
      <input class="port" type="text" name="dhport4" id="dhport4" value="<{$basic.dhport4}>"/>
    </div></td>
    <td><div class="agreement">
      <div><input type="radio" name="protocol4" value="TCP" checked="checked" />TCP</div>
      <div><input type="radio" name="protocol4" value="UDP" />UDP</div>
      <div><input type="radio" name="protocol4" value="Other" />Other</div>
      <input class="port" type="text" name="protocolv4" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>5</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="slport5" id="slport5" value="<{$basic.slport5}>"/>
      <input class="port" type="text" name="shport5" id="shport5" value="<{$basic.shport5}>"/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="dlport5" id="dlport5" value="<{$basic.dlport5}>"/>
      <input class="port" type="text" name="dhport5" id="dhport5" value="<{$basic.dhport5}>"/>
    </div></td>
    <td><div class="agreement">
      <div><input type="radio" name="protocol5" value="TCP" checked="checked" />TCP</div>
      <div><input type="radio" name="protocol5" value="UDP" />UDP</div>
      <div><input type="radio" name="protocol5" value="Other" />Other</div>
      <input class="port" type="text" name="protocolv5" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>6</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="slport6" id="slport6" value="<{$basic.slport6}>"/>
      <input class="port" type="text" name="shport6" id="shport6" value="<{$basic.shport6}>"/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="dlport6" id="dlport6" value="<{$basic.dlport6}>"/>
      <input class="port" type="text" name="dhport6" id="dhport6" value="<{$basic.dhport6}>"/>
    </div></td>
    <td><div class="agreement">
      <div><input type="radio" name="protocol6" value="TCP" checked="checked" />TCP</div>
      <div><input type="radio" name="protocol6" value="UDP" />UDP</div>
      <div><input type="radio" name="protocol6" value="Other" />Other</div>
      <input class="port" type="text" name="protocolv6" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>7</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="slport7" id="slport7" value="<{$basic.slport7}>"/>
      <input class="port" type="text" name="shport7" id="shport7" value="<{$basic.shport7}>"/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="dlport7" id="dlport7" value="<{$basic.dlport7}>"/>
      <input class="port" type="text" name="dhport7" id="dhport7" value="<{$basic.dhport7}>"/>
    </div></td>
    <td><div class="agreement">
      <div><input type="radio" name="protocol7" value="TCP" checked="checked" />TCP</div>
      <div><input type="radio" name="protocol7" value="UDP" />UDP</div>
      <div><input type="radio" name="protocol7" value="Other" />Other</div>
      <input class="port" type="text" name="protocolv7" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>8</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="slport8" id="slport8" value="<{$basic.slport8}>"/>
      <input class="port" type="text" name="shport8" id="shport8" value="<{$basic.shport8}>"/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="dlport8" id="dlport8" value="<{$basic.dlport8}>"/>
      <input class="port" type="text" name="dhport8" id="dhport8" value="<{$basic.dhport8}>"/>
    </div></td>
    <td><div class="agreement">
      <div><input type="radio" name="protocol8" value="TCP" checked="checked" />TCP</div>
      <div><input type="radio" name="protocol8" value="UDP" />UDP</div>
      <div><input type="radio" name="protocol8" value="Other" />Other</div>
      <input class="port" type="text" name="protocolv8" value=""/>
    </div></td>
  </tr>
</table>
</div>
        <div class="row">
            <label for="comment">备注:</label>            
            <input class="comment" name="comment" id="comment" value="<{$basic.comment}>"/> 
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
		validateForm($("#editBasicListForm"));			   
    });
</script>
