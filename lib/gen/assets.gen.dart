/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsLogosGen {
  const $AssetsLogosGen();

  /// File path: assets/logos/movi.png
  AssetGenImage get movi => const AssetGenImage('assets/logos/movi.png');

  /// File path: assets/logos/moviBig.png
  AssetGenImage get moviBigPng =>
      const AssetGenImage('assets/logos/moviBig.png');

  /// File path: assets/logos/moviBig.webp
  AssetGenImage get moviBigWebp =>
      const AssetGenImage('assets/logos/moviBig.webp');

  /// File path: assets/logos/univali.png
  AssetGenImage get univali => const AssetGenImage('assets/logos/univali.png');

  /// List of all assets
  List<AssetGenImage> get values => [movi, moviBigPng, moviBigWebp, univali];
}

class $AssetsMascotsGen {
  const $AssetsMascotsGen();

  /// File path: assets/mascots/tuba.png
  AssetGenImage get tuba => const AssetGenImage('assets/mascots/tuba.png');

  /// File path: assets/mascots/whale.png
  AssetGenImage get whale => const AssetGenImage('assets/mascots/whale.png');

  /// List of all assets
  List<AssetGenImage> get values => [tuba, whale];
}

class $AssetsQuizzGen {
  const $AssetsQuizzGen();

  /// File path: assets/quizz/crystals.png
  AssetGenImage get crystalsPng =>
      const AssetGenImage('assets/quizz/crystals.png');

  /// File path: assets/quizz/crystals.webp
  AssetGenImage get crystalsWebp =>
      const AssetGenImage('assets/quizz/crystals.webp');

  /// File path: assets/quizz/dots.svg
  String get dots => 'assets/quizz/dots.svg';

  /// List of all assets
  List<dynamic> get values => [crystalsPng, crystalsWebp, dots];
}

class $AssetsSectionsGen {
  const $AssetsSectionsGen();

  /// File path: assets/sections/Beige.jpg
  AssetGenImage get beige => const AssetGenImage('assets/sections/Beige.jpg');

  /// File path: assets/sections/Black.jpg
  AssetGenImage get black => const AssetGenImage('assets/sections/Black.jpg');

  /// File path: assets/sections/Black2.jpg
  AssetGenImage get black2 => const AssetGenImage('assets/sections/Black2.jpg');

  /// File path: assets/sections/blue.jpg
  AssetGenImage get blue => const AssetGenImage('assets/sections/blue.jpg');

  /// File path: assets/sections/brown.jpg
  AssetGenImage get brown => const AssetGenImage('assets/sections/brown.jpg');

  /// File path: assets/sections/exhibition.jpg
  AssetGenImage get exhibition =>
      const AssetGenImage('assets/sections/exhibition.jpg');

  /// File path: assets/sections/gray.jpg
  AssetGenImage get gray => const AssetGenImage('assets/sections/gray.jpg');

  /// File path: assets/sections/green.jpg
  AssetGenImage get green => const AssetGenImage('assets/sections/green.jpg');

  /// File path: assets/sections/red.jpg
  AssetGenImage get red => const AssetGenImage('assets/sections/red.jpg');

  /// List of all assets
  List<AssetGenImage> get values =>
      [beige, black, black2, blue, brown, exhibition, gray, green, red];
}

class $AssetsTourGen {
  const $AssetsTourGen();

  /// File path: assets/tour/fast.svg
  String get fast => 'assets/tour/fast.svg';

  /// List of all assets
  List<String> get values => [fast];
}

class Assets {
  Assets._();

  static const $AssetsLogosGen logos = $AssetsLogosGen();
  static const $AssetsMascotsGen mascots = $AssetsMascotsGen();
  static const AssetGenImage movi = AssetGenImage('assets/movi.png');
  static const $AssetsQuizzGen quizz = $AssetsQuizzGen();
  static const $AssetsSectionsGen sections = $AssetsSectionsGen();
  static const $AssetsTourGen tour = $AssetsTourGen();
  static const AssetGenImage univali = AssetGenImage('assets/univali.jpg');
  static const AssetGenImage univaliBlackWhite =
      AssetGenImage('assets/univali_black_white.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [movi, univali, univaliBlackWhite];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}