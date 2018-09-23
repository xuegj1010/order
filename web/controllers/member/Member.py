# -*- coding: utf-8 -*-
from flask import Blueprint

from common.libs.Helper import ops_render

route_member = Blueprint('member_page', __name__)


@route_member.route("/index")
def index():
    return ops_render("member/index.html")


@route_member.route("/info")
def info():
    return ops_render("member/info.html")


@route_member.route("/set")
def set():
    return ops_render("member/set.html")


@route_member.route("/comment")
def comment():
    return ops_render("member/comment.html")
