import 'package:digital_escape_room/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class PuzzleChallengeBehavior extends CollisionBehavior<Puzzle, Player>
    with HasGameRef<EscapeRoomGame> {
  @override
  bool isValid(Component c) => c is Puzzle;

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, Puzzle other) {
    game.overlays.add(other.overlayKey);
    super.onCollision(intersectionPoints, other);
  }
}
