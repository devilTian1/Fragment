<div class="search">
    <input type="text" value="请输入关键字"
        onfocus="$(this).val('')" id="search"/>&nbsp;
    <button class="standard" style="margin: auto 0; position: static"
        onClick="searchKeyData('<{$tableId}>')"
        id="searchBtn">查找</button>
</div>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
});
</script>
