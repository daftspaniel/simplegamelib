library simplegamelib.movements;

import 'dart:math';

/// The Movements class provides pairs of values for setting movements.
class Movements {
  static final west = new Point(-1, 0);
  static final east = new Point(1, 0);
  static final north = new Point(0, -1);
  static final south = new Point(0, 1);

  static final northwest = new Point(-1, -1);
  static final northeast = new Point(1, -1);
  static final southwest = new Point(-1, 1);
  static final southeast = new Point(1, 1);

  static final none = new Point(0, 0);
}

/// Change direction of the current [Point].
Point reverseDirection(Point current,
    [ bool changeHorizontal = true, bool changeVertical = true]) {
  int newVertical = changeVertical ? current.y * -1 : current.y;
  int newHorizontal = changeHorizontal ? current.x * -1 : current.x;
  return new Point(newHorizontal, newVertical);
}