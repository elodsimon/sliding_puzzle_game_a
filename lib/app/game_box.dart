// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sliding_puzzle_game/utils/constants.dart';

import 'box_number.dart';
import 'game_logic.dart';

class GameBox extends StatelessWidget {
  GameLogic game;
  final Function numClick;
  GameBox({Key? key, required this.game, required this.numClick})
      : super(key: key);
  late MediaQueryData mediaQuery;
  bool balFent = false;
  bool jobbFent = false;
  bool balLent = false;
  bool jobbLent = false;
  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    // double responsiveRatio = mediaQuery.size.width > kScreenLimit ? 1.5 : 1;
    // final double boardWidth = max(mediaQuery.size.width * kBoardRatio, 340);
    final double boardWidth = max(
        mediaQuery.size.width > kScreenLimit
            ? mediaQuery.size.width / kMagic * kBoardRatio
            : mediaQuery.size.width * kBoardRatio,
        // mediaQuery.size.width * kBoardRatio,
        340);
    // final double boardWidth =
    //     max(mediaQuery.size.width / kMagic * kBoardRatio, 340);
    return Stack(
      children: gridBuilder(boardWidth),
    );
  }

  List<AnimatedPositioned> gridBuilder(double w) {
    List<AnimatedPositioned> element = [];
    for (int i = 0; i < 16; i++) {
      balFent = listEquals(game.generatedNumbers[i], game.gameNumbers[1]);
      jobbFent = listEquals(game.generatedNumbers[i], game.gameNumbers[4]);
      balLent = listEquals(game.generatedNumbers[i], game.gameNumbers[13]);
      jobbLent = listEquals(game.generatedNumbers[i], game.gameNumbers[0]);
      element.add(gridElement(i, w));
    }
    // print(element);
    return element;
  }

  AnimatedPositioned gridElement(int num, double w) {
    return AnimatedPositioned(
      curve: Curves.easeIn,
      child: gridButton(num, w),
      duration: const Duration(milliseconds: 500),
      top: game.generatedNumbers[num]![0],
      left: game.generatedNumbers[num]![1],
    );
  }

  Container gridButton(int i, double w) {
    return Container(
      /**get boxNumber width from second map element*/
      width: game.gameNumbers[2]![1],
      height: game.gameNumbers[2]![1],
      // padding: EdgeInsets.all(w * 0.01),
      padding: const EdgeInsets.all(5),
      child: MaterialButton(
        onPressed: () {
          numClick(i);
        },
        color: i == 0
            ? null
            : (game.generatedNumbers[i] == game.gameNumbers[i]
                ? const Color(0xFF2F84C9)
                : Colors.lightBlueAccent),
        hoverColor: i == 0 ? null : Colors.lightBlue,
        child: i == 0 ? dancingDash() : BoxNumber(num: i, width: w),
        elevation: 6,
        hoverElevation: 8,
        animationDuration: const Duration(seconds: 1),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(8.0),
          borderRadius: BorderRadius.only(
            topLeft: balFent
                ? Radius.circular(w * 0.1)
                : const Radius.circular(kRadius10),
            topRight: jobbFent
                ? Radius.circular(w * 0.1)
                : const Radius.circular(kRadius10),
            bottomLeft: balLent
                ? Radius.circular(w * 0.1)
                : const Radius.circular(kRadius10),
            bottomRight: jobbLent
                ? Radius.circular(w * 0.1)
                : const Radius.circular(kRadius10),
          ),
        ),
      ),
    );
  }

  RiveAnimation dancingDash() {
    return const RiveAnimation.asset(
      'rive_anim/birb.riv',
      animations: ['slowDance'],
      fit: BoxFit.fitHeight,
    );
  }
}
