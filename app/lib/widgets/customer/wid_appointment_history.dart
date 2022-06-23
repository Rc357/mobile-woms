// @dart=2.10
import 'package:app/model/model_customer_booking.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentHistory extends StatefulWidget {
  final List<CustomerBookingModel> lAppointment;
  final String label;

  const AppointmentHistory({Key key, this.lAppointment, this.label})
      : super(key: key);
  @override
  _AppointmentHistoryState createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  bool selected = true;

  ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15),
            width: MediaQuery.of(context).size.width,
            child: Text(
              '${widget.label}',
              style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Table(
              border: TableBorder.all(),
              columnWidths: {
                0: FractionColumnWidth(.3),
                1: FractionColumnWidth(.3),
                2: FractionColumnWidth(.2),
                3: FractionColumnWidth(.2)
              },
              children: [
                TableRow(children: [
                  Column(children: [
                    Text(
                      'Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ]),
                  Column(children: [
                    Text('Product',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))
                  ]),
                  Column(children: [
                    Text('Status',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))
                  ]),
                  Column(children: [
                    Text('Branch',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))
                  ]),
                ]),
                for (int n = 0; n < widget.lAppointment.length; n++)
                  TableRow(children: [
                    Column(children: [
                      // Text("")
                      Text(
                        '${DateFormat('MMMM dd, yyyy').add_jm().format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.lAppointment[n].from) * 1000))}',
                        textAlign: TextAlign.center,
                      )
                    ]),
                    Column(
                        children: [Text('${widget.lAppointment[n].product}')]),
                    Column(
                        children: [Text('${widget.lAppointment[n].status}')]),
                    Column(children: [
                      Text('${widget.lAppointment[n].booking_outlet}')
                    ]),
                  ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
