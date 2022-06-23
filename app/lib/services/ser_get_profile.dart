// @dart=2.10
import 'dart:convert';
import 'package:app/model/model_profille.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:app/constants/constants.dart';

class ProfileService {
  Future<ProfileModel> profileService(String uname) async {
    var url = Constants.API_HOST + "profile/get_profile_data.php";
    ProfileModel profile;
    print("CODE HERE");
    print(uname);
    print("CODE HEREdddd");
    try {
      var map = Map<String, dynamic>();
      map['username'] = uname;
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        // Map<String, dynamic> user = jsonDecode(response.body);
        // print('Howdy, ${user['name']}!');
        print(response.body);
        Map data = convert.jsonDecode(response.body);
        print("ProfileModel.fromJson(data)");
        ProfileModel template = ProfileModel.fromJson(data);
        print(template.id);
        print(template);
        return template;
      } else {
        print("get agent: failed");
        return profile;
      }
    } catch (e) {
      print(e);
      return profile;
    }
  }

  Future<ProfileModel> checkUserExist(String uname) async {
    print("checkUserExist");
    var url = Constants.API_HOST + "profile/check_user_exist.php";
    ProfileModel profile;
    try {
      var map = Map<String, dynamic>();
      map['username'] = uname;
      print(map);
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        print("asasasasasasa");
        Map data = convert.jsonDecode(response.body);
        ProfileModel template = ProfileModel.fromJson(data);
        print(template.firstName);
        print(template.email);
        return template;
      } else {
        print("get agent: failed");
        return profile;
      }
    } catch (e) {
      return profile;
    }
  }
}
