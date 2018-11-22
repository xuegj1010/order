# coding: utf-8
from sqlalchemy import Column, DateTime, Integer, String, Text
from sqlalchemy.schema import FetchedValue

from application import db


class AppErrorLog(db.Model):
    __tablename__ = 'app_error_log'

    id = db.Column(db.Integer, primary_key=True)
    referer_url = db.Column(db.String(255), nullable=False, server_default=db.FetchedValue())
    target_url = db.Column(db.String(255), nullable=False, server_default=db.FetchedValue())
    query_params = db.Column(db.Text, nullable=False)
    content = db.Column(db.String, nullable=False)
    created_time = db.Column(db.DateTime, nullable=False, server_default=db.FetchedValue())
