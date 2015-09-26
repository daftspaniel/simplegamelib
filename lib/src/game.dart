import 'dart:html';
import 'unimplemented.dart';
import 'package:simplegamelib/simplegamelib.dart';
import 'dart:async';

/// Game object.
class Game {
  String name;
  Player p1;
  Arena arena;
  ResourcePack resources;
  Renderer renderer;
  SpriteGroup spriteGroup;
  Timer logup;

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

  void setDisplay(CanvasElement canvas) {
    renderer = new Renderer(canvas.getContext("2d"));
    renderer.addSpriteGroup(spriteGroup);
  }

  Sprite createSprite(String filename) {
    return spriteGroup.spriteFromFilename(filename);
  }

  void draw(num i) {
    renderer.draw();
    window.requestAnimationFrame(this.draw);
  }

  void start() {
    logup = new Timer.periodic(new Duration(milliseconds:20),  update);
    window.requestAnimationFrame(this.draw);
  }

  void update(Timer i){
    spriteGroup.update();
  }
}
