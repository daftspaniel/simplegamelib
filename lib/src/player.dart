library simplegamelib.player;
import 'sprite.dart';

/// Active agent taking part in the game.
class Player {
  Sprite sprite;

  int health;
  int score;
  String name;

  Player(){
    reset();
  }

  void  reset(){
    health = 100;
    score = 0;
    name = "Player1";
  }
}