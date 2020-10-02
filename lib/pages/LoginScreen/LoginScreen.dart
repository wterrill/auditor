import 'package:flutter/material.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'LoginForm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // color: ColorDefs.colorDarkBackground,

        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              ColorDefs.colorLogoDarkGreen,
              ColorDefs.colorLogoDarkGreen,
              ColorDefs.colorLogoLightGreen
            ])),
        child: LayoutBuilder(
            builder: (context, constraints) => Column(
                  children: <Widget>[
                    SizedBox(
                      height: (constraints.minHeight) * 0.15,
                    ),
                    LoginForm()
                  ],
                )),
      ),
    );
  }
}
