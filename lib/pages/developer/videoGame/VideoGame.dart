import 'package:flutter/services.dart';

import 'Apple.dart';
import 'GameDefs.dart';
import 'Snake.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class VideoGame extends StatefulWidget {
  VideoGame({Key key}) : super(key: key);

  @override
  _VideoGameState createState() => _VideoGameState();
}

class _VideoGameState extends State<VideoGame> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      // getKeystroke();
      if (kill) {
        timer.cancel();
      }
      updateSnake();
      updateApple();
      setState(() {});
    });
  }

  bool kill = false;
  FocusNode focusNode = FocusNode();
  String direction = "right";
  Apple apple = Apple();
  Snake snake = Snake();
  GameDefs gameDefs = GameDefs();
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return WillPopScope(
      onWillPop: () {
        print(
            'Backbutton pressed (device or appbar button), do whatever you want.');
        kill = true;
        //trigger leaving and use own data
        Navigator.pop(context, false);

        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: RawKeyboardListener(
          autofocus: true,
          focusNode: focusNode,
          onKey: (RawKeyEvent event) {
            getKeystroke(event.data.logicalKey);
          },
          child: GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx.abs() > details.delta.dy.abs()) {
                if (details.delta.dx > 0) {
                  print("Dragging in +X direction");
                  direction = "right";
                } else {
                  print("Dragging in -X direction");
                  direction = "left";
                }
              } else {
                if (details.delta.dy > 0) {
                  print("Dragging in +Y direction");
                  direction = "down";
                } else {
                  print("Dragging in -Y direction");
                  direction = "up";
                }
              }
            },
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: gameDefs.itemCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gameDefs.crossAxisCount),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.all(5.0),
                    color: Colors.grey,
                    child: getPixels(index));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getPixels(int index) {
    Widget finalPixel;
    List<int> snakeBody = snake.getSnake();
    // int applePos = apple.Position();
    if (snakeBody.contains(index)) {
      finalPixel = Container(color: snake.getColor());
    } else if (apple.getPosition() == index) {
      finalPixel = Container(color: apple.getColor());
    }
    return finalPixel;
  }

  void updateSnake() {
    bool eating = checkEating();

    if (direction == "right") {
      snake.snakeTick(1, eating);
    }
    if (direction == "left") {
      snake.snakeTick(-1, eating);
    }
    if (direction == "up") {
      snake.snakeTick(-1 * gameDefs.crossAxisCount, eating);
    }
    if (direction == "down") {
      snake.snakeTick(gameDefs.crossAxisCount, eating);
    }
  }

  void getKeystroke(LogicalKeyboardKey keypress) {
    if (keypress == LogicalKeyboardKey.arrowDown) {
      direction = "down";
    }
    if (keypress == LogicalKeyboardKey.arrowLeft) {
      direction = "left";
    }
    if (keypress == LogicalKeyboardKey.arrowRight) {
      direction = "right";
    }
    if (keypress == LogicalKeyboardKey.arrowUp) {
      direction = "up";
    }
  }

  void updateApple() {
    if (apple == null) {
      apple = Apple();
    }
  }

  bool checkEating() {
    if (snake.getHead() == apple.getPosition()) {
      apple = null;
      return true;
    } else
      return false;
  }
}
