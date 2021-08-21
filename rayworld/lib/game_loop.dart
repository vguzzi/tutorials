import 'dart:ui';

import 'package:flame/game.dart';

import 'helpers/direction.dart';

class GameLoop extends Game {
  Direction direction = Direction.none;

  void onJoypadDirectionChanged(Direction direction) {
    this.direction = direction;
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
  }

  @override
  void update(double dt) {
    // TODO: implement update
  }
}
