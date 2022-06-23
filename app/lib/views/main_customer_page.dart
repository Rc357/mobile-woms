import 'package:app/constants/constants.dart';
import 'package:app/model/event.dart';
import 'package:app/model/model_customer.dart';
import 'package:app/model/model_profille.dart';
import 'package:app/services/ser_get_admins_sessions.dart';
import 'package:app/services/ser_get_app_pos.dart';
import 'package:app/services/ser_get_customer_data.dart';
import 'package:app/services/ser_get_profile.dart';
import 'package:app/views/hamburger/hamburger_page.dart';
import 'package:app/views/pages/calendar_page.dart';
import 'package:app/views/screens/scr_calendar/calendar_sched/calendar_customer.dart';
import 'package:app/views/screens/scr_calendar/calendar_sched/customer/customer_calendar.dart';
import 'package:app/views/screens/scr_home/tracking_calendar_src.dart';
import 'package:app/views/pages/home_page.dart';
import 'package:app/views/pages/profile_page.dart';
import 'package:app/views/pages/more_page.dart';
import 'package:app/views/screens/scr_profile/profile_screen.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainCustomerPage extends StatefulWidget {
  @override
  _MainCustomerPageState createState() => _MainCustomerPageState();
}

class _MainCustomerPageState extends State<MainCustomerPage> {
  int pageIndex = 0;
  ProfileModel? data;
  CustomerModel? cusData;
  final screens = [
    CustomerCalendar(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();

    final cron = Cron()
      ..schedule(Schedule.parse('*/6 * * * * *'), () {
        // ..schedule(Schedule.parse('10 * * * * *'), () {
        checkSession();
        print("object");
        getProfile();
      });
    Constants().cron = cron;
  }

  void getProfile() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var value = await ProfileService()
        .profileService(sharedPreferences.getString("emailKey"));
    var cusValue = await GetCustomerData()
        .getCustomerDataByEmail(sharedPreferences.getString("emailKey"));
    setState(() {
      cusData = cusValue;
      data = value;
      Constants.CUS_ID = int.parse(cusData!.id);
      Constants.USER_ID = int.parse(data!.id);
      Constants.USER_NAME = "${data!.firstName} ${data!.lastName}";
    });
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink.shade50,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFCD5E77),
        currentIndex: pageIndex,
        onTap: (index) => setState(() => pageIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
