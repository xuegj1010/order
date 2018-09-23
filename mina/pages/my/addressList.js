//获取应用实例
var app = getApp();
Page({
    data: {
        addressList: []
    },
    selectTap: function (e) {
        //从商品详情下单选择地址之后返回
        wx.navigateBack({});
    },
    addessSet: function (e) {
        wx.navigateTo({
            url: "/pages/my/addressSet"
        })
    },
    onShow: function () {
        var that = this;
        that.setData({
            addressList: [
                {
                    id:1,
                    name: "编程浪子",
                    mobile: "12345678901",
                    detail: "上海市浦东新区XX",
                    isDefault: 1
                },
                {
                    id: 2,
                    name: "编程浪子888",
                    mobile: "12345678901",
                    detail: "上海市浦东新区XX"
                }
            ]
        });
    }
});
