# -*- coding: utf-8 -*-
from flask import Blueprint

from common.libs.Helper import ops_render

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
    return ops_render("food/cat.html")


@route_food.route("/cat-set")
def cat_set():
    return ops_render("food/cat_set.html")
