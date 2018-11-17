import hashlib
import base64
import random
import string


class UserService:

    @staticmethod
    def gene_auth_code(user_info):
        """生成授权码"""
        m = hashlib.md5()
        raw_str = "%s-%s-%s-%s" % (user_info.uid, user_info.login_name, user_info.login_pwd, user_info.login_salt)
        m.update(raw_str.encode("utf-8"))
        return m.hexdigest()

    @staticmethod
    def gene_pwd(pwd, salt):
        m = hashlib.md5()
        raw_str = "%s-%s" % (base64.encodebytes(pwd.encode('utf-8')), salt)
        m.update(raw_str.encode("utf-8"))
        return m.hexdigest()

    @staticmethod
    def gene_salt(length=16):
        keys = [random.choice((string.ascii_letters + string.digits)) for _ in range(length)]
        return ("".join(keys))
