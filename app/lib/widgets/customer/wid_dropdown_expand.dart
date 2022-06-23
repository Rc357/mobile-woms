import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class SubServicesContents extends StatefulWidget {
  @override
  _SubServicesContentsState createState() => _SubServicesContentsState();
}

class _SubServicesContentsState extends State<SubServicesContents> {
  bool selected = true;

  ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Column(
        children: [
          Divider(
            height: 1,
          ),
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
                      'HOW-TO OF THE APP',
                      style: TextStyle(
                        fontSize: 14,
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
                    Divider(
                      height: 1,
                      // color: Constants.darkGray,
                    ),
                    ListTile(
                      onTap: () {},
                      title: Text('How to search for Homes',
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(color: Colors.black)),
                    ),
                    Divider(
                      height: 1,
                      // color: Constants.darkGray,
                    ),
                    ListTile(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //       type: PageTransitionType.fade,
                        //       child: StartGettingCustomerHT(),
                        //       inheritTheme: true,
                        //       ctx: context),
                        // );
                      },
                      title: Text('How to start getting a customer',
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(color: Colors.black)),
                    ),
                    Divider(
                      height: 1,
                      // color: Constants.darkGray,
                    ),
                    ListTile(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //       type: PageTransitionType.fade,
                        //       child: ContactCustomerHT(),
                        //       inheritTheme: true,
                        //       ctx: context),
                        // );
                      },
                      title: Text('How to contact customer',
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(color: Colors.black)),
                    ),
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
            height: 1,
            // color: Constants.darkGray,
          ),
        ],
      ),
    );
  }
}
