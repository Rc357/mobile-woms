import 'package:app/services/ser_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool isLogout = false;
  @override
  void initState() {
    super.initState();
  }

  Future logoutUser(String? uname, String? tokenKey) async {
    var timeOut = DateTime.now();
    isLogout =
        await UserService().logoutService(uname, timeOut.toString(), tokenKey);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("More Page"),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // loginUser();
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove("emailKey");
                  sharedPreferences.remove("tokenKey");
                  Navigator.pushNamed(context, "/signin");
                },
                child: Text("LOGOUT"),
              ),
            )
          ],
        )),
      ),
    );
  }
}
