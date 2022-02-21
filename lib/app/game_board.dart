import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sliding_puzzle_game/app/game_logic.dart';
import 'package:sliding_puzzle_game/utils/constants.dart';

import 'columnized_board.dart';
import 'rowized_board.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late GameLogic game;
  Duration duration = const Duration();
  Timer? _timer;
  LinearGradient bgColor = kBGColors[15];

  @override
  void initState() {
    super.initState();
    game = GameLogic();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    // duration = const Duration();
    _timer = Timer.periodic(const Duration(seconds: 1), (x) {
      setState(() {
        duration = Duration(seconds: duration.inSeconds + 1);
      });
    });
  }

  void setBGColor() {
    if ((game.percentage / 16) * 100 < 7) {
      bgColor = kBGColors[0];
    } else if ((game.percentage / 16) * 100 < 13) {
      bgColor = kBGColors[1];
    } else if ((game.percentage / 16) * 100 < 19) {
      bgColor = kBGColors[2];
    } else if ((game.percentage / 16) * 100 < 26) {
      bgColor = kBGColors[3];
    } else if ((game.percentage / 16) * 100 < 32) {
      bgColor = kBGColors[4];
    } else if ((game.percentage / 16) * 100 < 38) {
      bgColor = kBGColors[5];
    } else if ((game.percentage / 16) * 100 < 44) {
      bgColor = kBGColors[6];
    } else if ((game.percentage / 16) * 100 < 51) {
      bgColor = kBGColors[7];
    } else if ((game.percentage / 16) * 100 < 57) {
      bgColor = kBGColors[8];
    } else if ((game.percentage / 16) * 100 < 63) {
      bgColor = kBGColors[9];
    } else if ((game.percentage / 16) * 100 < 69) {
      bgColor = kBGColors[10];
    } else if ((game.percentage / 16) * 100 < 76) {
      bgColor = kBGColors[11];
    } else if ((game.percentage / 16) * 100 < 82) {
      bgColor = kBGColors[12];
    } else if ((game.percentage / 16) * 100 < 88) {
      bgColor = kBGColors[13];
    } else if ((game.percentage / 16) * 100 < 94) {
      bgColor = kBGColors[14];
    } else {
      bgColor = kBGColors[15];
    }
  }

  void numClick(int numberClicked) {
    if (!game.gameFinished) {
      if (game.numClicked(numberClicked)) {
        game.calcPercent();
        setState(() {
          setBGColor();
        });
        if (game.checkFinished()) {
          game.gameFinished = true;
          _timer!.cancel();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double boardWidth = max(
        mediaQuery.size.width > kScreenLimit
            ? double.parse((mediaQuery.size.width / kMagic * kBoardRatio)
                .toStringAsFixed(4))
            : mediaQuery.size.width * kBoardRatio,
        // mediaQuery.size.width * kBoardRatio,
        340);
    if (game.inGame) {
      game.updatePositions(boardWidth);
    } else {
      List<double> temp;
      double boxWidth = double.parse((boardWidth / 4.0).toStringAsFixed(4));
      for (int i = 0; i < 16; i++) {
        game.gameNumbers[i] = [
          double.parse(((i / 4).floor() * boxWidth).toStringAsFixed(4)),
          double.parse(((i % 4) * boxWidth).toStringAsFixed(4))
        ];
      }
      game.gameNumbers[0] = game.gameNumbers[15]!;
      for (int i = 15; i > 1; i--) {
        if (i > 0) {
          temp = game.gameNumbers[i - 1]!;
          game.gameNumbers[i] = game.gameNumbers[i - 1]!;
          game.gameNumbers[i - 1] = temp;
        }
      }
      game.gameNumbers[1] = [0, 0];
    }
    return mediaQuery.size.width > kScreenLimit
        ? RowizedBoard(
            game: game,
            bgColor: bgColor,
            duration: duration,
            numClick: numClick,
            newGameClick: newGameClick)
        : ColumnizedBoard(
            game: game,
            bgColor: bgColor,
            duration: duration,
            numClick: numClick,
            newGameClick: newGameClick);
  }

  void newGameClick() {
    setState(() {
      game.shuffleNumbers();
      game.calcPercent();
      setBGColor();
      game.stepper = 0;
      game.inGame = true;
      game.gameFinished = false;
      duration = const Duration();
      _startTimer();
    });
  }
}
