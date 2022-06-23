import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String toDateTime(DateTime dataTime) {
    final date = DateFormat.yMMMEd().format(dataTime);
    final time = DateFormat.Hm().format(dataTime);
    return '$date $time';
  }

  static String toDate(DateTime dataTime) {
    final date = DateFormat.yMMMEd().format(dataTime);
    return date;
  }

  static String toTime(DateTime dataTime) {
    final time = DateFormat.Hm().format(dataTime);
    return time;
  }
}
