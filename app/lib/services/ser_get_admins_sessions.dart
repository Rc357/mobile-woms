// @dart=2.10
import 'dart:convert';
import 'package:app/model/model_profille.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:app/constants/constants.dart';

class CheckTimeSesssion {
  Future<bool> checkTimeSesssion(String functionType, String username,
      String tokenKey, String dateTimeNow) async {
    var url = Constants.API_HOST + "profile/get_admins_sessions.php";
    bool ret = false;
    try {
      var map = Map<String, dynamic>();
      map['functionType'] = functionType;
      map['username'] = username;
      map['tokenKey'] = tokenKey;
      map['dateTimeNow'] = dateTimeNow;
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        print("object response.body");
        print(response.body);
        if (response.body.contains("success")) {
          ret = true;
        }
        return ret;
      } else {
        print("get agent: failed");
        return ret;
      }
    } catch (e) {
      return ret;
    }
  }
}
