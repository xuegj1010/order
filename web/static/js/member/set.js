;
var member_set_ops = {
    init: function () {
        this.eventBind();
    },
    eventBind: function () {
        $('.wrap_member_set .save').click(function () {
            var btn_target = $(this);
            if (btn_target.hasClass('disabled')) {
                common_ops.alert('正在处理，请不要重复提交！');
                return;
            }

            var nickname_taget = $('.wrap_member_set input[name=nickname]');
            var nickname = nickname_taget.val();

            if (nickname.length < 1) {
                common_ops.tip("请输入符合规范的姓名!", nickname_taget);
                return;
            }

            btn_target.addClass('disabled');

            var data = {
                nickname: nickname,
                id: $(".wrap_member_set input[name=id]").val()
            };

            $.ajax({
                url: common_ops.buildUrl('/member/set'),
                type: 'POST',
                data: data,
                dataType: 'json',
                success: function (res) {
                    btn_target.removeClass('disabled');
                    var callback = null;
                    if (res.code == 200) {
                        callback = function () {
                            window.location.href = common_ops.buildUrl('/member/index')
                        }
                    }
                    common_ops.alert(res.msg, callback)
                }
            })
        })
    }
};

$(document).ready(function () {
    member_set_ops.init()
});