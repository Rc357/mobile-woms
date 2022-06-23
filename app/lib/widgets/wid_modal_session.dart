import 'package:app/widgets/wid_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertEndSession extends StatelessWidget {
  final String? clientName;
  final String? estheticiansName;
  final String? serviceType;
  final String? from;
  final String? to;
  final String? howLong;
  final DateTime? getDate;

  const AlertEndSession(
      {Key? key,
      this.clientName,
      this.estheticiansName,
      this.serviceType,
      this.from,
      this.to,
      this.howLong,
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
          CustomButton(
            text: "OKAY",
            fontSize: 16,
            height: 35,
            width: 150,
            onClick: () {
              print("object");
              Navigator.pushReplacementNamed(context, "/main");
            },
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
