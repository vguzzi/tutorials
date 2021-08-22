import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'components/debug_text.dart';

import 'components/player.dart';
import 'helpers/direction.dart';
import 'package:flutter/material.dart';

class RayWorldGame extends BaseGame {
  final Player _player = Player();
  final TextComponent _debugText = DebugTextComponent();
  Direction _direction = Direction.none;

  void onJoypadDirectionChanged(Direction direction) {
    _direction = direction;
    _player.onJoypadDirectionChanged(direction);
  }

  @override
  Future<void> onLoad() async {
    add(_player);
    add(_debugText);
  }

  @override
  void update(double dt) {
    _debugText.text = getDebugText();
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  String getDebugText() {
    return 'Player position: x: ${_player.position.x.round()}' +
        ' y: ${_player.position.y.round()}' +
        '\n';
  }
}
