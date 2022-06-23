// @dart=2.10
import 'dart:convert';
import 'package:app/model/model_customer_slot.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:app/constants/constants.dart';
import 'package:intl/intl.dart';

class PostAddNewAppointment {
  Future<void> getSlotTime(String date, String estId, String duration,
      String brId, String serCode) async {
    var url = Constants.API_WEB_HOST +
        "api/pos/getBookingSlots/" +
        date +
        "/" +
        estId +
        "/" +
        duration +
        "/" +
        brId +
        "/" +
        serCode;
    print("GetSlotTime");
    print(url);

    try {
      var map = Map<String, dynamic>();
      map['booking_date'] = date;
      map['booking_employee'] = '4';
      map['booking_room'] = "5";
      map['booking_slot'] = "eventEstheticians";
      map['cashier_id'] = "bookingID";
      map['customer_id'] = "eventStartTime";
      map['esthetician_is_requested'] = true;
      map['is_client_reservation'] = true;
      map['outlet_id'] = 1;
      map['total_duration'] = 50;
      map['waitlist_id'] = 0;
      map['booking_service'] = json;

      print("CODE DDDD");
      print(map);
      final response = await http.post(url, body: map);
      print(response.body);
      if (response.statusCode == 200) {
        var data = response.body;
        if (data == "SUCCESS") {
          print("object SASASAS");
        }
      } else {}
    } catch (e) {}
  }
}
