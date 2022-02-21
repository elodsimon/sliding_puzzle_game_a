import 'package:flutter/material.dart';
import 'package:sliding_puzzle_game/utils/constants.dart';

import 'game_logic.dart';

class GridBuilderGame extends StatelessWidget {
  final bool balFent = false;
  final bool jobbFent = false;
  final bool balLent = false;
  final bool jobbLent = false;
  final GameLogic game = GameLogic();

  GridBuilderGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Stack(
        children: const [
          Text('sdf')
        ], //gridBuilder(widget.width, widget.mediaQuery.size.height),
      );
    });
  }

  List<AnimatedPositioned> gridBuilder(int w, double h) {
    List<AnimatedPositioned> element = [];
    for (int i = 0; i < 16; i++) {
      // balFent = listEquals(game.gameNumbers[i], GameLogic.goodNumbers[1]);
      // jobbFent = listEquals(game.gameNumbers[i], GameLogic.goodNumbers[4]);
      // balLent = listEquals(game.gameNumbers[i], GameLogic.goodNumbers[13]);
      // jobbLent = listEquals(game.gameNumbers[i], GameLogic.goodNumbers[0]);
      element.add(gridElement(i, w, h));
    }
    return element;
  }

  AnimatedPositioned gridElement(int num, int w, double h) {
    // print(w);
    // print(GameLogic.goodNumbers);
    return AnimatedPositioned(
      curve: Curves.easeIn,
      child: gridButton(num, w, h),
      duration: const Duration(milliseconds: 500),
      top: game.gameNumbers[num]![0],
      left: game.gameNumbers[num]![1],
    );
  }

  SizedBox gridButton(int num, int w, double h) {
    double kBox = (w == 340 ? 85 : 115) - 5;
    return SizedBox(
      width: kBox,
      height: kBox,
      child: MaterialButton(
        onPressed: () {
          /* widget.numberClick(num);*/
        },
        /*color: num == 0
            ? null //Color(0XFFffcc80)
            : (widget.game.gameNumbers[num] == widget.game.goodNumbers[num]
            ? widget.colorTween.value //const Color(0xFF01509b)
            : Colors.lightBlueAccent),*/
        color: num == 0 ? null : Colors.lightBlueAccent,
        hoverColor: num == 0 ? null : Colors.lightBlue,
        // child: num == 0 ? kDash() : boxNumbers(num),
        // child: num == 0 ? dancingDash() : boxNumbers(num),
        child: boxNumbers(num),
        elevation: 6,
        hoverElevation: 8,
        animationDuration: const Duration(seconds: 1),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(8.0),
          borderRadius: BorderRadius.only(
            topLeft: balFent
                ? const Radius.circular(kRadius24)
                : Radius.circular(h * 0.01),
            topRight: jobbFent
                ? const Radius.circular(kRadius24)
                : Radius.circular(h * 0.01),
            bottomLeft: balLent
                ? const Radius.circular(kRadius24)
                : Radius.circular(h * 0.01),
            bottomRight: jobbLent
                ? const Radius.circular(kRadius24)
                : Radius.circular(h * 0.01),
          ),
        ),
      ),
    );
  }

  Text boxNumbers(int num) {
    return Text(
      '$num',
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: "Roboto-Bold",
      ),
    );
  }
}
