import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../utils/constants.dart';

class PuzzleTitleBar extends StatelessWidget {
  const PuzzleTitleBar({
    Key? key,
    required this.mediaQuery,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(mediaQuery.size.height * 0.01),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(mediaQuery.size.height * 0.01),
            ),
          ),
          child: FlutterLogo(
            size: mediaQuery.size.height * kRoundedEdges,
            duration: const Duration(seconds: 2),
          ),
        ),
        SizedBox(
          width: mediaQuery.size.height * 0.01,
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(mediaQuery.size.height * kRoundedEdges),
          ),
          child: Padding(
            padding: EdgeInsets.all(mediaQuery.size.height * 0.01),
            child: Shimmer(
              child: Text(
                'Sliding Puzzle',
                style: TextStyle(
                  fontSize: mediaQuery.size.height * kRoundedEdges,
                  fontFamily: 'DancingScript',
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              duration: const Duration(seconds: 10),
              color: Colors.white,
              enabled: true,
            ),
          ),
        )
      ],
    );
  }
}
