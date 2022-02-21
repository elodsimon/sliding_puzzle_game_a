import 'package:flutter/material.dart';

class BoxNumber extends StatelessWidget {
  final int num;
  final double width;
  const BoxNumber({
    Key? key,
    required this.num,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$num',
      style: TextStyle(
        fontSize: width * 0.07,
        color: Colors.white54,
        fontWeight: FontWeight.bold,
        fontFamily: 'Rubik',
      ),
    );
  }
}
