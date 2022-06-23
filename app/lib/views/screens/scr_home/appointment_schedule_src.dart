// @dart=2.10
import 'dart:convert';
import 'package:app/model/event.dart';
import 'package:app/model/model_schedule_time.dart';
import 'package:app/services/ser_get_app.dart';
import 'package:app/services/ser_get_app_pos.dart';
import 'package:app/services/ser_get_customer_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentSchedule extends StatefulWidget {
  @override
  _AppointmentScheduleState createState() => _AppointmentScheduleState();
}

class _AppointmentScheduleState extends State<AppointmentSchedule> {
  var lEvents;
  var lItems;
  List<Appointment> _appointmentDetails = <Appointment>[];

  List<TimeSchedule> listTime = <TimeSchedule>[];

  List<Event> listE = [];
  // Event eventDataVal;

  bool inShow = false;

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

  Future getItemOrder(String id) async {
    String serName = "";
    var items = await ServicesGetAppointmentPos().orderName(id);
    setState(() {
      serName = items.name;
    });
    return serName;
  }

  Future getCustomerData(String id) async {
    String cusName = "";
    var items = await GetCustomerData().getCustomerData(id);
    setState(() {
      cusName = items.first_name + " " + items.last_name;
    });
    return cusName;
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      setState(() {
        _appointmentDetails =
            calendarTapDetails.appointments.cast<Appointment>();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCD5E77),
        centerTitle: true,
        title: Text("Schedule"),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: lEvents == null
          ? Container(
              child: Center(
                child: LoadingBouncingGrid.circle(
                    backgroundColor: Colors.pink.shade200,
                    duration: Duration(milliseconds: 500)),
              ),
            )
          : Scaffold(
              body: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SfCalendar(
                        view: CalendarView.month,
                        onLongPress: (data) {
                          if (data.appointments.isNotEmpty) {
                            print("LONG PRESS");
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => CalendarTimerScreen(
                            //             listData: lEvents,
                            //             eventData: data.appointments,
                            //             estheticians: Constants.USER_NAME,
                            //             fromDate: DateTime.now(),
                            //             startDateTime: DateTime.now())));
                          }
                        },
                        onTap: calendarTapped,
                        dataSource:
                            AppointmentDataSoure(getAppointment(lEvents)),
                        // view: CalendarView.week,
                        todayHighlightColor: Colors.pink.shade900,
                        selectionDecoration: BoxDecoration(
                          color: Colors.transparent,
                          border:
                              Border.all(color: Colors.pink.shade900, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                            color: Colors.black12,
                            child: ListView.separated(
                              padding: const EdgeInsets.all(2),
                              itemCount: _appointmentDetails.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    print(
                                        "object KKK ${_appointmentDetails[index].id}");
                                    print(
                                        "object KKK ${_appointmentDetails[index].notes}");
                                    print(
                                        "object KKK ${_appointmentDetails[index].startTime}");
                                    // if (_appointmentDetails[index] != null) {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               CalendarTimerScreen(
                                    //                   listData: lEvents,
                                    //                   eventData:
                                    //                       _appointmentDetails[
                                    //                           index],
                                    //                   estheticians:
                                    //                       Constants.USER_NAME,
                                    //                   fromDate: DateTime.now(),
                                    //                   startDateTime:
                                    //                       DateTime.now())));
                                    // }
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(2),
                                      height: 50,
                                      color: _appointmentDetails[index].color,
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              // flex: 3,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        child: Text(
                                                            convertTime(
                                                                "${_appointmentDetails[index].notes}"),
                                                            // '${DateFormat('hh:mm a').format(_appointmentDetails[index].startTime)} - ${DateFormat('hh:mm a').format(_appointmentDetails[index].endTime)}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                                height: 1.7))),
                                                    Container(
                                                        child: Text(
                                                            '${_appointmentDetails[index].subject}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white))),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ])),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                height: 5,
                              ),
                            )))
                  ],
                ),
              ),
            ),
    );
  }

  List<Appointment> getAppointment(var allEvents) {
    List<Appointment> lAppointment = <Appointment>[];

    for (int i = 0; i < allEvents.length; i++) {
      print(allEvents[i].code);
      print(allEvents[i].scheduleShifts);
      print("formatTimeOfDay");
      // print(formatTimeOfDay);
      bool lastEvent = false;
      // String timer = "01:30 PM";
      // DateTime dates = DateTime.parse();
      DateTime fdate = DateFormat("yyyy-MM-dd").parse(allEvents[i].dateStart);
      DateTime ftime =
          DateFormat.Hm().parse(getStartTime(allEvents[i].scheduleShifts));
      final dateTime = DateTime(fdate.year, fdate.month, fdate.day, ftime.hour,
          ftime.minute, ftime.second);
      print("dateTime");
      print(dateTime);

      var now = new DateTime.now();
      var dayDates = DateTime.parse(allEvents[i].dateStart);
      var berlinWallFellDate = new DateTime.utc(2022, 11, 9);
      // 0 denotes being equal positive value greater and negative value being less
      if (berlinWallFellDate.compareTo(now) > 0) {
        //peform logic here.....
        print("object AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
        lastEvent = true;
      } else {
        lastEvent = true;
        print("object BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
      }

      lAppointment.add(Appointment(
        id: allEvents[i].code,
        startTime: DateTime.parse(allEvents[i].dateStart),
        endTime: DateTime.parse(allEvents[i].dateStart),
        subject: convertToTitleCase(allEvents[i].dayOfWeek) + " Schedule",
        notes: allEvents[i].scheduleShifts,
        recurrenceRule: recTime(allEvents[i].repeat, allEvents[i].dayOfWeek),
        color: Colors.pink.shade200,
        // color: lastEvent ? Colors.red.shade200 : Colors.pink.shade200,
      ));
    }

    print("object lAppointment");
    print(lAppointment.length);
    return lAppointment;
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  String convertToTitleCase(String text) {
    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = text.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }

  String recTime(String recType, String day) {
    String retRec = '';
    final _now = new DateTime.now();

    print("_dt");
    var newDate =
        Jiffy(DateTime(_now.year, _now.month, _now.day)).add(years: 2).dateTime;
    print(newDate);
    String until = DateFormat('yyyyMMdd').format(newDate);
    print(until);
    print("CONTENTS");
    print(recType);
    print(day);
    if (recType.contains("Weekly")) {
      if (day.contains("monday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO;UNTIL=$until';
        });
      } else if (day.contains("tuesday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=TUE;UNTIL=$until';
        });
      } else if (day.contains("wednesday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=WED;UNTIL=$until';
        });
      } else if (day.contains("thursday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=THU;UNTIL=$until';
        });
      } else if (day.contains("friday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=FRI;UNTIL=$until';
        });
      } else if (day.contains("saturday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=SAT;UNTIL=$until';
        });
      } else if (day.contains("sunday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=SUN;UNTIL=$until';
        });
      }
    }
    print("retRec");
    print(retRec);
    return retRec;
  }

  List<TimeSchedule> parseResponse(String body) {
    final parsed = json.decode(body).cast<Map<String, dynamic>>();
    return parsed
        .map<TimeSchedule>((json) => TimeSchedule.fromJson(json))
        .toList();
  }

  String convertTime(String lTime) {
    String timeReturn = "";
    final List<TimeSchedule> listTime = parseResponse(lTime);
    for (int i = 0; i < listTime.length; i++) {
      print(listTime[i].startTime);
      print(listTime[i].endTime);
      timeReturn = listTime[i].startTime + "-" + listTime[i].endTime;
    }
    return timeReturn;
  }

  String getStartTime(String lTime) {
    String timeReturn = "";
    final List<TimeSchedule> listTime = parseResponse(lTime);
    for (int i = 0; i < listTime.length; i++) {
      print(listTime[i].startTime);
      timeReturn = listTime[i].startTime;
    }
    return timeReturn;
  }
}

class AppointmentDataSoure extends CalendarDataSource {
  AppointmentDataSoure(List<Appointment> source) {
    appointments = source;
  }
}
