# -*- coding: utf-8 -*-
from flask import Blueprint

from common.libs.Helper import ops_render

route_stat = Blueprint('stat_page', __name__)


@route_stat.route("/index")
def index():
    return ops_render("stat/index.html")


@route_stat.route("/food")
def food():
    return ops_render("stat/food.html")


@route_stat.route("/member")
def member():
    return ops_render("stat/member.html")


@route_stat.route("/share")
def share():
    return ops_render("stat/share.html")
