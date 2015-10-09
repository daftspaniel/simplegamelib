library simplegamelib.renderer;

import 'dart:html';
import 'background.dart';
import 'spritegroup.dart';

/// General purpose render engine.
class Renderer {
  List<SpriteGroup> _spriteGroups;

  Background liveBackground;
  CanvasRenderingContext2D gameCanvas;
  Rectangle limits;

  /// Creates a renderer for a specific canvas.
  Renderer(this.gameCanvas, this.limits) {
    liveBackground = new Background(this.gameCanvas, limits);
    resetGroups();
  }

  /// Add a [SpriteGroup] to the [List] of groups handled by this renderer.
  addSpriteGroup(SpriteGroup spriteGroup) {
    spriteGroup.canvas = gameCanvas;
    _spriteGroups.add(spriteGroup);
  }

  /// Draw [Background] and all [SpriteGroup] objects.
  draw() {
    liveBackground.draw();
    _spriteGroups.forEach((SpriteGroup spriteGroup) {
      spriteGroup.draw();
    });
  }

  /// Reset the group to empty.
  resetGroups() {
    _spriteGroups = new List<SpriteGroup>();
  }
}
