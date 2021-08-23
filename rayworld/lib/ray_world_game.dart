import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components/player.dart';
import 'components/world.dart';
import 'helpers/direction.dart';
import 'package:flutter/material.dart';

class RayWorldGame extends BaseGame with HasCollidables {
  final Player _player = Player();
  final World _world = World();

  @override
  Future<void> onLoad() async {
    await add(_world);
    add(_player);

    _player.position = _world.size / 2;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void onJoypadDirectionChanged(Direction direction) {
    _player.onJoypadDirectionChanged(direction);
  }

  String getDebugText() {
    return 'Player position: x: ${_player.position.x.round()}' +
        ' y: ${_player.position.y.round()}' +
        '\n game size x: ${size.x.round()} y: ${size.y.round()}';
  }
}
