//获取应用实例
var app = getApp();

Page({
    data: {
        goods_list: [
            {
                id:22,
                name: "小鸡炖蘑菇",
                price: "85.00",
                pic_url: "/images/food.jpg",
                number: 1,
            },
            {
                id:22,
                name: "小鸡炖蘑菇",
                price: "85.00",
                pic_url: "/images/food.jpg",
                number: 1,
            }
        ],
        default_address: {
            name: "编程浪子",
            mobile: "12345678901",
            detail: "上海市浦东新区XX",
        },
        yun_price: "1.00",
        pay_price: "85.00",
        total_price: "86.00",
        params: null
    },
    onShow: function () {
        var that = this;
    },
    onLoad: function (e) {
        var that = this;
    },
    createOrder: function (e) {
        wx.showLoading();
        var that = this;
        wx.navigateTo({
            url: "/pages/my/order_list"
        });
    },
    addressSet: function () {
        wx.navigateTo({
            url: "/pages/my/addressSet"
        });
    },
    selectAddress: function () {
        wx.navigateTo({
            url: "/pages/my/addressList"
        });
    }

});
