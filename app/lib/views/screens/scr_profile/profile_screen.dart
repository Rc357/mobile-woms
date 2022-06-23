import 'dart:io';
import 'dart:typed_data';
import 'package:app/constants/constants.dart';
import 'package:app/model/model_profille.dart';
import 'package:app/services/ser_add_or_update_profile_image.dart';
import 'package:app/services/ser_get_profile.dart';
import 'package:app/widgets/wid_button_timer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApp extends StatefulWidget {
  final String? email;
  final String? pEmail;
  final String? nName;
  final String? gender;
  final String? phoneP;
  final String? phoneW;
  final ProfileModel? profileData;

  const ProfileApp({
    Key? key,
    this.email = "",
    this.pEmail = "",
    this.nName = "",
    this.gender = "",
    this.phoneP = "",
    this.phoneW = "",
    this.profileData,
  }) : super(key: key);

  @override
  _ProfileAppState createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  final ImagePicker _picker = ImagePicker();

  File? _image;
  String? _imageName;
  PickedFile? _imageFile;
  Uint8List? _imageBytes;
  var _fileImage;
  String profileURL = "";
  bool complete = false;
  String _userId = Constants.USER_ID.toString();
  String _profileImageURL = "";

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white70,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFCD5E77), Colors.pink.shade200])),
                child: Container(
                  width: double.infinity,
                  height: 320.0,
                  child: Column(children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(children: <Widget>[
                          Semantics(
                            child: CircleAvatar(
                              backgroundImage: _fileImage != null
                                  ? _fileImage
                                  : widget.profileData?.profileImage != null
                                      ? NetworkImage(
                                          widget.profileData!.profileImage)
                                      : AssetImage(
                                          "assets/default_profile.png",
                                        ),
                              radius: 80,
                              backgroundColor: Colors.white,
                            ),
                            label: 'Add Profile Photo',
                          ),
                          Positioned(
                            bottom: 25,
                            right: 20,
                            child: Container(
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 1, color: Colors.white)),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => bottomSheet()),
                                  );
                                },
                                child: Icon(
                                  Icons.add_circle,
                                  semanticLabel: 'Add Profile Photo',
                                  size: 35,
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          Constants.USER_NAME,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        Container(
                          // width: 350,
                          // color: Colors.red,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 0, top: 0),
                                child: ButtonWidgetLogOut(
                                  text: 'Log Out',
                                  color: Colors.white,
                                  backgroundColor: Colors.orange.shade900,
                                  onClicked: () async {
                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.remove("emailKey");
                                    sharedPreferences.remove("tokenKey");
                                    Navigator.pushNamed(context, "/signin");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Card(
                        //   shape: RoundedRectangleBorder(
                        //     side: BorderSide(color: Colors.white70, width: 1),
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   margin: EdgeInsets.symmetric(
                        //       horizontal: 20.0, vertical: 5.0),
                        //   clipBehavior: Clip.antiAlias,
                        //   color: Colors.white,
                        //   elevation: 5.0,
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 8.0, vertical: 22.0),
                        //     child: Row(
                        //       children: <Widget>[
                        //         Expanded(
                        //           child: Column(
                        //             children: <Widget>[
                        //               Text(
                        //                 "No. Services",
                        //                 style: TextStyle(
                        //                   color: Colors.pink.shade900,
                        //                   fontSize: 18.0,
                        //                   fontWeight: FontWeight.bold,
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 height: 5.0,
                        //               ),
                        //               Text(
                        //                 "12",
                        //                 style: TextStyle(
                        //                   fontSize: 20.0,
                        //                   color: Colors.pinkAccent,
                        //                 ),
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //         Expanded(
                        //           child: Column(
                        //             children: <Widget>[
                        //               Text(
                        //                 "Total Reviews",
                        //                 style: TextStyle(
                        //                   color: Colors.pink.shade900,
                        //                   fontSize: 18.0,
                        //                   fontWeight: FontWeight.bold,
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 height: 5.0,
                        //               ),
                        //               Text(
                        //                 "12",
                        //                 style: TextStyle(
                        //                   fontSize: 20.0,
                        //                   color: Colors.pinkAccent,
                        //                 ),
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ]),
                )),
            Container(
              // color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildInfoHolder("Email", "${widget.profileData!.email}"),
                    Divider(height: 1),
                    buildInfoHolder(
                        "Personal Email", "${widget.profileData!.pEmail}"),
                    Divider(height: 1),
                    buildInfoHolder(
                        "Nick Name", "${widget.profileData!.nickName}"),
                    Divider(height: 1),
                    buildInfoHolder(
                        "Phone No. Personal", "${widget.profileData!.pPhone}"),
                    Divider(height: 1),
                    buildInfoHolder(
                        "Phone No. Work", "${widget.profileData!.wPhone}"),
                    Divider(height: 1),
                    buildInfoHolder("Gender", "${widget.profileData!.gender}"),
                    Divider(height: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoHolder(String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "${title} : ",
                    style: TextStyle(
                        color: Colors.pink.shade900,
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    content.isEmpty || content == 'null'
                        ? "Not Specify "
                        : "${content}",
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
      // ),
    );
  }

  Widget bottomSheet() {
    return Container(
        alignment: Alignment.topLeft,
        height: 150,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Container(
                padding: EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 20,
                ),
                alignment: Alignment.topLeft,
                height: 50,
                child: ListTile(
                  onTap: () {
                    takePhoto(ImageSource.gallery);
                  },
                  leading:
                      Icon(Icons.collections, size: 35, color: Colors.pink),
                  title: Text(
                    'Select Profile Photo',
                    style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                  ),
                )),
            Container(
                padding: EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 20,
                ),
                alignment: Alignment.topLeft,
                height: 50,
                child: ListTile(
                  onTap: () {
                    takePhoto(ImageSource.camera);
                  },
                  leading:
                      Icon(Icons.photo_camera, size: 35, color: Colors.pink),
                  title: Text(
                    'Take New Profile Photo',
                    style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                  ),
                )),
          ],
        ));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
      if (_imageFile != null) {
        _image = File(_imageFile!.path);
        _imageName = _image!.path.split('/').last;
        _imageBytes = _image!.readAsBytesSync();
        complete = true;
        _fileImage = FileImage(File(_imageFile!.path));
        Navigator.pop(context);
        print(_imageFile!.path);
        print(_fileImage);
        uploadImageToFirebase();
      }
    });
  }

  void uploadImageToFirebase() async {
    print("object _image");
    print(_image);
    final ref = FirebaseStorage.instance
        .ref()
        .child("userimage")
        .child(_userId)
        .child(
            DateTime.now().toUtc().millisecondsSinceEpoch.toString() + ".jpg");
    // await ref.putFile(_image);
    StorageUploadTask uploadTask = ref.putFile(_image);

    String downloadUrl =
        await (await uploadTask.onComplete).ref.getDownloadURL();

    print(downloadUrl);
    await addOrUpdateProfileImage(downloadUrl);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Saved profile image."),
    ));
  }

  Future<void> addOrUpdateProfileImage(String imgURL) async {
    AddOrUpdateProfileImage().addOrUpdateProfileImage(imgURL);
  }
}
