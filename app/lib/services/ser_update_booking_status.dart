import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/constants/constants.dart';

class UpdateBookingStatusService {
  //SAVE TIMER DATA
  static Future<bool> updateBookingStatusService(
      String id, String status, String dateNow, String orderId) async {
    var url = Constants.API_HOST + "appointment/update_bookings_status.php";
    bool ret = false;

    try {
      var map = Map<String, dynamic>();
      map['id'] = id;
      map['orderId'] = orderId;
      map['status'] = status;
      map['startTime'] = dateNow;
      map['endTime'] = DateTime.now().toString();

      print("CODE updateBookingStatusService");
      print(map);
      final response = await http.post(url, body: map);
      print(response.body);
      if (response.statusCode == 200) {
        var data = response.body;
        if (data == "SUCCESS") {
          ret = true;
          print("object SASASAS");
        }
        return ret;
      } else {
        return ret;
      }
    } catch (e) {
      return ret;
    }
  }
}
