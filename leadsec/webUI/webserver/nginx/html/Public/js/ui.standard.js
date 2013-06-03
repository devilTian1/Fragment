function renderStandardUi() {
	$("input.standard").button({
    });
    $("button.standard").button({
    });
    $("button.trash").button({
        icons: {
            primary: 'ui-icon-trash'
        },
        text: false
    });
    $("button.edit").button({
        icons: {
            primary: 'ui-icon-pencil'
        }
    });
    $("button.save").button({
        icons: {
            primary: 'ui-icon-disk'
        }
    });
    $("button.reset").button({
        icons: {
            primary: 'ui-icon-arrowreturnthick-1-s'
        }
    });
    $("button.up").button({
        icons: {
            primary: 'ui-icon-arrowreturn-1-n'
        }
    });
    $("button.down").button({
        icons: {
            primary: 'ui-icon-arrowreturn-1-s'
        }
    });
    $("button.new").button({
        icons: {
            primary: 'ui-icon-plusthick'
        }
    });
    $("button.add").button({
        icons: {
            primary: 'ui-icon-circle-plus'
        }
    });
    $("button.close").button({
        icons: {
            primary: 'ui-icon-closethick'
        }
    });
    $("button.next").button({
        icons: {
            primary: 'ui-icon-carat-1-e'
        }
    });
    $("button.start").button({
        icons: {
            primary: 'ui-icon-play'
        }
    });
    $("button.stop").button({
        icons: {
            primary: 'ui-icon-stop'
        }
    });
    $("button.restart").button({
        icons: {
            primary: 'ui-icon-refresh'
        }
    });
    $("button.browse").button({
        icons: {
            primary: 'ui-icon-folder-open'
        }
    });
    $("button.submit").button({
    });
    $("button.login").button({
        icons: {
            primary: 'ui-icon-key'
        }
    });
    $("button.document").button({
        icons: {
            primary: 'ui-icon-document'
        }
    });
    $("button.search").button({
        icons: {
            primary: 'ui-icon-search'
        }
    });
    $("button.script").button({
        icons: {
            primary: 'ui-icon-script'
        }
    });
    $("button.kill").button({
        icons: {
            primary: 'ui-icon-close'
        }
    });
    $("button.hold").button({
        icons: {
            primary: 'ui-icon-cancel'
        }
    });
    $("button.release").button({
        icons: {
            primary: 'ui-icon-clock'
        }
    });
    $("button.suspend").button({
        icons: {
            primary: 'ui-icon-pause'
        }
    });
    $("button.resume").button({
        icons: {
            primary: 'ui-icon-play'
        }
    });
    $("button.parentDir").button({
        icons: {
            primary: 'ui-icon-circle-triangle-w'
        }
    });
    $("button.childDir").button({
        icons: {
            primary: 'ui-icon-circle-triangle-e'
        }
    });
    $("button.download").button({
        icons: {
            primary: 'ui-icon-arrowthick-1-s'
        }
    });
    $("button.add").button({
        icons: {
            primary: 'ui-icon-triangle-1-n'
        },
        text:false
    });
    $("button.suppGroups").button({
        icons: {
            primary: 'ui-icon-pencil'
        },
        text:false
    });
    $("button.boomadd").button({
        icons: {
            primary: 'ui-icon-eject'
        },
        text:false
    });

    // Pager Buttons
    $(".pager a.first").button({
        icons: {
            primary: 'ui-icon-seek-first'
        },
        text: false
    });
    $(".pager a.prev").button({
        icons: {
            primary: 'ui-icon-seek-prev'
        },
        text: false
    });
    $(".pager a.next").button({
        icons: {
            primary: 'ui-icon-seek-next'
        },
        text: false
    });
    $(".pager a.last").button({
        icons: {
            primary: 'ui-icon-seek-end'
        },
        text: false
    });

    // Error message
    $(".error")
        .addClass("ui-state-error ui-corner-all")
        .css("margin", "1em")
        .css("padding", "1em")
        .css("text-align", "left");
}

$(document).ready(renderStandardUi);

