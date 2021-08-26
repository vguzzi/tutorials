import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components/player.dart';
import 'components/world.dart';
import 'components/world_collidable.dart';
import 'helpers/direction.dart';
import 'package:flutter/material.dart';

import 'helpers/map_loader.dart';

class RayWorldGame extends BaseGame with HasCollidables {
  final Player _player = Player();
  final World _world = World();

  @override
  Future<void> onLoad() async {
    await add(_world);
    add(_player);
    addWorldCollision();

    _player.position = _world.size / 2;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void addWorldCollision() async =>
      (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });

  void onJoypadDirectionChanged(Direction direction) {
    _player.onJoypadDirectionChanged(direction);
  }

  WorldCollidable createWorldCollidable(Rect rect) {
    final collidable = WorldCollidable();
    collidable.position = Vector2(rect.left, rect.top);
    collidable.width = rect.width;
    collidable.height = rect.height;
    return collidable;
  }

  String getDebugText() {
    return 'Player position: x: ${_player.position.x.round()}' +
        ' y: ${_player.position.y.round()}' +
        '\n game size x: ${size.x.round()} y: ${size.y.round()}';
  }
}
