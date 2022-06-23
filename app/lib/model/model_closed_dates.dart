// @dart=2.10
class ClosedDatesModel {
  final String date_start;
  final String date_end;
  final String description;
  ClosedDatesModel({
    this.date_start,
    this.date_end,
    this.description,
  });

  factory ClosedDatesModel.fromJson(Map<String, dynamic> json) {
    return ClosedDatesModel(
      date_start: json['date_start'],
      date_end: json['date_end'],
      description: json['description'],
    );
  }
}
