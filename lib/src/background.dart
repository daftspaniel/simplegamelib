import 'dart:math';
import 'dart:html';

/// Basic background data and drawing object.
class Background {
  String tag = '';
  Rectangle rect = null;
  CanvasRenderingContext2D canvas;

  void draw() {
    canvas.clearRect(0, 0, 800, 600);
  }

}
