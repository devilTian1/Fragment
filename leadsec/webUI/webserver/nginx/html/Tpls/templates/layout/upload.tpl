<div style="position: relative;float:left">
    <input class="uploadText uploadText_<{$id}>" type="input"
        readonly="readonly"/>
    <input class="uploadBtn uploadBtn_<{$id}>" type="button" value="浏览..."/>
    <input class="uploadEle" type="file" name="<{$name}>" id="<{$id}>"
        onChange="$('.uploadText_<{$id}>').val($(this).val())"
        onKeypress="if(navigator.userAgent.indexOf('MSIE 6.0')>0) {return false;}"
	onpaste="if(navigator.userAgent.indexOf('MSIE 6.0')>0) {return false;}"/>
</div>
