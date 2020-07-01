SERVER_PORT = 9000
DEBUG = False
SQLALCHEMY_ECHO = False  # 打印sql语句
AUTH_COOKIE_NAME = 'mooc_food'

# 过滤url
IGNORE_URLS = [
    '^/user/login',
]

IGNORE_CHECK_LOGIN_URLS = [
    "^/static",
    "^/favicon.ico"
]
API_IGNORE_URLS = [
    '^/api'
]

PAGE_SIZE = 50
PAGE_DISPLAY = 10

STATUS_MAPPING = {
    '1': '正常',
    '0': '已删除'
}

MINA_APP = {
    'appid': 'wxe3bf7f6fe7085b14',
    'appkey': '51d0388c7760149de5064cff95e538b5',
    "paykey": "",
    "mch_id": "1443337302",
    "callback_url": "/api/order/callback"
}

UPLOAD = {
    'ext': ['jpg', 'gif', 'bmp', 'jpeg', 'png'],
    'prefix_path': '/web/static/upload/',
    'prefix_url': '/static/upload/'
}

APP = {
    'domain': 'http://127.0.0.1:9000'
}

PAY_STATUS_DISPLAY_MAPPING = {
    "0": "订单关闭",
    "1": "支付成功",
    "-8": "待支付",
    "-7": "代发货",
    "-6": "待确认",
    "-5": "待评价"
}
