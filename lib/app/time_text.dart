import 'package:flutter/material.dart';

class TimeText extends StatelessWidget {
  const TimeText({Key? key, required this.h, required this.duration})
      : super(key: key);

  final double h;
  final Duration duration;
  String twoDigits(int x) => x.toString().padLeft(2, '0');
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(seconds: 1),
      child: Text(
        '# ${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white60,
          fontSize: h * 0.03,
          fontFamily: 'Rubik',
        ),
      ),
    );
  }
}
