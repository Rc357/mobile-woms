import 'package:app/views/screens/scr_home/calendar_timer.dart';
import 'package:app/widgets/wid_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AlertCheckIn extends StatelessWidget {
  final List<Appointment> appointmentDetails;
  final eventData;
  final listData;
  final String estheticians;
  final DateTime fromDate;
  final DateTime startDateTime;
  const AlertCheckIn({
    Key? key,
    this.eventData,
    this.listData,
    required this.estheticians,
    required this.appointmentDetails,
    required this.fromDate,
    required this.startDateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Image.asset('assets/temp_profile.png'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'DO YOU WANT TO CHECKIN?',
              style: TextStyle(
                fontFamily: 'roboto',
                color: Colors.pink.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Please check-in this appointment first on the admin POS.',
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              CustomButton(
                text: "OKAY",
                fontSize: 16,
                height: 35,
                width: 150,
                onClick: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => CalendarTimerScreen(
                  //             appointmentDetails: appointmentDetails,
                  //             listData: listData,
                  //             eventData: eventData,
                  //             estheticians: estheticians,
                  //             fromDate: fromDate,
                  //             startDateTime: startDateTime)));
                },
              ),
              // CustomButton2(
              //   text: "Cancel",
              //   fontSize: 16,
              //   height: 35,
              //   width: 150,
              //   onClick: () {
              //     print("object");
              //     Navigator.pushReplacementNamed(context, "/main");
              //   },
              // ),
            ],
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
