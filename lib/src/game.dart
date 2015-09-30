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
  Player p1;
  Arena arena;
  ResourcePack resources;
  Renderer renderer;
  SpriteGroup spriteGroup;
  Timer logup;
  Function customUpdate;

  /// The main game constructor.
  Game(this.name, [String canvasID = ""]) {
    p1 = new Player();
    arena = new Arena();
    resources = new ResourcePack();
    spriteGroup = new SpriteGroup();
    if (canvasID.length > 0) {
      CanvasElement canvas = querySelector(canvasID);
      setDisplay(canvas);
    }
  }

  /// Sets the display canvas property.
  void setDisplay(CanvasElement canvas) {
    renderer = new Renderer(canvas.getContext("2d"));
    renderer.addSpriteGroup(spriteGroup);
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
    logup = new Timer.periodic(new Duration(milliseconds: 20), update);
    window.requestAnimationFrame(this.draw);
  }

  /// Logic update loop.
  void update(Timer i) {
    spriteGroup.update();
    if (customUpdate != null) customUpdate();
  }
}
