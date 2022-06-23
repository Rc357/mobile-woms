// @dart=2.10
class OderName {
  final String id;
  final String name;
  OderName({
    this.id,
    this.name,
  });

  factory OderName.fromJson(Map<String, dynamic> json) {
    return OderName(
      id: json['id'],
      name: json['name'],
    );
  }
}
