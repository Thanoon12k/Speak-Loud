import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FlutterSpeechController extends GetxController {
  late bool _hasSpeech;
  bool get hasSpeech => _hasSpeech;
  late bool _logEvents;
  bool get logEvents => _logEvents;
  late bool _onDevice;
  bool get onDevice => _onDevice;
  late TextEditingController _pauseForController;
  TextEditingController get pauseForController => _pauseForController;
  late TextEditingController _listenForController;
  TextEditingController get listenForController => _listenForController;
  late double level;
  late double minSoundLevel;
  late double maxSoundLevel;
  late String lastWords;
  late String lastError;
  late String lastStatus;
  late String _currentLocaleId;
  late List<LocaleName> _localeNames;
  final SpeechToText speech = SpeechToText();

  @override
  void onInit() async {
    super.onInit();
    _hasSpeech = false;
    _logEvents = false;
    _onDevice = false;
    _pauseForController = TextEditingController(text: '3');
    _listenForController = TextEditingController(text: '30');
    level = 0.0;
    minSoundLevel = 50000;
    maxSoundLevel = -50000;
    lastWords = '';
    lastError = '';
    lastStatus = '';
    _currentLocaleId = '';
    _localeNames = [];

    await initSpeechState();
  }

  /// This initializes SpeechToText. That only has to be done
  /// once per application, though calling it again is harmless
  /// it also does nothing. The UX of the sample app ensures that
  /// it can only be called once.
  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (hasSpeech) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      if (!this.isClosed) {
        _hasSpeech = hasSpeech;
        update();
      }
    } catch (e) {
      if (!this.isClosed) {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
        update();
      }
    }
  }

  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    final pauseFor = int.tryParse(_pauseForController.text);
    final listenFor = int.tryParse(_listenForController.text);
    // Note that `listenFor` is the maximum, not the minimun, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 30),
      pauseFor: Duration(seconds: pauseFor ?? 3),
      partialResults: true,
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
      onDevice: _onDevice,
    );
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    level = 0.0;
    update();
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    level = 0.0;
    update();
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    lastWords = '${result.recognizedWords} - ${result.finalResult}';
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    this.level = level;
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    lastError = '${error.errorMsg} - ${error.permanent}';
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    lastStatus = '$status';
  }

  void _switchLang(selectedVal) {
    _currentLocaleId = selectedVal;
    print(selectedVal);
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  void _switchLogging(bool? val) {
    _logEvents = val ?? false;
  }

  void _switchOnDevice(bool? val) {
    _onDevice = val ?? false;
  }
}
