import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_puzzle_game/utils/constants.dart';

import 'game_logic.dart';

class SoundHandler extends StatefulWidget {
  final GameLogic game;
  const SoundHandler({Key? key, required this.game}) : super(key: key);

  @override
  State<SoundHandler> createState() => _SoundHandlerState();
}

class _SoundHandlerState extends State<SoundHandler> {
  bool _soundEnabled = true;
  SharedPreferences? _prefs;
  _setSoundState() async {
    _soundEnabled = !(_prefs?.getBool('soundEnabled') ?? true);
    setState(() {
      widget.game.soundState = _soundEnabled;
    });
    await _prefs?.setBool('soundEnabled', _soundEnabled);
  }

  _getInitSoundState() async {
    _prefs = await SharedPreferences.getInstance();
    _soundEnabled = (_prefs!.getBool('soundEnabled') ?? true);

    setState(() {
      widget.game.soundState = _soundEnabled;
    });
  }

  @override
  void initState() {
    super.initState();
    _getInitSoundState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MaterialButton(
      padding: const EdgeInsets.all(20),
      minWidth: 50.0,
      onPressed: () {
        _setSoundState();
      },
      color: Colors.blue,
      hoverColor: const Color(0xff40c4ff),
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      shape: kButtonRadius,
      child: SizedBox(
        width: kButtonWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SOUND',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: mediaQuery.size.height * 0.03,
                color: Colors.white60,
                decoration: TextDecoration.none,
                fontFamily: 'Shizuru',
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            _soundEnabled
                ? const Icon(
                    Icons.volume_up_outlined,
                    color: Colors.white60,
                    size: 24.0,
                  )
                : const Icon(
                    Icons.volume_off_outlined,
                    color: Colors.white60,
                    size: 24,
                  ),
          ],
        ),
      ),
    );
  }
}
