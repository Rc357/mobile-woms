import 'package:app/views/pages/customer/cus_add_appointment_page.dart';
import 'package:app/widgets/wid_button.dart';
import 'package:flutter/material.dart';

class SelectBranch extends StatefulWidget {
  final DateTime dateString;
  final String branchId;
  final List<dynamic> branchServices;

  const SelectBranch(
      {Key? key,
      required this.dateString,
      required this.branchId,
      required this.branchServices})
      : super(key: key);
  @override
  State<SelectBranch> createState() => _SelectBranchState();
}

enum Branch { None, Airmont, BoroughPark }

class _SelectBranchState extends State<SelectBranch> {
  String? selected = "None";
  Branch _site = Branch.None;

  // List<dynamic> branchServices = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      // title: Image.asset('assets/temp_profile.png'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Add an appointment?',
              style: TextStyle(
                fontFamily: 'roboto',
                color: Colors.pink.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Branch selected: ',
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
          Column(
            children: [
              SizedBox(
                child: ListTile(
                  title:
                      Text(widget.branchId == '1' ? 'Airmont' : 'Borough Park'),
                  leading: Radio(
                    value: true,
                    groupValue: true,
                    onChanged: (bool? value) {},
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton2(
                    text: "Continue",
                    fontSize: 14,
                    height: 35,
                    width: width * .4,
                    onClick: () {
                      String siteName = "";
                      if (widget.branchId == '0') {
                        setState(() {
                          siteName = "Airmont";
                        });
                      } else {
                        setState(() {
                          siteName = "Borough Park";
                        });
                      }

                      if (widget.branchServices.length != 0) {
                        List<bool> checkedValue = [];
                        for (int j = 0; j < widget.branchServices.length; j++) {
                          checkedValue.add(false);
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerAddAppointment(
                                    checkedValue: checkedValue,
                                    dateString: widget.dateString,
                                    site: siteName,
                                    branchId: widget.branchId,
                                    branchServices: widget.branchServices)));
                      }
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    text: "Cancel",
                    fontSize: 14,
                    height: 35,
                    width: width * .4,
                    onClick: () {
                      print("object");
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
