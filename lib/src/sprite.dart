library simplegamelib.sprite;

import 'dart:math';
import 'dart:html';

/// A Sprite is an on-screen entity that usually moves.
class Sprite {
  String tag = '';
  int x = 0;
  int y = 0;
  int width = 0;
  int height = 0;

  bool alive = true;
  bool dying = false;
  Point movement = new Point(0, 0);

  Rectangle rect;
  ImageElement image;
  CanvasRenderingContext2D canvas;

  set position(Point pos) {
    this.x = pos.x;
    this.y = pos.y;
  }

  // Create a [Sprite] from a file
  Sprite.fromFilename(String filename) {
    image = new ImageElement(src: filename);
    image.onLoad.first;
    width = image.width;
    height = image.height;
    updatePos();
  }

  Sprite(this.x, this.y, this.width, this.height) {
    updatePos();
  }

  void updatePos() {
    rect = new Rectangle(x, y, width, height);
  }

  void draw() {
    //print('Draw image $canvas $image $x $y');
    canvas.drawImage(image, this.x, this.y);
  }

  bool detectCollision(Sprite anotherEntity) {
    return rect.intersects(anotherEntity.rect);
  }

  void setMovement(int horizontal, int vertical) {
    movement = new Point(horizontal, vertical);
  }

  void update() {
    x += movement.x;
    y += movement.y;
    updatePos();
  }
}
