import 'package:digital_escape_room/game/components/collisions/collisions.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class Puzzle extends PositionComponent with EntityMixin {
  Puzzle({
    required this.overlayKey,
    required super.size,
    required super.position,
  }) : super(
          children: [
            NonPhysicsHitbox(collisionType: CollisionType.passive, size: size),
          ],
        );

  final String overlayKey;
}
