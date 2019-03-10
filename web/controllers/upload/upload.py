import json
import re

from flask import Blueprint, request, jsonify

from application import app
from common.libs.UploadService import UploadService
from common.libs.UrlManager import UrlManager
from common.models.Image import Image

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

    if action == 'listimage':
        return list_image()

    return 'upload'


@route_upload.route('/pic', methods=['GET', 'POST'])
def upload_pic():
    file_target = request.files
    up_file = file_target['pic'] if 'pic' in file_target else None
    callback_target = 'window.parent.upload'
    if up_file is None:
        return "<script type='text/javascript'>{0}.error('{1}')</script>".format(callback_target, "上传失败")

    ret = UploadService.upload_by_file(up_file)
    if ret['code'] != 200:
        return "<script type='text/javascript'>{0}.error('{1}')</script>".format(callback_target, "上传失败：" + ret['msg'])

    return "<script type='text/javascript'>{0}.success('{1}')</script>".format(callback_target, ret['data']['file_key'])


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

    resp['url'] = UrlManager.build_image_url(ret['data']['file_key'])

    return jsonify(resp)


def list_image():
    resp = {'state': 'SUCCESS', 'list': [], 'start': 0, 'total': 0}
    req = request.values

    start = int(req['start']) if 'start' in req else 0
    page_size = int(req['size']) if 'size' in req else 20

    query = Image.query

    if start > 0:
        query = query.filter(Image.id < start)

    list = query.order_by(Image.id.desc()).limit(page_size).all()
    images = []
    if list:
        for item in list:
            images.append({'url': UrlManager.build_image_url(item.file_key)})
            start = item.id

    resp['list'] = images
    resp['start'] = start
    resp['total'] = len(images)
    return jsonify(resp)
