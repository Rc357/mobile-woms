// @dart=2.10
class TimeSchedule {
  final String startTime;
  final String endTime;
  TimeSchedule({this.startTime, this.endTime});

  factory TimeSchedule.fromJson(Map<String, dynamic> json) {
    return TimeSchedule(
        startTime: json['time_start'], endTime: json['time_end']);
  }
}
