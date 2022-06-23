import 'package:app/constants/constants.dart';
import 'package:app/model/model_get_worked_hrs.dart';
import 'package:app/model/model_profille.dart';
import 'package:app/services/ser_get_app.dart';
import 'package:app/services/ser_get_profile.dart';
import 'package:app/services/ser_get_worked_hours.dart';
import 'package:app/services/ser_login.dart';
import 'package:app/services/ser_update_time.dart';
import 'package:app/views/screens/scr_home/scr_dashboard.dart';
import 'package:app/widgets/wid_button_timer.dart';
import 'package:app/widgets/wid_modal_no_schedule.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProfileModel? data;
  bool hasSchedule = false;
  bool isLogout = false;
  bool isAlreadyTimeIn = false;
  List<GetWorkedHoursModel> retData = [];

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var value = await ProfileService()
        .profileService(sharedPreferences.getString("emailKey"));
    setState(() {
      data = value;
      Constants.USER_ID = int.parse(data!.id);
      Constants.USER_NAME = "${data!.firstName} ${data!.lastName}";
    });

    //getDoneSession
    retData = await GetWorkedHours.getWorkedHours();
    print("object sssss");
    var dateNow = DateTime.now();
    var dateTime = DateTime.parse(retData[0].workIn);
    var formate2 = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    var formate = "${dateNow.year}-${dateNow.month}-${dateNow.day}";
    print(formate2);
    print(formate);

    if (formate2.contains(formate)) {
      setState(() {
        isAlreadyTimeIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data == null
                              ? ""
                              : "${data!.firstName} ${data!.lastName} ",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          data == null ? "" : "${data!.email}",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.pink.shade900,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    Constants.isTimeIn
                        ? ButtonWidgetSignIn(
                            text: 'Time Out',
                            color: Colors.white,
                            backgroundColor: Colors.orange.shade900,
                            onClicked: () async {
                              final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              await UpdateTimeInAndOut.updateTimeInOut(
                                  "timeOut",
                                  sharedPreferences.getString("tokenKey"));

                              await logoutUser(
                                  sharedPreferences.getString("emailKey"),
                                  sharedPreferences.getString("tokenKey"));
                              setState(() {
                                Constants.isTimeIn = false;
                              });
                            },
                          )
                        : ButtonWidgetSignIn(
                            text: 'Time In',
                            color: Colors.white,
                            backgroundColor: Colors.green.shade500,
                            onClicked: () async {
                              final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              checkIfHasSchedule();
                              if (!isAlreadyTimeIn) {
                                if (hasSchedule) {
                                  setState(() {
                                    Constants.isTimeIn = true;
                                  });
                                  print("object Okayxxx");
                                  await UpdateTimeInAndOut.updateTimeInOut(
                                      "timeIn",
                                      sharedPreferences.getString("tokenKey"));
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlreadyTimeIn();
                                  },
                                );
                              }
                            },
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GridDashboard()
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: Colors.pink.shade200,
        //     child: Icon(
        //       Icons.add,
        //       color: Colors.white,
        //     ),
        //     onPressed: () async {
        //       var events = await ServicesGetAppointment().getAppointmentSched();
        //       final df = new DateFormat('yyyy-MM-dd');
        //       final now = new DateTime.now();
        //       final dates = df.format(now);
        //       print(dates);
        //     }
        //     // => Navigator.of(context).push(
        //     //     MaterialPageRoute(builder: (context) => EventEditingScreen()))

        //     ),
      ),
    );
  }

  Future logoutUser(String? uname, String? tokenKey) async {
    var timeOut = DateTime.now();
    isLogout =
        await UserService().logoutService(uname, timeOut.toString(), tokenKey);
  }

  Future<void> checkIfHasSchedule() async {
    DateTime date = DateTime.now();
    String day = DateFormat('EEEE').format(date);
    print("object day");
    var value = await ProfileService().checkUserExist("${data!.email}");
    setState(() {
      Constants.USER_ID = int.parse(value.id);
    });
    var events = await ServicesGetAppointment().getAppointmentSched();

    for (int i = 0; i < events.length; i++) {
      events[i].dayOfWeek;
      // print("KOKOKOK");
      // print(day.toLowerCase());
      // print(events[i].dayOfWeek.toString());
      if (day.toLowerCase().contains(events[i].dayOfWeek.toString())) {
        // print("KOKOasasasKOK");
        setState(() {
          hasSchedule = true;
        });
        break;
      }
    }
    if (!hasSchedule) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertNoSchedule();
        },
      );
    }
  }
}
