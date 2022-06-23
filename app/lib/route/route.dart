import 'package:app/views/main_customer_page.dart';
import 'package:app/views/main_page.dart';
import 'package:app/views/pages/home_page.dart';
import 'package:app/views/login_page.dart';
import 'package:app/views/screens/scr_calendar/tracking_events/calendar_add_event.dart';
import 'package:app/views/screens/scr_home/timer_scr.dart';
import 'package:app/views/splash.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // CustomButtonTheme customTheme = CustomButtonTheme.DARK;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Splash());
      case '/addevent':
        return MaterialPageRoute(builder: (context) => EventEditingScreen());
      case '/timer':
        return MaterialPageRoute(
            builder: (context) => TimerScreen(
                  serviceType: "",
                  clientName: "",
                  estheticians: "",
                  fromDate: DateTime.now(),
                  startDateTime: DateTime.now(),
                ));
      case '/signin':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/main':
        return MaterialPageRoute(builder: (context) => MainPage());
      case '/main_customer':
        return MaterialPageRoute(builder: (context) => MainCustomerPage());

      default:
        return _errorRoute();
    }
  }

  /*Error Route */
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Error"),
          ),
          body: Center(
            child: Text("ERROR"),
          ),
        );
      },
    );
  }
}
