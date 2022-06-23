// @dart=2.10
import 'dart:convert';
import 'package:app/model/model_get_worked_hrs.dart';
import 'package:http/http.dart' as http;
import 'package:app/constants/constants.dart';
import 'dart:convert' as convert;

class GetWorkedHours {
  //SAVE TIMER DATA
  static Future<List<GetWorkedHoursModel>> getWorkedHours() async {
    var url = Constants.API_HOST + "timer_monitor/get_worked_hrs.php";
    List<GetWorkedHoursModel> template;

    print("object getWorkedHours");

    try {
      var map = Map<String, dynamic>();
      print("Constants.USER_ID");
      print(Constants.USER_ID);
      map['userId'] = Constants.USER_ID.toString();
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        List data = convert.jsonDecode(response.body) as List;
        template = data.map((j) => GetWorkedHoursModel.fromJson(j)).toList();
        // Map<String, dynamic> data = jsonDecode(response.body);
        // template = GetWorkedHoursModel.fromJson(data);
        return template;
      } else {
        print("get agent: failed");
        return template;
      }
    } catch (e) {
      print("object e");
      print(e);
      return template;
    }
  }
}
