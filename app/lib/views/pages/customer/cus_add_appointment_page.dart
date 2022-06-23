import 'package:app/model/model_customer_booking.dart';
import 'package:app/model/model_customer_estheticians.dart';
import 'package:app/model/model_customer_room.dart';
import 'package:app/model/model_customer_slot.dart';
import 'package:app/model/model_esthetician.dart';
import 'package:app/services/customer_services/ser_get_estheticiansList.dart';
import 'package:app/services/customer_services/ser_get_last_and_future_appointment.dart';
import 'package:app/services/customer_services/ser_get_product_by_branch.dart';
import 'package:app/services/customer_services/ser_get_room.dart';
import 'package:app/services/customer_services/ser_get_slot_time.dart';
import 'package:app/widgets/customer/wid_appointment_history.dart';
import 'package:app/widgets/customer/wid_dropdown_expand.dart';
import 'package:app/widgets/customer/wid_modal_close_booking,.dart';
import 'package:app/widgets/wid_button.dart';
import 'package:app/widgets/wid_modal_no_schedule.dart';
import 'package:app/widgets/wid_modal_select_branch.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';

class CustomerAddAppointment extends StatefulWidget {
  final String site;
  final String branchId;
  final DateTime dateString;
  final List<dynamic> branchServices;
  final List<bool> checkedValue;
  CustomerAddAppointment({
    Key? key,
    required this.site,
    required this.branchId,
    required this.dateString,
    required this.branchServices,
    required this.checkedValue,
  }) : super(key: key);

  @override
  State<CustomerAddAppointment> createState() => _CustomerAddAppointmentState();
}

enum Branch { None, Airmont, BoroughPark }

class _CustomerAddAppointmentState extends State<CustomerAddAppointment> {
  String? selected = "None";
  List<CustomerBookingModel> futureAppointment = [];
  List<CustomerBookingModel> lastAppointment = [];
  bool showContent = false;
  EstheticianListModel? allEst;
  List<bool> checkedValueEst = [];
  List<bool> checkedValueTime = [];
  List<bool> checkedValueRoom = [];

  //Selected
  List<dynamic> selectetServices = [];
  var selectesEst;

  ExpandableController _expandableController = ExpandableController();
  ExpandableController _expandableController2 = ExpandableController();
  ExpandableController _expandableController3 = ExpandableController();
  ExpandableController _expandableController4 = ExpandableController();

  @override
  void initState() {
    super.initState();
    getCustomerBooking();
  }

  void getCustomerBooking() async {
    print("getCustomerBooking");
    List<CustomerBookingModel> fAppointment =
        await GetCustomerBooking().getCustomerFutureAppointment();
    List<CustomerBookingModel> lAppointment =
        await GetCustomerBooking().getCustomerLastAppointment();
    setState(() {
      futureAppointment = fAppointment;
      lastAppointment = lAppointment;
    });
  }

  @override
  Widget build(BuildContext context) {
    String _dateString = DateFormat('MMMM dd, yyyy').format(widget.dateString);
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Color(0xFFCD5E77),
        centerTitle: true,
        title: Text("Appointment Details"),
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        '${_dateString} ',
                        style: TextStyle(
                          fontFamily: 'roboto',
                          color: Colors.pink.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onTap: () {
                          print("TOUCH");
                          setState(() {});
                        },
                        child: RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Selected branch: '),
                              new TextSpan(
                                  text: '${widget.site}',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AppointmentHistory(
                      label: "Last Appointment",
                      lAppointment: lastAppointment,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppointmentHistory(
                      label: "Future Appointment",
                      lAppointment: futureAppointment,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    checkBoxServicesContainer(),
                    checkBoxEstheticians(),
                    checkBoxTimeSelect(),
                    checkBoxRoomSelect(),

                    SizedBox(
                      height: 25,
                    ),
                    //Buttons HERE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton2(
                          text: "Book Appointment",
                          fontSize: 16,
                          height: 35,
                          width: 200,
                          onClick: () {
                            // getCustomerBooking();
                            // Navigator.pop(context);
                            // if (_site != Branch.None) {
                            //   print(_site);
                            // }
                            // GetServicesByBranch().getServicesByBranch("1");
                          },
                        ),
                        CustomButton(
                          text: "Cancel",
                          fontSize: 16,
                          height: 35,
                          width: 100,
                          onClick: () {
                            print("object sss");
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertCancelBooking();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkBoxServicesContainer() => ExpandableNotifier(
        child: Column(
          children: [
            ScrollOnExpand(
              child: ExpandablePanel(
                controller: _expandableController,
                // isExpanded:
                theme: ExpandableThemeData(
                  hasIcon: false,
                ),
                header: TextButton(
                  child: ListTile(
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Services/Membership',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700,
                          // color: Constants.darkPrimary,
                        ),
                      ),
                    ),
                    trailing: _expandableController.expanded
                        ? Icon(
                            Icons.keyboard_arrow_down,
                            size: 40,
                          )
                        : Icon(
                            Icons.keyboard_arrow_right,
                            size: 40,
                          ),
                  ),
                  onPressed: () {
                    setState(() {
                      _expandableController2.expanded = false;
                      _expandableController.expanded =
                          !_expandableController.expanded;
                    });
                  },
                ),

                //CONTENT EXPANDED
                expanded: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: [
                          for (int i = 0; i < widget.branchServices.length; i++)
                            Container(
                              // color: Colors.amber,
                              child: checkBoxBuild(
                                  widget.branchServices[i]['label'],
                                  widget.branchServices[i]['code'],
                                  i,
                                  widget.branchServices[i]['duration'],
                                  widget.branchServices[i]),
                            ),
                        ],
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
          ],
        ),
      );

  Widget checkBoxEstheticians() => ExpandableNotifier(
        child: Column(
          children: [
            ScrollOnExpand(
              child: ExpandablePanel(
                controller: _expandableController2,
                // isExpanded:
                theme: ExpandableThemeData(
                  hasIcon: false,
                ),
                header: TextButton(
                  child: ListTile(
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Specialist',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700,
                          // color: Constants.darkPrimary,
                        ),
                      ),
                    ),
                    trailing: _expandableController2.expanded
                        ? Icon(
                            Icons.keyboard_arrow_down,
                            size: 40,
                          )
                        : Icon(
                            Icons.keyboard_arrow_right,
                            size: 40,
                          ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (allEst != null) {
                        _expandableController.expanded = false;
                        _expandableController2.expanded =
                            !_expandableController2.expanded;
                      }
                    });
                  },
                ),

                //CONTENT EXPANDED
                expanded: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      allEst != null
                          ? Column(
                              children: [
                                for (int i = 0; i < allEst!.data.length; i++)
                                  Container(
                                    // color: Colors.amber,
                                    child: checkBoxBuildEst(
                                      allEst!.data[i].name,
                                      allEst!.data[i].id,
                                      i,
                                    ),
                                  ),
                              ],
                            )
                          : Container()
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
          ],
        ),
      );

  Widget checkBoxTimeSelect() => ExpandableNotifier(
        child: Column(
          children: [
            ScrollOnExpand(
              child: ExpandablePanel(
                controller: _expandableController3,
                // isExpanded:
                theme: ExpandableThemeData(
                  hasIcon: false,
                ),
                header: TextButton(
                  child: ListTile(
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Time',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700,
                          // color: Constants.darkPrimary,
                        ),
                      ),
                    ),
                    trailing: _expandableController3.expanded
                        ? Icon(
                            Icons.keyboard_arrow_down,
                            size: 40,
                          )
                        : Icon(
                            Icons.keyboard_arrow_right,
                            size: 40,
                          ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (lSlotTime.data != null) {
                        _expandableController2.expanded = false;
                        _expandableController3.expanded =
                            !_expandableController3.expanded;
                      }
                    });
                  },
                ),

                //CONTENT EXPANDED
                expanded: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      lSlotTime.data != null
                          ? Column(
                              children: [
                                for (int i = 0; i < lSlotTime.data.length; i++)
                                  Container(
                                    // color: Colors.amber,
                                    child: checkBoxBuildTime(
                                      lSlotTime.data[i].from,
                                      lSlotTime.data[i].to,
                                      lSlotTime.data[i].timestamp,
                                      i,
                                    ),
                                  ),
                              ],
                            )
                          : Container()
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
          ],
        ),
      );

  Widget checkBoxRoomSelect() => ExpandableNotifier(
        child: Column(
          children: [
            ScrollOnExpand(
              child: ExpandablePanel(
                controller: _expandableController4,
                // isExpanded:
                theme: ExpandableThemeData(
                  hasIcon: false,
                ),
                header: TextButton(
                  child: ListTile(
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Room',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700,
                          // color: Constants.darkPrimary,
                        ),
                      ),
                    ),
                    trailing: _expandableController4.expanded
                        ? Icon(
                            Icons.keyboard_arrow_down,
                            size: 40,
                          )
                        : Icon(
                            Icons.keyboard_arrow_right,
                            size: 40,
                          ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (aRoom.data != null) {
                        _expandableController3.expanded = false;
                        _expandableController4.expanded =
                            !_expandableController4.expanded;
                      }
                    });
                  },
                ),

                //CONTENT EXPANDED
                expanded: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      aRoom.data != null
                          ? Column(
                              children: [
                                for (int i = 0; i < aRoom.data.length; i++)
                                  Container(
                                    // color: Colors.amber,
                                    child: checkBoxBuildRoom(
                                      aRoom.data[i].room.name,
                                      aRoom.data[i].roomId,
                                      i,
                                    ),
                                  ),
                              ],
                            )
                          : Container()
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
          ],
        ),
      );

  // bool test = false;
  Widget checkBoxBuild(
          String label, int sCode, int index, int duration, dynamic product) =>
      Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    '${label}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    // height: 20,
                    child: Transform.scale(
                      scale: .7,
                      child: Checkbox(
                          activeColor: Colors.pink.shade200,
                          value: widget.checkedValue[index],
                          onChanged: (value) {
                            setState(() {
                              print("CHECKED11111111111111111111111");
                              print(value);
                              print(sCode);
                              widget.checkedValue[index] = value!;
                              selectetServices.add(product);

                              getEstheticianData(
                                  widget.branchId,
                                  sCode.toString(),
                                  widget.dateString,
                                  duration);
                            });
                          }),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
            )
          ],
        ),
      );

  Widget checkBoxBuildEst(String label, int empId, int index) => Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    '${label}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    // height: 20,
                    child: Transform.scale(
                      scale: .7,
                      child: Checkbox(
                          activeColor: Colors.pink.shade200,
                          value: checkedValueEst[index],
                          onChanged: (value) {
                            setState(() {
                              print("CHECKED2222222222222222222222222222");
                              print(value);
                              print(empId);
                              for (int x = 0; x < checkedValueEst.length; x++) {
                                setState(() {
                                  checkedValueEst[x] = false;
                                });
                              }
                              checkedValueEst[index] = value!;

                              selectesEst = allEst!.data[index];
                              print(selectesEst.id);
                              print(selectesEst.name);
                              print(selectesEst.role);

                              getAvailableSlotTime(empId.toString());
                            });
                          }),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
            )
          ],
        ),
      );

  Widget checkBoxBuildTime(
          String label, String to, String timeStamp, int index) =>
      Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  // flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      '${label}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  // flex: 1,
                  child: Container(
                    // height: 20,
                    child: Transform.scale(
                      scale: .7,
                      child: Checkbox(
                          activeColor: Colors.pink.shade200,
                          value: checkedValueTime[index],
                          onChanged: (value) {
                            setState(() {
                              print("CHECKED3333333333333333333333333");
                              print(value);

                              for (int x = 0;
                                  x < checkedValueTime.length;
                                  x++) {
                                setState(() {
                                  checkedValueTime[x] = false;
                                });
                              }
                              checkedValueTime[index] = value!;

                              getAvailableRoom(timeStamp);
                            });
                          }),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
            )
          ],
        ),
      );

  Widget checkBoxBuildRoom(String label, int roomId, int index) => Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  // flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                      '${label}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  // flex: 1,
                  child: Container(
                    // height: 20,
                    child: Transform.scale(
                      scale: .7,
                      child: Checkbox(
                          activeColor: Colors.pink.shade200,
                          value: checkedValueRoom[index],
                          onChanged: (value) {
                            setState(() {
                              print("CHECKED444444444444444444444444444");
                              print(value);

                              for (int x = 0;
                                  x < checkedValueRoom.length;
                                  x++) {
                                setState(() {
                                  checkedValueRoom[x] = false;
                                });
                              }
                              checkedValueRoom[index] = value!;

                              // getAvailableRoom(timeStamp);
                            });
                          }),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
            )
          ],
        ),
      );

  Future<void> getEstheticianData(
      String brId, String serviceCode, DateTime caldate, int duration) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(caldate);
    EstheticianListModel est = await GetEstheticianList()
        .getEstheticianList(brId, serviceCode, formattedDate);
    setState(() {
      allEst = est;
      if (checkedValueEst.isNotEmpty) {
        checkedValueEst = [];
      }
      calDateG = formattedDate;
      durationTime = duration.toString();
      brIdG = brId;
      serviceCodeG = serviceCode;
    });
    for (int j = 0; j < allEst!.data.length; j++) {
      setState(() {
        checkedValueEst.add(false);
      });
    }
  }

  String calDateG = '';
  String durationTime = '';
  String brIdG = '';
  String serviceCodeG = '';
  late SlotTimeModel lSlotTime = new SlotTimeModel();
  late AvailableRoomModel aRoom = new AvailableRoomModel();
  Future<void> getAvailableSlotTime(
    String empId,
  ) async {
    print("AAAAAAAAA XXXXX VVVVVVVVVVVVVVVV");
    lSlotTime = await GetSlotTime()
        .getSlotTime(calDateG, empId, durationTime, brIdG, serviceCodeG);
    print(calDateG);
    print(durationTime);
    print(brIdG);
    print(serviceCodeG);
    print(empId);

    print("AAAAAAAAA XXXXX XCXCXCXCXCXCXCX");
    print(lSlotTime.data.length);
    setState(() {
      if (checkedValueTime.isNotEmpty) {
        checkedValueTime = [];
      }
    });
    for (int k = 0; k < lSlotTime.data.length; k++) {
      print(lSlotTime.data[k].from);
      setState(() {
        checkedValueTime.add(false);
      });
    }
  }

  Future<void> getAvailableRoom(String tStamp) async {
    print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC");
    aRoom = await GetAvailableRoom()
        .getAvailableRoom(serviceCodeG, calDateG, tStamp, durationTime, brIdG);
    print(serviceCodeG);
    print(calDateG);
    print(tStamp);
    print(durationTime);
    print(brIdG);

    print("LLLPLPLPLPLLPLPLPLPPLPLPLPLPLPLPLPLP");
    print(aRoom.data.length);
    setState(() {
      if (checkedValueRoom.isNotEmpty) {
        checkedValueRoom = [];
      }
    });
    for (int k = 0; k < aRoom.data.length; k++) {
      setState(() {
        checkedValueRoom.add(false);
      });
    }
    print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    print(checkedValueRoom.length);
  }
}
