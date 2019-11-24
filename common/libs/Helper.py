import datetime

from flask import g, render_template


# 自定义分页类
def i_pagination(params):
    import math

    ret = {
        "is_prev": 1,
        "is_next": 1,
        "from": 0,
        "end": 0,
        "current": 0,
        "total_pages": 0,
        "page_size": 0,
        "total": 0,
        "url": params['url']
    }

    total = int(params['total'])
    page_size = int(params['page_size'])
    page = int(params['page'])
    display = int(params['display'])
    total_pages = int(math.ceil(total / page_size))
    total_pages = total_pages if total_pages > 0 else 1
    if page <= 1:
        ret['is_prev'] = 0

    if page >= total_pages:
        ret['is_next'] = 0

    semi = int(math.ceil(display / 2))

    if page - semi > 0:
        ret['from'] = page - semi
    else:
        ret['from'] = 1

    if page + semi <= total_pages:
        ret['end'] = page + semi
    else:
        ret['end'] = total_pages

    ret['current'] = page
    ret['total_pages'] = total_pages
    ret['page_size'] = page_size
    ret['total'] = total
    ret['range'] = range(ret['from'], ret['end'] + 1)
    return ret


#  统一渲染
def ops_render(template, context={}):
    if 'current_user' in g:
        context['current_user'] = g.current_user
    return render_template(template, **context)


# 获取当前时间
def getCurrentDate(fmt="%Y-%m-%d %H:%M:%S"):
    return datetime.datetime.now().strftime((fmt))


#  根据某个字段获取一个dict出来

def get_dict_filter_field(db_model, select_field, key_field, id_list):
    ret = {}
    query = db_model.query
    if id_list and len(id_list) > 0:
        query = query.filter(select_field.in_(id_list))

    list = query.all()

    if not list:
        return ret
    for item in list:
        if not hasattr(item, key_field):
            break
        ret[getattr(item, key_field)] = item
    return ret


def select_filter_obj(obj, field):
    ret = []
    for item in obj:
        if not hasattr(item, field):
            continue
        if getattr(item, field) in ret:
            continue
        ret.append(getattr(item, field))
    return ret
