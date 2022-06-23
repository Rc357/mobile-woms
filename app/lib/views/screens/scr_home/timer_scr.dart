import 'dart:async';
import 'package:app/constants/constants.dart';
import 'package:app/services/ser_post_app.dart';
import 'package:app/views/screens/scr_calendar/components/utils.dart';
import 'package:app/widgets/wid_button_timer.dart';
import 'package:app/widgets/wid_date.dart';
import 'package:app/widgets/wid_modal_session.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimerScreen extends StatefulWidget {
  final String serviceType;
  final String clientName;
  final String estheticians;
  final DateTime fromDate;
  final DateTime startDateTime;

  const TimerScreen(
      {Key? key,
      required this.serviceType,
      required this.clientName,
      required this.fromDate,
      required this.startDateTime,
      required this.estheticians});
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Duration duration = Duration();
  Timer? timer;

  DateTime? today;
  DateTime? startTime;
  DateTime? endTime;

  @override
  void initState() {
    super.initState();

    reset();
  }

//***** METHODS/FUNCTION AREA *****/

//***  Timer methods START */
  void reset() {
    setState(() => duration = Duration());
  }

  void addTime() {
    setState(() {
      final seconds = duration.inSeconds + 1;

      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) {
    today = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    if (resets) {
      reset();
    }
  }

  void pauseTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  void stopTimer() async {
    String _from = DateFormat.jm().format(DateFormat("hh:mm:ss")
        .parse("${today!.hour}:${today!.minute}:${today!.second}"));

    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final _hours = twoDigit(duration.inHours);
    final _minutes = twoDigit(duration.inMinutes.remainder(60));
    final _seconds = twoDigit(duration.inSeconds.remainder(60));

    final DateTime endTime = today!.add(
      Duration(
        hours: int.parse(_hours),
        minutes: int.parse(_minutes),
        seconds: int.parse(_seconds),
      ),
    );

    String _to = DateFormat.jm().format(DateFormat("hh:mm:ss")
        .parse("${endTime.hour}:${endTime.minute}:${endTime.second}"));

    String twoDigit2(int n) => n.toString().padLeft(2);
    final hours2 = twoDigit2(duration.inHours);
    final minutes2 = twoDigit2(duration.inMinutes.remainder(60));
    final seconds2 = twoDigit2(duration.inSeconds.remainder(60));

    String _howLong = "";
    if (int.parse(hours2) == 0) {
      if (int.parse(minutes2) == 0) {
        _howLong = "${seconds2} seconds";
      } else {
        _howLong = "${minutes2} minutes and ${seconds2} seconds";
      }
    } else {
      _howLong = "${hours2} hours, ${minutes2} minutes and ${seconds2} seconds";
    }

    // final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(widget.fromDate);

    //Recording to datanase

    String _dateNow = formatted;
    // String _dateNow = Utils.toDate(widget.fromDate);
    // String _dateNow = widget.fromDate.toString();

    // await saveEvent(_howLong, widget.startDateTime, DateTime.now(), _dateNow);
    // await saveEvent(_howLong, ((_recFromTime / 1000).round()),
    //     ((_recToTime / 1000).round()), _dateNow);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertEndSession(
          serviceType: widget.serviceType,
          clientName: widget.clientName,
          estheticiansName: widget.estheticians,
          getDate: today,
          from: _from,
          to: _to,
          howLong: _howLong,
        );
      },
    );
    reset();
    setState(() => timer?.cancel());
  }

  // Future saveEvent(
  //     String howLong, DateTime from, DateTime to, String dateNow) async {
  //   AppointmentService.appointmentService(
  //     widget.serviceType,
  //     howLong,
  //     widget.clientName,
  //     widget.estheticians,
  //     from.toString(),
  //     to.toString(),
  //     dateNow,
  //   );
  // }

//***  Timer methods END */

//***** WIDGETS AREA *****/

//***  Timer Widget START */
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/woms_bg01.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: size.width,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40.0, left: 10),
                child: IconButton(
                  icon: Image.asset('assets/back.png'),
                  iconSize: 32,
                  onPressed: () {
                    print("object");
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: size.height * .05),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(0XFFF7D0C8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                            border: Border.all(
                              width: 3,
                              color: Colors.pink,
                              style: BorderStyle.solid,
                            ),
                          ),
                          height: size.height * .50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: size.height * .04),
                              Text(
                                "${widget.clientName}",
                                style: TextStyle(
                                    color: Colors.pink.shade900,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: size.height * .02),
                              buildDateToday(),
                              SizedBox(height: size.height * .02),
                              buildTime(),
                              SizedBox(height: size.height * .03),
                              buildEstheticians(),
                              SizedBox(height: size.height * .01),
                              buildServiceType()
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -120,
                      child: Container(
                        child: CircleAvatar(
                            radius: size.height * .10,
                            backgroundColor: Colors.pink.shade200,
                            backgroundImage:
                                AssetImage("assets/temp_profile.jpeg")
                            // NetworkImage('https://via.placeholder.com/150'),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * .04),
            buildButtons()
          ],
        ),
      ),
    );
  }

  Widget buildTime() {
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigit(duration.inHours);
    final minutes = twoDigit(duration.inMinutes.remainder(60));
    final seconds = twoDigit(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: "HOURS"),
        const SizedBox(
          width: 10,
        ),
        buildTimeCard(time: minutes, header: "MINUTES"),
        const SizedBox(
          width: 10,
        ),
        buildTimeCard(time: seconds, header: "SECONDS"),
      ],
    );
  }

  Widget buildEstheticians() {
    return Column(
      children: [
        Container(
          child: Text(
            "Estheticians:",
            style: TextStyle(
                color: Colors.pink.shade900,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: Text(
            '${widget.estheticians}',
            style: TextStyle(
                color: Colors.pink, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buildServiceType() {
    return Column(
      children: [
        Container(
          child: Text(
            "Availed Service:",
            style: TextStyle(
                color: Colors.pink.shade900,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          child: Text(
            '${widget.serviceType}',
            style: TextStyle(
                color: Colors.pink, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.pink.shade900,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(time,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade50,
                  fontSize: 50,
                )),
          ),
          Text(header,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade900,
                fontSize: 15,
              )),
        ],
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return Container(
      child: isRunning || !isCompleted
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  text: isRunning ? 'PAUSE' : "RESUME",
                  color: Colors.white,
                  backgroundColor: Colors.pink.shade300,
                  onClicked: () {
                    if (isRunning) {
                      pauseTimer(resets: false);
                    } else {
                      startTimer(resets: false);
                    }
                  },
                ),
                const SizedBox(width: 12),
                ButtonWidget(
                  text: 'STOP',
                  color: Colors.white,
                  backgroundColor: Colors.red.shade400,
                  onClicked: stopTimer,
                ),
              ],
            )
          : ButtonWidget(
              text: 'Start Timer',
              color: Colors.white,
              backgroundColor: Colors.pink.shade400,
              onClicked: () {
                print("object Constants.isTimeIn");
                print(Constants.isTimeIn);
                if (Constants.isTimeIn) {
                  startTimer();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Please sign in first in oder to start the timer."),
                  ));
                }
              },
            ),
    );
  }
//***  Timer Widget END */

//***  DATE Widget START */

  Widget buildDateToday() => Container(
      child:
          BuildDateDisplay().buildDate(context, Utils.toDate(widget.fromDate)));

  Widget buildDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xFFF0D3DA),
                Color(0xFFF0CAD4),
                Color(0xFFF1C2CC),
                Color(0xFFF1BCC5),
                Color(0xFFF2B4BE),
                Color(0xFFF2ADB7),
              ],
            ),
            border: Border.all(color: Color(0XFFF09FAD), width: 5),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            Utils.toDate(widget.fromDate),
            style: TextStyle(
                fontSize: 40,
                color: Colors.pink.shade900,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
