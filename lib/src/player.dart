library simplegamelib.player;

import 'sprite.dart';
import 'collectible.dart';

/// Active agent taking part in the game.
class Player {
  Sprite sprite;
  int _score;
  int _health;
  int _lives;

  int get health => _health;
  int get score => _score;
  int get lives => _lives;

  set health(int newHealth) {
    _health = newHealth;
    update();
  }

  set score(int newScore) {
    _score = newScore;
    update();
  }

  set lives(int newLives) {
    _lives = newLives;
    update();
  }

  String name;
  Function _updateNotification;

  /// Default constructor.
  Player() {
    reset();
  }

  /// Constructor that allows setting of update notifications.
  /// For example, a score display.
  Player.withNotifications(Function updateNotification) {
    reset();
    _updateNotification = updateNotification;
  }

  /// Standard initialisation.
  void reset() {
    health = 100;
    score = 0;
    name = "Player1";
    lives = 3;
  }

  /// Updates and notifies of changes to properties
  void update() {
    if (_updateNotification != null) _updateNotification(this);
  }

  /// Alive flag taken from [Sprite].
  bool get alive => sprite.alive;

  /// Apply [Collectible] object to this player
  apply(Collectible powerUp) {
    score += powerUp.scoreDelta;
    health += powerUp.healthDelta;
  }
}
