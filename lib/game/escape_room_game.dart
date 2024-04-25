import 'dart:async';

import 'package:digital_escape_room/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class EscapeRoomGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late final CameraComponent cam;
  @override
  Color backgroundColor() => gameBackgroundColor;

  @override
  final world = EscapeRoomWorld(mapFilename: _levels.random());

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    cam = CameraComponent.withFixedResolution(
      width: gameWidth,
      height: gameHeight,
      world: world,
    );
    cam.viewfinder.anchor = Anchor.topLeft;
    await addAll([cam, world]);
    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);
    return KeyEventResult.handled;
  }

  static const _levels = [
    'escape-room-01.tmx',
    'escape-room-02.tmx',
    'escape-room-03.tmx',
    'escape-room-04.tmx',
    'escape-room-05.tmx',
    'escape-room-06.tmx',
    'escape-room-07.tmx',
    'escape-room-08.tmx',
    'escape-room-09.tmx',
    'escape-room-10.tmx',
  ];
}
