// @dart=2.10
import 'dart:convert';
import 'package:app/model/model_customer_slot.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:app/constants/constants.dart';
import 'package:intl/intl.dart';

class GetSlotTime {
  Future<SlotTimeModel> getSlotTime(String date, String estId, String duration,
      String brId, String serCode) async {
    var url = Constants.API_WEB_HOST +
        "api/pos/getBookingSlots/" +
        date +
        "/" +
        estId +
        "/" +
        duration +
        "/" +
        brId +
        "/" +
        serCode;
    print("GetSlotTime");
    print(url);

    try {
      var res = await http.get(url);

      if (res.statusCode == 200) {
        final estheticianListModel = slotTimeModelFromJson(res.body);
        return estheticianListModel;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
