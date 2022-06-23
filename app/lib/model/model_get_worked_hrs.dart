// @dart=2.10
class GetWorkedHoursModel {
  final String id;
  final String adminId;
  final String workIn;
  final String workOut;
  final String workTime;
  GetWorkedHoursModel({
    this.id,
    this.adminId,
    this.workIn,
    this.workOut,
    this.workTime,
  });

  factory GetWorkedHoursModel.fromJson(Map<String, dynamic> json) {
    return GetWorkedHoursModel(
      id: json['id'],
      adminId: json['admins_id'],
      workIn: json['work_in'],
      workOut: json['work_out'],
      workTime: json['work_time'],
    );
  }
}
