// @dart=2.10
import 'dart:convert';
import 'package:app/model/event.dart';
import 'package:app/model/model_get_worked_hrs.dart';
import 'package:app/model/model_schedule_time.dart';
import 'package:app/services/ser_get_app.dart';
import 'package:app/services/ser_get_app_pos.dart';
import 'package:app/services/ser_get_customer_data.dart';
import 'package:app/services/ser_get_worked_hours.dart';
import 'package:app/widgets/wid_button_timer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class MonitorWokedHours extends StatefulWidget {
  @override
  _MonitorWokedHoursState createState() => _MonitorWokedHoursState();
}

class _MonitorWokedHoursState extends State<MonitorWokedHours> {
  var lEvents;
  var lItems;
  List<Appointment> _appointmentDetails = <Appointment>[];
  List<GetWorkedHoursModel> retData;

  List<TimeSchedule> listTime = <TimeSchedule>[];

  List<Event> listE = [];
  bool isSignedIn = false;

  List nameOfDays = ["MON", "TUE", "WED", "THU", "FRI"];
  List hoursOfDays = ["0", "0", "0", "0", "0"];
  List dateOfDays = [
    "00-00-0000",
    "00-00-0000",
    "00-00-0000",
    "00-00-0000",
    "00-00-0000"
  ];
  // Event eventDataVal;

  bool inShow = false;

  DateTime date = DateTime.now();
  int todayHrs = 0;
  int weekHrs = 0;

  @override
  void initState() {
    super.initState();
    print("object WEEKLY");
    print(date.weekday);
    getEvents();
    getLastSession();
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Color(0xFFCD5E77),
        centerTitle: true,
        title: Text("Worked Hours"),
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/woms_bg_00.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 22.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "${weekHrs}",
                              style: TextStyle(
                                color: Colors.pink.shade900,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Weekly total hr/s",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.pinkAccent,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            retData == null
                                ? Container(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator())
                                : Text(
                                    "${todayHrs}",
                                    style: TextStyle(
                                      color: Colors.pink.shade900,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Daily hr/s",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.pinkAccent,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            for (var i = 0; i < nameOfDays.length; i++)
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.pink.shade50,
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 22.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                nameOfDays[i],
                                style: TextStyle(
                                  color: Colors.pink.shade900,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                dateOfDays[i],
                                style: TextStyle(
                                  color: Colors.pinkAccent,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.black45,
                          height: 40,
                          width: 1,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "${hoursOfDays[i]}",
                                style: TextStyle(
                                  color: Colors.pink.shade900,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "hr/s",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.pinkAccent,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> getLastSession() async {
    retData = await GetWorkedHours.getWorkedHours();
    String day = DateFormat('EEEE').format(DateTime.parse(retData[0].workIn));
    print("object day");
    print(day);
    DateTime date = DateTime.now();
    String day1 = DateFormat('EEEE').format(date);
    print("object ddddddd");
    print(day1);

    setState(() {
      if (day == day1) {
        todayHrs = int.parse(retData[0].workTime);
      }
    });

    for (int i = 0; i < retData.length; i++) {
      print("object retData[i].workTime");
      print(weekHrs);
      if (day1 == "Monday") {
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == 0) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[0] = retData[i].workTime;
            dateOfDays[0] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
      } else if (day1 == "Tuesday") {
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == 0) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[1] = retData[i].workTime;
            dateOfDays[1] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == -1) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[0] = retData[i].workTime;
            dateOfDays[0] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
      } else if (day1 == "Wednesday") {
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == 0) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[2] = retData[i].workTime;
            dateOfDays[2] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == -1) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[1] = retData[i].workTime;
            dateOfDays[1] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == -2) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[0] = retData[i].workTime;
            dateOfDays[0] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
      } else if (day1 == "Thursday") {
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == 0) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[3] = retData[i].workTime;
            dateOfDays[3] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == -1) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[2] = retData[i].workTime;
            dateOfDays[2] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == -2) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[1] = retData[i].workTime;
            dateOfDays[1] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == -3) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[0] = retData[i].workTime;
            dateOfDays[0] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
      } else if (day1 == "Friday") {
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == 0) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[4] = retData[i].workTime;
            dateOfDays[4] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == -1) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[3] = retData[i].workTime;
            dateOfDays[3] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == -2) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[2] = retData[i].workTime;
            dateOfDays[2] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == -3) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[1] = retData[i].workTime;
            dateOfDays[1] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
        if (calculateDifference(DateTime.parse(retData[i].workIn)) == -4) {
          String dateString =
              DateFormat.yMMMMd().format(DateTime.parse(retData[i].workIn));
          setState(() {
            hoursOfDays[0] = retData[i].workTime;
            dateOfDays[0] = dateString;
            weekHrs += int.parse(retData[i].workTime);
          });
        }
      }

      print(DateFormat('EEEE').format(DateTime.parse(retData[i].workIn)));
      print(DateTime.parse(retData[i].workIn));
      print(calculateDifference(DateTime.parse(retData[i].workIn)));
    }
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
