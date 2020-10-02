import 'package:flutter/material.dart';
import 'dart:math';

import 'GameDefs.dart';

class Apple {
  int position;
  Color color;
  List<Color> colors = [Colors.red, Colors.green, Colors.yellow];
  Apple() {
    Random random = new Random();
    position = random.nextInt(GameDefs().itemCount);
    color = colors[random.nextInt(3)];
  }

  int getPosition() {
    return position;
  }

  Color getColor() {
    return color;
  }
}
