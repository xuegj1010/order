# coding: utf-8
from sqlalchemy import BigInteger, Column, DateTime, Integer, String, Text
from sqlalchemy.schema import FetchedValue

from application import db


class AppAccessLog(db.Model):
    __tablename__ = 'app_access_log'

    id = db.Column(db.Integer, primary_key=True)
    uid = db.Column(db.BigInteger, nullable=False, index=True, server_default=db.FetchedValue())
    referer_url = db.Column(db.String(255), nullable=False, server_default=db.FetchedValue())
    target_url = db.Column(db.String(255), nullable=False, server_default=db.FetchedValue())
    query_params = db.Column(db.Text, nullable=False)
    ua = db.Column(db.String(255), nullable=False, server_default=db.FetchedValue())
    ip = db.Column(db.String(32), nullable=False, server_default=db.FetchedValue())
    note = db.Column(db.String(1000), nullable=False, server_default=db.FetchedValue())
    created_time = db.Column(db.DateTime, nullable=False, server_default=db.FetchedValue())
