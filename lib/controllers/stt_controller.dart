import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeachToTextController extends GetxController {
  var is_listeninig = false.obs;
  var txttospeaking = "press to speak".obs;
  final SpeechToText _speech = SpeechToText();

  Future<void> listen() async {
    debugPrint("iam in listeennig${is_listeninig.value}");
    if (!is_listeninig.value) {
      bool available = await _speech.initialize(
        onStatus: (val) {},
        onError: (val) {},
      );

      if (available) {
        is_listeninig.value = true;
        _speech.listen(onResult: (val) {
          txttospeaking.value = val.recognizedWords;
        });
      }
    } else {
      is_listeninig.value = false;
      _speech.stop();
      txttospeaking.value = "";
    }
  }
}
