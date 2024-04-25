import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:digital_escape_room/game/components/collisions/collisions.dart';
import 'package:digital_escape_room/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class PlayerCollider extends PositionedEntity
    with HasGameReference<EscapeRoomGame> {
  PlayerCollider({
    required super.size,
    required super.position,
    required this.hitbox,
    this.unit = 1.0,
  }) {
    collisionBehavior = PhysicsPropagatingCollisionBehavior(hitbox);
    add(collisionBehavior);
  }

  @override
  Color get debugColor => const Color(0xFF88FF00);

  /// Size of a single move unit. Default is 1.0.
  final double unit;

  /// Collision hitbox.
  final RectangleHitbox hitbox;

  /// Propagating collision behavior.
  late final PhysicsPropagatingCollisionBehavior collisionBehavior;

  double get moveStepSize => min(hitbox.width, hitbox.height);

  /// Attempts to move to the local position specified by [destPosition] and
  /// sets [nextPosition] to the next position the player can move to.
  ///
  /// If [destPosition] cannot be reached without colliding, this determines the
  /// closest position along the x and y access that can be reached. If there
  /// are no collisions in the direct path, the next position will be the same
  /// as [destPosition].
  ///
  /// This algorithm uses both a broad-phase and fine-grain stepping approach
  /// to move the player along the direct path towards the desired destination.
  /// The [unit] size determines the smallest amount of stepping possible.
  ///
  /// The algorithm is effectively O(n) (in practice), where n is the number of
  /// steps needed to cover the distance between the two positions. Higher
  /// movement speeds result in larger distances, requiring more steps. With
  /// a player movement speed of approximately 7,500 pixels per second, this
  /// never seemed to exceed 16 steps. More reasonable amounts typically only
  /// result in 1 or 2 steps, which is constant time.
  ///
  /// Returns true if the next position is the destination position.
  bool calculateNextPosition(Vector2 destPosition, Vector2 nextPosition) {
    final distance = (destPosition - position).length;

    final numSteps = (distance / moveStepSize).ceil();

    // Track last safe position along each axis.
    var safeX = position.x;
    var safeY = position.y;

    // Breaking the distance up into discrete steps along each access prevents
    // tunneling and allows the player to slide along one axis if blocked
    // along the other.

    final stepDx = (destPosition.x - position.x) / numSteps;
    final stepDy = (destPosition.y - position.y) / numSteps;

    // Determine if the player is moving more than one unit at a time when
    // stepping. If we hit a collision while doing broad steps, we will do a
    // fine-grain adjustment to make sure the player gets as close to the
    // destination as possible.
    final hasBroadMovementX = stepDx.abs() > unit;
    final hasBroadMovementY = stepDy.abs() > unit;

    for (var i = 0; i < numSteps; i++) {
      // ------------------------------------------------------------------ //
      // Horizontal Stepping
      // ------------------------------------------------------------------ //
      position.setValues(position.x + stepDx, position.y);

      game.collisionDetection.run();

      if (collisionBehavior.isCollidingWithSurfaces) {
        // Hit something during a broad-phase horizontal movement.
        position.x = safeX;

        // Step by the individual unit amount from here to next x-step.
        // This brings us as close as we can get to the obstacle.
        while (hasBroadMovementX && position.x != destPosition.x) {
          final fineStep = stepDx.sign * unit;

          position.x += fineStep;

          game.collisionDetection.run();

          if (collisionBehavior.isCollidingWithSurfaces) {
            // Fine step hit something. We are as close as we can get.
            // Revert to the last successful fine-step.
            position.x -= fineStep;
            break;
          }

          safeX = position.x;
        }
      } else {
        safeX = position.x;
      }

      // ------------------------------------------------------------------ //
      // Vertical Stepping
      // ------------------------------------------------------------------ //
      position.setValues(position.x, position.y + stepDy);

      game.collisionDetection.run();

      if (collisionBehavior.isCollidingWithSurfaces) {
        // Hit something during a broad-phase vertical movement.
        position.y = safeY;

        // Step by the individual unit amount from here to next y-step.
        // This brings us as close as we can get to the obstacle.
        while (hasBroadMovementY && position.y != destPosition.y) {
          final fineStep = stepDy.sign * unit;

          position.y += fineStep;

          game.collisionDetection.run();

          if (collisionBehavior.isCollidingWithSurfaces) {
            // Fine step hit something. We are as close as we can get.
            // Revert to the last successful fine-step.
            position.y -= fineStep;
            break;
          }

          safeY = position.y;
        }
      } else {
        safeY = position.y;
      }
      // ------------------------------------------------------------------ //
    }

    nextPosition.setValues(safeX, safeY);

    return destPosition == nextPosition;
  }
}
