import 'package:app/constants/constants.dart';
import 'package:app/views/screens/scr_home/calendar_timer.dart';
import 'package:app/widgets/wid_modal_check_in.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentCard extends StatefulWidget {
  final List<Appointment> appointmentDetails;
  final String customerName;
  final lEvents;
  const AppointmentCard({
    required this.appointmentDetails,
    required this.customerName,
    required this.lEvents,
  });
  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool selected = true;

  ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < widget.appointmentDetails.length; i++) {
      children.add(
        Column(
          children: [
            new ListTile(
              onTap: () {
                print("object KKK ${widget.appointmentDetails[i].id}");
                print(
                    "object KKK ${widget.appointmentDetails[i].recurrenceId}");
                if (widget.appointmentDetails[i].recurrenceId == "confirmed") {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertCheckIn(
                          appointmentDetails: widget.appointmentDetails,
                          listData: widget.lEvents,
                          eventData: widget.appointmentDetails[i],
                          estheticians: Constants.USER_NAME,
                          fromDate: DateTime.now(),
                          startDateTime: DateTime.now());
                    },
                  );
                } else if (widget.appointmentDetails[i].recurrenceId ==
                    "checked_in") {
                  // Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalendarTimerScreen(
                              appointmentDetails: widget.appointmentDetails,
                              listData: widget.lEvents,
                              eventData: widget.appointmentDetails[i],
                              estheticians: Constants.USER_NAME,
                              fromDate: DateTime.now(),
                              startDateTime: DateTime.now())));
                }
              },
              title: Column(
                children: [
                  Text(
                    '${widget.appointmentDetails[i].subject}',
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                      '${DateFormat('hh:mm a').format(widget.appointmentDetails[i].startTime)} - ${DateFormat('hh:mm a').format(widget.appointmentDetails[i].endTime)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            Divider(
              height: 1,
            )
          ],
        ),
      );
    }
    // return new ListView(
    //   children: children,
    // )
    return ExpandableNotifier(
      child: Column(
        children: [
          ScrollOnExpand(
            child: ExpandablePanel(
              controller: _expandableController,
              theme: ExpandableThemeData(
                hasIcon: false,
              ),
              header: TextButton(
                child: ListTile(
                  title: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.customerName}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  trailing: _expandableController.expanded
                      ? Icon(
                          Icons.keyboard_arrow_down,
                          size: 30,
                        )
                      : Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                        ),
                ),
                onPressed: () {
                  setState(() {
                    _expandableController.expanded =
                        !_expandableController.expanded;
                  });
                },
              ),

              //CONTENT EXPANDED
              expanded: Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: children,
                    )
                  ],
                ),
              ),
              collapsed: Container(),
              builder: (_, collapsed, expanded) {
                return Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                );
              },
            ),
          ),
          Divider(
            height: 2,
          )
        ],
      ),
    );
  }
}
