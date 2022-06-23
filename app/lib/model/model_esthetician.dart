// @dart=2.10
//     final estheticianModel = estheticianModelFromJson(jsonString);

import 'dart:convert';

EstheticianModel estheticianModelFromJson(String str) =>
    EstheticianModel.fromJson(json.decode(str));

String estheticianModelToJson(EstheticianModel data) =>
    json.encode(data.toJson());

class EstheticianModel {
  EstheticianModel({
    this.id,
    this.name,
    this.role,
    this.terminationDate,
    this.schedules,
  });

  int id;
  String name;
  String role;
  String terminationDate;
  List<Schedule> schedules;

  factory EstheticianModel.fromJson(Map<String, dynamic> json) =>
      EstheticianModel(
        id: json["id"],
        name: json["name"],
        role: json["role"],
        terminationDate: json["termination_date"],
        schedules: List<Schedule>.from(
            json["schedules"].map((x) => Schedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
        "termination_date": terminationDate,
        "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
      };
}

class Schedule {
  Schedule({
    this.id,
    this.adminId,
    this.dateStart,
    this.dateEnd,
    this.repeat,
    this.dayOfWeek,
    this.scheduleShifts,
    this.createdAt,
    this.updatedAt,
    this.removedDates,
    this.onlyDates,
    this.priority,
  });

  int id;
  int adminId;
  DateTime dateStart;
  dynamic dateEnd;
  String repeat;
  String dayOfWeek;
  List<ScheduleShift> scheduleShifts;
  DateTime createdAt;
  DateTime updatedAt;
  String removedDates;
  dynamic onlyDates;
  int priority;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        adminId: json["admin_id"],
        dateStart: DateTime.parse(json["date_start"]),
        dateEnd: json["date_end"],
        repeat: json["repeat"],
        dayOfWeek: json["day_of_week"],
        scheduleShifts: List<ScheduleShift>.from(
            json["schedule_shifts"].map((x) => ScheduleShift.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        removedDates: json["removed_dates"],
        onlyDates: json["only_dates"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin_id": adminId,
        "date_start": dateStart.toIso8601String(),
        "date_end": dateEnd,
        "repeat": repeat,
        "day_of_week": dayOfWeek,
        "schedule_shifts":
            List<dynamic>.from(scheduleShifts.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "removed_dates": removedDates,
        "only_dates": onlyDates,
        "priority": priority,
      };
}

class ScheduleShift {
  ScheduleShift({
    this.timeStart,
    this.timeEnd,
  });

  String timeStart;
  String timeEnd;

  factory ScheduleShift.fromJson(Map<String, dynamic> json) => ScheduleShift(
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
      );

  Map<String, dynamic> toJson() => {
        "time_start": timeStart,
        "time_end": timeEnd,
      };
}
