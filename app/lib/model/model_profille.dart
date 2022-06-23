// @dart=2.10
class ProfileModel {
  final String id;
  final String name;
  final String firstName;
  final String midName;
  final String lastName;
  final String nickName;
  final String uName;
  final String gender;
  final String bDay;
  final String pPhone;
  final String wPhone;
  final String pEmail;
  final String wEmail;
  final String email;
  final String profileImage;
  ProfileModel({
    this.id,
    this.name,
    this.firstName,
    this.midName,
    this.lastName,
    this.nickName,
    this.uName,
    this.gender,
    this.bDay,
    this.pPhone,
    this.wPhone,
    this.pEmail,
    this.wEmail,
    this.email,
    this.profileImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      firstName: json['first_name'],
      midName: json['middle_name'],
      lastName: json['last_name'],
      nickName: json['nick_name'],
      uName: json['uname'],
      gender: json['gender'],
      bDay: json['date_of_birth'],
      pPhone: json['personal_phone_number'],
      wPhone: json['work_phone_number'],
      pEmail: json['personal_email'],
      wEmail: json['work_email'],
      email: json['email'],
      profileImage: json['profile_image'],
    );
  }
}
