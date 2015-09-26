import 'package:simplegamelib/simplegamelib.dart';
import 'dart:html';

Sprite createSprite(){return new Sprite(1,2,3,4);}

SpriteGroup createSpriteGroup(int count){
  SpriteGroup sg = new SpriteGroup();
  for(int i=0;i<count;i++)
    sg.add(createSprite());
  return sg;
}

CanvasRenderingContext2D getCanvas(){
  CanvasElement CanvasTag = new CanvasElement();
  CanvasRenderingContext2D GameCanvas = CanvasTag.getContext("2d");
  return GameCanvas;
}
