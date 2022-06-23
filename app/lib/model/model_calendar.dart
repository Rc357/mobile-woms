// @dart=2.10
class DateAndEventsSched {
  final String id;
  final String adminId;
  final String dateStart;
  final String dateEnd;
  final String repeat;
  final String dayOfWeek;
  final String scheduleShifts;
  final String createdAt;
  final String updatedAt;
  final String removedDates;
  final String onlyDates;
  final String priority;
  DateAndEventsSched({
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

  factory DateAndEventsSched.fromJson(Map<String, dynamic> json) {
    return DateAndEventsSched(
      id: json['id'],
      adminId: json['admin_id'],
      dateStart: json['date_start'],
      dateEnd: json['date_end'],
      repeat: json['repeat'],
      dayOfWeek: json['day_of_week'],
      scheduleShifts: json['schedule_shifts'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      removedDates: json['removed_dates'],
      onlyDates: json['only_dates'],
      priority: json['priority'],
    );
  }
}
