import 'package:flutter/material.dart';
import 'package:sliding_puzzle_game/app/floating_info_button.dart';

import 'game_board.dart';

class AppHome extends StatelessWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // backgroundColor: Colors.lightBlueAccent,
        floatingActionButton: FloatingInfoButton(),
        body: SafeArea(
          child: GameBoard(),
        ));
  }
}
