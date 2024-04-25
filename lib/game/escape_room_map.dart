import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';

class EscapeRoomMap {
  EscapeRoomMap._({
    required this.tiledMap,
    required this.renderableTiledMap,
  });

  final TiledMap tiledMap;
  final RenderableTiledMap renderableTiledMap;

  static Future<EscapeRoomMap> load({
    required String filename,
    required Vector2 tileSize,
    void Function(TiledMap)? mapTransformer,
    AssetBundle? bundle,
    String? prefix,
  }) async {
    bundle ??= Flame.bundle;
    prefix ??= 'assets/tiles/';

    final mapContents = await Flame.bundle.loadString('$prefix$filename');
    final tiledMap = await TiledMap.fromString(
      mapContents,
      (key) => FlameTsxProvider.parse(key, bundle),
    );

    mapTransformer?.call(tiledMap);

    final renderableTiledMap =
        await RenderableTiledMap.fromTiledMap(tiledMap, tileSize);

    return EscapeRoomMap._(
      tiledMap: tiledMap,
      renderableTiledMap: renderableTiledMap,
    );
  }
}
