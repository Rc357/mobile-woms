import 'dart:ui';

import 'package:app/model/event.dart';
import 'package:app/model/model_date_event_pos.dart';
import 'package:app/model/model_end_multiple_book.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';

class Constants {
  static const String API_HOST = 'http://192.168.100.43/';

  static const String API_WEB_HOST = 'http://10.0.2.2:8000/';

  static const COLOR_PRIMARY = Color(0xFFCD5E77);

  var cron = Cron();

  //Global Variables
  static int USER_ID = 0;
  static int CUS_ID = 0;
  static String USER_NAME = "";
  static List<Event> eventsInCal = [];
  static List<MultipleBookEndSessionData> lMultipleModal = [];
  static var lData = [];
  static bool addBookOnce = true;
  static bool isTimeIn = false;
  static bool isCustomer = false;
}
