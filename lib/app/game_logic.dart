import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class GameLogic {
  Map<int, List<double>> gameNumbers = {};
  Map<int, List<double>> generatedNumbers = {};

  bool gameFinished = false;
  bool inGame = false;
  bool soundState = true;
  int stepper = 0;
  int percentage = 0;

  final AudioCache _player = AudioCache();
  bool checkFinished() {
    return gameNumbers.toString() == generatedNumbers.toString();
  }

  bool checkSolvability(int position0, int invertCount) {
    return !((position0 % 2 == 0 && invertCount % 2 != 0) ||
        (position0 % 2 != 0 && invertCount % 2 == 0));
  }

  void shuffleNumbers() {
    List<double> boxWidths = [
      0,
      gameNumbers[2]![1],
      gameNumbers[3]![1],
      gameNumbers[4]![1]
    ];
    // print(boxWidths);
    List a = gameNumbers.values.toList();
    // print(a);
    List numbers = [];
    int position0 = 0;
    int invertCount = 0;
    do {
      numbers = [];
      invertCount = 0;
      a.shuffle();
      for (double i in boxWidths) {
        for (double j in boxWidths) {
          // print('i ${i} j ${j}');
          for (int xx = 0; xx < 16; xx++) {
            // print('i ${i} j ${j} xx ${xx} a ${a[xx]}');
            if (listEquals(a[xx], [i, j])) {
              numbers.add(xx);
              // print(numbers);
              break;
            }
          }
        }
      }
      position0 = 4 - (numbers.indexOf(0) / 4).floor();
      for (int i = 0; i < 16; i++) {
        for (int j = i; j < 16; j++) {
          if (numbers[i] != 0 && numbers[j] != 0 && numbers[i] > numbers[j]) {
            invertCount++;
          }
        }
      }
    } while (checkSolvability(position0, invertCount));
    // numbers = [13, 2, 10, 3, 1, 12, 8, 4, 5, 0, 9, 6, 15, 14, 11, 7];
    // numbers = [6, 13, 7, 10, 8, 9, 11, 0, 15, 2, 12, 5, 14, 3, 1, 4];
    //numbers = [3, 9, 1, 15, 14, 11, 4, 6, 13, 0, 10, 12, 2, 7, 8, 5];
    for (int i = 0; i < 16; i++) {
      generatedNumbers[i] = a[i];
    }
    /**cheat*/
    /*for (int i = 0; i < 16; i++) {
      generatedNumbers[i] = gameNumbers[i]!;
    }*/
  }

  bool numClicked(int num) {
    List<double> boxWidths = [
      0,
      gameNumbers[2]![1],
      gameNumbers[3]![1],
      gameNumbers[4]![1]
    ];
    if (num == 0) {
      return false;
    }
    List<double> temp;
    int pos0;
    int pos;
    // print('init 0');
    if (generatedNumbers[num]![0] == generatedNumbers[0]![0] ||
        generatedNumbers[num]![1] == generatedNumbers[0]![1]) {
      if (soundState) {
        _player.play('click.mp3');
      }

      List<int> numsBetween = [];
      /*horizontal move*/
      if (generatedNumbers[num]![0] == generatedNumbers[0]![0]) {
        // seged = generatedNumbers[num]![0];
        pos0 = boxWidths.indexOf(generatedNumbers[0]![1]);
        pos = boxWidths.indexOf(generatedNumbers[num]![1]);
        /**right to left*/
        if (pos > pos0) {
          for (int i = pos0; i <= pos; i++) {
            numsBetween.add(generatedNumbers.keys.firstWhere((k) => listEquals(
                generatedNumbers[k],
                [generatedNumbers[num]![0], boxWidths[i]])));
          }
          for (int i = 0; i < numsBetween.length; i++) {
            temp = generatedNumbers[numsBetween[i]]!;
            generatedNumbers[numsBetween[i]] = generatedNumbers[0]!;
            generatedNumbers[0] = temp;
          }
        } else {
          /**left to right*/
          for (int i = pos; i <= pos0; i++) {
            numsBetween.add(generatedNumbers.keys.firstWhere((k) => listEquals(
                generatedNumbers[k],
                [generatedNumbers[num]![0], boxWidths[i]])));
          }
          for (int i = numsBetween.length - 1; i > -1; i--) {
            temp = generatedNumbers[numsBetween[i]]!;
            generatedNumbers[numsBetween[i]] = generatedNumbers[0]!;
            generatedNumbers[0] = temp;
          }
        }
      } else {
        /**vertival move*/
        pos0 = boxWidths.indexOf(generatedNumbers[0]![0]);
        pos = boxWidths.indexOf(generatedNumbers[num]![0]);
        /**bottom  to top*/
        if (pos > pos0) {
          for (int i = pos0; i <= pos; i++) {
            numsBetween.add(generatedNumbers.keys.firstWhere((k) => listEquals(
                generatedNumbers[k],
                [boxWidths[i], generatedNumbers[num]![1]])));
          }
          for (int i = 0; i < numsBetween.length; i++) {
            temp = generatedNumbers[numsBetween[i]]!;
            generatedNumbers[numsBetween[i]] = generatedNumbers[0]!;
            generatedNumbers[0] = temp;
          }
        } else {
          /**top to bottom*/
          for (int i = pos; i <= pos0; i++) {
            numsBetween.add(generatedNumbers.keys.firstWhere((k) => listEquals(
                generatedNumbers[k],
                [boxWidths[i], generatedNumbers[num]![1]])));
          }
          for (int i = numsBetween.length - 1; i > -1; i--) {
            temp = generatedNumbers[numsBetween[i]]!;
            generatedNumbers[numsBetween[i]] = generatedNumbers[0]!;
            generatedNumbers[0] = temp;
          }
        }
      }
      stepper++;
      return true;
    } else {
      if (soundState) {
        _player.play('wrong-click.mp3');
      }
      return false;
    }
  }

  void updatePositions(double w) {
    Map<int, List<double>> temp = {};
    /** get numberBox width from second list*/
    double ratio =
        double.parse((w / (gameNumbers[2]![1] * 4)).toStringAsFixed(4));
    // print('ratio ${ratio}');
    // print('rtaio numbers ${generatedNumbers}');
    for (int i = 0; i < 16; i++) {
      // print('i ${i}');
      temp[i] = generatedNumbers[i]!;
    }
    // print('tenmp ${temp}');
    for (int i = 0; i < 16; i++) {
      generatedNumbers[i]![0] =
          double.parse((temp[i]![0] * ratio).toStringAsFixed(4));
      generatedNumbers[i]![1] =
          double.parse((temp[i]![1] * ratio).toStringAsFixed(4));
    }
    // print(generatedNumbers);
  }

  void calcPercent() {
    percentage = 0;
    for (int i = 0; i < 16; i++) {
      if (listEquals(generatedNumbers[i], gameNumbers[i])) {
        percentage++;
      }
    }
  }

  String getPercent() {
    return ((percentage / 16) * 100).toStringAsFixed(2);
  }
}
