library simplegamelib.spritegroup;

import 'dart:html';

import 'sprite.dart';

/// A collection of [Sprite] objects.
class SpriteGroup {
  final List<Sprite> sprites = new List<Sprite>();
  CanvasRenderingContext2D canvas;

  int get length => sprites.length;

  bool get isEmpty => sprites.length == 0;

  /// Creates an empty [Sprite] group.
  SpriteGroup() {
    reset();
  }

  /// Set the group back to empty.
  reset() {
    sprites.clear();
  }

  /// Add a [Sprite] to the group.
  add(Sprite newSprite) {
    if (canvas != null) newSprite.canvas = canvas;
    sprites.add(newSprite);
  }

  /// Remove sprites that are marked as dead.
  removeDead() {
    sprites.removeWhere((Sprite sprite) => sprite.alive == false);
  }

  /// Update every [Sprite] in this group.
  update() {
    sprites.forEach((Sprite sprite) => sprite.update());
    removeDead();
  }

  /// Detect collision between a [Sprite] and all the sprites in this group.
  List<Sprite> detectCollision(Sprite sprite) {
    List<Sprite> collisionSprites = new List();
    sprites.forEach((Sprite groupSprite) {
      if (groupSprite.detectCollision(sprite) && groupSprite.dying == false)
        collisionSprites.add(groupSprite);
    });

    return collisionSprites;
  }

  /// Detects collision between a [Rectangle] and all the sprites in this group.
  List detectCollisionRectangle(Rectangle rect) {
    List<Sprite> collisionSprites = new List();
    sprites.forEach((Sprite groupSprite) {
      if (groupSprite.detectCollisionRectangle(rect) &&
          groupSprite.dying == false) collisionSprites.add(groupSprite);
    });

    return collisionSprites;
  }

  /// Draw every [Sprite] in the sprite list.
  void draw() {
    sprites.forEach((Sprite sprite) {
      sprite.draw();
    });
  }

  /// Create a [Sprite] from a supplied filename.
  Sprite spriteFromFilename(String filename, int width, int height) {
    Sprite sprite = new Sprite.fromFilename(filename, width, height);
    add(sprite);
    if (canvas != null) sprite.canvas = canvas;
    return sprite;
  }

  /// Reverse the order of sprites in the list.
  void reverse() {
    List<Sprite> revd = new List.from(sprites.reversed);
    sprites.clear();
    sprites.addAll(revd);
  }
}
