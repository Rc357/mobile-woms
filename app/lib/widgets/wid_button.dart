import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CustomButton extends StatefulWidget {
  final String? text;
  final double? width;
  final double? height;
  final double? fontSize;
  final Function? onClick;
  CustomButton(
      {this.text, this.width, this.height, this.onClick, this.fontSize});
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        height: widget.height,
        width: widget.width,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.pink.shade700),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xFFBE1522))))),
          onPressed: () {
            widget.onClick!();
          },
          child: Text(
            '${widget.text}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'roboto'),
          ),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatefulWidget {
  final String? text;
  final double? width;
  final double? height;
  final double? fontSize;
  final Function? onClick;
  CustomButton2(
      {this.text, this.width, this.height, this.onClick, this.fontSize});
  @override
  _CustomButtonState2 createState() => _CustomButtonState2();
}

class _CustomButtonState2 extends State<CustomButton2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        height: widget.height,
        width: widget.width,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black)))),
          onPressed: () {
            widget.onClick!();
          },
          child: Text(
            '${widget.text}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'roboto'),
          ),
        ),
      ),
    );
  }
}

class CustomButton3 extends StatefulWidget {
  final String? text;
  final double? width;
  final double? height;
  final double? fontSize;
  final Function? onClick;
  CustomButton3(
      {this.text, this.width, this.height, this.onClick, this.fontSize});
  @override
  _CustomButtonState3 createState() => _CustomButtonState3();
}

class _CustomButtonState3 extends State<CustomButton3> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        height: widget.height,
        width: widget.width,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black)))),
          onPressed: () {
            widget.onClick!();
          },
          child: Text(
            '${widget.text}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'roboto'),
          ),
        ),
      ),
    );
  }
}
