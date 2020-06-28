# coding: utf-8
from sqlalchemy import Column, DateTime, Integer, Text
from sqlalchemy.schema import FetchedValue
from application import db


class PayOrderCallbackData(db.Model):
    __tablename__ = 'pay_order_callback_data'

    id = db.Column(db.Integer, primary_key=True)
    pay_order_id = db.Column(db.Integer, nullable=False, unique=True, server_default=db.FetchedValue())
    pay_data = db.Column(db.Text, nullable=False)
    refund_data = db.Column(db.Text, nullable=False)
    updated_time = db.Column(db.DateTime, nullable=False, server_default=db.FetchedValue())
    created_time = db.Column(db.DateTime, nullable=False, server_default=db.FetchedValue())
