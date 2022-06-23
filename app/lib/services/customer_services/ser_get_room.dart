// @dart=2.10
import 'package:app/model/model_customer_room.dart';
import 'package:http/http.dart' as http;
import 'package:app/constants/constants.dart';

class GetAvailableRoom {
  Future<AvailableRoomModel> getAvailableRoom(String sCode, String date,
      String timeStamp, String duration, String brId) async {
    var url = Constants.API_WEB_HOST +
        "api/pos/getBookingRooms/" +
        sCode +
        "/" +
        date +
        "/" +
        timeStamp +
        "/" +
        duration +
        "/" +
        brId;
    print("GetAvailableRoom");
    print(url);

    try {
      var res = await http.get(url);

      if (res.statusCode == 200) {
        final estheticianListModel = availableRoomModelFromJson(res.body);
        return estheticianListModel;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
