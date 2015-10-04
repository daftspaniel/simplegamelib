library renderer;

import 'dart:html';
import 'background.dart';
import 'spritegroup.dart';

/// General purpose render engine.
class Renderer {
  List<SpriteGroup> _spriteGroups;

  Background liveBackground;
  CanvasRenderingContext2D gameCanvas;

  Renderer(this.gameCanvas) {
    liveBackground = new Background();
    liveBackground.canvas = this.gameCanvas;
    resetGroups();
  }

  addSpriteGroup(SpriteGroup spriteGroup) {
    spriteGroup.canvas = gameCanvas;
    _spriteGroups.add(spriteGroup);
  }

  draw() {
    liveBackground.draw();
    _spriteGroups.forEach((SpriteGroup spriteGroup) {
      spriteGroup.draw();
    });
  }

  resetGroups() {
    _spriteGroups = new List<SpriteGroup>();
  }
}
