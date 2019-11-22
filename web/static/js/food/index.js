;
var food_index_ops = {
    init: function () {
        this.eventBind();
    },
    eventBind: function () {
        var that = this;
        $(".remove").click(function () {
            that.ops("remove", $(this).attr("data"))
        });

        $(".recover").click(function () {
            that.ops("recover", $(this).attr("data"))
        });

        $(".wrap_search .search").click(function () {
            $(".wrap_search").submit();
        })
    },
    ops: function (act, id) {
        var callback = {
            'ok': function () {
                $.ajax({
                    url: common_ops.buildUrl("/food/ops"),
                    type: 'POST',
                    data: {
                        act: act,
                        id: id
                    },
                    dataType: 'json',
                    success: function (res) {
                        var callback = null;
                        if (res.code == 200) {
                            callback = function () {
                                window.location.href = window.location.href;
                            }
                        }
                        common_ops.alert(res.msg, callback)
                    }
                })
            },
            'cancel': null
        }
        common_ops.confirm((act == "remove") ? "確定刪除？" : "確定恢復？", callback)
    }
};

$(document).ready(function () {
    food_index_ops.init();
});