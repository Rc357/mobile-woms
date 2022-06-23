// @dart=2.10
import 'package:app/views/screens/scr_home/appointment_schedule_src.dart';
import 'package:app/views/screens/scr_home/tracking_calendar_src.dart';
import 'package:app/views/screens/scr_home/work_time_monitor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Worked Hours",
      subtitle: "Details",
      event: "",
      img: "assets/icon_work_hrs.png");

  Items item2 = new Items(
    title: "Schedules",
    subtitle: "View Schedules",
    event: "",
    img: "assets/icon_appointment.png",
  );
  Items item3 = new Items(
    title: "Timer History",
    subtitle: "Preview Timer Data",
    event: "",
    img: "assets/icon_timer_history.png",
  );
  Items item4 = new Items(
    title: "Products",
    subtitle: "Available Products",
    event: "",
    img: "assets/icon_product.png",
  );
  Items item5 = new Items(
    title: "Category",
    subtitle: "Details",
    event: "4 Items",
    img: "assets/woms_logo.png",
  );
  Items item6 = new Items(
    title: "More",
    subtitle: "",
    event: "2 Items",
    img: "assets/woms_logo.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            var index = myList.indexOf(data);
            return GestureDetector(
              onTap: () {
                print("object ${index}");
                oncaCategiryClick(index, context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.pink.shade900,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.red.shade400,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.event,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }

  void oncaCategiryClick(int catIndex, BuildContext context) {
    switch (catIndex) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MonitorWokedHours()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AppointmentSchedule()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CalendarPageTracking()));
        break;
    }
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}
