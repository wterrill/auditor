import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/pages/LoginScreen/LoginScreen.dart';
import 'package:auditor/pages/developer/DeveloperMenu.dart';
// import 'package:auditor/providers/AuditData.dart';
import 'package:auditor/providers/GeneralData.dart';
import 'package:auditor/providers/ListCalendarData.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopWhiteHeaderWidget extends StatefulWidget {
  const TopWhiteHeaderWidget({Key key}) : super(key: key);

  @override
  _TopWhiteHeaderWidgetState createState() => _TopWhiteHeaderWidgetState();
}

class _TopWhiteHeaderWidgetState extends State<TopWhiteHeaderWidget> {
  final filterTextController = TextEditingController();
  void dispose() {
    // Clean up the controller when the widget is disposed.
    filterTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String portNumber = Provider.of<GeneralData>(context).portNumber;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        // Top header (white)
        height: 70,

        width: MediaQuery.of(context).size.width,
        color: ColorDefs.colorTopHeader,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
              child: Hero(
                tag: "GCFD_Logo",
                child: Image(
                  image: AssetImage('assets/images/GCFD_Logo.png'),
                ),
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0), shape: BoxShape.rectangle, boxShadow: [
                BoxShadow(
                  color: Color(0x55555555),
                  offset: const Offset(5.0, 5.0),
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                ),
              ]),
              height: 40,
              width: 350,
              child: TextField(
                enableInteractiveSelection: true,
                // autofocus: true,
                onChanged: (text) {
                  if (text.toLowerCase() == "version") {
                    Dialogs.showVersionDialog(context);
                  }
                  if (text.toLowerCase() == "download") {
                    Provider.of<GeneralData>(context, listen: false).toggleShowTopDrawer();
                  }
                  if (text.toLowerCase() == "developer") {
                    Navigator.of(context).pop();
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(builder: (context) => DeveloperMenu()),
                    );
                  }
                  Provider.of<ListCalendarData>(context, listen: false).updateFilterValue(filterTextController.text);
                },
                controller: filterTextController,
                style: ColorDefs.textBodyBlack20,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: ColorDefs.colorLogoLightGreen,
                        width: 2.0,
                      ),
                    ),
                    // suffixIcon: IconButton(
                    //   onPressed: () {
                    //     filterTextController.clear();
                    //     Provider.of<ListCalendarData>(context, listen: false)
                    //         .updateFilterValue(filterTextController.text);
                    //   },
                    //   icon: Icon(Icons.clear),
                    // ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                      child: FaIcon(
                        FontAwesomeIcons.search,
                        color: ColorDefs.colorLogoLightGreen,
                        // size: 50.0,
                      ),
                    ),
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                    filled: true,
                    fillColor: portNumber == "88" ? Colors.white : Colors.red,
                    hintText: 'Agency / Program Number Filter'),
              ),
            ),
            if (portNumber == "90") Text("TEST TEST", style: ColorDefs.textRedTest),

            // if (Provider.of<GeneralData>(context, listen: true).syncInProgress) CircularProgressIndicator(),
            // if (Provider.of<GeneralData>(context, listen: true).syncInProgress)
            //   Text(
            //     Provider.of<GeneralData>(context).syncMessage,
            //     style: ColorDefs.textBodyBlack10,
            //   ),
            PopupMenuButton<String>(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
                child: Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: ColorDefs.colorUserAccent, width: 1.0),
                  //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  // ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                        child: Container(
                          child: FaIcon(
                            FontAwesomeIcons.userAlt,
                            color: ColorDefs.colorLogoLightGreen,
                            size: 45.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          Provider.of<GeneralData>(context, listen: false).username ?? "generic login",
                          style: ColorDefs.textBodyBlack20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              elevation: 16,
              offset: Offset(0, 90),
              onSelected: (dynamic result) {
                Provider.of<GeneralData>(context, listen: false).setRememberMe(false);
                Navigator.of(context).pop();
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(builder: (context) => LoginScreen()),
                );
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: "logout",
                  child: Text('Logout'),
                ),
              ],
            ),
            //)
          ],
        ),
      ),
    );
  }
}
