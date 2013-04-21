<form action="Function/client/safeBrowse/filterGl.php?filterGl=1" method="POST" id="setFilterGlForm"
    onSubmit="return false;">
    <table class="column_95">
        <caption>HTTP页面过滤</caption>
        <tbody>
        <tr>
            <td class="tdheader" width="250">过滤HTML页面中的Activex控件:</td>
            <td class="tdbody">
                <input class='floatLeft' type="checkbox" name="filterActivex" 
                <{if $filter.activex eq 1}>checked="checked"<{/if}>/>
            </td>
        </tr>
        <tr>
            <td class="tdheader">过滤Http Header中的Cookie信息:</td>
            <td class="tdbody">
            	<input class='floatLeft' type="checkbox" name="filterCookie" 
            	<{if $filter.cookie eq 1}>checked="checked"<{/if}>/>
            </td>
        </tr>
        <tr>
            <td class="tdheader">过滤HTML页面中的script脚本:</td>
            <td class="tdbody">
            	<input class='floatLeft' type="checkbox" name="filterScript" 
            	<{if $filter.javascript eq 1}>checked="checked"<{/if}>/>
            </td>
        </tr>
        <tr>
            <td class="tdheader">禁止加载Java applet小程序:</td>
            <td class="tdbody">
            	<input class='floatLeft' type="checkbox" name="disableJava"
            	<{if $filter.javaapplet eq 1}>checked="checked"<{/if}>/>
            </td>
        </tr>
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" class="inputbtn standard" onclick="setFilterGlConfigForm()">确定</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>

<form action="Function/client/safeBrowse/filterGl.php?mime=1" method="POST" id="setMIMEForm"
    onSubmit="return false;">
    <table class="column_95">
        <caption> MIME类型过滤</caption>
        <tbody>
        <tr>
            <td class="tdheader" width="250">应用程序:</td>
            <td class="tdbody">
                <{html_radios class="radio" name=application label_ids=true values=array('N','P','F')
              output=array('不禁止','部分禁止','全部禁止') selected=$filter.application|default: 'N' 
              	onclick="showAppList()"}>
              	<div id="appListDiv" <{if $filter.application === 'P'}>style="display:block"<{else}>style="display:none"<{/if}>>
              		<{foreach $appList as $key => $app}>
              			<label class="column column_30"><input name="<{$app.name}>" type="checkbox" class="checkbox"
              			<{if <{$app.checkflag}> eq 1}>checked="checked"<{/if}>/><{$app.name}></label>
              			<{if ($key+1)%3 eq 0}><br class="clearFloat"/><{/if}>
              		<{/foreach}>
              		<br class="clearFloat"/>
              	</div>
            </td>
        </tr>
        <tr>
            <td class="tdheader">视频类:</td>
            <td class="tdbody">
            	<{html_radios class="radio" name=video label_ids=true values=array('N','P','F')
              output=array('不禁止','部分禁止','全部禁止') selected=$filter.video|default: 'N' 
              onclick="showVideoList()"}> 
              	<div id="videoListDiv" <{if $filter.video === 'P'}>style="display:block"<{else}>style="display:none"<{/if}>>
              		<{foreach $videoList as $key => $video}>
              			<label class="column column_30"><input name="<{$video.name}>" type="checkbox" class="checkbox"
              			<{if <{$video.checkflag}> eq 1}>checked="checked"<{/if}>/><{$video.name}></label>
              			<{if ($key+1)%3 eq 0}><br class="clearFloat"/><{/if}>
              		<{/foreach}>
              		<br class="clearFloat"/>
              	</div>             	
            </td>
        </tr>
        <tr>
            <td class="tdheader">音频类:</td>
            <td class="tdbody">
            	<{html_radios class="radio" name=audio label_ids=true values=array('N','P','F')
              output=array('不禁止','部分禁止','全部禁止') selected=$filter.audio|default: 'N' 
              onclick="showAudioList()"}>
              	<div id="audioListDiv" <{if $filter.audio === 'P'}>style="display:block"<{else}>style="display:none"<{/if}>>
              		<{foreach $audioList as $key => $audio}>
              			<label class="column column_30"><input name="<{$audio.name}>" type="checkbox" class="checkbox"
              			<{if <{$audio.checkflag}> eq 1}>checked="checked"<{/if}>/><{$audio.name}></label>
              			<{if ($key+1)%3 eq 0}><br class="clearFloat"/><{/if}>
              		<{/foreach}>
              		<br class="clearFloat"/>
              	</div>
            </td>
        </tr>
        <tr>
            <td class="tdheader">图像类:</td>
            <td class="tdbody">
            	<{html_radios class="radio" name=image label_ids=true values=array('N','P','F')
              output=array('不禁止','部分禁止','全部禁止') selected=$filter.image|default: 'N' 
              onclick="showImageList()"}>
              	<div id="imageListDiv" <{if $filter.image === 'P'}>style="display:block"<{else}>style="display:none"<{/if}>>
              		<{foreach $imageList as $key => $image}>
              			<label class="column column_30"><input name="<{$image.name}>" type="checkbox" class="checkbox"
              			<{if <{$image.checkflag}> eq 1}>checked="checked"<{/if}>/><{$image.name}></label>
              			<{if ($key+1)%3 eq 0}><br class="clearFloat"/><{/if}>
              		<{/foreach}>
              		<br class="clearFloat"/>
              	</div>
            </td>
        </tr>
        <tr>
            <td class="tdheader">文本类:</td>
            <td class="tdbody">
            	<{html_radios class="radio" name=text label_ids=true values=array('N','P','F')
              output=array('不禁止','部分禁止','全部禁止') selected=$filter.text|default: 'N' 
              onclick="showTextList()"}>
              	<div id="textListDiv" <{if $filter.text === 'P'}>style="display:block"<{else}>style="display:none"<{/if}>>
              		<{foreach $textList as $key => $text}>
              			<label class="column column_30"><input name="<{$text.name}>" type="checkbox" class="checkbox"
              			<{if <{$text.checkflag}> eq 1}>checked="checked"<{/if}>/><{$text.name}></label>
              			<{if ($key+1)%3 eq 0}><br class="clearFloat"/><{/if}>
              		<{/foreach}>
              		<br class="clearFloat"/>
              	</div>
            </td>
        </tr>
        <tr>
            <td class="tdheader"></td>
            <td class="tdbody">
                <button type="button" class="inputbtn standard" onclick="setMIMEConfigForm()">确定</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>

<script type="text/javascript" src="Public/js/client/safeBrowse/filterGl.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    renderStandardUi();
});
</script>