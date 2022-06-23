import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;
  final Color backgroundColor;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onClicked,
      required this.color,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        primary: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      ),
      onPressed: onClicked,
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: color),
      ));
}

class ButtonWidgetSignIn extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;
  final Color backgroundColor;

  const ButtonWidgetSignIn(
      {Key? key,
      required this.text,
      required this.onClicked,
      required this.color,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        primary: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      onPressed: onClicked,
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: color),
      ));
}

class ButtonWidgetLogOut extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;
  final Color backgroundColor;

  const ButtonWidgetLogOut(
      {Key? key,
      required this.text,
      required this.onClicked,
      required this.color,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        primary: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      onPressed: onClicked,
      child: Container(
        width: 70,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ),
      ));
}
