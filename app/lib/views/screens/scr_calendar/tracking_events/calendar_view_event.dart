import 'package:app/views/screens/scr_calendar/components/utils.dart';
import 'package:app/widgets/sticky_note/sticky_note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendareViewEvents extends StatelessWidget {
  final date;
  final event;
  final lEvents;
  @override
  const CalendareViewEvents({
    Key? key,
    required this.date,
    required this.event,
    required this.lEvents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFCD5E77),
          // title: Text(""),
          // automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * .2,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade200.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(70)),
                    color: Color(0xFFCD5E77)),
                child: Stack(
                  children: [
                    Positioned(
                        top: 10,
                        left: 0,
                        child: Container(
                          height: size.height * .1,
                          width: size.width * .8,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 8,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                              color: Colors.white),
                        )),
                    Positioned(
                      top: size.height * .05,
                      left: 20,
                      child: Text(
                        "${Utils.toDate(date)}",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade900),
                      ),
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: cardHolder(size.height, size.width, event, lEvents),
              // ),
              SizedBox(
                height: 20,
              ),
              stickyPage(size.height, size.width, event, lEvents)
            ],
          ),
        ));
  }

  Widget stickyPage(double h, double w, var event, var ldata) {
    var data;
    var allData = [];

    for (int j = 0; j < event.length; j++) {
      print(event[j].code);

      for (int i = 0; i < ldata.length; i++) {
        if (event[j].code == ldata[i].code) {
          print("FFFFFFFFFFFFFFFFFFFFFFF");
          print(ldata[i].code);
          data = ldata[i];
          allData.add(ldata[i]);
        }
      }
      ;
    }
    // DateTime dtS = DateTime.parse('2022-04-21 22:08:06');
    // DateTime dtE = DateTime.parse('2022-04-21 22:08:06');
    // DateTime dtS = DateTime.parse('${data.eventStartTime}');
    // DateTime dtE = DateTime.parse('${data.eventEndTime}');
    return Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: allData
                .map<Widget>((i) => new SizedBox(
                    width: w * .9,
                    height: h * .5,
                    child: Container(
                        color: Colors.white,
                        child: StickyNote(
                          child: Stack(
                            children: [
                              Positioned(
                                  child: Container(
                                width: w * 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Type of Service: ',
                                          style: TextStyle(
                                              fontFamily: "DKLemonYellowSun",
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink.shade900),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '${i.eventTitle}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        Colors.pink.shade900)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Name of Client: ',
                                          style: TextStyle(
                                              fontFamily: "DKLemonYellowSun",
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink.shade900),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '${i.order_item_id}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        Colors.pink.shade900)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Name of Estheticians: ',
                                          style: TextStyle(
                                              fontFamily: "DKLemonYellowSun",
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink.shade900),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '${i.booking_product_event_ticket_id}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        Colors.pink.shade900)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Start of Service: ',
                                          style: TextStyle(
                                              fontFamily: "DKLemonYellowSun",
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink.shade900),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '${DateFormat.Hms().format(DateTime.parse(i.product_id))}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        Colors.pink.shade900)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'End of Service: ',
                                          style: TextStyle(
                                              fontFamily: "DKLemonYellowSun",
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink.shade900),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    '${DateFormat.Hms().format(DateTime.parse(i.employee_id))}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        Colors.pink.shade900)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Service Duration: ',
                                          style: TextStyle(
                                              fontFamily: "DKLemonYellowSun",
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.pink.shade900),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '${i.to}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        Colors.pink.shade900)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ))))
                .toList(),
          ),
        ));
  }

  Widget cardHolder(double h, double w, var event, var ldata) {
    var data;
    for (int i = 0; i < ldata.length; i++) {
      if (event[0].code == ldata[i].code) {
        print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
        data = ldata[i];
      }
    }
    ;
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: h * .05,
          ),
          Container(
            height: h * .3,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                    child: Container(
                  width: w * 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Type of Service: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade900),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${data.eventTitle}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.pink.shade900)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Name of Client: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade900),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${data.order_item_id}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.pink.shade900)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Name of Estheticians: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade900),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '${data.booking_product_event_ticket_id}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.pink.shade900)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Start of Service: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade900),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${data.product_id}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.pink.shade900)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'End of Service: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade900),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${data.employee_id}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.pink.shade900)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Service Duration: ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade900),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${data.to}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.pink.shade900)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
