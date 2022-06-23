// @dart=2.10
import 'package:app/model/model_customer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:app/constants/constants.dart';

class GetCustomerData {
  Future<CustomerModel> getCustomerData(String id) async {
    var url = Constants.API_HOST + "appointment/get_customer_data.php";
    CustomerModel profile;
    print("CODE CC");
    print(id);
    try {
      var map = Map<String, dynamic>();
      map['customerID'] = id;
      map['type'] = "id";
      final response = await http.post(url, body: map);
      print(response.body);
      if (response.statusCode == 200) {
        Map data = convert.jsonDecode(response.body);
        CustomerModel template = CustomerModel.fromJson(data);
        print(template.id);
        print(template);
        return template;
      } else {
        return profile;
      }
    } catch (e) {
      return profile;
    }
  }

  Future<CustomerModel> getCustomerDataByEmail(String email) async {
    var url = Constants.API_HOST + "appointment/get_customer_data.php";
    CustomerModel profile;
    print("CODE CC");
    print(email);
    try {
      var map = Map<String, dynamic>();
      map['customerEmail'] = email;
      map['type'] = "email";
      final response = await http.post(url, body: map);
      print(response.body);
      if (response.statusCode == 200) {
        Map data = convert.jsonDecode(response.body);
        CustomerModel template = CustomerModel.fromJson(data);
        print(template.id);
        print(template);
        return template;
      } else {
        return profile;
      }
    } catch (e) {
      return profile;
    }
  }
}
