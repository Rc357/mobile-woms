import 'package:flutter/material.dart';

class BuildDateDisplay {
  Widget buildDate(BuildContext context, String date) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: size.height * .06,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xFFF0D3DA),
                Color(0xFFF0CAD4),
                Color(0xFFF1C2CC),
                Color(0xFFF1BCC5),
                Color(0xFFF2B4BE),
                Color(0xFFF2ADB7),
              ],
            ),
            border: Border.all(color: Color(0XFFF09FAD), width: 5),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "$date",
            style: TextStyle(
                fontSize: size.height * .03,
                color: Colors.pink.shade900,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
