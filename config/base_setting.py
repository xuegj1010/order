SERVER_PORT = 9000
DEBUG = False
SQLALCHEMY_ECHO = False  # 打印sql语句
AUTH_COOKIE_NAME = 'mooc_food'

# 过滤url
IGNORE_URLS = [
    '^/user/login',
    '^/api'
]

IGNORE_CHECK_LOGIN_URLS = [
    "^/static",
    "^/favicon.ico"
]

PAGE_SIZE = 50
PAGE_DISPLAY = 10

STATUS_MAPPING = {
    '1': '正常',
    '0': '已删除'
}

MINA_APP = {
    'appid': 'wxe3bf7f6fe7085b14',
    'appkey': '51d0388c7760149de5064cff95e538b5'
}
