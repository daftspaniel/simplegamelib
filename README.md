# simplegamelib

Heads Up - this is a very early release!

[![Build Status](https://travis-ci.org/daftspaniel/simplegamelib.svg?branch=master)](https://travis-ci.org/daftspaniel/simplegamelib)

An easy to use package for 2D games. It is going to be awesome.

## Usage

A simple usage example:

    import 'dart:html';
    import 'package:simplegamelib/simplegamelib.dart';

    void main() {
      Game game = new Game("My Game", '#surface');
      Sprite player = game.createSprite("images/ninjadude.png");

      player
        ..position = new Point(0, 10)
        ..movement = Movements.east;
		
      print('starting game...');
      game.start();
    }


## Features and bugs

Github : https://github.com/daftspaniel/simplegamelib

## To run unit tests.

    pub run test .\test\simplegamelib_test.dart -p dartium
