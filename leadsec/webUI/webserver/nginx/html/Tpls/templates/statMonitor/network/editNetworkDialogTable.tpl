    <table class="column_95 textMid">        
        <caption> 网络设备 <{$net.external_name}> 当前接收状态 </caption>
        <tbody>
            <tr>
                <td class="column_25">字节数/Bytes</td>
                <td class="column_10"><{$net.recvBytes}></td>
                <td class="column_25">包数/Packets</td>
                <td class="column_10"><{$net.recvPackets}></td>
                <td class="column_20">错误包数/Errs</td>
                <td class="column_10"><{$net.recvErrs}></td>      
            </tr>
            <tr>
                <td >丢包数/Drop</td>
                <td ><{$net.recvDrop}></td> 
                <td >Fifo包数/Fifo</td>
                <td ><{$net.recvFifo}></td>
                <td >帧数/Frame</td>
                <td ><{$net.recvFrame}></td>     
            </tr>
            <tr>
                <td >压缩包数/Compressed</td>
                <td ><{$net.recvCompressed}></td>
                <td >多播包数/Multicast</td>
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
                <td class="column_25">字节数/Bytes</td>
                <td class="column_10"><{$net.transBytes}></td>
                <td class="column_25">包数/Packets</td>
                <td class="column_10"><{$net.transPackets}></td>
                <td class="column_20">错误包数/Errs</td>
                <td class="column_10"><{$net.transErrs}></td>      
            </tr>
            <tr>
                <td >丢包数/Drop</td>
                <td ><{$net.transDrop}></td> 
                <td >Fifo包数/Fifo</td>
                <td ><{$net.transFifo}></td>
                <td >Colls包数/Colls</td>
                <td ><{$net.transColls}></td>     
            </tr>
            <tr>
                <td >Carrier包数/Carrier</td>
                <td ><{$net.transCarrier}></td>
                <td >压缩包数/Compressed</td>
                <td ><{$net.transCompressed}></td>
                <td ></td>
                <td ></td>      
            </tr>
        </tbody>
    </table>
