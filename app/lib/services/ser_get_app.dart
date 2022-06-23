// @dart=2.10
import 'dart:convert';
import 'package:app/model/model_calendar.dart';
import 'package:app/model/model_dateEvents.dart';
import 'package:http/http.dart' as http;
import 'package:app/constants/constants.dart';

class ServicesGetAppointment {
  // String url = Constants.API_HOST + "appointment/get_app.php";

  Future<List<DateAndEvents>> getAppointment() async {
    String url = Constants.API_HOST + "appointment/get_app.php";
    try {
      final response = await http.get(url);
      print("GET ALL");
      // print(response.body);
      if (response.statusCode == 200) {
        final List<DateAndEvents> list = parseResponse(response.body);
        print(list.length);
        for (int i = 0; i < list.length; i++) {
          print(list[i].evenDateID);
        }
        return list;
      } else {
        return <DateAndEvents>[];
      }
    } catch (e) {
      return <DateAndEvents>[];
    }
  }

  List<DateAndEvents> parseResponse(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed
        .map<DateAndEvents>((json) => DateAndEvents.fromJson(json))
        .toList();
  }

  Future<List<DateAndEventsSched>> getAppointmentSched() async {
    String url = Constants.API_HOST + "appointment/get_app_sched.php";
    var map = Map<String, dynamic>();
    map['userID'] = Constants.USER_ID.toString();
    try {
      final response = await http.post(url, body: map);
      // final response = await http.get(url);
      print("GET ALL getAppointmentSched");
      print(Constants.USER_ID.toString());
      if (response.statusCode == 200) {
        final List<DateAndEventsSched> list = parseResponseSched(response.body);
        print(list.length);
        for (int i = 0; i < list.length; i++) {
          // print(list[i].scheduleShifts);
          // print(DateTime.parse(list[i].dateStart));
          // List l = parseResponseTimer(list[i].scheduleShifts);
          // print(l[0].startTime);
        }
        return list;
      } else {
        return <DateAndEventsSched>[];
      }
    } catch (e) {
      return <DateAndEventsSched>[];
    }
  }

  List<DateAndEventsSched> parseResponseSched(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed
        .map<DateAndEventsSched>((json) => DateAndEventsSched.fromJson(json))
        .toList();
  }

  Future<DateAndEventsSched> getTodaySchedule() async {
    DateAndEventsSched retData;
    String url = Constants.API_HOST + "appointment/get_app_sched.php";
    var map = Map<String, dynamic>();
    map['userID'] = Constants.USER_ID.toString();
    try {
      final response = await http.post(url, body: map);
      // final response = await http.get(url);
      print("GET ALL getAppointmentSched");
      print(Constants.USER_ID.toString());
      if (response.statusCode == 200) {
        final List<DateAndEventsSched> list = parseResponseSched(response.body);
        print(list.length);
        for (int i = 0; i < list.length; i++) {
          print(list[i].scheduleShifts);
          print(DateTime.parse(list[i].dateStart));
          // List l = parseResponseTimer(list[i].scheduleShifts);
          // print(l[0].startTime);
        }
        return retData;
      } else {
        return retData;
      }
    } catch (e) {
      return retData;
    }
  }

  // List parseResponseTimer(String body) {
  //   final parsed = json.decode(body).cast<Map<String, dynamic>>();
  //   return parsed.map<ListOfDate>((json) => ListOfDate.fromJson(json)).toList();
  // }
}

// class ListOfDate {
//   final String startTime;
//   final String endTime;
//   ListOfDate({
//     this.startTime,
//     this.endTime,
//   });

//   factory ListOfDate.fromJson(Map<String, dynamic> json) {
//     return ListOfDate(
//       startTime: json['time_start'],
//       endTime: json['time_end'],
//     );
//   }
// }
