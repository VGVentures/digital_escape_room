import 'package:digital_escape_room/game/components/collisions/collisions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

/// Propagating collision behavior that only collides with hitboxes that are not
/// instances of [NonPhysicsHitbox]. [NonPhysicsHitbox] is used to represent
/// hitboxes that are not meant to be used for physics collisions.
class PhysicsPropagatingCollisionBehavior extends PropagatingCollisionBehavior {
  PhysicsPropagatingCollisionBehavior(
    super._hitbox, {
    super.priority,
    super.key,
  });

  /// True if we are colliding with surfaces that.
  bool get isCollidingWithSurfaces =>
      super.isColliding &&
      activeCollisions.any((hitbox) => hitbox is! NonPhysicsHitbox);
}
