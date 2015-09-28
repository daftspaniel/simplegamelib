library simplegamelib.spritegroup;

import 'sprite.dart';
import 'dart:html';

/// A collection of [Sprite] objects.
class SpriteGroup {
  List<Sprite> sprites;
  CanvasRenderingContext2D canvas;
  int get length => sprites.length;
  bool get empty => sprites.length == 0;

  SpriteGroup() {
    reset();
  }

  reset() {
    sprites = new List<Sprite>();
  }

  add(Sprite newSprite) {
    newSprite.canvas = canvas;
    sprites.add(newSprite);
  }

  removeDead() {
    sprites.removeWhere((Sprite sprite) => sprite.alive == false);
  }

  update() {
    sprites.forEach((Sprite sprite) => sprite.update());
  }

  List detectCollision(Sprite sprite) {
    List collisionSprites = new List();
    sprites.forEach((groupSprite) {
      if (groupSprite.detectCollision(sprite) &&
          groupSprite.dying == false) collisionSprites.add(groupSprite);
    });

    return collisionSprites;
  }

  void draw() {
    sprites.forEach((Sprite sprite) {
      sprite.draw();
    });
  }

  Sprite spriteFromFilename(String filename) {
    Sprite sprite = new Sprite.fromFilename(filename);
    add(sprite);
    sprite.canvas = canvas;
    return sprite;
  }
}
