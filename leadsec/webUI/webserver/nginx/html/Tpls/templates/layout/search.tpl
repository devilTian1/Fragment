<div class="search">
    <input type="hidden" id="colNames" value="<{$colNames}>"/>
    <input type="hidden" id="isInitSearch" value='0'/>
    <input type="text" value="请输入关键字"
        onfocus="focusFunc('请输入关键字')" onblur="blurFunc('请输入关键字')"
        id="search"/>&nbsp;
    <button class="standard" style="margin: auto 0; position: static"
        onClick="setInitSearch(true);freshTableAndPage();setInitSearch(false);"
        id="searchBtn">查找</button>
</div>
<div class="clearFloat"></div>
