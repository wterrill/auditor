import 'package:flutter/material.dart';

// final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child: TextTest(),
//         ),
//       ),
//     );
//   }
// }

// class TextTest extends StatelessWidget {
//    TextEditingController controller = TextEditingController();
//   bool setColor = false;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(height: 100, width: 300,color: setColor?Colors.blue: Colors.red),
//         Container(
//     child: TextField(
//     controller: controller,
//         onChanged: (value) {
//           if(value.length > 2){
//             setState(() {
//               setColor = true;
//             });

//           }
//         }))]);
// }
// }

class TextTest extends StatefulWidget {
  TextTest({Key key}) : super(key: key);

  @override
  _TextTestState createState() => _TextTestState();
}

class _TextTestState extends State<TextTest> {
  TextEditingController controller = TextEditingController();
  bool setColor = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(height: 100, width: 300, color: setColor ? Colors.blue : Colors.red)),
          Container(
              child: TextField(
                  enableInteractiveSelection: true,
                  controller: controller,
                  onChanged: (value) {
                    if (value.length > 2) {
                      setState(() {
                        setColor = true;
                      });
                    }
                    if (value.length < 2) {
                      setState(() {
                        setColor = false;
                      });
                    }
                  }))
        ]),
      ),
    );
  }
}
