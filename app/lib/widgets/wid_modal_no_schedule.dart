import 'package:app/widgets/wid_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertNoSchedule extends StatelessWidget {
  const AlertNoSchedule();

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
              'No schedule Today!',
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
              'You cannot login because you have no schedule today.',
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}

class AlreadyTimeIn extends StatelessWidget {
  const AlreadyTimeIn();

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
              'Done Session for Today!',
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
              'Your time-in and time-out for today is already exist.',
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
