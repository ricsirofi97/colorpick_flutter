import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../game_page.dart';

class GameController {
  final player = AudioCache(prefix: 'assets/sounds/', fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
  String sound = "";

  void loadSounds() async{
    debugPrint('load buttons-------------------------------------------------------');
    await player.loadAll(['sound1.mp3', 'sound2.mp3', 'sound3.mp3', 'sound4.mp3']);
  }

  void playSound(buttons button) async{

    switch(button){

      case buttons.RED:
        sound += "sound1.mp3";
        break;
      case buttons.GREEN:
        sound += "sound2.mp3";
        break;
      case buttons.BLUE:
        sound += "sound3.mp3";
        break;
      case buttons.YELLOW:
        sound += "sound4.mp3";
        break;
    }
    player.play(sound);
    sound = "";

  }

}


