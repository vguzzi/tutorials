import 'package:flame/components.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef {
  final double _playerSpeed = 300.0;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

  Direction direction = Direction.none;

  Player()
      : super(
          size: Vector2.all(50.0),
        ) {
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    await loadAnimations();

    animation = _standingAnimation;
    position = gameRef.size / 2;
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  void onJoypadDirectionChanged(Direction direction) {
    this.direction = direction;
  }

  Future<void> loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('player_spritesheet.png'),
      srcSize: Vector2(29.0, 32.0),
    );

    _runDownAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);

    _runLeftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);

    _runUpAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);

    _runRightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  void movePlayer(double delta) {
    if (direction == Direction.up) {
      animation = _runUpAnimation;
      if (canPlayerMoveUp(delta)) {
        position.add(Vector2(0, delta * -_playerSpeed));
      }
    } else if (direction == Direction.down) {
      animation = _runDownAnimation;
      if (canPlayerMoveDown(delta)) {
        position.add(Vector2(0, delta * _playerSpeed));
      }
    } else if (direction == Direction.left) {
      animation = _runLeftAnimation;
      if (canPlayerMoveLeft(delta)) {
        position.add(Vector2(delta * -_playerSpeed, 0));
      }
    } else if (direction == Direction.right) {
      animation = _runRightAnimation;
      if (canPlayerMoveRight(delta)) {
        position.add(Vector2(delta * _playerSpeed, 0));
      }
    } else {
      animation = _standingAnimation;
    }
  }

  bool canPlayerMoveUp(double delta) {
    return position.y + delta * -_playerSpeed > 0 + size.y / 2;
  }

  bool canPlayerMoveDown(double delta) {
    return (position.y + (delta * _playerSpeed)) < gameRef.size.y - size.y / 2;
  }

  bool canPlayerMoveLeft(double delta) {
    return (position.x + (delta * -_playerSpeed)) > 0 + size.x / 2;
  }

  bool canPlayerMoveRight(double delta) {
    return (position.x + (delta * _playerSpeed)) < gameRef.size.x - size.x / 2;
  }
}
