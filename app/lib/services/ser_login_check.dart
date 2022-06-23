import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/constants/constants.dart';

class UserServiceCheck {
  static Future<bool> loginService(String uname, String pass) async {
    var url = Constants.API_HOST + "auth/api_login_check.php";
    bool ret = false;
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
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
