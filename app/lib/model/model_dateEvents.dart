// @dart=2.10
class DateAndEvents {
  final String id;
  final String eventTitle;
  final String eventDescription;
  final String eventClientName;
  final String eventEstheticians;
  final String evenDateID;
  final String eventStartTime;
  final String eventEndTime;
  DateAndEvents({
    this.id,
    this.eventTitle,
    this.eventDescription,
    this.eventClientName,
    this.eventEstheticians,
    this.evenDateID,
    this.eventStartTime,
    this.eventEndTime,
  });

  factory DateAndEvents.fromJson(Map<String, dynamic> json) {
    return DateAndEvents(
      id: json['id'],
      eventTitle: json['eventTitle'],
      eventDescription: json['eventDescription'],
      eventClientName: json['eventClientName'],
      eventEstheticians: json['eventEstheticians'],
      evenDateID: json['evenDateID'],
      eventStartTime: json['eventStartTime'],
      eventEndTime: json['eventEndTime'],
    );
  }
}
