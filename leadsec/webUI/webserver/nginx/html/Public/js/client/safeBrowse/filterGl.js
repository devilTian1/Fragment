function setFilterGlConfigForm() {
    ajaxSubmitForm($('#setFilterGlForm'), '设置HTTP页面过滤');
}

function setMIMEConfigForm() {
    ajaxSubmitForm($('#setMIMEForm'), '设置MIME类型过滤');
}

function showAppList() {
	if ($("input:radio[name='application']:checked").val() == 'P') {
		$("#appListDiv").css("display",'block');
	} else {
		$("#appListDiv").css("display",'none');
	}
	$("#mainContent").getNiceScroll().resize();
}

function showVideoList() {
	if ($("input:radio[name='video']:checked").val() == 'P') {
		$("#videoListDiv").css("display",'block');
	} else {
		$("#videoListDiv").css("display",'none');
	}
	$("#mainContent").getNiceScroll().resize();
}

function showAudioList() {
	if ($("input:radio[name='audio']:checked").val() == 'P') {
		$("#audioListDiv").css("display",'block');
	} else {
		$("#audioListDiv").css("display",'none');
	}
	$("#mainContent").getNiceScroll().resize();
}

function showImageList() {
	if ($("input:radio[name='image']:checked").val() == 'P') {
		$("#imageListDiv").css("display",'block');
	} else {
		$("#imageListDiv").css("display",'none');
	}
	$("#mainContent").getNiceScroll().resize();
}

function showTextList() {
	if ($("input:radio[name='text']:checked").val() === 'P') {
		$("#textListDiv").css("display",'block');
	} else {
		$("#textListDiv").css("display",'none');
	}
	$("#mainContent").getNiceScroll().resize();
}