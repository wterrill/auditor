// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class PDFScreen extends StatefulWidget {
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String pathPDF = "";

  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    var documentDirectory = await getApplicationDocumentsDirectory();
    var filePathAndName = documentDirectory.path + '/pdfs/example.pdf';

    setState(() {
      this.pathPDF = filePathAndName;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pathPDF == "") {
      // This is what we show while we're loading
      return Container(color: Colors.purple);
    } else {
      return PDFViewerScaffold(
          appBar: AppBar(
            title: Text("Document"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),
          path: pathPDF);
    }
  }
}

// if(kIsWeb){
//     print("in web section");
//   Provider.of<WebData>(context).pdfFile = doc.save();
//   } else {
