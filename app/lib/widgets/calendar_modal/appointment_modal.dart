import 'package:app/views/screens/scr_calendar/expanded_list/list_customer_sched.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import "package:collection/collection.dart";

class ModalAppointment extends StatefulWidget {
  var lEvents;
  final List<Appointment> appointmentDetails;
  ModalAppointment({this.lEvents, required this.appointmentDetails});

  @override
  State<ModalAppointment> createState() => _ModalAppointmentState();
}

class _ModalAppointmentState extends State<ModalAppointment> {
  List<List<Appointment>> appointmentArrays = [];
  @override
  void initState() {
    super.initState();

    reGroupAppointment();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: ImageIcon(
                  AssetImage("assets/icons/remove_icon.jpg"),
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Scheduled Appointment',
                style: TextStyle(
                  fontFamily: 'roboto',
                  color: Colors.pink.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: appointmentArrays
                  .map((i) => AppointmentCard(
                      lEvents: widget.lEvents,
                      appointmentDetails: i,
                      customerName: i.first.location.toString()))
                  .toList()),
        ));
  }

  void reGroupAppointment() {
    List<Appointment> temp = [];
    if (widget.appointmentDetails.length == 1) {
      temp.add(widget.appointmentDetails[0]);
      appointmentArrays.add(temp);
    } else {
      temp.add(widget.appointmentDetails.first);
      for (int i = 1; i < widget.appointmentDetails.length; i++) {
        if (temp.last.location == widget.appointmentDetails[i].location &&
            temp.last.startTime == widget.appointmentDetails[i].startTime) {
          // print("ADDED GGGG");
          temp.add(widget.appointmentDetails[i]);
          if (widget.appointmentDetails[i].id ==
              widget.appointmentDetails.last.id) {
            appointmentArrays.add(temp);
          }
        } else if (widget.appointmentDetails[i].id ==
            widget.appointmentDetails.last.id) {
          // print("ELSE IF GGGG");
          appointmentArrays.add(temp);
          temp = [];
          temp.add(widget.appointmentDetails[i]);
          appointmentArrays.add(temp);
        } else {
          // print("ELSE GGGG");
          appointmentArrays.add(temp);
          temp = [];
          temp.add(widget.appointmentDetails[i]);
          print(temp.last.location);
        }
      }
    }
  }
}
