// @dart=2.10
import 'dart:convert';
import 'package:app/model/model_branch_services.dart';
import 'package:app/model/model_customer_booking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:app/constants/constants.dart';

class GetServicesByBranch {
  Future<List<dynamic>> getServicesByBranch(String branchID) async {
    var url = Constants.API_WEB_HOST +
        "api/pos/multiple-membership-booking/fetchOutletProduct/" +
        branchID +
        "/" +
        Constants.CUS_ID.toString();
    print("GetServicesByBranch");
    print(url);
    print("API_WEB_HOST");

    try {
      var res = await http.get(url);

      if (res.statusCode == 200) {
        Map<String, dynamic> map = json.decode(res.body);
        List<dynamic> datas = map["data"];
        print("datas[0]");
        print(datas.length);
        print(datas[0]["code"]);
        print(datas[1]["code"]);
        return datas;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
