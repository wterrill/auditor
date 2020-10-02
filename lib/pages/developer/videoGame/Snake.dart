import 'package:auditor/pages/developer/videoGame/GameDefs.dart';
import 'package:flutter/material.dart';

class Snake {
  List<int> bodyValues = [];
  Color color = Colors.green;
  GameDefs gameDefs = GameDefs();
  Snake() {
    bodyValues.add(30);
    bodyValues.add(31);
    bodyValues.add(32);
    bodyValues.add(33);
  }

  List<int> getSnake() {
    return bodyValues;
  }

  Color getColor() {
    return color;
  }

  void snakeTick(int headChange, bool eating) {
    // update bodyValue based on direction and current location.
    if (headChange.abs() < gameDefs.crossAxisCount) {
      // left or right
      if ((bodyValues.last + headChange) % gameDefs.crossAxisCount == 0 &&
          headChange > 0) {
        print('==0 ${bodyValues.last - gameDefs.crossAxisCount + headChange}');
        bodyValues.add(bodyValues.last - gameDefs.crossAxisCount + headChange);
      } else if ((bodyValues.last) % gameDefs.crossAxisCount == 0 &&
          headChange < 0) {
        print(
            '==1 ${bodyValues.last + gameDefs.crossAxisCount + headChange - 1}');
        bodyValues.add(bodyValues.last + gameDefs.crossAxisCount + headChange);
      } else {
        bodyValues.add(bodyValues.last + headChange);
      }
    } else {
      // up or down
      if (bodyValues.last + headChange < 0) {
        // wrap from top to bottom
        bodyValues.add(gameDefs.itemCount -
            (gameDefs.crossAxisCount -
                (bodyValues.last % gameDefs.crossAxisCount)));
      } else if (bodyValues.last + headChange > gameDefs.itemCount) {
        // wrap from bottom to top
        bodyValues.add(bodyValues.last % gameDefs.crossAxisCount);
      } else {
        // no wrap
        bodyValues.add(bodyValues.last + headChange);
      }
    }
    if (!eating) bodyValues.removeAt(0);
  }

  int getHead() {
    return bodyValues.last;
  }
}
