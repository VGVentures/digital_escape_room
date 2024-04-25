import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class CollisionBlock extends PositionComponent with EntityMixin {
  CollisionBlock({required super.size, required super.position});

  @override
  FutureOr<void> onLoad() {
    // Passive collision boxes only care about collisions with active ones,
    // like the player's hitbox.
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }
}
