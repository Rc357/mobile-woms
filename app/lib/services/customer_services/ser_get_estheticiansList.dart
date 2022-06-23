// @dart=2.10
import 'dart:convert';
import 'package:app/model/model_customer_estheticians.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:app/constants/constants.dart';
import 'package:intl/intl.dart';

class GetEstheticianList {
  Future<EstheticianListModel> getEstheticianList(
      String branchID, String code, String date) async {
    var url = Constants.API_WEB_HOST +
        "api/pos/getBookingEmployeeViaDate/" +
        code +
        "/" +
        branchID +
        "/" +
        date;
    print("GetEstheticianList");
    print(url);
    print("API_WEB_HOST XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");

    try {
      var res = await http.get(url);

      if (res.statusCode == 200) {
        Map<String, dynamic> map = json.decode(res.body);
        List<dynamic> datas = map["data"];

        final estheticianListModel = estheticianListModelFromJson(res.body);
        print(estheticianListModel.data[0].schedules[0].createdAt);
        print("datas[0]");
        print(datas.length);
        print(datas[0]["id"]);
        print(datas[0]["name"]);
        print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
        print(datas[0]["schedules"][0]);
        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        print(datas[0]["schedules"][0]['schedule_shifts'][0]);
        return estheticianListModel;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
