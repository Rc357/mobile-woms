// @dart=2.10
import 'package:app/controller/ctrl_get_all_events.dart';
import 'package:app/model/model_dateEvents.dart';
import 'package:app/model/model_dates.dart';
import 'package:app/services/ser_get_app.dart';
import 'package:app/views/screens/scr_calendar/tracking_events/calendar_view_event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'dart:convert';

class CalendarScreenWeeklySched extends StatefulWidget {
  @override
  _CalendarScreenWeeklySchedState createState() =>
      _CalendarScreenWeeklySchedState();
}

class _CalendarScreenWeeklySchedState extends State<CalendarScreenWeeklySched> {
  var lEvents;

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  getEvents() async {
    var events = await ServicesGetAppointment().getAppointmentSched();
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
            view: CalendarView.week,
            onLongPress: (data) {
              if (data.appointments.isNotEmpty) {
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
          startTime: convertDateTime(
              allEvents[i].dateStart, allEvents[i].scheduleShifts, true),
          // startTime: DateTime.parse(allEvents[i].dateStart),
          endTime: convertDateTime(
              allEvents[i].dateStart, allEvents[i].scheduleShifts, false),
          // endTime: DateTime.parse(allEvents[i].dateStart),
          subject: allEvents[i].dayOfWeek,
          notes: allEvents[i].repeat,
          color: Colors.pink.shade200));
    }
    return lAppointment;
  }

  DateTime convertDateTime(String sDate, String sTime, bool isStart) {
    DateTime str;
    String sTimeClean;
    String eTimeClean;
    List lTime = parseResponseTimer(sTime);
    sTimeClean = lTime[0].startTime.substring(0, lTime[0].startTime.length - 2);
    eTimeClean = lTime[0].endTime.substring(0, lTime[0].endTime.length - 2);

    if (isStart) {
      if (lTime[0].startTime.contains("am")) {
        print("object AM");
        print(sDate);
        print(sTimeClean);
        final split = sTimeClean.split(":");
        if (split[0].length == 1) {
          sTimeClean = sDate + " 0" + sTimeClean;
        } else {
          sTimeClean = sDate + " " + sTimeClean;
        }
        str = DateTime.parse(sTimeClean);
        print(str);
      }
    } else {
      if (lTime[0].endTime.contains("pm")) {
        print("object PM");
        print(eTimeClean);
        final split = eTimeClean.split(":");
        if (split[0].length == 1) {
          eTimeClean = sDate + " 0" + eTimeClean;
        } else {
          eTimeClean = sDate + " " + eTimeClean;
        }
        str = DateTime.parse(eTimeClean).add(Duration(hours: 12));
        print(str);
      }
    }
    return str;
  }

  List parseResponseTimer(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed.map<ListOfDate>((json) => ListOfDate.fromJson(json)).toList();
  }
}

class AppointmentDataSoure extends CalendarDataSource {
  AppointmentDataSoure(List<Appointment> source) {
    appointments = source;
  }
}
