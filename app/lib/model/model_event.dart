import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DateAndEvent {
  final String date;
  final EventModel eventModel;
  DateAndEvent({
    required this.date,
    required this.eventModel,
  });

  factory DateAndEvent.fromJson(Map<String, dynamic> json) {
    return DateAndEvent(
        date: json["date"], eventModel: EventModel.fromJson(json));
  }
}

class EventModel {
  int? eventId;
  String? title;
  String? description;
  String? clientName;
  DateTime? from;
  DateTime? to;

  EventModel({
    this.eventId,
    this.title,
    this.description,
    this.clientName,
    this.from,
    this.to,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    eventId = json["eventID"];
    title = json["title"];
    description = json["description"];
    clientName = json["clientName"];
    from = json["from"];
    to = json["to"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventID'] = this.eventId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['clientName'] = this.clientName;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
