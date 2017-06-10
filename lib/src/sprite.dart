library simplegamelib.sprite;

import 'dart:html';
import 'dart:math';

import 'movements.dart';
import 'spritegroup.dart';

/// A Sprite is an on-screen entity that usually moves.
class Sprite {
  int _x = 0;
  int _y = 0;
  int _width = 0;
  int _height = 0;

  int _speed = 1;
  String tag = '';
  int cyclesToDie = 200;

  bool alive = true;
  bool dying = false;
  bool bounce = false;

  Point movement = new Point(0, 0);

  Rectangle rect;
  Rectangle limits;
  ImageElement image;
  ImageElement imageDying;
  CanvasRenderingContext2D canvas;

  /// List of [Sprite] objects that this one can't overlap.
  SpriteGroup obstacles;

  int get x => _x;

  int get y => _y;

  int get width => _width;

  int get height => _height;

  int get speed => _speed;

  set width(int newWidth) {
    _width = newWidth;
    updatePos();
  }

  set height(int newHeight) {
    _height = newHeight;
    updatePos();
  }

  set x(int newX) {
    _x = newX;
    updatePos();
  }

  set y(int newY) {
    _y = newY;
    updatePos();
  }

  /// Move the [Sprite] to position in [Point]. No checks made.
  set position(Point pos) {
    this._x = pos.x;
    this._y = pos.y;
    updatePos();
  }

  /// Move the [Sprite] to position x y. No checks made.
  setPosition(int x, int y) {
    this._x = x;
    this._y = y;
    updatePos();
  }

  /// Relative speed acts as multiplier for movement values.
  set speed(int newSpeed) {
    _speed = newSpeed;
  }

  /// Create a [Sprite] from a file.
  Sprite.fromFilename(String filename, this._width, this._height) {
    image = new ImageElement(src: filename);
    image.onLoad.first;
    updatePos();
  }

  /// Set the dying image for this [Sprite].
  setDyingImage(String filename) {
    imageDying = new ImageElement(src: filename);
    imageDying.onLoad.first;
  }

  /// Default Constructor.Intended for subclasses.
  Sprite() {}

  /// Create a [Sprite] with no image. Intended for testing.
  Sprite.noImage(this._x, this._y, this._width, this._height) {
    updatePos();
  }

  /// Update the positional [Rectangle] for this [Sprite].
  void updatePos() {
    rect = new Rectangle(_x, _y, _width, _height);
  }

  /// Draw this [Sprite].
  void draw() {
    if (!dying || imageDying == null) {
      canvas.drawImage(image, _x, _y);
    } else {
      canvas.drawImage(imageDying, _x, _y);
    }
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
    if (dying) {
      cyclesToDie--;
      if (cyclesToDie < 1) {
        dying = false;
        alive = false;
      }
    }

    int xMove = movement.x * _speed;
    int yMove = movement.y * _speed;
    Rectangle nextRect;

    // Limit sprite to area of display.
    if (limits != null) {
      nextRect =
      new Rectangle(rect.left + xMove, rect.top, rect.width, rect.height);

      if (!limits.containsRectangle(nextRect)) {
        xMove = 0;
        if (bounce) movement = reverseDirection(movement, true, false);
      }
      nextRect =
      new Rectangle(rect.left, rect.top + yMove, rect.width, rect.height);

      if (!limits.containsRectangle(nextRect)) {
        yMove = 0;
        if (bounce) movement = reverseDirection(movement, false, true);
      }
    }

    //obstacles
    if (obstacles != null) {
      nextRect = new Rectangle(
          rect.left + xMove, rect.top + yMove, rect.width, rect.height);
      if (obstacles
          .detectCollisionRectangle(nextRect)
          .length > 0) {
        return;
      }
    }

    // do actual move.
    _x += xMove;
    _y += yMove;

    if (0 != xMove || 0 != yMove) updatePos();
  }
}
