import 'package:flutter/material.dart';
import 'package:sliding_puzzle_game/utils/constants.dart';

class GeneralButton extends StatelessWidget {
  final String label;
  final VoidCallback fn;
  const GeneralButton({Key? key, required this.label, required this.fn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MaterialButton(
      padding: const EdgeInsets.all(20),
      minWidth: 50.0,
      onPressed: fn,
      color: Colors.blue,
      hoverColor: const Color(0xff40c4ff),
      hoverElevation: 8,
      animationDuration: const Duration(seconds: 1),

      elevation: 5,
      // clipBehavior: Clip.antiAlias,
      shape: kButtonRadius,
      child: SizedBox(
        width: kButtonWidth,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: mediaQuery.size.height * 0.02,
              color: Colors.white60,
              decoration: TextDecoration.none,
              fontFamily: 'Shizuru',
            ),
          ),
        ),
      ),
    );
  }
}
