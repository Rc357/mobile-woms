// @dart=2.10
import 'dart:convert';
import 'package:app/model/model_date_event_pos.dart';
import 'package:app/model/model_order.dart';
import 'package:app/model/model_order_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:app/constants/constants.dart';

class ServicesGetAppointmentPos {
  Future<List<DateAndEventsPos>> getAppointmentPos() async {
    var map = Map<String, dynamic>();
    print("Constants.USER_ID.toString()");
    print(Constants.USER_ID.toString());
    map['userID'] = Constants.USER_ID.toString();
    String url = Constants.API_HOST + "appointment/get_app_pos.php";
    try {
      final response = await http.post(url, body: map);
      print("GET ALL SSS");
      if (response.statusCode == 200) {
        final List<DateAndEventsPos> list = parseResponse(response.body);
        print(list.length);
        for (int i = 0; i < list.length; i++) {
          print(list[i].from);
        }
        return list;
      } else {
        return <DateAndEventsPos>[];
      }
    } catch (e) {
      print("ERROR");
      return <DateAndEventsPos>[];
    }
  }

  List<DateAndEventsPos> parseResponse(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed
        .map<DateAndEventsPos>((json) => DateAndEventsPos.fromJson(json))
        .toList();
  }

  Future<List<ItemsOrder>> getOrderItems(String id) async {
    var map = Map<String, dynamic>();
    map['itemID'] = id;
    String url = Constants.API_HOST + "appointment/get_order_items.php";
    try {
      final response = await http.post(url, body: map);
      print("GET ALL DDD");
      if (response.statusCode == 200) {
        final List<ItemsOrder> list = getOrderItemsResponse(response.body);
        print(list.length);
        for (int i = 0; i < list.length; i++) {
          print(list[i].id);
        }
        return list;
      } else {
        return <ItemsOrder>[];
      }
    } catch (e) {
      print("ERROR");
      return <ItemsOrder>[];
    }
  }

  List<ItemsOrder> getOrderItemsResponse(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed.map<ItemsOrder>((json) => ItemsOrder.fromJson(json)).toList();
  }

  Future<OderName> orderName(String id) async {
    var url = Constants.API_HOST + "appointment/get_order.php";
    OderName profile;
    print("CODE CC");
    print(id);
    print("CODE HERE");
    try {
      var map = Map<String, dynamic>();
      map['itemID'] = id;
      final response = await http.post(url, body: map);
      print(response.body);
      if (response.statusCode == 200) {
        print("CODE XXXX");
        Map data = convert.jsonDecode(response.body);
        OderName template = OderName.fromJson(data);
        print(template.id);
        print(template);
        return template;
      } else {
        return profile;
      }
    } catch (e) {
      return profile;
    }
  }
}
