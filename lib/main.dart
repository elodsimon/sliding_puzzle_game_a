import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_puzzle_game/app/sliding_puzzle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  if (kIsWeb) {
    await Firebase.initializeApp(
      // Replace with actual values
      options: const FirebaseOptions(
        apiKey: "AIzaSyCh8qB0a8XCaCJiI4XaC5dpp4q4ibO4Ndo",
        appId: "1:1050725762059:web:5bc9665147ff439925330e",
        messagingSenderId: "1050725762059",
        projectId: "slidingpuzzle-bdf65",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const SlidingPuzzle());
}
