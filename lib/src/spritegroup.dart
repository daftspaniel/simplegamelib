library simplegamelib.spritegroup;

import 'dart:html';
import 'sprite.dart';

/// A collection of [Sprite] objects.
class SpriteGroup {
  List<Sprite> sprites;
  CanvasRenderingContext2D canvas;
  int get length => sprites.length;
  bool get empty => sprites.length == 0;

  /// Creates an empty [Sprite] group.
  SpriteGroup() {
    reset();
  }

  /// Set the group back to empty.
  reset() {
    sprites = new List<Sprite>();
  }

  /// Add a [Sprite] to the group.
  add(Sprite newSprite) {
    newSprite.canvas = canvas;
    sprites.add(newSprite);
  }

  /// Remove sprites that are marked as dead.
  removeDead() {
    sprites.removeWhere((Sprite sprite) => sprite.alive == false);
  }

  /// Update every [Sprite] in this group.
  update() {
    sprites.forEach((Sprite sprite) => sprite.update());
  }

  /// Detect collision between a [Sprite] and all the sprites in this group.
  List detectCollision(Sprite sprite) {
    List collisionSprites = new List();
    sprites.forEach((Sprite groupSprite) {
      if (groupSprite.detectCollision(sprite) &&
          groupSprite.dying == false) collisionSprites.add(groupSprite);
    });

    return collisionSprites;
  }

  /// Detects collision between a [Rectangle] and all the sprites in this group.
  List detectCollisionRectangle(Rectangle rect) {
    List collisionSprites = new List();
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
    sprite.canvas = canvas;
    return sprite;
  }

  /// Reverse the order of sprites in the list.
  void reverse() {
    sprites = new List.from(sprites.reversed);
  }
}
