import 'package:app/widgets/wid_button.dart';
import 'package:flutter/material.dart';

class AlertExitTimer extends StatelessWidget {
  const AlertExitTimer();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Warning!',
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
              'Are you sure you want to exit?',
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
              'Timer will reset if you close this screen.',
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
                text: "Yes, EXIT",
                fontSize: 16,
                height: 35,
                width: 150,
                onClick: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              CustomButton2(
                text: "Cancel",
                fontSize: 16,
                height: 35,
                width: 150,
                onClick: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
