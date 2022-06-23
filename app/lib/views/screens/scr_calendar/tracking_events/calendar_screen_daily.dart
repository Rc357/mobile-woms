import 'package:app/controller/ctrl_get_all_events.dart';
import 'package:app/model/model_dateEvents.dart';
import 'package:app/services/ser_get_app.dart';
import 'package:app/views/screens/scr_calendar/tracking_events/calendar_view_event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreenDaily extends StatefulWidget {
  @override
  _CalendarScreenDailyState createState() => _CalendarScreenDailyState();
}

class _CalendarScreenDailyState extends State<CalendarScreenDaily> {
  var lEvents;

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  getEvents() async {
    var events = await ServicesGetAppointment().getAppointment();
    setState(() {
      lEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return lEvents == null
        ? Container(
            child: Center(
              child: LoadingBouncingGrid.circle(
                  backgroundColor: Colors.pink.shade200,
                  duration: Duration(milliseconds: 500)),
            ),
          )
        : SfCalendar(
            view: CalendarView.day,
            onLongPress: (data) {
              if (data.appointments!.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CalendareViewEvents(
                            date: data.date,
                            event: data.appointments,
                            lEvents: lEvents)));
              }
            },
            dataSource: AppointmentDataSoure(getAppointment(lEvents)),
            // view: CalendarView.week,
            todayHighlightColor: Colors.pink.shade900,
            selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.pink.shade900, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              shape: BoxShape.rectangle,
            ),
          );
  }

  List<Appointment> getAppointment(var allEvents) {
    List<Appointment> lAppointment = <Appointment>[];

    for (int i = 0; i < allEvents.length; i++) {
      print(allEvents[i].code);
      lAppointment.add(Appointment(
          id: allEvents[i].code,
          startTime: DateTime.parse(allEvents[i].product_id),
          endTime: DateTime.parse(allEvents[i].employee_id),
          subject: allEvents[i].eventTitle,
          notes: allEvents[i].to,
          color: Colors.pink.shade200));
    }
    return lAppointment;
  }
}

class AppointmentDataSoure extends CalendarDataSource {
  AppointmentDataSoure(List<Appointment> source) {
    appointments = source;
  }
}
