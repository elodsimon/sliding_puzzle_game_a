import 'package:flutter/material.dart';

import 'app_home.dart';

class SlidingPuzzle extends StatelessWidget {
  const SlidingPuzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sliding Puzzle Game',
      debugShowCheckedModeBanner: false,
      home: AppHome(),
    );
  }
}
