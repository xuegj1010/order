# -*- coding: utf-8 -*-
from flask import Blueprint, request, redirect

from app import app
from common.libs.Helper import ops_render, i_pagination
from common.libs.UrlManager import UrlManager
from common.models.user import User

route_account = Blueprint('account_page', __name__)


@route_account.route("/index")
def index():
    resp_data = {}
    req = request.values
    page = int(req['page'] if ('page' in req and req['page']) else 1)
    query = User.query
    page_params = {
        'total': query.count(),
        'page_size': app.config['PAGE_SIZE'],
        'page': page,
        'display': app.config['PAGE_DISPLAY'],
        'url': '/account/index'
    }
    pages = i_pagination(page_params)
    offset = (page - 1) * app.config['PAGE_SIZE']
    limit = app.config['PAGE_SIZE'] * page

    list_ = query.order_by(User.uid.desc()).all()[offset:limit]

    resp_data['list'] = list_
    resp_data['pages'] = pages
    return ops_render("account/index.html", resp_data)


@route_account.route("/info")
def info():
    resp_data = {}
    req = request.args
    uid = int(req.get('id', 0))
    reback_url = UrlManager.build_url('/account/index')
    if uid < 1:
        return redirect(reback_url)
    info = User.query.filter_by(uid=uid).first()
    if not info:
        return redirect(reback_url)

    resp_data['info'] = info
    return ops_render("account/info.html",resp_data)


@route_account.route("/set")
def set_():
    return ops_render("account/set.html")
