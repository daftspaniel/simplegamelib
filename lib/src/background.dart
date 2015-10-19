library simplegamelib.background;

import 'dart:math';
import 'dart:html';

/// Basic background data and drawing object.
class Background {
  String tag = '';
  CanvasRenderingContext2D canvas;
  ImageElement image;
  Rectangle limits;
  Background(this.canvas, this.limits) {}

  String _color;
  set color(String newColor) {
    _color = newColor;
    canvas.fillStyle = _color;
  }

  /// Sets an [Image] as the background
  setImageBackground(String filename) {
    image = new ImageElement(src: filename);
    image.onLoad.first;
  }

  /// Draw the background or just clear to the [CanvasElement] default color.
  void draw() {
    if (image != null) {
      canvas.drawImage(image, limits.left, limits.top);
    } else if (_color != null) {
      canvas.fillRect(limits.left, limits.top, limits.width, limits.height);
    } else {
      canvas.clearRect(limits.left, limits.top, limits.width, limits.height);
    }
  }
}
