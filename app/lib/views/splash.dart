// @dart=2.10
import 'dart:async';

import 'package:app/constants/constants.dart';
import 'package:app/views/login_page.dart';
import 'package:app/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

String sessionEmail;

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    getValidateData();
    super.initState();
  }

  Future getValidateData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var obtainData = sharedPreferences.getString("emailKey");
    setState(() {
      sessionEmail = obtainData;
    });
    print(sessionEmail);
    await Future.delayed(Duration(seconds: 2));
    if (sessionEmail == null) {
      Navigator.pushNamed(context, '/signin');
    } else {
      Navigator.pushNamed(context, '/main_customer');
      // if (Constants.isCustomer) {
      //   Navigator.pushNamed(context, '/main_customer');
      // } else {
      //   Navigator.pushNamed(context, '/main');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * .3,
          ),
          Image.asset(
            'assets/woms_logo.png',
            semanticLabel: 'WOMS Logo',
            height: 200,
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Center(
              child: LoadingBouncingGrid.circle(
                  backgroundColor: Colors.pink.shade200,
                  duration: Duration(milliseconds: 1000)),
            ),
          )
        ],
      ),
    );
  }
}
