// @dart=2.10
import 'package:app/constants/constants.dart';
import 'package:app/controller/ctrl_get_all_events.dart';
import 'package:app/model/event.dart';
import 'package:app/model/model_dateEvents.dart';
import 'package:app/services/ser_get_app.dart';
import 'package:app/services/ser_get_app_pos.dart';
import 'package:app/services/ser_get_customer_data.dart';
import 'package:app/views/screens/scr_calendar/expanded_list/list_customer_sched.dart';
import 'package:app/views/screens/scr_calendar/tracking_events/calendar_add_event.dart';
import 'package:app/views/screens/scr_calendar/tracking_events/calendar_view_event.dart';
import 'package:app/views/screens/scr_home/calendar_timer.dart';
import 'package:app/views/screens/scr_home/timer_scr.dart';
import 'package:app/widgets/calendar_modal/appointment_modal.dart';
import 'package:app/widgets/wid_modal_check_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreenMonthSched extends StatefulWidget {
  @override
  _CalendarScreenMonthSchedState createState() =>
      _CalendarScreenMonthSchedState();
}

class _CalendarScreenMonthSchedState extends State<CalendarScreenMonthSched> {
  var lEvents;
  var lItems;
  List<Appointment> _appointmentDetails = <Appointment>[];

  List<Event> listE = [];
  // Event eventDataVal;

  bool inShow = false;

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  getEvents() async {
    // var events = await ServicesGetAppointment().getAppointment();
    // var events = Constants.eventsInCal;
    // var events = await ServicesGetAppointment().getAppointmentSched();

    // for (int i = 0; i < events.length; i++) {
    //   listE.add(Event(
    //       id: events[i]?.id.toString(),
    //       title: await getItemOrder(events[i].order_item_id.toString()),
    //       from: events[i].from,
    //       to: events[i].to,
    //       description: "",
    //       clientName: await getCustomerData(events[i].customer_id.toString())));
    // }
    setState(() {
      lEvents = Constants.eventsInCal;
      // lEvents = listE;
      // lEvents = events;
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
        print("CAL TAP");
        _appointmentDetails =
            calendarTapDetails.appointments.cast<Appointment>();
        if (_appointmentDetails.length > 0) {
          showDialog(
            context: context,
            builder: (context) {
              return ModalAppointment(
                  lEvents: lEvents, appointmentDetails: _appointmentDetails);
            },
          );
        }
      });
    }
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
        : Column(
            children: [
              Expanded(
                flex: 3,
                child: SfCalendar(
                  view: CalendarView.month,
                  onTap: calendarTapped,
                  dataSource: AppointmentDataSoure(getAppointment(lEvents)),
                  // view: CalendarView.week,
                  todayHighlightColor: Colors.pink.shade900,
                  selectionDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.pink.shade900, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
              // Expanded(
              //     flex: 1,
              //     child: Container(
              //         color: Colors.black12,
              //         child: ListView.separated(
              //           padding: const EdgeInsets.all(2),
              //           itemCount: _appointmentDetails.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             return GestureDetector(
              //               onTap: () {
              //                 print(
              //                     "object KKK ${_appointmentDetails[index].id}");
              //                 print(
              //                     "object KKK ${_appointmentDetails[index].recurrenceId}");
              //                 if (_appointmentDetails[index] != null) {
              //                   if (_appointmentDetails[index].recurrenceId ==
              //                       "confirmed") {
              //                     showDialog(
              //                       context: context,
              //                       builder: (context) {
              //                         return AlertCheckIn(
              //                             appointmentDetails:
              //                                 _appointmentDetails,
              //                             listData: lEvents,
              //                             eventData: _appointmentDetails[index],
              //                             estheticians: Constants.USER_NAME,
              //                             fromDate: DateTime.now(),
              //                             startDateTime: DateTime.now());
              //                       },
              //                     );
              //                   } else if (_appointmentDetails[index]
              //                           .recurrenceId ==
              //                       "checked_in") {
              //                     showDialog(
              //                       context: context,
              //                       builder: (context) {
              //                         return ModalAppointment();
              //                       },
              //                     );
              //                     // Navigator.pop(context);
              //                     Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                             builder: (context) =>
              //                                 CalendarTimerScreen(
              //                                     appointmentDetails:
              //                                         _appointmentDetails,
              //                                     listData: lEvents,
              //                                     eventData:
              //                                         _appointmentDetails[
              //                                             index],
              //                                     estheticians:
              //                                         Constants.USER_NAME,
              //                                     fromDate: DateTime.now(),
              //                                     startDateTime:
              //                                         DateTime.now())));
              //                   }
              //                 }
              //               },
              //               child: Container(
              //                   padding: EdgeInsets.all(2),
              //                   // height: 70,
              //                   color: _appointmentDetails[index].color,
              //                   child: Column(children: [
              //                     Row(
              //                       children: [
              //                         Expanded(
              //                           // flex: 3,
              //                           child: Container(
              //                             child: Column(
              //                               children: [
              //                                 // Container(
              //                                 //     child: Text(
              //                                 //         '${DateFormat('hh:mm a').format(_appointmentDetails[index].startTime)} - ${DateFormat('hh:mm a').format(_appointmentDetails[index].endTime)}',
              //                                 //         textAlign:
              //                                 //             TextAlign.center,
              //                                 //         style: TextStyle(
              //                                 //             fontWeight:
              //                                 //                 FontWeight.w600,
              //                                 //             color: Colors.white,
              //                                 //             height: 1.7))),
              //                                 // Container(
              //                                 //     child: Text(
              //                                 //         '${_appointmentDetails[index].subject}',
              //                                 //         textAlign:
              //                                 //             TextAlign.center,
              //                                 //         style: TextStyle(
              //                                 //             fontWeight:
              //                                 //                 FontWeight.w600,
              //                                 //             color:
              //                                 //                 Colors.white))),
              //                                 // Container(
              //                                 //     child: Text(
              //                                 //         '${_appointmentDetails[index].location}',
              //                                 //         textAlign:
              //                                 //             TextAlign.center,
              //                                 //         style: TextStyle(
              //                                 //             fontWeight:
              //                                 //                 FontWeight.w600,
              //                                 //             color:
              //                                 //                 Colors.white))),
              //                                 // AppointmentCard()
              //                               ],
              //                             ),
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   ])),
              //             );
              //           },
              //           separatorBuilder: (BuildContext context, int index) =>
              //               const Divider(
              //             height: 5,
              //           ),
              //         )))
            ],
          );
  }

  List<Appointment> getAppointment(var allEvents) {
    List<Appointment> lAppointment = <Appointment>[];

    for (int i = 0; i < allEvents.length; i++) {
      // if (i > 0 && i < allEvents.length - 1) {
      //   print(" O P P P O");
      //   if (allEvents[i].from == allEvents[i + 1].from) {
      //     print("object allEvents[i].eventStartTime");
      //     print(allEvents[i].from);
      //   }
      // }
      // print("object allEvents[i].eventStartTime");
      // print(allEvents[i].description);
      var date = new DateTime.fromMillisecondsSinceEpoch(
          int.parse(allEvents[i].from) * 1000);
      var date2 = new DateTime.fromMillisecondsSinceEpoch(
          int.parse(allEvents[i].to) * 1000);
      lAppointment.add(
        Appointment(
            id: allEvents[i].id,
            startTime: date,
            endTime: date2,
            subject: allEvents[i].title,
            notes: allEvents[i].description,
            location: allEvents[i].clientName,
            recurrenceId: allEvents[i].description,
            // resourceIds: allEvents[i].orderId,
            // recurrenceRule: recTime(allEvents[i].repeat, allEvents[i].dayOfWeek),
            color: Colors.pink.shade200),
      );
    }
    // for (int i = 0; i < allEvents.length; i++) {
    //   print(allEvents[i].id);
    //   lAppointment.add(Appointment(
    //       id: allEvents[i].id,
    //       startTime: DateTime.parse(allEvents[i].dateStart),
    //       endTime: DateTime.parse(allEvents[i].dateStart),
    //       subject: convertToTitleCase(allEvents[i].dayOfWeek) + " Schedule",
    //       notes: allEvents[i].repeat,
    //       recurrenceRule: recTime(allEvents[i].repeat, allEvents[i].dayOfWeek),
    //       color: Colors.pink.shade200));
    // }
    return lAppointment;
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
    // String retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO,WED,FRI;UNTIL=20241225';
    String repDay = "";
    print("CONTENTS");
    print(recType);
    print(day);
    if (recType.contains("Weekly")) {
      if (day.contains("monday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO;UNTIL=20241225';
        });
      } else if (day.contains("tuesday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=TUE;UNTIL=20241225';
        });
      } else if (day.contains("wednesday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=WED;UNTIL=20241225';
        });
      } else if (day.contains("thursday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=THU;UNTIL=20241225';
        });
      } else if (day.contains("friday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=FRI;UNTIL=20241225';
        });
      } else if (day.contains("saturday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=SAT;UNTIL=20241225';
        });
      } else if (day.contains("sunday")) {
        setState(() {
          retRec = 'FREQ=WEEKLY;INTERVAL=1;BYDAY=SUN;UNTIL=20241225';
        });
      }
    }
    print("retRec");
    print(retRec);
    return retRec;
  }
}

class AppointmentDataSoure extends CalendarDataSource {
  AppointmentDataSoure(List<Appointment> source) {
    appointments = source;
  }
}
