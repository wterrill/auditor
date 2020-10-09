import 'package:auditor/Definitions/AuditClasses/Audit.dart';
import 'package:auditor/Definitions/Dialogs.dart';
import 'package:auditor/Definitions/colorDefs.dart';
import 'package:auditor/providers/AuditData.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:io';
import 'dart:typed_data';
// import 'package:photo_view/photo_view.dart';
// import 'dart:async';
// import 'package:flutter_appavailability/flutter_appavailability.dart';
// import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key key, this.activeAudit}) : super(key: key);
  final Audit activeAudit;

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  Uint8List pickedImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              child: RaisedButton(
                color: ColorDefs.colorAudit1,
                onPressed: () async {
                  final picker = ImagePicker();
                  try {
                    PickedFile fromPicker = await picker.getImage(source: ImageSource.gallery);
                    pickedImage = await fromPicker.readAsBytes();
                    widget.activeAudit.photoList.add(pickedImage);
                    setState(() {});
                    print(widget.activeAudit.photoList.length);
                    Provider.of<AuditData>(context, listen: false).saveActiveAudit();
                  } catch (err) {}
                },
                child: Text("Add picture", style: ColorDefs.textBodyWhite20),
              ),
            ),
            // Container(
            //   child: RaisedButton(
            //     color: ColorDefs.colorAudit3,
            //     onPressed: () async {
            //       dynamic cameras = await availableCameras();

            //       AppAvailability.launchApp("com.apple.avfoundation.avcapturedevice.built-in_video").then((_) {
            //         print("launched");
            //       }).catchError((dynamic err) {
            //         Scaffold.of(context).showSnackBar(
            //             SnackBar(content: Container(height: 40, child: Center(child: Text("Camera App not found!")))));
            //         print(err);
            //       });
            //     },
            //     child: Text("Launch Camera", style: ColorDefs.textBodyWhite20),
            //   ),
            // ),
            GridView.builder(
              shrinkWrap: true,
              primary: false,

              itemCount: widget.activeAudit.photoList?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 10.0), //(orientation == Orientation.portrait) ? 2 : 3),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: LimitedBox(
                      maxHeight: 50.0,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 2.0, color: Colors.lightBlue.shade900),
                          )),
                          child: GestureDetector(
                            onTap: () {
                              Dialogs.showPicture(
                                  context: context,
                                  image: widget.activeAudit.photoList[index].buffer.asUint8List(),
                                  dismissable: true);
                            },
                            onLongPress: () {
                              Dialogs.showDeletePic(context, index);
                            },
                            child: Image.memory(widget.activeAudit.photoList[index].buffer.asUint8List()),
                          ))),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
