import 'package:auditor/Utilities/FlatButtonToTextButton.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
// import 'package:universal_html/html.dart';

class ClayContainerEx extends StatefulWidget {
  @override
  _ClayContainerExState createState() => _ClayContainerExState();
}

class _ClayContainerExState extends State<ClayContainerEx> with SingleTickerProviderStateMixin {
  Color baseColor = Color(0xFFf2f2f2);
  double firstDepth = 50;
  double secondDepth = 50;
  double thirdDepth = 50;
  double fourthDepth = 50;
  AnimationController _animationController;
  bool animationToggle = true;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleAnimation() {
    animationToggle = !animationToggle;
  }

  @override
  Widget build(BuildContext context) {
    if (animationToggle == true) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    double stagger(double value, double progress, double delay) {
      progress = progress - (1 - delay);
      if (progress < 0) progress = 0;
      return value * (progress / delay);
    }

    double calculatedFirstDepth = stagger(firstDepth, _animationController.value, 0.25);
    double calculatedSecondDepth = stagger(secondDepth, _animationController.value, 0.5);
    double calculatedThirdDepth = stagger(thirdDepth, _animationController.value, 0.75);
    double calculatedFourthDepth = stagger(fourthDepth, _animationController.value, 1);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        FlatButtonX(
          colorx: Colors.blue,
          textColorx: Colors.black,
          childx: Text(
            "Back",
            style: TextStyle(color: Colors.black),
          ),
          onPressedx: () {
            Navigator.of(context).pop();
          },
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              print(animationToggle);
              print("tapped");
              toggleAnimation();
              setState(() {});
            },
            child: Container(
              color: baseColor,
              child: Center(
                child: ClayContainer(
                  color: baseColor,
                  height: 240,
                  width: 240,
                  borderRadius: 200,
                  curveType: CurveType.concave,
                  spread: 30,
                  depth: calculatedFirstDepth.toInt(),
                  child: Center(
                    child: ClayContainer(
                      height: 200,
                      width: 200,
                      borderRadius: 200,
                      depth: calculatedSecondDepth.toInt(),
                      curveType: CurveType.convex,
                      color: baseColor,
                      child: Center(
                        child: ClayContainer(
                            height: 160,
                            width: 160,
                            borderRadius: 200,
                            color: baseColor,
                            depth: calculatedThirdDepth.toInt(),
                            curveType: CurveType.concave,
                            child: Center(
                                child: ClayContainer(
                              height: 120,
                              width: 120,
                              borderRadius: 200,
                              color: baseColor,
                              depth: calculatedFourthDepth.toInt(),
                              curveType: CurveType.convex,
                            ))),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
