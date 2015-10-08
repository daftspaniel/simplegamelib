library simplegamelib.movements;
import 'dart:math';

/// The Movements class provides pairs of values for setting movements.
class Movements {
  static final west = new Point(-1, 0);
  static final east = new Point(1, 0);
  static final north = new Point(0, -1);
  static final south = new Point(0, 1);

  static final none = new Point(0, 0);
}
