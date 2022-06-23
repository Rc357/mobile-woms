// @dart=2.10
class CustomerModel {
  final String id;
  final String first_name;
  final String last_name;
  final String gender;
  final String date_of_birth;
  final String email;
  final String phone;
  CustomerModel({
    this.id,
    this.first_name,
    this.last_name,
    this.gender,
    this.date_of_birth,
    this.email,
    this.phone,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      gender: json['gender'],
      date_of_birth: json['date_of_birth'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
