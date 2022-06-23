import 'package:app/constants/constants.dart';
import 'package:app/services/ser_get_app.dart';
import 'package:app/services/ser_get_profile.dart';
import 'package:app/services/ser_login.dart';
import 'package:app/widgets/toaster_message.dart';
import 'package:app/widgets/wid_modal_no_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _ctlUserName = TextEditingController();
  var _ctlPassword = TextEditingController();
  late DateTime timeIn;
  bool hasSchedule = false;
  bool isRememberMe = false;

  bool _passIsEncrypted = true;
  final _storage = const FlutterSecureStorage();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void loginUser() async {
    var uuid = Uuid();
    var v1Token = uuid.v1();

    if (_ctlUserName.text.isEmpty || _ctlPassword.text.isEmpty) {
      // ToastMessage().toastMessage("Username or Password is required.");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Username or Password is required."),
      ));
    } else {
      timeIn = DateTime.now();
      String? checkUser = await UserService.loginService(
          _ctlUserName.text, _ctlPassword.text, timeIn.toString(), v1Token);
      if (checkUser == "success") {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("emailKey", _ctlUserName.text);
        sharedPreferences.setString("tokenKey", v1Token);
        Navigator.popAndPushNamed(context, "/main");
      } else if (checkUser == "customer") {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("emailKey", _ctlUserName.text);
        sharedPreferences.setString("tokenKey", v1Token);
        setState(() {
          Constants.isCustomer = true;
        });
        Navigator.popAndPushNamed(context, "/main_customer");
      } else {
        // ToastMessage().toastMessage("Username or Password is incorrect.");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Username or Password is incorrect."),
        ));
      }
    }
  }

  @override
  void dispose() {
    _ctlUserName.dispose();
    _ctlPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // checkIfHasRememberMe();
    _readFromStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: null,
              extendBodyBehindAppBar: true,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/woms_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SafeArea(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * .1,
                        ),
                        Image.asset(
                          'assets/woms_logo.png',
                          semanticLabel: 'WOMS Logo',
                          height: 200,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  width: size.width * .8,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: TextField(
                                          controller: _ctlUserName,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFCD5E77),
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFa8668a),
                                                  width: 1.0),
                                            ),
                                            labelText: "User Name",
                                            hintText:
                                                "Enter user name or mail id",
                                            labelStyle: TextStyle(
                                              color: Color(0xFFCD5E77),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // InputTextField("User Name", "Enter user name or mail id"),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: size.width * .8,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: TextField(
                                          controller: _ctlPassword,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFCD5E77),
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFa8668a),
                                                  width: 1.0),
                                            ),
                                            labelText: "Password",
                                            hintText: "Enter password",
                                            labelStyle: TextStyle(
                                              color: Color(0xFFCD5E77),
                                            ),
                                          ),
                                          obscureText: _passIsEncrypted,
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 20,
                                        child: Padding(
                                          padding: const EdgeInsets.only(),
                                          child: IconButton(
                                            icon: _passIsEncrypted
                                                ? Icon(
                                                    Icons.visibility_off,
                                                    semanticLabel:
                                                        'Eye Icon for show or hide password',
                                                  )
                                                : Icon(Icons.visibility,
                                                    semanticLabel:
                                                        'Eye Icon for show or hide password',
                                                    color:
                                                        Colors.grey.shade400),
                                            onPressed: () => setState(() =>
                                                _passIsEncrypted =
                                                    !_passIsEncrypted),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        // InputTextFieldPass("Password", "Enter password"),
                        Container(
                            width: size.width * .7,
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 12),
                                    ),
                                    onPressed: null,
                                    child: const Text('Reset Password?'),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 12),
                                    ),
                                    onPressed: null,
                                    child: Row(
                                      children: [
                                        Text('Remember me'),
                                        Container(
                                          width: 20,
                                          child: Transform.scale(
                                            scale: .7,
                                            child: Checkbox(
                                                activeColor:
                                                    Colors.pink.shade200,
                                                value: isRememberMe,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isRememberMe =
                                                        !isRememberMe;
                                                  });
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 40),
                          width: size.width * 0.8,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              checkIfHasSchedule();
                              loginUser();

                              updateRememberMe();
                            },
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: Colors.pink.shade200,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              )),
        ],
      ),
    );
  }

  Future<void> checkIfHasSchedule() async {
    DateTime date = DateTime.now();
    String day = DateFormat('EEEE').format(date);
    print("object day");
    print(day.toLowerCase());
    if (_ctlUserName.text.isEmpty || _ctlPassword.text.isEmpty) {
      // ToastMessage().toastMessage("Username or Password is required.");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Username or Password is required."),
      ));
    } else {
      var value = await ProfileService().checkUserExist(_ctlUserName.text);
      setState(() {
        Constants.USER_ID = int.parse(value.id);
      });
      var events = await ServicesGetAppointment().getAppointmentSched();

      for (int i = 0; i < events.length; i++) {
        events[i].dayOfWeek;
        print(events[i].dayOfWeek.toString());
        if (day.toLowerCase().contains(events[i].dayOfWeek.toString())) {
          // setState(() {
          hasSchedule = true;
          // });
          break;
        }
      }
      // if (hasSchedule) {
      //   loginUser();
      // } else {
      //   showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertNoSchedule();
      //     },
      //   );
      // }
    }
  }

  Future<void> updateRememberMe() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (isRememberMe) {
        print("object SAVVVVEEEEEEEE");
        print(_ctlUserName.text);
        print(_ctlPassword.text);
        await _storage.write(key: "KEY_USERNAME", value: _ctlUserName.text);
        await _storage.write(key: "KEY_PASSWORD", value: _ctlPassword.text);
      }
    }
  }

  Future<void> _readFromStorage() async {
    _ctlUserName.text = await _storage.read(key: "KEY_USERNAME") ?? "";
    _ctlPassword.text = await _storage.read(key: "KEY_PASSWORD") ?? "";
  }

  // Future<void> checkIfHasRememberMe() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   if (sharedPreferences.getString("emailKey") != null) {
  //     setState(() {
  //       _ctlUserName = new TextEditingController(
  //           text: sharedPreferences.getString("emailKey").toString());
  //     });
  //   }
  // }
}
