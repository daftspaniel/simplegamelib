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

  int _speed = 1;

  bool alive = true;
  bool dying = false;
  Point movement = new Point(0, 0);

  Rectangle rect;
  Rectangle limits;
  ImageElement image;
  CanvasRenderingContext2D canvas;

  set position(Point pos) {
    this.x = pos.x;
    this.y = pos.y;
  }

  void set speed(int newSpeed) {
    _speed = newSpeed;
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

  // Update the positional [Rectangle] for this [Sprite].
  void updatePos() {
    rect = new Rectangle(x, y, width, height);
  }

  // Draw this [Sprite].
  void draw() {
    //print('Draw image $canvas $image $x $y');
    canvas.drawImage(image, this.x, this.y);
  }

  /// Detect if the [Rectangle] of the supplied [Sprite] collides with this one.
  bool detectCollision(Sprite anotherEntity) {
    return rect.intersects(anotherEntity.rect);
  }

  // Set movement values.
  void setMovement(int horizontal, int vertical) {
    movement = new Point(horizontal, vertical);
  }

  // Updated the sprites positional [Rectangle] depending on movement, speed and limiter settings.
  void update() {
    int xMove = movement.x * _speed;
    int yMove = movement.y * _speed;
    Rectangle nextRect;

    if (limits != null) {
      nextRect =
          new Rectangle(rect.left + xMove, rect.top, rect.width, rect.height);
      if (!limits.containsRectangle(nextRect)) {
        xMove = 0;
      }
      nextRect =
          new Rectangle(rect.left, rect.top + yMove, rect.width, rect.height);
      if (!limits.containsRectangle(nextRect)) {
        yMove = 0;
      }
    }

    x += xMove;
    y += yMove;

    if (0 != xMove || 0 != yMove) updatePos();
  }
}
