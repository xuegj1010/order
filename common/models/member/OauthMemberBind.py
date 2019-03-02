# coding: utf-8
from sqlalchemy import Column, DateTime, Index, Integer, String, Text
from sqlalchemy.schema import FetchedValue

from application import db


class OauthMemberBind(db.Model):
    __tablename__ = 'oauth_member_bind'
    __table_args__ = (
        db.Index('idx_type_openid', 'type', 'openid'),
    )

    id = db.Column(db.Integer, primary_key=True)
    member_id = db.Column(db.Integer, nullable=False, server_default=db.FetchedValue())
    client_type = db.Column(db.String(20), nullable=False, server_default=db.FetchedValue())
    type = db.Column(db.Integer, nullable=False, server_default=db.FetchedValue())
    openid = db.Column(db.String(80), nullable=False, server_default=db.FetchedValue())
    unionid = db.Column(db.String(100), nullable=False, server_default=db.FetchedValue())
    extra = db.Column(db.Text, nullable=False)
    updated_time = db.Column(db.DateTime, nullable=False, server_default=db.FetchedValue())
    created_time = db.Column(db.DateTime, nullable=False, server_default=db.FetchedValue())
