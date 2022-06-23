// @dart=2.10
import "package:equatable/equatable.dart";

class ServicesByBranch extends Equatable {
  final ServicesByBranchData rData;
  ServicesByBranch({
    this.rData,
  });

  factory ServicesByBranch.fromJson(List<dynamic> json) {
    return ServicesByBranch(
      rData: ServicesByBranchData.fromJson(json[0]),
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [rData];
}

class ServicesByBranchData {
  final List<DataReturn> rData;
  ServicesByBranchData(
    this.rData,
  );

  factory ServicesByBranchData.fromJson(Map<String, dynamic> json) {
    var tagObjsJson = json['data'] as List;
    List<DataReturn> dataReturn =
        tagObjsJson.map((tagJson) => DataReturn.fromJson(tagJson)).toList();
    return ServicesByBranchData(dataReturn);
  }
}

class DataReturn {
  final String code;
  final String label;
  final String type;
  final String duration;
  final String membership_id;
  final String membership_status;
  DataReturn({
    this.code,
    this.label,
    this.type,
    this.duration,
    this.membership_id,
    this.membership_status,
  });

  factory DataReturn.fromJson(Map<String, dynamic> json) {
    return DataReturn(
      code: json['code'],
      label: json['label'],
      type: json['type'],
      duration: json['duration'],
      membership_id: json['membership_id'],
      membership_status: json['membership_status'],
    );
  }
}
