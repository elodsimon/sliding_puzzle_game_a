import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sliding_puzzle_game/app/puzzle_title_bar.dart';
import 'package:sliding_puzzle_game/app/sound_handler.dart';
import 'package:sliding_puzzle_game/app/stepper_text.dart';
import 'package:sliding_puzzle_game/app/time_text.dart';

import '../utils/constants.dart';
import 'best_scores.dart';
import 'game_box.dart';
import 'game_logic.dart';
import 'general_button.dart';

class RowizedBoard extends StatelessWidget {
  final GameLogic game;
  final Duration duration;
  final LinearGradient bgColor;
  final Function numClick;
  final VoidCallback newGameClick;
  const RowizedBoard({
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
    final double boardWidth =
        max(mediaQuery.size.width / kMagic * kBoardRatio, 340);
    // final double boardHeight = max(mediaQuery.size.width * kBoardRatio, 340);
    return AnimatedContainer(
      duration: const Duration(milliseconds: kGradientDuration),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        gradient: bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: mediaQuery.size.height * kSpaceBetween),
              ),
              PuzzleTitleBar(mediaQuery: mediaQuery),
              SizedBox(
                height: mediaQuery.size.width * 0.02,
              ),
              TimeText(
                h: mediaQuery.size.height,
                duration: duration,
              ),
              SizedBox(
                height: mediaQuery.size.width * 0.02,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
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
                                  child:
                                      GameBox(game: game, numClick: numClick),
                                ),
                              )
                            : const rive.RiveAnimation.asset(
                                'rive_anim/birb.riv'),
                      ),
                      SizedBox(
                        height: mediaQuery.size.width * 0.015,
                      ),
                      StepperText(game: game, h: mediaQuery.size.height),
                    ],
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.06,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GeneralButton(
                        label: 'NEW',
                        fn: newGameClick,
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.02,
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
                        height: mediaQuery.size.height * 0.02,
                      ),
                      SoundHandler(game: game)
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
