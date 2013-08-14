<table class="column_95" id="transOracleDataIp">
  <tr>
    <td class="tdheader" width="200">ORACLE数据通道IP地址:</td>
    <td class="tdbody">
        <{html_options  class="w150" name="oracleDataIp" id="oracleDataIp"
            output=$localIp values=$localIp selected=$data.dataip|default: 'empty'
            onChange="freshOracleDataIpTable('Function/client/db/transVisit.php',$('#transOracleDataIp'))"
            }>                    
    </td>
  </tr>
</table>