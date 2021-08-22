import 'package:flame/components.dart';
import 'package:rayworld/components/joypad.dart';
import 'package:rayworld/helpers/direction.dart';

class Player extends SpriteComponent with HasGameRef {
  double playerSpeed = 300.0;

  Direction direction = Direction.none;

  Player()
      : super(
          size: Vector2.all(50.0),
        ) {
    anchor = Anchor.center;
  }

  void onJoypadDirectionChanged(Direction direction) {
    this.direction = direction;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png');
    position = gameRef.size / 2;
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  void movePlayer(double delta) {
    if (direction == Direction.up) {
      if (canPlayerMoveUp(delta)) {
        position.add(Vector2(0, delta * -playerSpeed));
      }
    } else if (direction == Direction.down) {
      if (canPlayerMoveDown(delta)) {
        position.add(Vector2(0, delta * playerSpeed));
      }
    } else if (direction == Direction.left) {
      if (canPlayerMoveLeft(delta)) {
        position.add(Vector2(delta * -playerSpeed, 0));
      }
    } else if (direction == Direction.right) {
      if (canPlayerMoveRight(delta)) {
        position.add(Vector2(delta * playerSpeed, 0));
      }
    }
  }

  bool canPlayerMoveUp(double delta) {
    return position.y + delta * -playerSpeed > 0 + size.y / 2;
  }

  bool canPlayerMoveDown(double delta) {
    return (position.y + (delta * playerSpeed)) < gameRef.size.y - size.y / 2;
  }

  bool canPlayerMoveLeft(double delta) {
    return (position.x + (delta * -playerSpeed)) > 0 + size.x / 2;
  }

  bool canPlayerMoveRight(double delta) {
    return (position.x + (delta * playerSpeed)) < gameRef.size.x - size.x / 2;
  }
}
