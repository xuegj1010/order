import hashlib
import uuid
from xml.etree import ElementTree as ET

import requests

from application import app


class WeChatService:
    def __init__(self, merchant_key=None):
        self.merchant_key = merchant_key
        pass

    def create_sign(self, pay_data):
        '''
        生产签名
        :param pay_data:
        :return:
        '''
        stringA = "&".join(["{0}-{1}".format(k, pay_data.get(k)) for k in sorted(pay_data)])
        stringSignTemp = "{0}&key={1}".format(stringA, self.merchant_key)
        sign = hashlib.md5(stringSignTemp.encode("utf-8")).hexdigest()
        return sign.upper()

    def get_pay_info(self, pay_data=None):
        '''
        获取支付信息
        :param xml_data:
        :return:
        '''

        sign = self.create_sign(pay_data)
        pay_data['sign'] = sign
        xml_data = self.dict_to_xml(pay_data)
        headers = {'Content-Type': 'application/xml'}
        url = "https://api.mch.weixin.qq.com/pay/unifiedorder"
        r = requests.post(url=url, data=xml_data.encode('utf-8'), headers=headers)
        r.encoding = "utf-8"
        app.logger.info(r.text)
        if r.status_code == 200:
            prepay_id = self.xml_to_dict(r.text).get('prepay_id')
            pay_sign_data = {
                'appId': pay_data.get('appid'),
                'timeStamp': pay_data.get('out_trade_no'),
                'nonceStr': pay_data.get('nonce_str'),
                'package': 'prepay_id={0}'.format(prepay_id),
                'signType': 'MD5'
            }
            pay_sign = self.create_sign(pay_sign_data)
            pay_sign_data.pop('appId')
            pay_sign_data['paySign'] = pay_sign
            pay_sign_data['prepay_id'] = prepay_id
            return pay_sign_data

        return False

    def dict_to_xml(self, dict_data):
        xml = ["<xml>"]
        for k, v in dict_data.items():
            xml.append("<{0}{1}</{0}>".format(k, v))
        xml.append("</xml>")
        return "".join(xml)

    def xml_to_dict(self, xml_data):
        xml_dict = {}
        root = ET.fromstring(xml_data)
        for child in root:
            xml_dict[child.tag] = child.text

        return xml_dict

    def get_nonce_str(self):
        return str(uuid.uuid4()).replace("-", "")
