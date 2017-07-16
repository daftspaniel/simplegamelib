library simplegamelib.movements;

import 'dart:math';

/// The Movements class provides pairs of values for setting movements.
class Movements {
  static final Point west = new Point(-1, 0);
  static final Point east = new Point(1, 0);
  static final Point north = new Point(0, -1);
  static final Point south = new Point(0, 1);

  static final Point northwest = new Point(-1, -1);
  static final Point northeast = new Point(1, -1);
  static final Point southwest = new Point(-1, 1);
  static final Point southeast = new Point(1, 1);

  static final Point none = new Point(0, 0);
}

/// Change direction of the current [Point].
Point reverseDirection(Point current,
    [bool changeHorizontal = true, bool changeVertical = true]) {
  int newVertical = changeVertical ? current.y * -1 : current.y;
  int newHorizontal = changeHorizontal ? current.x * -1 : current.x;
  return new Point(newHorizontal, newVertical);
}
