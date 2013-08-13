<style type="text/css">
.agreement{ width:260px;}
.agreement div{ width:60px; float:left;}
.agreement div input{ clear:both; width:10px;}

.portdiv{ width:140px; padding:3px 0;}
.portdiv input{ margin-left:10px; width:50px;}
.portdiv span{ margin-left:50px;}
.portdiv em{ font-style:normal; margin-left:50px;}
</style>
<form action="Function/client/customized/udpTransVisit.php" method="POST"
    id="editUdpTransClientAclForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <fieldset>
        <legend>添加基本服务</legend>
        <div class="row">
            <label for="name">名称:<em class="required">*</em></label>
            <input type="text" name="name" id="name" value=""/>
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
       <input class="port" type="text" name="name" id="name" value=""/>
       <input class="port" type="text" name="name2" id="name2" value=""/>
    </div>
    </td>
    <td>
    <div class="portdiv">
       <input class="port" type="text" name="name" id="name" value=""/>
       <input class="port" type="text" name="name2" id="name2" value=""/>
    </div>
    </td>
    <td>
    <div class="agreement">
      <div><input type="radio" name="radio1" value="TCP" checked="checked" />TCP</div>
      <div><input type="radio" name="radio1" value="UDP" />UDP</div>
      <div><input type="radio" name="radio1" value="Other" />Other</div>
      <input class="port" type="text" name="radiov1" value=""/>
    </div>
    </td>
  </tr>
  <tr>
    <td>2</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name3" id="name3" value=""/>
      <input class="port" type="text" name="name3" id="name4" value=""/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name10" id="name17" value=""/>
      <input class="port" type="text" name="name10" id="name18" value=""/>
    </div></td>
    <td><div class="agreement">
      <div>
        <input type="radio" name="radio2" value="TCP" checked="checked" />
        TCP</div>
      <div>
        <input type="radio" name="radio2" value="UDP" />
        UDP</div>
      <div>
        <input type="radio" name="radio2" value="Other" />
        Other</div>
      <input class="port" type="text" name="radiov2" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>3</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name4" id="name5" value=""/>
      <input class="port" type="text" name="name4" id="name6" value=""/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name11" id="name19" value=""/>
      <input class="port" type="text" name="name11" id="name20" value=""/>
    </div></td>
    <td><div class="agreement">
      <div>
        <input type="radio" name="radio3" value="TCP" checked="checked"/>
        TCP</div>
      <div>
        <input type="radio" name="radio3" value="UDP" />
        UDP</div>
      <div>
        <input type="radio" name="radio3" value="Other" />
        Other</div>
      <input class="port" type="text" name="radiov3" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>4</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name5" id="name7" value=""/>
      <input class="port" type="text" name="name5" id="name8" value=""/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name12" id="name21" value=""/>
      <input class="port" type="text" name="name12" id="name22" value=""/>
    </div></td>
    <td><div class="agreement">
      <div>
        <input type="radio" name="radio4" value="TCP" checked="checked" />
        TCP</div>
      <div>
        <input type="radio" name="radio4" value="UDP" />
        UDP</div>
      <div>
        <input type="radio" name="radio4" value="Other" />
        Other</div>
      <input class="port" type="text" name="radiov4" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>5</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name6" id="name9" value=""/>
      <input class="port" type="text" name="name6" id="name10" value=""/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name13" id="name23" value=""/>
      <input class="port" type="text" name="name13" id="name24" value=""/>
    </div></td>
    <td><div class="agreement">
      <div>
        <input type="radio" name="radio5" value="TCP" checked="checked" />
        TCP</div>
      <div>
        <input type="radio" name="radio5" value="UDP" />
        UDP</div>
      <div>
        <input type="radio" name="radio5" value="Other" />
        Other</div>
      <input class="port" type="text" name="radiov5" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>6</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name7" id="name11" value=""/>
      <input class="port" type="text" name="name7" id="name12" value=""/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name14" id="name25" value=""/>
      <input class="port" type="text" name="name14" id="name26" value=""/>
    </div></td>
    <td><div class="agreement">
      <div>
        <input type="radio" name="radio6" value="TCP" checked="checked" />
        TCP</div>
      <div>
        <input type="radio" name="radio6" value="UDP" />
        UDP</div>
      <div>
        <input type="radio" name="radio6" value="Other" />
        Other</div>
      <input class="port" type="text" name="radiov6" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>7</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name8" id="name13" value=""/>
      <input class="port" type="text" name="name8" id="name14" value=""/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name15" id="name27" value=""/>
      <input class="port" type="text" name="name15" id="name28" value=""/>
    </div></td>
    <td><div class="agreement">
      <div>
        <input type="radio" name="radio7" value="TCP" checked="checked" />
        TCP</div>
      <div>
        <input type="radio" name="radio7" value="UDP" />
        UDP</div>
      <div>
        <input type="radio" name="radio7" value="Other" />
        Other</div>
      <input class="port" type="text" name="radiov7" value=""/>
    </div></td>
  </tr>
  <tr>
    <td>8</td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name9" id="name15" value=""/>
      <input class="port" type="text" name="name9" id="name16" value=""/>
    </div></td>
    <td><div class="portdiv">
      <input class="port" type="text" name="name16" id="name29" value=""/>
      <input class="port" type="text" name="name16" id="name30" value=""/>
    </div></td>
    <td><div class="agreement">
      <div>
        <input type="radio" name="radio8" value="TCP" checked="checked" />
        TCP</div>
      <div>
        <input type="radio" name="radio8" value="UDP" />
        UDP</div>
      <div>
        <input type="radio" name="radio8" value="Other" />
        Other</div>
      <input class="port" type="text" name="radiov8" value=""/>
    </div></td>
  </tr>
</table>

</div>

        <div class="row">
            <label for="comment">备注:</label>            
            <input class="comment" name="comment" id="comment" value=""/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(document).ready(function() {
							   
    });
</script>
