import 'package:app/model/model_profille.dart';
import 'package:app/services/ser_get_profile.dart';
import 'package:app/views/screens/scr_profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileModel? data;
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var value = await ProfileService()
        .profileService(sharedPreferences.getString("emailKey"));
    setState(() {
      data = value;
    });
    print(sharedPreferences.getString("emailKey"));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: data == null
          ? Container(
              child: Center(
                child: LoadingBouncingGrid.circle(
                    backgroundColor: Colors.pink.shade200,
                    duration: Duration(milliseconds: 500)),
              ),
            )
          : ProfileApp(profileData: data),
    );
  }
}
