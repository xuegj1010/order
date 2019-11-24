import json

from flask import jsonify, request, g

from common.libs.Helper import select_filter_obj, get_dict_filter_field
from common.libs.UrlManager import UrlManager
from common.libs.member.CartService import CartService
from common.models.food.food import Food
from common.models.member.MemberCart import MemberCart
from web.controllers.api import route_api


@route_api.route('/cart/index')
def cart_index():
    resp = {'code': 200, 'msg': '操作成功', 'data': {}}
    member_info = g.member_info
    if not member_info:
        resp['code'] = -1
        resp['msg'] = "獲取失敗，未登陸"
        return jsonify(resp)
    cart_list = MemberCart.query.filter_by(member_id=member_info.id).all()
    data_cart_list = []
    if cart_list:
        food_ids = select_filter_obj(cart_list, "food_id")
        food_map = get_dict_filter_field(Food, Food.id, "id", food_ids)
        for item in cart_list:
            tmp_food_info = food_map[item.food_id]
            tmp_data = {
                'id': item.id,
                'food_id': item.food_id,
                'number': item.quantity,
                'name': tmp_food_info.name,
                'price': str(tmp_food_info.price),
                'pic_url': UrlManager.build_image_url(tmp_food_info.main_image),
                'active': True
            }
            data_cart_list.append(tmp_data)

    resp['data']['list'] = data_cart_list
    return jsonify(resp)


@route_api.route("/cart/set", methods=["POST"])
def set_cart():
    resp = {'code': 200, 'msg': '操作成功', 'data': {}}
    req = request.values
    food_id = int(req['id']) if 'id' in req else 0
    number = int(req['number']) if 'number' in req else 0
    if food_id < 1 or number < 1:
        resp['code'] = -1
        resp['msg'] = "添加購物車失敗-1"
        return jsonify(resp)
    member_info = g.member_info
    if not member_info:
        resp['code'] = -1
        resp['msg'] = "添加購物車失敗-2"
        return jsonify(resp)
    food_info = Food.query.filter_by(id=food_id).first()
    if not food_info:
        resp['code'] = -1
        resp['msg'] = "添加購物車失敗-3"
        return jsonify(resp)
    if food_info.stock < number:
        resp['code'] = -1
        resp['msg'] = "添加購物車失敗,庫存不足"
        return jsonify(resp)

    ret = CartService.set_items(member_id=member_info.id, food_id=food_id, number=number)
    if not ret:
        resp['code'] = -1
        resp['msg'] = "添加購物車失敗-4"
        return jsonify(resp)
    return jsonify(resp)


@route_api.route("/cart/del", methods=["POST"])
def del_cart():
    resp = {'code': 200, 'msg': '操作成功', 'data': {}}
    req = request.values
    params_goods = req['goods'] if 'goods' in req else None

    items = []
    if params_goods:
        items = json.loads(params_goods)
    if not items or len(items) < 1:
        return jsonify(resp)
    member_info = g.member_info
    if not member_info:
        resp['code'] = -1
        resp['msg'] = "删除购物车失败-1~~"
        return jsonify(resp)
    ret = CartService.delete_item(member_id=member_info.id, items=items)
    if not ret:
        resp['code'] = -1
        resp['msg'] = "删除购物车失败-2~~"
        return jsonify(resp)
    return jsonify(resp)
