import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/constants/constants.dart';

class UpdateTimeInAndOut {
  //SAVE TIMER DATA
  static Future<bool> updateTimeInOut(String status, String? tokenKey) async {
    var url = Constants.API_HOST + "timer_monitor/update_time_in_and_out.php";
    bool ret = false;
    try {
      var map = Map<String, dynamic>();
      map['type'] = status;
      map['userId'] = Constants.USER_ID.toString();
      map['currentTime'] = DateTime.now().toString().substring(0, 19);
      map['tokenKey'] = tokenKey;

      print("CODE UpdateTimeInAndOut");
      print(map);
      final response = await http.post(url, body: map);
      print("response.body");
      print(response.body);
      if (response.statusCode == 200) {
        var data = response.body;

        print("data SASASAS");
        print(data);
        if (data == "SUCCESS") {
          ret = true;
          print("object SASASAS");
        }
        return ret;
      } else {
        return ret;
      }
    } catch (e) {
      print(e);
      return ret;
    }
  }
}
