// @dart=2.10
import 'dart:convert';
import 'package:app/model/model_closed_dates.dart';
import 'package:app/model/model_customer_booking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:app/constants/constants.dart';

class GetCloseDates {
  Future<List<ClosedDatesModel>> getCloseDates(String branchID) async {
    var url = Constants.API_WEB_HOST +
        "admin/customer-calendar/get-close-dates/" +
        branchID;
    print("GetCloseDates");
    print(url);
    print("API_WEB_HOST");

    try {
      final response = await http.get(url);
      // print(response.body);
      if (response.statusCode == 200) {
        final List<ClosedDatesModel> list = parseResponse(response.body);
        print(list[0].description);
        return list;
      } else {
        return <ClosedDatesModel>[];
      }
    } catch (e) {
      print("Error Future");
      print(e);
      return <ClosedDatesModel>[];
    }
  }

  List<ClosedDatesModel> parseResponse(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed
        .map<ClosedDatesModel>((json) => ClosedDatesModel.fromJson(json))
        .toList();
  }
}
