// @dart=2.10
import 'dart:async';
import 'dart:convert';
import 'package:app/constants/constants.dart';
import 'package:app/model/event.dart';
import 'package:app/model/model_closed_dates.dart';
import 'package:app/model/model_customer_appointment.dart';
import 'package:app/model/model_schedule_time.dart';
import 'package:app/services/customer_services/ser_get_closed_dates.dart';
import 'package:app/services/customer_services/ser_get_customer_appointment.dart';
import 'package:app/services/customer_services/ser_get_last_and_future_appointment.dart';
import 'package:app/services/customer_services/ser_get_product_by_branch.dart';
import 'package:app/services/ser_get_app.dart';
import 'package:app/services/ser_get_app_pos.dart';
import 'package:app/services/ser_get_customer_data.dart';
import 'package:app/views/pages/customer/cus_add_appointment_page.dart';
import 'package:app/views/screens/scr_home/calendar_timer.dart';
import 'package:app/widgets/wid_modal_select_branch.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomerCalendar extends StatefulWidget {
  @override
  _CustomerCalendarState createState() => _CustomerCalendarState();
}

enum Branch { None, Airmont, BoroughPark }

class _CustomerCalendarState extends State<CustomerCalendar> {
  var lEvents;
  var lItems;
  List<Appointment> _appointmentDetails = <Appointment>[];

  List<TimeSchedule> listTime = <TimeSchedule>[];
  bool isShowGuide = false;

  List<Event> listE = [];

  List<dynamic> branchServices = [];
  // Event eventDataVal;

  bool inShow = false;
  DateTime _today = DateTime.now();

  String selected = "None";
  Branch _site = Branch.None;
  String _branchID = '0';

  @override
  void initState() {
    super.initState();
    getEvents('1');
  }

  void guideTimer() {
    Timer(const Duration(seconds: 10), () {
      setState(() {
        isShowGuide = false;
      });
    });
  }

//Get booking appointment
  getEvents(String branchID) async {
    // var events = await ServicesGetAppointment().getAppointmentSched();
    List<CustomerAppointment> events = await ServicesGetCustomerAppointment()
        .servicesGetCustomerAppointment(branchID);

    //Get closed dates
    List<CustomerAppointment> holderEvents = [];
    List<ClosedDatesModel> closedDates =
        await GetCloseDates().getCloseDates(branchID);
    List<CustomerAppointment> newList = [];
    if (closedDates != null) {
      for (int x = 0; x < closedDates.length; x++) {
        var f = (DateTime.parse(closedDates[x].date_start)
            .toUtc()
            .millisecondsSinceEpoch);
        var t = (DateTime.parse(closedDates[x].date_end)
            .toUtc()
            .millisecondsSinceEpoch);
        holderEvents.add(CustomerAppointment(
          id: '00',
          from: '${f}', //closedDates[x].date_start,
          to: '${t}', //closedDates[x].date_end,
          order_item_id: closedDates[x].description,
        ));
      }
      newList = new List.from(events)..addAll(holderEvents);
    }
    setState(() {
      lEvents = newList;
    });
    // getClosedDatesByBranch(branchID);
  }

  Future getServicesByBranchID(int siteId) async {
    List<dynamic> _branchServices = [];
    _branchServices =
        await GetServicesByBranch().getServicesByBranch('${siteId}');
    setState(() {
      //get services by branch
      branchServices = _branchServices;
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
        title: Text("My Calendar"),
        automaticallyImplyLeading: false,
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Please select a branch: ',
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 35.0,
                          child: ListTile(
                            title: const Text('Airmont'),
                            leading: Radio(
                              value: Branch.Airmont,
                              groupValue: _site,
                              onChanged: (Branch value) {
                                setState(() {
                                  _site = value;
                                  isShowGuide = true;
                                  _branchID = '1';
                                  guideTimer();
                                  getEvents(_branchID);
                                  getServicesByBranchID(1);
                                });
                              },
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text('Borough Park'),
                          leading: Radio(
                            value: Branch.BoroughPark,
                            groupValue: _site,
                            onChanged: (Branch value) {
                              setState(() {
                                _site = value;
                                isShowGuide = true;
                                _branchID = '2';
                                guideTimer();
                                getEvents(_branchID);
                                getServicesByBranchID(2);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    isShowGuide
                        ? Container(
                            color: Colors.pink.shade900,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Tap a cell on the calendar to view the appointment",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(
                                    "and long press to add an appointment.",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    //Calendar Section
                    Expanded(
                      flex: 3,
                      child: SfCalendar(
                        view: CalendarView.month,
                        onLongPress: (data) {
                          if (data.date.isAfter(_today) && _branchID != '0') {
                            print("data.date");
                            print(data.date);
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return SelectBranch(
                                    branchServices: branchServices,
                                    dateString: data.date,
                                    branchId: _branchID);
                              },
                            );
                          } else if (_branchID == '0') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please select branch"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Closed date"),
                            ));
                          }
                          if (data.appointments.isNotEmpty) {
                            print("LONG PRESS");
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
                                    if (_appointmentDetails[index] != null &&
                                        _appointmentDetails[index].id != '00') {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             CalendarTimerScreen(
                                      //                 listData: lEvents,
                                      //                 eventData:
                                      //                     _appointmentDetails[
                                      //                         index],
                                      //                 estheticians:
                                      //                     Constants.USER_NAME,
                                      //                 fromDate: DateTime.now(),
                                      //                 startDateTime:
                                      //                     DateTime.now())));
                                    }
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
                                                    _appointmentDetails[
                                                                    index]
                                                                .id !=
                                                            '00'
                                                        ? Container(
                                                            child: Text(
                                                                "${_appointmentDetails[index].notes}",
                                                                // convertTime(
                                                                //     "${_appointmentDetails[index].notes}"),
                                                                // '${DateFormat('hh:mm a').format(_appointmentDetails[index].startTime)} - ${DateFormat('hh:mm a').format(_appointmentDetails[index].endTime)}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white,
                                                                    height:
                                                                        1.7)))
                                                        : Container(
                                                            child: Text(
                                                                "CLOSED DATE",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white,
                                                                    height:
                                                                        1.7))),
                                                    Container(
                                                        child: Center(
                                                      child: Text(
                                                          '${_appointmentDetails[index].subject}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .white)),
                                                    )),
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

  List<Appointment> getAppointment(List<CustomerAppointment> allEvents) {
    List<Appointment> lAppointment = <Appointment>[];

    for (int i = 0; i < allEvents.length; i++) {
      if (allEvents[i].id == '00') {
        DateTime startDate =
            DateTime.fromMillisecondsSinceEpoch(int.parse(allEvents[i].from));
        DateTime endDate =
            DateTime.fromMillisecondsSinceEpoch(int.parse(allEvents[i].to));
        lAppointment.add(Appointment(
          id: allEvents[i].id,
          startTime: startDate,
          endTime: endDate,
          subject: " ${allEvents[i].order_item_id}",
          notes:
              "${DateFormat.jm().format(startDate)} - ${DateFormat.jm().format(endDate)}",
          color: Colors.red,
        ));
      } else {
        DateTime startDate = DateTime.fromMillisecondsSinceEpoch(
            int.parse(allEvents[i].from) * 1000);
        DateTime endDate = DateTime.fromMillisecondsSinceEpoch(
            int.parse(allEvents[i].to) * 1000);

        lAppointment.add(Appointment(
          id: allEvents[i].id,
          startTime: startDate,
          endTime: endDate,
          subject: " ${allEvents[i].order_item_id}",
          notes:
              "${DateFormat.jm().format(startDate)} - ${DateFormat.jm().format(endDate)}",
          color: Colors.pink.shade200,
        ));
      }
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
}

class AppointmentDataSoure extends CalendarDataSource {
  AppointmentDataSoure(List<Appointment> source) {
    appointments = source;
  }
}
