import 'package:app/constants/constants.dart';
import 'package:app/widgets/wid_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlertEndSessionMulti extends StatefulWidget {
  final String? clientName;
  final String? estheticiansName;

  const AlertEndSessionMulti({Key? key, this.clientName, this.estheticiansName})
      : super(key: key);

  @override
  _AlertEndSessionMultiState createState() => _AlertEndSessionMultiState();
}

class _AlertEndSessionMultiState extends State<AlertEndSessionMulti> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Image.asset('assets/temp_profile.png'),
      content: SingleChildScrollView(
        child: Column(
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
              child: Column(
                children: [
                  Column(
                    children: [
                      for (var i in Constants.lMultipleModal)
                        Text(
                          '${i.ServiceType} took ${i.howLong} to complete. \nStarted at : ${i.from}\nEnded at: ${i.to}\n',
                          style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                  Text(
                    '\nEstheticians : ${widget.estheticiansName} \nClient Name: ${widget.clientName}\n\nThe informations above will be recorded.',
                    style: TextStyle(
                      fontFamily: 'roboto',
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
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
                setState(() {
                  Constants.lMultipleModal = [];
                });
              },
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
