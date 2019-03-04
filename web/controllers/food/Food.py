# -*- coding: utf-8 -*-
from flask import Blueprint, request, jsonify

from application import db, app
from common.libs.Helper import ops_render, getCurrentDate
from common.models.food.food_cat import FoodCat

route_food = Blueprint('food_page', __name__)


@route_food.route("/index")
def index():
    return ops_render("food/index.html")


@route_food.route("/info")
def info():
    return ops_render("food/info.html")


@route_food.route("/set")
def set():
    return ops_render("food/set.html")


@route_food.route("/cat")
def cat():
    resp_data = {}
    req = request.values
    query = FoodCat.query

    if 'status' in req and int(req['status']) > -1:
        query = query.filter(FoodCat.status == int(req['status']))

    list = query.order_by(FoodCat.weight.desc(), FoodCat.id.desc()).all()
    resp_data['list'] = list
    resp_data['search_con'] = req
    resp_data['status_mapping'] = app.config['STATUS_MAPPING']
    resp_data['current'] = 'cat'

    return ops_render("food/cat.html", resp_data)


@route_food.route("/cat-set", methods=["GET", "POST"])
def cat_set():
    if request.method == "GET":
        resp_data = {}
        req = request.args
        id = int(req.get("id", 0))
        info = None
        if id:
            info = FoodCat.query.filter_by(id=id).first()
        resp_data['info'] = info
        resp_data['current'] = 'cat'
        return ops_render("food/cat_set.html", resp_data)

    resp = {'code': 200, 'msg': '操作成功', 'data': {}}
    req = request.values

    id = req['id'] if 'id' in req else 0
    name = req['name'] if 'name' in req else ''
    weight = int(req['weight']) if ('weight' in req and int(req['weight']) > 0) else 1

    if name is None or len(name) < 1:
        resp['code'] = -1
        resp['msg'] = '请输入符合规范的分类名称'
        return jsonify(resp)

    food_cat_info = FoodCat.query.filter_by(id=id).first()
    if food_cat_info:
        model_food_cat = food_cat_info
    else:
        model_food_cat = FoodCat()
        model_food_cat.created_time = getCurrentDate()
    model_food_cat.name = name
    model_food_cat.weight = weight
    model_food_cat.updated_time = getCurrentDate()
    db.session.add(model_food_cat)
    db.session.commit()
    return jsonify(resp)

@route_food.route("/cat-ops", methods=["POST"])
def cat_ops():
    resp = {'code': 200, 'msg': '操作成功!', 'data': {}}
    req = request.values

    id = req['id'] if 'id' in req else 0
    act = req['act'] if 'act' in req else ''

    if not id:
        resp['code'] = -1
        resp['msg'] = "请选择要操作的分类！"
        return jsonify(resp)

    if act not in ['remove', 'recover']:
        resp['code'] = -1
        resp['msg'] = "操作有误，请重试！"
        return jsonify(resp)

    food_cat_info = FoodCat.query.filter_by(id=id).first()
    if not food_cat_info:
        resp['code'] = -1
        resp['msg'] = "指定分类不存在！"
        return jsonify(resp)

    if act == 'remove':
        food_cat_info.status = 0
    elif act == 'recover':
        food_cat_info.status = 1

    food_cat_info.update_time = getCurrentDate()
    db.session.add(food_cat_info)
    db.session.commit()

    return jsonify(resp)
