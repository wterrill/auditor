// import 'package:auto_size_text/auto_size_text.dart';
import 'package:auditor/Utilities/FlatButtonToTextButton.dart';
import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/communications/Comms.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/pages/ListSchedulingPage/ListSchedulingPage.dart';
import 'package:provider/provider.dart';
import 'package:auditor/providers/GeneralData.dart';

import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity/connectivity.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

// keys for testing:
// password
// username
// login
// eyeball
// keepMeLoggedIn

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  String _username, _password;
  bool _dirtyUsername = false;
  bool _dirtyPassword = false;
  bool _enabledLoginButton = false;
  var _userController = TextEditingController();
  var _passwordController = TextEditingController();
  // bool rememberMeCheckedValue;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(horizontal: .2 * Provider.of<GeneralData>(context).mediaArea.width),
      color: ColorDefs.colorTopHeader,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(height: 20),
            Container(
              height: 150,
              child: Hero(
                tag: "GCFD_Logo",
                child: Image(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/GCFD_Logo.png'),
                ),
              ),
            ),
            Container(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                child: Text(
                  //AutoSizeText
                  "Welcome!",
                  //

                  style: ColorDefs.textGreenLogoLight30,
                  // maxLines: 1,
                  // minFontSize: 5,
                ),
              ),
            ),
            Container(height: 30),
            // Container(
            //     margin: EdgeInsets.fromLTRB(30, 0, 0, 10),
            //     width: double.infinity,
            //     child: Align(
            //         alignment: Alignment.centerLeft,
            //         child: Text("Username", style: ColorDefs.textBodyBlack20))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 70,
                child: TextFormField(
                  key: Key('username'),
                  controller: _userController,
                  onChanged: (input) => _onChangeField(input: input, from: "username"),
                  // validator: (input) => !input.contains('@')
                  //     ? "make sure your username has a '@'"
                  //     : null,
                  onSaved: (input) => _username = input,
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
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: "User Name",
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                    labelStyle: ColorDefs.textBodyBlack20,
                  ),
                ),
              ),
            ),
            Container(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 70,
                child: TextFormField(
                  key: Key('password'),
                  controller: _passwordController,
                  onChanged: (input) => _onChangeField(input: input, from: "password"),
                  validator: (input) => input.length < 1 ? "your password requires at least 6 characters" : null,
                  onSaved: (input) => _password = input,
                  obscureText: _obscureText,
                  style: ColorDefs.textBodyBlack20,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: "Password (Case Sensitive)",
                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
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
                    suffixIcon: GestureDetector(
                      key: Key('eyeball'),
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                        print(_obscureText);
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 12.0),
                        child: _obscureText
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(0, 13.0, 0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.eye, //icon.visibility,
                                  color: ColorDefs.colorDarkBackground,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(0, 13.0, 0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.eyeSlash, //icon.visibility,
                                  color: ColorDefs.colorDarkBackground,
                                ),
                              ),
                      ),
                    ),
                    // filled: true,
                    // fillColor: ColorDefs.colorLoginBackground,
                    // labelText: 'Password',
                    labelStyle: ColorDefs.textBodyBlack10,
                  ),
                ),
              ),
            ),
            Container(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                height: 50,
                child:
                    // TextButton(
                    //   style: ButtonStyle(
                    //       foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    //         // text color
                    //         (Set<MaterialState> states) =>
                    //             states.contains(MaterialState.disabled) ? Colors.white : Colors.white,
                    //       ),
                    //       backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    //         // background color
                    //         (Set<MaterialState> states) =>
                    //             states.contains(MaterialState.disabled) ? Colors.grey : Colors.green,
                    //       ),
                    //       shape:
                    //           MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)))),
                    //   key: Key('login'),
                    //   onPressed: _enabledLoginButton ? _submit : null,
                    //   child: Text(
                    //     'Log In',
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // ),
                    //
                    FlatButtonX(
                  keyx: Key('login'),
                  colorx: Colors.green,
                  textColorx: Colors.black,
                  disabledColorx: Colors.grey,
                  disabledTextColorx: Colors.white,
                  shapex: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                  onPressedx: _enabledLoginButton ? _submit : null,
                  childx: Text(
                    'Log In',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Container(height: 10),
            Theme(
              data: ThemeData(brightness: Brightness.light),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CheckboxListTile(
                  key: Key('keepMeLoggedIn'),
                  title: Text("Keep me logged in", style: TextStyle(color: ColorDefs.colorLogoDarkGreen)),
                  value: Provider.of<GeneralData>(context, listen: false).rememberMe,
                  onChanged: (newValue) {
                    setState(() {
                      Provider.of<GeneralData>(context, listen: false).setRememberMe(newValue);
                    });
                  },

                  controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
            ),

            Container(height: 20)
          ]),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_username);
      print(_password);
      Dialogs.showAlertDialog(context);
      bool isAuthenticated = false;
      bool isError = false;
      String errorString = "";
      try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
          // I am connected to a mobile network. or a wifi network
          print("######### CONNECTED Auth #########");
        } else {
          throw ("No internet connection found");
        }
        if (_username.toLowerCase().contains("mxotestaud1")) {
          // This opens the app in TEST mode for an mxotestaud1 account"
          Provider.of<GeneralData>(context, listen: false).portNumber = "90";
        }

        isAuthenticated = await Authentication.authenticate(username: _username, password: _password, context: context);
        Provider.of<GeneralData>(context, listen: false).saveUsername(_username);
      } catch (error) {
        print(error);
        isAuthenticated = false;
        isError = true;
        errorString = error.toString();
      }

      if (isAuthenticated) {
        Provider.of<GeneralData>(context, listen: false).username = _username;
        Navigator.push(
          context,
          PageRouteBuilder<void>(
            transitionDuration: Duration(seconds: 2),
            pageBuilder: (_, __, ___) => //StatsFl(
                ListSchedulingPage(),
            // ),
          ),
        );
      } else {
        Provider.of<GeneralData>(context, listen: false).saveUsername("");
        Navigator.of(context).pop();
        if (!isError) {
          Dialogs.failedAuthentication(context);
        } else {
          Dialogs.failedAuthenticationWithError(context, errorString);
        }
      }
    }
  }

  void _onChangeField({@required String input, @required String from}) {
    if (input == "version") {
      Dialogs.showVersionDialog(context);
      return;
    }

    if (input == "developer") {
      Dialogs.showDeveloperMenu(context);
      return;
    }

    if (from == "username") if (input.length > 1) {
      _dirtyUsername = true;
    } else {
      _dirtyUsername = false;
    }

    if (from == "password") if (input.length > 1) {
      _dirtyPassword = true;
    } else {
      _dirtyPassword = false;
    }

    bool bothDirtyAndNotEnabled = _dirtyUsername && _dirtyPassword && !_enabledLoginButton;
    bool enabledButOnlyOneIsDirty = _enabledLoginButton && (!_dirtyUsername || !_dirtyPassword);
    if (bothDirtyAndNotEnabled) {
      setState(() {
        _enabledLoginButton = true;
      });
    }
    if (enabledButOnlyOneIsDirty) {
      setState(() {
        _enabledLoginButton = false;
      });
    }
  }
}
