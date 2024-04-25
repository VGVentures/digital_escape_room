import 'dart:async';

import 'package:digital_escape_room/game/components/collisions/collisions.dart';
import 'package:digital_escape_room/game/components/player/player_collider.dart';
import 'package:digital_escape_room/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

enum PlayerOrientation {
  down(row: 0),
  idleDown(row: 0),
  up(row: 3),
  idleUp(row: 3),
  right(row: 2),
  idleRight(row: 2),
  left(row: 1),
  idleLeft(row: 1);

  const PlayerOrientation({required this.row});

  final int row;
}

class Player extends SpriteAnimationGroupComponent<PlayerOrientation>
    with HasGameRef<EscapeRoomGame>, EntityMixin {
  Player({
    required this.character,
    required this.collider,
    required Vector2 position,
    required super.size,
  }) : super(
          position: position,
          priority: position.y.toInt() ~/ tileSize.y,
          children: [
            PropagatingCollisionBehavior(
              NonPhysicsHitbox(size: collider.hitbox.size),
            ),
            KeyboardMovingBehavior(collider: collider),
            PuzzleChallengeBehavior(),
          ],
        ) {
    // Y-sorting based on the player's position. This allows us to show up
    // behind objects that are positioned further down the y axis than us.
    this.position.addListener(() {
      final pos = absolutePosition.y.toInt();
      final newPriority = pos;

      if (newPriority != priority) {
        priority = newPriority;
      }
    });
  }

  final PlayerCollider collider;

  final String character;

  late final SpriteAnimation _rightOrientationAnimation;
  late final SpriteAnimation _idleRightOrientationAnimation;
  late final SpriteAnimation _leftOrientationAnimation;
  late final SpriteAnimation _idleLeftOrientationAnimation;
  late final SpriteAnimation _upOrientationAnimation;
  late final SpriteAnimation _idleUpOrientationAnimation;
  late final SpriteAnimation _downOrientationAnimation;
  late final SpriteAnimation _idleDownOrientationAnimation;

  @override
  FutureOr<void> onLoad() async {
    _loadPlayerAnimations();
    return super.onLoad();
  }

  void _loadPlayerAnimations() {
    final image = game.images.fromCache('characters/$character.png');
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: playerSpriteSheetSize,
    );
    _rightOrientationAnimation =
        _loadAnimation(PlayerOrientation.right, spriteSheet);
    _leftOrientationAnimation =
        _loadAnimation(PlayerOrientation.left, spriteSheet);
    _upOrientationAnimation = _loadAnimation(PlayerOrientation.up, spriteSheet);
    _downOrientationAnimation =
        _loadAnimation(PlayerOrientation.down, spriteSheet);
    _idleRightOrientationAnimation =
        _loadAnimation(PlayerOrientation.idleRight, spriteSheet, to: 1);
    _idleLeftOrientationAnimation =
        _loadAnimation(PlayerOrientation.idleLeft, spriteSheet, to: 1);
    _idleUpOrientationAnimation =
        _loadAnimation(PlayerOrientation.idleUp, spriteSheet, to: 1);
    _idleDownOrientationAnimation =
        _loadAnimation(PlayerOrientation.idleDown, spriteSheet, to: 1);
    animations = {
      PlayerOrientation.right: _rightOrientationAnimation,
      PlayerOrientation.idleRight: _idleRightOrientationAnimation,
      PlayerOrientation.left: _leftOrientationAnimation,
      PlayerOrientation.idleLeft: _idleLeftOrientationAnimation,
      PlayerOrientation.up: _upOrientationAnimation,
      PlayerOrientation.idleUp: _idleUpOrientationAnimation,
      PlayerOrientation.down: _downOrientationAnimation,
      PlayerOrientation.idleDown: _idleDownOrientationAnimation,
    };
    current = PlayerOrientation.idleRight;
  }

  SpriteAnimation _loadAnimation(
    PlayerOrientation orientation,
    SpriteSheet spriteSheet, {
    int to = playerSpriteSheetFrames,
  }) {
    return spriteSheet.createAnimation(
      row: orientation.row,
      stepTime: playerStepTimeAnimation,
      to: to,
    );
  }
}
