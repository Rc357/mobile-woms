// @dart=2.10
import 'package:app/model/model_customer_booking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' as convert;
import 'package:app/constants/constants.dart';

class GetCustomerBooking {
  double dateNow = DateTime.now().toUtc().millisecondsSinceEpoch * 0.001;
  Future<List<CustomerBookingModel>> getCustomerFutureAppointment() async {
    int _date = dateNow.round();
    var url = Constants.API_HOST + "appointment/customer/get_booking.php";
    print("GetCustomerBooking");
    try {
      var map = Map<String, dynamic>();
      map['customerID'] = Constants.CUS_ID.toString();
      map['dateNow'] = _date.toString();
      map['type'] = "getFuture";
      print(map);
      final response = await http.post(url, body: map);
      // print(response.body);
      if (response.statusCode == 200) {
        final List<CustomerBookingModel> list = parseResponse(response.body);
        print(list[0].id);
        return list;
      } else {
        return <CustomerBookingModel>[];
      }
    } catch (e) {
      print("Error Future");
      print(e);
      return <CustomerBookingModel>[];
    }
  }

  List<CustomerBookingModel> parseResponse(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed
        .map<CustomerBookingModel>(
            (json) => CustomerBookingModel.fromJson(json))
        .toList();
  }

  Future<List<CustomerBookingModel>> getCustomerLastAppointment() async {
    int _date = dateNow.round();
    var url = Constants.API_HOST + "appointment/customer/get_booking.php";
    try {
      var map = Map<String, dynamic>();
      map['customerID'] = Constants.CUS_ID.toString();
      map['dateNow'] = _date.toString();
      map['type'] = "getLast";
      final response = await http.post(url, body: map);
      // print(response.body);
      if (response.statusCode == 200) {
        final List<CustomerBookingModel> list = parseResponse(response.body);
        return list;
      } else {
        return <CustomerBookingModel>[];
      }
    } catch (e) {
      print("Error Last");
      print(e);
      return <CustomerBookingModel>[];
    }
  }

  Future<List<CustomerBookingModel>> getCustomerAppointments(
      String branchId) async {
    int _date = dateNow.round();
    var url = Constants.API_WEB_HOST +
        "admin/customer-calendar/get-customer-appointments/ " +
        Constants.CUS_ID.toString() +
        "/${branchId}";

    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        Map<String, dynamic> map = json.decode(res.body);
        List<dynamic> datas = map[res.body];
        // print("SASASADASASAS[0]");
        // print(datas.length);
        // print(datas[0]["code"]);
        // print(datas[1]["code"]);
        return datas;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
