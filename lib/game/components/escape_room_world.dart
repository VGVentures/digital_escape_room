import 'dart:async';

import 'package:digital_escape_room/game/components/player/player_collider.dart';
import 'package:digital_escape_room/game/escape_room_map.dart';
import 'package:digital_escape_room/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class EscapeRoomWorld extends World {
  EscapeRoomWorld({required this.mapFilename});

  String mapFilename;

  /// Original map, for reference.
  late EscapeRoomMap map;
  late TiledComponent mapLevel;

  late EscapeRoomMap background;
  late TiledComponent backgroundLevel;

  final List<EscapeRoomMap> furniture = [];
  final List<TiledComponent> furnitureProps = [];

  @override
  FutureOr<void> onLoad() async {
    // Load the map repeatedly, filtering out the layers we want into different
    // flame components. Why? Because we construct props out of group layers
    // using tiles. That's just how the artwork is setup.
    //
    // I'm not particularly proud of it, but it works. Unless maps become very
    // large, this will be fine.
    //
    // We have to create separate TiledComponent(s) for each layer, since we
    // need to enable y-sorting to make the player appear behind or in front of
    // the props.
    map = await EscapeRoomMap.load(
      filename: mapFilename,
      tileSize: tileSize,
    );
    mapLevel = TiledComponent(map.renderableTiledMap);

    final furnitureLayerNames = map.tiledMap.layers
        .where(
          (layer) =>
              layer.properties.byName[customTypeProp]?.value == furnitureType,
        )
        .map((layer) => layer.name);

    final backgroundTask = EscapeRoomMap.load(
      filename: mapFilename,
      tileSize: tileSize,
      mapTransformer: (map) => map.layers.retainWhere(
        (layer) =>
            layer.properties.byName[customTypeProp]?.value == backgroundLayer,
      ),
    );

    final furnitureFutures = <Future<EscapeRoomMap>>[];

    for (final layerName in furnitureLayerNames) {
      furnitureFutures.add(
        EscapeRoomMap.load(
          filename: mapFilename,
          tileSize: tileSize,
          mapTransformer: (map) => map.layers.retainWhere(
            (layer) => layer.name == layerName,
          ),
        ),
      );
    }

    final futures = await Future.wait([backgroundTask, ...furnitureFutures]);
    background = futures[0];

    furniture.addAll(futures.sublist(1));

    backgroundLevel = TiledComponent(background.renderableTiledMap);

    add(backgroundLevel);

    for (final furnitureMap in furniture) {
      final originLayer = (furnitureMap.tiledMap.layers.single as Group)
          .layers
          .firstWhere((layer) => layer is ObjectGroup) as ObjectGroup;

      // y-sorting: the origin's y position is the render priority.
      // grab all object y positions and average them to make the originY
      final originY =
          originLayer.objects.map((obj) => obj.y).reduce((a, b) => a + b) /
              originLayer.objects.length;

      final priority = originY.floor();

      final furnitureProp =
          TiledComponent(furnitureMap.renderableTiledMap, priority: priority);

      furnitureProps.add(furnitureProp);

      add(furnitureProp);
    }

    _loadSpawnPoints();
    _loadCollisions();
    _loadPuzzles();
    return super.onLoad();
  }

  void _loadSpawnPoints() {
    final spawnPointsLayer =
        mapLevel.tileMap.getLayer<ObjectGroup>(spawnPointObjectLayer);
    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case spawnPointPlayerClass:
            final position = Vector2(spawnPoint.x, spawnPoint.y);
            final colliderPosition =
                position + Vector2(0, spawnPoint.height + spawnPoint.width);
            final colliderSize = Vector2.all(spawnPoint.width);
            final hitbox = RectangleHitbox(size: colliderSize);
            final collider = PlayerCollider(
              size: colliderSize,
              position: colliderPosition,
              hitbox: hitbox,
            );
            final player = Player(
              character: 'conference_woman',
              collider: collider,
              position: position,
              size: Vector2(spawnPoint.width, spawnPoint.height),
            );
            add(collider);
            add(player);
          default:
            throw UnimplementedError('${spawnPoint.class_} not implemented');
        }
      }
    }
  }

  void _loadCollisions() {
    final collisionsLayer =
        mapLevel.tileMap.getLayer<ObjectGroup>(collisionsObjectLayer);
    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        add(
          CollisionBlock(
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
          ),
        );
      }
    }
  }

  void _loadPuzzles() {
    final puzzleLayer =
        mapLevel.tileMap.getLayer<ObjectGroup>(puzzlesObjectLayer);
    if (puzzleLayer != null) {
      for (final collision in puzzleLayer.objects) {
        add(
          Puzzle(
            overlayKey: collision.properties.getValue<String>('puzzle')!,
            position: Vector2(collision.x, collision.y),
            size: Vector2(collision.width, collision.height),
          ),
        );
      }
    }
  }
}
