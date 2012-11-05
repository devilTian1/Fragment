    <fieldset>
        <legend>客户端普通访问添加</legend>
        <div>
            <label for="mid">任务号:<em class="required">*</em></label>
            <input type="text" name="mid" id="mid"/>
            <span>(同一端的任务号必须唯一)</span>
        </div>
        <br class="clearFloat"/>
        <div>
            <label for="saddr">源地址:</label>
            <select name="saddr" id="saddr">
                <option value="1">10.1.1.1</option>
                <option value="2">255.255.255.255</option>
                <option value="3">192.168.3.189</option>
            </select>
        </div>
        <br class="clearFloat"/>
        <div>
            <label for="daddr">目的地址:</label>
            <select name="daddr" id="daddr">
                <option value="1">10.1.1.1</option>
                <option value="2">255.255.255.255</option>
                <option value="3">192.168.3.189</option>
            </select>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="dport">目的端口:<em class="required">*</em></label>
            <input type="text" name="dport" id="dport" maxlength="5"/>
            <span>(1 - 65535)</span>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="virusScan">流病毒扫描:</label>
            <span><input class="radio" type="radio" name="virusScan"/>开</span>
            <span><input class="radio" type="radio" name="virusScan"/>关</span>
            <br class="clearFloat"/>
        </div>
        <div>
            <label for="auGroup">认证用户组:</label>
            <select name="auGroup" id="auGroup">
                <option value="1">admin</option>
                <option value="2">wangqi</option>
                <option value="3">RenWinFLy</option>
            </select>
            <br class="clearFloat"/>
        </div>
    </fieldset>
