import 'package:flutter/material.dart';

import 'game_logic.dart';

class StepperText extends StatelessWidget {
  final GameLogic game;
  final double h;
  const StepperText({Key? key, required this.game, required this.h})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      game.gameFinished
          ? 'Game finished in ${game.stepper} steps!'
          : 'Step${game.stepper < 2 ? ': ' : 's: '}${game.stepper}',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white60,
        fontSize: h * 0.03,
        fontFamily: 'Rubik',
      ),
    );
  }
}
