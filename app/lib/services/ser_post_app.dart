import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/constants/constants.dart';

class AppointmentService {
  static Future<bool> appointmentService(
    String eventTitle,
    String eventDescription,
    String eventClientName,
    String eventEstheticians,
    String bookingID,
    String eventStartTime,
    String eventEndTime,
    String dateNow,
  ) async {
    var url = Constants.API_HOST + "appointment/add_app.php";
    bool ret = false;

    try {
      var map = Map<String, dynamic>();
      map['eventTitle'] = eventTitle;
      map['eventDescription'] = eventDescription;
      map['eventClientName'] = eventClientName;
      map['eventEstheticians'] = eventEstheticians;
      map['bookingID'] = bookingID;
      map['eventStartTime'] = eventStartTime;
      map['eventEndTime'] = eventEndTime;
      map['dateNow'] = dateNow;

      print("CODE DDDD");
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

  //SAVE TIMER DATA
  static Future<bool> appointmentServiceTimer(
      String id, String timeDuration) async {
    var url = Constants.API_HOST + "appointment/update_bookings_timer.php";
    bool ret = false;

    try {
      var map = Map<String, dynamic>();
      map['id'] = id;
      map['timeDuration'] = timeDuration;

      print("CODE appointmentServiceTimer");
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
