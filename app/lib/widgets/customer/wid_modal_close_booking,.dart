import 'package:app/views/main_customer_page.dart';
import 'package:app/widgets/wid_button.dart';
import 'package:flutter/material.dart';

class AlertCancelBooking extends StatelessWidget {
  const AlertCancelBooking();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Cancel booking?',
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
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "The data you've selected will be lost!",
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
          CustomButton3(
            text: "Close",
            fontSize: 16,
            height: 35,
            width: 150,
            onClick: () {
              print("object");
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MainCustomerPage()));
            },
          ),
          CustomButton(
            text: "Cancel",
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
