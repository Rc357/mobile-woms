// @dart=2.10
import 'dart:convert';
import 'package:app/model/model_customer_all_bookings.dart';
import 'package:app/model/model_customer_appointment.dart';
import 'package:http/http.dart' as http;
import 'package:app/constants/constants.dart';

class ServicesGetCustomerAppointment {
  Future<List<CustomerAppointment>> servicesGetCustomerAppointment(
      String branchID) async {
    print("ServicesGetCustomerAppointment");
    String url =
        Constants.API_HOST + "appointment/customer/get_all_bookings.php";
    try {
      // final response = await http.get(url);
      print(url);
      var map = Map<String, dynamic>();
      map['customerID'] = Constants.CUS_ID.toString();
      map['outletID'] = branchID;
      final response = await http.post(url, body: map);
      print(map);
      print("GET DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
      print(response.body);
      // print(response.body);
      if (response.statusCode == 200) {
        final List<CustomerAppointment> list = parseResponse(response.body);
        print("list.length xxxxx");
        print(list.length);
        for (int i = 0; i < list.length; i++) {
          print(list[i].order_item_id);
        }
        return list;
      } else {
        return <CustomerAppointment>[];
      }
    } catch (e) {
      print("ERROR DDDDDDDDDDDDDDDDDDD: ");
      print(e);
      return <CustomerAppointment>[];
    }
  }

  List<CustomerAppointment> parseResponse(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed
        .map<CustomerAppointment>((json) => CustomerAppointment.fromJson(json))
        .toList();
  }
}

class GetCustomerAppointment {
  Future<Map<String, dynamic>> getCustomerAppointment(String branchID) async {
    print("GetCustomerAppointment");
    var url = Constants.API_WEB_HOST +
        "admin/customer-calendar/get-customer-appointments/" +
        Constants.CUS_ID.toString() +
        "/" +
        branchID;
    print(url);
    print("API_WEB_HOST DSDSDSDSDSDSSDDSDSDSDSDSDSDSDSD");

    try {
      var res = await http.get(url);

      if (res.statusCode == 200) {
        Map<String, dynamic> map = json.decode(res.body);
        List<dynamic> datas = map["data"];

        final appointmentsData = customerAllBookingsModelFromJson(res.body);
        print("appointmentsData.length");
        print(appointmentsData.keys.length);

        return appointmentsData;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
