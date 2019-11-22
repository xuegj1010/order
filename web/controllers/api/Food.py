from flask import jsonify

from common.libs.UrlManager import UrlManager
from common.models.food.food import Food
from common.models.food.food_cat import FoodCat
from web.controllers.api import route_api


@route_api.route("/food/index")
def food_index():
    resp = {'code': 200, 'msg': "操作成功", 'data': {}}
    cat_list = FoodCat.query.filter_by(status=1).order_by(FoodCat.weight.desc()).all()
    data_cat_list = [{
        'id': 0,
        'name': "全部"
    }]
    if cat_list:
        for item in cat_list:
            tmp_data = {
                "id": item.id,
                "name": item.name
            }
            data_cat_list.append(tmp_data)
    resp['data']['cat_list'] = data_cat_list

    food_list = Food.query.filter_by(status=1) \
        .order_by(Food.total_count.desc(), Food.id.desc()).limit(3).all()
    data_food_list = []
    if food_list:
        for item in food_list:
            tmp_data = {
                "id": item.id,
                "pic_url": UrlManager.build_image_url(item.main_image)
            }
            data_food_list.append(tmp_data)
    resp['data']['banner_list'] = data_food_list
    return jsonify(resp)


@route_api.route("/food/search")
def food_search():
    return
