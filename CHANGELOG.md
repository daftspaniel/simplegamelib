# Changelog

## 0.0.16

- Updates for Dart 2.0.

## 0.0.15

- Updates for Strong Mode DDC.
- New setPosition method on Sprite.

## 0.0.14

- Dependency updates and use of new generics.

## 0.0.13

- Fix rendering issue where background increasingly redrawn when game restarted.
- Refactoring.
- More tests.
- Custom background drawing function.

## 0.0.12

- Improved Player and Sprite lifecycle.
- Game now has a stop method.
- Sprite now has a property called speed.

## 0.0.11
- Added color property to background.
- Added Collectible class.
- Bug fixes for SpriteGroup - canvas not set on Sprites if null.

## 0.0.10
- Bug Fixes.
- Improved documentation comments.
- Sprite objects now have an obstacle list.
- SpriteGroup and sprite can now detect collision from a Rectangle.
- Added more Movements presets.

## 0.0.9
- Bug fix for width and height in Sprite constructor.
- Improved documentation comments.

## 0.0.8
- Sprite now has setters for x y.
- Sprite now has a limit Rectangle.
- Sprite now requires width and height for creation.
- Sprite now has stop method.
- SpriteGroup updated with Sprite changes.
- General documentation improvements.

## 0.0.7
- Added AudioBank class for loading and playing sounds.
- Improved Renderer to have area limits.
- Game now has a default collectables SpriteGroup.
- Improved tests and documentation.

## 0.0.6

- Added default keyboard handling for player to Game object.
- Started Player object which currently holds a field for the player's sprite object.

## 0.0.5

- Added more comments to the sprite group object.
- Added test and method to allow a SpriteGroup to be reversed.

## 0.0.4

- Added more comments to Game object.
- Added optional custom update hook to simplify demos.

## 0.0.3

- Added URL of homepage for package.

## 0.0.2

- HomepageUrl in Readme updated.
- Print statement commented out.

## 0.0.1

- Initial version to allow Demo 1 to use pub version rather than local.
