library simplegamelib.player;

import 'sprite.dart';

/// Active agent taking part in the game.
class Player {

  Sprite sprite;

  int health;
  int score;
  int lives;

  String name;

  Player() {
    reset();
  }

  /// Standard initialisation.
  void reset() {
    health = 100;
    score = 0;
    name = "Player1";
    lives = 3;
  }

  // Alive flag taken from [Sprite].
  bool get alive => sprite.alive;

}
