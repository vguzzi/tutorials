import 'dart:collection';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/keyboard.dart';
import 'package:flutter/services.dart';

import 'components/player.dart';
import 'components/world.dart';
import 'components/world_collidable.dart';
import 'helpers/direction.dart';
import 'package:flutter/material.dart';

import 'helpers/map_loader.dart';

class RayWorldGame extends BaseGame with HasCollidables, KeyboardEvents {
  final Player _player = Player();
  final World _world = World();
  final Queue<Direction> _directionStack = Queue<Direction>();

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
    _player.direction = direction;
  }

  WorldCollidable createWorldCollidable(Rect rect) {
    final collidable = WorldCollidable();
    collidable.position = Vector2(rect.left, rect.top);
    collidable.width = rect.width;
    collidable.height = rect.height;
    return collidable;
  }

  @override
  void onKeyEvent(RawKeyEvent event) {
    final isKeyDown = event is RawKeyDownEvent;
    final keyLabel = event.data.keyLabel;
    Direction? keyDirection;

    switch (keyLabel) {
      case 'UIKeyInputUpArrow':
        keyDirection = Direction.up;
        break;
      case 'UIKeyInputLeftArrow':
        keyDirection = Direction.left;
        break;
      case 'UIKeyInputRightArrow':
        keyDirection = Direction.right;
        break;
      case 'UIKeyInputDownArrow':
        keyDirection = Direction.down;
        break;
    }

    if (keyDirection != null) {
      if (isKeyDown) {
        _directionStack.addFirst(keyDirection);
        _player.direction = keyDirection;
      } else {
        _directionStack.remove(keyDirection);

        if (_player.direction == keyDirection) {
          var direction = Direction.none;

          if (_directionStack.isNotEmpty) {
            direction = _directionStack.first;
          }

          _player.direction = direction;
        }
      }
    }
  }
}
