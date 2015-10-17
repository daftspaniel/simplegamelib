library simplegamelib.sprite;

import 'dart:math';
import 'dart:html';
import 'movements.dart';
import 'spritegroup.dart';

/// A Sprite is an on-screen entity that usually moves.
class Sprite {
  String tag = '';

  int _x = 0;
  int _y = 0;
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

  /// List of [Sprite] objects that this one can't overlap.
  SpriteGroup obstacles;

  /// Move the [Sprite] to position in [Point]. No checks made.
  set position(Point pos) {
    this._x = pos.x;
    this._y = pos.y;
    updatePos();
  }

  /// Relative speed acts as multiplier for movement values.
  set speed(int newSpeed) {
    _speed = newSpeed;
  }

  int get x {
    return _x;
  }

  int get y {
    return _y;
  }

  set x(int newX) {
    _x = newX;
    updatePos();
  }

  set y(int newY) {
    _y = newY;
    updatePos();
  }

  /// Create a [Sprite] from a file
  Sprite.fromFilename(String filename, this.width, this.height) {
    image = new ImageElement(src: filename);
    image.onLoad.first;
    updatePos();
  }

  /// Create a [Sprite] with no image. Intended for subclasses and testing.
  Sprite(this._x, this._y, this.width, this.height) {
    updatePos();
  }

  /// Update the positional [Rectangle] for this [Sprite].
  void updatePos() {
    rect = new Rectangle(_x, _y, width, height);
  }

  /// Draw this [Sprite].
  void draw() {
    //print('Draw image $canvas $image $x $y');
    canvas.drawImage(image, this._x, this._y);
  }

  /// Detect if the [Rectangle] of the supplied [Sprite] collides with this one.
  bool detectCollision(Sprite anotherEntity) {
  return rect.intersects(anotherEntity.rect);
  }

  /// Detect if the [Rectangle] of the supplied [Rectangle] collides with this one.
  bool detectCollisionRectangle(Rectangle targetRect) {
    return rect.intersects(targetRect);
  }

  /// Set movement values.
  void setMovement(int horizontal, int vertical) {
    movement = new Point(horizontal, vertical);
  }

  /// Stop the [Sprite] moving.
  void stop() {
    movement = Movements.none;
  }

  /// Updated the [Sprite]'s positional [Rectangle] depending on movement, speed and limiter settings.
  void update() {
    int xMove = movement.x * _speed;
    int yMove = movement.y * _speed;
    Rectangle nextRect;

    // Limit sprite to area of display.
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

    //obstacles
    if (obstacles != null){
      nextRect =
      new Rectangle(rect.left + xMove, rect.top + yMove, rect.width, rect.height);
      if (obstacles.detectCollisionRectangle(nextRect).length>0){
        return;
      }
    }

    _x += xMove;
    _y += yMove;

    if (0 != xMove || 0 != yMove) updatePos();
  }
}
