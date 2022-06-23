import 'package:app/constants/constants.dart';
import 'package:app/model/event.dart';
import 'package:app/services/ser_get_app_pos.dart';
import 'package:app/services/ser_get_customer_data.dart';
import 'package:app/views/screens/scr_calendar/calendar_sched/calendar_screen_daily.dart';
import 'package:app/views/screens/scr_calendar/calendar_sched/calendar_screen_month.dart';
import 'package:app/views/screens/scr_calendar/calendar_sched/calendar_screen_weekly.dart';
import 'package:app/views/screens/scr_calendar/tracking_events/calendar_add_event.dart';
import 'package:app/views/screens/scr_calendar/tracking_events/calendar_screen_daily.dart';
import 'package:app/views/screens/scr_calendar/tracking_events/calendar_screen_month.dart';
import 'package:app/views/screens/scr_calendar/tracking_events/calendar_screen_weekly.dart';
import 'package:app/views/screens/scr_home/timer_scr.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String viewName = "View Monthly";

  List<Event> listE = [];
  var calenView = CalendarView.month;
  var items = [
    'View Weekly',
    'View Daily',
    'View Monthly',
  ];

  changeView() async {
    if (viewName.contains("Monthly")) {
      setState(() {
        calenView = CalendarView.month;
      });
    } else if (viewName.contains("Weekly")) {
      setState(() {
        calenView = CalendarView.week;
      });
    } else {
      setState(() {
        calenView = CalendarView.day;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    // if (Constants.eventsInCal.isEmpty) {
    setState(() {
      Constants.eventsInCal = [];

      listE = [];
    });
    await getEvents();
    // }
  }

  getEvents() async {
    Constants.eventsInCal = [];
    var events = await ServicesGetAppointmentPos().getAppointmentPos();
    for (int i = 0; i < events.length; i++) {
      listE.add(Event(
        id: events[i].id.toString(),
        title: events[i]
            .order_item_id, //await getItemOrder(events[i].order_item_id.toString()),
        from: events[i].from,
        to: events[i].to,
        orderId: events[i].order_id,
        description: events[i].status,
        clientName: events[i]
            .customer_id, // await getCustomerData(events[i].customer_id.toString()),
      ));
    }
    setState(() {
      Constants.eventsInCal = listE;
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: listE.isEmpty
          ? Container(
              child: Center(
                child: LoadingBouncingGrid.circle(
                    backgroundColor: Colors.pink.shade200,
                    duration: Duration(milliseconds: 500)),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFFCD5E77),
                centerTitle: false,
                title: Text("Calendar"),
                automaticallyImplyLeading: false,
                elevation: 0,
                actions: [
                  new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color(0xFFCD5E77),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () => getData(),
                          child: Icon(
                            Icons.refresh_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Container(child: CalendarScreenMonthSched()),
              // body: RefreshIndicator(
              //     onRefresh: () => getData(), child: CalendarScreenMonthSched())
              // floatingActionButton: FloatingActionButton(
              //     backgroundColor: Colors.pink.shade200,
              //     child: Icon(
              //       Icons.add,
              //       color: Colors.white,
              //     ),
              //     onPressed: () => Navigator.of(context).push(
              //         MaterialPageRoute(builder: (context) => EventEditingScreen()))),
            ),
    );
  }
}
