import 'package:flutter/material.dart';

class FloatingInfoButton extends StatelessWidget {
  const FloatingInfoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => SimpleDialog(
                  title: const Text(
                    'Game info',
                    style: TextStyle(fontSize: 26, fontFamily: 'Rubik'),
                  ),
                  children: [
                    const ListTile(
                      leading: Icon(Icons.info),
                      title: Text(
                        'eLod 2022',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(Icons.volume_down_outlined),
                      title: Text(
                        'sounds from freesound',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(Icons.image),
                      title: Text(
                        'dash from dashatar',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ),
                    const ListTile(
                      leading: Icon(Icons.animation),
                      title: Text(
                        'animation from rive',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ));
      },
      child: const Icon(Icons.star_border_outlined),
    );
  }
}
