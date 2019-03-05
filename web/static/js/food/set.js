;
var food_set_ops = {
    init: function () {
        this.eventBind();
        this.initEditor();
    },
    eventBind: function () {

    },
    initEditor: function () {
        var that = this;
        that.ue = UE.getEditor('editor', {
            enableAutoSave: true,
            saveInterval: 60000,
            elementPathEnabled: false,
            zIndex: 4,
            serverUrl: common_ops.buildUrl('/upload/ueditor')
        })
    }
};

$(document).ready(function () {
    food_set_ops.init();
});