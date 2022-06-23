// @dart=2.10
import 'package:app/model/model_dateEvents.dart';
import 'package:app/services/ser_get_app.dart';
import 'package:get/get.dart';

class GetAllEventsController extends GetxController {
  var events = List<DateAndEvents>();
  @override
  void onInit() {
    super.onInit();
    fetchAllEvents();
  }

  void fetchAllEvents() async {
    var results = await ServicesGetAppointment().getAppointment();

    events = results;
  }
}
