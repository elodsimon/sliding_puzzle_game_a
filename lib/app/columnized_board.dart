import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sliding_puzzle_game/app/game_logic.dart';
import 'package:sliding_puzzle_game/app/puzzle_title_bar.dart';
import 'package:sliding_puzzle_game/app/sound_handler.dart';
import 'package:sliding_puzzle_game/app/stepper_text.dart';
import 'package:sliding_puzzle_game/app/time_text.dart';

import '../utils/constants.dart';
import 'best_scores.dart';
import 'game_box.dart';
import 'general_button.dart';

class ColumnizedBoard extends StatelessWidget {
  final GameLogic game;
  final Duration duration;
  final LinearGradient bgColor;
  final Function numClick;
  final VoidCallback newGameClick;
  const ColumnizedBoard({
    Key? key,
    required this.game,
    required this.duration,
    required this.bgColor,
    required this.numClick,
    required this.newGameClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double boardWidth = max(mediaQuery.size.width * kBoardRatio, 340);
    return AnimatedContainer(
      duration: const Duration(milliseconds: kGradientDuration),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        gradient: bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: mediaQuery.size.height * kSpaceBetween),
          ),
          PuzzleTitleBar(mediaQuery: mediaQuery),
          SizedBox(
            height: mediaQuery.size.height * 0.02,
          ),
          TimeText(h: mediaQuery.size.height, duration: duration),
          SizedBox(
            height: mediaQuery.size.height * 0.02,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(boardWidth * 0.1),
              color: Colors.blue,
            ),
            child: game.inGame
                ? ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(boardWidth * 0.1),
                    ),
                    child: Shimmer(
                      duration: const Duration(seconds: 2),
                      color: Colors.white,
                      enabled: game.gameFinished,
                      child: GameBox(game: game, numClick: numClick),
                    ),
                  )
                : const rive.RiveAnimation.asset('rive_anim/birb.riv'),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.02,
          ),
          StepperText(game: game, h: mediaQuery.size.height),
          SizedBox(
            height: mediaQuery.size.height * 0.01,
          ),
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GeneralButton(
                    label: 'NEW',
                    fn: newGameClick,
                  ),
                  SizedBox(
                    width: mediaQuery.size.height * 0.02,
                  ),
                  GeneralButton(
                      label: 'SCORES',
                      fn: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return BestScores(game: game);
                          }),
                        );
                      }),
                  SizedBox(
                    width: mediaQuery.size.height * 0.02,
                  ),
                  SoundHandler(game: game)
                ],
              ),
            ),
          )
          //GameBox(),
        ],
      ),
    );
  }
}
