import 'dart:ui';

import 'package:flame/components.dart';

const gameWidth = 640.0;
const gameHeight = 360.0;
const gameBackgroundColor = Color(0xff3A3A50);
const playerStepTimeAnimation = 0.3;
final playerSpriteSheetSize = Vector2(32, 48);
const playerSpriteSheetFrames = 4;
const playerMoveSpeed = 75.0; // pixels/second
const customTypeProp = 'type';
const furnitureType = 'furniture';
const backgroundLayer = 'background';
const spawnPointObjectLayer = 'Spawnpoints';
const spawnPointPlayerClass = 'Player';
const collisionsObjectLayer = 'Collisions';
const puzzlesObjectLayer = 'Puzzles';
const firstPuzzleOverlay = 'firstPuzzle';
const secondPuzzleOverlay = 'secondPuzzle';
const thirdPuzzleOverlay = 'thirdPuzzle';
const escapeRoomTickDuration = Duration(seconds: 1);
const escapeRoomTicks = 120;
const escapeRoomMaxWrongAnswersAllowed = 3;
const escapeRoomNumberOfPuzzles = 3;
final Vector2 tileSize = Vector2.all(16);
const escapeRoomNumberOfHintsAllowed = 2;
