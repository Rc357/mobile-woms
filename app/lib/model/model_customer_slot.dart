// @dart=2.10
//     final slotTimeModel = slotTimeModelFromJson(jsonString);

import 'dart:convert';

SlotTimeModel slotTimeModelFromJson(String str) =>
    SlotTimeModel.fromJson(json.decode(str));

String slotTimeModelToJson(SlotTimeModel data) => json.encode(data.toJson());

class SlotTimeModel {
  SlotTimeModel({
    this.data,
    this.employeeCount,
  });

  List<Datum> data;
  int employeeCount;

  factory SlotTimeModel.fromJson(Map<String, dynamic> json) => SlotTimeModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        employeeCount: json["employee_count"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "employee_count": employeeCount,
      };
}

class Datum {
  Datum({
    this.from,
    this.to,
    this.timestamp,
  });

  String from;
  String to;
  String timestamp;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        from: json["from"],
        to: json["to"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "timestamp": timestamp,
      };
}
