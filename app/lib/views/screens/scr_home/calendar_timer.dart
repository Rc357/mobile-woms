import 'dart:async';
import 'package:app/constants/constants.dart';
import 'package:app/model/model_end_multiple_book.dart';
import 'package:app/services/ser_post_app.dart';
import 'package:app/services/ser_update_booking_status.dart';
import 'package:app/views/screens/scr_calendar/components/utils.dart';
import 'package:app/widgets/wid_button_timer.dart';
import 'package:app/widgets/wid_date.dart';
import 'package:app/widgets/wid_modal_exit_warning.dart';
import 'package:app/widgets/wid_modal_session.dart';
import 'package:app/widgets/wid_modal_session_end.dart';
import 'package:app/widgets/wid_modal_session_multi_end.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wakelock/wakelock.dart';
// import 'package:wakelock/wakelock.dart';

class CalendarTimerScreen extends StatefulWidget {
  final List<Appointment> appointmentDetails;
  final eventData;
  final listData;
  // final String serviceType;
  // final String clientName;
  final String estheticians;
  final DateTime fromDate;
  final DateTime startDateTime;

  const CalendarTimerScreen(
      {Key? key,
      // required this.serviceType,
      required this.appointmentDetails,
      required this.eventData,
      required this.listData,
      // required this.clientName,
      required this.fromDate,
      required this.startDateTime,
      required this.estheticians});
  @override
  _CalendarTimerScreenState createState() => _CalendarTimerScreenState();
}

class _CalendarTimerScreenState extends State<CalendarTimerScreen> {
  Duration duration = Duration();
  Timer? timer;

  DateTime? today;
  DateTime? startTime;
  DateTime? endTime;
  String dateNowStart = "";
  var date;
  var data;
  var eData;
  bool singleBooked = true;
  bool multiBookedEnd = false;
  bool multiBooked = false;
  bool isTimerStart = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      dateNowStart = DateTime.now().toString();
    });

    print("object sdasdassdas");
    print(widget.listData.length);
    bool isStop = false;
    print("object BBBBBSSSSSS");
    print(widget.appointmentDetails.length);

    setState(() {
      Constants.lData = [];
    });
    for (int i = 0; i < widget.listData.length; i++) {
      for (int x = 0; x < widget.appointmentDetails.length; x++) {
        if (widget.appointmentDetails[x].id == widget.listData[i].code) {
          print("ADD widget.appointmentDetails[x].id");
          print(widget.appointmentDetails[x].id);
          Constants.lData.add(widget.listData[i]);
          print("addddd");
        }
      }
    }
    setState(() {
      Constants.addBookOnce = false;
    });

    print(" Constants.lData ");
    print(Constants.lData.length);

    for (int j = 0; j < Constants.lData.length; j++) {
      print(" lData[j].orderId ");
      print(Constants.lData[j].orderId);
      if (widget.eventData != null && widget.appointmentDetails.length == 1) {
        if (widget.eventData.code == Constants.lData[j].code) {
          data = Constants.lData[j];
        }
      } else if (widget.eventData != null) {
        print("KLKLKLKLK");
        if (widget.eventData.code == Constants.lData[j].code) {
          data = Constants.lData[j];
          if (j < Constants.lData.length - 1) {
            if (Constants.lData[j].orderId == Constants.lData[j + 1].orderId) {
              setState(() {
                print("XXXX multiBooked");
                multiBooked = true;
                eData = Constants.lData[j + 1];
              });
            } else {
              setState(() {
                print("XXXX1 singleBook");
                singleBooked = true;
              });
            }
            break;
          } else {
            setState(() {
              print("XXXX2 singleBook");
              singleBooked = true;
            });
          }
        }
      }
      // print("object lData");
      // print(lData[j].id);
      // print(lData[j].orderId);
    }

    //ESCAPE
    // if (widget.eventData != null && widget.appointmentDetails.length == 1) {
    //   print("SASASASADDDDDAAAAAA");
    //   if (widget.eventData.id == widget.listData[i].id) {
    //     print(widget.eventData.id);
    //     print(widget.appointmentDetails[0].id);
    //     data = widget.listData[i];
    //     setState(() {
    //       singleBooked = true;
    //       // multiBookedEnd = true;
    //     });
    //     break;
    //   }
    // } else if (widget.appointmentDetails.length > 1) {
    //   print("KKKKKKKKKKKLLLLLLLLLLLLLLLLL");
    //   for (int n = 0; n < widget.appointmentDetails.length; n++) {
    //     print("dsasdsdsfdsdfsdfdsfdds");
    //     if (widget.appointmentDetails[n].id == widget.listData[i].id) {
    //       lData.add(widget.listData[i]);
    //       print("addddd");
    //     }
    //     if (widget.eventData != null) {
    //       print("dfdfdf");
    //       for (int m = 0; m < lData.length; m++) {
    //         if (widget.eventData.id == lData[m]) {
    //           data = lData[m];
    //           if (m < lData.length - 1) {
    //             if (lData[m].orderId == lData[m + 1].orderId) {
    //               setState(() {
    //                 multiBookedEnd = true;
    //               });
    //             } else {
    //               setState(() {
    //                 singleBooked = true;
    //               });
    //             }
    //           }
    //           isStop = true;
    //           break;
    //         }
    //       }
    //     }
    //   }
    //   if (isStop) {
    //     break;
    //   }
    // }
    // else if (widget.eventData != null &&
    //     widget.appointmentDetails.length > 1) {
    //   // print("XXXXXXX");
    //   // int j = widget.appointmentDetails.length - 1;
    //   // setState(() {
    //   //   multiBookedEnd = true;
    //   // });

    //   for (int j = 0; j < widget.appointmentDetails.length; j++) {
    //     if (widget.appointmentDetails[j].id == widget.listData[i].id) {
    //       print("DDDDDDDDDD");
    //       print(widget.appointmentDetails[j].id);
    //       data = widget.listData[i];
    //       isStop = true;
    //       break;
    //     }
    //   }
    //   // while (j >= 0) {
    //   //   j--;
    //   // }
    //   if (isStop) {
    //     break;
    //   }
    // }
    //  else if (widget.appointmentDetails.length == 1) {
    //   if (widget.appointmentDetails[0].id == widget.listData[i].id) {
    //     print("FFFFFFFFFFFF");
    //     data = widget.listData[i];
    //     isStop = true;
    //     setState(() {
    //       singleBooked = true;
    //     });
    //     break;
    //   }
    // }
    // }
    ;
    reset();

    date =
        new DateTime.fromMillisecondsSinceEpoch(int.parse(data.label) * 1000);
    print("DKSKSKSKS");
    print(widget.fromDate);
    print(data.code);
    print(date);
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
    setState(() {
      isTimerStart = false;
    });
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

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);

    //Recording to datanase

    String _dateNow = formatted;

    await saveEvent(
        data.code.toString(), _howLong, widget.startDateTime, now, _dateNow);
    await saveEventTimer(data.code.toString(), duration.inMinutes.toString());
    // await saveEvent(_howLong, ((_recFromTime / 1000).round()),
    //     ((_recToTime / 1000).round()), _dateNow);

    updateBookingStatus("end");

    for (int x = 0; x < widget.appointmentDetails.length; x++) {
      print("passsokkkk");
      if (widget.appointmentDetails[x].id == data.code &&
          widget.appointmentDetails.length != 1) {
        setState(() {
          widget.appointmentDetails.removeAt(x);
        });
        print("remmmovee");
        print(widget.appointmentDetails[x].id);
        print(widget.appointmentDetails.last.id);
        break;
      }
      if (widget.appointmentDetails[x].id ==
          widget.appointmentDetails.last.id) {
        print("DSDSDSDSDSDSDSDAS");
        setState(() {
          multiBookedEnd = true;
        });
        break;
      }
    }
    if (multiBooked) {
      print("FFFFFFFFFFFFFFFFFFFFFFF");
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertEndSessionMultiBook(
              serviceType: data.title,
              clientName: data.clientName,
              estheticiansName: widget.estheticians,
              getDate: today,
              from: _from,
              to: _to,
              howLong: _howLong,
              appointmentDetails: widget.appointmentDetails,
              eventData: eData,
              listData: widget.listData,
              estheticians: widget.estheticians,
              fromDate: widget.fromDate,
              startDateTime: widget.startDateTime);
        },
      );
    }

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) {
    //     return AlertEndSessionMultiBook(
    //         serviceType: data.title,
    //         clientName: data.clientName,
    //         estheticiansName: widget.estheticians,
    //         getDate: today,
    //         from: _from,
    //         to: _to,
    //         howLong: _howLong,
    //         appointmentDetails: widget.appointmentDetails,
    //         eventData: null,
    //         listData: widget.listData,
    //         estheticians: widget.estheticians,
    //         fromDate: widget.fromDate,
    //         startDateTime: widget.startDateTime);
    //   },
    // );

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) {
    //     return AlertEndSession(
    //       serviceType: data.title,
    //       clientName: data.clientName,
    //       estheticiansName: widget.estheticians,
    //       getDate: today,
    //       from: _from,
    //       to: _to,
    //       howLong: _howLong,
    //     );
    //   },
    // );

    //Check if multiple bookings
    // for (int j = 0; j < widget.appointmentDetails.length - 1; j++) {
    //   if (widget.appointmentDetails[j].startTime ==
    //       widget.appointmentDetails[j + 1].startTime) {
    //     if (widget.appointmentDetails.last.id ==
    //         widget.appointmentDetails[0].id) {
    //       setState(() {
    //         singleBooked = true;
    //       });
    //     } else {
    //       if (data.id == widget.appointmentDetails[j].id) {
    //         print("AASASASASASASAS");
    //         setState(() {
    //           singleBooked = false;
    //           widget.appointmentDetails.removeAt(j);
    //         });
    //       }
    //     }

    //     print("object  widget.appointmentDetails");
    //     print(widget.appointmentDetails[j].recurrenceId);
    //     showDialog(
    //       context: context,
    //       barrierDismissible: false,
    //       builder: (context) {
    //         return AlertEndSessionMultiBook(
    //             serviceType: data.title,
    //             clientName: data.clientName,
    //             estheticiansName: widget.estheticians,
    //             getDate: today,
    //             from: _from,
    //             to: _to,
    //             howLong: _howLong,
    //             appointmentDetails: widget.appointmentDetails,
    //             eventData: null,
    //             listData: widget.listData,
    //             estheticians: widget.estheticians,
    //             fromDate: widget.fromDate,
    //             startDateTime: widget.startDateTime);
    //       },
    //     );
    //   }
    // }

    if (multiBookedEnd) {
      print("multiBookedEnd");
      print(multiBookedEnd);
      Constants.lMultipleModal.add(MultipleBookEndSessionData(
        ServiceType: data.title,
        clientName: data.clientName,
        estheticiansName: widget.estheticians,
        getDate: today,
        from: _from,
        to: _to,
        howLong: _howLong,
        estheticians: widget.estheticians,
        fromDate: widget.fromDate,
        startDateTime: widget.startDateTime,
      ));

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertEndSessionMulti(
            clientName: data.clientName,
            estheticiansName: widget.estheticians,
          );
        },
      );
    } else if (!multiBooked && singleBooked && !multiBookedEnd) {
      print("multiBooked singleBooked");
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertEndSession(
            serviceType: data.title,
            clientName: data.clientName,
            estheticiansName: widget.estheticians,
            getDate: today,
            from: _from,
            to: _to,
            howLong: _howLong,
          );
        },
      );
    }

    reset();
    setState(() => timer?.cancel());
  }

  Future saveEvent(String id, String howLong, DateTime from, DateTime to,
      String dateNow) async {
    AppointmentService.appointmentService(
      data.title,
      howLong,
      data.clientName,
      widget.estheticians,
      id,
      from.toString(),
      to.toString(),
      dateNow,
    );
  }

  Future saveEventTimer(String id, String timeDuration) async {
    AppointmentService.appointmentServiceTimer(id, timeDuration);
  }

//***  Timer methods END */

//***** WIDGETS AREA *****/

//***  Timer Widget START */
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        closeSecreen();
        return false;
      },
      child: Scaffold(
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
                      closeSecreen();
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
                                  "${data.clientName}",
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
            '${data.title}',
            style: TextStyle(
                color: Colors.pink, fontSize: 15, fontWeight: FontWeight.bold),
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
                if (Constants.isTimeIn) {
                  startTimer();
                  updateBookingStatus("start");
                  setState(() {
                    isTimerStart = true;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Please Time In first in order to start the timer."),
                  ));
                }
              },
            ),
    );
  }
//***  Timer Widget END */

//***  DATE Widget START */

  Widget buildDateToday() => Container(
      child: BuildDateDisplay().buildDate(context, Utils.toDate(date)));

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
            Utils.toDate(date),
            style: TextStyle(
                fontSize: 40,
                color: Colors.pink.shade900,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void updateBookingStatus(String status) async {
    print(data.orderId);
    await UpdateBookingStatusService.updateBookingStatusService(
        widget.eventData.code.toString(),
        status,
        DateTime.now().toString(),
        data.orderId);
  }

  void closeSecreen() {
    setState(() {
      Constants.lMultipleModal = [];
    });
    if (isTimerStart) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertExitTimer();
        },
      );
    } else {
      Navigator.pop(context);
    }
  }
}
