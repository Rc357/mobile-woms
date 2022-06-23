import 'package:app/constants/constants.dart';
import 'package:app/model/event.dart';
import 'package:app/model/model_service_card.dart';
import 'package:app/views/screens/scr_calendar/components/utils.dart';
import 'package:app/views/screens/scr_home/timer_scr.dart';
import 'package:app/widgets/service_card/ser_card.dart';
import 'package:app/widgets/wid_date.dart';
import 'package:flutter/material.dart';

class ReviewData extends StatefulWidget {
  final Event? event;
  const ReviewData({Key? key, this.event}) : super(key: key);

  @override
  _ReviewDataState createState() => _ReviewDataState();
}

class _ReviewDataState extends State<ReviewData> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlServiceType = TextEditingController();
  final _ctrlClientName = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  CardItem? service;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _ctrlServiceType.dispose();
    _ctrlClientName.dispose();
    super.dispose();
  }

  void selectData(CardItem selItem) {
    setState(() {
      service = selItem;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Add Session Informations"),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // actions: buildEditingAction(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: Container(
                    height: .8 * MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.shade100,
                          blurRadius: 4,
                          offset: Offset(2, 4), // Shadow position
                        ),
                      ],
                    ),
                    // color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          buildDateToday(),
                          SizedBox(
                            height: .05 * MediaQuery.of(context).size.height,
                          ),

                          buildLabel("Type of Service:"),
                          SizedBox(
                            height: 10,
                          ),
                          TypeOfServiceCard(
                            selectedData: selectData,
                          ),

                          // buildTitle(),
                          // SizedBox(
                          //   height: .04 * MediaQuery.of(context).size.height,
                          // ),
                          SizedBox(
                            height: 40,
                          ),
                          buildLabel("Name of Client:"),
                          buildClientName(),
                          SizedBox(
                            height: .02 * MediaQuery.of(context).size.height,
                          ),
                          // buildFormDateTimePicker(),
                          Expanded(
                            child: Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: SizedBox(
                                width: .5 * MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() &&
                                        service != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TimerScreen(
                                                  serviceType: service!.title,
                                                  clientName:
                                                      _ctrlClientName.text,
                                                  estheticians:
                                                      Constants.USER_NAME,
                                                  fromDate: fromDate,
                                                  startDateTime:
                                                      DateTime.now())));
                                    }
                                  },
                                  child: Text("START"),
                                  style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                      primary: Colors.pink
                                          .shade300, //background color of button
                                      side: BorderSide(
                                          width: 1, color: Colors.pink),
                                      padding: EdgeInsets.all(20)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: .02 * MediaQuery.of(context).size.height,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      );

  Widget buildLabel(String label) => Container(
        alignment: Alignment.center,
        child: Text(
          "$label",
          style: TextStyle(
              fontSize: 20,
              color: Colors.pink.shade900,
              fontWeight: FontWeight.normal),
        ),
      );

  Widget buildDateToday() => Container(
      child: BuildDateDisplay().buildDate(context, Utils.toDate(fromDate)));

  Widget buildTitle() => Container(
        width: .8 * MediaQuery.of(context).size.width,
        child: TextFormField(
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pink.shade200),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pink.shade900),
              ),
              border: UnderlineInputBorder(),
              hintText: "Service Type"),
          onFieldSubmitted: (_) {},
          controller: _ctrlServiceType,
          validator: (value) => value != null && value.isEmpty
              ? "Service type cannot be empty"
              : null,
        ),
      );

  Widget buildClientName() => Container(
        width: .8 * MediaQuery.of(context).size.width,
        child: TextFormField(
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pink.shade200),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pink.shade900),
              ),
              border: UnderlineInputBorder(),
              hintText: "Client's Name"),
          onFieldSubmitted: (_) {},
          controller: _ctrlClientName,
          validator: (value) => value != null && value.isEmpty
              ? "Client name cannot be empty"
              : null,
        ),
      );
}
