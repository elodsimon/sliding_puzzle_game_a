import 'package:flutter/material.dart';

class GridButton extends StatelessWidget {
  final int num;
  const GridButton({Key? key, required this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final w = constraints.maxWidth;
      return SizedBox(
        width: w / 4 - 10,
        height: w / 4 - 10,
        child: MaterialButton(
          onPressed: () {
            /* widget.numberClick(num);*/
          },
          /*color: num == 0
            ? null //Color(0XFFffcc80)
            : (widget.game.gameNumbers[num] == widget.game.goodNumbers[num]
            ? widget.colorTween.value //const Color(0xFF01509b)
            : Colors.lightBlueAccent),*/
          color: num == 0 ? null : Colors.lightBlueAccent,
          hoverColor: num == 0 ? null : Colors.lightBlue,
          // child: num == 0 ? kDash() : boxNumbers(num),
          // child: num == 0 ? dancingDash() : boxNumbers(num),
          child: boxNumbers(num),
          elevation: 6,
          hoverElevation: 8,
          animationDuration: const Duration(seconds: 1),
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(8.0),
            borderRadius: BorderRadius.only(
                /*topLeft: balFent
                  ? Radius.circular(h * kRoundedEdges)
                  : Radius.circular(h * 0.01),
              topRight: jobbFent
                  ? Radius.circular(h * kRoundedEdges)
                  : Radius.circular(h * 0.01),
              bottomLeft: balLent
                  ? Radius.circular(h * kRoundedEdges)
                  : Radius.circular(h * 0.01),
              bottomRight: jobbLent
                  ? Radius.circular(h * kRoundedEdges)
                  : Radius.circular(h * 0.01),*/
                ),
          ),
        ),
      );
    });
  }

  Text boxNumbers(int num) {
    return Text(
      '$num',
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: "Roboto-Bold",
      ),
    );
  }
}
