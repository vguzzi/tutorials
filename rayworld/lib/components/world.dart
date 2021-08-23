import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'world_collidable.dart';

class World extends SpriteComponent with HasGameRef {
  World()
      : super(
          position: Vector2(0, 0),
          size: Vector2.all(2400.0),
        );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('rayworld_background.png');

    (await getWorldCollidables())
        .forEach((component) => gameRef.add(component));

    super.onLoad();
  }

  Future<List<WorldCollidable>> getWorldCollidables() async =>
      (await readWorldCollisionMap())
          .map((rect) => createWorldCollidable(rect))
          .toList();

  Future<List<Rect>> readWorldCollisionMap() async {
    final collidableRects = <Rect>[];
    final dynamic collisionMap = json.decode(
        await rootBundle.loadString('assets/rayworld_collision_map.json'));

    for (final dynamic data in collisionMap['objects']) {
      collidableRects.add(Rect.fromLTWH(
          data['x'] as double,
          data['y'] as double,
          data['width'] as double,
          data['height'] as double));
    }

    return collidableRects;
  }

  WorldCollidable createWorldCollidable(Rect rect) {
    final collidable = WorldCollidable();
    collidable.position = Vector2(rect.left, rect.top);
    collidable.width = rect.width;
    collidable.height = rect.height;
    return collidable;
  }
}
