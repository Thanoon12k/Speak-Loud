import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeachToTextController extends GetxController {
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
 bool is_available=false;
 late stt.SpeechToText speech;

  Future<void> init_stt() async {
    speech = stt.SpeechToText();
    bool is_available = await speech.initialize(
      onStatus: (s) => debugPrint("status : $s"),
      onError: (e) => debugPrint("status : $e"),
    );
  }

void listen(){
 if (is_available) {
       speech.listen(onResult: resultListener);
    } else {
      print('error occured i am unavailible');
    }
    speech.stop();
  }

  void resultListener(SpeechRecognitionResult result) {
    lastWords = "${result.recognizedWords} - ${result.finalResult}";

    debugPrint("last: $lastWords "); //print the user's speech on the console
  }
}
