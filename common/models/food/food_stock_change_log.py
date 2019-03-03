# coding: utf-8
from sqlalchemy import Column, DateTime, Integer, String
from sqlalchemy.schema import FetchedValue
from flask_sqlalchemy import SQLAlchemy


from application import db, app


class FoodStockChangeLog(db.Model):
    __tablename__ = 'food_stock_change_log'

    id = db.Column(db.Integer, primary_key=True)
    food_id = db.Column(db.Integer, nullable=False, index=True)
    unit = db.Column(db.Integer, nullable=False, server_default=db.FetchedValue())
    total_stock = db.Column(db.Integer, nullable=False, server_default=db.FetchedValue())
    note = db.Column(db.String(100), nullable=False, server_default=db.FetchedValue())
    created_time = db.Column(db.DateTime, nullable=False, server_default=db.FetchedValue())
