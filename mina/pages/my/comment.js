//获取应用实例
var app = getApp();
Page({
    data: {
        "content":"非常愉快的订餐体验~~",
        "score":10,
        "order_sn":""
    },
    onLoad: function (e) {

    },
    scoreChange:function( e ){
        this.setData({
            "score":e.detail.value
        });
    },
    doComment:function(){
        var that = this;
        wx.request({
            url: app.buildUrl("/my/comment/add"),
            header: app.getRequestHeader(),
            success: function (res) {
                var resp = res.data;
                if (resp.code != 200) {
                    app.alert({"content": resp.msg});
                    return;
                }
                that.setData({
                   user_info:resp.data.info
                });
            }
        });
    }
});