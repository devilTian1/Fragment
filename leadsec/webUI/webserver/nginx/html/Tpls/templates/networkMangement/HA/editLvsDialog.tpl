<form action="Function/networkMangement/HA/lvs.php" method="POST" id="editLvsForm" onSubmit="return false;">
 <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
 <table class="column_95">
    <thead>
    <tr>
      <th class="tdheader"><span class="red">*</span> 虚拟地址:</th>
      <th class="tbody">
          <select name="virtual_name" id="select">
            <option>fs2</option>
          </select>
      </th>
      <th class="tdheader"><span class="red">*</span>虚拟端口:</th>
      <th class="tdbody"><input type="text" name="virtual_port" id="virtual_port" size="6" /></th>
      <th colspan="4">&nbsp;</th>
    </tr>
    </thead>
    <tdbody>
    <tr>
      <td class="tdheader" width="120"><span class="red">*</span> 真实地址1:</td>
      <td class="tdbody"><input name="realaddr1" type="text" id="realaddr1" size="10" /></td>
      <td class="tdheader" width="100"><span class="red">*</span> 端口1:</td>
      <td class="tdbody"><input type="text" name="port1" id="port1"  size="6" /></td>
      <td class="tdheader" width="120"><span class="red">*</span> 真实地址2:</td>
      <td class="tdbody"><input name="realaddr2" type="text" id="realaddr2" size="10" /></td>
      <td class="tdheader" width="80"><span class="red">*</span> 端口2:</td>
      <td class="tdbody"><input type="text" name="port2" id="port2"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader">真实地址3:</td>
      <td class="tdbody"><input name="realaddr3" type="text" id="realaddr3" size="10" /></td>
      <td class="tdheader">端口3:</td>
      <td class="tdbody"><input type="text" name="port3" id="port3"  size="6" /></td>
      <td class="tdheader">真实地址4:</td>
      <td class="tdbody"><input name="realaddr4" type="text" id="realaddr4" size="10" /></td>
      <td class="tdheader">端口4:</td>
      <td class="tdbody"><input type="text" name="port4" id="port4"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>真实地址5:</td>
      <td class="tdbody"><input name="realaddr5" type="text" id="realaddr5" size="10" /></td>
      <td class="tdheader">端口5:</td>
      <td class="tdbody"><input type="text" name="port5" id="port5"  size="6" /></td>
      <td class="tdheader">真实地址6:</td>
      <td class="tdbody"><input name="realaddr6" type="text" id="realaddr6" size="10" /></td>
      <td class="tdheader">端口6:</td>
      <td class="tdbody"><input type="text" name="port6" id="port6"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader">真实地址7:</td>
      <td class="tdbody"><input name="realaddr7" type="text" id="realaddr7" size="10" /></td>
      <td class="tdheader">端口7:</td>
      <td class="tdbody"><input type="text" name="port7" id="port7"  size="6" /></td>
      <td class="tdheader">真实地址8:</td>
      <td class="tdbody"><input name="realaddr8" type="text" id="realaddr8" size="10" /></td>
      <td class="tdheader">端口8:</td>
      <td class="tdbody"><input type="text" name="port8" id="port8"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>真实地址9:</td>
      <td class="tdbody"><input name="realaddr9" type="text" id="realaddr9" size="10" /></td>
      <td class="tdheader">端口9:</td>
      <td class="tdbody"><input type="text" name="port9" id="port9"  size="6" /></td>
      <td class="tdheader">真实地址10:</td>
      <td class="tdbody"><input name="realaddr10" type="text" id="realaddr10" size="10" /></td>
      <td class="tdheader">端口10:</td>
      <td class="tdbody"><input type="text" name="port10" id="port10"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>真实地址11:</td>
      <td class="tdbody"><input name="realaddr11" type="text" id="realaddr11" size="10" /></td>
      <td class="tdheader">端口11:</td>
      <td class="tdbody"><input type="text" name="port11" id="port11"  size="6" /></td>
      <td class="tdheader">真实地址12:</td>
      <td class="tdbody"><input name="realaddr12" type="text" id="realaddr12" size="10" /></td>
      <td class="tdheader">端口12:</td>
      <td class="tdbody"><input type="text" name="port12" id="port12"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>真实地址13:</td>
      <td class="tdbody"><input name="realaddr13" type="text" id="realaddr13" size="10" /></td>
      <td class="tdheader">端口13:</td>
      <td class="tdbody"><input type="text" name="port13" id="port13"  size="6" /></td>
      <td class="tdheader">真实地址14:</td>
      <td class="tdbody"><input name="realaddr14" type="text" id="realaddr14" size="10" /></td>
      <td class="tdheader">端口14:</td>
      <td class="tdbody"><input type="text" name="port14" id="port14"  size="6" /></td>
    </tr>
    <tr>
      <td class="tdheader"><span class="red"></span>真实地址15:</td>
      <td class="tdbody"><input name="realaddr15" type="text" id="realaddr15" size="10" /></td>
      <td class="tdheader">端口15:</td>
      <td class="tdbody"><input type="text" name="port15" id="port15"  size="6" /></td>
      <td class="tdheader">真实地址16:</td>
      <td class="tdbody"><input name="realaddr16" type="text" id="realaddr16" size="10" /></td>
      <td class="tdheader">端口16:</td>
      <td class="tdbody"><input type="text" name="port16" id="port16"  size="6" /></td>
    </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript">
    $(document).ready(function(){
        validateForm($("#editLvsForm"));
    });
</script>
