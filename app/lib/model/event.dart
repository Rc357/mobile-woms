import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Event {
  String id;
  String title;
  String description;
  String clientName;
  String from;
  String to;
  String orderId;
  Color backgroundColor;
  bool isAllDay;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.clientName,
    required this.from,
    required this.to,
    required this.orderId,
    this.backgroundColor = Colors.limeAccent,
    this.isAllDay = false,
  });
}
