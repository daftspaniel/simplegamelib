library simplegamelib.background;

import 'dart:html';
import 'dart:math';

/// Basic background data and drawing object.
class Background {
  String tag = '';

  CanvasRenderingContext2D canvas;
  ImageElement image;
  Rectangle limits;
  Function postCustomDraw;

  Background(this.canvas, this.limits);

  String _color;

  /// Sets the [CanvasRenderingContext2D] fillStyle color.
  set color(String newColor) {
    _color = newColor;
    canvas.fillStyle = _color;
  }

  /// Sets an [Image] as the background
  void loadImage(String filename) {
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

    if (postCustomDraw != null) {
      postCustomDraw(canvas);
    }
  }
}
