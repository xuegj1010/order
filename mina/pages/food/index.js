//index.js
//获取应用实例
var app = getApp();
Page({
    data: {
        indicatorDots: true,
        autoplay: true,
        interval: 3000,
        duration: 1000,
        loadingHidden: false, // loading
        swiperCurrent: 0,
        categories: [],
        activeCategoryId: 0,
        goods: [],
        scrollTop: "0",
        loadingMoreHidden: true,
        searchInput: '',
    },
    onLoad: function () {
        var that = this;

        wx.setNavigationBarTitle({
            title: app.globalData.shopName
        });

        that.setData({
            banners: [
                {
                    "id": 1,
                    "pic_url": "/images/food.jpg"
                },
                {
                    "id": 2,
                    "pic_url": "/images/food.jpg"
                },
                {
                    "id": 3,
                    "pic_url": "/images/food.jpg"
                }
            ],
            categories: [
                {id: 0, name: "全部"},
                {id: 1, name: "川菜"},
                {id: 2, name: "东北菜"},
            ],
            activeCategoryId: 0,
			goods: [
			                {
			                    "id": 1,
			                    "name": "小鸡炖蘑菇-1",
			                    "min_price": "15.00",
			                    "price": "15.00",
			                    "pic_url": "/images/food.jpg"
			                },
			                {
			                    "id": 2,
			                    "name": "小鸡炖蘑菇-1",
			                    "min_price": "15.00",
			                    "price": "15.00",
			                    "pic_url": "/images/food.jpg"
			                },
			                {
			                    "id": 3,
			                    "name": "小鸡炖蘑菇-1",
			                    "min_price": "15.00",
			                    "price": "15.00",
			                    "pic_url": "/images/food.jpg"
			                },
			                {
			                    "id": 4,
			                    "name": "小鸡炖蘑菇-1",
			                    "min_price": "15.00",
			                    "price": "15.00",
			                    "pic_url": "/images/food.jpg"
			                }

			 ],
            loadingMoreHidden: false
        });
    },
    scroll: function (e) {
        var that = this, scrollTop = that.data.scrollTop;
        that.setData({
            scrollTop: e.detail.scrollTop
        });
    },
    //事件处理函数
    swiperchange: function (e) {
        this.setData({
            swiperCurrent: e.detail.current
        })
    },
	listenerSearchInput:function( e ){
	        this.setData({
	            searchInput: e.detail.value
	        });
	 },
	 toSearch:function( e ){
	        this.setData({
	            p:1,
	            goods:[],
	            loadingMoreHidden:true
	        });
	        this.getFoodList();
	},
    tapBanner: function (e) {
        if (e.currentTarget.dataset.id != 0) {
            wx.navigateTo({
                url: "/pages/food/info?id=" + e.currentTarget.dataset.id
            });
        }
    },
    toDetailsTap: function (e) {
        wx.navigateTo({
            url: "/pages/food/info?id=" + e.currentTarget.dataset.id
        });
    }
});
