import 'package:app/constants/constants.dart';
import 'package:app/model/model_end_multiple_book.dart';
import 'package:app/views/screens/scr_home/calendar_timer.dart';
import 'package:app/widgets/wid_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AlertEndSessionMultiBook extends StatelessWidget {
  final String? clientName;
  final String? estheticiansName;
  final String? serviceType;
  final String? from;
  final String? to;
  final String? howLong;
  final DateTime? getDate;
  final List<Appointment> appointmentDetails;
  final eventData;
  final listData;
  final String? estheticians;
  final DateTime? fromDate;
  final DateTime? startDateTime;

  const AlertEndSessionMultiBook(
      {Key? key,
      this.clientName,
      this.estheticiansName,
      this.serviceType,
      this.from,
      this.to,
      this.howLong,
      required this.appointmentDetails,
      this.eventData,
      this.listData,
      this.estheticians,
      this.fromDate,
      this.startDateTime,
      this.getDate})
      : super(key: key);

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
              'SESSION ENDED',
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
              '${serviceType} took ${howLong} to complete. \nStarted at : ${from}\nEnded at: ${to}\n\nEstheticians : ${estheticiansName} \nClient Name: ${clientName}\n\nThe informations above will be recorded.',
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
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Do you want to continue for the next session?',
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
                text: "CONTINUE",
                fontSize: 16,
                height: 35,
                width: 150,
                onClick: () {
                  addToModelList();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalendarTimerScreen(
                              appointmentDetails: appointmentDetails,
                              listData: listData,
                              eventData: eventData,
                              estheticians: "${estheticians}",
                              fromDate: DateTime.now(),
                              startDateTime: DateTime.now())));
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

  void addToModelList() {
    Constants.lMultipleModal.add(MultipleBookEndSessionData(
      ServiceType: serviceType,
      clientName: clientName,
      estheticiansName: estheticiansName,
      getDate: getDate,
      from: from,
      to: to,
      howLong: howLong,
      estheticians: estheticians,
      fromDate: fromDate,
      startDateTime: startDateTime,
    ));
  }
}
