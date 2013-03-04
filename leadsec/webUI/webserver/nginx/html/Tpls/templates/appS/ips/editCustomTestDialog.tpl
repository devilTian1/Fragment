<form action="Function/appS/ips/customTest.php" method="POST" id="editCustomTestForm" onSubmit="return false;">
    <input type="hidden" name="type" value="edit"/>
    <fieldset>
       <!--<legend>修改自定义规则</legend>-->
       <div class="hide" id="summary"></div>
       
       <div class="row">
       		 <div class="column column_50">
                 <label for="source_address">源地址:<em class="required">*</em></label>
                 <input type="text" name="source_address" value="<{$res.external_name}>"/>
             </div>
              <div class="column column_50">
                <label for="source_mask">掩码:<em class="required">*</em></label>
                <{html_options name="linkmode" id="linkmode" class="select"
                    output=array('255.255.255.0','255.255.0.0','255.0.0.0') values=array(0,1,2)
                    selected=$res.linkmode}>
        	</div>
	   </div>
       <div class="row clearFloat"><label for="source_port">源端口：</label>
                <input type="text" name="port1" value="<{$res.ip}>" /><label class="maskLabel">-</label>
                <input type="text" name="port2" value="<{$res.mask}>"/>
       </div>
       
       <hr class="clearFloat hrb"/>
       
       <div class="row">
       		 <div class="column column_50">
                 <label for="target_address">目的地址:<em class="required">*</em></label>
                 <input type="text" name="source_address" value="<{$res.external_name}>"/>
             </div>
              <div class="column column_50">
                <label for="target_mask">掩码:<em class="required">*</em></label>
                <{html_options name="linkmode" id="linkmode" class="select"
                    output=array('255.255.255.0','255.255.0.0','255.0.0.0') values=array(0,1,2)
                    selected=$res.linkmode}>
        	</div>
	   </div>
       <div class="row clearFloat"><label for="target_port">目的端口：</label>
                <input type="text" name="port1" value="<{$res.ip}>" /><label class="maskLabel">-</label>
                <input type="text" name="port2" value="<{$res.mask}>"/>
       </div>
       
       <hr class="clearFloat hrb"/>
       
       <div class="row">
       		 <div class="column column_50">
                 <label for="source_address">IP包头标识:</label>
                 <input type="text" name="source_address" value="<{$res.external_name}>"/>
             </div>
              <div class="column column_50">
                <label for="source_address">生存期TTL:</label>
                <input type="text" name="source_address" value="<{$res.external_name}>"/>
        	</div>
	   </div>
       
       <div class="row">
       		 <div class="column column_50">
                 <label for="source_address">IP包头标识:<em class="required">*</em></label>
                 <{html_options name="linkmode" id="linkmode" class="select"
                    output=array('ICMP','TCP') values=array(0,1)
                    selected=$res.linkmode}>
             </div>
              <div class="column column_50">
                <label for="source_address">数据区长度:</label>
                <input type="text" name="source_address" value="<{$res.external_name}>"/>
        	</div>
	   </div>
       
       <div class="row clearFloat">
       		 <div class="column column_50">
                 <label for="source_address">TCP包头确认码(ACK):</label>
                 <input type="text" name="source_address" value="<{$res.external_name}>"/>
             </div>
              <div class="column column_50">
                <label for="source_address">TCP包头确认码(SEQ):</label>
                <input type="text" name="source_address" value="<{$res.external_name}>"/>
        	</div>
	   </div>
       <hr class="clearFloat hrb"/>
       <div class="row">
       		<label for="source_address">TCP标志位(从左到右):</label>
       		 <div class="tcpflag column">
                 <label><input name="" type="checkbox" value="" />保留1</label>
                 <label><input name="" type="checkbox" value="" />保留2</label>
                 <label><input name="" type="checkbox" value="" />URG</label>
                 <label><input name="" type="checkbox" value="" />ACK</label>
                 <label><input name="" type="checkbox" value="" />PSM</label>
                 <label><input name="" type="checkbox" value="" />RST</label>
                 <label><input name="" type="checkbox" value="" />SYN</label>
                 <label><input name="" type="checkbox" value="" />FIN</label>
                 <label><input name="" type="checkbox" value="" />空</label>
             </div>
	   </div>
       <div class="row clearFloat">
       		<label for="source_address">TCP类型:</label>
       		 <div class="tcptype column">
                 <label><input name="tcptype" type="radio" value="" />0 回应应答</label>
                 <label><input name="tcptype" type="radio" value="" />3 信宿不可达</label>
                 <label><input name="tcptype" type="radio" value="" />4 源抑制</label>
                 <label><input name="tcptype" type="radio" value="" />5 重定向</label>
                 <label><input name="tcptype" type="radio" value="" />8 回应请求</label>
                 <label><input name="tcptype" type="radio" value="" />11 数据报超时</label>
                 <label><input name="tcptype" type="radio" value="" />12 数据报参数错</label>
                 <label><input name="tcptype" type="radio" value="" />13 时露请求</label>
                 <label><input name="tcptype" type="radio" value="" />14 时露应答</label>
                 <label><input name="tcptype" type="radio" value="" />17 地址模请求</label>
                 <label><input name="tcptype" type="radio" value="" />18 地址模应答</label>
             </div>
	   </div>
        <hr class="clearFloat hrb"/>
        
        <div class="row"><label for="ipmac_check">TCMP代码:</label>
           <input type="text" name="source_address" value="<{$res.external_name}>"/>
        </div>
       
       <div class="row">
       		 <div class="column column_50">
                 <label for="source_address">入侵特征码:</label>
                 <input type="text" name="source_address" value="<{$res.external_name}>"/>
             </div>
              <div class="column column_50">
                <label for="source_mask">区分大小写:</label>
                <input name="" type="checkbox" value="" />
        	</div>
	   </div>
       
       <div class="row">
       		 <div class="column column_50">
                 <label for="source_address">偏移量度(offset):</label>
                 <input type="text" name="source_address" value="<{$res.external_name}>"/>
             </div>
              <div class="column column_50">
                <label for="source_mask">偏移量度(depth):</label>
                <input type="text" name="source_address" value="<{$res.external_name}>"/>
        	</div>
	   </div>
       <div class="row"><label for="ipmac_check">定义报警事件主题:<em class="required">*</em></label>
           <input type="text" name="source_address" value="<{$res.external_name}>"/>
        </div>
  </fieldset>
</form>
<style type="text/css">
	fieldset label {
		width:15em;
	}
	.hrb{}
	.tcpflag label{ float:left; width:80px;}
	.tcpflag label input{ width:10px;}
	.tcptype label{ float:left; width:150px;}
	.tcptype label input{ width:10px;}
</style>
<script type="text/javascript">
    $(document).ready(function(){
      
    });
</script>
