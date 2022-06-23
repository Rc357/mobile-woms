import 'package:app/views/screens/scr_calendar/tracking_events/calendar_screen_daily.dart';
import 'package:app/views/screens/scr_calendar/tracking_events/calendar_screen_month.dart';
import 'package:app/views/screens/scr_calendar/tracking_events/calendar_screen_weekly.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPageTracking extends StatefulWidget {
  @override
  _CalendarPageTrackingState createState() => _CalendarPageTrackingState();
}

class _CalendarPageTrackingState extends State<CalendarPageTracking> {
  String viewName = "View Daily";
  var calenView = CalendarView.week;
  var items = [
    'View Daily',
    'View Weekly',
    // 'View Monthly',
  ];

  changeView() async {
    if (viewName.contains("Weekly")) {
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCD5E77),
        title: Text("Log Tracking"),
        centerTitle: true,
        // automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: CalendarScreenMonth(),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.pink.shade200,
      //     child: Icon(
      //       Icons.add,
      //       color: Colors.white,
      //     ),
      //     onPressed: () => Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) => EventEditingScreen()))),
    );
  }
}
