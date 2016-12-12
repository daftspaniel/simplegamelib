library simplegamelib.game;

import 'dart:async';
import 'dart:html';

import 'package:simplegamelib/simplegamelib.dart';

/// Core [Game] object - not mandatory to use but convenient.
/// All forms the basis of many demos so that they are not
/// cluttered with boilerplate code.
class Game {
  /// The name of the game.
  String name;
  Player player = new Player();
  final SpriteGroup spriteGroup = new SpriteGroup();
  final SpriteGroup collectiblesGroup = new SpriteGroup();

  Renderer renderer;
  Timer logicUpdate;
  Function customUpdate;
  Rectangle drawLimits;

  bool _running = false;

  /// The main [Game] constructor.
  Game(this.name, [String canvasID = ""]) {
    drawLimits = new Rectangle(0, 0, 800, 600);
    if (canvasID.length > 0) {
      CanvasElement canvas = querySelector(canvasID);
      setDisplay(canvas);
    }
  }

  /// Sets the display canvas property.
  void setDisplay(CanvasElement canvas) {
    renderer = new Renderer(canvas.getContext("2d"), drawLimits);
    renderer..addSpriteGroup(collectiblesGroup)..addSpriteGroup(spriteGroup);
  }

  /// Create a [Sprite] object and add it to the built in [SpriteGroup].
  Sprite createSprite(String filename, int width, int height) {
    return spriteGroup.spriteFromFilename(filename, width, height);
  }

  /// Draw the current scene with the [Renderer].
  void draw(num i) {
    renderer.draw();
    if (_running) window.requestAnimationFrame(this.draw);
  }

  /// Begin the game display and update loop.
  void start() {
    if (logicUpdate != null) {
      logicUpdate.cancel();
      logicUpdate = null;
    }
    logicUpdate = new Timer.periodic(new Duration(milliseconds: 20), update);

    _running = true;
    window.requestAnimationFrame(this.draw);
  }

  /// Stop the game playing.
  void stop() {
    if (logicUpdate == null) return;
    if (logicUpdate.isActive) {
      logicUpdate.cancel();
    }
    logicUpdate = null;
    _running = false;
  }

  /// Logic update loop using [Timer].
  void update(Timer i) {
    spriteGroup.update();
    if (customUpdate != null) customUpdate();

    // Default collectibles.
    collectiblesGroup.sprites.forEach((Collectible thing) {
      if (thing.detectCollision(player.sprite)) {
        player
          ..health += thing.healthDelta
          ..score += thing.scoreDelta;
        thing.alive = false;
        collectiblesGroup.removeDead();
      }
    });
  }

  /// Set some movement keys for the player [Sprite].
  void setUpKeys() {
    window.onKeyDown.listen((KeyboardEvent e) {
      if (player.sprite.dying) return;
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
      if (player.sprite.dying) return;
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
