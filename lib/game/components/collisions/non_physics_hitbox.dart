import 'package:flame/collisions.dart';

/// Puzzle mixin. Add this to a hitbox to make it trigger a puzzle.
/// Puzzle hitboxes do not act as physics hitboxes.
class NonPhysicsHitbox extends RectangleHitbox {
  NonPhysicsHitbox({
    super.position,
    super.size,
    super.angle,
    super.anchor,
    super.priority,
    super.isSolid,
    super.collisionType,
  });
}
