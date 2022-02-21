import 'package:flutter/material.dart';

const double kRoundedEdges = 0.05;
const double kSpaceBetween = 0.05;
const double kCornerRadius = 0.05;
const double kSmall = 0.01;
const double kSizedBoxDist = 0.02;
const double kRadius10 = 10.0;
const double kRadius24 = 24.0;
const double kBoardRatio = 0.55;
const double kButtonWidth = 150.0;
const double kScreenLimit = 1000.0;
const double kMagic = 1.7;
const kButtonRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(12),
    topRight: Radius.circular(12),
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
  ),
);
const int kGradientDuration = 2000;
/*const List<Color> kColors = [
  Colors.lightBlueAccent,
  Color(0xFF448AFF),
  Color(0xFF0288D1),
  Color(0xFF03A9F4),
  // Colors.blue,
  // Colors.cyan,
];*/
const List<Color> kColors = [
  Colors.lightBlueAccent,
  Color(0xB71882DB),
  Color(0x371C5CE2),
  Color(0xFF2F84C9),
  // Colors.blue,
  // Colors.cyan,
];
const List<double> stops0 = [0.10, 0.20, 0.30, 0.40];
const List<double> stops1 = [0.15, 0.25, 0.35, 0.45];
const List<double> stops2 = [0.20, 0.30, 0.40, 0.50];
const List<double> stops3 = [0.25, 0.35, 0.45, 0.55];
const List<double> stops4 = [0.30, 0.40, 0.50, 0.60];
const List<double> stops5 = [0.35, 0.45, 0.55, 0.65];
const List<double> stops6 = [0.40, 0.50, 0.60, 0.70];
const List<double> stops7 = [0.45, 0.55, 0.65, 0.75];
const List<double> stops8 = [0.50, 0.60, 0.65, 0.80];
const List<double> stops9 = [0.55, 0.65, 0.70, 0.75];
const List<double> stops10 = [0.60, 0.70, 0.75, 0.80];
const List<double> stops11 = [0.65, 0.75, 0.80, 0.85];
const List<double> stops12 = [0.75, 0.80, 0.85, 0.90];
const List<double> stops13 = [0.85, 0.85, 0.90, 0.95];
const List<double> stops14 = [0.90, 0.90, 0.95, 0.98];
const List<double> stops15 = [1.0, 0.0, 0.0, 0.0];
const List<LinearGradient> kBGColors = [
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops0,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops1,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops2,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops3,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops4,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops5,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops6,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops7,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops8,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops9,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops10,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops11,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops12,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops13,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops14,
    colors: kColors,
  ),
  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: stops15,
    colors: kColors,
  ),
];
