<form action="Function/appS/ids/customTest.php" method="POST" id="editCustomTestForm" onSubmit="return false;">
<input type="hidden" name="type" id="customType" value="<{$type|default: 'add'}>"/>
<fieldset>
<legend>自定义规则</legend>
<div class="hide" id="summary"></div>
<div class="row">
	<div class="column column_50">
		<label for="source_address">源地址:<em class="required">*</em></label>
		<input type="text" class="width132" name="source_address" value="<{$list.source_address}>"/>
		<{if $type == 'edit'}>
			<input type="hidden" name="editId" value="<{$list.rule_id}>"/>
		<{/if}>
	</div>
	<div class="column column_50">
		<label for="source_mask">掩码:<em class="required">*</em></label>
		<{html_options name="source_address_msk" id="source_address_msk" class="select"
			output=array('255.255.255.0','255.255.0.0','255.0.0.0') values=array(0,1,2)
		selected=$res.linkmode}>
	</div>
</div>
<div class="row clearFloat"><label for="source_port">源端口：</label>
	<input type="text" name="source_address_port1" id="source_address_port1" 
		style="width:50px" value="<{$list.source_port_start}>"/>
	<label class="maskLabel">到</label>
	<input type="text" name="source_address_port2" id="source_address_port2" 
		style="width:50px" value="<{$list.source_port_end}>"/>
</div>  
<hr class="clearFloat hrb"/>

<div class="row">
	<div class="column column_50">
		<label for="target_address">目的地址:<em class="required">*</em></label>
		<input class="width132" type="text" name="target_address" value="<{$list.target_address}>"/>
	</div>
	<div class="column column_50">
		<label for="target_mask">掩码:<em class="required">*</em></label>
		<{html_options name="target_msk" id="target_msk" class="select"
			output=array('255.255.255.0','255.255.0.0','255.0.0.0') values=array(0,1,2) 
			selected=$res.linkmode}>
	</div>
</div>
<div class="row clearFloat"><label for="target_port">目的端口：</label>
	<input type="text" name="target_port1" style="width:50px" value="<{$list.target_port_start}>"/>
	<label class="maskLabel">到</label>
	<input type="text" name="target_port2" style="width:50px" value="<{$list.target_port_end}>"/>
</div>
<hr class="clearFloat hrb"/>
   
<div class="row">
	<div class="column column_50">
		<label for="txt_ipID">IP包头标识:</label>
		<input type="text" name="txt_ipID" value="<{$list.tos}>"/>
	</div>
	<div class="column column_50">
		<label for="txt_ipTTL">生存期TTL:</label>
		<input type="text" name="txt_ipTTL" value="<{$list.ttl}>"/>
	</div>
</div>
   
<div class="row">
	 <div class="column column_50">
		 <label for="link_mode">协 议:<em class="required">*</em></label>
		 <{html_options class="select" name="link_mode" id="link_mode" onchange="changeToLinkMode()"
			output=array('TCP','UDP','ICMP') values=array('tcp','udp','icmp')
			selected=$list.link_mode|default: 'tcp'}>
	 </div>
	  <div class="column column_50">
		<label for="txt_dsize">数据区长度:</label>
		<input type="text" name="txt_dsize" value="<{$list.dsize}>"/>
	</div>
</div>
   
<div id="tcp_type_div" <{if $list.link_mode neq 'tcp' and $type eq 'edit'}> class="hide"<{/if}>>
	<div class="row clearFloat">
		<div class="column column_50">
			<label for="txt_tcpACKnum">TCP包头确认码(ACK):</label>
			<input type="text" name="txt_tcpACKnum" value="<{$list.ack}>"/>
		</div>
		 <div class="column column_50">
			<label for="txt_tcpSEQnum">TCP包头顺序码(SEQ):</label>
			<input type="text" name="txt_tcpSEQnum" value="<{$list.seq}>"/>
		 </div>
	</div>
	<hr class="clearFloat hrb"/>
	<div class="row">
	<label for="tcp_flag">TCP标志位(从左到右):</label>
		<div class="tcpflag column">
		<label><input type="checkbox" name="retain_1" id="tcp_retain_1" value="x" onClick="chk_one_clicked()"
			<{foreach $checkStr as $k => $val}>
				<{if $val eq '1'}>
					checked="checked"
				<{/if}>
			<{/foreach}>/>保留1</label>
		<label><input type="checkbox" name="retain_2" id="tcp_retain_2" value="y" onClick="chk_one_clicked()"
			<{foreach $checkStr as $k => $val}>
				<{if $val eq '2'}>
					checked="checked"
				<{/if}>
			<{/foreach}>/>保留2</label>
		<label><input type="checkbox" name="urg" id="tcp_urg" value="U" onClick="chk_one_clicked()"
			<{foreach $checkStr as $k => $val}>
				<{if $val eq 'U'}>
					checked="checked"
				<{/if}>
			<{/foreach}>/>URG</label>
		<label><input type="checkbox" name="ack" id="tcp_ack" value="A" onClick="chk_one_clicked()"
		<{foreach $checkStr as $k => $val}>
				<{if $val eq 'A'}>
					checked="checked"
				<{/if}>
			<{/foreach}>/>ACK</label>
		<label><input type="checkbox" name="psh" id="tcp_psh" value="P" onClick="chk_one_clicked()"
			<{foreach $checkStr as $k => $val }>
				<{if $val eq 'P'}>
					checked="checked"
				<{/if}>
			<{/foreach}>/>PSH</label>
		<label><input type="checkbox" name="rst" id="tcp_rst" value="R" onClick="chk_one_clicked()"
			<{foreach $checkStr as $k => $val }>
					<{if $val eq 'R'}>
						checked="checked"
					<{/if}>
				<{/foreach}>/>RST</label>
		<label><input type="checkbox" name="syn" id="tcp_syn" value="S" onClick="chk_one_clicked()"
			<{foreach $checkStr as $k => $val }>
					<{if $val eq 'S'}>
						checked="checked"
					<{/if}>
				<{/foreach}>/>SYN</label>
		<label><input type="checkbox" name="fin" id="tcp_fin" value="F" onClick="chk_one_clicked()" checked/>FIN</label>
		<label><input type="checkbox" name="empty" id="tcp_empty" value="Z" onClick="chk_tcpNULL_clicked()"/>空</label>
		</div>
	</div>
</div>

<div id="icmp_type_div" <{if $list.link_mode neq 'icmp'}> class="hide"<{/if}>>
<div class="row clearFloat">
	<div class="tcptype column">
		<label for="iptype">ICMP类型:</label>
		<{html_radios class="radio" name=rad_icmp label_ids=true
		values=array('0', '3','4','5','8','11','12','13','14','17','18') 
		output=array('0 回应应答', '3 信宿不可达','4 源抑制','5 重定向',
			'8 回应请求','11 数据报超时','12 数据报参数错','13 时戳请求',
			'14 时戳应答','17 地址模请求','18 地址模响应') 
		selected=$list.itype|default: '0'
		}>
	</div>
</div>

<hr class="clearFloat hrb"/>
<div class="row"><label for="txt_icmpcode">ICMP代码:</label>
   <input type="text" name="txt_icmpcode" value="<{$list.icode}>"/>
</div>
</div>
<div class="row">
	 <div class="column column_50">
		 <label for="txt_content">入侵特征码:</label>
		 <input type="text" name="txt_content" value="<{$list.content}>"/>
	 </div>
	  <div class="column column_50">
		<label for="chk_case">区分大小写:</label>
		<input type="checkbox" name="chk_case" value="case" />
	</div>
</div>
   
<div class="row">
	 <div class="column column_50">
		 <label for="txt_offset">偏移量度(offset):</label>
		 <input type="text" name="txt_offset" value="<{$list.offset}>"/>
	 </div>
	  <div class="column column_50">
		<label for="txt_depth">偏移量度(depth):</label>
		<input type="text" name="txt_depth" value="<{$list.depth}>"/>
	</div>
</div>
<div class="row"><label for="txt_msg">定义报警事件主题:<em class="required">*</em></label>
   <input type="text" class="width132" name="txt_msg" value="<{$list.msg}>"/>
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
    validateForm($("#editCustomTestForm"),'summary');
});

</script>
