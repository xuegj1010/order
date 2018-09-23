class UrlManager:
    def __init__(self):
        pass

    @staticmethod
    def build_url(path):
        return path

    @classmethod
    def static_url(cls, path):
        ver = "%s" % 201808111400
        path = '/static' + path + "?ver=" + ver
        return cls.build_url(path)

