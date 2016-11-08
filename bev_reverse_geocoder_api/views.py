# -*- coding: utf-8 -*-

from django.shortcuts import render
import psycopg2
import psycopg2.extras
import json
from django.http import HttpResponse
from django.http import HttpResponseServerError
from django.http import HttpResponseBadRequest
from .dicttoxml import DictToXML


def index(request):
    return render(request, 'index.html')


def is_float(value):
    try:
        float(value)
        return True
    except ValueError:
        return False


def reverse_geocode(request, format):
    default_distance = 30
    max_distance = 100
    default_limit = 5
    max_limit = 10

    # Get the HTTP GET parameters and use default values where it makes sense.
    lat = request.GET.get("lat")
    lon = request.GET.get("lon")
    epsg = request.GET.get("epsg", "4326")
    distance = request.GET.get("distance", default_distance)
    limit = request.GET.get('limit', default_limit)

    # Try to connect
    try:
        conn = psycopg2.connect(
            database="gis"
        )
    except Exception as e:
        result = {
            "status": "server_error",
            "message": "The web application was unable to connect to the database. Please inform the site " +
                       "administrator about this issue."
        }
        return HttpResponseServerError(json.dumps(result), content_type="application/json")

    cursor = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

    # Do basic data validation.
    if not format in ["json", "xml"]:
        result = {
            "status": "bad_request",
            "message": "The format must either by JSON or XML."
        }
        return HttpResponseBadRequest(get_response_content(result, format), content_type=get_content_type(format))

    if not epsg.isdigit():
        result = {
            "status": "bad_request",
            "message": "The EPSG parameter must be an integer vaule."
        }
        return HttpResponseBadRequest(get_response_content(result, format), content_type=get_content_type(format))

    epsg_statement = "SELECT srid from spatial_ref_sys WHERE srid=%s"
    cursor.execute(epsg_statement, (epsg,))
    epsg_result = cursor.fetchall()

    if len(epsg_result) < 1:
        result = {
            "status": "bad_request",
            "message": "EPSG %s is not supported or does not exist. Try 4326!" % epsg
        }
        return HttpResponseBadRequest(get_response_content(result, format), content_type=get_content_type(format))

    if not distance.isdigit() or (int(distance) > max_distance) or (int(distance) < 0):
        result = {
            "status": "bad_request",
            "message": "The distance value must be an integer between 0 and %s." % max_distance
        }
        return HttpResponseBadRequest(get_response_content(result, format), content_type=get_content_type(format))

    if not limit.isdigit() or (int(limit) > max_limit) or (int(limit) < 1):
        result = {
            "status": "bad_request",
            "message": "The limit parameter must be an integer between 1 and %s." % max_limit
        }
        return HttpResponseBadRequest(get_response_content(result, format), content_type=get_content_type(format))

    statement = """
        select b.municipality, b.postcode, b.street, b.house_number, b.house_name, b.address_type,
          ST_Distance(ST_SetSRID(ST_MakePoint(%s, %s),%s), b.point) as distance,
          ST_X(ST_Transform(point::geometry, %s)) as lon, ST_Y(ST_Transform(point::geometry, %s)) as lat
        from bev_addresses b
        where ST_DWithin(ST_SetSRID(ST_MakePoint(%s, %s),%s), b.point, %s)
        order by distance
        limit %s
    """

    try:
        cursor.execute(statement, (lat, lon, epsg, epsg, epsg, lat, lon, epsg, distance, limit,))
        sql_result = cursor.fetchall()

        # Convert the result from psycopg2.extras.RealDictRow back to a usual dict.
        dict_result = []
        for row in sql_result:
            dict_result.append(dict(row))
    except Exception as e:
        result = {
            "status": "server_error",
            "message": "There was a problem querying the database. Please verify that the parameters you submitted (" +
                       "especially the coordinates according to the EPSG you specified) make sense."
        }
        return HttpResponseServerError(get_response_content(result, format), content_type=get_content_type(format))

    result = {"status": "ok", "copyright": u"© Österreichisches Adressregister, Stichtagsdaten vom 02.10.2016", "results": dict_result}

    return HttpResponse(get_response_content(result, format), content_type=get_content_type(format))


def get_response_content(dictionary, format):
    if format == 'json':
        return json.dumps(dictionary)
    elif format == 'xml':
        xml = DictToXML({"reverse_geocode_results": dictionary},  list_mappings={"results": "address"})
        return xml.get_string()

    return ""


def get_content_type(format):
    if format == 'json':
        return "application/json"
    elif format == 'xml':
        return "application/xml"

    return "text/plain"
