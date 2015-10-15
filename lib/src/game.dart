library simplegamelib.game;

import 'dart:html';
import 'unimplemented.dart';
import 'package:simplegamelib/simplegamelib.dart';
import 'dart:async';

/// Core [Game] object - not mandatory to use but convenient.
/// All forms the basis of many demos so that they are not
/// cluttered with boilerplate code.
class Game {
  /// The name of the game.
  String name;
  Player player;
  Arena arena;
  ResourcePack resources;
  Renderer renderer;
  SpriteGroup spriteGroup;
  SpriteGroup collectablesGroup;
  Timer logicUpdate;
  Function customUpdate;
  Rectangle drawLimits;

  /// The main game constructor.
  Game(this.name, [String canvasID = ""]) {
    player = new Player();
    arena = new Arena();
    resources = new ResourcePack();
    spriteGroup = new SpriteGroup();
    collectablesGroup = new SpriteGroup();
    drawLimits = new Rectangle(0, 0, 800, 600);
    if (canvasID.length > 0) {
      CanvasElement canvas = querySelector(canvasID);
      setDisplay(canvas);
    }
  }

  /// Sets the display canvas property.
  void setDisplay(CanvasElement canvas) {
    renderer = new Renderer(canvas.getContext("2d"), drawLimits);
    renderer..addSpriteGroup(collectablesGroup)..addSpriteGroup(spriteGroup);
  }

  /// Create a [Sprite] object and add it to the built in [SpriteGroup].
  Sprite createSprite(String filename) {
    return spriteGroup.spriteFromFilename(filename);
  }

  /// Draw the current scene with the [Renderer].
  void draw(num i) {
    renderer.draw();
    window.requestAnimationFrame(this.draw);
  }

  /// Begin the game display and update loop.
  void start() {
    logicUpdate = new Timer.periodic(new Duration(milliseconds: 20), update);
    window.requestAnimationFrame(this.draw);
  }

  /// Logic update loop.
  void update(Timer i) {
    spriteGroup.update();
    if (customUpdate != null) customUpdate();
  }

  /// Set some movement keys for the player [Sprite].
  void setUpKeys() {
    window.onKeyDown.listen((KeyboardEvent e) {
      print(e);
      if (e.keyCode == 38) {
        player.sprite.movement = new Point(player.sprite.movement.x, -1);
      }
      if (e.keyCode == 40) {
        player.sprite.movement = new Point(player.sprite.movement.x, 1);
      }
      if (e.keyCode == 39) {
        player.sprite.movement = new Point(1, player.sprite.movement.y);
      }
      if (e.keyCode == 37) {
        player.sprite.movement = new Point(-1, player.sprite.movement.y);
      }
    });

    window.onKeyUp.listen((KeyboardEvent e) {
      if (e.keyCode == 38) {
        player.sprite.movement = new Point(player.sprite.movement.x, 0);
      }
      if (e.keyCode == 40) {
        player.sprite.movement = new Point(player.sprite.movement.x, 0);
      }
      if (e.keyCode == 39) {
        player.sprite.movement = new Point(0, player.sprite.movement.y);
      }
      if (e.keyCode == 37) {
        player.sprite.movement = new Point(0, player.sprite.movement.y);
      }
    });
  }
}
