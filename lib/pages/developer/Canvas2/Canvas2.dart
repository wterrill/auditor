import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/animation.dart';

class MyPainter2 extends StatefulWidget {
  MyPainter2({Key key}) : super(key: key);

  @override
  _MyPainter2State createState() => _MyPainter2State();
}

Color getRandomColor(Random rgn) {
  var a = rgn.nextInt(255);
  var r = rgn.nextInt(255);
  var g = rgn.nextInt(255);
  var b = rgn.nextInt(255);
  return Color.fromARGB(a, r, g, b);
}

double maxRadius = 6;
double maxSpeed = 0.2;
double maxTheta = 2.0 * pi;

class _MyPainter2State extends State<MyPainter2> with SingleTickerProviderStateMixin {
  List<Particle> particles;
  Animation<double> animation;
  AnimationController controller;

  Random rgn = Random(DateTime.now().microsecondsSinceEpoch);
  @override
  void initState() {
    super.initState();
    this.particles = List.generate(200, (index) {
      var p = Particle();
      p.color = getRandomColor(rgn);
      p.position = Offset(-1, -1);
      p.speed = rgn.nextDouble() * maxSpeed; // 0 -> 0.2
      p.theta = rgn.nextDouble() * maxTheta; // 0->2pi radians
      p.radius = rgn.nextDouble() * maxRadius;
      return p;
    });

    controller = AnimationController(vsync: this, duration: Duration(seconds: 10));
    animation = Tween<double>(begin: 0, end: 500).animate(controller)
      ..addListener(() {
        setState(() {
          print(animation.value);
        });
      })
      ..addStatusListener((status) {
        print(status.toString());
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addStatusListener((state) => print('state: $state'));
    controller.forward;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (this.particles == null) {
    //   initialize();
    // }
    return Scaffold(
        appBar: AppBar(),
        body: CustomPaint(
            painter: MyPainter2Canvas(particles: particles, rgn: rgn, animValue: animation.value),
            child: Container(color: Colors.white38)));
  }
}

Offset PolarToCartesian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

class MyPainter2Canvas extends CustomPainter {
  Random rgn; // = Random(DateTime.now().microsecondsSinceEpoch);
  List<Particle> particles;
  double animValue;

  MyPainter2Canvas({this.particles, this.rgn, this.animValue});

  @override
  void paint(Canvas canvas, Size size) {
    // update the objects
    this.particles.forEach((p) {
      var velocity = PolarToCartesian(p.speed, p.theta);
      var dx = p.position.dx + velocity.dx * animValue;
      var dy = p.position.dy + velocity.dy * animValue;
      //if either position falls outside the canvas, reinitialize them
      if (p.position.dx < 0 || p.position.dx > size.width) {
        dx = rgn.nextDouble() * size.width;
      }
      if (p.position.dy < 0 || p.position.dy > size.height) {
        dy = rgn.nextDouble() * size.height;
      }
      p.position = Offset(dx, dy);
    });
    // paint the objects
    this.particles.forEach((p) {
      var paint = Paint();
      paint.color = Colors.red;
      canvas.drawCircle(p.position, p.radius, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter o) {
    return true;
  }
}

//////////////////////////////////////////
class Particle {
  Offset position;
  Color color;
  double speed;
  double theta;
  double radius;
}
