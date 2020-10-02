import 'package:flutter/material.dart';

// https://blog.gskinner.com/archives/2020/09/flutter-tricks-widget-size-position.html

class ContextUtils {
  // Takes a key, and in 1 frame, returns the size of the context attached to the key
  static void getFutureSizeFromGlobalKey(GlobalKey key, Function(Size size) callback) {
    Future.microtask(() {
      Size size = getSizeFromContext(key.currentContext);
      if (size != null) {
        callback(size);
      }
    });
  }

  // Shortcut to get the renderBox size from a context
  static Size getSizeFromContext(BuildContext context) {
    RenderBox rb = context.findRenderObject() as RenderBox;
    return rb?.size ?? Size.zero;
  }

  // Shortcut to get the global position of a context
  static Offset getOffsetFromContext(BuildContext context, [Offset offset = null]) {
    RenderBox rb = context.findRenderObject() as RenderBox;
    return rb?.localToGlobal(offset ?? Offset.zero);
  }
}

class BiggerOne extends StatelessWidget {
  const BiggerOne({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: SizedBox(
          width: 300,
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.blue,
              width: 200,
              height: 320,
              child: WidgetSizeAndPosition(),
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetSizeAndPosition extends StatelessWidget {
  const WidgetSizeAndPosition({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size bigSize = MediaQuery.of(context).size;
    print('bigSize: $bigSize');
    Size size = ContextUtils.getSizeFromContext(context);
    print('getSizeFromContext: $size');
    Offset offset = ContextUtils.getOffsetFromContext(context);
    print('offset: $offset');

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 300,
        width: 200,
        child: Column(
          children: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(height: 50, width: 100, color: Colors.green, child: Center(child: Text("pop()")))),
            Container(child: Text('size: ${size.toString()}')),
            Container(child: Text('offset: ${offset.toString()}')),
          ],
        ),
      ),
    );
  }
}
