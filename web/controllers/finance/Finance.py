# -*- coding: utf-8 -*-
from flask import Blueprint

from common.libs.Helper import ops_render

route_finance = Blueprint('finance_page', __name__)


@route_finance.route("/index")
def index():
    return ops_render("finance/index.html")


@route_finance.route("/pay-info")
def pay_info():
    return ops_render("finance/pay_info.html")


@route_finance.route("/account")
def account():
    return ops_render("finance/account.html")
