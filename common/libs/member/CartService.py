from application import db
from common.libs.Helper import getCurrentDate
from common.models.member.MemberCart import MemberCart


class CartService:

    @staticmethod
    def delete_item(member_id=0, items=None):
        if member_id < 1 or not items:
            return False
        for item in items:
            MemberCart.query.filter_by(food_id=item['id'], member_id=member_id).delete()
        db.session.commit()
        return True

    @staticmethod
    def set_items(member_id=0, food_id=0, number=0):
        if member_id < 1 or food_id < 1 or number < 1:
            return False
        cart_info = MemberCart.query.filter_by(food_id=food_id, member_id=member_id).first()

        if cart_info:
            model_cart = cart_info
        else:
            model_cart = MemberCart()
            model_cart.member_id = member_id
            model_cart.created_time = getCurrentDate()

        model_cart.food_id = food_id
        model_cart.quantity = number
        model_cart.updated_time = getCurrentDate()
        db.session.add(model_cart)
        db.session.commit()
        return True
