import 'package:app/constants/constants.dart';
import 'package:app/model/event.dart';
import 'package:app/services/ser_get_admins_sessions.dart';
import 'package:app/services/ser_get_app_pos.dart';
import 'package:app/services/ser_get_customer_data.dart';
import 'package:app/views/hamburger/hamburger_page.dart';
import 'package:app/views/pages/calendar_page.dart';
import 'package:app/views/screens/scr_home/tracking_calendar_src.dart';
import 'package:app/views/pages/home_page.dart';
import 'package:app/views/pages/profile_page.dart';
import 'package:app/views/pages/more_page.dart';
import 'package:app/views/screens/scr_profile/profile_screen.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  final screens = [
    HomePage(),
    CalendarPage(),
    ProfilePage(),
    // SchedulePage(),
  ];

  @override
  void initState() {
    super.initState();

    final cron = Cron()
      ..schedule(Schedule.parse('*/6 * * * * *'), () {
        // ..schedule(Schedule.parse('10 * * * * *'), () {
        checkSession();
        print("object");
      });
    Constants().cron = cron;
  }

  checkSession() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var timeOut = DateTime.now();
    bool ret = await CheckTimeSesssion().checkTimeSesssion(
        "CHECK_TIME",
        sharedPreferences.getString("emailKey"),
        sharedPreferences.getString("tokenKey"),
        timeOut.toString());
    print(ret);
    if (ret) {
      setState(() {
        Constants.isTimeIn = false;
      });
      sharedPreferences.remove("emailKey");
      sharedPreferences.remove("tokenKey");
      await Constants().cron.close();
      Navigator.pushNamed(context, "/signin");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      // drawer: Drawer(
      //   child: HamburgerContents(),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink.shade50,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFCD5E77),
        currentIndex: pageIndex,
        onTap: (index) => setState(() => pageIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.more_horiz),
          //   label: "More",
          // ),
        ],
      ),
    );
  }
}
