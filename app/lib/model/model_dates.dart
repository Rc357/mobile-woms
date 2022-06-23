// @dart=2.10
class ListOfDate {
  final String startTime;
  final String endTime;
  ListOfDate({
    this.startTime,
    this.endTime,
  });

  factory ListOfDate.fromJson(Map<String, dynamic> json) {
    return ListOfDate(
      startTime: json['time_start'],
      endTime: json['time_end'],
    );
  }
}
