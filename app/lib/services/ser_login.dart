import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/constants/constants.dart';

class UserService {
  static Future<String?> loginService(
      String uname, String pass, String timeIn, String v1Token) async {
    var url = Constants.API_HOST + "auth/api_login.php";
    bool ret = false;
    try {
      var map = Map<String, dynamic>();
      map['username'] = uname;
      map['password'] = pass;
      map['timeIn'] = '0000-01-01 00:00:00';
      map['tokenKey'] = v1Token;

      print("CODE DDDD loginService");
      print(map);
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("object");
        print(data);
        print(response.body);

        if (data == "success") {
          return "success";
        } else if (data == "customer") {
          return "customer";
        }
      } else {
        return "none";
      }
    } catch (e) {
      print(" loginService ");
      print(e);
      return "none";
    }
  }

  Future<bool> logoutService(
      String? uname, String timeOut, String? v1Token) async {
    var url = Constants.API_HOST + "auth/api_logout.php";
    bool ret = false;
    try {
      print("logoutService");
      var map = Map<String, dynamic>();
      map['username'] = uname;
      map['timeOut'] = timeOut;
      map['tokenKey'] = v1Token;
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        print(response.body);
        var data = json.decode(response.body);
        if (data == "success") {
          ret = true;
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
