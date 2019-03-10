;
var upload = {
    error: function (msg) {
        common_ops.alert(msg);

    },
    success: function (file_key) {
        if (!file_key) {
            return;
        }
        var html = '<img src="' + common_ops.buildPicUrl(file_key) + '"/>'
            + '<span class="fa fa-times-circle del del_image" data="' + file_key + '"></span>';

        if ($(".upload_pic_wrap .pic-each").size() > 0) {
            $(".upload_pic_wrap .pic-each").html(html);
        } else {
            $(".upload_pic_wrap").append('<span class="pic-each">' + html + '</span>');
        }
        food_set_ops.delete_img();

    }
};

var food_set_ops = {
    init: function () {
        this.eventBind();
        this.initEditor();
        this.delete_img();
    },
    eventBind: function () {
        $(".wrap_food_set .upload_pic_wrap input[name=pic]").change(function () {
            $(".wrap_food_set .upload_pic_wrap").submit()
        });

        $(".wrap_food_set select[name=cat_id]").select2({
            language: 'zh-CN',
            width: '100%'
        });

        $(".wrap_food_set input[name=tags]").tagsInput({
            language: 'auto',
            height: '40'
        })
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
    },
    delete_img:function () {
        $(".wrap_food_set .del_image").unbind().click(function () {
            $(this).parent().remove();
        })
    }
};

$(document).ready(function () {
    food_set_ops.init();
});