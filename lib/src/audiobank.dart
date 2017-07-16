library simplegamelib.audio;

import 'dart:html';

/// Audio Utility Class
/// Note : Dartium will NOT play MP3 files.
class AudioBank {
  final Map<String, AudioElement> sounds = {};

  /// Play the sound with the given name.
  void play(String name) {
    if (sounds.containsKey(name)) sounds[name].play();
  }

  /// Load a sound into the audio bank.
  void load(String name, String url) {
    var audioSource = new AudioElement();
    audioSource.src = url;
    sounds[name] = audioSource;
  }
}
