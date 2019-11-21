import os

from flask import Flask
from flask_script import Manager
from flask_sqlalchemy import SQLAlchemy


class Application(Flask):
    def __init__(self, import_name, template_folder=None, root_path=None):
        super(Application, self).__init__(
            import_name,
            template_folder=template_folder,
            root_path=root_path,
            static_folder=None
        )
        self.config.from_pyfile('config/base_setting.py')
        os.environ['ops_config'] = 'local'
        if 'ops_config' in os.environ:
            print('config/%s_setting.py' % os.environ['ops_config'])
            self.config.from_pyfile('config/%s_setting.py' % os.environ['ops_config'])

        db.init_app(self)


db = SQLAlchemy()
app = Application(__name__, template_folder=os.getcwd() + '/web/templates', root_path=os.getcwd())
manager = Manager(app)

"""
函数模板
"""
from common.libs.UrlManager import UrlManager
app.add_template_global(UrlManager.build_url, 'build_url')
app.add_template_global(UrlManager.static_url, 'static_url')
app.add_template_global(UrlManager.build_image_url, 'build_image_url')
