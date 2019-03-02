import hashlib
import base64
import random
import string

import requests

from application import app


class MemberService:

    @staticmethod
    def gene_auth_code(member_info):
        """生成授权码"""
        m = hashlib.md5()
        raw_str = "%s-%s-%s" % (member_info.id, member_info.salt, member_info.status)
        m.update(raw_str.encode("utf-8"))
        return m.hexdigest()

    @staticmethod
    def gene_salt(length=16):
        keys = [random.choice((string.ascii_letters + string.digits)) for _ in range(length)]
        return ("".join(keys))

    @staticmethod
    def getWeChatOpenId(code):
        url = 'https://api.weixin.qq.com/sns/jscode2session?appid={0}&secret={1}&js_code={2}&grant_type=authorization_code'.format(
            app.config['MINA_APP']['appid'], app.config['MINA_APP']['appkey'], code)
        res = requests.get(url).json()
        openid = None
        if 'openid' in res:
            openid = res['openid']
        return openid
