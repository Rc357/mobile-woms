// @dart=2.10
import 'package:app/model/model_profille.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:app/constants/constants.dart';

class AddOrUpdateProfileImage {
  Future<String> addOrUpdateProfileImage(String imageUrl) async {
    var url = Constants.API_HOST + "profile/add_update_image.php";
    String profile;
    print("CODE CC");
    print(imageUrl);
    try {
      var map = Map<String, dynamic>();
      map['userId'] = Constants.USER_ID.toString();
      map['imageUrl'] = imageUrl;
      map['type'] = "addUpdate";
      final response = await http.post(url, body: map);
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return profile;
      }
    } catch (e) {
      return profile;
    }
  }
}
