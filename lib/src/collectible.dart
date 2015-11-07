library simplegamelib.collectible;

import 'sprite.dart';

/// A [Collectible] object can have -ve or +ve effects on health or score.
class Collectible extends Sprite {
  /// The health difference this object makes.
  int healthDelta = 0;

  /// The score difference this object makes.
  int scoreDelta = 0;

  Collectible() {}

  Collectible.fromFilename(String filename, int width, int height)
      : super.fromFilename(filename, width, height) {}
}
