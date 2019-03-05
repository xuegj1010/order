import json
import re

from flask import Blueprint, request, jsonify

from application import app
from common.libs.UploadService import UploadService

route_upload = Blueprint("upload_page", __name__)


@route_upload.route("/ueditor", methods=['GET', 'POST'])
def ueditor():
    req = request.values
    action = req['action'] if 'action' in req else ''

    if action == 'config':
        root_path = app.root_path
        config_path = r"{0}/web/static/plugins/ueditor/upload_config.json".format(root_path)
        # a = r'C:\Users\xuegj1010\PycharmProjects\order\web\static\plugins\ueditor\upload_config.json'
        with open(config_path, 'r', encoding='UTF-8') as fp:
            try:
                config_data = json.loads(re.sub('/\*.*\*/', '', fp.read()))
            except:
                config_data = {}
        return jsonify(config_data)

    if action == "uploadimage":
        return upload_image()


def upload_image():
    resp = {'state': 'SUCCESS', 'url': '', 'title': '', 'original': ''}
    file_target = request.files
    up_file = file_target['upfile'] if 'upfile' in file_target else None
    if up_file is None:
        resp['state'] = '上传失败'
        return jsonify(resp)

    ret = UploadService.upload_by_file(up_file)
    if ret['code'] != 200:
        resp['state'] = '上传是失败：' + ret['msg']
        return jsonify(resp)

    resp['url'] = ret['data']['file_key']

    return jsonify(resp)
