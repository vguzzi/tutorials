import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/joypad.dart';
import 'game_loop.dart';
import 'helpers/direction.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  GameLoop gameLoop = GameLoop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Stack(
          children: [
            GameWidget(game: gameLoop),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Joypad(
                    onDirectionChanged: gameLoop.onJoypadDirectionChanged),
              ),
            )
          ],
        ));
  }
}
