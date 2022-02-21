import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mock_data/mock_data.dart';
import 'package:sliding_puzzle_game/app/general_button.dart';

import 'game_logic.dart';

final _firestore = FirebaseFirestore.instance;

class BestScores extends StatefulWidget {
  final GameLogic game;
  const BestScores({Key? key, required this.game}) : super(key: key);

  @override
  State<BestScores> createState() => _BestScoresState();
}

class _BestScoresState extends State<BestScores> {
  final AudioCache _player = AudioCache();
  final nameTextController = TextEditingController(text: mockName());
  String? nameText;
  Future<void> addScore() async {
    _firestore.collection('scores').add({
      'name': nameTextController.text,
      'moves': widget.game.stepper
    }).then((value) {
      //print("Score Added");
      setState(() {
        widget.game.stepper = 0;
      });
    }).catchError((error) => print("Failed to add score: $error"));
  }

  @override
  void initState() {
    super.initState();
    if (widget.game.soundState) {
      _player.play('winner.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Game info",
        style: TextStyle(
          fontSize: 26.0,
          color: Colors.black,
          fontFamily: 'Rubik',
        ),
      ),
      content: const Text("Finish the game to get a score",
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Rubik',
          )),
      actions: [
        TextButton(
          child: const Text(
            'OK',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // okButton,
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sliding puzzle scores'),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
              child: TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                controller: nameTextController,
                onChanged: (value) {
                  nameText = value;
                },
                onTap: () => nameTextController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: nameTextController.value.text.length),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '_your name',
                ),
                // decoration: kMessageTextFieldDecoration,
              ),
            ),
            Text(
              'Your ${(widget.game.gameFinished ? '' : 'unfinished ')}score: ${widget.game.stepper}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white60,
                fontSize: 24.0,
                fontFamily: 'Rubik',
              ),
            ),
            const SizedBox(
              height: 14.0,
            ),
            GeneralButton(
                label: 'SEND',
                fn: () {
                  if (widget.game.stepper > 0 && widget.game.gameFinished) {
                    addScore();
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return alert;
                        });
                  }
                }),
            const SizedBox(
              height: 14.0,
            ),
            const ScoresStream(),
          ],
        ),
      ),
    );
  }
}

class ScoresStream extends StatelessWidget {
  const ScoresStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('scores')
          .orderBy("moves", descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Expanded(
            child: Material(
              color: Colors.lightBlueAccent,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          );
        }
        List<ScoreRow> scoreWidgets = [];
        final scores = snapshot.data!.docs; //.reversed;
        int index = 1;
        for (var score in scores) {
          final nameText = score['name'];
          final scoreText = score['moves'];
          final scoreWidget =
              ScoreRow(score: scoreText, name: nameText, index: index);
          scoreWidgets.add(scoreWidget);
          index++;
        }

        return Expanded(
          child: Material(
            color: Colors.lightBlueAccent,
            child: ListView(
              // reverse: true,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              children: scoreWidgets,
            ),
          ),
        );
      },
    );
  }
}

class ScoreRow extends StatelessWidget {
  final int score;
  final int index;
  final String name;

  const ScoreRow(
      {Key? key, required this.score, required this.name, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: .5,
          color: Colors.lightBlueAccent,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: ListTile(
        shape: [1, 2, 3].contains(index)
            ? const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(0),
              ))
            : const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
        tileColor: Colors.blue,
        contentPadding: const EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          right: 24.0,
          left: 24.0,
        ),
        dense: true,
        leading: (index == 1
            ? const Icon(
                Icons.emoji_events_outlined,
                color: Color(0xFFFFD700),
              )
            : (index == 2
                ? const Icon(
                    Icons.emoji_events_outlined,
                    color: Color(0xFFC0C0C0),
                  )
                : (index == 3
                    ? const Icon(
                        Icons.emoji_events_outlined,
                        color: Color(0xFFCD7F32),
                      )
                    : const Icon(Icons.verified_user)))),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white60,
            fontFamily: 'Rubik',
            fontSize: 20.0,
          ),
        ),
        trailing: Text(
          score.toString(),
          style: const TextStyle(
            color: Colors.white60,
            fontFamily: 'Rubik',
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
