<form action="Function/statMonitor/network/network.php" method="POST" id="editNetworkForm" onSubmit="return false;">
    <input type="hidden" name="externalName" value="<{$type|default: add}>"/>
    <table class="column_95 textMid">        
        <caption> 网络设备 <{$net.external_name}> 当前接收状态 </caption>
        <tbody>
            <tr>
                <td class="column_20">Bytes</td>
                <td class="column_15"><{$net.recvBytes}></td>
                <td class="column_20">Packets</td>
                <td class="column_15"><{$net.recvPackets}></td>
                <td class="column_15">Errs</td>
                <td class="column_15"><{$net.recvErrs}></td>      
            </tr>
            <tr>
                <td >Drop</td>
                <td ><{$net.recvDrop}></td> 
                <td >Fifo</td>
                <td ><{$net.recvFifo}></td>
                <td >Frame</td>
                <td ><{$net.recvFrame}></td>     
            </tr>
            <tr>
                <td >Compressed</td>
                <td ><{$net.recvCompressed}></td>
                <td >Multicast</td>
                <td ><{$net.recvMulticast}></td>
                <td ></td>
                <td ></td>      
            </tr>
        </tbody>
    </table>
    <br>
    <table class="column_95 textMid">        
        <caption> 网络设备 <{$net.external_name}> 当前发送状态 </caption>
        <tbody>
            <tr>
                <td class="column_20">Bytes</td>
                <td class="column_15"><{$net.transBytes}></td>
                <td class="column_20">Packets</td>
                <td class="column_15"><{$net.transPackets}></td>
                <td class="column_15">Errs</td>
                <td class="column_15"><{$net.transErrs}></td>      
            </tr>
            <tr>
                <td >Drop</td>
                <td ><{$net.transDrop}></td> 
                <td >Fifo</td>
                <td ><{$net.transFifo}></td>
                <td >Colls</td>
                <td ><{$net.transColls}></td>     
            </tr>
            <tr>
                <td >Carrier</td>
                <td ><{$net.transCarrier}></td>
                <td >Compressed</td>
                <td ><{$net.transCompressed}></td>
                <td ></td>
                <td ></td>      
            </tr>
        </tbody>
    </table>
</form>